#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
FOUNDATION_EXPORT NSString *const CSPluginStorageErrorDomain;
typedef NS_ENUM(NSInteger, CSPluginStorageError) {
    CSPluginStorageErrorIO = 1,
    CSPluginStorageErrorConflict = 2,
};

/// Raw-byte relocation only. No account, encryption or configuration interpretation.
@interface CSPluginDirectoryMigration : NSObject
@property(nonatomic, readonly) NSURL *destinationRoot;
@property(nonatomic, readonly) NSURL *legacyRoot;
@property(nonatomic, readonly, nullable) NSError *lastError;
- (instancetype)initWithLibrary:(NSURL *)library leaf:(NSString *)leaf;
/// Exclusive rename when possible; otherwise verified, resumable merge without overwrite.
/// A failure preserves all source files not already durably present at the destination.
- (BOOL)migrate:(NSError **)error;
/// Read fallback only. Call migrate first; never use these URLs as write destinations.
- (NSArray<NSURL *> *)readRoots;
- (NSURL *)readURLForName:(NSString *)name;
@end

FOUNDATION_EXPORT CSPluginDirectoryMigration *CSPluginStorageMigration(NSString *leaf);
NS_ASSUME_NONNULL_END
