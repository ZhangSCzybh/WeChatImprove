// Complete production proxy/index-scope methods; UIKit geometry and timing are doubles.
#define main CSUnusedSessionFixtureMain
#import "CloseFriendSessionTests.m"
#undef main
#import <CoreGraphics/CoreGraphics.h>
#import <objc/runtime.h>

@interface NSIndexPath (MiniappLayout)
@property(nonatomic,readonly) NSInteger section,row;
@end
@implementation NSIndexPath (MiniappLayout)
- (NSInteger)section { return (NSInteger)[self indexAtPosition:0]; }
- (NSInteger)row { return (NSInteger)[self indexAtPosition:1]; }
@end
@interface UITableViewCell (MiniappLayout)
@property(nonatomic) BOOL hidden;
@end
@implementation UITableViewCell (MiniappLayout)
- (BOOL)hidden { return [objc_getAssociatedObject(self,@selector(hidden)) boolValue]; }
- (void)setHidden:(BOOL)value { objc_setAssociatedObject(self,@selector(hidden),@(value),OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
@end
@interface CSCloseFriendListShield : NSObject
- (void)shieldCell:(UITableViewCell *)cell;
- (void)prepareForPublication;
@end
#include "MiniappShieldBody.h"
@interface TestTable (MiniappLayout)
@property(nonatomic,copy) NSArray<UITableViewCell *> *visibleCells;
@end
@implementation TestTable (MiniappLayout)
- (NSArray *)visibleCells { return objc_getAssociatedObject(self,@selector(visibleCells)); }
- (void)setVisibleCells:(NSArray *)cells { objc_setAssociatedObject(self,@selector(visibleCells),cells,OBJC_ASSOCIATION_COPY_NONATOMIC); }
@end
@interface CSGroupListAdapter (MiniappLayout)
@property(nonatomic,strong) CSCloseFriendListShield *privacyShield;
@property(nonatomic) BOOL privacyRefreshPending,sessionLayoutHeld;
@property(nonatomic,readonly) NSUInteger layoutRequests;
@property(nonatomic) NSUInteger snapshotEpoch;
+ (instancetype)adapterForTable:(id)table;
- (void)requestRefresh;
- (void)performSessionListLayout:(void (^)(void))layout;
- (void)finishPublicationFixture;
- (void)shieldVisiblePrivateRows;
@end
static CSGroupListAdapter *layoutAdapter;
@implementation CSGroupListAdapter (MiniappLayout)
+ (instancetype)adapterForTable:(id)table { return layoutAdapter.table==table ? layoutAdapter : nil; }
- (CSCloseFriendListShield *)privacyShield { return objc_getAssociatedObject(self,@selector(privacyShield)); }
- (void)setPrivacyShield:(CSCloseFriendListShield *)shield { objc_setAssociatedObject(self,@selector(privacyShield),shield,OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
- (BOOL)privacyRefreshPending { return [objc_getAssociatedObject(self,@selector(privacyRefreshPending)) boolValue]; }
- (void)setPrivacyRefreshPending:(BOOL)value { objc_setAssociatedObject(self,@selector(privacyRefreshPending),@(value),OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
- (BOOL)sessionLayoutHeld { return [objc_getAssociatedObject(self,@selector(sessionLayoutHeld)) boolValue]; }
- (void)setSessionLayoutHeld:(BOOL)value { objc_setAssociatedObject(self,@selector(sessionLayoutHeld),@(value),OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
- (NSUInteger)snapshotEpoch { return [objc_getAssociatedObject(self,@selector(snapshotEpoch)) unsignedIntegerValue]; }
- (void)setSnapshotEpoch:(NSUInteger)value { objc_setAssociatedObject(self,@selector(snapshotEpoch),@(value),OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
- (NSUInteger)layoutRequests { return [objc_getAssociatedObject(self,@selector(layoutRequests)) unsignedIntegerValue]; }
- (void)requestRefresh { objc_setAssociatedObject(self,@selector(layoutRequests),@(self.layoutRequests+1),OBJC_ASSOCIATION_RETAIN_NONATOMIC); self.dirty=YES; }
#include "MiniappLayoutBody.h"
#include "MiniappPublicationRelease.h"
- (void)shieldVisiblePrivateRows { for(UITableViewCell *cell in self.table.visibleCells)[self.privacyShield shieldCell:cell]; }
@end
#define UITableView TestTable
#include "MiniappCardPosition.h"
#undef UITableView

@interface MainFrameTableView : TestTable
@property(nonatomic) NSUInteger layouts,rawPrivateCells,offsetWrites,reloads;
@property(nonatomic) CGPoint contentOffset;
@property(nonatomic,strong) NSMutableArray *offsetTrajectory;
- (void)setContentOffset:(CGPoint)point animated:(BOOL)animated;
- (void)reloadData;
@property(nonatomic,strong) NSArray *captured;
@property(nonatomic,copy) void (^onCapture)(void);
- (void)captureLayout;
- (void)layoutSubviews;
@end
static void Query(CSGroupListAdapter *a,NativeHost *host,SEL selector,NSInteger section,NSInteger *result) {
    NSInvocation *inv=[NSInvocation invocationWithMethodSignature:[host methodSignatureForSelector:selector]];
    inv.selector=selector; id table=a.table; [inv setArgument:&table atIndex:2];
    if([NSStringFromSelector(selector) containsString:@"numberOfRows"])[inv setArgument:&section atIndex:3];
    [a forwardInvocation:inv target:host]; [inv getReturnValue:result];
}
@implementation MainFrameTableView
@synthesize contentOffset=_contentOffset;
- (void)setContentOffset:(CGPoint)point {
    _contentOffset=point;self.offsetWrites++;
    if(!self.offsetTrajectory)self.offsetTrajectory=[NSMutableArray array];
    [self.offsetTrajectory addObject:@{@"x":@(point.x),@"y":@(point.y)}];
}
- (void)setContentOffset:(CGPoint)point animated:(BOOL)animated { (void)animated;self.contentOffset=point; }
- (void)reloadData { self.reloads++; }
#include "MiniappTableLayoutHook.h"
- (void)captureLayout {
    self.layouts++; CSGroupListAdapter *a=layoutAdapter; NativeHost *host=a.controller;
    NSInteger sectionCount=0; Query(a,host,@selector(numberOfSectionsInTableView:),0,&sectionCount);
    NSMutableArray *result=[NSMutableArray array],*cells=[NSMutableArray array]; CGFloat y=0;
    for(NSInteger s=0;s<sectionCount;s++) {
        NSInteger rowCount=0; Query(a,host,@selector(tableView:numberOfRowsInSection:),s,&rowCount);
        for(NSInteger r=0;r<rowCount;r++) {
            NSUInteger indexes[]={(NSUInteger)s,(NSUInteger)r}; NSIndexPath *path=[NSIndexPath indexPathWithIndexes:indexes length:2];
            host.nativeCell=[UITableViewCell new]; host.rendered=nil;
            UITableViewCell *cell=[a cellForDisplayPath:path target:host]; [cells addObject:cell];
            NSString *name=host.rendered ? [(NativeSession *)[host getSessionInfoAtIndexPath:host.rendered] m_nsUserName] : @"placeholder";
            BOOL first=NO,last=NO; CSGroupCardPosition(self,path,&first,&last);
            if([policy hidesUserName:name surface:CSCloseFriendSurfaceSession])self.rawPrivateCells++;
            [result addObject:@{@"name":name?:@"",@"section":@(s),@"row":@(r),@"y":@(y),@"first":@(first),@"last":@(last),@"offset":@(self.contentOffset.y)}];
            y+=64;
        }
        y+=16;
    }
    self.visibleCells=cells; self.captured=result;
    if(self.onCapture)self.onCapture();
}
@end
static CSGroupListAdapter *MiniappList(BOOL revealed) {
    NativeHost *host=[NativeHost new]; host.sessions=[NSMutableArray array];
    for(NSString *name in @[@"ordinary-A",@"private-person",@"ordinary-B",@"private-group-A",@"private-group-B",@"ordinary-C",@"ordinary-D"])
        [host.sessions addObject:FoldedSession(name,0)];
    MainFrameTableView *table=[MainFrameTableView new];table.contentOffset=CGPointMake(0,128); host.m_tableView=table;table.offsetWrites=0;[table.offsetTrajectory removeAllObjects];
    CSGroupListAdapter *a=[CSGroupListAdapter new];a.controller=host;a.table=table;a.preferences=[Preferences new];a.prefetchedPaths=[NSMutableSet set];
    policy=Policy(@[@"private-person",@"private-group-A",@"private-group-B"],revealed,2);layoutAdapter=a;groupEnabled=NO;[a refresh];a.snapshotEpoch=epoch;return a;
}
int main(void) { @autoreleasepool {
    MainFrameTableView *counterControl=[MainFrameTableView new];
    counterControl.contentOffset=CGPointMake(0,20);
    [counterControl setContentOffset:CGPointMake(0,60) animated:NO];[counterControl reloadData];
    Check(counterControl.offsetWrites==2 && [counterControl.offsetTrajectory isEqual:@[@{@"x":@0,@"y":@20},@{@"x":@0,@"y":@60}]],@"counter control captures direct and animated offset writes and their trajectory");
    Check(counterControl.reloads==1,@"counter control detects a whole-table reload");
    counterControl.offsetWrites=0;counterControl.reloads=0;[counterControl.offsetTrajectory removeAllObjects];
    Check(!counterControl.offsetWrites && !counterControl.reloads && !counterControl.offsetTrajectory.count,@"counter control resets before return-path measurements");
    for(NSUInteger revealed=0;revealed<2;revealed++) {
        CSGroupListAdapter *a=MiniappList(revealed);MainFrameTableView *table=(id)a.table;
        [table layoutSubviews];NSArray *stable=table.captured;NSUInteger stableLayouts=table.layouts;
        CSGroupWithNativeIndices(table,^{ [table layoutSubviews]; });
        NSData *record=[NSJSONSerialization dataWithJSONObject:@{@"revealed":@(revealed),@"stable":stable,@"first":table.captured,@"nativePrivateDeliveries":@(table.rawPrivateCells),@"contentLayouts":@(table.layouts),@"offsetWrites":@(table.offsetWrites),@"offsetTrajectory":table.offsetTrajectory?:@[],@"fullReloads":@(table.reloads)} options:NSJSONWritingSortedKeys error:NULL];
        fprintf(stdout,"LAYOUT %s\n",[[[NSString alloc]initWithData:record encoding:NSUTF8StringEncoding] UTF8String]);
        Check(table.layouts==stableLayouts+1,@"container return without appear callbacks performs one content layout");
        Check([table.captured isEqual:stable],@"first exposed sections, row identities/y, card first/last and offset equal filtered stable layout");
        Check(table.rawPrivateCells==0,@"first exposed miniapp return layout never asks native cells for hidden sessions");
        Check(table.captured.count==(revealed?7:4),@"locked/unlocked visible row membership is unchanged");
        Check(table.contentOffset.y==128 && table.offsetWrites==0,@"miniapp layout boundary preserves scroll position without rebound");
        Check(table.reloads==0,@"miniapp layout boundary performs no full-table reload");
        for(NSDictionary *row in stable) {
            Check([row[@"first"] boolValue]==([row[@"row"] integerValue]==0),@"first visible frame card first-row flag matches stable section");
            Check([row[@"last"] boolValue]==([row[@"row"] integerValue]==(NSInteger)table.captured.count-1),@"first visible frame card last-row flag matches stable section");
        }
    }
    CSGroupListAdapter *a=MiniappList(NO);MainFrameTableView *table=(id)a.table;[table layoutSubviews];NSUInteger before=table.layouts;
    policy=[[CSCloseFriendSnapshot alloc]initWithAccountID:account profile:@{} revealed:NO revision:3 blocked:YES];
    CSGroupWithNativeIndices(table,^{[table layoutSubviews];});
    Check(table.layouts==before,@"late policy readiness does not publish a native/unfiltered layout");
    Check(table.rawPrivateCells==0,@"late policy readiness exposes zero protected native cells");
    Check(table.visibleCells.count==4 && [table.visibleCells filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UITableViewCell *cell,NSDictionary *bindings){(void)bindings;return !cell.hidden;}]].count==0,@"unready content is coherently neutral without partial hidden-row holes");
    Check(table.contentOffset.y==128 && table.offsetWrites==0,@"unready boundary leaves saved filtered scroll geometry untouched");
    Check(a.layoutRequests==0 && a.privacyRefreshPending,@"blocked policy waits for its readiness event without polling or an invented delay");
    policy=Policy(@[@"private-person",@"private-group-A",@"private-group-B"],NO,4);[a refresh];[a.privacyShield prepareForPublication];
    CSGroupWithNativeIndices(table,^{[table layoutSubviews];});
    Check(table.captured.count==4 && !table.rawPrivateCells,@"ready policy resumes first content directly in filtered coordinates");
    // A lock arriving after an unlocked projection must not use its old row geometry.
    a=MiniappList(YES);table=(id)a.table;[table layoutSubviews];before=table.layouts;
    policy=Policy(@[@"private-person",@"private-group-A",@"private-group-B"],NO,5);
    CSGroupWithNativeIndices(table,^{[table layoutSubviews];});
    Check(table.layouts==before,@"new lock refuses stale unlocked projection before any content layout");
    Check([table.visibleCells filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UITableViewCell *cell,NSDictionary *bindings){(void)bindings;return !cell.hidden;}]].count==0,@"new lock neutralizes all old content until filtered projection is ready");
    // Reentry while baseline refresh owns publication must not request recovery.
    for(NSUInteger depth=0;depth<2;depth++) {
        a=MiniappList(YES);table=(id)a.table;[table layoutSubviews];before=table.layouts;
        policy=Policy(@[@"private-person",@"private-group-A",@"private-group-B"],NO,6+depth);
        a.publishing=depth==0;a.changeDepth=depth;
        CSGroupWithNativeIndices(table,^{
            [table layoutSubviews];
            Check(CSGroupUsesNativeIndices(table),@"unsafe return restores caller native scope");
        });
        Check(!CSGroupUsesNativeIndices(table),@"unsafe return restores outer display scope");
        Check(table.layouts==before && a.sessionLayoutHeld && !a.layoutRequests,@"publishing/transaction reentry holds unsafe content without recursively refreshing");
        [a finishPublicationFixture];
        Check([table.visibleCells filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UITableViewCell *cell,NSDictionary *bindings){(void)bindings;return !cell.hidden;}]].count==0,@"baseline refresh completion cannot release a held stale cell set");
        a.publishing=NO;a.changeDepth=0;[a refresh];
        CSGroupWithNativeIndices(table,^{
            [table layoutSubviews];
            Check(CSGroupUsesNativeIndices(table),@"safe return restores caller native scope");
        });
        Check(!a.sessionLayoutHeld && table.captured.count==4 && !table.rawPrivateCells,@"ready publication closes held boundary using filtered content");
        Check(table.contentOffset.y==128 && !table.offsetWrites && !table.reloads,@"reentry preserves viewport and adds no whole-table reload");
    }
    a=MiniappList(NO);table=(id)a.table;a.publishing=YES;a.changeDepth=1;
    CSGroupWithNativeIndices(table,^{[table layoutSubviews];});
    Check(table.layouts==1 && table.captured.count==4 && !a.sessionLayoutHeld && !a.layoutRequests,@"safe layout inside publication/native transaction needs no refresh or geometry rebuild");
    __block BOOL threw=NO;
    CSGroupWithNativeIndices(table,^{
        @try {[a performSessionListLayout:^{[NSException raise:@"fixture-layout" format:@"interrupted"]; }];}
        @catch(NSException *exception){threw=[exception.name isEqual:@"fixture-layout"];}
        Check(CSGroupUsesNativeIndices(table),@"throwing original layout restores native scope in finally");
    });
    Check(threw && !CSGroupUsesNativeIndices(table),@"throwing layout preserves exception and restores outer scope");
    a=MiniappList(NO);table=(id)a.table;
    table.onCapture=^{policy=[[CSCloseFriendSnapshot alloc]initWithAccountID:account profile:@{} revealed:NO revision:99 blocked:YES];};
    CSGroupWithNativeIndices(table,^{[table layoutSubviews];});
    Check(a.sessionLayoutHeld && !table.rawPrivateCells,@"policy invalidation from original layout cannot release old content");
    Check([table.visibleCells filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UITableViewCell *cell,NSDictionary *bindings){(void)bindings;return !cell.hidden;}]].count==0,@"policy invalidation inside native layout neutralizes all delivered content before returning");
    // Ready policy revision alone is insufficient if the old aggregate digest was built earlier.
    a=MiniappList(NO);table=(id)a.table;[table layoutSubviews];before=table.layouts;
    policy=Policy(@[@"private-person",@"private-group-A",@"private-group-B",@"digest-only-secret"],NO,100);
    CSGroupWithNativeIndices(table,^{[table layoutSubviews];});
    Check(table.layouts==before && a.sessionLayoutHeld && a.layoutRequests==1,@"stale projection privacy revision holds aggregate digest and geometry until rebuilt");
    // Turning both grouping and protection off must release a prior held native list.
    a.projection=nil;policy=[[CSCloseFriendSnapshot alloc]initWithAccountID:account profile:@{@"enabled":@NO,@"friends":@[],@"groups":@[],@"options":@{}} revealed:NO revision:101 blocked:NO];
    [a performSessionListLayout:^{}];
    Check(!a.sessionLayoutHeld && [table.visibleCells filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UITableViewCell *cell,NSDictionary *bindings){(void)bindings;return cell.hidden;}]].count==0,@"native presentation after disabling protection releases held cells");
    // Native original may synchronously publish an entirely newer safe projection.
    a=MiniappList(NO);table=(id)a.table;
    __block BOOL changedInside=NO;
    table.onCapture=^{if(!changedInside){changedInside=YES;policy=Policy(@[@"private-person",@"private-group-A",@"private-group-B"],NO,102);[layoutAdapter refresh];}};
    CSGroupWithNativeIndices(table,^{[table layoutSubviews];});
    Check(a.sessionLayoutHeld && a.layoutRequests==1 && a.dirty,@"policy publication during original layout records exactly one event-driven recovery");
    table.onCapture=nil;[a refresh];
    CSGroupWithNativeIndices(table,^{[table layoutSubviews];});
    Check(!a.sessionLayoutHeld && table.captured.count==4 && !table.rawPrivateCells,@"event-driven publication closes post-layout token-change hold");
    a=MiniappList(NO);table=(id)a.table;[table layoutSubviews];before=table.layouts;
    policy=[[CSCloseFriendSnapshot alloc]initWithAccountID:account profile:@{} revealed:NO revision:103 blocked:YES];[a refresh];
    Check(a.projection.isValid && !a.projection.sections.firstObject.count,@"blocked policy fixture carries the baseline valid empty projection");
    policy=Policy(@[@"private-person",@"private-group-A",@"private-group-B"],NO,104);
    CSGroupWithNativeIndices(table,^{[table layoutSubviews];});
    Check(table.layouts==before && table.contentOffset.y==128 && !table.offsetWrites,@"ready policy cannot lay out the old blocked empty projection or clamp its viewport");
    a=MiniappList(NO);table=(id)a.table;[table layoutSubviews];before=table.layouts;epoch++;
    CSGroupWithNativeIndices(table,^{[table layoutSubviews];});
    Check(table.layouts==before && a.sessionLayoutHeld,@"same-account old epoch projection cannot lay out even with unchanged policy revision");
    a=MiniappList(NO);table=(id)a.table;[table layoutSubviews];before=table.layouts;a.snapshotRetryAttempted=YES;
    CSGroupWithNativeIndices(table,^{[table layoutSubviews];});
    Check(table.layouts==before && a.sessionLayoutHeld,@"snapshot retry placeholder cannot be mistaken for a ready content projection");
    printf("Miniapp private layout: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
    return failures?1:0;
} }
