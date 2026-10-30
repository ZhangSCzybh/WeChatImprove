#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <sys/stat.h>
#import <fcntl.h>
#import "CSBackupEngine.h"
#import "CSBackupCodec.h"
#import "CSBackupAssets.h"
#import "CSPluginStorage.h"
static NSUInteger checks,imageCalls,digestCalls;
static IMP imageOriginal,digestOriginal;
static void (^imageAction)(void);
static void Check(BOOL ok,NSString *message){checks++;if(!ok){fprintf(stderr,"FAIL: %s\n",message.UTF8String);exit(1);}}
@interface CountingBackupStore:CSBackupStore
@property(nonatomic) NSUInteger reads;
@property(nonatomic) NSUInteger prunes;
@property(nonatomic) BOOL failPublish;
@end
@implementation CountingBackupStore
- (NSDictionary *)snapshot:(NSString *)identifier error:(NSError **)error {self.reads++;return [super snapshot:identifier error:error];}
- (BOOL)publish:(NSDictionary *)snapshot error:(NSError **)error {if(self.failPublish){if(error)*error=CSBackupFailure(@"isolated publish failure");return NO;}return [super publish:snapshot error:error];}
- (BOOL)prune:(NSError **)error {self.prunes++;return [super prune:error];}
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
    NSDictionary *original=[engine save:@"first" kind:@"automatic" error:NULL];Check(original!=nil,@"seed automatic");
    for(NSUInteger n=0;n<manualCount;n++)Check([store publish:Snapshot(@"manual",n+1) error:NULL],@"seed manual history");
    store.reads=0;NSDictionary *same=[engine save:@"same" kind:@"automatic" error:NULL];NSUInteger unchanged=store.reads;
    Check([same[@"id"] isEqual:original[@"id"]],@"unchanged automatic remains deduplicated");
    if(unchanged!=manualCount+1)fprintf(stderr,"count diagnostic: N=%lu unchanged=%lu\n",(unsigned long)manualCount,(unsigned long)unchanged);
    Check(unchanged==manualCount+1,@"unchanged save reads each historical file once");
    [defaults setObject:@"changed" forKey:key];store.reads=0;
    NSDictionary *changed=[engine save:@"changed" kind:@"automatic" error:NULL];NSUInteger changedReads=store.reads;
    Check(changed&&! [changed[@"id"] isEqual:original[@"id"]],@"changed automatic publishes");
    Check(changedReads==manualCount+2,@"prune reuses history and verifies newly published file once");
    printf("Inventory N=%lu: unchanged snapshot reads %lu -> %lu; changed+prune %lu -> %lu\n",(unsigned long)manualCount,(unsigned long)(manualCount+2),(unsigned long)unchanged,(unsigned long)(2*manualCount+3),(unsigned long)changedReads);
    account=@"other";Check(![[engine save:@"other account" kind:@"automatic" error:NULL][@"id"] isEqual:changed[@"id"]],@"account changes do not deduplicate");
    account=@"audit";installation=@"other";Check(![[engine save:@"other install" kind:@"automatic" error:NULL][@"id"] isEqual:changed[@"id"]],@"installation changes do not deduplicate");
    NSUInteger prunes=store.prunes;store.failPublish=YES;[defaults setObject:@"failed" forKey:key];NSError *failure=nil;
    Check(![engine save:@"failure" kind:@"automatic" error:&failure]&&failure&&store.prunes==prunes,@"publication failure propagates and never prunes");
    [defaults removePersistentDomainForName:suite];
}
static void InventoryBoundaries(NSURL *base){
    CountingBackupStore *store=[[CountingBackupStore alloc]initWithRoot:[base URLByAppendingPathComponent:@"identity"]];
    NSDictionary *s=Snapshot(@"automatic",1);Check([store publish:s error:NULL],@"identity fixture");
    [store withInventoryForSource:s[@"source"] operation:^NSDictionary *{
        [store records:NULL];NSUInteger reads=store.reads;[store records:NULL];Check(store.reads==reads,@"unchanged scope reuses summaries");
        NSMutableDictionary *replacement=[s mutableCopy];replacement[@"name"]=@"changed";
        NSData *bytes=[CSBackupCodec encode:replacement error:NULL];Check(CSBackupAtomicWrite(bytes,File(store,s),NULL),@"replace same filename during scope");
        Check([Record([store records:NULL],s[@"id"])[@"name"] isEqual:@"changed"]&&store.reads==reads+1,@"replacement is reread inside scope");
        NSDictionary *cached=[store snapshotUsingInventory:s[@"id"] error:NULL];Check([cached[@"name"] isEqual:@"changed"],@"dedup return uses current replacement");
        NSData *broken=[@"broken!" dataUsingEncoding:NSUTF8StringEncoding];Check(CSBackupAtomicWrite(broken,File(store,s),NULL),@"corrupt inside scope");
        Check([Record([store records:NULL],s[@"id"])[@"unavailable"] boolValue],@"scope corruption is retained as unavailable");
        NSDictionary *added=Snapshot(@"manual",2);Check([store publish:added error:NULL],@"publish during scope");
        Check([store records:NULL].count==2,@"new scope file is discovered");
        Check([NSFileManager.defaultManager removeItemAtURL:File(store,added) error:NULL],@"external deletion during scope");
        Check([store records:NULL].count==1,@"removed scope file disappears");return nil;
    }];
    NSUInteger reads=store.reads;[store records:NULL];Check(store.reads==reads+1,@"scope completion drops cache");
    @try{[store withInventoryForSource:s[@"source"] operation:^NSDictionary *{[store records:NULL];@throw [NSException exceptionWithName:@"fixture" reason:@"scope unwind" userInfo:nil];}];}
    @catch(NSException *exception){Check([exception.name isEqual:@"fixture"],@"scope exception propagated");}
    reads=store.reads;[store records:NULL];Check(store.reads==reads+1,@"finally drops cache after exception");

    // Exact same byte length and preserved mtime still change inode/ctime.
    Check(CSBackupAtomicWrite([CSBackupCodec encode:s error:NULL],File(store,s),NULL),@"repair identity fixture");
    [store withInventoryForSource:s[@"source"] operation:^NSDictionary *{
        [store records:NULL];NSUInteger before=store.reads;
        NSMutableDictionary *replacement=[s mutableCopy];replacement[@"name"]=@"changed";
        NSData *old=[NSData dataWithContentsOfURL:File(store,s)],*new=[CSBackupCodec encode:replacement error:NULL];
        Check(old.length==new.length,@"same-length replacement fixture");
        struct stat st;Check(!stat(File(store,s).fileSystemRepresentation,&st),@"read original timestamp");
        Check(CSBackupAtomicWrite(new,File(store,s),NULL),@"same-size replace");
        struct timespec times[2]={st.st_atimespec,st.st_mtimespec};Check(!utimensat(AT_FDCWD,File(store,s).fileSystemRepresentation,times,0),@"restore original mtime");
        Check([Record([store records:NULL],s[@"id"])[@"name"] isEqual:@"changed"]&&store.reads==before+1,@"inode and ctime invalidate same-size same-mtime replacement");return nil;
    }];
    // Migration is retried before reuse, including late reappearance of a legacy root.
    NSURL *library=[base URLByAppendingPathComponent:@"migration/Library"];
    Check([NSFileManager.defaultManager createDirectoryAtURL:library withIntermediateDirectories:YES attributes:nil error:NULL],@"isolated migration library");
    CSPluginDirectoryMigration *migration=[[CSPluginDirectoryMigration alloc]initWithLibrary:library leaf:@"BackupV2"];
    CountingBackupStore *moving=[[CountingBackupStore alloc]initWithMigration:migration];
    NSDictionary *first=Snapshot(@"automatic",1);Check([moving publish:first error:NULL],@"migration scoped seed");
    [moving withInventoryForSource:first[@"source"] operation:^NSDictionary *{
        [moving records:NULL];CSBackupStore *legacy=[[CSBackupStore alloc]initWithRoot:migration.legacyRoot];
        NSDictionary *late=Snapshot(@"manual",2);Check([legacy publish:late error:NULL],@"late legacy scoped fixture");
        Check([moving records:NULL].count==2&&![NSFileManager.defaultManager fileExistsAtPath:migration.legacyRoot.path],@"late migration files discovered before scope reuse");return nil;
    }];
}
static void RetentionBoundaries(NSURL *base){
    for(NSString *change in @[@"favorite",@"imported",@"journal",@"bad-journal",@"bad-metadata",@"replace",@"inplace"]){
        CountingBackupStore *store=[[CountingBackupStore alloc]initWithRoot:[base URLByAppendingPathComponent:change]];
        NSDictionary *old=Snapshot(@"automatic",1);Check([store publish:old error:NULL],@"retention target");
        for(NSUInteger n=0;n<20;n++)Check([store publish:Snapshot(@"automatic",n+10) error:NULL],@"retention newer fixture");
        __block BOOL fired=NO;__weak CSBackupStore *weak=store;
        store.eventHandler=^(NSString *event,NSDictionary *details){
            if(fired||![event isEqual:@"remove-requested"]||![details[@"id"] isEqual:old[@"id"]])return;fired=YES;
            CSBackupStore *strong=weak;
            if([change isEqual:@"favorite"])Check([strong setMetadata:@{@"favorite":@YES} identifier:old[@"id"] error:NULL],@"late favorite");
            else if([change isEqual:@"imported"])Check([strong importSnapshot:old error:NULL],@"late imported protection");
            else if([change isEqual:@"journal"])Check([strong writeJournal:@{@"sourceID":old[@"id"]} error:NULL],@"late active transaction");
            else if([change isEqual:@"bad-journal"])Check(CSBackupAtomicWrite([@"bad" dataUsingEncoding:NSUTF8StringEncoding],[strong.root URLByAppendingPathComponent:@"transaction.plist"],NULL),@"late journal corruption");
            else if([change isEqual:@"bad-metadata"])Check(CSBackupAtomicWrite([@"bad" dataUsingEncoding:NSUTF8StringEncoding],[strong.root URLByAppendingPathComponent:[old[@"id"] stringByAppendingPathExtension:@"meta"]],NULL),@"late metadata corruption");
            else {NSMutableDictionary *replacement=[old mutableCopy];replacement[@"kind"]=@"manual";NSData *data=[CSBackupCodec encode:replacement error:NULL];
                if([change isEqual:@"inplace"])Check([data writeToURL:File(strong,old) options:0 error:NULL],@"late in-place file mutation");
                else Check(CSBackupAtomicWrite(data,File(strong,old),NULL),@"late replacement");}
        };
        [store withInventoryForSource:old[@"source"] operation:^NSDictionary *{[store records:NULL];[store prune:NULL];return nil;}];
        Check(fired&&[NSFileManager.defaultManager fileExistsAtPath:File(store,old).path],[@"delete-time protection: " stringByAppendingString:change]);
        store.eventHandler=nil;
    }
    CSBackupStore *store=[[CSBackupStore alloc]initWithRoot:[base URLByAppendingPathComponent:@"digest"]];
    Check([store publish:Snapshot(@"automatic",1) error:NULL],@"digest fixture");digestCalls=0;
    Check([store prune:NULL]&&digestCalls==0,@"standalone prune avoids unused content digests");
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
    printf("Before counts: recorded baseline in performance-followup-2.1-15.md; after counts: current production methods, forwarded by counters.\n");
    Method imageMethod=class_getClassMethod(CSBackupAssets.class,@selector(validImage:));
    imageOriginal=method_getImplementation(imageMethod);
    method_setImplementation(imageMethod,imp_implementationWithBlock(^BOOL(id owner,NSData *data){imageCalls++;if(imageAction)imageAction();return ((BOOL(*)(id,SEL,id))imageOriginal)(owner,@selector(validImage:),data);}));
    Method digestMethod=class_getClassMethod(CSBackupCodec.class,@selector(digest:));digestOriginal=method_getImplementation(digestMethod);
    method_setImplementation(digestMethod,imp_implementationWithBlock(^NSString *(id owner,id value){if([value isKindOfClass:NSDictionary.class]&&[value count]==2&&value[@"fields"]&&value[@"assets"])digestCalls++;return ((id(*)(id,SEL,id))digestOriginal)(owner,@selector(digest:),value);}));
    NSURL *base=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString]];
    for(NSNumber *n in @[@0,@20,@80])Counts(base,n.unsignedIntegerValue);
    InventoryBoundaries(base);RetentionBoundaries(base);Images(base);
    Check([NSFileManager.defaultManager removeItemAtURL:base error:NULL],@"remove isolated fixtures");
    method_setImplementation(imageMethod,imageOriginal);method_setImplementation(digestMethod,digestOriginal);
    printf("Backup performance: %lu checks passed\n",(unsigned long)checks);
}return 0;}
