#import <Foundation/Foundation.h>
#import "CSCloseFriendRuntime.h"
#import "CSCloseFriendEntryState.h"
#import "CSCloseFriendReset.h"
#import "CSCloseFriendCrypto.h"
#import "CSPluginStorage.h"
#import <CommonCrypto/CommonCrypto.h>
#import <unistd.h>

@class ResetFixture;
static __weak ResetFixture *ActiveFixture;
static BOOL CSKeychainRemove(NSString *account,NSString *kind,NSError **error) __attribute__((unused));
static NSUInteger checks, failures;
#define Check(value,message) do { checks++; if(!(value)){fprintf(stderr,"FAIL line %d: %s\n",__LINE__,message);failures++;} } while(0)
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
    ActiveFixture=self;
    CSCloseFriendRuntime *_runtime=runtime;
#include "ManagerResetStorageUnderTest.h"
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


static BOOL CSKeychainRemove(NSString *account,NSString *kind,NSError **error) {
    ResetFixture *f=ActiveFixture;
    if([f.failure isEqual:[@"remove:" stringByAppendingString:kind]]) { if(error)*error=Failure(); return NO; }
    [f.secure removeObjectForKey:[NSString stringWithFormat:@"%@/%@",account,kind]];
    [f.operations addObject:[@"remove:" stringByAppendingString:kind]]; return YES;
}
static BOOL Resume(ResetFixture *f,NSError **error) {
    ActiveFixture=f;
    CSCloseFriendReset *reset=f.reset;
    CSCloseFriendRuntime *_runtime=[CSCloseFriendRuntime new];
#include "ManagerResetStorageUnderTest.h"
    return _runtime.resetStorage(@"a",NO,error);
}
static NSData *Bytes(NSString *s) { return [s dataUsingEncoding:NSUTF8StringEncoding]; }
static NSDictionary *OtherSecure(ResetFixture *f) { NSMutableDictionary *out=[NSMutableDictionary new]; for(NSString *key in f.secure)if([key hasPrefix:@"b/"])out[key]=f.secure[key]; return out; }
static void RemovedAPITests(void) {
    ResetFixture *f=[ResetFixture new]; CSCloseFriendRuntime *r=[f configured:@"a"];
    for(NSString *name in @[@"beginCredentialResetForAccountID:error:",@"finishCredentialResetForAccountID:error:",@"requiresPasswordSetupForAccountID:error:",@"completeCredentialSetupForAccountID:error:"])
        Check(![f.reset respondsToSelector:NSSelectorFromString(name)],"removed reset API must not remain callable");
    for(NSString *name in @[@"requiresPasswordSetup",@"prepareCredentialResetWithAccountConfirmation:token:error:",@"resetCredentialWithToken:error:",@"setCredentialResetStorage:",@"setCredentialResetSetupAllowed:",@"setFinishCredentialResetSetup:"])
        Check(![r respondsToSelector:NSSelectorFromString(name)],"removed runtime state/API must not remain callable");
    [f cleanup];
}
static void ResidueTests(void) {
    for(NSString *kind in @[@"marker",@"malformed-marker",@"intent",@"both",@"without-auth",@"intent-without-auth"]){
        ResetFixture *f=[ResetFixture new]; [f configured:@"a"]; [f configured:@"b"];
        NSData *state=[f stateBytes:@"a"]; NSDictionary *other=OtherSecure(f); NSData *otherState=[f stateBytes:@"b"];
        BOOL oldIntent=[kind isEqual:@"intent"] || [kind isEqual:@"both"] || [kind isEqual:@"intent-without-auth"];
        if(oldIntent)f.secure[@"a/reset"]=Bytes(@"close-friends-credential-reset-v1");
        if(![kind isEqual:@"intent"] && ![kind isEqual:@"intent-without-auth"])f.secure[@"a/credential-reset"]=Bytes([kind isEqual:@"malformed-marker"]?@"unknown-retired-value":@"close-friends-credential-setup-v1");
        if([kind isEqual:@"without-auth"] || [kind isEqual:@"intent-without-auth"]){[f.secure removeObjectForKey:@"a/auth"];[f.secure removeObjectForKey:@"a/biometric-domain"];}
        NSData *auth=f.secure[@"a/auth"],*biometric=f.secure[@"a/biometric-domain"],*key=f.secure[@"a/policy"];
        NSError *error=nil;
        Check(Resume(f,&error) && !error,"retired residue is not pending and produces no error");
        Check(!f.secure[@"a/credential-reset"],"retired marker is deleted immediately");
        Check(!f.secure[@"a/reset"],"exact legacy credential-reset intent is deleted");
        Check((!auth && !f.secure[@"a/auth"]) || [auth isEqual:f.secure[@"a/auth"]],"cleanup never deletes or recreates credential");
        Check((!biometric && !f.secure[@"a/biometric-domain"]) || [biometric isEqual:f.secure[@"a/biometric-domain"]],"cleanup never deletes biometric record");
        Check([state isEqual:[f stateBytes:@"a"]] && [key isEqual:f.secure[@"a/policy"]],"cleanup preserves encrypted lists, options and key");
        Check([other isEqual:OtherSecure(f)] && [otherState isEqual:[f stateBytes:@"b"]],"other account bytes and key set do not change");
        CSCloseFriendRuntime *r=[f runtimeFor:@"a"];
        Check(![r snapshotForEpoch:1 suspended:NO].revealed && !r.isAuthorized,"resuming retired marker never reveals chat list");
        if(auth){
            Check(![r snapshotForEpoch:1 suspended:NO].blocked && r.currentProfile!=nil,"valid credential resumes ordinary non-pending account");
            Check([r authenticatePassword:@"123456" token:r.authenticationToken error:NULL],"original password remains required and works");
        }else{
            Check([r snapshotForEpoch:1 suspended:NO].blocked && !r.authenticationToken,"lost verifier remains fail-closed outside dedicated quick page");
            Check(![r setPassword:@"new-password" token:r.authenticationToken error:NULL],"migration does not resurrect removed password setup path");
        }
        error=nil; Check(Resume(f,&error) && !error && !f.secure[@"a/credential-reset"],"second resume is non-pending and marker never returns");
        [f cleanup];
    }
}
static void BaselineTests(void) {
    ResetFixture *f=[ResetFixture new]; [f configured:@"a"];
    NSDictionary *before=[f.secure copy]; NSData *state=[f stateBytes:@"a"];
    CSCloseFriendRuntime *r=[f runtimeFor:@"a"];
    Check([before isEqual:f.secure] && [state isEqual:[f stateBytes:@"a"]],"without residue account bytes match 2.2-14 behavior");
    Check(!r.isAuthorized && ![r snapshotForEpoch:1 suspended:NO].revealed,"ordinary load remains locked");
    Check(![r authenticatePassword:@"wrong-password" token:r.authenticationToken error:NULL],"ordinary entry rejects bad password");
    Check([r authenticatePassword:@"123456" token:r.authenticationToken error:NULL],"ordinary entry requires valid password");
    [f cleanup];
}
static void StrictFullResetTests(void) {
    for(NSString *kind in @[@"unknown",@"read-error",@"full",@"full-delete-fails"]){
        ResetFixture *f=[ResetFixture new]; [f configured:@"a"]; [f configured:@"b"];
        f.secure[@"a/reset"]=Bytes([kind isEqual:@"unknown"]?@"unknown-future-reset":@"close-friends-reset-v1");
        if([kind isEqual:@"read-error"])f.failure=@"read:reset";
        if([kind isEqual:@"full-delete-fails"])f.failure=@"remove:auth";
        NSDictionary *before=[f.secure copy],*other=OtherSecure(f); NSData *state=[f stateBytes:@"a"];
        NSError *error=nil; BOOL ok=Resume(f,&error);
        if([kind isEqual:@"full"]){
            Check(ok && !error,"real full-reset intent completes normally");
            Check(![f stateBytes:@"a"] && !f.secure[@"a/auth"] && !f.secure[@"a/biometric-domain"] && !f.secure[@"a/policy"] && !f.secure[@"a/reset"],"real full-reset resources remain strictly cleared");
        }else{
            Check(!ok && error.code==2,"unknown unreadable or incomplete real full reset remains pending error");
            Check(f.secure[@"a/reset"]!=nil,"failed real full reset never drops durable intent");
            if(![kind isEqual:@"full-delete-fails"])Check([before isEqual:f.secure] && [state isEqual:[f stateBytes:@"a"]],"unknown/read error performs no cleanup");
            Check([[[f runtimeFor:@"a"] snapshotForEpoch:1 suspended:NO] blocked],"strict full-reset failure blocks account loading");
        }
        Check([other isEqual:OtherSecure(f)],"strict reset remains account-scoped");
        [f cleanup];
    }
}
static void RemovalRetryTests(void) {
    ResetFixture *f=[ResetFixture new];[f configured:@"a"];
    f.secure[@"a/credential-reset"]=Bytes(@"close-friends-credential-setup-v1");
    f.failure=@"remove:credential-reset"; NSError *error=nil;
    Check(Resume(f,&error) && !error,"retired-marker deletion failure does not become reset-pending UI");
    Check(f.secure[@"a/credential-reset"]!=nil,"failed cleanup honestly leaves marker for retry");
    f.failure=nil; error=nil;
    Check(Resume(f,&error) && !error && !f.secure[@"a/credential-reset"],"subsequent resume completes cleanup");
    f.secure[@"a/reset"]=Bytes(@"close-friends-credential-reset-v1");
    f.failure=@"remove:reset"; error=nil;
    Check(Resume(f,&error) && !error && f.secure[@"a/reset"]!=nil,"retired intent deletion failure is nonblocking and retained for retry");
    f.failure=nil; error=nil;
    Check(Resume(f,&error) && !error && !f.secure[@"a/reset"],"retired intent cleanup retries without destructive credential reset");
    [f cleanup];
}
int main(void) { @autoreleasepool {
    RemovedAPITests(); ResidueTests(); BaselineTests(); StrictFullResetTests(); RemovalRetryTests();
    printf("Rollback/migration: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
    return failures?1:0;
} }
