#import <Foundation/Foundation.h>
#import "CSPaymentAutomation.h"
#import "CSPaymentLedger.h"
#import <objc/message.h>
static NSUserDefaults *paymentDefaults;
static NSUInteger nativeNetworkSubmissions, submittedStatusQueries;
static NSMutableArray *deliveries;
static NSUInteger checks, originalCallbacks, nativeStarts, sentMessages, submittedTransfers, submittedQueries, submittedOpens;
static NSMutableArray *requests;
static NSString *testAccount=@"self";
static BOOL nativePaymentBusy;
#define CHECK(c) do { checks++; if (!(c)) { fprintf(stderr,"FAIL %d: %s\n",__LINE__,#c); exit(1); } } while(0)
NSString *const UIApplicationDidBecomeActiveNotification=@"TestActive", *const UIApplicationDidEnterBackgroundNotification=@"TestBackground";
id CSGetService(Class cls) { static NSMutableDictionary *services; if (!services) services=[NSMutableDictionary dictionary]; NSString *key=NSStringFromClass(cls); if (!key) return nil; if (!services[key]) services[key]=[cls new]; return services[key]; }
#import "PaymentAutomationUnderTest.h"
@interface TestContact : NSObject
@property NSString *m_nsUsrName;
@end
@implementation TestContact @end
@interface CContactMgr : NSObject
- (id)getSelfContact;
@end
@implementation CContactMgr
- (id)getSelfContact { TestContact *c=[TestContact new]; c.m_nsUsrName=testAccount; return c; }
@end
@interface TestBuffer : NSObject
@property NSData *buffer;
@end
@implementation TestBuffer @end
static id Buffer(NSDictionary *data) { TestBuffer *b=[TestBuffer new]; b.buffer=[NSJSONSerialization dataWithJSONObject:data options:0 error:NULL]; return b; }
@interface TestBase : NSObject
@property NSInteger ret;
@end
@implementation TestBase @end
@interface TestResponse : NSObject
@property TestBase *baseResponse;
@property NSInteger cgiCmdid, errorType, tenpayErrType, platRet;
@property TestBuffer *retText;
@end
@implementation TestResponse @end
@interface TestRequest : NSObject
@property TestBuffer *reqText;
@property NSInteger cgiCmd;
@end
@implementation TestRequest @end
@interface TenPayRequest : TestRequest @end
@implementation TenPayRequest @end
@interface HongBaoReq : TestRequest @end
@implementation HongBaoReq @end
@interface WCPayNetworkHelper : NSObject
- (void)WCToTenpayCommonRequest:(TenPayRequest *)request RetryCount:(unsigned int)retryCount routeInfo:(unsigned char)routeInfo;
@end
@implementation WCPayNetworkHelper
#import "TransferNetworkHooksUnderTest.h"
@end
@interface WCRedEnvelopesNetworkHelper : NSObject
- (void)WCToHongbaoCommonRequest:(HongBaoReq *)request;
@end
@implementation WCRedEnvelopesNetworkHelper
#import "EnvelopeNetworkHooksUnderTest.h"
@end
// Mirror native UTF-8, escaped form fields. No setter hook is invoked.
static TestBuffer *Form(NSDictionary *p, NSUInteger escapes) {
    NSMutableArray *pairs=[NSMutableArray array];
    NSCharacterSet *allowed=[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_.~"];
    for (NSString *key in [p.allKeys sortedArrayUsingSelector:@selector(compare:)]) {
        NSString *v=[p[key] description];
        for (NSUInteger i=0;i<escapes;i++) v=[v stringByAddingPercentEncodingWithAllowedCharacters:allowed];
        [pairs addObject:[NSString stringWithFormat:@"%@=%@",key,v]];
    }
    TestBuffer *b=[TestBuffer new]; b.buffer=[[pairs componentsJoinedByString:@"&"] dataUsingEncoding:NSUTF8StringEncoding]; return b;
}
@interface WCPayControlData : NSObject
@property NSString *m_nsTransferID, *selectedTransferChatroomUsername;
@property NSNumber *m_uiTransferInvalidTime;
@end
@implementation WCPayControlData @end
@interface WCPayReveiverControlTransferControlLogic : NSObject
@property WCPayControlData *data;
- (id)initWithData:(id)data;
- (void)startLogic;
- (void)nativeConfirm;
- (void)OnWCPayTransferMoneyStatusViewControllerConfirmTransfer;
@end
@implementation WCPayReveiverControlTransferControlLogic
#import "PaymentLogicHooksUnderTest.h"
- (void)nativeConfirm {
    NSMutableDictionary *p=[@{@"trans_id":self.data.m_nsTransferID,@"op":@"confirm"} mutableCopy];
    if (self.data.selectedTransferChatroomUsername) p[@"group_username"]=self.data.selectedTransferChatroomUsername;
    TenPayRequest *r=[TenPayRequest new]; r.reqText=Form(p,1); r.cgiCmd=85; [(id)CSGetService(WCPayNetworkHelper.class) WCToTenpayCommonRequest:r RetryCount:0 routeInfo:0]; [requests addObject:r]; submittedTransfers++;
}

@end
@interface WCPayControlMgr : NSObject
@property NSMutableArray *logics;
- (unsigned int)startReceiverConfirmTransferMoneyLogic:(id)vc Data:(id)data;
@end
@implementation WCPayControlMgr
- (BOOL)IsDoingWCPayLogic:(Class)c { return nativePaymentBusy; }
- (unsigned int)startReceiverConfirmTransferMoneyLogic:(id)vc Data:(id)data { WCPayReveiverControlTransferControlLogic *l=[[WCPayReveiverControlTransferControlLogic alloc] initWithData:data]; if (!self.logics) self.logics=[NSMutableArray array]; [self.logics addObject:l]; [l startLogic]; return 1; }
@end
@interface WCPayCheckTransferStatusRequest : NSObject
@property NSString *m_nsTransferID, *group_username;
@property NSNumber *m_uiInvalidTime;
@end
@implementation WCPayCheckTransferStatusRequest @end
@interface WCPayLogicMgr : NSObject
- (void)nativeLicense:(dispatch_block_t)block;
- (void)CheckTransferMoneyStatus:(WCPayCheckTransferStatusRequest *)data;
@end
@implementation WCPayLogicMgr
- (void)CheckTransferMoneyStatus:(WCPayCheckTransferStatusRequest *)data {
    NSMutableDictionary *p=[@{@"transfer_id":data.m_nsTransferID,@"invalid_time":data.m_uiInvalidTime} mutableCopy];
    if (data.group_username) p[@"group_username"]=data.group_username;
    TenPayRequest *r=[TenPayRequest new]; r.reqText=Form(p,1); r.cgiCmd=84;
    [(id)CSGetService(WCPayNetworkHelper.class) WCToTenpayCommonRequest:r RetryCount:0 routeInfo:0];
    [requests addObject:r]; submittedStatusQueries++;
}
- (void)nativeLicense:(dispatch_block_t)block { if (block) block(); }
#import "PaymentResponseHooksUnderTest.h"
@end
@interface WCRedEnvelopesLogicMgr : NSObject
- (void)ReceiverQueryRedEnvelopesRequest:(id)params;
- (void)OpenRedEnvelopesRequest:(id)params;
@end
@implementation WCRedEnvelopesLogicMgr
- (void)ReceiverQueryRedEnvelopesRequest:(id)p { HongBaoReq *r=[HongBaoReq new]; r.reqText=Form(p,1); r.cgiCmd=3; [(id)CSGetService(WCRedEnvelopesNetworkHelper.class) WCToHongbaoCommonRequest:r]; [requests addObject:r]; submittedQueries++; }
- (void)OpenRedEnvelopesRequest:(id)p { HongBaoReq *r=[HongBaoReq new]; r.reqText=Form(p,1); r.cgiCmd=4; [(id)CSGetService(WCRedEnvelopesNetworkHelper.class) WCToHongbaoCommonRequest:r]; [requests addObject:r]; submittedOpens++; }
#import "EnvelopeResponseHooksUnderTest.h"
@end
@interface TestPayInfo : NSObject
@property NSString *exclusive_recv_username;
@property NSString *m_nsTransferID, *transfer_receiver_username, *transfer_payer_username, *m_c2cNativeUrl;
@property NSUInteger m_uiPaySubType;
@end
@implementation TestPayInfo @end
@interface CMessageWrap : NSObject
@property unsigned int m_uiMessageType, m_uiCreateTime, m_uiStatus;
@property NSString *m_nsContent, *m_nsFromUsr, *m_nsToUsr, *m_nsRealChatUsr;
@property TestPayInfo *m_oWCPayInfoItem;
- (id)initWithMsgType:(unsigned int)type;
@end
@implementation CMessageWrap
- (id)initWithMsgType:(unsigned int)type { if ((self=[super init])) _m_uiMessageType=type; return self; }
@end
@interface CMessageMgr : NSObject
- (void)AddMsg:(id)session MsgWrap:(id)wrap;
@end
@implementation CMessageMgr
- (void)AddMsg:(id)session MsgWrap:(id)wrap { sentMessages++; [deliveries addObject:@{@"session":session,@"text":[wrap m_nsContent]}]; }
@end
static void Drain(void) { for (NSInteger i=0;i<8;i++) [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.005]]; }
static void Until(BOOL (^done)(void)) { NSDate *end=[NSDate dateWithTimeIntervalSinceNow:4]; while (!done() && end.timeIntervalSinceNow>0) Drain(); CHECK(done()); }
static void Setup(void) {
    for (CSPaymentTask *t in store.tasks) CSFinish(t);
    store=[CSPaymentTaskStore new]; receiptSources=[NSMutableDictionary dictionary]; requests=[NSMutableArray array]; submittedTransfers=submittedQueries=submittedOpens=sentMessages=0;
    testAccount=@"self"; nativePaymentBusy=NO; submittedStatusQueries=0; deliveries=[NSMutableArray array];
    [paymentDefaults setInteger:0 forKey:@"kReceiveTransferNotifyTargetKey"];
    [paymentDefaults removeObjectForKey:@"com.wechat.enhance.redenvelop.autoReplyEnable"];
    [paymentDefaults setInteger:0 forKey:@"com.wechat.enhance.redenvelop.groupScope"];
    [paymentDefaults setBool:YES forKey:@"kReceiveTransferAutoEnableKey"];
    [paymentDefaults setBool:YES forKey:@"kReceiveTransferPrivateEnableKey"];
    [paymentDefaults setBool:YES forKey:@"kReceiveTransferGroupEnableKey"];
    [paymentDefaults setBool:YES forKey:@"kReceiveTransferAutoReplyEnableKey"];
    [paymentDefaults setObject:@"thanks" forKey:@"kReceiveTransferPrivateAutoReplyKey"];
    [paymentDefaults setObject:@"thanks" forKey:@"kReceiveTransferGroupAutoReplyKey"];
    [paymentDefaults setInteger:0 forKey:@"kReceiveTransferDelayKey"];
    [paymentDefaults setBool:YES forKey:@"com.wechat.enhance.redenvelop.autoReceive"];
    [paymentDefaults setBool:YES forKey:@"com.wechat.enhance.redenvelop.privateEnable"];
    [paymentDefaults setBool:YES forKey:@"com.wechat.enhance.redenvelop.groupEnable"];
    [paymentDefaults setBool:NO forKey:@"com.wechat.enhance.redenvelop.serialReceive"];
    [paymentDefaults setInteger:0 forKey:@"com.wechat.enhance.redenvelop.delay"];
    [paymentDefaults setObject:@"thanks" forKey:@"com.wechat.enhance.redenvelop.groupReply"];
    [paymentDefaults setObject:@"thanks" forKey:@"com.wechat.enhance.redenvelop.privateReply"];
    transferSettings=CSSettings(NO); envelopeSettings=CSSettings(YES);
    atomic_store(&transferEnabled,true); atomic_store(&envelopeEnabled,true); activeAccount=CSAccount();
}
static CMessageWrap *Message(NSString *identifier, NSString *receiver, BOOL env) {
    CMessageWrap *w=[[CMessageWrap alloc] initWithMsgType:49]; w.m_nsFromUsr=@"room@chatroom"; w.m_nsToUsr=@"self";
    TestPayInfo *p=[TestPayInfo new]; p.m_nsTransferID=identifier; p.transfer_receiver_username=receiver; p.transfer_payer_username=@"payer"; p.m_uiPaySubType=1;
    p.m_c2cNativeUrl=[NSString stringWithFormat:@"wxpay://c2cbizmessagehandler/hongbao/receivehongbao?sendid=%@&channelid=1&msgtype=1&sign=s",identifier]; w.m_oWCPayInfoItem=p;
    w.m_nsContent=[NSString stringWithFormat:@"<msg><wcpayinfo><transferid>%@</transferid><paysubtype>1</paysubtype></wcpayinfo></msg>",identifier]; return w;
}
static TestResponse *Response(id request, NSDictionary *body) { TestResponse *r=[TestResponse new]; r.cgiCmdid=[request cgiCmd]; r.retText=Buffer(body); return r; }
static void Respond(id req, NSDictionary *body, BOOL env) {
    id mgr=CSGetService(NSClassFromString(env?@"WCRedEnvelopesLogicMgr":@"WCPayLogicMgr"));
    SEL s=NSSelectorFromString(env?@"OnWCToHongbaoCommonResponse:Request:":@"OnWCToTenpayCommonResponse:Request:");
    ((void(*)(id,SEL,id,id))objc_msgSend)(mgr,s,Response(req,body),req); Drain();
}
static NSDictionary *Receipt(long long cents) {
    return @{@"retcode":@0,@"trans_status":@2001,@"fee":@(cents),@"fee_type":@"CNY",@"payer_name":@"payer",@"receiver_name":@"self",@"is_payer":@0};
}
static void CompleteTransfer(id req, NSDictionary *confirmation) {
    CSPaymentTask *t=CSPaymentOwner(req);
    Respond(req,confirmation,NO);
    if (t.phase==CSPaymentVerifying && t.queryRequest) Respond(t.queryRequest,Receipt(4250),NO);
}
int main(void) { @autoreleasepool {
    NSString *suite=[@"payment-automation-tests-" stringByAppendingString:NSUUID.UUID.UUIDString]; paymentDefaults=[[NSUserDefaults alloc] initWithSuiteName:suite];
    NSURL *dir=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:suite]];
    ledger=[[CSPaymentLedger alloc] initWithURL:[dir URLByAppendingPathComponent:@"ledger.plist"] defaults:paymentDefaults];
    __block BOOL loaded=NO; [ledger load:^{loaded=YES;}]; Until(^BOOL{ return loaded; }); CHECK(ledger.ready);
    Setup();
    // Confirmation is not the final receipt. Native 8.0.78 performs command 84 next.
    CSPaymentAdmitMessage(Message(@"confirm-without-receipt-fields",@"self",NO),NO); Drain();
    Respond(requests.lastObject,@{@"retcode":@0},NO);
    CHECK(submittedStatusQueries==1 && sentMessages==0);
    Setup();
    CMessageWrap *third=Message(@"third",@"other",NO); CSPaymentAdmitMessage(third,NO); Drain(); CHECK(!submittedTransfers && !sentMessages && !store.tasks.count);
    third.m_oWCPayInfoItem.m_uiPaySubType=3; CSPaymentAdmitMessage(third,NO); Drain(); CHECK(!submittedTransfers);
    WCPayReveiverControlTransferControlLogic *manual=[[WCPayReveiverControlTransferControlLogic alloc] initWithData:[WCPayControlData new]];
    [manual startLogic]; CHECK(nativeStarts==1);
    nativePaymentBusy=YES; CSPaymentAdmitMessage(Message(@"manual-busy",@"self",NO),NO); Drain(); CHECK(!submittedTransfers); nativePaymentBusy=NO;
    CMessageWrap *mine=Message(@"mine",@"self",NO); CSPaymentAdmitMessage(mine,NO); CSPaymentAdmitMessage(mine,NO); Drain();
    CHECK(submittedTransfers==1); CHECK(sentMessages==0); CHECK(CSPaymentOwner(requests.lastObject)!=nil);
    NSDictionary *success=@{@"retcode":@0,@"fee":@4250,@"fee_type":@"CNY",@"payer":@"payer",@"receiver":@"self",@"real_name_info":@{@"guide_flag":@0,@"guide_wording":@""}};
    id request=requests.lastObject; CompleteTransfer(request,success); Until(^BOOL{ return sentMessages==1; });
    CompleteTransfer(request,success); CHECK(sentMessages==1); CHECK([paymentDefaults integerForKey:@"kReceiveTransferTotalCountKey"]==1); CHECK(!store.tasks.count);
    TenPayRequest *unowned=[TenPayRequest new]; unowned.cgiCmd=85; unowned.reqText=Buffer(@{@"trans_id":@"manual",@"op":@"confirm"}); CompleteTransfer(unowned,success); CHECK(sentMessages==1);
    Setup(); CSPaymentAdmitMessage(Message(@"error",@"self",NO),NO); Drain();
    Respond(requests.lastObject,@{@"retcode":@1,@"fee":@4250,@"fee_type":@"CNY",@"payer":@"payer",@"receiver":@"self"},NO); CHECK(!sentMessages && !store.tasks.count);
    Setup(); [paymentDefaults setInteger:10 forKey:@"kReceiveTransferDelayKey"]; transferSettings=CSSettings(NO); CSPaymentAdmitMessage(Message(@"disabled",@"self",NO),NO); Drain(); CHECK(store.tasks.count==1 && !submittedTransfers);
    [paymentDefaults setBool:NO forKey:@"kReceiveTransferAutoEnableKey"]; CSPaymentReload(); Drain(); CHECK(!store.tasks.count && !submittedTransfers);
    Setup(); CSPaymentAdmitMessage(Message(@"epoch",@"self",NO),NO); Drain(); request=requests.lastObject;
    CSPaymentAccountWillChange(); testAccount=@"new-self"; CSPaymentAccountDidChange(); CompleteTransfer(request,success); CHECK(!sentMessages && !store.tasks.count);
    Setup(); CSPaymentAdmitMessage(Message(@"relogin",@"self",NO),NO); Drain(); request=requests.lastObject;
    CSPaymentAccountWillChange(); CSPaymentAccountDidChange(); CompleteTransfer(request,success); CHECK(!sentMessages);
    Setup(); CSPaymentAdmitMessage(Message(@"success-after-disable",@"self",NO),NO); Drain(); request=requests.lastObject;
    NSInteger countBefore=[paymentDefaults integerForKey:@"kReceiveTransferTotalCountKey"];
    [paymentDefaults setBool:NO forKey:@"kReceiveTransferAutoEnableKey"]; CSPaymentReload(); Drain(); CHECK(store.tasks.count==1);
    CompleteTransfer(request,success); Until(^BOOL{ return [paymentDefaults integerForKey:@"kReceiveTransferTotalCountKey"]==countBefore+1; }); CHECK(!sentMessages);
    Setup(); CSPaymentTask *deferred=[CSPaymentTask new]; deferred.account=@"self"; deferred.epoch=atomic_load(&paymentEpoch); deferred.key=@"deferred"; deferred.session=@"room@chatroom"; deferred.phase=CSPaymentConfirming; deferred.deadline=CSNow()+30;
    CHECK([store add:deferred now:CSNow()]);
    __block dispatch_block_t accept=nil; __block NSUInteger accepted=0;
    CSPaymentWithOwner(deferred,^{ accept=CSPaymentGuardConfirmation(^{ accepted++; }); });
    accept(); CHECK(accepted==1);
    CSPaymentAccountWillChange(); CSPaymentAccountDidChange(); accept(); CHECK(accepted==1); Drain();
    Setup(); CSPaymentAdmitMessage(Message(@"timeout",@"self",NO),NO); Drain(); request=requests.lastObject; store.tasks.firstObject.deadline=CSNow()-10000; CSPump(); CompleteTransfer(request,success); CHECK(!sentMessages && !store.tasks.count);

    Setup(); [paymentDefaults setBool:YES forKey:@"com.wechat.enhance.redenvelop.serialReceive"]; envelopeSettings=CSSettings(YES);
    for (NSInteger i=0;i<3;i++) CSPaymentAdmitMessage(Message([NSString stringWithFormat:@"env%ld",(long)i],@"self",YES),YES);
    Drain(); CHECK(submittedQueries==1 && submittedOpens==0);
    request=requests.lastObject; NSDictionary *query=@{@"retcode":@0,@"receiveStatus":@0,@"hbStatus":@2,@"timingIdentifier":@"token"};
    Respond(request,query,YES); CHECK(submittedOpens==1 && submittedQueries==1); CHECK(store.tasks.count==3);
    id open=requests.lastObject; Respond(request,query,YES); CHECK(submittedOpens==1);
    Respond(open,@{@"retcode":@0,@"amount":@100},YES); Until(^BOOL{ return sentMessages==1; }); CHECK(submittedQueries==2); CHECK(store.tasks.count==2);
    Respond(open,@{@"retcode":@0,@"amount":@100},YES); CHECK(sentMessages==1);
    Respond(requests.lastObject,@{@"retcode":@0,@"receiveStatus":@2,@"hbStatus":@2},YES); CHECK(store.tasks.count==1);
    Respond(requests.lastObject,@{@"retcode":@0,@"receiveStatus":NSNull.null,@"hbStatus":@2},YES); CHECK(!store.tasks.count);
    Setup(); for (NSInteger i=0;i<8;i++) CSPaymentAdmitMessage(Message([NSString stringWithFormat:@"parallel%ld",(long)i],@"self",YES),YES);
    Drain(); CHECK(submittedQueries==5 && store.tasks.count==8);
    [paymentDefaults setBool:YES forKey:@"com.wechat.enhance.redenvelop.serialReceive"]; CSPaymentReload(); Drain(); CHECK(submittedQueries==5);
    NSArray *active=[requests copy]; for (id r in active) Respond(r,@{@"retcode":@1},YES);
    CHECK(submittedQueries==6); CHECK(store.tasks.count==3);
    [paymentDefaults setBool:NO forKey:@"com.wechat.enhance.redenvelop.autoReceive"]; CSPaymentReload(); Drain(); CHECK(!store.tasks.count);
    NSUInteger replies=sentMessages; Respond(requests.lastObject,@{@"retcode":@0,@"amount":@100},YES); CHECK(sentMessages==replies);
    Setup(); CMessageWrap *outgoing=Message(@"outgoing",@"self",YES); outgoing.m_nsFromUsr=@"self"; outgoing.m_nsToUsr=@"friend"; CSPaymentAdmitMessage(outgoing,YES); Drain(); CHECK(!submittedQueries);
    CMessageWrap *groupSelf=Message(@"group-self",@"self",YES); groupSelf.m_nsRealChatUsr=@"self"; CSPaymentAdmitMessage(groupSelf,YES); Drain(); CHECK(!submittedQueries);
    CMessageWrap *missing=Message(@"missing",@"self",YES); missing.m_oWCPayInfoItem.m_c2cNativeUrl=@"wxpay://c2cbizmessagehandler/hongbao/receivehongbao?sendid=missing"; CSPaymentAdmitMessage(missing,YES); Drain(); CHECK(!submittedQueries);
    Setup(); CSPaymentAdmitMessage(Message(@"mismatch",@"self",YES),YES); Drain(); HongBaoReq *r=requests.lastObject;
    r.reqText=Buffer(@{@"sendId":@"other",@"channelId":@"1",@"msgType":@"1",@"nativeUrl":@"other"}); Respond(r,query,YES); CHECK(!store.tasks.count && !submittedOpens);
    Setup(); CMessageWrap *privateMessage=Message(@"private-success",@"self",NO); privateMessage.m_nsFromUsr=@"payer"; CSPaymentAdmitMessage(privateMessage,NO); Drain();
    CHECK(submittedTransfers==1); CompleteTransfer(requests.lastObject,success); Until(^BOOL{ return sentMessages==1; });
    Setup(); CSPaymentAdmitMessage(Message(@"transport",@"self",YES),YES); Drain();
    TestResponse *transport=Response(requests.lastObject,query); transport.platRet=1;
    [(id)CSGetService(WCRedEnvelopesLogicMgr.class) OnWCToHongbaoCommonResponse:transport Request:requests.lastObject]; Drain(); CHECK(!store.tasks.count && !submittedOpens);
    Setup(); CSPaymentAdmitMessage(Message(@"bad-timing",@"self",YES),YES); Drain();
    Respond(requests.lastObject,@{@"retcode":@0,@"receiveStatus":@0,@"hbStatus":@2,@"timingIdentifier":NSNull.null},YES); CHECK(!store.tasks.count && !submittedOpens);
    Setup(); CSPaymentAdmitMessage(Message(@"bad-amount",@"self",YES),YES); Drain(); Respond(requests.lastObject,query,YES); CHECK(submittedOpens==1);
    Respond(requests.lastObject,@{@"retcode":@0,@"amount":NSNull.null},YES); CHECK(!store.tasks.count && !sentMessages);
    Setup(); [paymentDefaults setInteger:10 forKey:@"com.wechat.enhance.redenvelop.delay"]; [paymentDefaults setBool:YES forKey:@"com.wechat.enhance.redenvelop.serialReceive"]; envelopeSettings=CSSettings(YES);
    CSPaymentAdmitMessage(Message(@"delayed-envelope",@"self",YES),YES); Drain(); Respond(requests.lastObject,query,YES); CHECK(!submittedOpens && store.tasks.firstObject.phase==CSPaymentReady);
    store.tasks.firstObject.deadline=CSNow()-100; CSPump(); CHECK(!submittedOpens && !store.tasks.count);
    Setup(); [paymentDefaults setInteger:1 forKey:@"com.wechat.enhance.redenvelop.groupScope"]; [paymentDefaults setObject:@[@"other@chatroom"] forKey:@"com.wechat.enhance.redenvelop.allowedGroups"]; envelopeSettings=CSSettings(YES);
    CSPaymentAdmitMessage(Message(@"whitelist",@"self",YES),YES); Drain(); CHECK(!submittedQueries);
    [paymentDefaults setInteger:0 forKey:@"com.wechat.enhance.redenvelop.groupScope"];
    [paymentDefaults setInteger:-100 forKey:@"kReceiveTransferDelayKey"]; CHECK([CSSettings(NO)[@"delay"] integerValue]==0);
    [paymentDefaults setInteger:100000 forKey:@"com.wechat.enhance.redenvelop.delay"]; CHECK([CSSettings(YES)[@"delay"] integerValue]==10);
    Setup(); for (NSInteger i=0;i<1000;i++) { CMessageWrap *w=[CMessageWrap new]; w.m_uiMessageType=1; CSPaymentAdmitMessage(w,YES); CSPaymentAdmitMessage(w,NO); } Drain(); CHECK(!store.tasks.count && !submittedQueries && !submittedTransfers && !timer);
    // Private cards use direction plus original subtype when native group fields are absent.
    Setup(); privateMessage=Message(@"private-empty-fields",@"self",NO); privateMessage.m_nsFromUsr=@"payer";
    privateMessage.m_oWCPayInfoItem.transfer_receiver_username=nil; privateMessage.m_oWCPayInfoItem.transfer_payer_username=nil; privateMessage.m_oWCPayInfoItem.m_uiPaySubType=0;
    CSPaymentAdmitMessage(privateMessage,NO); Drain(); CHECK(submittedTransfers==1);
    long long beforeAmount=[paymentDefaults objectForKey:@"kReceiveTransferTotalAmountKey"] ? [[paymentDefaults objectForKey:@"kReceiveTransferTotalAmountKey"] longLongValue] : 0;
    CompleteTransfer(requests.lastObject,success); Until(^BOOL{ return sentMessages==1; });
    CHECK([[paymentDefaults objectForKey:@"kReceiveTransferTotalAmountKey"] longLongValue]==beforeAmount+4250);

    // Native scalar defaults and optional baseResponse/retcode; positive success fields remain mandatory.
    Setup(); CSPaymentAdmitMessage(Message(@"protobuf-defaults",@"self",NO),NO); Drain();
    transport=Response(requests.lastObject,@{@"fee":@20,@"fee_type":@1,@"payer":@"payer",@"receiver":@"self"}); transport.cgiCmdid=0;
    [(id)CSGetService(WCPayLogicMgr.class) OnWCToTenpayCommonResponse:transport Request:requests.lastObject];
    Drain(); CHECK(submittedStatusQueries==1 && !sentMessages); Respond(requests.lastObject,Receipt(20),NO);
    Until(^BOOL{ return sentMessages==1; });
    for (NSDictionary *invalid in @[
        @{@"retcode":NSNull.null,@"fee":@20,@"fee_type":@1,@"payer":@"payer",@"receiver":@"self"}
    ]) {
        Setup(); CSPaymentAdmitMessage(Message(NSUUID.UUID.UUIDString,@"self",NO),NO); Drain(); Respond(requests.lastObject,invalid,NO); CHECK(!sentMessages && !store.tasks.count);
    }
    Setup(); CSPaymentAdmitMessage(Message(@"base-error",@"self",NO),NO); Drain();
    transport=Response(requests.lastObject,success); transport.baseResponse=[TestBase new]; transport.baseResponse.ret=1;
    [(id)CSGetService(WCPayLogicMgr.class) OnWCToTenpayCommonResponse:transport Request:requests.lastObject]; Drain(); CHECK(!sentMessages && !store.tasks.count);
    Setup(); CSPaymentAdmitMessage(Message(@"command-error",@"self",NO),NO); Drain();
    transport=Response(requests.lastObject,success); transport.cgiCmdid=3;
    [(id)CSGetService(WCPayLogicMgr.class) OnWCToTenpayCommonResponse:transport Request:requests.lastObject]; Drain(); CHECK(!sentMessages && !store.tasks.count);

    // Native protobuf setters are ordinary assignments. Only the network hook associates requests.
    Setup(); CSPaymentTask *encoded=[CSPaymentTask new]; encoded.account=@"self"; encoded.epoch=atomic_load(&paymentEpoch); encoded.key=@"encoded"; encoded.session=@"room@chatroom";
    encoded.payload=@{@"id":@"id&x=1",@"payer":@"payer",@"invalidtime":@0}; encoded.phase=CSPaymentConfirming; encoded.deadline=CSNow()+30; CHECK([store add:encoded now:CSNow()]);
    TenPayRequest *encodedRequest=[TenPayRequest new]; encodedRequest.reqText=Form(@{@"trans_id":@"id&x=1",@"op":@"confirm",@"group_username":@"room@chatroom"},2); encodedRequest.cgiCmd=85;
    CHECK(!CSPaymentOwner(encodedRequest));
    CSPaymentWithOwner(encoded,^{ [(id)CSGetService(WCPayNetworkHelper.class) WCToTenpayCommonRequest:encodedRequest RetryCount:0 routeInfo:0]; });
    CHECK(CSPaymentOwner(encodedRequest)==encoded); CompleteTransfer(encodedRequest,success); Until(^BOOL{ return sentMessages==1; });

    // Manual confirmation after auto submission was skipped must count once and preserve native UI.
    Setup(); nativePaymentBusy=YES; CSPaymentAdmitMessage(Message(@"manual-mine",@"self",NO),NO); Drain(); CHECK(!submittedTransfers && receiptSources.count==1);
    TenPayRequest *manualRequest=[TenPayRequest new]; manualRequest.cgiCmd=85;
    manualRequest.reqText=Form(@{@"trans_id":@"manual-mine",@"op":@"confirm",@"group_username":@"room@chatroom"},1);
    [(id)CSGetService(WCPayNetworkHelper.class) WCToTenpayCommonRequest:manualRequest RetryCount:0 routeInfo:0]; CHECK([CSPaymentOwner(manualRequest) observation]);
    countBefore=[paymentDefaults integerForKey:@"kReceiveTransferTotalCountKey"];
    CompleteTransfer(manualRequest,success); Until(^BOOL{ return sentMessages==1; }); CompleteTransfer(manualRequest,success);
    CHECK([paymentDefaults integerForKey:@"kReceiveTransferTotalCountKey"]==countBefore+1);
    Setup(); CSPaymentAdmitMessage(Message(@"manual-other",@"other",NO),NO); Drain(); manualRequest=[TenPayRequest new]; manualRequest.cgiCmd=85;
    manualRequest.reqText=Form(@{@"trans_id":@"manual-other",@"op":@"confirm",@"group_username":@"room@chatroom"},1);
    [(id)CSGetService(WCPayNetworkHelper.class) WCToTenpayCommonRequest:manualRequest RetryCount:0 routeInfo:0];
    CompleteTransfer(manualRequest,success); CHECK(!CSPaymentOwner(manualRequest) && !sentMessages && !receiptSources.count);

    // Private envelopes and legacy receiveAmount response; reply switch never gates accounting.
    Setup(); CMessageWrap *privateEnvelope=Message(@"private-envelope",@"self",YES); privateEnvelope.m_nsFromUsr=@"payer";
    CSPaymentAdmitMessage(privateEnvelope,YES); Drain(); CHECK(submittedQueries==1);
    NSDictionary *nativeQuery=@{@"receiveStatus":@0,@"hbStatus":@2,@"timingIdentifier":@"token+/%"};
    Respond(requests.lastObject,nativeQuery,YES); CHECK(submittedOpens==1);
    countBefore=[paymentDefaults integerForKey:@"com.wechat.enhance.redenvelop.totalCount"];
    [paymentDefaults setBool:NO forKey:@"com.wechat.enhance.redenvelop.autoReplyEnable"]; CSPaymentReload(); Drain();
    Respond(requests.lastObject,@{@"receiveAmount":@88},YES);
    Until(^BOOL{ return [paymentDefaults integerForKey:@"com.wechat.enhance.redenvelop.totalCount"]==countBefore+1; }); CHECK(!sentMessages);
    CHECK(![CSSettings(YES)[@"reply"] boolValue]);
    [paymentDefaults setBool:YES forKey:@"com.wechat.enhance.redenvelop.autoReplyEnable"]; CHECK([CSSettings(YES)[@"reply"] boolValue]);

    // Missing pay-info URL is resolved from the bounded XML fields; conflicting recipients are rejected.
    Setup(); CMessageWrap *xmlEnvelope=Message(@"xml-envelope",@"self",YES);
    NSString *originalURL=xmlEnvelope.m_oWCPayInfoItem.m_c2cNativeUrl; xmlEnvelope.m_oWCPayInfoItem.m_c2cNativeUrl=nil;
    xmlEnvelope.m_nsContent=[NSString stringWithFormat:@"<msg><appmsg><wcpayinfo><nativeurl><![CDATA[%@]]></nativeurl><exclusive_recv_username>self</exclusive_recv_username></wcpayinfo></appmsg></msg>",originalURL];
    CSPaymentAdmitMessage(xmlEnvelope,YES); Drain(); CHECK(submittedQueries==1);
    Respond(requests.lastObject,nativeQuery,YES); Respond(requests.lastObject,@{@"retcode":@0,@"amount":@15},YES); Until(^BOOL{ return sentMessages==1; });
    Setup(); xmlEnvelope.m_nsContent=[xmlEnvelope.m_nsContent stringByReplacingOccurrencesOfString:@">self<" withString:@">other<"];
    CSPaymentAdmitMessage(xmlEnvelope,YES); Drain(); CHECK(!submittedQueries && !receiptSources.count);
    CMessageWrap *exclusive=Message(@"exclusive-other",@"self",YES); exclusive.m_oWCPayInfoItem.exclusive_recv_username=@"other";
    CSPaymentAdmitMessage(exclusive,YES); Drain(); CHECK(!submittedQueries && !receiptSources.count);
    Setup(); exclusive=Message(@"exclusive-query",@"self",YES); CSPaymentAdmitMessage(exclusive,YES); Drain();
    Respond(requests.lastObject,@{@"retcode":@0,@"receiveStatus":@0,@"hbStatus":@2,@"timingIdentifier":@"token",@"exclusive_recv_username":@"other"},YES); CHECK(!submittedOpens && !sentMessages && !receiptSources.count);

    // Manual open races with a delayed automatic open: one receipt, no later automated open.
    Setup(); [paymentDefaults setInteger:10 forKey:@"com.wechat.enhance.redenvelop.delay"]; envelopeSettings=CSSettings(YES);
    CSPaymentAdmitMessage(Message(@"manual-envelope",@"self",YES),YES); Drain(); Respond(requests.lastObject,nativeQuery,YES);
    CSPaymentTask *pending=store.tasks.firstObject; NSMutableDictionary *manualParams=[pending.payload[@"params"] mutableCopy]; manualParams[@"timingIdentifier"]=@"manual-token";
    HongBaoReq *manualOpen=[HongBaoReq new]; manualOpen.cgiCmd=4; manualOpen.reqText=Form(manualParams,2);
    [(id)CSGetService(WCRedEnvelopesNetworkHelper.class) WCToHongbaoCommonRequest:manualOpen]; CHECK([CSPaymentOwner(manualOpen) observation]);
    Respond(manualOpen,@{@"amount":@77},YES); Until(^BOOL{ return sentMessages==1; }); CHECK(!submittedOpens && !store.tasks.count);
    Respond(manualOpen,@{@"amount":@77},YES); CHECK(sentMessages==1);
    Setup(); CSPaymentAdmitMessage(Message(@"amount-conflict",@"self",YES),YES); Drain(); Respond(requests.lastObject,nativeQuery,YES);
    Respond(requests.lastObject,@{@"amount":@1,@"receiveAmount":@2},YES); CHECK(!sentMessages && !store.tasks.count);
    // Receipt effects: both chat types, reply on/off, and all notification targets.
    for (NSNumber *group in @[@NO,@YES]) for (NSNumber *notify in @[@0,@1,@2]) for (NSNumber *reply in @[@NO,@YES]) {
        Setup();
        [paymentDefaults setInteger:notify.integerValue forKey:@"kReceiveTransferNotifyTargetKey"];
        [paymentDefaults setBool:reply.boolValue forKey:@"kReceiveTransferAutoReplyEnableKey"]; transferSettings=CSSettings(NO);
        CMessageWrap *card=Message(NSUUID.UUID.UUIDString,@"self",NO);
        if (!group.boolValue) card.m_nsFromUsr=@"payer";
        NSInteger priorCount=[paymentDefaults integerForKey:@"kReceiveTransferTotalCountKey"];
        long long priorAmount=[[paymentDefaults objectForKey:@"kReceiveTransferTotalAmountKey"] longLongValue];
        __block NSUInteger refreshed=0;
        id observer=[NSNotificationCenter.defaultCenter addObserverForName:CSPaymentStatisticsDidChangeNotification object:ledger queue:nil usingBlock:^(__unused NSNotification *n){ refreshed++; }];
        CSPaymentAdmitMessage(card,NO); Drain(); id confirm=requests.lastObject;
        // Acknowledge without fee, currency or confirmation-specific identities.
        Respond(confirm,@{@"retcode":@0},NO);
        CHECK(submittedStatusQueries==1 && !sentMessages && store.tasks.firstObject.phase==CSPaymentVerifying);
        CHECK([paymentDefaults integerForKey:@"kReceiveTransferTotalCountKey"]==priorCount);
        CHECK(!refreshed);
        id statusRequest=requests.lastObject; NSDictionary *params=CSPaymentDecode([[statusRequest reqText] buffer]);
        CHECK([params[@"transfer_id"] isEqual:card.m_oWCPayInfoItem.m_nsTransferID]);
        CHECK(group.boolValue ? [params[@"group_username"] isEqual:@"room@chatroom"] : !params[@"group_username"]);
        Respond(confirm,@{@"retcode":@0},NO); CHECK(submittedStatusQueries==1); // No second status query.
        Respond(statusRequest,Receipt(123),NO);
        Until(^BOOL{ return [paymentDefaults integerForKey:@"kReceiveTransferTotalCountKey"]==priorCount+1; });
        CHECK([[paymentDefaults objectForKey:@"kReceiveTransferTotalAmountKey"] longLongValue]==priorAmount+123);
        CHECK(refreshed==1);
        CHECK(sentMessages==(NSUInteger)(reply.boolValue+(notify.integerValue!=0)));
        if (reply.boolValue) CHECK(([deliveries.firstObject isEqual:@{@"session":card.m_nsFromUsr,@"text":@"thanks"}]));
        if (notify.integerValue) {
            NSDictionary *notification=deliveries.lastObject;
            CHECK([notification[@"session"] isEqual:notify.integerValue==1?@"self":@"filehelper"]);
            CHECK([notification[@"text"] containsString:@"收到转账提醒"] && [notification[@"text"] containsString:@"CNY 1.23"]);
            CHECK([notification[@"text"] containsString:card.m_nsFromUsr]);
        }
        NSUInteger effects=sentMessages;
        Respond(statusRequest,Receipt(123),NO); Respond(confirm,@{@"retcode":@0},NO); CSPaymentAdmitMessage(card,NO); Drain();
        CHECK(sentMessages==effects && submittedStatusQueries==1 && submittedTransfers==1);
        CHECK([paymentDefaults integerForKey:@"kReceiveTransferTotalCountKey"]==priorCount+1);
        CHECK(!store.tasks.count && !timer);
        [NSNotificationCenter.defaultCenter removeObserver:observer];
    }
    // Never record pending, rejected, refunded, mismatched, malformed or failed status responses.
    for (NSDictionary *delta in @[
        @{@"trans_status":@2000},@{@"trans_status":@2002},@{@"trans_status":@2003},@{@"trans_status":@2004},@{@"trans_status":@2005},@{@"trans_status":NSNull.null},
        @{@"receiver_name":@"other"},@{@"payer_name":@"other"},@{@"receiver_name":NSNull.null},@{@"payer_name":NSNull.null},
        @{@"fee":@0},@{@"fee":@-1},@{@"fee":@"0.01"},@{@"fee":NSNull.null},@{@"fee_type":NSNull.null},
        @{@"is_payer":@1},@{@"is_payer":NSNull.null},@{@"retcode":@1},@{@"wx_error_type":@1}
    ]) {
        Setup(); CSPaymentAdmitMessage(Message(NSUUID.UUID.UUIDString,@"self",NO),NO); Drain();
        Respond(requests.lastObject,@{@"retcode":@0},NO); CHECK(submittedStatusQueries==1);
        NSInteger before=[paymentDefaults integerForKey:@"kReceiveTransferTotalCountKey"];
        NSMutableDictionary *body=[Receipt(100) mutableCopy]; [body addEntriesFromDictionary:delta];
        Respond(requests.lastObject,body,NO);
        CHECK(!sentMessages && !store.tasks.count && !timer);
        CHECK([paymentDefaults integerForKey:@"kReceiveTransferTotalCountKey"]==before);
    }
    // Intermediate prompts are neither proof of settlement nor proof of failure.
    // Only the exact final receipt can authorize statistics and message effects.
    for (NSNumber *settled in @[@NO,@YES]) {
        Setup(); CSPaymentAdmitMessage(Message(NSUUID.UUID.UUIDString,@"self",NO),NO); Drain();
        NSInteger before=[paymentDefaults integerForKey:@"kReceiveTransferTotalCountKey"];
        Respond(requests.lastObject,@{@"retcode":@0,@"real_name_info":@{@"guide_flag":@1},@"half_page_info":@{@"title":@"notice"}},NO);
        CHECK(submittedStatusQueries==1 && !sentMessages);
        NSMutableDictionary *body=[Receipt(61) mutableCopy]; body[@"trans_status"]=settled.boolValue?@2001:@2000;
        Respond(requests.lastObject,body,NO);
        if (settled.boolValue) Until(^BOOL{ return sentMessages==1; });
        CHECK(sentMessages==(NSUInteger)settled.boolValue);
        CHECK([paymentDefaults integerForKey:@"kReceiveTransferTotalCountKey"]==before+settled.boolValue);
    }
    // Final response must be from this task's exact query, not a broadcast or another request.
    Setup(); CSPaymentAdmitMessage(Message(@"exact-status",@"self",NO),NO); Drain();
    id confirm=requests.lastObject; Respond(confirm,@{@"retcode":@0},NO); id statusRequest=requests.lastObject;
    TenPayRequest *unownedStatus=[TenPayRequest new]; unownedStatus.cgiCmd=84; unownedStatus.reqText=[statusRequest reqText];
    [(id)CSGetService(WCPayNetworkHelper.class) WCToTenpayCommonRequest:unownedStatus RetryCount:0 routeInfo:0];
    CHECK(!CSPaymentOwner(unownedStatus)); Respond(unownedStatus,Receipt(99),NO); CHECK(!sentMessages);
    Respond(confirm,Receipt(99),NO); CHECK(!sentMessages && submittedStatusQueries==1);
    // A copied/mutated query with another transaction cannot satisfy the receipt check.
    [(TenPayRequest *)statusRequest setReqText:Form(@{@"transfer_id":@"other",@"group_username":@"room@chatroom"},1)];
    Respond(statusRequest,Receipt(99),NO); CHECK(!sentMessages && !store.tasks.count);

    Setup(); CSPaymentAdmitMessage(Message(@"status-expired",@"self",NO),NO); Drain(); Respond(requests.lastObject,@{@"retcode":@0},NO);
    statusRequest=requests.lastObject; store.tasks.firstObject.deadline=CSNow()-1; CSPump(); Respond(statusRequest,Receipt(100),NO);
    CHECK(!sentMessages && !store.tasks.count && !timer && submittedStatusQueries==1);
    Setup(); CSPaymentAdmitMessage(Message(@"status-account-change",@"self",NO),NO); Drain(); Respond(requests.lastObject,@{@"retcode":@0},NO);
    statusRequest=requests.lastObject; CSPaymentAccountWillChange(); testAccount=@"other-account"; CSPaymentAccountDidChange(); Respond(statusRequest,Receipt(100),NO);
    CHECK(!sentMessages && !store.tasks.count);
    Setup(); CSPaymentAdmitMessage(Message(@"status-network-error",@"self",NO),NO); Drain(); Respond(requests.lastObject,@{@"retcode":@0},NO);
    transport=Response(requests.lastObject,Receipt(100));
    [(id)CSGetService(WCPayLogicMgr.class) OnWCToTenpayCommonErrorResponse:transport Request:requests.lastObject]; Drain();
    CHECK(!sentMessages && !store.tasks.count);

    // Disabling during final verification still records the settled receipt, without sending effects.
    Setup(); CSPaymentAdmitMessage(Message(@"disable-during-status",@"self",NO),NO); Drain(); Respond(requests.lastObject,@{@"retcode":@0},NO);
    countBefore=[paymentDefaults integerForKey:@"kReceiveTransferTotalCountKey"];
    [paymentDefaults setBool:NO forKey:@"kReceiveTransferAutoEnableKey"]; CSPaymentReload(); Drain();
    CHECK(store.tasks.count==1); Respond(requests.lastObject,Receipt(37),NO);
    Until(^BOOL{ return [paymentDefaults integerForKey:@"kReceiveTransferTotalCountKey"]==countBefore+1; }); CHECK(!sentMessages);
    // Native confirmation/status broadcasts alone do not emit plugin effects.
    Setup(); CSPaymentAdmitMessage(Message(@"broadcast-only",@"self",NO),NO); Drain();
    WCPayReveiverControlTransferControlLogic *owned=[(WCPayControlMgr *)CSGetService(WCPayControlMgr.class) logics].lastObject;
    NSUInteger callbacksBefore=originalCallbacks;
    [owned OnConfirmTransferMoney:Receipt(100) Error:nil]; [owned OnCheckTransferMoneyStatus:Receipt(100) Error:nil];
    CHECK(!sentMessages && !submittedStatusQueries && originalCallbacks==callbacksBefore);
    [manual OnCheckTransferMoneyStatus:Receipt(100) Error:nil]; CHECK(originalCallbacks==callbacksBefore+1);
    // Verify the persisted totals agree with the settings mirror after all settled receipts.
    NSDictionary *persisted=[NSDictionary dictionaryWithContentsOfURL:[dir URLByAppendingPathComponent:@"ledger.plist"]];
    CHECK([persisted[@"totals"] isEqual:ledger.totals]);
    for (CSPaymentTask *t in store.tasks) CSFinish(t); CSPump();
    CHECK(nativeNetworkSubmissions>20);
    CHECK(originalCallbacks>=15);
    if (timer) { dispatch_source_cancel(timer); timer=nil; }
    [paymentDefaults removePersistentDomainForName:suite]; [NSFileManager.defaultManager removeItemAtURL:dir error:NULL];
    printf("Payment automation: %lu checks passed; native callbacks preserved\n",(unsigned long)checks);
} return 0; }
