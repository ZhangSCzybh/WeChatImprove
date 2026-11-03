#import "CSMessageMediaProvider.h"
#import "CSMessageNativeActionAdapter.h"
#include <string.h>
#include <stdatomic.h>
static atomic_uint CSPendingVoiceDownloads;
BOOL CSMessageHasPendingVoiceDownloads(void) { return atomic_load(&CSPendingVoiceDownloads)>0; }
@implementation CSMessageVoiceResource
- (instancetype)initWithData:(NSData *)data durationMilliseconds:(unsigned int)duration format:(unsigned int)format { if ((self=[super init])) { _data=[data copy]; _durationMilliseconds=duration; _format=format; } return self; }
@end
@interface CSVoicePreparation : NSObject
@property(nonatomic, strong) CSMessageActionContext *context;
@property(nonatomic, strong) NSMutableDictionary<NSString *, id> *subscribers;
@property(nonatomic, copy) NSString *path;
@property(nonatomic, copy) NSData *bytes;
@property(nonatomic, strong) id refreshedSource;
@property(nonatomic) unsigned int duration;
@property(nonatomic) unsigned int format;
@property(nonatomic) BOOL terminalCompletion;
@property(nonatomic) BOOL formatKnown;
@property(nonatomic) BOOL cancelled;
@property(nonatomic) BOOL explicitNonterminal;
@property(nonatomic) unsigned int expectedBytes;
@property(nonatomic) BOOL reading;
@property(nonatomic) BOOL localComplete;
@property(nonatomic) BOOL recording;
@property(nonatomic) BOOL requestedDownload;
@property(nonatomic) BOOL sourceReloaded;
@property(nonatomic) BOOL localReadAttempted;
@property(nonatomic) BOOL readRetryUsed;
@property(nonatomic) BOOL retryScheduled;
@property(nonatomic, copy) NSString *failureHint;
@end
@implementation CSVoicePreparation
- (void)dealloc { if (_requestedDownload) atomic_fetch_sub(&CSPendingVoiceDownloads,1); }
@end
@interface CSMessageMediaProvider ()
@property(nonatomic, strong) NSMutableDictionary<NSString *, CSVoicePreparation *> *preparations;
@property(nonatomic, strong) dispatch_queue_t queue;
@property(nonatomic, strong) NSMutableSet<NSString *> *appSubscribers;
@property(nonatomic, copy) NSData *(^reader)(NSString *);
@end
@implementation CSMessageMediaProvider
- (instancetype)init { return [self initWithReader:^NSData *(NSString *path){ return [NSData dataWithContentsOfFile:path options:NSDataReadingMappedIfSafe error:nil]; }]; }
- (instancetype)initWithReader:(NSData *(^)(NSString *))reader { if ((self=[super init])) { _reader=[reader copy]; _preparations=[NSMutableDictionary dictionary]; _appSubscribers=[NSMutableSet set]; _queue=dispatch_queue_create("com.wechat.enhance.message-media",DISPATCH_QUEUE_SERIAL); } return self; }
- (void)readImageForContext:(CSMessageActionContext *)context completion:(void (^)(NSData *))completion {
    if (!NSThread.isMainThread || context.messageType!=3) { completion(nil); return; }
    NSMutableArray<NSString *> *paths=[NSMutableArray array]; Class cls=NSClassFromString(@"CMessageWrap");
    // Native path getters run on main. Only immutable paths/bytes cross to IO; never read a cell thumbnail.
    @try {
        for (NSString *selector in @[@"getJpgPathOfMsgHdOrMiddleImg:",@"getPathOfHdOrMiddleImgForSender:",@"getPathOfRawMiddleImage:",@"getJpgPathOfMsgMiddleImg:"]) {
            if ([selector isEqual:@"getPathOfHdOrMiddleImgForSender:"] && !context.outgoing) continue;
            if (!CSMessageNativeSupports(cls,selector,@"@",@[@"@"])) continue;
            id path=CSMessageNativeInvoke(cls,selector,@[context.sourceWrap]);
            if ([path isKindOfClass:NSString.class] && [path isAbsolutePath] && ![paths containsObject:path]) [paths addObject:[path copy]];
        }
    } @catch (__unused NSException *exception) {}
    NSArray *snapshot=[paths copy];
    dispatch_async(_queue,^{
        NSData *data=nil;
        for (NSString *path in snapshot) {
            NSDictionary *attrs=[NSFileManager.defaultManager attributesOfItemAtPath:path error:NULL];
            if (![attrs[NSFileType] isEqual:NSFileTypeRegular] || [attrs fileSize]>32*1024*1024) continue;
            data=self.reader(path); if (data.length && data.length<=32*1024*1024) break; data=nil;
        }
        dispatch_async(dispatch_get_main_queue(),^{ completion(data); });
    });
}
// Presence matters: historical XML can omit flags, while explicit zero endflag
// denies completeness until the correlated terminal native callback arrives.
static BOOL CSVoiceXMLFlag(NSString *xml, NSString *attribute, unsigned int *value) {
    if (![xml isKindOfClass:NSString.class]) return NO;
    NSTextCheckingResult *voice=[[NSRegularExpression regularExpressionWithPattern:@"<voicemsg\\b[^>]*>" options:0 error:nil] firstMatchInString:xml options:0 range:NSMakeRange(0,xml.length)];
    if (!voice) return NO;
    xml=[xml substringWithRange:voice.range];
    NSString *pattern=[NSString stringWithFormat:@"\\s%@\\s*=\\s*([\"'])([0-9]+)\\1",attribute];
    NSTextCheckingResult *match=[[NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil] firstMatchInString:xml options:0 range:NSMakeRange(0,xml.length)];
    if (match.numberOfRanges<3) return NO;
    NSString *number=[xml substringWithRange:[match rangeAtIndex:2]];
    *value=number.longLongValue>UINT_MAX ? UINT_MAX : number.intValue; return YES;
}
static unsigned int CSVoiceXMLUInt(NSString *xml, NSString *attribute) {
    // Group sender prefixes and unrelated XML nodes are not voice metadata.
    unsigned int value=0; CSVoiceXMLFlag(xml,attribute,&value); return value;
}
- (void)snapshotFlags:(CSVoicePreparation *)preparation {
    NSString *xml=CSMessageActionObjectGetter(preparation.refreshedSource ?: preparation.context.sourceWrap,NSSelectorFromString(@"m_nsContent"));
    unsigned int originalCancel=0;
    NSString *originalXML=CSMessageActionObjectGetter(preparation.context.sourceWrap,NSSelectorFromString(@"m_nsContent"));
    preparation.cancelled=preparation.cancelled || (CSVoiceXMLFlag(originalXML,@"cancelflag",&originalCancel) && originalCancel!=0) ||
        CSMessageNativeUnsigned(preparation.context.sourceWrap,@"m_uiVoiceCancelFlag")!=0 ||
        CSMessageNativeUnsigned(preparation.refreshedSource,@"m_uiVoiceCancelFlag")!=0;
    unsigned int cancel=0,end=0;
    // Cancellation is sticky for this preparation, including later terminal callbacks.
    preparation.cancelled=preparation.cancelled || (CSVoiceXMLFlag(xml,@"cancelflag",&cancel) && cancel!=0);
    preparation.explicitNonterminal=CSVoiceXMLFlag(xml,@"endflag",&end) && end!=1;
}
- (NSString *)keyForContext:(CSMessageActionContext *)context { return [NSString stringWithFormat:@"%lu|%@",(unsigned long)context.accountEpoch,context.stableMessageIdentity]; }
- (void)snapshot:(CSVoicePreparation *)preparation {
    [self snapshotFlags:preparation];
    id source=preparation.refreshedSource ?: preparation.context.sourceWrap;
    preparation.bytes=CSMessageActionNativeObject(source,@"m_dtVoice");
    if (![preparation.bytes isKindOfClass:NSData.class]) preparation.bytes=nil;
    NSString *xml=CSMessageActionObjectGetter(source,NSSelectorFromString(@"m_nsContent"));
    preparation.duration=(unsigned int)CSMessageNativeUnsigned(source,@"m_uiVoiceTime");
    if (!preparation.duration) preparation.duration=CSVoiceXMLUInt(xml,@"voicelength");
    preparation.formatKnown=CSMessageNativeSupports(source,@"m_uiVoiceFormat",@"I",@[]) || CSMessageNativeSupports(source,@"m_uiVoiceFormat",@"i",@[]);
    preparation.format=(unsigned int)CSMessageNativeUnsigned(source,@"m_uiVoiceFormat");
    if (!preparation.formatKnown) { unsigned int format=0; preparation.formatKnown=CSVoiceXMLFlag(xml,@"voiceformat",&format); preparation.format=format; }
    preparation.expectedBytes=CSVoiceXMLUInt(xml,@"length");
    unsigned long long status=CSMessageNativeUnsigned(source,@"m_uiDownloadStatus");
    preparation.localComplete=(status & 1)!=0;
    preparation.recording=preparation.context.outgoing && !(status & 8);
    // Persisted, playable voices can have status 17 and no recording-end bit.
    // Query the active native recorder before treating that missing bit as recording.
    if (preparation.recording && preparation.localComplete && _recordingState) {
        NSNumber *active=_recordingState(preparation.context);
        if (active) preparation.recording=active.boolValue;
    }
    preparation.path=nil;
    Class cls=NSClassFromString(@"CMessageWrap");
    if (CSMessageNativeSupports(source,@"getVoicePath",@"@",@[])) {
        id path=CSMessageActionNativeObject(source,@"getVoicePath"); if ([path isKindOfClass:NSString.class]) preparation.path=[path copy];
    } else if (CSMessageNativeSupports(cls,@"getPathOfAudio:",@"@",@[@"@"])) {
        @try { id path=CSMessageNativeInvoke(cls,@"getPathOfAudio:",@[source]); if ([path isKindOfClass:NSString.class]) preparation.path=[path copy]; } @catch (__unused NSException *exception) {}
    }
}
- (void)finish:(CSVoicePreparation *)preparation key:(NSString *)key resource:(CSMessageVoiceResource *)resource {
    if (_preparations[key]!=preparation) return;
    if (preparation.requestedDownload) { preparation.requestedDownload=NO; atomic_fetch_sub(&CSPendingVoiceDownloads,1); }
    NSDictionary *subscribers=[preparation.subscribers copy]; [preparation.subscribers removeAllObjects]; preparation.bytes=nil; preparation.context=nil; [_preparations removeObjectForKey:key];
    for (NSString *identifier in subscribers) {
        if (!resource && preparation.failureHint.length && _failureHandler) _failureHandler(identifier,preparation.failureHint);
        void (^completion)(CSMessageVoiceResource *)=subscribers[identifier]; completion(resource);
    }
}
static BOOL CSVoiceSourceMatches(id source, CSMessageActionContext *context) {
    return [source isKindOfClass:NSClassFromString(@"CMessageWrap")] && CSMessageNativeUnsigned(source,@"m_uiMessageType")==34 &&
        CSMessageNativeUnsigned(source,@"m_uiMesLocalID")==context.localID &&
        (!context.serverID || CSMessageNativeUnsigned(source,@"m_n64MesSvrID")==context.serverID) &&
        [CSMessageActionObjectGetter(source,NSSelectorFromString(@"m_nsFromUsr")) isEqual:context.outgoing ? context.accountID : context.sourceConversationID] &&
        [CSMessageActionObjectGetter(source,NSSelectorFromString(@"m_nsToUsr")) isEqual:context.outgoing ? context.sourceConversationID : context.accountID];
}
- (BOOL)reloadSource:(CSVoicePreparation *)preparation key:(NSString *)key {
    preparation.sourceReloaded=YES;
    CSMessageActionContext *context=preparation.context;
    id refreshed=_refreshSource && context.localID ? _refreshSource(context) : nil;
    // Service lookup can cross an account boundary and synchronously cancel us.
    if (_preparations[key]!=preparation) return NO;
    if (refreshed && !CSVoiceSourceMatches(refreshed,context)) { preparation.failureHint=@"原语音记录已变化，请重新打开会话"; [self finish:preparation key:key resource:nil]; return NO; }
    if (refreshed) preparation.refreshedSource=refreshed;
    [self snapshot:preparation];
    return YES;
}
- (BOOL)retryLocalRead:(CSVoicePreparation *)preparation key:(NSString *)key {
    if (preparation.readRetryUsed) return NO;
    preparation.readRetryUsed=YES; preparation.retryScheduled=YES;
    __weak typeof(self) weakSelf=self; __weak CSVoicePreparation *weakPreparation=preparation;
    // One bounded preparation retry, never an upload retry or a polling timer.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,200*NSEC_PER_MSEC),dispatch_get_main_queue(),^{
        typeof(self) self=weakSelf; CSVoicePreparation *live=weakPreparation;
        if (!self || !live || self.preparations[key]!=live) return;
        live.retryScheduled=NO;
        if (!live.sourceReloaded) { if (![self reloadSource:live key:key]) return; }
        else [self snapshot:live];
        [self read:live key:key];
    });
    return YES;
}
// Immutable-byte validation stays on the serial media queue. Header recognition follows
// native getVoiceFormat; a header alone is never evidence of a complete recording.
static CSMessageVoiceResource *CSValidatedVoice(NSData *data, unsigned int duration, unsigned int format, BOOL formatKnown, unsigned int expected, NSString **failureHint) {
    if (!data.length) { *failureHint=@"原语音文件未就绪，请先播放后重试"; return nil; }
    if (!duration || !formatKnown) { *failureHint=@"原语音信息不完整"; return nil; }
    if (expected && expected!=data.length) { *failureHint=@"原语音数据不完整"; return nil; }
    const unsigned char *bytes=data.bytes;
    if (format==UINT_MAX || format==4 || format==7) {
        if (data.length>=7 && memcmp(bytes+1,"#!SILK",6)==0) format=4;
        else if (data.length>=12 && memcmp(bytes,"#!OPUS_RAW_V1",12)==0) format=7;
        else { *failureHint=@"无法识别原语音格式"; return nil; }
    }
    {
        unsigned long long measured=0; BOOL decodedBytes=NO; Class utility=NSClassFromString(@"AudioUtil");
        @try {
            if (format==4 && CSMessageNativeSupports(utility,@"calcSilkVoiceTime:",@"I",@[@"@"])) { decodedBytes=YES; measured=[CSMessageNativeInvoke(utility,@"calcSilkVoiceTime:",@[data]) unsignedLongLongValue]; }
            else if (format==7 && CSMessageNativeSupports(NSClassFromString(@"OpusAudioPlayer"),@"calculateVoiceTime:",@"I",@[@"@"])) { decodedBytes=YES; measured=[CSMessageNativeInvoke(NSClassFromString(@"OpusAudioPlayer"),@"calculateVoiceTime:",@[data]) unsignedLongLongValue]; }
            else if (CSMessageNativeSupports(utility,@"calcVoiceTime:VoiceFormat:",@"I",@[@"I",@"I"]) && data.length<=UINT_MAX) measured=[CSMessageNativeInvoke(utility,@"calcVoiceTime:VoiceFormat:",@[@(data.length),@(format)]) unsignedLongLongValue];
        } @catch (__unused NSException *exception) {}
        if (!measured || measured>UINT_MAX) { *failureHint=@"无法读取原语音时长"; return nil; }
        if (llabs((long long)measured-duration)>20) {
            // Network XML byte count + completed/nonrecording state + native byte
            // decoding establish this complete resource independently of display
            // duration. Normalize only the fresh send; never mutate source metadata.
            // Without declared bytes, retain duration agreement as the truncation guard.
            if (!expected || !decodedBytes) { *failureHint=@"原语音标注时长与音频不一致"; return nil; }
            duration=(unsigned int)measured;
        }
    }
    return [[CSMessageVoiceResource alloc] initWithData:data durationMilliseconds:duration format:format];
}
- (void)read:(CSVoicePreparation *)preparation key:(NSString *)key {
    if (preparation.reading || preparation.retryScheduled || !preparation.subscribers.count) return;
    [self snapshotFlags:preparation];
    if (preparation.cancelled) { [self finish:preparation key:key resource:nil]; return; }
    // A first cell may keep stale status/extension fields across every user retry.
    // Re-fetch the exact persisted message before refusing it or starting download.
    if (!preparation.sourceReloaded && (preparation.recording || !(preparation.terminalCompletion || preparation.localComplete) ||
        (preparation.explicitNonterminal && !preparation.terminalCompletion))) {
        if (![self reloadSource:preparation key:key]) return;
    }
    if (preparation.cancelled || preparation.recording) { [self finish:preparation key:key resource:nil]; return; }
    if (!(preparation.terminalCompletion || preparation.localComplete) || (preparation.explicitNonterminal && !preparation.terminalCompletion)) { [self requestMissing:preparation key:key]; return; }
    preparation.reading=YES; preparation.localReadAttempted=YES;
    NSData *snapshot=preparation.bytes; NSString *path=preparation.path;
    unsigned int duration=preparation.duration, format=preparation.format, expected=preparation.expectedBytes; BOOL known=preparation.formatKnown;
    NSData *(^reader)(NSString *)=_reader; __weak typeof(self) weakSelf=self;
    dispatch_async(_queue,^{
        @autoreleasepool {
            NSString *failureHint=nil;
            CSMessageVoiceResource *resource=CSValidatedVoice(snapshot,duration,format,known,expected,&failureHint);
            if (!resource && path.length) {
                // A UI wrapper can retain only a cached chunk. Try its native file
                // once, on this queue, with the same completeness/codec checks.
                NSDictionary *before=[NSFileManager.defaultManager attributesOfItemAtPath:path error:nil];
                NSData *data=reader(path);
                NSDictionary *after=[NSFileManager.defaultManager attributesOfItemAtPath:path error:nil];
                BOOL stable=before && after && [before[NSFileSize] isEqual:after[NSFileSize]] && [before[NSFileModificationDate] isEqual:after[NSFileModificationDate]] && [after[NSFileSize] unsignedLongLongValue]==data.length;
                if (stable) resource=CSValidatedVoice(data,duration,format,known,expected,&failureHint);
                else if (data.length) failureHint=@"原语音文件仍在更新，请稍后重试";
            }
            dispatch_async(dispatch_get_main_queue(),^{
                typeof(self) self=weakSelf; if (!self || self.preparations[key]!=preparation) return;
                preparation.reading=NO; [self snapshotFlags:preparation];
                if (preparation.cancelled || (preparation.explicitNonterminal && !preparation.terminalCompletion)) { [self finish:preparation key:key resource:nil]; return; }
                preparation.failureHint=failureHint;
                if (!resource && [self retryLocalRead:preparation key:key]) return;
                // A completed local source cannot be repaired through downloadMsg:, whose
                // CGI path can remove an existing source file. Invalid bytes fail closed.
                [self finish:preparation key:key resource:resource];
            });
        }
    });
}
- (void)requestMissing:(CSVoicePreparation *)preparation key:(NSString *)key {
    if (preparation.localComplete || preparation.localReadAttempted || preparation.recording || preparation.context.outgoing || !preparation.context.serverID || !preparation.expectedBytes) { preparation.failureHint=@"原语音尚未准备完整，请先播放后重试"; [self finish:preparation key:key resource:nil]; return; }
    if (preparation.requestedDownload) return;
    preparation.requestedDownload=YES; atomic_fetch_add(&CSPendingVoiceDownloads,1);
    if (_waitingHandler) for (NSString *operationID in preparation.subscribers.allKeys) _waitingHandler(operationID);
    if (!_requestDownload || !_requestDownload(preparation.context)) [self finish:preparation key:key resource:nil];
}
- (void)prepareVoiceForContext:(CSMessageActionContext *)context operationID:(NSString *)operationID completion:(void (^)(CSMessageVoiceResource *))completion {
    NSString *key=[self keyForContext:context]; CSVoicePreparation *preparation=_preparations[key];
    if (!preparation) {
        // Bound source metadata, not bytes. Refuse new operations visibly through completion.
        if (_preparations.count>=32) { completion(nil); return; }
        preparation=[CSVoicePreparation new]; preparation.context=context; preparation.subscribers=[NSMutableDictionary dictionary]; _preparations[key]=preparation;
        [self snapshot:preparation];
        __weak typeof(self) weakSelf=self;
        __weak CSVoicePreparation *weakPreparation=preparation;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,60*NSEC_PER_SEC),dispatch_get_main_queue(),^{ CSVoicePreparation *live=weakPreparation; if (live) [weakSelf finish:live key:key resource:nil]; });
    }
    if (preparation.subscribers.count>=64 && !preparation.subscribers[operationID]) { completion(nil); return; }
    preparation.subscribers[operationID]=[completion copy]; if (preparation.requestedDownload && _waitingHandler) _waitingHandler(operationID); [self read:preparation key:key];
}
- (void)prepareAppDataForContext:(CSMessageActionContext *)context operationID:(NSString *)operationID completion:(void (^)(NSData *, NSString *))completion {
    if (_appSubscribers.count>=32) { completion(nil,nil); return; }
    NSString *path=CSMessageNativeAppDataPath(context);
    BOOL file=NO;
    @try { if (CSMessageNativeSupports(context.sourceWrap,@"IsFileMsg",@"B",@[])) file=[CSMessageNativeInvoke(context.sourceWrap,@"IsFileMsg",@[]) boolValue]; } @catch (__unused NSException *exception) { completion(nil,nil); return; }
    [_appSubscribers addObject:operationID]; __weak typeof(self) weakSelf=self; NSData *(^reader)(NSString *)=_reader;
    dispatch_async(_queue,^{
        BOOL exists=path.length && [NSFileManager.defaultManager isReadableFileAtPath:path];
        NSData *data=!file && exists ? reader(path) : nil;
        dispatch_async(dispatch_get_main_queue(),^{ typeof(self) self=weakSelf; if (![self.appSubscribers containsObject:operationID]) return; [self.appSubscribers removeObject:operationID]; completion(data,exists ? path : nil); });
    });
}
- (BOOL)hasPendingVoiceForChat:(NSString *)chat localID:(unsigned int)localID serverID:(long long)serverID {
    if (!localID || ![chat isKindOfClass:NSString.class]) return NO;
    for (CSVoicePreparation *preparation in _preparations.allValues) {
        CSMessageActionContext *context=preparation.context;
        if (preparation.requestedDownload && [context.sourceConversationID isEqual:chat] && context.localID==localID &&
            (!context.serverID || !serverID || context.serverID==(unsigned long long)serverID)) return YES;
    }
    return NO;
}
- (void)cancelOperationID:(NSString *)operationID {
    [_appSubscribers removeObject:operationID];
    for (NSString *key in _preparations.allKeys) { CSVoicePreparation *preparation=_preparations[key]; [preparation.subscribers removeObjectForKey:operationID]; if (!preparation.subscribers.count) { if (preparation.requestedDownload) { preparation.requestedDownload=NO; atomic_fetch_sub(&CSPendingVoiceDownloads,1); } preparation.context=nil; preparation.bytes=nil; [_preparations removeObjectForKey:key]; } }
}
- (void)downloadCompletedForAccount:(NSString *)account epoch:(NSUInteger)epoch chat:(NSString *)chat localID:(unsigned int)localID serverID:(long long)serverID {
    for (NSString *key in _preparations.allKeys) {
        CSVoicePreparation *preparation=_preparations[key]; CSMessageActionContext *context=preparation.context;
        if (![context isValidForAccountID:account epoch:epoch] || ![context.sourceConversationID isEqualToString:chat] || !localID || context.localID!=localID || (context.serverID && serverID && context.serverID!=(unsigned long long)serverID)) continue;
        preparation.terminalCompletion=YES;
        if ([self reloadSource:preparation key:key]) [self read:preparation key:key];
    }
}
- (void)downloadFailedForAccount:(NSString *)account epoch:(NSUInteger)epoch chat:(NSString *)chat localID:(unsigned int)localID serverID:(long long)serverID {
    for (NSString *key in _preparations.allKeys) {
        CSVoicePreparation *preparation=_preparations[key]; CSMessageActionContext *context=preparation.context;
        if (![context isValidForAccountID:account epoch:epoch] || ![context.sourceConversationID isEqualToString:chat] || !localID || context.localID!=localID || (context.serverID && serverID && context.serverID!=(unsigned long long)serverID)) continue;
        [self finish:preparation key:key resource:nil];
    }
}
@end
