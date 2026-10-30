// Supplemental compatibility checks. The immutable 14-check red/green suite is
// included with only its main definition renamed by the runner, then not run.
#include "TopTransitionCompatibilityHarness.m"

@interface TopMMCellSubclass : MMTableViewCell @end
@implementation TopMMCellSubclass @end

static void TopCompatibilityCase(BOOL subclass,BOOL inTableLayout) {
    Configure();UITableView *table=Table();table.window=[UIWindow new];
    id owner=Owner(CSListCornerPageSession,table);table.rows=@[@2];
    CSListCornerPrepareTable(owner,CSListCornerPageSession,YES);
    UITableViewCell *cell=subclass?[[TopMMCellSubclass alloc] initWithFrame:CGRectMake(0,0,390,60)]:TopBusinessCell(table);
    if(subclass) {cell.contentView.frame=cell.bounds;cell.path=Path(0,0);[table addSubview:cell];}
    // Fixture has one initial decoration. Return below does not redeliver a cell.
    CSListCornerSessionDecorate(cell,table,cell.path,owner);
    UIView *card=CSListCornerExistingSessionBackground(cell);
    CGRect beforeFrame=card.frame;UIColor *beforeColor=card.backgroundColor;
    CALayer *beforeMask=card.layer.mask;CGPathRef beforePath=((CAShapeLayer *)beforeMask).path;
    NSUInteger beforeInvalidations=card.displayInvalidations;
    table.contentOffset=CGPointMake(0,120);CGPoint beforeOffset=table.contentOffset;
    topWatchedCard=card;TopResetCounts();table.queries=0;table.throwsOnQuery=YES;
    void (^native)(void)=^{
        TopTransitionMMCellLayout(cell,^{
            topNativeLayouts++;CGRect frame=cell.contentView.frame;
            frame.size.width=cell.bounds.size.width;frame.origin.x=0;cell.contentView.frame=frame;
        });
        if(inTableLayout)
            Check(topApplyCalls==0 && topRefreshCalls==0,@"MM cell closeout remains suppressed inside the native table-layout scope");
    };
    if(inTableLayout) HookSessionTableLayout(table,native); else native();
    TopCounts(subclass?@"compatibility.subclass":inTableLayout?@"compatibility.table-layout-depth":@"compatibility.unchanged-native-width-x",table,cell,card);
    Check(topFrameWrites==0 && topBackgroundWrites==0 && card.displayInvalidations==beforeInvalidations,
          @"unchanged native content does not rewrite card frame/background or invalidate display");
    Check(CGRectEqualToRect(card.frame,beforeFrame) && [card.backgroundColor isEqual:beforeColor] &&
          card.layer.mask==beforeMask && ((CAShapeLayer *)beforeMask).path==beforePath,
          @"unchanged native layout retains card geometry, color, mask and path identities");
    Check(CGPointEqualToPoint(table.contentOffset,beforeOffset) && table.reloads==0 && table.queries==0 && topNativeLayouts==1,
          @"compatibility input preserves offset with one native layout and no host reloadData/model queries");
    if(subclass) Check(topApplyCalls==0 && topRefreshCalls==0,@"base hook does not add a second geometry refresh for subclasses");
    topWatchedCard=nil;
}
int main(void) { @autoreleasepool {
    FixtureDefaults=[MemoryDefaults new];FixtureConfiguration=[[CSListCornerConfiguration alloc] initWithDefaults:FixtureDefaults];
    method_setImplementation(class_getClassMethod(CSListCornerConfiguration.class,@selector(sharedConfiguration)),(IMP)SharedConfiguration);
    topOriginalBackground=method_setImplementation(class_getInstanceMethod(UIView.class,@selector(setBackgroundColor:)),(IMP)TopBackground);
    topOriginalFrame=method_setImplementation(class_getInstanceMethod(UIView.class,@selector(setFrame:)),(IMP)TopFrame);
    TopCompatibilityCase(NO,NO);TopCompatibilityCase(YES,NO);TopCompatibilityCase(NO,YES);
    fprintf(stdout,"Top transition compatibility: %lu checks, %lu failures (supplemental; host initial decorate once, no return delivery; device delivery/draw/CA unknown)\n",(unsigned long)checks,(unsigned long)failures);
    return failures?1:0;
} }
