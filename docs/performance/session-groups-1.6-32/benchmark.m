// Host-only microbenchmark: production Foundation code + synthetic host objects.
// No UIKit, injected WeChat, real account, or persistent NSUserDefaults writes.
#import <Foundation/Foundation.h>
#import <mach/mach_time.h>
#import "CSGroupNativeBridge.h"
#import "CSGroupPreferences.h"
#import "WESessionTabItem.h"

id CSGetService(Class cls) { (void)cls; return nil; }
@interface BenchContact : NSObject
@property(nonatomic,copy) NSString *m_nsUsrName;
- (BOOL)isBrandContact;
- (BOOL)isServiceBrand;
- (BOOL)isSubscriptionBrand;
- (BOOL)isMyContact;
@end
@implementation BenchContact
- (BOOL)isBrandContact { return NO; }
- (BOOL)isServiceBrand { return NO; }
- (BOOL)isSubscriptionBrand { return NO; }
- (BOOL)isMyContact { return YES; }
@end
@interface BenchSession : NSObject
@property(nonatomic,copy) NSString *m_nsUserName;
@property(nonatomic,strong) BenchContact *m_contact;
@property(nonatomic) BOOL m_bIsTop,m_bShowUnReadAsRedDot;
@property(nonatomic) NSUInteger m_uUnReadCount;
- (BOOL)isBrandServiceBoxSession;
- (BOOL)isBrandEcsMsgHolderSession;
- (BOOL)isInBrandServiceBox;
- (BOOL)isSingleChatSession;
@end
@implementation BenchSession
- (BOOL)isBrandServiceBoxSession { return NO; }
- (BOOL)isBrandEcsMsgHolderSession { return NO; }
- (BOOL)isInBrandServiceBox { return NO; }
- (BOOL)isSingleChatSession { return YES; }
@end
@interface BenchHost : NSObject
@property(nonatomic,strong) NSArray<BenchSession *> *sessions;
@property(nonatomic,strong) id m_tableView;
- (id)m_mainFrameLogicController;
- (id)getSessionInfoAtIndexPath:(NSIndexPath *)path;
- (NSInteger)numberOfSectionsInTableView:(id)table;
- (NSInteger)tableView:(id)table numberOfRowsInSection:(NSInteger)section;
@end
@implementation BenchHost
- (id)m_mainFrameLogicController { return self; }
- (id)getSessionInfoAtIndexPath:(NSIndexPath *)path { return self.sessions[[path indexAtPosition:1]]; }
- (NSInteger)numberOfSectionsInTableView:(id)table { (void)table; return 1; }
- (NSInteger)tableView:(id)table numberOfRowsInSection:(NSInteger)section { (void)table; (void)section; return self.sessions.count; }
@end
// A minimal object implementing only the defaults API used by production prefs.
// It intentionally does not inherit NSUserDefaults or touch a persistent domain.
@interface MemoryDefaults : NSObject
@property(nonatomic,strong) NSMutableDictionary *values;
@property(nonatomic) NSUInteger writes,syncs;
- (id)objectForKey:(NSString *)key;
- (void)setObject:(id)object forKey:(NSString *)key;
- (void)removeObjectForKey:(NSString *)key;
- (BOOL)synchronize;
@end
@implementation MemoryDefaults
- (instancetype)init { if ((self=[super init])) self.values=[NSMutableDictionary new]; return self; }
- (id)objectForKey:(NSString *)key { return self.values[key]; }
- (void)setObject:(id)object forKey:(NSString *)key { self.values[key]=object; self.writes++; }
- (void)removeObjectForKey:(NSString *)key { [self.values removeObjectForKey:key]; }
- (BOOL)synchronize { self.syncs++; return YES; }
@end
static double Now(void) {
    static mach_timebase_info_data_t info; if (!info.denom) mach_timebase_info(&info);
    return (double)mach_absolute_time()*info.numer/info.denom/1e6;
}
static NSDictionary *Measure(void (^work)(void)) {
    for (NSUInteger i=0;i<3;i++) { @autoreleasepool { work(); } }
    NSMutableArray *samples=[NSMutableArray new];
    for (NSUInteger i=0;i<21;i++) {
        double start=Now(); @autoreleasepool { work(); }
        [samples addObject:@(Now()-start)];
    }
    NSArray *sorted=[samples sortedArrayUsingSelector:@selector(compare:)];
    return @{@"median_ms":sorted[10],@"p95_ms":sorted[19],@"samples_ms":samples};
}
static CSGroupPreferences *Prefs(MemoryDefaults *defaults) {
    return [[CSGroupPreferences alloc] initWithDefaults:(NSUserDefaults *)(id)defaults accountID:@"synthetic-account"];
}
static CSGroupProjection *Project(NSArray *sections,CSGroupPreferences *prefs) {
    CSGroupProjection *p=[[CSGroupProjection alloc] initWithSections:sections tabs:prefs.tabs selectedTabID:prefs.selectedTabID filterDuplicates:NO accountID:@"synthetic-account"];
    NSCAssert(p.isValid,@"invalid synthetic fixture"); return p;
}
int main(void) { @autoreleasepool {
    NSMutableArray *results=[NSMutableArray new];
    // N, custom groups, memberships per row; 4 presets are always present.
    for (NSArray *scenario in @[@[@500,@0,@0],@[@2000,@10,@2],@[@10000,@20,@2],@[@2000,@30,@30]]) { @autoreleasepool {
        NSUInteger n=[scenario[0] unsignedIntegerValue],g=[scenario[1] unsignedIntegerValue],overlap=[scenario[2] unsignedIntegerValue];
        BenchHost *host=[BenchHost new]; host.m_tableView=[NSObject new];
        NSMutableArray *sessions=[NSMutableArray new],*members=[NSMutableArray new],*custom=[NSMutableArray new];
        for (NSUInteger j=0;j<g;j++) [members addObject:[NSMutableArray new]];
        for (NSUInteger i=0;i<n;i++) {
            BenchSession *session=[BenchSession new]; session.m_nsUserName=[NSString stringWithFormat:@"synthetic-%lu",(unsigned long)i];
            session.m_contact=[BenchContact new]; session.m_contact.m_nsUsrName=session.m_nsUserName; session.m_uUnReadCount=i%7;
            [sessions addObject:session];
            for (NSUInteger j=0;j<overlap;j++) [members[(i+j)%g] addObject:session.m_nsUserName];
        }
        for (NSUInteger j=0;j<g;j++) [custom addObject:@{@"id":[NSString stringWithFormat:@"custom-%lu",(unsigned long)j],@"name":@"Synthetic group",@"members":members[j]}];
        host.sessions=sessions;
        MemoryDefaults *defaults=[MemoryDefaults new];
        defaults.values[@"com.wechat.enhance.chat_group.account_profiles"]=@{@"synthetic-account":@{@"version":@1,@"customTabs":custom,@"selectedTabID":g ? @"custom-0" : @"preset_0",@"legacyImported":@YES}};
        CSGroupPreferences *prefs=Prefs(defaults);
        NSArray *sections=CSGroupBuildNativeSections(host,host.m_tableView,host); NSCAssert(sections,@"snapshot failed");
        NSDictionary *read=Measure(^{ (void)Prefs(defaults); });
        NSDictionary *snapshot=Measure(^{ NSCAssert(CSGroupBuildNativeSections(host,host.m_tableView,host),@"snapshot failed"); });
        NSDictionary *projection=Measure(^{ (void)Project(sections,prefs); });
        NSDictionary *core=Measure(^{
            CSGroupPreferences *p=Prefs(defaults);
            CSGroupProjection *view=Project(CSGroupBuildNativeSections(host,host.m_tableView,host),p);
            NSMutableDictionary *identities=[NSMutableDictionary new];
            [view.sections enumerateObjectsUsingBlock:^(NSArray *rows,NSUInteger s,BOOL *stop) {
                (void)stop; [rows enumerateObjectsUsingBlock:^(CSGroupRow *row,NSUInteger r,BOOL *end) {
                    (void)end; NSUInteger indexes[]={s,r}; identities[row.userName]=[NSIndexPath indexPathWithIndexes:indexes length:2];
                }];
            }];
        });
        __block NSUInteger iteration=0;
        NSDictionary *write=Measure(^{ prefs.selectedTabID=(iteration++%2) ? @"preset_0" : @"preset_2"; });
        NSUInteger beforeWrites=defaults.writes,beforeSyncs=defaults.syncs;
        prefs.selectedTabID=@"preset_0";
        [results addObject:@{@"sessions":@(n),@"tabs":@(g+4),@"memberships":@(n*overlap),@"selected":g ? @"custom-0" : @"preset_0",@"preferences_read":read,@"snapshot_mock_host":snapshot,@"projection_only":projection,@"refresh_data_no_UI":core,@"selection_write_memory_only":write,@"steady_selection_defaults_writes":@(defaults.writes-beforeWrites),@"steady_selection_synchronize_calls":@(defaults.syncs-beforeSyncs)}];
    } }
    NSData *data=[NSJSONSerialization dataWithJSONObject:@{@"warmup":@3,@"samples":@21,@"results":results} options:NSJSONWritingPrettyPrinted error:nil];
    fwrite(data.bytes,1,data.length,stdout); fputc('\n',stdout);
} return 0; }
