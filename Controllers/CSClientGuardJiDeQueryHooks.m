#import "CSClientGuard.h"
#import "CSCloseFriendSignatures.h"
#include <stdbool.h>

static Method JiDeQueryMethod(NSString *className, NSString *name) {
    Class cls = NSClassFromString(className);
    return cls ? class_getInstanceMethod(cls, NSSelectorFromString(name)) : NULL;
}

static void JiDeQueryReject(NSString *className, NSString *name) {
    CSClientGuardRecordStatus([NSString stringWithFormat:@"-[%@ %@]", className, name],
        JiDeQueryMethod(className, name) ? @"接口签名不兼容，未安装" : @"当前宿主无此接口，未安装");
}

// Only the synchronous predecessor call enters the existing query scope. No
// request, opcode, message or result is replaced, and work it queues inherits no
// thread-local scope. Separate blocks preserve both supported BOOL encodings.
#define JIDE_FRIEND_SEND(TYPE, ENCODING) \
    do { \
        IMP replacement = imp_implementationWithBlock(^TYPE(id object, id request) { \
            if (!CSClientGuardEvaluateCall(CSClientGuardFriendScope, NO)) \
                return ((TYPE (*)(id, SEL, id))original)(object, selector, request); \
            __block TYPE result; \
            @try { \
                CSClientGuardWithCheckScope(^{ \
                    result = ((TYPE (*)(id, SEL, id))original)(object, selector, request); \
                }); \
            } @catch (NSException *exception) { \
                CSClientGuardRecordOutcome(CSClientGuardFriendScope, CSClientGuardCallOriginalException); @throw exception; \
            } \
            CSClientGuardRecordOutcome(CSClientGuardFriendScope, CSClientGuardCallApplied); \
            return result; \
        }); \
        CSClientGuardInstallHook(className, name, NO, ENCODING "@:@", replacement, &original); \
    } while (0)

static void JiDeFriendSend(void) {
    NSString *className = @"NormalContactVerifyLogic", *name = @"sendVerifyUserRequest:";
    SEL selector = NSSelectorFromString(name);
    Method method = JiDeQueryMethod(className, name);
    __block IMP original = NULL;
    if (CSCloseFriendMethodMatches(method, "B@:@")) JIDE_FRIEND_SEND(bool, "B");
    else if (CSCloseFriendMethodMatches(method, "c@:@")) JIDE_FRIEND_SEND(signed char, "c");
    else JiDeQueryReject(className, name);
}
#undef JIDE_FRIEND_SEND

#define JIDE_FRIEND_START(RESULT, RESULT_ENCODING, OPCODE, OPCODE_ENCODING) \
    do { \
        IMP replacement = imp_implementationWithBlock(^RESULT(id object, id contact, OPCODE opcode, id message) { \
            if (!CSClientGuardEvaluateCall(CSClientGuardFriendScope, NO)) \
                return ((RESULT (*)(id, SEL, id, OPCODE, id))original)(object, selector, contact, opcode, message); \
            __block RESULT result; \
            @try { \
                CSClientGuardWithCheckScope(^{ \
                    result = ((RESULT (*)(id, SEL, id, OPCODE, id))original)(object, selector, contact, opcode, message); \
                }); \
            } @catch (NSException *exception) { \
                CSClientGuardRecordOutcome(CSClientGuardFriendScope, CSClientGuardCallOriginalException); @throw exception; \
            } \
            CSClientGuardRecordOutcome(CSClientGuardFriendScope, CSClientGuardCallApplied); \
            return result; \
        }); \
        CSClientGuardInstallHook(className, name, NO, RESULT_ENCODING "@:@" OPCODE_ENCODING "@", replacement, &original); \
    } while (0)

static void JiDeFriendStart(void) {
    NSString *className = @"NormalContactVerifyLogic", *name = @"startVerifyContact:opcode:verifyMsg:";
    SEL selector = NSSelectorFromString(name);
    Method method = JiDeQueryMethod(className, name);
    __block IMP original = NULL;
    if (CSCloseFriendMethodMatches(method, "B@:@i@")) JIDE_FRIEND_START(bool, "B", int, "i");
    else if (CSCloseFriendMethodMatches(method, "B@:@I@")) JIDE_FRIEND_START(bool, "B", unsigned int, "I");
    else if (CSCloseFriendMethodMatches(method, "B@:@q@")) JIDE_FRIEND_START(bool, "B", long long, "q");
    else if (CSCloseFriendMethodMatches(method, "B@:@Q@")) JIDE_FRIEND_START(bool, "B", unsigned long long, "Q");
    else if (CSCloseFriendMethodMatches(method, "c@:@i@")) JIDE_FRIEND_START(signed char, "c", int, "i");
    else if (CSCloseFriendMethodMatches(method, "c@:@I@")) JIDE_FRIEND_START(signed char, "c", unsigned int, "I");
    else if (CSCloseFriendMethodMatches(method, "c@:@q@")) JIDE_FRIEND_START(signed char, "c", long long, "q");
    else if (CSCloseFriendMethodMatches(method, "c@:@Q@")) JIDE_FRIEND_START(signed char, "c", unsigned long long, "Q");
    else JiDeQueryReject(className, name);
}
#undef JIDE_FRIEND_START

static void JiDeDictionaryQuery(NSString *className, NSString *name,
    CSClientGuardCapability capability, NSArray<NSString *> *keys) {
    SEL selector = NSSelectorFromString(name);
    __block IMP original = NULL;
    IMP replacement = imp_implementationWithBlock(^id(id object) {
        id result;
        @try { result = ((id (*)(id, SEL))original)(object, selector); }
        @catch (NSException *exception) {
            if (CSClientGuardEvaluateCall(capability, NO))
                CSClientGuardRecordOutcome(capability, CSClientGuardCallOriginalException);
            @throw exception;
        }
        if (!CSClientGuardEvaluateCall(capability, NO)) return result;
        if (![result isKindOfClass:NSDictionary.class]) {
            CSClientGuardRecordOutcome(capability, CSClientGuardCallUnexpectedValue); return result;
        }
        @try {
            NSMutableDictionary *filtered = [result mutableCopy];
            if (filtered == result || ![filtered isKindOfClass:NSMutableDictionary.class]) {
                CSClientGuardRecordOutcome(capability, CSClientGuardCallUnexpectedValue); return result;
            }
            [filtered removeObjectsForKeys:keys];
            // Preserve the predecessor's mutability contract: some callers add
            // their own fields to these reports after obtaining the result.
            if ([result isKindOfClass:NSMutableDictionary.class]) {
                CSClientGuardRecordOutcome(capability, CSClientGuardCallApplied); return filtered;
            }
            id immutable = [filtered copy];
            if (![immutable isKindOfClass:NSDictionary.class] || [immutable isKindOfClass:NSMutableDictionary.class]) {
                CSClientGuardRecordOutcome(capability, CSClientGuardCallUnexpectedValue); return result;
            }
            CSClientGuardRecordOutcome(capability, CSClientGuardCallApplied);
            return immutable;
        } @catch (__unused NSException *exception) {
            CSClientGuardRecordOutcome(capability, CSClientGuardCallUnexpectedValue); return result;
        }
    });
    CSClientGuardInstallHook(className, name, NO, "@@:", replacement, &original);
}

static void JiDeExperimentQuery(void) {
    SEL selector = NSSelectorFromString(@"getStringExpt:");
    __block IMP original = NULL;
    IMP replacement = imp_implementationWithBlock(^id(id object, id key) {
        if ([key isKindOfClass:NSString.class] &&
            ([key isEqualToString:@"clicfg_gogwcs_ios_runtime_sdk_dc_dc_report_enable"] ||
             [key isEqualToString:@"clicfg_gogwcs_ios_runtime_sdk_main_cert_chain_report"]) &&
            CSClientGuardEvaluateCall(CSClientGuardExperimentReports, NO)) {
            CSClientGuardRecordOutcome(CSClientGuardExperimentReports, CSClientGuardCallApplied); return @"0";
        }
        return ((id (*)(id, SEL, id))original)(object, selector, key);
    });
    CSClientGuardInstallHook(@"ExptService", @"getStringExpt:", NO, "@@:@", replacement, &original);
}

void CSClientGuardInstallJiDeQueryHooks(void) {
    if (CSClientGuardShouldApply(CSClientGuardFriendScope, NO)) {
        JiDeFriendSend();
        JiDeFriendStart();
    }
    if (CSClientGuardShouldApply(CSClientGuardDeviceReport, NO))
        JiDeDictionaryQuery(@"MMDeviceInfoManager", @"deviceEnvironmentReport", CSClientGuardDeviceReport,
            @[@"provisioning_type", @"cert_valid", @"env_abnormal"]);
    if (CSClientGuardShouldApply(CSClientGuardFingerprintData, NO))
        JiDeDictionaryQuery(@"MMFPManager", @"generateFingerprint", CSClientGuardFingerprintData, @[@"jb_indicator"]);
    if (CSClientGuardShouldApply(CSClientGuardExperimentReports, NO)) JiDeExperimentQuery();
}
