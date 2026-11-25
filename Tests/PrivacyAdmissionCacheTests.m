// Execute complete production admission methods. UIKit is represented by counted doubles.
#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "CSCloseFriendPolicy.h"
#import "CSCloseFriendRuntime.h"
#import "CSGroupProjection.h"
#import "CSGroupNativeBridge.h"
#import "CSGroupIndexScope.h"
#import "WESessionTabItem.h"

static NSString *account=@"admission-fixture-account";
static NSUInteger epoch=7,snapshotReads,rowChecks,originalLayouts,checks,failures;
static CSCloseFriendSnapshot *policy;
static CSCloseFriendRuntime *runtimeProvider;
static char CellRowKey;
static CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) {
    snapshotReads++;
    return runtimeProvider ? [runtimeProvider snapshotForEpoch:epoch suspended:NO] : policy;
}
static NSUInteger CSCloseFriendAccountEpoch(void) { return epoch; }
@interface MMContext : NSObject @end
@implementation MMContext
+ (NSString *)currentUserName { return account; }
@end
id CSGetService(Class cls) { (void)cls; return nil; }
@interface AdmissionPolicy : CSCloseFriendSnapshot @end
@implementation AdmissionPolicy
- (BOOL)hidesUserName:(NSString *)name surface:(CSCloseFriendSurface)surface {
    rowChecks++;
    return [super hidesUserName:name surface:surface];
}
@end
@interface AdmissionProjection : CSGroupProjection
@property(nonatomic) BOOL fixtureRevisionKnown;
@property(nonatomic) NSUInteger fixtureRevision;
@end
@implementation AdmissionProjection
- (BOOL)respondsToSelector:(SEL)selector {
    return selector==NSSelectorFromString(@"privacyRevision") && !self.fixtureRevisionKnown ? NO : [super respondsToSelector:selector];
}
- (NSUInteger)privacyRevision { return self.fixtureRevision; }
@end
@interface UITableViewCell : NSObject
@property(nonatomic) BOOL hidden;
@end
@implementation UITableViewCell @end
@interface AdmissionTable : NSObject
@property(nonatomic,copy) NSArray<UITableViewCell *> *visibleCells;
@end
@implementation AdmissionTable @end
@interface CSCloseFriendListShield : NSObject
- (void)shieldCell:(UITableViewCell *)cell;
- (void)prepareForPublication;
@end
#include "AdmissionShieldBody.h"
// This suite owns compatibility-list privacy admission. Entering the native
// model coordinator would cross that explicit fixture boundary.
@interface CSGroupNativeSessionCoordinator : NSObject
@property(nonatomic) BOOL boundary;
@property(nonatomic) NSUInteger revision;
+ (instancetype)sharedCoordinator;
@end
@implementation CSGroupNativeSessionCoordinator
+ (instancetype)sharedCoordinator { [NSException raise:@"UnexpectedNativeModel" format:@"Privacy admission fixture uses compatibility rows"]; return nil; }
@end
@interface CSGroupListAdapter : NSObject
@property(nonatomic,strong) AdmissionTable *table;
@property(nonatomic,strong) CSGroupProjection *projection;
@property(nonatomic,strong) CSCloseFriendListShield *privacyShield;
@property(nonatomic) BOOL active,snapshotRetryAttempted,sessionLayoutHeld,privacyRefreshPending,dirty,publishing;
@property(nonatomic) NSUInteger snapshotEpoch,changeDepth,layoutRequests,modelRevision;
@property(nonatomic) BOOL usesNativeSessionModel,nativeBoundaryHeld,pageActive,pageCancelledBeforeShield;
@property(nonatomic) NSUInteger nativeModelRevision,pageCancellations;
- (BOOL)isActive;
- (void)requestRefresh;
- (void)performSessionListLayout:(void (^)(void))layout;
- (void)invalidateNativeSnapshot;
- (BOOL)adoptCompatibilityModelIfNeeded;
- (void)restorePendingViewport;
- (void)cancelInvalidPageTransition;
- (void)cancelPageTransition;
- (void)finishPageTransitionIfReady;
- (void)prepareForVisibility;
@end
@implementation CSGroupListAdapter
- (BOOL)isActive { return self.active; }
- (void)requestRefresh { self.layoutRequests++; self.dirty=YES; }
- (BOOL)adoptCompatibilityModelIfNeeded { return NO; }
- (void)restorePendingViewport {}
- (void)cancelInvalidPageTransition {}
- (void)finishPageTransitionIfReady {}
- (void)cancelPageTransition {
    self.pageCancellations++; self.pageActive=NO; self.pageCancelledBeforeShield=YES;
    for (UITableViewCell *cell in self.table.visibleCells) if (cell.hidden) self.pageCancelledBeforeShield=NO;
}
#include "AdmissionProductionBody.h"
@end
static void Check(BOOL pass,NSString *name) {
    checks++;
    if(!pass){failures++;fprintf(stderr,"FAIL: %s\n",name.UTF8String);}
}
static NSDictionary *Profile(void) {
    return @{@"enabled":@YES,@"friends":@[@"protected-fixture"],@"groups":@[],@"options":@{}};
}
static AdmissionPolicy *NewPolicy(void) {
    return [[AdmissionPolicy alloc]initWithAccountID:account profile:Profile() revealed:NO revision:23 blocked:NO];
}
static AdmissionProjection *Projection(NSUInteger n,BOOL unsafe) {
    NSMutableArray *rows=[NSMutableArray array];
    for(NSUInteger i=0;i<n;i++) {
        NSUInteger indexes[]={0,i};
        NSString *name=unsafe && i==n-1 ? @"protected-fixture" : [NSString stringWithFormat:@"safe-fixture-%lu",(unsigned long)i];
        [rows addObject:[[CSGroupRow alloc]initWithNativePath:[NSIndexPath indexPathWithIndexes:indexes length:2] userName:name kind:CSGroupRowKindSession category:CSGroupRowCategoryPrivate top:NO unreadCount:0 redDot:NO]];
    }
    AdmissionProjection *projection=[[AdmissionProjection alloc]initWithSections:@[rows] tabs:@[[WESessionTabItem tabWithType:WETabTypeAll]] selectedTabID:@"preset_0" filterDuplicates:NO accountID:account hiddenUserNames:[NSSet set] privacyRevision:policy.revision previousProjection:nil];
    projection.fixtureRevisionKnown=YES;projection.fixtureRevision=policy.revision;
    return projection;
}
static CSGroupListAdapter *Fresh(void) {
    runtimeProvider=nil;account=@"admission-fixture-account";epoch=7;policy=NewPolicy();
    CSGroupListAdapter *adapter=[CSGroupListAdapter new];adapter.active=YES;adapter.snapshotEpoch=epoch;
    adapter.table=[AdmissionTable new];adapter.table.visibleCells=@[[UITableViewCell new],[UITableViewCell new],[UITableViewCell new]];
    adapter.projection=Projection(32,NO);
    snapshotReads=0;rowChecks=0;originalLayouts=0;
    return adapter;
}
static void Layout(CSGroupListAdapter *adapter) {
    CSGroupWithNativeIndices(adapter.table,^{
        [adapter performSessionListLayout:^{originalLayouts++;Check(!CSGroupUsesNativeIndices(adapter.table),@"original consumes display coordinates");}];
        Check(CSGroupUsesNativeIndices(adapter.table),@"admission restores caller index scope");
    });
}
static BOOL AllHidden(CSGroupListAdapter *adapter) {
    for(UITableViewCell *cell in adapter.table.visibleCells)if(!cell.hidden)return NO;
    return YES;
}
static void Record(NSString *name,CSGroupListAdapter *adapter) {
    NSDictionary *data=@{@"case":name,@"snapshotReads":@(snapshotReads),@"rowHidesQueries":@(rowChecks),@"originalLayouts":@(originalLayouts),@"held":@(adapter.sessionLayoutHeld),@"hiddenCells":@(AllHidden(adapter)?adapter.table.visibleCells.count:0),@"requests":@(adapter.layoutRequests),@"dirty":@(adapter.dirty)};
    NSData *json=[NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingSortedKeys error:NULL];
    printf("ADMISSION %s\n",[[[NSString alloc]initWithData:json encoding:NSUTF8StringEncoding] UTF8String]);
}
static void Warm(CSGroupListAdapter *adapter) { Layout(adapter);snapshotReads=0;rowChecks=0;originalLayouts=0; }
static void CheckHeld(CSGroupListAdapter *adapter,NSString *name) {
    Check(!originalLayouts && adapter.sessionLayoutHeld && AllHidden(adapter),[name stringByAppendingString:@": no original layout and all visible content shielded"]);
}
@interface AdmissionRuntimeStore : NSObject
@property(nonatomic,copy) NSDictionary *fixtureState;
- (NSDictionary *)loadStateForAccountID:(NSString *)name error:(NSError **)error;
@end
@implementation AdmissionRuntimeStore
- (NSDictionary *)loadStateForAccountID:(NSString *)name error:(NSError **)error { (void)name;(void)error;return self.fixtureState; }
@end
int main(void) { @autoreleasepool {
    CSGroupListAdapter *adapter=Fresh();
    for(NSUInteger i=0;i<25;i++)Layout(adapter);
    Record(@"stable-K25-N32",adapter);
    Check(rowChecks==32,@"25 stable layouts scan the 32-row projection exactly once");
    Check(originalLayouts==25 && !adapter.sessionLayoutHeld,@"all 25 stable layouts execute original layout");
    Check(snapshotReads==50,@"every stable layout still reads policy before and after original");
    Check(!adapter.layoutRequests && !adapter.dirty,@"stable admission adds no refresh or dirty event");

    adapter=Fresh();Warm(adapter);adapter.projection=Projection(32,NO);Layout(adapter);Record(@"new-projection-identity",adapter);
    Check(rowChecks==32 && originalLayouts==1,@"new immutable projection identity requires one new scan");
    adapter=Fresh();Warm(adapter);policy=NewPolicy();Layout(adapter);Record(@"new-policy-identity",adapter);
    Check(rowChecks==32 && originalLayouts==1,@"new policy identity with equal values requires a new scan");

    // Deliberately mutate one read-only snapshot ivar through KVC only in this hostile
    // fixture, keeping object identity/revision fixed to isolate each key input.
    for(NSString *field in @[@"enabled",@"revealed",@"hideSessions"]) {
        adapter=Fresh();Warm(adapter);
        if([field isEqual:@"hideSessions"]){NSMutableDictionary *options=[policy.options mutableCopy];options[field]=@NO;[policy setValue:options forKey:@"options"];}
        else [policy setValue:@([field isEqual:@"revealed"]) forKey:field];
        Layout(adapter);Record([@"same-policy-mutated-" stringByAppendingString:field],adapter);
        Check(rowChecks==32 && originalLayouts==1,[field stringByAppendingString:@" change invalidates the scan despite stable policy identity/revision"]);
        rowChecks=0;originalLayouts=0;Layout(adapter);
        Check(rowChecks==0 && originalLayouts==1,[field stringByAppendingString:@" stable changed value is reused only after its fresh scan"]);
    }
    adapter=Fresh();Warm(adapter);NSMutableDictionary *unknownOptions=[policy.options mutableCopy];unknownOptions[@"hideSessions"]=@"untyped-value";[policy setValue:unknownOptions forKey:@"options"];
    for(NSUInteger i=0;i<3;i++)Layout(adapter);Record(@"unknown-hideSessions-type",adapter);
    Check(rowChecks==96 && originalLayouts==3,@"unknown hideSessions type preserves old scan path on every layout");

    adapter=Fresh();Warm(adapter);[policy setValue:@YES forKey:@"blocked"];Layout(adapter);CheckHeld(adapter,@"blocked policy");
    [policy setValue:@NO forKey:@"blocked"];Layout(adapter);Record(@"blocked-then-ready",adapter);
    Check(rowChecks==32 && originalLayouts==1,@"blocked transition discards earlier admission before ready resumes");
    adapter=Fresh();Warm(adapter);epoch++;Layout(adapter);CheckHeld(adapter,@"new epoch with old snapshot");
    adapter.snapshotEpoch=epoch;Layout(adapter);Record(@"epoch-then-ready",adapter);
    Check(rowChecks==32 && originalLayouts==1,@"ready epoch performs fresh scan after refusing stale epoch");
    adapter=Fresh();Warm(adapter);account=@"other-fixture-account";Layout(adapter);CheckHeld(adapter,@"account switch");
    account=@"admission-fixture-account";Layout(adapter);Record(@"account-then-ready",adapter);
    Check(rowChecks==32 && originalLayouts==1,@"account boundary discards earlier admission before restoring account");
    adapter=Fresh();Warm(adapter);[policy setValue:@24 forKey:@"revision"];Layout(adapter);CheckHeld(adapter,@"new policy revision");
    ((AdmissionProjection *)adapter.projection).fixtureRevision=24;Layout(adapter);Record(@"revision-then-ready",adapter);
    Check(rowChecks==32 && originalLayouts==1,@"matching fresh privacy revision requires scan even with same projection identity");
    adapter=Fresh();Warm(adapter);((AdmissionProjection *)adapter.projection).fixtureRevisionKnown=NO;Layout(adapter);CheckHeld(adapter,@"unknown projection revision");
    ((AdmissionProjection *)adapter.projection).fixtureRevisionKnown=YES;Layout(adapter);Record(@"unknown-projection-revision-then-known",adapter);
    Check(rowChecks==32 && originalLayouts==1,@"unknown revision never reuses prior proof when readability returns");
    adapter=Fresh();Warm(adapter);adapter.snapshotRetryAttempted=YES;Layout(adapter);CheckHeld(adapter,@"retry placeholder");
    adapter.snapshotRetryAttempted=NO;Layout(adapter);Record(@"retry-then-ready",adapter);
    Check(rowChecks==32 && originalLayouts==1,@"retry placeholder discards prior admission before ready resumes");
    adapter=Fresh();Warm(adapter);AdmissionTable *replacement=[AdmissionTable new];replacement.visibleCells=adapter.table.visibleCells;adapter.table=replacement;Layout(adapter);Record(@"table-identity",adapter);
    Check(rowChecks==32 && originalLayouts==1,@"replacement table does not reuse an admission from the old table");
    adapter=Fresh();Warm(adapter);[adapter invalidateNativeSnapshot];Layout(adapter);Record(@"native-invalidation",adapter);
    Check(rowChecks==32 && originalLayouts==1,@"explicit native invalidation discards admission for same projection and policy");

    adapter=Fresh();adapter.pageActive=YES;adapter.projection=Projection(32,YES);Layout(adapter);Record(@"unsafe-projection",adapter);
    CheckHeld(adapter,@"hidden row in projection");
    Check(!adapter.pageActive && adapter.pageCancellations==1 && adapter.pageCancelledBeforeShield,@"unsafe layout synchronously removes the sibling page snapshot before shielding cells");
    Check(adapter.dirty && adapter.layoutRequests==1,@"hidden row requests one event-driven filtered publication");
    rowChecks=0;Layout(adapter);Check(!originalLayouts && rowChecks>0,@"failed scan is never accepted as a reusable successful admission");
    adapter=Fresh();Warm(adapter);adapter.projection=Projection(32,YES);Layout(adapter);Record(@"safe-then-unsafe-identity",adapter);
    CheckHeld(adapter,@"unsafe replacement projection");
    adapter=Fresh();adapter.pageActive=YES;[adapter performSessionListLayout:^{originalLayouts++;policy=[[AdmissionPolicy alloc]initWithAccountID:account profile:Profile() revealed:NO revision:24 blocked:NO];}];Record(@"policy-changed-during-original",adapter);
    Check(originalLayouts==1 && adapter.sessionLayoutHeld && AllHidden(adapter) && adapter.dirty && adapter.layoutRequests==1,@"policy change during original shields before returning and marks one recovery");
    Check(!adapter.pageActive && adapter.pageCancellations==1 && adapter.pageCancelledBeforeShield,@"policy invalidation inside layout cancels the page snapshot before its synchronous shielding return");
    ((AdmissionProjection *)adapter.projection).fixtureRevision=24;snapshotReads=0;rowChecks=0;originalLayouts=0;Layout(adapter);
    Check(rowChecks==32 && originalLayouts==1,@"post-layout policy change cannot preserve an old successful admission");

    adapter=Fresh();adapter.pageActive=YES;
    NSArray *safeRows=adapter.projection.sections.firstObject;
    for (NSUInteger i=0;i<adapter.table.visibleCells.count;i++)
        objc_setAssociatedObject(adapter.table.visibleCells[i],&CellRowKey,@{@"row":safeRows[i],@"account":account},OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [adapter prepareForVisibility];
    Check(adapter.pageActive && !adapter.pageCancellations && !adapter.sessionLayoutHeld && !adapter.layoutRequests,
        @"a proven safe visibility boundary preserves the active page snapshot without adding recovery");
    policy=[[AdmissionPolicy alloc]initWithAccountID:account profile:Profile() revealed:NO revision:24 blocked:NO];
    [adapter prepareForVisibility];
    Check(!adapter.pageActive && adapter.pageCancellations==1 && adapter.pageCancelledBeforeShield && AllHidden(adapter) && adapter.sessionLayoutHeld && !originalLayouts,
        @"unsafe visibility synchronously cancels the sibling page snapshot before cell shielding and before any native layout");

    // This uses the real runtime snapshot getter and monotonic expiry, with only
    // persistence/credentials replaced by in-memory providers. No disk or real account.
    adapter=Fresh();AdmissionRuntimeStore *store=[AdmissionRuntimeStore new];store.fixtureState=@{@"profile":CSCloseFriendNormalizeProfile(Profile(),NULL),@"muteRecords":@{}};
    __block NSTimeInterval elapsed=1000;
    NSDictionary *credential=@{@"salt":[NSMutableData dataWithLength:32],@"verifier":[NSMutableData dataWithLength:32],@"iterations":@210000,@"failures":@0,@"cooldown":@0};
    runtimeProvider=[[CSCloseFriendRuntime alloc]initWithStore:(id)store wallClock:^NSTimeInterval{return 10000;} elapsedClock:^NSTimeInterval{return elapsed;} credentialReader:^NSDictionary *(NSString *name,NSError **error){(void)name;(void)error;return credential;} credentialWriter:^BOOL(NSString *name,NSDictionary *value,NSError **error){(void)name;(void)value;(void)error;return YES;}];
    [runtimeProvider synchronizeAccount:account epoch:epoch suspended:NO];
    Check([runtimeProvider revealWithShortcutToken:runtimeProvider.authenticationToken],@"real runtime fixture obtains temporary reveal through its public API");
    CSCloseFriendSnapshot *unlocked=CSCloseFriendCurrentSnapshot();policy=unlocked;adapter.projection=Projection(32,YES);
    for(NSUInteger i=0;i<25;i++)Layout(adapter);
    Check(originalLayouts==25 && !adapter.sessionLayoutHeld,@"unlocked runtime retains existing visibility during stable layouts");
    NSUInteger unlockedRevision=unlocked.revision;elapsed+=301;originalLayouts=0;Layout(adapter);Record(@"real-runtime-expiry",adapter);
    CheckHeld(adapter,@"expired reveal on next layout");
    CSCloseFriendSnapshot *locked=CSCloseFriendCurrentSnapshot();
    Check(!locked.revealed && locked.revision>unlockedRevision,@"real runtime expiry changes revealed flag and revision at snapshot read");
    Check(adapter.dirty && adapter.layoutRequests==1,@"expired reveal requests filtered publication without a timer or extra delay");
    runtimeProvider=nil;
    printf("Privacy admission cache: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
    return failures?1:0;
} }
