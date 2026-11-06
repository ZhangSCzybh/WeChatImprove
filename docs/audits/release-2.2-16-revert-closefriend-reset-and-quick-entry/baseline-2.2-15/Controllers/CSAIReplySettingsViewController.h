#import "CSSettingsTableViewController.h"
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface CSAISettingsPage : CSSettingsTableViewController
@end
@interface CSAIReplySettingsViewController : CSAISettingsPage
@end
/// Native details use the same preset picker and expected-account guards as settings.
FOUNDATION_EXPORT void CSAIPresentPresetPicker(UIViewController *controller, NSString * _Nullable conversation, NSString *account, NSUInteger epoch);
NS_ASSUME_NONNULL_END
