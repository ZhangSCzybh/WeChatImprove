#import <UIKit/UIKit.h>

static NSUInteger checks;
#define CHECK(...) do { checks++; if (!(__VA_ARGS__)) { fprintf(stderr,"FAIL %d: %s\n",__LINE__,#__VA_ARGS__); exit(1); } } while (0)

// Reuse the background tests' App/Scene declarations; only visibility and
// reload counts are modeled. The actual controller methods are included below.
NSNotificationName const UIApplicationDidBecomeActiveNotification=@"AppActive";
NSNotificationName const UISceneDidActivateNotification=@"SceneActive";
@implementation UIScene @end
@implementation UIApplication
+ (instancetype)sharedApplication { static id app; if (!app) app=[self new]; return app; }
- (UIBackgroundTaskIdentifier)beginBackgroundTaskWithName:(NSString *)name expirationHandler:(void (^)(void))handler { return UIBackgroundTaskInvalid; }
- (void)endBackgroundTask:(UIBackgroundTaskIdentifier)identifier {}
@end
@interface UIWindow : NSObject
@property(nonatomic) UIScene *windowScene;
@property(nonatomic) BOOL hidden;
@end
@implementation UIWindow @end
@interface UIView : NSObject
@property(nonatomic) UIWindow *window;
@property(nonatomic) BOOL hidden;
@end
@implementation UIView @end
@interface UINavigationController : NSObject
@property(nonatomic, weak) id topViewController;
@end
@implementation UINavigationController @end
@interface CSSettingsTableViewController : NSObject
@property(nonatomic) UIView *viewIfLoaded;
@property(nonatomic) UINavigationController *navigationController;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewIsAppearing:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
@end
@implementation CSSettingsTableViewController
- (void)viewWillAppear:(BOOL)animated {}
- (void)viewIsAppearing:(BOOL)animated {}
- (void)viewWillDisappear:(BOOL)animated {}
@end
@interface CSBackgroundRunManager : NSObject
@property(nonatomic) NSUInteger reloads;
@property(nonatomic, copy) dispatch_block_t onReload;
+ (instancetype)sharedManager;
- (void)reloadSettings;
@end
@implementation CSBackgroundRunManager
+ (instancetype)sharedManager { static id manager; if (!manager) manager=[self new]; return manager; }
- (void)reloadSettings { self.reloads++; if (self.onReload) self.onReload(); }
@end
@interface CSBackgroundRunViewController : CSSettingsTableViewController
@property(nonatomic) BOOL settingsPageVisible, sectionsDirty, sectionsRefreshPending;
@property(nonatomic) NSUInteger rebuilds;
- (void)stateChanged:(NSNotification *)notification;
- (void)activityChanged:(NSNotification *)notification;
- (void)rebuildSections;
@end
@implementation CSBackgroundRunViewController
#include "BackgroundRunViewRefreshUnderTest.h"
- (void)rebuildSections { CHECK([self canRefreshSections]); self.rebuilds++; }
@end

static void DrainMain(void) {
    for (NSUInteger i=0;i<3;i++) {
        __block BOOL done=NO;
        dispatch_async(dispatch_get_main_queue(),^{ done=YES; });
        while (!done) [NSRunLoop.mainRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:.01]];
    }
}
static void Activity(CSBackgroundRunViewController *page, NSString *name, id object) {
    [page activityChanged:[NSNotification notificationWithName:name object:object]];
}
static void Appear(CSBackgroundRunViewController *page) {
    [page viewWillAppear:NO]; [page viewIsAppearing:NO];
}
int main(void) { @autoreleasepool {
    UIApplication *app=UIApplication.sharedApplication; app.applicationState=UIApplicationStateActive;
    UIScene *scene=[UIScene new]; scene.activationState=UISceneActivationStateForegroundActive;
    UIScene *other=[UIScene new]; other.activationState=UISceneActivationStateForegroundActive;
    UIWindow *window=[UIWindow new]; window.windowScene=scene;
    CSBackgroundRunViewController *page=[CSBackgroundRunViewController new];
    page.viewIfLoaded=[UIView new]; page.navigationController=[UINavigationController new]; page.navigationController.topViewController=page;
    __weak CSBackgroundRunViewController *weakPage=page;
    CSBackgroundRunManager *manager=CSBackgroundRunManager.sharedManager;
    manager.onReload=^{ [weakPage stateChanged:nil]; [weakPage stateChanged:nil]; };

    [page viewWillAppear:NO]; DrainMain();
    CHECK(!page.rebuilds && page.sectionsDirty && !page.sectionsRefreshPending);
    page.viewIfLoaded.window=window;
    [page viewIsAppearing:NO]; DrainMain();
    CHECK(page.rebuilds==1 && !page.sectionsDirty && manager.reloads==1);

    for (NSUInteger i=0;i<100;i++) [page stateChanged:nil];
    CHECK(page.rebuilds==1 && page.sectionsRefreshPending); DrainMain();
    CHECK(page.rebuilds==2 && !page.sectionsDirty);
    [page stateChanged:nil]; [page viewWillDisappear:NO]; DrainMain();
    CHECK(page.rebuilds==2 && page.sectionsDirty && !page.sectionsRefreshPending);
    for (NSUInteger i=0;i<100;i++) [page stateChanged:nil];
    CHECK(!page.sectionsRefreshPending);
    Appear(page); DrainMain(); CHECK(page.rebuilds==3);

    // Another scene being active cannot make this background scene render.
    app.applicationState=UIApplicationStateBackground; scene.activationState=UISceneActivationStateBackground;
    [page stateChanged:nil]; Activity(page,@"AppInactive",app); DrainMain();
    CHECK(page.rebuilds==3 && page.sectionsDirty && !page.sectionsRefreshPending);
    app.applicationState=UIApplicationStateActive;
    Activity(page,UISceneDidActivateNotification,other); Activity(page,UIApplicationDidBecomeActiveNotification,app); DrainMain();
    CHECK(page.rebuilds==3 && !page.sectionsRefreshPending);
    scene.activationState=UISceneActivationStateForegroundActive;
    Activity(page,UISceneDidActivateNotification,scene); Activity(page,UIApplicationDidBecomeActiveNotification,app); DrainMain();
    CHECK(page.rebuilds==4 && !page.sectionsDirty);
    Activity(page,UISceneDidActivateNotification,other); DrainMain(); CHECK(page.rebuilds==4);

    [page stateChanged:nil]; app.applicationState=UIApplicationStateInactive;
    Activity(page,@"AppInactive",app); DrainMain(); CHECK(page.rebuilds==4 && page.sectionsDirty);
    app.applicationState=UIApplicationStateActive;
    Activity(page,UIApplicationDidBecomeActiveNotification,app); DrainMain(); CHECK(page.rebuilds==5);
    NSUInteger reloads=manager.reloads;
    CHECK(reloads==2); // Activation observes state; it does not reload settings.

    NSObject *cover=[NSObject new]; page.navigationController.topViewController=cover;
    [page stateChanged:nil]; DrainMain(); CHECK(page.rebuilds==5 && !page.sectionsRefreshPending);
    page.navigationController.topViewController=page; Appear(page); DrainMain(); CHECK(page.rebuilds==6);
    window.hidden=YES; [page stateChanged:nil]; DrainMain(); CHECK(page.rebuilds==6);
    window.hidden=NO; Activity(page,UISceneDidActivateNotification,scene); DrainMain(); CHECK(page.rebuilds==7);

    dispatch_sync(dispatch_get_global_queue(QOS_CLASS_DEFAULT,0),^{ [page stateChanged:nil]; });
    DrainMain(); CHECK(page.rebuilds==8 && !page.sectionsDirty);
    // Neither kind of queued dispatch may retain a popped settings page.
    @autoreleasepool {
        CSBackgroundRunViewController *released=[CSBackgroundRunViewController new];
        released.viewIfLoaded=[UIView new]; released.viewIfLoaded.window=window;
        released.settingsPageVisible=YES; [released stateChanged:nil];
        CHECK(released.sectionsRefreshPending);
        __weak CSBackgroundRunViewController *weakReleased=released; released=nil;
        CHECK(!weakReleased); DrainMain(); CHECK(!weakReleased);
    }
    printf("Background settings visibility: %lu assertions passed\n",(unsigned long)checks);
} return 0; }
