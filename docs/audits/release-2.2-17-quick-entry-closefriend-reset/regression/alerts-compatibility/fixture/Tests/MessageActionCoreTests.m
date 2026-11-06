#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>
#import "CSMessageActionPolicy.h"
#include <math.h>
#include <stdlib.h>
static unsigned checks;
#define CHECK(...) do { checks++; if (!(__VA_ARGS__)) { fprintf(stderr,"FAIL line %d: %s\n",__LINE__,#__VA_ARGS__); exit(1); } } while (0)

@interface TestWrap : NSObject
@property(nonatomic, copy) NSString *m_nsFromUsr;
@property(nonatomic, copy) NSString *m_nsToUsr;
@property(nonatomic) unsigned int m_uiMesLocalID;
@property(nonatomic) long long m_n64MesSvrID;
@property(nonatomic) unsigned int m_uiMessageType;
@end
@implementation TestWrap @end
@interface TestReceivedWrap : TestWrap
+ (BOOL)isSenderFromMsgWrap:(id)wrap;
@end
@implementation TestReceivedWrap
+ (BOOL)isSenderFromMsgWrap:(__unused id)wrap { return NO; }
@end
@interface TestModel : NSObject
@property(nonatomic, strong) id messageWrap;
@property(nonatomic, strong) TestModel *parentModel;
@end
@implementation TestModel @end
@interface TestCell : NSObject
@property(nonatomic, strong) id current;
@property(nonatomic, strong) TestModel *viewModel;
@end
@implementation TestCell
- (id)getCurrentMessageWrap { return self.current; }
@end
@interface WrongABICell : NSObject
@property(nonatomic, strong) TestModel *viewModel;
@end
@implementation WrongABICell
- (BOOL)getCurrentMessageWrap { [NSException raise:@"WrongABI" format:@"must not invoke"]; return YES; }
@end
@interface CountingDefaults : NSUserDefaults
@property(nonatomic) NSUInteger reads;
@property(nonatomic, strong) NSMutableSet *readKeys;
@end
@implementation CountingDefaults
- (id)objectForKey:(NSString *)key { self.reads++; [self.readKeys addObject:key]; return [super objectForKey:key]; }
@end
static TestWrap *Wrap(BOOL outgoing, unsigned int localID) {
    TestWrap *wrap=[TestWrap new]; wrap.m_nsFromUsr=outgoing ? @"me" : @"chat";
    wrap.m_nsToUsr=outgoing ? @"chat" : @"me"; wrap.m_uiMesLocalID=localID;
    wrap.m_uiMessageType=1; return wrap;
}
static CSMessageActionContext *Context(id cell, NSUInteger generation) {
    return [CSMessageActionContext contextWithCell:cell controller:nil accountID:@"me"
        accountEpoch:7 conversationID:nil bindingGeneration:generation];
}
static void Drain(void) {
    for (int i=0;i<3;i++) [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.02]];
}
static void TestPolicy(NSUserDefaults *d) {
    // The first required regression: menu switch must never gate gesture repeat.
    [d setBool:YES forKey:CSMessageActionGestureEnabledKey];
    CSMessageActionSettings *s=[[CSMessageActionSettings alloc] initWithDefaults:d version:1];
    CHECK(CSMessageActionEntryAllows(s,CSMessageActionEntryGesture,CSMessageActionRepeat));
    CHECK(!CSMessageActionEntryAllows(s,CSMessageActionEntryMenuRepeat,CSMessageActionRepeat));
    CHECK(CSMessageActionDisabled==0 && CSMessageActionQuote==1 && CSMessageActionDelete==2 &&
        CSMessageActionForward==3 && CSMessageActionFavorite==4 && CSMessageActionRevoke==5 && CSMessageActionRepeat==6);
    for (NSUInteger mask=0;mask<8;mask++) {
        [d setBool:(mask&1)!=0 forKey:CSMessageActionGestureEnabledKey];
        [d setBool:(mask&2)!=0 forKey:CSMessageActionRepeatEnabledKey];
        [d setBool:(mask&4)!=0 forKey:CSMessageActionVoiceForwardEnabledKey];
        s=[[CSMessageActionSettings alloc] initWithDefaults:d version:2];
        for (NSInteger action=0;action<=7;action++) {
            CHECK(CSMessageActionEntryAllows(s,CSMessageActionEntryGesture,action)==((mask&1)!=0 && action>=1 && action<=6));
            CHECK(CSMessageActionEntryAllows(s,CSMessageActionEntryMenuRepeat,action)==((mask&2)!=0 && action==6));
            CHECK(CSMessageActionEntryAllows(s,CSMessageActionEntryMenuVoiceForward,action)==((mask&4)!=0 && action==3));
            CHECK(CSMessageActionEntryAllows(s,CSMessageActionEntryNativeForward,action)==(action==3));
        }
        CHECK(!CSMessageActionEntryAllows(s,(CSMessageActionEntry)100,CSMessageActionRepeat));
        for (NSNumber *entry in @[@(CSMessageActionEntryGesture),@(CSMessageActionEntryMenuVoiceForward),@(CSMessageActionEntryNativeForward)]) {
            BOOL permitted=CSMessageActionEntryAllows(s,entry.integerValue,CSMessageActionForward);
            CHECK(CSMessageActionUsesVoiceEnhancement(s,entry.integerValue,CSMessageActionForward,34)==(permitted && (mask&4)!=0));
            CHECK(!CSMessageActionUsesVoiceEnhancement(s,entry.integerValue,CSMessageActionForward,1));
            CHECK(!CSMessageActionUsesVoiceEnhancement(s,entry.integerValue,CSMessageActionRepeat,34));
        }
    }
    NSArray *keys=@[CSMessageActionLeftOtherKey,CSMessageActionLeftSelfKey,CSMessageActionRightOtherKey,CSMessageActionRightSelfKey];
    for (NSUInteger selected=0;selected<4;selected++) for (NSInteger action=-1;action<9;action++) {
        for (NSString *key in keys) [d setInteger:0 forKey:key];
        [d setInteger:action forKey:keys[selected]];
        s=[[CSMessageActionSettings alloc] initWithDefaults:d version:3];
        for (NSUInteger slot=0;slot<4;slot++) CHECK(CSMessageActionForDirection(s,
            slot<2 ? CSMessageActionDirectionLeft : CSMessageActionDirectionRight,(slot%2)==1)==
            (slot==selected ? CSMessageActionValidated(action) : CSMessageActionDisabled));
        CHECK([d integerForKey:keys[selected]]==action);
    }
    CHECK(CSMessageActionForDirection(s,CSMessageActionDirectionNone,YES)==CSMessageActionDisabled);
    CHECK(CSMessageActionForDirection(s,(CSMessageActionDirection)22,YES)==CSMessageActionDisabled);
}
static void TestGesture(void) {
    CHECK(CSMessageActionGestureDistanceThreshold(300)==60);
    CHECK(CSMessageActionGestureDistanceThreshold(500)==100);
    CHECK(CSMessageActionGestureHasHorizontalIntent(16,10));
    CHECK(!CSMessageActionGestureHasHorizontalIntent(15,10));
    CHECK(!CSMessageActionGestureHasHorizontalIntent(0,0));
    for (NSInteger direction=-1;direction<=1;direction+=2) {
        CHECK(CSMessageActionGestureShouldCommit(CSMessageActionGesturePhaseEnded,70*direction,0,300,direction,YES,YES));
        CHECK(CSMessageActionGestureIsArmed(12*direction,600*direction,300,direction));
        CHECK(!CSMessageActionGestureIsArmed(11.99*direction,700*direction,300,direction));
        CHECK(!CSMessageActionGestureIsArmed(12*direction,-700*direction,300,direction));
        CHECK(!CSMessageActionGestureIsArmed(-70*direction,700*direction,300,direction));
        CHECK(!CSMessageActionGestureIsArmed(0,700*direction,300,direction));
        CHECK(!CSMessageActionGestureIsArmed(12*direction,599*direction,300,direction));
        for (NSNumber *phase in @[@(CSMessageActionGesturePhaseTracking),@(CSMessageActionGesturePhaseCancelled),@(CSMessageActionGesturePhaseFailed),@99])
            CHECK(!CSMessageActionGestureShouldCommit(phase.integerValue,70*direction,700*direction,300,direction,YES,YES));
        CHECK(!CSMessageActionGestureShouldCommit(CSMessageActionGesturePhaseEnded,70*direction,700*direction,300,direction,NO,YES));
        CHECK(!CSMessageActionGestureShouldCommit(CSMessageActionGesturePhaseEnded,70*direction,700*direction,300,direction,YES,NO));
    }
    CHECK(!CSMessageActionGestureShouldCommit(CSMessageActionGesturePhaseCancelled,-70,0,300,CSMessageActionDirectionLeft,YES,YES));
    CHECK(!CSMessageActionGestureShouldCommit(CSMessageActionGesturePhaseEnded,-10,700,300,CSMessageActionDirectionLeft,YES,YES));
    CHECK(!CSMessageActionGestureIsArmed(-70,700,300,CSMessageActionDirectionNone));
    for (NSNumber *bad in @[@(NAN),@(INFINITY),@(-1),@0]) CHECK(!CSMessageActionGestureIsArmed(-70,-700,bad.doubleValue,CSMessageActionDirectionLeft));
    CHECK(!CSMessageActionGestureIsArmed(NAN,-700,300,CSMessageActionDirectionLeft));
    CHECK(!CSMessageActionGestureIsArmed(-70,NAN,300,CSMessageActionDirectionLeft));
}
static void TestContext(void) {
    TestCell *cell=[TestCell new]; cell.current=Wrap(YES,10);
    CSMessageActionContext *sent=Context(cell,1);
    CHECK(sent.outgoing && [sent.sourceConversationID isEqual:@"chat"] && sent.localID==10);
    CHECK(sent.sourceWrap==cell.current && sent.cell==cell && sent.controller==nil);
    CHECK([sent isValidForAccountID:@"me" epoch:7]);
    CHECK(![sent isValidForAccountID:@"other" epoch:7]);
    CHECK(![CSMessageActionContext contextWithCell:cell controller:nil accountID:@"me" accountEpoch:0 conversationID:nil bindingGeneration:1]);
    CHECK(![CSMessageActionContext contextWithCell:cell controller:nil accountID:@"me" accountEpoch:7 conversationID:@"wrong-chat" bindingGeneration:1]); CHECK(![sent isValidForAccountID:@"me" epoch:8]);
    cell.current=Wrap(NO,11); CSMessageActionContext *received=Context(cell,2);
    CHECK(received && !received.outgoing && [received.sourceConversationID isEqual:@"chat"]);
    CHECK(![sent matchesSourceContext:received]);
    TestModel *parent=[TestModel new]; parent.messageWrap=cell.current;
    TestModel *segment=[TestModel new]; segment.parentModel=parent;
    cell.viewModel=segment; cell.current=nil;
    CHECK(CSMessageActionResolveSourceWrap(cell)==parent.messageWrap);
    CHECK([Context(cell,2) matchesSourceContext:received]);
    // A segment's own messageWrap must resolve to the complete parent's source.
    segment.messageWrap=Wrap(NO,12);
    CHECK(CSMessageActionResolveSourceWrap(cell)==parent.messageWrap);
    WrongABICell *wrong=[WrongABICell new]; wrong.viewModel=segment;
    CHECK(CSMessageActionResolveSourceWrap(wrong)==parent.messageWrap);
    CHECK(CSMessageActionObjectGetter(wrong,@selector(getCurrentMessageWrap))==nil);
    TestWrap *wrap=parent.messageWrap; wrap.m_nsFromUsr=@"group@chatroom";
    CHECK([Context(cell,2).sourceConversationID isEqual:@"group@chatroom"]);
    wrap.m_nsFromUsr=@"chat"; wrap.m_n64MesSvrID=100;
    CSMessageActionContext *promoted=Context(cell,2);
    CHECK([received matchesSourceContext:promoted]);
    wrap.m_uiMesLocalID=0; CHECK([promoted matchesSourceContext:Context(cell,2)]);
    wrap.m_n64MesSvrID=101; CHECK(![promoted matchesSourceContext:Context(cell,2)]);
    CHECK(![CSMessageActionContext contextWithCell:cell controller:nil accountID:@"" accountEpoch:7 conversationID:nil bindingGeneration:2]);
    wrap.m_nsFromUsr=@"unknown"; wrap.m_nsToUsr=@"elsewhere"; CHECK(Context(cell,2)==nil);
    cell.current=Wrap(NO,0); cell.viewModel=nil;
    CSMessageActionContext *bound=Context(cell,3); CHECK(bound!=nil);
    CHECK([bound matchesSourceContext:Context(cell,3)]);
    CHECK(![bound matchesSourceContext:Context(cell,4)]);
    CHECK(Context(cell,0)==nil);
    cell.current=Wrap(NO,0); CHECK(![bound matchesSourceContext:Context(cell,3)]);
    TestReceivedWrap *authoritative=[TestReceivedWrap new]; authoritative.m_nsFromUsr=@"me";
    authoritative.m_nsToUsr=@"chat"; authoritative.m_uiMesLocalID=80; cell.current=authoritative;
    // Contradictory account/direction metadata fails closed, never overrides an authoritative NO.
    CHECK(Context(cell,5)==nil);
    authoritative.m_nsFromUsr=@"chat"; authoritative.m_nsToUsr=@"me";
    CHECK(Context(cell,5)!=nil && !Context(cell,5).outgoing);
    __block CSMessageActionContext *backgroundContext;
    dispatch_group_t group=dispatch_group_create();
    dispatch_group_async(group,dispatch_get_global_queue(QOS_CLASS_USER_INITIATED,0),^{ backgroundContext=Context(cell,5); });
    dispatch_group_wait(group,DISPATCH_TIME_FOREVER);
    CHECK(backgroundContext==nil);
    __weak id weakCell;
    CSMessageActionContext *retained;
    @autoreleasepool { TestCell *temporary=[TestCell new]; temporary.current=Wrap(YES,5); weakCell=temporary; retained=Context(temporary,1); }
    CHECK(weakCell==nil && retained.cell==nil && retained.sourceWrap!=nil);
    TestModel *cycle=[TestModel new]; cycle.parentModel=cycle; cell.current=nil; cell.viewModel=cycle;
    CHECK(CSMessageActionResolveSourceWrap(cell)==nil); cycle.parentModel=nil;
}
static CSMessageActionSubmissionLedger *Ledger(void) {
    CSMessageActionSubmissionLedger *l=[[CSMessageActionSubmissionLedger alloc] initWithAccountID:@"me" accountEpoch:7];
    CHECK([l registerOperationID:@"op1" targetIDs:@[@"chat",@"other"]]); return l;
}
static BOOL Begin(CSMessageActionSubmissionLedger *l, NSString *op, NSString *target) {
    return [l beginSubmissionForOperationID:op targetID:target currentAccountID:@"me" accountEpoch:7];
}
static void TestSubmission(void) {
    CSMessageActionSubmissionLedger *l=Ledger();
    CHECK(!Begin(l,@"op1",@"chat"));
    CHECK([l transitionOperationID:@"op1" targetID:@"chat" toState:CSMessageActionSubmissionStateReady]);
    CHECK(Begin(l,@"op1",@"chat")); CHECK(!Begin(l,@"op1",@"chat"));
    CHECK(![l registerOperationID:@"op1" targetIDs:@[@"chat"]]);
    CHECK([l registerOperationID:@"op2" targetIDs:@[@"chat"]]);
    CHECK([l transitionOperationID:@"op2" targetID:@"chat" toState:CSMessageActionSubmissionStateReady]);
    CHECK(Begin(l,@"op2",@"chat"));
    CHECK([l stateForOperationID:@"op1" targetID:@"other"]==CSMessageActionSubmissionStatePreparing);
    CHECK([l stateForOperationID:@"missing" targetID:@"chat"]==CSMessageActionSubmissionStateUnregistered);
    CHECK(!Begin(l,@"missing",@"chat")); CHECK(!Begin(l,@"op1",@"not-confirmed"));
    CHECK(![l transitionOperationID:@"op1" targetID:@"chat" toState:CSMessageActionSubmissionStateSucceeded]);
    CHECK([l stateForOperationID:@"op1" targetID:@"chat"]==CSMessageActionSubmissionStateSubmitting);
    CHECK([l transitionOperationID:@"op1" targetID:@"chat" toState:CSMessageActionSubmissionStateAccepted]);
    [l cancelUnsubmittedOperations];
    CHECK([l stateForOperationID:@"op1" targetID:@"chat"]==CSMessageActionSubmissionStateAccepted);
    CHECK([l stateForOperationID:@"op1" targetID:@"other"]==CSMessageActionSubmissionStateCancelled);
    CHECK([l stateForOperationID:@"op2" targetID:@"chat"]==CSMessageActionSubmissionStateSubmitting);
    CHECK([l transitionOperationID:@"op1" targetID:@"chat" toState:CSMessageActionSubmissionStateSucceeded]);
    CHECK(![l transitionOperationID:@"op1" targetID:@"chat" toState:CSMessageActionSubmissionStateFailedAfterAcceptance]);
    for (NSNumber *terminal in @[@(CSMessageActionSubmissionStateFailedBeforeAcceptance),@(CSMessageActionSubmissionStateUnknown)]) {
        l=Ledger(); CHECK([l transitionOperationID:@"op1" targetID:@"chat" toState:CSMessageActionSubmissionStateReady]);
        CHECK(Begin(l,@"op1",@"chat")); CHECK([l transitionOperationID:@"op1" targetID:@"chat" toState:terminal.integerValue]);
        CHECK(!Begin(l,@"op1",@"chat")); CHECK(![l transitionOperationID:@"op1" targetID:@"chat" toState:CSMessageActionSubmissionStateReady]);
    }
    l=Ledger(); CHECK([l transitionOperationID:@"op1" targetID:@"chat" toState:CSMessageActionSubmissionStateReady]);
    CHECK(![l beginSubmissionForOperationID:@"op1" targetID:@"chat" currentAccountID:@"me" accountEpoch:8]);
    CHECK(![l beginSubmissionForOperationID:@"op1" targetID:@"chat" currentAccountID:@"else" accountEpoch:7]);
    CHECK(![l registerOperationID:@"empty" targetIDs:@[]]); CHECK(![l registerOperationID:@"dup" targetIDs:@[@"chat",@"chat"]]);
    // Concurrent callback ownership: exactly one guarded owner, no actual native sends.
    __block unsigned owners=0;
    dispatch_apply(100,dispatch_get_global_queue(QOS_CLASS_USER_INITIATED,0),^(__unused size_t i){
        if (Begin(l,@"op1",@"chat")) @synchronized(l) { owners++; }
    }); CHECK(owners==1);
}
// Exercise every legal edge and every forbidden edge, including terminal late callbacks.
static CSMessageActionSubmissionLedger *LedgerAtState(CSMessageActionSubmissionState state) {
    CSMessageActionSubmissionLedger *l=Ledger();
    if (state==CSMessageActionSubmissionStatePreparing) return l;
    if (state==CSMessageActionSubmissionStateWaitingForMedia) {
        CHECK([l transitionOperationID:@"op1" targetID:@"chat" toState:state]); return l;
    }
    CHECK([l transitionOperationID:@"op1" targetID:@"chat" toState:CSMessageActionSubmissionStateReady]);
    if (state==CSMessageActionSubmissionStateReady) return l;
    if (state==CSMessageActionSubmissionStateCancelled) {
        CHECK([l transitionOperationID:@"op1" targetID:@"chat" toState:state]); return l;
    }
    CHECK(Begin(l,@"op1",@"chat"));
    if (state==CSMessageActionSubmissionStateSubmitting) return l;
    if (state==CSMessageActionSubmissionStateFailedBeforeAcceptance || state==CSMessageActionSubmissionStateUnknown) {
        CHECK([l transitionOperationID:@"op1" targetID:@"chat" toState:state]); return l;
    }
    CHECK([l transitionOperationID:@"op1" targetID:@"chat" toState:CSMessageActionSubmissionStateAccepted]);
    if (state!=CSMessageActionSubmissionStateAccepted)
        CHECK([l transitionOperationID:@"op1" targetID:@"chat" toState:state]);
    return l;
}
static void TestAllSubmissionTransitions(void) {
    // Allowed successor sets from the design's evidence/state contract, not a simulated sender.
    NSDictionary<NSNumber *,NSArray<NSNumber *> *> *allowed=@{
        @(CSMessageActionSubmissionStatePreparing): @[@(CSMessageActionSubmissionStateWaitingForMedia),@(CSMessageActionSubmissionStateReady),@(CSMessageActionSubmissionStateFailedBeforeAcceptance),@(CSMessageActionSubmissionStateCancelled)],
        @(CSMessageActionSubmissionStateWaitingForMedia): @[@(CSMessageActionSubmissionStateReady),@(CSMessageActionSubmissionStateFailedBeforeAcceptance),@(CSMessageActionSubmissionStateCancelled)],
        @(CSMessageActionSubmissionStateReady): @[@(CSMessageActionSubmissionStateFailedBeforeAcceptance),@(CSMessageActionSubmissionStateCancelled)],
        @(CSMessageActionSubmissionStateSubmitting): @[@(CSMessageActionSubmissionStateAccepted),@(CSMessageActionSubmissionStateFailedBeforeAcceptance),@(CSMessageActionSubmissionStateUnknown)],
        @(CSMessageActionSubmissionStateAccepted): @[@(CSMessageActionSubmissionStateSucceeded),@(CSMessageActionSubmissionStateFailedAfterAcceptance),@(CSMessageActionSubmissionStateUnknown)]
    };
    for (NSInteger source=CSMessageActionSubmissionStatePreparing;source<=CSMessageActionSubmissionStateCancelled;source++) {
        for (NSInteger destination=CSMessageActionSubmissionStateUnregistered;destination<=CSMessageActionSubmissionStateCancelled;destination++) {
            CSMessageActionSubmissionLedger *l=LedgerAtState(source);
            BOOL expected=[allowed[@(source)] containsObject:@(destination)];
            CHECK([l transitionOperationID:@"op1" targetID:@"chat" toState:destination]==expected);
            CHECK([l stateForOperationID:@"op1" targetID:@"chat"]==(expected ? destination : source));
            CHECK([l stateForOperationID:@"op1" targetID:@"other"]==CSMessageActionSubmissionStatePreparing);
        }
    }
    CSMessageActionSubmissionLedger *l=Ledger();
    CHECK([l registerOperationID:@"bulk" targetIDs:@[@"a",@"b",@"c"]]);
    [l cancelUnsubmittedOperations];
    for (NSString *target in @[@"a",@"b",@"c"])
        CHECK([l stateForOperationID:@"bulk" targetID:target]==CSMessageActionSubmissionStateCancelled);
}
static void TestPreferences(CountingDefaults *d, NSString *suite) {
    CSMessageActionPreferences *p=[[CSMessageActionPreferences alloc] initWithDefaults:d];
    CHECK(!p.snapshot.gestureEnabled && !p.snapshot.repeatEnabled && !p.snapshot.voiceForwardEnabled && !p.snapshot.imageStickerEnabled);
    CHECK(p.snapshot.leftOtherAction==0 && p.snapshot.leftSelfAction==0 && p.snapshot.rightOtherAction==0 && p.snapshot.rightSelfAction==0);
    CHECK(d.readKeys.count==8);
    __block unsigned notifications=0; __block BOOL mainDelivery=YES;
    id observer=[[NSNotificationCenter defaultCenter] addObserverForName:CSMessageActionSettingsDidChangeNotification object:p queue:nil usingBlock:^(__unused NSNotification *n){ notifications++; mainDelivery &= NSThread.isMainThread; }];
    CSMessageActionSettings *initial=p.snapshot;
    [d setInteger:999 forKey:CSMessageActionLeftOtherKey];
    for (int i=0;i<30;i++) [p requestRefresh]; Drain();
    CHECK(p.snapshot.version==initial.version+1 && notifications==1 && mainDelivery);
    CHECK(p.snapshot.leftOtherAction==999 && initial.leftOtherAction==0);
    CHECK([d integerForKey:CSMessageActionLeftOtherKey]==999);
    NSUInteger version=p.snapshot.version;
    [d setBool:YES forKey:@"unrelated.setting"];
    [[NSNotificationCenter defaultCenter] postNotificationName:NSUserDefaultsDidChangeNotification object:d];
    [p requestRefresh]; Drain(); CHECK(p.snapshot.version==version && notifications==1);
    NSUInteger reads=d.reads;
    for (int i=0;i<1000;i++) (void)CSMessageActionForDirection(p.snapshot,CSMessageActionDirectionLeft,NO);
    CHECK(d.reads==reads);
    [d setBool:YES forKey:CSMessageActionRepeatEnabledKey];
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(),(__bridge CFStringRef)CSMessageActionRepeatDarwinNotification,NULL,NULL,true);
    Drain(); CHECK(p.snapshot.repeatEnabled && p.snapshot.version==version+1);
    [d removeObjectForKey:CSMessageActionRepeatEnabledKey];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UIApplicationDidBecomeActiveNotification" object:nil];
    Drain(); CHECK(!p.snapshot.repeatEnabled && p.snapshot.version==version+2);
    // NS defaults notification bridge, independently of Darwin.
    [d setBool:YES forKey:CSMessageActionVoiceForwardEnabledKey];
    [[NSNotificationCenter defaultCenter] postNotificationName:NSUserDefaultsDidChangeNotification object:d];
    Drain(); CHECK(p.snapshot.voiceForwardEnabled && p.snapshot.version==version+3);
    [d setBool:YES forKey:CSMessageActionImageStickerEnabledKey]; [p requestRefresh]; Drain();
    CHECK(p.snapshot.imageStickerEnabled && p.snapshot.version==version+4);
    CHECK(CSMessageActionEntryAllows(p.snapshot,CSMessageActionEntryMenuAddSticker,CSMessageActionAddSticker));
    CHECK(!CSMessageActionEntryAllows(p.snapshot,CSMessageActionEntryGesture,CSMessageActionAddSticker));
    CHECK(!CSMessageActionEntryAllows(p.snapshot,CSMessageActionEntryMenuAddSticker,CSMessageActionRepeat));
    // Backup import/reset may replace the domain without a feature-specific Darwin notification.
    [d setPersistentDomain:@{CSMessageActionGestureEnabledKey:@YES,CSMessageActionLeftSelfKey:@6} forName:suite];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UIApplicationDidBecomeActiveNotification" object:nil];
    Drain(); CHECK(p.snapshot.gestureEnabled && p.snapshot.leftSelfAction==6 && !p.snapshot.voiceForwardEnabled);
    [d removePersistentDomainForName:suite];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UIApplicationDidBecomeActiveNotification" object:nil];
    Drain(); CHECK(!p.snapshot.gestureEnabled && p.snapshot.leftSelfAction==0);
    [[NSNotificationCenter defaultCenter] removeObserver:observer];
}
int main(void) { @autoreleasepool {
    NSString *suite=[@"CSMessageActionCoreTests." stringByAppendingString:NSUUID.UUID.UUIDString];
    CountingDefaults *d=[[CountingDefaults alloc] initWithSuiteName:suite]; d.readKeys=[NSMutableSet set];
    TestPreferences(d,suite); [d removePersistentDomainForName:suite];
    TestPolicy(d); TestGesture(); TestContext(); TestSubmission(); TestAllSubmissionTransitions();
    [d removePersistentDomainForName:suite];
    printf("PASS: %u message action core checks (isolated defaults suite; no native sends)\n",checks);
} return 0; }
