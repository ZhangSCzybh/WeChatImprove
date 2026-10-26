#import <Foundation/Foundation.h>

// Only UIKit and the manager boundary are fixtures; all gesture/controller methods
// below are extracted from CSCustomViewController unchanged.
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
@end
@implementation UIGestureRecognizer @end
@interface UILongPressGestureRecognizer : UIGestureRecognizer
@property(nonatomic) double minimumPressDuration,allowableMovement;
@property(nonatomic) NSUInteger numberOfTouchesRequired;
@property(nonatomic) BOOL cancelsTouchesInView;
@property(nonatomic,weak) id delegate;
- (instancetype)initWithTarget:(id)target action:(SEL)action;
@end
@implementation UILongPressGestureRecognizer
- (instancetype)initWithTarget:(id)target action:(SEL)action {return [super init];}
@end
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
@end
@implementation UIViewController @end
static UIViewController *CSNativeSettingsHostForContent(UIViewController *content) {return content.host?:content;}
@interface UIApplication : NSObject
@property(nonatomic) NSInteger applicationState;
+ (instancetype)sharedApplication;
@end
@implementation UIApplication
+ (instancetype)sharedApplication {static UIApplication *app;if(!app)app=[self new];return app;}
@end
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
@property(nonatomic) BOOL discovered,visible;
@property(nonatomic) NSUInteger discoveries;
+ (instancetype)sharedManager;
- (NSDictionary *)settingsEntryDiscoveryToken;
- (BOOL)discoverSettingsEntryWithToken:(NSDictionary *)token;
- (BOOL)settingsEntryVisible;
@end
@implementation CSCloseFriendManager
+ (instancetype)sharedManager {static CSCloseFriendManager *manager;if(!manager)manager=[self new];return manager;}
- (NSDictionary *)settingsEntryDiscoveryToken {return self.discovered?nil:self.token;}
- (BOOL)discoverSettingsEntryWithToken:(NSDictionary *)token {if(self.discovered || !token || ![token isEqual:self.token])return NO;self.discoveries++;self.discovered=YES;self.visible=YES;return YES;}
- (BOOL)settingsEntryVisible {return self.visible;}
@end
@interface EntryController : UIViewController
@property(nonatomic,strong) UIView *avatarImageView,*authorizationOverlay;
@property(nonatomic,strong) UILongPressGestureRecognizer *closeFriendEntryGesture;
@property(nonatomic,copy) NSDictionary *closeFriendEntryToken;
@property(nonatomic) BOOL isAuthorized,closeFriendEntryVisible;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic) NSUInteger setups;
- (void)setupData;
@end
@implementation EntryController
- (void)setupData {self.setups++;self.closeFriendEntryVisible=CSCloseFriendManager.sharedManager.visible;}
#import "EntryGestureUnderTest.h"
@end

int main(void) {@autoreleasepool {
    EntryController *page=[EntryController new];page.view=[UIView new];page.view.window=[NSObject new];page.isViewLoaded=YES;page.isAuthorized=YES;
    page.avatarImageView=[UIView new];page.tableView=[UITableView new];
    page.navigationController=[UINavigationController new];page.navigationController.topViewController=page;
    CSCloseFriendManager *manager=CSCloseFriendManager.sharedManager;manager.token=@{@"account":@"first",@"generation":@1};
    [page installCloseFriendEntryGesture];[page installCloseFriendEntryGesture];
    UILongPressGestureRecognizer *gesture=page.closeFriendEntryGesture;
    Check(page.avatarImageView.userInteractionEnabled && page.avatarImageView.gestures.count==1,"avatar receives exactly one recognizer");
    Check(gesture.minimumPressDuration==2 && gesture.allowableMovement==10 && gesture.numberOfTouchesRequired==1 && !gesture.cancelsTouchesInView,"discovery requires a stationary two-second single-finger hold");
    Check(gesture.delegate==page,"touch-down binds the account before recognition");
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
    page.authorizationOverlay=[UIView new];page.authorizationOverlay.superview=page.view;
    Check(![page gestureRecognizer:gesture shouldReceiveTouch:nil],"visible authorization overlay blocks discovery");page.authorizationOverlay=nil;
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
    printf("CloseFriendEntryGestureTests: %lu checks passed\n",(unsigned long)checks);
}return 0;}
