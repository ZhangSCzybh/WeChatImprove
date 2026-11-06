#import <UIKit/UIKit.h>
@class CSGroupRow;
/// Reversible cell-only masking; never changes session/contact/message models.
FOUNDATION_EXPORT void CSCloseFriendUpdateSessionCover(UITableViewCell *cell, CSGroupRow *row);

FOUNDATION_EXPORT void CSCloseFriendRefreshSessionCover(UITableViewCell *cell);
