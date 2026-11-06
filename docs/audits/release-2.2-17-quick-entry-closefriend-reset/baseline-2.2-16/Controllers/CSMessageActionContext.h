#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
// Signature-checked object dispatch; no KVC and no object/BOOL ABI confusion.
// ResolveSourceWrap and context capture fail closed off main (native mutable objects are UI owned).
FOUNDATION_EXPORT id _Nullable CSMessageActionObjectGetter(id _Nullable object, SEL selector);
FOUNDATION_EXPORT id _Nullable CSMessageActionResolveSourceWrap(id _Nullable cell);

// Capture/revalidate on main. Source wrap is retained read-only for the operation's bounded lifetime.
// Account identity/epoch must come from the caller's current account lifecycle, never a cached service.
@interface CSMessageActionContext : NSObject
@property(nonatomic, copy, readonly) NSString *accountID;
@property(nonatomic, readonly) NSUInteger accountEpoch;
@property(nonatomic, copy, readonly) NSString *sourceConversationID;
@property(nonatomic, copy, readonly) NSString *stableMessageIdentity;
@property(nonatomic, strong, readonly) id sourceWrap;
@property(nonatomic, weak, readonly, nullable) id cell;
@property(nonatomic, weak, readonly, nullable) id controller;
@property(nonatomic, readonly) NSUInteger bindingGeneration;
@property(nonatomic, readonly) BOOL outgoing;
@property(nonatomic, readonly) NSUInteger messageType;
@property(nonatomic, readonly) unsigned long long localID;
@property(nonatomic, readonly) unsigned long long serverID;
+ (nullable instancetype)contextWithCell:(id)cell controller:(nullable id)controller
    accountID:(NSString *)accountID accountEpoch:(NSUInteger)accountEpoch
    conversationID:(nullable NSString *)conversationID bindingGeneration:(NSUInteger)bindingGeneration;
- (BOOL)isValidForAccountID:(NSString *)accountID epoch:(NSUInteger)epoch;
// Persistent IDs may evolve local -> local+server -> server. Conflicting known server IDs fail.
// No-ID messages match only the same live wrapper and nonzero binding generation.
- (BOOL)matchesSourceContext:(CSMessageActionContext *)other;
@end
NS_ASSUME_NONNULL_END
