#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
# Compile the entire production controller against recording UIKit/Foundation
# doubles. No application, audio session, real defaults or device is accessed.
python3 - <<'PY'
from pathlib import Path
import subprocess
import tempfile

source = Path('Controllers/CSBackgroundRunViewController.m').read_text()
source = '\n'.join(line for line in source.splitlines() if not line.startswith('#import '))
for forbidden in ('NSUserDefaults', 'setBool:', 'NSTimer', 'dispatch_after', 'dispatch_source_create'):
    assert forbidden not in source, forbidden
with tempfile.TemporaryDirectory(prefix='wechat-background-settings-ui-') as directory:
    work = Path(directory)
    (work / 'BackgroundRunSettingsUIUnderTest.h').write_text(source + '\n')
    executable = work / 'tests'
    subprocess.run([
        'xcrun', '--sdk', 'macosx', 'clang', '-fobjc-arc', '-fblocks',
        '-Wall', '-Wextra', '-Werror', '-I' + str(work),
        '-framework', 'Foundation', 'Tests/BackgroundRunSettingsUITests.m',
        '-o', str(executable),
    ], check=True)
    subprocess.run([str(executable)], check=True)
PY
