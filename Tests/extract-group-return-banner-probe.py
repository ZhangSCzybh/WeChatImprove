"""Complete production refresh with counted host UIKit/native boundaries.

Only five method names are changed to add nonmutating entry/exit observers;
method bodies, NativeEvent attribution, viewport logic and publication plan are
otherwise executed as saved. Every input sequence is synthetic and is logged.
"""
from pathlib import Path
import sys
root=Path(__file__).resolve().parent.parent
source=(Path(sys.argv[2]) if len(sys.argv)>2 else root/'Controllers/CSGroupListAdapter.m').read_text()
hooks=(Path(sys.argv[3]) if len(sys.argv)>3 else root/'Hooks/SessionGroupHooks.xm').read_text()
out=Path(sys.argv[1])
def method(text,marker):
 start=text.index(marker);brace=text.index('{',start);depth=0
 for end in range(brace,len(text)):
  if text[end]=='{':depth+=1
  elif text[end]=='}':
   depth-=1
   if not depth:return text[start:end+1]
 raise AssertionError(marker)
markers=['- (void)refresh {','- (void)publishProjection:','- (void)layout {','- (void)publishHeader:',
 '- (UITableViewCell *)cellForDisplayPath:(NSIndexPath *)path target:(id)target {','- (BOOL)isActive {',
 '+ (void)setPresentationSuspended:','+ (void)finishPresentationReturnForController:',
 '- (BOOL)hasScrollableContent','- (BOOL)canRestoreAnchor','- (void)saveAnchor','- (void)restoreAnchor',
 '- (NSNumber *)presentationScrollHeight','- (void)restoreViewportFromTab:','- (void)restoreScrollHeight:',
 '- (void)setNativeTableHeaderView:', '- (void)cancelScheduledRefresh {', '- (void)requestRefresh {',
 '- (void)beginNativeChange {','- (void)beginNativeChangeOfKind:(CSGroupChangeKind)kind {',
 '- (void)beginNativeChangeOfKind:(CSGroupChangeKind)kind sessionUserNames:',
 '- (void)endNativeChange {','- (void)endNativeChangeCoalesced:', '- (void)requestCoalescedRefresh {']
renames={'- (void)publishProjection:':'- (void)probe_publishProjectionBody:', '- (void)layout {':'- (void)probe_layoutBody {','- (void)publishHeader:':'- (void)probe_publishHeaderBody:',
 '- (UITableViewCell *)cellForDisplayPath:':'- (UITableViewCell *)probe_cellBody:', '- (void)restoreAnchor':'- (void)probe_restoreAnchorBody'}
bodies=[]
for marker in markers:
 body=method(source,marker)
 for old,new in renames.items():
  if body.startswith(old):body=body.replace(old,new,1);break
 bodies.append(body)
out.write_text('\n\n'.join(bodies)+'\n')
identity=hooks.split('// BEGIN Session event identity',1)[1].split('// END Session event identity',1)[0]
functions=[method(hooks,'static void Native('),identity,method(hooks,'static void NativeEvent('),method(hooks,'static void NativeNotification(')]
out.with_name('GroupReturnBannerEvents.h').write_text('\n'.join(functions)+'\n')
main=hooks.split('%hook NewMainFrameViewController',1)[1].split('%end',1)[0]
bodies=[]
for name in ['viewWillAppear','viewDidAppear','viewWillDisappear','viewDidDisappear']:
 body=method(main,'- (void)'+name+':').replace('%orig','[self hostAppearance:@"'+name+'"]');bodies.append(body)
for name in ['viewDidLayoutSubviews','initTableHeaderView','setSearchBarToTableHeaderView']:
 body=method(main,'- (void)'+name+' {').replace('%orig','[self hostHeaderClosing:@"'+name+'"]');bodies.append(body)
logic=hooks.split('%hook MainFrameLogicController',1)[1].split('%end',1)[0]
body=method(logic,'- (void)onActiveUsrNameChange:').replace('%orig','[self hostActiveUserChanged:oldName newName:newName]')
bodies.append(body)
out.with_name('GroupReturnBannerHostHooks.h').write_text('\n'.join(bodies)+'\n')
# Header setter routing is part of the production hook, not a guessed UIKit path.
body=method(hooks,'- (void)setTableHeaderView:(UIView *)header {').split('{',1)[1].rsplit('}',1)[0].replace('%orig','original(header)')
out.with_name('GroupReturnBannerHeaderHook.h').write_text('static void ProbeHeaderSetter(id self,UIView *header,void (^original)(UIView *)) {'+body+'}\n')
