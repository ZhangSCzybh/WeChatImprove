#import <UIKit/UIKit.h>
#import "CSSettingsTableViewController.h"
#include <math.h>
#include <stdlib.h>

static unsigned checks;
#define CHECK(c) do { checks++;if (!(c)) { fprintf(stderr,"FAIL line %d: %s\n",__LINE__,#c);exit(1); } } while(0)
static BOOL Equal(CGFloat a, CGFloat b) { return fabs(a-b)<.001; }

@interface NestedSettingsFixture : CSSettingsTableViewController
@property(nonatomic) NSUInteger childLoads;
@end
@implementation NestedSettingsFixture
- (void)viewDidLoad { [super viewDidLoad];self.childLoads++; }
@end

static CSSettingsTableViewController *Page(CGFloat safeBottom,CGFloat top,CGFloat automaticTop,CGFloat y) {
    CSSettingsTableViewController *page=[[CSSettingsTableViewController alloc] initWithStyle:UITableViewStyleInsetGrouped];
    UITableView *table=[UITableView new];
    table.safeAreaInsets=UIEdgeInsetsMake(88,0,safeBottom,0);
    table.contentInset=UIEdgeInsetsMake(top,4,12,5);
    table.verticalScrollIndicatorInsets=UIEdgeInsetsMake(top,6,9,7);
    table.testAutomaticInsets=UIEdgeInsetsMake(automaticTop,0,safeBottom,0);
    table.contentOffset=CGPointMake(3,y);
    page.testPreparedTable=table;
    CHECK(!page.isViewLoaded);
    CHECK(page.edgesForExtendedLayout==UIRectEdgeNone);
    CHECK(!page.extendedLayoutIncludesOpaqueBars);
    CHECK(!page.automaticallyAdjustsScrollViewInsets);
    CHECK(page.navigationItem.largeTitleDisplayMode==UINavigationItemLargeTitleDisplayModeNever);
    [page loadViewIfNeeded];
    CHECK(page.testDidLoadCalls==1);
    CHECK(page.tableView==table && page.view==table);
    CHECK(table.contentInsetAdjustmentBehavior==UIScrollViewContentInsetAdjustmentNever);
    CHECK(!table.automaticallyAdjustsScrollIndicatorInsets);
    CHECK(table.contentInset.top==0 && table.verticalScrollIndicatorInsets.top==0);
    CHECK(table.contentInset.left==4 && table.contentInset.right==5);
    CHECK(table.verticalScrollIndicatorInsets.left==6 && table.verticalScrollIndicatorInsets.right==7);
    CHECK(Equal(table.contentInset.bottom,12+safeBottom));
    CHECK(Equal(table.verticalScrollIndicatorInsets.bottom,9+safeBottom));
    CHECK(table.contentOffset.x==3);
    return page;
}

int main(void) { @autoreleasepool {
    // Apply final navigation policy before loading the table or entering a push.
    CSSettingsTableViewController *decoded=[[CSSettingsTableViewController alloc] initWithCoder:nil];
    CHECK(!decoded.isViewLoaded && decoded.edgesForExtendedLayout==UIRectEdgeNone);
    CHECK(!decoded.automaticallyAdjustsScrollViewInsets);
    CHECK(decoded.navigationItem.largeTitleDisplayMode==UINavigationItemLargeTitleDisplayModeNever);
    NestedSettingsFixture *nested=[[NestedSettingsFixture alloc] initWithStyle:UITableViewStyleInsetGrouped];
    [nested loadViewIfNeeded];CHECK(nested.childLoads==1 && nested.testDidLoadCalls==1);
    CHECK(nested.tableView.contentInsetAdjustmentBehavior==UIScrollViewContentInsetAdjustmentNever);

    CSSettingsTableViewController *page=Page(34,0,88,0);
    UITableView *table=page.tableView;
    CGPoint retainedOffset=CGPointMake(3,312.75);table.contentOffset=retainedOffset;
    // Keyboard/editor additions and explicit top margins belong to the page.
    table.contentInset=UIEdgeInsetsMake(7,4,346,5);
    table.verticalScrollIndicatorInsets=UIEdgeInsetsMake(8,6,173,7);
    NSUInteger offsets=table.testOffsetWrites;
    NSUInteger insets=table.testInsetWrites,indicators=table.testIndicatorWrites;
    for (NSUInteger i=0;i<1000;i++) {
        [page viewDidLayoutSubviews];[page viewSafeAreaInsetsDidChange];
        [page viewWillDisappear:YES];[page viewDidDisappear:YES];
        [page viewWillAppear:YES];[page viewDidAppear:YES];
        CHECK(Equal(table.contentOffset.y,retainedOffset.y));
        CHECK(table.contentInset.top==7 && table.verticalScrollIndicatorInsets.top==8);
        CHECK(table.contentInset.bottom==346 && table.verticalScrollIndicatorInsets.bottom==173);
    }
    CHECK(table.testOffsetWrites==offsets);
    CHECK(table.testInsetWrites==insets && table.testIndicatorWrites==indicators);
    CHECK(page.testLayoutCalls==1000 && page.testSafeAreaCalls==1000);
    // Rotation, presentation and the home indicator can change the safe bottom.
    // Only its prior contribution is replaced; keyboard/editor additions survive.
    for (NSUInteger i=0;i<500;i++) {
        table.safeAreaInsets=UIEdgeInsetsMake(i%2 ? 44 : 96,0,21,0);
        [page viewSafeAreaInsetsDidChange];
        CHECK(table.contentInset.bottom==333 && table.verticalScrollIndicatorInsets.bottom==160);
        table.safeAreaInsets=UIEdgeInsetsMake(44,0,0,0);[page viewDidLayoutSubviews];
        CHECK(table.contentInset.bottom==312 && table.verticalScrollIndicatorInsets.bottom==139);
        table.safeAreaInsets=UIEdgeInsetsMake(44,0,34,0);[page viewDidLayoutSubviews];
        CHECK(table.contentInset.bottom==346 && table.verticalScrollIndicatorInsets.bottom==173);
        CHECK(table.contentOffset.x==3 && table.contentOffset.y==312.75);
    }
    CHECK(table.testOffsetWrites==offsets);
    CHECK(table.contentInset.top==7 && table.verticalScrollIndicatorInsets.top==8);
    CHECK(table.contentInset.left==4 && table.contentInset.right==5);
    // Returning during a native negative rebound must not trigger startup logic.
    table.contentOffset=CGPointMake(3,-12.5);offsets=table.testOffsetWrites;
    [page viewWillAppear:YES];[page viewDidAppear:YES];[page viewDidLayoutSubviews];
    [page viewSafeAreaInsetsDidChange];
    CHECK(table.contentOffset.y==-12.5 && table.contentOffset.x==3);
    CHECK(table.testOffsetWrites==offsets);

    // Initial preloaded tables can already be pinned to an old navigation inset.
    // Clearing that inset must keep the first row at the visible top.
    CSSettingsTableViewController *provisional=Page(34,88,0,-88);
    CHECK(provisional.tableView.contentOffset.y==0);
    CSSettingsTableViewController *automatic=Page(0,0,88,-88);
    CHECK(automatic.tableView.contentOffset.y==0);
    // A restored/scrolled initial position is not the old top boundary.
    CSSettingsTableViewController *restored=Page(34,88,0,240.5);
    CHECK(restored.tableView.contentOffset.y==240.5);
    CSSettingsTableViewController *overscrolled=Page(34,88,0,-103);
    CHECK(overscrolled.tableView.contentOffset.y==-103);
    CSSettingsTableViewController *fractional=Page(0,55.5,0,-55.5);
    CHECK(fractional.tableView.contentOffset.y==0);
    // Respect a correction UIKit makes synchronously when its policy changes.
    CSSettingsTableViewController *corrected=[[CSSettingsTableViewController alloc] initWithStyle:UITableViewStyleInsetGrouped];
    UITableView *correctedTable=[UITableView new];
    correctedTable.testAutomaticInsets=UIEdgeInsetsMake(88,0,0,0);
    correctedTable.contentOffset=CGPointMake(9,-88);
    correctedTable.testCorrectsOffsetWhenDisablingAdjustment=YES;
    correctedTable.testCorrectedOffset=CGPointMake(9,76);
    corrected.testPreparedTable=correctedTable;
    [corrected loadViewIfNeeded];
    CHECK(corrected.tableView.contentOffset.y==76 && corrected.tableView.contentOffset.x==9);

    // Native/contact tables are outside the settings inheritance boundary.
    UITableViewController *native=[[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    [native loadViewIfNeeded];
    CHECK(native.edgesForExtendedLayout==UIRectEdgeAll);
    CHECK(native.automaticallyAdjustsScrollViewInsets);
    CHECK(native.navigationItem.largeTitleDisplayMode==UINavigationItemLargeTitleDisplayModeAutomatic);
    CHECK(native.tableView.contentInsetAdjustmentBehavior==UIScrollViewContentInsetAdjustmentAutomatic);
    CHECK(native.tableView.automaticallyAdjustsScrollIndicatorInsets);
    printf("PASS: %u settings lifecycle checks (host UIKit double; no iOS runtime)\n",checks);
} return 0; }
