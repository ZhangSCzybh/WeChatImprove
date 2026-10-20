#import "CSCloseFriendNotificationAdapter.h"
#import "CSPaymentAutomation.h"
#import "CSPaymentLedger.h"
#import "CSServiceCenter.h"
#import "CSPreferenceRefresh.h"
#import <UIKit/UIKit.h>
#import <objc/message.h>
#import <objc/runtime.h>

static atomic_bool transferEnabled, envelopeEnabled, refreshPending;
static atomic_uint_fast64_t paymentEpoch;
static atomic_uint pendingIngress;
static const void *ownerKey=&ownerKey;
static NSString *const scopeKey=@"CSOwnedPaymentRequest";
static CSPaymentTaskStore *store;
static CSPaymentLedger *ledger;
// Bounded metadata for matching later manual receipts. No polling or payment retries.
static NSMutableDictionary<NSString *,CSPaymentTask *> *receiptSources;
static NSDictionary *transferSettings, *envelopeSettings;
static dispatch_source_t timer;
static BOOL pumping;
static NSString *activeAccount;
static void CSPump(void);
static NSTimeInterval CSNow(void) { return NSDate.date.timeIntervalSince1970; }
static id CSValue(id obj, NSString *key) {
    @try { return [obj valueForKey:key]; }
    @catch (__unused NSException *e) { return nil; }
}
static id CSCall(id object, NSString *name) {
    SEL s=NSSelectorFromString(name);
    return [object respondsToSelector:s] ? ((id(*)(id,SEL))objc_msgSend)(object,s) : nil;
}
static id CSSelfContact(void) { return CSCall(CSGetService(NSClassFromString(@"CContactMgr")),@"getSelfContact"); }
static NSString *CSAccount(void) { return CSPaymentString(CSValue(CSSelfContact(),@"m_nsUsrName")); }
static BOOL CSGroup(NSString *s) { return [s hasSuffix:@"@chatroom"]; }
static NSArray *CSGroups(id value) {
    if (![value isKindOfClass:NSArray.class]) return @[];
    NSMutableArray *result=[NSMutableArray array];
    for (id s in value) if (CSPaymentString(s) && CSGroup(s)) [result addObject:s];
    return result;
}
static NSDictionary *CSSettings(BOOL envelope) {
    NSUserDefaults *d=NSUserDefaults.standardUserDefaults;
    NSString *(^key)(NSString *)=^NSString *(NSString *s) {
        if (envelope) return [@"com.wechat.enhance.redenvelop." stringByAppendingString:s];
        return [@"kReceiveTransfer" stringByAppendingFormat:@"%@Key",s];
    };
    NSString *(^text)(NSString *)=^NSString *(NSString *k){ return CSPaymentString([d objectForKey:key(k)])?:@""; };
    BOOL (^flag)(NSString *)=^BOOL(NSString *k){ return [CSPaymentInteger([d objectForKey:key(k)]) boolValue]; };
    NSString *group=key(envelope?@"groupEnable":@"GroupEnable");
    return @{@"enabled":@(flag(envelope?@"autoReceive":@"AutoEnable")),
             @"private":@(flag(envelope?@"privateEnable":@"PrivateEnable")),
             @"group":@([d objectForKey:group] ? [CSPaymentInteger([d objectForKey:group]) boolValue] : YES),
             @"delay":@(MAX(0,MIN(10,[CSPaymentInteger([d objectForKey:key(envelope?@"delay":@"Delay")]) integerValue]))),
             @"notify":@(MAX(0,MIN(2,[CSPaymentInteger([d objectForKey:key(envelope?@"notifyTarget":@"NotifyTarget")]) integerValue]))),
             @"reply":@(envelope ? ([d objectForKey:key(@"autoReplyEnable")] ? flag(@"autoReplyEnable") : (text(@"privateReply").length || text(@"groupReply").length)) : flag(@"AutoReplyEnable")),
             @"privateReply":text(envelope?@"privateReply":@"PrivateAutoReply"),
             @"groupReply":text(envelope?@"groupReply":@"GroupAutoReply"),
             @"serial":@(envelope && flag(@"serialReceive")), @"self":@(envelope && flag(@"receiveSelf")),
             @"scope":@(MAX(0,MIN(2,[CSPaymentInteger([d objectForKey:key(@"groupScope")]) integerValue]))),
             @"allowed":[NSSet setWithArray:CSGroups([d objectForKey:key(@"allowedGroups")])],
             @"blocked":[NSSet setWithArray:CSGroups([d objectForKey:key(@"blockedGroups")])]};
}
static BOOL CSCurrentAccount(CSPaymentTask *t) {
    return t.epoch==atomic_load(&paymentEpoch) && !(t.epoch&1) && [t.account isEqual:activeAccount];
}
static BOOL CSEligible(CSPaymentTask *t) {
    if (!CSCurrentAccount(t)) return NO;
    NSDictionary *c=t.envelope?envelopeSettings:transferSettings;
    if (![c[@"enabled"] boolValue] || ![c[CSGroup(t.session)?@"group":@"private"] boolValue]) return NO;
    if (t.envelope && CSGroup(t.session)) {
        if ([t.payload[@"self"] boolValue] && ![c[@"self"] boolValue]) return NO;
        NSInteger scope=[c[@"scope"] integerValue];
        if (scope==1 && ![c[@"allowed"] containsObject:t.session]) return NO;
        if (scope==2 && [c[@"blocked"] containsObject:t.session]) return NO;
    }
    return YES;
}
static void CSStopNativeLogic(CSPaymentTask *t) {
    id logic=t.nativeLogic; t.nativeLogic=nil;
    if (logic) @try { SEL sel=NSSelectorFromString(@"stopLogic"); if ([logic respondsToSelector:sel]) ((void(*)(id,SEL))objc_msgSend)(logic,sel); } @catch (__unused NSException *e) {}
}
static void CSFinish(CSPaymentTask *t) {
    if (![store contains:t]) return;
    [store finish:t now:CSNow()];
    CSStopNativeLogic(t);
}

id CSPaymentOwner(id obj) { return obj ? objc_getAssociatedObject(obj,ownerKey) : nil; }
void CSPaymentSetOwner(id obj, id task) { if (obj) objc_setAssociatedObject(obj,ownerKey,task,OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
BOOL CSPaymentCanConfirm(id obj) {
    if (![NSThread isMainThread] || ![obj isKindOfClass:CSPaymentTask.class]) return NO;
    activeAccount=CSAccount();
    CSPaymentTask *t=obj;
    return [store contains:t] && t.phase==CSPaymentConfirming && !t.openRequest && t.deadline>CSNow() && CSEligible(t);
}
void CSPaymentWithOwner(id task, dispatch_block_t block) {
    NSMutableDictionary *d=NSThread.currentThread.threadDictionary;
    id previous=d[scopeKey];
    if (task) d[scopeKey]=task; else [d removeObjectForKey:scopeKey];
    @try { block(); } @finally { if (previous) d[scopeKey]=previous; else [d removeObjectForKey:scopeKey]; }
}
dispatch_block_t CSPaymentGuardConfirmation(dispatch_block_t callback) {
    CSPaymentTask *task=NSThread.currentThread.threadDictionary[scopeKey];
    if (!task || !callback) return callback;
    return [^{
        dispatch_block_t invoke=^{ if (CSPaymentCanConfirm(task)) CSPaymentWithOwner(task,callback); };
        if (NSThread.isMainThread) invoke(); else dispatch_async(dispatch_get_main_queue(),invoke);
    } copy];
}
static NSData *CSBuffer(id buffer) {
    id data=CSValue(buffer,@"buffer");
    return [data isKindOfClass:NSData.class] && [data length]<=256*1024 ? [data copy] : nil;
}
static NSDictionary *CSRequestIdentity(CSPaymentTask *t, NSDictionary *actual) {
    if (!actual) return nil;
    if (!t.envelope) {
        // Native command 85 uses trans_id; command 84 uses transfer_id.
        NSMutableDictionary *e=[(t.phase==CSPaymentVerifying ? @{@"transfer_id":t.payload[@"id"]} : @{@"trans_id":t.payload[@"id"],@"op":@"confirm"}) mutableCopy];
        if (CSGroup(t.session)) e[@"group_username"]=t.session;
        return CSPaymentRequestMatches(e,actual) ? e : nil;
    }
    NSDictionary *p=t.payload[@"params"];
    NSDictionary *e=@{@"sendId":p[@"sendId"],@"channelId":p[@"channelId"],@"msgType":p[@"msgType"]};
    if (!CSPaymentRequestMatches(e,actual)) return nil;
    if (!CSPaymentRequestMatches(@{@"nativeUrl":p[@"nativeUrl"]},actual)) return nil;
    if (actual[@"sign"] && (!p[@"sign"] || !CSPaymentRequestMatches(@{@"sign":p[@"sign"]},actual))) return nil;
    if (t.phase==CSPaymentOpening && (!CSPaymentRequestMatches(@{@"sessionUserName":t.session,@"timingIdentifier":t.payload[@"timing"]},actual))) return nil;
    return e;
}
static void CSPruneSources(void) {
    for (NSString *key in receiptSources.allKeys) {
        CSPaymentTask *t=receiptSources[key];
        if (!CSCurrentAccount(t) || t.deadline<=CSNow()) [receiptSources removeObjectForKey:key];
    }
}
static void CSRememberSource(CSPaymentTask *t) {
    if (!receiptSources) receiptSources=[NSMutableDictionary dictionary];
    CSPruneSources();
    if (receiptSources[t.key]) return;
    if (receiptSources.count>=384) {
        NSString *oldest=nil; double deadline=DBL_MAX;
        for (NSString *key in receiptSources) if (receiptSources[key].deadline<deadline) { oldest=key; deadline=receiptSources[key].deadline; }
        if (oldest) [receiptSources removeObjectForKey:oldest];
    }
    CSPaymentTask *source=[CSPaymentTask new];
    source.key=t.key; source.account=t.account; source.session=t.session; source.payload=t.payload;
    source.epoch=t.epoch; source.envelope=t.envelope; source.deadline=CSNow()+86400;
    receiptSources[t.key]=source;
}
static CSPaymentTask *CSManualReceipt(NSDictionary *actual, BOOL envelope, NSInteger cmd) {
    // Only a submitted confirm/open for a previously validated incoming card.
    // Queries, broadcasts and third-party cards cannot create receipt effects.
    if (cmd!=(envelope?4:85)) return nil;
    CSPruneSources();
    for (CSPaymentTask *source in receiptSources.allValues) {
        if (source.envelope!=envelope || !CSEligible(source) || [ledger containsKey:source.key]) continue;
        CSPaymentTask *t=[CSPaymentTask new];
        t.key=source.key; t.account=source.account; t.session=source.session; t.epoch=source.epoch;
        t.envelope=envelope; t.observation=YES; t.payload=source.payload;
        t.phase=envelope?CSPaymentOpening:CSPaymentConfirming; t.deadline=CSNow()+30;
        if (envelope) {
            NSString *timing=CSPaymentString(actual[@"timingIdentifier"]);
            if (!timing) continue;
            NSMutableDictionary *p=[t.payload mutableCopy]; p[@"timing"]=timing; t.payload=p;
        }
        if (CSRequestIdentity(t,actual) && [store add:t now:CSNow()]) return t;
    }
    return nil;
}
void CSPaymentCaptureRequest(id req, id buffer, BOOL envelope) {
    if (!NSThread.isMainThread || CSPaymentOwner(req)) return;
    CSPaymentTask *scoped=NSThread.currentThread.threadDictionary[scopeKey];
    BOOL verifying=!envelope && [scoped isKindOfClass:CSPaymentTask.class] && !scoped.envelope && scoped.phase==CSPaymentVerifying;
    // Finish the read-only receipt check for an already submitted transfer even
    // when automation is turned off; replies/notifications still obey the switch.
    if (!verifying && !atomic_load(envelope?&envelopeEnabled:&transferEnabled)) return;
    @try {
        activeAccount=CSAccount();
        NSDictionary *actual=CSPaymentDecode(CSBuffer(buffer));
        NSInteger cmd=[CSPaymentInteger(CSValue(req,@"cgiCmd")) integerValue];
        CSPaymentTask *t=scoped;
        if (!t) t=CSManualReceipt(actual,envelope,cmd);
        if (![t isKindOfClass:CSPaymentTask.class] || t.envelope!=envelope || ![store contains:t] || !CSCurrentAccount(t) || (!verifying && !CSEligible(t))) return;
        if (cmd!=(envelope?(t.phase==CSPaymentQuerying?3:4):(verifying?84:85)) || !CSRequestIdentity(t,actual)) return;
        if (((envelope && t.phase==CSPaymentQuerying) || verifying) && !t.queryRequest) t.queryRequest=req;
        else if ((t.phase==CSPaymentOpening || t.phase==CSPaymentConfirming) && !t.openRequest) t.openRequest=req;
        else return;
        CSPaymentSetOwner(req,t);
        if (t.observation) CSPump();
    } @catch (__unused NSException *e) {}
}

NSDictionary *CSPaymentResponseSnapshot(id res, id req, BOOL envelope, BOOL failed) {
    CSPaymentTask *t=CSPaymentOwner(req);
    if (![t isKindOfClass:CSPaymentTask.class] || t.envelope!=envelope) return nil;
    @try {
        NSData *body=CSBuffer(CSValue(res,@"retText"));
        NSData *request=CSBuffer(CSValue(req,@"reqText"));
        NSNumber *base=CSPaymentInteger(CSValue(CSValue(res,@"baseResponse"),@"ret"));
        NSNumber *platform=CSPaymentInteger(CSValue(res,@"platRet"));
        NSNumber *error=CSPaymentInteger(CSValue(res,envelope?@"errorType":@"tenpayErrType"));
        NSNumber *cmd=CSPaymentInteger(CSValue(req,@"cgiCmd"));
        NSNumber *responseCmd=CSPaymentInteger(CSValue(res,@"cgiCmdid"));
        // The native common-response path does not require baseResponse. A missing
        // optional protobuf base or zero response command is not a payment error.
        BOOL valid=!failed && (!CSValue(res,@"baseResponse") || (base && !base.longLongValue)) && platform && error && !platform.longLongValue && !error.longLongValue && cmd.integerValue>0 && (!responseCmd || !responseCmd.integerValue || [cmd isEqual:responseCmd]);
        return @{@"task":t,@"requestObject":req,@"bodyData":body?:NSData.data,@"requestData":request?:NSData.data,@"valid":@(valid),@"cmd":cmd?:@0};
    } @catch (__unused NSException *e) { return @{@"task":t,@"requestObject":req,@"valid":@NO,@"bodyData":NSData.data,@"requestData":NSData.data,@"cmd":@0}; }
}
static void CSSend(NSString *content, NSString *session, CSPaymentTask *t) {
    if (!content.length || !session.length || !CSEligible(t) ||
        !CSCFPaymentOutputAllowed(t.account,t.session,CSPaymentString(t.payload[t.envelope?@"sender":@"payer"]))) return;
    id mgr=CSGetService(NSClassFromString(@"CMessageMgr")); Class cls=NSClassFromString(@"CMessageWrap");
    SEL init=NSSelectorFromString(@"initWithMsgType:"), add=NSSelectorFromString(@"AddMsg:MsgWrap:");
    if (![cls instancesRespondToSelector:init] || ![mgr respondsToSelector:add]) return;
    @try {
        id wrap=((id(*)(id,SEL,unsigned int))objc_msgSend)([cls alloc],init,1);
        [wrap setValue:content forKey:@"m_nsContent"]; [wrap setValue:t.account forKey:@"m_nsFromUsr"];
        [wrap setValue:session forKey:@"m_nsToUsr"]; [wrap setValue:@((unsigned int)CSNow()) forKey:@"m_uiCreateTime"];
        [wrap setValue:@1 forKey:@"m_uiStatus"];
        ((void(*)(id,SEL,id,id))objc_msgSend)(mgr,add,session,wrap);
    } @catch (__unused NSException *e) {}
}
static NSString *CSNotificationName(id value) {
    NSString *name=CSPaymentString(value);
    if (!name) return nil;
    BOOL truncated=name.length>80;
    if (truncated) name=[name substringWithRange:[name rangeOfComposedCharacterSequencesForRange:NSMakeRange(0,80)]];
    NSMutableCharacterSet *separators=[NSCharacterSet.whitespaceAndNewlineCharacterSet mutableCopy];
    [separators formUnionWithCharacterSet:NSCharacterSet.controlCharacterSet];
    NSMutableArray *parts=[NSMutableArray array];
    for (NSString *part in [name componentsSeparatedByCharactersInSet:separators]) if (part.length) [parts addObject:part];
    name=[parts componentsJoinedByString:@" "];
    return name.length ? (truncated ? [name stringByAppendingString:@"…"] : name) : nil;
}
static NSString *CSNotificationContactName(NSString *username, NSString *fallback) {
    if (CSPaymentString(username)) {
        @try {
            id manager=CSGetService(NSClassFromString(@"CContactMgr"));
            // Two bounded local lookups, only when a successful receipt needs a notification.
            for (NSString *method in @[@"getContactByNameFromCache:",@"getContactByName:"]) {
                SEL sel=NSSelectorFromString(method);
                if (![manager respondsToSelector:sel]) continue;
                @try {
                    id contact=((id(*)(id,SEL,id))objc_msgSend)(manager,sel,username);
                    NSString *name=CSNotificationName(CSValue(contact,@"m_nsRemark"))?:CSNotificationName(CSValue(contact,@"m_nsNickName"));
                    if (name) return name;
                } @catch (__unused NSException *e) {}
            }
        } @catch (__unused NSException *e) {}
    }
    return CSNotificationName(fallback);
}
static NSString *CSNotificationMoney(long long cents, NSString *currency) {
    NSString *number=[NSString stringWithFormat:@"%lld.%02lld",cents/100,cents%100];
    return [currency isEqual:@"CNY"] ? [@"¥" stringByAppendingString:number] : [NSString stringWithFormat:@"%@ %@",currency,number];
}
// Called on the payment main queue. Display-only metadata never decides receipt success.
static NSString *CSNotificationText(CSPaymentTask *t, long long cents, NSString *currency, NSDictionary *receipt, NSDate *receivedAt) {
    NSMutableArray *lines=[NSMutableArray arrayWithObjects:t.envelope?@"🧧 红包已领取":@"💰 转账已收款",
        [@"到账金额：" stringByAppendingString:CSNotificationMoney(cents,currency)],nil];
    if (t.envelope) {
        // Native OnContinueOpenRedEnvelopesRequest: maps totalAmount to m_lTotalAmount.
        NSNumber *total=CSPaymentInteger(receipt[@"totalAmount"]);
        NSString *text=total.longLongValue>=cents && total.longLongValue>0 ? CSNotificationMoney(total.longLongValue,@"CNY") : @"未提供";
        [lines addObject:[@"红包总额：" stringByAppendingString:text]];
    }
    [lines addObject:@""];
    NSString *sender=CSPaymentString(t.payload[t.envelope?@"sender":@"payer"]), *nick=nil;
    if (t.envelope) {
        NSString *reported=CSPaymentString(receipt[@"sendUserName"]);
        if (reported && !CSGroup(reported) && (!sender || [reported isEqual:sender])) {
            sender=reported; nick=CSPaymentString(receipt[@"sendNick"]);
        }
    }
    if (sender && !CSGroup(sender)) {
        NSString *name=CSNotificationContactName(sender,nick?:@"未获取昵称");
        [lines addObject:[@"来自：" stringByAppendingString:name?:@"未获取昵称"]];
    }
    if (CSGroup(t.session)) [lines addObject:[@"群聊：" stringByAppendingString:CSNotificationContactName(t.session,@"未获取群名")]];
    else [lines addObject:@"会话：私聊"];
    static NSDateFormatter *formatter; static dispatch_once_t once;
    dispatch_once(&once,^{
        formatter=[NSDateFormatter new]; formatter.locale=[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        formatter.calendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        formatter.dateFormat=@"MM-dd HH:mm:ss";
    });
    formatter.timeZone=NSTimeZone.defaultTimeZone;
    [lines addObject:[@"时间：" stringByAppendingString:[formatter stringFromDate:receivedAt]]];
    return [lines componentsJoinedByString:@"\n"];
}
static void CSSuccess(CSPaymentTask *t, long long cents, NSString *currency, NSDictionary *receipt) {
    NSDate *receivedAt=NSDate.date;
    for (CSPaymentTask *other in store.tasks) if ([other.key isEqual:t.key]) CSFinish(other);
    [receiptSources removeObjectForKey:t.key];
    NSTimeInterval effectDeadline=CSNow()+15;
    [ledger recordKey:t.key envelope:t.envelope cents:cents currency:currency completion:^(BOOL written){
        activeAccount=CSAccount();
        if (!written || CSNow()>effectDeadline || !CSEligible(t)) return;
        NSDictionary *c=t.envelope?envelopeSettings:transferSettings;
        NSString *reply=[c[CSGroup(t.session)?@"groupReply":@"privateReply"] stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
        if ([c[@"reply"] boolValue] && reply.length) CSSend(reply,t.session,t);
        NSInteger target=[c[@"notify"] integerValue];
        if (target) {
            NSString *message=CSNotificationText(t,cents,currency,receipt,receivedAt);
            CSSend(message,target==1?t.account:@"filehelper",t);
        }
    }];
}
static void CSVerifyTransfer(CSPaymentTask *t) {
    // Match the native confirm -> status sequence, with one bounded read and no
    // payment retry. Keep the exact request owner through the network boundary.
    t.phase=CSPaymentVerifying; t.deadline=CSNow()+30;
    @try {
        id mgr=CSGetService(NSClassFromString(@"WCPayLogicMgr"));
        Class cls=NSClassFromString(@"WCPayCheckTransferStatusRequest");
        SEL sel=NSSelectorFromString(@"CheckTransferMoneyStatus:");
        if (!cls || ![mgr respondsToSelector:sel]) { CSFinish(t); return; }
        id request=[cls new];
        [request setValue:t.payload[@"id"] forKey:@"m_nsTransferID"];
        [request setValue:t.payload[@"invalidtime"] forKey:@"m_uiInvalidTime"];
        if (CSGroup(t.session)) [request setValue:t.session forKey:@"group_username"];
        CSPaymentWithOwner(t,^{ ((void(*)(id,SEL,id))objc_msgSend)(mgr,sel,request); });
        if (!t.queryRequest) CSFinish(t);
    } @catch (__unused NSException *e) { CSFinish(t); }
}
void CSPaymentHandleResponse(NSDictionary *snapshot) {
    if (!snapshot) return;
    dispatch_async(dispatch_get_main_queue(),^{
        activeAccount=CSAccount();
        CSPaymentTask *t=snapshot[@"task"]; id req=snapshot[@"requestObject"];
        if (![store contains:t]) return;
        BOOL query=t.envelope && t.phase==CSPaymentQuerying && req==t.queryRequest;
        BOOL verifying=!t.envelope && t.phase==CSPaymentVerifying && req==t.queryRequest;
        BOOL open=(t.phase==CSPaymentOpening || t.phase==CSPaymentConfirming) && req==t.openRequest;
        if (!query && !open && !verifying) return;
        if (!CSCurrentAccount(t) || (query && !CSEligible(t)) || t.deadline<=CSNow()) { CSFinish(t); CSPump(); return; }
        NSDictionary *body=CSPaymentDecode(snapshot[@"bodyData"])?:@{};
        BOOL valid=[snapshot[@"valid"] boolValue] && CSRequestIdentity(t,CSPaymentDecode(snapshot[@"requestData"])) && CSPaymentErrorsOK(body);
        valid=valid && [snapshot[@"cmd"] integerValue]==(t.envelope?(query?3:4):(verifying?84:85));
        for (NSString *key in @[@"exclusive_recv_username",@"receiver_username"]) {
            NSString *receiver=CSPaymentString(body[key]);
            if (t.envelope && receiver && ![receiver isEqual:t.account]) { [receiptSources removeObjectForKey:t.key]; valid=NO; }
        }
        if (!valid) { CSFinish(t); CSPump(); return; }
        if (query) {
            NSNumber *received=CSPaymentInteger(body[@"receiveStatus"]), *status=CSPaymentInteger(body[@"hbStatus"]);
            NSString *timing=CSPaymentString(body[@"timingIdentifier"]);
            if (!received || !status || (received.integerValue!=0 && received.integerValue!=1) || status.integerValue!=2 || !timing) CSFinish(t);
            else {
                NSMutableDictionary *payload=[t.payload mutableCopy]; payload[@"timing"]=timing; t.payload=payload;
                t.queryRequest=nil; t.phase=CSPaymentReady;
                t.readyAt=CSNow()+[envelopeSettings[@"delay"] doubleValue]; t.deadline=t.readyAt+30;
            }
        } else if (t.envelope) {
            NSNumber *amount=nil;
            for (NSString *key in @[@"amount",@"receiveAmount",@"receive_amount",@"recvAmount",@"recv_amount"]) {
                if (!body[key]) continue;
                NSNumber *v=CSPaymentInteger(body[key]);
                if (!v || v.longLongValue<=0 || (amount && ![amount isEqual:v])) { amount=nil; break; }
                amount=v;
            }
            if (!amount || amount.longLongValue<=0) CSFinish(t);
            else CSSuccess(t,amount.longLongValue,@"CNY",body);
        } else {
            if (verifying) {
                // These are the status response's username fields, not the
                // optional payer/receiver fields from confirmation command 85.
                NSNumber *amount=CSPaymentInteger(body[@"fee"]);
                NSString *currency=CSPaymentString(body[@"fee_type"]);
                if ([currency isEqual:@"1"] || [body[@"fee_type"] isEqual:@1]) currency=@"CNY";
                NSNumber *status=CSPaymentInteger(body[@"trans_status"]);
                NSNumber *payer=CSPaymentInteger(body[@"is_payer"]);
                // 8.0.78 maps 2001 to Succeed_Receiver; 2000 is still waiting.
                BOOL received=status.integerValue==2001 && (!body[@"is_payer"] || (payer && !payer.boolValue));
                if (!received || !amount || amount.longLongValue<=0 || currency.length!=3 || ![body[@"receiver_name"] isEqual:t.account] || ![body[@"payer_name"] isEqual:t.payload[@"payer"]]) CSFinish(t);
                else CSSuccess(t,amount.longLongValue,currency,body);
            } else {
                // Confirmation fields and guides cannot prove settlement. A read
                // cannot accept a license or bypass an intercept; only the final
                // status of this exact transaction can produce receipt effects.
                if (!body.count) CSFinish(t);
                else CSVerifyTransfer(t);
            }
        }
        CSPump();
    });
}
static void CSSubmit(CSPaymentTask *t) {
    @try {
        if (!t.envelope) {
            Class dataClass=NSClassFromString(@"WCPayControlData");
            id mgr=CSGetService(NSClassFromString(@"WCPayControlMgr"));
            SEL sel=NSSelectorFromString(@"startReceiverConfirmTransferMoneyLogic:Data:");
            if (!dataClass || ![mgr respondsToSelector:sel]) { CSFinish(t); return; }
            SEL busy=NSSelectorFromString(@"IsDoingWCPayLogic:");
            Class logicClass=NSClassFromString(@"WCPayReveiverControlTransferControlLogic");
            if (CSCall(mgr,@"getCurrentLogic") || ([mgr respondsToSelector:busy] && ((BOOL(*)(id,SEL,Class))objc_msgSend)(mgr,busy,logicClass))) { CSFinish(t); return; }
            id data=[dataClass new];
            [data setValue:t.payload[@"id"] forKey:@"m_nsTransferID"];
            [data setValue:t.payload[@"invalidtime"] forKey:@"m_uiTransferInvalidTime"];
            if (CSGroup(t.session)) [data setValue:t.session forKey:@"selectedTransferChatroomUsername"];
            CSPaymentSetOwner(data,t); t.phase=CSPaymentConfirming; t.deadline=CSNow()+30;
            // Native manager retains/starts the logic. No unrelated chat controller
            // traversal or fabricated chat view is needed for an optional delegate.
            ((unsigned int(*)(id,SEL,id,id))objc_msgSend)(mgr,sel,nil,data);
        } else {
            id mgr=CSGetService(NSClassFromString(@"WCRedEnvelopesLogicMgr"));
            BOOL open=t.phase==CSPaymentReady;
            SEL sel=NSSelectorFromString(open?@"OpenRedEnvelopesRequest:":@"ReceiverQueryRedEnvelopesRequest:");
            if (![mgr respondsToSelector:sel]) { CSFinish(t); return; }
            NSMutableDictionary *params=[t.payload[@"params"] mutableCopy];
            if (open) { params[@"timingIdentifier"]=t.payload[@"timing"]; params[@"sessionUserName"]=t.session; }
            else { [params removeObjectForKey:@"sessionUserName"]; [params removeObjectForKey:@"nickName"]; [params removeObjectForKey:@"headImg"]; }
            t.phase=open?CSPaymentOpening:CSPaymentQuerying; t.deadline=CSNow()+30;
            CSPaymentWithOwner(t,^{ ((void(*)(id,SEL,id))objc_msgSend)(mgr,sel,params); });
            if (!(open?t.openRequest:t.queryRequest)) CSFinish(t);
        }
    } @catch (__unused NSException *e) { CSFinish(t); }
}
static void CSPump(void) {
    if (pumping || !store) return;
    if (!store.tasks.count) { if (timer) { dispatch_source_cancel(timer); timer=nil; } return; }
    pumping=YES;
    @try {
        activeAccount=CSAccount();
        NSTimeInterval now=CSNow();
        for (CSPaymentTask *t in [store expireAt:now]) CSStopNativeLogic(t);
        for (CSPaymentTask *t in store.tasks) {
            BOOL submitted=t.openRequest && (t.phase==CSPaymentOpening || t.phase==CSPaymentConfirming || t.phase==CSPaymentVerifying);
            if (!CSCurrentAccount(t) || (!submitted && !CSEligible(t))) CSFinish(t);
        }
        if (ledger.ready) {
            CSPaymentTask *next;
            while ((next=[store nextAt:CSNow() serial:[envelopeSettings[@"serial"] boolValue]])) CSSubmit(next);
        }
        if (timer) { dispatch_source_cancel(timer); timer=nil; }
        NSTimeInterval wake=[store nextWakeAt:CSNow()];
        if (wake<DBL_MAX) {
            timer=dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0,0,dispatch_get_main_queue());
            dispatch_source_set_timer(timer,dispatch_walltime(NULL,(int64_t)(MAX(.01,wake-CSNow())*NSEC_PER_SEC)),DISPATCH_TIME_FOREVER,20*NSEC_PER_MSEC);
            dispatch_source_set_event_handler(timer,^{ CSPump(); }); dispatch_resume(timer);
        }
    } @finally { pumping=NO; }
}
static void CSAdmit(NSDictionary *s, BOOL envelope, uint64_t epoch) {
    if (epoch!=atomic_load(&paymentEpoch) || (epoch&1)) return;
    NSString *account=CSAccount(), *from=CSPaymentString(s[@"from"]), *to=CSPaymentString(s[@"to"]);
    if (!account || !from || !to) return;
    activeAccount=account;
    NSDictionary *payload=nil; NSString *session=nil,*identifier=nil;
    if (!envelope) {
        payload=CSPaymentTransferFields(s[@"xml"],s[@"pay"],account,from,to);
        if (!payload) return;
        session=payload[@"session"]; identifier=payload[@"id"];
    } else {
        NSDictionary *fields=CSPaymentXMLFields(s[@"xml"]);
        if (!fields) return;
        NSString *url=CSPaymentString(s[@"url"])?:CSPaymentString(fields[@"nativeurl"]);
        if (CSPaymentString(s[@"url"]) && CSPaymentString(fields[@"nativeurl"]) && ![s[@"url"] isEqual:fields[@"nativeurl"]]) return;
        NSURLComponents *components=[NSURLComponents componentsWithString:url];
        if (![components.scheme isEqual:@"wxpay"] || ![components.host isEqual:@"c2cbizmessagehandler"] || ![components.path isEqual:@"/hongbao/receivehongbao"]) return;
        NSDictionary *q=CSPaymentQuery(url);
        NSString *send=CSPaymentString(q[@"sendid"]?:q[@"sendId"]),*channel=CSPaymentString(q[@"channelid"]?:q[@"channelId"]),*type=CSPaymentString(q[@"msgtype"]?:q[@"msgType"]);
        if (!send || !CSPaymentInteger(channel) || !CSPaymentInteger(type) || type.integerValue<=0 || channel.integerValue<0) return;
        for (NSArray *pair in @[@[@"sendid",@"sendId"],@[@"channelid",@"channelId"],@[@"msgtype",@"msgType"]]) if (q[pair[0]] && q[pair[1]] && ![q[pair[0]] isEqual:q[pair[1]]]) return;
        BOOL selfSent=[from isEqual:account] || (CSGroup(from) && [s[@"sender"] isEqual:account]);
        for (id exclusive in @[s[@"exclusive"]?:@"", fields[@"exclusive_recv_username"]?:@"",q[@"exclusive_recv_username"]?:@""]) {
            if (CSPaymentString(exclusive) && ![exclusive isEqual:account]) return;
        }
        if (CSGroup(from)) session=from;
        else if (selfSent && CSGroup(to)) session=to;
        else if (!selfSent && [to isEqual:account] && !CSGroup(to)) session=from;
        if (!session.length) return;
        id contact=CSSelfContact();
        NSMutableDictionary *params=[@{@"sendId":send,@"channelId":channel,@"msgType":type,@"nativeUrl":url,@"agreeDuty":@"0",@"inWay":@"0",@"sessionUserName":session} mutableCopy];
        NSString *sign=CSPaymentString(q[@"sign"]); if (sign) params[@"sign"]=sign;
        NSString *nick=CSPaymentString(CSValue(contact,@"m_nsNickName")), *head=CSPaymentString(CSValue(contact,@"m_nsHeadImgUrl"));
        if (nick) params[@"nickName"]=nick; if (head) params[@"headImg"]=head;
        NSString *sender=selfSent?account:(CSGroup(from)?CSPaymentString(s[@"sender"]):from);
        payload=@{@"params":[params copy],@"self":@(selfSent),@"sender":(sender && !CSGroup(sender))?sender:@""}; identifier=send;
    }
    CSPaymentTask *t=[CSPaymentTask new]; t.account=account; t.session=session; t.payload=payload; t.envelope=envelope; t.epoch=epoch;
    t.key=CSPaymentBusinessKey(account,envelope?@"envelope":@"transfer",session,identifier);
    t.readyAt=CSNow()+(envelope?0:[transferSettings[@"delay"] doubleValue]); t.deadline=t.readyAt+30;
    if (!CSEligible(t) || [ledger containsKey:t.key]) return;
    CSRememberSource(t);
    if ([store add:t now:CSNow()]) CSPump();
}
void CSPaymentAdmitMessage(id wrap, BOOL envelope) {
    if (!atomic_load(envelope?&envelopeEnabled:&transferEnabled)) return;
    uint64_t epoch=atomic_load(&paymentEpoch); if (epoch&1) return;
    @try {
        SEL type=NSSelectorFromString(@"m_uiMessageType");
        if (![wrap respondsToSelector:type] || ((unsigned int(*)(id,SEL))objc_msgSend)(wrap,type)!=49) return;
        id info=CSValue(wrap,@"m_oWCPayInfoItem");
        NSString *url=CSPaymentString(CSValue(info,@"m_c2cNativeUrl"));
        NSString *xml=CSPaymentString(CSValue(wrap,@"m_nsContent"));
        if (envelope ? (![url containsString:@"/hongbao/receivehongbao"] && ![xml containsString:@"/hongbao/receivehongbao"]) : (!xml && !CSPaymentString(CSValue(info,@"m_nsTransferID")))) return;
        if (!envelope && xml && ![xml containsString:@"<wcpayinfo>"]) return;
        NSMutableDictionary *pay=[NSMutableDictionary dictionary];
        if (!envelope) {
            NSDictionary *keys=@{@"id":@"m_nsTransferID",@"receiver":@"transfer_receiver_username",@"payer":@"transfer_payer_username",@"subtype":@"m_uiPaySubType"};
            for (NSString *k in keys) { id v=CSValue(info,keys[k]); if ([v isKindOfClass:NSString.class] || [v isKindOfClass:NSNumber.class]) pay[k]=[v copy]; }
        }
        NSDictionary *s=@{@"from":[CSPaymentString(CSValue(wrap,@"m_nsFromUsr")) copy]?:@"",@"to":[CSPaymentString(CSValue(wrap,@"m_nsToUsr")) copy]?:@"",@"xml":[xml copy]?:@"",@"url":[url copy]?:@"",@"pay":[pay copy],@"sender":[CSPaymentString(CSValue(wrap,@"m_nsRealChatUsr")) copy]?:@"",@"exclusive":[CSPaymentString(CSValue(info,@"exclusive_recv_username")) copy]?:@""};
        if (atomic_fetch_add(&pendingIngress,1)>=384) { atomic_fetch_sub(&pendingIngress,1); return; }
        dispatch_async(dispatch_get_main_queue(),^{
            atomic_fetch_sub(&pendingIngress,1);
            @try { CSAdmit(s,envelope,epoch); } @catch (__unused NSException *e) {}
        });
    } @catch (__unused NSException *e) {}
}
void CSPaymentReload(void) {
    CSRequestMainRefresh(&refreshPending,^{
        transferSettings=CSSettings(NO); envelopeSettings=CSSettings(YES);
        atomic_store(&transferEnabled,[transferSettings[@"enabled"] boolValue] && ([transferSettings[@"private"] boolValue] || [transferSettings[@"group"] boolValue]));
        atomic_store(&envelopeEnabled,[envelopeSettings[@"enabled"] boolValue] && ([envelopeSettings[@"private"] boolValue] || [envelopeSettings[@"group"] boolValue]));
        CSPump();
    });
}
void CSPaymentAccountWillChange(void) {
    uint64_t old=atomic_load(&paymentEpoch);
    while (!atomic_compare_exchange_weak(&paymentEpoch,&old,(old+2)|1)) {}
    dispatch_async(dispatch_get_main_queue(),^{ CSPump(); });
}
void CSPaymentAccountDidChange(void) {
    uint64_t old=atomic_load(&paymentEpoch);
    while (!atomic_compare_exchange_weak(&paymentEpoch,&old,(old+2)&~(uint64_t)1)) {}
    dispatch_async(dispatch_get_main_queue(),^{ CSPump(); });
}
static void CSChanged(CFNotificationCenterRef c,void *o,CFStringRef n,const void *object,CFDictionaryRef userInfo) { CSPaymentReload(); }
void CSPaymentStart(void) {
    static dispatch_once_t once;
    dispatch_once(&once,^{
        dispatch_async(dispatch_get_main_queue(),^{
            store=[CSPaymentTaskStore new];
            NSURL *base=[NSFileManager.defaultManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask].firstObject;
            ledger=[[CSPaymentLedger alloc] initWithURL:[[base URLByAppendingPathComponent:@"WeChatImprove"] URLByAppendingPathComponent:@"payment-ledger-v1.plist"] defaults:NSUserDefaults.standardUserDefaults];
            [ledger load:^{ for (CSPaymentTask *t in store.tasks) if ([ledger containsKey:t.key]) CSFinish(t); CSPump(); }];
            CSPaymentReload();
            for (NSString *name in @[NSUserDefaultsDidChangeNotification,UIApplicationDidBecomeActiveNotification,UIApplicationDidEnterBackgroundNotification]) {
                [NSNotificationCenter.defaultCenter addObserverForName:name object:nil queue:nil usingBlock:^(__unused NSNotification *n){ CSPaymentReload(); }];
            }
        });
        for (NSString *name in @[@"com.wechat.enhance.receivetransfer.settings_changed",@"com.wechat.enhance.redenvelop.settings_changed"]) CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),NULL,CSChanged,(__bridge CFStringRef)name,NULL,CFNotificationSuspensionBehaviorDeliverImmediately);
    });
}
void CSPaymentResetEnvelopeStatistics(dispatch_block_t completion) {
    [ledger resetEnvelopes:completion];
}
