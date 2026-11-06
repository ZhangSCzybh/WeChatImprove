#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "CSBackupAudit.h"
#import "CSBackupStore.h"

static NSUInteger checks,hostCalls;
static NSURL *trash;
static void Check(BOOL ok,NSString *message){checks++;if(!ok){fprintf(stderr,"FAIL: %s\n",message.UTF8String);exit(1);}}
static NSDictionary *Snapshot(void){return @{@"magic":@"WeChatImproveBackup",@"formatVersion":@2,@"id":NSUUID.UUID.UUIDString,@"name":@"fixture",@"createdAt":NSDate.date,@"kind":@"manual",@"source":@{@"account":@"fixture",@"installationID":@"fixture",@"pluginVersion":@"test"},@"fields":@[],@"assets":@{},@"warnings":@[]};}
static NSDictionary *Audit(NSURL *url){return [NSDictionary dictionaryWithContentsOfURL:url];}
static NSArray *Events(NSURL *url,NSString *kind){return [Audit(url)[@"events"] filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(NSDictionary *entry,__unused NSDictionary *bindings){return [entry[@"event"] isEqual:kind];}]];}

// Host contract fixture only. Auditing must leave both this method and Foundation untouched.
@interface TestDiskUsage : NSObject
+ (id)moveFileToTmpTrash:(NSString *)path description:(NSString *)description;
@end
@implementation TestDiskUsage
+ (id)moveFileToTmpTrash:(NSString *)path description:(__unused NSString *)description {
    hostCalls++;NSURL *destination=[trash URLByAppendingPathComponent:NSUUID.UUID.UUIDString];
    if(![NSFileManager.defaultManager moveItemAtPath:path toPath:destination.path error:NULL])return nil;
    [NSFileManager.defaultManager removeItemAtURL:destination error:NULL];return destination.path;
}
@end
static NSDictionary *Implementations(void) {
    NSMutableDictionary *result=[NSMutableDictionary dictionary];
    for(NSString *selector in @[@"removeItemAtPath:error:",@"removeItemAtURL:error:",@"moveItemAtPath:toPath:error:",@"moveItemAtURL:toURL:error:",@"replaceItemAtURL:withItemAtURL:backupItemName:options:resultingItemURL:error:"]) {
        Method method=class_getInstanceMethod(NSFileManager.class,NSSelectorFromString(selector));
        result[selector]=[NSValue valueWithPointer:method_getImplementation(method)];
    }
    Method method=class_getClassMethod(TestDiskUsage.class,@selector(moveFileToTmpTrash:description:));
    result[@"host"]=[NSValue valueWithPointer:method_getImplementation(method)];return result;
}
int main(void){@autoreleasepool{
    NSFileManager *fm=NSFileManager.defaultManager;NSDictionary *implementations=Implementations();
    NSURL *work=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString] isDirectory:YES];
    NSURL *root=[work URLByAppendingPathComponent:@"Library/Preferences/WeChatImprove/BackupV2" isDirectory:YES];
    NSURL *auditURL=[work URLByAppendingPathComponent:@"Library/Preferences/com.wechat.improve.backup-audit.plist"];
    trash=[work URLByAppendingPathComponent:@"tmp/DiskScanTrash" isDirectory:YES];
    Check([fm createDirectoryAtURL:trash withIntermediateDirectories:YES attributes:nil error:NULL],@"isolated filesystem fixture");
    CSBackupAudit *audit=[[CSBackupAudit alloc]initWithRoot:root auditURL:auditURL];[audit flush];
    Check(![fm fileExistsAtPath:root.path]&&! [fm fileExistsAtPath:auditURL.path],@"audit init does not create backup root or write audit without events");
    Check([Implementations() isEqual:implementations],@"audit init does not replace host or Foundation implementations");
    Check(![audit respondsToSelector:NSSelectorFromString(@"affectsBackup:")],@"auditor exposes no path-blocking decision");
    CSBackupStore *store=[[CSBackupStore alloc]initWithRoot:root];
    store.eventHandler=^(NSString *event,NSDictionary *details){[audit storeEvent:event details:details];};
    NSDictionary *backup=Snapshot();Check([store publish:backup error:NULL],@"publish under Preferences");[audit flush];
    Check([Audit(auditURL)[@"lastPublished"][@"id"] isEqual:backup[@"id"]],@"published receipt persisted asynchronously");
    Check([Audit(auditURL)[@"lastPublished"][@"root"] isEqual:root.path],@"receipt uses new Preferences root");
    Check([Audit(auditURL)[@"schema"] isEqual:@2],@"passive audit schema identified");
    NSDictionary *published=Events(auditURL,@"published").lastObject;
    Check([published[@"rootIdentity"][@"exists"] boolValue]&&[published[@"rootIdentityObservedAt"] isKindOfClass:NSDate.class],@"directory identity observation time recorded independently");
    Check([published[@"hostImageUUID"] length]>0,@"image UUID available for plugin event diagnostics");
    [store records:NULL];[audit flush];NSUInteger inventories=Events(auditURL,@"inventory").count;
    [store records:NULL];[audit flush];Check(Events(auditURL,@"inventory").count==inventories,@"unchanged inventory is not repeatedly persisted");
    NSMutableArray *mutable=[NSMutableArray arrayWithObject:@"before"];
    [audit record:@"snapshot-fixture" details:@{@"values":mutable} stack:NO];[mutable addObject:@"after"];[audit flush];
    Check([Events(auditURL,@"snapshot-fixture").lastObject[@"details"][@"values"] count]==1,@"queued event owns an immutable payload snapshot");

    NSURL *backupURL=[root URLByAppendingPathComponent:[backup[@"id"] stringByAppendingPathExtension:@"wcbak"]];
    NSUInteger before=hostCalls;
    Check([TestDiskUsage moveFileToTmpTrash:backupURL.path description:@"(bizUnknow)"]!=nil,@"host cleanup executes original contract");
    Check(hostCalls==before+1&&! [fm fileExistsAtPath:backupURL.path],@"auditor does not block actual host deletion");
    [audit flush];Check(Events(auditURL,@"filesystem-before").count==0&&Events(auditURL,@"blocked-native-trash").count==0,@"no deletion hooks or fabricated delete attribution");
    Check([store records:NULL].count==0,@"inventory reports independently deleted backup as absent");[audit flush];
    NSDictionary *inventory=Events(auditURL,@"inventory").lastObject[@"details"];
    Check([inventory[@"previous"][@"files"] containsObject:backupURL.lastPathComponent],@"inventory retains prior published filename as evidence");
    Check([Audit(auditURL)[@"lastPublished"][@"id"] isEqual:backup[@"id"]],@"receipt survives independently deleted backup");

    NSDictionary *next=Snapshot();Check([store publish:next error:NULL],@"publish next fixture");
    Check([store remove:next[@"id"] error:NULL],@"explicit backup deletion succeeds");[audit flush];
    Check(Events(auditURL,@"remove-requested").count==1&&Events(auditURL,@"removed").count==1,@"plugin deletion request and completion observed");
    Check([Events(auditURL,@"removed").lastObject[@"stack"] count]>0,@"plugin caller stack retained");
    Check(![store remove:next[@"id"] error:NULL],@"failed backup deletion preserves original failure result");[audit flush];
    Check(Events(auditURL,@"remove-failed").count==1,@"failed plugin delete logged without changing result");
    Check([store publish:Snapshot() error:NULL],@"directory move fixture");[store records:NULL];[audit flush];
    NSURL *moved=[work URLByAppendingPathComponent:@"moved-root" isDirectory:YES];
    Check([fm moveItemAtURL:root toURL:moved error:NULL],@"Foundation directory move is unmodified");
    Check([store records:NULL].count==0,@"store reports new empty root");[audit flush];
    inventory=Events(auditURL,@"inventory").lastObject[@"details"];
    Check(![inventory[@"directoryExistedBeforeRead"] boolValue]&&[inventory[@"previous"][@"files"] count]>0,@"passive inventory distinguishes root recreation");
    Check([fm removeItemAtURL:moved error:NULL]&&! [fm fileExistsAtPath:moved.path],@"Foundation recursive delete is unmodified");
    Check([fm fileExistsAtPath:auditURL.path],@"audit remains outside moved/deleted backup root");

    CSBackupAudit *reopened=[[CSBackupAudit alloc]initWithRoot:root auditURL:auditURL];
    [reopened record:@"process-reopened" details:@{} stack:NO];[reopened flush];
    Check([Audit(auditURL)[@"lastPublished"][@"id"] length]>0,@"publication evidence survives reopening auditor");
    for(NSUInteger i=0;i<110;i++)[reopened record:@"bounded-audit-fixture" details:@{@"n":@(i)} stack:NO];
    [reopened flush];Check([Audit(auditURL)[@"events"] count]==96,@"audit retention bounded to 96 events");
    Check([Events(auditURL,@"bounded-audit-fixture").lastObject[@"details"][@"n"] isEqual:@109],@"serial ordering retained through batching");
    [reopened record:@"oversize-fixture" details:@{@"text":[@"x" stringByPaddingToLength:1024*1024 withString:@"x" startingAtIndex:0]} stack:NO];[reopened flush];
    Check([[fm attributesOfItemAtPath:auditURL.path error:NULL][NSFileSize] unsignedIntegerValue]<=512*1024,@"one oversized event cannot exceed audit file size limit");
    Check([Events(auditURL,@"oversize-fixture").lastObject[@"details"][@"omitted"] length]>0,@"oversized detail explicitly omitted");
    Check([Audit(auditURL)[@"lastPublished"][@"id"] length]>0,@"receipt survives event size trimming");

    NSURL *blocked=[work URLByAppendingPathComponent:@"blocked-parent"];
    Check([@"not a directory" writeToURL:blocked atomically:YES encoding:NSUTF8StringEncoding error:NULL],@"audit failure fixture");
    CSBackupAudit *failed=[[CSBackupAudit alloc]initWithRoot:root auditURL:[blocked URLByAppendingPathComponent:@"audit.plist"]];
    store.eventHandler=^(NSString *event,NSDictionary *details){[failed storeEvent:event details:details];};
    NSDictionary *unaffected=Snapshot();Check([store publish:unaffected error:NULL],@"audit persistence failure cannot fail publication");
    Check([store remove:unaffected[@"id"] error:NULL],@"audit persistence failure cannot fail deletion");[failed flush];
    NSURL *target=[work URLByAppendingPathComponent:@"audit-link-target"];
    Check([@"keep" writeToURL:target atomically:YES encoding:NSUTF8StringEncoding error:NULL],@"audit symlink fixture");
    NSURL *alias=[work URLByAppendingPathComponent:@"audit-link"];
    Check([fm createSymbolicLinkAtURL:alias withDestinationURL:target error:NULL],@"audit path symlink created");
    CSBackupAudit *linked=[[CSBackupAudit alloc]initWithRoot:root auditURL:alias];[linked record:@"ignored" details:@{} stack:NO];[linked flush];
    Check([[NSString stringWithContentsOfURL:target encoding:NSUTF8StringEncoding error:NULL] isEqual:@"keep"],@"audit refuses nonregular destination without touching target");
    Check([Implementations() isEqual:implementations],@"all host and filesystem implementations still identical after every audit operation");
    [audit flush];[reopened flush];[failed flush];[linked flush];[fm removeItemAtURL:work error:NULL];
    printf("Backup passive audit: %lu checks passed\n",(unsigned long)checks);
}return 0;}
