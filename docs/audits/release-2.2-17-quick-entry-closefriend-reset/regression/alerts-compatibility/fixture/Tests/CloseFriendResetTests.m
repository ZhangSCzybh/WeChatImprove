#import <Foundation/Foundation.h>
#import "CSCloseFriendRuntime.h"
#import "CSCloseFriendEntryState.h"
#import "CSCloseFriendReset.h"
#import "CSCloseFriendCrypto.h"
#import "CSPluginStorage.h"
#import <CommonCrypto/CommonCrypto.h>
#import <unistd.h>

static NSUInteger checks;
#define Check(value,message) do { checks++; if(!(value)){fprintf(stderr,"FAIL line %d: %s\n",__LINE__,message);exit(1);} } while(0)
static NSError *Failure(void) { return [NSError errorWithDomain:@"ResetFixture" code:1 userInfo:nil]; }
@interface ResetDefaults : NSUserDefaults
@property(nonatomic) BOOL failSync;
@end
@implementation ResetDefaults
- (BOOL)synchronize { return !self.failSync && [super synchronize]; }
@end
@interface ResetStore : CSCloseFriendStore
@property(nonatomic) BOOL failRemoval;
@property(nonatomic) NSUInteger removals;
@end
@implementation ResetStore
- (BOOL)removeStateForAccountID:(NSString *)account error:(NSError **)error {
    self.removals++;
    if(self.failRemoval) { if(error)*error=Failure(); return NO; }
    return [super removeStateForAccountID:account error:error];
}
@end
@interface ResetFixture : NSObject
@property(nonatomic,strong) NSURL *root;
@property(nonatomic,copy) NSString *suite,*failure;
@property(nonatomic,strong) ResetDefaults *defaults;
@property(nonatomic,strong) ResetStore *store;
@property(nonatomic,strong) CSCloseFriendEntryState *entry;
@property(nonatomic,strong) CSCloseFriendReset *reset;
@property(nonatomic,strong) NSMutableDictionary *secure;
@property(nonatomic,strong) NSMutableArray *operations;
@property(nonatomic) NSTimeInterval now;
- (instancetype)initWithRoot:(NSURL *)root suite:(NSString *)suite secure:(NSDictionary *)secure;
- (CSCloseFriendRuntime *)runtimeFor:(NSString *)account;
- (CSCloseFriendRuntime *)configured:(NSString *)account;
- (NSData *)stateBytes:(NSString *)account;
- (NSURL *)stateURL:(NSString *)account;
- (void)cleanup;
@end
@implementation ResetFixture
- (instancetype)init { return [self initWithRoot:[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString]]
    suite:[@"com.wechatimprove.tests.reset." stringByAppendingString:NSUUID.UUID.UUIDString] secure:@{}]; }
- (instancetype)initWithRoot:(NSURL *)root suite:(NSString *)suite secure:(NSDictionary *)secure {
    if((self=[super init])) {
        _root=root; _suite=suite; _secure=[secure mutableCopy]; _operations=[NSMutableArray new]; _now=1000;
        _defaults=[[ResetDefaults alloc] initWithSuiteName:suite]; _entry=[[CSCloseFriendEntryState alloc] initWithDefaults:_defaults];
        __weak typeof(self) weakSelf=self;
        _store=[[ResetStore alloc] initWithRoot:root keyProvider:^NSData *(NSString *account,__unused NSError **error){
            NSString *key=[account stringByAppendingString:@"/policy"];
            if(!weakSelf.secure[key])weakSelf.secure[key]=CSCloseFriendRandomBytes(64,NULL);
            return weakSelf.secure[key];
        }];
        _store.readKeyProvider=^NSData *(NSString *account,NSError **error){
            NSData *key=weakSelf.secure[[account stringByAppendingString:@"/policy"]];
            if(!key && error)*error=Failure(); return key;
        };
        _reset=[[CSCloseFriendReset alloc] initWithStore:_store entryState:_entry reader:^NSData *(NSString *account,NSString *kind,NSError **error){
            if([weakSelf.failure isEqual:[@"read:" stringByAppendingString:kind]]) { if(error)*error=Failure(); return nil; }
            return weakSelf.secure[[NSString stringWithFormat:@"%@/%@",account,kind]];
        } writer:^BOOL(NSString *account,NSString *kind,NSData *data,NSError **error){
            if([weakSelf.failure isEqual:[@"write:" stringByAppendingString:kind]]) { if(error)*error=Failure(); return NO; }
            weakSelf.secure[[NSString stringWithFormat:@"%@/%@",account,kind]]=data; [weakSelf.operations addObject:[@"write:" stringByAppendingString:kind]]; return YES;
        } remover:^BOOL(NSString *account,NSString *kind,NSError **error){
            if([weakSelf.failure isEqual:[@"remove:" stringByAppendingString:kind]]) { if(error)*error=Failure(); return NO; }
            [weakSelf.secure removeObjectForKey:[NSString stringWithFormat:@"%@/%@",account,kind]];
            [weakSelf.operations addObject:[@"remove:" stringByAppendingString:kind]]; return YES;
        }];
    } return self;
}
- (CSCloseFriendRuntime *)runtimeFor:(NSString *)account {
    __weak typeof(self) weakSelf=self;
    CSCloseFriendRuntime *runtime=[[CSCloseFriendRuntime alloc] initWithStore:self.store wallClock:^NSTimeInterval{return weakSelf.now;}
        elapsedClock:^NSTimeInterval{return weakSelf.now;} credentialReader:^NSDictionary *(NSString *name,NSError **error){
            NSData *data=weakSelf.secure[[name stringByAppendingString:@"/auth"]];
            return data ? [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:error] : nil;
        } credentialWriter:^BOOL(NSString *name,NSDictionary *value,NSError **error){
            NSData *data=[NSPropertyListSerialization dataWithPropertyList:value format:NSPropertyListBinaryFormat_v1_0 options:0 error:error];
            if(data)weakSelf.secure[[name stringByAppendingString:@"/auth"]]=data; return data!=nil;
        }];
    CSCloseFriendReset *reset=self.reset;
    runtime.resetStorage=^BOOL(NSString *name,BOOL begin,NSError **error){
        return begin ? [reset beginResetForAccountID:name error:error] : [reset resumeResetForAccountID:name error:error];
    };
    [runtime synchronizeAccount:account epoch:1 suspended:NO];
    return runtime;
}
- (CSCloseFriendRuntime *)configured:(NSString *)account {
    CSCloseFriendRuntime *runtime=[self runtimeFor:account];
    Check([self.entry discoverEntryForSnapshot:[runtime snapshotForEpoch:1 suspended:NO] hasCredential:NO],"fixture discovers entry");
    Check([runtime setPassword:@"123456" token:runtime.authenticationToken error:NULL],"fixture creates independent password");
    NSMutableDictionary *profile=[runtime.currentProfile mutableCopy],*options=[profile[@"options"] mutableCopy];
    profile[@"enabled"]=@YES; profile[@"friends"]=@[@"private-person"]; profile[@"groups"]=@[@"private-room@chatroom"];
    options[@"biometric"]=@YES; options[@"hideSettingsEntry"]=@YES; options[@"callReplyEnabled"]=@YES; options[@"unlockSeconds"]=@60;
    profile[@"options"]=options;
    Check([runtime updateProfile:profile error:NULL],"fixture persists custom profile");
    Check(([self.store saveState:@{@"profile":profile,@"muteRecords":@{@"private-person":@YES}} forAccountID:account error:NULL]),"fixture includes legacy bookkeeping");
    self.secure[[account stringByAppendingString:@"/biometric-domain"]]=[@"enrollment" dataUsingEncoding:NSUTF8StringEncoding];
    return runtime;
}
- (NSURL *)stateURL:(NSString *)account {
    NSData *data=[account dataUsingEncoding:NSUTF8StringEncoding]; uint8_t bytes[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(data.bytes,(CC_LONG)data.length,bytes); NSMutableString *hash=[NSMutableString new];
    for(NSUInteger i=0;i<sizeof(bytes);i++)[hash appendFormat:@"%02x",bytes[i]];
    return [self.root URLByAppendingPathComponent:[NSString stringWithFormat:@"state-%@.bin",hash]];
}
- (NSData *)stateBytes:(NSString *)account { return [NSData dataWithContentsOfURL:[self stateURL:account]]; }
- (void)cleanup { [self.defaults removePersistentDomainForName:self.suite]; [self.defaults synchronize]; [NSFileManager.defaultManager removeItemAtURL:self.root error:NULL]; }
@end

static void AuthTests(void) {
    ResetFixture *f=[ResetFixture new]; CSCloseFriendRuntime *r=[f configured:@"a"];
    NSData *before=[f stateBytes:@"a"];
    Check(![r resetWithToken:r.authenticationToken error:NULL],"existing authorization alone cannot reset");
    [r lock]; Check([r revealWithShortcutToken:r.authenticationToken],"fixture enters with homepage shortcut");
    Check(![r resetWithToken:r.authenticationToken error:NULL],"shortcut authorization cannot reset");
    [r lock]; Check([r completeBiometricWithToken:r.authenticationToken],"fixture enters with biometrics");
    Check(![r resetWithToken:r.authenticationToken error:NULL],"biometrics cannot substitute the reset password");
    Check(![r prepareResetWithPassword:@"wrong-password" token:r.authenticationToken error:NULL],"wrong password produces no reset proof");
    Check([before isEqual:[f stateBytes:@"a"]] && !f.secure[@"a/reset"] && f.store.removals==0,"failed authentication performs no reset writes");
    NSDictionary *proof=[r prepareResetWithPassword:@"123456" token:r.authenticationToken error:NULL];
    Check(proof!=nil && [before isEqual:[f stateBytes:@"a"]] && !f.secure[@"a/reset"],"password proof waits for separate confirmation");
    [r cancelResetWithToken:proof]; Check(![r resetWithToken:proof error:NULL],"cancel revokes the proof");
    proof=[r prepareResetWithPassword:@"123456" token:r.authenticationToken error:NULL];
    f.now+=61; Check(![r resetWithToken:proof error:NULL],"expired reveal cannot confirm reset");
    Check([r authenticatePassword:@"123456" token:r.authenticationToken error:NULL],"restore auth after expiry");
    proof=[r prepareResetWithPassword:@"123456" token:r.authenticationToken error:NULL];
    [r setActive:NO]; [r setActive:YES]; Check(![r resetWithToken:proof error:NULL],"background invalidates confirmed-password proof");
    Check([r authenticatePassword:@"123456" token:r.authenticationToken error:NULL],"restore auth after background");
    proof=[r prepareResetWithPassword:@"123456" token:r.authenticationToken error:NULL];
    [r synchronizeAccount:@"b" epoch:2 suspended:NO]; Check(![r resetWithToken:proof error:NULL],"account switch rejects old proof");
    [r synchronizeAccount:@"a" epoch:3 suspended:NO]; Check(![r resetWithToken:proof error:NULL],"switching back cannot replay proof");
    Check([r authenticatePassword:@"123456" token:r.authenticationToken error:NULL],"restore auth after account switch");
    proof=[r prepareResetWithPassword:@"123456" token:r.authenticationToken error:NULL];
    Check([r setPassword:@"234567" token:r.authenticationToken error:NULL],"password can change during another flow");
    Check(![r resetWithToken:proof error:NULL],"password change invalidates old proof");
    for(int i=0;i<5;i++)Check(![r prepareResetWithPassword:@"bad" token:r.authenticationToken error:NULL],"reset password failures count normally");
    Check(![r prepareResetWithPassword:@"234567" token:r.authenticationToken error:NULL],"reset respects password cooldown");
    Check([before isEqual:[f stateBytes:@"a"]] && !f.secure[@"a/reset"] && f.store.removals==0,"all rejected confirmations preserve ciphertext");
    [f cleanup];
}
static void CompleteTests(void) {
    ResetFixture *f=[ResetFixture new]; CSCloseFriendRuntime *r=[f configured:@"a"];
    [f configured:@"b"]; NSData *otherFile=[f stateBytes:@"b"],*otherAuth=f.secure[@"b/auth"],*oldKey=f.secure[@"a/policy"];
    NSURL *native=[f.root URLByAppendingPathComponent:@"wechat-chat-fixture.db"];
    [@"native-record" writeToURL:native atomically:YES encoding:NSUTF8StringEncoding error:NULL];
    [f.defaults setObject:@"unrelated" forKey:@"general-setting"]; [f.defaults synchronize];
    __block BOOL searchDone=NO;
    [r checkSearchPassword:@"123456" token:r.authenticationToken isCurrent:^BOOL{return YES;} completion:^(BOOL consumed){Check(consumed,"in-flight secret remains consumed after reset");searchDone=YES;}];
    NSDictionary *proof=[r prepareResetWithPassword:@"123456" token:r.authenticationToken error:NULL];
    Check([r resetWithToken:proof error:NULL],"complete reset succeeds");
    Check(!r.hasCredential && !r.isAuthorized && ![r snapshotForEpoch:1 suspended:NO].blocked,"reset leaves a usable unconfigured account");
    Check(![r.currentProfile[@"enabled"] boolValue] && [r.currentProfile[@"friends"] count]==0 && [r.currentProfile[@"groups"] count]==0 && [r.currentProfile[@"options"] isEqual:CSCloseFriendDefaultOptions()],"all lists and options return to defaults with protection off");
    Check(![f stateBytes:@"a"] && !f.secure[@"a/auth"] && !f.secure[@"a/policy"] && !f.secure[@"a/biometric-domain"] && !f.secure[@"a/reset"],"ciphertext, credentials, biometric baseline and intent are removed");
    Check(![f.entry isEntryVisibleForSnapshot:[r snapshotForEpoch:1 suspended:NO] hasCredential:r.hasCredential],"entry returns to first-use hidden");
    Check([otherFile isEqual:[f stateBytes:@"b"]] && [otherAuth isEqual:f.secure[@"b/auth"]],"other account files and credentials are byte-identical");
    Check([f.entry hasDiscoveredEntryForSnapshot:[[f runtimeFor:@"b"] snapshotForEpoch:1 suspended:NO] hasCredential:NO],"other account discovery persists");
    Check([[f.defaults stringForKey:@"general-setting"] isEqual:@"unrelated"] && [[NSString stringWithContentsOfURL:native encoding:NSUTF8StringEncoding error:NULL] isEqual:@"native-record"],"unrelated preferences and native data untouched");
    Check(([f.operations isEqual:@[@"write:reset",@"remove:biometric-domain",@"remove:auth",@"remove:policy",@"remove:reset"]]),"secure intent removed last, after password and policy key");
    Check(![r resetWithToken:proof error:NULL] && ![r authenticatePassword:@"123456" token:r.authenticationToken error:NULL],"reset proof and old password cannot be reused");
    NSDate *limit=[NSDate dateWithTimeIntervalSinceNow:3];
    while(!searchDone && limit.timeIntervalSinceNow>0)[NSRunLoop.mainRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.005]];
    Check(searchDone && !r.isAuthorized,"late search completion never restores old authorization");
    CSCloseFriendRuntime *fresh=[f runtimeFor:@"a"];
    Check(!fresh.hasCredential && ![f.entry isEntryVisibleForSnapshot:[fresh snapshotForEpoch:1 suspended:NO] hasCredential:NO],"new runtime preserves first-use state");
    Check([f.entry discoverEntryForSnapshot:[fresh snapshotForEpoch:1 suspended:NO] hasCredential:NO],"avatar discovery can be used again");
    Check([fresh setPassword:@"new-password" token:fresh.authenticationToken error:NULL] && [fresh updateProfile:fresh.currentProfile error:NULL],"new configuration can be saved after reset");
    Check(![oldKey isEqual:f.secure[@"a/policy"]] && [[[f.store loadStateForAccountID:@"a" error:NULL] objectForKey:@"muteRecords"] count]==0,"new encryption key and no old bookkeeping");
    [f cleanup];
}
static void FailureTests(const char *executable) {
    for(NSString *stage in @[@"write:reset",@"file",@"preferences",@"remove:biometric-domain",@"remove:auth",@"remove:policy",@"remove:reset"]) {
        ResetFixture *f=[ResetFixture new]; CSCloseFriendRuntime *r=[f configured:@"a"]; [f configured:@"b"];
        NSData *before=[f stateBytes:@"a"],*other=[f stateBytes:@"b"],*otherAuth=f.secure[@"b/auth"];
        NSDictionary *proof=[r prepareResetWithPassword:@"123456" token:r.authenticationToken error:NULL];
        f.failure=stage; f.store.failRemoval=[stage isEqual:@"file"]; f.defaults.failSync=[stage isEqual:@"preferences"];
        NSError *error=nil; Check(![r resetWithToken:proof error:&error] && error!=nil,"injected failure is reported");
        Check([r snapshotForEpoch:1 suspended:NO].blocked && !r.authenticationToken && !r.currentProfile,"partial reset cannot appear as fresh setup");
        Check([other isEqual:[f stateBytes:@"b"]] && [otherAuth isEqual:f.secure[@"b/auth"]],"failure preserves other account byte-for-byte");
        if([stage isEqual:@"write:reset"]) {
            Check(!f.secure[@"a/reset"] && [before isEqual:[f stateBytes:@"a"]] && f.secure[@"a/auth"] && f.secure[@"a/policy"],"intent write failure leaves all original data intact");
            f.failure=nil; r=[f runtimeFor:@"a"];
            Check(r.hasCredential && ![r snapshotForEpoch:1 suspended:NO].blocked && [r.currentProfile[@"friends"] count]==1,"pre-intent failure reloads existing configuration");
        } else {
            Check(f.secure[@"a/reset"]!=nil,"cleanup failure retains durable intent");
            if([stage isEqual:@"file"])Check([before isEqual:[f stateBytes:@"a"]] && f.secure[@"a/policy"] && f.secure[@"a/auth"],"file removal failure never deletes encryption key");
            if([stage isEqual:@"remove:policy"]) {
                NSURL *secureFile=[f.root URLByAppendingPathComponent:@"fixture-keychain.plist"];
                Check([f.secure writeToURL:secureFile error:NULL],"persist only fixture credentials for child process");
                NSTask *child=[NSTask new]; child.executableURL=[NSURL fileURLWithPath:@(executable)];
                child.arguments=@[@"--resume",f.root.path,f.suite];
                Check([child launchAndReturnError:NULL],"launch independent recovery process"); [child waitUntilExit];
                Check(child.terminationStatus==0,"fresh process completes reset after auth was already removed");
                f.secure=[[NSDictionary dictionaryWithContentsOfURL:secureFile] mutableCopy];
            }
            f.failure=nil; f.store.failRemoval=NO; f.defaults.failSync=NO;
            ResetFixture *reopened=[[ResetFixture alloc] initWithRoot:f.root suite:f.suite secure:f.secure];
            CSCloseFriendRuntime *fresh=[reopened runtimeFor:@"a"];
            Check(![fresh snapshotForEpoch:1 suspended:NO].blocked && !fresh.hasCredential && !fresh.isAuthorized,"restart resumes reset and returns to unconfigured state");
            Check(![reopened stateBytes:@"a"] && !reopened.secure[@"a/reset"] && !reopened.secure[@"a/policy"] && !reopened.secure[@"a/auth"] && !reopened.secure[@"a/biometric-domain"],"resume removes every account resource");
            Check(![reopened.entry isEntryVisibleForSnapshot:[fresh snapshotForEpoch:1 suspended:NO] hasCredential:NO],"resume also clears discovery durably");
            Check([other isEqual:[reopened stateBytes:@"b"]] && [otherAuth isEqual:reopened.secure[@"b/auth"]],"resume remains isolated to original account");
            Check([reopened.reset resumeResetForAccountID:@"a" error:NULL],"completed reset recovery is idempotent");
        }
        f.defaults.failSync=NO; [f cleanup];
    }
    ResetFixture *f=[ResetFixture new]; [f configured:@"a"]; NSData *before=[f stateBytes:@"a"];
    f.secure[@"a/reset"]=[@"unrecognized-intent" dataUsingEncoding:NSUTF8StringEncoding];
    Check([[f runtimeFor:@"a"] snapshotForEpoch:1 suspended:NO].blocked && [before isEqual:[f stateBytes:@"a"]] && f.store.removals==0,"malformed intent blocks without cleaning files");
    [f.secure removeObjectForKey:@"a/reset"]; f.failure=@"read:reset";
    Check([[f runtimeFor:@"a"] snapshotForEpoch:1 suspended:NO].blocked && [before isEqual:[f stateBytes:@"a"]],"unreadable intent cannot be mistaken for absence");
    Check([[f runtimeFor:@"new"] snapshotForEpoch:1 suspended:NO].blocked,"unreadable secure storage cannot authorize new setup");
    f.failure=nil;
    Check(![f.reset beginResetForAccountID:@"" error:NULL] && ![f.reset resumeResetForAccountID:@"\n" error:NULL],"invalid account rejected before secure writes");
    NSURL *file=[f stateURL:@"a"],*target=[f.root URLByAppendingPathComponent:@"untouched"];
    [@"native-file" writeToURL:target atomically:YES encoding:NSUTF8StringEncoding error:NULL];
    [NSFileManager.defaultManager removeItemAtURL:file error:NULL]; symlink(target.path.fileSystemRepresentation,file.path.fileSystemRepresentation);
    Check(![f.store removeStateForAccountID:@"a" error:NULL] && [NSFileManager.defaultManager fileExistsAtPath:target.path],"reset never follows a state-file symlink");
    [f cleanup];
}
int main(int argc,const char **argv) { @autoreleasepool {
    if(argc==4 && strcmp(argv[1],"--resume")==0) {
        NSURL *root=[NSURL fileURLWithPath:@(argv[2])]; NSURL *secureFile=[root URLByAppendingPathComponent:@"fixture-keychain.plist"];
        ResetFixture *f=[[ResetFixture alloc] initWithRoot:root suite:@(argv[3]) secure:[NSDictionary dictionaryWithContentsOfURL:secureFile]];
        CSCloseFriendRuntime *r=[f runtimeFor:@"a"];
        BOOL ok=![r snapshotForEpoch:1 suspended:NO].blocked && !r.hasCredential && ![f.entry isEntryVisibleForSnapshot:[r snapshotForEpoch:1 suspended:NO] hasCredential:NO];
        return ok && [f.secure writeToURL:secureFile error:NULL] ? 0 : 2;
    }
    AuthTests(); CompleteTests(); FailureTests(argv[0]);
    printf("CloseFriendResetTests: %lu checks passed\n",(unsigned long)checks);
} return 0; }
