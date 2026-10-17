#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
// Injectable storage: host tests use memory only; production uses standard defaults.
@protocol CSListCornerDefaults <NSObject>
- (id _Nullable)objectForKey:(NSString *)key;
- (float)floatForKey:(NSString *)key;
- (BOOL)boolForKey:(NSString *)key;
- (void)setFloat:(float)value forKey:(NSString *)key;
- (void)setBool:(BOOL)value forKey:(NSString *)key;
- (BOOL)synchronize;
@end
FOUNDATION_EXPORT NSString * const kListCornerRadiusEnabledKey;
FOUNDATION_EXPORT NSString * const kListCornerRadiusKey;
FOUNDATION_EXPORT NSString * const kListLeftMarginKey;
FOUNDATION_EXPORT NSString * const kListRightMarginKey;
FOUNDATION_EXPORT NSString * const kListTopSessionTopMarginKey;
FOUNDATION_EXPORT NSString * const kListNormalSessionTopMarginKey;
FOUNDATION_EXPORT NSString * const kListLightModeBgColorRedKey;
FOUNDATION_EXPORT NSString * const kListLightModeBgColorGreenKey;
FOUNDATION_EXPORT NSString * const kListLightModeBgColorBlueKey;
FOUNDATION_EXPORT NSString * const kListLightModeBgColorAlphaKey;
FOUNDATION_EXPORT NSString * const kListDarkModeBgColorRedKey;
FOUNDATION_EXPORT NSString * const kListDarkModeBgColorGreenKey;
FOUNDATION_EXPORT NSString * const kListDarkModeBgColorBlueKey;
FOUNDATION_EXPORT NSString * const kListDarkModeBgColorAlphaKey;
FOUNDATION_EXPORT NSString * const kTopSessionTopMarginLightBgColorRedKey;
FOUNDATION_EXPORT NSString * const kTopSessionTopMarginLightBgColorGreenKey;
FOUNDATION_EXPORT NSString * const kTopSessionTopMarginLightBgColorBlueKey;
FOUNDATION_EXPORT NSString * const kTopSessionTopMarginLightBgColorAlphaKey;
FOUNDATION_EXPORT NSString * const kTopSessionTopMarginDarkBgColorRedKey;
FOUNDATION_EXPORT NSString * const kTopSessionTopMarginDarkBgColorGreenKey;
FOUNDATION_EXPORT NSString * const kTopSessionTopMarginDarkBgColorBlueKey;
FOUNDATION_EXPORT NSString * const kTopSessionTopMarginDarkBgColorAlphaKey;
FOUNDATION_EXPORT NSString * const kNormalSessionTopMarginLightBgColorRedKey;
FOUNDATION_EXPORT NSString * const kNormalSessionTopMarginLightBgColorGreenKey;
FOUNDATION_EXPORT NSString * const kNormalSessionTopMarginLightBgColorBlueKey;
FOUNDATION_EXPORT NSString * const kNormalSessionTopMarginLightBgColorAlphaKey;
FOUNDATION_EXPORT NSString * const kNormalSessionTopMarginDarkBgColorRedKey;
FOUNDATION_EXPORT NSString * const kNormalSessionTopMarginDarkBgColorGreenKey;
FOUNDATION_EXPORT NSString * const kNormalSessionTopMarginDarkBgColorBlueKey;
FOUNDATION_EXPORT NSString * const kNormalSessionTopMarginDarkBgColorAlphaKey;
FOUNDATION_EXPORT const CGFloat kDefaultCornerRadius;
FOUNDATION_EXPORT const CGFloat kDefaultLeftMargin;
FOUNDATION_EXPORT const CGFloat kDefaultRightMargin;
FOUNDATION_EXPORT const CGFloat kDefaultTopSessionTopMargin;
FOUNDATION_EXPORT const CGFloat kDefaultNormalSessionTopMargin;
@interface CSListCornerSnapshot : NSObject
@property(nonatomic, readonly) BOOL enabled;
@property(nonatomic, readonly) CGFloat radius, leftMargin, rightMargin, pinnedGap, normalGap;
- (UIColor *)backgroundForStyle:(UIUserInterfaceStyle)style;
- (UIColor *)pinnedColorForStyle:(UIUserInterfaceStyle)style;
- (UIColor *)normalColorForStyle:(UIUserInterfaceStyle)style;
@end
@interface CSListCornerConfiguration : NSObject
+ (instancetype)sharedConfiguration;
- (instancetype)initWithDefaults:(id<CSListCornerDefaults>)defaults;
- (CSListCornerSnapshot *)snapshot;
- (void)invalidate;
- (void)saveNumber:(CGFloat)value forKey:(NSString *)key;
- (void)saveEnabled:(BOOL)enabled;
- (void)saveColor:(UIColor *)color redKey:(NSString *)red greenKey:(NSString *)green blueKey:(NSString *)blue alphaKey:(NSString *)alpha;
@end
FOUNDATION_EXPORT UIColor *CSListCornerLoadColor(id<CSListCornerDefaults> defaults, NSString *red, NSString *green, NSString *blue, NSString *alpha, UIColor *fallback);
NS_ASSUME_NONNULL_END
