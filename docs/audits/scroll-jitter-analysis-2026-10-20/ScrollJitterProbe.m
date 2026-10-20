#define main CSOriginalMergeRegressionMain
#include "../../../Tests/MessageMergeAdapterTests.m"
#undef main
int main(void) { @autoreleasepool {
    configure(YES);
    TestController *page=[TestController new];page.session=@"alice";
    page.nodes=[NSMutableArray arrayWithArray:@[model(24001),model(24002),model(24003)]];
    UITableView *table=[UITableView new];page.table=table;page.view=table;
    UIWindow *window=[UIWindow new];table.window=window;table.bounds=CGRectMake(0,0,320,500);
    table.contentSize=CGSizeMake(320,1200);table.testHeights=@[@61,@61,@61];
    NSIndexPath *path=[NSIndexPath indexPathForRow:0 inSection:1];
    TestCellView *view=[TestCellView new];view.viewModel=page.nodes[1];view.viewModel.contentViewSize=CGSizeMake(0,44);
    view.frame=CGRectMake(0,0,320,61);view.bounds=view.frame;view.content=[UIView new];
    view.content.frame=CGRectMake(50,8,200,44);view.content.bounds=CGRectMake(0,0,200,44);view.subviews=@[view.content];
    insetBackground=view.content;visibleInsets=(UIEdgeInsets){3,0,3,0};
    TestTableCell *cell=[TestTableCell new];cell.cellView=view;table.testCells=@{path:cell};table.indexPathsForVisibleRows=@[path];
    CSMessageMergeActivate(page);CSMessageMergePrepare(page,table,path);
    CGFloat initial=CSMessageMergeRowHeight(page,table,path,61);
    CSMessageMergeBind(page,table,path,cell);CSMessageMergeRender(view);
    CGFloat renderedOrigin=view.frame.origin.y;
    CGFloat later=CSMessageMergeRowHeight(page,table,path,61);
    printf("Same native inputs / real adapter with UIKit doubles: row height %.0f -> %.0f pt after render; explicit table updates = %lu.\n",initial,later,(unsigned long)table.updateCount);
    printf("First row measurement predicted origin -7 pt; render applied %.0f pt while row still had first height.\n",renderedOrigin);
    CHECK(initial==46 && later==40 && table.updateCount==0 && renderedOrigin==-10);
    CSMessageMergeRender(view);CGFloat beforeEpoch=view.frame.origin.y;
    table.dragging=YES;
    CSMessageMergeInvalidateLayout(page);CSMessageMergeBind(page,table,path,cell);CSMessageMergeRender(view);
    CGFloat afterEpoch=view.frame.origin.y;
    CSMessageMergeDidMutate(page);CSMessageMergeFlush(page);
    NSUInteger during=table.updateCount;
    table.dragging=NO;CSMessageMergeFlush(page);
    printf("Same-message epoch invalidation: rendered origin %.0f -> %.0f pt; table updates while dragging %lu, after stop %lu.\n",beforeEpoch,afterEpoch,(unsigned long)during,(unsigned long)table.updateCount);
    CHECK(beforeEpoch==-10 && afterEpoch==0 && during==0 && table.updateCount==1);
    printf("Characterization checks passed. These reproduce instability; they do not validate a fix or actual UIKit timing.\n");
    CSMessageMergeDeactivate(page);insetBackground=nil;
} return 0; }
