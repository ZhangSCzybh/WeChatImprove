#import "CSMessageImageStickerAdapter.h"
#import <objc/runtime.h>
#import <TargetConditionals.h>
#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
#import <ImageIO/ImageIO.h>
#import "CSBackupBootstrap.h"
#endif
@interface NSObject (CSStickerTaskConstruction)
- (instancetype)initWithImage:(id)image;
- (instancetype)initWithGifData:(NSData *)data;
@end
@class CSImageStickerOperation;
@interface CSMessageImageStickerAdapter ()
@property id<CSMessageActionEnvironment> environment;
@property CSMessageMediaProvider *media;
@property NSMutableDictionary<NSString *,CSImageStickerOperation *> *operations;
@end
@interface CSImageStickerOperation : NSObject
@property CSMessageActionContext *context;
@property(weak) CSMessageImageStickerAdapter *owner;
@property NSString *identifier;
@property id task;
@property id extensionContext;
@property id addingItem;
@property BOOL requestedDownload;
@property BOOL reading;
@property BOOL submitted;
@property BOOL finished;
@property BOOL completing;
@property NSUInteger backupEpoch;
- (void)read;
- (BOOL)valid;
- (void)finish;
- (void)completeWithSuccess:(BOOL)success;
@end
static id CSStickerTask(NSData *data) {
#if TARGET_OS_IOS
    if (!data.length || data.length>32*1024*1024) return nil;
    CGImageSourceRef source=CGImageSourceCreateWithData((__bridge CFDataRef)data,NULL); if (!source) return nil;
    size_t frames=CGImageSourceGetCount(source); NSString *type=(__bridge NSString *)CGImageSourceGetType(source);
    NSDictionary *properties=CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(source,0,NULL));
    double width=[properties[(__bridge NSString *)kCGImagePropertyPixelWidth] doubleValue],height=[properties[(__bridge NSString *)kCGImagePropertyPixelHeight] doubleValue];
    BOOL valid=width>0 && height>0 && width*height<=100000000 && CGImageSourceGetStatus(source)==kCGImageStatusComplete;
    Class cls=NSClassFromString(@"EmoticonCreateImageUploadTask"); id task=nil;
    if (valid && [type isEqual:@"com.compuserve.gif"] && CSMessageNativeSupports([cls alloc],@"initWithGifData:",@"@",@[@"@"])) task=[[cls alloc] initWithGifData:data];
    else if (valid && frames==1 && CSMessageNativeSupports([cls alloc],@"initWithImage:",@"@",@[@"@"])) {
        CGImageRef image=CGImageSourceCreateThumbnailAtIndex(source,0,(__bridge CFDictionaryRef)@{(__bridge NSString *)kCGImageSourceCreateThumbnailFromImageAlways:@YES,(__bridge NSString *)kCGImageSourceCreateThumbnailWithTransform:@YES,(__bridge NSString *)kCGImageSourceThumbnailMaxPixelSize:@2048});
        if (image) { task=[[cls alloc] initWithImage:[UIImage imageWithCGImage:image]]; CGImageRelease(image); }
    }
    CFRelease(source); return task;
#else
    (void)data; return nil;
#endif
}
@implementation CSMessageImageStickerAdapter
- (instancetype)initWithEnvironment:(id<CSMessageActionEnvironment>)environment media:(CSMessageMediaProvider *)media {
    if ((self=[super init])) { _environment=environment; _media=media; _operations=[NSMutableDictionary dictionary]; _taskFactory=^id(NSData *data){ return CSStickerTask(data); }; } return self;
}
- (void)addContext:(CSMessageActionContext *)context {
    if (!NSThread.isMainThread || context.messageType!=3 || !self.validate || !self.validate(context)) return;
    for (CSImageStickerOperation *op in self.operations.allValues) if ([op.context matchesSourceContext:context]) return;
    if (self.operations.count>=4) return;
    CSImageStickerOperation *op=[CSImageStickerOperation new]; op.context=context; op.owner=self; op.identifier=NSUUID.UUID.UUIDString; self.operations[op.identifier]=op;
#if TARGET_OS_IOS
    op.backupEpoch=CSBackupAccountEpoch();
#endif
    __weak CSImageStickerOperation *weakOp=op;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,90*NSEC_PER_SEC),dispatch_get_main_queue(),^{ CSImageStickerOperation *live=weakOp; if (live && !live.finished) [live finish]; });
    [op read];
}
- (void)cancelInvalidOperations { for (CSImageStickerOperation *op in self.operations.allValues) if (![op valid]) [op finish]; }
- (void)cancelAllOperations { for (CSImageStickerOperation *op in self.operations.allValues) [op finish]; }
@end
@implementation CSImageStickerOperation
- (BOOL)valid {
#if TARGET_OS_IOS
    if (!CSBackupIsReady() || CSBackupAccountIsSuspended() || self.backupEpoch!=CSBackupAccountEpoch()) return NO;
#endif
    return !self.finished && self.owner && self.owner.validate && self.owner.validate(self.context);
}
- (void)unregisterDownload {
    id context=self.extensionContext; self.extensionContext=nil;
    @try { Protocol *protocol=objc_getProtocol("IDownloadImageExt"); if (protocol && CSMessageNativeSupports(context,@"unRegisterExtension:withTarget:",@"v",@[@"@",@"@"])) CSMessageNativeInvoke(context,@"unRegisterExtension:withTarget:",@[(id)protocol,self]); } @catch (__unused NSException *exception) {}
}
- (void)finish {
    if (!NSThread.isMainThread) { dispatch_async(dispatch_get_main_queue(),^{ [self finish]; }); return; }
    if (self.finished) return; self.finished=YES; [self unregisterDownload];
    // Detach only our delegates. Native already-submitted work may finish; never repeat it or stop a shared downloader.
    @try {
        id logic=CSMessageActionNativeObject(self.task,@"addEmoticonLogic");
        CSMessageNativeSet(logic,@"setDelegate:",nil,NO); CSMessageNativeSet(self.task,@"setDelegate:",nil,NO);
        if (CSMessageNativeSupports(self.task,@"setPrepareFailBlock:",@"v",@[@"@?"])) CSMessageNativeInvoke(self.task,@"setPrepareFailBlock:",@[NSNull.null]);
        if (CSMessageNativeSupports(self.task,@"setUploadFailBlock:",@"v",@[@"@?"])) CSMessageNativeInvoke(self.task,@"setUploadFailBlock:",@[NSNull.null]);
    } @catch (__unused NSException *exception) {}
    [self.owner.operations removeObjectForKey:self.identifier]; self.task=nil; self.addingItem=nil;
}
- (void)completeWithSuccess:(BOOL)success {
    if (!NSThread.isMainThread) { dispatch_async(dispatch_get_main_queue(),^{ [self completeWithSuccess:success]; }); return; }
    if (self.finished || self.completing) return; self.completing=YES;
    @try {
        if (success && self.submitted && [self valid]) {
            id logic=CSMessageActionNativeObject(self.task,@"addEmoticonLogic");
            // handleAddingItem: disables automatic success UI. Restore only that missing
            // native result, before finish detaches the delegate/getViewController.
            // If WeChat already owns automatic presentation, leave it alone.
            if (CSMessageNativeSupports(logic,@"disableAutoShowSucToast",@"B",@[]) &&
                [CSMessageNativeInvoke(logic,@"disableAutoShowSucToast",@[]) boolValue] &&
                CSMessageNativeSupports(logic,@"showSavedTips",@"v",@[]))
                CSMessageNativeInvoke(logic,@"showSavedTips",@[]);
        }
    } @catch (__unused NSException *exception) {}
    [self finish];
}
- (void)read {
    if (![self valid]) { [self finish]; return; } if (self.reading || self.submitted) return; self.reading=YES;
    __weak typeof(self) weakSelf=self;
    [self.owner.media readImageForContext:self.context completion:^(NSData *data){
        typeof(self) self=weakSelf; if (!self || self.finished) return; self.reading=NO;
        if (![self valid]) { [self finish]; return; }
        if (!data.length) { if (!self.requestedDownload) [self download]; else [self finish]; return; }
        [self unregisterDownload];
        @try {
            id task=self.owner.taskFactory?self.owner.taskFactory(data):nil;
            if (!task || !CSMessageNativeSupports(task,@"setDelegate:",@"v",@[@"@"]) || !CSMessageNativeSupports(task,@"startUpload",@"v",@[]) || !CSMessageNativeSupports(task,@"addEmoticonLogic",@"@",@[]) || !NSClassFromString(@"EmoticonCustomAddingItem")) { [self finish]; return; }
            self.task=task; CSMessageNativeSet(task,@"setDelegate:",self,YES);
            id logic=CSMessageActionNativeObject(task,@"addEmoticonLogic"); if (!CSMessageNativeSet(logic,@"setDelegate:",self,YES)) { [self finish]; return; }
            void (^failed)(void)=^{ [weakSelf finish]; };
            for (NSString *selector in @[@"setPrepareFailBlock:",@"setUploadFailBlock:"]) if (CSMessageNativeSupports(task,selector,@"v",@[@"@?"])) CSMessageNativeInvoke(task,selector,@[failed]);
            if (![self valid]) { [self finish]; return; }
            self.submitted=YES;
#if TARGET_OS_IOS
            __block BOOL invalid=NO,nativeFailed=NO;
            BOOL handed=CSBackupPerformAtAccountEpoch(self.backupEpoch,^{
                // Keep native exceptions inside the account lock's handoff block.
                @try { if ([self valid]) CSMessageNativeInvoke(task,@"startUpload",@[]); else invalid=YES; }
                @catch (__unused NSException *exception) { nativeFailed=YES; }
            });
            if (nativeFailed) [self finish];
            else if (!handed || invalid) [self finish];
#else
            CSMessageNativeInvoke(task,@"startUpload",@[]);
#endif
        } @catch (__unused NSException *exception) { [self finish]; }
    }];
}
- (void)download {
    @try {
        id context=CSMessageActionNativeObject(NSClassFromString(@"MMContext"),@"currentContext"); id manager=[self.owner.environment serviceNamed:@"CMessageMgr"]; Protocol *protocol=objc_getProtocol("IDownloadImageExt");
        if (!protocol || !CSMessageNativeSupports(context,@"registerExtension:withTarget:",@"v",@[@"@",@"@"]) || !CSMessageNativeSupports(context,@"unRegisterExtension:withTarget:",@"v",@[@"@",@"@"]) || !CSMessageNativeSupports(manager,@"StartDownloadImage:HD:AutoDownload:SaveAlbum:Silent:",@"v",@[@"@",@"B",@"B",@"B",@"B"])) { [self finish]; return; }
        self.requestedDownload=YES; self.extensionContext=context; class_addProtocol(self.class,protocol);
        CSMessageNativeInvoke(context,@"registerExtension:withTarget:",@[(id)protocol,self]);
        if (![self valid]) { [self finish]; return; }
        CSMessageNativeInvoke(manager,@"StartDownloadImage:HD:AutoDownload:SaveAlbum:Silent:",@[self.context.sourceWrap,@NO,@NO,@NO,@YES]);
    } @catch (__unused NSException *exception) { [self finish]; }
}
- (BOOL)matchesDownload:(id)wrap {
    if (![self valid] || self.submitted || !self.requestedDownload) return NO;
    NSString *chat=CSMessageActionNativeObject(wrap,@"GetChatName"); if (![chat isEqual:self.context.sourceConversationID]) return NO;
    unsigned long long local=CSMessageNativeUnsigned(wrap,@"m_uiMesLocalID"),server=CSMessageNativeUnsigned(wrap,@"m_n64MesSvrID");
    if (server && self.context.serverID && server!=self.context.serverID) return NO;
    return (local && local==self.context.localID) || (server && server==self.context.serverID);
}
- (void)downloadResult:(id)wrap success:(BOOL)success { dispatch_async(dispatch_get_main_queue(),^{ if ([self matchesDownload:wrap]) { if (success) [self read]; else [self finish]; } }); }
- (void)OnDownloadImageOk:(id)wrap { [self downloadResult:wrap success:YES]; }
- (void)OnDownloadImageFail:(id)wrap { [self downloadResult:wrap success:NO]; }
- (void)OnDownloadImageExpired:(id)wrap { [self downloadResult:wrap success:NO]; }
- (void)OnDownloadImageStop:(id)wrap { [self downloadResult:wrap success:NO]; }
- (id)getPresetAddingItem { if (!self.addingItem) self.addingItem=[NSClassFromString(@"EmoticonCustomAddingItem") new]; return self.addingItem; }
- (BOOL)handleAddingItemAndShouldContinueUploading:(id)item { (void)item; return [self valid]; }
- (id)addlogicDelegate { return self; }
- (id)getViewController { return [self valid]?self.context.controller:nil; }
// WeChat owns all presentation; never substitute a plugin toast for a native result.
- (void)AddEmoticonFinishedWithWrap:(id)wrap IsSuccessed:(BOOL)success { (void)wrap; [self completeWithSuccess:success]; }
- (void)AddEmoticonFinishedWithWraps:(id)wraps sessionID:(id)sessionID {
    if (!NSThread.isMainThread) { dispatch_async(dispatch_get_main_queue(),^{ [self AddEmoticonFinishedWithWraps:wraps sessionID:sessionID]; }); return; }
    if (self.finished || self.completing) return;
    // Native passes MD5 -> result, including failures. Nonempty does not mean success.
    BOOL success=NO;
    @try {
        if ([wraps isKindOfClass:NSDictionary.class] && [wraps count]>0) {
            success=YES;
            for (id result in [(NSDictionary *)wraps allValues]) {
                if (!CSMessageNativeSupports(result,@"uploadSuccess",@"B",@[]) ||
                    ![CSMessageNativeInvoke(result,@"uploadSuccess",@[]) boolValue]) { success=NO; break; }
            }
        }
    } @catch (__unused NSException *exception) { success=NO; }
    [self completeWithSuccess:success];
}
- (void)onAddEmoticonPendingUploadWithWrap:(id)wrap { (void)wrap; [self finish]; }
- (void)AddEmoticonUploadedButExceedLimitWithWrap:(id)wrap { (void)wrap; [self finish]; }
@end
