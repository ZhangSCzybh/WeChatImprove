#!/bin/bash
set -euo pipefail
project_dir="${1:?Pass the WeChatImprove checkout path}"
script_dir="$(cd "$(dirname "$0")" && pwd)"
build_dir="$(mktemp -d)"
trap 'rm -rf "$build_dir"' EXIT
cd "$project_dir"
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-deprecated-declarations -IControllers -framework Foundation -framework CoreFoundation -framework ImageIO -framework CoreGraphics Controllers/CSBackupRegistry.m Controllers/CSBackupCodec.m Controllers/CSBackupAssets.m Controllers/CSBackupStore.m Controllers/CSBackupEngine.m Controllers/CSBackupMutation.m "$script_dir/reproduction.m" -o "$build_dir/diagnosis"
"$build_dir/diagnosis"
