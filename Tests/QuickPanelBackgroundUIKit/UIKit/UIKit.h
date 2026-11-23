// Purpose-built host doubles for the background renderer. Geometry, colors and
// CGImage ownership are real; these classes do not emulate UIKit presentation.
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <dispatch/dispatch.h>

typedef NS_ENUM(NSInteger, UIViewContentMode) { UIViewContentModeScaleToFill, UIViewContentModeScaleAspectFill };
typedef NS_ENUM(NSInteger, UIUserInterfaceStyle) { UIUserInterfaceStyleUnspecified, UIUserInterfaceStyleLight, UIUserInterfaceStyleDark };

@interface UITraitCollection : NSObject
@property(nonatomic) UIUserInterfaceStyle userInterfaceStyle;
@end

@interface UIColor : NSObject
@property(nonatomic) CGFloat red, green, blue, alpha;
+ (instancetype)clearColor;
+ (instancetype)secondarySystemGroupedBackgroundColor;
+ (instancetype)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
- (UIColor *)resolvedColorWithTraitCollection:(UITraitCollection *)traits;
- (BOOL)getRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha;
@end

@interface UIView : NSObject
@property(nonatomic) CGRect frame, bounds;
@property(nonatomic) CGFloat alpha;
@property(nonatomic) BOOL hidden, clipsToBounds, userInteractionEnabled, isAccessibilityElement;
@property(nonatomic) UIViewContentMode contentMode;
@property(nonatomic, strong) UIColor *backgroundColor;
@property(nonatomic, strong) UITraitCollection *traitCollection;
@property(nonatomic, readonly) NSArray<UIView *> *subviews;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)addSubview:(UIView *)view;
- (void)layoutSubviews;
- (void)traitCollectionDidChange:(UITraitCollection *)previous;
@end

@interface UIImage : NSObject
@property(nonatomic, readonly) CGImageRef CGImage;
+ (instancetype)imageWithCGImage:(CGImageRef)image;
@end

@interface UIImageView : UIView
@property(nonatomic, strong) UIImage *image;
@end

FOUNDATION_EXPORT uint64_t CSQuickPanelTestImageCreationCount(void);
