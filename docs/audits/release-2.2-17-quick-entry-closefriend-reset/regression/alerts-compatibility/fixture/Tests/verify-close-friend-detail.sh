#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
detail_work=$(mktemp -d)
trap 'rm -rf "$detail_work"' EXIT
python3 - "$detail_work" <<'PY'
from pathlib import Path
import sys
source=Path('Controllers/CSCloseFriendDetailAdapter.m').read_text()
Path(sys.argv[1],'DetailAdapterBodies.h').write_text('\n'.join(line for line in source.splitlines() if not line.startswith('#import '))+'\n')
PY
xcrun --sdk macosx clang -x objective-c -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-function \
 -framework Foundation -IControllers -I"$detail_work" Controllers/CSCloseFriendPolicy.m \
 Controllers/CSCloseFriendSignatures.m Controllers/CSCloseFriendContactProjection.m Controllers/CSCloseFriendSocialProjection.m \
 Tests/CloseFriendDetailFixture.h -o "$detail_work/tests"
"$detail_work/tests"
