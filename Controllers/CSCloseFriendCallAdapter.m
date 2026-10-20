#import "CSCloseFriendCallAdapter.h"
#import "CSCloseFriendBridge.h"
#import "CSServiceCenter.h"
#import <objc/message.h>
static BOOL Matches(id o,NSString *n,const char *t) { return CSCloseFriendMethodMatches(class_getInstanceMethod([o class],NSSelectorFromString(n)),t); }
static BOOL Bool(id o,NSString *n,BOOL *v) {if(!Matches(o,n,"B@:"))return NO; *v=((BOOL(*)(id,SEL))objc_msgSend)(o,NSSelectorFromString(n));return YES;}
static BOOL Unsigned(id o,NSString *n,unsigned long long *v) {if(!Matches(o,n,"Q@:"))return NO; *v=((unsigned long long(*)(id,SEL))objc_msgSend)(o,NSSelectorFromString(n));return YES;}
static BOOL Signed(id o,NSString *n,long long *v) {if(!Matches(o,n,"q@:"))return NO; *v=((long long(*)(id,SEL))objc_msgSend)(o,NSSelectorFromString(n));return YES;}
static NSString *String(id v){return [v isKindOfClass:NSString.class] && [v length]?v:nil;}
@implementation CSCloseFriendCallToken
- (BOOL)requiresRejection {
    if(![self.subject isCurrent])return NO;
    CSCloseFriendSnapshot *p=CSCloseFriendCurrentSnapshot();
    if(self.roomType==1 || self.roomType==2)return [p rejectsCaller:self.subject.sender chatRoom:self.subject.session video:self.roomType==2];
    return [p rejectsCaller:self.subject.sender chatRoom:self.subject.session video:NO] && [p rejectsCaller:self.subject.sender chatRoom:self.subject.session video:YES];
}
- (BOOL)suppressesPresentation {return [self.subject shouldSilence] || [self requiresRejection];}
@end
@interface CSCloseFriendCallAdapter ()
@property(nonatomic,strong) NSMutableDictionary *claims;
@end
@implementation CSCloseFriendCallAdapter
- (BOOL)claim:(CSCloseFriendCallToken *)token now:(NSTimeInterval)now {
    @synchronized(self) {
        if(![token.subject isCurrent] || !token.key.length)return NO;
        if(!self.claims)self.claims=[NSMutableDictionary dictionary];
        for(NSString *key in self.claims.allKeys) {
            NSDictionary *entry=self.claims[key]; CSCloseFriendCallToken *old=entry[@"token"];
            if(![old.subject isCurrent] || now-[entry[@"time"] doubleValue]>120)[self.claims removeObjectForKey:key];
        }
        if(self.claims[token.key] || self.claims.count>=128)return NO;
        self.claims[token.key]=@{@"token":token,@"time":@(now)}; return YES;
    }
}
- (void)end:(CSCloseFriendCallToken *)token {
    // Keep a tombstone until expiry: a duplicate stale invite must not be rejected twice.
    @synchronized(self) { CSCloseFriendCallToken *old=self.claims[token.key][@"token"]; old.state=@"native-ended"; }
}
@end
static CSCloseFriendCallAdapter *Registry(void) {static CSCloseFriendCallAdapter *r;static dispatch_once_t once;dispatch_once(&once,^{r=[CSCloseFriendCallAdapter new];});return r;}
static void Identify(CSCloseFriendCallToken *t,NSString *caller,NSString *room,NSString *messageKey) {
    NSString *session=room?:caller;
    CSCloseFriendAlertSubject *bound=CSCFBoundAlert(t.info)?:CSCFBoundAlert(t.mono);
    if(bound) {
        // Old callbacks and repurposed native objects cannot gain a new account's authorization.
        BOOL sameSession=bound.session==session || [bound.session isEqual:session];
        BOOL sameCaller=bound.sender==caller || [bound.sender isEqual:caller];
        if(sameSession && sameCaller)t.subject=bound;
    } else {
        t.subject=[CSCloseFriendAlertSubject subjectForSession:session sender:caller];
        CSCFBindAlert(t.info,t.subject);CSCFBindAlert(t.mono,t.subject);
    }
    t.state=@"identified";
    if(t.subject && t.roomID && messageKey.length)t.key=[@[t.subject.account,@(t.subject.epoch).stringValue,@(t.roomType).stringValue,@(t.roomID).stringValue,@(t.roomKey).stringValue,messageKey] componentsJoinedByString:@"|"];
}
CSCloseFriendCallToken *CSCFInvitationToken(id info) {
    CSCloseFriendCallToken *t=[CSCloseFriendCallToken new];t.info=info;t.mono=CSCloseFriendRead(info,@"monoMsg");
    unsigned long long room=0,type=0;long long key=0;BOOL ilink=NO;
    if(!Unsigned(info,@"roomID",&room) || !Unsigned(info,@"roomType",&type) || !Signed(info,@"roomKey",&key) || !Bool(info,@"isFromIlink",&ilink))return nil;
    t.roomID=room;t.roomType=type;t.roomKey=key;t.ilink=ilink;
    NSString *caller=CSCloseFriendUserName(CSCloseFriendRead(info,@"contact"));
    NSString *group=String(CSCloseFriendRead(CSCloseFriendRead(t.mono,@"m_group"),@"mWxGroupId"));
    if(!group)group=String(CSCloseFriendRead(CSCloseFriendRead(info,@"inviteMsg"),@"wxGroupid"));
    NSString *msg=String(CSCloseFriendRead(t.mono,@"msgKey"));
    if(!msg && Matches(info,@"receiveTime","I@:")) { unsigned int time=((unsigned int(*)(id,SEL))objc_msgSend)(info,NSSelectorFromString(@"receiveTime"));if(time)msg=@(time).stringValue; }
    Identify(t,caller,group,msg);return t;
}
CSCloseFriendCallToken *CSCFMultiTalkToken(id message) {
    CSCloseFriendCallToken *t=[CSCloseFriendCallToken new];t.mono=message;t.roomType=3;
    unsigned long long room=0;long long groupRoom=0;id group=CSCloseFriendRead(message,@"m_group");
    if(!Unsigned(message,@"roomID",&room) || !Signed(group,@"mroomid",&groupRoom) || groupRoom<=0 || room!=(unsigned long long)groupRoom)return nil;
    t.roomID=room;
    Identify(t,String(CSCloseFriendRead(message,@"m_fromUser")),String(CSCloseFriendRead(group,@"mWxGroupId")),String(CSCloseFriendRead(message,@"msgKey")));return t;
}
static BOOL Pending(CSCloseFriendCallToken *t) {
    BOOL cancel=YES,expired=YES;
    return t.key.length && [t.subject isCurrent] && Bool(t.mono,@"isCancelMsg",&cancel) && !cancel && Bool(t.mono,@"isOutOfDate",&expired) && !expired;
}
static BOOL MatchedSubcall(CSCloseFriendCallToken *t) {
    Class cls=NSClassFromString(@"VoIPMPSubCallService"); SEL sel=NSSelectorFromString(@"sharedInstance");
    if(!CSCloseFriendMethodMatches(class_getClassMethod(cls,sel),"@@:"))return NO;
    id service=((id(*)(id,SEL))objc_msgSend)(cls,sel),cache=CSCloseFriendRead(service,@"cache"),info=CSCloseFriendRead(cache,@"inviteInfo");
    unsigned long long room=0;
    // Native receiver compares this room before calling reject. Retain its own routing.
    return Unsigned(info,@"roomid",&room) && room==t.roomID && room!=0 &&
        info==CSCloseFriendRead(t.info,@"inviteInfo") &&
        [String(CSCloseFriendRead(info,@"callerUsername")) isEqual:t.subject.sender];
}
BOOL CSCFHandleInvitation(id service,id info,unsigned long long talkingRoom) {
    CSCloseFriendCallToken *t=CSCFInvitationToken(info);
    if(t.roomID==talkingRoom || ![t suppressesPresentation])return NO;
    if(![t requiresRejection]) {t.state=@"presentationSuppressed";return YES;}
    BOOL route=(t.roomType==1 || t.roomType==2) && (t.ilink ? MatchedSubcall(t) : t.roomKey!=0);
    route=route && Matches(service,@"rejectInvitationWithInfo:","v@:@");
    if(!route || !Pending(t) || t.roomID==talkingRoom) {
        t.state=@"rejectionUnsupported";CSCloseFriendRecordCapability(t.ilink?@"calls.ilinkMain.rejection":@"calls.invitation.rejection",NO);return YES;
    }
    if([Registry() claim:t now:NSProcessInfo.processInfo.systemUptime]) {
        if(!Pending(t) || ![CSCFInvitationToken(info).key isEqual:t.key] || ![t requiresRejection] || (t.ilink && !MatchedSubcall(t)))return [t suppressesPresentation];
        t.state=@"rejectionRequested";
        ((void(*)(id,SEL,id))objc_msgSend)(service,NSSelectorFromString(@"rejectInvitationWithInfo:"),info);
    }
    return YES;
}
static NSString *const CallScope=@"CSCloseFriendIncomingCall";
BOOL CSCFCallOutputSuppressed(void) {return [NSThread.currentThread.threadDictionary[CallScope] suppressesPresentation];}
BOOL CSCFCallBannerSuppressed(id group,unsigned long long room) {
    CSCloseFriendCallToken *t=NSThread.currentThread.threadDictionary[CallScope];
    return t && room==t.roomID && [String(CSCloseFriendRead(group,@"mWxGroupId")) isEqual:t.subject.session] && [t suppressesPresentation];
}
BOOL CSCFInvitationOutputSuppressed(id controller) {CSCloseFriendCallToken *t=CSCFInvitationToken(CSCloseFriendRead(controller,@"info"));return Pending(t) && [t suppressesPresentation];}
void CSCFHandleMultiTalk(id manager,id message,void (^native)(void)) {
    CSCloseFriendCallToken *t=CSCFMultiTalkToken(message);BOOL cancel=NO;
    if(Bool(message,@"isCancelMsg",&cancel) && cancel) {if(t)[Registry() end:t];native();return;}
    BOOL wasConnected=YES;unsigned long long previousRoom=0;
    BOOL knownState=Bool(manager,@"isMultiTalkConnected",&wasConnected) && Unsigned(manager,@"getCurrentRoomID",&previousRoom);
    if(!knownState || (wasConnected && previousRoom==t.roomID) || !Pending(t) || ![t suppressesPresentation]) {native();return;}
    CSCFBindAlert(CSCloseFriendRead(message,@"m_notificationInfo"),t.subject);
    NSMutableDictionary *d=NSThread.currentThread.threadDictionary;id old=d[CallScope];d[CallScope]=t;
    @try {CSCFWithAlert(t.subject,native);} @finally {if(old)d[CallScope]=old;else [d removeObjectForKey:CallScope];}
    // Initialization and PushKit/CallKit reporting above always run. Only the
    // exact incoming room is eligible; current ordinary call state is never reset.
    BOOL connected=YES;unsigned long long active=0;
    BOOL state=Bool(manager,@"isMultiTalkConnected",&connected) && Unsigned(manager,@"getCurrentRoomID",&active);
    if(![t requiresRejection])return;
    if(!state || (connected && active==t.roomID) || !Pending(t) || !Matches(manager,@"MultiTalkReject:","v@:Q")) {t.state=@"rejectionUnsupported";CSCloseFriendRecordCapability(@"calls.multitalk.rejection",NO);return;}
    if([Registry() claim:t now:NSProcessInfo.processInfo.systemUptime] && Pending(t) && [CSCFMultiTalkToken(message).key isEqual:t.key] && [t requiresRejection]) {
        t.state=@"rejectionRequested";((void(*)(id,SEL,unsigned long long))objc_msgSend)(manager,NSSelectorFromString(@"MultiTalkReject:"),t.roomID);
    }
}
