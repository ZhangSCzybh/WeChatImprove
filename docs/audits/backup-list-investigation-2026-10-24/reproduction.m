#import <Foundation/Foundation.h>
#import "CSBackupStore.h"
#import "CSBackupCodec.h"
#import "CSBackupEngine.h"
#include <sys/stat.h>
#include <unistd.h>
static NSUInteger checks;
static void Check(BOOL ok, NSString *message) { checks++; if(!ok) { fprintf(stderr,"FAIL: %s\n",message.UTF8String);exit(1); } }
static NSDictionary *Snapshot(NSString *kind) { return @{@"magic":@"WeChatImproveBackup",@"formatVersion":@2,@"id":NSUUID.UUID.UUIDString,@"name":@"diagnostic",@"createdAt":NSDate.date,@"kind":kind,@"source":@{@"account":@"alice",@"installationID":@"diagnostic-install",@"pluginVersion":@"2.0-1"},@"fields":@[],@"assets":@{},@"warnings":@[]}; }
int main(void) { @autoreleasepool {
    Check(geteuid()!=0,@"permission scenario requires ordinary user");
    NSFileManager *fm=NSFileManager.defaultManager;
    NSURL *base=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:[@"backup-list-fixture-" stringByAppendingString:NSUUID.UUID.UUIDString]] isDirectory:YES];
    NSURL *root=[base URLByAppendingPathComponent:@"container-a/Library/Application Support/WeChatImprove/BackupV2" isDirectory:YES];
    CSBackupStore *store=[[CSBackupStore alloc]initWithRoot:root];
    NSDictionary *manual=Snapshot(@"manual");NSError *error=nil;
    Check([store publish:manual error:&error],@"publish manual through production store");
    NSString *filename=[manual[@"id"] stringByAppendingPathExtension:@"wcbak"];
    NSURL *original=[root URLByAppendingPathComponent:filename];NSData *bytes=[NSData dataWithContentsOfURL:original];
    Check([store records:&error].count==1&&error==nil,@"manual initially visible");
    Check(chmod(root.path.fileSystemRepresentation,0000)==0,@"simulate unavailable directory");
    error=nil;NSArray *blocked=[store records:&error];
    Check(chmod(root.path.fileSystemRepresentation,0700)==0,@"restore only fixture permissions");
    Check(blocked.count==0&&error!=nil,@"scan failure returns empty with error");
    NSString *readFailure=[NSString stringWithFormat:@"%@/%ld",error.domain,(long)error.code];
    Check([[NSData dataWithContentsOfURL:original] isEqual:bytes],@"scan failure leaves original unchanged");
    error=nil;Check([store records:&error].count==1&&error==nil,@"next successful scan restores original row");
    printf("permission failure: rows=0, error=%s; original unchanged; retry rows=1\n",readFailure.UTF8String);

    NSURL *moved=[base URLByAppendingPathComponent:@"preserved-original-BackupV2" isDirectory:YES];
    Check([fm moveItemAtURL:root toURL:moved error:&error],@"simulate directory moved out of configured path");
    error=nil;NSArray *missing=[store records:&error];
    Check(missing.count==0&&error==nil&&[fm fileExistsAtPath:root.path],@"read silently recreates missing root and reports empty success");
    Check([[NSData dataWithContentsOfURL:[moved URLByAppendingPathComponent:filename]] isEqual:bytes],@"old snapshot survives outside configured root");
    Check([fm removeItemAtURL:root error:&error]&&[fm moveItemAtURL:moved toURL:root error:&error],@"restore only isolated original root");
    error=nil;Check([store records:&error].count==1&&error==nil,@"restored root restores row");
    printf("missing directory: recreated=true, rows=0, error=nil; saved old root still has manual; restore rows=1\n");

    NSURL *other=[base URLByAppendingPathComponent:@"container-b/Library/Application Support/WeChatImprove/BackupV2" isDirectory:YES];
    CSBackupStore *otherStore=[[CSBackupStore alloc]initWithRoot:other];
    error=nil;Check([otherStore records:&error].count==0&&error==nil,@"different container has independent empty list");
    Check([store records:NULL].count==1,@"original container retains manual");
    printf("different container: new rows=0; original container rows=1\n");

    for(NSString *ext in @[@"meta",@"meta.bak"]) Check([fm removeItemAtURL:[root URLByAppendingPathComponent:[manual[@"id"] stringByAppendingPathExtension:ext]] error:&error],@"simulate lost protection records");
    error=nil;Check([store records:&error].count==1&&error==nil,@"missing metadata does not hide snapshot");
    Check([store prune:&error]&&[store snapshot:manual[@"id"] error:NULL]!=nil,@"manual is outside pruning quotas despite missing metadata");
    printf("missing metadata: manual rows=1; manual survives prune\n");
    Check(CSBackupAtomicWrite([@"broken backup" dataUsingEncoding:NSUTF8StringEncoding],original,&error),@"simulate damaged fixture only");
    error=nil;NSArray *damaged=[store records:&error];
    Check(damaged.count==1&&[damaged[0][@"unavailable"] boolValue],@"damaged backup stays visible");
    Check(![store prune:NULL]&&[fm fileExistsAtPath:original.path],@"damaged backup preserved by prune");
    printf("damaged snapshot: rows=1, unavailable=true; file survives prune\n");
    Check(CSBackupAtomicWrite(bytes,original,&error),@"restore diagnostic snapshot bytes");

    NSMutableDictionary *defaults=[NSMutableDictionary dictionary],*domains=[NSMutableDictionary dictionary];
    for(NSString *alias in @[@"standard",@"legacy",@"layout"]) {NSString *suite=[@"backup-list-diagnostic." stringByAppendingString:NSUUID.UUID.UUIDString];domains[alias]=suite;defaults[alias]=[[NSUserDefaults alloc]initWithSuiteName:suite];}
    CSBackupEngine *engine=[[CSBackupEngine alloc]initWithDefaults:defaults domains:domains store:store resources:[base URLByAppendingPathComponent:@"resources"]];
    __block NSString *account=@"alice",*version=@"2.0-1",*installation=@"diagnostic-install";__block NSUInteger epoch=1;
    engine.context=^{return @{@"account":account,@"epoch":@(epoch),@"installationID":installation,@"pluginVersion":version};};
    error=nil;Check([engine save:@"manual A" kind:@"manual" error:&error]!=nil,@"save first account through engine");
    account=@"bob";epoch++;version=@"2.0-2";installation=@"diagnostic-install-b";
    Check([engine save:@"manual B" kind:@"manual" error:&error]!=nil,@"save changed account, epoch, version and installation context");
    Check([store records:NULL].count==3&&[store snapshot:manual[@"id"] error:NULL]!=nil,@"context change does not filter or delete old manuals");
    printf("account/epoch/version/installation changes in same root: rows=3; prior manual survives\n");
    NSData *pending=[@"not yet committed" dataUsingEncoding:NSUTF8StringEncoding];
    Check([pending writeToURL:[root URLByAppendingPathComponent:@".pending-diagnostic"] atomically:YES],@"simulate interrupted pending write");
    Check([store records:NULL].count==3,@"pending file does not replace or hide committed snapshots");
    printf("interrupted pending write: committed rows remain 3\n");
    for(NSString *alias in defaults)[defaults[alias] removePersistentDomainForName:domains[alias]];
    Check([fm removeItemAtURL:base error:NULL],@"remove isolated fixture only");
    printf("Backup list diagnosis: %lu checks passed; no device files accessed\n",(unsigned long)checks);
}return 0;}
