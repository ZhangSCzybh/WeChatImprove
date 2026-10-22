#import <Foundation/Foundation.h>
#import "CSBackupEngine.h"
#import "CSBackupCodec.h"

// Diagnostic reproduction of the unmodified production implementation.
// Every file and preference domain is an isolated, randomly named fixture.
static NSUInteger checks;
static void Check(BOOL condition, NSString *message) {
    checks++;
    if (!condition) {
        fprintf(stderr, "FAIL: %s\n", message.UTF8String);
        exit(1);
    }
}
static NSDictionary *Snapshot(NSString *kind, NSUInteger time) {
    return @{@"magic":@"WeChatImproveBackup", @"formatVersion":@2,
             @"id":NSUUID.UUID.UUIDString, @"name":@"retention audit fixture",
             @"createdAt":[NSDate dateWithTimeIntervalSince1970:time], @"kind":kind,
             @"source":@{@"account":@"audit-account", @"installationID":@"audit-install", @"pluginVersion":@"audit"},
             @"fields":@[], @"assets":@{}, @"warnings":@[]};
}
static NSURL *File(CSBackupStore *store, NSDictionary *snapshot, NSString *extension) {
    return [store.root URLByAppendingPathComponent:[snapshot[@"id"] stringByAppendingPathExtension:extension]];
}
static CSBackupEngine *Engine(CSBackupStore *store) {
    NSMutableDictionary *defaults=[NSMutableDictionary dictionary], *domains=[NSMutableDictionary dictionary];
    for (NSString *alias in @[@"standard", @"legacy", @"layout"]) {
        NSString *domain=[@"wechat.retention.audit." stringByAppendingString:NSUUID.UUID.UUIDString];
        domains[alias]=domain;
        defaults[alias]=[[NSUserDefaults alloc] initWithSuiteName:domain];
    }
    CSBackupEngine *engine=[[CSBackupEngine alloc] initWithDefaults:defaults domains:domains store:store resources:[store.root URLByAppendingPathComponent:@"resources"]];
    engine.context=^{return @{@"account":@"audit-account", @"installationID":@"audit-install", @"pluginVersion":@"audit"};};
    return engine;
}
static NSDictionary *Probe(NSString *kind, NSString *fault, NSString *trigger, BOOL expectedExists) {
    NSURL *root=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:[@"wechat-retention-audit-" stringByAppendingString:NSUUID.UUID.UUIDString]] isDirectory:YES];
    CSBackupStore *store=[[CSBackupStore alloc] initWithRoot:root];
    NSFileManager *fm=NSFileManager.defaultManager;
    NSError *error=nil;
    NSDictionary *target=Snapshot(kind, 1);
    Check([store publish:target error:&error], @"publish target");
    Check([store setMetadata:@{@"favorite":@YES, @"name":@"favorite fixture"} identifier:target[@"id"] error:&error], @"persist favorite");
    Check([[store metadata:target[@"id"]][@"favorite"] boolValue], @"favorite readable before fault");
    for (NSUInteger n=0; n<25; n++) {
        NSString *newKind=[kind isEqual:@"protection"] ? (n%2 ? @"upgrade" : @"protection") : @"automatic";
        Check([store publish:Snapshot(newKind, 100+n) error:&error], @"publish newer snapshot");
    }
    NSURL *meta=File(store, target, @"meta");
    if ([fault isEqual:@"corrupt"]) {
        Check([[ @"not a property list" dataUsingEncoding:NSUTF8StringEncoding] writeToURL:meta atomically:YES], @"corrupt isolated metadata");
    } else if ([fault isEqual:@"missing"]) {
        Check([fm removeItemAtURL:meta error:&error], @"remove isolated metadata");
    } else if ([fault isEqual:@"oversize"]) {
        Check([store setMetadata:@{@"favorite":@YES, @"padding":[NSMutableData dataWithLength:16385]} identifier:target[@"id"] error:&error], @"writer accepts metadata larger than reader limit");
    } else if ([fault isEqual:@"nonregular"]) {
        Check([fm removeItemAtURL:meta error:&error] && [fm createDirectoryAtURL:meta withIntermediateDirectories:NO attributes:nil error:&error], @"simulate metadata read rejection with isolated directory");
    }
    BOOL favoriteVisible=[[store metadata:target[@"id"]][@"favorite"] boolValue];
    error=nil;
    BOOL succeeded=NO;
    if ([trigger isEqual:@"upgrade-save"]) {
        succeeded=[Engine(store) save:@"simulated version update" kind:@"upgrade" error:&error]!=nil;
    } else if ([trigger isEqual:@"manual-remove"]) {
        succeeded=[store remove:target[@"id"] error:&error];
    } else {
        succeeded=[store prune:&error];
    }
    BOOL exists=[fm fileExistsAtPath:File(store,target,@"wcbak").path];
    Check(succeeded && error==nil, @"operation reports success without error");
    Check(exists==expectedExists, @"observed current behavior matches reproduction");
    NSDictionary *result=@{@"kind":kind, @"metadataCondition":fault, @"trigger":trigger,
                           @"favoriteVisibleToPrune":@(favoriteVisible), @"snapshotExistsAfterOperation":@(exists),
                           @"metadataExistsAfterOperation":@([fm fileExistsAtPath:meta.path]), @"operationReportedError":@NO};
    Check([fm removeItemAtURL:root error:&error], @"clean isolated fixture directory");
    return result;
}
static NSDictionary *HiddenProbe(void) {
    NSURL *root=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:[@"wechat-retention-audit-" stringByAppendingString:NSUUID.UUID.UUIDString]] isDirectory:YES];
    CSBackupStore *store=[[CSBackupStore alloc] initWithRoot:root];
    NSDictionary *snapshot=Snapshot(@"automatic", 1);
    NSError *error=nil;
    Check([store publish:snapshot error:&error], @"publish hidden fixture");
    Check([store setMetadata:@{@"favorite":@YES} identifier:snapshot[@"id"] error:&error], @"favorite hidden fixture");
    NSURL *file=File(store,snapshot,@"wcbak");
    Check([[@"invalid snapshot fixture" dataUsingEncoding:NSUTF8StringEncoding] writeToURL:file atomically:YES], @"simulate invalid snapshot");
    error=nil;
    NSArray *listed=[store snapshots:&error];
    BOOL listingReportedError=error!=nil;
    error=nil;
    BOOL pruningSucceeded=[store prune:&error];
    Check(listed.count==0 && listingReportedError && !pruningSucceeded && error!=nil, @"invalid snapshot is hidden and blocks pruning");
    Check([NSFileManager.defaultManager fileExistsAtPath:file.path], @"hidden snapshot remains on disk");
    NSDictionary *result=@{@"scenario":@"invalid-snapshot-hidden", @"listedCount":@(listed.count),
                           @"snapshotExistsOnDisk":@YES, @"favoriteMetadataIntact":@YES,
                           @"listingReportedError":@(listingReportedError), @"pruningSucceeded":@(pruningSucceeded)};
    Check([NSFileManager.defaultManager removeItemAtURL:root error:NULL], @"clean hidden fixture");
    return result;
}
int main(void) { @autoreleasepool {
    NSArray *results=@[
        Probe(@"automatic", @"healthy", @"prune", YES),
        Probe(@"automatic", @"corrupt", @"prune", NO),
        Probe(@"automatic", @"missing", @"prune", NO),
        Probe(@"automatic", @"oversize", @"prune", NO),
        Probe(@"automatic", @"nonregular", @"prune", NO),
        Probe(@"automatic", @"healthy", @"upgrade-save", YES),
        Probe(@"automatic", @"corrupt", @"upgrade-save", NO),
        Probe(@"protection", @"healthy", @"prune", YES),
        Probe(@"protection", @"corrupt", @"upgrade-save", NO),
        Probe(@"manual", @"corrupt", @"prune", YES),
        Probe(@"manual", @"healthy", @"upgrade-save", YES),
        Probe(@"manual", @"corrupt", @"upgrade-save", YES),
        Probe(@"automatic", @"healthy", @"manual-remove", NO),
        HiddenProbe()
    ];
    NSDictionary *output=@{@"checksPassed":@(checks), @"scenarioCount":@(results.count), @"results":results};
    NSData *json=[NSJSONSerialization dataWithJSONObject:output options:NSJSONWritingPrettyPrinted|NSJSONWritingSortedKeys error:NULL];
    fwrite(json.bytes, 1, json.length, stdout);
    fputc('\n', stdout);
} return 0; }
