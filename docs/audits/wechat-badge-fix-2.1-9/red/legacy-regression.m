#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>
#import <objc/runtime.h>
#import "CSCloseFriendPolicy.h"
#import "CSGroupProjection.h"
#import "WESessionTabItem.h"

// Controlled host boundaries. No UIKit, device, defaults, account service,
// database, live notification or tabbar-style code is loaded by this probe.
static NSUInteger Checks, Epoch=23;
static CSCloseFriendSnapshot *Policy;
static NSHashTable *AdapterOwners, *TabOwners;
static NSArray *StrongAdapters, *FoldedNames;
static NSString *CurrentAccount=@"probe-account";
static BOOL StyleLabel, MessagePhase;
static NSMutableArray *Rows;
static NSString *ScenarioName;
static NSDictionary *ProjectionTelemetry;
#define CHECK(c) do { Checks++; if (!(c)) { fprintf(stderr,"FAIL %d %s: %s\n",__LINE__,ScenarioName.UTF8String,#c); exit(1); } } while (0)

static CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) { return Policy; }
static NSUInteger CSCloseFriendAccountEpoch(void) { return Epoch; }
static NSString *CSGroupCurrentAccountID(void) { return CurrentAccount; }
static NSHashTable *Adapters(void) { return AdapterOwners; }
static BOOL CSGroupIsFoldedController(id owner) { return [owner isEqual:@"folded-fixture"]; }
typedef NS_ENUM(NSUInteger,CSGroupFoldedPrivacyState) {
    CSGroupFoldedPrivacyUnknown, CSGroupFoldedPrivacyNoHidden,
    CSGroupFoldedPrivacyMixed, CSGroupFoldedPrivacyAllHidden
};
static NSArray *CSGroupCopyFoldedUserNames(void) { return FoldedNames; }
static CSGroupFoldedPrivacyState CSGroupAssessFoldedUserNames(NSArray *names,NSSet *hidden) {
    (void)names; (void)hidden; return CSGroupFoldedPrivacyUnknown;
}
static id CSCloseFriendRead(id owner,NSString *key) {
    if ([owner isKindOfClass:NSDictionary.class]) return owner[key];
    @try { return [owner valueForKey:key]; } @catch (NSException *exception) { (void)exception; return nil; }
}

@interface CSGroupListAdapter : NSObject
@property(nonatomic,strong) id controller;
@property(nonatomic,copy) NSArray *cachedNativeSections;
@property(nonatomic,strong) NSNumber *alertBadge;
@property(nonatomic,copy) NSArray *alertBadgeKey;
@property(nonatomic) NSUInteger changeDepth,snapshotRevision,modelRevision,snapshotEpoch;
@property(nonatomic) BOOL dirty;
@property(nonatomic,copy) NSString *snapshotAccount;
+ (NSNumber *)closeFriendAlertBadgeCount;
@end
@implementation CSGroupListAdapter
#include "closeFriendAlertBadgeCount.inc"
@end

@interface NewMainFrameViewController : NSObject @end
@implementation NewMainFrameViewController @end
@interface UINavigationController : NSObject
@property(nonatomic,copy) NSArray *viewControllers;
@end
@implementation UINavigationController @end

@interface ProbeBadge : NSObject
@property(nonatomic) unsigned long long count;
@property(nonatomic,copy) NSString *string;
@property(nonatomic) BOOL hidden,dot;
@property(nonatomic) NSRect nativeFixtureFrame;
@end
@implementation ProbeBadge @end
@interface ProbeOwner : NSObject
@property(nonatomic,copy) NSArray *viewControllers;
@property(nonatomic,strong) NSArray<ProbeBadge *> *badges;
@property(nonatomic) NSUInteger numericCalls,stringCalls,dotCalls;
@end
@implementation ProbeOwner @end

#include "ChatTab.inc"

// These original IMPs are explicitly host models of native content setters.
// Their content/hidden effects are asserted as controlled fixture behavior, not
// observations of WeChat rendering, sizing, setter order or message delivery.
static void NativeNumber(id object,SEL selector,unsigned long long count,unsigned long long index) {
    (void)selector; ProbeOwner *owner=object; ProbeBadge *badge=owner.badges[index];
    owner.numericCalls++; badge.count=count; badge.string=nil; badge.dot=NO; badge.hidden=count==0;
}
static void NativeString(id object,SEL selector,id string,unsigned long long index) {
    (void)selector; ProbeOwner *owner=object; ProbeBadge *badge=owner.badges[index];
    owner.stringCalls++; badge.count=0; badge.string=string; badge.dot=NO; badge.hidden=[string length]==0;
}
static void NativeDot(id object,SEL selector,unsigned long long index) {
    (void)selector; ProbeOwner *owner=object; ProbeBadge *badge=owner.badges[index];
    owner.dotCalls++; badge.count=0; badge.string=nil; badge.dot=YES; badge.hidden=NO;
}
static IMP tab=(IMP)NativeNumber,tabString=(IMP)NativeString,dot=(IMP)NativeDot;
static void (^NumberHook)(id,unsigned long long,unsigned long long);
static void (^StringHook)(id,id,unsigned long long);
static void (^DotHook)(id,unsigned long long);

static NSDictionary *BadgeState(ProbeBadge *badge) {
    return @{@"object": [NSString stringWithFormat:@"%p",badge], @"count":@(badge.count),
        @"string":badge.string ?: NSNull.null, @"hidden":@(badge.hidden), @"dot":@(badge.dot),
        @"frame":NSStringFromRect(badge.nativeFixtureFrame), @"frameSource":@"fixed native host fixture; not device geometry"};
}
static void Emit(NSString *event,NSNumber *decision,NSDictionary *before,ProbeOwner *owner,NSUInteger index,NSArray *assertions) {
    NSMutableArray *adapterState=[NSMutableArray new];
    for (CSGroupListAdapter *adapter in StrongAdapters) [adapterState addObject:@{
        @"cachedNativeSectionsPresent":@(adapter.cachedNativeSections!=nil),@"changeDepth":@(adapter.changeDepth),
        @"dirty":@(adapter.dirty),@"snapshotRevision":@(adapter.snapshotRevision),@"modelRevision":@(adapter.modelRevision),
        @"snapshotEpoch":@(adapter.snapshotEpoch),@"snapshotAccount":adapter.snapshotAccount ?: NSNull.null,
        @"alertBadgeAtLogTime":adapter.alertBadge ?: NSNull.null}];
    NSDictionary *row=@{@"kind":@"controlled-host-content",@"scenario":ScenarioName,
        @"styleLabelOnly":@(StyleLabel),@"phase":MessagePhase?@"message":@"cold",
        @"actualMainThread":@(NSThread.isMainThread),@"event":event,
        @"replacementDecision":decision ?: NSNull.null,@"before":before,@"after":BadgeState(owner.badges[index]),
        @"nativeCalls":@{@"number":@(owner.numericCalls),@"string":@(owner.stringCalls),@"dot":@(owner.dotCalls)},
        @"controlledState":@{@"enabled":@(Policy.enabled),@"blocked":@(Policy.blocked),
            @"concealsSessionSurface":@([Policy concealsSurface:CSCloseFriendSurfaceSession]),
            @"silenceMessages":Policy.options[@"silenceMessages"],@"protectedNamesCount":@(Policy.protectedUserNames.count),
            @"currentEpoch":@(Epoch),@"currentAccount":CurrentAccount,@"adaptersAtLogTime":adapterState},
        @"independentProjection":ProjectionTelemetry ?: NSNull.null,
        @"assertions":assertions,@"siteStateObserved":@NO};
    [Rows addObject:row];
    NSData *data=[NSJSONSerialization dataWithJSONObject:row options:NSJSONWritingSortedKeys error:NULL];
    fwrite(data.bytes,1,data.length,stdout);fputc('\n',stdout);
}
static void Seed(ProbeOwner *owner) {
    owner.numericCalls=owner.stringCalls=owner.dotCalls=0;
    for (ProbeBadge *badge in owner.badges) {
        badge.count=12;badge.string=nil;badge.hidden=NO;badge.dot=NO;
        badge.nativeFixtureFrame=NSMakeRect(32,4,24,16);
    }
}
static CSGroupRow *Row(NSUInteger index,NSString *name,NSUInteger unread,BOOL redDot) {
    NSUInteger path[]={0,index};
    return [[CSGroupRow alloc] initWithNativePath:[NSIndexPath indexPathWithIndexes:path length:2]
        userName:name kind:CSGroupRowKindSession category:CSGroupRowCategoryPrivate top:NO unreadCount:unread redDot:redDot];
}
static void Configure(NSString *name) {
    ScenarioName=name; AdapterOwners=[NSHashTable weakObjectsHashTable]; StrongAdapters=@[]; FoldedNames=nil;ProjectionTelemetry=nil;
    BOOL noFilter=[name isEqual:@"no-filter"],emptyNames=[name isEqual:@"no-protected-names"];
    BOOL silence=[name isEqual:@"silence-only-no-cache"],blocked=[name isEqual:@"blocked"];
    Policy=[[CSCloseFriendSnapshot alloc] initWithAccountID:CurrentAccount
        profile:@{@"enabled":@YES,@"friends":emptyNames?@[]:@[@"protected"],@"groups":@[],
                  @"options":@{@"hideSessions":@((BOOL)(!noFilter && !silence)),@"silenceMessages":@(silence)}}
        revealed:NO revision:41 blocked:blocked];
    if ([name isEqual:@"no-adapter"] || silence) return;
    CSGroupListAdapter *adapter=[CSGroupListAdapter new]; adapter.controller=@"main-fixture";
    adapter.modelRevision=adapter.snapshotRevision=17;adapter.snapshotEpoch=Epoch;adapter.snapshotAccount=CurrentAccount;
    BOOL redDot=[name isEqual:@"valid-zero-count-with-red-dot"];
    adapter.cachedNativeSections=@[@[Row(0,@"ordinary",7,redDot),Row(1,@"protected",50,NO)]];
    if ([name isEqual:@"valid-cache-nonzero"]) {
        adapter.alertBadge=@7;adapter.alertBadgeKey=@[Policy.accountID,@(Epoch),@(adapter.modelRevision),@(Policy.revision),NSNull.null];
    }
    if ([name isEqual:@"change-depth"]) adapter.changeDepth=1;
    if ([name isEqual:@"dirty"]) adapter.dirty=YES;
    if ([name isEqual:@"no-cache"]) adapter.cachedNativeSections=nil;
    if ([name isEqual:@"revision-mismatch"]) adapter.snapshotRevision--;
    if ([name isEqual:@"epoch-mismatch"]) adapter.snapshotEpoch--;
    if ([name isEqual:@"account-mismatch"]) adapter.snapshotAccount=@"other-probe-account";
    StrongAdapters=@[adapter];[AdapterOwners addObject:adapter];
}
static NSNumber *ExpectedDecision(NSString *name) {
    if ([name isEqual:@"no-filter"] || [name isEqual:@"no-protected-names"]) return nil;
    if ([name isEqual:@"valid-cache-nonzero"] || [name isEqual:@"valid-projection-nonzero"]) return @7;
    return @0;
}
static void AssertShared(ProbeBadge *badge,ProbeBadge *original,NSRect originalFrame) {
    CHECK(badge==original);CHECK(NSEqualRects(badge.nativeFixtureFrame,originalFrame));
}
static void RunScenario(NSString *name) {
    Configure(name);
    ProbeOwner *owner=[ProbeOwner new];UINavigationController *nav=[UINavigationController new];
    nav.viewControllers=@[[NewMainFrameViewController new]];
    // Chat is deliberately at index 2: ChatTab identifies the controller class.
    owner.viewControllers=@[[NSObject new],[NSObject new],nav,[NSObject new]];
    owner.badges=@[[ProbeBadge new],[ProbeBadge new],[ProbeBadge new],[ProbeBadge new]];
    NSUInteger index=2;Seed(owner);ProbeBadge *original=owner.badges[index];NSRect frame=original.nativeFixtureFrame;
    NSNumber *expected=ExpectedDecision(name),*decision=[CSGroupListAdapter closeFriendAlertBadgeCount];
    CHECK((!decision && !expected) || [decision isEqual:expected]);CHECK(ChatTab(owner,index));
    CHECK(!ChatTab(owner,0));CHECK(!ChatTab(owner,4));
    if ([name isEqual:@"valid-zero-count-with-red-dot"]) {
        CSGroupListAdapter *adapter=StrongAdapters.firstObject;WESessionTabItem *all=[WESessionTabItem tabWithType:WETabTypeAll];
        CSGroupProjection *projection=[[CSGroupProjection alloc] initWithSections:adapter.cachedNativeSections
            tabs:@[all] selectedTabID:all.tabId filterDuplicates:NO accountID:CurrentAccount
            hiddenUserNames:Policy.protectedUserNames unmaskedAggregateUserNames:NSSet.set privacyRevision:Policy.revision previousProjection:nil];
        CHECK(projection.isValid);CHECK([projection badgeForTabID:all.tabId].count==0);
        CHECK([projection badgeForTabID:all.tabId].redDot);
        ProjectionTelemetry=@{@"valid":@(projection.isValid),@"count":@([projection badgeForTabID:all.tabId].count),
            @"redDot":@([projection badgeForTabID:all.tabId].redDot),@"implementation":@"real CSGroupProjection; controlled immutable rows"};
    }
    if (!MessagePhase) {
        NSDictionary *before=BadgeState(original);
        // A getter is sampled without any incoming native update; this does not
        // claim the real WeChat cold-start sequence contains no badge setters.
        AssertShared(owner.badges[index],original,frame);CHECK(!original.hidden && original.count==12);
        CHECK(owner.numericCalls+owner.stringCalls+owner.dotCalls==0);
        Emit(@"controlled-no-notification-setter",decision,before,owner,index,@[@"decision",@"same-object",@"content-retained",@"no-native-setter",@"frame-unchanged"]);
        return;
    }
    NSDictionary *before=BadgeState(original);NumberHook(owner,13,index);
    CHECK(owner.numericCalls==1);CHECK(original.count==(decision?decision.unsignedLongLongValue:13));
    CHECK(original.hidden==(decision && !decision.unsignedLongLongValue));CHECK(!original.string && !original.dot);
    AssertShared(owner.badges[index],original,frame);
    Emit(@"isolated-number-input-13",decision,before,owner,index,@[@"decision",@"forwarded-number",@"hidden-from-host-native-zero-rule",@"same-object",@"frame-unchanged"]);
    Seed(owner);before=BadgeState(original);StringHook(owner,@"99+",index);
    NSString *wanted=decision?(decision.unsignedLongLongValue?decision.stringValue:nil):@"99+";
    CHECK(owner.stringCalls==1);CHECK(original.string==wanted || [original.string isEqual:wanted]);
    CHECK(original.hidden==!wanted.length);CHECK(!original.count && !original.dot);
    AssertShared(owner.badges[index],original,frame);
    Emit(@"isolated-string-input-99+",decision,before,owner,index,@[@"decision",@"forwarded-string-or-nil",@"hidden-from-host-native-nil-rule",@"same-object",@"frame-unchanged"]);
    Seed(owner);before=BadgeState(original);DotHook(owner,index);
    BOOL suppress=decision && !decision.unsignedLongLongValue;CHECK(owner.dotCalls==(suppress?0:1));
    CHECK(suppress?(original.count==12 && !original.hidden && !original.dot):(!original.count && !original.hidden && original.dot));
    AssertShared(owner.badges[index],original,frame);
    Emit(@"isolated-dot-on-visible-number",decision,before,owner,index,@[@"decision",@"dot-suppression-or-forward",@"suppression-retains-prior-state",@"same-object",@"frame-unchanged"]);
    Seed(owner);before=BadgeState(original);NumberHook(owner,13,index);StringHook(owner,@"99+",index);DotHook(owner,index);
    CHECK(original.hidden==suppress);CHECK(owner.dotCalls==(suppress?0:1));
    AssertShared(owner.badges[index],original,frame);
    Emit(@"synthetic-number-then-string-then-dot",decision,before,owner,index,@[@"controlled-order-only",@"zero-number-and-nil-string-hide",@"suppressed-dot-keeps-hidden",@"same-object",@"frame-unchanged"]);
    // The same zero policy decision must not rewrite a non-chat tab.
    Seed(owner);before=BadgeState(owner.badges[0]);NumberHook(owner,13,0);CHECK(owner.badges[0].count==13 && !owner.badges[0].hidden);
    StringHook(owner,@"99+",0);CHECK([owner.badges[0].string isEqual:@"99+"] && !owner.badges[0].hidden);
    DotHook(owner,0);CHECK(owner.badges[0].dot && !owner.badges[0].hidden);
    Emit(@"non-chat-tab-bypasses-replacement",decision,before,owner,0,@[@"ChatTab-false",@"native-inputs-pass-through"]);
}


// New regression requirements replayed against the exact legacy getter/blocks.
// A nonzero exit here is an observed behavior failure, after successful compile.
int main(void) { @autoreleasepool {
    TabOwners=[NSHashTable weakObjectsHashTable];
    NumberHook=
#include "numeric-block.inc"
    ;StringHook=
#include "string-block.inc"
    ;DotHook=
#include "dot-block.inc"
    ;
    Configure(@"valid-projection-nonzero");
    ProbeOwner *owner=[ProbeOwner new];UINavigationController *nav=[UINavigationController new];nav.viewControllers=@[[NewMainFrameViewController new]];
    owner.viewControllers=@[[NSObject new],[NSObject new],nav];owner.badges=@[[ProbeBadge new],[ProbeBadge new],[ProbeBadge new]];Seed(owner);
    NumberHook(owner,57,2);CHECK(owner.badges[2].count==7 && !owner.badges[2].hidden);
    CSGroupListAdapter *adapter=StrongAdapters.firstObject;adapter.dirty=YES;
    NumberHook(owner,58,2);
    BOOL pendingRetainsKnown=owner.badges[2].count==7 && !owner.badges[2].hidden;
    fprintf(stdout,"%s pending message must retain verified filtered 7: actual count=%llu hidden=%d getter=%s\n",pendingRetainsKnown?"PASS":"FAIL",owner.badges[2].count,owner.badges[2].hidden,[[CSGroupListAdapter closeFriendAlertBadgeCount] description].UTF8String);
    adapter.dirty=NO;adapter.modelRevision++;adapter.snapshotRevision=adapter.modelRevision;adapter.alertBadge=nil;
    NSNumber *ready=[CSGroupListAdapter closeFriendAlertBadgeCount];
    BOOL refreshRestores=owner.badges[2].count==ready.unsignedLongLongValue && !owner.badges[2].hidden;
    fprintf(stdout,"%s reliable source must publish without another native setter: ready=%s actual count=%llu hidden=%d\n",refreshRestores?"PASS":"FAIL",ready.description.UTF8String,owner.badges[2].count,owner.badges[2].hidden);
    Configure(@"valid-zero-count-with-red-dot");Seed(owner);NumberHook(owner,0,2);DotHook(owner,2);
    BOOL ordinaryDot=owner.badges[2].dot && !owner.badges[2].hidden;
    fprintf(stdout,"%s visible ordinary dot must survive filtering: actual dot=%d hidden=%d getter=%s\n",ordinaryDot?"PASS":"FAIL",owner.badges[2].dot,owner.badges[2].hidden,[[CSGroupListAdapter closeFriendAlertBadgeCount] description].UTF8String);
    fprintf(stdout,"Legacy regression requirements: %u / 3 failed; controlled host, actual WeChat not loaded\n",!pendingRetainsKnown+!refreshRestores+!ordinaryDot);
    return (pendingRetainsKnown && refreshRestores && ordinaryDot)?0:1;
} }
