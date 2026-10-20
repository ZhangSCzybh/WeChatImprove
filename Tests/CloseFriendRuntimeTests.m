#import <Foundation/Foundation.h>
#import "CSCloseFriendRuntime.h"
#import "CSCloseFriendAccount.h"
#import "CSCloseFriendCrypto.h"
#import "CSCloseFriendSignatures.h"
static NSUInteger checks;
#define Check(value,...) do { checks++; if(!(value)){fprintf(stderr,"FAIL %lu: %s\n",(unsigned long)checks,[@(__VA_ARGS__) UTF8String]);exit(1);} } while(0)
@interface CSSignatureFixture:NSObject
- (id)object:(id)object;
- (BOOL)flag:(NSUInteger)value;
@end
@implementation CSSignatureFixture
- (id)object:(id)object { return object; }
- (BOOL)flag:(NSUInteger)value { return value!=0; }
@end
static NSString *authoritativeName;
static NSUInteger fallbackReads;
@interface CSFakeAuthority:NSObject
+ (id)currentUserName;
@end
@implementation CSFakeAuthority
+ (id)currentUserName { return authoritativeName; }
@end
@interface CSFakeWrongAuthority:NSObject
+ (NSUInteger)currentUserName;
@end
@implementation CSFakeWrongAuthority
+ (NSUInteger)currentUserName { return 123; }
@end
@interface CSFakeContact:NSObject
- (NSString *)m_nsUsrName;
@end
@implementation CSFakeContact
- (NSString *)m_nsUsrName { return @"cached-account"; }
@end
@interface CSFakeService:NSObject
+ (instancetype)defaultCenter;
- (id)getService:(Class)cls;
- (id)getSelfContact;
@end
@implementation CSFakeService
+ (instancetype)defaultCenter { fallbackReads++; return [self new]; }
- (id)getService:(Class)cls { return self; }
- (id)getSelfContact { return [CSFakeContact new]; }
@end
@interface CSFakeEmptyContext:NSObject
+ (id)currentContext;
@end
@implementation CSFakeEmptyContext
+ (id)currentContext { return nil; }
@end
int main(void) { @autoreleasepool {
    __block Class authority=CSFakeAuthority.class;
    Class (^lookup)(NSString *)=^Class(NSString *name){
        if([name isEqual:@"MMContext"])return authority;
        if([name isEqual:@"MMServiceCenter"] || [name isEqual:@"CContactMgr"])return CSFakeService.class;
        return Nil;
    };
    authoritativeName=@"current-account";
    Check([CSCloseFriendResolveAccount(lookup) isEqual:@"current-account"],"authoritative account takes precedence over cached default service");
    authoritativeName=nil;
    Check(!CSCloseFriendResolveAccount(lookup) && fallbackReads==0,"authoritative nil is logged out and never reads cached self");
    authority=CSFakeWrongAuthority.class;
    Check(!CSCloseFriendResolveAccount(lookup) && fallbackReads==0,"unknown authoritative getter signature fails closed");
    authority=CSFakeEmptyContext.class;
    Check(!CSCloseFriendResolveAccount(lookup) && fallbackReads==0,"available current context returning nil cannot fall back to default center");
    authority=Nil;
    Check([CSCloseFriendResolveAccount(lookup) isEqual:@"cached-account"] && fallbackReads==1,"legacy fallback only when authoritative accessors absent");
    NSURL *root=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString] isDirectory:YES];
    __block NSTimeInterval now=10000; __block BOOL unavailable=NO, failWrite=NO;
    NSMutableDictionary *credentials=[NSMutableDictionary new]; NSData *key=CSCloseFriendRandomBytes(64,NULL);
    CSCloseFriendStore *store=[[CSCloseFriendStore alloc] initWithRoot:root keyProvider:^NSData *(__unused NSString *account,NSError **error){
        if(unavailable) { if(error)*error=[NSError errorWithDomain:@"FakeKeychain" code:1 userInfo:nil]; return nil; } return key;
    }];
    CSCloseFriendCredentialReader reader=^NSDictionary *(NSString *account,NSError **error){
        if(unavailable) { if(error)*error=[NSError errorWithDomain:@"FakeKeychain" code:1 userInfo:nil];return nil; } return credentials[account];
    };
    CSCloseFriendCredentialWriter writer=^BOOL(NSString *account,NSDictionary *credential,NSError **error){
        if(failWrite) { if(error)*error=[NSError errorWithDomain:@"FakeKeychain" code:2 userInfo:nil];return NO; } credentials[account]=[credential copy];return YES;
    };
    CSCloseFriendRuntime *(^makeRuntime)(void)=^{ return [[CSCloseFriendRuntime alloc] initWithStore:store clock:^NSTimeInterval{return now;} credentialReader:reader credentialWriter:writer]; };
    CSCloseFriendRuntime *runtime=makeRuntime();
    Check([runtime snapshotForEpoch:0 suspended:NO].blocked,"uninitialized runtime protects surfaces");
    [runtime synchronizeAccount:@"alice" epoch:1 suspended:NO];
    Check(![runtime snapshotForEpoch:1 suspended:NO].blocked,"missing data is a new disabled account");
    Check(!runtime.hasCredential && !runtime.isAuthorized,"new account has no implicit authorization");
    Check(![runtime saveMuteRecords:@{} account:@"alice" epoch:1 error:NULL],"journal cannot create persisted account state before credential setup");
    NSMutableDictionary *profile=[runtime.currentProfile mutableCopy]; profile[@"enabled"]=@YES; profile[@"friends"]=@[@"protected"];
    Check(![runtime updateProfile:profile error:NULL],"enable requires password and authorization");
    NSDictionary *token=runtime.authenticationToken;
    Check(![runtime setPassword:@"12345" token:token error:NULL],"short password rejected");
    Check(![runtime setPassword:@"abc123" token:token error:NULL],"mixed six-character password rejected");
    Check(![runtime setPassword:@"abcdef7" token:token error:NULL],"mixed seven-character password rejected");
    Check(![runtime setPassword:@"１２３４５６" token:token error:NULL],"six non-ASCII digits rejected");
    Check([runtime setPassword:@"correct-password" token:token error:NULL],"setup stores verifier using injected provider");
    Check(runtime.hasCredential && runtime.isAuthorized,"setup grants temporary access");
    NSMutableDictionary *options=[profile[@"options"] mutableCopy]; options[@"biometric"]=@YES; profile[@"options"]=options;
    Check([runtime updateProfile:profile error:NULL],"authenticated profile write succeeds");
    Check([runtime snapshotForEpoch:1 suspended:NO].revealed,"snapshot publishes reveal");
    Check([runtime snapshotForEpoch:1 suspended:NO]==[runtime snapshotForEpoch:1 suspended:NO],"stable reads reuse published immutable snapshot");
    Check([[runtime snapshotForEpoch:1 suspended:NO] silencesSession:@"protected" sender:nil],"reveal preserves silence");
    Check([runtime saveMuteRecords:@{@"protected":@{@"original":@NO}} account:@"alice" epoch:1 error:NULL],"journal writes independently");
    Check([runtime.currentProfile[@"friends"] isEqual:@[@"protected"]],"journal preserves profile");
    [runtime lock]; token=runtime.authenticationToken;
    for(int i=0;i<5;i++)Check(![runtime authenticatePassword:@"wrong-password" token:token error:NULL],"wrong password fails");
    Check(![runtime authenticatePassword:@"correct-password" token:token error:NULL],"cooldown rejects correct password");
    Check(![runtime completeBiometricWithToken:token],"cooldown cannot be bypassed by biometric");
    CSCloseFriendRuntime *reloaded=makeRuntime(); [reloaded synchronizeAccount:@"alice" epoch:1 suspended:NO];
    Check(![reloaded authenticatePassword:@"correct-password" token:reloaded.authenticationToken error:NULL],"cooldown survives runtime recreation");
    now+=31; Check([runtime authenticatePassword:@"correct-password" token:token error:NULL],"password succeeds after cooldown");
    Check(![runtime isTokenCurrent:token],"successful authentication consumes token");
    NSUInteger revealedRevision=[runtime snapshotForEpoch:1 suspended:NO].revision;
    now+=301; Check(!runtime.isAuthorized && ![runtime snapshotForEpoch:1 suspended:NO].revealed,"clock expiry removes authorization immediately");
    Check([runtime snapshotForEpoch:1 suspended:NO].revision>revealedRevision,"expiry publishes a new policy revision");
    token=runtime.authenticationToken; [runtime setActive:NO]; [runtime setActive:YES];
    Check(![runtime completeBiometricWithToken:token],"late biometric reply after background fails");
    Check(![runtime authenticatePassword:@"correct-password" token:token error:NULL],"late password reply after background fails");
    token=runtime.authenticationToken; Check([runtime completeBiometricWithToken:token],"current biometric authorization succeeds");
    [runtime lock]; Check(![runtime updateProfile:profile error:NULL],"locked settings cannot mutate profile");
    Check([runtime saveMuteRecords:@{@"protected":@{@"original":@YES}} account:@"alice" epoch:1 error:NULL],"trusted journal write remains possible while locked");
    Check(![runtime saveMuteRecords:@{} account:@"bob" epoch:1 error:NULL],"cross-account journal write rejected");
    Check(![runtime saveMuteRecords:@{} account:@"alice" epoch:0 error:NULL],"stale journal epoch rejected");
    Check([runtime snapshotForEpoch:2 suspended:NO].blocked,"immediate external epoch mismatch blocks snapshot");
    Check(![[runtime snapshotForEpoch:2 suspended:NO] silencesSession:@"protected" sender:nil],"epoch boundary cannot silence using prior account membership");
    Check(![[runtime snapshotForEpoch:2 suspended:NO] rejectsCaller:@"protected" chatRoom:nil video:NO],"epoch boundary cannot reject calls using prior account membership");
    Check(![[runtime snapshotForEpoch:1 suspended:YES] silencesSession:@"protected" sender:nil],"suspension cannot silence using prior account membership");
    Check(![[runtime snapshotForEpoch:1 suspended:YES] rejectsCaller:@"protected" chatRoom:nil video:YES],"suspension cannot reject calls using prior account membership");
    Check([runtime snapshotForEpoch:1 suspended:YES].blocked,"external suspension blocks snapshot");
    token=runtime.authenticationToken; [runtime synchronizeAccount:@"bob" epoch:2 suspended:NO];
    Check(![runtime completeBiometricWithToken:token],"old-account biometric reply rejected");
    Check(!runtime.hasCredential && ![runtime.currentProfile[@"enabled"] boolValue],"accounts do not share verifiers or profile");
    Check(![runtime setPassword:@"correct-password" token:token error:NULL],"old setup token cannot write another account");
    Check([runtime setPassword:@"123456" token:runtime.authenticationToken error:NULL],"six ASCII digit PIN is permitted");
    [runtime synchronizeAccount:@"alice" epoch:3 suspended:NO];
    Check([runtime.currentProfile[@"friends"] isEqual:@[@"protected"]],"account return loads original membership");
    Check([runtime.muteRecords[@"protected"][@"original"] boolValue],"account return loads independent durable journal");
    token=runtime.authenticationToken; Check([runtime authenticatePassword:@"correct-password" token:token error:NULL],"account credential reloads");
    profile=[runtime.currentProfile mutableCopy]; profile[@"groups"]=@[@"room@chatroom"];
    Check([runtime updateProfile:profile error:NULL],"profile edit succeeds after reload");
    Check([runtime.muteRecords[@"protected"][@"original"] boolValue],"profile edit preserves journal");
    unavailable=YES; [runtime synchronizeAccount:@"alice" epoch:4 suspended:NO];
    Check([runtime snapshotForEpoch:4 suspended:NO].blocked && !runtime.authenticationToken,"unavailable key blocks auth and policy");
    unavailable=NO; [runtime synchronizeAccount:@"alice" epoch:4 suspended:NO];
    Check(![runtime snapshotForEpoch:4 suspended:NO].blocked,"key availability can recover existing data");
    [runtime setActive:NO]; Check(!runtime.authenticationToken,"inactive account cannot start auth"); [runtime setActive:YES];
    failWrite=YES; Check(![runtime authenticatePassword:@"wrong-password" token:runtime.authenticationToken error:NULL],"failed credential journal write rejected");
    Check([runtime snapshotForEpoch:4 suspended:NO].blocked,"credential write failure holds protection"); failWrite=NO;
    [runtime synchronizeAccount:@"alice" epoch:4 suspended:NO];
    NSDictionary *savedCredential=credentials[@"alice"]; [credentials removeObjectForKey:@"alice"];
    [runtime synchronizeAccount:@"alice" epoch:5 suspended:NO];
    Check([runtime snapshotForEpoch:5 suspended:NO].blocked,"missing verifier over persisted state cannot become new setup");
    credentials[@"alice"]=savedCredential; [runtime synchronizeAccount:@"alice" epoch:5 suspended:NO];
    NSArray *files=[NSFileManager.defaultManager contentsOfDirectoryAtURL:root includingPropertiesForKeys:nil options:0 error:NULL];
    NSURL *stateURL=nil; for(NSURL *url in files)if([url.pathExtension isEqual:@"bin"])stateURL=url;
    NSData *corrupt=[@"corrupt-existing-state" dataUsingEncoding:NSUTF8StringEncoding]; [corrupt writeToURL:stateURL atomically:YES];
    [runtime synchronizeAccount:@"alice" epoch:6 suspended:NO];
    Check([runtime snapshotForEpoch:6 suspended:NO].blocked,"corrupt persisted state holds protection");
    Check([[runtime snapshotForEpoch:6 suspended:NO] hidesUserName:@"any-contact" surface:CSCloseFriendSurfaceContact],"blocked state protects even unknown membership");
    Check(![runtime saveMuteRecords:@{} account:@"alice" epoch:6 error:NULL],"corrupt state not overwritten by journal");
    Check([[NSData dataWithContentsOfURL:stateURL] isEqual:corrupt],"corrupt bytes preserved");
    Method object=class_getInstanceMethod(CSSignatureFixture.class,@selector(object:));
    Check(CSCloseFriendMethodMatches(object,"@@:@"),"normalized signature ignores encoded offsets");
    Check(!CSCloseFriendMethodMatches(object,"v@:@"),"hook rejects wrong return type");
    Check(!CSCloseFriendMethodMatches(object,"@@:q"),"hook rejects wrong argument type");
    Check(!CSCloseFriendMethodMatches(object,"@@:"),"hook rejects wrong argument count");
    Check(!CSCloseFriendMethodMatches(NULL,"@@:"),"missing native method rejected");
    [NSFileManager.defaultManager removeItemAtURL:root error:NULL];
    printf("CloseFriendRuntimeTests: %lu checks passed\n",(unsigned long)checks);
}return 0; }
