#import "MomentsShareUIKit.h"
#import "CSMomentsCardModel.h"
#import "CSMomentsCardGeometry.h"
#import "CSCloseFriendSignatures.h"
#import <objc/message.h>
#import <objc/runtime.h>
#include <math.h>

static NSUInteger Checks, ReleasedThumbnails, URLLoads;
#define CHECK(...) do { Checks++; if (!(__VA_ARGS__)) { \
    fprintf(stderr, "Moments shared cover FAIL %d: %s\n", __LINE__, #__VA_ARGS__); exit(1); \
} } while (0)

@implementation UIFont @end
@implementation UITraitCollection @end
@implementation UIColor
+ (instancetype)secondaryLabelColor { return [self new]; }
+ (instancetype)tertiarySystemFillColor { return [self new]; }
+ (instancetype)secondarySystemGroupedBackgroundColor { return [self new]; }
@end
@implementation UIView
- (instancetype)init {
    if ((self = [super init])) {
        _subviews = [NSMutableArray new];
        _gestureRecognizers = [NSMutableArray new];
        _transform = CGAffineTransformIdentity;
        _userInteractionEnabled = YES;
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame { if ((self = [self init])) self.frame = frame; return self; }
- (void)setFrame:(CGRect)frame { _frame = frame; _bounds.size = frame.size; }
- (void)addSubview:(UIView *)view {
    if (view.superview == self) return;
    [view removeFromSuperview];
    [view willMoveToSuperview:self];
    view.superview = self;
    [self.subviews addObject:view];
    [view didMoveToSuperview];
}
- (void)removeFromSuperview {
    if (!self.superview) return;
    [self willMoveToSuperview:nil];
    [self.superview.subviews removeObjectIdenticalTo:self];
    self.superview = nil;
    [self didMoveToSuperview];
}
- (void)willMoveToSuperview:(UIView *)superview { (void)superview; }
- (void)didMoveToSuperview {}
- (void)layoutSubviews {}
- (void)addGestureRecognizer:(UITapGestureRecognizer *)recognizer {
    if (!recognizer || recognizer.view == self) return;
    [recognizer.view removeGestureRecognizer:recognizer];
    recognizer.view = self;
    [self.gestureRecognizers addObject:recognizer];
}
- (void)removeGestureRecognizer:(UITapGestureRecognizer *)recognizer {
    if (!recognizer) return;
    [self.gestureRecognizers removeObjectIdenticalTo:recognizer];
    if (recognizer.view == self) recognizer.view = nil;
}
@end
@implementation UILabel @end
@implementation UIImage
+ (instancetype)systemImageNamed:(NSString *)name { (void)name; return [self new]; }
@end
@implementation UIImageView
- (instancetype)initWithImage:(UIImage *)image { if ((self = [super init])) _image = image; return self; }
@end
@implementation UIViewController
- (instancetype)init { if ((self = [super init])) _traitCollection = [UITraitCollection new]; return self; }
@end
@implementation UITapGestureRecognizer
- (instancetype)initWithTarget:(id)target action:(SEL)action {
    if ((self = [super init])) { _target = target; _action = action; }
    return self;
}
- (void)fire { if (self.target && self.action) ((void (*)(id, SEL))objc_msgSend)(self.target, self.action); }
@end
@implementation CSMomentsCardModel @end

@interface WCContentItem : NSObject
@property(nonatomic, copy) NSString *linkUrl;
@end
@implementation WCContentItem @end
@interface WCDataItem : NSObject
@property(nonatomic, strong) WCContentItem *contentObj;
@end
@implementation WCDataItem @end

static BOOL URLLoadThrows;
@interface MMWebImageView : UIView
@property(nonatomic, strong) NSURL *imageURL;
@end
@implementation MMWebImageView
- (void)setImageURL:(NSURL *)imageURL {
    if (URLLoadThrows) @throw [NSException exceptionWithName:@"FixtureImageLoader" reason:nil userInfo:nil];
    URLLoads++;
    _imageURL = imageURL;
}
@end

static NSUInteger FinderPreloads, FinderFullCoverLoads, NewsInitializations;
@interface WCContentItemFinderView : UIView
@property(nonatomic, strong) WCDataItem *item;
@property(nonatomic, strong) id navigationController;
@property(nonatomic, strong) UIView *playIconView;
@property(nonatomic) NSUInteger opens;
- (instancetype)initWithWCDataItem:(id)item showDetail:(BOOL)detail withScene:(NSUInteger)scene;
- (void)preLoad:(id)item;
- (void)loadFinderImages;
- (void)throwUrlMessage;
@end
@implementation WCContentItemFinderView
- (instancetype)initWithWCDataItem:(id)item showDetail:(BOOL)detail withScene:(NSUInteger)scene {
    (void)detail; (void)scene;
    if ((self = [super initWithFrame:CGRectMake(0, 0, 160, 160)])) {
        _item = item;
        _playIconView = [UIView new];
        [self addSubview:_playIconView];
        [self preLoad:item];
        [self loadFinderImages];
    }
    return self;
}
- (void)preLoad:(id)item { (void)item; FinderPreloads++; }
- (void)loadFinderImages { FinderFullCoverLoads++; }
- (void)throwUrlMessage { self.opens++; }
@end

@interface WCContentItemViewTemplateNews : UIView
@property(nonatomic, strong) WCDataItem *item;
@property(nonatomic, strong) id navigationController;
@property(nonatomic) NSUInteger opens;
- (instancetype)initWithWCDataItem:(id)item showDetail:(BOOL)detail withScene:(NSUInteger)scene;
- (void)initViewsWithWCDataItem:(id)item;
- (void)throwUrlMessage;
@end
@implementation WCContentItemViewTemplateNews
- (instancetype)initWithWCDataItem:(id)item showDetail:(BOOL)detail withScene:(NSUInteger)scene {
    (void)detail; (void)scene;
    if ((self = [super init])) { _item = item; [self initViewsWithWCDataItem:item]; [self layoutSubviews]; }
    return self;
}
- (void)initViewsWithWCDataItem:(id)item { (void)item; NewsInitializations++; }
- (void)throwUrlMessage { self.opens++; }
@end

// A live owner would initialize live-state services in WeChat. Static cards
// must avoid constructing it and leave opening to the guarded native detail.
static NSUInteger LiveOwnerInitializations;
@interface WCFinderShareLiveView : WCContentItemViewTemplateNews @end
@implementation WCFinderShareLiveView
- (instancetype)initWithWCDataItem:(id)item showDetail:(BOOL)detail withScene:(NSUInteger)scene {
    LiveOwnerInitializations++;
    return [super initWithWCDataItem:item showDetail:detail withScene:scene];
}
@end

static BOOL CSMomentsTitleMethod(Class cls, NSString *name, const char *types) {
    return cls && CSCloseFriendMethodMatches(class_getInstanceMethod(cls, NSSelectorFromString(name)), types);
}
static UIFont *CSMomentsSmallFont(CGFloat size, CGFloat maximum, UITraitCollection *traits) {
    (void)size; (void)maximum; (void)traits; return [UIFont new];
}
static void CSMomentsReleaseCoverView(UIView *view) { if (view) ReleasedThumbnails++; }

// Generated directly from the production shared-cover section by the runner.
#include "MomentsSharedCoverProduction.h"

static CSMomentsCardModel *Model(CSMomentsContentKind kind) {
    CSMomentsCardModel *model = [CSMomentsCardModel new];
    model.contentKind = kind;
    WCDataItem *item = [WCDataItem new];
    item.contentObj = [WCContentItem new];
    item.contentObj.linkUrl = @"https://example.invalid/native-share";
    model.item = item;
    model.title = @"分享标题";
    model.sourceText = @"分享来源";
    model.shareCoverURL = @"";
    return model;
}

static CSMomentsNativeShareCover *Cover(CSMomentsCardModel *model, UIView *thumbnail, BOOL (^gate)(void)) {
    UIViewController *page = [UIViewController new];
    page.navigationController = [NSObject new];
    CSMomentsNativeShareCover *cover = (id)CSMomentsCreateSharedCover(model, page, thumbnail, gate);
    CHECK([cover isKindOfClass:CSMomentsNativeShareCover.class]);
    cover.frame = CGRectMake(0, 0, 180, 140);
    [cover layoutSubviews];
    return cover;
}

int main(void) { @autoreleasepool {
    // Native thumbnail loading uses the original URL and keeps routing separate.
    MMWebImageView *image = (id)CSMomentsShareURLThumbnail(@"https://example.invalid/cover.jpg?token=original");
    CHECK([image isKindOfClass:MMWebImageView.class]);
    CHECK([image.imageURL.absoluteString isEqual:@"https://example.invalid/cover.jpg?token=original"]);
    CHECK(image.contentMode == UIViewContentModeScaleAspectFill && image.clipsToBounds && !image.userInteractionEnabled);
    CHECK(CSMomentsShareURLThumbnail(@"") == nil);
    CHECK(CSMomentsShareURLThumbnail(@"http://[") == nil);
    CHECK(CSMomentsShareURLThumbnail(@"file:///tmp/cover.jpg") == nil);
    CHECK(CSMomentsShareURLThumbnail(@"/relative/cover.jpg") == nil);
    CHECK(CSMomentsShareURLThumbnail(@"javascript:alert(1)") == nil);

    CSMomentsCardModel *live = Model(CSMomentsContentFinderLive);
    live.sourceText = @"主播 · 直播";
    live.shareCoverURL = @"https://example.invalid/live.jpg";
    NSUInteger beforeLoads = URLLoads;
    CSMomentsNativeShareCover *liveCover = Cover(live, nil, ^BOOL { return YES; });
    CHECK([liveCover.thumbnail isKindOfClass:MMWebImageView.class]);
    CHECK([[(MMWebImageView *)liveCover.thumbnail imageURL].absoluteString isEqual:live.shareCoverURL]);
    CHECK(URLLoads == beforeLoads + 1 && [liveCover.sourceLabel.text isEqual:live.sourceText]);
    CHECK(LiveOwnerInitializations == 0 && liveCover.nativeOwner == nil && liveCover.nativeTap == nil);
    UIView *liveCell = [UIView new];
    [liveCell addSubview:liveCover];
    CHECK(liveCell.gestureRecognizers.count == 0);
    [liveCover removeFromSuperview];

    CSMomentsCardModel *finder = Model(CSMomentsContentFinder);
    CSMomentsNativeShareCover *cover = Cover(finder, nil, ^BOOL { return YES; });
    CHECK([cover.nativeOwner isKindOfClass:WCContentItemFinderView.class]);
    CHECK(cover.thumbnail == nil && cover.nativeOwner.superview == cover.stage);
    CHECK(cover.nativePlayIcon && FinderPreloads == 0 && FinderFullCoverLoads == 0);
    [cover openNativeContent];
    CHECK([(WCContentItemFinderView *)cover.nativeOwner opens] == 0);
    UIView *finderCell = [UIView new];
    [finderCell addSubview:cover];
    [cover openNativeContent];
    CHECK([(WCContentItemFinderView *)cover.nativeOwner opens] == 1);

    // The adapter's display-only subclass leaves original native classes intact.
    WCContentItemFinderView *original = [[WCContentItemFinderView alloc] initWithWCDataItem:finder.item showDetail:NO withScene:0];
    CHECK(original && FinderPreloads == 1 && FinderFullCoverLoads == 1);

    UIView *articleThumbnail = [UIView new];
    CSMomentsCardModel *article = Model(CSMomentsContentArticle);
    cover = Cover(article, articleThumbnail, ^BOOL { return YES; });
    CHECK([cover.nativeOwner isKindOfClass:WCContentItemViewTemplateNews.class]);
    CHECK(cover.thumbnail == articleThumbnail && cover.thumbnail.superview == cover.stage);
    CHECK(cover.nativeOwner.hidden && NewsInitializations == 0);
    CHECK(CGRectGetWidth(articleThumbnail.frame) == 180);
    CHECK([cover.sourceLabel.text isEqual:@"分享来源"] && CGRectGetHeight(cover.sourceLabel.frame) > 0);
    WCContentItemViewTemplateNews *originalNews = [[WCContentItemViewTemplateNews alloc]
        initWithWCDataItem:article.item showDetail:NO withScene:0];
    CHECK(originalNews && NewsInitializations == 1);

    __block BOOL allowed = NO;
    UIView *cell = [UIView new];
    [cell addSubview:cover];
    CHECK(cell.gestureRecognizers.count == 1 && cover.nativeTap.view == cell);
    cover.shouldOpen = ^BOOL { return allowed; };
    [cover.nativeTap fire];
    CHECK([(WCContentItemViewTemplateNews *)cover.nativeOwner opens] == 0);
    allowed = YES;
    [cover.nativeTap fire];
    CHECK([(WCContentItemViewTemplateNews *)cover.nativeOwner opens] == 1);
    NSUInteger beforeRelease = ReleasedThumbnails;
    [cover removeFromSuperview];
    CHECK(cell.gestureRecognizers.count == 0 && cover.nativeTap.view == nil);
    CHECK(ReleasedThumbnails == beforeRelease + 1);
    CHECK(cover.superview == nil);
    [cover.nativeTap fire];
    [cover openNativeContent];
    CHECK([(WCContentItemViewTemplateNews *)cover.nativeOwner opens] == 1);
    UIView *reusedCell = [UIView new];
    CSMomentsNativeShareCover *replacement = Cover(article, [UIView new], ^BOOL { return NO; });
    [cell addSubview:replacement];
    CHECK(cell.gestureRecognizers.count == 1 && replacement.nativeTap.view == cell);
    CHECK(![cell.gestureRecognizers containsObject:cover.nativeTap]);
    [reusedCell addSubview:replacement];
    CHECK(cell.gestureRecognizers.count == 0 && reusedCell.gestureRecognizers.count == 1);
    [replacement removeFromSuperview];
    CHECK(reusedCell.gestureRecognizers.count == 0);

    // A tiny application icon is bounded instead of enlarged to card width.
    CSMomentsCardModel *miniapp = Model(CSMomentsContentMiniApp);
    miniapp.title = @"真实小程序名称";
    miniapp.sourceText = @"小程序分享的页面标题";
    UIView *smallIcon = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    cover = Cover(miniapp, smallIcon, ^BOOL { return YES; });
    CHECK([[cover valueForKey:@"compact"] boolValue]);
    CHECK(cover.thumbnail == smallIcon);
    CHECK(CGRectGetWidth(smallIcon.frame) > 0 && CGRectGetWidth(smallIcon.frame) <= 56);
    CHECK(CGRectGetHeight(smallIcon.frame) > 0 && CGRectGetHeight(smallIcon.frame) <= 56);
    CHECK([cover.sourceLabel.text isEqual:@"小程序分享的页面标题"] && CGRectGetHeight(cover.sourceLabel.frame) > 0);
    CHECK(![cover.sourceLabel.text isEqual:miniapp.title]);
    CHECK(CSMomentsSharedCoverSize(miniapp, 180).height == 88);

    miniapp.shareCoverURL = @"http://[";
    cover = Cover(miniapp, smallIcon, ^BOOL { return YES; });
    CHECK(cover.compact && cover.thumbnail == smallIcon);
    CHECK(CGRectGetWidth(smallIcon.frame) <= 56 && CGRectGetHeight(smallIcon.frame) <= 56);

    miniapp.shareCoverURL = @"https://example.invalid/miniapp-screenshot.jpg";
    beforeRelease = ReleasedThumbnails;
    cover = Cover(miniapp, smallIcon, ^BOOL { return YES; });
    CHECK(![[cover valueForKey:@"compact"] boolValue]);
    CHECK([cover.thumbnail isKindOfClass:MMWebImageView.class]);
    CHECK([[(MMWebImageView *)cover.thumbnail imageURL].absoluteString isEqual:miniapp.shareCoverURL]);
    CHECK(CGRectGetWidth(cover.thumbnail.frame) == 180);
    CHECK([cover.sourceLabel.text isEqual:@"小程序分享的页面标题"]);
    CHECK(ReleasedThumbnails >= beforeRelease + 1);

    URLLoadThrows = YES;
    cover = Cover(miniapp, smallIcon, ^BOOL { return YES; });
    CHECK(cover.compact && cover.thumbnail == smallIcon);
    CHECK(CGRectGetWidth(cover.thumbnail.frame) <= 56 && CGRectGetHeight(cover.thumbnail.frame) <= 56);
    URLLoadThrows = NO;

    miniapp.shareCoverURL = @"";
    cover = Cover(miniapp, nil, ^BOOL { return YES; });
    CHECK(cover.compact && [cover.thumbnail isKindOfClass:UIImageView.class]);
    CHECK(CGRectGetWidth(cover.thumbnail.frame) <= 56 && CGRectGetHeight(cover.thumbnail.frame) <= 56);
    CHECK(cover.sourceLabel.text.length && CGRectGetWidth(cover.sourceLabel.frame) > 0);

    // Reproduce the image-less H5 card from the report: a long encoded query
    // stays on the native action owner and never becomes a large text cover.
    NSString *longLink = [@"https://h5.aihujing.com/#/video?hjType=1&content_title="
        stringByAppendingString:[@"%E6%9C%AF%E5%89%8D" stringByPaddingToLength:1800 withString:@"%E6%9C%AF" startingAtIndex:0]];
    CSMomentsCardModel *linkCard = Model(CSMomentsContentArticle);
    ((WCDataItem *)linkCard.item).contentObj.linkUrl = longLink;
    linkCard.title = @"探马";
    linkCard.sourceText = @"h5.aihujing.com";
    linkCard.coverSize = CGSizeMake(1, 0.65);
    CGSize linkSize = CSMomentsSharedCoverSize(linkCard, 180);
    CHECK(linkSize.width == 180 && linkSize.height == 88);
    CSMomentsCardMetrics linkMetrics = CSMomentsCardMeasure(true, 180, linkSize.width, linkSize.height,
        21, 21, 17, 15, 0);
    CHECK(linkMetrics.coverHeight == 88 && linkMetrics.titleHeight == 21);
    CHECK(CSMomentsSharedCoverSize(linkCard, 70).height == 70);
    cover = Cover(linkCard, nil, ^BOOL { return YES; });
    cover.frame = CGRectMake(0, 0, 180, linkMetrics.coverHeight);
    [cover layoutSubviews];
    CHECK(cover.compact && [cover.thumbnail isKindOfClass:UIImageView.class]);
    CHECK(CGRectGetWidth(cover.thumbnail.frame) <= 56 && CGRectGetHeight(cover.thumbnail.frame) <= 56);
    CHECK([cover.sourceLabel.text isEqual:@"h5.aihujing.com"] && cover.sourceLabel.numberOfLines == 2);
    CHECK(cover.sourceLabel.lineBreakMode == NSLineBreakByTruncatingTail);
    CHECK(![cover.sourceLabel.text containsString:@"content_title"] && ![cover.sourceLabel.text containsString:@"探马"]);
    CHECK([((WCDataItem *)linkCard.item).contentObj.linkUrl isEqual:longLink]);
    CHECK(((WCContentItemViewTemplateNews *)cover.nativeOwner).item == linkCard.item);
    [cell addSubview:cover];
    [cover.nativeTap fire];
    CHECK([(WCContentItemViewTemplateNews *)cover.nativeOwner opens] == 1);
    [cover removeFromSuperview];

    linkCard.sourceText = @"";
    cover = Cover(linkCard, nil, ^BOOL { return YES; });
    CHECK(cover.compact && [cover.sourceLabel.text isEqual:@"网页链接"]);
    UILabel *fallback = CSMomentsShareFallback(linkCard, [UIViewController new]);
    CHECK([fallback.text isEqual:@"探马"] && fallback.numberOfLines == 2);
    CHECK(fallback.lineBreakMode == NSLineBreakByTruncatingTail && ![fallback.text containsString:@"https://"]);

    // Published covers retain their normal image proportions.
    linkCard.media = [NSObject new];
    CHECK(CGSizeEqualToSize(CSMomentsSharedCoverSize(linkCard, 180), CGSizeMake(1, 0.65)));
    linkCard.media = nil;
    linkCard.shareCoverURL = @"https://example.invalid/link-cover.jpg";
    CHECK(CGSizeEqualToSize(CSMomentsSharedCoverSize(linkCard, 180), CGSizeMake(1, 0.65)));
    cover = Cover(linkCard, nil, ^BOOL { return YES; });
    CHECK(!cover.compact && [cover.thumbnail isKindOfClass:MMWebImageView.class]);
    URLLoadThrows = YES;
    cover = Cover(linkCard, nil, ^BOOL { return YES; });
    CHECK(!cover.compact && [cover.thumbnail isKindOfClass:UILabel.class]);
    CHECK([(UILabel *)cover.thumbnail numberOfLines] == 2);
    CHECK(CGSizeEqualToSize(CSMomentsSharedCoverSize(linkCard, 180), CGSizeMake(1, 0.65)));
    CHECK(![cover.sourceLabel.text containsString:@"content_title"]);
    URLLoadThrows = NO;

    // A native model/class mismatch keeps presentation usable without attaching
    // a guessed action owner to the card.
    article.item = [NSObject new];
    article.shareCoverURL = @"https://example.invalid/article.jpg";
    cover = Cover(article, nil, ^BOOL { return YES; });
    CHECK(cover.nativeOwner == nil && cover.nativeTap == nil);
    CHECK([cover.thumbnail isKindOfClass:MMWebImageView.class] && cover.sourceLabel.text.length);

    // Absent, malformed and unavailable thumbnail contracts retain readable content.
    for (NSString *URL in @[@"", @"http://["]) {
        live.shareCoverURL = URL;
        cover = Cover(live, nil, ^BOOL { return NO; });
        CHECK([cover.thumbnail isKindOfClass:UILabel.class]);
        CHECK([(UILabel *)cover.thumbnail text].length > 0);
        CHECK(CGRectGetWidth(cover.thumbnail.frame) > 0 && CGRectGetHeight(cover.thumbnail.frame) > 0);
    }
    URLLoadThrows = YES;
    live.shareCoverURL = @"https://example.invalid/unavailable.jpg";
    cover = Cover(live, nil, ^BOOL { return NO; });
    CHECK([cover.thumbnail isKindOfClass:UILabel.class] && [(UILabel *)cover.thumbnail text].length > 0);
    URLLoadThrows = NO;

    printf("Moments shared cover: %lu checks passed (production adapter, native routing, thumbnail URL, compact icon, fallback, gesture cleanup).\n", (unsigned long)Checks);
} return 0; }
