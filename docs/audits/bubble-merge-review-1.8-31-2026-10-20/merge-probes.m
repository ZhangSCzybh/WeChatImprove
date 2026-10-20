// Review-only probes. Reuse existing host doubles and exercise unchanged production code.
#define main CSExistingMergeRegressionMain
#include "../../../Tests/MessageMergeAdapterTests.m"
#undef main
int main(void) { @autoreleasepool {
    configure(YES);
    TestController *page=[TestController new];page.session=@"alice";
    page.nodes=[NSMutableArray arrayWithArray:@[model(18001),model(18002),model(18003)]];
    for (TextMessageViewModel *m in page.nodes) {m.contentViewSize=CGSizeMake(0,38);m.messageWrap.m_nsFromUsr=@"alice";}
    UIWindow *window=[UIWindow new];UITableView *t=[UITableView new];page.table=t;page.view=t;t.window=window;t.bounds=CGRectMake(0,0,320,600);
    NSIndexPath *path=[NSIndexPath indexPathForRow:0 inSection:1];
    CSMessageMergeActivate(page);CSMessageMergePrepare(page,t,path);
    CGFloat initial=CSMessageMergeRowHeight(page,t,path,55);
    TestCellView *v=[TestCellView new];v.viewModel=page.nodes[1];v.frame=CGRectMake(0,0,320,initial);v.bounds=v.frame;
    v.content=[UIView new];v.content.frame=CGRectMake(50,8,180,38);v.content.bounds=CGRectMake(0,0,180,38);v.subviews=@[v.content];
    TestTableCell *cell=[TestTableCell new];cell.cellView=v;
    t.testCells=@{path:cell};t.testHeights=@[@55,@(initial),@55];t.indexPathsForVisibleRows=@[path];
    insetBackground=v.content;visibleInsets=(UIEdgeInsets){1,0,3,0};
    CSMessageMergeBind(page,t,path,cell);t.dragging=YES;CSMessageMergeRender(v);
    CGFloat offset=v.frame.origin.y;
    CGFloat displayedBottom=offset+CGRectGetMaxY(v.content.frame)-visibleInsets.bottom;
    CGFloat gapWithNextLeadingPoint=initial+1-displayedBottom;
    CGFloat remeasured=CSMessageMergeRowHeight(page,t,path,55);
    printf("same_content_remeasure: initial=%.2f render_offset=%.2f gap_before_remeasure=%.2f remeasured=%.2f\n",initial,offset,gapWithNextLeadingPoint,remeasured);
    CHECK(initial==40 && remeasured==36 && gapWithNextLeadingPoint==6);
    // A cache notification with no data/size/settings change resets verified geometry.
    NSUInteger resets=((TextMessageViewModel *)page.nodes[1]).resetCount;
    CSMessageMergeInvalidateLayout(page);CSMessageMergeWillMutate(page);CSMessageMergeDidMutate(page);
    CSMessageMergeFlush(page);CHECK(t.updateCount==0);
    t.dragging=NO;CSMessageMergeFlush(page);
    CGFloat afterNoop=CSMessageMergeRowHeight(page,t,path,55);
    printf("noop_cache_notification: row_updates=%lu model_resets=%lu height_after=%.2f\n",(unsigned long)t.updateCount,(unsigned long)(((TextMessageViewModel *)page.nodes[1]).resetCount-resets),afterNoop);
    CHECK(t.updateCount==1 && afterNoop==40);
    CSMessageMergeReuse(v);CSMessageMergeDeactivate(page);
} return 0; }
