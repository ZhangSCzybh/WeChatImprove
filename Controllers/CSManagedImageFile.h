#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// Clears only an existing PNG directly inside the managed resource directory.
// Missing files are already clear; nested paths, directories, symbolic links and
// other invalid paths are preserved and return NO.
FOUNDATION_EXPORT BOOL CSManagedImageRemove(NSString * _Nullable path, NSError **error);

// The caller supplies the trusted resource directory, allowing isolated tests.
FOUNDATION_EXPORT BOOL CSManagedImageRemoveInDirectory(NSString * _Nullable path,
                                                       NSURL *resourceDirectory,
                                                       NSError **error);

NS_ASSUME_NONNULL_END
