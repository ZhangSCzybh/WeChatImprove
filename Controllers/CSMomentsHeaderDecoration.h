#pragma once
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

// Only the named title decoration can be visually suppressed. The source,
// avatar, nickname and tap targets keep their native ownership and geometry.
@protocol CSMomentsDecorationSource <NSObject>
- (UIImageView *)m_bkgMaskView;
@end
static char CSMomentsDecorationTarget, CSMomentsDecorationMask, CSMomentsDecorationOriginal;
static inline void CSMomentsUpdateDecoration(UIView *owner, UIImageView *source) {
    UIView<CSMomentsDecorationSource> *header = (id)source.superview;
    UIImageView *next = nil;
    if ([header isKindOfClass:NSClassFromString(@"WCListHeaderView")] &&
        [header respondsToSelector:@selector(m_bkgMaskView)]) {
        UIImageView *candidate = [header m_bkgMaskView];
        if ([candidate isKindOfClass:UIImageView.class] && candidate != source &&
            candidate.superview == header && !candidate.subviews.count) next = candidate;
    }
    UIView *previous = objc_getAssociatedObject(owner, &CSMomentsDecorationTarget);
    CALayer *mask = objc_getAssociatedObject(owner, &CSMomentsDecorationMask);
    if (next == previous && (!next || next.layer.mask == mask)) return;
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    if (previous && previous.layer.mask == mask) {
        previous.layer.mask = objc_getAssociatedObject(owner, &CSMomentsDecorationOriginal);
    }
    objc_setAssociatedObject(owner, &CSMomentsDecorationOriginal, next.layer.mask, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(owner, &CSMomentsDecorationTarget, next, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (next) {
        if (!mask) mask = [CALayer layer];
        mask.frame = next.bounds;
        next.layer.mask = mask;
    }
    objc_setAssociatedObject(owner, &CSMomentsDecorationMask, next ? mask : nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [CATransaction commit];
}
