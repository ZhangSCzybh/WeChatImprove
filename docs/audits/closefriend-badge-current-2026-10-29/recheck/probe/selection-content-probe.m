#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "CSCloseFriendPolicy.h"
#import "CSGroupProjection.h"
#import "WESessionTabItem.h"

// Only these host boundaries are synthetic: account/snapshot/adapter owners,
// immutable unread input rows, the controller hierarchy and native setter effects.
// The policy/projection and extracted getter/Hook bodies are real frozen sources.
static NSUInteger Checks, EventRows, MatrixCases, LifecycleCases,ConstructionCases;
static const NSUInteger Epoch=23;
static NSString *const Account=@"synthetic-probe-account";
static CSCloseFriendSnapshot *Policy;
static NSHashTable *Owners,*TabOwners;
static NSString *Context;
static NSString *Selection,*CacheState;
static NSUInteger OrdinaryUnread,CandidateUnread;
static NSArray *FixtureSections;
#define CHECK(c) do { Checks++; if (!(c)) { fprintf(stderr,"FAIL %d [%s]: %s\n",__LINE__,Context.UTF8String,#c); exit(1); } } while (0)
static CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) { return Policy; }
static NSUInteger CSCloseFriendAccountEpoch(void) { return Epoch; }
static NSString *CSGroupCurrentAccountID(void) { return Account; }
static NSHashTable *Adapters(void) { return Owners; }
static BOOL CSGroupIsFoldedController(id owner) { (void)owner;return NO; }
typedef NS_ENUM(NSUInteger,CSGroupFoldedPrivacyState) {
    CSGroupFoldedPrivacyUnknown,CSGroupFoldedPrivacyNoHidden,
    CSGroupFoldedPrivacyMixed,CSGroupFoldedPrivacyAllHidden
};
static NSArray *CSGroupCopyFoldedUserNames(void) { return nil; }
static CSGroupFoldedPrivacyState CSGroupAssessFoldedUserNames(NSArray *names,NSSet *hidden) {
    (void)names;(void)hidden;return CSGroupFoldedPrivacyUnknown;
}
static id CSCloseFriendRead(id object,NSString *key) {
    if ([object isKindOfClass:NSDictionary.class]) return object[key];
    @try { return [object valueForKey:key]; } @catch (__unused NSException *exception) { return nil; }
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
@property(nonatomic) NSRect fixtureFrame;
@end
@implementation ProbeBadge @end
@interface ProbeOwner : NSObject
@property(nonatomic,copy) NSArray *viewControllers;
@property(nonatomic,strong) NSArray<ProbeBadge *> *badges;
@property(nonatomic) NSUInteger numberCalls,stringCalls,dotCalls;
@property(nonatomic,strong) NSNumber *lastOriginalCount;
@property(nonatomic,copy) NSString *lastOriginalString;
@end
@implementation ProbeOwner @end
#include "ChatTab.inc"

// Explicit native IMP host fixtures. No claim that they implement UIKit,
// native badge geometry, actual unread updates or a real device lifecycle.
static void NativeNumber(id object,SEL selector,unsigned long long count,unsigned long long index) {
    (void)selector;ProbeOwner *owner=object;ProbeBadge *badge=owner.badges[index];
    owner.numberCalls++;owner.lastOriginalCount=@(count);
    badge.count=count;badge.string=nil;badge.dot=NO;badge.hidden=count==0;
}
static void NativeString(id object,SEL selector,id string,unsigned long long index) {
    (void)selector;ProbeOwner *owner=object;ProbeBadge *badge=owner.badges[index];
    owner.stringCalls++;owner.lastOriginalString=string;
    badge.count=0;badge.string=string;badge.dot=NO;badge.hidden=[string length]==0;
}
static void NativeDot(id object,SEL selector,unsigned long long index) {
    (void)selector;ProbeOwner *owner=object;ProbeBadge *badge=owner.badges[index];
    owner.dotCalls++;badge.count=0;badge.string=nil;badge.dot=YES;badge.hidden=NO;
}
static IMP tab=(IMP)NativeNumber,tabString=(IMP)NativeString,dot=(IMP)NativeDot;
static void (^NumberHook)(id,unsigned long long,unsigned long long);
static void (^StringHook)(id,id,unsigned long long);
static void (^DotHook)(id,unsigned long long);

static void PrintJSON(NSDictionary *row) {
    NSData *data=[NSJSONSerialization dataWithJSONObject:row options:NSJSONWritingSortedKeys error:NULL];
    CHECK(data!=nil);fwrite(data.bytes,1,data.length,stdout);fputc('\n',stdout);
}
static NSDictionary *BadgeState(ProbeBadge *badge) {
    return @{@"object":[NSString stringWithFormat:@"%p",badge],@"count":@(badge.count),
        @"string":badge.string ?: NSNull.null,@"hidden":@(badge.hidden),@"dot":@(badge.dot),
        @"frame":NSStringFromRect(badge.fixtureFrame),@"frameSource":@"fixed host fixture; not device geometry"};
}
static NSDictionary *Counts(ProbeOwner *owner) {
    return @{@"number":@(owner.numberCalls),@"string":@(owner.stringCalls),@"dot":@(owner.dotCalls)};
}
static BOOL DecisionEqual(NSNumber *a,NSNumber *b) { return (!a && !b) || [a isEqual:b]; }
static NSNumber *ExpectedDecision(BOOL valid) {
    if ([Selection isEqual:@"empty"]) return nil;
    return valid ? @(OrdinaryUnread) : @0;
}
static void Emit(NSString *kind,NSString *event,NSNumber *decision,id setterInput,BOOL setterInvoked,
                 NSDictionary *before,ProbeOwner *owner,CSGroupListAdapter *adapter,ProbeBadge *original) {
    ProbeBadge *badge=owner.badges[2];
    CHECK(badge==original);CHECK(NSEqualRects(badge.fixtureFrame,NSMakeRect(32,4,24,16)));
    BOOL chat=ChatTab(owner,2);
    EventRows++;
    PrintJSON(@{@"kind":kind,@"event":event,@"context":Context,@"selection":Selection,
        @"snapshotState":CacheState,@"ordinaryNumericUnread":@(OrdinaryUnread),
        @"candidateUnread":@(CandidateUnread),@"candidateIsProtectedByPolicy":@(![Selection isEqual:@"empty"]),
        @"candidateKind":[Selection isEqual:@"group"]?@"group":@"friend",
        @"nativeTotalInput":@(OrdinaryUnread+CandidateUnread),@"setterInvoked":@(setterInvoked),
        @"chatTabMatchesAtIndex2":@(chat),@"hookConsultsGetter":@(setterInvoked && chat),
        @"appliedReplacementDecision":setterInvoked && chat && decision ? decision : NSNull.null,
        @"setterInput":setterInput ?: NSNull.null,@"getterDecision":decision ?: NSNull.null,
        @"nativeOriginalCalls":Counts(owner),@"originalNumberArgument":owner.lastOriginalCount ?: NSNull.null,
        @"originalStringArgument":owner.lastOriginalString ?: NSNull.null,@"before":before,@"after":BadgeState(badge),
        @"sameBadgeObject":@(badge==original),@"actualMainThread":@(NSThread.isMainThread),
        @"adapter":@{@"cachedNativeSectionsPresent":@(adapter.cachedNativeSections!=nil),
            @"dirty":@(adapter.dirty),@"changeDepth":@(adapter.changeDepth),
            @"modelRevision":@(adapter.modelRevision),@"snapshotRevision":@(adapter.snapshotRevision),
            @"snapshotEpoch":@(adapter.snapshotEpoch),@"alertBadgeAtLogTime":adapter.alertBadge ?: NSNull.null},
        @"policy":@{@"enabled":@(Policy.enabled),@"revealed":@(Policy.revealed),@"blocked":@(Policy.blocked),
            @"protectedNamesCount":@(Policy.protectedUserNames.count),@"hideSessions":Policy.options[@"hideSessions"],
            @"silenceMessages":Policy.options[@"silenceMessages"]},
        @"siteStateObserved":@NO,@"actualWeChatLoaded":@NO,@"styleImplementationLoaded":@NO,
        @"lifecycleSource":@"manual host state sequence; not full GroupListAdapter lifecycle or device timing"});
}
static CSGroupRow *Row(NSUInteger index,NSString *name,NSUInteger unread,BOOL group) {
    NSUInteger indexes[]={0,index};
    return [[CSGroupRow alloc] initWithNativePath:[NSIndexPath indexPathWithIndexes:indexes length:2]
        userName:name kind:CSGroupRowKindSession category:group?CSGroupRowCategoryGroup:CSGroupRowCategoryPrivate
        top:NO unreadCount:unread redDot:NO];
}
static CSGroupListAdapter *Configure(NSString *selection,NSUInteger candidate,NSUInteger ordinary,NSString *state) {
    Selection=selection;CandidateUnread=candidate;OrdinaryUnread=ordinary;CacheState=state;
    Context=[NSString stringWithFormat:@"selection=%@ candidate=%lu ordinary=%lu state=%@",selection,
        (unsigned long)candidate,(unsigned long)ordinary,state];
    BOOL friend=[selection isEqual:@"friend"],group=[selection isEqual:@"group"];
    NSString *candidateName=group?@"synthetic-candidate@chatroom":@"synthetic-candidate-friend";
    Policy=[[CSCloseFriendSnapshot alloc] initWithAccountID:Account profile:@{@"enabled":@YES,
        @"friends":friend?@[candidateName]:@[],@"groups":group?@[candidateName]:@[],
        @"options":@{@"hideSessions":@YES,@"silenceMessages":@YES}}
        revealed:NO revision:41 blocked:NO];
    CHECK(!Policy.blocked);CHECK(Policy.protectedUserNames.count==([selection isEqual:@"empty"]?0:1));
    FixtureSections=@[@[Row(0,@"synthetic-ordinary",ordinary,NO),Row(1,candidateName,candidate,group)]];
    CSGroupListAdapter *adapter=[CSGroupListAdapter new];adapter.controller=@"synthetic-main-owner";
    adapter.cachedNativeSections=FixtureSections;adapter.modelRevision=adapter.snapshotRevision=17;
    adapter.snapshotEpoch=Epoch;adapter.snapshotAccount=Account;
    if ([state isEqual:@"no-cache"]) adapter.cachedNativeSections=nil;
    else if ([state isEqual:@"dirty"]) adapter.dirty=YES;
    else if ([state isEqual:@"change-depth"]) adapter.changeDepth=1;
    else if ([state isEqual:@"revision-mismatch"]) adapter.snapshotRevision--;
    Owners=[NSHashTable weakObjectsHashTable];[Owners addObject:adapter];
    return adapter;
}
static ProbeOwner *Owner(void) {
    ProbeOwner *owner=[ProbeOwner new];UINavigationController *nav=[UINavigationController new];
    nav.viewControllers=@[[NewMainFrameViewController new]];
    owner.viewControllers=@[[NSObject new],[NSObject new],nav,[NSObject new]];
    owner.badges=@[[ProbeBadge new],[ProbeBadge new],[ProbeBadge new],[ProbeBadge new]];
    CHECK(ChatTab(owner,2));CHECK(!ChatTab(owner,0));CHECK(!ChatTab(owner,4));return owner;
}
static void Seed(ProbeOwner *owner,unsigned long long count) {
    owner.numberCalls=owner.stringCalls=owner.dotCalls=0;
    owner.lastOriginalCount=nil;owner.lastOriginalString=nil;
    for (ProbeBadge *badge in owner.badges) {
        badge.count=count;badge.string=nil;badge.dot=NO;badge.hidden=count==0;
        badge.fixtureFrame=NSMakeRect(32,4,24,16);
    }
}
static void NumberEvent(NSString *kind,NSString *event,ProbeOwner *owner,CSGroupListAdapter *adapter,ProbeBadge *original,NSNumber *expected) {
    unsigned long long total=OrdinaryUnread+CandidateUnread;
    NSNumber *decision=[CSGroupListAdapter closeFriendAlertBadgeCount];CHECK(DecisionEqual(decision,expected));
    NSDictionary *before=BadgeState(original);NSUInteger calls=owner.numberCalls;NumberHook(owner,total,2);
    unsigned long long wanted=expected?expected.unsignedLongLongValue:total;
    CHECK(owner.numberCalls==calls+1);CHECK([owner.lastOriginalCount isEqual:@(wanted)]);
    CHECK(original.count==wanted);CHECK(original.hidden==(wanted==0));CHECK(!original.string && !original.dot);
    Emit(kind,event,decision,@(total),YES,before,owner,adapter,original);
}
static void Matrix(NSString *selection,NSUInteger candidate,NSUInteger ordinary,NSString *state) {
    MatrixCases++;CSGroupListAdapter *adapter=Configure(selection,candidate,ordinary,state);
    BOOL valid=[state isEqual:@"valid-cache"];NSNumber *expected=ExpectedDecision(valid);
    ProbeOwner *owner=Owner();Seed(owner,12);ProbeBadge *original=owner.badges[2];
    NumberEvent(@"matrix",@"isolated-number",owner,adapter,original,expected);
    if (valid && expected) {
        CHECK(adapter.alertBadge!=nil);NSNumber *cached=adapter.alertBadge;
        CHECK([CSGroupListAdapter closeFriendAlertBadgeCount]==cached);
    }
    Seed(owner,12);NSNumber *decision=[CSGroupListAdapter closeFriendAlertBadgeCount];
    CHECK(DecisionEqual(decision,expected));NSDictionary *before=BadgeState(original);
    NSString *input=OrdinaryUnread+CandidateUnread ? [@(OrdinaryUnread+CandidateUnread) stringValue] : nil;
    StringHook(owner,input,2);NSString *wanted=expected?(expected.unsignedLongLongValue?expected.stringValue:nil):input;
    CHECK(owner.stringCalls==1);CHECK(owner.lastOriginalString==wanted || [owner.lastOriginalString isEqual:wanted]);
    CHECK(original.string==wanted || [original.string isEqual:wanted]);CHECK(original.hidden==!wanted.length);
    CHECK(original.count==0 && !original.dot);
    Emit(@"matrix",@"isolated-string-native-total",decision,input,YES,before,owner,adapter,original);
    Seed(owner,12);decision=[CSGroupListAdapter closeFriendAlertBadgeCount];CHECK(DecisionEqual(decision,expected));
    before=BadgeState(original);DotHook(owner,2);BOOL suppressed=expected && !expected.unsignedLongLongValue;
    CHECK(owner.dotCalls==(suppressed?0:1));
    CHECK(suppressed ? (original.count==12 && !original.hidden && !original.dot) : (original.count==0 && !original.hidden && original.dot));
    Emit(@"matrix",@"explicit-dot-request-on-visible-number",decision,@"synthetic explicit show request; not derived from numeric total",YES,before,owner,adapter,original);
}
static void NoSetterStage(NSString *event,ProbeOwner *owner,CSGroupListAdapter *adapter,ProbeBadge *original,NSNumber *expected) {
    NSDictionary *before=BadgeState(original),*calls=Counts(owner);
    NSNumber *decision=[CSGroupListAdapter closeFriendAlertBadgeCount];CHECK(DecisionEqual(decision,expected));
    CHECK([BadgeState(original) isEqual:before]);CHECK([Counts(owner) isEqual:calls]);
    Emit(@"controlled-lifecycle",event,decision,nil,NO,before,owner,adapter,original);
}
static void Lifecycle(NSString *selection,NSUInteger candidate,NSUInteger ordinary) {
    LifecycleCases++;CSGroupListAdapter *adapter=Configure(selection,candidate,ordinary,@"valid-cache");
    ProbeOwner *owner=Owner();Seed(owner,OrdinaryUnread+CandidateUnread);ProbeBadge *original=owner.badges[2];
    // Controlled cold state already identifies the chat tab and has valid rows.
    // A later invalid snapshot can hide it without any identity-match transition.
    NumberEvent(@"controlled-lifecycle",@"cold-valid-chat-matches-and-setter",owner,adapter,original,ExpectedDecision(YES));
    // These assignments model only the state predicates used by the extracted
    // getter. They do not execute real begin/end/refresh or schedule any event.
    adapter.modelRevision++;adapter.changeDepth=1;CacheState=@"manual-begin-invalid";
    NoSetterStage(@"begin-invalid-no-setter",owner,adapter,original,ExpectedDecision(NO));
    NumberEvent(@"controlled-lifecycle",@"setter-during-begin",owner,adapter,original,ExpectedDecision(NO));
    adapter.changeDepth=0;adapter.dirty=YES;CacheState=@"manual-end-dirty";
    NoSetterStage(@"end-dirty-no-setter",owner,adapter,original,ExpectedDecision(NO));
    NumberEvent(@"controlled-lifecycle",@"setter-during-dirty",owner,adapter,original,ExpectedDecision(NO));
    adapter.cachedNativeSections=FixtureSections;adapter.snapshotRevision=adapter.modelRevision;adapter.dirty=NO;
    CacheState=@"manual-valid-refresh-without-setter";
    NoSetterStage(@"valid-refresh-does-not-touch-badge",owner,adapter,original,ExpectedDecision(YES));
    CacheState=@"manual-valid-subsequent-setter";
    NumberEvent(@"controlled-lifecycle",@"new-setter-uses-valid-result",owner,adapter,original,ExpectedDecision(YES));
}
static void Construction(void) {
    CSGroupListAdapter *adapter=Configure(@"friend",5,7,@"valid-cache");
    // A not-yet-loaded policy is represented by blocked, not by returning nil.
    Policy=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"" profile:@{@"enabled":@NO,
        @"friends":@[],@"groups":@[],@"options":@{}}
        revealed:NO revision:42 blocked:YES];
    ProbeOwner *owner=Owner();Seed(owner,12);ProbeBadge *original=owner.badges[2];
    UINavigationController *placeholderNav=[UINavigationController new];placeholderNav.viewControllers=@[[NSObject new]];
    UINavigationController *chatNav=[UINavigationController new];chatNav.viewControllers=@[[NewMainFrameViewController new]];
    NSArray *inventories=@[@[],@[[NSObject new],[NSObject new],[NSObject new]],
        @[[NSObject new],[NSObject new],placeholderNav],@[[NSObject new],[NSObject new],chatNav]];
    NSArray *names=@[@"empty-viewControllers",@"placeholder-controller",@"navigation-placeholder-root",@"navigation-chat-root"];
    for (NSUInteger stage=0;stage<inventories.count;stage++) {
        ConstructionCases++;owner.viewControllers=inventories[stage];Seed(owner,12);CacheState=names[stage];
        NSNumber *decision=[CSGroupListAdapter closeFriendAlertBadgeCount];CHECK([decision isEqual:@0]);
        CHECK(ChatTab(owner,2)==(stage==3));NSDictionary *before=BadgeState(original);NumberHook(owner,12,2);
        CHECK(owner.numberCalls==1);CHECK([owner.lastOriginalCount isEqual:stage==3?@0:@12]);
        CHECK(original.count==(stage==3?0:12));CHECK(original.hidden==(stage==3));
        Emit(@"controlled-construction",names[stage],decision,@12,YES,before,owner,adapter,original);
    }
}
int main(void) { @autoreleasepool {
    CHECK(NSThread.isMainThread);TabOwners=[NSHashTable weakObjectsHashTable];
    NumberHook=
#include "numeric-block.inc"
    ;StringHook=
#include "string-block.inc"
    ;DotHook=
#include "dot-block.inc"
    ;
    for (NSString *selection in @[@"empty",@"friend",@"group"])
        for (NSNumber *candidate in @[@0,@5]) for (NSNumber *ordinary in @[@0,@7])
            for (NSString *state in @[@"valid-cache",@"no-cache",@"dirty",@"change-depth",@"revision-mismatch"])
                Matrix(selection,candidate.unsignedIntegerValue,ordinary.unsignedIntegerValue,state);
    for (NSString *selection in @[@"empty",@"friend",@"group"])
        for (NSNumber *candidate in @[@0,@5]) for (NSNumber *ordinary in @[@0,@7])
            Lifecycle(selection,candidate.unsignedIntegerValue,ordinary.unsignedIntegerValue);
    Construction();
    // PrintJSON performs one final serialization assertion; include it in total.
    PrintJSON(@{@"kind":@"summary",@"checks":@(Checks+1),@"failures":@0,
        @"matrixCases":@(MatrixCases),@"lifecycleCases":@(LifecycleCases),@"eventRows":@(EventRows),
        @"constructionCases":@(ConstructionCases),
        @"actualWeChatLoaded":@NO,@"styleImplementationLoaded":@NO,@"siteStateObserved":@NO});
    return 0;
} }
