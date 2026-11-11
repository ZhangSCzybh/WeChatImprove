#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
FOUNDATION_EXPORT NSString *const CSGroupChatBackupDomain;
FOUNDATION_EXPORT NSDictionary *CSGroupChatDefaultConfiguration(void);
FOUNDATION_EXPORT BOOL CSGroupChatValidateConfiguration(NSDictionary *configuration);
FOUNDATION_EXPORT BOOL CSGroupChatValidateState(id state, NSString *account, NSError **error);
FOUNDATION_EXPORT NSURL *CSGroupChatFileURL(NSURL *resourceRoot, NSString *account);
// Missing file returns nil without error. Invalid files are preserved and return an error.
FOUNDATION_EXPORT NSDictionary *_Nullable CSGroupChatReadState(NSURL *url, NSString *account, NSError **error);
// nil removes this module's configuration only. No runtime queue is restored.
FOUNDATION_EXPORT BOOL CSGroupChatWriteState(NSDictionary *_Nullable state, NSURL *url, NSString *account, NSError **error);
NS_ASSUME_NONNULL_END
