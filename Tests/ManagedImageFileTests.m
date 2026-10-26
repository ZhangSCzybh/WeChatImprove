#import <Foundation/Foundation.h>
#import "CSManagedImageFile.h"
#include <errno.h>
#include <fcntl.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <unistd.h>

static NSUInteger checks;
static NSInteger replacement;
static NSString *raceRoot;
static NSString *raceBackup;
static NSString *movedRoot;

static void Check(BOOL ok, NSString *message) {
    checks++;
    if (!ok) { fprintf(stderr, "FAIL: %s\n", message.UTF8String); exit(1); }
}

// Only the production helper's unlinkat symbol is redirected by the test build.
// This changes the directory entry after its fstatat, at the exact race boundary.
int CSManagedImageTestUnlinkAt(int directory, const char *name, int flags) {
    Check(flags == 0, @"cleanup never requests directory removal");
    NSInteger mode = replacement;
    replacement = 0;
    if (mode == 1 || mode == 2) {
        Check(renameat(directory, name, directory, ".held.png") == 0, @"hold checked file before replacement");
        if (mode == 1) {
            Check(mkdirat(directory, name, 0700) == 0, @"replace checked file with directory");
            NSString *child = [[NSString stringWithUTF8String:name] stringByAppendingPathComponent:@"keep.wcbak"];
            int file = openat(directory, child.fileSystemRepresentation, O_CREAT | O_EXCL | O_WRONLY, 0600);
            Check(file >= 0 && write(file, "retained", 8) == 8, @"replacement directory contains protected data");
            if (file >= 0) close(file);
        } else {
            Check(symlinkat(raceBackup.fileSystemRepresentation, directory, name) == 0, @"replace checked file with backup symlink");
        }
    } else if (mode == 3) {
        Check(rename(raceRoot.fileSystemRepresentation, movedRoot.fileSystemRepresentation) == 0, @"move opened resource directory");
        Check(symlink(raceBackup.fileSystemRepresentation, raceRoot.fileSystemRepresentation) == 0, @"replace resource path with backup symlink");
    }
    return unlinkat(directory, name, flags);
}

static void Write(NSData *data, NSURL *url) {
    Check([NSFileManager.defaultManager createDirectoryAtURL:url.URLByDeletingLastPathComponent
                               withIntermediateDirectories:YES attributes:nil error:NULL], @"create fixture parent");
    Check([data writeToURL:url atomically:YES], @"write isolated fixture");
}

static void Rejected(NSString *path, NSURL *root, NSString *message) {
    NSError *error = nil;
    Check(!CSManagedImageRemoveInDirectory(path, root, &error) && error != nil, message);
}

int main(int argc, const char **argv) { @autoreleasepool {
    Check(argc == 2, @"isolated root supplied");
    NSURL *fixture = [NSURL fileURLWithPath:[NSString stringWithUTF8String:argv[1]] isDirectory:YES];
    NSURL *library = [fixture URLByAppendingPathComponent:@"Library" isDirectory:YES];
    NSURL *root = [library URLByAppendingPathComponent:@"Preferences/WeChatImprove" isDirectory:YES];
    NSURL *backup = [root URLByAppendingPathComponent:@"BackupV2" isDirectory:YES];
    NSURL *closeFriends = [root URLByAppendingPathComponent:@"CloseFriends" isDirectory:YES];
    NSData *png = [[NSData alloc] initWithBase64EncodedString:@"iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMCAO+aWZcAAAAASUVORK5CYII=" options:0];
    NSData *protected = [@"retained backup bytes" dataUsingEncoding:NSUTF8StringEncoding];
    NSURL *original = [backup URLByAppendingPathComponent:@"original.wcbak"];
    Write(protected, original);
    NSURL *relationship = [closeFriends URLByAppendingPathComponent:@"fixture/relationships.plist"];
    Write(protected, relationship);
    NSFileManager *fm = NSFileManager.defaultManager;

    for (NSString *name in @[@"separator_image.png", @"tabbar_icon_chat_selected.png", @"backup_restored.png", @"UPPER.PNG"]) {
        NSURL *image = [root URLByAppendingPathComponent:name];
        Write(png, image);
        Check(CSManagedImageRemoveInDirectory(image.path, root, NULL), @"remove ordinary managed image");
        Check(![fm fileExistsAtPath:image.path], @"managed image was removed");
    }
    for (NSString *name in @[@"BackupV2/image.png", @"CloseFriends/image.png", @"CloseFriends/fixture/image.png", @"nested/other.png"]) {
        NSURL *image = [root URLByAppendingPathComponent:name];
        Write(png, image);
        Rejected(image.path, root, @"nested PNG cannot be treated as a managed image");
        Check([[NSData dataWithContentsOfURL:image] isEqual:png], @"persistent subtree PNG sentinel preserved");
    }
    Check(CSManagedImageRemoveInDirectory([root URLByAppendingPathComponent:@"missing.png"].path, root, NULL), @"missing image is already clear");
    NSURL *missingRoot = [fixture URLByAppendingPathComponent:@"never-created"];
    Check(CSManagedImageRemoveInDirectory([missingRoot URLByAppendingPathComponent:@"missing.png"].path, missingRoot, NULL), @"missing resource directory is already clear");
    Check(![fm fileExistsAtPath:missingRoot.path], @"cleanup never creates directories");

    Rejected(root.path, root, @"resource root cannot be deleted");
    Rejected(backup.path, root, @"backup directory cannot be deleted");
    Rejected(closeFriends.path, root, @"close-friend directory cannot be deleted");
    Rejected(relationship.path, root, @"relationship data cannot be deleted");
    Rejected(backup.URLByDeletingLastPathComponent.path, root, @"backup ancestor cannot be deleted");
    Rejected(original.path, root, @"individual backup cannot be deleted");
    Rejected(library.path, root, @"Library ancestor cannot be deleted");
    Rejected(@"separator_image.png", root, @"relative path rejected");
    Rejected(nil, root, @"missing preference rejected without touching disk");
    Rejected(@"", root, @"empty preference rejected");
    Rejected([root.path stringByAppendingString:@"/../escape.png"], root, @"parent traversal rejected");
    Rejected([root.path stringByAppendingString:@"/./separator_image.png"], root, @"dot traversal rejected");
    unichar zero = 0;
    NSString *embeddedNUL = [NSString stringWithFormat:@"%@/image%@.png", root.path, [NSString stringWithCharacters:&zero length:1]];
    Rejected(embeddedNUL, root, @"embedded NUL cannot truncate syscall path");
    Rejected(@"/image.png", [NSURL fileURLWithPath:@"/"], @"filesystem root is never an image resource root");
    NSURL *sibling = [NSURL fileURLWithPath:[root.path stringByAppendingString:@"Other/image.png"]];
    Write(png, sibling);
    Rejected(sibling.path, root, @"textual prefix sibling is outside resource directory");
    Check([[NSData dataWithContentsOfURL:sibling] isEqual:png], @"sibling image preserved");

    NSURL *folderImage = [root URLByAppendingPathComponent:@"directory.png"];
    NSURL *nestedBackup = [folderImage URLByAppendingPathComponent:@"keep.wcbak"];
    Write(protected, nestedBackup);
    Rejected(folderImage.path, root, @"PNG-named directory rejected");
    Check([[NSData dataWithContentsOfURL:nestedBackup] isEqual:protected], @"directory contents preserved");
    NSURL *nonImage = [root URLByAppendingPathComponent:@"keep.wcbak"];
    Write(protected, nonImage);
    Rejected(nonImage.path, root, @"non-PNG file rejected even inside resources");

    NSURL *rootLink = [fixture URLByAppendingPathComponent:@"resource-link"];
    Check([fm createSymbolicLinkAtURL:rootLink withDestinationURL:root error:NULL], @"create root symlink fixture");
    Rejected([rootLink URLByAppendingPathComponent:@"missing.png"].path, rootLink, @"symbolic-link resource root rejected");
    NSURL *parentLink = [fixture URLByAppendingPathComponent:@"parent-link"];
    Check([fm createSymbolicLinkAtURL:parentLink withDestinationURL:library error:NULL], @"create ancestor symlink fixture");
    NSURL *aliasedRoot = [parentLink URLByAppendingPathComponent:@"Preferences/WeChatImprove"];
    Rejected([aliasedRoot URLByAppendingPathComponent:@"missing.png"].path, aliasedRoot, @"untrusted resource ancestor symlink rejected");
    NSURL *middleLink = [root URLByAppendingPathComponent:@"linked"];
    Check([fm createSymbolicLinkAtURL:middleLink withDestinationURL:backup error:NULL], @"create intermediate symlink fixture");
    Write(png, [backup URLByAppendingPathComponent:@"image.png"]);
    Rejected([middleLink URLByAppendingPathComponent:@"image.png"].path, root, @"intermediate symlink cannot escape resource root");
    NSURL *finalLink = [root URLByAppendingPathComponent:@"image-link.png"];
    Check([fm createSymbolicLinkAtURL:finalLink withDestinationURL:backup error:NULL], @"create final symlink fixture");
    Rejected(finalLink.path, root, @"final symlink rejected");
    Check([fm destinationOfSymbolicLinkAtPath:finalLink.path error:NULL] != nil, @"rejected final link remains untouched");
    NSURL *fifo = [root URLByAppendingPathComponent:@"pipe.png"];
    Check(mkfifo(fifo.path.fileSystemRepresentation, 0600) == 0, @"create special-file fixture");
    Rejected(fifo.path, root, @"non-regular file rejected without opening it");

    char *resolvedRoot = realpath(root.path.fileSystemRepresentation, NULL);
    Check(resolvedRoot != NULL, @"resolve isolated root for system alias test");
    NSString *canonicalRoot = [NSString stringWithUTF8String:resolvedRoot];
    free(resolvedRoot);
    if ([canonicalRoot hasPrefix:@"/private/var/"]) {
        NSURL *aliasImage = [root URLByAppendingPathComponent:@"system-alias.png"];
        Write(png, aliasImage);
        NSString *canonicalImage = [canonicalRoot stringByAppendingPathComponent:@"system-alias.png"];
        NSString *shortImage = [canonicalImage substringFromIndex:@"/private".length];
        Check(CSManagedImageRemoveInDirectory(shortImage, [NSURL fileURLWithPath:canonicalRoot], NULL), @"system /var image alias accepted");
        Write(png, aliasImage);
        NSString *shortRoot = [canonicalRoot substringFromIndex:@"/private".length];
        Check(CSManagedImageRemoveInDirectory(canonicalImage, [NSURL fileURLWithPath:shortRoot], NULL), @"system /var resource-root alias accepted");
    }

    raceBackup = backup.path;
    for (NSInteger mode = 1; mode <= 3; mode++) {
        NSURL *race = [fixture URLByAppendingPathComponent:[NSString stringWithFormat:@"race-%ld", (long)mode]];
        NSURL *image = [race URLByAppendingPathComponent:@"image.png"];
        Write(png, image);
        raceRoot = race.path;
        movedRoot = [raceRoot stringByAppendingString:@"-moved"];
        replacement = mode;
        NSError *error = nil;
        BOOL result = CSManagedImageRemoveInDirectory(image.path, race, &error);
        Check(replacement == 0, @"race injected at production unlink boundary");
        if (mode == 1) {
            Check(!result && error != nil, @"directory replacement is never removed recursively");
            Check([fm fileExistsAtPath:[image.path stringByAppendingPathComponent:@"keep.wcbak"]], @"replacement directory data survives");
        } else if (mode == 2) {
            Check(result, @"raced final symlink is unlinked without following target");
            Check([fm destinationOfSymbolicLinkAtPath:image.path error:NULL] == nil, @"raced symlink itself removed");
        } else {
            Check(result, @"opened directory descriptor survives parent rename");
            Check(![fm fileExistsAtPath:[movedRoot stringByAppendingPathComponent:@"image.png"]], @"deletion stays in original opened directory");
            Check([[NSData dataWithContentsOfURL:[backup URLByAppendingPathComponent:@"image.png"]] isEqual:png], @"replacement root cannot redirect deletion into backup directory");
        }
        Check([[NSData dataWithContentsOfURL:original] isEqual:protected], @"all backup bytes survive race");
        Check([[NSData dataWithContentsOfURL:relationship] isEqual:protected], @"relationship bytes survive race");
    }
    Check([[NSData dataWithContentsOfURL:original] isEqual:protected], @"backup original remains unchanged after all cleanup cases");
    Check([[NSData dataWithContentsOfURL:relationship] isEqual:protected], @"relationship original remains unchanged after all cleanup cases");
    printf("Managed image deletion: %lu checks passed\n", (unsigned long)checks);
} return 0; }
