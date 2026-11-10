#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-favorite-voice-media.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -framework Foundation \
  -I"$project_dir/Controllers" \
  "$project_dir/Controllers/CSMessageActionPreferences.m" \
  "$project_dir/Controllers/CSMessageActionContext.m" \
  "$project_dir/Controllers/CSMessageActionPolicy.m" \
  "$project_dir/Controllers/CSMessageNativeActionAdapter.m" \
  "$project_dir/Controllers/CSMessageMediaProvider.m" \
  "$project_dir/Controllers/CSFavoriteVoiceContext.m" \
  "$project_dir/Controllers/CSFavoriteVoiceMediaProvider.m" \
  "$project_dir/Tests/FavoriteVoiceMediaTests.m" -o "$test_dir/tests"
"$test_dir/tests"
