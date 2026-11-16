#import "CSClientGuard.h"
#include <stdbool.h>

// These wrappers preserve the predecessor supplied by the shared hook installer.
// Disabling a capability affects future calls only: a start/install call that was
// skipped is not replayed, so restoring monitoring requires restarting the host.
// No crash reports are deleted and no original monitoring state is rewritten.

static Method CSClientGuardNativeMethod(NSString *className, NSString *selectorName) {
    Class cls = NSClassFromString(className);
    return cls ? class_getInstanceMethod(cls, NSSelectorFromString(selectorName)) : NULL;
}

static char CSClientGuardNativeReturnType(Method method) {
    char type[16] = {0};
    if (method) method_getReturnType(method, type, sizeof(type));
    return type[0];
}

static char CSClientGuardNativeArgumentType(Method method, unsigned int index) {
    char type[16] = {0};
    if (method && method_getNumberOfArguments(method) > index)
        method_getArgumentType(method, index, type, sizeof(type));
    return type[0];
}

static void CSClientGuardInstallBooleanResultHook(NSString *className,
    NSString *selectorName, CSClientGuardCapability capability, bool guardedResult) {
    SEL selector = NSSelectorFromString(selectorName);
    Method method = CSClientGuardNativeMethod(className, selectorName);
    __block IMP original = NULL;

    // BOOL is encoded as B on current iOS targets, but some host methods retain
    // the signed-char c encoding. Each branch has its own exact native ABI.
    if (CSClientGuardNativeReturnType(method) == 'c') {
        IMP replacement = imp_implementationWithBlock(^signed char(id object) {
            if (CSClientGuardEvaluateCall(capability, NO)) {
                CSClientGuardRecordOutcome(capability, CSClientGuardCallApplied);
                return guardedResult ? (signed char)1 : (signed char)0;
            }
            return ((signed char (*)(id, SEL))original)(object, selector);
        });
        CSClientGuardInstallHook(className, selectorName, NO, "c@:", replacement, &original);
    } else {
        IMP replacement = imp_implementationWithBlock(^bool(id object) {
            if (CSClientGuardEvaluateCall(capability, NO)) {
                CSClientGuardRecordOutcome(capability, CSClientGuardCallApplied);
                return guardedResult;
            }
            return ((bool (*)(id, SEL))original)(object, selector);
        });
        // The shared installer checks the complete signature. Missing classes,
        // methods and unsupported return types are reported without installing.
        CSClientGuardInstallHook(className, selectorName, NO, "B@:", replacement, &original);
    }
}

static void CSClientGuardInstallMonitoringHook(void) {
    NSString *className = @"KSCrash";
    NSString *selectorName = @"setMonitoring:";
    SEL selector = NSSelectorFromString(selectorName);
    Method method = CSClientGuardNativeMethod(className, selectorName);
    __block IMP original = NULL;

    if (CSClientGuardNativeArgumentType(method, 2) == 'B') {
        IMP replacement = imp_implementationWithBlock(^(id object, bool monitoring) {
            if (CSClientGuardEvaluateCall(CSClientGuardCrashMonitor, NO)) {
                CSClientGuardRecordOutcome(CSClientGuardCrashMonitor, CSClientGuardCallApplied); return;
            }
            ((void (*)(id, SEL, bool))original)(object, selector, monitoring);
        });
        CSClientGuardInstallHook(className, selectorName, NO, "v@:B", replacement, &original);
    } else {
        IMP replacement = imp_implementationWithBlock(^(id object, int monitoring) {
            if (CSClientGuardEvaluateCall(CSClientGuardCrashMonitor, NO)) {
                CSClientGuardRecordOutcome(CSClientGuardCrashMonitor, CSClientGuardCallApplied); return;
            }
            ((void (*)(id, SEL, int))original)(object, selector, monitoring);
        });
        // KSCrash monitoring is an int bit mask in the checked host headers.
        // Any other ABI is rejected by the installer; it is not coerced to int.
        CSClientGuardInstallHook(className, selectorName, NO, "v@:i", replacement, &original);
    }
}

static void CSClientGuardInstallVendorIDHook(void) {
    SEL selector = NSSelectorFromString(@"identifierForVendor");
    __block IMP original = NULL;
    IMP replacement = imp_implementationWithBlock(^id(id object) {
        if (CSClientGuardEvaluateCall(CSClientGuardVendorID, YES)) {
            NSUUID *identifier = CSClientGuardVendorUUID();
            if (identifier) { CSClientGuardRecordOutcome(CSClientGuardVendorID, CSClientGuardCallApplied); return identifier; }
            CSClientGuardRecordOutcome(CSClientGuardVendorID, CSClientGuardCallResourceUnavailable);
        }
        return ((id (*)(id, SEL))original)(object, selector);
    });
    // Only the observed QIDevice entry is supported. Do not widen this to the
    // system UIDevice class when QIDevice or its method is absent.
    CSClientGuardInstallHook(@"QIDevice", @"identifierForVendor", NO, "@@:",
        replacement, &original);
}

void CSClientGuardInstallNativeHooks(void) {
    // This function is called by the shared controller after startup readiness.
    // Capabilities are independent and installed lazily; refreshes are safe
    // because the shared installer owns duplicate detection and block disposal.
    if (CSClientGuardShouldApply(CSClientGuardCrashBlock, NO))
        CSClientGuardInstallBooleanResultHook(@"WCCrashBlockMonitorPlugin", @"start",
            CSClientGuardCrashBlock, true);

    if (CSClientGuardShouldApply(CSClientGuardCrashMonitor, NO)) {
        CSClientGuardInstallBooleanResultHook(@"KSCrash", @"install",
            CSClientGuardCrashMonitor, true);
        CSClientGuardInstallMonitoringHook();
    }

    if (CSClientGuardShouldApply(CSClientGuardVendorID, NO))
        CSClientGuardInstallVendorIDHook();

    if (CSClientGuardShouldApply(CSClientGuardSafeMode, NO))
        CSClientGuardInstallBooleanResultHook(@"MMSafeModeMgr", @"shouldEnterSafeMode",
            CSClientGuardSafeMode, false);
}
