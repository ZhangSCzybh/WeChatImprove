#import <Foundation/Foundation.h>
#import "CSBackgroundRunAudio.h"
#import "CSBackgroundRunPolicy.h"

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
- (void)setEnabled:(BOOL)enabled;
- (BOOL)savePolicy:(NSDictionary *)policy error:(NSError **)error;
@property(nonatomic, readonly) BOOL enabled;
@property(nonatomic, copy, readonly) NSDictionary *policy;
@property(nonatomic, readonly) BOOL usesLegacyPolicy;
/// -1 means unlimited or no successful start in this background session.
@property(nonatomic, readonly) NSTimeInterval remainingDuration;
@property(nonatomic, readonly) BOOL backgroundAudioActive;
@property(nonatomic, readonly) BOOL supportsBackgroundAudio;
@property(nonatomic, copy, readonly) NSString *statusText;
@property(nonatomic, copy, readonly) NSString *lastBackgroundResult;
@end
NS_ASSUME_NONNULL_END
