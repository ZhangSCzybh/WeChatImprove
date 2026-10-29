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
(Path(sys.argv[1])/'AlertOutputDecisions.h').write_text(body('static BOOL DiscardOutput(')+'\n'+body('static void RemoveKnown('))
start=s.index('    __block IMP add=NULL;');end=s.index('    for(NSString *name in @[@"presentLocalNotificationNow:',start)
(Path(sys.argv[1])/'AlertNotificationBody.h').write_text('static void InstallNotificationOutput(void) { IMP imp;\n'+s[start:end]+'\n}')
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter -DCSCF_CALL_REPLY_TESTING=1 \
 -framework Foundation -I"$work" -IControllers \
 Controllers/CSCloseFriend{Policy,Signatures,NotificationAdapter,CallAdapter,CallReply}.m \
 Controllers/CSGroupProjection.m Controllers/WESessionTabItem.m Tests/CloseFriendAlertTests.m -o "$work/alerts"
"$work/alerts"
python3 - "$work" <<'PY'
from pathlib import Path
import sys
out=Path(sys.argv[1])
adapter=Path('Controllers/CSGroupListAdapter.m').read_text()
hooks=Path('Hooks/CloseFriendNotificationHooks.xm').read_text()
header=Path('Controllers/CSGroupListAdapter.h').read_text()
def marked(source,label):
    return source.split('// BEGIN '+label,1)[1].split('// END '+label,1)[0]
def balanced(source,marker,block=False):
    start=source.index(marker)
    if block:start=source.index('^',start)
    opening=source.index('{',start);depth=0;state='code';i=opening
    while i<len(source):
        c=source[i];pair=source[i:i+2]
        if state=='line':
            if c=='\n':state='code'
        elif state=='comment':
            if pair=='*/':state='code';i+=1
        elif state in ('string','char'):
            if c=='\\':i+=1
            elif c==('"' if state=='string' else "'"):state='code'
        elif pair=='//':state='line';i+=1
        elif pair=='/*':state='comment';i+=1
        elif c=='"':state='string'
        elif c=="'":state='char'
        elif c=='{':depth+=1
        elif c=='}':
            depth-=1
            if not depth:return source[start:i+1]
        i+=1
    raise AssertionError('Unbalanced production snippet '+marker)
(out/'TabBadgeDecisionInterface.inc').write_text('NS_ASSUME_NONNULL_BEGIN\n'+marked(header,'Chat tab badge decision')+'\nNS_ASSUME_NONNULL_END\n')
start=adapter.index('@implementation CSGroupTabBadgeDecision')
end=adapter.index('@end',start)+len('@end')
(out/'TabBadgeDecisionImplementation.inc').write_text(adapter[start:end])
constant=next(line for line in adapter.splitlines() if line.startswith('NSNotificationName const CSGroupTabBadgeSourceDidRefreshNotification='))
(out/'TabBadgeSourceNotification.inc').write_text(constant+'\n')
getters=[balanced(adapter,'+ (CSGroupTabBadgeDecision *)closeFriendTabBadgeDecision {'),balanced(adapter,'+ (CSGroupTabBadgeDecision *)closeFriendTabBadgeDecisionForPublication:')]
if '+ (CSGroupTabBadgeDecision *)closeFriendTabBadgeDecisionForController:' in adapter:
    getters.append(balanced(adapter,'+ (CSGroupTabBadgeDecision *)closeFriendTabBadgeDecisionForController:'))
(out/'TabBadgeGetter.inc').write_text('\n'.join(getters))
# This suite controls the source-ready event boundary; GroupLifecycleTests
# separately executes the complete production source maintenance and notifier.
(out/'TabBadgeSourceEmission.inc').write_text('')
(out/'TabBadgeChatTab.inc').write_text(balanced(hooks,'static BOOL ChatTab('))
(out/'TabBadgeOutput.inc').write_text(marked(hooks,'Chat tab badge output'))
for variable,output in [('tab','Numeric'),('tabString','String'),('dot','Dot')]:
    (out/('TabBadge'+output+'.inc')).write_text(balanced(hooks,'__block IMP '+variable+'=NULL;',True))
start=hooks.index('    [NSNotificationCenter.defaultCenter addObserverForName:CSGroupTabBadgeSourceDidRefreshNotification')
end=hooks.index('}];',start)+len('}];')
(out/'TabBadgeSourceObserver.inc').write_text(hooks[start:end])
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror \
 -framework Foundation -I"$work" -IControllers \
 Controllers/CSCloseFriendPolicy.m Controllers/CSCloseFriendSignatures.m \
 Controllers/CSGroupProjection.m Controllers/WESessionTabItem.m Tests/CloseFriendTabBadgeTests.m -o "$work/tab-badges"
"$work/tab-badges"
