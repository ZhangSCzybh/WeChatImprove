#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
FOUNDATION_EXPORT NSNotificationName const CSSettingsHomeThemeDidChangeNotification;

/// A persisted accent scoped to the plugin homepage, independent of WeChat's appearance.
@interface CSSettingsHomeTheme : NSObject
+ (NSUInteger)selectedIndex;
+ (UIColor *)accentColor;
+ (UIColor *)colorAtIndex:(NSUInteger)index;
+ (UIColor *)customColor;
+ (UIColor *)aboutGoldColor;
+ (UIColor *)foregroundColorForAccent;
+ (void)setPresetIndex:(NSUInteger)index;
+ (void)setCustomColor:(UIColor *)color;
@end
NS_ASSUME_NONNULL_END
