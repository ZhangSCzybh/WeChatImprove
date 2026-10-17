#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-native-reward.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter \
  -framework Foundation -I"$project_dir/Controllers" \
  "$project_dir/Controllers/CSNativeRewardRoute.m" "$project_dir/Tests/NativeRewardRouteTests.m" \
  -o "$test_dir/native-reward-tests"
"$test_dir/native-reward-tests"
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter \
  -framework Foundation -I"$project_dir/Tests/RewardUIKit" -I"$project_dir/Controllers" \
  "$project_dir/Controllers/CSNativeRewardRoute.m" "$project_dir/Controllers/CSNativeRewardPresenter.m" \
  "$project_dir/Controllers/CSNativeSettingsHost.m" "$project_dir/Tests/NativeRewardPresenterTests.m" -o "$test_dir/native-reward-presenter-tests"
"$test_dir/native-reward-presenter-tests"
