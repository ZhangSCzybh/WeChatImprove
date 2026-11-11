#import "CSMessageSendAdapter.h"
@interface NSObject (CSMessageWrapConstruction)
- (instancetype)initWithMsgType:(long long)type;
@end
@interface CSMessagePreparedSend ()
@property(nonatomic, strong, readwrite) id outputWrap;
@property(nonatomic, copy) CSMessageActionSubmissionState (^submission)(void);
@property(nonatomic) BOOL submitted;
@property(nonatomic, readwrite) BOOL nativeHandoffReturned;
@end
@implementation CSMessagePreparedSend
- (instancetype)initWithWrap:(id)wrap routeName:(NSString *)routeName submission:(CSMessageActionSubmissionState (^)(void))submission { if ((self=[super init])) { _outputWrap=wrap; _routeName=[routeName copy]; _submission=[submission copy]; } return self; }
- (CSMessageActionSubmissionState)submit {
    @synchronized(self) { if (_submitted) return CSMessageActionSubmissionStateUnknown; _submitted=YES; }
    @try { if (_submissionStillAuthorized && !_submissionStillAuthorized()) return CSMessageActionSubmissionStateFailedBeforeAcceptance; return _submission(); } @catch (__unused NSException *exception) { return CSMessageActionSubmissionStateUnknown; }
}
@end
@interface CSMessageSendAdapter ()
@property(nonatomic, strong) id<CSMessageActionEnvironment> environment;
@end
static id CSFreshWrap(NSUInteger type) {
    Class cls=NSClassFromString(@"CMessageWrap");
    // Native 8.0.78 uses a signed 64-bit message type for this initializer.
    id allocated=[cls alloc];
    if (!CSMessageNativeSupports(allocated,@"initWithMsgType:",@"@",@[@"q"])) return nil;
    return [allocated initWithMsgType:(long long)type];
}
static id CSIndependentCopy(id source) {
    if (![source respondsToSelector:@selector(copyWithZone:)]) return nil;
    id copy=[source copy]; return copy!=source ? copy : nil;
}
static BOOL CSResetSendWrapForAccount(id wrap, NSString *accountID, NSString *target) {
    unsigned int now=(unsigned int)NSDate.date.timeIntervalSince1970;
    return CSMessageNativeSet(wrap,@"setM_nsFromUsr:",accountID,YES) && CSMessageNativeSet(wrap,@"setM_nsToUsr:",target,YES) &&
        CSMessageNativeSet(wrap,@"setM_uiMesLocalID:",@0,YES) && CSMessageNativeSet(wrap,@"setM_n64MesSvrID:",@0,YES) &&
        CSMessageNativeSet(wrap,@"setM_uiCreateTime:",@(now),YES) && CSMessageNativeSet(wrap,@"setM_uiStatus:",@1,YES) &&
        CSMessageNativeSet(wrap,@"setM_uiIsSenderStatus:",@1,NO) && CSMessageNativeSet(wrap,@"setM_uiSendTime:",@(now),NO) &&
        CSMessageNativeSet(wrap,@"setM_nsClientMsgID:",NSUUID.UUID.UUIDString,NO) &&
        CSMessageNativeSet(wrap,@"setM_nsRealChatUsr:",[target containsString:@"@chatroom"] ? accountID : @"",NO) &&
        CSMessageNativeSet(wrap,@"setM_nsMsgSource:",nil,NO) && CSMessageNativeSet(wrap,@"setM_nsRevokeBatchId:",nil,NO);
}
static BOOL CSResetSendWrap(id wrap, CSMessageActionContext *context, NSString *target) {
    return CSResetSendWrapForAccount(wrap,context.accountID,target);
}
static CSMessagePreparedSend *CSVoidRoute(id receiver, NSString *selector, NSArray *arguments, id wrap) {
    __block __weak CSMessagePreparedSend *weakRoute=nil;
    CSMessagePreparedSend *route=[[CSMessagePreparedSend alloc] initWithWrap:wrap routeName:selector submission:^{
        id output=CSMessageNativeInvoke(receiver,selector,arguments);
        if (output && [output isKindOfClass:NSClassFromString(@"CMessageWrap")]) weakRoute.outputWrap=output;
        weakRoute.nativeHandoffReturned=YES;
        return CSMessageActionSubmissionStateUnknown;
    }]; weakRoute=route; return route;
}
@implementation CSMessageSendAdapter
- (instancetype)initWithEnvironment:(id<CSMessageActionEnvironment>)environment { if ((self=[super init])) _environment=environment; return self; }
- (id)voiceWrapForResource:(CSMessageVoiceResource *)voice accountID:(NSString *)accountID targetID:(NSString *)target {
    if (!NSThread.isMainThread || !accountID.length || !target.length || !voice.data.length || !voice.durationMilliseconds) return nil;
    @try {
        id wrap=CSFreshWrap(34); if (!wrap || !CSResetSendWrapForAccount(wrap,accountID,target)) return nil;
        if (!CSMessageNativeSet(wrap,@"setM_dtVoice:",voice.data,YES) || !CSMessageNativeSet(wrap,@"setM_uiVoiceTime:",@(voice.durationMilliseconds),YES) || !CSMessageNativeSet(wrap,@"setM_uiVoiceFormat:",@(voice.format),YES) || !CSMessageNativeSet(wrap,@"setM_uiDownloadStatus:",@9,YES)) return nil;
        CSMessageNativeSet(wrap,@"setM_uiVoiceForwardFlag:",@0,NO);
        CSMessageNativeSet(wrap,@"setM_nsContent:",[NSString stringWithFormat:@"<msg><voicemsg voicelength=\"%u\" voiceformat=\"%u\" forwardflag=\"0\" /></msg>",voice.durationMilliseconds,voice.format],NO);
        return wrap;
    } @catch (__unused NSException *exception) { return nil; }
}
- (CSMessagePreparedSend *)prepareVoiceResource:(CSMessageVoiceResource *)voice accountID:(NSString *)accountID targetID:(NSString *)target {
    if (!NSThread.isMainThread || ![[_environment currentAccountID] isEqual:accountID]) return nil;
    @try {
        id wrap=[self voiceWrapForResource:voice accountID:accountID targetID:target]; if (!wrap) return nil;
        id manager=[_environment serviceNamed:@"CMessageMgr"], audio=[_environment serviceNamed:@"AudioSender"];
        if (!CSMessageNativeSupports(audio,@"uploaderForMsgWrap:",@"@",@[@"@"]) || !CSMessageNativeSupports(manager,@"AddLocalMsg:MsgWrap:",@"v",@[@"@",@"@"])) return nil;
        id uploader=CSMessageNativeInvoke(audio,@"uploaderForMsgWrap:",@[wrap]);
        // AudioSender's own resend deletes originals. Use only its concrete uploader.
        if (uploader==audio || !CSMessageNativeSupports(uploader,@"ResendVoiceMsg:MsgWrap:",@"v",@[@"@",@"@"])) return nil;
        __block __weak CSMessagePreparedSend *weakRoute=nil;
        CSMessagePreparedSend *route=[[CSMessagePreparedSend alloc] initWithWrap:wrap routeName:@"fresh-voice" submission:^{
            CSMessageNativeInvoke(manager,@"AddLocalMsg:MsgWrap:",@[target,wrap]);
            if (!CSMessageNativeUnsigned(wrap,@"m_uiMesLocalID")) return CSMessageActionSubmissionStateUnknown;
            if (weakRoute.submissionStillAuthorized && !weakRoute.submissionStillAuthorized()) return CSMessageActionSubmissionStateUnknown;
            CSMessageNativeInvoke(uploader,@"ResendVoiceMsg:MsgWrap:",@[target,wrap]); weakRoute.nativeHandoffReturned=YES; return CSMessageActionSubmissionStateUnknown;
        }]; weakRoute=route; return route;
    } @catch (__unused NSException *exception) { return nil; }
}
- (CSMessagePreparedSend *)prepareScheduledText:(NSString *)text targetID:(NSString *)targetID accountID:(NSString *)accountID {
    if (!NSThread.isMainThread || !text.length || text.length>4000 || !targetID.length || !accountID.length || ![[_environment currentAccountID] isEqual:accountID]) return nil;
    @try {
        id manager=[_environment serviceNamed:@"CMessageMgr"], wrap=CSFreshWrap(1);
        if (!wrap || !CSMessageNativeSupports(manager,@"AddMsg:MsgWrap:",@"v",@[@"@",@"@"])) return nil;
        if (!CSMessageNativeSet(wrap,@"setM_nsFromUsr:",accountID,YES) || !CSMessageNativeSet(wrap,@"setM_nsToUsr:",targetID,YES) ||
            !CSMessageNativeSet(wrap,@"setM_nsContent:",text,YES) || !CSMessageNativeSet(wrap,@"setM_uiCreateTime:",@((unsigned int)NSDate.date.timeIntervalSince1970),YES) ||
            !CSMessageNativeSet(wrap,@"setM_uiStatus:",@1,YES) || !CSMessageNativeSet(wrap,@"setM_uiMesLocalID:",@0,YES) || !CSMessageNativeSet(wrap,@"setM_n64MesSvrID:",@0,YES)) return nil;
        CSMessageNativeSet(wrap,@"setM_nsClientMsgID:",NSUUID.UUID.UUIDString,NO);
        return CSVoidRoute(manager,@"AddMsg:MsgWrap:",@[targetID,wrap],wrap);
    } @catch (__unused NSException *e) { return nil; }
}
- (CSMessagePreparedSend *)prepareGroupText:(NSString *)text mentions:(NSArray<NSString *> *)mentions targetID:(NSString *)targetID accountID:(NSString *)accountID {
    @try {
        if (![targetID isKindOfClass:NSString.class] || ![targetID hasSuffix:@"@chatroom"] || ![mentions isKindOfClass:NSArray.class] || mentions.count>10000) return nil;
        NSMutableOrderedSet *ids=[NSMutableOrderedSet orderedSet];
        NSCharacterSet *allowed=[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_-@."];
        for(id member in mentions) {
            if(![member isKindOfClass:NSString.class] || ![member length] || [member length]>128 || [member isEqual:@"notify@all"] ||
               [member hasSuffix:@"@chatroom"] || [member rangeOfCharacterFromSet:allowed.invertedSet].location!=NSNotFound)return nil;
            [ids addObject:member];
        }
        CSMessagePreparedSend *route=[self prepareScheduledText:text targetID:targetID accountID:accountID];if(!route)return nil;
        // The generic setter also supports scalar fields. Mentions require the
        // evidenced object ABI; an incompatible setter must never be invoked.
        if(ids.count && (!CSMessageNativeSupports(route.outputWrap,@"setM_nsAtUserList:",@"v",@[@"@"]) ||
            !CSMessageNativeSet(route.outputWrap,@"setM_nsAtUserList:",[ids.array componentsJoinedByString:@","],YES)))return nil;
        return route;
    } @catch (__unused NSException *exception) { return nil; }
}
- (CSMessagePreparedSend *)prepareContext:(CSMessageActionContext *)context targetID:(NSString *)targetID voice:(CSMessageVoiceResource *)voice {
    return [self prepareContext:context targetID:targetID voice:voice appData:nil appDataPath:nil];
}
- (CSMessagePreparedSend *)prepareContext:(CSMessageActionContext *)context targetID:(NSString *)targetID voice:(CSMessageVoiceResource *)voice appData:(NSData *)appData appDataPath:(NSString *)path {
    if (!NSThread.isMainThread || !targetID.length || !context.accountID.length) return nil;
    @try { return [self prepareChecked:context target:targetID voice:voice appData:appData appPath:path]; } @catch (__unused NSException *exception) { return nil; }
}
- (CSMessagePreparedSend *)prepareChecked:(CSMessageActionContext *)context target:(NSString *)target voice:(CSMessageVoiceResource *)voice appData:(NSData *)appData appPath:(NSString *)path {
    id source=context.sourceWrap, manager=[_environment serviceNamed:@"CMessageMgr"];
    id logic=CSMessageActionObjectGetter(context.controller,NSSelectorFromString(@"m_logicController")) ?: CSMessageActionObjectGetter(context.controller,NSSelectorFromString(@"logicController"));
    // WeChat 8.0.78 stores BaseMsgContentLogicController in the page's weak m_delegate.
    // Do not follow unrelated delegates or broaden service/proxy resolution.
    Class pageClass=NSClassFromString(@"BaseMsgContentViewController"), logicClass=NSClassFromString(@"BaseMsgContentLogicController");
    if (pageClass && [context.controller isKindOfClass:pageClass]) {
        id delegate=CSMessageActionObjectGetter(context.controller,NSSelectorFromString(@"m_delegate"));
        logic=logicClass && [delegate isKindOfClass:logicClass] ? delegate : nil;
    }
    if (context.messageType==1) {
        NSString *text=CSMessageActionObjectGetter(source,NSSelectorFromString(@"m_nsContent")); if (![text isKindOfClass:NSString.class] || !text.length || ![target isEqualToString:context.sourceConversationID]) return nil;
        for (id receiver in @[logic ?: NSNull.null,context.controller ?: NSNull.null]) {
            if (CSMessageNativeSupports(receiver,@"SendTextMessage:",@"v",@[@"@"])) return CSVoidRoute(receiver,@"SendTextMessage:",@[text],nil);
            if (CSMessageNativeSupports(receiver,@"SendTextMessage:externInfo:",@"v",@[@"@",@"@"])) return CSVoidRoute(receiver,@"SendTextMessage:externInfo:",@[text,NSNull.null],nil);
        }
        return nil;
    }
    if (context.messageType==34) {
        return [self prepareVoiceResource:voice accountID:context.accountID targetID:target];
    }
    Class factory=NSClassFromString(@"ForwardMsgUtil");
    if (context.messageType==43) return [self prepareVideo:context target:target factory:factory manager:manager];
    id wrap=nil;
    NSDictionary *factories=@{@3:@"imgMsgFromMsgWrap:",@42:@"cardMsgFromMsgWrap:",@48:@"locMsgFromMsgWrap:",@49:@"appMsgFromMsgWrap:"};
    NSString *selector=factories[@(context.messageType)];
    // Type-specific conversion loads the original media before IDs are reset. It is not a generic forward/send fallback.
    if (selector && CSMessageNativeSupports(factory,selector,@"@",@[@"@"])) {
        id input=CSIndependentCopy(source); if (!input) return nil;
        if (context.messageType==3) { id imageInfo=CSMessageActionNativeObject(input,@"m_oImageInfo"); if (imageInfo) { id detached=CSIndependentCopy(imageInfo); if (!detached || !CSMessageNativeSet(input,@"setM_oImageInfo:",detached,YES)) return nil; } }
        wrap=CSMessageNativeInvoke(factory,selector,@[input]);
    }
    else wrap=CSIndependentCopy(source);
    if (!wrap || ![wrap isKindOfClass:NSClassFromString(@"CMessageWrap")] || wrap==source || !CSResetSendWrap(wrap,context,target)) return nil;
    if (context.messageType==47) {
        NSString *md5=CSMessageActionNativeObject(source,@"m_nsEmoticonMD5");
        NSString *content=CSMessageActionObjectGetter(source,NSSelectorFromString(@"m_nsContent"));
        if (md5.length!=32 && [content isKindOfClass:NSString.class]) { NSRegularExpression *regex=[NSRegularExpression regularExpressionWithPattern:@"[a-fA-F0-9]{32}" options:0 error:nil]; NSTextCheckingResult *match=[regex firstMatchInString:content options:0 range:NSMakeRange(0,content.length)]; if (match) md5=[content substringWithRange:match.range]; }
        if (md5.length==32) CSMessageNativeSet(wrap,@"setM_nsEmoticonMD5:",md5,NO);
        if (CSMessageNativeSupports(manager,@"AddEmoticonMsg:MsgWrap:",@"v",@[@"@",@"@"])) return CSVoidRoute(manager,@"AddEmoticonMsg:MsgWrap:",@[target,wrap],wrap);
        id emoticons=[_environment serviceNamed:@"CEmoticonMgr"], emoticon=nil;
        NSArray *lookups=@[@[@"getEmoticonWrapByMd5:",md5 ?: @""],@[@"getEmoticonWrapByMessageWrap:",source],@[@"getEmoticonWrapByContent:",content ?: @""]];
        for (NSArray *lookup in lookups) { if (CSMessageNativeSupports(emoticons,lookup[0],@"@",@[@"@"])) emoticon=CSMessageNativeInvoke(emoticons,lookup[0],@[lookup[1]]); if (emoticon) break; }
        if (emoticon && [target isEqualToString:context.sourceConversationID]) {
            if (CSMessageNativeSupports(logic,@"SendEmoticonMessage:",@"v",@[@"@"])) return CSVoidRoute(logic,@"SendEmoticonMessage:",@[emoticon],wrap);
            if (CSMessageNativeSupports(context.controller,@"SendEmoticonMesssageToolView:",@"v",@[@"@"])) return CSVoidRoute(context.controller,@"SendEmoticonMesssageToolView:",@[emoticon],wrap);
        }
    }
    if (context.messageType==49) return [self prepareApp:context wrap:wrap target:target manager:manager data:appData path:path];
    // Native AddMsg owns insertion and its send queue; never enqueue a zero-ID historical copy.
    if (CSMessageNativeSupports(manager,@"AddMsg:MsgWrap:",@"v",@[@"@",@"@"])) return CSVoidRoute(manager,@"AddMsg:MsgWrap:",@[target,wrap],wrap);
    return nil;
}
- (CSMessagePreparedSend *)prepareVideo:(CSMessageActionContext *)context target:(NSString *)target factory:(id)factory manager:(id)manager {
    if (!CSMessageNativeSupports(factory,@"GenForwardVideoFromMsgWrap:",@"@",@[@"@"])) return nil;
    id input=CSIndependentCopy(context.sourceWrap); if (!input) return nil;
    // Clear only a detached wrapper cache so the native factory creates independent video info.
    if (!CSMessageNativeSet(input,@"setM_dicForwardParas:",[NSMutableDictionary dictionary],YES)) return nil;
    id generated=CSMessageNativeInvoke(factory,@"GenForwardVideoFromMsgWrap:",@[input]);
    Class capture=NSClassFromString(@"CaptureVideoInfo");
    if (capture && [generated isKindOfClass:capture]) {
        // Factory may return a shared cached descriptor. Only mutate a detached descriptor.
        id video=generated;
        if (!CSMessageNativeSet(video,@"setM_bForward:",@YES,YES) || !CSMessageNativeSet(video,@"setM_nsSpecifiedChatName:",target,YES)) return nil;
        if (CSMessageNativeSupports(manager,@"AddVideoMsg:ToUsr:VideoInfo:MsgType:",@"@",@[@"@",@"@",@"@",@"I"])) return CSVoidRoute(manager,@"AddVideoMsg:ToUsr:VideoInfo:MsgType:",@[context.accountID,target,video,@43],nil);
        if (CSMessageNativeSupports(manager,@"AddVideoMsg:ToUsr:VideoInfo:",@"@",@[@"@",@"@",@"@"])) return CSVoidRoute(manager,@"AddVideoMsg:ToUsr:VideoInfo:",@[context.accountID,target,video],nil);
        if (CSMessageNativeSupports(manager,@"AddShortVideoMsg:ToUsr:VideoInfo:",@"@",@[@"@",@"@",@"@"])) return CSVoidRoute(manager,@"AddShortVideoMsg:ToUsr:VideoInfo:",@[context.accountID,target,video],nil);
        return nil;
    }
    id wrap=CSMessageActionObjectGetter(generated,NSSelectorFromString(@"msgWrap")) ?: generated;
    if (!wrap || wrap==context.sourceWrap || !CSResetSendWrap(wrap,context,target)) return nil;
    if (CSMessageNativeSupports(manager,@"AddMsg:MsgWrap:",@"v",@[@"@",@"@"])) return CSVoidRoute(manager,@"AddMsg:MsgWrap:",@[target,wrap],wrap);
    return nil;
}
- (CSMessagePreparedSend *)prepareApp:(CSMessageActionContext *)context wrap:(id)wrap target:(NSString *)target manager:(id)manager data:(NSData *)data path:(NSString *)path {
    Class cls=NSClassFromString(@"CMessageWrap");
    if (CSMessageNativeSupports(cls,@"IsRecordOrNoteMsg:",@"B",@[@"@"]) && [CSMessageNativeInvoke(cls,@"IsRecordOrNoteMsg:",@[context.sourceWrap]) boolValue]) {
        if (CSMessageNativeSupports(manager,@"AddRecordMsg:MsgWrap:",@"v",@[@"@",@"@"])) return CSVoidRoute(manager,@"AddRecordMsg:MsgWrap:",@[target,wrap],wrap);
        return nil;
    }
    if (CSMessageNativeSupports(context.sourceWrap,@"IsFileMsg",@"B",@[]) && [CSMessageNativeInvoke(context.sourceWrap,@"IsFileMsg",@[]) boolValue]) {
        if (path.length && CSMessageNativeSupports(manager,@"AddAppMsg:MsgWrap:DataPath:Scene:",@"v",@[@"@",@"@",@"@",@"I"])) return CSVoidRoute(manager,@"AddAppMsg:MsgWrap:DataPath:Scene:",@[target,wrap,path,@1],wrap);
        return nil;
    }
    unsigned long long declared=CSMessageNativeUnsigned(context.sourceWrap,@"m_uiAppDataSize");
    BOOL remote=CSMessageNativeUnsigned(context.sourceWrap,@"m_bAppAttachExistInSvr") || [CSMessageActionNativeObject(context.sourceWrap,@"m_nsAppAttachID") length];
    if (declared && !data.length && !remote) return nil;
    if (data && declared && declared!=data.length) return nil;
    if (CSMessageNativeSupports(manager,@"AddAppMsg:MsgWrap:Data:Scene:",@"v",@[@"@",@"@",@"@",@"I"])) return CSVoidRoute(manager,@"AddAppMsg:MsgWrap:Data:Scene:",@[target,wrap,data ?: NSNull.null,@1],wrap);
    return nil;
}
@end
