#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
contacts_read_work=$(mktemp -d)
trap 'rm -rf "$contacts_read_work"' EXIT
python3 - "$contacts_read_work" <<'PY'
from pathlib import Path
import sys
out=Path(sys.argv[1])
source=Path('Hooks/CloseFriendContactHooks.xm').read_text()
out.joinpath('ContactsReadBodies.h').write_text(source[source.index('@interface CSCFContactsCache'):source.index('static void Hook0(')])
source=Path('Controllers/CSCloseFriendContactAdapter.m').read_text()
start=source.index('BOOL CSCFContactLogicSurface(')
out.joinpath('ContactsSurface.h').write_text(source[start:source.index('void CSCFBeginSelection(',start)])
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -framework Foundation \
 -IControllers -I"$contacts_read_work" Controllers/CSCloseFriendPolicy.m Controllers/CSCloseFriendSignatures.m \
 Controllers/CSCloseFriendContactProjection.m Tests/CloseFriendContactsReadTests.m -o "$contacts_read_work/tests"
"$contacts_read_work/tests"
