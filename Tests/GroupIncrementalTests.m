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
@property(nonatomic) NSUInteger fullReloads,layouts;
- (void)reloadData;
- (void)reloadRowsAtIndexPaths:(NSArray *)paths withRowAnimation:(NSInteger)animation;
- (void)layoutIfNeeded;
@end
@implementation UITableView
- (void)reloadData { self.fullReloads++; }
- (void)reloadRowsAtIndexPaths:(NSArray *)paths withRowAnimation:(NSInteger)animation { (void)animation; self.reloaded=paths; }
- (void)layoutIfNeeded { self.layouts++; }
@end
#define UITableViewRowAnimationNone 0
static void CSGroupWithDisplayIndices(id table,void (^body)(void)) { (void)table; body(); }
@interface CSGroupListAdapter : NSObject
@property(nonatomic,strong) UITableView *table;
@property(nonatomic) BOOL projecting,pendingScrollToTop;
@end
@implementation CSGroupListAdapter
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
    [adapter publishProjection:unread previous:old changes:CSGroupChangeUnread previouslyProjecting:YES];
    Check(!table.fullReloads && [table.reloaded isEqual:@[Path(0,0)]],@"stable structure updates only visible changed unread rows");
    table.reloaded=nil;
    [adapter publishProjection:old previous:old changes:CSGroupChangeUnread previouslyProjecting:YES];
    Check(!table.fullReloads && !table.reloaded,@"unchanged values perform no cell reload");
    [adapter publishProjection:old previous:old changes:CSGroupChangeContent previouslyProjecting:YES];
    Check(!table.fullReloads && table.reloaded.count==2,@"preview/draft changes refresh visible cells even when snapshot values match");
    table.reloaded=nil;
    [adapter publishProjection:old previous:old changes:CSGroupChangeUnknown previouslyProjecting:YES];
    Check(table.fullReloads==1,@"unknown native changes retain full reload fallback");
    adapter.pendingScrollToTop=YES;
    [adapter publishProjection:old previous:old changes:CSGroupChangeUnread previouslyProjecting:YES];
    Check(table.fullReloads==2,@"explicit return-to-top keeps the full publication path"); adapter.pendingScrollToTop=NO;
    CSGroupProjection *removed=Build(@[rows[0]],tabs,@"preset_2",NO,@"A",old);
    [adapter publishProjection:removed previous:old changes:CSGroupChangeContent previouslyProjecting:YES];
    Check(table.fullReloads==3,@"structural mismatch overrides even a content-only hint");
    CSGroupRow *banner=[[CSGroupRow alloc] initWithNativePath:Path(0,0) userName:nil kind:CSGroupRowKindBusiness category:CSGroupRowCategoryUnknown top:NO unreadCount:0 redDot:NO];
    CSGroupProjection *business=Build(@[banner],tabs,@"preset_2",NO,@"A",nil);
    [adapter publishProjection:business previous:business changes:CSGroupChangeContent previouslyProjecting:YES];
    Check(table.fullReloads==4,@"business/header-like rows retain native geometry refresh fallback");
    fprintf(stdout,"Group incremental: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
    return failures ? 1 : 0;
} }
