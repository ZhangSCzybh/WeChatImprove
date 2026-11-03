#!/usr/bin/env python3
"""Execute extracted production UI methods against deterministic host UI objects.

This checks mutation/measurement contracts, not real UIKit rendering or device CPU.
The iOS SDK syntax check and package build separately validate real UIKit APIs.
"""
import argparse
import hashlib
import json
import pathlib
import subprocess

HERE = pathlib.Path(__file__).resolve().parent
ROOT = HERE.parents[3]
DEFAULT_SOURCE = ROOT / 'Controllers/WESessionTabContainerView.m'


def method(text, declaration, start=0):
    begin = text.index(declaration, start)
    opening = text.index('{', begin)
    depth = 1
    index = opening + 1
    while depth:
        if text[index] == '{':
            depth += 1
        elif text[index] == '}':
            depth -= 1
        index += 1
    return text[begin:index]


def generate(source):
    text = source.read_text()
    button_start = text.index('@implementation WETabButton')
    container_start = text.index('@implementation WESessionTabContainerView')
    button_methods = [
        '- (void)updateFonts', '- (CGSize)tabTitleSize', '- (CGFloat)badgeWidth',
        '- (CGRect)tabTitleFrame', '- (void)layoutSubviews',
        '- (void)configureCapsuleEnabled:', '- (void)setCapsuleProgress:',
        '- (void)updateUnreadCount:',
    ]
    container_methods = [
        '- (void)applyAppearanceWithFontSize:', '- (void)traitCollectionDidChange:',
        '- (void)layoutSubviews', '- (CGFloat)widthForTabButton:',
        '- (void)layoutTabButtons', '- (void)updateUnreadCount:',
        '- (void)updateTabs:', '- (NSInteger)indexForTabID:',
        '- (void)updateSelectedButtons', '- (void)selectTabAtIndex:',
        '- (void)updateIndicatorPosition', '- (void)updateIndicatorPositionAnimated:',
        '- (void)updateCapsuleSelectionAnimated:', '- (CGRect)indicatorFrameForIndex:',
        '- (void)updateInteractiveTransitionToIndex:', '- (void)cancelInteractiveTransition',
        '- (void)moveIndicatorToFrame:', '- (void)scrollToSelectedTab',
    ]
    constants = text[text.index('static CGFloat const kTabContainerHeight'):text.index('// Match the native outlined magnifier')]
    button_interface = text[text.index('@interface WETabButton'):button_start]
    extension = text[text.index('@interface WESessionTabContainerView ()'):container_start]
    # The public properties normally come from the production header.
    extension = extension.replace('@interface WESessionTabContainerView ()', '@interface WESessionTabContainerView : UIView\n'
        '@property(nonatomic) NSInteger selectedIndex;\n'
        '@property(nonatomic,copy) NSString *selectedTabID;\n'
        '@property(nonatomic,copy) void (^onTabSelected)(NSInteger);\n'
        '@property(nonatomic,copy) void (^onSearchButtonTapped)(void);\n')
    pieces = [(HERE / 'ui-fixture-prefix.h').read_text(), constants, button_interface, extension,
        '@implementation WETabButton',
        '- (instancetype)init { if ((self=[super init])) { self.unreadBadge=[UILabel new]; self.unreadBadge.hidden=YES; self.baseFontSize=15; [self updateFonts]; } return self; }']
    for declaration in button_methods:
        # Legacy source has no title measurement cache. Keep the one helper needed
        # by the driver while all existing legacy methods remain unchanged.
        if declaration == '- (CGSize)tabTitleSize' and declaration not in text:
            pieces.append('- (CGSize)tabTitleSize { return [self.currentTitle sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}]; }')
        else:
            pieces.append(method(text, declaration, button_start))
    pieces += ['@end', '@implementation WESessionTabContainerView',
        '- (void)refreshAppearance {}', '- (void)triggerHapticFeedback {}']
    pieces += [method(text, declaration, container_start) for declaration in container_methods]
    pieces += ['@end', (HERE / 'ui-fixture-tests.m').read_text()]
    return '\n\n'.join(pieces)


def main():
    p = argparse.ArgumentParser()
    p.add_argument('--source', type=pathlib.Path, default=DEFAULT_SOURCE)
    p.add_argument('--label', default='current')
    args = p.parse_args()
    generated = HERE / (args.label + '-extracted.m')
    generated.write_text(generate(args.source))
    executable = HERE / (args.label + '-fixture')
    command = ['xcrun', 'clang', '-fobjc-arc', '-fblocks', '-Wno-objc-method-access',
        '-Wno-incompatible-pointer-types', '-framework', 'Foundation', '-framework',
        'QuartzCore', '-framework', 'CoreGraphics', str(generated), '-o', str(executable)]
    build = subprocess.run(command, text=True, capture_output=True)
    (HERE / (args.label + '-compile.log')).write_text(build.stdout + build.stderr)
    if build.returncode:
        raise SystemExit(build.stderr)
    run = subprocess.run([str(executable)], text=True, capture_output=True)
    (HERE / (args.label + '-run.log')).write_text(run.stdout + run.stderr)
    result = {'source': str(args.source.resolve()), 'sha256': hashlib.sha256(args.source.read_bytes()).hexdigest(),
        'extracted_fixture': str(generated), 'exit_code': run.returncode,
        'method_body_source': 'unmodified production method bodies; deterministic host UI objects',
        'scope': 'geometry, invalidation, measurement and animation lifecycle contracts; no real UIKit rendering or device CPU',
        'output': run.stdout.strip(), 'stderr': run.stderr.strip()}
    (HERE / (args.label + '-result.json')).write_text(json.dumps(result, ensure_ascii=False, indent=2) + '\n')
    print(json.dumps(result, ensure_ascii=False, indent=2))
    raise SystemExit(run.returncode)


if __name__ == '__main__':
    main()
