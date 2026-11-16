#import <Foundation/Foundation.h>
#import <objc/message.h>
#import "CSClientGuard.h"
#include <stdbool.h>

static NSUInteger Assertions,HookCount,BlockCalls,InstallCalls,MonitoringCalls,SafeCalls,VendorCalls;
static int LastMonitoring;
#define CHECK(c) do { Assertions++;if(!(c)){NSLog(@"ClientGuard FAIL %d: %s",__LINE__,#c);exit(1);} } while(0)
@interface CSGuardBlockFixture : NSObject
- (bool)start;
@end
@implementation CSGuardBlockFixture
- (bool)start {BlockCalls++;return false;}
@end
@interface CSGuardCrashFixture : NSObject
- (bool)install;
- (void)setMonitoring:(int)value;
@end
@implementation CSGuardCrashFixture
- (bool)install {InstallCalls++;return false;}
- (void)setMonitoring:(int)value {MonitoringCalls++;LastMonitoring=value;}
@end
@interface CSGuardSafeFixture : NSObject
- (bool)shouldEnterSafeMode;
@end
@implementation CSGuardSafeFixture
- (bool)shouldEnterSafeMode {SafeCalls++;return true;}
@end
@interface QIDevice : NSObject
- (id)identifierForVendor;
@end
@implementation QIDevice
- (id)identifierForVendor {VendorCalls++;return [[NSUUID alloc]initWithUUIDString:@"11111111-1111-1111-1111-111111111111"];}
@end
@interface CSGuardInvalidFixture : NSObject
- (double)unexpected;
@end
@implementation CSGuardInvalidFixture
- (double)unexpected {return 1.5;}
@end

void CSClientGuardTestHookMessage(Class cls,SEL selector,IMP replacement,IMP *original) {
    Method method=class_getInstanceMethod(cls,selector);
    *original=method_getImplementation(method);
    if(!class_addMethod(cls,selector,replacement,method_getTypeEncoding(method)))method_setImplementation(method,replacement);
    HookCount++;
}
static signed char CharStart(id object,SEL selector){(void)object;(void)selector;BlockCalls++;return 0;}
static signed char CharInstall(id object,SEL selector){(void)object;(void)selector;InstallCalls++;return 0;}
static signed char CharSafe(id object,SEL selector){(void)object;(void)selector;SafeCalls++;return 1;}
static void BoolMonitoring(id object,SEL selector,bool value){(void)object;(void)selector;MonitoringCalls++;LastMonitoring=value?1:0;}
static bool ClassOnlyEnvironmentCheck(id object,SEL selector){(void)object;(void)selector;return true;}
static double IncompatibleFingerprint(id object,SEL selector){(void)object;(void)selector;return 1.5;}
static BOOL BooleanCall(id object,SEL selector,BOOL charMode) {
    return charMode?((signed char(*)(id,SEL))objc_msgSend)(object,selector)!=0:((bool(*)(id,SEL))objc_msgSend)(object,selector);
}
static void SetMonitoring(id object,BOOL charMode,int value) {
    SEL selector=@selector(setMonitoring:);
    if(charMode)((void(*)(id,SEL,bool))objc_msgSend)(object,selector,value!=0);
    else ((void(*)(id,SEL,int))objc_msgSend)(object,selector,value);
}
static void Configure(NSUserDefaults *defaults,NSArray<NSString *> *identifiers,BOOL scoped) {
    [defaults setBool:YES forKey:CSClientGuardEnabledKey];[defaults setBool:scoped forKey:CSClientGuardScopedKey];
    for(NSDictionary *row in CSClientGuardOptions())[defaults setBool:[identifiers containsObject:row[@"identifier"]] forKey:CSClientGuardPreferenceKey(row[@"identifier"])];
    CSClientGuardRefresh();
}
extern void CSClientGuardRunQueryTests(void);
static NSDictionary *State(NSString *identifier) {
    for(NSDictionary *state in CSClientGuardCapabilityStates())if([state[@"identifier"] isEqual:identifier])return state;
    return nil;
}
static void DrainRefreshQueue(void) {
    __block BOOL done=NO;dispatch_async(dispatch_get_main_queue(),^{done=YES;});
    NSDate *deadline=[NSDate dateWithTimeIntervalSinceNow:2];
    while(!done && deadline.timeIntervalSinceNow>0)
        [NSRunLoop.currentRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
    CHECK(done);
}

int main(int argc,const char **argv) { @autoreleasepool {
    BOOL charMode=argc>1 && strcmp(argv[1],"--char")==0;
    // Existing method replacement preserves its original type encoding. Create
    // real host subclasses and add each selected ABI before registering them.
    Class blockHost=objc_allocateClassPair(CSGuardBlockFixture.class,"WCCrashBlockMonitorPlugin",0);
    Class crashHost=objc_allocateClassPair(CSGuardCrashFixture.class,"KSCrash",0);
    Class safeHost=objc_allocateClassPair(CSGuardSafeFixture.class,"MMSafeModeMgr",0);
    CHECK(blockHost && crashHost && safeHost);
    CHECK(class_addMethod(blockHost,@selector(start),charMode?(IMP)CharStart:
        method_getImplementation(class_getInstanceMethod(CSGuardBlockFixture.class,@selector(start))),charMode?"c@:":"B@:"));
    CHECK(class_addMethod(crashHost,@selector(install),charMode?(IMP)CharInstall:
        method_getImplementation(class_getInstanceMethod(CSGuardCrashFixture.class,@selector(install))),charMode?"c@:":"B@:"));
    CHECK(class_addMethod(safeHost,@selector(shouldEnterSafeMode),charMode?(IMP)CharSafe:
        method_getImplementation(class_getInstanceMethod(CSGuardSafeFixture.class,@selector(shouldEnterSafeMode))),charMode?"c@:":"B@:"));
    CHECK(class_addMethod(crashHost,@selector(setMonitoring:),charMode?(IMP)BoolMonitoring:
        method_getImplementation(class_getInstanceMethod(CSGuardCrashFixture.class,@selector(setMonitoring:))),charMode?"v@:B":"v@:i"));
    objc_registerClassPair(blockHost);objc_registerClassPair(crashHost);objc_registerClassPair(safeHost);
    CHECK(strcmp(method_getTypeEncoding(class_getInstanceMethod(blockHost,@selector(start))),charMode?"c@:":"B@:")==0);
    CHECK(strcmp(method_getTypeEncoding(class_getInstanceMethod(crashHost,@selector(install))),charMode?"c@:":"B@:")==0);
    CHECK(strcmp(method_getTypeEncoding(class_getInstanceMethod(safeHost,@selector(shouldEnterSafeMode))),charMode?"c@:":"B@:")==0);
    CHECK(strcmp(method_getTypeEncoding(class_getInstanceMethod(crashHost,@selector(setMonitoring:))),charMode?"v@:B":"v@:i")==0);
    NSString *suite=[@"ClientGuardTests." stringByAppendingString:NSUUID.UUID.UUIDString];
    NSUserDefaults *defaults=[[NSUserDefaults alloc]initWithSuiteName:suite];[defaults removePersistentDomainForName:suite];
    NSURL *root=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:suite] isDirectory:YES];
    CHECK([NSFileManager.defaultManager createDirectoryAtURL:root withIntermediateDirectories:YES attributes:nil error:NULL]);
    CSClientGuardUseTestDefaults(defaults,[root URLByAppendingPathComponent:@"Host.app"].path,root);
    CHECK(CSClientGuardSetting(CSClientGuardScopedKey));CHECK(!CSClientGuardSetting(CSClientGuardEnabledKey));
    CHECK(CSClientGuardOptions().count==28);
    for(NSDictionary *row in CSClientGuardOptions())CHECK(!CSClientGuardSetting(CSClientGuardPreferenceKey(row[@"identifier"])));
    CSClientGuardStart();CHECK(HookCount==0);
    CHECK([CSClientGuardDiagnosticSummary() containsString:@"配置总开关：关闭"]);
    CHECK([CSClientGuardDiagnosticSummary() containsString:@"实际干预策略：已停用"]);
    [defaults setBool:YES forKey:CSClientGuardEnabledKey];CSClientGuardRefresh();
    CHECK([CSClientGuardDiagnosticSummary() containsString:@"配置总开关：开启"]);
    CHECK([CSClientGuardDiagnosticSummary() containsString:@"实际干预策略：已发布 0 项能力"]);
    [defaults setBool:NO forKey:CSClientGuardEnabledKey];CSClientGuardRefresh();
    CSClientGuardSetSetting(@"not-a-guard-setting",YES);CHECK(![defaults objectForKey:@"not-a-guard-setting"]);
    [defaults setObject:@"YES" forKey:CSClientGuardEnabledKey];CSClientGuardRefresh();CHECK(HookCount==0);
    [defaults setObject:@2 forKey:CSClientGuardEnabledKey];CSClientGuardRefresh();CHECK(HookCount==0);
    [defaults setBool:NO forKey:CSClientGuardEnabledKey];
    [defaults setObject:@"invalid" forKey:CSClientGuardScopedKey];CHECK(CSClientGuardSetting(CSClientGuardScopedKey));
    [defaults setBool:YES forKey:CSClientGuardEnabledKey];
    [defaults setBool:YES forKey:CSClientGuardPreferenceKey(@"environment")];
    __block NSUInteger preparationCalls=0;
    CSClientGuardBeforeRefreshResourcesForTesting(^{
        preparationCalls++;
        dispatch_sync(dispatch_get_global_queue(QOS_CLASS_DEFAULT,0),^{CSClientGuardSetSetting(CSClientGuardEnabledKey,NO);});
    });
    CSClientGuardRefresh();CHECK(preparationCalls==1);CHECK(!CSClientGuardSetting(CSClientGuardEnabledKey));
    CHECK(!CSClientGuardShouldApply(CSClientGuardEnvironment,NO));CHECK(HookCount==0);

    CSClientGuardRunQueryTests();
    // Query tests use their own isolated store and host resources. Return to this suite.
    CSClientGuardUseTestDefaults(defaults,[root URLByAppendingPathComponent:@"Host.app"].path,root);
    Configure(defaults,@[@"crash_block",@"crash_monitor",@"safe_mode",@"vendor_id"],NO);
    NSUInteger installed=HookCount;CSClientGuardRefresh();CHECK(HookCount==installed);
    id block=[blockHost new],crash=[crashHost new],safe=[safeHost new],device=[QIDevice new];
    CHECK(BooleanCall(block,@selector(start),charMode));CHECK(BlockCalls==0);
    CHECK(BooleanCall(crash,@selector(install),charMode));CHECK(InstallCalls==0);
    SetMonitoring(crash,charMode,7);CHECK(MonitoringCalls==0);
    CHECK(!BooleanCall(safe,@selector(shouldEnterSafeMode),charMode));CHECK(SafeCalls==0);
    NSUUID *identifier=[device identifierForVendor];CHECK([identifier isKindOfClass:NSUUID.class]);CHECK(VendorCalls==0);
    CHECK(![identifier.UUIDString isEqual:@"11111111-1111-1111-1111-111111111111"]);
    CHECK([[device identifierForVendor] isEqual:identifier]);CSClientGuardRefresh();CHECK([[device identifierForVendor] isEqual:identifier]);
    CHECK([defaults objectForKey:@"RG_FAKE_IDFV"]==nil);
    CHECK([defaults objectForKey:@"com.wechat.enhance.backup.installationID"]==nil);
    CHECK([CSClientGuardStatuses()[@"-[QIDevice identifierForVendor]"] hasPrefix:@"已安装"]);
    NSString *installedSummary=CSClientGuardDiagnosticSummary();
    CHECK([installedSummary componentsSeparatedByString:@"-[QIDevice identifierForVendor]："].count==2);
    CHECK([installedSummary containsString:@"本机 IDFV：本机标识已准备，不随备份迁移"] &&
        [installedSummary containsString:@"本机停用标记：未设置"]);

    // Stop the master immediately; no refresh is needed for passthrough.
    CSClientGuardSetSetting(CSClientGuardEnabledKey,NO);
    CHECK(!BooleanCall(block,@selector(start),charMode));CHECK(BlockCalls==1);
    CHECK(!BooleanCall(crash,@selector(install),charMode));CHECK(InstallCalls==1);
    SetMonitoring(crash,charMode,7);CHECK(MonitoringCalls==1 && LastMonitoring==(charMode?1:7));
    CHECK(BooleanCall(safe,@selector(shouldEnterSafeMode),charMode));CHECK(SafeCalls==1);
    CHECK([[[device identifierForVendor] UUIDString] isEqual:@"11111111-1111-1111-1111-111111111111"]);
    Configure(defaults,@[@"vendor_id"],YES);
    CHECK([[[device identifierForVendor] UUIDString] isEqual:@"11111111-1111-1111-1111-111111111111"]);
    CSClientGuardWithCheckScope(^{CHECK([[device identifierForVendor] isEqual:identifier]);});
    CSClientGuardWithCheckScope(^{
        CHECK(CSClientGuardShouldApply(CSClientGuardVendorID,YES));
        CSClientGuardSetSetting(CSClientGuardPreferenceKey(@"vendor_id"),NO);
        CHECK(!CSClientGuardShouldApply(CSClientGuardVendorID,YES));
        CHECK([[[device identifierForVendor] UUIDString] isEqual:@"11111111-1111-1111-1111-111111111111"]);
        CSClientGuardSetSetting(CSClientGuardPreferenceKey(@"vendor_id"),YES);
        CHECK(!CSClientGuardShouldApply(CSClientGuardVendorID,YES));
    });
    CHECK(!CSClientGuardShouldApply(CSClientGuardVendorID,NO));
    CSClientGuardRefresh();
    CSClientGuardSetSetting(CSClientGuardScopedKey,NO);
    CSClientGuardWithCheckScope(^{CHECK(CSClientGuardShouldApply(CSClientGuardVendorID,YES));});
    [defaults setBool:YES forKey:CSClientGuardScopedKey];
    CSClientGuardWithCheckScope(^{
        CHECK(CSClientGuardShouldApply(CSClientGuardVendorID,YES));
        [defaults setBool:NO forKey:CSClientGuardPreferenceKey(@"vendor_id")];CSClientGuardRefresh();
        CHECK(!CSClientGuardShouldApply(CSClientGuardVendorID,YES));
        CHECK([[[device identifierForVendor] UUIDString] isEqual:@"11111111-1111-1111-1111-111111111111"]);
    });
    Configure(defaults,@[@"vendor_id"],YES);
    CSClientGuardWithoutOverrides(^{CSClientGuardWithCheckScope(^{CHECK([[[device identifierForVendor] UUIDString] isEqual:@"11111111-1111-1111-1111-111111111111"]);});});
    [defaults setObject:@"invalid" forKey:@"com.wechat.enhance.client_guard.local_vendor_uuid"];CSClientGuardRefresh();
    CSClientGuardWithCheckScope(^{CHECK([[[device identifierForVendor] UUIDString] isEqual:@"11111111-1111-1111-1111-111111111111"]);});
    CHECK([[defaults objectForKey:@"com.wechat.enhance.client_guard.local_vendor_uuid"] isEqual:@"invalid"]);

    IMP prior=NULL;NSUInteger before=HookCount;
    CHECK(!CSClientGuardInstallHook(@"CSGuardInvalidFixture",@"unexpected",NO,"B@:",imp_implementationWithBlock(^bool(id obj){(void)obj;return true;}),&prior));
    CHECK(HookCount==before);CHECK([[CSGuardInvalidFixture new] unexpected]==1.5);
    NSString *extraInterfaceSummary=CSClientGuardDiagnosticSummary();
    CHECK([extraInterfaceSummary containsString:@"-[CSGuardInvalidFixture unexpected]：目标接口存在，签名不兼容，未安装"]);
    CHECK([extraInterfaceSummary componentsSeparatedByString:@"-[CSGuardInvalidFixture unexpected]："].count==2);
    CHECK(!CSClientGuardInstallHook(@"CSGuardAbsentClass",@"nothing",NO,"v@:",imp_implementationWithBlock(^(id obj){(void)obj;}),&prior));
    CHECK(HookCount==before);
    CHECK([CSClientGuardDiagnosticSummary() containsString:@"不代表防封效果"]);
    // A device-local emergency marker wins over restored settings and prevents
    // even the lazy generation of the independent vendor UUID.
    [defaults removeObjectForKey:@"com.wechat.enhance.client_guard.local_vendor_uuid"];
    NSURL *marker=[root URLByAppendingPathComponent:@"Preferences/WeChatImprove/ClientGuard/disabled"];
    CHECK([NSFileManager.defaultManager createDirectoryAtURL:marker.URLByDeletingLastPathComponent withIntermediateDirectories:YES attributes:nil error:NULL]);
    CHECK([NSData.data writeToURL:marker atomically:YES]);
    NSUInteger markerHooks=HookCount;Configure(defaults,@[@"vendor_id"],NO);
    CHECK(HookCount==markerHooks && !CSClientGuardShouldApply(CSClientGuardVendorID,NO));
    CHECK([defaults objectForKey:@"com.wechat.enhance.client_guard.local_vendor_uuid"]==nil);
    CHECK([CSClientGuardDiagnosticSummary() containsString:@"配置总开关：开启"]);
    CHECK([CSClientGuardDiagnosticSummary() containsString:@"实际干预策略：已停用"]);
    CHECK([NSFileManager.defaultManager removeItemAtURL:marker error:NULL]);
    CSClientGuardRefresh();CHECK(CSClientGuardShouldApply(CSClientGuardVendorID,NO));
    // An invalid resource context cannot make the emergency marker look absent.
    // These paths stay inside this suite; no real preferences or Library are used.
    [defaults removeObjectForKey:@"com.wechat.enhance.client_guard.local_vendor_uuid"];
    CSClientGuardUseTestDefaults(defaults,[root URLByAppendingPathComponent:@"Host.app"].path,
        [NSURL URLWithString:@"https://invalid.example/Library"]);
    Configure(defaults,@[@"vendor_id"],NO);
    CHECK(!CSClientGuardShouldApply(CSClientGuardVendorID,NO));
    CHECK([defaults objectForKey:@"com.wechat.enhance.client_guard.local_vendor_uuid"]==nil);
    CHECK([CSClientGuardStatuses()[@"本机停用标记"] containsString:@"无法确认"]);
    CHECK([CSClientGuardDiagnosticSummary() containsString:@"实际干预策略：已停用"]);
    CSClientGuardUseTestDefaults(defaults,@"",root);
    Configure(defaults,@[@"vendor_id",@"bundle_info"],NO);
    CHECK(!CSClientGuardShouldApply(CSClientGuardVendorID,NO));
    CHECK([defaults objectForKey:@"com.wechat.enhance.client_guard.local_vendor_uuid"]==nil);
    CHECK(CSClientGuardReplacementInfoPath()==nil);
    CSClientGuardUseTestDefaults(defaults,[root URLByAppendingPathComponent:@"Host.app"].path,root);
    CSClientGuardRefresh();CHECK(CSClientGuardShouldApply(CSClientGuardVendorID,NO));
    // The catalog, UI state and current-session ABI record describe the same
    // capabilities, while observed calls remain separate from installation.
    for(NSDictionary *option in CSClientGuardOptions()) {
        NSDictionary *state=State(option[@"identifier"]);
        CHECK([option[@"section"] length]>0 && option[@"sectionOrder"] && option[@"order"] &&
            option[@"scopedQuery"] && option[@"restartRequired"] && option[@"dependencies"] &&
            [option[@"resource"] length]>0 && [option[@"interfaces"] count]>0 &&
            state[@"configured"] && state[@"published"] && state[@"observed"] && state[@"interfaceStates"]);
    }
    for(NSString *identifier in @[@"crash_block",@"crash_monitor",@"safe_mode",@"vendor_id"])
        CHECK([State(identifier)[@"observed"] unsignedLongLongValue]>0 && [State(identifier)[@"applied"] unsignedLongLongValue]>0);
    NSDictionary *vendorInterface=[State(@"vendor_id")[@"interfaceStates"] firstObject];
    CHECK([vendorInterface[@"actualEncoding"] containsString:@"@"] && [vendorInterface[@"attemptedEncoding"] isEqual:@"@@:"]);
    CHECK([vendorInterface[@"expectedEncodings"] containsObject:@"@@:"] && [vendorInterface[@"status"] hasPrefix:@"已安装"]);
    CHECK([vendorInterface[@"classFound"] boolValue] && [vendorInterface[@"methodFound"] boolValue]);
    CHECK([vendorInterface[@"availabilityCode"] isEqual:@"available"] && [vendorInterface[@"installationCode"] isEqual:@"installed"]);
    CHECK([State(@"vendor_id")[@"installedInterfaces"] unsignedIntegerValue]==1 && [State(@"vendor_id")[@"fullyInstalled"] boolValue]);
    Configure(defaults,@[@"crash_block"],NO);
    CSClientGuardSetSetting(CSClientGuardPreferenceKey(@"crash_block"),NO);
    CHECK([State(@"crash_block")[@"restartPending"] boolValue]);
    // OFF then ON can end with the same persisted settings as the prior
    // snapshot. It must still republish the atomically revoked policy.
    Configure(defaults,@[@"environment"],NO);DrainRefreshQueue();
    CSClientGuardSetSetting(CSClientGuardPreferenceKey(@"environment"),NO);
    CSClientGuardSetSetting(CSClientGuardPreferenceKey(@"environment"),YES);
    CHECK(!CSClientGuardShouldApply(CSClientGuardEnvironment,NO));
    DrainRefreshQueue();CHECK(CSClientGuardShouldApply(CSClientGuardEnvironment,NO));

    // Counter contention is tested on a dedicated capability without a live
    // fixture for that target, so unrelated Foundation calls cannot add noise.
    Configure(defaults,@[@"tls_trust"],YES);
    CHECK([State(@"tls_trust")[@"lastOutcome"] isEqual:@"尚无完成记录"] &&
        [State(@"tls_trust")[@"observed"] unsignedLongLongValue]==0);
    CHECK(CSClientGuardEvaluateCall(CSClientGuardTLSTrust,NO));
    NSDictionary *pending=State(@"tls_trust");
    CHECK([pending[@"lastOutcome"] isEqual:@"尚无完成记录"] &&
        [pending[@"observed"] unsignedLongLongValue]==1 && [pending[@"applied"] unsignedLongLongValue]==0);
    CSClientGuardRecordOutcome(CSClientGuardTLSTrust,CSClientGuardCallApplied);
    NSDictionary *counterBefore=State(@"tls_trust");
    CHECK([counterBefore[@"lastOutcome"] isEqual:@"已应用"] &&
        [counterBefore[@"applied"] unsignedLongLongValue]==1 && [counterBefore[@"fallback"] unsignedLongLongValue]==0);
    dispatch_apply(1000,dispatch_get_global_queue(QOS_CLASS_USER_INITIATED,0),^(__unused size_t index){
        if(CSClientGuardEvaluateCall(CSClientGuardTLSTrust,NO))
            CSClientGuardRecordOutcome(CSClientGuardTLSTrust,CSClientGuardCallApplied);
    });
    NSDictionary *counterAfter=State(@"tls_trust");
    CHECK([counterAfter[@"observed"] unsignedLongLongValue]-[counterBefore[@"observed"] unsignedLongLongValue]==1000);
    CHECK([counterAfter[@"applied"] unsignedLongLongValue]-[counterBefore[@"applied"] unsignedLongLongValue]==1000);
    CHECK([counterAfter[@"fallback"] isEqual:counterBefore[@"fallback"]]);
    CHECK([counterAfter[@"lastOutcome"] isEqual:@"已应用"]);
    CHECK(!CSClientGuardEvaluateCall(CSClientGuardTLSTrust,YES));
    CSClientGuardWithoutOverrides(^{CHECK(!CSClientGuardEvaluateCall(CSClientGuardTLSTrust,NO));});
    CSClientGuardSetSetting(CSClientGuardPreferenceKey(@"tls_trust"),NO);
    CHECK(!CSClientGuardEvaluateCall(CSClientGuardTLSTrust,NO));
    NSDictionary *rejected=State(@"tls_trust");
    CHECK([rejected[@"outcomes"][@(CSClientGuardCallOutOfScope)] unsignedLongLongValue]>0);
    CHECK([rejected[@"outcomes"][@(CSClientGuardCallBypassed)] unsignedLongLongValue]>0);
    CHECK([rejected[@"outcomes"][@(CSClientGuardCallDisabled)] unsignedLongLongValue]>0);
    CHECK([rejected[@"lastOutcome"] isEqual:@"能力或总策略关闭"]);
    CSClientGuardDiagnosticSummary();CSClientGuardSessionSnapshot();
    CHECK([State(@"tls_trust")[@"observed"] isEqual:rejected[@"observed"]]);
    CHECK(!CSClientGuardEvaluateCall((CSClientGuardCapability)(CSClientGuardTLSTrust|CSClientGuardVendorID),NO));

    // Unrelated preferences must not reread resources or retry Hook installs.
    // Explicit refresh and foreground still recheck changed files and the
    // emergency marker even when the persisted choices are unchanged.
    NSURL *host=[root URLByAppendingPathComponent:@"Host.app" isDirectory:YES];
    CHECK([NSFileManager.defaultManager createDirectoryAtURL:host withIntermediateDirectories:YES attributes:nil error:NULL]);
    NSURL *siri=[host URLByAppendingPathComponent:@"siri.plist"];
    CHECK([@{@"test":@1} writeToURL:siri atomically:YES]);
    Configure(defaults,@[@"bundle_info"],NO);DrainRefreshQueue();
    CHECK([CSClientGuardReplacementInfo()[@"test"] isEqual:@1]);
    NSDictionary *sessionBefore=CSClientGuardSessionSnapshot();NSUInteger installedBefore=HookCount;
    CHECK([@{@"test":@2} writeToURL:siri atomically:YES]);
    [defaults setObject:@"unrelated" forKey:@"test.other.module"];
    [NSNotificationCenter.defaultCenter postNotificationName:NSUserDefaultsDidChangeNotification object:defaults];
    DrainRefreshQueue();NSDictionary *sessionAfter=CSClientGuardSessionSnapshot();
    CHECK([sessionAfter[@"resourcePreparations"] isEqual:sessionBefore[@"resourcePreparations"]]);
    CHECK([sessionAfter[@"refreshes"] isEqual:sessionBefore[@"refreshes"]] && HookCount==installedBefore);
    CHECK([CSClientGuardReplacementInfo()[@"test"] isEqual:@1]);
    CSClientGuardRefresh();CHECK([CSClientGuardReplacementInfo()[@"test"] isEqual:@2]);
    CHECK([CSClientGuardSessionSnapshot()[@"resourcePreparations"] unsignedLongLongValue]>[sessionBefore[@"resourcePreparations"] unsignedLongLongValue]);
    CHECK([@{@"test":@3} writeToURL:siri atomically:YES]);
    [NSNotificationCenter.defaultCenter postNotificationName:@"UIApplicationDidBecomeActiveNotification" object:nil];
    DrainRefreshQueue();CHECK([CSClientGuardReplacementInfo()[@"test"] isEqual:@3]);
    CHECK([NSData.data writeToURL:marker atomically:YES]);
    [NSNotificationCenter.defaultCenter postNotificationName:@"UIApplicationDidBecomeActiveNotification" object:nil];
    DrainRefreshQueue();CHECK(!CSClientGuardShouldApply(CSClientGuardBundleInfo,NO));
    CHECK([State(@"bundle_info")[@"published"] boolValue]==NO && ![State(@"bundle_info")[@"resourceReady"] boolValue]);
    CHECK([NSFileManager.defaultManager removeItemAtURL:marker error:NULL]);
    CSClientGuardRefresh();CHECK(CSClientGuardShouldApply(CSClientGuardBundleInfo,NO));
    CHECK([State(@"bundle_info")[@"resourceReady"] boolValue]);
    NSDictionary *resourceSession=CSClientGuardSessionSnapshot();
    CHECK([@{@"test":@4} writeToURL:siri atomically:YES]);
    CSClientGuardSetSetting(CSClientGuardPreferenceKey(@"friend_scope"),YES);DrainRefreshQueue();
    CHECK([CSClientGuardReplacementInfo()[@"test"] isEqual:@3]);
    CHECK([CSClientGuardSessionSnapshot()[@"resourcePreparations"] isEqual:resourceSession[@"resourcePreparations"]]);
    CHECK([State(@"friend_scope")[@"dependencyReady"] boolValue]);
    CSClientGuardRefresh();CHECK([CSClientGuardReplacementInfo()[@"test"] isEqual:@4]);

    // Inspect real runtime metadata without inventing an implementation when
    // only a class method exists. Presence, ABI support and Hook installation
    // are separate states, including when methods appear after an attempt.
    NSDictionary *unattempted=[State(@"fingerprint_data")[@"interfaceStates"] firstObject];
    CHECK(![unattempted[@"classFound"] boolValue] && ![unattempted[@"methodFound"] boolValue]);
    CHECK([unattempted[@"availabilityCode"] isEqual:@"class-missing"] && [unattempted[@"installationCode"] isEqual:@"not-attempted"]);
    Configure(defaults,@[@"fingerprint_data"],NO);
    NSDictionary *absent=[State(@"fingerprint_data")[@"interfaceStates"] firstObject];
    CHECK([absent[@"installationCode"] isEqual:@"class-missing"] && ![absent[@"oppositeMethodAvailable"] boolValue]);
    CHECK([State(@"fingerprint_data")[@"installation"] containsString:@"未找到目标类"]);
    Class deviceInfo=objc_allocateClassPair(NSObject.class,"MMDeviceInfoManager",0);
    CHECK(deviceInfo!=Nil);
    CHECK(class_addMethod(object_getClass(deviceInfo),NSSelectorFromString(@"isJailbrokenDevice"),(IMP)ClassOnlyEnvironmentCheck,"B@:"));
    objc_registerClassPair(deviceInfo);
    NSUInteger beforeOpposite=HookCount;
    Configure(defaults,@[@"device_checks"],NO);
    CHECK(HookCount==beforeOpposite);
    NSArray *deviceRecords=State(@"device_checks")[@"interfaceStates"];
    NSDictionary *opposite=deviceRecords[0],*missing=deviceRecords[1];
    CHECK([opposite[@"classFound"] boolValue] && ![opposite[@"methodFound"] boolValue] && [opposite[@"oppositeMethodAvailable"] boolValue]);
    CHECK([opposite[@"availabilityCode"] isEqual:@"opposite-method-only"] && [opposite[@"oppositeEncoding"] isEqual:@"B@:"]);
    CHECK([opposite[@"installationCode"] isEqual:@"opposite-method-only"] && ![opposite[@"installed"] boolValue]);
    CHECK([missing[@"classFound"] boolValue] && ![missing[@"methodFound"] boolValue] && ![missing[@"oppositeMethodAvailable"] boolValue]);
    CHECK([missing[@"availabilityCode"] isEqual:@"method-missing"] && [missing[@"installationCode"] isEqual:@"method-missing"]);
    CHECK([CSClientGuardDiagnosticSummary() containsString:@"同名类方法编码：B@:；仅供核对，不自动接入"]);
    CHECK(class_addMethod(deviceInfo,NSSelectorFromString(@"isJailbrokenDevice"),(IMP)ClassOnlyEnvironmentCheck,"B@:"));
    NSDictionary *nowAvailable=[State(@"device_checks")[@"interfaceStates"] firstObject];
    CHECK([nowAvailable[@"availabilityCode"] isEqual:@"available"] && [nowAvailable[@"installationCode"] isEqual:@"available-not-installed"]);
    CHECK([nowAvailable[@"status"] containsString:@"请刷新重检"] && HookCount==beforeOpposite);
    CSClientGuardRefresh();
    CHECK(HookCount==beforeOpposite+1 && [State(@"device_checks")[@"installationCode"] isEqual:@"partial"]);
    CHECK([State(@"device_checks")[@"installedInterfaces"] unsignedIntegerValue]==1 && ![State(@"device_checks")[@"fullyInstalled"] boolValue]);
    Class fingerprint=objc_allocateClassPair(NSObject.class,"MMFPManager",0);
    CHECK(fingerprint!=Nil);
    CHECK(class_addMethod(fingerprint,NSSelectorFromString(@"generateFingerprint"),(IMP)IncompatibleFingerprint,"d@:"));
    objc_registerClassPair(fingerprint);
    Configure(defaults,@[@"fingerprint_data"],NO);
    NSDictionary *incompatible=[State(@"fingerprint_data")[@"interfaceStates"] firstObject];
    CHECK([incompatible[@"classFound"] boolValue] && [incompatible[@"methodFound"] boolValue]);
    CHECK([incompatible[@"availabilityCode"] isEqual:@"signature-unsupported"] && [incompatible[@"installationCode"] isEqual:@"signature-unsupported"]);
    CHECK([incompatible[@"actualEncoding"] isEqual:@"d@:"] && ![incompatible[@"installed"] boolValue]);
    CHECK([CSClientGuardDiagnosticSummary() containsString:@"配置开启 1 项，策略发布 1 项"]);
    CHECK([CSClientGuardDiagnosticSummary() containsString:@"至少一个接口已安装"]);
    CHECK(![State(@"environment")[@"configured"] boolValue] && [State(@"environment")[@"installedInterfaces"] unsignedIntegerValue]>0);
    // Build-specific adapters and diagnostics share one exact host identity;
    // a matching marketing version cannot admit a different build.
    CSClientGuardUseTestHostVersion(@"8.0.80",@"8.0.80.34");
    CHECK(CSClientGuardHostMatches(@"8.0.80",@"8.0.80.34"));
    CHECK(!CSClientGuardHostMatches(@"8.0.79",@"8.0.80.34") && !CSClientGuardHostMatches(@"8.0.80",@"8.0.80.35"));
    CHECK([CSClientGuardSessionSnapshot()[@"version"] isEqual:@"8.0.80"] && [CSClientGuardSessionSnapshot()[@"build"] isEqual:@"8.0.80.34"]);
    CHECK([CSClientGuardDiagnosticSummary() containsString:@"宿主：8.0.80 (8.0.80.34)"]);
    NSArray *verifiedDevice=State(@"device_checks")[@"interfaceStates"];
    CHECK([verifiedDevice[2][@"identity"] isEqual:@"+[JailBreakHelper JailBroken]"] && [verifiedDevice[3][@"identity"] isEqual:@"-[JailBreakHelper IsJailBreak]"]);
    CHECK([verifiedDevice[2][@"supportedHostBuild"] isEqual:@"8.0.80.34"] && [verifiedDevice[2][@"hostMatched"] boolValue]);
    CHECK([verifiedDevice[2][@"expectedEncodings"] containsObject:@"B@:"]);
    NSArray *verifiedDetection=State(@"detection_results")[@"interfaceStates"];
    CHECK([verifiedDetection[2][@"identity"] isEqual:@"-[WCSHmdtMgr isHmdtEnable]"] && [verifiedDetection[3][@"identity"] isEqual:@"-[WCSHmdtMgr startTask:behaviorID:config:]"]);
    CHECK([verifiedDetection[3][@"supportedHostBuild"] isEqual:@"8.0.80.34"] && [verifiedDetection[3][@"hostMatched"] boolValue]);
    CHECK([verifiedDetection[3][@"expectedEncodings"] containsObject:@"v@:I@^{TaskConfig=I}"]);
    CSClientGuardUseTestHostVersion(@"8.0.80",@"8.0.80.35");
    CHECK(!CSClientGuardHostMatches(@"8.0.80",@"8.0.80.34"));
    CHECK(![State(@"device_checks")[@"interfaceStates"][2][@"hostMatched"] boolValue]);
    CHECK([CSClientGuardDiagnosticSummary() containsString:@"当前构建不匹配，不接入该目标"]);
    CSClientGuardUseTestHostVersion(@"8.0.80",nil);
    CHECK(!CSClientGuardHostMatches(@"8.0.80",@"8.0.80.34"));
    CSClientGuardUseTestHostVersion(nil,nil);
    [defaults removePersistentDomainForName:suite];[NSFileManager.defaultManager removeItemAtURL:root error:NULL];
    NSLog(@"ClientGuard runtime: %lu assertions, %@ ABI passed",(unsigned long)Assertions,charMode?@"char/bool-setter":@"bool/int-setter");
}return 0;}
