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
/// Checks off the main thread, then completes on main. YES consumes locally, including
/// cancelled checks/cooldown. Ordinary queries never count as password failures or write credentials.
- (void)checkSearchPassword:(NSString *)query token:(NSDictionary *)token isCurrent:(BOOL (^)(void))isCurrent completion:(void (^)(BOOL consumed))completion;
/// Monotonic remaining authorization time; zero while locked/inactive.
- (NSTimeInterval)revealTimeRemaining;
/// Only call after successful LAContext biometric evaluation. Still validates token/current policy/cooldown.
- (BOOL)completeBiometricWithToken:(NSDictionary *)token;
- (BOOL)isAuthorized;
- (nullable NSDictionary *)currentProfile;
- (BOOL)updateProfile:(NSDictionary *)profile error:(NSError **)error;
/// Separate password proof for destructive reset; shortcut/biometric authorization is insufficient.
- (nullable NSDictionary *)prepareResetWithPassword:(NSString *)password token:(NSDictionary *)token error:(NSError **)error;
- (void)cancelResetWithToken:(NSDictionary *)token;
/// Consumes the proof after UI confirmation. Must run under the current account epoch lock.
- (BOOL)resetWithToken:(NSDictionary *)token error:(NSError **)error;
/// Injected account cleanup: begin=NO resumes only a previously confirmed reset before loading state.
@property(nonatomic, copy, nullable) BOOL (^resetStorage)(NSString *account, BOOL begin, NSError **error);
@property(nonatomic, copy, nullable) void (^didChange)(void);
@end
NS_ASSUME_NONNULL_END
