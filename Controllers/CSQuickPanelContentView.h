#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// Presentation content only. The owner controls the shell, dismissal and routing.
@interface CSQuickPanelContentView : UIView
@property(nonatomic, copy, nullable) void (^actionHandler)(NSString *identifier);
@property(nonatomic) BOOL backgroundUsesLightContent;
- (void)reloadContent;
- (CGFloat)preferredHeightForWidth:(CGFloat)width;
@end

NS_ASSUME_NONNULL_END
