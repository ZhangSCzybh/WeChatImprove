#import <UIKit/UIKit.h>

// A row-local shield while the native model cannot be republished. Never captures
// private pixels, changes table visibility, or installs a window-wide mask.
@interface CSCloseFriendListTransition : NSObject
- (void)shieldCell:(UITableViewCell *)cell;
- (void)prepareForPublication;
- (void)finishOnTable:(UITableView *)table animated:(BOOL)animated;
- (void)stopAnimationOnTable:(UITableView *)table;
@end
