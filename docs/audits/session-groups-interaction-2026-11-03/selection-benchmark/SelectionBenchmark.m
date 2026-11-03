#import <Foundation/Foundation.h>
#import "CSGroupNativeModel.h"
#import "WESessionTabItem.h"

// Controlled macOS workload over the actual production translation units.
// This row provider substitutes copied metadata, never iPhone/private services.
@interface SelectionSession:NSObject
@property(nonatomic,copy) NSString *name;
@property(nonatomic) CSGroupRowCategory category;
@property(nonatomic) CSGroupRowKind kind;
@property(nonatomic) NSUInteger unread;
@end
@implementation SelectionSession @end
static NSUInteger Reads;
static void Require(BOOL value,NSString *message) {
    if (!value) { fprintf(stderr,"Selection benchmark: %s\n",message.UTF8String);exit(1); }
}
static CSGroupNativeModelResult *Build(NSArray *top,NSArray *normal,NSArray *all,NSArray *tabs,NSString *selected,NSArray *folded) {
    return [CSGroupNativeModel buildWithTopSessions:top normalSessions:normal allTopSessions:top allSessions:all tabs:tabs
        selectedTabID:selected groupingEnabled:YES filterDuplicates:YES accountID:@"selection-benchmark-account"
        hiddenUserNames:[NSSet setWithObjects:@"select_0007",@"folded_0008@chatroom",nil] privacyRevision:11
        scopeFoldedEntry:YES foldedRows:folded rowProvider:^CSGroupRow *(SelectionSession *session,NSIndexPath *path,BOOL isTop) {
            Reads++;
            return [[CSGroupRow alloc] initWithNativePath:path userName:session.name kind:session.kind
                category:session.category top:isTop unreadCount:session.unread redDot:session.unread%4==0];
        }];
}
static NSArray *Names(NSArray *sessions) {
    NSMutableArray *names=[NSMutableArray array];for (SelectionSession *session in sessions) [names addObject:session.name];return names;
}
static NSDictionary *Fingerprint(CSGroupNativeModelResult *model,NSArray *tabs) {
    NSMutableArray *visible=[NSMutableArray array];
    for (NSArray *section in model.projection.sections) for (CSGroupRow *row in section)
        [visible addObject:@[row.userName ?: @"",@(row.kind),@(row.category),@(row.top),@(row.unreadCount),@(row.redDot),
            @(row.privacyMasked),@(row.foldedEntryScoped),row.foldedEntryCount ?: NSNull.null,
            row.foldedEntryAccountID ?: NSNull.null,@(row.foldedEntryPrivacyRevision),row.foldedEntrySummary ?: NSNull.null,
            row.foldedEntryPrefix ?: NSNull.null,row.foldedEntrySummaryUserName ?: NSNull.null]];
    NSMutableDictionary *badges=[NSMutableDictionary dictionary];
    for (WESessionTabItem *tab in tabs) {
        CSGroupBadge *badge=[model.projection badgeForTabID:tab.tabId];
        badges[tab.tabId]=@[@(badge.count),@(badge.redDot),@([model.projection sessionCountForTabID:tab.tabId])];
    }
    return @{@"selected":model.selectedTabID,@"top":Names(model.topSessions),@"normal":Names(model.normalSessions),
        @"all_top":Names(model.allTopSessions),@"total_top":@(model.totalTopSessionCount),@"visible":visible,@"badges":badges};
}
int main(void) { @autoreleasepool {
    const NSUInteger count=1200,customCount=24,switches=120,rounds=5;
    NSMutableArray *all=[NSMutableArray array],*top=[NSMutableArray array],*normal=[NSMutableArray array];
    NSMutableArray *tabs=[NSMutableArray arrayWithArray:@[[WESessionTabItem tabWithType:WETabTypeAll],
        [WESessionTabItem tabWithType:WETabTypeGroup],[WESessionTabItem tabWithType:WETabTypePrivate],
        [WESessionTabItem tabWithType:WETabTypeOfficial]]];
    for (NSUInteger i=0;i<count;i++) {
        SelectionSession *session=[SelectionSession new];session.name=[NSString stringWithFormat:@"select_%04lu%@",(unsigned long)i,i%3==0?@"@chatroom":@""];
        session.kind=CSGroupRowKindSession;session.category=i%3==0?CSGroupRowCategoryGroup:CSGroupRowCategoryPrivate;session.unread=i%10;
        [all addObject:session];[(i<32 ? top : normal) addObject:session];
    }
    SelectionSession *box=[SelectionSession new];box.name=@"chatroom_session_box";box.kind=CSGroupRowKindAggregate;
    box.category=CSGroupRowCategoryGroup;[normal addObject:box];[all addObject:box];
    NSMutableArray *folded=[NSMutableArray array];
    for (NSUInteger i=0;i<100;i++) {
        NSUInteger indexes[]={0,i};
        [folded addObject:[[CSGroupRow alloc] initWithNativePath:[NSIndexPath indexPathWithIndexes:indexes length:2]
            userName:[NSString stringWithFormat:@"folded_%04lu@chatroom",(unsigned long)i] kind:CSGroupRowKindSession
            category:CSGroupRowCategoryGroup top:NO unreadCount:i%7 redDot:i%2==0 nativeSummary:@"copied folded digest" sortTime:@(i+1)]];
    }
    for (NSUInteger group=0;group<customCount;group++) {
        NSMutableArray *names=[NSMutableArray array];
        for (NSUInteger i=0;i<count;i++) if (i%24==group || i%37==group) [names addObject:[all[i] name]];
        for (NSUInteger i=0;i<folded.count;i++) if (i%24==group) [names addObject:[folded[i] userName]];
        WESessionTabItem *tab=[WESessionTabItem customTabWithName:@"benchmark group" sessionUserNames:names];
        tab.tabId=[NSString stringWithFormat:@"selection_custom_%lu",(unsigned long)group];[tabs addObject:tab];
    }
    NSMutableDictionary *results=[NSMutableDictionary dictionary];
    for (NSString *workload in @[@"filtered-groups",@"cross-all-scope"]) {
        NSMutableArray *times=[NSMutableArray array],*reads=[NSMutableArray array];
        NSMutableDictionary *fingerprints=[NSMutableDictionary dictionary];
        for (NSUInteger round=0;round<rounds;round++) { @autoreleasepool {
            CSGroupNativeModelResult *model=Build(top,normal,all,tabs,@"preset_0",folded);
            Require(model.isValid,@"initial complete model invalid");
            // Start filtered-only timing within the same scoped boundary.
            model=Build(top,normal,all,tabs,@"preset_1",folded);Reads=0;
            NSTimeInterval started=NSProcessInfo.processInfo.systemUptime;
            for (NSUInteger i=0;i<switches;i++) { @autoreleasepool {
                NSString *selected=[tabs[4+i%customCount] tabId];
                if ([workload isEqual:@"cross-all-scope"] && i%2==0) selected=@"preset_0";
#if CS_SELECTION_REUSE
                model=[CSGroupNativeModel modelBySelectingTabID:selected fromResult:model foldedRows:folded];
#else
                model=Build(top,normal,all,tabs,selected,folded);
#endif
                Require(model.isValid && [model.selectedTabID isEqual:selected],@"wrong selected model");
            }}
            [times addObject:@((NSProcessInfo.processInfo.systemUptime-started)*1000.0/switches)];[reads addObject:@(Reads)];
            // Validate every destination outside the measured loop. Fingerprints
            // include native object names/order, badges and scoped fold metadata.
            for (WESessionTabItem *tab in tabs) {
#if CS_SELECTION_REUSE
                model=[CSGroupNativeModel modelBySelectingTabID:tab.tabId fromResult:model foldedRows:folded];
#else
                model=Build(top,normal,all,tabs,tab.tabId,folded);
#endif
                Require(model.isValid,@"fingerprint destination invalid");fingerprints[tab.tabId]=Fingerprint(model,tabs);
            }
        }}
        NSArray *ordered=[times sortedArrayUsingSelector:@selector(compare:)];
        results[workload]=@{@"metadata_reads_per_round":reads,@"milliseconds_per_switch_each_round":times,
            @"median_milliseconds_per_switch":ordered[ordered.count/2],@"projection_fingerprints":fingerprints};
    }
    NSDictionary *result=@{@"sessions":@(count),@"aggregate_entries":@1,@"folded_children":@100,@"custom_groups":@(customCount),
        @"switches_per_round":@(switches),@"rounds":@(rounds),@"selection_reuse":@(CS_SELECTION_REUSE),@"workloads":results,
        @"scope":@"macOS production model/projection wall time only; excludes native folded/source capture, identity verification, coordinator, UIKit, Instruments and iPhone CPU"};
    NSData *json=[NSJSONSerialization dataWithJSONObject:result options:NSJSONWritingPrettyPrinted|NSJSONWritingSortedKeys error:nil];
    fwrite(json.bytes,1,json.length,stdout);fputc('\n',stdout);
} return 0; }
