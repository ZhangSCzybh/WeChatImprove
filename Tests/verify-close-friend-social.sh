#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
# Compile the real production projection and bounded production adapter bodies. UIKit-only
# painting is compiled for iOS separately; no database, service process or account is touched.
python3 - "$work" <<'PY'
from pathlib import Path
import sys
out=Path(sys.argv[1])
def body(source,marker):
 start=source.index(marker); brace=source.index('{',start); depth=0
 for end in range(brace,len(source)):
  if source[end]=='{': depth+=1
  elif source[end]=='}':
   depth-=1
   if not depth: return source[start:end+1]
s=Path('Controllers/CSCloseFriendTimelineAdapter.m').read_text()
a=s.index('@interface CSCFTimelineState'); b=s.index('static void ClearLikes')
(out/'TimelineBodies.h').write_text(s[a:b]+'\n'+'\n'.join(body(s,m) for m in ['static void ClearLikes(', 'static CSCFTimelineState *State(', 'id CSCFTimelineFacade(', 'static CSCFTimelineScope *Enter(', 'static void Leave(', 'static NSArray *ProjectedPosts(', 'static BOOL ModelScoped(', 'static NSArray *ProjectedUsers(', 'static void InstallModel(']))
s=Path('Controllers/CSCloseFriendInteractionAdapter.m').read_text()
(out/'InteractionBodies.h').write_text('static char MessagesKey;\n'+'\n'.join(body(s,m) for m in ['static CSCloseFriendSocialProjection *Messages(', 'static NSIndexPath *MessagePath(', 'static BOOL MessageActionCurrent(', 'static void TableMethod(', 'static BOOL DiscoveryConcealed(', 'static void DiscoveryCounters(']))
s=Path('Controllers/CSCloseFriendAudienceAdapter.m').read_text()
a=s.index('static char AudienceBindingKey'); b=s.index('static BOOL BindingCurrent(')
(out/'AudienceBodies.h').write_text(s[a:b]+'\nstatic id (*AudienceKeys)(id,SEL);\nstatic id (*AudienceRows)(id,SEL,id);\n'+'\n'.join(body(s,m) for m in ['static BOOL BindingCurrent(', 'static void RevokeBinding(', 'static void RefreshPicker(', 'static CSCFAudienceBinding *BindPicker(', 'static BOOL PickerAllowsAction(', 'static id PublishingOwner(', 'static CSCloseFriendContactProjection *Candidates(', 'static id Keys(', 'static id Rows(', 'static BOOL NeedsUnlock(']))
s=Path('Controllers/CSCloseFriendStatusAdapter.m').read_text()
(out/'StatusBodies.h').write_text(body(s,'static NSArray *RawNames(')+'\n'+body(s,'static CSCloseFriendSocialProjection *Cards('))
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-function \
 -framework Foundation -IControllers -I"$work" Controllers/CSCloseFriendPolicy.m \
 Controllers/CSCloseFriendSignatures.m Controllers/CSCloseFriendContactProjection.m Controllers/CSCloseFriendSocialProjection.m Tests/CloseFriendSocialTests.m -o "$work/tests"
"$work/tests"
