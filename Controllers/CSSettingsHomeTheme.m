#import "CSSettingsHomeTheme.h"
#include <math.h>

NSNotificationName const CSSettingsHomeThemeDidChangeNotification=@"CSSettingsHomeThemeDidChangeNotification";
static NSString *const CSHomeThemeIndexKey=@"com.wechat.enhance.home_theme.index";
static NSString *const CSHomeThemeCustomKey=@"com.wechat.enhance.home_theme.custom_rgb";
static const NSUInteger CSHomeThemeDefaultRGB=0x05944A;

static BOOL CSHomeThemeValidNumber(id value, NSUInteger maximum) {
    if (![value isKindOfClass:NSNumber.class]) return NO;
    double number=[value doubleValue];
    return isfinite(number) && number>=0 && number<=maximum && floor(number)==number;
}
static UIColor *CSHomeThemeColor(NSUInteger rgb) {
    return [UIColor colorWithRed:((rgb>>16)&0xff)/255.0 green:((rgb>>8)&0xff)/255.0 blue:(rgb&0xff)/255.0 alpha:1];
}
static CGFloat CSHomeThemeLinear(CGFloat channel) {
    return channel<=0.04045 ? channel/12.92 : pow((channel+0.055)/1.055,2.4);
}

@implementation CSSettingsHomeTheme
+ (NSUInteger)selectedIndex {
    id value=[NSUserDefaults.standardUserDefaults objectForKey:CSHomeThemeIndexKey];
    return CSHomeThemeValidNumber(value,4) ? [value unsignedIntegerValue] : 0;
}
+ (UIColor *)customColor {
    id value=[NSUserDefaults.standardUserDefaults objectForKey:CSHomeThemeCustomKey];
    return CSHomeThemeColor(CSHomeThemeValidNumber(value,0xffffff) ? [value unsignedIntegerValue] : CSHomeThemeDefaultRGB);
}
+ (UIColor *)colorAtIndex:(NSUInteger)index {
    const NSUInteger colors[]={CSHomeThemeDefaultRGB,0x0875ED,0x7B45DF,0xF1730C};
    if (index==4) return self.customColor;
    return CSHomeThemeColor(colors[index<4 ? index : 0]);
}
+ (UIColor *)accentColor { return [self colorAtIndex:self.selectedIndex]; }
+ (UIColor *)aboutGoldColor { return CSHomeThemeColor(0xF8D8A9); }
+ (UIColor *)foregroundColorForAccent {
    CGFloat red=0,green=0,blue=0,alpha=1;
    [self.accentColor getRed:&red green:&green blue:&blue alpha:&alpha];
    CGFloat luminance=0.2126*CSHomeThemeLinear(red)+0.7152*CSHomeThemeLinear(green)+0.0722*CSHomeThemeLinear(blue);
    // Pick the better contrast for arbitrary custom colors, including white or black.
    return (luminance+0.05)/0.05 >= 1.05/(luminance+0.05) ? UIColor.blackColor : UIColor.whiteColor;
}
+ (void)publishChange {
    [NSUserDefaults.standardUserDefaults synchronize];
    [NSNotificationCenter.defaultCenter postNotificationName:CSSettingsHomeThemeDidChangeNotification object:nil];
}
+ (void)setPresetIndex:(NSUInteger)index {
    if (index>=4 || self.selectedIndex==index) return;
    [NSUserDefaults.standardUserDefaults setInteger:(NSInteger)index forKey:CSHomeThemeIndexKey];
    [self publishChange];
}
+ (void)setCustomColor:(UIColor *)color {
    CGFloat red=0,green=0,blue=0,alpha=1;
    if (![color getRed:&red green:&green blue:&blue alpha:&alpha] || !isfinite(red) || !isfinite(green) || !isfinite(blue)) return;
    NSUInteger rgb=((NSUInteger)lround(MAX(0,MIN(1,red))*255)<<16) |
                   ((NSUInteger)lround(MAX(0,MIN(1,green))*255)<<8) |
                   (NSUInteger)lround(MAX(0,MIN(1,blue))*255);
    id old=[NSUserDefaults.standardUserDefaults objectForKey:CSHomeThemeCustomKey];
    if (self.selectedIndex==4 && CSHomeThemeValidNumber(old,0xffffff) && [old unsignedIntegerValue]==rgb) return;
    [NSUserDefaults.standardUserDefaults setInteger:(NSInteger)rgb forKey:CSHomeThemeCustomKey];
    [NSUserDefaults.standardUserDefaults setInteger:4 forKey:CSHomeThemeIndexKey];
    [self publishChange];
}
@end
