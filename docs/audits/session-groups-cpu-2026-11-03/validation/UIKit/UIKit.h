#import <Foundation/Foundation.h>
@class UIWindow, UINavigationController;
@interface UIView : NSObject
@property(nonatomic, strong) UIWindow *window;
@end
@interface UIViewController : NSObject
@property(nonatomic, strong) UIViewController *presentedViewController;
@property(nonatomic, strong) UINavigationController *navigationController;
@property(nonatomic, strong) UIView *viewIfLoaded;
@end
@interface UINavigationController : UIViewController
@property(nonatomic, strong) UIViewController *topViewController;
@end
@interface UITabBarController : UIViewController
@property(nonatomic, strong) UIViewController *selectedViewController;
@end
@interface UIWindow : UIView
@property(nonatomic, strong) UIViewController *rootViewController;
@end
