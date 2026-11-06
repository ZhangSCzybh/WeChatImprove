#import <Foundation/Foundation.h>
#import "CSPluginStorage.h"
#import "CSBackupStore.h"
#import "CSBackupEngine.h"
#import "CSBackupCodec.h"
#include <sys/stat.h>
#include <unistd.h>
#include <errno.h>
static NSUInteger checks;
static NSString *fault;
static void Check(BOOL ok,NSString *message){checks++;if(!ok){fprintf(stderr,"FAIL: %s\n",message.UTF8String);exit(1);}}
// The migration translation unit alone redirects syscalls to these fault shims.
// All other production code and filesystem operations use the real functions.
int CSMigrationLinkat(int a,const char *x,int b,const char *y,int flags){
    if([fault isEqual:@"full"]){errno=ENOSPC;return -1;}
    int r=linkat(a,x,b,y,flags);if(!r&&[fault isEqual:@"linked"])_exit(77);return r;
}
int CSMigrationUnlinkat(int fd,const char *name,int flags){
    int r=unlinkat(fd,name,flags);if(!r&&[fault isEqual:@"unlinked"])_exit(77);return r;
}
static NSURL *Child(NSURL *root,NSString *name){return [root URLByAppendingPathComponent:name];}
static void Put(NSURL *url,NSString *value){Check([NSFileManager.defaultManager createDirectoryAtURL:url.URLByDeletingLastPathComponent withIntermediateDirectories:YES attributes:nil error:NULL],@"create fixture parent");Check([[value dataUsingEncoding:NSUTF8StringEncoding] writeToURL:url atomically:NO],@"write fixture");}
static BOOL Has(NSURL *url){struct stat st;return !lstat(url.fileSystemRepresentation,&st);}
static NSString *Get(NSURL *url){return [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:NULL];}
static CSPluginDirectoryMigration *Migration(NSURL *base,NSString *name){NSURL *library=Child(base,[name stringByAppendingString:@"/Library"]);[NSFileManager.defaultManager createDirectoryAtURL:library withIntermediateDirectories:YES attributes:nil error:NULL];return [[CSPluginDirectoryMigration alloc]initWithLibrary:library leaf:@"BackupV2"];}
static NSDictionary *Snapshot(void){return @{@"magic":@"WeChatImproveBackup",@"formatVersion":@2,@"id":NSUUID.UUID.UUIDString,@"name":@"migration",@"createdAt":NSDate.date,@"kind":@"manual",@"source":@{@"account":@"alice",@"installationID":@"test",@"pluginVersion":@"test"},@"fields":@[],@"assets":@{},@"warnings":@[]};}
static int ChildMigration(NSString *binary,CSPluginDirectoryMigration *m,NSString *point){NSTask *task=[NSTask new];task.executableURL=[NSURL fileURLWithPath:binary];task.arguments=@[@"--migrate",m.legacyRoot.URLByDeletingLastPathComponent.URLByDeletingLastPathComponent.URLByDeletingLastPathComponent.path,point];Check([task launchAndReturnError:NULL],@"launch crash fixture");[task waitUntilExit];return task.terminationStatus;}
int main(int argc,const char **argv){@autoreleasepool{
    if(argc==4){fault=@(argv[3]);CSPluginDirectoryMigration *m=[[CSPluginDirectoryMigration alloc]initWithLibrary:[NSURL fileURLWithPath:@(argv[2])] leaf:@"BackupV2"];return [m migrate:NULL]?0:3;}
    NSURL *base=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString]];NSError *error=nil;
    CSPluginDirectoryMigration *m=Migration(base,@"rename");
    Check([m.destinationRoot.path hasSuffix:@"Library/Preferences/WeChatImprove/BackupV2"],@"new constant");
    NSDictionary *snapshot=Snapshot();CSBackupStore *old=[[CSBackupStore alloc]initWithRoot:m.legacyRoot];
    Check([old publish:snapshot error:&error],@"real legacy backup published");
    Check([old setMetadata:@{@"favorite":@YES} identifier:snapshot[@"id"] error:&error],@"favorite metadata");
    Check([old writeJournal:@{@"state":@"prepared",@"sourceID":snapshot[@"id"]} error:&error],@"legacy pending journal");
    Put(Child(m.legacyRoot,@".pending-crash"),@"pending bytes");Put(Child(m.legacyRoot,@"nested/unknown.bin"),@"opaque bytes");
    struct stat before,after;lstat(m.legacyRoot.fileSystemRepresentation,&before);
    NSData *original=[old originalData:[snapshot[@"id"] stringByAppendingPathExtension:@"wcbak"] error:NULL];
    CSBackupStore *store=[[CSBackupStore alloc]initWithMigration:m];
    lstat(m.destinationRoot.fileSystemRepresentation,&after);
    Check(before.st_ino==after.st_ino,@"exclusive rename preserves root inode");
    Check(!Has(m.legacyRoot),@"old leaf removed only after migration");
    Check([[store originalData:[snapshot[@"id"] stringByAppendingPathExtension:@"wcbak"] error:NULL] isEqual:original],@"backup bytes identical");
    Check([[store metadata:snapshot[@"id"]][@"favorite"] boolValue],@"metadata retained");
    Check([[store journal:NULL][@"state"] isEqual:@"prepared"],@"pending journal retained");
    Check([Get(Child(m.destinationRoot,@".pending-crash")) isEqual:@"pending bytes"],@"pending files retained");
    Check([Get(Child(m.destinationRoot,@"nested/unknown.bin")) isEqual:@"opaque bytes"],@"unknown nested bytes retained");
    Check([m migrate:&error]&&!Has(m.legacyRoot),@"idempotent retry never creates old root");
    Put(Child(m.legacyRoot,@"late.bin"),@"late old data");Check([m migrate:&error],@"reappeared old path retried");Check([Get(Child(m.destinationRoot,@"late.bin")) isEqual:@"late old data"],@"late legacy data merged");

    for(NSString *point in @[@"linked",@"unlinked"]){
        m=Migration(base,point);Put(Child(m.legacyRoot,@"a.bin"),@"alpha");Put(Child(m.legacyRoot,@"nested/b.bin"),@"beta");Put(Child(m.destinationRoot,@"new.bin"),@"new");
        Check(ChildMigration(@(argv[0]),m,point)==77,[@"real process termination after " stringByAppendingString:point]);
        Check([Get(Child(m.destinationRoot,@"a.bin")) isEqual:@"alpha"],@"committed destination survives process exit");
        Check([m migrate:&error],@"resume after interrupted merge or cleanup");
        Check(!Has(m.legacyRoot),@"resumed old directory cleaned");
        Check([Get(Child(m.destinationRoot,@"nested/b.bin")) isEqual:@"beta"]&&[Get(Child(m.destinationRoot,@"new.bin")) isEqual:@"new"],@"both independent trees preserved");
    }
    m=Migration(base,@"conflict");Put(Child(m.legacyRoot,@"same.bin"),@"old");Put(Child(m.destinationRoot,@"same.bin"),@"new");Put(Child(m.legacyRoot,@"unique.bin"),@"unique");error=nil;
    Check(![m migrate:&error]&&error.code==CSPluginStorageErrorConflict,@"real collision refused before source cleanup");
    Check([Get(Child(m.legacyRoot,@"same.bin")) isEqual:@"old"]&&[Get(Child(m.destinationRoot,@"same.bin")) isEqual:@"new"],@"both conflicting originals retained");
    Check(Has(Child(m.legacyRoot,@"unique.bin"))&&!Has(Child(m.destinationRoot,@"unique.bin")),@"preflight detects collision before merging other files");
    Put(Child(m.destinationRoot,@"same.bin"),@"old");Check([m migrate:&error]&&!Has(m.legacyRoot),@"identical duplicates safely deduplicated on retry");

    m=Migration(base,@"full");old=[[CSBackupStore alloc]initWithRoot:m.legacyRoot];snapshot=Snapshot();Check([old publish:snapshot error:NULL],@"fallback real snapshot");
    Check([old writeJournal:@{@"state":@"prepared"} error:NULL],@"fallback real journal");Put(Child(m.destinationRoot,@"other.bin"),@"target data");
    fault=@"full";store=[[CSBackupStore alloc]initWithMigration:m];error=nil;
    Check([store records:&error].count==1&&error!=nil,@"failed migration lists legacy backup with warning");
    Check([store snapshot:snapshot[@"id"] error:NULL]!=nil,@"failed migration reads legacy original");
    Check([[store journal:NULL][@"state"] isEqual:@"prepared"],@"failed migration still sees pending transaction");
    Check(![store publish:Snapshot() error:NULL],@"ENOSPC blocks new backup");
    Check(![store remove:snapshot[@"id"] error:NULL],@"ENOSPC blocks source deletion");
    Check(![store removeFile:[snapshot[@"id"] stringByAppendingPathExtension:@"wcbak"] error:NULL],@"ENOSPC also blocks filename deletion");
    Check(![store setMetadata:@{@"favorite":@YES} identifier:snapshot[@"id"] error:NULL],@"ENOSPC blocks metadata mutation");
    Check(![store writeJournal:@{} error:NULL]&&![store archiveJournal:NULL]&&![store confirmActivation:@{} error:NULL],@"all mutation entry points wait for migration");
    fault=nil;Check([m migrate:&error],@"real retry succeeds after fault removed");
    Check([store snapshot:snapshot[@"id"] error:NULL]!=nil&&!Has(m.legacyRoot),@"retry now reads only destination");

    m=Migration(base,@"symlink");NSURL *outside=Child(base,@"outside");Put(Child(outside,@"keep.bin"),@"keep");
    [NSFileManager.defaultManager createDirectoryAtURL:m.legacyRoot.URLByDeletingLastPathComponent withIntermediateDirectories:YES attributes:nil error:NULL];
    Check(symlink(outside.fileSystemRepresentation,m.legacyRoot.fileSystemRepresentation)==0,@"source link fixture");error=nil;
    Check(![m migrate:&error]&&error.code==CSPluginStorageErrorConflict,@"source symbolic root rejected");
    Check([Get(Child(outside,@"keep.bin")) isEqual:@"keep"],@"outside data untouched");

    // Apply a genuinely prepared restore after relocating the entire legacy store.
    m=Migration(base,@"recovery");NSString *suite=[@"storage.migration." stringByAppendingString:NSUUID.UUID.UUIDString];
    NSUserDefaults *defaults=[[NSUserDefaults alloc]initWithSuiteName:suite];
    NSURL *resources=m.destinationRoot.URLByDeletingLastPathComponent;
    CSBackupEngine *engine=[[CSBackupEngine alloc]initWithDefaults:@{@"standard":defaults,@"legacy":defaults,@"layout":defaults} domains:@{@"standard":suite,@"legacy":suite,@"layout":suite} store:[[CSBackupStore alloc]initWithRoot:m.legacyRoot] resources:resources];
    NSDictionary *(^context)(void)=^{return @{@"account":@"alice",@"epoch":@1,@"installationID":@"migration-test",@"pluginVersion":@"test"};};engine.context=context;
    NSString *key=@"com.wechat.tweak.navigation.separator.text";[defaults setObject:@"after" forKey:key];
    NSDictionary *saved=[engine save:@"source" error:&error];Check(saved!=nil,@"recovery source saved");[defaults setObject:@"before" forKey:key];
    NSDictionary *preview=[engine preview:saved modules:[NSSet setWithObject:@"navigation"] accounts:[NSSet setWithObject:@"alice"] error:&error];
    Check([engine prepare:preview error:&error],error.description?:@"prepare old recovery");
    Put(Child(resources,@"CloseFriends/state-test.bin"),@"encrypted sentinel");
    CSBackupStore *relocated=[[CSBackupStore alloc]initWithMigration:m];
    engine=[[CSBackupEngine alloc]initWithDefaults:@{@"standard":defaults,@"legacy":defaults,@"layout":defaults} domains:@{@"standard":suite,@"legacy":suite,@"layout":suite} store:relocated resources:resources];engine.context=context;
    Check([engine applyPending:&error],error.description?:@"apply migrated pending recovery");
    Check([engine finishStartup:&error]&&[engine confirmStartup:&error],@"migrated recovery completes activation");
    Check([[defaults stringForKey:key] isEqual:@"after"],@"recovery desired configuration applied");
    Check([Get(Child(resources,@"CloseFriends/state-test.bin")) isEqual:@"encrypted sentinel"],@"recovery resources preserve close friends subtree");
    Check([relocated snapshot:saved[@"id"] error:NULL]!=nil,@"recovery resources preserve backup subtree");
    [defaults removePersistentDomainForName:suite];[NSFileManager.defaultManager removeItemAtURL:base error:NULL];
    printf("Plugin storage migration: %lu checks passed\n",(unsigned long)checks);
}return 0;}
