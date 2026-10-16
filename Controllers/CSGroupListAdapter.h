#import <UIKit/UIKit.h>
#import "CSGroupIndexScope.h"
NS_ASSUME_NONNULL_BEGIN
@interface CSGroupListAdapter : NSObject
@property (nonatomic, weak, readonly) UITableView *table;
@property (nonatomic, readonly, getter=isActive) BOOL active;
@property (nonatomic, readonly) BOOL publishing;
@property (nonatomic, readonly) BOOL updatingHeader;
@property (atomic, readonly) NSUInteger changeDepth;
+ (nullable instancetype)adapterForTable:(id)table;
+ (nullable instancetype)adapterForController:(id)controller;
+ (void)attachToController:(id)controller;
/// Suspend derived UI work while the native main-frame owner is offscreen.
+ (void)setPresentationSuspended:(BOOL)suspended forController:(id)controller;
+ (void)layoutForController:(id)controller;
+ (void)settingsChanged;
+ (nullable NSString *)groupTitleForTitleView:(id)titleView;
+ (void)recordNativeTitle:(nullable NSString *)title status:(unsigned int)status forTitleView:(id)titleView;
- (void)returnToGroupTop;
- (void)endSwipeEditing;
/// Wake pending work after the host custom menu handles a pan or visibility change.
- (void)nativeMenuDidChange;
/// Restrict the native row pan using the original touch position in the table.
- (BOOL)nativeMenuGesture:(UIGestureRecognizer *)gesture inCell:(UIView *)cell shouldReceiveTouch:(UITouch *)touch;
- (void)layout;
- (void)refresh;
- (void)requestRefresh;
- (void)beginNativeChange;
- (void)endNativeChange;
/// Only passive message/unread notifications use the bounded merge window.
- (void)endNativeChangeCoalesced:(BOOL)coalesced;
- (void)performNativeBatch:(void (^ _Nullable)(void))updates completion:(void (^ _Nullable)(BOOL))completion;
- (void)performInNativePresentation:(void (^)(void))action;
- (nullable id)proxyForTarget:(nullable id)target role:(NSUInteger)role;
- (nullable NSIndexPath *)nativePath:(nullable NSIndexPath *)displayPath;
- (nullable NSIndexPath *)displayPath:(nullable NSIndexPath *)nativePath;
- (NSArray<NSIndexPath *> *)nativePaths:(nullable NSArray<NSIndexPath *> *)displayPaths;
- (NSInteger)nativeRowCount:(NSInteger)section;
- (NSInteger)nativeSectionCount;
- (nullable UIView *)nativeTableHeaderView;
- (void)setNativeTableHeaderView:(nullable UIView *)header;
/// Restore the native search/header before WeChat activates its search interface.
- (void)prepareForNativeSearch;
- (nullable NSDictionary *)captureNativeEditingContextAtPath:(NSIndexPath *)path;
- (BOOL)performNativeEditingContext:(NSDictionary *)context action:(void (^)(NSIndexPath *currentPath))action;
@end
FOUNDATION_EXPORT BOOL CSGroupCardPosition(UITableView *table, NSIndexPath *path, BOOL *first, BOOL *last);
NS_ASSUME_NONNULL_END
