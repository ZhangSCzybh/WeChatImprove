#import <Foundation/Foundation.h>
static NSUInteger checks;
static void Check(BOOL ok,NSString *message){checks++;if(!ok){fprintf(stderr,"FAIL: %s\n",message.UTF8String);exit(1);}}
static NSUserDefaults *testDefaults;
static NSString *gCustomEntryTitle;
static NSString *const kEntryDisplayModeKey=@"com.wechat.tweak.entry.display.mode";
static NSString *const kEntryCustomTitleKey=@"com.wechat.tweak.entry.custom.title";
typedef NS_ENUM(NSInteger,CSEntryDisplayMode){CSEntryDisplayModeMore=1,CSEntryDisplayModePlugin=2,CSEntryDisplayModeSetting=4};
static BOOL ready;
static BOOL CSBackupIsReady(void){return ready;}
enum {UIModalPresentationFormSheet,UIModalPresentationPageSheet};
@interface UIViewController : NSObject
@property(nonatomic) NSString *title;
@property(nonatomic) UIViewController *presented;
@property(nonatomic) UIViewController *navigationController;
@property(nonatomic) NSInteger modalPresentationStyle;
- (void)presentViewController:(UIViewController *)vc animated:(BOOL)animated completion:(void (^)(void))completion;
@end
@implementation UIViewController
- (void)presentViewController:(UIViewController *)vc animated:(BOOL)animated completion:(void (^)(void))completion{self.presented=vc;}
@end
@interface UINavigationController : UIViewController
@property(nonatomic) UIViewController *root;
- (instancetype)initWithRootViewController:(UIViewController *)controller;
@end
@implementation UINavigationController
- (instancetype)initWithRootViewController:(UIViewController *)controller{if((self=[super init]))_root=controller;return self;}
@end
@interface OriginalSettingsController : UIViewController @end
@implementation OriginalSettingsController @end
@interface CSBackupSettingsViewController : UIViewController @end
@implementation CSBackupSettingsViewController @end
static Class CSNativeSettingsControllerClass(void){return OriginalSettingsController.class;}
@interface CSAuthorizationManager : NSObject
@property(nonatomic) BOOL authorized;
@property(nonatomic) NSUInteger requests;
+ (instancetype)sharedManager;
- (BOOL)isAuthorized;
- (void)requestAuthorizationWithPresentingViewController:(UIViewController *)vc completion:(void (^)(BOOL,NSString *))completion;
@end
@implementation CSAuthorizationManager
+ (instancetype)sharedManager{static CSAuthorizationManager *v;if(!v)v=[self new];return v;}
- (BOOL)isAuthorized{return self.authorized;}
- (void)requestAuthorizationWithPresentingViewController:(UIViewController *)vc completion:(void (^)(BOOL,NSString *))completion{self.requests++;completion(NO,@"test");}
@end
static BOOL closeFriendHidden, closeFriendAllow;
static NSUInteger closeFriendRequests;
static BOOL CSCloseFriendPluginEntryHidden(void){return closeFriendHidden;}
static void CSCloseFriendAuthenticate(UIViewController *presenter,void (^completion)(BOOL)) {
    closeFriendRequests++; if(closeFriendAllow)closeFriendHidden=NO; completion(closeFriendAllow);
}
@interface TestEntry : UIViewController
- (void)onCustomEntryClick;
- (void)onCustomEntryClickInSetting:(id)sender;
- (void)openCustomViewController;
- (void)openCustomViewControllerFromSetting;
@end
#import "EntryUnderTest.h"
int main(void){@autoreleasepool{
    NSString *suite=[@"framework.entry.test." stringByAppendingString:NSUUID.UUID.UUIDString];testDefaults=[[NSUserDefaults alloc]initWithSuiteName:suite];
    for(NSNumber *state in @[@NO,@YES]){
        ready=state.boolValue;gCustomEntryTitle=nil;[testDefaults removeObjectForKey:kEntryCustomTitleKey];[testDefaults removeObjectForKey:kEntryDisplayModeKey];
        Check([getCustomEntryTitle() isEqual:@"再也不会"],@"backup readiness cannot rename the plugin");
        Check(getEntryDisplayMode()==CSEntryDisplayModeSetting,@"backup readiness cannot override original default location");
        [testDefaults setObject:@"我的插件" forKey:kEntryCustomTitleKey];[testDefaults setInteger:CSEntryDisplayModePlugin forKey:kEntryDisplayModeKey];loadEntrySettings();
        Check([getCustomEntryTitle() isEqual:@"我的插件"]&&getEntryDisplayMode()==CSEntryDisplayModePlugin,@"custom entry name and placement survive backup failure");
        TestEntry *more=[TestEntry new];CSAuthorizationManager.sharedManager.authorized=YES;[more onCustomEntryClick];
        Check([[(UINavigationController *)more.presented root] isKindOfClass:OriginalSettingsController.class],@"More entry always opens the complete original settings framework");
        Check([[[(UINavigationController *)more.presented root] title] isEqual:@"我的插件"],@"original settings receives saved plugin title");
        TestEntry *settings=[TestEntry new];settings.navigationController=[UINavigationController new];[settings onCustomEntryClickInSetting:nil];
        Check([[(UINavigationController *)settings.navigationController.presented root] isKindOfClass:OriginalSettingsController.class],@"Settings entry always opens the complete original framework");
        TestEntry *denied=[TestEntry new];CSAuthorizationManager.sharedManager.authorized=NO;NSUInteger before=CSAuthorizationManager.sharedManager.requests;
        [denied onCustomEntryClick];[denied onCustomEntryClickInSetting:nil];
        Check(!denied.presented&&CSAuthorizationManager.sharedManager.requests==before+2,@"backup failure does not bypass original authorization");
    }
    CSAuthorizationManager.sharedManager.authorized=YES;
    closeFriendHidden=YES; closeFriendAllow=NO;
    TestEntry *hidden=[TestEntry new]; [hidden onCustomEntryClick];
    Check(!hidden.presented&&closeFriendRequests==1,@"hidden More route requires close-friend authentication");
    hidden.navigationController=[UINavigationController new]; [hidden openCustomViewControllerFromSetting];
    Check(!hidden.navigationController.presented&&closeFriendRequests==2,@"direct hidden Settings route cannot bypass close-friend authentication");
    closeFriendAllow=YES; [hidden openCustomViewControllerFromSetting];
    Check([[(UINavigationController *)hidden.navigationController.presented root] isKindOfClass:OriginalSettingsController.class],@"authenticated hidden route restores original complete settings");
    closeFriendHidden=YES; closeFriendAllow=NO; CSAuthorizationManager.sharedManager.authorized=NO;
    NSUInteger prior=closeFriendRequests; [hidden onCustomEntryClick];
    Check(closeFriendRequests==prior,@"close-friend gate does not bypass original plugin authorization");
    [testDefaults removePersistentDomainForName:suite];printf("Plugin entry: %lu checks passed\n",(unsigned long)checks);
}return 0;}
