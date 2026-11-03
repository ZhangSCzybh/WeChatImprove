#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
FOUNDATION_EXPORT NSString * _Nullable CSPaymentString(id _Nullable value);
FOUNDATION_EXPORT NSNumber * _Nullable CSPaymentInteger(id _Nullable value);
FOUNDATION_EXPORT NSDictionary * _Nullable CSPaymentDecode(NSData * _Nullable data);
FOUNDATION_EXPORT NSDictionary * _Nullable CSPaymentQuery(NSString * _Nullable text);
FOUNDATION_EXPORT NSDictionary * _Nullable CSPaymentTransferFields(NSString * _Nullable xml, NSDictionary *native, NSString *account, NSString *from, NSString *to);
FOUNDATION_EXPORT NSDictionary * _Nullable CSPaymentXMLFields(NSString * _Nullable xml);
FOUNDATION_EXPORT BOOL CSPaymentErrorsOK(NSDictionary *dict);
FOUNDATION_EXPORT BOOL CSPaymentRequestMatches(NSDictionary *expected, NSDictionary *actual);
FOUNDATION_EXPORT NSString *CSPaymentBusinessKey(NSString *account, NSString *kind, NSString *session, NSString *identifier);

typedef NS_ENUM(NSUInteger, CSPaymentPhase) {
    CSPaymentQueued, CSPaymentQuerying, CSPaymentReady, CSPaymentOpening, CSPaymentConfirming, CSPaymentVerifying, CSPaymentFinished
};
@interface CSPaymentTask : NSObject
@property(nonatomic, copy) NSString *key;
@property(nonatomic, copy) NSString *account;
@property(nonatomic, copy) NSString *session;
@property(nonatomic, copy) NSDictionary *payload;
@property(nonatomic) uint64_t epoch;
@property(nonatomic) BOOL envelope;
@property(nonatomic) BOOL observation; // A manual request is observed, never submitted by the scheduler.
@property(nonatomic) CSPaymentPhase phase;
@property(nonatomic) NSTimeInterval readyAt, deadline;
@property(nonatomic, weak, nullable) id nativeLogic;
@property(nonatomic, strong, nullable) id queryRequest;
@property(nonatomic, strong, nullable) id openRequest;
@end

// All state has one owner (the main queue in production). The clock is injected
// so expiry/cancellation tests never sleep or contact a payment service.
@interface CSPaymentTaskStore : NSObject
@property(nonatomic, readonly) NSArray<CSPaymentTask *> *tasks;
- (BOOL)add:(CSPaymentTask *)task now:(NSTimeInterval)now;
- (BOOL)contains:(CSPaymentTask *)task;
- (void)finish:(CSPaymentTask *)task now:(NSTimeInterval)now;
- (NSArray<CSPaymentTask *> *)expireAt:(NSTimeInterval)now;
- (nullable CSPaymentTask *)nextAt:(NSTimeInterval)now serial:(BOOL)serial;
- (NSTimeInterval)nextWakeAt:(NSTimeInterval)now;
@end
NS_ASSUME_NONNULL_END
