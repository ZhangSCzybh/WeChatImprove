#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// A distinct reuse pool keeps illustrative content out of ordinary setting cells.
@interface CSSettingsPreviewCell : UITableViewCell
+ (NSString *)reuseIdentifier;
- (void)configureWithPreview:(UIView *)preview caption:(NSString *)caption;
@end

NS_ASSUME_NONNULL_END
