#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString * const CSBackgroundBlurDefaultsSuite;
FOUNDATION_EXPORT NSString * const CSBackgroundBlurEnabledKey;
FOUNDATION_EXPORT NSString * const CSBackgroundBlurSettingsChangedNotification;

/// Main-thread lifecycle/view mutations. Return-transition snapshots stay in memory only.
@interface CSBackgroundBlurManager : NSObject
+ (instancetype)sharedManager;
/// Injectable preferences keep host-side tests away from the user's configuration.
- (instancetype)initWithDefaults:(NSUserDefaults *)defaults;
/// Called on the main thread by the tweak entry point; repeated calls are safe.
- (void)start;
@end

NS_ASSUME_NONNULL_END
