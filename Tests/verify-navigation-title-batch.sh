#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-navigation-title.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" <<'PY'
from pathlib import Path
import re, sys
root,out=map(Path,sys.argv[1:])
source=(root/'Hooks/NavigationTitleHooks.xm').read_text()
implementation=source.split('@implementation CSAvatarTitleView',1)[1]
markers=['performTitleUpdates:', 'updateLayoutWithMode:', 'updateSizeAndRadius:', 'updateSeparatorText:',
         'updateSeparatorSize:', 'updateAvatarSpacing:', 'updateVerticalOffset:', 'updateOtherNickname:',
         'updateOtherAvatarWithContact:', 'updateSeparatorForContactId:', 'settingsChanged:']
methods=[]
for marker in markers:
 start=implementation.index('- (void)'+marker); brace=implementation.index('{',start);depth=1;end=brace+1
 while depth:
  if implementation[end]=='{':depth+=1
  elif implementation[end]=='}':depth-=1
  end+=1
 methods.append(implementation[start:end])
properties='\n'.join(line for line in source.split('@interface CSAvatarTitleView : UIView',1)[1].split('@end',1)[0].splitlines() if line.startswith('@property'))
declarations='\n'.join(method.split('{',1)[0].strip()+';' for method in methods)
(out/'NavigationTitleDeclarations.h').write_text('@interface CSAvatarTitleView : UIView\n'+properties+'\n'+declarations+'\n@end\n')
(out/'NavigationTitleBodies.h').write_text('\n'.join(methods))
settings=(root/'Controllers/CSNavigationTitleSettingsViewController.m').read_text()
names=set(re.findall(r'\bk(?:Navigation\w+Key|Default\w+)\b','\n'.join(methods)))
constants=[]
for name in sorted(names):
 match=re.search(r'(?:NSString\s*\*\s*const|CGFloat const)\s+'+name+r'\s*=\s*[^;]+;',settings)
 assert match,name
 constants.append(match.group())
(out/'NavigationTitleConstants.h').write_text('\n'.join(constants))
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter \
  -Wno-incomplete-implementation -framework Foundation -framework CoreGraphics -framework QuartzCore \
  -I"$project_dir/Tests/StyleUIKit" -I"$test_dir" \
  "$project_dir/Tests/TabBarUIKit/TabBarUIKit.m" "$project_dir/Tests/StyleUIKit/StyleUIKit.m" \
  "$project_dir/Tests/NavigationTitleBatchTests.m" -o "$test_dir/tests"
"$test_dir/tests"
