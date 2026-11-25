// Actual adapter method bodies, isolated geometry/account/policy doubles.
// These tests do not render UIKit or change the user's preferences or data.
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <objc/runtime.h>
#import <math.h>

typedef struct { CGFloat top,left,bottom,right; } UIEdgeInsets;
@interface NSIndexPath (GroupInitialViewport)
+ (instancetype)indexPathForRow:(NSInteger)row inSection:(NSInteger)section;
@end
@implementation NSIndexPath (GroupInitialViewport)
+ (instancetype)indexPathForRow:(NSInteger)row inSection:(NSInteger)section {
    NSUInteger indexes[]={(NSUInteger)section,(NSUInteger)row};
    return [self indexPathWithIndexes:indexes length:2];
}
@end

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
- (void)setFrame:(CGRect)frame { _frame=frame; _bounds.size=frame.size; }
- (void)addSubview:(UIView *)view { view.superview=self; }
- (BOOL)isDescendantOfView:(UIView *)view {
    for (UIView *node=self;node;node=node.superview) if (node==view) return YES;
    return NO;
}
- (CGRect)convertRect:(CGRect)rect toView:(UIView *)view {
    UIView *node=self;
    while (node && node!=view) {
        rect=CGRectOffset(rect,node.frame.origin.x-node.bounds.origin.x,node.frame.origin.y-node.bounds.origin.y);
        node=node.superview;
    }
    NSCAssert(node==view,@"Fixture converts only to an ancestor");
    return rect;
}
@end
@interface TestChrome : UIView
@property(nonatomic,copy) NSString *selectedTabID;
@end
@implementation TestChrome @end
@interface UITableView : UIView
@property(nonatomic) CGSize contentSize;
@property(nonatomic) CGPoint contentOffset;
@property(nonatomic) UIEdgeInsets adjustedContentInset;
@property(nonatomic) BOOL tracking,dragging,decelerating,editing;
@property(nonatomic) NSUInteger offsetWrites,layouts;
@property(nonatomic,copy) void (^onOffsetWrite)(void);
@property(nonatomic,strong) NSArray<NSIndexPath *> *indexPathsForVisibleRows;
@property(nonatomic,strong) NSDictionary<NSIndexPath *,NSNumber *> *rowOrigins;
- (void)setContentOffset:(CGPoint)point animated:(BOOL)animated;
- (void)layoutIfNeeded;
- (CGRect)rectForRowAtIndexPath:(NSIndexPath *)path;
@end
@implementation UITableView
- (void)setContentOffset:(CGPoint)point animated:(BOOL)animated {
    NSCAssert(!animated,@"Startup restoration must not animate");
    self.offsetWrites++; self.contentOffset=point;
    void (^callback)(void)=self.onOffsetWrite;
    if (callback) callback();
}
- (void)layoutIfNeeded { self.layouts++; }
- (CGRect)rectForRowAtIndexPath:(NSIndexPath *)path { return CGRectMake(0,[self.rowOrigins[path] doubleValue],390,80); }
@end
@interface HostController : NSObject
@property(nonatomic) BOOL isSearching,folded;
@end
@implementation HostController @end
@interface WESessionTabItem : NSObject
@property(nonatomic,copy) NSString *tabId;
@end
@implementation WESessionTabItem @end
@interface CSGroupPreferences : NSObject
@property(nonatomic,copy) NSString *accountID,*selectedTabID;
@property(nonatomic,strong) NSArray<WESessionTabItem *> *tabs;
@end
@implementation CSGroupPreferences @end
@interface CSGroupRow : NSObject
@property(nonatomic,copy) NSString *userName;
@property(nonatomic) NSUInteger kind;
@end
@implementation CSGroupRow @end
@interface CSGroupProjection : NSObject
@property(nonatomic,copy) NSString *accountID;
@property(nonatomic) BOOL isValid;
@property(nonatomic) NSUInteger privacyRevision;
@property(nonatomic,strong) NSArray<NSArray<CSGroupRow *> *> *sections;
- (CSGroupRow *)rowAtDisplayPath:(NSIndexPath *)path;
- (void)discardComputationCache;
@end
@implementation CSGroupProjection
- (CSGroupRow *)rowAtDisplayPath:(NSIndexPath *)path {
    if (!path || path.length!=2) return nil;
    NSUInteger s=[path indexAtPosition:0],r=[path indexAtPosition:1];
    return s<self.sections.count && r<self.sections[s].count ? self.sections[s][r] : nil;
}
- (void)discardComputationCache {}
@end
@interface CSCloseFriendSnapshot : NSObject
@property(nonatomic,copy) NSString *accountID;
@property(nonatomic) NSUInteger revision;
@property(nonatomic) BOOL blocked;
@property(nonatomic,strong) NSDictionary *options;
@end
@implementation CSCloseFriendSnapshot @end
@interface CSGroupNativeSessionCoordinator : NSObject
@property(nonatomic,copy) NSString *accountID;
@property(nonatomic) NSUInteger epoch,revision;
@property(nonatomic) BOOL boundary;
+ (instancetype)sharedCoordinator;
@end
@implementation CSGroupNativeSessionCoordinator
+ (instancetype)sharedCoordinator { static id coordinator; if (!coordinator) coordinator=[self new]; return coordinator; }
@end

static char AdapterKey,PresentationSuspendedKey;
static NSString *currentAccount=@"initial-viewport-account";
static NSUInteger currentEpoch=1;
static BOOL groupingEnabled=YES,applicationActive=YES;
static CSCloseFriendSnapshot *currentPolicy;
static NSString *CSGroupCurrentAccountID(void) { return currentAccount; }
static NSUInteger CSCloseFriendAccountEpoch(void) { return currentEpoch; }
static CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) { return currentPolicy; }
static BOOL CSGroupApplicationActive(void) { return applicationActive; }
static BOOL Option(NSString *key) { return [key isEqual:@"enabled"] && groupingEnabled; }
static BOOL CSGroupIsFoldedController(HostController *host) { return host.folded; }
static long long CSGroupReadInteger(id object,NSString *key,long long fallback) {
    if (!object || ![object respondsToSelector:NSSelectorFromString(key)]) return fallback;
    return [[object valueForKey:key] longLongValue];
}
static void CSGroupWithDisplayIndices(id table,void (^body)(void)) { (void)table; body(); }
static BOOL CSGroupSearchButtonVisible(NSUserDefaults *defaults) { (void)defaults; return YES; }
static id CSGroupReadObject(id object,NSString *key) {
    SEL selector=NSSelectorFromString(key);
    return [object respondsToSelector:selector] ? ((id (*)(id,SEL))[object methodForSelector:selector])(object,selector) : nil;
}

@interface CSGroupListAdapter : NSObject
@property(nonatomic,strong) UITableView *table;
@property(nonatomic,strong) HostController *controller;
@property(nonatomic,strong) TestChrome *chrome;
@property(nonatomic,strong) UIView *headerContainer;
@property(nonatomic,strong) CSGroupPreferences *preferences;
@property(nonatomic,strong) CSGroupProjection *projection;
@property(nonatomic,strong) NSMutableDictionary *anchors;
@property(nonatomic,strong) NSMutableArray *nativeActions;
@property(nonatomic,strong) NSArray *cachedNativeSections;
@property(nonatomic,strong) NSArray<WESessionTabItem *> *displayedTabs;
@property(nonatomic,copy) NSString *publishedTabID;
@property(nonatomic,copy) NSDictionary *presentationViewport,*switchViewport;
@property(nonatomic,copy) NSArray *initialViewportKey,*pageSourceReturnKey;
@property(nonatomic) NSUInteger initialViewportGeneration,viewportGeneration,modelRevision,snapshotEpoch,nativeModelRevision;
@property(nonatomic) NSUInteger changeDepth,snapshotRetryGeneration,recoveryAttempts;
@property(nonatomic) BOOL initialViewportPending,presentationSuspended,presentationReturnFinished,restoringViewport;
@property(nonatomic) BOOL active,chromeVisible,searching,nativePresentation,searchChromeVisible,publishing,dirty;
@property(nonatomic) BOOL privacyRefreshPending,sessionLayoutHeld,snapshotRetryAttempted,swipeActive,usesNativeSessionModel,recoveryPending;
@property(nonatomic) BOOL groupPanMoving;
@property(nonatomic) BOOL preparingPagePreview;
@property(nonatomic) NSUInteger nativeMenuState;
+ (instancetype)adapterForController:(id)controller;
+ (void)setPresentationSuspended:(BOOL)suspended forController:(id)controller;
+ (void)finishPresentationReturnForController:(id)controller;
+ (void)refreshFoldedListsForAccount:(NSString *)account;
- (BOOL)isActive;
- (void)prepareInitialViewport;
- (void)cancelInitialViewport;
- (void)restoreInitialViewport;
- (BOOL)restoreScrollHeight:(CGFloat)height;
- (void)restorePendingViewport;
- (NSDictionary *)captureViewportForTabID:(NSString *)tabID;
- (BOOL)validViewport:(NSDictionary *)viewport;
- (void)saveAnchor;
- (void)restoreAnchor;
- (void)prepareForNativeSearch;
- (void)clearPendingViewport;
- (void)beginUserScrolling;
- (void)selectIndex:(NSInteger)index;
- (void)preparePageTransitionForSelection:(NSInteger)index;
- (void)cancelPageTransition;
@end
@implementation CSGroupListAdapter
#include "GroupInitialViewportBodies.h"
- (BOOL)isActive { return self.active; }
- (void)invalidateNativeSnapshot { self.modelRevision++; }
- (void)cancelScheduledRefresh {}
- (void)finishSuspendedBatches {}
- (void)requestTabBadgeSourceRefresh {}
- (void)refreshNavigationTitle {}
- (void)requestRefresh { self.dirty=YES; }
- (void)layout {}
- (void)refresh { self.publishedTabID=self.preferences.selectedTabID; }
// This suite owns viewport geometry; the page animator is an independent boundary.
- (void)preparePageTransitionForSelection:(NSInteger)index { (void)index; }
- (void)cancelPageTransition {}
+ (void)refreshFoldedListsForAccount:(NSString *)account { (void)account; }
@end

// The production callbacks use the existing guarded hook installer. This
// substitute performs signature admission and swizzling without Substrate.
static NSUInteger tabHookAttempts,tabHooksInstalled;
static BOOL tabHookEncodingsCorrect=YES;
static BOOL CSCloseFriendInstallHook(NSString *className,NSString *name,IMP replacement,IMP *original,const char *encoding) {
    tabHookAttempts++;
    tabHookEncodingsCorrect &= strcmp(encoding,"v@:@")==0;
    Class cls=NSClassFromString(className);SEL selector=NSSelectorFromString(name);
    Method target=class_getInstanceMethod(cls,selector);
    if (!target) return NO;
    NSMethodSignature *signature=[NSMethodSignature signatureWithObjCTypes:method_getTypeEncoding(target)];
    if (signature.numberOfArguments!=3 || strcmp(signature.methodReturnType,"v") || strcmp([signature getArgumentTypeAtIndex:2],"@")) return NO;
    *original=method_setImplementation(target,replacement);tabHooksInstalled++;return *original!=NULL;
}
#include "GroupInitialViewportHooks.h"

@interface TabCommandHost : NSObject
@property(nonatomic,strong) HostController *mainController;
@property(nonatomic) NSUInteger nativeCalls;
@property(nonatomic) BOOL pendingAtNativeCommand;
@property(nonatomic,strong) id receivedSender;
@end
@implementation TabCommandHost @end
static id NativeMainFrameGetter(TabCommandHost *owner,SEL selector) { (void)selector;return owner.mainController; }
static void NativeTabCommand(TabCommandHost *owner,SEL selector,id sender) {
    (void)selector;owner.nativeCalls++;owner.receivedSender=sender;
    CSGroupListAdapter *adapter=[CSGroupListAdapter adapterForController:owner.mainController];
    owner.pendingAtNativeCommand=adapter.initialViewportPending;
    // Native unread navigation is allowed to choose a later conversation.
    adapter.table.contentOffset=CGPointMake(9,240);
}

static NSUInteger checks,failures;
static void Check(BOOL pass,NSString *message) {
    checks++; if (!pass) { failures++; fprintf(stderr,"FAIL: %s\n",message.UTF8String); }
}
static BOOL Near(CGFloat a,CGFloat b) { return fabs(a-b)<0.001; }
static NSIndexPath *Path(void) { return [NSIndexPath indexPathForRow:0 inSection:0]; }
static CSGroupListAdapter *List(CGFloat nativeHeaderHeight,CGFloat contentHeight) {
    currentAccount=@"initial-viewport-account";currentEpoch=1;groupingEnabled=YES;applicationActive=YES;
    currentPolicy=[CSCloseFriendSnapshot new];currentPolicy.accountID=currentAccount;currentPolicy.revision=7;
    currentPolicy.options=@{@"hideSessions":@NO};
    CSGroupListAdapter *a=[CSGroupListAdapter new];a.controller=[HostController new];
    objc_setAssociatedObject(a.controller,&AdapterKey,a,OBJC_ASSOCIATION_ASSIGN);
    a.table=[UITableView new];a.table.bounds=CGRectMake(0,0,390,700);a.table.window=[NSObject new];
    a.table.contentSize=CGSizeMake(390,contentHeight);a.table.adjustedContentInset=(UIEdgeInsets){103,0,30,0};
    a.table.contentOffset=CGPointMake(9,-103);a.table.indexPathsForVisibleRows=@[Path()];a.table.rowOrigins=@{Path():@100};
    a.headerContainer=[UIView new];a.headerContainer.frame=CGRectMake(0,0,390,nativeHeaderHeight+52);
    [a.table addSubview:a.headerContainer];a.chrome=[TestChrome new];a.chrome.frame=CGRectMake(0,nativeHeaderHeight,390,52);
    [a.headerContainer addSubview:a.chrome];
    a.preferences=[CSGroupPreferences new];a.preferences.accountID=currentAccount;a.preferences.selectedTabID=@"preset_0";
    WESessionTabItem *first=[WESessionTabItem new];first.tabId=@"preset_0";
    WESessionTabItem *next=[WESessionTabItem new];next.tabId=@"custom_1";
    a.preferences.tabs=@[first,next];a.displayedTabs=a.preferences.tabs;
    a.projection=[CSGroupProjection new];a.projection.isValid=YES;a.projection.accountID=currentAccount;
    a.projection.privacyRevision=currentPolicy.revision;
    CSGroupRow *row=[CSGroupRow new];row.userName=@"fixture-row";a.projection.sections=@[@[row]];
    a.anchors=[NSMutableDictionary new];a.nativeActions=[NSMutableArray new];
    a.active=YES;a.chromeVisible=YES;a.publishedTabID=@"preset_0";a.snapshotEpoch=currentEpoch;a.modelRevision=3;
    a.usesNativeSessionModel=YES;a.nativeModelRevision=4;
    CSGroupNativeSessionCoordinator *coordinator=CSGroupNativeSessionCoordinator.sharedCoordinator;
    coordinator.accountID=currentAccount;coordinator.epoch=currentEpoch;coordinator.revision=4;coordinator.boundary=NO;
    [a prepareInitialViewport];
    return a;
}
static void HideGroup(CSGroupListAdapter *a) { a.table.contentOffset=CGPointMake(9,CGRectGetMinY(a.chrome.frame)+52-a.table.adjustedContentInset.top); }
static void CheckCancelled(CSGroupListAdapter *a,NSString *reason) {
    Check(!a.initialViewportPending,reason);[a prepareInitialViewport];
    Check(!a.initialViewportPending,@"same-account refresh cannot rearm a consumed startup request");
    NSUInteger writes=a.table.offsetWrites;HideGroup(a);[a restorePendingViewport];
    Check(a.table.offsetWrites==writes,@"cancelled startup request does not reclaim the user's position");
}
int main(void) { @autoreleasepool {
    CSGroupListAdapter *a=List(0,1800);
    Check(a.initialViewportPending,@"new main-list account establishes startup visibility ownership");
    [a restorePendingViewport];
    Check(a.table.offsetWrites==0 && a.initialViewportPending,@"visible first frame is not written or prematurely consumed");
    [a saveAnchor];Check(!a.anchors.count,@"native startup position is not saved as a row anchor");
    Check(![a captureViewportForTabID:a.publishedTabID],@"native startup position is not captured as a switch/return height");
    HideGroup(a);[a restorePendingViewport];
    Check(a.table.offsetWrites==1 && Near(a.table.contentOffset.y,-103),@"late native top-area reset reveals the group above the computer-login row");
    Check(Near(a.table.contentOffset.x,9) && a.initialViewportPending,@"startup restore preserves x and retains ownership for late host writes");
    [a restorePendingViewport];Check(a.table.offsetWrites==1,@"unchanged visible geometry avoids duplicate offset callbacks");
    a.table.adjustedContentInset=(UIEdgeInsets){119,0,30,0};HideGroup(a);[a restorePendingViewport];
    Check(Near(a.table.contentOffset.y,-119),@"late navigation inset change uses the current adjusted inset");
    HideGroup(a);[a restoreAnchor];Check(Near(a.table.contentOffset.y,-119),@"row-anchor restore defers to startup visibility while pending");

    a=List(64,1800);HideGroup(a);[a restorePendingViewport];
    Check(Near(a.table.contentOffset.y,-39),@"retained native search header uses the actual group y instead of zero");
    a=List(64,1800);a.headerContainer.frame=CGRectMake(0,20,390,116);HideGroup(a);
    a.table.contentOffset=CGPointMake(9,84+52-103);[a restorePendingViewport];
    Check(Near(a.table.contentOffset.y,-19),@"converted chrome geometry includes its containing header origin");
    for (NSNumber *height in @[@0,@160,@1800]) {
        a=List(0,height.doubleValue);if (!height.doubleValue) a.projection.sections=@[@[]];HideGroup(a);[a restorePendingViewport];
        Check(a.table.offsetWrites==1 && Near(a.table.contentOffset.y,-103),@"empty, short and long list startup reveal is independent of scrollability");
    }
    a=List(0,0);HideGroup(a);[a restorePendingViewport];
    Check(a.table.offsetWrites==0 && a.initialViewportPending,@"zero content with real rows waits for content geometry");

    for (NSString *flag in @[@"publishing",@"dirty",@"privacyRefreshPending",@"sessionLayoutHeld",@"snapshotRetryAttempted",@"swipeActive",@"groupPanMoving"]) {
        a=List(0,1800);HideGroup(a);[a setValue:@YES forKey:flag];[a restorePendingViewport];
        Check(a.table.offsetWrites==0 && a.initialViewportPending,[NSString stringWithFormat:@"%@ postpones startup writes",flag]);
        [a setValue:@NO forKey:flag];[a restorePendingViewport];Check(a.table.offsetWrites==1,@"valid publication retries the existing request");
    }
    for (NSString *flag in @[@"tracking",@"dragging",@"decelerating",@"editing"]) {
        a=List(0,1800);HideGroup(a);[a.table setValue:@YES forKey:flag];[a restorePendingViewport];
        Check(a.table.offsetWrites==0,[NSString stringWithFormat:@"%@ retains UIKit interaction ownership",flag]);
    }
    a=List(0,1800);HideGroup(a);a.changeDepth=1;[a restorePendingViewport];Check(a.table.offsetWrites==0,@"native data batch blocks startup writes");
    a=List(0,1800);HideGroup(a);a.nativeMenuState=1;[a restorePendingViewport];Check(a.table.offsetWrites==0,@"open native row menu blocks startup writes");
    a=List(0,1800);HideGroup(a);currentPolicy.blocked=YES;[a restorePendingViewport];Check(a.table.offsetWrites==0,@"blocked privacy snapshot cannot move the list");
    currentPolicy.blocked=NO;currentPolicy.options=@{};[a restorePendingViewport];Check(a.table.offsetWrites==0,@"unknown privacy metadata cannot move the list");
    a=List(0,1800);HideGroup(a);a.projection.privacyRevision++;[a restorePendingViewport];Check(a.table.offsetWrites==0,@"stale privacy projection cannot move the list");
    a=List(0,1800);HideGroup(a);CSGroupNativeSessionCoordinator.sharedCoordinator.boundary=YES;[a restorePendingViewport];Check(a.table.offsetWrites==0,@"native model boundary blocks startup restore");
    a=List(0,1800);HideGroup(a);a.nativeModelRevision++;[a restorePendingViewport];Check(a.table.offsetWrites==0,@"stale native revision blocks startup restore");
    a=List(0,1800);HideGroup(a);applicationActive=NO;[a restorePendingViewport];Check(a.table.offsetWrites==0,@"inactive application leaves native position alone");

    a=List(0,1800);[a cancelInitialViewport];a.table.tracking=YES;a.groupPanMoving=YES;
    Check(![a restoreScrollHeight:180] && !a.table.offsetWrites,@"ordinary horizontal tracking retains viewport ownership outside preview preparation");
    a.preparingPagePreview=YES;
    Check([a restoreScrollHeight:180] && a.table.offsetWrites==1 && Near(a.table.contentOffset.y,77),@"explicit preview preparation alone can restore source height while the horizontal finger remains down");
    NSUInteger previewWrites=a.table.offsetWrites;a.table.dragging=YES;
    Check(![a restoreScrollHeight:200] && a.table.offsetWrites==previewWrites,@"preview preparation does not bypass native vertical dragging");
    a.table.dragging=NO;a.dirty=YES;
    Check(![a restoreScrollHeight:200] && a.table.offsetWrites==previewWrites,@"preview preparation does not bypass dirty model safety");

    for (NSString *geometry in @[@"window",@"detached",@"hidden",@"width",@"height",@"nan",@"tableHeight",@"content"]) {
        a=List(0,1800);HideGroup(a);
        if ([geometry isEqual:@"window"]) a.table.window=nil;
        if ([geometry isEqual:@"detached"]) a.headerContainer.superview=nil;
        if ([geometry isEqual:@"hidden"]) a.chrome.hidden=YES;
        if ([geometry isEqual:@"width"]) a.chrome.frame=CGRectMake(0,0,0,52);
        if ([geometry isEqual:@"height"]) a.chrome.frame=CGRectMake(0,0,390,0);
        if ([geometry isEqual:@"nan"]) a.chrome.frame=CGRectMake(0,NAN,390,52);
        if ([geometry isEqual:@"tableHeight"]) a.table.bounds=CGRectZero;
        if ([geometry isEqual:@"content"]) a.table.contentSize=CGSizeMake(390,NAN);
        [a restorePendingViewport];Check(a.table.offsetWrites==0,[NSString stringWithFormat:@"unready %@ geometry cannot write",geometry]);
    }
    a=List(0,1800);a.pageSourceReturnKey=@[currentAccount,@(currentEpoch),@(a.viewportGeneration)];
    [a beginUserScrolling];CheckCancelled(a,@"real user scrolling consumes startup ownership");
    Check(!a.pageSourceReturnKey && a.viewportGeneration==1,@"a vertical positioning command invalidates the completed return key with its viewport generation");
    a=List(0,1800);[a prepareForNativeSearch];a.searching=NO;CheckCancelled(a,@"native search consumes startup ownership");
    a=List(0,1800);a.pageSourceReturnKey=@[currentAccount,@(currentEpoch),@(a.viewportGeneration)];
    [CSGroupListAdapter setPresentationSuspended:YES forController:a.controller];
    Check(!a.initialViewportPending && a.presentationViewport,@"leaving main list ends startup and captures the normal return height");
    Check(!a.pageSourceReturnKey,@"the first departure invalidates the previous completed return key");
    [CSGroupListAdapter setPresentationSuspended:NO forController:a.controller];a.dirty=NO;
    [a prepareInitialViewport];Check(!a.initialViewportPending,@"returning to a previously shown list does not rearm startup");
    a=List(0,1800);[a selectIndex:0];CheckCancelled(a,@"an explicit same-index selection command ends startup ownership");
    a=List(0,1800);[a selectIndex:1];Check(!a.initialViewportPending && [a.preferences.selectedTabID isEqual:@"custom_1"],@"a new group selection supersedes startup ownership");
    [a prepareInitialViewport];Check(!a.initialViewportPending,@"a new group selection cannot rearm startup on refresh");
    a=List(0,1800);a.pageSourceReturnKey=@[currentAccount,@(currentEpoch),@(a.viewportGeneration)];
    [a clearPendingViewport];CheckCancelled(a,@"explicit native positioning consumes startup ownership");
    Check(!a.pageSourceReturnKey,@"clearing pending positioning also consumes the completed return key");
    a=List(0,1800);groupingEnabled=NO;[a restorePendingViewport];groupingEnabled=YES;CheckCancelled(a,@"disabling grouping cancels the current startup request");
    a=List(0,1800);a.controller.folded=YES;a.initialViewportKey=nil;[a prepareInitialViewport];Check(!a.initialViewportPending,@"folded group page never creates startup positioning");
    a=List(0,1800);[a cancelInitialViewport];currentEpoch++;[a prepareInitialViewport];
    Check(a.initialViewportPending && a.initialViewportGeneration==a.viewportGeneration,@"a new account epoch gets its own startup request");
    [a restorePendingViewport];Check(a.table.offsetWrites==0,@"old epoch projection cannot satisfy new startup request");
    a=List(0,1800);HideGroup(a);currentAccount=@"other-account";[a restorePendingViewport];
    Check(!a.initialViewportPending && a.table.offsetWrites==0,@"old account startup request is invalidated without a write");
    [a prepareInitialViewport];
    Check(a.initialViewportPending && [a.initialViewportKey.firstObject isEqual:currentAccount],@"layout before new-account publication must not consume the new account's startup request");
    [a restorePendingViewport];Check(a.table.offsetWrites==0,@"new-account startup waits until its own projection is published");
    a.nativePresentation=YES;a.searching=YES;[a.nativeActions addObject:@"old-account-action"];
    a.initialViewportKey=nil;[a prepareInitialViewport];[a restorePendingViewport];
    Check(a.initialViewportPending && a.table.offsetWrites==0,@"old-account native and search state cannot consume the new account's startup request");
    a=List(0,1800);HideGroup(a);currentEpoch++;[a restorePendingViewport];
    Check(!a.initialViewportPending && a.table.offsetWrites==0,@"old epoch startup request is invalidated without a write");
    [a prepareInitialViewport];
    Check(a.initialViewportPending && [a.initialViewportKey.lastObject unsignedIntegerValue]==currentEpoch,@"layout before new-epoch publication must not consume the new epoch's startup request");

    a=List(0,1800);HideGroup(a);__weak CSGroupListAdapter *weakAdapter=a;
    a.table.onOffsetWrite=^{ [weakAdapter beginUserScrolling]; };
    Check(![a restoreScrollHeight:0] && !a.initialViewportPending,@"a reentrant user command invalidates restore success and startup ownership");
    a.table.onOffsetWrite=nil;NSUInteger writes=a.table.offsetWrites;HideGroup(a);[a restorePendingViewport];
    Check(a.table.offsetWrites==writes,@"reentrant cancellation cannot be resurrected by a later layout");
    a=List(0,1800);HideGroup(a);__weak UITableView *weakTable=a.table;
    a.table.onOffsetWrite=^{ weakTable.adjustedContentInset=(UIEdgeInsets){120,0,30,0}; };
    Check(![a restoreScrollHeight:0] && a.initialViewportPending,@"reentrant inset changes do not falsely report the old target as accepted");
    a.table.onOffsetWrite=nil;[a restorePendingViewport];
    Check(Near(a.table.contentOffset.y,-120),@"subsequent layout corrects using final reentrant inset");

    a=List(0,1800);HideGroup(a);[CSGroupListAdapter finishPresentationReturnForController:a.controller];
    Check(a.table.layouts==1 && a.table.offsetWrites==1 && !a.presentationViewport,@"first didAppear restores startup without a departure viewport");
    Check([a.pageSourceReturnKey isEqual:@[currentAccount,@(currentEpoch),@(a.viewportGeneration)]],@"didAppear records return ownership independently of startup restoration");
    a=List(0,1800);[a cancelInitialViewport];a.viewportGeneration=4;
    [CSGroupListAdapter finishPresentationReturnForController:a.controller];
    Check(!a.presentationViewport && !a.initialViewportPending && !a.table.layouts && !a.table.offsetWrites &&
        [a.pageSourceReturnKey isEqual:@[currentAccount,@(currentEpoch),@4]],@"a return without captured or startup geometry still records its exact account epoch and generation for the first pan");
    a=List(0,1800);HideGroup(a);a.dirty=YES;[CSGroupListAdapter finishPresentationReturnForController:a.controller];
    Check(a.table.layouts==0 && a.table.offsetWrites==0 && a.initialViewportPending,@"didAppear waits for dirty model publication");
    a.dirty=NO;[a restorePendingViewport];Check(a.table.offsetWrites==1,@"publication after didAppear fulfills the retained startup request");
    a=List(0,1800);[a cancelInitialViewport];a.table.contentOffset=CGPointMake(9,130);[a saveAnchor];
    Check(a.anchors[a.publishedTabID]!=nil,@"normal row anchors resume after startup is consumed");
    a.table.rowOrigins=@{Path():@200};[a restoreAnchor];Check(Near(a.table.contentOffset.y,230),@"normal row restoration retains its existing behavior after startup");

    // Keep absent native methods absent: their respondsToSelector result is
    // part of the tab adapter's fallback choice. Add real methods only as
    // fixture setup, then install and invoke the actual production callbacks.
    Class legacy=objc_allocateClassPair(TabCommandHost.class,"MainTabBarViewController",0);
    Class modern=objc_allocateClassPair(TabCommandHost.class,"NewMainTabBarViewController",0);
    objc_registerClassPair(legacy);objc_registerClassPair(modern);
    SEL command=NSSelectorFromString(@"OnMainFrameDoubleClicked:");
    InstallMainTabPositioningHooks();
    Check(tabHookAttempts==2 && tabHooksInstalled==0 && !class_getInstanceMethod(legacy,command) && !class_getInstanceMethod(modern,command),@"missing double-click methods remain missing for native fallback selection");
    for (Class cls in @[legacy,modern]) {
        class_addMethod(cls,command,(IMP)NativeTabCommand,"v@:@");
        class_addMethod(cls,NSSelectorFromString(@"getNewMainFrameViewController"),(IMP)NativeMainFrameGetter,"@@:");
    }
    InstallMainTabPositioningHooks();
    Check(tabHookAttempts==4 && tabHooksInstalled==2 && tabHookEncodingsCorrect,@"both actual tab owners install through the guarded object-argument signature");
    for (Class cls in @[legacy,modern]) {
        a=List(0,1800);TabCommandHost *tab=[cls new];tab.mainController=a.controller;
        NSObject *sender=[NSObject new];
        ((void (*)(id,SEL,id))[tab methodForSelector:command])(tab,command,sender);
        Check(!a.initialViewportPending && a.viewportGeneration==1 && !tab.pendingAtNativeCommand,@"double-click command cancels startup before native unread positioning begins");
        Check(tab.nativeCalls==1 && tab.receivedSender==sender,@"double-click callback forwards the original target and sender exactly once");
        [a prepareInitialViewport];[a restorePendingViewport];
        Check(!a.initialViewportPending && Near(a.table.contentOffset.y,240) && a.table.offsetWrites==0,@"late layout preserves the user's double-click unread destination");
        tab=[cls new];tab.mainController=[HostController new];
        ((void (*)(id,SEL,id))[tab methodForSelector:command])(tab,command,nil);
        Check(tab.nativeCalls==1,@"native double-click forwards once when the main controller has no adapter");
    }
    fprintf(stdout,"Group initial viewport: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
    return failures ? 1 : 0;
} }
