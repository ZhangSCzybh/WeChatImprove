#import <Foundation/Foundation.h>
#import "CSCloseFriendRuntime.h"

// UIKit, entry discovery and confirmation presentation are fixtures. Gesture,
// lifecycle and token guards are extracted unchanged from the real controller;
// quick-entry authority uses the real runtime with isolated temporary storage.
static NSUInteger checks,haptics;
#define Check(value,message) do {checks++;if(!(value)){fprintf(stderr,"FAIL: %s\n",message);exit(1);}} while(0)
enum {UIApplicationStateActive=0,UIGestureRecognizerStateBegan=1,UIGestureRecognizerStateChanged=2,UIGestureRecognizerStateEnded=3,UIGestureRecognizerStateCancelled=4,UIGestureRecognizerStateFailed=5,UIImpactFeedbackStyleLight=0};
@class UIGestureRecognizer,UIViewController;
@interface UIView : NSObject
@property(nonatomic,strong) id window;
@property(nonatomic,weak) UIView *superview;
@property(nonatomic) BOOL userInteractionEnabled;
@property(nonatomic,strong) NSMutableArray *gestures;
- (void)addGestureRecognizer:(UIGestureRecognizer *)gesture;
@end
@implementation UIView
- (void)addGestureRecognizer:(UIGestureRecognizer *)gesture {if(!self.gestures)self.gestures=[NSMutableArray new];[self.gestures addObject:gesture];}
@end
@interface UIGestureRecognizer : NSObject
@property(nonatomic) NSInteger state;
@property(nonatomic) NSUInteger numberOfTouchesRequired;
@property(nonatomic) BOOL cancelsTouchesInView;
@property(nonatomic,weak) id delegate;
@property(nonatomic,weak) UIGestureRecognizer *requiredFailure;
- (instancetype)initWithTarget:(id)target action:(SEL)action;
- (void)requireGestureRecognizerToFail:(UIGestureRecognizer *)gesture;
@end
@implementation UIGestureRecognizer
- (instancetype)initWithTarget:(id)target action:(SEL)action {return [super init];}
- (void)requireGestureRecognizerToFail:(UIGestureRecognizer *)gesture {self.requiredFailure=gesture;}
@end
@interface UILongPressGestureRecognizer : UIGestureRecognizer
@property(nonatomic) double minimumPressDuration,allowableMovement;
@end
@implementation UILongPressGestureRecognizer @end
@interface UITapGestureRecognizer : UIGestureRecognizer
@property(nonatomic) NSUInteger numberOfTapsRequired;
@end
@implementation UITapGestureRecognizer @end
@interface UITouch : NSObject @end
@implementation UITouch @end
@interface UINavigationController : NSObject
@property(nonatomic,strong) UIViewController *topViewController;
@end
@implementation UINavigationController @end
@interface UIViewController : NSObject
@property(nonatomic,strong) UIView *view;
@property(nonatomic,strong) UINavigationController *navigationController;
@property(nonatomic,strong) UIViewController *presentedViewController,*host;
@property(nonatomic) BOOL isViewLoaded;
- (void)viewWillDisappear:(BOOL)animated;
@end
@implementation UIViewController
- (void)viewWillDisappear:(BOOL)animated {}
@end
static UIViewController *CSNativeSettingsHostForContent(UIViewController *content) {return content.host?:content;}
@interface UIApplication : NSObject
@property(nonatomic) NSInteger applicationState;
+ (instancetype)sharedApplication;
@end
@implementation UIApplication
+ (instancetype)sharedApplication {static UIApplication *app;if(!app)app=[self new];return app;}
@end
static NSString * const UIApplicationDidEnterBackgroundNotification=@"TestDidEnterBackground";
static NSString *currentAccount=@"first";
static NSUInteger accountEpoch=1;
static BOOL accountSuspended;
static NSUInteger CSCloseFriendAccountEpoch(void) {return accountEpoch;}
static BOOL CSBackupAccountIsSuspended(void) {return accountSuspended;}
@interface UIImpactFeedbackGenerator : NSObject
- (instancetype)initWithStyle:(NSInteger)style;
- (void)impactOccurred;
@end
@implementation UIImpactFeedbackGenerator
- (instancetype)initWithStyle:(NSInteger)style {return [super init];}
- (void)impactOccurred {haptics++;}
@end
@interface UITableView : NSObject
@property(nonatomic) NSUInteger reloads;
- (void)reloadData;
@end
@implementation UITableView
- (void)reloadData {self.reloads++;}
@end
@interface CSCloseFriendManager : NSObject
@property(nonatomic,strong) NSDictionary *token;
@property(nonatomic,strong) CSCloseFriendRuntime *runtime;
@property(nonatomic) BOOL discovered,visible;
@property(nonatomic) NSUInteger discoveries;
+ (instancetype)sharedManager;
- (NSDictionary *)settingsEntryDiscoveryToken;
- (BOOL)discoverSettingsEntryWithToken:(NSDictionary *)token;
- (BOOL)settingsEntryVisible;
- (void)refreshAccount;
@end
@implementation CSCloseFriendManager
+ (instancetype)sharedManager {static CSCloseFriendManager *manager;if(!manager)manager=[self new];return manager;}
- (NSDictionary *)settingsEntryDiscoveryToken {return self.discovered?nil:self.token;}
- (BOOL)discoverSettingsEntryWithToken:(NSDictionary *)token {if(self.discovered || !token || ![token isEqual:self.token])return NO;self.discoveries++;self.discovered=YES;self.visible=YES;return YES;}
- (BOOL)settingsEntryVisible {return self.visible;}
- (void)refreshAccount {[self.runtime synchronizeAccount:currentAccount epoch:accountEpoch suspended:accountSuspended];}
@end
@interface EntryController : UIViewController
@property(nonatomic,strong) UIView *avatarImageView;
@property(nonatomic,strong) UILongPressGestureRecognizer *closeFriendEntryGesture;
@property(nonatomic,copy) NSDictionary *closeFriendEntryToken;
@property(nonatomic,strong) UITapGestureRecognizer *closeFriendQuickEntryGesture;
@property(nonatomic,copy) NSDictionary *closeFriendQuickEntryToken;
@property(nonatomic) NSUInteger closeFriendQuickEntryCount;
@property(nonatomic) NSTimeInterval closeFriendQuickEntryLastTap;
@property(nonatomic) BOOL isAuthorized,closeFriendEntryVisible,authorizationPromptInFlight;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic) NSUInteger setups;
@property(nonatomic) NSUInteger confirmations;
@property(nonatomic,copy) NSDictionary *pendingConfirmationToken;
- (void)setupData;
- (void)confirmCloseFriendQuickEntryWithToken:(NSDictionary *)token;
- (void)installBackgroundObserver;
@end
@implementation EntryController
- (void)setupData {self.setups++;self.closeFriendEntryVisible=CSCloseFriendManager.sharedManager.visible;}
- (void)confirmCloseFriendQuickEntryWithToken:(NSDictionary *)token {self.confirmations++;self.pendingConfirmationToken=token;}
- (void)installBackgroundObserver {
#import "EntryBackgroundObserverUnderTest.h"
}
#import "EntryGestureUnderTest.h"
@end

// The controller's real clock method is compiled above. Only this test subclass
// overrides time so the 0.8-second boundary does not depend on wall-clock waits.
@interface EntryClockController : EntryController
@property(nonatomic) NSTimeInterval testTime;
@end
@implementation EntryClockController
- (NSTimeInterval)closeFriendQuickEntryTimestamp {return self.testTime;}
@end
static void Tap(EntryClockController *page,NSTimeInterval timestamp) {
    page.testTime=timestamp;
    if(![page gestureRecognizer:page.closeFriendQuickEntryGesture shouldReceiveTouch:nil])return;
    page.closeFriendQuickEntryGesture.state=UIGestureRecognizerStateEnded;
    [page tapCloseFriendQuickEntry:page.closeFriendQuickEntryGesture];
}

int main(void) {@autoreleasepool {
    EntryClockController *page=[EntryClockController new];page.view=[UIView new];page.view.window=[NSObject new];page.isViewLoaded=YES;page.isAuthorized=YES;
    page.avatarImageView=[UIView new];page.tableView=[UITableView new];
    page.navigationController=[UINavigationController new];page.navigationController.topViewController=page;
    CSCloseFriendManager *manager=CSCloseFriendManager.sharedManager;manager.token=@{@"account":@"first",@"generation":@1};
    NSURL *root=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString] isDirectory:YES];
    CSCloseFriendStore *store=[[CSCloseFriendStore alloc] initWithRoot:root keyProvider:^NSData *(__unused NSString *account,__unused NSError **error){return [NSMutableData dataWithLength:64];}];
    manager.runtime=[[CSCloseFriendRuntime alloc] initWithStore:store clock:^NSTimeInterval{return 10000;}
        credentialReader:^NSDictionary *(__unused NSString *account,__unused NSError **error){return nil;}
        credentialWriter:^BOOL(__unused NSString *account,__unused NSDictionary *value,__unused NSError **error){return NO;}];
    [manager refreshAccount];
    [page installCloseFriendEntryGesture];[page installCloseFriendEntryGesture];
    UILongPressGestureRecognizer *gesture=page.closeFriendEntryGesture;
    UITapGestureRecognizer *tap=page.closeFriendQuickEntryGesture;
    Check(page.avatarImageView.userInteractionEnabled && page.avatarImageView.gestures.count==2,"avatar receives exactly one long press and one tap recognizer");
    Check(gesture.minimumPressDuration==2 && gesture.allowableMovement==10 && gesture.numberOfTouchesRequired==1 && !gesture.cancelsTouchesInView,"discovery requires a stationary two-second single-finger hold");
    Check(gesture.delegate==page,"touch-down binds the account before recognition");
    Check(tap.numberOfTapsRequired==1 && tap.numberOfTouchesRequired==1 && !tap.cancelsTouchesInView && tap.delegate==page,"individual single-finger taps are counted by the controller");
    Check(tap.requiredFailure==gesture,"recognized long press suppresses the tap recognizer");
    Check([page gestureRecognizer:gesture shouldReceiveTouch:nil] && [page.closeFriendEntryToken isEqual:manager.token],"eligible touch captures current token");
    gesture.state=UIGestureRecognizerStateEnded;[page discoverCloseFriendEntry:gesture];
    Check(!page.closeFriendEntryToken && manager.discoveries==0 && haptics==0,"short or ended touches cannot discover");
    [page gestureRecognizer:gesture shouldReceiveTouch:nil];gesture.state=UIGestureRecognizerStateCancelled;[page discoverCloseFriendEntry:gesture];
    Check(!page.closeFriendEntryToken && manager.discoveries==0,"scroll-cancelled gesture clears captured authority");
    [page gestureRecognizer:gesture shouldReceiveTouch:nil];manager.token=@{@"account":@"second",@"generation":@2};gesture.state=UIGestureRecognizerStateBegan;[page discoverCloseFriendEntry:gesture];
    Check(manager.discoveries==0 && !page.closeFriendEntryToken,"account changed during the hold cannot discover a different account");
    [page gestureRecognizer:gesture shouldReceiveTouch:nil];UIApplication.sharedApplication.applicationState=1;[page discoverCloseFriendEntry:gesture];
    Check(manager.discoveries==0,"background at recognition blocks discovery");
    Check(![page gestureRecognizer:gesture shouldReceiveTouch:nil],"background cannot begin a touch");UIApplication.sharedApplication.applicationState=0;
    page.isAuthorized=NO;Check(![page gestureRecognizer:gesture shouldReceiveTouch:nil],"plugin authorization gate remains enforced");page.isAuthorized=YES;
    page.authorizationPromptInFlight=YES;
    Check(![page gestureRecognizer:gesture shouldReceiveTouch:nil],"pending native authorization alert blocks discovery");page.authorizationPromptInFlight=NO;
    page.presentedViewController=[UIViewController new];Check(![page gestureRecognizer:gesture shouldReceiveTouch:nil],"modal presentation blocks discovery");page.presentedViewController=nil;
    page.navigationController.topViewController=[UIViewController new];Check(![page gestureRecognizer:gesture shouldReceiveTouch:nil],"covered settings page cannot discover");page.navigationController.topViewController=page;
    page.view.window=nil;Check(![page gestureRecognizer:gesture shouldReceiveTouch:nil],"offscreen settings cannot discover");page.view.window=[NSObject new];
    UIViewController *host=[UIViewController new];host.navigationController=[UINavigationController new];host.navigationController.topViewController=host;page.host=host;
    Check([page gestureRecognizer:gesture shouldReceiveTouch:nil],"native wrapper host is supported");
    host.presentedViewController=[UIViewController new];[page discoverCloseFriendEntry:gesture];
    Check(manager.discoveries==0,"wrapper-host modal appearing during the hold blocks discovery");host.presentedViewController=nil;
    [page gestureRecognizer:gesture shouldReceiveTouch:nil];
    [page discoverCloseFriendEntry:[UILongPressGestureRecognizer new]];
    Check(manager.discoveries==0,"unrelated recognizer cannot activate entry");
    [page discoverCloseFriendEntry:gesture];
    Check(manager.discoveries==1 && page.closeFriendEntryVisible,"successful gesture reveals the entry in place");
    Check(page.setups==1 && page.tableView.reloads==1 && haptics==1,"successful discovery refreshes and acknowledges once");
    Check(!page.presentedViewController && !host.presentedViewController,"discovery does not present password or settings pages");
    [page discoverCloseFriendEntry:gesture];gesture.state=UIGestureRecognizerStateChanged;[page discoverCloseFriendEntry:gesture];
    Check(manager.discoveries==1 && haptics==1,"repeated gesture callbacks cannot reactivate or repeat feedback");
    Check(![page gestureRecognizer:gesture shouldReceiveTouch:nil],"already discovered account does not intercept subsequent long presses");
    [page closeFriendEntryPolicyChanged:nil];Check(page.tableView.reloads==1,"unrelated policy notification avoids a redundant list reload");
    manager.visible=NO;[page closeFriendEntryPolicyChanged:nil];
    Check(!page.closeFriendEntryVisible && page.tableView.reloads==2,"manual hiding or relock removes entry synchronously");
    manager.visible=YES;[page closeFriendEntryPolicyChanged:nil];
    Check(page.closeFriendEntryVisible && page.tableView.reloads==3,"existing unlock restores entry synchronously");
    page.isViewLoaded=NO;manager.visible=NO;[page closeFriendEntryPolicyChanged:nil];
    Check(page.tableView.reloads==3,"notification never loads an unseen settings view");
    page.isViewLoaded=YES;page.host=nil;

    for(NSUInteger i=0;i<4;i++)Tap(page,100+i*0.1);
    NSDictionary *token=page.closeFriendQuickEntryToken;
    Check(page.closeFriendQuickEntryCount==4 && page.confirmations==0,"four consecutive taps do not enter or prompt");
    Check([manager.runtime isSettingsTokenCurrent:token] && !manager.runtime.isAuthorized,"counting taps captures scoped settings access without unlocking contacts");
    Tap(page,100.4);
    Check(page.confirmations==1 && [page.pendingConfirmationToken isEqual:token] && page.closeFriendQuickEntryCount==0,"fifth tap requests confirmation with the same runtime token and clears the count");
    Check(!manager.runtime.isAuthorized && !page.presentedViewController,"tap handler alone never authenticates or navigates");
    [page resetCloseFriendQuickEntry];
    Check(![manager.runtime isSettingsTokenCurrent:token] && !page.closeFriendQuickEntryToken && !page.closeFriendQuickEntryLastTap,"reset invalidates authority and clears timing");

    for(NSUInteger i=0;i<4;i++)Tap(page,110+i*0.1);
    Tap(page,111.2);
    Check(page.closeFriendQuickEntryCount==1 && page.confirmations==1,"a gap above 0.8 seconds starts a new five-tap sequence");
    Tap(page,112.0);
    Check(page.closeFriendQuickEntryCount==2,"exactly 0.8 seconds still belongs to the same sequence");
    Tap(page,111.9);
    Check(page.closeFriendQuickEntryCount==1,"a backwards clock sample restarts the sequence");
    tap.state=UIGestureRecognizerStateChanged;[page tapCloseFriendQuickEntry:tap];
    [page tapCloseFriendQuickEntry:[UITapGestureRecognizer new]];
    Check(page.closeFriendQuickEntryCount==1 && page.confirmations==1,"non-ended and unrelated recognizers cannot add taps");

    manager.discovered=NO;manager.visible=NO;
    Check([page gestureRecognizer:gesture shouldReceiveTouch:nil],"long press remains available while a tap sequence is pending");
    token=page.closeFriendQuickEntryToken;
    gesture.state=UIGestureRecognizerStateBegan;[page discoverCloseFriendEntry:gesture];
    Check(manager.discoveries==2 && page.closeFriendQuickEntryCount==0 && !page.closeFriendQuickEntryToken,"long-press discovery clears the pending tap sequence");
    Check(![manager.runtime isSettingsTokenCurrent:token] && page.confirmations==1,"recognized long press revokes tap authority without opening the quick page");
    tap.state=UIGestureRecognizerStateEnded;[page tapCloseFriendQuickEntry:tap];
    Check(!page.closeFriendQuickEntryCount && page.confirmations==1,"a stray tap callback after long press cannot count or confirm");

    Tap(page,120);Tap(page,120.1);token=page.closeFriendQuickEntryToken;
    [page viewWillDisappear:NO];
    Check(!page.closeFriendQuickEntryCount && !page.closeFriendQuickEntryToken && ![manager.runtime isSettingsTokenCurrent:token],"leaving the page clears the sequence and invalidates its token");
    Tap(page,121);
    Check(page.closeFriendQuickEntryCount==1,"returning begins a fresh sequence");
    token=page.closeFriendQuickEntryToken;
    [page installBackgroundObserver];UIApplication.sharedApplication.applicationState=1;
    [NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidEnterBackgroundNotification object:nil];
    Check(!page.closeFriendQuickEntryCount && !page.closeFriendQuickEntryToken && ![manager.runtime isSettingsTokenCurrent:token],"the real background observer clears both sequence and token");
    Tap(page,121.1);Check(!page.closeFriendQuickEntryCount,"background touches never start a new sequence");
    [manager.runtime setActive:NO];[manager.runtime setActive:YES];UIApplication.sharedApplication.applicationState=0;

    for(NSUInteger i=0;i<4;i++)Tap(page,130+i*0.1);
    token=page.closeFriendQuickEntryToken;
    currentAccount=@"second";accountEpoch++;
    Check(![page closeFriendQuickEntryTokenIsCurrent:token],"account epoch changes immediately reject the old controller token");
    Tap(page,130.4);
    Check(page.closeFriendQuickEntryCount==1 && page.confirmations==1 && ![page.closeFriendQuickEntryToken isEqual:token],"first tap after switching accounts cannot complete the old sequence");
    Check(![manager.runtime isSettingsTokenCurrent:token],"runtime also rejects old-account settings authority");

    token=page.closeFriendQuickEntryToken;[manager.runtime lock];
    [page closeFriendEntryPolicyChanged:nil];
    Check(!page.closeFriendQuickEntryCount && !page.closeFriendQuickEntryToken && ![page closeFriendQuickEntryTokenIsCurrent:token],"policy-driven token invalidation clears a pending sequence");
    Tap(page,140);token=page.closeFriendQuickEntryToken;accountSuspended=YES;
    Check(![page closeFriendQuickEntryTokenIsCurrent:token],"account suspension rejects settings authority before runtime refresh");
    Tap(page,140.1);
    Check(!page.closeFriendQuickEntryCount && !page.closeFriendQuickEntryToken,"suspended account cannot renew quick-entry authority");
    accountSuspended=NO;accountEpoch++;[manager refreshAccount];
    Tap(page,150);page.isAuthorized=NO;Tap(page,150.1);
    Check(!page.closeFriendQuickEntryCount && !page.closeFriendQuickEntryToken,"authorization loss cancels pending taps");page.isAuthorized=YES;
    Tap(page,151);page.presentedViewController=[UIViewController new];Tap(page,151.1);
    Check(!page.closeFriendQuickEntryCount && !page.closeFriendQuickEntryToken,"an intervening modal cancels pending taps");page.presentedViewController=nil;
    Tap(page,152);page.view.window=nil;Tap(page,152.1);
    Check(!page.closeFriendQuickEntryCount && !page.closeFriendQuickEntryToken,"offscreen page cannot continue pending taps");
    [NSNotificationCenter.defaultCenter removeObserver:page];
    Check(![NSFileManager.defaultManager fileExistsAtPath:root.path],"all entry gestures leave encrypted policy storage untouched");
    [NSFileManager.defaultManager removeItemAtURL:root error:NULL];
    printf("CloseFriendEntryGestureTests: %lu checks passed\n",(unsigned long)checks);
}return 0;}
