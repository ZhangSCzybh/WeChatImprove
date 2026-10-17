#import <UIKit/UIKit.h>
#import "CSNativeRewardPresenter.h"
#import "CSNativeRewardRoute.h"
#import "CSNativeSettingsHost.h"
#include <stdlib.h>
static unsigned checks;
#define CHECK(x) do { checks++; if (!(x)) { fprintf(stderr,"FAIL line %d: %s\n",__LINE__,#x); exit(1); } } while (0)
@implementation UIView
- (instancetype)init { if ((self=[super init])) _userInteractionEnabled=YES; return self; }
- (void)addSubview:(UIView *)view { if (!self.subviews) self.subviews=[NSMutableArray new]; [self.subviews addObject:view]; }
@end
@implementation UIViewController
- (instancetype)init { if ((self=[super init])) { _view=[UIView new]; _view.window=[NSObject new]; } return self; }
- (UINavigationController *)navigationController { return _navigationController ?: self.parentViewController.navigationController; }
- (void)viewDidLoad {}
- (void)addChildViewController:(UIViewController *)child {
    if (!self.childViewControllers) self.childViewControllers=[NSMutableArray new];
    [self.childViewControllers addObject:child]; child.parentViewController=self;
}
- (void)didMoveToParentViewController:(UIViewController *)parent { CHECK(parent==self.parentViewController); }
- (BOOL)isViewLoaded { return self.view != nil; }
- (void)presentViewController:(UIViewController *)controller animated:(BOOL)animated completion:(void (^)(void))completion {
    self.presentedViewController=controller; if (completion) completion();
}
@end
@implementation UINavigationController
- (UIViewController *)topViewController { return self.viewControllers.lastObject; }
- (void)pushViewController:(UIViewController *)controller animated:(BOOL)animated {
    self.pushCount++; controller.navigationController=self;
    self.viewControllers=[self.viewControllers arrayByAddingObject:controller];
}
@end
@implementation UIAlertAction
+ (instancetype)actionWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void (^)(UIAlertAction *))handler { return [self new]; }
@end
@implementation UIAlertController
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)style { return [self new]; }
- (void)addAction:(UIAlertAction *)action {}
@end
@interface CSCustomViewController : UIViewController @end
@implementation CSCustomViewController @end
@interface MMUIViewController : UIViewController
@property(nonatomic) NSUInteger nativeLoads;
@property(nonatomic) NSUInteger nativeStops;
@property(nonatomic) NSUInteger nativeViewLoads;
@property(nonatomic, strong) NSMutableDictionary *loadingViewX;
- (void)startLoadingNonBlock;
- (void)stopLoading;
@end
@implementation MMUIViewController
- (void)viewDidLoad { [super viewDidLoad]; self.nativeViewLoads++; }
- (void)startLoadingNonBlock { self.nativeLoads++; self.loadingViewX=[NSMutableDictionary new]; }
- (void)stopLoading { self.nativeStops++; self.loadingViewX=nil; }
@end
@interface WCPayQRCodeRewardPayerDetailViewController : MMUIViewController @end
@implementation WCPayQRCodeRewardPayerDetailViewController @end
@interface ScanQRCodeLogicParams : NSObject @end
@implementation ScanQRCodeLogicParams @end
@interface CSNativeRewardRoute (Callbacks)
- (UIViewController *)onScanQRCodeUrlPrefixHandlerRequestViewController;
- (void)onScanQRCodeUrlPrefixHandlerEnd;
@end
@interface PresenterPayer : NSObject
@property(nonatomic) NSUInteger stops;
- (void)stopLogic;
@end
@implementation PresenterPayer
- (void)stopLogic { self.stops++; }
@end
static NSUInteger routeCalls;
static BOOL rejectDelegate;
@interface ScanWXCodeRewardUrlPrefixHandler : NSObject
@property(nonatomic, weak) CSNativeRewardRoute *m_delegate;
@property(nonatomic, strong) PresenterPayer *qrcodeRewardPayerLogic;
- (void)handleUrl:(id)content;
- (void)showNativePage;
@end
static ScanWXCodeRewardUrlPrefixHandler *lastHandler;
static __weak UIViewController *receivedHost;
@implementation ScanWXCodeRewardUrlPrefixHandler
- (instancetype)init { if ((self=[super init])) { _qrcodeRewardPayerLogic=[PresenterPayer new]; lastHandler=self; } return self; }
- (void)setM_delegate:(CSNativeRewardRoute *)delegate { _m_delegate=rejectDelegate ? nil : delegate; }
- (void)handleUrl:(id)content {
    CHECK([content isEqual:@"m0Ggq8kqRKX/V3Z-Ior(?3"]);
    routeCalls++; receivedHost=[self.m_delegate onScanQRCodeUrlPrefixHandlerRequestViewController];
    // Mirror native global-top loading calls, not merely the delegate's host identity.
    MMUIViewController *top=(id)receivedHost.navigationController.topViewController;
    CHECK([top isKindOfClass:MMUIViewController.class]);
    [top startLoadingNonBlock];
    [top.loadingViewX setObject:@"loading" forKey:@"text"];
    CHECK(top.loadingViewX != nil);
}
- (void)showNativePage {
    UIViewController *source=[self.m_delegate onScanQRCodeUrlPrefixHandlerRequestViewController];
    // Executed after handleUrl: returns: an outer @try cannot catch this failure.
    [(MMUIViewController *)source.navigationController.topViewController stopLoading];
    [source.navigationController pushViewController:[WCPayQRCodeRewardPayerDetailViewController new] animated:YES];
}
@end
@interface CSNativeRewardSession : NSObject
- (void)start;
- (void)observePresentation;
@end
static void Tick(void) { [NSRunLoop.mainRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.25]]; }
int main(void) { @autoreleasepool {
    UIViewController *source=[[CSNativeSettingsControllerClass() alloc] init];
    CHECK([source isKindOfClass:MMUIViewController.class]);
    CHECK(CSNativeSettingsControllerClass()==source.class);
    [source viewDidLoad];
    CHECK(((MMUIViewController *)source).nativeViewLoads==1);
    CHECK(source.childViewControllers.count==1);
    UIViewController *content=source.childViewControllers.firstObject;
    CHECK([content isKindOfClass:CSCustomViewController.class]);
    CHECK(content.view != source.view);
    CHECK([source.view.subviews containsObject:content.view]);
    CHECK(CSNativeSettingsHostForContent(content)==source);
    UINavigationController *nav=[UINavigationController new];
    nav.viewControllers=@[source]; source.navigationController=nav;
    CSOpenNativeAuthorReward(content);
    CHECK(routeCalls==1); CHECK(receivedHost==source);
    CHECK(!source.view.userInteractionEnabled);
    CHECK(nav.viewControllers.count==1); CHECK(nav.pushCount==0);
    CHECK(source.presentedViewController==nil);
    CSOpenNativeAuthorReward(content); CHECK(routeCalls==1);
    [lastHandler showNativePage]; Tick();
    CHECK(nav.viewControllers.count==2); CHECK(nav.pushCount==1);
    CHECK([nav.topViewController isKindOfClass:WCPayQRCodeRewardPayerDetailViewController.class]);
    CHECK(lastHandler.m_delegate.state==CSNativeRewardPresented);
    CHECK(source.view.userInteractionEnabled);
    CHECK(((MMUIViewController *)source).nativeLoads==1);
    CHECK(((MMUIViewController *)source).nativeStops==1);
    PresenterPayer *firstPayer=lastHandler.qrcodeRewardPayerLogic;
    nav.viewControllers=@[source]; Tick(); // Native back gesture without an End callback.
    CHECK(firstPayer.stops==1); CHECK(lastHandler.m_delegate==nil);
    CHECK(source.view.userInteractionEnabled);
    CHECK(nav.topViewController==source); CHECK(source.presentedViewController==nil);
    CSOpenNativeAuthorReward(content); CHECK(routeCalls==2);
    [lastHandler showNativePage]; Tick();
    nav.viewControllers=@[source];
    [lastHandler.m_delegate onScanQRCodeUrlPrefixHandlerEnd]; Tick();
    CHECK(nav.viewControllers.count==1); CHECK(nav.topViewController==source);
    CHECK(source.presentedViewController==nil); // No completion page or success alert.
    CSOpenNativeAuthorReward(content); CHECK(routeCalls==3);
    nav.isBeingDismissed=YES; Tick();
    CHECK(lastHandler.m_delegate==nil);
    CHECK(source.view.userInteractionEnabled);
    nav.isBeingDismissed=NO;
    rejectDelegate=YES;
    CSOpenNativeAuthorReward(content); Tick();
    CHECK(routeCalls==3); CHECK(nav.viewControllers.count==1);
    CHECK([source.presentedViewController isKindOfClass:UIAlertController.class]);
    source.presentedViewController=nil; rejectDelegate=NO;
    // Exercise timeout without a twelve-second wait, using a real production session.
    CSNativeRewardSession *session=[CSNativeRewardSession new];
    [session setValue:source forKey:@"source"];
    [session start];
    [session setValue:@(NSProcessInfo.processInfo.systemUptime-13) forKey:@"beganAt"];
    [session observePresentation];
    CHECK(lastHandler.m_delegate==nil);
    CHECK(nav.viewControllers.count==1); CHECK(nav.topViewController==source);
    CHECK([source.presentedViewController isKindOfClass:UIAlertController.class]);
    source.presentedViewController=nil;
    CSOpenNativeAuthorReward(content); CHECK(routeCalls==5);
    [lastHandler.m_delegate onScanQRCodeUrlPrefixHandlerEnd]; Tick();
    CHECK(nav.viewControllers.count==1); CHECK(source.presentedViewController==nil);
    printf("Native reward presenter: %u checks passed\n",checks);
} return 0; }
