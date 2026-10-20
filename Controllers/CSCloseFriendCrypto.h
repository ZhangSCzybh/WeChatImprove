#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
FOUNDATION_EXPORT NSData * _Nullable CSCloseFriendRandomBytes(NSUInteger length, NSError **error);
FOUNDATION_EXPORT BOOL CSCloseFriendConstantTimeEqual(NSData *a, NSData *b);
/// Derive 32 bytes using PBKDF2-HMAC-SHA256; salt must be 32 bytes, iterations >= 210000.
FOUNDATION_EXPORT NSData * _Nullable CSCloseFriendPasswordVerifier(NSString *password, NSData *salt, NSUInteger iterations, NSError **error);
/// Independent encryption/MAC halves of an injected 64-byte key. Envelope v1 authenticates its header, IV and ciphertext.
FOUNDATION_EXPORT NSData * _Nullable CSCloseFriendEncrypt(NSData *plaintext, NSData *key, NSError **error);
FOUNDATION_EXPORT NSData * _Nullable CSCloseFriendDecrypt(NSData *envelope, NSData *key, NSError **error);
NS_ASSUME_NONNULL_END
