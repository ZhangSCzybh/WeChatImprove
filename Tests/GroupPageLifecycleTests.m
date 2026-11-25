#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <dispatch/dispatch.h>
#import <math.h>
#import <objc/runtime.h>

// Replay real adapter preview, commit and rollback methods. Native rendering,
// preference acceptance and the pixel animator are observable bounded inputs.
static NSUInteger checks,failures,foldedRefreshes;
static void Check(BOOL result,NSString *message) { checks++; if (!result) { failures++; fprintf(stderr,"FAIL: %s\n",message.UTF8String); } }
static BOOL animationEnabled,enabled,swipesEnabled,reducedMotion,appActive;
static NSString *currentAccount;
static NSUInteger accountEpoch;
static char AdapterKey,PresentationSuspendedKey;
static NSMutableArray<NSString *> *events;
static void (^duringSourceCapture)(void),(^duringIncomingCapture)(void),(^duringSettle)(void),(^duringCancellation)(void);
static BOOL CSGroupPageTransitionEnabled(NSUserDefaults *defaults) { (void)defaults; return animationEnabled; }
static BOOL UIAccessibilityIsReduceMotionEnabled(void) { return reducedMotion; }
static BOOL CSGroupApplicationActive(void) { return appActive; }
static NSString *CSGroupCurrentAccountID(void) { return currentAccount; }
static NSUInteger CSCloseFriendAccountEpoch(void) { return accountEpoch; }
static BOOL Option(NSString *key) { return [key isEqual:@"enabled"] ? enabled : ([key isEqual:@"swipe_gesture_enabled"] ? swipesEnabled : NO); }
typedef struct { CGFloat top,left,bottom,right; } UIEdgeInsets;
@interface UIView : NSObject
@property(nonatomic) CGRect frame,bounds;
@property(nonatomic,weak) UIView *superview;
@property(nonatomic,strong) id window;
@property(nonatomic) BOOL hidden;
- (void)addSubview:(UIView *)view;
- (BOOL)isDescendantOfView:(UIView *)view;
- (CGRect)convertRect:(CGRect)rect toView:(UIView *)view;
@end
@implementation UIView
- (void)setFrame:(CGRect)frame { _frame=frame;_bounds.size=frame.size; }
- (void)addSubview:(UIView *)view { view.superview=self; }
- (BOOL)isDescendantOfView:(UIView *)view { for(UIView *node=self;node;node=node.superview)if(node==view)return YES;return NO; }
- (CGRect)convertRect:(CGRect)rect toView:(UIView *)view {
    for(UIView *node=self;node && node!=view;node=node.superview) rect=CGRectOffset(rect,node.frame.origin.x-node.bounds.origin.x,node.frame.origin.y-node.bounds.origin.y);
    return rect;
}
@end
@protocol SessionLayoutHost
- (void)performSessionListLayout:(void (^)(void))layout;
@end
@interface UITableView : UIView
@property(nonatomic) BOOL tracking,dragging,decelerating,editing;
@property(nonatomic) CGPoint contentOffset;
@property(nonatomic) UIEdgeInsets adjustedContentInset;
@property(nonatomic) CGSize contentSize;
@property(nonatomic) NSUInteger layouts,layoutRequests,nativeLayouts,offsetWrites;
@property(nonatomic) BOOL acceptsOffsetWrites,routesSessionLayout;
@property(nonatomic,weak) id<SessionLayoutHost> adapter;
@property(nonatomic,copy) NSArray *visibleCells;
@property(nonatomic,copy) void (^onNativeLayout)(void),(^onOffsetWrite)(void);
- (void)setNeedsLayout;
- (void)setContentOffset:(CGPoint)offset animated:(BOOL)animated;
- (void)layoutIfNeeded;
@end
@implementation UITableView
- (instancetype)init { if((self=[super init]))_acceptsOffsetWrites=YES;return self; }
- (void)setNeedsLayout { self.layoutRequests++; }
- (void)setContentOffset:(CGPoint)offset animated:(BOOL)animated {
    NSCAssert(!animated,@"Viewport restoration must not animate");self.offsetWrites++;
    if(self.acceptsOffsetWrites)self.contentOffset=offset;if(self.onOffsetWrite)self.onOffsetWrite();
}
- (void)layoutIfNeeded {
    self.layouts++;[events addObject:@"layout"];
    if(self.routesSessionLayout) [self.adapter performSessionListLayout:^{ self.nativeLayouts++;if(self.onNativeLayout)self.onNativeLayout(); }];
}
@end
@interface UITableViewCell : UIView @end
@implementation UITableViewCell @end
@interface CSCloseFriendListShield : NSObject
- (void)shieldCell:(UITableViewCell *)cell;
- (void)prepareForPublication;
@end
@implementation CSCloseFriendListShield
- (void)shieldCell:(UITableViewCell *)cell { (void)cell; }
- (void)prepareForPublication {}
@end
static void CSGroupWithDisplayIndices(UITableView *table,void (^body)(void)) { (void)table; body(); }
@interface Chrome : UIView
@property(nonatomic) NSInteger selectedIndex;
@property(nonatomic,copy) NSArray<NSString *> *tabIDs;
@property(nonatomic,copy) NSString *selectedTabID;
@property(nonatomic) NSUInteger selections,animatedSelections,staticSelections,selectionAcknowledgements;
@property(nonatomic) BOOL interactiveTransition,indicatorMoving;
@property(nonatomic) CGFloat indicatorProgress,lastAnimatedStartProgress;
@property(nonatomic,copy) void (^onAnimatedSelection)(void);
- (void)selectTabAtIndex:(NSInteger)index animated:(BOOL)animated;
@end
@implementation Chrome
- (instancetype)init { if ((self=[super init])) _selectedIndex=NSNotFound;return self; }
- (void)setSelectedTabID:(NSString *)tabID {
    NSUInteger index=[self.tabIDs indexOfObject:tabID];
    if (index!=NSNotFound) [self selectTabAtIndex:(NSInteger)index animated:NO];
}
- (void)selectTabAtIndex:(NSInteger)index animated:(BOOL)animated {
    if (index==self.selectedIndex) { self.selectionAcknowledgements++;return; }
    self.selectedIndex=index;_selectedTabID=self.tabIDs[(NSUInteger)index];self.selections++;
    if (animated) {
        self.animatedSelections++;self.lastAnimatedStartProgress=self.indicatorProgress;self.indicatorMoving=YES;
        [events addObject:@"select-indicator-animated"];
    } else { self.staticSelections++;self.indicatorMoving=NO;[events addObject:@"select-indicator-static"]; }
    self.interactiveTransition=NO;self.indicatorProgress=1;
    if (animated && self.onAnimatedSelection) self.onAnimatedSelection();
}
@end
@interface CSCloseFriendSnapshot : NSObject
@property(nonatomic) BOOL blocked,enabled,revealed;
@property(nonatomic) NSUInteger revision;
@property(nonatomic,copy) NSString *accountID;
@property(nonatomic,copy) NSDictionary *options;
- (BOOL)hidesUserName:(NSString *)name surface:(NSUInteger)surface;
@end
@implementation CSCloseFriendSnapshot
- (BOOL)hidesUserName:(NSString *)name surface:(NSUInteger)surface { (void)name;(void)surface;return NO; }
@end
static NSUInteger const CSCloseFriendSurfaceSession=0;
static CSCloseFriendSnapshot *policy;
static CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) { return policy; }
@interface CSGroupProjection : NSObject
@property(nonatomic,getter=isValid) BOOL valid;
@property(nonatomic,copy) NSString *accountID;
@property(nonatomic) long long privacyRevision;
@property(nonatomic,copy) NSArray *sections;
- (void)discardComputationCache;
@end
@implementation CSGroupProjection
- (void)discardComputationCache {}
@end
@interface CSGroupRow : NSObject
@property(nonatomic,copy) NSString *userName;
@end
@implementation CSGroupRow @end
static long long CSGroupReadInteger(id object,NSString *key,long long fallback) {
    return object && [object respondsToSelector:NSSelectorFromString(key)] ? [[object valueForKey:key] longLongValue] : fallback;
}
static BOOL CSGroupIsFoldedController(id controller) { (void)controller;return NO; }
@interface Preferences : NSObject
@property(nonatomic,copy) NSString *accountID,*selectedTabID;
@property(nonatomic,copy) NSArray *tabs;
@property(nonatomic) NSUInteger writes;
@property(nonatomic) BOOL rejectsWrites;
@property(nonatomic,copy) void (^onSelectionWrite)(void);
@end
@implementation Preferences
- (void)setSelectedTabID:(NSString *)tabID {
    self.writes++; [events addObject:@"write-selection"]; if (!self.rejectsWrites) _selectedTabID=tabID.copy;
    if (self.onSelectionWrite) self.onSelectionWrite();
}
@end
@interface WESessionTabItem : NSObject
@property(nonatomic,copy) NSString *tabId;
@end
@implementation WESessionTabItem @end
@interface CSGroupNativeSessionCoordinator : NSObject
@property(nonatomic) BOOL boundary,previewAllowed,previewValid,tokenValid;
@property(nonatomic) NSUInteger revision,epoch,previewBegins,previewEnds,fullProofs,tokenProofs;
@property(nonatomic,copy) NSString *accountID,*previewTarget;
@property(nonatomic,weak) id previewOwner;
+ (instancetype)sharedCoordinator;
- (BOOL)beginPagePreviewForTabID:(NSString *)tabID owner:(id)owner;
- (BOOL)pagePreviewIsValidForOwner:(id)owner;
- (BOOL)pagePreviewTokenIsValidForOwner:(id)owner;
- (void)endPagePreviewForOwner:(id)owner;
@end
static CSGroupNativeSessionCoordinator *coordinator;
@implementation CSGroupNativeSessionCoordinator
+ (instancetype)sharedCoordinator { return coordinator; }
- (BOOL)beginPagePreviewForTabID:(NSString *)tabID owner:(id)owner {
    self.previewBegins++; [events addObject:@"begin-native-preview"];
    if (!self.previewAllowed) return NO;
    self.previewOwner=owner; self.previewTarget=tabID; return YES;
}
- (BOOL)pagePreviewIsValidForOwner:(id)owner { self.fullProofs++; return self.previewValid && self.previewOwner==owner; }
- (BOOL)pagePreviewTokenIsValidForOwner:(id)owner { self.tokenProofs++; return self.tokenValid && self.previewOwner==owner; }
- (void)endPagePreviewForOwner:(id)owner {
    self.previewEnds++; [events addObject:@"end-native-preview"];
    if (self.previewOwner==owner) { self.previewOwner=nil; self.previewTarget=nil; }
}
@end
@interface CSGroupPageAnimator : NSObject
@property(nonatomic,getter=isActive) BOOL active;
@property(nonatomic,getter=isAnimating) BOOL animating;
@property(nonatomic) BOOL matches,lastCommit;
@property(nonatomic) NSUInteger cancellations,begins,prepares,settles,motions;
@property(nonatomic) CGFloat translation,lastVelocity;
@property(nonatomic,copy) void (^completion)(BOOL committed);
- (BOOL)beginWithTable:(UITableView *)table belowView:(UIView *)rail direction:(NSInteger)direction;
- (BOOL)matchesTable:(UITableView *)table belowView:(UIView *)rail;
- (BOOL)prepareIncomingWithTable:(UITableView *)table belowView:(UIView *)rail readiness:(BOOL (^)(void))readiness;
- (BOOL)updateTranslation:(CGFloat)translation;
- (void)settleCommitting:(BOOL)commit velocity:(CGFloat)velocity readiness:(BOOL (^)(void))readiness completion:(void (^)(BOOL))completion;
- (void)cancel;
@end
@implementation CSGroupPageAnimator
- (BOOL)beginWithTable:(UITableView *)table belowView:(UIView *)rail direction:(NSInteger)direction {
    (void)table; (void)rail; self.begins++; [events addObject:@"capture-source"];
    self.active=(direction==1 || direction==-1); self.matches=YES;
    if (duringSourceCapture) duringSourceCapture(); return self.active;
}
- (BOOL)matchesTable:(UITableView *)table belowView:(UIView *)rail { (void)table; (void)rail; return self.matches; }
- (BOOL)prepareIncomingWithTable:(UITableView *)table belowView:(UIView *)rail readiness:(BOOL (^)(void))readiness {
    (void)table; (void)rail; self.prepares++; [events addObject:@"capture-target"];
    if (duringIncomingCapture) duringIncomingCapture();
    if (!readiness || readiness()) return YES;
    [self cancel]; return NO;
}
- (BOOL)updateTranslation:(CGFloat)translation { self.translation=translation; return self.active; }
- (void)settleCommitting:(BOOL)commit velocity:(CGFloat)velocity readiness:(BOOL (^)(void))readiness completion:(void (^)(BOOL))completion {
    self.settles++; self.lastCommit=commit; self.lastVelocity=velocity;
    [events addObject:commit ? @"settle-commit" : @"settle-source"]; self.completion=completion;
    if (duringSettle) duringSettle();
    if (!readiness || readiness()) { self.motions++; self.animating=YES; }
    else { [self cancel]; if (completion) completion(NO); }
}
- (void)cancel {
    self.cancellations++; self.active=NO; self.animating=NO; [events addObject:@"cancel-pixels"];
    if (duringCancellation) { void (^callback)(void)=duringCancellation; duringCancellation=nil; callback(); }
}
@end

@interface CSGroupListAdapter : NSObject <SessionLayoutHost>
@property(nonatomic,strong) CSGroupPageAnimator *pageAnimator;
@property(nonatomic,copy) NSDictionary *pageTransitionContext;
@property(nonatomic,copy) NSString *pagePreviewTabID,*pagePreviewAttemptedTarget;
@property(nonatomic) NSUInteger pageTransitionGeneration,pageAnimationModelRevision;
@property(nonatomic) BOOL pageSelectionAccepted,checkingPageTransition,preparingPagePreview,restoringPagePreview,pageRollingBack;
@property(nonatomic) CGFloat pageReleaseVelocity;
@property(nonatomic) BOOL presentationSuspended,searching,nativePresentation,chromeVisible,usesNativeSessionModel;
@property(nonatomic) BOOL publishing,dirty,privacyRefreshPending,sessionLayoutHeld,snapshotRetryAttempted,initialViewportPending,swipeActive;
@property(nonatomic,getter=isActive) BOOL active;
@property(nonatomic) BOOL panMoving,publicationAllowed;
@property(nonatomic) BOOL restoringViewport,presentationReturnFinished,pendingRestoreAllowed,restorationObservedPreviewScope;
@property(nonatomic,copy) NSArray *pageSourceReturnKey,*initialViewportKey;
@property(nonatomic) NSUInteger initialViewportGeneration,snapshotRetryGeneration;
@property(nonatomic) BOOL nativeBoundaryHeld;
@property(nonatomic,strong) CSCloseFriendListShield *privacyShield;
@property(nonatomic,copy) NSArray *cachedNativeSections;
@property(nonatomic,strong) UIView *headerContainer;
@property(nonatomic) NSUInteger viewportGeneration,pendingViewportRestores;
@property(nonatomic) NSUInteger changeDepth,menuState,modelRevision,snapshotEpoch,nativeModelRevision;
@property(nonatomic) NSUInteger refreshes,heightRestores,initialCancellations,directSelections,titles;
@property(nonatomic) CGFloat lastRestoredHeight;
@property(nonatomic,strong) UITableView *table;
@property(nonatomic,strong) Chrome *chrome;
@property(nonatomic,strong) Preferences *preferences;
@property(nonatomic,strong) CSGroupProjection *projection;
@property(nonatomic,strong) NSObject *controller;
@property(nonatomic,strong) NSMutableDictionary *anchors;
@property(nonatomic,copy) NSArray *nativeActions,*displayedTabs;
@property(nonatomic,copy) NSString *publishedTabID;
@property(nonatomic,copy) NSDictionary *switchViewport,*presentationViewport;
@property(nonatomic,copy) void (^onRefresh)(void);
+ (instancetype)adapterForController:(id)controller;
+ (void)setPresentationSuspended:(BOOL)suspended forController:(id)controller;
+ (void)finishPresentationReturnForController:(id)controller;
- (void)performSessionListLayout:(void (^)(void))layout;
- (BOOL)adoptCompatibilityModelIfNeeded;
- (void)requestRefresh;
- (void)prepareForVisibility;
- (void)invalidateNativeSnapshot;
- (void)cancelScheduledRefresh;
- (void)finishSuspendedBatches;
- (void)requestTabBadgeSourceRefresh;
- (void)saveAnchor;
- (NSDictionary *)captureViewportForTabID:(NSString *)tabID;
- (void)prepareInitialViewport;
- (void)restoreInitialViewport;
- (void)clearPendingViewport;
- (BOOL)restoreScrollHeightUnderTest:(CGFloat)height;
- (void)restorePendingViewportUnderTest;
- (void)cancelInitialViewportUnderTest;
- (void)restorePagePreview;
- (void)cancelPageTransition;
- (BOOL)pageTransitionContextIsValid;
- (void)cancelInvalidPageTransition;
- (BOOL)validViewport:(NSDictionary *)viewport;
- (void)preparePageSourceForPan;
- (BOOL)beginSwipePageTransitionToIndex:(NSInteger)index direction:(NSInteger)direction;
- (void)preparePageTransitionForSelection:(NSInteger)index;
- (void)rollbackPageTransitionWithVelocity:(CGFloat)velocity;
- (void)selectSwipeIndex:(NSInteger)index direction:(NSInteger)direction;
- (BOOL)pageTransitionTargetIsReady;
- (void)finishPageTransitionIfReady;
- (BOOL)groupSwipesAvailable;
- (BOOL)groupPanMoving;
- (NSUInteger)nativeMenuState;
- (void)refresh;
- (void)restorePendingViewport;
- (BOOL)restoreScrollHeight:(CGFloat)height;
- (void)cancelInitialViewport;
- (void)selectIndex:(NSInteger)index;
- (void)refreshNavigationTitle;
+ (void)refreshFoldedListsForAccount:(NSString *)account;
@end
@implementation CSGroupListAdapter
- (BOOL)adoptCompatibilityModelIfNeeded { return NO; }
- (void)requestRefresh { self.dirty=YES; }
- (void)prepareForVisibility {}
- (void)invalidateNativeSnapshot { self.modelRevision++; }
- (void)cancelScheduledRefresh {}
- (void)finishSuspendedBatches {}
- (void)requestTabBadgeSourceRefresh {}
- (void)saveAnchor {}
- (BOOL)groupSwipesAvailable { return self.active && swipesEnabled && enabled && self.chromeVisible && !self.searching; }
- (BOOL)groupPanMoving { return self.panMoving; }
- (NSUInteger)nativeMenuState { return self.menuState; }
- (void)refresh {
    self.refreshes++;
    NSString *target=self.pagePreviewTabID ?: self.preferences.selectedTabID;
    [events addObject:[@"publish-" stringByAppendingString:target ?: @"nil"]];
    if (self.publicationAllowed) {
        self.publishedTabID=target;self.dirty=NO;
        NSMutableArray *tabIDs=[NSMutableArray new];for (WESessionTabItem *tab in self.displayedTabs) [tabIDs addObject:tab.tabId];
        self.chrome.tabIDs=tabIDs;
        // Both publication paths acknowledge selection through the production
        // container's nonanimated selectedTabID setter, including preview exit.
        self.chrome.selectedTabID=self.pagePreviewTabID ? self.pageTransitionContext[@"source"] : target;
    }
    if (self.onRefresh) self.onRefresh();
}
- (void)restorePendingViewport {
    self.pendingViewportRestores++;self.restorationObservedPreviewScope=self.preparingPagePreview;
    [events addObject:@"restore-pending"];
    [self restorePendingViewportUnderTest];
}
- (BOOL)restoreScrollHeight:(CGFloat)height {
    self.heightRestores++; self.lastRestoredHeight=height; [events addObject:@"restore-height"];
    self.table.acceptsOffsetWrites=self.pendingRestoreAllowed;
    return [self restoreScrollHeightUnderTest:height];
}
- (void)cancelInitialViewport { self.initialCancellations++;[self cancelInitialViewportUnderTest]; }
- (void)selectIndex:(NSInteger)index { self.directSelections++; self.preferences.selectedTabID=[self.displayedTabs[(NSUInteger)index] tabId]; [self refresh]; }
- (void)refreshNavigationTitle { self.titles++; }
+ (void)refreshFoldedListsForAccount:(NSString *)account { (void)account; foldedRefreshes++; }
#include "GroupPageLifecycleUnderTest.h"
@end

static CSGroupListAdapter *Fixture(void) {
    animationEnabled=enabled=swipesEnabled=appActive=YES; reducedMotion=NO;
    duringSourceCapture=duringIncomingCapture=duringSettle=duringCancellation=nil; foldedRefreshes=0; events=[NSMutableArray new];
    currentAccount=@"account"; accountEpoch=7;
    policy=[CSCloseFriendSnapshot new]; policy.accountID=currentAccount; policy.revision=11; policy.options=@{@"hideSessions":@YES};
    coordinator=[CSGroupNativeSessionCoordinator new]; coordinator.accountID=currentAccount; coordinator.epoch=7; coordinator.revision=50; coordinator.previewAllowed=coordinator.previewValid=coordinator.tokenValid=YES;
    CSGroupListAdapter *a=[CSGroupListAdapter new]; a.active=a.chromeVisible=a.publicationAllowed=YES;
    a.pendingRestoreAllowed=YES;a.viewportGeneration=3;
    a.table=[UITableView new]; a.chrome=[Chrome new]; a.controller=[NSObject new];
    objc_setAssociatedObject(a.controller,&AdapterKey,a,OBJC_ASSOCIATION_ASSIGN);
    a.table.adapter=a;a.table.bounds=CGRectMake(0,0,400,800);a.table.contentSize=CGSizeMake(400,2000);a.table.window=[NSObject new];
    a.headerContainer=[UIView new];a.headerContainer.frame=CGRectMake(0,0,400,52);[a.table addSubview:a.headerContainer];
    a.chrome.frame=CGRectMake(0,0,400,52);[a.headerContainer addSubview:a.chrome];
    a.table.contentOffset=CGPointMake(0,160); a.table.adjustedContentInset=(UIEdgeInsets){20,0,0,0};
    a.modelRevision=30; a.snapshotEpoch=7; a.nativeModelRevision=50;
    a.preferences=[Preferences new]; a.preferences.accountID=currentAccount; a.preferences.selectedTabID=@"source"; a.preferences.writes=0;
    a.projection=[CSGroupProjection new]; a.projection.valid=YES; a.projection.accountID=currentAccount; a.projection.privacyRevision=11;a.projection.sections=@[@[]];
    a.publishedTabID=@"source"; a.nativeActions=@[]; a.anchors=[@{@"target":@1} mutableCopy];
    WESessionTabItem *source=[WESessionTabItem new],*target=[WESessionTabItem new]; source.tabId=@"source"; target.tabId=@"target"; a.displayedTabs=@[source,target];
    a.preferences.tabs=a.displayedTabs;
    a.chrome.tabIDs=@[@"source",@"target"];a.chrome.selectedTabID=@"source";a.chrome.selections=a.chrome.staticSelections=a.chrome.selectionAcknowledgements=0;
    [events removeAllObjects]; return a;
}
static CSGroupListAdapter *Ready(void) {
    CSGroupListAdapter *a=Fixture(); a.preferences.selectedTabID=@"target"; a.preferences.writes=0; a.publishedTabID=@"target"; a.pageSelectionAccepted=YES;
    a.pageAnimator=[CSGroupPageAnimator new]; a.pageAnimator.active=YES; a.pageAnimator.matches=YES;
    a.pageTransitionContext=@{@"account":currentAccount,@"source":@"source",@"target":@"target",@"epoch":@7,@"policy":@11,@"nativeModel":@NO,@"revision":@30,@"height":@180};
    a.pageTransitionGeneration=1; [events removeAllObjects]; return a;
}
static BOOL Before(NSString *first,NSString *second) {
    NSUInteger a=[events indexOfObject:first],b=[events indexOfObject:second]; return a!=NSNotFound && b!=NSNotFound && a<b;
}
static NSDictionary *PendingViewport(CSGroupListAdapter *a,NSString *target) {
    NSMutableDictionary *pending=[@{@"height":@240,@"generation":@(a.viewportGeneration),@"account":currentAccount,@"epoch":@(accountEpoch)} mutableCopy];
    if (target) pending[@"targetTab"]=target;
    return pending;
}
static void TestFirstPanSourcePreparation(void) {
    CSGroupListAdapter *a=Fixture();a.presentationViewport=PendingViewport(a,nil);a.presentationReturnFinished=YES;
    a.table.tracking=YES;a.panMoving=YES;[a preparePageSourceForPan];
    Check(!a.refreshes && a.table.layouts==1 && a.pendingViewportRestores==1 && a.restorationObservedPreviewScope,@"completed return restores through the shared viewport path during horizontal ownership without reloading unchanged rows");
    Check(!a.presentationViewport && !a.presentationReturnFinished && a.table.contentOffset.y==220 && !a.preparingPagePreview && !a.preferences.writes,@"completed return consumes its accepted height and releases preparation scope without selecting a group");
    Check([a beginSwipePageTransitionToIndex:1 direction:1] && [a.pageTransitionContext[@"source"] isEqual:@"source"],@"the first pan after completed return immediately captures an animated neighbor");
    a=Fixture();a.presentationViewport=PendingViewport(a,nil);a.presentationReturnFinished=YES;a.dirty=YES;[a preparePageSourceForPan];
    Check(a.refreshes==1 && !a.dirty && !a.presentationViewport && Before(@"publish-source",@"restore-pending") && !a.preferences.writes,@"a completed return with dirty rows republishes the selected source before consuming saved geometry");

    a=Fixture();WESessionTabItem *third=[WESessionTabItem new];third.tabId=@"third";a.displayedTabs=[a.displayedTabs arrayByAddingObject:third];
    a.preferences.selectedTabID=@"target";a.preferences.writes=0;a.switchViewport=PendingViewport(a,@"target");a.table.tracking=YES;a.panMoving=YES;
    [a preparePageSourceForPan];
    Check(a.refreshes==1 && [a.publishedTabID isEqual:@"target"] && !a.switchViewport && a.chrome.selectedIndex==1 && a.pendingViewportRestores==1 && !a.preferences.writes,@"an accepted but unpublished selection catches up B and its pending height while the next pan is already tracking");
    Check([a beginSwipePageTransitionToIndex:2 direction:1] && [a.pageTransitionContext[@"source"] isEqual:@"target"] && [a.pageTransitionContext[@"target"] isEqual:@"third"],@"the next forward pan prepares B to C after source catch-up rather than capturing stale A");
    a=Fixture();a.switchViewport=PendingViewport(a,@"source");[a preparePageSourceForPan];
    Check(!a.refreshes && !a.switchViewport && a.pendingViewportRestores==1,@"an already-published accepted switch restores geometry without an unnecessary data refresh");

    a=Fixture();a.presentationViewport=PendingViewport(a,nil);NSDictionary *pending=a.presentationViewport;a.presentationReturnFinished=YES;a.pendingRestoreAllowed=NO;
    [a preparePageSourceForPan];
    Check(a.presentationViewport==pending && a.presentationReturnFinished && a.pendingViewportRestores==1 && !a.preparingPagePreview && !a.pageAnimator,@"a rejected real viewport restore keeps the exact pending request for a later safe retry");
    Check(![a beginSwipePageTransitionToIndex:1 direction:1] && !a.pagePreviewAttemptedTarget,@"unconsumed return geometry prevents capture without latching a cheap failure");
    a.pendingRestoreAllowed=YES;[a preparePageSourceForPan];
    Check(!a.presentationViewport && a.pendingViewportRestores==2 && [a beginSwipePageTransitionToIndex:1 direction:1],@"a later accepted shared restore recovers first-pan animation during the same horizontal gesture");
    a=Fixture();a.presentationViewport=PendingViewport(a,nil);pending=a.presentationViewport;a.presentationReturnFinished=YES;a.dirty=YES;a.publicationAllowed=NO;
    [a preparePageSourceForPan];
    Check(a.refreshes==1 && a.dirty && a.presentationViewport==pending && !a.pendingViewportRestores && !a.preparingPagePreview,@"a source refresh that cannot publish retains the return request and never restores against stale rows");
    a=Fixture();a.dirty=YES;[a preparePageSourceForPan];
    Check(a.dirty && !a.refreshes && !a.pendingViewportRestores,@"ordinary dirty data without a pending return or accepted switch still waits for gesture completion");
    a=Fixture();a.switchViewport=PendingViewport(a,@"target");pending=a.switchViewport;a.dirty=YES;[a preparePageSourceForPan];
    Check(a.switchViewport==pending && a.dirty && !a.refreshes && !a.pendingViewportRestores,@"a pending switch for a different selected target cannot republish or consume unrelated geometry");

    for (NSString *reason in @[@"unfinished-return",@"presentationSuspended",@"publishing",@"changeDepth",@"privacyRefreshPending",@"snapshotRetryAttempted",@"searching",@"nativePresentation",@"preparingPagePreview",@"restoringPagePreview",@"restoringViewport",@"swipeActive",@"menuState",@"dragging",@"decelerating",@"editing",@"native-actions",@"inactive-app",@"inactive-adapter",@"disabled-swipe",@"hidden-chrome",@"invalid-generation",@"invalid-viewport-account",@"invalid-viewport-epoch",@"invalid-height",@"blocked-policy",@"missing-policy-option",@"stale-policy",@"old-epoch",@"other-account",@"invalid-projection",@"other-projection",@"native-boundary",@"native-epoch",@"native-account"]) {
        a=Fixture();a.presentationViewport=PendingViewport(a,nil);a.presentationReturnFinished=YES;a.dirty=YES;
        if ([reason isEqual:@"unfinished-return"]) a.presentationReturnFinished=NO;
        else if ([@[@"dragging",@"decelerating",@"editing"] containsObject:reason]) [a.table setValue:@YES forKey:reason];
        else if ([reason isEqual:@"native-actions"]) a.nativeActions=@[@1];
        else if ([reason isEqual:@"inactive-app"]) appActive=NO;
        else if ([reason isEqual:@"inactive-adapter"]) a.active=NO;
        else if ([reason isEqual:@"disabled-swipe"]) swipesEnabled=NO;
        else if ([reason isEqual:@"hidden-chrome"]) a.chromeVisible=NO;
        else if ([reason hasPrefix:@"invalid-"] && ![reason isEqual:@"invalid-projection"]) {
            NSMutableDictionary *invalid=a.presentationViewport.mutableCopy;
            if ([reason isEqual:@"invalid-generation"]) invalid[@"generation"]=@99;
            else if ([reason isEqual:@"invalid-viewport-account"]) invalid[@"account"]=@"other";
            else if ([reason isEqual:@"invalid-viewport-epoch"]) invalid[@"epoch"]=@99;
            else invalid[@"height"]=@(NAN);
            a.presentationViewport=invalid;
        }
        else if ([reason isEqual:@"blocked-policy"]) policy.blocked=YES;
        else if ([reason isEqual:@"missing-policy-option"]) policy.options=@{};
        else if ([reason isEqual:@"stale-policy"]) policy.revision++;
        else if ([reason isEqual:@"old-epoch"]) a.snapshotEpoch--;
        else if ([reason isEqual:@"other-account"]) a.preferences.accountID=@"other";
        else if ([reason isEqual:@"invalid-projection"]) a.projection.valid=NO;
        else if ([reason isEqual:@"other-projection"]) a.projection.accountID=@"other";
        else if ([reason hasPrefix:@"native-"]) {
            a.usesNativeSessionModel=YES;
            if ([reason isEqual:@"native-boundary"]) coordinator.boundary=YES;
            else if ([reason isEqual:@"native-epoch"]) coordinator.epoch--;
            else coordinator.accountID=@"other";
        }
        else [a setValue:@YES forKey:reason];
        pending=a.presentationViewport;[a preparePageSourceForPan];
        Check(a.presentationViewport==pending && !a.refreshes && !a.pendingViewportRestores && !a.pageAnimator && !a.preferences.writes,
            [NSString stringWithFormat:@"%@ preserves pending return geometry and performs no unsafe source work",reason]);
    }
}
// Exercise the real owner lifecycle and its real height consumer together. A
// manually retained return viewport cannot represent the late-dirty regression:
// successful didAppear restoration has already consumed that viewport.
static NSDictionary *DepartAndResume(CSGroupListAdapter *a) {
    [CSGroupListAdapter setPresentationSuspended:YES forController:a.controller];
    NSDictionary *departure=a.presentationViewport;
    a.table.contentOffset=CGPointMake(0,480);
    [CSGroupListAdapter setPresentationSuspended:YES forController:a.controller];
    [CSGroupListAdapter setPresentationSuspended:NO forController:a.controller];
    return departure;
}
static void TrackHorizontal(CSGroupListAdapter *a) { a.table.tracking=YES;a.panMoving=YES; }
static void TestActualReturnChain(void) {
    CSGroupListAdapter *a=Fixture();a.table.routesSessionLayout=YES;
    NSDictionary *departure=DepartAndResume(a);
    Check(departure && a.presentationViewport==departure && [departure[@"height"] doubleValue]==180 && a.dirty && !a.presentationReturnFinished,
        @"real will/didDisappear retain one departure height while the covered host moves its offset");
    [a refresh];[CSGroupListAdapter finishPresentationReturnForController:a.controller];
    Check(!a.presentationViewport && !a.presentationReturnFinished && a.table.contentOffset.y==160 &&
        [a.pageSourceReturnKey isEqual:@[currentAccount,@(accountEpoch),@(a.viewportGeneration)]],
        @"real didAppear consumes accepted departure geometry but retains an independent completed-return key");
    a.dirty=YES;TrackHorizontal(a);[events removeAllObjects];NSUInteger refreshes=a.refreshes;
    [a preparePageSourceForPan];
    Check(a.refreshes==refreshes+1 && !a.dirty && !a.pageSourceReturnKey && !a.preparingPagePreview && a.table.layoutRequests==1 && a.table.nativeLayouts>=2,
        @"late dirty rows after successful return restoration synchronize on the first tracking pan and consume its key");
    Check([a beginSwipePageTransitionToIndex:1 direction:1] && Before(@"publish-source",@"capture-source") &&
        [a.pageTransitionContext[@"source"] isEqual:@"source"] && [a.pageTransitionContext[@"height"] doubleValue]==180,
        @"the first post-return gesture animates immediately from the restored and republished source");

    a=Fixture();a.table.routesSessionLayout=YES;a.table.dragging=YES;
    departure=DepartAndResume(a);a.table.dragging=NO;
    [CSGroupListAdapter finishPresentationReturnForController:a.controller];
    Check(!departure && !a.presentationViewport && a.dirty && a.pageSourceReturnKey && !a.pendingViewportRestores,
        @"a departure during native dragging records completion even when no viewport can be captured");
    TrackHorizontal(a);[a preparePageSourceForPan];
    Check(!a.dirty && !a.pageSourceReturnKey && !a.presentationViewport && [a beginSwipePageTransitionToIndex:1 direction:1],
        @"a captureless return catches up dirty source rows on its first gesture");

    a=Fixture();a.table.routesSessionLayout=YES;departure=DepartAndResume(a);
    [CSGroupListAdapter finishPresentationReturnForController:a.controller];
    Check(a.presentationViewport==departure && a.presentationReturnFinished && a.dirty && a.pageSourceReturnKey,
        @"dirty didAppear leaves the real departure height pending instead of restoring against unpublished rows");
    TrackHorizontal(a);[events removeAllObjects];[a preparePageSourceForPan];
    Check(!a.presentationViewport && !a.pageSourceReturnKey && !a.dirty && a.table.contentOffset.y==160 &&
        Before(@"publish-source",@"restore-height") && [a beginSwipePageTransitionToIndex:1 direction:1],
        @"a delayed return publication restores its real height while tracking and animates the same first pan");

    a=Fixture();a.table.dragging=YES;
    [CSGroupListAdapter setPresentationSuspended:YES forController:a.controller];
    // attachToController creates a fresh adapter when the owner's real table
    // is replaced. Reproduce that boundary with the same native owner.
    NSObject *returningController=a.controller;
    a=Fixture();a.controller=returningController;objc_setAssociatedObject(returningController,&AdapterKey,a,OBJC_ASSOCIATION_ASSIGN);
    a.table.routesSessionLayout=YES;a.table.contentOffset=CGPointMake(0,480);a.dirty=YES;
    [CSGroupListAdapter setPresentationSuspended:NO forController:returningController];
    [a prepareInitialViewport];[CSGroupListAdapter finishPresentationReturnForController:a.controller];
    Check(a.initialViewportPending && a.pageSourceReturnKey && a.table.contentOffset.y==480,
        @"a captureless returned adapter may still have a real armed startup viewport");
    NSUInteger heightRestores=a.heightRestores;TrackHorizontal(a);[a preparePageSourceForPan];
    Check(!a.initialViewportPending && a.heightRestores==heightRestores && a.table.contentOffset.y==480 &&
        [a beginSwipePageTransitionToIndex:1 direction:1] && [a.pageTransitionContext[@"height"] doubleValue]==500,
        @"the completed-return gesture cancels startup positioning before source preparation and preserves the user's current height");

    a=Fixture();a.table.routesSessionLayout=YES;a.usesNativeSessionModel=YES;departure=DepartAndResume(a);
    coordinator.revision++;[a.table layoutIfNeeded];
    Check(a.sessionLayoutHeld && !a.table.nativeLayouts,@"a mismatched native revision actually withholds the host layout and holds publication geometry");
    [CSGroupListAdapter finishPresentationReturnForController:a.controller];
    __weak CSGroupListAdapter *weak=a;a.onRefresh=^{ weak.nativeModelRevision=coordinator.revision; };
    TrackHorizontal(a);[a preparePageSourceForPan];
    Check(!a.sessionLayoutHeld && !a.presentationViewport && !a.pageSourceReturnKey && a.table.layoutRequests==1 && a.table.nativeLayouts==1 &&
        a.nativeModelRevision==coordinator.revision && [a beginSwipePageTransitionToIndex:1 direction:1],
        @"a return refresh updates the native revision and a requested real verified layout releases its hold before first capture");

    a=Fixture();a.table.routesSessionLayout=YES;a.sessionLayoutHeld=YES;
    a.preferences.selectedTabID=@"target";a.preferences.writes=0;a.switchViewport=PendingViewport(a,@"target");
    TrackHorizontal(a);[a preparePageSourceForPan];
    Check(!a.sessionLayoutHeld && !a.switchViewport && a.table.nativeLayouts==1 && a.table.layoutRequests==1 &&
        [a.publishedTabID isEqual:@"target"] && [a beginSwipePageTransitionToIndex:0 direction:-1],
        @"an accepted switch also releases an existing layout hold only through the verified host layout");

    a=Fixture();a.table.dragging=YES;DepartAndResume(a);a.table.dragging=NO;
    [CSGroupListAdapter finishPresentationReturnForController:a.controller];a.sessionLayoutHeld=YES;TrackHorizontal(a);
    NSArray *key=a.pageSourceReturnKey;[a preparePageSourceForPan];
    Check(a.refreshes==1 && a.sessionLayoutHeld && a.pageSourceReturnKey==key && !a.table.nativeLayouts &&
        ![a beginSwipePageTransitionToIndex:1 direction:1],
        @"source preparation cannot directly clear a held layout when layoutIfNeeded never reaches the host hook");
    a.table.routesSessionLayout=YES;[a preparePageSourceForPan];
    Check(!a.sessionLayoutHeld && !a.pageSourceReturnKey && a.table.nativeLayouts==1 && [a beginSwipePageTransitionToIndex:1 direction:1],
        @"the retained return key retries safely once the real layout hook can execute during the same pan");

    for(NSString *reason in @[@"blocked-policy",@"changed-epoch"]) {
        a=Fixture();a.table.routesSessionLayout=YES;a.table.dragging=YES;DepartAndResume(a);a.table.dragging=NO;
        [CSGroupListAdapter finishPresentationReturnForController:a.controller];a.sessionLayoutHeld=YES;TrackHorizontal(a);key=a.pageSourceReturnKey;
        a.table.onNativeLayout=^{ if([reason isEqual:@"blocked-policy"])policy.blocked=YES;else accountEpoch++; };
        [a preparePageSourceForPan];
        Check(a.table.nativeLayouts==1 && a.sessionLayoutHeld && a.privacyRefreshPending && a.pageSourceReturnKey==key &&
            ![a beginSwipePageTransitionToIndex:1 direction:1] && !a.pagePreviewAttemptedTarget,
            [NSString stringWithFormat:@"%@ during the real source layout keeps the hold and prevents any capture",reason]);
    }

    for(NSString *reason in @[@"wrong-account-key",@"old-epoch-key",@"old-generation-key",@"privacyRefreshPending",@"snapshotRetryAttempted",@"dragging",@"native-boundary"]) {
        a=Fixture();a.table.routesSessionLayout=YES;a.table.dragging=YES;DepartAndResume(a);a.table.dragging=NO;
        [CSGroupListAdapter finishPresentationReturnForController:a.controller];key=a.pageSourceReturnKey;TrackHorizontal(a);
        if([reason isEqual:@"wrong-account-key"])a.pageSourceReturnKey=@[@"other",@(accountEpoch),@(a.viewportGeneration)];
        else if([reason isEqual:@"old-epoch-key"])a.pageSourceReturnKey=@[currentAccount,@(accountEpoch-1),@(a.viewportGeneration)];
        else if([reason isEqual:@"old-generation-key"])a.pageSourceReturnKey=@[currentAccount,@(accountEpoch),@(a.viewportGeneration-1)];
        else if([reason isEqual:@"dragging"])a.table.dragging=YES;
        else if([reason isEqual:@"native-boundary"]){a.usesNativeSessionModel=YES;coordinator.boundary=YES;}
        else[a setValue:@YES forKey:reason];
        key=a.pageSourceReturnKey;[a preparePageSourceForPan];
        Check(!a.refreshes && !a.table.nativeLayouts && a.pageSourceReturnKey==key && a.dirty &&
            ![a beginSwipePageTransitionToIndex:1 direction:1],
            [NSString stringWithFormat:@"%@ refuses source work despite a completed captureless return",reason]);
    }

    for(NSString *reason in @[@"table",@"controller",@"generation",@"selection",@"return-key"]) {
        a=Fixture();a.table.routesSessionLayout=YES;a.table.dragging=YES;DepartAndResume(a);a.table.dragging=NO;
        [CSGroupListAdapter finishPresentationReturnForController:a.controller];TrackHorizontal(a);key=a.pageSourceReturnKey;
        __weak CSGroupListAdapter *returning=a;UITableView *sourceTable=a.table;
        a.table.onNativeLayout=^{
            if([reason isEqual:@"table"]) returning.table=[UITableView new];
            else if([reason isEqual:@"controller"])returning.controller=[NSObject new];
            else if([reason isEqual:@"generation"])returning.viewportGeneration++;
            else if([reason isEqual:@"selection"])returning.preferences.selectedTabID=@"target";
            else returning.pageSourceReturnKey=[returning.pageSourceReturnKey arrayByAddingObject:@"new-command"];
        };
        [a preparePageSourceForPan];
        Check(sourceTable.nativeLayouts==1 && a.pendingViewportRestores==1 && !a.preparingPagePreview &&
            ([reason isEqual:@"return-key"] ? a.pageSourceReturnKey!=key : a.pageSourceReturnKey==key),
            [NSString stringWithFormat:@"%@ replacement inside native layout stops the old helper before its second restore or key consumption",reason]);
    }
}
static void TestPreviewAndCommit(void) {
    CSGroupListAdapter *a=Fixture(); a.table.tracking=YES; a.panMoving=YES;
    Check([a beginSwipePageTransitionToIndex:1 direction:1],@"horizontal tracking admits a clean preview without waiting for release");
    CSGroupPageAnimator *animator=a.pageAnimator;
    Check(Before(@"capture-source",@"publish-target") && Before(@"publish-target",@"capture-target") && Before(@"layout",@"capture-target"),@"real source is covered before transient target publication and incoming capture follows layout");
    Check([a.preferences.selectedTabID isEqual:@"source"] && !a.preferences.writes && !a.pageSelectionAccepted,@"preview publication never commits the user's selected group");
    Check([a.publishedTabID isEqual:@"target"] && [a.pagePreviewTabID isEqual:@"target"] && a.heightRestores==1 && a.lastRestoredHeight==180,@"preview captures the actual target with the source scroll height");
    Check(animator.begins==1 && animator.prepares==1 && !animator.settles && [a pageTransitionTargetIsReady],@"prepared target remains interactive with no settle animation before release");
    [animator updateTranslation:-125]; a.pageReleaseVelocity=-600;
    a.chrome.interactiveTransition=YES;a.chrome.indicatorProgress=.3125;[events removeAllObjects];
    [a selectSwipeIndex:1 direction:1];
    Check(a.preferences.writes==1 && [a.preferences.selectedTabID isEqual:@"target"] && a.pageSelectionAccepted,@"confirmation writes the selected target exactly once");
    Check(!a.pagePreviewTabID && [a.publishedTabID isEqual:@"target"] && !a.directSelections,@"confirmation ends the override and preserves the actual committed target");
    Check(animator.settles==1 && animator.lastCommit && animator.lastVelocity==-600 && animator.translation==-125 && animator.begins==1 && animator.prepares==1,@"confirmation settles from existing progress and velocity without recapturing either page");
    Check(Before(@"write-selection",@"publish-target") && Before(@"publish-target",@"settle-commit") && a.chrome.selectedIndex==1 && !a.anchors[@"target"] && foldedRefreshes==1,@"accepted preference precedes target reveal and dependent selection effects run once");
    Check(a.chrome.animatedSelections==1 && !a.chrome.staticSelections && a.chrome.indicatorMoving && fabs(a.chrome.lastAnimatedStartProgress-.3125)<.0001,@"confirmation starts the indicator's animated settle from finger progress before a nonanimated publication acknowledgement can consume selection");
    Check(Before(@"write-selection",@"select-indicator-animated") && Before(@"select-indicator-animated",@"publish-target") && ![events containsObject:@"select-indicator-static"],@"the accepted animated selection precedes preview-exit publication while the refresh becomes a stable-ID acknowledgement");
    NSUInteger acknowledgements=a.chrome.selectionAcknowledgements;[a refresh];
    Check(a.chrome.selectionAcknowledgements==acknowledgements+1 && a.chrome.animatedSelections==1 && !a.chrome.staticSelections && a.chrome.indicatorMoving && !a.chrome.interactiveTransition,@"passive target publication during page settling preserves the indicator animation without duplicate selection effects");
    [a finishPageTransitionIfReady]; Check(animator.settles==1,@"layout reentry cannot schedule a duplicate settle");
    animator.completion(YES); Check(!a.pageAnimator && !a.pageTransitionContext && !a.pageSelectionAccepted,@"current settle completion releases every transition handle");
}
static void TestRollbackAndRejectedWrite(void) {
    CSGroupListAdapter *a=Fixture(); [a beginSwipePageTransitionToIndex:1 direction:1];
    CSGroupPageAnimator *animator=a.pageAnimator; [animator updateTranslation:-90]; [events removeAllObjects];
    [a rollbackPageTransitionWithVelocity:120];
    Check(!a.preferences.writes && [a.preferences.selectedTabID isEqual:@"source"] && [a.publishedTabID isEqual:@"source"] && !a.pagePreviewTabID,@"cancel restores the actual source without writing preferences");
    Check(a.chrome.selectedIndex==0 && !a.chrome.animatedSelections && !a.chrome.staticSelections,@"rollback publication only acknowledges the original indicator selection without animating an unaccepted neighbor");
    Check(animator.settles==1 && !animator.lastCommit && animator.lastVelocity==120 && animator.translation==-90 && Before(@"publish-source",@"settle-source") && Before(@"restore-height",@"settle-source"),@"source model and viewport restore beneath the cover before rebound starts");
    animator.completion(NO); NSUInteger generation=a.pageTransitionGeneration; [a cancelPageTransition];
    Check(!a.pageAnimator && !a.pageTransitionContext && a.pageTransitionGeneration==generation,@"completed rollback cleanup is idempotent");
    a=Fixture(); [a beginSwipePageTransitionToIndex:1 direction:1]; animator=a.pageAnimator; a.preferences.rejectsWrites=YES;
    [a selectSwipeIndex:1 direction:1];
    Check(a.preferences.writes==1 && [a.preferences.selectedTabID isEqual:@"source"] && [a.publishedTabID isEqual:@"source"] && animator.settles==1 && !animator.lastCommit,@"a rejected preference write rebounds to the real source instead of revealing an unaccepted target");
    Check(!a.chrome.animatedSelections && a.chrome.selectedIndex==0,@"rejected selection never begins a target indicator settle");
    a=Fixture(); animationEnabled=NO; [a selectSwipeIndex:1 direction:1];
    Check(a.directSelections==1 && a.preferences.writes==1 && !a.pageAnimator,@"disabled animation retains the established direct selection route");
}
static void TestPublicationBarriers(void) {
    for (NSString *key in @[@"publishing",@"dirty",@"changeDepth",@"privacyRefreshPending",@"sessionLayoutHeld",@"snapshotRetryAttempted",@"initialViewportPending",@"swipeActive",@"menuState"]) {
        CSGroupListAdapter *a=Ready(); CSGroupPageAnimator *animator=a.pageAnimator;
        [a setValue:@1 forKey:key]; [a finishPageTransitionIfReady];
        Check(!animator.settles,[NSString stringWithFormat:@"%@ blocks motion until publication is safe",key]);
    }
    for (NSString *key in @[@"dragging",@"decelerating",@"editing"]) {
        CSGroupListAdapter *a=Ready(); CSGroupPageAnimator *animator=a.pageAnimator;
        [a.table setValue:@YES forKey:key]; [a finishPageTransitionIfReady];
        Check(!animator.settles,[NSString stringWithFormat:@"table %@ blocks moving viewport admission",key]);
    }
    for (NSString *key in @[@"switchViewport",@"presentationViewport"]) {
        CSGroupListAdapter *a=Ready(); CSGroupPageAnimator *animator=a.pageAnimator;
        [a setValue:@{} forKey:key]; [a finishPageTransitionIfReady];
        Check(!animator.settles,[NSString stringWithFormat:@"%@ must be consumed before motion",key]);
    }
    CSGroupListAdapter *a=Ready(); CSGroupPageAnimator *animator=a.pageAnimator;
    a.projection.valid=NO; [a finishPageTransitionIfReady]; Check(!animator.settles,@"invalid projection cannot settle");
    a.projection.valid=YES; a.publishedTabID=@"source"; [a finishPageTransitionIfReady]; Check(!animator.settles,@"preference acceptance cannot substitute for actual target publication");
    a.publishedTabID=@"target"; a.snapshotEpoch=6; [a finishPageTransitionIfReady]; Check(!animator.settles,@"old-epoch rows cannot settle");
    a.snapshotEpoch=7; a.projection.privacyRevision=10; [a finishPageTransitionIfReady]; Check(!animator.settles,@"old-policy rows cannot settle");
    a.projection.privacyRevision=11; a.projection.accountID=@"other"; [a finishPageTransitionIfReady]; Check(!animator.settles,@"another account's projection cannot settle");
    a.projection.accountID=currentAccount; [a finishPageTransitionIfReady]; Check(animator.settles==1,@"fully proven target settles exactly once");
}
static void TestNativePreviewAndRevision(void) {
    CSGroupListAdapter *a=Fixture(); a.usesNativeSessionModel=YES;
    Check([a beginSwipePageTransitionToIndex:1 direction:1] && coordinator.previewBegins==1 && coordinator.previewOwner==a.controller,@"native path requests a transient preview owned by this controller");
    Check(!a.preferences.writes && [coordinator.previewTarget isEqual:@"target"],@"native preview remains independent of saved selection");
    coordinator.fullProofs=coordinator.tokenProofs=0;[a cancelInvalidPageTransition];[a cancelInvalidPageTransition];
    Check(coordinator.tokenProofs==2 && !coordinator.fullProofs && a.pageAnimator.active,@"per-frame context validation uses lightweight native ownership tokens without rebuilding full proof");
    [a rollbackPageTransitionWithVelocity:0];
    Check(coordinator.previewEnds==1 && !coordinator.previewOwner && [a.publishedTabID isEqual:@"source"],@"native cancel ends only this preview before restoring source publication");
    a=Fixture(); a.usesNativeSessionModel=YES; coordinator.previewAllowed=NO;
    Check(![a beginSwipePageTransitionToIndex:1 direction:1] && !a.pageAnimator && !a.pagePreviewTabID && !a.preferences.writes,@"coordinator preview rejection leaves no cover or saved-selection mutation");
    a=Ready(); a.usesNativeSessionModel=YES;
    NSMutableDictionary *context=a.pageTransitionContext.mutableCopy; context[@"nativeModel"]=@YES; a.pageTransitionContext=context;
    CSGroupPageAnimator *animator=a.pageAnimator;
    coordinator.boundary=YES; [a finishPageTransitionIfReady]; Check(!animator.settles,@"open native-model transaction blocks settle");
    coordinator.boundary=NO; coordinator.revision=51; [a finishPageTransitionIfReady]; Check(!animator.settles,@"coordinator revision must match published native rows");
    coordinator.revision=50; coordinator.epoch=8; [a finishPageTransitionIfReady]; Check(!animator.settles,@"native coordinator epoch must match current account");
    coordinator.epoch=7; coordinator.accountID=@"other"; [a finishPageTransitionIfReady]; Check(!animator.settles,@"native coordinator account must match current account");
    coordinator.accountID=currentAccount; [a finishPageTransitionIfReady]; Check(animator.settles==1,@"proven native target uses the same single settle path");
}
static void TestInvalidation(void) {
    for (NSString *key in @[@"searching",@"presentationSuspended",@"nativePresentation"]) {
        CSGroupListAdapter *a=Fixture(); [a beginSwipePageTransitionToIndex:1 direction:1]; CSGroupPageAnimator *animator=a.pageAnimator;
        [a setValue:@YES forKey:key]; [events removeAllObjects]; [a cancelInvalidPageTransition];
        Check(!a.pageAnimator && !a.pagePreviewTabID && animator.cancellations==1 && Before(@"cancel-pixels",@"publish-source"),[NSString stringWithFormat:@"%@ removes old pixels before restoring source state",key]);
    }
    for (NSString *reason in @[@"motion",@"setting",@"policy",@"epoch",@"account",@"blocked",@"geometry",@"model"]) {
        CSGroupListAdapter *a=Fixture(); [a beginSwipePageTransitionToIndex:1 direction:1]; CSGroupPageAnimator *animator=a.pageAnimator;
        if ([reason isEqual:@"motion"]) reducedMotion=YES;
        else if ([reason isEqual:@"setting"]) animationEnabled=NO;
        else if ([reason isEqual:@"policy"]) policy.revision++;
        else if ([reason isEqual:@"epoch"]) accountEpoch++;
        else if ([reason isEqual:@"account"]) currentAccount=@"other";
        else if ([reason isEqual:@"blocked"]) policy.blocked=YES;
        else if ([reason isEqual:@"geometry"]) animator.matches=NO;
        else a.modelRevision++;
        [a cancelInvalidPageTransition];
        Check(!a.pageAnimator && !a.pagePreviewTabID && !a.preferences.writes && animator.cancellations==1,[NSString stringWithFormat:@"%@ invalidation cannot retain a preview or commit selection",reason]);
    }
    CSGroupListAdapter *a=Fixture(); a.usesNativeSessionModel=YES; [a beginSwipePageTransitionToIndex:1 direction:1]; coordinator.tokenValid=NO; [a cancelInvalidPageTransition];
    Check(!a.pageAnimator && !a.pagePreviewTabID && coordinator.previewEnds==1,@"invalid native preview ownership cancels copied pixels and releases its override");
    a=Fixture();a.usesNativeSessionModel=YES;[a beginSwipePageTransitionToIndex:1 direction:1];coordinator.previewValid=NO;
    Check([a pageTransitionContextIsValid] && ![a pageTransitionTargetIsReady],@"light ownership validation cannot substitute for full release publication proof");
    [a selectSwipeIndex:1 direction:1];
    Check(!a.pageAnimator && !a.pagePreviewTabID && !a.preferences.writes,@"failed full native proof at release cancels preview before any selection write");
    a=Fixture(); [a beginSwipePageTransitionToIndex:1 direction:1]; [a preparePageTransitionForSelection:1];
    Check(!a.pageAnimator && !a.pagePreviewTabID && !a.preferences.writes,@"a tab tap cancels even a matching pan preview before normal selection");
    a=Fixture(); [a beginSwipePageTransitionToIndex:1 direction:1]; NSUInteger restores=a.heightRestores;
    currentAccount=@"other";a.preferences.accountID=currentAccount;[a cancelPageTransition];
    Check(!a.pageAnimator && !a.pagePreviewTabID && a.heightRestores==restores && [a.preferences.selectedTabID isEqual:@"source"],@"same tab identifier in a new account cannot receive the old account's captured scroll height");
}
static void TestReentryAndStaleCompletion(void) {
    CSGroupListAdapter *a=Fixture(); __weak CSGroupListAdapter *weakAdapter=a;
    duringIncomingCapture=^{ weakAdapter.dirty=YES; };
    Check(![a beginSwipePageTransitionToIndex:1 direction:1] && !a.pageAnimator && !a.pagePreviewTabID && !a.preferences.writes,@"incoming snapshot that synchronously marks dirty fails the complete readiness proof");
    a=Fixture(); weakAdapter=a; duringSourceCapture=^{ weakAdapter.modelRevision++; };
    Check(![a beginSwipePageTransitionToIndex:1 direction:1] && !a.pageAnimator && !a.pagePreviewTabID && !a.refreshes,@"source snapshot mutation rejects preview before publishing any neighbor");
    a=Ready(); CSGroupPageAnimator *animator=a.pageAnimator; weakAdapter=a;
    duringSettle=^{ [weakAdapter finishPageTransitionIfReady]; };
    [a finishPageTransitionIfReady]; Check(animator.settles==1 && !a.checkingPageTransition,@"synchronous settle reentry cannot start a second settle or leave its guard latched");
    a=Ready(); animator=a.pageAnimator; weakAdapter=a; duringSettle=^{ weakAdapter.dirty=YES; };
    [a finishPageTransitionIfReady]; Check(animator.settles==1 && !animator.motions && !a.pageAnimator,@"settle readiness recovery rejects visual motion without relying on a revision change");
    a=Fixture(); [a beginSwipePageTransitionToIndex:1 direction:1]; animator=a.pageAnimator; [a selectSwipeIndex:1 direction:1];
    void (^oldCompletion)(BOOL)=animator.completion; [a cancelPageTransition];
    Check([a beginSwipePageTransitionToIndex:0 direction:-1],@"a new gesture can preview back from the last committed target");
    CSGroupPageAnimator *second=a.pageAnimator; NSDictionary *context=a.pageTransitionContext; NSUInteger generation=a.pageTransitionGeneration;
    oldCompletion(YES);
    Check(a.pageAnimator==second && a.pageTransitionContext==context && a.pageTransitionGeneration==generation && second.active,@"old settle completion cannot clear a newer preview or advance its generation");
    [second updateTranslation:45];oldCompletion(NO);
    Check(a.pageAnimator==second && a.pageTransitionContext==context && second.translation==45 && a.preferences.writes==1,@"an obsolete completion during the next drag cannot change its pixels, identity or saved selection");
    [a selectSwipeIndex:0 direction:-1];oldCompletion(YES);
    Check(a.pageAnimator==second && a.pageTransitionContext==context && second.animating && a.preferences.writes==2 && [a.preferences.selectedTabID isEqual:@"source"],@"an obsolete first completion after the second end cannot cancel its newer accepted settle");
    a=Fixture();[a beginSwipePageTransitionToIndex:1 direction:1];weakAdapter=a;
    CSGroupPageAnimator *replacement=[CSGroupPageAnimator new];replacement.active=replacement.matches=YES;
    NSDictionary *replacementContext=@{@"new":@YES};
    duringCancellation=^{ weakAdapter.pageAnimator=replacement;weakAdapter.pageTransitionContext=replacementContext;weakAdapter.pagePreviewTabID=@"new-preview";weakAdapter.pageTransitionGeneration++; };
    [a cancelPageTransition];
    Check(a.pageAnimator==replacement && a.pageTransitionContext==replacementContext && [a.pagePreviewTabID isEqual:@"new-preview"] && replacement.active,@"synchronous pixel cancellation cannot clear a replacement session installed by its callback");
    a=Fixture();[a beginSwipePageTransitionToIndex:1 direction:1];weakAdapter=a;
    replacement=[CSGroupPageAnimator new];replacement.active=replacement.matches=YES;replacementContext=@{@"new-selection":@YES};
    a.preferences.onSelectionWrite=^{ weakAdapter.pageAnimator=replacement;weakAdapter.pageTransitionContext=replacementContext;weakAdapter.pageTransitionGeneration++; };
    [a selectSwipeIndex:1 direction:1];
    Check(a.pageAnimator==replacement && a.pageTransitionContext==replacementContext && !a.chrome.selections && !a.titles && !foldedRefreshes,@"preference-write reentry cannot apply old confirmation effects to its replacement session");
}
static void TestAcceptedSelectionReentry(void) {
    for (NSNumber *replace in @[@NO,@YES]) {
        CSGroupListAdapter *a=Fixture();[a beginSwipePageTransitionToIndex:1 direction:1];
        CSGroupPageAnimator *oldAnimator=a.pageAnimator,*replacement=[CSGroupPageAnimator new];replacement.active=replacement.matches=YES;
        NSDictionary *replacementContext=@{@"source":@"target",@"target":@"new-target",@"account":currentAccount,@"epoch":@(accountEpoch),@"height":@240};
        __weak CSGroupListAdapter *weakAdapter=a;__block NSUInteger refreshesAfterReentry=0,generationAfterReentry=0,callbacks=0;
        a.chrome.onAnimatedSelection=^{
            CSGroupListAdapter *adapter=weakAdapter;callbacks++;adapter.chrome.onAnimatedSelection=nil;
            if (replace.boolValue) {
                adapter.pageAnimator=replacement;adapter.pageTransitionContext=replacementContext;
                adapter.pagePreviewTabID=@"new-preview";adapter.pageSelectionAccepted=NO;adapter.pageTransitionGeneration++;
            } else [adapter cancelPageTransition];
            adapter.anchors[@"target"]=@73;
            refreshesAfterReentry=adapter.refreshes;generationAfterReentry=adapter.pageTransitionGeneration;
        };
        [a selectSwipeIndex:1 direction:1];
        Check(callbacks==1 && a.preferences.writes==1 && a.chrome.animatedSelections==1,@"accepted indicator animation permits one synchronous lifecycle interruption after the accepted preference write");
        Check(a.refreshes==refreshesAfterReentry && a.pageTransitionGeneration==generationAfterReentry && !a.titles && !foldedRefreshes && !oldAnimator.settles && [a.anchors[@"target"] isEqual:@73],@"the first post-animation identity guard prevents old preview restore, anchor cleanup, title and folded-list effects after synchronous interruption");
        Check(replace.boolValue ? (a.pageAnimator==replacement && a.pageTransitionContext==replacementContext && [a.pagePreviewTabID isEqual:@"new-preview"] && replacement.active) : (!a.pageAnimator && !a.pageTransitionContext && !a.pagePreviewTabID),@"the post-animation identity guard preserves both a synchronous cancellation and a replacement preview");
    }
    CSGroupListAdapter *a=Fixture();[a beginSwipePageTransitionToIndex:1 direction:1];
    CSGroupPageAnimator *oldAnimator=a.pageAnimator,*replacement=[CSGroupPageAnimator new];replacement.active=replacement.matches=YES;
    NSDictionary *replacementContext=@{@"source":@"target",@"target":@"next-target",@"account":currentAccount,@"epoch":@(accountEpoch),@"height":@300};
    __weak CSGroupListAdapter *weakAdapter=a;__block NSUInteger callbacks=0,refreshesAfterReentry=0,generationAfterReentry=0;
    a.onRefresh=^{
        CSGroupListAdapter *adapter=weakAdapter;callbacks++;adapter.onRefresh=nil;
        adapter.pageAnimator=replacement;adapter.pageTransitionContext=replacementContext;adapter.pagePreviewTabID=@"next-preview";
        adapter.pageSelectionAccepted=NO;adapter.pageTransitionGeneration++;adapter.anchors[@"target"]=@91;
        refreshesAfterReentry=adapter.refreshes;generationAfterReentry=adapter.pageTransitionGeneration;
    };
    [a selectSwipeIndex:1 direction:1];
    Check(callbacks==1 && a.preferences.writes==1 && a.chrome.animatedSelections==1 && a.refreshes==refreshesAfterReentry,@"preview-exit refresh can synchronously replace the session after the accepted indicator animation without repeating publication");
    Check(a.pageAnimator==replacement && a.pageTransitionContext==replacementContext && a.pageTransitionGeneration==generationAfterReentry && [a.pagePreviewTabID isEqual:@"next-preview"] && replacement.active,@"the second post-restore identity guard preserves a session installed during preview-exit refresh");
    Check([a.anchors[@"target"] isEqual:@91] && !a.titles && !foldedRefreshes && !oldAnimator.settles && !replacement.settles,@"the second post-restore identity guard protects the replacement anchor and prevents old title, folded-list and settle effects");
}
static void TestBeginAdmission(void) {
    for (NSString *key in @[@"dirty",@"publishing",@"changeDepth",@"privacyRefreshPending",@"sessionLayoutHeld",@"snapshotRetryAttempted",@"swipeActive",@"preparingPagePreview",@"restoringPagePreview"]) {
        CSGroupListAdapter *a=Fixture(); [a setValue:@YES forKey:key];
        Check(![a beginSwipePageTransitionToIndex:1 direction:1] && !a.pageAnimator && !a.pagePreviewAttemptedTarget && !a.preferences.writes,[NSString stringWithFormat:@"%@ source refuses unsafe snapshot admission without latching an unattempted target",key]);
    }
    for (NSString *key in @[@"dragging",@"decelerating",@"editing"]) {
        CSGroupListAdapter *a=Fixture(); [a.table setValue:@YES forKey:key];
        Check(![a beginSwipePageTransitionToIndex:1 direction:1],[NSString stringWithFormat:@"table %@ cannot become a page preview",key]);
    }
    CSGroupListAdapter *a=Fixture(); animationEnabled=NO; Check(![a beginSwipePageTransitionToIndex:1 direction:1],@"disabled independent setting avoids snapshots");
    a=Fixture(); reducedMotion=YES; Check(![a beginSwipePageTransitionToIndex:1 direction:1],@"Reduce Motion avoids interactive snapshot admission");
    a=Fixture(); Check(![a beginSwipePageTransitionToIndex:0 direction:-1],@"same-group target never creates a preview");
    a=Fixture(); a.table.contentOffset=CGPointMake(0,NAN); Check(![a beginSwipePageTransitionToIndex:1 direction:1],@"nonfinite source height never reaches snapshot publication");
    a=Fixture(); a.publicationAllowed=NO; Check(![a beginSwipePageTransitionToIndex:1 direction:1] && !a.pageAnimator && !a.preferences.writes,@"requested preview alone cannot substitute for actual target publication");
    Check([a.pagePreviewAttemptedTarget isEqual:@"target"],@"a hard incoming snapshot failure records the attempted target for its caller's per-gesture lock");
    a=Fixture();a.dirty=YES;[a beginSwipePageTransitionToIndex:1 direction:1];a.dirty=NO;
    Check([a beginSwipePageTransitionToIndex:1 direction:1] && !a.pagePreviewAttemptedTarget,@"a cheap busy guard can recover without a new gesture and successful capture clears the failure lock");
}
int main(void) { @autoreleasepool {
    TestFirstPanSourcePreparation(); TestActualReturnChain(); TestPreviewAndCommit(); TestRollbackAndRejectedWrite(); TestPublicationBarriers(); TestNativePreviewAndRevision(); TestInvalidation(); TestReentryAndStaleCompletion(); TestAcceptedSelectionReentry(); TestBeginAdmission();
    fprintf(stdout,"Group page lifecycle: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
    return failures ? 1 : 0;
} }
