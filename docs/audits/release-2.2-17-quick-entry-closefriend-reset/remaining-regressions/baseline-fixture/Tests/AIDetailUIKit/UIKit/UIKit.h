#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,UIApplicationState){UIApplicationStateActive,UIApplicationStateInactive,UIApplicationStateBackground};
@interface UIApplication : NSObject
+ (instancetype)sharedApplication;
@property(nonatomic) UIApplicationState applicationState;
@end
@interface UIView : NSObject
@property(nonatomic,strong) id window;
@end
@interface UISwitch : UIView
@property(nonatomic,getter=isOn) BOOL on;
@end
@interface UITableView : UIView
@property(nonatomic) NSUInteger reloadCount;
- (void)reloadData;
@end
@interface UIViewController : NSObject
@property(nonatomic,strong) UIView *view;
@property(nonatomic,strong) UIViewController *presentedViewController;
- (void)presentViewController:(UIViewController *)controller animated:(BOOL)animated completion:(void(^)(void))completion;
@end
@interface UITableViewController : UIViewController @end
typedef NS_ENUM(NSInteger,UIAlertControllerStyle){UIAlertControllerStyleAlert};
typedef NS_ENUM(NSInteger,UIAlertActionStyle){UIAlertActionStyleCancel};
@interface UIAlertAction : NSObject
+ (instancetype)actionWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void(^)(UIAlertAction *))handler;
@end
@interface UIAlertController : UIViewController
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)style;
- (void)addAction:(UIAlertAction *)action;
@end
FOUNDATION_EXPORT NSNotificationName const UIApplicationDidBecomeActiveNotification;
FOUNDATION_EXPORT NSNotificationName const UIApplicationDidEnterBackgroundNotification;
FOUNDATION_EXPORT NSNotificationName const UIApplicationWillEnterForegroundNotification;
FOUNDATION_EXPORT NSNotificationName const UIApplicationSignificantTimeChangeNotification;
FOUNDATION_EXPORT NSNotificationName const UIApplicationProtectedDataDidBecomeAvailable;
