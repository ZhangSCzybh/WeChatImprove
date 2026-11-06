#import "CSSettingsTableViewController.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSContactSeparatorSettingsViewController : CSSettingsTableViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, copy) NSString *contactId;
@property (nonatomic, copy, nullable) NSString *contactName;
@property (nonatomic, strong, nullable) UIImage *contactAvatar;

- (instancetype)initWithContactId:(NSString *)contactId contactName:(nullable NSString *)contactName contactAvatar:(nullable UIImage *)contactAvatar;
- (void)configureContactAvatarURL:(nullable NSString *)url account:(NSString *)account;

@end

NS_ASSUME_NONNULL_END
