#import <Foundation/Foundation.h>
@class CSPluginDirectoryMigration;
NS_ASSUME_NONNULL_BEGIN
/// Serial-queue-owned storage. Every published snapshot is immutable and independently valid.
@interface CSBackupStore : NSObject
@property(nonatomic,readonly) NSURL *root;
/// Optional diagnostics. Never used to decide which snapshots exist or may be removed.
@property(nonatomic,copy,nullable) void (^eventHandler)(NSString *event,NSDictionary *details);
- (instancetype)initWithRoot:(NSURL *)root;
- (instancetype)initWithMigration:(CSPluginDirectoryMigration *)migration;
/// All mutations, including recovery, must wait for complete relocation.
- (BOOL)prepareForWriting:(NSError **)error;
/// Passive phase events; neither audit failures nor handlers alter operation results.
- (void)recordRestoreStage:(NSString *)stage status:(NSString *)status error:(nullable NSError *)error details:(NSDictionary *)details;
- (BOOL)publish:(NSDictionary *)snapshot error:(NSError **)error;
/// Import provenance is durable before a snapshot becomes visible.
- (BOOL)importSnapshot:(NSDictionary *)snapshot error:(NSError **)error;
- (nullable NSDictionary *)snapshot:(NSString *)identifier error:(NSError **)error;
/// Audits selected-file/meta reads without flooding diagnostics during list scans.
- (nullable NSDictionary *)snapshotForRestore:(NSString *)identifier error:(NSError **)error;
- (NSArray<NSDictionary *> *)snapshots:(NSError **)error;
/// Includes unreadable files as unavailable records so the UI can preserve/export originals.
- (NSArray<NSDictionary *> *)records:(NSError **)error;
- (nullable NSData *)originalData:(NSString *)filename error:(NSError **)error;
- (BOOL)remove:(NSString *)identifier error:(NSError **)error;
/// Manual deletion also accepts unreadable or renamed leaf .wcbak files; never follows links or removes directories.
- (BOOL)removeFile:(NSString *)filename error:(NSError **)error;
- (NSDictionary *)metadata:(NSString *)identifier;
/// A readable copy is returned even when redundancy is degraded; error means retain it.
- (NSDictionary *)metadata:(NSString *)identifier error:(NSError **)error;
- (BOOL)setMetadata:(NSDictionary *)metadata identifier:(NSString *)identifier error:(NSError **)error;
- (BOOL)writeJournal:(NSDictionary *)journal error:(NSError **)error;
- (nullable NSDictionary *)journal:(NSError **)error;
- (BOOL)confirmActivation:(NSDictionary *)record error:(NSError **)error;
- (BOOL)activationConfirmed:(NSDictionary *)journal;
- (BOOL)archiveJournal:(NSError **)error;
@end
FOUNDATION_EXPORT BOOL CSBackupAtomicWrite(NSData *data, NSURL *url, NSError **error);
FOUNDATION_EXPORT NSData * _Nullable CSBackupReadFile(NSURL *url, NSUInteger limit, NSError **error);
NS_ASSUME_NONNULL_END
