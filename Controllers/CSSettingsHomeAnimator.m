#import "CSSettingsHomeAnimator.h"

@interface CSSettingsHomeAnimator ()
@property(nonatomic, strong) UIView *overlay;
@end

@implementation CSSettingsHomeAnimator
- (void)cancel {
    UIView *overlay=self.overlay;
    self.overlay=nil;
    for (UIView *group in overlay.subviews) [group.layer removeAllAnimations];
    [overlay removeFromSuperview];
}

- (CGRect)visibleFrameForTable:(UITableView *)table belowView:(UIView *)rail {
    CGRect frame=[table.superview convertRect:table.bounds fromView:table];
    CGFloat top=MAX(CGRectGetMinY(frame)+table.adjustedContentInset.top,CGRectGetMaxY(rail.frame));
    CGFloat bottom=CGRectGetMaxY(frame)-table.adjustedContentInset.bottom;
    return CGRectMake(CGRectGetMinX(frame),top,CGRectGetWidth(frame),MAX(0,bottom-top));
}

- (NSArray<UIView *> *)groupsForTable:(UITableView *)table frame:(CGRect)frame afterUpdates:(BOOL)afterUpdates {
    NSMutableArray<UIView *> *groups=[NSMutableArray array];
    CGRect visible=[table convertRect:frame fromView:table.superview];
    for (NSInteger section=0; section<table.numberOfSections; section++) {
        CGRect rect=CGRectIntersection([table rectForSection:section],visible);
        if (CGRectIsNull(rect) || CGRectIsEmpty(rect)) continue;
        // Capture the header, rounded group background, rows and accessories together.
        UIView *group=[table resizableSnapshotViewFromRect:rect afterScreenUpdates:afterUpdates withCapInsets:UIEdgeInsetsZero];
        if (!group) continue;
        group.frame=[table.superview convertRect:rect fromView:table];
        [groups addObject:group];
    }
    return groups;
}

- (void)transitionTable:(UITableView *)table belowView:(UIView *)rail updates:(void (^)(void))updates {
    [self cancel];
    if (!table.window || !table.superview) { updates(); return; }
    CGRect oldFrame=[self visibleFrameForTable:table belowView:rail];
    NSArray<UIView *> *outgoing=[self groupsForTable:table frame:oldFrame afterUpdates:NO];
    updates();
    CGRect frame=[self visibleFrameForTable:table belowView:rail];
    NSArray<UIView *> *incoming=[self groupsForTable:table frame:frame afterUpdates:YES];
    if (!incoming.count || CGRectIsEmpty(frame)) return;

    UIView *overlay=[[UIView alloc] initWithFrame:frame];
    overlay.backgroundColor=table.backgroundColor;
    overlay.clipsToBounds=YES;
    // Keep the rail responsive, but never route a tap through a fading old row.
    overlay.userInteractionEnabled=YES;
    overlay.accessibilityElementsHidden=YES;
    self.overlay=overlay;
    [table.superview insertSubview:overlay belowSubview:rail];
    BOOL reduced=UIAccessibilityIsReduceMotionEnabled();
    for (UIView *group in outgoing) {
        group.frame=CGRectOffset(group.frame,-frame.origin.x,-frame.origin.y);
        [overlay addSubview:group];
        [UIView animateWithDuration:reduced ? 0.12 : 0.14 delay:0
            options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionAllowUserInteraction
            animations:^{
                group.alpha=0;
                group.transform=reduced ? CGAffineTransformIdentity : CGAffineTransformMakeTranslation(0,160);
            } completion:nil];
    }
    __weak typeof(self) weakSelf=self;
    [incoming enumerateObjectsUsingBlock:^(UIView *group, NSUInteger index, BOOL *stop) {
        group.frame=CGRectOffset(group.frame,-frame.origin.x,-frame.origin.y);
        group.alpha=0;
        group.transform=reduced ? CGAffineTransformIdentity : CGAffineTransformMakeTranslation(0,210);
        [overlay addSubview:group];
        [UIView animateWithDuration:reduced ? 0.12 : 0.20 delay:reduced ? 0 : 0.01+MIN(index*0.02,0.04)
            options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionAllowUserInteraction
            animations:^{ group.alpha=1; group.transform=CGAffineTransformIdentity; }
            completion:^(BOOL finished) {
                // An older completion must never remove a newer rapid-switch overlay.
                if (index==incoming.count-1 && weakSelf.overlay==overlay) [weakSelf cancel];
            }];
    }];
}
@end
