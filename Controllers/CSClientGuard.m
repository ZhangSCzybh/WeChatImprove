#import "CSClientGuard.h"
#import "CSCloseFriendSignatures.h"
#include <stdatomic.h>
#include <dlfcn.h>
#include <sys/stat.h>
#include <errno.h>
#ifndef CS_CLIENT_GUARD_TESTING
#import <substrate.h>
#endif

NSString *const CSClientGuardEnabledKey=@"com.wechat.enhance.client_guard.enabled";
NSString *const CSClientGuardScopedKey=@"com.wechat.enhance.client_guard.scoped_queries";
NSString *const CSClientGuardChangedNotification=@"CSClientGuardChangedNotification";
static NSString *const VendorUUIDKey=@"com.wechat.enhance.client_guard.local_vendor_uuid";
static const uint64_t MasterBit=1ULL<<63, ScopedBit=1ULL<<62;
static atomic_uint_fast64_t CurrentPolicy;
static atomic_bool Started, RefreshQueued, ForceRefreshQueued;
static atomic_uint_fast64_t RestartChanges, Refreshes, SkippedRefreshes, ResourcePreparations;
typedef struct {
    atomic_uint_fast64_t observed;
    atomic_uint_fast64_t outcomes[CSClientGuardCallOutcomeCount];
    // Zero means no completed call; recorded outcomes use enum value + 1.
    atomic_uint lastOutcome;
} CSGuardObservation;
static CSGuardObservation Observations[28];
static uint64_t PolicyRevision, LastPublishedRevision;
static uint64_t PreparedResourcePolicy;
static _Thread_local unsigned ScopeDepth, BypassDepth, DiagnosticDepth;
static _Thread_local uint64_t ScopePolicy;
static NSUserDefaults *GuardDefaults;
static NSString *HostPath, *InfoPath;
static NSURL *LibraryURL, *ReceiptURL;
static NSDictionary *InfoView;
static NSUUID *VendorUUID;
static NSSet<NSString *> *ImageNames;
static NSMutableDictionary<NSString *,NSString *> *Statuses;
static NSMutableDictionary<NSString *,NSString *> *AttemptedEncodings;
static NSMutableSet<NSString *> *Installed;
static NSDictionary *LastSettings;
static NSString *PreparedHost, *PreparedLibrary;
static id VendorSourceValue;
static NSDate *LastCheckedAt;
#ifdef CS_CLIENT_GUARD_TESTING
static void (^BeforeRefreshResources)(void);
static NSString *TestHostVersion,*TestHostBuild;
#endif
static NSObject *GuardLock(void) { static NSObject *lock;static dispatch_once_t once;dispatch_once(&once,^{lock=[NSObject new];});return lock; }
static void RefreshPolicy(BOOL force);
static NSDictionary *HostIdentity(void) {
    DiagnosticDepth++;BypassDepth++;
    @try {
        @synchronized(GuardLock()) {
#ifdef CS_CLIENT_GUARD_TESTING
            if(TestHostVersion || TestHostBuild)return @{@"version":TestHostVersion?:@"未知",@"build":TestHostBuild?:@"未知"};
#endif
            NSDictionary *info=NSBundle.mainBundle.infoDictionary;
            id version=info[@"CFBundleShortVersionString"],build=info[@"CFBundleVersion"];
            return @{@"version":[version isKindOfClass:NSString.class]?[version copy]:@"未知",
                @"build":[build isKindOfClass:NSString.class]?[build copy]:@"未知"};
        }
    } @finally {BypassDepth--;DiagnosticDepth--;}
}
BOOL CSClientGuardHostMatches(NSString *version,NSString *build) {
    if(!version.length || !build.length)return NO;
    NSDictionary *identity=HostIdentity();
    return [identity[@"version"] isEqualToString:version] && [identity[@"build"] isEqualToString:build];
}
static NSDictionary *InterfaceIdentity(NSString *name) {
    if(name.length<5 || (![name hasPrefix:@"-["] && ![name hasPrefix:@"+["]) || ![name hasSuffix:@"]"])return nil;
    NSRange space=[name rangeOfString:@" "];if(space.location==NSNotFound || space.location<3)return nil;
    return @{@"class":[name substringWithRange:NSMakeRange(2,space.location-2)],
        @"selector":[name substringWithRange:NSMakeRange(space.location+1,name.length-space.location-2)],
        @"classMethod":@([name hasPrefix:@"+["])};
}
static NSArray<NSString *> *ExpectedSignatures(NSString *identity) {
    NSString *selector=InterfaceIdentity(identity)[@"selector"];if(!selector)return @[];
    NSDictionary *fixed=@{@"environment":@[@"@@:"],@"contentsOfDirectoryAtPath:error:":@[@"@@:@^@"],
        @"pathForResource:ofType:":@[@"@@:@@"],@"stringWithContentsOfFile:encoding:error:":@[@"@@:@Q^@"],
        @"dictionaryWithContentsOfFile:":@[@"@@:@"],@"appStoreReceiptURL":@[@"@@:"],
        @"checkHook:":@[@"v@:@"],@"checkConsistency:":@[@"v@:@"],@"checkHookWithSeq:":@[@"v@:I"],
        @"registerAddImageCallBack":@[@"v@:"],@"setMonitoring:":@[@"v@:i",@"v@:B"],
        @"syncSafetyPolicy:completion:":@[@"v@:@@?"],@"getStringExpt:":@[@"@@:@"],
        @"JailBroken":@[@"B@:"],@"IsJailBreak":@[@"B@:"],@"isHmdtEnable":@[@"B@:"],
        @"startTask:behaviorID:config:":@[@"v@:I@^{TaskConfig=I}"]};
    if(fixed[selector])return fixed[selector];
    if([@[@"getImageList",@"identifierForVendor",@"deviceEnvironmentReport",@"generateFingerprint",@"getBasicData",@"pinnedCertificates",@"detectionResult"] containsObject:selector])return @[@"@@:"];
    if([@[@"start",@"install",@"shouldEnterSafeMode",@"isJailbrokenDevice"] containsObject:selector])return @[@"B@:",@"c@:"];
    if([@[@"sendVerifyUserRequest:",@"shouldPinRemoteCert:"] containsObject:selector])return @[@"B@:@",@"c@:@"];
    if([selector isEqual:@"evaluateServerTrust:forDomain:"])return @[@"B@:@@",@"c@:@@"];
    if([@[@"runtimeEnvironmentType",@"currentRiskLevel"] containsObject:selector])return @[@"i@:",@"I@:",@"q@:",@"Q@:"];
    if([selector isEqual:@"checkAccountRiskLevel:"])return @[@"i@:@",@"I@:@",@"q@:@",@"Q@:@"];
    if([selector isEqual:@"startVerifyContact:opcode:verifyMsg:"])return @[@"B@:@i@",@"B@:@I@",@"B@:@q@",@"B@:@Q@",@"c@:@i@",@"c@:@I@",@"c@:@q@",@"c@:@Q@"];
    if([@[@"uploadFingerprintData:channel:",@"reportDetectionData:channel:"] containsObject:selector])return @[@"v@:@i",@"v@:@I",@"v@:@q",@"v@:@Q"];
    if([@[@"setCcData:",@"reportDeviceToken:",@"uploadSafetyLog:",@"reportAbnormalBehavior:"] containsObject:selector])return @[@"v@:@"];
    if([@[@"flushSecurityEvents",@"startDetection"] containsObject:selector])return @[@"v@:"];
    return @[];
}
static NSDictionary *ReadInterface(NSString *identity,NSString *status) {
    @synchronized(GuardLock()) {
    NSDictionary *parts=InterfaceIdentity(identity);if(!parts)return nil;
    Class hostClass=NSClassFromString(parts[@"class"]);
    BOOL classMethod=[parts[@"classMethod"] boolValue];
    SEL selector=NSSelectorFromString(parts[@"selector"]);
    Class cls=classMethod && hostClass?object_getClass(hostClass):hostClass;
    Method method=cls?class_getInstanceMethod(cls,selector):NULL;
    Method opposite=hostClass?class_getInstanceMethod(classMethod?hostClass:object_getClass(hostClass),selector):NULL;
    const char *actual=method?method_getTypeEncoding(method):NULL;
    const char *oppositeEncoding=opposite?method_getTypeEncoding(opposite):NULL;
    NSString *attemptedEncoding=AttemptedEncodings[identity];
    NSArray<NSString *> *expected=ExpectedSignatures(identity);
    if(!expected.count && attemptedEncoding.length)expected=@[attemptedEncoding];
    BOOL compatible=NO;
    for(NSString *encoding in expected)if(CSCloseFriendMethodMatches(method,encoding.UTF8String)){compatible=YES;break;}
    NSString *availabilityCode,*availabilityReason;
    if(!hostClass){availabilityCode=@"class-missing";availabilityReason=@"未找到目标类（可能未加载或当前版本未提供）";}
    else if(!method && opposite){
        availabilityCode=@"opposite-method-only";
        availabilityReason=classMethod?@"未找到目标类方法，仅发现同名实例方法":@"未找到目标实例方法，仅发现同名类方法";
    }
    else if(!method){availabilityCode=@"method-missing";availabilityReason=classMethod?@"类存在，未找到目标类方法":@"类存在，未找到目标实例方法";}
    else if(expected.count && !compatible){availabilityCode=@"signature-unsupported";availabilityReason=@"目标接口存在，签名不兼容";}
    else {availabilityCode=@"available";availabilityReason=@"目标接口存在";}
    BOOL installed=[Installed containsObject:identity];
    NSString *installationCode=installed?@"installed":!status?@"not-attempted":
        ![availabilityCode isEqual:@"available"]?availabilityCode:@"available-not-installed";
    NSString *displayStatus=status?:@"尚未尝试安装";
    if(!installed && status && ([status containsString:@"无此接口"] || [status containsString:@"签名不兼容"]))
        displayStatus=[availabilityCode isEqual:@"available"]?@"当前接口已可用，尚未安装；请刷新重检":
            [availabilityReason stringByAppendingString:@"，未安装"];
    NSMutableDictionary *record=[@{@"identity":identity,@"actualEncoding":actual?[NSString stringWithUTF8String:actual]:@"未找到接口",
        @"expectedEncodings":expected,@"attemptedEncoding":attemptedEncoding?:@"",
        @"status":displayStatus,
        @"classFound":@(hostClass!=Nil),@"methodFound":@(method!=NULL),@"classMethod":@(classMethod),
        @"oppositeMethodAvailable":@(opposite!=NULL),
        @"oppositeEncoding":oppositeEncoding?[NSString stringWithUTF8String:oppositeEncoding]:@"",
        @"availabilityCode":availabilityCode,@"availabilityReason":availabilityReason,
        @"installationCode":installationCode,@"installed":@(installed)} mutableCopy];
    BOOL verifiedJailbreak=[parts[@"class"] isEqual:@"JailBreakHelper"] &&
        [@[@"JailBroken",@"IsJailBreak"] containsObject:parts[@"selector"]];
    BOOL verifiedDetection=[parts[@"class"] isEqual:@"WCSHmdtMgr"] &&
        [@[@"isHmdtEnable",@"startTask:behaviorID:config:"] containsObject:parts[@"selector"]];
    if(verifiedJailbreak || verifiedDetection){
        record[@"supportedHostVersion"]=@"8.0.80";record[@"supportedHostBuild"]=@"8.0.80.34";
        record[@"hostMatched"]=@(CSClientGuardHostMatches(@"8.0.80",@"8.0.80.34"));
    }
    return [record copy];
    }
}

static NSArray<NSDictionary *> *EnrichOptions(NSArray<NSDictionary *> *options) {
    NSArray *groups=@[
        @[@"环境与资源查询",@[@"environment",@"frameworks",@"provision_path",@"provision_read",@"bundle_info",@"receipt"]],
        @[@"客户端检查",@[@"checks",@"images"]],@[@"好友验证范围",@[@"friend_scope"]],
        @[@"设备与检测数据",@[@"vendor_id",@"device_checks",@"device_report",@"fingerprint_data",@"basic_data",@"cc_data"]],
        @[@"本地风险与策略",@[@"risk_results",@"policy_completion",@"detection_results"]],
        @[@"检测与日志上报（实验）",@[@"device_reports",@"safety_reports",@"behavior_reports",@"detection_reports",@"experiment_reports"]],
        @[@"监控与安全模式",@[@"crash_block",@"crash_monitor",@"safe_mode"]],
        @[@"证书校验（实验）",@[@"tls_trust",@"tls_pinning"]]
    ];
    NSDictionary *interfaces=@{
        @"environment":@[@"-[NSProcessInfo environment]"],
        @"frameworks":@[@"-[NSFileManager contentsOfDirectoryAtPath:error:]"],
        @"provision_path":@[@"-[NSBundle pathForResource:ofType:]"],
        @"provision_read":@[@"+[NSString stringWithContentsOfFile:encoding:error:]"],
        @"bundle_info":@[@"-[NSBundle pathForResource:ofType:]",@"+[NSDictionary dictionaryWithContentsOfFile:]"],
        @"receipt":@[@"-[NSBundle appStoreReceiptURL]"],
        @"checks":@[@"-[ClientCheckMgr checkHook:]",@"-[ClientCheckMgr checkConsistency:]",@"-[ClientCheckMgr checkHookWithSeq:]",@"-[ClientCheckMgr registerAddImageCallBack]"],
        @"images":@[@"-[ClientCheckMgr getImageList]"],@"vendor_id":@[@"-[QIDevice identifierForVendor]"],
        @"crash_block":@[@"-[WCCrashBlockMonitorPlugin start]"],
        @"crash_monitor":@[@"-[KSCrash install]",@"-[KSCrash setMonitoring:]"],
        @"safe_mode":@[@"-[MMSafeModeMgr shouldEnterSafeMode]"],
        @"friend_scope":@[@"-[NormalContactVerifyLogic sendVerifyUserRequest:]",@"-[NormalContactVerifyLogic startVerifyContact:opcode:verifyMsg:]"],
        @"device_checks":@[@"-[MMDeviceInfoManager isJailbrokenDevice]",@"-[MMDeviceInfoManager runtimeEnvironmentType]",
            @"+[JailBreakHelper JailBroken]",@"-[JailBreakHelper IsJailBreak]"],
        @"device_report":@[@"-[MMDeviceInfoManager deviceEnvironmentReport]"],
        @"fingerprint_data":@[@"-[MMFPManager generateFingerprint]"],
        @"basic_data":@[@"-[MMClientCacheManager getBasicData]"],
        @"risk_results":@[@"-[MMAccountSafeManager checkAccountRiskLevel:]",@"-[MMAccountSafeManager currentRiskLevel]"],
        @"policy_completion":@[@"-[MMAccountSafeManager syncSafetyPolicy:completion:]"],
        @"cc_data":@[@"-[WCExtInfo setCcData:]"],
        @"device_reports":@[@"-[MMFPManager reportDeviceToken:]",@"-[MMFPManager uploadFingerprintData:channel:]"],
        @"safety_reports":@[@"-[MMAccountSafeManager uploadSafetyLog:]"],
        @"behavior_reports":@[@"-[MMBehaviorAnalytics reportAbnormalBehavior:]",@"-[MMBehaviorAnalytics flushSecurityEvents]"],
        @"detection_results":@[@"-[HMDTManager startDetection]",@"-[HMDTManager detectionResult]",
            @"-[WCSHmdtMgr isHmdtEnable]",@"-[WCSHmdtMgr startTask:behaviorID:config:]"],
        @"detection_reports":@[@"-[HMDTManager reportDetectionData:channel:]"],
        @"experiment_reports":@[@"-[ExptService getStringExpt:]"],
        @"tls_trust":@[@"-[MMSecureTransport evaluateServerTrust:forDomain:]"],
        @"tls_pinning":@[@"-[MMSecureTransport pinnedCertificates]",@"-[MMSecureTransport shouldPinRemoteCert:]"]
    };
    NSSet *scoped=[NSSet setWithArray:@[@"environment",@"frameworks",@"provision_path",@"provision_read",@"bundle_info",@"receipt",@"vendor_id"]];
    NSSet *restart=[NSSet setWithArray:@[@"crash_block",@"crash_monitor",@"safe_mode",@"detection_results"]];
    NSMutableArray *result=[NSMutableArray arrayWithCapacity:options.count];
    for(NSDictionary *option in options) {
        NSMutableDictionary *row=[option mutableCopy];NSString *identifier=row[@"identifier"];
        for(NSUInteger section=0;section<groups.count;section++) {
            NSUInteger order=[groups[section][1] indexOfObject:identifier];
            if(order!=NSNotFound){row[@"section"]=groups[section][0];row[@"sectionOrder"]=@(section+1);row[@"order"]=@(order);break;}
        }
        row[@"scopedQuery"]=@([scoped containsObject:identifier]);
        row[@"dependencies"]=[identifier isEqual:@"friend_scope"]?scoped.allObjects:@[];
        row[@"resource"]=[identifier isEqual:@"bundle_info"]?@"siri":([identifier isEqual:@"vendor_id"]?@"vendor":([identifier isEqual:@"receipt"]?@"receipt":@"none"));
        row[@"restartRequired"]=@([restart containsObject:identifier]);
        row[@"interfaces"]=interfaces[identifier]?:@[];
        [result addObject:[row copy]];
    }
    return [result copy];
}

NSArray<NSDictionary *> *CSClientGuardOptions(void) {
    static NSArray *rows;static dispatch_once_t once;
    dispatch_once(&once,^{
        rows=EnrichOptions(@[
            @{@"identifier":@"environment",@"title":@"隐藏注入环境变量",@"detail":@"仅过滤 environment 返回字典中的 DYLD_INSERT_LIBRARIES。",@"capability":@(CSClientGuardEnvironment),@"experimental":@NO},
            @{@"identifier":@"frameworks",@"title":@"隐藏 Frameworks 枚举",@"detail":@"主包 Frameworks 目录查询返回空列表，不删除文件。",@"capability":@(CSClientGuardFrameworks),@"experimental":@NO},
            @{@"identifier":@"provision_path",@"title":@"隐藏描述文件路径",@"detail":@"主包资源查询不返回 embedded.mobileprovision。",@"capability":@(CSClientGuardProvisionPath),@"experimental":@NO},
            @{@"identifier":@"provision_read",@"title":@"拦截描述文件文本读取",@"detail":@"NSString 读取主包描述文件时返回不存在；不拦截 NSData。",@"capability":@(CSClientGuardProvisionRead),@"experimental":@NO},
            @{@"identifier":@"bundle_info",@"title":@"替换包信息文件查询",@"detail":@"使用可用的 siri.plist；缺失或无效时保留原查询。",@"capability":@(CSClientGuardBundleInfo),@"experimental":@NO},
            @{@"identifier":@"receipt",@"title":@"替换收据查询路径",@"detail":@"返回 Library/StoreKit/receipt 路径，不生成或验证收据。",@"capability":@(CSClientGuardReceipt),@"experimental":@NO},
            @{@"identifier":@"checks",@"title":@"跳过客户端检查",@"detail":@"跳过四个签名匹配的检查入口；关闭时保留检查并限定下游查询。",@"capability":@(CSClientGuardChecks),@"experimental":@NO},
            @{@"identifier":@"images",@"title":@"过滤检查模块列表",@"detail":@"仅过滤 ClientCheckMgr.getImageList 返回值中的指定模块名。",@"capability":@(CSClientGuardImages),@"experimental":@NO},
            @{@"identifier":@"vendor_id",@"title":@"替换检查用 IDFV",@"detail":@"仅作用于 QIDevice；使用本机持久 UUID，不随切号或重置轮换。",@"capability":@(CSClientGuardVendorID),@"experimental":@YES},
            @{@"identifier":@"crash_block",@"title":@"跳过卡顿监控启动",@"detail":@"跳过后不会补放启动；关闭此项后需重启微信恢复初始化。",@"capability":@(CSClientGuardCrashBlock),@"experimental":@YES},
            @{@"identifier":@"crash_monitor",@"title":@"跳过崩溃监控安装",@"detail":@"跳过 KSCrash 安装及监控设置；保留已有报告，恢复需重启。",@"capability":@(CSClientGuardCrashMonitor),@"experimental":@YES},
            @{@"identifier":@"safe_mode",@"title":@"阻止进入安全模式",@"detail":@"将安全模式判断改为否，可能影响故障恢复；关闭后需重启。",@"capability":@(CSClientGuardSafeMode),@"experimental":@YES},
            @{@"identifier":@"friend_scope",@"title":@"好友验证查询范围",@"detail":@"保留原好友请求和参数，将同步验证过程纳入已开启的查询范围。",@"capability":@(CSClientGuardFriendScope),@"experimental":@NO},
            @{@"identifier":@"device_checks",@"title":@"替换本地环境检测结果",@"detail":@"8.0.80.34 接入本地越狱判断并保留原检查副作用；其他环境接口按兼容接入，不更改系统环境。",@"capability":@(CSClientGuardDeviceChecks),@"experimental":@YES},
            @{@"identifier":@"device_report",@"title":@"过滤设备环境字段",@"detail":@"复制检测字典并移除三项已知环境字段；其他类型保留原结果。",@"capability":@(CSClientGuardDeviceReport),@"experimental":@NO},
            @{@"identifier":@"fingerprint_data",@"title":@"过滤指纹异常字段",@"detail":@"仅在字典结果的副本中移除 jb_indicator，保留其他字段。",@"capability":@(CSClientGuardFingerprintData),@"experimental":@NO},
            @{@"identifier":@"basic_data",@"title":@"屏蔽基础检测数据",@"detail":@"仅对 MMClientCacheManager.getBasicData 返回空值。",@"capability":@(CSClientGuardBasicData),@"experimental":@YES},
            @{@"identifier":@"risk_results",@"title":@"替换本地风险结果",@"detail":@"只替换两个已匹配接口的本地结果，不改变服务器风险状态。",@"capability":@(CSClientGuardRiskResults),@"experimental":@YES},
            @{@"identifier":@"policy_completion",@"title":@"替代安全策略完成回调",@"detail":@"校验完成回调签名后返回成功；不执行原同步，不能代表服务端成功。",@"capability":@(CSClientGuardPolicyCompletion),@"experimental":@YES},
            @{@"identifier":@"cc_data",@"title":@"拦截扩展检测数据",@"detail":@"跳过 WCExtInfo.setCcData:；不修改好友请求中的扩展反垃圾字段。",@"capability":@(CSClientGuardCCData),@"experimental":@YES},
            @{@"identifier":@"device_reports",@"title":@"拦截设备与指纹上报",@"detail":@"跳过已匹配的令牌与指纹上报入口，关闭后恢复未来调用。",@"capability":@(CSClientGuardDeviceReports),@"experimental":@YES},
            @{@"identifier":@"safety_reports",@"title":@"拦截安全日志上报",@"detail":@"跳过 MMAccountSafeManager.uploadSafetyLog:。",@"capability":@(CSClientGuardSafetyReports),@"experimental":@YES},
            @{@"identifier":@"behavior_reports",@"title":@"拦截异常行为上报",@"detail":@"跳过异常行为报告和安全事件刷新入口。",@"capability":@(CSClientGuardBehaviorReports),@"experimental":@YES},
            @{@"identifier":@"detection_results",@"title":@"屏蔽本地检测结果",@"detail":@"8.0.80.34 拦截 WCS 新任务（含直播采样）；已运行任务不撤销，旧结果接口按兼容接入。",@"capability":@(CSClientGuardDetectionResults),@"experimental":@YES},
            @{@"identifier":@"detection_reports",@"title":@"拦截检测数据上报",@"detail":@"跳过 HMDTManager 已匹配的数据上报入口。",@"capability":@(CSClientGuardDetectionReports),@"experimental":@YES},
            @{@"identifier":@"experiment_reports",@"title":@"关闭运行时上报配置",@"detail":@"仅替换已核实的两项字符串配置；其他配置查询保留原方法。",@"capability":@(CSClientGuardExperimentReports),@"experimental":@YES},
            @{@"identifier":@"tls_trust",@"title":@"放宽证书信任判断",@"detail":@"对目标接口返回信任，会降低证书验证约束；默认关闭。",@"capability":@(CSClientGuardTLSTrust),@"experimental":@YES},
            @{@"identifier":@"tls_pinning",@"title":@"停用证书固定校验",@"detail":@"目标接口返回空固定证书列表并停用 pin 判断；默认关闭。",@"capability":@(CSClientGuardTLSPinning),@"experimental":@YES}
        ]);
    });return rows;
}
NSString *CSClientGuardPreferenceKey(NSString *identifier) { return [@"com.wechat.enhance.client_guard." stringByAppendingString:identifier]; }
static NSUserDefaults *Defaults(void) { return GuardDefaults?:NSUserDefaults.standardUserDefaults; }
BOOL CSClientGuardSetting(NSString *key) {
    id value=[Defaults() objectForKey:key];
    if(!value)return [key isEqual:CSClientGuardScopedKey];
    BOOL valid=[value isKindOfClass:NSNumber.class] && ([value isEqual:@YES] || [value isEqual:@NO]);
    if(!valid)return [key isEqual:CSClientGuardScopedKey];
    return [value boolValue];
}
static NSDictionary *RelevantSettings(void) {
    NSMutableDictionary *values=[NSMutableDictionary dictionaryWithDictionary:@{
        CSClientGuardEnabledKey:@(CSClientGuardSetting(CSClientGuardEnabledKey)),
        CSClientGuardScopedKey:@(CSClientGuardSetting(CSClientGuardScopedKey))}];
    for(NSDictionary *row in CSClientGuardOptions()) {
        NSString *key=CSClientGuardPreferenceKey(row[@"identifier"]);values[key]=@(CSClientGuardSetting(key));
    }
    values[VendorUUIDKey]=[Defaults() objectForKey:VendorUUIDKey]?:NSNull.null;
    return [values copy];
}
static void RequestRefresh(BOOL force) {
    if(!atomic_load_explicit(&Started,memory_order_acquire))return;
    if(force)atomic_store_explicit(&ForceRefreshQueued,true,memory_order_release);
    if(atomic_exchange_explicit(&RefreshQueued,true,memory_order_acq_rel))return;
    dispatch_async(dispatch_get_main_queue(),^{
        atomic_store_explicit(&RefreshQueued,false,memory_order_release);
        RefreshPolicy(atomic_exchange_explicit(&ForceRefreshQueued,false,memory_order_acq_rel));
    });
}
void CSClientGuardSetSetting(NSString *key,BOOL value) {
    NSMutableSet *keys=[NSMutableSet setWithArray:@[CSClientGuardEnabledKey,CSClientGuardScopedKey]];
    uint64_t capability=0;
    for(NSDictionary *row in CSClientGuardOptions()) {
        NSString *optionKey=CSClientGuardPreferenceKey(row[@"identifier"]);
        [keys addObject:optionKey];
        if([key isEqual:optionKey])capability=[row[@"capability"] unsignedLongLongValue];
    }
    if(![keys containsObject:key])return;
    @synchronized(GuardLock()) {
        BOOL changed=CSClientGuardSetting(key)!=value;
        [Defaults() setBool:value forKey:key];PolicyRevision++;
        if(changed && capability)for(NSDictionary *row in CSClientGuardOptions())
            if([row[@"capability"] unsignedLongLongValue]==capability && [row[@"restartRequired"] boolValue])
                atomic_fetch_or_explicit(&RestartChanges,capability,memory_order_relaxed);
        // Publication shares this short lock with refresh, so a refresh that
        // started before this request can never reactivate a disabled policy.
        if([key isEqual:CSClientGuardEnabledKey] && !value)atomic_store_explicit(&CurrentPolicy,0,memory_order_release);
        else if(!value && capability)atomic_fetch_and_explicit(&CurrentPolicy,~capability,memory_order_acq_rel);
    }
    RequestRefresh(NO);
}
void CSClientGuardWithCheckScope(void (NS_NOESCAPE ^work)(void)) {
    if(!work)return;
    uint64_t old=ScopePolicy;
    if(!ScopeDepth)ScopePolicy=atomic_load_explicit(&CurrentPolicy,memory_order_acquire);
    ScopeDepth++;
    @try {work();}@finally {ScopeDepth--;ScopePolicy=old;}
}
void CSClientGuardWithoutOverrides(void (NS_NOESCAPE ^work)(void)) {
    if(!work)return;BypassDepth++;@try {work();}@finally {BypassDepth--;}
}
BOOL CSClientGuardShouldApply(CSClientGuardCapability capability,BOOL scopedQuery) {
    uint64_t current=atomic_load_explicit(&CurrentPolicy,memory_order_acquire);
    if(BypassDepth || !(current&MasterBit))return NO;
    uint64_t policy=ScopeDepth?ScopePolicy:current;
    // A scope cannot gain newly enabled capabilities mid-call; current policy
    // can still revoke an individual capability when its setting is disabled.
    return (current&capability)!=0 && (policy&capability)!=0 && (!scopedQuery || !(policy&ScopedBit) || ScopeDepth>0);
}
static int ObservationIndex(CSClientGuardCapability capability) {
    uint64_t value=(uint64_t)capability;
    if(!value || (value&(value-1)) || value>=(1ULL<<28))return -1;
    return __builtin_ctzll(value);
}
static void StoreOutcome(CSGuardObservation *state,CSClientGuardCallOutcome outcome) {
    if(outcome>=CSClientGuardCallOutcomeCount)return;
    atomic_fetch_add_explicit(&state->outcomes[outcome],1,memory_order_relaxed);
    atomic_store_explicit(&state->lastOutcome,(unsigned)outcome+1,memory_order_relaxed);
}
BOOL CSClientGuardEvaluateCall(CSClientGuardCapability capability,BOOL scopedQuery) {
    if(DiagnosticDepth)return NO;
    int index=ObservationIndex(capability);if(index<0)return NO;
    CSGuardObservation *state=&Observations[index];
    atomic_fetch_add_explicit(&state->observed,1,memory_order_relaxed);
    uint64_t current=atomic_load_explicit(&CurrentPolicy,memory_order_acquire);
    uint64_t policy=ScopeDepth?ScopePolicy:current;
    if(BypassDepth){StoreOutcome(state,CSClientGuardCallBypassed);return NO;}
    if(!(current&MasterBit) || !(current&capability) || !(policy&capability)){
        StoreOutcome(state,CSClientGuardCallDisabled);return NO;
    }
    if(scopedQuery && (policy&ScopedBit) && !ScopeDepth){StoreOutcome(state,CSClientGuardCallOutOfScope);return NO;}
    return YES;
}
void CSClientGuardRecordOutcome(CSClientGuardCapability capability,CSClientGuardCallOutcome outcome) {
    int index=ObservationIndex(capability);if(index>=0)StoreOutcome(&Observations[index],outcome);
}
NSString *CSClientGuardHostBundlePath(void) { @synchronized(GuardLock()){return HostPath?:@"";} }
NSString *CSClientGuardReplacementInfoPath(void) { @synchronized(GuardLock()){return InfoPath;} }
NSDictionary *CSClientGuardReplacementInfo(void) { @synchronized(GuardLock()){return InfoView;} }
NSURL *CSClientGuardReceiptURL(void) { @synchronized(GuardLock()){return ReceiptURL;} }
NSUUID *CSClientGuardVendorUUID(void) { @synchronized(GuardLock()){return VendorUUID;} }
NSSet<NSString *> *CSClientGuardImageNames(void) { @synchronized(GuardLock()){return ImageNames?:[NSSet set];} }
void CSClientGuardRecordStatus(NSString *name,NSString *status) {
    @synchronized(GuardLock()){
        if(!Statuses)Statuses=[NSMutableDictionary dictionary];Statuses[name]=status;
    }
}
static NSDictionary<NSString *,NSString *> *StatusSnapshot(void) { @synchronized(GuardLock()){return [Statuses copy]?:@{};} }
BOOL CSClientGuardInstallHook(NSString *className,NSString *name,BOOL classMethod,const char *encoding,IMP replacement,IMP *original) {
    NSString *identity=[NSString stringWithFormat:@"%c[%@ %@]",classMethod?'+':'-',className,name];
    @synchronized(GuardLock()) {
        if(!(atomic_load_explicit(&CurrentPolicy,memory_order_acquire)&MasterBit)){if(replacement)imp_removeBlock(replacement);return NO;}
        if(!Installed)Installed=[NSMutableSet set];
        if([Installed containsObject:identity]){imp_removeBlock(replacement);return YES;}
        Class cls=NSClassFromString(className);if(classMethod && cls)cls=object_getClass(cls);
        SEL selector=NSSelectorFromString(name);Method method=cls?class_getInstanceMethod(cls,selector):NULL;
        if(!AttemptedEncodings)AttemptedEncodings=[NSMutableDictionary dictionary];
        AttemptedEncodings[identity]=encoding?[NSString stringWithUTF8String:encoding]:@"";
        if(!replacement || !original || !CSCloseFriendMethodMatches(method,encoding)) {
            if(replacement)imp_removeBlock(replacement);
            CSClientGuardRecordStatus(identity,method?@"接口签名不兼容，未安装":@"当前宿主无此接口，未安装");return NO;
        }
        IMP predecessor=method_getImplementation(method);
        *original=predecessor;
        // Once installation is attempted, never wrap it again on a refresh,
        // including the exceptional case where the engine omits its predecessor.
        [Installed addObject:identity];
#ifdef CS_CLIENT_GUARD_TESTING
        CSClientGuardTestHookMessage(cls,selector,replacement,original);
#else
        MSHookMessageEx(cls,selector,replacement,original);
#endif
        if(!*original){*original=predecessor;CSClientGuardRecordStatus(identity,@"原调用链未返回，保留安装前链路；需重启核查");return NO;}
        CSClientGuardRecordStatus(identity,@"已安装；仅已开启策略改变行为");return YES;
    }
}
static void PrepareResources(uint64_t policy,BOOL force) {
#ifdef CS_CLIENT_GUARD_TESTING
    void (^probe)(void)=BeforeRefreshResources;BeforeRefreshResources=nil;if(probe)probe();
#endif
    CSClientGuardWithoutOverrides(^{
        NSString *libraryPath=LibraryURL.path?:@"";
        BOOL contextChanged=![PreparedHost isEqual:HostPath] || ![PreparedLibrary isEqual:libraryPath];
        uint64_t resourceBits=CSClientGuardBundleInfo|CSClientGuardVendorID|CSClientGuardReceipt;
        uint64_t requested=policy&resourceBits;
        id vendorSource=[Defaults() objectForKey:VendorUUIDKey]?:NSNull.null;
        BOOL infoCheck=(requested&CSClientGuardBundleInfo) && (force || contextChanged || !(PreparedResourcePolicy&CSClientGuardBundleInfo));
        BOOL vendorCheck=(requested&CSClientGuardVendorID) && (force || contextChanged || !(PreparedResourcePolicy&CSClientGuardVendorID) || ![vendorSource isEqual:VendorSourceValue]);
        if(force || contextChanged || requested!=PreparedResourcePolicy || vendorCheck || !ImageNames)
            atomic_fetch_add_explicit(&ResourcePreparations,1,memory_order_relaxed);
        NSString *infoPath=(requested&CSClientGuardBundleInfo)?InfoPath:nil;
        NSDictionary *info=(requested&CSClientGuardBundleInfo)?InfoView:nil;
        if(infoCheck) {
            infoPath=nil;info=nil;
            NSArray *paths=@[[HostPath stringByAppendingPathComponent:@"siri.plist"],
                [[LibraryURL URLByAppendingPathComponent:@"Preferences/WeChatImprove/ClientGuard/siri.plist"] path]?:@""];
            for(NSString *path in paths) {
                NSData *data=[NSData dataWithContentsOfFile:path];
                id value=data?[NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:NULL]:nil;
                if([value isKindOfClass:NSDictionary.class] && [value count]){infoPath=path;info=[value copy];break;}
            }
        }
        if(requested&CSClientGuardBundleInfo)
            CSClientGuardRecordStatus(@"包信息替换资源",info?@"已读取 siri.plist；仅替换指定文件查询":@"未找到有效 siri.plist，保留原查询");
        else CSClientGuardRecordStatus(@"包信息替换资源",@"能力未开启，未使用备用包信息");
        NSUUID *vendor=(requested&CSClientGuardVendorID)?VendorUUID:nil;
        if(vendorCheck) {
            vendor=nil;id value=[Defaults() objectForKey:VendorUUIDKey];
            if([value isKindOfClass:NSString.class])vendor=[[NSUUID alloc]initWithUUIDString:value];
            if(!value){vendor=NSUUID.UUID;[Defaults() setObject:vendor.UUIDString forKey:VendorUUIDKey];}
            VendorSourceValue=[Defaults() objectForKey:VendorUUIDKey]?:NSNull.null;
            if(!vendor)CSClientGuardRecordStatus(@"本机 IDFV",@"本机值格式无效，保留原 IDFV");
            else CSClientGuardRecordStatus(@"本机 IDFV",@"本机标识已准备，不随备份迁移");
        }
        NSSet *names=ImageNames;
        if(!names) {
            NSMutableSet *discovered=[NSMutableSet setWithArray:@[@"frida",@"substitute",@"libsubstrate",@"DebugHierarchyFoundation",@"libViewDebuggerSupport.dylib",@"libMTLCapture.dylib",@"libBacktraceRecording.dylib",@"DanceMonkey"]];
            Dl_info location={0};if(dladdr((const void *)&CSClientGuardStart,&location) && location.dli_fname) {
                NSString *path=[NSString stringWithUTF8String:location.dli_fname];if(path.lastPathComponent.length)[discovered addObject:path.lastPathComponent];
            }
            names=[discovered copy];
        }
        NSURL *receipt=LibraryURL.isFileURL?[LibraryURL URLByAppendingPathComponent:@"StoreKit/receipt"]:nil;
        @synchronized(GuardLock()) {
            InfoPath=[infoPath copy];InfoView=info;ReceiptURL=receipt;VendorUUID=vendor;ImageNames=names;
            PreparedResourcePolicy=requested;PreparedHost=[HostPath copy];PreparedLibrary=[libraryPath copy];
        }
    });
}
static void RefreshPolicy(BOOL force) {
    if(!atomic_load_explicit(&Started,memory_order_acquire))return;
    if(!NSThread.isMainThread){RequestRefresh(force);return;}
    uint64_t policy=0,revision;NSDictionary *settings;
    @synchronized(GuardLock()) {
        settings=RelevantSettings();revision=PolicyRevision;
        if(!force && revision==LastPublishedRevision && [settings isEqual:LastSettings]){
            atomic_fetch_add_explicit(&SkippedRefreshes,1,memory_order_relaxed);return;
        }
        if(LastSettings)for(NSDictionary *row in CSClientGuardOptions()) {
            NSString *key=CSClientGuardPreferenceKey(row[@"identifier"]);
            if([row[@"restartRequired"] boolValue] && ![settings[key] isEqual:LastSettings[key]])
                atomic_fetch_or_explicit(&RestartChanges,[row[@"capability"] unsignedLongLongValue],memory_order_relaxed);
        }
        if(CSClientGuardSetting(CSClientGuardEnabledKey)) {
            policy=MasterBit;if(CSClientGuardSetting(CSClientGuardScopedKey))policy|=ScopedBit;
            for(NSDictionary *row in CSClientGuardOptions())if(CSClientGuardSetting(CSClientGuardPreferenceKey(row[@"identifier"])))policy|=[row[@"capability"] unsignedLongLongValue];
        }
    }
    atomic_fetch_add_explicit(&Refreshes,1,memory_order_relaxed);
    CSClientGuardWithoutOverrides(^{
        if(!HostPath)HostPath=[NSBundle.mainBundle.bundlePath copy];
        if(!LibraryURL)LibraryURL=[NSFileManager.defaultManager URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask].firstObject;
    });
    BOOL contextValid=HostPath.length && HostPath.isAbsolutePath && LibraryURL.isFileURL &&
        LibraryURL.path.length && LibraryURL.path.isAbsolutePath;
    NSString *disabledPath=contextValid?[[LibraryURL URLByAppendingPathComponent:@"Preferences/WeChatImprove/ClientGuard/disabled"] path]:nil;
    struct stat marker;BOOL forcedOff=!disabledPath.length;
    if(disabledPath.length){int result=lstat(disabledPath.fileSystemRepresentation,&marker);forcedOff=result==0 || errno!=ENOENT;}
    if(forcedOff){
        policy=0;
        CSClientGuardRecordStatus(@"本机停用标记",contextValid?@"已停用干预；移除本机 disabled 标记并重启后再检查":
            @"无法确认本地宿主与容器路径，已停用干预；未生成替代标识");
    }
    else CSClientGuardRecordStatus(@"本机停用标记",@"未设置");
    PrepareResources(policy,force);
    @synchronized(GuardLock()) {
        if(revision!=PolicyRevision){RequestRefresh(NO);return;}
        // The UUID may have been initialized by resource preparation. Capture
        // that one owned write without hiding a concurrent user-choice change.
        NSMutableDictionary *current=[RelevantSettings() mutableCopy];
        NSMutableDictionary *expected=[settings mutableCopy];
        expected[VendorUUIDKey]=(policy&CSClientGuardVendorID)?(VendorSourceValue?:settings[VendorUUIDKey]):settings[VendorUUIDKey];
        if(![current isEqual:expected]){RequestRefresh(NO);return;}
        LastSettings=[current copy];LastCheckedAt=NSDate.date;LastPublishedRevision=revision;
        atomic_store_explicit(&CurrentPolicy,policy,memory_order_release);
    }
    if(policy&MasterBit){
        CSClientGuardInstallQueryHooks();CSClientGuardInstallNativeHooks();
        CSClientGuardInstallJiDeNativeHooks();CSClientGuardInstallJiDeQueryHooks();
    }
    [NSNotificationCenter.defaultCenter postNotificationName:CSClientGuardChangedNotification object:nil];
}
void CSClientGuardRefresh(void) { RefreshPolicy(YES); }
void CSClientGuardStart(void) {
    if(atomic_exchange_explicit(&Started,true,memory_order_acq_rel))return;
    if(!GuardDefaults)GuardDefaults=NSUserDefaults.standardUserDefaults;
    [NSNotificationCenter.defaultCenter addObserverForName:NSUserDefaultsDidChangeNotification object:nil queue:nil
        usingBlock:^(__unused NSNotification *note){RequestRefresh(NO);}];
    [NSNotificationCenter.defaultCenter addObserverForName:@"UIApplicationDidBecomeActiveNotification" object:nil queue:nil
        usingBlock:^(__unused NSNotification *note){RequestRefresh(YES);}];
    CSClientGuardRefresh();
}
static NSString *OutcomeName(NSUInteger outcome) {
    NSArray *names=@[@"已应用",@"能力或总策略关闭",@"不在同步检查范围",@"内部旁路",@"资源未就绪",
        @"返回值或副本不兼容",@"完成回调不兼容",@"查询条件未匹配",@"原方法或回调异常"];
    return outcome<names.count?names[outcome]:@"未知";
}
NSDictionary *CSClientGuardSessionSnapshot(void) {
    DiagnosticDepth++;BypassDepth++;
    @try {
    NSDictionary *identity=HostIdentity();
    @synchronized(GuardLock()) {
        return @{@"version":identity[@"version"],@"build":identity[@"build"],@"checkedAt":LastCheckedAt?:NSNull.null,
            @"refreshes":@(atomic_load_explicit(&Refreshes,memory_order_relaxed)),
            @"skippedRefreshes":@(atomic_load_explicit(&SkippedRefreshes,memory_order_relaxed)),
            @"resourcePreparations":@(atomic_load_explicit(&ResourcePreparations,memory_order_relaxed))};
    }
    } @finally {BypassDepth--;DiagnosticDepth--;}
}
NSArray<NSDictionary *> *CSClientGuardCapabilityStates(void) {
    DiagnosticDepth++;BypassDepth++;
    @try {
    uint64_t policy=atomic_load_explicit(&CurrentPolicy,memory_order_acquire);
    uint64_t restart=atomic_load_explicit(&RestartChanges,memory_order_relaxed);
    NSMutableArray *states=[NSMutableArray arrayWithCapacity:28];
    @synchronized(GuardLock()) {
        for(NSDictionary *option in CSClientGuardOptions()) {
            NSMutableDictionary *state=[option mutableCopy];
            CSClientGuardCapability capability=[option[@"capability"] unsignedLongLongValue];
            CSGuardObservation *observation=&Observations[ObservationIndex(capability)];
            uint64_t observed=atomic_load_explicit(&observation->observed,memory_order_relaxed),applied=0,fallback=0;
            NSMutableDictionary *outcomes=[NSMutableDictionary dictionary];
            for(NSUInteger i=0;i<CSClientGuardCallOutcomeCount;i++) {
                uint64_t value=atomic_load_explicit(&observation->outcomes[i],memory_order_relaxed);outcomes[@(i)]=@(value);
                if(i==CSClientGuardCallApplied)applied=value;else fallback+=value;
            }
            unsigned lastOutcome=atomic_load_explicit(&observation->lastOutcome,memory_order_relaxed);
            state[@"configured"]=@(CSClientGuardSetting(CSClientGuardPreferenceKey(option[@"identifier"])));
            state[@"published"]=@((policy&MasterBit) && (policy&capability));
            state[@"observed"]=@(observed);state[@"applied"]=@(applied);state[@"fallback"]=@(fallback);state[@"outcomes"]=[outcomes copy];
            state[@"lastOutcome"]=lastOutcome?OutcomeName(lastOutcome-1):@"尚无完成记录";
            state[@"restartPending"]=@((restart&capability)!=0);
            BOOL ready=YES;NSString *resourceStatus=@"无需外部资源";
            NSString *resource=option[@"resource"];
            if([resource isEqual:@"siri"]){ready=InfoView.count>0 && InfoPath.length>0;resourceStatus=ready?@"siri.plist 已就绪":@"缺少有效 siri.plist，保留原查询";}
            else if([resource isEqual:@"vendor"]){ready=VendorUUID!=nil;resourceStatus=ready?@"本机替代标识已就绪":@"替代标识未就绪，保留原标识";}
            else if([resource isEqual:@"receipt"]){ready=ReceiptURL.isFileURL;resourceStatus=ready?@"仅替换收据路径，不代表有效收据":@"本地收据路径未就绪";}
            NSArray *dependencies=option[@"dependencies"];
            if(dependencies.count) {
                BOOL dependencyReady=NO;
                for(NSString *identifier in dependencies)if(CSClientGuardSetting(CSClientGuardPreferenceKey(identifier))){dependencyReady=YES;break;}
                state[@"dependencyReady"]=@(dependencyReady);
                if(!dependencyReady){ready=NO;resourceStatus=@"需同时开启至少一项环境、资源或标识查询";}
                else resourceStatus=@"已有配套查询配置，实际应用以命中记录为准";
            } else state[@"dependencyReady"]=@YES;
            state[@"resourceReady"]=@(ready);state[@"resourceStatus"]=resourceStatus;
            NSMutableArray *records=[NSMutableArray array];NSUInteger installed=0,attempted=0;
            BOOL incompatible=NO,missingClass=NO,missingMethod=NO,oppositeOnly=NO;
            for(NSString *identity in option[@"interfaces"]) {
                NSDictionary *record=ReadInterface(identity,Statuses[identity]);
                if(record)[records addObject:record];
                if([Installed containsObject:identity])installed++;
                NSString *status=Statuses[identity];if(status)attempted++;
                NSString *availability=record[@"availabilityCode"];
                incompatible|=[availability isEqual:@"signature-unsupported"];
                missingClass|=[availability isEqual:@"class-missing"];
                missingMethod|=[availability isEqual:@"method-missing"];
                oppositeOnly|=[availability isEqual:@"opposite-method-only"];
            }
            state[@"interfaceStates"]=[records copy];
            NSUInteger total=[option[@"interfaces"] count];
            state[@"installedInterfaces"]=@(installed);state[@"totalInterfaces"]=@(total);
            state[@"fullyInstalled"]=@(total>0 && installed==total);
            NSString *installationCode=installed?(installed==total?@"installed":@"partial"):
                !attempted?@"not-attempted":incompatible?@"signature-unsupported":oppositeOnly?@"opposite-method-only":
                missingClass?@"class-missing":missingMethod?@"method-missing":@"available-not-installed";
            state[@"installationCode"]=installationCode;
            if(installed)state[@"installation"]=[NSString stringWithFormat:installed==total?@"已安装 %lu/%lu 个接口":@"部分安装 %lu/%lu 个接口",(unsigned long)installed,(unsigned long)total];
            else if(!attempted)state[@"installation"]=@"尚未尝试安装";
            else if(incompatible)state[@"installation"]=@"接口签名不兼容，未安装";
            else if(oppositeOnly)state[@"installation"]=@"目标方法缺失，仅发现相反方法类型；未安装";
            else if(missingClass)state[@"installation"]=@"未找到目标类，未安装";
            else if(missingMethod)state[@"installation"]=@"类存在，未找到目标方法；未安装";
            else state[@"installation"]=@"当前接口已可用，尚未安装；请刷新重检";
            [states addObject:[state copy]];
        }
    }
    return [states copy];
    } @finally {BypassDepth--;DiagnosticDepth--;}
}
NSString *CSClientGuardDiagnosticSummary(void) {
    DiagnosticDepth++;BypassDepth++;
    @try {
    NSDictionary *session=CSClientGuardSessionSnapshot();
    uint64_t policy=atomic_load_explicit(&CurrentPolicy,memory_order_acquire);
    NSArray<NSDictionary *> *capabilityStates=CSClientGuardCapabilityStates();
    NSUInteger configured=0,active=0,installed=0,partial=0;
    for(NSDictionary *state in capabilityStates){
        configured+=[state[@"configured"] boolValue];active+=[state[@"published"] boolValue];
        installed+=[state[@"installedInterfaces"] unsignedIntegerValue]>0;
        partial+=[state[@"installationCode"] isEqual:@"partial"];
    }
    NSMutableArray *lines=[NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"宿主：%@ (%@)",session[@"version"],session[@"build"]],
        CSClientGuardSetting(CSClientGuardEnabledKey)?@"配置总开关：开启":@"配置总开关：关闭",nil];
    [lines addObject:(policy&MasterBit)?[NSString stringWithFormat:@"实际干预策略：已发布 %lu 项能力；仅表示策略许可",(unsigned long)active]:
        @"实际干预策略：已停用，已装替代只透传原调用链"];
    [lines addObject:[NSString stringWithFormat:@"能力概况：目录 %lu 项，配置开启 %lu 项，策略发布 %lu 项；至少一个接口已安装 %lu 项（其中部分安装 %lu 项），未安装 %lu 项",
        (unsigned long)capabilityStates.count,(unsigned long)configured,(unsigned long)active,
        (unsigned long)installed,(unsigned long)partial,(unsigned long)(capabilityStates.count-installed)]];
    [lines addObject:@"安装统计包含当前已关闭的能力；接口安装、策略许可与实际应用分别记录。"];
    [lines addObject:[NSString stringWithFormat:@"本次进程：策略刷新 %@ 次，忽略无关变化 %@ 次，资源准备 %@ 次",session[@"refreshes"],session[@"skippedRefreshes"],session[@"resourcePreparations"]]];
    if(session[@"checkedAt"]!=NSNull.null)[lines addObject:[NSString stringWithFormat:@"最近重检：%@",session[@"checkedAt"]]];
    NSMutableSet<NSString *> *listedInterfaces=[NSMutableSet set];
    for(NSDictionary *state in capabilityStates) {
        [lines addObject:[NSString stringWithFormat:@"\n%@%@\n配置：%@；策略：%@；%@\n调用 %@ 次，应用 %@ 次，透传 %@ 次；最近：%@\n%@",
            state[@"title"],[state[@"experimental"] boolValue]?@"（实验）":@"",
            [state[@"configured"] boolValue]?@"开启":@"关闭",[state[@"published"] boolValue]?@"已发布":@"未发布",
            state[@"installation"],state[@"observed"],state[@"applied"],state[@"fallback"],state[@"lastOutcome"],state[@"resourceStatus"]]];
        if([state[@"restartPending"] boolValue])[lines addObject:@"本次进程更改过此能力，完整初始化或恢复需重启微信。"];
        else if([state[@"restartRequired"] boolValue])[lines addObject:@"依赖启动时机，已安装不代表本次初始化已被接管。"];
        for(NSDictionary *record in state[@"interfaceStates"]){
            [listedInterfaces addObject:record[@"identity"]];
            [lines addObject:[NSString stringWithFormat:@"%@：%@；当前核对 %@；实际 %@；支持 %@",record[@"identity"],record[@"status"],record[@"availabilityReason"],record[@"actualEncoding"],[record[@"expectedEncodings"] componentsJoinedByString:@" / "]]];
            if(![record[@"methodFound"] boolValue] && [record[@"oppositeMethodAvailable"] boolValue])
                [lines addObject:[NSString stringWithFormat:@"同名%@方法编码：%@；仅供核对，不自动接入",[record[@"classMethod"] boolValue]?@"实例":@"类",record[@"oppositeEncoding"]]];
            if(record[@"supportedHostBuild"])
                [lines addObject:[NSString stringWithFormat:@"此目标支持宿主：%@ (%@)；%@",record[@"supportedHostVersion"],record[@"supportedHostBuild"],
                    [record[@"hostMatched"] boolValue]?@"当前构建匹配":@"当前构建不匹配，不接入该目标"]];
        }
    }
    NSDictionary *states=StatusSnapshot();
    for(NSString *key in [[states allKeys] sortedArrayUsingSelector:@selector(compare:)]){
        if([listedInterfaces containsObject:key])continue;
        NSDictionary *record=ReadInterface(key,states[key]);
        [lines addObject:[NSString stringWithFormat:@"%@：%@",key,record[@"status"]?:states[key]]];
    }
    [lines addObject:@"签名匹配与安装状态不代表防封效果；异步检查及安装前查询不在覆盖范围。"];
    [lines addObject:@"好友验证范围保留原申请；本地风险结果或成功回调不代表服务器已接受。证书实验会降低目标接口的验证约束。"];
    [lines addObject:@"计数仅保存在当前进程内；匹配入口的调用、应用与回退分别统计，业务内容不进入记录。并发读取为即时快照，正在执行的调用可能尚未记录结果。宿主业务语义与效果仍未验证。"];
    return [lines componentsJoinedByString:@"\n"];
    } @finally {BypassDepth--;DiagnosticDepth--;}
}
#ifdef CS_CLIENT_GUARD_TESTING
NSDictionary<NSString *,NSString *> *CSClientGuardStatuses(void) {return StatusSnapshot();}
void CSClientGuardUseTestDefaults(NSUserDefaults *defaults,NSString *bundlePath,NSURL *libraryURL) {
    @synchronized(GuardLock()){
        atomic_store(&CurrentPolicy,0);PolicyRevision++;GuardDefaults=defaults;HostPath=[bundlePath copy];LibraryURL=libraryURL;
        LastSettings=nil;PreparedHost=nil;PreparedLibrary=nil;PreparedResourcePolicy=0;VendorSourceValue=nil;
    }
}
void CSClientGuardBeforeRefreshResourcesForTesting(void (^callback)(void)) {BeforeRefreshResources=[callback copy];}
void CSClientGuardUseTestHostVersion(NSString *version,NSString *build) {
    @synchronized(GuardLock()){TestHostVersion=[version copy];TestHostBuild=[build copy];}
}
#endif
