#import "CSClientGuard.h"

// These wrappers preserve the next implementation in Substrate's existing chain.
// A query override is admitted independently on every call; disabling the feature
// therefore restores passthrough without overwriting another tweak's IMP.
static BOOL CSClientGuardStringEquals(id value, NSString *expected) {
    return [value isKindOfClass:NSString.class] && [value isEqualToString:expected];
}

static BOOL CSClientGuardIsHostBundle(id bundle) {
    if (![bundle isKindOfClass:NSBundle.class]) return NO;
    return CSClientGuardStringEquals([bundle bundlePath], CSClientGuardHostBundlePath());
}

static BOOL CSClientGuardResourceMatches(id name, id type, NSString *base, NSString *extension, NSString *fullName) {
    if (CSClientGuardStringEquals(name, base) && CSClientGuardStringEquals(type, extension)) return YES;
    BOOL noType = type == nil || CSClientGuardStringEquals(type, @"");
    return noType && CSClientGuardStringEquals(name, fullName);
}

static BOOL CSClientGuardHostFileMatches(id path, NSString *suffix) {
    if (![path isKindOfClass:NSString.class]) return NO;
    NSString *host = CSClientGuardHostBundlePath();
    // Exact host-plus-suffix matching without constructing a path on every
    // Foundation call, including when an installed wrapper is disabled.
    return host.length && [path length] == host.length + suffix.length &&
        [path hasPrefix:host] && [path hasSuffix:suffix];
}

static void CSClientGuardInstallEnvironmentQueryForClass(NSString *className) {
    SEL selector = @selector(environment);
    __block IMP original = NULL;
    IMP replacement = imp_implementationWithBlock(^id(id process) {
        id result;
        @try { result = ((id (*)(id, SEL))original)(process, selector); }
        @catch (NSException *exception) {
            if (CSClientGuardEvaluateCall(CSClientGuardEnvironment, YES))
                CSClientGuardRecordOutcome(CSClientGuardEnvironment, CSClientGuardCallOriginalException);
            @throw exception;
        }
        if (!CSClientGuardEvaluateCall(CSClientGuardEnvironment, YES)) return result;
        if (![result isKindOfClass:NSDictionary.class]) {
            CSClientGuardRecordOutcome(CSClientGuardEnvironment, CSClientGuardCallUnexpectedValue); return result;
        }
        @try {
            NSMutableDictionary *filtered = [result mutableCopy];
            if (filtered == result || ![filtered isKindOfClass:NSMutableDictionary.class]) {
                CSClientGuardRecordOutcome(CSClientGuardEnvironment, CSClientGuardCallUnexpectedValue); return result;
            }
            [filtered removeObjectForKey:@"DYLD_INSERT_LIBRARIES"];
            id immutable = [filtered copy];
            if (![immutable isKindOfClass:NSDictionary.class] || [immutable isKindOfClass:NSMutableDictionary.class]) {
                CSClientGuardRecordOutcome(CSClientGuardEnvironment, CSClientGuardCallUnexpectedValue); return result;
            }
            CSClientGuardRecordOutcome(CSClientGuardEnvironment, CSClientGuardCallApplied);
            return immutable;
        } @catch (__unused NSException *exception) {
            CSClientGuardRecordOutcome(CSClientGuardEnvironment, CSClientGuardCallUnexpectedValue); return result;
        }
    });
    CSClientGuardInstallHook(className, @"environment", NO, "@@:", replacement, &original);
}

static void CSClientGuardInstallEnvironmentQuery(void) {
    // Foundation may vend a concrete ProcessInfo subclass with its own override.
    // Cover only that actual receiver in addition to the public base class;
    // inherited methods already follow the base wrapper and need no second hook.
    Class concrete = object_getClass(NSProcessInfo.processInfo);
    SEL selector = @selector(environment);
    BOOL hasConcreteOverride = concrete && concrete != NSProcessInfo.class &&
        class_getInstanceMethod(concrete, selector) != class_getInstanceMethod(NSProcessInfo.class, selector);
    CSClientGuardInstallEnvironmentQueryForClass(@"NSProcessInfo");
    if (hasConcreteOverride) CSClientGuardInstallEnvironmentQueryForClass(NSStringFromClass(concrete));
}

static void CSClientGuardInstallFrameworksQuery(void) {
    SEL selector = @selector(contentsOfDirectoryAtPath:error:);
    __block IMP original = NULL;
    IMP replacement = imp_implementationWithBlock(^id(id manager, NSString *path, NSError *__autoreleasing *error) {
        if (CSClientGuardHostFileMatches(path, @"/Frameworks") &&
            CSClientGuardEvaluateCall(CSClientGuardFrameworks, YES)) {
            if (error) *error = nil;
            CSClientGuardRecordOutcome(CSClientGuardFrameworks, CSClientGuardCallApplied);
            return @[];
        }
        return ((id (*)(id, SEL, id, NSError *__autoreleasing *))original)(manager, selector, path, error);
    });
    CSClientGuardInstallHook(@"NSFileManager", @"contentsOfDirectoryAtPath:error:", NO,
        "@@:@^@", replacement, &original);
}

static void CSClientGuardInstallBundleResourceQuery(void) {
    SEL selector = @selector(pathForResource:ofType:);
    __block IMP original = NULL;
    IMP replacement = imp_implementationWithBlock(^id(id bundle, NSString *name, NSString *type) {
        if (CSClientGuardIsHostBundle(bundle)) {
            if (CSClientGuardResourceMatches(name, type, @"embedded", @"mobileprovision", @"embedded.mobileprovision") &&
                CSClientGuardEvaluateCall(CSClientGuardProvisionPath, YES)) {
                CSClientGuardRecordOutcome(CSClientGuardProvisionPath, CSClientGuardCallApplied); return nil;
            }
            if (CSClientGuardResourceMatches(name, type, @"Info", @"plist", @"Info.plist") &&
                CSClientGuardEvaluateCall(CSClientGuardBundleInfo, YES)) {
                NSString *path = CSClientGuardReplacementInfoPath();
                if ([path isKindOfClass:NSString.class] && path.length) {
                    CSClientGuardRecordOutcome(CSClientGuardBundleInfo, CSClientGuardCallApplied); return path;
                }
                CSClientGuardRecordOutcome(CSClientGuardBundleInfo, CSClientGuardCallResourceUnavailable);
            }
        }
        return ((id (*)(id, SEL, id, id))original)(bundle, selector, name, type);
    });
    CSClientGuardInstallHook(@"NSBundle", @"pathForResource:ofType:", NO,
        "@@:@@", replacement, &original);
}

static void CSClientGuardInstallProvisionReadQuery(void) {
    SEL selector = @selector(stringWithContentsOfFile:encoding:error:);
    __block IMP original = NULL;
    IMP replacement = imp_implementationWithBlock(^id(id stringClass, NSString *path, NSUInteger encoding, NSError *__autoreleasing *error) {
        if (CSClientGuardHostFileMatches(path, @"/embedded.mobileprovision") &&
            CSClientGuardEvaluateCall(CSClientGuardProvisionRead, YES)) {
            if (error) *error = [NSError errorWithDomain:NSCocoaErrorDomain code:NSFileReadNoSuchFileError
                userInfo:@{NSFilePathErrorKey:path}];
            CSClientGuardRecordOutcome(CSClientGuardProvisionRead, CSClientGuardCallApplied); return nil;
        }
        return ((id (*)(id, SEL, id, NSUInteger, NSError *__autoreleasing *))original)
            (stringClass, selector, path, encoding, error);
    });
    CSClientGuardInstallHook(@"NSString", @"stringWithContentsOfFile:encoding:error:", YES,
        "@@:@Q^@", replacement, &original);
}

static void CSClientGuardInstallInfoDictionaryQuery(void) {
    SEL selector = @selector(dictionaryWithContentsOfFile:);
    __block IMP original = NULL;
    IMP replacement = imp_implementationWithBlock(^id(id dictionaryClass, NSString *path) {
        if (CSClientGuardHostFileMatches(path, @"/Info.plist") &&
            CSClientGuardEvaluateCall(CSClientGuardBundleInfo, YES)) {
            NSDictionary *info = CSClientGuardReplacementInfo();
            if ([info isKindOfClass:NSDictionary.class]) {
                id replacementInfo = [info copy];
                CSClientGuardRecordOutcome(CSClientGuardBundleInfo, CSClientGuardCallApplied); return replacementInfo;
            }
            CSClientGuardRecordOutcome(CSClientGuardBundleInfo, CSClientGuardCallResourceUnavailable);
        }
        return ((id (*)(id, SEL, id))original)(dictionaryClass, selector, path);
    });
    CSClientGuardInstallHook(@"NSDictionary", @"dictionaryWithContentsOfFile:", YES,
        "@@:@", replacement, &original);
}

static void CSClientGuardInstallReceiptQuery(void) {
    SEL selector = @selector(appStoreReceiptURL);
    __block IMP original = NULL;
    IMP replacement = imp_implementationWithBlock(^id(id bundle) {
        if (CSClientGuardIsHostBundle(bundle) && CSClientGuardEvaluateCall(CSClientGuardReceipt, YES)) {
            NSURL *url = CSClientGuardReceiptURL();
            if ([url isKindOfClass:NSURL.class]) {
                CSClientGuardRecordOutcome(CSClientGuardReceipt, CSClientGuardCallApplied); return url;
            }
            CSClientGuardRecordOutcome(CSClientGuardReceipt, CSClientGuardCallResourceUnavailable);
        }
        return ((id (*)(id, SEL))original)(bundle, selector);
    });
    CSClientGuardInstallHook(@"NSBundle", @"appStoreReceiptURL", NO, "@@:", replacement, &original);
}

static void CSClientGuardInstallObjectCheck(NSString *name) {
    SEL selector = NSSelectorFromString(name);
    __block IMP original = NULL;
    IMP replacement = imp_implementationWithBlock(^(id manager, id argument) {
        if (CSClientGuardEvaluateCall(CSClientGuardChecks, NO)) {
            CSClientGuardRecordOutcome(CSClientGuardChecks, CSClientGuardCallApplied); return;
        }
        CSClientGuardWithCheckScope(^{
            ((void (*)(id, SEL, id))original)(manager, selector, argument);
        });
    });
    CSClientGuardInstallHook(@"ClientCheckMgr", name, NO, "v@:@", replacement, &original);
}

static void CSClientGuardInstallSequenceCheck(void) {
    SEL selector = NSSelectorFromString(@"checkHookWithSeq:");
    __block IMP original = NULL;
    IMP replacement = imp_implementationWithBlock(^(id manager, unsigned int sequence) {
        if (CSClientGuardEvaluateCall(CSClientGuardChecks, NO)) {
            CSClientGuardRecordOutcome(CSClientGuardChecks, CSClientGuardCallApplied); return;
        }
        CSClientGuardWithCheckScope(^{
            ((void (*)(id, SEL, unsigned int))original)(manager, selector, sequence);
        });
    });
    CSClientGuardInstallHook(@"ClientCheckMgr", @"checkHookWithSeq:", NO, "v@:I", replacement, &original);
}

static void CSClientGuardInstallImageRegistrationCheck(void) {
    SEL selector = NSSelectorFromString(@"registerAddImageCallBack");
    __block IMP original = NULL;
    IMP replacement = imp_implementationWithBlock(^(id manager) {
        if (CSClientGuardEvaluateCall(CSClientGuardChecks, NO)) {
            CSClientGuardRecordOutcome(CSClientGuardChecks, CSClientGuardCallApplied); return;
        }
        CSClientGuardWithCheckScope(^{ ((void (*)(id, SEL))original)(manager, selector); });
    });
    CSClientGuardInstallHook(@"ClientCheckMgr", @"registerAddImageCallBack", NO, "v@:", replacement, &original);
}

static void CSClientGuardInstallImageQuery(void) {
    SEL selector = NSSelectorFromString(@"getImageList");
    __block IMP original = NULL;
    IMP replacement = imp_implementationWithBlock(^id(id manager) {
        id result;
        @try { result = ((id (*)(id, SEL))original)(manager, selector); }
        @catch (NSException *exception) {
            if (CSClientGuardEvaluateCall(CSClientGuardImages, NO))
                CSClientGuardRecordOutcome(CSClientGuardImages, CSClientGuardCallOriginalException);
            @throw exception;
        }
        // This method is itself the exact supported inspection endpoint. Its
        // output policy does not require a surrounding Foundation query scope.
        if (!CSClientGuardEvaluateCall(CSClientGuardImages, NO)) return result;
        if (![result isKindOfClass:NSArray.class]) {
            CSClientGuardRecordOutcome(CSClientGuardImages, CSClientGuardCallUnexpectedValue); return result;
        }
        @try {
            // An unexpected element invalidates the entire transformation: never
            // partially filter a value whose native contract is no longer known.
            for (id item in result) if (![item isKindOfClass:NSString.class]) {
                CSClientGuardRecordOutcome(CSClientGuardImages, CSClientGuardCallUnexpectedValue); return result;
            }
            NSSet<NSString *> *names = CSClientGuardImageNames();
            NSMutableArray *filtered = [NSMutableArray arrayWithCapacity:[result count]];
            for (NSString *path in result) if (![names containsObject:path.lastPathComponent]) [filtered addObject:path];
            id replacementImages = [filtered copy];
            CSClientGuardRecordOutcome(CSClientGuardImages, CSClientGuardCallApplied); return replacementImages;
        } @catch (__unused NSException *exception) {
            CSClientGuardRecordOutcome(CSClientGuardImages, CSClientGuardCallUnexpectedValue); return result;
        }
    });
    CSClientGuardInstallHook(@"ClientCheckMgr", @"getImageList", NO, "@@:", replacement, &original);
}

void CSClientGuardInstallQueryHooks(void) {
    BOOL environment = CSClientGuardShouldApply(CSClientGuardEnvironment, NO);
    BOOL frameworks = CSClientGuardShouldApply(CSClientGuardFrameworks, NO);
    BOOL provisionPath = CSClientGuardShouldApply(CSClientGuardProvisionPath, NO);
    BOOL provisionRead = CSClientGuardShouldApply(CSClientGuardProvisionRead, NO);
    BOOL bundleInfo = CSClientGuardShouldApply(CSClientGuardBundleInfo, NO);
    BOOL receipt = CSClientGuardShouldApply(CSClientGuardReceipt, NO);
    BOOL images = CSClientGuardShouldApply(CSClientGuardImages, NO);
    BOOL checks = CSClientGuardShouldApply(CSClientGuardChecks, NO);
    BOOL vendorID = CSClientGuardShouldApply(CSClientGuardVendorID, NO);
    if (environment) CSClientGuardInstallEnvironmentQuery();
    if (frameworks) CSClientGuardInstallFrameworksQuery();
    if (provisionPath || bundleInfo) CSClientGuardInstallBundleResourceQuery();
    if (provisionRead) CSClientGuardInstallProvisionReadQuery();
    if (bundleInfo) CSClientGuardInstallInfoDictionaryQuery();
    if (receipt) CSClientGuardInstallReceiptQuery();
    if (images) CSClientGuardInstallImageQuery();
    if (environment || frameworks || provisionPath || provisionRead || bundleInfo || receipt || images || vendorID || checks) {
        CSClientGuardInstallObjectCheck(@"checkHook:");
        CSClientGuardInstallObjectCheck(@"checkConsistency:");
        CSClientGuardInstallSequenceCheck();
        CSClientGuardInstallImageRegistrationCheck();
    }
}
