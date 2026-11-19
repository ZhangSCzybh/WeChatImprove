#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *const CSClownEnabledKey;
FOUNDATION_EXPORT NSString *const CSClownTextEnabledKey;
FOUNDATION_EXPORT NSString *const CSClownTimeEnabledKey;
FOUNDATION_EXPORT NSString *const CSClownImageEnabledKey;
FOUNDATION_EXPORT NSString *const CSClownAmountEnabledKey;
FOUNDATION_EXPORT NSString *const CSClownWarmthEnabledKey;
FOUNDATION_EXPORT NSString *const CSClownWarmthTargetsKey;
FOUNDATION_EXPORT NSString *const CSClownFakeQuoteEnabledKey;
// Delivered on the main thread after the effective settings change; object is the preferences instance.
FOUNDATION_EXPORT NSNotificationName const CSClownSettingsDidChangeNotification;

@interface CSClownSettings : NSObject
@property(nonatomic, readonly) BOOL enabled;
// Each capability includes the master switch. Disabling the master keeps the stored choices.
@property(nonatomic, readonly) BOOL textEnabled;
@property(nonatomic, readonly) BOOL timeEnabled;
@property(nonatomic, readonly) BOOL imageEnabled;
@property(nonatomic, readonly) BOOL amountEnabled;
@property(nonatomic, readonly) BOOL warmthEnabled;
@property(nonatomic, readonly) BOOL fakeQuoteEnabled;
- (NSArray<NSString *> *)warmthTargetsForAccount:(NSString *)account groups:(BOOL)groups;
- (BOOL)warmsConversation:(NSString *)conversation account:(NSString *)account;
@end

@interface CSClownPreferences : NSObject
@property(nonatomic, strong, readonly) CSClownSettings *snapshot;
+ (instancetype)sharedPreferences;
// An isolated defaults suite can be injected for tests. Construction never writes preferences.
- (instancetype)initWithDefaults:(NSUserDefaults *)defaults;
// Coalesced main-thread refresh, also requested on defaults changes and app activation.
- (void)requestRefresh;
- (void)setWarmthTargets:(NSArray<NSString *> *)names account:(NSString *)account groups:(BOOL)groups;
@end

NS_ASSUME_NONNULL_END
