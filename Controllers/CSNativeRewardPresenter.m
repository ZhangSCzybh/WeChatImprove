#import "CSNativeRewardPresenter.h"
#import "CSNativeRewardRoute.h"
#import "CSNativeSettingsHost.h"
#import <objc/runtime.h>
#import <objc/message.h>

static char CSRewardSessionKey;

// Own the request on the existing settings screen. Never insert a plugin controller
// into the navigation stack; only WeChat creates/presents the actual reward screens.
@interface CSNativeRewardSession : NSObject
@property(nonatomic, weak) UIViewController *source;
@property(nonatomic, strong) CSNativeRewardRoute *route;
@property(nonatomic, strong) NSTimer *observer;
@property(nonatomic, strong) NSTimer *openingDeadline;
@property(nonatomic) NSTimeInterval beganAt;
@property(nonatomic) BOOL observedPaymentPage;
@property(nonatomic) BOOL lockedSettings;
@property(nonatomic) BOOL priorInteractionEnabled;
@property(nonatomic) BOOL finished;
- (void)start;
- (void)finish;
- (void)observePresentation;
@end

@implementation CSNativeRewardSession
- (BOOL)sourceIsCurrent {
    UIViewController *source = self.source;
    return source && source.isViewLoaded && source.view.window && !source.isBeingDismissed &&
        !source.navigationController.isBeingDismissed && !source.presentedViewController &&
        (!source.navigationController || source.navigationController.topViewController == source);
}
- (void)showFailure:(NSString *)message {
    if (![self sourceIsCurrent]) return;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"暂时无法打开赞赏" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil]];
    [self.source presentViewController:alert animated:YES completion:nil];
}
- (void)start {
    // Native CGI loading callbacks address the current top controller. Keep the
    // settings content from pushing an unrelated, ordinary controller mid-request.
    self.priorInteractionEnabled = self.source.view.userInteractionEnabled;
    self.lockedSettings = YES;
    self.source.view.userInteractionEnabled = NO;
    self.route = [[CSNativeRewardRoute alloc] initWithHost:self.source];
    __weak typeof(self) weakSelf = self;
    self.route.changed = ^(CSNativeRewardState state, NSString *message) {
        CSNativeRewardSession *session = weakSelf;
        if (!session) return;
        if (state == CSNativeRewardFailed) {
            // Defer until the native call stack has unwound before releasing the request.
            dispatch_async(dispatch_get_main_queue(), ^{ [session finish]; [session showFailure:message]; });
        } else if (state == CSNativeRewardFinished) {
            dispatch_async(dispatch_get_main_queue(), ^{ [session finish]; });
        }
    };
    self.beganAt = NSProcessInfo.processInfo.systemUptime;
    for (NSString *name in @[UIApplicationDidBecomeActiveNotification, UIApplicationWillResignActiveNotification, UIApplicationDidEnterBackgroundNotification]) {
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(applicationStateChanged:) name:name object:nil];
    }
    // The opening deadline is independent of display polling. In the background
    // it leaves the native route alone; activation first checks the actual page.
    self.openingDeadline = [NSTimer timerWithTimeInterval:12 repeats:NO block:^(NSTimer *timer) { [weakSelf observePresentation]; }];
    [NSRunLoop.mainRunLoop addTimer:self.openingDeadline forMode:NSRunLoopCommonModes];
    [self refreshObservation];
    [self.route start];
}
- (void)refreshObservation {
    if (self.finished || UIApplication.sharedApplication.applicationState != UIApplicationStateActive) {
        [self.observer invalidate]; self.observer = nil; return;
    }
    // Host appearance and the native End callback own normal return handling.
    // A slower fallback also covers versions that omit End for a back gesture.
    NSTimeInterval interval = self.observedPaymentPage ? 2 : 0.2;
    if (self.observer.valid && self.observer.timeInterval == interval) return;
    [self.observer invalidate];
    __weak typeof(self) weakSelf = self;
    self.observer = [NSTimer timerWithTimeInterval:interval repeats:YES block:^(NSTimer *timer) { [weakSelf observePresentation]; }];
    self.observer.tolerance = self.observedPaymentPage ? 0.5 : 0.02;
    [NSRunLoop.mainRunLoop addTimer:self.observer forMode:NSRunLoopCommonModes];
}
- (void)applicationStateChanged:(NSNotification *)note {
    if ([note.name isEqual:UIApplicationWillResignActiveNotification] || [note.name isEqual:UIApplicationDidEnterBackgroundNotification]) {
        [self.observer invalidate]; self.observer = nil; return;
    }
    [self observePresentation];
    [self refreshObservation];
}
- (void)observePresentation {
    if (self.finished || UIApplication.sharedApplication.applicationState != UIApplicationStateActive) return;
    UIViewController *source = self.source;
    UINavigationController *navigation = source.navigationController;
    if (!source || source.isBeingDismissed || navigation.isBeingDismissed ||
        (navigation && ![navigation.viewControllers containsObject:source]) ||
        (!navigation && source.isViewLoaded && !source.view.window)) {
        [self finish]; return;
    }
    UIViewController *top = navigation.topViewController ?: source;
    while (top.presentedViewController) top = top.presentedViewController;
    if ([top isKindOfClass:UINavigationController.class]) top = ((UINavigationController *)top).topViewController;
    Class payer = NSClassFromString(@"WCPayQRCodeRewardPayerDetailViewController");
    if (payer && [top isKindOfClass:payer] && top.isViewLoaded && top.view.window) {
        if (!self.observedPaymentPage) {
            self.observedPaymentPage = YES;
            [self.openingDeadline invalidate]; self.openingDeadline = nil;
            [self unlockSettings];
            [self.route paymentPageDidAppear];
            [self refreshObservation];
        }
    } else if (self.observedPaymentPage && [self sourceIsCurrent] && !navigation.transitionCoordinator) {
        // Also release after a native back gesture if this WeChat version omits End.
        [self finish]; return;
    }
    if (!self.observedPaymentPage && self.route.state == CSNativeRewardOpening &&
        NSProcessInfo.processInfo.systemUptime - self.beganAt >= 12) {
        [self finish];
        [self showFailure:@"请检查网络后重试。"];
    }
}
- (void)unlockSettings {
    if (!self.lockedSettings) return;
    self.source.view.userInteractionEnabled = self.priorInteractionEnabled;
    self.lockedSettings = NO;
}
- (void)finish {
    if (self.finished) return;
    self.finished = YES;
    [self.observer invalidate]; self.observer = nil;
    [self.openingDeadline invalidate]; self.openingDeadline = nil;
    [NSNotificationCenter.defaultCenter removeObserver:self];
    [self.route cancel];
    [self unlockSettings];
    UIViewController *source = self.source;
    if ([source respondsToSelector:NSSelectorFromString(@"stopLoading")]) {
        ((void (*)(id, SEL))objc_msgSend)(source, NSSelectorFromString(@"stopLoading"));
    }
    // A delayed callback from an older session must not remove a newer request.
    if (source && objc_getAssociatedObject(source, &CSRewardSessionKey) == self) {
        objc_setAssociatedObject(source, &CSRewardSessionKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
- (void)dealloc { [NSNotificationCenter.defaultCenter removeObserver:self]; [self.observer invalidate]; [self.openingDeadline invalidate]; [self.route cancel]; }
@end

void CSNativeRewardSourceDidAppear(UIViewController *source) {
    CSNativeRewardSession *session = objc_getAssociatedObject(source, &CSRewardSessionKey);
    [session observePresentation];
}

void CSOpenNativeAuthorReward(UIViewController *source) {
    source = CSNativeSettingsHostForContent(source);
    if (!NSThread.isMainThread || !source.view.window || source.presentedViewController || source.isBeingDismissed) return;
    if (source.navigationController && (source.navigationController.topViewController != source || source.navigationController.isBeingDismissed)) return;
    if (objc_getAssociatedObject(source, &CSRewardSessionKey)) return;
    CSNativeRewardSession *session = [CSNativeRewardSession new];
    session.source = source;
    objc_setAssociatedObject(source, &CSRewardSessionKey, session, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [session start];
}
