// Native message boundary doubles: never connects to WeChat or sends a real message.
@interface CMessageWrap : NSObject
@property(nonatomic,copy) NSString *m_nsContent,*m_nsFromUsr,*m_nsToUsr;
@property(nonatomic) unsigned int m_uiCreateTime,m_uiStatus,type;
- (instancetype)initWithMsgType:(unsigned int)type;
@end
@implementation CMessageWrap
- (instancetype)initWithMsgType:(unsigned int)type {if((self=[super init]))self.type=type;return self;}
@end
@interface CMessageMgr : NSObject
@property(nonatomic) NSUInteger sent;
@property(nonatomic,strong) CMessageWrap *lastWrap;
@property(nonatomic,copy) NSString *lastReceiver;
- (void)AddMsg:(NSString *)receiver MsgWrap:(CMessageWrap *)wrap;
@end
@implementation CMessageMgr
- (void)AddMsg:(NSString *)receiver MsgWrap:(CMessageWrap *)wrap {self.sent++;self.lastWrap=wrap;self.lastReceiver=receiver;}
@end
static CSCloseFriendCallToken *ReplyToken(unsigned long long room) {
    CSCloseFriendCallToken *token=[CSCloseFriendCallToken new];
    token.subject=[CSCloseFriendAlertSubject subjectForSession:@"friend" sender:@"friend"];
    token.roomID=room;token.roomKey=7;token.roomType=1;token.key=[NSString stringWithFormat:@"reply-%llu",room];token.state=@"rejectionSubmitted";return token;
}
static void PumpReplies(void) {[NSRunLoop.currentRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];}
static void CallReplyChecks(void) {
    Epoch++;Policy=Snapshot(YES,NO,nil);
    CHECK(![Policy.options[@"callReplyEnabled"] boolValue] && [Policy.options[@"callReplyText"] length]>0);
    CMessageMgr *messages=[CMessageMgr new];FixtureServices=[@{@"CMessageMgr":messages} mutableCopy];
    CSCFCallDidReject(ReplyToken(300));PumpReplies();CHECK(messages.sent==0);
    Policy=Snapshot(YES,YES,@{@"callReplyEnabled":@YES,@"callReplyText":@"稍后联系"});
    CSCloseFriendCallToken *first=ReplyToken(301);
    CSCFCallDidReject(first);CSCFCallDidReject(first);CSCFCallDidReject(ReplyToken(302));PumpReplies();
    CHECK(messages.sent==1 && [messages.lastReceiver isEqual:@"friend"] && [messages.lastWrap.m_nsContent isEqual:@"稍后联系"]);
    CHECK(messages.lastWrap.type==1 && messages.lastWrap.m_uiStatus==1 && [messages.lastWrap.m_nsFromUsr isEqual:@"self"] && [messages.lastWrap.m_nsToUsr isEqual:@"friend"]);
    Epoch++;Policy=Snapshot(YES,NO,@{@"callReplyEnabled":@YES});
    CSCloseFriendCallToken *stale=ReplyToken(303);CSCFCallDidReject(stale);Epoch++;Policy=Snapshot(YES,NO,@{@"callReplyEnabled":@YES});PumpReplies();CHECK(messages.sent==1);
    CSCloseFriendCallToken *disabled=ReplyToken(304);CSCFCallDidReject(disabled);Policy=Snapshot(YES,NO,nil);PumpReplies();CHECK(messages.sent==1);
    Policy=Snapshot(YES,NO,@{@"callReplyEnabled":@YES});
    CSCloseFriendCallToken *suppressed=ReplyToken(305);suppressed.state=@"presentationSuppressed";CSCFCallDidReject(suppressed);
    CSCloseFriendCallToken *group=ReplyToken(306);group.subject=[CSCloseFriendAlertSubject subjectForSession:@"secret@chatroom" sender:@"friend"];CSCFCallDidReject(group);
    CSCloseFriendCallToken *cancelled=ReplyToken(307);CSCFCallDidReject(cancelled);cancelled.state=@"native-ended";
    CSCloseFriendCallToken *ordinary=ReplyToken(308);ordinary.subject=[CSCloseFriendAlertSubject subjectForSession:@"ordinary" sender:@"ordinary"];CSCFCallDidReject(ordinary);
    PumpReplies();CHECK(messages.sent==1);
    CSCloseFriendCallToken *video=ReplyToken(309);video.roomType=2;CSCFCallDidReject(video);PumpReplies();CHECK(messages.sent==2);
    NSMutableDictionary *invalid=[@{@"enabled":@YES,@"friends":@[],@"groups":@[],@"options":@{}} mutableCopy];
    for(id text in @[@"",@"   ",@"line\nbreak",@3,[@"a" stringByPaddingToLength:201 withString:@"a" startingAtIndex:0]]) {invalid[@"options"]=@{@"callReplyText":text};CHECK(!CSCloseFriendNormalizeProfile(invalid,NULL));}
    FixtureServices=nil;
}
