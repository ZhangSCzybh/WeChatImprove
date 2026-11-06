#import <Foundation/Foundation.h>
#import "CSManagedImageFile.h"
#import "CSBackupStore.h"

static NSUserDefaults *fixtureDefaults;
static NSURL *resourceRoot;
static NSUInteger checks;
static void Check(BOOL ok, NSString *message) {
    checks++;
    if (!ok) { fprintf(stderr, "FAIL: %s\n", message.UTF8String); exit(1); }
}
static NSArray<NSString *> *CSImageSearchPaths(NSSearchPathDirectory directory, NSSearchPathDomainMask domain, BOOL expand) {
    (void)directory; (void)domain; (void)expand;
    return @[resourceRoot.URLByDeletingLastPathComponent.URLByDeletingLastPathComponent.path];
}
static NSData *CSImagePNGRepresentation(NSData *image) { return image; }
static NSString *const kNavigationSeparatorImageKey = @"com.wechat.tweak.navigation.separator.image";

@interface CSImageFixtureDefaults : NSUserDefaults
+ (instancetype)standardUserDefaults;
@end
@implementation CSImageFixtureDefaults
+ (instancetype)standardUserDefaults { return (id)fixtureDefaults; }
@end
@interface UIAlertAction : NSObject
+ (instancetype)actionWithTitle:(NSString *)title style:(NSInteger)style handler:(id)handler;
@end
@implementation UIAlertAction
+ (instancetype)actionWithTitle:(NSString *)title style:(NSInteger)style handler:(id)handler { return [self new]; }
@end
@interface UIAlertController : NSObject
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(NSInteger)style;
- (void)addAction:(id)action;
@end
@implementation UIAlertController
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(NSInteger)style { return [self new]; }
- (void)addAction:(id)action {}
@end
@interface CSImageTableStub : NSObject
- (void)reloadData;
@end
@implementation CSImageTableStub
- (void)reloadData {}
@end
#define UIAlertControllerStyleAlert 0
#define UIAlertActionStyleDefault 0
@interface CSImageControllerProbe : NSObject
@property(nonatomic) NSInteger currentIconType;
@property(nonatomic,strong) CSImageTableStub *tableView;
@property(nonatomic,strong) NSData *separatorImage;
- (NSString *)iconKeyForType:(NSInteger)type isSelected:(BOOL)selected;
- (void)setupData;
- (void)presentViewController:(id)controller animated:(BOOL)animated completion:(id)completion;
- (void)clearCustomIcon;
- (void)saveSeparatorImage:(NSData *)image;
@end
@implementation CSImageControllerProbe
- (NSString *)iconKeyForType:(NSInteger)type isSelected:(BOOL)selected {
    return selected ? @"com.wechat.enhance.tabbar_style.icon.selected.chat" : @"com.wechat.enhance.tabbar_style.icon.chat";
}
- (void)setupData {}
- (void)presentViewController:(id)controller animated:(BOOL)animated completion:(id)completion {}
// The script extracts the complete current production method without rewriting
// its cleanup logic. Only its defaults and resource directory are isolated here.
#define NSUserDefaults CSImageFixtureDefaults
#define CSManagedImageRemove(path,error) CSManagedImageRemoveInDirectory(path,resourceRoot,error)
#define UIImage NSData
#define UIImagePNGRepresentation CSImagePNGRepresentation
#define NSSearchPathForDirectoriesInDomains CSImageSearchPaths
#define CSBackupResourceMutationScope() do {} while (0)
#include "ManagedImageCleanupMethods.inc"
#undef CSBackupResourceMutationScope
#undef NSSearchPathForDirectoriesInDomains
#undef UIImagePNGRepresentation
#undef UIImage
#undef CSManagedImageRemove
#undef NSUserDefaults
@end

int main(int argc, const char **argv) { @autoreleasepool {
    Check(argc == 2, @"isolated fixture root supplied");
    NSURL *root = [NSURL fileURLWithPath:[NSString stringWithUTF8String:argv[1]]];
    resourceRoot = [root URLByAppendingPathComponent:@"Library/Preferences/WeChatImprove"];
    NSURL *backup = [resourceRoot URLByAppendingPathComponent:@"BackupV2"];
    NSURL *closeFriends = [resourceRoot URLByAppendingPathComponent:@"CloseFriends"];
    CSBackupStore *store = [[CSBackupStore alloc] initWithRoot:backup];
    NSDictionary *snapshot = @{@"magic":@"WeChatImproveBackup", @"formatVersion":@2, @"id":NSUUID.UUID.UUIDString,
        @"name":@"manual fixture", @"createdAt":NSDate.date, @"kind":@"manual",
        @"source":@{@"account":@"fixture", @"installationID":@"fixture", @"pluginVersion":@"test"},
        @"fields":@[], @"assets":@{}, @"warnings":@[]};
    Check([store publish:snapshot error:NULL], @"publish real manual backup");
    NSData *png = [[NSData alloc] initWithBase64EncodedString:@"iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMCAO+aWZcAAAAASUVORK5CYII=" options:0];
    NSData *relationship = [@"persistent relationship sentinel" dataUsingEncoding:NSUTF8StringEncoding];
    Check([NSFileManager.defaultManager createDirectoryAtURL:closeFriends withIntermediateDirectories:YES attributes:nil error:NULL], @"create real close-friend subtree");
    NSURL *relationURL = [closeFriends URLByAppendingPathComponent:@"relationships.plist"];
    NSURL *backupImage = [backup URLByAppendingPathComponent:@"sentinel.png"];
    NSURL *relationImage = [closeFriends URLByAppendingPathComponent:@"sentinel.png"];
    Check([relationship writeToURL:relationURL atomically:YES] && [png writeToURL:backupImage atomically:YES] && [png writeToURL:relationImage atomically:YES], @"publish persistent data and nested PNG sentinels");
    NSString *suite = [@"org.wechatimprove.isolated.managed-image." stringByAppendingString:NSUUID.UUID.UUIDString];
    fixtureDefaults = [[NSUserDefaults alloc] initWithSuiteName:suite];
    CSImageControllerProbe *controller = [CSImageControllerProbe new];
    controller.tableView = [CSImageTableStub new];
    NSString *normal = [controller iconKeyForType:0 isSelected:NO], *selected = [controller iconKeyForType:0 isSelected:YES];
    for (NSString *badPath in @[backup.path, backup.URLByDeletingLastPathComponent.path, closeFriends.path, backupImage.path, relationImage.path]) {
        [fixtureDefaults setObject:badPath forKey:normal];
        [fixtureDefaults setObject:badPath forKey:selected];
        [controller clearCustomIcon];
        Check(![fixtureDefaults objectForKey:normal] && ![fixtureDefaults objectForKey:selected], @"invalid paths are still cleared from preferences");
        Check([store records:NULL].count == 1 && [store snapshot:snapshot[@"id"] error:NULL] != nil, @"production clear icon preserves complete manual backup");
        Check([[NSData dataWithContentsOfURL:relationURL] isEqual:relationship] && [[NSData dataWithContentsOfURL:backupImage] isEqual:png] && [[NSData dataWithContentsOfURL:relationImage] isEqual:png], @"production clear icon preserves both persistent subtrees");
    }
    Check([NSFileManager.defaultManager createDirectoryAtURL:resourceRoot withIntermediateDirectories:YES attributes:nil error:NULL], @"create isolated resource directory");
    NSURL *image = [resourceRoot URLByAppendingPathComponent:@"tabbar_icon_chat.png"];
    Check([png writeToURL:image atomically:YES], @"write ordinary icon fixture");
    [fixtureDefaults setObject:image.path forKey:normal];
    [controller clearCustomIcon];
    Check(![NSFileManager.defaultManager fileExistsAtPath:image.path] && ![fixtureDefaults objectForKey:normal], @"production clear icon still removes ordinary image and preference");
    Check([store records:NULL].count == 1, @"ordinary cleanup leaves manual backup listed");
    Check([[NSData dataWithContentsOfURL:relationURL] isEqual:relationship] && [[NSData dataWithContentsOfURL:backupImage] isEqual:png] && [[NSData dataWithContentsOfURL:relationImage] isEqual:png], @"ordinary cleanup preserves colocated persistent subtree sentinels");
    [controller saveSeparatorImage:png];
    Check([[NSData dataWithContentsOfURL:[resourceRoot URLByAppendingPathComponent:@"separator_image.png"]] isEqual:png], @"production separator save still writes ordinary image");
    Check([store snapshot:snapshot[@"id"] error:NULL] != nil && [[NSData dataWithContentsOfURL:relationURL] isEqual:relationship] && [[NSData dataWithContentsOfURL:backupImage] isEqual:png] && [[NSData dataWithContentsOfURL:relationImage] isEqual:png], @"separator save preserves both persistent subtrees");
    NSString *savedPreference = [fixtureDefaults stringForKey:kNavigationSeparatorImageKey];
    NSURL *savedRoot = resourceRoot;
    resourceRoot = [root URLByAppendingPathComponent:@"blocked/Library/Preferences/WeChatImprove"];
    Check([NSFileManager.defaultManager createDirectoryAtURL:resourceRoot.URLByDeletingLastPathComponent withIntermediateDirectories:YES attributes:nil error:NULL] && [relationship writeToURL:resourceRoot atomically:YES], @"create blocked resource root without replacing real fixture");
    [controller saveSeparatorImage:png];
    Check([[NSData dataWithContentsOfURL:resourceRoot] isEqual:relationship], @"blocked root is preserved instead of being deleted and recreated");
    Check([[fixtureDefaults stringForKey:kNavigationSeparatorImageKey] isEqual:savedPreference], @"failed separator save leaves existing preference intact");
    resourceRoot = savedRoot;
    [fixtureDefaults removePersistentDomainForName:suite];
    printf("Managed image cleanup integration: %lu checks passed\n", (unsigned long)checks);
} return 0; }
