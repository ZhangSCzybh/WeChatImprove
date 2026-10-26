#import <Foundation/Foundation.h>
#import "CSBackupEngine.h"
#import "CSBackupCodec.h"
#import "CSBackupRegistry.h"
#import "CSBackupAudit.h"
#import "CSPluginStorage.h"
#import "CSBackupRestoreDiagnostics.h"
#include <unistd.h>
static NSUInteger checks;
static NSString *const TextKey=@"com.wechat.tweak.navigation.separator.text";
static NSString *const ImageKey=@"com.wechat.tweak.navigation.separator.image";
static void Check(BOOL ok,NSString *message){checks++;if(!ok){fprintf(stderr,"FAIL: %s\n",message.UTF8String);exit(1);}}
static CSBackupEngine *Engine(NSString *path,NSString *suite,NSString *account,NSString *version,BOOL legacyResources){
    NSURL *library=[NSURL fileURLWithPath:[path stringByAppendingPathComponent:@"Library"]];
    [NSFileManager.defaultManager createDirectoryAtURL:library withIntermediateDirectories:YES attributes:nil error:NULL];
    CSPluginDirectoryMigration *migration=[[CSPluginDirectoryMigration alloc]initWithLibrary:library leaf:@"BackupV2"];
    NSUserDefaults *defaults=[[NSUserDefaults alloc]initWithSuiteName:suite];
    NSURL *resources=[library URLByAppendingPathComponent:legacyResources?@"Application Support/WeChatImprove":@"Preferences/WeChatImprove"];
    CSBackupEngine *engine=[[CSBackupEngine alloc]initWithDefaults:@{@"standard":defaults,@"legacy":defaults,@"layout":defaults} domains:@{@"standard":suite,@"legacy":suite,@"layout":suite} store:[[CSBackupStore alloc]initWithMigration:migration] resources:resources];
    engine.context=^{return @{@"account":account,@"epoch":@1,@"installationID":@"compatibility-tests",@"pluginVersion":version};};return engine;
}
static int Run(NSString *binary,NSArray *args){NSTask *task=[NSTask new];task.executableURL=[NSURL fileURLWithPath:binary];task.arguments=args;NSError *error=nil;Check([task launchAndReturnError:&error],error.description?:@"launch child");[task waitUntilExit];return task.terminationStatus;}
static NSData *Seal(NSDictionary *snapshot){NSMutableDictionary *copy=[snapshot mutableCopy];[copy removeObjectForKey:@"integrity"];copy[@"integrity"]=[CSBackupCodec digest:copy];return [NSPropertyListSerialization dataWithPropertyList:copy format:NSPropertyListBinaryFormat_v1_0 options:0 error:NULL];}
int main(int argc,const char **argv){@autoreleasepool{
    if(argc>=5){CSBackupEngine *engine=Engine(@(argv[2]),@(argv[3]),@(argv[4]),@"current",NO);NSString *mode=@(argv[1]);NSError *error=nil;
        if([mode isEqual:@"--kill-attempt"])engine.checkpoint=^(NSString *point){if([point isEqual:@"startupAttempt"])_exit(77);};
        BOOL ok=[engine applyPending:&error];
        if([mode isEqual:@"--retry"]){Check(!ok,@"first account mismatch blocks apply");ok=[engine applyPending:&error];Check(!ok&&[[engine.store journal:NULL][@"state"] isEqual:@"prepared"],@"foreground retry in same process is not a second startup");}
        if(!ok)fprintf(stdout,"STARTUP rejected: %s\n",error.localizedDescription.UTF8String);return ok?0:2;
    }
    BOOL expectStuck=argc>1&&!strcmp(argv[1],"--expect-stuck");NSString *binary=@(argv[0]);NSFileManager *fm=NSFileManager.defaultManager;
    NSString *base=[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString];
    NSMutableArray *suites=[NSMutableArray array];NSError *error=nil;
    NSData *png=[[NSData alloc]initWithBase64EncodedString:@"iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMCAO+aWZcAAAAASUVORK5CYII=" options:0];
    NSSet *modules=[NSSet setWithObject:@"navigation"],*accounts=[NSSet setWithObject:@"alice"];
    // Compare native-new and externally created old-version snapshots with real PNG bytes.
    for(NSNumber *imported in @[@NO,@YES]){
        NSString *suite=[@"backup.compatibility." stringByAppendingString:NSUUID.UUID.UUIDString];[suites addObject:suite];NSUserDefaults *defaults=[[NSUserDefaults alloc]initWithSuiteName:suite];
        NSString *targetPath=[base stringByAppendingPathComponent:imported.boolValue?@"imported":@"new"];
        CSBackupEngine *target=Engine(targetPath,suite,@"alice",@"2.0-5",NO);
        NSString *sourcePath=imported.boolValue?[base stringByAppendingPathComponent:@"old-origin"]:targetPath;
        CSBackupEngine *source=imported.boolValue?Engine(sourcePath,suite,@"alice",@"1.8-37",YES):target;
        [fm createDirectoryAtURL:source.resourceRoot withIntermediateDirectories:YES attributes:nil error:NULL];NSURL *oldImage=[source.resourceRoot URLByAppendingPathComponent:@"separator_image.png"];
        [png writeToURL:oldImage atomically:YES];[defaults setObject:oldImage.path forKey:ImageKey];[defaults setObject:@"wanted" forKey:TextKey];
        NSDictionary *snapshot=[source capture:@"portable" kind:@"manual" error:&error];Check(snapshot!=nil,error.description?:@"capture source PNG");
        NSDictionary *imageField=nil;for(NSDictionary *f in snapshot[@"fields"])if([f[@"key"] isEqual:ImageKey])imageField=f;
        Check([imageField[@"value"] hasPrefix:@"csbackup:"]&&[snapshot[@"assets"] count]>0,@"payload embeds PNG bytes and digest reference, not the origin path");
        NSData *exported=[CSBackupCodec encode:snapshot error:&error];Check(exported!=nil,@"export portable backup");
        if(imported.boolValue)[fm removeItemAtPath:sourcePath error:NULL];
        [defaults removeObjectForKey:ImageKey];[defaults setObject:@"before" forKey:TextKey];
        CSBackupAudit *audit=[[CSBackupAudit alloc]initWithRoot:target.store.root auditURL:[target.store.root URLByAppendingPathComponent:@"test-audit.plist"]];
        target.store.eventHandler=^(NSString *event,NSDictionary *details){[audit storeEvent:event details:details];};
        NSDictionary *decoded=[CSBackupCodec decode:exported error:&error];Check(decoded!=nil,@"old source removed: portable bytes still decode");
        Check(imported.boolValue?[target.store importSnapshot:decoded error:&error]:[target.store publish:decoded error:&error],error.description?:@"publish comparison snapshot");
        NSDictionary *loaded=[target.store snapshot:snapshot[@"id"] error:&error];Check(loaded!=nil,@"read chosen comparison snapshot");
        NSDictionary *preview=[target preview:loaded modules:modules accounts:accounts error:&error];Check(preview!=nil,error.description?:@"preview portable snapshot");
        for(NSDictionary *f in preview[@"fields"])if([f[@"key"] isEqual:ImageKey])Check([f[@"value"] isEqual:[target.resourceRoot URLByAppendingPathComponent:@"separator_image.png"].path],@"resource reference remapped into current root");
        Check([target prepare:preview error:&error]&&[target applyPending:&error]&&[target finishStartup:&error]&&[target confirmStartup:&error],error.description?:@"complete native/imported restore");
        Check([[defaults stringForKey:TextKey] isEqual:@"wanted"]&&[[NSData dataWithContentsOfFile:[defaults stringForKey:ImageKey]] isEqual:png],@"preferences and PNG restored");
        Check([target applyPending:&error]&&[target.store journal:NULL]==nil,@"successful restore archives");
        // A purported old absolute-path payload is rejected before any prepared journal exists.
        NSMutableDictionary *bad=[snapshot mutableCopy];NSMutableArray *fields=[NSMutableArray array];
        for(NSDictionary *f in snapshot[@"fields"]){NSMutableDictionary *field=[f mutableCopy];if([field[@"key"] isEqual:ImageKey])field[@"value"]=@"/old-container/Library/Application Support/WeChatImprove/separator_image.png";[fields addObject:field];}
        bad[@"fields"]=fields;NSURL *original=[NSURL fileURLWithPath:[targetPath stringByAppendingPathComponent:@"legacy.wcbak"]];NSData *invalid=Seal(bad);[invalid writeToURL:original atomically:YES];
        error=nil;Check([CSBackupCodec decode:[NSData dataWithContentsOfURL:original] error:&error]==nil&&error!=nil,@"absolute old-path payload rejected at decode, before import/prepare");
        Check([[NSData dataWithContentsOfURL:original] isEqual:invalid]&&[target.store journal:NULL]==nil,@"rejected original retained without dangling transaction");
        bad=[snapshot mutableCopy];bad[@"assets"]=@{};error=nil;Check([CSBackupCodec decode:Seal(bad) error:&error]==nil,@"missing referenced resource rejected before prepare");
        if(imported.boolValue)Check(![fm fileExistsAtPath:sourcePath],@"restore never recreates old origin");
        [audit flush];
    }
    // A valid prepared transaction that fails before applying must not block every future launch.
    NSString *suite=[@"backup.prepared." stringByAppendingString:NSUUID.UUID.UUIDString];[suites addObject:suite];NSUserDefaults *defaults=[[NSUserDefaults alloc]initWithSuiteName:suite];
    NSString *path=[base stringByAppendingPathComponent:@"prepared"];CSBackupEngine *engine=Engine(path,suite,@"alice",@"current",NO);
    [defaults setObject:@"wanted" forKey:TextKey];NSDictionary *snapshot=[engine save:@"prepared expiry" kind:@"manual" error:&error];[defaults setObject:@"before" forKey:TextKey];
    NSDictionary *preview=[engine preview:snapshot modules:modules accounts:accounts error:&error];Check([engine prepare:preview error:&error],@"prepare expiry fixture");[defaults synchronize];
    Check(Run(binary,@[@"--retry",path,suite,@"bob"])==2,@"first startup cannot apply another account plan");
    Check([[engine.store journal:NULL][@"state"] isEqual:@"prepared"],@"first rejected startup leaves a valid prepared transaction");
    [defaults setObject:@"later user edit" forKey:TextKey];[defaults synchronize];
    int second=Run(binary,@[@"--apply",path,suite,@"alice"]);
    if(expectStuck){Check(second==2&&[[engine.store journal:NULL][@"state"] isEqual:@"prepared"],@"2.0-4 repeats failed prepared transaction on next startup");printf("REPRO: two separate startup processes leave journal=prepared after account/revision failures\n");}
    else {Check(second==0&&[engine.store journal:NULL]==nil,@"next startup safely retires unapplied prepared transaction");
        Check([[defaults stringForKey:TextKey] isEqual:@"later user edit"],@"retiring untouched plan cannot overwrite later edits with stale before values");
        NSDictionary *last=[NSDictionary dictionaryWithContentsOfURL:[engine.store.root URLByAppendingPathComponent:@"last-transaction.plist"]];
        Check([last[@"resolution"] isEqual:@"cancelledBeforeApply"]&&[last[@"resolutionReason"] length]>0,@"archived journal preserves cancellation reason");}
    for(NSString *name in suites)[[[NSUserDefaults alloc]initWithSuiteName:name] removePersistentDomainForName:name];[fm removeItemAtPath:base error:NULL];
    printf("Backup compatibility: %lu checks passed\n",(unsigned long)checks);
}return 0;}
