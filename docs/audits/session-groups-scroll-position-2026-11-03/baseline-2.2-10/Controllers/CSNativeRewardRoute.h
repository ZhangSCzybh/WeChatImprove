#import <Foundation/Foundation.h>
FOUNDATION_EXPORT NSString * const CSAuthorRewardContent;
typedef NS_ENUM(NSInteger, CSNativeRewardState) {
    CSNativeRewardIdle, CSNativeRewardPreparing, CSNativeRewardOpening,
    CSNativeRewardPresented, CSNativeRewardFinished, CSNativeRewardFailed, CSNativeRewardCancelled
};
@interface CSNativeRewardRoute : NSObject
@property(nonatomic, readonly) CSNativeRewardState state;
@property(nonatomic, copy) void (^changed)(CSNativeRewardState state, NSString *message);
- (instancetype)initWithHost:(id)host;
- (void)start;
- (void)paymentPageDidAppear;
- (void)openingTimedOut;
- (void)cancel;
@end
