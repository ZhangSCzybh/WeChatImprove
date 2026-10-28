#import <Foundation/Foundation.h>
#import "CSAIReplyStore.h"
#import "CSAIClient.h"
#import <sys/stat.h>
#import <unistd.h>
#define CHECK(...) do { if(!(__VA_ARGS__)) { fprintf(stderr,"FAIL line %d: %s\n",__LINE__,#__VA_ARGS__); exit(1); } } while(0)
int main(void) { @autoreleasepool {
    NSURL *root=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString] isDirectory:YES];
    NSURL *url=CSAIReplyFileURL(root,@"alice/../秘密");
    CHECK([[url URLByDeletingLastPathComponent].path isEqual:root.path]);
    CHECK(![CSAIReplyFileURL(root,@"bob") isEqual:url]);
    CSAIReplyStore *store=[[CSAIReplyStore alloc] initWithURL:url account:@"alice"];
    CHECK([store load]); CHECK(store.ready); CHECK(![store.configuration[@"enabled"] boolValue]); CHECK(store.history.count==0);
    CHECK([CSAIProvider(store.configuration) isEqual:@"openai-compatible"]); CHECK([CSAISearchMode(store.configuration) isEqual:@"off"]);
    CHECK(![store.configuration[@"imageEnabled"] boolValue] && ![store.configuration[@"thinkingEnabled"] boolValue]);
    NSError *error=nil;
    CHECK(![CSAIReplyStore readStateAtURL:url account:@"alice" error:&error]); CHECK(!error);
    // Missing capability fields retain both the old data format and its verified connection identity.
    NSMutableDictionary *legacy=[CSAIReplyDefaultConfiguration() mutableCopy];
    for(NSString *key in @[@"provider",@"imageEnabled",@"searchMode",@"thinkingEnabled"])[legacy removeObjectForKey:key];
    legacy[@"enabled"]=@YES;legacy[@"endpoint"]=@"https://example.invalid/v1/chat/completions";legacy[@"model"]=@"legacy-model";legacy[@"credentialRevision"]=@"legacy-key";
    NSString *legacyIdentifier=@"b713a0f0b6c37defbf8d25f283661b4d2c209e59903090f1505ca89ed2d85121";
    CHECK(CSAIReplyValidateConfiguration(legacy,&error));CHECK([CSAIConnectionIdentifier(legacy) isEqual:legacyIdentifier]);
    CHECK([CSAIProvider(legacy) isEqual:@"openai-compatible"] && [CSAISearchMode(legacy) isEqual:@"off"]);
    NSMutableDictionary *explicitDefaults=[legacy mutableCopy];[explicitDefaults addEntriesFromDictionary:@{@"provider":@"openai-compatible",@"imageEnabled":@NO,@"searchMode":@"off",@"thinkingEnabled":@NO}];
    CHECK(CSAIReplyValidateConfiguration(explicitDefaults,&error));CHECK([CSAIConnectionIdentifier(explicitDefaults) isEqual:legacyIdentifier]);
    for(NSString *key in @[@"provider",@"imageEnabled",@"searchMode",@"thinkingEnabled"]){NSMutableDictionary *part=[legacy mutableCopy];part[key]=explicitDefaults[key];CHECK([CSAIConnectionIdentifier(part) isEqual:legacyIdentifier]);}
    legacy[@"verifiedConnection"]=legacyIdentifier;
    NSURL *legacyURL=[root URLByAppendingPathComponent:@"legacy.plist"];
    CHECK([CSAIReplyStore replaceState:@{@"schema":@1,@"account":@"alice",@"configuration":legacy,@"handled":@{},@"history":@[]} atURL:legacyURL account:@"alice" error:&error]);
    NSData *legacyBytes=[NSData dataWithContentsOfURL:legacyURL];CSAIReplyStore *legacyStore=[[CSAIReplyStore alloc]initWithURL:legacyURL account:@"alice"];CHECK([legacyStore load]);
    CHECK([legacyStore.configuration[@"verifiedConnection"] isEqual:CSAIConnectionIdentifier(legacyStore.configuration)]);CHECK(!legacyStore.configuration[@"provider"]);CHECK([[NSData dataWithContentsOfURL:legacyURL] isEqual:legacyBytes]);
    NSMutableSet *capabilityIdentifiers=[NSMutableSet setWithObject:legacyIdentifier];
    NSMutableDictionary *imageOnly=[legacy mutableCopy];imageOnly[@"imageEnabled"]=@YES;CHECK(CSAIReplyValidateConfiguration(imageOnly,&error));[capabilityIdentifiers addObject:CSAIConnectionIdentifier(imageOnly)];
    for(NSString *search in @[@"off",@"auto",@"always"])for(NSNumber *image in @[@NO,@YES])for(NSNumber *thinking in @[@NO,@YES]){
        NSMutableDictionary *capability=[legacy mutableCopy];[capability addEntriesFromDictionary:@{@"provider":@"bailian",@"imageEnabled":image,@"searchMode":search,@"thinkingEnabled":thinking}];
        CHECK(CSAIReplyValidateConfiguration(capability,&error));[capabilityIdentifiers addObject:CSAIConnectionIdentifier(capability)];
    }
    CHECK(capabilityIdentifiers.count==14);
    for(NSString *key in @[@"provider",@"searchMode"])for(id value in @[@"",@"unknown",@1,NSNull.null,@[],@{}]){NSMutableDictionary *invalid=[legacy mutableCopy];invalid[key]=value;CHECK(!CSAIReplyValidateConfiguration(invalid,&error));}
    for(NSString *key in @[@"imageEnabled",@"thinkingEnabled"])for(id value in @[@2,@"YES",NSNull.null,@[],@{}]){NSMutableDictionary *invalid=[legacy mutableCopy];invalid[key]=value;CHECK(!CSAIReplyValidateConfiguration(invalid,&error));}
    for(NSString *search in @[@"auto",@"always"]){NSMutableDictionary *invalid=[legacy mutableCopy];invalid[@"searchMode"]=search;CHECK(!CSAIReplyValidateConfiguration(invalid,&error));}
    NSMutableDictionary *invalidThinking=[legacy mutableCopy];invalidThinking[@"thinkingEnabled"]=@YES;CHECK(!CSAIReplyValidateConfiguration(invalidThinking,&error));
    NSMutableDictionary *configuration=[store.configuration mutableCopy]; configuration[@"enabled"]=@YES; configuration[@"endpoint"]=@"https://example.invalid/v1/chat/completions"; configuration[@"model"]=@"test"; configuration[@"credentialRevision"]=@"revision"; configuration[@"verifiedConnection"]=CSAIConnectionIdentifier(configuration); configuration[@"verifiedAt"]=[NSDate date];
    // Mutating any caller-owned container or string after save cannot alter memory or disk.
    NSMutableString *endpoint=[configuration[@"endpoint"] mutableCopy], *model=[@"test" mutableCopy], *name=[@"默认回复" mutableCopy], *prompt=[@"原始提示" mutableCopy], *presetID=[@"" mutableCopy];
    NSMutableDictionary *preset=[@{@"id":@"default",@"name":name,@"prompt":prompt} mutableCopy]; NSMutableArray *presets=[NSMutableArray arrayWithObject:preset];
    NSMutableDictionary *room=[@{@"enabled":@YES,@"presetID":presetID,@"allowUnmentioned":@YES} mutableCopy];
    NSMutableDictionary *conversations=[@{@"contact":@{@"enabled":@YES,@"presetID":@""},@"legacy@chatroom":@{@"enabled":@YES,@"presetID":@""},@"room@chatroom":room} mutableCopy];
    NSMutableString *provider=[@"bailian" mutableCopy],*searchMode=[@"auto" mutableCopy];configuration[@"provider"]=provider;configuration[@"imageEnabled"]=@YES;configuration[@"searchMode"]=searchMode;configuration[@"thinkingEnabled"]=@YES;configuration[@"verifiedConnection"]=CSAIConnectionIdentifier(configuration);
    configuration[@"endpoint"]=endpoint; configuration[@"model"]=model; configuration[@"presets"]=presets; configuration[@"conversations"]=conversations;
    CHECK([store saveConfiguration:configuration error:&error]); NSDictionary *savedConfiguration=store.configuration; NSData *savedConfigurationBytes=[NSData dataWithContentsOfURL:url];
    configuration[@"enabled"]=@NO; [endpoint appendString:@"/changed"]; [model setString:@"changed"]; [name setString:@"变更名称"]; [prompt setString:@"变更提示"]; [presetID setString:@"default"]; room[@"allowUnmentioned"]=@NO; preset[@"id"]=@"changed"; [presets removeAllObjects]; [conversations removeAllObjects];
    [provider setString:@"openai-compatible"];[searchMode setString:@"off"];configuration[@"imageEnabled"]=@NO;configuration[@"thinkingEnabled"]=@NO;
    CHECK([CSAIProvider(store.configuration) isEqual:@"bailian"] && [CSAISearchMode(store.configuration) isEqual:@"auto"]);CHECK([store.configuration[@"imageEnabled"] boolValue] && [store.configuration[@"thinkingEnabled"] boolValue]);
    CHECK([store.configuration[@"enabled"] boolValue]); CHECK([store.configuration[@"endpoint"] isEqual:@"https://example.invalid/v1/chat/completions"]); CHECK([store.configuration[@"model"] isEqual:@"test"]);
    CHECK([store.configuration[@"presets"][0][@"id"] isEqual:@"default"]); CHECK([store.configuration[@"presets"][0][@"name"] isEqual:@"默认回复"]); CHECK([store.configuration[@"presets"][0][@"prompt"] isEqual:@"原始提示"]);
    CHECK([store.configuration[@"conversations"][@"room@chatroom"][@"allowUnmentioned"] boolValue]); CHECK([store.configuration[@"conversations"][@"room@chatroom"][@"presetID"] isEqual:@""]); CHECK([[NSData dataWithContentsOfURL:url] isEqual:savedConfigurationBytes]);
    CHECK(![store.configuration[@"conversations"][@"legacy@chatroom"][@"allowUnmentioned"] boolValue]);
    CHECK([store claimMessageIDs:@[@"id1",@"id2"] error:&error]); CHECK([store hasHandledMessageID:@"id1"]);
    CHECK(store.configuration==savedConfiguration);
    NSMutableString *mutableIdentity=[@"mutable-id" mutableCopy]; NSMutableArray *mutableIdentities=[NSMutableArray arrayWithObject:mutableIdentity]; CHECK([store claimMessageIDs:mutableIdentities error:&error]); [mutableIdentity setString:@"changed-id"]; [mutableIdentities removeAllObjects]; CHECK([store hasHandledMessageID:@"mutable-id"]); CHECK(![store hasHandledMessageID:@"changed-id"]); CHECK(store.configuration==savedConfiguration);
    NSData *before=[NSData dataWithContentsOfURL:url]; CHECK(![store claimMessageIDs:@[@"id1",@"id3"] error:&error]); CHECK(![store hasHandledMessageID:@"id3"]); CHECK([[NSData dataWithContentsOfURL:url] isEqual:before]);
    CHECK(![store claimMessageIDs:@[@"same",@"same"] error:&error]); CHECK(![store hasHandledMessageID:@"same"]); CHECK(store.configuration==savedConfiguration); CHECK([[NSData dataWithContentsOfURL:url] isEqual:before]);
    NSMutableString *historyConversation=[@"contact" mutableCopy], *historyPreset=[@"default" mutableCopy], *historyResult=[@"submitted" mutableCopy], *historyDetail=[@"已提交" mutableCopy];
    NSMutableDictionary *mutableRecord=[@{@"date":[NSDate date],@"conversation":historyConversation,@"preset":historyPreset,@"result":historyResult,@"detail":historyDetail} mutableCopy];
    CHECK([store appendHistory:mutableRecord error:&error]); NSDictionary *record=store.history.lastObject; NSData *savedHistoryBytes=[NSData dataWithContentsOfURL:url];
    [historyConversation setString:@"other"]; [historyPreset setString:@"other"]; [historyResult setString:@"failed"]; [historyDetail setString:@"更改内容"]; [mutableRecord removeAllObjects];
    CHECK([record[@"conversation"] isEqual:@"contact"]); CHECK([record[@"preset"] isEqual:@"default"]); CHECK([record[@"result"] isEqual:@"submitted"]); CHECK([record[@"detail"] isEqual:@"已提交"]); CHECK([[NSData dataWithContentsOfURL:url] isEqual:savedHistoryBytes]); CHECK(store.configuration==savedConfiguration);
    for(NSUInteger i=0;i<204;i++) CHECK([store appendHistory:record error:&error]); CHECK(store.history.count==200); CHECK(store.configuration==savedConfiguration);
    CHECK(![store appendHistory:@{@"date":[NSDate date],@"conversation":@"contact",@"preset":@"default",@"result":@"failed",@"detail":@"",@"body":@"secret"} error:&error]);
    CSAIReplyStore *reload=[[CSAIReplyStore alloc] initWithURL:url account:@"alice"]; CHECK([reload load]); CHECK([reload hasHandledMessageID:@"id2"]); CHECK([reload.configuration[@"enabled"] boolValue]);
    CHECK([reload.configuration[@"conversations"][@"room@chatroom"][@"allowUnmentioned"] boolValue]); CHECK(![reload.configuration[@"conversations"][@"legacy@chatroom"][@"allowUnmentioned"] boolValue]);
    CHECK([CSAIProvider(reload.configuration) isEqual:@"bailian"] && [CSAISearchMode(reload.configuration) isEqual:@"auto"]);CHECK([reload.configuration[@"imageEnabled"] boolValue] && [reload.configuration[@"thinkingEnabled"] boolValue]);
    NSDictionary *state=[CSAIReplyStore readStateAtURL:url account:@"alice" error:&error]; NSDictionary *portable=CSAIReplyPortableState(state);
    CHECK(!portable[@"handled"] && !portable[@"history"]); CHECK(!portable[@"configuration"][@"credentialRevision"] && !portable[@"configuration"][@"verifiedConnection"] && !portable[@"configuration"][@"verifiedAt"]); CHECK([portable[@"configuration"][@"enabled"] boolValue]); CHECK(CSAIReplyValidateState(portable,@"alice",&error)); CHECK(!CSAIReplyValidateState(portable,@"bob",&error));
    CHECK([CSAIProvider(portable[@"configuration"]) isEqual:@"bailian"] && [CSAISearchMode(portable[@"configuration"]) isEqual:@"auto"]);CHECK([portable[@"configuration"][@"imageEnabled"] boolValue] && [portable[@"configuration"][@"thinkingEnabled"] boolValue]);
    NSMutableDictionary *bad=[store.configuration mutableCopy]; bad[@"apiKey"]=@"must-never-persist"; CHECK(![store saveConfiguration:bad error:&error]);
    bad=[store.configuration mutableCopy];bad[@"imageData"]=[@"synthetic-image" dataUsingEncoding:NSUTF8StringEncoding];CHECK(![store saveConfiguration:bad error:&error]);CHECK(store.configuration==savedConfiguration);
    bad=[store.configuration mutableCopy]; bad[@"defaultPreset"]=@"missing"; CHECK(!CSAIReplyValidateConfiguration(bad,&error));
    bad=[store.configuration mutableCopy]; bad[@"presets"]=@[]; CHECK(!CSAIReplyValidateConfiguration(bad,&error));
    bad=[store.configuration mutableCopy]; bad[@"conversations"]=@{@"contact":@{@"enabled":@YES,@"presetID":@"missing"}}; CHECK(!CSAIReplyValidateConfiguration(bad,&error));
    for(id value in @[@2,@"YES",NSNull.null,@[]]) { bad=[store.configuration mutableCopy]; bad[@"conversations"]=@{@"room@chatroom":@{@"enabled":@YES,@"presetID":@"",@"allowUnmentioned":value}}; CHECK(!CSAIReplyValidateConfiguration(bad,&error)); }
    bad=[store.configuration mutableCopy]; bad[@"conversations"]=@{@"room@chatroom":@{@"enabled":@YES,@"presetID":@"",@"allowUnmentioned":@NO}}; CHECK(CSAIReplyValidateConfiguration(bad,&error));
    for(NSString *endpoint in @[@"http://example.invalid/a",@"https://user:pass@example.invalid/a",@"https://example.invalid/a#fragment",@"https:///a",@" https://example.invalid/a",@"https://example.invalid:0/a"]) CHECK(!CSAIValidateEndpoint(endpoint,&error));
    CHECK(CSAIValidateEndpoint(@"https://example.invalid/chat?version=1",&error));
    NSMutableDictionary *changed=[store.configuration mutableCopy]; NSString *connection=CSAIConnectionIdentifier(changed); changed[@"model"]=@"other"; CHECK(![connection isEqual:CSAIConnectionIdentifier(changed)]); changed=[store.configuration mutableCopy]; changed[@"credentialRevision"]=@"other"; CHECK(![connection isEqual:CSAIConnectionIdentifier(changed)]);
    // A seven-day-old ledger entry expires, and at most 5,000 recent identities persist.
    NSMutableDictionary *pruned=[state mutableCopy]; pruned[@"handled"]=@{@"expired":[NSDate dateWithTimeIntervalSinceNow:-8*86400]}; CHECK([CSAIReplyStore replaceState:pruned atURL:url account:@"alice" error:&error]); CHECK([store load]); CHECK(![store hasHandledMessageID:@"expired"]);
    NSMutableArray *identities=[NSMutableArray array]; for(NSUInteger i=0;i<5000;i++) [identities addObject:[NSString stringWithFormat:@"message-%lu",(unsigned long)i]];
    savedConfiguration=store.configuration; CHECK([store claimMessageIDs:identities error:&error]); CHECK(store.configuration==savedConfiguration); state=[CSAIReplyStore readStateAtURL:url account:@"alice" error:&error]; CHECK([state[@"handled"] count]==5000); CHECK(!state[@"handled"][@"expired"]);
    before=[NSData dataWithContentsOfURL:url]; CHECK(![store claimMessageIDs:@[@"message-0",@"unclaimed"] error:&error]); CHECK(![store hasHandledMessageID:@"unclaimed"]); CHECK([[NSData dataWithContentsOfURL:url] isEqual:before]); CHECK(store.configuration==savedConfiguration);
    [identities addObject:@"too-many"]; CHECK(![store claimMessageIDs:identities error:&error]); CHECK(![store hasHandledMessageID:@"too-many"]); CHECK([[NSData dataWithContentsOfURL:url] isEqual:before]);
    // Crossing the bound evicts the oldest record and retains the newly claimed identity.
    NSMutableDictionary *fullState=[state mutableCopy], *fullHandled=[state[@"handled"] mutableCopy]; fullHandled[@"message-0"]=[NSDate dateWithTimeIntervalSinceNow:-3600]; fullState[@"handled"]=fullHandled;
    CHECK([CSAIReplyStore replaceState:fullState atURL:url account:@"alice" error:&error]); CHECK([store load]); savedConfiguration=store.configuration;
    CHECK([store claimMessageIDs:@[@"new"] error:&error]); CHECK(store.configuration==savedConfiguration); CHECK(![store hasHandledMessageID:@"message-0"]); CHECK([store hasHandledMessageID:@"message-1"]);
    state=[CSAIReplyStore readStateAtURL:url account:@"alice" error:&error]; CHECK([state[@"handled"] count]==5000); CHECK(!state[@"handled"][@"message-0"]); CHECK(state[@"handled"][@"new"]);
    // Corruption never gets silently replaced or rewritten by subsequent operations.
    NSData *corrupt=[@"invalid original bytes" dataUsingEncoding:NSUTF8StringEncoding]; CHECK([corrupt writeToURL:url atomically:YES]); CHECK(![reload load]); CHECK(!reload.ready); CHECK(![reload saveConfiguration:CSAIReplyDefaultConfiguration() error:&error]); CHECK([[NSData dataWithContentsOfURL:url] isEqual:corrupt]);
    // Failed durable claims fail closed and never update the in-memory ledger.
    NSURL *blocker=[root URLByAppendingPathComponent:@"file"]; CHECK([corrupt writeToURL:blocker atomically:YES]);
    CSAIReplyStore *blocked=[[CSAIReplyStore alloc] initWithURL:[blocker URLByAppendingPathComponent:@"state.plist"] account:@"alice"]; CHECK(![blocked load]); CHECK(blocked.error); CHECK(![blocked claimMessageIDs:@[@"blocked"] error:&error]); CHECK(!blocked.ready); CHECK(![blocked hasHandledMessageID:@"blocked"]);
    // A write failure after a successful absent-file load also closes the send gate.
    NSURL *lateParent=[root URLByAppendingPathComponent:@"late-file"];
    CSAIReplyStore *lateFailure=[[CSAIReplyStore alloc] initWithURL:[lateParent URLByAppendingPathComponent:@"state.plist"] account:@"alice"];
    CHECK([lateFailure load]); NSDictionary *failedConfiguration=lateFailure.configuration; NSArray *failedHistory=lateFailure.history; CHECK([corrupt writeToURL:lateParent atomically:YES]);
    CHECK(![lateFailure claimMessageIDs:@[@"never-send"] error:&error]); CHECK(!lateFailure.ready); CHECK(![lateFailure hasHandledMessageID:@"never-send"]); CHECK(lateFailure.configuration==failedConfiguration); CHECK(lateFailure.history==failedHistory);
    // Replacing a regular file preserves restrictive permissions and rejects unsafe sources.
    NSURL *durable=[root URLByAppendingPathComponent:@"durable.plist"];
    CHECK([CSAIReplyStore replaceState:state atURL:durable account:@"alice" error:&error]);
    struct stat info; CHECK(stat(durable.fileSystemRepresentation,&info)==0); CHECK((info.st_mode&0777)==0600);
    NSURL *link=[root URLByAppendingPathComponent:@"link.plist"]; CHECK(symlink(durable.fileSystemRepresentation,link.fileSystemRepresentation)==0);
    error=nil; CHECK(![CSAIReplyStore readStateAtURL:link account:@"alice" error:&error]); CHECK(error);
    CHECK(![CSAIReplyStore replaceState:state atURL:link account:@"alice" error:&error]); CHECK(![CSAIReplyStore replaceState:nil atURL:link account:@"alice" error:&error]); CHECK(lstat(link.fileSystemRepresentation,&info)==0 && S_ISLNK(info.st_mode));
    NSURL *large=[root URLByAppendingPathComponent:@"large.plist"]; CHECK([[NSMutableData dataWithLength:4*1024*1024+1] writeToURL:large atomically:YES]);
    error=nil; CHECK(![CSAIReplyStore readStateAtURL:large account:@"alice" error:&error]); CHECK(error); CHECK([[NSData dataWithContentsOfURL:large] length]==4*1024*1024+1);
    CSAIReplyStore *oversized=[[CSAIReplyStore alloc] initWithURL:large account:@"alice"]; CHECK(![oversized load]); CHECK(!oversized.ready);
    error=nil; CHECK(![CSAIReplyStore readStateAtURL:root account:@"alice" error:&error]); CHECK(error);
    CHECK([CSAIReplyStore replaceState:nil atURL:durable account:@"alice" error:&error]); CHECK(![[NSFileManager defaultManager] fileExistsAtPath:durable.path]);
    [[NSFileManager defaultManager] removeItemAtURL:root error:NULL];
    puts("AIReplyStoreTests passed: legacy capability defaults/fingerprint, provider validation, immutable inputs, portable capabilities, atomic claims, bounds, account isolation, corruption and failed writes");
} return 0; }
