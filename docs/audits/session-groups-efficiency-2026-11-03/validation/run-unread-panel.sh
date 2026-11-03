#!/bin/bash
set -euo pipefail
validation_dir="$(cd "$(dirname "$0")" && pwd)"
project_dir="${WECHAT_VALIDATION_SOURCE_ROOT:-$(cd "$validation_dir/../../../.." && pwd)}"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-unread-panel-validation.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 "$validation_dir/extract-unread-panel.py" "$project_dir" "$test_dir"
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror \
  -framework Foundation -I"$project_dir/Controllers" -I"$test_dir" \
  "$project_dir/Controllers/CSCloseFriendPolicy.m" "$project_dir/Controllers/CSCloseFriendSignatures.m" \
  "$test_dir/UnreadPanelTests.m" -o "$test_dir/unread-panel"
"$test_dir/unread-panel"
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -DCS_UNREAD_PANEL_ABI=1 \
  -framework Foundation -I"$project_dir/Controllers" -I"$test_dir" \
  "$project_dir/Controllers/CSCloseFriendPolicy.m" "$project_dir/Controllers/CSCloseFriendSignatures.m" \
  "$test_dir/UnreadPanelTests.m" -o "$test_dir/unread-panel-abi"
"$test_dir/unread-panel-abi"
