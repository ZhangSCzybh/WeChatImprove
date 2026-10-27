#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// Presents WeChat's own contact/group list, search and selection UI.
/// Completion runs once, after dismissal. Cancel never changes the stored list.
FOUNDATION_EXPORT BOOL CSNativeContactPickerPresent(UIViewController *presenter, NSString *title,
    BOOL groups, NSArray<NSString *> *selectedNames, BOOL (^_Nullable isValid)(void),
    void (^completion)(NSArray<NSString *> *names), NSError **error);
/// Presents the native friend picker, then its own tag chooser after presentation.
/// Tags populate live friend selections; native search/checkmarks refine them.
/// Only the outer Done saves; cancelling either page never commits configuration.
FOUNDATION_EXPORT BOOL CSNativeContactPickerPresentTags(UIViewController *presenter, NSString *title,
    NSArray<NSString *> *selectedNames, BOOL (^_Nullable isValid)(void),
    void (^completion)(NSArray<NSString *> *names), NSError **error);
/// Same native UI, limited to one resolvable contact. Empty/multiple results cannot finish.
/// Changing the target requires unchecking the previous selection first.
FOUNDATION_EXPORT BOOL CSNativeContactPickerPresentSingle(UIViewController *presenter, NSString *title,
    BOOL groups, NSString *_Nullable selectedName, BOOL (^_Nullable isValid)(void),
    void (^completion)(NSString *name), NSError **error);
FOUNDATION_EXPORT void CSNativeContactPickerRevalidate(UIViewController *presenter);
NS_ASSUME_NONNULL_END
