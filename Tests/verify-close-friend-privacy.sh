#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
privacy_work=$(mktemp -d)
trap 'rm -rf "$privacy_work"' EXIT
python3 - "$privacy_work" "${1:-Controllers/CSCloseFriendPrivacyAdapter.m}" <<'PY'
from pathlib import Path
import sys
source=Path(sys.argv[2]).read_text()
Path(sys.argv[1],'PrivacyAdapterUnderTest.h').write_text('\n'.join(line for line in source.splitlines() if not line.startswith('#import'))+'\n')
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror \
 -framework Foundation -IControllers -I"$privacy_work" Controllers/CSCloseFriendPolicy.m \
 Controllers/CSCloseFriendSignatures.m Tests/CloseFriendPrivacyTests.m -o "$privacy_work/tests"
"$privacy_work/tests"
