#import <Foundation/Foundation.h>
#import <objc/message.h>
#import "CSClientGuard.h"
#include <stdbool.h>
#include <stdint.h>
#include <limits.h>

static NSUInteger Assertions,HookCount,BoolOriginals,TaskOriginals;
static uint64_t LastTask;
static id LastBehavior;
static void *LastConfig;
static BOOL ThrowOriginal;
static NSException *ExpectedException;
struct TaskConfig { unsigned int value; };
#define CHECK(...) do {Assertions++;if(!(__VA_ARGS__)){fprintf(stderr,"8080 FAIL %d: %s\n",__LINE__,#__VA_ARGS__);exit(1);}}while(0)

static bool OriginalBool(id object,SEL selector){
    (void)object;(void)selector;BoolOriginals++;
    if(ThrowOriginal)@throw ExpectedException;
    return true;
}
static signed char OriginalChar(id object,SEL selector){return OriginalBool(object,selector)?1:0;}
static void OriginalTask32(id object,SEL selector,unsigned int task,id behavior,struct TaskConfig *config){
    (void)object;(void)selector;TaskOriginals++;LastTask=task;LastBehavior=behavior;LastConfig=config;
    if(ThrowOriginal)@throw ExpectedException;
}
static void OriginalTask64(id object,SEL selector,unsigned long long task,id behavior,struct TaskConfig *config){
    (void)object;(void)selector;TaskOriginals++;LastTask=task;LastBehavior=behavior;LastConfig=config;
    if(ThrowOriginal)@throw ExpectedException;
}
void CSClientGuardTestHookMessage(Class cls,SEL selector,IMP replacement,IMP *original){
    Method method=class_getInstanceMethod(cls,selector);*original=method_getImplementation(method);
    if(!class_addMethod(cls,selector,replacement,method_getTypeEncoding(method)))method_setImplementation(method,replacement);
    HookCount++;
}
static Class HostClass(NSString *name){
    Class cls=objc_allocateClassPair(NSObject.class,name.UTF8String,0);
    CHECK(cls!=Nil);objc_registerClassPair(cls);return cls;
}
static NSDictionary *State(CSClientGuardCapability capability){
    for(NSDictionary *state in CSClientGuardCapabilityStates())
        if([state[@"capability"] unsignedLongLongValue]==capability)return state;
    return @{};
}
static uint64_t Metric(CSClientGuardCapability capability,NSString *key){return [State(capability)[key] unsignedLongLongValue];}
static NSDictionary *Interface(CSClientGuardCapability capability,NSString *identity){
    for(NSDictionary *record in State(capability)[@"interfaceStates"])
        if([record[@"identity"] isEqual:identity])return record;
    return @{};
}
static BOOL CallBool(id object,NSString *name,BOOL charABI){
    SEL selector=NSSelectorFromString(name);
    return charABI?((signed char(*)(id,SEL))objc_msgSend)(object,selector)!=0:
        ((bool(*)(id,SEL))objc_msgSend)(object,selector);
}
static void CallTask(id object,BOOL wide,id behavior,struct TaskConfig *config){
    SEL selector=NSSelectorFromString(@"startTask:behaviorID:config:");
    if(wide)((void(*)(id,SEL,unsigned long long,id,struct TaskConfig *))objc_msgSend)
        (object,selector,ULLONG_MAX-7,behavior,config);
    else ((void(*)(id,SEL,unsigned int,id,struct TaskConfig *))objc_msgSend)
        (object,selector,UINT_MAX-7,behavior,config);
}
static void Configure(NSUserDefaults *defaults){
    [defaults setBool:YES forKey:CSClientGuardEnabledKey];
    for(NSDictionary *row in CSClientGuardOptions()){
        uint64_t capability=[row[@"capability"] unsignedLongLongValue];
        [defaults setBool:(capability&(CSClientGuardDeviceChecks|CSClientGuardDetectionResults))!=0
            forKey:CSClientGuardPreferenceKey(row[@"identifier"])];
    }
    CSClientGuardRefresh();
}

int main(int argc,const char **argv){@autoreleasepool{
    BOOL unsupported=argc>1 && !strcmp(argv[1],"--unsupported");
    Class jailClass=HostClass(@"JailBreakHelper"),detectionClass=HostClass(@"WCSHmdtMgr");
    CHECK(class_addMethod(object_getClass(jailClass),NSSelectorFromString(@"JailBroken"),
        unsupported?(IMP)OriginalChar:(IMP)OriginalBool,unsupported?"c@:":"B16@0:8"));
    CHECK(class_addMethod(jailClass,NSSelectorFromString(@"IsJailBreak"),(IMP)OriginalBool,"B16@0:8"));
    CHECK(class_addMethod(detectionClass,NSSelectorFromString(@"isHmdtEnable"),(IMP)OriginalBool,"B16@0:8"));
    CHECK(class_addMethod(detectionClass,NSSelectorFromString(@"startTask:behaviorID:config:"),
        unsupported?(IMP)OriginalTask64:(IMP)OriginalTask32,
        unsupported?"v@:Q@^{TaskConfig=I}":"v36@0:8I16@20^{TaskConfig=I}28"));
    id jail=[jailClass new],detection=[detectionClass new],behavior=[NSObject new];
    struct TaskConfig config={37};struct TaskConfig *configPointer=&config;
    NSString *suite=[@"ClientGuard8080." stringByAppendingString:NSUUID.UUID.UUIDString];
    NSUserDefaults *defaults=[[NSUserDefaults alloc] initWithSuiteName:suite];
    NSURL *library=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString] isDirectory:YES];
    CHECK([NSFileManager.defaultManager createDirectoryAtURL:library withIntermediateDirectories:YES attributes:nil error:NULL]);
    CSClientGuardUseTestDefaults(defaults,@"/tmp/ClientGuard8080.app",library);
    CSClientGuardUseTestHostVersion(@"8.0.80",@"8.0.80.35");
    CSClientGuardStart();Configure(defaults);
    CHECK(HookCount==0);CHECK(!CSClientGuardHostMatches(@"8.0.80",@"8.0.80.34"));
    CHECK(CallBool(jailClass,@"JailBroken",unsupported));CHECK(CallBool(jail,@"IsJailBreak",NO));
    CHECK(CallBool(detection,@"isHmdtEnable",NO));CallTask(detection,unsupported,behavior,&config);
    CHECK(TaskOriginals==1 && LastBehavior==behavior && LastConfig==&config);
    CHECK(LastTask==(unsupported?ULLONG_MAX-7:UINT_MAX-7));
    CHECK(![Interface(CSClientGuardDeviceChecks,@"+[JailBreakHelper JailBroken]")[@"hostMatched"] boolValue]);
    CSClientGuardUseTestHostVersion(@"8.0.79",@"8.0.80.34");CSClientGuardRefresh();CHECK(HookCount==0);
    CSClientGuardUseTestHostVersion(@"8.0.80",@"8.0.80.34");CSClientGuardRefresh();
    CHECK(CSClientGuardHostMatches(@"8.0.80",@"8.0.80.34"));CHECK(HookCount==(unsupported?2:4));
    CHECK([Interface(CSClientGuardDeviceChecks,@"+[JailBreakHelper JailBroken]")[@"hostMatched"] boolValue]);
    CHECK(Metric(CSClientGuardDeviceChecks,@"installedInterfaces")== (unsupported?1:2));
    CHECK(Metric(CSClientGuardDetectionResults,@"installedInterfaces")== (unsupported?1:2));
    CHECK([State(CSClientGuardDeviceChecks)[@"installationCode"] isEqual:@"partial"]);
    NSUInteger beforeBool=BoolOriginals,beforeTask=TaskOriginals;
    CHECK(CallBool(jailClass,@"JailBroken",unsupported)==unsupported);
    CHECK(!CallBool(jail,@"IsJailBreak",NO));CHECK(!CallBool(detection,@"isHmdtEnable",NO));
    CHECK(BoolOriginals==beforeBool+3); // Predecessor side effects remain intact.
    CallTask(detection,unsupported,behavior,&config);CHECK(TaskOriginals==beforeTask+(unsupported?1:0));
    CHECK(Metric(CSClientGuardDeviceChecks,@"applied")== (unsupported?1:2));
    CHECK(Metric(CSClientGuardDetectionResults,@"applied")== (unsupported?1:2));
    if(unsupported){
        CHECK([Interface(CSClientGuardDeviceChecks,@"+[JailBreakHelper JailBroken]")[@"installationCode"] isEqual:@"signature-unsupported"]);
        CHECK([Interface(CSClientGuardDetectionResults,@"-[WCSHmdtMgr startTask:behaviorID:config:]")[@"installationCode"] isEqual:@"signature-unsupported"]);
        CHECK(LastTask==ULLONG_MAX-7 && LastBehavior==behavior && LastConfig==&config);
    }
    beforeTask=TaskOriginals;
    CSClientGuardWithoutOverrides(^{
        CHECK(CallBool(jailClass,@"JailBroken",unsupported));CHECK(CallBool(jail,@"IsJailBreak",NO));
        CHECK(CallBool(detection,@"isHmdtEnable",NO));CallTask(detection,unsupported,behavior,configPointer);
    });
    CHECK(TaskOriginals==beforeTask+1 && LastBehavior==behavior && LastConfig==&config);
    CSClientGuardSetSetting(CSClientGuardPreferenceKey(@"device_checks"),NO);
    CHECK(CallBool(jail,@"IsJailBreak",NO));CHECK(!CallBool(detection,@"isHmdtEnable",NO));
    CSClientGuardSetSetting(CSClientGuardPreferenceKey(@"detection_results"),NO);
    CHECK(CallBool(detection,@"isHmdtEnable",NO));
    beforeTask=TaskOriginals;CallTask(detection,unsupported,behavior,&config);CHECK(TaskOriginals==beforeTask+1);
    Configure(defaults);NSUInteger installed=HookCount;CSClientGuardRefresh();CHECK(HookCount==installed);
    ExpectedException=[NSException exceptionWithName:@"Original8080" reason:@"fixture" userInfo:nil];ThrowOriginal=YES;
    uint64_t beforeApplied=Metric(CSClientGuardDeviceChecks,@"applied");BOOL caught=NO;
    @try {CallBool(jail,@"IsJailBreak",NO);}@catch(NSException *exception){caught=exception==ExpectedException;}
    CHECK(caught);CHECK(Metric(CSClientGuardDeviceChecks,@"applied")==beforeApplied);
    CHECK([State(CSClientGuardDeviceChecks)[@"outcomes"][@(CSClientGuardCallOriginalException)] unsignedLongLongValue]==1);
    ThrowOriginal=NO;
    CSClientGuardSetSetting(CSClientGuardEnabledKey,NO);
    CHECK(CallBool(jail,@"IsJailBreak",NO));CHECK(CallBool(detection,@"isHmdtEnable",NO));
    beforeTask=TaskOriginals;CallTask(detection,unsupported,behavior,&config);
    CHECK(TaskOriginals==beforeTask+1 && LastBehavior==behavior && LastConfig==&config);
    for(NSNumber *capability in @[@(CSClientGuardDeviceChecks),@(CSClientGuardDetectionResults)]){
        uint64_t cap=capability.unsignedLongLongValue;
        CHECK(Metric(cap,@"observed")==Metric(cap,@"applied")+Metric(cap,@"fallback"));
    }
    uint64_t observations=Metric(CSClientGuardDeviceChecks,@"observed");
    NSString *summary=CSClientGuardDiagnosticSummary();CHECK([summary containsString:@"至少一个接口已安装"]);
    CHECK(Metric(CSClientGuardDeviceChecks,@"observed")==observations);
    [defaults removePersistentDomainForName:suite];
    [NSFileManager.defaultManager removeItemAtURL:library error:NULL];
    printf("ClientGuard 8.0.80.34 (%s): %lu assertions passed\n",unsupported?"unsupported ABI":"verified ABI",(unsigned long)Assertions);
    return 0;
}}
