#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
python3 - "$work" <<'PY'
from pathlib import Path
import sys
source=Path('Hooks/CloseFriendCallDiagnosticsHooks.xm').read_text().split('%ctor',1)[0]
source='\n'.join(line for line in source.splitlines() if not line.startswith('#import'))
(Path(sys.argv[1])/'CallResponseProduction.inc').write_text(source+'\n')
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-function \
  -framework Foundation -IControllers -I"$work" \
  Controllers/CSCloseFriendCallDiagnostics.m Controllers/CSCloseFriendSignatures.m \
  Tests/CloseFriendCallResponseTests.m -o "$work/response"
"$work/response"
