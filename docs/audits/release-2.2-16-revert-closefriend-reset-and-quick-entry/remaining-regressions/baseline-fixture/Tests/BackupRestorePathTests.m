#import <Foundation/Foundation.h>
#import "CSBackupEngine.h"
#import "CSBackupRegistry.h"
#import "CSBackupAssets.h"
#import <sys/stat.h>
#import "CSPluginStorage.h"
#import "CSBackupAudit.h"
#import "CSBackupRestoreDiagnostics.h"
#include <errno.h>
#include <fcntl.h>
#include <stdarg.h>
#include <unistd.h>
static NSUInteger checks,denied;
static BOOL denyAncestors;
static NSString *deniedResourceRoot,*ioFault;
int CSRestoreStoreOpen(const char *path,int flags,...){
    if([ioFault isEqual:@"create-temp"]&&strstr(path,".pending-")){errno=EACCES;return -1;}
    mode_t mode=0;if(flags&O_CREAT){va_list args;va_start(args,flags);mode=(mode_t)va_arg(args,int);va_end(args);}return open(path,flags,mode);
}
int CSRestoreStoreRename(const char *from,const char *to){if([ioFault isEqual:@"rename"]){errno=EACCES;return -1;}return rename(from,to);}
int CSRestoreStoreFsync(int fd){if([ioFault isEqual:@"fsync-file"]){errno=EIO;return -1;}return fsync(fd);}
static void Check(BOOL ok,NSString *message){checks++;if(!ok){fprintf(stderr,"FAIL: %s\n",message.UTF8String);exit(1);}}
// Only the image helper translation unit redirects open. Own-container file I/O
// remains real. This models denial of reading container-external directories.
int CSRestoreTestOpen(const char *path,int flags,...){
    if(deniedResourceRoot&&[deniedResourceRoot isEqual:@(path)]){errno=EACCES;return -1;}
    if(denyAncestors&&(!strcmp(path,"/")||!strcmp(path,"/private")||!strcmp(path,"/private/var"))){denied++;errno=EPERM;return -1;}
    mode_t mode=0;if(flags&O_CREAT){va_list args;va_start(args,flags);mode=(mode_t)va_arg(args,int);va_end(args);}return open(path,flags,mode);
}
static CSBackupEngine *Engine(CSBackupStore *store,NSURL *resources,NSString *suite,NSUserDefaults *defaults){
    CSBackupEngine *engine=[[CSBackupEngine alloc]initWithDefaults:@{@"standard":defaults,@"legacy":defaults,@"layout":defaults} domains:@{@"standard":suite,@"legacy":suite,@"layout":suite} store:store resources:resources];
    engine.context=^{return @{@"account":@"alice",@"epoch":@1,@"installationID":@"restore-path-tests",@"pluginVersion":@"test"};};return engine;
}
int main(int argc,const char **argv){@autoreleasepool{
    BOOL expectDenied=argc>1&&strcmp(argv[1],"--expect-ancestor-denial")==0;
    NSURL *base=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString]];
    NSFileManager *fm=NSFileManager.defaultManager;
    NSData *png=[[NSData alloc]initWithBase64EncodedString:@"iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMCAO+aWZcAAAAASUVORK5CYII=" options:0];
    for(NSNumber *merged in @[@NO,@YES])for(NSNumber *restricted in (expectDenied?@[@0,@1]:@[@0,@1,@2])){
        NSString *label=[NSString stringWithFormat:@"merge-%@-deny-%@",merged,restricted];
        NSURL *library=[base URLByAppendingPathComponent:[label stringByAppendingString:@"/Library"]];[fm createDirectoryAtURL:library withIntermediateDirectories:YES attributes:nil error:NULL];
        CSPluginDirectoryMigration *migration=[[CSPluginDirectoryMigration alloc]initWithLibrary:library leaf:@"BackupV2"];
        NSError *error=nil;Check([migration migrate:&error]&&migration.lastError==nil,@"new-only migration completes without old content");
        NSURL *resources=migration.destinationRoot.URLByDeletingLastPathComponent;
        NSURL *image=[resources URLByAppendingPathComponent:@"separator_image.png"],*icon=[resources URLByAppendingPathComponent:@"chat.png"],*trail=[resources URLByAppendingPathComponent:@"touch_trail.png"];
        [png writeToURL:image atomically:YES];[png writeToURL:icon atomically:YES];
        NSString *suite=[@"restore.paths." stringByAppendingString:NSUUID.UUID.UUIDString];NSUserDefaults *defaults=[[NSUserDefaults alloc]initWithSuiteName:suite];
        NSString *text=@"com.wechat.tweak.navigation.separator.text",*imageKey=@"com.wechat.tweak.navigation.separator.image",*iconKey=@"com.wechat.enhance.tabbar_style.icon.chat";
        [defaults setObject:@"wanted" forKey:text];[defaults setObject:image.path forKey:imageKey];[defaults setObject:icon.path forKey:iconKey];
        CSBackupStore *store=[[CSBackupStore alloc]initWithMigration:migration];
        NSURL *auditURL=[library URLByAppendingPathComponent:@"Preferences/com.wechat.improve.backup-audit.plist"];
        CSBackupAudit *audit=[[CSBackupAudit alloc]initWithRoot:store.root auditURL:auditURL];
        void (^handler)(NSString *,NSDictionary *)=^(NSString *event,NSDictionary *details){[audit storeEvent:event details:details];};store.eventHandler=handler;
        CSBackupEngine *engine=Engine(store,resources,suite,defaults);
        NSDictionary *saved=[engine save:@"with assets" error:&error];Check(saved!=nil&&[saved[@"assets"] count]>0,error.description?:@"publish snapshot with embedded PNG");
        if(merged.boolValue){[fm createDirectoryAtURL:migration.legacyRoot withIntermediateDirectories:YES attributes:nil error:NULL];
            NSString *filename=[saved[@"id"] stringByAppendingPathExtension:@"wcbak"];
            Check([fm copyItemAtURL:[migration.destinationRoot URLByAppendingPathComponent:filename] toURL:[migration.legacyRoot URLByAppendingPathComponent:filename] error:&error],@"same snapshot in both roots");
        }
        [defaults setObject:@"before" forKey:text];[png writeToURL:trail atomically:YES]; // Desired restore must remove this fallback PNG.
        NSDictionary *loaded=[store snapshot:saved[@"id"] error:&error];Check(loaded!=nil,@"read and decode new snapshot after optional merge");
        NSDictionary *preview=[engine preview:loaded modules:[NSSet setWithArray:CSBackupRegistry.moduleTitles.allKeys] accounts:[NSSet setWithObject:@"alice"] error:&error];
        Check(preview!=nil&&[preview[@"writes"] count]>=3,error.description?:@"materialize direct-child assets including deletion");
        Check([engine prepare:preview error:&error],error.description?:@"prepare journal in new root");
        Check([[store journal:NULL][@"state"] isEqual:@"prepared"],@"prepared is durable");
        if(merged.boolValue){[fm createDirectoryAtURL:migration.legacyRoot withIntermediateDirectories:YES attributes:nil error:NULL];Check([fm copyItemAtURL:[migration.destinationRoot URLByAppendingPathComponent:@"transaction.plist"] toURL:[migration.legacyRoot URLByAppendingPathComponent:@"transaction.plist"] error:NULL],@"pending transaction duplicated before restart");}
        // Recreate engine/store to exercise the startup path, with real assets and journal.
        store=[[CSBackupStore alloc]initWithMigration:migration];store.eventHandler=handler;engine=Engine(store,resources,suite,defaults);
        NSURL *friend=[resources URLByAppendingPathComponent:@"CloseFriends/keep.png"];
        [fm createDirectoryAtURL:friend.URLByDeletingLastPathComponent withIntermediateDirectories:YES attributes:nil error:NULL];[png writeToURL:friend atomically:YES];
        denyAncestors=restricted.integerValue==1;char *physical=realpath(resources.fileSystemRepresentation,NULL);deniedResourceRoot=restricted.integerValue==2&&physical?@(physical):nil;free(physical);denied=0;error=nil;BOOL applied=[engine applyPending:&error];denyAncestors=NO;deniedResourceRoot=nil;
        if(restricted.integerValue==2){
            Check(!applied&&error.code==CSBackupRestorePermission&&[error.localizedDescription containsString:@"权限"],@"real resource-access denial has actionable permission category");
            Check([error.userInfo[NSFilePathErrorKey] hasPrefix:resources.path],@"resource failure retains actual path");
            Check([[store journal:NULL][@"state"] isEqual:@"rollingBack"],@"failed cleanup remains pending and retains journal");
            [audit flush];NSDictionary *failed=[NSDictionary dictionaryWithContentsOfURL:auditURL][@"lastRestoreFailure"];
            Check([failed[@"details"][@"causes"] count]>0&&[failed[@"details"][@"errorCode"] integerValue]==CSBackupRestorePermission,@"passive audit persists structured failure and original cause");
            Check([engine applyPending:&error],@"rollback retries after resource permission becomes available");
            Check([[defaults stringForKey:text] isEqual:@"before"],@"rollback restores before-image rather than claiming desired restore succeeded");
            [audit flush];NSArray *events=[NSDictionary dictionaryWithContentsOfURL:auditURL][@"events"];
            BOOL cleanup=NO;for(NSDictionary *entry in events)if([entry[@"event"] isEqual:@"restore-failure-cleanup"]&&[entry[@"details"][@"status"] isEqual:@"rolledBack"])cleanup=YES;
            Check(cleanup,@"failure-cleanup completion is recorded");
        }else if(expectDenied&&restricted.boolValue){
            Check(!applied&&error!=nil&&denied>0,@"2.0-3 ancestor denial reproduces application failure");
            fprintf(stdout,"REPRO %s: domain=%s code=%ld deniedRootOpens=%lu journal=%s\n",label.UTF8String,error.domain.UTF8String,(long)error.code,(unsigned long)denied,[[store journal:NULL][@"state"] UTF8String]);
        }else{
            Check(applied,error.description?:@"apply restore despite inaccessible external ancestors");
            Check([engine finishStartup:&error]&&[engine confirmStartup:&error],error.description?:@"verify and confirm activation");
            Check([[defaults stringForKey:text] isEqual:@"wanted"],@"desired preferences applied");
            Check([[NSData dataWithContentsOfURL:[NSURL fileURLWithPath:[defaults stringForKey:iconKey]]] isEqual:png],@"materialized icon bytes retained");
            Check(![fm fileExistsAtPath:trail.path],@"unwanted fallback image removed");
            Check([[store journal:NULL][@"state"] isEqual:@"committed"]&&[store activationConfirmed:[store journal:NULL]],@"committed transaction activation confirmed");
            Check([engine applyPending:&error]&&[store journal:NULL]==nil,@"confirmed transaction archives on following startup");
            [audit flush];NSArray *events=[NSDictionary dictionaryWithContentsOfURL:auditURL][@"events"];NSMutableSet *stages=[NSMutableSet set];
            for(NSDictionary *entry in events)if([entry[@"event"] hasPrefix:@"restore-"]){[stages addObject:entry[@"event"]];Check(entry[@"details"][@"path"]!=nil&&entry[@"details"][@"errorCode"]!=nil,@"each restore stage records path and error code");}
            Check([[NSSet setWithArray:@[@"restore-validate",@"restore-prepared",@"restore-write-resource",@"restore-write-preferences",@"restore-applied",@"restore-activation",@"restore-transaction"]] isSubsetOfSet:stages],@"actual engine stages reach persistent passive audit");
        }
        Check([store snapshot:saved[@"id"] error:NULL]!=nil&&[[NSData dataWithContentsOfURL:friend] isEqual:png],@"backup and close-friend subtree retained");
        Check(![fm fileExistsAtPath:migration.legacyRoot.path]&&[migration migrate:&error]&&migration.lastError==nil,@"old directory absent is a successful state");
        [defaults removePersistentDomainForName:suite];
    }
    // Real low-level writer with syscall failures: preserve source bytes and errno/operation.
    NSURL *target=[base URLByAppendingPathComponent:@"io/transaction.plist"];NSData *old=[@"old" dataUsingEncoding:NSUTF8StringEncoding],*new=[@"new" dataUsingEncoding:NSUTF8StringEncoding];
    Check(CSBackupAtomicWrite(old,target,NULL),@"atomic writer fixture");
    for(NSString *step in @[@"create-temp",@"rename",@"fsync-file"]){ioFault=step;NSError *error=nil;
        Check(!CSBackupAtomicWrite(new,target,&error),@"injected writer failure returned");ioFault=nil;
        Check([error.domain isEqual:NSPOSIXErrorDomain]&&[error.userInfo[@"operation"] isEqual:step]&&[error.userInfo[NSFilePathErrorKey] isEqual:target.path],@"writer preserves actual operation/path/error domain");
        Check([[NSData dataWithContentsOfURL:target] isEqual:old],@"pre-commit failure preserves existing transaction");
        Check([[fm contentsOfDirectoryAtPath:target.URLByDeletingLastPathComponent.path error:NULL] count]==1,@"only this operation's pending temp is removed");
    }
    CSPluginDirectoryMigration *conflict=[[CSPluginDirectoryMigration alloc]initWithLibrary:[base URLByAppendingPathComponent:@"conflict/Library"] leaf:@"BackupV2"];
    [fm createDirectoryAtURL:conflict.legacyRoot withIntermediateDirectories:YES attributes:nil error:NULL];[fm createDirectoryAtURL:conflict.destinationRoot withIntermediateDirectories:YES attributes:nil error:NULL];
    [old writeToURL:[conflict.legacyRoot URLByAppendingPathComponent:@"same.bin"] atomically:YES];[new writeToURL:[conflict.destinationRoot URLByAppendingPathComponent:@"same.bin"] atomically:YES];
    CSBackupStore *blocked=[[CSBackupStore alloc]initWithMigration:conflict];NSError *failure=nil;
    Check([blocked snapshot:NSUUID.UUID.UUIDString error:&failure]==nil&&failure.code==CSBackupRestoreMigration&&[failure.localizedDescription containsString:@"迁移未完成"],@"real conflicting trees have a distinct migration reason");
    CSBackupStore *corrupt=[[CSBackupStore alloc]initWithRoot:[base URLByAppendingPathComponent:@"corrupt"]];NSString *identifier=NSUUID.UUID.UUIDString;
    Check(CSBackupAtomicWrite(old,[corrupt.root URLByAppendingPathComponent:[identifier stringByAppendingPathExtension:@"wcbak"]],NULL),@"invalid snapshot fixture");failure=nil;
    Check([corrupt snapshot:identifier error:&failure]==nil&&failure.code==CSBackupRestoreValidation&&[failure.localizedDescription containsString:@"校验失败"],@"corrupt snapshot is distinguished from migration or permissions");
    Check(CSBackupAtomicWrite(old,[corrupt.root URLByAppendingPathComponent:@"transaction.plist"],NULL),@"corrupt transaction fixture");failure=nil;
    Check([corrupt journal:&failure]==nil&&failure.code==CSBackupRestoreValidation,@"corrupt journal rejected without treating it as absent");
    if(getuid()!=0){
        NSURL *image=[target.URLByDeletingLastPathComponent URLByAppendingPathComponent:@"locked.png"];[png writeToURL:image atomically:YES];
        Check(chmod(image.fileSystemRepresentation,0000)==0,@"real unreadable image fixture");
        NSError *readFailure=nil;NSArray *fields=@[@{@"domain":@"standard",@"key":@"com.wechat.tweak.navigation.separator.image",@"present":@YES,@"value":image.path}];
        Check([CSBackupAssets captureFields:fields root:image.URLByDeletingLastPathComponent assets:[NSMutableDictionary dictionary] error:&readFailure]==nil,@"protected image blocks capture without dropping reference");
        NSError *reported=CSBackupRestoreError(readFailure,@"validate",CSBackupRestoreValidation,image.path);
        Check(reported.code==CSBackupRestorePermission&&[reported.localizedDescription containsString:@"读取权限"]&&[CSBackupRestoreErrorDetails(reported)[@"causes"] count]>1,@"asset wrapper retains real OS permission cause and read-specific message");
        chmod(image.fileSystemRepresentation,0600);
    }
    [fm removeItemAtURL:base error:NULL];printf("Backup restore paths: %lu checks passed\n",(unsigned long)checks);
}return 0;}
