#!/usr/bin/env python3
"""Run original entry assertion bytes with additive declarations for the new tap.

The original first assertion requires one avatar recognizer. Current production
correctly installs two, so this is an expected, retained behavior incompatibility,
never a green regression. No fixture filters the tap out of the gesture array.
"""
import difflib
import hashlib
import json
from pathlib import Path
import re
import subprocess
import tempfile

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
OUTPUT = HERE / "entry-compatibility"
FIXTURE = HERE / "fixture-project/Tests/CloseFriendEntryGestureTests.m"


def method(source, name):
    start = re.search(r"^- \([^)]+\)" + re.escape(name) + r"(?=[ :(])", source, re.M).start()
    opening = source.index("{", start)
    depth, end = 1, opening + 1
    while depth:
        depth += (source[end] == "{") - (source[end] == "}")
        end += 1
    return source[start:end]


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    OUTPUT.mkdir(exist_ok=True)
    original = FIXTURE.read_text()
    augmented = original.replace('#import <Foundation/Foundation.h>',
        '#import <Foundation/Foundation.h>\n#import "CSCloseFriendRuntime.h"\n#import <stdatomic.h>\n'
        'static atomic_uint_fast64_t CSBackupAccountBoundary=2;\n'
        'NSUInteger CSBackupAccountEpoch(void){return (NSUInteger)(atomic_load_explicit(&CSBackupAccountBoundary,memory_order_acquire)>>1);}\n'
        'BOOL CSBackupAccountIsSuspended(void){return (atomic_load_explicit(&CSBackupAccountBoundary,memory_order_acquire)&1)!=0;}\n'
        'NSUInteger CSCloseFriendAccountEpoch(void){return CSBackupAccountEpoch();}')
    tap = '''@interface UITapGestureRecognizer : UIGestureRecognizer
@property(nonatomic) NSUInteger numberOfTapsRequired,numberOfTouchesRequired;
@property(nonatomic) BOOL cancelsTouchesInView;
@property(nonatomic,weak) id delegate;
@property(nonatomic,strong) UIGestureRecognizer *requiredToFail;
- (instancetype)initWithTarget:(id)target action:(SEL)action;
- (void)requireGestureRecognizerToFail:(UIGestureRecognizer *)gesture;
@end
@implementation UITapGestureRecognizer
- (instancetype)initWithTarget:(id)target action:(SEL)action{return [super init];}
- (void)requireGestureRecognizerToFail:(UIGestureRecognizer *)gesture{self.requiredToFail=gesture;}
@end
'''
    augmented = augmented.replace('@interface UITouch : NSObject', tap + '@interface UITouch : NSObject')
    augmented = augmented.replace('@interface EntryController : UIViewController', '''@interface CSCloseFriendManager (NewDeclarations)
@property(nonatomic,readonly) CSCloseFriendRuntime *runtime;
- (void)refreshAccount;
@end
@interface EntryController : UIViewController
@property(nonatomic,strong) UITapGestureRecognizer *closeFriendQuickEntryGesture;
@property(nonatomic,copy) NSDictionary *closeFriendQuickEntryToken;
@property(nonatomic) NSUInteger closeFriendQuickEntryCount;
@property(nonatomic) NSTimeInterval closeFriendQuickEntryLastTap;''')
    augmented = augmented.replace('@implementation EntryController', '''@interface EntryController (NewDeclarations)
- (void)tapCloseFriendQuickEntry:(UITapGestureRecognizer *)gesture;
- (void)resetCloseFriendQuickEntry;
- (BOOL)closeFriendQuickEntryTokenIsCurrent:(NSDictionary *)token;
@end
@implementation EntryController''')
    # Validate that every original Check line remains byte-for-byte and ordered.
    assertions = [line for line in original.splitlines() if 'Check(' in line]
    assert assertions == [line for line in augmented.splitlines() if 'Check(' in line]
    (OUTPUT / "fixture-additions.diff").write_text(''.join(difflib.unified_diff(
        original.splitlines(True), augmented.splitlines(True), fromfile=str(FIXTURE), tofile="declarations-only-fixture.m")))
    input_file = OUTPUT / "fixture-with-additive-declarations.m"
    input_file.write_text(augmented)
    production = (ROOT / "Controllers/CSCustomViewController.m").read_text()
    names = ['installCloseFriendEntryGesture','canDiscoverCloseFriendEntry','gestureRecognizer:',
             'discoverCloseFriendEntry:','closeFriendEntryPolicyChanged:',
             'resetCloseFriendQuickEntry','closeFriendQuickEntryTokenIsCurrent:']
    (OUTPUT / "EntryGestureUnderTest.h").write_text('\n'.join(method(production, n) for n in names))
    with tempfile.TemporaryDirectory(prefix="wechat-2216-entry-compatibility-") as directory:
        executable = Path(directory) / "entry"
        sources = ['CSCloseFriendPolicy.m','CSCloseFriendCrypto.m','CSCloseFriendStore.m',
                   'CSPluginStorage.m','CSCloseFriendRuntime.m']
        command = ['xcrun','--sdk','macosx','clang','-fobjc-arc','-fblocks','-Wall','-Wextra','-Werror',
            '-Wno-unused-parameter','-Wno-deprecated-declarations','-I'+str(ROOT/'Controllers'),'-I'+str(OUTPUT),
            '-framework','Foundation','-framework','Security']
        command += [str(ROOT/'Controllers'/n) for n in sources] + [str(input_file),'-o',str(executable)]
        compiled = subprocess.run(command, text=True, capture_output=True)
        (OUTPUT / 'compile.log').write_text(compiled.stdout + compiled.stderr)
        run = subprocess.run([str(executable)], text=True, capture_output=True) if compiled.returncode == 0 else None
        text = run.stdout + run.stderr if run else ''
        (OUTPUT / 'run.log').write_text(text)
    accepted = compiled.returncode == 0 and run.returncode != 0 and text.strip() == 'FAIL: avatar receives exactly one recognizer'
    report = {'original_fixture_sha256':sha(FIXTURE), 'original_assertion_lines_preserved':True,
        'original_assertion_count':len(assertions), 'compiled_actual_production_sources':sources,
        'extracted_actual_production_methods':names, 'command':command,
        'compile_exit_code':compiled.returncode, 'run_exit_code':run.returncode if run else None,
        'expected_failure_observed':accepted, 'product_pass_claimed':False,
        'reason':'Original invariant requires exactly one avatar recognizer; requested feature adds one tap beside the existing long press. The fixture still records both. Execution stops at this original assertion; later assertions are not claimed executed.'}
    (OUTPUT / 'result.json').write_text(json.dumps(report, ensure_ascii=False, indent=2)+'\n')
    print('Expected original one-recognizer assertion:', 'OBSERVED' if accepted else 'NOT OBSERVED', text.strip())
    if not accepted:
        raise SystemExit(1)


if __name__ == '__main__':
    main()
