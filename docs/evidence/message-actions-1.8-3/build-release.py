#!/usr/bin/env python3
"""Build 1.8-3 from committed source without touching existing build artifacts."""
from datetime import datetime, timezone
from pathlib import Path
import hashlib
import json
import subprocess
import tempfile

root = Path(__file__).resolve().parents[3]
evidence = Path(__file__).resolve().parent
main_checkout = Path('/Users/zhangshichao/Documents/Workspace/WeChatImprove')

def command(args, cwd=root):
    return subprocess.check_output(args, cwd=cwd, text=True).strip()

def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

def write_json(name, data):
    (evidence / name).write_text(json.dumps(data, indent=2) + '\n')

def now():
    return datetime.now(timezone.utc).isoformat()

def main_state():
    return {
        'head': command(['git', 'rev-parse', 'HEAD'], main_checkout),
        'status_sha256': hashlib.sha256(subprocess.check_output(
            ['git', 'status', '--porcelain=v1', '--untracked-files=normal'],
            cwd=main_checkout)).hexdigest(),
    }

assert command(['git', 'branch', '--show-current']) == 'codex/message-actions-refactor-1.7-17'
assert not command(['git', 'diff', 'HEAD', '--', 'Controllers', 'Hooks', 'Headers', 'Tests', 'Makefile', 'control', 'WeChatImprove.plist', 'layout'])
assert not (root / 'packages/com.wechat.improve_1.8-3_iphoneos-arm64.deb').exists()
source = command(['git', 'rev-parse', 'HEAD'])
prior = {p.name: digest(p) for p in sorted((root / 'packages').glob('*.deb'))}
protected = {name: digest(root / name) for name in command(['git', 'ls-files', '.theos']).splitlines()}
assert len(protected) == 777
write_json('prior-packages.json', prior)
write_json('protected-build-files.json', protected)
before_main = main_state()
fresh = Path(tempfile.mkdtemp(prefix='wechat-message-actions-1.8-3.'))
args = ['make', 'package', 'SCHEME=rootless', 'THEOS=/Users/zhangshichao/theos',
        'THEOS_BUILD_DIR=' + str(fresh / 'build'),
        '_THEOS_LOCAL_DATA_DIR=' + str(fresh / '.theos'),
        'THEOS_PACKAGE_DIR=' + str(root / 'packages'), '-j4', 'COLOR=0']
provenance = {
    'source_commit': source,
    'source_baseline': '2c343db2f21ec04267d7390c578871ff6b080e9b',
    'branch': command(['git', 'branch', '--show-current']),
    'worktree': str(root), 'started_utc': now(),
    'fresh_build_directory': str(fresh),
    'fresh_build_directory_initial_entries': [p.name for p in fresh.iterdir()],
    'theos': '/Users/zhangshichao/theos',
    'sdk': command(['xcrun', '--sdk', 'iphoneos', '--show-sdk-path']),
    'clang': command(['xcrun', 'clang', '--version']),
    'minimum_ios': '15.0', 'command': args,
    'original_theos_file_count': len(protected),
    'main_checkout_before_build': before_main,
    'host_log_sha256': {str(p.relative_to(evidence)): digest(p) for p in sorted((evidence / 'host').glob('*.log'))},
}
write_json('build-provenance.json', provenance)
print('Building source ' + source + ' in ' + str(fresh), flush=True)
with (evidence / 'rootless-build.log').open('w') as log:
    result = subprocess.run(args, cwd=root, stdout=log, stderr=subprocess.STDOUT)
provenance.update({
    'finished_utc': now(), 'exit_status': result.returncode,
    'original_theos_unchanged': all(digest(root / name) == value for name, value in protected.items()),
    'prior_packages_unchanged': all(digest(root / 'packages' / name) == value for name, value in prior.items()),
    'main_checkout_after_build': main_state(),
})
provenance['main_checkout_status_unchanged'] = provenance['main_checkout_after_build'] == before_main
write_json('build-provenance.json', provenance)
assert provenance['original_theos_unchanged'] and provenance['prior_packages_unchanged']
assert provenance['main_checkout_status_unchanged']
assert result.returncode == 0, 'See rootless-build.log'
print('PASS: fresh Rootless build; old packages, tracked .theos files and main checkout status preserved')
