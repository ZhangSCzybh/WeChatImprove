#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CSQuickPanelHeaderFontRole) {
    CSQuickPanelHeaderFontNickname,
    CSQuickPanelHeaderFontWeChatID,
    CSQuickPanelHeaderFontTime,
    CSQuickPanelHeaderFontDate,
};

/// Shared foreground choices for the preview and live quick panel.
@interface CSQuickPanelAppearance : NSObject
+ (UIColor *)primaryTextColorForLightContent:(BOOL)lightContent;
+ (UIColor *)secondaryTextColorForLightContent:(BOOL)lightContent;
/// A custom color takes precedence; the default exactly follows interface tint.
+ (UIColor *)iconColor;
+ (UIColor *)iconTileColorForLightContent:(BOOL)lightContent;
+ (UIFont *)headerFontForRole:(CSQuickPanelHeaderFontRole)role;
@end

NS_ASSUME_NONNULL_END
