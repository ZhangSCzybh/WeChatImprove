#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
python3 - "$work" <<'PY'
from pathlib import Path
import sys
source=Path('Controllers/CSCloseFriendInteractionAdapter.m').read_text()
def body(marker):
    start=source.index(marker); brace=source.index('{',start); depth=0
    for end in range(brace,len(source)):
        if source[end]=='{': depth+=1
        elif source[end]=='}':
            depth-=1
            if not depth:return source[start:end+1]
markers=['static NSUInteger VisibleUnread(', 'static BOOL DiscoveryCommentInteger(', 'static BOOL DiscoveryRelatedMessage(', 'static unsigned int DiscoveryUnreadCount(', 'static void InstallUnread(', 'static BOOL DiscoveryConcealed(', 'static void DiscoveryCounters(', 'static void DiscoveryViews(', 'static void InstallDiscovery(']
declarations='static BOOL UnreadDisplay;\nstatic id DiscoveryCountingOwner;\nstatic id (*NativeUnread)(id,SEL);\nstatic char DiscoveryViewKey;\n'
(Path(sys.argv[1])/'DiscoveryBodies.h').write_text(declarations+'\n'.join(body(marker) for marker in markers))
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-function \
 -framework Foundation -IControllers -I"$work" Controllers/CSCloseFriendPolicy.m \
 Controllers/CSCloseFriendSignatures.m Controllers/CSCloseFriendContactProjection.m \
 Controllers/CSCloseFriendSocialProjection.m Tests/CloseFriendDiscoveryTests.m -o "$work/tests"
"$work/tests"
