#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// Attaches scoped recognizers to existing WeChat views; never creates a window.
@interface CSQuickPanelCoordinator : NSObject
+ (void)install;
+ (void)attachToHomeBar:(UIView *)bar;
+ (void)attachToChatController:(UIViewController *)controller;
+ (void)chatControllerDidDisappear:(UIViewController *)controller;
+ (void)presentPreviewFromViewController:(UIViewController *)controller;
@end

NS_ASSUME_NONNULL_END
