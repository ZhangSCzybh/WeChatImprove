#import "CSMessageGestureAdapter.h"
#import "CSVoicePlaybackOverlay.h"
#import <objc/runtime.h>
#import <math.h>

static char CSAdapterKey;
static NSHashTable<CSMessageGestureAdapter *> *CSAdapters;
static NSHashTable<UIView *> *CSGestureCells;
static void CSObserveGestureCells(void);
// Verified native BOOL fields (artifact ivars.json), resolved once per binding.
// Read scalar state without KVC, service resolution or arbitrary native callbacks in admission.
static ptrdiff_t CSGestureFlagOffset(id object, const char *name) {
    Ivar field=class_getInstanceVariable(object_getClass(object),name);
    if (!field) return -1;
    const char *type=ivar_getTypeEncoding(field);
    if (!type || (strcmp(type,"B") && strcmp(type,"c"))) return -1;
    ptrdiff_t offset=ivar_getOffset(field);
    return offset>=0 && (size_t)offset<class_getInstanceSize(object_getClass(object)) ? offset : -1;
}
static BOOL CSGestureFlag(id object, ptrdiff_t offset) {
    if (!object || offset<0) return NO;
    unsigned char value=0;
    memcpy(&value,(const unsigned char *)(__bridge const void *)object+offset,1);
    return value!=0;
}
@interface CSMessageGestureAdapter ()
@property(nonatomic, weak) UIView *cell;
@property(nonatomic, strong) CSMessageActionCoordinator *coordinator;
@property(nonatomic, strong) UIPanGestureRecognizer *pan;
@property(nonatomic) NSUInteger bindingGeneration;
@property(nonatomic, strong) CSMessageActionSettings *settings;
@property(nonatomic, strong) CSMessageActionContext *context;
@property(nonatomic, strong) CSMessageActionContext *trackingContext;
@property(nonatomic, weak) UIView *region;
@property(nonatomic, weak) UIGestureRecognizer *pop;
@property(nonatomic, weak) UIScrollView *scroll;
@property(nonatomic) CSMessageAction leftAction, rightAction, lockedAction;
@property(nonatomic) CSMessageActionDirection direction;
@property(nonatomic) BOOL tracking, ownsTransform, detached, hapticSent, touchAccepted;
@property(nonatomic) CGFloat offset, width;
@property(nonatomic) ptrdiff_t disabledOffset, multiSelectOffset;
@property(nonatomic) CGAffineTransform baseline, applied;
@property(nonatomic, strong) UIImpactFeedbackGenerator *feedback;
@property(nonatomic, strong) UIViewPropertyAnimator *reboundAnimator;
@end
@implementation CSMessageGestureAdapter
- (instancetype)initWithCell:(UIView *)cell coordinator:(CSMessageActionCoordinator *)coordinator {
    if ((self=[super init])) {
        _cell=cell; _coordinator=coordinator; _bindingGeneration=1;
        _pan=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        _pan.delegate=self; _pan.maximumNumberOfTouches=1; _pan.minimumNumberOfTouches=1;
        _pan.cancelsTouchesInView=YES; _pan.delaysTouchesBegan=NO; _pan.delaysTouchesEnded=NO;
        [cell addGestureRecognizer:_pan];
        if (!CSAdapters) CSAdapters=[NSHashTable weakObjectsHashTable];
        [CSAdapters addObject:self];
        [self bind];
    }
    return self;
}
- (void)invalidateBinding {
    [self cancel]; [_coordinator cancelOperationsForCell:_cell];
    _bindingGeneration++; _context=nil; _leftAction=0; _rightAction=0; _pan.enabled=NO;
}
- (void)bind {
    [self invalidateBinding];
    _settings=_coordinator.settings;
    if (!_settings.gestureEnabled) { _region=nil; _pop=nil; _scroll=nil; return; }
    _context=[_coordinator captureContextForCell:_cell controller:nil bindingGeneration:_bindingGeneration];
    _disabledOffset=CSGestureFlagOffset(_cell,"m_bDisableAllOperation");
    _multiSelectOffset=CSGestureFlagOffset(_context.controller,"m_bMultiSelectMode");
    [self updateCapabilities];
}
- (void)updateCapabilities {
    _settings=_coordinator.settings; _leftAction=CSMessageActionDisabled; _rightAction=CSMessageActionDisabled;
    if (_context && _settings.gestureEnabled) {
        CSMessageAction left=CSMessageActionForDirection(_settings,CSMessageActionDirectionLeft,_context.outgoing);
        CSMessageAction right=CSMessageActionForDirection(_settings,CSMessageActionDirectionRight,_context.outgoing);
        if (left && [_coordinator canExecuteContext:_context action:left entry:CSMessageActionEntryGesture]) _leftAction=left;
        if (right && [_coordinator canExecuteContext:_context action:right entry:CSMessageActionEntryGesture]) _rightAction=right;
    }
    _pan.enabled=(_leftAction || _rightAction);
}
- (void)settingsDidChange {
    if (_settings.version==_coordinator.settings.version) return;
    if (!_coordinator.settings.gestureEnabled) {
        _settings=_coordinator.settings;
        [self invalidateBinding]; _region=nil; _pop=nil; _scroll=nil;
        return;
    }
    if (!_context) {
        if (!_cell.window) { _settings=_coordinator.settings; return; }
        [self bind];
    } else { [self cancel]; [self updateCapabilities]; }
    [self refreshForLayout];
}
- (void)refreshForLayout {
    if (!_settings.gestureEnabled || !_pan.enabled) return;
    UIView *cell=_cell;
    // Binding/activation refresh resolves services once. Repeated layouts only update geometry.
    UIView *region=CSMessageActionObjectGetter(cell,NSSelectorFromString(@"getBgImageView"));
    BOOL confirmedBubble=[region isKindOfClass:UIView.class] && !region.hidden && !CGRectIsEmpty(region.bounds);
    if (!confirmedBubble) region=CSMessageActionObjectGetter(cell,NSSelectorFromString(@"getContentView"));
    // Full-row content containers include avatars/blank space and are not an action region.
    if (![region isKindOfClass:UIView.class] || region==cell || region.hidden ||
        ![region isDescendantOfView:cell] || CGRectIsEmpty(region.bounds) || region.alpha<=.01 ||
        (!confirmedBubble && CGRectGetWidth(region.bounds)>=CGRectGetWidth(cell.bounds)*.95)) region=nil;
    _region=region;
    UIViewController *controller=_context.controller;
    _pop=controller.navigationController.interactivePopGestureRecognizer;
    _scroll=nil;
    for (UIView *view=cell.superview; view; view=view.superview) if ([view isKindOfClass:UIScrollView.class]) { _scroll=(UIScrollView *)view; break; }
    CGRect visible=CGRectIntersection(cell.bounds,[cell convertRect:cell.window.bounds fromView:cell.window]);
    _width=CGRectIsNull(visible) ? CGRectGetWidth(cell.bounds) : CGRectGetWidth(visible);
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldReceiveTouch:(UITouch *)touch {
    if (gesture!=_pan) return YES;
    _touchAccepted=NO;
    UIView *cell=_cell, *region=_region;
    if (!region || !cell.window || !_context.controller || !(_leftAction || _rightAction)) return NO;
    CGPoint point=[touch locationInView:cell];
    if (CSVoicePlaybackOwnsTouch(cell,point)) return NO;
    if (!CGRectContainsPoint([cell convertRect:region.bounds fromView:region],point)) return NO;
    for (UIView *view=touch.view; view && view!=cell; view=view.superview) {
        if ([view isKindOfClass:UIControl.class]) return NO;
        if ([view isKindOfClass:UIScrollView.class]) {
            UIScrollView *nested=(UIScrollView *)view;
            if (nested.scrollEnabled && nested.contentSize.width>CGRectGetWidth(nested.bounds)+1) return NO;
        }
    }
    _touchAccepted=YES; return YES;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gesture {
    if (gesture!=_pan) return YES;
    if (!_touchAccepted || !_context || !_region || !_cell.window || !_settings.gestureEnabled || _tracking) return NO;
    if (CSGestureFlag(_cell,_disabledOffset) || CSGestureFlag(_context.controller,_multiSelectOffset)) return NO;
    if ([_scroll isKindOfClass:UITableView.class] && ((UITableView *)_scroll).editing) return NO;
    CGPoint velocity=[_pan velocityInView:_cell], translation=[_pan translationInView:_cell];
    CGPoint intent=(fabs(velocity.x)+fabs(velocity.y)>0) ? velocity : translation;
    if (!CSMessageActionGestureHasHorizontalIntent(intent.x,intent.y)) return NO;
    CSMessageActionDirection direction=intent.x<0 ? CSMessageActionDirectionLeft : CSMessageActionDirectionRight;
    if (!(direction==CSMessageActionDirectionLeft ? _leftAction : _rightAction)) return NO;
    // The actual navigation recognizer gets first refusal, irrespective of class name.
    if (_pop && _pop.enabled && (_pop.state==UIGestureRecognizerStateBegan || _pop.state==UIGestureRecognizerStateChanged)) return NO;
    return YES;
}
- (BOOL)isContentCompetitor:(UIGestureRecognizer *)other {
    if (!other.view || !_region || !([other isKindOfClass:UITapGestureRecognizer.class] ||
        [other isKindOfClass:UILongPressGestureRecognizer.class])) return NO;
    if ([other.view isDescendantOfView:_region]) return YES;
    // Native content taps may be installed on the cell rather than its bubble.
    return other.view==_cell && CGRectContainsPoint([_cell convertRect:_region.bounds fromView:_region],
        [other locationInView:_cell]);
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)other {
    return gesture==_pan && other==_pop && _pop.enabled;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)other {
    return gesture==_pan && [self isContentCompetitor:other];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)other {
    if (gesture!=_pan) return NO;
    if (other==_pop || other==_scroll.panGestureRecognizer || [self isContentCompetitor:other]) return NO;
    return YES;
}
- (BOOL)removeOwnedTransform {
    if (!_ownsTransform) return YES;
    _ownsTransform=NO;
    if (!CGAffineTransformEqualToTransform(_cell.transform,_applied)) return NO;
    _cell.transform=_baseline; return YES;
}
- (void)stopRebound {
    if (_reboundAnimator.state==UIViewAnimatingStateActive) {
        // Stop only our animator and preserve the current model transform, including
        // a host value installed since Ended. Never inherit an intermediate presentation value.
        UIView *cell=_cell; CGAffineTransform model=cell.transform;
        [_reboundAnimator stopAnimation:YES];
        if (!CGAffineTransformEqualToTransform(cell.transform,model)) cell.transform=model;
    }
    _reboundAnimator=nil;
}
- (void)clearTracking {
    _tracking=NO; _detached=NO; _trackingContext=nil; _feedback=nil;
    _offset=0; _direction=CSMessageActionDirectionNone; _touchAccepted=NO;
}
- (void)cancel {
    [self stopRebound]; [self removeOwnedTransform]; [self clearTracking];
}
- (void)detachForLayout {
    [self stopRebound];
    if (!_tracking) return;
    if (![self removeOwnedTransform]) { [self cancel]; return; }
    _detached=YES;
}
- (void)applyOffset {
    _applied=_baseline; _applied.tx+=_offset; // translation in cell-parent coordinates, preserve native scale/rotation
    _cell.transform=_applied; _ownsTransform=YES;
}
- (void)reattachAfterLayout {
    if (!_tracking || !_detached) return;
    _detached=NO;
    // Native transform ownership changed while we were detached. Do not overlay a stale drag.
    if (!CGAffineTransformEqualToTransform(_cell.transform,_baseline)) { [self cancel]; return; }
    [self applyOffset];
}
- (void)handlePan:(UIPanGestureRecognizer *)pan {
    if (pan!=_pan) return;
    CGPoint translation=[pan translationInView:_cell], velocity=[pan velocityInView:_cell];
    if (pan.state==UIGestureRecognizerStateBegan) {
        if (![self gestureRecognizerShouldBegin:pan]) { [self cancel]; return; }
        [self stopRebound];
        _direction=(velocity.x ? velocity.x : translation.x)<0 ? CSMessageActionDirectionLeft : CSMessageActionDirectionRight;
        _lockedAction=_direction==CSMessageActionDirectionLeft ? _leftAction : _rightAction;
        _trackingContext=_context; _tracking=YES; _hapticSent=NO; _baseline=_cell.transform;
        _feedback=[[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium]; [_feedback prepare];
    }
    if (!_tracking) return;
    if (pan.state==UIGestureRecognizerStateCancelled || pan.state==UIGestureRecognizerStateFailed) { [self cancel]; return; }
    if (_ownsTransform && !CGAffineTransformEqualToTransform(_cell.transform,_applied)) { [self cancel]; return; }
    if (pan.state==UIGestureRecognizerStateBegan || pan.state==UIGestureRecognizerStateChanged) {
        _offset=translation.x*_direction>0 ? translation.x*.5 : 0;
        [self applyOffset];
        if (!_hapticSent && CSMessageActionGestureIsArmed(translation.x,velocity.x,_width,_direction)) {
            _hapticSent=YES; [_feedback impactOccurred];
        }
        return;
    }
    if (pan.state!=UIGestureRecognizerStateEnded) return;
    CSMessageActionContext *context=_trackingContext;
    CSMessageAction action=_lockedAction;
    BOOL commit=CSMessageActionGestureShouldCommit(CSMessageActionGesturePhaseEnded,translation.x,velocity.x,_width,_direction,
        context && context.bindingGeneration==_bindingGeneration && !CSGestureFlag(_cell,_disabledOffset) &&
        !CSGestureFlag(context.controller,_multiSelectOffset),_settings.gestureEnabled);
    // Model geometry is restored before facade handoff. UIKit animates only this owned transform.
    if (_ownsTransform && !UIAccessibilityIsReduceMotionEnabled()) {
        __weak typeof(self) weakSelf=self;
        _reboundAnimator=[[UIViewPropertyAnimator alloc] initWithDuration:.2 curve:UIViewAnimationCurveEaseOut
            animations:^{ [weakSelf removeOwnedTransform]; }];
        [_reboundAnimator startAnimation];
    }
    [self removeOwnedTransform]; [self clearTracking];
    if (commit) [_coordinator executeContext:context action:action entry:CSMessageActionEntryGesture];
    // No cell access after handoff: repeat/native forwarding owns its immutable request.
}
@end
static void CSObserveGestureCells(void) {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        CSGestureCells=[NSHashTable weakObjectsHashTable];
        // One observer also covers cells that have never needed a gesture adapter.
        [NSNotificationCenter.defaultCenter addObserverForName:CSMessageActionSettingsDidChangeNotification
            object:nil queue:NSOperationQueue.mainQueue usingBlock:^(__unused NSNotification *note) {
            for (UIView *cell in CSGestureCells.allObjects) {
                CSMessageGestureAdapter *adapter=objc_getAssociatedObject(cell,&CSAdapterKey);
                if (adapter) [adapter settingsDidChange];
                else if (cell.window) [CSMessageGestureAdapterForCell(cell,YES) refreshForLayout];
            }
        }];
    });
}
CSMessageGestureAdapter *CSMessageGestureAdapterForCell(id cell, BOOL create) {
    CSMessageGestureAdapter *adapter=objc_getAssociatedObject(cell,&CSAdapterKey);
    if (create && [cell isKindOfClass:UIView.class]) {
        CSObserveGestureCells(); [CSGestureCells addObject:cell];
    }
    if (!adapter && create && [cell isKindOfClass:UIView.class] && CSMessageActionCoordinator.sharedCoordinator.settings.gestureEnabled) {
        adapter=[[CSMessageGestureAdapter alloc] initWithCell:cell coordinator:CSMessageActionCoordinator.sharedCoordinator];
        objc_setAssociatedObject(cell,&CSAdapterKey,adapter,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return adapter;
}
void CSMessageGestureCancelForController(id controller) {
    for (CSMessageGestureAdapter *adapter in CSAdapters) if (adapter.context.controller==controller) [adapter cancel];
}
void CSMessageGestureAccountBoundary(void) {
    // Native hook thread calls the coordinator atomic marker first; UIKit cleanup stays on main.
    dispatch_async(dispatch_get_main_queue(), ^{
        for (CSMessageGestureAdapter *adapter in CSAdapters) { [adapter invalidateBinding]; if (adapter.cell.window) [adapter bind]; }
    });
}
