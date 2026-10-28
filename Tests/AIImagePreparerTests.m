#import <Foundation/Foundation.h>
#import <ImageIO/ImageIO.h>
#import <CoreGraphics/CoreGraphics.h>
#import <zlib.h>
#import <sys/stat.h>
#import "CSAIImagePreparer.h"

static NSUInteger checks,nativeReads;
#define CHECK(c) do {checks++;if(!(c)){fprintf(stderr,"FAIL %d: %s\n",__LINE__,#c);exit(1);}} while(0)
static void NativeMain(void){if(!NSThread.isMainThread){fprintf(stderr,"Native image access off main\n");exit(1);}nativeReads++;}
static BOOL Wait(BOOL (^ready)(void)) {NSDate *until=[NSDate dateWithTimeIntervalSinceNow:3];while(!ready() && until.timeIntervalSinceNow>0)[NSRunLoop.currentRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.002]];return ready();}
static void Drain(void){for(NSUInteger i=0;i<8;i++)[NSRunLoop.currentRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.002]];}

@interface CMessageWrap:NSObject
@property(nonatomic,copy) NSString *m_nsFromUsr,*m_nsToUsr,*m_nsRealChatUsr,*path;
@property(nonatomic) unsigned int m_uiMessageType,m_uiCreateTime,m_uiMesLocalID;
@property(nonatomic) long long m_n64MesSvrID;
@property(nonatomic,copy) void (^serverReadAction)(void);
@end
@implementation CMessageWrap
@synthesize m_nsFromUsr=_m_nsFromUsr,m_nsToUsr=_m_nsToUsr,m_nsRealChatUsr=_m_nsRealChatUsr,m_uiMessageType=_m_uiMessageType,m_uiCreateTime=_m_uiCreateTime,m_uiMesLocalID=_m_uiMesLocalID,m_n64MesSvrID=_m_n64MesSvrID;
- (NSString *)m_nsFromUsr {NativeMain();return _m_nsFromUsr;}
- (NSString *)m_nsToUsr {NativeMain();return _m_nsToUsr;}
- (NSString *)m_nsRealChatUsr {NativeMain();return _m_nsRealChatUsr;}
- (unsigned int)m_uiMessageType {NativeMain();return _m_uiMessageType;}
- (unsigned int)m_uiCreateTime {NativeMain();return _m_uiCreateTime;}
- (unsigned int)m_uiMesLocalID {NativeMain();return _m_uiMesLocalID;}
- (long long)m_n64MesSvrID {NativeMain();if(self.serverReadAction)self.serverReadAction();return _m_n64MesSvrID;}
+ (id)getJpgPathOfMsgHdOrMiddleImg:(CMessageWrap *)wrap {NativeMain();return wrap.path;}
+ (id)getPathOfRawMiddleImage:(CMessageWrap *)wrap {NativeMain();return wrap.path;}
+ (id)getJpgPathOfMsgMiddleImg:(CMessageWrap *)wrap {NativeMain();return wrap.path;}
@end
@protocol IDownloadImageExt <NSObject>
- (void)OnDownloadImageOk:(id)wrap;
- (void)OnDownloadImageFail:(id)wrap;
@end
@interface TestContact:NSObject
@property(nonatomic,copy) NSString *m_nsUsrName;
@end
@implementation TestContact
@end
@interface CContactMgr:NSObject
@property(nonatomic,strong) TestContact *contact;
- (id)getSelfContact;
@end
@implementation CContactMgr
- (id)getSelfContact {NativeMain();return self.contact;}
@end
@interface CMessageMgr:NSObject
@property(nonatomic) NSUInteger starts;
@property(nonatomic,copy) void (^startAction)(void);
- (void)StartDownloadImage:(id)wrap HD:(BOOL)hd AutoDownload:(BOOL)automatic SaveAlbum:(BOOL)album Silent:(BOOL)silent;
@end
@implementation CMessageMgr
- (void)StartDownloadImage:(id)wrap HD:(BOOL)hd AutoDownload:(BOOL)automatic SaveAlbum:(BOOL)album Silent:(BOOL)silent {NativeMain();CHECK([wrap isKindOfClass:CMessageWrap.class] && !hd && !automatic && !album && silent);self.starts++;if(self.startAction)self.startAction();}
@end
@interface MMContext:NSObject
@property(nonatomic,strong) CMessageMgr *messages;
@property(nonatomic,strong) CContactMgr *contacts;
@property(nonatomic,strong) NSMutableSet *targets;
@property(nonatomic) NSUInteger registrations,unregistrations;
@property(nonatomic,copy) void (^lookupAction)(void),(^registerAction)(void),(^unregisterAction)(void);
+ (id)currentContext;
- (id)getService:(Class)cls;
- (void)registerExtension:(id)protocol withTarget:(id)target;
- (void)unRegisterExtension:(id)protocol withTarget:(id)target;
@end
static MMContext *context;
@implementation MMContext
+ (id)currentContext {NativeMain();return context;}
- (id)getService:(Class)cls {NativeMain();if(cls==CMessageMgr.class){if(self.lookupAction)self.lookupAction();return self.messages;}return cls==CContactMgr.class?self.contacts:nil;}
- (void)registerExtension:(id)protocol withTarget:(id)target {NativeMain();CHECK(protocol==@protocol(IDownloadImageExt));self.registrations++;[self.targets addObject:target];if(self.registerAction)self.registerAction();}
- (void)unRegisterExtension:(id)protocol withTarget:(id)target {NativeMain();CHECK(protocol==@protocol(IDownloadImageExt));self.unregistrations++;[self.targets removeObject:target];if(self.unregisterAction)self.unregisterAction();}
@end
@interface TestCancellation:NSObject<CSAICancellable>
@property(nonatomic) NSUInteger cancellations;
@end
@implementation TestCancellation
- (void)cancel {self.cancellations++;}
@end
@interface TestDownloadBoundaryPreparer:CSAIImagePreparer
@property(nonatomic,copy) void (^timeoutRead)(void);
@end
@implementation TestDownloadBoundaryPreparer
- (NSTimeInterval)downloadTimeout {if(self.timeoutRead)self.timeoutRead();return [super downloadTimeout];}
@end

static CMessageWrap *Wrap(NSString *path) {
    CMessageWrap *wrap=[CMessageWrap new];wrap.m_nsFromUsr=@"image-room@chatroom";wrap.m_nsToUsr=@"self";wrap.m_nsRealChatUsr=@"sender";
    wrap.m_uiMessageType=3;wrap.m_uiCreateTime=1000;wrap.m_uiMesLocalID=123;wrap.m_n64MesSvrID=456;wrap.path=path;return wrap;
}
static NSDictionary *Event(CMessageWrap *wrap,BOOL (^valid)(void)) {
    return @{@"account":@"self",@"conversation":@"image-room@chatroom",@"sender":@"sender",@"type":@3,@"created":@1000,@"epoch":@7,
             @"identifiers":@[@"self|image-room@chatroom|s:456",@"self|image-room@chatroom|l:123:1000"],@"imageLocalID":@123,@"imageServerID":@456,@"imageSource":wrap,@"imageStillValid":[valid copy]};
}
static NSData *ImageData(size_t width,size_t height,BOOL alpha,BOOL noise) {
    NSMutableData *pixels=[NSMutableData dataWithLength:width*height*4];uint8_t *bytes=pixels.mutableBytes;uint32_t value=17;
    for(size_t i=0;i<width*height;i++){value=value*1664525+1013904223;bytes[i*4]=(uint8_t)(value>>24);bytes[i*4+1]=noise?(uint8_t)(value>>16):32;bytes[i*4+2]=noise?(uint8_t)(value>>8):64;bytes[i*4+3]=alpha?(uint8_t)(value|64):255;}
    CGColorSpaceRef space=CGColorSpaceCreateDeviceRGB();CGContextRef bitmap=CGBitmapContextCreate(bytes,width,height,8,width*4,space,(CGBitmapInfo)(alpha?kCGImageAlphaPremultipliedLast:kCGImageAlphaNoneSkipLast));CGColorSpaceRelease(space);CHECK(bitmap);
    CGImageRef image=CGBitmapContextCreateImage(bitmap);CGContextRelease(bitmap);NSMutableData *result=[NSMutableData data];
    CGImageDestinationRef destination=CGImageDestinationCreateWithData((__bridge CFMutableDataRef)result,CFSTR("public.png"),1,NULL);CHECK(destination);CGImageDestinationAddImage(destination,image,NULL);CHECK(CGImageDestinationFinalize(destination));CFRelease(destination);CGImageRelease(image);return result;
}
static NSData *URLBytes(NSString *url){NSRange comma=[url rangeOfString:@","];return comma.location==NSNotFound?nil:[[NSData alloc]initWithBase64EncodedString:[url substringFromIndex:comma.location+1] options:0];}
static void CheckEncoded(NSString *url,BOOL alpha) {
    CHECK([url hasPrefix:alpha?@"data:image/png;base64,":@"data:image/jpeg;base64,"]);
    NSData *bytes=URLBytes(url);CHECK(bytes.length && bytes.length<=2*1024*1024);
    CGImageSourceRef source=CGImageSourceCreateWithData((__bridge CFDataRef)bytes,NULL);CHECK(source && CGImageSourceGetStatus(source)==kCGImageStatusComplete);
    NSDictionary *properties=CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(source,0,NULL));CHECK([properties[(__bridge NSString *)kCGImagePropertyPixelWidth] unsignedIntegerValue]<=2048 && [properties[(__bridge NSString *)kCGImagePropertyPixelHeight] unsignedIntegerValue]<=2048);CFRelease(source);
}
static NSString *Prepare(CSAIImagePreparer *preparer,NSDictionary *event,NSError **error) {
    __block BOOL done=NO;__block NSString *url=nil;__block NSError *failure=nil;
    [preparer prepareImageForEvent:event completion:^(NSString *result,NSError *problem){CHECK(NSThread.isMainThread);url=result;failure=problem;done=YES;}];CHECK(Wait(^BOOL{return done;}));if(error)*error=failure;return url;
}
static void ResetNative(void){CHECK(!context.targets.count);context.contacts.contact.m_nsUsrName=@"self";context.lookupAction=context.registerAction=context.unregisterAction=context.messages.startAction=nil;}

static void TestEncoding(NSString *directory) {
    CSAIImagePreparer *preparer=[CSAIImagePreparer new];NSString *path=[directory stringByAppendingPathComponent:@"large.png"];
    CHECK([ImageData(3200,1600,NO,NO) writeToFile:path atomically:YES]);CMessageWrap *wrap=Wrap(path);NSError *error=nil;
    NSString *url=Prepare(preparer,Event(wrap,^BOOL{return YES;}),&error);CHECK(url && !error);CheckEncoded(url,NO);CHECK(!context.targets.count && !context.messages.starts);
    path=[directory stringByAppendingPathComponent:@"transparent.png"];CHECK([ImageData(2048,2048,YES,YES) writeToFile:path atomically:YES]);wrap=Wrap(path);
    url=Prepare(preparer,Event(wrap,^BOOL{return YES;}),&error);CHECK(url && !error);CheckEncoded(url,YES);
    NSMutableDictionary *fallback=[Event(wrap,^BOOL{return YES;}) mutableCopy];[fallback removeObjectForKey:@"imageLocalID"];[fallback removeObjectForKey:@"imageServerID"];
    CHECK(Prepare(preparer,fallback,&error) && !error);
    __block BOOL readOffMain=NO,encodedOffMain=NO;NSData *(^reader)(NSString *,BOOL (^)(void))=preparer.reader;NSString *(^encoder)(NSData *,BOOL (^)(void),NSError **)=preparer.encoder;
    preparer.reader=^NSData *(NSString *file,BOOL (^cancelled)(void)){readOffMain=!NSThread.isMainThread;return reader(file,cancelled);};
    preparer.encoder=^NSString *(NSData *data,BOOL (^cancelled)(void),NSError **failure){encodedOffMain=!NSThread.isMainThread;return encoder(data,cancelled,failure);};
    CHECK(Prepare(preparer,Event(wrap,^BOOL{return YES;}),&error) && readOffMain && encodedOffMain);
    NSData *tiny=ImageData(8,8,NO,NO);NSMutableData *bomb=[tiny mutableCopy];uint8_t *bytes=bomb.mutableBytes;
    for(NSUInteger offset=16;offset<=20;offset+=4){bytes[offset]=0;bytes[offset+1]=0;bytes[offset+2]=0xC3;bytes[offset+3]=0x50;}
    uint32_t crc=(uint32_t)crc32(0,bytes+12,17);bytes[29]=(uint8_t)(crc>>24);bytes[30]=(uint8_t)(crc>>16);bytes[31]=(uint8_t)(crc>>8);bytes[32]=(uint8_t)crc;
    for(NSData *invalid in @[[tiny subdataWithRange:NSMakeRange(0,tiny.length/2)],bomb]){
        preparer.reader=^NSData *(NSString *file,BOOL (^cancelled)(void)){(void)file;(void)cancelled;return invalid;};
        NSString *invalidURL=Prepare(preparer,Event(wrap,^BOOL{return YES;}),&error);
        CHECK(!invalidURL && error);
    }
    __block NSUInteger encodes=0;preparer.encoder=^NSString *(NSData *data,BOOL (^cancelled)(void),NSError **failure){(void)data;(void)cancelled;(void)failure;encodes++;return @"file:///must-never-leave-device.png";};
    preparer.reader=^NSData *(NSString *file,BOOL (^cancelled)(void)){(void)file;(void)cancelled;return tiny;};
    CHECK(!Prepare(preparer,Event(wrap,^BOOL{return YES;}),&error) && error && encodes==1);
    preparer.reader=^NSData *(NSString *file,BOOL (^cancelled)(void)){(void)file;(void)cancelled;return [NSMutableData dataWithLength:32*1024*1024+1];};
    CHECK(!Prepare(preparer,Event(wrap,^BOOL{return YES;}),&error) && error.code==6 && encodes==1);
    // The default reader refuses links and directories before opening image data.
    preparer=[CSAIImagePreparer new];preparer.requestDownload=^id<CSAICancellable>(NSDictionary *event,BOOL (^valid)(void),void (^result)(id,NSError *)){(void)event;(void)valid;(void)result;return nil;};
    NSString *link=[directory stringByAppendingPathComponent:@"linked.png"];CHECK([NSFileManager.defaultManager createSymbolicLinkAtPath:link withDestinationPath:path error:NULL]);
    CHECK(!Prepare(preparer,Event(Wrap(link),^BOOL{return YES;}),&error) && error.code==3);
    CHECK(!Prepare(preparer,Event(Wrap(directory),^BOOL{return YES;}),&error) && error.code==3);
    // Opening a FIFO must not block the sole IO worker before its type check.
    NSString *fifo=[directory stringByAppendingPathComponent:@"image-fifo"];CHECK(mkfifo(fifo.fileSystemRepresentation,0600)==0);
    CHECK(!Prepare(preparer,Event(Wrap(fifo),^BOOL{return YES;}),&error) && error.code==3);
    CHECK(Prepare(preparer,Event(Wrap(path),^BOOL{return YES;}),&error) && !error);
}
static void TestNativeDownload(NSString *directory) {
    ResetNative();CSAIImagePreparer *preparer=[CSAIImagePreparer new];CMessageWrap *original=Wrap([directory stringByAppendingPathComponent:@"missing.png"]);
    __block NSUInteger callbacks=0;__block NSString *url=nil;NSUInteger starts=context.messages.starts,unregisters=context.unregistrations;
    [preparer prepareImageForEvent:Event(original,^BOOL{return YES;}) completion:^(NSString *result,NSError *error){CHECK(NSThread.isMainThread && !error);callbacks++;url=result;}];
    CHECK(Wait(^BOOL{return context.messages.starts==starts+1;}));CHECK(context.targets.count==1);
    id<IDownloadImageExt> target=context.targets.anyObject;
    for(NSUInteger mutation=0;mutation<7;mutation++){
        CMessageWrap *other=Wrap(original.path);
        switch(mutation){case 0:other.m_nsToUsr=@"other-account";break;case 1:other.m_nsFromUsr=@"other-room@chatroom";break;case 2:other.m_nsRealChatUsr=@"other-sender";break;case 3:other.m_uiMesLocalID=124;break;case 4:other.m_n64MesSvrID=457;break;case 5:other.m_uiCreateTime=1001;break;default:other.m_uiMessageType=1;break;}
        [target OnDownloadImageOk:other];Drain();CHECK(!callbacks && context.targets.count==1);
    }
    CMessageWrap *downloaded=Wrap([directory stringByAppendingPathComponent:@"large.png"]);[target OnDownloadImageOk:downloaded];CHECK(Wait(^BOOL{return callbacks==1;}));CheckEncoded(url,NO);
    CHECK(context.messages.starts==starts+1 && !context.targets.count && context.unregistrations==unregisters+1);
    [target OnDownloadImageOk:downloaded];Drain();CHECK(callbacks==1);
    // Exact failure completes once, while unrelated callbacks above were ignored.
    starts=context.messages.starts;callbacks=0;__block NSError *failure=nil;
    [preparer prepareImageForEvent:Event(original,^BOOL{return YES;}) completion:^(NSString *result,NSError *error){CHECK(!result);callbacks++;failure=error;}];CHECK(Wait(^BOOL{return context.messages.starts==starts+1;}));
    target=context.targets.anyObject;[target OnDownloadImageFail:original];CHECK(Wait(^BOOL{return callbacks==1;}));CHECK(failure && !context.targets.count);
    // Cancellation only detaches our delegate; no shared downloader stop API.
    starts=context.messages.starts;callbacks=0;
    id<CSAICancellable> cancellation=[preparer prepareImageForEvent:Event(original,^BOOL{return YES;}) completion:^(NSString *result,NSError *error){(void)result;(void)error;callbacks++;}];CHECK(Wait(^BOOL{return context.messages.starts==starts+1;}));target=context.targets.anyObject;
    [cancellation cancel];CHECK(!context.targets.count);[target OnDownloadImageOk:downloaded];Drain();CHECK(!callbacks);
    // The eligibility block is checked across each reentrant native boundary.
    for(NSUInteger stage=0;stage<3;stage++){
        ResetNative();__block BOOL valid=YES;starts=context.messages.starts;callbacks=0;
        void (^invalidate)(void)=^{valid=NO;};if(stage==0)context.lookupAction=invalidate;else if(stage==1)context.registerAction=invalidate;else context.messages.startAction=invalidate;
        [preparer prepareImageForEvent:Event(original,^BOOL{return valid;}) completion:^(NSString *result,NSError *error){(void)result;(void)error;callbacks++;}];
        CHECK(Wait(^BOOL{return !valid;}));Drain();CHECK(!context.targets.count && !callbacks && context.messages.starts==starts+(stage==2?1:0));
    }
    // Even the final delegate removal can reenter account/config cancellation.
    for(NSUInteger stage=0;stage<2;stage++){
        ResetNative();__block BOOL valid=YES;starts=context.messages.starts;callbacks=0;__block id<CSAICancellable> token=nil;
        token=[preparer prepareImageForEvent:Event(original,^BOOL{return valid;}) completion:^(NSString *result,NSError *error){(void)result;(void)error;callbacks++;}];CHECK(Wait(^BOOL{return context.messages.starts==starts+1;}));
        context.unregisterAction=^{if(stage==0)valid=NO;else [token cancel];};target=context.targets.anyObject;[target OnDownloadImageOk:downloaded];
        CHECK(Wait(^BOOL{return !context.targets.count;}));Drain();CHECK(!callbacks && [[preparer valueForKey:@"operations"] count]==0);context.unregisterAction=nil;token=nil;
    }
    ResetNative();
}
static void TestTimeoutAndCancellation(NSString *directory) {
    CSAIImagePreparer *preparer=[CSAIImagePreparer new];CMessageWrap *wrap=Wrap(@"/missing-ai-image-fixture");preparer.downloadTimeout=.03;
    TestCancellation *download=[TestCancellation new];__block NSUInteger requests=0;
    preparer.requestDownload=^id<CSAICancellable>(NSDictionary *event,BOOL (^valid)(void),void (^result)(id,NSError *)){(void)event;(void)result;CHECK(NSThread.isMainThread && valid());requests++;return download;};
    NSError *error=nil;CHECK(!Prepare(preparer,Event(wrap,^BOOL{return YES;}),&error) && error.code==5 && requests==1 && download.cancellations==1);
    // Queued work observes cancellation before touching files or starting decode.
    preparer=[CSAIImagePreparer new];dispatch_semaphore_t entered=dispatch_semaphore_create(0),release=dispatch_semaphore_create(0);__block NSUInteger reads=0,encodes=0,callbacks=0;
    preparer.reader=^NSData *(NSString *path,BOOL (^cancelled)(void)){(void)path;reads++;dispatch_semaphore_signal(entered);dispatch_semaphore_wait(release,dispatch_time(DISPATCH_TIME_NOW,2*NSEC_PER_SEC));CHECK(cancelled());return [@"bytes" dataUsingEncoding:NSUTF8StringEncoding];};
    preparer.encoder=^NSString *(NSData *data,BOOL (^cancelled)(void),NSError **failure){(void)data;(void)cancelled;(void)failure;encodes++;return nil;};
    id<CSAICancellable> first=[preparer prepareImageForEvent:Event(wrap,^BOOL{return YES;}) completion:^(NSString *url,NSError *failure){(void)url;(void)failure;callbacks++;}];
    CHECK(dispatch_semaphore_wait(entered,dispatch_time(DISPATCH_TIME_NOW,NSEC_PER_SEC))==0);
    __weak CMessageWrap *releasedWrap=nil;id<CSAICancellable> second=nil;
    @autoreleasepool {CMessageWrap *queued=Wrap(@"/queued-ai-image-fixture");releasedWrap=queued;second=[preparer prepareImageForEvent:Event(queued,^BOOL{return YES;}) completion:^(NSString *url,NSError *failure){(void)url;(void)failure;callbacks++;}];[second cancel];}
    CHECK(!releasedWrap);
    [first cancel];dispatch_semaphore_signal(release);Drain();CHECK(reads==1 && !encodes && !callbacks);
    CHECK([[preparer valueForKey:@"operations"] count]==0);[second cancel];
    // An account switch during asynchronous file preparation suppresses output.
    preparer=[CSAIImagePreparer new];preparer.reader=^NSData *(NSString *path,BOOL (^cancelled)(void)){(void)path;(void)cancelled;return [NSData data];};
    __block BOOL valid=YES;preparer.imagePaths=^NSArray *(id source){(void)source;valid=NO;return @[@"/must-not-read"];} ;
    requests=0;preparer.requestDownload=^id<CSAICancellable>(NSDictionary *event,BOOL (^eligible)(void),void (^result)(id,NSError *)){(void)event;(void)eligible;(void)result;requests++;return nil;};
    [preparer prepareImageForEvent:Event(wrap,^BOOL{return valid;}) completion:^(NSString *url,NSError *failure){(void)url;(void)failure;callbacks++;}];Drain();CHECK(!requests && !callbacks && [[preparer valueForKey:@"operations"] count]==0);
    // Off-main admission dispatches native work and completion back to main.
    preparer=[CSAIImagePreparer new];wrap=Wrap([directory stringByAppendingPathComponent:@"large.png"]);__block BOOL done=NO;NSDictionary *event=Event(wrap,^BOOL{return YES;});
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT,0),^{[preparer prepareImageForEvent:event completion:^(NSString *url,NSError *failure){CHECK(NSThread.isMainThread && url && !failure);done=YES;}];});CHECK(Wait(^BOOL{return done;}));
}
static void TestSourceFailureAndGetterCancellation(NSString *directory) {
    CSAIImagePreparer *preparer=[CSAIImagePreparer new];__block NSUInteger requests=0,callbacks=0;
    preparer.requestDownload=^id<CSAICancellable>(NSDictionary *event,BOOL (^valid)(void),void (^result)(id,NSError *)){(void)event;(void)valid;(void)result;requests++;return nil;};
    // Unsupported and damaged native sources are preparation errors while the
    // coordinator's account/configuration lease remains valid.
    for(NSUInteger failure=0;failure<2;failure++){
        CMessageWrap *wrap=Wrap(@"/invalid-source-fixture");NSMutableDictionary *event=[Event(wrap,^BOOL{return YES;}) mutableCopy];
        if(failure==0)event[@"imageSource"]=[NSObject new];else wrap.m_nsRealChatUsr=@"changed-sender";
        NSUInteger before=callbacks;
        [preparer prepareImageForEvent:event completion:^(NSString *url,NSError *error){CHECK(NSThread.isMainThread && !url && error);callbacks++;}];
        CHECK(callbacks==before+1 && !requests && [[preparer valueForKey:@"operations"] count]==0);
    }
    // A source damaged after bytes were snapshotted still cannot receive a URL;
    // its valid batch gets an immediate failure and releases its slot.
    CMessageWrap *wrap=Wrap([directory stringByAppendingPathComponent:@"large.png"]);
    dispatch_semaphore_t entered=dispatch_semaphore_create(0),release=dispatch_semaphore_create(0);
    NSString *(^encoder)(NSData *,BOOL (^)(void),NSError **)=preparer.encoder;
    preparer.encoder=^NSString *(NSData *data,BOOL (^cancelled)(void),NSError **error){dispatch_semaphore_signal(entered);dispatch_semaphore_wait(release,dispatch_time(DISPATCH_TIME_NOW,2*NSEC_PER_SEC));return encoder(data,cancelled,error);};
    NSUInteger before=callbacks;
    [preparer prepareImageForEvent:Event(wrap,^BOOL{return YES;}) completion:^(NSString *url,NSError *error){CHECK(!url && error);callbacks++;}];
    CHECK(dispatch_semaphore_wait(entered,dispatch_time(DISPATCH_TIME_NOW,NSEC_PER_SEC))==0);wrap.m_nsRealChatUsr=@"changed-during-encoding";dispatch_semaphore_signal(release);
    CHECK(Wait(^BOOL{return callbacks==before+1;}));CHECK(!requests && [[preparer valueForKey:@"operations"] count]==0);
    // Install cancellation after download admission but before its final native
    // source validation. A getter reenters cancel and clears owner/requestDownload.
    TestDownloadBoundaryPreparer *boundary=[TestDownloadBoundaryPreparer new];wrap=Wrap(@"/getter-cancel-fixture");__block id<CSAICancellable> token=nil;__block NSUInteger cancellations=0;
    boundary.imagePaths=^NSArray *(id source){(void)source;return @[];};
    boundary.requestDownload=^id<CSAICancellable>(NSDictionary *event,BOOL (^valid)(void),void (^result)(id,NSError *)){(void)event;(void)valid;(void)result;requests++;return nil;};
    __weak CMessageWrap *weakWrap=wrap;
    boundary.timeoutRead=^{weakWrap.serverReadAction=^{weakWrap.serverReadAction=nil;cancellations++;[token cancel];};};
    before=callbacks;token=[boundary prepareImageForEvent:Event(wrap,^BOOL{return YES;}) completion:^(NSString *url,NSError *error){(void)url;(void)error;callbacks++;}];
    CHECK(Wait(^BOOL{return cancellations==1;}));Drain();CHECK(callbacks==before && !requests && [[boundary valueForKey:@"operations"] count]==0);
    boundary.timeoutRead=nil;wrap.serverReadAction=nil;token=nil;
}
int main(int argc,const char **argv){@autoreleasepool {
    CHECK(argc==2);NSString *directory=[NSString stringWithUTF8String:argv[1]];
    context=[MMContext new];context.targets=[NSMutableSet set];context.messages=[CMessageMgr new];context.contacts=[CContactMgr new];context.contacts.contact=[TestContact new];context.contacts.contact.m_nsUsrName=@"self";
    TestEncoding(directory);TestNativeDownload(directory);TestTimeoutAndCancellation(directory);TestSourceFailureAndGetterCancellation(directory);CHECK(nativeReads>0 && !context.targets.count);
    printf("AI image preparation: %lu checks passed; bounded ImageIO encoding, native download identity, cancellation and account reentry verified\n",(unsigned long)checks);
}return 0;}
