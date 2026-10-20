// Deliberately small host test double, not a claim about WeChat's actual UIKit layout.
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <dispatch/dispatch.h>
typedef struct { CGFloat top,left,bottom,right; } UIEdgeInsets;
@class UIWindow, UITableViewCell, UIViewController;
@interface NSIndexPath (MessageUIKit)
@property(nonatomic, readonly) NSInteger section;
@property(nonatomic, readonly) NSInteger row;
+ (instancetype)indexPathForRow:(NSInteger)row inSection:(NSInteger)section;
@end
@interface UIView : NSObject
@property(nonatomic) CGRect frame;
@property(nonatomic) CGRect bounds;
@property(nonatomic) CGPoint center;
@property(nonatomic) BOOL hidden;
@property(nonatomic) CGFloat alpha;
@property(nonatomic) CGAffineTransform transform;
@property(nonatomic, weak) UIWindow *window;
@property(nonatomic, weak) UIView *superview;
@property(nonatomic, strong) NSArray<UIView *> *subviews;
@property(nonatomic) NSUInteger layoutRequests;
- (CGRect)convertRect:(CGRect)rect fromView:(UIView *)view;
- (void)setNeedsLayout;
- (void)layoutIfNeeded;
+ (void)performWithoutAnimation:(void (^)(void))block;
@end
typedef NS_ENUM(NSInteger, UIApplicationState) { UIApplicationStateActive, UIApplicationStateInactive, UIApplicationStateBackground };
typedef NS_ENUM(NSInteger, UISceneActivationState) { UISceneActivationStateUnattached=-1, UISceneActivationStateForegroundActive, UISceneActivationStateForegroundInactive, UISceneActivationStateBackground };
@interface UIApplication : NSObject
@property(class,nonatomic,readonly) UIApplication *sharedApplication;
@property(nonatomic) UIApplicationState applicationState;
@end
@interface UIScene : NSObject
@property(nonatomic) UISceneActivationState activationState;
@end
@interface UIWindow : UIView
@property(nonatomic,strong) UIScene *windowScene;
@end
extern NSString *const UIApplicationWillResignActiveNotification, *const UIApplicationDidEnterBackgroundNotification, *const UIApplicationDidBecomeActiveNotification;
extern NSString *const UISceneWillDeactivateNotification, *const UISceneDidActivateNotification;
@interface UITableView : UIView
@property(nonatomic) BOOL dragging;
@property(nonatomic) BOOL decelerating;
@property(nonatomic) BOOL editing;
@property(nonatomic) BOOL hasUncommittedUpdates;
@property(nonatomic) BOOL isReloadingData;
@property(nonatomic) CGPoint contentOffset;
@property(nonatomic) CGSize contentSize;
@property(nonatomic) UIEdgeInsets adjustedContentInset;
@property(nonatomic, strong) NSArray<NSIndexPath *> *indexPathsForVisibleRows;
@property(nonatomic, strong) NSDictionary<NSIndexPath *,id> *testCells;
@property(nonatomic, strong) NSArray<NSNumber *> *testHeights;
@property(nonatomic) NSUInteger updateCount;
- (id)cellForRowAtIndexPath:(NSIndexPath *)path;
- (CGRect)rectForRowAtIndexPath:(NSIndexPath *)path;
- (CGRect)rectForSection:(NSInteger)section;
- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (void)beginUpdates;
- (void)endUpdates;
- (void)setContentOffset:(CGPoint)point animated:(BOOL)animated;
@end
@interface UIViewController : NSObject
@property(nonatomic, strong) UIView *view;
@property(nonatomic, strong) UIViewController *presentedViewController;
- (UIView *)viewIfLoaded;
- (BOOL)isBeingDismissed;
- (void)presentViewController:(UIViewController *)controller animated:(BOOL)animated completion:(void (^)(void))completion;
@end
@interface UIMenuController : NSObject
@property(class,nonatomic,readonly) UIMenuController *sharedMenuController;
@property(nonatomic) BOOL menuVisible;
@end
extern NSString *const UIMenuControllerDidHideMenuNotification;
typedef NS_ENUM(NSInteger, UIAlertControllerStyle) { UIAlertControllerStyleAlert };
typedef NS_ENUM(NSInteger, UIAlertActionStyle) { UIAlertActionStyleCancel };
@interface UIAlertAction : NSObject
+ (instancetype)actionWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void (^)(UIAlertAction *))handler;
@end
@interface UIAlertController : UIViewController
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)style;
- (void)addAction:(UIAlertAction *)action;
@end
