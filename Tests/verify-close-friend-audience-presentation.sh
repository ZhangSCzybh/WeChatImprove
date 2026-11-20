#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
audience_work=$(mktemp -d)
trap 'rm -rf "$audience_work"' EXIT
# Compile the complete production adapter. Native UI painting and account access
# are fixtures; production hook registration, scopes and filtering stay intact.
python3 - "$audience_work" <<'PY'
from pathlib import Path
import os,sys
source=Path(os.environ.get('CS_AUDIENCE_PRESENTATION_SOURCE','Controllers/CSCloseFriendAudiencePresentation.m')).read_text()
source='\n'.join(line for line in source.splitlines() if not line.lstrip().startswith('#import'))
(Path(sys.argv[1])/'AudiencePresentationProduction.h').write_text(source+'\n')
def body(source,marker):
 start=source.index(marker);brace=source.index('{',start);depth=0
 for end in range(brace,len(source)):
  if source[end]=='{':depth+=1
  elif source[end]=='}':
   depth-=1
   if not depth:return source[start:end+1]
owner=Path('Controllers/CSCloseFriendAudienceAdapter.m').read_text()
start=owner.index('static char AudienceBindingKey');end=owner.index('static BOOL AuthorizationCurrent(')
(Path(sys.argv[1])/'AudienceOwnerProduction.h').write_text(owner[start:end]+'\n'+'\n'.join(body(owner,marker) for marker in ['static id ReminderOwner(', 'static void BindReminderPicker(', 'static id PublishingOwner(', 'id CSCFAudiencePublishingOwner(']))
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-function \
 -framework Foundation -IControllers -I"$audience_work" Controllers/CSCloseFriendPolicy.m \
 Controllers/CSCloseFriendSignatures.m Controllers/CSCloseFriendContactProjection.m \
 Tests/CloseFriendAudiencePresentationTests.m -o "$audience_work/tests"
"$audience_work/tests"
