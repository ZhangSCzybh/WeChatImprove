#import <Foundation/Foundation.h>
@interface CSRevokeReference : NSObject
@property(nonatomic, readonly) long long serverID;
@property(nonatomic, readonly) unsigned int localID;
+ (instancetype)referenceWithServerID:(long long)serverID localID:(unsigned int)localID;
- (NSString *)link;
@end
FOUNDATION_EXPORT BOOL CSRevokeIsSelfReplacement(NSString *text);
FOUNDATION_EXPORT BOOL CSRevokeHasOwnedReference(NSString *content, NSString *pattern);
FOUNDATION_EXPORT BOOL CSRevokeOwnsLink(id link);
FOUNDATION_EXPORT CSRevokeReference *CSRevokeResolveReference(id clickedLink, NSString *content, NSString *pattern);
FOUNDATION_EXPORT BOOL CSRevokeSessionMatches(NSString *account, NSString *session, NSString *modelChat,
                                              NSString *from, NSString *to);
@interface CSRevokeEvent : NSObject
@property(nonatomic, readonly, copy) NSString *session;
@property(nonatomic, readonly, copy) NSString *replacement;
@property(nonatomic, readonly) long long serverID;
+ (instancetype)eventFromXML:(NSString *)xml;
@end
