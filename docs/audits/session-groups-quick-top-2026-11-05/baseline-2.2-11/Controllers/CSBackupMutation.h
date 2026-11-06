#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
/// Resource file and preference changes share a generation. Capture never accepts
/// a candidate spanning a writer; writers do not block the main thread on backup IO.
@interface CSBackupMutation : NSObject
@end
#define CSBackupResourceMutationScope() __attribute__((objc_precise_lifetime)) CSBackupMutation *csBackupMutation = [CSBackupMutation new]; (void)csBackupMutation
FOUNDATION_EXPORT uint64_t CSBackupResourceRevision(void);
FOUNDATION_EXPORT BOOL CSBackupResourceWriteInProgress(void);
NS_ASSUME_NONNULL_END
