#import "CSTabBarPreferences.h"
#import "CSTabBarGeometry.h"
static CSTabBarPreferences *CSCurrentTabBarPreferences;
static CGFloat CSNumber(NSUserDefaults *d, NSString *key, CGFloat fallback, CGFloat min, CGFloat max) {
    id value=[d objectForKey:key];
    return value && [value respondsToSelector:@selector(doubleValue)] ? CSTabBarClamp([value doubleValue],min,max,fallback) : fallback;
}
@implementation CSTabBarPreferences
+ (instancetype)current {
    if (!CSCurrentTabBarPreferences) [self reload];
    return CSCurrentTabBarPreferences;
}
+ (UIColor *)colorInDefaults:(NSUserDefaults *)d prefix:(NSString *)prefix {
    if (![d objectForKey:[prefix stringByAppendingString:@".alpha"]]) return nil;
    return [UIColor colorWithRed:CSNumber(d,[prefix stringByAppendingString:@".red"],0,0,1)
                          green:CSNumber(d,[prefix stringByAppendingString:@".green"],0,0,1)
                           blue:CSNumber(d,[prefix stringByAppendingString:@".blue"],0,0,1)
                          alpha:CSNumber(d,[prefix stringByAppendingString:@".alpha"],1,0,1)];
}
+ (void)reload {
    NSUserDefaults *d=NSUserDefaults.standardUserDefaults;
    CSTabBarPreferences *p=[self new];
    p.enabled=[d boolForKey:kTabBarStyleEnabledKey]; p.hideText=[d boolForKey:kTabBarHideTextKey];
    p.scale=CSNumber(d,kTabBarScaleKey,kDefaultScale,.6,1);
    p.contentHeight=CSNumber(d,kTabBarContentHeightKey,52,44,80);
    p.lift=CSNumber(d,kTabBarPositionOffsetKey,0,0,100);
    p.cornerRadius=CSNumber(d,kTabBarCornerRadiusKey,kDefaultCornerRadius,0,40);
    p.borderWidth=CSNumber(d,kTabBarBorderWidthKey,1,0,6);
    p.borderStyle=(NSInteger)CSNumber(d,kTabBarBorderStyleKey,kDefaultBorderStyle,0,1);
    p.haptic=(NSInteger)CSNumber(d,kTabBarHapticFeedbackKey,0,0,4);
    // Unknown values must not opt existing users into motion.
    id clickEffect=[d objectForKey:kTabBarClickEffectKey];
    p.clickEffect=[clickEffect isKindOfClass:NSNumber.class] && [clickEffect doubleValue]==CSTabBarClickEffectBounce ? CSTabBarClickEffectBounce : CSTabBarClickEffectNone;
    p.animation=(NSInteger)CSNumber(d,kTabBarBorderAnimationKey,0,0,CSTabBarBorderAnimationClassicHeartbeat);
    p.backgroundColor=[self colorInDefaults:d prefix:@"com.wechat.enhance.tabbar_style.bg_color"];
    p.borderColor=[self colorInDefaults:d prefix:@"com.wechat.enhance.tabbar_style.border_color"];
    NSMutableArray *titles=[NSMutableArray array], *icons=[NSMutableArray array], *selected=[NSMutableArray array];
    for (NSString *name in @[@"chat",@"contacts",@"discover",@"me"]) {
        NSString *title=[d stringForKey:[@"com.wechat.enhance.tabbar_style.text." stringByAppendingString:name]];
        [titles addObject:title.length ? title : (id)NSNull.null];
        for (NSNumber *state in @[@NO,@YES]) {
            NSString *key=[(state.boolValue ? @"com.wechat.enhance.tabbar_style.icon.selected." : @"com.wechat.enhance.tabbar_style.icon.") stringByAppendingString:name];
            NSString *path=[d stringForKey:key];
            UIImage *image=path.length ? [UIImage imageWithContentsOfFile:path] : nil;
            // Decode once per preference change, never on layout or selection.
            [(state.boolValue ? selected : icons) addObject:image ?: (id)NSNull.null];
        }
    }
    p.titles=titles; p.icons=icons; p.selectedIcons=selected;
    CSCurrentTabBarPreferences=p;
}
- (UIImage *)iconAtIndex:(NSUInteger)i selected:(BOOL)selected {
    if (i>=self.icons.count) return nil;
    id value=(selected ? self.selectedIcons : self.icons)[i];
    if (value==NSNull.null && selected) value=self.icons[i];
    return value==NSNull.null ? nil : value;
}
- (NSString *)titleAtIndex:(NSUInteger)i {
    if (i>=self.titles.count) return nil;
    id value=self.titles[i]; return value==NSNull.null ? nil : value;
}
@end
