#import <Foundation/Foundation.h>
@class CSCloseFriendStore, CSCloseFriendEntryState;
NS_ASSUME_NONNULL_BEGIN
typedef NSData * _Nullable (^CSCloseFriendSecureReader)(NSString *account, NSString *kind, NSError **error);
typedef BOOL (^CSCloseFriendSecureWriter)(NSString *account, NSString *kind, NSData *data, NSError **error);
typedef BOOL (^CSCloseFriendSecureRemover)(NSString *account, NSString *kind, NSError **error);

/// Forward-only, account-scoped cleanup. A Keychain intent survives process exit;
/// unreadable/unknown intent blocks loading rather than making an account look new.
@interface CSCloseFriendReset : NSObject
- (instancetype)initWithStore:(CSCloseFriendStore *)store entryState:(CSCloseFriendEntryState *)entryState
                       reader:(CSCloseFriendSecureReader)reader writer:(CSCloseFriendSecureWriter)writer remover:(CSCloseFriendSecureRemover)remover;
/// Caller must validate a fresh password proof and explicit confirmation under the account epoch lock.
- (BOOL)beginResetForAccountID:(NSString *)account error:(NSError **)error;
/// Called before loading account state. No intent is a successful no-op.
- (BOOL)resumeResetForAccountID:(NSString *)account error:(NSError **)error;
@end
NS_ASSUME_NONNULL_END
