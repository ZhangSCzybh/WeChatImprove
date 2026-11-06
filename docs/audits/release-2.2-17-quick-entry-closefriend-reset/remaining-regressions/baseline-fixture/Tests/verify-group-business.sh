#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-group-business.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
bridge_source="${1:-$project_dir/Controllers/CSGroupNativeBridge.m}"
python3 "$project_dir/Tests/extract-group-business.py" "$test_dir" "${2:-$project_dir/Controllers/CSGroupListAdapter.m}"
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-undeclared-selector \
  -framework Foundation -I"$test_dir" -I"$project_dir/Controllers" \
  "$bridge_source" "$project_dir/Controllers/CSGroupProjection.m" \
  "$project_dir/Controllers/CSGroupIndexScope.m" "$project_dir/Controllers/WESessionTabItem.m" \
  "$project_dir/Tests/GroupBusinessRowTests.m" -o "$test_dir/business-tests"
"$test_dir/business-tests"
