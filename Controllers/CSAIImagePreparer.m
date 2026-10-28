#import "CSAIImagePreparer.h"
#import "CSMessageNativeActionAdapter.h"
#import <ImageIO/ImageIO.h>
#import <CoreGraphics/CoreGraphics.h>
#import <objc/runtime.h>
#import <stdatomic.h>
#import <sys/stat.h>
#import <fcntl.h>
#import <unistd.h>
#import <errno.h>
#import <math.h>
#import <string.h>

static const NSUInteger CSAIImageInputLimit=32*1024*1024,CSAIImageOutputLimit=2*1024*1024;
static NSError *CSAIImageError(NSInteger code) {
    return [NSError errorWithDomain:@"CSAIImagePreparation" code:code userInfo:@{NSLocalizedDescriptionKey:@"图片准备失败，请稍后重试。"}];
}
static BOOL CSAIImageDataURL(NSString *url) {
    if(![url isKindOfClass:NSString.class] || url.length>((CSAIImageOutputLimit+2)/3)*4+32)return NO;
    NSString *prefix=[url hasPrefix:@"data:image/jpeg;base64,"]?@"data:image/jpeg;base64,":([url hasPrefix:@"data:image/png;base64,"]?@"data:image/png;base64,":nil);
    if(!prefix)return NO;
    NSData *bytes=[[NSData alloc]initWithBase64EncodedString:[url substringFromIndex:prefix.length] options:0];
    return bytes.length && bytes.length<=CSAIImageOutputLimit;
}
static NSString *CSAIImageString(id source,NSString *selector) {
    id value=CSMessageActionNativeObject(source,selector);return [value isKindOfClass:NSString.class]?value:nil;
}
static BOOL CSAIImageMatches(id source,NSDictionary *event) {
    if(!NSThread.isMainThread || !source || ![source isKindOfClass:NSClassFromString(@"CMessageWrap")])return NO;
    @try {
        NSString *account=event[@"account"],*chat=event[@"conversation"],*sender=event[@"sender"];
        if(CSMessageNativeUnsigned(source,@"m_uiMessageType")!=3 || ![CSAIImageString(source,@"m_nsFromUsr") isEqual:chat] ||
           ![CSAIImageString(source,@"m_nsToUsr") isEqual:account] || CSMessageNativeUnsigned(source,@"m_uiCreateTime")!=[event[@"created"] unsignedLongLongValue])return NO;
        NSString *nativeSender=[chat hasSuffix:@"@chatroom"]?CSAIImageString(source,@"m_nsRealChatUsr"):chat;
        if(![nativeSender isEqual:sender])return NO;
        unsigned long long local=CSMessageNativeUnsigned(source,@"m_uiMesLocalID"),server=CSMessageNativeUnsigned(source,@"m_n64MesSvrID");
        unsigned long long expectedLocal=[event[@"imageLocalID"] unsignedLongLongValue],expectedServer=[event[@"imageServerID"] unsignedLongLongValue];
        if((local && expectedLocal && local!=expectedLocal) || (server && expectedServer && server!=expectedServer))return NO;
        return (local && local==expectedLocal) || (server && server==expectedServer);
    } @catch(__unused NSException *exception) {return NO;}
}
static BOOL CSAIImageSourceIdentity(NSDictionary *event,id source) {
    NSString *account=event[@"account"],*chat=event[@"conversation"],*sender=event[@"sender"];
    if(![account isKindOfClass:NSString.class] || !account.length || ![chat isKindOfClass:NSString.class] || !chat.length || ![sender isKindOfClass:NSString.class] || !sender.length || [sender isEqual:account] || [chat isEqual:account] ||
       ![event[@"type"] isKindOfClass:NSNumber.class] || [event[@"type"] integerValue]!=3 || ![event[@"created"] isKindOfClass:NSNumber.class] || ![event[@"created"] unsignedLongLongValue] ||
       ![event[@"identifiers"] isKindOfClass:NSArray.class] || ![event[@"identifiers"] count] || [event[@"identifiers"] count]>10)return NO;
    unsigned long long local=[event[@"imageLocalID"] unsignedLongLongValue],server=[event[@"imageServerID"] unsignedLongLongValue];
    NSString *localIdentity=[NSString stringWithFormat:@"%@|%@|l:%llu:%llu",account,chat,local,[event[@"created"] unsignedLongLongValue]];
    NSString *serverIdentity=[NSString stringWithFormat:@"%@|%@|s:%llu",account,chat,server];
    if(!(local && [event[@"identifiers"] containsObject:localIdentity]) && !(server && [event[@"identifiers"] containsObject:serverIdentity]))return NO;
    return CSAIImageMatches(event[@"imageSource"],event) && CSAIImageMatches(source,event);
}
static NSArray<NSString *> *CSAIImagePaths(id source) {
    NSCAssert(NSThread.isMainThread,@"Image native snapshots are main-thread owned");
    NSMutableArray *paths=[NSMutableArray array];Class cls=NSClassFromString(@"CMessageWrap");
    @try {
        for(NSString *selector in @[@"getJpgPathOfMsgHdOrMiddleImg:",@"getPathOfRawMiddleImage:",@"getJpgPathOfMsgMiddleImg:"]){
            if(!CSMessageNativeSupports(cls,selector,@"@",@[@"@"]))continue;
            id path=CSMessageNativeInvoke(cls,selector,@[source]);
            if([path isKindOfClass:NSString.class] && [path isAbsolutePath] && ![paths containsObject:path])[paths addObject:[path copy]];
        }
    } @catch(__unused NSException *exception) {}
    return [paths copy];
}
static NSData *CSAIReadImage(NSString *path,BOOL (^cancelled)(void)) {
    if(cancelled() || ![path isAbsolutePath])return nil;
    int file=open(path.fileSystemRepresentation,O_RDONLY|O_NOFOLLOW|O_NONBLOCK);if(file<0)return nil;
    struct stat info;NSMutableData *data=nil;
    if(!fstat(file,&info) && S_ISREG(info.st_mode) && info.st_size>0 && (unsigned long long)info.st_size<=CSAIImageInputLimit){
        data=[NSMutableData dataWithLength:(NSUInteger)info.st_size];NSUInteger offset=0;
        while(offset<data.length && !cancelled()){
            ssize_t count=read(file,(uint8_t *)data.mutableBytes+offset,MIN((NSUInteger)65536,data.length-offset));
            if(count<0 && errno==EINTR)continue;
            if(count<=0)break;offset+=(NSUInteger)count;
        }
        uint8_t extra;ssize_t tail=offset==data.length && !cancelled()?read(file,&extra,1):-1;
        if(offset!=data.length || tail!=0 || cancelled())data=nil;
    }
    close(file);return data;
}
static CGImageRef CSAIImageScaled(CGImageRef image,size_t limit) CF_RETURNS_RETAINED {
    size_t width=CGImageGetWidth(image),height=CGImageGetHeight(image);
    if(MAX(width,height)<=limit)return CGImageRetain(image);
    double scale=(double)limit/(double)MAX(width,height);width=MAX((size_t)1,(size_t)floor(width*scale));height=MAX((size_t)1,(size_t)floor(height*scale));
    CGColorSpaceRef space=CGColorSpaceCreateDeviceRGB();
    CGContextRef context=CGBitmapContextCreate(NULL,width,height,8,width*4,space,kCGImageAlphaPremultipliedLast|kCGBitmapByteOrder32Big);CGColorSpaceRelease(space);
    if(!context)return NULL;
    CGContextSetInterpolationQuality(context,kCGInterpolationHigh);CGContextDrawImage(context,CGRectMake(0,0,width,height),image);
    CGImageRef resized=CGBitmapContextCreateImage(context);CGContextRelease(context);return resized;
}
static NSString *CSAIEncodeImage(NSData *data,BOOL (^cancelled)(void),NSError **error) {
    if(cancelled())return nil;
    if(!data.length || data.length>CSAIImageInputLimit){if(error)*error=CSAIImageError(6);return nil;}
    CGImageSourceRef source=CGImageSourceCreateWithData((__bridge CFDataRef)data,(__bridge CFDictionaryRef)@{(__bridge NSString *)kCGImageSourceShouldCache:@NO});
    if(!source){if(error)*error=CSAIImageError(7);return nil;}
    NSDictionary *properties=CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(source,0,NULL));
    double width=[properties[(__bridge NSString *)kCGImagePropertyPixelWidth] doubleValue],height=[properties[(__bridge NSString *)kCGImagePropertyPixelHeight] doubleValue];
    BOOL valid=isfinite(width) && isfinite(height) && width>0 && height>0 && width*height<=100000000 && CGImageSourceGetCount(source)==1 && CGImageSourceGetStatus(source)==kCGImageStatusComplete;
    // ImageIO can decode a truncated PNG/JPEG before the file's terminal marker.
    NSString *type=(__bridge NSString *)CGImageSourceGetType(source);const uint8_t *bytes=data.bytes;
    if([type isEqual:@"public.png"]){static const uint8_t end[]={0,0,0,0,'I','E','N','D',0xae,0x42,0x60,0x82};valid=valid && data.length>=sizeof(end) && !memcmp(bytes+data.length-sizeof(end),end,sizeof(end));}
    else if([type isEqual:@"public.jpeg"])valid=valid && data.length>=2 && bytes[data.length-2]==0xff && bytes[data.length-1]==0xd9;
    else if([type isEqual:@"com.compuserve.gif"])valid=valid && data.length && bytes[data.length-1]==0x3b;
    CGImageRef image=NULL;
    if(valid && !cancelled())image=CGImageSourceCreateThumbnailAtIndex(source,0,(__bridge CFDictionaryRef)@{(__bridge NSString *)kCGImageSourceCreateThumbnailFromImageAlways:@YES,(__bridge NSString *)kCGImageSourceCreateThumbnailWithTransform:@YES,(__bridge NSString *)kCGImageSourceThumbnailMaxPixelSize:@2048,(__bridge NSString *)kCGImageSourceShouldCacheImmediately:@YES});
    if(image && CGImageSourceGetStatusAtIndex(source,0)!=kCGImageStatusComplete){CGImageRelease(image);image=NULL;}
    CFRelease(source);
    if(!image || cancelled()){if(image)CGImageRelease(image);if(error)*error=CSAIImageError(7);return nil;}
    CGImageAlphaInfo alpha=CGImageGetAlphaInfo(image);BOOL transparent=alpha==kCGImageAlphaFirst || alpha==kCGImageAlphaLast || alpha==kCGImageAlphaPremultipliedFirst || alpha==kCGImageAlphaPremultipliedLast || alpha==kCGImageAlphaOnly;
    NSString *result=nil;
    for(NSNumber *bound in @[@2048,@1536,@1024,@768,@512]){
        if(cancelled())break;
        CGImageRef resized=CSAIImageScaled(image,bound.unsignedIntegerValue);if(!resized)break;
        for(NSNumber *quality in (transparent?@[@1]:@[@0.85,@0.65,@0.45])){@autoreleasepool {
            if(cancelled())break;
            NSMutableData *output=[NSMutableData data];CFStringRef type=transparent?CFSTR("public.png"):CFSTR("public.jpeg");
            CGImageDestinationRef destination=CGImageDestinationCreateWithData((__bridge CFMutableDataRef)output,type,1,NULL);
            BOOL encoded=NO;
            if(destination){CGImageDestinationAddImage(destination,resized,(__bridge CFDictionaryRef)@{(__bridge NSString *)kCGImageDestinationLossyCompressionQuality:quality});encoded=CGImageDestinationFinalize(destination);CFRelease(destination);}
            if(encoded && output.length && output.length<=CSAIImageOutputLimit && !cancelled()){
                result=[NSString stringWithFormat:@"data:image/%@;base64,%@",transparent?@"png":@"jpeg",[output base64EncodedStringWithOptions:0]];break;
            }
        }}
        CGImageRelease(resized);if(result)break;
    }
    CGImageRelease(image);if(!result && error)*error=CSAIImageError(7);return result;
}

@interface CSAIImageNativeDownload : NSObject <CSAICancellable>
@property(nonatomic,strong) id context;
@property(nonatomic,copy) NSDictionary *event;
@property(nonatomic,copy) BOOL (^valid)(void);
@property(nonatomic,copy) void (^result)(id,NSError *);
@property(nonatomic) BOOL stopped;
+ (id<CSAICancellable>)startEvent:(NSDictionary *)event environment:(id<CSMessageActionEnvironment>)environment valid:(BOOL (^)(void))valid result:(void (^)(id,NSError *))result;
@end
@implementation CSAIImageNativeDownload
+ (id<CSAICancellable>)startEvent:(NSDictionary *)event environment:(id<CSMessageActionEnvironment>)environment valid:(BOOL (^)(void))valid result:(void (^)(id,NSError *))result {
    if(!valid())return nil;
    CSAIImageNativeDownload *download=[self new];download.event=event;download.valid=valid;download.result=result;
    @try {
        id context=CSMessageActionNativeObject(NSClassFromString(@"MMContext"),@"currentContext");
        if(!valid())return nil;
        id manager=[environment serviceNamed:@"CMessageMgr"];
        if(!valid())return nil;
        Protocol *protocol=objc_getProtocol("IDownloadImageExt");
        if(!protocol || !CSMessageNativeSupports(context,@"registerExtension:withTarget:",@"v",@[@"@",@"@"]) || !CSMessageNativeSupports(context,@"unRegisterExtension:withTarget:",@"v",@[@"@",@"@"]) || !CSMessageNativeSupports(manager,@"StartDownloadImage:HD:AutoDownload:SaveAlbum:Silent:",@"v",@[@"@",@"B",@"B",@"B",@"B"]))return nil;
        if(!valid())return nil;
        download.context=context;class_addProtocol(self,protocol);
        CSMessageNativeInvoke(context,@"registerExtension:withTarget:",@[(id)protocol,download]);
        if(!valid()){[download cancel];return nil;}
        CSMessageNativeInvoke(manager,@"StartDownloadImage:HD:AutoDownload:SaveAlbum:Silent:",@[event[@"imageSource"],@NO,@NO,@NO,@YES]);
        if(!valid()){[download cancel];return nil;}
        return download;
    } @catch(__unused NSException *exception) {[download cancel];return nil;}
}
- (void)cancel {
    if(!NSThread.isMainThread){dispatch_async(dispatch_get_main_queue(),^{[self cancel];});return;}
    if(self.stopped)return;self.stopped=YES;
    id context=self.context;self.context=nil;self.event=nil;self.valid=nil;self.result=nil;
    @try {Protocol *protocol=objc_getProtocol("IDownloadImageExt");if(protocol && context)CSMessageNativeInvoke(context,@"unRegisterExtension:withTarget:",@[(id)protocol,self]);} @catch(__unused NSException *exception) {}
}
- (void)downloadResult:(id)wrap success:(BOOL)success {
    dispatch_async(dispatch_get_main_queue(),^{if(!self.stopped && self.valid && self.valid() && self.result)self.result(wrap,success?nil:CSAIImageError(4));});
}
- (void)OnDownloadImageOk:(id)wrap {[self downloadResult:wrap success:YES];}
- (void)OnDownloadImageFail:(id)wrap {[self downloadResult:wrap success:NO];}
- (void)OnDownloadImageExpired:(id)wrap {[self downloadResult:wrap success:NO];}
- (void)OnDownloadImageStop:(id)wrap {[self downloadResult:wrap success:NO];}
- (void)OnDownloadImageStopByChatName:(NSString *)chat FromDelMsg:(BOOL)deleted {
    (void)deleted;dispatch_async(dispatch_get_main_queue(),^{if([chat isEqual:self.event[@"conversation"]])[self downloadResult:self.event[@"imageSource"] success:NO];});
}
@end

@interface CSAIImageCancellationState : NSObject { @public atomic_bool cancelled,suppressCompletion; }
@end
@implementation CSAIImageCancellationState
@end
static BOOL CSAIImageLease(NSDictionary *event,NSString *(^currentAccount)(void),CSAIImageCancellationState *state) {
    if(!NSThread.isMainThread || !state || atomic_load(&state->suppressCompletion) || !currentAccount ||
       ![event[@"account"] isKindOfClass:NSString.class] || ![event[@"account"] length] || ![event[@"epoch"] isKindOfClass:NSNumber.class] ||
       ![event[@"imageStillValid"] isKindOfClass:NSClassFromString(@"NSBlock")])return NO;
    @try {
        BOOL (^stillValid)(void)=event[@"imageStillValid"];
        return stillValid() && !atomic_load(&state->suppressCompletion) && [currentAccount() isEqual:event[@"account"]] && stillValid() && !atomic_load(&state->suppressCompletion);
    } @catch(__unused NSException *exception) {return NO;}
}
@class CSAIImageOperation;
@interface CSAIImagePreparer ()
@property(nonatomic,strong) dispatch_queue_t queue;
@property(nonatomic,strong) NSMutableSet<CSAIImageOperation *> *operations;
@end
@interface CSAIImageOperation : NSObject <CSAICancellable>
@property(nonatomic,weak) CSAIImagePreparer *owner;
@property(nonatomic,strong) CSAIImageCancellationState *state;
@property(nonatomic,copy) NSDictionary *event;
@property(nonatomic,strong) id source;
@property(nonatomic,copy) CSAIImageCompletion completion;
@property(nonatomic,strong) id<CSAICancellable> download;
@property(nonatomic,strong) dispatch_source_t timeout;
@property(nonatomic) BOOL finished,requestedDownload,reading;
- (BOOL)valid;
- (BOOL)leaseValid;
- (void)read;
- (void)finishURL:(NSString *)url error:(NSError *)error;
@end
@implementation CSAIImagePreparer
- (instancetype)init {
    if((self=[super init])){
        _queue=dispatch_queue_create("com.wechat.improve.ai-image",DISPATCH_QUEUE_SERIAL);_operations=[NSMutableSet set];_downloadTimeout=20;
        CSMessageNativeEnvironment *environment=[CSMessageNativeEnvironment new];
        _currentAccount=^NSString *{return [environment currentAccountID];};_imagePaths=^NSArray *(id source){return CSAIImagePaths(source);};
        _requestDownload=^id<CSAICancellable>(NSDictionary *event,BOOL (^valid)(void),void (^result)(id,NSError *)){return [CSAIImageNativeDownload startEvent:event environment:environment valid:valid result:result];};
        _reader=^NSData *(NSString *path,BOOL (^cancelled)(void)){return CSAIReadImage(path,cancelled);};
        _encoder=^NSString *(NSData *data,BOOL (^cancelled)(void),NSError **error){return CSAIEncodeImage(data,cancelled,error);};
    }return self;
}
- (void)dealloc {for(CSAIImageOperation *operation in self.operations.allObjects)[operation cancel];}
- (id<CSAICancellable>)prepareImageForEvent:(NSDictionary *)event completion:(CSAIImageCompletion)completion {
    CSAIImageOperation *operation=[CSAIImageOperation new];operation.owner=self;operation.state=[CSAIImageCancellationState new];operation.event=[event copy];operation.source=event[@"imageSource"];operation.completion=completion;
    void (^start)(void)=^{
        if(atomic_load(&operation.state->cancelled))return;
        [self.operations addObject:operation];
        if(![operation leaseValid]){[operation finishURL:nil error:CSAIImageError(2)];return;}
        NSMutableDictionary *snapshot=[operation.event mutableCopy];
        if(![snapshot[@"imageLocalID"] isKindOfClass:NSNumber.class])snapshot[@"imageLocalID"]=@(CSMessageNativeUnsigned(operation.source,@"m_uiMesLocalID"));
        if(![operation leaseValid]){[operation finishURL:nil error:CSAIImageError(2)];return;}
        if(![snapshot[@"imageServerID"] isKindOfClass:NSNumber.class])snapshot[@"imageServerID"]=@(CSMessageNativeUnsigned(operation.source,@"m_n64MesSvrID"));
        if(![operation leaseValid]){[operation finishURL:nil error:CSAIImageError(2)];return;}
        operation.event=[snapshot copy];
        if(self.operations.count>8 || ![operation valid]){[operation finishURL:nil error:CSAIImageError(1)];return;}
        [operation read];
    };
    if(NSThread.isMainThread)start();else dispatch_async(dispatch_get_main_queue(),start);
    return operation;
}
@end
@implementation CSAIImageOperation
- (void)dealloc {
    if(_state)atomic_store(&_state->cancelled,true);
    if(_timeout)dispatch_source_cancel(_timeout);
    [_download cancel];
}
- (BOOL)leaseValid {
    if(!NSThread.isMainThread || self.finished || atomic_load(&self.state->cancelled) || !self.owner)return NO;
    NSDictionary *event=self.event;CSAIImagePreparer *owner=self.owner;
    BOOL valid=CSAIImageLease(event,owner.currentAccount,self.state);
    return valid && !self.finished && !atomic_load(&self.state->cancelled) && self.owner==owner && self.event==event;
}
- (BOOL)valid {
    if(![self leaseValid])return NO;
    BOOL matches=CSAIImageSourceIdentity(self.event,self.source);
    // Native getters may synchronously cancel and clear this operation's owner.
    return [self leaseValid] && matches;
}
- (void)finishURL:(NSString *)url error:(NSError *)error {
    if(self.finished)return;
    BOOL deliver=[self leaseValid];
    if(self.finished)return;
    NSDictionary *event=self.event;id source=self.source;NSString *(^currentAccount)(void)=self.owner.currentAccount;
    self.finished=YES;atomic_store(&self.state->cancelled,true);
    if(self.timeout){dispatch_source_cancel(self.timeout);self.timeout=nil;}
    id<CSAICancellable> download=self.download;self.download=nil;[download cancel];
    CSAIImageCompletion completion=self.completion;self.completion=nil;self.source=nil;self.event=nil;
    [self.owner.operations removeObject:self];self.owner=nil;
    // Unregistering the native extension can synchronously change the account or
    // cancel the owning batch. Recheck after that final native boundary as well.
    @try {
        if(deliver && completion && CSAIImageLease(event,currentAccount,self.state)){
            // A valid batch must receive a preparation failure immediately even
            // when the native source is unsupported or its identity has changed.
            if(url && !CSAIImageSourceIdentity(event,source)){url=nil;error=CSAIImageError(2);}
            if(CSAIImageLease(event,currentAccount,self.state))completion(url,error?:(!url?CSAIImageError(2):nil));
        }
    } @catch(__unused NSException *exception) {}
}
- (BOOL)isCancelled {return atomic_load(&self.state->cancelled);}
- (void)cancel {
    atomic_store(&self.state->suppressCompletion,true);
    if(atomic_exchange(&self.state->cancelled,true))return;
    if(NSThread.isMainThread)[self finishURL:nil error:nil];else dispatch_async(dispatch_get_main_queue(),^{[self finishURL:nil error:nil];});
}
- (void)startDownload {
    if(![self valid]){[self finishURL:nil error:CSAIImageError(2)];return;}
    if(self.requestedDownload || !self.owner.requestDownload){[self finishURL:nil error:CSAIImageError(3)];return;}
    self.requestedDownload=YES;__weak typeof(self) weakSelf=self;
    NSTimeInterval seconds=self.owner.downloadTimeout;if(!isfinite(seconds) || seconds<=0)seconds=20;seconds=MIN(seconds,30);
    self.timeout=dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0,0,dispatch_get_main_queue());
    dispatch_source_set_timer(self.timeout,dispatch_time(DISPATCH_TIME_NOW,(int64_t)(seconds*NSEC_PER_SEC)),DISPATCH_TIME_FOREVER,0);
    dispatch_source_set_event_handler(self.timeout,^{[weakSelf finishURL:nil error:CSAIImageError(5)];});dispatch_resume(self.timeout);
    BOOL (^valid)(void)=^BOOL{return [weakSelf valid];};
    void (^result)(id,NSError *)=^(id wrap,NSError *error){
        dispatch_async(dispatch_get_main_queue(),^{
            typeof(self) self=weakSelf;if(!self || self.finished)return;
            if(![self valid]){[self finishURL:nil error:CSAIImageError(2)];return;}
            BOOL matches=CSAIImageMatches(wrap,self.event);
            if(![self leaseValid]){[self finishURL:nil error:CSAIImageError(2)];return;}
            if(!matches)return;
            if(error){[self finishURL:nil error:CSAIImageError(4)];return;}
            self.source=wrap;[self read];
        });
    };
    id<CSAICancellable> download=nil;
    @try {
        if([self valid]){
            id<CSAICancellable> (^request)(NSDictionary *,BOOL (^)(void),void (^)(id,NSError *))=self.owner.requestDownload;
            if(request && [self leaseValid])download=request(self.event,valid,result);
        }
    } @catch(__unused NSException *exception) {}
    if(self.finished || ![self valid]){[download cancel];[self finishURL:nil error:CSAIImageError(2)];return;}
    self.download=download;
    if(!download)[self finishURL:nil error:CSAIImageError(3)];
}
- (void)read {
    if(![self valid]){[self finishURL:nil error:CSAIImageError(2)];return;}if(self.reading)return;
    NSArray *paths=nil;
    @try {paths=self.owner.imagePaths?self.owner.imagePaths(self.source):nil;} @catch(__unused NSException *exception) {}
    if(![self valid]){[self finishURL:nil error:CSAIImageError(2)];return;}
    NSMutableArray *snapshot=[NSMutableArray array];
    if([paths isKindOfClass:NSArray.class])for(id path in paths)if([path isKindOfClass:NSString.class] && [path isAbsolutePath] && ![snapshot containsObject:path]){[snapshot addObject:[path copy]];if(snapshot.count==8)break;}
    self.reading=YES;CSAIImageCancellationState *state=self.state;
    NSData *(^reader)(NSString *,BOOL (^)(void))=self.owner.reader;
    NSString *(^encoder)(NSData *,BOOL (^)(void),NSError **)=self.owner.encoder;
    __weak typeof(self) weakSelf=self;
    dispatch_async(self.owner.queue,^{@autoreleasepool {
        BOOL (^cancelled)(void)=^BOOL{return atomic_load(&state->cancelled);};
        if(cancelled())return;
        NSString *url=nil;NSError *error=nil;BOOL found=NO;
        for(NSString *path in snapshot){@autoreleasepool {
            if(cancelled())return;
            NSData *data=nil;
            @try {data=reader?reader(path,cancelled):nil;} @catch(__unused NSException *exception) {found=YES;error=CSAIImageError(7);break;}
            if(cancelled())return;if(![data isKindOfClass:NSData.class] || !data.length)continue;
            found=YES;if(data.length>CSAIImageInputLimit){error=CSAIImageError(6);continue;}
            @try {url=encoder?encoder(data,cancelled,&error):nil;} @catch(__unused NSException *exception) {error=CSAIImageError(7);}
            if(cancelled())return;
            if(CSAIImageDataURL(url))break;url=nil;
        }}
        if(cancelled())return;
        dispatch_async(dispatch_get_main_queue(),^{
            typeof(self) self=weakSelf;if(!self || self.finished)return;self.reading=NO;
            if(![self valid]){[self finishURL:nil error:CSAIImageError(2)];return;}
            if(url.length)[self finishURL:url error:nil];
            else if(!found && !self.requestedDownload)[self startDownload];
            else [self finishURL:nil error:error?:CSAIImageError(7)];
        });
    }});
}
@end
