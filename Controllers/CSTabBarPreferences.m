#import "CSTabBarPreferences.h"
#import "CSTabBarGeometry.h"
#include <sys/stat.h>
static CSTabBarPreferences *CSCurrentTabBarPreferences;
static NSMutableDictionary<NSString *, NSDictionary *> *CSIconCache;
static NSMutableDictionary<NSString *, NSNumber *> *CSIconResourceGenerations;
static NSArray *CSIconSignature(NSString *path, NSString *identifier, NSNumber *generation) {
    struct stat info;
    if (!path.length || stat(path.fileSystemRepresentation,&info)!=0 || !S_ISREG(info.st_mode)) return nil;
    return @[path,identifier,generation ?: @0,@(info.st_dev),@(info.st_ino),@(info.st_size),
        @(info.st_mtimespec.tv_sec),@(info.st_mtimespec.tv_nsec),@(info.st_ctimespec.tv_sec),@(info.st_ctimespec.tv_nsec)];
}
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
    p.swipeSwitch=[d objectForKey:kTabBarSwipeSwitchKey] ? [d boolForKey:kTabBarSwipeSwitchKey] : YES;
    p.scale=CSNumber(d,kTabBarScaleKey,kDefaultScale,.6,1);
    p.contentHeight=CSNumber(d,kTabBarContentHeightKey,52,44,80);
    p.lift=CSNumber(d,kTabBarPositionOffsetKey,0,0,100);
    p.cornerRadius=CSNumber(d,kTabBarCornerRadiusKey,kDefaultCornerRadius,0,40);
    p.borderWidth=CSNumber(d,kTabBarBorderWidthKey,1,0,6);
    p.borderStyle=(NSInteger)CSNumber(d,kTabBarBorderStyleKey,kDefaultBorderStyle,0,1);
    p.haptic=(NSInteger)CSNumber(d,kTabBarHapticFeedbackKey,0,0,4);
    // Only persisted 1/3 enable effects; reserved 2 and unknown values stay off.
    id clickEffect=[d objectForKey:kTabBarClickEffectKey];
    p.clickEffect=CSTabBarClickEffectNone;
    if ([clickEffect isKindOfClass:NSNumber.class]) {
        double value=[clickEffect doubleValue];
        if (value==CSTabBarClickEffectBounce || value==CSTabBarClickEffectCapsule) p.clickEffect=(CSTabBarClickEffect)value;
    }
    p.animation=(NSInteger)CSNumber(d,kTabBarBorderAnimationKey,0,0,CSTabBarBorderAnimationClassicHeartbeat);
    p.backgroundColor=[self colorInDefaults:d prefix:@"com.wechat.enhance.tabbar_style.bg_color"];
    p.borderColor=[self colorInDefaults:d prefix:@"com.wechat.enhance.tabbar_style.border_color"];
    p.indicatorColor=[self colorInDefaults:d prefix:kTabBarIndicatorColorKey];
    NSMutableArray *titles=[NSMutableArray array], *icons=[NSMutableArray array], *selected=[NSMutableArray array];
    for (NSString *name in @[@"chat",@"contacts",@"discover",@"me"]) {
        NSString *title=[d stringForKey:[@"com.wechat.enhance.tabbar_style.text." stringByAppendingString:name]];
        [titles addObject:title.length ? title : (id)NSNull.null];
        for (NSNumber *state in @[@NO,@YES]) {
            NSString *key=[(state.boolValue ? @"com.wechat.enhance.tabbar_style.icon.selected." : @"com.wechat.enhance.tabbar_style.icon.") stringByAppendingString:name];
            NSString *path=[d stringForKey:key];
            UIImage *image=[self cachedIconAtPath:path resourceIdentifier:key];
            // Reuse the loaded image until this resource or its file identity changes.
            [(state.boolValue ? selected : icons) addObject:image ?: (id)NSNull.null];
        }
    }
    p.titles=titles; p.icons=icons; p.selectedIcons=selected;
    CSCurrentTabBarPreferences=p;
}
+ (UIImage *)cachedIconAtPath:(NSString *)path resourceIdentifier:(NSString *)identifier {
    if (!identifier.length) return nil;
    @synchronized (self) {
        if (!CSIconCache) CSIconCache=[NSMutableDictionary dictionary];
        if (!CSIconResourceGenerations) CSIconResourceGenerations=[NSMutableDictionary dictionary];
        NSArray *signature=CSIconSignature(path,identifier,CSIconResourceGenerations[identifier]);
        if (!signature) {
            [CSIconCache removeObjectForKey:identifier];
            return nil;
        }
        NSDictionary *entry=CSIconCache[identifier];
        if ([entry[@"signature"] isEqual:signature]) {
            return entry[@"image"];
        }
        UIImage *image=[UIImage imageWithContentsOfFile:path];
        // Never retain stale pixels or a failed load. A later notification can
        // retry transient failures; selected-image fallback remains in iconAtIndex.
        if (image && [signature isEqual:CSIconSignature(path,identifier,CSIconResourceGenerations[identifier])]) {
            CSIconCache[identifier]=@{@"signature":signature,@"image":image};
            return image;
        }
        [CSIconCache removeObjectForKey:identifier];
        return nil;
    }
}
+ (void)invalidateIconAtPath:(NSString *)path resourceIdentifier:(NSString *)identifier {
    (void)path; // The identifier invalidates either the old or replacement path.
    if (!identifier.length) return;
    @synchronized (self) {
        if (!CSIconResourceGenerations) CSIconResourceGenerations=[NSMutableDictionary dictionary];
        CSIconResourceGenerations[identifier]=@([CSIconResourceGenerations[identifier] unsignedLongLongValue]+1);
        [CSIconCache removeObjectForKey:identifier];
    }
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
