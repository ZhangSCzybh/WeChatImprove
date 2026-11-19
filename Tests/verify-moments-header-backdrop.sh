#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-moments-header-backdrop.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
test_sdk="$(xcrun --sdk macosx --show-sdk-path)"
xcrun --sdk macosx clang -target "$(uname -m)-apple-ios15.0-macabi" \
  -isysroot "$test_sdk" \
  -iframework "$test_sdk/System/iOSSupport/System/Library/Frameworks" \
  -F "$test_sdk/System/iOSSupport/System/Library/Frameworks" \
  -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter -Wno-deprecated-declarations \
  -framework Foundation -framework UIKit -framework CoreGraphics -framework QuartzCore \
  -I"$project_dir/Controllers" \
  "$project_dir/Controllers/CSCloseFriendSignatures.m" \
  "$project_dir/Controllers/CSMomentsMasonryLayout.m" \
  "$project_dir/Controllers/CSMomentsHeaderBackdrop.m" \
  "$project_dir/Tests/MomentsHeaderBackdropTests.m" -o "$test_dir/tests"
"$test_dir/tests"
