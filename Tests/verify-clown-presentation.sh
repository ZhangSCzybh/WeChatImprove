#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-clown-presentation.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
test_sdk="$(xcrun --sdk macosx --show-sdk-path)"
test_arch="$(uname -m)"
xcrun --sdk macosx clang -target "${test_arch}-apple-ios15.0-macabi" \
  -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-deprecated-declarations -Wno-unused-parameter \
  -isysroot "$test_sdk" \
  -iframework "$test_sdk/System/iOSSupport/System/Library/Frameworks" \
  -F "$test_sdk/System/iOSSupport/System/Library/Frameworks" \
  -framework Foundation -framework UIKit -framework QuartzCore -framework PhotosUI -framework CoreGraphics \
  -I"$project_dir/Controllers" -I"$project_dir/Tests" \
  "$project_dir/Controllers/CSClownPreferences.m" \
  "$project_dir/Controllers/CSClownSession.m" \
  "$project_dir/Controllers/CSClownLayout.m" \
  "$project_dir/Controllers/CSClownMenuAdapter.m" \
  "$project_dir/Controllers/CSMessageActionContext.m" \
  "$project_dir/Controllers/CSChatNativeBridge.m" \
  "$project_dir/Controllers/CSMessageNativeActionAdapter.m" \
  "$project_dir/Tests/ClownPresentationNativeDouble.m" \
  "$project_dir/Tests/ClownPresentationTests.m" -o "$test_dir/tests"
"$test_dir/tests"
