#import "CSCloseFriendCallReply.h"
// Actual 8.0.78 ABI and persisted-message status semantics; no real messaging.
@interface CMessageWrap : NSObject <NSCopying>
@property(nonatomic,copy) NSString *m_nsContent,*m_nsFromUsr,*m_nsToUsr;
@property(nonatomic) unsigned int m_uiCreateTime,m_uiStatus,m_uiMessageType,m_uiMesLocalID;
@property(nonatomic) long long m_n64MesSvrID;
- (instancetype)initWithMsgType:(long long)type;
@end
@implementation CMessageWrap
- (instancetype)initWithMsgType:(long long)type {if((self=[super init]))self.m_uiMessageType=(unsigned int)type;return self;}
- (id)copyWithZone:(NSZone *)zone {
    CMessageWrap *copy=[[CMessageWrap allocWithZone:zone] initWithMsgType:self.m_uiMessageType];
    copy.m_nsContent=self.m_nsContent;copy.m_nsFromUsr=self.m_nsFromUsr;copy.m_nsToUsr=self.m_nsToUsr;
    copy.m_uiCreateTime=self.m_uiCreateTime;copy.m_uiStatus=self.m_uiStatus;
    copy.m_uiMesLocalID=self.m_uiMesLocalID;copy.m_n64MesSvrID=self.m_n64MesSvrID;return copy;
}
@end
@interface CMessageMgr : NSObject
@property(nonatomic) NSUInteger sent,modified;
@property(nonatomic) BOOL throwAfterInsert;
@property(nonatomic) BOOL throwWhenMarkingSending,disableWhenMarkingSending;
@property(nonatomic,strong) CMessageWrap *lastWrap;
@property(nonatomic,copy) NSString *lastReceiver;
@property(nonatomic,strong) NSMutableDictionary<NSNumber *,CMessageWrap *> *records;
- (void)AddMsg:(NSString *)receiver MsgWrap:(CMessageWrap *)wrap;
- (CMessageWrap *)GetMsg:(NSString *)receiver LocalID:(unsigned int)localID;
- (void)ModMsg:(NSString *)receiver MsgWrap:(CMessageWrap *)wrap;
@end
@implementation CMessageMgr
- (instancetype)init {if((self=[super init]))self.records=[NSMutableDictionary dictionary];return self;}
- (void)AddMsg:(NSString *)receiver MsgWrap:(CMessageWrap *)wrap {
    self.sent++;self.lastWrap=wrap;self.lastReceiver=receiver;wrap.m_uiMesLocalID=(unsigned int)self.sent;
    self.records[@(wrap.m_uiMesLocalID)]=[wrap copy];
    if(self.throwAfterInsert)@throw [NSException exceptionWithName:@"native-handoff" reason:nil userInfo:nil];
}
- (CMessageWrap *)GetMsg:(NSString *)receiver LocalID:(unsigned int)localID {
    CMessageWrap *wrap=self.records[@(localID)];return [wrap.m_nsToUsr isEqual:receiver]?[wrap copy]:nil;
}
- (void)ModMsg:(NSString *)receiver MsgWrap:(CMessageWrap *)wrap {
    CHECK([receiver isEqual:wrap.m_nsToUsr] && self.records[@(wrap.m_uiMesLocalID)]!=nil);
    self.modified++;self.records[@(wrap.m_uiMesLocalID)]=[wrap copy];
    if(wrap.m_uiStatus==1 && self.disableWhenMarkingSending)Policy=Snapshot(YES,NO,nil);
    if(wrap.m_uiStatus==1 && self.throwWhenMarkingSending)@throw [NSException exceptionWithName:@"native-modify" reason:nil userInfo:nil];
}
@end
@interface SendMessageMgr : NSObject
@property(nonatomic) NSUInteger queued,checks;
@property(nonatomic,strong) CMessageWrap *lastWrap;
@end
@implementation SendMessageMgr
- (void)AddMsgToSendTable:(NSString *)receiver MsgWrap:(CMessageWrap *)wrap {
    CHECK(wrap.m_uiMesLocalID && [receiver isEqual:wrap.m_nsToUsr]);self.queued++;self.lastWrap=[wrap copy];
}
- (void)CheckResend {self.checks++;}
@end
static NSTimeInterval ReplyFixtureNow;
static NSMutableArray<NSDictionary *> *ReplyJobs;
static void AdvanceReplies(NSTimeInterval delta) {
    NSTimeInterval end=ReplyFixtureNow+delta;NSUInteger runs=0;
    while(YES) {
        NSUInteger index=NSNotFound;NSTimeInterval when=end;
        for(NSUInteger i=0;i<ReplyJobs.count;i++) {
            NSTimeInterval candidate=[ReplyJobs[i][@"when"] doubleValue];
            if(candidate<=end && (index==NSNotFound || candidate<when)){index=i;when=candidate;}
        }
        if(index==NSNotFound)break;
        dispatch_block_t block=ReplyJobs[index][@"block"];[ReplyJobs removeObjectAtIndex:index];ReplyFixtureNow=when;
        if(++runs>1000){fprintf(stderr,"unbounded reply scheduling\n");exit(1);}block();
    }
    ReplyFixtureNow=end;
}
static void PumpReplies(void) {AdvanceReplies(0);}
static CSCloseFriendCallToken *ReplyToken(unsigned long long room) {
    CSCloseFriendCallToken *token=[CSCloseFriendCallToken new];
    token.subject=[CSCloseFriendAlertSubject subjectForSession:@"friend" sender:@"friend"];
    token.roomID=room;token.roomKey=7;token.roomType=1;token.key=[NSString stringWithFormat:@"reply-%llu",room];token.state=@"rejectionSubmitted";return token;
}
static CMessageMgr *ResetReplies(void) {
    Epoch++;Policy=Snapshot(YES,NO,@{@"callReplyEnabled":@YES,@"callReplyText":@"稍后联系"});
    ReplyFixtureNow=100;ReplyJobs=[NSMutableArray array];
    CSCFCallReplyConfigureTesting(^NSTimeInterval{return ReplyFixtureNow;},^(NSTimeInterval delay,dispatch_block_t block){
        [ReplyJobs addObject:@{@"when":@(ReplyFixtureNow+delay),@"block":[block copy]}];
    });
    CMessageMgr *manager=[CMessageMgr new];FixtureServices=[@{@"CMessageMgr":manager,@"SendMessageMgr":[SendMessageMgr new]} mutableCopy];return manager;
}
static void ReplyStatus(CMessageMgr *manager,unsigned int status,long long server,BOOL notify) {
    CMessageWrap *stored=manager.records[@(manager.lastWrap.m_uiMesLocalID)];stored.m_uiStatus=status;stored.m_n64MesSvrID=server;
    if(notify)CSCFCallReplyMessageDidChange([stored copy]);
}
static void CallReplyChecks(void) {
    CMessageMgr *messages=ResetReplies();Policy=Snapshot(YES,NO,nil);
    CHECK(![Policy.options[@"callReplyEnabled"] boolValue] && [Policy.options[@"callReplyText"] length]>0);
    CSCFCallDidReject(ReplyToken(300));PumpReplies();CHECK(messages.sent==0);
    Policy=Snapshot(YES,YES,@{@"callReplyEnabled":@YES,@"callReplyText":@"稍后联系"});
    __weak CSCloseFriendCallToken *weak;
    @autoreleasepool {
        CSCloseFriendCallToken *first=ReplyToken(301);weak=first;
        CSCFCallDidReject(first);CSCFCallDidReject(first);CSCFCallDidReject(ReplyToken(302));
        first.state=@"native-ended";first.subject=nil;first=nil;
    }
    Policy=Snapshot(YES,YES,@{@"callReplyEnabled":@YES,@"callReplyText":@"新的设置内容"});PumpReplies();
    CHECK(!weak && messages.sent==1 && [messages.lastReceiver isEqual:@"friend"] && [messages.lastWrap.m_nsContent isEqual:@"稍后联系"]);
    CHECK(messages.lastWrap.m_uiMessageType==1 && messages.lastWrap.m_uiStatus==1 && [messages.lastWrap.m_nsFromUsr isEqual:@"self"] && [messages.lastWrap.m_nsToUsr isEqual:@"friend"]);
    CHECK(CSCloseFriendMethodMatches(class_getInstanceMethod(CMessageWrap.class,@selector(initWithMsgType:)),"@@:q"));
    AdvanceReplies(2);ReplyStatus(messages,2,9001,YES);PumpReplies();AdvanceReplies(298);
    CSCFCallDidReject(ReplyToken(303));PumpReplies();CHECK(messages.sent==1);
    AdvanceReplies(2);CSCFCallDidReject(ReplyToken(304));PumpReplies();CHECK(messages.sent==2);
    CSCFCallDidReject(ReplyToken(301));PumpReplies();CHECK(messages.sent==2);

    // Service readiness retries happen before AddMsg; exhaustion consumes no slot.
    messages=ResetReplies();[FixtureServices removeObjectForKey:@"CMessageMgr"];
    CSCFCallDidReject(ReplyToken(310));CSCFCallDidReject(ReplyToken(311));PumpReplies();CHECK(messages.sent==0);
    FixtureServices[@"CMessageMgr"]=messages;AdvanceReplies(1);CHECK(messages.sent==1);
    messages=ResetReplies();[FixtureServices removeObjectForKey:@"CMessageMgr"];
    CSCFCallDidReject(ReplyToken(312));AdvanceReplies(8);CHECK(messages.sent==0);
    FixtureServices[@"CMessageMgr"]=messages;CSCFCallDidReject(ReplyToken(312));PumpReplies();CHECK(messages.sent==1);

    // Epoch, opt-out, and current rejection policy are checked at every handoff.
    messages=ResetReplies();CSCFCallDidReject(ReplyToken(320));Epoch++;Policy=Snapshot(YES,NO,@{@"callReplyEnabled":@YES});PumpReplies();CHECK(messages.sent==0);
    messages=ResetReplies();CSCFCallDidReject(ReplyToken(321));Policy=Snapshot(YES,NO,nil);PumpReplies();CHECK(messages.sent==0);
    messages=ResetReplies();CSCFCallDidReject(ReplyToken(322));Policy=Snapshot(YES,NO,@{@"callReplyEnabled":@YES,@"rejectVoice":@NO});PumpReplies();CHECK(messages.sent==0);
    messages=ResetReplies();CSCloseFriendCallToken *suppressed=ReplyToken(323);suppressed.state=@"presentationSuppressed";CSCFCallDidReject(suppressed);
    CSCloseFriendCallToken *group=ReplyToken(324);group.subject=[CSCloseFriendAlertSubject subjectForSession:@"secret@chatroom" sender:@"friend"];CSCFCallDidReject(group);
    CSCloseFriendCallToken *ordinary=ReplyToken(325);ordinary.subject=[CSCloseFriendAlertSubject subjectForSession:@"ordinary" sender:@"ordinary"];CSCFCallDidReject(ordinary);
    PumpReplies();CHECK(messages.sent==0);
    CSCloseFriendCallToken *video=ReplyToken(326);video.roomType=2;CSCFCallDidReject(video);PumpReplies();CHECK(messages.sent==1);

    // Lost completion callback is covered by bounded persisted-status polling.
    messages=ResetReplies();SendMessageMgr *sender=FixtureServices[@"SendMessageMgr"];
    CSCFCallDidReject(ReplyToken(330));PumpReplies();unsigned int local=messages.lastWrap.m_uiMesLocalID,time=messages.lastWrap.m_uiCreateTime;
    ReplyStatus(messages,5,0,NO);AdvanceReplies(2);AdvanceReplies(2);
    CHECK(messages.sent==1 && messages.modified==1 && sender.queued==1 && sender.checks==1 && messages.records.count==1);
    CHECK(sender.lastWrap.m_uiMesLocalID==local && sender.lastWrap.m_uiCreateTime==time && [sender.lastWrap.m_nsContent isEqual:@"稍后联系"]);
    CHECK(messages.records[@(local)].m_uiStatus==1);
    CMessageWrap *oldFailure=[messages.records[@(local)] copy];oldFailure.m_uiStatus=5;
    CSCFCallReplyMessageDidChange(oldFailure);CSCFCallReplyMessageDidChange(oldFailure);PumpReplies();AdvanceReplies(2);CHECK(sender.queued==1);
    ReplyStatus(messages,5,0,YES);PumpReplies();AdvanceReplies(7);CHECK(sender.queued==1);AdvanceReplies(1);CHECK(sender.queued==2 && messages.sent==1);
    ReplyStatus(messages,5,0,YES);PumpReplies();AdvanceReplies(130);
    CHECK(sender.queued==2 && messages.sent==1 && messages.records[@(local)].m_uiStatus==5);
    CSCFCallDidReject(ReplyToken(330));PumpReplies();CHECK(messages.sent==1);
    CSCFCallDidReject(ReplyToken(331));PumpReplies();CHECK(messages.sent==2); // Failed delivery releases recipient cooldown.

    // Success received during the retry delay wins. Never requeue an acknowledged record.
    messages=ResetReplies();sender=FixtureServices[@"SendMessageMgr"];CSCFCallDidReject(ReplyToken(340));PumpReplies();
    ReplyStatus(messages,5,0,NO);AdvanceReplies(2);ReplyStatus(messages,2,9002,YES);PumpReplies();AdvanceReplies(120);
    CHECK(messages.sent==1 && sender.queued==0 && messages.modified==0);
    messages=ResetReplies();sender=FixtureServices[@"SendMessageMgr"];CSCFCallDidReject(ReplyToken(341));PumpReplies();
    ReplyStatus(messages,5,9003,NO);AdvanceReplies(120);CHECK(sender.queued==0); // Server identity also forbids resend.

    messages=ResetReplies();sender=FixtureServices[@"SendMessageMgr"];CSCFCallDidReject(ReplyToken(350));PumpReplies();
    ReplyStatus(messages,5,0,NO);AdvanceReplies(2);Epoch++;Policy=Snapshot(YES,NO,@{@"callReplyEnabled":@YES});AdvanceReplies(2);
    CHECK(sender.queued==0 && messages.modified==0 && messages.sent==1);
    messages=ResetReplies();sender=FixtureServices[@"SendMessageMgr"];CSCFCallDidReject(ReplyToken(351));PumpReplies();
    ReplyStatus(messages,5,0,NO);AdvanceReplies(2);Policy=Snapshot(YES,NO,nil);AdvanceReplies(2);CHECK(sender.queued==0);

    // Missing native queue is retried without a new local message.
    messages=ResetReplies();sender=FixtureServices[@"SendMessageMgr"];[FixtureServices removeObjectForKey:@"SendMessageMgr"];
    CSCFCallDidReject(ReplyToken(360));PumpReplies();ReplyStatus(messages,5,0,NO);AdvanceReplies(4);
    CHECK(sender.queued==0 && messages.modified==0);FixtureServices[@"SendMessageMgr"]=sender;AdvanceReplies(3);CHECK(sender.queued==1 && messages.sent==1);
    messages=ResetReplies();sender=FixtureServices[@"SendMessageMgr"];[FixtureServices removeObjectForKey:@"SendMessageMgr"];
    CSCFCallDidReject(ReplyToken(361));PumpReplies();ReplyStatus(messages,5,0,NO);AdvanceReplies(20);
    CHECK(messages.records[@1].m_uiStatus==5 && messages.sent==1 && messages.modified==0);

    // Failure before queue entry restores the native failed row. Policy changes
    // in a synchronous native modify callback do not strand it in sending state.
    messages=ResetReplies();sender=FixtureServices[@"SendMessageMgr"];messages.throwWhenMarkingSending=YES;
    CSCFCallDidReject(ReplyToken(362));PumpReplies();ReplyStatus(messages,5,0,NO);AdvanceReplies(40);
    CHECK(sender.queued==0 && messages.sent==1 && messages.records[@1].m_uiStatus==5);
    messages=ResetReplies();sender=FixtureServices[@"SendMessageMgr"];messages.disableWhenMarkingSending=YES;
    CSCFCallDidReject(ReplyToken(363));PumpReplies();ReplyStatus(messages,5,0,NO);AdvanceReplies(20);
    CHECK(sender.queued==0 && messages.sent==1 && messages.records[@1].m_uiStatus==5);

    // Ambiguous handoff, unknown status, missing or changed records never create a duplicate.
    messages=ResetReplies();sender=FixtureServices[@"SendMessageMgr"];messages.throwAfterInsert=YES;
    CSCFCallDidReject(ReplyToken(370));AdvanceReplies(121);CHECK(messages.sent==1 && sender.queued==0);
    messages=ResetReplies();sender=FixtureServices[@"SendMessageMgr"];CSCFCallDidReject(ReplyToken(371));PumpReplies();
    ReplyStatus(messages,5,0,NO);messages.records[@1].m_nsContent=@"用户已修改";AdvanceReplies(121);CHECK(messages.sent==1 && sender.queued==0);
    messages=ResetReplies();sender=FixtureServices[@"SendMessageMgr"];CSCFCallDidReject(ReplyToken(372));PumpReplies();
    [messages.records removeAllObjects];AdvanceReplies(121);CHECK(messages.sent==1 && sender.queued==0);

    NSMutableDictionary *invalid=[@{@"enabled":@YES,@"friends":@[],@"groups":@[],@"options":@{}} mutableCopy];
    for(id text in @[@"",@"   ",@"line\nbreak",@3,[@"a" stringByPaddingToLength:201 withString:@"a" startingAtIndex:0]]) {invalid[@"options"]=@{@"callReplyText":text};CHECK(!CSCloseFriendNormalizeProfile(invalid,NULL));}
    CSCFCallReplyConfigureTesting(nil,nil);ReplyJobs=nil;FixtureServices=nil;
}
