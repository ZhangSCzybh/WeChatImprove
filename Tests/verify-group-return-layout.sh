#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-group-return-layout.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 "$project_dir/Tests/extract-group-return-layout.py" "$test_dir/GroupReturnPrivacyBodies.h" "$@"
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror \
 -framework Foundation -framework CoreGraphics -I"$test_dir" -I"$project_dir/Controllers" \
 "$project_dir/Controllers/CSGroupProjection.m" "$project_dir/Controllers/WESessionTabItem.m" \
 "$project_dir/Controllers/CSGroupInvocationMapper.m" "$project_dir/Controllers/CSGroupNativeBridge.m" \
 "$project_dir/Controllers/CSGroupIndexScope.m" "$project_dir/Controllers/CSCloseFriendPolicy.m" \
 "$project_dir/Controllers/CSCloseFriendSignatures.m" \
 "$project_dir/Tests/GroupReturnLayoutTests.m" -o "$test_dir/return-layout-tests"
"$test_dir/return-layout-tests"
