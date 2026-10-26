#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
entry_work=$(mktemp -d)
trap 'rm -rf "$entry_work"' EXIT
python3 - "$entry_work" <<'PY'
from pathlib import Path
import re, sys
def extract(file, names, output):
    source=Path(file).read_text()
    methods=[]
    for name in names:
        start=re.search(r'^- \([^)]+\)'+re.escape(name)+r'(?=[ :(])',source,re.M).start()
        opening=source.index('{',start); depth=1; end=opening+1
        while depth:
            depth+=(source[end]=='{')-(source[end]=='}'); end+=1
        methods.append(source[start:end])
    Path(sys.argv[1],output).write_text('\n'.join(methods))
extract('Controllers/CSCloseFriendManager.m', ['settingsEntryVisible','settingsEntryDiscoveryToken','discoverSettingsEntryWithToken:','validateToken:'], 'EntryManagerUnderTest.h')
extract('Controllers/CSCustomViewController.m', ['installCloseFriendEntryGesture','canDiscoverCloseFriendEntry','gestureRecognizer:','discoverCloseFriendEntry:','closeFriendEntryPolicyChanged:'], 'EntryGestureUnderTest.h')
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-deprecated-declarations \
 -IControllers -I"$entry_work" -framework Foundation -framework Security \
 Controllers/CSCloseFriendPolicy.m Controllers/CSCloseFriendCrypto.m Controllers/CSCloseFriendStore.m Controllers/CSPluginStorage.m \
 Controllers/CSCloseFriendRuntime.m Controllers/CSCloseFriendEntryState.m Tests/CloseFriendEntryTests.m -o "$entry_work/state"
"$entry_work/state"
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter \
 -I"$entry_work" -framework Foundation Tests/CloseFriendEntryGestureTests.m -o "$entry_work/gesture"
"$entry_work/gesture"
