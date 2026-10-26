#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "CSCloseFriendPolicy.h"

// UIKit is replaced only at the host boundary. Gesture attachment, policy refresh,
// foreground/navigation checks and the action below are the production methods.
@class UILongPressGestureRecognizer, UINavigationController;
@interface UIView : NSObject
@property(nonatomic,strong) NSMutableArray *gestures;
- (void)addGestureRecognizer:(UILongPressGestureRecognizer *)gesture;
@end
@interface UILongPressGestureRecognizer : NSObject
@property(nonatomic,weak) UIView *view;
@property(nonatomic) NSTimeInterval minimumPressDuration;
@property(nonatomic) BOOL enabled,cancelsTouchesInView;
@property(nonatomic) NSInteger state;
@property(nonatomic) NSUInteger cancellations;
- (instancetype)initWithTarget:(id)target action:(SEL)action;
@end
@implementation UILongPressGestureRecognizer
- (instancetype)initWithTarget:(__unused id)target action:(__unused SEL)action {if((self=[super init]))_enabled=YES;return self;}
- (void)setEnabled:(BOOL)enabled {if(_enabled && !enabled)self.cancellations++;_enabled=enabled;}
@end
@implementation UIView
- (void)addGestureRecognizer:(UILongPressGestureRecognizer *)gesture {if(!self.gestures)self.gestures=[NSMutableArray new];[self.gestures addObject:gesture];gesture.view=self;}
@end
@interface UINavigationBar : UIView @end
@implementation UINavigationBar @end
@interface UIViewController : NSObject
@property(nonatomic,strong) UINavigationController *navigationController;
@property(nonatomic,strong) UIViewController *presentedViewController;
@end
@implementation UIViewController @end
@interface UINavigationController : NSObject
@property(nonatomic,weak) UIViewController *topViewController;
@property(nonatomic,strong) UINavigationBar *navigationBar;
@end
@implementation UINavigationController @end
@interface UIApplication : NSObject
@property(nonatomic) NSInteger applicationState;
+ (instancetype)sharedApplication;
@end
@implementation UIApplication
+ (instancetype)sharedApplication {static UIApplication *app; if(!app)app=[self new];return app;}
@end
enum {UIGestureRecognizerStateBegan=1, UIApplicationStateActive=0, UIImpactFeedbackStyleLight=0};
@interface UIImpactFeedbackGenerator : NSObject
- (instancetype)initWithStyle:(NSInteger)style;
- (void)impactOccurred;
@end
@implementation UIImpactFeedbackGenerator
- (instancetype)initWithStyle:(__unused NSInteger)style {return [super init];}
- (void)impactOccurred {}
@end
@interface RecoveryRuntime : NSObject
@property(nonatomic) NSUInteger reveals;
@property(nonatomic,strong) NSDictionary *authenticationToken;
- (BOOL)revealWithShortcutToken:(NSDictionary *)token;
@end
@implementation RecoveryRuntime
- (BOOL)revealWithShortcutToken:(__unused NSDictionary *)token {self.reveals++;return YES;}
@end
static CSCloseFriendSnapshot *snapshot;
static NSUInteger epoch=1;
static CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) {return snapshot;}
static NSUInteger CSCloseFriendAccountEpoch(void) {return epoch;}
static id CSCloseFriendRead(id object,NSString *key) {return [object isKindOfClass:NSDictionary.class]?object[key]:nil;}
@interface RecoveryManager : NSObject
@property(nonatomic,weak) UIViewController *recoveryPage;
@property(nonatomic,weak) UILongPressGestureRecognizer *recoveryGesture;
@property(nonatomic) NSUInteger recoveryEpoch;
@property(nonatomic) BOOL lastRevealed,changeAccountOnRefresh;
@property(nonatomic,strong) RecoveryRuntime *runtime;
@property(nonatomic) NSUInteger authenticationRequests;
- (void)refreshAccount;
- (void)refreshRecoveryGesture;
- (void)recovery:(UILongPressGestureRecognizer *)gesture;
@end
@implementation RecoveryManager
- (void)refreshAccount {if(self.changeAccountOnRefresh)epoch++;}
- (void)authenticateFrom:(__unused UIViewController *)presenter completion:(void (^)(BOOL))completion {self.authenticationRequests++;completion(NO);}
#import "ManagerRecoveryUnderTest.h"
@end
static NSUInteger checks;
static BOOL biometric;
#define Check(x, message) do {checks++;if(!(x)){fprintf(stderr,"FAIL: %s\n",message);exit(1);}} while(0)
static void Policy(BOOL enabled,BOOL shortcut,double duration,BOOL blocked) {
    snapshot=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"gesture-fixture" profile:@{@"enabled":@(enabled),@"friends":@[],@"groups":@[],@"options":@{@"biometric":@(biometric),@"longPressUnlockEnabled":@(shortcut),@"longPressUnlockDuration":@(duration)}} revealed:NO revision:epoch blocked:blocked];
}
int main(void) {@autoreleasepool {
    RecoveryManager *manager=[RecoveryManager new];manager.runtime=[RecoveryRuntime new];
    UIViewController *page=[UIViewController new];page.navigationController=[UINavigationController new];
    page.navigationController.navigationBar=[UINavigationBar new];page.navigationController.topViewController=page;
    Policy(YES,YES,1,NO);[manager attachRecoveryGestureTo:page];
    UILongPressGestureRecognizer *gesture=manager.recoveryGesture;gesture.state=UIGestureRecognizerStateBegan;
    Check(gesture.enabled && gesture.minimumPressDuration==1 && !gesture.cancelsTouchesInView,"default one-second shortcut preserves native touches");
    [manager attachRecoveryGestureTo:page];Check(page.navigationController.navigationBar.gestures.count==1,"reappearing homepage never duplicates recognizers");
    [manager recovery:gesture];Check(manager.runtime.reveals==1,"enabled homepage action reveals once");
    Policy(YES,YES,1.5,NO);[manager recovery:gesture];Check(manager.runtime.reveals==1,"old threshold cannot unlock before pending settings refresh");
    for(NSNumber *duration in @[@0.5,@0.75,@2]) {
        NSUInteger cancelled=gesture.cancellations;Policy(YES,YES,duration.doubleValue,NO);[manager refreshRecoveryGesture];
        Check(gesture.minimumPressDuration==duration.doubleValue && gesture.enabled,"duration updates existing recognizer immediately");
        Check(gesture.cancellations==cancelled+1,"threshold change cancels an in-flight touch");
    }
    Policy(YES,NO,2,NO);[manager refreshRecoveryGesture];[manager recovery:gesture];
    Check(!gesture.enabled && manager.runtime.reveals==1,"disabled setting cancels gesture and rejects queued action");
    Policy(YES,YES,2,NO);[manager refreshRecoveryGesture];
    Policy(YES,NO,2,NO);[manager recovery:gesture];Check(manager.runtime.reveals==1,"action reads latest disabled policy even before refresh notification");
    Policy(YES,YES,2,NO);[manager refreshRecoveryGesture];
    UIViewController *otherPage=[UIViewController new];page.navigationController.topViewController=otherPage;[manager recovery:gesture];
    Check(manager.runtime.reveals==1,"other navigation pages cannot unlock");page.navigationController.topViewController=page;
    page.presentedViewController=[UIViewController new];[manager recovery:gesture];
    Check(manager.runtime.reveals==1,"modal presentation cannot unlock");page.presentedViewController=nil;
    UIApplication.sharedApplication.applicationState=1;[manager recovery:gesture];Check(manager.runtime.reveals==1,"inactive app cannot unlock");UIApplication.sharedApplication.applicationState=0;
    manager.changeAccountOnRefresh=YES;[manager recovery:gesture];Check(manager.runtime.reveals==1,"account change while handling touch cannot unlock new account");manager.changeAccountOnRefresh=NO;
    NSUInteger cancelled=gesture.cancellations;[manager refreshRecoveryGesture];Check(gesture.cancellations==cancelled+1,"account refresh cancels old touch even with same threshold");
    [manager recovery:gesture];Check(manager.runtime.reveals==2,"fresh touch works after account refresh");
    for(NSArray *flags in @[@[@NO,@NO],@[@YES,@YES]]) {Policy([flags[0] boolValue],YES,1,[flags[1] boolValue]);[manager refreshRecoveryGesture];[manager recovery:gesture];Check(!gesture.enabled && manager.runtime.reveals==2,"disabled or blocked profile cannot reveal");}
    Policy(YES,YES,1,NO);UINavigationBar *oldBar=page.navigationController.navigationBar;page.navigationController.navigationBar=[UINavigationBar new];[manager attachRecoveryGestureTo:page];
    Check(!gesture.enabled && manager.recoveryGesture!=gesture && oldBar.gestures.count==1,"moving to a new navigation bar disables old recognizer");
    [manager recovery:gesture];Check(manager.runtime.reveals==2,"obsolete recognizer cannot unlock");
    biometric=YES;Policy(YES,YES,1,NO);[manager refreshRecoveryGesture];
    manager.recoveryGesture.state=UIGestureRecognizerStateBegan;[manager recovery:manager.recoveryGesture];
    Check(manager.authenticationRequests==1 && manager.runtime.reveals==2,"biometric-enabled long press must authenticate and cannot reveal on failure");
    biometric=NO;Policy(YES,YES,1,NO);[manager recovery:manager.recoveryGesture];
    Check(manager.authenticationRequests==1 && manager.runtime.reveals==3,"biometric-disabled long press retains existing shortcut behavior");
    printf("CloseFriendRecoveryTests: %lu checks passed\n",(unsigned long)checks);
}return 0;}
