#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
python3 - <<'PY'
import pathlib
import subprocess
import tempfile

with tempfile.TemporaryDirectory(prefix="backup-deletion-build-") as work:
    binary = str(pathlib.Path(work) / "tests")
    subprocess.run([
        "xcrun", "--sdk", "macosx", "clang", "-fobjc-arc", "-fblocks",
        "-Wall", "-Wextra", "-Werror", "-Wno-deprecated-declarations", "-IControllers",
        "-framework", "Foundation", "-framework", "CoreFoundation",
        "-framework", "ImageIO", "-framework", "CoreGraphics",
        "Controllers/CSScheduledTaskStore.m", "Controllers/CSAIReplyStore.m", "Controllers/CSGroupChatStore.m", "Controllers/CSGroupChatTemplate.m",
        "Controllers/CSBackupRegistry.m", "Controllers/CSBackupCodec.m",
        "Controllers/CSBackupAssets.m", "Controllers/CSPluginStorage.m",
        "Controllers/CSBackupStore.m", "Tests/BackupDeletionTests.m", "-o", binary,
    ], check=True)
    subprocess.run([binary], check=True)
PY
