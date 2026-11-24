#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// Persisted values: keep the ordering stable for existing settings and backups.
typedef NS_ENUM(NSInteger, CSInputTextGestureAction) {
    CSInputTextGestureActionDisabled = 0,
    CSInputTextGestureActionClear = 1,
    CSInputTextGestureActionCopy = 2,
    CSInputTextGestureActionCut = 3,
    CSInputTextGestureActionPaste = 4,
    CSInputTextGestureActionSend = 5,
};

FOUNDATION_EXPORT NSString *const CSInputTextGestureEnabledKey;
FOUNDATION_EXPORT NSString *const CSInputTextGestureLeftActionKey;
FOUNDATION_EXPORT NSString *const CSInputTextGestureRightActionKey;
FOUNDATION_EXPORT NSNotificationName const CSInputTextGesturePreferencesDidChangeNotification;

@interface CSInputTextGesturePreferences : NSObject
+ (BOOL)enabled;
+ (void)setEnabled:(BOOL)enabled;
+ (CSInputTextGestureAction)actionForKey:(NSString *)key;
+ (void)setAction:(CSInputTextGestureAction)action forKey:(NSString *)key;
+ (NSString *)titleForAction:(CSInputTextGestureAction)action;
@end

NS_ASSUME_NONNULL_END
