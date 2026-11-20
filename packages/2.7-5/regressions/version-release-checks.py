from pathlib import Path
import contextlib
import hashlib
import io
import json
import re
import subprocess
import sys
import tempfile
import traceback

ROOT = Path('/Users/zhangshichao/Documents/Workspace/WeChatImprove')
VERSION = '2.7-5'
BEFORE = Path('/tmp/wechat-2.7-5-metadata-before')
OUTPUT = Path('/tmp/wechat-2.7-5-release-content-checks')
FORBIDDEN = ['密友', '密群', 'CloseFriend', 'close_friend', 'close-friend', '捉迷藏',
             '长按', '五击', '五连击', '连续五', '2 秒', '密码', '生物识别', '摇动锁定']
CHECKS = 0


def check(condition, label):
    global CHECKS
    CHECKS += 1
    if not condition:
        raise AssertionError(label)
    print('PASS ' + label)


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def unrestricted(value):
    return not any(term.casefold() in value.casefold() for term in FORBIDDEN)


def check_runtime(function, macro):
    forbidden_literals = ','.join('@' + json.dumps(term, ensure_ascii=False) for term in FORBIDDEN)
    prelude = '#import <Foundation/Foundation.h>\n#define kPluginVersionString ' + macro + '\n'
    harness = r'''
static NSUInteger checks=0;
static void Check(BOOL value, NSString *message) {
    checks++;
    if (!value) { fprintf(stderr,"FAIL %s\n",message.UTF8String); exit(1); }
}
int main(void) { @autoreleasepool {
    Check([kPluginVersionString isEqual:@"REQUESTED_VERSION"],@"actual requested version macro");
    NSArray *notes=CSCurrentReleaseNotes();
    Check([notes isKindOfClass:NSArray.class],@"real production method returns an array");
    Check(notes.count==4,@"four current public release notes");
    NSSet *expected=[NSSet setWithArray:@[@"title",@"detail"]];
    NSArray *forbidden=@[FORBIDDEN_LITERALS];
    NSMutableSet *titles=[NSMutableSet set];
    for (id item in notes) {
        Check([item isKindOfClass:NSDictionary.class],@"public note dictionary");
        NSDictionary *note=item;
        Check([[NSSet setWithArray:note.allKeys] isEqual:expected],@"public note exact schema");
        for (NSString *key in @[@"title",@"detail"]) {
            NSString *value=note[key];
            Check([value isKindOfClass:NSString.class],@"note field string");
            Check([value stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet].length>0,@"note field nonempty");
            BOOL permitted=YES;
            for (NSString *term in forbidden) {
                if ([value rangeOfString:term options:NSCaseInsensitiveSearch].location!=NSNotFound) permitted=NO;
            }
            Check(permitted,@"public field excludes restricted feature descriptions");
        }
        [titles addObject:note[@"title"]];
    }
    Check(titles.count==notes.count,@"current note titles are unique");
    NSDictionary *payload=@{@"version":kPluginVersionString,@"notes":notes};
    Check([NSJSONSerialization dataWithJSONObject:payload options:0 error:NULL]!=nil,@"production notes serialize");
    NSDictionary *result=@{@"version":kPluginVersionString,@"checks":@(checks),@"notes":notes};
    NSData *data=[NSJSONSerialization dataWithJSONObject:result options:NSJSONWritingPrettyPrinted error:NULL];
    puts([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding].UTF8String);
    fprintf(stderr,"Runtime release notes: %lu checks passed\n",(unsigned long)checks);
} }
'''.replace('REQUESTED_VERSION', VERSION).replace('FORBIDDEN_LITERALS', forbidden_literals)
    with tempfile.TemporaryDirectory(prefix='wechat-' + VERSION + '-release-notes-', dir='/tmp') as temp:
        folder = Path(temp)
        objective = folder / 'ReleaseNotesChecks.m'
        binary = folder / 'ReleaseNotesChecks'
        objective.write_text(prelude + function + harness)
        compilation = subprocess.run(['xcrun', '--sdk', 'macosx', 'clang', '-x', 'objective-c',
                                      '-fobjc-arc', '-Wall', '-Wextra', '-Werror', '-framework',
                                      'Foundation', str(objective), '-o', str(binary)],
                                     capture_output=True, text=True, cwd=ROOT)
        if compilation.stdout:
            print(compilation.stdout)
        if compilation.stderr:
            print(compilation.stderr)
        check(compilation.returncode == 0, 'Foundation compilation of real production release method')
        runtime = subprocess.run([str(binary)], capture_output=True, text=True, cwd=ROOT)
        if runtime.stderr:
            print(runtime.stderr.strip())
        check(runtime.returncode == 0, 'Foundation execution of real production release method')
        return json.loads(runtime.stdout)


def run_release_checks():
    paths = ['control', 'Headers/CSUserInfoHelper.h', 'Controllers/CSReleaseNotesViewController.m', 'README.md']
    check(all((BEFORE / name).is_file() for name in paths), 'four original metadata byte baselines exist')
    source = (ROOT / paths[2]).read_text()
    header = (ROOT / paths[1]).read_text()
    macro = re.search(r'^#define\s+kPluginVersionString\s+(@"[^"]+")', header, re.M)
    check(macro is not None, 'current version macro exists')
    check(macro.group(1) == '@"' + VERSION + '"', 'plugin macro equals requested final version')
    control = (ROOT / 'control').read_text()
    check(re.search(r'^Version:\s*' + re.escape(VERSION) + r'\s*$', control, re.M) is not None,
          'package control equals requested final version')
    for name in paths[:2]:
        original = (BEFORE / name).read_bytes()
        old_version = re.search(rb'^Version:\s*(\S+)', original, re.M).group(1) if name == 'control' else re.search(rb'^#define\s+kPluginVersionString\s+@"([^"]+)"', original, re.M).group(1)
        check((ROOT / name).read_bytes() == original.replace(old_version, VERSION.encode()),
              name + ' changed only the version value')

    source_bytes = (ROOT / paths[2]).read_bytes()
    original_bytes = (BEFORE / paths[2]).read_bytes()
    current_marker = ('        @"' + VERSION + '": @[\n').encode()
    check(source_bytes.count(current_marker) == 1, 'one release entry for final version')
    insertion = source_bytes.index(current_marker)
    first_original = re.search(rb'^        @"[^"]+": @\[\n', original_bytes, re.M).group(0)
    end = source_bytes.index(first_original, insertion)
    check(source_bytes[:insertion] + source_bytes[end:] == original_bytes,
          'all historical release source bytes preserved after stripping new entry')
    start = source.index('static NSArray<NSDictionary<NSString *, NSString *> *> *CSCurrentReleaseNotes(void) {')
    finish = source.index('\n@interface ', start)
    function = source[start:finish]
    check('return releases[kPluginVersionString]' in function, 'production method dispatches by installed version')
    runtime = check_runtime(function, macro.group(1))
    check(runtime['version'] == VERSION, 'runtime returned final version')
    check(len(runtime['notes']) == 4, 'runtime returned exactly four current notes')
    check('#05944A' in ''.join(n['detail'] for n in runtime['notes']), 'runtime current notes state the approved default green')

    readme_bytes = (ROOT / 'README.md').read_bytes()
    old_readme_bytes = (BEFORE / 'README.md').read_bytes()
    new_parts = readme_bytes.split(b'\n\n')
    old_parts = old_readme_bytes.split(b'\n\n')
    check(len(new_parts) == len(old_parts), 'root README paragraph structure preserved')
    changed = [i for i, (old, new) in enumerate(zip(old_parts, new_parts)) if old != new]
    check(changed == [2, 8, 9], 'only current version, publication paragraph and download table changed')
    prior_version = re.search(rb'\*\*\xe6\xba\x90\xe7\xa0\x81\xe7\x89\x88\xe6\x9c\xac\xef\xbc\x9a`([^`]+)`', old_parts[2]).group(1)
    check(new_parts[2] == old_parts[2].replace(prior_version, VERSION.encode()), 'README source-version line synchronized')
    check(new_parts[9] == old_parts[9].replace(prior_version, VERSION.encode()), 'README current download table changed version only')
    check(all(old == new for i, (old, new) in enumerate(zip(old_parts, new_parts)) if i not in {2, 8, 9}),
          'all other root README bytes including historical content preserved')
    publication = new_parts[8].decode()
    check(publication.startswith('当前发布版本为正式完整版 `' + VERSION + '`。'), 'current publication identifies final full release')
    check(unrestricted(publication), 'current publication excludes restricted feature descriptions')
    check('#05944A' in publication, 'current publication states approved default green')
    expected_names = [f'com.wechat.improve_{VERSION}_iphoneos-arm64.deb',
                      f'com.wechat.improve_{VERSION}_iphoneos-arm.deb',
                      'WeChatImprove.dylib', 'SHA256SUMS', 'symbols.zip', 'README.md']
    expected_paths = [f'packages/{VERSION}/{name}' for name in expected_names]
    check(re.findall(r'\]\(([^)]+)\)', new_parts[9].decode()) == expected_paths,
          'all six root download links point to current release files')

    package_readme_path = ROOT / 'packages' / VERSION / 'README.md'
    check(package_readme_path.is_file(), 'new package README exists')
    package_readme = package_readme_path.read_text()
    check(package_readme.startswith('# WeChatImprove ' + VERSION + '\n'), 'package README title matches final version')
    check('正式完整版' in package_readme, 'package README identifies final full release')
    check('包版本、插件内版本和当前更新说明统一为 `' + VERSION + '`。' in package_readme,
          'package README states synchronized current version')
    check(unrestricted(package_readme), 'entire new package README excludes restricted feature descriptions')
    check('#05944A' in package_readme, 'package README states approved default green')
    links = re.findall(r'\]\(([^)]+)\)', package_readme)
    for name in expected_names:
        if name == 'README.md':
            continue
        check(name in links, 'package README links ' + name)
    for index, note in enumerate(runtime['notes'], 1):
        check(note['title'] in package_readme and note['detail'] in package_readme,
              'package README exactly reproduces production public note ' + str(index))
    check('未安装或重启原设备微信' in package_readme, 'package README states actual device-verification limit')
    counts = {'checks': CHECKS + runtime['checks'], 'document_version_history_checks': CHECKS,
              'runtime_foundation_checks': runtime['checks']}
    print(json.dumps(runtime, ensure_ascii=False, indent=2))
    print('Release content: ' + str(counts['checks']) + ' effective checks passed')
    return dict(result='passed', **counts, version=VERSION, notes=runtime['notes'])


if __name__ == '__main__':
    output = io.StringIO()
    exit_code = 0
    try:
        with contextlib.redirect_stdout(output):
            result = run_release_checks()
    except Exception as error:
        exit_code = 1
        output.write(traceback.format_exc())
        result = {'result': 'failed', 'version': VERSION, 'error': str(error),
                  'document_version_history_checks_attempted': CHECKS}
    result['script_sha256'] = sha(Path(__file__))
    OUTPUT.mkdir(exist_ok=True)
    (OUTPUT / 'release-content-checks.log').write_text(output.getvalue())
    (OUTPUT / 'release-content-checks.json').write_text(json.dumps(result, ensure_ascii=False, indent=2) + '\n')
    sys.stdout.write(output.getvalue())
    print('RESULT_JSON ' + json.dumps(result, ensure_ascii=False))
    sys.exit(exit_code)
