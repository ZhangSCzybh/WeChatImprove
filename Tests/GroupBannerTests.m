// Production header hooks, Native/HeaderChange scopes, adapter changes and cache
// selection run against isolated host doubles. The fixture models a banner
// arriving during the first metadata publication, after source rows were read.
// It does not invoke UIKit, launch WeChat, or access any user account/defaults.
#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "CSGroupRefreshState.h"

@class BannerOwner,CSGroupListAdapter;
@interface CSCloseFriendSnapshot : NSObject
@property(nonatomic) BOOL blocked;
@property(nonatomic) NSUInteger revision;
@property(nonatomic,copy) NSString *accountID;
@property(nonatomic,copy) NSDictionary *options;
@end
@implementation CSCloseFriendSnapshot @end
@interface CSGroupRow : NSObject
@property(nonatomic,copy) NSString *userName,*token;
@property(nonatomic,strong) NSIndexPath *nativePath;
@end
@implementation CSGroupRow @end
@interface BannerProjection : CSCloseFriendSnapshot
@property(nonatomic,copy) NSArray *sections;
- (CSGroupRow *)rowAtDisplayPath:(NSIndexPath *)path;
- (NSUInteger)privacyRevision;
@end
@implementation BannerProjection
- (NSUInteger)privacyRevision { return self.revision; }
- (CSGroupRow *)rowAtDisplayPath:(NSIndexPath *)path {
    if(path.length!=2 || [path indexAtPosition:0]>=self.sections.count)return nil;
    NSArray *rows=self.sections[[path indexAtPosition:0]];
    if([path indexAtPosition:1]>=rows.count)return nil;
    NSString *token=rows[[path indexAtPosition:1]];CSGroupRow *row=[CSGroupRow new];
    row.token=token;row.nativePath=path;row.userName=[token hasPrefix:@"banner-"] ? nil : token;return row;
}
@end
@interface UITableViewCell : NSObject
@property(nonatomic) BOOL shielded;
@end
@implementation UITableViewCell @end
@interface CSCloseFriendListShield : NSObject
- (void)shieldCell:(UITableViewCell *)cell;
@end
@implementation CSCloseFriendListShield
- (void)shieldCell:(UITableViewCell *)cell { cell.shielded=YES; }
@end
static char CellRowKey;
static const NSUInteger CSCloseFriendSurfaceSession=1;
static BOOL CSCloseFriendShouldHideUserName(NSString *name,NSUInteger surface) { (void)name;(void)surface;return NO; }
static void CSCloseFriendUpdateSessionCover(UITableViewCell *cell,CSGroupRow *row) { (void)cell;(void)row; }
static NSString *CSGroupNativeUserNameAtPath(id owner,NSIndexPath *path);
static CSCloseFriendSnapshot *policy;
static NSString *CSGroupCurrentAccountID(void) { return @"fixture-account"; }
static NSUInteger CSCloseFriendAccountEpoch(void) { return 7; }
static CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) { return policy; }
static id CSGroupReadObject(id object,NSString *key) {
    @try { return [object valueForKey:key]; } @catch (__unused NSException *e) { return nil; }
}
static long long CSGroupReadInteger(id object,NSString *key,long long fallback) {
    id value=CSGroupReadObject(object,key);return [value respondsToSelector:@selector(longLongValue)] ? [value longLongValue] : fallback;
}
static NSUInteger nativeScopeDepth;
static void CSGroupWithNativeIndices(id table,void (^body)(void)) {
    (void)table;nativeScopeDepth++;@try { body(); } @finally { nativeScopeDepth--; }
}
static NSArray *CSGroupBuildNativeSectionsForChanges(id owner,id table,id source,NSArray *previous,
                                                    CSGroupChangeKind changes,NSSet *names);

@interface CSGroupNativeSessionCoordinator : NSObject
@property(nonatomic) NSUInteger revision,invalidations,changeScopes,epoch;
@property(nonatomic,copy) NSString *accountID;
@property(nonatomic) BOOL boundary;
@property(nonatomic,weak) CSGroupListAdapter *adapter;
+ (instancetype)sharedCoordinator;
- (void)invalidateNativeData;
- (void)performChangeForUserNames:(NSSet *)names kind:(CSGroupChangeKind)kind original:(void (^)(void))body;
@end

@interface CSGroupListAdapter : NSObject
@property(nonatomic,weak) BannerOwner *controller;
@property(nonatomic,strong) NSObject *table;
@property(nonatomic) BOOL usesNativeSessionModel,active,publishing,presentationSuspended;
@property(nonatomic) BOOL dirty,scheduledCoalesced,scheduled,recoveryPending,immediateRefreshPending,background;
@property(nonatomic) BOOL pendingChangeNamesUnknown,privacyRefreshPending;
@property(nonatomic) BOOL nativeBoundaryHeld;
@property(nonatomic) NSUInteger modelRevision,changeDepth,snapshotRevision,snapshotEpoch;
@property(nonatomic) NSUInteger nativeModelRevision;
@property(nonatomic) NSUInteger tabBadgeRevision,tabBadgeEpoch,anchorCaptures,badgeRequests,bridgeReads;
@property(nonatomic) CSGroupChangeKind pendingChanges;
@property(nonatomic,strong) NSMutableSet *pendingChangedUserNames;
@property(nonatomic,strong) NSMutableArray *nativeActions;
@property(nonatomic,copy) NSArray *cachedNativeSections,*tabBadgeSections,*publishedSections;
@property(nonatomic,copy) NSString *snapshotAccount,*tabBadgeAccount;
@property(nonatomic,strong) BannerProjection *projection;
@property(nonatomic,strong) CSCloseFriendListShield *privacyShield;
+ (instancetype)adapterForController:(id)owner;
- (void)performSessionListLayout:(void (^)(void))layout;
- (void)beginNativeChange;
- (void)beginNativeChangeOfKind:(CSGroupChangeKind)kind;
- (void)beginNativeChangeOfKind:(CSGroupChangeKind)kind changedUserNames:(NSSet *)names;
- (void)endNativeChange;
- (void)endNativeChangeCoalesced:(BOOL)coalesced;
- (void)invalidateNativeSnapshot;
- (void)requestRecovery;
- (void)requestRefresh;
- (void)scheduleRefresh;
- (void)requestCoalescedRefresh;
- (void)requestTabBadgeSourceRefreshCoalesced:(BOOL)coalesced;
- (void)saveAnchor;
- (id)nativeSource;
- (NSArray *)nativeSectionsForAccount:(NSString *)account changes:(CSGroupChangeKind)changes changedUserNames:(NSSet *)names;
- (void)sourceChanged;
- (void)bindNativeCell:(UITableViewCell *)cell atPath:(NSIndexPath *)path;
- (NSIndexPath *)currentPathForRow:(CSGroupRow *)row;
@end

@interface BannerOwner : NSObject
@property(nonatomic,strong) CSGroupListAdapter *adapter;
@property(nonatomic,strong) id m_delegate;
@property(nonatomic) NSUInteger bannerCount,originalCalls,lastRow;
@property(nonatomic) BOOL originalSawNativeScope,throwInOriginal,changeSessionRevision;
@property(nonatomic,copy) void (^nestedUpdate)(void);
@property(nonatomic,strong) UITableViewCell *lastCell;
- (NSArray *)nativeSections;
- (void)insertRow:(unsigned int)row;
- (void)removeRow:(unsigned int)row;
- (void)reloadAll;
- (void)originalInsertRow:(unsigned int)row;
- (void)originalRemoveRow:(unsigned int)row;
- (void)originalReloadAll;
@end

@implementation CSGroupListAdapter
#include "GroupBannerAdapterBodies.h"
+ (instancetype)adapterForController:(id)owner { return [owner isKindOfClass:BannerOwner.class] ? ((BannerOwner *)owner).adapter : nil; }
- (void)performSessionListLayout:(void (^)(void))layout { if (layout) layout(); }
- (void)saveAnchor { self.anchorCaptures++; }
- (void)requestTabBadgeSourceRefreshCoalesced:(BOOL)coalesced { (void)coalesced;self.badgeRequests++; }
- (void)requestCoalescedRefresh { self.dirty=YES;[self scheduleRefresh]; }
- (void)scheduleRefresh { if (self.dirty && !self.publishing && !self.changeDepth && !self.presentationSuspended && !self.background) self.scheduled=YES; }
- (id)nativeSource { return self.controller; }
- (void)sourceChanged { [self invalidateNativeSnapshot];self.dirty=YES;[self scheduleRefresh]; }
- (NSIndexPath *)currentPathForRow:(CSGroupRow *)row {
    NSIndexPath *path=row.nativePath;NSArray *sections=[self.controller nativeSections];
    if(path.length!=2 || [path indexAtPosition:0]>=sections.count)return nil;
    NSArray *rows=sections[[path indexAtPosition:0]];
    return [path indexAtPosition:1]<rows.count && [rows[[path indexAtPosition:1]] isEqual:row.token] ? path : nil;
}
@end
@implementation CSGroupNativeSessionCoordinator
+ (instancetype)sharedCoordinator { static CSGroupNativeSessionCoordinator *c;static dispatch_once_t once;dispatch_once(&once,^{c=[self new];});return c; }
- (void)invalidateNativeData { self.invalidations++;self.revision++;[self.adapter sourceChanged]; }
- (void)performChangeForUserNames:(NSSet *)names kind:(CSGroupChangeKind)kind original:(void (^)(void))body {
    NSCAssert(!names && kind==CSGroupChangeUnknown,@"Banner callbacks must not invent a session identity");
    self.changeScopes++;body();
}
@end

#include "GroupBannerNativeScope.h"
@implementation BannerOwner
#include "GroupBannerHooks.h"
- (NSArray *)nativeSections {
    NSMutableArray *rows=[NSMutableArray array];
    for (NSUInteger i=0;i<self.bannerCount;i++) [rows addObject:[NSString stringWithFormat:@"banner-%lu",(unsigned long)i]];
    [rows addObject:@"session-a"];return @[[rows copy]];
}
- (void)nativeUIUpdate {
    self.originalCalls++;
    self.originalSawNativeScope=nativeScopeDepth>0;
    if (self.changeSessionRevision) {
        CSGroupNativeSessionCoordinator *coordinator=CSGroupNativeSessionCoordinator.sharedCoordinator;
        coordinator.revision++;[self.adapter sourceChanged];
    }
    // Compatibility UITableView hooks intercept native row/reload operations.
    // Native-model operations pass through. During first publication, a newly
    // delivered cell is shielded until metadata knows its anonymous business slot.
    if (self.adapter.active && !self.adapter.usesNativeSessionModel && !self.adapter.publishing)
        [self.adapter requestRefresh];
    if (self.adapter.usesNativeSessionModel && self.bannerCount) {
        self.lastCell=[UITableViewCell new];NSUInteger indexes[]={0,0};
        [self.adapter bindNativeCell:self.lastCell atPath:[NSIndexPath indexPathWithIndexes:indexes length:2]];
    }
    if (self.nestedUpdate) { void (^nested)(void)=self.nestedUpdate;self.nestedUpdate=nil;nested(); }
    if (self.throwInOriginal) @throw [NSException exceptionWithName:@"NativeBannerException" reason:@"fixture" userInfo:nil];
}
- (void)originalInsertRow:(unsigned int)row { self.lastRow=row;[self nativeUIUpdate]; }
- (void)originalRemoveRow:(unsigned int)row { self.lastRow=row;[self nativeUIUpdate]; }
- (void)originalReloadAll { [self nativeUIUpdate]; }
@end
static NSString *CSGroupNativeUserNameAtPath(id owner,NSIndexPath *path) {
    NSArray *sections=[owner nativeSections];
    if(path.length!=2 || [path indexAtPosition:0]>=sections.count)return nil;
    NSArray *rows=sections[[path indexAtPosition:0]];
    if([path indexAtPosition:1]>=rows.count)return nil;
    NSString *token=rows[[path indexAtPosition:1]];return [token hasPrefix:@"banner-"] ? nil : token;
}
static NSArray *CSGroupBuildNativeSectionsForChanges(id owner,id table,id source,NSArray *previous,
                                                    CSGroupChangeKind changes,NSSet *names) {
    (void)table;(void)source;(void)previous;(void)changes;(void)names;
    BannerOwner *host=owner;host.adapter.bridgeReads++;return [host nativeSections];
}

static NSUInteger checks,failures;
static void Check(BOOL ok,NSString *message) { checks++;if(!ok){failures++;fprintf(stderr,"FAIL: %s\n",message.UTF8String);} }
static BannerOwner *Fixture(BOOL nativeModel) {
    BannerOwner *owner=[BannerOwner new];CSGroupListAdapter *a=[CSGroupListAdapter new];owner.adapter=a;
    a.controller=owner;a.table=[NSObject new];a.usesNativeSessionModel=nativeModel;a.active=YES;
    a.modelRevision=11;a.snapshotRevision=11;a.tabBadgeRevision=11;a.snapshotEpoch=7;a.tabBadgeEpoch=7;
    a.snapshotAccount=CSGroupCurrentAccountID();a.tabBadgeAccount=CSGroupCurrentAccountID();
    a.projection=[BannerProjection new];a.projection.accountID=policy.accountID;a.projection.revision=policy.revision;
    a.projection.sections=[owner nativeSections];a.nativeActions=[NSMutableArray array];
    a.cachedNativeSections=[owner nativeSections];a.tabBadgeSections=a.cachedNativeSections;a.publishedSections=a.cachedNativeSections;
    CSGroupNativeSessionCoordinator *c=CSGroupNativeSessionCoordinator.sharedCoordinator;
    c.adapter=a;c.revision=19;c.epoch=7;c.accountID=CSGroupCurrentAccountID();c.invalidations=0;c.changeScopes=0;c.boundary=NO;
    a.nativeModelRevision=c.revision;return owner;
}
static NSArray *ReadSource(CSGroupListAdapter *a) {
    return a.usesNativeSessionModel ? [a.controller nativeSections] :
        [a nativeSectionsForAccount:CSGroupCurrentAccountID() changes:CSGroupChangeUnknown changedUserNames:nil];
}
// This event loop double retains the real publication's essential contract:
// a synchronous host callback may invalidate an in-flight source read; dirty
// work is drained only after publishing is released. It is not a UIKit renderer.
static BOOL Publish(CSGroupListAdapter *a,void (^duringPublication)(void)) {
    a.scheduled=NO;a.dirty=NO;a.publishing=YES;
    NSUInteger revision=a.modelRevision;NSArray *source=ReadSource(a);
    if (duringPublication) duringPublication();
    BOOL accepted=revision==a.modelRevision;
    if (accepted) { a.publishedSections=source;a.projection.sections=source; }
    a.publishing=NO;if(a.dirty)[a scheduleRefresh];return accepted;
}
static void Drain(CSGroupListAdapter *a) { if(a.scheduled) Publish(a,nil); }
static BOOL HasBanner(CSGroupListAdapter *a) { return [a.publishedSections.firstObject containsObject:@"banner-0"]; }
static void Invoke(BannerOwner *owner,NSUInteger action) {
    if(action==0)[owner insertRow:0];else if(action==1)[owner removeRow:0];else[owner reloadAll];
}

int main(void) { @autoreleasepool {
    policy=[CSCloseFriendSnapshot new];policy.accountID=CSGroupCurrentAccountID();policy.revision=3;policy.options=@{@"hideSessions":@NO};
    for (NSNumber *nativeNumber in @[@YES,@NO]) {
        BOOL nativeModel=nativeNumber.boolValue;NSString *lane=nativeModel ? @"native" : @"compatibility";
        for (NSUInteger action=0;action<3;action++) {
            BannerOwner *owner=Fixture(nativeModel);CSGroupListAdapter *a=owner.adapter;
            BOOL accepted=Publish(a,^{owner.bannerCount=action==1 ? 0 : 1;Invoke(owner,action);});
            Check(!accepted,[NSString stringWithFormat:@"%@ action %lu invalidates first-publication metadata",lane,(unsigned long)action]);
            Check(owner.originalCalls==1 && owner.lastRow==0,[NSString stringWithFormat:@"%@ action %lu forwards original once with native row",lane,(unsigned long)action]);
            Check(a.scheduled,[NSString stringWithFormat:@"%@ action %lu schedules post-publication repair without foreground",lane,(unsigned long)action]);
            if(nativeModel && action!=1)Check(owner.lastCell.shielded && !a.recoveryPending,@"production native binding shields an unknown banner but cannot start recovery inside publishing");
            Drain(a);
            Check(HasBanner(a)==(action!=1),[NSString stringWithFormat:@"%@ action %lu republishes actual banner source",lane,(unsigned long)action]);
            if(nativeModel && action!=1) {
                UITableViewCell *current=[UITableViewCell new];NSUInteger indexes[]={0,0};
                [a bindNativeCell:current atPath:[NSIndexPath indexPathWithIndexes:indexes length:2]];
                Check(!current.shielded,@"production binding admits the banner after its current metadata is published");
            }
            Check(a.changeDepth==0 && !nativeScopeDepth,[NSString stringWithFormat:@"%@ action %lu balances scopes",lane,(unsigned long)action]);
            if(nativeModel)Check(CSGroupNativeSessionCoordinator.sharedCoordinator.invalidations==0 && CSGroupNativeSessionCoordinator.sharedCoordinator.changeScopes==0,@"native banner mutation does not rebuild or change the separate session source");
            else Check(owner.originalSawNativeScope && a.modelRevision>11,@"compatibility callback retains native coordinates and invalidates cached source");
        }
        // Removal is meaningful only after an existing banner was published.
        BannerOwner *owner=Fixture(nativeModel);CSGroupListAdapter *a=owner.adapter;
        owner.bannerCount=1;[a invalidateNativeSnapshot];Publish(a,nil);Check(HasBanner(a),@"removal fixture starts with a visible banner");
        Publish(a,^{owner.bannerCount=0;[owner removeRow:0];});Drain(a);
        Check(!HasBanner(a),[lane stringByAppendingString:@" removes a banner arriving during publication"]);

        owner=Fixture(nativeModel);a=owner.adapter;owner.throwInOriginal=YES;
        BOOL threw=NO;@try{[owner insertRow:0];}@catch(NSException *e){threw=[e.name isEqual:@"NativeBannerException"];}
        Check(threw && owner.originalCalls==1,[lane stringByAppendingString:@" preserves native exception and original call count"]);
        Check(!a.changeDepth && !nativeScopeDepth,[lane stringByAppendingString:@" releases change/index scopes after exception"]);
        Check(a.dirty,[lane stringByAppendingString:@" retains invalidation after an interrupted native update"]);

        owner=Fixture(nativeModel);a=owner.adapter;
        __weak BannerOwner *weakOwner=owner;
        owner.nestedUpdate=^{[weakOwner reloadAll];};Publish(a,^{owner.bannerCount=1;[owner insertRow:0];});Drain(a);
        Check(owner.originalCalls==2 && !a.changeDepth && HasBanner(a),[lane stringByAppendingString:@" nested header updates complete one coherent source publication"]);

        owner=Fixture(nativeModel);a=owner.adapter;CSGroupNativeSessionCoordinator.sharedCoordinator.boundary=YES;
        Publish(a,^{owner.bannerCount=1;[owner reloadAll];});
        Check(a.dirty && a.scheduled && a.modelRevision>11,[lane stringByAppendingString:@" source boundary does not drop a header invalidation"]);
        CSGroupNativeSessionCoordinator.sharedCoordinator.boundary=NO;Drain(a);
        Check(HasBanner(a),[lane stringByAppendingString:@" source boundary repair retains late banner"]);

        for (NSUInteger hold=0;hold<2;hold++) {
            owner=Fixture(nativeModel);a=owner.adapter;a.presentationSuspended=hold==0;a.background=hold==1;
            owner.bannerCount=1;[owner reloadAll];
            Check(a.dirty && !a.scheduled && a.modelRevision>11,[lane stringByAppendingString:@" covered/background updates retain dirty metadata without UI publication"]);
            a.presentationSuspended=NO;a.background=NO;[a scheduleRefresh];Drain(a);
            Check(HasBanner(a),[lane stringByAppendingString:@" existing visibility event publishes retained header work"]);
        }
        owner=Fixture(nativeModel);a=owner.adapter;a.active=NO;
        Publish(a,^{owner.bannerCount=1;[owner insertRow:0];});Drain(a);
        Check(a.modelRevision>11 && HasBanner(a),[lane stringByAppendingString:@" grouping-disabled privacy adapter retains independent header changes"]);
    }
    BannerOwner *owner=Fixture(NO);owner.bannerCount=1;[owner insertRow:0];Drain(owner.adapter);
    Check(HasBanner(owner.adapter),@"ordinary compatibility table refresh remains sufficient outside publishing");

    owner=Fixture(YES);owner.changeSessionRevision=YES;[owner insertRow:0];
    Check(CSGroupNativeSessionCoordinator.sharedCoordinator.invalidations==0,@"a genuine nested source revision avoids redundant coordinator invalidation");
    Check(owner.adapter.dirty && owner.originalCalls==1,@"nested session revision still carries banner refresh work");

    owner=[BannerOwner new];[owner insertRow:UINT_MAX];[owner reloadAll];[owner removeRow:UINT_MAX];
    Check(owner.originalCalls==3 && owner.lastRow==UINT_MAX,@"unattached native owner forwards all callbacks and preserves unsigned row range");
    Check(!nativeScopeDepth,@"unattached callbacks create no native index scope");
    owner=Fixture(YES);owner.adapter.table=nil;[owner insertRow:UINT_MAX];
    Check(owner.originalCalls==1 && owner.lastRow==UINT_MAX && owner.adapter.modelRevision==11 && !owner.adapter.changeDepth,@"adapter awaiting its table keeps native passthrough without a partial change scope");
    fprintf(stdout,"Group banner: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
    return failures ? 1 : 0;
} }
