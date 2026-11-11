#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/// Durable identity only. Account epochs belong to a tap, never to historical links.
FOUNDATION_EXPORT NSString *_Nullable CSGroupChatNoticeLink(NSString *account, NSString *room, NSString *member, NSString *event);
FOUNDATION_EXPORT NSDictionary<NSString *, NSString *> *_Nullable CSGroupChatParseNoticeLink(id _Nullable link);
/// Every owned anchor and the optional persisted marker must identify the same event.
FOUNDATION_EXPORT NSDictionary<NSString *, NSString *> *_Nullable CSGroupChatResolveNoticeLink(id _Nullable clickedLink, NSString *content, NSString *_Nullable pattern);
NS_ASSUME_NONNULL_END
