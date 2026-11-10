#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/message.h>
#import "CSVoicePlaybackController.h"
#import "CSMessageActionContext.h"
#import "CSBubbleStyleAdapter.h"
#include <math.h>

static NSUInteger checks;
static void Check(BOOL condition,NSString *message) {
    checks++;if (!condition) { NSLog(@"FAIL: %@",message);exit(1); }
}
static BOOL Close(CGFloat first,CGFloat second) { return fabs(first-second)<.001; }

@interface CSVoicePlaybackSnapshot ()
@property(nonatomic) NSUInteger generation;
@property(nonatomic) NSTimeInterval currentTime,duration;
@property(nonatomic) BOOL canSeek;
@end
@implementation CSVoicePlaybackSnapshot @end
NSNotificationName const CSVoicePlaybackStateDidChangeNotification=@"CSTestVoicePlaybackStateDidChange";
NSNotificationName const CSVoicePlaybackSettingsDidChangeNotification=@"CSTestVoicePlaybackSettingsDidChange";
static id activeMessage;
static CSVoicePlaybackSnapshot *activeSnapshot;
static NSMutableArray<NSDictionary *> *seekCalls;
static BOOL synchronousSeekNotification;
@implementation CSVoicePlaybackController
+ (instancetype)sharedController { static id controller;static dispatch_once_t once;dispatch_once(&once,^{ controller=[self new]; });return controller; }
- (CSVoicePlaybackSnapshot *)snapshotForMessage:(id)message { return message==activeMessage ? activeSnapshot : nil; }
- (BOOL)seekToTime:(NSTimeInterval)seconds message:(id)message generation:(NSUInteger)generation {
    [seekCalls addObject:@{@"seconds":@(seconds),@"message":message,@"generation":@(generation)}];
    if (synchronousSeekNotification) [NSNotificationCenter.defaultCenter postNotificationName:CSVoicePlaybackStateDidChangeNotification object:self];
    return YES;
}
@end

@interface CMessageWrap : NSObject
@property(nonatomic) unsigned int m_uiMessageType;
@end
@implementation CMessageWrap @end
@interface VoiceMessageViewModel : NSObject
@property(nonatomic,strong) CMessageWrap *messageWrap;
@property(nonatomic) double voiceNodeHeight;
@end
@implementation VoiceMessageViewModel @end
@interface VoiceMessageCellView : UIView {
@public
    UILabel *m_secLabel;
    UIView *m_playingImageView;
    UIControl *m_playRateButton,*m_resumePlayButton,*m_quickTransTipButton;
}
@property(nonatomic,strong) VoiceMessageViewModel *viewModel;
@property(nonatomic,strong) UIView *testContent,*testBubble;
@property(nonatomic,strong) UIViewController *testController;
- (UIView *)getContentView;
- (UIView *)getBgImageView;
- (UIViewController *)getCurrViewController;
@end
@implementation VoiceMessageCellView
- (UIView *)getContentView { return self.testContent; }
- (UIView *)getBgImageView { return self.testBubble; }
- (UIViewController *)getCurrViewController { return self.testController; }
@end

id CSMessageActionObjectGetter(id object,SEL selector) {
    if (!object || ![object respondsToSelector:selector]) return nil;
    return ((id(*)(id,SEL))objc_msgSend)(object,selector);
}
id CSMessageActionNativeObject(id object,NSString *selector) { return CSMessageActionObjectGetter(object,NSSelectorFromString(selector)); }
id CSMessageActionResolveSourceWrap(id cell) { return [cell isKindOfClass:VoiceMessageCellView.class] ? ((VoiceMessageCellView *)cell).viewModel.messageWrap : nil; }
unsigned long long CSMessageNativeUnsigned(id object,NSString *selector) {
    if ([selector isEqualToString:@"m_uiMessageType"] && [object isKindOfClass:CMessageWrap.class]) return ((CMessageWrap *)object).m_uiMessageType;
    return 0;
}
static BOOL useVisibleInsets;
static BOOL useModelInsets;
static UIEdgeInsets visibleInsets;
BOOL CSBubbleStyleVisibleInsets(UIView *background,UIEdgeInsets *insets) {
    if (useVisibleInsets && insets) *insets=visibleInsets;return useVisibleInsets;
}
BOOL CSBubbleStyleIsDark(UIView *view) { return view.traitCollection.userInterfaceStyle==UIUserInterfaceStyleDark; }
BOOL CSBubbleStyleModelInsets(id model,UIView *appearance,CGSize size,UIEdgeInsets *insets) {
    if (useModelInsets && insets) *insets=visibleInsets;return useModelInsets;
}

// Include the actual production implementation: all interactions below exercise its
// public lifecycle and gesture entry points with invocation-recording native edges.
#import "../Controllers/CSVoicePlaybackOverlay.m"

static VoiceMessageCellView *MakeCell(UIWindow *window) {
    VoiceMessageCellView *cell=[[VoiceMessageCellView alloc] initWithFrame:CGRectMake(0,120,390,64)];
    [window addSubview:cell];cell.testContent=[[UIView alloc] initWithFrame:cell.bounds];[cell addSubview:cell.testContent];
    cell.testBubble=[[UIView alloc] initWithFrame:CGRectMake(54,6,180,48)];[cell.testContent addSubview:cell.testBubble];
    cell.viewModel=[VoiceMessageViewModel new];cell.viewModel.voiceNodeHeight=48;cell.viewModel.messageWrap=[CMessageWrap new];cell.viewModel.messageWrap.m_uiMessageType=34;
    cell->m_playingImageView=[[UIView alloc] initWithFrame:CGRectMake(68,19,18,22)];[cell.testContent addSubview:cell->m_playingImageView];
    cell->m_secLabel=[[UILabel alloc] initWithFrame:CGRectMake(190,18,27,24)];cell->m_secLabel.text=@"20″";cell->m_secLabel.textColor=[UIColor colorWithWhite:.12 alpha:1];[cell.testContent addSubview:cell->m_secLabel];
    cell->m_playRateButton=[[UIControl alloc] initWithFrame:CGRectMake(244,14,40,32)];[cell.testContent addSubview:cell->m_playRateButton];
    cell->m_resumePlayButton=[[UIControl alloc] initWithFrame:CGRectMake(244,14,40,32)];cell->m_resumePlayButton.hidden=YES;[cell.testContent addSubview:cell->m_resumePlayButton];
    cell->m_quickTransTipButton=[[UIControl alloc] initWithFrame:CGRectMake(288,14,40,32)];[cell.testContent addSubview:cell->m_quickTransTipButton];
    cell.testController=[UIViewController new];cell.testController.navigationController=[UINavigationController new];
    cell.testController.navigationController.interactivePopGestureRecognizer=[UIScreenEdgePanGestureRecognizer new];
    cell.nextResponder=cell.testController;
    return cell;
}
static void Activate(VoiceMessageCellView *cell,NSTimeInterval position) {
    activeMessage=cell.viewModel.messageWrap;activeSnapshot=[CSVoicePlaybackSnapshot new];
    activeSnapshot.generation=17;activeSnapshot.duration=20;activeSnapshot.currentTime=position;activeSnapshot.canSeek=YES;
}
static NSDictionary *NativeFrames(VoiceMessageCellView *cell) {
    NSMutableDictionary *frames=[NSMutableDictionary dictionary];
    for (NSString *key in @[@"cell",@"content",@"bubble",@"label",@"glyph",@"rate",@"resume",@"quick"]) {
        NSDictionary *views=@{@"cell":cell,@"content":cell.testContent,@"bubble":cell.testBubble,@"label":cell->m_secLabel,
            @"glyph":cell->m_playingImageView,@"rate":cell->m_playRateButton,@"resume":cell->m_resumePlayButton,@"quick":cell->m_quickTransTipButton};
        CGRect frame=((UIView *)views[key]).frame;frames[key]=[NSValue valueWithBytes:&frame objCType:@encode(CGRect)];
    } return frames;
}
static CSVoicePlaybackOverlayState *State(VoiceMessageCellView *cell) {
    return objc_getAssociatedObject(cell,&CSVoiceOverlayKey);
}
static CGPoint PointAt(CSVoicePlaybackOverlayState *state,CGFloat fraction) {
    return CGPointMake(CGRectGetMinX(state.bubbleRect)+CGRectGetWidth(state.bubbleRect)*fraction,CGRectGetMidY(state.bubbleRect));
}
static UITouch *TouchAt(UIView *host,CGPoint point,UIView *touchView) {
    UITouch *touch=[UITouch new];touch.view=touchView;touch.testLocation=[touchView convertPoint:point fromView:host];return touch;
}
static BOOL Admit(CSVoicePlaybackOverlayState *state,CGPoint point,UIView *touchView,CGPoint velocity) {
    state.pan.testLocation=point;state.pan.testVelocity=velocity;
    UITouch *touch=TouchAt(state.host,point,touchView);
    return [state gestureRecognizer:state.pan shouldReceiveTouch:touch] && [state gestureRecognizerShouldBegin:state.pan];
}
static void SendPan(CSVoicePlaybackOverlayState *state,UIGestureRecognizerState phase,CGFloat fraction) {
    state.pan.testLocation=PointAt(state,fraction);state.pan.state=phase;[state pan:state.pan];
}
static void Begin(CSVoicePlaybackOverlayState *state,CGFloat fraction) {
    Check(Admit(state,PointAt(state,fraction),state.host,CGPointMake(100,3)),@"active horizontal drag is admitted");
    SendPan(state,UIGestureRecognizerStateBegan,fraction);
}
static void CheckNoSeek(NSUInteger before,NSString *message) { Check(seekCalls.count==before,message); }

int main(void) {
    @autoreleasepool {
        seekCalls=[NSMutableArray array];UIWindow *window=[[UIWindow alloc] initWithFrame:CGRectMake(0,0,390,844)];
        useVisibleInsets=YES;visibleInsets=(UIEdgeInsets){0,6,0,6};
        VoiceMessageCellView *cell=MakeCell(window);
        NSDictionary *nativeFrames=NativeFrames(cell);
        CSVoicePlaybackRefreshCell(cell);
        Check(!CSVoicePlaybackOwnsTouch(cell,CGPointMake(100,30)),@"inactive voice leaves bubble touches native");
        Activate(cell,5);
        CSVoicePlaybackRefreshCell(cell);
        CSVoicePlaybackOverlayState *state=State(cell);
        Check(state && state.visual && state.pan,@"active voice installs fill and gesture state");
        Check(state.visual.superview==cell.testBubble,@"fill stays inside the actual native bubble");
        Check(!state.visual.userInteractionEnabled,@"passive fill never captures native taps or long presses");
        Check(state.visual.subviews.count==1,@"progress has one fill and no dot or separate track");
        Check(state.visual.clipsToBounds && state.visual.layer.cornerRadius>0,@"progress clips to a rounded bubble body");
        Check(CGRectContainsRect(cell.testBubble.bounds,state.visual.frame),@"progress remains inside native bubble bounds");
        Check(Close(state.visual.fraction,.25),@"native current time drives initial progress");
        [state.visual layoutIfNeeded];
        Check(Close(state.visual.fill.frame.size.width,state.visual.bounds.size.width*.25),@"bubble length represents current time");
        Check(state.pan.view==cell.testContent,@"gesture belongs to content container");
        Check(!state.pan.delaysTouchesBegan && !state.pan.delaysTouchesEnded,@"unrecognized progress gesture does not delay native touches");
        Check(state.pan.cancelsTouchesInView,@"recognized horizontal drag cancels the native click");
        CGPoint point=PointAt(state,.5);
        CGPoint pointInCell=[cell convertPoint:point fromView:state.host];
        Check(CSVoicePlaybackOwnsTouch(cell,pointInCell),@"only active bubble owns message-swipe admission");
        Check(!CSVoicePlaybackOwnsTouch(cell,CGPointMake(350,30)),@"rest of message cell keeps native gesture admission");
        Check(!Admit(state,point,state.host,CGPointMake(4,100)),@"vertical scrolling wins over progress dragging");
        Check(!Admit(state,point,state.host,CGPointMake(50,48)),@"ambiguous diagonal movement does not seek");
        Check(Admit(state,point,state.host,CGPointMake(100,2)),@"explicit horizontal intent can seek");
        Check(![state gestureRecognizer:state.pan shouldReceiveTouch:TouchAt(state.host,point,cell->m_playRateButton)],@"native control ancestry excludes progress recognizer");
        UIGestureRecognizer *pop=cell.testController.navigationController.interactivePopGestureRecognizer;
        Check([state gestureRecognizer:state.pan shouldRequireFailureOfGestureRecognizer:pop],@"navigation pop has recognizer priority");
        Check([state gestureRecognizer:state.pan shouldRequireFailureOfGestureRecognizer:[UIScreenEdgePanGestureRecognizer new]],@"screen-edge navigation retains priority");

        CGRect originalBubble=cell.testBubble.frame;
        cell.testBubble.frame=CGRectMake(2,originalBubble.origin.y,originalBubble.size.width,originalBubble.size.height);CSVoicePlaybackRefreshCell(cell);
        Check(!CSVoicePlaybackOwnsTouch(cell,CGPointMake(10,30)),@"navigation edge strip never belongs to progress");
        Check(!Admit(state,CGPointMake(10,30),state.host,CGPointMake(100,0)),@"progress recognizer refuses navigation edge touch");
        cell.testBubble.frame=CGRectMake(224,originalBubble.origin.y,160,originalBubble.size.height);CSVoicePlaybackRefreshCell(cell);
        Check(!CSVoicePlaybackOwnsTouch(cell,CGPointMake(380,30)),@"opposite navigation edge is also reserved");
        cell.testBubble.frame=originalBubble;CSVoicePlaybackRefreshCell(cell);

        CGRect originalRate=cell->m_playRateButton.frame;
        cell->m_playRateButton.frame=CGRectMake(110,16,30,28);CSVoicePlaybackRefreshCell(cell);
        Check(!CSVoicePlaybackOwnsTouch(cell,CGPointMake(120,25)),@"native rate button keeps its own touch region");
        cell->m_playRateButton.frame=originalRate;CSVoicePlaybackRefreshCell(cell);

        NSUInteger before=seekCalls.count;
        synchronousSeekNotification=YES;
        Begin(state,.25);CheckNoSeek(before,@"drag begin only previews");
        SendPan(state,UIGestureRecognizerStateChanged,.6);CheckNoSeek(before,@"drag changes only preview");
        Check(state.dragging && state.preview.superview==window,@"preview badge appears only during active drag");
        SendPan(state,UIGestureRecognizerStateEnded,.75);
        Check(seekCalls.count==before+1,@"drag end commits exactly one native seek");
        Check(Close([seekCalls.lastObject[@"seconds"] doubleValue],15),@"full bubble x position maps to seconds");
        Check(seekCalls.lastObject[@"message"]==cell.viewModel.messageWrap,@"seek targets bound source message");
        Check([seekCalls.lastObject[@"generation"] unsignedIntegerValue]==17,@"seek commits captured generation");
        Check(!state.dragging && !state.preview,@"seek clears preview before synchronous refresh reentry");
        SendPan(state,UIGestureRecognizerStateEnded,.9);CheckNoSeek(before+1,@"duplicate end cannot commit twice");
        synchronousSeekNotification=NO;

        Begin(state,.2);SendPan(state,UIGestureRecognizerStateEnded,-.5);
        Check(Close([seekCalls.lastObject[@"seconds"] doubleValue],0),@"drag beyond bubble start clamps to zero");
        Begin(state,.8);SendPan(state,UIGestureRecognizerStateEnded,1.5);
        Check(Close([seekCalls.lastObject[@"seconds"] doubleValue],20),@"drag beyond bubble end clamps to duration");

        before=seekCalls.count;Begin(state,.2);SendPan(state,UIGestureRecognizerStateChanged,.8);SendPan(state,UIGestureRecognizerStateCancelled,.8);
        CheckNoSeek(before,@"cancel never seeks");Check(!state.dragging && !state.preview,@"cancel clears drag and badge");
        Check(Close(state.visual.fraction,.25),@"cancel restores actual playback position");
        Begin(state,.3);SendPan(state,UIGestureRecognizerStateFailed,.9);CheckNoSeek(before,@"failed gesture never seeks");

        Begin(state,.3);activeSnapshot.generation++;SendPan(state,UIGestureRecognizerStateEnded,.8);
        CheckNoSeek(before,@"generation change invalidates a pending seek");
        activeSnapshot.generation=17;
        Begin(state,.4);activeMessage=nil;SendPan(state,UIGestureRecognizerStateEnded,.9);
        CheckNoSeek(before,@"message stop invalidates pending seek");
        Check(!CSVoicePlaybackOwnsTouch(cell,pointInCell),@"stopped voice immediately releases bubble touch ownership");
        Activate(cell,5);CSVoicePlaybackRefreshCell(cell);state=State(cell);

        Begin(state,.4);UIPanGestureRecognizer *oldPan=state.pan;
        VoiceMessageViewModel *replacement=[VoiceMessageViewModel new];replacement.voiceNodeHeight=48;replacement.messageWrap=[CMessageWrap new];replacement.messageWrap.m_uiMessageType=34;
        cell.viewModel=replacement;Activate(cell,2);CSVoicePlaybackRefreshCell(cell);
        oldPan.state=UIGestureRecognizerStateEnded;[state pan:oldPan];
        CheckNoSeek(before,@"cell rebinding rejects old gesture commit");
        Check(!state.dragging && !state.preview,@"cell rebinding discards prior preview");

        activeSnapshot.currentTime=10;
        [NSNotificationCenter.defaultCenter postNotificationName:CSVoicePlaybackStateDidChangeNotification object:nil];
        Check(Close(state.visual.fraction,.5),@"state notification refreshes known attached cells");
        VoiceMessageCellView *unregistered=MakeCell(window);
        [NSNotificationCenter.defaultCenter postNotificationName:CSVoicePlaybackStateDidChangeNotification object:nil];
        Check(!State(unregistered),@"notification never discovers or installs unregistered cells");

        Begin(state,.4);UIPanGestureRecognizer *settingsPan=state.pan;activeSnapshot=nil;
        [NSNotificationCenter.defaultCenter postNotificationName:CSVoicePlaybackSettingsDidChangeNotification object:nil];
        Check(!state.visual && !state.pan && !state.preview,@"progress switch notification releases fill, recognizer and drag badge");
        Check(State(cell)==state,@"progress switch keeps already-registered cell lifecycle state");
        settingsPan.state=UIGestureRecognizerStateEnded;[state pan:settingsPan];
        CheckNoSeek(before,@"disabling progress invalidates previously captured drag");
        Activate(cell,5);[NSNotificationCenter.defaultCenter postNotificationName:CSVoicePlaybackSettingsDidChangeNotification object:nil];
        Check(state.visual && state.pan && Close(state.visual.fraction,.25),@"re-enabling progress refreshes known active cell");
        Check(!State(unregistered),@"settings refresh does not discover unregistered cells");

        useVisibleInsets=NO;CSVoicePlaybackRefreshCell(cell);
        Check(!state.visual && !state.pan && !CSVoicePlaybackOwnsTouch(cell,pointInCell),@"unknown bubble padding fails closed without drawing or touch interception");
        useModelInsets=YES;CSVoicePlaybackRefreshCell(cell);
        Check(state.visual && state.pan,@"reliable model padding can supply native body fallback");
        useVisibleInsets=YES;useModelInsets=NO;CSVoicePlaybackRefreshCell(cell);

        activeSnapshot.canSeek=NO;CSVoicePlaybackRefreshCell(cell);
        Check(!CSVoicePlaybackOwnsTouch(cell,pointInCell),@"unseekable active player does not own gestures");
        activeSnapshot.canSeek=YES;activeSnapshot.duration=NAN;CSVoicePlaybackRefreshCell(cell);
        Check(!CSVoicePlaybackOwnsTouch(cell,pointInCell),@"invalid duration fails closed for touch admission");
        Activate(cell,5);CSVoicePlaybackRefreshCell(cell);state=State(cell);

        Begin(state,.4);oldPan=state.pan;[cell removeFromSuperview];CSVoicePlaybackRefreshCell(cell);
        oldPan.state=UIGestureRecognizerStateEnded;[state pan:oldPan];
        CheckNoSeek(before,@"window detach invalidates active drag");
        Check(!State(cell) && !CSVoicePlaybackOwnsTouch(cell,pointInCell),@"window detach removes lifecycle state");
        Check(!state.preview && !state.visual.superview && !oldPan.view,@"window detach removes badge, fill and recognizer");
        [window addSubview:cell];CSVoicePlaybackRefreshCell(cell);
        Check([NativeFrames(cell) isEqual:nativeFrames],@"refresh preserves every native frame");
        Check(cell->m_resumePlayButton.hidden,@"progress does not unhide native resume controls");
        CSVoicePlaybackDetachCell(cell);
        Check([NativeFrames(cell) isEqual:nativeFrames],@"detach preserves every native frame");
        NSLog(@"VoicePlaybackOverlayTests: %lu checks",(unsigned long)checks);
    } return 0;
}
