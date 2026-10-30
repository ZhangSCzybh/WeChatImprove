#import "GroupRefreshFixture.h"
// Production method bodies + small host doubles. No real defaults, accounts or UI.
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import <dispatch/dispatch.h>
#import <math.h>

typedef struct { CGFloat top,left,bottom,right; } UIEdgeInsets;
@interface NSIndexPath (GroupViewport)
+ (instancetype)indexPathForRow:(NSInteger)row inSection:(NSInteger)section;
@end
@implementation NSIndexPath (GroupViewport)
+ (instancetype)indexPathForRow:(NSInteger)row inSection:(NSInteger)section {
    NSUInteger indexes[]={(NSUInteger)section,(NSUInteger)row};
    return [self indexPathWithIndexes:indexes length:2];
}
@end
@interface WESessionTabItem : NSObject
@property(nonatomic,copy) NSString *tabId;
@end
@implementation WESessionTabItem @end
@interface TestChrome : NSObject
@property(nonatomic,copy) NSString *selectedTabID;
@end
@implementation TestChrome @end
@interface UITableView : NSObject
@property(nonatomic) CGRect bounds;
@property(nonatomic) CGSize contentSize;
@property(nonatomic) CGPoint contentOffset;
@property(nonatomic) UIEdgeInsets adjustedContentInset;
@property(nonatomic) UIEdgeInsets contentInset;
@property(nonatomic,strong) id window;
@property(nonatomic) BOOL tracking,dragging,decelerating,editing;
@property(nonatomic) CGFloat decelerationRate;
@property(nonatomic,strong) id tableHeaderView;
@property(nonatomic,strong) NSArray *indexPathsForVisibleRows;
@property(nonatomic,strong) NSDictionary<NSIndexPath *,NSNumber *> *rowOrigins;
@property(nonatomic) NSUInteger offsetWrites;
- (CGRect)rectForRowAtIndexPath:(NSIndexPath *)path;
- (void)layoutIfNeeded;
- (void)setContentOffset:(CGPoint)point animated:(BOOL)animated;
@end
@implementation UITableView
- (void)layoutIfNeeded {}
- (CGRect)rectForRowAtIndexPath:(NSIndexPath *)path { return CGRectMake(0,[self.rowOrigins[path] doubleValue],320,80); }
- (void)setContentOffset:(CGPoint)point animated:(BOOL)animated { (void)animated; self.offsetWrites++; self.contentOffset=point; }
@end
@interface HostController : NSObject
@property(nonatomic,strong) UITableView *m_tableView;
@property(nonatomic) BOOL isSearching;
@property(nonatomic) NSUInteger nativeAppearanceCalls;
@property(nonatomic,copy) void (^nativeAppearanceMutation)(void);
- (void)nativeAppearance:(BOOL)animated;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)viewDidDisappear:(BOOL)animated;
@end
@interface CSGroupRow : NSObject
@property(nonatomic,copy) NSString *userName;
@property(nonatomic) NSUInteger kind;
@end
@implementation CSGroupRow @end
@interface CSGroupProjection : NSObject
@property(nonatomic,strong) NSArray<NSArray<CSGroupRow *> *> *sections;
@property(nonatomic,copy) NSString *accountID;
@property(nonatomic,getter=isValid) BOOL valid;
@property(nonatomic) NSUInteger privacyRevision;
- (CSGroupRow *)rowAtDisplayPath:(NSIndexPath *)path;
@end
@implementation CSGroupProjection
- (void)discardComputationCache {}
- (CSGroupRow *)rowAtDisplayPath:(NSIndexPath *)path {
    if (!path || path.length!=2) return nil;
    NSUInteger section=[path indexAtPosition:0],row=[path indexAtPosition:1];
    return section<self.sections.count && row<self.sections[section].count ? self.sections[section][row] : nil;
}
@end
@interface CSGroupPreferences : NSObject
@property(nonatomic,copy) NSString *accountID,*selectedTabID;
@property(nonatomic,strong) NSArray *tabs;
@end
@implementation CSGroupPreferences @end
static char AdapterKey, PresentationSuspendedKey;
static BOOL enabled=YES;
static NSString *account=@"test-account";
static NSUInteger accountEpoch=1;
static NSHashTable *Adapters(void) {
    static NSHashTable *adapters;
    if (!adapters) adapters=[NSHashTable weakObjectsHashTable];
    return adapters;
}
static BOOL Option(NSString *suffix) { (void)suffix; return enabled; }
static NSString *CSGroupCurrentAccountID(void) { return account; }
static NSUInteger CSCloseFriendAccountEpoch(void) { return accountEpoch; }
@interface CSCloseFriendSnapshot : NSObject
@property(nonatomic,copy) NSString *accountID;
@property(nonatomic) BOOL enabled,revealed,blocked;
@property(nonatomic,strong) NSDictionary *options;
@property(nonatomic) NSUInteger revision;
@end
@implementation CSCloseFriendSnapshot @end
static CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) {
    CSCloseFriendSnapshot *policy=[CSCloseFriendSnapshot new];policy.accountID=account;return policy;
}
@interface ViewportShield : NSObject
- (void)finishTablePublication;
@end
@implementation ViewportShield
- (void)finishTablePublication {}
@end
static BOOL CSGroupIsFoldedController(id owner) { (void)owner; return NO; }
static BOOL CSGroupPrivacyActive(void) { return NO; }
static id CSGroupReadObject(id object,NSString *name) { return [object valueForKey:name]; }
static long long CSGroupReadInteger(id object,NSString *name,long long fallback) {
    return object ? [[object valueForKey:name] longLongValue] : fallback;
}
static void CSGroupWithDisplayIndices(id table,void (^body)(void)) { (void)table; body(); }

@interface CSGroupListAdapter : NSObject
CS_GROUP_REFRESH_TEST_PROPERTIES
@property(nonatomic) NSUInteger modelRevision,snapshotRevision,refreshGeneration,snapshotRetryGeneration;
@property(nonatomic) BOOL coalescingNotification,scheduledCoalesced;
@property(nonatomic,copy) NSString *snapshotAccount;
@property(nonatomic,strong) NSArray *cachedNativeSections;
@property(nonatomic,copy) NSString *nativeActionsAccount;
@property(nonatomic) BOOL presentationSuspended,privacyRefreshPending;
@property(nonatomic,weak) UITableView *table;
@property(nonatomic,weak) HostController *controller;
@property(nonatomic,strong) CSGroupPreferences *preferences;
@property(nonatomic,strong) CSGroupProjection *projection;
@property(nonatomic,strong) NSMutableDictionary *proxies,*anchors;
@property(nonatomic,copy) NSDictionary *presentationViewport;
@property(nonatomic,copy) NSDictionary *neutralViewport;
@property(nonatomic) BOOL finishingNeutralPublication;
@property(nonatomic,strong) ViewportShield *privacyShield;
@property(nonatomic,strong) NSMutableArray *completions,*nativeActions;
@property(nonatomic,strong) NSMutableSet *prefetchedPaths;
@property(nonatomic,strong) id nativeHeader;
@property(nonatomic) CGFloat baselineDeceleration;
@property(nonatomic) BOOL dirty,searching,publishedEnabled,scheduled,publishing,groupPanMoving;
@property(nonatomic) BOOL active,pendingScrollToTop,chromeVisible,swipeActive,nativePresentation,snapshotRetryAttempted;
@property(nonatomic,readonly) BOOL projecting;
@property(nonatomic,strong) NSArray *displayedTabs;
@property(nonatomic,strong) TestChrome *chrome;
@property(nonatomic) NSUInteger changeDepth,refreshCount,layoutCount,detachCount,nativeMenuState;
@property(nonatomic,copy) NSString *publishedTabID;
@property(nonatomic) BOOL publishesViewport;
@property(nonatomic,copy) void (^publicationMutation)(void);
- (BOOL)isActive;
+ (instancetype)adapterForController:(id)controller;
+ (void)attachToController:(id)controller;
+ (void)setPresentationSuspended:(BOOL)suspended forController:(id)controller;
+ (void)finishPresentationReturnForController:(id)controller;
+ (void)refreshFoldedListsForAccount:(NSString *)accountID;
- (void)refresh;
- (void)layout;
- (void)detach;
- (void)saveAnchor;
- (void)restoreAnchor;
- (NSNumber *)presentationScrollHeight;
- (void)restoreScrollHeight:(CGFloat)height;
- (void)restoreViewportFromTab:(NSString *)previousTab scrollHeight:(CGFloat)height;
- (void)requestRefresh;
- (void)applyPendingScrollToTop;
- (void)returnToGroupTop;
- (void)selectIndex:(NSInteger)index;
- (void)finishNeutralPublication:(BOOL)completed;
@end
@implementation CSGroupListAdapter
// Badge source lifecycle is exercised in GroupLifecycleTests.
- (void)requestTabBadgeSourceRefresh {}
+ (void)refreshFoldedListsForAccount:(NSString *)accountID { (void)accountID; }
- (void)invalidateNativeSnapshot { self.modelRevision++; }
- (void)pruneNativeActions {}
- (void)finishSuspendedBatches {}
- (void)recordRefreshEvent:(NSString *)event delay:(NSTimeInterval)delay { (void)event; (void)delay; }
#include "GroupViewportBodies.h"
- (BOOL)isActive { return self.active; }
- (BOOL)projecting { return self.active; }
// Neutral publication is exercised by GroupNeutralScrollTests, not this
// viewport-only fixture, whose inputs never install a privacy render mask.
- (void)finishNeutralPublication:(BOOL)completed { (void)completed; }
- (void)refreshNavigationTitle {}
- (void)refresh {
    // Capture and restore calls are extracted from the actual refresh method.
#include "GroupViewportCapture.h"
    BOOL changed=NO; // This fixture publishes within its current account.
    if (self.publishesViewport) [self saveAnchor];
    self.refreshCount++; self.dirty=NO;
    if (!self.publishesViewport || !self.preferences) self.preferences=[CSGroupPreferences new];
    self.preferences.accountID=account;
    self.publishedEnabled=enabled; self.searching=self.controller.isSearching;
    if (self.publishesViewport && self.preferences.selectedTabID.length) self.publishedTabID=self.preferences.selectedTabID;
    if (self.publicationMutation) self.publicationMutation();
    if (self.publishesViewport) {
#include "GroupViewportRestore.h"
    }
}
- (void)layout { self.layoutCount++; }
- (void)detach { self.detachCount++; objc_setAssociatedObject(self.table,&AdapterKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
@end
static CSGroupListAdapter *Adapter(id owner) { return [CSGroupListAdapter adapterForController:owner]; }
static void Native(id owner,BOOL change,void (^body)(void)) { (void)owner; (void)change; body(); }
@implementation HostController
- (void)nativeAppearance:(BOOL)animated {
    (void)animated; self.nativeAppearanceCalls++;
    if (self.nativeAppearanceMutation) self.nativeAppearanceMutation();
}
#include "GroupViewportHooks.h"
@end

static NSUInteger checks,failures;
static void Check(BOOL condition,NSString *message) {
    checks++;
    if (!condition) { failures++; fprintf(stderr,"FAIL: %s\n",message.UTF8String); }
}
static BOOL Near(CGFloat a,CGFloat b) { return fabs(a-b)<0.001; }
static CSGroupListAdapter *List(HostController **owner,CGFloat height) {
    HostController *host=[HostController new]; host.m_tableView=[UITableView new];
    [CSGroupListAdapter attachToController:host];
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForController:host];
    a.active=YES; a.chromeVisible=YES; a.publishedTabID=@"private";
    a.preferences.selectedTabID=a.publishedTabID;
    a.table.bounds=CGRectMake(0,0,320,700);
    a.table.contentSize=CGSizeMake(320,height);
    a.table.adjustedContentInset=(UIEdgeInsets){100,0,30,0};
    a.table.contentOffset=CGPointMake(7,-20);
    a.projection=[CSGroupProjection new];
    CSGroupRow *row=[CSGroupRow new]; row.userName=@"fixture-row";
    a.projection.sections=@[@[row]];
    NSIndexPath *path=[NSIndexPath indexPathForRow:0 inSection:0];
    a.table.indexPathsForVisibleRows=@[path]; a.table.rowOrigins=@{path:@60};
    *owner=host; return a;
}
static void Drain(CSGroupListAdapter *a) {
    NSDate *deadline=[NSDate dateWithTimeIntervalSinceNow:1];
    while (a.scheduled && deadline.timeIntervalSinceNow>0)
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.002]];
    Check(!a.scheduled,@"queued refresh completed");
}
int main(void) { @autoreleasepool {
    HostController *host=nil;
    CSGroupListAdapter *a=List(&host,240);
    Check(a.refreshCount==1,@"first attachment initializes the projection once");
    for (NSUInteger i=0;i<8;i++) [CSGroupListAdapter attachToController:host];
    Check(a.refreshCount==1,@"repeated will/did appear without changes does not reload");
    Check(a.layoutCount==9,@"appearance still reconciles header layout");
    Check(a.table.offsetWrites==0,@"appearance does not force a scroll");
    NSUInteger before=a.refreshCount;
    a.dirty=YES; [CSGroupListAdapter attachToController:host];
    Check(a.refreshCount==before+1,@"pending native changes still publish on appearance");
    before=a.refreshCount; enabled=NO; [CSGroupListAdapter attachToController:host];
    Check(!a.publishedEnabled && a.refreshCount==before+1,@"disabling grouping still refreshes");
    before=a.refreshCount; enabled=YES; [CSGroupListAdapter attachToController:host];
    Check(a.publishedEnabled && a.refreshCount==before+1,@"enabling grouping still refreshes");
    before=a.refreshCount; host.isSearching=YES; [CSGroupListAdapter attachToController:host];
    Check(a.searching && a.refreshCount==before+1,@"native search activation is observed");
    before=a.refreshCount; host.isSearching=NO; [CSGroupListAdapter attachToController:host];
    Check(!a.searching && a.refreshCount==before+1,@"search cancellation is observed");
    before=a.refreshCount; account=@"other-test-account"; [CSGroupListAdapter attachToController:host];
    Check([a.preferences.accountID isEqual:account] && a.refreshCount==before+1,@"account switch refreshes");
    before=a.refreshCount; account=nil; [CSGroupListAdapter attachToController:host];
    [CSGroupListAdapter attachToController:host];
    Check(a.refreshCount==before+1,@"logged-out nil account does not reload on every appearance");
    account=@"test-account";
    CSGroupListAdapter *old=a;
    host.m_tableView=[UITableView new]; [CSGroupListAdapter attachToController:host];
    a=[CSGroupListAdapter adapterForController:host];
    Check(a!=old && old.detachCount==1 && a.refreshCount==1,@"replaced main table is detached and initialized");
    [a requestRefresh]; [CSGroupListAdapter attachToController:host];
    NSUInteger published=a.refreshCount; Drain(a);
    Check(a.refreshCount==published,@"queued request consumed by appearance does not reload again");
    [a requestRefresh]; [a requestRefresh]; published=a.refreshCount; Drain(a);
    Check(a.refreshCount==published+1,@"multiple pending updates publish once");

    // Execute actual Hook callbacks: returning from chat preserves native scroll.
    for (NSNumber *height in @[@0,@160,@320,@570,@1600]) {
        a=List(&host,height.doubleValue); a.publishesViewport=YES;
        CGFloat originalY=height.doubleValue>570 ? 340 : -100;
        a.table.contentOffset=CGPointMake(7,originalY); [a saveAnchor];
        NSUInteger refreshes=a.refreshCount;
        [host viewWillDisappear:YES]; [host viewDidDisappear:YES];
        Check(a.presentationSuspended && a.table.offsetWrites==0,@"pushing chat suspends projection without scrolling the retained list");
        [host viewWillAppear:YES]; [host viewDidAppear:YES];
        Check(host.nativeAppearanceCalls==4 && !a.presentationSuspended,@"complete push/pop executes all four real appearance Hooks");
        Check(a.refreshCount==refreshes+1,@"return publishes suspended changes once across will/did appear");
        Check(Near(a.table.contentOffset.y,originalY) && Near(a.table.contentOffset.x,7) && a.table.offsetWrites==0,
              @"complete chat push/pop preserves long, short and empty list position");
        Check(!a.pendingScrollToTop && !a.presentationViewport,@"completed chat return clears its temporary height record without requesting top");
        [a requestRefresh]; Drain(a);
        Check(Near(a.table.contentOffset.y,originalY) && a.table.offsetWrites==0,
              @"data refresh after chat return preserves the retained list position");
    }
    a=List(&host,1600); a.publishesViewport=YES;
    a.table.contentOffset=CGPointMake(7,400); [a saveAnchor];
    [host viewWillDisappear:YES];
    NSDictionary *departureViewport=a.presentationViewport;
    Check(Near([departureViewport[@"height"] doubleValue],500),@"leaving chat list captures absolute height 500 before native disappearance");
    a.table.contentOffset=CGPointMake(7,700); [host viewDidDisappear:YES];
    Check([a.presentationViewport isEqual:departureViewport],@"repeated disappearance never replaces the original departure height");
    NSIndexPath *chatPath=[NSIndexPath indexPathForRow:0 inSection:0];
    a.table.rowOrigins=@{chatPath:@860}; // Same row moved while chat was open.
    __weak UITableView *chatTable=a.table;
    host.nativeAppearanceMutation=^{
        chatTable.adjustedContentInset=(UIEdgeInsets){140,0,30,0};
        chatTable.contentOffset=CGPointMake(7,-25);
    };
    [host viewWillAppear:YES];
    Check(Near(a.table.contentOffset.y,360) && Near(a.table.contentOffset.y+a.table.adjustedContentInset.top,500),
          @"chat willAppear preserves departure height despite reordered rows and native inset/offset changes");
    [host viewDidAppear:YES]; host.nativeAppearanceMutation=nil;
    Check(Near(a.table.contentOffset.y,360) && Near(a.table.contentOffset.x,7) && !a.presentationViewport,
          @"chat didAppear corrects the native offset again and consumes the departure record");
    a.table.rowOrigins=@{chatPath:@960}; [a restoreAnchor];
    Check(Near(a.table.contentOffset.y,460),@"ordinary same-group updates resume row-anchor behavior after chat return finishes");
    for (NSNumber *height in @[@0,@160,@570,@900]) {
        a=List(&host,1600); a.publishesViewport=YES; a.table.contentOffset=CGPointMake(7,700);
        [host viewWillDisappear:YES]; [host viewDidDisappear:YES];
        a.table.contentSize=CGSizeMake(320,height.doubleValue);
        [host viewWillAppear:YES]; [host viewDidAppear:YES];
        CGFloat returnY=MAX(-100,height.doubleValue-700+30);
        Check(Near(a.table.contentOffset.y,returnY) && !a.presentationViewport,
              @"chat return clamps saved height to shortened, short or empty content and clears the record");
        [a requestRefresh]; Drain(a);
        Check(Near(a.table.contentOffset.y,returnY),@"refresh after a clamped chat return keeps the actual returned height");
    }
    for (NSNumber *changeAccount in @[@YES,@NO]) {
        a=List(&host,1600); a.table.contentOffset=CGPointMake(7,400); [host viewWillDisappear:YES];
        if (changeAccount.boolValue) account=@"different-account"; else accountEpoch++;
        Check(![a presentationScrollHeight] && !a.presentationViewport,@"account or privacy epoch change discards a stale chat return height");
        account=@"test-account"; accountEpoch=1;
    }
    a=List(&host,1600); a.publishesViewport=YES;
    a.table.contentOffset=CGPointMake(7,340); [a saveAnchor];
    NSDictionary *returnAnchor=a.anchors[a.publishedTabID];
    [host viewWillDisappear:YES]; // Cancelled push never reaches didDisappear.
    [host viewWillAppear:YES]; [host viewDidAppear:YES];
    Check(host.nativeAppearanceCalls==3 && Near(a.table.contentOffset.y,340) && !a.table.offsetWrites,
          @"cancelled chat push preserves the visible list position");
    NSUInteger appearanceRefreshes=a.refreshCount;
    [host viewWillAppear:NO]; [host viewDidAppear:NO];
    [host viewWillAppear:NO]; [host viewDidAppear:NO];
    Check(a.refreshCount==appearanceRefreshes && !a.table.offsetWrites && Near(a.table.contentOffset.y,340),
          @"duplicate appearance neither republishes a clean list nor scrolls it");
    Check([a.anchors[a.publishedTabID] isEqual:returnAnchor],@"cancelled and duplicate appearance retain the original anchor");
    __weak UITableView *returnTable=a.table;
    NSIndexPath *returnPath=[NSIndexPath indexPathForRow:0 inSection:0];
    a.publicationMutation=^{ returnTable.rowOrigins=@{returnPath:@260}; };
    [a requestRefresh]; Drain(a); a.publicationMutation=nil;
    Check(Near(a.table.contentOffset.y,540) && [a.anchors[a.publishedTabID] isEqual:returnAnchor],
          @"refresh after return keeps the original row anchor when preceding rows change height");

    // Anchor helpers alone also preserve short lists' native offset.
    for (NSNumber *height in @[@0,@160,@320,@570]) {
        a=List(&host,height.doubleValue);
        a.anchors[a.publishedTabID]=@{@"name":@"fixture-row",@"kind":@0,@"offset":@(-80)};
        [a restoreAnchor];
        Check(Near(a.table.contentOffset.y,-20) && a.table.offsetWrites==0,@"short/empty/exact-fit list preserves the native offset");
        [a saveAnchor];
        Check(!a.anchors[a.publishedTabID],@"short list does not retain a stale row anchor");
    }
    a=List(&host,1600); [a saveAnchor];
    [a restoreAnchor];
    Check(a.table.offsetWrites==0,@"unchanged long-list anchor avoids redundant scroll callbacks");
    a.table.adjustedContentInset=(UIEdgeInsets){140,0,30,0};
    [a restoreAnchor];
    Check(Near(a.table.contentOffset.y,-60),@"navigation inset change preserves the row relative to the visible top");
    Check(Near(a.table.contentOffset.x,7),@"anchor restoration preserves horizontal offset");
    NSIndexPath *path=[NSIndexPath indexPathForRow:0 inSection:0];
    a.table.rowOrigins=@{path:@260}; [a restoreAnchor];
    Check(Near(a.table.contentOffset.y,140),@"long-list row movement restores the same visual anchor");
    a.table.rowOrigins=@{path:@5000}; [a restoreAnchor];
    Check(Near(a.table.contentOffset.y,930),@"long-list anchor clamps at the bottom");
    a.table.rowOrigins=@{path:@(-500)}; [a restoreAnchor];
    Check(Near(a.table.contentOffset.y,-140),@"long-list anchor clamps at the top");
    for (NSString *state in @[@"tracking",@"dragging",@"decelerating"]) {
        a=List(&host,1600); [a saveAnchor];
        [a.table setValue:@YES forKey:state];
        a.table.rowOrigins=@{path:@260}; [a restoreAnchor];
        Check(a.table.offsetWrites==0,@"touch/drag/deceleration stays under native control");
    }
    a=List(&host,1600); [a saveAnchor];
    NSDictionary *saved=a.anchors[a.publishedTabID];
    a.table.contentOffset=CGPointMake(7,-180); [a saveAnchor]; [a restoreAnchor];
    Check(a.table.offsetWrites==0 && [a.anchors[a.publishedTabID] isEqual:saved],@"pull-down bounce is neither captured nor overwritten");
    a.table.contentOffset=CGPointMake(7,-20); a.searching=YES; [a restoreAnchor];
    Check(a.table.offsetWrites==0,@"search transition does not restore a list anchor");
    a.searching=NO; a.table.bounds=CGRectZero; [a restoreAnchor];
    Check(a.table.offsetWrites==0,@"unlaid-out table does not restore an anchor");
    a=List(&host,1600); [a saveAnchor]; a.projection.sections=@[@[]]; [a restoreAnchor];
    Check(a.table.offsetWrites==0,@"deleted anchor leaves the host position intact");
    a=List(&host,1600); [a saveAnchor]; a.publishedTabID=@"group-without-anchor"; [a restoreAnchor];
    Check(a.table.offsetWrites==0,@"new group without an anchor leaves layout to the host");
    a=List(&host,1600); [a saveAnchor]; a.table.contentSize=CGSizeMake(320,NAN); [a restoreAnchor];
    Check(a.table.offsetWrites==0,@"nonfinite content geometry does not write an offset");
    for (NSNumber *height in @[@0,@160,@1600]) {
        a=List(&host,height.doubleValue); [a saveAnchor];
        [a returnToGroupTop];
        Check(Near(a.table.contentOffset.y,-100) && !a.pendingScrollToTop,@"explicit top request reaches the full header top for empty, short and long lists");
        Check(!a.anchors[a.publishedTabID],@"explicit top request clears the old per-group anchor");
        [a saveAnchor]; [a restoreAnchor];
        Check(Near(a.table.contentOffset.y,-100),@"later data refresh cannot restore the position before an explicit top request");
    }
    a=List(&host,1600); [a saveAnchor]; a.pendingScrollToTop=YES;
    a.table.contentOffset=CGPointMake(7,340); [a saveAnchor]; [a restoreAnchor];
    Check(Near(a.table.contentOffset.y,-100),@"pending top overrides an old group anchor");
    a=List(&host,1600); a.dirty=YES; [a returnToGroupTop];
    Check(a.pendingScrollToTop && a.table.offsetWrites==0,@"top waits until pending data is published");
    a.dirty=NO; a.publishing=YES; [a applyPendingScrollToTop];
    Check(a.pendingScrollToTop && a.table.offsetWrites==0,@"top waits for reload/layout completion");
    a.publishing=NO; a.table.adjustedContentInset=(UIEdgeInsets){147,0,30,0}; [a applyPendingScrollToTop];
    Check(Near(a.table.contentOffset.y,-147),@"top uses the final adjusted inset without modifying inset");
    a.table.contentOffset=CGPointMake(7,350); [a applyPendingScrollToTop];
    Check(Near(a.table.contentOffset.y,350),@"one-time top request does not pin subsequent user scrolling");
    for (NSString *state in @[@"tracking",@"dragging",@"decelerating",@"editing"]) {
        a=List(&host,1600); [a.table setValue:@YES forKey:state]; [a returnToGroupTop];
        Check(a.pendingScrollToTop && a.table.offsetWrites==0,@"explicit top request defers while the user is interacting");
        [a.table setValue:@NO forKey:state]; [a restoreAnchor];
        Check(Near(a.table.contentOffset.y,-100),@"deferred top completes when interaction ends");
    }
    a=List(&host,1600); a.searching=YES; [a returnToGroupTop];
    Check(!a.pendingScrollToTop && a.table.offsetWrites==0,@"native search appearance does not reset the chat viewport");
    a=List(&host,1600); enabled=NO; [a returnToGroupTop];
    Check(!a.pendingScrollToTop && a.table.offsetWrites==0,@"disabled groups do not force native list scrolling"); enabled=YES;
    a=List(&host,1600); a.publishesViewport=YES;
    WESessionTabItem *firstTab=[WESessionTabItem new]; firstTab.tabId=@"private";
    WESessionTabItem *tab=[WESessionTabItem new]; tab.tabId=@"another";
    WESessionTabItem *thirdTab=[WESessionTabItem new]; thirdTab.tabId=@"third";
    a.displayedTabs=@[firstTab,tab,thirdTab]; a.preferences.tabs=a.displayedTabs;
    a.table.contentOffset=CGPointMake(7,400); // Height from effective top is 500.
    NSDictionary *destinationAnchor=@{@"name":@"fixture-row",@"kind":@0,@"offset":@400};
    a.anchors[@"another"]=destinationAnchor;
    a.presentationViewport=@{@"height":@999,@"account":account,@"epoch":@(accountEpoch)};
    [a.nativeActions addObject:^{ }];
    [a selectIndex:1];
    Check(a.nativeActions.count==0 && !a.presentationViewport,@"new group selection supersedes older queued native navigation and return-height records");
    Check(!a.pendingScrollToTop && ![a.anchors[@"another"] isEqual:destinationAnchor],@"switching groups ignores the destination's old anchor without requesting top");
    Check([a.publishedTabID isEqual:@"another"] && Near(a.table.contentOffset.y+100,500),@"A at height 500 switches to B at height 500");
    Check(Near([a.anchors[@"another"][@"offset"] doubleValue],440),@"destination anchor is replaced with the newly shared height");
    a.table.contentOffset=CGPointMake(7,700); [a selectIndex:2];
    Check([a.publishedTabID isEqual:@"third"] && Near(a.table.contentOffset.y+100,800),@"B scrolled to height 800 switches to C at height 800");
    [a selectIndex:0];
    Check(Near(a.table.contentOffset.y+100,800),@"returning to A keeps current height 800 instead of A's historical height");
    __weak UITableView *sharedTable=a.table;
    a.publicationMutation=^{ sharedTable.rowOrigins=@{path:@260}; };
    [a selectIndex:1]; a.publicationMutation=nil;
    Check(Near(a.table.contentOffset.y+100,800) && Near([a.anchors[@"another"][@"offset"] doubleValue],540),
          @"different group row heights preserve the same absolute scroll height");
    NSUInteger selectionWrites=a.table.offsetWrites;
    [a selectIndex:1];
    Check(Near(a.table.contentOffset.y+100,800) && a.table.offsetWrites==selectionWrites,@"reselecting the current group does not scroll");
    a.publicationMutation=^{ sharedTable.rowOrigins=@{path:@360}; };
    [a requestRefresh]; Drain(a); a.publicationMutation=nil;
    Check(Near(a.table.contentOffset.y,800),@"same-group message refresh still follows its visible row anchor");
    a.table.tracking=YES; [a returnToGroupTop]; a.table.tracking=NO;
    [a selectIndex:2];
    Check(!a.pendingScrollToTop && Near(a.table.contentOffset.y+100,900),@"new selection cancels an older pending top and carries the current height");
    a.publicationMutation=^{ sharedTable.adjustedContentInset=(UIEdgeInsets){140,0,30,0}; };
    [a selectIndex:0]; a.publicationMutation=nil;
    Check(Near(a.table.contentOffset.y,760) && Near(a.table.contentOffset.y+a.table.adjustedContentInset.top,900) && Near(a.table.contentOffset.x,7),
          @"group inset changes normalize shared height and preserve horizontal offset");
    for (NSNumber *height in @[@0,@160,@570,@900]) {
        a=List(&host,1600); a.publishesViewport=YES;
        a.displayedTabs=@[firstTab,tab,thirdTab]; a.preferences.tabs=a.displayedTabs;
        a.table.contentOffset=CGPointMake(7,700);
        __weak UITableView *clampedTable=a.table;
        a.publicationMutation=^{ clampedTable.contentSize=CGSizeMake(320,height.doubleValue); };
        [a selectIndex:1];
        CGFloat clampedY=MAX(-100,height.doubleValue-700+30);
        Check([a.publishedTabID isEqual:@"another"] && !a.pendingScrollToTop && Near(a.table.contentOffset.y,clampedY),
              @"shorter, short and empty destination groups clamp shared height to their real scroll range");
        a.publicationMutation=^{ clampedTable.contentSize=CGSizeMake(320,1600); };
        [a selectIndex:2]; a.publicationMutation=nil;
        Check(Near(a.table.contentOffset.y,clampedY),@"the next group inherits actual clamped height instead of an older unclamped height");
    }
    a=List(&host,1600); a.publishesViewport=YES;
    a.presentationViewport=@{@"height":@999,@"account":account,@"epoch":@(accountEpoch)};
    a.table.tracking=YES; a.table.contentOffset=CGPointMake(7,340); [a returnToGroupTop];
    Check(a.pendingScrollToTop && !a.table.offsetWrites && !a.presentationViewport,@"explicit top request supersedes the return-height record and defers while tracking");
    [host viewWillDisappear:YES]; [host viewDidDisappear:YES];
    Check(a.pendingScrollToTop && !a.table.offsetWrites,@"suspension preserves an unfinished explicit top request");
    a.table.tracking=NO; [host viewWillAppear:YES]; [host viewDidAppear:YES];
    Check(!a.pendingScrollToTop && Near(a.table.contentOffset.y,-100) && a.table.offsetWrites==1,
          @"return completes a pre-existing explicit top request exactly once");
    a=List(&host,1600); a.nativeMenuState=3; [a returnToGroupTop];
    Check(a.pendingScrollToTop && !a.table.offsetWrites,@"custom menu motion defers return-to-top without UITableView flags");
    a.nativeMenuState=1; [a applyPendingScrollToTop];
    Check(a.pendingScrollToTop && !a.table.offsetWrites,@"stationary custom menu preserves viewport while open");
    a.nativeMenuState=0; [a applyPendingScrollToTop];
    Check(!a.pendingScrollToTop && Near(a.table.contentOffset.y,-100),@"top request completes after actual custom menu closes");
    a=List(&host,1600); a.displayedTabs=@[tab]; a.preferences.tabs=@[tab]; a.chrome=[TestChrome new];
    a.nativeMenuState=1; [a selectIndex:0];
    Check(!a.pendingScrollToTop && [a.chrome.selectedTabID isEqual:a.publishedTabID],@"custom menu open prevents tab selection and preserves published indicator");
    a=List(&host,1600); a.pendingScrollToTop=YES; a.groupPanMoving=YES;
    [a applyPendingScrollToTop];
    Check(a.pendingScrollToTop && !a.table.offsetWrites,@"independent group pan prevents top jump without native tracking flags");
    a.groupPanMoving=NO; [a applyPendingScrollToTop];
    Check(!a.pendingScrollToTop && a.table.offsetWrites==1,@"top completes once after group pan ends");
    fprintf(stdout,"Group viewport: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
    return failures ? 1 : 0;
} }
