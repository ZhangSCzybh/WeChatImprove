#import <Foundation/Foundation.h>
#import "CSBackupStore.h"
#include <sys/stat.h>
#include <unistd.h>

static NSUInteger checks;
static void Check(BOOL ok,NSString *message){checks++;if(!ok){fprintf(stderr,"FAIL: %s\n",message.UTF8String);exit(1);}}
static NSURL *Child(NSURL *root,NSString *name){return [root URLByAppendingPathComponent:name];}
static BOOL Exists(NSURL *url){struct stat st;return !lstat(url.fileSystemRepresentation,&st);}
static NSData *Bytes(NSString *value){return [value dataUsingEncoding:NSUTF8StringEncoding];}
static void Put(NSURL *url,NSData *data){Check([data writeToURL:url atomically:YES],@"write isolated file fixture");}
static NSDictionary *Snapshot(NSString *kind){
    return @{@"magic":@"WeChatImproveBackup",@"formatVersion":@2,@"id":NSUUID.UUID.UUIDString,@"name":@"deletion fixture",@"createdAt":NSDate.date,@"kind":kind,
             @"source":@{@"account":@"deletion-test",@"installationID":@"isolated",@"pluginVersion":@"test"},@"fields":@[],@"assets":@{},@"warnings":@[]};
}
static NSString *Filename(NSDictionary *snapshot){return [snapshot[@"id"] stringByAppendingPathExtension:@"wcbak"];}
static void Unchanged(NSURL *root,NSDictionary *kept,NSDictionary *before){
    for(NSString *extension in @[@"wcbak",@"meta",@"meta.bak"]){
        NSString *name=[kept[@"id"] stringByAppendingPathExtension:extension];
        Check([[NSData dataWithContentsOfURL:Child(root,name)] isEqual:before[extension]],@"other backup and sidecars remain byte-identical");
    }
}
static void Gone(NSURL *root,NSString *stem){
    for(NSString *extension in @[@"wcbak",@"meta",@"meta.bak"])
        Check(!Exists(Child(root,[stem stringByAppendingPathExtension:extension])),@"selected backup and sidecars removed");
}
int main(void){@autoreleasepool{
    NSFileManager *fm=NSFileManager.defaultManager;
    NSURL *work=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString] isDirectory:YES];
    NSURL *root=Child(work,@"backups"),*outside=Child(work,@"outside");
    Check([fm createDirectoryAtURL:outside withIntermediateDirectories:YES attributes:nil error:NULL],@"create isolated outside sentinel directory");
    CSBackupStore *store=[[CSBackupStore alloc]initWithRoot:root];NSError *error=nil;
    NSDictionary *kept=Snapshot(@"manual");Check([store publish:kept error:&error],@"publish untouched control backup");
    NSMutableDictionary *before=[NSMutableDictionary dictionary];
    for(NSString *extension in @[@"wcbak",@"meta",@"meta.bak"])
        before[extension]=[NSData dataWithContentsOfURL:Child(root,[kept[@"id"] stringByAppendingPathExtension:extension])];
    NSMutableArray *events=[NSMutableArray array];
    store.eventHandler=^(NSString *event,NSDictionary *details){[events addObject:@{@"event":event,@"details":details}];};

    // Every snapshot kind, including favorites and imported originals, supports explicit deletion.
    for(NSString *kind in @[@"manual",@"automatic",@"protection",@"upgrade",@"imported"]){
        NSDictionary *snapshot=Snapshot(kind);Check([store publish:snapshot error:&error],@"publish each backup kind");
        Check([store setMetadata:@{@"favorite":@YES} identifier:snapshot[@"id"] error:&error],@"favorite each deletion fixture");
        if([kind isEqual:@"imported"])Check([store importSnapshot:snapshot error:&error],@"mark imported original");
        if([kind isEqual:@"protection"]){
            Put(Child(root,[snapshot[@"id"] stringByAppendingPathExtension:@"meta"]),Bytes(@"broken metadata"));
            Put(Child(root,[snapshot[@"id"] stringByAppendingPathExtension:@"meta.bak"]),Bytes(@"broken mirror"));
        }
        Check([store removeFile:Filename(snapshot) error:&error],@"manual deletion does not depend on kind, favorite or metadata decode");
        Gone(root,snapshot[@"id"]);Unchanged(root,kept,before);
    }
    NSDictionary *legacyAPI=Snapshot(@"manual");Check([store publish:legacyAPI error:&error],@"publish UUID API fixture");
    Check([store remove:legacyAPI[@"id"] error:&error],@"UUID deletion API delegates successfully");Gone(root,legacyAPI[@"id"]);

    // Unreadable files remain listed and can be removed using their exact filename.
    for(NSString *name in @[[NSUUID.UUID.UUIDString stringByAppendingPathExtension:@"wcbak"],@"broken-old-backup.wcbak"]){
        Put(Child(root,name),Bytes(@"invalid snapshot bytes"));NSString *stem=name.stringByDeletingPathExtension;
        Put(Child(root,[stem stringByAppendingPathExtension:@"meta"]),Bytes(@"invalid metadata"));
        Put(Child(root,[stem stringByAppendingPathExtension:@"meta.bak"]),Bytes(@"invalid mirror"));
        NSDictionary *listed=nil;for(NSDictionary *record in [store records:NULL])if([record[@"filename"] isEqual:name])listed=record;
        Check([listed[@"unavailable"] boolValue],@"damaged UUID and non-UUID snapshots remain in inventory");
        if(![[NSUUID alloc]initWithUUIDString:stem]){error=nil;Check(![store remove:stem error:&error]&&error!=nil,@"UUID API stays strict for non-UUID identifiers");}
        Check([store removeFile:name error:&error],@"damaged UUID and non-UUID files can be removed");Gone(root,stem);Unchanged(root,kept,before);
    }
    NSDictionary *renamed=Snapshot(@"manual");Check([store publish:renamed error:&error],@"publish renamed fixture");
    NSString *renamedFile=@"my renamed backup.wcbak";
    Check([fm moveItemAtURL:Child(root,Filename(renamed)) toURL:Child(root,renamedFile) error:&error],@"rename real backup without altering its manifest");
    NSData *oldMetadata=[NSData dataWithContentsOfURL:Child(root,[renamed[@"id"] stringByAppendingPathExtension:@"meta"])];
    Check([store removeFile:renamedFile error:&error]&&!Exists(Child(root,renamedFile)),@"filename deletion removes a renamed manifest");
    Check([[NSData dataWithContentsOfURL:Child(root,[renamed[@"id"] stringByAppendingPathExtension:@"meta"])] isEqual:oldMetadata],@"renamed file does not claim sidecars of another stem");

    NSURL *sentinel=Child(outside,@"keep.wcbak");NSData *sentinelBytes=Bytes(@"outside data must survive");Put(sentinel,sentinelBytes);
    NSString *nul=[@"keep" stringByAppendingFormat:@"%C.wcbak",(unichar)0];
    for(NSString *name in @[@"../outside/keep.wcbak",sentinel.path,@"sub/keep.wcbak",@"keep.wcbak/",@"keep.meta",@"",@".",@"..",nul]){
        error=nil;Check(![store removeFile:name error:&error]&&error!=nil,@"invalid or escaping filenames rejected");
        Check([[NSData dataWithContentsOfURL:sentinel] isEqual:sentinelBytes],@"invalid requests leave outside bytes unchanged");
    }
    error=nil;Check(![store remove:@"../outside/keep" error:&error]&&error!=nil,@"UUID API still rejects traversal");

    // unlinkat removes only the link, including dangling links and metadata links.
    NSString *linked=@"linked.wcbak";Check([fm createSymbolicLinkAtURL:Child(root,linked) withDestinationURL:sentinel error:&error],@"create backup symlink fixture");
    for(NSString *extension in @[@"meta",@"meta.bak"])
        Check([fm createSymbolicLinkAtURL:Child(root,[@"linked" stringByAppendingPathExtension:extension]) withDestinationURL:sentinel error:&error],@"create sidecar symlink fixture");
    Check([store removeFile:linked error:&error],@"manual deletion unlinks selected symlink");Gone(root,@"linked");
    Check([[NSData dataWithContentsOfURL:sentinel] isEqual:sentinelBytes],@"backup and sidecar links never delete their target");
    Check([fm createSymbolicLinkAtURL:Child(root,@"dangling.wcbak") withDestinationURL:Child(outside,@"missing") error:&error],@"create dangling backup link");
    Check([store removeFile:@"dangling.wcbak" error:&error]&&!Exists(Child(root,@"dangling.wcbak")),@"dangling backup link can be removed");
    NSURL *directory=Child(root,@"folder.wcbak");Check([fm createDirectoryAtURL:directory withIntermediateDirectories:NO attributes:nil error:&error],@"create directory-shaped backup fixture");
    Put(Child(directory,@"keep.txt"),sentinelBytes);error=nil;
    Check(![store removeFile:directory.lastPathComponent error:&error]&&error!=nil,@"directory with backup extension is never recursively removed");
    Check([[NSData dataWithContentsOfURL:Child(directory,@"keep.txt")] isEqual:sentinelBytes],@"directory contents survive rejected deletion");
    NSURL *alias=Child(work,@"alias");Check([fm createSymbolicLinkAtURL:alias withDestinationURL:outside error:&error],@"create symbolic backup root fixture");
    CSBackupStore *aliased=[[CSBackupStore alloc]initWithRoot:alias];error=nil;
    Check(![aliased removeFile:@"keep.wcbak" error:&error]&&error!=nil,@"symbolic backup root is rejected");
    Check([[NSData dataWithContentsOfURL:sentinel] isEqual:sentinelBytes],@"symbolic root cannot remove outside bytes");

    // Recovery sources stay protected, including differently cased UUID references.
    NSDictionary *source=Snapshot(@"manual"),*protection=Snapshot(@"protection");
    Check([store publish:source error:&error]&&[store publish:protection error:&error],@"publish active transaction sources");
    Check([store writeJournal:@{@"state":@"prepared",@"sourceID":[source[@"id"] lowercaseString],@"protectionID":[protection[@"id"] lowercaseString]} error:&error],@"publish active references with UUID case aliases");
    for(NSDictionary *snapshot in @[source,protection]){
        error=nil;Check(![store removeFile:Filename(snapshot) error:&error]&&error!=nil,@"active recovery source or protection cannot be deleted by filename");
        error=nil;Check(![store remove:snapshot[@"id"] error:&error]&&error!=nil,@"UUID API also respects canonical active references");
        Check(Exists(Child(root,Filename(snapshot))),@"blocked active backup stays present");
    }
    Check([store archiveJournal:&error],@"archive isolated active journal");
    Put(Child(root,@"transaction.plist"),Bytes(@"corrupt transaction"));error=nil;
    Check(![store removeFile:Filename(source) error:&error]&&error!=nil,@"corrupt recovery journal blocks filename deletion");
    Check(Exists(Child(root,Filename(source))),@"journal failure preserves original backup");
    Check([fm removeItemAtURL:Child(root,@"transaction.plist") error:&error],@"repair only isolated corrupt journal fixture");
    Check([store removeFile:Filename(source) error:&error]&&[store removeFile:Filename(protection) error:&error],@"released transaction backups become deletable");
    error=nil;Check(![store removeFile:@"missing.wcbak" error:&error]&&error!=nil,@"missing target reports deletion failure");

    NSUInteger requested=0,removed=0,failed=0;BOOL sawNonUUID=NO;
    for(NSDictionary *event in events){
        NSString *name=event[@"event"];
        if([name isEqual:@"remove-requested"])requested++;
        if([name isEqual:@"removed"]){removed++;if([event[@"details"][@"filename"] isEqual:@"broken-old-backup.wcbak"])sawNonUUID=YES;}
        if([name isEqual:@"remove-failed"])failed++;
    }
    Check(removed>0&&failed==2&&requested==removed+failed&&sawNonUUID,@"manual deletion retains requested/success/failure audit events and exact filename");
    Unchanged(root,kept,before);Check([[NSData dataWithContentsOfURL:sentinel] isEqual:sentinelBytes],@"all deletion cases preserve outside sentinel");
    Check([fm removeItemAtURL:work error:NULL],@"remove isolated deletion fixtures");
    printf("Backup deletion: %lu checks passed (all five kinds, unavailable/renamed files, recovery guards and confined unlink)\n",(unsigned long)checks);
}return 0;}
