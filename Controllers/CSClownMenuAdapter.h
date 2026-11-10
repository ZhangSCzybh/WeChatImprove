#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// Menu construction only. Captured edits are local presentation requests and never message actions.
@interface CSClownMenuAdapter : NSObject
+ (NSArray *)itemsByAddingActionsForCell:(nullable id)cell items:(nullable NSArray *)items;
+ (BOOL)isPluginSelector:(SEL)selector;
+ (BOOL)canPerformSelector:(SEL)selector cell:(nullable id)cell;
+ (void)performSelector:(SEL)selector cell:(nullable id)cell;
@end

NS_ASSUME_NONNULL_END
