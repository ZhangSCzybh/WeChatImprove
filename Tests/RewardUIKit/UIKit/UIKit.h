#import <Foundation/Foundation.h>
@class UINavigationController;
typedef NSRect CGRect;
typedef NS_OPTIONS(NSUInteger, UIViewAutoresizing) { UIViewAutoresizingFlexibleWidth = 1, UIViewAutoresizingFlexibleHeight = 2 };
@interface UIView : NSObject
@property(nonatomic, strong) NSObject *window;
@property(nonatomic) CGRect frame;
@property(nonatomic) CGRect bounds;
@property(nonatomic) BOOL userInteractionEnabled;
@property(nonatomic) UIViewAutoresizing autoresizingMask;
@property(nonatomic, strong) NSMutableArray *subviews;
- (void)addSubview:(UIView *)view;
@end
@interface UIViewController : NSObject
@property(nonatomic, strong) UIView *view;
@property(nonatomic, weak) UIViewController *parentViewController;
@property(nonatomic, strong) NSMutableArray<UIViewController *> *childViewControllers;
- (void)viewDidLoad;
- (void)addChildViewController:(UIViewController *)child;
- (void)didMoveToParentViewController:(UIViewController *)parent;
@property(nonatomic, weak) UINavigationController *navigationController;
@property(nonatomic, strong) UIViewController *presentedViewController;
@property(nonatomic) BOOL isBeingDismissed;
@property(nonatomic, readonly) BOOL isViewLoaded;
- (void)presentViewController:(UIViewController *)controller animated:(BOOL)animated completion:(void (^)(void))completion;
@end
@interface UINavigationController : UIViewController
@property(nonatomic, copy) NSArray<UIViewController *> *viewControllers;
@property(nonatomic, readonly) UIViewController *topViewController;
@property(nonatomic, strong) id transitionCoordinator;
@property(nonatomic) NSUInteger pushCount;
- (void)pushViewController:(UIViewController *)controller animated:(BOOL)animated;
@end
typedef NS_ENUM(NSInteger, UIAlertControllerStyle) { UIAlertControllerStyleAlert };
typedef NS_ENUM(NSInteger, UIAlertActionStyle) { UIAlertActionStyleCancel };
@interface UIAlertAction : NSObject
+ (instancetype)actionWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void (^)(UIAlertAction *))handler;
@end
@interface UIAlertController : UIViewController
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)style;
- (void)addAction:(UIAlertAction *)action;
@end
