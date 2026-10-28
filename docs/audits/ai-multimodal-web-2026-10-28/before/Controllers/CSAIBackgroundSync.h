#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/// Main-thread scheduler. The caller owns eligibility and the native sync boundary.
@interface CSAIBackgroundSync : NSObject
- (instancetype)initWithEligibility:(BOOL (^)(void))eligibility synchronize:(void (^)(void))synchronize;
@property(nonatomic,copy) NSTimeInterval (^now)(void);
@property(nonatomic,readonly) BOOL active;
- (void)refresh;
- (void)stop;
@end
NS_ASSUME_NONNULL_END
