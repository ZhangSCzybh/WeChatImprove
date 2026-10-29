// The production adapter receives the same MonoService delegate contracts as
// WeChat 8.0.78. These doubles perform no network requests or real messaging.
@interface VoipMonoMsg : Mono
@property BOOL isFromIlink,video,valid,invite;
@property long long m_roomKey;
@end
@implementation VoipMonoMsg
- (unsigned long long)m_roomId{return self.roomID;}
- (BOOL)isInvite{return self.invite;}
- (BOOL)isParaVaild{return self.valid;}
- (BOOL)isVideo{return self.video;}
@end
@interface VoIPInvitationInfo : Info
@end
@implementation VoIPInvitationInfo
+ (instancetype)infoWithVoipMonoMsg:(VoipMonoMsg *)message scene:(unsigned long long)scene {
    VoIPInvitationInfo *info=[self new];info.roomID=message.m_roomId;info.roomKey=message.m_roomKey;
    info.roomType=message.isVideo?2:1;info.contact=message.m_fromUser;info.isFromIlink=message.isFromIlink;info.monoMsg=message;
    return info;
}
@end
@interface VoipUIManager : NSObject
@property BOOL working,talking;
@property unsigned long long room;
@end
@implementation VoipUIManager
- (BOOL)isVoipWorking{return self.working;}
- (BOOL)isVoipTalking{return self.talking;}
- (unsigned long long)getRoomIDForCurrentVoipView{return self.room;}
@end
@interface MultiTalkMgr : NSObject
@property BOOL active;
@end
@implementation MultiTalkMgr
- (BOOL)isMultiTalkActive{return self.active;}
@end
@interface VoIPConfSDKService : NSObject
@property unsigned long long currentStatus,lastRoom;
@property NSUInteger submissions;
@end
@implementation VoIPConfSDKService
- (void)hangup:(int)reason roomID:(unsigned long long)room{CHECK(reason==1);self.submissions++;self.lastRoom=room;}
@end
@interface VoIPilinkMgr : NSObject
@property BOOL isConnected,isCaller,changeToMultiTalk;
@property unsigned long long mRoomId;
@property NSUInteger rejects,starts;
@end
@implementation VoIPilinkMgr
- (void)rejectWithRoomID:(unsigned long long)room {
    CHECK(!self.isConnected && (!self.mRoomId || self.mRoomId==room));
    self.rejects++;[(VoIPConfSDKService *)FixtureServices[@"VoIPConfSDKService"] hangup:1 roomID:room];
}
- (BOOL)onMonoServiceMsgHandleWithMsg:(id)message{return NO;}
- (void)onMonoServiceMsgStartWithMsg:(id)message{self.starts++;}
@end
@interface VOIPMessageMgr : NSObject
@property NSUInteger rejects,starts;
@property unsigned long long lastRoom;
@end
@implementation VOIPMessageMgr
- (void)voIPInvitationServiceDidRejectWithInfo:(Info *)info{CHECK(!info.isFromIlink && info.roomKey!=0);self.rejects++;self.lastRoom=info.roomID;}
- (BOOL)onMonoServiceMsgHandleWithMsg:(id)message{return NO;}
- (void)onMonoServiceMsgStartWithMsg:(id)message{self.starts++;}
@end
@interface VoIPMPSubCallService (IncomingFixture)
- (BOOL)isActive;
@end
static NSUInteger IncomingSubcallRejects;
@implementation VoIPMPSubCallService (IncomingFixture)
- (BOOL)isActive{return self.cache!=nil;}
- (void)voIPInvitationServiceDidRejectWithInfo:(Info *)info {
    Conf *current=self.cache[@"inviteInfo"];
    CHECK(current.roomid==info.roomID);IncomingSubcallRejects++;
}
@end
static VoipMonoMsg *IncomingMessage(NSString *caller,unsigned long long room,BOOL ilink,BOOL video) {
    VoipMonoMsg *m=[VoipMonoMsg new];m.m_fromUser=caller;m.roomID=room;m.m_roomKey=room+9;
    m.msgKey=[NSString stringWithFormat:@"incoming-%llu",room];m.isFromIlink=ilink;m.video=video;m.valid=YES;m.invite=YES;
    return m;
}
static void IncomingCallChecks(void) {
    CSCloseFriendSnapshot *savedPolicy=Policy;NSDictionary *savedServices=[FixtureServices copy];
    id savedCache=VoIPMPSubCallService.sharedInstance.cache;VoIPMPSubCallService.sharedInstance.cache=nil;
    Policy=Snapshot(YES,NO,nil);
    VoipUIManager *ui=[VoipUIManager new];MultiTalkMgr *multi=[MultiTalkMgr new];VoIPConfSDKService *sdk=[VoIPConfSDKService new];
    FixtureServices=[@{@"VoipUIManager":ui,@"MultiTalkMgr":multi,@"VoIPConfSDKService":sdk} mutableCopy];
    VoIPilinkMgr *ilink=[VoIPilinkMgr new];VOIPMessageMgr *legacy=[VOIPMessageMgr new];
    // The native queue asks Handle before Start. A handled invite never reaches
    // the window/ring method; its native queue still owns history and removal.
    VoipMonoMsg *m=IncomingMessage(@"friend",8101,YES,NO);
    BOOL handled=CSCFHandleIncomingCall(ilink,m,YES);if(!handled)[ilink onMonoServiceMsgStartWithMsg:m];
    CHECK(handled && ilink.starts==0 && ilink.rejects==1 && sdk.submissions==1 && sdk.lastRoom==8101);
    CHECK(CSCFHandleIncomingCall(ilink,m,YES) && ilink.rejects==1);
    m=IncomingMessage(@"friend",8102,YES,YES);CHECK(CSCFHandleIncomingCall(ilink,m,YES));CHECK(ilink.rejects==2 && sdk.lastRoom==8102);
    m=IncomingMessage(@"ordinary",8103,YES,NO);CHECK(!CSCFHandleIncomingCall(ilink,m,YES));[ilink onMonoServiceMsgStartWithMsg:m];CHECK(ilink.starts==1 && ilink.rejects==2);
    m=IncomingMessage(@"friend",8104,YES,NO);m.cancel=YES;CHECK(!CSCFHandleIncomingCall(ilink,m,YES));m.cancel=NO;m.expired=YES;CHECK(!CSCFHandleIncomingCall(ilink,m,YES));CHECK(ilink.rejects==2);
    m=IncomingMessage(@"friend",8105,YES,NO);m.valid=NO;CHECK(!CSCFHandleIncomingCall(ilink,m,YES));m.valid=YES;m.invite=NO;CHECK(!CSCFHandleIncomingCall(ilink,m,YES));
    m=IncomingMessage(@"friend",8106,YES,NO);ilink.isConnected=YES;ilink.mRoomId=8106;CHECK(CSCFHandleIncomingCall(ilink,m,YES) && ilink.rejects==2);ilink.isConnected=NO;ilink.mRoomId=999;
    m=IncomingMessage(@"friend",8107,YES,NO);CHECK(CSCFHandleIncomingCall(ilink,m,YES) && ilink.rejects==2);ilink.mRoomId=0;
    ui.working=YES;m=IncomingMessage(@"friend",8108,YES,NO);CHECK(CSCFHandleIncomingCall(ilink,m,YES) && ilink.rejects==2);ui.working=NO;
    multi.active=YES;m=IncomingMessage(@"friend",8109,YES,NO);CHECK(CSCFHandleIncomingCall(ilink,m,YES) && ilink.rejects==2);multi.active=NO;
    sdk.currentStatus=1;m=IncomingMessage(@"friend",8110,YES,NO);CHECK(CSCFHandleIncomingCall(ilink,m,YES) && ilink.rejects==2);sdk.currentStatus=0;
    VoIPMPSubCallService.sharedInstance.cache=@{};m=IncomingMessage(@"friend",8111,YES,NO);CHECK(CSCFHandleIncomingCall(ilink,m,YES) && ilink.rejects==2);VoIPMPSubCallService.sharedInstance.cache=nil;
    Conf *cached=[Conf new];cached.roomid=8120;cached.callerUsername=@"friend";
    VoIPMPSubCallService.sharedInstance.cache=@{@"inviteInfo":cached};ilink.isConnected=YES;ilink.mRoomId=999;
    m=IncomingMessage(@"friend",8120,YES,NO);NSUInteger subBefore=IncomingSubcallRejects;
    CHECK(CSCFHandleIncomingCall(ilink,m,YES) && IncomingSubcallRejects==subBefore+1 && ilink.rejects==2 && ilink.mRoomId==999);
    CHECK(CSCFHandleIncomingCall(ilink,m,YES) && IncomingSubcallRejects==subBefore+1);
    cached.roomid=8121;cached.callerUsername=@"ordinary";m=IncomingMessage(@"friend",8121,YES,NO);
    CHECK(CSCFHandleIncomingCall(ilink,m,YES) && IncomingSubcallRejects==subBefore+1);
    ilink.isConnected=NO;ilink.mRoomId=0;VoIPMPSubCallService.sharedInstance.cache=nil;
    Policy=Snapshot(YES,NO,@{@"rejectVoice":@NO,@"silenceMessages":@YES});m=IncomingMessage(@"friend",8112,YES,NO);
    CHECK(!CSCFHandleIncomingCall(ilink,m,YES) && ilink.rejects==2);
    CHECK(!CSCFIncomingCallToken(m).suppressesPresentation);
    m=IncomingMessage(@"friend",8113,YES,YES);CHECK(CSCFHandleIncomingCall(ilink,m,YES) && ilink.rejects==3);
    // Locked calls also reach native UI when the matching rejection is off,
    // including profiles retaining the retired message-silence option.
    Policy=Snapshot(YES,NO,@{@"rejectVoice":@NO,@"rejectVideo":@NO,@"silenceMessages":@YES});
    unsigned long long allowedRoom=8400;
    Invites *allowedInvites=[Invites new];
    for(NSNumber *transport in @[@YES,@NO])for(NSNumber *video in @[@NO,@YES]) {
        id manager=transport.boolValue?(id)ilink:(id)legacy;
        m=IncomingMessage(@"friend",allowedRoom++,transport.boolValue,video.boolValue);
        CSCloseFriendCallToken *token=CSCFIncomingCallToken(m);
        CHECK(token.subject.isCurrent && !token.requiresRejection && !token.suppressesPresentation);
        NSUInteger starts=[manager starts];
        BOOL intercepted=CSCFHandleIncomingCall(manager,m,transport.boolValue);
        CHECK(!intercepted);
        if(!intercepted)[manager onMonoServiceMsgStartWithMsg:m];
        CHECK([manager starts]==starts+1);
        Info *invitation=[VoIPInvitationInfo infoWithVoipMonoMsg:m scene:0];
        CHECK(!CSCFHandleInvitation(allowedInvites,invitation,999));
        CHECK(!CSCFInvitationOutputSuppressed(@{@"info":invitation}));
    }
    CHECK(ilink.rejects==3 && legacy.rejects==0 && allowedInvites.rejects==0);
    // Revealed friends reach the native incoming UI on both transports and media.
    Policy=Snapshot(YES,YES,@{@"silenceMessages":@YES});
    unsigned long long openRoom=8300;
    Invites *openInvites=[Invites new];
    for(NSNumber *transport in @[@YES,@NO])for(NSNumber *video in @[@NO,@YES]) {
        id manager=transport.boolValue?(id)ilink:(id)legacy;
        m=IncomingMessage(@"friend",openRoom++,transport.boolValue,video.boolValue);
        CSCloseFriendCallToken *token=CSCFIncomingCallToken(m);
        CHECK(token.subject.isCurrent && !token.requiresRejection && !token.suppressesPresentation);
        NSUInteger starts=[manager starts];
        BOOL intercepted=CSCFHandleIncomingCall(manager,m,transport.boolValue);
        CHECK(!intercepted);
        if(!intercepted)[manager onMonoServiceMsgStartWithMsg:m];
        CHECK([manager starts]==starts+1);
        Info *invitation=[VoIPInvitationInfo infoWithVoipMonoMsg:m scene:0];
        CHECK(!CSCFHandleInvitation(openInvites,invitation,999));
        CHECK(!CSCFInvitationOutputSuppressed(@{@"info":invitation}));
    }
    CHECK(ilink.rejects==3 && legacy.rejects==0 && openInvites.rejects==0);
    // Existing tokens consult the current lock state, without waiting for a new invite.
    CSCloseFriendCallToken *openToken=CSCFIncomingCallToken(m);
    Policy=Snapshot(YES,NO,nil);CHECK(openToken.requiresRejection && openToken.suppressesPresentation);
    Policy=Snapshot(YES,YES,nil);CHECK(!openToken.requiresRejection && !openToken.suppressesPresentation);
    m=IncomingMessage(@"friend",8115,YES,NO);CHECK(CSCFIncomingCallToken(m).subject.isCurrent);Epoch++;Policy=Snapshot(YES,NO,nil);
    CHECK(CSCFHandleIncomingCall(ilink,m,YES) && ilink.rejects==3);
    // Native reset does not reset isCaller; a previous outgoing call must not
    // disable a later incoming rejection once the owning UI/SDK are idle.
    ilink.isCaller=YES;m=IncomingMessage(@"friend",8116,YES,NO);
    CHECK(CSCFHandleIncomingCall(ilink,m,YES) && ilink.rejects==4);ilink.isCaller=NO;
    m=IncomingMessage(@"friend",8201,NO,NO);CHECK(CSCFHandleIncomingCall(legacy,m,NO));CHECK(legacy.rejects==1 && legacy.lastRoom==8201);CHECK(CSCFHandleIncomingCall(legacy,m,NO) && legacy.rejects==1);
    ui.talking=YES;ui.room=8202;m=IncomingMessage(@"friend",8202,NO,YES);CHECK(CSCFHandleIncomingCall(legacy,m,NO) && legacy.rejects==1);
    ui.room=999;m=IncomingMessage(@"friend",8203,NO,YES);CHECK(CSCFHandleIncomingCall(legacy,m,NO) && legacy.rejects==2 && legacy.lastRoom==8203 && ui.room==999);ui.talking=NO;
    m=IncomingMessage(@"ordinary",8204,NO,NO);CHECK(!CSCFHandleIncomingCall(legacy,m,NO));
    m=IncomingMessage(@"friend",8205,NO,NO);m.m_roomKey=0;CHECK(CSCFHandleIncomingCall(legacy,m,NO) && legacy.rejects==2);
    m=IncomingMessage(@"friend",8206,NO,NO);CHECK(!CSCFHandleIncomingCall(ilink,m,YES));
    Policy=Snapshot(NO,NO,nil);m=IncomingMessage(@"friend",8207,YES,NO);CHECK(!CSCFHandleIncomingCall(ilink,m,YES));
    FixtureServices=[savedServices mutableCopy];VoIPMPSubCallService.sharedInstance.cache=savedCache;Policy=savedPolicy;
}
