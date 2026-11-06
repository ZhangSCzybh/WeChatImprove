#import <Foundation/Foundation.h>
#import "CSCloseFriendRuntime.h"
#import "CSCloseFriendCrypto.h"
#import "CSCloseFriendReset.h"
@interface CSCloseFriendRuntime (QuickContract)
- (NSDictionary *)settingsAccessToken;
- (BOOL)isSettingsTokenCurrent:(NSDictionary *)token;
- (NSDictionary *)profileForSettingsToken:(NSDictionary *)token;
- (void)invalidateSettingsAccessToken:(NSDictionary *)token;
- (BOOL)updateProfile:(NSDictionary *)profile settingsToken:(NSDictionary *)token error:(NSError **)error;
@end
static NSUInteger checks,failures,testEpoch=1;
static NSMutableDictionary *migrationSecure;
static __attribute__((unused)) BOOL CSKeychainRemove(NSString *account,NSString *kind,__unused NSError **error){[migrationSecure removeObjectForKey:[NSString stringWithFormat:@"%@/%@",account,kind]];return YES;}
static BOOL testSuspended;
static __attribute__((unused)) NSUInteger CSCloseFriendAccountEpoch(void){return testEpoch;}
static __attribute__((unused)) BOOL CSBackupAccountIsSuspended(void){return testSuspended;}
static __attribute__((unused)) BOOL CSBackupPerformAtAccountEpoch(NSUInteger epoch,void (^block)(void)){if(epoch!=testEpoch)return NO;block();return YES;}
static void Check(BOOL b,NSString *s){checks++;if(!b){failures++;fprintf(stderr,"FAIL %s\n",s.UTF8String);}}
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
@end
@implementation TableView
- (void)reloadData{self.reloads++;}
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
@property(nonatomic,copy) void (^handler)(UIAlertAction *);
+ (instancetype)actionWithTitle:(NSString *)title style:(NSInteger)style handler:(void (^)(UIAlertAction *))handler;
@end
@implementation UIAlertAction
+ (instancetype)actionWithTitle:(NSString *)t style:(__unused NSInteger)s handler:(void (^)(UIAlertAction *))h{UIAlertAction *a=[self new];a.title=t;a.handler=h;return a;}
@end
@interface UIAlertController : UIViewController
@property(nonatomic,strong) NSString *title,*message;
@property(nonatomic,strong) NSMutableArray<UIAlertAction *> *actions;
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(NSInteger)style;
- (void)addAction:(UIAlertAction *)action;
@end
@implementation UIAlertController
+ (instancetype)alertControllerWithTitle:(NSString *)t message:(NSString *)m preferredStyle:(__unused NSInteger)s{UIAlertController *a=[self new];a.title=t;a.message=m;a.actions=[NSMutableArray new];return a;}
- (void)addAction:(UIAlertAction *)a{[self.actions addObject:a];}
@end
@interface CSCloseFriendManager : NSObject
@property(nonatomic,strong) CSCloseFriendRuntime *runtime;
@property(nonatomic) NSUInteger discoveries;
+ (instancetype)sharedManager;
- (NSDictionary *)settingsEntryDiscoveryToken;
- (BOOL)discoverSettingsEntryWithToken:(NSDictionary *)token;
- (void)refreshAccount;
@end
@implementation CSCloseFriendManager
+ (instancetype)sharedManager{static CSCloseFriendManager *m;if(!m)m=[self new];return m;}
- (NSDictionary *)settingsEntryDiscoveryToken{return self.runtime.authenticationToken;}
- (BOOL)discoverSettingsEntryWithToken:(NSDictionary *)token{if(![self.runtime isTokenCurrent:token])return NO;self.discoveries++;return YES;}
- (void)refreshAccount{}
@end
static UIViewController *CSNativeSettingsHostForContent(UIViewController *c){return c;}
static CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void){return [CSCloseFriendManager.sharedManager.runtime snapshotForEpoch:1 suspended:NO];}
static __attribute__((unused)) NSDictionary *CSCloseFriendCurrentProfile(void){return CSCloseFriendCurrentSnapshot().blocked?nil:CSCloseFriendManager.sharedManager.runtime.currentProfile;}
static __attribute__((unused)) void CSNativeContactPickerRevalidate(__unused UIViewController *c){}
static BOOL CSCloseFriendUpdateCurrentProfile(NSDictionary *profile,NSError **error){return [CSCloseFriendManager.sharedManager.runtime updateProfile:profile error:error];}
@interface CSCloseFriendSettingsViewController : UIViewController
@property(nonatomic,copy) NSDictionary *quickEntryToken;
@property(nonatomic) BOOL quickEntry;
@property(nonatomic,strong) TableView *tableView;
@property(nonatomic,strong) NSError *lastError;
- (void)showError:(NSError *)error;
- (instancetype)initWithStyle:(NSInteger)style;
#include "SettingsDeclarations.h"
@end
@interface CSCloseFriendSettingsViewController (QuickContract)
- (NSDictionary *)settingsProfile;
@end
@implementation CSCloseFriendSettingsViewController
- (void)showError:(NSError *)error{self.lastError=error?:[NSError errorWithDomain:@"QuickTest" code:1 userInfo:nil];}
- (instancetype)initWithStyle:(__unused NSInteger)s{if((self=[super init])){self.view=[UIView new];self.view.window=@YES;self.tableView=[TableView new];}return self;}
#include "SettingsMethods.h"
@end
@interface CSCustomViewController : UIViewController
@property(nonatomic,strong) UIView *avatarImageView;
@property(nonatomic,strong) TableView *tableView;
@property(nonatomic) BOOL isAuthorized,authorizationPromptInFlight;
@property(nonatomic,strong) UILongPressGestureRecognizer *closeFriendEntryGesture;
@property(nonatomic,copy) NSDictionary *closeFriendEntryToken;
@property(nonatomic,strong) UITapGestureRecognizer *closeFriendQuickEntryGesture;
@property(nonatomic,copy) NSDictionary *closeFriendQuickEntryToken;
@property(nonatomic) NSUInteger closeFriendQuickEntryCount;
@property(nonatomic) NSTimeInterval closeFriendQuickEntryLastTap;
#include "CustomDeclarations.h"
- (void)setupData;
@end
@implementation CSCustomViewController
- (void)setupData{}
#include "CustomMethods.h"
@end
@interface CSCustomViewController (FutureQuick)
- (void)tapCloseFriendQuickEntry:(UITapGestureRecognizer *)gesture;
- (void)resetCloseFriendQuickEntry;
- (NSTimeInterval)closeFriendQuickEntryTimestamp;
@end
static NSTimeInterval testNow;
@interface TestCustom : CSCustomViewController @end
@implementation TestCustom
- (NSTimeInterval)closeFriendQuickEntryTimestamp{return testNow;}
@end
static void ClickAction(UIAlertController *a,NSString *title){for(UIAlertAction *x in a.actions)if([x.title isEqual:title] && x.handler){x.handler(x);return;}Check(NO,@"requested action exists");}
static CSCustomViewController *Page(void){CSCustomViewController *c=[TestCustom new];c.view=[UIView new];c.view.window=@YES;c.avatarImageView=[UIView new];c.tableView=[TableView new];c.isAuthorized=YES;c.navigationController=[UINavigationController new];c.navigationController.topViewController=c;[c installCloseFriendEntryGesture];return c;}
static void Tap(CSCustomViewController *c,NSTimeInterval time){testNow=time;UITapGestureRecognizer *g=c.closeFriendQuickEntryGesture;if(!g){return;}[c gestureRecognizer:g shouldReceiveTouch:[UITouch new]];g.state=UIGestureRecognizerStateEnded;[c tapCloseFriendQuickEntry:g];}
static void Confirm(CSCustomViewController *c){UIAlertController *a=(id)c.presentedViewController;UIAlertAction *action=nil;for(UIAlertAction *x in a.actions)if([x.title isEqual:@"进入密友设置"])action=x;Check(action!=nil,@"risk confirmation action");if(action.handler)action.handler(action);}
static CSCloseFriendRuntime *MakeRuntime(NSURL *root,BOOL missingCredential){NSData *key=CSCloseFriendRandomBytes(64,NULL);CSCloseFriendStore *store=[[CSCloseFriendStore alloc] initWithRoot:root keyProvider:^NSData *(__unused NSString *account,__unused NSError **error){return key;}];NSDictionary *state=@{@"profile":@{@"enabled":@YES,@"friends":@[@"secret"],@"groups":@[@"secret@chatroom"],@"options":CSCloseFriendDefaultOptions()},@"muteRecords":@{}};Check([store saveState:state forAccountID:@"account-A" error:NULL],@"isolated state save");NSData *salt=CSCloseFriendRandomBytes(32,NULL);NSDictionary *credential=@{@"salt":salt,@"verifier":CSCloseFriendPasswordVerifier(@"12345678",salt,210000,NULL),@"iterations":@210000,@"failures":@0,@"cooldown":@0};CSCloseFriendRuntime *r=[[CSCloseFriendRuntime alloc] initWithStore:store wallClock:^NSTimeInterval{return 100;} elapsedClock:^NSTimeInterval{return 20;} credentialReader:^NSDictionary *(__unused NSString *account,__unused NSError **error){return missingCredential?nil:credential;} credentialWriter:^BOOL(__unused NSString *account,__unused NSDictionary *c,__unused NSError **error){return YES;}];[r synchronizeAccount:@"account-A" epoch:1 suspended:NO];return r;}
static NSDictionary *Bytes(NSURL *root){NSMutableDictionary *all=[NSMutableDictionary new];for(NSURL *url in [NSFileManager.defaultManager contentsOfDirectoryAtURL:root includingPropertiesForKeys:nil options:0 error:NULL])if([url.lastPathComponent hasSuffix:@".bin"])all[url.lastPathComponent]=[NSData dataWithContentsOfURL:url];return all;}
static void MigrationQuickEntry(NSURL *root,BOOL hiddenPlugin){
    NSData *key=CSCloseFriendRandomBytes(64,NULL);
    CSCloseFriendStore *store=[[CSCloseFriendStore alloc] initWithRoot:root keyProvider:^NSData *(__unused NSString *a,__unused NSError **e){return key;}];
    NSMutableDictionary *options=[CSCloseFriendDefaultOptions() mutableCopy];options[@"hidePluginEntry"]=@(hiddenPlugin);
    NSDictionary *profile=@{@"enabled":@YES,@"friends":@[@"migrated-secret"],@"groups":@[@"migrated@chatroom"],@"options":options};
    Check([store saveState:@{@"profile":profile,@"muteRecords":@{}} forAccountID:@"account-A" error:NULL],@"migration current account state persists");
    Check([store saveState:@{@"profile":profile,@"muteRecords":@{}} forAccountID:@"account-B" error:NULL],@"migration other account state persists");
    NSDictionary *before=Bytes(root);
    NSData *marker=[@"close-friends-credential-setup-v1" dataUsingEncoding:NSUTF8StringEncoding];
    migrationSecure=[@{@"account-A/credential-reset":marker,@"account-B/credential-reset":marker} mutableCopy];
    CSCloseFriendReset *reset=[[CSCloseFriendReset alloc] initWithStore:store entryState:nil reader:^NSData *(NSString *account,NSString *kind,__unused NSError **error){return migrationSecure[[NSString stringWithFormat:@"%@/%@",account,kind]];} writer:^BOOL(NSString *account,NSString *kind,NSData *data,__unused NSError **error){migrationSecure[[NSString stringWithFormat:@"%@/%@",account,kind]]=data;return YES;} remover:^BOOL(NSString *account,NSString *kind,NSError **error){return CSKeychainRemove(account,kind,error);}];
    CSCloseFriendRuntime *_runtime=[[CSCloseFriendRuntime alloc] initWithStore:store wallClock:^NSTimeInterval{return 100;} elapsedClock:^NSTimeInterval{return 20;} credentialReader:^NSDictionary *(__unused NSString *a,__unused NSError **e){return nil;} credentialWriter:^BOOL(__unused NSString *a,__unused NSDictionary *v,__unused NSError **e){return NO;}];
#include "ManagerResetStorageUnderTest.h"
    [_runtime synchronizeAccount:@"account-A" epoch:1 suspended:NO];
    Check(!migrationSecure[@"account-A/credential-reset"],@"actual Manager storage block clears old marker");
    Check([migrationSecure[@"account-B/credential-reset"] isEqual:marker],@"other account marker bytes unchanged");
    Check(_runtime.authenticationToken==nil && !_runtime.isAuthorized,@"migrated missing-auth normal path remains strict");
    CSCloseFriendManager.sharedManager.runtime=_runtime;
    CSCustomViewController *page=Page();for(int i=0;i<5;i++)Tap(page,120+i*.1);
    if(page.presentedViewController)Confirm(page);
    BOOL entered=[page.navigationController.topViewController isKindOfClass:CSCloseFriendSettingsViewController.class];
    Check(entered,hiddenPlugin?@"migration hidden-plugin state permits page-local quick access":@"migration visible-plugin state permits page-local quick access");
    if(entered){CSCloseFriendSettingsViewController *settings=(id)page.navigationController.topViewController;Check([settings authorized],@"migration quick page needs no old credential");Check([[settings settingsProfile][@"friends"] isEqual:profile[@"friends"]],@"migration quick page sees preserved list only in page");}
    Check([[ _runtime snapshotForEpoch:1 suspended:NO] hidesUserName:@"migrated-secret" surface:CSCloseFriendSurfaceSession],@"migration quick access never reveals WeChat sessions");
    Check([Bytes(root) isEqual:before],@"entering migration quick page changes neither account state bytes");
    [_runtime synchronizeAccount:@"account-A" epoch:1 suspended:NO];Check(!migrationSecure[@"account-A/credential-reset"],@"marker stays absent after repeated normal load");
}
int main(int argc,const char **argv){@autoreleasepool{if(argc!=2)return 2;NSURL *root=[NSURL fileURLWithPath:@(argv[1])];CSCloseFriendRuntime *r=MakeRuntime([root URLByAppendingPathComponent:@"normal"],NO);CSCloseFriendManager.sharedManager.runtime=r;CSCustomViewController *c=Page();Check(c.closeFriendEntryGesture.minimumPressDuration==2,@"old longpress remains 2 seconds");Check(c.closeFriendQuickEntryGesture!=nil,@"avatar installs quick tap");Check(c.closeFriendQuickEntryGesture.requiredToFail==c.closeFriendEntryGesture,@"tap explicitly waits for longpress failure");for(int i=0;i<4;i++)Tap(c,1+i*.2);Check(!c.presentedViewController,@"four taps do not enter");Tap(c,1.8);Check(c.presentedViewController!=nil,@"fifth tap offers entry");if(c.presentedViewController){Check([((UIAlertController *)c.presentedViewController).message containsString:@"无需密码"],@"UI admits no-password entry");Check([((UIAlertController *)c.presentedViewController).message containsString:@"已解锁"],@"UI warns unlocked-phone holder");Confirm(c);}Check([c.navigationController.topViewController isKindOfClass:CSCloseFriendSettingsViewController.class],@"five taps enter actual settings without password");Check(!r.isAuthorized && r.revealTimeRemaining==0,@"entry does not authorize or start reveal timer");Check([[r snapshotForEpoch:1 suspended:NO] hidesUserName:@"secret" surface:CSCloseFriendSurfaceSession],@"friend remains hidden in WeChat sessions");Check([[r snapshotForEpoch:1 suspended:NO] hidesUserName:@"secret@chatroom" surface:CSCloseFriendSurfaceSession],@"group remains hidden in WeChat sessions");CSCloseFriendSettingsViewController *settings=(id)c.navigationController.topViewController;if([settings isKindOfClass:CSCloseFriendSettingsViewController.class]){Check([settings authorized],@"page grant opens settings");NSDictionary *copied=[settings.quickEntryToken copy];Check([[r profileForSettingsToken:copied][@"friends"] isEqual:@[@"secret"]],@"page reads preserved list");settings.movingFromParentViewController=YES;[settings viewWillDisappear:NO];Check(![settings authorized] && ![r isSettingsTokenCurrent:copied],@"leaving revokes copied token");Check(![r profileForSettingsToken:copied],@"departed token cannot read list");}
if([r respondsToSelector:@selector(settingsAccessToken)]){NSDictionary *token=[r settingsAccessToken];[r synchronizeAccount:@"account-B" epoch:2 suspended:NO];Check(![r isSettingsTokenCurrent:token],@"account switch cannot inherit page grant");[r synchronizeAccount:@"account-A" epoch:1 suspended:NO];token=[r settingsAccessToken];[r setActive:NO];Check(![r isSettingsTokenCurrent:token],@"background invalidates page grant");[r setActive:YES];}
c=Page();Tap(c,10);Tap(c,10.2);Tap(c,12.2);Tap(c,12.4);Tap(c,12.6);Check(!c.presentedViewController,@"2 second gap resets count, five total do not enter");Tap(c,12.8);Check(!c.presentedViewController,@"new sequence four still no entry");Tap(c,13);Check(c.presentedViewController!=nil,@"fifth fresh tap enters");c=Page();Tap(c,20);Tap(c,20.2);NSUInteger before=CSCloseFriendManager.sharedManager.discoveries;[c gestureRecognizer:c.closeFriendEntryGesture shouldReceiveTouch:[UITouch new]];c.closeFriendEntryGesture.state=UIGestureRecognizerStateBegan;[c discoverCloseFriendEntry:c.closeFriendEntryGesture];Check(CSCloseFriendManager.sharedManager.discoveries==before+1,@"2s longpress still discovers original entry");Check(!c.presentedViewController,@"longpress does not enter quick settings");for(int i=0;i<3;i++)Tap(c,21+i*.2);Check(!c.presentedViewController,@"longpress cleared prior tap count");Check(CSCloseFriendManager.sharedManager.discoveries==before+1,@"taps never trigger discovery");
c=Page();for(int i=0;i<5;i++)Tap(c,30+i*.1);[r synchronizeAccount:@"account-B" epoch:2 suspended:NO];if(c.presentedViewController)Confirm(c);Check(c.navigationController.topViewController==c,@"switch during confirmation refuses entry");[r synchronizeAccount:@"account-A" epoch:1 suspended:NO];c=Page();for(int i=0;i<5;i++)Tap(c,40+i*.1);[r setActive:NO];if(c.presentedViewController)Confirm(c);Check(c.navigationController.topViewController==c,@"background during confirmation refuses entry");[r setActive:YES];
CSCloseFriendRuntime *missing=MakeRuntime([root URLByAppendingPathComponent:@"missing-auth"],YES);Check(missing.authenticationToken==nil && !missing.isAuthorized,@"missing old auth keeps original password path blocked");Check([missing respondsToSelector:@selector(settingsAccessToken)],@"page scope API exists");if([missing respondsToSelector:@selector(settingsAccessToken)]){NSDictionary *token=[missing settingsAccessToken];Check(token!=nil && [missing profileForSettingsToken:token]!=nil,@"legal missing-auth state remains reachable by quick entry");[missing synchronizeAccount:@"account-A" epoch:1 suspended:NO];Check([missing isSettingsTokenCurrent:token],@"same-account missing-auth refresh preserves exact page visit");Check(!missing.isAuthorized && missing.revealTimeRemaining==0,@"missing-auth quick grant preserves locked state");[missing invalidateSettingsAccessToken:token];Check(![missing isSettingsTokenCurrent:token],@"missing-auth grant can be revoked");}
if([r respondsToSelector:@selector(settingsAccessToken)]) {
    CSCloseFriendManager.sharedManager.runtime=r;
    c=Page();NSTimeInterval boundaryTime=50;for(int i=0;i<5;i++){Tap(c,boundaryTime);boundaryTime+=.8;}Check(c.presentedViewController!=nil,@"inclusive 0.8 second gap accepted");
    UIAlertController *a=(id)c.presentedViewController;TestTransition *transition=[TestTransition new];a.beingDismissed=YES;a.transitionCoordinator=transition;
    ClickAction(a,@"进入密友设置");Check(c.navigationController.topViewController==c,@"wait for automatic alert transition");
    c.presentedViewController=nil;if(transition.completion)transition.completion(nil);
    Check([c.navigationController.topViewController isKindOfClass:CSCloseFriendSettingsViewController.class],@"automatic dismiss completes entry once");
    settings=(id)c.navigationController.topViewController;
    if([settings isKindOfClass:CSCloseFriendSettingsViewController.class]) {
        NSDictionary *visit=settings.quickEntryToken;
        [settings viewWillDisappear:NO];Check([r isSettingsTokenCurrent:visit],@"native picker modal stays in same settings visit");
        NSMutableDictionary *profile=[[r profileForSettingsToken:visit] mutableCopy];profile[@"friends"]=@[@"secret",@"new-secret"];
        NSMutableDictionary *options=[profile[@"options"] mutableCopy];options[@"rejectVoice"]=@YES;profile[@"options"]=options;
        Check([r updateProfile:profile settingsToken:visit error:NULL],@"quick page edits lists and protection options");
        Check([[r profileForSettingsToken:visit][@"friends"] count]==2,@"saved list is visible within visit");
        Check(!r.isAuthorized && r.revealTimeRemaining==0,@"explicit settings save does not reveal WeChat lists");
        Check([[r snapshotForEpoch:1 suspended:NO] hidesUserName:@"secret" surface:CSCloseFriendSurfaceSession],@"entry and save keep protected session hidden");
        NSDictionary *normal=r.authenticationToken;Check(![r isSettingsTokenCurrent:normal],@"ordinary auth token cannot substitute page nonce");
        Check(![r prepareResetWithPassword:@"12345678" token:normal error:NULL],@"page grant cannot authorize destructive full reset");
        Check(![r setPassword:@"new-password" token:normal error:NULL],@"page grant cannot authorize password replacement");
        settings.navigationController.topViewController=[UIViewController new];[settings viewWillDisappear:NO];
        Check(![r isSettingsTokenCurrent:visit],@"unrelated navigation revokes visit");
        Check(![r updateProfile:profile settingsToken:visit error:NULL],@"old copied visit cannot save after departure");
    }
    c=Page();for(int i=0;i<5;i++)Tap(c,60+i*.1);a=(id)c.presentedViewController;transition=[TestTransition new];a.beingDismissed=YES;a.transitionCoordinator=transition;
    ClickAction(a,@"进入密友设置");UIViewController *newModal=[UIViewController new];c.presentedViewController=newModal;
    if(transition.completion)transition.completion(nil);Check(c.navigationController.topViewController==c && c.presentedViewController==newModal,@"later modal is preserved; stale confirmation cannot push");
    c=Page();for(int i=0;i<5;i++)Tap(c,70+i*.1);a=(id)c.presentedViewController;ClickAction(a,@"取消");c.presentedViewController=nil;ClickAction(a,@"进入密友设置");
    Check(c.navigationController.topViewController==c,@"cancelled old confirmation never enters");
    CSCloseFriendSettingsViewController *ordinary=[[CSCloseFriendSettingsViewController alloc] initWithStyle:0];
    Check(![ordinary authorized],@"ordinary row entry still needs original password authentication");
    c=Page();for(int i=0;i<5;i++)Tap(c,80+i*.1);Confirm(c);settings=(id)c.navigationController.topViewController;
    if([settings isKindOfClass:CSCloseFriendSettingsViewController.class]) {
        NSDictionary *visit=settings.quickEntryToken;
        NSMutableDictionary *profile=[[settings settingsProfile] mutableCopy];profile[@"friends"]=@[@"would-write-old-account"];
        NSDictionary *beforeProfile=[r profileForSettingsToken:visit];
        testEpoch=2; // Deliver the native account boundary before the main-thread notification.
        Check([r isSettingsTokenCurrent:visit],@"fixture retains stale Runtime before account notification");
        Check(![settings authorized] && ![settings settingsProfile],@"global epoch boundary immediately hides old settings");
        [settings save:profile];Check([[r profileForSettingsToken:visit] isEqual:beforeProfile],@"save at stale global epoch never writes old account");
        Check(settings.lastError!=nil,@"stale-account save reports refusal");
        testEpoch=1;
        testSuspended=YES;Check(![settings authorized],@"global suspended boundary immediately denies page");[settings save:profile];
        Check([[r profileForSettingsToken:visit] isEqual:beforeProfile],@"suspended save never writes");testSuspended=NO;
        settings.navigationController.topViewController=[UIViewController new];
        Check(![settings authorized],@"picker owner replaced without another disappear cannot read");
        [settings save:profile];Check([[r profileForSettingsToken:visit] isEqual:beforeProfile],@"late picker completion cannot save after owner replacement");
        [settings willMoveToParentViewController:nil];Check(![r isSettingsTokenCurrent:visit],@"removing invisible picker owner revokes nonce");
    }
    c=Page();Tap(c,90);Tap(c,90.2);testEpoch=2;Tap(c,90.4);Tap(c,90.6);Tap(c,90.8);
    Check(!c.presentedViewController && c.closeFriendQuickEntryCount==0,@"global boundary before Runtime notification clears tap sequence");testEpoch=1;
    __block NSUInteger publications=0;r.didChange=^{publications++;};NSDictionary *visit=[r settingsAccessToken];[r lock];
    Check(![r isSettingsTokenCurrent:visit] && publications>0,@"locking already-hidden chat publishes page-grant revocation");
    // Invalid persisted bytes are never made readable by the new page API.
    CSCloseFriendStore *stored=[r valueForKey:@"store"];NSArray<NSURL *> *files=[NSFileManager.defaultManager contentsOfDirectoryAtURL:stored.root includingPropertiesForKeys:nil options:0 error:NULL];
    for(NSURL *file in files)if([file.lastPathComponent hasSuffix:@".bin"])[@"damaged" writeToURL:file atomically:YES encoding:NSUTF8StringEncoding error:NULL];
    [r synchronizeAccount:@"account-A" epoch:3 suspended:NO];Check(r.settingsAccessToken==nil,@"corrupted store never grants no-password access");
}
MigrationQuickEntry([root URLByAppendingPathComponent:@"migrate-visible"],NO);
MigrationQuickEntry([root URLByAppendingPathComponent:@"migrate-hidden"],YES);
printf("Quick entry: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);return failures?1:0;}}
