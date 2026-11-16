#import <Foundation/Foundation.h>
#import <objc/message.h>
#import "CSClientGuard.h"
#include <stdbool.h>
#include <limits.h>

static NSUInteger Assertions,HookCount;
static NSMutableDictionary<NSString *,NSNumber *> *Calls;
static id LastArgument,LastPolicy,LastCompletion,OriginalObject,OriginalPins;
static unsigned long long LastChannel;
#define CHECK(...) do {Assertions++;if(!(__VA_ARGS__)){fprintf(stderr,"JiDeNative FAIL %d: %s\n",__LINE__,#__VA_ARGS__);exit(1);}}while(0)
static void Record(SEL selector,id argument){NSString *key=NSStringFromSelector(selector);Calls[key]=@([Calls[key] unsignedIntegerValue]+1);LastArgument=argument;}
static NSUInteger Count(NSString *selector){return [Calls[selector] unsignedIntegerValue];}
static NSDictionary *NativeState(CSClientGuardCapability capability){
    for(NSDictionary *state in CSClientGuardCapabilityStates())
        if([state[@"capability"] unsignedLongLongValue]==capability)return state;
    return @{};
}
static uint64_t NativeMetric(CSClientGuardCapability capability,NSString *metric){return [NativeState(capability)[metric] unsignedLongLongValue];}
static uint64_t NativeOutcome(CSClientGuardCapability capability,CSClientGuardCallOutcome outcome){return [NativeState(capability)[@"outcomes"][@(outcome)] unsignedLongLongValue];}

@interface JiDeDeviceFixture:NSObject
- (bool)isJailbrokenDevice;
- (unsigned long long)runtimeEnvironmentType;
@end
@implementation JiDeDeviceFixture
- (bool)isJailbrokenDevice{Record(_cmd,nil);return true;}
- (unsigned long long)runtimeEnvironmentType{Record(_cmd,nil);return ULLONG_MAX-23;}
@end
@interface JiDeCacheFixture:NSObject
- (id)getBasicData;
@end
@implementation JiDeCacheFixture
- (id)getBasicData{Record(_cmd,nil);return OriginalObject;}
@end
@interface JiDeSafetyFixture:NSObject
- (int)checkAccountRiskLevel:(id)object;
- (long long)currentRiskLevel;
- (void)syncSafetyPolicy:(id)policy completion:(void(^)(bool,id))completion;
- (void)uploadSafetyLog:(id)value;
@end
@implementation JiDeSafetyFixture
- (int)checkAccountRiskLevel:(id)object{Record(_cmd,object);return -17;}
- (long long)currentRiskLevel{Record(_cmd,nil);return LLONG_MIN+37;}
- (void)syncSafetyPolicy:(id)policy completion:(void(^)(bool,id))completion{Record(_cmd,nil);LastPolicy=policy;LastCompletion=completion;}
- (void)uploadSafetyLog:(id)value{Record(_cmd,value);}
@end
@interface JiDeCCFixture:NSObject
- (void)setCcData:(id)value;
@end
@implementation JiDeCCFixture
- (void)setCcData:(id)value{Record(_cmd,value);}
@end
@interface JiDeFingerprintFixture:NSObject
- (void)reportDeviceToken:(id)value;
- (void)uploadFingerprintData:(id)value channel:(unsigned int)channel;
@end
@implementation JiDeFingerprintFixture
- (void)reportDeviceToken:(id)value{Record(_cmd,value);}
- (void)uploadFingerprintData:(id)value channel:(unsigned int)channel{Record(_cmd,value);LastChannel=channel;}
@end
@interface JiDeBehaviorFixture:NSObject
- (void)reportAbnormalBehavior:(id)value;
- (void)flushSecurityEvents;
@end
@implementation JiDeBehaviorFixture
- (void)reportAbnormalBehavior:(id)value{Record(_cmd,value);}
- (void)flushSecurityEvents{Record(_cmd,nil);}
@end
@interface JiDeDetectionFixture:NSObject
- (void)startDetection;
- (id)detectionResult;
- (void)reportDetectionData:(id)value channel:(long long)channel;
@end
@implementation JiDeDetectionFixture
- (void)startDetection{Record(_cmd,nil);}
- (id)detectionResult{Record(_cmd,nil);return OriginalObject;}
- (void)reportDetectionData:(id)value channel:(long long)channel{Record(_cmd,value);LastChannel=(unsigned long long)channel;}
@end
@interface JiDeTLSFixture:NSObject
- (bool)evaluateServerTrust:(id)trust forDomain:(id)domain;
- (id)pinnedCertificates;
- (bool)shouldPinRemoteCert:(id)certificate;
@end
@implementation JiDeTLSFixture
- (bool)evaluateServerTrust:(id)trust forDomain:(id)domain{Record(_cmd,@[trust?:NSNull.null,domain?:NSNull.null]);return false;}
- (id)pinnedCertificates{Record(_cmd,nil);return OriginalPins;}
- (bool)shouldPinRemoteCert:(id)certificate{Record(_cmd,certificate);return true;}
@end

void CSClientGuardTestHookMessage(Class cls,SEL selector,IMP replacement,IMP *original){
    Method method=class_getInstanceMethod(cls,selector);*original=method_getImplementation(method);
    if(!class_addMethod(cls,selector,replacement,method_getTypeEncoding(method)))method_setImplementation(method,replacement);
    HookCount++;
}
static signed char CharJail(id object,SEL selector){(void)object;Record(selector,nil);return 1;}
static unsigned int UIntEnvironment(id object,SEL selector){(void)object;Record(selector,nil);return UINT_MAX-19;}
static long long LongRisk(id object,SEL selector,id value){(void)object;Record(selector,value);return LLONG_MIN+41;}
static unsigned long long ULongCurrent(id object,SEL selector){(void)object;Record(selector,nil);return ULLONG_MAX-11;}
static signed char CharTrust(id object,SEL selector,id trust,id domain){(void)object;Record(selector,@[trust?:NSNull.null,domain?:NSNull.null]);return 0;}
static signed char CharPin(id object,SEL selector,id value){(void)object;Record(selector,value);return 1;}
static void IntChannel(id object,SEL selector,id value,int channel){(void)object;Record(selector,value);LastChannel=(unsigned long long)channel;}
static void ULongChannel(id object,SEL selector,id value,unsigned long long channel){(void)object;Record(selector,value);LastChannel=channel;}
static double InvalidResult(id object,SEL selector){(void)object;Record(selector,nil);return 2.75;}
static id ValidResult(id object,SEL selector){(void)object;Record(selector,nil);return OriginalObject;}
static void InvalidChannel(id object,SEL selector,id value,double channel){(void)object;(void)channel;Record(selector,value);}
static void ValidChannel(id object,SEL selector,id value,long long channel){(void)object;Record(selector,value);LastChannel=(unsigned long long)channel;}
static void OriginalPolicy(id object,SEL selector,id policy,id completion){
    (void)object;Record(selector,nil);LastPolicy=policy;LastCompletion=completion;
}
static Class HostClass(NSString *name,Class parent){
    Class cls=objc_allocateClassPair(parent,name.UTF8String,0);CHECK(cls!=Nil);objc_registerClassPair(cls);return cls;
}
static void AddFixtureMethod(Class cls,SEL selector,IMP implementation,const char *encoding){
    // Adding an override preserves its real encoding. class_replaceMethod on
    // an existing method only replaces its IMP and would leave the old ABI.
    CHECK(class_addMethod(cls,selector,implementation,encoding));
}
static void Configure(NSUserDefaults *defaults,uint64_t mask){
    [defaults setBool:YES forKey:CSClientGuardEnabledKey];[defaults setBool:YES forKey:CSClientGuardScopedKey];
    for(NSDictionary *row in CSClientGuardOptions())[defaults setBool:(mask&[row[@"capability"] unsignedLongLongValue])!=0 forKey:CSClientGuardPreferenceKey(row[@"identifier"])];
    CSClientGuardRefresh();
}
static BOOL Bool0(id object,NSString *name,BOOL charMode){SEL s=NSSelectorFromString(name);return charMode?((signed char(*)(id,SEL))objc_msgSend)(object,s)!=0:((bool(*)(id,SEL))objc_msgSend)(object,s);}
static BOOL Trust(id object,id trust,id domain,BOOL charMode){SEL s=@selector(evaluateServerTrust:forDomain:);return charMode?((signed char(*)(id,SEL,id,id))objc_msgSend)(object,s,trust,domain)!=0:((bool(*)(id,SEL,id,id))objc_msgSend)(object,s,trust,domain);}
static BOOL Pin(id object,id value,BOOL charMode){SEL s=@selector(shouldPinRemoteCert:);return charMode?((signed char(*)(id,SEL,id))objc_msgSend)(object,s,value)!=0:((bool(*)(id,SEL,id))objc_msgSend)(object,s,value);}
static unsigned long long Environment(id object,BOOL charMode){SEL s=@selector(runtimeEnvironmentType);return charMode?((unsigned int(*)(id,SEL))objc_msgSend)(object,s):((unsigned long long(*)(id,SEL))objc_msgSend)(object,s);}
static long long Risk(id object,id argument,BOOL charMode){SEL s=@selector(checkAccountRiskLevel:);return charMode?((long long(*)(id,SEL,id))objc_msgSend)(object,s,argument):((int(*)(id,SEL,id))objc_msgSend)(object,s,argument);}
static unsigned long long Current(id object,BOOL charMode){SEL s=@selector(currentRiskLevel);return charMode?((unsigned long long(*)(id,SEL))objc_msgSend)(object,s):(unsigned long long)((long long(*)(id,SEL))objc_msgSend)(object,s);}
static void Fingerprint(id object,id data,BOOL charMode){SEL s=@selector(uploadFingerprintData:channel:);if(charMode)((void(*)(id,SEL,id,int))objc_msgSend)(object,s,data,INT_MIN+9);else ((void(*)(id,SEL,id,unsigned int))objc_msgSend)(object,s,data,UINT_MAX-7);}
static void Detection(id object,id data,BOOL charMode){SEL s=@selector(reportDetectionData:channel:);if(charMode)((void(*)(id,SEL,id,unsigned long long))objc_msgSend)(object,s,data,ULLONG_MAX-5);else ((void(*)(id,SEL,id,long long))objc_msgSend)(object,s,data,LLONG_MIN+13);}

int main(int argc,const char **argv){@autoreleasepool{
    BOOL charMode=argc>1 && !strcmp(argv[1],"--char");
    Calls=[NSMutableDictionary dictionary];OriginalObject=[@{@"original":@YES} mutableCopy];OriginalPins=[@[@"original-certificate"] mutableCopy];
    Class deviceClass=HostClass(@"MMDeviceInfoManager",JiDeDeviceFixture.class);
    Class cacheClass=HostClass(@"MMClientCacheManager",JiDeCacheFixture.class);
    Class safetyClass=HostClass(@"MMAccountSafeManager",JiDeSafetyFixture.class);
    AddFixtureMethod(safetyClass,@selector(syncSafetyPolicy:completion:),(IMP)OriginalPolicy,"v@:@@?");
    Class ccClass=HostClass(@"WCExtInfo",JiDeCCFixture.class);
    Class fingerprintClass=HostClass(@"MMFPManager",JiDeFingerprintFixture.class);
    Class behaviorClass=HostClass(@"MMBehaviorAnalytics",JiDeBehaviorFixture.class);
    Class invalidDetectionClass=HostClass(@"JiDeInvalidDetectionFixture",JiDeDetectionFixture.class);
    AddFixtureMethod(invalidDetectionClass,@selector(detectionResult),(IMP)InvalidResult,"d@:");
    AddFixtureMethod(invalidDetectionClass,@selector(reportDetectionData:channel:),(IMP)InvalidChannel,"v@:@d");
    Class detectionClass=HostClass(@"HMDTManager",invalidDetectionClass);
    Class tlsClass=HostClass(@"MMSecureTransport",JiDeTLSFixture.class);
    if(charMode){
        AddFixtureMethod(deviceClass,@selector(isJailbrokenDevice),(IMP)CharJail,"c@:");
        AddFixtureMethod(deviceClass,@selector(runtimeEnvironmentType),(IMP)UIntEnvironment,"I@:");
        AddFixtureMethod(safetyClass,@selector(checkAccountRiskLevel:),(IMP)LongRisk,"q@:@");
        AddFixtureMethod(safetyClass,@selector(currentRiskLevel),(IMP)ULongCurrent,"Q@:");
        AddFixtureMethod(tlsClass,@selector(evaluateServerTrust:forDomain:),(IMP)CharTrust,"c@:@@");
        AddFixtureMethod(tlsClass,@selector(shouldPinRemoteCert:),(IMP)CharPin,"c@:@");
        AddFixtureMethod(fingerprintClass,@selector(uploadFingerprintData:channel:),(IMP)IntChannel,"v@:@i");
    }
    NSString *suite=[@"JiDeNativeTests." stringByAppendingString:NSUUID.UUID.UUIDString];
    NSUserDefaults *defaults=[[NSUserDefaults alloc]initWithSuiteName:suite];
    NSURL *root=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:suite] isDirectory:YES];
    CHECK([NSFileManager.defaultManager createDirectoryAtURL:root withIntermediateDirectories:YES attributes:nil error:NULL]);
    CSClientGuardUseTestDefaults(defaults,[root URLByAppendingPathComponent:@"Host.app"].path,root);CSClientGuardStart();
    CHECK(HookCount==0);
    id device=[deviceClass new],cache=[cacheClass new],safe=[safetyClass new],cc=[ccClass new],fp=[fingerprintClass new],behavior=[behaviorClass new],detect=[detectionClass new],tls=[tlsClass new];
    id argument=[NSObject new];

    Configure(defaults,CSClientGuardDeviceChecks);
    CHECK(NativeMetric(CSClientGuardDeviceChecks,@"observed")==0);
    CHECK(HookCount==2);CHECK(!Bool0(device,@"isJailbrokenDevice",charMode));CHECK(Environment(device,charMode)==0);
    CHECK(NativeMetric(CSClientGuardDeviceChecks,@"observed")==2 && NativeMetric(CSClientGuardDeviceChecks,@"applied")==2);
    CHECK(Count(@"isJailbrokenDevice")==0 && Count(@"runtimeEnvironmentType")==0);
    CHECK(Risk(safe,argument,charMode)==(charMode?LLONG_MIN+41:-17));CHECK(LastArgument==argument);
    CSClientGuardSetSetting(CSClientGuardEnabledKey,NO);
    CHECK(Bool0(device,@"isJailbrokenDevice",charMode));CHECK(Environment(device,charMode)==(charMode?UINT_MAX-19:ULLONG_MAX-23));
    CHECK(NativeOutcome(CSClientGuardDeviceChecks,CSClientGuardCallDisabled)==2);
    Configure(defaults,CSClientGuardRiskResults);
    CHECK(Risk(safe,argument,charMode)==0 && Current(safe,charMode)==0);
    CHECK(Bool0(device,@"isJailbrokenDevice",charMode));
    CSClientGuardWithoutOverrides(^{CHECK(Risk(safe,argument,charMode)==(charMode?LLONG_MIN+41:-17));});
    Configure(defaults,0);
    CHECK(Current(safe,charMode)==(charMode?ULLONG_MAX-11:(unsigned long long)(LLONG_MIN+37)));

    Configure(defaults,CSClientGuardBasicData|CSClientGuardCCData);
    CHECK([cache getBasicData]==nil);[cc setCcData:argument];CHECK(Count(@"setCcData:")==0);
    Configure(defaults,0);CHECK([cache getBasicData]==OriginalObject);[cc setCcData:argument];CHECK(Count(@"setCcData:")==1 && LastArgument==argument);

    // A mismatched ABI is rejected before installation and can become eligible
    // after the host supplies a compatible method, without wrapping twice.
    Configure(defaults,CSClientGuardDetectionResults|CSClientGuardDetectionReports);
    CHECK([CSClientGuardStatuses()[@"-[HMDTManager detectionResult]"] containsString:@"签名不兼容"]);
    CHECK([CSClientGuardStatuses()[@"-[HMDTManager reportDetectionData:channel:]"] containsString:@"签名不兼容"]);
    CHECK(((double(*)(id,SEL))objc_msgSend)(detect,@selector(detectionResult))==2.75);
    AddFixtureMethod(detectionClass,@selector(detectionResult),(IMP)ValidResult,"@@:");
    AddFixtureMethod(detectionClass,@selector(reportDetectionData:channel:),charMode?(IMP)ULongChannel:(IMP)ValidChannel,charMode?"v@:@Q":"v@:@q");
    CSClientGuardRefresh();CHECK([detect detectionResult]==nil);

    Configure(defaults,CSClientGuardPolicyCompletion);
    __block NSUInteger callbackCalls=0;
    void(^booleanCompletion)(bool,id)=^(bool result,id error){callbackCalls++;CHECK(result && !error);};
    void(^charCompletion)(signed char,id)=^(signed char result,id error){callbackCalls++;CHECK(result==1 && !error);};
    ((void(*)(id,SEL,id,id))objc_msgSend)(safe,@selector(syncSafetyPolicy:completion:),argument,booleanCompletion);
    CHECK(callbackCalls==1 && Count(@"syncSafetyPolicy:completion:")==0);
    ((void(*)(id,SEL,id,id))objc_msgSend)(safe,@selector(syncSafetyPolicy:completion:),argument,charCompletion);
    CHECK(callbackCalls==2 && Count(@"syncSafetyPolicy:completion:")==0);
    void(^wrongCompletion)(id)=^(__unused id value){callbackCalls++;};
    ((void(*)(id,SEL,id,id))objc_msgSend)(safe,@selector(syncSafetyPolicy:completion:),argument,wrongCompletion);
    CHECK(callbackCalls==2 && Count(@"syncSafetyPolicy:completion:")==1 && LastPolicy==argument && LastCompletion==wrongCompletion);
    ((void(*)(id,SEL,id,id))objc_msgSend)(safe,@selector(syncSafetyPolicy:completion:),argument,nil);
    CHECK(Count(@"syncSafetyPolicy:completion:")==2 && LastCompletion==nil);
    ((void(*)(id,SEL,id,id))objc_msgSend)(safe,@selector(syncSafetyPolicy:completion:),argument,argument);
    CHECK(Count(@"syncSafetyPolicy:completion:")==3 && LastCompletion==argument);
    CHECK(NativeOutcome(CSClientGuardPolicyCompletion,CSClientGuardCallUnsupportedCallback)==3);
    CHECK(NativeMetric(CSClientGuardPolicyCompletion,@"applied")==2 && NativeMetric(CSClientGuardPolicyCompletion,@"observed")==5);
    @try {
        void(^throwingCompletion)(bool,id)=^(__unused bool result,__unused id error){callbackCalls++;[NSException raise:@"CompletionFixture" format:@"propagate"];};
        ((void(*)(id,SEL,id,id))objc_msgSend)(safe,@selector(syncSafetyPolicy:completion:),argument,throwingCompletion);
        CHECK(NO);
    }@catch(NSException *exception){CHECK([exception.name isEqual:@"CompletionFixture"]);}
    CHECK(callbackCalls==3 && Count(@"syncSafetyPolicy:completion:")==3);
    Configure(defaults,0);
    ((void(*)(id,SEL,id,id))objc_msgSend)(safe,@selector(syncSafetyPolicy:completion:),argument,booleanCompletion);
    CHECK(callbackCalls==3 && Count(@"syncSafetyPolicy:completion:")==4 && LastCompletion==booleanCompletion);
    CHECK(NativeMetric(CSClientGuardPolicyCompletion,@"observed")==7 && NativeMetric(CSClientGuardPolicyCompletion,@"applied")==2);
    CHECK(NativeOutcome(CSClientGuardPolicyCompletion,CSClientGuardCallDisabled)==1);
    CHECK(NativeOutcome(CSClientGuardPolicyCompletion,CSClientGuardCallOriginalException)==1);

    Configure(defaults,CSClientGuardTLSTrust);
    CHECK(Trust(tls,argument,@"fixture.invalid",charMode));CHECK(Pin(tls,argument,charMode));CHECK([tls pinnedCertificates]==OriginalPins);
    Configure(defaults,CSClientGuardTLSPinning);
    CHECK(!Trust(tls,argument,@"fixture.invalid",charMode));CHECK([LastArgument isEqual:@[argument,@"fixture.invalid"]]);
    CHECK(!Pin(tls,argument,charMode));CHECK([[tls pinnedCertificates] isEqual:@[]]);CHECK([OriginalPins count]==1);

    uint64_t reports=CSClientGuardDeviceReports|CSClientGuardSafetyReports|CSClientGuardBehaviorReports|CSClientGuardDetectionResults|CSClientGuardDetectionReports;
    Configure(defaults,reports);
    [fp reportDeviceToken:argument];Fingerprint(fp,argument,charMode);[safe uploadSafetyLog:argument];
    [behavior reportAbnormalBehavior:argument];[behavior flushSecurityEvents];[detect startDetection];Detection(detect,argument,charMode);
    CHECK(Count(@"reportDeviceToken:")==0 && Count(@"uploadFingerprintData:channel:")==0 && Count(@"uploadSafetyLog:")==0);
    CHECK(Count(@"reportAbnormalBehavior:")==0 && Count(@"flushSecurityEvents")==0 && Count(@"startDetection")==0 && Count(@"reportDetectionData:channel:")==0);
    CHECK([detect detectionResult]==nil);
    NSUInteger installed=HookCount;CSClientGuardRefresh();CHECK(HookCount==installed);
    CSClientGuardSetSetting(CSClientGuardEnabledKey,NO);
    [fp reportDeviceToken:argument];CHECK(LastArgument==argument);
    Fingerprint(fp,argument,charMode);CHECK(LastArgument==argument && LastChannel==(charMode?(unsigned long long)(INT_MIN+9):UINT_MAX-7));
    [safe uploadSafetyLog:argument];CHECK(LastArgument==argument);
    [behavior reportAbnormalBehavior:argument];[behavior flushSecurityEvents];[detect startDetection];Detection(detect,argument,charMode);
    CHECK(LastArgument==argument && LastChannel==(charMode?ULLONG_MAX-5:(unsigned long long)(LLONG_MIN+13)));
    CHECK(Count(@"reportDeviceToken:")==1 && Count(@"uploadFingerprintData:channel:")==1 && Count(@"uploadSafetyLog:")==1);
    CHECK(Count(@"reportAbnormalBehavior:")==1 && Count(@"flushSecurityEvents")==1 && Count(@"startDetection")==1 && Count(@"reportDetectionData:channel:")==1);
    CHECK([detect detectionResult]==OriginalObject);CHECK([tls pinnedCertificates]==OriginalPins);CHECK(!Trust(tls,nil,nil,charMode));CHECK(Pin(tls,argument,charMode));
    Configure(defaults,CSClientGuardDeviceReports);
    CSClientGuardWithoutOverrides(^{[fp reportDeviceToken:argument];});CHECK(Count(@"reportDeviceToken:")==2);
    Configure(defaults,0);[fp reportDeviceToken:argument];CHECK(Count(@"reportDeviceToken:")==3);
    CHECK(NativeMetric(CSClientGuardDeviceReports,@"observed")==6 && NativeMetric(CSClientGuardDeviceReports,@"applied")==2);
    CHECK(NativeOutcome(CSClientGuardDeviceReports,CSClientGuardCallDisabled)==3);
    CHECK(NativeOutcome(CSClientGuardDeviceReports,CSClientGuardCallBypassed)==1);
    CHECK(NativeOutcome(CSClientGuardRiskResults,CSClientGuardCallBypassed)==1);
    for(NSNumber *capability in @[@(CSClientGuardDeviceChecks),@(CSClientGuardBasicData),@(CSClientGuardRiskResults),
        @(CSClientGuardPolicyCompletion),@(CSClientGuardCCData),@(CSClientGuardDeviceReports),@(CSClientGuardSafetyReports),
        @(CSClientGuardBehaviorReports),@(CSClientGuardDetectionResults),@(CSClientGuardDetectionReports),@(CSClientGuardTLSTrust),@(CSClientGuardTLSPinning)]){
        NSDictionary *state=NativeState([capability unsignedLongLongValue]);
        CHECK([state[@"observed"] unsignedLongLongValue]>0 && [state[@"applied"] unsignedLongLongValue]>0);
        CHECK([state[@"observed"] unsignedLongLongValue]==[state[@"applied"] unsignedLongLongValue]+[state[@"fallback"] unsignedLongLongValue]);
    }

    [defaults removePersistentDomainForName:suite];[NSFileManager.defaultManager removeItemAtURL:root error:NULL];
    NSLog(@"JiDe native: %lu assertions, %@ ABI passed",(unsigned long)Assertions,charMode?@"char/alternate integers":@"bool/primary integers");
}return 0;}
