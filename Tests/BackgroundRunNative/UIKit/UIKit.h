#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, UIApplicationState) { UIApplicationStateActive, UIApplicationStateInactive, UIApplicationStateBackground };
typedef NS_ENUM(NSInteger, UISceneActivationState) { UISceneActivationStateUnattached=-1, UISceneActivationStateForegroundActive, UISceneActivationStateForegroundInactive, UISceneActivationStateBackground };
extern NSNotificationName const UIApplicationDidEnterBackgroundNotification, UIApplicationWillEnterForegroundNotification, UIApplicationDidBecomeActiveNotification;
extern NSNotificationName const UISceneDidEnterBackgroundNotification, UISceneWillEnterForegroundNotification, UISceneDidActivateNotification, UISceneDidDisconnectNotification;
@interface UIScene : NSObject
@property(nonatomic) UISceneActivationState activationState;
@end
@interface UIApplication : NSObject
+ (instancetype)sharedApplication;
@property(nonatomic) UIApplicationState applicationState;
@property(nonatomic, copy) NSSet<UIScene *> *connectedScenes;
@end

typedef NS_ENUM(NSInteger, UIDeviceBatteryState) { UIDeviceBatteryStateUnknown, UIDeviceBatteryStateUnplugged, UIDeviceBatteryStateCharging, UIDeviceBatteryStateFull };
extern NSNotificationName const UIDeviceBatteryLevelDidChangeNotification, UIDeviceBatteryStateDidChangeNotification, UIApplicationSignificantTimeChangeNotification;
@interface UIDevice : NSObject
+ (instancetype)currentDevice;
@property(nonatomic) BOOL batteryMonitoringEnabled;
@property(nonatomic) float batteryLevel;
@property(nonatomic) UIDeviceBatteryState batteryState;
@end
