#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-group-page-animator.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" <<'PY'
from pathlib import Path
import sys
root, output = map(Path, sys.argv[1:])
source = (root / 'Controllers/CSGroupPageAnimator.m').read_text()
assert source.count('#import "CSGroupPageAnimator.h"') == 1
# Compile the entire production implementation against observable UIKit doubles.
(output / 'GroupPageAnimatorUnderTest.h').write_text(source.replace('#import "CSGroupPageAnimator.h"', ''))
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter \
  -framework Foundation -framework CoreGraphics -I"$test_dir" \
  "$project_dir/Tests/GroupPageAnimatorTests.m" -o "$test_dir/tests"
"$test_dir/tests"
