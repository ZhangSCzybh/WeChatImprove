#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSQuickPanelActionRouter : NSObject
/// Call on main after removing the panel. YES means the native navigation or
/// authentication request was accepted; it does not imply authentication succeeded.
/// The existing source navigation stack is retained and no tab is selected.
+ (BOOL)performActionWithIdentifier:(NSString *)identifier fromViewController:(UIViewController *)source;
@end

NS_ASSUME_NONNULL_END
