#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-moments-card.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" <<'PY'
from pathlib import Path
import os, sys
project, output = map(Path, sys.argv[1:])
source = Path(os.environ.get('CS_MOMENTS_CARD_SOURCE', project / 'Controllers/CSMomentsCardCell.m')).read_text()
def body(marker):
    start = source.index(marker)
    brace = source.index('{', start)
    depth = 0
    for end in range(brace, len(source)):
        if source[end] == '{':
            depth += 1
        elif source[end] == '}':
            depth -= 1
            if not depth:
                return source[start:end + 1]
    raise ValueError('Unclosed production body: ' + marker)
(output / 'MomentsCardCountBody.h').write_text(body('static NSString *CSMomentsCompactCount('))
(output / 'MomentsCardTimestampBodies.h').write_text('\n'.join(body(marker) for marker in [
    'static BOOL CSMomentsTimestampIsValid(', 'static NSString *CSMomentsTimestampText(']))
(output / 'MomentsCardFontBodies.h').write_text('\n'.join(body(marker) for marker in [
    'static UIFont *CSMomentsTitleFont(', 'static UIFont *CSMomentsWeightedSmallFont(', 'static UIFont *CSMomentsSmallFont(']))
(output / 'MomentsCardFontConfiguration.h').write_text(body('- (void)updateFonts {').replace(
    '- (void)updateFonts {', '- (void)applyFonts {', 1))
(output / 'MomentsCardNativeTitleBodies.h').write_text('\n'.join(body(marker) for marker in [
    'static BOOL CSMomentsTitleMethod(', 'static UIView *CSMomentsCreateNativeTitleView(',
    'static CGFloat CSMomentsConfigureNativeTitleView(']))
(output / 'MomentsCardConfigurationBodies.h').write_text('\n'.join(body(marker) for marker in [
    '- (void)configureWithModel:', '- (void)endDisplaying {']))
PY
xcrun --sdk macosx clang -std=c11 -Wall -Wextra -Werror -I"$project_dir/Controllers" \
  "$project_dir/Tests/MomentsCardGeometryTests.c" -o "$test_dir/geometry"
"$test_dir/geometry"
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror \
  -framework Foundation -framework CoreGraphics -I"$test_dir" -I"$project_dir/Controllers" \
  "$project_dir/Controllers/CSCloseFriendSignatures.m" \
  "$project_dir/Tests/MomentsCardConfigurationTests.m" -o "$test_dir/configuration"
"$test_dir/configuration"
if [[ "${1:-}" == "--ios" ]]; then
  ios_sdk="$(xcrun --sdk iphoneos --show-sdk-path)"
  for arch in arm64 arm64e; do
    xcrun --sdk iphoneos clang -target "$arch-apple-ios15.0" -isysroot "$ios_sdk" \
      -fobjc-arc -fblocks -Wall -Wextra -Werror -I"$project_dir/Controllers" \
      -c "${CS_MOMENTS_CARD_SOURCE:-$project_dir/Controllers/CSMomentsCardCell.m}" -o "$test_dir/card.$arch.o"
  done
  printf 'Moments card iOS: arm64 + arm64e source objects compiled\n'
fi
