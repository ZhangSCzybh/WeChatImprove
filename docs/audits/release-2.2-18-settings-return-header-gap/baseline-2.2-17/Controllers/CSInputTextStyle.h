#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CSInputTextNativeField) {
    CSInputTextNativePlain, CSInputTextNativeAttributed,
    CSInputTextNativeColor, CSInputTextNativeMultiline
};

FOUNDATION_EXPORT void CSInputTextStyleInstall(NSUserDefaults *defaults);
FOUNDATION_EXPORT void CSInputTextStylePreferencesChanged(void);
FOUNDATION_EXPORT void CSInputTextStyleApply(UIView *view);
FOUNDATION_EXPORT void CSInputTextStyleChatVisibility(UIViewController *controller, BOOL visible);
FOUNDATION_EXPORT void CSInputTextStyleNativeBegin(UIView *view, CSInputTextNativeField field, id value);
FOUNDATION_EXPORT void CSInputTextStyleNativeEnd(UIView *view);
