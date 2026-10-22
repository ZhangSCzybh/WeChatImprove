#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
/// Serial-queue-owned storage. Every published snapshot is immutable and independently valid.
@interface CSBackupStore : NSObject
@property(nonatomic,readonly) NSURL *root;
@property(nonatomic,copy,readonly) NSString *cleanupStatus;
- (instancetype)initWithRoot:(NSURL *)root;
- (BOOL)publish:(NSDictionary *)snapshot error:(NSError **)error;
/// Imported protection is durable before a new snapshot becomes visible.
- (BOOL)importSnapshot:(NSDictionary *)snapshot error:(NSError **)error;
- (nullable NSDictionary *)snapshot:(NSString *)identifier error:(NSError **)error;
- (NSArray<NSDictionary *> *)snapshots:(NSError **)error;
/// Includes unreadable files as unavailable records so the UI can preserve/export originals.
- (NSArray<NSDictionary *> *)records:(NSError **)error;
- (nullable NSData *)originalData:(NSString *)filename error:(NSError **)error;
- (BOOL)remove:(NSString *)identifier error:(NSError **)error;
- (NSDictionary *)metadata:(NSString *)identifier;
/// A readable copy is returned even when redundancy is degraded; error means retain it.
- (NSDictionary *)metadata:(NSString *)identifier error:(NSError **)error;
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
