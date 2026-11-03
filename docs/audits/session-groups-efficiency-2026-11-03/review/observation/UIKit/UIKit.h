#import <Foundation/Foundation.h>

typedef NSInteger UITableViewRowAnimation;
@interface UITableView : NSObject
- (void)reloadData;
- (void)reloadRowsAtIndexPaths:(NSArray *)paths withRowAnimation:(UITableViewRowAnimation)animation;
@end
