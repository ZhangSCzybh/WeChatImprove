#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-ad-web.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
xcrun --sdk macosx clang -fobjc-arc -fblocks -DCS_AD_PURIFICATION_TESTING=1 \
  -Wall -Wextra -Werror -framework Foundation -I"$project_dir/Controllers" \
  "$project_dir/Controllers/CSCloseFriendSignatures.m" \
  "$project_dir/Controllers/CSAdPurification.m" \
  "$project_dir/Controllers/CSAdPurificationFilters.m" \
  "$project_dir/Controllers/CSAdPurificationWebHooks.m" \
  "$project_dir/Tests/AdPurificationWebTests.m" -o "$test_dir/ad-web-tests"
"$test_dir/ad-web-tests"
