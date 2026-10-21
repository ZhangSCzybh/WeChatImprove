#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
mkdir -p "$work/UIKit"
printf '#import <Foundation/Foundation.h>\n@class UIViewController;\n' > "$work/UIKit/UIKit.h"
python3 - "$work" <<'PY'
from pathlib import Path
import sys
s=Path('Controllers/CSGroupListAdapter.m').read_text();start=s.index('+ (NSNumber *)closeFriendAlertBadgeCount');b=s.index('{',start);depth=0
for end in range(b,len(s)):
 if s[end]=='{':depth+=1
 elif s[end]=='}':
  depth-=1
  if not depth:break
(Path(sys.argv[1])/'AlertBadgeBody.h').write_text(s[start:end+1])
s=Path('Hooks/CloseFriendNotificationHooks.xm').read_text()
def body(marker):
 start=s.index(marker);opening=s.index('{',start);depth=0
 for end in range(opening,len(s)):
  if s[end]=='{':depth+=1
  elif s[end]=='}':
   depth-=1
   if not depth:return s[start:end+1]
(Path(sys.argv[1])/'AlertOutputDecisions.h').write_text(body('static BOOL Silent(')+'\n'+body('static void RemoveKnown('))
start=s.index('    __block IMP add=NULL;');end=s.index('    for(NSString *name in @[@"presentLocalNotificationNow:',start)
(Path(sys.argv[1])/'AlertNotificationBody.h').write_text('static void InstallNotificationOutput(void) { IMP imp;\n'+s[start:end]+'\n}')
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter -DCSCF_CALL_REPLY_TESTING=1 \
 -framework Foundation -I"$work" -IControllers \
 Controllers/CSCloseFriend{Policy,Signatures,NotificationAdapter,MuteAdapter,CallAdapter,CallReply}.m \
 Controllers/CSGroupProjection.m Controllers/WESessionTabItem.m Tests/CloseFriendAlertTests.m -o "$work/alerts"
"$work/alerts"
