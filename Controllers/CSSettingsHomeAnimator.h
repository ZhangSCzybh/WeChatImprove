#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// Transitions complete visible sections while keeping the profile and Tab rail live.
@interface CSSettingsHomeAnimator : NSObject
- (void)transitionTable:(UITableView *)table belowView:(UIView *)rail updates:(void (^)(void))updates;
- (void)cancel;
@end
NS_ASSUME_NONNULL_END
