#import "CSInputTextGesture.h"
#import "CSInputTextGestureEditing.h"
#import "CSInputTextGesturePolicy.h"
#import "CSPreferenceRefresh.h"
#import <UIKit/UIGestureRecognizerSubclass.h>
#import <objc/message.h>
#import <objc/runtime.h>
#import <string.h>

static char CSInputGestureBindingKey, CSInputGestureVisibleKey;
static NSHashTable<UIViewController *> *CSInputGestureChats;
static BOOL CSInputGestureEnabled;
static CSInputTextGestureAction CSInputGestureLeft, CSInputGestureRight;
static atomic_bool CSInputGestureRefreshPending;

static id CSInputGestureObject(id object, SEL selector) {
    NSMethodSignature *signature = [object methodSignatureForSelector:selector];
    if (!signature || signature.numberOfArguments != 2 || signature.methodReturnType[0] != '@') return nil;
    return ((id (*)(id, SEL))objc_msgSend)(object, selector);
}
static BOOL CSInputGestureFlag(id object, NSString *name) {
    SEL selector = NSSelectorFromString(name);
    NSMethodSignature *signature = [object methodSignatureForSelector:selector];
    if (!signature || signature.numberOfArguments != 2 ||
        (strcmp(signature.methodReturnType, @encode(BOOL)) && strcmp(signature.methodReturnType, "c"))) return NO;
    return ((BOOL (*)(id, SEL))objc_msgSend)(object, selector);
}
static UIViewController *CSInputGestureOwner(UIView *view) {
    Class chat = NSClassFromString(@"BaseMsgContentViewController");
    for (UIResponder *responder = view.nextResponder; responder; responder = responder.nextResponder) {
        if (chat && [responder isKindOfClass:chat]) return (id)responder;
        if ([responder isKindOfClass:UIViewController.class]) return nil;
    }
    return nil;
}
static BOOL CSInputGestureViewVisible(UIView *view) {
    if (!view.window || CGRectIsEmpty(view.bounds)) return NO;
    for (UIView *parent = view; parent; parent = parent.superview)
        if (parent.hidden || parent.alpha < .01 || !parent.userInteractionEnabled) return NO;
    return YES;
}
static BOOL CSInputGestureCanRecoverVisibility(UIViewController *controller) {
    // A late startup may miss will/didAppear. Recover only an unobserved, actually
    // visible chat; an explicit disappearance must never be undone by layout.
    UIView *view = controller.viewIfLoaded;
    UIWindow *window = view.window;
    if (objc_getAssociatedObject(controller, &CSInputGestureVisibleKey) ||
        !window.isKeyWindow || !CSInputGestureViewVisible(view) ||
        UIApplication.sharedApplication.applicationState != UIApplicationStateActive ||
        (window.windowScene && window.windowScene.activationState != UISceneActivationStateForegroundActive) ||
        controller.isBeingDismissed || controller.isBeingPresented || controller.presentedViewController ||
        controller.transitionCoordinator || controller.navigationController.transitionCoordinator) return NO;
    return !controller.navigationController || controller.navigationController.visibleViewController == controller;
}
static id CSInputGestureTool(UIViewController *controller) {
    id tool = CSInputGestureObject(controller, NSSelectorFromString(@"toolView"));
    if (!tool) tool = CSInputGestureObject(controller, NSSelectorFromString(@"getInputToolView"));
    Class toolClass = NSClassFromString(@"MMInputToolView");
    return toolClass && [tool isKindOfClass:toolClass] ? tool : nil;
}
static UIView *CSInputGestureGrow(id tool) {
    id grow = CSInputGestureObject(tool, @selector(textView));
    if (!grow) grow = CSInputGestureObject(tool, NSSelectorFromString(@"getGrowTextView"));
    Class growClass = NSClassFromString(@"MMGrowTextView");
    return growClass && [grow isKindOfClass:growClass] ? grow : nil;
}
static UITextView *CSInputGestureEditor(UIView *grow) {
    id editor = CSInputGestureObject(grow, @selector(textView));
    return [editor isKindOfClass:UITextView.class] ? editor : nil;
}

@interface CSInputTextSwipeRecognizer : UIGestureRecognizer
@property(nonatomic, weak) UITouch *trackedTouch;
@property(nonatomic) CGPoint origin;
@property(nonatomic) NSTimeInterval beganAt;
@property(nonatomic) NSInteger direction;
@property(nonatomic) BOOL leftEnabled, rightEnabled;
@end
@implementation CSInputTextSwipeRecognizer
- (instancetype)initWithTarget:(id)target action:(SEL)action {
    if ((self = [super initWithTarget:target action:action])) {
        self.cancelsTouchesInView = YES;
        self.delaysTouchesBegan = NO;
        self.delaysTouchesEnded = NO;
        self.allowedTouchTypes = @[@(UITouchTypeDirect)];
    }
    return self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.trackedTouch || touches.count != 1 || event.allTouches.count != 1) {
        self.state = UIGestureRecognizerStateFailed; return;
    }
    self.trackedTouch = touches.anyObject;
    self.origin = [self.trackedTouch locationInView:self.view];
    self.beganAt = self.trackedTouch.timestamp;
}
- (CSInputTextSwipeDecision)decisionForTouch:(UITouch *)touch {
    CGPoint point = [touch locationInView:self.view];
    CGFloat dx = point.x - self.origin.x;
    if (fabs(dx) >= 14 && ((dx < 0 && !self.leftEnabled) || (dx > 0 && !self.rightEnabled)))
        return CSInputTextSwipeRejected;
    return CSInputTextDecideSwipe(dx, point.y - self.origin.y, touch.timestamp - self.beganAt);
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.state != UIGestureRecognizerStatePossible) return;
    if (!self.trackedTouch || event.allTouches.count != 1 ||
        [self decisionForTouch:self.trackedTouch] == CSInputTextSwipeRejected) {
        self.state = UIGestureRecognizerStateFailed;
    }
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.state != UIGestureRecognizerStatePossible) return;
    CSInputTextSwipeDecision decision = self.trackedTouch && event.allTouches.count == 1
        ? [self decisionForTouch:self.trackedTouch] : CSInputTextSwipeRejected;
    if (decision == CSInputTextSwipeLeft || decision == CSInputTextSwipeRight) {
        self.direction = decision == CSInputTextSwipeLeft ? -1 : 1;
        self.state = UIGestureRecognizerStateRecognized;
    } else {
        self.state = UIGestureRecognizerStateFailed;
    }
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.state == UIGestureRecognizerStatePossible) {
        self.state = UIGestureRecognizerStateFailed;
    }
}
- (void)reset {
    [super reset]; self.trackedTouch = nil; self.direction = 0;
}
@end

@interface CSInputTextGestureBinding : NSObject <UIGestureRecognizerDelegate>
@property(nonatomic, weak) UIViewController *controller;
@property(nonatomic, weak) UIView *tool, *grow;
@property(nonatomic, weak) UITextView *strokeEditor;
@property(nonatomic, strong) CSInputTextSwipeRecognizer *recognizer;
- (BOOL)readyToEdit;
- (BOOL)prioritizesNativeRecognizer:(UIGestureRecognizer *)native;
- (void)cancelPendingStroke;
- (void)refresh;
@end
@implementation CSInputTextGestureBinding
- (BOOL)readyToEdit {
    UIViewController *controller = self.controller;
    UIWindow *window = self.grow.window;
    if (!CSInputGestureEnabled) return NO;
    if (![objc_getAssociatedObject(controller, &CSInputGestureVisibleKey) boolValue]) return NO;
    if (UIApplication.sharedApplication.applicationState != UIApplicationStateActive) return NO;
    if (!window.isKeyWindow) return NO;
    if (window.windowScene && window.windowScene.activationState != UISceneActivationStateForegroundActive)
        return NO;
    if (controller.isBeingDismissed || controller.isBeingPresented || controller.presentedViewController ||
        controller.transitionCoordinator || controller.navigationController.transitionCoordinator)
        return NO;
    if (controller.navigationController && controller.navigationController.visibleViewController != controller)
        return NO;
    if (CSInputGestureTool(controller) != self.tool || CSInputGestureGrow(self.tool) != self.grow)
        return NO;
    if (![self.grow isDescendantOfView:controller.viewIfLoaded] || !CSInputGestureViewVisible(self.grow))
        return NO;
    UITextView *editor = CSInputGestureEditor(self.grow);
    if (!editor || !editor.editable || !editor.selectable || editor.markedTextRange) return NO;
    if (!CSInputGestureViewVisible(editor)) return NO;
    if (CSInputGestureFlag(self.grow, @"isDictationWorking") || CSInputGestureFlag(self.grow, @"dictationRunning") ||
        CSInputGestureFlag(self.grow, @"lockedForWaitEndFlag")) return NO;
    return YES;
}
- (void)cancelPendingStroke {
    if (self.recognizer.enabled) self.recognizer.enabled = NO;
}
- (void)refresh {
    UIView *tool = CSInputGestureTool(self.controller);
    UIView *grow = CSInputGestureGrow(tool);
    if (grow != self.grow) {
        [self cancelPendingStroke];
        [self.grow removeGestureRecognizer:self.recognizer];
        self.recognizer = nil;
        self.grow = grow;
    }
    self.tool = tool;
    BOOL configured = CSInputGestureEnabled && (CSInputGestureLeft || CSInputGestureRight);
    if (!self.recognizer && grow && configured) {
        self.recognizer = [[CSInputTextSwipeRecognizer alloc] initWithTarget:self action:@selector(perform:)];
        self.recognizer.delegate = self;
        [grow addGestureRecognizer:self.recognizer];
    }
    BOOL changed = self.recognizer.leftEnabled != (CSInputGestureLeft != 0) ||
        self.recognizer.rightEnabled != (CSInputGestureRight != 0);
    // Cancel a pending stroke when its configuration changes.
    if (changed) [self cancelPendingStroke];
    self.recognizer.leftEnabled = CSInputGestureLeft != 0;
    self.recognizer.rightEnabled = CSInputGestureRight != 0;
    // Temporary transition state is checked when receiving/executing a stroke.
    // Keeping it out of enabled avoids a missed final transition callback leaving
    // the binding disabled after the native viewDidAppear returns.
    BOOL enabled = configured && [objc_getAssociatedObject(self.controller, &CSInputGestureVisibleKey) boolValue];
    if (!enabled) [self cancelPendingStroke];
    else if (!self.recognizer.enabled) self.recognizer.enabled = YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)recognizer shouldReceiveTouch:(UITouch *)touch {
    if (![self readyToEdit] || ![touch.view isDescendantOfView:self.grow]) return NO;
    self.strokeEditor = CSInputGestureEditor(self.grow);
    CGPoint point = [touch locationInView:self.grow.window];
    // Leave screen-edge navigation gestures their usual priority.
    return point.x >= 24 && point.x <= self.grow.window.bounds.size.width - 24;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)recognizer {
    return [self readyToEdit] && self.strokeEditor == CSInputGestureEditor(self.grow);
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)recognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)other {
    return CSInputTextGesturePrioritizesRecognizer(recognizer, other);
}
- (BOOL)prioritizesNativeRecognizer:(UIGestureRecognizer *)native {
    if (!self.recognizer.enabled || ![self readyToEdit] ||
        ![native isKindOfClass:UIPanGestureRecognizer.class] ||
        [native isKindOfClass:UIScreenEdgePanGestureRecognizer.class]) return NO;
    UINavigationController *navigation = self.controller.navigationController;
    if (native == navigation.interactivePopGestureRecognizer ||
        native == CSInputGestureObject(navigation, NSSelectorFromString(@"interactiveContentPopGestureRecognizer"))) return NO;
    UIView *view = native.view;
    if (!view || view.window != self.grow.window) return NO;
    // Chat-level pans also receive touches that start in the input. Keep the
    // dependency inside this chat; navigation and unrelated views retain theirs.
    return [view isDescendantOfView:self.grow] ||
        ([self.grow isDescendantOfView:view] && [view isDescendantOfView:self.controller.viewIfLoaded]);
}
- (void)perform:(CSInputTextSwipeRecognizer *)recognizer {
    if (recognizer.state != UIGestureRecognizerStateRecognized) return;
    if (![self readyToEdit] || self.strokeEditor != CSInputGestureEditor(self.grow)) return;
    CSInputTextGestureAction action = recognizer.direction < 0 ? CSInputGestureLeft : CSInputGestureRight;
    CSInputTextGesturePerformAction(action, (id)CSInputGestureEditor(self.grow), (id)self.tool);
}
@end

BOOL CSInputTextGesturePrioritizesRecognizer(UIGestureRecognizer *input, UIGestureRecognizer *native) {
    if (![input isKindOfClass:CSInputTextSwipeRecognizer.class] ||
        ![input.delegate isKindOfClass:CSInputTextGestureBinding.class]) return NO;
    CSInputTextGestureBinding *binding = (id)input.delegate;
    return binding.recognizer == input && [binding prioritizesNativeRecognizer:native];
}

static void CSInputGestureTrackChat(UIViewController *controller) {
    if (!CSInputGestureChats) CSInputGestureChats = [NSHashTable weakObjectsHashTable];
    [CSInputGestureChats addObject:controller];
}
void CSInputTextGestureChatVisibility(UIViewController *controller, BOOL visible) {
    if (!controller || !NSThread.isMainThread) return;
    objc_setAssociatedObject(controller, &CSInputGestureVisibleKey, @(visible), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    CSInputGestureTrackChat(controller);
    CSInputTextGestureBinding *binding = objc_getAssociatedObject(controller, &CSInputGestureBindingKey);
    if (!binding && visible && CSInputGestureEnabled) {
        binding = [CSInputTextGestureBinding new]; binding.controller = controller;
        objc_setAssociatedObject(controller, &CSInputGestureBindingKey, binding, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [binding refresh];
}
static void CSInputGestureRefreshFromInput(UIViewController *owner) {
    // Keep only a weak pending reference so foreground/config refresh can retry
    // an input observed before its window or scene became ready.
    CSInputGestureTrackChat(owner);
    NSNumber *visible = objc_getAssociatedObject(owner, &CSInputGestureVisibleKey);
    if (!visible && !CSInputGestureCanRecoverVisibility(owner)) {
        // Do not turn an early, unattached layout into an explicit disappearance.
        return;
    }
    CSInputTextGestureChatVisibility(owner, visible ? visible.boolValue : YES);
}
void CSInputTextGestureApplyTool(UIView *tool) {
    if (!NSThread.isMainThread) return;
    UIViewController *owner = CSInputGestureOwner(tool);
    if (!owner || CSInputGestureTool(owner) != tool) return;
    CSInputGestureRefreshFromInput(owner);
}
void CSInputTextGestureApplyGrow(UIView *grow) {
    if (!NSThread.isMainThread) return;
    UIViewController *owner = CSInputGestureOwner(grow);
    UIView *tool = CSInputGestureTool(owner);
    if (!owner || CSInputGestureGrow(tool) != grow) return;
    CSInputGestureRefreshFromInput(owner);
}
void CSInputTextGestureChatDidLayout(UIViewController *controller) {
    if (!controller || !NSThread.isMainThread) return;
    CSInputGestureRefreshFromInput(controller);
}
void CSInputTextGesturePreferencesChanged(void) {
    CSRequestMainRefresh(&CSInputGestureRefreshPending, ^{
        BOOL enabled = [CSInputTextGesturePreferences enabled];
        CSInputTextGestureAction left = [CSInputTextGesturePreferences actionForKey:CSInputTextGestureLeftActionKey];
        CSInputTextGestureAction right = [CSInputTextGesturePreferences actionForKey:CSInputTextGestureRightActionKey];
        BOOL changed = enabled != CSInputGestureEnabled || left != CSInputGestureLeft || right != CSInputGestureRight;
        CSInputGestureEnabled = enabled; CSInputGestureLeft = left; CSInputGestureRight = right;
        for (UIViewController *controller in CSInputGestureChats.allObjects) {
            CSInputTextGestureBinding *binding = objc_getAssociatedObject(controller, &CSInputGestureBindingKey);
            if (changed) [binding cancelPendingStroke];
            CSInputGestureRefreshFromInput(controller);
        }
    });
}
static void CSInputGestureDarwinChanged(CFNotificationCenterRef center, void *observer, CFStringRef name,
                                      const void *object, CFDictionaryRef info) {
    CSInputTextGesturePreferencesChanged();
}
void CSInputTextGestureInstall(void) {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        CSInputGestureEnabled = [CSInputTextGesturePreferences enabled];
        CSInputGestureLeft = [CSInputTextGesturePreferences actionForKey:CSInputTextGestureLeftActionKey];
        CSInputGestureRight = [CSInputTextGesturePreferences actionForKey:CSInputTextGestureRightActionKey];
        for (NSString *name in @[CSInputTextGesturePreferencesDidChangeNotification, NSUserDefaultsDidChangeNotification,
              @"com.wechat.tweak.local_settings_changed", UIApplicationDidBecomeActiveNotification]) {
            [NSNotificationCenter.defaultCenter addObserverForName:name object:nil queue:nil usingBlock:^(NSNotification *note) {
                CSInputTextGesturePreferencesChanged();
            }];
        }
        [NSNotificationCenter.defaultCenter addObserverForName:UIApplicationWillResignActiveNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
            for (UIViewController *controller in CSInputGestureChats.allObjects) {
                CSInputTextGestureBinding *binding = objc_getAssociatedObject(controller, &CSInputGestureBindingKey);
                [binding cancelPendingStroke];
            }
        }];
        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, CSInputGestureDarwinChanged,
            CFSTR("com.wechat.enhance.settings_changed"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    });
}
