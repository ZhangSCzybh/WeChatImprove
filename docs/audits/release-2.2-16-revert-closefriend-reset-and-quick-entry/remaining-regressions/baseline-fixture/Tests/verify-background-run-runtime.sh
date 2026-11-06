#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-background-runtime.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror \
    -I"$project_dir/Tests/BackgroundRunRuntimeNative" -I"$project_dir/Controllers" -framework Foundation \
    "$project_dir/Tests/BackgroundRunRuntimeNative/BackgroundRunRuntimeNative.m" \
    "$project_dir/Controllers/CSBackgroundRunRuntime.m" "$project_dir/Tests/BackgroundRunRuntimeTests.m" \
    -o "$test_dir/background-runtime"
"$test_dir/background-runtime"
if [[ "${1:-}" == "--ios" ]]; then
    sdk_dir="$(xcrun --sdk iphoneos --show-sdk-path)"
    for arch in arm64 arm64e; do
        xcrun --sdk iphoneos clang -target "$arch-apple-ios15.0" -isysroot "$sdk_dir" \
            -fobjc-arc -fblocks -Wall -Wextra -Werror -I"$project_dir/Controllers" \
            -c "$project_dir/Controllers/CSBackgroundRunRuntime.m" -o "$test_dir/runtime.$arch.o"
    done
    printf 'Background runtime iOS: arm64 + arm64e source objects compiled\n'
fi
