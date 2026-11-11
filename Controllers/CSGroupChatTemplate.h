#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
FOUNDATION_EXPORT NSString *CSGroupChatDefaultWelcome(void);
FOUNDATION_EXPORT NSString *CSGroupChatDefaultDeparture(void);
FOUNDATION_EXPORT NSString *CSGroupChatDefaultRoomDeparture(void);
FOUNDATION_EXPORT NSString *CSGroupChatNameValue(id _Nullable value);
FOUNDATION_EXPORT NSString *CSGroupChatEscapeXML(NSString *text);
// Template values are substituted in one pass; values are never interpreted as template source.
FOUNDATION_EXPORT NSString *CSGroupChatRenderTemplate(NSString *format, NSDictionary<NSString *,NSString *> *values);
FOUNDATION_EXPORT NSDictionary *CSGroupChatWelcomeText(NSString *format, NSArray<NSString *> *members, NSDictionary<NSString *,NSString *> *names, NSString *roomName, NSUInteger count, NSDate *date);
FOUNDATION_EXPORT NSDictionary *CSGroupChatWelcomeTextWithRemarks(NSString *format, NSArray<NSString *> *members, NSDictionary<NSString *,NSString *> *names, NSDictionary<NSString *,NSString *> *remarks, NSString *roomName, NSUInteger count, NSDate *date);
FOUNDATION_EXPORT NSDictionary<NSString *,NSString *> *CSGroupChatDepartureValues(NSString *memberID, NSString * _Nullable nickname, NSString * _Nullable remark, NSString *roomName, NSUInteger count, NSDate *date, NSString *reason);
FOUNDATION_EXPORT NSString *CSGroupChatDateText(NSDate *date);
NS_ASSUME_NONNULL_END
