#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import <math.h>
#import "../Controllers/CSGroupAppearance.h"
#import "../Controllers/WESessionTabItem.h"
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
static CGFloat const kTabMinWidth=60,kTabPadding=16,kTabMinGap=8,kTabBadgeGap=3,kActionButtonWidth=44;
static NSTimeInterval const kIndicatorDuration=0.20;
static NSString *const kIndicatorAnimationKey=@"CSGroupIndicator.selection";
#include "GroupCapsuleHelpers.h"
enum { UIViewAnimationOptionCurveEaseInOut=1, UIViewAnimationOptionBeginFromCurrentState=2, UIViewAnimationOptionAllowUserInteraction=4, UIViewAnimationOptionCurveEaseOut=8 };
typedef NSUInteger UIViewAnimationOptions;
typedef struct { CGFloat top,left,bottom,right; } UIEdgeInsets;
enum { UIControlStateNormal=0 };
@class UIView;
@interface ViewAnimation : NSObject
@property(nonatomic) NSTimeInterval duration,delay;
@property(nonatomic) CGFloat damping,velocity;
@property(nonatomic) NSUInteger options;
@property(nonatomic) BOOL spring;
@property(nonatomic) CGRect beforeFrame,afterFrame;
@end
@implementation ViewAnimation @end
static NSMutableArray<ViewAnimation *> *viewAnimations;
static __weak UIView *observedIndicator;
@interface UITouch : NSObject
@property(nonatomic) CGPoint sample;
- (CGPoint)locationInView:(UIView *)view;
@end
@implementation UITouch
- (CGPoint)locationInView:(UIView *)view { (void)view; return self.sample; }
@end
@interface UIEvent : NSObject @end
@implementation UIEvent @end
@interface TestLayer : CALayer
@property(nonatomic,strong) NSMutableDictionary *savedAnimations;
@property(nonatomic,strong) CALayer *visibleLayer;
@property(nonatomic) NSUInteger animationAdds;
@property(nonatomic) NSUInteger animationClears;
@end
@implementation TestLayer
- (instancetype)init { if ((self=[super init])) _savedAnimations=[NSMutableDictionary dictionary]; return self; }
- (instancetype)presentationLayer { return (id)self.visibleLayer; }
- (CAAnimation *)animationForKey:(NSString *)key { return self.savedAnimations[key]; }
- (void)addAnimation:(CAAnimation *)animation forKey:(NSString *)key { self.savedAnimations[key]=animation; self.animationAdds++; }
- (void)removeAnimationForKey:(NSString *)key { [self.savedAnimations removeObjectForKey:key]; }
- (void)removeAllAnimations { self.animationClears++; [self.savedAnimations removeAllObjects]; }
- (NSArray<NSString *> *)animationKeys { return self.savedAnimations.allKeys; }
@end
@interface UIView : NSObject
@property(nonatomic,strong) TestLayer *layer;
@property(nonatomic) BOOL hidden;
@property(nonatomic,strong) id window;
@property(nonatomic) CGRect frame,bounds;
@property(nonatomic) UIEdgeInsets safeAreaInsets;
@property(nonatomic) BOOL needsLayout;
@property(nonatomic) CGAffineTransform transform;
@property(nonatomic) CGFloat alpha;
@property(nonatomic) CGPoint contentOffset;
@property(nonatomic) CGSize contentSize;
@property(nonatomic) NSUInteger scrollWrites;
@property(nonatomic) NSUInteger baseTrackingBegins,baseTrackingContinues;
- (void)setNeedsLayout;
- (void)removeFromSuperview;
- (void)insertSubview:(UIView *)view belowSubview:(UIView *)sibling;
- (void)layoutIfNeeded;
- (void)layoutSubviews;
- (void)addSubview:(UIView *)view;
- (void)setContentOffset:(CGPoint)offset animated:(BOOL)animated;
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event;
- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event;
+ (void)animateWithDuration:(double)duration delay:(double)delay options:(NSUInteger)options animations:(void (^)(void))animations completion:(void (^)(BOOL))completion;
+ (void)animateWithDuration:(double)duration delay:(double)delay usingSpringWithDamping:(CGFloat)damping initialSpringVelocity:(CGFloat)velocity options:(NSUInteger)options animations:(void (^)(void))animations completion:(void (^)(BOOL))completion;
+ (void)performWithoutAnimation:(void (^)(void))changes;
@end
@implementation UIView
- (instancetype)init { if ((self=[super init])) _layer=[TestLayer layer]; return self; }
- (CGRect)frame { return self.layer.frame; }
- (void)setFrame:(CGRect)frame { self.layer.frame=frame; CGRect bounds=self.bounds; bounds.size=frame.size; self.bounds=bounds; }
- (CGAffineTransform)transform { return self.layer.affineTransform; }
- (void)setTransform:(CGAffineTransform)transform { self.layer.affineTransform=transform; }
- (CGFloat)alpha { return self.layer.opacity; }
- (void)setAlpha:(CGFloat)alpha { self.layer.opacity=alpha; }
- (void)layoutIfNeeded {}
- (void)layoutSubviews {}
- (void)setNeedsLayout { self.needsLayout=YES; }
- (void)addSubview:(UIView *)view { (void)view; }
- (void)removeFromSuperview {}
- (void)insertSubview:(UIView *)view belowSubview:(UIView *)sibling { (void)view; (void)sibling; }
- (void)setContentOffset:(CGPoint)offset animated:(BOOL)animated { (void)animated; self.contentOffset=offset; self.scrollWrites++; }
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event { (void)touch; (void)event; self.baseTrackingBegins++; return YES; }
- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event { (void)touch; (void)event; self.baseTrackingContinues++; return YES; }
+ (void)animateWithDuration:(double)duration delay:(double)delay options:(NSUInteger)options animations:(void (^)(void))animations completion:(void (^)(BOOL))completion {
    ViewAnimation *capture=[ViewAnimation new]; capture.duration=duration; capture.delay=delay; capture.options=options;
    capture.beforeFrame=observedIndicator.frame; viewportAnimations++; animations(); capture.afterFrame=observedIndicator.frame;
    [viewAnimations addObject:capture]; if (completion) completion(YES);
}
+ (void)animateWithDuration:(double)duration delay:(double)delay usingSpringWithDamping:(CGFloat)damping initialSpringVelocity:(CGFloat)velocity options:(NSUInteger)options animations:(void (^)(void))animations completion:(void (^)(BOOL))completion {
    ViewAnimation *capture=[ViewAnimation new]; capture.duration=duration; capture.delay=delay; capture.options=options;
    capture.spring=YES; capture.damping=damping; capture.velocity=velocity;
    capture.beforeFrame=observedIndicator.frame; animations(); capture.afterFrame=observedIndicator.frame;
    [viewAnimations addObject:capture]; if (completion) completion(YES);
}
+ (void)performWithoutAnimation:(void (^)(void))changes { changes(); }
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
typedef NS_OPTIONS(NSUInteger, UIControlEvents) {
    UIControlEventTouchDown = 1 << 0,
    UIControlEventTouchDragEnter = 1 << 4,
    UIControlEventTouchDragExit = 1 << 5,
    UIControlEventTouchUpInside = 1 << 6,
    UIControlEventTouchUpOutside = 1 << 7,
    UIControlEventTouchCancel = 1 << 8,
};
@interface TouchAction : NSObject
@property(nonatomic,weak) id target;
@property(nonatomic) SEL action;
@property(nonatomic) UIControlEvents events;
@end
@implementation TouchAction @end
@interface WETabButton : UIView
@property(nonatomic) NSInteger tabIndex;
@property(nonatomic) CGFloat baseFontSize;
@property(nonatomic,copy) NSString *tabID;
@property(nonatomic,copy) NSString *currentTitle,*accessibilityLabel;
@property(nonatomic,strong) UILabel *capsuleTitleLabel;
@property(nonatomic,strong) UIView *titleLabel;
@property(nonatomic,strong) UIView *unreadBadge;
@property(nonatomic) BOOL capsuleEnabled;
@property(nonatomic) CGFloat capsuleProgress;
@property(nonatomic) CGPoint capsuleTouchPoint;
@property(nonatomic) BOOL capsuleHasTouchPoint;
@property(nonatomic) CGRect measuredTitleFrame;
@property(nonatomic,strong) NSMutableArray<TouchAction *> *touchActions;
- (void)setCapsuleProgress:(CGFloat)progress animated:(BOOL)animated;
- (void)configureCapsuleEnabled:(BOOL)enabled color:(UIColor *)color textColor:(UIColor *)textColor;
- (CGRect)tabTitleFrame;
- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)events;
- (void)sendActionsForControlEvents:(UIControlEvents)events;
- (void)updateFonts;
- (void)setTitle:(NSString *)title forState:(NSUInteger)state;
- (CGSize)tabTitleSize;
- (CGFloat)badgeWidth;
@end
@implementation WETabButton
- (instancetype)init { if ((self=[super init])) { _titleLabel=[UIView new]; _unreadBadge=[UIView new]; _unreadBadge.hidden=YES; } return self; }
- (void)updateFonts {}
- (void)setTitle:(NSString *)title forState:(NSUInteger)state { (void)state; self.currentTitle=title; }
- (CGSize)tabTitleSize { return CGSizeMake(self.currentTitle.length * 9,20); }
- (CGFloat)badgeWidth { return self.unreadBadge.hidden ? 0 : CGRectGetWidth(self.unreadBadge.frame); }
- (CGRect)tabTitleFrame { return CGRectIsEmpty(self.measuredTitleFrame) ? CGRectMake(20,12,40,20) : self.measuredTitleFrame; }
- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)events {
    if (!self.touchActions) self.touchActions=[NSMutableArray array];
    TouchAction *binding=[TouchAction new]; binding.target=target; binding.action=action; binding.events=events;
    [self.touchActions addObject:binding];
}
- (void)sendActionsForControlEvents:(UIControlEvents)events {
    for (TouchAction *binding in self.touchActions) {
        id target=binding.target;
        if (target && (binding.events & events)) {
            void (*send)(id,SEL,WETabButton *)=(void (*)(id,SEL,WETabButton *))[target methodForSelector:binding.action];
            send(target,binding.action,self);
        }
    }
}
#define CALayer TestLayer
#include "GroupCapsuleButtonBody.h"
#undef CALayer
@end
@interface UIScrollView : UIView
@property(nonatomic) BOOL delaysContentTouches,canCancelContentTouches;
@property(nonatomic) BOOL tracking,dragging,decelerating;
- (BOOL)touchesShouldCancelInContentView:(UIView *)view;
@end
@implementation UIScrollView
- (BOOL)touchesShouldCancelInContentView:(UIView *)view { (void)view; return NO; }
@end
@interface WEGroupTabScrollView : UIScrollView @end
@implementation WEGroupTabScrollView
#include "GroupTabScrollBody.h"
@end
@interface WESessionTabContainerView : UIView
@property(nonatomic) NSInteger selectedIndex;
@property(nonatomic,copy) NSString *selectedTabID;
@property(nonatomic,strong) NSArray<WETabButton *> *tabButtons;
@property(nonatomic,copy) NSArray *renderedTabRecords;
@property(nonatomic,strong) UIView *indicatorView;
@property(nonatomic,strong) UIView *searchButton;
@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic) CGFloat baseFontSize;
@property(nonatomic) BOOL revealSelectionAfterLayout,tabLayoutValid,replaysLayout;
@property(nonatomic) CGSize tabLayoutSize,indicatorLayoutSize;
@property(nonatomic) NSUInteger haptics;
@property(nonatomic) BOOL interactiveTransition,settlingInteractiveTransition;
@property(nonatomic) NSInteger interactiveTarget;
@property(nonatomic) CGFloat interactiveProgress;
@property(nonatomic) CSGroupIndicatorStyle indicatorStyle;
@property(nonatomic,weak) WETabButton *capsulePressedButton,*capsuleTouchButton;
@property(nonatomic) BOOL capsuleTouchConsumed;
@property(nonatomic,copy) void (^onTabSelected)(NSInteger index);
@property(nonatomic) NSUInteger selectionCallbacks;
@property(nonatomic) NSInteger callbackIndex;
@property(nonatomic) NSUInteger layoutCalls;
- (void)updateCapsuleSelectionAnimated:(BOOL)animated;
- (CGRect)indicatorFrameForIndex:(NSInteger)index;
- (void)updateInteractiveTransitionToIndex:(NSInteger)index progress:(CGFloat)progress;
- (void)cancelInteractiveTransition;
- (void)selectTabAtIndex:(NSInteger)index animated:(BOOL)animated;
- (void)updateIndicatorPosition;
- (void)updateIndicatorPositionAnimated:(BOOL)animated;
- (void)moveIndicatorToFrame:(CGRect)frame animated:(BOOL)animated;
- (void)scrollToSelectedTab;
- (void)installTouchBindingsForButton:(WETabButton *)button;
- (void)refreshTouchAppearance;
- (void)setupTouchPolicy;
- (void)initializeSelection;
- (void)refreshAppearance;
- (void)updateTabs:(NSArray<WESessionTabItem *> *)tabs;
- (void)layoutTabButtons;
- (CGFloat)widthForTabButton:(WETabButton *)button;
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (CGRect)capsuleFrameForButton:(WETabButton *)button pressed:(BOOL)pressed;
- (void)moveCapsuleToFrame:(CGRect)target pressed:(BOOL)pressed animated:(BOOL)animated;
@end
@implementation WESessionTabContainerView
- (instancetype)init { if ((self=[super init])) _selectedIndex=NSNotFound; return self; }
#define NSUserDefaults IndicatorTestDefaults
#include "GroupIndicatorBodies.h"
#include "GroupContainerLayoutBody.h"
- (void)refreshTouchAppearance {
#include "GroupCapsuleTouchAppearance.h"
}
#undef NSUserDefaults
- (void)setupTouchPolicy {
#include "GroupCapsuleTouchSetup.h"
}
- (void)installTouchBindingsForButton:(WETabButton *)button {
#include "GroupCapsuleTouchBindings.h"
}
- (void)initializeSelection { _selectedIndex=0; _selectedTabID=@"tab0"; }
- (void)layoutIfNeeded { self.layoutCalls++; if (self.replaysLayout && self.needsLayout) { self.needsLayout=NO; [self layoutSubviews]; } }
- (void)refreshAppearance { [self refreshTouchAppearance]; }
- (void)triggerHapticFeedback { self.haptics++; }
- (void)updateSelectedButtons {}
@end
static NSUInteger checks,failures;
static void Check(BOOL c,NSString *message) { checks++; if (!c) { failures++; fprintf(stderr,"FAIL: %s\n",message.UTF8String); } }
static ViewAnimation *LastCapsuleAnimation(void) {
    for (ViewAnimation *animation in viewAnimations.reverseObjectEnumerator)
        if ((fabs(animation.duration-.12)<.001 || fabs(animation.duration-.22)<.001) && !CGRectEqualToRect(animation.beforeFrame,animation.afterFrame)) return animation;
    return nil;
}
static BOOL IsCapsuleSpring(ViewAnimation *animation) {
    return animation.spring && fabs(animation.duration-.22)<.001 && fabs(animation.damping-1)<.001 && fabs(animation.velocity)<.001 && !animation.delay &&
        (animation.options & (UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState)) == (UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState);
}
static WESessionTabContainerView *Fixture(void) {
    WESessionTabContainerView *view=[WESessionTabContainerView new];
    view.window=[NSObject new]; view.indicatorView=[UIView new]; view.scrollView=[WEGroupTabScrollView new];
    view.indicatorView.hidden=YES; observedIndicator=view.indicatorView;
    [view setupTouchPolicy]; [view refreshTouchAppearance];
    __weak WESessionTabContainerView *weakView=view;
    view.onTabSelected=^(NSInteger index) { weakView.selectionCallbacks++; weakView.callbackIndex=index; };
    view.scrollView.bounds=CGRectMake(0,0,160,52); view.scrollView.contentSize=CGSizeMake(300,52);
    view.tabLayoutValid=YES; view.tabLayoutSize=view.scrollView.bounds.size;
    NSMutableArray *buttons=[NSMutableArray array];
    for (NSInteger i=0;i<3;i++) {
        WETabButton *button=[WETabButton new]; button.frame=CGRectMake(i*100,0,80,52);
        button.bounds=CGRectMake(0,0,80,52); button.tabIndex=i; button.tabID=[NSString stringWithFormat:@"tab%ld",(long)i];
        button.titleLabel=[UIView new]; button.unreadBadge=[UIView new];
        button.titleLabel.frame=[button tabTitleFrame]; button.unreadBadge.frame=CGRectMake(63,14,14,14);
        if (view.indicatorStyle==CSGroupIndicatorStyleCapsule) {
            [button configureCapsuleEnabled:YES color:[UIColor new] textColor:[UIColor new]];
            button.capsuleTitleLabel.frame=[button tabTitleFrame];
        }
        [view installTouchBindingsForButton:button];
        [buttons addObject:button];
    }
    view.tabButtons=buttons; [view initializeSelection];
    [view updateIndicatorPositionAnimated:NO]; return view;
}

static WESessionTabContainerView *StartupFixture(void) {
    WESessionTabContainerView *view=[WESessionTabContainerView new];
    view.scrollView=[WEGroupTabScrollView new]; view.indicatorView=[UIView new];
    view.searchButton=[UIView new]; view.replaysLayout=YES; view.baseFontSize=14;
    return view;
}
static NSArray<WESessionTabItem *> *StartupTabs(NSUInteger count) {
    NSMutableArray *tabs=[NSMutableArray array];
    for (NSUInteger index=0;index<count;index++) {
        WESessionTabItem *item=[WESessionTabItem new];
        item.tabId=[NSString stringWithFormat:@"startup-%lu",(unsigned long)index];
        item.tabName=index ? [NSString stringWithFormat:@"Group%lu",(unsigned long)index] : @"Whole";
        item.type=index ? WETabTypeCustom : WETabTypeAll;
        [tabs addObject:item];
    }
    return tabs;
}
static void FinishStartupLayout(WESessionTabContainerView *view) {
    view.frame=CGRectMake(0,0,320,52); [view setNeedsLayout]; [view layoutIfNeeded];
}
static void CheckStartupViewport(void) {
    for (NSNumber *count in @[@5,@8]) {
        NSArray *tabs=StartupTabs(count.unsignedIntegerValue);
        WESessionTabContainerView *view=StartupFixture();
        [view updateTabs:tabs];
        Check(!view.scrollView.scrollWrites && !view.tabLayoutValid,@"zero-width cold-start publication never writes a horizontal offset or caches invalid geometry");
        Check(view.revealSelectionAfterLayout,@"cold-start selection reveal survives the zero-width layout");
        FinishStartupLayout(view);
        Check(view.scrollView.contentSize.width>CGRectGetWidth(view.scrollView.bounds),@"cold-start fixture has real horizontal overflow with five or more groups");
        Check(view.selectedIndex==0 && fabs(view.scrollView.contentOffset.x)<.001 && CGRectGetMinX(view.tabButtons[0].frame)>=0,@"first group remains fully visible after the real viewport arrives");
        Check(!view.revealSelectionAfterLayout && view.tabLayoutValid,@"real layout consumes the pending initial reveal once");
        view.scrollView.contentOffset=CGPointMake(25,0);
        NSUInteger writes=view.scrollView.scrollWrites;
        [view updateTabs:tabs]; [view setNeedsLayout]; [view layoutIfNeeded];
        Check(fabs(view.scrollView.contentOffset.x-25)<.001 && view.scrollView.scrollWrites==writes,@"identical publication and repeated layout preserve the user's horizontal position");
        view.tabButtons[1].unreadBadge.hidden=NO; view.tabButtons[1].unreadBadge.frame=CGRectMake(0,0,16,14);
        view.tabLayoutValid=NO; [view setNeedsLayout]; [view layoutIfNeeded];
        Check(fabs(view.scrollView.contentOffset.x-25)<.001 && view.scrollView.scrollWrites==writes,@"badge geometry reflow does not recenter an already revealed selection");

        view=StartupFixture(); view.selectedTabID=[tabs.lastObject tabId]; [view updateTabs:tabs];
        Check(!view.scrollView.scrollWrites && view.revealSelectionAfterLayout,@"restored last-group selection waits for real geometry");
        FinishStartupLayout(view);
        CGFloat maxOffset=view.scrollView.contentSize.width-CGRectGetWidth(view.scrollView.bounds);
        Check(view.selectedIndex==(NSInteger)tabs.count-1 && fabs(view.scrollView.contentOffset.x-maxOffset)<.001,@"restored last-group selection is revealed at the final viewport width");
        Check(CGRectGetMaxX(view.tabButtons.lastObject.frame)<=view.scrollView.contentOffset.x+CGRectGetWidth(view.scrollView.bounds)+.001,@"restored last group fits inside the visible strip");
    }
    WESessionTabContainerView *view=StartupFixture(); [view updateTabs:StartupTabs(5)];
    view.scrollView.dragging=YES; [view scrollViewWillBeginDragging:view.scrollView];
    Check(!view.revealSelectionAfterLayout,@"horizontal user drag cancels the pending startup reveal");
    FinishStartupLayout(view); view.scrollView.contentOffset=CGPointMake(25,0);
    [view scrollToSelectedTab];
    Check(fabs(view.scrollView.contentOffset.x-25)<.001 && !view.revealSelectionAfterLayout,@"selection reconciliation during dragging preserves user ownership");
    view.scrollView.dragging=NO; [view setNeedsLayout]; [view layoutIfNeeded];
    Check(fabs(view.scrollView.contentOffset.x-25)<.001,@"ending the drag does not replay the cancelled startup reveal");

    view=StartupFixture(); [view updateTabs:StartupTabs(2)]; FinishStartupLayout(view);
    Check(fabs(view.scrollView.contentOffset.x)<.001 && CGRectGetMinX(view.tabButtons[0].frame)>kTabMinGap,@"nonoverflowing groups keep their existing evenly distributed spacing");
}

static WESessionTabContainerView *PublishedFixture(CSGroupIndicatorStyle style,NSArray<WESessionTabItem *> *tabs) {
    CSGroupSetIndicatorStyle(testDefaults,style);
    WESessionTabContainerView *view=StartupFixture();
    view.window=[NSObject new]; view.searchButton.hidden=YES; observedIndicator=view.indicatorView;
    [view updateTabs:tabs];
    // UIColor and UIFont rendering are outside this host replay. Retain the
    // production button configuration while selection, records, and layout use
    // the extracted container methods without a substitute implementation.
    if (style==CSGroupIndicatorStyleCapsule) for (WETabButton *button in view.tabButtons) {
        [button configureCapsuleEnabled:YES color:[UIColor new] textColor:[UIColor new]];
        button.capsuleTitleLabel.frame=[button tabTitleFrame];
    }
    FinishStartupLayout(view);
    return view;
}
static CGRect SelectionFrame(WESessionTabContainerView *view,NSInteger index) {
    return view.indicatorStyle==CSGroupIndicatorStyleCapsule ?
        [view capsuleFrameForButton:view.tabButtons[index] pressed:NO] : [view indicatorFrameForIndex:index];
}
static BOOL SettlesFromFrame(WESessionTabContainerView *view,CGRect start,CGRect target) {
    if (view.indicatorStyle==CSGroupIndicatorStyleCapsule) {
        ViewAnimation *animation=LastCapsuleAnimation();
        return IsCapsuleSpring(animation) && CGRectEqualToRect(animation.beforeFrame,start) && CGRectEqualToRect(animation.afterFrame,target);
    }
    CAAnimationGroup *animation=(id)[view.indicatorView.layer animationForKey:kIndicatorAnimationKey];
    if (!animation || animation.animations.count!=2 || fabs(animation.duration-.20)>.001) return NO;
    CAKeyframeAnimation *position=(id)animation.animations[0],*size=(id)animation.animations[1];
    return position.values.count==2 && size.values.count==2 &&
        CGPointEqualToPoint([position.values.firstObject CGPointValue],CGPointMake(CGRectGetMidX(start),CGRectGetMidY(start))) &&
        CGPointEqualToPoint([position.values.lastObject CGPointValue],CGPointMake(CGRectGetMidX(target),CGRectGetMidY(target))) &&
        CGSizeEqualToSize([size.values.firstObject CGSizeValue],start.size) &&
        CGSizeEqualToSize([size.values.lastObject CGSizeValue],target.size);
}
static void CheckPublishedPageHandoff(void) {
    NSArray<WESessionTabItem *> *tabs=StartupTabs(5);
    for (NSNumber *styleValue in @[@(CSGroupIndicatorStyleUnderline),@(CSGroupIndicatorStyleCapsule)]) {
        CSGroupIndicatorStyle style=styleValue.integerValue;
        NSString *name=CSGroupIndicatorStyleName(style);
        WESessionTabContainerView *view=PublishedFixture(style,tabs);
        UIView *indicator=view.indicatorView;
        CGRect source=SelectionFrame(view,0),target=SelectionFrame(view,1);
        Check(view.tabLayoutValid && view.renderedTabRecords.count==5 && CGRectEqualToRect(indicator.frame,source),
              [NSString stringWithFormat:@"%@ page handoff starts from published records and real container layout",name]);
        CGFloat fraction=64.0/320.0;
        [view updateInteractiveTransitionToIndex:1 progress:fraction];
        CGFloat expected=CGRectGetMidX(source)+(CGRectGetMidX(target)-CGRectGetMidX(source))*fraction;
        Check(view.interactiveTransition && view.selectedIndex==0 && !view.haptics &&
              fabs(CGRectGetMidX(indicator.frame)-expected)<.001 && ![indicator.layer animationForKey:kIndicatorAnimationKey],
              [NSString stringWithFormat:@"%@ follows a page-width fraction without committing or queuing a tween",name]);
        fraction=108.0/320.0;
        [view updateInteractiveTransitionToIndex:1 progress:fraction];
        expected=CGRectGetMidX(source)+(CGRectGetMidX(target)-CGRectGetMidX(source))*fraction;
        CGRect interactiveFrame=indicator.frame;
        Check(fabs(CGRectGetMidX(interactiveFrame)-expected)<.001 && CGRectGetMidX(interactiveFrame)<CGRectGetMidX(target)-1,
              [NSString stringWithFormat:@"%@ retains remaining travel at a partial page drag",name]);
        NSUInteger layoutCalls=view.layoutCalls;
        [view selectTabAtIndex:1 animated:YES];
        Check(view.selectedIndex==1 && [view.selectedTabID isEqual:tabs[1].tabId] && !view.interactiveTransition &&
              view.layoutCalls==layoutCalls && view.haptics==1,
              [NSString stringWithFormat:@"%@ commits before passive publication without an old-selection layout",name]);
        Check(SettlesFromFrame(view,interactiveFrame,target),
              [NSString stringWithFormat:@"%@ release starts at current geometry and keeps its existing settle style",name]);

        NSString *animationKey=style==CSGroupIndicatorStyleCapsule ? @"UIKit.position" : kIndicatorAnimationKey;
        if (style==CSGroupIndicatorStyleCapsule)
            [indicator.layer addAnimation:[CABasicAnimation animationWithKeyPath:@"position"] forKey:animationKey];
        CAAnimation *settle=[indicator.layer animationForKey:animationKey];
        // UIKit owns capsule presentation; a retained stand-in makes accidental
        // removeAllAnimations calls observable during the passive refreshes.
        CALayer *presentation=[CALayer layer]; presentation.frame=interactiveFrame; indicator.layer.visibleLayer=presentation;
        NSUInteger animations=viewAnimations.count,adds=indicator.layer.animationAdds,clears=indicator.layer.animationClears;
        view.selectedTabID=tabs[1].tabId;
        Check([indicator.layer animationForKey:animationKey]==settle && indicator.layer.animationAdds==adds &&
              indicator.layer.animationClears==clears && viewAnimations.count==animations && CGRectEqualToRect(indicator.frame,target),
              [NSString stringWithFormat:@"%@ same-target stable-ID acknowledgement preserves the running settle",name]);
        NSArray<WETabButton *> *buttons=view.tabButtons;
        [view updateTabs:StartupTabs(5)];
        Check(view.tabButtons==buttons && [indicator.layer animationForKey:animationKey]==settle &&
              indicator.layer.animationClears==clears && viewAnimations.count==animations,
              [NSString stringWithFormat:@"%@ publication with equal records retains buttons and the running settle",name]);
        [view setNeedsLayout]; [view layoutIfNeeded];
        Check([indicator.layer animationForKey:animationKey]==settle && indicator.layer.animationAdds==adds &&
              indicator.layer.animationClears==clears && viewAnimations.count==animations && view.haptics==1 &&
              indicator.layer.visibleLayer==presentation && CGRectEqualToRect(indicator.frame,target),
              [NSString stringWithFormat:@"%@ unchanged real layout preserves presentation and avoids restarting the settle",name]);

        indicator.layer.visibleLayer=nil;
        [view updateInteractiveTransitionToIndex:2 progress:88.0/320.0];
        CGRect cancelFrame=indicator.frame;
        [view cancelInteractiveTransition];
        Check(view.selectedIndex==1 && [view.selectedTabID isEqual:tabs[1].tabId] && view.haptics==1 &&
              !view.interactiveTransition && SettlesFromFrame(view,cancelFrame,target),
              [NSString stringWithFormat:@"%@ cancelled next drag returns continuously to its committed source group",name]);
        CAAnimation *cancel=[indicator.layer animationForKey:kIndicatorAnimationKey];
        animations=viewAnimations.count; clears=indicator.layer.animationClears;
        view.selectedTabID=tabs[1].tabId; [view updateTabs:StartupTabs(5)]; [view setNeedsLayout]; [view layoutIfNeeded];
        Check(CGRectEqualToRect(indicator.frame,target) && viewAnimations.count==animations && indicator.layer.animationClears==clears &&
              [indicator.layer animationForKey:kIndicatorAnimationKey]==cancel && view.haptics==1,
              [NSString stringWithFormat:@"%@ rollback reconciliation keeps the source and does not replay feedback",name]);

        view=PublishedFixture(style,tabs); indicator=view.indicatorView; reducedMotion=YES;
        [view updateInteractiveTransitionToIndex:1 progress:108.0/320.0];
        Check(!view.interactiveTransition && view.selectedIndex==0 && CGRectEqualToRect(indicator.frame,SelectionFrame(view,0)),
              [NSString stringWithFormat:@"%@ Reduce Motion preserves direct-selection ownership without a page preview",name]);
        animations=viewAnimations.count;
        [view selectTabAtIndex:1 animated:YES];
        Check(view.selectedIndex==1 && CGRectEqualToRect(indicator.frame,SelectionFrame(view,1)) &&
              !indicator.layer.animationKeys.count && viewAnimations.count==animations,
              [NSString stringWithFormat:@"%@ Reduce Motion still commits directly without an indicator or viewport animation",name]);
        reducedMotion=NO;
    }
    WESessionTabContainerView *view=PublishedFixture(CSGroupIndicatorStyleNone,tabs);
    [view updateInteractiveTransitionToIndex:1 progress:108.0/320.0];
    NSUInteger animations=viewAnimations.count;
    Check(!view.interactiveTransition && view.selectedIndex==0,@"animation-off page gesture keeps direct-switch behavior");
    [view selectTabAtIndex:1 animated:YES];
    Check(view.selectedIndex==1 && !view.indicatorView.layer.animationKeys.count && viewAnimations.count==animations &&
          CGRectEqualToRect(view.indicatorView.frame,SelectionFrame(view,1)),@"animation-off selection commits with its existing static indicator");
    view.selectedTabID=tabs[1].tabId; [view updateTabs:StartupTabs(5)]; [view setNeedsLayout]; [view layoutIfNeeded];
    Check(view.selectedIndex==1 && view.haptics==1 && viewAnimations.count==animations,
          @"animation-off passive publication keeps the committed selection without extra feedback");
}
int main(void) { @autoreleasepool {
    viewAnimations=[NSMutableArray array];
    NSString *suite=[@"com.wechat.improve.tests.indicator." stringByAppendingString:NSUUID.UUID.UUIDString];
    testDefaults=[[NSUserDefaults alloc] initWithSuiteName:suite];
    CheckStartupViewport();
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
    UIView *shared=v.indicatorView;
    CGRect restA=CGRectMake(10,5,60,34),restB=CGRectOffset(restA,100,0),restC=CGRectOffset(restA,200,0);
    Check(!shared.hidden && CGRectEqualToRect(shared.frame,restA) && a.capsuleProgress==1 && b.capsuleProgress==0,@"first capsule layout uses one shared background at the selected title");
    Check(CATransform3DIsIdentity(shared.layer.transform) && fabs(shared.layer.cornerRadius-17)<.001,@"resting shared capsule uses a real frame and matching round corners");
    Check(!shared.layer.animationAdds && !b.layer.sublayers.count && !a.layer.sublayers.count,@"buttons own no capsule background layers or explicit scale animations");
    CGRect title=CGRectMake(20,12,40,20), bounds=CGRectMake(0,0,80,52);
    CGRect capsule=CSGroupCapsuleFrame(title,bounds);
    Check(CGRectContainsRect(capsule,title) && CGRectContainsRect(bounds,capsule),@"resting capsule surrounds the original title inside its button");
    Check(CGRectEqualToRect(CSGroupCapsuleFrame(title,CGRectZero),CGRectZero) && CGRectEqualToRect(CSGroupCapsuleFrame(CGRectZero,bounds),CGRectZero),@"unmeasured geometry cannot create an invalid capsule");
    Check(CGRectEqualToRect(CSGroupCapsuleFrame(CGRectMake(200,0,40,20),bounds),CGRectZero),@"nonintersecting title geometry is ignored");
    UIColor *chosenText=[UIColor new]; UILabel *reused=a.capsuleTitleLabel;
    [a configureCapsuleEnabled:YES color:[UIColor new] textColor:chosenText];
    Check(a.capsuleTitleLabel==reused && a.capsuleTitleLabel.textColor==chosenText,@"appearance refresh reuses the title overlay and preserves its configured color");
    Check(!a.capsuleTitleLabel.isAccessibilityElement && !a.capsuleTitleLabel.userInteractionEnabled,@"title overlay cannot intercept taps or duplicate VoiceOver elements");

    NSUInteger animationCount=viewAnimations.count;
    CGRect buttonFrame=b.frame,titleFrame=b.titleLabel.frame,badgeFrame=b.unreadBadge.frame;
    scrolls=v.scrollView.scrollWrites;
    [b sendActionsForControlEvents:UIControlEventTouchDown];
    ViewAnimation *press=LastCapsuleAnimation();
    NSUInteger pressOptions=UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut;
    Check(viewAnimations.count==animationCount+1 && !press.spring && fabs(press.duration-.12)<.001 && press.options==pressOptions && !press.delay,@"TouchDown starts the same interruptible 120ms EaseOut UIKit press as the bottom bar");
    Check(v.indicatorView==shared && CGRectEqualToRect(shared.frame,CGRectMake(107,4,66,36)) && fabs(shared.layer.cornerRadius-18)<.001,@"TouchDown moves and expands the one shared capsule through its real frame");
    Check(CGRectEqualToRect(press.beforeFrame,restA) && CGRectEqualToRect(press.afterFrame,shared.frame),@"the press hands off directly from the previous shared model frame");
    Check(v.capsulePressedButton==b && v.capsuleTouchButton==b && b.capsuleTitleLabel.alpha==1 && b.titleLabel.alpha==0 && a.capsuleTitleLabel.alpha==0,@"pressed text alpha shares the background's UIKit transaction");
    Check(v.selectedIndex==0 && [v.selectedTabID isEqual:@"tab0"] && !v.selectionCallbacks && !v.haptics && v.scrollView.scrollWrites==scrolls,@"TouchDown previews without committing, feedback, or viewport movement");
    Check(CGRectEqualToRect(b.frame,buttonFrame) && CGRectEqualToRect(b.titleLabel.frame,titleFrame) && CGRectEqualToRect(b.unreadBadge.frame,badgeFrame),@"press keeps the button, title, and badge layout fixed");
    Check(CATransform3DIsIdentity(shared.layer.transform) && CATransform3DIsIdentity(b.layer.transform) && CATransform3DIsIdentity(b.titleLabel.layer.transform) && CATransform3DIsIdentity(b.capsuleTitleLabel.layer.transform) && CATransform3DIsIdentity(b.unreadBadge.layer.transform),@"shared background, labels, and badges remain unscaled");
    [shared.layer addAnimation:[CABasicAnimation animationWithKeyPath:@"position"] forKey:@"UIKit.position"];
    CAAnimation *inFlight=[shared.layer animationForKey:@"UIKit.position"];
    animationCount=viewAnimations.count; NSUInteger clears=shared.layer.animationClears,layoutCalls=v.layoutCalls;
    for (NSUInteger repeat=0;repeat<5;repeat++) { [v updateIndicatorPosition]; v.selectedTabID=@"tab0"; }
    Check(viewAnimations.count==animationCount && shared.layer.animationClears==clears && [shared.layer animationForKey:@"UIKit.position"]==inFlight,@"passive layout and stable-ID acknowledgements preserve the press presentation");
    CGRect pressedB=shared.frame;
    [b sendActionsForControlEvents:UIControlEventTouchUpInside];
    ViewAnimation *settle=LastCapsuleAnimation();
    Check(IsCapsuleSpring(settle) && CGRectEqualToRect(settle.beforeFrame,pressedB) && CGRectEqualToRect(settle.afterFrame,restB),@"release continues from the pressed frame with its existing 220ms critically damped settle");
    Check(v.layoutCalls==layoutCalls && shared.layer.animationClears==clears,@"release never performs an old-selection layout or clears the moving shared capsule");
    Check(v.selectedIndex==1 && [v.selectedTabID isEqual:@"tab1"] && v.selectionCallbacks==1 && v.callbackIndex==1 && v.haptics==1,@"release commits exactly once through the existing selection callback");
    Check(!v.capsulePressedButton && !v.capsuleTouchButton && v.indicatorView==shared && b.capsuleTitleLabel.alpha==1 && a.capsuleTitleLabel.alpha==0,@"release retains one background and the committed title state");
    Check(IsCapsuleSpring(viewAnimations.lastObject),@"selected-label viewport reveal shares the existing 220ms critically damped parameters");
    animationCount=viewAnimations.count;
    for (NSUInteger repeat=0;repeat<5;repeat++) { v.selectedTabID=@"tab1"; [v updateIndicatorPosition]; }
    [b sendActionsForControlEvents:UIControlEventTouchUpInside];
    Check(viewAnimations.count==animationCount && v.selectionCallbacks==1 && v.haptics==1,@"passive publication and duplicate same-tab Up cannot restart the spring or commit again");

    CALayer *partial=[CALayer layer]; partial.frame=CGRectMake(158,4,65,36); shared.layer.visibleLayer=partial;
    [c sendActionsForControlEvents:UIControlEventTouchDown];
    ViewAnimation *rapid=LastCapsuleAnimation();
    Check(CGRectEqualToRect(rapid.beforeFrame,restB) && (rapid.options & UIViewAnimationOptionBeginFromCurrentState) && shared.layer.animationClears==clears,@"rapid second press preserves UIKit presentation handoff without rewriting its starting frame");
    [c sendActionsForControlEvents:UIControlEventTouchUpInside];
    Check(v.indicatorView==shared && CGRectEqualToRect(shared.frame,restC) && v.selectedIndex==2 && v.selectionCallbacks==2 && v.haptics==2,@"rapid taps move the same background and cannot leave duplicate selected capsules");
    Check(!a.titleLabel.layer.animationAdds && !a.capsuleTitleLabel.layer.animationAdds && !b.titleLabel.layer.animationAdds && !b.capsuleTitleLabel.layer.animationAdds,@"title alpha never starts independent Core Animation transitions");

    v=Fixture(); a=v.tabButtons[0];
    [a sendActionsForControlEvents:UIControlEventTouchDown];
    Check(CGRectGetWidth(v.indicatorView.frame)>CGRectGetWidth(restA) && fabs(LastCapsuleAnimation().duration-.12)<.001,@"the selected capsule also gets immediate press feedback");
    [a sendActionsForControlEvents:UIControlEventTouchUpInside];
    Check(CGRectEqualToRect(v.indicatorView.frame,restA) && IsCapsuleSpring(LastCapsuleAnimation()) && !v.selectionCallbacks && !v.haptics,@"same-tab release springs back without committing a group");
    for (NSNumber *event in @[@(UIControlEventTouchUpOutside),@(UIControlEventTouchCancel)]) {
        v=Fixture(); b=v.tabButtons[1];
        [b sendActionsForControlEvents:UIControlEventTouchDown]; [b sendActionsForControlEvents:event.unsignedIntegerValue];
        Check(v.selectedIndex==0 && CGRectEqualToRect(v.indicatorView.frame,restA) && IsCapsuleSpring(LastCapsuleAnimation()) && !v.capsulePressedButton && v.capsuleTouchConsumed && !v.selectionCallbacks && !v.haptics,@"UpOutside and Cancel spring the shared capsule back without committing");
        [b sendActionsForControlEvents:UIControlEventTouchUpInside];
        Check(v.selectedIndex==0 && !v.selectionCallbacks && !v.haptics,@"cancelled touch suppresses its stale UpInside");
    }
    v=Fixture(); b=v.tabButtons[1];
    [b sendActionsForControlEvents:UIControlEventTouchDown]; [b sendActionsForControlEvents:UIControlEventTouchDragExit];
    Check(!v.capsulePressedButton && CGRectEqualToRect(v.indicatorView.frame,restA) && IsCapsuleSpring(LastCapsuleAnimation()) && !v.selectionCallbacks,@"drag exit settles the same background to the committed group");
    [b sendActionsForControlEvents:UIControlEventTouchDragEnter];
    Check(v.capsulePressedButton==b && fabs(LastCapsuleAnimation().duration-.12)<.001 && b.capsuleProgress==1,@"drag re-entry immediately resumes the shared capsule press");
    [b sendActionsForControlEvents:UIControlEventTouchUpInside];
    Check(v.selectedIndex==1 && v.selectionCallbacks==1 && v.haptics==1,@"exit and re-entry still commit once on release");

    v=Fixture(); b=v.tabButtons[1]; c=v.tabButtons[2];
    [b sendActionsForControlEvents:UIControlEventTouchDown]; animationCount=viewAnimations.count;
    [v updateInteractiveTransitionToIndex:2 progress:.4];
    Check(v.capsuleTouchConsumed && !v.capsulePressedButton && v.interactiveTransition && v.selectedIndex==0 && !v.selectionCallbacks && !v.haptics,@"group pan consumes the native button touch without committing");
    Check(CGRectEqualToRect(v.indicatorView.frame,CGRectMake(90,5,60,34)) && v.tabButtons[1].capsuleProgress==0 && fabs(c.capsuleProgress-.4)<.001,@"group pan interpolates one background frame directly toward its target");
    Check(fabs(v.tabButtons[0].capsuleTitleLabel.alpha-.6)<.001 && fabs(c.capsuleTitleLabel.alpha-.4)<.001 && viewAnimations.count==animationCount,@"interactive title alpha follows the finger without queued UIView animations");
    CGRect panFrame=v.indicatorView.frame; [v updateIndicatorPosition];
    Check(CGRectEqualToRect(v.indicatorView.frame,panFrame) && fabs(c.capsuleProgress-.4)<.001,@"passive layout preserves the shared capsule's group-pan progress");
    [v updateInteractiveTransitionToIndex:2 progress:.15];
    Check(CGRectGetMinX(v.indicatorView.frame)<CGRectGetMinX(panFrame) && fabs(c.capsuleProgress-.15)<.001,@"reversing a pan reverses both shared frame and title alpha immediately");
    [v cancelInteractiveTransition]; [b sendActionsForControlEvents:UIControlEventTouchUpInside];
    Check(v.selectedIndex==0 && CGRectEqualToRect(v.indicatorView.frame,restA) && !v.selectionCallbacks && !v.haptics,@"stale Up cannot commit after a cancelled group pan");
    v=Fixture(); b=v.tabButtons[1];
    [b sendActionsForControlEvents:UIControlEventTouchDown]; [v updateInteractiveTransitionToIndex:2 progress:.6];
    panFrame=v.indicatorView.frame; [v selectTabAtIndex:2 animated:YES];
    Check(IsCapsuleSpring(LastCapsuleAnimation()) && CGRectEqualToRect(LastCapsuleAnimation().beforeFrame,panFrame),@"group-pan commit springs from its interactive frame");
    [b sendActionsForControlEvents:UIControlEventTouchUpInside];
    Check(v.selectedIndex==2 && [v.selectedTabID isEqual:@"tab2"] && !v.selectionCallbacks && v.haptics==1 && CGRectEqualToRect(v.indicatorView.frame,restC),@"stale Up cannot override a committed group pan");
    [b sendActionsForControlEvents:UIControlEventTouchDown]; [b sendActionsForControlEvents:UIControlEventTouchUpInside];
    Check(v.selectedIndex==1 && v.selectionCallbacks==1 && v.haptics==2,@"a fresh touch works normally after pan takeover");

    v=Fixture(); b=v.tabButtons[1]; UITouch *touch=[UITouch new]; UIEvent *touchEvent=[UIEvent new];
    touch.sample=CGPointMake(40,26);
    Check([b beginTrackingWithTouch:touch withEvent:touchEvent] && b.capsuleHasTouchPoint && CGPointEqualToPoint(b.capsuleTouchPoint,touch.sample) && b.baseTrackingBegins==1,@"real beginTracking captures the native touch location and forwards to UIButton");
    CGRect centered=[v capsuleFrameForButton:b pressed:YES]; touch.sample=CGPointMake(0,26);
    Check([b continueTrackingWithTouch:touch withEvent:touchEvent] && CGPointEqualToPoint(b.capsuleTouchPoint,touch.sample) && b.baseTrackingContinues==1,@"real continueTracking keeps the native press location current");
    CGRect edge=[v capsuleFrameForButton:b pressed:YES];
    Check(CGRectGetWidth(edge)<CGRectGetWidth(centered) && fabs(CGRectGetMidX(edge)-100)<1,@"press position and expansion follow the sampled finger location");
    b.capsuleTouchPoint=CGPointMake(-500,26); CGRect clippedLeft=[v capsuleFrameForButton:b pressed:YES];
    b.capsuleTouchPoint=CGPointMake(500,26); CGRect clippedRight=[v capsuleFrameForButton:b pressed:YES];
    CGRect contentBounds=CGRectMake(0,0,300,52);
    Check(CGRectContainsRect(contentBounds,clippedLeft) && CGRectContainsRect(contentBounds,clippedRight),@"extreme press samples keep the shared capsule within the strip's content bounds");
    b.bounds=CGRectMake(0,0,255,52); b.measuredTitleFrame=CGRectMake(6,12,200,20);
    b.frame=CGRectMake(0,0,255,52); b.capsuleHasTouchPoint=NO;
    CGRect longPress=[v capsuleFrameForButton:b pressed:YES];
    Check(CGRectContainsRect(contentBounds,longPress) && CGRectGetWidth(longPress)>200 && CATransform3DIsIdentity(b.unreadBadge.layer.transform),@"long title plus badge retains bounded shared geometry and an unscaled badge");

    v=Fixture(); b=v.tabButtons[1]; CSGroupSetIndicatorStyle(testDefaults,CSGroupIndicatorStyleNone);
    animationCount=viewAnimations.count; [b sendActionsForControlEvents:UIControlEventTouchDown];
    Check(v.indicatorStyle==CSGroupIndicatorStyleCapsule && !v.capsulePressedButton && v.capsuleTouchButton==b && CGRectEqualToRect(v.indicatorView.frame,restA) && viewAnimations.count==animationCount,@"disabled effects retain touch ownership while suppressing the cached capsule press");
    [v selectTabAtIndex:2 animated:YES]; [b sendActionsForControlEvents:UIControlEventTouchUpInside];
    Check(v.selectedIndex==2 && !v.selectionCallbacks && v.haptics==1 && viewAnimations.count==animationCount,@"animation-off pan commit still consumes stale native Up without overriding its result");
    for (NSNumber *reduce in @[@NO,@YES]) {
        CSGroupSetIndicatorStyle(testDefaults,CSGroupIndicatorStyleCapsule); v=Fixture(); b=v.tabButtons[1];
        reducedMotion=reduce.boolValue;
        if (!reducedMotion) CSGroupSetIndicatorStyle(testDefaults,CSGroupIndicatorStyleNone);
        [b sendActionsForControlEvents:UIControlEventTouchDown]; animationCount=viewAnimations.count;
        [v updateInteractiveTransitionToIndex:99 progress:.4];
        [v updateInteractiveTransitionToIndex:2 progress:NAN];
        Check(!v.capsuleTouchConsumed && v.capsuleTouchButton==b,@"invalid pan target or progress never consumes the native touch when effects are suppressed");
        [v updateInteractiveTransitionToIndex:2 progress:.4];
        Check(v.capsuleTouchConsumed && !v.capsulePressedButton && !v.interactiveTransition && v.selectedIndex==0 && CGRectEqualToRect(v.indicatorView.frame,restA),@"valid pan takes ownership and restores resting geometry when animation is off or reduce motion is enabled");
        [v cancelInteractiveTransition]; [b sendActionsForControlEvents:UIControlEventTouchUpInside];
        Check(v.selectedIndex==0 && !v.selectionCallbacks && !v.haptics && viewAnimations.count==animationCount && CGRectEqualToRect(v.indicatorView.frame,restA),@"cancelled pan with suppressed effects cannot turn its late native Up into a selection");
        reducedMotion=NO;
    }
    CSGroupSetIndicatorStyle(testDefaults,CSGroupIndicatorStyleCapsule);
    v=Fixture(); b=v.tabButtons[1]; reducedMotion=YES; animationCount=viewAnimations.count;
    [b sendActionsForControlEvents:UIControlEventTouchDown];
    Check(b.capsuleProgress==1 && viewAnimations.count==animationCount && CGRectGetWidth(v.indicatorView.frame)>60,@"reduce motion applies the pressed frame immediately without animation");
    [b sendActionsForControlEvents:UIControlEventTouchUpInside];
    Check(v.selectedIndex==1 && CGRectEqualToRect(v.indicatorView.frame,restB) && viewAnimations.count==animationCount,@"reduce motion commits directly to the resting shared frame");
    reducedMotion=NO; v=Fixture(); b=v.tabButtons[1]; v.window=nil; animationCount=viewAnimations.count;
    [b sendActionsForControlEvents:UIControlEventTouchDown];
    Check(!v.capsulePressedButton && b.capsuleProgress==0 && viewAnimations.count==animationCount,@"offscreen capsule suppresses press feedback");
    [v selectTabAtIndex:1 animated:YES];
    Check(CGRectEqualToRect(v.indicatorView.frame,restB) && viewAnimations.count==animationCount,@"offscreen selection updates the shared model without animation");
    v=Fixture(); [v.indicatorView.layer addAnimation:[CABasicAnimation animation] forKey:@"UIKit.position"];
    [v.tabButtons[0].titleLabel.layer addAnimation:[CABasicAnimation animation] forKey:@"UIKit.opacity"];
    [v.tabButtons[0].capsuleTitleLabel.layer addAnimation:[CABasicAnimation animation] forKey:@"UIKit.opacity"];
    [v updateIndicatorPositionAnimated:NO];
    Check(!v.indicatorView.layer.animationKeys.count && !v.tabButtons[0].titleLabel.layer.animationKeys.count && !v.tabButtons[0].capsuleTitleLabel.layer.animationKeys.count,@"nonanimated refresh clears shared and label animations even for an unchanged target");
    [v updateInteractiveTransitionToIndex:0 progress:.5]; [v updateInteractiveTransitionToIndex:1 progress:INFINITY];
    Check(!v.interactiveTransition && CGRectEqualToRect(v.indicatorView.frame,restA),@"same-tab and nonfinite pan inputs cannot corrupt shared capsule geometry");
    v.selectedIndex=NSNotFound; [v updateIndicatorPositionAnimated:NO];
    Check(v.indicatorView.hidden && !v.indicatorView.layer.animationKeys.count,@"removed selection hides and stops the shared background");
    v=Fixture(); b=v.tabButtons[1]; [b configureCapsuleEnabled:NO color:nil textColor:nil];
    Check(!b.capsuleTitleLabel && b.titleLabel.alpha==1 && !b.titleLabel.layer.animationKeys.count,@"leaving capsule style releases the overlay and restores the normal title");

    v=Fixture();
    Check(!v.scrollView.delaysContentTouches && v.scrollView.canCancelContentTouches,@"capsule scroll policy delivers Down immediately and permits takeover");
    Check([v.scrollView touchesShouldCancelInContentView:v.tabButtons[0]] && ![v.scrollView touchesShouldCancelInContentView:[UIView new]],@"capsule strip cancels tab controls while preserving superclass behavior for other views");
    CSGroupSetIndicatorStyle(testDefaults,CSGroupIndicatorStyleUnderline); [v refreshTouchAppearance];
    Check(v.scrollView.delaysContentTouches && ![v.scrollView touchesShouldCancelInContentView:v.tabButtons[0]],@"underline retains its original delayed-touch cancellation policy");
    v=Fixture(); b=v.tabButtons[1]; [b sendActionsForControlEvents:UIControlEventTouchDown];
    Check(!v.capsulePressedButton && v.selectedIndex==0 && !v.selectionCallbacks && !v.haptics,@"underline ignores the shared capsule Down preview");
    [b sendActionsForControlEvents:UIControlEventTouchUpInside]; first=(id)[v.indicatorView.layer animationForKey:kIndicatorAnimationKey];
    Check(v.selectedIndex==1 && v.selectionCallbacks==1 && v.haptics==1 && first && fabs(first.duration-.20)<.001,@"underline release preserves its callback and 200ms selection transition");
    CSGroupSetIndicatorStyle(testDefaults,CSGroupIndicatorStyleNone); v.indicatorStyle=CSGroupIndicatorStyleNone;
    [v updateIndicatorPositionAnimated:NO];
    Check(!v.indicatorView.hidden && ![v.indicatorView.layer animationForKey:kIndicatorAnimationKey],@"disabled style preserves its original static underline");
    CheckPublishedPageHandoff();
    [testDefaults removePersistentDomainForName:suite];
    printf("Group indicator: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
    return failures ? 1 : 0;
} }
