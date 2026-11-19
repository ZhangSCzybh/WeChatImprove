#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <math.h>
#import "CSMomentsNativeMedia.h"

// Boundary doubles preserve the native behavior that caused the regression:
// init leaves imageSize zero, same-user updates return early, and the internal
// image frame uses imageSize rather than the outer view's bounds.
static NSUInteger checks, avatarInitializations;
static BOOL cachedHead = YES;
static void Check(BOOL condition, NSString *message) {
    checks++;
    if (!condition) { NSLog(@"FAIL: %@", message); exit(1); }
}

@interface MMHeadImageView : UIView
@property(nonatomic) CGSize imageSize;
@property(nonatomic, strong) UIImageView *headImageView;
@property(nonatomic, copy) NSString *username, *requestedUsername;
@property(nonatomic, strong) NSMutableArray<NSString *> *events;
@property(nonatomic) BOOL autoUpdate, roundCorner;
- (instancetype)initWithUsrName:(NSString *)username headImgUrl:(NSString *)url
                   bAutoUpdate:(BOOL)autoUpdate bRoundCorner:(BOOL)roundCorner;
- (void)updateUsrName:(NSString *)username withHeadImgUrl:(NSString *)url;
@end
@implementation MMHeadImageView
- (instancetype)initWithUsrName:(NSString *)username headImgUrl:(NSString *)url
                   bAutoUpdate:(BOOL)autoUpdate bRoundCorner:(BOOL)roundCorner {
    if ((self = [super init])) {
        (void)url;
        avatarInitializations++;
        _username = username;
        _autoUpdate = autoUpdate;
        _roundCorner = roundCorner;
        _imageSize = CGSizeZero;
        _headImageView = [UIImageView new];
        _events = [NSMutableArray arrayWithObject:@"init"];
        [self addSubview:_headImageView];
    }
    return self;
}
- (void)setImageSize:(CGSize)size { _imageSize = size; [self.events addObject:@"size"]; }
- (void)updateUsrName:(NSString *)username withHeadImgUrl:(NSString *)url {
    Check(url == nil, @"native username path receives nil URL");
    if ([self.username isEqualToString:username]) return;
    [self.events addObject:@"update"];
    self.username = username;
    if (cachedHead) self.headImageView.image = [UIImage new];
    else if (self.autoUpdate) self.requestedUsername = username;
}
- (void)layoutIfNeeded {
    self.headImageView.frame = (CGRect){CGPointZero, self.imageSize};
}
@end

@interface WCDataItem : NSObject @end
@implementation WCDataItem @end
@interface WCMediaItem : NSObject
@property(nonatomic) CGSize imgSize;
@end
@implementation WCMediaItem @end
@interface WCImageViewModel : NSObject
@property(nonatomic, strong) id dataItem, mediaItem;
@property(nonatomic) BOOL centered;
+ (instancetype)centerSmall:(id)media;
@end
@implementation WCImageViewModel
+ (instancetype)centerSmall:(id)media {
    WCImageViewModel *model = [self new];
    model.mediaItem = media;
    model.centered = YES;
    return model;
}
@end
@interface WCImageView : UIView
@property(nonatomic, strong) WCImageViewModel *vm;
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic) NSUInteger unsubscribeCount;
- (instancetype)initWithViewModel:(WCImageViewModel *)model;
- (void)unsubscribeAll;
@end
@implementation WCImageView
- (instancetype)initWithViewModel:(WCImageViewModel *)model {
    if ((self = [super init])) {
        _vm = model;
        _imageView = [UIImageView new];
        // The production helper selects the factory; the native boundary owns
        // translating that choice into its internal image rendering policy.
        _imageView.contentMode = model.centered ? (UIViewContentMode)2 : (UIViewContentMode)0;
        _imageView.clipsToBounds = model.centered;
    }
    return self;
}
- (void)unsubscribeAll { self.unsubscribeCount++; }
@end

int main(void) {
    @autoreleasepool {
        MMHeadImageView *avatar = (id)CSMomentsCreateAvatarView(@"alice", CGSizeMake(20, 20));
        Check([avatar isKindOfClass:MMHeadImageView.class], @"native avatar created");
        Check(CGSizeEqualToSize(avatar.frame.size, CGSizeMake(20, 20)), @"outer avatar size initialized");
        Check(CGSizeEqualToSize(avatar.imageSize, CGSizeMake(20, 20)), @"native imageSize initialized");
        Check([avatar.events isEqual:@[@"init", @"size", @"update"]], @"size precedes real native user update");
        Check([avatar.username isEqual:@"alice"] && avatar.headImageView.image != nil, @"native cache read occurs immediately");
        Check(avatar.autoUpdate && avatar.roundCorner, @"native update and round flags retained");
        [avatar layoutIfNeeded];
        Check(CGSizeEqualToSize(avatar.headImageView.frame.size, CGSizeMake(20, 20)), @"native image has nonzero visible frame");
        Check(!avatar.userInteractionEnabled && avatar.clipsToBounds, @"card retains taps and avatar clipping");

        cachedHead = NO;
        MMHeadImageView *cold = (id)CSMomentsCreateAvatarView(@"bob", CGSizeMake(24, 24));
        Check([cold.requestedUsername isEqual:@"bob"], @"cold avatar enters native username download path");
        Check(CGSizeEqualToSize(cold.imageSize, CGSizeMake(24, 24)), @"requested avatar size is honored");
        CGSize invalidSizes[] = {CGSizeZero, CGSizeMake(-1, 20), CGSizeMake(NAN, 20), CGSizeMake(20, INFINITY)};
        for (NSUInteger index = 0; index < sizeof(invalidSizes) / sizeof(invalidSizes[0]); index++) {
            Check(CSMomentsCreateAvatarView(@"alice", invalidSizes[index]) == nil, @"invalid avatar size rejected");
        }
        Check(CSMomentsCreateAvatarView(nil, CGSizeMake(20, 20)) == nil, @"nil username rejected");
        Check(CSMomentsCreateAvatarView(@"", CGSizeMake(20, 20)) == nil, @"empty username rejected");
        __block UIView *backgroundAvatar;
        dispatch_semaphore_t backgroundDone = dispatch_semaphore_create(0);
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
            backgroundAvatar = CSMomentsCreateAvatarView(@"alice", CGSizeMake(20, 20));
            dispatch_semaphore_signal(backgroundDone);
        });
        dispatch_semaphore_wait(backgroundDone, DISPATCH_TIME_FOREVER);
        Check(backgroundAvatar == nil, @"background creation rejected");

        WCDataItem *item = [WCDataItem new];
        WCMediaItem *media = [WCMediaItem new];
        media.imgSize = CGSizeMake(100, 240);
        WCImageView *cover = (id)CSMomentsCreateCoverView(item, media);
        Check(cover.vm.dataItem == item && cover.vm.mediaItem == media, @"native cover retains actual item and media");
        Check(cover.imageView.contentMode == (UIViewContentMode)2 && cover.imageView.clipsToBounds,
              @"native centered factory configures internal aspect fill and clipping");
        Check(CGSizeEqualToSize(CSMomentsNativeMediaSize(media), media.imgSize), @"media CGSize ABI read");
        CSMomentsReleaseCoverView(cover);
        CSMomentsReleaseCoverView(cover);
        Check(cover.unsubscribeCount == 1, @"owned cover unsubscribes exactly once");
        WCImageView *foreign = [[WCImageView alloc] initWithViewModel:[WCImageViewModel new]];
        CSMomentsReleaseCoverView(foreign);
        Check(foreign.unsubscribeCount == 0, @"foreign native view subscription remains owned by WeChat");
        NSLog(@"Moments native media: %lu checks passed", (unsigned long)checks);
    }
    return 0;
}
