#import <UIKit/UIKit.h>
FOUNDATION_EXPORT void CSBubbleStyleStart(void);
FOUNDATION_EXPORT void CSBubbleStyleApply(UIView *cell);
FOUNDATION_EXPORT void CSBubbleStyleDetach(UIView *cell);
FOUNDATION_EXPORT void CSBubbleStyleNativeChanged(UIView *cell);
// Called only by YYAsyncImageView setters. Unassociated image views pass through unchanged.
FOUNDATION_EXPORT id CSBubbleStyleImageAssignment(UIImageView *view, id nativeImage, BOOL highlighted);
FOUNDATION_EXPORT void CSBubbleStyleImageDecoded(UIImageView *view);
