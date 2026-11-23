#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// Presentation only. The settings controller keeps ownership of avatar gestures.
@interface CSPluginHeaderView : UIView
@property(nonatomic, strong, readonly) UIImageView *avatarImageView;
@property(nonatomic) CGFloat horizontalInset;
/// The first metric caption's leading edge in this view's coordinates.
@property(nonatomic, readonly) CGFloat metricCaptionLeadingInset;
- (void)updateNickname:(NSString *)nickname
             wechatID:(NSString *)wechatID
         enabledCount:(NSUInteger)enabledCount
        pluginVersion:(NSString *)pluginVersion
        wechatVersion:(NSString *)wechatVersion;
- (void)setVerse:(NSString *)verse;
- (void)reloadTheme;
- (void)resetAvatarImage;
- (CGFloat)preferredHeightForWidth:(CGFloat)width;
@end

NS_ASSUME_NONNULL_END
