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
@end
@implementation UIView
- (instancetype)initWithFrame:(NSRect)frame { if ((self=[super init])) _bounds=frame; return self; }
- (UIView *)viewWithTag:(NSInteger)tag { for (UIView *child in self.children) if (child.tag==tag) return child; return nil; }
- (void)addSubview:(UIView *)child { if (!self.children) self.children=[NSMutableArray array]; [self.children addObject:child]; }
- (void)removeFromSuperview {}
@end
@interface UITableView : NSObject
@property(nonatomic) NSUInteger reloads;
- (void)reloadData;
@end
@implementation UITableView
- (void)reloadData { self.reloads++; }
@end
@class UIViewController;
@interface UINavigationController : NSObject
@property(nonatomic, weak) UIViewController *topViewController;
@end
@implementation UINavigationController @end
@interface UIViewController : NSObject
@property(nonatomic, strong) UIView *view;
@property(nonatomic, strong) UINavigationController *navigationController;
@property(nonatomic, strong) UIViewController *host, *presentedViewController;
@property(nonatomic) BOOL isViewLoaded, isBeingDismissed;
@property(nonatomic) NSUInteger superEntries;
- (void)viewWillAppear:(BOOL)animated;
@end
@implementation UIViewController
- (void)viewWillAppear:(BOOL)animated { (void)animated; self.superEntries++; }
@end
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
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) CSPluginHeaderView *headerView;
@property(nonatomic) NSUInteger setups, contentRefreshes, layouts;
- (void)setupData;
- (void)refreshHeaderContent;
- (void)updateHeaderLayout;
- (void)refreshHeaderVerse;
- (void)settingsDidChange:(NSNotification *)notification;
- (void)refreshHeaderFromNotification:(NSNotification *)notification;
@end
@implementation CSCustomViewController
- (void)setupData { self.setups++; }
- (void)refreshHeaderContent { self.contentRefreshes++; }
- (void)updateHeaderLayout { self.layouts++; }
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
    UIApplication.sharedApplication.applicationState=UIApplicationStateActive;
    return page;
}

int main(void) { @autoreleasepool {
    CSPluginVerseProvider *provider=CSPluginVerseProvider.sharedProvider;
    CSCustomViewController *page=Page();
    page.view.window=nil;
    [page viewWillAppear:NO];
    Check(provider.completions.count==1 && page.headerVerseEntryGeneration==1 && page.superEntries==1,
          @"first real homepage entry starts one fresh provider request");
    Check([page.headerView.verse isEqual:@"缓存诗句"] && page.layouts==1, @"cached text displays immediately while a fresh request starts");
    Reply(0, @"首轮缓存回调"); Reply(0, @"首轮新句");
    Check([page.headerView.verse isEqual:@"首轮新句"] && page.layouts==3, @"current entry accepts cached and fast fresh completions before window attachment");
    page.view.window=[NSObject new];
    [page viewWillAppear:YES];
    Check(provider.completions.count==2 && page.headerVerseEntryGeneration==2, @"returning to the homepage always starts another fresh request");
    NSUInteger updates=page.headerView.updates;
    Reply(0, @"迟到的旧句");
    Check(page.headerView.updates==updates && ![page.headerView.verse isEqual:@"迟到的旧句"], @"old entry completion cannot overwrite the current entry");
    Reply(1, @"第二轮新句");
    Check([page.headerView.verse isEqual:@"第二轮新句"], @"current entry reply remains eligible after old callback arrives");

    NSUInteger requests=provider.completions.count, generation=page.headerVerseEntryGeneration;
    [page settingsDidChange:[NSNotification notificationWithName:@"com.wechat.tweak.settings_changed" object:nil]];
    [page refreshHeaderFromNotification:[NSNotification notificationWithName:@"CSPluginFeatureSummaryDidChangeNotification" object:nil]];
    DrainMain();
    Check(provider.completions.count==requests && page.headerVerseEntryGeneration==generation &&
          [page.headerView.verse isEqual:@"第二轮新句"], @"settings and feature notifications refresh account data without requesting random text");
    Check(page.contentRefreshes==4, @"entry and both notification routes still refresh ordinary header data");

    page.view.window=nil;
    Reply(1, @"进入转场的快速新句");
    Check([page.headerView.verse isEqual:@"进入转场的快速新句"], @"fast current-entry reply is retained before its view gains a window");
    page.view.window=[NSObject new];
    updates=page.headerView.updates;
    page.isViewLoaded=NO; Reply(1, @"卸载回调"); page.isViewLoaded=YES;
    Check(page.headerView.updates==updates, @"unloaded controller ignores completion without forcing its view to load");
    page.view.window=nil;
    [page refreshHeaderFromNotification:[NSNotification notificationWithName:@"CSPluginFeatureSummaryDidChangeNotification" object:nil]];
    DrainMain();
    Check(provider.completions.count==requests && page.contentRefreshes==4, @"offscreen settings notification starts no random-text request or header work");
    Reply(1, @"当前进入的离页缓存更新");
    Check([page.headerView.verse isEqual:@"当前进入的离页缓存更新"] && provider.completions.count==requests,
          @"current-generation offscreen result only updates existing header without requesting more text");
    page.view.window=[NSObject new];

    UIViewController *host=[UIViewController new]; host.navigationController=[UINavigationController new];
    host.navigationController.topViewController=host; page.host=host;
    [page viewWillAppear:NO];
    Check(provider.completions.count==3 && page.headerVerseEntryGeneration==3, @"next native host entry requests fresh text again");
    updates=page.headerView.updates;
    Reply(1, @"上一进入残留句");
    Check(page.headerView.updates==updates, @"prior visit cannot overwrite a new native-host entry before its response");
    Reply(2, @"第三轮新句");
    Check([page.headerView.verse isEqual:@"第三轮新句"], @"new entry remains authoritative across native hosting");

    __weak CSCustomViewController *weakPage;
    @autoreleasepool {
        CSCustomViewController *temporary=Page(); weakPage=temporary; [temporary viewWillAppear:NO];
    }
    Check(!weakPage, @"provider completion does not retain a departed settings controller");
    Reply(3, @"已释放页面的迟到句");
    Check(provider.completions.count==4, @"late completion after controller release remains harmless");
    fprintf(stdout, "Plugin header verse entry: %lu checks, %lu failures\n", (unsigned long)checks, (unsigned long)failures);
    return failures ? 1 : 0;
} }
