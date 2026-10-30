#import <UIKit/UIKit.h>

// Known sensitive cells may be suppressed individually. An unknown content
// boundary neutralizes rendering coherently without changing scroll geometry,
// hit testing or gesture recognizers. No snapshots or deferred reveal.
@interface CSCloseFriendListShield : NSObject
@property(nonatomic,readonly) CGSize contentSize;
@property(nonatomic,copy,readonly) NSArray<NSNumber *> *sectionRowCounts;
@property(nonatomic,readonly) BOOL tableShielded;
- (void)shieldCell:(UITableViewCell *)cell;
- (void)shieldTable:(UITableView *)table;
- (void)shieldTable:(UITableView *)table contentSize:(CGSize)contentSize;
- (void)shieldTable:(UITableView *)table contentSize:(CGSize)contentSize sectionRowCounts:(NSArray<NSNumber *> *)counts;
- (void)prepareForPublication;
- (void)finishTablePublication;
@end
