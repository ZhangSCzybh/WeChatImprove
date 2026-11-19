#import "CSMomentsNativeVideo.h"
#import "CSCloseFriendSignatures.h"
#import <objc/message.h>
#import <objc/runtime.h>
#import <math.h>

// Keep init-family ownership visible to ARC despite dynamic native classes.
@protocol CSMomentsNativeVideoConstructor <NSObject>
- (instancetype)initWithWCDataItem:(id)dataItem showDetail:(BOOL)showDetail withScene:(NSUInteger)scene;
@end

static BOOL VideoMethod(Class cls, SEL selector, const char *types) {
    return cls && CSCloseFriendMethodMatches(class_getInstanceMethod(cls, selector), types);
}

static BOOL ValidVideoSize(CGSize size) {
    return isfinite(size.width) && isfinite(size.height) && size.width > 0 && size.height > 0;
}

// The native type-15 branch uses WCContentItemViewTemplateVideo for ordinary
// non-ad, non-folded videos. Ads/live/folded videos have different templates.
static id SupportedVideoMedia(id dataItem) {
    Class dataClass = NSClassFromString(@"WCDataItem");
    Class mediaClass = NSClassFromString(@"WCMediaItem");
    SEL contentSelector = NSSelectorFromString(@"contentObj");
    SEL adSelector = NSSelectorFromString(@"isAd");
    SEL foldedSelector = NSSelectorFromString(@"sightFolded");
    SEL compositionSelector = NSSelectorFromString(@"sightCompositeTaskOfMediaItemAtIndex:");
    Class itemClass = object_getClass(dataItem);
    if (!dataClass || !mediaClass || ![dataItem isKindOfClass:dataClass] ||
        !VideoMethod(itemClass, contentSelector, "@@:") ||
        !VideoMethod(itemClass, adSelector, "B@:") ||
        !VideoMethod(itemClass, foldedSelector, "i@:") ||
        !VideoMethod(itemClass, compositionSelector, "@@:q")) return nil;
    if (((BOOL (*)(id, SEL))objc_msgSend)(dataItem, adSelector) ||
        ((int (*)(id, SEL))objc_msgSend)(dataItem, foldedSelector) != 0 ||
        ((id (*)(id, SEL, NSInteger))objc_msgSend)(dataItem, compositionSelector, 0)) return nil;
    id content = ((id (*)(id, SEL))objc_msgSend)(dataItem, contentSelector);
    SEL typeSelector = NSSelectorFromString(@"type");
    SEL mediaSelector = NSSelectorFromString(@"mediaList");
    if (!VideoMethod(object_getClass(content), typeSelector, "i@:") ||
        !VideoMethod(object_getClass(content), mediaSelector, "@@:") ||
        ((int (*)(id, SEL))objc_msgSend)(content, typeSelector) != 15) return nil;
    id mediaList = ((id (*)(id, SEL))objc_msgSend)(content, mediaSelector);
    if (![mediaList isKindOfClass:NSArray.class]) return nil;
    id media = [(NSArray *)mediaList firstObject];
    return [media isKindOfClass:mediaClass] ? media : nil;
}

static void StopVideoOwner(id owner) {
    SEL stop = NSSelectorFromString(@"autoPauseWithoutSound");
    if (!VideoMethod(object_getClass(owner), stop, "v@:")) return;
    @try {
        // This native Video template forwards to silenceStopAtCurrentScreen,
        // which releases its WCPlayerView resources rather than retaining audio.
        ((void (*)(id, SEL))objc_msgSend)(owner, stop);
    } @catch (__unused NSException *exception) {}
}

@interface CSMomentsNativeVideoCover : UIView
@property(nonatomic, strong) id nativeOwner;
@property(nonatomic, strong) UIView *nativeVideo;
@property(nonatomic) CGSize naturalSize;
@property(nonatomic) BOOL playing;
@property(nonatomic) BOOL released;
- (void)releaseNativeVideo;
@end

@implementation CSMomentsNativeVideoCover
- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.released || !self.nativeVideo || !ValidVideoSize(self.bounds.size) ||
        !ValidVideoSize(self.naturalSize)) return;
    CGFloat scale = MAX(self.bounds.size.width / self.naturalSize.width,
                        self.bounds.size.height / self.naturalSize.height);
    CGSize size = CGSizeMake(self.naturalSize.width * scale, self.naturalSize.height * scale);
    // WCSNSNodeVideoView's verified setFrame: resizes its thumbnail and player.
    // Preserve the media ratio; the wrapper clips the centered overflow.
    self.nativeVideo.frame = CGRectMake(CGRectGetMidX(self.bounds) - size.width / 2,
                                       CGRectGetMidY(self.bounds) - size.height / 2,
                                       size.width, size.height);
    [self.nativeVideo setNeedsLayout];
}
- (void)releaseNativeVideo {
    if (_released) return;
    _released = YES;
    _playing = NO;
    StopVideoOwner(_nativeOwner);
    [_nativeVideo removeFromSuperview];
    _nativeVideo = nil;
    _nativeOwner = nil;
}
- (void)dealloc {
    if (!_released && _nativeOwner) {
        id owner = _nativeOwner;
        if (NSThread.isMainThread) StopVideoOwner(owner);
        else dispatch_async(dispatch_get_main_queue(), ^{ StopVideoOwner(owner); });
    }
}
@end

UIView *CSMomentsCreateVideoCoverView(id dataItem, id mediaItem) {
    if (!NSThread.isMainThread) return nil;
    id owner = nil;
    @try {
        if (!mediaItem || SupportedVideoMedia(dataItem) != mediaItem) return nil;
        Class templateClass = NSClassFromString(@"WCContentItemViewTemplateVideo");
        Class videoClass = NSClassFromString(@"WCSNSNodeVideoView");
        SEL initialize = NSSelectorFromString(@"initWithWCDataItem:showDetail:withScene:");
        SEL mainView = NSSelectorFromString(@"getMainContentView");
        SEL play = NSSelectorFromString(@"autoPlayWithoutSound");
        SEL pause = NSSelectorFromString(@"autoPauseWithoutSound");
        if (![templateClass isSubclassOfClass:UIView.class] || ![videoClass isSubclassOfClass:UIView.class] ||
            !VideoMethod(templateClass, initialize, "@@:@BQ") ||
            !VideoMethod(templateClass, mainView, "@@:") ||
            !VideoMethod(templateClass, play, "v@:") ||
            !VideoMethod(templateClass, pause, "v@:")) return nil;
        id<CSMomentsNativeVideoConstructor> allocated = [templateClass alloc];
        // Scene 1 shares WCFacade's timeline node cache. Scene 0 takes the
        // verified fresh-node branch, preserving the retained native timeline.
        owner = [allocated initWithWCDataItem:dataItem showDetail:NO withScene:0];
        if (![owner isKindOfClass:templateClass]) { StopVideoOwner(owner); return nil; }
        id main = ((id (*)(id, SEL))objc_msgSend)(owner, mainView);
        if (![main isKindOfClass:videoClass]) { StopVideoOwner(owner); return nil; }
        UIView *video = main;
        CGSize naturalSize = video.bounds.size;
        if (!ValidVideoSize(naturalSize)) naturalSize = video.frame.size;
        if (!ValidVideoSize(naturalSize)) { StopVideoOwner(owner); return nil; }
        CSMomentsNativeVideoCover *cover = [[CSMomentsNativeVideoCover alloc] initWithFrame:CGRectZero];
        cover.nativeOwner = owner;
        cover.nativeVideo = video;
        cover.naturalSize = naturalSize;
        cover.userInteractionEnabled = NO;
        cover.clipsToBounds = YES;
        video.userInteractionEnabled = NO;
        // Only our freshly created node is moved; the template remains retained
        // as its native delegate and media-setup owner throughout this cover.
        [video removeFromSuperview];
        [cover addSubview:video];
        return cover;
    } @catch (__unused NSException *exception) {
        StopVideoOwner(owner);
        return nil;
    }
}

UIView *CSMomentsVideoCoverViewInView(UIView *container) {
    if (!NSThread.isMainThread || !container) return nil;
    if ([container isKindOfClass:CSMomentsNativeVideoCover.class])
        return ((CSMomentsNativeVideoCover *)container).released ? nil : container;
    for (UIView *child in container.subviews) {
        UIView *cover = CSMomentsVideoCoverViewInView(child);
        if (cover) return cover;
    }
    return nil;
}

BOOL CSMomentsNativeVideoCanAutoPlay(id facade, id dataItem) {
    if (!NSThread.isMainThread) return NO;
    @try {
        Class facadeClass = NSClassFromString(@"WCFacade");
        SEL gate = NSSelectorFromString(@"isTimelineVideoSightAutoPlayEnable");
        if (!facadeClass || ![facade isKindOfClass:facadeClass] || !SupportedVideoMedia(dataItem) ||
            !VideoMethod(object_getClass(facade), gate, "B@:")) return NO;
        return ((BOOL (*)(id, SEL))objc_msgSend)(facade, gate);
    } @catch (__unused NSException *exception) {
        return NO;
    }
}

BOOL CSMomentsSetVideoCoverPlaying(UIView *view, BOOL playing) {
    if (!NSThread.isMainThread || ![view isKindOfClass:CSMomentsNativeVideoCover.class]) return NO;
    CSMomentsNativeVideoCover *cover = (id)view;
    if (cover.released || !cover.nativeOwner) return NO;
    if (cover.playing == playing) return YES;
    if (!playing) {
        cover.playing = NO;
        StopVideoOwner(cover.nativeOwner);
        return YES;
    }
    SEL play = NSSelectorFromString(@"autoPlayWithoutSound");
    if (!VideoMethod(object_getClass(cover.nativeOwner), play, "v@:")) return NO;
    @try {
        [cover layoutIfNeeded];
        ((void (*)(id, SEL))objc_msgSend)(cover.nativeOwner, play);
        cover.playing = YES;
        return YES;
    } @catch (__unused NSException *exception) {
        StopVideoOwner(cover.nativeOwner);
        cover.playing = NO;
        return NO;
    }
}

void CSMomentsReleaseVideoCoverView(UIView *view) {
    if (![view isKindOfClass:CSMomentsNativeVideoCover.class]) return;
    if (!NSThread.isMainThread) {
        dispatch_async(dispatch_get_main_queue(), ^{ CSMomentsReleaseVideoCoverView(view); });
        return;
    }
    [(CSMomentsNativeVideoCover *)view releaseNativeVideo];
}
