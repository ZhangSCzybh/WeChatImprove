#import <Foundation/Foundation.h>
#import <objc/message.h>
#import "CSAdPurification.h"
#include <stdatomic.h>

// Link real policy, signature matching and subscription wrappers. These fixtures
// replace only the host providers and Substrate; all assertions use real hooks.
void CSAdPurificationInstallSubscriptionHooks(void);
typedef void (^CSSubscriptionCompletion)(id, id);
static atomic_uint_fast64_t Checks, PredicateCalls, DiscardCalls, BoxDiscardCalls, CardCalls;
static NSUInteger HookCalls;
static id AFFOutput, Plugins;
#define CHECK(c) do { atomic_fetch_add(&Checks, 1); if (!(c)) { NSLog(@"Ad subscriptions FAIL %d: %s", __LINE__, #c); exit(1); } } while (0)

@interface CSSubscriptionCard : NSObject
@property(nonatomic, strong) id message;
@property(nonatomic, strong) id payload;
@end
@implementation CSSubscriptionCard @end
@interface CMessageWrap : NSObject
@property(nonatomic) unsigned int fixtureType;
@property(nonatomic) unsigned int fixtureInnerType;
@property(nonatomic) bool fixtureDiscard;
@property(nonatomic, strong) CSSubscriptionCard *fixtureCard;
@property(nonatomic, copy) dispatch_block_t onPredicate;
- (bool)isBizAdCanvasMsg;
@end
@implementation CMessageWrap
- (bool)isBizAdCanvasMsg {
    atomic_fetch_add(&PredicateCalls, 1);
    bool advertising = self.fixtureType == 10002 && self.fixtureInnerType == 6;
    if (self.onPredicate) self.onPredicate();
    return advertising;
}
@end
@interface CSThrowingSubscriptionMessage : CMessageWrap @end
@implementation CSThrowingSubscriptionMessage
- (bool)isBizAdCanvasMsg { @throw [NSException exceptionWithName:@"predicate" reason:nil userInfo:nil]; }
@end
@interface CSUnrelatedSubscriptionMessage : NSObject
- (bool)isBizAdCanvasMsg;
@end
@implementation CSUnrelatedSubscriptionMessage
- (bool)isBizAdCanvasMsg { return true; }
@end

static bool HostDiscard(id message) {
    if (![message isKindOfClass:CMessageWrap.class]) return false;
    CMessageWrap *wrap = message;
    return wrap.fixtureDiscard || wrap.fixtureType == 1 || wrap.fixtureType == 3 || wrap.fixtureType == 34;
}
@interface BrandTimelineMsgMgr : NSObject
+ (bool)canTimlineMsgDiscard:(id)message;
- (bool)isExptNotShowAd;
- (bool)isFlutterAffSupportAd;
@end
@implementation BrandTimelineMsgMgr
+ (bool)canTimlineMsgDiscard:(id)message { atomic_fetch_add(&DiscardCalls, 1); return HostDiscard(message); }
- (bool)isExptNotShowAd { return false; }
- (bool)isFlutterAffSupportAd { return true; }
@end
@interface BoxBrandTimelineMsgMgr : NSObject
+ (bool)canTimlineMsgDiscard:(id)message;
- (bool)isExptNotShowAd;
- (bool)isFlutterAffSupportAd;
@end
@implementation BoxBrandTimelineMsgMgr
+ (bool)canTimlineMsgDiscard:(id)message { atomic_fetch_add(&BoxDiscardCalls, 1); return HostDiscard(message); }
- (bool)isExptNotShowAd { return false; }
- (bool)isFlutterAffSupportAd { return true; }
@end
@interface BrandAffDataConverter : NSObject
+ (id)convertAffMsgInfoDataListToMsgWrapList:(id)data;
@end
@implementation BrandAffDataConverter
+ (id)convertAffMsgInfoDataListToMsgWrapList:(__unused id)data { return AFFOutput; }
@end
@interface BrandFlutterUtility : NSObject
+ (id)convertMsgWrapToMassSendMsg:(id)message;
@end
@implementation BrandFlutterUtility
+ (id)convertMsgWrapToMassSendMsg:(id)message {
    atomic_fetch_add(&CardCalls, 1);
    return [message isKindOfClass:CMessageWrap.class] ? [(CMessageWrap *)message fixtureCard] : nil;
}
@end
@interface BoxBrandTLFlutterViewController : NSObject
- (bool)enableAd;
- (id)getMagicBrushFlutterPlugins;
@end
@implementation BoxBrandTLFlutterViewController
- (bool)enableAd { return true; }
- (id)getMagicBrushFlutterPlugins { return Plugins; }
@end

@interface CSSubscriptionAPIFrame : NSObject
@property(nonatomic, copy) dispatch_block_t action;
@property(nonatomic, strong) id expectedCompletion;
@property(nonatomic, strong) id seenCompletion;
@property(nonatomic) int64_t order;
@property(nonatomic) bool initial;
@property(nonatomic) bool reset;
@property(nonatomic) NSUInteger calls;
@property(nonatomic) NSUInteger callbacks;
@property(nonatomic) BOOL holdCompletion;
@property(nonatomic, copy) CSSubscriptionCompletion pendingCompletion;
@property(nonatomic, strong) id result;
@property(nonatomic, strong) id error;
@end
@implementation CSSubscriptionAPIFrame @end
static NSString *const APIFrameKey = @"CSSubscriptionTests.APIFrame";
static void APIOriginal(int64_t order, bool initial, bool reset, CSSubscriptionCompletion completion) {
    CSSubscriptionAPIFrame *frame = NSThread.currentThread.threadDictionary[APIFrameKey];
    CHECK(frame != nil);
    frame.calls++;
    frame.order = order; frame.initial = initial; frame.reset = reset;
    frame.seenCompletion = completion;
    CHECK(frame.seenCompletion == frame.expectedCompletion);
    if (frame.action) frame.action();
    if (frame.holdCompletion) frame.pendingCompletion = completion;
    else if (completion) completion(frame.result, frame.error);
}
@interface FlutterBrandTLApiImplementation : NSObject
- (void)getMassSendDataLastOrderId:(int64_t)order initData:(bool)initial resetData:(bool)reset completion:(CSSubscriptionCompletion)completion;
@end
@implementation FlutterBrandTLApiImplementation
- (void)getMassSendDataLastOrderId:(int64_t)order initData:(bool)initial resetData:(bool)reset completion:(CSSubscriptionCompletion)completion { APIOriginal(order, initial, reset, completion); }
@end
@interface FlutterFinderBoxApiImplementation : NSObject
- (void)getMassSendDataLastOrderId:(int64_t)order initData:(bool)initial resetData:(bool)reset completion:(CSSubscriptionCompletion)completion;
@end
@implementation FlutterFinderBoxApiImplementation
- (void)getMassSendDataLastOrderId:(int64_t)order initData:(bool)initial resetData:(bool)reset completion:(CSSubscriptionCompletion)completion { APIOriginal(order, initial, reset, completion); }
@end

@interface CSSubscriptionMigrationFrame : NSObject
@property(nonatomic, copy) dispatch_block_t action;
@property(nonatomic, strong) id result;
@property(nonatomic) NSUInteger calls;
@end
@implementation CSSubscriptionMigrationFrame @end
static NSString *const MigrationFrameKey = @"CSSubscriptionTests.MigrationFrame";
static id MigrationOriginal(__unused id object, __unused SEL selector) {
    CSSubscriptionMigrationFrame *frame = NSThread.currentThread.threadDictionary[MigrationFrameKey];
    CHECK(frame != nil);
    frame.calls++;
    if (frame.action) frame.action();
    return frame.result;
}
@interface AffBizCppToNativeManagerImpl : NSObject
- (id)doDataMigrate;
@end
@implementation AffBizCppToNativeManagerImpl
- (id)doDataMigrate { return MigrationOriginal(self, _cmd); }
@end
@interface CSWrongMigrationProvider : NSObject
- (double)doDataMigrate;
@end
@implementation CSWrongMigrationProvider
- (double)doDataMigrate { CHECK(false); return 1; }
@end

void CSAdPurificationInstallNativeHooks(void) { CSAdPurificationInstallSubscriptionHooks(); }
void CSAdPurificationInstallWebHooks(void) {}
void CSAdPurificationTestHookMessage(Class cls, SEL selector, IMP replacement, IMP *original) {
    Method method = class_getInstanceMethod(cls, selector);
    *original = method_getImplementation(method);
    if (!class_addMethod(cls, selector, replacement, method_getTypeEncoding(method)))
        method_setImplementation(method, replacement);
    HookCalls++;
}
static void Configure(NSUserDefaults *defaults, CSAdPurificationScope scopes, BOOL master) {
    for (NSDictionary *option in CSAdPurificationOptions())
        [defaults setBool:(scopes & [option[@"capability"] unsignedLongLongValue]) != 0 forKey:CSAdPurificationPreferenceKey(option[@"identifier"])];
    [defaults setBool:master forKey:CSAdPurificationEnabledKey];
    CSAdPurificationRefresh();
    CHECK(CSAdPurificationActiveScopes() == (master ? scopes : 0));
}
static CMessageWrap *Message(unsigned int type, unsigned int inner, id payload) {
    CMessageWrap *message = [CMessageWrap new];
    message.fixtureType = type; message.fixtureInnerType = inner;
    message.fixtureCard = [CSSubscriptionCard new];
    message.fixtureCard.message = message;
    message.fixtureCard.payload = payload;
    return message;
}
static double BadPredicate(__unused id object, __unused SEL selector) { CHECK(false); return 1; }
static signed char CharPredicate(__unused id object, __unused SEL selector) { atomic_fetch_add(&PredicateCalls, 1); return 1; }
static CMessageWrap *DynamicMessage(NSString *name, IMP predicate, const char *encoding) {
    Class cls = objc_allocateClassPair(CMessageWrap.class, name.UTF8String, 0);
    CHECK(cls != Nil && class_addMethod(cls, @selector(isBizAdCanvasMsg), predicate, encoding));
    objc_registerClassPair(cls);
    return [cls new];
}
static CSSubscriptionAPIFrame *APIFrame(dispatch_block_t action) {
    CSSubscriptionAPIFrame *frame = [CSSubscriptionAPIFrame new];
    frame.action = action; frame.result = @[[NSObject new]]; frame.error = [NSObject new];
    __weak CSSubscriptionAPIFrame *weakFrame = frame;
    CSSubscriptionCompletion completion = ^(id result, id error) {
        CSSubscriptionAPIFrame *current = weakFrame;
        CHECK(current != nil && result == current.result && error == current.error);
        current.callbacks++;
    };
    frame.expectedCompletion = completion;
    return frame;
}
static void CallAPI(Class cls, CSSubscriptionAPIFrame *frame, int64_t order, bool initial, bool reset) {
    NSMutableDictionary *dictionary = NSThread.currentThread.threadDictionary;
    id previous = dictionary[APIFrameKey]; dictionary[APIFrameKey] = frame;
    NSUInteger before = frame.calls;
    @try {
        ((void (*)(id, SEL, int64_t, bool, bool, CSSubscriptionCompletion))objc_msgSend)
            ([cls new], @selector(getMassSendDataLastOrderId:initData:resetData:completion:), order, initial, reset, frame.expectedCompletion);
    } @finally {
        CHECK(frame.calls == before + 1);
        CHECK(frame.order == order && frame.initial == initial && frame.reset == reset);
        CHECK(frame.seenCompletion == frame.expectedCompletion);
        if (previous) dictionary[APIFrameKey] = previous; else [dictionary removeObjectForKey:APIFrameKey];
    }
}
static void WithinDisplay(Class cls, dispatch_block_t action) {
    CSSubscriptionAPIFrame *frame = APIFrame(action);
    CallAPI(cls, frame, INT64_MIN + 0x123456789LL, true, false);
    CHECK(frame.callbacks == 1);
}
static void InMigration(Class cls, dispatch_block_t action) {
    CSSubscriptionMigrationFrame *frame = [CSSubscriptionMigrationFrame new];
    frame.action = action; frame.result = [NSObject new];
    NSMutableDictionary *dictionary = NSThread.currentThread.threadDictionary;
    id previous = dictionary[MigrationFrameKey]; dictionary[MigrationFrameKey] = frame;
    @try {
        id returned = ((id (*)(id, SEL))objc_msgSend)([cls new], @selector(doDataMigrate));
        CHECK(returned == frame.result);
    } @finally {
        CHECK(frame.calls == 1);
        if (previous) dictionary[MigrationFrameKey] = previous; else [dictionary removeObjectForKey:MigrationFrameKey];
    }
}
static void CheckDiscard(id message, bool expected) {
    uint64_t before = atomic_load(&DiscardCalls);
    CHECK([BrandTimelineMsgMgr canTimlineMsgDiscard:message] == expected);
    CHECK(atomic_load(&DiscardCalls) == before + 1);
}
static NSArray *RenderCards(NSArray *messages, BOOL box) {
    NSMutableArray *cards = [NSMutableArray array];
    for (CMessageWrap *message in messages) {
        // BOTH real getMassSendData implementations call this same class.
        if ([BrandTimelineMsgMgr canTimlineMsgDiscard:message]) continue;
        CSSubscriptionCard *card = [BrandFlutterUtility convertMsgWrapToMassSendMsg:message];
        if (box) {
            // Box has no nil branch: it copies fields into a new card and adds
            // it. A converter returning nil would leave a visible empty card.
            CSSubscriptionCard *copy = [CSSubscriptionCard new];
            copy.message = card.message; copy.payload = card.payload;
            [cards addObject:copy];
        } else if (card) {
            [cards addObject:card];
        }
    }
    return cards;
}
static NSDictionary *UntouchedImplementations(void) {
    NSArray *targets = @[
        @[BrandAffDataConverter.class, @"convertAffMsgInfoDataListToMsgWrapList:", @YES],
        @[BrandFlutterUtility.class, @"convertMsgWrapToMassSendMsg:", @YES],
        @[BoxBrandTimelineMsgMgr.class, @"canTimlineMsgDiscard:", @YES],
        @[BrandTimelineMsgMgr.class, @"isExptNotShowAd", @NO],
        @[BrandTimelineMsgMgr.class, @"isFlutterAffSupportAd", @NO],
        @[BoxBrandTimelineMsgMgr.class, @"isExptNotShowAd", @NO],
        @[BoxBrandTimelineMsgMgr.class, @"isFlutterAffSupportAd", @NO],
        @[BoxBrandTLFlutterViewController.class, @"enableAd", @NO],
        @[BoxBrandTLFlutterViewController.class, @"getMagicBrushFlutterPlugins", @NO]
    ];
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    for (NSArray *target in targets) {
        Class cls = target[0]; SEL selector = NSSelectorFromString(target[1]);
        Method method = [target[2] boolValue] ? class_getClassMethod(cls, selector) : class_getInstanceMethod(cls, selector);
        result[[NSString stringWithFormat:@"%@.%@", NSStringFromClass(cls), target[1]]] = [NSValue valueWithPointer:method_getImplementation(method)];
    }
    return result;
}
static void Wait(dispatch_semaphore_t semaphore) {
    CHECK(dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC)) == 0);
}

int main(void) { @autoreleasepool {
    NSString *suite = [@"CSAdSubscriptionTests." stringByAppendingString:NSUUID.UUID.UUIDString];
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:suite];
    [defaults removePersistentDomainForName:suite];
    CSAdPurificationUseTestDefaults(defaults);
    // Start with an inherited wrong migration ABI. A correctly typed subclass
    // override later models the missing interface becoming available on retry.
    Class boxMigration = objc_allocateClassPair(CSWrongMigrationProvider.class, "BoxAffBizCppToNativeManagerImpl", 0);
    CHECK(boxMigration != Nil); objc_registerClassPair(boxMigration);
    NSDictionary *untouched = UntouchedImplementations();
    IMP discardBefore = method_getImplementation(class_getClassMethod(BrandTimelineMsgMgr.class, @selector(canTimlineMsgDiscard:)));
    IMP apiBefore = method_getImplementation(class_getInstanceMethod(FlutterBrandTLApiImplementation.class, @selector(getMassSendDataLastOrderId:initData:resetData:completion:)));
    CSAdPurificationStart(); CSAdPurificationInstallSubscriptionHooks();
    CHECK(HookCalls == 0);

    CMessageWrap *ad = Message(10002, 6, @"material");
    CMessageWrap *blankAd = Message(10002, 6, @"");
    CMessageWrap *nilAd = Message(10002, 6, nil);
    CMessageWrap *recommendation = Message(10002, 8, @"recommendation");
    CMessageWrap *ordinary = Message(49, 6, @"normal");
    CMessageWrap *text = Message(49, 0, @"advertisement word in a normal title");
    CMessageWrap *hostDiscard = Message(1, 0, @"host discarded text");
    CMessageWrap *wrong = DynamicMessage(@"CSBadSubscriptionPredicate", (IMP)BadPredicate, "d@:");
    CMessageWrap *charAd = DynamicMessage(@"CSCharSubscriptionPredicate", (IMP)CharPredicate, "c@:");
    id throwing = [CSThrowingSubscriptionMessage new], unrelated = [CSUnrelatedSubscriptionMessage new];
    NSArray *source = @[ordinary, ad, recommendation, blankAd, text, nilAd];
    AFFOutput = [source mutableCopy]; Plugins = @[ordinary, ad];
    NSArray *apis = @[FlutterBrandTLApiImplementation.class, FlutterFinderBoxApiImplementation.class];
    for (Class api in apis) WithinDisplay(api, ^{ CheckDiscard(ad, false); });
    CHECK(atomic_load(&PredicateCalls) == 0);

    Configure(defaults, CSAdPurificationSubscriptions, YES);
    CHECK(method_getImplementation(class_getClassMethod(BrandTimelineMsgMgr.class, @selector(canTimlineMsgDiscard:))) == discardBefore);
    CHECK(method_getImplementation(class_getInstanceMethod(FlutterBrandTLApiImplementation.class, @selector(getMassSendDataLastOrderId:initData:resetData:completion:))) == apiBefore);
    for (Class api in apis) WithinDisplay(api, ^{ CheckDiscard(ad, false); });
    CHECK(atomic_load(&PredicateCalls) == 0);
    NSUInteger partialHooks = HookCalls;
    CHECK(partialHooks > 0); // The valid ordinary migration guard is harmless.
    CHECK(class_addMethod(boxMigration, @selector(doDataMigrate), (IMP)MigrationOriginal, "@@:"));
    CSAdPurificationRefresh();
    CHECK(HookCalls > partialHooks);
    NSUInteger hooks = HookCalls, installed = CSAdPurificationInstalledHookCount();
    CHECK([UntouchedImplementations() isEqual:untouched]);

    for (Class api in apis) {
        CheckDiscard(ad, false); // Migration and notification callers outside UI.
        WithinDisplay(api, ^{
            CheckDiscard(ad, true); CheckDiscard(blankAd, true); CheckDiscard(nilAd, true);
            CheckDiscard(recommendation, false); CheckDiscard(ordinary, false); CheckDiscard(text, false);
            CheckDiscard(wrong, false); CheckDiscard(throwing, false); CheckDiscard(unrelated, false); CheckDiscard(nil, false);
            CheckDiscard(charAd, true);
            uint64_t predicates = atomic_load(&PredicateCalls);
            CheckDiscard(hostDiscard, true);
            CHECK(atomic_load(&PredicateCalls) == predicates);
            CHECK(![BoxBrandTimelineMsgMgr canTimlineMsgDiscard:ad]);
            CHECK([BrandAffDataConverter convertAffMsgInfoDataListToMsgWrapList:[NSData data]] == AFFOutput);
            CHECK([BrandFlutterUtility convertMsgWrapToMassSendMsg:ad] == ad.fixtureCard);
            for (NSNumber *box in @[@NO, @YES]) {
                NSArray *cards = RenderCards(source, box.boolValue);
                CHECK(cards.count == 3);
                CHECK(((CSSubscriptionCard *)cards[0]).message == ordinary);
                CHECK(((CSSubscriptionCard *)cards[1]).message == recommendation);
                CHECK(((CSSubscriptionCard *)cards[2]).message == text);
                for (CSSubscriptionCard *card in cards) CHECK(card.message != nil);
                CHECK(RenderCards(@[ad, blankAd, nilAd], box.boolValue).count == 0);
            }
            for (Class migration in @[AffBizCppToNativeManagerImpl.class, boxMigration]) {
                InMigration(migration, ^{
                    uint64_t predicatesBefore = atomic_load(&PredicateCalls);
                    CheckDiscard(ad, false); CheckDiscard(hostDiscard, true);
                    CHECK([BrandAffDataConverter convertAffMsgInfoDataListToMsgWrapList:[NSData data]] == AFFOutput);
                    CHECK(atomic_load(&PredicateCalls) == predicatesBefore);
                });
                CheckDiscard(ad, true);
                NSException *sentinel = [NSException exceptionWithName:@"migration" reason:nil userInfo:nil];
                @try { InMigration(migration, ^{ CheckDiscard(ad, false); @throw sentinel; }); CHECK(false); }
                @catch (NSException *exception) { CHECK(exception == sentinel); }
                CheckDiscard(ad, true);
            }
            WithinDisplay(FlutterFinderBoxApiImplementation.class, ^{ CheckDiscard(ad, true); });
            CheckDiscard(ad, true);
        });
        CheckDiscard(ad, false);
        NSException *sentinel = [NSException exceptionWithName:@"display" reason:nil userInfo:nil];
        CSSubscriptionAPIFrame *exceptionFrame = APIFrame(^{ CheckDiscard(ad, true); @throw sentinel; });
        @try { CallAPI(api, exceptionFrame, INT64_MAX - 0x12345678LL, false, true); CHECK(false); }
        @catch (NSException *exception) { CHECK(exception == sentinel); }
        CHECK(exceptionFrame.callbacks == 0);
        CheckDiscard(ad, false);
    }

    // Original completion identity is preserved for both nil and deferred use;
    // its later invocation does not inherit a finished display call's context.
    for (Class api in apis) {
        CSSubscriptionAPIFrame *deferred = APIFrame(^{ CheckDiscard(ad, true); });
        deferred.holdCompletion = YES;
        CallAPI(api, deferred, INT64_MAX, false, true);
        CHECK(deferred.callbacks == 0 && deferred.pendingCompletion == deferred.expectedCompletion);
        CheckDiscard(ad, false);
        deferred.pendingCompletion(deferred.result, deferred.error);
        CHECK(deferred.callbacks == 1);
        CSSubscriptionAPIFrame *nilCompletion = APIFrame(^{ CheckDiscard(ad, true); });
        nilCompletion.expectedCompletion = nil;
        CallAPI(api, nilCompletion, INT64_MIN, false, false);
        CHECK(nilCompletion.callbacks == 0 && nilCompletion.seenCompletion == nil);
    }

    // While the main thread owns a display scope, a real worker remains outside.
    WithinDisplay(FlutterBrandTLApiImplementation.class, ^{
        dispatch_semaphore_t done = dispatch_semaphore_create(0);
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
            CHECK(!NSThread.isMainThread);
            CheckDiscard(ad, false);
            dispatch_semaphore_signal(done);
        });
        Wait(done); CheckDiscard(ad, true);
    });
    // Conversely, a worker's active scope must not make main-thread migration
    // or notification reads filter messages.
    dispatch_semaphore_t entered = dispatch_semaphore_create(0), releaseWorker = dispatch_semaphore_create(0), done = dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        CHECK(!NSThread.isMainThread);
        WithinDisplay(FlutterFinderBoxApiImplementation.class, ^{
            CheckDiscard(ad, true); dispatch_semaphore_signal(entered);
            Wait(releaseWorker); CheckDiscard(ad, true);
        });
        CheckDiscard(ad, false); dispatch_semaphore_signal(done);
    });
    Wait(entered); CheckDiscard(ad, false); dispatch_semaphore_signal(releaseWorker); Wait(done);

    // A close occurring inside the host predicate wins before returning YES.
    CMessageWrap *closing = Message(10002, 6, @"closing");
    closing.onPredicate = ^{ CSAdPurificationSetSetting(CSAdPurificationPreferenceKey(@"subscriptions"), NO); };
    WithinDisplay(FlutterBrandTLApiImplementation.class, ^{
        CheckDiscard(closing, false); CHECK(CSAdPurificationActiveScopes() == 0); CheckDiscard(ad, false);
    });
    for (CSAdPurificationScope scopes = 0; scopes <= CSAdPurificationSubscriptions; scopes += CSAdPurificationSubscriptions) {
        Configure(defaults, scopes, YES);
        for (Class api in apis) WithinDisplay(api, ^{ CheckDiscard(ad, scopes != 0); });
    }
    Configure(defaults, CSAdPurificationRecommendations, YES);
    uint64_t predicatesBefore = atomic_load(&PredicateCalls);
    for (Class api in apis) WithinDisplay(api, ^{ CheckDiscard(ad, false); });
    CHECK(atomic_load(&PredicateCalls) == predicatesBefore);
    Configure(defaults, CSAdPurificationSubscriptions, YES);
    WithinDisplay(FlutterFinderBoxApiImplementation.class, ^{ CheckDiscard(ad, true); });
    CSAdPurificationSetSetting(CSAdPurificationEnabledKey, NO);
    for (Class api in apis) WithinDisplay(api, ^{ CheckDiscard(ad, false); });
    CHECK(CSAdPurificationActiveScopes() == 0);
    CHECK(HookCalls == hooks && CSAdPurificationInstalledHookCount() == installed);
    CHECK([UntouchedImplementations() isEqual:untouched]);
    CHECK([BrandAffDataConverter convertAffMsgInfoDataListToMsgWrapList:[NSData data]] == AFFOutput);
    CHECK([BrandFlutterUtility convertMsgWrapToMassSendMsg:blankAd] == blankAd.fixtureCard);
    CHECK([[BoxBrandTLFlutterViewController new] enableAd]);
    CHECK([[BoxBrandTLFlutterViewController new] getMagicBrushFlutterPlugins] == Plugins);
    CHECK(![[BrandTimelineMsgMgr new] isExptNotShowAd] && [[BrandTimelineMsgMgr new] isFlutterAffSupportAd]);
    CHECK(![[BoxBrandTimelineMsgMgr new] isExptNotShowAd] && [[BoxBrandTimelineMsgMgr new] isFlutterAffSupportAd]);
    CHECK(source.count == 6 && [(NSArray *)AFFOutput count] == 6);
    CHECK([blankAd.fixtureCard.payload isEqual:@""] && nilAd.fixtureCard.payload == nil);
    [defaults removePersistentDomainForName:suite];
    printf("Ad purification subscriptions: %llu checks passed\n", (unsigned long long)atomic_load(&Checks));
} return 0; }
