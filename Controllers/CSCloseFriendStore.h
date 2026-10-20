#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
typedef NSData * _Nullable (^CSCloseFriendKeyProvider)(NSString *accountID, NSError **error);
FOUNDATION_EXPORT NSString *const CSCloseFriendStoreErrorDomain;
typedef NS_ENUM(NSInteger, CSCloseFriendStoreErrorCode) {
    CSCloseFriendStoreErrorInvalid=1, CSCloseFriendStoreErrorMissing=2, CSCloseFriendStoreErrorIO=3
};
/// Encrypted account state: required `profile`, optional `muteRecords` dictionary.
/// Credentials remain owned by the runtime Keychain. Account IDs occur only inside ciphertext.
/// Reads/writes are serialized in-process. Never mutate the directory from another process.
@interface CSCloseFriendStore : NSObject
@property(nonatomic, copy, readonly) NSURL *root;
- (instancetype)initWithRoot:(NSURL *)root keyProvider:(CSCloseFriendKeyProvider)keyProvider;
/// A missing file returns nil and CSCloseFriendStoreErrorMissing; unreadable data never becomes an empty profile.
- (nullable NSDictionary *)loadStateForAccountID:(NSString *)accountID error:(NSError **)error;
/// Refuses to overwrite existing corrupt, incompatible or wrongly keyed bytes. Atomic, protected, readback-verified replacement.
- (BOOL)saveState:(NSDictionary *)state forAccountID:(NSString *)accountID error:(NSError **)error;
@end
NS_ASSUME_NONNULL_END
