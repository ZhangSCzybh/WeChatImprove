#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
/// Serial-queue-owned storage. Every published snapshot is immutable and independently valid.
@interface CSBackupStore : NSObject
@property(nonatomic,readonly) NSURL *root;
- (instancetype)initWithRoot:(NSURL *)root;
- (BOOL)publish:(NSDictionary *)snapshot error:(NSError **)error;
- (nullable NSDictionary *)snapshot:(NSString *)identifier error:(NSError **)error;
- (NSArray<NSDictionary *> *)snapshots:(NSError **)error;
- (BOOL)remove:(NSString *)identifier error:(NSError **)error;
- (NSDictionary *)metadata:(NSString *)identifier;
- (BOOL)setMetadata:(NSDictionary *)metadata identifier:(NSString *)identifier error:(NSError **)error;
- (BOOL)writeJournal:(NSDictionary *)journal error:(NSError **)error;
- (nullable NSDictionary *)journal:(NSError **)error;
- (BOOL)confirmActivation:(NSDictionary *)record error:(NSError **)error;
- (BOOL)activationConfirmed:(NSDictionary *)journal;
- (BOOL)archiveJournal:(NSError **)error;
- (BOOL)prune:(NSError **)error;
@end
FOUNDATION_EXPORT BOOL CSBackupAtomicWrite(NSData *data, NSURL *url, NSError **error);
FOUNDATION_EXPORT NSData * _Nullable CSBackupReadFile(NSURL *url, NSUInteger limit, NSError **error);
NS_ASSUME_NONNULL_END
