from pathlib import Path
import subprocess
import sys

root,out=map(Path,sys.argv[1:])

def balanced(source,marker):
    start=source.index(marker);opening=source.index('{',start)
    depth,state,pos=0,'code',opening
    while pos<len(source):
        char,pair=source[pos],source[pos:pos+2]
        if state=='line':
            if char=='\n':state='code'
        elif state=='comment':
            if pair=='*/':state='code';pos+=1
        elif state in ('string','char'):
            if char=='\\':pos+=1
            elif char==('"' if state=='string' else "'"):state='code'
        elif pair=='//':state='line';pos+=1
        elif pair=='/*':state='comment';pos+=1
        elif char=='"':state='string'
        elif char=="'":state='char'
        elif char=='{':depth+=1
        elif char=='}':
            depth-=1
            if not depth:return source[start:pos+1]
        pos+=1
    raise AssertionError(marker)

bridge=(root/'Controllers/CSCloseFriendBridge.m').read_text()
(out/'UnreadPanelBridge.inc').write_text('\n'.join(balanced(bridge,m) for m in
    ['id CSCloseFriendRead(', 'NSString *CSCloseFriendUserName(', 'BOOL CSCloseFriendInstallHook(']))
contact=(root/'Controllers/CSCloseFriendContactAdapter.m').read_text()
(out/'UnreadPanelSurface.inc').write_text('static char PageEpochKey, PendingSurfaceRefreshKey, SurfaceAppearanceHookKey;\n'+
    '\n'.join(balanced(contact,m) for m in ['BOOL CSCFPageIsCurrent(', 'BOOL CSCFIsClass(', 'BOOL CSCFCallVoid(',
    'BOOL CSCFSetObject(', 'static void ApplyPendingSurfaceRefresh(', 'static BOOL WatchSurfaceAppearance(', 'void CSCFRefreshSurface(']))
adapter=(root/'Controllers/CSCloseFriendUnreadPanelAdapter.m').read_text()
(out/'UnreadPanelAdapter.inc').write_text('\n'.join(line for line in adapter.splitlines() if not line.startswith('#import')))
hooks=(root/'Hooks/CloseFriendUnreadPanelHooks.xm').read_text().split('%ctor',1)[0]
(out/'UnreadPanelHooks.inc').write_text('\n'.join(line for line in hooks.splitlines() if not line.startswith('#import')))
fixture_commit='863bfdb350fddf678c349574d99badb241d98958'
fixture=subprocess.check_output(['git','show',fixture_commit+':Tests/CloseFriendUnreadPanelTests.m'],cwd=root,text=True)
stub='''
// The production complete-source coordinator is tested by NativeGroupBehaviorTests.
// This host double controls the wrapper's acceptance independently from whether
// native rebuildSessionList ran, exercising the panel integration's publication.
static BOOL CompleteAccepted=YES, CompleteExecute=YES;
@interface CSGroupNativeSessionCoordinator:NSObject
+ (instancetype)sharedCoordinator;
- (BOOL)performWithCompleteSourceForSurface:(CSCloseFriendSurface)surface original:(void (^)(void))original;
@end
@implementation CSGroupNativeSessionCoordinator
+ (instancetype)sharedCoordinator {static id c;if(!c)c=[self new];return c;}
- (BOOL)performWithCompleteSourceForSurface:(CSCloseFriendSurface)surface original:(void (^)(void))original {
    (void)surface;if(CompleteExecute)original();return CompleteAccepted;
}
@end
'''
fixture=fixture.replace('#include "UnreadPanelAdapter.inc"',stub+'\n#include "UnreadPanelAdapter.inc"')
extra='''
    CaseName=@"complete-source rejection keeps native-rebuilt content masked";
    Locked(YES);Drain();panel=Panel(home);
    CompleteAccepted=NO;CompleteExecute=YES;
    NSUInteger rejectedBuilds=panel.dataLogic.rebuilds;
    CSCFUnreadPanelRefresh(panel);
    CHECK(panel.dataLogic.rebuilds>rejectedBuilds);
    CHECK(panel.tableContainerView.hidden && !PanelState(panel).safelyPublished && PanelState(panel).maskActive);
    CHECK(!CSCFUnreadPanelAllowsOpen(panel,ordinary));
    CompleteAccepted=YES;CSCFUnreadPanelRefresh(panel);
    CHECK(!panel.tableContainerView.hidden && PanelState(panel).safelyPublished && !PanelState(panel).maskActive);
    CompleteAccepted=NO;CompleteExecute=NO;rejectedBuilds=panel.dataLogic.rebuilds;
    CSCFUnreadPanelRefresh(panel);
    CHECK(panel.dataLogic.rebuilds==rejectedBuilds && panel.tableContainerView.hidden && !PanelState(panel).safelyPublished);
    CompleteAccepted=YES;CompleteExecute=YES;CSCFUnreadPanelRefresh(panel);
    CHECK(!panel.tableContainerView.hidden && PanelState(panel).safelyPublished);
'''
needle='    fprintf(stdout,"Close-friend unread panel%s:'
assert fixture.count(needle)==1
fixture=fixture.replace(needle,extra+'\n'+needle)
(out/'UnreadPanelTests.m').write_text(fixture)
