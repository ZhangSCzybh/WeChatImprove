#import "CSCloseFriendCallAdapter.h"
#import "CSCloseFriendCallReply.h"
#import "CSCloseFriendBridge.h"
#import "CSServiceCenter.h"
#import "CSBackupBootstrap.h"
#import <objc/message.h>

@interface NSObject (CSCFCallReplyNativeInit)
- (instancetype)initWithMsgType:(long long)type;
@end

// A reply owns only message/account identity. VoIP may destroy its room,
// invitation and token immediately after handing off the rejection request.
@interface CSCFCallReplyTask : NSObject
@property(nonatomic,copy) NSString *account,*caller,*callKey,*text;
@property(nonatomic) NSUInteger epoch,prepareAttempts,resends,generation,polls;
@property(nonatomic) BOOL video,submitted,finished,retryScheduled;
@property(nonatomic) unsigned int localID,createTime;
@property(nonatomic) NSTimeInterval started;
@property(nonatomic,strong) id wrap;
@end
@implementation CSCFCallReplyTask @end

static NSMutableDictionary<NSString *,CSCFCallReplyTask *> *Tasks;
static NSMutableDictionary<NSString *,NSNumber *> *SubmittedCalls;
static NSMutableDictionary<NSString *,NSDictionary *> *Recipients;
static NSString *RegistryAccount;
static NSUInteger RegistryEpoch;
#if CSCF_CALL_REPLY_TESTING
static NSTimeInterval (^TestClock)(void);
static void (^TestSchedule)(NSTimeInterval,dispatch_block_t);
void CSCFCallReplyConfigureTesting(NSTimeInterval (^clock)(void),void (^schedule)(NSTimeInterval,dispatch_block_t)) {
    for(CSCFCallReplyTask *task in Tasks.allValues)task.finished=YES;
    Tasks=nil;SubmittedCalls=nil;Recipients=nil;RegistryAccount=nil;RegistryEpoch=0;
    TestClock=[clock copy];TestSchedule=[schedule copy];
}
#endif
static NSTimeInterval ReplyNow(void) {
#if CSCF_CALL_REPLY_TESTING
    if(TestClock)return TestClock();
#endif
    return NSProcessInfo.processInfo.systemUptime;
}
static void ReplyAfter(NSTimeInterval delay,dispatch_block_t block) {
#if CSCF_CALL_REPLY_TESTING
    if(TestSchedule){TestSchedule(delay,block);return;}
#endif
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(delay*NSEC_PER_SEC)),dispatch_get_main_queue(),block);
}
static BOOL ReplyMethod(id object,NSString *name,const char *types) {
    return CSCloseFriendMethodMatches(class_getInstanceMethod([object class],NSSelectorFromString(name)),types);
}
static BOOL ReplyUInt(id object,NSString *name,unsigned int *value) {
    if(!ReplyMethod(object,name,"I@:"))return NO;
    *value=((unsigned int(*)(id,SEL))objc_msgSend)(object,NSSelectorFromString(name));return YES;
}
static BOOL ReplyServerID(id object,long long *value) {
    if(!ReplyMethod(object,@"m_n64MesSvrID","q@:"))return NO;
    *value=((long long(*)(id,SEL))objc_msgSend)(object,NSSelectorFromString(@"m_n64MesSvrID"));return YES;
}
static BOOL ReplyEligible(CSCFCallReplyTask *task) {
    CSCloseFriendSnapshot *policy=CSCloseFriendCurrentSnapshot();
    return !policy.blocked && task.epoch==CSCloseFriendAccountEpoch() &&
        [task.account isEqual:policy.accountID] && [policy.options[@"callReplyEnabled"] boolValue] &&
        [policy rejectsCaller:task.caller chatRoom:task.caller video:task.video];
}
static BOOL ReplyActive(CSCFCallReplyTask *task) {return !task.finished && Tasks[task.callKey]==task;}
static void Finish(CSCFCallReplyTask *task,BOOL releaseRecipient,BOOL success) {
    task.finished=YES;task.generation++;task.wrap=nil;
    if(Tasks[task.callKey]==task)[Tasks removeObjectForKey:task.callKey];
    if(RegistryEpoch==task.epoch && [RegistryAccount isEqual:task.account] &&
       [Recipients[task.caller][@"call"] isEqual:task.callKey]) {
        if(releaseRecipient)[Recipients removeObjectForKey:task.caller];
        else if(success)Recipients[task.caller]=@{@"call":task.callKey,@"time":@(ReplyNow())};
    }
}
static void Run(CSCFCallReplyTask *task,dispatch_block_t action) {
    if(!ReplyActive(task))return;
    BOOL ran=CSBackupPerformAtAccountEpoch(task.epoch,^{
        if(!ReplyEligible(task)){Finish(task,!task.submitted,NO);return;}
        action();
    });
    if(!ran)Finish(task,!task.submitted,NO);
}
static void Schedule(CSCFCallReplyTask *task,NSTimeInterval delay,dispatch_block_t action) {
    NSUInteger generation=++task.generation;
    delay=MIN(delay,MAX(0,task.started+120-ReplyNow()));
    ReplyAfter(delay,^{if(ReplyActive(task) && task.generation==generation)Run(task,action);});
}
static void Observe(CSCFCallReplyTask *task);
static void Poll(CSCFCallReplyTask *task) {
    task.retryScheduled=NO;
    NSTimeInterval delay=task.polls++<2?2:8;
    Schedule(task,delay,^{Observe(task);});
}
static BOOL SameMessage(CSCFCallReplyTask *task,id wrap) {
    unsigned int local=0,type=0,time=0;
    return task.localID && ReplyUInt(wrap,@"m_uiMesLocalID",&local) && local==task.localID &&
        ReplyUInt(wrap,@"m_uiMessageType",&type) && type==1 &&
        ReplyUInt(wrap,@"m_uiCreateTime",&time) && time==task.createTime &&
        [CSCloseFriendRead(wrap,@"m_nsFromUsr") isEqual:task.account] &&
        [CSCloseFriendRead(wrap,@"m_nsToUsr") isEqual:task.caller] &&
        [CSCloseFriendRead(wrap,@"m_nsContent") isEqual:task.text];
}
static id StoredMessage(CSCFCallReplyTask *task,id manager) {
    if(!task.localID){unsigned int local=0;if(ReplyUInt(task.wrap,@"m_uiMesLocalID",&local))task.localID=local;}
    if(!task.localID || !ReplyMethod(manager,@"GetMsg:LocalID:","@@:@I"))return nil;
    id wrap=((id(*)(id,SEL,id,unsigned int))objc_msgSend)(manager,NSSelectorFromString(@"GetMsg:LocalID:"),task.caller,task.localID);
    return SameMessage(task,wrap)?wrap:nil;
}
static void RestoreFailed(CSCFCallReplyTask *task) {
    // Only before entering the queue. A disabled reply policy may still restore
    // its own failed row, while an account boundary must stop all old writes.
    CSCloseFriendSnapshot *policy=CSCloseFriendCurrentSnapshot();
    if(task.epoch!=CSCloseFriendAccountEpoch() || policy.blocked || ![task.account isEqual:policy.accountID])return;
    @try {
        id manager=CSGetService(NSClassFromString(@"CMessageMgr"));id wrap=StoredMessage(task,manager);
        unsigned int status=0;long long server=0;
        if(wrap && ReplyUInt(wrap,@"m_uiStatus",&status) && status==1 && ReplyServerID(wrap,&server) && !server &&
           ReplyMethod(wrap,@"setM_uiStatus:","v@:I") && ReplyMethod(manager,@"ModMsg:MsgWrap:","v@:@@")) {
            ((void(*)(id,SEL,unsigned int))objc_msgSend)(wrap,NSSelectorFromString(@"setM_uiStatus:"),5);
            ((void(*)(id,SEL,id,id))objc_msgSend)(manager,NSSelectorFromString(@"ModMsg:MsgWrap:"),task.caller,wrap);
        }
    } @catch (__unused NSException *exception) {}
}
static void Retry(CSCFCallReplyTask *task) {
    task.retryScheduled=NO;
    if(ReplyNow()-task.started>=120){Finish(task,NO,NO);return;}
    BOOL queueAttempted=NO;
    @try {
        id manager=CSGetService(NSClassFromString(@"CMessageMgr"));
        id wrap=StoredMessage(task,manager);unsigned int status=0;long long server=0;
        if(!wrap || !ReplyUInt(wrap,@"m_uiStatus",&status) || !ReplyServerID(wrap,&server)){Poll(task);return;}
        if(status==2 || server!=0){Finish(task,NO,YES);return;}
        if(status!=5){Poll(task);return;}
        if(task.resends>=2){Finish(task,YES,NO);return;}
        id sender=CSGetService(NSClassFromString(@"SendMessageMgr"));
        if(!ReplyMethod(sender,@"AddMsgToSendTable:MsgWrap:","v@:@@") || !ReplyMethod(sender,@"CheckResend","v@:") ||
           !ReplyMethod(manager,@"ModMsg:MsgWrap:","v@:@@") || !ReplyMethod(wrap,@"setM_uiStatus:","v@:I")) {
            if(++task.prepareAttempts<4){task.retryScheduled=YES;Schedule(task,3,^{Retry(task);});}
            else Finish(task,YES,NO);
            return;
        }
        // Keep the original local ID and creation time: native derives the
        // client ID from both. Restore "sending" so old failure callbacks cannot
        // consume another retry while this attempt is in flight.
        task.resends++;task.prepareAttempts=0;
        ((void(*)(id,SEL,unsigned int))objc_msgSend)(wrap,NSSelectorFromString(@"setM_uiStatus:"),1);
        ((void(*)(id,SEL,id,id))objc_msgSend)(manager,NSSelectorFromString(@"ModMsg:MsgWrap:"),task.caller,wrap);
        if(!ReplyEligible(task)){RestoreFailed(task);Finish(task,YES,NO);return;}
        queueAttempted=YES;
        ((void(*)(id,SEL,id,id))objc_msgSend)(sender,NSSelectorFromString(@"AddMsgToSendTable:MsgWrap:"),task.caller,wrap);
        ((void(*)(id,SEL))objc_msgSend)(sender,NSSelectorFromString(@"CheckResend"));
    } @catch (__unused NSException *exception) {
        if(!queueAttempted)RestoreFailed(task);
        // The queue may already own the message. Re-read persisted state; never
        // repeat an uncertain handoff or create a replacement message.
    }
    Poll(task);
}
static void Prepare(CSCFCallReplyTask *task) {
    task.prepareAttempts++;
    @try {
        id manager=CSGetService(NSClassFromString(@"CMessageMgr"));Class cls=NSClassFromString(@"CMessageWrap");
        if(!manager || !cls) {
            if(task.prepareAttempts<4)Schedule(task,task.prepareAttempts==1?1:3,^{Observe(task);});
            else Finish(task,YES,NO);
            return;
        }
        // WeChat 8.0.78 uses signed 64-bit q for initWithMsgType:, unlike its
        // unsigned 32-bit status/time accessors. The old I check rejected every send.
        if(!CSCloseFriendMethodMatches(class_getInstanceMethod(cls,NSSelectorFromString(@"initWithMsgType:")),"@@:q") ||
           !ReplyMethod(manager,@"AddMsg:MsgWrap:","v@:@@") || !ReplyMethod(manager,@"GetMsg:LocalID:","@@:@I")) {
            CSCloseFriendRecordCapability(@"calls.reply.messageABI",NO);Finish(task,YES,NO);return;
        }
        id wrap=[[cls alloc] initWithMsgType:1LL];
        for(NSString *setter in @[@"setM_nsContent:",@"setM_nsFromUsr:",@"setM_nsToUsr:"])
            if(!ReplyMethod(wrap,setter,"v@:@")){Finish(task,YES,NO);return;}
        for(NSString *setter in @[@"setM_uiCreateTime:",@"setM_uiStatus:"])
            if(!ReplyMethod(wrap,setter,"v@:I")){Finish(task,YES,NO);return;}
        ((void(*)(id,SEL,id))objc_msgSend)(wrap,NSSelectorFromString(@"setM_nsContent:"),task.text);
        ((void(*)(id,SEL,id))objc_msgSend)(wrap,NSSelectorFromString(@"setM_nsFromUsr:"),task.account);
        ((void(*)(id,SEL,id))objc_msgSend)(wrap,NSSelectorFromString(@"setM_nsToUsr:"),task.caller);
        ((void(*)(id,SEL,unsigned int))objc_msgSend)(wrap,NSSelectorFromString(@"setM_uiCreateTime:"),task.createTime);
        ((void(*)(id,SEL,unsigned int))objc_msgSend)(wrap,NSSelectorFromString(@"setM_uiStatus:"),1);
        unsigned int local=0;long long server=0;
        if(!ReplyUInt(wrap,@"m_uiMesLocalID",&local) || local || !ReplyServerID(wrap,&server) || server){Finish(task,YES,NO);return;}
        if(!ReplyEligible(task)){Finish(task,YES,NO);return;}
        task.wrap=wrap;task.submitted=YES;task.prepareAttempts=0;
        SubmittedCalls[task.callKey]=@(ReplyNow());
        Recipients[task.caller]=@{@"call":task.callKey,@"time":@(ReplyNow())};
        ((void(*)(id,SEL,id,id))objc_msgSend)(manager,NSSelectorFromString(@"AddMsg:MsgWrap:"),task.caller,wrap);
        CSCloseFriendRecordCapability(@"calls.reply.messageABI",YES);
    } @catch (__unused NSException *exception) {
        if(!task.submitted) {
            if(task.prepareAttempts<4)Schedule(task,3,^{Observe(task);});else Finish(task,YES,NO);
            return;
        }
    }
    Poll(task);
}
static void Observe(CSCFCallReplyTask *task) {
    if(ReplyNow()-task.started>=120){Finish(task,!task.submitted,NO);return;}
    if(!task.submitted){Prepare(task);return;}
    @try {
        id manager=CSGetService(NSClassFromString(@"CMessageMgr"));
        id wrap=StoredMessage(task,manager);unsigned int status=0;long long server=0;
        if(wrap && ReplyUInt(wrap,@"m_uiStatus",&status) && ReplyServerID(wrap,&server)) {
            if(status==2 || server!=0){Finish(task,NO,YES);return;}
            if(status==5) {
                if(task.resends>=2){Finish(task,YES,NO);return;}
                if(!task.retryScheduled){task.retryScheduled=YES;Schedule(task,task.resends?8:2,^{Retry(task);});}
                return;
            }
        }
    } @catch (__unused NSException *exception) {}
    Poll(task);
}
static void Begin(CSCFCallReplyTask *task) {
    if(!ReplyEligible(task))return;
    if(!Tasks || RegistryEpoch!=task.epoch || ![RegistryAccount isEqual:task.account]) {
        for(CSCFCallReplyTask *old in Tasks.allValues)old.finished=YES;
        Tasks=[NSMutableDictionary dictionary];SubmittedCalls=[NSMutableDictionary dictionary];Recipients=[NSMutableDictionary dictionary];
        RegistryEpoch=task.epoch;RegistryAccount=task.account;
    }
    NSTimeInterval now=ReplyNow();
    for(NSString *key in SubmittedCalls.allKeys)if(now-[SubmittedCalls[key] doubleValue]>86400)[SubmittedCalls removeObjectForKey:key];
    for(NSString *key in Recipients.allKeys)if(now-[Recipients[key][@"time"] doubleValue]>=300)[Recipients removeObjectForKey:key];
    if(Tasks[task.callKey] || SubmittedCalls[task.callKey] || Recipients[task.caller] || Tasks.count>=32 || SubmittedCalls.count>=512)return;
    for(CSCFCallReplyTask *active in Tasks.allValues)if([active.caller isEqual:task.caller])return;
    Tasks[task.callKey]=task;
    Run(task,^{Observe(task);});
}
void CSCFCallDidReject(CSCloseFriendCallToken *token) {
    CSCloseFriendSnapshot *policy=CSCloseFriendCurrentSnapshot();
    if(![token.state isEqual:@"rejectionSubmitted"] || ![token.subject isCurrent] || ![token requiresRejection] ||
       ![policy.options[@"callReplyEnabled"] boolValue] || !token.roomID || !token.key.length ||
       (token.roomType!=1 && token.roomType!=2) || !token.subject.sender.length ||
       ![token.subject.session isEqual:token.subject.sender] || [token.subject.sender hasSuffix:@"@chatroom"] ||
       [token.subject.sender isEqual:token.subject.account])return;
    CSCFCallReplyTask *task=[CSCFCallReplyTask new];
    task.account=token.subject.account;task.epoch=token.subject.epoch;task.caller=token.subject.sender;
    task.video=token.roomType==2;task.text=policy.options[@"callReplyText"];
    task.callKey=[NSString stringWithFormat:@"%@|%llu|%lld",task.caller,token.roomID,token.roomKey];
    task.started=ReplyNow();task.createTime=(unsigned int)NSDate.date.timeIntervalSince1970;
    if(!task.text.length || !ReplyEligible(task))return;
    ReplyAfter(0,^{Begin(task);});
}
void CSCFCallReplyMessageDidChange(id message) {
    // Callbacks are only wakeups. Reload the exact record through the current
    // account service instead of trusting a stale callback's status.
    ReplyAfter(0,^{
        for(CSCFCallReplyTask *task in Tasks.allValues) {
            if(ReplyActive(task) && task.submitted && SameMessage(task,message))Run(task,^{Observe(task);});
        }
    });
}
