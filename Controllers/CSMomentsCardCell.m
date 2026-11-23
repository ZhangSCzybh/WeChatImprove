#import "CSMomentsCardCell.h"
#import "CSMomentsVisualSurface.h"
#import "CSMomentsCardModel.h"
#import "CSMomentsNativeMedia.h"
#import "CSMomentsNativeVideo.h"
#import "CSMomentsCardGeometry.h"
#import "CSCloseFriendSignatures.h"
#import <objc/message.h>
#import <objc/runtime.h>
#import <math.h>

static UIFont *CSMomentsTitleFont(UITraitCollection *traits) {
    UIFont *base = [UIFont systemFontOfSize:17 weight:UIFontWeightSemibold];
    return [[UIFontMetrics metricsForTextStyle:UIFontTextStyleSubheadline] scaledFontForFont:base maximumPointSize:21 compatibleWithTraitCollection:traits];
}

static UIFont *CSMomentsWeightedSmallFont(CGFloat size, CGFloat maximum, UIFontWeight weight, UITraitCollection *traits) {
    return [[UIFontMetrics metricsForTextStyle:UIFontTextStyleCaption1] scaledFontForFont:[UIFont systemFontOfSize:size weight:weight] maximumPointSize:maximum compatibleWithTraitCollection:traits];
}

static UIFont *CSMomentsSmallFont(CGFloat size, CGFloat maximum, UITraitCollection *traits) {
    return CSMomentsWeightedSmallFont(size, maximum, UIFontWeightRegular, traits);
}

static BOOL CSMomentsTitleMethod(Class cls, NSString *name, const char *types) {
    return cls && CSCloseFriendMethodMatches(class_getInstanceMethod(cls, NSSelectorFromString(name)), types);
}

static UIView *CSMomentsCreateNativeTitleView(void) {
    if (!NSThread.isMainThread) return nil;
    Class cellClass = NSClassFromString(@"WCTimeLineCellView");
    Class richClass = NSClassFromString(@"RichTextView");
    SEL factory = NSSelectorFromString(@"defaultContentTextView");
    if (![richClass isSubclassOfClass:UIView.class] ||
        !CSCloseFriendMethodMatches(class_getClassMethod(cellClass, factory), "@@:")) return nil;
    @try {
        // WeChat creates a new WCRichTextView here with its Moments emoji
        // parsers. A UILabel cannot render native [微笑]-style emoticon codes.
        id view = ((id (*)(id, SEL))objc_msgSend)(cellClass, factory);
        Class cls = object_getClass(view);
        if (![view isKindOfClass:richClass] || ![view isKindOfClass:UIView.class] ||
            !CSMomentsTitleMethod(cls, @"setContent:", "v@:@") ||
            !CSMomentsTitleMethod(cls, @"setOFont:", "v@:@") ||
            !CSMomentsTitleMethod(cls, @"setOTextColor:", "v@:@") ||
            !CSMomentsTitleMethod(cls, @"setFWidth:", "v@:d") ||
            !CSMomentsTitleMethod(cls, @"setLineNumber:", "v@:d") ||
            !CSMomentsTitleMethod(cls, @"sizeThatFits:", "{CGSize=dd}@:{CGSize=dd}")) return nil;
        UIView *titleView = view;
        titleView.userInteractionEnabled = NO;
        titleView.isAccessibilityElement = NO;
        titleView.accessibilityElementsHidden = YES;
        titleView.clipsToBounds = YES;
        return titleView;
    } @catch (__unused NSException *exception) {
        return nil;
    }
}

static CGFloat CSMomentsConfigureNativeTitleView(UIView *view, NSString *text, UIFont *font, CGFloat width) {
    if (!NSThread.isMainThread || !view || !text.length || !font || !isfinite(width) || width <= 0) return NAN;
    @try {
        ((void (*)(id, SEL, id))objc_msgSend)(view, NSSelectorFromString(@"setOFont:"), font);
        ((void (*)(id, SEL, id))objc_msgSend)(view, NSSelectorFromString(@"setOTextColor:"), UIColor.labelColor);
        ((void (*)(id, SEL, double))objc_msgSend)(view, NSSelectorFromString(@"setFWidth:"), width);
        // The native lineNumber property is a double, despite describing a count.
        ((void (*)(id, SEL, double))objc_msgSend)(view, NSSelectorFromString(@"setLineNumber:"), 2.0);
        ((void (*)(id, SEL, id))objc_msgSend)(view, NSSelectorFromString(@"setContent:"), text);
        CGSize size = ((CGSize (*)(id, SEL, CGSize))objc_msgSend)(view, NSSelectorFromString(@"sizeThatFits:"), CGSizeMake(width, CGFLOAT_MAX));
        return isfinite(size.height) && size.height > 0 && size.height < 1000 ? ceil(size.height) : NAN;
    } @catch (__unused NSException *exception) {
        return NAN;
    }
}

static BOOL CSMomentsTimestampIsValid(NSTimeInterval timestamp, NSDate *now) {
    // WeChat did not exist before 2011. Also reject millisecond epochs and
    // corrupt future values while allowing a small difference between clocks.
    return now && isfinite(timestamp) && timestamp >= 1293840000 && timestamp <= now.timeIntervalSince1970 + 300;
}

static NSString *CSMomentsTimestampText(NSTimeInterval timestamp, NSDate *now) {
    if (!CSMomentsTimestampIsValid(timestamp, now)) return nil;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = NSTimeZone.defaultTimeZone;
    NSDateComponents *parts = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
        | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:date];
    NSString *time = [NSString stringWithFormat:@"%02ld:%02ld", (long)parts.hour, (long)parts.minute];
    if ([calendar isDate:date inSameDayAsDate:now]) return [@"今天" stringByAppendingString:time];
    NSDate *yesterday = [calendar dateByAddingUnit:NSCalendarUnitDay value:-1 toDate:now options:0];
    if (yesterday && [calendar isDate:date inSameDayAsDate:yesterday]) return [@"昨天" stringByAppendingString:time];
    if (parts.year == [calendar component:NSCalendarUnitYear fromDate:now]) {
        return [NSString stringWithFormat:@"%02ld-%02ld %@", (long)parts.month, (long)parts.day, time];
    }
    return [NSString stringWithFormat:@"%04ld-%02ld-%02ld %@", (long)parts.year, (long)parts.month, (long)parts.day, time];
}

static CGSize CSMomentsSharedCoverSize(CSMomentsCardModel *model, CGFloat width) {
    BOOL compactMiniApp = model.contentKind == CSMomentsContentMiniApp && !model.shareCoverURL.length;
    BOOL compactLink = model.contentKind == CSMomentsContentArticle && !model.media && !model.shareCoverURL.length;
    if (compactMiniApp || compactLink) return CGSizeMake(width, MIN(88, width));
    return model.coverSize;
}

static CSMomentsCardMetrics CSMomentsMetrics(CSMomentsCardModel *model, CGFloat width, UITraitCollection *traits, UIView *nativeTitleView, BOOL *nativeTitleReady) {
    if (nativeTitleReady) *nativeTitleReady = NO;
    if (!model || !isfinite(width) || width <= 0) return (CSMomentsCardMetrics){0};
    CGFloat titleHeight = 0, lineHeight = 0;
    CGFloat innerWidth = width - 2 * CSMomentsCardContentPadding;
    if (model.title.length && innerWidth > 0) {
        UIFont *font = CSMomentsTitleFont(traits);
        UIView *measuringView = nativeTitleView ?: CSMomentsCreateNativeTitleView();
        CGFloat nativeHeight = CSMomentsConfigureNativeTitleView(measuringView, model.title, font, innerWidth);
        if (isfinite(nativeHeight)) {
            // Native layout already limits the content to two lines, including
            // emoji ascenders and spacing. Keep its full measured height.
            titleHeight = lineHeight = nativeHeight;
            if (nativeTitleReady) *nativeTitleReady = YES;
        } else {
            CGRect text = [model.title boundingRectWithSize:CGSizeMake(innerWidth, CGFLOAT_MAX)
                options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                attributes:@{NSFontAttributeName:font} context:nil];
            titleHeight = text.size.height;
            lineHeight = font.lineHeight;
        }
    }
    CGFloat timestampHeight = CSMomentsTimestampIsValid(model.timestamp, NSDate.date)
        ? CSMomentsSmallFont(12.5, 15, traits).lineHeight : 0;
    CGFloat nicknameHeight = CSMomentsWeightedSmallFont(13.5, 17, UIFontWeightSemibold, traits).lineHeight;
    CGFloat locationHeight = model.locationText.length ? CSMomentsSmallFont(12.5, 15, traits).lineHeight : 0;
    BOOL hasCover = model.media != nil || model.contentKind == CSMomentsContentFinder ||
        model.contentKind == CSMomentsContentArticle || model.contentKind == CSMomentsContentFinderLive ||
        model.contentKind == CSMomentsContentMiniApp;
    // Missing link covers and icon-only mini apps use the same compact row
    // in both collection sizing and the actual shared-cover presentation.
    CGSize coverSize = CSMomentsSharedCoverSize(model, width);
    return CSMomentsCardMeasure(hasCover, width, coverSize.width, coverSize.height,
        titleHeight, lineHeight, nicknameHeight, timestampHeight, locationHeight);
}

static NSString *CSMomentsCompactCount(NSUInteger count) {
    if (count < 1000) return [NSString stringWithFormat:@"%lu", (unsigned long)count];
    if (count < 10000) return [NSString stringWithFormat:@"%.1f千", floor(count / 100.0) / 10];
    if (count < 100000) return [NSString stringWithFormat:@"%.1f万", floor(count / 1000.0) / 10];
    if (count < 10000000) return [NSString stringWithFormat:@"%lu万", (unsigned long)(count / 10000)];
    return @"999万+";
}

static CGRect CSMomentsCardCGRect(CSMomentsCardRect rect) {
    return CGRectMake(rect.x, rect.y, rect.width, rect.height);
}

@protocol CSMomentsNativeShareConstructor <NSObject>
- (instancetype)initWithWCDataItem:(id)item showDetail:(BOOL)detail withScene:(NSUInteger)scene;
@end

@interface CSMomentsNativeShareCover : UIView
@property(nonatomic, strong) UIView *nativeOwner;
@property(nonatomic, strong) UIView *stage;
@property(nonatomic, strong) UIView *thumbnail;
@property(nonatomic, strong) UILabel *sourceLabel;
@property(nonatomic, copy) BOOL (^shouldOpen)(void);
@property(nonatomic, strong) UITapGestureRecognizer *nativeTap;
@property(nonatomic) CGSize naturalSize;
@property(nonatomic) BOOL nativePlayIcon;
@property(nonatomic) BOOL compact;
- (void)openNativeContent;
@end

@implementation CSMomentsNativeShareCover
- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview != self.superview) {
        [self.nativeTap.view removeGestureRecognizer:self.nativeTap];
        if (!newSuperview) CSMomentsReleaseCoverView(self.thumbnail);
    }
    [super willMoveToSuperview:newSuperview];
}
- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    // Apply the native share action to the whole card, including its title.
    // Removal with the cover prevents recognizers surviving cell reuse.
    if (self.superview && self.nativeTap) [self.superview addGestureRecognizer:self.nativeTap];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.compact) {
        self.stage.transform = CGAffineTransformIdentity;
        self.stage.frame = self.bounds;
        CGFloat inset = MIN(12, self.bounds.size.width / 2);
        CGFloat side = MIN(56, MAX(0, MIN(self.bounds.size.width, self.bounds.size.height) - 2 * inset));
        self.thumbnail.frame = CGRectMake(inset, (self.bounds.size.height - side) / 2, side, side);
        CGFloat textX = inset + side + (side > 0 ? 10 : 0);
        self.sourceLabel.frame = CGRectMake(textX, inset, MAX(0, self.bounds.size.width - textX - inset),
            MAX(0, self.bounds.size.height - 2 * inset));
        return;
    }
    CGFloat footer = self.sourceLabel.text.length ? 24 : 0;
    CGFloat height = MAX(0, self.bounds.size.height - footer);
    if (self.thumbnail) {
        self.stage.transform = CGAffineTransformIdentity;
        self.stage.frame = CGRectMake(0, 0, self.bounds.size.width, height);
        self.thumbnail.frame = self.stage.bounds;
    } else
    if (self.naturalSize.width > 0 && self.naturalSize.height > 0 && height > 0) {
        CGFloat scale = MIN(self.bounds.size.width / self.naturalSize.width, height / self.naturalSize.height);
        self.stage.bounds = (CGRect){CGPointZero, self.naturalSize};
        self.stage.transform = CGAffineTransformMakeScale(scale, scale);
        self.stage.center = CGPointMake(CGRectGetMidX(self.bounds), height / 2);
    }
    self.sourceLabel.frame = CGRectMake(8, height, MAX(0, self.bounds.size.width - 16), footer);
}
- (void)openNativeContent {
    if (!self.superview || !self.nativeOwner || !self.shouldOpen || !self.shouldOpen()) return;
    SEL action = NSSelectorFromString(@"throwUrlMessage");
    if (!CSMomentsTitleMethod(object_getClass(self.nativeOwner), NSStringFromSelector(action), "v@:")) return;
    @try { ((void (*)(id, SEL))objc_msgSend)(self.nativeOwner, action); }
    @catch (__unused NSException *exception) {}
}
- (void)dealloc { CSMomentsReleaseCoverView(_thumbnail); }
@end

// These overrides apply only to new card-owned instances. Native timeline
// classes and original data objects retain their existing implementations.
static void CSMomentsShareNoop(id self, SEL command) { (void)self; (void)command; }
static void CSMomentsShareNoopItem(id self, SEL command, id item) { (void)self; (void)command; (void)item; }

static Class CSMomentsShareDisplayClass(Class nativeClass, BOOL finder) {
    NSString *name = finder ? @"CSMomentsFinderDisplayOnly" : @"CSMomentsNewsActionOnly";
    NSArray<NSString *> *methods = finder ? @[@"preLoad:", @"loadFinderImages"] : @[@"initViewsWithWCDataItem:", @"layoutSubviews"];
    if (!CSMomentsTitleMethod(nativeClass, methods[0], "v@:@") ||
        !CSMomentsTitleMethod(nativeClass, methods[1], "v@:")) return Nil;
    Class existing = NSClassFromString(name);
    if (existing) {
        if (class_getSuperclass(existing) != nativeClass ||
            class_getMethodImplementation(existing, NSSelectorFromString(methods[0])) != (IMP)CSMomentsShareNoopItem ||
            class_getMethodImplementation(existing, NSSelectorFromString(methods[1])) != (IMP)CSMomentsShareNoop) return Nil;
        return existing;
    }
    Class cls = objc_allocateClassPair(nativeClass, name.UTF8String, 0);
    if (!cls) return Nil;
    if (!class_addMethod(cls, NSSelectorFromString(methods[0]), (IMP)CSMomentsShareNoopItem, "v@:@") ||
        !class_addMethod(cls, NSSelectorFromString(methods[1]), (IMP)CSMomentsShareNoop, "v@:")) {
        objc_disposeClassPair(cls);
        return Nil;
    }
    objc_registerClassPair(cls);
    return cls;
}

static UIView *CSMomentsShareURLThumbnail(NSString *originalURL) {
    if (!originalURL.length) return nil;
    Class cls = NSClassFromString(@"MMWebImageView");
    if (![cls isSubclassOfClass:UIView.class] ||
        !CSMomentsTitleMethod(cls, @"initWithFrame:", "@@:{CGRect={CGPoint=dd}{CGSize=dd}}") ||
        !CSMomentsTitleMethod(cls, @"setImageURL:", "v@:@")) return nil;
    @try {
        NSURL *url = [NSURL URLWithString:originalURL];
        if (!url.host.length || (![url.scheme.lowercaseString isEqual:@"https"] &&
            ![url.scheme.lowercaseString isEqual:@"http"])) return nil;
        UIView *view = [(UIView *)[cls alloc] initWithFrame:CGRectMake(0, 0, 160, 100)];
        view.contentMode = UIViewContentModeScaleAspectFill;
        view.clipsToBounds = YES;
        view.userInteractionEnabled = NO;
        // Only the original thumbnail field goes to WeChat's thumbnail loader.
        // Navigation always uses the native owner, never this URL.
        ((void (*)(id, SEL, id))objc_msgSend)(view, NSSelectorFromString(@"setImageURL:"), url);
        return view;
    } @catch (__unused NSException *exception) { return nil; }
}

static UILabel *CSMomentsShareFallback(CSMomentsCardModel *model, UIViewController *page) {
    UILabel *fallback = [UILabel new];
    fallback.numberOfLines = 2;
    fallback.lineBreakMode = NSLineBreakByTruncatingTail;
    fallback.textAlignment = NSTextAlignmentCenter;
    fallback.font = CSMomentsSmallFont(13, 16, page.traitCollection);
    fallback.textColor = UIColor.secondaryLabelColor;
    // Source already has its own label. Navigation keeps the original native
    // URL; a missing image must never turn its encoded query into cover text.
    fallback.text = model.title.length ? model.title : @"分享内容暂不可用";
    return fallback;
}

static UIView *CSMomentsCreateSharedCover(CSMomentsCardModel *model, UIViewController *page, UIView *thumbnail, BOOL (^shouldOpen)(void)) {
    BOOL finder = model.contentKind == CSMomentsContentFinder;
    BOOL miniApp = model.contentKind == CSMomentsContentMiniApp;
    BOOL article = model.contentKind == CSMomentsContentArticle;
    BOOL live = model.contentKind == CSMomentsContentFinderLive;
    NSString *name = finder ? @"WCContentItemFinderView" : @"WCContentItemViewTemplateNews";
    Class nativeClass = NSClassFromString(name);
    Class cls = Nil;
    UIView *native = nil;
    @try {
        // Live initialization starts native state/loading/player work. A static
        // cover leaves selection on the guarded native Moments-detail route.
        if (!live && [nativeClass isSubclassOfClass:UIView.class] && [model.item isKindOfClass:NSClassFromString(@"WCDataItem")] &&
            CSMomentsTitleMethod(nativeClass, @"initWithWCDataItem:showDetail:withScene:", "@@:@BQ") &&
            CSMomentsTitleMethod(nativeClass, @"throwUrlMessage", "v@:")) cls = CSMomentsShareDisplayClass(nativeClass, finder);
        if (cls) {
            // Finder keeps native VM/layout/thumbnail/click, but suppresses
            // preLoad: (original share attachObject writes) and fullCover loads.
            // News is action-only: its full initializer writes BSnsScene and
            // may force a data-image download. Its thumbnail is owned separately.
            id<CSMomentsNativeShareConstructor> allocated = [cls alloc];
            id initialized = [allocated initWithWCDataItem:model.item showDetail:NO withScene:0];
            if ([initialized isKindOfClass:cls]) native = initialized;
        }
        if (native && CSMomentsTitleMethod(object_getClass(native), @"setNavigationController:", "v@:@"))
            ((void (*)(id, SEL, id))objc_msgSend)(native, NSSelectorFromString(@"setNavigationController:"), page.navigationController);
    } @catch (__unused NSException *exception) { native = nil; }

    CGSize size = native.bounds.size;
    BOOL nativeLayout = finder && native && isfinite(size.width) && isfinite(size.height) && size.width > 0 && size.height > 0;
    BOOL loadedShareCover = NO;
    if (!nativeLayout && (!thumbnail || (miniApp && model.shareCoverURL.length))) {
        UIView *sharedImage = CSMomentsShareURLThumbnail(model.shareCoverURL);
        if (sharedImage) {
            CSMomentsReleaseCoverView(thumbnail);
            thumbnail = sharedImage;
            loadedShareCover = YES;
        }
    }
    CSMomentsNativeShareCover *cover = [CSMomentsNativeShareCover new];
    cover.nativeOwner = native;
    cover.naturalSize = size;
    cover.shouldOpen = shouldOpen;
    // A failed published image retains its measured cover space and uses the
    // bounded fallback. Image-less links use the same compact rule as sizing.
    cover.compact = (miniApp && !loadedShareCover) ||
        (article && !model.media && !model.shareCoverURL.length && !thumbnail);
    cover.stage = [UIView new];
    cover.stage.userInteractionEnabled = NO;
    native.userInteractionEnabled = NO;
    if (nativeLayout) {
        native.frame = (CGRect){CGPointZero, size};
        [cover.stage addSubview:native];
    } else {
        if (!thumbnail && cover.compact) {
            UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:miniApp ? @"app.dashed" : @"link"]];
            icon.tintColor = UIColor.secondaryLabelColor;
            icon.contentMode = UIViewContentModeScaleAspectFit;
            thumbnail = icon;
        }
        cover.thumbnail = thumbnail ?: CSMomentsShareFallback(model, page);
        [cover.stage addSubview:cover.thumbnail];
        // findViewController follows the hierarchy on native action owners.
        native.hidden = YES;
        if (native) [cover addSubview:native];
    }
    [cover addSubview:cover.stage];
    cover.sourceLabel = [UILabel new];
    cover.sourceLabel.text = model.sourceText;
    if (article && cover.compact && !cover.sourceLabel.text.length) cover.sourceLabel.text = @"网页链接";
    cover.sourceLabel.numberOfLines = cover.compact ? 2 : 1;
    cover.sourceLabel.font = CSMomentsSmallFont(12.5, 15, page.traitCollection);
    cover.sourceLabel.textColor = UIColor.secondaryLabelColor;
    cover.sourceLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [cover addSubview:cover.sourceLabel];
    if (nativeLayout && CSMomentsTitleMethod(object_getClass(native), @"playIconView", "@@:")) {
        id icon = ((id (*)(id, SEL))objc_msgSend)(native, NSSelectorFromString(@"playIconView"));
        cover.nativePlayIcon = [icon isKindOfClass:UIView.class] && [(UIView *)icon superview] != nil && ![(UIView *)icon isHidden];
    }
    if (native) cover.nativeTap = [[UITapGestureRecognizer alloc] initWithTarget:cover action:@selector(openNativeContent)];
    return cover;
}

@implementation CSMomentsCardCell {
    CSMomentsCardModel *_model;
    UIView *_coverView;
    UIView *_avatarView;
    UIView *_nativeTitleView;
    UILabel *_titleLabel;
    UIView *_locationView;
    UIImageView *_locationIconView;
    UILabel *_locationLabel;
    UILabel *_timestampLabel;
    UILabel *_nicknameLabel;
    UILabel *_likesLabel;
    UILabel *_commentsLabel;
    UILabel *_mediaCountLabel;
    UIImageView *_heartView;
    UIImageView *_commentView;
    UIImageView *_videoView;
}

- (CSMomentsCardModel *)model { return _model; }

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.backgroundColor = UIColor.clearColor;
        self.contentView.backgroundColor = UIColor.secondarySystemGroupedBackgroundColor;
        self.contentView.layer.cornerRadius = 14;
        self.contentView.clipsToBounds = YES;
        CSMomentsStyleCard(self);
        self.isAccessibilityElement = YES;
        self.accessibilityTraits = UIAccessibilityTraitButton;
        self.contentView.accessibilityElementsHidden = YES;

        _titleLabel = [UILabel new];
        _titleLabel.numberOfLines = 2;
        _titleLabel.textColor = UIColor.labelColor;
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _timestampLabel = [UILabel new];
        _timestampLabel.textColor = UIColor.secondaryLabelColor;
        _timestampLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _nicknameLabel = [UILabel new];
        _nicknameLabel.textColor = UIColor.labelColor;
        _nicknameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _locationView = [UIView new];
        _locationView.backgroundColor = UIColor.tertiarySystemFillColor;
        _locationView.clipsToBounds = YES;
        _locationView.userInteractionEnabled = NO;
        [self.contentView addSubview:_locationView];
        _locationIconView = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"location.fill"]];
        _locationIconView.contentMode = UIViewContentModeScaleAspectFit;
        _locationIconView.tintColor = UIColor.systemGreenColor;
        [self.contentView addSubview:_locationIconView];
        _locationLabel = [UILabel new];
        _locationLabel.textColor = UIColor.secondaryLabelColor;
        _locationLabel.numberOfLines = 1;
        _locationLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _likesLabel = [UILabel new];
        _commentsLabel = [UILabel new];
        for (UILabel *label in @[_titleLabel, _locationLabel, _timestampLabel, _nicknameLabel, _likesLabel, _commentsLabel]) {
            label.adjustsFontForContentSizeCategory = YES;
            label.isAccessibilityElement = NO;
            [self.contentView addSubview:label];
        }
        for (UILabel *label in @[_likesLabel, _commentsLabel]) {
            label.textColor = UIColor.secondaryLabelColor;
            label.lineBreakMode = NSLineBreakByTruncatingTail;
            label.adjustsFontSizeToFitWidth = YES;
            label.minimumScaleFactor = 0.65;
        }
        _heartView = [UIImageView new];
        _commentView = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"bubble.right"]];
        for (UIImageView *imageView in @[_heartView, _commentView]) {
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.tintColor = UIColor.secondaryLabelColor;
            [self.contentView addSubview:imageView];
        }
        _videoView = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"play.fill"]];
        _videoView.tintColor = UIColor.whiteColor;
        _videoView.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.35];
        _videoView.contentMode = UIViewContentModeCenter;
        _videoView.layer.cornerRadius = 12;
        _videoView.clipsToBounds = YES;
        [self.contentView addSubview:_videoView];
        _mediaCountLabel = [UILabel new];
        _mediaCountLabel.adjustsFontForContentSizeCategory = YES;
        _mediaCountLabel.textColor = UIColor.whiteColor;
        _mediaCountLabel.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.4];
        _mediaCountLabel.textAlignment = NSTextAlignmentCenter;
        _mediaCountLabel.layer.cornerRadius = 8;
        _mediaCountLabel.clipsToBounds = YES;
        [self.contentView addSubview:_mediaCountLabel];
        [self updateFonts];
        [self endDisplaying];
    }
    return self;
}

- (void)updateFonts {
    _titleLabel.font = CSMomentsTitleFont(self.traitCollection);
    _timestampLabel.font = _locationLabel.font = CSMomentsSmallFont(12.5, 15, self.traitCollection);
    _nicknameLabel.font = CSMomentsWeightedSmallFont(13.5, 17, UIFontWeightSemibold, self.traitCollection);
    _likesLabel.font = _commentsLabel.font = CSMomentsSmallFont(12, 14, self.traitCollection);
    _mediaCountLabel.font = CSMomentsWeightedSmallFont(12, 14, UIFontWeightMedium, self.traitCollection);
}

+ (CGFloat)heightForModel:(CSMomentsCardModel *)model width:(CGFloat)width {
    return CSMomentsMetrics(model, width, nil, nil, NULL).height;
}

- (void)configureWithModel:(CSMomentsCardModel *)model {
    // Display can resume after endDisplaying with the very same model instance.
    [self endDisplaying];
    _model = model;
    [self updateFonts];
    _titleLabel.text = model.title;
    _titleLabel.hidden = !model.title.length;
    if (model.title.length) {
        _nativeTitleView = CSMomentsCreateNativeTitleView();
        if (_nativeTitleView) [self.contentView addSubview:_nativeTitleView];
    }
    _timestampLabel.text = CSMomentsTimestampText(model.timestamp, NSDate.date);
    _timestampLabel.hidden = !_timestampLabel.text.length;
    _locationLabel.text = model.locationText;
    _locationView.hidden = _locationIconView.hidden = _locationLabel.hidden = !model.locationText.length;
    _nicknameLabel.text = model.nickname.length ? model.nickname : model.username;
    _likesLabel.text = CSMomentsCompactCount(model.likes);
    _commentsLabel.text = CSMomentsCompactCount(model.comments);
    _heartView.image = [UIImage systemImageNamed:model.liked ? @"heart.fill" : @"heart"];
    _heartView.tintColor = model.liked ? UIColor.systemRedColor : UIColor.secondaryLabelColor;
    _heartView.hidden = _commentView.hidden = NO;

    if (model.media) {
        if (model.video) _coverView = CSMomentsCreateVideoCoverView(model.item, model.media);
        if (!_coverView) _coverView = CSMomentsCreateCoverView(model.item, model.media);
        if (_coverView) {
            _coverView.contentMode = UIViewContentModeScaleAspectFill;
        } else {
            UIImage *placeholder = [UIImage systemImageNamed:@"photo" withConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:28]];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:placeholder];
            imageView.contentMode = UIViewContentModeCenter;
            imageView.tintColor = UIColor.tertiaryLabelColor;
            imageView.backgroundColor = UIColor.tertiarySystemFillColor;
            _coverView = imageView;
        }
        _coverView.userInteractionEnabled = NO;
        _coverView.isAccessibilityElement = NO;
        _coverView.accessibilityElementsHidden = YES;
        _coverView.clipsToBounds = YES;
        [self.contentView insertSubview:_coverView atIndex:0];
    }
    _avatarView = CSMomentsCreateAvatarView(model.username, CGSizeMake(CSMomentsCardAvatarSide, CSMomentsCardAvatarSide));
    if (!_avatarView) {
        UIImageView *fallback = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"person.crop.circle.fill"]];
        fallback.tintColor = UIColor.tertiaryLabelColor;
        fallback.contentMode = UIViewContentModeScaleAspectFit;
        _avatarView = fallback;
    }
    _avatarView.userInteractionEnabled = NO;
    _avatarView.isAccessibilityElement = NO;
    _avatarView.accessibilityElementsHidden = YES;
    _avatarView.layer.cornerRadius = CSMomentsCardAvatarSide / 2;
    _avatarView.clipsToBounds = YES;
    [self.contentView addSubview:_avatarView];
    // Native video nodes own the play icon and its playback-state visibility.
    // The card badge is only needed when video creation fell back to a still.
    _videoView.hidden = !model.media || !model.video || CSMomentsVideoCoverViewInView(_coverView) != nil;
    _mediaCountLabel.hidden = !model.media || model.mediaCount <= 1;
    _mediaCountLabel.text = model.mediaCount > 1 ? [NSString stringWithFormat:@"%lu张", (unsigned long)model.mediaCount] : nil;
    self.accessibilityLabel = [NSString stringWithFormat:@"%@，%@，%lu个赞，%lu条评论",
        model.title ?: @"", _nicknameLabel.text ?: @"", (unsigned long)model.likes, (unsigned long)model.comments];
    if (_timestampLabel.text.length) self.accessibilityLabel = [self.accessibilityLabel stringByAppendingFormat:@"，发布于%@", _timestampLabel.text];
    if (_locationLabel.text.length) self.accessibilityLabel = [self.accessibilityLabel stringByAppendingFormat:@"，位置%@", _locationLabel.text];
    [self setNeedsLayout];
}

- (void)configureSharedPresentationForOwner:(UIViewController *)owner shouldOpen:(BOOL (^)(void))shouldOpen {
    if (!_model || (_model.contentKind != CSMomentsContentFinder && _model.contentKind != CSMomentsContentArticle &&
        _model.contentKind != CSMomentsContentFinderLive && _model.contentKind != CSMomentsContentMiniApp)) return;
    UIView *thumbnail = (_model.contentKind == CSMomentsContentArticle || _model.contentKind == CSMomentsContentMiniApp) &&
        [_coverView isKindOfClass:NSClassFromString(@"WCImageView")] ? _coverView : nil;
    if (!thumbnail) {
        CSMomentsReleaseVideoCoverView(_coverView);
        CSMomentsReleaseCoverView(_coverView);
    }
    [_coverView removeFromSuperview];
    _coverView = CSMomentsCreateSharedCover(_model, owner, thumbnail, shouldOpen);
    _coverView.clipsToBounds = YES;
    _coverView.isAccessibilityElement = NO;
    _coverView.accessibilityElementsHidden = YES;
    [self.contentView insertSubview:_coverView atIndex:0];
    _mediaCountLabel.hidden = YES;
    BOOL nativePlay = [_coverView isKindOfClass:CSMomentsNativeShareCover.class] && ((CSMomentsNativeShareCover *)_coverView).nativePlayIcon;
    _videoView.hidden = !_model.video || nativePlay;
    if (_model.sourceText.length) self.accessibilityLabel = [self.accessibilityLabel stringByAppendingFormat:@"，来源%@", _model.sourceText];
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = CGRectGetWidth(self.contentView.bounds);
    CSMomentsLayoutCardShadow(self);
    BOOL nativeTitleReady = NO;
    CSMomentsCardMetrics metrics = CSMomentsMetrics(_model, width, self.traitCollection, _nativeTitleView, &nativeTitleReady);
    CGFloat innerWidth = MAX(0, width - 2 * CSMomentsCardContentPadding);
    _coverView.frame = CGRectMake(0, 0, width, metrics.coverHeight);
    _titleLabel.frame = CGRectMake(CSMomentsCardContentPadding, metrics.coverHeight + CSMomentsCardContentPadding, innerWidth, metrics.titleHeight);
    _nativeTitleView.frame = _titleLabel.frame;
    // If a native renderer fails at runtime, retain readable Unicode and the
    // original native emoticon codes rather than dropping text from the title.
    _nativeTitleView.hidden = !nativeTitleReady;
    _titleLabel.hidden = !_model.title.length || (_nativeTitleView && !_nativeTitleView.hidden);
    CSMomentsCardLocation location = CSMomentsCardLocationMeasure(width, metrics);
    _locationView.frame = CSMomentsCardCGRect(location.background);
    _locationView.layer.cornerRadius = metrics.locationHeight / 2;
    _locationIconView.frame = CSMomentsCardCGRect(location.icon);
    _locationLabel.frame = CSMomentsCardCGRect(location.text);
    CSMomentsCardFooter footer = CSMomentsCardFooterMeasure(width, metrics,
        ceil([_likesLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX, metrics.authorHeight)].width),
        ceil([_commentsLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX, metrics.authorHeight)].width));
    _avatarView.frame = CSMomentsCardCGRect(footer.avatar);
    _nicknameLabel.frame = CSMomentsCardCGRect(footer.nickname);
    _timestampLabel.frame = CSMomentsCardCGRect(footer.timestamp);
    _heartView.frame = CSMomentsCardCGRect(footer.likeIcon);
    _likesLabel.frame = CSMomentsCardCGRect(footer.likeCount);
    _commentView.frame = CSMomentsCardCGRect(footer.commentIcon);
    _commentsLabel.frame = CSMomentsCardCGRect(footer.commentCount);
    _videoView.frame = CGRectMake(MAX(0, width - 32), 8, 24, 24);
    CGFloat countWidth = MIN(MAX(0, width - 16), ceil([_mediaCountLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX, 20)].width) + 12);
    _mediaCountLabel.frame = CGRectMake(MAX(0, width - countWidth - 8), MAX(0, metrics.coverHeight - 28), countWidth, 20);
}

- (void)endDisplaying {
    CSMomentsReleaseVideoCoverView(_coverView);
    CSMomentsReleaseCoverView(_coverView);
    [_coverView removeFromSuperview];
    [_avatarView removeFromSuperview];
    [_nativeTitleView removeFromSuperview];
    _coverView = nil;
    _avatarView = nil;
    _nativeTitleView = nil;
    _model = nil;
    _titleLabel.text = _locationLabel.text = _timestampLabel.text = _nicknameLabel.text = _likesLabel.text = _commentsLabel.text = nil;
    _mediaCountLabel.text = nil;
    _titleLabel.hidden = _timestampLabel.hidden = _heartView.hidden = _commentView.hidden = _videoView.hidden = _mediaCountLabel.hidden = YES;
    _locationView.hidden = _locationIconView.hidden = _locationLabel.hidden = YES;
    self.accessibilityLabel = nil;
    self.contentView.alpha = 1;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self endDisplaying];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    CSMomentsStyleCard(self);
    [self updateFonts];
    [self setNeedsLayout];
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    self.contentView.alpha = highlighted ? 0.8 : 1;
}

- (void)dealloc {
    CSMomentsReleaseVideoCoverView(_coverView);
    CSMomentsReleaseCoverView(_coverView);
    [_coverView removeFromSuperview];
    [_avatarView removeFromSuperview];
    [_nativeTitleView removeFromSuperview];
}
@end
