// Native methods below only record the requested operation. The production
// deletion hooks run verbatim, including the page delegate and policy checks.
static NSUInteger TimelineCellDeleteCalls,TimelinePageDeleteCalls,TimelineDeleteIndex;
static id TimelineDeletedItem;
@interface WCTimeLineViewController (TimelineDeleteFixture)
- (void)onWCTimeLineCommentCellDeleteComment:(NSUInteger)index ofDataItem:(id)item;
@end
@implementation WCTimeLineViewController (TimelineDeleteFixture)
- (void)onWCTimeLineCommentCellDeleteComment:(NSUInteger)index ofDataItem:(id)item {
    TimelinePageDeleteCalls++; TimelineDeleteIndex=index; TimelineDeletedItem=item;
}
@end
@interface WCTimeLineCommentCellView : UIView
@property(nonatomic,strong) id mainDataItem;
@property(nonatomic,weak) id m_delegate;
@property(nonatomic) NSUInteger deleteMenus,deleteEvents;
- (void)showCommentDeleteOption:(id)argument;
- (void)onCommentViewDelete:(id)argument;
- (void)deleteComment:(NSUInteger)index;
@end
@implementation WCTimeLineCommentCellView
- (void)showCommentDeleteOption:(__unused id)argument {self.deleteMenus++;}
- (void)onCommentViewDelete:(__unused id)argument {self.deleteEvents++;}
- (void)deleteComment:(NSUInteger)index {
    TimelineCellDeleteCalls++;
    [self.m_delegate onWCTimeLineCommentCellDeleteComment:index ofDataItem:self.mainDataItem];
}
@end
static void BindDeleteFixture(WCTimeLineCommentCellView *cell) {
    CSCFPageIsCurrent(cell); if(cell.m_delegate)CSCFPageIsCurrent(cell.m_delegate);
    objc_setAssociatedObject(cell,&CommentRevisionKey,@(Snapshot.revision),OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static int TestTimelineDeletion(void) {
    InstallCommentDeletion(); Policy(NO,300);
    TimelineCellDeleteCalls=TimelinePageDeleteCalls=AuthenticationRequests=0;
    TimelineDeletedItem=nil; AuthenticationOwner=nil;
    WCTimeLineViewController *page=[WCTimeLineViewController new];
    WCDataItem *item=[WCDataItem new]; item.username=@"alice";
    item.commentUsers=[@[@{@"username":@"secret"},@{@"username":@"fixture"},@{@"username":@"bob"}] mutableCopy];
    NSArray *source=item.commentUsers;
    WCTimeLineCommentCellView *cell=[WCTimeLineCommentCellView new]; cell.mainDataItem=item; cell.m_delegate=page;
    BindDeleteFixture(cell);
    [cell showCommentDeleteOption:nil];
    Check(AuthenticationRequests==1 && AuthenticationOwner==page && cell.deleteMenus==0);
    [cell onCommentViewDelete:nil];
    Check(AuthenticationRequests==2 && cell.deleteEvents==0);
    [cell deleteComment:1];
    Check(AuthenticationRequests==3 && TimelineCellDeleteCalls==0 && TimelinePageDeleteCalls==0);
    [page onWCTimeLineCommentCellDeleteComment:1 ofDataItem:item];
    Check(AuthenticationRequests==4 && TimelinePageDeleteCalls==0 && item.commentUsers==source && source.count==3);

    // Authentication changes policy only; it never replays an old menu/index.
    Policy(YES,301);
    Check(TimelineCellDeleteCalls==0 && TimelinePageDeleteCalls==0);
    [cell deleteComment:1];
    Check(TimelineCellDeleteCalls==0 && AuthenticationRequests==4);
    BindDeleteFixture(cell); [cell showCommentDeleteOption:nil]; [cell onCommentViewDelete:nil];
    Check(cell.deleteMenus==1 && cell.deleteEvents==1 && AuthenticationRequests==4);
    [cell deleteComment:1];
    Check(TimelineCellDeleteCalls==1 && TimelinePageDeleteCalls==1 && TimelineDeleteIndex==1 && TimelineDeletedItem==item);
    Check(item.commentUsers==source && source.count==3);

    Policy(NO,302); [cell showCommentDeleteOption:nil];
    Check(AuthenticationRequests==4 && cell.deleteMenus==1); // Old rendered revision is rejected.
    BindDeleteFixture(cell); [cell showCommentDeleteOption:nil];
    Check(AuthenticationRequests==5 && cell.deleteMenus==1 && TimelineCellDeleteCalls==1);
    WCDataItem *hidden=[WCDataItem new]; hidden.username=@"secret";
    cell.mainDataItem=hidden; BindDeleteFixture(cell); [cell deleteComment:0];
    [page onWCTimeLineCommentCellDeleteComment:0 ofDataItem:hidden];
    Check(AuthenticationRequests==5 && TimelineCellDeleteCalls==1 && TimelinePageDeleteCalls==1);

    // A vanished/unsupported native delegate must never receive a destructive call.
    cell.mainDataItem=item; cell.m_delegate=nil; BindDeleteFixture(cell); [cell deleteComment:0];
    Check(AuthenticationRequests==5 && TimelineCellDeleteCalls==1);
    cell.m_delegate=page; BindDeleteFixture(cell);
    Epoch++; Policy(YES,303); [cell showCommentDeleteOption:nil]; [cell deleteComment:0];
    [page onWCTimeLineCommentCellDeleteComment:0 ofDataItem:item];
    Check(AuthenticationRequests==5 && cell.deleteMenus==1 && TimelineCellDeleteCalls==1 && TimelinePageDeleteCalls==1);
    Epoch--; AuthenticationOwner=nil;
    puts("Timeline deletion: authentication at menu entry, no concealed edit or replay, fresh revealed native operation, unchanged source and stale account/revision guards passed");
    return 0;
}
