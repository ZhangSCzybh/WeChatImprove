#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, UIApplicationState) { UIApplicationStateActive, UIApplicationStateInactive, UIApplicationStateBackground };
typedef NS_ENUM(NSInteger, UISceneActivationState) { UISceneActivationStateUnattached=-1, UISceneActivationStateForegroundActive, UISceneActivationStateForegroundInactive, UISceneActivationStateBackground };
typedef NSUInteger UIBackgroundTaskIdentifier;
static const UIBackgroundTaskIdentifier UIBackgroundTaskInvalid=NSUIntegerMax;
extern NSNotificationName const UIApplicationDidEnterBackgroundNotification, UIApplicationWillEnterForegroundNotification, UIApplicationDidBecomeActiveNotification;
extern NSNotificationName const UISceneDidEnterBackgroundNotification, UISceneWillEnterForegroundNotification, UISceneDidActivateNotification, UISceneDidDisconnectNotification;
@interface UIScene : NSObject
@property(nonatomic) UISceneActivationState activationState;
@end
@interface UIApplication : NSObject
+ (instancetype)sharedApplication;
@property(nonatomic) UIApplicationState applicationState;
@property(nonatomic, copy) NSSet<UIScene *> *connectedScenes;
@property(nonatomic) NSTimeInterval backgroundTimeRemaining;
- (UIBackgroundTaskIdentifier)beginBackgroundTaskWithName:(NSString *)name expirationHandler:(void (^)(void))handler;
- (void)endBackgroundTask:(UIBackgroundTaskIdentifier)identifier;
@end
