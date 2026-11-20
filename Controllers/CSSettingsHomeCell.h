#import <UIKit/UIKit.h>
@class CSSettingItem;

NS_ASSUME_NONNULL_BEGIN

/// Homepage navigation styling, isolated from the shared settings cell.
@interface CSSettingsHomeCell : UITableViewCell
+ (NSString *)reuseIdentifier;
- (void)configureWithItem:(CSSettingItem *)item;
@end

NS_ASSUME_NONNULL_END
