#import <Foundation/Foundation.h>
#import "CSCloseFriendRuntime.h"
#import "CSCloseFriendCrypto.h"
#import "CSCloseFriendReset.h"
#import "CSCloseFriendEntryState.h"
static NSUInteger checks,failures,testEpoch=1,biometricCalls;
static BOOL testSuspended;
static void Check(BOOL ok,NSString *label){checks++;if(!ok){failures++;fprintf(stderr,"FAIL %s\n",label.UTF8String);}}
static NSUInteger CSBackupAccountEpoch(void){return testEpoch;}
static NSUInteger CSCloseFriendAccountEpoch(void){return testEpoch;}
static BOOL CSBackupAccountIsSuspended(void){return testSuspended;}
static BOOL CSBackupPerformAtAccountEpoch(NSUInteger epoch,void (^block)(void)){if(epoch!=testEpoch)return NO;block();return YES;}
@class UIViewController,UINavigationController;
@interface UIView : NSObject
@property(nonatomic,strong) id window;
@property(nonatomic) BOOL userInteractionEnabled;
@property(nonatomic,strong) NSMutableArray *gestures;
- (void)addGestureRecognizer:(id)gesture;
@end
@implementation UIView
- (void)addGestureRecognizer:(id)gesture{if(!self.gestures)self.gestures=[NSMutableArray new];[self.gestures addObject:gesture];}
@end
@interface TestTable : UIView
- (void)reloadData;
@end
@implementation TestTable
- (void)reloadData{}
@end
@interface UIViewController : NSObject
@property(nonatomic,strong) UIView *view;
@property(nonatomic,strong) UIViewController *presentedViewController;
@property(nonatomic,strong) UINavigationController *navigationController;
- (void)presentViewController:(UIViewController *)controller animated:(BOOL)animated completion:(void (^)(void))completion;
@end
@implementation UIViewController
- (instancetype)init{if((self=[super init])){self.view=[UIView new];self.view.window=@YES;}return self;}
- (void)presentViewController:(UIViewController *)c animated:(__unused BOOL)animated completion:(void (^)(void))completion{self.presentedViewController=c;if(completion)completion();}
@end
@interface UINavigationController : UIViewController
@property(nonatomic,strong) UIViewController *topViewController;
- (void)pushViewController:(UIViewController *)controller animated:(BOOL)animated;
- (instancetype)initWithRootViewController:(UIViewController *)controller;
@end
@implementation UINavigationController
- (void)pushViewController:(UIViewController *)c animated:(__unused BOOL)animated{self.topViewController=c;c.navigationController=self;}
- (instancetype)initWithRootViewController:(UIViewController *)c{if((self=[super init]))[self pushViewController:c animated:NO];return self;}
@end
@interface CSCloseFriendSettingsViewController : UIViewController
- (instancetype)initWithStyle:(NSInteger)style;
@end
@implementation CSCloseFriendSettingsViewController
- (instancetype)initWithStyle:(__unused NSInteger)style{return [super init];}
@end
enum{UIApplicationStateActive=0,UIGestureRecognizerStatePossible=0,UIGestureRecognizerStateBegan=1,UIGestureRecognizerStateEnded=3,UIGestureRecognizerStateCancelled=4,UIGestureRecognizerStateFailed=5,UIImpactFeedbackStyleLight=0,UIAlertControllerStyleAlert=0,UIAlertActionStyleDefault=0,UIAlertActionStyleCancel=1,UIAlertActionStyleDestructive=2,UITableViewStyleInsetGrouped=2,LAPolicyDeviceOwnerAuthenticationWithBiometrics=1};
static NSString *const UITextContentTypeNewPassword=@"new-password",*const UITextContentTypePassword=@"password";
@interface UIApplication : NSObject
@property(nonatomic) NSInteger applicationState;
+ (instancetype)sharedApplication;
@end
@implementation UIApplication
+ (instancetype)sharedApplication{static UIApplication *a;if(!a)a=[self new];return a;}
@end
@interface UIGestureRecognizer : NSObject
@property(nonatomic) NSInteger state;
@property(nonatomic) BOOL cancelsTouchesInView;
@property(nonatomic,weak) id delegate;
- (instancetype)initWithTarget:(id)target action:(SEL)action;
- (void)requireGestureRecognizerToFail:(UIGestureRecognizer *)gesture;
@end
@implementation UIGestureRecognizer
- (instancetype)initWithTarget:(__unused id)target action:(__unused SEL)action{return [super init];}
- (void)requireGestureRecognizerToFail:(__unused UIGestureRecognizer *)gesture{}
@end
@interface UILongPressGestureRecognizer : UIGestureRecognizer
@property(nonatomic) NSTimeInterval minimumPressDuration;
@property(nonatomic) double allowableMovement;
@property(nonatomic) NSUInteger numberOfTouchesRequired;
@end
@implementation UILongPressGestureRecognizer @end
@interface UITapGestureRecognizer : UIGestureRecognizer
@property(nonatomic) NSUInteger numberOfTapsRequired,numberOfTouchesRequired;
@end
@implementation UITapGestureRecognizer @end
@interface UITouch : NSObject @end
@implementation UITouch @end
@interface UIImpactFeedbackGenerator : NSObject
- (instancetype)initWithStyle:(NSInteger)style;
- (void)impactOccurred;
@end
@implementation UIImpactFeedbackGenerator
- (instancetype)initWithStyle:(__unused NSInteger)style{return [super init];}
- (void)impactOccurred{}
@end
@interface UITextField : NSObject
@property(nonatomic) BOOL secureTextEntry;
@property(nonatomic,strong) NSString *text,*placeholder,*textContentType;
@end
@implementation UITextField @end
@interface UIAlertAction : NSObject
@property(nonatomic,strong) NSString *title;
@property(nonatomic,copy) void (^handler)(UIAlertAction *);
+ (instancetype)actionWithTitle:(NSString *)title style:(NSInteger)style handler:(void (^)(UIAlertAction *))handler;
@end
@implementation UIAlertAction
+ (instancetype)actionWithTitle:(NSString *)t style:(__unused NSInteger)s handler:(void (^)(UIAlertAction *))h{UIAlertAction *a=[self new];a.title=t;a.handler=h;return a;}
@end
@interface UIAlertController : UIViewController
@property(nonatomic,strong) NSString *title,*message;
@property(nonatomic,strong) NSMutableArray<UIAlertAction *> *actions;
@property(nonatomic,strong) NSMutableArray<UITextField *> *textFields;
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(NSInteger)style;
- (void)addAction:(UIAlertAction *)action;
- (void)addTextFieldWithConfigurationHandler:(void (^)(UITextField *))handler;
@end
@implementation UIAlertController
+ (instancetype)alertControllerWithTitle:(NSString *)t message:(NSString *)m preferredStyle:(__unused NSInteger)s{UIAlertController *a=[self new];a.title=t;a.message=m;a.actions=[NSMutableArray new];a.textFields=[NSMutableArray new];return a;}
- (void)addAction:(UIAlertAction *)a{[self.actions addObject:a];}
- (void)addTextFieldWithConfigurationHandler:(void (^)(UITextField *))handler{UITextField *f=[UITextField new];handler(f);[self.textFields addObject:f];}
@end
@interface LAContext : NSObject
@property(nonatomic) NSTimeInterval touchIDAuthenticationAllowableReuseDuration;
@property(nonatomic,strong) NSString *localizedFallbackTitle;
- (BOOL)canEvaluatePolicy:(NSInteger)policy error:(NSError **)error;
- (void)evaluatePolicy:(NSInteger)policy localizedReason:(NSString *)reason reply:(void (^)(BOOL,NSError *))reply;
- (void)invalidate;
@end
@implementation LAContext
- (BOOL)canEvaluatePolicy:(__unused NSInteger)policy error:(__unused NSError **)error{biometricCalls++;return NO;}
- (void)evaluatePolicy:(__unused NSInteger)policy localizedReason:(__unused NSString *)reason reply:(void (^)(BOOL,NSError *))reply{biometricCalls++;reply(NO,nil);}
- (void)invalidate{}
@end
static CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void);
@interface CSCloseFriendManager : NSObject
@property(nonatomic,strong) CSCloseFriendRuntime *runtime;
@property(nonatomic,strong) CSCloseFriendEntryState *entryState;
@property(nonatomic) BOOL backgroundCoverRequired,authenticating,lastRevealed;
@property(nonatomic,strong) NSString *passwordFallbackReason;
@property(nonatomic,strong) LAContext *authenticationContext;
@property(nonatomic,copy) void (^biometricCompletion)(BOOL);
@property(nonatomic,strong) NSError *lastError;
+ (instancetype)sharedManager;
- (void)start;
- (void)refreshAccount;
- (void)message:(NSString *)message presenter:(UIViewController *)presenter;
- (void)recordCapability:(NSString *)name available:(BOOL)available;
- (NSString *)biometricFailureReason:(NSError *)error;
- (void)biometricPasswordFallbackFrom:(UIViewController *)presenter token:(NSDictionary *)token reason:(NSString *)reason domainState:(NSData *)domain completion:(void (^)(BOOL))completion;
- (void)finishBiometricContext:(LAContext *)context token:(NSDictionary *)token presenter:(UIViewController *)presenter success:(BOOL)success error:(NSError *)error;
#include "ManagerDeclarations.h"
@end
@implementation CSCloseFriendManager
+ (instancetype)sharedManager{static CSCloseFriendManager *m;if(!m)m=[self new];return m;}
- (void)start{}
- (void)refreshAccount{[self.runtime synchronizeAccount:@"account-A" epoch:testEpoch suspended:testSuspended];}
- (void)message:(NSString *)message presenter:(__unused UIViewController *)presenter{self.lastError=[NSError errorWithDomain:@"PasswordFixture" code:1 userInfo:@{NSLocalizedDescriptionKey:message}];}
- (void)recordCapability:(__unused NSString *)name available:(__unused BOOL)available{}
- (NSString *)biometricFailureReason:(__unused NSError *)error{biometricCalls++;return @"unexpected biometric path";}
- (void)biometricPasswordFallbackFrom:(__unused UIViewController *)presenter token:(__unused NSDictionary *)token reason:(__unused NSString *)reason domainState:(__unused NSData *)domain completion:(void (^)(BOOL))completion{biometricCalls++;completion(NO);}
- (void)finishBiometricContext:(__unused LAContext *)context token:(__unused NSDictionary *)token presenter:(__unused UIViewController *)presenter success:(__unused BOOL)success error:(__unused NSError *)error{biometricCalls++;}
#include "ManagerMethods.h"
@end
static CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void){return [CSCloseFriendManager.sharedManager.runtime snapshotForEpoch:testEpoch suspended:testSuspended];}
static UIViewController *CSNativeSettingsHostForContent(UIViewController *c){return c;}
@interface CSCustomViewController : UIViewController
@property(nonatomic,strong) UIView *avatarImageView;
@property(nonatomic,strong) TestTable *tableView;
@property(nonatomic) BOOL isAuthorized,authorizationPromptInFlight,entryVisible;
@property(nonatomic,strong) UILongPressGestureRecognizer *closeFriendEntryGesture;
@property(nonatomic,copy) NSDictionary *closeFriendEntryToken;
@property(nonatomic,strong) UITapGestureRecognizer *closeFriendQuickEntryGesture;
@property(nonatomic,copy) NSDictionary *closeFriendQuickEntryToken;
@property(nonatomic) NSUInteger closeFriendQuickEntryCount;
@property(nonatomic) NSTimeInterval closeFriendQuickEntryLastTap;
- (void)setupData;
#include "CustomDeclarations.h"
@end
@implementation CSCustomViewController
- (void)setupData{self.entryVisible=[CSCloseFriendManager.sharedManager settingsEntryVisible];}
#include "CustomMethods.h"
@end
@interface MemoryDefaults : NSUserDefaults
@property(nonatomic,strong) NSMutableDictionary *values;
@end
@implementation MemoryDefaults
- (instancetype)init{if((self=[super initWithSuiteName:[@"wci-unused-" stringByAppendingString:NSUUID.UUID.UUIDString]]))_values=[NSMutableDictionary new];return self;}
- (id)objectForKey:(NSString *)key{return self.values[key];}
- (void)setObject:(id)value forKey:(NSString *)key{self.values[key]=value;}
- (void)setBool:(BOOL)value forKey:(NSString *)key{self.values[key]=@(value);}
- (void)removeObjectForKey:(NSString *)key{[self.values removeObjectForKey:key];}
- (BOOL)synchronize{return YES;}
@end
static NSString *SecureKey(NSString *account,NSString *kind){return [NSString stringWithFormat:@"%@/%@",account,kind];}
static void Action(UIAlertController *alert,NSString *title){for(UIAlertAction *a in alert.actions)if([a.title isEqual:title]){if(a.handler)a.handler(a);return;}Check(NO,@"requested real password action exists");}
static void Scenario(NSURL *root,BOOL restart){
    NSMutableDictionary<NSString *,NSData *> *secure=[NSMutableDictionary new];
    MemoryDefaults *defaults=[MemoryDefaults new];CSCloseFriendEntryState *entry=[[CSCloseFriendEntryState alloc] initWithDefaults:defaults];
    CSCloseFriendStore *store=[[CSCloseFriendStore alloc] initWithRoot:root keyProvider:^NSData *(NSString *account,NSError **error){NSString *key=SecureKey(account,@"policy");if(!secure[key])secure[key]=CSCloseFriendRandomBytes(64,error);return secure[key];}];
    CSCloseFriendReset *reset=[[CSCloseFriendReset alloc] initWithStore:store entryState:entry reader:^NSData *(NSString *account,NSString *kind,__unused NSError **error){return secure[SecureKey(account,kind)];} writer:^BOOL(NSString *account,NSString *kind,NSData *data,__unused NSError **error){secure[SecureKey(account,kind)]=data;return YES;} remover:^BOOL(NSString *account,NSString *kind,__unused NSError **error){[secure removeObjectForKey:SecureKey(account,kind)];return YES;}];
    CSCloseFriendRuntime *(^runtime)(void)=^CSCloseFriendRuntime *{
        CSCloseFriendRuntime *r=[[CSCloseFriendRuntime alloc] initWithStore:store wallClock:^NSTimeInterval{return 100;} elapsedClock:^NSTimeInterval{return 20;} credentialReader:^NSDictionary *(NSString *account,NSError **error){NSData *data=secure[SecureKey(account,@"auth")];return data?[NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:error]:nil;} credentialWriter:^BOOL(NSString *account,NSDictionary *credential,NSError **error){NSData *data=[NSPropertyListSerialization dataWithPropertyList:credential format:NSPropertyListBinaryFormat_v1_0 options:0 error:error];if(data)secure[SecureKey(account,@"auth")]=data;return data!=nil;}];
        r.resetStorage=^BOOL(NSString *account,BOOL begin,NSError **error){return begin?[reset beginResetForAccountID:account error:error]:[reset resumeResetForAccountID:account error:error];};
        [r synchronizeAccount:@"account-A" epoch:testEpoch suspended:NO];return r;
    };
    CSCloseFriendRuntime *r=runtime();CSCloseFriendManager *manager=CSCloseFriendManager.sharedManager;manager.runtime=r;manager.entryState=entry;
    Check([r setPassword:@"old-password" token:r.authenticationToken error:NULL],@"fixture creates original verifier");
    NSMutableDictionary *options=[CSCloseFriendDefaultOptions() mutableCopy];options[@"biometric"]=@YES;options[@"hidePluginEntry"]=@YES;
    Check([r updateProfile:@{@"enabled":@YES,@"friends":@[@"secret"],@"groups":@[@"secret@chatroom"],@"options":options} error:NULL],@"fixture persists actual protected lists and options");
    secure[SecureKey(@"account-A",@"biometric-domain")]=[@"old-domain" dataUsingEncoding:NSUTF8StringEncoding];
    [entry discoverEntryForSnapshot:CSCloseFriendCurrentSnapshot() hasCredential:NO];
    NSDictionary *proof=[r prepareResetWithPassword:@"old-password" token:r.authenticationToken error:NULL];
    Check(proof!=nil && [r resetWithToken:proof error:NULL],@"actual original Runtime+Reset completes full reset");
    Check(secure.count==0,@"full reset removes all secure kinds including old verifier and policy");
    Check(defaults.values.count==0,@"full reset removes account discovery record");
    Check(![[NSFileManager defaultManager] contentsOfDirectoryAtPath:root.path error:NULL].count,@"full reset removes encrypted profile file");
    if(restart){r=runtime();manager.runtime=r;}
    Check(!r.hasCredential && !CSCloseFriendCurrentSnapshot().blocked && !CSCloseFriendCurrentSnapshot().enabled,@"reset memory/restart has empty unblocked setup state");
    Check(![manager settingsEntryVisible],@"reset hides ordinary settings entry");
    Check(r.authenticationToken!=nil,@"setup authentication token exists without old verifier");
    CSCustomViewController *page=[CSCustomViewController new];page.avatarImageView=[UIView new];page.tableView=[TestTable new];page.isAuthorized=YES;page.navigationController=[[UINavigationController alloc] initWithRootViewController:page];
    [page installCloseFriendEntryGesture];
    Check(page.closeFriendEntryGesture.minimumPressDuration==2.0,@"actual existing longpress threshold remains two seconds");
    Check([page gestureRecognizer:page.closeFriendEntryGesture shouldReceiveTouch:[UITouch new]],@"actual touch delegate obtains discovery token after reset");
    Check(page.closeFriendEntryToken!=nil,@"discovery token does not depend on removed verifier");
    page.closeFriendEntryGesture.state=UIGestureRecognizerStateBegan;[page discoverCloseFriendEntry:page.closeFriendEntryGesture];
    Check(page.entryVisible && [manager settingsEntryVisible],@"actual longpress+Manager+EntryState discovers ordinary entry");
    Check(defaults.values.count==1,@"only account discovery record added");
    Check(secure.count==0 && !r.hasCredential,@"discovery does not recreate verifier or policy key");
    manager.lastError=nil;[manager presentSettingsFrom:page];
    UIAlertController *alert=(id)page.presentedViewController;
    Check([alert isKindOfClass:UIAlertController.class] && [alert.title isEqual:@"设置密友密码"],@"actual ordinary present/authenticate chooses initial setup prompt");
    Check(alert.textFields.count==2 && [alert.textFields.firstObject.textContentType isEqual:UITextContentTypeNewPassword],@"actual setup requires two new password fields");
    Check(biometricCalls==0,@"missing old verifier never enters biometric logic");
    alert.textFields.firstObject.text=@"new-password";alert.textFields.lastObject.text=@"new-password";Action(alert,@"确定");
    Check(manager.lastError==nil && r.hasCredential && r.isAuthorized,@"actual passwordPrompt writes new verifier and authorizes normally");
    Check([page.navigationController.topViewController isKindOfClass:CSCloseFriendSettingsViewController.class],@"ordinary setup completion navigates into settings");
    Check(secure.count==1 && secure[SecureKey(@"account-A",@"auth")]!=nil,@"only new auth kind created by setup");
    [r lock];Check(!r.isAuthorized,@"new password state locks normally");
    Check(![r authenticatePassword:@"old-password" token:r.authenticationToken error:NULL] && !r.isAuthorized,@"deleted old password cannot unlock new setup");
    Check([r authenticatePassword:@"new-password" token:r.authenticationToken error:NULL] && r.isAuthorized,@"new password unlocks after normal lock");
    [r lock];Check(!r.isAuthorized,@"second lock revokes authorization normally");
}
int main(int argc,const char **argv){@autoreleasepool{
    if(argc!=2)return 2;NSURL *root=[NSURL fileURLWithPath:@(argv[1]) isDirectory:YES];
    Scenario([root URLByAppendingPathComponent:@"same-process" isDirectory:YES],NO);
    Scenario([root URLByAppendingPathComponent:@"fresh-process-model" isDirectory:YES],YES);
    fprintf(stdout,"new-password production path: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
    return failures?1:0;
}}
