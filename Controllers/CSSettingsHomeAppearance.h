#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *const CSHomeIconBackgroundKey;
FOUNDATION_EXPORT NSString *const CSHomeDisclosureArrowKey;
FOUNDATION_EXPORT NSNotificationName const CSSettingsHomeAppearanceDidChangeNotification;

/// Optional homepage decorations. Missing preferences retain the 2.7-6 appearance.
@interface CSSettingsHomeAppearance : NSObject
+ (BOOL)iconBackgroundEnabled;
+ (BOOL)disclosureArrowEnabled;
+ (void)setIconBackgroundEnabled:(BOOL)enabled;
+ (void)setDisclosureArrowEnabled:(BOOL)enabled;
@end

NS_ASSUME_NONNULL_END
