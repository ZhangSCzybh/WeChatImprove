#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-message-merge.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
xcrun --sdk macosx clang -fobjc-arc -Wall -Wextra -Werror -framework Foundation \
  -I"$project_dir/Controllers" "$project_dir/Controllers/CSMessageMergePolicy.m" \
  "$project_dir/Tests/MessageMergePolicyTests.m" -o "$test_dir/policy-tests"
"$test_dir/policy-tests"
xcrun --sdk macosx clang -DCS_MERGE_TESTING=1 -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter \
  -framework Foundation -framework CoreGraphics -framework CoreFoundation \
  -I"$project_dir/Tests/MessageUIKit" -I"$project_dir/Controllers" \
  "$project_dir/Tests/MessageUIKit/MessageUIKit.m" "$project_dir/Tests/MessageUIKit/DisplayLink.m" \
  "$project_dir/Controllers/CSMessageMergePolicy.m" "$project_dir/Controllers/CSMessageMergeAdapter.m" \
  "$project_dir/Controllers/CSRevokeReference.m" "$project_dir/Controllers/CSChatNativeBridge.m" "$project_dir/Controllers/CSMessageNavigation.m" "$project_dir/Tests/MessageMergeAdapterTests.m" \
  "$project_dir/Controllers/CSMessageTimeLayout.m" \
  -o "$test_dir/adapter-tests"
"$test_dir/adapter-tests"
