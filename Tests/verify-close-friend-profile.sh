#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
python3 - "$work" <<'PY'
from pathlib import Path
import sys
out=Path(sys.argv[1])
source=Path('Controllers/CSCloseFriendProfileAdapter.m').read_text()
(out/'ProfileAdapterBodies.h').write_text('\n'.join(line for line in source.splitlines() if not line.startswith('#import'))+'\n')
source=Path('Hooks/CloseFriendProfileHooks.xm').read_text()
source='\n'.join(line for line in source.splitlines() if not line.startswith('#import'))
# Execute the exact production registrations synchronously in this host fixture.
source=source.replace('%ctor { dispatch_async(dispatch_get_main_queue(),^{','static void InstallProfileHooks(void) {',1)
assert source.endswith('}); }')
(out/'ProfileHookBodies.h').write_text(source[:-5]+'}\n')
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror \
 -framework Foundation -IControllers -I"$work" Controllers/CSCloseFriendPolicy.m \
 Controllers/CSCloseFriendSignatures.m Tests/CloseFriendProfileTests.m -o "$work/tests"
"$work/tests"
