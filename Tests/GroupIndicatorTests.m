#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import <math.h>
#import "../Controllers/CSGroupAppearance.h"
// Redirect only this host replay to an isolated preference suite.
static NSUserDefaults *testDefaults;
@interface IndicatorTestDefaults : NSUserDefaults
@end
@implementation IndicatorTestDefaults
+ (NSUserDefaults *)standardUserDefaults { return testDefaults; }
@end
static NSUInteger viewportAnimations;
@interface NSValue (UIKitGeometry)
+ (instancetype)valueWithCGPoint:(CGPoint)value;
+ (instancetype)valueWithCGSize:(CGSize)value;
- (CGPoint)CGPointValue;
- (CGSize)CGSizeValue;
@end
@implementation NSValue (UIKitGeometry)
+ (instancetype)valueWithCGPoint:(CGPoint)value { return [self valueWithBytes:&value objCType:@encode(CGPoint)]; }
+ (instancetype)valueWithCGSize:(CGSize)value { return [self valueWithBytes:&value objCType:@encode(CGSize)]; }
- (CGSize)CGSizeValue { CGSize size; [self getValue:&size size:sizeof(size)]; return size; }
- (CGPoint)CGPointValue { CGPoint point; [self getValue:&point size:sizeof(point)]; return point; }
@end
static BOOL reducedMotion;
static BOOL UIAccessibilityIsReduceMotionEnabled(void) { return reducedMotion; }
static CGFloat const kIndicatorHeight=2;
static NSTimeInterval const kIndicatorDuration=0.20;
static NSString *const kIndicatorAnimationKey=@"CSGroupIndicator.selection";
#include "GroupCapsuleHelpers.h"
enum { UIViewAnimationOptionCurveEaseInOut=1, UIViewAnimationOptionBeginFromCurrentState=2, UIViewAnimationOptionAllowUserInteraction=4 };
@interface TestLayer : CALayer
@property(nonatomic,strong) NSMutableDictionary *savedAnimations;
@property(nonatomic,strong) CALayer *visibleLayer;
@property(nonatomic) NSUInteger animationAdds;
@end
@implementation TestLayer
- (instancetype)init { if ((self=[super init])) _savedAnimations=[NSMutableDictionary dictionary]; return self; }
- (instancetype)presentationLayer { return (id)self.visibleLayer; }
- (CAAnimation *)animationForKey:(NSString *)key { return self.savedAnimations[key]; }
- (void)addAnimation:(CAAnimation *)animation forKey:(NSString *)key { self.savedAnimations[key]=animation; self.animationAdds++; }
- (void)removeAnimationForKey:(NSString *)key { [self.savedAnimations removeObjectForKey:key]; }
@end
@interface UIView : NSObject
@property(nonatomic,strong) TestLayer *layer;
@property(nonatomic) BOOL hidden;
@property(nonatomic,strong) id window;
@property(nonatomic) CGRect frame,bounds;
@property(nonatomic) CGPoint contentOffset;
@property(nonatomic) CGSize contentSize;
@property(nonatomic) NSUInteger scrollWrites;
- (void)setNeedsLayout;
- (void)removeFromSuperview;
- (void)insertSubview:(UIView *)view belowSubview:(UIView *)sibling;
- (void)layoutIfNeeded;
- (void)setContentOffset:(CGPoint)offset animated:(BOOL)animated;
+ (void)animateWithDuration:(double)duration delay:(double)delay options:(NSUInteger)options animations:(void (^)(void))animations completion:(void (^)(BOOL))completion;
@end
@implementation UIView
- (instancetype)init { if ((self=[super init])) _layer=[TestLayer layer]; return self; }
- (CGRect)frame { return self.layer.frame; }
- (void)setFrame:(CGRect)frame { self.layer.frame=frame; }
- (void)layoutIfNeeded {}
- (void)setNeedsLayout {}
- (void)removeFromSuperview {}
- (void)insertSubview:(UIView *)view belowSubview:(UIView *)sibling { (void)view; (void)sibling; }
- (void)setContentOffset:(CGPoint)offset animated:(BOOL)animated { (void)animated; self.contentOffset=offset; self.scrollWrites++; }
+ (void)animateWithDuration:(double)duration delay:(double)delay options:(NSUInteger)options animations:(void (^)(void))animations completion:(void (^)(BOOL))completion {
    (void)duration; (void)delay; (void)options; viewportAnimations++; animations(); if (completion) completion(YES);
}
@end
@interface UIColor : NSObject
@property(nonatomic,readonly) CGColorRef CGColor;
@end
@implementation UIColor
- (CGColorRef)CGColor { return CGColorGetConstantColor(kCGColorWhite); }
@end
enum { NSTextAlignmentCenter=1 };
@interface UILabel : UIView
@property(nonatomic) BOOL isAccessibilityElement,userInteractionEnabled;
@property(nonatomic) NSInteger textAlignment;
@property(nonatomic,strong) UIColor *textColor;
@end
@implementation UILabel @end
@interface WETabButton : UIView
@property(nonatomic) NSInteger tabIndex;
@property(nonatomic,copy) NSString *tabID;
@property(nonatomic,strong) TestLayer *capsuleLayer;
@property(nonatomic,strong) UILabel *capsuleTitleLabel;
@property(nonatomic,strong) UIView *titleLabel;
@property(nonatomic,strong) UIView *unreadBadge;
@property(nonatomic) BOOL capsuleEnabled;
@property(nonatomic) CGFloat capsuleProgress;
- (void)setCapsuleProgress:(CGFloat)progress animated:(BOOL)animated;
- (void)configureCapsuleEnabled:(BOOL)enabled color:(UIColor *)color textColor:(UIColor *)textColor;
- (CGRect)tabTitleFrame;
@end
@implementation WETabButton
- (CGRect)tabTitleFrame { return CGRectMake(20,12,40,20); }
#define CALayer TestLayer
#include "GroupCapsuleButtonBody.h"
#undef CALayer
@end
@interface WESessionTabContainerView : UIView
@property(nonatomic) NSInteger selectedIndex;
@property(nonatomic,copy) NSString *selectedTabID;
@property(nonatomic,strong) NSArray<WETabButton *> *tabButtons;
@property(nonatomic,strong) UIView *indicatorView,*scrollView;
@property(nonatomic) NSUInteger haptics;
@property(nonatomic) BOOL interactiveTransition,settlingInteractiveTransition;
@property(nonatomic) NSInteger interactiveTarget;
@property(nonatomic) CGFloat interactiveProgress;
@property(nonatomic) CSGroupIndicatorStyle indicatorStyle;
- (void)updateCapsuleSelectionAnimated:(BOOL)animated;
- (CGRect)indicatorFrameForIndex:(NSInteger)index;
- (void)updateInteractiveTransitionToIndex:(NSInteger)index progress:(CGFloat)progress;
- (void)cancelInteractiveTransition;
- (void)selectTabAtIndex:(NSInteger)index animated:(BOOL)animated;
- (void)updateIndicatorPosition;
- (void)updateIndicatorPositionAnimated:(BOOL)animated;
- (void)moveIndicatorToFrame:(CGRect)frame animated:(BOOL)animated;
- (void)scrollToSelectedTab;
@end
@implementation WESessionTabContainerView
#define NSUserDefaults IndicatorTestDefaults
#include "GroupIndicatorBodies.h"
#undef NSUserDefaults
- (void)triggerHapticFeedback { self.haptics++; }
- (void)updateSelectedButtons {}
@end
static NSUInteger checks,failures;
static void Check(BOOL c,NSString *message) { checks++; if (!c) { failures++; fprintf(stderr,"FAIL: %s\n",message.UTF8String); } }
static WESessionTabContainerView *Fixture(void) {
    WESessionTabContainerView *view=[WESessionTabContainerView new];
    view.window=[NSObject new]; view.indicatorView=[UIView new]; view.scrollView=[UIView new];
    view.indicatorStyle=CSGroupCurrentIndicatorStyle(testDefaults);
    view.scrollView.bounds=CGRectMake(0,0,160,52); view.scrollView.contentSize=CGSizeMake(300,52);
    NSMutableArray *buttons=[NSMutableArray array];
    for (NSInteger i=0;i<3;i++) {
        WETabButton *button=[WETabButton new]; button.frame=CGRectMake(i*100,0,80,52);
        button.bounds=CGRectMake(0,0,80,52); button.tabIndex=i; button.tabID=[NSString stringWithFormat:@"tab%ld",(long)i];
        button.titleLabel=[UIView new]; button.unreadBadge=[UIView new];
        if (view.indicatorStyle==CSGroupIndicatorStyleCapsule) {
            [button configureCapsuleEnabled:YES color:[UIColor new] textColor:[UIColor new]];
        }
        [buttons addObject:button];
    }
    view.tabButtons=buttons; view.selectedIndex=0; view.selectedTabID=@"tab0";
    [view updateIndicatorPositionAnimated:NO]; return view;
}
int main(void) { @autoreleasepool {
    NSString *suite=[@"com.wechat.improve.tests.indicator." stringByAppendingString:NSUUID.UUID.UUIDString];
    testDefaults=[[NSUserDefaults alloc] initWithSuiteName:suite];
    Check(CSGroupCurrentIndicatorStyle(testDefaults)==CSGroupIndicatorStyleUnderline,@"fresh install preserves the original underline style");
    Check(![testDefaults objectForKey:CSGroupIndicatorStyleKey],@"reading preferences does not migrate or write user data");
    [testDefaults setInteger:2 forKey:@"com.wechat.enhance.chat_group.indicator_animation_style"];
    Check(CSGroupCurrentIndicatorStyle(testDefaults)==CSGroupIndicatorStyleUnderline,@"abandoned animation choices cannot silently opt into capsule");
    for (NSNumber *legacy in @[@YES,@NO]) {
        [testDefaults setBool:legacy.boolValue forKey:CSGroupIndicatorAnimationEnabledKey];
        CSGroupIndicatorStyle expected=legacy.boolValue?CSGroupIndicatorStyleUnderline:CSGroupIndicatorStyleNone;
        for (id invalid in @[@"2",@(-1),@3,@1.5,@(NAN),@{},@[]]) {
            [testDefaults setObject:invalid forKey:CSGroupIndicatorStyleKey];
            Check(CSGroupCurrentIndicatorStyle(testDefaults)==expected,@"invalid new preferences preserve the old on/off choice");
        }
    }
    for (NSNumber *style in @[@0,@1,@2]) {
        CSGroupSetIndicatorStyle(testDefaults,style.integerValue);
        Check(CSGroupCurrentIndicatorStyle([[NSUserDefaults alloc] initWithSuiteName:suite])==style.integerValue,@"each style survives a new preference instance");
        Check([testDefaults boolForKey:CSGroupIndicatorAnimationEnabledKey]==(style.integerValue!=0),@"legacy boolean remains compatible with downgrades");
    }
    CSGroupSetIndicatorStyle(testDefaults,(CSGroupIndicatorStyle)99);
    Check(CSGroupCurrentIndicatorStyle(testDefaults)==CSGroupIndicatorStyleCapsule,@"invalid selections do not overwrite the saved style");
    [testDefaults removeObjectForKey:CSGroupIndicatorStyleKey];
    [testDefaults removeObjectForKey:CSGroupIndicatorAnimationEnabledKey];
    Check(CSGroupIndicatorAnimationEnabled(testDefaults),@"unset preference preserves enabled animation by default");
    [testDefaults setObject:@"invalid" forKey:CSGroupIndicatorAnimationEnabledKey];
    Check(CSGroupIndicatorAnimationEnabled(testDefaults),@"invalid stored preference falls back to enabled");
    [testDefaults removeObjectForKey:CSGroupIndicatorAnimationEnabledKey];
    WESessionTabContainerView *v=Fixture();
    [v selectTabAtIndex:1 animated:YES];
    CAAnimationGroup *first=(id)[v.indicatorView.layer animationForKey:kIndicatorAnimationKey];
    Check(first!=nil && fabs(first.duration-0.20)<0.001,@"user selection starts the intended transition");
    Check(v.selectedIndex==1 && [v.selectedTabID isEqual:@"tab1"],@"selection commits immediately without waiting for animation");
    NSUInteger adds=v.indicatorView.layer.animationAdds,haptics=v.haptics,scrolls=v.scrollView.scrollWrites;
    for (NSUInteger i=0;i<4;i++) { v.selectedTabID=@"tab1"; [v updateIndicatorPosition]; [v scrollToSelectedTab]; }
    Check([v.indicatorView.layer animationForKey:kIndicatorAnimationKey]==first,@"projection refresh and same-ID acknowledgement preserve the transition");
    Check(v.indicatorView.layer.animationAdds==adds && v.haptics==haptics,@"repeated publication neither restarts the animation nor repeats haptics");
    Check(v.scrollView.scrollWrites==scrolls,@"unchanged selected scroll target is not rewritten during animation");
    CALayer *visible=[CALayer layer]; visible.frame=CGRectMake(65,45,62,2);
    v.indicatorView.layer.visibleLayer=visible;
    [v selectTabAtIndex:2 animated:YES];
    CAAnimationGroup *next=(id)[v.indicatorView.layer animationForKey:kIndicatorAnimationKey];
    CAKeyframeAnimation *position=(id)next.animations[0];
    CGPoint start=[position.values[0] CGPointValue];
    Check(fabs(start.x-CGRectGetMidX(visible.frame))<0.001,@"rapid selection continues from the visible position");
    CGPoint end=[position.values.lastObject CGPointValue];
    Check(fabs(end.x-CGRectGetMidX(v.indicatorView.layer.frame))<0.001,@"model geometry already equals the final destination");
    CGRect oldTarget=v.indicatorView.layer.frame;
    WETabButton *button=v.tabButtons[2]; CGRect shifted=button.frame; shifted.origin.x+=18; button.frame=shifted;
    [v updateIndicatorPosition];
    Check(CGRectGetMinX(v.indicatorView.layer.frame)==CGRectGetMinX(oldTarget)+18 && v.indicatorView.layer.animationAdds==adds+2,@"changed badge/layout geometry retargets the moving indicator");
    reducedMotion=YES; [v selectTabAtIndex:0 animated:YES];
    Check(![v.indicatorView.layer animationForKey:kIndicatorAnimationKey] && v.selectedIndex==0,@"reduce motion commits immediately and cancels movement");
    reducedMotion=NO; v=Fixture(); v.window=nil; [v selectTabAtIndex:2 animated:YES];
    Check(![v.indicatorView.layer animationForKey:kIndicatorAnimationKey],@"offscreen selection does not animate");
    v=Fixture(); v.indicatorView.hidden=YES; [v selectTabAtIndex:1 animated:YES];
    Check(![v.indicatorView.layer animationForKey:kIndicatorAnimationKey],@"first reveal does not fly in from stale geometry");
    v=Fixture(); [v selectTabAtIndex:2 animated:YES]; v.selectedIndex=NSNotFound; [v updateIndicatorPosition];
    Check(v.indicatorView.hidden && ![v.indicatorView.layer animationForKey:kIndicatorAnimationKey],@"removing all tabs hides the indicator and clears animation");
    v=Fixture(); [v selectTabAtIndex:1 animated:YES]; [v selectTabAtIndex:0 animated:NO];
    Check(v.selectedIndex==0 && ![v.indicatorView.layer animationForKey:kIndicatorAnimationKey],@"a genuinely different nonanimated selection can cancel and restore selection");
    v=Fixture(); [v selectTabAtIndex:-1 animated:YES]; [v selectTabAtIndex:8 animated:YES];
    Check(v.selectedIndex==0 && v.indicatorView.layer.animationAdds==0,@"invalid selection does not animate or alter selection");
    v=Fixture(); [v selectTabAtIndex:1 animated:YES];
    [testDefaults setBool:NO forKey:CSGroupIndicatorAnimationEnabledKey];
    Check(!CSGroupIndicatorAnimationEnabled([[NSUserDefaults alloc] initWithSuiteName:suite]),@"disabled preference survives a fresh preferences instance");
    v.selectedTabID=@"tab1";
    Check(![v.indicatorView.layer animationForKey:kIndicatorAnimationKey] && v.selectedIndex==1,@"settings refresh cancels in-flight animation even for the same selected ID");
    NSUInteger viewportBefore=viewportAnimations;
    [v selectTabAtIndex:2 animated:YES];
    Check(v.selectedIndex==2 && ![v.indicatorView.layer animationForKey:kIndicatorAnimationKey] && viewportAnimations==viewportBefore,@"disabled switch commits taps/swipes without indicator or label viewport animation");
    Check(fabs(CGRectGetMidX(v.indicatorView.frame)-240)<0.001 && v.scrollView.contentOffset.x==140,@"disabled animation still places the indicator and reveals the selected tab");
    [testDefaults setBool:YES forKey:CSGroupIndicatorAnimationEnabledKey];
    [v selectTabAtIndex:0 animated:YES];
    Check([v.indicatorView.layer animationForKey:kIndicatorAnimationKey]!=nil,@"reenabling the switch restores the next selection animation");
    [testDefaults setBool:NO forKey:CSGroupIndicatorAnimationEnabledKey];
    [v updateIndicatorPosition];
    Check(![v.indicatorView.layer animationForKey:kIndicatorAnimationKey],@"layout refresh cannot retain an animation after disabling");
    [testDefaults setBool:YES forKey:CSGroupIndicatorAnimationEnabledKey];
    reducedMotion=YES; [v selectTabAtIndex:1 animated:YES];
    Check(![v.indicatorView.layer animationForKey:kIndicatorAnimationKey],@"system reduce motion overrides the enabled switch");
    reducedMotion=NO; v=Fixture();
    CGRect origin=v.indicatorView.frame;
    [v updateInteractiveTransitionToIndex:1 progress:0.25];
    Check(v.interactiveTransition && v.selectedIndex==0 && v.haptics==0,@"drag preview never commits selection or sends haptics");
    Check(fabs(CGRectGetMidX(v.indicatorView.frame)-65)<0.001 && ![v.indicatorView.layer animationForKey:kIndicatorAnimationKey],@"quarter drag moves immediately with no queued animation");
    [v updateInteractiveTransitionToIndex:1 progress:0.5];
    Check(fabs(v.indicatorView.frame.size.width-origin.size.width*0.30)<0.001,@"mid-drag contracts to 30 percent of normal width");
    CGRect mid=v.indicatorView.frame; [v updateIndicatorPosition];
    Check(CGRectEqualToRect(mid,v.indicatorView.frame),@"ordinary layout keeps interactive progress");
    [v updateInteractiveTransitionToIndex:1 progress:0.1];
    Check(CGRectGetMidX(v.indicatorView.frame)<CGRectGetMidX(mid),@"reversing the finger reverses the indicator immediately");
    [v cancelInteractiveTransition];
    Check(!v.interactiveTransition && v.selectedIndex==0 && CGRectEqualToRect(v.indicatorView.frame,origin),@"cancel restores original group without committing a switch");
    v=Fixture(); [v updateInteractiveTransitionToIndex:1 progress:0.5];
    mid=v.indicatorView.frame; [v selectTabAtIndex:1 animated:YES];
    next=(id)[v.indicatorView.layer animationForKey:kIndicatorAnimationKey]; position=(id)next.animations[0];
    Check(!v.interactiveTransition && v.selectedIndex==1 && fabs([position.values[0] CGPointValue].x-CGRectGetMidX(mid))<0.001,@"commit settles from finger position without snapping back");
    CAKeyframeAnimation *settleSize=(id)next.animations[1];
    Check(settleSize.values.count==2 && fabs([settleSize.values.firstObject CGSizeValue].width-mid.size.width)<0.001 &&
        fabs([settleSize.values.lastObject CGSizeValue].width-origin.size.width)<0.001,@"release restores normal width without a second expansion peak");
    v=Fixture();
    BOOL bounded=YES;
    for (NSUInteger step=0;step<=20;step++) {
        [v updateInteractiveTransitionToIndex:1 progress:step/20.0];
        CGFloat ratio=v.indicatorView.frame.size.width/origin.size.width;
        bounded &= ratio>=0.30-0.001 && ratio<=1.001;
    }
    Check(bounded,@"entire drag stays between 30 and 100 percent of normal width");
    [v updateInteractiveTransitionToIndex:1 progress:0.5]; [v cancelInteractiveTransition];
    CAAnimationGroup *cancel=(id)[v.indicatorView.layer animationForKey:kIndicatorAnimationKey];
    Check([(CAKeyframeAnimation *)cancel.animations[1] values].count==2 && v.selectedIndex==0,@"cancel returns to the original group without extra stretch");
    v=Fixture(); [v updateInteractiveTransitionToIndex:1 progress:2];
    Check(fabs(CGRectGetMidX(v.indicatorView.frame)-140)<0.001 && fabs(v.indicatorView.frame.size.width-origin.size.width)<0.001,@"full drag clamps at target and contracts to final width");
    [testDefaults setBool:NO forKey:CSGroupIndicatorAnimationEnabledKey]; [v updateIndicatorPosition];
    Check(!v.interactiveTransition && CGRectEqualToRect(v.indicatorView.frame,origin),@"disabling animation during drag clears preview");
    [v updateInteractiveTransitionToIndex:1 progress:0.5];
    Check(!v.interactiveTransition && v.selectedIndex==0,@"disabled animation never previews a drag");
    [testDefaults setBool:YES forKey:CSGroupIndicatorAnimationEnabledKey]; reducedMotion=YES;
    [v updateInteractiveTransitionToIndex:1 progress:0.5];
    Check(!v.interactiveTransition,@"reduce motion also suppresses interactive stretch");
    reducedMotion=NO; [v updateInteractiveTransitionToIndex:99 progress:0.5];
    Check(!v.interactiveTransition,@"invalid adjacent target is ignored");

    CSGroupSetIndicatorStyle(testDefaults,CSGroupIndicatorStyleCapsule);
    v=Fixture();
    WETabButton *a=v.tabButtons[0], *b=v.tabButtons[1], *c=v.tabButtons[2];
    Check(v.indicatorView.hidden && a.capsuleLayer.opacity==1 && b.capsuleLayer.opacity==0,@"capsule first layout has exactly one selected background and no underline");
    Check(!a.capsuleLayer.animationAdds && !b.capsuleLayer.animationAdds,@"first layout does not animate");
    CGRect title=CGRectMake(20,12,40,20), bounds=CGRectMake(0,0,80,52);
    CGRect capsule=CSGroupCapsuleFrame(title,bounds);
    Check(CGRectContainsRect(capsule,title) && CGRectContainsRect(bounds,capsule),@"capsule surrounds the title within the original button bounds");
    Check(CGRectGetMidX(capsule)==CGRectGetMidX(title) && capsule.size.height>title.size.height,@"capsule wraps the title without changing its position");
    Check(CGRectEqualToRect(CSGroupCapsuleFrame(title,CGRectZero),CGRectZero) && CGRectEqualToRect(CSGroupCapsuleFrame(CGRectZero,bounds),CGRectZero),@"unmeasured button/title cannot produce infinite layer geometry");
    Check(CGRectEqualToRect(CSGroupCapsuleFrame(CGRectMake(200,0,40,20),bounds),CGRectZero),@"nonintersecting layout cannot produce a null/infinite frame");
    UIColor *chosenText=[UIColor new], *chosenFill=[UIColor new];
    CALayer *reused=a.capsuleLayer;
    [a configureCapsuleEnabled:YES color:chosenFill textColor:chosenText];
    Check(a.capsuleLayer==reused && a.capsuleTitleLabel.textColor==chosenText && CGColorEqualToColor(a.capsuleLayer.backgroundColor,chosenFill.CGColor),@"appearance refresh reuses the capsule and applies independent fill/text colors");
    Check(!a.capsuleTitleLabel.isAccessibilityElement && !a.capsuleTitleLabel.userInteractionEnabled,@"overlay neither intercepts taps nor duplicates VoiceOver elements");
    [v selectTabAtIndex:1 animated:YES];
    CAAnimationGroup *bloom=(id)[b.capsuleLayer animationForKey:kCapsuleAnimationKey];
    Check(bloom && fabs(bloom.duration-0.28)<0.001,@"capsule selection uses a finite 280ms transition");
    Check(b.capsuleLayer.opacity==1 && a.capsuleLayer.opacity==0 && b.titleLabel.layer.opacity==0 && b.capsuleTitleLabel.layer.opacity==1,@"background and selected title crossfade to the committed selection");
    Check([[(CABasicAnimation *)bloom.animations[0] keyPath] isEqual:@"opacity"] && [[(CABasicAnimation *)bloom.animations[1] keyPath] isEqual:@"transform"],@"capsule animates only opacity and local scale, never horizontal travel");
    NSUInteger capsuleAdds=b.capsuleLayer.animationAdds, capsuleHaptics=v.haptics;
    for (NSInteger i=0;i<10;i++) { v.selectedTabID=@"tab1"; [v updateIndicatorPosition]; }
    Check(b.capsuleLayer.animationAdds==capsuleAdds && [b.capsuleLayer animationForKey:kCapsuleAnimationKey]==bloom && v.haptics==capsuleHaptics,@"passive refresh does not restart capsule animation or repeat haptics");
    CALayer *partial=[CALayer layer]; partial.opacity=.4; partial.transform=CATransform3DMakeScale(.65,.9,1);
    b.capsuleLayer.visibleLayer=partial;
    [v selectTabAtIndex:2 animated:YES];
    CAAnimationGroup *retreat=(id)[b.capsuleLayer animationForKey:kCapsuleAnimationKey];
    Check(fabs([[(CABasicAnimation *)retreat.animations[0] fromValue] doubleValue]-.4)<.001,@"rapid reversal starts from the displayed opacity");
    Check(CATransform3DEqualToTransform([[(CABasicAnimation *)retreat.animations[1] fromValue] CATransform3DValue],partial.transform),@"rapid reversal starts from the displayed local scale");
    Check(c.capsuleLayer.opacity==1 && a.capsuleLayer.opacity==0 && b.capsuleLayer.opacity==0,@"rapid selection cannot leave multiple selected model layers");
    v=Fixture(); a=v.tabButtons[0]; b=v.tabButtons[1];
    [v updateInteractiveTransitionToIndex:1 progress:.4];
    Check(v.selectedIndex==0 && v.haptics==0 && fabs(a.capsuleProgress-.6)<.001 && fabs(b.capsuleProgress-.4)<.001,@"capsule drag previews both titles without committing or haptics");
    Check(!a.capsuleLayer.animationAdds && !b.capsuleLayer.animationAdds,@"drag updates do not enqueue animations");
    [v updateIndicatorPosition];
    Check(fabs(b.capsuleProgress-.4)<.001,@"passive layout preserves the finger's capsule progress");
    [v updateInteractiveTransitionToIndex:1 progress:.15];
    Check(fabs(b.capsuleProgress-.15)<.001,@"reversing a drag reverses the fill immediately");
    [v cancelInteractiveTransition];
    Check(v.selectedIndex==0 && a.capsuleLayer.opacity==1 && b.capsuleLayer.opacity==0 && v.haptics==0,@"cancel restores original capsule with no selection or haptic side effects");
    v=Fixture(); a=v.tabButtons[0]; b=v.tabButtons[1];
    [v updateInteractiveTransitionToIndex:1 progress:.5]; [v selectTabAtIndex:1 animated:YES];
    bloom=(id)[b.capsuleLayer animationForKey:kCapsuleAnimationKey];
    Check(v.selectedIndex==1 && v.haptics==1 && fabs([[(CABasicAnimation *)bloom.animations[0] fromValue] doubleValue]-.5)<.001,@"gesture commit continues from visible fill and triggers one haptic");
    [v selectTabAtIndex:2 animated:YES]; reducedMotion=YES; [v updateIndicatorPositionAnimated:NO];
    BOOL stopped=YES;
    for (WETabButton *tab in v.tabButtons) stopped &= ![tab.capsuleLayer animationForKey:kCapsuleAnimationKey] && ![tab.titleLabel.layer animationForKey:kCapsuleAnimationKey] && ![tab.capsuleTitleLabel.layer animationForKey:kCapsuleAnimationKey];
    Check(stopped && v.tabButtons[2].capsuleProgress==1,@"reduce motion stops every capsule layer at the selected state");
    [v selectTabAtIndex:0 animated:YES];
    Check(![v.tabButtons[0].capsuleLayer animationForKey:kCapsuleAnimationKey],@"reduce motion suppresses capsule transitions");
    reducedMotion=NO; v=Fixture(); v.window=nil; [v selectTabAtIndex:1 animated:YES];
    Check(![v.tabButtons[1].capsuleLayer animationForKey:kCapsuleAnimationKey] && v.tabButtons[1].capsuleProgress==1,@"offscreen capsule selection is immediate");
    v=Fixture(); [v selectTabAtIndex:1 animated:YES]; v.selectedIndex=NSNotFound; [v updateIndicatorPositionAnimated:NO];
    Check(v.indicatorView.hidden && v.tabButtons[0].capsuleProgress==0 && v.tabButtons[1].capsuleProgress==0 && v.tabButtons[2].capsuleProgress==0,@"invalid or removed selection clears all capsule highlights");
    v=Fixture(); [v selectTabAtIndex:1 animated:YES]; b=v.tabButtons[1];
    [b configureCapsuleEnabled:NO color:nil textColor:nil];
    Check(!b.capsuleLayer && !b.capsuleTitleLabel && b.titleLabel.layer.opacity==1 && ![b.titleLabel.layer animationForKey:kCapsuleAnimationKey],@"leaving capsule style frees its views and restores the normal title immediately");
    v=Fixture(); [v updateInteractiveTransitionToIndex:0 progress:.5];
    Check(!v.interactiveTransition && v.tabButtons[0].capsuleProgress==1,@"same-tab gesture cannot fade the selected capsule");
    [v updateInteractiveTransitionToIndex:1 progress:INFINITY];
    Check(!v.interactiveTransition && v.tabButtons[0].capsuleProgress==1,@"nonfinite drag input cannot corrupt capsule layers");
    CSGroupSetIndicatorStyle(testDefaults,CSGroupIndicatorStyleNone);
    v.indicatorStyle=CSGroupIndicatorStyleNone;
    [v updateIndicatorPositionAnimated:NO];
    Check(!v.indicatorView.hidden && ![v.indicatorView.layer animationForKey:kIndicatorAnimationKey],@"disabled choice uses the original static underline");
    [testDefaults removePersistentDomainForName:suite];
    printf("Group indicator: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
    return failures ? 1 : 0;
} }
