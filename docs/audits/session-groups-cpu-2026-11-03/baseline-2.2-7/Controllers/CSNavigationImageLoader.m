#import "CSNavigationImageLoader.h"
#import <ImageIO/ImageIO.h>

@interface CSNavigationImageRequest ()
@property(nonatomic, readonly) BOOL cancelled;
- (void)installCancellation:(dispatch_block_t)block;
@end

@implementation CSNavigationImageBinding {
    CSNavigationImageRequest *_request;
    NSArray *_key;
    __weak UIImageView *_target;
    UIImage *_image;
    NSUInteger _generation;
}
- (void)displayURL:(NSURL *)url scope:(NSString *)scope identity:(NSArray *)identity
     maxPixelSize:(NSUInteger)maxPixelSize inImageView:(UIImageView *)imageView
        ifCurrent:(BOOL (^)(void))ifCurrent {
    if (!NSThread.isMainThread) return;
    if (!ifCurrent()) {
        [self cancel];imageView.image=[UIImage imageNamed:@"DefaultProfileHead_phone"];return;
    }
    NSArray *key=@[scope ?: @"",identity ?: @[],url.absoluteString ?: @"",@(maxPixelSize)];
    if (_target==imageView && [_key isEqual:key] && (_request || _image)) {
        if (_image) imageView.image=_image;
        return;
    }
    [self cancel];
    _key=key;_target=imageView;
    imageView.image=[UIImage imageNamed:@"DefaultProfileHead_phone"];
    if (!url || !scope.length) return;
    NSUInteger generation=_generation;
    __weak typeof(self) weakSelf=self;
    __weak UIImageView *weakTarget=imageView;
    _request=[CSNavigationImageLoader.sharedLoader loadURL:url fallbackFileURL:nil scope:scope maxPixelSize:maxPixelSize
        completion:^(UIImage *image,__unused NSURL *resolvedURL) {
            CSNavigationImageBinding *live=weakSelf;
            UIImageView *target=weakTarget;
            if (!live || generation!=live->_generation || ![key isEqual:live->_key] || target!=live->_target) return;
            live->_request=nil;
            if (image && target && ifCurrent()) { live->_image=image;target.image=image; }
        }];
}
- (void)cancel {
    _generation++;[_request cancel];_request=nil;_key=nil;_target=nil;_image=nil;
}
- (void)dealloc { [_request cancel]; }
@end
@implementation CSNavigationImageRequest {
    BOOL _cancelled;
    dispatch_block_t _cancellation;
}
- (BOOL)cancelled { @synchronized(self) { return _cancelled; } }
- (void)installCancellation:(dispatch_block_t)block {
    BOOL cancelled;
    @synchronized(self) { cancelled=_cancelled; if (!cancelled) _cancellation=[block copy]; }
    if (cancelled) block();
}
- (void)cancel {
    dispatch_block_t block;
    @synchronized(self) { _cancelled=YES; block=_cancellation; _cancellation=nil; }
    if (block) block();
}
- (void)dealloc { [self cancel]; }
@end

@interface CSNavigationImageFlight : NSObject
@property(nonatomic, strong) NSURLSessionDataTask *task;
@property(nonatomic, strong) NSMutableDictionary<NSString *,id> *subscribers;
@end
@implementation CSNavigationImageFlight @end

static NSArray *CSFileVersion(NSURL *url) {
    NSDictionary *attrs=url.isFileURL ? [NSFileManager.defaultManager attributesOfItemAtPath:url.path error:NULL] : nil;
    if (![attrs[NSFileType] isEqual:NSFileTypeRegular]) return nil;
    return @[attrs[NSFileSize] ?: @0,attrs[NSFileModificationDate] ?: @0,attrs[NSFileSystemFileNumber] ?: @0];
}
static UIImage *CSThumbnail(NSData *data,NSUInteger pixels) {
    if (!data.length) return nil;
    CGImageSourceRef source=CGImageSourceCreateWithData((__bridge CFDataRef)data,(__bridge CFDictionaryRef)@{(__bridge id)kCGImageSourceShouldCache:@NO});
    if (!source) return nil;
    CGImageRef cg=NULL;
    if (CGImageSourceGetStatus(source)==kCGImageStatusComplete) {
        cg=CGImageSourceCreateThumbnailAtIndex(source,0,(__bridge CFDictionaryRef)@{
            (__bridge id)kCGImageSourceCreateThumbnailFromImageAlways:@YES,
            (__bridge id)kCGImageSourceCreateThumbnailWithTransform:@YES,
            (__bridge id)kCGImageSourceThumbnailMaxPixelSize:@(pixels),
            (__bridge id)kCGImageSourceShouldCacheImmediately:@YES});
    }
    UIImage *image=cg ? [UIImage imageWithCGImage:cg scale:1 orientation:UIImageOrientationUp] : nil;
    if (cg) CGImageRelease(cg);
    CFRelease(source);return image;
}

@implementation CSNavigationImageLoader {
    dispatch_queue_t _queue;
    NSURLSession *_session;
    NSCache *_images;
    NSMutableDictionary<NSArray *,CSNavigationImageFlight *> *_flights;
    id _memoryObserver;
}
+ (instancetype)sharedLoader {
    static CSNavigationImageLoader *loader;static dispatch_once_t once;
    dispatch_once(&once, ^{
        NSURLSessionConfiguration *configuration=NSURLSessionConfiguration.defaultSessionConfiguration;
        configuration.timeoutIntervalForRequest=10;
        // The decoded cache is bounded below; avoid adding another disk cache for avatars.
        configuration.URLCache=nil;
        loader=[[self alloc] initWithSessionConfiguration:configuration];
    });return loader;
}
- (instancetype)init { return [self initWithSessionConfiguration:NSURLSessionConfiguration.defaultSessionConfiguration]; }
- (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration {
    if ((self=[super init])) {
        _queue=dispatch_queue_create("com.wechat.improve.navigation-images",DISPATCH_QUEUE_SERIAL);
        _session=[NSURLSession sessionWithConfiguration:configuration];
        _images=[NSCache new];_images.countLimit=128;_images.totalCostLimit=8*1024*1024;
        _flights=[NSMutableDictionary dictionary];
        __weak typeof(self) weakSelf=self;
        _memoryObserver=[NSNotificationCenter.defaultCenter addObserverForName:UIApplicationDidReceiveMemoryWarningNotification object:nil queue:nil usingBlock:^(__unused NSNotification *note) {
            CSNavigationImageLoader *live=weakSelf;
            if (live) dispatch_async(live->_queue, ^{ [live->_images removeAllObjects]; });
        }];
    }return self;
}
- (CSNavigationImageRequest *)loadURL:(NSURL *)url fallbackFileURL:(NSURL *)fallbackFileURL scope:(NSString *)scope
                        maxPixelSize:(NSUInteger)maxPixelSize completion:(void (^)(UIImage *,NSURL *))completion {
    CSNavigationImageRequest *request=[CSNavigationImageRequest new];
    NSUInteger pixels=MAX(16,MIN(512,maxPixelSize));
    NSString *account=[scope copy] ?: @"";
    __weak CSNavigationImageRequest *weakRequest=request;
    void (^deliver)(UIImage *,NSURL *)=^(UIImage *image,NSURL *resolved) {
        dispatch_async(dispatch_get_main_queue(), ^{
            CSNavigationImageRequest *live=weakRequest;
            if (live && !live.cancelled) completion(image,resolved);
        });
    };
    dispatch_async(_queue, ^{
        if (request.cancelled) return;
        NSURL *resolved=url;
        NSArray *version=CSFileVersion(resolved);
        if ((!resolved || resolved.isFileURL) && !version && fallbackFileURL.isFileURL) {
            resolved=fallbackFileURL;version=CSFileVersion(resolved);
        }
        BOOL remote=[@[@"https",@"http"] containsObject:resolved.scheme.lowercaseString];
        if (!resolved || (!remote && !version)) { deliver(nil,nil);return; }
        NSArray *key=@[account,resolved.absoluteString,@(pixels),version ?: @[]];
        NSDictionary *cached=[self->_images objectForKey:key];
        // Avatar URLs are usually versioned, but a stable URL must not stay stale for the app's lifetime.
        if (cached && (version || NSProcessInfo.processInfo.systemUptime-[cached[@"time"] doubleValue]<300)) {
            deliver(cached[@"image"],resolved);return;
        }
        if (cached) [self->_images removeObjectForKey:key];
        if (version) {
            NSData *data=[NSData dataWithContentsOfURL:resolved options:NSDataReadingMappedIfSafe error:NULL];
            UIImage *image=request.cancelled ? nil : CSThumbnail(data,pixels);
            if (![version isEqual:CSFileVersion(resolved)]) image=nil;
            if (image && !request.cancelled) [self cacheImage:image key:key];
            deliver(image,resolved);return;
        }
        NSString *subscriber=NSUUID.UUID.UUIDString;
        CSNavigationImageFlight *flight=self->_flights[key];
        BOOL start=!flight;
        if (start) { flight=[CSNavigationImageFlight new];flight.subscribers=[NSMutableDictionary dictionary];self->_flights[key]=flight; }
        flight.subscribers[subscriber]=[deliver copy];
        __weak typeof(self) weakSelf=self;
        __weak CSNavigationImageFlight *weakFlight=flight;
        [request installCancellation:^{
            CSNavigationImageLoader *live=weakSelf;
            if (!live) return;
            dispatch_async(live->_queue, ^{
                CSNavigationImageFlight *current=weakFlight;
                if (!current || live->_flights[key]!=current) return;
                [current.subscribers removeObjectForKey:subscriber];
                if (!current.subscribers.count) { [current.task cancel];[live->_flights removeObjectForKey:key]; }
            });
        }];
        if (!start) return;
        flight.task=[self->_session dataTaskWithURL:resolved completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
            CSNavigationImageLoader *live=weakSelf;
            if (!live) return;
            dispatch_async(live->_queue, ^{
                CSNavigationImageFlight *current=weakFlight;
                if (!current || live->_flights[key]!=current) return;
                NSInteger status=[response isKindOfClass:NSHTTPURLResponse.class] ? [(NSHTTPURLResponse *)response statusCode] : 0;
                UIImage *image=!error && status>=200 && status<300 ? CSThumbnail(data,pixels) : nil;
                if (image) [live cacheImage:image key:key];
                NSArray *callbacks=current.subscribers.allValues;
                [live->_flights removeObjectForKey:key];
                for (void (^callback)(UIImage *,NSURL *) in callbacks) callback(image,resolved);
            });
        }];
        [flight.task resume];
    });
    return request;
}
- (void)cacheImage:(UIImage *)image key:(NSArray *)key {
    CGImageRef cg=image.CGImage;
    if (cg) [_images setObject:@{@"image":image,@"time":@(NSProcessInfo.processInfo.systemUptime)} forKey:key cost:CGImageGetBytesPerRow(cg)*CGImageGetHeight(cg)];
}
- (void)dealloc {
    if (_memoryObserver) [NSNotificationCenter.defaultCenter removeObserver:_memoryObserver];
    [_session invalidateAndCancel];
}
@end
