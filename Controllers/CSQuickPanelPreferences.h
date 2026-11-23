#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, CSQuickPanelTriggerLocations) {
    CSQuickPanelTriggerHome = 1 << 0,
    CSQuickPanelTriggerChat = 1 << 1,
};

FOUNDATION_EXPORT NSNotificationName const CSQuickPanelPreferencesDidChangeNotification;
FOUNDATION_EXPORT NSString * const CSQuickPanelEnabledKey;
FOUNDATION_EXPORT NSString * const CSQuickPanelTriggerLocationsKey;
FOUNDATION_EXPORT NSString * const CSQuickPanelSelectedActionIdentifiersKey;
FOUNDATION_EXPORT NSString * const CSQuickPanelBackgroundStyleKey;
FOUNDATION_EXPORT NSString * const CSQuickPanelBackgroundColorHexKey;
FOUNDATION_EXPORT NSString * const CSQuickPanelBackgroundOpacityKey;
FOUNDATION_EXPORT NSString * const CSQuickPanelBackgroundImagePathKey;
FOUNDATION_EXPORT NSString * const CSQuickPanelTextColorHexKey;
FOUNDATION_EXPORT NSString * const CSQuickPanelIconColorHexKey;

typedef NSString * CSQuickPanelBackgroundStyle NS_TYPED_EXTENSIBLE_ENUM;
FOUNDATION_EXPORT CSQuickPanelBackgroundStyle const CSQuickPanelBackgroundStyleDefault;
FOUNDATION_EXPORT CSQuickPanelBackgroundStyle const CSQuickPanelBackgroundStyleColor;
FOUNDATION_EXPORT CSQuickPanelBackgroundStyle const CSQuickPanelBackgroundStyleImage;

/// Stores only layout, appearance and entry preferences; never stores account/contact data.
@interface CSQuickPanelPreferences : NSObject
+ (BOOL)enabled;
+ (void)setEnabled:(BOOL)enabled;
+ (CSQuickPanelTriggerLocations)triggerLocations;
+ (void)setTriggerLocations:(CSQuickPanelTriggerLocations)locations;
/// Empty is intentional. Unknown and duplicate identifiers are removed in order.
+ (NSArray<NSString *> *)selectedActionIdentifiers;
+ (void)setSelectedActionIdentifiers:(NSArray<NSString *> *)identifiers;
+ (NSArray<NSString *> *)allActionIdentifiers;
+ (nullable NSString *)titleForActionIdentifier:(NSString *)identifier;
+ (nullable NSString *)symbolNameForActionIdentifier:(NSString *)identifier;
/// Default follows the system appearance. Color is stored as a canonical #RRGGBB string.
+ (CSQuickPanelBackgroundStyle)backgroundStyle;
+ (void)setBackgroundStyle:(CSQuickPanelBackgroundStyle)style;
+ (NSString *)backgroundColorHex;
+ (void)setBackgroundColorHex:(NSString *)colorHex;
/// Opacity affects only the background layer. 1 is opaque; 0 is transparent.
+ (double)backgroundOpacity;
+ (void)setBackgroundOpacity:(double)opacity;
/// Only a file owned by CSQuickPanelBackgroundImageStore can be published here.
+ (nullable NSString *)backgroundImagePath;
+ (void)setBackgroundImagePath:(nullable NSString *)path;
/// Clears only the four background settings and their owned image.
+ (BOOL)resetBackgroundWithError:(NSError **)error;
/// Nil follows the background contrast. Custom colors are canonical #RRGGBB strings.
+ (nullable NSString *)textColorHex;
+ (void)setTextColorHex:(nullable NSString *)colorHex;
/// Nil follows the shared interface palette, independently of the text color.
+ (nullable NSString *)iconColorHex;
+ (void)setIconColorHex:(nullable NSString *)colorHex;
/// Clears only text/icon overrides; preserves background, entries and trigger preferences.
+ (void)resetForegroundColors;
@end

NS_ASSUME_NONNULL_END
