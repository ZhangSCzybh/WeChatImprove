#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-avatar-input.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" <<'PY'
from pathlib import Path
import sys,re
root,out=map(Path,sys.argv[1:])
s=(root/'Hooks/InputTextHooks.xm').read_text()
result=[]
for name,parent in [('BaseMsgContentViewController','UIViewController'),('MMGrowTextView','TestNativeInput'),('MMInputToolView','TestNativeTool')]:
    body=s.split('%hook '+name+'\n')[1].split('%end')[0]
    if name=='BaseMsgContentViewController':
        for sel in ['viewWillAppear','viewWillDisappear']:
            body=re.sub(r'(- \(void\)'+sel+r':[^\n]+)',lambda m:m.group().replace('%orig;',f'[super {sel}:animated];'),body)
    elif name=='MMGrowTextView':
        replacements=['[super layoutSubviews];','[super didMoveToWindow];','[super didMoveToSuperview];','[super traitCollectionDidChange:previous];',
          '[super setPlaceHolder:text];','[super setAttributePlaceholder:text];','[super setPlaceHolderColor:color];','[super setPlaceHolderMultiLine:multiline];',
          '[super setPlaceholder:text animated:animated];','[super setAttributedPlaceholder:text animated:animated];']
        for r in replacements: body=body.replace('%orig;',r,1)
    else:
        for r in ['[super layoutSubviews];','[super didMoveToWindow];','[super updateToolViewHeight:animated];','[super onWillAppear];','[super onViewDidInit];']:body=body.replace('%orig;',r,1)
    assert '%' not in body
    result.append('@interface '+name+' : '+parent+' @end\n@implementation '+name+'\n'+body+'\n@end\n')
s=(root/'Hooks/CSAvatarShape.xm').read_text()
for name in ['MMHeadImageView','FakeHeadImageView']:
    body=s.split('%hook '+name+'\n')[1].split('%end')[0]
    body=body[body.index('- (void)didMoveToWindow'):body.index('// Hook conerSize')]
    for r in ['[super didMoveToWindow];','[super didMoveToSuperview];','[super setHidden:hidden];','[super setAlpha:alpha];','[super setTag:tag];']:body=body.replace('%orig;',r,1)
    assert '%' not in body
    result.append('@interface '+name+' : UIView @end\n@implementation '+name+'\n'+body+'\n@end\n')
body=s.split('%hook MoreViewController\n')[1].split('%end')[0]
for r in ['[super viewDidAppear:animated];','[super viewWillDisappear:animated];','[super viewDidLayoutSubviews];']:body=body.replace('%orig;',r,1)
result.append('@interface MoreViewController : UIViewController @end\n@implementation MoreViewController\n'+body+'\n@end\n')
(out/'StyleHooksUnderTest.h').write_text('\n'.join(result))
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror \
  -Wno-unused-parameter -framework Foundation -framework CoreGraphics -framework QuartzCore \
  -I"$project_dir/Tests/StyleUIKit" -I"$project_dir/Controllers" -I"$test_dir" \
  "$project_dir/Tests/TabBarUIKit/TabBarUIKit.m" "$project_dir/Tests/StyleUIKit/StyleUIKit.m" \
  "$project_dir/Controllers/CSAvatarRotation.m" "$project_dir/Controllers/CSInputTextStyle.m" \
  "$project_dir/Tests/AvatarInputStyleTests.m" -o "$test_dir/tests"
"$test_dir/tests"
