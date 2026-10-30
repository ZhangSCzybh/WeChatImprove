#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-group-return-banner-probe.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
adapter_source="${1:-$project_dir/Controllers/CSGroupListAdapter.m}"
hooks_source="${2:-$project_dir/Hooks/SessionGroupHooks.xm}"
projection_source="${3:-$project_dir/Controllers/CSGroupProjection.m}"
projection_header="${4:-$project_dir/Controllers/CSGroupProjection.h}"
python3 "$project_dir/Tests/extract-group-return-banner-probe.py" "$test_dir/GroupReturnBannerProbeBodies.h" "$adapter_source" "$hooks_source"
cp "$projection_source" "$test_dir/CSGroupProjection.m"
cp "$projection_header" "$test_dir/CSGroupProjection.h"
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror \
 -framework Foundation -framework CoreGraphics -I"$test_dir" -I"$project_dir/Controllers" \
 "$test_dir/CSGroupProjection.m" "$project_dir/Controllers/CSGroupIndexScope.m" \
 "$project_dir/Controllers/WESessionTabItem.m" "$project_dir/Tests/GroupReturnBannerProbeTests.m" \
 -o "$test_dir/return-banner-probe"
"$test_dir/return-banner-probe"
