#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
// Pure rules shared by measurement, rendering and the input boundary.
FOUNDATION_EXPORT NSArray<NSString *> *CSClownWarmExpressions(NSString *text);
@interface CSClownFakeQuoteInput : NSObject
@property(nonatomic, copy, readonly) NSString *quote;
@property(nonatomic, copy, readonly) NSString *body;
+ (nullable instancetype)parse:(NSString *)text error:(NSString *_Nullable *_Nullable)error;
@end
NS_ASSUME_NONNULL_END
