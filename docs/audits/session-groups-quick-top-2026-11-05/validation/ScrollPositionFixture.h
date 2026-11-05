// Full production Adapter refresh/viewport/lifecycle methods run above. This
// fixture substitutes only unavailable UIKit geometry, WeChat source and time.
#include "ScrollAPIs.h"
static void (^FixtureOnLifecycle)(id,NSString *);
static void FixtureLifecycleOriginal(id owner,NSString *name) {if(FixtureOnLifecycle)FixtureOnLifecycle(owner,name);}
#include "LifecycleCallbacks.h"
#include "ScrollInteractionBegin.h"
@interface ScrollDragHost:NSObject
@property(nonatomic) NSUInteger beginnings,tops;
@property(nonatomic) BOOL acceptsTop;
@property(nonatomic,copy) void (^onBegin)(void);
- (void)scrollViewWillBeginDragging:(id)scrollView;
- (BOOL)scrollViewShouldScrollToTop:(id)scrollView;
- (void)scrollViewDidScrollToTop:(id)scrollView;
- (void)scrollViewDidEndDragging:(id)scrollView willDecelerate:(BOOL)decelerate;
- (void)scrollViewDidEndDecelerating:(id)scrollView;
@end
@implementation ScrollDragHost
- (BOOL)scrollViewShouldScrollToTop:(id)scrollView {(void)scrollView;return self.acceptsTop;}
- (void)scrollViewDidScrollToTop:(id)scrollView {(void)scrollView;self.tops++;}
- (void)scrollViewWillBeginDragging:(id)scrollView {(void)scrollView;self.beginnings++;if(self.onBegin)self.onBegin();}
- (void)scrollViewDidEndDragging:(id)scrollView willDecelerate:(BOOL)decelerate {(void)scrollView;(void)decelerate;}
- (void)scrollViewDidEndDecelerating:(id)scrollView {(void)scrollView;}
@end
@class ScrollRig;
static void __attribute__((unused)) ScrollWillBeginDragging(ScrollRig *r);
static void __attribute__((unused)) ScrollStatusBarToTop(ScrollRig *r,BOOL accepted);
@interface ScrollRig:NSObject
@property(nonatomic,strong) NewMainFrameViewController *owner;
@property(nonatomic,strong) UITableView *table;
@property(nonatomic,strong) CSGroupListAdapter *adapter;
@end
@implementation ScrollRig @end
static void ScrollWillBeginDragging(ScrollRig *r) {
#if CS_SCROLL_APIS
    if(r.adapter.usesNativeSessionModel)FixtureDidBeginDragging(r.table);
    else {
        ScrollDragHost *host=[ScrollDragHost new];__weak CSGroupListAdapter *weak=r.adapter;
        host.onBegin=^{CHECK(!weak.presentationViewport && !weak.switchViewport);};
        NSInvocation *inv=[NSInvocation invocationWithMethodSignature:[host methodSignatureForSelector:@selector(scrollViewWillBeginDragging:)]];
        inv.selector=@selector(scrollViewWillBeginDragging:);id table=r.table;[inv setArgument:&table atIndex:2];
        [r.adapter forwardInvocation:inv target:host];CHECK(host.beginnings==1);
    }
#else
    (void)r;
#endif
}
static CGFloat ScrollHeight(ScrollRig *r) {return r.table.contentOffset.y+r.table.adjustedContentInset.top;}
static void ScrollAt(ScrollRig *r,CGFloat height) {
    r.table.contentOffset=CGPointMake(0,height-r.table.adjustedContentInset.top);
    [r.table.fixtureOffsetWrites removeAllObjects];
}
static BOOL __attribute__((unused)) ScrollNativeRejectedTop(id owner,SEL selector,id table) {(void)owner;(void)selector;(void)table;return NO;}
static void ScrollStatusBarToTop(ScrollRig *r,BOOL accepted) {
#if CS_SCROLL_APIS
    if(r.adapter.usesNativeSessionModel) {
        MainScrollToTopOriginal=accepted ? NULL : ScrollNativeRejectedTop;
        CHECK(MainScrollToTop(r.owner,@selector(scrollViewShouldScrollToTop:),r.table)==accepted);
        MainScrollToTopOriginal=NULL;
        if(accepted) {ScrollAt(r,0);FixtureDidScrollToTop(r.table);}
    } else {
        ScrollDragHost *host=[ScrollDragHost new];host.acceptsTop=accepted;
        NSInvocation *inv=[NSInvocation invocationWithMethodSignature:[host methodSignatureForSelector:@selector(scrollViewShouldScrollToTop:)]];
        inv.selector=@selector(scrollViewShouldScrollToTop:);id table=r.table;[inv setArgument:&table atIndex:2];
        [r.adapter forwardInvocation:inv target:host];BOOL result=NO;[inv getReturnValue:&result];CHECK(result==accepted);
        if(accepted) {
            ScrollAt(r,0);inv=[NSInvocation invocationWithMethodSignature:[host methodSignatureForSelector:@selector(scrollViewDidScrollToTop:)]];
            inv.selector=@selector(scrollViewDidScrollToTop:);[inv setArgument:&table atIndex:2];
            [r.adapter forwardInvocation:inv target:host];CHECK(host.tops==1);
        }
    }
#else
    (void)r;(void)accepted;
#endif
}
static void CheckHeight(ScrollRig *r,CGFloat expected) {
    if(fabs(ScrollHeight(r)-expected)>.01)fprintf(stderr,"Height mismatch native=%d selected=%s actual=%.3f expected=%.3f dirty=%d publishing=%d pendingGeo=%d\n",r.adapter.usesNativeSessionModel,r.adapter.publishedTabID.UTF8String,ScrollHeight(r),expected,r.adapter.dirty,r.adapter.publishing,r.table.fixtureGeometryPending);
    CHECK(fabs(ScrollHeight(r)-expected)<.01);
    for(NSDictionary *write in r.table.fixtureOffsetWrites)CHECK(![write[@"native"] boolValue]);
}
static ScrollRig *NewScrollRig(BOOL native) {
    FixtureOnLifecycle=nil;OnAdapterLayout=nil;FixtureJobs=[NSMutableArray array];FixturePanMoving=NO;FixtureMenuState=0;FixtureActive=YES;
    Account=@"validation-scroll-account";Policy=MakePolicy(@[],NO,NO,@{@"hideSessions":@NO},1);Suspended=NO;
    [Defaults setObject:@YES forKey:@"com.wechat.enhance.chat_group.enabled"];
    Select(@"preset_0");
    NSMutableArray *sessions=[NSMutableArray array];
    for(NSUInteger i=0;i<200;i++) {
        NSString *name=i<80 ? [NSString stringWithFormat:@"scroll-%lu@chatroom",(unsigned long)i] :
            (i<197 ? [NSString stringWithFormat:@"scroll-%lu",(unsigned long)i] : [NSString stringWithFormat:@"gh_scroll_%lu",(unsigned long)i]);
        [sessions addObject:Session(name,1)];
    }
    Main=[MainSessionMgr new];Main.hostTop=@[];Main.hostNormal=sessions;Main.hostAllTop=@[];Main.hostTotal=0;
    Full->m_arrSession=sessions;Folded.chatBoxSessions=@[];
    ScrollRig *r=[ScrollRig new];r.owner=[NewMainFrameViewController new];r.table=[UITableView new];r.owner.m_tableView=r.table;
    r.table.bounds=CGRectMake(0,0,390,600);r.table.adjustedContentInset=UIEdgeInsetsMake(100,0,30,0);
    r.table.fixtureDeferredGeometry=YES;r.table.fixtureRowHeight=44;
    FixtureMainFrameLogic *logic=[FixtureMainFrameLogic new];logic.useManager=native;logic.fixtureSessions=@[sessions];r.owner.m_mainFrameLogicController=logic;
    FixtureMainFrameDataSource *source=[FixtureMainFrameDataSource new];source.logic=logic;r.table.dataSource=source;
    if(native) {
        [Coordinator setMainController:r.owner];[Main rebuildMainSessions];[CSGroupListAdapter attachToController:r.owner];
        r.adapter=[CSGroupListAdapter adapterForController:r.owner];
    } else {
        CSGroupListAdapter *a;
        if(getenv("WECHAT_QUICK_TOP_ONLY")) {
            [Coordinator useCompatibilityFallback];[CSGroupListAdapter attachToController:r.owner];
            a=[CSGroupListAdapter adapterForController:r.owner];
        } else {a=[CSGroupListAdapter new];a.controller=r.owner;a.table=r.table;}
        r.adapter=a;
        a.anchors=[NSMutableDictionary dictionary];a.proxies=[NSMutableDictionary dictionary];a.nativeActions=[NSMutableArray array];
        a.completions=[NSMutableArray array];a.prefetchedPaths=[NSMutableSet set];a.fixtureRealCompatibilityRefresh=YES;
        a.fixtureRealCompatSource=YES;a.privacyShield=[CSCloseFriendListShield new];
        objc_setAssociatedObject(r.owner,&AdapterKey,a,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(r.table,&AdapterKey,a,OBJC_ASSOCIATION_RETAIN_NONATOMIC);[Adapters() addObject:a];
    }
    r.adapter.fixtureRealScroll=YES;r.adapter.fixtureRealNotifications=YES;
    [r.adapter refresh];[r.table reloadData];[r.table layoutIfNeeded];
    CHECK(r.adapter.projection.isValid && r.adapter.projecting && r.adapter.chromeVisible);
    CHECK([r.adapter.publishedTabID isEqual:@"preset_0"] && !r.adapter.dirty && !r.adapter.publishing);
    CHECK(r.table.contentSize.height==8800);
    ScrollAt(r,900);return r;
}
static void ScrollPositionTests(void) {
    for(NSUInteger mode=0;mode<2;mode++) {
        ScrollRig *r=NewScrollRig(mode==0);CSGroupListAdapter *a=r.adapter;
        const char *probe=getenv("WECHAT_SCROLL_PROBE");
        if(probe && strcmp(probe,"return")==0) {
            ScrollAt(r,1250);Fixture_viewWillDisappear(r.owner);r.table.contentOffset=CGPointMake(0,-100);
            Fixture_viewDidDisappear(r.owner);Fixture_viewWillAppear(r.owner);Fixture_viewDidAppear(r.owner);
            CheckHeight(r,1250);continue;
        }
        // A -> B -> A shares the height immediately before each switch. The
        // second switch must not reuse an old per-group saved row anchor.
        [a selectIndex:1];CheckHeight(r,900);CHECK([a.publishedTabID isEqual:@"preset_1"]);
        ScrollAt(r,1400);[a selectIndex:0];CheckHeight(r,1400);
        [a selectIndex:0];CheckHeight(r,1400);CHECK(a.chromeVisible);
        // Returning from chat preserves departure height through both native
        // will/didAppear resets and repeated suspended callbacks.
        ScrollAt(r,1250);Fixture_viewWillDisappear(r.owner);
        CHECK(a.presentationSuspended);r.table.contentOffset=CGPointMake(0,-100);
        Fixture_viewDidDisappear(r.owner);Fixture_viewWillAppear(r.owner);
        FixtureOnLifecycle=^(id owner,NSString *name) {
            if([name isEqual:@"viewDidAppear"]){UITableView *table=[owner m_tableView];table.contentOffset=CGPointMake(0,-table.adjustedContentInset.top);}
        };
        Fixture_viewDidAppear(r.owner);FixtureOnLifecycle=nil;CheckHeight(r,1250);
        CHECK(!a.presentationSuspended);
#if CS_SCROLL_APIS
        CHECK(!a.presentationViewport && !a.presentationReturnFinished);
#endif
        // A shorter target clamps to its current valid range; switching back
        // shares this clamped height instead of remembering the former 1250.
        ScrollAt(r,1250);[a selectIndex:3];CheckHeight(r,0);
        CHECK([a.publishedTabID isEqual:@"preset_3"]);
        [a selectIndex:0];CheckHeight(r,0);
        // Ordinary same-group reordering retains the visible row anchor. This
        // behavior deliberately differs from sharing a height across groups.
        ScrollAt(r,1000);[a beginNativeChangeOfKind:CSGroupChangeStructure changedUserNames:nil];
        NSArray *original=mode==0 ? Main.hostNormal : [(FixtureMainFrameLogic *)r.owner.m_mainFrameLogicController fixtureSessions][0];
        NSMutableArray *reordered=[original mutableCopy];id last=reordered.lastObject;[reordered removeLastObject];[reordered insertObject:last atIndex:0];
        if(mode==0) {Main.hostNormal=reordered;Full->m_arrSession=reordered;[Main rebuildMainSessions];}
        else [(FixtureMainFrameLogic *)r.owner.m_mainFrameLogicController setFixtureSessions:@[reordered]];
        [a endNativeChange];[a refresh];[a cancelScheduledRefresh];CheckHeight(r,1044);
#if CS_SCROLL_APIS
        CHECK(!a.presentationViewport && !a.switchViewport);
#endif
#if CS_SCROLL_APIS
        // Geometry is pending across reload until layout. A zero viewport must
        // retain the request and perform no write; the next real layout retries.
        ScrollAt(r,750);r.table.fixtureHoldLayout=YES;__weak UITableView *weakTable=r.table;
        r.table.onReload=^{weakTable.bounds=CGRectMake(0,0,390,0);};
        [a selectIndex:1];CHECK(a.switchViewport && r.table.fixtureGeometryPending);
        CHECK(r.table.fixtureOffsetWrites.count==0);
        r.table.bounds=CGRectMake(0,0,390,600);r.table.fixtureHoldLayout=NO;
        [r.table layoutIfNeeded];[CSGroupListAdapter layoutForController:r.owner];CheckHeight(r,750);
        CHECK(!a.switchViewport);
        // Two queued selections replace the target without adopting any old
        // per-tab anchor; no UI publication is allowed while the batch is open.
        ScrollAt(r,920);a.publishing=YES;[a selectIndex:0];[a selectIndex:2];
        CHECK(a.switchViewport && [a.switchViewport[@"targetTab"] isEqual:@"preset_2"]);
        a.publishing=NO;[a refresh];CheckHeight(r,920);CHECK([a.publishedTabID isEqual:@"preset_2"]);
        [a cancelScheduledRefresh];
        // Host changes inset during return, leaving the old -top offset behind.
        // There is no touch/bounce: saved effective height must survive it.
        ScrollAt(r,1100);Fixture_viewWillDisappear(r.owner);r.table.contentOffset=CGPointMake(0,-100);
        r.table.adjustedContentInset=UIEdgeInsetsMake(60,0,20,0);
        Fixture_viewWillAppear(r.owner);Fixture_viewDidAppear(r.owner);CheckHeight(r,1100);
        CHECK(!a.presentationViewport);
        // Recovery remains pending through transient invalid geometry/insets.
        ScrollAt(r,800);Fixture_viewWillDisappear(r.owner);Fixture_viewWillAppear(r.owner);
        r.table.contentSize=CGSizeMake(390,NAN);Fixture_viewDidAppear(r.owner);
        CHECK(a.presentationViewport && a.presentationReturnFinished);
        r.table.fixtureGeometryPending=YES;[r.table layoutIfNeeded];[a layout];CheckHeight(r,800);
        CHECK(!a.presentationViewport);
        // A real vertical user drag supersedes both return and explicit top.
        ScrollAt(r,700);Fixture_viewWillDisappear(r.owner);Fixture_viewWillAppear(r.owner);
        CHECK(a.presentationViewport);ScrollWillBeginDragging(r);
        CHECK(!a.presentationViewport && !a.switchViewport);
        ScrollAt(r,333);Fixture_viewDidAppear(r.owner);CheckHeight(r,333);
        // Interaction gates retain a pending restore without polling or pulling
        // the table. A genuine interaction-end/layout event wakes it once.
        ScrollAt(r,870);Fixture_viewWillDisappear(r.owner);Fixture_viewWillAppear(r.owner);
        r.table.dragging=YES;ScrollAt(r,240);Fixture_viewDidAppear(r.owner);
        CHECK(a.presentationViewport);CheckHeight(r,240);
        NSUInteger enqueued=FixtureJobsEnqueued;Advance(5);CHECK(FixtureJobsEnqueued==enqueued);
        r.table.dragging=NO;[a layout];CheckHeight(r,870);CHECK(!a.presentationViewport);
        // Explicit top is a newer positioning command than a pending return.
        ScrollAt(r,640);Fixture_viewWillDisappear(r.owner);Fixture_viewWillAppear(r.owner);
        ScrollStatusBarToTop(r,YES);Fixture_viewDidAppear(r.owner);CheckHeight(r,0);
        CHECK(!a.presentationViewport && !a.switchViewport);
        ScrollAt(r,650);Fixture_viewWillDisappear(r.owner);Fixture_viewWillAppear(r.owner);
        ScrollStatusBarToTop(r,NO);CHECK(a.presentationViewport);Fixture_viewDidAppear(r.owner);CheckHeight(r,650);
        // Native search and native navigation cancel stale group positioning.
        ScrollAt(r,680);Fixture_viewWillDisappear(r.owner);Fixture_viewWillAppear(r.owner);
        [a prepareForNativeSearch];CHECK(!a.presentationViewport && !a.switchViewport && a.searching);
        r.owner.isSearching=NO;a.searching=NO;[a refresh];
        ScrollAt(r,670);Fixture_viewWillDisappear(r.owner);Fixture_viewWillAppear(r.owner);
        __block NSUInteger nativeActions=0;[a performInNativePresentation:^{nativeActions++;}];
        CHECK(!a.presentationViewport && !a.switchViewport && nativeActions==1);
        // A fresh group selection re-enters grouping after native navigation.
        [a selectIndex:0];CHECK(a.projecting && !a.nativePresentation);
        // A callback re-entering restore from setContentOffset cannot recurse.
        ScrollAt(r,760);Fixture_viewWillDisappear(r.owner);Fixture_viewWillAppear(r.owner);
        ScrollAt(r,0);__weak CSGroupListAdapter *weak=a;
        r.table.fixtureOnOffset=^{[weak restorePendingViewport];};Fixture_viewDidAppear(r.owner);
        CheckHeight(r,760);CHECK(r.table.fixtureOffsetWrites.count==1 && !a.restoringViewport);
        // A blocked privacy publication retains the height until a current,
        // valid projection exists; the final restoration uses current insets.
        ScrollAt(r,780);Fixture_viewWillDisappear(r.owner);Fixture_viewWillAppear(r.owner);
        a.privacyRefreshPending=YES;ScrollAt(r,0);Fixture_viewDidAppear(r.owner);
        CHECK(a.presentationViewport);CheckHeight(r,0);
        a.privacyRefreshPending=NO;[a layout];CheckHeight(r,780);CHECK(!a.presentationViewport);
        // A synchronous host callback may overwrite the requested offset
        // without changing the model. Such a write is not successful delivery.
        ScrollAt(r,840);Fixture_viewWillDisappear(r.owner);Fixture_viewWillAppear(r.owner);ScrollAt(r,0);
        __weak ScrollRig *weakRig=r;
        r.table.fixtureOnOffset=^{weakRig.table.contentOffset=CGPointMake(0,111-weakRig.table.adjustedContentInset.top);};
        [CSGroupListAdapter finishPresentationReturnForController:r.owner];CheckHeight(r,111);CHECK(a.presentationViewport);
        [a layout];CheckHeight(r,840);CHECK(!a.presentationViewport);
        // Insets can change inside the same write, leaving a different effective
        // height. Retain and recompute against the new inset on the next layout.
        ScrollAt(r,860);Fixture_viewWillDisappear(r.owner);Fixture_viewWillAppear(r.owner);ScrollAt(r,0);
        r.table.fixtureOnOffset=^{weakRig.table.adjustedContentInset=UIEdgeInsetsMake(70,0,20,0);};
        [CSGroupListAdapter finishPresentationReturnForController:r.owner];CHECK(a.presentationViewport);[a layout];CheckHeight(r,860);CHECK(!a.presentationViewport);
        // Native owners can replace their table synchronously. The old table's
        // successful write must not consume the new table's pending restoration.
        ScrollAt(r,880);Fixture_viewWillDisappear(r.owner);Fixture_viewWillAppear(r.owner);ScrollAt(r,0);
        r.table.fixtureOnOffset=^{
            UITableView *old=weakRig.table,*replacement=[UITableView new];replacement.dataSource=old.dataSource;replacement.delegate=old.delegate;
            replacement.bounds=old.bounds;replacement.adjustedContentInset=old.adjustedContentInset;replacement.contentSize=old.contentSize;
            replacement.fixtureDeferredGeometry=YES;replacement.fixtureRowHeight=44;replacement.fixtureGeometryCounts=old.fixtureGeometryCounts;
            replacement.contentOffset=CGPointMake(0,-replacement.adjustedContentInset.top);
            weakRig.table=replacement;weakRig.owner.m_tableView=replacement;weak.table=replacement;
            objc_setAssociatedObject(replacement,&AdapterKey,weak,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        };
        [CSGroupListAdapter finishPresentationReturnForController:r.owner];CHECK(a.presentationViewport);CheckHeight(r,0);
        [a layout];CheckHeight(r,880);CHECK(!a.presentationViewport);
        // Horizontal swipe completion may still report tracking while the
        // recognizer has ended. Capture current height before deferring publish.
        ScrollAt(r,970);r.table.tracking=YES;[a selectIndex:1];CHECK(a.switchViewport);
        r.table.tracking=NO;[a nativeMenuDidChange];[a refresh];CheckHeight(r,970);
        CHECK([a.publishedTabID isEqual:@"preset_1"] && !a.switchViewport);
        // Settings can delete a queued target before it publishes. Only a
        // successful fallback publication may bind the same height to All.
        NSMutableArray *members=[NSMutableArray array];for(id session in Main.hostNormal)[members addObject:[session m_nsUserName]];
        if(mode==1) { [members removeAllObjects];for(id session in [(FixtureMainFrameLogic *)r.owner.m_mainFrameLogicController fixtureSessions][0])[members addObject:[session m_nsUserName]]; }
        WESessionTabItem *custom=[WESessionTabItem customTabWithName:@"delete-pending" sessionUserNames:members];custom.tabId=@"scroll-delete-target";
        CHECK([a.preferences saveCustomTabs:@[custom] presetNames:@{} tabOrder:@[] hiddenPresetTabs:NSSet.set]);[a refresh];
        NSInteger customIndex=NSNotFound;for(NSUInteger i=0;i<a.displayedTabs.count;i++)if([a.displayedTabs[i].tabId isEqual:custom.tabId])customIndex=(NSInteger)i;
        CHECK(customIndex!=NSNotFound);ScrollAt(r,600);r.table.tracking=YES;[a selectIndex:customIndex];
        CHECK(a.switchViewport && [a.switchViewport[@"targetTab"] isEqual:custom.tabId]);
        CHECK([a.preferences saveCustomTabs:@[] presetNames:@{} tabOrder:@[] hiddenPresetTabs:NSSet.set]);
        [a restorePendingViewport];CHECK([a.switchViewport[@"targetTab"] isEqual:custom.tabId]);
        r.table.tracking=NO;[a refresh];CheckHeight(r,600);
        if(![a.publishedTabID isEqual:@"preset_0"] || a.switchViewport)fprintf(stderr,"deleted target mode=%lu selected=%s pref=%s pending=%s dirty=%d\n",(unsigned long)mode,a.publishedTabID.UTF8String,a.preferences.selectedTabID.UTF8String,[a.switchViewport description].UTF8String,a.dirty);
        CHECK([a.publishedTabID isEqual:@"preset_0"] && !a.switchViewport);
        [a saveAnchor];CHECK(a.anchors[a.publishedTabID]);
        // The actual preferences setter rejects a future-schema selection
        // record. A rejected switch cannot leave an unreachable target pending.
        NSString *selectionKey=[@"com.wechat.enhance.chat_group.selection." stringByAppendingString:Account];
        id savedSelection=Defaults.memory[selectionKey];Defaults.memory[selectionKey]=@{@"version":@2,@"tabID":@"preset_0"};
        [a.preferences reload];ScrollAt(r,620);[a selectIndex:1];CheckHeight(r,620);
        CHECK([a.preferences.selectedTabID isEqual:@"preset_0"] && [a.publishedTabID isEqual:@"preset_0"]);
        CHECK([a.chrome.selectedTabID isEqual:@"preset_0"] && !a.switchViewport);
        [a saveAnchor];CHECK(a.anchors[a.publishedTabID]);
        if(savedSelection)Defaults.memory[selectionKey]=savedSelection;else [Defaults.memory removeObjectForKey:selectionKey];[a refresh];
        // Pull-to-bounce positions are owned by UIKit. They never become a
        // pending return height, and leave without a plugin offset write.
        ScrollAt(r,-20);Fixture_viewWillDisappear(r.owner);CHECK(!a.presentationViewport);
        CHECK(r.table.fixtureOffsetWrites.count==0);Fixture_viewWillAppear(r.owner);Fixture_viewDidAppear(r.owner);
        // Account/epoch changes invalidate every pending old-account height.
        ScrollAt(r,790);Fixture_viewWillDisappear(r.owner);Fixture_viewWillAppear(r.owner);
        Epoch++;ScrollAt(r,0);[a restorePendingViewport];CHECK(!a.presentationViewport && !a.switchViewport);CheckHeight(r,0);
        [a refresh];
        ScrollAt(r,820);Fixture_viewDidAppear(r.owner);Fixture_viewWillDisappear(r.owner);Fixture_viewWillAppear(r.owner);
        CHECK(a.presentationViewport);NSString *savedAccount=Account;Account=@"another-scroll-account";
        ScrollAt(r,0);[a restorePendingViewport];CHECK(!a.presentationViewport && !a.switchViewport);CheckHeight(r,0);Account=savedAccount;
#endif
        [a cancelScheduledRefresh];[Adapters() removeObject:a];
    }
}
