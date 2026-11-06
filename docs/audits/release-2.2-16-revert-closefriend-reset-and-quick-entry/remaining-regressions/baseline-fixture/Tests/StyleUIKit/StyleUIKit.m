#import <UIKit/UIKit.h>
#import <objc/runtime.h>
static char tagKey, ownerKey;
@interface CSWeakOwner : NSObject
@property(nonatomic,weak) id value;
@end
@implementation CSWeakOwner @end
@implementation NSObject (StyleResponder)
- (id)nextResponder { return nil; }
@end
@implementation UIView (StyleTest)
- (NSInteger)tag { return [objc_getAssociatedObject(self,&tagKey) integerValue]; }
- (void)setTag:(NSInteger)tag { objc_setAssociatedObject(self,&tagKey,@(tag),OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
- (id)testOwner { return [objc_getAssociatedObject(self,&ownerKey) value]; }
- (void)setTestOwner:(id)owner { CSWeakOwner *weak=[CSWeakOwner new];weak.value=owner;objc_setAssociatedObject(self,&ownerKey,weak,OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
- (id)nextResponder { return self.testOwner ?: self.superview; }
- (void)layoutSubviews {} - (void)didMoveToWindow {} - (void)didMoveToSuperview {}
- (void)traitCollectionDidChange:(UITraitCollection *)previous {}
@end
@implementation UIViewController (StyleTest)
- (void)viewWillAppear:(BOOL)animated {} - (void)viewWillDisappear:(BOOL)animated {}
- (void)viewDidAppear:(BOOL)animated {} - (void)viewDidLayoutSubviews {}
@end
@interface CSStyleDynamicGray : UIColor @end
NSUInteger CSStyleTestColorResolutions;
@implementation CSStyleDynamicGray
- (UIColor *)resolvedColorWithTraitCollection:(UITraitCollection *)trait {
    CSStyleTestColorResolutions++;
    return [UIColor colorWithWhite:trait.userInterfaceStyle==UIUserInterfaceStyleDark?.7:.5 alpha:1];
}
@end
@implementation UITraitCollection (StyleTest)
- (BOOL)hasDifferentColorAppearanceComparedToTraitCollection:(UITraitCollection *)other {
    return self.userInterfaceStyle != other.userInterfaceStyle;
}
@end
@implementation UIColor (StyleTest)
+ (BOOL)supportsSecureCoding { return YES; }
- (void)encodeWithCoder:(NSCoder *)c { [c encodeDouble:self.red forKey:@"r"];[c encodeDouble:self.green forKey:@"g"];[c encodeDouble:self.blue forKey:@"b"];[c encodeDouble:self.alpha forKey:@"a"]; }
- (instancetype)initWithCoder:(NSCoder *)c { return [UIColor colorWithRed:[c decodeDoubleForKey:@"r"] green:[c decodeDoubleForKey:@"g"] blue:[c decodeDoubleForKey:@"b"] alpha:[c decodeDoubleForKey:@"a"]]; }
+ (instancetype)systemGrayColor { return [CSStyleDynamicGray new]; }
+ (instancetype)colorWithWhite:(CGFloat)white alpha:(CGFloat)alpha { return [self colorWithRed:white green:white blue:white alpha:alpha]; }
+ (instancetype)colorWithCGColor:(CGColorRef)c { const CGFloat *v=CGColorGetComponents(c);return CGColorGetNumberOfComponents(c)==4?[self colorWithRed:v[0] green:v[1] blue:v[2] alpha:v[3]]:[self colorWithWhite:v[0] alpha:v[1]]; }
- (instancetype)colorWithAlphaComponent:(CGFloat)alpha { return [UIColor colorWithRed:self.red green:self.green blue:self.blue alpha:alpha]; }
@end
NSUInteger CSStyleTestFonts;
@implementation UIFont (StyleTest)
+ (instancetype)systemFontOfSize:(CGFloat)size { CSStyleTestFonts++;UIFont *f=[self new];f.lineHeight=size;return f; }
+ (instancetype)boldSystemFontOfSize:(CGFloat)size { return [self systemFontOfSize:size]; }
@end
@implementation NSMutableParagraphStyle
- (id)copyWithZone:(NSZone *)zone { NSMutableParagraphStyle *p=[NSMutableParagraphStyle new];p.alignment=self.alignment;return p; }
@end
NSString *const NSFontAttributeName=@"font";
NSString *const NSForegroundColorAttributeName=@"foreground";
NSString *const NSParagraphStyleAttributeName=@"paragraph";
