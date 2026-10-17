#import <UIKit/UIKit.h>
#import <QuartzCore/CADisplayLink.h>
#import "CSMessageMergeAdapter.h"
#import "CSMessageMergePolicy.h"
#import "CSMessageNavigation.h"
#import "CSMessageTimeLayout.h"
#import "CSRevokeReference.h"
#include <stdlib.h>
static unsigned checks;
#define CHECK(x) do { checks++; if (!(x)) { fprintf(stderr,"FAIL line %d: %s\n",__LINE__,#x); exit(1); } } while (0)
@interface MMContext : NSObject
+ (NSString *)currentUserName;
@end
@implementation MMContext
+ (NSString *)currentUserName { return @"account"; }
@end
@interface TestWrap : NSObject
@property(nonatomic) unsigned int m_uiMesLocalID;
@property(nonatomic) unsigned int m_uiCreateTime;
@property(nonatomic) unsigned int m_uiMessageType;
@property(nonatomic) long long m_n64MesSvrID;
@property(nonatomic,copy) NSString *m_nsFromUsr;
@property(nonatomic,copy) NSString *m_nsToUsr;
@property(nonatomic,copy) NSString *m_nsRealChatUsr;
@property(nonatomic,copy) NSString *m_nsContent;
@property(nonatomic,copy) NSString *m_nsPattern;
@end
@implementation TestWrap @end
@interface TextMessageViewModel : NSObject
@property(nonatomic,strong) TestWrap *messageWrap;
@property(nonatomic) BOOL isSender;
@property(nonatomic) NSUInteger resetCount;
@property(nonatomic) long long rows;
@property(nonatomic) CGSize contentViewSize;
@property(nonatomic) BOOL canShowTranslateView;
@property(nonatomic,strong) NSArray *subViewModels;
- (long long)numberOfRowsInSection;
- (id)cellDataForRow:(unsigned long long)row;
- (void)resetLayoutCache;
@end
@implementation TextMessageViewModel
- (instancetype)init { if ((self=[super init])) _rows=1;return self; }
- (long long)numberOfRowsInSection { return self.rows; }
- (id)cellDataForRow:(unsigned long long)row { return self.subViewModels.count>row ? self.subViewModels[row] : self; }
- (void)resetLayoutCache { self.resetCount++; CSMessageMergeResetGeometry(self); }
@end
// Match the dumped separate NSObject parent/submodel protocol, not single-row stand-ins.
@interface TextMessageSubViewModel : NSObject
@property(nonatomic,weak) TextMessageViewModel *parentModel;
@property(nonatomic) NSUInteger resetCount;
@property(nonatomic,copy) NSString *content;
- (void)resetLayoutCache;
@end
@implementation TextMessageSubViewModel
- (void)resetLayoutCache { self.resetCount++;self.content=nil;[self.parentModel resetLayoutCache]; }
@end
@interface TestCellView : UIView {
@public UIView *m_chatRoomNameLabel;
}
@property(nonatomic,strong) TextMessageViewModel *viewModel;
@property(nonatomic,strong) UIView *head;
@property(nonatomic,strong) UIView *content;
- (id)getHeadImageView;
- (id)getContentView;
@end
@implementation TestCellView
- (id)getHeadImageView { return self.head; }
- (id)getContentView { return self.content; }
@end
@interface TestTableCell : NSObject
@property(nonatomic,strong) TestCellView *cellView;
@end
@implementation TestTableCell @end
@interface TestController : UIViewController
@property(nonatomic,strong) UITableView *table;
@property(nonatomic,strong) NSMutableArray *nodes;
@property(nonatomic,copy) NSString *session;
@property(nonatomic) double lastMargin;
@property(nonatomic) NSUInteger scrollCount;
@property(nonatomic) NSUInteger highlightCount;
@property(nonatomic,strong) id highlightedMessage;
@property(nonatomic) BOOL lastScrollHighlight;
@property(nonatomic) BOOL nativePresentationPending;
@property(nonatomic) BOOL highlightVisible;
@property(nonatomic) BOOL missingHighlightAPI;
@property(nonatomic) BOOL incompatibleHighlightAPI;
- (void)highlightMsg:(id)message;
- (id)getTableView;
- (id)getCurrentChatName;
- (id)GetMessageNodeDataArray;
- (void)scrollToMessage:(id)message highlight:(BOOL)highlight marginTop:(double)margin animated:(BOOL)animated;
@end
@implementation TestController
- (id)getTableView { return self.table; }
- (id)getCurrentChatName { return self.session; }
- (id)GetMessageNodeDataArray { return self.nodes; }
- (void)scrollToMessage:(id)message highlight:(BOOL)highlight marginTop:(double)margin animated:(BOOL)animated { self.scrollCount++; self.lastMargin=margin; self.lastScrollHighlight=highlight; }
- (void)highlightMsg:(id)message { self.highlightCount++;self.highlightedMessage=message;self.highlightVisible=!self.nativePresentationPending; }
- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    if (selector==@selector(highlightMsg:)) {
        if (self.missingHighlightAPI) return nil;
        if (self.incompatibleHighlightAPI) return [NSMethodSignature signatureWithObjCTypes:"v@:q"];
    }
    return [super methodSignatureForSelector:selector];
}
@end
@interface TestManager : NSObject
@property(nonatomic,strong) TestWrap *wrap;
- (id)GetMsg:(id)session n64SvrID:(long long)ID;
@end
@implementation TestManager
- (id)GetMsg:(id)session n64SvrID:(long long)ID { return self.wrap.m_n64MesSvrID==ID ? self.wrap : nil; }
@end
static TextMessageViewModel *model(unsigned n) {
    TextMessageViewModel *m=[TextMessageViewModel new]; TestWrap *w=[TestWrap new];
    w.m_uiMesLocalID=n; w.m_n64MesSvrID=100+n;w.m_nsFromUsr=@"group@chatroom";w.m_nsToUsr=@"account";w.m_nsRealChatUsr=@"alice";m.messageWrap=w;m.contentViewSize=CGSizeMake(200,30);return m;
}
static void configure(BOOL enabled) {
    [NSUserDefaults.standardUserDefaults setVolatileDomain:@{CSMessageMergeEnabledKey:@(enabled),CSMessageMergeScopeKey:@3,
        CSMessageMergeSpacingKey:@(-12),CSMessageMergeAvatarKey:@1} forName:NSArgumentDomain];
}
int main(void) { @autoreleasepool {
    TestWrap *timeWrap=[TestWrap new];timeWrap.m_uiCreateTime=1700000000;
    TextMessageViewModel *timeModel=[TextMessageViewModel new];timeModel.messageWrap=timeWrap;
    unsigned int stamp=0;CHECK(CSMessageTimeReadTimestamp(timeModel,&stamp));CHECK(stamp==1700000000);
    CHECK(!CSMessageTimeReadTimestamp([NSObject new],&stamp));CHECK(stamp==0);
    NSUserDefaults *timeDefaults=NSUserDefaults.standardUserDefaults;
    [timeDefaults setVolatileDomain:@{} forName:NSArgumentDomain];
    NSDateFormatter *expected=[NSDateFormatter new];expected.dateFormat=@"HH:mm";
    CHECK([CSMessageTimeText(1700000000,timeDefaults) isEqual:[expected stringFromDate:[NSDate dateWithTimeIntervalSince1970:1700000000]]]);
    [timeDefaults setVolatileDomain:@{@"com.wechat.enhance.messageTime.showYear":@YES,@"com.wechat.enhance.messageTime.showSecond":@YES} forName:NSArgumentDomain];
    expected.dateFormat=@"yyyy\nss";
    CHECK([CSMessageTimeText(1700000000,timeDefaults) isEqual:[expected stringFromDate:[NSDate dateWithTimeIntervalSince1970:1700000000]]]);
    CHECK(!CSMessageTimeText(0,timeDefaults));
    UIView *timeContainer=[UIView new];
    UIView *timeLabel=[UIView new], *head=[UIView new], *bubble=[UIView new];
    timeLabel.hidden=YES;timeLabel.bounds=CGRectMake(0,0,40,20);
    head.frame=CGRectMake(10,10,30,30);bubble.frame=CGRectMake(50,15,100,60);
    head.bounds=CGRectMake(0,0,30,30);bubble.bounds=CGRectMake(0,0,100,60);
    CSMessageTimePositionLabel(timeLabel,timeContainer,head,bubble,NO,YES);
    CHECK(CGPointEqualToPoint(timeLabel.center,CGPointMake(25,43)));
    CHECK(timeLabel.hidden); // Layout must not change tap visibility.
    head.hidden=YES;CSMessageTimePositionLabel(timeLabel,timeContainer,head,bubble,NO,YES);
    CHECK(CGPointEqualToPoint(timeLabel.center,CGPointMake(171,65)));
    timeLabel.hidden=NO;CSMessageTimePositionLabel(timeLabel,timeContainer,head,bubble,YES,YES);
    CHECK(CGPointEqualToPoint(timeLabel.center,CGPointMake(29,65)));
    CHECK(CSMessageTimeCanToggle(YES,YES,@"12:34"));
    CHECK(!CSMessageTimeCanToggle(NO,YES,@"12:34"));
    CHECK(!CSMessageTimeCanToggle(YES,NO,@"12:34"));
    CHECK(!CSMessageTimeCanToggle(YES,YES,@"-1"));
    CHECK(!CSMessageTimeCanToggle(YES,YES,nil));
    configure(YES);
    UIWindow *window=[UIWindow new];
    TestController *vc=[TestController new];vc.session=@"group@chatroom";vc.nodes=[NSMutableArray arrayWithArray:@[model(1),model(2)]];
    UITableView *table=[UITableView new];vc.table=table;vc.view=table;table.window=window;table.bounds=CGRectMake(0,0,320,500);table.contentSize=CGSizeMake(320,120);
    table.testHeights=@[@60,@60];
    NSIndexPath *p=[NSIndexPath indexPathForRow:0 inSection:0];table.indexPathsForVisibleRows=@[p];
    TestCellView *view=[TestCellView new];view.viewModel=vc.nodes[0];view.head=[UIView new];view.content=[UIView new];view->m_chatRoomNameLabel=[UIView new];
    view.bounds=CGRectMake(0,0,320,60);view.content.bounds=CGRectMake(0,0,200,30);view.content.frame=CGRectMake(50,5,200,30);
    view.head.bounds=CGRectMake(0,0,30,30);view.head.frame=CGRectMake(0,5,30,30);view.subviews=@[view.head,view.content,view->m_chatRoomNameLabel];
    TestTableCell *cell=[TestTableCell new];cell.cellView=view;table.testCells=@{p:cell};
    CSMessageMergeActivate(vc);CSMessageMergePrepare(vc,table,p);
    CHECK(CSMessageMergeHidesName(view.viewModel));
    CHECK(CSMessageMergeMeasure(view.viewModel,CGSizeMake(320,60)).height==35); // First pass is already compact.
    CHECK(CSMessageMergeRowHeight(vc,table,p,60)==35);view.bounds=CGRectMake(0,0,320,35);
    CSMessageMergeBind(vc,table,p,cell);CSMessageMergeRender(view);
    CHECK(view.head.hidden); CHECK(view->m_chatRoomNameLabel.hidden);
    CHECK(CSMessageMergeMeasure(view.viewModel,CGSizeMake(320,60)).height==35);
    CHECK(CSMessageMergeRowHeight(vc,table,p,60)==35); // Repeated native cached height is projected once.
    CSMessageMergeFlush(vc);
    NSUInteger stableUpdates=table.updateCount, stableResets=view.viewModel.resetCount;
    CSMessageMergeWillMutate(vc);[vc.nodes addObject:model(3)];CSMessageMergeDidMutate(vc);CSMessageMergeFlush(vc);
    CHECK(table.updateCount==stableUpdates);CHECK(view.viewModel.resetCount==stableResets);
    CSMessageMergeWillMutate(vc);[vc.nodes removeLastObject];CSMessageMergeDidMutate(vc);CSMessageMergeFlush(vc);
    CHECK(table.updateCount==stableUpdates);
    CSMessageMergeRestore(view);CHECK(!view.head.hidden);CHECK(!view->m_chatRoomNameLabel.hidden);
    view.head.hidden=YES;CSMessageMergeRender(view);CSMessageMergeRestore(view);CHECK(view.head.hidden); // Preserve native hidden.
    CSMessageMergeReuse(view);CHECK(view.head.hidden);
    view.head.hidden=NO;
    CSMessageMergeWillMutate(vc);[vc.nodes removeLastObject];CSMessageMergeDidMutate(vc);
    CSMessageMergePrepare(vc,table,p);CSMessageMergeBind(vc,table,p,cell);CSMessageMergeRender(view);
    CHECK(!view.head.hidden);CHECK(!CSMessageMergeHidesName(view.viewModel));
    [vc.nodes addObject:model(3)];CSMessageMergeWillMutate(vc);CSMessageMergeDidMutate(vc);CSMessageMergePrepare(vc,table,p);
    CSMessageMergeBind(vc,table,p,cell);CSMessageMergeRender(view);CHECK(view.head.hidden);
    UIMenuController.sharedMenuController.menuVisible=YES;
    NSUInteger beforeMenuUpdates=table.updateCount;
    configure(NO);CSMessageMergeActivate(vc);CSMessageMergeFlush(vc);
    CHECK(table.updateCount==beforeMenuUpdates);
    UIMenuController.sharedMenuController.menuVisible=NO;
    [NSNotificationCenter.defaultCenter postNotificationName:UIMenuControllerDidHideMenuNotification object:nil];
    [NSRunLoop.currentRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.01]];
    CHECK(table.updateCount>beforeMenuUpdates);
    CSMessageMergeRender(view);CHECK(!view.head.hidden);CHECK(!CSMessageMergeHidesName(view.viewModel));
    CHECK(CSMessageMergeMeasure(view.viewModel,CGSizeMake(320,60)).height==60);
    configure(YES);CSMessageMergeActivate(vc);
    view.viewModel.rows=3;CSMessageMergePrepare(vc,table,p);CHECK(!CSMessageMergeHidesName(view.viewModel));
    CHECK(CSMessageMergeMeasure(view.viewModel,CGSizeMake(320,180)).height==180);
    view.viewModel.rows=1;
    ((TextMessageViewModel *)vc.nodes[1]).messageWrap.m_nsRealChatUsr=nil;
    CSMessageMergePrepare(vc,table,p);CHECK(!CSMessageMergeHidesName(view.viewModel));
    // Legacy positive spacing now maps to normal without changing model metrics.
    ((TextMessageViewModel *)vc.nodes[1]).messageWrap.m_nsRealChatUsr=@"alice";
    [NSUserDefaults.standardUserDefaults setVolatileDomain:@{CSMessageMergeEnabledKey:@YES,
        CSMessageMergeScopeKey:@3,CSMessageMergeSpacingKey:@6,CSMessageMergeAvatarKey:@1} forName:NSArgumentDomain];
    CSMessageMergeActivate(vc);CSMessageMergePrepare(vc,table,p);
    CHECK(CSMessageMergeMeasure(view.viewModel,CGSizeMake(320,60)).height==60);
    CHECK(CSMessageMergeRowHeight(vc,table,p,60)==60);CSMessageMergeFlush(vc);
    CHECK(CSMessageMergeRowHeight(vc,table,p,60)==60);
    stableUpdates=table.updateCount;
    CSMessageMergeRender(view);CSMessageMergeFlush(vc);
    CHECK(table.updateCount==stableUpdates);
    configure(NO);CSMessageMergeActivate(vc);CSMessageMergeFlush(vc);
    // Ordinary navigation works with merge off, and margin is viewport-relative.
    TestManager *mgr=[TestManager new];mgr.wrap=view.viewModel.messageWrap;
    CHECK(CSMessageNavigateToRevoke(vc,mgr,vc.session,mgr.wrap.m_n64MesSvrID));CHECK(vc.scrollCount==1);
    CHECK(vc.lastMargin==220); // (500 - 60) / 2, not a document offset.
    CSMessageNavigationCheck(vc);CHECK(CSMessageNavigationIsActive(vc));
    [CADisplayLink testAdvanceFrame];[CADisplayLink testAdvanceFrame];
    CHECK(!CSMessageNavigationIsActive(vc));
    CHECK(table.contentOffset.y==0);
    CHECK(!CSMessageNavigateToRevoke(vc,mgr,@"other",101));
    mgr.wrap.m_nsFromUsr=@"wrong";CHECK(CSMessageNavigateToRevoke(vc,mgr,vc.session,101));CHECK(vc.scrollCount==1);
    CSMessageMergeDeactivate(vc);CSMessageNavigationCancel(vc);
    // First entry and rebuilt pages use independently allocated models/Cells, with no pattern.
    for (NSString *session in @[@"alice",@"group@chatroom"]) for (NSUInteger reload=0;reload<3;reload++) {
        @autoreleasepool {
            TestController *page=[TestController new];page.session=session;
            UITableView *t=[UITableView new];page.table=t;page.view=t;t.window=window;
            t.bounds=CGRectMake(0,0,320,500);t.contentSize=CGSizeMake(320,120);t.testHeights=@[@60,@60];
            TextMessageViewModel *original=model(501),*tip=model(502);
            original.messageWrap.m_nsFromUsr=session;original.messageWrap.m_nsToUsr=@"account";
            // The private incoming tip addresses the current account, not the peer session.
            tip.messageWrap.m_nsFromUsr=reload==2 ? nil : session;
            tip.messageWrap.m_nsToUsr=reload==2 ? nil : @"account";
            NSString *link=reload ? @"revoke_jump_601" : @"revoke_jump_v2_601_501";
            NSDictionary *record=@{@"content":[NSString stringWithFormat:@"<a href=\"%@\">old message</a>",link]};
            NSData *data=[NSPropertyListSerialization dataWithPropertyList:record format:NSPropertyListBinaryFormat_v1_0 options:0 error:nil];
            tip.messageWrap.m_nsContent=[NSPropertyListSerialization propertyListWithData:data options:0 format:nil error:nil][@"content"];
            page.nodes=[NSMutableArray arrayWithArray:@[original,tip]];
            TestTableCell *originalCell=[TestTableCell new],*tipCell=[TestTableCell new];
            originalCell.cellView=[TestCellView new];originalCell.cellView.viewModel=original;
            tipCell.cellView=[TestCellView new];tipCell.cellView.viewModel=tip;
            NSIndexPath *target=[NSIndexPath indexPathForRow:0 inSection:0],*tipPath=[NSIndexPath indexPathForRow:0 inSection:1];
            t.indexPathsForVisibleRows=@[target,tipPath];t.testCells=@{target:originalCell,tipPath:tipCell};
            TestManager *manager=[TestManager new];manager.wrap=original.messageWrap;
            CSMessageNavigationBind(page,t,tipPath,tipCell);
            CHECK(!CSMessageHandleRevokeLink(tipCell.cellView,manager,@"https://example.com",nil));
            NSUInteger marks=page.highlightCount;
            CHECK(CSMessageHandleRevokeLink(tipCell.cellView,manager,link,nil));
            CHECK(page.scrollCount==1);CHECK(!page.lastScrollHighlight);
            t.hasUncommittedUpdates=YES;CSMessageNavigationFinishedLoading(page);
            CHECK(CSMessageNavigationIsActive(page));CHECK(page.highlightCount==marks);
            page.nativePresentationPending=YES;
            t.hasUncommittedUpdates=NO;CSMessageNavigationCheck(page);
            CHECK(CSMessageNavigationIsActive(page));CHECK(page.highlightCount==marks);
            CHECK(CADisplayLink.testPendingCount==1);
            [CADisplayLink testAdvanceFrame];CHECK(page.highlightCount==marks);
            // Native drawing catches up after the first display boundary without another tap.
            page.nativePresentationPending=NO;
            [CADisplayLink testAdvanceFrame];CHECK(page.highlightVisible);
            CHECK(CADisplayLink.testPendingCount==0);
            CHECK(!CSMessageNavigationIsActive(page));CHECK(page.highlightCount==marks+1);
            CHECK(page.highlightedMessage==original.messageWrap);CHECK(page.scrollCount==1);
            CSMessageNavigationCheck(page);CSMessageNavigationFinishedLoading(page);
            CHECK(page.highlightCount==marks+1);
            // A visible stale/reused cell must not be marked even when its path is correct.
            CHECK(CSMessageHandleRevokeLink(tipCell.cellView,manager,link,nil));
            t.testCells=@{target:tipCell,tipPath:tipCell};
            CSMessageNavigationCheck(page);CHECK(CSMessageNavigationIsActive(page));CHECK(page.highlightCount==marks+1);
            CSMessageNavigationCancel(page);page.scrollCount--;
            t.testCells=@{target:originalCell,tipPath:tipCell};
            // The logic callback can recover from persisted content when pattern was lost.
            CHECK(CSMessageHandleRevokeLink(tipCell.cellView,manager,nil,nil));
            CHECK(page.scrollCount==2);
            CSMessageNavigationCancel(page);CHECK(!CSMessageNavigationIsActive(page));
            // A cancelled previous click must not consume a fresh click.
            CHECK(CSMessageHandleRevokeLink(tipCell.cellView,manager,link,nil));CHECK(page.scrollCount==3);
            CSMessageNavigationCancel(page);
            tip.messageWrap.m_nsPattern=@"revoke_jump_999";
            CHECK(CSMessageHandleRevokeLink(tipCell.cellView,manager,nil,nil));CHECK(page.scrollCount==3);
            CHECK(!CSMessageHandleRevokeLink(tipCell.cellView,manager,@"https://example.com",nil));
            tip.messageWrap.m_nsPattern=nil;
            // Missing or incompatible dedicated API falls back to native scroll highlighting.
            for (NSUInteger variant=0;variant<2;variant++) {
                page.missingHighlightAPI=variant==0;page.incompatibleHighlightAPI=variant==1;
                CHECK(CSMessageHandleRevokeLink(tipCell.cellView,manager,link,nil));
                CHECK(!page.lastScrollHighlight);
                CSMessageNavigationCheck(page);
                [CADisplayLink testAdvanceFrame];[CADisplayLink testAdvanceFrame];
                CHECK(!CSMessageNavigationIsActive(page));
                CHECK(page.lastScrollHighlight);CHECK(page.highlightCount==marks+1);
            }
            page.missingHighlightAPI=NO;page.incompatibleHighlightAPI=NO;
            page.scrollCount=3;
            tip.messageWrap.m_nsFromUsr=@"unrelated";
            CHECK(CSMessageHandleRevokeLink(tipCell.cellView,manager,link,nil));CHECK(page.scrollCount==3);
            tip.messageWrap.m_nsFromUsr=session;
            tip.messageWrap.m_nsContent=@"<a href='revoke_jump_v2_601_999'>bad local id</a>";
            CHECK(CSMessageHandleRevokeLink(tipCell.cellView,manager,@"revoke_jump_v2_601_999",nil));CHECK(page.scrollCount==3);
        }
    }
    // Frame-boundary callbacks must not revive cancelled navigation or mark a reused cell.
    for (NSUInteger scenario=0;scenario<6;scenario++) {
        TestController *page=[TestController new];page.session=@"group@chatroom";
        UITableView *t=[UITableView new];page.table=t;page.view=t;t.window=window;
        t.bounds=CGRectMake(0,0,320,500);t.contentSize=CGSizeMake(320,120);t.testHeights=@[@60,@60];
        TextMessageViewModel *target=model(801);page.nodes=[NSMutableArray arrayWithArray:@[target,model(802)]];
        TestTableCell *cell=[TestTableCell new];cell.cellView=[TestCellView new];cell.cellView.viewModel=target;
        NSIndexPath *path=[NSIndexPath indexPathForRow:0 inSection:0];t.indexPathsForVisibleRows=@[path];t.testCells=@{path:cell};
        TestManager *manager=[TestManager new];manager.wrap=target.messageWrap;
        CHECK(CSMessageNavigateToRevoke(page,manager,page.session,901));CSMessageNavigationCheck(page);
        CHECK(CADisplayLink.testPendingCount==1);CHECK(page.highlightCount==0);
        if (scenario==0) CSMessageNavigationCancel(page);
        if (scenario==1) cell.cellView.viewModel=page.nodes[1];
        if (scenario==2) { CSMessageNavigationContentChanged(page);t.hasUncommittedUpdates=YES; }
        if (scenario==3) t.contentOffset=CGPointMake(0,15);
        if (scenario==4) t.isReloadingData=YES;
        if (scenario==5) {
            manager.wrap=((TextMessageViewModel *)page.nodes[1]).messageWrap;
            CHECK(CSMessageNavigateToRevoke(page,manager,page.session,902));
            CHECK(CADisplayLink.testPendingCount==0); // Replacing a request cancels its old frame callbacks.
            CSMessageNavigationCancel(page);
        }
        [CADisplayLink testAdvanceFrame];[CADisplayLink testAdvanceFrame];
        CHECK(page.highlightCount==0);
        if (scenario==0) { CHECK(!CSMessageNavigationIsActive(page));CHECK(CADisplayLink.testPendingCount==0); }
        if (scenario==1) { cell.cellView.viewModel=target;CSMessageNavigationCheck(page); }
        if (scenario==2) { t.hasUncommittedUpdates=NO;CSMessageNavigationCheck(page); }
        if (scenario==4) { t.isReloadingData=NO;CSMessageNavigationFinishedLoading(page); }
        if (scenario>0 && scenario<5) {
            [CADisplayLink testAdvanceFrame];[CADisplayLink testAdvanceFrame];
            CHECK(page.highlightCount==1);CHECK(page.highlightedMessage==target.messageWrap);
            CHECK(!CSMessageNavigationIsActive(page));CHECK(CADisplayLink.testPendingCount==0);
        }
        CSMessageNavigationCancel(page);
    }
    // Enabling/reentering/flushing merge must never invalidate native split content.
    for (NSString *session in @[@"alice",@"group@chatroom"]) {
        TestController *page=[TestController new];page.session=session;
        UITableView *t=[UITableView new];page.table=t;page.view=t;t.window=window;
        t.bounds=CGRectMake(0,0,320,500);t.contentSize=CGSizeMake(320,200);t.testHeights=@[@140,@60];
        TextMessageViewModel *longText=model(701);longText.rows=2;
        TextMessageSubViewModel *top=[TextMessageSubViewModel new],*bottom=[TextMessageSubViewModel new];
        top.parentModel=longText;bottom.parentModel=longText;top.content=@"first four lines";bottom.content=@"remaining lines";
        longText.subViewModels=@[top,bottom];page.nodes=[NSMutableArray arrayWithArray:@[longText,model(702)]];
        NSIndexPath *a=[NSIndexPath indexPathForRow:0 inSection:0],*b=[NSIndexPath indexPathForRow:1 inSection:0];
        TestTableCell *ca=[TestTableCell new],*cb=[TestTableCell new];
        ca.cellView=[TestCellView new];cb.cellView=[TestCellView new];
        ca.cellView.viewModel=(id)top;cb.cellView.viewModel=(id)bottom;
        ca.cellView.content=[UIView new];cb.cellView.content=[UIView new];
        t.indexPathsForVisibleRows=@[a,b];t.testCells=@{a:ca,b:cb};
        for (NSUInteger pass=0;pass<4;pass++) {
            configure(pass!=2);CSMessageMergeActivate(page);
            CSMessageMergePrepare(page,t,a);CSMessageMergePrepare(page,t,b);
            CSMessageMergeBind(page,t,a,ca);CSMessageMergeBind(page,t,b,cb);
            CSMessageMergeRender(ca.cellView);CSMessageMergeRender(cb.cellView);CSMessageMergeFlush(page);
            CHECK(top.resetCount==0 && bottom.resetCount==0 && longText.resetCount==0);
            CHECK(top.content.length && bottom.content.length);
            CHECK(!ca.cellView.content.hidden && !cb.cellView.content.hidden);
            CHECK(CSMessageMergeMeasure(top,CGSizeMake(320,100)).height==100);
            CHECK(CSMessageMergeMeasure(bottom,CGSizeMake(320,40)).height==40);
            CHECK(t.updateCount==0);
            CSMessageMergeDeactivate(page);
        }
    }
    // History scrolling: measuring/rendering/reusing new rows must never queue a stop-time collapse.
    for (NSString *session in @[@"alice",@"group@chatroom"]) for (NSUInteger mode=0;mode<2;mode++) {
        configure(YES);
        TestController *page=[TestController new];page.session=session;
        UITableView *t=[UITableView new];page.table=t;page.view=t;t.window=window;
        t.bounds=CGRectMake(0,0,320,500);t.contentSize=CGSizeMake(320,1200);t.testHeights=@[@60,@60];
        TextMessageViewModel *first=model(901),*second=model(902);
        first.messageWrap.m_nsFromUsr=session;second.messageWrap.m_nsFromUsr=session;
        page.nodes=[NSMutableArray arrayWithArray:@[first,second]];
        NSIndexPath *path=[NSIndexPath indexPathForRow:0 inSection:0];
        TestCellView *v=[TestCellView new];v.viewModel=first;v.head=[UIView new];v.content=[UIView new];
        v.bounds=CGRectMake(0,0,320,60);v.content.bounds=CGRectMake(0,0,200,30);v.content.frame=CGRectMake(50,5,200,30);
        v.head.bounds=CGRectMake(0,0,30,30);v.head.frame=CGRectMake(0,5,30,30);v.subviews=@[v.head,v.content];
        TestTableCell *c=[TestTableCell new];c.cellView=v;t.indexPathsForVisibleRows=@[path];t.testCells=@{path:c};
        t.contentOffset=CGPointMake(0,19);t.dragging=mode==0;t.decelerating=mode==1;
        CSMessageMergeActivate(page);CSMessageMergePrepare(page,t,path);
        CHECK(CSMessageMergeMeasure(first,CGSizeMake(320,60)).height==35);
        CHECK(CSMessageMergeRowHeight(page,t,path,60)==35);v.bounds=CGRectMake(0,0,320,35);CSMessageMergeBind(page,t,path,c);
        NSUInteger resets=first.resetCount;
        for (NSUInteger pass=0;pass<20;pass++) {
            CSMessageMergeRender(v);CSMessageMergeFlush(page);
            CHECK(CSMessageMergeMeasure(first,CGSizeMake(320,60)).height==35);
            CHECK(t.updateCount==0);CHECK(t.contentOffset.y==19);
            CSMessageMergeReuse(v);CSMessageMergeBind(page,t,path,c);
        }
        t.dragging=NO;t.decelerating=NO;CSMessageMergeFlush(page);
        CHECK(t.updateCount==0);CHECK(t.contentOffset.y==19);CHECK(first.resetCount==resets);
        CHECK(CSMessageMergeLayoutSettled(page));
        CSMessageMergeDeactivate(page);CSMessageMergeActivate(page);CSMessageMergeFlush(page);
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(),
            (__bridge CFStringRef)CSMessageMergeSettingsNotification,NULL,NULL,YES);
        [NSRunLoop.currentRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.02]];
        CHECK(t.updateCount==0);CHECK(first.resetCount==resets);
        CHECK(CSMessageMergeMeasure(first,CGSizeMake(320,60)).height==35);
        // Normal and retired relaxed mode are native; compact needs no warmup.
        for (NSNumber *mode in @[@0,@2,@1]) {
            [NSUserDefaults.standardUserDefaults setVolatileDomain:@{CSMessageMergeEnabledKey:@YES,
                CSMessageMergeScopeKey:@3,CSMessageMergeSpacingModeKey:mode,CSMessageMergeAvatarKey:@1} forName:NSArgumentDomain];
            CSMessageMergeActivate(page);CSMessageMergePrepare(page,t,path);
            CGFloat expected=mode.integerValue==0 ? 60 : (mode.integerValue==1 ? 35 : 60);
            CHECK(CSMessageMergeMeasure(first,CGSizeMake(320,60)).height==expected);
            CHECK(CSMessageMergeRowHeight(page,t,path,60)==expected);CSMessageMergeFlush(page);
            CHECK(t.updateCount==0);v.bounds=CGRectMake(0,0,320,expected);CSMessageMergeRender(v);
        }
        // Unexpected auxiliary content must restore space once, never enter a refresh loop.
        v.content.bounds=CGRectMake(0,0,200,50);CSMessageMergeRender(v);CSMessageMergeFlush(page);
        CHECK(t.updateCount==1);CHECK(CSMessageMergeMeasure(first,CGSizeMake(320,60)).height==60);
        CSMessageMergeRender(v);CSMessageMergeFlush(page);CHECK(t.updateCount==1);
        // Rebuilt measurements use current content metrics, not a previously displayed sample.
        [first resetLayoutCache];v.content.bounds=CGRectMake(0,0,200,30);
        CHECK(CSMessageMergeMeasure(first,CGSizeMake(320,60)).height==35);
        first.contentViewSize=CGSizeMake(200,58);
        CHECK(CSMessageMergeMeasure(first,CGSizeMake(320,60)).height==60);
        first.contentViewSize=CGSizeMake(200,30);
        CHECK(CSMessageMergeMeasure(first,CGSizeMake(400,60)).height==35);
        CHECK(CSMessageMergeRowHeight(page,t,path,60)==35);CSMessageMergeFlush(page);
        first.contentViewSize=CGSizeMake(200,NAN);
        CHECK(CSMessageMergeRowHeight(page,t,path,60)==60);
        first.contentViewSize=CGSizeMake(200,30);
        CHECK(CSMessageMergeRowHeight(page,t,path,60)==35);
        first.contentViewSize=CGSizeMake(500,30);
        CHECK(CSMessageMergeRowHeight(page,t,path,60)==60);
        first.contentViewSize=CGSizeZero;[first resetLayoutCache];
        CHECK(CSMessageMergeMeasure(first,CGSizeMake(320,60)).height==60);
        first.contentViewSize=CGSizeMake(200,30);first.canShowTranslateView=YES;[first resetLayoutCache];
        CHECK(CSMessageMergeMeasure(first,CGSizeMake(320,60)).height==60);
        first.canShowTranslateView=NO;[first resetLayoutCache];
        CHECK(CSMessageMergeMeasure(first,CGSizeMake(320,60)).height==35);
        NSUInteger updates=t.updateCount;
        // Last-avatar mode hides the tail's name even though that row has no next neighbor.
        [NSUserDefaults.standardUserDefaults setVolatileDomain:@{CSMessageMergeEnabledKey:@YES,
            CSMessageMergeScopeKey:@3,CSMessageMergeSpacingKey:@(-12),CSMessageMergeAvatarKey:@2} forName:NSArgumentDomain];
        NSIndexPath *tail=[NSIndexPath indexPathForRow:0 inSection:1];
        CSMessageMergeActivate(page);CSMessageMergePrepare(page,t,tail);
        CHECK(CSMessageMergeMeasure(second,CGSizeMake(320,60)).height==60);
        CHECK(CSMessageMergeRowHeight(page,t,tail,60)==60);
        v.viewModel=second;t.indexPathsForVisibleRows=@[tail];t.testCells=@{tail:c};
        CSMessageMergeBind(page,t,tail,c);CSMessageMergeRender(v);CHECK(v.head.hidden);
        configure(NO);CSMessageMergeActivate(page);CSMessageMergeFlush(page);
        CHECK(t.updateCount==updates+1);CSMessageMergeRender(v);CHECK(!v.head.hidden);
        CSMessageMergeDeactivate(page);
    }
    // Cold first-pass metrics across conversation/identity layouts and tall text.
    for (NSString *session in @[@"alice",@"group@chatroom"]) for (NSInteger avatar=1;avatar<=2;avatar++) {
        for (NSInteger mode=0;mode<=1;mode++) {
            [NSUserDefaults.standardUserDefaults setVolatileDomain:@{CSMessageMergeEnabledKey:@YES,
                CSMessageMergeScopeKey:@3,CSMessageMergeSpacingModeKey:@(mode),CSMessageMergeAvatarKey:@(avatar)} forName:NSArgumentDomain];
            TestController *page=[TestController new];page.session=session;
            UITableView *t=[UITableView new];page.table=t;page.view=t;t.window=window;t.bounds=CGRectMake(0,0,320,500);
            TextMessageViewModel *m=model(951),*next=model(952);m.messageWrap.m_nsFromUsr=session;next.messageWrap.m_nsFromUsr=session;
            page.nodes=[NSMutableArray arrayWithArray:@[m,next]];
            NSIndexPath *path=[NSIndexPath indexPathForRow:0 inSection:0];
            CSMessageMergeActivate(page);CSMessageMergePrepare(page,t,path);
            for (NSNumber *height in @[@30,@120,@240]) {
                m.contentViewSize=CGSizeMake(200,height.doubleValue);[m resetLayoutCache];
                CGFloat native=height.doubleValue+60;
                CGFloat expected=native+(mode==1 ? -25 : 0);
                CHECK(CSMessageMergeRowHeight(page,t,path,native)==expected);
                CHECK(CSMessageMergeRowHeight(page,t,path,native)==expected);
                CHECK(m.contentViewSize.height==height.doubleValue); // Never overwrite native content metrics.
            }
            m.messageWrap.m_uiMessageType=49;[m resetLayoutCache];
            CHECK(CSMessageMergeRowHeight(page,t,path,300)==300);
            CSMessageMergeDeactivate(page);
        }
    }
    // Space for avatar-bottom time is protected on identity rows; hidden-avatar rows compact.
    for (NSInteger avatar=1;avatar<=2;avatar++) {
        [NSUserDefaults.standardUserDefaults setVolatileDomain:@{CSMessageMergeEnabledKey:@YES,
            CSMessageMergeScopeKey:@3,CSMessageMergeSpacingModeKey:@1,CSMessageMergeAvatarKey:@(avatar),
            @"com.wechat.enhance.messageTime.enabled":@YES,@"com.wechat.enhance.messageTime.showBelowAvatar":@YES} forName:NSArgumentDomain];
        TestController *page=[TestController new];page.session=@"alice";
        UITableView *t=[UITableView new];page.table=t;page.view=t;t.window=window;t.bounds=CGRectMake(0,0,320,500);
        TextMessageViewModel *m=model(961),*next=model(962);m.messageWrap.m_nsFromUsr=@"alice";next.messageWrap.m_nsFromUsr=@"alice";
        page.nodes=[NSMutableArray arrayWithArray:@[m,next]];
        NSIndexPath *path=[NSIndexPath indexPathForRow:0 inSection:0];
        CSMessageMergeActivate(page);CSMessageMergePrepare(page,t,path);
        CHECK(CSMessageMergeRowHeight(page,t,path,60)==(avatar==1 ? 35 : 60));
        CSMessageMergeDeactivate(page);
    }
    // A one-row text section may still return a child model. It is not a split message.
    for (NSString *session in @[@"alice",@"group@chatroom"]) {
        configure(YES);
        TestController *page=[TestController new];page.session=session;
        UITableView *t=[UITableView new];page.table=t;page.view=t;t.window=window;
        t.bounds=CGRectMake(0,0,320,500);t.contentSize=CGSizeMake(320,1200);t.testHeights=@[@60,@60];
        TextMessageViewModel *parent=model(971),*next=model(972);
        parent.messageWrap.m_nsFromUsr=session;next.messageWrap.m_nsFromUsr=session;
        TextMessageSubViewModel *child=[TextMessageSubViewModel new];child.parentModel=parent;child.content=@"native text";
        parent.subViewModels=@[child];page.nodes=[NSMutableArray arrayWithArray:@[parent,next]];
        NSIndexPath *path=[NSIndexPath indexPathForRow:0 inSection:0];
        TestCellView *v=[TestCellView new];v.viewModel=(id)child;v.head=[UIView new];v.content=[UIView new];
        v.frame=CGRectMake(0,0,320,35);v.bounds=CGRectMake(0,0,320,35);
        v.head.bounds=CGRectMake(0,0,30,30);v.head.frame=CGRectMake(0,5,30,30);
        v.content.bounds=CGRectMake(0,0,200,30);v.content.frame=CGRectMake(50,5,200,30);v.subviews=@[v.head,v.content];
        TestTableCell *cell=[TestTableCell new];cell.cellView=v;t.testCells=@{path:cell};t.indexPathsForVisibleRows=@[path];
        CSMessageMergeActivate(page);CSMessageMergePrepare(page,t,path);
        CHECK(CSMessageMergeRowHeight(page,t,path,60)==35);
        CHECK(CSMessageMergeHidesName(parent)==[session hasSuffix:@"@chatroom"]);
        CSMessageMergeBind(page,t,path,cell);
        CGRect nativeContent=v.content.frame;
        t.dragging=YES;
        for (NSUInteger pass=0;pass<30;pass++) {
            CSMessageMergeRender(v);
            CHECK(v.frame.origin.y==-2); // Uses top padding instead of discarding the 25pt plan.
            CHECK(CGRectEqualToRect(v.content.frame,nativeContent));
            CHECK(v.frame.size.height==35);CHECK(v.bounds.origin.y==0);
            CHECK(CSMessageMergeRowHeight(page,t,path,60)==35);
            CSMessageMergeFlush(page);CHECK(t.updateCount==0);
            CSMessageMergeRestore(v);CHECK(v.frame.origin.y==0);
        }
        CSMessageMergeRender(v);t.dragging=NO;CSMessageMergeFlush(page);
        CHECK(t.updateCount==0);CHECK(v.frame.origin.y==-2);
        CHECK(parent.resetCount==0 && child.resetCount==0);CHECK([child.content isEqual:@"native text"]);
        // Restoring our override must not overwrite a newer native frame origin.
        CGRect changed=v.frame;changed.origin.y=3;v.frame=changed;
        CSMessageMergeRestore(v);CHECK(v.frame.origin.y==3);
        changed.origin.y=0;v.frame=changed;
        [NSUserDefaults.standardUserDefaults setVolatileDomain:@{CSMessageMergeEnabledKey:@YES,
            CSMessageMergeScopeKey:@3,CSMessageMergeSpacingModeKey:@0,CSMessageMergeAvatarKey:@1} forName:NSArgumentDomain];
        CSMessageMergeActivate(page);CSMessageMergeFlush(page);
        CHECK(CSMessageMergeRowHeight(page,t,path,60)==60);
        CHECK(parent.resetCount==0 && child.resetCount==0);CHECK(child.content.length>0);
        configure(YES);CSMessageMergeActivate(page);CSMessageMergePrepare(page,t,path);
        CHECK(CSMessageMergeRowHeight(page,t,path,60)==35);
        parent.rows=2;CSMessageMergePrepare(page,t,path);
        CHECK(!CSMessageMergeHidesName(parent));CHECK(CSMessageMergeRowHeight(page,t,path,60)==60);
        CHECK(parent.resetCount==0 && child.resetCount==0);CHECK(child.content.length>0);
        CSMessageMergeDeactivate(page);
    }
    // Device evidence (8.0.78.34): contentViewSize is {0,38}; zero width is unspecified,
    // not missing height. Replay both 55pt/67pt rows without any learned Cell sample.
    for (NSString *session in @[@"alice",@"group@chatroom"]) for (NSUInteger childRow=0;childRow<2;childRow++) {
        configure(YES);
        TestController *page=[TestController new];page.session=session;
        UITableView *t=[UITableView new];page.table=t;page.view=t;t.window=window;
        t.bounds=CGRectMake(0,0,320,500);t.contentSize=CGSizeMake(320,1000);t.testHeights=@[@55,@55];
        TextMessageViewModel *m=model(981),*next=model(982);
        m.messageWrap.m_nsFromUsr=session;next.messageWrap.m_nsFromUsr=session;
        m.contentViewSize=CGSizeMake(0,38);page.nodes=[NSMutableArray arrayWithArray:@[m,next]];
        TextMessageSubViewModel *child=[TextMessageSubViewModel new];child.parentModel=m;child.content=@"native text";
        if (childRow) m.subViewModels=@[child];
        id row=childRow ? (id)child : m;
        NSIndexPath *path=[NSIndexPath indexPathForRow:0 inSection:0];
        TestCellView *v=[TestCellView new];v.viewModel=row;v.content=[UIView new];
        v.frame=CGRectMake(0,0,320,42);v.bounds=CGRectMake(0,0,320,42);
        v.content.frame=CGRectMake(50,8,200,38);v.content.bounds=CGRectMake(0,0,200,38);v.subviews=@[v.content];
        TestTableCell *cell=[TestTableCell new];cell.cellView=v;t.testCells=@{path:cell};t.indexPathsForVisibleRows=@[path];
        CSMessageMergeActivate(page);CSMessageMergePrepare(page,t,path);CSMessageMergeBind(page,t,path,cell);
        for (NSNumber *native in @[@55,@67]) {
            t.dragging=YES;
            CHECK(CSMessageMergeRowHeight(page,t,path,native.doubleValue)==42);
            for (NSUInteger pass=0;pass<10;pass++) {
                CSMessageMergeRender(v);CHECK(v.frame.origin.y==-6);
                CHECK(CSMessageMergeRowHeight(page,t,path,native.doubleValue)==42);
            }
            t.dragging=NO;CSMessageMergeFlush(page);CHECK(t.updateCount==0);
            CSMessageMergeReuse(v);CHECK(v.frame.origin.y==0);CSMessageMergeBind(page,t,path,cell);
        }
        for (NSValue *invalid in @[[NSValue valueWithSize:NSMakeSize(-1,38)],
                                  [NSValue valueWithSize:NSMakeSize(NAN,38)],
                                  [NSValue valueWithSize:NSMakeSize(INFINITY,38)],
                                  [NSValue valueWithSize:NSMakeSize(0,0)],
                                  [NSValue valueWithSize:NSMakeSize(0,NAN)],
                                  [NSValue valueWithSize:NSMakeSize(0,80)]]) {
            NSSize size=invalid.sizeValue;m.contentViewSize=CGSizeMake(size.width,size.height);
            CHECK(CSMessageMergeRowHeight(page,t,path,55)==55);
        }
        m.contentViewSize=CGSizeMake(0,38);CHECK(CSMessageMergeRowHeight(page,t,path,55)==42);
        CHECK(!childRow || (child.resetCount==0 && child.content.length>0));
        CSMessageMergeDeactivate(page);
    }
    // Device 1.6-12 fallback: the named row occupies [0,55], not [8,58].
    // Equal native-height deltas do not imply equal top/bottom padding.
    for (NSNumber *contentHeight in @[@38,@153]) {
        [NSUserDefaults.standardUserDefaults setVolatileDomain:@{CSMessageMergeEnabledKey:@YES,
            CSMessageMergeScopeKey:@3,CSMessageMergeSpacingModeKey:@1,CSMessageMergeAvatarKey:@2} forName:NSArgumentDomain];
        TestController *page=[TestController new];page.session=@"group@chatroom";
        UITableView *t=[UITableView new];page.table=t;page.view=t;t.window=window;t.bounds=CGRectMake(0,0,320,500);
        TextMessageViewModel *first=model(985),*second=model(986),*third=model(987);
        first.contentViewSize=CGSizeMake(0,contentHeight.doubleValue);second.contentViewSize=CGSizeMake(0,38);
        page.nodes=[NSMutableArray arrayWithArray:@[first,second,third]];
        NSIndexPath *aPath=[NSIndexPath indexPathForRow:0 inSection:0],*bPath=[NSIndexPath indexPathForRow:0 inSection:1];
        CSMessageMergeActivate(page);CSMessageMergePrepare(page,t,aPath);CSMessageMergePrepare(page,t,bPath);
        CGFloat native=contentHeight.doubleValue+29;
        CGFloat planned=CSMessageMergeRowHeight(page,t,aPath,native);
        CHECK(CSMessageMergeRowHeight(page,t,bPath,55)==42);
        TestCellView *a=[TestCellView new];a.viewModel=first;
        a.frame=CGRectMake(0,0,320,planned);a.bounds=a.frame;
        a.head=[UIView new];a.head.frame=CGRectMake(0,3,38,38);a.head.bounds=CGRectMake(0,0,38,38);
        a->m_chatRoomNameLabel=[UIView new];a->m_chatRoomNameLabel.frame=CGRectMake(50,0,150,14);
        a->m_chatRoomNameLabel.bounds=CGRectMake(0,0,150,14);
        a.content=[UIView new];a.content.frame=CGRectMake(50,17,200,contentHeight.doubleValue);
        a.content.bounds=CGRectMake(0,0,200,contentHeight.doubleValue);
        a.subviews=@[a.head,a->m_chatRoomNameLabel,a.content];
        TestTableCell *cell=[TestTableCell new];cell.cellView=a;
        t.testCells=@{aPath:cell};t.indexPathsForVisibleRows=@[aPath];t.testHeights=@[@(planned),@42,@55];
        CSMessageMergeBind(page,t,aPath,cell);t.dragging=YES;
        for (NSUInteger pass=0;pass<20;pass++) {
            CSMessageMergeRender(a);
            CHECK(CSMessageMergeRowHeight(page,t,aPath,native)==planned); // Old code restores 67/182 here.
            CHECK(a.frame.origin.y==0); // The name starts at zero: never move it outside the row.
            CHECK(planned+2-CGRectGetMaxY(a.content.frame)==4); // Following bubble starts at row y=2.
            CHECK(!a.head.hidden && !a->m_chatRoomNameLabel.hidden);
        }
        t.dragging=NO;CSMessageMergeFlush(page);CHECK(t.updateCount==0);
        CHECK(planned==contentHeight.doubleValue+19);
        CSMessageMergeReuse(a);CHECK(a.frame.origin.y==0);CSMessageMergeDeactivate(page);
    }
    // Earlier synthetic layout remains supported alongside the actual [0,55] device bounds.
    // Check consecutive bubbles in table coordinates, including the first named row.
    for (NSString *session in @[@"alice",@"group@chatroom"]) for (NSInteger avatar=1;avatar<=2;avatar++) {
        for (NSInteger mode=0;mode<=1;mode++) for (NSUInteger childRow=0;childRow<2;childRow++) {
            [NSUserDefaults.standardUserDefaults setVolatileDomain:@{CSMessageMergeEnabledKey:@YES,
                CSMessageMergeScopeKey:@3,CSMessageMergeSpacingModeKey:@(mode),CSMessageMergeAvatarKey:@(avatar)} forName:NSArgumentDomain];
            TestController *page=[TestController new];page.session=session;
            UITableView *t=[UITableView new];page.table=t;page.view=t;t.window=window;t.bounds=CGRectMake(0,0,320,500);
            TextMessageViewModel *first=model(991),*second=model(992),*third=model(993);
            page.nodes=[NSMutableArray arrayWithArray:@[first,second,third]];
            for (TextMessageViewModel *m in page.nodes) {
                m.messageWrap.m_nsFromUsr=session;m.contentViewSize=CGSizeMake(0,38);
                if (childRow) {
                    TextMessageSubViewModel *child=[TextMessageSubViewModel new];child.parentModel=m;child.content=@"native text";
                    m.subViewModels=@[child];
                }
            }
            BOOL named=[session hasSuffix:@"@chatroom"] && avatar==2;
            CGFloat firstNative=named ? 67 : 55;
            CGFloat expectedFirst=mode==0 ? firstNative : (named ? 57 : (avatar==2 ? 48 : 42));
            CGFloat expectedSecond=mode==0 ? 55 : 42;
            NSMutableArray *views=[NSMutableArray array],*paths=[NSMutableArray array];
            NSMutableDictionary *cells=[NSMutableDictionary dictionary];
            CSMessageMergeActivate(page);
            for (NSUInteger i=0;i<2;i++) {
                NSIndexPath *path=[NSIndexPath indexPathForRow:0 inSection:i];[paths addObject:path];
                TestCellView *v=[TestCellView new];[views addObject:v];v.viewModel=[page.nodes[i] cellDataForRow:0];
                v.frame=CGRectMake(0,0,320,i==0 ? expectedFirst : expectedSecond);v.bounds=v.frame;
                v.head=[UIView new];v.head.frame=CGRectMake(0,8,44,44);v.head.bounds=CGRectMake(0,0,44,44);
                v->m_chatRoomNameLabel=[UIView new];v->m_chatRoomNameLabel.frame=CGRectMake(50,8,150,12);
                v->m_chatRoomNameLabel.bounds=CGRectMake(0,0,150,12);
                v->m_chatRoomNameLabel.hidden=!(named && i==0);
                v.content=[UIView new];v.content.frame=CGRectMake(50,named && i==0 ? 20 : 8,200,38);
                v.content.bounds=CGRectMake(0,0,200,38);v.subviews=@[v.head,v->m_chatRoomNameLabel,v.content];
                TestTableCell *cell=[TestTableCell new];cell.cellView=v;cells[path]=cell;
                CSMessageMergePrepare(page,t,path);CSMessageMergeBind(page,t,path,cell);
            }
            t.testCells=cells;t.indexPathsForVisibleRows=paths;t.testHeights=@[@(expectedFirst),@(expectedSecond),@55];
            t.dragging=YES;
            TestCellView *a=views[0],*b=views[1];
            CGRect originalContent=a.content.frame,originalName=a->m_chatRoomNameLabel.frame;
            for (NSUInteger pass=0;pass<10;pass++) {
                CHECK(CSMessageMergeRowHeight(page,t,paths[0],firstNative)==expectedFirst);
                CHECK(CSMessageMergeRowHeight(page,t,paths[1],55)==expectedSecond);
                CSMessageMergeRestore(a);CSMessageMergeRender(a);CSMessageMergeRestore(b);CSMessageMergeRender(b);
                CHECK(a.head.hidden==(avatar==1));CHECK(b.head.hidden);
                CHECK(CGRectEqualToRect(a.content.frame,originalContent));
                CHECK(CGRectEqualToRect(a->m_chatRoomNameLabel.frame,originalName));
                if (named) {
                    CHECK(!a->m_chatRoomNameLabel.hidden);
                    CGFloat gap=expectedFirst+b.frame.origin.y+b.content.frame.origin.y-
                        (a.frame.origin.y+CGRectGetMaxY(a.content.frame));
                    CHECK(fabs(gap-(mode==1 ? 4 : 17))<.01);
                    CHECK(a.frame.origin.y+CGRectGetMinY(originalName)>=2);
                    CHECK(a.frame.origin.y+CGRectGetMaxY(a.content.frame)<=expectedFirst-2);
                }
            }
            t.dragging=NO;CSMessageMergeFlush(page);CHECK(t.updateCount==0);
            if (named && mode==1) {
                // A taller real name/status layout must retain the existing native-height fallback.
                CSMessageMergeRestore(a);
                a->m_chatRoomNameLabel.bounds=CGRectMake(0,0,150,20);
                a->m_chatRoomNameLabel.frame=CGRectMake(50,8,150,20);
                a.content.frame=CGRectMake(50,28,200,38);
                CSMessageMergeRender(a);
                CHECK(CSMessageMergeRowHeight(page,t,paths[0],firstNative)==firstNative);
                CHECK(CSMessageMergeRowHeight(page,t,paths[0],firstNative)==firstNative);
                CHECK(CSMessageMergeRowHeight(page,t,paths[1],55)==expectedSecond);
            }
            CSMessageMergeReuse(a);CSMessageMergeReuse(b);
            CHECK(a.frame.origin.y==0 && b.frame.origin.y==0);
            CHECK(!a.head.hidden && !b.head.hidden);
            CSMessageMergeDeactivate(page);
        }
    }
    printf("PASS: %u native adapter/navigation lifecycle checks (UIKit double)\n",checks);
} return 0; }
