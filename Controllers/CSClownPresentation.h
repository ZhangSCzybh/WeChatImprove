#import <Foundation/Foundation.h>

// Opaque, page-scoped requests. Menu targets retain a request, never a mutable message copy.
FOUNDATION_EXPORT id CSClownCaptureEdit(id cell, BOOL image);
FOUNDATION_EXPORT id CSClownCaptureAmountEdit(id cell);
FOUNDATION_EXPORT BOOL CSClownEditIsValid(id request);
FOUNDATION_EXPORT void CSClownPerformEdit(id request);

// All entry points are main-thread UI boundaries; no message persistence or sending.
FOUNDATION_EXPORT void CSClownPageDidAppear(id controller);
FOUNDATION_EXPORT void CSClownPageDidDisappear(id controller);
FOUNDATION_EXPORT void CSClownAccountBoundary(void);
FOUNDATION_EXPORT void CSClownRestoreCell(id cell);
FOUNDATION_EXPORT void CSClownRenderCell(id cell);
FOUNDATION_EXPORT void CSClownReuseCell(id cell);
FOUNDATION_EXPORT void CSClownBindTimeCell(id cell);
FOUNDATION_EXPORT void CSClownTimeDisplayModeDidChange(id controller);

#if __has_include(<UIKit/UIKit.h>)
#import <UIKit/UIKit.h>
FOUNDATION_EXPORT CGFloat CSClownRowHeight(id controller, UITableView *table, NSIndexPath *path, CGFloat nativeHeight);
FOUNDATION_EXPORT void CSClownBindRow(id controller, UITableView *table, NSIndexPath *path, id cell);
#endif
