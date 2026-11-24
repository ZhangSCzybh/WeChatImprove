#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSQuickPanelActionRouter : NSObject
/// Call on main after removing the panel. YES means the native action, navigation or
/// authentication request was accepted; it does not imply authentication succeeded.
/// Existing navigation stacks are retained. Native home-owned destinations can
/// hand off to the first WeChat tab in the same window.
+ (BOOL)performActionWithIdentifier:(NSString *)identifier fromViewController:(UIViewController *)source;
@end

NS_ASSUME_NONNULL_END
