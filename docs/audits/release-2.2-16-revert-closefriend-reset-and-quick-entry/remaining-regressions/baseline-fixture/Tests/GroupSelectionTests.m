#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <objc/runtime.h>
#import "CSGroupProjection.h"
#import "CSCloseFriendPolicy.h"
#import "CSGroupPreferences.h"
#import "CSGroupInvocationMapper.h"
#import "CSGroupIndexScope.h"
#import "WESessionTabItem.h"
#import "GroupSelectionFlags.h"
static void CSCloseFriendRefreshSessionCover(id cell) { (void)cell; }
static char CellRowKey;
static NSString *currentAccount=@"selection-account";
static NSString *CSGroupCurrentAccountID(void) { return currentAccount; }
static NSUInteger CSCloseFriendAccountEpoch(void) { return 1; }
typedef NS_ENUM(NSUInteger,CSGroupFoldedPrivacyState) { CSGroupFoldedPrivacyUnknown,CSGroupFoldedPrivacyNoHidden,CSGroupFoldedPrivacyMixed,CSGroupFoldedPrivacyAllHidden };
static BOOL CSGroupIsFoldedController(id owner) { (void)owner; return NO; }
static BOOL Option(NSString *key) { return [key isEqual:@"enabled"]; }
static NSArray *CSGroupCopyFoldedRowsSelectingSummary(CSGroupRow *(^selector)(NSArray<CSGroupRow *> *)) { (void)selector; return nil; }
static NSArray *CSGroupCopyFoldedUserNames(void) { return nil; }
static CSGroupFoldedPrivacyState CSGroupAssessFoldedUserNames(NSArray *names,NSSet *hidden) { (void)names;(void)hidden;return CSGroupFoldedPrivacyUnknown; }
static CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) {
    return [[CSCloseFriendSnapshot alloc] initWithAccountID:currentAccount profile:@{@"enabled":@NO,@"friends":@[],@"groups":@[],@"options":@{}} revealed:NO revision:0 blocked:NO];
}
typedef NSInteger UITableViewScrollPosition;
@class CSGroupListAdapter;
@interface UITableView : NSObject
@property(nonatomic,weak) CSGroupListAdapter *adapter;
@property(nonatomic,strong) NSIndexPath *selected,*scrolled;
@property(nonatomic) NSUInteger selections,scrolls;
- (void)originalSelect:(NSIndexPath *)path animated:(BOOL)animated scrollPosition:(NSInteger)position;
- (void)originalScroll:(NSIndexPath *)path atScrollPosition:(NSInteger)position animated:(BOOL)animated;
- (void)selectRowAtIndexPath:(NSIndexPath *)path animated:(BOOL)animated scrollPosition:(NSInteger)position;
- (void)scrollToRowAtIndexPath:(NSIndexPath *)path atScrollPosition:(NSInteger)position animated:(BOOL)animated;
@end
@interface UITableViewCell : NSObject @end
@implementation UITableViewCell @end
@interface Target : NSObject
@property(nonatomic) NSUInteger calls;
@property(nonatomic,strong) NSIndexPath *received;
- (void)tableView:(id)table didSelectRowAtIndexPath:(NSIndexPath *)path;
- (BOOL)tableView:(id)table shouldShowMenuForRowAtIndexPath:(NSIndexPath *)path;
- (id)tableView:(id)table trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)path;
- (void)scrollViewDidChangeContentSize:(id)table;
- (void)scrollViewDidScroll:(id)table;
@end
@implementation Target
- (void)tableView:(id)table didSelectRowAtIndexPath:(NSIndexPath *)path { (void)table; self.calls++; self.received=path; }
- (BOOL)tableView:(id)table shouldShowMenuForRowAtIndexPath:(NSIndexPath *)path { (void)table; (void)path; self.calls++; return YES; }
- (id)tableView:(id)table trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)path { (void)table; (void)path; self.calls++; return @"unsafe captured native indices"; }
- (void)scrollViewDidChangeContentSize:(id)table { (void)table; self.calls++; }
- (void)scrollViewDidScroll:(id)table { (void)table; self.calls++; }
@end
@interface CSGroupListAdapter : NSObject
@property(nonatomic,strong) UITableView *table;
@property(nonatomic,strong) id controller;
@property(nonatomic,strong) CSGroupProjection *projection;
@property(nonatomic,strong) CSGroupPreferences *preferences;
@property(nonatomic,strong) NSMutableSet *prefetchedPaths;
@property(nonatomic,strong) NSMutableDictionary *nativeRows,*displayRows;
@property(nonatomic) BOOL active,publishing,dirty,swipeActive,pendingScrollToTop,nativePresentation,snapshotRetryAttempted;
@property(nonatomic) NSUInteger refreshRequests,fallbacks,snapshotRetryGeneration;
@property(nonatomic,copy) NSString *publishedTabID;
- (BOOL)isActive;
+ (instancetype)adapterForTable:(UITableView *)table;
- (void)forwardInvocation:(NSInvocation *)inv target:(id)target;
- (BOOL)forwardSwipeInvocation:(NSInvocation *)inv target:(id)target;
- (NSIndexPath *)currentPathForRow:(CSGroupRow *)row;
- (NSIndexPath *)displayPath:(NSIndexPath *)path;
- (void)requestRefresh;
- (void)requestRecovery;
- (void)scheduleRefresh;
- (void)deferNativePresentation; // Baseline-only spy: production must never call it.
#if HAS_STABLE_SNAPSHOT
- (CSGroupProjection *)projectionForSections:(NSArray *)sections tabs:(NSArray *)tabs selectedTabID:(NSString *)selected accountID:(NSString *)account;
#endif
@end
@implementation CSGroupListAdapter
- (void)requestRecovery { [self requestRefresh]; }
- (void)scheduleRefresh { [self requestRefresh]; }
#include "GroupSelectionBodies.h"
- (BOOL)isActive { return self.active; }
+ (instancetype)adapterForTable:(UITableView *)table { return table.adapter; }
- (BOOL)forwardSwipeInvocation:(NSInvocation *)inv target:(id)target { (void)inv; (void)target; return NO; }
- (NSIndexPath *)currentPathForRow:(CSGroupRow *)row { return row.userName ? self.nativeRows[row.userName] : nil; }
- (NSIndexPath *)displayPath:(NSIndexPath *)path { return path ? self.displayRows[path] : nil; }
- (void)requestRefresh { self.dirty=YES; self.refreshRequests++; }
- (void)deferNativePresentation { self.fallbacks++; self.nativePresentation=YES; self.publishedTabID=@"preset_0"; }
@end
@interface TestProxy : NSObject
@property(nonatomic,strong) CSGroupListAdapter *adapter;
@property(nonatomic,strong) Target *target;
@property(nonatomic,strong) NSMutableDictionary *signatures;
@end
@implementation TestProxy
#include "GroupProxySupport.h"
@end
@implementation UITableView
#include "GroupSelectionHooks.h"
- (void)originalSelect:(NSIndexPath *)path animated:(BOOL)animated scrollPosition:(NSInteger)position { (void)animated; (void)position; self.selected=path; self.selections++; }
- (void)originalScroll:(NSIndexPath *)path atScrollPosition:(NSInteger)position animated:(BOOL)animated { (void)animated; (void)position; self.scrolled=path; self.scrolls++; }
@end
static NSIndexPath *Path(NSUInteger row) { NSUInteger indexes[]={0,row}; return [NSIndexPath indexPathWithIndexes:indexes length:2]; }
static NSArray *Rows(void) {
    CSGroupRow *row=[[CSGroupRow alloc] initWithNativePath:Path(0) userName:@"friend" kind:CSGroupRowKindSession category:CSGroupRowCategoryPrivate top:NO unreadCount:0 redDot:NO];
    return @[@[row]];
}
static NSUInteger checks,failures;
static void Check(BOOL pass,NSString *message) { checks++; if (!pass) { failures++; fprintf(stderr,"FAIL: %s\n",message.UTF8String); } }
static CSGroupListAdapter *Fixture(NSUserDefaults *defaults) {
    CSGroupListAdapter *a=[CSGroupListAdapter new]; a.table=[UITableView new]; a.table.adapter=a; a.active=YES;
    a.preferences=[[CSGroupPreferences alloc] initWithDefaults:defaults accountID:currentAccount]; a.preferences.selectedTabID=@"preset_2";
    a.publishedTabID=@"preset_2"; a.prefetchedPaths=[NSMutableSet new];
    a.nativeRows=[@{@"friend":Path(9)} mutableCopy]; a.displayRows=[@{Path(9):Path(0)} mutableCopy];
    a.projection=[[CSGroupProjection alloc] initWithSections:Rows() tabs:a.preferences.tabs selectedTabID:@"preset_2" filterDuplicates:NO accountID:currentAccount];
    return a;
}
static NSInvocation *Invocation(Target *target,SEL selector,UITableView *table,NSIndexPath *path) {
    NSInvocation *inv=[NSInvocation invocationWithMethodSignature:[target methodSignatureForSelector:selector]];
    inv.selector=selector; [inv setArgument:&table atIndex:2];
    if (inv.methodSignature.numberOfArguments>3) [inv setArgument:&path atIndex:3]; [inv retainArguments]; return inv;
}
static void DrainRetries(void) {
    NSDate *until=[NSDate dateWithTimeIntervalSinceNow:0.08];
    while (until.timeIntervalSinceNow>0) [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.002]];
}
int main(void) { @autoreleasepool {
    NSString *suite=[@"com.wechat.tests.selection." stringByAppendingString:NSUUID.UUID.UUIDString];
    NSUserDefaults *defaults=[[NSUserDefaults alloc] initWithSuiteName:suite];
    Target *target=[Target new]; CSGroupListAdapter *a=Fixture(defaults);
    TestProxy *proxy=[TestProxy new]; proxy.adapter=a; proxy.target=target;
    Check(![proxy respondsToSelector:@selector(tableView:trailingSwipeActionsConfigurationForRowAtIndexPath:)],@"projected proxy does not advertise unsupported block/index callbacks");
    Check([proxy respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)],@"projected proxy keeps supported identity-mapped callbacks");
    CSGroupWithNativeIndices(a.table, ^{ Check([proxy respondsToSelector:@selector(tableView:trailingSwipeActionsConfigurationForRowAtIndexPath:)],@"native scope retains the host's actual callback availability"); });
    a.active=NO; Check([proxy respondsToSelector:@selector(tableView:trailingSwipeActionsConfigurationForRowAtIndexPath:)],@"disabled projection retains native optional callbacks"); a.active=YES;
    for (NSString *name in @[@"scrollViewDidChangeContentSize:",@"tableView:trailingSwipeActionsConfigurationForRowAtIndexPath:",@"tableView:shouldShowMenuForRowAtIndexPath:"]) {
        a=Fixture(defaults); NSUInteger calls=target.calls;
        NSInvocation *inv=Invocation(target,NSSelectorFromString(name),a.table,Path(0));
        [a forwardInvocation:inv target:target];
        Check(a.fallbacks==0 && !a.nativePresentation && [a.publishedTabID isEqual:@"preset_2"],@"unsupported or probe callbacks do not select All");
        Check(target.calls==calls,@"unsafe captured-index callbacks are not sent to the native target");
        if (inv.methodSignature.methodReturnLength) {
            unsigned char *value=calloc(1,inv.methodSignature.methodReturnLength); [inv getReturnValue:value];
            BOOL zero=YES; for (NSUInteger i=0;i<inv.methodSignature.methodReturnLength;i++) if (value[i]) zero=NO;
            Check(zero,@"unsupported optional callbacks return neutral values"); free(value);
        }
    }
    a=Fixture(defaults); [a.nativeRows removeAllObjects]; NSUInteger calls=target.calls;
    [a forwardInvocation:Invocation(target,@selector(tableView:didSelectRowAtIndexPath:),a.table,Path(0)) target:target];
    Check(a.fallbacks==0 && a.refreshRequests==1 && target.calls==calls && [a.publishedTabID isEqual:@"preset_2"],@"a deleted/stale row requests a same-group refresh without invoking another row or selecting All");
    a=Fixture(defaults);
    [a forwardInvocation:Invocation(target,@selector(tableView:didSelectRowAtIndexPath:),a.table,Path(0)) target:target];
    Check([target.received isEqual:Path(9)] && !CSGroupUsesNativeIndices(a.table),@"valid click still reaches the current native identity and releases its scope");
    calls=target.calls; [a forwardInvocation:Invocation(target,@selector(scrollViewDidScroll:),a.table,nil) target:target];
    Check(target.calls==calls+1 && !a.fallbacks,@"supported scrolling callbacks remain forwarded");
    CSGroupWithNativeIndices(a.table, ^{
        [a.table selectRowAtIndexPath:Path(44) animated:NO scrollPosition:0];
        [a.table scrollToRowAtIndexPath:Path(44) atScrollPosition:0 animated:NO];
    });
    Check(!a.table.selections && !a.table.scrolls && !a.nativePresentation && [a.publishedTabID isEqual:@"preset_2"],@"native restoration to a row outside the selected group cannot navigate to All");
    CSGroupWithNativeIndices(a.table, ^{
        [a.table selectRowAtIndexPath:Path(9) animated:NO scrollPosition:0];
        [a.table scrollToRowAtIndexPath:Path(9) atScrollPosition:0 animated:NO];
    });
    Check([a.table.selected isEqual:Path(0)] && [a.table.scrolled isEqual:Path(0)],@"native restoration inside the group uses display indices");
    a.active=NO;
    CSGroupWithNativeIndices(a.table, ^{ [a.table selectRowAtIndexPath:Path(44) animated:NO scrollPosition:0]; });
    Check([a.table.selected isEqual:Path(44)],@"explicit native presentation still supports unrestricted native navigation");
#if HAS_STABLE_SNAPSHOT
    a=Fixture(defaults);
    CSGroupProjection *p=[a projectionForSections:nil tabs:a.preferences.tabs selectedTabID:@"preset_3" accountID:currentAccount];
    Check(p.isValid && !p.sections.count && !a.nativePresentation && [a.preferences.selectedTabID isEqual:@"preset_2"],@"incomplete snapshot creates a safe empty target projection without resetting preferences or native mode");
    [a projectionForSections:@[@[@"bad row"]] tabs:a.preferences.tabs selectedTabID:@"preset_3" accountID:currentAccount];
    DrainRetries(); Check(a.refreshRequests==1,@"multiple failed snapshots schedule only one bounded recovery attempt");
    [a projectionForSections:nil tabs:a.preferences.tabs selectedTabID:@"preset_3" accountID:currentAccount];
    DrainRetries(); Check(a.refreshRequests==1,@"persistent native snapshot failure cannot create a retry loop");
    p=[a projectionForSections:Rows() tabs:a.preferences.tabs selectedTabID:@"preset_2" accountID:currentAccount];
    Check(p.isValid && p.sections[0].count==1 && !a.snapshotRetryAttempted,@"valid native snapshot restores filtered data and rearms future recovery");
    [a projectionForSections:nil tabs:a.preferences.tabs selectedTabID:@"preset_2" accountID:currentAccount];
    [a projectionForSections:Rows() tabs:a.preferences.tabs selectedTabID:@"preset_2" accountID:currentAccount];
    DrainRetries(); Check(a.refreshRequests==1,@"normal data recovery invalidates a previously queued retry");
    [a projectionForSections:nil tabs:a.preferences.tabs selectedTabID:@"preset_2" accountID:currentAccount];
    [a projectionForSections:Rows() tabs:a.preferences.tabs selectedTabID:@"preset_2" accountID:currentAccount];
    [a projectionForSections:nil tabs:a.preferences.tabs selectedTabID:@"preset_2" accountID:currentAccount];
    DrainRetries(); Check(a.refreshRequests==2,@"a newer failure replaces the older scheduled retry generation");
    [a projectionForSections:Rows() tabs:a.preferences.tabs selectedTabID:@"preset_2" accountID:currentAccount];
    [a projectionForSections:nil tabs:a.preferences.tabs selectedTabID:@"preset_2" accountID:currentAccount];
    currentAccount=@"other-account"; DrainRetries();
    Check(a.refreshRequests==2,@"old-account retry cannot refresh another account"); currentAccount=@"selection-account";
#endif
    for (NSString *tabID in @[@"preset_3",@"preset_2",@"preset_1",@"preset_3",@"preset_2"]) {
        a.preferences.selectedTabID=tabID;
        CSGroupPreferences *loaded=[[CSGroupPreferences alloc] initWithDefaults:defaults accountID:currentAccount];
        Check([loaded.selectedTabID isEqual:tabID],@"actual preference writes/readback retain rapid non-first selections");
    }
    [defaults removePersistentDomainForName:suite];
    printf("Group selection stability: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
    return failures ? 1 : 0;
} }
