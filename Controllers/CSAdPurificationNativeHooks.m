#import "CSAdPurification.h"
#import "CSCloseFriendSignatures.h"
#import <objc/message.h>
#import <objc/runtime.h>

// These adapters deliberately leave database creation, service construction and
// host identifiers intact. Every installed adapter keeps its predecessor and
// checks the current scope on each call; toggling a scope never rewrites IMPs.
static Method CSAdNativeMethod(NSString *className, NSString *name, BOOL classMethod) {
    Class cls=NSClassFromString(className);
    if(classMethod && cls)cls=object_getClass(cls);
    return cls?class_getInstanceMethod(cls,NSSelectorFromString(name)):NULL;
}

static void CSAdBoolean0(NSString *className, NSString *name, BOOL classMethod,
    CSAdPurificationScope scope, BOOL value) {
    if(!CSAdPurificationShouldApply(scope))return;
    Method method=CSAdNativeMethod(className,name,classMethod);SEL sel=NSSelectorFromString(name);
    __block IMP original=NULL;
    if(CSCloseFriendMethodMatches(method,"B@:")) {
        IMP replacement=imp_implementationWithBlock(^bool(id obj){
            return CSAdPurificationShouldApply(scope)?(bool)value:((bool(*)(id,SEL))original)(obj,sel);
        });
        CSAdPurificationInstallHook(className,name,classMethod,"B@:",replacement,&original);
    } else if(CSCloseFriendMethodMatches(method,"c@:")) {
        IMP replacement=imp_implementationWithBlock(^signed char(id obj){
            return CSAdPurificationShouldApply(scope)?(signed char)value:((signed char(*)(id,SEL))original)(obj,sel);
        });
        CSAdPurificationInstallHook(className,name,classMethod,"c@:",replacement,&original);
    }
}

static void CSAdBoolean1(NSString *className, NSString *name, BOOL classMethod,
    CSAdPurificationScope scope, BOOL value) {
    if(!CSAdPurificationShouldApply(scope))return;
    Method method=CSAdNativeMethod(className,name,classMethod);SEL sel=NSSelectorFromString(name);
    __block IMP original=NULL;
    if(CSCloseFriendMethodMatches(method,"B@:@")) {
        IMP replacement=imp_implementationWithBlock(^bool(id obj,id arg){
            return CSAdPurificationShouldApply(scope)?(bool)value:((bool(*)(id,SEL,id))original)(obj,sel,arg);
        });
        CSAdPurificationInstallHook(className,name,classMethod,"B@:@",replacement,&original);
    } else if(CSCloseFriendMethodMatches(method,"c@:@")) {
        IMP replacement=imp_implementationWithBlock(^signed char(id obj,id arg){
            return CSAdPurificationShouldApply(scope)?(signed char)value:((signed char(*)(id,SEL,id))original)(obj,sel,arg);
        });
        CSAdPurificationInstallHook(className,name,classMethod,"c@:@",replacement,&original);
    }
}

static void CSAdBoolean2(NSString *className, NSString *name, BOOL classMethod,
    CSAdPurificationScope scope, BOOL value) {
    if(!CSAdPurificationShouldApply(scope))return;
    Method method=CSAdNativeMethod(className,name,classMethod);SEL sel=NSSelectorFromString(name);
    __block IMP original=NULL;
    if(CSCloseFriendMethodMatches(method,"B@:@@")) {
        IMP replacement=imp_implementationWithBlock(^bool(id obj,id first,id second){
            return CSAdPurificationShouldApply(scope)?(bool)value:((bool(*)(id,SEL,id,id))original)(obj,sel,first,second);
        });
        CSAdPurificationInstallHook(className,name,classMethod,"B@:@@",replacement,&original);
    } else if(CSCloseFriendMethodMatches(method,"c@:@@")) {
        IMP replacement=imp_implementationWithBlock(^signed char(id obj,id first,id second){
            return CSAdPurificationShouldApply(scope)?(signed char)value:((signed char(*)(id,SEL,id,id))original)(obj,sel,first,second);
        });
        CSAdPurificationInstallHook(className,name,classMethod,"c@:@@",replacement,&original);
    }
}

static void CSAdObject0(NSString *className, NSString *name, BOOL classMethod,
    CSAdPurificationScope scope) {
    if(!CSAdPurificationShouldApply(scope))return;
    SEL sel=NSSelectorFromString(name);__block IMP original=NULL;
    IMP replacement=imp_implementationWithBlock(^id(id obj){
        if(CSAdPurificationShouldApply(scope))return (id)nil;
        return ((id(*)(id,SEL))original)(obj,sel);
    });
    CSAdPurificationInstallHook(className,name,classMethod,"@@:",replacement,&original);
}

static void CSAdObject1(NSString *className, NSString *name, BOOL classMethod,
    CSAdPurificationScope scope) {
    if(!CSAdPurificationShouldApply(scope))return;
    SEL sel=NSSelectorFromString(name);__block IMP original=NULL;
    IMP replacement=imp_implementationWithBlock(^id(id obj,id arg){
        if(CSAdPurificationShouldApply(scope))return (id)nil;
        return ((id(*)(id,SEL,id))original)(obj,sel,arg);
    });
    CSAdPurificationInstallHook(className,name,classMethod,"@@:@",replacement,&original);
}

static void CSAdVoid0(NSString *className, NSString *name, CSAdPurificationScope scope) {
    if(!CSAdPurificationShouldApply(scope))return;
    SEL sel=NSSelectorFromString(name);__block IMP original=NULL;
    IMP replacement=imp_implementationWithBlock(^(id obj){
        if(!CSAdPurificationShouldApply(scope))((void(*)(id,SEL))original)(obj,sel);
    });
    CSAdPurificationInstallHook(className,name,NO,"v@:",replacement,&original);
}

static void CSAdVoid1(NSString *className, NSString *name, CSAdPurificationScope scope) {
    if(!CSAdPurificationShouldApply(scope))return;
    SEL sel=NSSelectorFromString(name);__block IMP original=NULL;
    IMP replacement=imp_implementationWithBlock(^(id obj,id arg){
        if(!CSAdPurificationShouldApply(scope))((void(*)(id,SEL,id))original)(obj,sel,arg);
    });
    CSAdPurificationInstallHook(className,name,NO,"v@:@",replacement,&original);
}

static void CSAdVoid2(NSString *className, NSString *name, CSAdPurificationScope scope) {
    if(!CSAdPurificationShouldApply(scope))return;
    SEL sel=NSSelectorFromString(name);__block IMP original=NULL;
    IMP replacement=imp_implementationWithBlock(^(id obj,id first,id second){
        if(!CSAdPurificationShouldApply(scope))((void(*)(id,SEL,id,id))original)(obj,sel,first,second);
    });
    CSAdPurificationInstallHook(className,name,NO,"v@:@@",replacement,&original);
}

static void CSAdVoid3(NSString *className, NSString *name, CSAdPurificationScope scope) {
    if(!CSAdPurificationShouldApply(scope))return;
    SEL sel=NSSelectorFromString(name);__block IMP original=NULL;
    IMP replacement=imp_implementationWithBlock(^(id obj,id first,id second,id third){
        if(!CSAdPurificationShouldApply(scope))((void(*)(id,SEL,id,id,id))original)(obj,sel,first,second,third);
    });
    CSAdPurificationInstallHook(className,name,NO,"v@:@@@",replacement,&original);
}

BOOL CSAdPurificationFinderItemIsAd(id item) {
    if(!item)return NO;
    @try {
        Class itemClass=NSClassFromString(@"WCFinderDataItem");
        if(!itemClass || ![item isKindOfClass:itemClass])return NO;
        Class cls=object_getClass(item);SEL flagSel=NSSelectorFromString(@"adFlag");
        Method flag=class_getInstanceMethod(cls,flagSel);
        // adFlag is an unsigned 64-bit field in the supplied 8.0.80.34 host.
        // Unknown signatures and absent fields preserve the native item.
        if(!CSCloseFriendMethodMatches(flag,"Q@:"))return NO;
        uint64_t value=((uint64_t(*)(id,SEL))objc_msgSend)(item,flagSel);
        if(value==0 || value==4)return NO;
        if(value>7)return YES;
        SEL liveSel=NSSelectorFromString(@"isAdsLive");
        Method live=class_getInstanceMethod(cls,liveSel);
        if(CSCloseFriendMethodMatches(live,"B@:")) {
            if(((bool(*)(id,SEL))objc_msgSend)(item,liveSel))return YES;
        } else if(CSCloseFriendMethodMatches(live,"c@:")) {
            if(((signed char(*)(id,SEL))objc_msgSend)(item,liveSel))return YES;
        } else return NO;
        SEL paramsSel=NSSelectorFromString(@"adsParams");
        if(!CSCloseFriendMethodMatches(class_getInstanceMethod(cls,paramsSel),"@@:"))return NO;
        return ((id(*)(id,SEL))objc_msgSend)(item,paramsSel)!=nil;
    } @catch(__unused NSException *exception) { return NO; }
}

static void CSAdInstallFinderFactory(void) {
    SEL sel=NSSelectorFromString(@"finderDataItemFromObject:");__block IMP original=NULL;
    IMP replacement=imp_implementationWithBlock(^id(id cls,id object){
        id item=((id(*)(id,SEL,id))original)(cls,sel,object);
        if(CSAdPurificationShouldApply(CSAdPurificationFinder) && CSAdPurificationFinderItemIsAd(item))return (id)nil;
        return item;
    });
    CSAdPurificationInstallHook(@"WCFinderDataItem",NSStringFromSelector(sel),YES,"@@:@",replacement,&original);
}

// Initializers consume their receiver and return +1. A normal object-returning
// block would lose that ARC contract; these C adapters carry it explicitly.
typedef id __attribute__((ns_returns_retained)) (*CSAdFinderInit2)(id __attribute__((ns_consumed)),SEL,id,int);
typedef id __attribute__((ns_returns_retained)) (*CSAdFinderInit3)(id __attribute__((ns_consumed)),SEL,id,int,id);
typedef id __attribute__((ns_returns_retained)) (*CSAdFinderInitIdentity)(id __attribute__((ns_consumed)),SEL,id,int,bool);
typedef id __attribute__((ns_returns_retained)) (*CSAdFinderInitIdentityChar)(id __attribute__((ns_consumed)),SEL,id,int,signed char);
static IMP CSAdFinderOriginal2,CSAdFinderOriginal3,CSAdFinderOriginalIdentity;

static id CSAdFinderInitialize2(id obj __attribute__((ns_consumed)),SEL sel,id item,int scene) __attribute__((ns_returns_retained));
static id CSAdFinderInitialize2(id obj __attribute__((ns_consumed)),SEL sel,id item,int scene) {
    if(CSAdPurificationShouldApply(CSAdPurificationFinder) && CSAdPurificationFinderItemIsAd(item))return nil;
    return ((CSAdFinderInit2)CSAdFinderOriginal2)(obj,sel,item,scene);
}
static id CSAdFinderInitialize3(id obj __attribute__((ns_consumed)),SEL sel,id item,int scene,id extra) __attribute__((ns_returns_retained));
static id CSAdFinderInitialize3(id obj __attribute__((ns_consumed)),SEL sel,id item,int scene,id extra) {
    if(CSAdPurificationShouldApply(CSAdPurificationFinder) && CSAdPurificationFinderItemIsAd(item))return nil;
    return ((CSAdFinderInit3)CSAdFinderOriginal3)(obj,sel,item,scene,extra);
}
static id CSAdFinderInitializeIdentity(id obj __attribute__((ns_consumed)),SEL sel,id item,int scene,bool identity) __attribute__((ns_returns_retained));
static id CSAdFinderInitializeIdentity(id obj __attribute__((ns_consumed)),SEL sel,id item,int scene,bool identity) {
    if(CSAdPurificationShouldApply(CSAdPurificationFinder) && CSAdPurificationFinderItemIsAd(item))return nil;
    return ((CSAdFinderInitIdentity)CSAdFinderOriginalIdentity)(obj,sel,item,scene,identity);
}
static id CSAdFinderInitializeIdentityChar(id obj __attribute__((ns_consumed)),SEL sel,id item,int scene,signed char identity) __attribute__((ns_returns_retained));
static id CSAdFinderInitializeIdentityChar(id obj __attribute__((ns_consumed)),SEL sel,id item,int scene,signed char identity) {
    if(CSAdPurificationShouldApply(CSAdPurificationFinder) && CSAdPurificationFinderItemIsAd(item))return nil;
    return ((CSAdFinderInitIdentityChar)CSAdFinderOriginalIdentity)(obj,sel,item,scene,identity);
}

static void CSAdInstallFinderInitializers(void) {
    NSString *cls=@"WCFinderFeedContentVM";
    CSAdPurificationInstallHook(cls,@"initWithDataItem:scene:",NO,"@@:@i",(IMP)CSAdFinderInitialize2,&CSAdFinderOriginal2);
    CSAdPurificationInstallHook(cls,@"initWithDataItem:scene:sessionExtraKey:",NO,"@@:@i@",(IMP)CSAdFinderInitialize3,&CSAdFinderOriginal3);
    NSString *identity=@"initWithDataItem:scene:isFinderIdentity:";
    Method method=CSAdNativeMethod(cls,identity,NO);
    if(CSCloseFriendMethodMatches(method,"@@:@iB"))
        CSAdPurificationInstallHook(cls,identity,NO,"@@:@iB",(IMP)CSAdFinderInitializeIdentity,&CSAdFinderOriginalIdentity);
    else if(CSCloseFriendMethodMatches(method,"@@:@ic"))
        CSAdPurificationInstallHook(cls,identity,NO,"@@:@ic",(IMP)CSAdFinderInitializeIdentityChar,&CSAdFinderOriginalIdentity);
}

static void CSAdInstallFinderRouter(void) {
    NSString *name=@"pushFinderAdPageViewControllerWithEncrytedObjectidTid:nonceId:currentNavController:enterScene:customParam:reportModel:cardType:commentScene:requestScene:functionalParams:";
    SEL sel=NSSelectorFromString(name);__block IMP original=NULL;
    IMP replacement=imp_implementationWithBlock(^(id obj,id tid,id nonce,id navigation,uint64_t enterScene,
        id custom,id report,int cardType,int commentScene,uint64_t requestScene,id params){
        if(!CSAdPurificationShouldApply(CSAdPurificationFinder))
            ((void(*)(id,SEL,id,id,id,uint64_t,id,id,int,int,uint64_t,id))original)
                (obj,sel,tid,nonce,navigation,enterScene,custom,report,cardType,commentScene,requestScene,params);
    });
    CSAdPurificationInstallHook(@"WCFinderRouterHelper",name,YES,"v@:@@@Q@@iiQ@",replacement,&original);
}

static void CSAdInstallSubscriptionPlugins(void) {
    SEL sel=NSSelectorFromString(@"getMagicBrushFlutterPlugins");__block IMP original=NULL;
    IMP replacement=imp_implementationWithBlock(^id(id obj){
        id plugins=((id(*)(id,SEL))original)(obj,sel);
        if(!CSAdPurificationShouldApply(CSAdPurificationSubscriptions) || ![plugins isKindOfClass:NSArray.class])return plugins;
        @try {
            NSMutableArray *filtered=[NSMutableArray arrayWithCapacity:[plugins count]];
            BOOL changed=NO;
            for(id plugin in plugins) {
                NSString *name=NSStringFromClass(object_getClass(plugin));
                if([name containsString:@"MagicSclBrandAdFlutterPlugin"]){changed=YES;continue;}
                [filtered addObject:plugin];
            }
            if(!changed)return plugins;
            return [plugins isKindOfClass:NSMutableArray.class]?filtered:[filtered copy];
        } @catch(__unused NSException *exception) { return plugins; }
    });
    CSAdPurificationInstallHook(@"BrandTLFlutterViewController",NSStringFromSelector(sel),NO,"@@:",replacement,&original);
}

static void CSAdInstallMomentsExtraHandlers(void) {
    // Full signatures matter here: the final log argument is Q or I, not an object.
    SEL log=NSSelectorFromString(@"logADH5:withUserInfo:reportType:");__block IMP logOriginal=NULL;
    IMP logReplacement=imp_implementationWithBlock(^(id obj,id first,id second,uint64_t type){
        if(!CSAdPurificationShouldApply(CSAdPurificationMoments))
            ((void(*)(id,SEL,id,id,uint64_t))logOriginal)(obj,log,first,second,type);
    });
    CSAdPurificationInstallHook(@"WCAdvertiseStatMgr",NSStringFromSelector(log),NO,"v@:@@Q",logReplacement,&logOriginal);
    SEL sphere=NSSelectorFromString(@"logSphereViewWithSphereReportInfo:dataItem:scene:");__block IMP sphereOriginal=NULL;
    IMP sphereReplacement=imp_implementationWithBlock(^(id obj,id first,id second,unsigned int scene){
        if(!CSAdPurificationShouldApply(CSAdPurificationMoments))
            ((void(*)(id,SEL,id,id,unsigned int))sphereOriginal)(obj,sphere,first,second,scene);
    });
    CSAdPurificationInstallHook(@"WCAdvertiseStatMgr",NSStringFromSelector(sphere),NO,"v@:@@I",sphereReplacement,&sphereOriginal);
}

void CSAdPurificationInstallNativeHooks(void) {
    if(CSAdPurificationShouldApply(CSAdPurificationArticles)) {
        for(NSString *cls in @[@"WebviewJSEventHandler_adDataReport",@"WebviewJSEventHandler_getAdIdInfo"])
            CSAdVoid3(cls,@"handleJSEvent:HandlerFacade:ExtraData:",CSAdPurificationArticles);
    }
    if(CSAdPurificationShouldApply(CSAdPurificationSubscriptions)) {
        CSAdPurificationInstallSubscriptionHooks();
        CSAdBoolean0(@"BrandTLExptConfig",@"isExptNotShowAd",NO,CSAdPurificationSubscriptions,YES);
        CSAdBoolean0(@"BrandTLFlutterViewController",@"enableAd",NO,CSAdPurificationSubscriptions,NO);
        CSAdBoolean0(@"BrandTLCanvasCardMgr",@"isAdRequestOpen",YES,CSAdPurificationSubscriptions,NO);
        CSAdBoolean0(@"BrandTLCanvasCardMgr",@"isAdCardOpen",YES,CSAdPurificationSubscriptions,NO);
        CSAdInstallSubscriptionPlugins();
        CSAdVoid0(@"BrandTLFlutterViewController",@"reportAdBrandCardOnClick",CSAdPurificationSubscriptions);
        CSAdVoid1(@"BrandTLCanvasCardMgr",@"handleBizAdNotifyNewXml:",CSAdPurificationSubscriptions);
        CSAdVoid1(@"MagicAdPushMgrService",@"handleAdMsg:",CSAdPurificationSubscriptions);
        CSAdVoid3(@"MagicAdPushMgrService",@"OnGetNewXmlMsg:Type:MsgWrap:",CSAdPurificationSubscriptions);
        for(NSString *cls in @[@"MBEventHandler_getAdPushMsg",@"MBEventHandler_getOldAdInfo",@"MBEventHandler_setAdCardRequestInfo",@"MBEventHandler_setAdRequestInfo",@"MBEventHandler_setFeedsAdRequestInfo"])
            CSAdVoid1(cls,@"invoke:",CSAdPurificationSubscriptions);
        for(NSString *name in @[@"adDataItemForContent:",@"adDataItemForMsgWrap:",@"adInfoDicForContent:",@"adInfoDicForMsgWrap:"])
            CSAdObject1(@"BrandAdDataParser",name,YES,CSAdPurificationSubscriptions);
        for(NSString *name in @[@"dicAdInfo",@"content"])
            CSAdObject0(@"BrandAdDataItem",name,NO,CSAdPurificationSubscriptions);
    }
    if(CSAdPurificationShouldApply(CSAdPurificationRecommendations)) {
        for(NSString *name in @[@"isExptNotShowRecCard",@"isExptNotShowFinderLiveBar",@"isExptNotShowRecoFlow"])
            CSAdBoolean0(@"BrandTLExptConfig",name,NO,CSAdPurificationRecommendations,YES);
        for(NSString *name in @[@"showDynamicCard",@"showDynamicCardToast"])
            CSAdBoolean0(@"BrandTLExptConfig",name,NO,CSAdPurificationRecommendations,NO);
    }
    if(CSAdPurificationShouldApply(CSAdPurificationMoments)) {
        CSAdBoolean2(@"WCAdvertiseDataHelper",@"IsAdvertiseDataValid:dataItem:",NO,CSAdPurificationMoments,NO);
        CSAdBoolean1(@"WCAdvertiseDataHelper",@"isAdPreviewExpired:",NO,CSAdPurificationMoments,YES);
        CSAdBoolean0(@"WCAdvertiseInfo",@"adExpired",NO,CSAdPurificationMoments,YES);
        CSAdBoolean0(@"WCAdDynamicCanvasServerData",@"isValid",NO,CSAdPurificationMoments,NO);
        CSAdVoid1(@"WCAdvertisePushService",@"handlePushMsg:",CSAdPurificationMoments);
        CSAdVoid3(@"WCAdvertisePushService",@"OnGetNewXmlMsg:Type:MsgWrap:",CSAdPurificationMoments);
        CSAdVoid1(@"WCCanvasDynamicDataLoader",@"handleAdCanvasInfoResponse:",CSAdPurificationMoments);
        CSAdObject1(@"WCAdvertiseStatMgr",@"getAdvertiseInfoForItem:",NO,CSAdPurificationMoments);
        for(NSString *name in @[@"h5PageWrap",@"poiH5PageWrap"])
            CSAdObject0(@"WCAdvertiseInfo",name,NO,CSAdPurificationMoments);
        for(NSString *name in @[@"fetchRealUxInfo",@"fetchPageInfoExtraDic",@"fetchPageInfoDic",@"fetchLaunchString"])
            CSAdObject0(@"WCAdDynamicCanvasPageInfo",name,NO,CSAdPurificationMoments);
        for(NSString *name in @[@"logHeadImageH5:",@"logADBrandProfile:",@"logADFloatView:",@"logADPoiH5:",@"logADH5:",@"logADCommentLog:",@"logADBodyLog:"])
            CSAdVoid1(@"WCAdvertiseStatMgr",name,CSAdPurificationMoments);
        for(NSString *name in @[@"logADDetail:dataItem:",@"logSphereViewInDetailWithWrapInfo:dataItem:",@"logSphereViewInTimeLineWithWrapInfo:dataItem:"])
            CSAdVoid2(@"WCAdvertiseStatMgr",name,CSAdPurificationMoments);
        CSAdVoid0(@"WCAdvertiseStatMgr",@"reportAllFeedsADLog",CSAdPurificationMoments);
        CSAdInstallMomentsExtraHandlers();
        for(NSString *name in @[@"SetAdvertiseInfo:ByAdInfo:",@"SetAdvertiseXml:ByAdXml:",@"ExtractRecommendAdInfo:ByAdMsgXml:"])
            CSAdBoolean2(@"WCAdXmlParser",name,YES,CSAdPurificationMoments,NO);
    }
    if(CSAdPurificationShouldApply(CSAdPurificationFinder)) {
        CSAdInstallFinderFactory();CSAdInstallFinderInitializers();CSAdInstallFinderRouter();
        CSAdObject0(@"_TtC6WeChat31MBJsEventOnFinderMediaAdPreload",@"startPreloadAdMedia",YES,CSAdPurificationFinder);
        CSAdBoolean0(@"WCAdFinderInfo",@"isValid",NO,CSAdPurificationFinder,NO);
        for(NSString *name in @[@"adDesc",@"adH5",@"adLeadLink",@"adMiniApp",@"adItems"])
            CSAdObject0(@"FinderObjectAdInfo",name,NO,CSAdPurificationFinder);
        for(NSString *name in @[@"adDesc",@"adH5",@"adLeadLink",@"adMiniApp",@"uxinfo"])
            CSAdObject0(@"ObjectAdItem",name,NO,CSAdPurificationFinder);
        CSAdObject0(@"ObjectAdContentH5",@"url",NO,CSAdPurificationFinder);
    }
    if(CSAdPurificationShouldApply(CSAdPurificationMiniPrograms)) {
        CSAdBoolean0(@"WAAppTask",@"isSplashADFinished",NO,CSAdPurificationMiniPrograms,YES);
        for(NSString *name in @[@"canShowSplashADWindow",@"canHotStartShowSplashAD",@"splashADHasContent"])
            CSAdBoolean0(@"WAAppTaskSplashADConfig",name,NO,CSAdPurificationMiniPrograms,NO);
        for(NSString *cls in @[@"WAJSEventHandler_showSplashAd",@"WAJSEventHandler_showSplashAdMenu",@"WAJSEventHandler_adOperateWXData"])
            CSAdVoid1(cls,@"handleJSEvent:",CSAdPurificationMiniPrograms);
    }
    CSAdBoolean0(@"WCAdSearchH5Info",@"isValid",NO,CSAdPurificationSearch,NO);
}
