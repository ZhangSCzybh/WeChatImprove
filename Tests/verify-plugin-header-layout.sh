#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
header_work=$(mktemp -d)
trap 'rm -rf "$header_work"' EXIT
python3 - "$header_work" <<'PY'
from pathlib import Path
import sys
public = Path('Controllers/CSPluginHeaderView.h').read_text().replace('#import <UIKit/UIKit.h>', '')
source = Path('Controllers/CSPluginHeaderView.m').read_text()
assert source.count('#import "CSPluginHeaderView.h"') == 1
Path(sys.argv[1], 'PluginHeaderUnderTest.h').write_text(source.replace('#import "CSPluginHeaderView.h"', public))
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter -Wno-nullability-completeness \
 -IHeaders -I"$header_work" -framework Foundation -framework AppKit -framework CoreGraphics \
 Tests/PluginHeaderLayoutTests.m -o "$header_work/layout"
"$header_work/layout"
