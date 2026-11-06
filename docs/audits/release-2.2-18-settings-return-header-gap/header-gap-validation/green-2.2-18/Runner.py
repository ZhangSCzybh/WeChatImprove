#!/usr/bin/env python3
"""Run verbatim production parent lifecycle against an explicit estimate boundary model.

The host model is a deterministic regression boundary, not an iOS UIKit runtime.
It does not infer UIKit's private default estimate or any phone pixel delta.
"""
import argparse
import hashlib
import json
import os
from pathlib import Path
import re
import subprocess

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
AUDIT = HERE.parent
BASELINE = AUDIT / 'baseline-2.2-17'


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def method(text, prefix):
    start = text.index(prefix)
    opened = text.index('{', start)
    level = 1
    i = opened + 1
    # Production bodies contain no braces inside literals in these methods.
    while level:
        if text[i] == '{': level += 1
        elif text[i] == '}': level -= 1
        i += 1
    return text[start:i]


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--source', type=Path, default=ROOT)
    parser.add_argument('--label', default='current')
    parser.add_argument('--expect-red', action='store_true')
    args = parser.parse_args()
    source = args.source.resolve()
    output = HERE / args.label
    output.mkdir(exist_ok=False)
    custom_path = source / 'Controllers/CSCustomViewController.m'
    before_hash = digest(custom_path)
    custom = custom_path.read_text()
    (output / 'ProductionSource.m').write_bytes(custom_path.read_bytes())
    (output / 'Fixture.m').write_bytes((HERE / 'HeaderGapLifecycleTests.m').read_bytes())
    (output / 'Runner.py').write_bytes(Path(__file__).read_bytes())
    prefixes = ['- (void)setupUI', '- (void)viewWillAppear:', '- (void)viewDidAppear:',
                '- (void)viewWillDisappear:']
    extracted = '\n\n'.join(method(custom, prefix) for prefix in prefixes)
    (output / 'ProductionMethods.h').write_text(extracted + '\n')
    routes = re.findall(r'else if \(\[item.title isEqualToString:@"([^"]+)"\]\) \{\s*(CS\w+) \*\w+ = \[\[(CS\w+) alloc\]', custom)
    required = ['顶栏信息', '头像设置', '触摸轨迹', '界面简化', '界面净化', '气泡样式', '列表圆角', '底栏样式', '布局设置', '附件布局']
    found = {title: allocated for title, _, allocated in routes}
    # Route naming comes directly from the actual menu, not assumed labels.
    aliases = {'列表圆角': '列表圆角', '附件布局': '附件布局'}
    selected = []
    for title in required:
        matching = [(t, c) for t, c in found.items() if title in t or aliases.get(title) == t]
        if not matching:
            raise AssertionError((title, sorted(found)))
        selected.append({'title': matching[0][0], 'class': matching[0][1]})
    selected += [{'title': '密友设置/普通入口', 'class': 'CSCloseFriendSettingsViewController'},
                 {'title': '密友设置/五击快捷入口', 'class': 'CSCloseFriendSettingsViewController'}]
    assert '[CSCloseFriendManager.sharedManager presentSettingsFrom:self]' in custom
    assert 'quickEntry' in custom and 'CSCloseFriendSettingsViewController' in custom
    (output / 'Routes.h').write_text('static NSArray<NSString *> *Routes(void) { return @[' + ','.join('@"' + row['title'] + '"' for row in selected) + ']; }\n')
    command = ['xcrun', '--sdk', 'macosx', 'clang', '-fobjc-arc', '-fblocks', '-Wall', '-Wextra', '-Werror',
               '-framework', 'Foundation', '-framework', 'CoreGraphics', '-I' + str(output),
               str(HERE / 'HeaderGapLifecycleTests.m'), '-o', str(output / 'header-gap-tests')]
    built = subprocess.run(command, text=True, capture_output=True)
    (output / 'compile.log').write_text(built.stdout + built.stderr)
    if built.returncode:
        raise SystemExit(built.stdout + built.stderr)
    environment = dict(os.environ, HEADER_GAP_TRACE_PATH=str(output / 'geometry-trace.json'))
    ran = subprocess.run([str(output / 'header-gap-tests')], text=True, capture_output=True, env=environment)
    (output / 'run.log').write_text(ran.stdout + ran.stderr)
    report = {
        'source_root': str(source), 'label': args.label, 'exit_code': ran.returncode,
        'source_sha256': {str(custom_path.relative_to(source)): digest(custom_path)},
        'source_unchanged_during_test': before_hash == digest(custom_path),
        'baseline_source_sha256': digest(BASELINE / 'Controllers/CSCustomViewController.m'),
        'test_sha256': digest(HERE / 'HeaderGapLifecycleTests.m'), 'runner_sha256': digest(Path(__file__)),
        'extracted_methods_sha256': digest(output / 'ProductionMethods.h'),
        'compile_command': command, 'routes': selected,
        'route_limit': 'Shared parent setup/lifecycle is executed under each menu route label. Child controllers and UIKit navigation are not executed by this host fixture.',
        'limits': 'Objective-C production methods execute in a host double. Actual heights and estimate errors in both directions are independent adversarial inputs; no values are fitted to video pixels. iOS runtime, phone rendering, animation and actual default section-header measurement are not exercised.'
    }
    (output / 'provenance.json').write_text(json.dumps(report, ensure_ascii=False, indent=2) + '\n')
    print(ran.stdout + ran.stderr, end='')
    print('PROVENANCE', output / 'provenance.json')
    accepted = (ran.returncode != 0 if args.expect_red else ran.returncode == 0) and before_hash == digest(custom_path)
    raise SystemExit(0 if accepted else 1)


if __name__ == '__main__':
    main()
