#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <sys/stat.h>
#import <fcntl.h>
#import "CSBackupEngine.h"
#import "CSBackupCodec.h"
#import "CSBackupAssets.h"
#import "CSPluginStorage.h"
static NSUInteger checks,imageCalls;
static IMP imageOriginal;
static void (^imageAction)(void);
static void Check(BOOL ok,NSString *message){checks++;if(!ok){fprintf(stderr,"FAIL: %s\n",message.UTF8String);exit(1);}}
@interface CountingBackupStore:CSBackupStore
@property(nonatomic) NSUInteger reads;
@property(nonatomic) BOOL failPublish;
@end
@implementation CountingBackupStore
- (NSDictionary *)snapshot:(NSString *)identifier error:(NSError **)error {self.reads++;return [super snapshot:identifier error:error];}
- (BOOL)publish:(NSDictionary *)snapshot error:(NSError **)error {if(self.failPublish){if(error)*error=CSBackupFailure(@"isolated publish failure");return NO;}return [super publish:snapshot error:error];}
@end
static NSDictionary *Snapshot(NSString *kind,NSTimeInterval time){
    return @{@"magic":@"WeChatImproveBackup",@"formatVersion":@2,@"id":NSUUID.UUID.UUIDString,@"name":@"fixture",@"createdAt":[NSDate dateWithTimeIntervalSince1970:time],@"kind":kind,@"source":@{@"account":@"audit",@"installationID":@"audit",@"pluginVersion":@"test"},@"fields":@[],@"assets":@{},@"warnings":@[]};
}
static NSURL *File(CSBackupStore *store,NSDictionary *s){return [store.root URLByAppendingPathComponent:[s[@"id"] stringByAppendingPathExtension:@"wcbak"]];}
static NSDictionary *Record(NSArray *records,NSString *identifier){for(NSDictionary *r in records)if([r[@"id"] isEqual:identifier])return r;return nil;}
static void Counts(NSURL *base,NSUInteger manualCount){
    NSString *suite=[@"backup.performance." stringByAppendingString:NSUUID.UUID.UUIDString];
    NSUserDefaults *defaults=[[NSUserDefaults alloc]initWithSuiteName:suite];
    CountingBackupStore *store=[[CountingBackupStore alloc]initWithRoot:[base URLByAppendingPathComponent:[NSString stringWithFormat:@"count-%lu",(unsigned long)manualCount]]];
    CSBackupEngine *engine=[[CSBackupEngine alloc]initWithDefaults:@{@"standard":defaults,@"legacy":defaults,@"layout":defaults} domains:@{@"standard":suite,@"legacy":suite,@"layout":suite} store:store resources:[base URLByAppendingPathComponent:@"resources"]];
    __block NSString *account=@"audit",*installation=@"audit";
    engine.context=^{return @{@"account":account,@"epoch":@1,@"installationID":installation,@"pluginVersion":@"test"};};
    NSString *key=@"com.wechat.tweak.navigation.separator.text";[defaults setObject:@"same" forKey:key];
    for(NSUInteger n=0;n<manualCount;n++)Check([store publish:Snapshot(@"manual",n+1) error:NULL],@"seed manual history");
    store.reads=0;NSDictionary *original=[engine save:@"first" error:NULL];
    Check(original&&store.reads==0,@"manual save publishes without scanning historical snapshots");
    store.reads=0;NSDictionary *same=[engine save:@"same" error:NULL];NSUInteger unchanged=store.reads;
    Check(same&&![same[@"id"] isEqual:original[@"id"]],@"unchanged manual save creates the requested snapshot");
    Check(unchanged==0,@"unchanged manual save does not read historical snapshots");
    [defaults setObject:@"changed" forKey:key];store.reads=0;
    NSDictionary *changed=[engine save:@"changed" error:NULL];NSUInteger changedReads=store.reads;
    Check(changed&&![changed[@"id"] isEqual:original[@"id"]],@"changed manual save publishes");
    Check(changedReads==0,@"changed manual save does not scan historical snapshots");
    account=@"other";NSDictionary *otherAccount=[engine save:@"other account" error:NULL];
    Check([otherAccount[@"source"][@"account"] isEqual:account],@"manual save records the current account");
    account=@"audit";installation=@"other";NSDictionary *otherInstall=[engine save:@"other install" error:NULL];
    Check([otherInstall[@"source"][@"installationID"] isEqual:installation],@"manual save records the current installation");
    store.failPublish=YES;[defaults setObject:@"failed" forKey:key];NSError *failure=nil;store.reads=0;
    Check(![engine save:@"failure" error:&failure]&&failure&&store.reads==0,@"publication failure propagates without scanning history");
    store.reads=0;NSArray *records=[store records:NULL];
    Check(records.count==manualCount+5&&store.reads==records.count,@"manual inventory reads each historical file once and retains every requested snapshot");
    printf("Manual history N=%lu: unchanged save reads %lu; changed save reads %lu; inventory reads %lu for %lu records\n",(unsigned long)manualCount,(unsigned long)unchanged,(unsigned long)changedReads,(unsigned long)store.reads,(unsigned long)records.count);
    [defaults removePersistentDomainForName:suite];
}
static void InventoryBoundaries(NSURL *base){
    CountingBackupStore *store=[[CountingBackupStore alloc]initWithRoot:[base URLByAppendingPathComponent:@"identity"]];
    NSDictionary *s=Snapshot(@"manual",1);Check([store publish:s error:NULL],@"identity fixture");
    Check([store records:NULL].count==1&&store.reads==1,@"initial inventory reads its snapshot once");
    NSUInteger reads=store.reads;[store records:NULL];Check(store.reads==reads+1,@"independent inventory reads revalidate their snapshots");
    NSMutableDictionary *replacement=[s mutableCopy];replacement[@"name"]=@"changed";
    NSData *bytes=[CSBackupCodec encode:replacement error:NULL];Check(CSBackupAtomicWrite(bytes,File(store,s),NULL),@"replace same filename");
    reads=store.reads;
    Check([Record([store records:NULL],s[@"id"])[@"name"] isEqual:@"changed"]&&store.reads==reads+1,@"next inventory reads the replacement once");
    NSDictionary *selected=[store snapshot:s[@"id"] error:NULL];Check([selected[@"name"] isEqual:@"changed"],@"selected snapshot reads the current replacement");
    NSData *broken=[@"broken!" dataUsingEncoding:NSUTF8StringEncoding];Check(CSBackupAtomicWrite(broken,File(store,s),NULL),@"corrupt existing snapshot");
    Check([Record([store records:NULL],s[@"id"])[@"unavailable"] boolValue]&&[NSFileManager.defaultManager fileExistsAtPath:File(store,s).path],@"corruption is retained as an unavailable original");
    NSDictionary *added=Snapshot(@"manual",2);Check([store publish:added error:NULL],@"publish another snapshot");
    Check([store records:NULL].count==2,@"new file is discovered");
    Check([NSFileManager.defaultManager removeItemAtURL:File(store,added) error:NULL],@"external file deletion");
    Check([store records:NULL].count==1,@"removed file disappears from the next inventory");

    // Exact same byte length and preserved mtime still change inode/ctime.
    Check(CSBackupAtomicWrite([CSBackupCodec encode:s error:NULL],File(store,s),NULL),@"repair identity fixture");
    [store records:NULL];NSUInteger before=store.reads;
    NSData *old=[NSData dataWithContentsOfURL:File(store,s)],*new=[CSBackupCodec encode:replacement error:NULL];
    Check(old.length==new.length,@"same-length replacement fixture");
    struct stat st;Check(!stat(File(store,s).fileSystemRepresentation,&st),@"read original timestamp");
    Check(CSBackupAtomicWrite(new,File(store,s),NULL),@"same-size replace");
    struct timespec times[2]={st.st_atimespec,st.st_mtimespec};Check(!utimensat(AT_FDCWD,File(store,s).fileSystemRepresentation,times,0),@"restore original mtime");
    struct stat replaced;Check(!stat(File(store,s).fileSystemRepresentation,&replaced)&&replaced.st_ino!=st.st_ino&&replaced.st_size==st.st_size&&
        replaced.st_mtimespec.tv_sec==st.st_mtimespec.tv_sec&&replaced.st_mtimespec.tv_nsec==st.st_mtimespec.tv_nsec,@"replacement changes inode while preserving size and mtime");
    Check([Record([store records:NULL],s[@"id"])[@"name"] isEqual:@"changed"]&&store.reads==before+1,@"same-size same-mtime replacement is read on the next inventory");
    // Each inventory retries migration, including late reappearance of a legacy root.
    NSURL *library=[base URLByAppendingPathComponent:@"migration/Library"];
    Check([NSFileManager.defaultManager createDirectoryAtURL:library withIntermediateDirectories:YES attributes:nil error:NULL],@"isolated migration library");
    CSPluginDirectoryMigration *migration=[[CSPluginDirectoryMigration alloc]initWithLibrary:library leaf:@"BackupV2"];
    CountingBackupStore *moving=[[CountingBackupStore alloc]initWithMigration:migration];
    NSDictionary *first=Snapshot(@"manual",1);Check([moving publish:first error:NULL],@"migration seed");
    Check([moving records:NULL].count==1,@"initial migrated inventory");
    CSBackupStore *legacy=[[CSBackupStore alloc]initWithRoot:migration.legacyRoot];
    NSDictionary *late=Snapshot(@"manual",2);Check([legacy publish:late error:NULL],@"late legacy fixture");
    Check([moving records:NULL].count==2&&![NSFileManager.defaultManager fileExistsAtPath:migration.legacyRoot.path],@"next inventory discovers and migrates late legacy files");
}
static void Images(NSURL *base){
    NSData *png=[[NSData alloc]initWithBase64EncodedString:@"iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMCAO+aWZcAAAAASUVORK5CYII=" options:0];
    NSString *hash=[CSBackupCodec digest:png],*reference=[@"csbackup:" stringByAppendingString:hash];
    for(NSNumber *count in @[@1,@20,@100]){
        NSMutableDictionary *contacts=[NSMutableDictionary dictionary];for(NSUInteger n=0;n<count.unsignedIntegerValue;n++)contacts[[NSString stringWithFormat:@"user%lu",(unsigned long)n]]=@{@"enabled":@YES,@"separatorImagePath":reference};
        NSArray *fields=@[@{@"domain":@"standard",@"key":@"com.wechat.tweak.navigation.contact.overrides",@"present":@YES,@"value":contacts}];
        NSMutableDictionary *s=[Snapshot(@"manual",1) mutableCopy];s[@"fields"]=fields;s[@"assets"]=@{hash:png};imageCalls=0;
        NSData *encoded=[CSBackupCodec encode:s error:NULL];Check(encoded&&imageCalls==1,@"encode verifies each unique shared image once");
        printf("Shared image R=%lu: encode validImage calls %lu -> %lu\n",(unsigned long)count.unsignedIntegerValue,(unsigned long)(count.unsignedIntegerValue+1),(unsigned long)imageCalls);
        imageCalls=0;Check([CSBackupCodec decode:encoded error:NULL]&&imageCalls==1,@"independent decode revalidates each image once");
        imageCalls=0;NSMutableDictionary *writes=[NSMutableDictionary dictionary];
        Check([CSBackupAssets materializeFields:fields assets:s[@"assets"] root:[NSURL fileURLWithPath:@"/isolated"] writes:writes error:NULL]&&imageCalls==1&&writes.count==count.unsignedIntegerValue,@"independent materialize verifies once and retains every owned output");
    }
    NSArray *fields=@[@{@"domain":@"standard",@"key":@"com.wechat.tweak.navigation.separator.image",@"present":@YES,@"value":reference}];
    NSMutableData *mutable=[png mutableCopy];NSMutableDictionary *snapshot=[Snapshot(@"manual",1) mutableCopy];snapshot[@"fields"]=fields;snapshot[@"assets"]=@{hash:mutable};
    imageAction=^{[mutable setLength:0];};NSData *encoded=[CSBackupCodec encode:snapshot error:NULL];imageAction=nil;
    Check(encoded&&[CSBackupCodec decode:encoded error:NULL],@"encode seals the immutable bytes actually validated despite mutable source mutation");
    Check(![CSBackupAssets materializeFields:fields assets:snapshot[@"assets"] root:[NSURL fileURLWithPath:@"/isolated"] writes:[NSMutableDictionary dictionary] error:NULL],@"later materialize revalidates changed bytes");
    for(NSDictionary *assets in @[@{},@{hash:[@"bad" dataUsingEncoding:NSUTF8StringEncoding]},@{[@"x" stringByPaddingToLength:64 withString:@"x" startingAtIndex:0]:png}])
        Check(![CSBackupAssets materializeFields:fields assets:assets root:[NSURL fileURLWithPath:@"/isolated"] writes:[NSMutableDictionary dictionary] error:NULL],@"missing corrupt or mismatched resource rejected");
    NSMutableDictionary *bad=[fields[0] mutableCopy];bad[@"value"]=@"csbackup:../invalid";
    Check(![CSBackupAssets materializeFields:@[bad] assets:@{hash:png} root:[NSURL fileURLWithPath:@"/isolated"] writes:[NSMutableDictionary dictionary] error:NULL],@"each reference syntax still checked");
    NSMutableDictionary *writes=[@{@"separator_image.png":@{@"present":@YES,@"data":[@"other" dataUsingEncoding:NSUTF8StringEncoding]}} mutableCopy];
    Check(![CSBackupAssets materializeFields:fields assets:@{hash:png} root:[NSURL fileURLWithPath:@"/isolated"] writes:writes error:NULL],@"fixed destination collisions remain rejected");
    NSMutableData *other=[png mutableCopy];[other appendBytes:"x" length:1];Check([CSBackupAssets validImage:other],@"second valid image fixture");
    NSMutableDictionary *two=[Snapshot(@"manual",1) mutableCopy];two[@"assets"]=@{hash:png,[CSBackupCodec digest:other]:other};imageCalls=0;
    Check([CSBackupCodec encode:two error:NULL]&&imageCalls==2,@"each unique image validated including unreferenced assets");
    two[@"assets"]=@{hash:png,[CSBackupCodec digest:@"broken"]:[@"broken" dataUsingEncoding:NSUTF8StringEncoding]};
    Check(![CSBackupCodec encode:two error:NULL],@"corrupt unreferenced image still rejected");
    NSURL *mappedURL=[base URLByAppendingPathComponent:@"mapped.png"];Check(CSBackupAtomicWrite(png,mappedURL,NULL),@"mapped image fixture");
    NSData *mapped=[NSData dataWithContentsOfURL:mappedURL options:NSDataReadingMappedAlways error:NULL];
    NSDictionary *frozen=[CSBackupAssets immutableAssets:@{hash:mapped} error:NULL];
    NSMutableData *modified=[png mutableCopy];((uint8_t *)modified.mutableBytes)[modified.length-1]^=1;
    Check([modified writeToURL:mappedURL options:0 error:NULL],@"mutate mapped backing file in place");
    Check([frozen[hash] isEqual:png],@"resource freezing owns bytes independently of mapped backing file");

    // Keep the two independent capture reads: an atomically changing external
    // image must exhaust the existing retry guard rather than publish mixed bytes.
    NSString *suite=[@"backup.performance.capture." stringByAppendingString:NSUUID.UUID.UUIDString];NSUserDefaults *defaults=[[NSUserDefaults alloc]initWithSuiteName:suite];
    NSURL *resources=[base URLByAppendingPathComponent:@"capture/resources"],*image=[resources URLByAppendingPathComponent:@"changing.png"];
    Check(CSBackupAtomicWrite(png,image,NULL),@"capture external image fixture");
    [defaults setObject:image.path forKey:@"com.wechat.tweak.navigation.separator.image"];
    CSBackupEngine *engine=[[CSBackupEngine alloc]initWithDefaults:@{@"standard":defaults,@"legacy":defaults,@"layout":defaults} domains:@{@"standard":suite,@"legacy":suite,@"layout":suite} store:[[CSBackupStore alloc]initWithRoot:[base URLByAppendingPathComponent:@"capture/backups"]] resources:resources];
    engine.context=^{return @{@"account":@"audit",@"epoch":@1,@"installationID":@"audit",@"pluginVersion":@"test"};};
    __block BOOL alternate=NO;imageCalls=0;
    imageAction=^{alternate=!alternate;Check(CSBackupAtomicWrite(alternate?other:png,image,NULL),@"change external image between independent capture reads");};
    NSError *failure=nil;NSDictionary *captured=[engine capture:@"changing" kind:@"manual" error:&failure];imageAction=nil;
    Check(!captured&&failure&&imageCalls==6,@"all three double-capture attempts detect changing file bytes");
    [defaults removePersistentDomainForName:suite];
}
int main(void){@autoreleasepool{
    printf("Manual backup performance: current production methods, forwarded by counters.\n");
    Method imageMethod=class_getClassMethod(CSBackupAssets.class,@selector(validImage:));
    imageOriginal=method_getImplementation(imageMethod);
    method_setImplementation(imageMethod,imp_implementationWithBlock(^BOOL(id owner,NSData *data){imageCalls++;if(imageAction)imageAction();return ((BOOL(*)(id,SEL,id))imageOriginal)(owner,@selector(validImage:),data);}));
    NSURL *base=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString]];
    for(NSNumber *n in @[@0,@20,@80])Counts(base,n.unsignedIntegerValue);
    InventoryBoundaries(base);Images(base);
    Check([NSFileManager.defaultManager removeItemAtURL:base error:NULL],@"remove isolated fixtures");
    method_setImplementation(imageMethod,imageOriginal);
    printf("Backup performance: %lu checks passed\n",(unsigned long)checks);
}return 0;}
