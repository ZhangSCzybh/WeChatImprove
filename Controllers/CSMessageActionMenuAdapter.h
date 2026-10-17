#import "CSMessageActionCoordinator.h"
NS_ASSUME_NONNULL_BEGIN
@interface CSMessageActionMenuAdapter : NSObject
- (instancetype)initWithCoordinator:(CSMessageActionCoordinator *)coordinator;
- (NSArray *)itemsByAddingActionsForCell:(id)cell items:(nullable NSArray *)items;
- (BOOL)canPerformSelector:(SEL)selector cell:(id)cell;
- (void)performSelector:(SEL)selector cell:(id)cell;
+ (NSArray *)itemsByAddingActionsForCell:(id)cell items:(nullable NSArray *)items;
+ (BOOL)isPluginSelector:(SEL)selector;
+ (BOOL)canPerformSelector:(SEL)selector cell:(id)cell;
+ (void)performSelector:(SEL)selector cell:(id)cell;
@end
NS_ASSUME_NONNULL_END
