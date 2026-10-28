#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
// Only the verified NewMainFrameViewController.m_tableView is tracked.
FOUNDATION_EXPORT void CSListCornerTrackSessionTable(UITableView *table);
// Lifecycle/layout refresh geometry; background setters only repair paint.
FOUNDATION_EXPORT void CSListCornerRestoreSessionTable(UITableView *table, BOOL refreshGeometry);
FOUNDATION_EXPORT UIView *CSListCornerCreateSessionGap(UITableView *table, NSInteger section, BOOL footer, CGRect frame);
NS_ASSUME_NONNULL_END
