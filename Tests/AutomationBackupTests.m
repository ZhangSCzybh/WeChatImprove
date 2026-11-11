#import <Foundation/Foundation.h>
#import "CSBackupEngine.h"
#import "CSBackupRegistry.h"
#import "CSBackupCodec.h"
#import "CSAutomationStore.h"
#include <unistd.h>

static unsigned checks;
static void Check(BOOL value, NSString *detail) { checks++; if(!value){fprintf(stderr,"FAIL: %s\n",detail.UTF8String);exit(1);} }
static CSBackupEngine *Engine(NSURL *root,NSString *suite) {
    NSUserDefaults *defaults=[[NSUserDefaults alloc]initWithSuiteName:suite];
    CSBackupEngine *engine=[[CSBackupEngine alloc]initWithDefaults:@{@"standard":defaults} domains:@{@"standard":suite}
        store:[[CSBackupStore alloc]initWithRoot:[root URLByAppendingPathComponent:@"backup"]] resources:[root URLByAppendingPathComponent:@"resources"]];
    engine.context=^{return @{@"account":@"alice",@"epoch":@1,@"installationID":@"automation-backup-install",@"pluginVersion":@"2.4-3"};};return engine;
}
static NSDictionary *State(NSString *account,NSString *text) {
    NSMutableDictionary *configuration=[CSAutomationDefaultConfiguration() mutableCopy];
    for(NSString *module in @[@"patBack",@"patReply",@"mentionReply",@"keywordReply"]){
        NSMutableDictionary *value=[configuration[module] mutableCopy];
        [value addEntriesFromDictionary:@{@"enabled":@YES,@"friends":@[@"friend"],@"groups":@[@"101@chatroom"],@"delay":@7}];
        if([module isEqual:@"patReply"] || [module isEqual:@"mentionReply"])value[@"contents"]=@[text,@"第二条回复"];
        if([module isEqual:@"patBack"])value[@"revoke"]=@YES;
        if([module isEqual:@"keywordReply"])value[@"rules"]=@[@{@"id":@"F4828A1B-BD19-4107-9A3A-F1BA2CC26F86",@"keyword":@"你好",@"match":@"contains",@"contents":@[text]}];
        configuration[module]=value;
    }
    return @{@"schema":@1,@"account":account,@"configuration":configuration};
}
static NSDictionary *Disabled(NSDictionary *state) {
    NSMutableDictionary *result=[state mutableCopy],*configuration=[state[@"configuration"] mutableCopy];
    for(NSString *module in @[@"patBack",@"patReply",@"mentionReply",@"keywordReply"]){NSMutableDictionary *value=[configuration[module] mutableCopy];value[@"enabled"]=@NO;configuration[module]=value;}
    result[@"configuration"]=configuration;return result;
}
static NSDictionary *Field(NSDictionary *snapshot) {
    for(NSDictionary *field in snapshot[@"fields"])if([field[@"domain"] isEqual:CSAutomationBackupDomain])return field;return nil;
}
static void Complete(CSBackupEngine *engine) {
    NSError *error=nil;Check([engine applyPending:&error],error.description?:@"apply");
    Check([engine finishStartup:&error],error.description?:@"finish");Check([engine confirmStartup:&error],error.description?:@"activate");
    Check([engine.store archiveJournal:&error],error.description?:@"archive");
}
int main(int argc,char **argv) { @autoreleasepool {
    if(argc==4 && [@(argv[1]) isEqual:@"crash"]){
        CSBackupEngine *engine=Engine([NSURL fileURLWithPath:@(argv[2]) isDirectory:YES],@(argv[3]));
        engine.checkpoint=^(NSString *point){if([point isEqual:@"automation"])_exit(77);};
        [engine applyPending:NULL];return 78;
    }
    NSURL *root=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString] isDirectory:YES];
    NSString *suite=[@"automation.backup." stringByAppendingString:NSUUID.UUID.UUIDString];
    CSBackupEngine *engine=Engine(root,suite);NSUserDefaults *defaults=[[NSUserDefaults alloc]initWithSuiteName:suite];
    NSURL *aliceURL=CSAutomationFileURL(engine.resourceRoot,@"alice"),*bobURL=CSAutomationFileURL(engine.resourceRoot,@"bob");
    NSDictionary *original=State(@"alice",@"欢迎@昵称加入@群昵称"),*changed=State(@"alice",@"变更后的欢迎@昵称"),*bob=State(@"bob",@"bob的配置");
    NSError *error=nil;
    Check(CSAutomationWriteState(original,aliceURL,@"alice",&error),@"write current account fixture");
    Check(CSAutomationWriteState(bob,bobURL,@"bob",&error),@"write other account fixture");
    NSData *bobBytes=[NSData dataWithContentsOfURL:bobURL];
    NSURL *runtimeURL=[[aliceURL URLByDeletingPathExtension] URLByAppendingPathExtension:@"runtime.plist"];
    CSAutomationLedger *ledger=[[CSAutomationLedger alloc]initWithURL:runtimeURL account:@"alice" error:&error];
    Check(ledger!=nil && [ledger claimIdentifiers:@[@"alice|historical-local-action"] action:@"patBack" now:NSDate.date error:&error],@"create local owned-action ledger fixture");
    NSData *runtimeBytes=[NSData dataWithContentsOfURL:runtimeURL];
    __block NSUInteger restoreNotifications=0;__block BOOL notificationsOnMain=YES;
    id observer=[NSNotificationCenter.defaultCenter addObserverForName:@"CSAutomationRestoreDidComplete" object:nil queue:nil usingBlock:^(__unused NSNotification *note){restoreNotifications++;notificationsOnMain=notificationsOnMain && NSThread.isMainThread;}];
    [defaults setObject:@"host secret" forKey:@"host.account"];
    NSDictionary *snapshot=[engine save:@"自动功能配置" error:&error];Check(snapshot!=nil,error.description?:@"capture");
    Check([Field(snapshot)[@"value"] isEqual:original],@"snapshot preserves exact configuration");
    Check([Field(snapshot)[@"value"] count]==3 && [Field(snapshot)[@"value"][@"configuration"] count]==5,@"snapshot contains portable configuration only");
    Check([CSBackupRegistry entryForDomain:@"automation.runtime" key:@"alice"]==nil,@"runtime ledger has no portable registry domain");
    Check([snapshot[@"source"][@"account"] isEqual:@"alice"],@"source account preserved");
    Check([CSBackupRegistry.moduleTitles[@"automation"] isEqual:@"自动功能"],@"registered module label");
    Check([[CSBackupRegistry entryForDomain:CSAutomationBackupDomain key:@"alice"][@"scope"] isEqual:@"account"],@"account scoped registry");
    Check([CSBackupRegistry entryForDomain:CSAutomationBackupDomain key:@"../alice"]==nil,@"invalid account path rejected");
    Check([CSBackupCodec decode:[CSBackupCodec encode:snapshot error:&error] error:&error]!=nil,@"portable codec round trip");
    NSSet *modules=[NSSet setWithObject:@"automation"],*accounts=[NSSet setWithObject:@"alice"];
    Check(CSAutomationWriteState(changed,aliceURL,@"alice",&error),@"edit fixture after snapshot");
    NSDictionary *preview=[engine preview:snapshot modules:modules accounts:accounts error:&error];Check(preview!=nil,error.description?:@"preview");
    Check([preview[@"changes"] count]==1,@"one module configuration change");
    Check([preview[@"fields"][0][@"value"] isEqual:Disabled(original)],@"restore disables all four modules and preserves rule data/account");
    Check([[preview[@"warnings"] componentsJoinedByString:@" "] containsString:@"四个模块开关均关闭"],@"preview explains disabled restored modules");
    Check([engine prepare:preview error:&error],error.description?:@"prepare");
    Check([CSAutomationReadState(aliceURL,@"alice",&error) isEqual:changed],@"prepare does not alter live config");
    Check(restoreNotifications==0,@"preview and prepare do not notify a completed restore");
    Complete(engine);
    [NSRunLoop.currentRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.02]];
    Check(restoreNotifications>0 && notificationsOnMain,@"verified restore posts manager invalidation on main");
    Check([CSAutomationReadState(aliceURL,@"alice",&error) isEqual:Disabled(original)],@"same account restored with switches disabled");
    Check([[NSData dataWithContentsOfURL:bobURL] isEqual:bobBytes],@"other account bytes preserved");
    Check([[defaults objectForKey:@"host.account"] isEqual:@"host secret"],@"wechat account defaults preserved");
    Check([[NSData dataWithContentsOfURL:runtimeURL] isEqual:runtimeBytes],@"restore does not overwrite or clear local ownership ledger");
    Check(CSAutomationWriteState(changed,aliceURL,@"alice",&error),@"edit before stale preview");
    preview=[engine preview:snapshot modules:modules accounts:accounts error:&error];
    NSMutableDictionary *newest=[changed mutableCopy],*config=[changed[@"configuration"] mutableCopy],*back=[config[@"patBack"] mutableCopy];back[@"delay"]=@19;config[@"patBack"]=back;newest[@"configuration"]=config;
    Check(CSAutomationWriteState(newest,aliceURL,@"alice",&error),@"change after preview");
    Check(![engine prepare:preview error:&error],@"configuration revision change invalidates preview");
    Check([CSAutomationReadState(aliceURL,@"alice",NULL) isEqual:newest],@"stale preview preserves current state");
    NSDictionary *empty=[engine preview:snapshot modules:modules accounts:[NSSet setWithObject:@"bob"] error:&error];
    Check(!empty && [CSAutomationReadState(aliceURL,@"alice",NULL) isEqual:newest],@"unselected original account skipped without writes");
    engine.context=^{return @{@"account":@"bob",@"epoch":@2,@"installationID":@"automation-backup-install",@"pluginVersion":@"2.4-3"};};
    empty=[engine preview:snapshot modules:modules accounts:[NSSet setWithObject:@"alice"] error:&error];
    Check(!empty && [[NSData dataWithContentsOfURL:bobURL] isEqual:bobBytes],@"different current account never gets config reassigned");
    engine.context=^{return @{@"account":@"alice",@"epoch":@3,@"installationID":@"automation-backup-install",@"pluginVersion":@"2.4-3"};};
    NSMutableDictionary *invalid=[original mutableCopy];invalid[@"account"]=@"bob";
    Check(![CSBackupRegistry validateValue:invalid entry:[CSBackupRegistry entryForDomain:CSAutomationBackupDomain key:@"alice"] error:&error],@"mismatched state owner rejected");
    invalid=[original mutableCopy];invalid[@"pendingActions"]=@[@"historical event"];
    Check(![CSBackupRegistry validateValue:invalid entry:[CSBackupRegistry entryForDomain:CSAutomationBackupDomain key:@"alice"] error:&error],@"runtime queues cannot be imported");
    Check(!CSAutomationWriteState(invalid,aliceURL,@"alice",&error),@"invalid imported state cannot overwrite config");
    Check([CSAutomationReadState(aliceURL,@"alice",NULL) isEqual:newest],@"invalid import preserved existing file");
    // A syntactically valid journal still cannot redirect an automation field to another account.
    preview=[engine preview:snapshot modules:modules accounts:accounts error:&error];
    Check([engine prepare:preview error:&error],@"prepare journal ownership fixture");
    NSDictionary *validJournal=[engine.store journal:&error];NSMutableDictionary *forged=[validJournal mutableCopy];
    forged[@"after"]=@[@{@"domain":CSAutomationBackupDomain,@"key":@"bob",@"present":@YES,@"value":Disabled(bob)}];
    Check([engine.store writeJournal:forged error:&error],@"store a structurally valid but cross-account journal fixture");
    Check(![engine applyPending:&error],@"engine rejects cross-account automation journal before writes");
    Check([CSAutomationReadState(aliceURL,@"alice",NULL) isEqual:newest] && [[NSData dataWithContentsOfURL:bobURL] isEqual:bobBytes],@"rejected journal preserves both account configurations");
    Check([engine.store writeJournal:validJournal error:&error] && [engine cancelPending:&error],@"retire journal ownership fixture without applying");
    // An older backup without this module is not an instruction to erase it.
    NSMutableDictionary *older=[snapshot mutableCopy];NSMutableArray *oldFields=[NSMutableArray array];
    for(NSDictionary *field in snapshot[@"fields"])if(![field[@"domain"] isEqual:CSAutomationBackupDomain])[oldFields addObject:field];older[@"fields"]=oldFields;
    empty=[engine preview:older modules:modules accounts:accounts error:&error];Check(!empty && [CSAutomationReadState(aliceURL,@"alice",NULL) isEqual:newest],@"older backup leaves new module untouched");
    // A crash after the native module file write is repaired from its original account before-image.
    preview=[engine preview:snapshot modules:modules accounts:accounts error:&error];Check([engine prepare:preview error:&error],error.description?:@"prepare crash fixture");
    NSTask *child=[NSTask new];child.executableURL=[NSURL fileURLWithPath:@(argv[0])];child.arguments=@[@"crash",root.path,suite];
    Check([child launchAndReturnError:&error],@"start crash fixture");[child waitUntilExit];Check(child.terminationStatus==77,@"crashed at module write boundary");
    Check([CSAutomationReadState(aliceURL,@"alice",NULL) isEqual:Disabled(original)],@"crash occurred after replacement");
    engine.context=^{return @{@"account":@"bob",@"epoch":@4,@"installationID":@"automation-backup-install",@"pluginVersion":@"2.4-3"};};
    Check([engine applyPending:&error],error.description?:@"recover interrupted write");
    Check([CSAutomationReadState(aliceURL,@"alice",NULL) isEqual:newest],@"rollback restores journal original alice file while bob active");
    Check([[NSData dataWithContentsOfURL:bobURL] isEqual:bobBytes],@"rollback never touches active bob config");
    Check([engine.store archiveJournal:&error],@"archive rolled back journal");
    engine.context=^{return @{@"account":@"alice",@"epoch":@5,@"installationID":@"automation-backup-install",@"pluginVersion":@"2.4-3"};};
    NSDictionary *reset=[engine resetSnapshot:&error];preview=[engine preview:reset modules:modules accounts:accounts error:&error];
    Check(preview && [preview[@"fields"] count]==1 && ![preview[@"fields"][0][@"present"] boolValue],@"module reset covers only current account file");
    Check([engine prepare:preview error:&error],error.description?:@"prepare reset");Complete(engine);
    Check(![NSFileManager.defaultManager fileExistsAtPath:aliceURL.path],@"reset deletes only this config file");
    Check([[NSData dataWithContentsOfURL:runtimeURL] isEqual:runtimeBytes],@"reset preserves local ownership ledger to prevent replay");
    Check([[NSData dataWithContentsOfURL:bobURL] isEqual:bobBytes],@"reset preserves other account file");
    Check([[defaults objectForKey:@"host.account"] isEqual:@"host secret"],@"reset preserves host preferences");
    preview=[engine preview:snapshot modules:modules accounts:accounts error:&error];Check([engine prepare:preview error:&error],@"restore after missing current account file");Complete(engine);
    Check([CSAutomationReadState(aliceURL,@"alice",NULL) isEqual:Disabled(original)],@"restored after reset");
    Check([ledger hasIdentifiers:@[@"alice|historical-local-action"] action:@"patBack"],@"historical action remains owned after reset and restore");
    [NSNotificationCenter.defaultCenter removeObserver:observer];
    [defaults removePersistentDomainForName:suite];[NSFileManager.defaultManager removeItemAtURL:root error:NULL];
    printf("Automation backup: %u checks passed\n",checks);return 0;
} }
