#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-message-time.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" <<'PY'
from pathlib import Path
import sys
root,out=map(Path,sys.argv[1:])
s=(root/'Hooks/MessageTimeHooks.xm').read_text()
preamble=s.split('%hook CommonMessageCellView',1)[0].replace('../Controllers/','')
def method(signature):
 start=s.index(signature,s.index("%hook CommonMessageCellView"));begin=s.index('{',start);depth=0
 for i in range(begin,len(s)):
  if s[i]=='{':depth+=1
  elif s[i]=='}':
   depth-=1
   if not depth:return s[start:i+1]
 raise ValueError(signature)
# Execute the actual production rendering, tap and layout code; UIKit and native construction are doubles.
methods='\n'.join(method(x) for x in ['- (void)cs_messageTimeLayout','- (void)handleMessageTap:'])
# The removed hook methods now live in the one production lifecycle owner.
g=(root/'Hooks/MessageGestureHooks.xm').read_text()
for signature in ['- (void)layoutSubviews','- (void)prepareForReuse','- (void)onAppear']:
 start=g.index(signature);begin=g.index('{',start);depth=0
 for i in range(begin,len(g)):
  if g[i]=='{':depth+=1
  elif g[i]=='}':
   depth-=1
   if not depth:
    methods+='\n'+g[start:i+1];break
methods=methods.replace('%orig;','')
settings=s[s.index('static void refreshTimeSettings'):s.index('%ctor')]
(out/'TimeHookUnderTest.h').write_text(preamble+'\nstatic char testModelKey,testHeadKey,testBubbleKey,testContentKey;\n@implementation CommonMessageCellView\n- (id)viewModel { return objc_getAssociatedObject(self,&testModelKey); }\n- (id)getHeadImageView { return objc_getAssociatedObject(self,&testHeadKey); }\n- (id)getBgImageView { return objc_getAssociatedObject(self,&testBubbleKey); }\n- (id)getContentView { return objc_getAssociatedObject(self,&testContentKey); }\n- (CGRect)convertRect:(CGRect)rect fromView:(UIView *)view {\n for (UIView *v=view;v && v!=self;v=v.superview) rect=CGRectOffset(rect,v.frame.origin.x-v.bounds.origin.x,v.frame.origin.y-v.bounds.origin.y);\n return rect;\n}\n'+methods+'\n@end\n'+settings)
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter -Wno-unused-variable -Wno-incomplete-implementation \
 -framework Foundation -framework CoreGraphics -framework CoreFoundation \
 -I"$project_dir/Tests/GestureUIKit" -I"$project_dir/Controllers" -I"$test_dir" \
 "$project_dir/Tests/MessageUIKit/MessageUIKit.m" "$project_dir/Tests/TimeUIKit/TimeUIKit.m" \
 "$project_dir/Controllers/CSChatNativeBridge.m" \
 "$project_dir/Controllers/CSMessageTimeLayout.m" "$project_dir/Controllers/CSMessageCellLifecycle.m" "$project_dir/Tests/ClownLifecycleDouble.m" "$project_dir/Tests/VoicePlaybackLifecycleDouble.m" "$project_dir/Tests/TimeUIKit/TimeLifecycleDouble.m" "$project_dir/Tests/MessageTimeHookTests.m" -o "$test_dir/time-tests"
"$test_dir/time-tests"
