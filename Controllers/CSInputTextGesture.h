#import <UIKit/UIKit.h>

FOUNDATION_EXPORT void CSInputTextGestureInstall(void);
FOUNDATION_EXPORT void CSInputTextGesturePreferencesChanged(void);
FOUNDATION_EXPORT void CSInputTextGestureApplyTool(UIView *tool);
// Uses the same MMGrowTextView callbacks as the working placeholder adapter.
FOUNDATION_EXPORT void CSInputTextGestureApplyGrow(UIView *grow);
FOUNDATION_EXPORT void CSInputTextGestureChatDidLayout(UIViewController *controller);
FOUNDATION_EXPORT void CSInputTextGestureChatVisibility(UIViewController *controller, BOOL visible);
// Shared by the input delegate and the host's reverse failure-dependency hook.
FOUNDATION_EXPORT BOOL CSInputTextGesturePrioritizesRecognizer(UIGestureRecognizer *input, UIGestureRecognizer *native);
