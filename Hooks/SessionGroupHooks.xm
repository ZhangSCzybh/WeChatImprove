#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "CSGroupListAdapter.h"
#import "CSGroupNativeBridge.h"

@interface NewMainFrameViewController : NSObject @end
@interface MainFrameTableView : UITableView @end
@interface MainFrameLogicController : NSObject @end
@interface MainSessionEditingLogic : NSObject @end

static char EditingContextKey;
static CSGroupListAdapter *EditingAdapter(id owner) {
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:CSGroupReadObject(owner,@"tableView")];
    return a ?: [CSGroupListAdapter adapterForController:CSGroupReadObject(owner,@"delegate")];
}
static void EditingAction(id owner, void (^body)(NSIndexPath *current)) {
    NSDictionary *context=objc_getAssociatedObject(owner,&EditingContextKey);
    CSGroupListAdapter *a=EditingAdapter(owner);
    if (!context) {
        if (a.table) CSGroupWithNativeIndices(a.table, ^{ body(nil); }); else body(nil);
        return;
    }
    NSString *confirming=CSGroupReadObject(owner,@"confirmingSessionName");
    NSString *expected=[context[@"row"] userName];
    if ([confirming isKindOfClass:NSString.class] && confirming.length && ![confirming isEqual:expected]) return;
    [a performNativeEditingContext:context action:body];
}

static CSGroupListAdapter *Adapter(id owner) {
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForController:owner];
    if (!a) a=[CSGroupListAdapter adapterForController:CSGroupReadObject(owner,@"m_delegate")];
    return a;
}
static void Native(id owner, BOOL change, void (^body)(void)) {
    CSGroupListAdapter *a=Adapter(owner);
    if (!a.table) { body(); return; }
    if (change) [a beginNativeChange];
    @try { CSGroupWithNativeIndices(a.table,body); }
    @finally { if (change) [a endNativeChange]; }
}
static BOOL Projected(CSGroupListAdapter *a) { return a.isActive && !a.publishing; }
static void SettingsChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef info) {
    (void)center; (void)observer; (void)name; (void)object; (void)info;
    [CSGroupListAdapter settingsChanged];
}

%hook NewMainFrameViewController
- (void)viewDidLoad { %orig; [CSGroupListAdapter attachToController:self]; }
- (void)initView { %orig; [CSGroupListAdapter attachToController:self]; }
- (void)viewWillAppear:(BOOL)animated {
    Native(self,NO,^{ %orig; });
    [CSGroupListAdapter attachToController:self];
}
- (void)viewDidAppear:(BOOL)animated {
    Native(self,NO,^{ %orig; });
    [CSGroupListAdapter attachToController:self];
}
- (void)viewDidLayoutSubviews { Native(self,NO,^{ %orig; }); [CSGroupListAdapter layoutForController:self]; }
- (void)initTableHeaderView { Native(self,NO,^{ %orig; }); [CSGroupListAdapter layoutForController:self]; }
- (void)setSearchBarToTableHeaderView { Native(self,NO,^{ %orig; }); [CSGroupListAdapter layoutForController:self]; }
- (void)onSearch { [Adapter(self) prepareForNativeSearch]; Native(self,NO,^{ %orig; }); [Adapter(self) requestRefresh]; }
- (void)setSearchBarActive:(BOOL)active { if (active) [Adapter(self) prepareForNativeSearch]; Native(self,NO,^{ %orig; }); [Adapter(self) refresh]; }
- (void)onFTSSearchEnd { Native(self,NO,^{ %orig; }); [Adapter(self) requestRefresh]; }
- (void)cancelSearch { Native(self,NO,^{ %orig; }); [Adapter(self) requestRefresh]; }
- (id)previewingContext:(id)context viewControllerForLocation:(CGPoint)point {
    CSGroupListAdapter *a=Adapter(self);
    if (a.isActive) { [a deferNativePresentation]; return nil; }
    __block id result=nil; Native(self,NO,^{ result=%orig; }); return result;
}
- (void)newMessageByContact:(id)contact msgWrapToAdd:(id)wrap { Native(self,YES,^{ %orig; }); }
- (void)updateSession:(id)session { Native(self,YES,^{ %orig; }); }
- (void)reloadSessions { Native(self,YES,^{ %orig; }); }
- (void)updateItem:(id)item { Native(self,YES,^{ %orig; }); }
- (void)insertSessionCellAtIndexes:(id)paths { Native(self,YES,^{ %orig; }); }
- (void)deleteSessionCellAtIndexes:(id)paths { Native(self,YES,^{ %orig; }); }
- (void)onLogicDeleteSessionByUsername:(id)name { Native(self,YES,^{ %orig; }); }
- (void)logicUpdateSession:(id)session { Native(self,YES,^{ %orig; }); }
- (void)onAuthOK { Native(self,YES,^{ %orig; }); }
- (void)onLogicHideSession:(id)session { Native(self,YES,^{ %orig; }); }
- (void)selectCellForName:(id)name {
    CSGroupListAdapter *a=Adapter(self);
    if (a.isActive) { [a performInNativePresentation:^{ Native(self,NO,^{ %orig; }); }]; return; }
    Native(self,NO,^{ %orig; });
}
- (void)cancelSelectedCell { Native(self,NO,^{ %orig; }); }
- (void)handleSelectIndexPath:(id)path tableView:(id)table { Native(self,NO,^{ %orig; }); }
- (void)previewingContext:(id)context commitViewController:(id)vc { Native(self,NO,^{ %orig; }); }
- (void)onNextUnreadChat { CSGroupListAdapter *a=Adapter(self); if (a.isActive) { [a performInNativePresentation:^{ Native(self,NO,^{ %orig; }); }]; return; } Native(self,NO,^{ %orig; }); }
- (void)onNextChat { CSGroupListAdapter *a=Adapter(self); if (a.isActive) { [a performInNativePresentation:^{ Native(self,NO,^{ %orig; }); }]; return; } Native(self,NO,^{ %orig; }); }
- (void)onLastChat { CSGroupListAdapter *a=Adapter(self); if (a.isActive) { [a performInNativePresentation:^{ Native(self,NO,^{ %orig; }); }]; return; } Native(self,NO,^{ %orig; }); }

- (id)logicGetCellDataAtIndexPath:(id)path { __block id result=nil; Native(self,NO,^{ result=%orig; }); return result; }
- (id)logicGetSessionAtIndexPath:(id)path { __block id result=nil; Native(self,NO,^{ result=%orig; }); return result; }
- (id)visibleIndexPaths { __block id result=nil; Native(self,NO,^{ result=%orig; }); return result; }
- (id)indexPathOfSessionUserName:(id)name { __block id result=nil; Native(self,NO,^{ result=%orig; }); return result; }
%end

%hook MainSessionEditingLogic
- (void)handleEditing:(NSInteger)style forTableView:(UITableView *)table atIndexPath:(NSIndexPath *)path {
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:table];
    NSDictionary *context=[a captureNativeEditingContextAtPath:path];
    if (a.isActive && !context) return;
    objc_setAssociatedObject(self,&EditingContextKey,context,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (table) { CSGroupWithNativeIndices(table, ^{ %orig; }); } else { %orig; }
}
- (void)deleteSessionAtIndexPath:(NSIndexPath *)path {
    EditingAction(self, ^(NSIndexPath *current) { %orig(current ?: path); });
}
- (void)handleBrandUnsubscribeAtIndexPath:(NSIndexPath *)path {
    EditingAction(self, ^(NSIndexPath *current) { %orig(current ?: path); });
}
- (void)onConfirmDeleteSessionAtIndex:(id)index {
    EditingAction(self, ^(NSIndexPath *current) { %orig([index isKindOfClass:NSIndexPath.class] && current ? current : index); });
}
- (void)actionSheet:(id)sheet clickedButtonAtIndex:(NSInteger)index {
    EditingAction(self, ^(__unused NSIndexPath *current) { %orig; });
}
- (void)onArriveFundConfirmDeleteSession:(id)session {
    EditingAction(self, ^(__unused NSIndexPath *current) { %orig; });
}
%end

%hook MainFrameLogicController
- (void)onSessionRebuildBegin { [Adapter(self) beginNativeChange]; Native(self,NO,^{ %orig; }); }
- (void)onSessionRebuildEnd { @try { Native(self,NO,^{ %orig; }); } @finally { [Adapter(self) endNativeChange]; } }
- (void)onActiveUsrNameChange:(id)oldName curUsrName:(id)newName { Native(self,YES,^{ %orig; }); }
- (void)onSessionTotalUnreadCountChange:(unsigned int)count { Native(self,YES,^{ %orig; }); }
- (void)onSessionChanged:(id)session { Native(self,YES,^{ %orig; }); }
- (void)onSessionTopStatusChanged:(id)session bTop:(BOOL)top { Native(self,YES,^{ %orig; }); }
- (void)onMainSessionReload { Native(self,YES,^{ %orig; }); }
%end

%hook UITableView
- (void)setEditing:(BOOL)editing {
    %orig;
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
    if (!editing && !a.publishing) [a requestRefresh];
}
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    %orig;
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
    if (!editing && !a.publishing) [a requestRefresh];
}
- (UIView *)tableHeaderView {
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
    if (a && (CSGroupUsesNativeHeader(self) || (!a.updatingHeader && CSGroupUsesNativeIndices(self))))
        return [a nativeTableHeaderView];
    return %orig;
}
- (void)setTableHeaderView:(UIView *)header {
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
    if (a && !a.updatingHeader) { [a setNativeTableHeaderView:header]; return; }
    %orig;
}
- (void)setDataSource:(id)source {
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
    %orig(a ? [a proxyForTarget:source role:0] : source);
    if (a && !a.publishing) [a requestRefresh];
}
- (void)setDelegate:(id)delegate {
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
    %orig(a ? [a proxyForTarget:delegate role:1] : delegate);
    if (a && !a.publishing) [a requestRefresh];
}
- (void)setPrefetchDataSource:(id)source {
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
    %orig(a ? [a proxyForTarget:source role:2] : source);
}
- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
    if (a.isActive && CSGroupUsesNativeIndices(self)) return [a nativeRowCount:section];
    return %orig;
}
- (NSInteger)numberOfSections {
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
    if (a.isActive && CSGroupUsesNativeIndices(self)) return [a nativeSectionCount];
    return %orig;
}
- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)path {
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
    if (!a.isActive || !CSGroupUsesNativeIndices(self)) return %orig;
    NSIndexPath *display=[a displayPath:path];
    if (!display) return nil;
    __block UITableViewCell * result=nil; CSGroupWithDisplayIndices(self, ^{ result=%orig(display); }); return result;
}
- (CGRect)rectForRowAtIndexPath:(NSIndexPath *)path {
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
    if (!a.isActive || !CSGroupUsesNativeIndices(self)) return %orig;
    NSIndexPath *display=[a displayPath:path];
    if (!display) return CGRectZero;
    __block CGRect result=CGRectZero; CSGroupWithDisplayIndices(self, ^{ result=%orig(display); }); return result;
}
- (void)selectRowAtIndexPath:(NSIndexPath *)path animated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)position {
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
    if (!a.isActive || !CSGroupUsesNativeIndices(self))  { %orig; return; }
    NSIndexPath *display=[a displayPath:path];
    if (!display && path) { [a revealNativePath:path action:^(NSIndexPath *current) { CSGroupWithDisplayIndices(self, ^{ %orig(current, animated, position); }); }]; return; }
    CSGroupWithDisplayIndices(self, ^{ %orig(display, animated, position); });
}
- (void)deselectRowAtIndexPath:(NSIndexPath *)path animated:(BOOL)animated {
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
    if (!a.isActive || !CSGroupUsesNativeIndices(self))  { %orig; return; }
    NSIndexPath *display=[a displayPath:path];
    if (!display && path) return;
    CSGroupWithDisplayIndices(self, ^{ %orig(display, animated); });
}
- (void)scrollToRowAtIndexPath:(NSIndexPath *)path atScrollPosition:(UITableViewScrollPosition)position animated:(BOOL)animated {
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
    if (!a.isActive || !CSGroupUsesNativeIndices(self))  { %orig; return; }
    NSIndexPath *display=[a displayPath:path];
    if (!display && path) { [a revealNativePath:path action:^(NSIndexPath *current) { CSGroupWithDisplayIndices(self, ^{ %orig(current, position, animated); }); }]; return; }
    CSGroupWithDisplayIndices(self, ^{ %orig(display, position, animated); });
}
- (NSIndexPath *)indexPathForCell:(UITableViewCell *)cell {
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
    if (!a.isActive || !CSGroupUsesNativeIndices(self)) return %orig;
    __block NSIndexPath *display=nil; CSGroupWithDisplayIndices(self, ^{ display=%orig(cell); }); return [a nativePath:display];
}
- (NSIndexPath *)indexPathForRowAtPoint:(CGPoint)point {
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
    if (!a.isActive || !CSGroupUsesNativeIndices(self)) return %orig;
    __block NSIndexPath *display=nil; CSGroupWithDisplayIndices(self, ^{ display=%orig(point); }); return [a nativePath:display];
}
- (NSIndexPath *)indexPathForSelectedRow {
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
    if (!a.isActive || !CSGroupUsesNativeIndices(self)) return %orig;
    __block NSIndexPath *display=nil; CSGroupWithDisplayIndices(self, ^{ display=%orig; }); return [a nativePath:display];
}
- (NSArray *)indexPathsForVisibleRows {
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
    if (!a.isActive || !CSGroupUsesNativeIndices(self)) return %orig;
    __block NSArray *paths=nil; CSGroupWithDisplayIndices(self, ^{ paths=%orig; }); return [a nativePaths:paths];
}
- (NSArray *)indexPathsForSelectedRows {
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
    if (!a.isActive || !CSGroupUsesNativeIndices(self)) return %orig;
    __block NSArray *paths=nil; CSGroupWithDisplayIndices(self, ^{ paths=%orig; }); return [a nativePaths:paths];
}
- (void)reloadData {
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
    if (Projected(a)) { [a requestRefresh]; return; }
    CSGroupWithDisplayIndices(self, ^{ %orig; });
}
- (void)beginUpdates {
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
    if (Projected(a)) { [a beginNativeChange]; return; } %orig;
}
- (void)endUpdates {
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
    if (a.changeDepth && !a.publishing) { [a endNativeChange]; return; } %orig;
}
- (void)performBatchUpdates:(void (^)(void))updates completion:(void (^)(BOOL))completion {
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
    if (Projected(a)) { [a performNativeBatch:updates completion:completion]; return; } %orig;
}
- (void)insertRowsAtIndexPaths:(NSArray *)paths withRowAnimation:(UITableViewRowAnimation)animation {
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
    if (Projected(a)) { [a requestRefresh]; return; } %orig;
}
- (void)deleteRowsAtIndexPaths:(NSArray *)paths withRowAnimation:(UITableViewRowAnimation)animation {
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
    if (Projected(a)) { [a requestRefresh]; return; } %orig;
}
- (void)reloadRowsAtIndexPaths:(NSArray *)paths withRowAnimation:(UITableViewRowAnimation)animation {
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
    if (Projected(a)) { [a requestRefresh]; return; } %orig;
}
- (void)moveRowAtIndexPath:(NSIndexPath *)source toIndexPath:(NSIndexPath *)destination {
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
    if (Projected(a)) { [a requestRefresh]; return; } %orig;
}
- (void)insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
    if (Projected(a)) { [a requestRefresh]; return; } %orig;
}
- (void)deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
    if (Projected(a)) { [a requestRefresh]; return; } %orig;
}
- (void)reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
    if (Projected(a)) { [a requestRefresh]; return; } %orig;
}
- (void)moveSection:(NSInteger)source toSection:(NSInteger)destination {
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
    if (Projected(a)) { [a requestRefresh]; return; } %orig;
}
%end

%hook MainFrameTableView
- (BOOL)hasSearchBarHeader {
    if (![CSGroupListAdapter adapterForTable:self]) return %orig;
    // MMTableView switches BOTH contentInset getter and setter semantics based
    // on this classification. The grouping wrapper must never change it.
    // A separate read scope also works inside publishHeader (updatingHeader=YES)
    // without changing which rows or displayed header UIKit is laying out.
    __block BOOL result=NO;
    CSGroupWithNativeHeader(self, ^{ result=%orig; });
    return result;
}
- (NSIndexPath *)indexPathForSelectedRow {
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
    if (!a.isActive || !CSGroupUsesNativeIndices(self)) return %orig;
    __block NSIndexPath *display=nil; CSGroupWithDisplayIndices(self, ^{ display=%orig; }); return [a nativePath:display];
}
- (void)selectRowAtIndexPath:(NSIndexPath *)path animated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)position {
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
    if (!a.isActive || !CSGroupUsesNativeIndices(self))  { %orig; return; }
    NSIndexPath *display=[a displayPath:path];
    if (!display && path) { [a revealNativePath:path action:^(NSIndexPath *current) { CSGroupWithDisplayIndices(self, ^{ %orig(current, animated, position); }); }]; return; }
    CSGroupWithDisplayIndices(self, ^{ %orig(display, animated, position); });
}
- (void)deselectRowAtIndexPath:(NSIndexPath *)path animated:(BOOL)animated {
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
    if (!a.isActive || !CSGroupUsesNativeIndices(self))  { %orig; return; }
    NSIndexPath *display=[a displayPath:path];
    if (!display && path) return;
    CSGroupWithDisplayIndices(self, ^{ %orig(display, animated); });
}
- (NSIndexPath *)selectedIndexPath {
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
    if (!a.isActive || !CSGroupUsesNativeIndices(self)) return %orig;
    __block NSIndexPath *path=nil; CSGroupWithDisplayIndices(self, ^{ path=%orig; }); return [a nativePath:path];
}
- (void)setSelectedIndexPath:(NSIndexPath *)path {
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
    if (!a.isActive || !CSGroupUsesNativeIndices(self)) { %orig; return; }
    NSIndexPath *display=[a displayPath:path];
    CSGroupWithDisplayIndices(self, ^{ %orig(display); });
}
- (void)selectRowAtIndexPath:(NSIndexPath *)path cell:(id)cell animated:(BOOL)animated scrollPosition:(NSInteger)position {
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
    if (!a.isActive || !CSGroupUsesNativeIndices(self)) { %orig; return; }
    NSIndexPath *display=[a displayPath:path]; if (!display) return;
    CSGroupWithDisplayIndices(self, ^{ %orig(display,cell,animated,position); });
}
- (void)handleSelectAtIndexPath:(NSIndexPath *)path {
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
    if (!a.isActive || !CSGroupUsesNativeIndices(self)) { %orig; return; }
    NSIndexPath *display=[a displayPath:path]; if (!display) return;
    CSGroupWithDisplayIndices(self, ^{ %orig(display); });
}
- (BOOL)tryInsertRowsAtIndexPaths:(NSArray *)paths withRowAnimation:(NSInteger)animation {
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
    if (!Projected(a)) return %orig;
    __block BOOL result=NO;
    [a beginNativeChange];
    @try { CSGroupWithNativeIndices(self, ^{ result=%orig; }); }
    @finally { [a endNativeChange]; }
    return result;
}
- (BOOL)tryDeleteRowsAtIndexPaths:(NSArray *)paths withRowAnimation:(NSInteger)animation {
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
    if (!Projected(a)) return %orig;
    __block BOOL result=NO;
    [a beginNativeChange];
    @try { CSGroupWithNativeIndices(self, ^{ result=%orig; }); }
    @finally { [a endNativeChange]; }
    return result;
}
%end

%ctor {
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),NULL,SettingsChanged,
        CFSTR("com.wechat.enhance.chat_group.settings_changed"),NULL,CFNotificationSuspensionBehaviorDeliverImmediately);
}
