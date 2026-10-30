#import "CSCloseFriendListShield.h"
#import <QuartzCore/QuartzCore.h>

@interface CSCloseFriendListShield ()
@property(nonatomic,strong) NSMapTable<UITableViewCell *,NSNumber *> *hiddenStates;
@property(nonatomic,weak) UITableView *table;
@property(nonatomic,strong) CALayer *originalMask;
@property(nonatomic) BOOL originalAccessibilityHidden;
@property(nonatomic,readwrite) CGSize contentSize;
@property(nonatomic,copy,readwrite) NSArray<NSNumber *> *sectionRowCounts;
@end
@implementation CSCloseFriendListShield
- (BOOL)tableShielded { return self.table!=nil; }
- (void)shieldCell:(UITableViewCell *)cell {
    if (!cell || cell.hidden) return;
    if (!self.hiddenStates) self.hiddenStates=[NSMapTable weakToStrongObjectsMapTable];
    if (![self.hiddenStates objectForKey:cell]) [self.hiddenStates setObject:@(cell.hidden) forKey:cell];
    // UIKit excludes hidden cells from display, hit testing and accessibility.
    // Keep the table/header and known ordinary cells visible throughout.
    cell.hidden=YES;
}
- (void)shieldTable:(UITableView *)table {
    [self shieldTable:table contentSize:table.contentSize];
}
- (void)shieldTable:(UITableView *)table contentSize:(CGSize)contentSize {
    [self shieldTable:table contentSize:contentSize sectionRowCounts:@[@1]];
}
- (void)shieldTable:(UITableView *)table contentSize:(CGSize)contentSize sectionRowCounts:(NSArray<NSNumber *> *)counts {
    if (!table || self.table==table) return;
    self.table=table; self.originalMask=table.layer.mask; self.contentSize=contentSize;
    self.sectionRowCounts=counts;
    self.originalAccessibilityHidden=table.accessibilityElementsHidden;
    // An empty render mask has no pixels. It does not remove the scroll view,
    // shrink its content or insert a view into the touch/gesture chain.
    [CATransaction begin]; [CATransaction setDisableActions:YES];
    table.layer.mask=[CALayer layer]; table.accessibilityElementsHidden=YES;
    [CATransaction commit];
    [self prepareForPublication];
}
- (void)prepareForPublication {
    // Restore before reload configures reused cells, never after native setup.
    for (UITableViewCell *cell in self.hiddenStates) cell.hidden=[[self.hiddenStates objectForKey:cell] boolValue];
    [self.hiddenStates removeAllObjects];
}
- (void)finishTablePublication {
    UITableView *table=self.table;
    if (!table) return;
    [CATransaction begin]; [CATransaction setDisableActions:YES];
    table.layer.mask=self.originalMask;
    table.accessibilityElementsHidden=self.originalAccessibilityHidden;
    [CATransaction commit];
    self.table=nil; self.originalMask=nil;
}
@end
