#import <UIKit/UIKit.h>

// Only suppresses sensitive rendered cells while native publication is deferred.
// No table/window mask, placeholder, snapshot, animation or delayed completion.
@interface CSCloseFriendListShield : NSObject
- (void)shieldCell:(UITableViewCell *)cell;
- (void)prepareForPublication;
@end
