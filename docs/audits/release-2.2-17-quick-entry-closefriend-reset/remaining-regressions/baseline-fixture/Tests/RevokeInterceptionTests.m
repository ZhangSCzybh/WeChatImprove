#import <Foundation/Foundation.h>
#import <objc/message.h>
#import <objc/runtime.h>
#import "CSRevokeReference.h"
static unsigned checks;
#define CHECK(x) do { checks++;if (!(x)) { fprintf(stderr,"FAIL %d: %s\n",__LINE__,#x);return 1; } } while(0)
static NSString *account=@"me";
NSString *CSMessageCurrentAccount(void) { return account; }
id CSMessageNativeObject(id object, NSString *name) {
 SEL sel=NSSelectorFromString(name);NSMethodSignature *sig=[object methodSignatureForSelector:sel];
 if (sig.numberOfArguments!=2 || sig.methodReturnType[0]!='@') return nil;
 return ((id (*)(id,SEL))objc_msgSend)(object,sel);
}
@interface CMessageWrap : NSObject
@property(nonatomic,copy) NSString *m_nsContent,*m_nsFromUsr,*m_nsToUsr,*m_nsRealChatUsr,*m_nsPattern;
@property(nonatomic) unsigned int m_uiCreateTime,m_uiMessageType,m_uiStatus,m_uiMesLocalID;
@property(nonatomic) long long m_n64MesSvrID;
@property(nonatomic) BOOL isSender;
- (instancetype)initWithMsgType:(unsigned int)type;
@end
@implementation CMessageWrap
- (instancetype)initWithMsgType:(unsigned int)type { if ((self=[super init])) _m_uiMessageType=type;return self; }
@end
@interface CMessageMgr : NSObject
@property(nonatomic,strong) NSMutableDictionary *messages;
@property(nonatomic,strong) NSMutableArray *tips;
@property(nonatomic) BOOL failTip;
- (id)GetMsg:(NSString *)session n64SvrID:(long long)sid;
- (void)AddLocalMsg:(NSString *)session MsgWrap:(id)wrap;
@end
@implementation CMessageMgr
- (id)GetMsg:(NSString *)session n64SvrID:(long long)sid { return self.messages[[NSString stringWithFormat:@"%@/%lld",session,sid]]; }
- (void)AddLocalMsg:(NSString *)session MsgWrap:(id)wrap {
 if (self.failTip) [NSException raise:@"test-tip-failure" format:@"test"];
 [self.tips addObject:@[session,wrap]];
}
@end
static CMessageMgr *manager;
@interface MMContext : NSObject
+ (instancetype)currentContext;
- (id)getService:(Class)cls;
@end
@implementation MMContext
+ (instancetype)currentContext { static MMContext *ctx; if (!ctx) ctx=[self new];return ctx; }
- (id)getService:(Class)cls { return manager; }
@end
@interface RevokeInfo : NSObject
@property(nonatomic,strong) CMessageWrap *msgWrap;
@property(nonatomic,copy) NSString *nsChatName;
@end
@implementation RevokeInfo @end
#import "RevokeUnderTest.h"
static CMessageWrap *Original(NSString *session, long long sid, NSString *from, NSString *to, NSString *real) {
 CMessageWrap *w=[CMessageWrap new];w.m_n64MesSvrID=sid;w.m_uiMesLocalID=42;w.m_uiMessageType=1;
 w.m_nsContent=@"test content";w.m_nsFromUsr=from;w.m_nsToUsr=to;w.m_nsRealChatUsr=real;
 manager.messages[[NSString stringWithFormat:@"%@/%lld",session,sid]]=w;return w;
}
static CMessageWrap *Event(NSString *session,long long sid) {
 CMessageWrap *w=[CMessageWrap new];w.m_uiMessageType=10002;w.m_uiCreateTime=1700000000;
 w.m_nsContent=[NSString stringWithFormat:@"<sysmsg type='revokemsg'><revokemsg><session>%@</session><newmsgid>%lld</newmsgid><replacemsg><![CDATA[张三撤回了一条消息]]></replacemsg></revokemsg></sysmsg>",session,sid];
 w.m_nsFromUsr=session;w.m_nsToUsr=account;return w;
}
int main(void) { @autoreleasepool {
 manager=[CMessageMgr new];manager.messages=[NSMutableDictionary dictionary];manager.tips=[NSMutableArray array];
 Original(@"peer",101,@"peer",@"me",nil);CHECK(handleRevokeMessage(Event(@"peer",101),nil));
 CHECK(manager.tips.count==1);CHECK(handleRevokeMessage(Event(@"peer",101),nil));CHECK(manager.tips.count==1);
 Original(@"room@chatroom",102,@"room@chatroom",@"me",@"member");
 CHECK(handleRevokeMessage(Event(@"room@chatroom",102),nil));CHECK(manager.tips.count==2);
 CMessageWrap *tip=[manager.tips.lastObject lastObject];
 CHECK([tip.m_nsToUsr isEqual:@"room@chatroom"]);CHECK([tip.m_nsContent containsString:@"revoke_jump_v2_102_42"]);
 // Group transport content can have the sender envelope before the XML document.
 Original(@"room@chatroom",103,@"room@chatroom",@"me",@"member");
 CMessageWrap *prefixed=Event(@"room@chatroom",103);prefixed.m_nsContent=[@"member:\n" stringByAppendingString:prefixed.m_nsContent];
 CHECK(handleRevokeMessage(prefixed,nil));
 // A member-to-room message still belongs to the exact room queried by server ID.
 Original(@"room@chatroom",104,@"member",@"room@chatroom",@"member");
 CHECK(handleRevokeMessage(Event(@"room@chatroom",104),nil));
 // Transport direction on the revoke notification is not the original message's author.
 Original(@"room@chatroom",105,@"room@chatroom",@"me",@"member");
 CMessageWrap *direction=Event(@"room@chatroom",105);direction.isSender=YES;
 CHECK(handleRevokeMessage(direction,nil));
 // Self-authored group messages retain native revoke, even under localized replacement text.
 Original(@"room@chatroom",106,@"room@chatroom",@"me",@"me");CHECK(!handleRevokeMessage(Event(@"room@chatroom",106),nil));
 Original(@"peer",107,@"me",@"peer",nil);CHECK(!handleRevokeMessage(Event(@"peer",107),nil));
 Original(@"room@chatroom",108,@"other@chatroom",@"me",@"member");CHECK(!handleRevokeMessage(Event(@"room@chatroom",108),nil));
 Original(@"room@chatroom",109,@"room@chatroom",@"me",@"member").m_n64MesSvrID=999;
 CHECK(!handleRevokeMessage(Event(@"room@chatroom",109),nil));CHECK(!handleRevokeMessage(Event(@"room@chatroom",110),nil));
 Original(@"room@chatroom",111,@"room@chatroom",@"me",@"member");manager.failTip=YES;
 CHECK(handleRevokeMessage(Event(@"room@chatroom",111),nil));manager.failTip=NO;
 Original(@"room@chatroom",112,@"room@chatroom",@"me",@"member");account=@"";
 CHECK(!handleRevokeMessage(Event(@"room@chatroom",112),nil));account=@"me";
 RevokeInfo *info=[RevokeInfo new];info.msgWrap=Event(@"room@chatroom",112);info.nsChatName=@"room@chatroom";
 CHECK(revokeMsgWrapFromObject(info)==info.msgWrap);CHECK([revokeChatNameFromObject(info) isEqual:info.nsChatName]);
 CHECK(handleRevokeMessage(revokeMsgWrapFromObject(info),revokeChatNameFromObject(info)));
 // Execute all four production hook branches: YES means native deletion was suppressed.
 for (unsigned route=0;route<4;route++) {
  BOOL (*entry)(id)=route==0 ? testPrimary : route==1 ? testSecondary : route==2 ? testReplace : testDelete;
  long long sid=200+route;
  Original(@"room@chatroom",sid,@"room@chatroom",@"me",@"member");
  CMessageWrap *notice=Event(@"room@chatroom",sid);
  notice.m_nsContent=[@"member:\n" stringByAppendingString:notice.m_nsContent];
  RevokeInfo *context=[RevokeInfo new];context.msgWrap=notice;context.nsChatName=@"room@chatroom";
  id argument=route==0 ? (id)notice : context;
  [NSUserDefaults.standardUserDefaults setVolatileDomain:@{@"com.wechat.enhance.revoke.enabled":@NO} forName:NSArgumentDomain];
  NSUInteger tipCount=manager.tips.count;CHECK(!entry(argument));CHECK(manager.tips.count==tipCount);
  [NSUserDefaults.standardUserDefaults setVolatileDomain:@{@"com.wechat.enhance.revoke.enabled":@YES} forName:NSArgumentDomain];
  CHECK(entry(argument));CHECK(manager.tips.count==tipCount+1);CHECK(entry(argument));CHECK(manager.tips.count==tipCount+1);
  notice.m_nsContent=@"ordinary content";CHECK(!entry(argument));
 }
 // XML lacks a session: exact original identity can still be validated via the room hint.
 Original(@"room@chatroom",300,@"member",@"room@chatroom",@"member");
 CMessageWrap *withoutSession=Event(@"",300);withoutSession.m_nsFromUsr=@"member";
 CHECK(handleRevokeMessage(withoutSession,@"room@chatroom"));
 CHECK([[manager.tips.lastObject firstObject] isEqual:@"room@chatroom"]);
 Original(@"room@chatroom",301,@"room@chatroom",@"other@chatroom",@"member");
 CHECK(!handleRevokeMessage(Event(@"room@chatroom",301),nil));
 Original(@"room@chatroom",302,@"room@chatroom",@"me",@"member");
 CMessageWrap *selfText=Event(@"room@chatroom",302);
 selfText.m_nsContent=[selfText.m_nsContent stringByReplacingOccurrencesOfString:@"张三撤回了一条消息" withString:@"你撤回了一条消息"];
 CHECK(!handleRevokeMessage(selfText,nil));
 // Native replacement already quotes its actor; generated tips must not double-escape it.
 long long quoteID=400;
 for (NSString *actor in @[@"\"再也不会\"",@"&quot;再也不会&quot;",@"&#34;再也不会&#34;",@"“再也不会”"]) {
  Original(@"room@chatroom",quoteID,@"room@chatroom",@"me",@"member");
  CMessageWrap *quoted=Event(@"room@chatroom",quoteID++);
  quoted.m_nsContent=[quoted.m_nsContent stringByReplacingOccurrencesOfString:@"张三" withString:actor];
  CHECK(handleRevokeMessage(quoted,nil));
  CMessageWrap *rendered=[manager.tips.lastObject lastObject];
  CHECK([rendered.m_nsContent containsString:@"\n“再也不会”撤回了一条消息\n"]);
  CHECK(![rendered.m_nsContent containsString:@"&quot;"]);
  CHECK(CSRevokeResolveReference(nil,rendered.m_nsContent,rendered.m_nsPattern).serverID==quoteID-1);
 }
 Original(@"room@chatroom",500,@"room@chatroom",@"me",@"member").m_nsContent=@"<a href='revoke_jump_999'>\"text\" & more</a>";
 CMessageWrap *special=Event(@"room@chatroom",500);
 special.m_nsContent=[special.m_nsContent stringByReplacingOccurrencesOfString:@"张三" withString:@"\"A \"B\" & <C>\""];
 CHECK(handleRevokeMessage(special,nil));
 CMessageWrap *safeTip=[manager.tips.lastObject lastObject];
 CHECK([safeTip.m_nsContent containsString:@"“A \"B\" &amp; &lt;C&gt;”撤回了一条消息"]);
 CHECK(![safeTip.m_nsContent containsString:@"<a href='revoke_jump_999'>"]);
 CHECK(CSRevokeResolveReference(nil,safeTip.m_nsContent,safeTip.m_nsPattern).serverID==500);
 printf("PASS: %u production revoke interception checks (native service doubles)\n",checks);
 }return 0; }
