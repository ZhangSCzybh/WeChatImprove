#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-moments-share.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" <<'PY'
from pathlib import Path
import os
import sys

project, output = map(Path, sys.argv[1:])
source = Path(os.environ.get('CS_MOMENTS_CARD_SOURCE', project / 'Controllers/CSMomentsCardCell.m')).read_text()
start = source.index('@protocol CSMomentsNativeShareConstructor')
end = source.index('@implementation CSMomentsCardCell', start)
size_start = source.index('static CGSize CSMomentsSharedCoverSize(')
size_end = source.index('\nstatic CSMomentsCardMetrics CSMomentsMetrics(', size_start)
(output / 'MomentsSharedCoverProduction.h').write_text(source[size_start:size_end] + source[start:end])
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror \
  -framework Foundation -framework CoreGraphics \
  -I"$test_dir" -I"$project_dir/Tests" -I"$project_dir/Controllers" \
  "$project_dir/Controllers/CSCloseFriendSignatures.m" \
  "$project_dir/Tests/MomentsSharePresentationTests.m" -o "$test_dir/tests"
"$test_dir/tests"
