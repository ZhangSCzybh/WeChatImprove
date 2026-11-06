#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
python3 - "$work" <<'PY'
from pathlib import Path
import sys
source=Path('Controllers/CSCloseFriendAlbumAdapter.m').read_text()
(Path(sys.argv[1])/'AlbumBodies.h').write_text('\n'.join(line for line in source.splitlines() if not line.startswith('#import'))+'\n')
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror \
 -framework Foundation -IControllers -I"$work" Controllers/CSCloseFriendPolicy.m \
 Controllers/CSCloseFriendSignatures.m Tests/CloseFriendAlbumTests.m -o "$work/tests"
"$work/tests"
