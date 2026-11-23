#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

UIFontWeight const UIFontWeightRegular=0,UIFontWeightMedium=.23,UIFontWeightSemibold=.3;
UIFontTextStyle const UIFontTextStyleHeadline=@"headline",UIFontTextStyleCaption1=@"caption1",UIFontTextStyleCaption2=@"caption2",UIFontTextStyleTitle2=@"title2",UIFontTextStyleSubheadline=@"subheadline";
UIFontDescriptorSystemDesign const UIFontDescriptorSystemDesignRounded=@"rounded";
NSString *const UIFontDescriptorFeatureSettingsAttribute=@"features";
NSString *const UIFontFeatureTypeIdentifierKey=@"featureType";
NSString *const UIFontFeatureSelectorIdentifierKey=@"featureSelector";
CGFloat CSQuickPanelTestFontScale=1;
BOOL CSQuickPanelTestRoundedUnavailable=NO;

@implementation UITraitCollection @end
@implementation UIColor
+ (instancetype)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    UIColor *c=[self new];c.red=red;c.green=green;c.blue=blue;c.alpha=alpha;return c;
}
+ (instancetype)whiteColor { return [self colorWithRed:1 green:1 blue:1 alpha:1]; }
+ (instancetype)blackColor { return [self colorWithRed:0 green:0 blue:0 alpha:1]; }
- (UIColor *)colorWithAlphaComponent:(CGFloat)alpha { return [UIColor colorWithRed:self.red green:self.green blue:self.blue alpha:alpha]; }
- (BOOL)getRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha {
    if(red)*red=self.red;if(green)*green=self.green;if(blue)*blue=self.blue;if(alpha)*alpha=self.alpha;return YES;
}
@end
@implementation UIFontDescriptor
- (UIFontDescriptor *)fontDescriptorWithDesign:(UIFontDescriptorSystemDesign)design {
    if(CSQuickPanelTestRoundedUnavailable)return nil;
    NSMutableDictionary *a=self.attributes.mutableCopy;
    // Deliberately simulate a design change dropping number-spacing features.
    [a removeObjectForKey:UIFontDescriptorFeatureSettingsAttribute];
    a[@"design"]=design;
    UIFontDescriptor *d=[self.class new];d.attributes=a;return d;
}
- (UIFontDescriptor *)fontDescriptorByAddingAttributes:(NSDictionary *)attributes {
    NSMutableDictionary *a=self.attributes.mutableCopy;[a addEntriesFromDictionary:attributes];
    UIFontDescriptor *d=[self.class new];d.attributes=a;return d;
}
- (id)objectForKey:(NSString *)key { return self.attributes[key]; }
@end
@implementation UIFont
+ (instancetype)fontWithDescriptor:(UIFontDescriptor *)descriptor size:(CGFloat)size {
    UIFont *f=[self new];f.fontDescriptor=descriptor;f.pointSize=size;f.lineHeight=size*1.2;f.weight=[descriptor.attributes[@"weight"] doubleValue];return f;
}
+ (instancetype)systemFontOfSize:(CGFloat)size weight:(UIFontWeight)weight {
    UIFontDescriptor *d=[UIFontDescriptor new];d.attributes=@{@"weight":@(weight),@"design":@"system"};
    return [self fontWithDescriptor:d size:size];
}
+ (instancetype)monospacedDigitSystemFontOfSize:(CGFloat)size weight:(UIFontWeight)weight {
    UIFont *font=[self systemFontOfSize:size weight:weight];
    font.fontDescriptor=[font.fontDescriptor fontDescriptorByAddingAttributes:@{UIFontDescriptorFeatureSettingsAttribute:@[
        @{UIFontFeatureTypeIdentifierKey:@(kNumberSpacingType),UIFontFeatureSelectorIdentifierKey:@(kMonospacedNumbersSelector)}]}];
    return font;
}
@end
@implementation UIFontMetrics
+ (instancetype)metricsForTextStyle:(UIFontTextStyle)style { UIFontMetrics *m=[self new];m.style=style;return m; }
- (UIFont *)scaledFontForFont:(UIFont *)font maximumPointSize:(CGFloat)maximum {
    UIFontDescriptor *descriptor=[font.fontDescriptor fontDescriptorByAddingAttributes:@{@"metricsStyle":self.style,@"maximum":@(maximum)}];
    return [UIFont fontWithDescriptor:descriptor size:MIN(font.pointSize*CSQuickPanelTestFontScale,maximum)];
}
@end
@implementation UIView
- (void)setNeedsLayout { self.layoutRequests++; }
@end
@implementation UILabel @end
@implementation UIButton
- (instancetype)init { if((self=[super init]))_titleLabel=[UILabel new];return self; }
- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state { (void)state;self.titleColor=color; }
@end
@implementation UIImageSymbolConfiguration
+ (instancetype)configurationWithPointSize:(CGFloat)size weight:(NSInteger)weight { (void)size;(void)weight;return [self new]; }
@end
@implementation UIImage
+ (instancetype)systemImageNamed:(NSString *)name { UIImage *image=[self new];image.name=name;return image; }
+ (instancetype)systemImageNamed:(NSString *)name withConfiguration:(UIImageSymbolConfiguration *)configuration { (void)configuration;return [self systemImageNamed:name]; }
@end
@implementation UIImageView @end
@implementation NSIndexPath (QuickPanelHost)
+ (NSIndexPath *)indexPathForItem:(NSInteger)item inSection:(NSInteger)section { NSUInteger indexes[]={(NSUInteger)section,(NSUInteger)item};return [NSIndexPath indexPathWithIndexes:indexes length:2]; }
- (NSInteger)item { return (NSInteger)[self indexAtPosition:1]; }
@end
@implementation UICollectionView
- (NSIndexPath *)indexPathForCell:(id)cell {
    NSUInteger index=[self.visibleCells indexOfObjectIdenticalTo:cell];return index==NSNotFound ? nil : [NSIndexPath indexPathForItem:(NSInteger)index inSection:0];
}
@end
