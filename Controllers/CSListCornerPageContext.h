#import "CSListCornerConfiguration.h"
#import "CSListCornerSectionPolicy.h"
NS_ASSUME_NONNULL_BEGIN
FOUNDATION_EXPORT UITableView * _Nullable CSListCornerTableForView(UIView *view);
FOUNDATION_EXPORT UITableView * _Nullable CSListCornerOwnedTable(id owner, CSListCornerPage page);
FOUNDATION_EXPORT BOOL CSListCornerOwnsTable(id owner, UITableView *table, CSListCornerPage page);
FOUNDATION_EXPORT id _Nullable CSListCornerOwnerForTable(UITableView *table, CSListCornerPage page);
FOUNDATION_EXPORT UIColor *CSListCornerCanvasColor(void);
FOUNDATION_EXPORT UIView * _Nullable CSListCornerNativeContent(UITableViewCell *cell);
FOUNDATION_EXPORT void CSListCornerPrepareTable(id owner, CSListCornerPage page, BOOL initial);
FOUNDATION_EXPORT void CSListCornerHideSeparator(UITableViewCell *cell);
FOUNDATION_EXPORT BOOL CSListCornerBeginOperation(id _Nullable object);
FOUNDATION_EXPORT void CSListCornerEndOperation(id object);
FOUNDATION_EXPORT UIView *CSListCornerOwnedBackground(UIView *container);
FOUNDATION_EXPORT BOOL CSListCornerValidRect(CGRect rect);
@interface CSListCornerPageContext : NSObject
@property(nonatomic, readonly) UITableViewCell *cell;
@property(nonatomic, readonly) UITableView *table;
@property(nonatomic, readonly) UIView *content;
@property(nonatomic, readonly) NSIndexPath *indexPath;
@property(nonatomic, readonly) CSListCornerSnapshot *configuration;
@property(nonatomic, readonly) CGRect cardFrame;
@property(nonatomic, readonly) UIUserInterfaceStyle style;
+ (instancetype _Nullable)contextForCell:(UITableViewCell *)cell table:(UITableView *)table indexPath:(NSIndexPath *)path page:(CSListCornerPage)page owner:(id _Nullable)owner;
- (BOOL)nativeFirst:(BOOL *)first last:(BOOL *)last;
- (void)renderFirst:(BOOL)first last:(BOOL)last;
@end
// Preserve native role classification and spacing across repeated decoration without native relayout.
FOUNDATION_EXPORT CGRect CSListCornerNativeFrame(UIView *view);
FOUNDATION_EXPORT void CSListCornerSetFrame(UIView *view, CGRect frame);
NS_ASSUME_NONNULL_END
