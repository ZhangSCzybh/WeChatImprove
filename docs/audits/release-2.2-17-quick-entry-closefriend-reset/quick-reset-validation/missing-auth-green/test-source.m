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
static NSString *CSCloseFriendResolveAccount(__unused Class(^resolver)(NSString *)){return @"a";}
static NSUInteger testEpoch=1; static BOOL testSuspended;
static NSUInteger CSBackupAccountEpoch(void){return testEpoch;}
static NSUInteger CSCloseFriendAccountEpoch(void){return testEpoch;}
static BOOL CSBackupAccountIsSuspended(void){return testSuspended;}
static BOOL CSBackupPerformAtAccountEpoch(NSUInteger epoch,void(^block)(void)){if(epoch!=testEpoch)return NO;block();return YES;}
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
@property(nonatomic,copy) void(^beforeRemoval)(void);
@property(nonatomic) NSUInteger removals;
@end
@implementation ResetStore
- (BOOL)removeStateForAccountID:(NSString *)account error:(NSError **)error {
    self.removals++; if(self.beforeRemoval)self.beforeRemoval();
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
@property(nonatomic,copy) void(^cleanupObserver)(NSString *kind);
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
            if(weakSelf.cleanupObserver)weakSelf.cleanupObserver(kind);
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

@class UIGestureRecognizer,UINavigationController,UIViewController;
@protocol UIViewControllerTransitionCoordinatorContext @end
@protocol UIViewControllerTransitionCoordinator
- (BOOL)animateAlongsideTransition:(void (^)(id<UIViewControllerTransitionCoordinatorContext>))animation completion:(void (^)(id<UIViewControllerTransitionCoordinatorContext>))completion;
@end
@interface TestTransition : NSObject <UIViewControllerTransitionCoordinator>
@property(nonatomic,copy) void (^completion)(id<UIViewControllerTransitionCoordinatorContext>);
@end
@implementation TestTransition
- (BOOL)animateAlongsideTransition:(__unused void (^)(id<UIViewControllerTransitionCoordinatorContext>))animation completion:(void (^)(id<UIViewControllerTransitionCoordinatorContext>))completion{self.completion=completion;return YES;}
@end
@interface UIView : NSObject
@property(nonatomic,strong) id window;
@property(nonatomic) BOOL userInteractionEnabled;
@property(nonatomic,strong) NSMutableArray *gestures;
- (void)addGestureRecognizer:(UIGestureRecognizer *)g;
@end
@implementation UIView
- (void)addGestureRecognizer:(UIGestureRecognizer *)g{if(!self.gestures)self.gestures=[NSMutableArray new];[self.gestures addObject:g];}
@end
@interface TableView : UIView
@property(nonatomic) NSUInteger reloads;
- (void)reloadData;
- (void)deselectRowAtIndexPath:(NSIndexPath *)p animated:(BOOL)animated;
@end
@implementation TableView
- (void)reloadData{self.reloads++;}
- (void)deselectRowAtIndexPath:(__unused NSIndexPath *)p animated:(__unused BOOL)animated{}
@end
@interface UIViewController : NSObject
@property(nonatomic,strong) UIView *view;
@property(nonatomic,strong) id<UIViewControllerTransitionCoordinator> transitionCoordinator;
@property(nonatomic,strong) UIViewController *presentedViewController;
@property(nonatomic,weak) UIViewController *presentingViewController;
@property(nonatomic,strong) UINavigationController *navigationController;
@property(nonatomic,getter=isMovingFromParentViewController) BOOL movingFromParentViewController;
@property(nonatomic,getter=isBeingDismissed) BOOL beingDismissed;
- (void)viewWillDisappear:(BOOL)animated;
- (void)willMoveToParentViewController:(UIViewController *)parent;
- (void)presentViewController:(UIViewController *)controller animated:(BOOL)animated completion:(void (^)(void))completion;
- (void)dismissViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion;
@end
@implementation UIViewController
- (void)viewWillDisappear:(__unused BOOL)animated{}
- (void)willMoveToParentViewController:(__unused UIViewController *)parent{}
- (void)presentViewController:(UIViewController *)c animated:(__unused BOOL)animated completion:(void (^)(void))completion{self.presentedViewController=c;c.presentingViewController=self;if(completion)completion();}
- (void)dismissViewControllerAnimated:(__unused BOOL)animated completion:(void (^)(void))completion{if(self.presentingViewController)self.presentingViewController.presentedViewController=nil;else self.presentedViewController=nil;if(completion)completion();}
@end
@interface UINavigationController : UIViewController
@property(nonatomic,strong) UIViewController *topViewController;
@property(nonatomic,strong) NSMutableArray<UIViewController *> *viewControllers;
- (void)pushViewController:(UIViewController *)c animated:(BOOL)animated;
- (instancetype)initWithRootViewController:(UIViewController *)c;
@end
@implementation UINavigationController
- (instancetype)initWithRootViewController:(UIViewController *)c {if((self=[super init]))[self pushViewController:c animated:NO];return self;}
- (void)pushViewController:(UIViewController *)c animated:(__unused BOOL)animated{self.topViewController=c;c.navigationController=self;if(!self.viewControllers)self.viewControllers=[NSMutableArray new];[self.viewControllers addObject:c];}
@end
@interface UIApplication : NSObject
@property(nonatomic) NSInteger applicationState;
+ (instancetype)sharedApplication;
@end
@implementation UIApplication
+ (instancetype)sharedApplication{static UIApplication *a;if(!a)a=[self new];return a;}
@end
enum{UIApplicationStateActive,UIGestureRecognizerStatePossible,UIGestureRecognizerStateBegan,UIGestureRecognizerStateEnded,UIGestureRecognizerStateCancelled,UIGestureRecognizerStateFailed,UIImpactFeedbackStyleLight,UIAlertControllerStyleAlert,UIAlertActionStyleDefault,UIAlertActionStyleCancel,UIAlertActionStyleDestructive,UITableViewStyleInsetGrouped};
@interface UIGestureRecognizer : NSObject
@property(nonatomic) NSInteger state;
@property(nonatomic) BOOL cancelsTouchesInView;
@property(nonatomic,weak) id delegate,target;
@property(nonatomic) SEL action;
@property(nonatomic,weak) UIGestureRecognizer *requiredToFail;
- (instancetype)initWithTarget:(id)target action:(SEL)action;
- (void)requireGestureRecognizerToFail:(UIGestureRecognizer *)g;
@end
@implementation UIGestureRecognizer
- (instancetype)initWithTarget:(id)t action:(SEL)a{if((self=[super init])){self.target=t;self.action=a;}return self;}
- (void)requireGestureRecognizerToFail:(UIGestureRecognizer *)g{self.requiredToFail=g;}
@end
@interface UITapGestureRecognizer : UIGestureRecognizer
@property(nonatomic) NSUInteger numberOfTapsRequired,numberOfTouchesRequired;
@end
@implementation UITapGestureRecognizer @end
@interface UILongPressGestureRecognizer : UIGestureRecognizer
@property(nonatomic) NSTimeInterval minimumPressDuration;
@property(nonatomic) double allowableMovement;
@property(nonatomic) NSUInteger numberOfTouchesRequired;
@end
@implementation UILongPressGestureRecognizer @end
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
@interface UIAlertAction : NSObject
@property(nonatomic,strong) NSString *title;
@property(nonatomic) NSInteger style;
@property(nonatomic,copy) void (^handler)(UIAlertAction *);
+ (instancetype)actionWithTitle:(NSString *)title style:(NSInteger)style handler:(void (^)(UIAlertAction *))handler;
@end
@implementation UIAlertAction
+ (instancetype)actionWithTitle:(NSString *)t style:(__unused NSInteger)s handler:(void (^)(UIAlertAction *))h{UIAlertAction *a=[self new];a.title=t;a.style=s;a.handler=h;return a;}
@end
@interface UITextField : NSObject
@property(nonatomic,copy) NSString *text,*textContentType,*placeholder;
@property(nonatomic) BOOL secureTextEntry;
@end
@implementation UITextField @end
static NSString *UITextContentTypePassword=@"password";
@interface UIAlertController : UIViewController
@property(nonatomic,strong) NSString *title,*message;
@property(nonatomic,strong) NSMutableArray<UIAlertAction *> *actions;
@property(nonatomic,strong) NSMutableArray<UITextField *> *textFields;
- (void)addTextFieldWithConfigurationHandler:(void(^)(UITextField *))config;
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(NSInteger)style;
- (void)addAction:(UIAlertAction *)action;
@end
@implementation UIAlertController
+ (instancetype)alertControllerWithTitle:(NSString *)t message:(NSString *)m preferredStyle:(__unused NSInteger)s{UIAlertController *a=[self new];a.title=t;a.message=m;a.actions=[NSMutableArray new];return a;}
- (void)addAction:(UIAlertAction *)a{[self.actions addObject:a];}
- (void)addTextFieldWithConfigurationHandler:(void(^)(UITextField *))config{if(!self.textFields)self.textFields=[NSMutableArray new];UITextField *f=[UITextField new];config(f);[self.textFields addObject:f];}
@end

@interface NSIndexPath (Rows)
@property(nonatomic,readonly) NSInteger section,row;
@end
@implementation NSIndexPath (Rows)
- (NSInteger)section{return [self indexAtPosition:0];}
- (NSInteger)row{return [self indexAtPosition:1];}
@end
@interface CSCloseFriendRuntime (QuickResetContract)
- (NSDictionary *)prepareResetWithSettingsToken:(NSDictionary *)token error:(NSError **)error;
@end
@class CSCloseFriendSettingsViewController;
@interface CSCloseFriendManager : NSObject
@property(nonatomic,strong) CSCloseFriendRuntime *runtime;
@property(nonatomic) BOOL backgroundCoverRequired,authenticating,lastRevealed;
@property(nonatomic,strong) NSString *lastMessage;
+ (instancetype)sharedManager;
- (void)refreshAccount;
- (void)flushPolicyRefresh;
- (void)recordCapability:(NSString *)name available:(BOOL)available;
- (void)message:(NSString *)message presenter:(UIViewController *)presenter;
#include "ManagerDeclarations.h"
@end
@interface CSCloseFriendManager (QuickResetContract)
- (void)resetFrom:(UIViewController *)presenter settingsToken:(NSDictionary *)token completion:(void(^)(BOOL))completion;
@end
@implementation CSCloseFriendManager
+ (instancetype)sharedManager{static CSCloseFriendManager *m;if(!m)m=[self new];return m;}
- (void)recordCapability:(__unused NSString *)name available:(__unused BOOL)available{}
- (void)flushPolicyRefresh{}
- (void)message:(NSString *)message presenter:(__unused UIViewController *)presenter{self.lastMessage=message;}
#include "ManagerMethods.h"
@end
static CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void){return [CSCloseFriendManager.sharedManager.runtime snapshotForEpoch:testEpoch suspended:testSuspended];}
static void CSNativeContactPickerRevalidate(__unused UIViewController *c){}
@interface CSCloseFriendSettingsViewController : UIViewController
@property(nonatomic,copy) NSDictionary *quickEntryToken;
@property(nonatomic) BOOL quickEntry,requestingAuthentication,resetFinished,left;
@property(nonatomic,strong) TableView *tableView;
@property(nonatomic,strong) NSError *lastError;
- (void)showError:(NSError *)error;
- (void)leaveAfterReset;
#include "SettingsDeclarations.h"
@end
@implementation CSCloseFriendSettingsViewController
- (void)showError:(NSError *)e{self.lastError=e;}
- (void)leaveAfterReset{self.left=YES;}
#include "SettingsMethods.h"
@end
static CSCloseFriendSettingsViewController *Page(CSCloseFriendRuntime *r,BOOL quick){
 CSCloseFriendManager.sharedManager.runtime=r;CSCloseFriendManager.sharedManager.authenticating=NO;CSCloseFriendManager.sharedManager.backgroundCoverRequired=NO;
 CSCloseFriendSettingsViewController *p=[CSCloseFriendSettingsViewController new];p.view=[UIView new];p.view.window=@YES;p.tableView=[TableView new];p.quickEntry=quick;p.quickEntryToken=quick?[r settingsAccessToken]:nil;
 UINavigationController *n=[UINavigationController new];n.topViewController=p;p.navigationController=n;return p;
}
static UIAlertAction *Action(UIAlertController *a,NSString *title){for(UIAlertAction *x in a.actions)if([x.title isEqual:title])return x;return nil;}
static BOOL Click(CSCloseFriendSettingsViewController *p,NSString *title){UIAlertController *a=(id)p.presentedViewController;UIAlertAction *x=Action(a,title);if(!x)return NO;if(x.style==UIAlertActionStyleCancel){p.presentedViewController=nil;a.presentingViewController=nil;}if(x.handler)x.handler(x);return YES;}
static void Select(CSCloseFriendSettingsViewController *p,NSUInteger section,NSUInteger row){NSUInteger v[]={section,row};[p tableView:p.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathWithIndexes:v length:2]];}
static NSDictionary *Persistent(ResetFixture *f){NSMutableDictionary *d=[NSMutableDictionary new];d[@"secure"]=[f.secure copy];d[@"defaults"]=[f.defaults persistentDomainForName:f.suite]?:@{};NSMutableDictionary *files=[NSMutableDictionary new];for(NSURL *u in [NSFileManager.defaultManager contentsOfDirectoryAtURL:f.root includingPropertiesForKeys:nil options:0 error:NULL])files[u.lastPathComponent]=[NSData dataWithContentsOfURL:u];d[@"files"]=files;return d;}
static NSDictionary *Other(ResetFixture *f){NSMutableDictionary *d=[NSMutableDictionary new];for(NSString *k in f.secure)if([k hasPrefix:@"b/"])d[k]=f.secure[k];d[@"state"]=[f stateBytes:@"b"];id key=[f.entry valueForKey:@"defaults"];(void)key;CSCloseFriendRuntime *r=[f runtimeFor:@"b"];d[@"discovered"]=@([f.entry hasDiscoveredEntryForSnapshot:[r snapshotForEpoch:1 suspended:NO] hasCredential:NO]);return d;}
static void FlowTests(void){
 ResetFixture *f=[ResetFixture new];CSCloseFriendRuntime *r=[f configured:@"a"];[f configured:@"b"];[r lock];NSDictionary *other=Other(f);ActiveFixture=f;CSCloseFriendSettingsViewController *p=Page(r,YES);NSDictionary *before=Persistent(f);NSDictionary *visit=p.quickEntryToken;
 Select(p,0,3);Check(p.lastError!=nil,"quick change password remains blocked");p.lastError=nil;
 Select(p,2,0);Check(p.presentedViewController!=nil && !p.lastError,"quick reset enters first confirmation instead of rejection");
 if(p.presentedViewController){
  UIAlertController *a=(id)p.presentedViewController;Check([a.message containsString:@"已解锁手机"],"first step explicitly warns unlocked-phone access");Check([a.message containsString:@"微信好友、聊天记录、免打扰设置和其他账号不受影响"],"first step states unaffected data");Check([Persistent(f) isEqual:before],"showing first step writes zero persistent bytes");
  Check(Click(p,@"取消"),"first cancel available");Check([Persistent(f) isEqual:before],"first cancel changes no persistent byte");Select(p,2,0);Check(Click(p,@"继续"),"first continue action available");
  a=(id)p.presentedViewController;Check(Action(a,@"重置密友").style==UIAlertActionStyleDestructive,"second action uses original destructive style");Check([a.message containsString:@"入口发现记录"],"second confirmation enumerates discovery deletion");Check([Persistent(f) isEqual:before],"preparing proof writes no persistent bytes");Check(Click(p,@"取消"),"second cancel available");Check([Persistent(f) isEqual:before],"second cancel changes no persistent byte");
  Select(p,2,0);Click(p,@"继续");Check(Click(p,@"重置密友"),"second confirmation executes original reset");
  Check(![f stateBytes:@"a"],"current encrypted lists and options removed");for(NSString *kind in @[@"auth",@"biometric-domain",@"policy",@"reset"])Check(!f.secure[[@"a/" stringByAppendingString:kind]],"current secure reset resources removed");
  Check(![f.entry hasDiscoveredEntryForSnapshot:[r snapshotForEpoch:1 suspended:NO] hasCredential:NO],"entry discovery cleared");Check(![r.currentProfile[@"enabled"] boolValue] && [r.currentProfile[@"friends"] count]==0 && [r.currentProfile[@"groups"] count]==0,"protection off and both lists empty");Check([r.currentProfile[@"options"] isEqual:CSCloseFriendDefaultOptions()],"all options restored to reset defaults");Check(![f.entry isEntryVisibleForSnapshot:[r snapshotForEpoch:1 suspended:NO] hasCredential:r.hasCredential],"entry hidden after reset");Check(p.resetFinished && p.left && !p.quickEntryToken && ![r isSettingsTokenCurrent:visit],"success revokes quick page and leaves through resetFinished");Check(!p.authorized,"departed quick page cannot reenter without new five taps");
  Check([Other(f) isEqual:other],"other account key set and every value/state/discovery unchanged");
  Check(!r.hasCredential && r.authenticationToken!=nil,"fresh reset no verifier remains and ordinary setup token available");Check([r setPassword:@"new-secret-2217" token:r.authenticationToken error:NULL],"new password can be created after reset");[r lock];Check(![r authenticatePassword:@"123456" token:r.authenticationToken error:NULL],"old password invalid after reset");Check([r authenticatePassword:@"new-secret-2217" token:r.authenticationToken error:NULL],"new password normally unlocks after lock");
 }
 [f cleanup];
}
static void ScopeTests(void){
 for(NSString *scenario in @[@"epoch",@"background",@"leave",@"account",@"suspended",@"new-modal"]){ResetFixture *f=[ResetFixture new];CSCloseFriendRuntime *r=[f configured:@"a"];[r lock];CSCloseFriendSettingsViewController *p=Page(r,YES);NSDictionary *before=Persistent(f);Select(p,2,0);if(p.presentedViewController){Click(p,@"继续");UIAlertController *a=(id)p.presentedViewController;UIAlertAction *destructive=Action(a,@"重置密友");if([scenario isEqual:@"epoch"])testEpoch=2;if([scenario isEqual:@"background"])UIApplication.sharedApplication.applicationState=1;if([scenario isEqual:@"leave"])p.navigationController.topViewController=[UIViewController new];if([scenario isEqual:@"account"])[r synchronizeAccount:@"b" epoch:2 suspended:NO];if([scenario isEqual:@"suspended"])testSuspended=YES;if([scenario isEqual:@"new-modal"])p.presentedViewController=[UIViewController new];if(destructive.handler)destructive.handler(destructive);Check([Persistent(f) isEqual:before],"stale page/account/epoch/background/modal cannot reset any byte");}testEpoch=1;testSuspended=NO;UIApplication.sharedApplication.applicationState=0;[f cleanup];}
}
static void ResumeTests(void){
 if(![CSCloseFriendRuntime instancesRespondToSelector:@selector(prepareResetWithSettingsToken:error:)]){Check(NO,"runtime supports scoped preparation");return;}
 for(NSString *cut in @[@"state",@"biometric-domain",@"auth",@"policy",@"reset"]){ResetFixture *f=[ResetFixture new];CSCloseFriendRuntime *r=[f configured:@"a"];[f configured:@"b"];[r lock];NSDictionary *other=Other(f);ActiveFixture=f;NSDictionary *visit=[r settingsAccessToken];NSDictionary *proof=[r prepareResetWithSettingsToken:visit error:NULL];NSData *initialState=[f stateBytes:@"a"];
 f.store.beforeRemoval=^{Check([r snapshotForEpoch:1 suspended:NO].blocked && !r.currentProfile && ![r settingsAccessToken],"intent window exposes no policy/list or fresh quick token");};
 f.cleanupObserver=^(__unused NSString *kind){Check([r snapshotForEpoch:1 suspended:NO].blocked && !r.currentProfile && ![r settingsAccessToken] && ![r isSettingsTokenCurrent:visit],"every secure deletion stage stays fail-closed to original and copied visit");};
 if([cut isEqual:@"state"])f.store.failRemoval=YES;else f.failure=[@"remove:" stringByAppendingString:cut];
 Check(![r resetWithToken:proof error:NULL],"injected interruption fails closed");Check(f.secure[@"a/reset"]!=nil,"durable forward-only intent retained at every cut");Check([r snapshotForEpoch:1 suspended:NO].blocked && !r.authenticationToken && !r.currentProfile && ![r settingsAccessToken],"partially removed state inaccessible through all runtime entry points");if([cut isEqual:@"state"])Check([[f stateBytes:@"a"] isEqual:initialState] && f.secure[@"a/policy"]!=nil,"intent-after-write before-state cut preserves list and decryption key");
 f.failure=nil;f.store.failRemoval=NO;f.store.beforeRemoval=nil;f.cleanupObserver=nil;CSCloseFriendRuntime *restart=[f runtimeFor:@"a"];Check(![restart snapshotForEpoch:1 suspended:NO].blocked && !restart.hasCredential && [restart.currentProfile[@"friends"] count]==0,"process restart resumes intent completely before publishing empty profile");Check(![f stateBytes:@"a"] && !f.secure[@"a/policy"] && !f.secure[@"a/auth"] && !f.secure[@"a/biometric-domain"] && !f.secure[@"a/reset"],"resume removes all current resources and clears intent last");Check([Other(f) isEqual:other],"all interruption cuts preserve other-account bytes/key sets");[f cleanup];}
}
static void MissingCredentialTests(void){
 ResetFixture *f=[ResetFixture new];[f configured:@"a"];[f configured:@"b"];NSDictionary *other=Other(f);[f.secure removeObjectForKey:@"a/auth"];[f.secure removeObjectForKey:@"a/biometric-domain"];f.secure[@"a/credential-reset"]=[@"close-friends-credential-setup-v1" dataUsingEncoding:NSUTF8StringEncoding];CSCloseFriendRuntime *r=[f runtimeFor:@"a"];Check([r snapshotForEpoch:1 suspended:NO].blocked && !r.authenticationToken,"persisted policy without verifier stays ordinary fail-closed");Check(!f.secure[@"a/credential-reset"],"old credential-reset marker still cleaned before entering");CSCloseFriendSettingsViewController *p=Page(r,YES);Select(p,2,0);Check(p.presentedViewController!=nil,"missing-auth valid policy enters quick reset explanation");if(p.presentedViewController){Click(p,@"继续");Check(Action((id)p.presentedViewController,@"重置密友")!=nil,"missing-auth valid visit reaches final confirmation across refresh");Click(p,@"重置密友");Check(p.resetFinished && p.left && ![f stateBytes:@"a"] && !f.secure[@"a/policy"],"missing-auth quick reset succeeds after final real Manager refresh");Check(!p.quickEntryToken && !r.hasCredential && ![r.currentProfile[@"enabled"] boolValue],"missing-auth final reset revokes page and leaves clean setup state");Check([Other(f) isEqual:other],"missing-auth reset preserves all other-account bytes");}[f cleanup];
}
static void PreparationFailureTests(void){
 if(![CSCloseFriendRuntime instancesRespondToSelector:@selector(prepareResetWithSettingsToken:error:)])return;
 for(NSNumber *quick in @[@YES,@NO]) {
  ResetFixture *f=[ResetFixture new];CSCloseFriendRuntime *r=[f configured:@"a"];NSDictionary *state=[[r valueForKey:@"state"] copy],*credential=[[r valueForKey:@"credential"] copy];
  NSDictionary *proof=nil,*visit=nil;if(quick.boolValue){[r lock];visit=[r settingsAccessToken];proof=[r prepareResetWithSettingsToken:visit error:NULL];}else proof=[r prepareResetWithPassword:@"123456" token:r.authenticationToken error:NULL];
  NSDictionary *before=Persistent(f);f.failure=@"write:reset";Check(![r resetWithToken:proof error:NULL],"intent-write failure cannot begin reset");Check([Persistent(f) isEqual:before],"intent-write failure preserves every persisted byte");Check([[r valueForKey:@"state"] isEqual:state] && [[r valueForKey:@"credential"] isEqual:credential],"normal and quick failed reset retain original in-memory state and credential");Check([r snapshotForEpoch:1 suspended:NO].enabled && [r snapshotForEpoch:1 suspended:NO].blocked,"failed reset preserves enabled/options fail-closed snapshot semantics");Check(![r settingsAccessToken] && ![r isSettingsTokenCurrent:visit],"failed intent write cannot reissue page authorization");
  f.failure=nil;[r synchronizeAccount:@"a" epoch:1 suspended:NO];Check([r settingsAccessToken]!=nil,"successful no-pending reload re-enables fresh visit issuance");[f cleanup];
 }
 for(NSString *intent in @[@"unknown-reset",@"close-friends-reset-v1"]){ResetFixture *f=[ResetFixture new];CSCloseFriendRuntime *r=[f configured:@"a"];[r lock];f.secure[@"a/reset"]=[intent dataUsingEncoding:NSUTF8StringEncoding];f.store.failRemoval=YES;r=[f runtimeFor:@"a"];Check([r snapshotForEpoch:1 suspended:NO].blocked && !r.authenticationToken && ![r settingsAccessToken],"unknown or genuine incomplete reset stays strict and never signs settings visit");Check(f.secure[@"a/reset"]!=nil,"strict pending intent retained");[f cleanup];}
}
static void NormalTests(void){ResetFixture *f=[ResetFixture new];CSCloseFriendRuntime *r=[f configured:@"a"];CSCloseFriendSettingsViewController *p=Page(r,NO);NSDictionary *before=Persistent(f);Select(p,2,0);UIAlertController *a=(id)p.presentedViewController;Check([a.title isEqual:@"验证密友密码"] && a.textFields.count==1,"ordinary reset still starts with original password prompt");Click(p,@"取消");Check([Persistent(f) isEqual:before],"ordinary first cancel changes no bytes");Select(p,2,0);a=(id)p.presentedViewController;a.textFields.firstObject.text=@"123456";Click(p,@"验证");Check(Action((id)p.presentedViewController,@"重置密友")!=nil,"ordinary verified password still reaches original destructive confirm");Click(p,@"重置密友");Check(p.resetFinished && p.left && ![f stateBytes:@"a"] && !r.hasCredential,"ordinary original reset still completes");[f cleanup];}
int main(void){@autoreleasepool{FlowTests();ScopeTests();ResumeTests();MissingCredentialTests();PreparationFailureTests();NormalTests();fprintf(stdout,"Quick reset: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);return failures?1:0;}}
