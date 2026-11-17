#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-ad-purification-preferences.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
xcrun --sdk macosx clang -fobjc-arc -fblocks -DCS_AD_PURIFICATION_TESTING=1 \
  -Wall -Wextra -Werror -framework Foundation -I"$project_dir/Controllers" \
  "$project_dir/Controllers/CSCloseFriendSignatures.m" \
  "$project_dir/Controllers/CSAdPurification.m" \
  "$project_dir/Tests/AdPurificationPreferencesTests.m" \
  -o "$test_dir/tests"
"$test_dir/tests"
