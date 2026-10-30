#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-navigation-images.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" <<'PY'
from pathlib import Path
import sys
source=(Path(sys.argv[1])/'Hooks/NavigationTitleHooks.xm').read_text().split('@implementation CSAvatarTitleView',1)[1]
methods=[]
for marker in ['- (void)updateOtherAvatarWithUrl:', '- (void)updateSelfAvatarWithUrl:', '- (void)updateAvatarWithURL:']:
 start=source.index(marker);brace=source.index('{',start);depth=0
 for end in range(brace,len(source)):
  if source[end]=='{':depth+=1
  elif source[end]=='}':
   depth-=1
   if depth==0:break
 methods.append(source[start:end+1])
(Path(sys.argv[2])/'NavigationAvatarBodies.h').write_text('\n'.join(methods))
root=Path(sys.argv[1]);out=Path(sys.argv[2])
def extract(source,markers):
 result=[]
 for marker in markers:
  start=source.index(marker);brace=source.index('{',start);depth=0
  for end in range(brace,len(source)):
   if source[end]=='{':depth+=1
   elif source[end]=='}':
    depth-=1
    if not depth:break
  result.append(source[start:end+1])
 return '\n'.join(result)
popover=(root/'Hooks/NavigationTitleHooks.xm').read_text().split('@implementation CSUserInfoPopoverController',1)[1]
assert 'dataWithContentsOfURL:' not in popover and 'NSURLSession' not in popover
(out/'NavigationPopoverBodies.h').write_text(extract(popover,['- (void)viewDidAppear:', '- (void)viewWillDisappear:', '- (void)loadPopoverAvatar', '- (void)tableView:(UITableView *)tableView didEndDisplayingCell:']))
settings=(root/'Controllers/CSContactSeparatorSettingsViewController.m').read_text()
(out/'NavigationSettingsAvatarBodies.h').write_text(extract(settings,['- (void)configureContactAvatarURL:', '- (void)viewDidAppear:', '- (void)viewWillDisappear:', '- (void)loadContactAvatar', '- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:']))
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror \
  -framework Foundation -framework CoreGraphics -framework ImageIO \
  -I"$test_dir" -I"$project_dir/Tests/NavigationUIKit" -I"$project_dir/Controllers" \
  "$project_dir/Controllers/CSNavigationImageLoader.m" "$project_dir/Tests/NavigationImageTests.m" -o "$test_dir/tests"
"$test_dir/tests"
