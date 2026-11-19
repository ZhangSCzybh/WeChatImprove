#import "CSMomentsNativeMedia.h"
#import "CSCloseFriendSignatures.h"
#import <objc/message.h>
#import <objc/runtime.h>
#import <math.h>
#import <stdatomic.h>
#import <ImageIO/ImageIO.h>

// Protocol declarations preserve ARC's init-family ownership for dynamic classes.
@protocol CSMomentsNativeCoverConstructor <NSObject>
- (instancetype)initWithViewModel:(id)viewModel;
@end

@protocol CSMomentsNativeAvatarConstructor <NSObject>
- (instancetype)initWithUsrName:(nullable NSString *)username headImgUrl:(nullable NSString *)url
                   bAutoUpdate:(BOOL)autoUpdate bRoundCorner:(BOOL)roundCorner;
@end

static char CSMomentsOwnedCoverKey, CSMomentsCachedCoverKey;

@interface CSMomentsCachedCover : NSObject
@property(nonatomic, strong) id media;
@property(nonatomic, copy) NSString *key;
@property(nonatomic, strong) UIImageView *overlay;
@end
@implementation CSMomentsCachedCover
@end

@interface CSMomentsCachedImage : NSObject
@property(nonatomic, strong) UIImage *image;
@property(nonatomic) NSUInteger quality, cost;
@property(nonatomic) CGSize pixels;
@property(nonatomic, copy) NSString *fingerprint;
@end
@implementation CSMomentsCachedImage
@end

@interface CSMomentsViewedMedia : NSObject
@property(nonatomic) NSTimeInterval lastCycle;
@property(nonatomic, strong) NSDictionary<NSNumber *, NSString *> *failedFiles;
@property(nonatomic, strong) NSDictionary<NSNumber *, NSString *> *localPaths;
@end
@implementation CSMomentsViewedMedia
@end

@interface CSMomentsCachedRequest : NSObject {
@public _Atomic(BOOL) cancelled;
}
@property(nonatomic, strong) id media;
@property(nonatomic, copy) NSString *key;
@property(nonatomic) NSUInteger generation, attempt;
@property(nonatomic) NSTimeInterval started;
@property(nonatomic) BOOL timerPending, completionPending, extraCompletionRead;
@end
@implementation CSMomentsCachedRequest
@end

@interface CSMomentsDisplayObservation : NSObject
@property(nonatomic, weak) UIView *view;
@property(nonatomic, weak) UIImage *image;
@property(nonatomic, strong) id payload, media;
@property(nonatomic, copy) NSString *key;
@property(nonatomic) NSUInteger generation, attempt;
@property(nonatomic) BOOL finished;
@end
@implementation CSMomentsDisplayObservation
@end

static NSHashTable<UIView *> *CachedCovers;
static NSMutableDictionary<NSString *, CSMomentsCachedImage *> *CachedImages;
static NSMutableArray<NSString *> *CachedImageOrder, *ViewedMediaOrder;
static NSMutableDictionary<NSString *, CSMomentsViewedMedia *> *ViewedMedia;
static NSMutableDictionary<NSString *, CSMomentsCachedRequest *> *MediaRequests;
static NSMutableOrderedSet<NSString *> *PendingMedia;
static NSMapTable<UIView *, CSMomentsDisplayObservation *> *DisplayObservations;
static NSUInteger CachedImageBytes;
static _Atomic(NSUInteger) CacheGeneration;
static BOOL CacheRefreshScheduled, CacheReadInFlight, CachedMediaActive = YES;
static dispatch_queue_t CacheDecodeQueue;
static const NSUInteger CSMomentsImageBudget = 48 * 1024 * 1024;
static const NSUInteger CSMomentsEncodedLimit = 16 * 1024 * 1024;

static void CSMomentsRegisterCover(UIView *cover, id media);
static void CSMomentsScheduleCachedMedia(id media);
static void CSMomentsDropUnusedMedia(NSString *key);

static BOOL CSMomentsInstanceMethod(Class cls, SEL selector, const char *types) {
    return cls && CSCloseFriendMethodMatches(class_getInstanceMethod(cls, selector), types);
}

UIView *CSMomentsCreateCoverView(id dataItem, id mediaItem) {
    if (!NSThread.isMainThread) return nil;
    Class dataClass = NSClassFromString(@"WCDataItem");
    Class mediaClass = NSClassFromString(@"WCMediaItem");
    Class modelClass = NSClassFromString(@"WCImageViewModel");
    Class viewClass = NSClassFromString(@"WCImageView");
    SEL factory = NSSelectorFromString(@"centerSmall:");
    SEL setData = NSSelectorFromString(@"setDataItem:");
    SEL initialize = NSSelectorFromString(@"initWithViewModel:");
    SEL unsubscribe = NSSelectorFromString(@"unsubscribeAll");
    if (!dataClass || !mediaClass || !modelClass || ![dataItem isKindOfClass:dataClass] ||
        ![mediaItem isKindOfClass:mediaClass] || ![viewClass isSubclassOfClass:UIView.class] ||
        !CSCloseFriendMethodMatches(class_getClassMethod(modelClass, factory), "@@:@") ||
        !CSMomentsInstanceMethod(modelClass, setData, "v@:@") ||
        !CSMomentsInstanceMethod(viewClass, initialize, "@@:@") ||
        !CSMomentsInstanceMethod(viewClass, unsubscribe, "v@:")) return nil;

    UIView *cover = nil;
    @try {
        // The native centered factory uses style 1, which configures its internal
        // UIImageView for aspect fill and clipping. The outer view's contentMode
        // cannot configure that child when a tall cover is cropped by the card.
        id model = ((id (*)(id, SEL, id))objc_msgSend)(modelClass, factory, mediaItem);
        if (![model isKindOfClass:modelClass] ||
            !CSMomentsInstanceMethod(object_getClass(model), setData, "v@:@")) return nil;
        ((void (*)(id, SEL, id))objc_msgSend)(model, setData, dataItem);
        id<CSMomentsNativeCoverConstructor> allocated = [viewClass alloc];
        id initialized = [allocated initWithViewModel:model];
        if (![initialized isKindOfClass:viewClass]) return nil;
        cover = initialized;
        objc_setAssociatedObject(cover, &CSMomentsOwnedCoverKey, @YES, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        // The card owns taps; native image loading and cache subscriptions remain active.
        cover.userInteractionEnabled = NO;
        cover.clipsToBounds = YES;
        CSMomentsRegisterCover(cover, mediaItem);
        return cover;
    } @catch (__unused NSException *exception) {
        CSMomentsReleaseCoverView(cover);
        return nil;
    }
}

UIView *CSMomentsCreateAvatarView(NSString *username, CGSize size) {
    if (!NSThread.isMainThread || ![username isKindOfClass:NSString.class] || !username.length ||
        !isfinite(size.width) || !isfinite(size.height) || size.width <= 0 || size.height <= 0) return nil;
    Class avatarClass = NSClassFromString(@"MMHeadImageView");
    SEL initialize = NSSelectorFromString(@"initWithUsrName:headImgUrl:bAutoUpdate:bRoundCorner:");
    SEL setSize = NSSelectorFromString(@"setImageSize:");
    SEL updateUser = NSSelectorFromString(@"updateUsrName:withHeadImgUrl:");
    if (![avatarClass isSubclassOfClass:UIView.class] ||
        !CSMomentsInstanceMethod(avatarClass, initialize, "@@:@@BB") ||
        !CSMomentsInstanceMethod(avatarClass, setSize, "v@:{CGSize=dd}") ||
        !CSMomentsInstanceMethod(avatarClass, updateUser, "v@:@@")) return nil;
    @try {
        id<CSMomentsNativeAvatarConstructor> allocated = [avatarClass alloc];
        // Native init leaves imageSize at zero and does not load the image. Start
        // empty so updateUsrName: cannot take its same-user early return.
        id initialized = [allocated initWithUsrName:nil headImgUrl:nil bAutoUpdate:YES bRoundCorner:YES];
        if (![initialized isKindOfClass:avatarClass]) return nil;
        UIView *avatar = initialized;
        avatar.frame = (CGRect){CGPointZero, size};
        ((void (*)(id, SEL, CGSize))objc_msgSend)(avatar, setSize, size);
        // A nil URL is supported: WeChat resolves the cached head by username and
        // starts its own MMHeadImageMgr update/subscription path when needed.
        ((void (*)(id, SEL, id, id))objc_msgSend)(avatar, updateUser, username, nil);
        avatar.userInteractionEnabled = NO;
        avatar.clipsToBounds = YES;
        [avatar setNeedsLayout];
        return avatar;
    } @catch (__unused NSException *exception) {
        return nil;
    }
}

CGSize CSMomentsNativeMediaSize(id mediaItem) {
    if (!NSThread.isMainThread) return CGSizeZero;
    Class mediaClass = NSClassFromString(@"WCMediaItem");
    SEL sizeSelector = NSSelectorFromString(@"imgSize");
    if (!mediaClass || ![mediaItem isKindOfClass:mediaClass] ||
        !CSMomentsInstanceMethod(object_getClass(mediaItem), sizeSelector, "{CGSize=dd}@:")) return CGSizeZero;
    @try {
        CGSize size = ((CGSize (*)(id, SEL))objc_msgSend)(mediaItem, sizeSelector);
        if (isfinite(size.width) && isfinite(size.height) && size.width > 0 && size.height > 0) return size;
    } @catch (__unused NSException *exception) {}
    return CGSizeZero;
}

void CSMomentsReleaseCoverView(UIView *view) {
    if (!view) return;
    if (!NSThread.isMainThread) {
        dispatch_async(dispatch_get_main_queue(), ^{ CSMomentsReleaseCoverView(view); });
        return;
    }
    if (!objc_getAssociatedObject(view, &CSMomentsOwnedCoverKey)) return;
    objc_setAssociatedObject(view, &CSMomentsOwnedCoverKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    CSMomentsCachedCover *cached = objc_getAssociatedObject(view, &CSMomentsCachedCoverKey);
    [cached.overlay removeFromSuperview];
    objc_setAssociatedObject(view, &CSMomentsCachedCoverKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [CachedCovers removeObject:view];
    CSMomentsDropUnusedMedia(cached.key);
    SEL unsubscribe = NSSelectorFromString(@"unsubscribeAll");
    if (!CSMomentsInstanceMethod(object_getClass(view), unsubscribe, "v@:")) return;
    @try {
        ((void (*)(id, SEL))objc_msgSend)(view, unsubscribe);
    } @catch (__unused NSException *exception) {}
}

static void CSMomentsEnsureImageCache(void) {
    if (CachedCovers) return;
    CachedCovers = [NSHashTable weakObjectsHashTable];
    CachedImages = [NSMutableDictionary new];
    CachedImageOrder = [NSMutableArray new];
    ViewedMedia = [NSMutableDictionary new];
    ViewedMediaOrder = [NSMutableArray new];
    MediaRequests = [NSMutableDictionary new];
    PendingMedia = [NSMutableOrderedSet new];
    DisplayObservations = [NSMapTable weakToStrongObjectsMapTable];
    CacheDecodeQueue = dispatch_queue_create("com.wechat.improve.moments.cached-images", DISPATCH_QUEUE_SERIAL);
}

static id CSMomentsMediaObject(id object, NSString *name) {
    SEL selector = NSSelectorFromString(name);
    return CSMomentsInstanceMethod(object_getClass(object), selector, "@@:")
        ? ((id (*)(id, SEL))objc_msgSend)(object, selector) : nil;
}

static NSString *CSMomentsMediaCacheKey(id media) {
    Class cls = NSClassFromString(@"WCMediaItem");
    if (!cls || ![media isKindOfClass:cls]) return nil;
    id key = CSMomentsMediaObject(media, @"mediaID");
    return [key isKindOfClass:NSString.class] && [key length] ? key : nil;
}

static BOOL CSMomentsHasOwnedCover(NSString *key) {
    for (UIView *cover in CachedCovers.allObjects) {
        CSMomentsCachedCover *state = objc_getAssociatedObject(cover, &CSMomentsCachedCoverKey);
        if ([state.key isEqual:key] && objc_getAssociatedObject(cover, &CSMomentsOwnedCoverKey)) return YES;
    }
    return NO;
}

static void CSMomentsRemoveCachedImage(NSString *key) {
    if (!key.length) return;
    CSMomentsCachedImage *entry = CachedImages[key];
    CachedImageBytes -= MIN(CachedImageBytes, entry.cost);
    [CachedImages removeObjectForKey:key];
    [CachedImageOrder removeObject:key];
    // Eviction also releases every overlay's strong image reference. Native
    // thumbnails remain underneath, including during memory-budget fallback.
    for (UIView *cover in CachedCovers.allObjects) {
        CSMomentsCachedCover *state = objc_getAssociatedObject(cover, &CSMomentsCachedCoverKey);
        if (![state.key isEqual:key]) continue;
        state.overlay.image = nil;
        [state.overlay removeFromSuperview];
        state.overlay = nil;
    }
}

static void CSMomentsCancelRequest(NSString *key) {
    CSMomentsCachedRequest *request = MediaRequests[key];
    if (request) atomic_store_explicit(&request->cancelled, YES, memory_order_release);
    [MediaRequests removeObjectForKey:key];
    [PendingMedia removeObject:key];
}

static void CSMomentsDropUnusedMedia(NSString *key) {
    if (!key.length || CSMomentsHasOwnedCover(key)) return;
    CSMomentsCancelRequest(key);
    CSMomentsRemoveCachedImage(key);
}

static BOOL CSMomentsRequestValid(CSMomentsCachedRequest *request) {
    return request && !atomic_load_explicit(&request->cancelled, memory_order_acquire) &&
        request.generation == atomic_load_explicit(&CacheGeneration, memory_order_acquire);
}

static void CSMomentsApplyCachedImage(NSString *key, CSMomentsCachedImage *entry) {
    if (!CachedMediaActive || ![entry.image isKindOfClass:UIImage.class] || CachedImages[key] != entry) return;
    [CachedImageOrder removeObject:key];
    [CachedImageOrder addObject:key];
    for (UIView *cover in CachedCovers.allObjects) {
        CSMomentsCachedCover *state = objc_getAssociatedObject(cover, &CSMomentsCachedCoverKey);
        if (![state.key isEqual:key] || !objc_getAssociatedObject(cover, &CSMomentsOwnedCoverKey)) continue;
        if (!state.overlay) {
            UIImageView *overlay = [UIImageView new];
            overlay.frame = cover.bounds;
            overlay.contentMode = (UIViewContentMode)2;
            overlay.clipsToBounds = YES;
            overlay.userInteractionEnabled = NO;
            SEL autoresize = NSSelectorFromString(@"setAutoresizingMask:");
            if (CSMomentsInstanceMethod(object_getClass(overlay), autoresize, "v@:Q"))
                ((void (*)(id, SEL, NSUInteger))objc_msgSend)(overlay, autoresize, 2 | 16);
            state.overlay = overlay;
            [cover addSubview:overlay];
        }
        state.overlay.image = entry.image;
        // The native image view continues to own its thumbnail. Only the
        // plugin-owned overlay is raised; native view/model data is untouched.
        SEL raise = NSSelectorFromString(@"bringSubviewToFront:");
        if (CSMomentsInstanceMethod(object_getClass(cover), raise, "v@:@"))
            ((void (*)(id, SEL, id))objc_msgSend)(cover, raise, state.overlay);
    }
}

static void CSMomentsStoreCachedImage(NSString *key, CSMomentsCachedImage *entry) {
    if (!entry || !entry.cost || entry.cost > CSMomentsImageBudget) return;
    if (CachedImages[key] == entry) { CSMomentsApplyCachedImage(key, entry); return; }
    CSMomentsRemoveCachedImage(key);
    while (CachedImageOrder.count && (CachedImages.count >= 8 || CachedImageBytes + entry.cost > CSMomentsImageBudget))
        CSMomentsRemoveCachedImage(CachedImageOrder.firstObject);
    CachedImages[key] = entry;
    CachedImageBytes += entry.cost;
    CSMomentsApplyCachedImage(key, entry);
}

static CGFloat CSMomentsDisplayScale(void) {
    Class screenClass = NSClassFromString(@"UIScreen");
    SEL main = NSSelectorFromString(@"mainScreen"), scale = NSSelectorFromString(@"scale");
    if (CSCloseFriendMethodMatches(class_getClassMethod(screenClass, main), "@@:")) {
        id screen = ((id (*)(id, SEL))objc_msgSend)(screenClass, main);
        if (CSMomentsInstanceMethod(object_getClass(screen), scale, "d@:")) {
            CGFloat value = ((CGFloat (*)(id, SEL))objc_msgSend)(screen, scale);
            if (isfinite(value) && value >= 1 && value <= 4) return value;
        }
    }
    return 3;
}

static CGSize CSMomentsRequiredPixels(NSString *key) {
    CGSize size = CGSizeZero;
    CGFloat scale = CSMomentsDisplayScale();
    for (UIView *cover in CachedCovers.allObjects) {
        CSMomentsCachedCover *state = objc_getAssociatedObject(cover, &CSMomentsCachedCoverKey);
        if (![state.key isEqual:key] || !objc_getAssociatedObject(cover, &CSMomentsOwnedCoverKey)) continue;
        CGSize bounds = cover.bounds.size;
        if (!isfinite(bounds.width) || !isfinite(bounds.height)) continue;
        size.width = MAX(size.width, ceil(bounds.width * scale));
        size.height = MAX(size.height, ceil(bounds.height * scale));
    }
    return size;
}

static CGImageRef CSMomentsImagePixels(UIImage *image) {
    SEL selector = NSSelectorFromString(@"CGImage");
    NSString *types = [NSString stringWithFormat:@"%s@:", @encode(CGImageRef)];
    return [image isKindOfClass:UIImage.class] && CSMomentsInstanceMethod(object_getClass(image), selector, types.UTF8String)
        ? ((CGImageRef (*)(id, SEL))objc_msgSend)(image, selector) : NULL;
}

static BOOL CSMomentsPixelsCover(CGSize pixels, CGSize demand) {
    return demand.width > 0 && demand.height > 0 && pixels.width >= demand.width && pixels.height >= demand.height;
}

static CSMomentsCachedImage *CSMomentsReadLocalImage(CSMomentsCachedRequest *request, CGSize demand,
    CSMomentsCachedImage *cached, NSDictionary<NSNumber *, NSString *> *paths,
    NSMutableDictionary<NSNumber *, NSString *> *failedFiles) {
    if (!CSMomentsRequestValid(request) || !CSMomentsPixelsCover(CGSizeMake(2048, 2048), demand)) return nil;
    for (NSUInteger quality = 4; quality >= 2; quality--) {
        if (!CSMomentsRequestValid(request)) return nil;
        // A file disappearing from the native cache cannot lower an image
        // already retained for this card when its real pixels still suffice.
        if (cached.quality > quality && CSMomentsPixelsCover(cached.pixels, demand)) return cached;
        id value = paths[@(quality)];
        if (![value isKindOfClass:NSString.class] || ![value length]) continue;
        NSString *path = value;
        NSDictionary *attributes = [NSFileManager.defaultManager attributesOfItemAtPath:path error:NULL];
        unsigned long long length = [attributes[NSFileSize] unsignedLongLongValue];
        if (!length || length > CSMomentsEncodedLimit) continue;
        NSString *fingerprint = [NSString stringWithFormat:@"%@/%llu/%.6f", path, length, [attributes[NSFileModificationDate] timeIntervalSince1970]];
        if (cached.quality == quality && [cached.fingerprint isEqual:fingerprint] && CSMomentsPixelsCover(cached.pixels, demand)) return cached;
        NSString *failure = [fingerprint stringByAppendingFormat:@"/%.0fx%.0f", demand.width, demand.height];
        if ([failedFiles[@(quality)] isEqual:failure]) continue;
        // Only paths already returned by WeChat in this viewed session reach
        // this snapshot. Do not call native getters: cold initialization may
        // create directories or change native cache backup attributes.
        NSData *data = [NSData dataWithContentsOfFile:path options:NSDataReadingMappedIfSafe error:NULL];
        if (!data.length || data.length > CSMomentsEncodedLimit || !CSMomentsRequestValid(request)) continue;
        CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data,
            (__bridge CFDictionaryRef)@{(__bridge NSString *)kCGImageSourceShouldCache:@NO});
        if (!source) { failedFiles[@(quality)] = failure; continue; }
        NSDictionary *properties = CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(source, 0, NULL));
        double width = [properties[(__bridge NSString *)kCGImagePropertyPixelWidth] doubleValue];
        double height = [properties[(__bridge NSString *)kCGImagePropertyPixelHeight] doubleValue];
        NSUInteger orientation = [properties[(__bridge NSString *)kCGImagePropertyOrientation] unsignedIntegerValue];
        if (orientation >= 5 && orientation <= 8) { double swap = width; width = height; height = swap; }
        CGSize original = CGSizeMake(width, height);
        if (!isfinite(width) || !isfinite(height) || width <= 0 || height <= 0 || width * height > 100000000 ||
            !CSMomentsPixelsCover(original, demand)) {
            CFRelease(source); failedFiles[@(quality)] = failure; continue;
        }
        // Decode only the display-sized derivative. AspectFill cannot add
        // pixels, so the derivative must cover both actual display dimensions.
        CGFloat maximum = MIN(2048, ceil(MAX(demand.width * MAX(width, height) / width,
            demand.height * MAX(width, height) / height)));
        CGImageRef pixels = CSMomentsRequestValid(request) ? CGImageSourceCreateThumbnailAtIndex(source, 0,
            (__bridge CFDictionaryRef)@{(__bridge NSString *)kCGImageSourceCreateThumbnailFromImageAlways:@YES,
                (__bridge NSString *)kCGImageSourceCreateThumbnailWithTransform:@YES, (__bridge NSString *)kCGImageSourceShouldCache:@NO,
                (__bridge NSString *)kCGImageSourceShouldCacheImmediately:@YES, (__bridge NSString *)kCGImageSourceThumbnailMaxPixelSize:@(maximum)}) : NULL;
        CFRelease(source);
        if (!pixels) { failedFiles[@(quality)] = failure; continue; }
        CGSize size = CGSizeMake(CGImageGetWidth(pixels), CGImageGetHeight(pixels));
        NSUInteger cost = (NSUInteger)size.width * (NSUInteger)size.height * 4;
        CGImageRef raster = NULL;
        if (CSMomentsRequestValid(request) && CSMomentsPixelsCover(size, demand) && size.width <= 2048 && size.height <= 2048 &&
            cost > 0 && cost <= 16 * 1024 * 1024) {
            CGColorSpaceRef color = CGColorSpaceCreateDeviceRGB();
            CGContextRef context = CGBitmapContextCreate(NULL, (size_t)size.width, (size_t)size.height, 8,
                (size_t)size.width * 4, color, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
            CGColorSpaceRelease(color);
            if (context) {
                CGContextDrawImage(context, (CGRect){CGPointZero, size}, pixels);
                raster = CGBitmapContextCreateImage(context);
                CGContextRelease(context);
            }
        }
        CGImageRelease(pixels);
        SEL factory = NSSelectorFromString(@"imageWithCGImage:scale:orientation:");
        NSString *types = [NSString stringWithFormat:@"@@:%sdq", @encode(CGImageRef)];
        UIImage *image = nil;
        if (raster && CSMomentsRequestValid(request) && CSCloseFriendMethodMatches(class_getClassMethod(UIImage.class, factory), types.UTF8String))
            image = ((id (*)(id, SEL, CGImageRef, CGFloat, NSInteger))objc_msgSend)(UIImage.class, factory, raster, 1, 0);
        if (raster) CGImageRelease(raster);
        if (![image isKindOfClass:UIImage.class]) { failedFiles[@(quality)] = failure; continue; }
        CSMomentsCachedImage *entry = [CSMomentsCachedImage new];
        entry.image = image; entry.quality = quality; entry.cost = cost;
        entry.pixels = size; entry.fingerprint = fingerprint;
        [failedFiles removeObjectForKey:@(quality)];
        return entry;
    }
    return CSMomentsPixelsCover(cached.pixels, demand) ? cached : nil;
}

static void CSMomentsFlushCachedMedia(void);
static void CSMomentsScheduleRequest(CSMomentsCachedRequest *request) {
    if (!CachedMediaActive || !CSMomentsRequestValid(request) || request.timerPending) return;
    BOOL extra = request.attempt >= 3;
    if (extra && (!request.completionPending || request.extraCompletionRead)) return;
    if (extra) request.extraCompletionRead = YES;
    const NSTimeInterval deadlines[] = {0.3, 0.8, 1.6};
    NSTimeInterval delay = extra ? 0.08 : MAX(0.03,
        request.started + deadlines[request.attempt] - NSDate.timeIntervalSinceReferenceDate);
    request.timerPending = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!CachedMediaActive || !CSMomentsRequestValid(request) || MediaRequests[request.key] != request) return;
        request.timerPending = NO;
        [PendingMedia addObject:request.key];
        CSMomentsFlushCachedMedia();
    });
}

static void CSMomentsFlushCachedMedia(void) {
    CacheRefreshScheduled = NO;
    if (!CachedMediaActive || CacheReadInFlight) return;
    while (PendingMedia.count) {
        NSString *key = PendingMedia.firstObject;
        [PendingMedia removeObject:key];
        CSMomentsCachedRequest *request = MediaRequests[key];
        if (!CSMomentsRequestValid(request) || !ViewedMedia[key] || !CSMomentsHasOwnedCover(key)) { CSMomentsCancelRequest(key); continue; }
        CGSize demand = CSMomentsRequiredPixels(key);
        request.attempt++;
        request.completionPending = NO;
        // Workers carry metadata only. Removing the final cover can release
        // every old raster immediately, even while another file is decoded.
        CSMomentsCachedImage *current = CachedImages[key], *cached = [CSMomentsCachedImage new];
        cached.quality = current.quality; cached.cost = current.cost;
        cached.pixels = current.pixels;
        cached.fingerprint = current.fingerprint;
        NSDictionary *paths = [ViewedMedia[key].localPaths copy];
        NSMutableDictionary *failures = [ViewedMedia[key].failedFiles mutableCopy] ?: [NSMutableDictionary new];
        CacheReadInFlight = YES;
        dispatch_async(CacheDecodeQueue, ^{
            @autoreleasepool {
                CSMomentsCachedImage *result = nil;
                @try { result = CSMomentsReadLocalImage(request, demand, cached, paths, failures); }
                @catch (__unused NSException *exception) {}
                dispatch_async(dispatch_get_main_queue(), ^{
                    CacheReadInFlight = NO;
                    if (CachedMediaActive && CSMomentsRequestValid(request) && MediaRequests[key] == request &&
                        ViewedMedia[key] && CSMomentsHasOwnedCover(key)) {
                        ViewedMedia[key].failedFiles = failures.copy;
                        CSMomentsCachedImage *ready = result;
                        if (ready && !ready.image) {
                            CSMomentsCachedImage *retained = CachedImages[key];
                            ready = retained.quality == ready.quality &&
                                [retained.fingerprint isEqual:ready.fingerprint] &&
                                CSMomentsPixelsCover(retained.pixels, demand) ? retained : nil;
                        }
                        CSMomentsCachedImage *retained = CachedImages[key];
                        if (retained.quality > ready.quality && CSMomentsPixelsCover(retained.pixels, demand)) ready = retained;
                        if (ready) CSMomentsStoreCachedImage(key, ready);
                        if ((request.attempt < 3 && ready.quality < 4) ||
                            (request.completionPending && !request.extraCompletionRead)) CSMomentsScheduleRequest(request);
                        else CSMomentsCancelRequest(key);
                    }
                    // Point updates are spread across frames, even when many
                    // native completion callbacks arrive together on resume.
                    if (PendingMedia.count && !CacheRefreshScheduled) {
                        CacheRefreshScheduled = YES;
                        NSUInteger generation = atomic_load_explicit(&CacheGeneration, memory_order_acquire);
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.08 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            if (generation == atomic_load_explicit(&CacheGeneration, memory_order_acquire)) CSMomentsFlushCachedMedia();
                        });
                    }
                });
            }
        });
        break;
    }
}

static void CSMomentsScheduleCachedMedia(id media) {
    if (!CachedMediaActive) return;
    @try {
        NSString *key = CSMomentsMediaCacheKey(media);
        CSMomentsViewedMedia *viewed = ViewedMedia[key];
        if (!key.length || !viewed || !CSMomentsHasOwnedCover(key) || MediaRequests[key]) return;
        NSTimeInterval now = NSDate.timeIntervalSinceReferenceDate;
        if (now - viewed.lastCycle < 1.6 || MediaRequests.count >= 64) return;
        viewed.lastCycle = now;
        CSMomentsCachedRequest *request = [CSMomentsCachedRequest new];
        request.media = media; request.key = key;
        request.generation = atomic_load_explicit(&CacheGeneration, memory_order_acquire);
        request.started = now;
        MediaRequests[key] = request;
        CSMomentsScheduleRequest(request);
    } @catch (__unused NSException *exception) {}
}

static void CSMomentsRegisterCover(UIView *cover, id media) {
    NSString *key = CSMomentsMediaCacheKey(media);
    if (!key.length) return;
    CSMomentsEnsureImageCache();
    CSMomentsCachedCover *state = [CSMomentsCachedCover new];
    state.media = media; state.key = key;
    objc_setAssociatedObject(cover, &CSMomentsCachedCoverKey, state, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [CachedCovers addObject:cover];
    if (ViewedMedia[key]) {
        CSMomentsApplyCachedImage(key, CachedImages[key]);
        // A viewer may have been observed while no card was retained. Returning
        // to this card is another bounded local-file check, never a download.
        ViewedMedia[key].lastCycle = 0;
        CSMomentsScheduleCachedMedia(media);
    }
}

void CSMomentsNativeMediaDidDownload(id mediaItem) {
    if (!mediaItem) return;
    if (!NSThread.isMainThread) {
        dispatch_async(dispatch_get_main_queue(), ^{ CSMomentsNativeMediaDidDownload(mediaItem); });
        return;
    }
    @try {
        NSString *key = CSMomentsMediaCacheKey(mediaItem);
        CSMomentsCachedRequest *request = MediaRequests[key];
        if (request) request.completionPending = YES;
        else CSMomentsScheduleCachedMedia(mediaItem);
    } @catch (__unused NSException *exception) {}
}

void CSMomentsNativeMediaDidResolveLocalPath(id mediaItem, NSUInteger quality, NSString *path) {
    if (!NSThread.isMainThread || !CachedMediaActive || quality < 2 || quality > 4 ||
        ![path isKindOfClass:NSString.class] || !path.length || !path.isAbsolutePath) return;
    @try {
        NSString *key = CSMomentsMediaCacheKey(mediaItem);
        CSMomentsViewedMedia *viewed = key.length ? ViewedMedia[key] : nil;
        if (!viewed) return;
        if ([viewed.localPaths[@(quality)] isEqual:path]) return;
        // ViewedMedia is session-scoped and bounded to 256 native media IDs;
        // each entry retains at most these three native-returned path strings.
        NSMutableDictionary *paths = [viewed.localPaths mutableCopy] ?: [NSMutableDictionary new];
        paths[@(quality)] = [path copy];
        viewed.localPaths = paths.copy;
        if (viewed.failedFiles[@(quality)]) {
            NSMutableDictionary *failures = [viewed.failedFiles mutableCopy];
            [failures removeObjectForKey:@(quality)];
            viewed.failedFiles = failures.copy;
        }
        CSMomentsCachedRequest *request = MediaRequests[key];
        if (request) request.completionPending = YES;
        else CSMomentsScheduleCachedMedia(mediaItem);
    } @catch (__unused NSException *exception) {}
}

static BOOL CSMomentsVisibleNativeView(UIView *view) {
    UIView *window = view.window;
    if (!window || view.bounds.size.width <= 0 || view.bounds.size.height <= 0) return NO;
    CGRect full = [view convertRect:view.bounds toView:window], visible = full;
    for (UIView *ancestor = view; ancestor; ancestor = ancestor.superview) {
        if (ancestor.hidden || ancestor.alpha <= 0.01) return NO;
        if (ancestor.clipsToBounds || ancestor == window)
            visible = CGRectIntersection(visible, [ancestor convertRect:ancestor.bounds toView:window]);
    }
    CGFloat area = full.size.width * full.size.height;
    return isfinite(area) && area > 0 && !CGRectIsNull(visible) &&
        visible.size.width * visible.size.height / area >= 0.6;
}

static id CSMomentsCurrentDisplayedMedia(UIView *view, id payload, UIImage *image) {
    Class scroll = NSClassFromString(@"WCMediaImageScrollView");
    Class container = NSClassFromString(@"WCImageFullScreenViewContainer");
    if (scroll && [view isKindOfClass:scroll]) {
        Class model = NSClassFromString(@"WCMediaImageViewModel_WCMediaItem");
        if (!model || ![payload isKindOfClass:model] || CSMomentsMediaObject(view, @"viewModel") != payload ||
            CSMomentsMediaObject(CSMomentsMediaObject(view, @"imageMaterial"), @"image") != image) return nil;
        return CSMomentsMediaObject(payload, @"mediaItem");
    }
    if (container && [view isKindOfClass:container]) {
        id imageView = CSMomentsMediaObject(view, @"m_container");
        if (![imageView isKindOfClass:UIImageView.class] || CSMomentsMediaObject(imageView, @"image") != image ||
            CSMomentsMediaObject(view, @"m_mediaData") != payload || !CSMomentsVisibleNativeView(imageView)) return nil;
        return payload;
    }
    return nil;
}

static void CSMomentsCheckDisplay(CSMomentsDisplayObservation *observation) {
    if (!CachedMediaActive || observation.finished || observation.generation != atomic_load_explicit(&CacheGeneration, memory_order_acquire) ||
        !observation.view || [DisplayObservations objectForKey:observation.view] != observation) return;
    UIImage *image = observation.image;
    CGImageRef pixels = CSMomentsImagePixels(image);
    id media = image && pixels && CGImageGetWidth(pixels) && CGImageGetHeight(pixels)
        ? CSMomentsCurrentDisplayedMedia(observation.view, observation.payload, image) : nil;
    if (media && media == observation.media && [CSMomentsMediaCacheKey(media) isEqual:observation.key] &&
        CSMomentsVisibleNativeView(observation.view)) {
        observation.finished = YES;
        [DisplayObservations removeObjectForKey:observation.view];
        [ViewedMediaOrder removeObject:observation.key];
        [ViewedMediaOrder addObject:observation.key];
        if (!ViewedMedia[observation.key]) ViewedMedia[observation.key] = [CSMomentsViewedMedia new];
        while (ViewedMediaOrder.count > 256) {
            NSString *oldest = ViewedMediaOrder.firstObject;
            CSMomentsCancelRequest(oldest); CSMomentsRemoveCachedImage(oldest);
            [ViewedMedia removeObjectForKey:oldest]; [ViewedMediaOrder removeObjectAtIndex:0];
        }
        ViewedMedia[observation.key].lastCycle = 0;
        CSMomentsScheduleCachedMedia(media);
        return;
    }
    if (observation.attempt >= 3) { [DisplayObservations removeObjectForKey:observation.view]; return; }
    const NSTimeInterval delays[] = {0.3, 0.5, 0.8};
    NSTimeInterval delay = delays[observation.attempt++];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ CSMomentsCheckDisplay(observation); });
}

void CSMomentsNativeMediaDidDisplay(UIView *nativeView, id payload, UIImage *image) {
    if (!NSThread.isMainThread || !CachedMediaActive || ![nativeView isKindOfClass:UIView.class] || ![image isKindOfClass:UIImage.class]) return;
    @try {
        Class scroll = NSClassFromString(@"WCMediaImageScrollView"), container = NSClassFromString(@"WCImageFullScreenViewContainer");
        id media = nil;
        if (scroll && [nativeView isKindOfClass:scroll]) {
            Class model = NSClassFromString(@"WCMediaImageViewModel_WCMediaItem");
            if (model && [payload isKindOfClass:model]) media = CSMomentsMediaObject(payload, @"mediaItem");
        } else if (container && [nativeView isKindOfClass:container]) media = payload;
        NSString *key = CSMomentsMediaCacheKey(media);
        if (!key.length) return;
        CSMomentsEnsureImageCache();
        if (DisplayObservations.count >= 8 && ![DisplayObservations objectForKey:nativeView]) return;
        CSMomentsDisplayObservation *observation = [CSMomentsDisplayObservation new];
        observation.view = nativeView; observation.payload = payload; observation.media = media; observation.image = image;
        observation.key = key; observation.generation = atomic_load_explicit(&CacheGeneration, memory_order_acquire);
        [DisplayObservations setObject:observation forKey:nativeView];
        CSMomentsCheckDisplay(observation);
    } @catch (__unused NSException *exception) {}
}

void CSMomentsNativeMediaSetActive(BOOL active) {
    if (!NSThread.isMainThread) {
        dispatch_async(dispatch_get_main_queue(), ^{ CSMomentsNativeMediaSetActive(active); });
        return;
    }
    if (CachedMediaActive == active) return;
    CachedMediaActive = active;
    if (!active) {
        atomic_fetch_add_explicit(&CacheGeneration, 1, memory_order_acq_rel);
        CacheRefreshScheduled = NO;
        for (CSMomentsCachedRequest *request in MediaRequests.allValues) atomic_store_explicit(&request->cancelled, YES, memory_order_release);
        [MediaRequests removeAllObjects]; [PendingMedia removeAllObjects]; [DisplayObservations removeAllObjects];
        return;
    }
    NSMutableSet<NSString *> *scheduled = [NSMutableSet new];
    for (UIView *cover in CachedCovers.allObjects) {
        CSMomentsCachedCover *state = objc_getAssociatedObject(cover, &CSMomentsCachedCoverKey);
        if (!state.key.length || !objc_getAssociatedObject(cover, &CSMomentsOwnedCoverKey) ||
            !ViewedMedia[state.key] || [scheduled containsObject:state.key]) continue;
        [scheduled addObject:state.key]; ViewedMedia[state.key].lastCycle = 0;
        CSMomentsScheduleCachedMedia(state.media);
    }
}

void CSMomentsResetCachedMedia(void) {
    if (!NSThread.isMainThread) {
        dispatch_async(dispatch_get_main_queue(), ^{ CSMomentsResetCachedMedia(); });
        return;
    }
    atomic_fetch_add_explicit(&CacheGeneration, 1, memory_order_acq_rel);
    CacheRefreshScheduled = NO;
    for (CSMomentsCachedRequest *request in MediaRequests.allValues) atomic_store_explicit(&request->cancelled, YES, memory_order_release);
    [MediaRequests removeAllObjects]; [PendingMedia removeAllObjects]; [DisplayObservations removeAllObjects];
    for (NSString *key in CachedImageOrder.copy) CSMomentsRemoveCachedImage(key);
    [ViewedMedia removeAllObjects]; [ViewedMediaOrder removeAllObjects];
    for (UIView *cover in CachedCovers.allObjects) objc_setAssociatedObject(cover, &CSMomentsCachedCoverKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [CachedCovers removeAllObjects];
}


