#import <Foundation/Foundation.h>
#import "CSGroupProjection.h"
#import "WESessionTabItem.h"

static NSUInteger checks, failures;
static void Check(BOOL yes, NSString *message) {
    checks++; if (!yes) { failures++; fprintf(stderr,"FAIL: %s\n",message.UTF8String); }
}
static NSIndexPath *Path(NSUInteger section, NSUInteger row) {
    NSUInteger indexes[]={section,row}; return [NSIndexPath indexPathWithIndexes:indexes length:2];
}
static CSGroupRow *Row(NSString *name, NSUInteger index, CSGroupRowKind kind,
                       NSUInteger unread, BOOL top, NSString *summary) {
    return [[CSGroupRow alloc] initWithNativePath:Path(0,index) userName:name kind:kind
        category:kind==CSGroupRowKindSession ? CSGroupRowCategoryPrivate : CSGroupRowCategoryUnknown
        top:top unreadCount:unread redDot:NO nativeSummary:summary sortTime:nil];
}
static CSGroupProjection *Build(NSArray *rows, NSString *account, NSString *selected, NSUInteger privacyRevision) {
    return [[CSGroupProjection alloc] initWithSections:@[rows]
        tabs:@[[WESessionTabItem tabWithType:WETabTypeAll],[WESessionTabItem tabWithType:WETabTypePrivate]]
        selectedTabID:selected filterDuplicates:NO accountID:account hiddenUserNames:NSSet.set
        privacyRevision:privacyRevision previousProjection:nil];
}
static CSGroupPublicationPlan *Plan(CSGroupProjection *newProjection, CSGroupProjection *oldProjection,
                                    CSGroupChangeKind changes, NSSet *names, BOOL known, NSArray *visible) {
    return [newProjection publicationPlanFrom:oldProjection changes:changes contentUserNames:names
        contentIdentityKnown:known visiblePaths:visible];
}
static id CSGroupReadObject(id object, NSString *name) {
    @try { return [object valueForKey:name]; } @catch (__unused NSException *e) { return nil; }
}
@interface CSGroupListAdapter : NSObject
@property(nonatomic,strong) id table;
@property(nonatomic,strong) NSMutableArray *explicitIdentities;
@property(nonatomic,strong) NSMutableArray<NSString *> *reasons;
@property(nonatomic) NSUInteger genericBegins, ends;
@property(nonatomic) BOOL publishing;
- (void)recordRefreshReason:(NSString *)reason;
- (void)beginNativeChange;
- (void)beginNativeChangeOfKind:(CSGroupChangeKind)kind;
- (void)beginNativeChangeOfKind:(CSGroupChangeKind)kind sessionUserNames:(NSSet *)names;
- (void)endNativeChange;
- (void)endNativeChangeCoalesced:(BOOL)coalesced;
@end
@implementation CSGroupListAdapter
- (instancetype)init { if ((self=[super init])) { _table=NSObject.new; _explicitIdentities=NSMutableArray.new; _reasons=NSMutableArray.new; } return self; }
- (void)recordRefreshReason:(NSString *)reason { [self.reasons addObject:reason]; }
- (void)beginNativeChange { self.genericBegins++; }
- (void)beginNativeChangeOfKind:(CSGroupChangeKind)kind { (void)kind; self.genericBegins++; }
- (void)beginNativeChangeOfKind:(CSGroupChangeKind)kind sessionUserNames:(NSSet *)names { (void)kind; [self.explicitIdentities addObject:names ?: NSNull.null]; }
- (void)endNativeChange { self.ends++; }
- (void)endNativeChangeCoalesced:(BOOL)coalesced { (void)coalesced; self.ends++; }
@end
static CSGroupListAdapter *Adapter(id owner) { return owner; }
static void CSGroupWithNativeIndices(id table, void (^body)(void)) { (void)table; body(); }
#include "GroupEventIdentityBody.h"

int main(void) { @autoreleasepool {
    NSArray *rows=@[Row(nil,0,CSGroupRowKindBusiness,0,NO,nil),
                    Row(@"chatroom_session_box",1,CSGroupRowKindAggregate,0,NO,nil),
                    Row(@"a",2,CSGroupRowKindSession,1,NO,nil),
                    Row(@"b",3,CSGroupRowKindSession,0,NO,nil),
                    Row(@"offscreen",4,CSGroupRowKindSession,0,NO,nil)];
    CSGroupProjection *old=Build(rows,@"A",@"preset_0",0);
    NSArray *visible=@[Path(0,0),Path(0,1),Path(0,2),Path(0,3)];
    Check(old.valid,@"fixture validates special and ordinary native rows");
    for (NSNumber *kind in @[@0,@(CSGroupChangeUnread),@(CSGroupChangeUnknown),@(CSGroupChangeStructure),@(CSGroupChangeUnknown|CSGroupChangeStructure)]) {
        CSGroupPublicationPlan *p=Plan(old,old,kind.unsignedIntegerValue,nil,NO,visible);
        Check(!p.fullReload && !p.reloadPaths.count && !p.geometryChanged,@"same verified rows settle unknown/unread/structure feedback without reload or layout");
    }
    CSGroupPublicationPlan *p=Plan(old,old,CSGroupChangeContent,[NSSet setWithObject:@"a"],YES,visible);
    Check(!p.fullReload && [p.reloadPaths isEqual:@[Path(0,2)]] && !p.geometryChanged,@"known content refreshes only its visible session and keeps unrelated banners stable");
    p=Plan(old,old,CSGroupChangeContent|CSGroupChangeStructure|CSGroupChangeUnknown,[NSSet setWithObject:@"a"],YES,visible);
    Check([p.reloadPaths isEqual:@[Path(0,2)]] && !p.fullReload,@"structural and unknown hints cannot erase reliable content identity after coordinates validate");
    p=Plan(old,old,CSGroupChangeContent,[NSSet setWithObject:@"offscreen"],YES,visible);
    Check(!p.reloadPaths.count && !p.geometryChanged,@"offscreen content waits for native reuse rather than redrawing other rows");
    p=Plan(old,old,CSGroupChangeContent,[NSSet setWithObject:@"hidden-or-filtered"],YES,visible);
    Check(!p.reloadPaths.count && !p.fullReload,@"content for a filtered session does not touch unrelated displayed rows");
    p=Plan(old,old,CSGroupChangeContent,[NSSet setWithArray:@[@"a",@"b"]],YES,visible);
    Check([p.reloadPaths isEqual:@[Path(0,2),Path(0,3)]],@"multiple incoming sessions survive event merging");
    for (NSNumber *kind in @[@(CSGroupChangeContent),@(CSGroupChangeContent|CSGroupChangeUnknown)]) {
        p=Plan(old,old,kind.unsignedIntegerValue,nil,NO,visible);
        Check(!p.fullReload && [p.reloadPaths isEqual:visible] && p.geometryChanged,@"unattributed preview/draft content stays conservative without blanket table reload");
    }
    p=Plan(old,old,CSGroupChangeContent,nil,NO,@[Path(0,2)]);
    Check([p.reloadPaths isEqual:@[Path(0,0),Path(0,1),Path(0,2)]] && p.geometryChanged,@"unattributed content invalidates offscreen special-row geometry as well as visible ordinary rows");
    p=Plan(old,old,CSGroupChangeContent,nil,YES,visible);
    Check([p.reloadPaths isEqual:visible],@"inconsistent known identity cannot silently discard content");
    p=Plan(old,old,CSGroupChangeContent,(id)[NSSet setWithObject:@1],YES,visible);
    Check([p.reloadPaths isEqual:visible],@"malformed identity hints fall back to visible content refresh");
    p=Plan(old,old,CSGroupChangeContent,[NSSet setWithObject:@"chatroom_session_box"],YES,visible);
    Check([p.reloadPaths isEqual:@[Path(0,1)]] && p.geometryChanged && !p.fullReload,@"a content event for the aggregate updates only that entry and native geometry");

    NSMutableArray *changed=[rows mutableCopy];
    changed[2]=Row(@"a",2,CSGroupRowKindSession,4,NO,nil);
    CSGroupProjection *next=Build(changed,@"A",@"preset_0",0);
    p=Plan(next,old,CSGroupChangeUnread,nil,NO,visible);
    Check([p.reloadPaths isEqual:@[Path(0,2)]] && !p.geometryChanged && !p.fullReload,@"unread value diff works beside stable anonymous and aggregate rows");
    p=Plan(next,old,CSGroupChangeContent,[NSSet setWithObject:@"b"],YES,visible);
    Check([p.reloadPaths isEqual:@[Path(0,2),Path(0,3)]],@"explicit content identity and independently changed row values are both published");
    changed=[rows mutableCopy]; changed[2]=Row(@"a",2,CSGroupRowKindSession,1,NO,@"updated digest");
    next=Build(changed,@"A",@"preset_0",0);
    p=Plan(next,old,CSGroupChangeUnknown,nil,NO,visible);
    Check([p.reloadPaths isEqual:@[Path(0,2)]] && !p.fullReload,@"known summary value changes are targeted even on an unknown-only hint");
    changed=[rows mutableCopy]; changed[1]=Row(@"chatroom_session_box",1,CSGroupRowKindAggregate,0,NO,@"new folded child digest");
    next=Build(changed,@"A",@"preset_0",0);
    p=Plan(next,old,CSGroupChangeContent,[NSSet setWithObject:@"folded-child"],YES,visible);
    Check([p.reloadPaths isEqual:@[Path(0,1)]] && p.geometryChanged && !p.fullReload,@"folded aggregate value changes survive child event attribution");
    p=Plan(next,old,CSGroupChangeUnread,nil,NO,@[Path(0,2)]);
    Check([p.reloadPaths isEqual:@[Path(0,1)]] && p.geometryChanged,@"changed special geometry invalidates its height even when offscreen");
    NSArray *definitionTabs=@[[WESessionTabItem tabWithType:WETabTypeAll],[WESessionTabItem tabWithType:WETabTypePrivate]];
    CSGroupProjection *foldedChild=Build(@[Row(@"folded-child",0,CSGroupRowKindSession,0,NO,@"same folded digest")],@"A",@"preset_0",0);
    CSGroupProjection *scoped=[[CSGroupProjection alloc] initWithSections:@[rows] tabs:definitionTabs selectedTabID:@"preset_0"
        filterDuplicates:NO accountID:@"A" hiddenUserNames:NSSet.set unmaskedAggregateUserNames:NSSet.set privacyRevision:0
        scopeFoldedEntry:YES foldedProjection:foldedChild previousProjection:nil];
    Check(scoped.valid && [[scoped rowAtDisplayPath:Path(0,1)].foldedEntrySummaryUserName isEqual:@"folded-child"],@"folded summary fixture retains verified child provenance");
    p=Plan(scoped,scoped,CSGroupChangeContent,[NSSet setWithObject:@"folded-child"],YES,visible);
    Check([p.reloadPaths isEqual:@[Path(0,1)]] && p.geometryChanged,@"same-snapshot content from the displayed folded child invalidates its aggregate preview");
    p=Plan(scoped,scoped,CSGroupChangeContent,[NSSet setWithObject:@"a"],YES,visible);
    Check([p.reloadPaths isEqual:@[Path(0,2)]] && !p.geometryChanged,@"folded child provenance does not invalidate aggregates for unrelated ordinary content");
    changed=[rows mutableCopy]; changed[1]=Row(@"chatroom_session_box",1,CSGroupRowKindAggregate,3,NO,nil);
    next=Build(changed,@"A",@"preset_0",0);
    p=Plan(next,old,CSGroupChangeUnread,nil,NO,visible);
    Check([p.reloadPaths isEqual:@[Path(0,1)]] && !p.geometryChanged,@"aggregate unread count changes do not force native geometry measurement");
    changed=[rows mutableCopy]; changed[0]=Row(nil,0,CSGroupRowKindBusiness,0,NO,@"new banner");
    next=Build(changed,@"A",@"preset_0",0);
    p=Plan(next,old,CSGroupChangeUnknown,nil,NO,visible);
    Check([p.reloadPaths isEqual:@[Path(0,0)]] && p.geometryChanged && !p.fullReload,@"a changed anonymous banner refreshes its verified slot");
    changed=[rows mutableCopy]; changed[2]=Row(@"a",2,CSGroupRowKindSession,1,YES,nil);
    next=Build(changed,@"A",@"preset_0",0);
    p=Plan(next,old,CSGroupChangeStructure,nil,NO,visible);
    Check([p.reloadPaths isEqual:@[Path(0,2)]] && p.geometryChanged,@"a top-state value change preserves coordinates and refreshes card geometry");

    changed=[rows mutableCopy]; changed[2]=Row(@"different",2,CSGroupRowKindSession,1,NO,nil);
    p=Plan(Build(changed,@"A",@"preset_0",0),old,CSGroupChangeContent,[NSSet setWithObject:@"a"],YES,visible);
    Check(p.fullReload && p.geometryChanged,@"identity replacement overrides a targeted hint");
    changed=[rows mutableCopy]; [changed removeLastObject];
    Check(Plan(Build(changed,@"A",@"preset_0",0),old,CSGroupChangeUnread,nil,NO,visible).fullReload,@"row removal requires structural publication");
    Check(Plan(Build(rows,@"B",@"preset_0",0),old,0,nil,NO,visible).fullReload,@"publication cannot reuse another account");
    Check(Plan(Build(rows,@"A",@"preset_2",0),old,0,nil,NO,visible).fullReload,@"tab transition forces a complete publication boundary");
    Check(Plan(Build(rows,@"A",@"preset_0",1),old,0,nil,NO,visible).fullReload,@"privacy revision change is a publication boundary even with identical rows");
    Check(Plan(old,nil,0,nil,NO,visible).fullReload,@"first publication requires a native table reload");
    CSGroupProjection *invalid=Build(@[rows[0],rows[0]],@"A",@"preset_0",0);
    Check(Plan(invalid,old,0,nil,NO,visible).fullReload,@"invalid native snapshot cannot authorize row-only updates");
    p=Plan(old,old,CSGroupChangeContent,[NSSet setWithObject:@"a"],YES,@[Path(0,2),Path(0,2),Path(9,9)]);
    Check([p.reloadPaths isEqual:@[Path(0,2)]],@"visible coordinates are revalidated and deduplicated");

    // Draft/preview events are deliberately tested against the exact same row
    // objects: their omitted text must not be mistaken for unchanged content.
    for (NSUInteger event=0;event<2;event++) {
        p=Plan(old,old,CSGroupChangeContent,[NSSet setWithObject:@"a"],YES,visible);
        Check([p.reloadPaths isEqual:@[Path(0,2)]],event ? @"a second draft change is not consumed by the first event" : @"same-snapshot preview content is still invalidated");
    }
    for (NSUInteger seed=0;seed<6;seed++) {
        NSUInteger target=2+seed%3;
        NSSet *names=[NSSet setWithObject:[rows[target] userName]];
        NSArray *expected=target<4 ? @[Path(0,target)] : @[];
        p=Plan(old,old,CSGroupChangeContent|((seed%2) ? CSGroupChangeUnknown : CSGroupChangeStructure),names,YES,visible);
        Check([p.reloadPaths isEqual:expected] && !p.fullReload && !p.geometryChanged,@"repeated known events keep unrelated special rows stable");
    }

    Check([CSGroupSessionEventUserName(@{@"m_nsUserName":@"session"}) isEqual:@"session"],@"session notifications retain their user identity");
    Check([CSGroupSessionEventUserName(@{@"m_nsUsrName":@"contact"}) isEqual:@"contact"],@"message contact notifications retain their user identity");
    Check([CSGroupSessionEventUserName(@{@"userName":@"fake"}) isEqual:@"fake"],@"named fake-row item notifications can be targeted");
    Check([CSGroupSessionEventUserName(@{@"m_sessionInfo":@{@"m_nsUserName":@"real"},@"userName":@"stale-fake"}) isEqual:@"real"],@"real session identity outranks stale fake-cell data like native row resolution");
    Check(!CSGroupSessionEventUserName(@{@"m_sessionInfo":@{@"m_nsUserName":@"a",@"m_nsUsrName":@"b"},@"userName":@"stale-fake"}),@"conflicting real-session fields never fall back to stale fake-cell identity");
    Check(!CSGroupSessionEventUserName(@{@"m_sessionInfo":NSObject.new,@"userName":@"stale-fake"}),@"unreadable real-session identity stays conservative instead of trusting the outer fake row");
    Check([CSGroupSessionEventUserName(@"direct") isEqual:@"direct"],@"explicit delete-session names remain valid event identities");
    Check(!CSGroupSessionEventUserName(@{@"m_nsUserName":@"a",@"m_nsUsrName":@"b"}),@"conflicting event fields force conservative content attribution");
    Check(!CSGroupSessionEventUserName(@{@"m_nsUserName":@1}),@"non-string native identity cannot authorize a targeted update");
    Check(!CSGroupSessionEventUserName(nil) && !CSGroupSessionEventUserName(NSObject.new),@"missing or unknown native event models use conservative attribution");
    NSMutableString *mutableName=[@"original" mutableCopy];
    NSString *copied=CSGroupSessionEventUserName(@{@"m_nsUserName":mutableName});
    [mutableName setString:@"mutated"];
    Check([copied isEqual:@"original"],@"queued identity values never retain mutable host names");

    CSGroupListAdapter *adapter=CSGroupListAdapter.new;
    __block NSUInteger nativeCalls=0;
    NativeNotification(adapter,CSGroupChangeContent,@{@"m_nsUserName":@"a"},@"onSessionChanged:",^{ nativeCalls++; });
    Check([adapter.explicitIdentities.lastObject isEqual:[NSSet setWithObject:@"a"]] && adapter.ends==1 && nativeCalls==1,@"actual notification helper passes a copied session identity and preserves native completion");
    NativeEvent(adapter,CSGroupChangeContent,nil,@"onMainSessionReload",NO,^{ nativeCalls++; });
    Check(adapter.explicitIdentities.lastObject==NSNull.null && !adapter.genericBegins,@"real noarg notifications explicitly retain unknown content attribution");
    NSUInteger explicitCount=adapter.explicitIdentities.count;
    NativeReload(adapter,@"reloadSessions",^{ nativeCalls++; });
    Check(adapter.genericBegins==1 && adapter.explicitIdentities.count==explicitCount,@"derived view reload uses the generic transaction API so a known outer event can be inherited");
    NativeEvent(adapter,CSGroupChangeContent,@{@"m_nsUserName":@"outer"},@"updateItem:",NO,^{
        NativeEvent(adapter,CSGroupChangeContent,nil,@"onMainSessionReload",NO,^{ nativeCalls++; });
    });
    Check(adapter.explicitIdentities.lastObject==NSNull.null,@"a genuine unknown event nested in a known session event is never misattributed");
    adapter.publishing=YES;
    NativeNotification(adapter,CSGroupChangeContent,@{@"m_nsUserName":@"during-publication"},@"newMessageByContact:msgWrapToAdd:",^{ nativeCalls++; });
    Check([adapter.explicitIdentities.lastObject isEqual:[NSSet setWithObject:@"during-publication"]],@"real content arriving during publication remains an explicit dirty event");
    Check([adapter.reasons containsObject:@"onMainSessionReload"] && [adapter.reasons containsObject:@"newMessageByContact:msgWrapToAdd:"],@"diagnostic attribution records actual selectors without message contents");
    NSUInteger beforeException=adapter.ends;
    @try { NativeEvent(adapter,CSGroupChangeContent,@"a",@"updateSession:",YES,^{ @throw [NSException exceptionWithName:@"NativeFailure" reason:nil userInfo:nil]; }); }
    @catch (__unused NSException *e) {}
    Check(adapter.ends==beforeException+1,@"native transaction completion is preserved when the host throws");
    fprintf(stdout,"Group publication plan: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
    return failures ? 1 : 0;
} }
