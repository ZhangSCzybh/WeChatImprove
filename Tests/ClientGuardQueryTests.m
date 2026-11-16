#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>
#import <objc/runtime.h>
#import "CSClientGuard.h"
#include <limits.h>

static NSUInteger QueryAssertions;
#define QUERY_CHECK(...) do { QueryAssertions++; if (!(__VA_ARGS__)) { \
    fprintf(stderr, "ClientGuardQueryTests FAIL %d: %s\n", __LINE__, #__VA_ARGS__); exit(1); \
} } while (0)

// Only environment needs a deterministic predecessor. The remaining Foundation
// cases use real APIs and files under one uniquely named temporary directory.
static id QueryEnvironmentSource;
static BOOL QueryEnvironmentThrows;
static id QueryFixtureEnvironment(__unused id object, __unused SEL selector) {
    if(QueryEnvironmentThrows)[NSException raise:@"EnvironmentOriginalFixture" format:@"propagate"];
    return QueryEnvironmentSource;
}
static void (^QueryCheckProbe)(NSString *name, unsigned int sequence);

typedef NS_ENUM(NSUInteger, QueryCopyBehavior) {
    QueryCopyNormal, QueryCopyNil, QueryCopyWrongType, QueryCopySelf, QueryCopyThrow
};
@interface QueryDictionaryFixture : NSMutableDictionary
@property(nonatomic, strong) NSMutableDictionary *contents;
@property(nonatomic) QueryCopyBehavior mutableCopyBehavior;
@property(nonatomic) QueryCopyBehavior copyBehavior;
@end
@implementation QueryDictionaryFixture
- (instancetype)init {
    if ((self=[super init])) _contents=[@{@"DYLD_INSERT_LIBRARIES":@"fixture-only.dylib",@"GUARD_KEEP":@"kept"} mutableCopy];
    return self;
}
- (NSUInteger)count { return self.contents.count; }
- (NSEnumerator *)keyEnumerator { return self.contents.keyEnumerator; }
- (id)objectForKey:(id)key { return self.contents[key]; }
- (void)setObject:(id)object forKey:(id<NSCopying>)key { [self.contents setObject:object forKey:key]; }
- (void)removeObjectForKey:(id)key { [self.contents removeObjectForKey:key]; }
- (id)mutableCopyWithZone:(__unused NSZone *)zone {
    switch(self.mutableCopyBehavior) {
        case QueryCopyNil:return nil;
        case QueryCopyWrongType:return @"not-a-dictionary";
        case QueryCopySelf:return self;
        case QueryCopyThrow:[NSException raise:@"QueryCopyFixture" format:@"mutableCopy failed"];return nil;
        case QueryCopyNormal:break;
    }
    if(self.copyBehavior!=QueryCopyNormal) {
        QueryDictionaryFixture *result=[QueryDictionaryFixture new];
        result.contents=[self.contents mutableCopy];result.copyBehavior=self.copyBehavior;
        return result;
    }
    return [self.contents mutableCopy];
}
- (id)copyWithZone:(__unused NSZone *)zone {
    switch(self.copyBehavior) {
        case QueryCopyNil:return nil;
        case QueryCopyWrongType:return @"not-a-dictionary";
        case QueryCopySelf:return self;
        case QueryCopyThrow:[NSException raise:@"QueryCopyFixture" format:@"copy failed"];return nil;
        case QueryCopyNormal:return [self.contents copy];
    }
}
@end

@interface ClientCheckMgr : NSObject
@property(nonatomic, strong) id fixtureImages;
@property(nonatomic, strong) NSMutableDictionary<NSString *, NSNumber *> *fixtureCalls;
- (void)checkHook:(id)argument;
- (void)checkConsistency:(id)argument;
- (void)checkHookWithSeq:(unsigned int)sequence;
- (void)registerAddImageCallBack;
- (id)getImageList;
@end
@implementation ClientCheckMgr
- (instancetype)init { if ((self = [super init])) _fixtureCalls = [NSMutableDictionary dictionary]; return self; }
- (void)record:(NSString *)name sequence:(unsigned int)sequence {
    self.fixtureCalls[name] = @([self.fixtureCalls[name] unsignedIntegerValue] + 1);
    if (QueryCheckProbe) QueryCheckProbe(name, sequence);
}
- (void)checkHook:(__unused id)argument { [self record:@"checkHook:" sequence:0]; }
- (void)checkConsistency:(__unused id)argument { [self record:@"checkConsistency:" sequence:0]; }
- (void)checkHookWithSeq:(unsigned int)sequence { [self record:@"checkHookWithSeq:" sequence:sequence]; }
- (void)registerAddImageCallBack { [self record:@"registerAddImageCallBack" sequence:0]; }
- (id)getImageList { return self.fixtureImages; }
@end

static void QueryEnable(NSArray<NSString *> *identifiers) {
    CSClientGuardSetSetting(CSClientGuardEnabledKey, YES);
    CSClientGuardSetSetting(CSClientGuardScopedKey, YES);
    for (NSDictionary *row in CSClientGuardOptions())
        CSClientGuardSetSetting(CSClientGuardPreferenceKey(row[@"identifier"]), [identifiers containsObject:row[@"identifier"]]);
    CSClientGuardRefresh();
}
static BOOL QueryEqualNullable(id left, id right) { return left == right || [left isEqual:right]; }
static NSDictionary *LegacyQueryState(CSClientGuardCapability capability) {
    for(NSDictionary *state in CSClientGuardCapabilityStates())
        if([state[@"capability"] unsignedLongLongValue]==capability)return state;
    return @{};
}
static uint64_t LegacyQueryMetric(CSClientGuardCapability capability,NSString *metric) {
    return [LegacyQueryState(capability)[metric] unsignedLongLongValue];
}
static uint64_t LegacyQueryOutcome(CSClientGuardCapability capability,CSClientGuardCallOutcome outcome) {
    return [LegacyQueryState(capability)[@"outcomes"][@(outcome)] unsignedLongLongValue];
}
static NSBundle *QueryCreateBundle(NSString *root, NSString *name) {
    NSString *path = [root stringByAppendingPathComponent:[name stringByAppendingPathExtension:@"app"]];
    QUERY_CHECK([NSFileManager.defaultManager createDirectoryAtPath:[path stringByAppendingPathComponent:@"Frameworks"]
        withIntermediateDirectories:YES attributes:nil error:NULL]);
    NSDictionary *info = @{@"CFBundleIdentifier":[@"client.guard.fixture." stringByAppendingString:name],
        @"CFBundleName":name, @"CFBundleExecutable":name, @"CFBundlePackageType":@"APPL", @"view":@"original"};
    QUERY_CHECK([info writeToFile:[path stringByAppendingPathComponent:@"Info.plist"] atomically:YES]);
    QUERY_CHECK([@"fixture-only-profile" writeToFile:[path stringByAppendingPathComponent:@"embedded.mobileprovision"]
        atomically:YES encoding:NSUTF8StringEncoding error:NULL]);
    QUERY_CHECK([[NSData dataWithBytes:"fixture" length:7] writeToFile:
        [[path stringByAppendingPathComponent:@"Frameworks"] stringByAppendingPathComponent:@"fixture.dylib"] atomically:YES]);
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    QUERY_CHECK(bundle != nil && [bundle.bundlePath isEqual:path]);
    return bundle;
}

void CSClientGuardRunQueryTests(void) {
    QUERY_CHECK(NSThread.isMainThread);
    NSString *suite = [@"com.wechatimprove.client-guard.query-tests." stringByAppendingString:NSUUID.UUID.UUIDString];
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:suite];
    NSString *root = [NSTemporaryDirectory() stringByAppendingPathComponent:[@"client-guard-queries-" stringByAppendingString:NSUUID.UUID.UUIDString]];
    NSBundle *host = QueryCreateBundle(root, @"Host"), *other = QueryCreateBundle(root, @"Other");
    NSString *hostPath = host.bundlePath, *otherPath = other.bundlePath;
    NSURL *library = [NSURL fileURLWithPath:[root stringByAppendingPathComponent:@"Library"] isDirectory:YES];
    QUERY_CHECK([NSFileManager.defaultManager createDirectoryAtURL:library withIntermediateDirectories:YES attributes:nil error:NULL]);
    CSClientGuardUseTestDefaults(defaults, hostPath, library);
    CSClientGuardRefresh();
    QUERY_CHECK(!CSClientGuardShouldApply(CSClientGuardEnvironment, NO));

    Method environment = class_getInstanceMethod(object_getClass(NSProcessInfo.processInfo), @selector(environment));
    QUERY_CHECK(environment != NULL);
    QueryEnvironmentSource = [@{@"DYLD_INSERT_LIBRARIES":@"fixture-only.dylib", @"GUARD_KEEP":@"kept"} mutableCopy];
    method_setImplementation(environment, (IMP)QueryFixtureEnvironment);
    ClientCheckMgr *checks = [ClientCheckMgr new];
    @try {
        // A vendor-only configuration must still wrap check entry points so its
        // default scoped policy is reachable without another query capability.
        QueryEnable(@[@"vendor_id"]);
        QUERY_CHECK(!CSClientGuardShouldApply(CSClientGuardVendorID, YES));
        __block BOOL vendorScope = NO;
        QueryCheckProbe = ^(__unused NSString *name, unsigned int sequence) {
            QUERY_CHECK(sequence == UINT_MAX);
            vendorScope = CSClientGuardShouldApply(CSClientGuardVendorID, YES);
        };
        [checks checkHookWithSeq:UINT_MAX];
        QUERY_CHECK(vendorScope);
        QueryCheckProbe = nil;

        NSArray *queries = @[@"environment", @"frameworks", @"provision_path", @"provision_read", @"bundle_info", @"receipt", @"images"];
        QueryEnable(queries);
        IMP installedEnvironment = method_getImplementation(environment);
        CSClientGuardRefresh();
        QUERY_CHECK(method_getImplementation(environment) == installedEnvironment);
        QUERY_CHECK(NSProcessInfo.processInfo.environment == QueryEnvironmentSource);

        CSClientGuardWithCheckScope(^{
            NSDictionary *filtered = NSProcessInfo.processInfo.environment;
            QUERY_CHECK(filtered != QueryEnvironmentSource && filtered[@"DYLD_INSERT_LIBRARIES"] == nil);
            QUERY_CHECK([filtered[@"GUARD_KEEP"] isEqual:@"kept"]);
            QUERY_CHECK([QueryEnvironmentSource[@"DYLD_INSERT_LIBRARIES"] isEqual:@"fixture-only.dylib"]);
            CSClientGuardWithCheckScope(^{ QUERY_CHECK(NSProcessInfo.processInfo.environment[@"DYLD_INSERT_LIBRARIES"] == nil); });
            QUERY_CHECK(NSProcessInfo.processInfo.environment[@"DYLD_INSERT_LIBRARIES"] == nil);
            CSClientGuardWithoutOverrides(^{
                QUERY_CHECK(NSProcessInfo.processInfo.environment == QueryEnvironmentSource);
                CSClientGuardWithCheckScope(^{ QUERY_CHECK(NSProcessInfo.processInfo.environment == QueryEnvironmentSource); });
            });
            QUERY_CHECK(NSProcessInfo.processInfo.environment[@"DYLD_INSERT_LIBRARIES"] == nil);
        });
        QUERY_CHECK(NSProcessInfo.processInfo.environment == QueryEnvironmentSource);
        id ordinaryEnvironment=QueryEnvironmentSource;
        uint64_t badEnvironmentBefore=LegacyQueryOutcome(CSClientGuardEnvironment,CSClientGuardCallUnexpectedValue);
        CSClientGuardWithCheckScope(^{
            QueryEnvironmentSource=nil;
            QUERY_CHECK(NSProcessInfo.processInfo.environment==nil);
            QueryEnvironmentSource=@"unexpected";
            QUERY_CHECK((id)NSProcessInfo.processInfo.environment==QueryEnvironmentSource);
            for(NSUInteger mode=QueryCopyNil;mode<=QueryCopyThrow;mode++) {
                QueryDictionaryFixture *fixture=[QueryDictionaryFixture new];
                fixture.mutableCopyBehavior=(QueryCopyBehavior)mode;
                NSDictionary *before=[fixture.contents copy];
                QueryEnvironmentSource=fixture;
                QUERY_CHECK(NSProcessInfo.processInfo.environment==fixture);
                QUERY_CHECK([fixture.contents isEqual:before]);
            }
            for(NSUInteger mode=QueryCopyNil;mode<=QueryCopyThrow;mode++) {
                QueryDictionaryFixture *fixture=[QueryDictionaryFixture new];
                fixture.copyBehavior=(QueryCopyBehavior)mode;
                NSDictionary *before=[fixture.contents copy];
                QueryEnvironmentSource=fixture;
                QUERY_CHECK(NSProcessInfo.processInfo.environment==fixture);
                QUERY_CHECK([fixture.contents isEqual:before]);
            }
        });
        QueryEnvironmentSource=ordinaryEnvironment;
        QUERY_CHECK(LegacyQueryOutcome(CSClientGuardEnvironment,CSClientGuardCallUnexpectedValue)==badEnvironmentBefore+10);
        CSClientGuardWithCheckScope(^{
            QueryEnvironmentThrows=YES;
            @try { (void)NSProcessInfo.processInfo.environment; QUERY_CHECK(NO); }
            @catch(NSException *exception) { QUERY_CHECK([exception.name isEqual:@"EnvironmentOriginalFixture"]); }
            @finally { QueryEnvironmentThrows=NO; }
        });
        QUERY_CHECK(LegacyQueryOutcome(CSClientGuardEnvironment,CSClientGuardCallOriginalException)==1);
        @try {
            CSClientGuardWithCheckScope(^{ [NSException raise:@"QueryScopeFixture" format:@"unwind"]; });
        } @catch (NSException *exception) { QUERY_CHECK([exception.name isEqual:@"QueryScopeFixture"]); }
        QUERY_CHECK(NSProcessInfo.processInfo.environment == QueryEnvironmentSource);
        CSClientGuardWithCheckScope(^{
            @try {
                CSClientGuardWithoutOverrides(^{ [NSException raise:@"QueryBypassFixture" format:@"unwind"]; });
            } @catch (NSException *exception) { QUERY_CHECK([exception.name isEqual:@"QueryBypassFixture"]); }
            QUERY_CHECK(NSProcessInfo.processInfo.environment[@"DYLD_INSERT_LIBRARIES"] == nil);
        });
        // Async work starts with its own TLS state. A semaphore keeps only this
        // isolated fixture scope alive until the worker observation is finished.
        dispatch_semaphore_t observed = dispatch_semaphore_create(0);
        __block BOOL asynchronousPassthrough = NO;
        CSClientGuardWithCheckScope(^{
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
                asynchronousPassthrough = NSProcessInfo.processInfo.environment == QueryEnvironmentSource;
                dispatch_semaphore_signal(observed);
            });
            QUERY_CHECK(dispatch_semaphore_wait(observed, dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC)) == 0);
        });
        QUERY_CHECK(asynchronousPassthrough);

        NSString *frameworks = [hostPath stringByAppendingPathComponent:@"Frameworks"];
        NSString *otherFrameworks = [otherPath stringByAppendingPathComponent:@"Frameworks"];
        NSArray *originalFiles = [NSFileManager.defaultManager contentsOfDirectoryAtPath:frameworks error:NULL];
        QUERY_CHECK(originalFiles.count == 1);
        CSClientGuardWithCheckScope(^{
            NSError *error = [NSError errorWithDomain:@"fixture" code:1 userInfo:nil];
            QUERY_CHECK([[NSFileManager.defaultManager contentsOfDirectoryAtPath:frameworks error:&error] count] == 0);
            QUERY_CHECK(error == nil);
            QUERY_CHECK([[NSFileManager.defaultManager contentsOfDirectoryAtPath:otherFrameworks error:NULL] count] == 1);
        });
        QUERY_CHECK([[NSFileManager.defaultManager contentsOfDirectoryAtPath:frameworks error:NULL] isEqual:originalFiles]);

        NSString *profile = [hostPath stringByAppendingPathComponent:@"embedded.mobileprovision"];
        NSString *otherProfile = [otherPath stringByAppendingPathComponent:@"embedded.mobileprovision"];
        QUERY_CHECK([[host pathForResource:@"embedded" ofType:@"mobileprovision"] isEqual:profile]);
        QUERY_CHECK([[NSString stringWithContentsOfFile:profile encoding:NSUTF8StringEncoding error:NULL] isEqual:@"fixture-only-profile"]);
        CSClientGuardWithCheckScope(^{
            QUERY_CHECK([host pathForResource:@"embedded" ofType:@"mobileprovision"] == nil);
            QUERY_CHECK([host pathForResource:@"embedded.mobileprovision" ofType:nil] == nil);
            QUERY_CHECK([[other pathForResource:@"embedded" ofType:@"mobileprovision"] isEqual:otherProfile]);
            NSError *error = nil;
            QUERY_CHECK([NSString stringWithContentsOfFile:profile encoding:NSUTF8StringEncoding error:&error] == nil);
            QUERY_CHECK([error.domain isEqual:NSCocoaErrorDomain] && error.code == NSFileReadNoSuchFileError);
            QUERY_CHECK([error.userInfo[NSFilePathErrorKey] isEqual:profile]);
            QUERY_CHECK([NSString stringWithContentsOfFile:profile encoding:NSUTF8StringEncoding error:NULL] == nil);
            QUERY_CHECK([[NSString stringWithContentsOfFile:otherProfile encoding:NSUTF8StringEncoding error:NULL] isEqual:@"fixture-only-profile"]);
            QUERY_CHECK([NSData dataWithContentsOfFile:profile].length > 0);
        });

        NSString *infoPath = [hostPath stringByAppendingPathComponent:@"Info.plist"];
        NSString *otherInfo = [otherPath stringByAppendingPathComponent:@"Info.plist"];
        NSString *siriPath = [hostPath stringByAppendingPathComponent:@"siri.plist"];
        NSString *originalResource = [host pathForResource:@"Info" ofType:@"plist"];
        QUERY_CHECK(CSClientGuardReplacementInfoPath() == nil);
        uint64_t missingResourceBefore=LegacyQueryOutcome(CSClientGuardBundleInfo,CSClientGuardCallResourceUnavailable);
        CSClientGuardWithCheckScope(^{
            QUERY_CHECK([[host pathForResource:@"Info" ofType:@"plist"] isEqual:originalResource]);
            QUERY_CHECK([[NSDictionary dictionaryWithContentsOfFile:infoPath][@"view"] isEqual:@"original"]);
        });
        QUERY_CHECK(LegacyQueryOutcome(CSClientGuardBundleInfo,CSClientGuardCallResourceUnavailable)==missingResourceBefore+2);
        QUERY_CHECK([@{@"view":@"replacement", @"CFBundleShortVersionString":@"fixture-only"} writeToFile:siriPath atomically:YES]);
        CSClientGuardRefresh();
        QUERY_CHECK([CSClientGuardReplacementInfoPath() isEqual:siriPath]);
        CSClientGuardWithCheckScope(^{
            QUERY_CHECK([[host pathForResource:@"Info" ofType:@"plist"] isEqual:siriPath]);
            QUERY_CHECK([[host pathForResource:@"Info.plist" ofType:nil] isEqual:siriPath]);
            NSDictionary *filtered = [NSDictionary dictionaryWithContentsOfFile:infoPath];
            QUERY_CHECK([filtered[@"view"] isEqual:@"replacement"]);
            QUERY_CHECK([[NSDictionary dictionaryWithContentsOfFile:otherInfo][@"view"] isEqual:@"original"]);
            QUERY_CHECK([[other pathForResource:@"Info" ofType:@"plist"] isEqual:otherInfo]);
            CSClientGuardWithoutOverrides(^{
                QUERY_CHECK([[host pathForResource:@"Info" ofType:@"plist"] isEqual:originalResource]);
                QUERY_CHECK([[NSDictionary dictionaryWithContentsOfFile:infoPath][@"view"] isEqual:@"original"]);
            });
        });
        QUERY_CHECK([[NSDictionary dictionaryWithContentsOfFile:infoPath][@"view"] isEqual:@"original"]);
        QUERY_CHECK([host.infoDictionary[@"view"] isEqual:@"original"]);
        QUERY_CHECK([@"not a property list" writeToFile:siriPath atomically:YES encoding:NSUTF8StringEncoding error:NULL]);
        CSClientGuardRefresh();
        QUERY_CHECK(CSClientGuardReplacementInfoPath() == nil);
        CSClientGuardWithCheckScope(^{ QUERY_CHECK([[host pathForResource:@"Info" ofType:@"plist"] isEqual:originalResource]); });

        NSURL *originalReceipt = host.appStoreReceiptURL, *otherReceipt = other.appStoreReceiptURL;
        NSURL *replacementReceipt = [library URLByAppendingPathComponent:@"StoreKit/receipt"];
        CSClientGuardWithCheckScope(^{
            QUERY_CHECK([host.appStoreReceiptURL isEqual:replacementReceipt]);
            QUERY_CHECK(QueryEqualNullable(other.appStoreReceiptURL, otherReceipt));
        });
        QUERY_CHECK(QueryEqualNullable(host.appStoreReceiptURL, originalReceipt));

        // These original check bodies run in a scope while Checks is off. The
        // sequence value catches accidental object/int/width ABI substitutions.
        __block NSUInteger originals = 0;
        QueryCheckProbe = ^(NSString *name, unsigned int sequence) {
            originals++;
            QUERY_CHECK(NSProcessInfo.processInfo.environment[@"DYLD_INSERT_LIBRARIES"] == nil);
            if ([name isEqual:@"checkHookWithSeq:"]) QUERY_CHECK(sequence == UINT_MAX);
        };
        [checks checkHook:@"argument"]; [checks checkConsistency:@"argument"];
        [checks checkHookWithSeq:UINT_MAX]; [checks registerAddImageCallBack];
        QUERY_CHECK(originals == 4);
        QueryEnable([queries arrayByAddingObject:@"checks"]);
        NSDictionary *beforeSkipping = [checks.fixtureCalls copy];
        [checks checkHook:@"argument"]; [checks checkConsistency:@"argument"];
        [checks checkHookWithSeq:UINT_MAX]; [checks registerAddImageCallBack];
        QUERY_CHECK(originals == 4 && [checks.fixtureCalls isEqual:beforeSkipping]);
        QueryCheckProbe = nil;

        NSMutableArray *images = [@[@"/fixture/DanceMonkey", @"/fixture/frida", @"/fixture/FridaGadget.dylib", @"/fixture/keep.dylib"] mutableCopy];
        checks.fixtureImages = images;
        id filteredImages = [checks getImageList];
        QUERY_CHECK(filteredImages != images && [filteredImages isEqual:@[@"/fixture/FridaGadget.dylib", @"/fixture/keep.dylib"]]);
        QUERY_CHECK(images.count == 4 && [images[0] isEqual:@"/fixture/DanceMonkey"]);
        NSArray *unexpected = @[@"/fixture/DanceMonkey", @7];
        checks.fixtureImages = unexpected; QUERY_CHECK([checks getImageList] == unexpected);
        checks.fixtureImages = @"unexpected"; QUERY_CHECK([checks getImageList] == checks.fixtureImages);
        checks.fixtureImages = nil; QUERY_CHECK([checks getImageList] == nil);

        // A master-off operation takes effect immediately, before the queued
        // refresh, and wrappers remain transparent without restoring IMPs.
        checks.fixtureImages = images;
        CSClientGuardSetSetting(CSClientGuardEnabledKey, NO);
        QUERY_CHECK([checks getImageList] == images);
        CSClientGuardWithCheckScope(^{ QUERY_CHECK(NSProcessInfo.processInfo.environment == QueryEnvironmentSource); });
        NSUInteger calls = [checks.fixtureCalls[@"checkHook:"] unsignedIntegerValue];
        [checks checkHook:nil];
        QUERY_CHECK([checks.fixtureCalls[@"checkHook:"] unsignedIntegerValue] == calls + 1);
        QUERY_CHECK(LegacyQueryOutcome(CSClientGuardImages,CSClientGuardCallDisabled)==1);
        QUERY_CHECK(LegacyQueryOutcome(CSClientGuardEnvironment,CSClientGuardCallOutOfScope)>0);
        QUERY_CHECK(LegacyQueryOutcome(CSClientGuardEnvironment,CSClientGuardCallBypassed)>0);
        QUERY_CHECK(LegacyQueryOutcome(CSClientGuardEnvironment,CSClientGuardCallDisabled)>0);
        uint64_t frameworkObserved=LegacyQueryMetric(CSClientGuardFrameworks,@"observed");
        CSClientGuardWithCheckScope(^{
            QUERY_CHECK([[NSFileManager.defaultManager contentsOfDirectoryAtPath:otherFrameworks error:NULL] count]==1);
        });
        QUERY_CHECK(LegacyQueryMetric(CSClientGuardFrameworks,@"observed")==frameworkObserved);
        for(NSNumber *capability in @[@(CSClientGuardEnvironment),@(CSClientGuardFrameworks),@(CSClientGuardProvisionPath),
            @(CSClientGuardProvisionRead),@(CSClientGuardBundleInfo),@(CSClientGuardReceipt),@(CSClientGuardChecks),@(CSClientGuardImages)]) {
            NSDictionary *state=LegacyQueryState([capability unsignedLongLongValue]);
            QUERY_CHECK([state[@"observed"] unsignedLongLongValue]>0 && [state[@"applied"] unsignedLongLongValue]>0);
            QUERY_CHECK([state[@"observed"] unsignedLongLongValue]==[state[@"applied"] unsignedLongLongValue]+[state[@"fallback"] unsignedLongLongValue]);
        }
    } @finally {
        QueryCheckProbe = nil;
        CSClientGuardSetSetting(CSClientGuardEnabledKey, NO);
        CSClientGuardRefresh();
        [defaults removePersistentDomainForName:suite];
        [NSFileManager.defaultManager removeItemAtPath:root error:NULL];
    }
    printf("Client guard queries: %lu assertions passed\n", (unsigned long)QueryAssertions);
}
