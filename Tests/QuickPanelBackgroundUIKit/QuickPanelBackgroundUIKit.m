#import <UIKit/UIKit.h>
#import <stdatomic.h>

@implementation UITraitCollection
@end

@interface UIColor ()
@property(nonatomic) BOOL systemBackground;
@end
@implementation UIColor
+ (instancetype)clearColor { return [self colorWithRed:0 green:0 blue:0 alpha:0]; }
+ (instancetype)secondarySystemGroupedBackgroundColor {
    UIColor *color = [self new]; color.systemBackground = YES; return color;
}
+ (instancetype)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    UIColor *color = [self new]; color.red=red; color.green=green; color.blue=blue; color.alpha=alpha; return color;
}
- (UIColor *)resolvedColorWithTraitCollection:(UITraitCollection *)traits {
    if (!self.systemBackground) return self;
    CGFloat brightness = traits.userInterfaceStyle == UIUserInterfaceStyleDark ? .12 : .96;
    return [UIColor colorWithRed:brightness green:brightness blue:brightness alpha:1];
}
- (BOOL)getRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha {
    if (red) *red=self.red; if (green) *green=self.green; if (blue) *blue=self.blue; if (alpha) *alpha=self.alpha; return YES;
}
@end

@interface UIView ()
@property(nonatomic, strong) NSMutableArray<UIView *> *testChildren;
@end
@implementation UIView
- (instancetype)init { return [self initWithFrame:CGRectZero]; }
- (instancetype)initWithFrame:(CGRect)frame {
    if ((self=[super init])) {
        _frame=frame; _bounds=(CGRect){CGPointZero,frame.size}; _alpha=1;
        _testChildren=[NSMutableArray array]; _traitCollection=[UITraitCollection new];
        _traitCollection.userInterfaceStyle=UIUserInterfaceStyleLight;
    }
    return self;
}
- (NSArray<UIView *> *)subviews { return self.testChildren.copy; }
- (void)addSubview:(UIView *)view { [self.testChildren addObject:view]; }
- (void)layoutSubviews {}
- (void)traitCollectionDidChange:(UITraitCollection *)previous { (void)previous; }
@end

static atomic_uint_fast64_t imageCreationCount;
uint64_t CSQuickPanelTestImageCreationCount(void) { return atomic_load(&imageCreationCount); }
@implementation UIImage {
    CGImageRef _CGImage;
}
+ (instancetype)imageWithCGImage:(CGImageRef)image {
    UIImage *result=[self new]; result->_CGImage=CGImageRetain(image);
    atomic_fetch_add(&imageCreationCount,1);
    return result;
}
- (CGImageRef)CGImage { return _CGImage; }
- (void)dealloc { if (_CGImage) CGImageRelease(_CGImage); }
@end

@implementation UIImageView
@end
