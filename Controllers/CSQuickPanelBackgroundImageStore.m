#import "CSQuickPanelBackgroundImageStore.h"
#import "CSBackupMutation.h"
#import "CSManagedImageFile.h"
#import <CommonCrypto/CommonDigest.h>
#import <ImageIO/ImageIO.h>
#include <errno.h>
#include <fcntl.h>
#include <limits.h>
#include <math.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <unistd.h>

static const NSUInteger CSQuickPanelImageMaximumBytes = 4 * 1024 * 1024;
static const NSUInteger CSQuickPanelSourceMaximumBytes = 64 * 1024 * 1024;
// Names retain the backup journal's backup_<64 hex>.png contract while carrying
// a module namespace, so a stale preference cannot remove another module's file.
static NSString * const CSQuickPanelImageNamePrefix = @"717569636b70616e656c";

static id CSQuickPanelImageError(NSError **error, NSString *message) {
    if (error) *error = [NSError errorWithDomain:@"CSQuickPanelBackgroundImage" code:1
                                      userInfo:@{NSLocalizedDescriptionKey:message}];
    return nil;
}

static NSString *CSQuickPanelImageNormalizedPath(NSString *path) {
    if (![path isKindOfClass:NSString.class] || !path.isAbsolutePath) return nil;
    unichar zero = 0;
    if ([path rangeOfString:[NSString stringWithCharacters:&zero length:1]].location != NSNotFound) return nil;
    NSMutableArray<NSString *> *parts = [NSMutableArray array];
    for (NSString *part in [path componentsSeparatedByString:@"/"]) {
        if ([part isEqual:@"."] || [part isEqual:@".."]) return nil;
        if (part.length) [parts addObject:part];
    }
    NSString *normalized = [@"/" stringByAppendingString:[parts componentsJoinedByString:@"/"]];
    char systemVar[PATH_MAX];
    if (([normalized isEqual:@"/var"] || [normalized hasPrefix:@"/var/"]) &&
        realpath("/var", systemVar) && strcmp(systemVar, "/private/var") == 0) {
        normalized = [@"/private" stringByAppendingString:normalized];
    }
    return normalized;
}

static NSString *CSQuickPanelRestoredImageName(void) {
    static NSString *name;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        NSData *identity = [@"standard/com.wechat.enhance.quick_panel.background_image_path/" dataUsingEncoding:NSUTF8StringEncoding];
        // CSBackupCodec hashes a canonical typed string, rather than raw UTF-8.
        NSMutableData *canonical = [NSMutableData dataWithBytes:"s" length:1];
        uint64_t length = CFSwapInt64HostToBig(identity.length);
        [canonical appendBytes:&length length:sizeof(length)];
        [canonical appendData:identity];
        unsigned char digest[CC_SHA256_DIGEST_LENGTH];
        CC_SHA256(canonical.bytes, (CC_LONG)canonical.length, digest);
        NSMutableString *hex = [NSMutableString stringWithCapacity:64];
        for (NSUInteger index = 0; index < sizeof(digest); index++) [hex appendFormat:@"%02x", digest[index]];
        name = [NSString stringWithFormat:@"backup_%@.png", hex];
    });
    return name;
}

static int CSQuickPanelOpenImageDirectory(NSURL *directory) {
    NSString *expected = directory.isFileURL ? CSQuickPanelImageNormalizedPath(directory.path) : nil;
    if (!expected || [expected isEqual:@"/"]) { errno = EINVAL; return -1; }
    int descriptor = open(expected.fileSystemRepresentation, O_RDONLY | O_DIRECTORY | O_CLOEXEC | O_NOFOLLOW);
    if (descriptor < 0) return -1;
    char actual[PATH_MAX];
    if (fcntl(descriptor, F_GETPATH, actual) < 0) { int saved = errno; close(descriptor); errno = saved; return -1; }
    NSString *opened = [NSFileManager.defaultManager stringWithFileSystemRepresentation:actual length:strlen(actual)];
    if (![CSQuickPanelImageNormalizedPath(opened) isEqual:expected]) { close(descriptor); errno = EPERM; return -1; }
    return descriptor;
}

static BOOL CSQuickPanelValidImageData(NSData *data) {
    if (!data.length || data.length > CSQuickPanelImageMaximumBytes) return NO;
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    if (!source) return NO;
    NSDictionary *properties = CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(source, 0, NULL));
    double width = [properties[(__bridge NSString *)kCGImagePropertyPixelWidth] doubleValue];
    double height = [properties[(__bridge NSString *)kCGImagePropertyPixelHeight] doubleValue];
    BOOL valid = CGImageSourceGetCount(source) == 1 && isfinite(width) && isfinite(height) && width > 0 && height > 0 && width * height <= 16000000;
    if (valid) {
        CGImageRef decoded = CGImageSourceCreateImageAtIndex(source, 0, (__bridge CFDictionaryRef)@{(__bridge NSString *)kCGImageSourceShouldCache:@NO});
        valid = decoded != NULL;
        if (decoded) CGImageRelease(decoded);
    }
    CFRelease(source);
    return valid;
}

@implementation CSQuickPanelBackgroundImageStore

+ (NSURL *)resourceDirectoryURL {
    NSURL *library = [NSFileManager.defaultManager URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask].firstObject;
    return [library URLByAppendingPathComponent:@"Preferences/WeChatImprove" isDirectory:YES];
}

+ (BOOL)isManagedImagePath:(NSString *)path {
    NSString *root = CSQuickPanelImageNormalizedPath(self.resourceDirectoryURL.path);
    NSString *candidate = CSQuickPanelImageNormalizedPath(path);
    if (!root || !candidate || ![candidate.stringByDeletingLastPathComponent isEqual:root]) return NO;
    NSString *name = candidate.lastPathComponent;
    if ([name isEqual:CSQuickPanelRestoredImageName()]) return YES;
    if (name.length != 75 || ![name hasPrefix:@"backup_"] || ![name hasSuffix:@".png"]) return NO;
    NSString *hex = [name substringWithRange:NSMakeRange(7, 64)];
    if (![hex hasPrefix:CSQuickPanelImageNamePrefix]) return NO;
    return [hex rangeOfCharacterFromSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789abcdef"] invertedSet]].location == NSNotFound;
}

+ (NSData *)imageDataAtPath:(NSString *)path {
    if (![self isManagedImagePath:path]) return nil;
    int directory = CSQuickPanelOpenImageDirectory(self.resourceDirectoryURL);
    if (directory < 0) return nil;
    int descriptor = openat(directory, path.lastPathComponent.fileSystemRepresentation, O_RDONLY | O_CLOEXEC | O_NOFOLLOW | O_NONBLOCK);
    close(directory);
    if (descriptor < 0) return nil;
    struct stat status;
    if (fstat(descriptor, &status) != 0 || !S_ISREG(status.st_mode) || status.st_size <= 0 || status.st_size > (off_t)CSQuickPanelImageMaximumBytes) { close(descriptor); return nil; }
    NSMutableData *data = [NSMutableData dataWithLength:(NSUInteger)status.st_size];
    NSUInteger offset = 0;
    while (offset < data.length) {
        ssize_t count = read(descriptor, (uint8_t *)data.mutableBytes + offset, data.length - offset);
        if (count < 0 && errno == EINTR) continue;
        if (count <= 0) { close(descriptor); return nil; }
        offset += (NSUInteger)count;
    }
    close(descriptor);
    return CSQuickPanelValidImageData(data) ? data.copy : nil;
}

+ (NSString *)cs_storeImageSource:(CGImageSourceRef)source error:(NSError **)error {
    if (!source || CGImageSourceGetCount(source) != 1) return CSQuickPanelImageError(error, @"请选择一张静态图片，动态图片暂不支持。");
    NSData *encoded = nil;
    for (NSNumber *maximum in @[@1536, @1280, @1024, @768, @512]) {
        NSDictionary *options = @{(__bridge NSString *)kCGImageSourceCreateThumbnailFromImageAlways:@YES,
                                  (__bridge NSString *)kCGImageSourceCreateThumbnailWithTransform:@YES,
                                  (__bridge NSString *)kCGImageSourceThumbnailMaxPixelSize:maximum,
                                  (__bridge NSString *)kCGImageSourceShouldCacheImmediately:@YES};
        CGImageRef image = CGImageSourceCreateThumbnailAtIndex(source, 0, (__bridge CFDictionaryRef)options);
        if (!image) return CSQuickPanelImageError(error, @"无法读取所选图片，请重新选择。");
        NSMutableData *buffer = [NSMutableData data];
        CGImageDestinationRef destination = CGImageDestinationCreateWithData((__bridge CFMutableDataRef)buffer, CFSTR("public.png"), 1, NULL);
        if (destination) CGImageDestinationAddImage(destination, image, NULL);
        BOOL finished = destination && CGImageDestinationFinalize(destination);
        if (destination) CFRelease(destination);
        CGImageRelease(image);
        if (!finished) return CSQuickPanelImageError(error, @"图片转换失败，请重新选择。");
        if (buffer.length <= CSQuickPanelImageMaximumBytes) { encoded = buffer.copy; break; }
    }
    if (!CSQuickPanelValidImageData(encoded)) return CSQuickPanelImageError(error, @"图片超过 4 MiB，无法保存。");
    NSURL *root = self.resourceDirectoryURL;
    if (![NSFileManager.defaultManager createDirectoryAtURL:root withIntermediateDirectories:YES attributes:nil error:error]) return nil;
    int directory = CSQuickPanelOpenImageDirectory(root);
    if (directory < 0) return CSQuickPanelImageError(error, @"无法访问快捷面板图片目录。");
    NSString *random = [[[NSUUID.UUID.UUIDString stringByAppendingString:NSUUID.UUID.UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""] lowercaseString];
    NSString *hex = [CSQuickPanelImageNamePrefix stringByAppendingString:[random substringToIndex:64 - CSQuickPanelImageNamePrefix.length]];
    NSString *name = [NSString stringWithFormat:@"backup_%@.png", hex];
    CSBackupResourceMutationScope();
    int descriptor = openat(directory, name.fileSystemRepresentation, O_WRONLY | O_CREAT | O_EXCL | O_CLOEXEC | O_NOFOLLOW, 0600);
    if (descriptor < 0) { close(directory); return CSQuickPanelImageError(error, @"无法创建快捷面板图片文件。"); }
    NSUInteger offset = 0;
    BOOL success = YES;
    while (offset < encoded.length) {
        ssize_t count = write(descriptor, (const uint8_t *)encoded.bytes + offset, encoded.length - offset);
        if (count < 0 && errno == EINTR) continue;
        if (count <= 0) { success = NO; break; }
        offset += (NSUInteger)count;
    }
    if (success) success = fsync(descriptor) == 0;
    close(descriptor);
    if (!success) unlinkat(directory, name.fileSystemRepresentation, 0);
    close(directory);
    return success ? [root URLByAppendingPathComponent:name].path : CSQuickPanelImageError(error, @"图片保存失败，原背景已保留。");
}

+ (NSString *)storeImageAtURL:(NSURL *)url error:(NSError **)error {
    if (error) *error = nil;
    if (![url isKindOfClass:NSURL.class] || !url.isFileURL) return CSQuickPanelImageError(error, @"所选图片不是本地文件。");
    NSNumber *size = nil;
    if (![url getResourceValue:&size forKey:NSURLFileSizeKey error:error]) return nil;
    if (size.unsignedLongLongValue == 0 || size.unsignedLongLongValue > CSQuickPanelSourceMaximumBytes) return CSQuickPanelImageError(error, @"请选择小于 64 MiB 的图片。");
    CGImageSourceRef source = CGImageSourceCreateWithURL((__bridge CFURLRef)url, (__bridge CFDictionaryRef)@{(__bridge NSString *)kCGImageSourceShouldCache:@NO});
    NSString *path = [self cs_storeImageSource:source error:error];
    if (source) CFRelease(source);
    return path;
}

+ (NSString *)storeImageData:(NSData *)data error:(NSError **)error {
    if (error) *error = nil;
    if (![data isKindOfClass:NSData.class] || !data.length || data.length > CSQuickPanelSourceMaximumBytes) return CSQuickPanelImageError(error, @"请选择小于 64 MiB 的图片。");
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, (__bridge CFDictionaryRef)@{(__bridge NSString *)kCGImageSourceShouldCache:@NO});
    NSString *path = [self cs_storeImageSource:source error:error];
    if (source) CFRelease(source);
    return path;
}

+ (BOOL)removeImageAtPath:(NSString *)path error:(NSError **)error {
    if (error) *error = nil;
    if (!path) return YES;
    if (![self isManagedImagePath:path]) { CSQuickPanelImageError(error, @"图片不属于快捷面板，原文件已保留。"); return NO; }
    CSBackupResourceMutationScope();
    return CSManagedImageRemoveInDirectory(path, self.resourceDirectoryURL, error);
}

@end
