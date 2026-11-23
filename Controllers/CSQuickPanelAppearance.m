#import "CSQuickPanelAppearance.h"
#import "CSQuickPanelPreferences.h"
#import "CSSettingsHomeTheme.h"
#import <CoreText/CoreText.h>

static UIColor *CSQuickPanelForegroundColor(NSString *hex) {
    if (hex.length!=7 || ![hex hasPrefix:@"#"]) return nil;
    NSString *digits=[hex substringFromIndex:1];
    NSCharacterSet *invalid=[[NSCharacterSet characterSetWithCharactersInString:@"0123456789abcdefABCDEF"] invertedSet];
    if ([digits rangeOfCharacterFromSet:invalid].location!=NSNotFound) return nil;
    unsigned int rgb=0;
    if (![[NSScanner scannerWithString:digits] scanHexInt:&rgb]) return nil;
    return [UIColor colorWithRed:((rgb>>16)&255)/255.0 green:((rgb>>8)&255)/255.0 blue:(rgb&255)/255.0 alpha:1];
}

@implementation CSQuickPanelAppearance
+ (UIColor *)primaryTextColorForLightContent:(BOOL)lightContent {
    return CSQuickPanelForegroundColor(CSQuickPanelPreferences.textColorHex) ?: (lightContent ? UIColor.whiteColor : UIColor.blackColor);
}
+ (UIColor *)secondaryTextColorForLightContent:(BOOL)lightContent {
    return [[self primaryTextColorForLightContent:lightContent] colorWithAlphaComponent:.67];
}
+ (UIColor *)iconColor {
    return CSQuickPanelForegroundColor(CSQuickPanelPreferences.iconColorHex) ?: CSSettingsHomeTheme.accentColor;
}
+ (UIColor *)iconTileColorForLightContent:(BOOL)lightContent {
    return [self.iconColor colorWithAlphaComponent:lightContent ? .19 : .10];
}
+ (UIFont *)headerFontForRole:(CSQuickPanelHeaderFontRole)role {
    CGFloat size=17,maximum=22;
    UIFontWeight weight=UIFontWeightSemibold;
    UIFontTextStyle style=UIFontTextStyleHeadline;
    switch (role) {
        case CSQuickPanelHeaderFontWeChatID: size=12; maximum=16; weight=UIFontWeightRegular; style=UIFontTextStyleCaption1; break;
        case CSQuickPanelHeaderFontTime: size=29; maximum=34; weight=UIFontWeightMedium; style=UIFontTextStyleTitle2; break;
        case CSQuickPanelHeaderFontDate: size=11; maximum=14; weight=UIFontWeightMedium; style=UIFontTextStyleCaption2; break;
        case CSQuickPanelHeaderFontNickname: break;
    }
    UIFont *font=role==CSQuickPanelHeaderFontTime ? [UIFont monospacedDigitSystemFontOfSize:size weight:weight] : [UIFont systemFontOfSize:size weight:weight];
    UIFontDescriptor *descriptor=[font.fontDescriptor fontDescriptorWithDesign:UIFontDescriptorSystemDesignRounded];
    if (descriptor) {
        if (role==CSQuickPanelHeaderFontTime) {
            // Reapply the number-spacing feature after changing the font design.
            // This preserves stable HH:mm widths even if the design drops traits.
            descriptor=[descriptor fontDescriptorByAddingAttributes:@{UIFontDescriptorFeatureSettingsAttribute:@[
                @{UIFontFeatureTypeIdentifierKey:@(kNumberSpacingType),UIFontFeatureSelectorIdentifierKey:@(kMonospacedNumbersSelector)}]}];
        }
        font=[UIFont fontWithDescriptor:descriptor size:size] ?: font;
    }
    return [[UIFontMetrics metricsForTextStyle:style] scaledFontForFont:font maximumPointSize:maximum];
}
@end
