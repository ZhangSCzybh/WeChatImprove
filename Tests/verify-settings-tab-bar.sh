#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-settings-tab-bar.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" <<'PY'
from pathlib import Path
import sys
source=(Path(sys.argv[1])/'Controllers/CSSettingsTabBar.m').read_text()
signatures=[
'- (void)reloadTheme {',
'- (CGSize)intrinsicContentSize {',
'- (void)setHorizontalInset:(CGFloat)horizontalInset {',
'- (void)layoutSubviews {',
'- (void)updateButtonStates {',
'- (void)setSelectedIndex:(NSUInteger)selectedIndex {',
'- (void)setSelectedIndex:(NSUInteger)index animated:(BOOL)animated {',
'- (void)selectTab:(UIButton *)button {',
'- (void)toggleSearch {',
'- (void)cancelSearchAnimations {',
'- (void)setSearching:(BOOL)searching animated:(BOOL)animated {',
'- (void)resetSearch {',
'- (void)searchTextChanged:(UITextField *)field {',
'- (BOOL)textFieldShouldReturn:(UITextField *)textField {'
]
methods=[]
for signature in signatures:
    start=source.index(signature)
    opening=source.index('{',start)
    depth,end=1,opening+1
    while depth:
        depth+=(source[end]=='{')-(source[end]=='}')
        end+=1
    methods.append(source[start:end])
(Path(sys.argv[2])/'SettingsTabBarUnderTest.h').write_text('\n'.join(methods))
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter \
  -framework Foundation -framework CoreGraphics -I"$test_dir" \
  "$project_dir/Tests/SettingsTabBarTests.m" -o "$test_dir/tests"
"$test_dir/tests"
