#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/// Passive diagnostics only. No host methods or filesystem methods are intercepted.
/// Audit failures never change backup results; queued events may be lost on process termination.
@interface CSBackupAudit : NSObject
@property(nonatomic,readonly) NSURL *root;
@property(nonatomic,readonly) NSURL *auditURL;
- (instancetype)initWithRoot:(NSURL *)root auditURL:(NSURL *)auditURL;
- (void)record:(NSString *)event details:(NSDictionary *)details stack:(BOOL)stack;
- (void)storeEvent:(NSString *)event details:(NSDictionary *)details;
/// Wait for previously submitted diagnostics. Tests only; normal operations never wait for audit I/O.
- (void)flush;
@end

FOUNDATION_EXPORT CSBackupAudit *CSBackupDefaultAudit(void);
NS_ASSUME_NONNULL_END
