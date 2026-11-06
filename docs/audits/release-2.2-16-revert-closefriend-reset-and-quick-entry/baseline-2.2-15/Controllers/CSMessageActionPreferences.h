#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
// These values are persisted. Never reorder or renumber.
typedef NS_ENUM(NSInteger, CSMessageAction) {
    CSMessageActionDisabled = 0, CSMessageActionQuote = 1, CSMessageActionDelete = 2,
    CSMessageActionForward = 3, CSMessageActionFavorite = 4, CSMessageActionRevoke = 5,
    CSMessageActionRepeat = 6, CSMessageActionAddSticker = 7
};
typedef NS_ENUM(NSInteger, CSMessageActionEntry) {
    CSMessageActionEntryGesture, CSMessageActionEntryMenuRepeat,
    CSMessageActionEntryMenuVoiceForward, CSMessageActionEntryNativeForward,
    CSMessageActionEntryMenuAddSticker
};
typedef NS_ENUM(NSInteger, CSMessageActionDirection) {
    CSMessageActionDirectionNone = 0, CSMessageActionDirectionLeft = -1,
    CSMessageActionDirectionRight = 1
};
FOUNDATION_EXPORT NSString *const CSMessageActionGestureEnabledKey;
FOUNDATION_EXPORT NSString *const CSMessageActionRepeatEnabledKey;
FOUNDATION_EXPORT NSString *const CSMessageActionVoiceForwardEnabledKey;
FOUNDATION_EXPORT NSString *const CSMessageActionImageStickerEnabledKey;
FOUNDATION_EXPORT NSString *const CSMessageActionLeftOtherKey;
FOUNDATION_EXPORT NSString *const CSMessageActionLeftSelfKey;
FOUNDATION_EXPORT NSString *const CSMessageActionRightOtherKey;
FOUNDATION_EXPORT NSString *const CSMessageActionRightSelfKey;
// Local Foundation notification; object is the preferences instance. Delivered on main.
FOUNDATION_EXPORT NSNotificationName const CSMessageActionSettingsDidChangeNotification;
FOUNDATION_EXPORT NSString *const CSMessageActionGestureDarwinNotification;
FOUNDATION_EXPORT NSString *const CSMessageActionRepeatDarwinNotification;
FOUNDATION_EXPORT NSString *const CSMessageActionVoiceForwardDarwinNotification;

@interface CSMessageActionSettings : NSObject
@property(nonatomic, readonly) BOOL gestureEnabled;
@property(nonatomic, readonly) BOOL repeatEnabled;
@property(nonatomic, readonly) BOOL voiceForwardEnabled;
@property(nonatomic, readonly) BOOL imageStickerEnabled;
@property(nonatomic, readonly) NSUInteger version;
// Raw values remain available; unknown values are interpreted as Disabled only by policy.
@property(nonatomic, readonly) NSInteger leftOtherAction;
@property(nonatomic, readonly) NSInteger leftSelfAction;
@property(nonatomic, readonly) NSInteger rightOtherAction;
@property(nonatomic, readonly) NSInteger rightSelfAction;
- (instancetype)initWithDefaults:(NSUserDefaults *)defaults version:(NSUInteger)version;
@end

@interface CSMessageActionPreferences : NSObject
@property(nonatomic, strong, readonly) CSMessageActionSettings *snapshot;
+ (instancetype)sharedPreferences;
// Inject a unique defaults suite for host tests. Does not write defaults or register defaults.
- (instancetype)initWithDefaults:(NSUserDefaults *)defaults;
// Coalesced asynchronous main-thread refresh. Also observed on defaults/Darwin/app activation.
- (void)requestRefresh;
@end
NS_ASSUME_NONNULL_END
