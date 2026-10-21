#import "CSCloseFriendCallAdapter.h"
#import "CSCloseFriendBridge.h"
#import "CSServiceCenter.h"
#import "CSBackupBootstrap.h"
#import <objc/message.h>

static BOOL ReplyMethod(id object,NSString *name,const char *types) {
    return CSCloseFriendMethodMatches(class_getInstanceMethod([object class],NSSelectorFromString(name)),types);
}
static BOOL ReplyEligible(CSCloseFriendCallToken *token) {
    CSCloseFriendSnapshot *policy=CSCloseFriendCurrentSnapshot();
    return [token.state isEqual:@"rejectionSubmitted"] && [token.subject isCurrent] && [token requiresRejection] &&
        [policy.options[@"callReplyEnabled"] boolValue] && token.roomID && token.key.length &&
        (token.roomType==1 || token.roomType==2) && token.subject.sender.length &&
        [token.subject.session isEqual:token.subject.sender] && ![token.subject.sender hasSuffix:@"@chatroom"] &&
        ![token.subject.sender isEqual:token.subject.account];
}
static BOOL ReserveReply(CSCloseFriendCallToken *token) {
    // Main-thread only. Calls and recipients have separate limits: duplicate native
    // callbacks never reply twice, and repeated new calls cannot spam a recipient.
    static NSMutableDictionary *calls,*recipients;
    static NSString *account;
    static NSUInteger epoch;
    if(!calls || epoch!=token.subject.epoch || ![account isEqual:token.subject.account]) {
        calls=[NSMutableDictionary dictionary]; recipients=[NSMutableDictionary dictionary];
        epoch=token.subject.epoch; account=[token.subject.account copy];
    }
    NSTimeInterval now=NSProcessInfo.processInfo.systemUptime;
    for(NSString *key in calls.allKeys) if(now-[calls[key] doubleValue]>86400) [calls removeObjectForKey:key];
    for(NSString *key in recipients.allKeys) if(now-[recipients[key] doubleValue]>=300) [recipients removeObjectForKey:key];
    NSString *call=[NSString stringWithFormat:@"%@|%llu|%lld",token.subject.sender,token.roomID,token.roomKey];
    if(calls[call] || recipients[token.subject.sender] || calls.count>=512) return NO;
    calls[call]=@(now); recipients[token.subject.sender]=@(now); return YES;
}
void CSCFCallDidReject(CSCloseFriendCallToken *token) {
    // Enqueue only from a confirmed native rejection boundary. Revalidate after
    // that stack unwinds; an account/policy change cancels the pending reply.
    if(!ReplyEligible(token)) return;
    dispatch_async(dispatch_get_main_queue(),^{
      CSBackupPerformAtAccountEpoch(token.subject.epoch,^{
        if(!ReplyEligible(token)) return;
        NSString *text=CSCloseFriendCurrentSnapshot().options[@"callReplyText"];
        id manager=CSGetService(NSClassFromString(@"CMessageMgr"));
        Class wrapClass=NSClassFromString(@"CMessageWrap");
        if(!text.length || !CSCloseFriendMethodMatches(class_getInstanceMethod(wrapClass,NSSelectorFromString(@"initWithMsgType:")),"@@:I") ||
            !ReplyMethod(manager,@"AddMsg:MsgWrap:","v@:@@")) return;
        @try {
            id wrap=((id(*)(id,SEL,unsigned int))objc_msgSend)([wrapClass alloc],NSSelectorFromString(@"initWithMsgType:"),1);
            for(NSString *setter in @[@"setM_nsContent:",@"setM_nsFromUsr:",@"setM_nsToUsr:"]) if(!ReplyMethod(wrap,setter,"v@:@")) return;
            for(NSString *setter in @[@"setM_uiCreateTime:",@"setM_uiStatus:"]) if(!ReplyMethod(wrap,setter,"v@:I")) return;
            ((void(*)(id,SEL,id))objc_msgSend)(wrap,NSSelectorFromString(@"setM_nsContent:"),text);
            ((void(*)(id,SEL,id))objc_msgSend)(wrap,NSSelectorFromString(@"setM_nsFromUsr:"),token.subject.account);
            ((void(*)(id,SEL,id))objc_msgSend)(wrap,NSSelectorFromString(@"setM_nsToUsr:"),token.subject.sender);
            ((void(*)(id,SEL,unsigned int))objc_msgSend)(wrap,NSSelectorFromString(@"setM_uiCreateTime:"),(unsigned int)NSDate.date.timeIntervalSince1970);
            ((void(*)(id,SEL,unsigned int))objc_msgSend)(wrap,NSSelectorFromString(@"setM_uiStatus:"),1);
            if(!ReplyEligible(token) || !ReserveReply(token)) return;
            ((void(*)(id,SEL,id,id))objc_msgSend)(manager,NSSelectorFromString(@"AddMsg:MsgWrap:"),token.subject.sender,wrap);
        } @catch (__unused NSException *exception) {
            // No blind retries: AddMsg may already have enqueued the outgoing text.
        }
      });
    });
}
