#import <UIKit/UIKit.h>
#import "CSInputTextGesture.h"
#import "CSInputTextGesturePreferences.h"
#import "CSInputTextStyle.h"
#import <objc/runtime.h>

static NSUInteger checks, failures;
static void Check(BOOL value, NSString *message) {
    checks++;
    if (!value) { failures++; fprintf(stderr, "FAIL: %s\n", message.UTF8String); }
}
static void Pump(void) { [NSRunLoop.mainRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.025]]; }

// All preference writes stay in this dictionary; no persistent defaults domain is used.
@interface InputRuntimeDefaults : NSUserDefaults
@property(nonatomic, strong) NSMutableDictionary *values;
@end
@implementation InputRuntimeDefaults
- (instancetype)init { if ((self = [super init])) _values = [NSMutableDictionary dictionary]; return self; }
- (id)objectForKey:(NSString *)key { return self.values[key]; }
- (void)setObject:(id)value forKey:(NSString *)key { self.values[key] = value; }
@end
static InputRuntimeDefaults *memoryDefaults;
static NSUserDefaults *RuntimeDefaults(id object, SEL selector) { return memoryDefaults; }

@interface MMGrowTextView : UIView
@property(nonatomic, strong) UITextView *textView;
@property(nonatomic, copy) NSString *placeHolder;
@property(nonatomic, copy) NSAttributedString *attributePlaceholder;
@property(nonatomic) BOOL dictationRunning, lockedForWaitEndFlag, isDictationWorking;
@end
@implementation MMGrowTextView @end
@interface MMInputToolView : UIView
@property(nonatomic, strong) MMGrowTextView *textView;
@property(nonatomic) NSUInteger sends;
- (void)onTapSendButton;
@end
@implementation MMInputToolView
- (void)onTapSendButton { self.sends++; }
@end
@interface BaseMsgContentViewController : UIViewController
@property(nonatomic, strong) MMInputToolView *nativeTool;
- (id)getInputToolView;
@end
@implementation BaseMsgContentViewController
- (id)getInputToolView { return self.nativeTool; }
@end

@interface RuntimeFixture : NSObject
@property(nonatomic, strong) UIWindow *window;
@property(nonatomic, strong) BaseMsgContentViewController *chat;
@property(nonatomic, strong) MMInputToolView *tool;
@property(nonatomic, strong) MMGrowTextView *grow;
@property(nonatomic, strong) UITextView *editor;
@end
@implementation RuntimeFixture
- (instancetype)init {
    if ((self = [super init])) {
        _window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 390, 800)];
        _window.isKeyWindow = YES;
        _window.windowScene = [UIWindowScene new];
        _window.windowScene.activationState = UISceneActivationStateForegroundActive;
        _chat = [BaseMsgContentViewController new];
        _chat.view = [[UIView alloc] initWithFrame:_window.bounds];
        _chat.view.testOwner = _chat;
        [_window addSubview:_chat.view];
        _tool = [[MMInputToolView alloc] initWithFrame:CGRectMake(0, 650, 390, 60)];
        _chat.nativeTool = _tool;
        [_chat.view addSubview:_tool];
        _grow = [[MMGrowTextView alloc] initWithFrame:CGRectMake(40, 0, 280, 50)];
        _tool.textView = _grow;
        [_tool addSubview:_grow];
        _editor = [[UITextView alloc] initWithFrame:_grow.bounds];
        _grow.textView = _editor;
        [_grow addSubview:_editor];
    }
    return self;
}
@end
static UIGestureRecognizer *Recognizer(RuntimeFixture *fixture) { return fixture.grow.gestureRecognizers.firstObject; }
static UITouch *Touch(UIView *view, CGPoint point, NSTimeInterval time) {
    UITouch *touch = [UITouch new]; touch.testView = view; touch.testLocation = point; touch.timestamp = time; return touch;
}
static BOOL Receive(UIGestureRecognizer *recognizer, UITouch *touch) {
    return recognizer.enabled && [recognizer.delegate gestureRecognizer:recognizer shouldReceiveTouch:touch];
}
static UITouch *Begin(RuntimeFixture *fixture) {
    UIGestureRecognizer *recognizer = Recognizer(fixture);
    [recognizer reset];
    UITouch *touch = Touch(fixture.editor, CGPointMake(150, 20), 10);
    if (!Receive(recognizer, touch)) return nil;
    UIEvent *event = [UIEvent new]; event.allTouches = [NSSet setWithObject:touch];
    [recognizer touchesBegan:event.allTouches withEvent:event];
    return touch;
}
static void Finish(RuntimeFixture *fixture, UITouch *touch, CGFloat dx, CGFloat dy, BOOL endTwice) {
    if (!touch) return;
    UIGestureRecognizer *recognizer = Recognizer(fixture);
    UIEvent *event = [UIEvent new]; event.allTouches = [NSSet setWithObject:touch];
    touch.testLocation = CGPointMake(150 + dx, 20 + dy); touch.timestamp = 10.2;
    [recognizer touchesMoved:event.allTouches withEvent:event];
    [recognizer touchesEnded:event.allTouches withEvent:event];
    if (endTwice) [recognizer touchesEnded:event.allTouches withEvent:event];
}
static void Swipe(RuntimeFixture *fixture, CGFloat dx, CGFloat dy) { Finish(fixture, Begin(fixture), dx, dy, NO); }
static void Configure(BOOL enabled, CSInputTextGestureAction left, CSInputTextGestureAction right) {
    [CSInputTextGesturePreferences setEnabled:enabled];
    [CSInputTextGesturePreferences setAction:left forKey:CSInputTextGestureLeftActionKey];
    [CSInputTextGesturePreferences setAction:right forKey:CSInputTextGestureRightActionKey];
    Pump();
}

static void TestDelayedInstallAndGrowEntry(void) {
    Configure(YES, CSInputTextGestureActionClear, CSInputTextGestureActionSend);
    RuntimeFixture *fixture = [RuntimeFixture new];
    CSInputTextGestureInstall();
    // The chat is already on screen when the module installs. No appearance
    // callback is injected: the observed grow layout must discover it.
    CSInputTextGestureApplyGrow(fixture.grow);
    UIGestureRecognizer *recognizer = Recognizer(fixture);
    Check(recognizer.enabled && fixture.grow.gestureRecognizers.count == 1,
          @"a grow callback binds a visible chat after delayed install without didAppear");
    Swipe(fixture, -90, 0);
    Check(fixture.editor.testDeletes == 1 && !fixture.editor.text.length,
          @"the grow-discovered input executes its configured clear action");
    for (NSUInteger index = 0; index < 3; index++) {
        CSInputTextGestureApplyGrow(fixture.grow);
        CSInputTextGestureApplyTool(fixture.tool);
    }
    Check(Recognizer(fixture) == recognizer && fixture.grow.gestureRecognizers.count == 1,
          @"repeated grow and toolbar callbacks reuse one input binding");
    CSInputTextGestureChatVisibility(fixture.chat, NO);
    CSInputTextGestureApplyGrow(fixture.grow);
    CSInputTextGestureApplyTool(fixture.tool);
    fixture.editor.text = @"draft after leaving";
    Swipe(fixture, 90, 0);
    Check(!recognizer.enabled && fixture.tool.sends == 0,
          @"grow and toolbar layouts cannot reactivate a chat explicitly marked as left");
    Configure(NO, CSInputTextGestureActionDisabled, CSInputTextGestureActionDisabled);
}

static void TestLifecycle(void) {
    RuntimeFixture *fixture = [RuntimeFixture new];
    CSInputTextGestureChatVisibility(fixture.chat, YES);
    CSInputTextGestureApplyTool(fixture.tool);
    Check(fixture.grow.gestureRecognizers.count == 0, @"default configuration attaches no recognizer");
    Configure(YES, CSInputTextGestureActionSend, CSInputTextGestureActionSend);
    UIGestureRecognizer *recognizer = Recognizer(fixture);
    Check(recognizer.enabled && fixture.grow.gestureRecognizers.count == 1, @"enabling binds one recognizer to the current input");
    for (NSUInteger index = 0; index < 5; index++) {
        CSInputTextGestureApplyTool(fixture.tool);
        CSInputTextGestureChatDidLayout(fixture.chat);
    }
    Check(Recognizer(fixture) == recognizer && fixture.grow.gestureRecognizers.count == 1, @"repeated native layout reuses its existing recognizer");
    CSInputTextGestureChatVisibility(fixture.chat, NO);
    Check(!recognizer.enabled, @"leaving the chat disables its recognizer");
    CSInputTextGestureChatVisibility(fixture.chat, YES);
    Check(recognizer.enabled, @"returning to the chat enables its existing recognizer");
    UIApplication.sharedApplication.applicationState = UIApplicationStateInactive;
    [NSNotificationCenter.defaultCenter postNotificationName:UIApplicationWillResignActiveNotification object:nil];
    Check(!recognizer.enabled, @"background transition cancels the recognizer");
    UIApplication.sharedApplication.applicationState = UIApplicationStateActive;
    [NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidBecomeActiveNotification object:nil];
    Pump();
    Check(recognizer.enabled, @"foreground notification restores the visible input");
    fixture.chat.transitionCoordinator = [NSObject new];
    CSInputTextGestureChatDidLayout(fixture.chat);
    Check(recognizer.enabled && !Begin(fixture), @"a transition temporarily rejects touches without latching disabled state");
    fixture.chat.transitionCoordinator = nil;
    Swipe(fixture, -80, 0);
    Check(fixture.tool.sends == 1, @"a finished transition accepts the next swipe without another layout callback");
    fixture.chat.presentedViewController = [UIViewController new];
    Check(!Begin(fixture), @"an overlaid modal prevents edits to the chat underneath");
    fixture.chat.presentedViewController = nil;
    fixture.window.isKeyWindow = NO;
    Check(!Begin(fixture), @"an inactive window rejects the gesture");
    fixture.window.isKeyWindow = YES;

    MMGrowTextView *oldGrow = fixture.grow;
    MMGrowTextView *replacement = [[MMGrowTextView alloc] initWithFrame:oldGrow.frame];
    replacement.textView = fixture.editor;
    [replacement addSubview:fixture.editor];
    fixture.tool.textView = replacement;
    [fixture.tool addSubview:replacement];
    fixture.grow = replacement;
    CSInputTextGestureApplyTool(fixture.tool);
    Check(oldGrow.gestureRecognizers.count == 0 && replacement.gestureRecognizers.count == 1,
          @"replacing the grow view detaches the old recognizer and binds the new input");
    MMInputToolView *oldTool = fixture.tool;
    MMGrowTextView *previousGrow = fixture.grow;
    fixture.tool = [[MMInputToolView alloc] initWithFrame:oldTool.frame];
    fixture.grow = [[MMGrowTextView alloc] initWithFrame:previousGrow.frame];
    fixture.grow.textView = fixture.editor;
    [fixture.grow addSubview:fixture.editor];
    fixture.tool.textView = fixture.grow;
    [fixture.tool addSubview:fixture.grow];
    fixture.chat.nativeTool = fixture.tool;
    [fixture.chat.view addSubview:fixture.tool];
    CSInputTextGestureApplyTool(fixture.tool);
    Check(previousGrow.gestureRecognizers.count == 0 && Recognizer(fixture).enabled,
          @"replacing the native toolbar releases the previous input binding");
    Swipe(fixture, 80, 0);
    Check(fixture.tool.sends == 1 && oldTool.sends == 1, @"sending follows the replacement toolbar only");
    CSInputTextGestureChatVisibility(fixture.chat, NO);
}

static void TestRecognitionAndScope(void) {
    RuntimeFixture *fixture = [RuntimeFixture new];
    CSInputTextGestureChatVisibility(fixture.chat, YES);
    UIGestureRecognizer *recognizer = Recognizer(fixture);
    UITouch *touch = Begin(fixture);
    UIEvent *event = [UIEvent new]; event.allTouches = [NSSet setWithObject:touch];
    touch.testLocation = CGPointMake(60, 20); touch.timestamp = 10.15;
    [recognizer touchesMoved:event.allTouches withEvent:event];
    Check(fixture.tool.sends == 0, @"crossing the distance threshold does not send before lift off");
    Finish(fixture, touch, -90, 0, YES);
    Check(fixture.tool.sends == 1, @"a valid horizontal stroke sends once even if end is repeated");
    Swipe(fixture, 15, 0); Check(fixture.tool.sends == 1, @"a short stroke does nothing");
    Swipe(fixture, 5, 45); Check(fixture.tool.sends == 1, @"vertical scrolling does nothing");
    fixture.editor.markedTextRange = [NSObject new];
    Check(!Begin(fixture), @"composition rejects the initial touch");
    fixture.editor.markedTextRange = nil;
    touch = Begin(fixture); fixture.editor.markedTextRange = [NSObject new];
    Finish(fixture, touch, -90, 0, NO);
    Check(fixture.tool.sends == 1, @"composition starting mid-stroke prevents the action");
    fixture.editor.markedTextRange = nil;
    fixture.grow.dictationRunning = YES; Check(!Begin(fixture), @"active dictation rejects the touch");
    fixture.grow.dictationRunning = NO;
    fixture.grow.lockedForWaitEndFlag = YES; Check(!Begin(fixture), @"pending dictation completion rejects the touch");
    fixture.grow.lockedForWaitEndFlag = NO;
    touch = Begin(fixture);
    UITextView *replacement = [[UITextView alloc] initWithFrame:fixture.editor.frame];
    [fixture.grow addSubview:replacement]; fixture.grow.textView = replacement;
    Finish(fixture, touch, -90, 0, NO);
    Check(fixture.tool.sends == 1, @"rebuilding the inner editor during a stroke cancels its action");
    fixture.editor = replacement;
    UITouch *outside = Touch(fixture.chat.view, CGPointMake(120, 120), 20);
    Check(!Receive(recognizer, outside), @"touches outside the input subtree are ignored");
    UITouch *edge = Touch(fixture.editor, CGPointMake(-30, 20), 20);
    Check(!Receive(recognizer, edge), @"screen-edge navigation has priority");
    touch = Begin(fixture);
    UITouch *second = Touch(fixture.editor, CGPointMake(120, 20), 10.05);
    event.allTouches = [NSSet setWithObjects:touch, second, nil];
    [recognizer touchesBegan:[NSSet setWithObject:second] withEvent:event];
    Finish(fixture, touch, -90, 0, NO);
    Check(fixture.tool.sends == 1, @"a second finger rejects the pending stroke");
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:nil action:NULL];
    [fixture.editor addGestureRecognizer:pan];
    Check([recognizer.delegate gestureRecognizer:recognizer shouldBeRequiredToFailByGestureRecognizer:pan],
          @"an input pan waits for the custom swipe's failure decision");
    UILongPressGestureRecognizer *press = [[UILongPressGestureRecognizer alloc] initWithTarget:nil action:NULL];
    [fixture.editor addGestureRecognizer:press];
    Check(![recognizer.delegate gestureRecognizer:recognizer shouldBeRequiredToFailByGestureRecognizer:press],
          @"native long-press selection is not made to wait");
    UIScreenEdgePanGestureRecognizer *edgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:nil action:NULL];
    [fixture.editor addGestureRecognizer:edgePan];
    Check(![recognizer.delegate gestureRecognizer:recognizer shouldBeRequiredToFailByGestureRecognizer:edgePan],
          @"edge navigation pans are excluded from the failure requirement");
    [fixture.chat.view addGestureRecognizer:pan];
    Check([recognizer.delegate gestureRecognizer:recognizer shouldBeRequiredToFailByGestureRecognizer:pan],
          @"the chat-root ancestor pan waits for the custom swipe");
    Configure(YES, CSInputTextGestureActionDisabled, CSInputTextGestureActionSend);
    touch = Begin(fixture); event.allTouches = [NSSet setWithObject:touch];
    touch.testLocation = CGPointMake(130, 20); touch.timestamp = 10.05;
    [recognizer touchesMoved:event.allTouches withEvent:event];
    Check(recognizer.state == UIGestureRecognizerStateFailed, @"a disabled direction fails early for native text gestures");
    Swipe(fixture, 90, 0);
    Check(fixture.tool.sends == 2, @"the independently enabled direction still sends");
    touch = Begin(fixture);
    Configure(NO, CSInputTextGestureActionDisabled, CSInputTextGestureActionSend);
    Finish(fixture, touch, 90, 0, NO);
    Check(!recognizer.enabled && fixture.tool.sends == 2, @"disabling the feature during a stroke prevents sending");
    CSInputTextGestureChatVisibility(fixture.chat, NO);
}


// Model a conditional native Base YES branch seen in the inspected 8.0.80
// binary. Either recognizer's YES establishes an edge; a delegate NO cannot
// cancel the opposite edge. This directed model exercises only those two edges.
@interface InputNativeBasePan : UIPanGestureRecognizer
- (BOOL)shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)other;
@end
@implementation InputNativeBasePan
- (BOOL)shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)other { return YES; }
@end
static BOOL Prioritizes(UIGestureRecognizer *custom, UIGestureRecognizer *native) {
    return CSInputTextGesturePrioritizesRecognizer(custom, native);
}
typedef struct { BOOL customWaitsForNative, nativeWaitsForCustom; } FailureEdges;
static FailureEdges Edges(RuntimeFixture *fixture, InputNativeBasePan *native, BOOL originalChain) {
    UIGestureRecognizer *custom = Recognizer(fixture);
    // Simulate the production Base hook boundary, keeping its %orig YES outside
    // our priority scope. No UIKit delegate replacement or global arbiter is used.
    BOOL nativeAnswer = originalChain || !Prioritizes(custom, native)
        ? [native shouldBeRequiredToFailByGestureRecognizer:custom] : NO;
    BOOL customAnswer = originalChain
        ? [native.view isDescendantOfView:fixture.grow]
        : [custom.delegate gestureRecognizer:custom shouldBeRequiredToFailByGestureRecognizer:native];
    return (FailureEdges){ nativeAnswer, customAnswer };
}
static void ArbitrateStroke(RuntimeFixture *fixture, InputNativeBasePan *native,
                            CGFloat dx, CGFloat dy, BOOL originalChain, BOOL endTwice) {
    [native reset];
    UITouch *touch = Begin(fixture);
    UIGestureRecognizer *custom = Recognizer(fixture);
    if (!touch) { native.state = UIGestureRecognizerStateBegan; return; }
    FailureEdges edges = Edges(fixture, native, originalChain);
    if (edges.customWaitsForNative || !edges.nativeWaitsForCustom) {
        // An eager native pan can begin before lift-off; the custom action loses.
        custom.state = UIGestureRecognizerStateFailed;
        native.state = UIGestureRecognizerStateBegan;
        return;
    }
    Finish(fixture, touch, dx, dy, endTwice);
    native.state = custom.state == UIGestureRecognizerStateRecognized
        ? UIGestureRecognizerStateFailed : UIGestureRecognizerStateBegan;
}
static void TestNativeFailurePriority(void) {
    Configure(YES, CSInputTextGestureActionClear, CSInputTextGestureActionSend);
    RuntimeFixture *fixture = [RuntimeFixture new];
    CSInputTextGestureChatVisibility(fixture.chat, YES);
    UIGestureRecognizer *custom = Recognizer(fixture);
    InputNativeBasePan *native = [[InputNativeBasePan alloc] initWithTarget:nil action:NULL];
    [fixture.chat.view addGestureRecognizer:native];
    FailureEdges original = Edges(fixture, native, YES);
    Check(original.customWaitsForNative && !original.nativeWaitsForCustom,
          @"the pre-fix native ancestor establishes custom-to-native dependency");
    ArbitrateStroke(fixture, native, -90, 0, YES, NO);
    Check([fixture.editor.text isEqualToString:@"draft"] && !fixture.editor.testDeletes &&
          native.state == UIGestureRecognizerStateBegan,
          @"the original chain reproduces the swallowed horizontal clear gesture");
    FailureEdges fixed = Edges(fixture, native, NO);
    Check(!fixed.customWaitsForNative && fixed.nativeWaitsForCustom,
          @"the fixed chain removes native's opposite edge and prioritizes the custom swipe");
    ArbitrateStroke(fixture, native, -90, 0, NO, YES);
    Check(!fixture.editor.text.length && fixture.editor.testDeletes == 1 &&
          native.state == UIGestureRecognizerStateFailed,
          @"left clear executes once with the native ancestor pan present");
    fixture.editor.text = @"send this draft";
    ArbitrateStroke(fixture, native, 90, 0, NO, YES);
    Check(fixture.tool.sends == 1 && native.state == UIGestureRecognizerStateFailed,
          @"right send executes once with the native ancestor pan present");
    Configure(YES, CSInputTextGestureActionClear, CSInputTextGestureActionPaste);
    ArbitrateStroke(fixture, native, 90, 0, NO, YES);
    Check(fixture.editor.testPastes == 1 && native.state == UIGestureRecognizerStateFailed,
          @"right paste executes once after changing the configured action");
    ArbitrateStroke(fixture, native, 5, 45, NO, NO);
    Check(native.state == UIGestureRecognizerStateBegan && fixture.editor.testPastes == 1 &&
          fixture.editor.testDeletes == 1, @"vertical input scrolling releases the native pan without an edit");
    Configure(YES, CSInputTextGestureActionDisabled, CSInputTextGestureActionPaste);
    ArbitrateStroke(fixture, native, -90, 0, NO, NO);
    Check(native.state == UIGestureRecognizerStateBegan && fixture.editor.testDeletes == 1,
          @"a disabled direction releases the native pan without clearing");

    Check(Prioritizes(custom, native), @"the own ready recognizer prioritizes a chat-root ancestor pan");
    [fixture.tool addGestureRecognizer:native];
    Check(Prioritizes(custom, native), @"the toolbar ancestor pan is covered");
    [fixture.editor addGestureRecognizer:native];
    Check(Prioritizes(custom, native), @"an editor descendant pan is covered");
    [fixture.window addGestureRecognizer:native];
    Check(!Prioritizes(custom, native), @"ancestors above the owning chat root are excluded");
    UIView *sibling = [[UIView alloc] initWithFrame:fixture.tool.frame];
    [fixture.chat.view addSubview:sibling]; [sibling addGestureRecognizer:native];
    Check(!Prioritizes(custom, native), @"a sibling region's pan is excluded");
    RuntimeFixture *otherPage = [RuntimeFixture new];
    [otherPage.editor addGestureRecognizer:native];
    Check(!Prioritizes(custom, native), @"another page and window's pan is excluded");
    [fixture.editor addGestureRecognizer:native];
    UIGestureRecognizer *unrelated = [[UIGestureRecognizer alloc] initWithTarget:nil action:NULL];
    [fixture.grow addGestureRecognizer:unrelated];
    Check(!Prioritizes(unrelated, native), @"an unrelated custom recognizer never receives our priority");
    UIScreenEdgePanGestureRecognizer *edge = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:nil action:NULL];
    [fixture.editor addGestureRecognizer:edge];
    Check(!Prioritizes(custom, edge), @"screen-edge navigation is excluded");
    UINavigationController *navigation = [UINavigationController new];
    navigation.visibleViewController = fixture.chat; fixture.chat.navigationController = navigation;
    navigation.interactivePopGestureRecognizer = native;
    Check(!Prioritizes(custom, native), @"interactive-pop is excluded even when it is an ordinary UIPan");
    navigation.interactivePopGestureRecognizer = nil;
    Check(Prioritizes(custom, native), @"ordinary input pans retain priority after the pop exclusion");
    fixture.editor.markedTextRange = [NSObject new];
    Check(!Prioritizes(custom, native), @"active composition restores native priority");
    fixture.editor.markedTextRange = nil;
    Configure(NO, CSInputTextGestureActionDisabled, CSInputTextGestureActionPaste);
    Check(!Prioritizes(custom, native), @"a disabled feature restores native priority");
    ArbitrateStroke(fixture, native, 90, 0, NO, NO);
    Check(native.state == UIGestureRecognizerStateBegan && fixture.editor.testPastes == 1,
          @"a disabled feature leaves the native pan usable without another paste");
    CSInputTextGestureChatVisibility(fixture.chat, NO);
}


static void TestAppearanceBridgeAndGrowScope(void) {
    Configure(YES, CSInputTextGestureActionClear, CSInputTextGestureActionSend);
    [memoryDefaults setObject:@YES forKey:@"com.wechat.enhance.inputText.enabled"];
    [memoryDefaults setObject:@"custom placeholder" forKey:@"com.wechat.enhance.inputText.content"];
    CSInputTextStyleInstall(memoryDefaults);
    RuntimeFixture *fixture = [RuntimeFixture new];
    fixture.grow.placeHolder = @"native placeholder";
    // The same exported calls and order used by the shared appearance hooks.
    CSInputTextStyleChatVisibility(fixture.chat, YES);
    CSInputTextGestureChatVisibility(fixture.chat, YES);
    CSInputTextStyleApply(fixture.grow);
    CSInputTextGestureApplyGrow(fixture.grow);
    UIGestureRecognizer *recognizer = Recognizer(fixture);
    Check([fixture.grow.placeHolder isEqualToString:@"custom placeholder"] && recognizer.enabled,
          @"the appearance bridge applies the placeholder and binds the same input swipe");
    Swipe(fixture, -90, 0);
    Check(fixture.editor.testDeletes == 1 && !fixture.editor.text.length,
          @"an input reached through the appearance bridge performs its clear action");
    CSInputTextStyleChatVisibility(fixture.chat, NO);
    CSInputTextGestureChatVisibility(fixture.chat, NO);
    CSInputTextStyleApply(fixture.grow);
    CSInputTextGestureApplyGrow(fixture.grow);
    Check([fixture.grow.placeHolder isEqualToString:@"native placeholder"] && !recognizer.enabled,
          @"the shared disappearance bridge restores appearance and keeps gestures disabled");

    RuntimeFixture *early = [RuntimeFixture new];
    [early.chat.view removeFromSuperview];
    CSInputTextGestureApplyGrow(early.grow);
    Check(!Recognizer(early), @"an early grow callback outside a window waits without binding");
    [early.window addSubview:early.chat.view];
    CSInputTextGestureApplyGrow(early.grow);
    Check(Recognizer(early).enabled,
          @"the early callback does not prevent binding after the input reaches its visible window");
    CSInputTextGestureChatVisibility(early.chat, NO);

    RuntimeFixture *unregistered = [RuntimeFixture new];
    UIViewController *foreignOwner = [UIViewController new];
    unregistered.grow.testOwner = foreignOwner;
    CSInputTextGestureApplyGrow(unregistered.grow);
    Check(!Recognizer(unregistered), @"a grow owned by another controller cannot bind to the chat");
    unregistered.grow.testOwner = nil;
    MMInputToolView *foreignTool = [MMInputToolView new];
    unregistered.chat.nativeTool = foreignTool;
    CSInputTextGestureApplyGrow(unregistered.grow);
    CSInputTextGestureApplyTool(unregistered.tool);
    Check(!Recognizer(unregistered), @"a grow or toolbar outside the owner's current toolbar cannot bind");
    unregistered.chat.nativeTool = unregistered.tool;
    MMGrowTextView *foreignGrow = [MMGrowTextView new];
    unregistered.tool.textView = foreignGrow;
    CSInputTextGestureApplyGrow(unregistered.grow);
    Check(!Recognizer(unregistered), @"a stale grow that is not the toolbar's current input cannot bind");
    unregistered.tool.textView = unregistered.grow;
    unregistered.window.isKeyWindow = NO;
    CSInputTextGestureApplyGrow(unregistered.grow);
    Check(!Recognizer(unregistered), @"an inactive window cannot activate an unobserved chat");
    unregistered.window.isKeyWindow = YES;
    unregistered.chat.presentedViewController = foreignOwner;
    CSInputTextGestureApplyGrow(unregistered.grow);
    Check(!Recognizer(unregistered), @"a covered chat cannot be activated from a grow callback");
    unregistered.chat.presentedViewController = nil;
    UINavigationController *navigation = [UINavigationController new];
    navigation.visibleViewController = foreignOwner;
    unregistered.chat.navigationController = navigation;
    CSInputTextGestureApplyGrow(unregistered.grow);
    Check(!Recognizer(unregistered), @"a chat hidden in the navigation stack cannot be auto-activated");
    navigation.visibleViewController = unregistered.chat;
    CSInputTextGestureApplyGrow(unregistered.grow);
    Check(Recognizer(unregistered).enabled && unregistered.grow.gestureRecognizers.count == 1,
          @"a valid current chat binds after owner, toolbar, grow and visibility match");
    CSInputTextGestureChatVisibility(unregistered.chat, NO);
}

static void TestPendingForegroundDiscovery(void) {
    Configure(YES, CSInputTextGestureActionClear, CSInputTextGestureActionSend);
    RuntimeFixture *fixture = [RuntimeFixture new];
    UIApplication.sharedApplication.applicationState = UIApplicationStateInactive;
    CSInputTextGestureApplyGrow(fixture.grow);
    Check(!Recognizer(fixture), @"an initial inactive grow callback observes the chat without binding");
    UIApplication.sharedApplication.applicationState = UIApplicationStateActive;
    [NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidBecomeActiveNotification object:nil];
    Pump();
    // No layout or appearance callback occurs between the foreground notification
    // and the stroke: the pending input must recover from the notification alone.
    Swipe(fixture, -90, 0);
    Check(Recognizer(fixture).enabled && fixture.editor.testDeletes == 1 && !fixture.editor.text.length,
          @"foreground notification binds the pending input and permits clear without another layout");
    CSInputTextGestureChatVisibility(fixture.chat, NO);
    UIApplication.sharedApplication.applicationState = UIApplicationStateInactive;
    UIApplication.sharedApplication.applicationState = UIApplicationStateActive;
    [NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidBecomeActiveNotification object:nil];
    Pump();
    fixture.editor.text = @"draft after explicit leave";
    Swipe(fixture, 90, 0);
    Check(!Recognizer(fixture).enabled && fixture.tool.sends == 0,
          @"foreground notification never reactivates a chat explicitly marked as left");
}

static void TestChatRelease(void) {
    Configure(YES, CSInputTextGestureActionClear, CSInputTextGestureActionSend);
    __weak BaseMsgContentViewController *releasedChat;
    __weak MMGrowTextView *releasedGrow;
    @autoreleasepool {
        RuntimeFixture *fixture = [RuntimeFixture new];
        releasedChat = fixture.chat; releasedGrow = fixture.grow;
        CSInputTextGestureApplyGrow(fixture.grow);
        CSInputTextGestureChatVisibility(fixture.chat, NO);
        [fixture.chat.view removeFromSuperview];
        fixture = nil;
    }
    Check(!releasedChat && !releasedGrow, @"input bindings do not keep the exited chat or input alive");
}

int main(void) {
    @autoreleasepool {
        memoryDefaults = [InputRuntimeDefaults new];
        Method defaultsGetter = class_getClassMethod(CSInputTextGesturePreferences.class, NSSelectorFromString(@"cs_defaults"));
        IMP original = method_setImplementation(defaultsGetter, (IMP)RuntimeDefaults);
        UIApplication.sharedApplication.applicationState = UIApplicationStateActive;
        TestDelayedInstallAndGrowEntry();
        TestLifecycle();
        TestRecognitionAndScope();
        TestNativeFailurePriority();
        TestAppearanceBridgeAndGrowScope();
        TestPendingForegroundDiscovery();
        TestChatRelease();
        method_setImplementation(defaultsGetter, original);
        printf("Input text gesture runtime: %lu checks, %lu failures (host behavioral doubles and a minimal two-edge failure model; actual UIKit arbitration is not simulated)\n",
               (unsigned long)checks, (unsigned long)failures);
        return failures ? 1 : 0;
    }
}
