#import <Foundation/Foundation.h>
#import "CSCloseFriendEntryState.h"
#import "CSCloseFriendRuntime.h"

static NSUInteger checks;
#define Check(value,message) do {checks++;if(!(value)){fprintf(stderr,"FAIL: %s\n",message);exit(1);}} while(0)
enum {UIApplicationStateActive=0};
@interface UIApplication : NSObject
@property(nonatomic) NSInteger applicationState;
+ (instancetype)sharedApplication;
@end
@implementation UIApplication
+ (instancetype)sharedApplication {static UIApplication *app; if(!app)app=[self new];return app;}
@end

static CSCloseFriendRuntime *runtimeUnderTest;
static NSString *currentAccount=@"first-account";
static NSUInteger epoch=1;
static BOOL suspended;
static CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) {return [runtimeUnderTest snapshotForEpoch:epoch suspended:suspended];}
static NSUInteger CSBackupAccountEpoch(void) {return epoch;}
static BOOL CSBackupAccountIsSuspended(void) {return suspended;}
static void CSBackupPerformAtAccountEpoch(NSUInteger expected,void (^action)(void)) {if(expected==epoch && !suspended)action();}
@interface EntryManager : NSObject
@property(nonatomic,strong) CSCloseFriendRuntime *runtime;
@property(nonatomic,strong) CSCloseFriendEntryState *entryState;
@property(nonatomic) BOOL backgroundCoverRequired;
- (void)start;
- (void)refreshAccount;
- (BOOL)validateToken:(NSDictionary *)token;
@end
@implementation EntryManager
- (void)start {}
- (void)refreshAccount {[self.runtime synchronizeAccount:currentAccount epoch:epoch suspended:suspended];}
#import "EntryManagerUnderTest.h"
@end

static CSCloseFriendSnapshot *EmptySnapshot(NSString *account) {
    return [[CSCloseFriendSnapshot alloc] initWithAccountID:account profile:@{@"enabled":@NO,@"friends":@[],@"groups":@[],@"options":@{}} revealed:NO revision:1 blocked:NO];
}
int main(int argc,const char **argv) {@autoreleasepool {
    if(argc==4 && strcmp(argv[1],"--reopen")==0) {
        NSUserDefaults *defaults=[[NSUserDefaults alloc] initWithSuiteName:@(argv[2])];
        CSCloseFriendEntryState *state=[[CSCloseFriendEntryState alloc] initWithDefaults:defaults];
        return [state isEntryVisibleForSnapshot:EmptySnapshot(@(argv[3])) hasCredential:NO]?0:2;
    }
    NSString *suite=[@"com.wechatimprove.tests.entry." stringByAppendingString:NSUUID.UUID.UUIDString];
    NSUserDefaults *defaults=[[NSUserDefaults alloc] initWithSuiteName:suite];
    [defaults removePersistentDomainForName:suite];
    NSURL *root=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString] isDirectory:YES];
    NSData *key=[NSMutableData dataWithLength:64];
    NSMutableDictionary *credentials=[NSMutableDictionary new];
    __block BOOL unavailable=NO;
    __block NSUInteger credentialWrites=0;
    __block NSTimeInterval elapsed=1000;
    CSCloseFriendStore *store=[[CSCloseFriendStore alloc] initWithRoot:root keyProvider:^NSData *(__unused NSString *account,__unused NSError **error){return key;}];
    runtimeUnderTest=[[CSCloseFriendRuntime alloc] initWithStore:store wallClock:^NSTimeInterval{return 10000;} elapsedClock:^NSTimeInterval{return elapsed;}
        credentialReader:^NSDictionary *(NSString *account,NSError **error){
            if(unavailable){if(error)*error=[NSError errorWithDomain:@"TestCredentialUnavailable" code:1 userInfo:nil];return nil;}
            return credentials[account];
        } credentialWriter:^BOOL(NSString *account,NSDictionary *value,__unused NSError **error){credentialWrites++;credentials[account]=value;return YES;}];
    EntryManager *manager=[EntryManager new];manager.runtime=runtimeUnderTest;
    manager.entryState=[[CSCloseFriendEntryState alloc] initWithDefaults:defaults];
    Check(![manager settingsEntryVisible],"first use has no entry before any password or configuration");
    Check(![manager settingsEntryVisible] && [defaults persistentDomainForName:suite].count==0,"rendering a new account does not activate or persist anything");
    NSDictionary *token=[manager settingsEntryDiscoveryToken];
    Check(token!=nil,"new disabled account can begin discovery");
    Check([manager discoverSettingsEntryWithToken:token],"gesture persists discovery without password setup");
    Check([manager settingsEntryVisible],"discovery displays the settings entry");
    Check(!runtimeUnderTest.isAuthorized && !runtimeUnderTest.hasCredential && !CSCloseFriendCurrentSnapshot().enabled,"discovery grants no authorization and does not enable protection");
    Check(credentialWrites==0 && ![NSFileManager.defaultManager fileExistsAtPath:root.path],"discovery never creates credentials, policy keys or an encrypted profile");
    Check(![manager discoverSettingsEntryWithToken:token] && ![manager settingsEntryDiscoveryToken],"repeat gestures are idempotent and cannot act as recovery");
    NSDictionary *saved=[defaults persistentDomainForName:suite];
    Check(saved.count==1 && ![[saved.allKeys firstObject] containsString:currentAccount],"local discovery stores only an account digest flag");
    manager.entryState=[[CSCloseFriendEntryState alloc] initWithDefaults:[[NSUserDefaults alloc] initWithSuiteName:suite]];
    Check([manager settingsEntryVisible],"recreating preference objects retains discovery");
    NSTask *child=[NSTask new];child.executableURL=[NSURL fileURLWithPath:@(argv[0])];child.arguments=@[@"--reopen",suite,currentAccount];
    Check([child launchAndReturnError:NULL],"launch separate preference reader");[child waitUntilExit];
    Check(child.terminationStatus==0,"discovery survives an actual fresh process");
    NSString *flagKey=saved.allKeys.firstObject;
    [defaults setObject:@"YES" forKey:flagKey];[defaults synchronize];
    Check(![manager settingsEntryVisible],"malformed preference is not treated as a discovered account");
    [defaults setBool:YES forKey:flagKey];[defaults synchronize];
    UIApplication.sharedApplication.applicationState=1;[runtimeUnderTest setActive:NO];
    Check([manager settingsEntryVisible],"background does not forget discovery");
    Check(![manager discoverSettingsEntryWithToken:token] && ![manager settingsEntryDiscoveryToken],"inactive app cannot discover");
    UIApplication.sharedApplication.applicationState=0;[runtimeUnderTest setActive:YES];
    currentAccount=@"second-account";epoch++;
    Check(![manager settingsEntryVisible],"another account starts hidden");
    Check(![manager discoverSettingsEntryWithToken:token],"old-account touch cannot discover the new account");
    token=[manager settingsEntryDiscoveryToken];
    [runtimeUnderTest setActive:NO];[runtimeUnderTest setActive:YES];
    Check(![manager discoverSettingsEntryWithToken:token],"background then foreground invalidates an in-flight touch");
    token=[manager settingsEntryDiscoveryToken];manager.backgroundCoverRequired=YES;
    Check(![manager discoverSettingsEntryWithToken:token] && ![manager settingsEntryDiscoveryToken],"privacy cover blocks discovery");manager.backgroundCoverRequired=NO;
    suspended=YES;
    Check(![manager discoverSettingsEntryWithToken:token] && ![manager settingsEntryVisible],"suspended account cannot reveal or write entry state");
    suspended=NO;epoch++;
    Check([manager settingsEntryDiscoveryToken]!=nil && ![manager settingsEntryVisible],"resume preserves an undiscovered account");
    Check([defaults persistentDomainForName:suite].count==1,"rejected stale touches never create another account flag");
    currentAccount=@"legacy-account";epoch++;[manager refreshAccount];
    Check([runtimeUnderTest setPassword:@"123456" token:runtimeUnderTest.authenticationToken error:NULL],"prepare existing password-only account");
    [runtimeUnderTest lock];
    Check([manager settingsEntryVisible] && !runtimeUnderTest.isAuthorized,"upgrade preserves entry for password-only users without unlocking them");
    Check(![manager settingsEntryDiscoveryToken],"existing users do not need first-use discovery");
    Check([runtimeUnderTest authenticatePassword:@"123456" token:runtimeUnderTest.authenticationToken error:NULL],"authorize existing profile fixture");
    NSMutableDictionary *profile=[runtimeUnderTest.currentProfile mutableCopy];profile[@"enabled"]=@YES;profile[@"friends"]=@[@"protected-friend"];
    NSMutableDictionary *options=[profile[@"options"] mutableCopy];options[@"hideSettingsEntry"]=@YES;profile[@"options"]=options;
    Check([runtimeUnderTest updateProfile:profile error:NULL],"prepare manually hidden settings");
    NSArray<NSURL *> *policyFiles=[NSFileManager.defaultManager contentsOfDirectoryAtURL:root includingPropertiesForKeys:nil options:0 error:NULL];
    Check(policyFiles.count==1 && [policyFiles.firstObject.pathExtension isEqual:@"bin"],"fixture contains only the historical account policy");
    NSURL *policyURL=policyFiles.firstObject;NSData *policyBytes=[NSData dataWithContentsOfURL:policyURL];
    [runtimeUnderTest lock];
    Check(![manager settingsEntryVisible] && ![manager settingsEntryDiscoveryToken],"manual hiding takes precedence over discovery for upgraded users");
    Check(![manager discoverSettingsEntryWithToken:runtimeUnderTest.authenticationToken],"fresh gesture token cannot override manual hiding");
    Check([CSCloseFriendCurrentSnapshot() hidesUserName:@"protected-friend" surface:CSCloseFriendSurfaceSession],"gesture leaves protected contacts hidden");
    Check([runtimeUnderTest authenticatePassword:@"123456" token:runtimeUnderTest.authenticationToken error:NULL] && [manager settingsEntryVisible],"existing password reveal restores entry");
    elapsed+=301;
    Check(![manager settingsEntryVisible],"authorization expiry hides a manually hidden entry again");
    Check([runtimeUnderTest authenticatePassword:@"123456" token:runtimeUnderTest.authenticationToken error:NULL],"reauthorize disabled-protection case");
    profile[@"enabled"]=@NO;
    Check([runtimeUnderTest updateProfile:profile error:NULL],"disable protection without losing existing password");
    [runtimeUnderTest lock];
    Check([manager settingsEntryVisible],"existing disabled-protection entry behavior is retained");
    policyBytes=[NSData dataWithContentsOfURL:policyURL];NSDictionary *legacyCredential=credentials[currentAccount];
    [credentials removeObjectForKey:currentAccount];epoch++;
    Check(![manager settingsEntryVisible] && CSCloseFriendCurrentSnapshot().blocked,"missing verifier for existing policy is an error, not first use");
    Check(![manager settingsEntryDiscoveryToken] && ![manager discoverSettingsEntryWithToken:token],"broken credential state cannot discover or initialize");
    Check([[NSData dataWithContentsOfURL:policyURL] isEqual:policyBytes],"entry checks preserve historical encrypted policy bytes");
    credentials[currentAccount]=legacyCredential;epoch++;
    Check([manager settingsEntryVisible],"valid historical entry recovers after credential availability returns");
    currentAccount=@"unavailable-account";epoch++;unavailable=YES;
    Check(![manager settingsEntryVisible] && ![manager settingsEntryDiscoveryToken],"unavailable credential storage is not interpreted as new setup");
    unavailable=NO;epoch++;
    Check(![manager settingsEntryVisible] && [manager settingsEntryDiscoveryToken]!=nil,"fresh account becomes discoverable only after successful account load");
    currentAccount=@"";epoch++;
    Check(![manager settingsEntryVisible] && ![manager settingsEntryDiscoveryToken],"logged-out state stays hidden");
    currentAccount=@"first-account";epoch++;
    Check([manager settingsEntryVisible] && !runtimeUnderTest.isAuthorized,"returning to original account restores only its entry");
    Check([defaults persistentDomainForName:suite].count==1,"legacy migration and error recovery do not rewrite discovery preferences");
    [defaults removePersistentDomainForName:suite];[defaults synchronize];
    [NSFileManager.defaultManager removeItemAtURL:root error:NULL];
    printf("CloseFriendEntryTests: %lu checks passed\n",(unsigned long)checks);
}return 0;}
