#import <UIKit/UIKit.h>
#import <QuartzCore/CADisplayLink.h>
#import "CSMessageMergeAdapter.h"
#import "CSMessageMergePolicy.h"
#import "CSMessageNavigation.h"
#import "CSMessageTimeLayout.h"
#import "CSRevokeReference.h"
#include <stdlib.h>
static unsigned checks;
extern NSUInteger CSMessageMergeDescriptorBuildCount;
extern NSString *CSMessageMergeTestProfileVersion;
static UIView *insetBackground;
static UIEdgeInsets visibleInsets;
static NSUInteger appearanceUpdates;
static NSMapTable *appearanceDecisions;
#ifndef CS_MERGE_BUBBLE_INTEGRATION
void CSBubbleStyleApply(UIView *view) {
    if (!appearanceDecisions) appearanceDecisions=[NSMapTable weakToStrongObjectsMapTable];
    CSMessageMergeDecision decision;
    id model=CSMessageNativeObject(view,@"viewModel");
    CSMessageMergeReadAppearance(model,&decision);
    [appearanceDecisions setObject:@((decision.joinsPrevious ? 1 : 0)|(decision.joinsNext ? 2 : 0)) forKey:view];
    appearanceUpdates++;
}
BOOL CSBubbleStyleVisibleInsets(UIView *background, UIEdgeInsets *insets) {
    if (!background || background!=insetBackground) return NO;
    *insets=visibleInsets;return YES;
}
BOOL CSBubbleStyleIsDark(UIView *view) { return NO; }
BOOL CSBubbleStyleModelInsets(id model, UIView *appearance, CGSize size, UIEdgeInsets *insets) {
    *insets=insetBackground ? visibleInsets : (UIEdgeInsets){0,0,0,0};return YES;
}
#endif
#define CHECK(x) do { checks++; if (!(x)) { fprintf(stderr,"FAIL line %d: %s\n",__LINE__,#x); exit(1); } } while (0)
@interface MMContext : NSObject
+ (NSString *)currentUserName;
+ (instancetype)currentContext;
- (id)getService:(Class)serviceClass;
@end
static double nativeMessageMarginTop=5, nativeMessageNameLength=12;
static BOOL nativeMessageThemeAvailable=YES;
static BOOL nativeMessageNamesVisible=YES;
@interface MMThemeManager : NSObject
- (id)getValueOfProperty:(NSString *)property inRuleSet:(NSString *)ruleSet;
@end
@implementation MMThemeManager
- (id)getValueOfProperty:(NSString *)property inRuleSet:(NSString *)ruleSet {
    CHECK([property isEqual:@"message_node_bkg_margin_top"]);
    CHECK([ruleSet isEqual:@"#message_node_view"]);
    return @[@(nativeMessageMarginTop)];
}
@end
@interface MMThemeUtil : NSObject
+ (double)parseFloatFromValues:(id)values;
@end
@implementation MMThemeUtil
+ (double)parseFloatFromValues:(id)values { return [values[0] doubleValue]; }
@end
@interface UIFont : NSObject
+ (double)dynamicLength:(double)value;
@end
@implementation UIFont
+ (double)dynamicLength:(double)value { CHECK(value==16);return nativeMessageNameLength; }
@end
@implementation MMContext
+ (NSString *)currentUserName { return @"account"; }
+ (instancetype)currentContext { if (!nativeMessageThemeAvailable) return nil;static MMContext *context; if (!context) context=[self new];return context; }
- (id)getService:(Class)serviceClass { CHECK(serviceClass==MMThemeManager.class);return [MMThemeManager new]; }
@end
@interface TestWrap : NSObject
@property(nonatomic) unsigned int m_uiMesLocalID;
@property(nonatomic) unsigned int m_uiCreateTime;
@property(nonatomic) unsigned int m_uiMessageType;
@property(nonatomic) unsigned int m_uiAppMsgInnerType;
@property(nonatomic) BOOL isReferMsgType;
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
@property(nonatomic,strong) id bgBubbleInfo;
@property(nonatomic) BOOL isSender;
@property(nonatomic) NSUInteger resetCount;
@property(nonatomic) long long rows;
@property(nonatomic) CGSize contentViewSize;
@property(nonatomic) BOOL canShowTranslateView;
@property(nonatomic) BOOL canShowReplyMessage;
@property(nonatomic) CGSize replyTextSize;
@property(nonatomic) UIEdgeInsets replyTextInset;
@property(nonatomic,strong) NSArray *subViewModels;
@property(nonatomic,strong) id chatRoomTextStateIconDescription;
- (long long)numberOfRowsInSection;
- (id)cellDataForRow:(unsigned long long)row;
- (void)resetLayoutCache;
- (BOOL)isHeadPart;
- (BOOL)isShowHeadImage;
- (BOOL)isShowChatRoomDisplayName;
@end
@implementation TextMessageViewModel
- (instancetype)init { if ((self=[super init])) _rows=1;return self; }
- (long long)numberOfRowsInSection { return self.rows; }
- (id)cellDataForRow:(unsigned long long)row { return self.subViewModels.count>row ? self.subViewModels[row] : self; }
- (void)resetLayoutCache { self.resetCount++; CSMessageMergeResetGeometry(self); }
- (BOOL)isHeadPart { return YES; }
- (BOOL)isShowHeadImage { return YES; }
- (BOOL)isShowChatRoomDisplayName { return nativeMessageNamesVisible && !CSMessageMergeHidesName(self); }
@end
@interface VoiceMessageViewModel : TextMessageViewModel
@property(nonatomic) BOOL canShowTranslateText;
@property(nonatomic) BOOL bShowingQuickTranTips;
@property(nonatomic) BOOL canShowTranslateLoadingView;
@property(nonatomic) BOOL canShowTextTranslateView;
@property(nonatomic) BOOL canShowTextTranslateText;
@property(nonatomic) BOOL dialectFeedbackShowing;
@end
@implementation VoiceMessageViewModel
// The cached contentViewSize is sufficient. These native methods would remeasure
// rich text and must never be queried by merge layout or scrolling.
- (CGSize)translatedTextSize { CHECK(NO);return CGSizeZero; }
- (CGSize)displayTextSize { CHECK(NO);return CGSizeZero; }
@end
@interface UnqualifiedVoiceMessageViewModel : VoiceMessageViewModel @end
@implementation UnqualifiedVoiceMessageViewModel @end
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
- (void)setSubviews:(NSArray *)children {
    [super setSubviews:children];
    for (UIView *child in children) child.superview=self;
}
- (id)getHeadImageView { return self.head; }
- (id)getContentView { return self.content; }
- (id)getBgImageView { return self.content; }
@end
@interface NativeHierarchyCellView : TestCellView
@property(nonatomic,strong) UIView *container;
@end
@implementation NativeHierarchyCellView
- (id)getContentView { return self.container; }
@end
@interface VoiceMessageCellView : NativeHierarchyCellView {
@public UIView *m_playingImageView;
@public UIView *m_secLabel;
@public UIView *m_unreadImageView;
}
@end
@implementation VoiceMessageCellView @end
@interface TestTableCell : NSObject
@property(nonatomic,strong) TestCellView *cellView;
@end
@implementation TestTableCell @end
#ifdef CS_MERGE_BUBBLE_INTEGRATION
@interface MergeTraits : UITraitCollection
#else
@interface MergeTraits : NSObject
#endif
@property(nonatomic) CGFloat displayScale;
@end
@implementation MergeTraits @end
@interface MergeTable : UITableView
@property(nonatomic,strong) MergeTraits *traitCollection;
@end
@implementation MergeTable
#ifdef CS_MERGE_BUBBLE_INTEGRATION
@dynamic traitCollection;
#endif
@end
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
static void VerifyDynamicNativeMessageOrigins(void) {
    // Native CSS/font inputs are deliberately different from the old 17/8 profile.
    // The first row must agree with actual layout before any cell has been created.
    UIWindow *window=[UIWindow new];
    for (NSUInteger names=0;names<2;names++) {
        nativeMessageNamesVisible=names!=0;nativeMessageMarginTop=8;nativeMessageNameLength=16;
        [NSUserDefaults.standardUserDefaults setVolatileDomain:@{CSMessageMergeEnabledKey:@YES,
            CSMessageMergeScopeKey:@3,CSMessageMergeSpacingModeKey:@1,CSMessageMergeAvatarKey:@2} forName:NSArgumentDomain];
        TestController *page=[TestController new];page.session=@"group@chatroom";page.nodes=[NSMutableArray array];
        UITableView *table=[UITableView new];page.table=table;page.view=table;table.window=window;
        table.bounds=CGRectMake(0,0,320,500);table.contentSize=CGSizeMake(320,1200);table.contentOffset=CGPointMake(0,19);
        for (NSUInteger i=0;i<4;i++) { TextMessageViewModel *m=model(25000+(unsigned)i);m.contentViewSize=CGSizeMake(180,38);[page.nodes addObject:m]; }
        CSMessageMergeActivate(page);
        NSMutableArray *paths=[NSMutableArray array],*views=[NSMutableArray array],*heights=[NSMutableArray array];
        NSMutableDictionary *cells=[NSMutableDictionary dictionary];
        for (NSUInteger phase=0;phase<2;phase++) {
            if (phase) { nativeMessageMarginTop=11;nativeMessageNameLength=18; }
            for (NSUInteger i=0;i<4;i++) {
                NSIndexPath *path=phase ? paths[i] : [NSIndexPath indexPathForRow:0 inSection:i];
                if (!phase) [paths addObject:path];
                CSMessageMergePrepare(page,table,path);
                CGFloat top=(i || !nativeMessageNamesVisible) ? nativeMessageMarginTop+3 : ceil(nativeMessageMarginTop+nativeMessageNameLength);
                CGFloat expected=i==0 ? top+39 : (i==3 ? 90-top+1 : 40);
                // Body size, native row height, model identity and width stay unchanged
                // in phase 2. Only native CSS/font geometry invalidates the cached pair.
                CGFloat height=CSMessageMergeRowHeight(page,table,path,90);
                CHECK(fabs(height-expected)<.01);
                if (phase) heights[i]=@(height);else [heights addObject:@(height)];
                NativeHierarchyCellView *v=phase ? views[i] : [NativeHierarchyCellView new];
                if (!phase) {
                    v.viewModel=page.nodes[i];v.head=[UIView new];v.head.bounds=CGRectMake(0,0,38,38);
                    v.container=[UIView new];v.content=[UIView new];v.container.subviews=@[v.content];v.content.superview=v.container;
                    v->m_chatRoomNameLabel=[UIView new];v->m_chatRoomNameLabel.frame=CGRectMake(50,0,160,14);
                    v->m_chatRoomNameLabel.bounds=CGRectMake(0,0,160,14);v->m_chatRoomNameLabel.hidden=i!=0 || !nativeMessageNamesVisible;
                    v.subviews=@[v.head,v.container,v->m_chatRoomNameLabel];
                    TestTableCell *cell=[TestTableCell new];cell.cellView=v;cells[path]=cell;[views addObject:v];
                } else CSMessageMergeRestore(v);
                v.frame=CGRectMake(0,0,320,height);v.bounds=v.frame;
                v.head.frame=CGRectMake(0,nativeMessageMarginTop,38,38);
                v.container.frame=CGRectMake(50,top,220,38);v.container.bounds=CGRectMake(0,0,220,38);
                v.content.frame=CGRectMake(0,0,180,38);v.content.bounds=v.content.frame;
                CSMessageMergeBind(page,table,path,cells[path]);
            }
            table.testCells=cells;table.testHeights=heights;table.indexPathsForVisibleRows=paths;
            for (NSUInteger pass=0;pass<12;pass++) {
                table.dragging=pass<4;table.decelerating=pass>=4 && pass<8;
                for (NSUInteger i=0;i<4;i++) {
                    NativeHierarchyCellView *v=views[i];CSMessageMergeRender(v);
                    CHECK(fabs(CSMessageMergeRowHeight(page,table,paths[i],90)-[heights[i] doubleValue])<.01);
                    if (i) {
                        NativeHierarchyCellView *previous=views[i-1];
                        CGFloat previousBottom=previous.frame.origin.y+CGRectGetMaxY([previous convertRect:previous.content.bounds fromView:previous.content]);
                        CGFloat currentTop=v.frame.origin.y+CGRectGetMinY([v convertRect:v.content.bounds fromView:v.content]);
                        CHECK(fabs([heights[i-1] doubleValue]+currentTop-previousBottom-2)<.01);
                    }
                }
                CSMessageMergeFlush(page);CHECK(table.updateCount==0);CHECK(table.contentOffset.y==19);
            }
            CHECK(CSMessageMergeLayoutSettled(page));
        }
        for (NativeHierarchyCellView *v in views) CSMessageMergeReuse(v);
        CSMessageMergeDeactivate(page);
    }
    nativeMessageNamesVisible=YES;
    // Missing/invalid native inputs and an unqualified nickname state icon keep
    // the native row from first display. Recovering metadata must not tighten it late.
    for (NSUInteger invalid=0;invalid<4;invalid++) {
        nativeMessageThemeAvailable=invalid!=0;
        nativeMessageMarginTop=invalid==1 ? NAN : 8;nativeMessageNameLength=invalid==2 ? NAN : 16;
        TestController *fallback=[TestController new];fallback.session=@"group@chatroom";
        TextMessageViewModel *first=model(25100+(unsigned)invalid*2),*next=model(25101+(unsigned)invalid*2);
        first.contentViewSize=CGSizeMake(180,38);if (invalid==3) first.chatRoomTextStateIconDescription=@"state-icon";
        fallback.nodes=[NSMutableArray arrayWithArray:@[first,next]];
        UITableView *t=[UITableView new];fallback.table=t;fallback.view=t;t.window=window;t.bounds=CGRectMake(0,0,320,500);
        NSIndexPath *path=[NSIndexPath indexPathForRow:0 inSection:0];CSMessageMergeActivate(fallback);CSMessageMergePrepare(fallback,t,path);
        CHECK(CSMessageMergeRowHeight(fallback,t,path,90)==90);
        TestCellView *v=[TestCellView new];v.viewModel=first;v.frame=CGRectMake(0,0,320,90);v.bounds=v.frame;
        v.content=[UIView new];v.content.frame=CGRectMake(50,24,180,38);v.content.bounds=CGRectMake(0,0,180,38);v.subviews=@[v.content];
        TestTableCell *cell=[TestTableCell new];cell.cellView=v;t.testCells=@{path:cell};t.testHeights=@[@90,@90];t.indexPathsForVisibleRows=@[path];
        CSMessageMergeBind(fallback,t,path,cell);
        nativeMessageThemeAvailable=YES;nativeMessageMarginTop=8;nativeMessageNameLength=16;
        for (NSUInteger pass=0;pass<3;pass++) {
            t.dragging=pass==0;t.decelerating=pass==1;CSMessageMergeRender(v);CSMessageMergeFlush(fallback);
            CHECK(CSMessageMergeRowHeight(fallback,t,path,90)==90);CHECK(t.updateCount==0);CHECK(v.frame.origin.y==0);
        }
        CSMessageMergeReuse(v);CSMessageMergeDeactivate(fallback);
    }
    nativeMessageThemeAvailable=YES;nativeMessageMarginTop=5;nativeMessageNameLength=12;
}
static void VerifyShortAndQuotedSeams(void) {
    UIWindow *window=[UIWindow new];
    for (NSUInteger scale=1;scale<=3;scale++) for (NSUInteger group=0;group<2;group++)
    for (NSUInteger outgoing=0;outgoing<2;outgoing++) for (NSUInteger avatar=1;avatar<=2;avatar++)
    for (NSInteger quote=-1;quote<4;quote++) {
        @autoreleasepool {
            [NSUserDefaults.standardUserDefaults setVolatileDomain:@{CSMessageMergeEnabledKey:@YES,
                CSMessageMergeScopeKey:@3,CSMessageMergeSpacingModeKey:@1,CSMessageMergeAvatarKey:@(avatar)} forName:NSArgumentDomain];
            TestController *page=[TestController new];page.session=group ? @"group@chatroom" : @"alice";
            page.nodes=[NSMutableArray array];MergeTable *t=[MergeTable new];page.table=t;page.view=t;t.window=window;
            t.bounds=CGRectMake(0,0,320,600);t.traitCollection=[MergeTraits new];t.traitCollection.displayScale=scale;
            NSMutableArray *views=[NSMutableArray array],*paths=[NSMutableArray array],*heights=[NSMutableArray array],*nativeHeights=[NSMutableArray array],*ends=[NSMutableArray array],*starts=[NSMutableArray array];
            NSMutableDictionary *cells=[NSMutableDictionary dictionary];
            for (NSUInteger i=0;i<4;i++) {
                TextMessageViewModel *m=model((unsigned)(16000+i));m.isSender=outgoing;
                m.messageWrap.m_nsFromUsr=page.session;m.messageWrap.m_uiMessageType=1;m.contentViewSize=CGSizeMake(0,38);
                if ((NSInteger)i==quote) {
                    m.messageWrap.m_uiMessageType=49;m.messageWrap.m_uiAppMsgInnerType=57;m.canShowReplyMessage=YES;
                    m.replyTextSize=CGSizeMake(160,quote%2 ? 60 : 20);m.replyTextInset=(UIEdgeInsets){5,6,6,6};
                }
                [page.nodes addObject:m];
            }
            CSMessageMergeActivate(page);
            for (NSUInteger i=0;i<4;i++) {
                TextMessageViewModel *m=page.nodes[i];BOOL identity=avatar==2 ? i==0 : i==3;
                BOOL named=group && !outgoing && identity;CGFloat y=named ? 17 : 8;
                CGFloat end=y+38+(m.canShowReplyMessage ? 4+5+m.replyTextSize.height+6 : 0),native=end+9;
                [ends addObject:@(end)];[starts addObject:@(named ? 0 : y)];[nativeHeights addObject:@(native)];
                NSIndexPath *path=[NSIndexPath indexPathForRow:0 inSection:i];[paths addObject:path];CSMessageMergePrepare(page,t,path);
                CGFloat height=CSMessageMergeRowHeight(page,t,path,native);[heights addObject:@(height)];
                TestCellView *v=[TestCellView new];v.viewModel=m;v.frame=CGRectMake(0,0,320,height);v.bounds=v.frame;
                v.head=[UIView new];v.head.frame=CGRectMake(0,5,38,38);v.head.bounds=CGRectMake(0,0,38,38);
                v.content=[UIView new];v.content.frame=CGRectMake(50,y,200,38);v.content.bounds=CGRectMake(0,0,200,38);
                v->m_chatRoomNameLabel=[UIView new];v->m_chatRoomNameLabel.frame=CGRectMake(50,0,150,14);
                v->m_chatRoomNameLabel.bounds=CGRectMake(0,0,150,14);v->m_chatRoomNameLabel.hidden=!named;
                NSMutableArray *children=[NSMutableArray arrayWithArray:@[v.head,v.content,v->m_chatRoomNameLabel]];
                if (m.canShowReplyMessage) {
                    UIView *reply=[UIView new];reply.frame=CGRectMake(50,y+38+4,172,5+m.replyTextSize.height+6);
                    reply.bounds=CGRectMake(0,0,172,reply.frame.size.height);[children addObject:reply];
                }
                v.subviews=children;[views addObject:v];TestTableCell *cell=[TestTableCell new];cell.cellView=v;cells[path]=cell;
                CSMessageMergeBind(page,t,path,cell);
            }
            t.testCells=cells;t.indexPathsForVisibleRows=paths;t.testHeights=heights;t.dragging=YES;
            for (NSUInteger pass=0;pass<4;pass++) {
                for (NSUInteger i=0;i<4;i++) {
                    TestCellView *v=views[i];CSMessageMergeRender(v);
                    if (i) {
                        TestCellView *previous=views[i-1];
                        CGFloat gap=[heights[i-1] doubleValue]+v.frame.origin.y+[starts[i] doubleValue]-previous.frame.origin.y-[ends[i-1] doubleValue];
                        // A last-row group nickname already starts at y=0; retain its native edge.
                        CGFloat points=[starts[i] doubleValue]==0 ? 1 : 2;
                        if (fabs(gap-points)>=.00001) fprintf(stderr,"seam scale=%lu group=%lu outgoing=%lu avatar=%lu quote=%ld pass=%lu row=%lu gap=%g height=%g prevY=%g y=%g\n",scale,group,outgoing,avatar,quote,pass,i,gap,[heights[i-1] doubleValue],previous.frame.origin.y,v.frame.origin.y);
                        CHECK(fabs(gap-points)<.00001);
                    }
                    CHECK(v.frame.origin.y+[starts[i] doubleValue]>=-.00001);
                    CHECK(v.frame.origin.y+[ends[i] doubleValue]<=[heights[i] doubleValue]+.00001);
                    CHECK(fabs(CSMessageMergeRowHeight(page,t,paths[i],[nativeHeights[i] doubleValue])-[heights[i] doubleValue])<.00001);
                    CHECK(v.viewModel.contentViewSize.height==38); // Reply is counted separately, never written into native body metrics.
                }
                t.dragging=pass==0;t.decelerating=pass==1;CSMessageMergeFlush(page);CHECK(t.updateCount==0);
            }
            if (quote>=0) {
                TextMessageViewModel *m=page.nodes[quote];CGFloat native=[nativeHeights[quote] doubleValue];
                CGSize reply=m.replyTextSize;UIEdgeInsets inset=m.replyTextInset;NSIndexPath *path=paths[quote];
                // Missing, malformed or unrelated app content must retain all native space.
                m.replyTextSize=CGSizeZero;CHECK(CSMessageMergeRowHeight(page,t,path,native)==native);
                m.replyTextSize=CGSizeMake(160,NAN);CHECK(CSMessageMergeRowHeight(page,t,path,native)==native);
                m.replyTextSize=CGSizeMake(600,20);CHECK(CSMessageMergeRowHeight(page,t,path,native)==native);
                m.replyTextSize=reply;m.replyTextInset=(UIEdgeInsets){-1,0,0,0};CHECK(CSMessageMergeRowHeight(page,t,path,native)==native);
                m.replyTextInset=inset;m.canShowReplyMessage=NO;CHECK(CSMessageMergeRowHeight(page,t,path,native)==native);
                m.canShowReplyMessage=YES;m.messageWrap.m_uiAppMsgInnerType=5;CHECK(CSMessageMergeRowHeight(page,t,path,native)==native);
                m.messageWrap.m_uiAppMsgInnerType=57;m.canShowTranslateView=YES;CHECK(CSMessageMergeRowHeight(page,t,path,native)==native);
                m.canShowTranslateView=NO;CHECK(fabs(CSMessageMergeRowHeight(page,t,path,native)-[heights[quote] doubleValue])<.00001);
                // A quote can grow independently of the body. The next native query
                // must reserve its full new footprint, even in the same model.
                m.replyTextSize=CGSizeMake(reply.width,reply.height+30);
                CHECK(fabs(CSMessageMergeRowHeight(page,t,path,native+30)-[heights[quote] doubleValue]-30)<.00001);
            }
            for (TestCellView *v in views) CSMessageMergeReuse(v);
            CSMessageMergeDeactivate(page);
        }
    }
}
static void VerifyNativeAvatarHierarchy(void) {
    // 8.0.78 adds the avatar directly to the cell, while the bubble belongs to
    // m_contentView. Compare both in cell coordinates, including a shifted container.
    UIWindow *window=[UIWindow new];
    insetBackground=[UIView new];visibleInsets=(UIEdgeInsets){1,0,3,0};
    for (NSUInteger outgoing=0;outgoing<2;outgoing++) for (NSUInteger avatar=1;avatar<=2;avatar++) {
        [NSUserDefaults.standardUserDefaults setVolatileDomain:@{CSMessageMergeEnabledKey:@YES,
            CSMessageMergeScopeKey:@3,CSMessageMergeSpacingModeKey:@1,CSMessageMergeAvatarKey:@(avatar)} forName:NSArgumentDomain];
        TestController *page=[TestController new];page.session=@"alice";page.nodes=[NSMutableArray array];
        UITableView *table=[UITableView new];page.table=table;page.view=table;table.window=window;
        table.bounds=CGRectMake(0,0,320,600);
        for (NSUInteger i=0;i<3;i++) {
            TextMessageViewModel *m=model(18000+(unsigned)i);m.isSender=outgoing;
            m.messageWrap.m_nsFromUsr=page.session;m.messageWrap.m_uiMessageType=1;m.contentViewSize=CGSizeMake(0,38);
            [page.nodes addObject:m];
        }
        CSMessageMergeActivate(page);
        NSMutableArray *paths=[NSMutableArray array],*views=[NSMutableArray array],*heights=[NSMutableArray array];
        NSMutableDictionary *cells=[NSMutableDictionary dictionary];
        for (NSUInteger i=0;i<3;i++) {
            NSIndexPath *path=[NSIndexPath indexPathForRow:0 inSection:i];[paths addObject:path];
            CSMessageMergePrepare(page,table,path);CGFloat height=CSMessageMergeRowHeight(page,table,path,55);[heights addObject:@(height)];
            NativeHierarchyCellView *v=[NativeHierarchyCellView new];v.viewModel=page.nodes[i];v.frame=CGRectMake(0,0,320,height);v.bounds=v.frame;
            v.head=[UIView new];v.head.frame=CGRectMake(outgoing ? 280 : 2,5,38,38);v.head.bounds=CGRectMake(0,0,38,38);
            v.container=[UIView new];v.container.frame=CGRectMake(50,8,220,38);v.container.bounds=CGRectMake(0,0,220,38);
            v.content=[UIView new];v.content.frame=CGRectMake(0,0,220,38);v.content.bounds=v.content.frame;
            v.container.subviews=@[v.content];v.content.superview=v.container;v.subviews=@[v.head,v.container];
            TestTableCell *cell=[TestTableCell new];cell.cellView=v;cells[path]=cell;[views addObject:v];
            CSMessageMergeBind(page,table,path,cell);
        }
        table.testCells=cells;table.testHeights=heights;table.indexPathsForVisibleRows=paths;
        for (NSUInteger pass=0;pass<8;pass++) {
            table.dragging=pass<2;table.decelerating=pass>=2 && pass<5;
            for (NSUInteger i=0;i<3;i++) {
                NativeHierarchyCellView *v=views[i];CSMessageMergeRender(v);
                CHECK(CSMessageMergeRowHeight(page,table,paths[i],55)==[heights[i] doubleValue]);
                if (!v.head.hidden) {
                    CGRect rect=[v convertRect:v.head.bounds fromView:v.head];
                    CHECK(v.frame.origin.y+CGRectGetMinY(rect)>=0);
                    CHECK(v.frame.origin.y+CGRectGetMaxY(rect)<=[heights[i] doubleValue]+.01);
                }
                if (i) {
                    NativeHierarchyCellView *previous=views[i-1];
                    CGFloat end=previous.frame.origin.y+CGRectGetMaxY([previous convertRect:previous.content.bounds fromView:previous.content])-3;
                    CGFloat start=v.frame.origin.y+CGRectGetMinY([v convertRect:v.content.bounds fromView:v.content])+1;
                    CHECK(fabs([heights[i-1] doubleValue]+start-end-2)<.01);
                }
            }
            CSMessageMergeFlush(page);CHECK(table.updateCount==0);
        }
        if (outgoing) {
            NSUInteger identity=avatar==2 ? 0 : 2;NativeHierarchyCellView *v=views[identity];
            // An unexpected native relayout moves the bubble into the avatar's
            // lane and lowers the avatar beyond the measured body footprint.
            // Overlapping lanes cannot use avatar relocation to hide the overflow.
            CSMessageMergeRestore(v);
            CGRect shifted=v.container.frame;shifted.origin.x=270;v.container.frame=shifted;
            CGRect lowered=v.head.frame;lowered.origin.y=8;v.head.frame=lowered;
            CSMessageMergeRender(v);
            CGFloat safeHeight=CSMessageMergeRowHeight(page,table,paths[identity],55);
            CHECK(safeHeight>[heights[identity] doubleValue]);CHECK(v.head.frame.origin.y==8);
            for (NSUInteger pass=0;pass<4;pass++) {
                CSMessageMergeRender(v);CHECK(CSMessageMergeRowHeight(page,table,paths[identity],55)==safeHeight);
                CHECK(v.head.frame.origin.y==8);
            }
        }
        for (NativeHierarchyCellView *v in views) CSMessageMergeReuse(v);
        CSMessageMergeDeactivate(page);
    }
    insetBackground=nil;visibleInsets=(UIEdgeInsets){0,0,0,0};
}
static void VerifyVoiceGlyphGeometry(void) {
    // Native outgoing voice glyphs use scale(-1,1), even while not playing.
    // They remain visible content: a mirror may be safe but an overflow is not.
    for (NSUInteger variant=0;variant<10;variant++) {
        [NSUserDefaults.standardUserDefaults setVolatileDomain:@{CSMessageMergeEnabledKey:@YES,
            CSMessageMergeScopeKey:@3,CSMessageMergeSpacingModeKey:@1,CSMessageMergeAvatarKey:@2} forName:NSArgumentDomain];
        TestController *page=[TestController new];page.session=@"alice";page.nodes=[NSMutableArray array];
        UIWindow *window=[UIWindow new];UITableView *table=[UITableView new];
        page.table=table;page.view=table;table.window=window;table.bounds=CGRectMake(0,0,320,600);
        for (NSUInteger i=0;i<3;i++) {
            TextMessageViewModel *m=i==1 && variant!=4 ? [VoiceMessageViewModel new] : [TextMessageViewModel new];
            m.messageWrap=model(18500+(unsigned)i).messageWrap;m.messageWrap.m_nsFromUsr=page.session;
            m.messageWrap.m_uiMessageType=i==1 && variant!=4 ? 34 : 1;
            m.isSender=YES;m.contentViewSize=CGSizeMake(180,37);[page.nodes addObject:m];
        }
        if (variant==7) {
            ((VoiceMessageViewModel *)page.nodes[1]).canShowTranslateText=YES;
            ((VoiceMessageViewModel *)page.nodes[1]).canShowTranslateLoadingView=YES;
        }
        CSMessageMergeActivate(page);
        NSMutableArray *paths=[NSMutableArray array],*heights=[NSMutableArray array];NSMutableDictionary *cells=[NSMutableDictionary dictionary];
        VoiceMessageCellView *voice=nil;
        for (NSUInteger i=0;i<3;i++) {
            NSIndexPath *path=[NSIndexPath indexPathForRow:0 inSection:i];[paths addObject:path];
            CSMessageMergePrepare(page,table,path);CGFloat height=CSMessageMergeRowHeight(page,table,path,54);[heights addObject:@(height)];
            VoiceMessageCellView *v=[VoiceMessageCellView new];v.viewModel=page.nodes[i];v.frame=CGRectMake(0,0,320,height);v.bounds=v.frame;
            v.container=[UIView new];v.container.frame=CGRectMake(40,8,240,37);v.container.bounds=CGRectMake(0,0,240,37);
            v.content=[UIView new];v.content.frame=CGRectMake(10,0,180,37);v.content.bounds=CGRectMake(0,0,180,37);
            v.head=[UIView new];v.head.frame=CGRectMake(282,5,38,38);v.head.bounds=CGRectMake(0,0,38,38);
            v.container.subviews=@[v.content];v.content.superview=v.container;v.subviews=@[v.head,v.container];
            if (i==1) {
                voice=v;UIView *glyph=[UIView new];glyph.frame=CGRectMake(158,6.5,24,24);glyph.bounds=CGRectMake(0,0,24,24);
                glyph.transform=CGAffineTransformMakeScale(-1,1);v->m_playingImageView=glyph;
                if (variant==1) glyph.transform=CGAffineTransformMakeScale(-1,1.2);
                if (variant==2) glyph.transform=CGAffineTransformMakeRotation(.2);
                if (variant==3) { v->m_secLabel=glyph;v->m_playingImageView=nil; }
                if (variant==5) glyph.frame=CGRectMake(158,-3,24,44); // Real overflow must expand.
                if (variant==5) glyph.bounds=CGRectMake(0,0,24,44);
                if (variant==6) glyph.hidden=YES;
                if (variant==8) glyph.transform=CGAffineTransformIdentity; // Incoming/native identity control.
                if (variant==9) glyph.transform=CGAffineTransformMakeTranslation(0,3);
                v.container.subviews=@[v.content,glyph];glyph.superview=v.container;
            }
            TestTableCell *cell=[TestTableCell new];cell.cellView=v;cells[path]=cell;CSMessageMergeBind(page,table,path,cell);
        }
        table.testCells=cells;table.testHeights=heights;table.indexPathsForVisibleRows=paths;
        BOOL compact=variant==0 || variant==6 || variant==8;
        for (NSUInteger pass=0;pass<9;pass++) {
            table.dragging=pass<3;table.decelerating=pass>=3 && pass<6;
            for (TestTableCell *cell in cells.allValues) CSMessageMergeRender(cell.cellView);
            CGFloat actual=CSMessageMergeRowHeight(page,table,paths[1],54);
            if (compact) CHECK(actual==[heights[1] doubleValue]);
            else CHECK(actual>[heights[1] doubleValue] || (variant==7 && actual==54));
            if (pass) CHECK(actual==[table.testHeights[1] doubleValue]);
            NSMutableArray *current=[table.testHeights mutableCopy];current[1]=@(actual);table.testHeights=current;
            NSUInteger updates=table.updateCount;CSMessageMergeFlush(page);CHECK(table.updateCount==updates);
        }
        CHECK(voice->m_playingImageView==nil || voice->m_playingImageView.hidden==(variant==6));
        for (TestTableCell *cell in cells.allValues) CSMessageMergeReuse(cell.cellView);
        CSMessageMergeDeactivate(page);
    }
}
static void VerifyVoiceAuxiliaryStates(void) {
    [NSUserDefaults.standardUserDefaults setVolatileDomain:@{CSMessageMergeEnabledKey:@YES,
        CSMessageMergeScopeKey:@3,CSMessageMergeSpacingModeKey:@1,CSMessageMergeAvatarKey:@2} forName:NSArgumentDomain];
    insetBackground=[UIView new];visibleInsets=(UIEdgeInsets){1,0,3,0};
    for (NSUInteger variant=0;variant<8;variant++) {
        TestController *page=[TestController new];page.session=@"alice";
        VoiceMessageViewModel *m=variant==7 ? [UnqualifiedVoiceMessageViewModel new] : [VoiceMessageViewModel new];
        m.messageWrap=model(18801).messageWrap;m.messageWrap.m_nsFromUsr=page.session;m.messageWrap.m_uiMessageType=34;
        m.contentViewSize=CGSizeMake(180,38);
        page.nodes=[NSMutableArray arrayWithArray:@[model(18800),m,model(18802)]];
        for (TextMessageViewModel *node in page.nodes) node.messageWrap.m_nsFromUsr=page.session;
        UIWindow *window=[UIWindow new];UITableView *table=[UITableView new];page.table=table;page.view=table;
        table.window=window;table.bounds=CGRectMake(0,0,320,600);
        NSIndexPath *path=[NSIndexPath indexPathForRow:0 inSection:1];
        if (variant==6) CSMessageMergeTestProfileVersion=@"8.0.79";
        CSMessageMergeActivate(page);CSMessageMergePrepare(page,table,path);
        CGFloat compact=CSMessageMergeRowHeight(page,table,path,55);
        CHECK(compact==(variant>=6 ? 55 : 36));
        m.bShowingQuickTranTips=YES;
        CHECK(CSMessageMergeRowHeight(page,table,path,55)==compact);
        m.canShowTranslateText=YES;m.contentViewSize=CGSizeMake(180,104);
        if (variant==1) m.canShowTranslateLoadingView=YES;
        if (variant==2) m.canShowTextTranslateView=YES;
        if (variant==3) m.canShowTextTranslateText=YES;
        if (variant==4) m.dialectFeedbackShowing=YES;
        if (variant==5) m.canShowTranslateView=YES;
        CHECK(CSMessageMergeRowHeight(page,table,path,121)==(variant==0 ? 105 : 121));
        if (variant==0) {
            // Expansion, longer transcript and collapse are real input changes.
            // Notifications alone and a side-button toggle are not.
            for (NSUInteger pass=0;pass<12;pass++) {
                m.bShowingQuickTranTips=pass%2;
                CSMessageMergeInvalidateLayout(page);CSMessageMergePrepare(page,table,path);
                CSMessageMergeResetGeometry(m);
                CHECK(CSMessageMergeRowHeight(page,table,path,121)==105);
            }
            m.contentViewSize=CGSizeMake(180,135);CHECK(CSMessageMergeRowHeight(page,table,path,152)==136);
            m.contentViewSize=CGSizeMake(180,104);CHECK(CSMessageMergeRowHeight(page,table,path,121)==105);
            m.canShowTranslateText=NO;m.contentViewSize=CGSizeMake(180,38);
            CHECK(CSMessageMergeRowHeight(page,table,path,55)==36);
            m.canShowTranslateText=YES;m.contentViewSize=CGSizeZero;
            CHECK(CSMessageMergeRowHeight(page,table,path,121)==121);
            m.contentViewSize=CGSizeMake(180,NAN);CHECK(CSMessageMergeRowHeight(page,table,path,121)==121);
        }
        CSMessageMergeDeactivate(page);CSMessageMergeTestProfileVersion=@"8.0.78";
    }
    insetBackground=nil;visibleInsets=(UIEdgeInsets){0,0,0,0};
}
int main(void) { @autoreleasepool {
    VerifyDynamicNativeMessageOrigins();
    VerifyVoiceAuxiliaryStates();
    VerifyVoiceGlyphGeometry();
    VerifyNativeAvatarHierarchy();
    VerifyShortAndQuotedSeams();
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
    view.bounds=CGRectMake(0,0,320,60);view.content.bounds=CGRectMake(0,0,200,30);view.content.frame=CGRectMake(50,8,200,30);
    view.head.bounds=CGRectMake(0,0,30,30);view.head.frame=CGRectMake(0,5,30,30);view.subviews=@[view.head,view.content,view->m_chatRoomNameLabel];
    TestTableCell *cell=[TestTableCell new];cell.cellView=view;table.testCells=@{p:cell};
    CSMessageMergeActivate(vc);CSMessageMergePrepare(vc,table,p);
    CHECK(CSMessageMergeHidesName(view.viewModel));
    CHECK(CSMessageMergeMeasure(view.viewModel,CGSizeMake(320,60)).height==39); // First pass is already compact.
    CHECK(CSMessageMergeRowHeight(vc,table,p,60)==39);view.bounds=CGRectMake(0,0,320,39);
    CSMessageMergeBind(vc,table,p,cell);CSMessageMergeRender(view);
    CHECK(view.head.hidden); CHECK(view->m_chatRoomNameLabel.hidden);
    CHECK(CSMessageMergeMeasure(view.viewModel,CGSizeMake(320,60)).height==39);
    CHECK(CSMessageMergeRowHeight(vc,table,p,60)==39); // Repeated native cached height is projected once.
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
        v.bounds=CGRectMake(0,0,320,60);v.content.bounds=CGRectMake(0,0,200,30);v.content.frame=CGRectMake(50,8,200,30);
        v.head.bounds=CGRectMake(0,0,30,30);v.head.frame=CGRectMake(0,5,30,30);v.subviews=@[v.head,v.content];
        TestTableCell *c=[TestTableCell new];c.cellView=v;t.indexPathsForVisibleRows=@[path];t.testCells=@{path:c};
        t.contentOffset=CGPointMake(0,19);t.dragging=mode==0;t.decelerating=mode==1;
        CSMessageMergeActivate(page);CSMessageMergePrepare(page,t,path);
        CHECK(CSMessageMergeMeasure(first,CGSizeMake(320,60)).height==39);
        CHECK(CSMessageMergeRowHeight(page,t,path,60)==39);v.bounds=CGRectMake(0,0,320,39);CSMessageMergeBind(page,t,path,c);
        NSUInteger resets=first.resetCount;
        for (NSUInteger pass=0;pass<20;pass++) {
            CSMessageMergeRender(v);CSMessageMergeFlush(page);
            CHECK(CSMessageMergeMeasure(first,CGSizeMake(320,60)).height==39);
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
        CHECK(CSMessageMergeMeasure(first,CGSizeMake(320,60)).height==39);
        // Normal and retired relaxed mode are native; compact needs no warmup.
        for (NSNumber *mode in @[@0,@2,@1]) {
            [NSUserDefaults.standardUserDefaults setVolatileDomain:@{CSMessageMergeEnabledKey:@YES,
                CSMessageMergeScopeKey:@3,CSMessageMergeSpacingModeKey:mode,CSMessageMergeAvatarKey:@1} forName:NSArgumentDomain];
            CSMessageMergeActivate(page);CSMessageMergePrepare(page,t,path);
            CGFloat expected=mode.integerValue==0 ? 60 : (mode.integerValue==1 ? 39 : 60);
            CHECK(CSMessageMergeMeasure(first,CGSizeMake(320,60)).height==expected);
            CHECK(CSMessageMergeRowHeight(page,t,path,60)==expected);CSMessageMergeFlush(page);
            CHECK(t.updateCount==0);v.bounds=CGRectMake(0,0,320,expected);CSMessageMergeRender(v);
        }
        // Unexpected auxiliary content must restore space once, never enter a refresh loop.
        v.content.bounds=CGRectMake(0,0,200,50);CSMessageMergeRender(v);CSMessageMergeFlush(page);
        CHECK(t.updateCount==1);CHECK(CSMessageMergeMeasure(first,CGSizeMake(320,60)).height==59);
        CSMessageMergeRender(v);CSMessageMergeFlush(page);CHECK(t.updateCount==1);
        // Cache eviction cannot undo a safety expansion. Only changed real metrics rebuild.
        [first resetLayoutCache];v.content.bounds=CGRectMake(0,0,200,30);
        CHECK(CSMessageMergeMeasure(first,CGSizeMake(320,60)).height==59);
        first.contentViewSize=CGSizeMake(200,58);
        CHECK(CSMessageMergeMeasure(first,CGSizeMake(320,60)).height==60);
        first.contentViewSize=CGSizeMake(200,30);
        CHECK(CSMessageMergeMeasure(first,CGSizeMake(400,60)).height==39);
        CHECK(CSMessageMergeRowHeight(page,t,path,60)==39);CSMessageMergeFlush(page);
        first.contentViewSize=CGSizeMake(200,NAN);
        CHECK(CSMessageMergeRowHeight(page,t,path,60)==60);
        first.contentViewSize=CGSizeMake(200,30);
        CHECK(CSMessageMergeRowHeight(page,t,path,60)==39);
        first.contentViewSize=CGSizeMake(500,30);
        CHECK(CSMessageMergeRowHeight(page,t,path,60)==60);
        first.contentViewSize=CGSizeZero;[first resetLayoutCache];
        CHECK(CSMessageMergeMeasure(first,CGSizeMake(320,60)).height==60);
        first.contentViewSize=CGSizeMake(200,30);first.canShowTranslateView=YES;[first resetLayoutCache];
        CHECK(CSMessageMergeMeasure(first,CGSizeMake(320,60)).height==60);
        first.canShowTranslateView=NO;[first resetLayoutCache];
        CHECK(CSMessageMergeMeasure(first,CGSizeMake(320,60)).height==39);
        NSUInteger updates=t.updateCount;
        // First-avatar mode hides the tail's name; its incoming seam is still compacted.
        [NSUserDefaults.standardUserDefaults setVolatileDomain:@{CSMessageMergeEnabledKey:@YES,
            CSMessageMergeScopeKey:@3,CSMessageMergeSpacingKey:@(-12),CSMessageMergeAvatarKey:@2} forName:NSArgumentDomain];
        NSIndexPath *tail=[NSIndexPath indexPathForRow:0 inSection:1];
        CSMessageMergeActivate(page);CSMessageMergePrepare(page,t,tail);
        CHECK(CSMessageMergeMeasure(second,CGSizeMake(320,60)).height==53);
        CHECK(CSMessageMergeRowHeight(page,t,tail,60)==53);
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
                BOOL named=[session hasSuffix:@"@chatroom"] && avatar==2;
                CGFloat occupiedBottom=(named ? 17 : 8)+height.doubleValue;
                CGFloat expected=mode==1 ? occupiedBottom+1 : native;
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
        CHECK(CSMessageMergeRowHeight(page,t,path,60)==(avatar==1 ? 39 : 60));
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
        v.frame=CGRectMake(0,0,320,39);v.bounds=CGRectMake(0,0,320,39);
        v.head.bounds=CGRectMake(0,0,30,30);v.head.frame=CGRectMake(0,5,30,30);
        v.content.bounds=CGRectMake(0,0,200,30);v.content.frame=CGRectMake(50,8,200,30);v.subviews=@[v.head,v.content];
        TestTableCell *cell=[TestTableCell new];cell.cellView=v;t.testCells=@{path:cell};t.indexPathsForVisibleRows=@[path];
        CSMessageMergeActivate(page);CSMessageMergePrepare(page,t,path);
        CHECK(CSMessageMergeRowHeight(page,t,path,60)==39);
        CHECK(CSMessageMergeHidesName(parent)==[session hasSuffix:@"@chatroom"]);
        CSMessageMergeBind(page,t,path,cell);
        CGRect nativeContent=v.content.frame;
        t.dragging=YES;
        for (NSUInteger pass=0;pass<30;pass++) {
            CSMessageMergeRender(v);
            CHECK(v.frame.origin.y==0); // Group outer top padding is preserved.
            CHECK(CGRectEqualToRect(v.content.frame,nativeContent));
            CHECK(v.frame.size.height==39);CHECK(v.bounds.origin.y==0);
            CHECK(CSMessageMergeRowHeight(page,t,path,60)==39);
            CSMessageMergeFlush(page);CHECK(t.updateCount==0);
            CSMessageMergeRestore(v);CHECK(v.frame.origin.y==0);
        }
        CSMessageMergeRender(v);t.dragging=NO;CSMessageMergeFlush(page);
        CHECK(t.updateCount==0);CHECK(v.frame.origin.y==0);
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
        CHECK(CSMessageMergeRowHeight(page,t,path,60)==39);
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
        v.frame=CGRectMake(0,0,320,47);v.bounds=CGRectMake(0,0,320,47);
        v.content.frame=CGRectMake(50,8,200,38);v.content.bounds=CGRectMake(0,0,200,38);v.subviews=@[v.content];
        TestTableCell *cell=[TestTableCell new];cell.cellView=v;t.testCells=@{path:cell};t.indexPathsForVisibleRows=@[path];
        CSMessageMergeActivate(page);CSMessageMergePrepare(page,t,path);CSMessageMergeBind(page,t,path,cell);
        for (NSNumber *native in @[@55,@67]) {
            t.dragging=YES;
            CHECK(CSMessageMergeRowHeight(page,t,path,native.doubleValue)==47);
            for (NSUInteger pass=0;pass<10;pass++) {
                CSMessageMergeRender(v);CHECK(v.frame.origin.y==0);
                CHECK(CSMessageMergeRowHeight(page,t,path,native.doubleValue)==47);
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
        m.contentViewSize=CGSizeMake(0,38);CHECK(CSMessageMergeRowHeight(page,t,path,55)==47);
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
        CHECK(CSMessageMergeRowHeight(page,t,bPath,55)==40);
        TestCellView *a=[TestCellView new];a.viewModel=first;
        a.frame=CGRectMake(0,0,320,planned);a.bounds=a.frame;
        a.head=[UIView new];a.head.frame=CGRectMake(0,5,38,38);a.head.bounds=CGRectMake(0,0,38,38);
        a->m_chatRoomNameLabel=[UIView new];a->m_chatRoomNameLabel.frame=CGRectMake(50,0,150,14);
        a->m_chatRoomNameLabel.bounds=CGRectMake(0,0,150,14);
        a.content=[UIView new];a.content.frame=CGRectMake(50,17,200,contentHeight.doubleValue);
        a.content.bounds=CGRectMake(0,0,200,contentHeight.doubleValue);
        a.subviews=@[a.head,a->m_chatRoomNameLabel,a.content];
        TestTableCell *cell=[TestTableCell new];cell.cellView=a;
        t.testCells=@{aPath:cell};t.indexPathsForVisibleRows=@[aPath];t.testHeights=@[@(planned),@40,@55];
        CSMessageMergeBind(page,t,aPath,cell);t.dragging=YES;
        for (NSUInteger pass=0;pass<20;pass++) {
            CSMessageMergeRender(a);
            CHECK(CSMessageMergeRowHeight(page,t,aPath,native)==planned); // Old code restores 67/182 here.
            CHECK(a.frame.origin.y==0); // The name starts at zero: never move it outside the row.
            CHECK(planned+1-CGRectGetMaxY(a.content.frame)==2); // Following bubble starts at row y=1.
            CHECK(!a.head.hidden && !a->m_chatRoomNameLabel.hidden);
        }
        t.dragging=NO;CSMessageMergeFlush(page);CHECK(t.updateCount==0);
        CHECK(planned==contentHeight.doubleValue+18);
        CSMessageMergeReuse(a);CHECK(a.frame.origin.y==0);CSMessageMergeDeactivate(page);
    }
    // All group seams, including the final row; native outer edges and hit frames stay intact.
    for (NSString *session in @[@"alice",@"group@chatroom"]) for (NSInteger avatar=1;avatar<=2;avatar++) {
        for (NSUInteger count=2;count<=4;count++) for (NSInteger mode=0;mode<=1;mode++) {
            [NSUserDefaults.standardUserDefaults setVolatileDomain:@{CSMessageMergeEnabledKey:@YES,
                CSMessageMergeScopeKey:@3,CSMessageMergeSpacingModeKey:@(mode),CSMessageMergeAvatarKey:@(avatar)} forName:NSArgumentDomain];
            TestController *page=[TestController new];page.session=session;page.nodes=[NSMutableArray array];
            UITableView *t=[UITableView new];page.table=t;page.view=t;t.window=window;t.bounds=CGRectMake(0,0,320,500);
            NSMutableArray *views=[NSMutableArray array],*paths=[NSMutableArray array],*heights=[NSMutableArray array];
            NSMutableDictionary *cells=[NSMutableDictionary dictionary];
            for (NSUInteger i=0;i<count;i++) {
                TextMessageViewModel *m=model((unsigned)(990+i));m.contentViewSize=CGSizeMake(0,60);[page.nodes addObject:m];
            }
            CSMessageMergeActivate(page);
            for (NSUInteger i=0;i<count;i++) {
                BOOL identity=avatar==2 ? i==0 : i==count-1;
                BOOL named=identity && [session hasSuffix:@"@chatroom"];
                CGFloat y=named ? 17 : 8,native=named ? 89 : 77;
                NSIndexPath *path=[NSIndexPath indexPathForRow:0 inSection:i];[paths addObject:path];
                CSMessageMergePrepare(page,t,path);
                CGFloat height=CSMessageMergeRowHeight(page,t,path,native);[heights addObject:@(height)];
                TestCellView *v=[TestCellView new];v.viewModel=page.nodes[i];[views addObject:v];
                v.frame=CGRectMake(0,0,320,height);v.bounds=v.frame;
                v.head=[UIView new];v.head.frame=CGRectMake(0,5,38,38);v.head.bounds=CGRectMake(0,0,38,38);
                v->m_chatRoomNameLabel=[UIView new];v->m_chatRoomNameLabel.frame=CGRectMake(50,0,150,14);
                v->m_chatRoomNameLabel.bounds=CGRectMake(0,0,150,14);v->m_chatRoomNameLabel.hidden=!named;
                v.content=[UIView new];v.content.frame=CGRectMake(50,y,200,60);v.content.bounds=CGRectMake(0,0,200,60);
                v.subviews=@[v.head,v->m_chatRoomNameLabel,v.content];
                TestTableCell *cell=[TestTableCell new];cell.cellView=v;cells[path]=cell;CSMessageMergeBind(page,t,path,cell);
            }
            t.testCells=cells;t.indexPathsForVisibleRows=paths;t.testHeights=heights;t.dragging=YES;
            for (NSUInteger pass=0;pass<20;pass++) {
                for (NSUInteger i=0;i<count;i++) {
                    TestCellView *v=views[i];CGRect content=v.content.frame;
                    CSMessageMergeRender(v);CHECK(CGRectEqualToRect(content,v.content.frame));
                    BOOL named=[session hasSuffix:@"@chatroom"] && (avatar==2 ? i==0 : i==count-1);
                    CGFloat measured=CSMessageMergeRowHeight(page,t,paths[i],named ? 89 : 77);
                    if (measured!=[heights[i] doubleValue]) fprintf(stderr,"group edge mismatch: session=%s avatar=%ld count=%lu mode=%ld row=%lu pass=%lu expected=%g actual=%g\n",session.UTF8String,avatar,count,mode,i,pass,[heights[i] doubleValue],measured);
                    CHECK(measured==[heights[i] doubleValue]);
                    if (i) {
                        TestCellView *prev=views[i-1];
                        CGFloat gap=[heights[i-1] doubleValue]+v.frame.origin.y+CGRectGetMinY(v.content.frame)-
                            (prev.frame.origin.y+CGRectGetMaxY(prev.content.frame));
                        // A visible nickname on the last row occupies the extra 17pt.
                        CHECK(fabs(gap-(mode==1 ? (named ? 18 : 2) : (named ? 26 : (avatar==2 && i==1 && [session hasSuffix:@"@chatroom"] ? 20 : 17))))<.01);
                    }
                }
            }
            TestCellView *first=views.firstObject,*last=views.lastObject;
            CHECK(first.frame.origin.y==0);
            CGFloat nativeLast=[session hasSuffix:@"@chatroom"] && avatar==1 ? 89 : 77;
            CHECK([heights.lastObject doubleValue]-(last.frame.origin.y+CGRectGetMaxY(last.content.frame))==nativeLast-CGRectGetMaxY(last.content.frame));
            t.dragging=NO;CSMessageMergeFlush(page);CHECK(t.updateCount==0);
            for (TestCellView *v in views) { CSMessageMergeReuse(v);CHECK(v.frame.origin.y==0); }
            CSMessageMergeDeactivate(page);
        }
    }
    // Unknown versions never inherit the 8.0.78 profile. The fallback remains stable
    // across later renders, cache resets and unchanged height queries.
    CSMessageMergeTestProfileVersion=@"8.0.99";
    configure(YES);
    TestController *unknown=[TestController new];unknown.session=@"alice";
    unknown.nodes=[NSMutableArray arrayWithArray:@[model(11001),model(11002),model(11003)]];
    UITableView *ut=[UITableView new];unknown.table=ut;unknown.view=ut;ut.window=window;ut.bounds=CGRectMake(0,0,320,500);
    NSIndexPath *up=[NSIndexPath indexPathForRow:0 inSection:1];
    TextMessageViewModel *um=unknown.nodes[1];um.contentViewSize=CGSizeMake(0,38);
    TestCellView *uv=[TestCellView new];uv.viewModel=um;uv.frame=CGRectMake(0,0,320,80);uv.bounds=uv.frame;
    uv.content=[UIView new];uv.content.frame=CGRectMake(50,14,200,38);uv.content.bounds=CGRectMake(0,0,200,38);uv.subviews=@[uv.content];
    TestTableCell *uc=[TestTableCell new];uc.cellView=uv;ut.testCells=@{up:uc};ut.indexPathsForVisibleRows=@[up];ut.testHeights=@[@80,@80,@80];
    CSMessageMergeActivate(unknown);CSMessageMergePrepare(unknown,ut,up);
    CHECK(CSMessageMergeRowHeight(unknown,ut,up,80)==80);
    CSMessageMergeBind(unknown,ut,up,uc);CSMessageMergeRender(uv);CSMessageMergeFlush(unknown);
    CHECK(uv.frame.origin.y==0 && ut.updateCount==0);
    CHECK(CSMessageMergeRowHeight(unknown,ut,up,80)==80);
    for (NSUInteger pass=0;pass<100;pass++) {
        CSMessageMergeRender(uv);CSMessageMergeFlush(unknown);
        CHECK(uv.frame.origin.y==0 && ut.updateCount==0);
        CHECK(CSMessageMergeRowHeight(unknown,ut,up,80)==80);
        CHECK(uv.frame.origin.y+CGRectGetMinY(uv.content.frame)==14);
    }
    // Auxiliary content invalidates a cached plan even if contentViewSize is unchanged.
    um.canShowTranslateView=YES;CSMessageMergeRender(uv);CSMessageMergeFlush(unknown);
    CHECK(ut.updateCount==0 && uv.frame.origin.y==0);
    CHECK(CSMessageMergeRowHeight(unknown,ut,up,80)==80);
    um.canShowTranslateView=NO;CHECK(CSMessageMergeRowHeight(unknown,ut,up,80)==80);
    CSMessageMergeRender(uv);CHECK(CSMessageMergeRowHeight(unknown,ut,up,80)==80);
    ut.bounds=CGRectMake(0,0,400,500);CHECK(CSMessageMergeRowHeight(unknown,ut,up,80)==80);
    CSMessageMergeRender(uv);CHECK(CSMessageMergeRowHeight(unknown,ut,up,80)==80);
    CSMessageMergeRender(uv);uv.transform=CGAffineTransformMakeScale(1.2,1.2);
    CSMessageMergeRender(uv);CSMessageMergeFlush(unknown);CHECK(CSMessageMergeRowHeight(unknown,ut,up,80)==80);
    NSUInteger transformUpdates=ut.updateCount;CSMessageMergeRender(uv);CSMessageMergeFlush(unknown);CHECK(ut.updateCount==transformUpdates);
    CSMessageMergeReuse(uv);CHECK(uv.frame.origin.y==0);CSMessageMergeDeactivate(unknown);
    CSMessageMergeTestProfileVersion=@"8.0.78";

    // A real avatar size supersedes the first-pass 38pt extent. Larger avatars
    // restore precisely the required space once; smaller avatars cause no refresh.
    for (NSNumber *avatarSize in @[@38,@60,@74]) {
        [NSUserDefaults.standardUserDefaults setVolatileDomain:@{CSMessageMergeEnabledKey:@YES,
            CSMessageMergeScopeKey:@3,CSMessageMergeSpacingModeKey:@1,CSMessageMergeAvatarKey:@2} forName:NSArgumentDomain];
        TestController *page=[TestController new];page.session=@"alice";
        page.nodes=[NSMutableArray arrayWithArray:@[model(12001),model(12002)]];
        UITableView *t=[UITableView new];page.table=t;page.view=t;t.window=window;t.bounds=CGRectMake(0,0,320,500);
        NSIndexPath *path=[NSIndexPath indexPathForRow:0 inSection:0];
        TestCellView *v=[TestCellView new];v.viewModel=page.nodes[0];v.frame=CGRectMake(0,0,320,100);v.bounds=v.frame;
        v.head=[UIView new];v.head.frame=CGRectMake(0,5,avatarSize.doubleValue,avatarSize.doubleValue);v.head.bounds=CGRectMake(0,0,avatarSize.doubleValue,avatarSize.doubleValue);
        v.content=[UIView new];v.content.frame=CGRectMake(50,8,200,30);v.content.bounds=CGRectMake(0,0,200,30);v.subviews=@[v.head,v.content];
        TestTableCell *cell=[TestTableCell new];cell.cellView=v;t.testCells=@{path:cell};t.indexPathsForVisibleRows=@[path];t.testHeights=@[@100,@100];
        CSMessageMergeActivate(page);CSMessageMergePrepare(page,t,path);
        CHECK(CSMessageMergeRowHeight(page,t,path,100)==39);
        CSMessageMergeBind(page,t,path,cell);CSMessageMergeRender(v);CSMessageMergeFlush(page);
        CHECK(t.updateCount==(avatarSize.doubleValue>38 ? 1 : 0));
        CGFloat expected=avatarSize.doubleValue<=38 ? 39 : avatarSize.doubleValue+6;
        CHECK(CSMessageMergeRowHeight(page,t,path,100)==expected);
        for (NSUInteger pass=0;pass<20;pass++) {
            CSMessageMergeRender(v);CSMessageMergeFlush(page);
            CHECK(CSMessageMergeRowHeight(page,t,path,100)==expected);
            CHECK(v.frame.origin.y==0 && !v.head.hidden);
            CHECK(t.updateCount==(avatarSize.doubleValue>38 ? 1 : 0));
        }
        CSMessageMergeReuse(v);CSMessageMergeDeactivate(page);
    }
    // Changing nickname geometry without changing body size must retain all content.
    [NSUserDefaults.standardUserDefaults setVolatileDomain:@{CSMessageMergeEnabledKey:@YES,
        CSMessageMergeScopeKey:@3,CSMessageMergeSpacingModeKey:@1,CSMessageMergeAvatarKey:@2} forName:NSArgumentDomain];
    TestController *named=[TestController new];named.session=@"group@chatroom";
    named.nodes=[NSMutableArray arrayWithArray:@[model(13001),model(13002)]];
    UITableView *nt=[UITableView new];named.table=nt;named.view=nt;nt.window=window;nt.bounds=CGRectMake(0,0,320,500);
    NSIndexPath *np=[NSIndexPath indexPathForRow:0 inSection:0];
    TestCellView *nv=[TestCellView new];nv.viewModel=named.nodes[0];nv.viewModel.contentViewSize=CGSizeMake(0,38);
    nv.frame=CGRectMake(0,0,320,80);nv.bounds=nv.frame;
    nv.content=[UIView new];nv.content.frame=CGRectMake(50,17,200,38);nv.content.bounds=CGRectMake(0,0,200,38);
    nv->m_chatRoomNameLabel=[UIView new];nv->m_chatRoomNameLabel.frame=CGRectMake(50,0,150,14);nv->m_chatRoomNameLabel.bounds=CGRectMake(0,0,150,14);
    nv.subviews=@[nv.content,nv->m_chatRoomNameLabel];
    TestTableCell *nc=[TestTableCell new];nc.cellView=nv;nt.testCells=@{np:nc};nt.indexPathsForVisibleRows=@[np];nt.testHeights=@[@80,@80];
    CSMessageMergeActivate(named);CSMessageMergePrepare(named,nt,np);CHECK(CSMessageMergeRowHeight(named,nt,np,80)==56);
    CSMessageMergeBind(named,nt,np,nc);CSMessageMergeRender(nv);CHECK(CSMessageMergeRowHeight(named,nt,np,80)==56);
    nv.content.frame=CGRectMake(50,28,200,38);nv->m_chatRoomNameLabel.bounds=CGRectMake(0,0,150,20);
    CSMessageMergeRender(nv);CSMessageMergeFlush(named);
    CHECK(nt.updateCount==1);CHECK(CSMessageMergeRowHeight(named,nt,np,80)==67);
    CSMessageMergeRender(nv);CSMessageMergeFlush(named);CHECK(nt.updateCount==1 && nv.frame.origin.y==0);
    CSMessageMergeDeactivate(named);

    // Cached transparent background margins affect visible seams; no content resizing.
    configure(YES);
    TestController *alphaPage=[TestController new];alphaPage.session=@"alice";
    alphaPage.nodes=[NSMutableArray arrayWithArray:@[model(14001),model(14002),model(14003)]];
    UITableView *at=[UITableView new];alphaPage.table=at;alphaPage.view=at;at.window=window;at.bounds=CGRectMake(0,0,320,500);
    NSIndexPath *ap=[NSIndexPath indexPathForRow:0 inSection:1];
    TestCellView *av=[TestCellView new];av.viewModel=alphaPage.nodes[1];av.viewModel.contentViewSize=CGSizeMake(0,44);
    av.frame=CGRectMake(0,0,320,61);av.bounds=av.frame;av.content=[UIView new];
    av.content.frame=CGRectMake(50,8,200,44);av.content.bounds=CGRectMake(0,0,200,44);av.subviews=@[av.content];
    insetBackground=av.content;visibleInsets=(UIEdgeInsets){3,0,3,0};
    TestTableCell *ac=[TestTableCell new];ac.cellView=av;at.testCells=@{ap:ac};at.indexPathsForVisibleRows=@[ap];at.testHeights=@[@61,@61,@61];
    CSMessageMergeActivate(alphaPage);CSMessageMergePrepare(alphaPage,at,ap);CHECK(CSMessageMergeRowHeight(alphaPage,at,ap,61)==40);
    CSMessageMergeBind(alphaPage,at,ap,ac);CSMessageMergeRender(av);CSMessageMergeFlush(alphaPage);CHECK(at.updateCount==0);
    CHECK(CSMessageMergeRowHeight(alphaPage,at,ap,61)==40);CSMessageMergeRender(av);
    CHECK(av.frame.origin.y+8+3==1);CHECK(av.frame.origin.y+8+44-3==39);
    CHECK(CGRectEqualToRect(av.content.frame,CGRectMake(50,8,200,44)));
    // Losing only the previous neighbor changes middle -> first, even if hidden
    // identity and joinsNext are unchanged. Discard the previous geometry plan.
    ((TextMessageViewModel *)alphaPage.nodes[0]).isSender=YES;
    CSMessageMergePrepare(alphaPage,at,ap);CHECK(CSMessageMergeRowHeight(alphaPage,at,ap,61)==50);
    CSMessageMergeReuse(av);CHECK(av.frame.origin.y==0);CSMessageMergeDeactivate(alphaPage);insetBackground=nil;
    // Appearance follows logical neighbors even when native row requests consumed
    // needsLayout already. Redrawing the bubbles must not cause extra row updates.
    [NSUserDefaults.standardUserDefaults setVolatileDomain:@{CSMessageMergeEnabledKey:@YES,
        CSMessageMergeScopeKey:@3,CSMessageMergeSpacingModeKey:@0,CSMessageMergeAvatarKey:@2} forName:NSArgumentDomain];
    TestController *appearance=[TestController new];appearance.session=@"alice";
    appearance.nodes=[NSMutableArray arrayWithArray:@[model(15001),model(15002),model(15003)]];
    UITableView *apt=[UITableView new];appearance.table=apt;appearance.view=apt;apt.window=window;apt.bounds=CGRectMake(0,0,320,500);
    NSMutableArray *appearanceCells=[NSMutableArray array];
    for (NSUInteger i=0;i<4;i++) { TestTableCell *c=[TestTableCell new];c.cellView=[TestCellView new];[appearanceCells addObject:c]; }
    CSMessageMergeActivate(appearance);
    for (NSUInteger change=0;change<4;change++) {
        CSMessageMergeWillMutate(appearance);
        if (change==1) [appearance.nodes addObject:model(15004)];
        if (change==2) { [appearance.nodes removeObjectAtIndex:0];[appearanceCells removeObjectAtIndex:0]; }
        if (change==3) { TextMessageViewModel *replacement=model(15005);replacement.isSender=YES;appearance.nodes[1]=replacement; }
        for (TextMessageViewModel *m in appearance.nodes) m.messageWrap.m_nsFromUsr=@"alice";
        NSMutableArray *paths=[NSMutableArray array],*heights=[NSMutableArray array];NSMutableDictionary *cells=[NSMutableDictionary dictionary];
        for (NSUInteger i=0;i<appearance.nodes.count;i++) {
            TextMessageViewModel *m=appearance.nodes[i];m.messageWrap.m_nsFromUsr=@"alice";
            NSIndexPath *path=[NSIndexPath indexPathForRow:0 inSection:i];[paths addObject:path];[heights addObject:@55];
            TestTableCell *c=appearanceCells[i];c.cellView.viewModel=m;cells[path]=c;
            CSMessageMergePrepare(appearance,apt,path);CHECK(CSMessageMergeRowHeight(appearance,apt,path,55)==55);
            if (!change) CSMessageMergeBind(appearance,apt,path,c);
        }
        apt.indexPathsForVisibleRows=paths;apt.testCells=cells;apt.testHeights=heights;
        NSUInteger updates=apt.updateCount;CSMessageMergeDidMutate(appearance);CSMessageMergeFlush(appearance);
        CHECK(apt.updateCount==updates);
        for (NSUInteger i=0;i<appearance.nodes.count;i++) {
            TestTableCell *c=appearanceCells[i];NSUInteger expected=change==3 ? 0 : ((i ? 1 : 0)|(i+1<appearance.nodes.count ? 2 : 0));
            CHECK([[appearanceDecisions objectForKey:c.cellView] unsignedIntegerValue]==expected);
            CSMessageMergeDecision decision;NSUInteger resets=((TextMessageViewModel *)appearance.nodes[i]).resetCount;
            NSUInteger renders=appearanceUpdates;
            for (NSUInteger j=0;j<20;j++) CHECK(CSMessageMergeReadAppearance(appearance.nodes[i],&decision));
            CHECK(((TextMessageViewModel *)appearance.nodes[i]).resetCount==resets && appearanceUpdates==renders);
        }
    }
    configure(NO);CSMessageMergeActivate(appearance);CSMessageMergeFlush(appearance);
    for (TestTableCell *c in appearanceCells) CHECK([[appearanceDecisions objectForKey:c.cellView] unsignedIntegerValue]==0);
    CSMessageMergeDeactivate(appearance);
    // Repeated preparation reuses descriptors, but in-place edits and equal-count replacement stay live.
    configure(YES);
    TestController *cachedPage=[TestController new];cachedPage.session=@"group@chatroom";
    cachedPage.nodes=[NSMutableArray arrayWithArray:@[model(9001),model(9002)]];
    UITableView *cachedTable=[UITableView new];cachedPage.table=cachedTable;cachedPage.view=cachedTable;
    cachedTable.window=window;cachedTable.bounds=CGRectMake(0,0,320,500);cachedTable.testHeights=@[@60,@60];
    cachedTable.indexPathsForVisibleRows=@[p];
    CSMessageMergeActivate(cachedPage);CSMessageMergePrepare(cachedPage,cachedTable,p);
    NSUInteger builds=CSMessageMergeDescriptorBuildCount;
    for (NSUInteger i=0;i<1000;i++) CSMessageMergePrepare(cachedPage,cachedTable,p);
    CHECK(CSMessageMergeDescriptorBuildCount==builds);
    CHECK(CSMessageMergeHidesName(cachedPage.nodes[0]));
    ((TextMessageViewModel *)cachedPage.nodes[1]).messageWrap.m_nsRealChatUsr=@"bob";
    CSMessageMergePrepare(cachedPage,cachedTable,p);
    CHECK(!CSMessageMergeHidesName(cachedPage.nodes[0]));CHECK(CSMessageMergeDescriptorBuildCount==builds+1);
    cachedPage.nodes[1]=model(9003);CSMessageMergePrepare(cachedPage,cachedTable,p);
    CHECK(CSMessageMergeHidesName(cachedPage.nodes[0]));
    CSMessageMergeRowHeight(cachedPage,cachedTable,p,60);
    NSUInteger updates=cachedTable.updateCount;
    UIApplication.sharedApplication.applicationState=UIApplicationStateBackground;
    [NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidEnterBackgroundNotification object:nil];
    CSMessageMergeWillMutate(cachedPage);[cachedPage.nodes removeLastObject];CSMessageMergeDidMutate(cachedPage);
    CSMessageMergeFlush(cachedPage);
    CHECK(cachedTable.updateCount==updates);CHECK(!CSMessageMergeLayoutSettled(cachedPage));
    UIApplication.sharedApplication.applicationState=UIApplicationStateActive;
    [NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidBecomeActiveNotification object:nil];
    [NSRunLoop.currentRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.01]];
    CHECK(cachedTable.updateCount==updates+1);CHECK(CSMessageMergeLayoutSettled(cachedPage));
    CHECK(!CSMessageMergeHidesName(cachedPage.nodes[0]));
    UIScene *scene=[UIScene new];window.windowScene=scene;
    [NSNotificationCenter.defaultCenter postNotificationName:UISceneWillDeactivateNotification object:scene];
    CSMessageMergeWillMutate(cachedPage);[cachedPage.nodes addObject:model(9004)];CSMessageMergeDidMutate(cachedPage);
    CSMessageMergeFlush(cachedPage);CHECK(cachedTable.updateCount==updates+1);
    [NSNotificationCenter.defaultCenter postNotificationName:UISceneDidActivateNotification object:scene];
    [NSRunLoop.currentRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.01]];
    CHECK(cachedTable.updateCount==updates+2);CHECK(CSMessageMergeHidesName(cachedPage.nodes[0]));
    CSMessageMergeDeactivate(cachedPage);window.windowScene=nil;
    printf("PASS: %u native adapter/navigation lifecycle checks (UIKit double)\n",checks);
} return 0; }
