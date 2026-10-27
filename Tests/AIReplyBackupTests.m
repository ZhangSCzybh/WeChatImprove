#import <Foundation/Foundation.h>
#import "CSAIReplyStore.h"
#import "CSBackupEngine.h"
#import "CSBackupRegistry.h"
#import "CSBackupCodec.h"
static NSUInteger checks;
#define CHECK(c) do{checks++;if(!(c)){NSLog(@"FAIL %d %s",__LINE__,#c);exit(1);}}while(0)
static NSDictionary *AIField(NSDictionary *snapshot){for(NSDictionary *field in snapshot[@"fields"])if([field[@"domain"] isEqual:CSAIReplyBackupDomain])return field;return nil;}
int main(int argc,const char **argv){@autoreleasepool{
    CHECK(argc==2);NSURL *root=[NSURL fileURLWithPath:@(argv[1]) isDirectory:YES];NSString *suite=[@"ai.backup.tests." stringByAppendingString:NSUUID.UUID.UUIDString];NSUserDefaults *defaults=[[NSUserDefaults alloc]initWithSuiteName:suite];
    CSBackupEngine *engine=[[CSBackupEngine alloc]initWithDefaults:@{@"standard":defaults} domains:@{@"standard":suite} store:[[CSBackupStore alloc]initWithRoot:[root URLByAppendingPathComponent:@"BackupV2"]] resources:root];
    __block NSString *account=@"alice";engine.context=^{return @{@"account":account,@"epoch":@1,@"installationID":@"isolated-test",@"pluginVersion":@"2.0-25-ai"};};NSError *error=nil;
    CHECK(!AIField([engine capture:@"before" kind:@"manual" error:&error]));
    NSURL *url=CSAIReplyFileURL(root,account);CSAIReplyStore *live=[[CSAIReplyStore alloc]initWithURL:url account:account];CHECK([live load]);NSMutableDictionary *config=[live.configuration mutableCopy];
    config[@"enabled"]=@YES;config[@"endpoint"]=@"https://example.invalid/v1/chat/completions";config[@"model"]=@"test-model";config[@"credentialRevision"]=@"local-key-slot";config[@"verifiedConnection"]=CSAIConnectionIdentifier(config);config[@"verifiedAt"]=NSDate.date;
    config[@"mode"]=@"bailianResponses";config[@"sessionCache"]=@YES;config[@"endpoint"]=@"https://example.invalid/v1/responses";config[@"verifiedConnection"]=CSAIConnectionIdentifier(config);
    config[@"conversations"]=@{@"friend":@{@"enabled":@YES,@"presetID":@""},@"room@chatroom":@{@"enabled":@YES,@"presetID":@"",@"replyWithoutMention":@YES}};CHECK([live saveConfiguration:config error:&error]);CHECK([live claimMessageIDs:@[@"private-message-identity"] error:&error]);
    CHECK(([live appendHistory:@{@"date":NSDate.date,@"conversation":@"friend",@"preset":@"default",@"result":@"submitted",@"detail":@"已提交微信"} error:&error]));
    NSDictionary *snapshot=[engine capture:@"AI backup" kind:@"manual" error:&error];if(!snapshot)NSLog(@"capture failed: %@",error);CHECK(snapshot!=nil);NSDictionary *field=AIField(snapshot),*portable=field[@"value"],*portableConfig=portable[@"configuration"];
    CHECK([CSBackupRegistry.moduleTitles[@"ai_reply"] isEqual:@"AI 自动回复"]);CHECK([portableConfig[@"enabled"] boolValue]);CHECK(!portableConfig[@"credentialRevision"] && !portableConfig[@"verifiedConnection"] && !portableConfig[@"verifiedAt"]);CHECK(!portable[@"handled"] && !portable[@"history"]);
    CHECK(CSAIReplyUsesResponses(portableConfig));CHECK([portableConfig[@"sessionCache"] boolValue]);CHECK([portableConfig[@"conversations"][@"room@chatroom"][@"replyWithoutMention"] boolValue]);
    NSData *encoded=[CSBackupCodec encode:snapshot error:&error];CHECK(encoded!=nil);NSString *raw=[[NSString alloc]initWithData:encoded encoding:NSISOLatin1StringEncoding];CHECK(![raw containsString:@"private-message-identity"]);CHECK(![raw containsString:@"local-key-slot"]);
    NSDictionary *automatic=[engine save:@"auto" kind:@"automatic" error:&error];CHECK(automatic!=nil);CHECK([live claimMessageIDs:@[@"another-identity"] error:&error]);NSDictionary *same=[engine save:@"auto" kind:@"automatic" error:&error];CHECK([automatic[@"id"] isEqual:same[@"id"]]);
    NSSet *modules=[NSSet setWithObject:@"ai_reply"],*accounts=[NSSet setWithObject:@"alice"];
    NSDictionary *preview=[engine preview:snapshot modules:modules accounts:accounts error:&error];CHECK(preview!=nil);CHECK([preview[@"changes"] count]==1);NSDictionary *restoredConfig=preview[@"fields"][0][@"value"][@"configuration"];CHECK(![restoredConfig[@"enabled"] boolValue]);CHECK(![restoredConfig[@"credentialRevision"] length]);CHECK(![restoredConfig[@"verifiedConnection"] length]);
    // A new claim after preview invalidates the protected runtime before-image.
    CHECK([live claimMessageIDs:@[@"during-preview"] error:&error]);CHECK(![engine prepare:preview error:&error]);
    preview=[engine preview:snapshot modules:modules accounts:accounts error:&error];CHECK([engine prepare:preview error:&error]);NSDictionary *before=[CSAIReplyStore readStateAtURL:url account:@"alice" error:&error];CHECK([[engine.store journal:NULL][@"before"][0][@"value"] isEqual:before]);
    CHECK([engine applyPending:&error]);CHECK([engine cancelPending:&error]);
    CHECK([[CSAIReplyStore readStateAtURL:url account:@"alice" error:&error] isEqual:before]);
    preview=[engine preview:snapshot modules:modules accounts:accounts error:&error];CHECK([engine prepare:preview error:&error]);
    CHECK([engine applyPending:&error]);CHECK([engine finishStartup:&error]);CHECK([engine confirmStartup:&error]);CHECK([engine cancelPending:&error]);
    NSDictionary *restored=[CSAIReplyStore readStateAtURL:url account:@"alice" error:&error];CHECK(![restored[@"configuration"][@"enabled"] boolValue]);CHECK([restored[@"handled"] count]==0 && [restored[@"history"] count]==0);CHECK([restored[@"configuration"][@"conversations"] isEqual:config[@"conversations"]]);
    CHECK(CSAIReplyUsesResponses(restored[@"configuration"]));CHECK([restored[@"configuration"][@"sessionCache"] boolValue]);
    // Restoration cannot cross accounts; the existing file remains byte-for-byte intact.
    NSData *saved=[NSData dataWithContentsOfURL:url];account=@"bob";CHECK(![engine preview:snapshot modules:modules accounts:accounts error:&error]);CHECK([[NSData dataWithContentsOfURL:url] isEqual:saved]);account=@"alice";
    // An older snapshot has no AI module and cannot reset AI as a side effect.
    NSMutableDictionary *old=[snapshot mutableCopy];NSMutableArray *fields=[snapshot[@"fields"] mutableCopy];[fields removeObject:field];old[@"fields"]=fields;[old removeObjectForKey:@"integrity"];
    CHECK([engine preview:old modules:[NSSet setWithObject:@"entry"] accounts:accounts error:&error]!=nil);CHECK([[NSData dataWithContentsOfURL:url] isEqual:saved]);
    // Reset is scoped to the present account, with a protection snapshot before applying.
    NSDictionary *reset=[engine resetSnapshot:&error];CHECK(reset!=nil);preview=[engine preview:reset modules:modules accounts:accounts error:&error];CHECK(preview!=nil);CHECK([engine prepare:preview error:&error]);CHECK([engine applyPending:&error]);CHECK([engine finishStartup:&error]);CHECK([engine confirmStartup:&error]);CHECK([engine cancelPending:&error]);CHECK(![NSFileManager.defaultManager fileExistsAtPath:url.path]);
    [defaults removePersistentDomainForName:suite];printf("AI reply backup: %lu checks passed\n",(unsigned long)checks);return 0;
}}
