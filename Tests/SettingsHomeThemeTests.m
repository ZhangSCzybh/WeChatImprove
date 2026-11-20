#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <objc/runtime.h>
#include <math.h>

// Only UIColor drawing is replaced. The production preference validation,
// persistence, notifications and contrast calculation run unchanged below.
@interface UIColor : NSObject
@property(nonatomic) CGFloat red,green,blue,alpha;
+ (instancetype)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
+ (instancetype)blackColor;
+ (instancetype)whiteColor;
- (BOOL)getRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha;
@end
@implementation UIColor
+ (instancetype)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    UIColor *c=[self new];c.red=red;c.green=green;c.blue=blue;c.alpha=alpha;return c;
}
+ (instancetype)blackColor {return [self colorWithRed:0 green:0 blue:0 alpha:1];}
+ (instancetype)whiteColor {return [self colorWithRed:1 green:1 blue:1 alpha:1];}
- (BOOL)getRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha {
    *red=self.red;*green=self.green;*blue=self.blue;*alpha=self.alpha;return YES;
}
@end
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
#import "SettingsHomeThemeUnderTest.h"

static NSUserDefaults *isolatedDefaults;
@interface NSUserDefaults (ThemeTest)
+ (NSUserDefaults *)themeTestDefaults;
@end
@implementation NSUserDefaults (ThemeTest)
+ (NSUserDefaults *)themeTestDefaults {return isolatedDefaults;}
@end
static NSUInteger checks;
#define Check(value,message) do {checks++;if(!(value)){fprintf(stderr,"FAIL: %s\n",message);exit(1);}} while(0)
static NSUInteger RGB(UIColor *color) {return ((NSUInteger)lround(color.red*255)<<16)|((NSUInteger)lround(color.green*255)<<8)|(NSUInteger)lround(color.blue*255);}
int main(void) {@autoreleasepool {
    NSString *suite=[@"CSHomeThemeTests." stringByAppendingString:NSUUID.UUID.UUIDString];
    isolatedDefaults=[[NSUserDefaults alloc] initWithSuiteName:suite];
    Method normal=class_getClassMethod(NSUserDefaults.class,@selector(standardUserDefaults));
    Method replacement=class_getClassMethod(NSUserDefaults.class,@selector(themeTestDefaults));
    method_exchangeImplementations(normal,replacement);
    __block NSUInteger notifications=0;
    id observer=[NSNotificationCenter.defaultCenter addObserverForName:CSSettingsHomeThemeDidChangeNotification object:nil queue:nil usingBlock:^(NSNotification *note){notifications++;}];
    Check(CSSettingsHomeTheme.selectedIndex==0,"missing preferences select default green");
    Check(RGB(CSSettingsHomeTheme.accentColor)==0x05944A,"default green matches approved palette");
    Check(RGB(CSSettingsHomeTheme.customColor)==0x05944A,"unconfigured custom color is a safe green sample");
    Check(RGB(CSSettingsHomeTheme.aboutGoldColor)==0xF8D8A9,"About gold exactly matches SVIP background");
    for(NSUInteger index=0;index<4;index++) {
        [CSSettingsHomeTheme setPresetIndex:index];
        Check(CSSettingsHomeTheme.selectedIndex==index,"preset selection persists");
        Check(RGB(CSSettingsHomeTheme.accentColor)==RGB([CSSettingsHomeTheme colorAtIndex:index]),"selected preset and sample agree");
        Check(CSSettingsHomeTheme.accentColor.alpha==1,"preset accents are opaque");
        Check(RGB(CSSettingsHomeTheme.aboutGoldColor)==0xF8D8A9,"preset does not change About gold");
    }
    NSUInteger before=notifications;
    [CSSettingsHomeTheme setPresetIndex:3];[CSSettingsHomeTheme setPresetIndex:4];[CSSettingsHomeTheme setPresetIndex:99];
    Check(notifications==before,"same or out-of-range preset does not publish a redundant change");
    [CSSettingsHomeTheme setCustomColor:[UIColor colorWithRed:0.2 green:0.4 blue:0.6 alpha:0.01]];
    Check(CSSettingsHomeTheme.selectedIndex==4&&RGB(CSSettingsHomeTheme.accentColor)==0x336699,"custom picker stores RGB and selects custom slot");
    Check(CSSettingsHomeTheme.accentColor.alpha==1,"custom opacity cannot hide tabs or arrows");
    Check(notifications==before+1,"custom change publishes once");
    [CSSettingsHomeTheme setCustomColor:[UIColor colorWithRed:0.2 green:0.4 blue:0.6 alpha:1]];
    Check(notifications==before+1,"same opaque RGB does not publish repeatedly");
    [CSSettingsHomeTheme setPresetIndex:1];
    Check(RGB(CSSettingsHomeTheme.customColor)==0x336699,"switching presets preserves the user's custom sample");
    [CSSettingsHomeTheme setCustomColor:CSSettingsHomeTheme.customColor];
    Check(CSSettingsHomeTheme.selectedIndex==4&&RGB(CSSettingsHomeTheme.accentColor)==0x336699,"existing custom sample can be reselected");
    [CSSettingsHomeTheme setCustomColor:UIColor.whiteColor];
    Check(RGB(CSSettingsHomeTheme.foregroundColorForAccent)==0,"white custom accent uses black selected text");
    [CSSettingsHomeTheme setCustomColor:UIColor.blackColor];
    Check(RGB(CSSettingsHomeTheme.foregroundColorForAccent)==0xffffff,"black custom accent uses white selected text");
    [CSSettingsHomeTheme setCustomColor:[UIColor colorWithRed:2 green:-1 blue:0.5 alpha:1]];
    Check(RGB(CSSettingsHomeTheme.accentColor)==0xFF0080,"finite RGB values clamp and round safely");
    before=notifications;
    [CSSettingsHomeTheme setCustomColor:[UIColor colorWithRed:NAN green:0 blue:0 alpha:1]];
    Check(notifications==before&&RGB(CSSettingsHomeTheme.accentColor)==0xFF0080,"nonfinite color cannot corrupt persistence");
    for(id invalid in @[@(-1),@5,@0.5,@"2",@(NAN),NSNull.null]) {
        [isolatedDefaults setObject:invalid==NSNull.null ? @[] : invalid forKey:CSHomeThemeIndexKey];
        Check(CSSettingsHomeTheme.selectedIndex==0,"malformed stored palette index falls back to default");
    }
    for(id invalid in @[@(-1),@0x1000000,@1.5,@"112233",@(INFINITY),@[]]) {
        [isolatedDefaults setObject:invalid forKey:CSHomeThemeCustomKey];
        Check(RGB(CSSettingsHomeTheme.customColor)==0x05944A,"malformed stored RGB falls back to default");
    }
    [CSSettingsHomeTheme setCustomColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];
    NSUserDefaults *reopened=[[NSUserDefaults alloc] initWithSuiteName:suite];
    Check([reopened integerForKey:CSHomeThemeIndexKey]==4&&[reopened integerForKey:CSHomeThemeCustomKey]==0xffffff,"selected color survives a new preferences reader");
    Check(RGB([CSSettingsHomeTheme colorAtIndex:99])==0x05944A,"invalid sample lookup safely returns default");
    [NSNotificationCenter.defaultCenter removeObserver:observer];
    method_exchangeImplementations(normal,replacement);
    [isolatedDefaults removePersistentDomainForName:suite];
    printf("Settings home theme passed %lu checks\n",(unsigned long)checks);
}}
