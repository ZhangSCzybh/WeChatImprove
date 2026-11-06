#!/usr/bin/env python3
"""Compile production adapters against iOS and run isolated host behavior checks."""
import json
from pathlib import Path
import subprocess
import tempfile

audit = Path(__file__).resolve().parent
project = Path('/Users/zhangshichao/Documents/Workspace/WeChatImprove')
results = []


def run(name, command):
    completed = subprocess.run(command, cwd=project, text=True, capture_output=True)
    (audit / (name + '.log')).write_text(completed.stdout + completed.stderr)
    results.append({'name': name, 'command': command, 'exit_code': completed.returncode})
    if completed.returncode:
        raise RuntimeError(f'{name} failed; inspect {audit / (name + ".log")}')


try:
    with tempfile.TemporaryDirectory(prefix='runtime-', dir=audit) as directory:
        temporary = Path(directory)
        for architecture in ['arm64', 'arm64e']:
            run('ios-' + architecture, ['xcrun', '--sdk', 'iphoneos', 'clang', '-target', architecture + '-apple-ios15.0',
                '-fobjc-arc', '-fblocks', '-fsyntax-only', '-Wall', '-Wextra', '-Werror', '-Wno-unused-parameter',
                '-I' + str(project / 'Headers'), '-I' + str(project / 'Controllers'),
                str(project / 'Controllers/CSTabBarNativeAdapter.m')])
        run('geometry-build', ['xcrun', 'clang', '-Wall', '-Wextra', '-Werror', '-I' + str(project / 'Headers'),
            str(audit / 'TabBarGeometryTests.c'), '-o', str(temporary / 'geometry')])
        run('geometry', [str(temporary / 'geometry')])
        run('native-build', ['xcrun', '--sdk', 'macosx', 'clang', '-fobjc-arc', '-fblocks', '-Wall', '-Wextra',
            '-Werror', '-Wno-unused-parameter', '-Wno-unused-const-variable', '-Wno-incompatible-pointer-types',
            '-framework', 'Foundation', '-framework', 'QuartzCore', '-framework', 'CoreGraphics',
            '-I' + str(audit / 'TabBarUIKit'), '-I' + str(project / 'Headers'), '-I' + str(project / 'Controllers'),
            str(audit / 'TabBarUIKit/TabBarUIKit.m'), str(project / 'Controllers/CSTabBarPreferences.m'),
            str(project / 'Controllers/CSTabBarNativeAdapter.m'), str(audit / 'TabBarNativeTests.m'),
            '-o', str(temporary / 'native')])
        run('native', [str(temporary / 'native'), str(temporary / 'icon.png')])
finally:
    (audit / 'validation-result.json').write_text(json.dumps(results, ensure_ascii=False, indent=2) + '\n')

print('PASS: iOS arm64/arm64e adapter compilation, geometry, legacy and 8.0.80 native behavior')
