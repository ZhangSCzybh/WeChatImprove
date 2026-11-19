#import "CSMomentsHeaderBackdrop.h"
#import "CSMomentsFadeGeometry.h"
#import "CSMomentsHeaderDecoration.h"
#import "CSCloseFriendSignatures.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/message.h>
#import <objc/runtime.h>
#import <math.h>

static char BackdropKey;
@implementation CSMomentsBackdropCollectionView
- (void)layoutSubviews {
    [super layoutSubviews];
    UIView *background = self.contentBackground;
    if (background.superview == self && self.subviews.firstObject != background)
        [self sendSubviewToBack:background];
}
@end

static BOOL ValidRect(CGRect rect) {
    return isfinite(rect.origin.x) && isfinite(rect.origin.y) &&
        isfinite(rect.size.width) && isfinite(rect.size.height) &&
        rect.size.width > 0 && rect.size.height > 0;
}

static id HeaderObject(UIView *header, NSString *name) {
    SEL selector = NSSelectorFromString(name);
    if (!CSCloseFriendMethodMatches(class_getInstanceMethod(object_getClass(header), selector), "@@:")) return nil;
    return ((id (*)(id, SEL))objc_msgSend)(header, selector);
}

// 8.0.80.34 WCListHeaderView is an MMUIView, despite the older local class
// dump declaring NSObject. Its background getter is @16@0:8. Native cover
// reload adds it directly to the header and sends it behind the foreground.
static BOOL ForegroundIsAboveCover(UIView *header, UIImageView *source, NSUInteger sourceIndex) {
    BOOL foundForeground = NO;
    for (NSString *name in @[@"m_headImageView", @"m_nickLabel", @"nicknameContainerView"]) {
        id object = HeaderObject(header, name);
        if (!object) continue;
        if (![object isKindOfClass:UIView.class]) return NO;
        UIView *child = object;
        while (child.superview && child.superview != header) child = child.superview;
        if (child.superview != header || child == source) return NO;
        NSUInteger index = [header.subviews indexOfObjectIdenticalTo:child];
        if (index == NSNotFound || index <= sourceIndex) return NO;
        foundForeground = YES;
    }
    return foundForeground;
}

@interface CSMomentsHeaderBackdropView : UIView
@property(nonatomic, weak) UIImageView *source;
@property(nonatomic, weak) UIView *contentBackground;
@property(nonatomic) CGFloat firstCardTop, nicknameBottom, headerTop;
@property(nonatomic, strong) UIColor *originalHeaderColor;
@property(nonatomic, strong) CALayer *originalSourceMask;
@property(nonatomic, strong) CALayer *suppressionMask;
@property(nonatomic) CGFloat pullDistance;
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) CAGradientLayer *fadeLayer;
@end

@implementation CSMomentsHeaderBackdropView
- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.userInteractionEnabled = NO;
        self.clipsToBounds = YES;
        self.backgroundColor = UIColor.clearColor;
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.userInteractionEnabled = NO;
        _imageView.clipsToBounds = YES;
        [self addSubview:_imageView];
        _fadeLayer = [CAGradientLayer layer];
        _fadeLayer.startPoint = CGPointMake(0.5, 0);
        _fadeLayer.endPoint = CGPointMake(0.5, 1);
        UIColor *opaque = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        UIColor *clear = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        NSMutableArray *colors = [NSMutableArray arrayWithObject:(__bridge id)opaque.CGColor];
        for (NSUInteger step = 0; step <= 10; step++) {
            CGFloat t = step / 10.0;
            CGFloat alpha = 1 - t * t * (3 - 2 * t);
            [colors addObject:(__bridge id)[UIColor colorWithRed:0 green:0 blue:0 alpha:alpha].CGColor];
        }
        [colors addObject:(__bridge id)clear.CGColor];
        _fadeLayer.colors = colors;
        _imageView.layer.mask = _fadeLayer;
        // A transparent native-cover mask preserves its view and hit testing.
        // Without it, the original opaque pixels would show through the copy.
        _suppressionMask = [CALayer layer];
    }
    return self;
}
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    [self setNeedsLayout];
}
#pragma clang diagnostic pop
- (void)layoutSubviews {
    [super layoutSubviews];
    // Native image updates remain authoritative; no snapshots, URL loaders or
    // retained native cover are introduced by this view.
    self.imageView.image = self.source.image;
    self.imageView.alpha = self.source.alpha;
    self.hidden = !self.source || self.source.hidden || !self.source.image;
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    CSMomentsUpdateDecoration(self, self.hidden ? nil : self.source);
    CGRect cover = CGRectOffset(self.source.frame, 0, self.headerTop);
    if (self.source.contentMode == UIViewContentModeScaleAspectFill) {
        // Reveal real pixels below the native crop. Symmetric expansion keeps
        // its center and zoom identical throughout the original cover.
        CGSize image = self.imageView.image.size;
        if (image.width > 0 && image.height > 0) {
            CGFloat spare = (image.height * CGRectGetWidth(cover) / image.width - CGRectGetHeight(cover)) / 2;
            CGFloat gap = CGRectGetMaxY(self.frame) - CGRectGetMaxY(cover);
            cover = CGRectInset(cover, 0, -MAX(0, MIN(spare, gap)));
        }
    }
    self.imageView.contentMode = self.source.contentMode;
    self.imageView.layer.transform = CATransform3DIdentity;
    self.imageView.frame = CGRectMake(CGRectGetMinX(cover) - CGRectGetMinX(self.frame),
                                     CGRectGetMinY(cover) - CGRectGetMinY(self.frame),
                                     CGRectGetWidth(cover), CGRectGetHeight(cover));
    CSMomentsFadeGeometry fade = CSMomentsFadeForCover(cover, self.pullDistance,
        self.firstCardTop, self.nicknameBottom);
    self.imageView.layer.transform = CATransform3DMakeAffineTransform(
        CGAffineTransformMake(1, 0, 0, fade.scaleY, 0, fade.translateY));
    self.fadeLayer.frame = self.imageView.bounds;
    NSMutableArray *locations = [NSMutableArray arrayWithObject:@0];
    for (NSUInteger step = 0; step <= 10; step++)
        [locations addObject:@(fade.start + (fade.end - fade.start) * step / 10.0)];
    [locations addObject:@1];
    self.fadeLayer.locations = locations;
    [CATransaction commit];
}
@end

static CSMomentsHeaderBackdropView *BackdropForHeader(UIView *header) {
    CSMomentsHeaderBackdropView *backdrop = objc_getAssociatedObject(header, &BackdropKey);
    if (!backdrop) {
        backdrop = [[CSMomentsHeaderBackdropView alloc] initWithFrame:CGRectZero];
        backdrop.originalHeaderColor = header.backgroundColor;
        objc_setAssociatedObject(header, &BackdropKey, backdrop, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return backdrop;
}

static void RestoreSource(CSMomentsHeaderBackdropView *backdrop) {
    if (backdrop.source.layer.mask == backdrop.suppressionMask)
        backdrop.source.layer.mask = backdrop.originalSourceMask;
    backdrop.originalSourceMask = nil;
}

void CSMomentsHeaderBackdropRemove(UIView *header) {
    if (!NSThread.isMainThread || !header) return;
    CSMomentsHeaderBackdropView *backdrop = objc_getAssociatedObject(header, &BackdropKey);
    if (![backdrop isKindOfClass:CSMomentsHeaderBackdropView.class]) return;
    if (header.backgroundColor == UIColor.clearColor) header.backgroundColor = backdrop.originalHeaderColor;
    CSMomentsUpdateDecoration(backdrop, nil);
    RestoreSource(backdrop);
    backdrop.source = nil;
    backdrop.contentBackground = nil;
    backdrop.imageView.image = nil;
    backdrop.imageView.layer.mask = nil;
    [backdrop removeFromSuperview];
    objc_setAssociatedObject(header, &BackdropKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

BOOL CSMomentsHeaderBackdropApply(UIView *header, UIView *contentBackground, CGFloat headerTop, CGFloat firstCardTop) {
    if (!NSThread.isMainThread || ![header isKindOfClass:UIView.class]) return NO;
    @try {
        Class nativeClass = NSClassFromString(@"WCListHeaderView");
        if (!nativeClass || ![header isKindOfClass:nativeClass] || header.hidden || !ValidRect(header.bounds) ||
            ![contentBackground isKindOfClass:UIView.class] || contentBackground == header ||
            [contentBackground isDescendantOfView:header] || !isfinite(headerTop) || headerTop < 0 || !isfinite(firstCardTop) ||
            firstCardTop < CGRectGetMaxY(header.bounds) + headerTop) {
            CSMomentsHeaderBackdropRemove(header);
            return NO;
        }
        id object = HeaderObject(header, @"m_backgroundImageView");
        if (![object isKindOfClass:UIImageView.class]) {
            CSMomentsHeaderBackdropRemove(header);
            return NO;
        }
        UIImageView *source = object;
        CGRect cover = source.frame;
        NSUInteger sourceIndex = [header.subviews indexOfObjectIdenticalTo:source];
        // A changed native hierarchy must retain its native presentation. In
        // particular, never place the new layer above the avatar or nickname.
        if (source.superview != header || sourceIndex == NSNotFound || source.hidden ||
            ![source.image isKindOfClass:UIImage.class] || !isfinite(source.alpha) || source.alpha <= 0 ||
            !ValidRect(cover) || !CATransform3DIsIdentity(source.layer.transform) ||
            fabs(CGRectGetMinX(cover) - CGRectGetMinX(header.bounds)) > 1 ||
            fabs(CGRectGetWidth(cover) - CGRectGetWidth(header.bounds)) > 1 ||
            CGRectGetMaxY(cover) > CGRectGetMaxY(header.bounds) + 0.5 ||
            !ForegroundIsAboveCover(header, source, sourceIndex)) {
            CSMomentsHeaderBackdropRemove(header);
            return NO;
        }
        CSMomentsHeaderBackdropView *backdrop = BackdropForHeader(header);
        backdrop.contentBackground = contentBackground;
        backdrop.firstCardTop = firstCardTop;
        backdrop.headerTop = headerTop;
        CGFloat nicknameBottom = 0;
        for (NSString *name in @[@"m_nickLabel", @"nicknameContainerView"]) {
            UIView *label = HeaderObject(header, name);
            if ([label isKindOfClass:UIView.class] && !label.hidden && [label isDescendantOfView:header])
                nicknameBottom = MAX(nicknameBottom, CGRectGetMaxY([label convertRect:label.bounds toView:header]) + headerTop);
        }
        backdrop.nicknameBottom = nicknameBottom;
        CGFloat top = MIN(CGRectGetMinY(cover) + headerTop, -backdrop.pullDistance);
        CGRect frame = CGRectMake(CGRectGetMinX(header.bounds), top,
                                  CGRectGetWidth(header.bounds), firstCardTop + CSMomentsBackdropTail - top);
        if (!ValidRect(frame)) {
            CSMomentsHeaderBackdropRemove(header);
            return NO;
        }
        if (header.backgroundColor != UIColor.clearColor) backdrop.originalHeaderColor = header.backgroundColor;
        header.backgroundColor = UIColor.clearColor;
        if (backdrop.source != source) {
            // UIKit may move a mask from the retired cover to the new one.
            // A CALayer mask has one owner; restoring it onto the retired
            // cover would strip the new cover of its native mask.
            if (source.layer.mask && source.layer.mask == backdrop.originalSourceMask)
                backdrop.originalSourceMask = nil;
            RestoreSource(backdrop);
            backdrop.source = source;
        }
        if (source.layer.mask != backdrop.suppressionMask) backdrop.originalSourceMask = source.layer.mask;
        backdrop.suppressionMask.frame = source.bounds;
        source.layer.mask = backdrop.suppressionMask;
        backdrop.frame = frame;
        // Separate from the native table's clipping viewport: its rows stay
        // hidden while this photo continues behind the first waterfall cards.
        if (backdrop.superview != contentBackground) [contentBackground addSubview:backdrop];
        [backdrop setNeedsLayout];
        [backdrop layoutSubviews];
        return YES;
    } @catch (__unused NSException *exception) {
        CSMomentsHeaderBackdropRemove(header);
        return NO;
    }
}

void CSMomentsHeaderBackdropSetPullDistance(UIView *header, CGFloat distance) {
    if (!NSThread.isMainThread || !header) return;
    CSMomentsHeaderBackdropView *backdrop = objc_getAssociatedObject(header, &BackdropKey);
    if (!backdrop) return;
    CGFloat pull = isfinite(distance) ? MAX(0, distance) : 0;
    if (fabs(backdrop.pullDistance - pull) < 0.01) return;
    backdrop.pullDistance = pull;
    CSMomentsHeaderBackdropApply(header, backdrop.contentBackground, backdrop.headerTop, backdrop.firstCardTop);
}
