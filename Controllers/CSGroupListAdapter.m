#import "CSGroupListAdapter.h"
#import "CSGroupProjection.h"
#import "CSGroupPreferences.h"
#import "CSGroupAppearance.h"
#import "CSGroupInvocationMapper.h"
#import "CSGroupNativeBridge.h"
#import "WESessionTabContainerView.h"
#import <objc/runtime.h>
#import <objc/message.h>

static char AdapterKey, CellRowKey, TitleContextKey, PresentationSuspendedKey;
static NSHashTable<CSGroupListAdapter *> *Adapters(void) {
    static NSHashTable *adapters; static dispatch_once_t once;
    dispatch_once(&once, ^{ adapters=[NSHashTable weakObjectsHashTable]; }); return adapters;
}
static BOOL Option(NSString *suffix) {
    return [NSUserDefaults.standardUserDefaults boolForKey:[@"com.wechat.enhance.chat_group." stringByAppendingString:suffix]];
}
static id ObjectArgument(id target, NSString *name, id value) {
    SEL selector=NSSelectorFromString(name);
    NSMethodSignature *signature=[target methodSignatureForSelector:selector];
    if (signature.numberOfArguments!=3 || signature.methodReturnType[0]!='@' || [signature getArgumentTypeAtIndex:2][0]!='@') return nil;
    return ((id(*)(id,SEL,id))objc_msgSend)(target,selector,value);
}
@class CSGroupTableProxy;
@interface CSGroupListAdapter () <UIGestureRecognizerDelegate>
@property (nonatomic, weak, readwrite) UITableView *table;
@property (nonatomic, weak) id controller;
@property (nonatomic, strong) CSGroupProjection *projection;
@property (nonatomic, strong) CSGroupPreferences *preferences;
@property (nonatomic, strong) WESessionTabContainerView *chrome;
@property (nonatomic, strong) UIView *headerContainer;
@property (nonatomic, strong) UIView *nativeHeader;
@property (nonatomic, readwrite) BOOL updatingHeader;
@property (nonatomic, strong) UIPanGestureRecognizer *pan;
@property (nonatomic, strong) UIPanGestureRecognizer *listPan;
@property (nonatomic) BOOL barTouchAllowed, listTouchAllowed, swipeActive;
@property (nonatomic, strong) CSGroupRow *swipeRow;
@property (nonatomic, copy) NSString *swipeAccount;
@property (nonatomic, copy) NSIndexPath *swipeDisplayPath;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *,CSGroupTableProxy *> *proxies;
@property (nonatomic, strong) NSMutableDictionary<NSString *,NSDictionary *> *anchors;
@property (nonatomic, strong) NSMutableArray *completions;
@property (nonatomic, copy) NSArray<WESessionTabItem *> *displayedTabs;
@property (nonatomic, copy) NSDictionary<NSString *,id> *identityDisplayPaths;
@property (nonatomic, copy) NSString *publishedTabID;
@property (nonatomic) BOOL projecting, chromeVisible;
@property (nonatomic) BOOL presentationSuspended;
@property (nonatomic) BOOL publishedEnabled;
@property (nonatomic, strong) NSMutableSet<NSIndexPath *> *prefetchedPaths;
@property (nonatomic, strong) NSMutableArray *nativeActions;
@property (nonatomic) BOOL nativePresentation, scheduled, dirty, searching, pendingScrollToTop;
@property (nonatomic) BOOL snapshotRetryAttempted;
@property (nonatomic) NSUInteger snapshotRetryGeneration;
@property (nonatomic, readwrite) BOOL publishing;
@property (atomic, readwrite) NSUInteger changeDepth;
@property (nonatomic) UIScrollViewDecelerationRate baselineDeceleration;
- (void)useNativePresentation;
- (void)forwardInvocation:(NSInvocation *)inv target:(id)target;
- (UITableViewCell *)cellForDisplayPath:(NSIndexPath *)path target:(id)target;
@end
@interface CSGroupTableProxy : NSObject
@property (nonatomic, weak) CSGroupListAdapter *adapter;
@property (nonatomic, weak) id target;
@end
@implementation CSGroupTableProxy
- (UITableViewCell *)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)path {
    (void)table; return [self.adapter cellForDisplayPath:path target:self.target];
}
- (BOOL)respondsToSelector:(SEL)selector {
    if ([super respondsToSelector:selector]) return YES;
    if (self.adapter.isActive && !CSGroupUsesNativeIndices(self.adapter.table) && !CSGroupInvocationIsSupported(selector)) return NO;
    return [self.target respondsToSelector:selector];
}
- (BOOL)conformsToProtocol:(Protocol *)protocol { return [self.target conformsToProtocol:protocol] || [super conformsToProtocol:protocol]; }
- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector { return [self.target methodSignatureForSelector:selector] ?: [super methodSignatureForSelector:selector]; }
- (void)forwardInvocation:(NSInvocation *)invocation { [self.adapter forwardInvocation:invocation target:self.target]; }
@end

@implementation CSGroupListAdapter
+ (instancetype)adapterForTable:(id)table { return objc_getAssociatedObject(table,&AdapterKey); }
+ (instancetype)adapterForController:(id)controller { return objc_getAssociatedObject(controller,&AdapterKey); }
+ (void)attachToController:(id)controller {
    // The native main-frame owner can expose curViewController instead of inheriting UIKit.
    // Attachment is authorized by its actual chat table, not an assumed superclass.
    if (!NSThread.isMainThread || !controller) return;
    id table=CSGroupReadObject(controller,@"m_tableView");
    if (![table isKindOfClass:UITableView.class]) return;
    CSGroupListAdapter *adapter=[self adapterForController:controller];
    if (adapter.table!=table) {
        if (adapter) [adapter detach];
        adapter=[self new]; adapter.controller=controller; adapter.table=table;
        adapter.presentationSuspended=[objc_getAssociatedObject(controller,&PresentationSuspendedKey) boolValue];
        adapter.proxies=[NSMutableDictionary dictionary]; adapter.anchors=[NSMutableDictionary dictionary]; adapter.completions=[NSMutableArray array]; adapter.prefetchedPaths=[NSMutableSet set]; adapter.nativeActions=[NSMutableArray array];
        adapter.nativeHeader=[table tableHeaderView]; adapter.baselineDeceleration=[table decelerationRate];
        objc_setAssociatedObject(controller,&AdapterKey,adapter,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(table,&AdapterKey,adapter,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [Adapters() addObject:adapter];
    }
    if (adapter.presentationSuspended) { adapter.dirty=YES; return; }
    // Appearance is not a data change. Repeated reload/anchor restoration here
    // competes with WeChat's own search/task-bar inset and offset restoration.
    NSString *account=CSGroupCurrentAccountID();
    BOOL sameAccount=adapter.preferences.accountID==account || [adapter.preferences.accountID isEqualToString:account];
    BOOL searching=CSGroupReadInteger(controller,@"isSearching",0)!=0;
    if (!adapter.preferences || adapter.dirty || !sameAccount ||
        adapter.publishedEnabled!=Option(@"enabled") || adapter.searching!=searching) [adapter refresh];
    [adapter layout];
}
// Visibility belongs to the native owner lifecycle, not table.window: a covered
// main list can remain attached while chat scrolling and keyboard layout run.
+ (void)setPresentationSuspended:(BOOL)suspended forController:(id)controller {
    if (!NSThread.isMainThread || !controller) return;
    objc_setAssociatedObject(controller,&PresentationSuspendedKey,@(suspended),OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    CSGroupListAdapter *adapter=[self adapterForController:controller];
    adapter.presentationSuspended=suspended;
    if (suspended) {
        adapter.dirty=YES;
        adapter.snapshotRetryAttempted=NO; adapter.snapshotRetryGeneration++;
        [adapter finishSuspendedBatches];
    }
}
- (void)finishSuspendedBatches {
    if (!self.presentationSuspended || self.changeDepth || self.publishing) return;
    // Native model updates have run, but their requested UI animation was
    // interrupted. Complete exactly once rather than retaining callbacks in chat.
    NSArray *callbacks=[self.completions copy]; [self.completions removeAllObjects];
    for (void (^completion)(BOOL) in callbacks) completion(NO);
}
+ (void)layoutForController:(id)controller {
    if (!NSThread.isMainThread || !controller) return;
    CSGroupListAdapter *adapter=[self adapterForController:controller];
    id table=CSGroupReadObject(controller,@"m_tableView");
    if (!adapter || adapter.table!=table) { [self attachToController:controller]; return; }
    [adapter layout];
}
+ (void)settingsChanged {
    dispatch_async(dispatch_get_main_queue(), ^{ for (CSGroupListAdapter *adapter in Adapters().allObjects) { [adapter refresh]; [adapter layout]; } });
}
- (BOOL)isActive {
    return self.projecting;
}
- (id)nativeSource { return self.proxies[@0].target; }
- (void)installProxies {
    UITableView *table=self.table; if (!table) return;
    table.dataSource=[self proxyForTarget:table.dataSource role:0];
    table.delegate=[self proxyForTarget:table.delegate role:1];
    table.prefetchDataSource=[self proxyForTarget:table.prefetchDataSource role:2];
}
- (id)proxyForTarget:(id)target role:(NSUInteger)role {
    if ([target isKindOfClass:CSGroupTableProxy.class]) return target;
    CSGroupTableProxy *proxy=self.proxies[@(role)];
    if (!target) { proxy.target=nil; return nil; }
    if (!proxy) { proxy=[CSGroupTableProxy new]; proxy.adapter=self; self.proxies[@(role)]=proxy; }
    proxy.target=target; return proxy;
}
- (void)detach {
    UITableView *table=self.table; self.nativePresentation=YES; self.projecting=NO; self.chromeVisible=NO;
    [self refreshNavigationTitle];
    self.presentationSuspended=YES;
    [self publishHeader:self.nativeHeader]; [self.chrome removeFromSuperview]; [self.chrome removeGestureRecognizer:self.pan]; [table removeGestureRecognizer:self.listPan];
    objc_setAssociatedObject(table,&AdapterKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (table.dataSource==self.proxies[@0]) table.dataSource=self.proxies[@0].target;
    if (table.delegate==self.proxies[@1]) table.delegate=self.proxies[@1].target;
    if (table.prefetchDataSource==self.proxies[@2]) table.prefetchDataSource=self.proxies[@2].target;
    table.decelerationRate=self.baselineDeceleration;
    for (void (^completion)(BOOL) in self.completions) completion(NO);
    [self.completions removeAllObjects];
    [self.nativeActions removeAllObjects];
}
- (void)ensureChrome {
    if (self.chrome) return;
    self.chrome=[WESessionTabContainerView new];
    __weak typeof(self) weakSelf=self;
    self.chrome.onTabSelected=^(NSInteger index) { [weakSelf selectIndex:index]; };
    self.chrome.onSearchButtonTapped=^{
        CSGroupListAdapter *self=weakSelf; if (!self) return;
        [self prepareForNativeSearch];
        CSGroupWithNativeIndices(self.table, ^{
            SEL search=NSSelectorFromString(@"onSearch");
            if ([self.controller respondsToSelector:search]) ((void(*)(id,SEL))objc_msgSend)(self.controller,search);
        });
        [self requestRefresh];
    };
    self.pan=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(groupPan:)];
    self.pan.delegate=self; self.pan.maximumNumberOfTouches=1; self.pan.cancelsTouchesInView=NO;
    [self.chrome addGestureRecognizer:self.pan];
    self.listPan=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(groupPan:)];
    self.listPan.delegate=self; self.listPan.maximumNumberOfTouches=1;
    // Once a row swipe belongs to grouping, cancel the row's pending tap.
    // Rejected right-zone touches never reach this recognizer.
    self.listPan.cancelsTouchesInView=YES;
    [self.table addGestureRecognizer:self.listPan];
}
- (UIView *)nativeTableHeaderView { return self.nativeHeader; }
- (void)setNativeTableHeaderView:(UIView *)header {
    if (header && header==self.headerContainer) return;
    if (self.nativeHeader!=header) {
        // WeChat may wrap the existing search view in a new composite header.
        if (!header || ![self.nativeHeader isDescendantOfView:header]) [self.nativeHeader removeFromSuperview];
    }
    self.nativeHeader=header;
    [self layout];
}
- (void)prepareForNativeSearch {
    if (!self.searching) [self saveAnchor];
    self.searching=YES; self.pendingScrollToTop=NO;
    [self refreshNavigationTitle];
    [self layout];
}
- (void)publishHeader:(UIView *)header {
    if (!self.table) return;
    self.updatingHeader=YES;
    @try { CSGroupWithDisplayIndices(self.table, ^{ self.table.tableHeaderView=header; }); }
    @finally { self.updatingHeader=NO; }
}
- (void)layout {
    UITableView *table=self.table; if (self.presentationSuspended || !table || self.updatingHeader) return;
    __block UIView *installed=nil;
    CSGroupWithDisplayIndices(table, ^{ installed=table.tableHeaderView; });
    BOOL visible=self.chromeVisible && !self.searching;
    if (!visible) {
        self.chrome.hidden=YES;
        self.pan.enabled=NO; self.listPan.enabled=NO;
        if (installed!=self.nativeHeader) [self publishHeader:self.nativeHeader];
        table.decelerationRate=self.baselineDeceleration; return;
    }
    [self ensureChrome];
    NSUserDefaults *defaults=NSUserDefaults.standardUserDefaults;
    [self.chrome applyAppearanceWithFontSize:CSGroupTabFontSize(defaults) showsSearchButton:CSGroupSearchButtonVisible(defaults)];
    if (!self.headerContainer) self.headerContainer=[UIView new];
    CGFloat width=CGRectGetWidth(table.bounds);
    CGFloat nativeHeight=MAX(0,CGRectGetHeight(self.nativeHeader.frame));
    CGFloat height=self.chrome.intrinsicContentSize.height;
    BOOL replacesNativeHeader=CSGroupSearchButtonVisible(defaults);
    CGFloat displayedNativeHeight=replacesNativeHeader ? 0 : nativeHeight;
    // The shortcut replaces the entire native search header, including decoration,
    // wrappers and padding. Keep its object and full height for native search/restore.
    if (replacesNativeHeader) [self.nativeHeader removeFromSuperview];
    else if (self.nativeHeader && self.nativeHeader.superview!=self.headerContainer) [self.headerContainer addSubview:self.nativeHeader];
    if (self.chrome.superview!=self.headerContainer) [self.headerContainer addSubview:self.chrome];
    self.nativeHeader.frame=CGRectMake(0,0,width,nativeHeight);
    self.chrome.frame=CGRectMake(0,displayedNativeHeight,width,height); self.chrome.hidden=NO;
    CGRect headerFrame=CGRectMake(0,0,width,displayedNativeHeight+height);
    BOOL resized=!CGRectEqualToRect(self.headerContainer.frame,headerFrame);
    self.headerContainer.frame=headerFrame;
    if (installed!=self.headerContainer || resized) [self publishHeader:self.headerContainer];
    NSInteger sensitivity=[NSUserDefaults.standardUserDefaults integerForKey:@"com.wechat.enhance.scroll_sensitivity"];
    table.decelerationRate=sensitivity==1 ? 0.998 : sensitivity==2 ? 0.9998 : sensitivity==3 ? 0.999 : self.baselineDeceleration;
    [self updateGroupGestureAvailability];
    [self applyPendingScrollToTop];
}
- (BOOL)groupPanMoving {
    return self.pan.state==UIGestureRecognizerStateBegan || self.pan.state==UIGestureRecognizerStateChanged ||
        self.listPan.state==UIGestureRecognizerStateBegan || self.listPan.state==UIGestureRecognizerStateChanged;
}
- (NSInteger)listZoneForTouch:(UITouch *)touch {
    CGPoint point=[touch locationInView:self.table];
    CGRect viewport=self.table.bounds;
    if (!CGRectContainsPoint(viewport,point)) return -1;
    return point.x>=CGRectGetMinX(viewport)+CGRectGetWidth(viewport)*0.85 ? 1 : 0;
}
- (BOOL)nativeMenuGesture:(UIGestureRecognizer *)gesture inCell:(UIView *)cell shouldReceiveTouch:(UITouch *)touch {
    if (![self groupSwipesAvailable] || gesture!=CSGroupReadObject(cell,@"_panGestureRecognizer")) return YES;
    // UIKit asks once at touch-down. Never reconsider using the translated row
    // frame or the finger's position after crossing the 85% boundary.
    return [self listZoneForTouch:touch]==1;
}
- (BOOL)closeMenusForGroupSwitch {
    if (![self nativeMenuState] && !self.swipeActive && !self.table.editing) return YES;
    [self beginNativeChange];
    @try {
        __block NSArray *cells=nil;
        CSGroupWithDisplayIndices(self.table, ^{ cells=self.table.visibleCells; });
        Class menuClass=NSClassFromString(@"MMBaseMultiMenuTableViewCell");
        SEL hide=NSSelectorFromString(@"setMenuOptionsViewHidden:animated:completionHandler:");
        for (UITableViewCell *cell in cells) {
            if (menuClass && [cell isKindOfClass:menuClass] && [cell respondsToSelector:hide])
                ((void(*)(id,SEL,BOOL,BOOL,id))objc_msgSend)(cell,hide,YES,NO,nil);
        }
        [self.table setEditing:NO animated:NO];
        [self endSwipeEditing];
    } @finally { [self endNativeChange]; }
    return ![self nativeMenuState] && !self.table.editing && !self.swipeActive;
}
- (NSUInteger)nativeMenuState {
    // WeChat's custom row menu is independent of UITableView.editing/tracking.
    // Bit 0 blocks publication; bit 1 needs a short wake-up while motion settles.
    if (!self.table || !self.chromeVisible || !Option(@"enabled") || self.searching) return 0;
    Class menuClass=NSClassFromString(@"MMBaseMultiMenuTableViewCell");
    if (!menuClass) return 0;
    __block NSArray *cells=nil;
    CSGroupWithDisplayIndices(self.table, ^{ cells=self.table.visibleCells; });
    NSUInteger state=0;
    for (UITableViewCell *cell in cells) {
        if (![cell isKindOfClass:menuClass]) continue;
        NSDictionary *delivery=objc_getAssociatedObject(cell,&CellRowKey);
        if (delivery && ![delivery[@"account"] isEqual:CSGroupCurrentAccountID()]) continue;
        CSGroupRow *row=delivery[@"row"];
        // A genuinely deleted row must not keep its stale menu alive forever.
        if (self.dirty && !self.changeDepth && row.userName.length && ![self currentPathForRow:row]) continue;
        id pan=CSGroupReadObject(cell,@"_panGestureRecognizer");
        BOOL moving=[pan isKindOfClass:UIGestureRecognizer.class] &&
            ([(UIGestureRecognizer *)pan state]==UIGestureRecognizerStateBegan || [(UIGestureRecognizer *)pan state]==UIGestureRecognizerStateChanged);
        Ivar hiding=class_getInstanceVariable(object_getClass(cell),"_inHideAnimation");
        if (hiding && strchr("Bc",ivar_getTypeEncoding(hiding)[0])) {
            unsigned char flag=0;
            memcpy(&flag,(const char *)(__bridge const void *)cell+ivar_getOffset(hiding),sizeof(flag));
            moving |= flag!=0;
        }
        if (moving) state|=3;
        else if (!CSGroupReadInteger(cell,@"isMenuHidden",1)) state|=1;
    }
    return state;
}
- (void)nativeMenuDidChange {
    if (self.presentationSuspended) return;
    [self updateGroupGestureAvailability];
    if (self.dirty || self.pendingScrollToTop) [self requestRefresh];
}
- (void)refresh {
    if (!NSThread.isMainThread) { [self requestRefresh]; return; }
    if (self.publishing) return;
    // Explicit native navigation is the only offscreen publication exception.
    // Ordinary message/unread/draft updates merely invalidate the cached list.
    if (self.presentationSuspended && !self.nativeActions.count) {
        self.dirty=YES; [self finishSuspendedBatches]; return;
    }
    // A horizontal row swipe starts tracking before UIKit reports editing or
    // dragging. Reloading in that window replaces the cell under the finger.
    if (!self.presentationSuspended && (self.table.tracking || [self groupPanMoving])) { [self requestRefresh]; return; }
    NSUInteger menuState=self.presentationSuspended ? 0 : [self nativeMenuState];
    if (menuState) {
        self.dirty=YES;
        if (menuState&2) [self requestRefresh];
        return;
    }
    if (!self.presentationSuspended) [self reconcileDeletedSwipeRow];
    if (self.changeDepth || (!self.presentationSuspended && (self.table.dragging || self.table.decelerating || self.table.editing || self.swipeActive))) { self.dirty=YES; return; }
    self.publishing=YES; self.dirty=NO;
    BOOL finished=NO;
    @try {
        [self saveAnchor];
        [self installProxies];
        NSString *account=CSGroupCurrentAccountID();
        BOOL changed= ![self.preferences.accountID isEqualToString:account];
        if (changed) { self.anchors=[NSMutableDictionary dictionary]; self.nativePresentation=NO; self.projection=nil; self.snapshotRetryAttempted=NO; }
        self.preferences=[[CSGroupPreferences alloc] initWithDefaults:NSUserDefaults.standardUserDefaults accountID:account];
        self.searching=CSGroupReadInteger(self.controller,@"isSearching",0)!=0;
        [self ensureChrome];
        NSArray *tabs=self.preferences.tabs; NSString *selected=self.preferences.selectedTabID;
        if (self.nativePresentation) {
            selected=@"preset_0";
            if (![tabs filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(WESessionTabItem *tab, NSDictionary *bindings) { (void)bindings; return [tab.tabId isEqual:selected]; }]].count)
                tabs=[@[[WESessionTabItem tabWithType:WETabTypeAll]] arrayByAddingObjectsFromArray:tabs];
        }
        __block NSArray *sections=nil;
        CSGroupWithNativeIndices(self.table, ^{ sections=CSGroupBuildNativeSections(self.controller,self.table,[self nativeSource]); });
        CSGroupProjection *projection=[self projectionForSections:sections tabs:tabs selectedTabID:selected accountID:account];
        self.projection=projection;
        NSMutableDictionary *identities=[NSMutableDictionary dictionary];
        [self.projection.sections enumerateObjectsUsingBlock:^(NSArray *rows, NSUInteger s, BOOL *stop) {
            (void)stop; [rows enumerateObjectsUsingBlock:^(CSGroupRow *row, NSUInteger r, BOOL *end) {
                (void)end; if (row.userName.length) identities[row.userName]=identities[row.userName] ? (id)NSNull.null : [NSIndexPath indexPathForRow:(NSInteger)r inSection:(NSInteger)s];
            }];
        }]; self.identityDisplayPaths=identities; self.displayedTabs=tabs;
        BOOL projecting=Option(@"enabled") && !self.searching && !self.nativePresentation && self.projection.isValid && account.length>0;
        if (projecting && self.prefetchedPaths.count) {
            id prefetch=self.proxies[@2].target;
            NSArray *paths=self.prefetchedPaths.allObjects;
            CSGroupWithNativeIndices(self.table, ^{ if ([prefetch respondsToSelector:@selector(tableView:cancelPrefetchingForRowsAtIndexPaths:)]) [prefetch tableView:self.table cancelPrefetchingForRowsAtIndexPaths:paths]; });
            [self.prefetchedPaths removeAllObjects];
        }
        self.projecting=projecting;
        self.chromeVisible=Option(@"enabled") && !self.searching && account.length>0;
        self.publishedEnabled=Option(@"enabled");
        self.publishedTabID=selected;
        self.chrome.selectedTabID=selected; [self.chrome updateTabs:tabs]; self.chrome.selectedTabID=selected;
        id logic=CSGroupReadObject(self.controller,@"m_mainFrameLogicController");
        [tabs enumerateObjectsUsingBlock:^(WESessionTabItem *tab, NSUInteger index, BOOL *stop) {
            (void)stop; CSGroupBadge *badge=[projection badgeForTabID:tab.tabId];
            NSInteger count=tab.type==WETabTypeAll ? (NSInteger)MAX(0,CSGroupReadInteger(logic,@"getTotalUnreadCount",(long long)badge.count)) : (NSInteger)MIN(badge.count,(NSUInteger)NSIntegerMax);
            BOOL hidden=Option(tab.type==WETabTypeAll ? @"hide_all_badge" : @"hide_group_badge");
            [self.chrome updateUnreadCount:hidden ? 0 : count hasRedDot:!hidden && badge.redDot forTabIndex:(NSInteger)index];
        }];
        [self layout];
        CSGroupWithDisplayIndices(self.table, ^{ [self.table reloadData]; [self.table layoutIfNeeded]; });
        [self restoreAnchor];
        [self refreshNavigationTitle];
        finished=YES;
    } @finally {
        self.publishing=NO;
        if (finished) [self applyPendingScrollToTop];
        NSArray *callbacks=[self.completions copy]; [self.completions removeAllObjects];
        for (void (^completion)(BOOL) in callbacks) completion(finished);
        if (finished && !self.isActive && !self.changeDepth) {
            NSArray *actions=[self.nativeActions copy]; [self.nativeActions removeAllObjects];
            for (void (^action)(void) in actions) CSGroupWithNativeIndices(self.table,action);
        }
        if (self.dirty) [self requestRefresh];
    }
}
- (CSGroupProjection *)projectionForSections:(NSArray *)sections tabs:(NSArray *)tabs selectedTabID:(NSString *)selected accountID:(NSString *)account {
    if (!account.length) return nil;
    CSGroupProjection *projection=sections ? [[CSGroupProjection alloc] initWithSections:sections tabs:tabs selectedTabID:selected
        filterDuplicates:self.preferences.filterDuplicates accountID:account] : nil;
    if (projection.isValid) { self.snapshotRetryAttempted=NO; self.snapshotRetryGeneration++; return projection; }
    // A partially rebuilt native snapshot must not permanently select All.
    // Publish a safe empty projection for the selected group, then retry once.
    // Never expose unfiltered rows under a filtered group's label.
    if (!self.snapshotRetryAttempted) {
        self.snapshotRetryAttempted=YES;
        NSUInteger generation=++self.snapshotRetryGeneration;
        __weak typeof(self) weakSelf=self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(0.05*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
            CSGroupListAdapter *self=weakSelf;
            if (self.snapshotRetryAttempted && self.snapshotRetryGeneration==generation && [account isEqual:CSGroupCurrentAccountID()]) [self requestRefresh];
        });
    }
    projection=[[CSGroupProjection alloc] initWithSections:@[] tabs:tabs selectedTabID:selected
        filterDuplicates:self.preferences.filterDuplicates accountID:account];
    return projection.isValid ? projection : nil;
}
- (void)requestRefresh {
    if (!NSThread.isMainThread) { dispatch_async(dispatch_get_main_queue(), ^{ [self requestRefresh]; }); return; }
    self.dirty=YES;
    if (self.presentationSuspended && !self.nativeActions.count) { [self finishSuspendedBatches]; return; }
    if (self.scheduled || self.changeDepth || self.publishing) return;
    self.scheduled=YES;
    __weak typeof(self) weakSelf=self;
    void (^publish)(void)=^{ CSGroupListAdapter *self=weakSelf; self.scheduled=NO; if (self.dirty) [self refresh]; };
    // A rejected/cancelled row swipe need not send scrollViewDidEndDragging.
    // Keep one pending wake-up until tracking ends; editing then owns deferral.
    if (!self.presentationSuspended && (self.table.tracking || [self groupPanMoving] || ([self nativeMenuState]&2)))
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(0.05*NSEC_PER_SEC)),dispatch_get_main_queue(),publish);
    else dispatch_async(dispatch_get_main_queue(),publish);
}
- (void)beginNativeChange {
    @synchronized (self) { if (!self.changeDepth && NSThread.isMainThread && !self.presentationSuspended) [self saveAnchor]; self.changeDepth++; }
}
- (void)endNativeChange {
    BOOL outer=NO; @synchronized (self) { if (self.changeDepth) self.changeDepth--; outer=self.changeDepth==0; }
    if (outer) [self requestRefresh];
}
- (void)performNativeBatch:(void (^)(void))updates completion:(void (^)(BOOL))completion {
    void (^callback)(BOOL)=[completion copy];
    [self beginNativeChange]; if (callback) [self.completions addObject:callback];
    @try { CSGroupWithNativeIndices(self.table, ^{ if (updates) updates(); }); }
    @catch (NSException *exception) {
        if (callback) { [self.completions removeObjectIdenticalTo:callback]; callback(NO); }
        @throw exception;
    }
    @finally { [self endNativeChange]; }
}
- (void)useNativePresentation {
    if (!self.isActive || self.swipeActive || self.table.editing || [self nativeMenuState]) return;
    [self saveAnchor]; self.nativePresentation=YES; [self.table setEditing:NO animated:NO]; [self refresh];
}
- (void)performInNativePresentation:(void (^)(void))action {
    NSString *account=CSGroupCurrentAccountID(); if (!account.length) return;
    void (^guarded)(void)=^{ if ([account isEqualToString:CSGroupCurrentAccountID()]) action(); };
    if (!self.isActive && !self.publishing && !self.changeDepth) { CSGroupWithNativeIndices(self.table,guarded); return; }
    [self.nativeActions addObject:[guarded copy]];
    if (self.presentationSuspended) {
        // Search/next-chat navigation can target the main list from another page.
        // Publish native coordinates once for that action, then remain suspended.
        self.nativePresentation=YES; [self refresh]; return;
    }
    if (self.swipeActive || self.table.editing || [self nativeMenuState]) {
        // Native navigation waits for the menu to close; do not discard its queued action.
        self.nativePresentation=YES; [self requestRefresh]; return;
    }
    [self useNativePresentation];
}
- (BOOL)accountMatches { return [self.projection.accountID isEqualToString:CSGroupCurrentAccountID()]; }
- (NSIndexPath *)currentPathForRow:(CSGroupRow *)row {
    if (!row || ![self accountMatches]) return nil;
    __block NSIndexPath *path=nil;
    CSGroupWithNativeIndices(self.table, ^{ path=CSGroupResolveNativeRowPath(self.controller,row,self.dirty); });
    return path;
}
- (NSIndexPath *)nativePath:(NSIndexPath *)displayPath {
    if (!displayPath) return nil;
    NSIndexPath *path=[self currentPathForRow:[self.projection rowAtDisplayPath:displayPath]];
    if (!path) [self requestRefresh]; return path;
}
- (NSIndexPath *)displayPath:(NSIndexPath *)nativePath {
    if (![nativePath isKindOfClass:NSIndexPath.class] || nativePath.length!=2 || ![self accountMatches]) return nil;
    id logic=CSGroupReadObject(self.controller,@"m_mainFrameLogicController");
    id session=ObjectArgument(logic,@"getSessionInfoAtIndexPath:",nativePath);
    NSString *name=CSGroupReadObject(session,@"m_nsUserName");
    if (name.length) {
        // The snapshot stores original positions; resolve current native positions by identity.
        id path=self.identityDisplayPaths[name]; return [path isKindOfClass:NSIndexPath.class] ? path : nil;
    }
    NSIndexPath *display=[self.projection displayPathForNativePath:nativePath];
    CSGroupRow *row=[self.projection rowAtDisplayPath:display];
    // A deferred refresh alone does not invalidate a banner. Revalidate in both
    // directions so native rect/cell queries keep addressing the displayed row.
    return [[self currentPathForRow:row] isEqual:nativePath] ? display : nil;
}
- (NSArray *)nativePaths:(NSArray *)displayPaths {
    NSMutableArray *out=[NSMutableArray array];
    for (NSIndexPath *path in displayPaths) { NSIndexPath *native=[self nativePath:path]; if (native) [out addObject:native]; }
    return [out copy];
}
- (NSInteger)nativeRowCount:(NSInteger)section {
    id source=[self nativeSource];
    return [source respondsToSelector:@selector(tableView:numberOfRowsInSection:)] ? [source tableView:self.table numberOfRowsInSection:section] : 0;
}
- (NSInteger)nativeSectionCount {
    id source=[self nativeSource]; return [source respondsToSelector:@selector(numberOfSectionsInTableView:)] ? [source numberOfSectionsInTableView:self.table] : 1;
}
- (NSDictionary *)captureNativeEditingContextAtPath:(NSIndexPath *)path {
    if (!self.table || !self.isActive || ![self accountMatches]) return nil;
    CSGroupRow *row=[self.projection rowAtDisplayPath:[self displayPath:path]];
    if (!row.userName.length) return nil;
    return @{@"row":row,@"account":self.projection.accountID};
}
- (BOOL)performNativeEditingContext:(NSDictionary *)context action:(void (^)(NSIndexPath *))action {
    if (!self.table || !NSThread.isMainThread || ![context[@"account"] isEqual:CSGroupCurrentAccountID()]) return NO;
    CSGroupRow *row=context[@"row"];
    if (![row isKindOfClass:CSGroupRow.class] || !row.userName.length) return NO;
    __block NSIndexPath *current=nil;
    CSGroupWithNativeIndices(self.table, ^{ current=CSGroupResolveNativeRowPath(self.controller,row,YES); });
    if (!current) { [self requestRefresh]; return NO; }
    // Private edit actions can arrive without the projected willBegin callback.
    // Retain the identity while UIKit still reports editing so a later native
    // deletion can release that state even if didEnd is never delivered.
    if (self.table.editing && !self.swipeRow) {
        self.swipeActive=YES; self.swipeRow=row; self.swipeAccount=context[@"account"];
        self.swipeDisplayPath=[self displayPath:current];
    }
    [self beginNativeChange];
    @try { CSGroupWithNativeIndices(self.table, ^{ action(current); }); }
    @finally { [self endNativeChange]; }
    return YES;
}
- (void)updateGroupGestureAvailability {
    // Editing/open menus do not transfer left-zone touches to the native menu.
    BOOL enabled=self.chromeVisible && !self.searching && Option(@"swipe_gesture_enabled");
    if (self.pan.enabled!=enabled) self.pan.enabled=enabled;
    if (self.listPan.enabled!=enabled) self.listPan.enabled=enabled;
}
- (void)endSwipeEditing {
    self.swipeActive=NO; self.swipeRow=nil; self.swipeAccount=nil; self.swipeDisplayPath=nil;
    // Closing a clean menu must restore group gestures without rebuilding cells.
    [self updateGroupGestureAvailability];
    if (self.dirty || self.pendingScrollToTop) [self requestRefresh];
}
- (void)reconcileDeletedSwipeRow {
    // A projected deletion suppresses UIKit's row removal. The native menu may
    // therefore never emit didEndEditing. Release it only after identity loss,
    // not merely because another message arrived while the menu was open.
    if (!self.swipeActive || !self.swipeRow || self.changeDepth) return;
    if ([self.swipeAccount isEqual:CSGroupCurrentAccountID()] && [self currentPathForRow:self.swipeRow]) return;
    [self endSwipeEditing];
    [self.table setEditing:NO animated:NO];
}
- (BOOL)forwardSwipeInvocation:(NSInvocation *)inv target:(id)target {
    NSString *name=NSStringFromSelector(inv.selector);
    BOOL begin=[name isEqual:@"tableView:willBeginEditingRowAtIndexPath:"];
    BOOL end=[name isEqual:@"tableView:didEndEditingRowAtIndexPath:"];
    BOOL commit=[name isEqual:@"tableView:commitEditingStyle:forRowAtIndexPath:"];
    if ((!begin && !end && !commit) || (!self.isActive && !self.swipeRow)) return NO;
    if (CSGroupUsesNativeIndices(self.table)) {
        if (!end) return NO;
        @try { [inv invokeWithTarget:target]; }
        @finally { [self endSwipeEditing]; }
        return YES;
    }
    NSUInteger slot=commit ? 4 : 3;
    __unsafe_unretained NSIndexPath *display=nil; [inv getArgument:&display atIndex:slot];
    CSGroupRow *row=self.swipeRow;
    BOOL sameAccount=!row || [self.swipeAccount isEqual:CSGroupCurrentAccountID()];
    if (begin || !row) row=[self.projection rowAtDisplayPath:display];
    NSIndexPath *native=sameAccount && row.userName.length ? [self currentPathForRow:row] : nil;
    // A commit must belong to the row whose swipe UI is open, even if native rows moved.
    if (commit && self.swipeRow && ![display isEqual:self.swipeDisplayPath]) native=nil;
    if (begin && native) {
        self.swipeActive=YES; self.swipeRow=row;
        self.swipeAccount=self.projection.accountID; self.swipeDisplayPath=display;
    }
    @try {
        if (native || (end && sameAccount)) {
            [inv setArgument:&native atIndex:slot]; [inv retainArguments];
            if (commit) [self beginNativeChange];
            @try { CSGroupWithNativeIndices(self.table, ^{ [inv invokeWithTarget:target]; }); }
            @finally { if (commit) [self endNativeChange]; }
        }
    } @finally {
        if (end) {
            [self endSwipeEditing];
        }
    }
    return YES;
}
- (UITableViewCell *)cellForDisplayPath:(NSIndexPath *)path target:(id)target {
    BOOL projected=self.isActive && !CSGroupUsesNativeIndices(self.table);
    CSGroupRow *row=projected ? [self.projection rowAtDisplayPath:path] : nil;
    NSIndexPath *native=projected ? [self currentPathForRow:row] : path;
    __block UITableViewCell *cell=nil;
    if (native && [target respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)])
        CSGroupWithNativeIndices(self.table, ^{ cell=[target tableView:self.table cellForRowAtIndexPath:native]; });
    if (!cell) {
        // Required data-source callbacks must return a cell even while an old identity disappears.
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.textLabel.text=@"正在更新会话…"; cell.userInteractionEnabled=NO; cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [self requestRefresh];
    }
    id delivery=row ? @{@"row":row,@"account":self.projection.accountID} : nil;
    objc_setAssociatedObject(cell,&CellRowKey,delivery,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return cell;
}
- (void)forwardInvocation:(NSInvocation *)inv target:(id)target {
    NSUInteger length=inv.methodSignature.methodReturnLength;
    if (length) { void *zero=calloc(1,length); [inv setReturnValue:zero]; free(zero); }
    if (!target) return;
    NSString *name=NSStringFromSelector(inv.selector);
    if ([self forwardSwipeInvocation:inv target:target]) return;
    BOOL cellLifecycle=[name isEqual:@"tableView:willDisplayCell:forRowAtIndexPath:"] || [name isEqual:@"tableView:didEndDisplayingCell:forRowAtIndexPath:"];
    CSGroupRow *cellRow=nil;
    if (cellLifecycle) {
        __unsafe_unretained UITableViewCell *cell=nil; [inv getArgument:&cell atIndex:3];
        NSDictionary *delivery=objc_getAssociatedObject(cell,&CellRowKey);
        if (delivery) {
            if (![delivery[@"account"] isEqual:CSGroupCurrentAccountID()]) return;
            cellRow=delivery[@"row"];
            if (!self.isActive || CSGroupUsesNativeIndices(self.table)) {
                if (!CSGroupMapInvocationPaths(inv, ^NSIndexPath *(NSIndexPath *path) { (void)path; return [self currentPathForRow:cellRow]; })) return;
                CSGroupWithNativeIndices(self.table, ^{ [inv invokeWithTarget:target]; }); return;
            }
        } else if (self.publishing && [name isEqual:@"tableView:didEndDisplayingCell:forRowAtIndexPath:"]) {
            // Cells delivered before activation were native and never carried projected coordinates.
            CSGroupWithNativeIndices(self.table, ^{ [inv invokeWithTarget:target]; }); return;
        }
    }
    BOOL prefetch=[name isEqual:@"tableView:prefetchRowsAtIndexPaths:"];
    BOOL cancelPrefetch=[name isEqual:@"tableView:cancelPrefetchingForRowsAtIndexPaths:"];
    if (prefetch || cancelPrefetch) {
        // Native prefetch cancellation captures positions. It stays disabled in projected lists.
        if (self.isActive) return;
        __unsafe_unretained NSArray *paths=nil; [inv getArgument:&paths atIndex:3];
        if (prefetch) [self.prefetchedPaths addObjectsFromArray:paths]; else [self.prefetchedPaths minusSet:[NSSet setWithArray:paths]];
    }
    if (!self.isActive || CSGroupUsesNativeIndices(self.table)) {
        CSGroupWithNativeIndices(self.table, ^{ [inv invokeWithTarget:target]; });
        if ((self.dirty || self.pendingScrollToTop) && ([name isEqual:@"scrollViewDidEndDecelerating:"] || [name isEqual:@"scrollViewDidEndDragging:willDecelerate:"] || [name isEqual:@"tableView:didEndEditingRowAtIndexPath:"])) [self requestRefresh];
        return;
    }
    if ([name isEqual:@"numberOfSectionsInTableView:"]) { NSInteger count=(NSInteger)self.projection.sections.count; [inv setReturnValue:&count]; return; }
    if ([name isEqual:@"tableView:numberOfRowsInSection:"]) {
        NSInteger section=0; [inv getArgument:&section atIndex:3];
        NSInteger count=section>=0 && section<(NSInteger)self.projection.sections.count ? (NSInteger)self.projection.sections[(NSUInteger)section].count : 0;
        [inv setReturnValue:&count]; return;
    }
    // Optional queries and unsupported coordinate/block callbacks do not express
    // a request to select All. Keep the initialized neutral return and selection.
    if (!CSGroupInvocationIsSupported(inv.selector) || [@[@"tableView:shouldShowMenuForRowAtIndexPath:",@"tableView:moveRowAtIndexPath:toIndexPath:",@"tableView:performAction:forRowAtIndexPath:withSender:"] containsObject:name]) return;
    __block CSGroupRow *deliveredRow=nil;
    BOOL mapped=CSGroupMapInvocationPaths(inv, ^NSIndexPath *(NSIndexPath *path) {
        deliveredRow=cellRow ?: [self.projection rowAtDisplayPath:path];
        BOOL action=[name containsString:@"didSelectRow"] || [name containsString:@"commitEditingStyle"] || [name containsString:@"moveRowAt"] || [name containsString:@"performAction:"];
        if (action && !deliveredRow.userName.length) return nil;
        return [self currentPathForRow:deliveredRow];
    });
    if (!mapped) {
        if ([name isEqual:@"tableView:heightForRowAtIndexPath:"] || [name isEqual:@"tableView:estimatedHeightForRowAtIndexPath:"]) {
            CGFloat height=44; [inv setReturnValue:&height]; [self requestRefresh];
        } else if (!cellLifecycle) [self requestRefresh];
        return;
    }
    CSGroupWithNativeIndices(self.table, ^{ [inv invokeWithTarget:target]; });
    if (CSGroupInvocationReturnsPath(inv.selector)) {
        __unsafe_unretained NSIndexPath *native=nil; [inv getReturnValue:&native];
        NSIndexPath *display=[self displayPath:native]; [inv setReturnValue:&display]; [inv retainArguments];
    }
    if ([name isEqual:@"scrollViewDidEndDecelerating:"] || [name isEqual:@"scrollViewDidEndDragging:willDecelerate:"] || [name isEqual:@"tableView:didEndEditingRowAtIndexPath:"]) {
        if (self.dirty || self.pendingScrollToTop) [self requestRefresh];
    }
}
- (BOOL)hasScrollableContent {
    UITableView *table=self.table;
    CGFloat viewport=CGRectGetHeight(table.bounds);
    CGFloat content=table.contentSize.height;
    UIEdgeInsets inset=table.adjustedContentInset;
    return viewport>0 && isfinite(viewport) && isfinite(content) &&
        isfinite(inset.top) && isfinite(inset.bottom) && content+inset.top+inset.bottom>viewport+0.5;
}
- (BOOL)canRestoreAnchor {
    UITableView *table=self.table;
    // Do not turn a pull-down/bounce or a native top-area transition into a
    // persistent row anchor. The host owns these positions, including short lists.
    return [self hasScrollableContent] && !self.searching && !table.tracking &&
        !table.dragging && !table.decelerating && isfinite(table.contentOffset.y) &&
        table.contentOffset.y>=-table.adjustedContentInset.top-0.5;
}
- (void)saveAnchor {
    if (self.presentationSuspended) return;
    if (self.pendingScrollToTop) return;
    if (!self.isActive || !self.publishedTabID) return;
    if (![self hasScrollableContent]) { [self.anchors removeObjectForKey:self.publishedTabID]; return; }
    if (![self canRestoreAnchor]) return;
    __block NSIndexPath *first=nil; __block CGRect rect=CGRectZero;
    CSGroupWithDisplayIndices(self.table, ^{ first=[self.table.indexPathsForVisibleRows sortedArrayUsingSelector:@selector(compare:)].firstObject; if (first) rect=[self.table rectForRowAtIndexPath:first]; });
    CSGroupRow *row=[self.projection rowAtDisplayPath:first];
    if (row.userName.length) self.anchors[self.publishedTabID]=@{@"name":row.userName,@"kind":@(row.kind),@"offset":@(self.table.contentOffset.y+self.table.adjustedContentInset.top-rect.origin.y)};
}
- (void)restoreAnchor {
    if (self.presentationSuspended) return;
    if (self.pendingScrollToTop) { [self applyPendingScrollToTop]; return; }
    NSDictionary *anchor=self.anchors[self.publishedTabID];
    if (!self.isActive || !anchor || ![self canRestoreAnchor]) return;
    for (NSUInteger s=0;s<self.projection.sections.count;s++) {
        NSArray *rows=self.projection.sections[s];
        for (NSUInteger r=0;r<rows.count;r++) { CSGroupRow *row=rows[r];
            if ([row.userName isEqual:anchor[@"name"]] && row.kind==[anchor[@"kind"] unsignedIntegerValue]) {
                NSIndexPath *path=[NSIndexPath indexPathForRow:(NSInteger)r inSection:(NSInteger)s];
                CSGroupWithDisplayIndices(self.table, ^{
                    // Keep the row relative to the unobscured viewport, not an
                    // absolute offset captured with an earlier navigation inset.
                    CGFloat y=[self.table rectForRowAtIndexPath:path].origin.y+[anchor[@"offset"] doubleValue]-self.table.adjustedContentInset.top;
                    CGFloat min=-self.table.adjustedContentInset.top;
                    CGFloat max=MAX(min,self.table.contentSize.height-self.table.bounds.size.height+self.table.adjustedContentInset.bottom);
                    CGFloat target=MIN(max,MAX(min,y));
                    if (isfinite(y) && fabs(target-self.table.contentOffset.y)>0.5)
                        [self.table setContentOffset:CGPointMake(self.table.contentOffset.x,target) animated:NO];
                }); return;
            }
        }
    }
}
- (void)selectIndex:(NSInteger)index {
    if (self.swipeActive || self.table.editing || [self nativeMenuState]) { self.chrome.selectedTabID=self.publishedTabID; return; }
    NSArray *tabs=self.displayedTabs; if (index<0 || index>=(NSInteger)tabs.count) return;
    if (![self.preferences.accountID isEqualToString:CSGroupCurrentAccountID()]) { [self requestRefresh]; return; }
    NSString *tabID=[tabs[(NSUInteger)index] tabId];
    BOOL belongs=[self.preferences.tabs filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(WESessionTabItem *tab, NSDictionary *bindings) { (void)bindings; return [tab.tabId isEqual:tabID]; }]].count>0;
    // A newer user selection supersedes any queued explicit native navigation.
    [self.nativeActions removeAllObjects];
    self.snapshotRetryAttempted=NO;
    self.nativePresentation=!belongs; if (belongs) self.preferences.selectedTabID=tabID;
    self.pendingScrollToTop=YES;
    [self.anchors removeObjectForKey:tabID];
    [self refresh];
}
- (void)returnToGroupTop {
    if (self.presentationSuspended) return;
    if (!Option(@"enabled") || !self.chromeVisible || self.searching) return;
    self.pendingScrollToTop=YES;
    if (self.publishedTabID) [self.anchors removeObjectForKey:self.publishedTabID];
    [self.table layoutIfNeeded];
    [self applyPendingScrollToTop];
    [self refreshNavigationTitle];
}
- (void)applyPendingScrollToTop {
    UITableView *table=self.table;
    if (self.presentationSuspended || !self.pendingScrollToTop || self.publishing || self.dirty || self.changeDepth || !self.chromeVisible ||
        self.searching || table.tracking || table.dragging || table.decelerating || table.editing || self.swipeActive || [self nativeMenuState]) return;
    CGFloat top=table.adjustedContentInset.top;
    if (CGRectGetHeight(table.bounds)<=0 || !isfinite(top)) return;
    self.pendingScrollToTop=NO;
    // Use UIKit's effective top, never the host's transformed contentInset getter.
    CSGroupWithDisplayIndices(table, ^{
        if (fabs(table.contentOffset.y+top)>0.5)
            [table setContentOffset:CGPointMake(table.contentOffset.x,-top) animated:NO];
    });
}
+ (NSString *)groupTitleForTitleView:(id)titleView {
    if (!titleView || !Option(@"enabled")) return nil;
    for (CSGroupListAdapter *adapter in Adapters().allObjects) {
        if (CSGroupReadObject(adapter.controller,@"m_titleView")!=titleView || !adapter.chromeVisible || adapter.searching ||
            ![adapter.preferences.accountID isEqual:CSGroupCurrentAccountID()]) continue;
        for (WESessionTabItem *tab in adapter.displayedTabs)
            if ([tab.tabId isEqual:adapter.publishedTabID]) return tab.displayName;
    }
    return nil;
}
+ (void)recordNativeTitle:(NSString *)title status:(unsigned int)status forTitleView:(id)titleView {
    objc_setAssociatedObject(titleView,&TitleContextKey,@{@"title":title ?: NSNull.null,@"status":@(status)},OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)refreshNavigationTitle {
    if (self.presentationSuspended) return;
    id titleView=CSGroupReadObject(self.controller,@"m_titleView");
    NSDictionary *before=objc_getAssociatedObject(titleView,&TitleContextKey);
    SEL selector=NSSelectorFromString(@"updateTitleView");
    if ([self.controller respondsToSelector:selector]) ((void(*)(id,SEL))objc_msgSend)(self.controller,selector);
    // Native updateTitleView may skip an unchanged "WeChat" title. Replaying its
    // last input still updates the group name, without changing its cached title
    // or inventing a status flag. The hook resolves the new group at render time.
    if (before && before==objc_getAssociatedObject(titleView,&TitleContextKey)) {
        SEL render=NSSelectorFromString(@"updateTitleView:title:");
        NSString *title=before[@"title"]==NSNull.null ? nil : before[@"title"];
        if ([titleView respondsToSelector:render])
            ((void(*)(id,SEL,unsigned int,id))objc_msgSend)(titleView,render,[before[@"status"] unsignedIntValue],title);
    }
}
- (BOOL)groupSwipesAvailable {
    return self.table && Option(@"enabled") && Option(@"swipe_gesture_enabled") && self.chromeVisible && !self.searching;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldReceiveTouch:(UITouch *)touch {
    BOOL allowed=NO;
    if (gesture==self.pan) self.barTouchAllowed=NO; else if (gesture==self.listPan) self.listTouchAllowed=NO;
    if ((gesture!=self.pan && gesture!=self.listPan) || ![self groupSwipesAvailable]) return NO;
    // Decide using the initial touch, before either recognizer can begin or cancel another.
    for (UIView *view=touch.view; view; view=view.superview) {
        if ([view isKindOfClass:UIControl.class] && gesture==self.pan && ![view isDescendantOfView:self.chrome.scrollView]) return NO;
        if (view==self.table || view==self.chrome) break;
    }
    if (gesture==self.listPan) {
        // Menu state never changes zone ownership; menu buttons still receive taps
        // unless a left-zone horizontal group pan actually begins.
        if ([self listZoneForTouch:touch]!=0) return NO;
        if (touch.view==self.chrome || [touch.view isDescendantOfView:self.headerContainer]) return NO;
        allowed=YES;
    } else if (self.chrome.scrollView.contentSize.width>self.chrome.scrollView.bounds.size.width) {
        allowed=!CGRectContainsPoint(self.chrome.scrollView.bounds,[touch locationInView:self.chrome.scrollView]);
    } else allowed=YES;
    if (gesture==self.pan) self.barTouchAllowed=allowed; else self.listTouchAllowed=allowed;
    return allowed;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)other {
    if (gesture!=self.listPan || other==gesture || other==self.pan || !self.listTouchAllowed || ![self groupSwipesAvailable]) return NO;
    if (![other isKindOfClass:UIPanGestureRecognizer.class] && ![other isKindOfClass:UISwipeGestureRecognizer.class]) return NO;
    UIView *view=other.view;
    if (!view || (view!=self.table && ![view isDescendantOfView:self.table])) return NO;
    if ([view isDescendantOfView:self.headerContainer]) return NO;
    // Native row swipes (and the table's scroll pan) wait for our direction decision.
    // A vertical drag fails shouldBegin immediately; an admitted horizontal drag
    // owns the sequence even if the host permits simultaneous recognition.
    // This is a per-attempt delegate dependency, not a permanent native modification.
    return YES;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gesture {
    if ((gesture!=self.pan && gesture!=self.listPan) || ![self groupSwipesAvailable]) return NO;
    if (!(gesture==self.pan ? self.barTouchAllowed : self.listTouchAllowed)) return NO;
    UIPanGestureRecognizer *pan=(UIPanGestureRecognizer *)gesture;
    CGPoint v=[pan velocityInView:self.chrome]; return fabs(v.x)>fabs(v.y)*1.5;
}
- (void)groupPan:(UIPanGestureRecognizer *)pan {
    // Admission is latched at touch-down; crossing the 85% boundary cannot change owners.
    if (pan.state!=UIGestureRecognizerStateEnded || ![self groupSwipesAvailable]) return;
    if ((pan!=self.pan && pan!=self.listPan) || !(pan==self.pan ? self.barTouchAllowed : self.listTouchAllowed)) return;
    CGPoint p=[pan translationInView:self.chrome],v=[pan velocityInView:self.chrome];
    if (fabs(p.x)<44 && fabs(v.x)<350) return;
    NSInteger index=self.chrome.selectedIndex+(p.x<0 || (p.x==0 && v.x<0) ? 1 : -1);
    if (index>=0 && index<(NSInteger)self.displayedTabs.count && [self closeMenusForGroupSwitch]) {
        [self.chrome selectTabAtIndex:index animated:YES]; [self selectIndex:index];
    }
}
@end
BOOL CSGroupCardPosition(UITableView *table, NSIndexPath *path, BOOL *first, BOOL *last) {
    CSGroupListAdapter *adapter=[CSGroupListAdapter adapterForTable:table];
    if (!adapter.isActive) return NO;
    if (CSGroupUsesNativeIndices(table)) path=[adapter displayPath:path];
    if (!path || path.length!=2 || path.section<0 || path.section>=(NSInteger)adapter.projection.sections.count) return NO;
    NSArray *rows=adapter.projection.sections[(NSUInteger)path.section];
    if (path.row<0 || path.row>=(NSInteger)rows.count) return NO;
    if (first) *first=path.row==0; if (last) *last=path.row==(NSInteger)rows.count-1; return YES;
}
