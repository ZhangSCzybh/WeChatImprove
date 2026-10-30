#import <Foundation/Foundation.h>
#import "CSGroupProjection.h"
#import "CSGroupRefreshState.h"
#import "WESessionTabItem.h"

static NSUInteger checks,failures;
static void Check(BOOL yes,NSString *message) { checks++; if (!yes) { failures++; fprintf(stderr,"FAIL: %s\n",message.UTF8String); } }
static NSIndexPath *Path(NSUInteger s,NSUInteger r) { NSUInteger v[]={s,r}; return [NSIndexPath indexPathWithIndexes:v length:2]; }
static CSGroupRow *Row(NSString *name,NSUInteger r,NSUInteger unread,CSGroupRowCategory category) {
    return [[CSGroupRow alloc] initWithNativePath:Path(0,r) userName:name kind:CSGroupRowKindSession category:category top:NO unreadCount:unread redDot:NO];
}
static CSGroupProjection *Build(NSArray *rows,NSArray *tabs,NSString *selected,BOOL filter,NSString *account,CSGroupProjection *previous) {
    return [[CSGroupProjection alloc] initWithSections:@[rows] tabs:tabs selectedTabID:selected filterDuplicates:filter accountID:account previousProjection:previous];
}
static NSDictionary *Values(CSGroupProjection *p,NSArray *tabs) {
    NSMutableArray *sections=[NSMutableArray array];
    for (NSArray *rows in p.sections) {
        NSMutableArray *values=[NSMutableArray array];
        for (CSGroupRow *r in rows) [values addObject:@[r.userName ?: @"",r.nativePath,@(r.kind),@(r.category),@(r.top),@(r.unreadCount),@(r.redDot),[p displayPathForNativePath:r.nativePath] ?: NSNull.null]];
        [sections addObject:values];
    }
    NSMutableDictionary *badges=[NSMutableDictionary dictionary];
    for (WESessionTabItem *tab in tabs) { CSGroupBadge *b=[p badgeForTabID:tab.tabId]; badges[tab.tabId]=@[@(b.count),@(b.redDot)]; }
    return @{@"valid":@(p.valid),@"account":p.accountID,@"sections":sections,@"badges":badges};
}
@interface UITableView : NSObject
@property(nonatomic,copy) NSArray *indexPathsForVisibleRows,*reloaded;
@property(nonatomic) NSUInteger fullReloads,layouts,rowReloads;
- (void)reloadData;
- (void)reloadRowsAtIndexPaths:(NSArray *)paths withRowAnimation:(NSInteger)animation;
- (void)layoutIfNeeded;
@end
@implementation UITableView
- (void)reloadData { self.fullReloads++; }
- (void)reloadRowsAtIndexPaths:(NSArray *)paths withRowAnimation:(NSInteger)animation { (void)animation; self.rowReloads++; self.reloaded=paths; }
- (void)layoutIfNeeded { self.layouts++; }
@end
#define UITableViewRowAnimationNone 0
static void CSGroupWithDisplayIndices(id table,void (^body)(void)) { (void)table; body(); }
@interface CSGroupListAdapter : NSObject
@property(nonatomic,strong) UITableView *table;
@property(nonatomic) BOOL projecting,pendingScrollToTop,publicationNeedsFullReload;
- (void)recordRefreshEvent:(NSString *)event delay:(NSTimeInterval)delay;
@end
@implementation CSGroupListAdapter
- (void)recordRefreshEvent:(NSString *)event delay:(NSTimeInterval)delay { (void)event; (void)delay; }
#include "GroupPublicationBody.h"
@end
int main(void) { @autoreleasepool {
    NSMutableArray *tabs=[NSMutableArray array];
    for (NSUInteger t=0;t<4;t++) [tabs addObject:[WESessionTabItem tabWithType:(WETabType)t]];
    WESessionTabItem *custom=[WESessionTabItem customTabWithName:@"工作" sessionUserNames:@[@"a",@"c"]]; custom.tabId=@"custom"; [tabs addObject:custom];
    NSArray *rows=@[Row(@"a",0,1,CSGroupRowCategoryPrivate),Row(@"b",1,2,CSGroupRowCategoryGroup),Row(@"c",2,0,CSGroupRowCategoryPrivate)];
    CSGroupProjection *old=Build(rows,tabs,@"preset_2",NO,@"A",nil);
    CSGroupProjection *same=Build(rows,tabs,@"preset_2",NO,@"A",old);
    Check(same==old,@"unchanged values return the existing calculation result");
    NSArray *changed=@[Row(@"a",0,3,CSGroupRowCategoryPrivate),rows[1],rows[2]];
    CSGroupProjection *unread=Build(changed,tabs,@"preset_2",NO,@"A",old);
    Check(unread!=old && [unread hasSameDisplayStructureAs:old],@"unread change preserves verified structure but updates row values");
    Check([unread valueForKey:@"memberTabIDs"]==[old valueForKey:@"memberTabIDs"],@"unread updates reuse validated member index");
    Check([unread valueForKey:@"destinationsByPath"]==[old valueForKey:@"destinationsByPath"],@"unread updates reuse validated group destinations");
    Check([unread valueForKey:@"displayToNative"]==[old valueForKey:@"displayToNative"],@"unread-only changes reuse verified display indices");
    Check([unread valueForKey:@"nativeToDisplay"]==[old valueForKey:@"nativeToDisplay"],@"unread-only changes reuse verified native indices");
    Check([[unread changedUnreadPathsFrom:old] isEqual:@[Path(0,0)]],@"only the changed displayed unread row is invalidated");
    CSGroupProjection *selected=Build(changed,tabs,@"custom",NO,@"A",unread);
    Check([selected badgeForTabID:@"custom"]==[unread badgeForTabID:@"custom"],@"selection-only publication reuses computed badges");
    CSGroupProjection *cross=Build(changed,tabs,@"custom",NO,@"B",selected);
    Check([cross valueForKey:@"memberTabIDs"]!=[selected valueForKey:@"memberTabIDs"],@"member cache cannot cross accounts");
    [selected discardComputationCache];
    Check(![selected valueForKey:@"inputSections"] && ![selected valueForKey:@"destinationsByPath"],@"suspension releases the full-list computation cache");
    Check([Values(Build(changed,tabs,@"custom",NO,@"A",selected),tabs) isEqual:Values(Build(changed,tabs,@"custom",NO,@"A",nil),tabs)],@"cache eviction preserves reconstruction semantics");
    custom.sessionUserNames=@[@"b"];
    CSGroupProjection *edited=Build(changed,tabs,@"custom",NO,@"A",unread);
    Check(edited.sections[0].count==1 && [[edited.sections[0][0] userName] isEqual:@"b"],@"editing members on the same tab objects invalidates cached membership");
    custom.sessionUserNames=@[@"a",@"c"];
    CSGroupProjection *previous=nil;
    for (NSUInteger step=0;step<160;step++) {
        NSMutableArray *data=[NSMutableArray array]; NSUInteger n=8+(step/19)%4;
        for (NSUInteger r=0;r<n;r++) {
            NSUInteger identity=(r+(step/11))%n;
            NSString *name=[NSString stringWithFormat:@"n%lu",(unsigned long)identity];
            CSGroupRowKind kind=r==n-1 ? CSGroupRowKindAggregate : CSGroupRowKindSession;
            CSGroupRowCategory cat=(CSGroupRowCategory)((identity+step/23)%4);
            [data addObject:[[CSGroupRow alloc] initWithNativePath:Path(0,r) userName:name kind:kind category:cat top:r==0 unreadCount:(identity+step)%9 redDot:((identity+step)%5)==0]];
        }
        custom.sessionUserNames=step%13<6 ? @[@"n0",@"n2",@"n4"] : @[@"n1",@"n3",@"n5"];
        NSString *chosen=[tabs[(step/7)%tabs.count] tabId], *account=step<80 ? @"A" : @"B";
        BOOL filter=(step/17)%2;
        CSGroupProjection *cached=Build(data,tabs,chosen,filter,account,previous);
        CSGroupProjection *cold=Build(data,tabs,chosen,filter,account,nil);
        Check([Values(cached,tabs) isEqual:Values(cold,tabs)],@"cached and cold projections agree across order/membership/filter/account/unread mutations");
        previous=cached;
    }
    custom.sessionUserNames=@[@"a",@"c"];
    CSGroupProjection *invalid=Build(@[rows[0],rows[0]],tabs,@"preset_2",NO,@"A",old);
    Check(!invalid.valid,@"cached projection still rejects duplicate/invalid coordinates");

    CSGroupListAdapter *adapter=[CSGroupListAdapter new]; adapter.projecting=YES;
    UITableView *table=[UITableView new]; adapter.table=table; table.indexPathsForVisibleRows=@[Path(0,0),Path(0,1)];
    [adapter publishProjection:unread previous:old changes:CSGroupChangeUnread contentUserNames:nil contentIdentityKnown:NO previouslyProjecting:YES];
    Check(!table.fullReloads && [table.reloaded isEqual:@[Path(0,0)]],@"stable structure updates only visible changed unread rows");
    Check(!table.layouts,@"ordinary unread rows do not force synchronous layout");
    table.reloaded=nil;
    NSUInteger rowReloads=table.rowReloads;
    [adapter publishProjection:old previous:old changes:CSGroupChangeUnread contentUserNames:nil contentIdentityKnown:NO previouslyProjecting:YES];
    Check(!table.fullReloads && !table.reloaded && table.rowReloads==rowReloads && !table.layouts,@"unchanged values perform zero table operations");
    [adapter publishProjection:old previous:old changes:CSGroupChangeContent contentUserNames:[NSSet setWithObject:@"a"] contentIdentityKnown:YES previouslyProjecting:YES];
    Check([table.reloaded isEqual:@[Path(0,0)]] && !table.layouts,@"same-snapshot known preview/draft content refreshes only its session without layout");
    table.reloaded=nil;
    [adapter publishProjection:old previous:old changes:CSGroupChangeContent contentUserNames:[NSSet setWithObject:@"b"] contentIdentityKnown:YES previouslyProjecting:YES];
    Check(!table.reloaded && !table.fullReloads && !table.layouts,@"known content outside the selected group leaves displayed rows alone");
    [adapter publishProjection:old previous:old changes:CSGroupChangeContent contentUserNames:nil contentIdentityKnown:NO previouslyProjecting:YES];
    Check(!table.fullReloads && table.reloaded.count==2,@"preview/draft changes refresh visible cells even when snapshot values match");
    table.reloaded=nil;
    rowReloads=table.rowReloads;
    [adapter publishProjection:old previous:old changes:CSGroupChangeUnknown contentUserNames:nil contentIdentityKnown:NO previouslyProjecting:YES];
    Check(!table.fullReloads && !table.reloaded && table.rowReloads==rowReloads && !table.layouts,@"unknown-only feedback with verified unchanged metadata settles without table work");
    adapter.pendingScrollToTop=YES;
    [adapter publishProjection:old previous:old changes:CSGroupChangeUnread contentUserNames:nil contentIdentityKnown:NO previouslyProjecting:YES];
    Check(table.fullReloads==1 && table.layouts==1,@"explicit return-to-top keeps the full publication path"); adapter.pendingScrollToTop=NO;
    CSGroupProjection *removed=Build(@[rows[0]],tabs,@"preset_2",NO,@"A",old);
    [adapter publishProjection:removed previous:old changes:CSGroupChangeContent contentUserNames:[NSSet setWithObject:@"a"] contentIdentityKnown:YES previouslyProjecting:YES];
    Check(table.fullReloads==2 && table.layouts==2,@"structural mismatch overrides even a targeted content hint");
    CSGroupRow *banner=[[CSGroupRow alloc] initWithNativePath:Path(0,0) userName:nil kind:CSGroupRowKindBusiness category:CSGroupRowCategoryUnknown top:NO unreadCount:0 redDot:NO];
    CSGroupProjection *business=Build(@[banner],tabs,@"preset_2",NO,@"A",nil);
    rowReloads=table.rowReloads;
    [adapter publishProjection:business previous:business changes:CSGroupChangeUnknown contentUserNames:nil contentIdentityKnown:NO previouslyProjecting:YES];
    Check(table.fullReloads==2 && table.layouts==2 && table.rowReloads==rowReloads,@"unchanged anonymous business rows no longer force full reload or layout");
    [adapter publishProjection:business previous:business changes:CSGroupChangeContent contentUserNames:nil contentIdentityKnown:NO previouslyProjecting:YES];
    Check(table.fullReloads==2 && table.layouts==3 && [table.reloaded isEqual:@[Path(0,0)]],@"unattributed business content refreshes its row and native geometry");
    CSGroupRow *changedBanner=[[CSGroupRow alloc] initWithNativePath:Path(0,0) userName:nil kind:CSGroupRowKindBusiness category:CSGroupRowCategoryUnknown top:NO unreadCount:0 redDot:NO nativeSummary:@"changed banner" sortTime:nil];
    CSGroupProjection *changedBusiness=Build(@[changedBanner],tabs,@"preset_2",NO,@"A",business);
    table.indexPathsForVisibleRows=@[];
    [adapter publishProjection:changedBusiness previous:business changes:CSGroupChangeUnknown contentUserNames:nil contentIdentityKnown:NO previouslyProjecting:YES];
    Check(table.fullReloads==2 && table.layouts==4 && [table.reloaded isEqual:@[Path(0,0)]],@"changed offscreen special geometry updates its verified row height");
    CSGroupProjection *privateRevision=[[CSGroupProjection alloc] initWithSections:@[@[banner]] tabs:tabs selectedTabID:@"preset_2" filterDuplicates:NO accountID:@"A" hiddenUserNames:NSSet.set privacyRevision:1 previousProjection:business];
    [adapter publishProjection:privateRevision previous:business changes:CSGroupChangeUnknown contentUserNames:nil contentIdentityKnown:NO previouslyProjecting:YES];
    Check(table.fullReloads==3 && table.layouts==5,@"privacy revision changes keep full publication semantics");
    adapter.publicationNeedsFullReload=YES;
    [adapter publishProjection:business previous:business changes:CSGroupChangeUnknown contentUserNames:nil contentIdentityKnown:NO previouslyProjecting:YES];
    Check(table.fullReloads==4 && table.layouts==6 && !adapter.publicationNeedsFullReload,@"a stale aborted publication forces one complete table synchronization before clearing its guard");
    fprintf(stdout,"Group incremental: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
    return failures ? 1 : 0;
} }
