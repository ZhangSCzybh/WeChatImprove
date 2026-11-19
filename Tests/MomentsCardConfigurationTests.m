#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <math.h>
#import <objc/message.h>
#import <objc/runtime.h>
#import "CSCloseFriendSignatures.h"
#import "CSMomentsCardGeometry.h"

static NSUInteger Assertions;
#define CHECK(...) do { Assertions++; if (!(__VA_ARGS__)) { \
    fprintf(stderr, "Moments card configuration FAIL %d: %s\n", __LINE__, #__VA_ARGS__); exit(1); \
} } while (0)

enum { UIViewContentModeScaleAspectFit = 1, UIViewContentModeScaleAspectFill = 2, UIViewContentModeCenter = 4 };
@interface TestLayer : NSObject
@property(nonatomic) CGFloat cornerRadius;
@end
@implementation TestLayer @end

@interface TestTraits : NSObject @end
@implementation TestTraits @end
@interface TestFont : NSObject
@property(nonatomic) CGFloat pointSize, maximumPointSize, weight;
+ (instancetype)systemFontOfSize:(CGFloat)size;
+ (instancetype)systemFontOfSize:(CGFloat)size weight:(CGFloat)weight;
@end
@implementation TestFont
+ (instancetype)systemFontOfSize:(CGFloat)size { TestFont *font = [self new]; font.pointSize = size; return font; }
+ (instancetype)systemFontOfSize:(CGFloat)size weight:(CGFloat)weight { TestFont *font = [self systemFontOfSize:size]; font.weight = weight; return font; }
@end
@interface TestFontMetrics : NSObject
+ (instancetype)metricsForTextStyle:(id)style;
- (TestFont *)scaledFontForFont:(TestFont *)font maximumPointSize:(CGFloat)maximum compatibleWithTraitCollection:(TestTraits *)traits;
@end
@implementation TestFontMetrics
+ (instancetype)metricsForTextStyle:(id)style { (void)style; return [self new]; }
- (TestFont *)scaledFontForFont:(TestFont *)font maximumPointSize:(CGFloat)maximum compatibleWithTraitCollection:(TestTraits *)traits {
    (void)traits; font.maximumPointSize = maximum; return font;
}
@end
#define UIFont TestFont
#define UIFontMetrics TestFontMetrics
#define UITraitCollection TestTraits
typedef CGFloat UIFontWeight;
#define UIFontWeightRegular 0
#define UIFontWeightMedium 0.4
#define UIFontWeightSemibold 0.6
#define UIFontTextStyleSubheadline @"subheadline"
#define UIFontTextStyleCaption1 @"caption1"

// Narrow UI boundary doubles. The real production configuration and teardown
// methods are compiled below without copying their decisions into these doubles.
@interface TestView : NSObject
@property(nonatomic, strong) TestLayer *layer;
@property(nonatomic, copy) NSString *text;
@property(nonatomic, strong) id image, tintColor, backgroundColor;
@property(nonatomic, strong) TestFont *font;
@property(nonatomic) NSInteger contentMode;
@property(nonatomic) BOOL userInteractionEnabled, isAccessibilityElement, accessibilityElementsHidden, clipsToBounds, hidden;
@property(nonatomic) BOOL ownedVideo;
@property(nonatomic) CGFloat alpha;
@property(nonatomic, weak) TestView *superview;
@property(nonatomic, strong) NSMutableArray<TestView *> *children;
- (instancetype)initWithImage:(id)image;
- (void)addSubview:(TestView *)view;
- (void)insertSubview:(TestView *)view atIndex:(NSUInteger)index;
- (void)removeFromSuperview;
@end
@implementation TestView
- (instancetype)init { if ((self = [super init])) { _layer = [TestLayer new]; _children = [NSMutableArray new]; } return self; }
- (instancetype)initWithImage:(id)image { if ((self = [self init])) _image = image; return self; }
- (void)addSubview:(TestView *)view { [view removeFromSuperview]; [self.children addObject:view]; view.superview = self; }
- (void)insertSubview:(TestView *)view atIndex:(NSUInteger)index { [view removeFromSuperview]; [self.children insertObject:view atIndex:index]; view.superview = self; }
- (void)removeFromSuperview { [self.superview.children removeObject:self]; self.superview = nil; }
@end

@interface TestImage : NSObject
+ (id)systemImageNamed:(NSString *)name;
+ (id)systemImageNamed:(NSString *)name withConfiguration:(id)configuration;
@end
@implementation TestImage
+ (id)systemImageNamed:(NSString *)name { return name; }
+ (id)systemImageNamed:(NSString *)name withConfiguration:(id)configuration { (void)configuration; return name; }
@end
@interface TestSymbols : NSObject
+ (id)configurationWithPointSize:(CGFloat)size;
@end
@implementation TestSymbols
+ (id)configurationWithPointSize:(CGFloat)size { return @(size); }
@end
@interface TestColor : NSObject
+ (id)labelColor;
+ (id)systemRedColor;
+ (id)secondaryLabelColor;
+ (id)tertiaryLabelColor;
+ (id)tertiarySystemFillColor;
@end
@implementation TestColor
+ (id)labelColor { return @"label"; }
+ (id)systemRedColor { return @"red"; }
+ (id)secondaryLabelColor { return @"secondary"; }
+ (id)tertiaryLabelColor { return @"tertiary"; }
+ (id)tertiarySystemFillColor { return @"fill"; }
@end
#define UIImage TestImage
#define UIImageView TestView
#define UIImageSymbolConfiguration TestSymbols
#define UIColor TestColor
#define UIView TestView

static BOOL NativeTextAvailable, NativeTextThrows;
static CGFloat NativeTextHeight = 42.5;
static Class NativeTextClass;
@interface RichTextView : TestView
@property(nonatomic, strong) TestFont *oFont;
@property(nonatomic, strong) id oTextColor;
@property(nonatomic) double fWidth, lineNumber;
@property(nonatomic, copy) NSString *content;
- (CGSize)sizeThatFits:(CGSize)size;
@end
@implementation RichTextView
- (void)setContent:(NSString *)content {
    if (NativeTextThrows) @throw [NSException exceptionWithName:@"NativeTextFixture" reason:nil userInfo:nil];
    _content = [content copy];
}
- (CGSize)sizeThatFits:(CGSize)size { return CGSizeMake(size.width, NativeTextHeight); }
@end
@interface WCTimeLineCellView : NSObject
+ (id)defaultContentTextView;
@end
@implementation WCTimeLineCellView
+ (id)defaultContentTextView { return NativeTextAvailable ? [NativeTextClass new] : nil; }
@end
#include "MomentsCardNativeTitleBodies.h"

@interface CSMomentsCardModel : NSObject
@property(nonatomic, strong) id item, media;
@property(nonatomic, copy) NSString *title, *username, *nickname, *locationText;
@property(nonatomic) NSUInteger likes, comments, mediaCount;
@property(nonatomic) NSTimeInterval timestamp;
@property(nonatomic) BOOL liked, video;
@end
@implementation CSMomentsCardModel @end

static TestView *NextCover, *NextAvatar;
static TestView *NextVideoCover;
static id RequestedItem, RequestedMedia;
static NSString *RequestedUsername;
static CGSize RequestedAvatarSize;
static NSUInteger CoverCreates, AvatarCreates, Releases;
static NSUInteger VideoCreates, VideoReleases;
static TestView *CSMomentsCreateVideoCoverView(id item, id media) {
    VideoCreates++; RequestedItem = item; RequestedMedia = media;
    NextVideoCover.ownedVideo = YES;
    return NextVideoCover;
}
static TestView *CSMomentsVideoCoverViewInView(TestView *view) {
    return view.ownedVideo ? view : nil;
}
static void CSMomentsReleaseVideoCoverView(TestView *view) {
    if (view.ownedVideo) { VideoReleases++; view.ownedVideo = NO; }
}
static TestView *CSMomentsCreateCoverView(id item, id media) {
    CoverCreates++; RequestedItem = item; RequestedMedia = media; return NextCover;
}
static TestView *CSMomentsCreateAvatarView(NSString *username, CGSize size) {
    AvatarCreates++; RequestedUsername = username; RequestedAvatarSize = size; return NextAvatar;
}
static void CSMomentsReleaseCoverView(TestView *view) { if (view) Releases++; }

#include "MomentsCardCountBody.h"
#include "MomentsCardTimestampBodies.h"
#include "MomentsCardFontBodies.h"
@interface CSMomentsCardCell : NSObject {
@public
    CSMomentsCardModel *_model;
    TestView *_coverView, *_avatarView, *_titleLabel, *_timestampLabel, *_nicknameLabel, *_likesLabel, *_commentsLabel;
    TestView *_nativeTitleView;
    TestView *_locationView, *_locationIconView, *_locationLabel;
    TestView *_mediaCountLabel, *_heartView, *_commentView, *_videoView;
}
@property(nonatomic, strong) TestView *contentView;
@property(nonatomic, copy) NSString *accessibilityLabel;
@property(nonatomic) NSUInteger fontUpdates, layoutRequests;
@property(nonatomic, strong) TestTraits *traitCollection;
- (void)updateFonts;
- (void)applyFonts;
- (void)setNeedsLayout;
- (void)configureWithModel:(CSMomentsCardModel *)model;
- (void)endDisplaying;
@end
@implementation CSMomentsCardCell
- (instancetype)init {
    if ((self = [super init])) {
        _contentView = [TestView new];
        _titleLabel = [TestView new]; _nicknameLabel = [TestView new]; _likesLabel = [TestView new];
        _timestampLabel = [TestView new];
        _locationView = [TestView new]; _locationIconView = [TestView new]; _locationLabel = [TestView new];
        _commentsLabel = [TestView new]; _mediaCountLabel = [TestView new];
        _heartView = [TestView new]; _commentView = [TestView new]; _videoView = [TestView new];
    }
    return self;
}
- (void)updateFonts { self.fontUpdates++; [self applyFonts]; }
- (void)setNeedsLayout { self.layoutRequests++; }
#include "MomentsCardFontConfiguration.h"
#include "MomentsCardConfigurationBodies.h"
@end

static CSMomentsCardModel *Model(void) {
    CSMomentsCardModel *model = [CSMomentsCardModel new];
    model.item = [NSObject new];
    model.media = [NSObject new];
    model.title = @"两行以内的朋友圈标题";
    model.username = @"wxid_fixture";
    model.nickname = @"很长很长的昵称会由实际 label 截断";
    model.likes = 12450;
    model.comments = 1999;
    model.mediaCount = 9;
    model.timestamp = NSDate.date.timeIntervalSince1970 - 3600;
    return model;
}

static void TestFirstCoverAndNativeAvatar(void) {
    CSMomentsCardCell *cell = [CSMomentsCardCell new];
    CSMomentsCardModel *model = Model();
    NextCover = [TestView new]; NextAvatar = [TestView new];
    [cell configureWithModel:model];
    CHECK(CoverCreates == 1 && RequestedItem == model.item && RequestedMedia == model.media);
    CHECK(cell->_coverView == NextCover && cell.contentView.children.count == 2);
    CHECK(cell->_coverView.contentMode == UIViewContentModeScaleAspectFill && cell->_coverView.clipsToBounds);
    CHECK(!cell->_coverView.userInteractionEnabled && cell->_coverView.accessibilityElementsHidden);
    CHECK(AvatarCreates == 1 && [RequestedUsername isEqual:model.username]);
    CHECK(CGSizeEqualToSize(RequestedAvatarSize, CGSizeMake(28, 28)));
    CHECK(cell->_avatarView.layer.cornerRadius == 14 && cell->_avatarView.clipsToBounds);
    CHECK([cell->_likesLabel.text isEqual:@"1.2万"] && [cell->_commentsLabel.text isEqual:@"1.9千"]);
    CHECK([cell->_mediaCountLabel.text isEqual:@"9张"] && !cell->_mediaCountLabel.hidden);
    CHECK([cell.accessibilityLabel containsString:@"12450个赞，1999条评论"]);
    CHECK(cell->_timestampLabel.text.length > 0 && !cell->_timestampLabel.hidden);
    CHECK([cell.accessibilityLabel containsString:[@"发布于" stringByAppendingString:cell->_timestampLabel.text]]);
    CHECK(cell->_videoView.hidden && [cell->_heartView.image isEqual:@"heart"]);
    CHECK(cell.fontUpdates == 1 && cell.layoutRequests == 1);
    CHECK(cell->_titleLabel.font.pointSize == 17 && cell->_titleLabel.font.maximumPointSize == 21);
    CHECK(cell->_nicknameLabel.font.pointSize == 13.5 && cell->_nicknameLabel.font.maximumPointSize == 17);
    CHECK(cell->_nicknameLabel.font.weight == UIFontWeightSemibold);
    CHECK(cell->_timestampLabel.font.pointSize == 12.5 && cell->_timestampLabel.font.maximumPointSize == 15);
    CHECK(cell->_likesLabel.font.pointSize == 12 && cell->_likesLabel.font.maximumPointSize == 14);
    CHECK(cell->_commentsLabel.font == cell->_likesLabel.font);
    CHECK(cell->_mediaCountLabel.font.pointSize == 12 && cell->_mediaCountLabel.font.maximumPointSize == 14);
    CHECK(cell->_mediaCountLabel.font.weight == UIFontWeightMedium);
    CHECK(cell->_locationView.hidden && cell->_locationIconView.hidden && cell->_locationLabel.hidden);
    TestView *oldCover = NextCover, *oldAvatar = NextAvatar;
    NextCover = [TestView new]; NextAvatar = [TestView new];
    [cell configureWithModel:model];
    CHECK(CoverCreates == 2 && Releases == 1 && cell.contentView.children.count == 2);
    CHECK(!oldCover.superview && !oldAvatar.superview && cell->_model == model);
    [cell endDisplaying];
    CHECK(Releases == 2 && !cell->_model && !cell->_coverView && !cell->_avatarView);
    CHECK(cell.contentView.children.count == 0 && !cell.accessibilityLabel && !cell->_likesLabel.text);
    CHECK(!cell->_timestampLabel.text && cell->_timestampLabel.hidden);
    [cell endDisplaying];
    CHECK(Releases == 2);
}

static void TestFallbacksAndTextOnly(void) {
    CSMomentsCardCell *cell = [CSMomentsCardCell new];
    CSMomentsCardModel *model = Model();
    NextCover = NextAvatar = nil;
    model.video = model.liked = YES;
    [cell configureWithModel:model];
    CHECK(CoverCreates == 3 && [cell->_coverView.image isEqual:@"photo"]);
    CHECK(VideoCreates == 1 && !VideoReleases);
    CHECK([cell->_avatarView.image isEqual:@"person.crop.circle.fill"] && cell->_avatarView.clipsToBounds);
    CHECK(!cell->_videoView.hidden && [cell->_heartView.image isEqual:@"heart.fill"]);
    model.media = nil; model.mediaCount = 0; model.title = @""; model.nickname = @"";
    model.likes = NSUIntegerMax; model.comments = 0;
    model.timestamp = 0;
    [cell configureWithModel:model];
    CHECK(CoverCreates == 3 && !cell->_coverView && cell.contentView.children.count == 1);
    CHECK(cell->_titleLabel.hidden && cell->_videoView.hidden && cell->_mediaCountLabel.hidden);
    CHECK([cell->_nicknameLabel.text isEqual:model.username]);
    CHECK([cell->_likesLabel.text isEqual:@"999万+"] && [cell->_commentsLabel.text isEqual:@"0"]);
    CHECK([cell.accessibilityLabel containsString:[NSString stringWithFormat:@"%lu个赞", (unsigned long)NSUIntegerMax]]);
    CHECK(!cell->_timestampLabel.text && cell->_timestampLabel.hidden);
    CHECK(![cell.accessibilityLabel containsString:@"发布于"]);
    [cell endDisplaying];
}

static void TestNativeVideoCoverReuse(void) {
    CSMomentsCardCell *cell = [CSMomentsCardCell new];
    CSMomentsCardModel *model = Model();
    model.video = YES;
    NextVideoCover = [TestView new];
    NSUInteger imageCreates = CoverCreates;
    [cell configureWithModel:model];
    TestView *firstVideo = NextVideoCover;
    CHECK(VideoCreates == 2 && CoverCreates == imageCreates);
    CHECK(cell->_coverView == firstVideo && RequestedItem == model.item && RequestedMedia == model.media);
    CHECK(!firstVideo.userInteractionEnabled && firstVideo.clipsToBounds && cell->_videoView.hidden);
    NextVideoCover = [TestView new];
    [cell configureWithModel:model];
    CHECK(VideoReleases == 1 && !firstVideo.superview && !firstVideo.ownedVideo);
    CHECK(cell->_coverView == NextVideoCover && VideoCreates == 3);
    [cell endDisplaying];
    CHECK(VideoReleases == 2 && !NextVideoCover.ownedVideo && !cell->_coverView);
    [cell endDisplaying];
    CHECK(VideoReleases == 2);
    NextVideoCover = nil;
}

static void TestLocationDisplayAndReuse(void) {
    CSMomentsCardCell *cell = [CSMomentsCardCell new];
    CSMomentsCardModel *model = Model();
    model.locationText = @"杭州市 · 马克珍妮童装（很长的位置由单行标签截断）";
    [cell configureWithModel:model];
    CHECK([cell->_locationLabel.text isEqual:model.locationText]);
    CHECK(!cell->_locationView.hidden && !cell->_locationIconView.hidden && !cell->_locationLabel.hidden);
    CHECK(cell->_locationLabel.font == cell->_timestampLabel.font);
    CHECK([cell.accessibilityLabel containsString:[@"位置" stringByAppendingString:model.locationText]]);
    [cell endDisplaying];
    CHECK(!cell->_locationLabel.text && cell->_locationView.hidden && cell->_locationIconView.hidden && cell->_locationLabel.hidden);
    model.locationText = @"";
    [cell configureWithModel:model];
    CHECK(cell->_locationView.hidden && cell->_locationIconView.hidden && cell->_locationLabel.hidden);
    CHECK(![cell.accessibilityLabel containsString:@"位置"]);
    model.locationText = nil;
    [cell configureWithModel:model];
    CHECK(cell->_locationView.hidden && !cell->_locationLabel.text);
    [cell endDisplaying];
}

static void TestCompactCountBoundaries(void) {
    const NSUInteger counts[] = {0, 999, 1000, 9999, 10000, 99999, 100000, 9999999, 10000000, NSUIntegerMax};
    NSArray *expected = @[@"0", @"999", @"1.0千", @"9.9千", @"1.0万", @"9.9万", @"10万", @"999万", @"999万+", @"999万+"];
    for (NSUInteger i = 0; i < sizeof(counts) / sizeof(*counts); i++) CHECK([CSMomentsCompactCount(counts[i]) isEqual:expected[i]]);
}

static void WrongLineNumber(__unused id self, __unused SEL selector, __unused NSUInteger count) {}

static void TestNativeEmojiTitle(void) {
    NativeTextAvailable = YES;
    NativeTextClass = RichTextView.class;
    RichTextView *first = (RichTextView *)CSMomentsCreateNativeTitleView();
    RichTextView *second = (RichTextView *)CSMomentsCreateNativeTitleView();
    CHECK(first && second && first != second);
    CHECK(!first.userInteractionEnabled && !first.isAccessibilityElement && first.accessibilityElementsHidden && first.clipsToBounds);
    NSString *text = @"👩🏽‍💻[微笑]🇨🇳1️⃣❤️[旺柴]";
    TestFont *font = [TestFont systemFontOfSize:16];
    CHECK(CSMomentsConfigureNativeTitleView(first, text, font, 156) == 43);
    CHECK([first.content isEqualToString:text] && first.oFont == font);
    CHECK([first.oTextColor isEqual:@"label"] && first.fWidth == 156 && first.lineNumber == 2.0);
    CHECK(!second.content);
    CSMomentsCardCell *cell = [CSMomentsCardCell new];
    CSMomentsCardModel *model = Model();
    model.title = text;
    [cell configureWithModel:model];
    TestView *ownedTitle = cell->_nativeTitleView;
    CHECK(ownedTitle && ownedTitle.superview == cell.contentView && cell->_model == model);
    [cell endDisplaying];
    CHECK(!cell->_nativeTitleView && !ownedTitle.superview);
    CHECK(isnan(CSMomentsConfigureNativeTitleView(first, text, font, 0)));
    CHECK(isnan(CSMomentsConfigureNativeTitleView(first, @"", font, 156)));
    NativeTextThrows = YES;
    CHECK(isnan(CSMomentsConfigureNativeTitleView(first, text, font, 156)));
    NativeTextThrows = NO;
    NativeTextHeight = NAN;
    CHECK(isnan(CSMomentsConfigureNativeTitleView(first, text, font, 156)));
    NativeTextHeight = 42.5;
    // A private API changing lineNumber to an integer must fail closed before
    // any typed native dispatch can confuse a double register with an integer.
    Class wrongABI = objc_allocateClassPair(RichTextView.class, "CSMomentsWrongTitleABI", 0);
    CHECK(wrongABI && class_addMethod(wrongABI, @selector(setLineNumber:), (IMP)WrongLineNumber, "v@:Q"));
    objc_registerClassPair(wrongABI);
    NativeTextClass = wrongABI;
    CHECK(!CSMomentsCreateNativeTitleView());
    NativeTextAvailable = NO;
    CHECK(!CSMomentsCreateNativeTitleView());
}

static NSDate *Date(NSString *value) {
    NSDate *date = [[NSISO8601DateFormatter new] dateFromString:value];
    CHECK(date != nil);
    return date;
}

static void CheckTimestamp(NSString *timestamp, NSDate *now, NSString *expected) {
    CHECK([CSMomentsTimestampText(Date(timestamp).timeIntervalSince1970, now) isEqual:expected]);
}

static void TestTimestampFormatting(void) {
    NSTimeZone *savedZone = NSTimeZone.defaultTimeZone;
    [NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    NSDate *now = Date(@"2026-11-18T15:00:00+08:00");
    CheckTimestamp(@"2026-11-18T10:23:00+08:00", now, @"今天10:23");
    CheckTimestamp(@"2026-11-17T08:09:00+08:00", now, @"昨天08:09");
    CheckTimestamp(@"2026-05-06T07:08:00+08:00", now, @"05-06 07:08");
    CheckTimestamp(@"2025-12-31T23:59:00+08:00", now, @"2025-12-31 23:59");
    CheckTimestamp(@"2011-01-01T08:00:00+08:00", now, @"2011-01-01 08:00");
    CheckTimestamp(@"2026-11-17T23:55:00Z", now, @"今天07:55");
    NSDate *newYear = Date(@"2026-01-01T00:15:00+08:00");
    CheckTimestamp(@"2025-12-31T23:50:00+08:00", newYear, @"昨天23:50");
    const NSTimeInterval invalid[] = {0, -1, 1, 1293839999, NAN, INFINITY, -INFINITY, 1794985200000};
    for (NSUInteger i = 0; i < sizeof(invalid) / sizeof(*invalid); i++) CHECK(!CSMomentsTimestampText(invalid[i], now));
    CHECK(!CSMomentsTimestampText(now.timeIntervalSince1970 + 301, now));
    CHECK([CSMomentsTimestampText(now.timeIntervalSince1970 + 300, now) isEqual:@"今天15:05"]);
    CHECK(!CSMomentsTimestampText(now.timeIntervalSince1970, nil));
    [NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneWithName:@"America/Los_Angeles"]];
    NSDate *afterDST = Date(@"2026-03-09T00:15:00-07:00");
    CheckTimestamp(@"2026-03-08T00:05:00-08:00", afterDST, @"昨天00:05");
    NSDate *afterFallDST = Date(@"2026-11-02T00:15:00-08:00");
    CheckTimestamp(@"2026-11-01T00:05:00-07:00", afterFallDST, @"昨天00:05");
    [NSTimeZone setDefaultTimeZone:savedZone];
}

int main(void) {
    @autoreleasepool {
        TestFirstCoverAndNativeAvatar();
        TestFallbacksAndTextOnly();
        TestNativeVideoCoverReuse();
        TestCompactCountBoundaries();
        TestNativeEmojiTitle();
        TestTimestampFormatting();
        TestLocationDisplayAndReuse();
        printf("Moments card configuration: %lu checks passed (production configure/cleanup, first cover, video reuse/fallback, native emoji text/ABI, larger fonts, counts, timestamp/timezone/DST, optional location).\n", (unsigned long)Assertions);
    }
    return 0;
}
