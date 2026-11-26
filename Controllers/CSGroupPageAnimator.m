#import "CSGroupPageAnimator.h"
#include <math.h>

@interface CSGroupPageAnimator ()
@property(nonatomic, strong) UIView *overlay;
@property(nonatomic, strong) UIView *outgoing, *incoming;
@property(nonatomic, weak) UITableView *table;
@property(nonatomic, weak) UIView *host, *rail, *window;
@property(nonatomic) CGRect viewport;
@property(nonatomic) CGRect sourceTableFrame, sourceTableBounds, sourceRailFrame, sourceRailBounds;
@property(nonatomic) CGRect sourceHostBounds, sourceWindowBounds;
@property(nonatomic) UIEdgeInsets sourceInset;
@property(nonatomic) BOOL croppedViewport;
@property(nonatomic) NSInteger direction;
@property(nonatomic) NSUInteger generation;
@property(nonatomic, readwrite) CGFloat progress;
@property(nonatomic, readwrite, getter=isAnimating) BOOL animating;
@end

@implementation CSGroupPageAnimator
- (void)dealloc { [self cancel]; }
- (BOOL)isActive { return self.overlay != nil; }
- (BOOL)ownsTouchView:(UIView *)view {
    UIView *overlay=self.overlay;
    return overlay && view && (view==overlay || [view isDescendantOfView:overlay]);
}

- (void)cancel {
    UIView *overlay=self.overlay;
    // Removing CA animations may synchronously invoke their old completions.
    // Release ownership first so none can finish or tear down a newer attempt.
    self.generation++;
    self.overlay=nil; self.outgoing=nil; self.incoming=nil; self.animating=NO;
    self.table=nil; self.host=nil; self.rail=nil; self.window=nil;
    self.viewport=CGRectZero; self.croppedViewport=NO; self.direction=0; self.progress=0;
    for (UIView *page in overlay.subviews) [page.layer removeAllAnimations];
    [overlay.layer removeAllAnimations];
    [overlay removeFromSuperview];
}

- (CGRect)visibleFrameForTable:(UITableView *)table belowView:(UIView *)rail {
    UIView *host=table.superview;
    if (!host || !table.window || !rail || rail.window!=table.window) return CGRectZero;
    CGRect tableFrame=[host convertRect:table.bounds fromView:table];
    CGRect visible=CGRectIntersection(tableFrame,host.bounds);
    visible=CGRectIntersection(visible,[host convertRect:table.window.bounds fromView:table.window]);
    CGRect railFrame=[host convertRect:rail.bounds fromView:rail];
    CGFloat top=MAX(CGRectGetMinY(visible)+table.adjustedContentInset.top,CGRectGetMaxY(railFrame));
    CGFloat bottom=CGRectGetMaxY(visible);
    // adjustedContentInset.bottom often reserves scrolling room for a floating
    // tab bar. It is not an opaque occlusion: cover that visible lower strip too.
    CGRect frame=CGRectMake(CGRectGetMinX(visible),top,CGRectGetWidth(visible),MAX(0,bottom-top));
    if (CGRectIsNull(visible) || CGRectIsEmpty(visible) || CGRectIsEmpty(frame) ||
        !isfinite(frame.origin.x) || !isfinite(frame.origin.y) ||
        !isfinite(frame.size.width) || !isfinite(frame.size.height)) return CGRectZero;
    return frame;
}

- (UIView *)snapshotForTable:(UITableView *)table frame:(CGRect)frame afterUpdates:(BOOL)afterUpdates {
    CGRect source=[table convertRect:frame fromView:table.superview];
    UIView *snapshot=[table resizableSnapshotViewFromRect:source afterScreenUpdates:afterUpdates withCapInsets:UIEdgeInsetsZero];
    snapshot.userInteractionEnabled=NO;
    snapshot.accessibilityElementsHidden=YES;
    return snapshot;
}

- (BOOL)beginWithTable:(UITableView *)table belowView:(UIView *)rail direction:(NSInteger)direction {
    NSUInteger generation=self.generation+1;
    [self cancel];
    // A layer-removal callback may have begun a replacement while cancelling.
    if (self.generation!=generation || self.overlay) return NO;
    if ((direction!=1 && direction!=-1) || UIAccessibilityIsReduceMotionEnabled()) return NO;
    CGRect frame=[self visibleFrameForTable:table belowView:rail];
    if (CGRectIsEmpty(frame)) return NO;
    UIView *originalHost=table.superview, *originalWindow=table.window;
    UIView *snapshot=[self snapshotForTable:table frame:frame afterUpdates:NO];
    if (!snapshot || UIAccessibilityIsReduceMotionEnabled() || self.generation!=generation || table.superview!=originalHost ||
        table.window!=originalWindow ||
        !CGRectEqualToRect(frame,[self visibleFrameForTable:table belowView:rail])) return NO;
    UIView *host=table.superview;
    UIView *overlay=[[UIView alloc] initWithFrame:frame];
    overlay.backgroundColor=table.backgroundColor ?: host.backgroundColor;
    overlay.clipsToBounds=YES;
    // A cover must not send taps on an old-looking row to a new native route.
    overlay.userInteractionEnabled=YES;
    overlay.accessibilityElementsHidden=YES;
    snapshot.frame=overlay.bounds;
    [overlay addSubview:snapshot];
    self.table=table; self.host=host; self.rail=rail; self.window=table.window;
    self.sourceTableFrame=table.frame; self.sourceTableBounds=table.bounds;
    self.sourceRailFrame=rail.frame; self.sourceRailBounds=rail.bounds;
    self.sourceHostBounds=host.bounds; self.sourceWindowBounds=table.window.bounds;
    self.sourceInset=table.adjustedContentInset;
    self.viewport=frame; self.direction=direction;
    self.overlay=overlay; self.outgoing=snapshot;
    // A sibling cover does not alter table/header geometry and cannot appear in
    // the target table's own snapshot when the caller temporarily renders it.
    [host insertSubview:overlay aboveSubview:table];
    if (self.generation!=generation || self.overlay!=overlay) return NO;
    if (![self matchesTable:table belowView:rail]) { [self cancel]; return NO; }
    return YES;
}

- (BOOL)hasStableScrollGeometryForTable:(UITableView *)table belowView:(UIView *)rail {
    UIEdgeInsets inset=table.adjustedContentInset;
    return table && rail && self.table==table && self.rail==rail && self.host==table.superview &&
        self.overlay.superview==self.host && self.window && self.window==table.window &&
        CGRectEqualToRect(self.sourceTableFrame,table.frame) &&
        CGSizeEqualToSize(self.sourceTableBounds.size,table.bounds.size) && self.sourceTableBounds.origin.x==table.bounds.origin.x &&
        CGRectEqualToRect(self.sourceRailFrame,rail.frame) && CGRectEqualToRect(self.sourceRailBounds,rail.bounds) &&
        CGRectEqualToRect(self.sourceHostBounds,self.host.bounds) && CGRectEqualToRect(self.sourceWindowBounds,table.window.bounds) &&
        self.sourceInset.top==inset.top && self.sourceInset.left==inset.left &&
        self.sourceInset.bottom==inset.bottom && self.sourceInset.right==inset.right;
}
- (BOOL)matchesTable:(UITableView *)table belowView:(UIView *)rail {
    CGRect visible=[self visibleFrameForTable:table belowView:rail];
    // Rollback can restore the longer source's scroll height. The cropped
    // common viewport remains valid only inside its still-visible pixels and
    // under the original physical geometry; expansion never invents pixels.
    if (self.croppedViewport) {
        if (![self hasStableScrollGeometryForTable:table belowView:rail]) return NO;
        visible=CGRectIntersection(visible,self.viewport);
    }
    return self.overlay && self.table==table && self.rail==rail &&
        self.host==table.superview && self.overlay.superview==self.host &&
        self.window==table.window && self.window!=nil &&
        CGRectEqualToRect(self.viewport,visible);
}

- (BOOL)prepareIncomingWithTable:(UITableView *)table belowView:(UIView *)rail
                      readiness:(BOOL (^)(void))readiness {
    if (self.animating) return NO;
    // A shorter target can clamp only the table's scroll origin, bringing its
    // header/rail back on screen. Crop the existing outgoing snapshot to that
    // smaller common viewport; never stretch it or waive matchesTable's proof.
    // Replacement, rotation, inset changes and geometry expansion still reject.
    if (!self.incoming && self.overlay && self.outgoing && self.sourceTableBounds.origin.y!=table.bounds.origin.y &&
        [self hasStableScrollGeometryForTable:table belowView:rail]) {
        CGRect current=[self visibleFrameForTable:table belowView:rail], previous=self.viewport;
        if (!CGRectIsEmpty(current) && !CGRectEqualToRect(previous,current) && CGRectContainsRect(previous,current) &&
            CGRectGetMinX(current)==CGRectGetMinX(previous) && CGRectGetWidth(current)==CGRectGetWidth(previous) &&
            CGRectGetMaxY(current)==CGRectGetMaxY(previous)) {
            NSUInteger cropGeneration=self.generation;
            UIView *overlay=self.overlay, *outgoing=self.outgoing;
            [UIView performWithoutAnimation:^{
                overlay.frame=current;
                outgoing.frame=CGRectOffset(outgoing.frame,previous.origin.x-current.origin.x,previous.origin.y-current.origin.y);
            }];
            if (self.generation!=cropGeneration || self.overlay!=overlay) return NO;
            self.viewport=current; self.croppedViewport=YES;
        }
    }
    if (UIAccessibilityIsReduceMotionEnabled() || ![self matchesTable:table belowView:rail]) {
        [self cancel]; return NO;
    }
    NSUInteger generation=self.generation;
    UIView *overlay=self.overlay;
    UIView *incoming=self.incoming ?: [self snapshotForTable:table frame:self.viewport afterUpdates:YES];
    // Both UIKit capture and the caller's proof can synchronously invalidate or
    // replace this attempt. An old preparation must never remove a newer cover.
    if (self.generation!=generation || self.overlay!=overlay) return NO;
    BOOL ready=incoming && (!readiness || readiness());
    if (self.generation!=generation || self.overlay!=overlay) return NO;
    if (!ready || UIAccessibilityIsReduceMotionEnabled() || ![self matchesTable:table belowView:rail]) {
        [self cancel]; return NO;
    }
    if (!self.incoming) {
        incoming.frame=overlay.bounds;
        incoming.transform=CGAffineTransformMakeTranslation(self.direction*CGRectGetWidth(overlay.bounds),0);
        [overlay addSubview:incoming];
        self.incoming=incoming;
    }
    return YES;
}

- (void)applyProgress:(CGFloat)progress {
    CGFloat distance=self.direction*CGRectGetWidth(self.overlay.bounds);
    self.progress=progress;
    self.outgoing.transform=CGAffineTransformMakeTranslation(-distance*progress,0);
    self.incoming.transform=CGAffineTransformMakeTranslation(distance*(1-progress),0);
}

- (BOOL)updateTranslation:(CGFloat)translation {
    if (self.animating) return NO;
    if (!isfinite(translation) || UIAccessibilityIsReduceMotionEnabled() ||
        ![self matchesTable:self.table belowView:self.rail]) { [self cancel]; return NO; }
    if (!self.incoming) return NO;
    CGFloat progress=MIN(1,MAX(0,-translation*self.direction/CGRectGetWidth(self.overlay.bounds)));
    // Gesture changes must track the finger exactly, even if called from within
    // an unrelated UIKit animation transaction. Only release starts an animation.
    [UIView performWithoutAnimation:^{ [self applyProgress:progress]; }];
    return YES;
}

- (void)completeGeneration:(NSUInteger)generation overlay:(UIView *)overlay committed:(BOOL)committed
                completion:(void (^)(BOOL committed))completion {
    if (self.generation!=generation || self.overlay!=overlay) return;
    [self cancel];
    // Layer removal can itself begin another attempt. Its owner must not receive
    // a completion belonging to the cover that was just removed.
    if (self.generation!=generation+1 || self.overlay) return;
    if (completion) completion(committed);
}

- (void)settleCommitting:(BOOL)commit velocity:(CGFloat)velocity
              readiness:(BOOL (^)(void))readiness completion:(void (^)(BOOL committed))completion {
    if (self.animating) return;
    NSUInteger generation=self.generation;
    UIView *overlay=self.overlay;
    if (UIAccessibilityIsReduceMotionEnabled() || !self.incoming ||
        ![self matchesTable:self.table belowView:self.rail]) {
        [self completeGeneration:generation overlay:overlay committed:NO completion:completion]; return;
    }
    BOOL ready=!readiness || readiness();
    if (self.generation!=generation || self.overlay!=overlay) return;
    if (!ready || UIAccessibilityIsReduceMotionEnabled() ||
        ![self matchesTable:self.table belowView:self.rail]) {
        [self completeGeneration:generation overlay:overlay committed:NO completion:completion]; return;
    }
    CGFloat target=commit ? 1 : 0;
    CGFloat remaining=fabs(target-self.progress);
    CGFloat distance=remaining*CGRectGetWidth(overlay.bounds);
    CGFloat speed=(commit ? -1 : 1)*self.direction*velocity;
    NSTimeInterval duration=0.28*remaining;
    if (isfinite(speed) && speed>0) duration=MIN(duration,distance/speed);
    duration=MAX(0.12,MIN(0.28,duration));
    if (distance<0.5) {
        [self completeGeneration:generation overlay:overlay committed:commit completion:completion]; return;
    }
    self.animating=YES;
    __weak typeof(self) weakSelf=self;
    [UIView animateWithDuration:duration delay:0
        options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionAllowUserInteraction
        animations:^{ [weakSelf applyProgress:target]; }
        completion:^(BOOL finished) {
            CSGroupPageAnimator *self=weakSelf;
            if (!self || self.generation!=generation || self.overlay!=overlay) return;
            BOOL ready=finished && !UIAccessibilityIsReduceMotionEnabled() &&
                [self matchesTable:self.table belowView:self.rail] && (!readiness || readiness());
            if (self.generation!=generation || self.overlay!=overlay) return;
            ready=ready && !UIAccessibilityIsReduceMotionEnabled() &&
                [self matchesTable:self.table belowView:self.rail];
            [self completeGeneration:generation overlay:overlay committed:ready && commit completion:completion];
        }];
}
@end
