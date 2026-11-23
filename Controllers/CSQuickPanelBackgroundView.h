#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// Shared background surface for the embedded preview and the complete panel.
/// Its alpha is independent from the panel's interactive foreground content.
@interface CSQuickPanelBackgroundView : UIView
@property(nonatomic, copy, nullable) void (^appearanceChanged)(BOOL usesLightContent);
@property(nonatomic, readonly) BOOL usesLightContent;
- (void)reloadAppearance;
@end

NS_ASSUME_NONNULL_END
