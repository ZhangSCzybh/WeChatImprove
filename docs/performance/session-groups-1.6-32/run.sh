#!/bin/bash
set -euo pipefail
repo="$(cd "$(dirname "$0")/../../.." && pwd)"
build="$(mktemp -d "${TMPDIR:-/tmp}/wechat-group-performance.XXXXXX")"
trap 'rm -rf "$build"' EXIT
xcrun --sdk macosx clang -O2 -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-undeclared-selector \
  -framework Foundation -I"$repo/Controllers" \
  "$repo/Controllers/CSGroupNativeBridge.m" "$repo/Controllers/CSGroupProjection.m" \
  "$repo/Controllers/CSGroupPreferences.m" "$repo/Controllers/WESessionTabItem.m" \
  "$repo/docs/performance/session-groups-1.6-32/benchmark.m" -o "$build/benchmark"
"$build/benchmark"
