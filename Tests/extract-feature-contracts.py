"""Compile production helper/hook bodies with host dependencies substituted.
This tests decisions and call bodies, not Logos installation or UIKit rendering.
"""
from pathlib import Path
import sys,re,json,hashlib
root=Path(__file__).resolve().parent.parent
out=Path(sys.argv[1])
def body(source,marker):
    start=source.index('{',source.index(marker)); depth=0
    for i in range(start,len(source)):
        if source[i]=='{': depth+=1
        elif source[i]=='}':
            depth-=1
            if depth==0: return source[start+1:i]
    raise AssertionError(marker)
s=(root/'Hooks/BubbleStyleHooks.xm').read_text()
preamble=s[s.index('static NSString * const kBubbleStyleEnabledKey'):s.index('static void bubbleSettingsChanged')]
draw=body(s,'- (id)getBubbleImage:').replace('%orig','nativeImage')
pay=body(s,'- (id)bgBubbleInfo').replace('%orig','nativeInfo')
a=(root/'Hooks/AvatarHooks.xm').read_text()
macros='\n'.join(l for l in (root/'Controllers/CSAvatarSettingsViewController.h').read_text().splitlines() if l.startswith('#define'))
avatar=a[a.index('static atomic_uint'):a.index('%hook')]
visible=body(a,'- (BOOL)isShowHeadImage').replace('BOOL native = %orig;','')
(out/'FeatureHookBodies.h').write_text(preamble+'\n@implementation BubbleInfo\n- (id)getBubbleImage:(BOOL)a isDarkMode:(BOOL)b useCache:(BOOL)c { return nil; }\n@end\n@implementation WCPayInfoItem @end\n'+
    'static UIImage *drawBubble(BubbleInfo *self,UIImage *nativeImage,BOOL arg2) {'+draw+'}\n'+
    'static BubbleInfo *markPayment(CommonMessageViewModel *self,BubbleInfo *nativeInfo) {'+pay+'}\n'+
    macros+'\n'+avatar+'\nstatic BOOL showAvatar(CommonMessageViewModel *self,BOOL native) {'+visible+'}\n')
# Check preserved anti-revoke interception bodies against the pre-refactor baseline.
current=(root/'Hooks/RevokeHooks.xm').read_text()
contracts=json.loads((root/'Tests/RevokeInterceptionBaseline.json').read_text())
for contract in contracts['methods']:
    section=current[current.index(contract['section']):] if contract['section'] else current
    actual=hashlib.sha256(body(section,contract['marker']).encode()).hexdigest()
    assert actual==contract['sha256'], 'Anti-revoke interception changed: '+contract['marker']
print(f"PASS: {len(contracts['methods'])} original anti-revoke interception bodies unchanged")
