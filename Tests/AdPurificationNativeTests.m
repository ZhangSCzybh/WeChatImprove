#import <Foundation/Foundation.h>
#import <objc/message.h>
#import "CSAdPurification.h"

static NSUInteger Checks,FactoryCalls,VMCalls,VMDeallocations,HandlerCalls,LogCalls,RouterCalls;
static id LastFirst,LastSecond,LastThird;
static uint64_t LastWide;
static int LastScene,LastCard,LastComment;
static bool LastIdentity;
#define CHECK(c) do { Checks++;if(!(c)){NSLog(@"Ad native FAIL %d: %s",__LINE__,#c);exit(1);} } while(0)

@interface WCFinderDataItem : NSObject
@property(nonatomic) unsigned long long adFlag;
@property(nonatomic) bool isAdsLive;
@property(nonatomic,strong) id adsParams;
+ (id)finderDataItemFromObject:(id)object;
@end
@implementation WCFinderDataItem
+ (id)finderDataItemFromObject:(id)object { FactoryCalls++;LastFirst=object;return object; }
@end
@interface CSAdThrowingFinder : WCFinderDataItem @end
@implementation CSAdThrowingFinder
- (unsigned long long)adFlag { @throw [NSException exceptionWithName:@"fixture" reason:nil userInfo:nil]; }
@end
@interface CSAdIncompatibleFinder : WCFinderDataItem @end
@implementation CSAdIncompatibleFinder @end

@interface WCFinderFeedContentVM : NSObject
@property(nonatomic,strong) id item;
- (instancetype)initWithDataItem:(id)item scene:(int)scene;
- (instancetype)initWithDataItem:(id)item scene:(int)scene sessionExtraKey:(id)extra;
- (instancetype)initWithDataItem:(id)item scene:(int)scene isFinderIdentity:(bool)identity;
@end
@implementation WCFinderFeedContentVM
- (instancetype)initWithDataItem:(id)item scene:(int)scene {
    if((self=[super init])){self.item=item;VMCalls++;LastScene=scene;LastFirst=item;}return self;
}
- (instancetype)initWithDataItem:(id)item scene:(int)scene sessionExtraKey:(id)extra {
    if((self=[super init])){self.item=item;VMCalls++;LastScene=scene;LastFirst=item;LastSecond=extra;}return self;
}
- (instancetype)initWithDataItem:(id)item scene:(int)scene isFinderIdentity:(bool)identity {
    if((self=[super init])){self.item=item;VMCalls++;LastScene=scene;LastFirst=item;LastIdentity=identity;}return self;
}
- (void)dealloc { VMDeallocations++; }
@end

@interface BrandTLExptConfig : NSObject
- (bool)isExptNotShowAd;
- (bool)isExptNotShowRecCard;
- (bool)showDynamicCard;
@end
@implementation BrandTLExptConfig
- (bool)isExptNotShowAd {return false;}
- (bool)isExptNotShowRecCard {return false;}
- (bool)showDynamicCard {return true;}
@end
@interface BrandTLCanvasCardMgr : NSObject
+ (bool)isAdRequestOpen;
- (void)handleBizAdNotifyNewXml:(id)xml;
@end
@implementation BrandTLCanvasCardMgr
+ (bool)isAdRequestOpen {return true;}
- (void)handleBizAdNotifyNewXml:(id)xml {HandlerCalls++;LastFirst=xml;}
@end
@interface CSAdMagicSclBrandAdFlutterPlugin : NSObject @end
@implementation CSAdMagicSclBrandAdFlutterPlugin @end
static id Plugins;
@interface BrandTLFlutterViewController : NSObject
- (id)getMagicBrushFlutterPlugins;
- (double)enableAd;
@end
@implementation BrandTLFlutterViewController
- (id)getMagicBrushFlutterPlugins {return Plugins;}
- (double)enableAd {return 1.25;}
@end

@interface WCAdvertiseDataHelper : NSObject
- (bool)IsAdvertiseDataValid:(id)ad dataItem:(id)item;
- (signed char)isAdPreviewExpired:(id)ad;
@end
@implementation WCAdvertiseDataHelper
- (bool)IsAdvertiseDataValid:(id)ad dataItem:(id)item {LastFirst=ad;LastSecond=item;return true;}
- (signed char)isAdPreviewExpired:(id)ad {LastFirst=ad;return 0;}
@end
@interface WCAdvertiseStatMgr : NSObject
- (id)getAdvertiseInfoForItem:(id)item;
- (void)logADH5:(id)url withUserInfo:(id)info reportType:(unsigned long long)type;
- (void)logSphereViewWithSphereReportInfo:(id)info dataItem:(id)item scene:(unsigned int)scene;
@end
@implementation WCAdvertiseStatMgr
- (id)getAdvertiseInfoForItem:(id)item {LastFirst=item;return item;}
- (void)logADH5:(id)url withUserInfo:(id)info reportType:(unsigned long long)type {LogCalls++;LastFirst=url;LastSecond=info;LastWide=type;}
- (void)logSphereViewWithSphereReportInfo:(id)info dataItem:(id)item scene:(unsigned int)scene {LogCalls++;LastFirst=info;LastSecond=item;LastWide=scene;}
@end
@interface WCAdvertisePushService : NSObject
- (void)OnGetNewXmlMsg:(id)msg Type:(id)type MsgWrap:(id)wrap;
@end
@implementation WCAdvertisePushService
- (void)OnGetNewXmlMsg:(id)msg Type:(id)type MsgWrap:(id)wrap {HandlerCalls++;LastFirst=msg;LastSecond=type;LastThird=wrap;}
@end
@interface WCAdXmlParser : NSObject
+ (bool)SetAdvertiseInfo:(id)target ByAdInfo:(id)source;
@end
@implementation WCAdXmlParser
+ (bool)SetAdvertiseInfo:(id)target ByAdInfo:(id)source {LastFirst=target;LastSecond=source;return true;}
@end
@interface WAAppTask : NSObject
- (signed char)isSplashADFinished;
@end
@implementation WAAppTask
- (signed char)isSplashADFinished {return 0;}
@end
@interface WAAppTaskSplashADConfig : NSObject
- (bool)canShowSplashADWindow;
@end
@implementation WAAppTaskSplashADConfig
- (bool)canShowSplashADWindow {return true;}
@end
@interface WAJSEventHandler_showSplashAd : NSObject
- (void)handleJSEvent:(id)event;
@end
@implementation WAJSEventHandler_showSplashAd
- (void)handleJSEvent:(id)event {HandlerCalls++;LastFirst=event;}
@end
@interface WebviewJSEventHandler_adDataReport : NSObject
- (void)handleJSEvent:(id)event HandlerFacade:(id)facade ExtraData:(id)data;
@end
@implementation WebviewJSEventHandler_adDataReport
- (void)handleJSEvent:(id)event HandlerFacade:(id)facade ExtraData:(id)data {HandlerCalls++;LastFirst=event;LastSecond=facade;LastThird=data;}
@end
@interface WCAdSearchH5Info : NSObject
- (signed char)isValid;
@end
@implementation WCAdSearchH5Info
- (signed char)isValid {return 1;}
@end
@interface WCFinderRouterHelper : NSObject
+ (void)pushFinderAdPageViewControllerWithEncrytedObjectidTid:(id)tid nonceId:(id)nonce currentNavController:(id)nav enterScene:(unsigned long long)scene customParam:(id)custom reportModel:(id)report cardType:(int)card commentScene:(int)comment requestScene:(unsigned long long)request functionalParams:(id)params;
@end
@implementation WCFinderRouterHelper
+ (void)pushFinderAdPageViewControllerWithEncrytedObjectidTid:(id)tid nonceId:(id)nonce currentNavController:(id)nav enterScene:(unsigned long long)scene customParam:(id)custom reportModel:(id)report cardType:(int)card commentScene:(int)comment requestScene:(unsigned long long)request functionalParams:(id)params {
    RouterCalls++;LastFirst=tid;LastSecond=nonce;LastThird=params;LastWide=scene^request;LastCard=card;LastComment=comment;
    CHECK(nav!=nil && custom!=nil && report!=nil);
}
@end

void CSAdPurificationInstallWebHooks(void) {}
void CSAdPurificationTestHookMessage(Class cls,SEL selector,IMP replacement,IMP *original) {
    Method method=class_getInstanceMethod(cls,selector);*original=method_getImplementation(method);
    if(!class_addMethod(cls,selector,replacement,method_getTypeEncoding(method)))method_setImplementation(method,replacement);
}
static void Configure(NSUserDefaults *defaults,NSArray *identifiers) {
    [defaults setBool:YES forKey:CSAdPurificationEnabledKey];
    for(NSDictionary *option in CSAdPurificationOptions())
        [defaults setBool:[identifiers containsObject:option[@"identifier"]] forKey:CSAdPurificationPreferenceKey(option[@"identifier"])];
    CSAdPurificationRefresh();
}
static double IncompatibleFlag(__unused id obj,__unused SEL sel){return 20;}
int main(void) { @autoreleasepool {
    NSString *suite=[@"CSAdNativeTests." stringByAppendingString:NSUUID.UUID.UUIDString];
    NSUserDefaults *defaults=[[NSUserDefaults alloc]initWithSuiteName:suite];
    CSAdPurificationUseTestDefaults(defaults);CSAdPurificationStart();
    CHECK(CSAdPurificationInstalledHookCount()==0);
    class_addMethod(CSAdIncompatibleFinder.class,@selector(adFlag),(IMP)IncompatibleFlag,"d@:");
    WCFinderDataItem *item=[WCFinderDataItem new];item.adsParams=[NSObject new];item.isAdsLive=true;
    CHECK(!CSAdPurificationFinderItemIsAd(nil));CHECK(!CSAdPurificationFinderItemIsAd([NSObject new]));
    for(unsigned long long flag=0;flag<32;flag++) {
        item.adFlag=flag;CHECK(CSAdPurificationFinderItemIsAd(item)==(flag!=0 && flag!=4));
        item.isAdsLive=false;item.adsParams=nil;
        CHECK(CSAdPurificationFinderItemIsAd(item)==(flag>7));
        item.isAdsLive=true;item.adsParams=[NSObject new];
    }
    CHECK(!CSAdPurificationFinderItemIsAd([CSAdThrowingFinder new]));
    CHECK(!CSAdPurificationFinderItemIsAd([CSAdIncompatibleFinder new]));
    BrandTLExptConfig *config=[BrandTLExptConfig new];
    Configure(defaults,@[@"subscriptions"]);
    CHECK([config isExptNotShowAd]);CHECK(![config isExptNotShowRecCard]);CHECK([config showDynamicCard]);
    CHECK(![BrandTLCanvasCardMgr isAdRequestOpen]);
    BrandTLFlutterViewController *controller=[BrandTLFlutterViewController new];
    CHECK([controller enableAd]==1.25); // Wrong return ABI stays unhooked.
    NSObject *keep=[NSObject new],*ad=[CSAdMagicSclBrandAdFlutterPlugin new];
    Plugins=@[keep,ad];id filtered=[controller getMagicBrushFlutterPlugins];
    CHECK([filtered count]==1 && [filtered firstObject]==keep && ![filtered isKindOfClass:NSMutableArray.class]);
    CHECK([Plugins count]==2);Plugins=[@[keep,ad] mutableCopy];
    filtered=[controller getMagicBrushFlutterPlugins];CHECK([filtered isKindOfClass:NSMutableArray.class] && [filtered count]==1);
    Plugins=@[keep];CHECK([controller getMagicBrushFlutterPlugins]==Plugins);
    Plugins=@"unexpected";CHECK([controller getMagicBrushFlutterPlugins]==Plugins);
    NSUInteger installed=CSAdPurificationInstalledHookCount();CSAdPurificationRefresh();CHECK(installed==CSAdPurificationInstalledHookCount());
    Configure(defaults,@[@"recommendations"]);CHECK(![config isExptNotShowAd]);CHECK([config isExptNotShowRecCard]);CHECK(![config showDynamicCard]);
    CHECK([BrandTLCanvasCardMgr isAdRequestOpen]);
    Configure(defaults,@[@"finder"]);item.adFlag=20;
    FactoryCalls=0;CHECK([WCFinderDataItem finderDataItemFromObject:item]==nil);CHECK(FactoryCalls==1 && LastFirst==item);
    item.adFlag=4;CHECK([WCFinderDataItem finderDataItemFromObject:item]==item);
    CHECK([WCFinderDataItem finderDataItemFromObject:keep]==keep);
    item.adFlag=20;NSUInteger deallocBefore=VMDeallocations;
    CHECK([[WCFinderFeedContentVM alloc]initWithDataItem:item scene:-17]==nil);
    CHECK(VMDeallocations==deallocBefore+1 && VMCalls==0);
    CHECK([[WCFinderFeedContentVM alloc]initWithDataItem:item scene:-17 sessionExtraKey:keep]==nil);
    CHECK([[WCFinderFeedContentVM alloc]initWithDataItem:item scene:-17 isFinderIdentity:true]==nil);
    CHECK(VMDeallocations==deallocBefore+3 && VMCalls==0);
    item.adFlag=0;
    @autoreleasepool {
        WCFinderFeedContentVM *vm=[[WCFinderFeedContentVM alloc]initWithDataItem:item scene:-123456 sessionExtraKey:keep];
        CHECK(vm.item==item && LastFirst==item && LastSecond==keep && LastScene==-123456);
    }
    CHECK(VMDeallocations==deallocBefore+4);
    Configure(defaults,@[@"moments"]);
    WCAdvertiseDataHelper *helper=[WCAdvertiseDataHelper new];
    CHECK(![helper IsAdvertiseDataValid:ad dataItem:item]);CHECK([helper isAdPreviewExpired:ad]);
    CHECK(![WCAdXmlParser SetAdvertiseInfo:ad ByAdInfo:item]);
    WCAdvertiseStatMgr *stats=[WCAdvertiseStatMgr new];CHECK([stats getAdvertiseInfoForItem:keep]==nil);
    [stats logADH5:ad withUserInfo:item reportType:UINT64_MAX];CHECK(LogCalls==0);
    WCAdvertisePushService *push=[WCAdvertisePushService new];NSUInteger handlers=HandlerCalls;
    [push OnGetNewXmlMsg:ad Type:item MsgWrap:keep];CHECK(HandlerCalls==handlers);
    Configure(defaults,@[@"mini_programs"]);
    CHECK([[WAAppTask new]isSplashADFinished]);CHECK(![[WAAppTaskSplashADConfig new]canShowSplashADWindow]);
    WAJSEventHandler_showSplashAd *splash=[WAJSEventHandler_showSplashAd new];
    [splash handleJSEvent:ad];CHECK(HandlerCalls==handlers);
    Configure(defaults,@[@"articles"]);
    WebviewJSEventHandler_adDataReport *web=[WebviewJSEventHandler_adDataReport new];
    [web handleJSEvent:ad HandlerFacade:item ExtraData:keep];CHECK(HandlerCalls==handlers);
    Configure(defaults,@[@"search"]);CHECK(![[WCAdSearchH5Info new]isValid]);
    CSAdPurificationSetSetting(CSAdPurificationEnabledKey,NO);
    CHECK(CSAdPurificationActiveScopes()==0); // Immediate disable, before queued refresh.
    CHECK([helper IsAdvertiseDataValid:ad dataItem:item] && LastFirst==ad && LastSecond==item);
    CHECK(![helper isAdPreviewExpired:ad] && LastFirst==ad);
    CHECK([WCAdXmlParser SetAdvertiseInfo:ad ByAdInfo:item] && LastFirst==ad && LastSecond==item);
    CHECK([stats getAdvertiseInfoForItem:keep]==keep && LastFirst==keep);
    [stats logADH5:ad withUserInfo:item reportType:UINT64_MAX];CHECK(LogCalls==1 && LastWide==UINT64_MAX && LastFirst==ad && LastSecond==item);
    [stats logSphereViewWithSphereReportInfo:ad dataItem:item scene:UINT_MAX];CHECK(LogCalls==2 && LastWide==UINT_MAX);
    [push OnGetNewXmlMsg:ad Type:item MsgWrap:keep];CHECK(HandlerCalls==handlers+1 && LastFirst==ad && LastSecond==item && LastThird==keep);
    [splash handleJSEvent:keep];CHECK(HandlerCalls==handlers+2 && LastFirst==keep);
    [web handleJSEvent:ad HandlerFacade:item ExtraData:keep];CHECK(HandlerCalls==handlers+3 && LastFirst==ad && LastSecond==item && LastThird==keep);
    CHECK(![[WAAppTask new]isSplashADFinished] && [[WAAppTaskSplashADConfig new]canShowSplashADWindow]);
    CHECK([[WCAdSearchH5Info new]isValid]);CHECK(![config isExptNotShowAd] && ![config isExptNotShowRecCard] && [config showDynamicCard]);
    item.adFlag=20;CHECK([WCFinderDataItem finderDataItemFromObject:item]==item);
    @autoreleasepool {
        WCFinderFeedContentVM *vm=[[WCFinderFeedContentVM alloc]initWithDataItem:item scene:INT_MIN isFinderIdentity:true];
        CHECK(vm.item==item && LastIdentity && LastScene==INT_MIN);
    }
    [WCFinderRouterHelper pushFinderAdPageViewControllerWithEncrytedObjectidTid:ad nonceId:item currentNavController:keep enterScene:UINT64_MAX customParam:keep reportModel:ad cardType:-7 commentScene:-9 requestScene:1 functionalParams:keep];
    CHECK(RouterCalls==1 && LastFirst==ad && LastSecond==item && LastThird==keep && LastWide==(UINT64_MAX^1) && LastCard==-7 && LastComment==-9);
    Configure(defaults,@[@"finder"]);
    [WCFinderRouterHelper pushFinderAdPageViewControllerWithEncrytedObjectidTid:ad nonceId:item currentNavController:keep enterScene:UINT64_MAX customParam:keep reportModel:ad cardType:-7 commentScene:-9 requestScene:1 functionalParams:keep];CHECK(RouterCalls==1);
    CSAdPurificationSetSetting(CSAdPurificationEnabledKey,NO);[defaults removePersistentDomainForName:suite];
    printf("Ad purification native: %lu checks passed\n",(unsigned long)Checks);
} return 0; }
