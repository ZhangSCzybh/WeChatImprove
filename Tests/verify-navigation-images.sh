#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-navigation-images.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" <<'PY'
from pathlib import Path
import sys
source=(Path(sys.argv[1])/'Hooks/NavigationTitleHooks.xm').read_text().split('@implementation CSAvatarTitleView',1)[1]
methods=[]
for marker in ['- (void)updateOtherAvatarWithUrl:', '- (void)updateSelfAvatarWithUrl:', '- (void)updateAvatarWithURL:']:
 start=source.index(marker);brace=source.index('{',start);depth=0
 for end in range(brace,len(source)):
  if source[end]=='{':depth+=1
  elif source[end]=='}':
   depth-=1
   if depth==0:break
 methods.append(source[start:end+1])
(Path(sys.argv[2])/'NavigationAvatarBodies.h').write_text('\n'.join(methods))
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror \
  -framework Foundation -framework CoreGraphics -framework ImageIO \
  -I"$test_dir" -I"$project_dir/Tests/NavigationUIKit" -I"$project_dir/Controllers" \
  "$project_dir/Controllers/CSNavigationImageLoader.m" "$project_dir/Tests/NavigationImageTests.m" -o "$test_dir/tests"
"$test_dir/tests"
