#import <UIKit/UIKit.h>

// Called only after the bubble adapter has verified a supported message model.
FOUNDATION_EXPORT void CSBubbleTextColorsApply(UIView *cell, UIColor *color, BOOL callRecord);
FOUNDATION_EXPORT void CSBubbleTextColorsRestore(UIView *cell);
// Scoped to already-bound RichTextView instances; other native text stays untouched.
FOUNDATION_EXPORT id CSBubbleTextColorAssignment(id view, id nativeColor);
