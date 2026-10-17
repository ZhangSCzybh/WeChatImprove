#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// Apply the existing card shape to a plugin-owned background view.
/// Reuses its mask/path; native resets and changed geometry are repaired on either display callback.
FOUNDATION_EXPORT void CSListApplyCardBackground(UIView *background, CGRect frame, CGFloat radius,
                                               BOOL first, BOOL last, UIColor *color);
/// Refresh an already-rendered card without recalculating its row/group role.
FOUNDATION_EXPORT BOOL CSListRefreshCardBackground(UIView *background, CGRect frame, CGFloat radius, UIColor *color);
NS_ASSUME_NONNULL_END
