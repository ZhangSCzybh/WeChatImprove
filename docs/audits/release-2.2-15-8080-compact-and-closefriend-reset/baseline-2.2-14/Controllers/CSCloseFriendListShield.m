#import "CSCloseFriendListShield.h"

@interface CSCloseFriendListShield ()
@property(nonatomic,strong) NSMapTable<UITableViewCell *,NSNumber *> *hiddenStates;
@end
@implementation CSCloseFriendListShield
- (void)shieldCell:(UITableViewCell *)cell {
    if (!cell || cell.hidden) return;
    if (!self.hiddenStates) self.hiddenStates=[NSMapTable weakToStrongObjectsMapTable];
    if (![self.hiddenStates objectForKey:cell]) [self.hiddenStates setObject:@(cell.hidden) forKey:cell];
    // UIKit excludes hidden cells from display, hit testing and accessibility.
    // Keep the table/header and known ordinary cells visible throughout.
    cell.hidden=YES;
}
- (void)prepareForPublication {
    // Restore before reload configures reused cells, never after native setup.
    for (UITableViewCell *cell in self.hiddenStates) cell.hidden=[[self.hiddenStates objectForKey:cell] boolValue];
    [self.hiddenStates removeAllObjects];
}
@end
