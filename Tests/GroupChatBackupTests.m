#import <Foundation/Foundation.h>
#import "CSBackupEngine.h"
#import "CSBackupRegistry.h"
#import "CSBackupCodec.h"
#import "CSGroupChatStore.h"
#include <unistd.h>

static unsigned checks;
static void Check(BOOL value, NSString *detail) { checks++; if(!value){fprintf(stderr,"FAIL: %s\n",detail.UTF8String);exit(1);} }
static CSBackupEngine *Engine(NSURL *root,NSString *suite) {
    NSUserDefaults *defaults=[[NSUserDefaults alloc]initWithSuiteName:suite];
    CSBackupEngine *engine=[[CSBackupEngine alloc]initWithDefaults:@{@"standard":defaults} domains:@{@"standard":suite}
        store:[[CSBackupStore alloc]initWithRoot:[root URLByAppendingPathComponent:@"backup"]] resources:[root URLByAppendingPathComponent:@"resources"]];
    engine.context=^{return @{@"account":@"alice",@"epoch":@1,@"installationID":@"group-backup-install",@"pluginVersion":@"2.4-3"};};return engine;
}
static NSDictionary *State(NSString *account,NSString *text) {
    NSMutableDictionary *configuration=[CSGroupChatDefaultConfiguration() mutableCopy];
    [configuration addEntriesFromDictionary:@{@"welcomeEnabled":@YES,@"monitorEnabled":@YES,@"autoSaveEnabled":@YES,
        @"welcomeRooms":@[@"101@chatroom"],@"monitorRooms":@[@"102@chatroom"],@"welcomeTemplate":text,@"welcomeDelay":@7}];
    return @{@"schema":@1,@"account":account,@"configuration":configuration};
}
static NSDictionary *Field(NSDictionary *snapshot) {
    for(NSDictionary *field in snapshot[@"fields"])if([field[@"domain"] isEqual:CSGroupChatBackupDomain])return field;return nil;
}
static void Complete(CSBackupEngine *engine) {
    NSError *error=nil;Check([engine applyPending:&error],error.description?:@"apply");
    Check([engine finishStartup:&error],error.description?:@"finish");Check([engine confirmStartup:&error],error.description?:@"activate");
    Check([engine.store archiveJournal:&error],error.description?:@"archive");
}
int main(int argc,char **argv) { @autoreleasepool {
    if(argc==4 && [@(argv[1]) isEqual:@"crash"]){
        CSBackupEngine *engine=Engine([NSURL fileURLWithPath:@(argv[2]) isDirectory:YES],@(argv[3]));
        engine.checkpoint=^(NSString *point){if([point isEqual:@"group-chat-tools"])_exit(77);};
        [engine applyPending:NULL];return 78;
    }
    NSURL *root=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString] isDirectory:YES];
    NSString *suite=[@"group.backup." stringByAppendingString:NSUUID.UUID.UUIDString];
    CSBackupEngine *engine=Engine(root,suite);NSUserDefaults *defaults=[[NSUserDefaults alloc]initWithSuiteName:suite];
    NSURL *aliceURL=CSGroupChatFileURL(engine.resourceRoot,@"alice"),*bobURL=CSGroupChatFileURL(engine.resourceRoot,@"bob");
    NSDictionary *original=State(@"alice",@"欢迎@昵称加入@群昵称"),*changed=State(@"alice",@"变更后的欢迎@昵称"),*bob=State(@"bob",@"bob的配置");
    NSError *error=nil;
    Check(CSGroupChatWriteState(original,aliceURL,@"alice",&error),@"write current account fixture");
    Check(CSGroupChatWriteState(bob,bobURL,@"bob",&error),@"write other account fixture");
    NSData *bobBytes=[NSData dataWithContentsOfURL:bobURL];
    [defaults setObject:@"host secret" forKey:@"host.account"];
    NSDictionary *snapshot=[engine save:@"群聊功能配置" error:&error];Check(snapshot!=nil,error.description?:@"capture");
    Check([Field(snapshot)[@"value"] isEqual:original],@"snapshot preserves exact configuration");
    Check([snapshot[@"source"][@"account"] isEqual:@"alice"],@"source account preserved");
    Check([CSBackupRegistry.moduleTitles[@"group_chat_tools"] isEqual:@"群聊功能"],@"registered module label");
    Check([[CSBackupRegistry entryForDomain:CSGroupChatBackupDomain key:@"alice"][@"scope"] isEqual:@"account"],@"account scoped registry");
    Check([CSBackupRegistry entryForDomain:CSGroupChatBackupDomain key:@"../alice"]==nil,@"invalid account path rejected");
    Check([CSBackupCodec decode:[CSBackupCodec encode:snapshot error:&error] error:&error]!=nil,@"portable codec round trip");
    NSSet *modules=[NSSet setWithObject:@"group_chat_tools"],*accounts=[NSSet setWithObject:@"alice"];
    Check(CSGroupChatWriteState(changed,aliceURL,@"alice",&error),@"edit fixture after snapshot");
    NSDictionary *preview=[engine preview:snapshot modules:modules accounts:accounts error:&error];Check(preview!=nil,error.description?:@"preview");
    Check([preview[@"changes"] count]==1,@"one module configuration change");
    Check([preview[@"fields"][0][@"value"] isEqual:original],@"restore preserves saved toggles and account");
    Check([[preview[@"warnings"] componentsJoinedByString:@" "] containsString:@"成员基线"],@"preview explains baseline rebuild");
    Check([engine prepare:preview error:&error],error.description?:@"prepare");
    Check([CSGroupChatReadState(aliceURL,@"alice",&error) isEqual:changed],@"prepare does not alter live config");
    Complete(engine);
    Check([CSGroupChatReadState(aliceURL,@"alice",&error) isEqual:original],@"same account restored exactly");
    Check([[NSData dataWithContentsOfURL:bobURL] isEqual:bobBytes],@"other account bytes preserved");
    Check([[defaults objectForKey:@"host.account"] isEqual:@"host secret"],@"wechat account defaults preserved");
    Check(CSGroupChatWriteState(changed,aliceURL,@"alice",&error),@"edit before stale preview");
    preview=[engine preview:snapshot modules:modules accounts:accounts error:&error];
    NSMutableDictionary *newest=[changed mutableCopy],*config=[changed[@"configuration"] mutableCopy];config[@"welcomeDelay"]=@19;newest[@"configuration"]=config;
    Check(CSGroupChatWriteState(newest,aliceURL,@"alice",&error),@"change after preview");
    Check(![engine prepare:preview error:&error],@"configuration revision change invalidates preview");
    Check([CSGroupChatReadState(aliceURL,@"alice",NULL) isEqual:newest],@"stale preview preserves current state");
    NSDictionary *empty=[engine preview:snapshot modules:modules accounts:[NSSet setWithObject:@"bob"] error:&error];
    Check(!empty && [CSGroupChatReadState(aliceURL,@"alice",NULL) isEqual:newest],@"unselected original account skipped without writes");
    engine.context=^{return @{@"account":@"bob",@"epoch":@2,@"installationID":@"group-backup-install",@"pluginVersion":@"2.4-3"};};
    empty=[engine preview:snapshot modules:modules accounts:[NSSet setWithObject:@"alice"] error:&error];
    Check(!empty && [[NSData dataWithContentsOfURL:bobURL] isEqual:bobBytes],@"different current account never gets config reassigned");
    engine.context=^{return @{@"account":@"alice",@"epoch":@3,@"installationID":@"group-backup-install",@"pluginVersion":@"2.4-3"};};
    NSMutableDictionary *invalid=[original mutableCopy];invalid[@"account"]=@"bob";
    Check(![CSBackupRegistry validateValue:invalid entry:[CSBackupRegistry entryForDomain:CSGroupChatBackupDomain key:@"alice"] error:&error],@"mismatched state owner rejected");
    invalid=[original mutableCopy];invalid[@"pendingWelcome"]=@[@"historical event"];
    Check(![CSBackupRegistry validateValue:invalid entry:[CSBackupRegistry entryForDomain:CSGroupChatBackupDomain key:@"alice"] error:&error],@"runtime queues cannot be imported");
    Check(!CSGroupChatWriteState(invalid,aliceURL,@"alice",&error),@"invalid imported state cannot overwrite config");
    Check([CSGroupChatReadState(aliceURL,@"alice",NULL) isEqual:newest],@"invalid import preserved existing file");
    // An older backup without this module is not an instruction to erase it.
    NSMutableDictionary *older=[snapshot mutableCopy];NSMutableArray *oldFields=[NSMutableArray array];
    for(NSDictionary *field in snapshot[@"fields"])if(![field[@"domain"] isEqual:CSGroupChatBackupDomain])[oldFields addObject:field];older[@"fields"]=oldFields;
    empty=[engine preview:older modules:modules accounts:accounts error:&error];Check(!empty && [CSGroupChatReadState(aliceURL,@"alice",NULL) isEqual:newest],@"older backup leaves new module untouched");
    // A crash after the native module file write is repaired from its original account before-image.
    preview=[engine preview:snapshot modules:modules accounts:accounts error:&error];Check([engine prepare:preview error:&error],error.description?:@"prepare crash fixture");
    NSTask *child=[NSTask new];child.executableURL=[NSURL fileURLWithPath:@(argv[0])];child.arguments=@[@"crash",root.path,suite];
    Check([child launchAndReturnError:&error],@"start crash fixture");[child waitUntilExit];Check(child.terminationStatus==77,@"crashed at module write boundary");
    Check([CSGroupChatReadState(aliceURL,@"alice",NULL) isEqual:original],@"crash occurred after replacement");
    engine.context=^{return @{@"account":@"bob",@"epoch":@4,@"installationID":@"group-backup-install",@"pluginVersion":@"2.4-3"};};
    Check([engine applyPending:&error],error.description?:@"recover interrupted write");
    Check([CSGroupChatReadState(aliceURL,@"alice",NULL) isEqual:newest],@"rollback restores journal original alice file while bob active");
    Check([[NSData dataWithContentsOfURL:bobURL] isEqual:bobBytes],@"rollback never touches active bob config");
    Check([engine.store archiveJournal:&error],@"archive rolled back journal");
    engine.context=^{return @{@"account":@"alice",@"epoch":@5,@"installationID":@"group-backup-install",@"pluginVersion":@"2.4-3"};};
    NSDictionary *reset=[engine resetSnapshot:&error];preview=[engine preview:reset modules:modules accounts:accounts error:&error];
    Check(preview && [preview[@"fields"] count]==1 && ![preview[@"fields"][0][@"present"] boolValue],@"module reset covers only current account file");
    Check([engine prepare:preview error:&error],error.description?:@"prepare reset");Complete(engine);
    Check(![NSFileManager.defaultManager fileExistsAtPath:aliceURL.path],@"reset deletes only this config file");
    Check([[NSData dataWithContentsOfURL:bobURL] isEqual:bobBytes],@"reset preserves other account file");
    Check([[defaults objectForKey:@"host.account"] isEqual:@"host secret"],@"reset preserves host preferences");
    preview=[engine preview:snapshot modules:modules accounts:accounts error:&error];Check([engine prepare:preview error:&error],@"restore after missing current account file");Complete(engine);
    Check([CSGroupChatReadState(aliceURL,@"alice",NULL) isEqual:original],@"restored after reset");
    [defaults removePersistentDomainForName:suite];[NSFileManager.defaultManager removeItemAtURL:root error:NULL];
    printf("Group chat backup: %u checks passed\n",checks);return 0;
} }
