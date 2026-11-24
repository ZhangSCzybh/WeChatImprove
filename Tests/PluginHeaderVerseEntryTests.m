#import <Foundation/Foundation.h>
#import "CSPreferenceRefresh.h"

// Execute the real controller lifecycle and notification methods with Foundation
// fixtures. The provider records requests and can deliberately deliver old replies.
enum { UIApplicationStateActive=0, UIApplicationStateBackground=2,
       UIViewAutoresizingFlexibleWidth=1, UIViewAutoresizingFlexibleHeight=2 };
@interface UIColor : NSObject
+ (instancetype)systemBackgroundColor;
@end
@implementation UIColor
+ (instancetype)systemBackgroundColor { return [self new]; }
@end
@interface UIView : NSObject
@property(nonatomic, strong) id window;
@property(nonatomic) NSRect bounds;
@property(nonatomic) NSInteger tag, autoresizingMask;
@property(nonatomic, strong) UIColor *backgroundColor;
@property(nonatomic, strong) NSMutableArray<UIView *> *children;
- (instancetype)initWithFrame:(NSRect)frame;
- (UIView *)viewWithTag:(NSInteger)tag;
- (void)addSubview:(UIView *)child;
- (void)removeFromSuperview;
- (void)layoutIfNeeded;
+ (void)performWithoutAnimation:(void (^)(void))actions;
@end
@implementation UIView
- (instancetype)initWithFrame:(NSRect)frame { if ((self=[super init])) _bounds=frame; return self; }
- (UIView *)viewWithTag:(NSInteger)tag { for (UIView *child in self.children) if (child.tag==tag) return child; return nil; }
- (void)addSubview:(UIView *)child { if (!self.children) self.children=[NSMutableArray array]; [self.children addObject:child]; }
- (void)removeFromSuperview {}
- (void)layoutIfNeeded {}
+ (void)performWithoutAnimation:(void (^)(void))actions { actions(); }
@end
@interface UITableView : NSObject
@property(nonatomic) NSUInteger reloads;
- (void)reloadData;
@end
@implementation UITableView
- (void)reloadData { self.reloads++; }
@end
@class UINavigationController;
@interface UIViewController : NSObject
@property(nonatomic, strong) UIView *view;
@property(nonatomic, strong) UINavigationController *navigationController;
@property(nonatomic, strong) UIViewController *host, *presentedViewController;
@property(nonatomic, weak) UIViewController *parentViewController;
@property(nonatomic) BOOL isViewLoaded, isBeingDismissed, isMovingFromParentViewController;
@property(nonatomic) NSUInteger superEntries;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidDisappear:(BOOL)animated;
@end
@implementation UIViewController
- (void)viewWillAppear:(BOOL)animated { (void)animated; self.superEntries++; }
- (void)viewDidDisappear:(BOOL)animated { (void)animated; }
@end
@interface UINavigationController : UIViewController
@property(nonatomic, weak) UIViewController *topViewController;
@property(nonatomic, copy) NSArray<UIViewController *> *viewControllers;
@end
@implementation UINavigationController @end
static UIViewController *CSNativeSettingsHostForContent(UIViewController *controller) { return controller.host ?: controller; }
static BOOL CSCloseFriendPluginEntryHidden(void) { return NO; }
@interface UIApplication : NSObject
@property(nonatomic) NSInteger applicationState;
+ (instancetype)sharedApplication;
@end
@implementation UIApplication
+ (instancetype)sharedApplication { static UIApplication *app; if (!app) app=[self new]; return app; }
@end
@interface CSPluginHeaderView : NSObject
@property(nonatomic, copy) NSString *verse;
@property(nonatomic) NSUInteger updates;
- (void)setVerse:(NSString *)verse;
@end
@implementation CSPluginHeaderView
- (void)setVerse:(NSString *)verse { _verse=[verse copy]; self.updates++; }
@end
@interface CSPluginVerseProvider : NSObject
@property(nonatomic, copy) NSString *currentVerse;
@property(nonatomic, strong) NSMutableArray *completions;
+ (instancetype)sharedProvider;
- (void)refreshWithCompletion:(void (^)(NSString *))completion;
@end
@implementation CSPluginVerseProvider
+ (instancetype)sharedProvider {
    static CSPluginVerseProvider *provider;
    if (!provider) { provider=[self new]; provider.currentVerse=@"缓存诗句"; provider.completions=[NSMutableArray array]; }
    return provider;
}
- (void)refreshWithCompletion:(void (^)(NSString *))completion { [self.completions addObject:[completion copy]]; }
@end
@interface CSCustomViewController : UIViewController {
    atomic_bool _headerRefreshPending;
}
@property(nonatomic) NSUInteger headerVerseEntryGeneration;
@property(nonatomic) BOOL headerVerseVisitActive, returningFromAuthorization;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) CSPluginHeaderView *headerView;
@property(nonatomic) NSUInteger setups, contentRefreshes, layouts;
@property(nonatomic,strong) NSNumber *pendingHomeDistance,*homeAppearanceDistance;
@property(nonatomic,copy) NSArray *homePreparedScope;
- (void)setupData;
- (void)reloadSettingsKeepingPosition;
- (void)refreshHeaderContent;
- (void)updateHeaderLayout;
- (void)refreshHeaderVerse;
- (void)finishHeaderVerseVisitIfLeaving;
- (void)settingsDidChange:(NSNotification *)notification;
- (void)refreshHeaderFromNotification:(NSNotification *)notification;
- (CGFloat)currentHomeDistance;
- (BOOL)returningFromOtherSettingsInCurrentScope;
- (void)refreshVisibleHomeAppearance;
- (NSArray *)currentHomePreparationScope;
@end
@implementation CSCustomViewController
- (void)setupData { self.setups++; }
- (void)reloadSettingsKeepingPosition { [self.tableView reloadData]; }
- (void)refreshHeaderContent { self.contentRefreshes++; }
- (void)updateHeaderLayout { self.layouts++; }
- (CGFloat)currentHomeDistance { return 0; }
- (BOOL)returningFromOtherSettingsInCurrentScope { return NO; }
- (void)refreshVisibleHomeAppearance {}
- (NSArray *)currentHomePreparationScope { return @[@"verse-fixture"]; }
#include "HeaderVerseEntryUnderTest.h"
@end

static NSUInteger checks, failures;
static void Check(BOOL result, NSString *message) {
    checks++;
    if (!result) { failures++; fprintf(stderr, "FAIL: %s\n", message.UTF8String); }
}
static void DrainMain(void) {
    __block BOOL done=NO;
    dispatch_async(dispatch_get_main_queue(), ^{ done=YES; });
    NSDate *deadline=[NSDate dateWithTimeIntervalSinceNow:1];
    while (!done && deadline.timeIntervalSinceNow>0)
        [NSRunLoop.currentRunLoop runMode:NSDefaultRunLoopMode beforeDate:deadline];
    Check(done, @"main queue refresh completed");
}
static void Reply(NSUInteger index, NSString *verse) {
    void (^completion)(NSString *)=CSPluginVerseProvider.sharedProvider.completions[index];
    completion(verse);
}
static CSCustomViewController *Page(void) {
    CSCustomViewController *page=[CSCustomViewController new];
    page.view=[UIView new]; page.view.window=[NSObject new]; page.isViewLoaded=YES;
    page.tableView=[UITableView new]; page.headerView=[CSPluginHeaderView new];
    page.navigationController=[UINavigationController new]; page.navigationController.topViewController=page;
    page.navigationController.viewControllers=@[page];
    UIApplication.sharedApplication.applicationState=UIApplicationStateActive;
    return page;
}

int main(void) { @autoreleasepool {
    CSPluginVerseProvider *provider=CSPluginVerseProvider.sharedProvider;
    CSCustomViewController *page=Page();
    page.view.window=nil;
    [page viewWillAppear:NO];
    Check(provider.completions.count==1 && page.headerVerseEntryGeneration==1 && page.superEntries==1 && page.headerVerseVisitActive,
          @"first plugin visit starts exactly one request before window attachment");
    Check([page.headerView.verse isEqual:@"缓存诗句"] && page.layouts==1, @"cached text displays immediately while the first request starts");
    Reply(0, @"首轮缓存回调"); Reply(0, @"首轮新句");
    Check([page.headerView.verse isEqual:@"首轮新句"] && page.layouts==3, @"current visit accepts fast cached and fresh replies before window attachment");
    page.view.window=[NSObject new];
    [page viewWillAppear:YES];
    [page refreshHeaderVerse];
    Check(provider.completions.count==1 && page.headerVerseEntryGeneration==1 && [page.headerView.verse isEqual:@"首轮新句"],
          @"repeated appearance and direct refresh cannot request or replace text during one visit");

    NSUInteger requests=provider.completions.count, generation=page.headerVerseEntryGeneration;
    NSUInteger refreshes=page.contentRefreshes;
    [page settingsDidChange:[NSNotification notificationWithName:@"com.wechat.tweak.settings_changed" object:nil]];
    [page refreshHeaderFromNotification:[NSNotification notificationWithName:@"CSPluginFeatureSummaryDidChangeNotification" object:nil]];
    DrainMain();
    Check(provider.completions.count==requests && page.headerVerseEntryGeneration==generation &&
          [page.headerView.verse isEqual:@"首轮新句"], @"settings and feature refresh routes never request random text");
    Check(page.contentRefreshes==refreshes+2, @"ordinary header data still refreshes through both notification routes");

    UIViewController *detail=[UIViewController new];
    page.navigationController.topViewController=detail;
    page.navigationController.viewControllers=@[page,detail];
    [page viewDidDisappear:YES];
    Check(page.headerVerseVisitActive, @"pushing a plugin detail retains the current visit");
    page.view.window=nil;
    Reply(0, @"当前访问的异步新句");
    Check([page.headerView.verse isEqual:@"当前访问的异步新句"], @"in-flight reply remains eligible while a plugin detail is showing");
    page.navigationController.topViewController=page;
    page.navigationController.viewControllers=@[page];
    page.view.window=[NSObject new];
    [page viewWillAppear:YES];
    Check(provider.completions.count==1 && [page.headerView.verse isEqual:@"当前访问的异步新句"], @"returning from a detail keeps text without another request");

    page.presentedViewController=detail;
    [page viewDidDisappear:YES]; [page viewWillAppear:YES];
    page.presentedViewController=nil;
    Check(provider.completions.count==1 && page.headerVerseVisitActive, @"full-screen picker appearance does not end the plugin visit");
    UIApplication.sharedApplication.applicationState=UIApplicationStateBackground;
    page.view.window=nil; [page viewDidDisappear:NO];
    UIApplication.sharedApplication.applicationState=UIApplicationStateActive;
    [page viewWillAppear:NO]; page.view.window=[NSObject new];
    Check(provider.completions.count==1 && page.headerVerseVisitActive, @"backgrounding and window loss do not count as a plugin exit");
    page.isMovingFromParentViewController=YES;
    // A cancelled interactive back gesture restores appearance without completing disappearance.
    [page viewWillAppear:YES]; page.isMovingFromParentViewController=NO;
    Check(provider.completions.count==1 && page.headerVerseVisitActive, @"cancelled interactive navigation keeps the current visit");

    NSUInteger updates=page.headerView.updates;
    page.isViewLoaded=NO; Reply(0, @"卸载回调"); page.isViewLoaded=YES;
    Check(page.headerView.updates==updates, @"unloaded controller ignores replies without loading its view");
    page.view.window=nil;
    refreshes=page.contentRefreshes;
    [page refreshHeaderFromNotification:[NSNotification notificationWithName:@"CSPluginFeatureSummaryDidChangeNotification" object:nil]];
    DrainMain();
    Check(provider.completions.count==1 && page.contentRefreshes==refreshes, @"offscreen notification starts no request or header work");
    page.view.window=[NSObject new];

    page.isMovingFromParentViewController=YES;
    [page viewDidDisappear:YES];
    Check(!page.headerVerseVisitActive, @"completed direct-controller pop ends the visit");
    updates=page.headerView.updates; Reply(0, @"退出后的旧句");
    Check(page.headerView.updates==updates, @"departed visit ignores late replies immediately");
    page.isMovingFromParentViewController=NO;
    [page viewWillAppear:YES];
    Check(provider.completions.count==2 && page.headerVerseEntryGeneration==2 && page.headerVerseVisitActive,
          @"reentering the same controller starts one new request");
    updates=page.headerView.updates; Reply(0, @"上一访问残留句");
    Check(page.headerView.updates==updates, @"previous visit cannot overwrite the new visit");
    Reply(1, @"第二轮新句");
    Check([page.headerView.verse isEqual:@"第二轮新句"], @"new visit accepts its own reply");

    UIViewController *host=[UIViewController new];
    UINavigationController *navigation=[UINavigationController new];
    host.navigationController=navigation; host.parentViewController=navigation;
    navigation.topViewController=host; navigation.viewControllers=@[host];
    page.host=host;
    [page viewWillAppear:NO];
    Check(provider.completions.count==2, @"native containment alone does not restart a visit");
    navigation.topViewController=detail; navigation.viewControllers=@[host,detail];
    [page viewDidDisappear:YES]; [page viewWillAppear:YES];
    Check(provider.completions.count==2 && page.headerVerseVisitActive, @"native-host detail push and return retain one visit");
    host.isMovingFromParentViewController=YES; [page viewDidDisappear:YES];
    Check(!page.headerVerseVisitActive, @"completed native-host pop ends its child content visit");
    host.isMovingFromParentViewController=NO;
    navigation.topViewController=host; navigation.viewControllers=@[host];
    [page viewWillAppear:YES];
    Check(provider.completions.count==3 && page.headerVerseEntryGeneration==3, @"reused native host refreshes exactly once after reentry");
    updates=page.headerView.updates; Reply(1, @"第二轮迟到句");
    Check(page.headerView.updates==updates, @"prior host visit callback cannot replace a reentered visit");
    Reply(2, @"第三轮新句");
    Check([page.headerView.verse isEqual:@"第三轮新句"], @"native-host reentry accepts its new text");

    navigation.isBeingDismissed=YES; [page viewDidDisappear:YES];
    Check(!page.headerVerseVisitActive, @"dismissal of the navigation ancestor ends the plugin visit");
    navigation.isBeingDismissed=NO; [page viewWillAppear:YES];
    Check(provider.completions.count==4, @"reentry after container dismissal refreshes once");
    host.isBeingDismissed=YES; [page viewDidDisappear:YES];
    Check(!page.headerVerseVisitActive, @"direct modal host dismissal ends the visit");
    host.isBeingDismissed=NO; [page viewWillAppear:YES];
    Check(provider.completions.count==5, @"reentry after direct host dismissal refreshes once");
    navigation.viewControllers=@[]; [page viewDidDisappear:YES];
    Check(!page.headerVerseVisitActive, @"completed stack removal also ends the visit after movement flags clear");
    updates=page.headerView.updates; Reply(4, @"移出导航后的旧句");
    Check(page.headerView.updates==updates, @"stack-removed visit rejects its late reply");

    // Release all fixture containment references before testing weak provider callbacks.
    page.host=nil; page.navigationController.viewControllers=@[];
    __weak CSCustomViewController *weakPage;
    NSUInteger temporaryRequest=provider.completions.count;
    @autoreleasepool {
        CSCustomViewController *temporary=Page(); weakPage=temporary; [temporary viewWillAppear:NO];
        temporary.navigationController.viewControllers=@[];
    }
    Check(!weakPage, @"provider callback does not retain a departed controller");
    Reply(temporaryRequest, @"已释放页面的迟到句");
    Check(provider.completions.count==temporaryRequest+1, @"late reply after controller release cannot request more text");
    fprintf(stdout, "Plugin header verse entry: %lu checks, %lu failures\n", (unsigned long)checks, (unsigned long)failures);
    return failures ? 1 : 0;
} }
