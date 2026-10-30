// Real proxy and shielding bodies under controlled UIKit-like geometry queries.
// Scroll gestures, dimensions and callbacks below are host doubles, not device input.
#define main GroupContainerCoreMain
#include "GroupContainerReturnTests.m"
#undef main

@interface NeutralScrollState : NSObject
@property(nonatomic) NSUInteger selections,scrollCallbacks;
@end
@implementation NeutralScrollState @end
static char NeutralScrollStateKey;
static NeutralScrollState *ScrollState(CSGroupListAdapter *a) {
    NeutralScrollState *state=objc_getAssociatedObject(a,&NeutralScrollStateKey);
    if(!state) {
        state=[NeutralScrollState new];a.table.userInteractionEnabled=YES;a.table.scrollEnabled=YES;
        a.table.panGestureRecognizer=[GroupNeutralGesture new];a.table.panGestureRecognizer.enabled=YES;
        a.pan=[GroupNeutralGesture new];a.pan.enabled=YES;a.listPan=[GroupNeutralGesture new];a.listPan.enabled=YES;
        a.chrome.userInteractionEnabled=YES;a.chrome.hidden=NO;
        objc_setAssociatedObject(a,&NeutralScrollStateKey,state,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return state;
}
@interface NativeHost (NeutralScrollCallbacks)
- (void)tableView:(id)table didSelectRowAtIndexPath:(NSIndexPath *)path;
- (void)scrollViewDidScroll:(id)table;
- (void)scrollViewDidEndDragging:(id)table willDecelerate:(BOOL)decelerate;
@end
@implementation NativeHost (NeutralScrollCallbacks)
- (void)tableView:(id)table didSelectRowAtIndexPath:(NSIndexPath *)path {(void)table;(void)path;ScrollState(self.m_tableView.adapter).selections++;}
- (void)scrollViewDidScroll:(id)table {(void)table;ScrollState(self.m_tableView.adapter).scrollCallbacks++;}
- (void)scrollViewDidEndDragging:(id)table willDecelerate:(BOOL)decelerate {(void)table;(void)decelerate;ScrollState(self.m_tableView.adapter).scrollCallbacks++;}
@end
static void NeutralCallback(CSGroupListAdapter *a,SEL selector,BOOL row) {
    NSInvocation *inv=[NSInvocation invocationWithMethodSignature:[a.controller methodSignatureForSelector:selector]];
    inv.selector=selector;__unsafe_unretained id table=a.table;[inv setArgument:&table atIndex:2];
    __unsafe_unretained id path=At(2,1);if(row)[inv setArgument:&path atIndex:3];[inv invokeWithTarget:a.uiProxy];
}
static NSDictionary *NumericGeometry(NSDictionary *sample) {
    NSMutableArray *rows=[NSMutableArray array];
    for(NSArray *section in sample[@"sections"])for(NSDictionary *row in section)[rows addObject:@{@"y":row[@"y"],@"height":row[@"height"]}];
    return @{@"sectionCounts":sample[@"sectionCounts"] ?: @[],@"rows":rows};
}
static NSDictionary *ScrollStage(CSGroupListAdapter *a) {
    NeutralScrollState *s=ScrollState(a);NSUInteger hidden=0,nonempty=0;
    for(UITableViewCell *cell in a.table.visibleCells){hidden+=cell.hidden;nonempty+=cell.textLabel.text.length>0;}
    return @{@"contentWidth":@(a.table.contentSize.width),@"contentHeight":@(a.table.contentSize.height),
        @"insetTop":@(a.table.adjustedContentInset.top),@"insetBottom":@(a.table.adjustedContentInset.bottom),
        @"offsetX":@(a.table.contentOffset.x),@"offsetY":@(a.table.contentOffset.y),
        @"visibleCells":@(a.table.visibleCells.count),@"hiddenCells":@(hidden),@"nonemptyCells":@(nonempty),
        @"tableInteraction":@(a.table.userInteractionEnabled),@"scrollEnabled":@(a.table.scrollEnabled),@"tablePanEnabled":@(a.table.panGestureRecognizer.enabled),
        @"barPanEnabled":@(a.pan.enabled),@"listPanEnabled":@(a.listPan.enabled),@"chromeInteraction":@(a.chrome.userInteractionEnabled),@"chromeHidden":@(a.chrome.hidden),
        @"fullReloads":@(a.table.reloads),@"rowReloads":@(a.table.rowReloads),@"offsetWrites":@(a.table.offsetWrites),
        @"privateNativeCellCalls":@(a.controller.privateCellCalls),@"selections":@(s.selections),@"scrollCallbacks":@(s.scrollCallbacks)};
}
static BOOL SyntheticDrag(CSGroupListAdapter *a,CGFloat delta) {
    (void)ScrollState(a);CGFloat old=a.table.contentOffset.y;
    if(!a.table.userInteractionEnabled || !a.table.scrollEnabled || !a.table.panGestureRecognizer.enabled)return NO;
    CGFloat min=-a.table.adjustedContentInset.top,max=MAX(min,a.table.contentSize.height-a.table.bounds.size.height+a.table.adjustedContentInset.bottom);
    [a.table setContentOffset:CGPointMake(a.table.contentOffset.x,MIN(max,MAX(min,old+delta))) animated:NO];
    NeutralCallback(a,@selector(scrollViewDidScroll:),NO);return fabs(a.table.contentOffset.y-old)>0.5;
}
static void NeutralScroll(NSString *entry,NSString *readiness) {
    scenario=[NSString stringWithFormat:@"neutral-scroll/%@/%@",entry,readiness];policy=Policy(NO,NO,501);
    CSGroupListAdapter *a=List(NO);a.presentationViewport=nil;ScrollState(a);
    Native(a.controller,NO,^{[a.table originalLayout];});
    NSDictionary *ready=NumericGeometry(a.table.geometrySamples.lastObject);CGSize readySize=a.table.contentSize;
    Emit(@"ready-stage",ScrollStage(a));Reset(a);
    if([readiness isEqual:@"blocked"])policy=Policy(NO,YES,502);
    else if([readiness isEqual:@"stale-revision"])policy=Policy(NO,NO,502);
    else if([readiness isEqual:@"nil-policy"])policy=nil;
    else policy=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"other-account" profile:@{@"enabled":@YES,@"options":@{}} revealed:NO revision:502 blocked:NO];
    // UIKit queries can precede a native table layout; this is controlled input.
    Native(a.controller,NO,^{[a.table originalLayout];});
    NSDictionary *neutral=NumericGeometry(a.table.geometrySamples.lastObject);
    Emit(@"neutral-stage",ScrollStage(a));
    Check([neutral[@"sectionCounts"] isEqual:ready[@"sectionCounts"]] && [neutral[@"rows"] count]==[ready[@"rows"] count],@"unready queries retain content-free slots with published section and row counts");
    Check(fabs(a.table.contentSize.width-readySize.width)<0.5 && fabs(a.table.contentSize.height-readySize.height)<0.5,@"unready queries preserve table contentSize instead of collapsing scroll extent");
    Check(a.table.contentSize.height+a.table.adjustedContentInset.top+a.table.adjustedContentInset.bottom>a.table.bounds.size.height,@"neutral state retains a scrollable bounding box");
    BOOL blank=YES;for(UITableViewCell *cell in a.table.visibleCells)blank&=cell.textLabel.text.length==0 && !cell.userInteractionEnabled;
    Check(blank,@"neutral required cells contain no unfiltered text and admit no row interaction");
    Check(a.controller.privateCellCalls==0,@"neutral stage invokes no protected native cell getter");
    Check(SectionTitle(a,2)==nil,@"neutral stage does not publish cached native header text");
    Check(a.table.reloads==0 && a.table.rowReloads==0,@"neutral queries do not reload the table or rows");
    CGFloat before=a.table.contentOffset.y;BOOL dragged=SyntheticDrag(a,40);
    Emit(@"neutral-drag-stage",ScrollStage(a));
    Check(dragged && fabs(a.table.contentOffset.y-before-40)<0.5,@"controlled neutral drag advances contentOffset by requested delta");
    Check(ScrollState(a).scrollCallbacks==1,@"neutral stage forwards scroll callback exactly once");
    Native(a.controller,NO,^{NeutralCallback(a,@selector(tableView:didSelectRowAtIndexPath:),YES);});
    Check(ScrollState(a).selections==0,@"unready native-owner row action cannot reach invisible native content");
    Check(a.table.userInteractionEnabled && a.table.scrollEnabled && a.table.panGestureRecognizer.enabled && a.pan.enabled && a.listPan.enabled && a.chrome.userInteractionEnabled && !a.chrome.hidden,@"neutralization does not toggle host gesture and interaction flags");
    Emit(@"neutral-action-stage",ScrollStage(a));
    policy=Policy(NO,NO,503);a.privacyRefreshPending=YES;a.dirty=YES;[a refresh];Reset(a);
    Native(a.controller,NO,^{[a.table originalLayout];});BOOL safe=YES;
    for(NSString *name in a.table.submissions.lastObject)safe&=![name hasPrefix:@"secret"];
    Check(safe && a.controller.privateCellCalls==0,@"ready publication after neutral scroll remains privacy filtered");
    Check([NumericGeometry(a.table.geometrySamples.lastObject) isEqual:ready],@"first real ready layout restores filtered stable section and row geometry");
    Check(fabs(a.table.contentOffset.y-400)<0.5,@"ready content restores genuine pre-neutral scroll position after blank dragging");
    Emit(@"restored-stage",ScrollStage(a));
}
static void ReadyDuringDrag(NSString *entry) {
    scenario=[@"neutral-scroll/ready-during-drag/" stringByAppendingString:entry];policy=Policy(NO,NO,601);
    CSGroupListAdapter *a=List(NO);a.presentationViewport=nil;CALayer *originalMask=[CALayer layer];a.table.layer.mask=originalMask;
    Native(a.controller,NO,^{[a.table originalLayout];});Reset(a);
    policy=Policy(NO,YES,602);Native(a.controller,NO,^{[a.table originalLayout];});
    CALayer *neutralMask=a.table.layer.mask;
    Check(neutralMask && neutralMask!=originalMask && CGRectIsEmpty(neutralMask.bounds),@"blocked content installs one empty rendering mask and retains original layer mask");
    Check(a.table.accessibilityElementsHidden,@"whole-content neutral state suppresses accessibility content");
    a.table.tracking=YES;a.table.dragging=YES;BOOL moved=SyntheticDrag(a,40);
    Check(moved && fabs(a.table.contentOffset.y-440)<0.5,@"active neutral dragging remains responsive without revealing content");
    policy=Policy(NO,NO,603);a.privacyRefreshPending=YES;a.dirty=YES;[a refresh];
    Check(a.neutralViewport!=nil,@"ready publication during active drag retains pending genuine viewport");
    Check(a.table.layer.mask==neutralMask && a.table.accessibilityElementsHidden,@"ready rows stay fully neutral until gesture permits safe viewport restoration");
    Check(fabs(a.table.contentOffset.y-440)<0.5,@"ready publication does not reset contentOffset underneath active drag");
    Emit(@"ready-while-dragging-stage",ScrollStage(a));
    NSUInteger publicationReloads=a.table.reloads,publicationRowReloads=a.table.rowReloads;
    a.table.tracking=NO;a.table.dragging=NO;
    SEL end=@selector(scrollViewDidEndDragging:willDecelerate:);
    NSInvocation *inv=[NSInvocation invocationWithMethodSignature:[a.controller methodSignatureForSelector:end]];
    inv.selector=end;__unsafe_unretained id table=a.table;BOOL decelerate=NO;[inv setArgument:&table atIndex:2];[inv setArgument:&decelerate atIndex:3];
    Native(a.controller,NO,^{[inv invokeWithTarget:a.uiProxy];});
    Check(a.neutralViewport==nil && fabs(a.table.contentOffset.y-400)<0.5,@"scroll-end restores genuine viewport once and clears neutral restoration state");
    Check(a.table.layer.mask==originalMask && !a.table.accessibilityElementsHidden,@"post-restore publication restores original layer identity and accessibility state");
    Check(a.table.reloads==publicationReloads && a.table.rowReloads==publicationRowReloads,@"scroll-end restoration adds no reload beyond existing policy-revision publication");
    Emit(@"safe-scroll-end-stage",ScrollStage(a));
}
static void ReadyNativeUnlocked(void) {
    scenario=@"neutral-scroll/unlocked-native-after-blocked";policy=Policy(YES,NO,701);CSGroupListAdapter *a=List(NO);
    a.presentationViewport=nil;CALayer *originalMask=[CALayer layer];a.table.layer.mask=originalMask;
    Native(a.controller,NO,^{[a.table originalLayout];});Reset(a);
    policy=Policy(NO,YES,702);Native(a.controller,NO,^{[a.table originalLayout];});
    Check(a.neutralViewport!=nil && a.table.layer.mask!=originalMask,@"blocked transition captures native return viewport and neutralizes rendering");
    BOOL moved=SyntheticDrag(a,40);Check(moved && fabs(a.table.contentOffset.y-440)<0.5,@"blocked transition keeps native destination geometry scrollable");
    policy=Policy(YES,NO,703);a.nativePresentation=YES;a.privacyRefreshPending=YES;a.dirty=YES;[a refresh];
    Check(!a.projecting && a.nativePresentation,@"ready native destination preserves unlocked native presentation semantics");
    Check(a.neutralViewport==nil && fabs(a.table.contentOffset.y-400)<0.5,@"unlocked native publication consumes neutral viewport and restores genuine position");
    Check(a.table.layer.mask==originalMask && !a.table.accessibilityElementsHidden,@"unlocked native publication restores previous mask identity and accessibility");
    Reset(a);Native(a.controller,NO,^{[a.table originalLayout];});BOOL secret=NO;for(NSString *name in a.table.submissions.lastObject)secret|=[name hasPrefix:@"secret"];
    Check(secret,@"native unlocked content keeps existing protected-session revealed semantics");
    Emit(@"unlocked-native-restored-stage",ScrollStage(a));
}
static void ColdNeutralGeometry(NSString *entry) {
    scenario=[@"neutral-scroll/cold-scalar-cache/" stringByAppendingString:entry];policy=Policy(NO,NO,801);CSGroupListAdapter *a=List(NO);
    a.presentationViewport=nil;
    if([a.uiProxy respondsToSelector:NSSelectorFromString(@"setGeometry:")])[a.uiProxy setValue:nil forKey:@"geometry"];
    // The fixture's 80pt prefix is its table header; UIKit contentSize includes it.
    a.table.tableHeaderView=[GroupNeutralHeader new];a.table.tableHeaderView.frame=CGRectMake(0,0,320,80);
    a.table.contentSize=CGSizeMake(320,1800);Reset(a);policy=Policy(NO,YES,802);
    Native(a.controller,NO,^{[a.table originalLayout];});
    Check(fabs(a.table.contentSize.width-320)<0.5 && fabs(a.table.contentSize.height-1800)<0.5,@"cold gate preserves previous scrollable content bounding box using content-free slots");
    BOOL blank=a.table.visibleCells.count>0;for(UITableViewCell *cell in a.table.visibleCells)blank&=cell.textLabel.text.length==0;
    Check(blank,@"cold gate supplies only empty placeholders without native content");
    Check(a.controller.privateCellCalls==0,@"cold gate never measures or configures protected native content");
    BOOL moved=SyntheticDrag(a,40);Check(moved && fabs(a.table.contentOffset.y-440)<0.5,@"cold spacer supports controlled neutral drag");
    Native(a.controller,NO,^{[a.table originalLayout];});
    Check(fabs(a.table.contentSize.width-320)<0.5 && fabs(a.table.contentSize.height-1800)<0.5,@"repeated cold neutral query does not inflate or collapse content bounds");
    Check(a.table.reloads==0 && a.table.rowReloads==0,@"cold neutral geometry does not require table reconstruction");
    Emit(@"cold-neutral-stage",ScrollStage(a));
}
int main(void) {@autoreleasepool {
    Emit(@"probe-boundary",@{@"deviceEvidence":@NO,@"scope":@"Production proxy and shield; geometry and drag clamp are explicit host doubles; gesture flags are fixed fixture controls, not measured UIKit values"});
    for(NSString *entry in @[@"miniapp-container",@"chat-return"])for(NSString *readiness in @[@"blocked",@"stale-revision",@"nil-policy",@"wrong-policy-account"])NeutralScroll(entry,readiness);
    for(NSString *entry in @[@"miniapp-container",@"chat-return"])ReadyDuringDrag(entry);
    ReadyNativeUnlocked();
    for(NSString *entry in @[@"miniapp-container",@"chat-return"])ColdNeutralGeometry(entry);
    Emit(@"result",@{@"checks":@(checks),@"failures":@(failures)});
    fprintf(stderr,"Group neutral scroll HOST: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);return failures?1:0;
}}
