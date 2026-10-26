#import <Foundation/Foundation.h>
#import "CSBackupStore.h"
#import "CSBackupAssets.h"
#import "CSBackupCodec.h"
static NSUserDefaults *fixtureDefaults;
@interface ProbeDefaults : NSUserDefaults @end
@implementation ProbeDefaults
+ (NSUserDefaults *)standardUserDefaults { return fixtureDefaults; }
@end
@interface UIAlertAction : NSObject
+ (instancetype)actionWithTitle:(NSString *)title style:(NSInteger)style handler:(id)handler;
@end
@implementation UIAlertAction
+ (instancetype)actionWithTitle:(NSString *)title style:(NSInteger)style handler:(id)handler{return [self new];}
@end
@interface UIAlertController : NSObject
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(NSInteger)style;
- (void)addAction:(id)action;
@end
@implementation UIAlertController
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(NSInteger)style{return [self new];}
- (void)addAction:(id)action{}
@end
@interface TableStub : NSObject
- (void)reloadData;
@end
@implementation TableStub
- (void)reloadData{}
@end
#define UIAlertControllerStyleAlert 0
#define UIAlertActionStyleDefault 0
@interface ProbeController : NSObject
@property(nonatomic) NSInteger currentIconType;
@property(nonatomic,strong) TableStub *tableView;
- (NSString *)iconKeyForType:(NSInteger)type isSelected:(BOOL)selected;
- (void)setupData;
- (void)presentViewController:(id)controller animated:(BOOL)animated completion:(id)completion;
- (void)clearCustomIcon;
@end
@implementation ProbeController
- (NSString *)iconKeyForType:(NSInteger)type isSelected:(BOOL)selected{return selected?@"com.wechat.enhance.tabbar_style.icon.selected.chat":@"com.wechat.enhance.tabbar_style.icon.chat";}
- (void)setupData{}
- (void)presentViewController:(id)controller animated:(BOOL)animated completion:(id)completion{}
#define NSUserDefaults ProbeDefaults
- (void)clearCustomIcon {
    NSString *normalKey = [self iconKeyForType:self.currentIconType isSelected:NO];
    NSString *selectedKey = [self iconKeyForType:self.currentIconType isSelected:YES];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // 获取文件路径并删除文件
    NSString *normalPath = [defaults stringForKey:normalKey];
    NSString *selectedPath = [defaults stringForKey:selectedKey];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (normalPath && [fileManager fileExistsAtPath:normalPath]) {
        [fileManager removeItemAtPath:normalPath error:nil];
    }
    if (selectedPath && [fileManager fileExistsAtPath:selectedPath]) {
        [fileManager removeItemAtPath:selectedPath error:nil];
    }
    
    // 清除NSUserDefaults中的路径
    [defaults removeObjectForKey:normalKey];
    [defaults removeObjectForKey:selectedKey];
    [defaults synchronize];
    
    // 刷新界面显示
    [self setupData];
    [self.tableView reloadData];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.enhance.tabbar_style.changed" object:nil];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"成功"
                                                                   message:@"已清除自定义图标"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

#undef NSUserDefaults
@end
static NSUInteger checks;
static void Check(BOOL ok,NSString *message){checks++;printf("%s %s\n",ok?"PASS":"FAIL",message.UTF8String);if(!ok)exit(1);}
static NSDictionary *Snapshot(void){return @{@"magic":@"WeChatImproveBackup",@"formatVersion":@2,@"id":NSUUID.UUID.UUIDString,@"name":@"manual fixture",@"createdAt":NSDate.date,@"kind":@"manual",@"source":@{@"account":@"fixture",@"installationID":@"fixture",@"pluginVersion":@"2.0-1"},@"fields":@[],@"assets":@{},@"warnings":@[]};}
int main(int argc,const char **argv){@autoreleasepool{
 NSURL *root=[NSURL fileURLWithPath:[NSString stringWithUTF8String:argv[1]]];
 NSFileManager *fm=NSFileManager.defaultManager;
 NSString *suite=[@"org.wechatimprove.isolated.deleteprobe." stringByAppendingString:NSUUID.UUID.UUIDString];fixtureDefaults=[[NSUserDefaults alloc]initWithSuiteName:suite];
 ProbeController *controller=[ProbeController new];controller.tableView=[TableStub new];
 NSString *key=[controller iconKeyForType:0 isSelected:NO];
 NSData *png=[[NSData alloc]initWithBase64EncodedString:@"iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMCAO+aWZcAAAAASUVORK5CYII=" options:0];
 for(NSString *scenario in @[@"normal-image",@"directory-default",@"ancestor-default",@"final-symlink",@"intermediate-symlink"]){
  NSURL *caseRoot=[root URLByAppendingPathComponent:scenario];NSURL *library=[caseRoot URLByAppendingPathComponent:@"Library"];
  NSURL *backup=[library URLByAppendingPathComponent:@"Application Support/WeChatImprove/BackupV2"];
  NSURL *resources=[library URLByAppendingPathComponent:@"Preferences/WeChatImprove"];
  CSBackupStore *store=[[CSBackupStore alloc]initWithRoot:backup];NSError *error=nil;
  Check([store publish:Snapshot() error:&error]&&[store records:&error].count==1,[scenario stringByAppendingString:@": genuine manual snapshot published"]);
  [fm createDirectoryAtURL:resources withIntermediateDirectories:YES attributes:nil error:NULL];
  NSString *path=nil;
  if([scenario isEqual:@"normal-image"]){path=[resources URLByAppendingPathComponent:@"tabbar_icon_chat.png"].path;[png writeToFile:path atomically:YES];}
  else if([scenario isEqual:@"directory-default"])path=backup.path;
  else if([scenario isEqual:@"ancestor-default"])path=[backup URLByDeletingLastPathComponent].path;
  else if([scenario isEqual:@"final-symlink"]){path=[resources URLByAppendingPathComponent:@"alias.png"].path;[fm createSymbolicLinkAtPath:path withDestinationPath:backup.path error:NULL];}
  else{NSURL *alias=[resources URLByAppendingPathComponent:@"alias"];[fm createSymbolicLinkAtPath:alias.path withDestinationPath:[backup URLByDeletingLastPathComponent].path error:NULL];path=[alias URLByAppendingPathComponent:@"BackupV2"].path;}
  [fixtureDefaults setObject:path forKey:key];[controller clearCustomIcon];
  BOOL shouldRetain=[scenario isEqual:@"normal-image"]||[scenario isEqual:@"final-symlink"];
  Check([fm fileExistsAtPath:backup.path]==shouldRetain,[scenario stringByAppendingString:shouldRetain?@": backup directory preserved":@": whole backup directory removed"]);
  error=nil;Check([store records:&error].count==(shouldRetain?1:0)&&!error,[scenario stringByAppendingString:shouldRetain?@": manual snapshot remains readable":@": production list silently recreates empty directory"]);
  NSDictionary *raw=@{@"domain":@"standard",@"key":key,@"present":@YES,@"value":backup.path};
  error=nil;Check(![CSBackupAssets captureFields:@[raw] root:resources assets:[NSMutableDictionary new] error:&error]&&error,[scenario stringByAppendingString:@": current capture rejects backup-directory image path"]);
  error=nil;Check(![CSBackupAssets materializeFields:@[raw] assets:@{} root:resources writes:[NSMutableDictionary new] error:&error]&&error,[scenario stringByAppendingString:@": current restore rejects raw backup-directory image path"]);
 }
 [fixtureDefaults removePersistentDomainForName:suite];printf("Image-path deletion investigation: %lu checks passed\n",(unsigned long)checks);
}return 0;}
