// Isolated host doubles for foreground/color application and font descriptors.
// These record UIKit attributes; they do not claim to render actual iOS glyphs.
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

typedef CGFloat UIFontWeight;
typedef NSString *UIFontTextStyle;
typedef NSString *UIFontDescriptorSystemDesign;
FOUNDATION_EXPORT UIFontWeight const UIFontWeightRegular, UIFontWeightMedium, UIFontWeightSemibold;
FOUNDATION_EXPORT UIFontTextStyle const UIFontTextStyleHeadline, UIFontTextStyleCaption1, UIFontTextStyleCaption2, UIFontTextStyleTitle2, UIFontTextStyleSubheadline;
FOUNDATION_EXPORT UIFontDescriptorSystemDesign const UIFontDescriptorSystemDesignRounded;
FOUNDATION_EXPORT NSString * const UIFontDescriptorFeatureSettingsAttribute;
FOUNDATION_EXPORT NSString * const UIFontFeatureTypeIdentifierKey;
FOUNDATION_EXPORT NSString * const UIFontFeatureSelectorIdentifierKey;
FOUNDATION_EXPORT CGFloat CSQuickPanelTestFontScale;
FOUNDATION_EXPORT BOOL CSQuickPanelTestRoundedUnavailable;

@interface UITraitCollection : NSObject
@end
@interface UIColor : NSObject
@property(nonatomic) CGFloat red,green,blue,alpha;
+ (instancetype)whiteColor;
+ (instancetype)blackColor;
+ (instancetype)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
- (UIColor *)colorWithAlphaComponent:(CGFloat)alpha;
- (BOOL)getRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha;
@end

@interface UIFontDescriptor : NSObject
@property(nonatomic,copy) NSDictionary *attributes;
- (UIFontDescriptor *)fontDescriptorWithDesign:(UIFontDescriptorSystemDesign)design;
- (UIFontDescriptor *)fontDescriptorByAddingAttributes:(NSDictionary *)attributes;
- (id)objectForKey:(NSString *)key;
@end
@interface UIFont : NSObject
@property(nonatomic) CGFloat pointSize,lineHeight;
@property(nonatomic) UIFontWeight weight;
@property(nonatomic,strong) UIFontDescriptor *fontDescriptor;
+ (instancetype)systemFontOfSize:(CGFloat)size weight:(UIFontWeight)weight;
+ (instancetype)monospacedDigitSystemFontOfSize:(CGFloat)size weight:(UIFontWeight)weight;
+ (instancetype)fontWithDescriptor:(UIFontDescriptor *)descriptor size:(CGFloat)size;
@end
@interface UIFontMetrics : NSObject
@property(nonatomic,copy) UIFontTextStyle style;
+ (instancetype)metricsForTextStyle:(UIFontTextStyle)style;
- (UIFont *)scaledFontForFont:(UIFont *)font maximumPointSize:(CGFloat)maximum;
@end

@interface UIView : NSObject
@property(nonatomic,strong) UIColor *backgroundColor,*tintColor;
@property(nonatomic,copy) NSString *accessibilityLabel;
@property(nonatomic) NSUInteger layoutRequests;
- (void)setNeedsLayout;
@end
@interface UILabel : UIView
@property(nonatomic,strong) UIFont *font;
@property(nonatomic,copy) NSString *text;
@property(nonatomic,strong) UIColor *textColor,*shadowColor;
@property(nonatomic) CGSize shadowOffset;
@end
typedef NSInteger UIControlState;
static const UIControlState UIControlStateNormal=0;
@interface UIButton : UIView
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UIColor *titleColor;
- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state;
@end
@interface UIImageSymbolConfiguration : NSObject
+ (instancetype)configurationWithPointSize:(CGFloat)size weight:(NSInteger)weight;
@end
static const NSInteger UIImageSymbolWeightRegular=0;
@interface UIImage : NSObject
@property(nonatomic,copy) NSString *name;
+ (instancetype)systemImageNamed:(NSString *)name;
+ (instancetype)systemImageNamed:(NSString *)name withConfiguration:(UIImageSymbolConfiguration *)configuration;
@end
@interface UIImageView : UIView
@property(nonatomic,strong) UIImage *image;
@end
@interface NSIndexPath (QuickPanelHost)
@property(nonatomic,readonly) NSInteger item;
+ (NSIndexPath *)indexPathForItem:(NSInteger)item inSection:(NSInteger)section;
@end
@interface UICollectionView : UIView
@property(nonatomic,copy) NSArray *visibleCells;
- (NSIndexPath *)indexPathForCell:(id)cell;
@end
