#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
FOUNDATION_EXPORT NSNotificationName const CSAIReplyConfigurationDidChange;
FOUNDATION_EXPORT NSString *const CSAIReplyBackupDomain;
/// YES in a save error's userInfo when rename succeeded but directory durability
/// was not confirmed. The store is unready; retain credentials for both revisions.
FOUNDATION_EXPORT NSString *const CSAIReplyStoreCommitUncertainKey;
FOUNDATION_EXPORT NSURL *CSAIReplyFileURL(NSURL *root, NSString *account);
FOUNDATION_EXPORT NSDictionary *CSAIReplyDefaultConfiguration(void);
FOUNDATION_EXPORT BOOL CSAIReplyValidateConfiguration(id configuration, NSError **error);
FOUNDATION_EXPORT BOOL CSAIReplyValidateState(id state, NSString *account, NSError **error);
FOUNDATION_EXPORT NSDictionary *CSAIReplyPortableState(NSDictionary *state);
FOUNDATION_EXPORT NSString *CSAIConnectionIdentifier(NSDictionary *configuration);
FOUNDATION_EXPORT BOOL CSAIReplyUsesResponses(NSDictionary *configuration);
FOUNDATION_EXPORT BOOL CSAIReplyValidateUsage(id usage);
FOUNDATION_EXPORT NSError *CSAIError(NSInteger code, NSString *message);
/// Single serialized owner. Configuration contains no credentials or chat text.
@interface CSAIReplyStore : NSObject
@property(nonatomic,copy,readonly) NSString *account;
@property(nonatomic,copy,readonly) NSDictionary *configuration;
@property(nonatomic,copy,readonly) NSArray<NSDictionary *> *history;
@property(nonatomic,readonly) BOOL ready;
@property(nonatomic,strong,readonly,nullable) NSError *error;
- (instancetype)initWithURL:(NSURL *)url account:(NSString *)account;
- (BOOL)load;
- (BOOL)saveConfiguration:(NSDictionary *)configuration error:(NSError **)error;
- (BOOL)hasHandledMessageID:(NSString *)identifier;
/// Durably reserves all identities before network work; duplicates fail without mutation.
- (BOOL)claimMessageIDs:(NSArray<NSString *> *)identifiers error:(NSError **)error;
- (BOOL)appendHistory:(NSDictionary *)record error:(NSError **)error;
+ (nullable NSDictionary *)readStateAtURL:(NSURL *)url account:(NSString *)account error:(NSError **)error;
+ (BOOL)replaceState:(nullable NSDictionary *)state atURL:(NSURL *)url account:(NSString *)account error:(NSError **)error;
@end
NS_ASSUME_NONNULL_END
