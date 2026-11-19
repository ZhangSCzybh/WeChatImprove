#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-moments-native-media.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror \
  -Wno-unused-parameter -framework Foundation -framework CoreGraphics -framework QuartzCore -framework ImageIO \
  -I"$project_dir/Tests/TabBarUIKit" -I"$project_dir/Controllers" \
  "$project_dir/Tests/TabBarUIKit/TabBarUIKit.m" \
  "$project_dir/Controllers/CSCloseFriendSignatures.m" \
  "$project_dir/Controllers/CSMomentsNativeMedia.m" \
  "$project_dir/Tests/MomentsNativeMediaTests.m" -o "$test_dir/tests"
"$test_dir/tests"
