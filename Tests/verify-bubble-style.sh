#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-bubble-style.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror \
  -framework Foundation -framework CoreGraphics \
  -I"$project_dir/Controllers" "$project_dir/Controllers/CSBubbleStylePolicy.m" \
  "$project_dir/Tests/BubbleStyleTests.m" -o "$test_dir/bubble-tests"
"$test_dir/bubble-tests"
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter \
  -framework Foundation -framework CoreGraphics -framework CoreFoundation \
  -I"$project_dir/Tests/BubbleUIKit" -I"$project_dir/Controllers" \
  "$project_dir/Tests/BubbleUIKit/BubbleUIKit.m" "$project_dir/Controllers/CSBubbleStylePolicy.m" \
  "$project_dir/Controllers/CSBubbleStyleAdapter.m" "$project_dir/Tests/BubbleStyleAdapterTests.m" \
  -o "$test_dir/bubble-adapter-tests"
"$test_dir/bubble-adapter-tests"
