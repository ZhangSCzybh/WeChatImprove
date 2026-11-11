#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
python3 - <<'PY'
from pathlib import Path
import subprocess
import tempfile
with tempfile.TemporaryDirectory(prefix='backup-performance-') as directory:
    executable = str(Path(directory) / 'tests')
    subprocess.run([
        'xcrun', '--sdk', 'macosx', 'clang', '-fobjc-arc', '-fblocks',
        '-Wall', '-Wextra', '-Werror', '-Wno-deprecated-declarations', '-IControllers',
        '-framework', 'Foundation', '-framework', 'CoreFoundation',
        '-framework', 'ImageIO', '-framework', 'CoreGraphics',
        'Controllers/CSScheduledTaskStore.m', 'Controllers/CSAIReplyStore.m', 'Controllers/CSGroupChatStore.m', 'Controllers/CSGroupChatTemplate.m',
        'Controllers/CSBackupRegistry.m', 'Controllers/CSBackupCodec.m',
        'Controllers/CSBackupAssets.m', 'Controllers/CSPluginStorage.m',
        'Controllers/CSBackupStore.m', 'Controllers/CSManagedImageFile.m',
        'Controllers/CSBackupEngine.m', 'Controllers/CSBackupMutation.m',
        'Tests/BackupPerformanceTests.m', '-o', executable,
    ], check=True)
    subprocess.run([executable], check=True)
PY
