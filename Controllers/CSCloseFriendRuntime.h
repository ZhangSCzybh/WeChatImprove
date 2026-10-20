#import <Foundation/Foundation.h>
#import "CSCloseFriendPolicy.h"
#import "CSCloseFriendStore.h"
NS_ASSUME_NONNULL_BEGIN
/// Providers are injected in tests. Credential absence is nil/no error; all other failures are errors.
typedef NSDictionary * _Nullable (^CSCloseFriendCredentialReader)(NSString *, NSError **);
typedef BOOL (^CSCloseFriendCredentialWriter)(NSString *, NSDictionary *, NSError **);
@interface CSCloseFriendRuntime : NSObject
/// Compatibility initializer: injected clock is wall time; reveal uses system uptime.
- (instancetype)initWithStore:(CSCloseFriendStore *)store clock:(NSTimeInterval (^)(void))clock credentialReader:(CSCloseFriendCredentialReader)reader credentialWriter:(CSCloseFriendCredentialWriter)writer;
/// Wall time persists cooldown timestamps; elapsedClock must be monotonic and owns reveal deadlines.
- (instancetype)initWithStore:(CSCloseFriendStore *)store wallClock:(NSTimeInterval (^)(void))wallClock elapsedClock:(NSTimeInterval (^)(void))elapsedClock credentialReader:(CSCloseFriendCredentialReader)reader credentialWriter:(CSCloseFriendCredentialWriter)writer;
/// Mutations are main-thread-owned. Every async continuation must retain and validate its token.
- (void)synchronizeAccount:(NSString *)account epoch:(NSUInteger)epoch suspended:(BOOL)suspended;
- (CSCloseFriendSnapshot *)snapshotForEpoch:(NSUInteger)epoch suspended:(BOOL)suspended;
- (void)lock;
- (void)setActive:(BOOL)active;
- (nullable NSDictionary *)authenticationToken;
- (BOOL)isTokenCurrent:(NSDictionary *)token;
- (BOOL)hasCredential;
- (BOOL)setPassword:(NSString *)password token:(NSDictionary *)token error:(NSError **)error;
- (BOOL)authenticatePassword:(NSString *)password token:(NSDictionary *)token error:(NSError **)error;
/// Explicit homepage shortcut. Validates foreground account/config; no password prompt.
- (BOOL)revealWithShortcutToken:(NSDictionary *)token;
/// YES means consume locally, even if cooldown/storage prevents reveal. Unrelated queries
/// never count as failed password attempts and never write the credential.
- (BOOL)consumeSearchPassword:(NSString *)query token:(NSDictionary *)token;
/// Only call after successful LAContext biometric evaluation. Still validates token/current policy/cooldown.
- (BOOL)completeBiometricWithToken:(NSDictionary *)token;
- (BOOL)isAuthorized;
- (nullable NSDictionary *)currentProfile;
- (NSDictionary *)muteRecords;
- (BOOL)updateProfile:(NSDictionary *)profile error:(NSError **)error;
- (BOOL)saveMuteRecords:(NSDictionary *)records account:(NSString *)account epoch:(NSUInteger)epoch error:(NSError **)error;
@property(nonatomic, copy, nullable) void (^didChange)(void);
@end
NS_ASSUME_NONNULL_END
