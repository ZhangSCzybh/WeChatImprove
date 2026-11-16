#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
# Compile the whole production adapter. Only UIKit painting and the native
# service/database boundary are fixtures; registration and every Hook stay real.
python3 - "$work" <<'PY'
from pathlib import Path
import os,sys
source=Path(os.environ.get('CS_INTERACTION_ADAPTER_SOURCE','Controllers/CSCloseFriendInteractionAdapter.m')).read_text()
source='\n'.join(line for line in source.splitlines() if not line.lstrip().startswith('#import'))
# Historical beta03 has no projection cache. Keep its behavioral regression
# runnable while compiling cache-specific thread assertions for current code.
cache=int('static NSMutableDictionary *UnreadProjections;' in source)
(Path(sys.argv[1])/'InteractionAdapterProduction.h').write_text(f'#define INTERACTION_HAS_UNREAD_PROJECTION_CACHE {cache}\n'+source+'\n')
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-function \
 -framework Foundation -IControllers -I"$work" Controllers/CSCloseFriendPolicy.m \
 Controllers/CSCloseFriendSignatures.m Controllers/CSCloseFriendSocialProjection.m \
 Tests/CloseFriendInteractionTests.m -o "$work/tests"
"$work/tests"
