#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>
#import <objc/message.h>
#import "CSClientGuard.h"
#include <stdbool.h>
#include <stdint.h>
#include <string.h>

static NSUInteger Assertions, HookCount, SendCalls, StartCalls, DeviceCalls, FingerprintCalls, ExperimentCalls;
static BOOL CharMode;
static char OpcodeKind = 'i';
static signed char SendResult = -73, StartResult = -42;
static id LastReceiver, LastRequest, LastContact, LastMessage, LastExperimentKey;
static uint64_t LastOpcode;
static NSMutableDictionary *EnvironmentSource;
static id DeviceSource, FingerprintSource;
static BOOL ThrowDeviceResult;
static void (^FriendProbe)(NSString *name);

#define CHECK(...) do { Assertions++; if (!(__VA_ARGS__)) { \
    fprintf(stderr, "ClientGuardJiDeQueryTests FAIL %d: %s\n", __LINE__, #__VA_ARGS__); exit(1); \
} } while (0)

void CSClientGuardTestHookMessage(Class cls, SEL selector, IMP replacement, IMP *original) {
    Method method = class_getInstanceMethod(cls, selector);
    *original = method_getImplementation(method);
    if (!class_addMethod(cls, selector, replacement, method_getTypeEncoding(method)))
        method_setImplementation(method, replacement);
    HookCount++;
}

static Class RegisterFixtureSubclass(NSString *name, Class superclass) {
    Class cls = objc_allocateClassPair(superclass, name.UTF8String, 0);
    CHECK(cls != Nil);
    objc_registerClassPair(cls);
    return cls;
}
static Class RegisterFixture(NSString *name) { return RegisterFixtureSubclass(name, NSObject.class); }

static void ObserveSend(id object, id request) {
    SendCalls++; LastReceiver = object; LastRequest = request;
    if (FriendProbe) FriendProbe(@"send");
}
static void ObserveStart(id object, id contact, uint64_t opcode, id message) {
    StartCalls++; LastReceiver = object; LastContact = contact; LastOpcode = opcode; LastMessage = message;
    if (FriendProbe) FriendProbe(@"start");
}

#define ADD_FRIEND_START(RESULT, RESULT_ENCODING, OPCODE, OPCODE_ENCODING) \
    do { \
        IMP imp = imp_implementationWithBlock(^RESULT(id object, id contact, OPCODE opcode, id message) { \
            ObserveStart(object, contact, (uint64_t)opcode, message); \
            return (RESULT)StartResult; \
        }); \
        CHECK(class_addMethod(cls, NSSelectorFromString(@"startVerifyContact:opcode:verifyMsg:"), imp, \
            RESULT_ENCODING "@:@" OPCODE_ENCODING "@")); \
    } while (0)

static void AddFriendFixtureMethods(Class cls) {
    IMP send = CharMode ? imp_implementationWithBlock(^signed char(id object, id request) {
        ObserveSend(object, request); return SendResult;
    }) : imp_implementationWithBlock(^bool(id object, id request) {
        ObserveSend(object, request); return (bool)SendResult;
    });
    CHECK(class_addMethod(cls, NSSelectorFromString(@"sendVerifyUserRequest:"), send, CharMode ? "c@:@" : "B@:@"));
    if (CharMode) {
        switch (OpcodeKind) {
            case 'i': ADD_FRIEND_START(signed char, "c", int, "i"); break;
            case 'I': ADD_FRIEND_START(signed char, "c", unsigned int, "I"); break;
            case 'q': ADD_FRIEND_START(signed char, "c", long long, "q"); break;
            case 'Q': ADD_FRIEND_START(signed char, "c", unsigned long long, "Q"); break;
        }
    } else {
        switch (OpcodeKind) {
            case 'i': ADD_FRIEND_START(bool, "B", int, "i"); break;
            case 'I': ADD_FRIEND_START(bool, "B", unsigned int, "I"); break;
            case 'q': ADD_FRIEND_START(bool, "B", long long, "q"); break;
            case 'Q': ADD_FRIEND_START(bool, "B", unsigned long long, "Q"); break;
        }
    }
}
#undef ADD_FRIEND_START

static int CallSend(id object, id request) {
    SEL selector = NSSelectorFromString(@"sendVerifyUserRequest:");
    if (CharMode) return ((signed char (*)(id, SEL, id))objc_msgSend)(object, selector, request);
    return ((bool (*)(id, SEL, id))objc_msgSend)(object, selector, request);
}
static uint64_t FixtureOpcode(void) {
    switch (OpcodeKind) {
        case 'i': return (uint64_t)-2147483647;
        case 'I': return UINT32_MAX;
        case 'q': return (uint64_t)(INT64_MIN + 127);
        default: return UINT64_MAX - 127;
    }
}

#define CALL_START(RESULT, OPCODE) \
    return ((RESULT (*)(id, SEL, id, OPCODE, id))objc_msgSend)(object, selector, contact, (OPCODE)opcode, message)
static int CallStart(id object, id contact, uint64_t opcode, id message) {
    SEL selector = NSSelectorFromString(@"startVerifyContact:opcode:verifyMsg:");
    if (CharMode) {
        switch (OpcodeKind) {
            case 'i': CALL_START(signed char, int);
            case 'I': CALL_START(signed char, unsigned int);
            case 'q': CALL_START(signed char, long long);
            default: CALL_START(signed char, unsigned long long);
        }
    }
    switch (OpcodeKind) {
        case 'i': CALL_START(bool, int);
        case 'I': CALL_START(bool, unsigned int);
        case 'q': CALL_START(bool, long long);
        default: CALL_START(bool, unsigned long long);
    }
}
#undef CALL_START

static int ExpectedResult(signed char value) { return CharMode ? value : (bool)value; }
static id FixtureEnvironment(__unused id object, __unused SEL selector) { return EnvironmentSource; }
static id FixtureDevice(__unused id object, __unused SEL selector) {
    DeviceCalls++;
    if(ThrowDeviceResult)[NSException raise:@"DeviceOriginalFixture" format:@"propagate"];
    return DeviceSource;
}
static id FixtureFingerprint(__unused id object, __unused SEL selector) { FingerprintCalls++; return FingerprintSource; }
static double WrongFingerprint(__unused id object, __unused SEL selector) { return 9.25; }
static id FixtureExperiment(__unused id object, __unused SEL selector, id key) {
    ExperimentCalls++; LastExperimentKey = key; return @"predecessor";
}
static id CallObject(id object, NSString *name) {
    return ((id (*)(id, SEL))objc_msgSend)(object, NSSelectorFromString(name));
}
static id CallExperiment(id object, id key) {
    return ((id (*)(id, SEL, id))objc_msgSend)(object, NSSelectorFromString(@"getStringExpt:"), key);
}
static NSDictionary *QueryState(CSClientGuardCapability capability) {
    for(NSDictionary *state in CSClientGuardCapabilityStates())
        if([state[@"capability"] unsignedLongLongValue]==capability)return state;
    return @{};
}
static uint64_t QueryMetric(CSClientGuardCapability capability,NSString *metric) {
    return [QueryState(capability)[metric] unsignedLongLongValue];
}
static uint64_t QueryOutcome(CSClientGuardCapability capability,CSClientGuardCallOutcome outcome) {
    return [QueryState(capability)[@"outcomes"][@(outcome)] unsignedLongLongValue];
}

@interface JiDeThrowingDictionary : NSDictionary
@end
@implementation JiDeThrowingDictionary
- (NSUInteger)count { return 0; }
- (NSEnumerator *)keyEnumerator { return [@[] objectEnumerator]; }
- (id)objectForKey:(__unused id)key { return nil; }
- (id)mutableCopyWithZone:(__unused NSZone *)zone { [NSException raise:@"FixtureCopy" format:@"copy failed"]; return nil; }
@end

@interface JiDeNilCopyDictionary : JiDeThrowingDictionary
@end
@implementation JiDeNilCopyDictionary
- (id)mutableCopyWithZone:(__unused NSZone *)zone { return nil; }
@end

// A custom implementation may violate mutableCopy's ownership convention and
// alias the original. The production filter must reject that alias before any
// dictionary mutation, including removal of a fingerprint field.
@interface JiDeSelfCopyDictionary : NSMutableDictionary
@property(nonatomic, strong) NSMutableDictionary *contents;
@end
@implementation JiDeSelfCopyDictionary
- (instancetype)init {
    if ((self = [super init])) _contents = [@{@"provisioning_type":@2, @"cert_valid":@NO,
        @"env_abnormal":@YES, @"jb_indicator":@1, @"keep":@"value"} mutableCopy];
    return self;
}
- (NSUInteger)count { return self.contents.count; }
- (NSEnumerator *)keyEnumerator { return self.contents.keyEnumerator; }
- (id)objectForKey:(id)key { return self.contents[key]; }
- (void)setObject:(id)object forKey:(id<NSCopying>)key { [self.contents setObject:object forKey:key]; }
- (void)removeObjectForKey:(id)key { [self.contents removeObjectForKey:key]; }
- (id)mutableCopyWithZone:(__unused NSZone *)zone { return self; }
@end

static void Configure(NSUserDefaults *defaults, NSArray<NSString *> *identifiers) {
    [defaults setBool:YES forKey:CSClientGuardEnabledKey];
    [defaults setBool:YES forKey:CSClientGuardScopedKey];
    for (NSDictionary *row in CSClientGuardOptions())
        [defaults setBool:[identifiers containsObject:row[@"identifier"]] forKey:CSClientGuardPreferenceKey(row[@"identifier"])];
    CSClientGuardRefresh();
}

static void CheckFriendCall(id object, id request, id contact, id message, BOOL expectedScope) {
    FriendProbe = ^(__unused NSString *name) {
        CHECK(CSClientGuardShouldApply(CSClientGuardEnvironment, YES) == expectedScope);
        CHECK((NSProcessInfo.processInfo.environment[@"DYLD_INSERT_LIBRARIES"] == nil) == expectedScope);
    };
    NSUInteger sends = SendCalls, starts = StartCalls;
    CHECK(CallSend(object, request) == ExpectedResult(SendResult));
    CHECK(SendCalls == sends + 1 && LastReceiver == object && LastRequest == request);
    CHECK(CallStart(object, contact, FixtureOpcode(), message) == ExpectedResult(StartResult));
    CHECK(StartCalls == starts + 1 && LastReceiver == object && LastContact == contact && LastMessage == message);
    CHECK(LastOpcode == FixtureOpcode());
    FriendProbe = nil;
}

int main(int argc, const char **argv) { @autoreleasepool {
    for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "--char") == 0) CharMode = YES;
        else if (strncmp(argv[i], "--opcode=", 9) == 0) OpcodeKind = argv[i][9];
    }
    CHECK(OpcodeKind == 'i' || OpcodeKind == 'I' || OpcodeKind == 'q' || OpcodeKind == 'Q');
    Class friendClass = RegisterFixture(@"NormalContactVerifyLogic");
    AddFriendFixtureMethods(friendClass);
    Class deviceClass = RegisterFixture(@"MMDeviceInfoManager");
    CHECK(class_addMethod(deviceClass, NSSelectorFromString(@"deviceEnvironmentReport"), (IMP)FixtureDevice, "@@:"));
    Class fingerprintBase = RegisterFixture(@"JiDeFingerprintInvalidBase");
    CHECK(class_addMethod(fingerprintBase, NSSelectorFromString(@"generateFingerprint"), (IMP)WrongFingerprint, "d@:"));
    Class fingerprintClass = RegisterFixtureSubclass(@"MMFPManager", fingerprintBase);
    Class experimentClass = RegisterFixture(@"ExptService");
    CHECK(class_addMethod(experimentClass, NSSelectorFromString(@"getStringExpt:"), (IMP)FixtureExperiment, "@@:@"));
    Method environment = class_getInstanceMethod(object_getClass(NSProcessInfo.processInfo), @selector(environment));
    CHECK(environment != NULL);
    EnvironmentSource = [@{@"DYLD_INSERT_LIBRARIES":@"fixture-only.dylib", @"keep":@"value"} mutableCopy];
    method_setImplementation(environment, (IMP)FixtureEnvironment);
    id friend = [friendClass new], device = [deviceClass new], fingerprint = [fingerprintClass new], experiment = [experimentClass new];
    id request = [NSObject new], contact = [NSObject new], message = [NSObject new];
    NSString *suite = [@"com.wechatimprove.jide-query-tests." stringByAppendingString:NSUUID.UUID.UUIDString];
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:suite];
    NSURL *root = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:suite] isDirectory:YES];
    CHECK([NSFileManager.defaultManager createDirectoryAtURL:root withIntermediateDirectories:YES attributes:nil error:NULL]);
    CSClientGuardUseTestDefaults(defaults, [root URLByAppendingPathComponent:@"Host.app"].path, root);
    @try {
        for (NSDictionary *row in CSClientGuardOptions()) CHECK(!CSClientGuardSetting(CSClientGuardPreferenceKey(row[@"identifier"])));
        CSClientGuardStart();
        CHECK(HookCount == 0);
        CheckFriendCall(friend, request, contact, message, NO);

        // Enabling the scope capability does not imply any other capability.
        Configure(defaults, @[@"friend_scope"]);
        CHECK(QueryMetric(CSClientGuardFriendScope,@"observed")==0);
        CheckFriendCall(friend, request, contact, message, NO);
        CHECK(QueryMetric(CSClientGuardFriendScope,@"observed")==2 && QueryMetric(CSClientGuardFriendScope,@"applied")==2);
        Configure(defaults, @[@"friend_scope", @"environment"]);
        NSUInteger installed = HookCount;
        CSClientGuardRefresh(); CHECK(HookCount == installed);
        CHECK(NSProcessInfo.processInfo.environment == EnvironmentSource);
        CheckFriendCall(friend, request, contact, message, YES);
        CHECK(NSProcessInfo.processInfo.environment == EnvironmentSource);

        // Preserve both false and nonzero c results; never normalize a c result.
        SendResult = 0; StartResult = 0;
        CheckFriendCall(friend, request, contact, message, YES);
        SendResult = -73; StartResult = -42;
        __block BOOL nested = NO;
        FriendProbe = ^(NSString *name) {
            CHECK(CSClientGuardShouldApply(CSClientGuardEnvironment, YES));
            if ([name isEqualToString:@"send"] && !nested) {
                nested = YES;
                CHECK(CallStart(friend, contact, FixtureOpcode(), message) == ExpectedResult(StartResult));
                CHECK(CSClientGuardShouldApply(CSClientGuardEnvironment, YES));
            }
        };
        CHECK(CallSend(friend, request) == ExpectedResult(SendResult)); CHECK(nested);
        CHECK(!CSClientGuardShouldApply(CSClientGuardEnvironment, YES));
        FriendProbe = ^(__unused NSString *name) { [NSException raise:@"FriendFixture" format:@"unwind"]; };
        @try { (void)CallSend(friend, request); CHECK(NO); }
        @catch (NSException *exception) { CHECK([exception.name isEqualToString:@"FriendFixture"]); }
        CHECK(!CSClientGuardShouldApply(CSClientGuardEnvironment, YES));
        CSClientGuardWithCheckScope(^{
            @try { (void)CallStart(friend, contact, FixtureOpcode(), message); CHECK(NO); }
            @catch (NSException *exception) { CHECK([exception.name isEqualToString:@"FriendFixture"]); }
            CHECK(CSClientGuardShouldApply(CSClientGuardEnvironment, YES));
        });
        CHECK(!CSClientGuardShouldApply(CSClientGuardEnvironment, YES));
        CHECK(QueryOutcome(CSClientGuardFriendScope,CSClientGuardCallOriginalException)==2);

        dispatch_semaphore_t observed = dispatch_semaphore_create(0);
        __block BOOL asynchronousPassthrough = NO;
        FriendProbe = ^(__unused NSString *name) {
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
                asynchronousPassthrough = !CSClientGuardShouldApply(CSClientGuardEnvironment, YES) &&
                    NSProcessInfo.processInfo.environment == EnvironmentSource;
                dispatch_semaphore_signal(observed);
            });
            CHECK(dispatch_semaphore_wait(observed, dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC)) == 0);
        };
        CHECK(CallSend(friend, request) == ExpectedResult(SendResult)); CHECK(asynchronousPassthrough);
        FriendProbe = nil;
        CSClientGuardWithoutOverrides(^{ CheckFriendCall(friend, request, contact, message, NO); });
        Configure(defaults, @[@"environment"]);
        CheckFriendCall(friend, request, contact, message, NO);

        // A mismatched object-result ABI remains untouched and is diagnosed.
        Method fpMethod = class_getInstanceMethod(fingerprintClass, NSSelectorFromString(@"generateFingerprint"));
        IMP invalid = method_getImplementation(fpMethod);
        Configure(defaults, @[@"fingerprint_data"]);
        CHECK(method_getImplementation(fpMethod) == invalid);
        CHECK(((double (*)(id, SEL))objc_msgSend)(fingerprint, NSSelectorFromString(@"generateFingerprint")) == 9.25);
        CHECK([CSClientGuardStatuses()[@"-[MMFPManager generateFingerprint]"] containsString:@"签名不兼容"]);
        class_replaceMethod(fingerprintClass, NSSelectorFromString(@"generateFingerprint"), (IMP)FixtureFingerprint, "@@:");
        Configure(defaults, @[@"device_report", @"fingerprint_data", @"experiment_reports"]);

        NSMutableDictionary *deviceOriginal = [@{@"provisioning_type":@2, @"cert_valid":@NO, @"env_abnormal":@YES,
            @"keep":@"value", @"jb_indicator":@1} mutableCopy];
        DeviceSource = deviceOriginal;
        NSUInteger deviceBefore = DeviceCalls;
        NSDictionary *deviceFiltered = CallObject(device, @"deviceEnvironmentReport");
        CHECK(DeviceCalls == deviceBefore + 1 && deviceFiltered != deviceOriginal);
        CHECK([deviceFiltered isEqual:@{@"keep":@"value", @"jb_indicator":@1}]);
        CHECK([deviceFiltered isKindOfClass:NSMutableDictionary.class] && deviceOriginal.count == 5);
        [(NSMutableDictionary *)deviceFiltered setObject:@"caller-field" forKey:@"consumer"];
        CHECK([deviceFiltered[@"consumer"] isEqual:@"caller-field"] && deviceOriginal[@"consumer"] == nil);
        [deviceOriginal setObject:@"changed" forKey:@"keep"];
        CHECK([deviceFiltered[@"keep"] isEqualToString:@"value"]);
        NSMutableDictionary *fingerprintOriginal = [@{@"jb_indicator":@1, @"keep":@"value", @"cert_valid":@NO} mutableCopy];
        FingerprintSource = fingerprintOriginal;
        NSUInteger fpBefore = FingerprintCalls;
        NSDictionary *fingerprintFiltered = CallObject(fingerprint, @"generateFingerprint");
        CHECK(FingerprintCalls == fpBefore + 1 && fingerprintFiltered != fingerprintOriginal);
        CHECK([fingerprintFiltered isEqual:@{@"keep":@"value", @"cert_valid":@NO}]);
        CHECK([fingerprintFiltered isKindOfClass:NSMutableDictionary.class] && fingerprintOriginal.count == 3);
        [(NSMutableDictionary *)fingerprintFiltered setObject:@"caller-field" forKey:@"consumer"];
        CHECK([fingerprintFiltered[@"consumer"] isEqual:@"caller-field"] && fingerprintOriginal[@"consumer"] == nil);
        NSDictionary *immutableDevice = @{@"provisioning_type":@2, @"cert_valid":@NO, @"env_abnormal":@YES, @"keep":@"value"};
        NSDictionary *immutableFingerprint = @{@"jb_indicator":@1, @"keep":@"value"};
        DeviceSource = immutableDevice; FingerprintSource = immutableFingerprint;
        NSDictionary *immutableDeviceResult = CallObject(device, @"deviceEnvironmentReport");
        NSDictionary *immutableFingerprintResult = CallObject(fingerprint, @"generateFingerprint");
        CHECK(immutableDeviceResult != immutableDevice && ![immutableDeviceResult isKindOfClass:NSMutableDictionary.class] &&
            [immutableDeviceResult isEqual:@{@"keep":@"value"}] && immutableDevice.count == 4);
        CHECK(immutableFingerprintResult != immutableFingerprint && ![immutableFingerprintResult isKindOfClass:NSMutableDictionary.class] &&
            [immutableFingerprintResult isEqual:@{@"keep":@"value"}] && immutableFingerprint.count == 2);
        JiDeSelfCopyDictionary *aliasedSource = [JiDeSelfCopyDictionary new];
        NSDictionary *beforeAliasFiltering = [aliasedSource.contents copy];
        DeviceSource = aliasedSource; FingerprintSource = aliasedSource;
        CHECK(CallObject(device, @"deviceEnvironmentReport") == aliasedSource);
        CHECK([aliasedSource.contents isEqualToDictionary:beforeAliasFiltering]);
        CHECK(CallObject(fingerprint, @"generateFingerprint") == aliasedSource);
        CHECK([aliasedSource.contents isEqualToDictionary:beforeAliasFiltering]);
        for (id unexpected in @[@"unexpected", @7, [JiDeThrowingDictionary new], [JiDeNilCopyDictionary new]]) {
            DeviceSource = unexpected; FingerprintSource = unexpected;
            CHECK(CallObject(device, @"deviceEnvironmentReport") == unexpected);
            CHECK(CallObject(fingerprint, @"generateFingerprint") == unexpected);
        }
        DeviceSource = nil; FingerprintSource = nil;
        CHECK(CallObject(device, @"deviceEnvironmentReport") == nil);
        CHECK(CallObject(fingerprint, @"generateFingerprint") == nil);
        DeviceSource = deviceOriginal; FingerprintSource = fingerprintOriginal;
        uint64_t deviceObserved=QueryMetric(CSClientGuardDeviceReport,@"observed");
        ThrowDeviceResult=YES;
        @try { (void)CallObject(device,@"deviceEnvironmentReport"); CHECK(NO); }
        @catch(NSException *exception) { CHECK([exception.name isEqual:@"DeviceOriginalFixture"]); }
        @finally { ThrowDeviceResult=NO; }
        CHECK(QueryMetric(CSClientGuardDeviceReport,@"observed")==deviceObserved+1 &&
            QueryOutcome(CSClientGuardDeviceReport,CSClientGuardCallOriginalException)==1);
        CHECK(QueryOutcome(CSClientGuardDeviceReport,CSClientGuardCallUnexpectedValue)==6 &&
            QueryOutcome(CSClientGuardFingerprintData,CSClientGuardCallUnexpectedValue)==6);
        CSClientGuardWithoutOverrides(^{
            CHECK(CallObject(device, @"deviceEnvironmentReport") == deviceOriginal);
            CHECK(CallObject(fingerprint, @"generateFingerprint") == fingerprintOriginal);
        });

        NSArray *keys = @[@"clicfg_gogwcs_ios_runtime_sdk_dc_dc_report_enable",
            @"clicfg_gogwcs_ios_runtime_sdk_main_cert_chain_report"];
        NSUInteger exptBefore = ExperimentCalls;
        for (NSString *key in keys) CHECK([CallExperiment(experiment, key) isEqualToString:@"0"]);
        CHECK(ExperimentCalls == exptBefore);
        uint64_t exptObserved=QueryMetric(CSClientGuardExperimentReports,@"observed");
        CHECK(exptObserved==2 && QueryMetric(CSClientGuardExperimentReports,@"applied")==2);
        for (id key in @[@"other", [keys[0] stringByAppendingString:@"_suffix"], @7]) {
            CHECK([CallExperiment(experiment, key) isEqualToString:@"predecessor"]);
            CHECK(LastExperimentKey == key);
        }
        CHECK([CallExperiment(experiment, nil) isEqualToString:@"predecessor"] && LastExperimentKey == nil);
        CHECK(QueryMetric(CSClientGuardExperimentReports,@"observed")==exptObserved);
        CSClientGuardWithoutOverrides(^{
            CHECK([CallExperiment(experiment, keys[0]) isEqualToString:@"predecessor"]);
            CHECK(LastExperimentKey == keys[0]);
        });
        Configure(defaults, @[]);
        CHECK(CallObject(device, @"deviceEnvironmentReport") == deviceOriginal);
        CHECK(CallObject(fingerprint, @"generateFingerprint") == fingerprintOriginal);
        CHECK([CallExperiment(experiment, keys[0]) isEqualToString:@"predecessor"]);
        Configure(defaults, @[@"friend_scope", @"environment", @"device_report", @"fingerprint_data", @"experiment_reports"]);
        CSClientGuardSetSetting(CSClientGuardEnabledKey, NO);
        CheckFriendCall(friend, request, contact, message, NO);
        CHECK(CallObject(device, @"deviceEnvironmentReport") == deviceOriginal);
        CHECK(CallObject(fingerprint, @"generateFingerprint") == fingerprintOriginal);
        CHECK([CallExperiment(experiment, keys[1]) isEqualToString:@"predecessor"]);
        CHECK(QueryOutcome(CSClientGuardExperimentReports,CSClientGuardCallBypassed)==1);
        CHECK(QueryOutcome(CSClientGuardExperimentReports,CSClientGuardCallDisabled)==2);
        for(NSNumber *capability in @[@(CSClientGuardFriendScope),@(CSClientGuardDeviceReport),@(CSClientGuardFingerprintData),@(CSClientGuardExperimentReports)]) {
            NSDictionary *state=QueryState([capability unsignedLongLongValue]);
            CHECK([state[@"observed"] unsignedLongLongValue]>0 && [state[@"applied"] unsignedLongLongValue]>0);
            CHECK([state[@"observed"] unsignedLongLongValue]==[state[@"applied"] unsignedLongLongValue]+[state[@"fallback"] unsignedLongLongValue]);
        }
    } @finally {
        FriendProbe = nil;
        CSClientGuardSetSetting(CSClientGuardEnabledKey, NO);
        CSClientGuardRefresh();
        [defaults removePersistentDomainForName:suite];
        [NSFileManager.defaultManager removeItemAtURL:root error:NULL];
    }
    printf("JiDe queries (%s, opcode %c): %lu assertions passed\n", CharMode ? "c" : "B", OpcodeKind, (unsigned long)Assertions);
    return 0;
} }
