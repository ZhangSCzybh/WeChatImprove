#!/bin/bash
set -euo pipefail
# --voice-animation-core runs only the six native completion regressions.
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-merge-bubble.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
xcrun --sdk macosx clang -DCS_MERGE_TESTING=1 -DCS_BUBBLE_TESTING=1 -DCS_MERGE_BUBBLE_INTEGRATION=1 \
  -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter \
  -framework Foundation -framework CoreGraphics -framework CoreFoundation \
  -I"$project_dir/Tests/MergeBubbleUIKit" -I"$project_dir/Tests/MessageUIKit" -I"$project_dir/Controllers" \
  "$project_dir/Tests/MessageUIKit/MessageUIKit.m" "$project_dir/Tests/MessageUIKit/DisplayLink.m" \
  "$project_dir/Tests/BubbleUIKit/BubbleUIKit.m" \
  "$project_dir/Controllers/CSMessageMergePolicy.m" "$project_dir/Controllers/CSMessageMergeAdapter.m" \
  "$project_dir/Controllers/CSRevokeReference.m" "$project_dir/Controllers/CSChatNativeBridge.m" \
  "$project_dir/Controllers/CSMessageNavigation.m" "$project_dir/Controllers/CSMessageTimeLayout.m" \
  "$project_dir/Controllers/CSBubbleStylePolicy.m" "$project_dir/Controllers/CSBubbleStyleAdapter.m" \
  "$project_dir/Controllers/CSBubbleTextColors.m" "$project_dir/Tests/MergeBubbleIntegrationTests.m" \
  -o "$test_dir/integration-tests"
"$test_dir/integration-tests" "$@"
