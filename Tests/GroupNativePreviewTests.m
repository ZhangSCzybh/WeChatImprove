#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>
#include <limits.h>

// Replay the production preview API and native group publication together.
// Host ABI, policy identity getters and native setters are bounded inputs.
static NSUInteger checks,failures;
static void Check(BOOL result,NSString *message) { checks++;if (!result) { failures++;fprintf(stderr,"FAIL: %s\n",message.UTF8String); } }
typedef NS_ENUM(NSUInteger,CSCloseFriendSurface) { CSCloseFriendSurfaceSession=1 };
typedef NS_OPTIONS(NSUInteger,CSGroupChangeKind) { CSGroupChangeUnknown=1,CSGroupChangeStructure=2 };
static NSString *currentAccount;
static NSUInteger accountEpoch;
static BOOL enabled,suspended;
static NSUInteger accountReads,serviceReads,permitsReads,identityReads;
static NSString *CSGroupCurrentAccountID(void) { accountReads++;return currentAccount; }
static NSUInteger CSCloseFriendAccountEpoch(void) { return accountEpoch; }
static BOOL CSBackupAccountIsSuspended(void) { return suspended; }
static BOOL CSNativeGroupEnabled(void) { return enabled; }

@interface CSCloseFriendSnapshot : NSObject
@property(nonatomic) BOOL blocked;
@property(nonatomic) NSUInteger revision;
@property(nonatomic,copy) NSString *accountID;
@property(nonatomic,copy) NSDictionary *options;
@property(nonatomic,copy) NSSet *protectedUserNames;
- (BOOL)concealsSurface:(CSCloseFriendSurface)surface;
@end
@implementation CSCloseFriendSnapshot
- (BOOL)concealsSurface:(CSCloseFriendSurface)surface { (void)surface;return [self.options[@"hideSessions"] boolValue]; }
@end
static CSCloseFriendSnapshot *policy;
static CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) { return policy; }
@interface WESessionTabItem : NSObject
@property(nonatomic,copy) NSString *tabId,*tabName;
@property(nonatomic,copy) NSArray *sessionUserNames;
@property(nonatomic) NSInteger type;
@end
@implementation WESessionTabItem @end
@interface CSGroupPreferences : NSObject
@property(nonatomic,copy) NSString *accountID,*selectedTabID;
@property(nonatomic,copy) NSArray *tabs;
@property(nonatomic) BOOL filterDuplicates;
@property(nonatomic) NSUInteger selectionWrites;
- (instancetype)initWithDefaults:(NSUserDefaults *)defaults accountID:(NSString *)accountID;
- (void)reload;
@end
@implementation CSGroupPreferences
- (instancetype)initWithDefaults:(NSUserDefaults *)defaults accountID:(NSString *)accountID { (void)defaults;if ((self=[super init])) _accountID=accountID;return self; }
- (void)reload {}
- (void)setSelectedTabID:(NSString *)selectedTabID { _selectedTabID=[selectedTabID copy];self.selectionWrites++; }
@end
@interface NativeSession : NSObject
@property(nonatomic,copy) NSString *name,*tabID;
@end
@implementation NativeSession @end
@interface MainSessionMgr : NSObject
@property(nonatomic,copy) NSArray *topSessions,*normalSessions,*allTopSessions;
@property(nonatomic) long long totalTopSessionCount,chatBoxMinIndex;
@end
@implementation MainSessionMgr @end
static MainSessionMgr *registeredManager;
static id CSNativeService(NSString *name) { serviceReads++;return [name isEqual:@"MainSessionMgr"] ? registeredManager : nil; }
static BOOL CSNativeManagerSupported(id manager) { return [manager isKindOfClass:MainSessionMgr.class]; }
static id CSGroupReadObject(id object,NSString *key) { return [object valueForKey:key]; }
static long long CSGroupReadInteger(id object,NSString *key,long long fallback) { return object ? [[object valueForKey:key] longLongValue] : fallback; }
static BOOL CSNativeSameObjects(NSArray *left,NSArray *right) {
    if (left==right) return YES;if (left.count!=right.count) return NO;
    for (NSUInteger i=0;i<left.count;i++) if (left[i]!=right[i]) return NO;return YES;
}
@interface CSGroupRow : NSObject @end
@implementation CSGroupRow @end
static CSGroupRow *CSGroupRowForNativeSession(id session,NSIndexPath *path,BOOL top) { (void)session;(void)path;(void)top;return [CSGroupRow new]; }
static NSArray *CSGroupCopyFoldedRowsSelectingSummary(CSGroupRow *(^selection)(NSArray *rows)) { (void)selection;return @[]; }
@interface CSNativeSessionBaseline : NSObject
@property(nonatomic,copy) NSArray *top,*normal,*allTop,*statisticsSessions;
@property(nonatomic,copy) NSString *accountID;
@property(nonatomic) NSUInteger epoch;
@property(nonatomic) long long totalTopCount,chatBoxMinIndex;
@property(nonatomic) BOOL hasChatBoxMinIndex;
@property(nonatomic,strong) CSNativeSessionBaseline *incrementalOrigin;
@end
@implementation CSNativeSessionBaseline @end
@interface CSGroupNativeModelResult : NSObject
@property(nonatomic,getter=isValid) BOOL valid;
@property(nonatomic,copy) NSString *selectedTabID;
@property(nonatomic,copy) NSArray *topSessions,*normalSessions,*allTopSessions,*inputTop,*inputNormal,*inputAllTop;
@property(nonatomic,copy) NSSet *hidden;
@property(nonatomic) NSUInteger totalTopSessionCount;
@end
@implementation CSGroupNativeModelResult @end
static CSGroupNativeModelResult *SelectedModel(NSArray *top,NSArray *normal,NSArray *allTop,NSString *selected,NSSet *hidden,BOOL grouping) {
    CSGroupNativeModelResult *model=[CSGroupNativeModelResult new];model.valid=YES;model.selectedTabID=selected;
    model.inputTop=top;model.inputNormal=normal;model.inputAllTop=allTop;model.hidden=hidden;
    NSArray *(^filter)(NSArray *)=^NSArray *(NSArray *objects) {
        NSMutableArray *kept=[NSMutableArray array];
        for (NativeSession *session in objects) if (![hidden containsObject:session.name] &&
            (!grouping || [selected isEqual:@"preset_0"] || [selected isEqual:session.tabID])) [kept addObject:session];
        return kept;
    };
    model.topSessions=filter(top);model.normalSessions=filter(normal);model.allTopSessions=filter(allTop);
    model.totalTopSessionCount=model.allTopSessions.count;return model;
}
@interface CSGroupNativeModel : NSObject
+ (CSGroupNativeModelResult *)modelBySelectingTabID:(NSString *)tabID fromResult:(CSGroupNativeModelResult *)result foldedRows:(NSArray *)folded;
+ (CSGroupNativeModelResult *)modelByUpdatingResult:(CSGroupNativeModelResult *)result changedUserNames:(NSSet *)names rowProvider:(CSGroupRow *(^)(id,NSIndexPath *,BOOL))provider;
+ (CSGroupNativeModelResult *)buildWithTopSessions:(NSArray *)top normalSessions:(NSArray *)normal allTopSessions:(NSArray *)allTop allSessions:(NSArray *)all tabs:(NSArray *)tabs selectedTabID:(NSString *)selected groupingEnabled:(BOOL)grouping filterDuplicates:(BOOL)duplicates accountID:(NSString *)account hiddenUserNames:(NSSet *)hidden privacyRevision:(NSUInteger)revision scopeFoldedEntry:(BOOL)scope foldedRows:(NSArray *)folded rowProvider:(CSGroupRow *(^)(id,NSIndexPath *,BOOL))provider;
@end
@implementation CSGroupNativeModel
+ (CSGroupNativeModelResult *)modelBySelectingTabID:(NSString *)tabID fromResult:(CSGroupNativeModelResult *)result foldedRows:(NSArray *)folded {
    (void)folded;return SelectedModel(result.inputTop,result.inputNormal,result.inputAllTop,tabID,result.hidden,YES);
}
+ (CSGroupNativeModelResult *)modelByUpdatingResult:(CSGroupNativeModelResult *)result changedUserNames:(NSSet *)names rowProvider:(CSGroupRow *(^)(id,NSIndexPath *,BOOL))provider { (void)names;(void)provider;return result; }
+ (CSGroupNativeModelResult *)buildWithTopSessions:(NSArray *)top normalSessions:(NSArray *)normal allTopSessions:(NSArray *)allTop allSessions:(NSArray *)all tabs:(NSArray *)tabs selectedTabID:(NSString *)selected groupingEnabled:(BOOL)grouping filterDuplicates:(BOOL)duplicates accountID:(NSString *)account hiddenUserNames:(NSSet *)hidden privacyRevision:(NSUInteger)revision scopeFoldedEntry:(BOOL)scope foldedRows:(NSArray *)folded rowProvider:(CSGroupRow *(^)(id,NSIndexPath *,BOOL))provider {
    (void)all;(void)tabs;(void)duplicates;(void)account;(void)revision;(void)scope;(void)folded;(void)provider;
    return SelectedModel(top,normal,allTop,selected,hidden,grouping);
}
@end
@interface CSGroupNativeSessionCoordinator : NSObject
@property(nonatomic,strong) id mainController;
@property(nonatomic,strong) MainSessionMgr *manager;
@property(nonatomic,strong) CSNativeSessionBaseline *baseline,*cachedModelBaseline,*pagePreviewBaseline;
@property(nonatomic,strong) CSGroupPreferences *preferences;
@property(nonatomic,strong) CSGroupNativeModelResult *model,*cachedModel;
@property(nonatomic) BOOL applied,boundary,dirty,compatibilityFallback,restoringCompatibilityFallback,nativePresentation;
@property(nonatomic) BOOL refreshing,restoringCompleteSource,pendingNativeChangesKnown,publicationRecoveryPending,sourceChanged,failNextWrite;
@property(nonatomic) NSUInteger revision,epoch,privacyRevision,depth,publicationDepth,completeSourceDepth,changeScopeDepth;
@property(nonatomic) NSUInteger publicationMutationRevision,publicationRecoveryAttempts,refreshCount;
@property(nonatomic,copy) NSString *accountID,*pagePreviewTabID,*pagePreviewAccount,*pagePreviewSourceTabID;
@property(nonatomic,weak) id pagePreviewOwner,pagePreviewManager;
@property(nonatomic,copy) NSArray *cachedModelKey,*pagePreviewConfiguration;
@property(nonatomic) NSUInteger pagePreviewEpoch,pagePreviewPrivacyRevision,pagePreviewRevision;
@property(nonatomic) CSGroupChangeKind pendingNativeKind;
@property(nonatomic,copy) NSSet *pendingNativeNames;
@property(nonatomic,copy) void (^onPolicyValidation)(void),(^onWrite)(void);
- (void)clearPagePreview;
- (BOOL)pagePreviewContextMatchesPolicy:(CSCloseFriendSnapshot *)policy;
- (NSString *)effectiveSelectedTabIDForPolicy:(CSCloseFriendSnapshot *)policy grouping:(BOOL)grouping;
- (BOOL)pagePreviewTokenIsValidForOwner:(id)owner;
- (BOOL)pagePreviewIsValidForOwner:(id)owner;
- (BOOL)beginPagePreviewForTabID:(NSString *)tabID owner:(id)owner;
- (void)endPagePreviewForOwner:(id)owner;
- (NSArray *)modelKeyForPolicy:(CSCloseFriendSnapshot *)policy grouping:(BOOL)grouping;
- (void)applyBaselineCandidate;
- (void)invalidateNativeData;
- (void)privacyChanged:(NSNotification *)notification;
- (BOOL)permitsSelectedGroup;
- (BOOL)accountMatchesBaseline:(CSNativeSessionBaseline *)baseline;
- (BOOL)completeSourcePolicy:(CSCloseFriendSnapshot *)snapshot matchesBaseline:(CSNativeSessionBaseline *)baseline surface:(CSCloseFriendSurface)surface;
- (void)refreshFromPreferences;
- (void)closeNativePublication;
- (void)useCompatibilityFallback;
- (BOOL)writeTop:(NSArray *)top normal:(NSArray *)normal allTop:(NSArray *)allTop total:(long long)total restoreGeometry:(BOOL)restore;
- (BOOL)recordCompatibilityNativeChange;
- (void)recordChangeNames:(NSSet *)names kind:(CSGroupChangeKind)kind;
- (void)queueRefresh;
@end
@implementation CSGroupNativeSessionCoordinator
- (BOOL)permitsSelectedGroup { permitsReads++;return !self.nativePresentation && self.mainController!=nil; }
- (BOOL)accountMatchesBaseline:(CSNativeSessionBaseline *)baseline { return baseline && !suspended && baseline.epoch==accountEpoch && [baseline.accountID isEqual:currentAccount]; }
- (BOOL)completeSourcePolicy:(CSCloseFriendSnapshot *)snapshot matchesBaseline:(CSNativeSessionBaseline *)baseline surface:(CSCloseFriendSurface)surface {
    identityReads++;
    (void)surface;
    if (self.onPolicyValidation) { void (^action)(void)=self.onPolicyValidation;self.onPolicyValidation=nil;action(); }
    return [self accountMatchesBaseline:baseline] && !policy.blocked && snapshot.revision==policy.revision &&
        [snapshot.accountID isEqual:baseline.accountID] && [policy.options[@"hideSessions"] isKindOfClass:NSNumber.class];
}
- (void)refreshFromPreferences {
    self.refreshCount++;
    if (self.depth || self.publicationDepth || self.refreshing) return;
    self.refreshing=YES;[self applyBaselineCandidate];self.refreshing=NO;
}
- (void)closeNativePublication { self.boundary=YES;self.model=nil; }
- (void)useCompatibilityFallback { self.compatibilityFallback=YES;[self closeNativePublication]; }
- (BOOL)writeTop:(NSArray *)top normal:(NSArray *)normal allTop:(NSArray *)allTop total:(long long)total restoreGeometry:(BOOL)restore {
    if (self.failNextWrite) { self.failNextWrite=NO;return NO; }
    self.manager.topSessions=top;self.manager.normalSessions=normal;self.manager.allTopSessions=allTop;self.manager.totalTopSessionCount=total;
    if (restore && self.baseline.hasChatBoxMinIndex) self.manager.chatBoxMinIndex=self.baseline.chatBoxMinIndex;
    if (self.onWrite) { void (^action)(void)=self.onWrite;self.onWrite=nil;action(); }
    return YES;
}
- (BOOL)recordCompatibilityNativeChange { return NO; }
- (void)recordChangeNames:(NSSet *)names kind:(CSGroupChangeKind)kind { (void)names;self.pendingNativeKind|=kind; }
- (void)queueRefresh {}
#include "GroupNativePreviewUnderTest.h"
@end

static CSGroupNativeSessionCoordinator *Fixture(void) {
    enabled=YES;suspended=NO;currentAccount=@"account";accountEpoch=7;
    policy=[CSCloseFriendSnapshot new];policy.accountID=currentAccount;policy.revision=11;
    policy.options=@{@"hideSessions":@YES};policy.protectedUserNames=[NSSet setWithObject:@"secret"];
    registeredManager=[MainSessionMgr new];
    CSGroupNativeSessionCoordinator *c=[CSGroupNativeSessionCoordinator new];c.mainController=[NSObject new];c.manager=registeredManager;
    c.preferences=[[CSGroupPreferences alloc] initWithDefaults:NSUserDefaults.standardUserDefaults accountID:currentAccount];
    c.preferences.selectedTabID=@"source";NSMutableArray *tabs=[NSMutableArray array];
    for (NSString *name in @[@"source",@"target",@"other"]) { WESessionTabItem *tab=[WESessionTabItem new];tab.tabId=name;tab.tabName=name;tab.sessionUserNames=@[];[tabs addObject:tab]; }
    c.preferences.tabs=tabs;
    NSMutableArray *sessions=[NSMutableArray array];
    for (NSArray *record in @[@[@"a",@"source"],@[@"b",@"target"],@[@"secret",@"target"],@[@"c",@"other"]]) {
        NativeSession *session=[NativeSession new];session.name=record[0];session.tabID=record[1];[sessions addObject:session];
    }
    c.baseline=[CSNativeSessionBaseline new];c.baseline.accountID=currentAccount;c.baseline.epoch=accountEpoch;
    c.baseline.top=@[];c.baseline.normal=sessions;c.baseline.allTop=@[];c.baseline.statisticsSessions=sessions;c.revision=50;
    [c refreshFromPreferences];c.preferences.selectionWrites=0;c.refreshCount=0;return c;
}
static void TestNativePublicationAndPersistence(void) {
    CSGroupNativeSessionCoordinator *c=Fixture();id owner=c.mainController;
    NSArray *baseline=c.baseline.normal;NativeSession *target=baseline[1];
    Check([c.manager.normalSessions isEqual:@[baseline[0]]],@"fixture publishes source native objects");
    Check([c beginPagePreviewForTabID:@"target" owner:owner],@"stable source accepts target preview");
    Check([c.pagePreviewTabID isEqual:@"target"] && [c.model.selectedTabID isEqual:@"target"],@"override publishes real target model");
    Check(c.manager.normalSessions.count==1 && c.manager.normalSessions[0]==target,@"preview applies original target session object and excludes protected session");
    Check([c.preferences.selectedTabID isEqual:@"source"] && !c.preferences.selectionWrites,@"begin never persists target selection");
    Check(c.baseline.normal==baseline && c.revision==50,@"preview preserves complete source and source revision");
    [c refreshFromPreferences];Check([c.model.selectedTabID isEqual:@"target"] && [c pagePreviewIsValidForOwner:owner],@"routine refresh keeps valid preview target");
    [c endPagePreviewForOwner:owner];
    Check(!c.pagePreviewTabID && [c.model.selectedTabID isEqual:@"source"] && c.manager.normalSessions[0]==baseline[0],@"cancel synchronously restores committed source objects");
    Check(!c.preferences.selectionWrites,@"cancel never writes selection");
    Check([c beginPagePreviewForTabID:@"target" owner:owner],@"second preview begins after cancellation");
    c.preferences.selectedTabID=@"target";
    Check([c pagePreviewIsValidForOwner:owner],@"verified target preference can precede ending preview");
    [c endPagePreviewForOwner:owner];
    Check(!c.pagePreviewTabID && [c.model.selectedTabID isEqual:@"target"] && c.manager.normalSessions[0]==target,@"commit keeps same native target objects after override removal");
    Check(c.preferences.selectionWrites==1,@"only caller's explicit commit writes preferences");
}
static void TestAdmissionAndOwnership(void) {
    for (NSString *key in @[@"depth",@"publicationDepth",@"refreshing",@"completeSourceDepth",@"restoringCompleteSource",@"boundary",@"dirty",@"compatibilityFallback",@"restoringCompatibilityFallback",@"nativePresentation"]) {
        CSGroupNativeSessionCoordinator *c=Fixture();[c setValue:@1 forKey:key];
        Check(![c beginPagePreviewForTabID:@"target" owner:c.mainController] && !c.pagePreviewTabID,[NSString stringWithFormat:@"%@ rejects preview before takeover",key]);
    }
    CSGroupNativeSessionCoordinator *c=Fixture();id owner=c.mainController;id other=[NSObject new];
    Check(![c beginPagePreviewForTabID:@"target" owner:other],@"unrelated owner cannot take over shared native manager");
    Check(![c beginPagePreviewForTabID:@"source" owner:owner] && ![c beginPagePreviewForTabID:@"missing" owner:owner],@"source and missing tabs cannot start preview");
    Check([c beginPagePreviewForTabID:@"target" owner:owner],@"valid owner starts preview");
    Check(![c beginPagePreviewForTabID:@"other" owner:owner],@"nested takeover is rejected");
    [c endPagePreviewForOwner:other];Check([c pagePreviewIsValidForOwner:owner],@"unrelated owner cannot end active preview");
    c=Fixture();registeredManager=[MainSessionMgr new];Check(![c beginPagePreviewForTabID:@"target" owner:c.mainController],@"different registered account manager rejects takeover");
}
static void TestInvalidationBarriers(void) {
    for (NSString *key in @[@"revision",@"epoch",@"policy",@"account",@"baseline",@"configuration",@"selection",@"manager",@"controller",@"blocked",@"suspended",@"disabled"]) {
        CSGroupNativeSessionCoordinator *c=Fixture();id owner=c.mainController;Check([c beginPagePreviewForTabID:@"target" owner:owner],@"invalidation fixture begins");
        if ([key isEqual:@"revision"]) c.revision++;
        else if ([key isEqual:@"epoch"]) accountEpoch++;
        else if ([key isEqual:@"policy"]) policy.revision++;
        else if ([key isEqual:@"account"]) currentAccount=@"other-account";
        else if ([key isEqual:@"baseline"]) { CSNativeSessionBaseline *newBaseline=[CSNativeSessionBaseline new];newBaseline.accountID=currentAccount;newBaseline.epoch=accountEpoch;c.baseline=newBaseline; }
        else if ([key isEqual:@"configuration"]) ((WESessionTabItem *)c.preferences.tabs[1]).tabName=@"changed";
        else if ([key isEqual:@"selection"]) c.preferences.selectedTabID=@"other";
        else if ([key isEqual:@"manager"]) registeredManager=[MainSessionMgr new];
        else if ([key isEqual:@"controller"]) c.mainController=[NSObject new];
        else if ([key isEqual:@"blocked"]) policy.blocked=YES;
        else if ([key isEqual:@"suspended"]) suspended=YES;
        else enabled=NO;
        Check(![c pagePreviewIsValidForOwner:owner],[NSString stringWithFormat:@"%@ invalidates copied target pages",key]);
    }
    CSGroupNativeSessionCoordinator *c=Fixture();id owner=c.mainController;[c beginPagePreviewForTabID:@"target" owner:owner];
    c.revision++;[c refreshFromPreferences];Check(!c.pagePreviewTabID && [c.model.selectedTabID isEqual:@"source"],@"source revision change drops override before next publication");
    c=Fixture();owner=c.mainController;[c beginPagePreviewForTabID:@"target" owner:owner];[c invalidateNativeData];
    Check(!c.pagePreviewTabID && c.dirty && ![c pagePreviewIsValidForOwner:owner],@"native invalidation immediately releases preview token");
    c.dirty=NO;[c endPagePreviewForOwner:owner];Check([c.model.selectedTabID isEqual:@"source"],@"owner can restore after source invalidation cleared token");
    c=Fixture();owner=c.mainController;[c beginPagePreviewForTabID:@"target" owner:owner];policy.revision++;[c privacyChanged:nil];
    Check(!c.pagePreviewTabID && [c.model.selectedTabID isEqual:@"source"],@"policy change clears preview and synchronously applies current privacy to source");
}
static void TestReentrantHostCallbacks(void) {
    CSGroupNativeSessionCoordinator *c=Fixture();id owner=c.mainController;
    c.failNextWrite=YES;Check(![c beginPagePreviewForTabID:@"target" owner:owner],@"failed target setter cannot accept preview");
    Check(!c.pagePreviewTabID && [c.model.selectedTabID isEqual:@"source"],@"failed preparation restores source before returning");
    c=Fixture();owner=c.mainController;__weak CSGroupNativeSessionCoordinator *weak=c;
    c.onWrite=^{ [weak invalidateNativeData]; };
    Check(![c beginPagePreviewForTabID:@"target" owner:owner] && !c.pagePreviewTabID,@"native callback during target setters invalidates publication and preview");
    c=Fixture();owner=c.mainController;[c beginPagePreviewForTabID:@"target" owner:owner];
    c.onPolicyValidation=^{ policy.revision++; };
    Check(![c pagePreviewIsValidForOwner:owner],@"identity getter relocking privacy invalidates preview before return");
    c=Fixture();owner=c.mainController;[c beginPagePreviewForTabID:@"target" owner:owner];
    c.onPolicyValidation=^{ registeredManager=[MainSessionMgr new]; };
    Check(![c pagePreviewIsValidForOwner:owner],@"registered manager is rechecked after reentrant identity getters");
}
static void TestLightweightToken(void) {
    CSGroupNativeSessionCoordinator *c=Fixture();id owner=c.mainController;
    Check([c beginPagePreviewForTabID:@"target" owner:owner],@"lightweight fixture begins with full native authorization");
    accountReads=serviceReads=permitsReads=identityReads=0;
    for (NSUInteger event=0;event<120;event++) Check([c pagePreviewTokenIsValidForOwner:owner],@"unchanged gesture token stays valid");
    Check(!accountReads && !serviceReads && !permitsReads && !identityReads,@"gesture token checks perform no host account/service/visibility/identity reads");
    c.preferences.selectedTabID=@"target";
    Check([c pagePreviewTokenIsValidForOwner:owner],@"light token allows caller to persist target before ending preview");
    [c pagePreviewIsValidForOwner:owner];
    Check(accountReads && serviceReads && permitsReads && identityReads,@"full authorization still rechecks live host identity");
    for (NSString *key in @[@"depth",@"publicationDepth",@"refreshing",@"completeSourceDepth",@"restoringCompleteSource",@"boundary",@"dirty",@"compatibilityFallback",@"restoringCompatibilityFallback",@"nativePresentation"]) {
        c=Fixture();owner=c.mainController;[c beginPagePreviewForTabID:@"target" owner:owner];[c setValue:@1 forKey:key];
        Check(![c pagePreviewTokenIsValidForOwner:owner],[NSString stringWithFormat:@"%@ closes light token",key]);
    }
    for (NSString *key in @[@"revision",@"epoch",@"privacyRevision",@"policy",@"baseline",@"manager",@"controller",@"model",@"configuration",@"selection",@"blocked",@"suspended",@"disabled"]) {
        c=Fixture();owner=c.mainController;[c beginPagePreviewForTabID:@"target" owner:owner];
        if ([key isEqual:@"revision"]) c.revision++;
        else if ([key isEqual:@"epoch"]) accountEpoch++;
        else if ([key isEqual:@"privacyRevision"]) c.privacyRevision++;
        else if ([key isEqual:@"policy"]) policy.revision++;
        else if ([key isEqual:@"baseline"]) c.baseline=[CSNativeSessionBaseline new];
        else if ([key isEqual:@"manager"]) c.manager=[MainSessionMgr new];
        else if ([key isEqual:@"controller"]) c.mainController=[NSObject new];
        else if ([key isEqual:@"model"]) c.model.selectedTabID=@"source";
        else if ([key isEqual:@"configuration"]) ((WESessionTabItem *)c.preferences.tabs[0]).tabName=@"changed";
        else if ([key isEqual:@"selection"]) c.preferences.selectedTabID=@"other";
        else if ([key isEqual:@"blocked"]) policy.blocked=YES;
        else if ([key isEqual:@"suspended"]) suspended=YES;
        else enabled=NO;
        Check(![c pagePreviewTokenIsValidForOwner:owner],[NSString stringWithFormat:@"%@ revokes light gesture token",key]);
    }
}
int main(void) { @autoreleasepool {
    TestNativePublicationAndPersistence();TestAdmissionAndOwnership();TestInvalidationBarriers();TestReentrantHostCallbacks();TestLightweightToken();
    fprintf(stdout,"group native preview: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
    return failures ? 1 : 0;
} }
