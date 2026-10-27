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
    NSError *error=nil;
    CHECK(![CSAIReplyStore readStateAtURL:url account:@"alice" error:&error]); CHECK(!error);
    NSMutableDictionary *configuration=[store.configuration mutableCopy]; configuration[@"enabled"]=@YES; configuration[@"endpoint"]=@"https://example.invalid/v1/chat/completions"; configuration[@"model"]=@"test"; configuration[@"credentialRevision"]=@"revision"; configuration[@"verifiedConnection"]=CSAIConnectionIdentifier(configuration); configuration[@"verifiedAt"]=[NSDate date];
    configuration[@"conversations"]=@{@"contact":@{@"enabled":@YES,@"presetID":@""}};
    CHECK([store saveConfiguration:configuration error:&error]); configuration[@"enabled"]=@NO; CHECK([store.configuration[@"enabled"] boolValue]);
    CHECK([store claimMessageIDs:@[@"id1",@"id2"] error:&error]); CHECK([store hasHandledMessageID:@"id1"]);
    NSData *before=[NSData dataWithContentsOfURL:url]; CHECK(![store claimMessageIDs:@[@"id1",@"id3"] error:&error]); CHECK(![store hasHandledMessageID:@"id3"]); CHECK([[NSData dataWithContentsOfURL:url] isEqual:before]);
    CHECK(![store claimMessageIDs:@[@"same",@"same"] error:&error]);
    NSDictionary *record=@{@"date":[NSDate date],@"conversation":@"contact",@"preset":@"default",@"result":@"submitted",@"detail":@"已提交"};
    CHECK([store appendHistory:record error:&error]);
    for(NSUInteger i=0;i<204;i++) CHECK([store appendHistory:record error:&error]); CHECK(store.history.count==200);
    CHECK(![store appendHistory:@{@"date":[NSDate date],@"conversation":@"contact",@"preset":@"default",@"result":@"failed",@"detail":@"",@"body":@"secret"} error:&error]);
    CSAIReplyStore *reload=[[CSAIReplyStore alloc] initWithURL:url account:@"alice"]; CHECK([reload load]); CHECK([reload hasHandledMessageID:@"id2"]); CHECK([reload.configuration[@"enabled"] boolValue]);
    NSDictionary *state=[CSAIReplyStore readStateAtURL:url account:@"alice" error:&error]; NSDictionary *portable=CSAIReplyPortableState(state);
    CHECK(!portable[@"handled"] && !portable[@"history"]); CHECK(!portable[@"configuration"][@"credentialRevision"] && !portable[@"configuration"][@"verifiedConnection"] && !portable[@"configuration"][@"verifiedAt"]); CHECK([portable[@"configuration"][@"enabled"] boolValue]); CHECK(CSAIReplyValidateState(portable,@"alice",&error)); CHECK(!CSAIReplyValidateState(portable,@"bob",&error));
    NSMutableDictionary *bad=[store.configuration mutableCopy]; bad[@"apiKey"]=@"must-never-persist"; CHECK(![store saveConfiguration:bad error:&error]);
    bad=[store.configuration mutableCopy]; bad[@"defaultPreset"]=@"missing"; CHECK(!CSAIReplyValidateConfiguration(bad,&error));
    bad=[store.configuration mutableCopy]; bad[@"presets"]=@[]; CHECK(!CSAIReplyValidateConfiguration(bad,&error));
    bad=[store.configuration mutableCopy]; bad[@"conversations"]=@{@"contact":@{@"enabled":@YES,@"presetID":@"missing"}}; CHECK(!CSAIReplyValidateConfiguration(bad,&error));
    for(NSString *endpoint in @[@"http://example.invalid/a",@"https://user:pass@example.invalid/a",@"https://example.invalid/a#fragment",@"https:///a",@" https://example.invalid/a",@"https://example.invalid:0/a"]) CHECK(!CSAIValidateEndpoint(endpoint,&error));
    CHECK(CSAIValidateEndpoint(@"https://example.invalid/chat?version=1",&error));
    NSMutableDictionary *changed=[store.configuration mutableCopy]; NSString *connection=CSAIConnectionIdentifier(changed); changed[@"model"]=@"other"; CHECK(![connection isEqual:CSAIConnectionIdentifier(changed)]); changed=[store.configuration mutableCopy]; changed[@"credentialRevision"]=@"other"; CHECK(![connection isEqual:CSAIConnectionIdentifier(changed)]);
    // A seven-day-old ledger entry expires, and at most 5,000 recent identities persist.
    NSMutableDictionary *pruned=[state mutableCopy]; pruned[@"handled"]=@{@"expired":[NSDate dateWithTimeIntervalSinceNow:-8*86400]}; CHECK([CSAIReplyStore replaceState:pruned atURL:url account:@"alice" error:&error]); CHECK([store load]); CHECK(![store hasHandledMessageID:@"expired"]);
    NSMutableArray *identities=[NSMutableArray array]; for(NSUInteger i=0;i<5000;i++) [identities addObject:[NSString stringWithFormat:@"message-%lu",(unsigned long)i]];
    CHECK([store claimMessageIDs:identities error:&error]); CHECK([store claimMessageIDs:@[@"new"] error:&error]); state=[CSAIReplyStore readStateAtURL:url account:@"alice" error:&error]; CHECK([state[@"handled"] count]==5000); CHECK(!state[@"handled"][@"expired"]); CHECK(state[@"handled"][@"new"]);
    // Corruption never gets silently replaced or rewritten by subsequent operations.
    NSData *corrupt=[@"invalid original bytes" dataUsingEncoding:NSUTF8StringEncoding]; CHECK([corrupt writeToURL:url atomically:YES]); CHECK(![reload load]); CHECK(!reload.ready); CHECK(![reload saveConfiguration:CSAIReplyDefaultConfiguration() error:&error]); CHECK([[NSData dataWithContentsOfURL:url] isEqual:corrupt]);
    // Failed durable claims fail closed and never update the in-memory ledger.
    NSURL *blocker=[root URLByAppendingPathComponent:@"file"]; CHECK([corrupt writeToURL:blocker atomically:YES]);
    CSAIReplyStore *blocked=[[CSAIReplyStore alloc] initWithURL:[blocker URLByAppendingPathComponent:@"state.plist"] account:@"alice"]; CHECK(![blocked load]); CHECK(blocked.error); CHECK(![blocked claimMessageIDs:@[@"blocked"] error:&error]); CHECK(!blocked.ready); CHECK(![blocked hasHandledMessageID:@"blocked"]);
    // A write failure after a successful absent-file load also closes the send gate.
    NSURL *lateParent=[root URLByAppendingPathComponent:@"late-file"];
    CSAIReplyStore *lateFailure=[[CSAIReplyStore alloc] initWithURL:[lateParent URLByAppendingPathComponent:@"state.plist"] account:@"alice"];
    CHECK([lateFailure load]); CHECK([corrupt writeToURL:lateParent atomically:YES]);
    CHECK(![lateFailure claimMessageIDs:@[@"never-send"] error:&error]); CHECK(!lateFailure.ready); CHECK(![lateFailure hasHandledMessageID:@"never-send"]);
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
    puts("AIReplyStoreTests passed: defaults, validation, atomic claims, bounds, account isolation, portable redaction, corruption and failed writes");
} return 0; }
