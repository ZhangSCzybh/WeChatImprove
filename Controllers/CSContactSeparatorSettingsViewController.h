#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSContactSeparatorSettingsViewController : UITableViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, copy) NSString *contactId;
@property (nonatomic, copy, nullable) NSString *contactName;
@property (nonatomic, strong, nullable) UIImage *contactAvatar;

- (instancetype)initWithContactId:(NSString *)contactId contactName:(nullable NSString *)contactName contactAvatar:(nullable UIImage *)contactAvatar;

@end

NS_ASSUME_NONNULL_END
