#import "CSClientGuard.h"
#include <stdbool.h>
#include <string.h>

static Method JiDeMethod(NSString *className, NSString *name) {
    Class cls=NSClassFromString(className);
    return cls?class_getInstanceMethod(cls,NSSelectorFromString(name)):NULL;
}
static char JiDeType(Method method, unsigned index, BOOL result) {
    char buffer[32]={0};
    if(method){
        if(result)method_getReturnType(method,buffer,sizeof(buffer));
        else if(index<method_getNumberOfArguments(method))method_getArgumentType(method,index,buffer,sizeof(buffer));
    }
    const char *type=buffer;
    while(*type && strchr("rnNoORV",*type))type++;
    return *type;
}
static void JiDeReject(NSString *className,NSString *name) {
    CSClientGuardRecordStatus([NSString stringWithFormat:@"-[%@ %@]",className,name],
        JiDeMethod(className,name)?@"接口签名不兼容，未安装":@"当前宿主无此接口，未安装");
}

// Each macro creates a block and predecessor call with exactly the selected ABI.
#define JIDE_BOOL_BODY(TYPE, ENCODING) \
    do { \
        IMP replacement; \
        if(arity==2)replacement=imp_implementationWithBlock(^TYPE(id object,id first,id second){ \
            if(CSClientGuardEvaluateCall(capability,NO)){CSClientGuardRecordOutcome(capability,CSClientGuardCallApplied);return (TYPE)value;} \
            return ((TYPE(*)(id,SEL,id,id))original)(object,selector,first,second); \
        }); \
        else if(arity==1)replacement=imp_implementationWithBlock(^TYPE(id object,id first){ \
            if(CSClientGuardEvaluateCall(capability,NO)){CSClientGuardRecordOutcome(capability,CSClientGuardCallApplied);return (TYPE)value;} \
            return ((TYPE(*)(id,SEL,id))original)(object,selector,first); \
        }); \
        else replacement=imp_implementationWithBlock(^TYPE(id object){ \
            if(CSClientGuardEvaluateCall(capability,NO)){CSClientGuardRecordOutcome(capability,CSClientGuardCallApplied);return (TYPE)value;} \
            return ((TYPE(*)(id,SEL))original)(object,selector); \
        }); \
        const char *encoding=arity==2?ENCODING "@:@@":arity==1?ENCODING "@:@":ENCODING "@:"; \
        CSClientGuardInstallHook(className,name,NO,encoding,replacement,&original); \
    } while(0)
static void JiDeBoolean(NSString *className,NSString *name,CSClientGuardCapability capability,BOOL value,unsigned arity) {
    SEL selector=NSSelectorFromString(name);
    __block IMP original=NULL;
    char result=JiDeType(JiDeMethod(className,name),0,YES);
    if(result=='B')JIDE_BOOL_BODY(bool,"B");
    else if(result=='c')JIDE_BOOL_BODY(signed char,"c");
    else JiDeReject(className,name);
}
#undef JIDE_BOOL_BODY

#define JIDE_INTEGER_BODY(TYPE, ENCODING) \
    do { \
        IMP replacement; \
        if(hasObject)replacement=imp_implementationWithBlock(^TYPE(id object,id argument){ \
            if(CSClientGuardEvaluateCall(capability,NO)){CSClientGuardRecordOutcome(capability,CSClientGuardCallApplied);return (TYPE)0;} \
            return ((TYPE(*)(id,SEL,id))original)(object,selector,argument); \
        }); \
        else replacement=imp_implementationWithBlock(^TYPE(id object){ \
            if(CSClientGuardEvaluateCall(capability,NO)){CSClientGuardRecordOutcome(capability,CSClientGuardCallApplied);return (TYPE)0;} \
            return ((TYPE(*)(id,SEL))original)(object,selector); \
        }); \
        CSClientGuardInstallHook(className,name,NO,hasObject?ENCODING "@:@":ENCODING "@:",replacement,&original); \
    } while(0)
static void JiDeInteger(NSString *className,NSString *name,CSClientGuardCapability capability,BOOL hasObject) {
    SEL selector=NSSelectorFromString(name);
    __block IMP original=NULL;
    switch(JiDeType(JiDeMethod(className,name),0,YES)){
        case 'i':JIDE_INTEGER_BODY(int,"i");break;
        case 'I':JIDE_INTEGER_BODY(unsigned int,"I");break;
        case 'q':JIDE_INTEGER_BODY(long long,"q");break;
        case 'Q':JIDE_INTEGER_BODY(unsigned long long,"Q");break;
        default:JiDeReject(className,name);break;
    }
}
#undef JIDE_INTEGER_BODY

static void JiDeObjectResult(NSString *className,NSString *name,CSClientGuardCapability capability,BOOL emptyArray) {
    SEL selector=NSSelectorFromString(name);
    __block IMP original=NULL;
    IMP replacement=imp_implementationWithBlock(^id(id object){
        if(CSClientGuardEvaluateCall(capability,NO)){
            CSClientGuardRecordOutcome(capability,CSClientGuardCallApplied);return emptyArray?@[]:nil;
        }
        return ((id(*)(id,SEL))original)(object,selector);
    });
    CSClientGuardInstallHook(className,name,NO,"@@:",replacement,&original);
}
static void JiDeVoid(NSString *className,NSString *name,CSClientGuardCapability capability,BOOL hasObject) {
    SEL selector=NSSelectorFromString(name);
    __block IMP original=NULL;
    IMP replacement;
    if(hasObject)replacement=imp_implementationWithBlock(^(id object,id argument){
        if(CSClientGuardEvaluateCall(capability,NO)){CSClientGuardRecordOutcome(capability,CSClientGuardCallApplied);return;}
        ((void(*)(id,SEL,id))original)(object,selector,argument);
    });
    else replacement=imp_implementationWithBlock(^(id object){
        if(CSClientGuardEvaluateCall(capability,NO)){CSClientGuardRecordOutcome(capability,CSClientGuardCallApplied);return;}
        ((void(*)(id,SEL))original)(object,selector);
    });
    CSClientGuardInstallHook(className,name,NO,hasObject?"v@:@":"v@:",replacement,&original);
}

#define JIDE_CHANNEL_BODY(TYPE, ENCODING) \
    do { \
        IMP replacement=imp_implementationWithBlock(^(id object,id data,TYPE channel){ \
            if(CSClientGuardEvaluateCall(capability,NO)){CSClientGuardRecordOutcome(capability,CSClientGuardCallApplied);return;} \
            ((void(*)(id,SEL,id,TYPE))original)(object,selector,data,channel); \
        }); \
        CSClientGuardInstallHook(className,name,NO,"v@:@" ENCODING,replacement,&original); \
    } while(0)
static void JiDeChannel(NSString *className,NSString *name,CSClientGuardCapability capability) {
    SEL selector=NSSelectorFromString(name);
    __block IMP original=NULL;
    switch(JiDeType(JiDeMethod(className,name),3,NO)){
        case 'i':JIDE_CHANNEL_BODY(int,"i");break;
        case 'I':JIDE_CHANNEL_BODY(unsigned int,"I");break;
        case 'q':JIDE_CHANNEL_BODY(long long,"q");break;
        case 'Q':JIDE_CHANNEL_BODY(unsigned long long,"Q");break;
        default:JiDeReject(className,name);break;
    }
}
#undef JIDE_CHANNEL_BODY

// Only actual Objective-C blocks with an explicit, compatible ABI may receive
// the synthetic completion. An id object or an unknown block falls through.
static char JiDeCompletionType(id completion) {
    Class blockClass=NSClassFromString(@"NSBlock");
    if(!completion || !blockClass || ![completion isKindOfClass:blockClass])return 0;
    struct BlockLiteral { void *isa; int flags; int reserved; void *invoke; void *descriptor; };
    const struct BlockLiteral *literal=(__bridge const void *)completion;
    if(!(literal->flags&(1<<30)) || !literal->descriptor)return 0;
    const unsigned char *entry=(const unsigned char *)literal->descriptor+2*sizeof(uintptr_t);
    if(literal->flags&(1<<25))entry+=2*sizeof(void *);
    const char *encoding=*(const char * const *)entry;
    if(!encoding)return 0;
    @try {
        NSMethodSignature *signature=[NSMethodSignature signatureWithObjCTypes:encoding];
        if(!signature || signature.numberOfArguments!=3 || strcmp(signature.methodReturnType,"v") ||
            strcmp([signature getArgumentTypeAtIndex:0],"@?"))return 0;
        const char *success=[signature getArgumentTypeAtIndex:1];
        const char *error=[signature getArgumentTypeAtIndex:2];
        if((strcmp(success,"B") && strcmp(success,"c")) || error[0]!='@' || error[1]=='?')return 0;
        return success[0];
    } @catch(__unused NSException *exception){return 0;}
}
static void JiDePolicyCompletion(void) {
    SEL selector=NSSelectorFromString(@"syncSafetyPolicy:completion:");
    __block IMP original=NULL;
    IMP replacement=imp_implementationWithBlock(^(id object,id policy,id completion){
        if(CSClientGuardEvaluateCall(CSClientGuardPolicyCompletion,NO)){
            char type=JiDeCompletionType(completion);
            if(type=='B' || type=='c'){
                @try{
                    if(type=='B')((void(^)(bool,id))completion)(true,nil);
                    else ((void(^)(signed char,id))completion)((signed char)1,nil);
                }@catch(NSException *exception){
                    CSClientGuardRecordOutcome(CSClientGuardPolicyCompletion,CSClientGuardCallOriginalException);@throw exception;
                }
                CSClientGuardRecordOutcome(CSClientGuardPolicyCompletion,CSClientGuardCallApplied);return;
            }
            CSClientGuardRecordOutcome(CSClientGuardPolicyCompletion,CSClientGuardCallUnsupportedCallback);
        }
        ((void(*)(id,SEL,id,id))original)(object,selector,policy,completion);
    });
    CSClientGuardInstallHook(@"MMAccountSafeManager",@"syncSafetyPolicy:completion:",NO,
        "v@:@@?",replacement,&original);
}

// These targets were verified in the supplied 8.0.80.34 main executable.
// They add bounded native behavior to the existing capabilities; they do not
// stand in for missing risk, fingerprint, report or certificate interfaces.
static void JiDe8080Boolean(NSString *className,NSString *name,BOOL classMethod,
    CSClientGuardCapability capability) {
    SEL selector=NSSelectorFromString(name);
    __block IMP original=NULL;
    IMP replacement=imp_implementationWithBlock(^bool(id object){
        bool result;
        @try {result=((bool(*)(id,SEL))original)(object,selector);}
        @catch(NSException *exception){
            if(CSClientGuardEvaluateCall(capability,NO))
                CSClientGuardRecordOutcome(capability,CSClientGuardCallOriginalException);
            @throw exception;
        }
        // JailBreakHelper also writes an internal marker before checking paths.
        // Keep predecessor side effects and change only the observed BOOL result.
        if(CSClientGuardEvaluateCall(capability,NO)){
            CSClientGuardRecordOutcome(capability,CSClientGuardCallApplied);return false;
        }
        return result;
    });
    // Only B is evidenced for this build. Do not infer a c variant from its name.
    CSClientGuardInstallHook(className,name,classMethod,"B@:",replacement,&original);
}

struct CSClientGuard8080TaskConfig;
static void JiDe8080DetectionTask(void) {
    SEL selector=NSSelectorFromString(@"startTask:behaviorID:config:");
    __block IMP original=NULL;
    IMP replacement=imp_implementationWithBlock(^(id object,unsigned int task,id behavior,
        struct CSClientGuard8080TaskConfig *config){
        if(CSClientGuardEvaluateCall(CSClientGuardDetectionResults,NO)){
            CSClientGuardRecordOutcome(CSClientGuardDetectionResults,CSClientGuardCallApplied);return;
        }
        // Keep the caller's pointer opaque and forward it without copying or
        // dereferencing it. The full host pointee encoding is validated below.
        ((void(*)(id,SEL,unsigned int,id,struct CSClientGuard8080TaskConfig *))original)
            (object,selector,task,behavior,config);
    });
    CSClientGuardInstallHook(@"WCSHmdtMgr",@"startTask:behaviorID:config:",NO,
        "v@:I@^{TaskConfig=I}",replacement,&original);
}

static void JiDe8080VerifiedHooks(void) {
    BOOL device=CSClientGuardShouldApply(CSClientGuardDeviceChecks,NO);
    BOOL detection=CSClientGuardShouldApply(CSClientGuardDetectionResults,NO);
    if(!device && !detection)return;
    if(!CSClientGuardHostMatches(@"8.0.80",@"8.0.80.34")){
        if(device){
            CSClientGuardRecordStatus(@"+[JailBreakHelper JailBroken]",@"仅核实于微信 8.0.80.34，当前构建未接入");
            CSClientGuardRecordStatus(@"-[JailBreakHelper IsJailBreak]",@"仅核实于微信 8.0.80.34，当前构建未接入");
        }
        if(detection){
            CSClientGuardRecordStatus(@"-[WCSHmdtMgr isHmdtEnable]",@"仅核实于微信 8.0.80.34，当前构建未接入");
            CSClientGuardRecordStatus(@"-[WCSHmdtMgr startTask:behaviorID:config:]",@"仅核实于微信 8.0.80.34，当前构建未接入");
        }
        return;
    }
    if(device){
        JiDe8080Boolean(@"JailBreakHelper",@"JailBroken",YES,CSClientGuardDeviceChecks);
        JiDe8080Boolean(@"JailBreakHelper",@"IsJailBreak",NO,CSClientGuardDeviceChecks);
    }
    if(detection){
        JiDe8080Boolean(@"WCSHmdtMgr",@"isHmdtEnable",NO,CSClientGuardDetectionResults);
        JiDe8080DetectionTask();
    }
}

void CSClientGuardInstallJiDeNativeHooks(void) {
    JiDe8080VerifiedHooks();
    if(CSClientGuardShouldApply(CSClientGuardDeviceChecks,NO)){
        JiDeBoolean(@"MMDeviceInfoManager",@"isJailbrokenDevice",CSClientGuardDeviceChecks,NO,0);
        JiDeInteger(@"MMDeviceInfoManager",@"runtimeEnvironmentType",CSClientGuardDeviceChecks,NO);
    }
    if(CSClientGuardShouldApply(CSClientGuardBasicData,NO))
        JiDeObjectResult(@"MMClientCacheManager",@"getBasicData",CSClientGuardBasicData,NO);
    if(CSClientGuardShouldApply(CSClientGuardRiskResults,NO)){
        JiDeInteger(@"MMAccountSafeManager",@"checkAccountRiskLevel:",CSClientGuardRiskResults,YES);
        JiDeInteger(@"MMAccountSafeManager",@"currentRiskLevel",CSClientGuardRiskResults,NO);
    }
    if(CSClientGuardShouldApply(CSClientGuardPolicyCompletion,NO))JiDePolicyCompletion();
    if(CSClientGuardShouldApply(CSClientGuardCCData,NO))
        JiDeVoid(@"WCExtInfo",@"setCcData:",CSClientGuardCCData,YES);
    if(CSClientGuardShouldApply(CSClientGuardDeviceReports,NO)){
        JiDeVoid(@"MMFPManager",@"reportDeviceToken:",CSClientGuardDeviceReports,YES);
        JiDeChannel(@"MMFPManager",@"uploadFingerprintData:channel:",CSClientGuardDeviceReports);
    }
    if(CSClientGuardShouldApply(CSClientGuardSafetyReports,NO))
        JiDeVoid(@"MMAccountSafeManager",@"uploadSafetyLog:",CSClientGuardSafetyReports,YES);
    if(CSClientGuardShouldApply(CSClientGuardBehaviorReports,NO)){
        JiDeVoid(@"MMBehaviorAnalytics",@"reportAbnormalBehavior:",CSClientGuardBehaviorReports,YES);
        JiDeVoid(@"MMBehaviorAnalytics",@"flushSecurityEvents",CSClientGuardBehaviorReports,NO);
    }
    if(CSClientGuardShouldApply(CSClientGuardDetectionResults,NO)){
        JiDeVoid(@"HMDTManager",@"startDetection",CSClientGuardDetectionResults,NO);
        JiDeObjectResult(@"HMDTManager",@"detectionResult",CSClientGuardDetectionResults,NO);
    }
    if(CSClientGuardShouldApply(CSClientGuardDetectionReports,NO))
        JiDeChannel(@"HMDTManager",@"reportDetectionData:channel:",CSClientGuardDetectionReports);
    if(CSClientGuardShouldApply(CSClientGuardTLSTrust,NO))
        JiDeBoolean(@"MMSecureTransport",@"evaluateServerTrust:forDomain:",CSClientGuardTLSTrust,YES,2);
    if(CSClientGuardShouldApply(CSClientGuardTLSPinning,NO)){
        JiDeObjectResult(@"MMSecureTransport",@"pinnedCertificates",CSClientGuardTLSPinning,YES);
        JiDeBoolean(@"MMSecureTransport",@"shouldPinRemoteCert:",CSClientGuardTLSPinning,NO,1);
    }
}
