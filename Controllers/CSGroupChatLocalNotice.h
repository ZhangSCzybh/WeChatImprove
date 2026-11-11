#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
FOUNDATION_EXPORT BOOL CSGroupChatPostDepartureNotice(NSString *account, NSString *roomID, NSString *memberID, NSDate *date, NSString *eventID, NSString *format, NSDictionary<NSString *,NSString *> *values, BOOL (^stillAuthorized)(void));
FOUNDATION_EXPORT void CSGroupChatInstallNoticeHooks(void);
NS_ASSUME_NONNULL_END
