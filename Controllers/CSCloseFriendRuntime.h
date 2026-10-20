#import <Foundation/Foundation.h>
#import "CSCloseFriendPolicy.h"
#import "CSCloseFriendStore.h"
NS_ASSUME_NONNULL_BEGIN
/// Providers are injected in tests. Credential absence is nil/no error; all other failures are errors.
typedef NSDictionary * _Nullable (^CSCloseFriendCredentialReader)(NSString *, NSError **);
typedef BOOL (^CSCloseFriendCredentialWriter)(NSString *, NSDictionary *, NSError **);
@interface CSCloseFriendRuntime : NSObject
- (instancetype)initWithStore:(CSCloseFriendStore *)store clock:(NSTimeInterval (^)(void))clock credentialReader:(CSCloseFriendCredentialReader)reader credentialWriter:(CSCloseFriendCredentialWriter)writer;
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
