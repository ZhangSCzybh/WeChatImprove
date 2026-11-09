#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-revoke-tap.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter \
 -framework Foundation -framework CoreGraphics \
 -I"$project_dir/Tests/RevokeTapUIKit" -I"$project_dir/Controllers" \
 "$project_dir/Controllers/CSRevokeReference.m" "$project_dir/Controllers/CSChatNativeBridge.m" \
 "$project_dir/Controllers/CSRevokeTapAdapter.m" "$project_dir/Tests/RevokeTapAdapterTests.m" \
 -o "$test_dir/revoke-tap-tests"
"$test_dir/revoke-tap-tests"
