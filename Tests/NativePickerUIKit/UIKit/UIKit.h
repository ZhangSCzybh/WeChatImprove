#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,UIModalPresentationStyle){UIModalPresentationFullScreen,UIModalPresentationPageSheet};
@interface UISheetPresentationControllerDetent : NSObject
+ (instancetype)mediumDetent;
+ (instancetype)largeDetent;
@end
@interface UISheetPresentationController : NSObject
@property(nonatomic,copy) NSArray *detents;
@end
@interface UIView : NSObject
@property(nonatomic) BOOL hidden;
@property(nonatomic,strong) id window;
@end
@protocol UIViewControllerTransitionCoordinatorContext <NSObject>
@property(nonatomic,readonly,getter=isCancelled) BOOL cancelled;
@end
@protocol UIViewControllerTransitionCoordinator <NSObject>
- (BOOL)animateAlongsideTransition:(void (^)(id<UIViewControllerTransitionCoordinatorContext>))animation completion:(void (^)(id<UIViewControllerTransitionCoordinatorContext>))completion;
@end
@interface UIControl : UIView
@property(nonatomic) BOOL enabled;
@end
@interface UIButton : UIControl
@property(nonatomic,copy) NSString *title;
@property(nonatomic,weak) id target;
@property(nonatomic) SEL action;
@end
@class UINavigationController;
@interface UIBarButtonItem : NSObject
@property(nonatomic) BOOL enabled;
@property(nonatomic,weak) id target;
@property(nonatomic) SEL action;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,strong) UIView *customView;
@end
@interface UINavigationItem : NSObject
@property(nonatomic,strong) UIBarButtonItem *rightBarButtonItem;
@end
@interface UIViewController : NSObject
@property(nonatomic,strong) UIView *view;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,strong) UINavigationItem *navigationItem;
@property(nonatomic,weak) UINavigationController *navigationController;
@property(nonatomic,weak) UIViewController *parentViewController;
@property(nonatomic,weak) UIViewController *presentingViewController;
@property(nonatomic,strong) UIViewController *presentedViewController;
@property(nonatomic) UIModalPresentationStyle modalPresentationStyle;
@property(nonatomic) BOOL isViewLoaded;
@property(nonatomic) BOOL isBeingDismissed;
@property(nonatomic) BOOL isMovingFromParentViewController;
@property(nonatomic,strong) id<UIViewControllerTransitionCoordinator> transitionCoordinator;
@property(nonatomic,strong) UISheetPresentationController *sheetPresentationController;
- (void)viewDidLoad;
- (void)loadViewIfNeeded;
- (void)presentViewController:(UIViewController *)controller animated:(BOOL)animated completion:(void(^)(void))completion;
- (void)dismissViewControllerAnimated:(BOOL)animated completion:(void(^)(void))completion;
@end
typedef NS_ENUM(NSInteger,UIAlertControllerStyle){UIAlertControllerStyleActionSheet,UIAlertControllerStyleAlert};
typedef NS_ENUM(NSInteger,UIAlertActionStyle){UIAlertActionStyleDefault,UIAlertActionStyleCancel};
@interface UIAlertAction : NSObject
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) void (^handler)(UIAlertAction *);
+ (instancetype)actionWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void (^)(UIAlertAction *))handler;
@end
@interface UIAlertController : UIViewController
@property(nonatomic,strong) NSMutableArray<UIAlertAction *> *actions;
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)style;
- (void)addAction:(UIAlertAction *)action;
@end
@interface UINavigationController : UIViewController
@property(nonatomic,strong) UIViewController *topViewController;
@property(nonatomic,copy) NSArray<UIViewController *> *viewControllers;
- (instancetype)initWithRootViewController:(UIViewController *)root;
- (void)pushViewController:(UIViewController *)controller animated:(BOOL)animated;
@end
@interface UITableViewController : UIViewController @end
