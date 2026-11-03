#import <UIKit/UIKit.h>
@class UIImage, UIImageView;
FOUNDATION_EXPORT void CSBubbleStyleStart(void);
FOUNDATION_EXPORT void CSBubbleStyleApply(UIView *cell);
FOUNDATION_EXPORT void CSBubbleStyleDetach(UIView *cell);
FOUNDATION_EXPORT void CSBubbleStyleNativeChanged(UIView *cell);
// Called only by YYAsyncImageView setters. Unassociated image views pass through unchanged.
FOUNDATION_EXPORT id CSBubbleStyleImageAssignment(UIImageView *view, id nativeImage, BOOL highlighted);
// Observe native decoding only for a bound message background; never start decoding.
FOUNDATION_EXPORT void CSBubbleStyleObserveDisplayTask(UIImageView *view, id task);
// Observes an already-returned native decoder result only inside a bound display task.
// This callback never invokes decoding or reads YYImage's mutable cache slots.
FOUNDATION_EXPORT void CSBubbleStyleObserveDecodedImage(id source, UIImage *decoded);
#ifdef CS_BUBBLE_TESTING
// Fixtures for pixels whose native display observation has already completed.
FOUNDATION_EXPORT void CSBubbleStyleTestPublishDecodedImage(id source, UIImage *decoded, BOOL dark);
#endif
// Uses already-decoded immutable images and the shared padding cache; never forces decoding.
FOUNDATION_EXPORT BOOL CSBubbleStyleVisibleInsets(UIView *background, UIEdgeInsets *insets);
// 8.0.78 BubbleInfo's cached UIImage templates, before a cell/YYImage exists.
// Uses the fitted custom template when enabled; normal/pressed share one safe
// footprint. Native opaque short bodies need no cap-size minimum. No lazy YY getter.
FOUNDATION_EXPORT BOOL CSBubbleStyleModelInsets(id model, UIView *appearance, CGSize size, UIEdgeInsets *insets);
FOUNDATION_EXPORT BOOL CSBubbleStyleIsDark(UIView *view);
