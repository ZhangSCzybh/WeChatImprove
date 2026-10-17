#import "CSMessageMediaProvider.h"
#import "CSMessageNativeActionAdapter.h"
#include <string.h>
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
@property(nonatomic) BOOL complete;
@property(nonatomic) BOOL terminalCompletion;
@property(nonatomic) BOOL formatKnown;
@property(nonatomic) BOOL cancelled;
@property(nonatomic) BOOL explicitNonterminal;
@property(nonatomic) unsigned int expectedBytes;
@property(nonatomic) BOOL reading;
@property(nonatomic) BOOL localComplete;
@property(nonatomic) BOOL recording;
@property(nonatomic) BOOL requestedDownload;
@end
@implementation CSVoicePreparation
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
static unsigned int CSVoiceXMLUInt(NSString *xml, NSString *attribute) {
    if (![xml isKindOfClass:NSString.class]) return 0;
    NSRegularExpression *expression=[NSRegularExpression regularExpressionWithPattern:[NSString stringWithFormat:@"\\b%@=[\"']([0-9]+)[\"']",attribute] options:0 error:nil];
    NSTextCheckingResult *match=[expression firstMatchInString:xml options:0 range:NSMakeRange(0,xml.length)];
    if (match.numberOfRanges<2) return 0;
    unsigned long long value=[[xml substringWithRange:[match rangeAtIndex:1]] longLongValue]; return value<=UINT_MAX ? (unsigned int)value : 0;
}
// Presence matters: historical XML can omit flags, while explicit zero endflag
// denies completeness until the correlated terminal native callback arrives.
static BOOL CSVoiceXMLFlag(NSString *xml, NSString *attribute, unsigned int *value) {
    if (![xml isKindOfClass:NSString.class]) return NO;
    NSTextCheckingResult *voice=[[NSRegularExpression regularExpressionWithPattern:@"<voicemsg\\b[^>]*>" options:0 error:nil] firstMatchInString:xml options:0 range:NSMakeRange(0,xml.length)];
    if (!voice) return NO;
    xml=[xml substringWithRange:voice.range];
    NSString *pattern=[NSString stringWithFormat:@"\\s%@\\s*=\\s*[\"']([0-9]+)[\"']",attribute];
    NSTextCheckingResult *match=[[NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil] firstMatchInString:xml options:0 range:NSMakeRange(0,xml.length)];
    if (match.numberOfRanges<2) return NO;
    NSString *number=[xml substringWithRange:[match rangeAtIndex:1]];
    *value=number.longLongValue>UINT_MAX ? UINT_MAX : number.intValue; return YES;
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
    if (!preparation.formatKnown && [xml isKindOfClass:NSString.class] && [xml rangeOfString:@"voiceformat="].location!=NSNotFound) { preparation.format=CSVoiceXMLUInt(xml,@"voiceformat"); preparation.formatKnown=YES; }
    preparation.expectedBytes=CSVoiceXMLUInt(xml,@"length");
    unsigned long long status=CSMessageNativeUnsigned(source,@"m_uiDownloadStatus");
    preparation.localComplete=(status & 1)!=0;
    preparation.recording=preparation.context.outgoing && !(status & 8);
    preparation.complete=preparation.terminalCompletion || preparation.localComplete;
    Class cls=NSClassFromString(@"CMessageWrap");
    if (CSMessageNativeSupports(source,@"getVoicePath",@"@",@[])) {
        id path=CSMessageActionNativeObject(source,@"getVoicePath"); if ([path isKindOfClass:NSString.class]) preparation.path=[path copy];
    } else if (CSMessageNativeSupports(cls,@"getPathOfAudio:",@"@",@[@"@"])) {
        @try { id path=CSMessageNativeInvoke(cls,@"getPathOfAudio:",@[source]); if ([path isKindOfClass:NSString.class]) preparation.path=[path copy]; } @catch (__unused NSException *exception) {}
    }
}
- (void)finish:(CSVoicePreparation *)preparation key:(NSString *)key resource:(CSMessageVoiceResource *)resource {
    if (_preparations[key]!=preparation) return;
    NSDictionary *subscribers=[preparation.subscribers copy]; [preparation.subscribers removeAllObjects]; preparation.bytes=nil; preparation.context=nil; [_preparations removeObjectForKey:key];
    for (void (^completion)(CSMessageVoiceResource *) in subscribers.allValues) completion(resource);
}
// Immutable-byte validation stays on the serial media queue. Header recognition follows
// native getVoiceFormat; a header alone is never evidence of a complete recording.
static CSMessageVoiceResource *CSValidatedVoice(NSData *data, unsigned int duration, unsigned int format, BOOL formatKnown, unsigned int expected) {
    if (!data.length || !duration || !formatKnown || (expected && expected!=data.length)) return nil;
    const unsigned char *bytes=data.bytes;
    if (format==UINT_MAX || format==4 || format==7) {
        if (data.length>=7 && memcmp(bytes+1,"#!SILK",6)==0) format=4;
        else if (data.length>=12 && memcmp(bytes,"#!OPUS_RAW_V1",12)==0) format=7;
        else return nil;
    }
    {
        unsigned long long measured=0; Class utility=NSClassFromString(@"AudioUtil");
        @try {
            if (format==4 && CSMessageNativeSupports(utility,@"calcSilkVoiceTime:",@"I",@[@"@"])) measured=[CSMessageNativeInvoke(utility,@"calcSilkVoiceTime:",@[data]) unsignedLongLongValue];
            else if (format==7 && CSMessageNativeSupports(NSClassFromString(@"OpusAudioPlayer"),@"calculateVoiceTime:",@"I",@[@"@"])) measured=[CSMessageNativeInvoke(NSClassFromString(@"OpusAudioPlayer"),@"calculateVoiceTime:",@[data]) unsignedLongLongValue];
            else if (CSMessageNativeSupports(utility,@"calcVoiceTime:VoiceFormat:",@"I",@[@"I",@"I"]) && data.length<=UINT_MAX) measured=[CSMessageNativeInvoke(utility,@"calcVoiceTime:VoiceFormat:",@[@(data.length),@(format)]) unsignedLongLongValue];
        } @catch (__unused NSException *exception) {}
        if (!measured || llabs((long long)measured-duration)>20) return nil;
    }
    return [[CSMessageVoiceResource alloc] initWithData:data durationMilliseconds:duration format:format];
}
- (void)read:(CSVoicePreparation *)preparation key:(NSString *)key {
    if (preparation.reading || !preparation.subscribers.count) return;
    [self snapshotFlags:preparation];
    if (preparation.cancelled || preparation.recording) { [self finish:preparation key:key resource:nil]; return; }
    if (!preparation.complete || (preparation.explicitNonterminal && !preparation.terminalCompletion)) { [self requestMissing:preparation key:key]; return; }
    preparation.reading=YES;
    NSData *snapshot=preparation.bytes; NSString *path=preparation.path;
    unsigned int duration=preparation.duration, format=preparation.format, expected=preparation.expectedBytes; BOOL known=preparation.formatKnown;
    NSData *(^reader)(NSString *)=_reader; __weak typeof(self) weakSelf=self;
    dispatch_async(_queue,^{
        @autoreleasepool {
            NSDictionary *before=path.length ? [NSFileManager.defaultManager attributesOfItemAtPath:path error:nil] : nil;
            NSData *data=snapshot.length ? snapshot : (path.length ? reader(path) : nil);
            NSDictionary *after=path.length ? [NSFileManager.defaultManager attributesOfItemAtPath:path error:nil] : nil;
            BOOL stable=snapshot.length || (before && after && [before[NSFileSize] isEqual:after[NSFileSize]] && [before[NSFileModificationDate] isEqual:after[NSFileModificationDate]] && [after[NSFileSize] unsignedLongLongValue]==data.length);
            CSMessageVoiceResource *resource=stable ? CSValidatedVoice(data,duration,format,known,expected) : nil;
            dispatch_async(dispatch_get_main_queue(),^{
                typeof(self) self=weakSelf; if (!self || self.preparations[key]!=preparation) return;
                preparation.reading=NO; [self snapshotFlags:preparation];
                if (preparation.cancelled || (preparation.explicitNonterminal && !preparation.terminalCompletion)) { [self finish:preparation key:key resource:nil]; return; }
                // A completed local source cannot be repaired through downloadMsg:, whose
                // CGI path can remove an existing source file. Invalid bytes fail closed.
                [self finish:preparation key:key resource:resource];
            });
        }
    });
}
- (void)requestMissing:(CSVoicePreparation *)preparation key:(NSString *)key {
    if (preparation.localComplete || preparation.recording || preparation.context.outgoing || !preparation.context.serverID || !preparation.expectedBytes) { [self finish:preparation key:key resource:nil]; return; }
    if (preparation.requestedDownload) return;
    preparation.requestedDownload=YES;
    if (_waitingHandler) for (NSString *operationID in preparation.subscribers.allKeys) _waitingHandler(operationID);
    if (!_requestDownload || !_requestDownload(preparation.context)) [self finish:preparation key:key resource:nil];
}
- (void)prepareVoiceForContext:(CSMessageActionContext *)context operationID:(NSString *)operationID completion:(void (^)(CSMessageVoiceResource *))completion {
    NSAssert(NSThread.isMainThread,@"Media metadata is main-thread owned");
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
    NSAssert(NSThread.isMainThread,@"App metadata is main-thread owned");
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
- (void)cancelOperationID:(NSString *)operationID {
    [_appSubscribers removeObject:operationID];
    for (NSString *key in _preparations.allKeys) { CSVoicePreparation *preparation=_preparations[key]; [preparation.subscribers removeObjectForKey:operationID]; if (!preparation.subscribers.count) { preparation.context=nil; preparation.bytes=nil; [_preparations removeObjectForKey:key]; } }
}
- (void)downloadCompletedForAccount:(NSString *)account epoch:(NSUInteger)epoch chat:(NSString *)chat localID:(unsigned int)localID serverID:(long long)serverID {
    for (NSString *key in _preparations.allKeys) {
        CSVoicePreparation *preparation=_preparations[key]; CSMessageActionContext *context=preparation.context;
        if (![context isValidForAccountID:account epoch:epoch] || ![context.sourceConversationID isEqualToString:chat] || !localID || context.localID!=localID || (context.serverID && serverID && context.serverID!=(unsigned long long)serverID)) continue;
        id refreshed=_refreshSource ? _refreshSource(context) : nil;
        if (refreshed) {
            BOOL matches=[refreshed isKindOfClass:NSClassFromString(@"CMessageWrap")] && CSMessageNativeUnsigned(refreshed,@"m_uiMessageType")==34 &&
                CSMessageNativeUnsigned(refreshed,@"m_uiMesLocalID")==context.localID &&
                (!context.serverID || CSMessageNativeUnsigned(refreshed,@"m_n64MesSvrID")==context.serverID) &&
                [CSMessageActionObjectGetter(refreshed,NSSelectorFromString(@"m_nsFromUsr")) isEqual:CSMessageActionObjectGetter(context.sourceWrap,NSSelectorFromString(@"m_nsFromUsr"))] &&
                [CSMessageActionObjectGetter(refreshed,NSSelectorFromString(@"m_nsToUsr")) isEqual:CSMessageActionObjectGetter(context.sourceWrap,NSSelectorFromString(@"m_nsToUsr"))];
            if (!matches) { [self finish:preparation key:key resource:nil]; continue; }
            preparation.refreshedSource=refreshed;
        }
        preparation.complete=YES; preparation.terminalCompletion=YES; [self snapshot:preparation]; [self read:preparation key:key];
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
