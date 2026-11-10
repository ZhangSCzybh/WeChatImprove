#import "CSVoicePlaybackOverlay.h"
#import "CSVoicePlaybackController.h"
#import "CSMessageNativeActionAdapter.h"
#import "CSBubbleStyleAdapter.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <objc/message.h>
#include <math.h>
#include <string.h>

static char CSVoiceOverlayKey;
static NSHashTable *CSVoiceOverlays;
static BOOL CSVoiceRectValid(CGRect r) {
    return isfinite(r.origin.x) && isfinite(r.origin.y) && isfinite(r.size.width) &&
        isfinite(r.size.height) && r.size.width>0 && r.size.height>0;
}
static double CSVoiceDouble(id object,NSString *name) {
    SEL selector=NSSelectorFromString(name); Method method=class_getInstanceMethod(object_getClass(object),selector);
    char type[16]={0}; if (!method || method_getNumberOfArguments(method)!=2) return NAN;
    method_getReturnType(method,type,sizeof(type)); if (strcmp(type,"d")) return NAN;
    @try { return ((double(*)(id,SEL))objc_msgSend)(object,selector); }
    @catch (__unused NSException *exception) { return NAN; }
}
static UIView *CSVoiceIvarView(id object,const char *name) {
    Ivar ivar=class_getInstanceVariable(object_getClass(object),name);
    if (!ivar || !ivar_getTypeEncoding(ivar) || ivar_getTypeEncoding(ivar)[0]!='@') return nil;
    id view=object_getIvar(object,ivar); return [view isKindOfClass:UIView.class] ? view : nil;
}
static BOOL CSVoiceVisible(UIView *view) { return view && !view.hidden && view.alpha>.01 && CSVoiceRectValid(view.bounds); }
static NSString *CSVoiceTime(NSTimeInterval seconds) {
    NSUInteger whole=(NSUInteger)floor(MAX(0,MIN(seconds,86400)));
    return [NSString stringWithFormat:@"%lu:%02lu",(unsigned long)(whole/60),(unsigned long)(whole%60)];
}
static BOOL CSVoiceSupported(UIView *cell,id model,id message) {
    Class vc=NSClassFromString(@"VoiceMessageCellView"),vm=NSClassFromString(@"VoiceMessageViewModel");
    return cell.window && vc && vm && [cell isKindOfClass:vc] && [model isKindOfClass:vm] &&
        CSMessageNativeUnsigned(message,@"m_uiMessageType")==34;
}
static UIGestureRecognizer *CSVoiceNavigationPop(UIView *cell) {
    UIResponder *responder=cell;
    for (NSUInteger depth=0;responder && depth<32;depth++,responder=responder.nextResponder) {
        if (![responder isKindOfClass:UIViewController.class]) continue;
        UIViewController *controller=(UIViewController *)responder;
        UINavigationController *navigation=[controller isKindOfClass:UINavigationController.class] ?
            (UINavigationController *)controller : controller.navigationController;
        UIGestureRecognizer *pop=navigation.interactivePopGestureRecognizer;
        if (pop.enabled) return pop;
    }
    return nil;
}

@class CSVoicePlaybackOverlayState;
// Passive tint inside the background, below the native glyph, duration and buttons.
@interface CSVoicePlaybackBubbleFill : UIView
@property(nonatomic,weak) CSVoicePlaybackOverlayState *owner;
@property(nonatomic,strong) UIView *fill;
@property(nonatomic) CGFloat fraction;
@end
@interface CSVoicePlaybackOverlayState : NSObject <UIGestureRecognizerDelegate>
@property(nonatomic,weak) UIView *cell,*host,*bubble;
@property(nonatomic,weak) id model;
@property(nonatomic,strong) id message;
@property(nonatomic,strong) CSVoicePlaybackBubbleFill *visual;
@property(nonatomic,strong) UIPanGestureRecognizer *pan;
@property(nonatomic,strong) UILabel *preview;
@property(nonatomic,strong) NSArray<NSValue *> *blockedRects;
@property(nonatomic) NSUInteger binding,dragBinding,dragGeneration,touchBinding,touchGeneration;
@property(nonatomic,weak) id dragModel;
@property(nonatomic,strong) id dragMessage;
@property(nonatomic) NSTimeInterval dragDuration,dragTime;
@property(nonatomic) BOOL dragging,touchAdmitted;
@property(nonatomic) CGPoint touchPoint;
@property(nonatomic) CGRect bubbleRect,bubbleInWindow;
- (void)refresh;
- (void)detach;
- (void)clearDrag;
- (void)hide;
- (BOOL)bindingIsCurrent;
- (CSVoicePlaybackSnapshot *)usableSnapshot;
- (BOOL)allowsPoint:(CGPoint)point;
- (void)updatePreview;
- (void)pan:(UIPanGestureRecognizer *)pan;
- (void)adjustBy:(NSTimeInterval)seconds;
@end
@implementation CSVoicePlaybackBubbleFill
- (instancetype)initWithFrame:(CGRect)frame {
    if ((self=[super initWithFrame:frame])) {
        self.backgroundColor=UIColor.clearColor; self.userInteractionEnabled=NO; self.clipsToBounds=YES;
        _fill=[UIView new]; _fill.userInteractionEnabled=NO; [self addSubview:_fill];
        self.isAccessibilityElement=YES; self.accessibilityLabel=@"语音播放进度";
        self.accessibilityTraits=UIAccessibilityTraitAdjustable;
    } return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.fill.frame=CGRectMake(0,0,CGRectGetWidth(self.bounds)*_fraction,CGRectGetHeight(self.bounds));
}
- (void)setFraction:(CGFloat)fraction { _fraction=MAX(0,MIN(1,fraction)); [self setNeedsLayout]; }
- (void)accessibilityIncrement { [self.owner adjustBy:5]; }
- (void)accessibilityDecrement { [self.owner adjustBy:-5]; }
@end
@implementation CSVoicePlaybackOverlayState
- (void)clearDrag {
    _dragging=NO; _touchAdmitted=NO; _dragModel=nil; _dragMessage=nil;
    _dragGeneration=0; _dragBinding=0; _touchBinding=0; _touchGeneration=0;
    [_preview removeFromSuperview]; _preview=nil;
}
- (void)hide {
    [self clearDrag];
    // Clear first: UIKit can synchronously send cancellation while disabling.
    UIPanGestureRecognizer *pan=_pan; _pan=nil; pan.enabled=NO;
    if (pan) [_host removeGestureRecognizer:pan]; pan.delegate=nil;
    [_visual removeFromSuperview]; _visual.owner=nil; _visual=nil;
    _host=nil; _bubble=nil; _blockedRects=nil; _bubbleRect=CGRectZero;
}
- (void)detach { _binding++; [self hide]; _message=nil; _model=nil; }
- (void)dealloc {
    UIView *preview=_preview,*visual=_visual,*host=_host; UIPanGestureRecognizer *pan=_pan;
    void (^remove)(void)=^{
        pan.enabled=NO; pan.delegate=nil; if (pan) [host removeGestureRecognizer:pan];
        [preview removeFromSuperview]; [visual removeFromSuperview];
    };
    if (NSThread.isMainThread) remove(); else dispatch_async(dispatch_get_main_queue(),remove);
}
- (BOOL)bindingIsCurrent {
    return _cell.window && _model && _message &&
        CSMessageActionObjectGetter(_cell,NSSelectorFromString(@"viewModel"))==_model &&
        CSMessageActionResolveSourceWrap(_cell)==_message;
}
- (CSVoicePlaybackSnapshot *)usableSnapshot {
    if (![self bindingIsCurrent] || !_host || !_visual.superview || !_pan.enabled ||
        ![_host isDescendantOfView:_cell] || !CSVoiceRectValid(_bubbleRect)) return nil;
    CSVoicePlaybackSnapshot *s=[CSVoicePlaybackController.sharedController snapshotForMessage:_message];
    return s.canSeek && isfinite(s.duration) && s.duration>0 && isfinite(s.currentTime) ? s : nil;
}
- (BOOL)allowsPoint:(CGPoint)point {
    if (!isfinite(point.x) || !isfinite(point.y) || ![self usableSnapshot] || !CGRectContainsPoint(_bubbleRect,point)) return NO;
    for (NSValue *value in _blockedRects) {
        CGRect rect; [value getValue:&rect size:sizeof(rect)]; if (CGRectContainsPoint(rect,point)) return NO;
    }
    if (CSVoiceNavigationPop(_cell)) {
        UIWindow *window=_cell.window; CGPoint p=[window convertPoint:point fromView:_host];
        if (p.x<CGRectGetMinX(window.bounds)+window.safeAreaInsets.left+24 ||
            p.x>CGRectGetMaxX(window.bounds)-window.safeAreaInsets.right-24) return NO;
    }
    return YES;
}
- (void)refresh {
    if (!NSThread.isMainThread) return;
    UIView *cell=_cell; id model=CSMessageActionObjectGetter(cell,NSSelectorFromString(@"viewModel"));
    id message=CSMessageActionResolveSourceWrap(cell);
    if (!CSVoiceSupported(cell,model,message)) { [self detach]; return; }
    if (_model!=model || _message!=message) { [self detach]; _model=model; _message=message; }
    CSVoicePlaybackSnapshot *s=[CSVoicePlaybackController.sharedController snapshotForMessage:message];
    if (!s || !isfinite(s.duration) || s.duration<=0 || !isfinite(s.currentTime)) { [self hide]; return; }
    if (_dragging && (_dragBinding!=_binding || _dragModel!=model || _dragMessage!=message ||
        _dragGeneration!=s.generation || !s.canSeek)) [self clearDrag];
    UIView *host=CSMessageActionObjectGetter(cell,NSSelectorFromString(@"getContentView"));
    UIView *bubble=CSMessageActionObjectGetter(cell,NSSelectorFromString(@"getBgImageView"));
    double height=CSVoiceDouble(model,@"voiceNodeHeight");
    if (![host isKindOfClass:UIView.class] || host==cell || ![host isDescendantOfView:cell] ||
        ![bubble isKindOfClass:UIView.class] || ![bubble isDescendantOfView:host] || !CSVoiceVisible(bubble) ||
        !CGAffineTransformIsIdentity(bubble.transform) || !isfinite(height) || height<24) { [self hide]; return; }
    UIEdgeInsets insets;
    if (!CSBubbleStyleVisibleInsets(bubble,&insets) &&
        !CSBubbleStyleModelInsets(model,bubble,bubble.bounds.size,&insets)) { [self hide]; return; }
    CGRect body=UIEdgeInsetsInsetRect(bubble.bounds,insets); body.size.height=MIN(body.size.height,height);
    CGRect rect=[host convertRect:body fromView:bubble];
    if (!CSVoiceRectValid(body) || body.size.width<28 || body.size.height<24 ||
        !CGRectContainsRect(bubble.bounds,body) || !CGRectContainsRect(host.bounds,rect)) { [self hide]; return; }
    if (_host!=host || _bubble!=bubble) [self hide];
    _host=host; _bubble=bubble; _bubbleRect=rect;
    NSMutableArray *blocked=[NSMutableArray array];
    for (NSString *name in @[@"m_playRateButton",@"m_resumePlayButton",@"m_quickTransTipButton"]) {
        UIView *native=CSVoiceIvarView(cell,name.UTF8String);
        if (CSVoiceVisible(native) && [native isKindOfClass:UIControl.class] && [native isDescendantOfView:host]) {
            CGRect block=[host convertRect:native.bounds fromView:native];
            [blocked addObject:[NSValue valueWithBytes:&block objCType:@encode(CGRect)]];
        }
    }
    _blockedRects=blocked;
    if (!_visual) { _visual=[[CSVoicePlaybackBubbleFill alloc] initWithFrame:CGRectInset(body,1,1)]; _visual.owner=self; }
    _visual.frame=CGRectInset(body,1,1);
    // A rounded inner footprint remains inside native/custom body corners.
    _visual.layer.cornerRadius=MIN(CGRectGetHeight(_visual.bounds)/2,CGRectGetWidth(_visual.bounds)/2);
    if (_visual.superview!=bubble) { [_visual removeFromSuperview]; [bubble addSubview:_visual]; }
    if (!_pan) {
        _pan=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        _pan.minimumNumberOfTouches=1; _pan.maximumNumberOfTouches=1; _pan.delegate=self;
        _pan.cancelsTouchesInView=YES; _pan.delaysTouchesBegan=NO; _pan.delaysTouchesEnded=NO;
        [host addGestureRecognizer:_pan];
    }
    _pan.enabled=s.canSeek;
    UIView *label=CSVoiceIvarView(cell,"m_secLabel");
    UIColor *tint=[label isKindOfClass:UILabel.class] ? ((UILabel *)label).textColor : nil;
    _visual.fill.backgroundColor=[(tint ?: UIColor.labelColor) colorWithAlphaComponent:_dragging ? .18 : .11];
    NSTimeInterval position=_dragging ? _dragTime : MAX(0,MIN(s.duration,s.currentTime));
    _visual.fraction=position/s.duration;
    _visual.accessibilityTraits=s.canSeek ? UIAccessibilityTraitAdjustable : UIAccessibilityTraitStaticText;
    _visual.accessibilityValue=[NSString stringWithFormat:@"%@ / %@",CSVoiceTime(position),CSVoiceTime(s.duration)];
    _bubbleInWindow=[cell.window convertRect:body fromView:bubble];
    [_visual layoutIfNeeded]; if (_dragging) [self updatePreview];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldReceiveTouch:(UITouch *)touch {
    _touchAdmitted=NO;
    if (gesture!=_pan || !touch || !NSThread.isMainThread) return NO;
    for (UIView *v=touch.view;v && v!=_host;v=v.superview) if ([v isKindOfClass:UIControl.class]) return NO;
    CGPoint point=[touch locationInView:_host]; if (![self allowsPoint:point]) return NO;
    CSVoicePlaybackSnapshot *s=[self usableSnapshot]; if (!s) return NO;
    _touchPoint=point; _touchBinding=_binding; _touchGeneration=s.generation; _touchAdmitted=YES; return YES;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gesture {
    if (gesture!=_pan || !_touchAdmitted || _touchBinding!=_binding || ![self allowsPoint:_touchPoint]) return NO;
    CSVoicePlaybackSnapshot *s=[self usableSnapshot]; if (!s || s.generation!=_touchGeneration) return NO;
    CGPoint velocity=[_pan velocityInView:_host],translation=[_pan translationInView:_host];
    CGPoint intent=fabs(velocity.x)+fabs(velocity.y)>0 ? velocity : translation;
    return isfinite(intent.x) && isfinite(intent.y) && fabs(intent.x)>fabs(intent.y)*1.35 && fabs(intent.x)>0;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)other {
    return gesture==_pan && ([other isKindOfClass:UIScreenEdgePanGestureRecognizer.class] || other==CSVoiceNavigationPop(_cell));
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)other {
    (void)gesture; (void)other; return NO;
}
- (void)updatePreview {
    UIWindow *window=_cell.window; if (!window || !_dragging) return;
    if (!_preview) {
        _preview=[UILabel new]; _preview.font=[UIFont monospacedDigitSystemFontOfSize:12 weight:UIFontWeightMedium];
        _preview.textAlignment=NSTextAlignmentCenter; _preview.layer.cornerRadius=7; _preview.clipsToBounds=YES;
        _preview.userInteractionEnabled=NO; _preview.isAccessibilityElement=NO;
    }
    _preview.text=[NSString stringWithFormat:@"%@ / %@",CSVoiceTime(_dragTime),CSVoiceTime(_dragDuration)];
    _preview.textColor=UIColor.labelColor; _preview.backgroundColor=[UIColor.secondarySystemBackgroundColor colorWithAlphaComponent:.96];
    CGFloat width=MAX(88,[_preview sizeThatFits:CGSizeMake(200,24)].width+16),height=26;
    UIEdgeInsets safe=window.safeAreaInsets; CGRect bounds=window.bounds;
    CGFloat x=CGRectGetMidX(_bubbleInWindow)-width/2;
    x=MAX(CGRectGetMinX(bounds)+safe.left+8,MIN(x,CGRectGetMaxX(bounds)-safe.right-width-8));
    CGFloat y=CGRectGetMinY(_bubbleInWindow)-height-6;
    if (y<CGRectGetMinY(bounds)+safe.top+4) y=CGRectGetMaxY(_bubbleInWindow)+6;
    y=MIN(y,CGRectGetMaxY(bounds)-safe.bottom-height-4);
    _preview.frame=CGRectMake(x,y,width,height);
    if (_preview.superview!=window) { [_preview removeFromSuperview]; [window addSubview:_preview]; }
}
- (void)pan:(UIPanGestureRecognizer *)pan {
    if (!NSThread.isMainThread || pan!=_pan) return;
    if (pan.state==UIGestureRecognizerStateCancelled || pan.state==UIGestureRecognizerStateFailed) { [self clearDrag]; [self refresh]; return; }
    if (pan.state==UIGestureRecognizerStateBegan) {
        CSVoicePlaybackSnapshot *s=[self usableSnapshot];
        if (!s || !_touchAdmitted || _touchBinding!=_binding || s.generation!=_touchGeneration) { [self clearDrag]; return; }
        _dragging=YES; _dragBinding=_binding; _dragGeneration=s.generation;
        _dragModel=_model; _dragMessage=_message; _dragDuration=s.duration;
    }
    if (!_dragging) return;
    CSVoicePlaybackSnapshot *current=[self usableSnapshot];
    if (!current || current.generation!=_dragGeneration || _dragBinding!=_binding ||
        _dragModel!=_model || _dragMessage!=_message) { [self clearDrag]; [self refresh]; return; }
    CGPoint location=[pan locationInView:_host]; CGFloat width=CGRectGetWidth(_bubbleRect);
    if (!isfinite(location.x) || width<=0) { [self clearDrag]; return; }
    _dragTime=MAX(0,MIN(1,(location.x-CGRectGetMinX(_bubbleRect))/width))*_dragDuration;
    _visual.fraction=_dragTime/_dragDuration;
    _visual.fill.backgroundColor=[_visual.fill.backgroundColor colorWithAlphaComponent:.18];
    _visual.accessibilityValue=[NSString stringWithFormat:@"%@ / %@",CSVoiceTime(_dragTime),CSVoiceTime(_dragDuration)];
    [_visual layoutIfNeeded]; [self updatePreview];
    if (pan.state==UIGestureRecognizerStateEnded) {
        id message=_dragMessage; NSUInteger generation=_dragGeneration; NSTimeInterval time=_dragTime;
        [self clearDrag]; // Seek may synchronously publish a notification and reenter refresh.
        [CSVoicePlaybackController.sharedController seekToTime:time message:message generation:generation];
        [self refresh];
    }
}
- (void)adjustBy:(NSTimeInterval)seconds {
    CSVoicePlaybackSnapshot *s=[self usableSnapshot]; if (!s) return;
    id message=_message; [self clearDrag];
    [CSVoicePlaybackController.sharedController seekToTime:MAX(0,MIN(s.duration,s.currentTime+seconds)) message:message generation:s.generation];
    [self refresh];
}
@end

static void CSVoiceObserveOverlays(void) {
    static dispatch_once_t once; dispatch_once(&once,^{
        CSVoiceOverlays=[NSHashTable weakObjectsHashTable];
        void (^changed)(NSNotification *)=^(__unused NSNotification *notification){
            void (^refresh)(void)=^{ for (CSVoicePlaybackOverlayState *s in CSVoiceOverlays.allObjects) [s refresh]; };
            if (NSThread.isMainThread) refresh(); else dispatch_async(dispatch_get_main_queue(),refresh);
        };
        for (NSString *name in @[CSVoicePlaybackStateDidChangeNotification,CSVoicePlaybackSettingsDidChangeNotification])
            [NSNotificationCenter.defaultCenter addObserverForName:name object:nil queue:nil usingBlock:changed];
    });
}
void CSVoicePlaybackRefreshCell(id object) {
    if (!NSThread.isMainThread || ![object isKindOfClass:UIView.class]) return;
    UIView *cell=object; id model=CSMessageActionObjectGetter(cell,NSSelectorFromString(@"viewModel"));
    if (!CSVoiceSupported(cell,model,CSMessageActionResolveSourceWrap(cell))) { CSVoicePlaybackDetachCell(cell); return; }
    CSVoiceObserveOverlays(); CSVoicePlaybackOverlayState *s=objc_getAssociatedObject(cell,&CSVoiceOverlayKey);
    if (!s) {
        s=[CSVoicePlaybackOverlayState new]; s.cell=cell;
        objc_setAssociatedObject(cell,&CSVoiceOverlayKey,s,OBJC_ASSOCIATION_RETAIN_NONATOMIC); [CSVoiceOverlays addObject:s];
    }
    [s refresh];
}
void CSVoicePlaybackDetachCell(id cell) {
    if (!NSThread.isMainThread || !cell) return;
    CSVoicePlaybackOverlayState *s=objc_getAssociatedObject(cell,&CSVoiceOverlayKey);
    [s detach]; if (s) [CSVoiceOverlays removeObject:s];
    objc_setAssociatedObject(cell,&CSVoiceOverlayKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
BOOL CSVoicePlaybackOwnsTouch(id cell,CGPoint pointInCell) {
    if (!NSThread.isMainThread || ![cell isKindOfClass:UIView.class]) return NO;
    CSVoicePlaybackOverlayState *s=objc_getAssociatedObject(cell,&CSVoiceOverlayKey);
    return s.host && [s allowsPoint:[s.host convertPoint:pointInCell fromView:cell]];
}
