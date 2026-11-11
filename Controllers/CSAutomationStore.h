#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
FOUNDATION_EXPORT NSString *const CSAutomationBackupDomain;
FOUNDATION_EXPORT NSDictionary *CSAutomationDefaultConfiguration(void);
FOUNDATION_EXPORT BOOL CSAutomationValidateConfiguration(id configuration);
FOUNDATION_EXPORT BOOL CSAutomationValidateState(id state,NSString *account,NSError **error);
FOUNDATION_EXPORT NSURL *CSAutomationFileURL(NSURL *resourceRoot,NSString *account);
FOUNDATION_EXPORT NSDictionary *_Nullable CSAutomationReadState(NSURL *url,NSString *account,NSError **error);
FOUNDATION_EXPORT BOOL CSAutomationWriteState(NSDictionary *_Nullable state,NSURL *url,NSString *account,NSError **error);
// Foundation-only matching. Event: conversation, group, own, text, mentioned, sender.
// Decisions: module, action (text/patBack/patReply), ruleID?, contents?, quote?, mention?, delay.
FOUNDATION_EXPORT NSArray<NSDictionary *> *CSAutomationDecisions(NSDictionary *configuration,NSDictionary *event,BOOL pat);
@interface CSAutomationLedger : NSObject
- (nullable instancetype)initWithURL:(NSURL *)url account:(NSString *)account error:(NSError **)error;
// Call on one serial I/O queue. Duplicate aliases are merged durably and return NO.
- (BOOL)claimIdentifiers:(NSArray<NSString *> *)identifiers action:(NSString *)action now:(NSDate *)now error:(NSError **)error;
- (BOOL)hasIdentifiers:(NSArray<NSString *> *)identifiers action:(NSString *)action;
@end
NS_ASSUME_NONNULL_END
