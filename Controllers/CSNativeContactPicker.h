#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// Presents WeChat's own contact/group list, search and selection UI.
/// Completion runs once, after dismissal. Cancel never changes the stored list.
FOUNDATION_EXPORT BOOL CSNativeContactPickerPresent(UIViewController *presenter, NSString *title,
    BOOL groups, NSArray<NSString *> *selectedNames, BOOL (^_Nullable isValid)(void),
    void (^completion)(NSArray<NSString *> *names), NSError **error);
FOUNDATION_EXPORT void CSNativeContactPickerRevalidate(UIViewController *presenter);
NS_ASSUME_NONNULL_END
