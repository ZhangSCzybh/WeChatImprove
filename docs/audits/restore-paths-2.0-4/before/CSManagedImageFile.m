#import "CSManagedImageFile.h"
#include <errno.h>
#include <fcntl.h>
#include <limits.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <unistd.h>

static BOOL CSImageFailure(NSError **error, int code) {
    if (error) *error = [NSError errorWithDomain:NSPOSIXErrorDomain code:code userInfo:nil];
    return NO;
}

static NSString *CSImagePath(NSString *path) {
    if (![path isKindOfClass:NSString.class] || !path.isAbsolutePath) return nil;
    unichar zero = 0;
    if ([path rangeOfString:[NSString stringWithCharacters:&zero length:1]].location != NSNotFound) return nil;
    NSMutableArray<NSString *> *parts = [NSMutableArray array];
    for (NSString *part in [path componentsSeparatedByString:@"/"]) {
        if ([part isEqual:@"."] || [part isEqual:@".."]) return nil;
        if (part.length) [parts addObject:part];
    }
    NSString *normalized = [@"/" stringByAppendingString:[parts componentsJoinedByString:@"/"]];
    // iOS and macOS may persist either spelling of the system /var alias.
    // Resolve only this known system alias, never a user-controlled directory.
    char systemVar[PATH_MAX];
    if (([normalized isEqual:@"/var"] || [normalized hasPrefix:@"/var/"]) &&
        realpath("/var", systemVar) && strcmp(systemVar, "/private/var") == 0) {
        normalized = [@"/private" stringByAppendingString:normalized];
    }
    return normalized;
}

static int CSOpenImageDirectory(NSString *path) {
    int directory = open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
    if (directory < 0) return -1;
    for (NSString *part in [path componentsSeparatedByString:@"/"]) {
        if (!part.length) continue;
        int child = openat(directory, part.fileSystemRepresentation,
                           O_RDONLY | O_DIRECTORY | O_CLOEXEC | O_NOFOLLOW);
        int savedError = errno;
        close(directory);
        if (child < 0) { errno = savedError; return -1; }
        directory = child;
    }
    return directory;
}

BOOL CSManagedImageRemoveInDirectory(NSString *path, NSURL *resourceDirectory, NSError **error) {
    NSString *root = resourceDirectory.isFileURL ? CSImagePath(resourceDirectory.path) : nil;
    NSString *candidate = CSImagePath(path);
    // Every current image writer and backup restore publishes PNG files directly
    // in this directory. Persistent BackupV2/CloseFriends subtrees share the root
    // and must never be treated as image resources by a stale preference.
    if (!root || [root isEqual:@"/"] || !candidate ||
        ![candidate.stringByDeletingLastPathComponent isEqual:root] ||
        [candidate.pathExtension caseInsensitiveCompare:@"png"] != NSOrderedSame) {
        return CSImageFailure(error, EINVAL);
    }

    int directory = CSOpenImageDirectory(root);
    if (directory < 0) return errno == ENOENT ? YES : CSImageFailure(error, errno);
    const char *name = candidate.lastPathComponent.fileSystemRepresentation;
    struct stat status;
    if (fstatat(directory, name, &status, AT_SYMLINK_NOFOLLOW) != 0) {
        int savedError = errno;
        close(directory);
        return savedError == ENOENT ? YES : CSImageFailure(error, savedError);
    }
    if (!S_ISREG(status.st_mode)) {
        close(directory);
        return CSImageFailure(error, EPERM);
    }
    // A replacement directory cannot be deleted with flags=0. A replacement
    // symlink is unlinked itself; its target and any backup tree remain intact.
    int result = unlinkat(directory, name, 0);
    int savedError = errno;
    close(directory);
    return result == 0 || savedError == ENOENT ? YES : CSImageFailure(error, savedError);
}

BOOL CSManagedImageRemove(NSString *path, NSError **error) {
    NSURL *library = [NSFileManager.defaultManager URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask].firstObject;
    NSURL *root = [library URLByAppendingPathComponent:@"Preferences/WeChatImprove" isDirectory:YES];
    return CSManagedImageRemoveInDirectory(path, root, error);
}
