#import "CSGroupListAdapter.h"
#import "CSGroupProjection.h"
#import "CSGroupPreferences.h"
#import "CSGroupAppearance.h"
#import "CSGroupInvocationMapper.h"
#import "CSGroupNativeBridge.h"
#import "WESessionTabContainerView.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import <QuartzCore/QuartzCore.h>

static char AdapterKey, CellRowKey;
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
@property (nonatomic, strong) NSMutableSet<NSIndexPath *> *prefetchedPaths;
@property (nonatomic, strong) NSMutableArray *nativeActions;
@property (nonatomic) BOOL nativePresentation, scheduled, dirty, searching, scrolling;
@property (nonatomic, readwrite) BOOL publishing;
@property (atomic, readwrite) NSUInteger changeDepth;
@property (nonatomic) NSUInteger revision;
@property (nonatomic) UIScrollViewDecelerationRate baselineDeceleration;
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
- (BOOL)respondsToSelector:(SEL)selector { return [super respondsToSelector:selector] || [self.target respondsToSelector:selector]; }
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
        adapter.proxies=[NSMutableDictionary dictionary]; adapter.anchors=[NSMutableDictionary dictionary]; adapter.completions=[NSMutableArray array]; adapter.prefetchedPaths=[NSMutableSet set]; adapter.nativeActions=[NSMutableArray array];
        adapter.nativeHeader=[table tableHeaderView]; adapter.baselineDeceleration=[table decelerationRate];
        objc_setAssociatedObject(controller,&AdapterKey,adapter,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(table,&AdapterKey,adapter,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [Adapters() addObject:adapter];
    }
    [adapter refresh]; [adapter layout];
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
    UITableView *table=self.table; self.nativePresentation=YES; self.projecting=NO;
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
    self.searching=YES;
    [self layout];
}
- (void)publishHeader:(UIView *)header {
    if (!self.table) return;
    self.updatingHeader=YES;
    @try { CSGroupWithDisplayIndices(self.table, ^{ self.table.tableHeaderView=header; }); }
    @finally { self.updatingHeader=NO; }
}
- (void)layout {
    UITableView *table=self.table; if (!table || self.updatingHeader) return;
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
    self.pan.enabled=Option(@"swipe_gesture_enabled") && !table.editing && !self.swipeActive;
    self.listPan.enabled=self.pan.enabled;
}
- (void)refresh {
    if (!NSThread.isMainThread) { [self requestRefresh]; return; }
    if (self.publishing) return;
    if (self.changeDepth || self.table.dragging || self.table.decelerating || self.table.editing || self.swipeActive) { self.dirty=YES; return; }
    self.publishing=YES; self.dirty=NO;
    BOOL finished=NO;
    @try {
        [self saveAnchor];
        [self installProxies];
        NSString *account=CSGroupCurrentAccountID();
        BOOL changed= ![self.preferences.accountID isEqualToString:account];
        if (changed) { self.anchors=[NSMutableDictionary dictionary]; self.nativePresentation=NO; self.projection=nil; }
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
        CSGroupProjection *projection=sections && account ? [[CSGroupProjection alloc] initWithSections:sections tabs:tabs selectedTabID:selected filterDuplicates:self.preferences.filterDuplicates accountID:account revision:++self.revision] : nil;
        self.projection=projection.isValid ? projection : nil;
        if (!self.projection && account.length) {
            self.nativePresentation=YES; selected=@"preset_0";
            if (![tabs filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(WESessionTabItem *tab, NSDictionary *bindings) { (void)bindings; return tab.type==WETabTypeAll; }]].count)
                tabs=[@[[WESessionTabItem tabWithType:WETabTypeAll]] arrayByAddingObjectsFromArray:tabs];
        }
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
        finished=YES;
    } @finally {
        self.publishing=NO;
        NSArray *callbacks=[self.completions copy]; [self.completions removeAllObjects];
        for (void (^completion)(BOOL) in callbacks) completion(finished);
        if (finished && !self.isActive && !self.changeDepth) {
            NSArray *actions=[self.nativeActions copy]; [self.nativeActions removeAllObjects];
            for (void (^action)(void) in actions) CSGroupWithNativeIndices(self.table,action);
        }
        if (self.dirty) [self requestRefresh];
    }
}
- (void)requestRefresh {
    if (!NSThread.isMainThread) { dispatch_async(dispatch_get_main_queue(), ^{ [self requestRefresh]; }); return; }
    self.dirty=YES;
    if (self.scheduled || self.changeDepth || self.publishing) return;
    self.scheduled=YES;
    __weak typeof(self) weakSelf=self;
    dispatch_async(dispatch_get_main_queue(), ^{ CSGroupListAdapter *self=weakSelf; self.scheduled=NO; [self refresh]; });
}
- (void)beginNativeChange {
    @synchronized (self) { if (!self.changeDepth && NSThread.isMainThread) [self saveAnchor]; self.changeDepth++; }
}
- (void)endNativeChange {
    BOOL outer=NO; @synchronized (self) { if (self.changeDepth) self.changeDepth--; outer=self.changeDepth==0; }
    if (outer) [self requestRefresh];
}
- (void)performNativeBatch:(void (^)(void))updates completion:(void (^)(BOOL))completion {
    [self beginNativeChange]; if (completion) [self.completions addObject:[completion copy]];
    @try { CSGroupWithNativeIndices(self.table, ^{ if (updates) updates(); }); }
    @catch (NSException *exception) {
        if (completion) { [self.completions removeObject:completion]; completion(NO); }
        @throw exception;
    }
    @finally { [self endNativeChange]; }
}
- (void)useNativePresentation {
    if (!self.isActive || self.swipeActive || self.table.editing) return;
    [self saveAnchor]; self.nativePresentation=YES; [self.table setEditing:NO animated:NO]; [self refresh];
}
- (void)deferNativePresentation {
    __weak typeof(self) weakSelf=self;
    dispatch_async(dispatch_get_main_queue(), ^{ [weakSelf useNativePresentation]; });
}
- (void)performInNativePresentation:(void (^)(void))action {
    NSString *account=CSGroupCurrentAccountID(); if (!account.length) return;
    void (^guarded)(void)=^{ if ([account isEqualToString:CSGroupCurrentAccountID()]) action(); };
    if (!self.isActive && !self.publishing && !self.changeDepth) { CSGroupWithNativeIndices(self.table,guarded); return; }
    [self.nativeActions addObject:[guarded copy]];
    if (self.swipeActive || self.table.editing) {
        // Native navigation waits for the menu to close; do not discard its queued action.
        self.nativePresentation=YES; [self requestRefresh]; return;
    }
    [self useNativePresentation];
}
- (void)revealNativePath:(NSIndexPath *)path action:(void (^)(NSIndexPath *))action {
    id logic=CSGroupReadObject(self.controller,@"m_mainFrameLogicController");
    NSString *name=CSGroupReadObject(ObjectArgument(logic,@"getSessionInfoAtIndexPath:",path),@"m_nsUserName");
    if (![name isKindOfClass:NSString.class] || !name.length) return;
    __weak typeof(self) weakSelf=self;
    [self performInNativePresentation:^{
        id logic=CSGroupReadObject(weakSelf.controller,@"m_mainFrameLogicController");
        NSIndexPath *current=ObjectArgument(logic,@"indexPathOfSessionUserName:",name);
        if ([current isKindOfClass:NSIndexPath.class] && [CSGroupReadObject(ObjectArgument(logic,@"getSessionInfoAtIndexPath:",current),@"m_nsUserName") isEqual:name]) action(current);
    }];
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
    return self.dirty ? nil : [self.projection displayPathForNativePath:nativePath];
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
    if (!current) return NO;
    CSGroupWithNativeIndices(self.table, ^{ action(current); }); return YES;
}
- (BOOL)forwardSwipeInvocation:(NSInvocation *)inv target:(id)target {
    NSString *name=NSStringFromSelector(inv.selector);
    BOOL begin=[name isEqual:@"tableView:willBeginEditingRowAtIndexPath:"];
    BOOL end=[name isEqual:@"tableView:didEndEditingRowAtIndexPath:"];
    BOOL commit=[name isEqual:@"tableView:commitEditingStyle:forRowAtIndexPath:"];
    if ((!begin && !end && !commit) || (!self.isActive && !self.swipeRow) || CSGroupUsesNativeIndices(self.table)) return NO;
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
            self.swipeActive=NO; self.swipeRow=nil; self.swipeAccount=nil; self.swipeDisplayPath=nil;
            if (self.dirty) [self requestRefresh];
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
        if (self.dirty && ([name isEqual:@"scrollViewDidEndDecelerating:"] || [name isEqual:@"scrollViewDidEndDragging:willDecelerate:"] || [name isEqual:@"tableView:didEndEditingRowAtIndexPath:"])) [self requestRefresh];
        return;
    }
    if ([name isEqual:@"numberOfSectionsInTableView:"]) { NSInteger count=(NSInteger)self.projection.sections.count; [inv setReturnValue:&count]; return; }
    if ([name isEqual:@"tableView:numberOfRowsInSection:"]) {
        NSInteger section=0; [inv getArgument:&section atIndex:3];
        NSInteger count=section>=0 && section<(NSInteger)self.projection.sections.count ? (NSInteger)self.projection.sections[(NSUInteger)section].count : 0;
        [inv setReturnValue:&count]; return;
    }
    // Blocks/points can retain an obsolete path. Retry these interactions after native presentation.
    if (!CSGroupInvocationIsSupported(inv.selector) || [@[@"tableView:shouldShowMenuForRowAtIndexPath:",@"tableView:moveRowAtIndexPath:toIndexPath:",@"tableView:performAction:forRowAtIndexPath:withSender:"] containsObject:name]) { if (!self.swipeActive) [self deferNativePresentation]; return; }
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
        } else if (!cellLifecycle) [self deferNativePresentation];
        return;
    }
    CSGroupWithNativeIndices(self.table, ^{ [inv invokeWithTarget:target]; });
    if (CSGroupInvocationReturnsPath(inv.selector)) {
        __unsafe_unretained NSIndexPath *native=nil; [inv getReturnValue:&native];
        NSIndexPath *display=[self displayPath:native]; [inv setReturnValue:&display]; [inv retainArguments];
    }
    if ([name isEqual:@"tableView:willDisplayCell:forRowAtIndexPath:"]) {
        __unsafe_unretained UITableViewCell *cell=nil; [inv getArgument:&cell atIndex:3];
        if (self.scrolling && !self.publishing && !UIAccessibilityIsReduceMotionEnabled() && [NSUserDefaults.standardUserDefaults boolForKey:@"com.wechat.enhance.scroll_animation.enabled"]) {
            CABasicAnimation *motion=[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
            motion.fromValue=@10; motion.toValue=@0; motion.additive=YES; motion.duration=0.18;
            [cell.layer addAnimation:motion forKey:@"CSGroupScrollMotion"];
            CABasicAnimation *fade=[CABasicAnimation animationWithKeyPath:@"opacity"];
            fade.fromValue=@(cell.layer.opacity*0.5); fade.toValue=@(cell.layer.opacity); fade.duration=0.18;
            [cell.layer addAnimation:fade forKey:@"CSGroupScrollFade"];
        }
    }
    if ([name isEqual:@"scrollViewWillBeginDragging:"]) self.scrolling=YES;
    if ([name isEqual:@"scrollViewDidEndDecelerating:"] || [name isEqual:@"scrollViewDidEndDragging:willDecelerate:"] || [name isEqual:@"tableView:didEndEditingRowAtIndexPath:"]) {
        if (!self.table.dragging && !self.table.decelerating) self.scrolling=NO;
        if (self.dirty) [self requestRefresh];
    }
}
- (void)saveAnchor {
    if (!self.isActive || !self.publishedTabID) return;
    __block NSIndexPath *first=nil; __block CGRect rect=CGRectZero;
    CSGroupWithDisplayIndices(self.table, ^{ first=[self.table.indexPathsForVisibleRows sortedArrayUsingSelector:@selector(compare:)].firstObject; if (first) rect=[self.table rectForRowAtIndexPath:first]; });
    CSGroupRow *row=[self.projection rowAtDisplayPath:first];
    if (row.userName.length) self.anchors[self.publishedTabID]=@{@"name":row.userName,@"kind":@(row.kind),@"offset":@(self.table.contentOffset.y-rect.origin.y)};
}
- (void)restoreAnchor {
    NSDictionary *anchor=self.anchors[self.publishedTabID];
    if (!self.isActive || !anchor) return;
    for (NSUInteger s=0;s<self.projection.sections.count;s++) {
        NSArray *rows=self.projection.sections[s];
        for (NSUInteger r=0;r<rows.count;r++) { CSGroupRow *row=rows[r];
            if ([row.userName isEqual:anchor[@"name"]] && row.kind==[anchor[@"kind"] unsignedIntegerValue]) {
                NSIndexPath *path=[NSIndexPath indexPathForRow:(NSInteger)r inSection:(NSInteger)s];
                CSGroupWithDisplayIndices(self.table, ^{
                    CGFloat y=[self.table rectForRowAtIndexPath:path].origin.y+[anchor[@"offset"] doubleValue];
                    CGFloat min=-self.table.adjustedContentInset.top;
                    CGFloat max=MAX(min,self.table.contentSize.height-self.table.bounds.size.height+self.table.adjustedContentInset.bottom);
                    [self.table setContentOffset:CGPointMake(self.table.contentOffset.x,MIN(max,MAX(min,y))) animated:NO];
                }); return;
            }
        }
    }
}
- (void)selectIndex:(NSInteger)index {
    if (self.swipeActive || self.table.editing) { self.chrome.selectedTabID=self.publishedTabID; return; }
    NSArray *tabs=self.displayedTabs; if (index<0 || index>=(NSInteger)tabs.count) return;
    if (![self.preferences.accountID isEqualToString:CSGroupCurrentAccountID()]) { [self requestRefresh]; return; }
    [self saveAnchor]; NSString *tabID=[tabs[(NSUInteger)index] tabId];
    BOOL belongs=[self.preferences.tabs filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(WESessionTabItem *tab, NSDictionary *bindings) { (void)bindings; return [tab.tabId isEqual:tabID]; }]].count>0;
    self.nativePresentation=!belongs; if (belongs) self.preferences.selectedTabID=tabID;
    [self refresh];
}
- (BOOL)groupSwipesAvailable {
    return self.table && Option(@"enabled") && Option(@"swipe_gesture_enabled") && self.chromeVisible && !self.searching && !self.table.editing && !self.swipeActive;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldReceiveTouch:(UITouch *)touch {
    BOOL allowed=NO;
    if (gesture==self.pan) self.barTouchAllowed=NO; else if (gesture==self.listPan) self.listTouchAllowed=NO;
    if ((gesture!=self.pan && gesture!=self.listPan) || ![self groupSwipesAvailable]) return NO;
    // Decide using the initial touch, before either recognizer can begin or cancel another.
    for (UIView *view=touch.view; view; view=view.superview) {
        if ([view isKindOfClass:UIControl.class] && (gesture!=self.pan || ![view isDescendantOfView:self.chrome.scrollView])) return NO;
        if (view==self.table || view==self.chrome) break;
    }
    if (gesture==self.listPan) {
        CGPoint point=[touch locationInView:self.table];
        CGRect viewport=self.table.bounds;
        // The boundary is fixed by the initial touch in the visible list width,
        // including a nonzero bounds origin. Exactly 80% belongs to native editing.
        if (!CGRectContainsPoint(viewport,point) || point.x>=CGRectGetMinX(viewport)+CGRectGetWidth(viewport)*0.8) return NO;
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
    // Admission is latched at touch-down; crossing the 80% boundary cannot change owners.
    if (pan.state!=UIGestureRecognizerStateEnded || ![self groupSwipesAvailable]) return;
    if ((pan!=self.pan && pan!=self.listPan) || !(pan==self.pan ? self.barTouchAllowed : self.listTouchAllowed)) return;
    CGPoint p=[pan translationInView:self.chrome],v=[pan velocityInView:self.chrome];
    if (fabs(p.x)<44 && fabs(v.x)<350) return;
    NSInteger index=self.chrome.selectedIndex+(p.x<0 || (p.x==0 && v.x<0) ? 1 : -1);
    if (index>=0 && index<(NSInteger)self.displayedTabs.count) { [self.chrome selectTabAtIndex:index animated:YES]; [self selectIndex:index]; }
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
