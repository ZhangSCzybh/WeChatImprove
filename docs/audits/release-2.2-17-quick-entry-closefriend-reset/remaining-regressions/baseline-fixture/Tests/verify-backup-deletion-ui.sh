#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
# Compile the real UI method bodies against in-memory Foundation doubles. No
# backup engine, real backup files, defaults or UIKit is loaded. The manager's
# real remove method connects the controller to a recording Store double.
python3 - <<'PY'
from pathlib import Path
import re
import subprocess
import tempfile

source = Path('Controllers/CSBackupSettingsViewController.m').read_text()
source = source.split('@implementation CSBackupSettingsViewController', 1)[1]
methods = []
for name in ('openRecord:', 'showUnavailableRecord:', 'showRecord:', 'deleteRecord:', 'retryRestore'):
    match = re.search(r'^- \([^)]+\)' + re.escape(name), source, re.M)
    if not match:
        raise SystemExit('Missing production selector: ' + name)
    start = match.start()
    opening = source.index('{', start)
    # Stop at the next method boundary; braces in Objective-C strings do not
    # affect extraction. Each selector must have its own complete body.
    next_method = re.search(r'^[-+] \(', source[opening + 1:], re.M)
    end = opening + 1 + next_method.start() if next_method else source.index('\n@end', opening)
    methods.append(source[start:end].rstrip())

for path in ('CSBackupSettingsViewController.m', 'CSBackupPreviewViewController.m', 'CSResetSettingsViewController.m'):
    ui = Path('Controllers', path).read_text()
    for removed_api in ('isAutoBackupEnabled', 'enableAutoBackup:', 'cleanupStatus', 'retryStartup'):
        assert removed_api not in ui, (path, removed_api)
    for removed_promise in ('先保存恢复前保护备份', '作为保护备份', '默认保留 20 份', '保留不自动清理'):
        assert removed_promise not in ui, (path, removed_promise)

manager_source = Path('Controllers/CSBackupManager.m').read_text()
start = manager_source.index('- (void)remove:(NSDictionary *)record completion:')
next_method = re.search(r'^[-+] \(', manager_source[start + 1:], re.M)
end = start + 1 + next_method.start() if next_method else manager_source.index('\n@end', start)
manager_method = manager_source[start:end].rstrip()

with tempfile.TemporaryDirectory(prefix='wechat-backup-deletion-ui-') as directory:
    work = Path(directory)
    (work / 'BackupDeletionUIUnderTest.h').write_text('\n'.join(methods) + '\n')
    (work / 'BackupDeletionManagerUnderTest.h').write_text(manager_method + '\n')
    executable = work / 'tests'
    subprocess.run([
        'xcrun', '--sdk', 'macosx', 'clang', '-fobjc-arc', '-fblocks',
        '-Wall', '-Wextra', '-Werror', '-I' + str(work),
        '-framework', 'Foundation', 'Tests/BackupDeletionUITests.m',
        '-o', str(executable),
    ], check=True)
    subprocess.run([str(executable)], check=True)
PY
