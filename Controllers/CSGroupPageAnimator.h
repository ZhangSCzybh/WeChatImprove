#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// Drives real, equal-width list snapshots directly from a horizontal pan.
/// The caller owns preview rendering, selection, publication and privacy checks.
@interface CSGroupPageAnimator : NSObject
@property(nonatomic, readonly, getter=isActive) BOOL active;
@property(nonatomic, readonly, getter=isAnimating) BOOL animating;
@property(nonatomic, readonly) CGFloat progress;
/// +1 previews the next group (pages move left); -1 previews the previous group.
/// Capture and cover the source before the caller renders the neighboring list.
- (BOOL)beginWithTable:(UITableView *)table belowView:(UIView *)rail direction:(NSInteger)direction;
/// Capture the rendered neighbor, then prove publication is still safe to show.
/// A failed preparation cancels this cover; reentrant newer covers are preserved.
- (BOOL)prepareIncomingWithTable:(UITableView *)table belowView:(UIView *)rail
                      readiness:(BOOL (^)(void))readiness;
/// UIKit's signed horizontal pan translation, in points. Changes move both pages
/// immediately, without starting an animation; crossing back through zero clamps.
- (BOOL)updateTranslation:(CGFloat)translation;
/// Ignores contentOffset changes, but rejects a different viewport or hierarchy.
- (BOOL)matchesTable:(UITableView *)table belowView:(UIView *)rail;
/// Lets the stable list gesture receive a new swipe while this cover settles.
- (BOOL)ownsTouchView:(UIView *)view;
/// Settle from the current progress to the neighbor or back to the source.
/// Velocity uses UIKit's signed horizontal points/second. Invalid readiness or an
/// interrupted settle completes with NO. Explicit cancellation suppresses callbacks.
- (void)settleCommitting:(BOOL)commit velocity:(CGFloat)velocity
              readiness:(BOOL (^)(void))readiness completion:(void (^)(BOOL committed))completion;
/// Immediately remove both pages, including for a privacy/account invalidation.
- (void)cancel;
@end

NS_ASSUME_NONNULL_END
