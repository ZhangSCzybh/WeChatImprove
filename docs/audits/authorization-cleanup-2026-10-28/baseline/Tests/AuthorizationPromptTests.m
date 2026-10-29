#import <Foundation/Foundation.h>
#include <stdio.h>
#include <stdlib.h>

static NSUInteger checks;
static BOOL deferDismissals;
static NSMutableArray<void (^)(void)> *pendingDismissals;
#define CHECK(condition) do { checks++; if (!(condition)) { \
    fprintf(stderr, "FAIL line %d: %s\n", __LINE__, #condition); exit(1); \
} } while (0)

// Small observable UIKit doubles. The code under test is extracted verbatim from
// the production manager, settings lifecycle, and navigation-return helper.
@class UINavigationController, UIAlertAction;
@interface UIView : NSObject
@property(nonatomic) BOOL userInteractionEnabled;
@property(nonatomic) NSUInteger subviewAdds;
- (UIView *)viewWithTag:(NSInteger)tag;
- (void)addSubview:(UIView *)view;
- (void)removeFromSuperview;
@end
@implementation UIView
- (instancetype)init { if ((self=[super init])) _userInteractionEnabled=YES; return self; }
- (UIView *)viewWithTag:(NSInteger)tag { (void)tag; return nil; }
- (void)addSubview:(UIView *)view { (void)view; self.subviewAdds++; }
- (void)removeFromSuperview {}
@end
@interface UITableView : UIView
@property(nonatomic) NSUInteger reloads;
- (void)reloadData;
@end
@implementation UITableView
- (void)reloadData { self.reloads++; }
@end
@interface UIViewController : NSObject
@property(nonatomic, strong) UIView *view;
@property(nonatomic, weak) UIViewController *parentViewController;
@property(nonatomic, strong) UINavigationController *navigationController;
@property(nonatomic, weak) UIViewController *presentingViewController;
@property(nonatomic, strong) UIViewController *presentedViewController;
@property(nonatomic) NSUInteger presentationCount;
@property(nonatomic) NSUInteger dismissCount;
- (void)viewDidAppear:(BOOL)animated;
- (void)viewDidDisappear:(BOOL)animated;
- (void)presentViewController:(UIViewController *)controller animated:(BOOL)animated completion:(void (^)(void))completion;
- (void)dismissViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion;
@end
@implementation UIViewController
- (instancetype)init { if ((self=[super init])) _view=[UIView new]; return self; }
- (UINavigationController *)navigationController { return _navigationController ?: self.parentViewController.navigationController; }
- (void)viewDidAppear:(BOOL)animated { (void)animated; }
- (void)viewDidDisappear:(BOOL)animated { (void)animated; }
- (void)presentViewController:(UIViewController *)controller animated:(BOOL)animated completion:(void (^)(void))completion {
    (void)animated; self.presentationCount++; self.presentedViewController=controller; controller.presentingViewController=self; if(completion)completion();
}
- (void)dismissViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion {
    (void)animated; self.dismissCount++;
    void (^finish)(void)=^{
        if(self.presentingViewController.presentedViewController==self) self.presentingViewController.presentedViewController=nil;
        self.presentingViewController=nil;
        if(completion)completion();
    };
    if(deferDismissals) { if(!pendingDismissals)pendingDismissals=[NSMutableArray new]; [pendingDismissals addObject:finish]; }
    else finish();
}
@end
@interface UINavigationController : UIViewController
@property(nonatomic, copy) NSArray<UIViewController *> *viewControllers;
@property(nonatomic, readonly) UIViewController *topViewController;
@property(nonatomic) NSUInteger popCount;
@property(nonatomic) NSUInteger popToCount;
- (UIViewController *)popViewControllerAnimated:(BOOL)animated;
- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)controller animated:(BOOL)animated;
@end
@implementation UINavigationController
- (instancetype)init { if ((self=[super init])) _viewControllers=@[]; return self; }
- (UIViewController *)topViewController { return self.viewControllers.lastObject; }
- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    (void)animated; self.popCount++; UIViewController *top=self.topViewController;
    if(self.viewControllers.count>1)self.viewControllers=[self.viewControllers subarrayWithRange:NSMakeRange(0,self.viewControllers.count-1)]; return top;
}
- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)controller animated:(BOOL)animated {
    (void)animated; self.popToCount++; NSUInteger index=[self.viewControllers indexOfObjectIdenticalTo:controller];
    if(index==NSNotFound)return nil; NSArray *removed=[self.viewControllers subarrayWithRange:NSMakeRange(index+1,self.viewControllers.count-index-1)];
    self.viewControllers=[self.viewControllers subarrayWithRange:NSMakeRange(0,index+1)]; return removed;
}
@end

typedef NS_ENUM(NSInteger, UIAlertControllerStyle) { UIAlertControllerStyleAlert=1 };
typedef NS_ENUM(NSInteger, UIAlertActionStyle) { UIAlertActionStyleDefault=0, UIAlertActionStyleCancel=1 };
@interface UIAlertAction : NSObject
@property(nonatomic, copy) NSString *title;
@property(nonatomic) UIAlertActionStyle style;
@property(nonatomic, copy) void (^handler)(UIAlertAction *);
+ (instancetype)actionWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void (^)(UIAlertAction *))handler;
@end
@implementation UIAlertAction
+ (instancetype)actionWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void (^)(UIAlertAction *))handler {
    UIAlertAction *action=[self new]; action.title=title; action.style=style; action.handler=handler; return action;
}
@end
@interface UIAlertController : UIViewController
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *message;
@property(nonatomic) UIAlertControllerStyle preferredStyle;
@property(nonatomic, strong) NSMutableArray<UIAlertAction *> *actions;
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)style;
- (void)addAction:(UIAlertAction *)action;
@end
@implementation UIAlertController
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)style {
    UIAlertController *alert=[self new]; alert.title=title; alert.message=message; alert.preferredStyle=style; alert.actions=[NSMutableArray new]; return alert;
}
- (void)addAction:(UIAlertAction *)action { [self.actions addObject:action]; }
@end

typedef void (^CSAuthorizationCompletion)(BOOL, NSString *);
@interface CSAuthorizationManager : NSObject
@property(nonatomic) BOOL authorized;
@property(nonatomic, copy) NSArray<NSNumber *> *nextReads;
@property(nonatomic) NSUInteger reads;
@property(nonatomic) NSUInteger opens;
@property(nonatomic, weak) UIViewController *openSource;
+ (instancetype)sharedManager;
- (BOOL)isAuthorized;
- (void)requestAuthorizationWithPresentingViewController:(UIViewController *)controller completion:(CSAuthorizationCompletion)completion;
- (void)openOfficialAccountFromViewController:(UIViewController *)controller;
@end

@interface TestNativeSettingsHost : UIViewController @end
@implementation TestNativeSettingsHost @end
static UIViewController *CSNativeSettingsHostForContent(UIViewController *content) {
    return [content.parentViewController isKindOfClass:TestNativeSettingsHost.class] ? content.parentViewController : content;
}

@interface CSCustomViewController : UIViewController
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic) BOOL isAuthorized;
@property(nonatomic) BOOL authorizationPromptInFlight;
@property(nonatomic) BOOL returningFromAuthorization;
@property(nonatomic) NSUInteger setupCount;
@property(nonatomic) NSUInteger agreementChecks;
- (void)setupData;
- (void)checkUserAgreement;
- (void)returnFromUnauthorizedSettings;
@end

static BOOL CSCloseFriendPluginEntryHidden(void) { return NO; }
static void CSCloseFriendAuthenticate(UIViewController *controller, void (^completion)(BOOL)) { (void)controller; completion(NO); }

@implementation CSAuthorizationManager
+ (instancetype)sharedManager { static CSAuthorizationManager *manager; if(!manager)manager=[self new]; return manager; }
- (BOOL)isAuthorized {
    self.reads++; if(self.nextReads.count) { BOOL result=self.nextReads.firstObject.boolValue; self.nextReads=[self.nextReads subarrayWithRange:NSMakeRange(1,self.nextReads.count-1)]; return result; } return self.authorized;
}
- (void)openOfficialAccountFromViewController:(UIViewController *)controller { self.opens++; self.openSource=controller; }
#import "AuthorizationManagerPromptUnderTest.h"
@end

@implementation CSCustomViewController
- (instancetype)init { if((self=[super init]))_tableView=[UITableView new]; return self; }
- (void)setupData { self.setupCount++; }
- (void)checkUserAgreement { CHECK(self.isAuthorized && self.tableView.userInteractionEnabled); self.agreementChecks++; }
#import "AuthorizationSettingsUnderTest.h"
@end

static void DrainMainQueue(void) {
    // Production callbacks enqueue UI work on the main queue.
    [NSRunLoop.mainRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
}
static UIAlertController *AlertFrom(UIViewController *controller) {
    controller=CSNativeSettingsHostForContent(controller);
    CHECK([controller.presentedViewController isKindOfClass:UIAlertController.class]);
    UIAlertController *alert=(UIAlertController *)controller.presentedViewController;
    CHECK(alert.preferredStyle==UIAlertControllerStyleAlert);
    CHECK([alert.title isEqualToString:@"需要授权"]);
    CHECK(alert.actions.count==2);
    return alert;
}
static void Choose(UIAlertController *alert, UIAlertActionStyle style) {
    UIAlertAction *chosen=nil;
    for(UIAlertAction *action in alert.actions)if(action.style==style)chosen=action;
    CHECK(chosen!=nil && chosen.handler!=nil);
    chosen.handler(chosen); DrainMainQueue();
}
static CSCustomViewController *ContentInHost(UIViewController **hostOut) {
    UIViewController *host=[TestNativeSettingsHost new];
    CSCustomViewController *content=[CSCustomViewController new]; content.parentViewController=host; *hostOut=host; return content;
}
static void Attach(UINavigationController *nav, NSArray<UIViewController *> *controllers) {
    nav.viewControllers=controllers; for(UIViewController *controller in controllers)controller.navigationController=nav;
}
static void ResetManager(void) {
    CSAuthorizationManager *manager=CSAuthorizationManager.sharedManager;
    manager.authorized=NO; manager.nextReads=nil; manager.opens=0; manager.reads=0; manager.openSource=nil;
    deferDismissals=NO; pendingDismissals=nil;
}

int main(void) { @autoreleasepool {
    ResetManager(); CSAuthorizationManager *manager=CSAuthorizationManager.sharedManager;

    // Existing native entry points all call this same production manager method.
    UIViewController *entry=[UIViewController new]; __block NSUInteger completions=0;
    [manager requestAuthorizationWithPresentingViewController:entry completion:^(BOOL success, NSString *message) {
        CHECK(!success); CHECK([message isEqualToString:@"用户取消授权"]); completions++;
    }];
    Choose(AlertFrom(entry),UIAlertActionStyleCancel);
    CHECK(completions==1 && manager.opens==0 && entry.dismissCount==0 && entry.presentedViewController==nil);

    // Routing must wait until the system alert has finished leaving the screen.
    ResetManager(); entry=[UIViewController new]; completions=0;
    [manager requestAuthorizationWithPresentingViewController:entry completion:^(BOOL success, NSString *message) {
        CHECK(!success && message.length>0); completions++;
    }];
    deferDismissals=YES; Choose(AlertFrom(entry),UIAlertActionStyleDefault);
    CHECK(manager.opens==0 && completions==0 && pendingDismissals.count==1);
    deferDismissals=NO; pendingDismissals.firstObject(); DrainMainQueue(); pendingDismissals=nil;
    CHECK(manager.opens==1 && completions==1 && entry.presentedViewController==nil);
    ResetManager();

    // A third-party manager pushes the native container into its existing stack.
    UIViewController *wechat=[UIViewController new], *host;
    CSCustomViewController *content=ContentInHost(&host);
    UINavigationController *thirdPartyNav=[UINavigationController new]; Attach(thirdPartyNav,@[wechat,host]);
    [content viewDidAppear:NO]; UIAlertController *alert=AlertFrom(content);
    CHECK(!content.isAuthorized && !content.tableView.userInteractionEnabled);
    CHECK(content.authorizationPromptInFlight && content.agreementChecks==0);
    NSUInteger presentations=CSNativeSettingsHostForContent(content).presentationCount;
    [content viewDidAppear:NO]; CHECK(CSNativeSettingsHostForContent(content).presentationCount==presentations);
    Choose(alert,UIAlertActionStyleCancel);
    CHECK(thirdPartyNav.topViewController==wechat && thirdPartyNav.viewControllers.count==1);
    CHECK(thirdPartyNav.popCount+thirdPartyNav.popToCount==1);
    CHECK(wechat.dismissCount==0 && thirdPartyNav.dismissCount==0 && host.dismissCount==0);
    CHECK(!content.authorizationPromptInFlight && content.view.subviewAdds==0);
    presentations=CSNativeSettingsHostForContent(content).presentationCount;
    [content viewDidAppear:NO]; CHECK(CSNativeSettingsHostForContent(content).presentationCount==presentations);
    [content viewDidDisappear:NO]; CHECK(!content.returningFromAuthorization);
    Attach(thirdPartyNav,@[wechat,host]); [content viewDidAppear:NO];
    CHECK(CSNativeSettingsHostForContent(content).presentationCount==presentations+1);
    Choose(AlertFrom(content),UIAlertActionStyleCancel);

    // More/Settings entries present a plugin-owned nav. Cancel closes only it.
    ResetManager(); content=ContentInHost(&host);
    UINavigationController *pluginNav=[UINavigationController new]; Attach(pluginNav,@[host]);
    [wechat presentViewController:pluginNav animated:NO completion:nil];
    [content viewDidAppear:NO]; Choose(AlertFrom(content),UIAlertActionStyleCancel);
    CHECK(pluginNav.dismissCount==1 && wechat.presentedViewController==nil);
    CHECK(wechat.dismissCount==0 && host.dismissCount==0 && content.dismissCount==0);
    CHECK(pluginNav.popCount+pluginNav.popToCount==0);

    // Never dismiss an underlying WeChat presentation when the plugin is only
    // the root of an existing host stack with no plugin-owned modal to close.
    ResetManager(); UIViewController *wechatRoot=[UIViewController new]; content=ContentInHost(&host);
    UINavigationController *existingNav=[UINavigationController new]; Attach(existingNav,@[host]);
    wechatRoot.presentedViewController=existingNav;
    [content viewDidAppear:NO]; Choose(AlertFrom(content),UIAlertActionStyleCancel);
    CHECK(wechatRoot.dismissCount==0 && existingNav.dismissCount==0 && host.dismissCount==0 && content.dismissCount==0);

    // A direct fallback controller (no MMUIViewController host) also pops safely.
    ResetManager(); content=[CSCustomViewController new];
    UINavigationController *fallbackNav=[UINavigationController new]; Attach(fallbackNav,@[wechat,content]);
    [content viewDidAppear:NO]; Choose(AlertFrom(content),UIAlertActionStyleCancel);
    CHECK(fallbackNav.topViewController==wechat && wechat.dismissCount==0);

    // Direct modal fallback closes its own host, preserving the presenting page.
    ResetManager(); content=ContentInHost(&host);
    [wechat presentViewController:host animated:NO completion:nil];
    [content viewDidAppear:NO]; Choose(AlertFrom(content),UIAlertActionStyleCancel);
    CHECK(host.dismissCount==1 && wechat.dismissCount==0 && wechat.presentedViewController==nil);

    // A delayed callback must not pop whichever unrelated page is now on top.
    ResetManager(); content=ContentInHost(&host); UIViewController *unrelated=[UIViewController new];
    Attach(thirdPartyNav,@[wechat,host]); [content viewDidAppear:NO]; alert=AlertFrom(content);
    Attach(thirdPartyNav,@[wechat,host,unrelated]); Choose(alert,UIAlertActionStyleCancel);
    CHECK(thirdPartyNav.topViewController==unrelated && thirdPartyNav.viewControllers.count==3);
    CHECK(unrelated.dismissCount==0 && wechat.dismissCount==0);

    // Preserve an already-presented native page; do not stack another prompt on it.
    ResetManager(); content=ContentInHost(&host); host.presentedViewController=[UIViewController new];
    [content viewDidAppear:NO];
    CHECK(host.presentationCount==0 && !content.authorizationPromptInFlight && !content.tableView.userInteractionEnabled);
    host.presentedViewController=nil; [content viewDidAppear:NO]; Choose(AlertFrom(content),UIAlertActionStyleCancel);

    // Going to the account leaves settings locked and creates no second/custom UI.
    ResetManager(); content=ContentInHost(&host); Attach(thirdPartyNav,@[wechat,host]);
    [content viewDidAppear:NO]; Choose(AlertFrom(content),UIAlertActionStyleDefault);
    CHECK(manager.opens==1 && manager.openSource==host);
    CHECK(!content.isAuthorized && !content.tableView.userInteractionEnabled && !content.authorizationPromptInFlight);
    CHECK(content.view.subviewAdds==0 && CSNativeSettingsHostForContent(content).presentedViewController==nil);
    CHECK(thirdPartyNav.topViewController==host && content.agreementChecks==0);

    // Returning after following restores interaction before the agreement check.
    manager.authorized=YES; [content viewDidAppear:NO];
    CHECK(content.isAuthorized && content.tableView.userInteractionEnabled);
    CHECK(content.agreementChecks==1 && CSNativeSettingsHostForContent(content).presentedViewController==nil);

    // Follow data can change between the lifecycle read and manager recheck.
    // Honor the production success callback instead of treating it as refusal.
    ResetManager(); content=ContentInHost(&host); manager.nextReads=@[@NO,@YES];
    [content viewDidAppear:NO]; DrainMainQueue();
    CHECK(content.isAuthorized && content.tableView.userInteractionEnabled);
    CHECK(!content.authorizationPromptInFlight && content.agreementChecks==1 && CSNativeSettingsHostForContent(content).presentationCount==0);

    // The manager's already-authorized fast path never constructs an alert.
    ResetManager(); manager.authorized=YES; entry=[UIViewController new]; completions=0;
    [manager requestAuthorizationWithPresentingViewController:entry completion:^(BOOL success, NSString *message) {
        CHECK(success && message.length>0); completions++;
    }];
    CHECK(completions==1 && entry.presentationCount==0);
    printf("Authorization prompt/navigation: %lu checks passed\n",(unsigned long)checks);
} return 0; }
