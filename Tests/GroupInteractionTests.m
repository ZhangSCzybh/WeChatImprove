#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <objc/runtime.h>
#import <objc/message.h>
static char TitleContextKey;

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
@property(nonatomic) BOOL editing;
@property(nonatomic) NSUInteger closes;
- (void)setEditing:(BOOL)editing animated:(BOOL)animated;
@end
@implementation UITableView
- (void)setEditing:(BOOL)editing animated:(BOOL)animated { (void)animated; self.editing=editing; self.closes++; }
@end
@interface UIGestureRecognizer : NSObject @end
@implementation UIGestureRecognizer @end
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
@end
@implementation Chrome @end
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
static NSHashTable *Adapters(void) {
    static NSHashTable *adapters; if (!adapters) adapters=[NSHashTable weakObjectsHashTable]; return adapters;
}
@interface CSGroupListAdapter : NSObject
@property(nonatomic,strong) UITableView *table;
@property(nonatomic,strong) Host *controller;
@property(nonatomic,strong) CSGroupRow *swipeRow;
@property(nonatomic,copy) NSString *swipeAccount,*publishedTabID;
@property(nonatomic,strong) NSIndexPath *swipeDisplayPath;
@property(nonatomic) BOOL active,swipeActive,dirty,pendingScrollToTop,chromeVisible,searching,barTouchAllowed,listTouchAllowed;
@property(nonatomic) NSUInteger changeDepth,refreshRequests;
@property(nonatomic,strong) CSGroupProjection *projection;
@property(nonatomic,strong) CSGroupPreferences *preferences;
@property(nonatomic,strong) NSArray *displayedTabs;
@property(nonatomic,strong) UIGestureRecognizer *pan,*listPan;
@property(nonatomic,strong) Chrome *chrome;
@property(nonatomic,strong) UIView *headerContainer;
- (BOOL)isActive;
- (NSIndexPath *)currentPathForRow:(CSGroupRow *)row;
- (NSIndexPath *)displayPath:(NSIndexPath *)path;
- (void)requestRefresh;
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
#include "GroupInteractionBodies.h"
- (BOOL)isActive { return self.active; }
- (NSIndexPath *)currentPathForRow:(CSGroupRow *)row { return CSGroupResolveNativeRowPath(self.controller,row,YES); }
- (NSIndexPath *)displayPath:(NSIndexPath *)path { (void)path; return [NSIndexPath indexPathWithIndex:1]; }
- (void)requestRefresh { self.dirty=YES; self.refreshRequests++; }
- (void)beginNativeChange { self.changeDepth++; }
- (void)endNativeChange { self.changeDepth--; [self requestRefresh]; }
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
    a.table=[UITableView new]; a.table.editing=YES; a.table.bounds=CGRectMake(0,0,400,800);
    a.controller=[Host new]; a.controller.paths=[@{@"deleted":Path(8),@"survivor":Path(12)} mutableCopy];
    a.controller.m_titleView=[NativeTitle new];
    a.swipeRow=[CSGroupRow new]; a.swipeRow.userName=@"deleted";
    a.swipeActive=YES; a.swipeAccount=account; a.swipeDisplayPath=Path(1);
    a.projection=[CSGroupProjection new]; a.projection.accountID=account; a.projection.rows=@{Path(1):a.swipeRow};
    a.preferences=[CSGroupPreferences new]; a.preferences.accountID=account;
    a.pan=[UIGestureRecognizer new]; a.listPan=[UIGestureRecognizer new];
    a.chrome=[Chrome new]; a.chrome.scrollView=[UIView new]; a.headerContainer=[UIView new];
    [Adapters() addObject:a]; return a;
}
static NSInvocation *Swipe(Host *host,BOOL end,BOOL commit,UITableView *table,NSIndexPath *path) {
    SEL selector=commit ? @selector(tableView:commitEditingStyle:forRowAtIndexPath:) : end ? @selector(tableView:didEndEditingRowAtIndexPath:) : @selector(tableView:willBeginEditingRowAtIndexPath:);
    NSInvocation *inv=[NSInvocation invocationWithMethodSignature:[host methodSignatureForSelector:selector]]; inv.selector=selector;
    [inv setArgument:&table atIndex:2];
    if (commit) { NSInteger style=1; [inv setArgument:&style atIndex:3]; }
    [inv setArgument:&path atIndex:commit ? 4 : 3]; [inv retainArguments]; return inv;
}
int main(void) { @autoreleasepool {
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
    a.swipeActive=YES; Check(![a gestureRecognizer:a.listPan shouldReceiveTouch:touch],@"open menu blocks group swipes");
    printf("Group interactions: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
    return failures ? 1 : 0;
} }
