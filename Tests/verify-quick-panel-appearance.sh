#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-quick-panel-appearance.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" <<'PY'
from pathlib import Path
import sys
root,output=map(Path,sys.argv[1:])
source=(root/'Controllers/CSQuickPanelContentView.m').read_text()
def method(selector):
    start=source.index(selector)
    body=source.index('{',start)
    depth=1
    index=body+1
    while depth:
        if source[index]=='{': depth+=1
        elif source[index]=='}': depth-=1
        index+=1
    return source[start:index]
prefix=method('static UIFont *CSQuickPanelFont(CGFloat size, UIFontWeight weight, UIFontTextStyle style, CGFloat maximum) {')+'''
@interface CSQuickPanelActionCell : UIView
@property(nonatomic,strong) UIView *iconTile;
@property(nonatomic,strong) UIImageView *iconView;
@property(nonatomic,strong) UILabel *titleLabel;
- (void)configureWithIdentifier:(NSString *)identifier lightContent:(BOOL)lightContent;
@end
@implementation CSQuickPanelActionCell
'''
cell=method('- (void)configureWithIdentifier:(NSString *)identifier lightContent:(BOOL)lightContent {')
content='''
@end
@interface CSQuickPanelContentView : UIView
@property(nonatomic,strong) UIImageView *avatarView;
@property(nonatomic,strong) UILabel *nicknameLabel,*wechatIDLabel,*timeLabel,*dateLabel,*emptyLabel;
@property(nonatomic,strong) UIView *separator;
@property(nonatomic,strong) UIButton *emptySettingsButton;
@property(nonatomic,strong) UICollectionView *collection;
@property(nonatomic,copy) NSArray<NSString *> *identifiers;
@property(nonatomic) BOOL backgroundUsesLightContent;
- (void)updateTheme;
- (void)updateFonts;
@end
@implementation CSQuickPanelContentView
'''
selected=[method('- (void)updateFonts {'),method('- (void)updateTheme {'),method('- (void)setBackgroundUsesLightContent:(BOOL)backgroundUsesLightContent {')]
(output/'QuickPanelAppearanceProduction.inc').write_text(prefix+cell+content+'\n'.join(selected)+'\n@end\n')
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-deprecated-declarations \
  -framework Foundation -framework CoreGraphics -framework ImageIO -framework CoreText \
  -I"$project_dir/Tests/QuickPanelAppearanceUIKit" -I"$project_dir/Controllers" -I"$test_dir" \
  "$project_dir/Tests/QuickPanelAppearanceUIKit/QuickPanelAppearanceUIKit.m" \
  "$project_dir/Controllers/CSQuickPanelAppearance.m" \
  "$project_dir/Controllers/CSSettingsHomeTheme.m" \
  "$project_dir/Controllers/CSQuickPanelPreferences.m" \
  "$project_dir/Controllers/CSQuickPanelBackgroundImageStore.m" \
  "$project_dir/Controllers/CSManagedImageFile.m" \
  "$project_dir/Controllers/CSBackupMutation.m" \
  "$project_dir/Tests/QuickPanelAppearanceTests.m" -o "$test_dir/appearance-tests"
"$test_dir/appearance-tests"
