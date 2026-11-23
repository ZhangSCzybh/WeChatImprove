#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <objc/message.h>
#import <objc/runtime.h>
#import "CSCloseFriendSignatures.h"
static NSUInteger Assertions;
#define CHECK(...) do { Assertions++; if(!(__VA_ARGS__)) { \
    fprintf(stderr,"Moments names FAIL %d: %s\n",__LINE__,#__VA_ARGS__); exit(1); \
} } while(0)

// Native contacts, contexts and forwarding services are boundary doubles. The
// account lookup, ABI gates, name resolution and equality come from production.
@interface CSMomentsCardModel : NSObject
@property(nonatomic,strong) id item,media;
@property(nonatomic,copy) NSString *identifier,*title,*username,*nickname,*locationText,*sourceText,*shareCoverURL;
@property(nonatomic) NSUInteger contentKind;
@property(nonatomic) CGSize coverSize;
@property(nonatomic) NSTimeInterval timestamp;
@property(nonatomic) NSUInteger mediaCount,likes,comments,epoch,revision;
@property(nonatomic) BOOL video,liked;
@end
@implementation CSMomentsCardModel @end
enum { CSMomentsContentMiniApp=7 };
@interface MiniAppInfo : NSObject
@property(nonatomic,strong) id appUserName;
@end
@implementation MiniAppInfo @end
@interface MiniAppItem : NSObject
@property(nonatomic,strong) id weappInfo;
@end
@implementation MiniAppItem @end
@interface WAContact : NSObject
@property(nonatomic,strong) id m_nsNickName;
@end
@implementation WAContact @end
@interface WAContactMgr : NSObject
@property(nonatomic,strong) NSDictionary<NSString *,id> *contacts;
@property(nonatomic,strong) NSMutableArray<NSString *> *queries;
@property(nonatomic) BOOL throws;
@property(nonatomic) NSUInteger forbiddenLookups;
- (id)getContactFromCache:(NSString *)username;
- (id)getWeAppContact:(NSString *)username;
@end
@implementation WAContactMgr
- (id)getContactFromCache:(NSString *)username {
    [self.queries addObject:username];
    if(self.throws)[NSException raise:@"NativeMiniAppLookupFailure" format:@"fixture"];
    return self.contacts[username];
}
- (id)getWeAppContact:(NSString *)username { (void)username; self.forbiddenLookups++; return nil; }
@end
@interface NameContact : NSObject
@property(nonatomic,strong) id m_nsRemark;
@end
@implementation NameContact @end
@interface CContactMgr : NSObject
@property(nonatomic,strong) NSDictionary<NSString *,id> *contacts;
@property(nonatomic,strong) NSMutableArray<NSString *> *queries;
@property(nonatomic) BOOL throws;
- (id)getContactByName:(NSString *)username;
@end
@implementation CContactMgr
- (id)getContactByName:(NSString *)username {
    [self.queries addObject:username];
    if(self.throws)[NSException raise:@"NativeLookupFailure" format:@"fixture"];
    return self.contacts[username];
}
@end
@interface WCFacade : NSObject @end
@implementation WCFacade @end
@interface NameCenter : NSObject
@property(nonatomic,strong) id manager,facade,miniAppManager;
@property(nonatomic) NSUInteger services;
- (id)getService:(Class)serviceClass;
@end
@implementation NameCenter
- (id)getService:(Class)serviceClass {
    self.services++;
    if(serviceClass==CContactMgr.class)return self.manager;
    if(serviceClass==WCFacade.class)return self.facade;
    if(serviceClass==WAContactMgr.class)return self.miniAppManager;
    return nil;
}
@end
static id ActiveContext;
@interface MMContext : NSObject
+ (id)currentContext;
@end
@implementation MMContext
+ (id)currentContext { return ActiveContext; }
@end
@interface NestedContext : NSObject
@property(nonatomic,strong) id serviceCenter;
@end
@implementation NestedContext @end
static NSUInteger BadCalls;
@interface BadContextAccessor : NSObject
+ (long long)currentContext;
@end
@implementation BadContextAccessor
+ (long long)currentContext { BadCalls++; return 0; }
@end
@interface NameServiceWrapper : NSProxy
@property(nonatomic,strong) id target;
@property(nonatomic) NSUInteger forwards;
@end
@implementation NameServiceWrapper
- (Class)class { return [self.target class]; }
- (BOOL)isKindOfClass:(Class)cls { return [self.target isKindOfClass:cls]; }
- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector { return [self.target methodSignatureForSelector:selector]; }
- (void)forwardInvocation:(NSInvocation *)invocation { self.forwards++; [invocation invokeWithTarget:self.target]; }
@end
static Class ContextLookupClass,ContactLookupClass,MiniAppLookupClass;
static NameCenter *FallbackCenter;
static NSUInteger FallbackCalls;
static id CSGetServiceCenter(void) { FallbackCalls++; return FallbackCenter; }
static id CSCloseFriendRead(id object,NSString *key) {
    SEL selector=NSSelectorFromString(key);
    if(!CSCloseFriendMethodMatches(class_getInstanceMethod([object class],selector),"@@:"))return nil;
    return ((id(*)(id,SEL))objc_msgSend)(object,selector);
}
static Class LookupClass(NSString *name) {
    if([name isEqual:@"MMContext"])return ContextLookupClass;
    if([name isEqual:@"CContactMgr"])return ContactLookupClass;
    if([name isEqual:@"WAContactMgr"])return MiniAppLookupClass;
    return NSClassFromString(name);
}
#define NSClassFromString LookupClass
#include "MomentsNamesBodies.h"
#undef NSClassFromString

static NameContact *Contact(id remark) { NameContact *contact=[NameContact new]; contact.m_nsRemark=remark; return contact; }
static CSMomentsCardModel *Card(NSString *username,id item) {
    CSMomentsCardModel *card=[CSMomentsCardModel new]; card.item=item?:[NSObject new];
    card.username=username; card.nickname=@"朋友圈昵称"; card.identifier=@"item-id"; card.title=@"正文";
    card.locationText=@""; card.epoch=7; card.revision=12; return card;
}
static CContactMgr *Begin(void) {
    ContextLookupClass=MMContext.class; ContactLookupClass=CContactMgr.class; MiniAppLookupClass=WAContactMgr.class;
    CContactMgr *manager=[CContactMgr new]; manager.contacts=@{}; manager.queries=[NSMutableArray new];
    NameCenter *center=[NameCenter new]; center.manager=manager; center.facade=[WCFacade new]; ActiveContext=center;
    FallbackCenter=[NameCenter new]; FallbackCenter.manager=[CContactMgr new]; FallbackCalls=BadCalls=0;
    return manager;
}
static WAContact *MiniContact(id name) { WAContact *contact=[WAContact new]; contact.m_nsNickName=name; return contact; }
static CSMomentsCardModel *MiniCard(id username) {
    MiniAppInfo *info=[MiniAppInfo new]; info.appUserName=username;
    MiniAppItem *item=[MiniAppItem new]; item.weappInfo=info;
    CSMomentsCardModel *card=Card(@"author",item); card.contentKind=CSMomentsContentMiniApp;
    card.title=@"小程序"; card.sourceText=@"分享内容标题"; card.shareCoverURL=@""; return card;
}
static WAContactMgr *BeginMiniApps(void) {
    Begin(); WAContactMgr *manager=[WAContactMgr new]; manager.contacts=@{}; manager.queries=[NSMutableArray new];
    ((NameCenter *)ActiveContext).miniAppManager=manager; return manager;
}
static void TestRemarkPriorityAndFallbacks(void) {
    CContactMgr *manager=Begin();
    manager.contacts=@{@"remark":Contact(@" \n 我的备注 \t"),@"blank":Contact(@" \n\t"),@"empty":Contact(@""),@"nil":Contact(nil),@"number":Contact(@42)};
    NSMutableArray *cards=[NSMutableArray new];
    for(NSString *username in @[@"remark",@"blank",@"empty",@"nil",@"number",@"missing",@""])[cards addObject:Card(username,nil)];
    ApplyContactRemarks(cards);
    CHECK([((CSMomentsCardModel *)cards[0]).nickname isEqual:@"我的备注"]);
    for(NSUInteger i=1;i<cards.count;i++)CHECK([((CSMomentsCardModel *)cards[i]).nickname isEqual:@"朋友圈昵称"]);
    CHECK(manager.queries.count==6 && ![manager.queries containsObject:@""] && FallbackCalls==0);
    CHECK([((NameContact *)manager.contacts[@"remark"]).m_nsRemark isEqual:@" \n 我的备注 \t"]);
}
static void TestLookupReuseIsLimitedToOneUpdate(void) {
    CContactMgr *manager=Begin(); manager.contacts=@{@"author":Contact(@"备注")};
    NSArray *cards=@[Card(@"author",nil),Card(@"author",nil),Card(@"missing",nil),Card(@"missing",nil)];
    ApplyContactRemarks(cards);
    CHECK(manager.queries.count==2 && [manager.queries[0] isEqual:@"author"] && [manager.queries[1] isEqual:@"missing"]);
    CHECK([((CSMomentsCardModel *)cards[0]).nickname isEqual:@"备注"] && [((CSMomentsCardModel *)cards[1]).nickname isEqual:@"备注"]);
    ApplyContactRemarks(@[Card(@"author",nil)]); CHECK(manager.queries.count==3);
    [manager.queries removeAllObjects]; manager.throws=YES;
    CSMomentsCardModel *card=Card(@"author",nil); ApplyContactRemarks(@[card,Card(@"author",nil)]);
    CHECK(manager.queries.count==1 && [card.nickname isEqual:@"朋友圈昵称"]);
}
static void TestCurrentAccountAndNilContextBoundaries(void) {
    CContactMgr *first=Begin(); first.contacts=@{@"author":Contact(@"账号甲备注")};
    CSMomentsCardModel *a=Card(@"author",nil); ApplyContactRemarks(@[a]);
    CHECK([a.nickname isEqual:@"账号甲备注"]);
    CContactMgr *second=[CContactMgr new]; second.contacts=@{@"author":Contact(@"账号乙备注")}; second.queries=[NSMutableArray new];
    NameCenter *center=[NameCenter new]; center.manager=second; ActiveContext=center;
    CSMomentsCardModel *b=Card(@"author",nil); ApplyContactRemarks(@[b]);
    CHECK([b.nickname isEqual:@"账号乙备注"] && first.queries.count==1 && second.queries.count==1);
    FallbackCenter.manager=first; ActiveContext=nil;
    CSMomentsCardModel *loggedOut=Card(@"author",nil); ApplyContactRemarks(@[loggedOut]);
    CHECK([loggedOut.nickname isEqual:@"朋友圈昵称"] && FallbackCalls==0 && first.queries.count==1);
    ContextLookupClass=Nil; CSMomentsCardModel *legacy=Card(@"author",nil); ApplyContactRemarks(@[legacy]);
    CHECK([legacy.nickname isEqual:@"账号甲备注"] && FallbackCalls==1);
}
static long long BadLookup(id object,SEL selector,id value) { (void)object; (void)selector; (void)value; BadCalls++; return 0; }
static long long BadRemark(id object,SEL selector) { (void)object; (void)selector; BadCalls++; return 0; }
static id BadService(id object,SEL selector,id value) { (void)object; (void)selector; (void)value; BadCalls++; return nil; }
static Class Subclass(NSString *name,Class parent,SEL selector,IMP implementation,const char *types) {
    Class cls=objc_allocateClassPair(parent,name.UTF8String,0);
    CHECK(cls && class_addMethod(cls,selector,implementation,types)); objc_registerClassPair(cls); return cls;
}
static void TestMissingServicesAndABIMismatches(void) {
    CContactMgr *manager=Begin(); CSMomentsCardModel *card=Card(@"author",nil);
    ((NameCenter *)ActiveContext).manager=nil; ApplyContactRemarks(@[card]);
    CHECK([card.nickname isEqual:@"朋友圈昵称"] && manager.queries.count==0 && FallbackCalls==0);
    ((NameCenter *)ActiveContext).manager=manager; ContactLookupClass=Nil; ApplyContactRemarks(@[card]);
    CHECK(manager.queries.count==0 && FallbackCalls==0);
    ContactLookupClass=CContactMgr.class; ContextLookupClass=BadContextAccessor.class; ApplyContactRemarks(@[card]);
    CHECK(BadCalls==0 && FallbackCalls==0);
    ContextLookupClass=MMContext.class;
    Class badManager=Subclass(@"MomentsNamesBadManager",CContactMgr.class,@selector(getContactByName:),(IMP)BadLookup,"q@:@");
    ((NameCenter *)ActiveContext).manager=[badManager new]; ApplyContactRemarks(@[card]);
    CHECK(BadCalls==0 && [card.nickname isEqual:@"朋友圈昵称"]);
    ((NameCenter *)ActiveContext).manager=manager;
    Class badContact=Subclass(@"MomentsNamesBadContact",NSObject.class,@selector(m_nsRemark),(IMP)BadRemark,"q@:");
    manager.contacts=@{@"author":[badContact new]}; ApplyContactRemarks(@[card]);
    CHECK(BadCalls==0 && [card.nickname isEqual:@"朋友圈昵称"]);
    Class badCenter=Subclass(@"MomentsNamesBadCenter",NameCenter.class,@selector(getService:),(IMP)BadService,"@@:@");
    ActiveContext=[badCenter new]; ApplyContactRemarks(@[card]);
    CHECK(BadCalls==0 && FallbackCalls==0);
}
static void TestNestedAndForwardedServicesUseNormalMessages(void) {
    CContactMgr *manager=Begin(); manager.contacts=@{@"author":Contact(@"代理上下文备注")};
    NameCenter *center=ActiveContext; NameServiceWrapper *wrapper=[NameServiceWrapper alloc]; wrapper.target=manager; center.manager=wrapper;
    NestedContext *context=[NestedContext new]; context.serviceCenter=center; ActiveContext=context;
    CSMomentsCardModel *card=Card(@"author",nil); ApplyContactRemarks(@[card]);
    CHECK([card.nickname isEqual:@"代理上下文备注"] && manager.queries.count==1 && wrapper.forwards==1);
    CHECK(CurrentFacade()==center.facade && FallbackCalls==0);
}
static void TestSameNativeItemRemarkEditsChangeEquality(void) {
    CContactMgr *manager=Begin(); NameContact *contact=Contact(@"原备注"); manager.contacts=@{@"author":contact};
    id item=[NSObject new]; CSMomentsCardModel *old=Card(@"author",item); ApplyContactRemarks(@[old]);
    CSMomentsCardModel *unchanged=Card(@"author",item); ApplyContactRemarks(@[unchanged]);
    CHECK(SameCards(@[old],@[unchanged]));
    contact.m_nsRemark=@" 新备注 "; CSMomentsCardModel *edited=Card(@"author",item); ApplyContactRemarks(@[edited]);
    CHECK(old.item==edited.item && [old.nickname isEqual:@"原备注"] && [edited.nickname isEqual:@"新备注"]);
    CHECK(!SameCards(@[old],@[edited]));
    contact.m_nsRemark=@" \n"; CSMomentsCardModel *removed=Card(@"author",item); ApplyContactRemarks(@[removed]);
    CHECK([removed.nickname isEqual:@"朋友圈昵称"] && !SameCards(@[edited],@[removed]));
    CHECK(manager.queries.count==4);
}
static void TestSameNativeItemLocationEditsChangeEquality(void) {
    id item=[NSObject new];
    CSMomentsCardModel *old=Card(@"author",item),*updated=Card(@"author",item);
    CHECK(SameCards(@[old],@[updated]));
    updated.locationText=@"上海 · 西岸美术馆";
    CHECK(!SameCards(@[old],@[updated]));
    old.locationText=updated.locationText;
    CHECK(SameCards(@[old],@[updated]));
    updated.locationText=@"";
    CHECK(!SameCards(@[old],@[updated]));
}
static void TestMiniAppLocalNameResolution(void) {
    WAContactMgr *manager=BeginMiniApps();
    manager.contacts=@{@"valid":MiniContact(@" \n 探马助手 \t"), @"placeholder":MiniContact(@" 小程序名称 "),
        @"blank":MiniContact(@" \n"), @"number":MiniContact(@42), @"null":MiniContact(NSNull.null)};
    NSArray *cards=@[MiniCard(@" valid "), MiniCard(@"valid"), MiniCard(@"placeholder"), MiniCard(@"blank"),
        MiniCard(@"number"), MiniCard(@"null"), MiniCard(@"missing"), MiniCard(@"missing"),
        MiniCard(@" \n"), MiniCard(@42), MiniCard(NSNull.null), MiniCard(@[])];
    ApplyMiniAppNames(cards);
    CHECK([((CSMomentsCardModel *)cards[0]).title isEqual:@"探马助手"]);
    CHECK([((CSMomentsCardModel *)cards[1]).title isEqual:@"探马助手"]);
    for(NSUInteger i=2;i<cards.count;i++)CHECK([((CSMomentsCardModel *)cards[i]).title isEqual:@"小程序"]);
    for(CSMomentsCardModel *card in cards)CHECK([card.sourceText isEqual:@"分享内容标题"]);
    CHECK(manager.queries.count==6 && manager.forbiddenLookups==0 && FallbackCalls==0);
    CHECK([((WAContact *)manager.contacts[@"valid"]).m_nsNickName isEqual:@" \n 探马助手 \t"]);
    CHECK([((MiniAppInfo *)[(MiniAppItem *)((CSMomentsCardModel *)cards[0]).item weappInfo]).appUserName isEqual:@" valid "]);
    CSMomentsCardModel *published=MiniCard(@"missing"); published.title=@"发布来源名称";
    ApplyMiniAppNames(@[published]);
    CHECK([published.title isEqual:@"发布来源名称"] && manager.queries.count==7 && manager.forbiddenLookups==0);
    NameCenter *center=ActiveContext; NSUInteger before=center.services;
    ApplyMiniAppNames(@[Card(@"author",nil)]);
    CHECK(center.services==before);
}
static void TestMiniAppLookupReuseAndRefresh(void) {
    WAContactMgr *manager=BeginMiniApps(); WAContact *contact=MiniContact(@"原小程序名");
    manager.contacts=@{@"app":contact};
    CSMomentsCardModel *old=MiniCard(@"app"),*duplicate=MiniCard(@"app");
    ApplyMiniAppNames(@[old,duplicate]);
    CHECK([old.title isEqual:@"原小程序名"] && [duplicate.title isEqual:old.title] && manager.queries.count==1);
    CSMomentsCardModel *unchanged=MiniCard(@"app"); unchanged.item=old.item;
    ApplyMiniAppNames(@[unchanged]);
    CHECK(SameCards(@[old],@[unchanged]) && manager.queries.count==2);
    contact.m_nsNickName=@" 新小程序名 ";
    CSMomentsCardModel *updated=MiniCard(@"app"); updated.item=old.item;
    ApplyMiniAppNames(@[updated]);
    CHECK([updated.title isEqual:@"新小程序名"] && [old.title isEqual:@"原小程序名"]);
    CHECK(!SameCards(@[old],@[updated]) && manager.queries.count==3);
    contact.m_nsNickName=@" \n";
    CSMomentsCardModel *removed=MiniCard(@"app"); removed.item=old.item;
    ApplyMiniAppNames(@[removed]);
    CHECK([removed.title isEqual:@"小程序"] && !SameCards(@[updated],@[removed]));
    manager.throws=YES; [manager.queries removeAllObjects];
    CSMomentsCardModel *failed=MiniCard(@"app");
    ApplyMiniAppNames(@[failed,MiniCard(@"app")]);
    CHECK(manager.queries.count==1 && [failed.title isEqual:@"小程序"]);
    ApplyMiniAppNames(@[failed]);
    CHECK(manager.queries.count==2 && manager.forbiddenLookups==0);
}
static void TestMiniAppCurrentAccountAndABIBoundaries(void) {
    WAContactMgr *first=BeginMiniApps(); first.contacts=@{@"app":MiniContact(@"账号甲小程序")};
    CSMomentsCardModel *a=MiniCard(@"app"); ApplyMiniAppNames(@[a]);
    CHECK([a.title isEqual:@"账号甲小程序"]);
    WAContactMgr *second=[WAContactMgr new]; second.contacts=@{@"app":MiniContact(@"账号乙小程序")}; second.queries=[NSMutableArray new];
    NameCenter *center=[NameCenter new]; center.miniAppManager=second; ActiveContext=center;
    CSMomentsCardModel *b=MiniCard(@"app"); ApplyMiniAppNames(@[b]);
    CHECK([b.title isEqual:@"账号乙小程序"] && first.queries.count==1 && second.queries.count==1);
    FallbackCenter.miniAppManager=first; ActiveContext=nil;
    CSMomentsCardModel *loggedOut=MiniCard(@"app"); ApplyMiniAppNames(@[loggedOut]);
    CHECK([loggedOut.title isEqual:@"小程序"] && FallbackCalls==0 && first.queries.count==1);
    ActiveContext=center; center.miniAppManager=nil; ApplyMiniAppNames(@[loggedOut]);
    CHECK([loggedOut.title isEqual:@"小程序"] && FallbackCalls==0);
    center.miniAppManager=second; MiniAppLookupClass=Nil; ApplyMiniAppNames(@[loggedOut]);
    CHECK(second.queries.count==1 && FallbackCalls==0);
    MiniAppLookupClass=WAContactMgr.class; ContextLookupClass=BadContextAccessor.class; ApplyMiniAppNames(@[loggedOut]);
    CHECK(BadCalls==0 && FallbackCalls==0);
    ContextLookupClass=MMContext.class;
    Class badManager=Subclass(@"MomentsNamesBadMiniAppManager",WAContactMgr.class,@selector(getContactFromCache:),(IMP)BadLookup,"q@:@");
    center.miniAppManager=[badManager new]; ApplyMiniAppNames(@[loggedOut]);
    CHECK(BadCalls==0 && [loggedOut.title isEqual:@"小程序"]);
    Class badContact=Subclass(@"MomentsNamesBadMiniAppContact",NSObject.class,@selector(m_nsNickName),(IMP)BadRemark,"q@:");
    center.miniAppManager=second; second.contacts=@{@"app":[badContact new]}; ApplyMiniAppNames(@[loggedOut]);
    CHECK(BadCalls==0 && [loggedOut.title isEqual:@"小程序"] && second.forbiddenLookups==0);
    second.contacts=@{@"app":MiniContact(@"代理缓存名")};
    NameServiceWrapper *wrapper=[NameServiceWrapper alloc]; wrapper.target=second; center.miniAppManager=wrapper;
    NestedContext *nested=[NestedContext new]; nested.serviceCenter=center; ActiveContext=nested;
    ApplyMiniAppNames(@[loggedOut]);
    CHECK([loggedOut.title isEqual:@"代理缓存名"] && wrapper.forwards==1 && FallbackCalls==0);
}
int main(void) { @autoreleasepool {
    TestRemarkPriorityAndFallbacks(); TestLookupReuseIsLimitedToOneUpdate(); TestCurrentAccountAndNilContextBoundaries();
    TestMissingServicesAndABIMismatches(); TestNestedAndForwardedServicesUseNormalMessages(); TestSameNativeItemRemarkEditsChangeEquality();
    TestSameNativeItemLocationEditsChangeEquality();
    TestMiniAppLocalNameResolution(); TestMiniAppLookupReuseAndRefresh(); TestMiniAppCurrentAccountAndABIBoundaries();
    printf("Moments names: %lu checks passed (production current-account services, remarks and cache-only mini app names, per-update reuse, nil-context isolation, ABI and proxy forwarding, same-item name refresh).\n",(unsigned long)Assertions);
    return 0;
} }
