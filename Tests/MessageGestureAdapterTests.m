#import <UIKit/UIKit.h>
#import "CSMessageGestureAdapter.h"
#import "CSMessageCellLifecycle.h"
#import "CSMessageMergeAdapter.h"
#include <stdlib.h>
static NSUInteger checks, captures, capabilities, executions, handoffs, cancels, timePrepares, timeResets;
static NSMutableArray<NSString *> *order;
static CGAffineTransform expectedBaseline;
static UIViewController *page;
static CSMessageActionSettings *snapshot;
static BOOL permitted=YES, allRestored=YES;
static NSMutableArray *executedSources, *accountHookOrder;
void CSMessageActionAccountWillChangeAtNativeBoundary(void) { [accountHookOrder addObject:@"will"];permitted=NO; }
void CSMessageActionAccountDidChangeAtNativeBoundary(void) { [accountHookOrder addObject:@"did"];permitted=YES; }
#import "GestureAccountHooksUnderTest.h"
#define CHECK(...) do { checks++; if (!(__VA_ARGS__)) { fprintf(stderr,"FAIL line %d: %s\n",__LINE__,#__VA_ARGS__);exit(1); } } while(0)
@interface GestureDefaults : NSUserDefaults
@property(nonatomic) NSUInteger reads;
@end
@implementation GestureDefaults
- (id)objectForKey:(NSString *)key { self.reads++;return [super objectForKey:key]; }
@end
// Only the business facade is a double: production context/policy/settings/adapter/lifecycle execute below.
@implementation CSMessageActionCoordinator
+ (instancetype)sharedCoordinator { static id coordinator; static dispatch_once_t once;dispatch_once(&once,^{coordinator=[self new];}); return coordinator; }
- (CSMessageActionSettings *)settings { return snapshot; }
- (CSMessageActionContext *)captureContextForCell:(id)cell controller:(id)controller bindingGeneration:(NSUInteger)generation {
    captures++;return [CSMessageActionContext contextWithCell:cell controller:controller ?: page accountID:@"self" accountEpoch:1 conversationID:@"peer" bindingGeneration:generation];
}
- (BOOL)validateContext:(CSMessageActionContext *)context {
    CSMessageActionContext *current=[CSMessageActionContext contextWithCell:context.cell controller:context.controller accountID:@"self" accountEpoch:1 conversationID:@"peer" bindingGeneration:context.bindingGeneration];
    return permitted && [context matchesSourceContext:current];
}
- (BOOL)canExecuteContext:(CSMessageActionContext *)context action:(CSMessageAction)action entry:(CSMessageActionEntry)entry { capabilities++;return [self validateContext:context] && CSMessageActionEntryAllows(snapshot,entry,action); }
- (NSString *)executeContext:(CSMessageActionContext *)context action:(CSMessageAction)action entry:(CSMessageActionEntry)entry {
    handoffs++;
    allRestored &= CGAffineTransformEqualToTransform(((UIView *)context.cell).transform,expectedBaseline);
    if (![self validateContext:context]) return nil;
    executions++;[executedSources addObject:context.sourceWrap];return NSUUID.UUID.UUIDString;
}
- (void)cancelOperationsForCell:(id)cell { cancels++; }
@end
@interface GestureWrap : NSObject
@property(nonatomic,copy) NSString *m_nsFromUsr,*m_nsToUsr;
@property(nonatomic) unsigned int m_uiMesLocalID,m_uiMessageType;
@property(nonatomic) long long m_n64MesSvrID;
@end
@implementation GestureWrap @end
@interface GestureModel : NSObject
@property(nonatomic,strong) GestureWrap *messageWrap;
@end
@implementation GestureModel @end
@interface GesturePage : UIViewController { @public BOOL m_bMultiSelectMode; }
@end
@implementation GesturePage @end
@interface GestureCell : UIView { @public BOOL m_bDisableAllOperation; }
@property(nonatomic,strong) GestureModel *viewModel;
@property(nonatomic,strong) UIView *bubble;
- (id)getBgImageView;
@end
@implementation GestureCell
- (id)getBgImageView { return self.bubble; }
@end
void CSMessageMergeRestore(UIView *cell) { [order addObject:@"merge-restore"];CHECK(CGAffineTransformEqualToTransform(cell.transform,expectedBaseline)); }
void CSMessageMergeRender(UIView *cell) { [order addObject:@"merge-render-time-position"];CHECK(CGAffineTransformEqualToTransform(cell.transform,expectedBaseline)); }
void CSMessageMergeReuse(UIView *cell) { [order addObject:@"merge-reuse"]; }
void CSMessageTimePrepareCell(id cell) { timePrepares++;[order addObject:@"time-prepare"]; }
void CSMessageTimeResetCell(id cell) { timeResets++;[order addObject:@"time-reset"]; }
static GestureModel *model(unsigned int ident) {
    GestureModel *m=[GestureModel new];m.messageWrap=[GestureWrap new];m.messageWrap.m_nsFromUsr=@"peer";m.messageWrap.m_nsToUsr=@"self";
    m.messageWrap.m_uiMesLocalID=ident;m.messageWrap.m_uiMessageType=1;return m;
}
static BOOL admit(CSMessageGestureAdapter *adapter, UIView *view, CGFloat x, CGFloat vx, CGFloat vy) {
    UITouch *touch=[UITouch new];touch.view=view;touch.testLocation=CGPointMake(x,20);
    adapter.pan.testTranslation=CGPointZero;adapter.pan.testVelocity=CGPointMake(vx,vy);adapter.pan.state=UIGestureRecognizerStatePossible;
    return [adapter gestureRecognizer:adapter.pan shouldReceiveTouch:touch] && [adapter gestureRecognizerShouldBegin:adapter.pan];
}
static void move(CSMessageGestureAdapter *adapter, NSInteger state, CGFloat x, CGFloat vx) {
    adapter.pan.state=state;adapter.pan.testTranslation=CGPointMake(x,0);adapter.pan.testVelocity=CGPointMake(vx,0);[adapter handlePan:adapter.pan];
}
int main(void) { @autoreleasepool {
    NSString *suite=[@"GestureTests." stringByAppendingString:NSUUID.UUID.UUIDString];
    GestureDefaults *defaults=[[GestureDefaults alloc] initWithSuiteName:suite];
    [defaults setBool:YES forKey:CSMessageActionGestureEnabledKey];[defaults setInteger:6 forKey:CSMessageActionLeftOtherKey];
    [defaults setInteger:0 forKey:CSMessageActionRightOtherKey];
    snapshot=[[CSMessageActionSettings alloc] initWithDefaults:defaults version:1];
    page=[GesturePage new];page.navigationController=[UINavigationController new];
    UIGestureRecognizer *pop=[UIGestureRecognizer new];pop.enabled=YES;page.navigationController.interactivePopGestureRecognizer=pop;
    order=[NSMutableArray array];executedSources=[NSMutableArray array];
    UIWindow *window=[UIWindow new];window.bounds=CGRectMake(0,0,320,640);
    GestureCell *cell=[GestureCell new];cell.bounds=CGRectMake(0,0,320,70);cell.window=window;cell.viewModel=model(1);
    cell.bubble=[UIView new];cell.bubble.frame=CGRectMake(70,8,160,40);cell.bubble.bounds=CGRectMake(0,0,160,40);[cell addSubview:cell.bubble];
    expectedBaseline=CGAffineTransformMakeScale(.9,.9);expectedBaseline.tx=3;cell.transform=expectedBaseline;
    CSMessageGestureAdapter *adapter=CSMessageGestureAdapterForCell(cell,YES);[adapter refreshForLayout];
    CHECK(cell.gestureRecognizers.count==1 && adapter.pan.delegate==adapter);
    NSUInteger initialReads=defaults.reads,initialCaptures=captures,initialCaps=capabilities;
    for (NSUInteger i=0;i<100;i++) CSMessageCellPerformLayout(cell,^{ [order addObject:@"native"]; });
    CHECK(cell.gestureRecognizers.count==1 && defaults.reads==initialReads && captures==initialCaptures && capabilities==initialCaps);
    CHECK(!admit(adapter,cell.bubble,90,-100,300)); // vertical passes to native scroll
    CHECK(!admit(adapter,cell.bubble,90,300,0)); // exact disabled direction
    CHECK(!admit(adapter,cell,20,-300,0)); // blank/avatar space
    UIControl *control=[UIControl new];[cell.bubble addSubview:control];CHECK(!admit(adapter,control,90,-300,0));
    UIScrollView *nested=[UIScrollView new];nested.scrollEnabled=YES;nested.contentSize=CGSizeMake(500,40);nested.bounds=CGRectMake(0,0,160,40);[cell.bubble addSubview:nested];CHECK(!admit(adapter,nested,90,-300,0));
    cell->m_bDisableAllOperation=YES;CHECK(!admit(adapter,cell.bubble,90,-300,0));cell->m_bDisableAllOperation=NO;
    ((GesturePage *)page)->m_bMultiSelectMode=YES;CHECK(!admit(adapter,cell.bubble,90,-300,0));((GesturePage *)page)->m_bMultiSelectMode=NO;
    CHECK(CSGestureHaptics==0 && CGAffineTransformEqualToTransform(cell.transform,expectedBaseline));
    CHECK([adapter gestureRecognizer:adapter.pan shouldRequireFailureOfGestureRecognizer:pop]);
    UIGestureRecognizer *unrelated=[UIGestureRecognizer new];CHECK(![adapter gestureRecognizer:adapter.pan shouldRequireFailureOfGestureRecognizer:unrelated]);
    UITapGestureRecognizer *contentTap=[UITapGestureRecognizer new];contentTap.view=cell.bubble;
    UITapGestureRecognizer *outsideTap=[UITapGestureRecognizer new];outsideTap.view=cell;
    CHECK([adapter gestureRecognizer:adapter.pan shouldBeRequiredToFailByGestureRecognizer:contentTap]);
    CHECK(![adapter gestureRecognizer:adapter.pan shouldBeRequiredToFailByGestureRecognizer:outsideTap]);
    UITapGestureRecognizer *cellContentTap=[UITapGestureRecognizer new];cellContentTap.view=cell;cellContentTap.testLocation=CGPointMake(90,20);
    CHECK([adapter gestureRecognizer:adapter.pan shouldBeRequiredToFailByGestureRecognizer:cellContentTap]);
    CHECK(![adapter gestureRecognizer:adapter.pan shouldRecognizeSimultaneouslyWithGestureRecognizer:contentTap]);
    CHECK([adapter gestureRecognizer:adapter.pan shouldRecognizeSimultaneouslyWithGestureRecognizer:outsideTap]);
    pop.state=UIGestureRecognizerStateBegan;CHECK(!admit(adapter,cell.bubble,90,-300,0));pop.state=0;
    CHECK(admit(adapter,cell.bubble,90,-300,0));move(adapter,1,-10,-300);move(adapter,2,-70,-300);
    CHECK(CSGestureHaptics==1 && executions==0 && cell.transform.a==.9 && cell.transform.tx==3-35);
    [order removeAllObjects];NSUInteger prepare=timePrepares;
    CSMessageCellPerformLayout(cell,^{
        CSMessageCellPerformLayout(cell,^{ [order addObject:@"native"];CHECK(CGAffineTransformEqualToTransform(cell.transform,expectedBaseline)); });
    });
    CHECK(timePrepares==prepare+1 && [order isEqual:@[@"merge-restore",@"native",@"time-prepare",@"merge-render-time-position"]]);
    CHECK(cell.transform.tx==3-35);
    move(adapter,2,-90,-300);CHECK(CSGestureHaptics==1);
    CHECK(defaults.reads==initialReads && captures==initialCaptures && capabilities==initialCaps);
    move(adapter,4,-100,-800);CHECK(executions==0 && CGAffineTransformEqualToTransform(cell.transform,expectedBaseline));
    CHECK(admit(adapter,cell.bubble,90,-300,0));move(adapter,1,-20,-300);move(adapter,5,-100,-800);CHECK(executions==0);
    // Two deliberate touches produce two operations. Ended delivered twice cannot repeat either.
    for (NSUInteger i=0;i<2;i++) { CHECK(admit(adapter,cell.bubble,90,-300,0));move(adapter,1,-20,-300);move(adapter,2,-70,-300);move(adapter,3,-70,0);move(adapter,3,-70,0); }
    CHECK(executions==2 && allRestored && executedSources[0]==cell.viewModel.messageWrap && executedSources[1]==executedSources[0]);
    // Ended owns one rebound, and reuse cancels that exact animator (no layer-wide cleanup API).
    CHECK(CSGestureActiveRebounds==1);NSUInteger stopped=CSGestureStoppedRebounds;
    CSMessageCellPerformReuse(cell,^{});CHECK(CSGestureActiveRebounds==0 && CSGestureStoppedRebounds==stopped+1);
    [adapter bind];[adapter refreshForLayout];
    // Velocity is directional and requires >=12pt; dragging back across origin cannot pick the opposite action.
    for (NSUInteger i=0;i<3;i++) { CHECK(admit(adapter,cell.bubble,90,-300,0));move(adapter,1,-8,-300);move(adapter,3,i==2 ? 70 : -8,i==0 ? -900 : 900); }
    CHECK(executions==2);
    // Armed -> tracking -> armed remains one haptic, and final backtracking cancels commit.
    NSUInteger beforeHaptics=CSGestureHaptics;
    CHECK(admit(adapter,cell.bubble,90,-300,0));move(adapter,1,-70,-300);move(adapter,2,-3,200);move(adapter,2,-70,-300);move(adapter,3,-3,0);
    CHECK(executions==2 && CSGestureHaptics==beforeHaptics+1);
    CHECK(admit(adapter,cell.bubble,90,-300,0));move(adapter,1,-12,-800);move(adapter,3,-12,-800);CHECK(executions==3);
    // Begin A, bind B through the real production scheduler, then Ended cannot retarget B.
    CHECK(admit(adapter,cell.bubble,90,-300,0));move(adapter,1,-20,-300);
    GestureModel *replacement=model(2);NSUInteger oldGeneration=adapter.bindingGeneration;NSUInteger oldResets=timeResets, oldHandoffs=handoffs;
    NSUInteger bindPrepares=timePrepares;
    CSMessageCellPerformBinding(cell,replacement,^{ CSMessageCellPerformBinding(cell,replacement,^{
        CSMessageCellPerformLayout(cell,^{});cell.viewModel=replacement;
    }); });
    CHECK(timePrepares==bindPrepares+1);
    move(adapter,3,-100,-800);CHECK(executions==3 && handoffs==oldHandoffs && adapter.bindingGeneration>oldGeneration && timeResets==oldResets+1);
    // An active settings version change cancels, and the next binding uses the new disabled direction.
    CHECK(admit(adapter,cell.bubble,90,-300,0));move(adapter,1,-30,-300);
    [defaults setInteger:0 forKey:CSMessageActionLeftOtherKey];snapshot=[[CSMessageActionSettings alloc] initWithDefaults:defaults version:2];
    [adapter settingsDidChange];move(adapter,3,-100,-800);CHECK(executions==3 && handoffs==oldHandoffs && !admit(adapter,cell.bubble,90,-300,0));
    [defaults setInteger:6 forKey:CSMessageActionLeftOtherKey];snapshot=[[CSMessageActionSettings alloc] initWithDefaults:defaults version:3];[adapter settingsDidChange];
    // Native takeover wins: never overwrite its new transform with a stale baseline.
    CHECK(admit(adapter,cell.bubble,90,-300,0));move(adapter,1,-30,-300);
    CGAffineTransform takeover=CGAffineTransformMakeScale(.7,.8);takeover.tx=8;cell.transform=takeover;
    move(adapter,2,-100,-800);move(adapter,3,-100,-800);CHECK(executions==3 && CGAffineTransformEqualToTransform(cell.transform,takeover));
    // An incompatible transform introduced inside native layout also wins; no reapplication/commit.
    cell.transform=expectedBaseline;
    CHECK(admit(adapter,cell.bubble,90,-300,0));move(adapter,1,-30,-300);
    CSMessageCellPerformLayout(cell,^{cell.transform=takeover;expectedBaseline=takeover;});
    move(adapter,3,-100,-800);CHECK(executions==3 && CGAffineTransformEqualToTransform(cell.transform,takeover));
    expectedBaseline=CGAffineTransformMakeScale(.9,.9);expectedBaseline.tx=3;
    cell.transform=expectedBaseline;CSGestureReducedMotion=YES;
    CHECK(admit(adapter,cell.bubble,90,-300,0));move(adapter,1,-20,-300);move(adapter,3,-80,0);CHECK(executions==4 && allRestored);
    CHECK(admit(adapter,cell.bubble,90,-300,0));move(adapter,1,-30,-300);
    NSUInteger reusePrepares=timePrepares;
    CSMessageCellPerformReuse(cell,^{CSMessageCellPerformReuse(cell,^{
        CSMessageCellPerformLayout(cell,^{});
        CSMessageCellPerformBinding(cell,cell.viewModel,^{});
    });});move(adapter,3,-100,-800);CHECK(executions==4 && !adapter.pan.enabled && timePrepares==reusePrepares);
    [adapter bind];[adapter refreshForLayout];CHECK(admit(adapter,cell.bubble,90,-300,0));move(adapter,1,-30,-300);
    CSMessageGestureCancelForController(page);move(adapter,3,-100,-800);CHECK(executions==4);
    CHECK(admit(adapter,cell.bubble,90,-300,0));move(adapter,1,-30,-300);cell.window=nil;CSMessageCellWindowChanged(cell);move(adapter,3,-100,-800);CHECK(executions==4);
    // Same source mutated without setViewModel: final facade validation still refuses.
    cell.window=window;CSMessageCellWindowChanged(cell);CHECK(admit(adapter,cell.bubble,90,-300,0));move(adapter,1,-30,-300);permitted=NO;move(adapter,3,-100,-800);CHECK(executions==4 && allRestored);
    permitted=YES;
    // Native delegates stay intact, and unchanged layouts do not append recognizers.
    NSObject *nativeOwner=[NSObject new];UITapGestureRecognizer *nativeTap=[UITapGestureRecognizer new];nativeTap.delegate=(id)nativeOwner;
    [cell.bubble addGestureRecognizer:nativeTap];[adapter refreshForLayout];CHECK((id)nativeTap.delegate==nativeOwner);
    // Execute the actual native hook bodies: WILL precedes logout, DID follows login.
    accountHookOrder=[NSMutableArray array];MMContextManager *manager=[MMContextManager new];
    CHECK(admit(adapter,cell.bubble,90,-300,0));move(adapter,1,-30,-300);
    [manager logout:nil];move(adapter,3,-100,-800);CHECK(executions==4);
    CHECK([accountHookOrder isEqual:@[@"will",@"native"]]);
    [accountHookOrder removeAllObjects];[manager loginByContext:nil];CHECK([accountHookOrder isEqual:@[@"native",@"did"]]);
    // Drain the main cleanup; it must not restore an old interaction or grow recognizer count.
    [NSRunLoop.mainRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.02]];
    CHECK(cell.gestureRecognizers.count==1 && CGAffineTransformEqualToTransform(cell.transform,expectedBaseline));
    [defaults removePersistentDomainForName:suite];
    printf("PASS: %lu production gesture/lifecycle checks (UIKit/facade doubles, no native sends)\n",(unsigned long)checks);
 } return 0; }
