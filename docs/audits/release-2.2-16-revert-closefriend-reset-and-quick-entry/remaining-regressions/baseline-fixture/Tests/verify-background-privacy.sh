#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
privacy_work=$(mktemp -d "${TMPDIR:-/tmp}/wechat-background-privacy.XXXXXX")
trap 'rm -rf "$privacy_work"' EXIT
python3 - "$privacy_work" "${1:-Controllers/CSCloseFriendManager.m}" <<'PY'
from pathlib import Path
import re,sys
source=Path(sys.argv[2]).read_text()
methods=[]
for name in ['windows','cover','uncover','schedulePolicyRefresh','flushPolicyRefresh','canLockForShake','handleShake','backgroundPrivacySettingsChanged:','start','lockAndReturnToSafePage','cancelBiometricAuthentication','resign:','suspend:','active:','accountChanged:']:
 match=re.search(r'^- \([^)]+\)'+re.escape(name)+r'(?=[ :(])',source,re.M)
 # The optional source argument reproduces the old lifecycle without the new observer.
 if not match and name in ['backgroundPrivacySettingsChanged:','flushPolicyRefresh']:continue
 start=match.start()
 opening=source.index('{',start);depth=1;pos=opening+1
 while depth:
  depth+=(source[pos]=='{')-(source[pos]=='}');pos+=1
 methods.append(source[start:pos])
Path(sys.argv[1],'BackgroundPrivacyUnderTest.h').write_text('\n'.join(methods))
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter \
 -framework Foundation -framework CoreGraphics -framework QuartzCore \
 -ITests/BackgroundBlurUIKit -IControllers -I"$privacy_work" \
 Tests/BackgroundBlurUIKit/BackgroundBlurUIKit.m Controllers/CSBackgroundBlurManager.m \
 Controllers/CSCloseFriendPolicy.m Tests/BackgroundPrivacyCoverTests.m -o "$privacy_work/privacy"
"$privacy_work/privacy"
