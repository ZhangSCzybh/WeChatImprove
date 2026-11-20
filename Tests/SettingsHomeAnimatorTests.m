#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#include <math.h>

// Observable UIKit doubles keep animation completions asynchronous. The complete
// production animator below supplies every clipping, snapshot and transition rule.
typedef struct { CGFloat top,left,bottom,right; } UIEdgeInsets;
static const UIEdgeInsets UIEdgeInsetsZero={0,0,0,0};
enum { UIViewAnimationOptionCurveEaseOut=1, UIViewAnimationOptionAllowUserInteraction=2 };
static BOOL reducedMotion;
static BOOL UIAccessibilityIsReduceMotionEnabled(void) { return reducedMotion; }
static NSUInteger checks, failures;
static void Check(BOOL result, NSString *message) {
    checks++;
    if (!result) { failures++; fprintf(stderr,"FAIL: %s\n",message.UTF8String); }
}
static BOOL Near(CGFloat a, CGFloat b) { return fabs(a-b)<0.0001; }
static NSValue *RectValue(CGRect rect) { return [NSValue valueWithBytes:&rect objCType:@encode(CGRect)]; }
static CGRect ReadRect(NSValue *value) { CGRect rect; [value getValue:&rect size:sizeof(rect)]; return rect; }
@class UIView, AnimationRecord;
static NSMutableArray<UIView *> *snapshotViews;
static NSMutableArray<AnimationRecord *> *animations;

@interface AnimationLayer : NSObject
@property(nonatomic) NSUInteger removals;
@property(nonatomic, copy) void (^onRemoveAnimations)(void);
- (void)removeAllAnimations;
@end
@implementation AnimationLayer
- (void)removeAllAnimations { self.removals++; if (self.onRemoveAnimations) self.onRemoveAnimations(); }
@end

@interface UIView : NSObject
@property(nonatomic) CGRect frame,bounds;
@property(nonatomic) CGFloat alpha;
@property(nonatomic) CGAffineTransform transform;
@property(nonatomic) BOOL clipsToBounds,userInteractionEnabled,accessibilityElementsHidden;
@property(nonatomic, strong) id backgroundColor,window;
@property(nonatomic, weak) UIView *superview;
@property(nonatomic, strong) NSMutableArray<UIView *> *children;
@property(nonatomic, readonly) NSArray<UIView *> *subviews;
@property(nonatomic, strong) AnimationLayer *layer;
@property(nonatomic) CGRect capturedRect;
@property(nonatomic) BOOL capturedAfterUpdates;
@property(nonatomic) NSUInteger capturedVersion;
- (instancetype)initWithFrame:(CGRect)frame;
- (CGRect)convertRect:(CGRect)rect fromView:(UIView *)view;
- (void)addSubview:(UIView *)view;
- (void)insertSubview:(UIView *)view belowSubview:(UIView *)sibling;
- (void)removeFromSuperview;
+ (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(NSUInteger)options
                animations:(void (^)(void))actions completion:(void (^)(BOOL))completion;
@end
@interface AnimationRecord : NSObject
@property(nonatomic) NSTimeInterval duration,delay;
@property(nonatomic) NSUInteger options;
@property(nonatomic, strong) UIView *target;
@property(nonatomic) CGFloat beforeAlpha,afterAlpha;
@property(nonatomic) CGAffineTransform beforeTransform,afterTransform;
@property(nonatomic, copy) void (^completion)(BOOL);
@end
@implementation AnimationRecord @end

static CGPoint AbsolutePoint(UIView *view, CGPoint point) {
    for (UIView *current=view; current; current=current.superview) {
        point.x+=current.frame.origin.x-current.bounds.origin.x;
        point.y+=current.frame.origin.y-current.bounds.origin.y;
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
    CGPoint source=AbsolutePoint(view,rect.origin), target=AbsolutePoint(self,CGPointZero);
    return (CGRect){CGPointMake(source.x-target.x,source.y-target.y),rect.size};
}
- (void)addSubview:(UIView *)view {
    [view removeFromSuperview]; view.superview=self; [self.children addObject:view];
}
- (void)insertSubview:(UIView *)view belowSubview:(UIView *)sibling {
    [view removeFromSuperview]; view.superview=self;
    NSUInteger index=[self.children indexOfObjectIdenticalTo:sibling];
    [self.children insertObject:view atIndex:index==NSNotFound ? self.children.count : index];
}
- (void)removeFromSuperview { [self.superview.children removeObjectIdenticalTo:self]; self.superview=nil; }
+ (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(NSUInteger)options
                animations:(void (^)(void))actions completion:(void (^)(BOOL))completion {
    NSMutableArray<NSNumber *> *alphas=[NSMutableArray array];
    NSMutableArray<NSValue *> *transforms=[NSMutableArray array];
    for (UIView *view in snapshotViews) {
        [alphas addObject:@(view.alpha)];
        CGAffineTransform transform=view.transform;
        [transforms addObject:[NSValue valueWithBytes:&transform objCType:@encode(CGAffineTransform)]];
    }
    actions();
    AnimationRecord *record=[AnimationRecord new]; record.duration=duration; record.delay=delay;
    record.options=options; record.completion=completion;
    for (NSUInteger i=0; i<snapshotViews.count; i++) {
        UIView *view=snapshotViews[i]; CGAffineTransform previous;
        [transforms[i] getValue:&previous size:sizeof(previous)];
        if (!Near(alphas[i].doubleValue,view.alpha) || !CGAffineTransformEqualToTransform(previous,view.transform)) {
            record.target=view; record.beforeAlpha=alphas[i].doubleValue; record.afterAlpha=view.alpha;
            record.beforeTransform=previous; record.afterTransform=view.transform;
            break;
        }
    }
    [animations addObject:record];
}
@end

@interface UITableView : UIView
@property(nonatomic) UIEdgeInsets adjustedContentInset;
@property(nonatomic, copy) NSArray<NSValue *> *sectionRects;
@property(nonatomic, readonly) NSInteger numberOfSections;
@property(nonatomic) NSUInteger sourceVersion,snapshotRequests;
- (CGRect)rectForSection:(NSInteger)section;
- (UIView *)resizableSnapshotViewFromRect:(CGRect)rect afterScreenUpdates:(BOOL)afterUpdates withCapInsets:(UIEdgeInsets)insets;
@end
@implementation UITableView
- (NSInteger)numberOfSections { return self.sectionRects.count; }
- (CGRect)rectForSection:(NSInteger)section { return ReadRect(self.sectionRects[section]); }
- (UIView *)resizableSnapshotViewFromRect:(CGRect)rect afterScreenUpdates:(BOOL)afterUpdates withCapInsets:(UIEdgeInsets)insets {
    self.snapshotRequests++;
    UIView *snapshot=[UIView new]; snapshot.capturedRect=rect; snapshot.capturedAfterUpdates=afterUpdates;
    snapshot.capturedVersion=self.sourceVersion; [snapshotViews addObject:snapshot]; return snapshot;
}
@end

@interface CSSettingsHomeAnimator : NSObject
- (void)transitionTable:(UITableView *)table belowView:(UIView *)rail updates:(void (^)(void))updates;
- (void)cancel;
- (CGRect)visibleFrameForTable:(UITableView *)table belowView:(UIView *)rail;
- (NSArray<UIView *> *)groupsForTable:(UITableView *)table frame:(CGRect)frame afterUpdates:(BOOL)afterUpdates;
@end
#include "SettingsHomeAnimatorUnderTest.h"

static void ResetRecords(void) { snapshotViews=[NSMutableArray array]; animations=[NSMutableArray array]; }
static UITableView *Table(UIView **hostOut,UIView **railOut) {
    UIView *host=[[UIView alloc] initWithFrame:CGRectMake(0,0,390,844)];
    UITableView *table=[[UITableView alloc] initWithFrame:CGRectMake(12,24,366,760)];
    table.bounds=CGRectMake(0,200,366,760); table.adjustedContentInset=(UIEdgeInsets){64,0,28,0};
    table.window=[NSObject new]; table.backgroundColor=[NSObject new]; table.sourceVersion=1;
    table.sectionRects=@[RectValue(CGRectMake(0,100,366,150)),RectValue(CGRectMake(0,300,366,200)),
                         RectValue(CGRectMake(0,500,366,240)),RectValue(CGRectMake(0,740,366,300)),
                         RectValue(CGRectMake(0,1040,366,100))];
    UIView *rail=[[UIView alloc] initWithFrame:CGRectMake(20,90,350,76)];
    [host addSubview:table]; [host addSubview:rail]; *hostOut=host; *railOut=rail; return table;
}
static void Finish(AnimationRecord *record) { if (record.completion) record.completion(YES); }

static void TestWholeGroups(void) {
    ResetRecords(); reducedMotion=NO;
    UIView *host,*rail; UITableView *table=Table(&host,&rail);
    CSSettingsHomeAnimator *animator=[CSSettingsHomeAnimator new];
    CGRect visible=[animator visibleFrameForTable:table belowView:rail];
    Check(CGRectEqualToRect(visible,CGRectMake(12,166,366,590)),@"visible overlay starts below the rail and ends above the bottom safe inset");
    __block NSUInteger updates=0;
    [animator transitionTable:table belowView:rail updates:^{
        updates++; table.sourceVersion=2; table.bounds=CGRectMake(0,240,366,760);
        table.sectionRects=@[RectValue(CGRectMake(0,300,366,210)),RectValue(CGRectMake(0,510,366,250)),RectValue(CGRectMake(0,760,366,400))];
    }];
    Check(updates==1 && snapshotViews.count==6 && animations.count==6,@"one update separates three outgoing and three incoming section snapshots");
    NSArray *expected=@[RectValue(CGRectMake(0,342,366,158)),RectValue(CGRectMake(0,500,366,240)),RectValue(CGRectMake(0,740,366,192)),
                        RectValue(CGRectMake(0,382,366,128)),RectValue(CGRectMake(0,510,366,250)),RectValue(CGRectMake(0,760,366,212))];
    for (NSUInteger i=0; i<snapshotViews.count; i++) {
        UIView *group=snapshotViews[i];
        Check(CGRectEqualToRect(group.capturedRect,ReadRect(expected[i])),@"section capture includes its complete width and clips only the viewport edges");
        Check(group.capturedAfterUpdates==(i>=3) && group.capturedVersion==(i>=3 ? 2 : 1),@"old and new groups are captured on the correct side of the real data update");
    }
    UIView *overlay=animator.overlay;
    Check(overlay && CGRectEqualToRect(overlay.frame,visible) && overlay.clipsToBounds,@"one clipped overlay contains entire groups including headers, rounded backgrounds and accessories");
    Check(overlay.userInteractionEnabled,@"transition overlay intercepts taps while old-looking rows overlap newly loaded routes");
    Check(overlay.backgroundColor==table.backgroundColor && overlay.subviews.count==6,@"overlay covers the real table with its matching background while both group sets animate");
    Check(host.subviews.count==3 && host.subviews[1]==overlay && host.subviews.lastObject==rail,@"profile/table remain live beneath an overlay placed below the stationary Tab rail");
    Check(CGRectEqualToRect(snapshotViews[0].frame,CGRectMake(0,0,366,158)) &&
          CGRectEqualToRect(snapshotViews[1].frame,CGRectMake(0,158,366,240)),@"captured groups retain section-relative spacing when converted into the clipped overlay");
    for (NSUInteger i=0; i<3; i++) {
        AnimationRecord *outgoing=animations[i], *incoming=animations[i+3];
        Check(Near(outgoing.duration,.14) && Near(outgoing.delay,0) && Near(outgoing.beforeAlpha,1) && Near(outgoing.afterAlpha,0),@"outgoing complete groups fade out together over 140ms");
        Check(Near(outgoing.beforeTransform.ty,0) && Near(outgoing.afterTransform.ty,160) && Near(outgoing.afterTransform.tx,0),@"outgoing groups visibly move down 160 points without horizontal displacement");
        Check(Near(incoming.duration,.20) && Near(incoming.delay,.01+MIN(i*.02,.04)) && Near(incoming.beforeAlpha,0) && Near(incoming.afterAlpha,1),@"incoming groups fade in over 200ms after a short 10ms lead-in and capped 20ms section stagger");
        Check(Near(incoming.beforeTransform.ty,210) && CGAffineTransformIsIdentity(incoming.afterTransform),@"incoming complete groups rise 210 points into their final position");
        Check((incoming.options&UIViewAnimationOptionCurveEaseOut)!=0,@"group motion uses ease-out timing");
    }
    Check(Near(table.alpha,1) && CGAffineTransformIsIdentity(table.transform) && CGRectEqualToRect(rail.frame,CGRectMake(20,90,350,76)),@"real table geometry and Tab rail are unaffected by snapshot animation transforms");
    Finish(animations[3]); Finish(animations[4]);
    Check(animator.overlay==overlay,@"early group completion preserves later staggered groups");
    Finish(animations[5]);
    Check(!animator.overlay && host.subviews.count==2 && !overlay.superview,@"last incoming completion removes the transition layer and exposes live settings");
}

static void TestCancellationAndRapidSwitches(void) {
    ResetRecords(); reducedMotion=NO;
    UIView *host,*rail; UITableView *table=Table(&host,&rail);
    CSSettingsHomeAnimator *animator=[CSSettingsHomeAnimator new];
    [animator transitionTable:table belowView:rail updates:^{}];
    UIView *first=animator.overlay; AnimationRecord *oldLast=animations.lastObject;
    __block NSUInteger reentrantStops=0;
    first.subviews.firstObject.layer.onRemoveAnimations=^{
        reentrantStops++;
        Check(!animator.overlay,@"cancel clears ownership before UIKit can synchronously reenter an old completion");
        if (oldLast.completion) oldLast.completion(NO);
    };
    [animator transitionTable:table belowView:rail updates:^{}];
    UIView *second=animator.overlay; AnimationRecord *newLast=animations.lastObject;
    Check(first!=second && reentrantStops==1 && !first.superview && second.superview==host,@"rapid switching cancels the previous overlay exactly once and installs the next one");
    Finish(oldLast);
    Check(animator.overlay==second && second.superview==host,@"late completion from the cancelled transition cannot remove the new overlay");
    [animator cancel];
    Check(!animator.overlay && !second.superview && host.subviews.count==2,@"explicit cancel removes every temporary overlay");
    BOOL removed=YES;
    for (UIView *group in second.subviews) removed=removed && group.layer.removals==1;
    Check(removed,@"cancel stops all outgoing and incoming section animations");
    Finish(newLast); [animator cancel];
    Check(!animator.overlay && host.subviews.count==2,@"post-cancel completion and repeated cancel remain harmless");
    first.subviews.firstObject.layer.onRemoveAnimations=nil;
}

static void TestReducedMotionAndStaggerCap(void) {
    ResetRecords(); reducedMotion=YES;
    UIView *host,*rail; UITableView *table=Table(&host,&rail);
    CSSettingsHomeAnimator *animator=[CSSettingsHomeAnimator new];
    [animator transitionTable:table belowView:rail updates:^{}];
    for (AnimationRecord *record in animations) {
        Check(Near(record.duration,.12) && Near(record.delay,0),@"Reduce Motion uses a short 120ms fade without stagger");
        Check(CGAffineTransformIsIdentity(record.beforeTransform) && CGAffineTransformIsIdentity(record.afterTransform),@"Reduce Motion never translates either outgoing or incoming groups");
    }
    [animator cancel]; ResetRecords(); reducedMotion=NO;
    table.sectionRects=@[RectValue(CGRectMake(0,350,366,100)),RectValue(CGRectMake(0,450,366,100)),
                         RectValue(CGRectMake(0,550,366,100)),RectValue(CGRectMake(0,650,366,100)),RectValue(CGRectMake(0,750,366,100))];
    [animator transitionTable:table belowView:rail updates:^{}];
    Check(animations.count==10 && Near(animations[9].delay,.05) && Near(animations[9].delay+animations[9].duration,.25),@"stagger delay caps at 50ms and the complete transition ends within 250ms even with several visible groups");
    [animator cancel];
}

static void TestOffscreenAndEmptyStates(void) {
    ResetRecords();
    UIView *host,*rail; UITableView *table=Table(&host,&rail);
    CSSettingsHomeAnimator *animator=[CSSettingsHomeAnimator new]; __block NSUInteger updates=0;
    table.window=nil;
    [animator transitionTable:table belowView:rail updates:^{ updates++; table.sourceVersion++; }];
    Check(updates==1 && !table.snapshotRequests && !animator.overlay,@"offscreen transition still updates data once without requesting any snapshots");
    table.window=[NSObject new]; [table removeFromSuperview];
    [animator transitionTable:table belowView:rail updates:^{ updates++; }];
    Check(updates==2 && !table.snapshotRequests && !animator.overlay,@"detached table also performs its update without an overlay");
    [host insertSubview:table belowSubview:rail];
    [animator transitionTable:table belowView:rail updates:^{ updates++; table.sectionRects=@[]; }];
    Check(updates==3 && !animator.overlay && host.subviews.count==2,@"empty incoming results expose the updated empty state without leaving an outgoing overlay");
    table.sectionRects=@[RectValue(CGRectMake(0,350,366,100))];
    table.adjustedContentInset=(UIEdgeInsets){900,0,28,0};
    CGRect empty=[animator visibleFrameForTable:table belowView:rail];
    [animator transitionTable:table belowView:rail updates:^{ updates++; }];
    Check(CGRectIsEmpty(empty) && updates==4 && !animator.overlay,@"fully clipped viewport still updates data and creates no lingering animation");
}

int main(void) { @autoreleasepool {
    TestWholeGroups(); TestCancellationAndRapidSwitches(); TestReducedMotionAndStaggerCap(); TestOffscreenAndEmptyStates();
    fprintf(stdout,"Settings home group animation: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
    return failures ? 1 : 0;
} }
