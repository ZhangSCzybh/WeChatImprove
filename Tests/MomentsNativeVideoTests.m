#import "MomentsNativeVideoUIKit.h"
#import "CSMomentsNativeVideo.h"
#import <objc/runtime.h>
#import <math.h>

static NSUInteger checks;
static void Check(BOOL condition, NSString *message) {
    checks++;
    if (!condition) { NSLog(@"FAIL: %@", message); exit(1); }
}
@implementation UIView (CSMomentsVideoTestLayout)
- (void)layoutSubviews {}
@end

@interface WCMediaItem : NSObject @end
@implementation WCMediaItem @end
@interface WCContentItem : NSObject
@property(nonatomic) int type;
@property(nonatomic, strong) NSArray *mediaList;
@end
@implementation WCContentItem @end
@interface WCDataItem : NSObject
@property(nonatomic, strong) WCContentItem *contentObj;
@property(nonatomic) BOOL isAd;
@property(nonatomic) int sightFolded;
@property(nonatomic, strong) id composition;
- (id)sightCompositeTaskOfMediaItemAtIndex:(NSInteger)index;
@end
@implementation WCDataItem
- (id)sightCompositeTaskOfMediaItemAtIndex:(NSInteger)index { return index == 0 ? self.composition : nil; }
@end
@interface WCFacade : NSObject
@property(nonatomic) BOOL enabled;
@property(nonatomic) NSUInteger gateCalls;
- (BOOL)isTimelineVideoSightAutoPlayEnable;
@end
@implementation WCFacade
- (BOOL)isTimelineVideoSightAutoPlayEnable { self.gateCalls++; return self.enabled; }
@end
@interface WCSNSNodeVideoView : UIView
@property(nonatomic, weak) id delegate;
@end
@implementation WCSNSNodeVideoView @end

@interface WCContentItemViewTemplateVideo : UIView
@property(nonatomic, strong) WCSNSNodeVideoView *video;
@property(nonatomic, strong) WCDataItem *item;
@property(nonatomic) NSUInteger scene, playCalls, stopCalls;
@property(nonatomic) BOOL detail;
- (instancetype)initWithWCDataItem:(id)item showDetail:(BOOL)detail withScene:(NSUInteger)scene;
- (UIView *)getMainContentView;
- (void)autoPlayWithoutSound;
- (void)autoPauseWithoutSound;
@end
static __weak WCContentItemViewTemplateVideo *lastOwner;
static WCSNSNodeVideoView *originalTimelineNode;
static BOOL invalidSize;
@implementation WCContentItemViewTemplateVideo
- (instancetype)initWithWCDataItem:(id)item showDetail:(BOOL)detail withScene:(NSUInteger)scene {
    if ((self = [super initWithFrame:CGRectZero])) {
        _item = item; _detail = detail; _scene = scene;
        // The native scene-1 branch shares the timeline cache. An adapter
        // choosing it would visibly steal this exact retained timeline node.
        _video = scene == 1 ? originalTimelineNode : [[WCSNSNodeVideoView alloc]
            initWithFrame:invalidSize ? CGRectZero : CGRectMake(0, 3, 160, 90)];
        _video.delegate = self;
        [self addSubview:_video];
        lastOwner = self;
    }
    return self;
}
- (UIView *)getMainContentView { return self.video; }
- (void)autoPlayWithoutSound { self.playCalls++; }
- (void)autoPauseWithoutSound { self.stopCalls++; }
@end

static NSInteger WrongGate(id object, SEL selector) { (void)object; (void)selector; return 1; }

int main(void) {
    @autoreleasepool {
        WCMediaItem *media = [WCMediaItem new];
        WCContentItem *content = [WCContentItem new];
        content.type = 15; content.mediaList = @[media];
        WCDataItem *item = [WCDataItem new]; item.contentObj = content;
        WCFacade *facade = [WCFacade new]; facade.enabled = YES;
        UIView *timeline = [UIView new];
        originalTimelineNode = [[WCSNSNodeVideoView alloc] initWithFrame:CGRectMake(0, 0, 160, 90)];
        [timeline addSubview:originalTimelineNode];
        UIView *cover = CSMomentsCreateVideoCoverView(item, media);
        WCContentItemViewTemplateVideo *owner = lastOwner;
        Check(cover != nil && owner != nil, @"ordinary video creates native owner");
        Check(owner.item == item && owner.scene == 0 && !owner.detail, @"fresh native scene keeps real data and timeline presentation");
        Check(owner.video != originalTimelineNode && originalTimelineNode.superview == timeline,
              @"adapter leaves retained timeline cache node in place");
        Check(owner.video.superview == cover && owner.video.delegate == owner, @"fresh node keeps its native delegate owner");
        Check(!cover.userInteractionEnabled && !owner.video.userInteractionEnabled && cover.clipsToBounds,
              @"card retains taps and wrapper clips media");
        Check(owner.playCalls == 0, @"cover creation does not start video");
        cover.frame = CGRectMake(0, 0, 100, 200);
        [cover layoutSubviews];
        CGRect frame = owner.video.frame;
        Check(fabs(frame.size.width / frame.size.height - 160.0 / 90.0) < .00001,
              @"tall card preserves native media aspect ratio");
        Check(fabs(CGRectGetMidX(frame) - 50) < .00001 && fabs(CGRectGetMidY(frame) - 100) < .00001 && frame.origin.x < 0,
              @"native video fills card with centered horizontal crop");
        cover.frame = CGRectMake(0, 0, 300, 100); [cover layoutSubviews];
        Check(owner.video.frame.origin.y < 0 && fabs(owner.video.frame.size.width - 300) < .00001,
              @"wide card centers vertical overflow");
        UIView *cell = [UIView new]; [cell addSubview:cover];
        Check(CSMomentsVideoCoverViewInView(cell) == cover, @"runtime finds owned cover inside unchanged cell API");
        Check(CSMomentsVideoCoverViewInView(timeline) == nil, @"foreign native video is never adopted");
        Check(CSMomentsNativeVideoCanAutoPlay(facade, item), @"current facade permits native autoplay");
        facade.enabled = NO;
        Check(!CSMomentsNativeVideoCanAutoPlay(facade, item) && facade.gateCalls == 2,
              @"native network preference is queried afresh without a plugin cache");
        facade.enabled = YES;
        Check(CSMomentsSetVideoCoverPlaying(cover, YES) && CSMomentsSetVideoCoverPlaying(cover, YES) && owner.playCalls == 1,
              @"silent play is idempotent");
        Check(CSMomentsSetVideoCoverPlaying(cover, NO) && CSMomentsSetVideoCoverPlaying(cover, NO) && owner.stopCalls == 1,
              @"pause releases native player once for repeated requests");
        Check(CSMomentsSetVideoCoverPlaying(cover, YES) && owner.playCalls == 2, @"visible cover can resume after pause");
        CSMomentsReleaseVideoCoverView(cover); CSMomentsReleaseVideoCoverView(cover);
        Check(owner.stopCalls == 2 && owner.video.superview == nil, @"release stops and detaches exactly once");
        Check(!CSMomentsSetVideoCoverPlaying(cover, YES) && CSMomentsVideoCoverViewInView(cell) == nil,
              @"released cover cannot restart or become a candidate");
        Check(!CSMomentsSetVideoCoverPlaying(timeline, NO) && !CSMomentsSetVideoCoverPlaying(nil, NO),
              @"nil and foreign pause requests are safe");
        CSMomentsReleaseVideoCoverView(timeline);
        Check(originalTimelineNode.superview == timeline, @"foreign release does not remove timeline media");
        Check(CSMomentsCreateVideoCoverView(item, [WCMediaItem new]) == nil, @"mismatched first media rejected");
        item.isAd = YES;
        Check(CSMomentsCreateVideoCoverView(item, media) == nil && !CSMomentsNativeVideoCanAutoPlay(facade, item), @"ad native templates excluded");
        item.isAd = NO; item.sightFolded = 1;
        Check(CSMomentsCreateVideoCoverView(item, media) == nil, @"folded HotVideo template excluded");
        item.sightFolded = 0; item.composition = [NSObject new];
        Check(CSMomentsCreateVideoCoverView(item, media) == nil && !CSMomentsNativeVideoCanAutoPlay(facade, item),
              @"unfinished local composition never autoplays");
        item.composition = nil;
        for (NSNumber *type in @[@4, @34, @45]) {
            content.type = type.intValue;
            Check(CSMomentsCreateVideoCoverView(item, media) == nil && !CSMomentsNativeVideoCanAutoPlay(facade, item),
                  @"audio and live content retain static fallback");
        }
        content.type = 15; content.mediaList = @[];
        Check(CSMomentsCreateVideoCoverView(item, media) == nil, @"empty media list rejected");
        content.mediaList = @[media]; invalidSize = YES;
        Check(CSMomentsCreateVideoCoverView(item, media) == nil, @"invalid native geometry falls back without playback");
        invalidSize = NO;
        Class wrongClass = objc_allocateClassPair(WCFacade.class, "CSMomentsWrongVideoGateFacade", 0);
        class_addMethod(wrongClass, @selector(isTimelineVideoSightAutoPlayEnable), (IMP)WrongGate, "q@:");
        objc_registerClassPair(wrongClass);
        Check(!CSMomentsNativeVideoCanAutoPlay([wrongClass new], item), @"changed native gate ABI fails closed");
        __block UIView *offMainCover;
        __block BOOL offMainGate, offMainPlay;
        dispatch_semaphore_t finished = dispatch_semaphore_create(0);
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
            offMainCover = CSMomentsCreateVideoCoverView(item, media);
            offMainGate = CSMomentsNativeVideoCanAutoPlay(facade, item);
            offMainPlay = CSMomentsSetVideoCoverPlaying(cover, YES);
            dispatch_semaphore_signal(finished);
        });
        dispatch_semaphore_wait(finished, DISPATCH_TIME_FOREVER);
        Check(!offMainCover && !offMainGate && !offMainPlay, @"off-main creation, gate and playback rejected");
        NSLog(@"Moments native video: %lu checks passed", (unsigned long)checks);
    }
    return 0;
}
