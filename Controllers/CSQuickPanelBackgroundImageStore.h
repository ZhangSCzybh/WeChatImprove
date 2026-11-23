#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Owns local image bytes, independently of defaults and UIKit. Imports are synchronous;
/// call them on an I/O queue, then publish the returned path on the main queue.
@interface CSQuickPanelBackgroundImageStore : NSObject
/// A subclass may supply an isolated resource directory for deterministic tests.
+ (NSURL *)resourceDirectoryURL;
/// Reads a temporary picker file before its callback returns. Each successful import
/// creates a unique, orientation-corrected PNG, at most 1536 px and 4 MiB.
+ (nullable NSString *)storeImageAtURL:(NSURL *)url error:(NSError **)error;
+ (nullable NSString *)storeImageData:(NSData *)data error:(NSError **)error;
/// Rejects paths outside this module's namespace, symlinks and invalid image data.
+ (nullable NSData *)imageDataAtPath:(nullable NSString *)path;
+ (BOOL)isManagedImagePath:(nullable NSString *)path;
+ (BOOL)removeImageAtPath:(nullable NSString *)path error:(NSError **)error;
@end

NS_ASSUME_NONNULL_END
