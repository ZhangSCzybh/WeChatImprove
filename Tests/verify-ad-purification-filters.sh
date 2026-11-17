#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-ad-purification-filters.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
# Compile the production pure filters directly. No tweak entry point, hook
# installer, app runtime, preferences, or user data is loaded by this suite.
xcrun --sdk macosx clang -fobjc-arc -fblocks \
  -Wall -Wextra -Werror -framework Foundation -I"$project_dir/Controllers" \
  "$project_dir/Controllers/CSAdPurificationFilters.m" \
  "$project_dir/Tests/AdPurificationFiltersTests.m" \
  -o "$test_dir/tests"
"$test_dir/tests"
