#!/usr/bin/env python3
"""Extract production gesture methods; execute with host doubles, without WeChat or preferences writes."""
from pathlib import Path
import subprocess, tempfile, hashlib, json
root=Path(__file__).resolve().parents[3]
source=root/'Hooks/MessageGestureHooks.xm'
s=source.read_text()
def method(signature):
    start=s.index(signature+' {'); begin=s.index('{', start); depth=0
    for i in range(begin,len(s)):
        if s[i]=='{': depth+=1
        elif s[i]=='}':
            depth-=1
            if depth==0:return s[start:i+1]
    raise ValueError(signature)
preamble=r"""
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <objc/runtime.h>
#include <math.h>
typedef NS_ENUM(NSInteger,WCHookSwipeDirection) { WCHookSwipeDirectionLeft,WCHookSwipeDirectionRight,WCHookSwipeDirectionNone };
typedef NS_ENUM(NSInteger,WCSwipeAction) { WCSwipeActionDisabled,WCSwipeActionQuote,WCSwipeActionDelete,WCSwipeActionForward,WCSwipeActionFavorite,WCSwipeActionRevoke,WCSwipeActionRepeat };
typedef NS_ENUM(NSInteger,UIGestureRecognizerState) { UIGestureRecognizerStatePossible,UIGestureRecognizerStateBegan,UIGestureRecognizerStateChanged,UIGestureRecognizerStateEnded,UIGestureRecognizerStateCancelled,UIGestureRecognizerStateFailed };
static NSString *kLeftSwipeOtherActionKey=@"leftOther", *kLeftSwipeSelfActionKey=@"leftSelf", *kRightSwipeOtherActionKey=@"rightOther", *kRightSwipeSelfActionKey=@"rightSelf";
static NSUInteger reads;
static BOOL isMessageGestureEnabled(void) { reads++;return YES; }
// Only left-swipe-other is enabled. No real NSUserDefaults calls or messages sent.
static WCSwipeAction getSwipeAction(NSString *key) { reads++;return [key isEqual:kLeftSwipeOtherActionKey] ? WCSwipeActionRepeat : WCSwipeActionDisabled; }
@interface UIGestureRecognizer:NSObject
@property(nonatomic) UIGestureRecognizerState state;
@end
@implementation UIGestureRecognizer @end
@interface UIPanGestureRecognizer:UIGestureRecognizer
@property(nonatomic) CGPoint translation,velocity;
- (CGPoint)translationInView:(id)view;
- (CGPoint)velocityInView:(id)view;
@end
@implementation UIPanGestureRecognizer
- (CGPoint)translationInView:(id)view { return self.translation; }
- (CGPoint)velocityInView:(id)view { return self.velocity; }
@end
@interface UIImpactFeedbackGenerator:NSObject
@property(nonatomic) NSUInteger impacts;
- (void)prepare;
- (void)impactOccurred;
@end
@implementation UIImpactFeedbackGenerator
- (void)prepare {}
- (void)impactOccurred { self.impacts++; }
@end
static const NSUInteger UIViewAnimationOptionCurveEaseOut=0;
@interface UIView:NSObject
@property(nonatomic) CGRect bounds;
@property(nonatomic) CGAffineTransform transform;
+ (void)animateWithDuration:(double)duration delay:(double)delay options:(NSUInteger)options animations:(void (^)(void))animations completion:(void (^)(BOOL))completion;
@end
@implementation UIView
+ (void)animateWithDuration:(double)duration delay:(double)delay options:(NSUInteger)options animations:(void (^)(void))animations completion:(void (^)(BOOL))completion { animations(); }
@end
@interface Cell:UIView
@property(nonatomic,strong) UIPanGestureRecognizer *wchook_swipeGesture;
@property(nonatomic,strong) UIImpactFeedbackGenerator *wchook_feedbackGenerator;
@property(nonatomic) BOOL wchook_feedbackTriggered;
@property(nonatomic) NSInteger wchook_swipeTriggerStage;
@property(nonatomic) NSUInteger actions;
@property(nonatomic) WCHookSwipeDirection direction;
- (void)wchook_resetSwipeAnimated:(BOOL)animated;
- (void)wchook_handleSwipe:(UIPanGestureRecognizer *)gesture;
- (void)wchook_triggerActionForDirection:(WCHookSwipeDirection)direction;
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer;
@end
@implementation Cell
- (void)wchook_triggerActionForDirection:(WCHookSwipeDirection)direction { self.actions++;self.direction=direction; }
"""
methods='\n'.join(method(x) for x in [
'- (void)wchook_handleSwipe:(UIPanGestureRecognizer *)gesture',
'- (void)wchook_resetSwipeAnimated:(BOOL)animated',
'- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer'])
main=r"""
@end
static BOOL firstIMP(id obj,SEL cmd,id a,id b) { return NO; }
static BOOL secondIMP(id obj,SEL cmd,id a,id b) { return YES; }
int main(void) { @autoreleasepool {
    Cell *c=[Cell new]; c.bounds=CGRectMake(0,0,300,100);c.transform=CGAffineTransformIdentity;
    UIPanGestureRecognizer *g=[UIPanGestureRecognizer new];c.wchook_swipeGesture=g;c.wchook_feedbackGenerator=[UIImpactFeedbackGenerator new];
    g.translation=CGPointMake(0,30);g.velocity=CGPointMake(0,700);
    printf("vertical_should_begin=%d (expected 0)\n",[c gestureRecognizerShouldBegin:g]);
    g.translation=CGPointMake(30,0);g.velocity=CGPointMake(700,0);
    printf("disabled_right_should_begin=%d (expected 0)\n",[c gestureRecognizerShouldBegin:g]);
    g.translation=CGPointMake(-70,0);g.velocity=CGPointZero;g.state=UIGestureRecognizerStateCancelled;
    [c wchook_handleSwipe:g];printf("cancelled_dispatches=%lu (expected 0)\n",(unsigned long)c.actions);
    c.actions=0;g.state=UIGestureRecognizerStateChanged;g.translation=CGPointMake(-30,0);[c wchook_handleSwipe:g];
    g.state=UIGestureRecognizerStateFailed;[c wchook_handleSwipe:g];
    printf("failed_transform_tx=%.1f (expected 0)\n",c.transform.tx);
    [c wchook_resetSwipeAnimated:NO];g.state=UIGestureRecognizerStateChanged;g.translation=CGPointMake(-45,0);[c wchook_handleSwipe:g];
    g.state=UIGestureRecognizerStateEnded;[c wchook_handleSwipe:g];
    printf("subthreshold_haptics=%lu,dispatches=%lu (threshold=60,displacement=45)\n",(unsigned long)c.wchook_feedbackGenerator.impacts,(unsigned long)c.actions);
    c.actions=0;g.state=UIGestureRecognizerStateEnded;g.translation=CGPointMake(-10,0);g.velocity=CGPointMake(700,0);[c wchook_handleSwipe:g];
    printf("reverse_velocity_dispatches=%lu,direction=%ld (left=0,right=1)\n",(unsigned long)c.actions,(long)c.direction);
    reads=0;g.state=UIGestureRecognizerStateChanged;g.translation=CGPointMake(-20,0);
    for(int i=0;i<1000;i++)[c wchook_handleSwipe:g];
    printf("1000_changed_configuration_reads=%lu (first action enabled; last-action-only would read more)\n",(unsigned long)reads);
    Class cls=objc_allocateClassPair(NSObject.class,"AuditDelegateCollision",0);objc_registerClassPair(cls);
    SEL sel=sel_registerName("gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:");
    BOOL first=class_addMethod(cls,sel,(IMP)firstIMP,"B@:@@");BOOL second=class_addMethod(cls,sel,(IMP)secondIMP,"B@:@@");
    printf("duplicate_delegate_registration_first=%d,second=%d (second implementation is not installed)\n",first,second);
} return 0; }
"""
with tempfile.TemporaryDirectory(prefix='wechat-gesture-audit-') as tmp:
    tmp=Path(tmp); (tmp/'audit.m').write_text(preamble+methods+main)
    subprocess.run(['xcrun','--sdk','macosx','clang','-fobjc-arc','-fblocks','-framework','Foundation','-framework','CoreGraphics',str(tmp/'audit.m'),'-o',str(tmp/'audit')],check=True)
    subprocess.run([str(tmp/'audit')],check=True)
print('source_sha256='+hashlib.sha256(source.read_bytes()).hexdigest())
