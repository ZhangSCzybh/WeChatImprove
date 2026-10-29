#import <Foundation/Foundation.h>
#ifdef __cplusplus
extern "C" {
#endif
@interface CSCloseFriendAlertSubject : NSObject
@property(nonatomic,copy,readonly) NSString *account, *session, *sender;
@property(nonatomic,readonly) NSUInteger epoch;
+ (instancetype)subjectForSession:(NSString *)session sender:(NSString *)sender;
- (BOOL)isCurrent;
// A known stale subject must be discarded without evaluating another account's membership.
- (BOOL)shouldDiscardOutput;
@end
FOUNDATION_EXPORT CSCloseFriendAlertSubject *CSCFMessageSubject(id message, id contact);
FOUNDATION_EXPORT void CSCFBindAlert(id object, CSCloseFriendAlertSubject *subject);
FOUNDATION_EXPORT CSCloseFriendAlertSubject *CSCFBoundAlert(id object);
FOUNDATION_EXPORT void CSCFWithAlert(CSCloseFriendAlertSubject *subject, void (^action)(void));
FOUNDATION_EXPORT CSCloseFriendAlertSubject *CSCFCurrentAlert(void);
/// Payment effects consult the source, not the summary destination. Execution/ledger stay native.
FOUNDATION_EXPORT BOOL CSCFPaymentOutputAllowed(NSString *account, NSString *session, NSString *sender);
#ifdef __cplusplus
}
#endif
