#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
// Only the verified NewMainFrameViewController.m_tableView is tracked.
FOUNDATION_EXPORT void CSListCornerTrackSessionTable(UITableView *table);
// Lifecycle/layout refresh geometry; background setters only repair paint.
FOUNDATION_EXPORT void CSListCornerRestoreSessionTable(UITableView *table, BOOL refreshGeometry);
// Defer child-cell geometry until the enclosing native table layout is complete.
FOUNDATION_EXPORT void CSListCornerPerformSessionTableLayout(UITableView *table, void (^nativeLayout)(void));
FOUNDATION_EXPORT BOOL CSListCornerSessionTableLayoutInProgress(UITableView *table);
FOUNDATION_EXPORT UIView *CSListCornerCreateSessionGap(UITableView *table, NSInteger section, BOOL footer, CGRect frame);
NS_ASSUME_NONNULL_END
