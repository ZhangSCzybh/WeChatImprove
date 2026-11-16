#import <Foundation/Foundation.h>
#import <objc/message.h>
#import <objc/runtime.h>
#import "CSCloseFriendPolicy.h"
#import "CSCloseFriendSignatures.h"
#import "CSCloseFriendUnreadPanelAdapter.h"

// Foundation host boundaries represent native WeChat aggregation and UIKit.
// Production bridge reads, surface ownership/visibility, adapter and hook bodies
// are extracted unchanged by verify-close-friend-unread-panel.sh.
static NSUInteger Checks, Failures, Epoch=31, Revision=1;
static NSString *CaseName, *CurrentAccount=@"panel-account";
static CSCloseFriendSnapshot *Current;
static void (^NativeCellCallback)(void),(^NativeDeselectCallback)(void);
static NSMutableDictionary<NSString *,NSNumber *> *Capabilities;
static NSString *const CSCloseFriendPolicyDidChangeNotification=@"UnreadPanelPolicyChanged";
static NSUInteger CSCloseFriendAccountEpoch(void) { return Epoch; }
static CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) { return Current; }
static void CSCloseFriendRecordCapability(NSString *name,BOOL available) { Capabilities[name]=@(available); }
static void MSHookMessageEx(Class cls,SEL selector,IMP replacement,IMP *original) {
    Method method=class_getInstanceMethod(cls,selector);
    *original=method_getImplementation(method);
    class_replaceMethod(cls,selector,replacement,method_getTypeEncoding(method));
}
#include "UnreadPanelBridge.inc"

typedef NS_ENUM(NSInteger,UIApplicationState) { UIApplicationStateActive,UIApplicationStateInactive,UIApplicationStateBackground };
@interface UIApplication : NSObject
@property(nonatomic) UIApplicationState applicationState;
+ (instancetype)sharedApplication;
@end
@implementation UIApplication
+ (instancetype)sharedApplication { static UIApplication *app; static dispatch_once_t once; dispatch_once(&once,^{app=[self new];}); return app; }
@end
@interface UIView : NSObject
@property(nonatomic,weak) id window;
@property(nonatomic,getter=isHidden) BOOL hidden;
@property(nonatomic,strong) NSMutableArray *subviews;
@property(nonatomic,weak) UIView *superview;
@property(nonatomic) NSUInteger layouts;
- (void)didMoveToWindow;
- (void)removeFromSuperview;
- (void)layoutIfNeeded;
- (void)addSubview:(UIView *)view;
@end
@implementation UIView
- (instancetype)init { if((self=[super init]))self.subviews=[NSMutableArray array];return self; }
- (void)didMoveToWindow {}
- (void)removeFromSuperview { [self.superview.subviews removeObjectIdenticalTo:self];self.superview=nil; }
- (void)layoutIfNeeded { self.layouts++; }
- (void)addSubview:(UIView *)view { [self.subviews addObject:view];view.superview=self; }
@end
@interface UIImageView : UIView
@property(nonatomic,strong) id image;
@end
@implementation UIImageView @end
@interface UIViewController : NSObject
@property(nonatomic,strong) UIView *view;
@property(nonatomic) BOOL isViewLoaded;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)viewDidDisappear:(BOOL)animated;
- (void)viewDidLoad;
@end
@implementation UIViewController
- (instancetype)init { if((self=[super init])) { self.view=[UIView new];self.isViewLoaded=YES; } return self; }
- (void)viewWillAppear:(BOOL)animated { (void)animated;self.view.window=self; }
- (void)viewDidAppear:(BOOL)animated { (void)animated; }
- (void)viewWillDisappear:(BOOL)animated { (void)animated; }
- (void)viewDidDisappear:(BOOL)animated { (void)animated;self.view.window=nil; }
- (void)viewDidLoad {}
@end
#include "UnreadPanelSurface.inc"

@interface NSIndexPath (UnreadPanelFixture)
@property(nonatomic,readonly) NSInteger row;
+ (instancetype)indexPathForRow:(NSInteger)row inSection:(NSInteger)section;
@end
@implementation NSIndexPath (UnreadPanelFixture)
- (NSInteger)row { return (NSInteger)[self indexAtPosition:1]; }
+ (instancetype)indexPathForRow:(NSInteger)row inSection:(NSInteger)section { NSUInteger indexes[]={(NSUInteger)section,(NSUInteger)row};return [self indexPathWithIndexes:indexes length:2]; }
@end
@interface UITableView : UIView
@property(nonatomic) NSUInteger reloads;
- (void)reloadData;
- (void)deselectRowAtIndexPath:(NSIndexPath *)path animated:(BOOL)animated;
@end
@implementation UITableView
- (void)reloadData { self.reloads++; }
- (void)deselectRowAtIndexPath:(NSIndexPath *)path animated:(BOOL)animated { (void)path;(void)animated;void(^callback)(void)=NativeDeselectCallback;NativeDeselectCallback=nil;if(callback)callback(); }
@end

@interface PanelSession : NSObject
@property(nonatomic,copy) NSString *m_nsUserName;
@property(nonatomic) unsigned int m_uUnReadCount;
@property(nonatomic) BOOL m_bShowUnReadAsRedDot,isHidden,isInChatBox,isInBrandServiceBox,m_isFolding;
@property(nonatomic) BOOL retained;
- (BOOL)canShowInMainFrame;
@end
@implementation PanelSession
- (BOOL)canShowInMainFrame { return !self.isHidden && !self.isInChatBox && !self.isInBrandServiceBox && !self.m_isFolding; }
@end
@interface WrongUnreadSession : NSObject
@property(nonatomic,copy) NSString *m_nsUserName;
@property(nonatomic) NSUInteger reads;
@property(nonatomic) BOOL m_bShowUnReadAsRedDot,isHidden,isInChatBox,isInBrandServiceBox,m_isFolding;
- (id)m_uUnReadCount;
@end
@implementation WrongUnreadSession
- (id)m_uUnReadCount { self.reads++;return @99; }
@end
@interface PanelCell : UIView
@property(nonatomic,strong) PanelSession *session;
@end
@implementation PanelCell @end
@interface MainSessionMgr : NSObject
@property(nonatomic,strong) NSMutableArray<PanelSession *> *fullSessions;
@property(nonatomic,copy) NSArray<PanelSession *> *selectedSessions;
@property(nonatomic) NSUInteger completeSourceDepth;
@property(nonatomic) CSCloseFriendSurface completeSourceSurface;
@property(nonatomic) NSUInteger enumerations;
@property(nonatomic,copy) void (^onEnumerate)(void);
- (NSEnumerator *)visibleSessionEnumerator;
@end
@implementation MainSessionMgr
- (NSEnumerator *)visibleSessionEnumerator {
    self.enumerations++;if(self.onEnumerate)self.onEnumerate();
    // The native manager owns main-frame source eligibility. The panel's own
    // canShowSession method below does not read these flags.
    NSMutableArray *visible=[NSMutableArray array];
    NSArray *source=self.completeSourceDepth ? self.fullSessions : (self.selectedSessions ?: self.fullSessions);
    for(PanelSession *session in source) {
        BOOL concealed=self.completeSourceDepth && [Current hidesUserName:session.m_nsUserName surface:self.completeSourceSurface];
        if([session canShowInMainFrame] && !concealed)[visible addObject:session];
    }
    return visible.objectEnumerator;
}
@end
static MainSessionMgr *Manager;

// This fixture owns only the coordinator's synchronous complete-source contract.
// Group model/array publication is covered by the coordinator's own native tests.
// Unlike an always-successful shim, unavailable or unstable reads are rejected;
// nested same-surface readers share one scope and every exit restores grouping.
@interface CSGroupNativeSessionCoordinator : NSObject
@property(nonatomic) BOOL sourceAvailable,nativeTransactionActive;
@property(nonatomic) NSUInteger scopes,restorations,depth,scopeEpoch,scopeRevision;
@property(nonatomic) CSCloseFriendSurface scopeSurface;
@property(nonatomic,copy) NSString *scopeAccount;
@property(nonatomic,weak) MainSessionMgr *scopeManager;
+ (instancetype)sharedCoordinator;
- (BOOL)performWithCompleteSourceForSurface:(CSCloseFriendSurface)surface original:(void (^)(void))original;
@end
@implementation CSGroupNativeSessionCoordinator
+ (instancetype)sharedCoordinator {
    static CSGroupNativeSessionCoordinator *coordinator;static dispatch_once_t once;
    dispatch_once(&once,^{coordinator=[self new];coordinator.sourceAvailable=YES;});return coordinator;
}
- (BOOL)scopeIsCurrent {
    return self.sourceAvailable && !self.nativeTransactionActive && Manager==self.scopeManager &&
        Epoch==self.scopeEpoch && Current.revision==self.scopeRevision && !Current.blocked &&
        [CurrentAccount isEqual:self.scopeAccount] && [Current.accountID isEqual:self.scopeAccount];
}
- (BOOL)performWithCompleteSourceForSurface:(CSCloseFriendSurface)surface original:(void (^)(void))original {
    if(!NSThread.isMainThread || !original || !Manager || !self.sourceAvailable || self.nativeTransactionActive ||
       (surface!=CSCloseFriendSurfaceSession && surface!=CSCloseFriendSurfaceForward) ||
       Current.blocked || !CurrentAccount.length || ![Current.accountID isEqual:CurrentAccount])return NO;
    if(self.depth) {
        if(surface!=self.scopeSurface || ![self scopeIsCurrent])return NO;
        original();return [self scopeIsCurrent];
    }
    self.scopeManager=Manager;self.scopeAccount=CurrentAccount;self.scopeEpoch=Epoch;
    self.scopeRevision=Current.revision;self.scopeSurface=surface;self.depth=1;self.scopes++;
    MainSessionMgr *manager=Manager;NSUInteger previousDepth=manager.completeSourceDepth;
    CSCloseFriendSurface previousSurface=manager.completeSourceSurface;
    manager.completeSourceDepth=previousDepth+1;manager.completeSourceSurface=surface;
    BOOL accepted=NO;
    @try {original();accepted=[self scopeIsCurrent];}
    @finally {
        manager.completeSourceDepth=previousDepth;manager.completeSourceSurface=previousSurface;
        self.depth=0;self.scopeManager=nil;self.scopeAccount=nil;self.restorations++;
    }
    return accepted;
}
@end
static NSInteger NativeNotifyCount;
#ifdef CS_UNREAD_PANEL_ABI
typedef NSInteger NativePredicateResult;
typedef unsigned int NativeCountResult;
#else
typedef BOOL NativePredicateResult;
typedef NSInteger NativeCountResult;
#endif

@interface MainFrameAggregationLogic : NSObject
@property(nonatomic,weak) id delegate;
@property(nonatomic,strong) NSMutableArray<PanelSession *> *sessionList,*reloadingList;
@property(nonatomic,strong) NSMutableSet *sessionSet;
@property(nonatomic,strong) NSSet *initalSessionSet;
@property(nonatomic) NSUInteger rebuilds,handles,nativeAllows;
@property(nonatomic) NSUInteger readMutations;
@property(nonatomic,copy) void (^onCurrentListRead)(void);
- (NSArray *)currentSessionList;
- (PanelSession *)sessionAtIndex:(NSInteger)index;
- (NSInteger)sessionCount;
- (NativeCountResult)notifySessionCount;
- (NativePredicateResult)canShowSession:(PanelSession *)session;
- (void)rebuildSessionList;
- (void)onMainFrameBeginReload;
- (void)onMainFrameHandleSession:(PanelSession *)session;
- (void)onMainFrameEndReload;
- (void)changeReadStatusAtIndex:(NSInteger)index;
@end
@implementation MainFrameAggregationLogic
- (instancetype)init {
    if((self=[super init])) {
        self.sessionSet=[NSMutableSet set];
        for(PanelSession *session in Manager.fullSessions)if(session.retained)[self.sessionSet addObject:session.m_nsUserName];
        self.initalSessionSet=[self.sessionSet copy];[self rebuildSessionList];
    }
    return self;
}
- (NSArray *)currentSessionList { void(^callback)(void)=self.onCurrentListRead;self.onCurrentListRead=nil;if(callback)callback();return [self.sessionList copy]; }
- (PanelSession *)sessionAtIndex:(NSInteger)index { return index>=0 && index<(NSInteger)self.sessionList.count ? self.sessionList[(NSUInteger)index] : nil; }
- (NSInteger)sessionCount { return (NSInteger)self.sessionList.count; }
- (NativePredicateResult)canShowSession:(PanelSession *)session {
    self.nativeAllows++;
    // Native 8.0.78: membership is checked first, so a retained row may remain
    // after being read or switching to dot mode. Native eligibility is upstream.
    if([self.sessionSet containsObject:session.m_nsUserName])return YES;
    return !session.m_bShowUnReadAsRedDot && session.m_uUnReadCount>0;
}
- (NativeCountResult)notifySessionCount { return (NativeCountResult)NativeNotifyCount; } // Native MMNewSessionMgr global count, independent of the panel buffer.
- (void)rebuildSessionList {
    self.rebuilds++;self.sessionList=[NSMutableArray array];
    for(PanelSession *session in [Manager visibleSessionEnumerator])
        if([self canShowSession:session]) { [self.sessionList addObject:session];[self.sessionSet addObject:session.m_nsUserName]; }
}
- (void)onMainFrameBeginReload { self.sessionList=[NSMutableArray array]; }
- (void)onMainFrameHandleSession:(PanelSession *)session { self.handles++;if([session canShowInMainFrame] && [self canShowSession:session]) { [self.sessionList addObject:session];[self.sessionSet addObject:session.m_nsUserName]; } }
- (void)onMainFrameEndReload { if([self.delegate respondsToSelector:@selector(onSessionListChange)])((void(*)(id,SEL))objc_msgSend)(self.delegate,@selector(onSessionListChange)); }
- (void)changeReadStatusAtIndex:(NSInteger)index { PanelSession *s=[self sessionAtIndex:index];if(s) { self.readMutations++;s.m_uUnReadCount=0; } }
@end

@interface NewMainFrameViewController : UIViewController
@property(nonatomic,strong) PanelSession *opened;
@property(nonatomic) NSUInteger opens;
- (void)onAggregation:(id)aggregation openSession:(PanelSession *)session;
- (void)onLogicOpenSession:(PanelSession *)session;
@end
@implementation NewMainFrameViewController
- (void)onAggregation:(id)aggregation openSession:(PanelSession *)session { (void)aggregation;[self onLogicOpenSession:session]; }
- (void)onLogicOpenSession:(PanelSession *)session { self.opens++;self.opened=session; }
@end
@interface PanelTransition : NSObject
@property(nonatomic,strong) UIImageView *fromSnapshtoView;
@end
@implementation PanelTransition @end
@interface MainFrameAggregationViewController : UIViewController
@property(nonatomic,strong) MainFrameAggregationLogic *dataLogic;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,weak) NewMainFrameViewController *delegate;
@property(nonatomic) BOOL isTransitioning,needReloadAfterTransition;
@property(nonatomic) NSUInteger reloads;
@property(nonatomic,strong) UIView *tableContainerView;
@property(nonatomic,strong) PanelTransition *transition;
@property(nonatomic) NSInteger bottomTitleCount;
- (void)reloadView;
- (void)updateContent;
- (void)onSessionListChange;
- (id)tableView:(id)table cellForRowAtIndexPath:(NSIndexPath *)path;
- (void)tableView:(id)table didSelectRowAtIndexPath:(NSIndexPath *)path;
- (void)tableView:(id)table commitEditingStyle:(NSInteger)style forRowAtIndexPath:(NSIndexPath *)path;
- (void)onPushTransitionWillBegin;
- (void)onPushTransitionEnd;
@end
@implementation MainFrameAggregationViewController
- (instancetype)init { if((self=[super init])) { self.tableView=[UITableView new];self.tableContainerView=[UIView new];self.dataLogic=[MainFrameAggregationLogic new];self.dataLogic.delegate=self; } return self; }
- (void)reloadView { self.reloads++;[self.tableView reloadData]; }
- (void)updateContent { [self reloadView];self.bottomTitleCount=self.dataLogic.notifySessionCount;[self.view layoutIfNeeded]; }
- (void)onSessionListChange { if(self.isTransitioning)self.needReloadAfterTransition=YES;else[self updateContent]; }
- (id)tableView:(id)table cellForRowAtIndexPath:(NSIndexPath *)path {
    (void)table;PanelCell *cell=[PanelCell new];cell.session=[self.dataLogic sessionAtIndex:path.row];
    void(^callback)(void)=NativeCellCallback;NativeCellCallback=nil;if(callback)callback();return cell;
}
- (void)tableView:(id)table didSelectRowAtIndexPath:(NSIndexPath *)path { [table deselectRowAtIndexPath:path animated:NO];PanelSession *session=[self.dataLogic sessionAtIndex:path.row];if(session)[self.delegate onAggregation:self openSession:session]; }
- (void)tableView:(id)table commitEditingStyle:(NSInteger)style forRowAtIndexPath:(NSIndexPath *)path { (void)table;(void)style;[self.dataLogic changeReadStatusAtIndex:path.row]; }
- (void)onPushTransitionWillBegin { self.isTransitioning=YES; }
- (void)onPushTransitionEnd { self.isTransitioning=NO;if(self.needReloadAfterTransition) { self.needReloadAfterTransition=NO;[self updateContent]; } }
@end

#include "UnreadPanelAdapter.inc"
#include "UnreadPanelHooks.inc"

#define CHECK(...) do { Checks++;if(!(__VA_ARGS__)) { Failures++;fprintf(stderr,"FAIL %d [%s]: %s\n",__LINE__,CaseName.UTF8String,#__VA_ARGS__); } } while(0)
static PanelSession *Session(NSString *name,unsigned int unread) { PanelSession *s=[PanelSession new];s.m_nsUserName=name;s.m_uUnReadCount=unread;return s; }
static NSArray *Names(NSArray *sessions) { NSMutableArray *names=[NSMutableArray array];for(PanelSession *s in sessions)[names addObject:s.m_nsUserName ?: @""];return names; }
static void SetPolicy(BOOL enabled,BOOL revealed,BOOL hideSessions,BOOL blocked,NSArray *friends,NSArray *groups,BOOL notify) {
    NSMutableDictionary *options=[CSCloseFriendDefaultOptions() mutableCopy];options[@"hideSessions"]=@(hideSessions);options[@"silenceMessages"]=@YES;
    Current=[[CSCloseFriendSnapshot alloc] initWithAccountID:CurrentAccount profile:@{@"enabled":@(enabled),@"friends":friends,@"groups":groups,@"options":options} revealed:revealed revision:++Revision blocked:blocked];
    if(notify)[NSNotificationCenter.defaultCenter postNotificationName:CSCloseFriendPolicyDidChangeNotification object:nil];
}
static void Locked(BOOL notify) { SetPolicy(YES,NO,YES,NO,@[@"secret"],@[@"secret-room@chatroom"],notify); }
static PanelCell *Render(MainFrameAggregationViewController *panel,NSInteger row) { return [panel tableView:panel.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]]; }
static MainFrameAggregationViewController *Panel(NewMainFrameViewController *home) { MainFrameAggregationViewController *panel=[MainFrameAggregationViewController new];panel.delegate=home;[panel viewDidLoad];[panel viewWillAppear:NO];[panel viewDidAppear:NO];return panel; }
static void Drain(void) { NSDate *deadline=[NSDate dateWithTimeIntervalSinceNow:.025];while([deadline timeIntervalSinceNow]>0)[NSRunLoop.currentRunLoop runMode:NSDefaultRunLoopMode beforeDate:deadline]; }

int main(void) { @autoreleasepool {
    Capabilities=[NSMutableDictionary dictionary];Manager=[MainSessionMgr new];
    BOOL unhooked=getenv("CS_TEST_UNREAD_PANEL_UNHOOKED")!=NULL;
#ifdef CS_UNREAD_PANEL_ABI
    {
        CaseName=@"incompatible native hooks are skipped before replacement";
        Method predicate=class_getInstanceMethod(MainFrameAggregationLogic.class,@selector(canShowSession:));
        IMP predicateIMP=method_getImplementation(predicate);
        Method count=class_getInstanceMethod(MainFrameAggregationLogic.class,@selector(notifySessionCount));
        IMP countIMP=method_getImplementation(count);
        Locked(NO);CSCFUnreadPanelInstallHooks();
        CHECK([Capabilities[@"MainFrameAggregationLogic.canShowSession:"] isEqual:@NO]);
        CHECK([Capabilities[@"MainFrameAggregationLogic.notifySessionCount"] isEqual:@NO]);
        CHECK(method_getImplementation(class_getInstanceMethod(MainFrameAggregationLogic.class,@selector(canShowSession:)))==predicateIMP);
        CHECK(method_getImplementation(class_getInstanceMethod(MainFrameAggregationLogic.class,@selector(notifySessionCount)))==countIMP);
        NativeNotifyCount=8;Manager.fullSessions=[NSMutableArray arrayWithObject:Session(@"ordinary",3)];
        MainFrameAggregationViewController *abiPanel=Panel([NewMainFrameViewController new]);
        CHECK(abiPanel.tableContainerView.hidden);
        CHECK(CSCFUnreadPanelNotifyCount(abiPanel.dataLogic,8)==0);
        CHECK(abiPanel.dataLogic.notifySessionCount==8);
        fprintf(stdout,"Close-friend unread panel ABI: %lu checks, %lu failures\n",(unsigned long)Checks,(unsigned long)Failures);
        return Failures?1:0;
    }
#endif
    Locked(NO);if(!unhooked)CSCFUnreadPanelInstallHooks();
    CaseName=@"native chain filters both protected kinds, order and original identity";
    PanelSession *ordinary=Session(@"ordinary",3),*secret=Session(@"secret",9),*room=Session(@"secret-room@chatroom",7),*second=Session(@"second",2);
    Manager.fullSessions=[@[ordinary,secret,room,second] mutableCopy];
    NativeNotifyCount=4;
    NSArray *originalObjects=[Manager.fullSessions copy];
    NewMainFrameViewController *home=[NewMainFrameViewController new];
    MainFrameAggregationViewController *panel=Panel(home);
    CHECK([Names(panel.dataLogic.currentSessionList) isEqual:@[@"ordinary",@"second"]]);
    CHECK(panel.dataLogic.sessionCount==2 && panel.dataLogic.notifySessionCount==2);
    CHECK([panel.dataLogic sessionAtIndex:0]==ordinary && [panel.dataLogic sessionAtIndex:1]==second);
    Render(panel,1);[panel tableView:panel.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    CHECK(home.opens==1 && home.opened==second);
    if(unhooked) {
        fprintf(stdout,"Close-friend unread panel (unhooked native control): %lu checks, %lu failures\n",(unsigned long)Checks,(unsigned long)Failures);
        return Failures?1:0;
    }

    CaseName=@"complete-source reads include other groups and restore the selected presentation";
    CSGroupNativeSessionCoordinator *coordinator=CSGroupNativeSessionCoordinator.sharedCoordinator;
    Manager.selectedSessions=@[second];NSArray *selectedSource=Manager.selectedSessions;
    NSUInteger scopes=coordinator.scopes,restorations=coordinator.restorations;
    __block BOOL nestedCalled=NO,crossSurfaceCalled=NO;
    BOOL complete=[coordinator performWithCompleteSourceForSurface:CSCloseFriendSurfaceSession original:^{
        CHECK(Manager.completeSourceDepth==1);
        CHECK([Names(Manager.visibleSessionEnumerator.allObjects) isEqual:@[@"ordinary",@"second"]]);
        CHECK([coordinator performWithCompleteSourceForSurface:CSCloseFriendSurfaceSession original:^{nestedCalled=YES;}]);
        CHECK(![coordinator performWithCompleteSourceForSurface:CSCloseFriendSurfaceForward original:^{crossSurfaceCalled=YES;}]);
    }];
    CHECK(complete && nestedCalled && !crossSurfaceCalled);
    CHECK(coordinator.scopes==scopes+1 && coordinator.restorations==restorations+1 && coordinator.depth==0);
    CHECK(Manager.completeSourceDepth==0 && Manager.selectedSessions==selectedSource && [Manager.fullSessions isEqual:originalObjects]);
    CHECK([Names(Manager.visibleSessionEnumerator.allObjects) isEqual:@[@"second"]]);
    CSCFUnreadPanelRefresh(panel);
    CHECK([Names(panel.dataLogic.currentSessionList) isEqual:@[@"ordinary",@"second"]] && !panel.tableContainerView.hidden);
    CHECK(Manager.selectedSessions==selectedSource && Manager.completeSourceDepth==0);

    CaseName=@"unavailable complete source stays masked until a verified rebuild";
    coordinator.sourceAvailable=NO;__block BOOL rejectedCalled=NO;
    CHECK(![coordinator performWithCompleteSourceForSurface:CSCloseFriendSurfaceSession original:^{rejectedCalled=YES;}]);
    CHECK(!rejectedCalled);
    NSUInteger enumerations=Manager.enumerations;CSCFUnreadPanelRefresh(panel);
    CHECK(panel.tableContainerView.hidden && Manager.enumerations==enumerations && !CSCFUnreadPanelAllowsOpen(panel,ordinary));
    coordinator.sourceAvailable=YES;CSCFUnreadPanelPreparePresentation(panel);
    CHECK(!panel.tableContainerView.hidden && panel.bottomTitleCount==2 && Manager.selectedSessions==selectedSource);
    coordinator.nativeTransactionActive=YES;
    CHECK(![coordinator performWithCompleteSourceForSurface:CSCloseFriendSurfaceSession original:^{rejectedCalled=YES;}]);
    CHECK(!rejectedCalled);coordinator.nativeTransactionActive=NO;

    CaseName=@"complete-source exceptions propagate after grouping is restored";
    BOOL caught=NO;restorations=coordinator.restorations;
    @try {
        [coordinator performWithCompleteSourceForSurface:CSCloseFriendSurfaceSession original:^{
            @throw [NSException exceptionWithName:@"NativeCompleteSourceFailure" reason:nil userInfo:nil];
        }];
    } @catch(NSException *exception) {caught=[exception.name isEqual:@"NativeCompleteSourceFailure"];}
    CHECK(caught && coordinator.depth==0 && coordinator.restorations==restorations+1);
    CHECK(Manager.completeSourceDepth==0 && Manager.selectedSessions==selectedSource);
    CHECK([Names(Manager.visibleSessionEnumerator.allObjects) isEqual:@[@"second"]]);
    Manager.selectedSessions=nil;

    CaseName=@"unlock and relock rebuild from the complete manager with the retired option ignored";
    SetPolicy(YES,YES,YES,NO,@[@"secret"],@[@"secret-room@chatroom"],YES);Drain();
    CHECK(!Current.blocked && !Current.options[@"silenceMessages"]);
    CHECK([Names(panel.dataLogic.currentSessionList) isEqual:@[@"ordinary",@"secret",@"secret-room@chatroom",@"second"]]);
    CHECK([panel.dataLogic sessionAtIndex:1]==secret && panel.dataLogic.notifySessionCount==4);
    Locked(YES);Drain();
    CHECK([Names(panel.dataLogic.currentSessionList) isEqual:@[@"ordinary",@"second"]]);
    CHECK(panel.tableView.reloads>0);
    CHECK([Manager.fullSessions isEqual:originalObjects] && Manager.fullSessions[0]==ordinary && Manager.fullSessions[1]==secret && Manager.fullSessions[2]==room);
    CHECK(ordinary.m_uUnReadCount==3 && secret.m_uUnReadCount==9 && room.m_uUnReadCount==7 && second.m_uUnReadCount==2);
    CHECK(!panel.tableContainerView.hidden && panel.bottomTitleCount==2);
    CHECK([Capabilities[@"MainFrameAggregationLogic.canShowSession:"] isEqual:@YES]);
    CHECK([Capabilities[@"MainFrameAggregationViewController.tableView:cellForRowAtIndexPath:"] isEqual:@YES]);

    CaseName=@"relock clears retained transition content during a native animation";
    SetPolicy(YES,YES,YES,NO,@[@"secret"],@[@"secret-room@chatroom"],YES);Drain();
    panel.transition=[PanelTransition new];panel.transition.fromSnapshtoView=[UIImageView new];
    UIImageView *snapshot=panel.transition.fromSnapshtoView;snapshot.image=@"old secret pixels";
    UIView *snapshotChild=[UIView new];[snapshot addSubview:snapshotChild];[panel.view addSubview:snapshot];
    panel.isTransitioning=YES;panel.needReloadAfterTransition=YES;NSUInteger reloads=panel.tableView.reloads;
    Locked(YES);Drain();
    CHECK(snapshot.image==nil && snapshot.subviews.count==0 && snapshot.hidden);
    CHECK(snapshot.superview==nil && snapshotChild.superview==nil);
    CHECK(panel.tableView.reloads>reloads && !panel.needReloadAfterTransition && panel.bottomTitleCount==2);
    snapshot.hidden=NO;CHECK(snapshot.image==nil && snapshot.subviews.count==0);
    CHECK(!panel.tableContainerView.hidden);
    panel.isTransitioning=NO;

    CaseName=@"native eligibility and unread notification count remain distinct";
    PanelSession *hidden=Session(@"native-hidden",5);hidden.isHidden=YES;
    PanelSession *folded=Session(@"folded",6);folded.m_isFolding=YES;
    PanelSession *box=Session(@"chatroom_session_box",8);box.isInChatBox=YES;
    PanelSession *brand=Session(@"brandsessionholder",4);brand.isInBrandServiceBox=YES;
    PanelSession *dot=Session(@"dot",10);dot.m_bShowUnReadAsRedDot=YES;
    PanelSession *read=Session(@"read-retained",0);read.retained=YES;
    PanelSession *todo=Session(@"todo",0);todo.retained=YES;
    Manager.fullSessions=[@[hidden,ordinary,folded,secret,box,brand,dot,read,todo,second] mutableCopy];
    NativeNotifyCount=3;
    [panel.dataLogic.sessionSet addObjectsFromArray:@[@"read-retained",@"todo"]];
    [panel.dataLogic rebuildSessionList];
    CHECK([Names(panel.dataLogic.currentSessionList) isEqual:@[@"ordinary",@"read-retained",@"todo",@"second"]]);
    CHECK(panel.dataLogic.sessionCount==4 && panel.dataLogic.notifySessionCount==2);
    // Count helper also protects a retained native list containing exceptional
    // rows, without relying on canShowSession having been called beforehand.
    panel.dataLogic.sessionList=[Manager.fullSessions mutableCopy];
    CHECK(CSCFUnreadPanelNotifyCount(panel.dataLogic,99)==2);
    CHECK(panel.dataLogic.sessionList.count==10 && Manager.fullSessions.count==10);
    WrongUnreadSession *wrong=[WrongUnreadSession new];wrong.m_nsUserName=@"wrong-unread-abi";
    panel.dataLogic.sessionList=(id)[@[ordinary,wrong] mutableCopy];
    CHECK(CSCFUnreadPanelNotifyCount(panel.dataLogic,99)==0 && wrong.reads==0);
    [panel.dataLogic rebuildSessionList];

    CaseName=@"incremental native reload applies the same live filter";
    PanelSession *third=Session(@"third",1);[Manager.fullSessions addObject:third];
    NativeNotifyCount=4;
    [panel.dataLogic onMainFrameBeginReload];
    for(PanelSession *s in @[second,room,third,secret,ordinary])[panel.dataLogic onMainFrameHandleSession:s];
    [panel.dataLogic onMainFrameEndReload];
    CHECK([Names(panel.dataLogic.currentSessionList) isEqual:@[@"second",@"third",@"ordinary"]]);
    CHECK([panel.dataLogic sessionAtIndex:1]==third && panel.dataLogic.notifySessionCount==3);
    NSUInteger opens=home.opens;Render(panel,1);[panel tableView:panel.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    CHECK(home.opens==opens+1 && home.opened==third);

    CaseName=@"old rendered indexes cannot select or mark a replacement row";
    Render(panel,0);opens=home.opens;NSUInteger mutations=panel.dataLogic.readMutations;
    [panel.dataLogic onMainFrameBeginReload];
    for(PanelSession *s in @[third,second,ordinary])[panel.dataLogic onMainFrameHandleSession:s];
    [panel.dataLogic onMainFrameEndReload];
    NSIndexPath *first=[NSIndexPath indexPathForRow:0 inSection:0];
    [panel tableView:panel.tableView didSelectRowAtIndexPath:first];
    [panel tableView:panel.tableView commitEditingStyle:1 forRowAtIndexPath:first];
    CHECK(home.opens==opens && panel.dataLogic.readMutations==mutations && third.m_uUnReadCount==1 && second.m_uUnReadCount==2);
    Render(panel,0);[panel tableView:panel.tableView didSelectRowAtIndexPath:first];
    CHECK(home.opens==opens+1 && home.opened==third);
    [panel tableView:panel.tableView commitEditingStyle:1 forRowAtIndexPath:first];
    CHECK(panel.dataLogic.readMutations==mutations+1 && third.m_uUnReadCount==0 && second.m_uUnReadCount==2);
    third.m_uUnReadCount=1; // Reset only this isolated fixture's explicit native edit.

    CaseName=@"policy change inside native enumeration rebuilds one current result";
    SetPolicy(YES,YES,YES,NO,@[@"secret"],@[@"secret-room@chatroom"],YES);Drain();
    __block NSUInteger policyChanges=0;
    Manager.onEnumerate=^{ Manager.onEnumerate=nil;policyChanges++;Locked(YES); };
    [panel.dataLogic rebuildSessionList];Drain();
    CHECK(policyChanges==1 && ![Names(panel.dataLogic.currentSessionList) containsObject:@"secret"]);
    CHECK(!panel.tableContainerView.hidden && panel.bottomTitleCount==3);
    CHECK(secret.m_uUnReadCount==9 && Manager.fullSessions.count==11);

    CaseName=@"complete native Begin Handle End transaction restores its original mask";
    Locked(YES);Drain();
    [panel.dataLogic onMainFrameBeginReload];
    [panel.dataLogic onMainFrameHandleSession:secret];
    CHECK(![Names(panel.dataLogic.currentSessionList) containsObject:@"secret"]);
    SetPolicy(YES,YES,YES,NO,@[@"secret"],@[@"secret-room@chatroom"],YES);
    CHECK(panel.tableContainerView.hidden && !CSCFUnreadPanelAllowsOpen(panel,ordinary));
    [panel.dataLogic onMainFrameHandleSession:second];
    [panel.dataLogic onMainFrameEndReload];Drain();
    CHECK(!panel.tableContainerView.hidden);
    CHECK([Names(panel.dataLogic.currentSessionList) isEqual:@[@"ordinary",@"secret",@"read-retained",@"todo",@"second",@"third"]]);
    CHECK(panel.bottomTitleCount==NativeNotifyCount && secret.m_uUnReadCount==9);

    CaseName=@"old cell cannot acquire a new row ticket during a synchronous lock";
    NativeCellCallback=^{ Locked(YES); };
    PanelCell *staleCell=Render(panel,1);
    CHECK(panel.tableContainerView.hidden);
    Drain();CHECK(!panel.tableContainerView.hidden);
    CHECK(staleCell.session==secret && staleCell.hidden);
    opens=home.opens;
    [panel tableView:panel.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    CHECK(home.opens==opens);
    PanelCell *freshCell=Render(panel,0);
    CHECK(freshCell.session==ordinary && !freshCell.hidden);
    [panel tableView:panel.tableView didSelectRowAtIndexPath:first];
    CHECK(home.opens==opens+1 && home.opened==ordinary);

    CaseName=@"native deselection cannot redirect a rendered ordinary row";
    panel.dataLogic.sessionList=[@[ordinary,second] mutableCopy];Render(panel,0);opens=home.opens;
    MainFrameAggregationLogic *selectedLogic=panel.dataLogic;
    NativeDeselectCallback=^{ [selectedLogic.sessionList exchangeObjectAtIndex:0 withObjectAtIndex:1]; };
    [panel tableView:panel.tableView didSelectRowAtIndexPath:first];
    CHECK(home.opens==opens && [panel.dataLogic sessionAtIndex:0]==second);
    Render(panel,0);[panel tableView:panel.tableView didSelectRowAtIndexPath:first];
    CHECK(home.opens==opens+1 && home.opened==second);
    CHECK(ordinary.m_uUnReadCount==3 && second.m_uUnReadCount==2);
    [panel.dataLogic rebuildSessionList];

    CaseName=@"off-main and invalid row callbacks never reach native actions";
    __block BOOL backgroundAllowed=YES,offMainObserved=NO;
    dispatch_group_t background=dispatch_group_create();
    dispatch_group_async(background,dispatch_get_global_queue(QOS_CLASS_DEFAULT,0),^{ offMainObserved=!NSThread.isMainThread;backgroundAllowed=CSCFUnreadPanelAllowsOpen(panel,ordinary); });
    CHECK(dispatch_group_wait(background,dispatch_time(DISPATCH_TIME_NOW,NSEC_PER_SEC))==0);
    CHECK(offMainObserved && !backgroundAllowed);
    opens=home.opens;mutations=panel.dataLogic.readMutations;
    [panel tableView:panel.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:-1 inSection:0]];
    [panel tableView:panel.tableView commitEditingStyle:1 forRowAtIndexPath:[NSIndexPath indexPathForRow:999 inSection:0]];
    CHECK(home.opens==opens && panel.dataLogic.readMutations==mutations);

    CaseName=@"late click rechecks latest policy before the native open";
    SetPolicy(YES,YES,YES,NO,@[@"secret"],@[@"secret-room@chatroom"],YES);Drain();
    PanelSession *captured=secret;
    Locked(NO);opens=home.opens;[home onAggregation:panel openSession:captured];
    CHECK(home.opens==opens);
    [home onAggregation:panel openSession:ordinary];CHECK(home.opens==opens);
    CSCFUnreadPanelPreparePresentation(panel);
    [home onAggregation:panel openSession:ordinary];CHECK(home.opens==opens+1 && home.opened==ordinary);
    SetPolicy(YES,NO,YES,NO,@[@"secret",@"ordinary"],@[@"secret-room@chatroom"],NO);
    opens=home.opens;[home onAggregation:panel openSession:ordinary];CHECK(home.opens==opens);

    CaseName=@"count cannot publish a result read across epoch or policy boundaries";
    Locked(YES);Drain();
    panel.dataLogic.onCurrentListRead=^{ Epoch++; };
    CHECK(CSCFUnreadPanelNotifyCount(panel.dataLogic,99)==0);
    CHECK(!CSCFUnreadPanelIsCurrent(panel));
    panel=Panel(home);CHECK(CSCFUnreadPanelIsCurrent(panel));
    panel.dataLogic.onCurrentListRead=^{ Locked(NO); };
    CHECK(CSCFUnreadPanelNotifyCount(panel.dataLogic,99)==0);
    CHECK(secret.m_uUnReadCount==9 && ordinary.m_uUnReadCount==3);
    CSCFUnreadPanelPreparePresentation(panel);

    CaseName=@"same-account epoch replacement and account changes reject stale panels";
    Locked(NO);Epoch++;opens=home.opens;[home onAggregation:panel openSession:second];CHECK(home.opens==opens);
    CHECK(!CSCFUnreadPanelIsCurrent(panel) && !CSCFUnreadPanelAllowsSession(panel,second));
    CSCFUnreadPanelRefresh(panel);CHECK(panel.dataLogic.sessionCount==0);
    panel=Panel(home);CHECK(CSCFUnreadPanelIsCurrent(panel));
    CurrentAccount=@"other-account";Locked(NO);opens=home.opens;
    [home onAggregation:panel openSession:second];CHECK(home.opens==opens);
    CSCFUnreadPanelRefresh(panel);CHECK(panel.dataLogic.sessionCount==0);

    CaseName=@"blocked boundary never borrows old membership";
    SetPolicy(YES,NO,YES,YES,@[],@[],NO);
    panel=Panel(home);CHECK(panel.dataLogic.sessionCount==0 && panel.dataLogic.notifySessionCount==0);
    CHECK(!CSCFUnreadPanelAllowsSession(panel,ordinary));

    CaseName=@"disabled and hideSessions off preserve the native session result";
    [Manager.fullSessions addObject:room];
    SetPolicy(NO,NO,YES,NO,@[@"secret"],@[@"secret-room@chatroom"],NO);
    panel=Panel(home);CHECK([Names(panel.dataLogic.currentSessionList) containsObject:@"secret"] && [Names(panel.dataLogic.currentSessionList) containsObject:@"secret-room@chatroom"]);
    SetPolicy(YES,NO,NO,NO,@[@"secret"],@[@"secret-room@chatroom"],YES);Drain();
    CHECK([Names(panel.dataLogic.currentSessionList) containsObject:@"secret"]);

    CaseName=@"policy lock while inactive cleans a visible panel";
    SetPolicy(YES,YES,YES,NO,@[@"secret"],@[@"secret-room@chatroom"],YES);Drain();
    UIApplication.sharedApplication.applicationState=UIApplicationStateInactive;
    Locked(YES);Drain();
    CHECK(![Names(panel.dataLogic.currentSessionList) containsObject:@"secret"] && ![Names(panel.dataLogic.currentSessionList) containsObject:@"secret-room@chatroom"]);
    opens=home.opens;[home onAggregation:panel openSession:ordinary];CHECK(home.opens==opens);
    UIApplication.sharedApplication.applicationState=UIApplicationStateActive;

    fprintf(stdout,"Close-friend unread panel%s: %lu checks, %lu failures\n",unhooked ? " (unhooked native control)" : "",(unsigned long)Checks,(unsigned long)Failures);
    return Failures?1:0;
} }
