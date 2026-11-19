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
@property(nonatomic,copy) NSString *identifier,*title,*username,*nickname,*locationText;
@property(nonatomic) CGSize coverSize;
@property(nonatomic) NSTimeInterval timestamp;
@property(nonatomic) NSUInteger mediaCount,likes,comments,epoch,revision;
@property(nonatomic) BOOL video,liked;
@end
@implementation CSMomentsCardModel @end
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
@property(nonatomic,strong) id manager,facade;
@property(nonatomic) NSUInteger services;
- (id)getService:(Class)serviceClass;
@end
@implementation NameCenter
- (id)getService:(Class)serviceClass {
    self.services++;
    if(serviceClass==CContactMgr.class)return self.manager;
    if(serviceClass==WCFacade.class)return self.facade;
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
static Class ContextLookupClass,ContactLookupClass;
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
    ContextLookupClass=MMContext.class; ContactLookupClass=CContactMgr.class;
    CContactMgr *manager=[CContactMgr new]; manager.contacts=@{}; manager.queries=[NSMutableArray new];
    NameCenter *center=[NameCenter new]; center.manager=manager; center.facade=[WCFacade new]; ActiveContext=center;
    FallbackCenter=[NameCenter new]; FallbackCenter.manager=[CContactMgr new]; FallbackCalls=BadCalls=0;
    return manager;
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
int main(void) { @autoreleasepool {
    TestRemarkPriorityAndFallbacks(); TestLookupReuseIsLimitedToOneUpdate(); TestCurrentAccountAndNilContextBoundaries();
    TestMissingServicesAndABIMismatches(); TestNestedAndForwardedServicesUseNormalMessages(); TestSameNativeItemRemarkEditsChangeEquality();
    TestSameNativeItemLocationEditsChangeEquality();
    printf("Moments names: %lu checks passed (production current-account services, remark priority/fallback, per-update reuse, nil-context isolation, ABI and proxy forwarding, same-item remark refresh).\n",(unsigned long)Assertions);
    return 0;
} }
