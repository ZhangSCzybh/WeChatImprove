#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import <stdatomic.h>
#import "CSRedEnvelopConfig.h"
#import "CSRedEnvelopParam.h"
#import "CSRedEnvelopParamQueue.h"

// All services and message sends below are in-process counters. No WeChat or network.
static NSUserDefaults *testDefaults;
static BOOL enabled=YES,groupEnabled=YES,privateEnabled=YES,autoReply=YES;
static NSInteger transferDelay;
static NSUInteger controlStarts,nativeMessageCalls,nativeStartCalls,manualConfirms,envelopeOpens,envelopeNotifies,queuedNormal,queuedSerial;
static NSMutableArray *pending,*messages;
static NSString *activeAccount;
static atomic_bool transferAdmissionEnabled=true;
static NSUInteger checks;
#define CHECK(x) do { checks++; if (!(x)) { fprintf(stderr,"FAIL %d: %s\n",__LINE__,#x); exit(1); } } while(0)
static id Defaults(id object,SEL selector) { (void)object;(void)selector;return testDefaults; }
static void AuditAsync(dispatch_queue_t queue,dispatch_block_t block) { (void)queue;[pending addObject:[block copy]]; }
static void AuditAfter(dispatch_time_t time,dispatch_queue_t queue,dispatch_block_t block) { (void)time;AuditAsync(queue,block); }
#define dispatch_async AuditAsync
#define dispatch_after AuditAfter
static void Drain(void) { NSUInteger iterations=0;while(pending.count) { CHECK(iterations++<100);dispatch_block_t block=pending.firstObject;[pending removeObjectAtIndex:0];block(); } }
static BOOL CSIsChatRoomName(NSString *name) { return [name hasSuffix:@"@chatroom"]; }
static BOOL isReceiveTransferEnabled(void) { return enabled; }
static BOOL isGroupReceiveEnabled(void) { return groupEnabled; }
static BOOL isPrivateReceiveEnabled(void) { return privateEnabled; }
static NSInteger getDelaySeconds(void) { return transferDelay; }
static BOOL isAutoReplyEnabled(void) { return autoReply; }
static NSString *getGroupAutoReplyContent(void) { return @"谢谢"; }
static NSString *getPrivateAutoReplyContent(void) { return @"谢谢"; }
static NSString *CSGetContactDisplayName(NSString *name) { return name; }
static BOOL CSSendTextMessage(NSString *content,NSString *session) { [messages addObject:@{@"content":content,@"session":session,@"account":activeAccount}];return YES; }
static void cs_sendTransferNotification(NSString *s,NSInteger amount,NSString *payer,BOOL group) { (void)s;(void)amount;(void)payer;(void)group; }
static NSString * const kReceiveTransferTotalCountKey=@"kReceiveTransferTotalCountKey";
static NSString * const kReceiveTransferTotalAmountKey=@"kReceiveTransferTotalAmountKey";
@interface WCPayInfoItem : NSObject
@property(nonatomic,copy) NSString *m_c2cNativeUrl,*transfer_receiver_username,*transfer_payer_username;
@property(nonatomic) unsigned int m_uiPaySubType;
@end
@implementation WCPayInfoItem @end
@interface CMessageWrap : NSObject
@property(nonatomic) unsigned int m_uiMessageType;
@property(nonatomic,copy) NSString *m_nsContent,*m_nsFromUsr,*m_nsToUsr;
@property(nonatomic,strong) WCPayInfoItem *m_oWCPayInfoItem;
@end
@implementation CMessageWrap @end
@interface UIViewController : NSObject
@property(nonatomic,strong) UIViewController *presentedViewController;
@end
@implementation UIViewController @end
@interface BaseMsgContentViewController : UIViewController @end
@implementation BaseMsgContentViewController @end
@interface UIWindow : NSObject
@property(nonatomic) BOOL isKeyWindow;
@property(nonatomic,strong) UIViewController *rootViewController;
@end
@implementation UIWindow @end
@interface UIApplication : NSObject
@property(nonatomic,copy) NSArray *windows;
+ (instancetype)sharedApplication;
@end
@implementation UIApplication
+ (instancetype)sharedApplication { static UIApplication *app; if(!app) { app=[self new];app.windows=@[]; }return app; }
@end
static UIViewController *cs_findViewController(UIViewController *vc,NSString *name) { (void)vc;(void)name;return nil; }
@interface WCPayControlData : NSObject
@property(nonatomic,copy) NSString *m_nsTransferID,*m_nsSelectedUserNameFromQRCode,*selectedTransferChatroomUsername;
@property(nonatomic) unsigned long long m_uiTransferInvalidTime;
@end
@implementation WCPayControlData @end
@interface WCPayControlMgr : NSObject
- (unsigned int)startReceiverConfirmTransferMoneyLogic:(id)host Data:(id)data;
@end
@implementation WCPayControlMgr
- (unsigned int)startReceiverConfirmTransferMoneyLogic:(id)host Data:(id)data { (void)host;(void)data;controlStarts++;return 0; }
@end
static id CSGetService(Class cls) { return cls==WCPayControlMgr.class ? [WCPayControlMgr new] : nil; }
static void cs_confirmTransfer(CMessageWrap *,BOOL,NSString *,NSString *);
#import "TransferAuditBody.h"
@interface TransferMessageManager : NSObject @end
@interface WCPayReveiverControlTransferControlLogic : NSObject
- (void)OnWCPayTransferMoneyStatusViewControllerConfirmTransfer;
@end
#import "TransferAuditHooks.h"

@interface HongBaoReq : NSObject
@property(nonatomic) unsigned int cgiCmd;
@property(nonatomic,strong) id reqText;
@end
@implementation HongBaoReq @end
@interface HongBaoRes : NSObject
@property(nonatomic) unsigned int cgiCmdid;
@property(nonatomic) int errorType,platRet;
@property(nonatomic,strong) id retText;
@end
@implementation HongBaoRes @end
@interface NSObject (NativeBuffer)
- (NSData *)buffer;
@end
@interface CSReceiveRedEnvelopOperation : NSObject
- (instancetype)initWithRedEnvelopParam:(CSRedEnvelopParam *)param delay:(unsigned int)delay;
@end
@implementation CSReceiveRedEnvelopOperation
- (instancetype)initWithRedEnvelopParam:(CSRedEnvelopParam *)param delay:(unsigned int)delay { (void)param;(void)delay;return [super init]; }
@end
@interface CSRedEnvelopTaskManager : NSObject
+ (instancetype)sharedManager;
- (void)addNormalTask:(id)task;
- (void)addSerialTask:(id)task;
@end
@implementation CSRedEnvelopTaskManager
+ (instancetype)sharedManager { static id manager;if(!manager)manager=[self new];return manager; }
- (void)addNormalTask:(id)task { (void)task;queuedNormal++; }
- (void)addSerialTask:(id)task { (void)task;queuedSerial++; }
@end
@interface WCRedEnvelopesLogicMgr : NSObject
- (void)OpenRedEnvelopesRequest:(id)params;
- (BOOL)cs_shouldReceiveRedEnvelop:(CSRedEnvelopParam *)param responseDict:(NSDictionary *)dict;
- (BOOL)cs_sendTextMessage:(NSString *)content toSession:(NSString *)session;
- (void)cs_sendRedEnvelopNotify:(NSString *)session amount:(NSInteger)amount totalAmount:(NSInteger)total isGroup:(BOOL)group;
@end
#import "EnvelopeAuditBody.h"
static CMessageWrap *Transfer(NSString *subtype) {
    CMessageWrap *w=[CMessageWrap new];w.m_uiMessageType=49;w.m_nsFromUsr=@"test@chatroom";w.m_nsToUsr=@"self";
    w.m_oWCPayInfoItem=[WCPayInfoItem new];w.m_oWCPayInfoItem.transfer_receiver_username=@"someone-else";
    w.m_oWCPayInfoItem.m_uiPaySubType=[subtype containsString:@">1<"] ? 1 : 3;
    w.m_nsContent=[NSString stringWithFormat:@"payer:\n<msg><appmsg><type>2000</type><title>转账</title><wcpayinfo>%@<transferid><![CDATA[audited-transfer]]></transferid><transfer_receiver_username><![CDATA[someone-else]]></transfer_receiver_username><feedesc><![CDATA[￥1.15]]></feedesc></wcpayinfo></appmsg></msg>",subtype?:@""];
    return w;
}
static void ResetTransfer(void) { [pending removeAllObjects];[messages removeAllObjects];controlStarts=0;enabled=groupEnabled=privateEnabled=autoReply=YES;activeAccount=@"self";transferDelay=0;[testDefaults setInteger:0 forKey:kReceiveTransferTotalCountKey]; }
static void TestTransfer(void) {
    ResetTransfer();CMessageWrap *thirdParty=Transfer(@"<paysubtype>1</paysubtype>");
    cs_handleTransferMessage(thirdParty);
    CHECK(controlStarts==1 && [testDefaults integerForKey:kReceiveTransferTotalCountKey]==1 && messages.count==0);
    Drain();CHECK(messages.count==1);
    printf("REPRO: unrelated group recipient schedules a reply and records success without any payment success callback.\n");
    ResetTransfer();cs_handleTransferMessage(Transfer(@"<paysubtype>3</paysubtype>"));Drain();CHECK(controlStarts==0 && messages.count==0);
    cs_handleTransferMessage(Transfer(nil));Drain();CHECK(controlStarts==1 && messages.count==1);
    printf("REPRO: recognized XML subtype 3 is skipped; absent XML subtype passes even when native pay subtype is 3.\n");
    ResetTransfer();TransferMessageManager *mgr=[TransferMessageManager new];[mgr AsyncOnAddMsg:@"test@chatroom" MsgWrap:thirdParty];[mgr AddMsg:@"test@chatroom" MsgWrap:thirdParty];Drain();
    CHECK(controlStarts==2 && messages.count==2 && nativeMessageCalls==2);
    printf("REPRO: the same transfer through both message entries starts twice and replies twice.\n");
    ResetTransfer();transferDelay=5;cs_handleTransferMessage(thirdParty);CHECK(controlStarts==0);enabled=NO;activeAccount=@"new-account";Drain();
    CHECK(controlStarts==1 && messages.count==1 && [messages[0][@"account"] isEqual:@"new-account"]);
    printf("REPRO: scheduled transfer survives disabling and account change; reply uses the new current account.\n");
    ResetTransfer();groupEnabled=privateEnabled=NO;WCPayReveiverControlTransferControlLogic *logic=[WCPayReveiverControlTransferControlLogic new];[logic startLogic];Drain();
    CHECK(nativeStartCalls==0 && manualConfirms==1);
    enabled=NO;[logic startLogic];CHECK(nativeStartCalls==1);
    printf("REPRO: master switch intercepts manual native start even with both receiving scopes disabled.\n");
    ResetTransfer();CMessageWrap *plain=Transfer(@"<paysubtype>1</paysubtype>");plain.m_nsContent=[plain.m_nsContent stringByReplacingOccurrencesOfString:@"<feedesc><![CDATA[￥1.15]]></feedesc>" withString:@"<feedesc>￥42.50</feedesc>"];
    [testDefaults setInteger:0 forKey:kReceiveTransferTotalAmountKey];cs_handleTransferMessage(plain);CHECK([testDefaults integerForKey:kReceiveTransferTotalCountKey]==1 && [testDefaults integerForKey:kReceiveTransferTotalAmountKey]==0);[pending removeAllObjects];
    printf("REPRO: plain-text feedesc increments success count with zero amount.\n");
}
static HongBaoReq *Request(unsigned int cmd,NSDictionary *body) { HongBaoReq *r=[HongBaoReq new];r.cgiCmd=cmd;r.reqText=[NSJSONSerialization dataWithJSONObject:body options:0 error:nil];return r; }
static HongBaoRes *Response(NSDictionary *body) { HongBaoRes *r=[HongBaoRes new];r.retText=[NSJSONSerialization dataWithJSONObject:body options:0 error:nil];return r; }
static CSRedEnvelopParam *Param(NSString *sid,NSString *sign) { CSRedEnvelopParam *p=[CSRedEnvelopParam new];p.sendId=sid;p.sign=sign;p.sessionUserName=@"test@chatroom";return p; }
static void EmptyQueue(void) { while(!CSRedEnvelopParamQueue.sharedQueue.isEmpty) [CSRedEnvelopParamQueue.sharedQueue dequeue]; }
static void TestEnvelope(void) {
    [messages removeAllObjects];CSRedEnvelopConfig *c=CSRedEnvelopConfig.sharedConfig;[c resetReceiveRecords];c.autoReceiveEnable=NO;c.groupAutoReplyText=@"谢谢红包";c.redEnvelopNotifyTarget=CSRedEnvelopNotifyTargetDisabled;
    WCRedEnvelopesLogicMgr *logic=[WCRedEnvelopesLogicMgr new];HongBaoReq *open=Request(4,@{@"sessionUserName":@"test@chatroom",@"sendId":@"untracked"});HongBaoRes *response=Response(@{@"amount":@100});response.errorType=1;response.platRet=-1;
    [logic cs_handleRedEnvelopOpenResponse:response request:open];[logic cs_handleRedEnvelopOpenResponse:response request:open];Drain();
    CHECK(messages.count==2 && c.totalReceiveCount==2 && c.totalReceiveAmount==200);
    printf("REPRO: untracked repeated open callbacks reply/count even with auto-receive off and transport error flags set, if a positive amount is present.\n");
    c.autoReceiveEnable=YES;c.groupRedEnvelopEnable=YES;c.groupRedEnvelopScope=0;c.serialReceive=YES;c.delaySeconds=0;
    CSRedEnvelopParamQueue *queue=CSRedEnvelopParamQueue.sharedQueue;
    [queue enqueue:Param(@"serial-zero",@"s1")];[logic cs_handleRedEnvelopReceiverQueryResponse:Response(@{@"timingIdentifier":@"t"}) request:Request(3,@{@"sendId":@"serial-zero"})];
    CHECK(envelopeOpens==1 && queuedSerial==0 && queuedNormal==0);
    c.delaySeconds=1;[queue enqueue:Param(@"serial-delay",@"s2")];[logic cs_handleRedEnvelopReceiverQueryResponse:Response(@{@"timingIdentifier":@"t"}) request:Request(3,@{@"sendId":@"serial-delay"})];CHECK(queuedSerial==1);
    printf("REPRO: serial mode is bypassed at zero delay; delayed requests use its queue.\n");
    [queue enqueue:Param(@"spent",@"s3")];[logic cs_handleRedEnvelopReceiverQueryResponse:Response(@{@"receiveStatus":@2}) request:Request(3,@{@"sendId":@"spent"})];CHECK(!queue.isEmpty && [queue.peek.sendId isEqual:@"spent"]);EmptyQueue();
    printf("REPRO: already-received query response leaves its pending entry retained.\n");
    CSRedEnvelopParam *a=Param(@"A",@"sign-A"),*b=Param(@"B",@"sign-B");[queue enqueue:a];[queue enqueue:b];CHECK([queue dequeueMatchingSign:@"sign-B" sendId:@"A"]==a);CHECK([queue dequeueMatchingSign:@"sign-B" sendId:@"unknown"]==b);
    printf("REPRO: conflicting sendId/sign selects by one key; unknown sendId can fall back to another sign.\n");
    for(NSUInteger i=0;i<600;i++) [queue enqueue:Param(@"duplicate",@"same-sign")];CHECK([[queue valueForKey:@"queue"] count]==600);EmptyQueue();
    printf("REPRO: duplicate query parameters accumulate without admission deduplication or a size cap.\n");
    BOOL exception=NO;@try { [logic cs_handleRedEnvelopReceiverQueryResponse:Response(@{@"receiveStatus":NSNull.null}) request:Request(3,@{})]; } @catch(NSException *e) { (void)e;exception=YES; }CHECK(exception);
    printf("REPRO: a wrong-type query status throws before native callback dispatch.\n");
}
int main(void) { @autoreleasepool {
    NSString *suite=[@"com.wechat.improve.payment-audit." stringByAppendingString:NSUUID.UUID.UUIDString];testDefaults=[[NSUserDefaults alloc] initWithSuiteName:suite];pending=[NSMutableArray array];messages=[NSMutableArray array];activeAccount=@"self";
    IMP old=method_setImplementation(class_getClassMethod(NSUserDefaults.class,@selector(standardUserDefaults)),(IMP)Defaults);
    TestTransfer();TestEnvelope();[testDefaults removePersistentDomainForName:suite];method_setImplementation(class_getClassMethod(NSUserDefaults.class,@selector(standardUserDefaults)),old);
    printf("Payment audit: %lu assertions passed, existing defects reproduced; host doubles only, no native requests or messages.\n",(unsigned long)checks);
    return 0;
} }
