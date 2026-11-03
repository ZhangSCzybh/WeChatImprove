#import <UIKit/UIKit.h>
#import "CSMessageActionCoordinator.h"
NS_ASSUME_NONNULL_BEGIN
// A cell owns one adapter; the adapter owns no page, service or account singleton.
@interface CSMessageGestureAdapter : NSObject <UIGestureRecognizerDelegate>
- (instancetype)initWithCell:(UIView *)cell coordinator:(CSMessageActionCoordinator *)coordinator;
@property(nonatomic, readonly) UIPanGestureRecognizer *pan;
@property(nonatomic, readonly) NSUInteger bindingGeneration;
- (void)bind;
- (void)invalidateBinding;
- (void)refreshForLayout;
- (void)settingsDidChange;
- (void)cancel;
- (void)detachForLayout;
- (void)reattachAfterLayout;
- (void)handlePan:(UIPanGestureRecognizer *)pan;
@end
FOUNDATION_EXPORT CSMessageGestureAdapter * _Nullable CSMessageGestureAdapterForCell(id cell, BOOL create);
FOUNDATION_EXPORT void CSMessageGestureCancelForController(id controller);
FOUNDATION_EXPORT void CSMessageGestureAccountBoundary(void);
NS_ASSUME_NONNULL_END
