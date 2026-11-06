#import <Foundation/Foundation.h>
#import "CSCloseFriendStore.h"
#import "CSCloseFriendCrypto.h"
#import "CSCloseFriendRuntime.h"
#import "CSPluginStorage.h"
#import <CommonCrypto/CommonCrypto.h>
#import <sys/stat.h>
#import <unistd.h>
#import "ManagerKeyGuardUnderTest.h"
static NSUInteger checks;
#define CHECK(...) do { checks++; if(!(__VA_ARGS__)) { fprintf(stderr,"FAIL line %d: %s\n",__LINE__,#__VA_ARGS__); exit(1); } } while(0)
@interface FaultMigration : CSPluginDirectoryMigration
@property(nonatomic) NSInteger failureCode;
@end
@implementation FaultMigration
- (BOOL)migrate:(NSError **)error {
    if(!self.failureCode)return [super migrate:error];
    if(error)*error=[NSError errorWithDomain:CSPluginStorageErrorDomain code:self.failureCode userInfo:nil];
    return NO;
}
@end
static NSURL *StateURL(NSURL *root,NSString *account) { return [root URLByAppendingPathComponent:[NSString stringWithFormat:@"state-%@.bin",CSAccountDigest(account)]]; }
static NSDictionary *State(NSString *friend) { return @{@"profile":@{@"enabled":@YES,@"friends":@[friend],@"groups":@[],@"options":@{}},@"muteRecords":@{@"historical":@{@"before":@NO,@"applied":@YES}}}; }
static CSCloseFriendRuntime *Runtime(CSCloseFriendStore *store,NSMutableDictionary *credentials) {
    return [[CSCloseFriendRuntime alloc] initWithStore:store wallClock:^NSTimeInterval{return 10000;} elapsedClock:^NSTimeInterval{return 5000;} credentialReader:^NSDictionary *(NSString *account,__unused NSError **error){return credentials[account];} credentialWriter:^BOOL(NSString *account,NSDictionary *value,__unused NSError **error){credentials[account]=[value copy];return YES;}];
}
int main(void) { @autoreleasepool {
    NSFileManager *fm=NSFileManager.defaultManager;
    NSURL *sandbox=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString] isDirectory:YES];
    NSURL *library=[sandbox URLByAppendingPathComponent:@"Library" isDirectory:YES];
    CSPluginDirectoryMigration *migration=[[CSPluginDirectoryMigration alloc] initWithLibrary:library leaf:@"CloseFriends"];
    CHECK([migration.destinationRoot.path hasSuffix:@"Library/Preferences/WeChatImprove/CloseFriends"]);
    CHECK([migration.legacyRoot.path hasSuffix:@"Library/Application Support/WeChatImprove/CloseFriends"]);
    NSDictionary *keys=@{@"alice":CSCloseFriendRandomBytes(64,NULL),@"bob":CSCloseFriendRandomBytes(64,NULL)};
    __block NSUInteger keyCalls=0;
    CSCloseFriendKeyProvider provider=^NSData *(NSString *account,__unused NSError **error){keyCalls++;return keys[account];};
    CSCloseFriendStore *legacy=[[CSCloseFriendStore alloc] initWithRoot:migration.legacyRoot keyProvider:provider];
    NSMutableDictionary *credentials=[NSMutableDictionary new];
    CSCloseFriendRuntime *oldRuntime=Runtime(legacy,credentials);
    [oldRuntime synchronizeAccount:@"alice" epoch:1 suspended:NO];
    CHECK([oldRuntime setPassword:@"alice-password" token:oldRuntime.authenticationToken error:NULL]);
    CHECK([oldRuntime updateProfile:State(@"alice-friend")[@"profile"] error:NULL]);
    [oldRuntime synchronizeAccount:@"bob" epoch:2 suspended:NO];
    CHECK([oldRuntime setPassword:@"246810" token:oldRuntime.authenticationToken error:NULL]);
    CHECK([oldRuntime updateProfile:State(@"bob-friend")[@"profile"] error:NULL]);
    NSDictionary *credentialBefore=[credentials copy];
    NSData *aliceCipher=[NSData dataWithContentsOfURL:StateURL(migration.legacyRoot,@"alice")];
    NSData *bobCipher=[NSData dataWithContentsOfURL:StateURL(migration.legacyRoot,@"bob")];
    CHECK(aliceCipher && bobCipher && ![aliceCipher isEqual:bobCipher]);
    CHECK(!CSCanCreatePolicyKey(migration,@"alice") && !CSCanCreatePolicyKey(migration,@"bob"));
    CSCloseFriendStore *store=[[CSCloseFriendStore alloc] initWithMigration:migration keyProvider:provider];
    store.readKeyProvider=provider;
    CHECK([store.root isEqual:migration.destinationRoot]);
    CSCloseFriendRuntime *runtime=Runtime(store,credentials);
    [runtime synchronizeAccount:@"alice" epoch:3 suspended:NO];
    CHECK(![runtime snapshotForEpoch:3 suspended:NO].blocked && !runtime.isAuthorized);
    CHECK([runtime.currentProfile[@"friends"] isEqual:@[@"alice-friend"]]);
    CHECK([credentials isEqual:credentialBefore]);
    CHECK([[NSData dataWithContentsOfURL:StateURL(migration.destinationRoot,@"alice")] isEqual:aliceCipher]);
    CHECK([[NSData dataWithContentsOfURL:StateURL(migration.destinationRoot,@"bob")] isEqual:bobCipher]);
    CHECK(![fm fileExistsAtPath:migration.legacyRoot.path]);
    CHECK(!CSCanCreatePolicyKey(migration,@"alice") && CSCanCreatePolicyKey(migration,@"brand-new"));
    CHECK([runtime authenticatePassword:@"alice-password" token:runtime.authenticationToken error:NULL] && runtime.isAuthorized);
    NSDictionary *aliceToken=runtime.authenticationToken;
    [runtime synchronizeAccount:@"bob" epoch:4 suspended:NO];
    CHECK(!runtime.isAuthorized && [runtime.currentProfile[@"friends"] isEqual:@[@"bob-friend"]]);
    CHECK(![runtime authenticatePassword:@"alice-password" token:aliceToken error:NULL]);
    CHECK([runtime authenticatePassword:@"246810" token:runtime.authenticationToken error:NULL]);
    [runtime setActive:NO]; [runtime setActive:YES];
    CHECK(!runtime.isAuthorized);
    [runtime synchronizeAccount:@"alice" epoch:5 suspended:NO];
    CHECK([runtime authenticatePassword:@"alice-password" token:runtime.authenticationToken error:NULL]);
    CHECK([store saveState:State(@"updated") forAccountID:@"alice" error:NULL]);
    CHECK([store loadStateForAccountID:@"alice" error:NULL][@"muteRecords"]!=nil);
    CHECK(![fm fileExistsAtPath:migration.legacyRoot.path]);

    // Migration IO failures may read existing ciphertext, but cannot write either copy or invent a missing account.
    FaultMigration *failure=[[FaultMigration alloc] initWithLibrary:[sandbox URLByAppendingPathComponent:@"FailureLibrary"] leaf:@"CloseFriends"];
    CSCloseFriendStore *failureLegacy=[[CSCloseFriendStore alloc] initWithRoot:failure.legacyRoot keyProvider:provider];
    CHECK([failureLegacy saveState:State(@"preserved") forAccountID:@"alice" error:NULL]);
    NSData *preserved=[NSData dataWithContentsOfURL:StateURL(failure.legacyRoot,@"alice")];
    failure.failureCode=1;
    CSCloseFriendStore *fallback=[[CSCloseFriendStore alloc] initWithMigration:failure keyProvider:provider]; fallback.readKeyProvider=provider;
    NSError *error=nil;
    CHECK([[fallback loadStateForAccountID:@"alice" error:&error][@"profile"][@"friends"] isEqual:@[@"preserved"]] && !error);
    NSUInteger calls=keyCalls;
    CHECK(![fallback saveState:State(@"lost") forAccountID:@"alice" error:&error] && [error.domain isEqual:CSPluginStorageErrorDomain]);
    CHECK(keyCalls==calls && [[NSData dataWithContentsOfURL:StateURL(failure.legacyRoot,@"alice")] isEqual:preserved]);
    CHECK(![fm fileExistsAtPath:failure.destinationRoot.path]);
    error=nil; CHECK(![fallback loadStateForAccountID:@"absent" error:&error] && [error.domain isEqual:CSPluginStorageErrorDomain]);
    CHECK(keyCalls==calls);
    CSCloseFriendRuntime *blocked=Runtime(fallback,credentials); [blocked synchronizeAccount:@"absent" epoch:6 suspended:NO];
    CHECK([blocked snapshotForEpoch:6 suspended:NO].blocked && !blocked.authenticationToken);
    failure.failureCode=0;
    CHECK([fallback loadStateForAccountID:@"alice" error:NULL]!=nil);
    CHECK(![fm fileExistsAtPath:failure.legacyRoot.path]);
    CHECK([[NSData dataWithContentsOfURL:StateURL(failure.destinationRoot,@"alice")] isEqual:preserved]);
    CHECK([fallback saveState:State(@"retry") forAccountID:@"alice" error:NULL]);

    // Conflicting copies hold protection rather than selecting whichever directory happens to be enumerated first.
    CSPluginDirectoryMigration *conflict=[[CSPluginDirectoryMigration alloc] initWithLibrary:[sandbox URLByAppendingPathComponent:@"ConflictLibrary"] leaf:@"CloseFriends"];
    CSCloseFriendStore *conflictOld=[[CSCloseFriendStore alloc] initWithRoot:conflict.legacyRoot keyProvider:provider];
    CSCloseFriendStore *conflictNew=[[CSCloseFriendStore alloc] initWithRoot:conflict.destinationRoot keyProvider:provider];
    CHECK([conflictOld saveState:State(@"old") forAccountID:@"alice" error:NULL]);
    CHECK([conflictNew saveState:State(@"new") forAccountID:@"alice" error:NULL]);
    NSData *oldConflict=[NSData dataWithContentsOfURL:StateURL(conflict.legacyRoot,@"alice")], *newConflict=[NSData dataWithContentsOfURL:StateURL(conflict.destinationRoot,@"alice")];
    CSCloseFriendStore *conflictStore=[[CSCloseFriendStore alloc] initWithMigration:conflict keyProvider:provider]; conflictStore.readKeyProvider=provider;
    calls=keyCalls; error=nil;
    CHECK(![conflictStore loadStateForAccountID:@"alice" error:&error] && [error.domain isEqual:CSPluginStorageErrorDomain] && error.code==CSPluginStorageErrorConflict);
    CHECK(![conflictStore saveState:State(@"overwrite") forAccountID:@"alice" error:NULL] && keyCalls==calls);
    CHECK([[NSData dataWithContentsOfURL:StateURL(conflict.legacyRoot,@"alice")] isEqual:oldConflict]);
    CHECK([[NSData dataWithContentsOfURL:StateURL(conflict.destinationRoot,@"alice")] isEqual:newConflict]);
    blocked=Runtime(conflictStore,credentials); [blocked synchronizeAccount:@"alice" epoch:7 suspended:NO];
    CHECK([blocked snapshotForEpoch:7 suspended:NO].blocked && !blocked.authenticationToken);

    // Copy raw bytes, even corrupt bytes. Decrypt failures must still be rejected after relocation.
    CSPluginDirectoryMigration *corrupt=[[CSPluginDirectoryMigration alloc] initWithLibrary:[sandbox URLByAppendingPathComponent:@"CorruptLibrary"] leaf:@"CloseFriends"];
    CHECK([fm createDirectoryAtURL:corrupt.legacyRoot withIntermediateDirectories:YES attributes:nil error:NULL]);
    NSData *broken=[@"corrupted existing ciphertext" dataUsingEncoding:NSUTF8StringEncoding];
    CHECK([broken writeToURL:StateURL(corrupt.legacyRoot,@"alice") options:0 error:NULL]);
    CSCloseFriendStore *corruptStore=[[CSCloseFriendStore alloc] initWithMigration:corrupt keyProvider:provider]; corruptStore.readKeyProvider=provider;
    CHECK(![corruptStore loadStateForAccountID:@"alice" error:NULL]);
    CHECK(![corruptStore saveState:State(@"overwrite") forAccountID:@"alice" error:NULL]);
    CHECK([[NSData dataWithContentsOfURL:StateURL(corrupt.destinationRoot,@"alice")] isEqual:broken]);
    CHECK(![fm fileExistsAtPath:corrupt.legacyRoot.path]);

    // Reading never invokes the key-creating provider, even if the file disappears after read succeeds.
    __block NSUInteger creations=0;
    CSCloseFriendStore *readonly=[[CSCloseFriendStore alloc] initWithMigration:migration keyProvider:^NSData *(__unused NSString *account,__unused NSError **err){creations++;return keys[@"alice"];}];
    readonly.readKeyProvider=^NSData *(__unused NSString *account,NSError **err){
        [fm removeItemAtURL:StateURL(migration.destinationRoot,@"alice") error:NULL];
        if(err)*err=[NSError errorWithDomain:@"MissingExistingKey" code:1 userInfo:nil]; return nil;
    };
    error=nil; CHECK(![readonly loadStateForAccountID:@"alice" error:&error] && [error.domain isEqual:@"MissingExistingKey"] && creations==0);
    CHECK(CSCanCreatePolicyKey(migration,@"alice"));

    // Extract the real Manager key guard: dangling links and lstat errors must forbid creating a replacement key.
    NSURL *link=StateURL(migration.destinationRoot,@"alice");
    CHECK(symlink("missing-ciphertext",link.path.fileSystemRepresentation)==0);
    CHECK(!CSCanCreatePolicyKey(migration,@"alice"));
    CHECK(unlink(link.path.fileSystemRepresentation)==0);
    CSPluginDirectoryMigration *badRoot=[[CSPluginDirectoryMigration alloc] initWithLibrary:[sandbox URLByAppendingPathComponent:@"BadRootLibrary"] leaf:@"CloseFriends"];
    CHECK([fm createDirectoryAtURL:badRoot.legacyRoot.URLByDeletingLastPathComponent withIntermediateDirectories:YES attributes:nil error:NULL]);
    CHECK([broken writeToURL:badRoot.legacyRoot options:0 error:NULL]);
    CHECK(!CSCanCreatePolicyKey(badRoot,@"alice"));
    CHECK([fm removeItemAtURL:sandbox error:NULL]);
    printf("CloseFriendMigrationTests: %lu checks passed\n",(unsigned long)checks);
} return 0; }
