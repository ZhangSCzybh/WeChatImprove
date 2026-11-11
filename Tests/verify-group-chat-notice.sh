#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-group-notice.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -framework Foundation \
 -I"$project_dir/Controllers" "$project_dir/Controllers/CSGroupChatNoticeReference.m" \
 "$project_dir/Tests/GroupChatNoticeReferenceTests.m" -o "$test_dir/notice-reference-tests"
"$test_dir/notice-reference-tests"
sdk_dir="$(xcrun --sdk iphoneos --show-sdk-path)"
for arch in arm64 arm64e; do
 xcrun --sdk iphoneos clang -target "$arch-apple-ios15.0" -isysroot "$sdk_dir" \
  -fobjc-arc -fblocks -fsyntax-only -Wall -Wextra -Werror \
  -I"$project_dir/Controllers" -I/Users/zhangshichao/theos/vendor/include -F/Users/zhangshichao/theos/vendor/lib \
  "$project_dir/Controllers/CSGroupChatLocalNotice.m"
done
