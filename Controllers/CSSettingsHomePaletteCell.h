#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// Inline five-choice palette used by the Settings tab and its search result.
@interface CSSettingsHomePaletteCell : UITableViewCell
@property(nonatomic, copy, nullable) void (^customColorRequested)(void);
+ (NSString *)reuseIdentifier;
- (void)reloadTheme;
@end
NS_ASSUME_NONNULL_END
