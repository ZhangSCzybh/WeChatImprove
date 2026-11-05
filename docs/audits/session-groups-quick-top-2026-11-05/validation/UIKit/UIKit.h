#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
typedef struct { CGFloat top,left,bottom,right; } UIEdgeInsets;
static inline UIEdgeInsets UIEdgeInsetsMake(CGFloat t,CGFloat l,CGFloat b,CGFloat r) {return (UIEdgeInsets){t,l,b,r};}
@class UIWindow, UINavigationController;
@interface UIView : NSObject
@property(nonatomic, strong) UIWindow *window;
@property(nonatomic) CGRect bounds,frame;
@property(nonatomic) BOOL hidden,userInteractionEnabled;
@property(nonatomic,weak) UIView *superview;
- (void)addSubview:(UIView *)view;
- (void)removeFromSuperview;
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
