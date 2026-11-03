#import <Foundation/Foundation.h>
#import "CSGroupNativeModel.h"
#import "CSGroupProjection.h"
#import "WESessionTabItem.h"

// This is a host-side workload over real production model/projection code.
// PerfSession supplies the unavailable host's copied session metadata only.
@interface PerfSession:NSObject
@property(nonatomic,copy) NSString *name;
@property(nonatomic) NSUInteger unread;
@property(nonatomic) BOOL top;
@property(nonatomic) CSGroupRowCategory category;
@end
@implementation PerfSession @end
#if CS_PERF_INCREMENTAL
@interface CSGroupNativeModel (PerfAPI)
+ (CSGroupNativeModelResult *)modelByUpdatingResult:(CSGroupNativeModelResult *)previous
                                 changedUserNames:(NSSet<NSString *> *)changedUserNames
                                      rowProvider:(CSGroupNativeRowProvider)rowProvider;
@end
#endif
static NSUInteger Reads;
static CSGroupRow *ReadRow(PerfSession *session,NSIndexPath *path,BOOL top) {
    Reads++;
    return [[CSGroupRow alloc] initWithNativePath:path userName:session.name kind:CSGroupRowKindSession
        category:session.category top:top unreadCount:session.unread redDot:NO];
}
static CSGroupNativeModelResult *Build(NSArray *top,NSArray *normal,NSArray *all,NSArray *tabs) {
    return [CSGroupNativeModel buildWithTopSessions:top normalSessions:normal allTopSessions:top allSessions:all tabs:tabs
        selectedTabID:@"preset_0" groupingEnabled:YES filterDuplicates:NO accountID:@"cpu-benchmark-account"
        hiddenUserNames:NSSet.set privacyRevision:1 scopeFoldedEntry:NO foldedRows:nil
        rowProvider:^CSGroupRow *(id object,NSIndexPath *path,BOOL isTop) {return ReadRow(object,path,isTop);}];
}
static void Require(BOOL accepted,NSString *reason) {
    if(!accepted) {fprintf(stderr,"Benchmark failed: %s\n",reason.UTF8String);exit(1);}
}
int main(void) { @autoreleasepool {
    const NSUInteger count=1200,groupCount=24,updates=120,rounds=5;
    NSMutableArray *all=[NSMutableArray array],*top=[NSMutableArray array],*normal=[NSMutableArray array];
    NSMutableArray *tabs=[NSMutableArray arrayWithArray:@[[WESessionTabItem tabWithType:WETabTypeAll],
        [WESessionTabItem tabWithType:WETabTypeGroup],[WESessionTabItem tabWithType:WETabTypePrivate],
        [WESessionTabItem tabWithType:WETabTypeOfficial]]];
    for(NSUInteger i=0;i<count;i++) {
        PerfSession *session=[PerfSession new];session.name=[NSString stringWithFormat:@"perf_%04lu%@",(unsigned long)i,i%3==0?@"@chatroom":@""];
        session.top=i<32;session.unread=i%10;session.category=i%3==0?CSGroupRowCategoryGroup:CSGroupRowCategoryPrivate;
        [all addObject:session];[(session.top?top:normal) addObject:session];
    }
    for(NSUInteger group=0;group<groupCount;group++) {
        NSMutableArray *names=[NSMutableArray array];
        for(NSUInteger i=0;i<count;i++) if(i%24==group || i%37==group) [names addObject:[all[i] name]];
        WESessionTabItem *tab=[WESessionTabItem customTabWithName:[NSString stringWithFormat:@"custom %lu",(unsigned long)group] sessionUserNames:names];
        tab.tabId=[NSString stringWithFormat:@"benchmark_custom_%lu",(unsigned long)group];[tabs addObject:tab];
    }
    NSMutableArray *times=[NSMutableArray array],*readsPerRound=[NSMutableArray array];
    NSMutableDictionary *fingerprint=[NSMutableDictionary dictionary];
    for(NSUInteger round=0;round<rounds;round++) { @autoreleasepool {
        for(NSUInteger i=0;i<count;i++) [all[i] setUnread:i%10];
        Reads=0;CSGroupNativeModelResult *model=Build(top,normal,all,tabs);
        Require(model.isValid,@"initial model must be valid");
        NSUInteger initialReads=Reads;Require(initialReads==count,@"all initial metadata must be read");Reads=0;
        NSTimeInterval started=NSProcessInfo.processInfo.systemUptime;
        for(NSUInteger update=0;update<updates;update++) { @autoreleasepool {
            PerfSession *session=all[(update*17)%count];session.unread++;
#if CS_PERF_INCREMENTAL
            model=[CSGroupNativeModel modelByUpdatingResult:model changedUserNames:[NSSet setWithObject:session.name]
                rowProvider:^CSGroupRow *(id object,NSIndexPath *path,BOOL isTop) {return ReadRow(object,path,isTop);}];
#else
            model=Build(top,normal,all,tabs);
#endif
            Require(model.isValid,@"every updated model must remain valid");
        }}
        NSTimeInterval elapsed=NSProcessInfo.processInfo.systemUptime-started;
        [times addObject:@(elapsed*1000.0/updates)];[readsPerRound addObject:@(Reads)];
        NSUInteger expected=0;for(PerfSession *session in all)expected+=session.unread;
        Require([model.projection badgeForTabID:@"preset_0"].count==expected,@"All badge must equal actual complete input");
        Require(model.sourceRows.count==count && model.normalSessions.count==normal.count && model.topSessions.count==top.count,@"native source remains complete");
        for(WESessionTabItem *tab in tabs) {
            CSGroupBadge *badge=[model.projection badgeForTabID:tab.tabId];
            fingerprint[tab.tabId]=@[@(badge.count),@(badge.redDot),@([model.projection sessionCountForTabID:tab.tabId])];
        }
    }}
    NSArray *ordered=[times sortedArrayUsingSelector:@selector(compare:)];
    NSDictionary *result=@{@"implementation":CS_PERF_INCREMENTAL?@"incremental":@"2.2-7-full-build",
        @"sessions":@(count),@"custom_groups":@(groupCount),@"updates_per_round":@(updates),@"rounds":@(rounds),
        @"metadata_reads_per_round":readsPerRound,@"milliseconds_per_update_each_round":times,
        @"median_milliseconds_per_update":ordered[ordered.count/2],@"final_projection_fingerprint":fingerprint,
        @"scope":@"macOS host wall time; real production native model + projection; controlled session row provider; excludes UIKit/device CPU, source capture, bridge and coordinator"};
    NSData *json=[NSJSONSerialization dataWithJSONObject:result options:NSJSONWritingPrettyPrinted|NSJSONWritingSortedKeys error:nil];
    fwrite(json.bytes,1,json.length,stdout);fputc('\n',stdout);
} return 0; }
