#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import <dispatch/dispatch.h>
static char TitleContextKey,CellRowKey;

@interface UIView : NSObject
@property(nonatomic,weak) UIView *superview;
@property(nonatomic) CGRect bounds;
@property(nonatomic) CGSize contentSize;
- (BOOL)isDescendantOfView:(UIView *)view;
@end
@implementation UIView
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
@property(nonatomic,strong) UIView *view;
@end
@implementation UIGestureRecognizer @end
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
@property(nonatomic) NSUInteger selections;
- (void)selectTabAtIndex:(NSInteger)index animated:(BOOL)animated;
@end
@implementation Chrome
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
@property(nonatomic,copy) NSString *accountID;
@end
@implementation CSGroupPreferences @end
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
static BOOL enabled=YES,gestureEnabled=YES,nativeScope;
static NSString *account=@"account-A";
static NSString *CSGroupCurrentAccountID(void) { return account; }
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
@property(nonatomic) NSUInteger modelRevision,snapshotRevision,refreshGeneration;
@property(nonatomic) BOOL coalescingNotification,scheduledCoalesced;
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
@property(nonatomic) BOOL active,swipeActive,dirty,scheduled,publishing,pendingScrollToTop,chromeVisible,searching,barTouchAllowed,listTouchAllowed;
@property(nonatomic) NSUInteger changeDepth,refreshRequests,refreshCount;
@property(nonatomic,strong) CSGroupProjection *projection;
@property(nonatomic,strong) CSGroupPreferences *preferences;
@property(nonatomic,strong) NSArray *displayedTabs;
@property(nonatomic,strong) UIPanGestureRecognizer *pan,*listPan;
@property(nonatomic) NSUInteger groupSelections;
@property(nonatomic) BOOL selectionWithOpenMenu;
@property(nonatomic,strong) Chrome *chrome;
@property(nonatomic,strong) UIView *headerContainer;
- (BOOL)isActive;
- (NSIndexPath *)currentPathForRow:(CSGroupRow *)row;
- (NSIndexPath *)displayPath:(NSIndexPath *)path;
+ (instancetype)adapterForTable:(UITableView *)table;
- (void)requestRefresh;
- (void)enqueueRefresh;
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
@end
@implementation CSGroupListAdapter
- (void)invalidateNativeSnapshot { self.modelRevision++; }
- (void)pruneNativeActions {}
- (void)finishSuspendedBatches {}
#include "GroupInteractionBodies.h"
- (BOOL)isActive { return self.active; }
- (NSIndexPath *)currentPathForRow:(CSGroupRow *)row { return CSGroupResolveNativeRowPath(self.controller,row,YES); }
- (NSIndexPath *)displayPath:(NSIndexPath *)path { (void)path; return [NSIndexPath indexPathWithIndex:1]; }
+ (instancetype)adapterForTable:(UITableView *)table { return table.adapter; }
- (void)requestRefresh { self.refreshRequests++; [self enqueueRefresh]; }
- (void)selectIndex:(NSInteger)index { (void)index; self.groupSelections++; self.selectionWithOpenMenu=[self nativeMenuState]!=0 || self.table.editing || self.swipeActive; }
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
static CSGroupListAdapter *Fixture(void) {
    CSGroupListAdapter *a=[CSGroupListAdapter new]; a.active=YES; a.chromeVisible=YES;
    a.table=[HookedTable new]; a.table.adapter=a; a.table.editing=YES; a.table.bounds=CGRectMake(0,0,400,800);
    a.controller=[Host new]; a.controller.paths=[@{@"deleted":Path(8),@"survivor":Path(12)} mutableCopy];
    a.controller.m_titleView=[NativeTitle new];
    a.swipeRow=[CSGroupRow new]; a.swipeRow.userName=@"deleted";
    a.swipeActive=YES; a.swipeAccount=account; a.swipeDisplayPath=Path(1);
    a.projection=[CSGroupProjection new]; a.projection.accountID=account; a.projection.rows=@{Path(1):a.swipeRow};
    a.preferences=[CSGroupPreferences new]; a.preferences.accountID=account;
    a.pan=[UIPanGestureRecognizer new]; a.listPan=[UIPanGestureRecognizer new];
    a.chrome=[Chrome new]; a.chrome.scrollView=[UIView new]; a.headerContainer=[UIView new];
    [Adapters() addObject:a]; return a;
}
static HookedMenuCell *MenuFixture(CSGroupListAdapter *a) {
    [a endSwipeEditing]; a.table.editing=NO;
    HookedMenuCell *cell=[HookedMenuCell new]; cell.superview=a.table;
    cell->_panGestureRecognizer=[UIGestureRecognizer new]; cell.menuHidden=YES;
    a.table.visibleCells=@[cell];
    objc_setAssociatedObject(cell,&CellRowKey,@{@"row":a.projection.rows[Path(1)],@"account":account},OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return cell;
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
    Check(a.refreshRequests>0 && a.controller.paths[@"survivor"]!=nil,@"deleted identity schedules refresh without deleting another session");
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
    a=Fixture(); NSDictionary *context=@{@"row":a.swipeRow,@"account":account}; __block NSUInteger actions=0;
    BOOL done=[a performNativeEditingContext:context action:^(NSIndexPath *path) { actions++; Check(nativeScope && a.changeDepth==1 && [path isEqual:Path(8)],@"private editing action enters a native change transaction"); [a.controller.paths removeObjectForKey:@"deleted"]; }];
    [a reconcileDeletedSwipeRow];
    Check(done && actions==1 && a.dirty && !a.swipeActive && !a.table.editing,@"private deletion without UIKit commit/end still drains the stale projected menu");
    [a performNativeEditingContext:context action:^(__unused NSIndexPath *path) { actions++; }];
    Check(actions==1 && a.refreshRequests>=2,@"repeated action on a deleted identity never targets its replacement and requests refresh");
    a=Fixture(); context=@{@"row":a.swipeRow,@"account":account}; [a endSwipeEditing];
    [a performNativeEditingContext:context action:^(__unused NSIndexPath *path) { [a.controller.paths removeObjectForKey:@"deleted"]; }];
    [a reconcileDeletedSwipeRow];
    Check(!a.swipeActive && !a.table.editing && a.dirty,@"private deletion without willBegin or didEnd still clears native editing and requests publication");
    a=Fixture(); context=@{@"row":a.swipeRow,@"account":@"different-account"};
    Check(![a performNativeEditingContext:context action:^(__unused NSIndexPath *path) { actions++; }] && actions==1,@"editing context cannot cross accounts");
    a=Fixture(); a.dirty=YES; account=@"account-B"; [a reconcileDeletedSwipeRow];
    Check(!a.swipeActive && !a.table.editing,@"account switch releases obsolete editing state"); account=@"account-A";

    a=Fixture(); WESessionTabItem *tab=[WESessionTabItem new]; tab.tabId=@"custom"; tab.displayName=@"项目讨论";
    a.displayedTabs=@[tab]; a.publishedTabID=@"custom";
    Check([[CSGroupListAdapter groupTitleForTitleView:a.controller.m_titleView] isEqual:@"项目讨论"],@"main title uses the selected custom group's display name");
    tab.displayName=@"Team";
    Check([[CSGroupListAdapter groupTitleForTitleView:a.controller.m_titleView] isEqual:@"Team"],@"renamed group title follows the published tab model");
    Check(![CSGroupListAdapter groupTitleForTitleView:[NSObject new]],@"unrelated title views are never replaced");
    a.searching=YES; Check(![CSGroupListAdapter groupTitleForTitleView:a.controller.m_titleView],@"search retains native title"); a.searching=NO;
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
    a=Fixture(); a.pendingScrollToTop=YES; [a.table setEditing:NO]; RunFor(0.02);
    Check(!a.swipeActive && a.refreshCount==1,@"closing a menu wakes a pending return-to-top operation");

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
    Check(menu.hideCalls==1 && menu.receivedAnimated && menu.receivedCompletion==completion && !completions,@"visibility hook preserves native arguments and completion identity/timing");
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
    a=Fixture(); menu=MenuFixture(a); a.pendingScrollToTop=YES;
    [menu setMenuOptionsViewHidden:YES animated:NO completionHandler:nil]; RunFor(0.02);
    Check(a.refreshCount==1,@"custom menu close wakes pending top request");

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
    a.table.editing=YES; a.swipeActive=YES; a.displayedTabs=@[[WESessionTabItem new],[WESessionTabItem new]];
    touch.view=menu; touch.point=CGPointMake(50,300);
    Check([a gestureRecognizer:a.listPan shouldReceiveTouch:touch] && !ReceiveMenu(menu,touch),@"new left touch on an already-open row belongs only to grouping");
    a.listPan.velocity=CGPointMake(-500,0); a.listPan.translation=CGPointMake(-90,0);
    Check([a gestureRecognizerShouldBegin:a.listPan],@"left horizontal pan starts while the old menu is open");
    a.listPan.state=UIGestureRecognizerStateBegan; [a requestRefresh]; RunFor(0.08);
    Check(!a.refreshCount && a.dirty && a.scheduled,@"group movement also defers refresh without native table tracking flags");
    touch.point=CGPointMake(390,300); a.listPan.state=UIGestureRecognizerStateEnded;
    [a groupPan:a.listPan];
    Check(a.groupSelections==1 && a.chrome.selectedIndex==1 && !a.selectionWithOpenMenu,@"left-owned completion closes the old menu before selecting another group");
    Check(menu.hideCalls==1 && menu.menuHidden && !menu.receivedAnimated && !a.table.editing && !a.swipeActive,@"group switch clears custom menu and standard editing without hide-animation races");
    RunFor(0.08); Check(!a.scheduled && a.refreshCount==1,@"deferred group interaction publishes once after release");
    a=Fixture(); menu=MenuFixture(a); a.displayedTabs=@[[WESessionTabItem new],[WESessionTabItem new]];
    touch.view=menu; touch.point=CGPointMake(390,300);
    Check(![a gestureRecognizer:a.listPan shouldReceiveTouch:touch] && ReceiveMenu(menu,touch),@"right touch belongs only to native menu");
    touch.point=CGPointMake(30,300); a.listPan.state=UIGestureRecognizerStateEnded;
    a.listPan.velocity=CGPointMake(-500,0); [a groupPan:a.listPan];
    Check(!a.groupSelections,@"right-owned touch never becomes a group switch after crossing left");
    touch.point=CGPointMake(30,300); [a gestureRecognizer:a.listPan shouldReceiveTouch:touch];
    a.listPan.velocity=CGPointMake(10,500);
    Check(![a gestureRecognizerShouldBegin:a.listPan],@"left vertical motion remains native scrolling");
    a.listPan.state=UIGestureRecognizerStateCancelled; [a groupPan:a.listPan];
    Check(!a.groupSelections && !menu.hideCalls,@"cancelled group attempt neither switches nor forcibly closes a menu");
    UIControl *menuButton=[UIControl new]; menuButton.superview=menu; touch.view=menuButton;
    Check([a gestureRecognizer:a.listPan shouldReceiveTouch:touch] && !ReceiveMenu(menu,touch),@"left-zone menu buttons do not hand horizontal group pans back to the native menu");
    printf("Group interactions: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
    return failures ? 1 : 0;
} }
