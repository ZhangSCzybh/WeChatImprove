#import "GroupRefreshFixture.h"
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import <dispatch/dispatch.h>
static char TitleContextKey,CellRowKey;

@class UIGestureRecognizer;
@interface UIView : NSObject
@property(nonatomic,weak) UIView *superview;
@property(nonatomic) CGRect frame,bounds;
@property(nonatomic) CGSize contentSize;
@property(nonatomic) BOOL userInteractionEnabled,hidden;
@property(nonatomic) CGFloat alpha;
@property(nonatomic,strong) NSMutableArray<UIView *> *subviews;
@property(nonatomic,strong) NSMutableArray<UIGestureRecognizer *> *gestureRecognizers;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)addSubview:(UIView *)view;
- (void)removeFromSuperview;
- (UIView *)hitTest:(CGPoint)point withEvent:(id)event;
- (BOOL)isDescendantOfView:(UIView *)view;
@end
@implementation UIView
- (instancetype)init { return [self initWithFrame:CGRectZero]; }
- (instancetype)initWithFrame:(CGRect)frame {
    if ((self=[super init])) { self.frame=frame;self.bounds=(CGRect){CGPointZero,frame.size};self.userInteractionEnabled=YES;self.alpha=1;self.subviews=[NSMutableArray new];self.gestureRecognizers=[NSMutableArray new]; }
    return self;
}
- (void)addSubview:(UIView *)view { [view removeFromSuperview];view.superview=self;[self.subviews addObject:view]; }
- (void)removeFromSuperview { [self.superview.subviews removeObjectIdenticalTo:self];self.superview=nil; }
- (UIView *)hitTest:(CGPoint)point withEvent:(id)event {
    (void)event;
    if (!self.userInteractionEnabled || self.hidden || self.alpha<=0.01 || !CGRectContainsPoint(self.bounds,point)) return nil;
    for (UIView *child in self.subviews.reverseObjectEnumerator) {
        CGPoint local=CGPointMake(point.x-child.frame.origin.x+child.bounds.origin.x,point.y-child.frame.origin.y+child.bounds.origin.y);
        UIView *hit=[child hitTest:local withEvent:event];if(hit)return hit;
    }
    return self;
}
- (BOOL)isDescendantOfView:(UIView *)view {
    for (UIView *p=self;p;p=p.superview) if (p==view) return YES;
    return NO;
}
@end
@interface UIControl : UIView @end
@implementation UIControl @end
@interface UITableView : UIView
@property(nonatomic) BOOL editing,tracking,dragging,decelerating;
@property(nonatomic,weak) id adapter;
@property(nonatomic) NSUInteger closes;
@property(nonatomic,strong) NSArray *visibleCells;
- (void)setEditing:(BOOL)editing animated:(BOOL)animated;
@end
@implementation UITableView
- (void)setEditing:(BOOL)editing animated:(BOOL)animated { (void)animated; self.editing=editing; self.closes++; }
@end
@interface HookedTable : UITableView @end
typedef NS_ENUM(NSInteger,UIGestureRecognizerState) { UIGestureRecognizerStatePossible, UIGestureRecognizerStateBegan, UIGestureRecognizerStateChanged, UIGestureRecognizerStateEnded, UIGestureRecognizerStateCancelled, UIGestureRecognizerStateFailed };
@interface UIGestureRecognizer : NSObject
@property(nonatomic) UIGestureRecognizerState state;
@property(nonatomic) BOOL enabled;
@property(nonatomic,weak) UIView *view;
@property(nonatomic,weak) id target,delegate;
@property(nonatomic) SEL action;
@property(nonatomic) NSUInteger maximumNumberOfTouches;
@property(nonatomic) BOOL delaysTouchesBegan,cancelsTouchesInView;
- (instancetype)initWithTarget:(id)target action:(SEL)action;
@end
@implementation UIGestureRecognizer
- (instancetype)init { if((self=[super init]))self.enabled=YES;return self; }
- (instancetype)initWithTarget:(id)target action:(SEL)action { if((self=[self init])){self.target=target;self.action=action;}return self; }
@end
@interface UIView (InputRecognizers)
- (void)addGestureRecognizer:(UIGestureRecognizer *)gesture;
- (void)removeGestureRecognizer:(UIGestureRecognizer *)gesture;
@end
@implementation UIView (InputRecognizers)
- (void)addGestureRecognizer:(UIGestureRecognizer *)gesture { [gesture.view removeGestureRecognizer:gesture];gesture.view=self;[self.gestureRecognizers addObject:gesture]; }
- (void)removeGestureRecognizer:(UIGestureRecognizer *)gesture { [self.gestureRecognizers removeObjectIdenticalTo:gesture];if(gesture.view==self)gesture.view=nil; }
@end
@interface UIPanGestureRecognizer : UIGestureRecognizer
@property(nonatomic) CGPoint velocity,translation;
- (CGPoint)velocityInView:(UIView *)view;
- (CGPoint)translationInView:(UIView *)view;
@end
@implementation UIPanGestureRecognizer
- (CGPoint)velocityInView:(UIView *)view { (void)view; return self.velocity; }
- (CGPoint)translationInView:(UIView *)view { (void)view; return self.translation; }
@end
@interface UISwipeGestureRecognizer : UIGestureRecognizer @end
@implementation UISwipeGestureRecognizer @end
@interface UITableViewCell : UIView @end
@implementation UITableViewCell @end
@interface MMBaseMultiMenuTableViewCell : UITableViewCell {
@public
    UIGestureRecognizer *_panGestureRecognizer;
    BOOL _inHideAnimation;
}
@property(nonatomic) BOOL menuHidden,throwOnPan;
@property(nonatomic) NSUInteger panCalls,hideCalls;
@property(nonatomic,strong) UIGestureRecognizer *receivedPan;
@property(nonatomic,copy) void (^receivedCompletion)(void);
@property(nonatomic) BOOL receivedAnimated;
- (BOOL)isMenuHidden;
- (void)handlePan:(UIGestureRecognizer *)gesture;
- (void)setMenuOptionsViewHidden:(BOOL)hidden animated:(BOOL)animated completionHandler:(void (^)(void))completion;
@end
@implementation MMBaseMultiMenuTableViewCell
- (BOOL)isMenuHidden { return self.menuHidden; }
- (void)handlePan:(UIGestureRecognizer *)gesture {
    self.panCalls++; self.receivedPan=gesture;
    if (self.throwOnPan) [NSException raise:@"fixture" format:@"menu pan failed"];
}
- (void)setMenuOptionsViewHidden:(BOOL)hidden animated:(BOOL)animated completionHandler:(void (^)(void))completion {
    self.hideCalls++; self.menuHidden=hidden; self.receivedAnimated=animated;
    _inHideAnimation=hidden && animated; self.receivedCompletion=completion;
}
@end
@interface HookedMenuCell : MMBaseMultiMenuTableViewCell @end
@interface UITouch : NSObject
@property(nonatomic,strong) UIView *view;
@property(nonatomic) CGPoint point;
- (CGPoint)locationInView:(UIView *)view;
@end
@implementation UITouch
- (CGPoint)locationInView:(UIView *)view { (void)view; return self.point; }
@end
@interface Chrome : UIView
@property(nonatomic,strong) UIView *scrollView;
@property(nonatomic) NSInteger selectedIndex;
@property(nonatomic) NSUInteger selections,previews,cancellations;
@property(nonatomic) CGFloat progress;
- (void)updateInteractiveTransitionToIndex:(NSInteger)index progress:(CGFloat)progress;
- (void)cancelInteractiveTransition;
- (void)selectTabAtIndex:(NSInteger)index animated:(BOOL)animated;
@end
@implementation Chrome
- (void)updateInteractiveTransitionToIndex:(NSInteger)index progress:(CGFloat)progress { (void)index; self.previews++; self.progress=progress; }
- (void)cancelInteractiveTransition { self.cancellations++; }
- (void)selectTabAtIndex:(NSInteger)index animated:(BOOL)animated { (void)animated; self.selectedIndex=index; self.selections++; }
@end
@interface CSGroupRow : NSObject
@property(nonatomic,copy) NSString *userName;
@end
@implementation CSGroupRow @end
@interface CSGroupProjection : NSObject
@property(nonatomic,copy) NSString *accountID;
@property(nonatomic,strong) NSDictionary *rows;
- (CSGroupRow *)rowAtDisplayPath:(NSIndexPath *)path;
@end
@implementation CSGroupProjection
- (CSGroupRow *)rowAtDisplayPath:(NSIndexPath *)path { return path ? self.rows[path] : nil; }
@end
@interface WESessionTabItem : NSObject
@property(nonatomic,copy) NSString *tabId,*displayName;
@end
@implementation WESessionTabItem @end
@interface CSGroupPreferences : NSObject
@property(nonatomic,copy) NSString *accountID,*selectedTabID;
@property(nonatomic) NSUInteger selectionWrites;
@end
@implementation CSGroupPreferences
- (void)setSelectedTabID:(NSString *)tabID { _selectedTabID=tabID.copy; self.selectionWrites++; }
@end
@interface CSGroupPageAnimator : NSObject
@property(nonatomic,getter=isActive) BOOL active;
@property(nonatomic,getter=isAnimating) BOOL animating;
@property(nonatomic) NSUInteger updates;
@property(nonatomic) CGFloat translation,progress,viewportWidth;
@property(nonatomic) NSInteger direction;
@property(nonatomic,strong) UIView *overlay;
- (BOOL)updateTranslation:(CGFloat)translation;
- (BOOL)ownsTouchView:(UIView *)view;
@end
@implementation CSGroupPageAnimator
- (BOOL)updateTranslation:(CGFloat)translation {
    self.updates++;self.translation=translation;
    self.progress=MIN(1,MAX(0,-translation*self.direction/MAX(1,self.viewportWidth)));
    return self.active;
}
- (BOOL)ownsTouchView:(UIView *)view { return self.active && self.overlay && [view isDescendantOfView:self.overlay]; }
@end
@interface NativeTitle : NSObject
@property(nonatomic,copy) NSString *renderedTitle;
@property(nonatomic) unsigned int renderedStatus;
@property(nonatomic) NSUInteger renders;
- (void)updateTitleView:(unsigned int)status title:(NSString *)title;
@end
@interface Host : NSObject
@property(nonatomic,strong) NativeTitle *m_titleView;
@property(nonatomic,copy) NSString *titleToRender;
- (void)updateTitleView;
@property(nonatomic,strong) NSMutableDictionary<NSString *,NSIndexPath *> *paths;
@property(nonatomic,strong) NSIndexPath *receivedPath;
@property(nonatomic) NSUInteger calls;
@property(nonatomic) BOOL throwOnEnd;
- (void)tableView:(UITableView *)table didEndEditingRowAtIndexPath:(NSIndexPath *)path;
- (void)tableView:(UITableView *)table willBeginEditingRowAtIndexPath:(NSIndexPath *)path;
- (void)tableView:(UITableView *)table commitEditingStyle:(NSInteger)style forRowAtIndexPath:(NSIndexPath *)path;
@end
@implementation Host
- (void)updateTitleView { if (self.titleToRender) [self.m_titleView updateTitleView:9 title:self.titleToRender]; }
- (void)tableView:(UITableView *)table didEndEditingRowAtIndexPath:(NSIndexPath *)path {
    (void)table; self.calls++; self.receivedPath=path;
    if (self.throwOnEnd) [NSException raise:@"fixture" format:@"native end failed"];
}
- (void)tableView:(UITableView *)table willBeginEditingRowAtIndexPath:(NSIndexPath *)path { (void)table; self.calls++; self.receivedPath=path; }
- (void)tableView:(UITableView *)table commitEditingStyle:(NSInteger)style forRowAtIndexPath:(NSIndexPath *)path { (void)table; (void)style; self.calls++; self.receivedPath=path; }
@end
static BOOL enabled=YES,gestureEnabled=YES,nativeScope,searchButtonVisible=YES;
static BOOL pageAnimationEnabled=YES,reducedMotion;
static BOOL CSGroupSearchButtonVisible(NSUserDefaults *defaults) { (void)defaults; return searchButtonVisible; }
static BOOL CSGroupPageTransitionEnabled(NSUserDefaults *defaults) { (void)defaults; return pageAnimationEnabled; }
static BOOL UIAccessibilityIsReduceMotionEnabled(void) { return reducedMotion; }
static NSString *account=@"account-A";
static NSString *CSGroupCurrentAccountID(void) { return account; }
// Interaction fixtures exercise ordinary sessions; privacy/source behavior is
// covered by the focused close-friend and group lifecycle suites.
static NSUInteger const FixtureAccountEpoch=1;
static NSUInteger const CSCloseFriendSurfaceSession=0;
static NSUInteger CSCloseFriendAccountEpoch(void) { return FixtureAccountEpoch; }
static BOOL CSCloseFriendShouldHideUserName(NSString *name,NSUInteger surface) { (void)name; (void)surface; return NO; }
static BOOL CSGroupPrivacyActive(void) { return NO; }
static BOOL Option(NSString *suffix) { return [suffix isEqual:@"enabled"] ? enabled : gestureEnabled; }
static BOOL CSGroupUsesNativeIndices(id table) { (void)table; return nativeScope; }
static void CSGroupWithNativeIndices(id table,void (^body)(void)) {
    (void)table; BOOL previous=nativeScope; nativeScope=YES;
    @try { body(); } @finally { nativeScope=previous; }
}
static NSIndexPath *CSGroupResolveNativeRowPath(Host *host,CSGroupRow *row,BOOL dirty) { (void)dirty; return host.paths[row.userName]; }
static id CSGroupReadObject(id owner,NSString *key) { return [owner valueForKey:key]; }
static __attribute__((unused)) long long CSGroupReadInteger(id owner,NSString *key,long long fallback) {
    return [owner respondsToSelector:NSSelectorFromString(key)] ? [[owner valueForKey:key] longLongValue] : fallback;
}
static __attribute__((unused)) void CSGroupWithDisplayIndices(id table,void (^body)(void)) {
    (void)table; BOOL previous=nativeScope; nativeScope=NO;
    @try { body(); } @finally { nativeScope=previous; }
}
static NSHashTable *Adapters(void) {
    static NSHashTable *adapters; if (!adapters) adapters=[NSHashTable weakObjectsHashTable]; return adapters;
}
@interface CSGroupListAdapter : NSObject
CS_GROUP_REFRESH_TEST_PROPERTIES
@property(nonatomic) NSUInteger modelRevision,snapshotRevision,refreshGeneration;
@property(nonatomic) BOOL coalescingNotification,scheduledCoalesced,coalescedDispatchPending;
@property(nonatomic) BOOL immediateRefreshPending,usesNativeSessionModel;
@property(nonatomic) NSTimeInterval refreshBurstStart,refreshCoalescedDue,scheduledRefreshDue;
@property(nonatomic,copy) NSString *snapshotAccount;
@property(nonatomic,strong) NSArray *cachedNativeSections;
@property(nonatomic,copy) NSString *nativeActionsAccount;
@property(nonatomic) BOOL presentationSuspended;
@property(nonatomic,strong) NSArray *nativeActions;
@property(nonatomic,strong) UITableView *table;
@property(nonatomic,strong) Host *controller;
@property(nonatomic,strong) CSGroupRow *swipeRow;
@property(nonatomic,copy) NSString *swipeAccount,*publishedTabID;
@property(nonatomic,strong) NSIndexPath *swipeDisplayPath;
@property(nonatomic) BOOL active,swipeActive,dirty,scheduled,publishing,chromeVisible,searching,searchChromeVisible,barTouchAllowed,listTouchAllowed,privacyRefreshPending;
@property(nonatomic) NSUInteger changeDepth,refreshRequests,refreshCount;
@property(nonatomic,strong) CSGroupProjection *projection;
@property(nonatomic,strong) CSGroupPreferences *preferences;
@property(nonatomic,strong) NSArray *displayedTabs;
@property(nonatomic,strong) UIPanGestureRecognizer *pan,*listPan;
@property(nonatomic,strong) UIView *inputHost;
@property(nonatomic) NSUInteger groupSelections;
@property(nonatomic) BOOL selectionWithOpenMenu;
@property(nonatomic,strong) Chrome *chrome;
@property(nonatomic,strong) UIView *headerContainer;
@property(nonatomic,copy) NSDictionary *presentationViewport,*switchViewport;
@property(nonatomic) NSUInteger viewportRestoreCalls,nativeModelRefreshCalls;
@property(nonatomic) NSUInteger pageTransitionBegins,pageTransitionCommits;
@property(nonatomic) NSUInteger pageTransitionRequests,nativeRowTaps;
@property(nonatomic) NSUInteger pageSourcePreparations;
@property(nonatomic) BOOL deferRollbackCompletion;
@property(nonatomic) NSInteger pageTransitionIndex,pageTransitionDirection;
@property(nonatomic) BOOL pageTransitionWithOpenMenu;
@property(nonatomic,strong) CSGroupPageAnimator *pageAnimator;
@property(nonatomic,copy) NSDictionary *pageTransitionContext;
@property(nonatomic,copy) NSString *pagePreviewTabID,*pagePreviewAttemptedTarget;
@property(nonatomic,strong) NSMutableDictionary *anchors;
@property(nonatomic) NSUInteger pageTransitionGeneration,pageTransitionRollbacks;
@property(nonatomic) BOOL pageSelectionAccepted,preparingPagePreview,rejectPagePreview;
@property(nonatomic) CGFloat pageReleaseVelocity,rollbackVelocity;
- (BOOL)isActive;
- (NSIndexPath *)currentPathForRow:(CSGroupRow *)row;
- (NSIndexPath *)displayPath:(NSIndexPath *)path;
+ (instancetype)adapterForTable:(UITableView *)table;
- (void)requestRefresh;
- (void)enqueueRefresh;
- (void)consumeRefreshRequest;
- (BOOL)adoptCompatibilityModelIfNeeded;
- (void)refreshNativeSessionModel;
- (void)prepareInitialViewport;
- (NSDictionary *)captureViewportForTabID:(NSString *)tabID;
- (void)restorePendingViewport;
- (void)selectSwipeIndex:(NSInteger)index;
- (BOOL)beginSwipePageTransitionToIndex:(NSInteger)index direction:(NSInteger)direction;
- (void)ensureListPanHost;
- (void)preparePageSourceForPan;
- (BOOL)pageTransitionTargetIsReady;
- (void)restorePagePreview;
- (void)rollbackPageTransitionWithVelocity:(CGFloat)velocity;
- (void)cancelPageTransition;
- (void)cancelInvalidPageTransition;
- (void)finishPageTransitionIfReady;
- (BOOL)nativeMenuGesture:(UIGestureRecognizer *)gesture inCell:(UIView *)cell shouldReceiveTouch:(UITouch *)touch;
- (void)selectIndex:(NSInteger)index;
- (NSUInteger)nativeMenuState;
- (void)nativeMenuDidChange;
- (BOOL)groupSwipesAvailable;
- (void)refresh;
- (void)beginNativeChange;
- (void)endNativeChange;
- (void)endSwipeEditing;
- (void)reconcileDeletedSwipeRow;
- (BOOL)forwardSwipeInvocation:(NSInvocation *)inv target:(id)target;
- (BOOL)performNativeEditingContext:(NSDictionary *)context action:(void (^)(NSIndexPath *))action;
+ (NSString *)groupTitleForTitleView:(id)titleView;
+ (void)recordNativeTitle:(NSString *)title status:(unsigned int)status forTitleView:(id)titleView;
- (void)refreshNavigationTitle;
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldReceiveTouch:(UITouch *)touch;
+ (void)refreshFoldedListsForAccount:(NSString *)account;
@end
@implementation CSGroupListAdapter
- (void)invalidateNativeSnapshot { self.modelRevision++; }
- (void)pruneNativeActions {}
- (void)finishSuspendedBatches {}
// The suite exercises compatibility-list interaction admission, not native-model
// publication or viewport geometry. Keep those boundaries explicit and observable.
- (BOOL)adoptCompatibilityModelIfNeeded { return NO; }
- (void)refreshNativeSessionModel { self.nativeModelRefreshCalls++; }
- (void)prepareInitialViewport {}
- (NSDictionary *)captureViewportForTabID:(NSString *)tabID { (void)tabID; return nil; }
- (void)restorePendingViewport { self.viewportRestoreCalls++; }
// Route and signed-translation spies only: the lifecycle suite independently
// executes the complete production begin/preview/commit/rollback implementation.
- (BOOL)beginSwipePageTransitionToIndex:(NSInteger)index direction:(NSInteger)direction {
    self.pageTransitionRequests++;
    if (self.dirty) return NO;
    self.pageTransitionBegins++; self.pageTransitionIndex=index; self.pageTransitionDirection=direction;
    self.pageTransitionWithOpenMenu=[self nativeMenuState]!=0 || self.table.editing || self.swipeActive;
    self.pagePreviewAttemptedTarget=[self.displayedTabs[(NSUInteger)index] tabId];
    if (self.rejectPagePreview) return NO;
    self.pageAnimator=[CSGroupPageAnimator new]; self.pageAnimator.active=YES;
    self.pageAnimator.direction=direction;self.pageAnimator.viewportWidth=CGRectGetWidth(self.table.bounds);
    self.pageAnimator.overlay=[[UIView alloc] initWithFrame:self.inputHost.bounds];
    [self.inputHost addSubview:self.pageAnimator.overlay];
    self.pageTransitionContext=@{@"source":self.preferences.selectedTabID,@"target":[self.displayedTabs[(NSUInteger)index] tabId]};
    self.pagePreviewTabID=self.pageTransitionContext[@"target"]; self.pageTransitionGeneration++;
    self.publishedTabID=self.pagePreviewTabID;
    self.pagePreviewAttemptedTarget=nil;
    return YES;
}
- (void)preparePageSourceForPan { self.pageSourcePreparations++; }
- (BOOL)pageTransitionTargetIsReady { return self.pageAnimator.active; }
- (void)restorePagePreview { self.pagePreviewTabID=nil;self.publishedTabID=self.preferences.selectedTabID; }
- (void)rollbackPageTransitionWithVelocity:(CGFloat)velocity {
    if (!self.pageAnimator) return;
    self.pageTransitionRollbacks++; self.rollbackVelocity=velocity;
    if (self.deferRollbackCompletion) { self.pageAnimator.animating=YES;[self restorePagePreview]; }
    else [self cancelPageTransition];
}
- (void)cancelPageTransition { [self.pageAnimator.overlay removeFromSuperview];self.pageTransitionGeneration++; self.pageAnimator=nil; self.pageTransitionContext=nil; self.pagePreviewTabID=nil; self.pageSelectionAccepted=NO; }
- (void)cancelInvalidPageTransition {}
- (void)finishPageTransitionIfReady {
    if (self.pageSelectionAccepted && self.pageAnimator && !self.pageAnimator.animating) { self.pageTransitionCommits++; self.pageAnimator.animating=YES; }
}
+ (void)refreshFoldedListsForAccount:(NSString *)account { (void)account; }
#include "GroupInteractionBodies.h"
- (BOOL)isActive { return self.active; }
- (NSIndexPath *)currentPathForRow:(CSGroupRow *)row { return CSGroupResolveNativeRowPath(self.controller,row,YES); }
- (NSIndexPath *)displayPath:(NSIndexPath *)path { (void)path; return [NSIndexPath indexPathWithIndex:1]; }
+ (instancetype)adapterForTable:(UITableView *)table { return table.adapter; }
- (void)requestRefresh { self.refreshRequests++; [self enqueueRefresh]; }
- (void)selectIndex:(NSInteger)index { self.groupSelections++; self.selectionWithOpenMenu=[self nativeMenuState]!=0 || self.table.editing || self.swipeActive; self.preferences.selectedTabID=[self.displayedTabs[(NSUInteger)index] tabId]; }
- (void)beginNativeChange { self.changeDepth++; }
- (void)endNativeChange { self.changeDepth--; [self requestRefresh]; }
@end
// Exercise actual optional-delegate installation with a bounded runtime hook substitute.
static __attribute__((unused)) void MSHookMessageEx(Class cls,SEL selector,IMP replacement,IMP *original) {
    Method method=class_getInstanceMethod(cls,selector); *original=method_getImplementation(method);
    class_replaceMethod(cls,selector,replacement,method_getTypeEncoding(method));
}
#include "GroupMenuHookBodies.h"
static NSUInteger nativeReceiveCalls;
static BOOL TestOriginalReceive(id cell,SEL selector,UIGestureRecognizer *gesture,UITouch *touch) {
    (void)cell; (void)selector; (void)gesture; (void)touch; nativeReceiveCalls++; return NO;
}
static BOOL ReceiveMenu(MMBaseMultiMenuTableViewCell *cell,UITouch *touch) {
    return ((BOOL(*)(id,SEL,id,id))objc_msgSend)(cell,@selector(gestureRecognizer:shouldReceiveTouch:),cell->_panGestureRecognizer,touch);
}
@implementation HookedTable
#include "GroupEditingHookBodies.h"
@end
@implementation NativeTitle
- (void)updateTitleView:(unsigned int)status title:(NSString *)title {
    [CSGroupListAdapter recordNativeTitle:title status:status forTitleView:self];
    self.renderedTitle=[CSGroupListAdapter groupTitleForTitleView:self] ?: title;
    self.renderedStatus=status; self.renders++;
}
@end
static NSUInteger checks,failures;
static void Check(BOOL value,NSString *message) { checks++; if (!value) { failures++; fprintf(stderr,"FAIL: %s\n",message.UTF8String); } }
static NSIndexPath *Path(NSUInteger row) { NSUInteger indexes[]={0,row}; return [NSIndexPath indexPathWithIndexes:indexes length:2]; }
static NSArray *TwoTabs(void) {
    WESessionTabItem *source=[WESessionTabItem new],*target=[WESessionTabItem new];
    source.tabId=@"source"; target.tabId=@"target"; return @[source,target];
}
static CSGroupListAdapter *Fixture(void) {
    CSGroupListAdapter *a=[CSGroupListAdapter new]; a.active=YES; a.chromeVisible=YES;
    a.inputHost=[[UIView alloc] initWithFrame:CGRectMake(0,0,400,800)];
    a.table=[[HookedTable alloc] initWithFrame:a.inputHost.bounds]; a.table.adapter=a; a.table.editing=YES;
    [a.inputHost addSubview:a.table];
    a.controller=[Host new]; a.controller.paths=[@{@"deleted":Path(8),@"survivor":Path(12)} mutableCopy];
    a.controller.m_titleView=[NativeTitle new];
    a.swipeRow=[CSGroupRow new]; a.swipeRow.userName=@"deleted";
    a.swipeActive=YES; a.swipeAccount=account; a.swipeDisplayPath=Path(1);
    a.projection=[CSGroupProjection new]; a.projection.accountID=account; a.projection.rows=@{Path(1):a.swipeRow};
    a.preferences=[CSGroupPreferences new]; a.preferences.accountID=account; a.preferences.selectedTabID=@"source"; a.preferences.selectionWrites=0;
    a.anchors=[NSMutableDictionary new];
    a.pan=[[UIPanGestureRecognizer alloc] initWithTarget:a action:@selector(groupPan:)];
    a.listPan=[[UIPanGestureRecognizer alloc] initWithTarget:a action:@selector(groupPan:)];
    a.listPan.delegate=a;
    [a.table addGestureRecognizer:a.listPan];
    a.chrome=[Chrome new]; a.chrome.scrollView=[UIView new]; a.headerContainer=[UIView new];
    [a ensureListPanHost];
    [Adapters() addObject:a]; return a;
}
static HookedMenuCell *MenuFixture(CSGroupListAdapter *a) {
    [a endSwipeEditing]; a.table.editing=NO;
    HookedMenuCell *cell=[[HookedMenuCell alloc] initWithFrame:CGRectMake(0,100,400,500)]; [a.table addSubview:cell];
    cell->_panGestureRecognizer=[UIGestureRecognizer new]; cell.menuHidden=YES;
    a.table.visibleCells=@[cell];
    objc_setAssociatedObject(cell,&CellRowKey,@{@"row":a.projection.rows[Path(1)],@"account":account},OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return cell;
}
static CSGroupListAdapter *PanFixture(NSInteger index) {
    CSGroupListAdapter *a=Fixture(); [a endSwipeEditing]; a.table.editing=NO;
    a.displayedTabs=TwoTabs(); a.chrome.selectedIndex=index; a.listTouchAllowed=YES;
    a.preferences.selectedTabID=index ? @"target" : @"source"; a.preferences.selectionWrites=0;
    a.publishedTabID=a.preferences.selectedTabID; return a;
}
static void SendPan(CSGroupListAdapter *a,UIGestureRecognizerState state,CGFloat x,CGFloat velocity) {
    a.listPan.state=state; a.listPan.translation=CGPointMake(x,0); a.listPan.velocity=CGPointMake(velocity,0);
    [a groupPan:a.listPan];
}
// Input enters at UIKit's hit view. A cover is the table's sibling, so a table-
// owned recognizer is deliberately absent from its ancestor dispatch chain.
static UIPanGestureRecognizer *BeginInputPan(CSGroupListAdapter *a,CGPoint point,CGFloat x,CGFloat velocity) {
    UIView *hit=[a.inputHost hitTest:point withEvent:nil];
    UITouch *touch=[UITouch new];touch.view=hit;touch.point=point;
    for (UIView *view=hit;view;view=view.superview) {
        for (UIGestureRecognizer *gesture in view.gestureRecognizers.copy) {
            if (![gesture isKindOfClass:UIPanGestureRecognizer.class] || !gesture.enabled) continue;
            UIPanGestureRecognizer *pan=(UIPanGestureRecognizer *)gesture;
            pan.translation=CGPointMake(x,0);pan.velocity=CGPointMake(velocity,0);
            if (![a gestureRecognizer:pan shouldReceiveTouch:touch] || ![a gestureRecognizerShouldBegin:pan]) continue;
            pan.state=UIGestureRecognizerStateBegan;
            ((void(*)(id,SEL,id))objc_msgSend)(pan.target,pan.action,pan);return pan;
        }
    }
    return nil;
}
static void ContinueInputPan(UIPanGestureRecognizer *pan,UIGestureRecognizerState state,CGFloat x,CGFloat velocity) {
    if (!pan || !pan.view) return;
    pan.state=state;pan.translation=CGPointMake(x,0);pan.velocity=CGPointMake(velocity,0);
    ((void(*)(id,SEL,id))objc_msgSend)(pan.target,pan.action,pan);
}
static void RouteNativeTap(CSGroupListAdapter *a,CGPoint point) {
    UIView *hit=[a.inputHost hitTest:point withEvent:nil];
    if ([hit isDescendantOfView:a.table]) a.nativeRowTaps++;
}
static NSInvocation *Swipe(Host *host,BOOL end,BOOL commit,UITableView *table,NSIndexPath *path) {
    SEL selector=commit ? @selector(tableView:commitEditingStyle:forRowAtIndexPath:) : end ? @selector(tableView:didEndEditingRowAtIndexPath:) : @selector(tableView:willBeginEditingRowAtIndexPath:);
    NSInvocation *inv=[NSInvocation invocationWithMethodSignature:[host methodSignatureForSelector:selector]]; inv.selector=selector;
    [inv setArgument:&table atIndex:2];
    if (commit) { NSInteger style=1; [inv setArgument:&style atIndex:3]; }
    [inv setArgument:&path atIndex:commit ? 4 : 3]; [inv retainArguments]; return inv;
}
static void RunFor(NSTimeInterval seconds) {
    NSDate *deadline=[NSDate dateWithTimeIntervalSinceNow:seconds];
    while (deadline.timeIntervalSinceNow>0)
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.002]];
}
int main(void) { @autoreleasepool {
    InstallMenuTouchGate();
    CSGroupListAdapter *a=Fixture(); a.dirty=YES; [a reconcileDeletedSwipeRow];
    Check(a.swipeActive && a.table.editing && !a.table.closes,@"ordinary refresh preserves a still-valid native swipe menu");
    [a.controller.paths removeObjectForKey:@"deleted"]; a.changeDepth=1; [a reconcileDeletedSwipeRow];
    Check(a.swipeActive,@"identity loss during an unfinished native batch does not prematurely close editing");
    a.changeDepth=0; [a reconcileDeletedSwipeRow];
    Check(!a.swipeActive && !a.swipeRow && !a.table.editing && a.table.closes==1,@"deletion with no UIKit end callback releases both refresh blockers");
    Check(a.scheduled && a.controller.paths[@"survivor"]!=nil,@"deleted identity schedules refresh without deleting another session");
    a=Fixture(); a.dirty=YES; nativeScope=YES;
    [a forwardSwipeInvocation:Swipe(a.controller,YES,NO,a.table,Path(8)) target:a.controller];
    Check(!a.swipeActive && [a.controller.receivedPath isEqual:Path(8)],@"native-scope end callback clears the latch without double mapping its path"); nativeScope=NO;
    a=Fixture(); a.dirty=YES; [a.controller.paths removeObjectForKey:@"deleted"];
    [a forwardSwipeInvocation:Swipe(a.controller,YES,NO,a.table,Path(1)) target:a.controller];
    Check(!a.swipeActive && a.controller.calls==1 && !a.controller.receivedPath,@"deleted-row end forwards nil rather than a reused index and clears state");
    a=Fixture(); a.controller.throwOnEnd=YES;
    @try { [a forwardSwipeInvocation:Swipe(a.controller,YES,NO,a.table,Path(1)) target:a.controller]; } @catch (__unused NSException *exception) {}
    Check(!a.swipeActive && !nativeScope,@"native end exceptions still clean up swipe state and index scope");
    a=Fixture(); a.controller.paths[@"deleted"]=Path(15);
    [a forwardSwipeInvocation:Swipe(a.controller,NO,YES,a.table,Path(1)) target:a.controller];
    Check([a.controller.receivedPath isEqual:Path(15)] && a.changeDepth==0 && a.dirty,@"delete commit resolves the moved session identity and requests publication");
    a=Fixture(); [a forwardSwipeInvocation:Swipe(a.controller,NO,YES,a.table,Path(2)) target:a.controller];
    Check(a.controller.calls==0,@"commit from a different displayed row is rejected");
    a=Fixture(); NSDictionary *context=@{@"row":a.swipeRow,@"account":account,@"epoch":@(FixtureAccountEpoch)}; __block NSUInteger actions=0;
    BOOL done=[a performNativeEditingContext:context action:^(NSIndexPath *path) { actions++; Check(nativeScope && a.changeDepth==1 && [path isEqual:Path(8)],@"private editing action enters a native change transaction"); [a.controller.paths removeObjectForKey:@"deleted"]; }];
    [a reconcileDeletedSwipeRow];
    Check(done && actions==1 && a.dirty && !a.swipeActive && !a.table.editing,@"private deletion without UIKit commit/end still drains the stale projected menu");
    [a performNativeEditingContext:context action:^(__unused NSIndexPath *path) { actions++; }];
    Check(actions==1 && a.refreshRequests>=2,@"repeated action on a deleted identity never targets its replacement and requests refresh");
    a=Fixture(); context=@{@"row":a.swipeRow,@"account":account,@"epoch":@(FixtureAccountEpoch)}; [a endSwipeEditing];
    [a performNativeEditingContext:context action:^(__unused NSIndexPath *path) { [a.controller.paths removeObjectForKey:@"deleted"]; }];
    [a reconcileDeletedSwipeRow];
    Check(!a.swipeActive && !a.table.editing && a.dirty,@"private deletion without willBegin or didEnd still clears native editing and requests publication");
    a=Fixture(); context=@{@"row":a.swipeRow,@"account":@"different-account",@"epoch":@(FixtureAccountEpoch)};
    Check(![a performNativeEditingContext:context action:^(__unused NSIndexPath *path) { actions++; }] && actions==1,@"editing context cannot cross accounts");
    a=Fixture(); a.dirty=YES; account=@"account-B"; [a reconcileDeletedSwipeRow];
    Check(!a.swipeActive && !a.table.editing,@"account switch releases obsolete editing state"); account=@"account-A";

    a=Fixture(); WESessionTabItem *tab=[WESessionTabItem new]; tab.tabId=@"custom"; tab.displayName=@"项目讨论";
    a.displayedTabs=@[tab]; a.publishedTabID=@"custom";
    Check([[CSGroupListAdapter groupTitleForTitleView:a.controller.m_titleView] isEqual:@"项目讨论"],@"main title uses the selected custom group's display name");
    tab.displayName=@"Team";
    Check([[CSGroupListAdapter groupTitleForTitleView:a.controller.m_titleView] isEqual:@"Team"],@"renamed group title follows the published tab model");
    WESessionTabItem *previewTab=[WESessionTabItem new];previewTab.tabId=@"preview";previewTab.displayName=@"Next";
    a.displayedTabs=@[tab,previewTab];a.publishedTabID=@"preview";a.pagePreviewTabID=@"preview";a.pageTransitionContext=@{@"source":@"custom"};
    Check([[CSGroupListAdapter groupTitleForTitleView:a.controller.m_titleView] isEqual:@"Team"],@"transient neighboring rows keep the source navigation title while the finger is down");
    a.pagePreviewTabID=nil;a.pageTransitionContext=nil;
    Check([[CSGroupListAdapter groupTitleForTitleView:a.controller.m_titleView] isEqual:@"Next"],@"ending preview ownership allows the actual published target title");
    a.displayedTabs=@[tab];a.publishedTabID=@"custom";
    Check(![CSGroupListAdapter groupTitleForTitleView:[NSObject new]],@"unrelated title views are never replaced");
    a.searching=YES; Check(![CSGroupListAdapter groupTitleForTitleView:a.controller.m_titleView],@"search retains native title"); a.searching=NO;
    a.searching=YES; a.searchChromeVisible=YES;
    Check([[CSGroupListAdapter groupTitleForTitleView:a.controller.m_titleView] isEqual:@"Team"],@"shortcut search preserves the backing main-list group title");
    Check(![CSGroupListAdapter groupTitleForTitleView:[NativeTitle new]],@"search page title view is never replaced by the retained group name");
    [a.controller.m_titleView updateTitleView:7 title:@"微信(3)"];
    Check([a.controller.m_titleView.renderedTitle isEqual:@"Team"] && a.controller.m_titleView.renderedStatus==7,@"native title updates during entry retain group text and native status");
    for (NSUInteger i=0;i<4;i++) [a refreshNavigationTitle];
    Check([a.controller.m_titleView.renderedTitle isEqual:@"Team"],@"repeated transition layout title refreshes do not reveal WeChat");
    a.presentationSuspended=YES;
    [a.controller.m_titleView updateTitleView:8 title:@"微信"];
    Check([a.controller.m_titleView.renderedTitle isEqual:@"Team"],@"native title updates while search covers the list preserve the backing title");
    a.presentationSuspended=NO;
    searchButtonVisible=NO;
    Check(![CSGroupListAdapter groupTitleForTitleView:a.controller.m_titleView],@"disabling the shortcut preserves ordinary native search title policy"); searchButtonVisible=YES;
    a.chromeVisible=NO;
    Check(![CSGroupListAdapter groupTitleForTitleView:a.controller.m_titleView],@"explicit native presentation does not retain an unrelated group title"); a.chromeVisible=YES;
    enabled=NO;
    Check(![CSGroupListAdapter groupTitleForTitleView:a.controller.m_titleView],@"disabling grouping during search restores native title"); enabled=YES;
    account=@"account-B";
    Check(![CSGroupListAdapter groupTitleForTitleView:a.controller.m_titleView],@"search title retention cannot cross accounts"); account=@"account-A";
    a.searching=NO; a.searchChromeVisible=NO; [a refreshNavigationTitle];
    Check([a.controller.m_titleView.renderedTitle isEqual:@"Team"],@"search return keeps group title when transition ownership clears");
    enabled=NO; Check(![CSGroupListAdapter groupTitleForTitleView:a.controller.m_titleView],@"disabling groups restores native/customized title"); enabled=YES;
    account=@"account-B"; Check(![CSGroupListAdapter groupTitleForTitleView:a.controller.m_titleView],@"stale-account group name is not displayed"); account=@"account-A";

    [a.controller.m_titleView updateTitleView:7 title:@"微信(3)"];
    tab.displayName=@"新名称";
    [a refreshNavigationTitle];
    Check([a.controller.m_titleView.renderedTitle isEqual:@"新名称"] && a.controller.m_titleView.renderedStatus==7,@"native cached-title early return still renders the new group with its last native status");
    enabled=NO; [a refreshNavigationTitle];
    Check([a.controller.m_titleView.renderedTitle isEqual:@"微信(3)"] && a.controller.m_titleView.renderedStatus==7,@"disabling grouping replays the original title rather than the last substituted group name"); enabled=YES;
    NSUInteger beforeRenders=a.controller.m_titleView.renders;
    a.controller.titleToRender=@"微信(4)"; [a refreshNavigationTitle];
    Check(a.controller.m_titleView.renders==beforeRenders+1 && a.controller.m_titleView.renderedStatus==9,@"when native title updates normally it renders only once and preserves new flags");

    a=Fixture(); [a endSwipeEditing]; a.table.editing=NO;
    UITouch *touch=[UITouch new]; UIView *cell=[UIView new]; cell.superview=a.table; touch.view=cell;
    for (NSNumber *origin in @[@0,@37]) {
        a.table.bounds=CGRectMake(origin.doubleValue,0,400,800);
        for (NSNumber *fraction in @[@0.7,@0.8,@0.849,@0.85,@0.851,@0.9,@0.999]) {
            touch.point=CGPointMake(origin.doubleValue+400*fraction.doubleValue,300);
            BOOL received=[a gestureRecognizer:a.listPan shouldReceiveTouch:touch];
            Check(received==(fraction.doubleValue<0.85),@"left 85 percent owns grouping; exact boundary/right 15 percent stays native, including shifted bounds");
        }
    }
    gestureEnabled=NO; touch.point=CGPointMake(50,300);
    Check(![a gestureRecognizer:a.listPan shouldReceiveTouch:touch],@"disabled group gesture leaves native menu available everywhere"); gestureEnabled=YES;
    a.swipeActive=YES; Check([a gestureRecognizer:a.listPan shouldReceiveTouch:touch],@"editing state does not give the left zone to the menu");
    // Menu preparation may redundantly clear editing before willBeginEditing.
    a=Fixture(); [a endSwipeEditing]; a.table.editing=NO; a.dirty=NO;
    a.pan.enabled=NO; a.listPan.enabled=NO;
    NSUInteger requests=a.refreshRequests;
    [a.table setEditing:NO]; [a.table setEditing:NO animated:NO];
    Check(!a.dirty && a.refreshRequests==requests,@"redundant native editing resets do not invent a data refresh");
    Check(a.pan.enabled && a.listPan.enabled,@"closing a clean menu re-enables grouping without a reload");
    gestureEnabled=NO; [a.table setEditing:NO];
    Check(!a.pan.enabled && !a.listPan.enabled,@"closing a menu respects the disabled grouping gesture setting"); gestureEnabled=YES;
    a=Fixture(); a.dirty=YES; [a.table setEditing:NO animated:NO]; RunFor(0.02);
    Check(!a.swipeActive && !a.dirty && a.refreshCount==1,@"closing a dirty menu still publishes once through nested editing setters");
    a=Fixture(); [a.table setEditing:NO]; RunFor(0.02);
    Check(!a.swipeActive && a.viewportRestoreCalls==1 && !a.refreshCount && !a.refreshRequests,@"closing a clean menu checks pending viewport restoration once without reloading");

    a=Fixture(); [a endSwipeEditing]; a.table.editing=NO; a.table.tracking=YES;
    [a refresh]; RunFor(0.12);
    Check(a.refreshCount==0 && a.dirty && a.scheduled,@"touch-down before editing or dragging defers refresh and preserves the cell");
    Check(a.refreshRequests<=4,@"tracking deferral uses a delayed coalesced wake-up rather than a main-queue spin");
    a.table.tracking=NO; RunFor(0.08);
    Check(a.refreshCount==1 && !a.dirty && !a.scheduled,@"cancelled horizontal gesture resumes refresh without a scroll-end callback");

    a=Fixture(); [a endSwipeEditing]; a.table.editing=NO;
    [a requestRefresh]; a.table.tracking=YES; RunFor(0.02);
    Check(!a.refreshCount && a.dirty,@"a queued refresh also notices a touch that began after scheduling");
    a.table.tracking=NO; a.table.editing=YES;
    [a forwardSwipeInvocation:Swipe(a.controller,NO,NO,a.table,Path(1)) target:a.controller];
    RunFor(0.08);
    Check(!a.refreshCount && a.swipeActive && a.dirty && !a.scheduled,@"an opened menu retains pending updates without polling or reloading");
    [a.table setEditing:NO animated:NO]; RunFor(0.02);
    Check(a.refreshCount==1 && !a.swipeActive && !a.dirty,@"menu close drains the merged update exactly once");

    a=Fixture(); a.table.tracking=YES; a.dirty=YES;
    [a.controller.paths removeObjectForKey:@"deleted"]; [a refresh]; RunFor(0.02);
    Check(a.swipeActive && !a.table.closes,@"identity reconciliation cannot close editing while the finger is still down");
    a.table.tracking=NO; RunFor(0.08);
    Check(!a.swipeActive && !a.table.editing && a.refreshCount==1,@"actual deletion still clears stale editing and publishes after touch release");
    // The real custom menu can move while every UITableView interaction flag is false.
    a=Fixture(); HookedMenuCell *menu=MenuFixture(a);
    menu->_panGestureRecognizer.state=UIGestureRecognizerStateBegan;
    [a requestRefresh]; RunFor(0.12);
    Check(!a.refreshCount && a.dirty && a.scheduled,@"custom menu pan blocks reload even with editing/tracking/dragging false");
    Check(a.refreshRequests<=4,@"custom menu movement coalesces delayed wake-ups");
    menu->_panGestureRecognizer.state=UIGestureRecognizerStateChanged;
    [menu handlePan:menu->_panGestureRecognizer];
    Check(menu.panCalls==1 && menu.receivedPan==menu->_panGestureRecognizer,@"pan hook forwards the exact original gesture once");
    Check([a groupSwipesAvailable],@"native menu movement does not globally disable left-zone admission");
    menu->_panGestureRecognizer.state=UIGestureRecognizerStateEnded; menu.menuHidden=NO;
    [menu handlePan:menu->_panGestureRecognizer]; RunFor(0.08);
    Check(!a.refreshCount && a.dirty && !a.scheduled,@"stationary custom menu holds updates without permanent polling");
    Check([a groupSwipesAvailable],@"open custom menu keeps grouping available for a new left-zone swipe");
    __block NSUInteger completions=0; void (^completion)(void)=^{ completions++; };
    [menu setMenuOptionsViewHidden:YES animated:YES completionHandler:completion]; RunFor(0.08);
    Check(!a.refreshCount && a.scheduled,@"hidden flag changing at close start does not permit reload during animation");
    Check(menu.hideCalls==1 && menu.receivedAnimated && menu.receivedCompletion!=nil && !completions,@"visibility hook preserves native arguments and completion timing");
    menu->_inHideAnimation=NO; menu.receivedCompletion(); RunFor(0.08);
    Check(a.refreshCount==1 && !a.dirty && !a.scheduled && completions==1,@"close settles and publishes once without any standard scroll/edit callbacks");
    Check([a groupSwipesAvailable] && a.pan.enabled && a.listPan.enabled,@"group gestures recover after custom close without disabling recognizers mid-pan");

    a=Fixture(); menu=MenuFixture(a); menu.menuHidden=NO;
    [menu setMenuOptionsViewHidden:YES animated:YES completionHandler:nil];
    menu->_inHideAnimation=NO; RunFor(0.08);
    Check(!a.refreshCount && !a.refreshRequests && !a.scheduled && [a groupSwipesAvailable] && a.listPan.enabled,@"clean menu closure schedules no unnecessary reload and leaves gestures usable");

    a=Fixture(); menu=MenuFixture(a); menu.menuHidden=NO;
    [a requestRefresh]; RunFor(0.02);
    [menu setMenuOptionsViewHidden:YES animated:NO completionHandler:nil]; RunFor(0.02);
    Check(a.refreshCount==1 && !a.scheduled,@"nonanimated close hook wakes dormant dirty update");
    a=Fixture(); menu=MenuFixture(a); NSUInteger restores=a.viewportRestoreCalls;
    [menu setMenuOptionsViewHidden:YES animated:NO completionHandler:nil]; RunFor(0.02);
    Check(a.viewportRestoreCalls==restores+1 && !a.refreshCount && !a.refreshRequests,@"custom menu close checks pending viewport restoration once without reloading");

    a=Fixture(); menu=MenuFixture(a); menu->_panGestureRecognizer.state=UIGestureRecognizerStateChanged;
    [a requestRefresh]; RunFor(0.02);
    menu->_panGestureRecognizer.state=UIGestureRecognizerStateCancelled; [menu handlePan:menu->_panGestureRecognizer]; RunFor(0.08);
    Check(a.refreshCount==1 && !a.scheduled,@"cancelled custom pan resumes a pending publication");
    a=Fixture(); menu=MenuFixture(a); a.dirty=YES; menu.throwOnPan=YES;
    @try { [menu handlePan:menu->_panGestureRecognizer]; } @catch (__unused NSException *exception) {}
    RunFor(0.02);
    Check(menu.panCalls==1 && a.refreshCount==1,@"native pan exception still wakes pending work without swallowing the exception");

    a=Fixture(); menu=MenuFixture(a); menu.menuHidden=NO; a.dirty=YES;
    [a.controller.paths removeObjectForKey:@"deleted"]; a.changeDepth=1;
    Check([a nativeMenuState]!=0,@"unfinished native transaction does not mistake a transient missing row for deletion");
    a.changeDepth=0; NSUInteger deletedState=[a nativeMenuState]; [a refresh];
    Check(a.refreshCount==1 && !deletedState,@"deleted identity releases a stale custom menu instead of deadlocking refresh");
    a=Fixture(); menu=MenuFixture(a); menu.menuHidden=NO; account=@"account-B";
    Check(![a nativeMenuState],@"previous account custom menu cannot block the new account"); account=@"account-A";
    a.chromeVisible=NO; Check(![a nativeMenuState],@"hidden grouping leaves native menu presentation untouched");
    a.chromeVisible=YES; a.table.visibleCells=@[[UITableViewCell new]];
    Check(![a nativeMenuState],@"ordinary cells do not create false menu blockers");
    UITableView *otherTable=[UITableView new];
    menu=[HookedMenuCell new]; menu.superview=otherTable;
    [menu handlePan:nil];
    Check(menu.panCalls==1,@"other tables receive only their original native pan behavior");
    // Re-run both owners for EACH touch, including a previously opened menu.
    a=Fixture(); menu=MenuFixture(a); touch=[UITouch new]; touch.view=menu;
    for (NSNumber *open in @[@NO,@YES]) {
        menu.menuHidden=!open.boolValue; a.table.editing=open.boolValue; a.swipeActive=open.boolValue;
        [a updateGroupGestureAvailability];
        Check(a.listPan.enabled,@"menu editing state leaves the group recognizer enabled");
        for (NSNumber *origin in @[@0,@37]) {
            a.table.bounds=CGRectMake(origin.doubleValue,0,400,800);
            for (NSNumber *fraction in @[@0.0,@0.849,@0.85,@0.999]) {
                touch.point=CGPointMake(origin.doubleValue+400*fraction.doubleValue,300);
                BOOL group=[a gestureRecognizer:a.listPan shouldReceiveTouch:touch],native=ReceiveMenu(menu,touch);
                Check(group==(fraction.doubleValue<0.85) && native==!group,@"closed/open menus have mutually exclusive owners using viewport touch-down boundary");
            }
        }
    }
    a.table.bounds=CGRectMake(0,0,400,800); touch.point=CGPointMake(410,300);
    Check(!ReceiveMenu(menu,touch) && ![a gestureRecognizer:a.listPan shouldReceiveTouch:touch],@"outside-table touch belongs to neither owner");
    touch.point=CGPointMake(30,300); gestureEnabled=NO;
    Check(ReceiveMenu(menu,touch) && ![a gestureRecognizer:a.listPan shouldReceiveTouch:touch],@"disabled group gesture restores native touch policy"); gestureEnabled=YES;
    a.searching=YES; Check(ReceiveMenu(menu,touch),@"search is outside the group partition"); a.searching=NO;
    a.active=NO; Check(!ReceiveMenu(menu,touch) && [a gestureRecognizer:a.listPan shouldReceiveTouch:touch],@"native presentation with a visible group bar keeps the same exclusive zones");
    Check([a nativeMenuState]!=0,@"visible group bar still observes an open menu in native presentation");
    a.chromeVisible=NO; Check(ReceiveMenu(menu,touch),@"hidden grouping restores native menu policy"); a.chromeVisible=YES; a.active=YES;
    Check(MenuReceiveTouch(menu,@selector(gestureRecognizer:shouldReceiveTouch:),[UIGestureRecognizer new],touch),@"only the cell's own menu recognizer is restricted");
    OriginalMenuReceiveTouch=TestOriginalReceive;
    touch.point=CGPointMake(390,300);
    Check(!ReceiveMenu(menu,touch) && nativeReceiveCalls==1,@"right-zone admission preserves a native delegate rejection");
    touch.point=CGPointMake(30,300);
    Check(!ReceiveMenu(menu,touch) && nativeReceiveCalls==1,@"left-zone rejection happens before invoking the native delegate");
    OriginalMenuReceiveTouch=NULL;

    // Moving the finger across the boundary does not redo the admission decision.
    a=Fixture(); menu=MenuFixture(a); menu.menuHidden=NO;
    a.table.editing=YES; a.swipeActive=YES; a.displayedTabs=TwoTabs();
    touch.view=menu; touch.point=CGPointMake(50,300);
    Check([a gestureRecognizer:a.listPan shouldReceiveTouch:touch] && !ReceiveMenu(menu,touch),@"new left touch on an already-open row belongs only to grouping");
    a.listPan.velocity=CGPointMake(-500,0); a.listPan.translation=CGPointMake(-90,0);
    Check([a gestureRecognizerShouldBegin:a.listPan],@"left horizontal pan starts while the old menu is open");
    a.listPan.state=UIGestureRecognizerStateBegan; [a requestRefresh]; RunFor(0.08);
    Check(!a.refreshCount && a.dirty && a.scheduled,@"group movement also defers refresh without native table tracking flags");
    [a groupPan:a.listPan];
    Check(a.chrome.previews==1 && a.chrome.progress>0 && !a.groupSelections,@"began previews movement before release without changing groups");
    Check(a.pageTransitionRequests==1 && !a.pageTransitionBegins && !a.pageTransitionCommits && !a.pageAnimator && !a.preferences.selectionWrites,@"dirty source rejects admission before snapshot capture without committing selection");
    a.listPan.state=UIGestureRecognizerStateChanged; [a groupPan:a.listPan];
    Check(a.chrome.previews==2 && !a.groupSelections,@"changed continuously updates indicator preview");
    Check(a.pageTransitionRequests==2 && !a.pageTransitionBegins && !a.pageTransitionCommits && !a.preferences.selectionWrites,@"a cheap busy rejection stays retryable without performing any snapshot capture");
    touch.point=CGPointMake(390,300); a.listPan.state=UIGestureRecognizerStateEnded;
    [a groupPan:a.listPan];
    Check(a.groupSelections==1 && a.chrome.selectedIndex==1 && !a.selectionWithOpenMenu,@"left-owned completion closes the old menu before selecting another group");
    Check(!a.pageTransitionBegins && !a.pageTransitionCommits && a.preferences.selectionWrites==1,
        @"unavailable dirty preview retains one direct switch after the native menu closes");
    Check(menu.hideCalls==1 && menu.menuHidden && !menu.receivedAnimated && !a.table.editing && !a.swipeActive,@"group switch clears custom menu and standard editing without hide-animation races");
    RunFor(0.08); Check(!a.scheduled && a.refreshCount==1,@"deferred group interaction publishes once after release");
    a=Fixture(); menu=MenuFixture(a); a.displayedTabs=TwoTabs();
    touch.view=menu; touch.point=CGPointMake(390,300);
    Check(![a gestureRecognizer:a.listPan shouldReceiveTouch:touch] && ReceiveMenu(menu,touch),@"right touch belongs only to native menu");
    touch.point=CGPointMake(30,300); a.listPan.state=UIGestureRecognizerStateEnded;
    a.listPan.velocity=CGPointMake(-500,0); [a groupPan:a.listPan];
    Check(!a.groupSelections,@"right-owned touch never becomes a group switch after crossing left");
    Check(!a.pageTransitionBegins && !a.pageTransitionCommits,@"a native-menu touch never starts the page animator");
    touch.point=CGPointMake(30,300); [a gestureRecognizer:a.listPan shouldReceiveTouch:touch];
    a.listPan.velocity=CGPointMake(10,500);
    Check(![a gestureRecognizerShouldBegin:a.listPan],@"left vertical motion remains native scrolling");
    a.listPan.state=UIGestureRecognizerStateCancelled; [a groupPan:a.listPan];
    Check(!a.groupSelections && !menu.hideCalls,@"cancelled group attempt neither switches nor forcibly closes a menu");
    Check(!a.pageTransitionBegins && !a.pageTransitionCommits,@"a cancelled gesture never starts a page transition");
    UIControl *menuButton=[UIControl new]; menuButton.superview=menu; touch.view=menuButton;
    Check([a gestureRecognizer:a.listPan shouldReceiveTouch:touch] && !ReceiveMenu(menu,touch),@"left-zone menu buttons do not hand horizontal group pans back to the native menu");

    a=PanFixture(1);
    touch.view=a.table; touch.point=CGPointMake(30,300);
    [a gestureRecognizer:a.listPan shouldReceiveTouch:touch];
    SendPan(a,UIGestureRecognizerStateBegan,20,500);
    Check(a.pageTransitionBegins==1 && a.pageAnimator.translation==20 && !a.preferences.selectionWrites,@"right drag prepares the previous page before release without persisting it");
    SendPan(a,UIGestureRecognizerStateEnded,90,500);
    Check(!a.groupSelections && a.preferences.selectionWrites==1 && a.pageTransitionBegins==1 && a.pageTransitionCommits==1 &&
        a.pageTransitionIndex==0 && a.pageTransitionDirection==-1,@"successful right swipe commits the prepared previous page once");

    a=Fixture(); [a endSwipeEditing]; a.table.editing=NO;
    a.displayedTabs=TwoTabs();
    touch.view=a.table; touch.point=CGPointMake(30,300); [a gestureRecognizer:a.listPan shouldReceiveTouch:touch];
    a.listPan.state=UIGestureRecognizerStateEnded; a.listPan.translation=CGPointMake(-20,0); a.listPan.velocity=CGPointMake(-80,0);
    [a groupPan:a.listPan];
    Check(!a.groupSelections && !a.pageTransitionBegins && !a.pageTransitionCommits,@"a release below both switching thresholds does not route to the page animator");

    a=PanFixture(0); SendPan(a,UIGestureRecognizerStateBegan,-12,-200);
    CSGroupPageAnimator *interactive=a.pageAnimator;
    Check(a.pageTransitionBegins==1 && interactive.updates==1 && interactive.translation==-12 && !a.preferences.selectionWrites && a.chrome.selectedIndex==0,@"began publishes signed drag progress while saved selection and indicator ownership remain at source");
    SendPan(a,UIGestureRecognizerStateChanged,-80,-300);
    Check(a.pageAnimator==interactive && interactive.updates==2 && interactive.translation==-80 && a.pageTransitionBegins==1 && !a.pageTransitionCommits && !a.preferences.selectionWrites,@"changed moves both prepared pages continuously without re-preparing or selecting");
    Check(fabs(interactive.progress-.20)<.0001 && fabs(a.chrome.progress-interactive.progress)<.0001,@"an active page preview drives the indicator with real viewport progress instead of the short legacy travel");
    SendPan(a,UIGestureRecognizerStateChanged,-20,250);
    Check(interactive.updates==3 && interactive.translation==-20 && !a.preferences.selectionWrites,@"pulling back updates the same interactive progress immediately");
    Check(fabs(a.chrome.progress-.05)<.0001 && fabs(a.chrome.progress-interactive.progress)<.0001,@"reversing the page drag reverses indicator progress by the same normalized distance");
    SendPan(a,UIGestureRecognizerStateEnded,-20,-500);
    Check(interactive.updates==4 && interactive.translation==-20 && a.pageTransitionBegins==1 && a.pageTransitionCommits==1 && a.preferences.selectionWrites==1 && [a.preferences.selectedTabID isEqual:@"target"],@"forward high velocity commits a short prepared drag exactly once from its final translation");

    for (NSNumber *terminalState in @[@(UIGestureRecognizerStateCancelled),@(UIGestureRecognizerStateFailed)]) {
        a=PanFixture(0); SendPan(a,UIGestureRecognizerStateBegan,-70,-300); SendPan(a,terminalState.integerValue,-70,0);
        Check(a.pageTransitionRollbacks==1 && !a.pageAnimator && !a.preferences.selectionWrites && [a.preferences.selectedTabID isEqual:@"source"] && !a.pageTransitionCommits,@"cancelled and failed drags restore source through rollback without committing");
    }
    a=PanFixture(0); SendPan(a,UIGestureRecognizerStateBegan,-25,-100); SendPan(a,UIGestureRecognizerStateEnded,-20,-80);
    Check(a.pageTransitionRollbacks==1 && a.rollbackVelocity==-80 && !a.preferences.selectionWrites && !a.pageTransitionCommits,@"below-threshold release rebounds with the real release velocity and no selection write");
    for (NSNumber *distance in @[@(-10),@(-90)]) {
        a=PanFixture(0); SendPan(a,UIGestureRecognizerStateBegan,-90,-500); SendPan(a,UIGestureRecognizerStateEnded,distance.doubleValue,800);
        Check(a.pageTransitionRollbacks==1 && a.rollbackVelocity==800 && !a.preferences.selectionWrites && !a.pageTransitionCommits,@"fast pull toward source cancels a prepared next page even before crossing zero");
    }
    a=PanFixture(0); a.rejectPagePreview=YES;
    SendPan(a,UIGestureRecognizerStateBegan,-10,-300); SendPan(a,UIGestureRecognizerStateChanged,-30,-300); SendPan(a,UIGestureRecognizerStateChanged,-50,-300);
    Check(a.pageTransitionBegins==1 && !a.pageAnimator && !a.preferences.selectionWrites,@"a rejected target preparation is attempted once per gesture rather than every frame");
    SendPan(a,UIGestureRecognizerStateEnded,-90,-500);
    Check(a.groupSelections==1 && a.preferences.selectionWrites==1 && !a.pageTransitionCommits,@"a failed visual preparation keeps the established confirmed direct-switch fallback");
    a=PanFixture(0);a.rejectPagePreview=YES;SendPan(a,UIGestureRecognizerStateBegan,-56,-300);
    Check(!a.pageAnimator && fabs(a.chrome.progress-.5)<.0001,@"an unavailable page snapshot keeps the original 112-point indicator travel for a 400-point list");
    for (NSNumber *width in @[@200,@800]) {
        a=PanFixture(0);a.table.bounds=CGRectMake(0,0,width.doubleValue,800);SendPan(a,UIGestureRecognizerStateBegan,-40,-300);
        Check(fabs(a.chrome.progress-(40/width.doubleValue))<.0001 && fabs(a.chrome.progress-a.pageAnimator.progress)<.0001,@"page and indicator progress remain synchronized at compact and wide viewport sizes");
        a=PanFixture(0);a.table.bounds=CGRectMake(0,0,width.doubleValue,800);pageAnimationEnabled=NO;SendPan(a,UIGestureRecognizerStateBegan,-40,-300);
        CGFloat travel=MAX(88,MIN(160,width.doubleValue*.28));
        Check(!a.pageAnimator && fabs(a.chrome.progress-(40/travel))<.0001,@"animation-off grouping preserves the established minimum and maximum indicator travel bounds");
        pageAnimationEnabled=YES;
    }
    a=PanFixture(1);SendPan(a,UIGestureRecognizerStateBegan,100,500);
    Check(a.pageAnimator.direction==-1 && fabs(a.pageAnimator.progress-.25)<.0001 && fabs(a.chrome.progress-.25)<.0001,@"a previous-page drag uses the same positive normalized progress for both pixels and indicator");
    a=PanFixture(0); SendPan(a,UIGestureRecognizerStateBegan,25,300);
    Check(!a.pageTransitionBegins && !a.pageAnimator && !a.preferences.selectionWrites,@"outward drag at the first tab cannot manufacture a neighboring page");
    SendPan(a,UIGestureRecognizerStateChanged,-45,-300);
    Check(a.pageTransitionBegins==1 && a.pageAnimator.translation==-45,@"an outward edge drag can return to the valid neighbor during the same gesture");
    interactive=a.pageAnimator;SendPan(a,UIGestureRecognizerStateChanged,20,300);SendPan(a,UIGestureRecognizerStateChanged,-60,-300);
    Check(a.pageTransitionBegins==2 && a.pageAnimator!=interactive && a.pageAnimator.translation==-60 && !a.preferences.selectionWrites,@"a successful preview can cross the outer edge and prepare the same neighbor again");
    a=PanFixture(0);a.dirty=YES;SendPan(a,UIGestureRecognizerStateBegan,-15,-300);
    Check(a.pageTransitionRequests==1 && !a.pageTransitionBegins && !a.pagePreviewAttemptedTarget,@"cheap busy admission does not latch an unattempted snapshot target");
    a.dirty=NO;SendPan(a,UIGestureRecognizerStateChanged,-60,-300);
    Check(a.pageTransitionRequests==2 && a.pageTransitionBegins==1 && a.pageAnimator.translation==-60,@"a transient busy source can recover and prepare the first snapshot during changed");
    a=PanFixture(1); WESessionTabItem *third=[WESessionTabItem new]; third.tabId=@"third";
    a.displayedTabs=[a.displayedTabs arrayByAddingObject:third];
    SendPan(a,UIGestureRecognizerStateBegan,-55,-300); interactive=a.pageAnimator;
    SendPan(a,UIGestureRecognizerStateChanged,45,300);
    Check(a.pageTransitionBegins==2 && a.pageAnimator!=interactive && a.pageTransitionIndex==0 && a.pageTransitionDirection==-1 && a.pageAnimator.translation==45 && !a.preferences.selectionWrites,@"crossing zero rebuilds the opposite neighbor and preserves saved source selection");
    a=PanFixture(0); SendPan(a,UIGestureRecognizerStateBegan,-55,-300); gestureEnabled=NO; SendPan(a,UIGestureRecognizerStateChanged,-60,-300); gestureEnabled=YES;
    Check(a.pageTransitionRollbacks==1 && !a.preferences.selectionWrites && !a.pageAnimator,@"lost gesture admission withdraws the active preview without committing");

    a=PanFixture(0);third=[WESessionTabItem new];third.tabId=@"third";a.displayedTabs=[a.displayedTabs arrayByAddingObject:third];
    Check(a.listPan.view==a.inputHost && ![a.table.gestureRecognizers containsObject:a.listPan],@"the real host helper attaches the list pan to the stable common parent");
    UIPanGestureRecognizer *routed=BeginInputPan(a,CGPointMake(250,300),-25,-500);
    Check(routed==a.listPan && a.pageTransitionBegins==1 && a.pageAnimator.translation==-25,@"an actual table hit dispatches the first horizontal input through its recognizer ancestor");
    ContinueInputPan(routed,UIGestureRecognizerStateEnded,-90,-500);interactive=a.pageAnimator;UIView *oldCover=interactive.overlay;
    Check(interactive.animating && a.pageTransitionCommits==1 && a.preferences.selectionWrites==1 && [a.preferences.selectedTabID isEqual:@"target"],@"the first accepted swipe leaves its cover present while settling");
    Check([a.inputHost hitTest:CGPointMake(250,300) withEvent:nil]==oldCover,@"the next touch really hits the old sibling cover instead of the table");
    RouteNativeTap(a,CGPointMake(250,300));
    Check(!a.nativeRowTaps,@"a left-zone tap on copied rows remains shielded from native row actions");
    Check(!BeginInputPan(a,CGPointMake(370,300),-20,-500),@"the cover's right fifteen percent does not start a group swipe");
    RouteNativeTap(a,CGPointMake(370,300));
    Check(!a.nativeRowTaps && a.pageAnimator==interactive,@"right-zone cover touches remain shielded while the accepted page settles");
    routed=BeginInputPan(a,CGPointMake(250,300),-15,-500);
    Check(routed==a.listPan && !oldCover.superview && routed.view==a.inputHost && a.pageTransitionBegins==2 && a.pageTransitionIndex==2 &&
        [a.pageTransitionContext[@"source"] isEqual:@"target"] && a.preferences.selectionWrites==1,@"a second cover hit interrupts settling and previews B to C while its recognizer survives cover removal");
    ContinueInputPan(routed,UIGestureRecognizerStateChanged,-65,-500);
    Check(a.pageAnimator.translation==-65 && a.pageTransitionBegins==2 && a.preferences.selectionWrites==1,@"the same admitted recognizer keeps receiving changed after its original cover is removed");
    ContinueInputPan(routed,UIGestureRecognizerStateEnded,-95,-500);
    Check(a.pageTransitionCommits==2 && a.preferences.selectionWrites==2 && [a.preferences.selectedTabID isEqual:@"third"],@"second end commits C exactly once before the previous visual settle completes");
    a=PanFixture(0);routed=BeginInputPan(a,CGPointMake(250,300),-25,-500);ContinueInputPan(routed,UIGestureRecognizerStateEnded,-90,-500);
    routed=BeginInputPan(a,CGPointMake(250,300),25,500);
    Check(routed==a.listPan && a.pageTransitionIndex==0 && a.pageTransitionDirection==-1 && [a.pageTransitionContext[@"source"] isEqual:@"target"],@"a reverse second cover gesture previews B back to A from the accepted selection");
    ContinueInputPan(routed,UIGestureRecognizerStateEnded,95,500);
    Check(a.preferences.selectionWrites==2 && [a.preferences.selectedTabID isEqual:@"source"],@"a reverse second gesture commits its actual previous group once");
    for (NSNumber *terminalState in @[@(UIGestureRecognizerStateEnded),@(UIGestureRecognizerStateCancelled),@(UIGestureRecognizerStateFailed)]) {
        a=PanFixture(0);a.deferRollbackCompletion=YES;
        routed=BeginInputPan(a,CGPointMake(250,300),-25,-100);ContinueInputPan(routed,terminalState.integerValue,-20,-80);interactive=a.pageAnimator;
        Check(interactive.animating && !a.preferences.selectionWrites && [a.preferences.selectedTabID isEqual:@"source"],@"rollback keeps a covered source while the first gesture finishes without selection");
        routed=BeginInputPan(a,CGPointMake(250,300),-25,-500);
        Check(routed==a.listPan && a.pageAnimator!=interactive && a.pageTransitionIndex==1 && [a.pageTransitionContext[@"source"] isEqual:@"source"] && !a.preferences.selectionWrites,@"new cover input during rebound starts from A after ended, cancelled or failed input");
        ContinueInputPan(routed,UIGestureRecognizerStateEnded,-95,-500);
        Check(a.preferences.selectionWrites==1 && [a.preferences.selectedTabID isEqual:@"target"],@"the restarted gesture accepts exactly one selection after a rollback");
    }
    a=PanFixture(0);UIControl *floating=[[UIControl alloc] initWithFrame:CGRectMake(10,250,80,60)];[a.inputHost addSubview:floating];
    Check(!BeginInputPan(a,CGPointMake(30,275),-25,-500) && !a.pageTransitionBegins,@"a sibling floating control is rejected even though the parent recognizer sees its touch");
    [floating removeFromSuperview];a.headerContainer.frame=CGRectMake(0,0,400,100);a.headerContainer.bounds=CGRectMake(0,0,400,100);[a.table addSubview:a.headerContainer];
    Check(!BeginInputPan(a,CGPointMake(30,50),-25,-500) && !a.pageTransitionBegins,@"a table header descendant remains excluded by the parent-owned list pan");
    Check(!BeginInputPan(a,CGPointMake(370,300),-25,-500),@"an uncovered table preserves the right-zone native owner");
    RouteNativeTap(a,CGPointMake(370,300));Check(a.nativeRowTaps==1,@"uncovered native row taps still reach the actual table subtree");
    for (NSString *mode in @[@"default-off",@"Reduce Motion"]) {
        a=PanFixture(0);menu=MenuFixture(a);menu.menuHidden=NO;a.table.editing=YES;a.swipeActive=YES;
        pageAnimationEnabled=![mode isEqual:@"default-off"];reducedMotion=[mode isEqual:@"Reduce Motion"];
        SendPan(a,UIGestureRecognizerStateBegan,-20,-500);SendPan(a,UIGestureRecognizerStateChanged,-60,-500);
        Check(!menu.hideCalls && !menu.menuHidden && a.table.editing && a.swipeActive && !a.pageSourcePreparations && !a.pageTransitionBegins && !a.pageAnimator && !a.preferences.selectionWrites,
            [NSString stringWithFormat:@"%@ preserves the native open menu throughout drag without preparing a page",mode]);
        Check(fabs(a.chrome.progress-(60/112.0))<.0001,[NSString stringWithFormat:@"%@ retains the original indicator travel while page preview is suppressed",mode]);
        SendPan(a,UIGestureRecognizerStateEnded,-90,-500);
        Check(menu.hideCalls==1 && menu.menuHidden && !a.table.editing && !a.swipeActive && a.groupSelections==1 && a.preferences.selectionWrites==1 && !a.pageTransitionBegins && !a.pageTransitionCommits,
            [NSString stringWithFormat:@"%@ closes the menu only when release confirms the existing direct group switch",mode]);
        pageAnimationEnabled=YES;reducedMotion=NO;
    }
    printf("Group interactions: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
    return failures ? 1 : 0;
} }
