#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#include <math.h>

// UIKit doubles observe the complete production animator without substituting
// its clipping, capture, cancellation, hierarchy, or animation decisions.
typedef struct { CGFloat top,left,bottom,right; } UIEdgeInsets;
static const UIEdgeInsets UIEdgeInsetsZero={0,0,0,0};
enum { UIViewAnimationOptionCurveEaseOut=1, UIViewAnimationOptionAllowUserInteraction=2 };
static BOOL reducedMotion;
static BOOL UIAccessibilityIsReduceMotionEnabled(void) { return reducedMotion; }
static NSUInteger checks, failures, nonanimatedUpdates;
static void Check(BOOL value,NSString *message) {
    checks++; if (!value) { failures++; fprintf(stderr,"FAIL: %s\n",message.UTF8String); }
}
static BOOL Near(CGFloat a,CGFloat b) { return fabs(a-b)<0.0001; }
static NSValue *TransformValue(CGAffineTransform t) { return [NSValue valueWithBytes:&t objCType:@encode(CGAffineTransform)]; }
static CGAffineTransform ReadTransform(NSValue *value) { CGAffineTransform t; [value getValue:&t size:sizeof(t)]; return t; }
@class UIView, AnimationRecord;
static NSMutableArray<UIView *> *snapshots;
static NSMutableArray<AnimationRecord *> *animations;

@interface AnimationLayer : NSObject
@property(nonatomic) NSUInteger removals;
@property(nonatomic,copy) void (^onRemove)(void);
- (void)removeAllAnimations;
@end
@implementation AnimationLayer
- (void)removeAllAnimations { self.removals++; if (self.onRemove) self.onRemove(); }
@end

@interface UIView : NSObject
@property(nonatomic) CGRect frame,bounds;
@property(nonatomic) CGFloat alpha;
@property(nonatomic) CGAffineTransform transform;
@property(nonatomic) BOOL clipsToBounds,userInteractionEnabled,accessibilityElementsHidden;
@property(nonatomic,strong) id backgroundColor;
@property(nonatomic,weak) UIView *window,*superview;
@property(nonatomic,strong) NSMutableArray<UIView *> *children;
@property(nonatomic,readonly) NSArray<UIView *> *subviews;
@property(nonatomic,strong) AnimationLayer *layer;
@property(nonatomic) CGRect capturedRect;
@property(nonatomic) BOOL capturedAfterUpdates;
@property(nonatomic) NSUInteger capturedVersion;
- (instancetype)initWithFrame:(CGRect)frame;
- (CGRect)convertRect:(CGRect)rect fromView:(UIView *)view;
- (void)addSubview:(UIView *)view;
- (void)insertSubview:(UIView *)view aboveSubview:(UIView *)sibling;
- (void)removeFromSuperview;
- (BOOL)isDescendantOfView:(UIView *)view;
+ (void)performWithoutAnimation:(void (^)(void))actions;
+ (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(NSUInteger)options
                animations:(void (^)(void))actions completion:(void (^)(BOOL))completion;
@end
@interface AnimationRecord : NSObject
@property(nonatomic) NSTimeInterval duration,delay;
@property(nonatomic) NSUInteger options;
@property(nonatomic,copy) NSArray<NSValue *> *beforeTransforms,*afterTransforms;
@property(nonatomic,copy) NSArray<NSNumber *> *beforeAlphas,*afterAlphas;
@property(nonatomic,copy) void (^completion)(BOOL);
@end
@implementation AnimationRecord @end
static CGPoint AbsolutePoint(UIView *view,CGPoint point) {
    for (UIView *p=view;p;p=p.superview) {
        point.x+=p.frame.origin.x-p.bounds.origin.x;
        point.y+=p.frame.origin.y-p.bounds.origin.y;
    }
    return point;
}
@implementation UIView
- (instancetype)init { return [self initWithFrame:CGRectZero]; }
- (instancetype)initWithFrame:(CGRect)frame {
    if ((self=[super init])) {
        _frame=frame; _bounds=(CGRect){CGPointZero,frame.size};
        _alpha=1; _transform=CGAffineTransformIdentity; _userInteractionEnabled=YES;
        _children=[NSMutableArray array]; _layer=[AnimationLayer new];
    }
    return self;
}
- (NSArray<UIView *> *)subviews { return self.children.copy; }
- (CGRect)convertRect:(CGRect)rect fromView:(UIView *)view {
    CGPoint source=AbsolutePoint(view,rect.origin),target=AbsolutePoint(self,CGPointZero);
    return (CGRect){CGPointMake(source.x-target.x,source.y-target.y),rect.size};
}
- (void)addSubview:(UIView *)view { [view removeFromSuperview]; view.superview=self; [self.children addObject:view]; }
- (void)insertSubview:(UIView *)view aboveSubview:(UIView *)sibling {
    [view removeFromSuperview]; view.superview=self;
    NSUInteger index=[self.children indexOfObjectIdenticalTo:sibling];
    [self.children insertObject:view atIndex:index==NSNotFound ? self.children.count : index+1];
}
- (void)removeFromSuperview { [self.superview.children removeObjectIdenticalTo:self]; self.superview=nil; }
- (BOOL)isDescendantOfView:(UIView *)view {
    for (UIView *parent=self;parent;parent=parent.superview) if (parent==view) return YES;
    return NO;
}
+ (void)performWithoutAnimation:(void (^)(void))actions { nonanimatedUpdates++; actions(); }
+ (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(NSUInteger)options
                animations:(void (^)(void))actions completion:(void (^)(BOOL))completion {
    AnimationRecord *record=[AnimationRecord new];
    NSMutableArray *transforms=[NSMutableArray array],*alphas=[NSMutableArray array];
    for (UIView *v in snapshots) { [transforms addObject:TransformValue(v.transform)]; [alphas addObject:@(v.alpha)]; }
    record.beforeTransforms=transforms.copy; record.beforeAlphas=alphas.copy;
    actions(); [transforms removeAllObjects]; [alphas removeAllObjects];
    for (UIView *v in snapshots) { [transforms addObject:TransformValue(v.transform)]; [alphas addObject:@(v.alpha)]; }
    record.afterTransforms=transforms.copy; record.afterAlphas=alphas.copy;
    record.duration=duration; record.delay=delay; record.options=options; record.completion=completion;
    [animations addObject:record];
}
@end

@interface UITableView : UIView
@property(nonatomic) UIEdgeInsets adjustedContentInset;
@property(nonatomic) NSUInteger sourceVersion,snapshotRequests;
@property(nonatomic) BOOL failNextSnapshot;
@property(nonatomic,copy) void (^onSnapshot)(BOOL afterUpdates);
- (UIView *)resizableSnapshotViewFromRect:(CGRect)rect afterScreenUpdates:(BOOL)afterUpdates withCapInsets:(UIEdgeInsets)insets;
@end
@implementation UITableView
- (UIView *)resizableSnapshotViewFromRect:(CGRect)rect afterScreenUpdates:(BOOL)afterUpdates withCapInsets:(UIEdgeInsets)insets {
    self.snapshotRequests++;
    if (self.onSnapshot) self.onSnapshot(afterUpdates);
    if (self.failNextSnapshot) { self.failNextSnapshot=NO; return nil; }
    UIView *snapshot=[UIView new]; snapshot.capturedRect=rect;
    snapshot.capturedAfterUpdates=afterUpdates; snapshot.capturedVersion=self.sourceVersion;
    [snapshots addObject:snapshot]; return snapshot;
}
@end

@interface CSGroupPageAnimator : NSObject
@property(nonatomic,readonly,getter=isActive) BOOL active;
@property(nonatomic,readonly,getter=isAnimating) BOOL animating;
@property(nonatomic,readonly) CGFloat progress;
- (BOOL)beginWithTable:(UITableView *)table belowView:(UIView *)rail direction:(NSInteger)direction;
- (BOOL)matchesTable:(UITableView *)table belowView:(UIView *)rail;
- (BOOL)ownsTouchView:(UIView *)view;
- (BOOL)prepareIncomingWithTable:(UITableView *)table belowView:(UIView *)rail readiness:(BOOL (^)(void))readiness;
- (BOOL)updateTranslation:(CGFloat)translation;
- (void)settleCommitting:(BOOL)commit velocity:(CGFloat)velocity readiness:(BOOL (^)(void))readiness completion:(void (^)(BOOL))completion;
- (void)cancel;
@end
#include "GroupPageAnimatorUnderTest.h"

static void Reset(void) { snapshots=[NSMutableArray array]; animations=[NSMutableArray array]; reducedMotion=NO; nonanimatedUpdates=0; }
static UITableView *Fixture(UIView **windowOut,UIView **hostOut,UIView **railOut) {
    UIView *window=[[UIView alloc] initWithFrame:CGRectMake(0,0,390,844)];
    UIView *host=[[UIView alloc] initWithFrame:window.bounds]; [window addSubview:host];
    UITableView *table=[[UITableView alloc] initWithFrame:CGRectMake(12,24,366,800)];
    table.bounds=CGRectMake(0,200,366,800); table.window=window;
    table.adjustedContentInset=(UIEdgeInsets){64,0,96,0}; table.sourceVersion=1;
    table.backgroundColor=[NSObject new]; [host addSubview:table];
    UIView *rail=[[UIView alloc] initWithFrame:CGRectMake(20,90,350,76)]; rail.window=window;
    [host addSubview:rail];
    UIView *bar=[[UIView alloc] initWithFrame:CGRectMake(20,740,350,80)]; [host addSubview:bar];
    *windowOut=window; *hostOut=host; *railOut=rail; return table;
}
static void Complete(AnimationRecord *record,BOOL finished) { if (record.completion) record.completion(finished); }

static BOOL Prepare(CSGroupPageAnimator *animator,UITableView *table,UIView *rail) {
    return [animator prepareIncomingWithTable:table belowView:rail readiness:^BOOL { return YES; }];
}
static void TestRealPagesAndGeometry(void) {
    Reset(); UIView *window,*host,*rail; UITableView *table=Fixture(&window,&host,&rail);
    CSGroupPageAnimator *animator=[CSGroupPageAnimator new];
    Check([animator beginWithTable:table belowView:rail direction:1],@"valid next-group pan captures its outgoing real list");
    UIView *overlay=animator.overlay;
    Check(animator.active && !animator.animating && snapshots.count==1 && animations.count==0 && Near(animator.progress,0),@"begin holds a stable source cover before neighbor rendering");
    Check(overlay.superview==host && ![table.subviews containsObject:overlay],@"cover is a sibling and never changes table contents or header geometry");
    Check(host.subviews[1]==overlay && host.subviews[2]==rail && host.subviews.lastObject.frame.origin.y==740,@"fixed rail and floating bottom bar remain above the page cover");
    Check(CGRectEqualToRect(overlay.frame,CGRectMake(12,166,366,658)),@"cover starts below rail and extends through the visible floating-bar bottom strip");
    Check(overlay.clipsToBounds && overlay.userInteractionEnabled && overlay.accessibilityElementsHidden,@"clipped cover intercepts stale row taps and stays out of accessibility");
    Check(CGRectEqualToRect(snapshots[0].capturedRect,CGRectMake(0,342,366,658)) && !snapshots[0].capturedAfterUpdates && snapshots[0].capturedVersion==1,@"old real content is captured in scrolled table coordinates before updates");
    Check(![animator updateTranslation:-60] && animator.active && animations.count==0 && Near(animator.progress,0),@"a pan cannot expose the target before its real snapshot is prepared");
    table.sourceVersion=2; table.bounds=CGRectMake(0,620,366,800);
    Check([animator matchesTable:table belowView:rail],@"neighbor preview may restore its content offset with a stable on-screen viewport");
    table.onSnapshot=^(BOOL after) { if (after) Check(animator.overlay==overlay && overlay.subviews.count==1,@"source cover remains installed during synchronous target rendering"); };
    Check(Prepare(animator,table,rail),@"real target prepares after its publication proof passes"); table.onSnapshot=nil;
    Check(snapshots[1].capturedAfterUpdates && snapshots[1].capturedVersion==2 && CGRectEqualToRect(snapshots[1].capturedRect,CGRectMake(0,762,366,658)),@"incoming page captures the real neighboring list including restored scroll position");
    Check(CGRectEqualToRect(snapshots[0].frame,snapshots[1].frame) && Near(snapshots[1].transform.tx,366),@"equal-width neighboring page starts exactly one viewport away");
    NSUInteger requests=table.snapshotRequests;
    Check(Prepare(animator,table,rail) && table.snapshotRequests==requests,@"duplicate preparation reuses the validated neighbor instead of taking another snapshot");
    Check([animator updateTranslation:-91.5] && Near(animator.progress,.25) && Near(snapshots[0].transform.tx,-91.5) && Near(snapshots[1].transform.tx,274.5),@"changed translation moves both pages immediately to the finger's quarter-width progress");
    Check([animator updateTranslation:-219.6] && Near(animator.progress,.6) && Near(snapshots[0].transform.tx,-219.6) && Near(snapshots[1].transform.tx,146.4),@"continued movement tracks the latest pan rather than queuing motion");
    Check([animator updateTranslation:-91.5] && Near(animator.progress,.25) && animations.count==0 && nonanimatedUpdates==3,@"reversing within the same neighbor follows directly without an implicit or explicit animation");
    __block NSUInteger completed=0; __block BOOL committed=NO;
    [animator settleCommitting:YES velocity:0 readiness:^BOOL { return YES; } completion:^(BOOL value) { completed++; committed=value; }];
    Check(animator.active && animator.animating && animations.count==1 && completed==0,@"release starts one settle from the current interactive position");
    AnimationRecord *record=animations.lastObject;
    Check(Near(record.duration,.21) && Near(record.delay,0) && record.options==(UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionAllowUserInteraction),@"settle duration reflects the remaining distance with one ease-out motion");
    CGAffineTransform oldBefore=ReadTransform(record.beforeTransforms[0]),oldAfter=ReadTransform(record.afterTransforms[0]);
    CGAffineTransform newBefore=ReadTransform(record.beforeTransforms[1]),newAfter=ReadTransform(record.afterTransforms[1]);
    Check(Near(oldBefore.tx,-91.5) && Near(oldAfter.tx,-366) && Near(newBefore.tx,274.5) && CGAffineTransformIsIdentity(newAfter),@"commit continues from the current finger position to the neighboring page");
    Check(Near(oldAfter.a,1) && Near(oldAfter.d,1) && Near(oldAfter.ty,0) && Near(newBefore.a,1) && Near(newBefore.d,1) && Near(newBefore.ty,0),@"page movement adds no scaling or vertical displacement");
    Check([record.beforeAlphas isEqual:@[@1,@1]] && [record.afterAlphas isEqual:@[@1,@1]],@"both real pages remain opaque throughout the translation");
    Check(CGAffineTransformIsIdentity(table.transform) && Near(table.alpha,1),@"real table never receives animation transforms or alpha changes");
    [animator settleCommitting:NO velocity:200 readiness:^BOOL { return YES; } completion:^(BOOL value) { completed+=100; }];
    Check(![animator updateTranslation:-10] && animations.count==1 && completed==0,@"duplicate release and late Changed cannot interrupt a settle or complete early");
    Complete(record,YES);
    Check(!animator.active && !animator.animating && completed==1 && committed && !overlay.superview,@"successful completion removes both snapshots before reporting a committed neighbor");
    Check(host.subviews.count==3 && Near(animator.progress,0),@"completion retains original fixed controls and clears interactive state");
    (void)window;
}

static void TestPreviousDirectionAndRollback(void) {
    Reset(); UIView *window,*host,*rail; UITableView *table=Fixture(&window,&host,&rail);
    [rail removeFromSuperview]; rail.frame=CGRectMake(0,270,366,76); [table addSubview:rail];
    CSGroupPageAnimator *animator=[CSGroupPageAnimator new];
    Check([animator beginWithTable:table belowView:rail direction:-1],@"a rail inside the table header supports an interactive previous-group pan");
    Check(CGRectEqualToRect(animator.overlay.frame,CGRectMake(12,170,366,654)),@"nested rail is converted from its bounds into host coordinates");
    Prepare(animator,table,rail); [animator updateTranslation:91.5];
    Check(Near(animator.progress,.25) && Near(snapshots[0].transform.tx,91.5) && Near(snapshots[1].transform.tx,-274.5),@"previous-group pan moves both equal-width pages in the reverse direction");
    __block NSUInteger completed=0; __block BOOL committed=YES;
    [animator settleCommitting:NO velocity:-500 readiness:^BOOL { return YES; } completion:^(BOOL value) { completed++; committed=value; }];
    AnimationRecord *record=animations.lastObject;
    Check(Near(ReadTransform(record.beforeTransforms[0]).tx,91.5) && Near(ReadTransform(record.afterTransforms[0]).tx,0) && Near(ReadTransform(record.afterTransforms[1]).tx,-366),@"cancelled pan rebounds from its current position to the complete source page");
    Check(Near(record.duration,.12),@"short cancellation uses the bounded minimum settling duration");
    Complete(record,YES);
    Check(!animator.active && completed==1 && !committed,@"completed rebound reports cancellation for the caller to restore its source preview");
    [animator beginWithTable:table belowView:rail direction:-1]; Prepare(animator,table,rail); [animator updateTranslation:250];
    [animator settleCommitting:YES velocity:300 readiness:^BOOL { return YES; } completion:^(BOOL value) { completed++; committed=value; }];
    Complete(animations.lastObject,NO);
    Check(!animator.active && completed==2 && !committed,@"interrupted UIKit settling reports rollback and releases the cover");
    (void)window; (void)host;
}

static void TestClampingAndTiming(void) {
    Reset(); UIView *window,*host,*rail; UITableView *table=Fixture(&window,&host,&rail);
    CSGroupPageAnimator *animator=[CSGroupPageAnimator new];
    [animator beginWithTable:table belowView:rail direction:1]; Prepare(animator,table,rail);
    [animator updateTranslation:-1000];
    Check(Near(animator.progress,1) && Near(snapshots[0].transform.tx,-366) && Near(snapshots[1].transform.tx,0),@"overshoot clamps at one page width");
    __block NSUInteger completed=0;
    [animator settleCommitting:YES velocity:-1000 readiness:^BOOL { return YES; } completion:^(BOOL value) { if (value) completed++; }];
    Check(!animator.active && completed==1 && animations.count==0,@"already completed page commits immediately without adding a fake settle");
    [animator beginWithTable:table belowView:rail direction:1]; Prepare(animator,table,rail);
    [animator updateTranslation:90];
    Check(Near(animator.progress,0) && Near(animator.outgoing.transform.tx,0) && Near(animator.incoming.transform.tx,366),@"crossing through the source clamps at zero until caller chooses the reverse neighbor");
    [animator settleCommitting:NO velocity:100 readiness:^BOOL { return YES; } completion:^(BOOL value) { if (!value) completed++; }];
    Check(!animator.active && completed==2 && animations.count==0,@"zero-progress cancellation completes synchronously");
    [animator beginWithTable:table belowView:rail direction:1]; Prepare(animator,table,rail);
    [animator settleCommitting:YES velocity:0 readiness:^BOOL { return YES; } completion:nil];
    Check(Near(animations.lastObject.duration,.28),@"full-distance zero-speed settle is capped at 280ms");
    Complete(animations.lastObject,YES);
    [animator beginWithTable:table belowView:rail direction:1]; Prepare(animator,table,rail); [animator updateTranslation:-73.2];
    [animator settleCommitting:YES velocity:-2000 readiness:^BOOL { return YES; } completion:nil];
    Check(Near(animations.lastObject.duration,.1464),@"a release toward the destination shortens settling based on remaining points divided by speed");
    Complete(animations.lastObject,YES);
    [animator beginWithTable:table belowView:rail direction:1]; Prepare(animator,table,rail); [animator updateTranslation:-73.2];
    [animator settleCommitting:YES velocity:2000 readiness:^BOOL { return YES; } completion:nil];
    Check(Near(animations.lastObject.duration,.224),@"velocity away from the chosen destination does not accelerate that commit");
    Complete(animations.lastObject,YES);
    [animator beginWithTable:table belowView:rail direction:1]; Prepare(animator,table,rail); [animator updateTranslation:-73.2];
    [animator settleCommitting:YES velocity:-100000 readiness:^BOOL { return YES; } completion:nil];
    Check(Near(animations.lastObject.duration,.12),@"extreme release speed is bounded at 120ms");
    Complete(animations.lastObject,YES);
    [animator beginWithTable:table belowView:rail direction:1]; Prepare(animator,table,rail);
    Check(![animator updateTranslation:NAN] && !animator.active,@"nonfinite pan input cancels before creating invalid transforms");
    (void)window; (void)host;
}

static void TestCancellationAndObsoleteCallbacks(void) {
    Reset(); UIView *window,*host,*rail; UITableView *table=Fixture(&window,&host,&rail);
    CSGroupPageAnimator *animator=[CSGroupPageAnimator new]; __block NSUInteger completed=0,reentrant=0;
    [animator beginWithTable:table belowView:rail direction:1]; Prepare(animator,table,rail); [animator updateTranslation:-150];
    [animator settleCommitting:YES velocity:0 readiness:^BOOL { return YES; } completion:^(BOOL value) { completed++; }];
    UIView *old=animator.overlay; AnimationRecord *oldAnimation=animations.lastObject;
    old.subviews.firstObject.layer.onRemove=^{
        reentrant++; Check(!animator.active && !animator.animating,@"privacy cancellation releases ownership before synchronous CA removal callbacks");
        Complete(oldAnimation,NO);
    };
    [animator cancel]; [animator cancel];
    Check(reentrant==1 && completed==0 && !old.superview,@"immediate privacy cancellation removes pages without invoking obsolete transaction completion");
    [animator beginWithTable:table belowView:rail direction:-1]; UIView *newCover=animator.overlay;
    Complete(oldAnimation,YES);
    Check(animator.overlay==newCover && newCover.superview==host && completed==0,@"late completion from an old generation cannot affect the newer group switch");
    for (UIView *page in old.subviews) Check(page.layer.removals==1,@"cancel removes every old page layer animation exactly once");
    old.subviews.firstObject.layer.onRemove=nil; [animator cancel];
    [animator beginWithTable:table belowView:rail direction:1]; UIView *replaced=animator.overlay;
    __weak UIView *weakReplaced=replaced;
    replaced.subviews.firstObject.layer.onRemove=^{
        weakReplaced.subviews.firstObject.layer.onRemove=nil;
        [animator beginWithTable:table belowView:rail direction:-1];
    };
    Check(![animator beginWithTable:table belowView:rail direction:1] && animator.active && animator.direction==-1 && host.subviews.count==4,@"a replacement begun by layer removal survives an outer begin without a leaked second cover");
    [animator cancel];
    [animator beginWithTable:table belowView:rail direction:1]; Prepare(animator,table,rail); [animator updateTranslation:-150];
    [animator settleCommitting:YES velocity:0 readiness:^BOOL { return YES; } completion:^(BOOL value) { completed++; }];
    UIView *finishing=animator.overlay;
    __weak UIView *weakFinishing=finishing;
    finishing.subviews.firstObject.layer.onRemove=^{
        weakFinishing.subviews.firstObject.layer.onRemove=nil;
        [animator beginWithTable:table belowView:rail direction:-1];
    };
    Complete(animations.lastObject,YES);
    Check(animator.active && animator.direction==-1 && completed==0,@"replacement begun during completion cleanup suppresses the obsolete owner callback");
    [animator cancel]; (void)window;
}

static void TestFallbacksAndChangedGeometry(void) {
    Reset(); UIView *window,*host,*rail; UITableView *table=Fixture(&window,&host,&rail);
    CSGroupPageAnimator *animator=[CSGroupPageAnimator new]; __block NSUInteger completed=0;
    Check(![animator beginWithTable:table belowView:rail direction:0] && !table.snapshotRequests,@"unsupported direction falls back without taking a snapshot");
    reducedMotion=YES;
    Check(![animator beginWithTable:table belowView:rail direction:1] && !table.snapshotRequests,@"Reduce Motion bypasses page capture and displacement");
    reducedMotion=NO;
    table.onSnapshot=^(BOOL after) { if (!after) reducedMotion=YES; };
    Check(![animator beginWithTable:table belowView:rail direction:1] && !animator.active,@"Reduce Motion enabled during source capture prevents installing a cover");
    table.onSnapshot=nil; reducedMotion=NO; table.failNextSnapshot=YES;
    Check(![animator beginWithTable:table belowView:rail direction:1] && !animator.active,@"outgoing capture failure leaves no cover");
    [animator beginWithTable:table belowView:rail direction:1]; table.failNextSnapshot=YES;
    Check(!Prepare(animator,table,rail) && !animator.active && animations.count==0,@"incoming capture failure cancels without starting motion");
    [animator beginWithTable:table belowView:rail direction:1];
    rail.frame=CGRectOffset(rail.frame,0,20);
    Check(![animator matchesTable:table belowView:rail] && !Prepare(animator,table,rail) && !animator.active,@"changed header geometry invalidates the capture before neighbor preparation");
    [animator beginWithTable:table belowView:rail direction:1]; Prepare(animator,table,rail); reducedMotion=YES;
    Check(![animator updateTranslation:-90] && !animator.active,@"enabling Reduce Motion during a pan immediately removes its cover");
    reducedMotion=NO; [animator beginWithTable:table belowView:rail direction:1]; Prepare(animator,table,rail); table.window=nil;
    [animator settleCommitting:YES velocity:0 readiness:^BOOL { return YES; } completion:^(BOOL value) { if (!value) completed++; }];
    Check(!animator.active && completed==1 && animations.count==0,@"offscreen release rejects motion and reports rollback");
    Check(![animator beginWithTable:table belowView:rail direction:1],@"offscreen begin creates no cover");
    table.window=window; host.bounds=CGRectMake(0,0,390,150);
    Check(![animator beginWithTable:table belowView:rail direction:1],@"viewport fully hidden by the rail creates no empty cover");
}

static void TestVisibleBoundsAndSnapshotReentrancy(void) {
    Reset(); UIView *window,*host,*rail; UITableView *table=Fixture(&window,&host,&rail);
    CSGroupPageAnimator *animator=[CSGroupPageAnimator new];
    host.bounds=CGRectMake(0,0,390,780);
    [animator beginWithTable:table belowView:rail direction:1];
    Check(Near(CGRectGetMaxY(animator.overlay.frame),780),@"parent clipping limits the cover before the table's nominal bottom");
    [animator cancel]; host.bounds=CGRectMake(0,0,390,844); window.bounds=CGRectMake(0,0,390,770);
    [animator beginWithTable:table belowView:rail direction:1];
    Check(Near(CGRectGetMaxY(animator.overlay.frame),770),@"actual window clipping also limits the cover");
    [animator cancel]; window.bounds=CGRectMake(0,0,390,844);
    table.onSnapshot=^(BOOL after) { if (!after) [animator cancel]; };
    Check(![animator beginWithTable:table belowView:rail direction:1] && !animator.active,@"cancellation during initial capture cannot install an obsolete cover");
    table.onSnapshot=nil; [animator beginWithTable:table belowView:rail direction:1];
    __weak UITableView *weakTable=table;
    table.onSnapshot=^(BOOL after) {
        if (after) { weakTable.onSnapshot=nil; [animator beginWithTable:weakTable belowView:rail direction:-1]; }
    };
    Check(!Prepare(animator,table,rail) && animator.active && !animator.animating && animator.direction==-1 && animations.count==0,@"new pan reentered during target capture preserves its source cover and rejects old preparation");
    [animator cancel];
}

static void TestReadinessBeforeAndAfterSettling(void) {
    Reset(); UIView *window,*host,*rail; UITableView *table=Fixture(&window,&host,&rail);
    CSGroupPageAnimator *animator=[CSGroupPageAnimator new];
    __block BOOL ready=YES; __block NSUInteger completed=0; __block BOOL committed=YES;
    [animator beginWithTable:table belowView:rail direction:1];
    table.onSnapshot=^(BOOL after) { if (after) ready=NO; };
    Check(![animator prepareIncomingWithTable:table belowView:rail readiness:^BOOL { return ready; }] && !animator.active && animations.count==0,@"capture that triggers publication recovery fails its post-capture proof before any motion");
    table.onSnapshot=nil; [animator beginWithTable:table belowView:rail direction:1];
    Check(![animator prepareIncomingWithTable:table belowView:rail readiness:^BOOL { [animator cancel]; return YES; }] && !animator.active,@"cancellation inside preparation proof suppresses obsolete mounting");
    [animator beginWithTable:table belowView:rail direction:1];
    Check(![animator prepareIncomingWithTable:table belowView:rail readiness:^BOOL {
        [animator beginWithTable:table belowView:rail direction:-1]; return NO;
    }] && animator.active && animator.direction==-1,@"replacement inside preparation proof keeps the new cover even when the old proof rejects");
    Prepare(animator,table,rail); [animator updateTranslation:100];
    [animator settleCommitting:YES velocity:0 readiness:^BOOL { return NO; } completion:^(BOOL value) { completed++; committed=value; }];
    Check(!animator.active && completed==1 && !committed && animations.count==0,@"release proof failure immediately reports rollback without animation");
    [animator beginWithTable:table belowView:rail direction:1]; Prepare(animator,table,rail); [animator updateTranslation:-100];
    ready=YES;
    [animator settleCommitting:YES velocity:0 readiness:^BOOL { return ready; } completion:^(BOOL value) { completed++; committed=value; }];
    ready=NO; Complete(animations.lastObject,YES);
    Check(!animator.active && completed==2 && !committed,@"readiness invalidated while settling prevents commit at animation completion");
    [animator beginWithTable:table belowView:rail direction:1]; Prepare(animator,table,rail); [animator updateTranslation:-100];
    [animator settleCommitting:YES velocity:0 readiness:^BOOL { [animator cancel]; return YES; } completion:^(BOOL value) { completed++; }];
    Check(!animator.active && completed==2,@"explicit cancellation reentered during release proof suppresses that completion");
    [animator beginWithTable:table belowView:rail direction:1]; Prepare(animator,table,rail); [animator updateTranslation:-100];
    __block NSUInteger proofs=0;
    [animator settleCommitting:YES velocity:0 readiness:^BOOL {
        proofs++; if (proofs==2) [animator beginWithTable:table belowView:rail direction:-1]; return YES;
    } completion:^(BOOL value) { completed++; }];
    Complete(animations.lastObject,YES);
    Check(animator.active && animator.direction==-1 && !animator.animating && completed==2,@"completion proof reentry preserves the new pan and suppresses the old completion");
    [animator cancel]; (void)window; (void)host;
}

static void TestTouchOwnershipAndLifecycle(void) {
    Reset(); UIView *window,*host,*rail; UITableView *table=Fixture(&window,&host,&rail);
    UIView *bar=host.subviews.lastObject;
    UIView *row=[UIView new]; [table addSubview:row];
    UIView *sibling=[UIView new]; [host addSubview:sibling];
    CSGroupPageAnimator *animator=[CSGroupPageAnimator new];
    Check(![animator ownsTouchView:nil] && ![animator ownsTouchView:table] &&
          ![animator ownsTouchView:host] && ![animator ownsTouchView:sibling],
          @"inactive animator never claims nil, the table, the gesture host, or unrelated siblings");
    [animator beginWithTable:table belowView:rail direction:1];
    UIView *cover=animator.overlay,*outgoing=animator.outgoing;
    UIView *outgoingChild=[UIView new],*outgoingGrandchild=[UIView new];
    [outgoing addSubview:outgoingChild]; [outgoingChild addSubview:outgoingGrandchild];
    Check([animator ownsTouchView:cover] && [animator ownsTouchView:outgoing] &&
          [animator ownsTouchView:outgoingGrandchild],
          @"current cover and every outgoing snapshot descendant belong to the animator");
    Check(![animator ownsTouchView:nil] && ![animator ownsTouchView:table] &&
          ![animator ownsTouchView:row] && ![animator ownsTouchView:host] &&
          ![animator ownsTouchView:window] && ![animator ownsTouchView:rail] &&
          ![animator ownsTouchView:bar] && ![animator ownsTouchView:sibling],
          @"active ownership excludes live rows, ancestors, rail, floating bar, and other host siblings");
    [table addSubview:outgoingGrandchild];
    Check(![animator ownsTouchView:outgoingGrandchild],@"a view moved out of the cover immediately loses overlay touch ownership");
    [outgoingChild addSubview:outgoingGrandchild];
    Prepare(animator,table,rail);
    UIView *incoming=animator.incoming,*incomingChild=[UIView new]; [incoming addSubview:incomingChild];
    Check([animator ownsTouchView:incoming] && [animator ownsTouchView:incomingChild],
          @"prepared incoming page and its descendants share current cover ownership");
    [animator updateTranslation:-140];
    __block NSUInteger completed=0,reentrant=0;
    [animator settleCommitting:YES velocity:-500 readiness:^BOOL { return YES; } completion:^(BOOL value) { completed++; }];
    AnimationRecord *oldAnimation=animations.lastObject;
    Check(animator.animating && [animator ownsTouchView:cover] &&
          [animator ownsTouchView:outgoingGrandchild] && [animator ownsTouchView:incomingChild],
          @"settling cover keeps touch ownership so a new pan can reach the stable parent recognizer");
    Check(cover.userInteractionEnabled && !outgoing.userInteractionEnabled && !incoming.userInteractionEnabled,
          @"settling still intercepts stale row taps while snapshot children remain noninteractive");
    outgoing.layer.onRemove=^{
        reentrant++;
        Check(![animator ownsTouchView:cover] && ![animator ownsTouchView:outgoingGrandchild] &&
              ![animator ownsTouchView:incomingChild],
              @"cancel revokes old cover ownership before synchronous layer-removal reentry");
        Complete(oldAnimation,NO);
    };
    [animator cancel]; outgoing.layer.onRemove=nil;
    Check(reentrant==1 && completed==0 && ![animator ownsTouchView:cover] &&
          ![animator ownsTouchView:outgoing] && ![animator ownsTouchView:incomingChild],
          @"canceled cover and retained descendants stay unowned without invoking the obsolete transaction");
    [animator beginWithTable:table belowView:rail direction:-1];
    UIView *newCover=animator.overlay,*newPage=animator.outgoing;
    Complete(oldAnimation,YES);
    Check([animator ownsTouchView:newCover] && [animator ownsTouchView:newPage] &&
          ![animator ownsTouchView:cover] && ![animator ownsTouchView:outgoingGrandchild] && completed==0,
          @"late old completion cannot claim old views or revoke a replacement cover's ownership");
    Prepare(animator,table,rail); [animator updateTranslation:120];
    [animator settleCommitting:YES velocity:0 readiness:^BOOL { return YES; } completion:^(BOOL value) {
        completed++;
        Check(value && ![animator ownsTouchView:newCover] && ![animator ownsTouchView:newPage],
              @"successful settle revokes all old ownership before notifying its transaction owner");
    }];
    Complete(animations.lastObject,YES);
    Check(completed==1 && !animator.active && ![animator ownsTouchView:newCover],
          @"settled cover remains unowned after its completion returns");
    [animator beginWithTable:table belowView:rail direction:1]; Prepare(animator,table,rail);
    UIView *interruptedCover=animator.overlay,*interruptedIncoming=animator.incoming;
    [animator updateTranslation:-120];
    [animator settleCommitting:YES velocity:0 readiness:^BOOL { return YES; } completion:^(BOOL value) {
        completed++;
        Check(!value && ![animator ownsTouchView:interruptedCover] && ![animator ownsTouchView:interruptedIncoming],
              @"interrupted settle also revokes cover and incoming-page ownership before reporting rollback");
    }];
    Complete(animations.lastObject,NO);
    Check(completed==2 && !animator.active && ![animator ownsTouchView:interruptedCover],
          @"interrupted and removed cover cannot admit a later touch sequence");
}

int main(void) { @autoreleasepool {
    TestRealPagesAndGeometry(); TestPreviousDirectionAndRollback(); TestClampingAndTiming();
    TestCancellationAndObsoleteCallbacks(); TestFallbacksAndChangedGeometry();
    TestVisibleBoundsAndSnapshotReentrancy(); TestReadinessBeforeAndAfterSettling();
    TestTouchOwnershipAndLifecycle();
    fprintf(stdout,"Group page animator: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
    return failures ? 1 : 0;
} }
