#import <Foundation/Foundation.h>
#import "CSBackgroundRunAudio.h"

NS_ASSUME_NONNULL_BEGIN
extern NSString *const CSBackgroundRunDefaultsSuite;
extern NSString *const CSBackgroundRunEnabledKey;
extern NSNotificationName const CSBackgroundRunSettingsChangedNotification;
extern NSNotificationName const CSBackgroundRunStateChangedNotification;

@interface CSBackgroundRunManager : NSObject
+ (instancetype)sharedManager;
- (instancetype)initWithDefaults:(NSUserDefaults *)defaults audio:(id<CSBackgroundRunAudio>)audio supportsBackgroundAudio:(BOOL)supported;
- (void)start;
- (void)reloadSettings;
@property(nonatomic, readonly) BOOL enabled;
@property(nonatomic, readonly) BOOL backgroundAudioActive;
@property(nonatomic, readonly) BOOL supportsBackgroundAudio;
@property(nonatomic, copy, readonly) NSString *statusText;
@property(nonatomic, copy, readonly) NSString *lastBackgroundResult;
@end
NS_ASSUME_NONNULL_END
