// Exercise the real pre-visibility hook bodies without a table content layout.
// UIKit visibility/animation is represented by a synchronous host boundary.
#import "MiniappFirstFrameBase.h"

@interface CSGroupListAdapter (VisibilityBoundary)
- (void)prepareForVisibility;
+ (void)prepareForListVisibility;
@end
@interface FirstFrameAdapter : CSGroupListAdapter
@property(nonatomic) BOOL fixtureActive;
@property(nonatomic,strong) id pan,listPan,chrome;
@end
static NSHashTable<CSGroupListAdapter *> *visibilityAdapters;
static NSHashTable<CSGroupListAdapter *> *Adapters(void) { return visibilityAdapters; }
@implementation CSGroupListAdapter (VisibilityBoundary)
#include "FirstFrameGateBodies.h"
@end
@implementation FirstFrameAdapter
- (BOOL)isActive { return self.fixtureActive; }
- (void)refresh { [super refresh]; [self finishPublicationFixture]; }
@end

@interface FirstFrameGesture : NSObject
@property(nonatomic) BOOL enabled;
@end
@implementation FirstFrameGesture @end
@interface FirstFrameChrome : NSObject
@property(nonatomic) BOOL userInteractionEnabled,hidden;
@end
@implementation FirstFrameChrome @end
typedef struct { CGFloat top,left,bottom,right; } FirstFrameInsets;
@interface FirstFrameTable : MainFrameTableView
@property(nonatomic) CGSize contentSize;
@property(nonatomic) FirstFrameInsets contentInset;
@property(nonatomic) BOOL userInteractionEnabled,scrollEnabled;
@property(nonatomic,strong) FirstFrameGesture *panGestureRecognizer;
@end
@implementation FirstFrameTable @end
static NSDictionary *ScrollState(FirstFrameAdapter *adapter) {
    FirstFrameTable *table=(id)adapter.table;
    return @{@"width":@(table.contentSize.width),@"height":@(table.contentSize.height),@"insetTop":@(table.contentInset.top),@"insetLeft":@(table.contentInset.left),@"insetBottom":@(table.contentInset.bottom),@"insetRight":@(table.contentInset.right),@"offsetX":@(table.contentOffset.x),@"offsetY":@(table.contentOffset.y),@"interaction":@(table.userInteractionEnabled),@"scroll":@(table.scrollEnabled),@"tablePan":@(table.panGestureRecognizer.enabled),@"pan":@([(FirstFrameGesture *)adapter.pan enabled]),@"listPan":@([(FirstFrameGesture *)adapter.listPan enabled]),@"chromeInteraction":@([(FirstFrameChrome *)adapter.chrome userInteractionEnabled]),@"chromeHidden":@([(FirstFrameChrome *)adapter.chrome hidden])};
}

static NSUInteger boundaryCalls,privateAtFirstExposure,visibleAtFirstExposure;
static NSArray *firstExposedGeometry;
static BOOL IsExposed(UITableViewCell *cell) { return !cell.hidden; }
static NSUInteger ExposedPrivate(MainFrameTableView *table) {
    NSUInteger count=0;NSArray *cells=table.visibleCells;
    for(NSUInteger i=0;i<cells.count && i<table.captured.count;i++)
        if(IsExposed(cells[i]) && [policy hidesUserName:table.captured[i][@"name"] surface:CSCloseFriendSurfaceSession])count++;
    return count;
}
static void CaptureBoundary(void) {
    boundaryCalls++;MainFrameTableView *table=(id)layoutAdapter.table;
    privateAtFirstExposure=ExposedPrivate(table);visibleAtFirstExposure=0;
    NSMutableArray *geometry=[NSMutableArray array];
    for(NSUInteger i=0;i<table.visibleCells.count;i++)if(IsExposed(table.visibleCells[i])) {
        visibleAtFirstExposure++;if(i<table.captured.count)[geometry addObject:table.captured[i]];
    }
    firstExposedGeometry=geometry;
}
@interface WAAppDismissAnimateTransition : NSObject
- (void)animateTransition:(id)context;
- (void)captureOriginal;
@end
@implementation WAAppDismissAnimateTransition
- (void)captureOriginal { CaptureBoundary(); }
#include "FirstFrameAnimatorHook.h"
@end
@interface WAAppTansitionController : NSObject
- (void)onMiniTaskDismissalGestureWillBegin;
- (void)sheetDismissalTransitionWillBegin:(id)context;
- (void)captureOriginal;
@end
@implementation WAAppTansitionController
- (void)captureOriginal { CaptureBoundary(); }
#include "FirstFrameContainerHooks.h"
@end
static FirstFrameAdapter *FreshVisibility(BOOL revealed) {
    firstFrameSnapshotRead=nil;
    NativeHost *host=[NativeHost new];host.sessions=[NSMutableArray array];
    for(NSString *name in @[@"ordinary-A",@"private-person",@"ordinary-B",@"private-group-A",@"private-group-B",@"ordinary-C",@"ordinary-D"])
        [host.sessions addObject:FoldedSession(name,0)];
    FirstFrameTable *table=[FirstFrameTable new];table.contentOffset=CGPointMake(0,128);host.m_tableView=table;
    table.contentSize=CGSizeMake(592,2048);table.contentInset=(FirstFrameInsets){20,0,12,0};
    table.userInteractionEnabled=YES;table.scrollEnabled=YES;table.panGestureRecognizer=[FirstFrameGesture new];table.panGestureRecognizer.enabled=YES;
    table.offsetWrites=0;[table.offsetTrajectory removeAllObjects];
    FirstFrameAdapter *adapter=[FirstFrameAdapter new];adapter.fixtureActive=YES;adapter.controller=host;adapter.table=table;
    FirstFrameGesture *pan=[FirstFrameGesture new],*listPan=[FirstFrameGesture new];pan.enabled=YES;listPan.enabled=YES;
    adapter.pan=pan;adapter.listPan=listPan;adapter.chrome=[FirstFrameChrome new];
    adapter.preferences=[Preferences new];adapter.prefetchedPaths=[NSMutableSet set];
    policy=Policy(@[@"private-person",@"private-group-A",@"private-group-B"],revealed,2);layoutAdapter=adapter;groupEnabled=NO;
    visibilityAdapters=[NSHashTable weakObjectsHashTable];[visibilityAdapters addObject:adapter];
    [adapter refresh];adapter.snapshotEpoch=epoch;
    boundaryCalls=0;privateAtFirstExposure=0;visibleAtFirstExposure=0;firstExposedGeometry=nil;firstFrameSnapshotRead=nil;
    return adapter;
}
static void SeedNativeContent(FirstFrameAdapter *adapter) {
    MainFrameTableView *table=(id)adapter.table;
    CSGroupWithNativeIndices(table,^{[table captureLayout];});
    Check(table.captured.count==7 && ExposedPrivate(table)==3,@"control: covered native cell set really contains three exposed private identities");
    table.layouts=0;table.rawPrivateCells=0;table.offsetWrites=0;table.reloads=0;[table.offsetTrajectory removeAllObjects];
}
static void Record(NSString *name,FirstFrameAdapter *adapter) {
    MainFrameTableView *table=(id)adapter.table;
    NSDictionary *data=@{@"case":name,@"boundaryCalls":@(boundaryCalls),@"contentLayouts":@(table.layouts),@"privateAtFirstExposure":@(privateAtFirstExposure),@"visibleAtFirstExposure":@(visibleAtFirstExposure),@"held":@(adapter.sessionLayoutHeld),@"refreshRequests":@(adapter.layoutRequests),@"offsetWrites":@(table.offsetWrites),@"offsetY":@(table.contentOffset.y),@"fullReloads":@(table.reloads),@"scrollState":ScrollState(adapter)};
    NSData *json=[NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingSortedKeys error:NULL];
    printf("FIRST_FRAME %s\n",[[[NSString alloc]initWithData:json encoding:NSUTF8StringEncoding]UTF8String]);
}
static void RunBoundary(NSUInteger kind) {
    if(kind==0)[[WAAppDismissAnimateTransition new]animateTransition:nil];
    else if(kind==1)[[WAAppTansitionController new]onMiniTaskDismissalGestureWillBegin];
    else [[WAAppTansitionController new]sheetDismissalTransitionWillBegin:nil];
}
int main(void) { @autoreleasepool {
    setvbuf(stdout,NULL,_IONBF,0);
    FirstFrameAdapter *adapter=FreshVisibility(NO);MainFrameTableView *table=(id)adapter.table;
    adapter.fixtureActive=NO;[table layoutSubviews];
    Record(@"inactive-locked-content-layout",adapter);
    Check(!table.rawPrivateCells,@"inactive adapter with matching safe projection cannot publish private native rows during layout");
    Check(table.layouts==0 && adapter.sessionLayoutHeld,@"inactive locked adapter holds native content instead of accepting projection-only proof");

    for(NSUInteger entry=0;entry<3;entry++) {
        adapter=FreshVisibility(NO);table=(id)adapter.table;
        [table layoutSubviews];NSArray *stable=table.captured;
        SeedNativeContent(adapter);NSDictionary *scrollBefore=ScrollState(adapter);RunBoundary(entry);Record([NSString stringWithFormat:@"native-old-cells-zero-layout-entry-%lu",(unsigned long)entry],adapter);
        Check(boundaryCalls==1 && table.layouts==0,@"overlay begins disappearing without a table content layout");
        Check(privateAtFirstExposure==0,@"the original dismissal callback sees zero exposed protected identities");
        Check(visibleAtFirstExposure==0,@"unproven existing native cell set is neutral before first visible frame");
        Check(adapter.sessionLayoutHeld && adapter.privacyRefreshPending,@"first visible boundary records a held privacy publication");
        Check(table.contentOffset.y==128 && !table.offsetWrites && !table.reloads,@"previsibility gate leaves viewport unchanged and adds no full-table reload");
        Check([ScrollState(adapter) isEqual:scrollBefore],@"neutralization preserves content size, insets, interaction, scroll and all gesture/chrome flags");
        table.contentOffset=CGPointMake(0,160);
        Check(table.contentOffset.y==160 && !ExposedPrivate(table),@"programmatic drag surrogate can move the neutralized viewport without exposing private rows");
        table.contentOffset=CGPointMake(0,128);table.offsetWrites=0;[table.offsetTrajectory removeAllObjects];
        NSUInteger requests=adapter.layoutRequests;
        [table layoutSubviews];CaptureBoundary();
        Check(privateAtFirstExposure==0 && visibleAtFirstExposure==0,@"one intervening layout cannot restore old native cells merely because a safe projection exists");
        Check(adapter.layoutRequests==requests,@"held layout does not recursively request another refresh");
        [adapter refresh];[table layoutSubviews];CaptureBoundary();Record(@"safe-refresh-recovery",adapter);
        Check(privateAtFirstExposure==0 && visibleAtFirstExposure==4,@"refresh restores exactly filtered content with no second private flash");
        Check([firstExposedGeometry isEqual:stable],@"first restored sections, row y, card boundaries and scroll offset equal filtered stable geometry");
        Check(!adapter.sessionLayoutHeld && table.contentOffset.y==128 && !table.offsetWrites && !table.reloads,@"safe recovery releases hold without viewport rebound or full reload");
        Check([ScrollState(adapter) isEqual:scrollBefore],@"safe recovery retains original scroll envelope and gesture availability");
    }

    adapter=FreshVisibility(NO);table=(id)adapter.table;[table layoutSubviews];NSArray *safe=table.captured;
    table.layouts=0;[FirstFrameAdapter prepareForListVisibility];CaptureBoundary();Record(@"already-safe-deliveries",adapter);
    Check(!privateAtFirstExposure && visibleAtFirstExposure==4 && [firstExposedGeometry isEqual:safe],@"already proven filtered visible cells remain immediately visible");
    Check(!table.layouts && !adapter.layoutRequests && !adapter.sessionLayoutHeld,@"safe previsibility check creates no content layout or refresh");

    adapter=FreshVisibility(YES);table=(id)adapter.table;[table layoutSubviews];table.layouts=0;
    [FirstFrameAdapter prepareForListVisibility];CaptureBoundary();
    Check(visibleAtFirstExposure==7 && !adapter.sessionLayoutHeld,@"unlocked visibility semantics remain unchanged");
    policy=Policy(@[@"private-person",@"private-group-A",@"private-group-B"],NO,3);
    RunBoundary(1);Record(@"unlocked-projection-expired-before-reveal",adapter);
    Check(!privateAtFirstExposure && !visibleAtFirstExposure && adapter.sessionLayoutHeld,@"unlock expiry shields the whole old row set before dismissal reveals it");

    adapter=FreshVisibility(YES);table=(id)adapter.table;[table layoutSubviews];table.layouts=0;
    __block NSUInteger reads=0;
    firstFrameSnapshotRead=^{if(++reads==2){policy=Policy(@[@"private-person",@"private-group-A",@"private-group-B"],NO,5);firstFrameSnapshotRead=nil;}};
    RunBoundary(0);Record(@"policy-changed-synchronously-in-gate",adapter);
    Check(reads>=2 && !privateAtFirstExposure && !visibleAtFirstExposure && adapter.sessionLayoutHeld,@"snapshot change within the previsibility check fails closed before original dismissal");

    adapter=FreshVisibility(NO);table=(id)adapter.table;[table layoutSubviews];table.layouts=0;
    reads=0;
    firstFrameSnapshotRead=^{if(++reads==2){account=@"other-visibility-account";epoch++;firstFrameSnapshotRead=nil;}};
    RunBoundary(2);Record(@"account-changed-synchronously-in-gate",adapter);
    Check(reads>=2 && !visibleAtFirstExposure && adapter.sessionLayoutHeld,@"account or epoch change inside gate neutralizes all former-account content");
    account=@"session-test-account";

    adapter=FreshVisibility(NO);table=(id)adapter.table;SeedNativeContent(adapter);
    policy=[[CSCloseFriendSnapshot alloc]initWithAccountID:account profile:@{} revealed:NO revision:90 blocked:YES];
    RunBoundary(0);Record(@"blocked-policy-before-reveal",adapter);
    Check(!visibleAtFirstExposure && adapter.sessionLayoutHeld,@"unknown blocked policy neutralizes existing native cells before visibility");

    adapter=FreshVisibility(NO);table=(id)adapter.table;SeedNativeContent(adapter);
    NSMutableDictionary *unknownOptions=[policy.options mutableCopy];unknownOptions[@"hideSessions"]=@"YES";[policy setValue:unknownOptions forKey:@"options"];
    RunBoundary(0);Record(@"unknown-option-previsibility",adapter);
    Check(!privateAtFirstExposure && !visibleAtFirstExposure && adapter.sessionLayoutHeld,@"unknown hideSessions option cannot authorize existing content at first visibility");
    adapter.publishing=YES;[table layoutSubviews];adapter.publishing=NO;[adapter finishPublicationFixture];[table layoutSubviews];CaptureBoundary();
    Record(@"unknown-option-during-and-after-publication",adapter);
    Check(!table.layouts && !privateAtFirstExposure && !visibleAtFirstExposure && adapter.sessionLayoutHeld,@"unknown option cannot bypass a visibility hold during publication or its finished release");
    policy=Policy(@[@"private-person",@"private-group-A",@"private-group-B"],NO,91);[adapter refresh];[table layoutSubviews];CaptureBoundary();
    Check(!privateAtFirstExposure && visibleAtFirstExposure==4 && !adapter.sessionLayoutHeld,@"known ready policy event safely restores content held for an unknown option");

    printf("Miniapp first frame: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
    return failures?1:0;
} }
