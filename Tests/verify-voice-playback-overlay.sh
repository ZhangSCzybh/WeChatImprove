#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-voice-overlay.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror \
 -Wno-unused-parameter -Wno-incomplete-implementation \
 -framework Foundation -framework CoreGraphics \
 -I"$project_dir/Tests/VoicePlaybackUIKit" -I"$project_dir/Controllers" \
 "$project_dir/Tests/VoicePlaybackUIKit/VoicePlaybackUIKit.m" \
 "$project_dir/Tests/VoicePlaybackOverlayTests.m" -o "$test_dir/tests"
"$test_dir/tests"
