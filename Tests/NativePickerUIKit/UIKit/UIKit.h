#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,UIModalPresentationStyle){UIModalPresentationFullScreen};
@interface UIView : NSObject
@property(nonatomic) BOOL hidden;
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
@property(nonatomic,weak) UIViewController *presentingViewController;
@property(nonatomic,strong) UIViewController *presentedViewController;
@property(nonatomic) UIModalPresentationStyle modalPresentationStyle;
@property(nonatomic) BOOL isViewLoaded;
- (void)viewDidLoad;
- (void)loadViewIfNeeded;
- (void)presentViewController:(UIViewController *)controller animated:(BOOL)animated completion:(void(^)(void))completion;
- (void)dismissViewControllerAnimated:(BOOL)animated completion:(void(^)(void))completion;
@end
@interface UINavigationController : UIViewController
@property(nonatomic,strong) UIViewController *topViewController;
- (instancetype)initWithRootViewController:(UIViewController *)root;
@end
