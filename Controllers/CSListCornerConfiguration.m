#import "CSListCornerConfiguration.h"
#import <math.h>
NSString * const kListCornerRadiusEnabledKey = @"com.wechat.enhance.list_corner_radius.enabled";
NSString * const kListCornerRadiusKey = @"com.wechat.enhance.list_corner_radius.radius";
NSString * const kListLeftMarginKey = @"com.wechat.enhance.list_corner_radius.left_margin";
NSString * const kListRightMarginKey = @"com.wechat.enhance.list_corner_radius.right_margin";
NSString * const kListTopSessionTopMarginKey = @"com.wechat.enhance.list_corner_radius.top_session_top_margin";
NSString * const kListNormalSessionTopMarginKey = @"com.wechat.enhance.list_corner_radius.normal_session_top_margin";
NSString * const kListLightModeBgColorRedKey = @"com.wechat.enhance.list_corner_radius.light_bg_color.red";
NSString * const kListLightModeBgColorGreenKey = @"com.wechat.enhance.list_corner_radius.light_bg_color.green";
NSString * const kListLightModeBgColorBlueKey = @"com.wechat.enhance.list_corner_radius.light_bg_color.blue";
NSString * const kListLightModeBgColorAlphaKey = @"com.wechat.enhance.list_corner_radius.light_bg_color.alpha";
NSString * const kListDarkModeBgColorRedKey = @"com.wechat.enhance.list_corner_radius.dark_bg_color.red";
NSString * const kListDarkModeBgColorGreenKey = @"com.wechat.enhance.list_corner_radius.dark_bg_color.green";
NSString * const kListDarkModeBgColorBlueKey = @"com.wechat.enhance.list_corner_radius.dark_bg_color.blue";
NSString * const kListDarkModeBgColorAlphaKey = @"com.wechat.enhance.list_corner_radius.dark_bg_color.alpha";
NSString * const kTopSessionTopMarginLightBgColorRedKey = @"com.wechat.enhance.list_corner_radius.top_session_top_margin_light_bg_color.red";
NSString * const kTopSessionTopMarginLightBgColorGreenKey = @"com.wechat.enhance.list_corner_radius.top_session_top_margin_light_bg_color.green";
NSString * const kTopSessionTopMarginLightBgColorBlueKey = @"com.wechat.enhance.list_corner_radius.top_session_top_margin_light_bg_color.blue";
NSString * const kTopSessionTopMarginLightBgColorAlphaKey = @"com.wechat.enhance.list_corner_radius.top_session_top_margin_light_bg_color.alpha";
NSString * const kTopSessionTopMarginDarkBgColorRedKey = @"com.wechat.enhance.list_corner_radius.top_session_top_margin_dark_bg_color.red";
NSString * const kTopSessionTopMarginDarkBgColorGreenKey = @"com.wechat.enhance.list_corner_radius.top_session_top_margin_dark_bg_color.green";
NSString * const kTopSessionTopMarginDarkBgColorBlueKey = @"com.wechat.enhance.list_corner_radius.top_session_top_margin_dark_bg_color.blue";
NSString * const kTopSessionTopMarginDarkBgColorAlphaKey = @"com.wechat.enhance.list_corner_radius.top_session_top_margin_dark_bg_color.alpha";
NSString * const kNormalSessionTopMarginLightBgColorRedKey = @"com.wechat.enhance.list_corner_radius.normal_session_top_margin_light_bg_color.red";
NSString * const kNormalSessionTopMarginLightBgColorGreenKey = @"com.wechat.enhance.list_corner_radius.normal_session_top_margin_light_bg_color.green";
NSString * const kNormalSessionTopMarginLightBgColorBlueKey = @"com.wechat.enhance.list_corner_radius.normal_session_top_margin_light_bg_color.blue";
NSString * const kNormalSessionTopMarginLightBgColorAlphaKey = @"com.wechat.enhance.list_corner_radius.normal_session_top_margin_light_bg_color.alpha";
NSString * const kNormalSessionTopMarginDarkBgColorRedKey = @"com.wechat.enhance.list_corner_radius.normal_session_top_margin_dark_bg_color.red";
NSString * const kNormalSessionTopMarginDarkBgColorGreenKey = @"com.wechat.enhance.list_corner_radius.normal_session_top_margin_dark_bg_color.green";
NSString * const kNormalSessionTopMarginDarkBgColorBlueKey = @"com.wechat.enhance.list_corner_radius.normal_session_top_margin_dark_bg_color.blue";
NSString * const kNormalSessionTopMarginDarkBgColorAlphaKey = @"com.wechat.enhance.list_corner_radius.normal_session_top_margin_dark_bg_color.alpha";
const CGFloat kDefaultCornerRadius = 10.0;
const CGFloat kDefaultLeftMargin = 15.0;
const CGFloat kDefaultRightMargin = 15.0;
const CGFloat kDefaultTopSessionTopMargin = 10.0;
const CGFloat kDefaultNormalSessionTopMargin = 10.0;

@interface CSListCornerSnapshot ()
@property(nonatomic) BOOL enabled;
@property(nonatomic) CGFloat radius, leftMargin, rightMargin, pinnedGap, normalGap;
@property(nonatomic, copy) NSArray<UIColor *> *colors;
@end
@implementation CSListCornerSnapshot
- (UIColor *)backgroundForStyle:(UIUserInterfaceStyle)style { return self.colors[style == UIUserInterfaceStyleDark ? 1 : 0]; }
- (UIColor *)pinnedColorForStyle:(UIUserInterfaceStyle)style { return self.colors[style == UIUserInterfaceStyleDark ? 3 : 2]; }
- (UIColor *)normalColorForStyle:(UIUserInterfaceStyle)style { return self.colors[style == UIUserInterfaceStyleDark ? 5 : 4]; }
@end
static UIColor *CSListCornerLoadColor(id<CSListCornerDefaults> defaults, NSString *redKey, NSString *greenKey, NSString *blueKey, NSString *alphaKey, UIColor *fallback) {
    CGFloat red=[defaults floatForKey:redKey], green=[defaults floatForKey:greenKey];
    CGFloat blue=[defaults floatForKey:blueKey], alpha=[defaults floatForKey:alphaKey];
    // Preserve 1.7-17's all-zero sentinel, including opaque background fallback.
    if ((!red && !green && !blue && !alpha) || !isfinite(red) || !isfinite(green) || !isfinite(blue) || !isfinite(alpha)) return fallback;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
@interface CSListCornerConfiguration ()
@property(nonatomic, strong) id<CSListCornerDefaults> defaults;
@property(nonatomic, strong) CSListCornerSnapshot *cached;
@property(nonatomic) NSUInteger revision;
@end
@implementation CSListCornerConfiguration
+ (instancetype)sharedConfiguration {
    static CSListCornerConfiguration *configuration; static dispatch_once_t once;
    dispatch_once(&once, ^{ configuration=[[self alloc] initWithDefaults:(id)[NSUserDefaults standardUserDefaults]]; });
    return configuration;
}
- (instancetype)initWithDefaults:(id<CSListCornerDefaults>)defaults {
    if ((self=[super init])) {
        _defaults=defaults;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(defaultsChanged:) name:NSUserDefaultsDidChangeNotification object:defaults];
    } return self;
}
- (void)dealloc { [[NSNotificationCenter defaultCenter] removeObserver:self]; }
- (void)defaultsChanged:(NSNotification *)notification { [self invalidate]; }
- (void)invalidate { @synchronized(self) { self.revision++; self.cached=nil; } }
- (void)saveNumber:(CGFloat)value forKey:(NSString *)key { [self.defaults setFloat:value forKey:key]; [self.defaults synchronize]; [self invalidate]; }
- (void)saveEnabled:(BOOL)value { [self.defaults setBool:value forKey:kListCornerRadiusEnabledKey]; [self.defaults synchronize]; [self invalidate]; }
- (void)saveColor:(UIColor *)color redKey:(NSString *)redKey greenKey:(NSString *)greenKey blueKey:(NSString *)blueKey alphaKey:(NSString *)alphaKey {
    CGFloat red=0,green=0,blue=0,alpha=0; [color getRed:&red green:&green blue:&blue alpha:&alpha];
    [self.defaults setFloat:red forKey:redKey]; [self.defaults setFloat:green forKey:greenKey];
    [self.defaults setFloat:blue forKey:blueKey]; [self.defaults setFloat:alpha forKey:alphaKey]; [self.defaults synchronize]; [self invalidate];
}
- (CSListCornerSnapshot *)snapshot {
    NSUInteger revision;
    @synchronized(self) { if (self.cached) return self.cached; revision=self.revision; }
    // A Defaults notification must be able to invalidate while this read runs.
    {
        id<CSListCornerDefaults> defaults=self.defaults;
        CSListCornerSnapshot *s=[CSListCornerSnapshot new];
        s.enabled=[defaults boolForKey:kListCornerRadiusEnabledKey];
        CGFloat radius=[defaults floatForKey:kListCornerRadiusKey];
        s.radius=isfinite(radius) && radius>0 ? radius : kDefaultCornerRadius;
        CGFloat leftMargin=[defaults floatForKey:kListLeftMarginKey];
        s.leftMargin=isfinite(leftMargin) && leftMargin>0 ? leftMargin : kDefaultLeftMargin;
        CGFloat rightMargin=[defaults floatForKey:kListRightMarginKey];
        s.rightMargin=isfinite(rightMargin) && rightMargin>0 ? rightMargin : kDefaultRightMargin;
        CGFloat pinnedGap=[defaults floatForKey:kListTopSessionTopMarginKey];
        s.pinnedGap=isfinite(pinnedGap) && [defaults objectForKey:kListTopSessionTopMarginKey]!=nil ? pinnedGap : kDefaultTopSessionTopMargin;
        CGFloat normalGap=[defaults floatForKey:kListNormalSessionTopMarginKey];
        s.normalGap=isfinite(normalGap) && [defaults objectForKey:kListNormalSessionTopMarginKey]!=nil ? normalGap : kDefaultNormalSessionTopMargin;
        s.colors=@[
            CSListCornerLoadColor(defaults, kListLightModeBgColorRedKey, kListLightModeBgColorGreenKey, kListLightModeBgColorBlueKey, kListLightModeBgColorAlphaKey, [UIColor whiteColor]),
            CSListCornerLoadColor(defaults, kListDarkModeBgColorRedKey, kListDarkModeBgColorGreenKey, kListDarkModeBgColorBlueKey, kListDarkModeBgColorAlphaKey, [UIColor colorWithRed:0.11 green:0.11 blue:0.12 alpha:1]),
            CSListCornerLoadColor(defaults, kTopSessionTopMarginLightBgColorRedKey, kTopSessionTopMarginLightBgColorGreenKey, kTopSessionTopMarginLightBgColorBlueKey, kTopSessionTopMarginLightBgColorAlphaKey, [UIColor clearColor]),
            CSListCornerLoadColor(defaults, kTopSessionTopMarginDarkBgColorRedKey, kTopSessionTopMarginDarkBgColorGreenKey, kTopSessionTopMarginDarkBgColorBlueKey, kTopSessionTopMarginDarkBgColorAlphaKey, [UIColor clearColor]),
            CSListCornerLoadColor(defaults, kNormalSessionTopMarginLightBgColorRedKey, kNormalSessionTopMarginLightBgColorGreenKey, kNormalSessionTopMarginLightBgColorBlueKey, kNormalSessionTopMarginLightBgColorAlphaKey, [UIColor clearColor]),
            CSListCornerLoadColor(defaults, kNormalSessionTopMarginDarkBgColorRedKey, kNormalSessionTopMarginDarkBgColorGreenKey, kNormalSessionTopMarginDarkBgColorBlueKey, kNormalSessionTopMarginDarkBgColorAlphaKey, [UIColor clearColor]),
        ];
        @synchronized(self) { if (revision==self.revision) self.cached=s; }
        return s;
    }
}
@end
