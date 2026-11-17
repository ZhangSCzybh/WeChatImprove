#import "CSAdPurification.h"
#import "CSCloseFriendSignatures.h"
#import <objc/message.h>

// Both Flutter APIs synchronously build their cards within getMassSendData.
// Keep this context per thread: the shared discard predicate also serves AFF
// migration, while card converters also serve add/delete notifications.
static _Thread_local NSUInteger SubscriptionDisplayDepth;

static BOOL SubscriptionEnabled(void) {
    return CSAdPurificationShouldApply(CSAdPurificationSubscriptions);
}

static BOOL SubscriptionMessageIsAd(id message) {
    @try {
        Class messageClass = NSClassFromString(@"CMessageWrap");
        if (!messageClass || ![message isKindOfClass:messageClass]) return NO;
        SEL selector = NSSelectorFromString(@"isBizAdCanvasMsg");
        Method method = class_getInstanceMethod(object_getClass(message), selector);
        // 8.0.80 distinguishes advertising Canvas (10002 / 6) from
        // recommendation Canvas (10002 / 8). Keep that decision in the host.
        if (CSCloseFriendMethodMatches(method, "B@:"))
            return ((bool (*)(id, SEL))objc_msgSend)(message, selector);
        if (CSCloseFriendMethodMatches(method, "c@:"))
            return ((signed char (*)(id, SEL))objc_msgSend)(message, selector) != 0;
    } @catch (__unused NSException *exception) { return NO; }
    return NO;
}

static BOOL InstallMigrationGuard(NSString *className) {
    SEL selector = NSSelectorFromString(@"doDataMigrate");
    __block IMP original = NULL;
    IMP replacement = imp_implementationWithBlock(^id(id object) {
        NSUInteger previous = SubscriptionDisplayDepth;
        SubscriptionDisplayDepth = 0;
        @try {
            return ((id (*)(id, SEL))original)(object, selector);
        } @finally {
            SubscriptionDisplayDepth = previous;
        }
    });
    // Migration returns an object. Preserve its work, result and exceptions,
    // including when a first service lookup re-enters it during list loading.
    return CSAdPurificationInstallHook(className, NSStringFromSelector(selector), NO,
        "@@:", replacement, &original);
}

static BOOL InstallDiscardHook(void) {
    SEL selector = NSSelectorFromString(@"canTimlineMsgDiscard:");
    __block IMP original = NULL;
    IMP replacement = imp_implementationWithBlock(^bool(id object, id message) {
        bool discarded = ((bool (*)(id, SEL, id))original)(object, selector, message);
        if (discarded || !SubscriptionDisplayDepth || !SubscriptionEnabled()) return discarded;
        BOOL advertising = SubscriptionMessageIsAd(message);
        return advertising && SubscriptionDisplayDepth && SubscriptionEnabled();
    });
    // Both the normal and Box display loops use this class method BEFORE
    // converting/adding a card. Box does not tolerate a nil converted card.
    return CSAdPurificationInstallHook(@"BrandTimelineMsgMgr", NSStringFromSelector(selector), YES,
        "B@:@", replacement, &original);
}

static void InstallDisplayScope(NSString *className) {
    SEL selector = NSSelectorFromString(@"getMassSendDataLastOrderId:initData:resetData:completion:");
    __block IMP original = NULL;
    IMP replacement = imp_implementationWithBlock(^(id object, int64_t lastOrder,
        bool initial, bool reset, id completion) {
        if (!SubscriptionEnabled()) {
            ((void (*)(id, SEL, int64_t, bool, bool, id))original)
                (object, selector, lastOrder, initial, reset, completion);
            return;
        }
        NSUInteger previous = SubscriptionDisplayDepth;
        SubscriptionDisplayDepth = previous + 1;
        @try {
            ((void (*)(id, SEL, int64_t, bool, bool, id))original)
                (object, selector, lastOrder, initial, reset, completion);
        } @finally {
            SubscriptionDisplayDepth = previous;
        }
    });
    // The original completion object is forwarded untouched. The unrelated
    // getBizTimelineMsgListWithCompletion: carries C++ protobuf and is not hooked.
    CSAdPurificationInstallHook(className, NSStringFromSelector(selector), NO,
        "v@:qBB@?", replacement, &original);
}

void CSAdPurificationInstallSubscriptionHooks(void) {
    if (!SubscriptionEnabled()) return;
    BOOL ordinaryMigration = InstallMigrationGuard(@"AffBizCppToNativeManagerImpl");
    BOOL boxMigration = InstallMigrationGuard(@"BoxAffBizCppToNativeManagerImpl");
    // A missing guard leaves presentation filtering uninstalled. Retrying later
    // uses the common installer without adding duplicate predecessor wrappers.
    if (!ordinaryMigration || !boxMigration || !InstallDiscardHook()) return;
    InstallDisplayScope(@"FlutterBrandTLApiImplementation");
    InstallDisplayScope(@"FlutterFinderBoxApiImplementation");
}
