#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
# Exercise only the real visibility/lifecycle methods with the existing App and
# Scene declarations plus small view doubles; no audio, tasks or defaults run.
python3 - <<'PY'
from pathlib import Path
import re, subprocess, tempfile

root=Path.cwd()
source=(root/'Controllers/CSBackgroundRunViewController.m').read_text().split('@implementation CSBackgroundRunViewController',1)[1]
methods=[]
for selector in ('viewWillAppear:', 'viewIsAppearing:', 'viewWillDisappear:', 'canRefreshSections',
                 'refreshSectionsIfVisible', 'requestSectionsRefresh', 'stateChanged:', 'activityChanged:'):
    match=re.search(r'^- \([^)]+\)'+re.escape(selector)+r'(?=\(|\s|\{)',source,re.M)
    if not match:
        raise SystemExit('Missing production selector: '+selector)
    start=match.start()
    following=re.search(r'^[-+] \(',source[match.end():],re.M)
    end=match.end()+following.start() if following else source.index('\n@end',match.end())
    methods.append(source[start:end].rstrip())
with tempfile.TemporaryDirectory(prefix='wechat-background-view-refresh-') as directory:
    work=Path(directory)
    (work/'BackgroundRunViewRefreshUnderTest.h').write_text('\n'.join(methods)+'\n')
    executable=work/'tests'
    subprocess.run(['xcrun','--sdk','macosx','clang','-fobjc-arc','-fblocks','-Wall','-Wextra','-Werror',
                    '-Wno-unused-parameter','-I'+str(work),'-I'+str(root/'Tests/BackgroundRunNative'),
                    '-framework','Foundation',str(root/'Tests/BackgroundRunViewRefreshTests.m'),'-o',str(executable)],check=True)
    subprocess.run([str(executable)],check=True)
PY
