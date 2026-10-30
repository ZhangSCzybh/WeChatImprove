// Reuse existing host interfaces, ownership/configuration fixtures and production
// hook extraction. Its full historical test main is compiled but is not run.
#define main TopTransitionUnusedHistoricalMain
#include "ListCornerSemanticsTests.m"
#undef main
#include "TopTransitionHooks.h"

@interface MMTableViewCell : UITableViewCell @end
@implementation MMTableViewCell @end
static UITableViewCell *TopBusinessCell(UITableView *table) {
    UITableViewCell *cell=[[MMTableViewCell alloc] initWithFrame:CGRectMake(0,0,390,60)];
    cell.contentView.frame=cell.bounds;cell.path=Path(0,0);[table addSubview:cell];return cell;
}

extern void TopRealApplyCardBackground(UIView *,CGRect,CGFloat,BOOL,BOOL,UIColor *);
extern BOOL TopRealRefreshCardBackground(UIView *,CGRect,CGFloat,UIColor *);
static NSUInteger topApplyCalls,topRefreshCalls,topNativeLayouts,topTransitionSequence;
static NSUInteger topBackgroundWrites,topFrameWrites;
static UIView *topWatchedCard;
static IMP topOriginalBackground,topOriginalFrame;
static void TopBackground(id self,SEL command,UIColor *color) {
    if (self==topWatchedCard) topBackgroundWrites++;
    ((void (*)(id,SEL,id))topOriginalBackground)(self,command,color);
}
static void TopFrame(id self,SEL command,CGRect frame) {
    if (self==topWatchedCard) topFrameWrites++;
    ((void (*)(id,SEL,CGRect))topOriginalFrame)(self,command,frame);
}
void CSListApplyCardBackground(UIView *view,CGRect frame,CGFloat radius,BOOL first,BOOL last,UIColor *color) {
    topApplyCalls++; TopRealApplyCardBackground(view,frame,radius,first,last,color);
}
BOOL CSListRefreshCardBackground(UIView *view,CGRect frame,CGFloat radius,UIColor *color) {
    topRefreshCalls++; return TopRealRefreshCardBackground(view,frame,radius,color);
}
static void TopCounts(NSString *event,UITableView *table,UITableViewCell *cell,UIView *card) {
    NSDictionary *record=@{@"event":event,@"sequence":@(++topTransitionSequence),
        @"inputBoundary":@"synthetic native MMTableViewCell layout; no UIKit compositor",
        @"hostNativeCellLayouts":@(topNativeLayouts),@"rendererApplyCalls":@(topApplyCalls),
        @"rendererRefreshCalls":@(topRefreshCalls),@"cardBackgroundSetterCalls":@(topBackgroundWrites),
        @"cardFrameSetterCalls":@(topFrameWrites),@"hostReloadData":@(table.reloads),
        @"visibleCardAttached":@(card.superview==cell.contentView),
        @"cardWidth":@(card.frame.size.width),@"contentWidth":@(cell.contentView.bounds.size.width),
        @"contentX":@(cell.contentView.frame.origin.x),@"maskWidth":@(card.layer.mask.frame.size.width),
        @"scrollX":@(table.contentOffset.x),@"scrollY":@(table.contentOffset.y),
        @"hostDisplayInvalidations":@(card.displayInvalidations),
        @"deviceDrawRectCalls":NSNull.null,@"deviceCACommits":NSNull.null};
    NSData *json=[NSJSONSerialization dataWithJSONObject:record options:NSJSONWritingSortedKeys error:NULL];
    fprintf(stdout,"TOP-TRANSITION %s\n",[[[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding] UTF8String]);
}
static void TopResetCounts(void) {
    topApplyCalls=topRefreshCalls=topNativeLayouts=topBackgroundWrites=topFrameWrites=topTransitionSequence=0;
}
static void TopTransitionCase(BOOL replaceContent) {
    Configure();UITableView *table=Table();table.window=[UIWindow new];
    id owner=Owner(CSListCornerPageSession,table);table.rows=@[@2];
    CSListCornerPrepareTable(owner,CSListCornerPageSession,YES);
    UITableViewCell *cell=TopBusinessCell(table);
    [cell.contentView addSubview:View(MFBannerBtn.class,cell.bounds)];
    CSListCornerSessionDecorate(cell,table,cell.path,owner);
    UIView *card=CSListCornerExistingSessionBackground(cell),*oldContent=cell.contentView;
    Check(card && card.superview==oldContent,@"initial business card exists before controlled return");
    table.queries=0;table.throwsOnQuery=YES;
    topWatchedCard=card;TopResetCounts();
    TopCounts(replaceContent?@"transition-begin.content-replacement":@"transition-begin.native-paint-reset",table,cell,card);
    TopTransitionMMCellLayout(cell,^{
        topNativeLayouts++;
        if (replaceContent) {
            UIView *replacement=View(UIView.class,cell.bounds);
            [replacement addSubview:View(MFBannerBtn.class,cell.bounds)];
            cell.contentView=replacement;[cell addSubview:replacement];[oldContent removeFromSuperview];
        } else {
            card.backgroundColor=UIColor.clearColor;card.layer.mask=nil;
        }
    });
    TopCounts(@"cell-layout-return.first-eligible-host-checkpoint",table,cell,card);
    if(replaceContent)
        Check(card.superview==cell.contentView && [cell.contentView.subviews containsObject:card],
              @"return cell layout reattaches its existing business card before a later table/VC layout");
    else
        Check([card.backgroundColor isEqual:[FixtureConfiguration.snapshot backgroundForStyle:cell.contentView.traitCollection.userInterfaceStyle]] && card.layer.mask,
              @"return cell layout repairs native-reset business-card paint/mask before later table/VC layout");
    Check(table.queries==0 && table.reloads==0,@"business-card closeout does not query rows or reload the list");
    // Controlled later boundary proves why a steady-state-only test misses it.
    HookSessionTableLayout(table,^{ });
    TopCounts(@"later-table-layout-return",table,cell,card);
    Check(card.superview==cell.contentView && card.layer.mask &&
          [card.backgroundColor isEqual:[FixtureConfiguration.snapshot backgroundForStyle:cell.contentView.traitCollection.userInterfaceStyle]],
          @"later table boundary recovers the same retained card without a cell delivery");
    Check(topNativeLayouts==1 && table.reloads==0 && table.queries==0,
          @"controlled failure/recovery has one cell layout and zero reload/model queries");
    TopCounts(@"transition-end.synthetic",table,cell,card);topWatchedCard=nil;
}
static void TopNativeFrameCase(void) {
    Configure();UITableView *table=Table();table.window=[UIWindow new];
    id owner=Owner(CSListCornerPageSession,table);table.rows=@[@2];
    CSListCornerPrepareTable(owner,CSListCornerPageSession,YES);
    UITableViewCell *cell=TopBusinessCell(table);
    // Controlled incoming geometry. The native MMTableViewCell body statically
    // sends contentView.setWidth:self.width and setX:0; these are its real
    // operations, but this input width and their device frequency are unknown.
    cell.contentView.frame=CGRectMake(-40,0,450,60);
    CSListCornerSessionDecorate(cell,table,cell.path,owner);
    UIView *card=CSListCornerExistingSessionBackground(cell);topWatchedCard=card;
    NSIndexPath *beforePath=cell.path;CGRect beforeCell=cell.frame;
    table.contentOffset=CGPointMake(0,120);CGPoint beforeOffset=table.contentOffset;
    table.queries=0;table.throwsOnQuery=YES;TopResetCounts();
    TopCounts(@"transition-begin.native-content-width-x-input",table,cell,card);
    TopTransitionMMCellLayout(cell,^{
        topNativeLayouts++;CGRect native=cell.contentView.frame;
        native.size.width=cell.bounds.size.width;native.origin.x=0;cell.contentView.frame=native;
    });
    TopCounts(@"native-width-x.cell-layout-return",table,cell,card);
    CGFloat expected=cell.contentView.bounds.size.width-FixtureConfiguration.snapshot.leftMargin-FixtureConfiguration.snapshot.rightMargin;
    Check(Near(card.frame.size.width,expected) && Near(((CAShapeLayer *)card.layer.mask).frame.size.width,expected),
          @"native content width/x repair closes existing business-card geometry before the cell layout returns");
    Check(cell.path==beforePath && CGRectEqualToRect(cell.frame,beforeCell) && CGPointEqualToPoint(table.contentOffset,beforeOffset),
          @"native content-width case preserves row position, row identity and scroll offset");
    Check(table.reloads==0 && table.queries==0 && topNativeLayouts==1,@"native width/x case has one cell layout and no reload/model queries");
    HookSessionTableLayout(table,^{});
    Check(Near(card.frame.size.width,expected) && Near(((CAShapeLayer *)card.layer.mask).frame.size.width,expected),
          @"later table layout recovers the retained card after native content-width input");
    TopCounts(@"native-width-x.later-table-layout-return",table,cell,card);topWatchedCard=nil;
}
int main(void) { @autoreleasepool {
    FixtureDefaults=[MemoryDefaults new];FixtureConfiguration=[[CSListCornerConfiguration alloc] initWithDefaults:FixtureDefaults];
    method_setImplementation(class_getClassMethod(CSListCornerConfiguration.class,@selector(sharedConfiguration)),(IMP)SharedConfiguration);
    topOriginalBackground=method_setImplementation(class_getInstanceMethod(UIView.class,@selector(setBackgroundColor:)),(IMP)TopBackground);
    topOriginalFrame=method_setImplementation(class_getInstanceMethod(UIView.class,@selector(setFrame:)),(IMP)TopFrame);
    TopTransitionCase(YES);TopTransitionCase(NO);TopNativeFrameCase();
    fprintf(stdout,"Top transition: %lu checks, %lu failures (complete MM cell hook + production corner modules; controlled host inputs, no device frame claim)\n",(unsigned long)checks,(unsigned long)failures);
    return failures?1:0;
} }
