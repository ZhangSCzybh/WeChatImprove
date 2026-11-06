#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-ai-images.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror \
  -framework Foundation -framework ImageIO -framework CoreGraphics -lz \
  -I"$project_dir/Controllers" \
  "$project_dir/Controllers/CSMessageActionContext.m" \
  "$project_dir/Controllers/CSMessageNativeActionAdapter.m" \
  "$project_dir/Controllers/CSAIImagePreparer.m" \
  "$project_dir/Tests/AIImagePreparerTests.m" -o "$test_dir/ai-images"
"$test_dir/ai-images" "$test_dir"
