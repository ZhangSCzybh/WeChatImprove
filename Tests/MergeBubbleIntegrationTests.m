// Both production adapters run together. Only UIKit and native WeChat are doubles.
#define main CSIsolatedMergeRegressionMain
#include "MessageMergeAdapterTests.m"
#undef main
#import "CSBubbleStylePolicy.h"
#import "CSBubbleStyleAdapter.h"
extern NSUInteger CSBubbleNativePaddingScanCount;

@interface BubbleInfo : NSObject
@property(nonatomic) NSUInteger position, requests;
@property(nonatomic,strong) UIImage *normal, *pressed, *darkNormal, *darkPressed;
- (id)getBubbleImage:(BOOL)pressed isDarkMode:(BOOL)dark useCache:(BOOL)cache;
@end
@implementation BubbleInfo
- (id)getBubbleImage:(BOOL)pressed isDarkMode:(BOOL)dark useCache:(BOOL)cache {
    CHECK(cache);self.requests++;
    return dark ? (pressed ? self.darkPressed : self.darkNormal) : (pressed ? self.pressed : self.normal);
}
@end
@interface ForbiddenYYImage : YYImage @end
@implementation ForbiddenYYImage
- (UIImage *)originImage { [NSException raise:@"UnsafeDecode" format:@"originImage called"];return nil; }
- (CGImageRef)CGImage { [NSException raise:@"UnsafeDecode" format:@"CGImage called on YYImage"];return nil; }
@end
@interface ImageMessageViewModel : TextMessageViewModel @end
@implementation ImageMessageViewModel @end
@interface VideoMessageViewModel : TextMessageViewModel @end
@implementation VideoMessageViewModel @end
@interface EmoticonMessageViewModel : TextMessageViewModel @end
@implementation EmoticonMessageViewModel @end
static UIImage *Template(CGFloat scale, CGFloat top, CGFloat bottom) {
    CGImageRef cg=CSBubbleCreateTemplate((CSBubbleRGBA){.5,.5,.5,1},8,0,scale,(CSBubbleInsets){top,2,bottom,4},NO);
    UIImage *image=[UIImage imageWithCGImage:cg scale:scale orientation:UIImageOrientationUp];CGImageRelease(cg);
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(top+10,12,bottom+10,14) resizingMode:UIImageResizingModeStretch];
}
static UIImage *NativeCapsTemplate(CGFloat scale, CGFloat top, CGFloat bottom) {
    // 8.0.78 BubbleManager sets {30,25,8,20}; keep a real stretchable center
    // in the SOURCE image. The 38pt destination may collapse that center to zero.
    // Pixels are synthetic; cap dimensions are from the audited native method.
    size_t pixels=(size_t)(49*scale);
    CGColorSpaceRef space=CGColorSpaceCreateDeviceRGB();
    CGContextRef context=CGBitmapContextCreate(NULL,pixels,pixels,8,pixels*4,space,kCGImageAlphaPremultipliedLast|kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(space);CHECK(context!=NULL);
    CGContextScaleCTM(context,scale,scale);CGContextTranslateCTM(context,0,49);CGContextScaleCTM(context,1,-1);
    CGPathRef path=CGPathCreateWithRoundedRect(CGRectMake(2,top,43,49-top-bottom),8,8,NULL);
    CGContextSetRGBFillColor(context,.5,.5,.5,1);CGContextAddPath(context,path);CGContextFillPath(context);
    CGImageRef cg=CGBitmapContextCreateImage(context);CGPathRelease(path);CGContextRelease(context);
    UIImage *image=[UIImage imageWithCGImage:cg scale:scale orientation:UIImageOrientationUp];CGImageRelease(cg);
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(30,25,8,20) resizingMode:UIImageResizingModeStretch];
}
static void DrainIntegration(void) { [NSRunLoop.currentRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.001]]; }
static void ConfigureIntegration(BOOL style, NSInteger avatar) {
    [NSUserDefaults.standardUserDefaults setVolatileDomain:@{CSMessageMergeEnabledKey:@YES,
        CSMessageMergeScopeKey:@3,CSMessageMergeSpacingModeKey:@1,CSMessageMergeAvatarKey:@(avatar),
        @"com.wechat.enhance.bubble_style.enabled":@(style),@"com.wechat.enhance.bubble_style.kind":@1} forName:NSArgumentDomain];
    CSBubbleStyleStart();[NSNotificationCenter.defaultCenter postNotificationName:NSUserDefaultsDidChangeNotification object:nil];DrainIntegration();
}
static void Display(YYAsyncImageView *bg) {
    YYAsyncLayerDisplayTask *task=[bg newAsyncDisplayTask];
    task.displayContentsForLayer(bg.frame.size,^BOOL { return NO; });DrainIntegration();
}
static void VerifyDynamicNamedBubbleSeams(void) {
    // One custom stacked-bubble chain reproduces the reported group first seam.
    // Its CSS/font origin changes without changing any native body/row dimensions.
    for (Class cls in @[TextMessageViewModel.class,VoiceMessageViewModel.class]) {
        BOOL voice=cls==VoiceMessageViewModel.class;
        ConfigureIntegration(YES,2);nativeMessageMarginTop=8;nativeMessageNameLength=16;
        BubbleInfo *info=[BubbleInfo new];info.normal=NativeCapsTemplate(3,1,3);info.pressed=info.normal;
        TestController *page=[TestController new];page.session=@"group@chatroom";page.nodes=[NSMutableArray array];
        UIWindow *window=[UIWindow new];UITableView *table=[UITableView new];page.table=table;page.view=table;table.window=window;
        table.bounds=CGRectMake(0,0,320,500);table.contentSize=CGSizeMake(320,1200);table.contentOffset=CGPointMake(0,19);
        for (NSUInteger i=0;i<4;i++) {
            TextMessageViewModel *m=[cls new];m.messageWrap=model(26000+(unsigned)i).messageWrap;
            m.messageWrap.m_uiMessageType=voice ? 34 : 1;m.contentViewSize=CGSizeMake(180,37);m.bgBubbleInfo=info;
            m.chatRoomTextStateIconDescription=@"";
            [page.nodes addObject:m];
        }
        CSMessageMergeActivate(page);
        NSMutableArray *views=[NSMutableArray array],*paths=[NSMutableArray array],*heights=[NSMutableArray array],*tips=[NSMutableArray array];
        NSMutableDictionary *cells=[NSMutableDictionary dictionary];
        for (NSUInteger phase=0;phase<2;phase++) {
            if (phase) { nativeMessageMarginTop=11;nativeMessageNameLength=18; }
            for (NSUInteger i=0;i<4;i++) {
                NSIndexPath *path=phase ? paths[i] : [NSIndexPath indexPathForRow:0 inSection:i];if (!phase) [paths addObject:path];
                CSMessageMergePrepare(page,table,path);
                CGFloat y=i ? nativeMessageMarginTop+3 : ceil(nativeMessageMarginTop+nativeMessageNameLength);
                CGFloat expected=i==0 ? y+35 : (i==3 ? 90-y : 35);
                CGFloat height=CSMessageMergeRowHeight(page,table,path,90);CHECK(fabs(height-expected)<.01);
                if (phase) heights[i]=@(height);else [heights addObject:@(height)];
                NativeHierarchyCellView *v=phase ? views[i] : (voice ? [VoiceMessageCellView new] : [NativeHierarchyCellView new]);
                if (!phase) {
                    v.viewModel=page.nodes[i];MMHeadImageView *head=[MMHeadImageView new];
                    head.bounds=CGRectMake(0,0,43,43);head.imageSize=CGSizeMake(37,37);
                    head.headImageView=[UIView new];head.headImageView.frame=CGRectMake(3,3,37,37);
                    head.headImageView.bounds=CGRectMake(0,0,37,37);[head addSubview:head.headImageView];
                    v.head=head;[v addSubview:head];
                    v.container=[UIView new];[v addSubview:v.container];
                    YYAsyncImageView *bg=[YYAsyncImageView new];bg.image=[ForbiddenYYImage deferredImageWithUIImage:info.normal];
                    bg.highlightedImage=[ForbiddenYYImage deferredImageWithUIImage:info.pressed];v.content=bg;[v.container addSubview:bg];
                    v->m_chatRoomNameLabel=[UIView new];v->m_chatRoomNameLabel.frame=CGRectMake(50,0,160,14);
                    v->m_chatRoomNameLabel.bounds=CGRectMake(0,0,160,14);v->m_chatRoomNameLabel.hidden=i!=0;[v addSubview:v->m_chatRoomNameLabel];
                    if (voice) {
                        VoiceMessageCellView *vc=(id)v;UIView *glyph=[UIView new];glyph.frame=CGRectMake(18,6.5,24,24);glyph.bounds=CGRectMake(0,0,24,24);
                        vc->m_playingImageView=glyph;[v.container addSubview:glyph];
                        UIView *tip=[UIView new];tip.bounds=CGRectMake(0,0,60,20);[v addSubview:tip];[tips addObject:tip];
                    }
                    TestTableCell *cell=[TestTableCell new];cell.cellView=v;cells[path]=cell;[views addObject:v];
                } else CSMessageMergeRestore(v);
                v.frame=CGRectMake(0,0,320,height);v.bounds=v.frame;v.head.frame=CGRectMake(0,nativeMessageMarginTop,43,43);
                v.container.frame=CGRectMake(40,y,240,37);v.container.bounds=CGRectMake(0,0,240,37);
                v.content.frame=CGRectMake(10,0,180,37);v.content.bounds=CGRectMake(0,0,180,37);
                if (voice) ((UIView *)tips[i]).frame=CGRectMake(258,y+8.5,60,20);
                CSMessageMergeBind(page,table,path,cells[path]);
            }
            table.testCells=cells;table.testHeights=heights;table.indexPathsForVisibleRows=paths;
            for (NSUInteger pass=0;pass<12;pass++) {
                table.dragging=pass<4;table.decelerating=pass>=4 && pass<8;
                for (NSUInteger i=0;i<4;i++) {
                    NativeHierarchyCellView *v=views[i];
                    if (voice) { ((VoiceMessageViewModel *)v.viewModel).bShowingQuickTranTips=pass%3!=0;((UIView *)tips[i]).hidden=pass%3==0; }
                    if (pass==1 || pass==3) { ((YYAsyncImageView *)v.content).highlighted=pass==3;Display((id)v.content); }
                    CSMessageMergeRender(v);CHECK(fabs(CSMessageMergeRowHeight(page,table,paths[i],90)-[heights[i] doubleValue])<.01);
                    if (i) {
                        NativeHierarchyCellView *previous=views[i-1];
                        CGFloat previousBottom=previous.frame.origin.y+CGRectGetMaxY([previous convertRect:previous.content.bounds fromView:previous.content])-3;
                        CGFloat currentTop=v.frame.origin.y+CGRectGetMinY([v convertRect:v.content.bounds fromView:v.content])+1;
                        CHECK(fabs([heights[i-1] doubleValue]+currentTop-previousBottom-2)<.01);
                    }
                }
                CSMessageMergeFlush(page);CHECK(table.updateCount==0);CHECK(table.contentOffset.y==19);
            }
            CHECK(CSMessageMergeLayoutSettled(page));
        }
        for (NativeHierarchyCellView *v in views) { CSMessageMergeReuse(v);CSBubbleStyleDetach(v); }
        CSMessageMergeDeactivate(page);nativeMessageMarginTop=5;nativeMessageNameLength=12;
    }
}

static NSUInteger VerifyVoiceTransTextSeams(void) {
    NSString *previousVersion=CSMessageMergeTestProfileVersion;
    NSUInteger scenarios=0;
    NSArray *orders=@[
        @[TextMessageViewModel.class,VoiceTransTextMessageViewModel.class,VoiceTransTextMessageViewModelV2.class],
        @[VoiceTransTextMessageViewModel.class,VoiceTransTextMessageViewModelV2.class,TextMessageViewModel.class],
        @[VoiceTransTextMessageViewModelV2.class,TextMessageViewModel.class,VoiceTransTextMessageViewModel.class]
    ];
    // These fixtures deliberately inherit ordinary text geometry. Their exact
    // classes exercise the sent-message path, separately from voice transcripts.
    for (NSString *version in @[@"8.0.80",@"8.0.99"]) for (NSArray *order in orders)
    for (NSUInteger style=0;style<2;style++) for (NSUInteger outgoing=0;outgoing<2;outgoing++)
    for (NSString *session in @[@"alice",@"group@chatroom"]) {
        CSMessageMergeTestProfileVersion=version;BOOL qualified=[version isEqual:@"8.0.80"];
        ConfigureIntegration(style,2);scenarios++;
        BubbleInfo *info=[BubbleInfo new];info.normal=NativeCapsTemplate(2,1,3);info.pressed=info.normal;
        TestController *page=[TestController new];page.session=session;page.nodes=[NSMutableArray array];
        UIWindow *window=[UIWindow new];UITableView *table=[UITableView new];page.table=table;page.view=table;table.window=window;
        table.bounds=CGRectMake(0,0,320,600);table.contentSize=CGSizeMake(320,1200);table.contentOffset=CGPointMake(0,19);
        for (NSUInteger i=0;i<order.count;i++) {
            TextMessageViewModel *m=[order[i] new];m.messageWrap=model(28000+(unsigned)i).messageWrap;
            m.messageWrap.m_nsFromUsr=session;m.messageWrap.m_uiMessageType=1;m.isSender=outgoing;
            m.contentViewSize=CGSizeMake(180,38);m.bgBubbleInfo=info;m.chatRoomTextStateIconDescription=@"";
            [page.nodes addObject:m];
        }
        CSMessageMergeActivate(page);
        NSMutableArray *views=[NSMutableArray array],*paths=[NSMutableArray array],*heights=[NSMutableArray array],*nativeHeights=[NSMutableArray array];
        NSMutableDictionary *cells=[NSMutableDictionary dictionary];
        for (NSUInteger i=0;i<order.count;i++) {
            BOOL named=i==0 && !outgoing && [session hasSuffix:@"@chatroom"];
            CGFloat y=named ? 17 : 8,native=named ? 67 : 55;
            NSIndexPath *path=[NSIndexPath indexPathForRow:0 inSection:i];[paths addObject:path];
            CSMessageMergePrepare(page,table,path);CGFloat height=CSMessageMergeRowHeight(page,table,path,native);
            CGFloat expected=!qualified ? native : (i==0 ? y+36 : (i==order.count-1 ? native-y : 36));
            CHECK(fabs(height-expected)<.01); // The first plan must work before any cell exists.
            [heights addObject:@(height)];[nativeHeights addObject:@(native)];
            Class cellClass=order[i]==VoiceTransTextMessageViewModel.class ? VoiceTransTextMessageCellView.class :
                (order[i]==VoiceTransTextMessageViewModelV2.class ? VoiceTransTextMessageCellViewV2.class : TextMessageCellView.class);
            NativeHierarchyCellView *v=[cellClass new];v.viewModel=page.nodes[i];
            v.container=[UIView new];[v addSubview:v.container];
            v.head=[UIView new];v.head.bounds=CGRectMake(0,0,38,38);[v addSubview:v.head];
            YYAsyncImageView *bg=[YYAsyncImageView new];bg.image=[ForbiddenYYImage deferredImageWithUIImage:info.normal];
            bg.highlightedImage=[ForbiddenYYImage deferredImageWithUIImage:info.pressed];
            v.content=bg;[v.container addSubview:bg];
            if (named) {
                v->m_chatRoomNameLabel=[UIView new];v->m_chatRoomNameLabel.frame=CGRectMake(50,0,160,14);
                v->m_chatRoomNameLabel.bounds=CGRectMake(0,0,160,14);[v addSubview:v->m_chatRoomNameLabel];
            }
            TestTableCell *cell=[TestTableCell new];cell.cellView=v;cells[path]=cell;[views addObject:v];
        }
        table.testCells=cells;table.testHeights=heights;table.indexPathsForVisibleRows=paths;
        for (NSUInteger binding=0;binding<2;binding++) {
            for (NSUInteger i=0;i<views.count;i++) {
                NativeHierarchyCellView *v=views[i];BOOL named=i==0 && !outgoing && [session hasSuffix:@"@chatroom"];
                v.frame=CGRectMake(0,0,320,[heights[i] doubleValue]);v.bounds=CGRectMake(0,0,320,[heights[i] doubleValue]);
                v.head.frame=CGRectMake(outgoing ? 282 : 0,5,38,38);
                v.container.frame=CGRectMake(40,named ? 17 : 8,240,38);v.container.bounds=CGRectMake(0,0,240,38);
                v.content.frame=CGRectMake(10,0,180,38);v.content.bounds=CGRectMake(0,0,180,38);
                CSMessageMergeBind(page,table,paths[i],cells[paths[i]]);
            }
            for (NSUInteger pass=0;pass<8;pass++) {
                table.dragging=pass<3;table.decelerating=pass>=3 && pass<6;
                for (NSUInteger i=0;i<views.count;i++) {
                    NativeHierarchyCellView *v=views[i];
                    if (pass==1 || pass==3) { ((YYAsyncImageView *)v.content).highlighted=pass==3;Display((id)v.content); }
                    CSMessageMergeRender(v);
                    CHECK(fabs(CSMessageMergeRowHeight(page,table,paths[i],[nativeHeights[i] doubleValue])-[heights[i] doubleValue])<.01);
                    if (!qualified) CHECK(v.frame.origin.y==0);
                    if (i) {
                        NativeHierarchyCellView *previous=views[i-1];
                        // Read the actual nested bubble frames. The synthetic
                        // source image has independently known 1pt/3pt alpha insets.
                        CGFloat end=previous.frame.origin.y+CGRectGetMaxY([previous convertRect:previous.content.bounds fromView:previous.content])-3;
                        CGFloat start=v.frame.origin.y+CGRectGetMinY([v convertRect:v.content.bounds fromView:v.content])+1;
                        CGFloat expected=qualified ? 2 : (i==1 && !outgoing && [session hasSuffix:@"@chatroom"] ? 24 : 21);
                        CHECK(fabs([heights[i-1] doubleValue]+start-end-expected)<.01);
                    }
                }
                CSMessageMergeFlush(page);CHECK(table.updateCount==0);CHECK(table.contentOffset.y==19);
            }
            for (NativeHierarchyCellView *v in views) { CSMessageMergeReuse(v);CSBubbleStyleDetach(v);CHECK(v.frame.origin.y==0); }
        }
        CSMessageMergeDeactivate(page);
    }
    CSMessageMergeTestProfileVersion=previousVersion;
    return scenarios;
}

// Only this fixture table replays native delegate height queries after a real
// begin/endUpdates transaction; the shared UIKit double stays unchanged.
@interface VoiceTransAnimationTable : UITableView
@property(nonatomic,weak) TestController *owner;
@property(nonatomic) NSUInteger heightQueries, finalLayouts;
@end
@implementation VoiceTransAnimationTable
- (void)endUpdates {
    [super endUpdates];
    NSMutableArray *heights=[NSMutableArray array];
    for (NSUInteger i=0;i<self.owner.nodes.count;i++) {
        self.heightQueries++;
        NSIndexPath *path=[NSIndexPath indexPathForRow:0 inSection:i];
        CGFloat height=[self.owner tableView:self heightForRowAtIndexPath:path];
        [heights addObject:@(height)];
        TextMessageCellView *v=(id)[self.testCells[path] cellView];
        if (fabs(v.bounds.size.height-height)>.01) {
            CGRect frame=v.frame,bounds=v.bounds;frame.size.height=height;bounds.size.height=height;
            v.frame=frame;v.bounds=bounds;v.nativeLayoutCacheClean=NO;[v setNeedsLayout];
        }
    }
    self.testHeights=heights;
}
- (void)layoutIfNeeded {
    [super layoutIfNeeded];
    // One UIKit tick consumes only requested cells. Native layoutSubviews first
    // checks model readiness, then animation/size-cache gates. The lifecycle's
    // Render still runs when either native gate returns early.
    for (NSUInteger i=0;i<self.owner.nodes.count;i++) {
        TextMessageCellView *v=(id)[self.testCells[[NSIndexPath indexPathForRow:0 inSection:i]] cellView];
        if (v.nativeConsumedLayoutRequests==v.layoutRequests) continue;
        v.nativeConsumedLayoutRequests=v.layoutRequests;CSMessageMergeRestore(v);
        BOOL animating=[v respondsToSelector:@selector(isAnimating)] && ((VoiceTransTextMessageCellView *)v).isAnimating;
        if (v.nativeModelGateBlocks) { v.nativeModelGateBlocks--;v.nativeSkippedLayouts++; }
        else if (animating || v.nativeLayoutCacheClean) v.nativeSkippedLayouts++;
        else {
            CSMessageMergePerformNativeLayout(v,^{
                CGFloat body=v.viewModel.contentViewSize.height;
                v.container.frame=CGRectMake(40,8,240,body);v.container.bounds=CGRectMake(0,0,240,body);
                v.content.frame=CGRectMake(10,0,v.viewModel.contentViewSize.width,body);v.content.bounds=CGRectMake(0,0,v.viewModel.contentViewSize.width,body);
                v.nativeLayoutCacheClean=YES;v.nativeLayouts++;self.finalLayouts++;
            });
        }
        CSMessageMergeRender(v);CSMessageMergeNativeLayoutPassEnded(v);
    }
}
@end

@interface VoiceTransAnimationFixture : NSObject
@property(nonatomic,strong) TestController *page;
@property(nonatomic,strong) VoiceTransAnimationTable *table;
@property(nonatomic,strong) UIWindow *window;
@property(nonatomic,strong) NSArray *views, *extras, *paths, *heights;
@end
@implementation VoiceTransAnimationFixture @end

static VoiceTransAnimationFixture *CreateVoiceTransAnimationFixture(BOOL style) {
    NSArray *models=@[TextMessageViewModel.class,VoiceTransTextMessageViewModel.class,VoiceTransTextMessageViewModelV2.class,TextMessageViewModel.class];
    NSArray *cellClasses=@[TextMessageCellView.class,VoiceTransTextMessageCellView.class,VoiceTransTextMessageCellViewV2.class,TextMessageCellView.class];
    ConfigureIntegration(style,2);
    BOOL qualified=[CSMessageMergeTestProfileVersion isEqual:@"8.0.80"];
    BubbleInfo *info=[BubbleInfo new];info.normal=NativeCapsTemplate(2,1,3);info.pressed=info.normal;
    TestController *page=[TestController new];page.session=@"alice";page.nodes=[NSMutableArray array];
    UIWindow *window=[UIWindow new];VoiceTransAnimationTable *table=[VoiceTransAnimationTable new];
    table.owner=page;page.table=table;page.view=table;table.window=window;
    table.bounds=CGRectMake(0,0,320,600);table.contentSize=CGSizeMake(320,1200);table.contentOffset=CGPointMake(0,19);
    for (NSUInteger i=0;i<models.count;i++) {
        TextMessageViewModel *m=[models[i] new];m.messageWrap=model(30000+(unsigned)i).messageWrap;
        m.messageWrap.m_nsFromUsr=@"alice";m.messageWrap.m_uiMessageType=1;m.isSender=YES;
        m.contentViewSize=CGSizeMake(180,38);m.nativeCachedHeight=55;m.bgBubbleInfo=info;[page.nodes addObject:m];
    }
    CSMessageMergeActivate(page);
    NSMutableArray *views=[NSMutableArray array],*extras=[NSMutableArray array],*paths=[NSMutableArray array],*heights=[NSMutableArray array];
    NSMutableDictionary *cells=[NSMutableDictionary dictionary];
    for (NSUInteger i=0;i<models.count;i++) {
        NSIndexPath *path=[NSIndexPath indexPathForRow:0 inSection:i];[paths addObject:path];
        CSMessageMergePrepare(page,table,path);CGFloat height=CSMessageMergeRowHeight(page,table,path,55);
        CHECK(height==(qualified ? (i==0 ? 44 : (i==models.count-1 ? 47 : 36)) : 55));[heights addObject:@(height)];
        NativeHierarchyCellView *v=[cellClasses[i] new];v.viewModel=page.nodes[i];
        v.frame=CGRectMake(0,0,320,height);v.bounds=CGRectMake(0,0,320,height);
        v.head=[UIView new];v.head.frame=CGRectMake(282,5,38,38);v.head.bounds=CGRectMake(0,0,38,38);[v addSubview:v.head];
        v.container=[UIView new];v.container.frame=CGRectMake(40,8,240,38);v.container.bounds=CGRectMake(0,0,240,38);[v addSubview:v.container];
        YYAsyncImageView *bg=[YYAsyncImageView new];bg.image=[YYImage imageWithUIImage:info.normal];bg.highlightedImage=[YYImage imageWithUIImage:info.pressed];
        bg.frame=CGRectMake(10,0,180,38);bg.bounds=CGRectMake(0,0,180,38);v.content=bg;[v.container addSubview:bg];
        UIView *extra=[UIView new];extra.frame=CGRectMake(50,44,20,8);extra.bounds=CGRectMake(0,0,20,8);extra.hidden=YES;[v addSubview:extra];[extras addObject:extra];
        TestTableCell *cell=[TestTableCell new];cell.cellView=v;cells[path]=cell;[views addObject:v];
        CSMessageMergeBind(page,table,path,cell);CSMessageMergeRender(v);
    }
    table.testCells=cells;table.testHeights=heights;
    table.indexPathsForVisibleRows=@[paths[1],paths[2]];
    for (TextMessageCellView *v in views) { v.nativeLayoutCacheClean=YES;v.nativeConsumedLayoutRequests=v.layoutRequests; }
    VoiceTransAnimationFixture *fixture=[VoiceTransAnimationFixture new];
    fixture.page=page;fixture.table=table;fixture.window=window;
    fixture.views=views;fixture.extras=extras;fixture.paths=paths;fixture.heights=heights;
    return fixture;
}
static void FinishVoiceTransAnimationFixture(VoiceTransAnimationFixture *fixture) {
    for (NativeHierarchyCellView *v in fixture.views) { CSMessageMergeReuse(v);CSBubbleStyleDetach(v); }
    CSMessageMergeDeactivate(fixture.page);
}

static NSUInteger VerifyVoiceTransTextAnimationSeams(void) {
    NSString *previousVersion=CSMessageMergeTestProfileVersion;CSMessageMergeTestProfileVersion=@"8.0.80";
    NSUInteger scenarios=0;
    for (NSUInteger style=0;style<2;style++) for (NSUInteger variant=0;variant<3;variant++)
    for (NSUInteger pending=0;pending<2;pending++) for (NSUInteger interaction=0;interaction<2;interaction++) {
        scenarios++;VoiceTransAnimationFixture *fixture=CreateVoiceTransAnimationFixture(style);
        TestController *page=fixture.page;VoiceTransAnimationTable *table=fixture.table;
        NSArray *views=fixture.views,*extras=fixture.extras,*heights=fixture.heights;
        for (NSUInteger i=1;i<=2;i++) {
            VoiceTransTextMessageCellView *v=views[i];v.isAnimating=YES;[v resetLayoutCache];
            CSMessageMergeRestore(v);
            if (variant==0) { CGRect frame=v.container.frame;frame.origin.y=11;v.container.frame=frame; }
            if (variant==1) v.container.transform=CGAffineTransformMakeScale(.95,.95);
            if (variant==2) ((UIView *)extras[i]).hidden=NO;
            NSUInteger requests=v.layoutRequests;CSMessageMergeNativeAnimationEnded(v);CHECK(v.layoutRequests==requests);
            CSMessageMergeRender(v);
        }
        CSMessageMergeFlush(page);
        // A transient frame must not publish a wider permanent safety envelope.
        CHECK(table.updateCount==0);CHECK(table.heightQueries==0);CHECK([table.testHeights isEqual:heights]);
        if (pending) {
            // A real model width change independently needs layout while the
            // native animation gate is closed. Heights and final y stay unchanged.
            for (NSUInteger i=1;i<=2;i++) ((TextMessageViewModel *)page.nodes[i]).contentViewSize=CGSizeMake(181,38);
            CSMessageMergeInvalidateLayout(page);CSMessageMergeWillMutate(page);CSMessageMergeDidMutate(page);CSMessageMergeFlush(page);
            CHECK(table.updateCount==0);CHECK(table.heightQueries==0);CHECK([table.testHeights isEqual:heights]);
        }
        table.dragging=interaction==0;table.decelerating=interaction==1;
        for (NSUInteger i=1;i<=2;i++) {
            VoiceTransTextMessageCellView *v=views[i];v.isAnimating=NO;
            NSUInteger requests=v.layoutRequests;CSMessageMergeNativeAnimationEnded(v);CHECK(v.layoutRequests==requests+1);
            v.container.transform=CGAffineTransformIdentity;((UIView *)extras[i]).hidden=YES;
        }
        // Native completion clears only the flag. Replay the requested final
        // layout explicitly; height queries belong exclusively to table updates.
        NSUInteger layouts=table.finalLayouts;[table layoutIfNeeded];CHECK(table.finalLayouts==layouts+2);
        CSMessageMergeFlush(page);CHECK(table.updateCount==0);CHECK(table.heightQueries==0);
        CHECK(!CSMessageMergeLayoutSettled(page));
        table.dragging=NO;table.decelerating=NO;CSMessageMergeFlush(page);
        CHECK(table.updateCount==1);CHECK(table.heightQueries==4);CHECK([table.testHeights isEqual:heights]);
        for (NSUInteger pass=0;pass<8;pass++) {
            [table layoutIfNeeded];CSMessageMergeFlush(page);
            CHECK(table.updateCount==1);CHECK(table.heightQueries==4);
            for (NSUInteger i=1;i<views.count;i++) {
                NativeHierarchyCellView *previous=views[i-1],*v=views[i];
                CGFloat end=previous.frame.origin.y+CGRectGetMaxY([previous convertRect:previous.content.bounds fromView:previous.content])-3;
                CGFloat start=v.frame.origin.y+CGRectGetMinY([v convertRect:v.content.bounds fromView:v.content])+1;
                CHECK(fabs([table.testHeights[i-1] doubleValue]+start-end-2)<.01);
            }
        }
        CHECK(CSMessageMergeLayoutSettled(page));CHECK(table.contentOffset.y==19);
        FinishVoiceTransAnimationFixture(fixture);
    }
    CSMessageMergeTestProfileVersion=previousVersion;return scenarios;
}

static void SetVoiceTransFixtureAnimating(VoiceTransAnimationFixture *fixture, BOOL animating) {
    for (NSUInteger i=1;i<=2;i++) ((VoiceTransTextMessageCellView *)fixture.views[i]).isAnimating=animating;
}
static void ScheduleVoiceTransFixture(VoiceTransAnimationFixture *fixture) {
    CSMessageMergeInvalidateLayout(fixture.page);
    CSMessageMergeWillMutate(fixture.page);CSMessageMergeDidMutate(fixture.page);CSMessageMergeFlush(fixture.page);
}
static void CompleteVoiceTransFixture(VoiceTransAnimationFixture *fixture) {
    SetVoiceTransFixtureAnimating(fixture,NO);
    for (NSUInteger i=1;i<=2;i++) CSMessageMergeNativeAnimationEnded(fixture.views[i]);
    [fixture.table layoutIfNeeded];CSMessageMergeFlush(fixture.page);
}
static NSUInteger VerifyVoiceTransTextAnimationBoundaries(void) {
    NSString *previousVersion=CSMessageMergeTestProfileVersion;CSMessageMergeTestProfileVersion=@"8.0.80";
    NSUInteger scenarios=0;
    {
        scenarios++;VoiceTransAnimationFixture *fixture=CreateVoiceTransAnimationFixture(NO);
        SetVoiceTransFixtureAnimating(fixture,YES);
        TextMessageViewModel *first=fixture.page.nodes[1],*second=fixture.page.nodes[2];
        NSUInteger firstResets=first.resetCount,secondResets=second.resetCount;
        // Break only the preceding join while both native cells suppress layout.
        ((TextMessageViewModel *)fixture.page.nodes[0]).isSender=NO;
        ScheduleVoiceTransFixture(fixture);
        CHECK(first.resetCount==firstResets);CHECK(second.resetCount==secondResets);
        CHECK(fixture.table.updateCount==0);CHECK(fixture.table.heightQueries==0);
        CHECK(!CSMessageMergeLayoutSettled(fixture.page));
        CompleteVoiceTransFixture(fixture);
        CHECK(fixture.table.updateCount==1);CHECK(fixture.table.heightQueries==4);
        CHECK(([fixture.table.testHeights isEqual:@[@55,@44,@36,@47]]));
        CHECK(CSMessageMergeLayoutSettled(fixture.page));
        for (NSUInteger i=2;i<fixture.views.count;i++) {
            NativeHierarchyCellView *previous=fixture.views[i-1],*v=fixture.views[i];
            CGFloat end=previous.frame.origin.y+CGRectGetMaxY([previous convertRect:previous.content.bounds fromView:previous.content])-3;
            CGFloat start=v.frame.origin.y+CGRectGetMinY([v convertRect:v.content.bounds fromView:v.content])+1;
            CHECK(fabs([fixture.table.testHeights[i-1] doubleValue]+start-end-2)<.01);
        }
        CSMessageMergeFlush(fixture.page);CHECK(fixture.table.updateCount==1);
        FinishVoiceTransAnimationFixture(fixture);
    }
    for (NSUInteger change=0;change<2;change++) {
        scenarios++;VoiceTransAnimationFixture *fixture=CreateVoiceTransAnimationFixture(NO);
        SetVoiceTransFixtureAnimating(fixture,YES);ScheduleVoiceTransFixture(fixture);
        CHECK(!CSMessageMergeLayoutSettled(fixture.page));CHECK(fixture.table.updateCount==0);
        NSMutableDictionary *settings=[[NSUserDefaults.standardUserDefaults volatileDomainForName:NSArgumentDomain] mutableCopy];
        if (change==0) settings[CSMessageMergeEnabledKey]=@NO;
        else settings[CSMessageMergeScopeKey]=@1; // The fixture is a private chat.
        [NSUserDefaults.standardUserDefaults setVolatileDomain:settings forName:NSArgumentDomain];
        CSMessageMergeActivate(fixture.page);CSMessageMergeFlush(fixture.page);
        CHECK(fixture.table.updateCount==1);CHECK(fixture.table.heightQueries==4);
        CHECK(([fixture.table.testHeights isEqual:@[@55,@55,@55,@55]]));
        CHECK(CSMessageMergeLayoutSettled(fixture.page));
        CompleteVoiceTransFixture(fixture);CHECK(fixture.table.updateCount==1);
        FinishVoiceTransAnimationFixture(fixture);
    }
    {
        scenarios++;VoiceTransAnimationFixture *fixture=CreateVoiceTransAnimationFixture(NO);
        for (NSUInteger i=1;i<=2;i++) ((TextMessageViewModel *)fixture.page.nodes[i]).messageWrap.m_uiMessageType=34;
        ScheduleVoiceTransFixture(fixture);
        CHECK(fixture.table.updateCount==1);CHECK(([fixture.table.testHeights isEqual:@[@55,@55,@55,@55]]));
        SetVoiceTransFixtureAnimating(fixture,YES);
        for (NSUInteger i=1;i<=2;i++) ((TextMessageViewModel *)fixture.page.nodes[i]).messageWrap.m_uiMessageType=1;
        // Old inactive ownership must not defer the first eligible preparation.
        ScheduleVoiceTransFixture(fixture);
        CHECK(fixture.table.updateCount==2);CHECK(fixture.table.heightQueries==8);
        CHECK([fixture.table.testHeights isEqual:fixture.heights]);CHECK(CSMessageMergeLayoutSettled(fixture.page));
        CompleteVoiceTransFixture(fixture);CHECK(fixture.table.updateCount==3);CHECK(CSMessageMergeLayoutSettled(fixture.page));
        FinishVoiceTransAnimationFixture(fixture);
    }
    {
        scenarios++;VoiceTransAnimationFixture *fixture=CreateVoiceTransAnimationFixture(NO);
        SetVoiceTransFixtureAnimating(fixture,YES);ScheduleVoiceTransFixture(fixture);
        CHECK(!CSMessageMergeLayoutSettled(fixture.page));CHECK(fixture.table.updateCount==0);
        for (NSUInteger i=1;i<=2;i++) CSMessageMergeReuse(fixture.views[i]);
        fixture.table.indexPathsForVisibleRows=@[];SetVoiceTransFixtureAnimating(fixture,NO);
        for (NSUInteger i=1;i<=2;i++) {
            UIView *v=fixture.views[i];NSUInteger requests=v.layoutRequests;
            CSMessageMergeNativeAnimationEnded(v);CHECK(v.layoutRequests==requests);
        }
        // Scroll-end flush has no dirty model or bound completion state left.
        CSMessageMergeFlush(fixture.page);
        CHECK(CSMessageMergeLayoutSettled(fixture.page));CHECK(fixture.table.updateCount==0);CHECK(fixture.table.heightQueries==0);
        FinishVoiceTransAnimationFixture(fixture);
    }
    {
        scenarios++;VoiceTransAnimationFixture *fixture=CreateVoiceTransAnimationFixture(NO);
        SetVoiceTransFixtureAnimating(fixture,YES);ScheduleVoiceTransFixture(fixture);
        CHECK(!CSMessageMergeLayoutSettled(fixture.page));CSMessageMergeDeactivate(fixture.page);
        VoiceTransTextMessageCellView *v=fixture.views[1];v.nativeModelGateBlocks=1;
        CompleteVoiceTransFixture(fixture);CHECK(fixture.table.updateCount==0);CHECK(v.nativeLayouts==0);
        CSMessageMergeActivate(fixture.page);CSMessageMergeFlush(fixture.page);
        CHECK(fixture.table.updateCount==1);CHECK(fixture.table.heightQueries==4);
        CHECK(v.nativeLayouts==0);CHECK(!CSMessageMergeLayoutSettled(fixture.page));
        for (NSUInteger tick=0;tick<4;tick++) { DrainIntegration();[fixture.table layoutIfNeeded];CSMessageMergeFlush(fixture.page); }
        CHECK(v.nativeLayouts>0);CHECK(CSMessageMergeLayoutSettled(fixture.page));CHECK(fixture.table.updateCount==1);
        FinishVoiceTransAnimationFixture(fixture);
    }
    {
        scenarios++;CSMessageMergeTestProfileVersion=@"8.0.99";
        VoiceTransAnimationFixture *fixture=CreateVoiceTransAnimationFixture(NO);
        SetVoiceTransFixtureAnimating(fixture,YES);
        for (NSUInteger i=1;i<=2;i++) ((TextMessageViewModel *)fixture.page.nodes[i]).contentViewSize=CGSizeMake(181,38);
        ScheduleVoiceTransFixture(fixture);
        CHECK(fixture.table.updateCount==1);CHECK(fixture.table.heightQueries==4);
        CHECK(([fixture.table.testHeights isEqual:@[@55,@55,@55,@55]]));CHECK(CSMessageMergeLayoutSettled(fixture.page));
        SetVoiceTransFixtureAnimating(fixture,NO);
        for (NSUInteger i=1;i<=2;i++) {
            UIView *v=fixture.views[i];NSUInteger requests=v.layoutRequests;
            CSMessageMergeNativeAnimationEnded(v);CHECK(v.layoutRequests==requests);
        }
        CSMessageMergeFlush(fixture.page);CHECK(CSMessageMergeLayoutSettled(fixture.page));CHECK(fixture.table.updateCount==1);
        FinishVoiceTransAnimationFixture(fixture);
    }
    CSMessageMergeTestProfileVersion=previousVersion;return scenarios;
}

static void AdvanceVoiceTransNativeTicks(VoiceTransAnimationFixture *fixture) {
    for (NSUInteger tick=0;tick<4;tick++) {
        DrainIntegration();[fixture.table layoutIfNeeded];CSMessageMergeFlush(fixture.page);
    }
}
static void CheckVoiceTransNativeSeams(VoiceTransAnimationFixture *fixture, NSArray *heights) {
    CHECK([fixture.table.testHeights isEqual:heights]);CHECK(CSMessageMergeLayoutSettled(fixture.page));
    for (NSUInteger i=1;i<fixture.views.count;i++) {
        NativeHierarchyCellView *previous=fixture.views[i-1],*v=fixture.views[i];
        CGFloat end=previous.frame.origin.y+CGRectGetMaxY([previous convertRect:previous.content.bounds fromView:previous.content])-3;
        CGFloat start=v.frame.origin.y+CGRectGetMinY([v convertRect:v.content.bounds fromView:v.content])+1;
        CHECK(fabs([fixture.table.testHeights[i-1] doubleValue]+start-end-2)<.01);
    }
}
static NSUInteger VerifyVoiceTransTextNativeCompletion(void) {
    NSString *previousVersion=CSMessageMergeTestProfileVersion;CSMessageMergeTestProfileVersion=@"8.0.80";
    NSUInteger scenarios=0;
    // The first requested native pass may stop at the model gate; an already
    // clean cell cache independently requires invalidation at completion.
    for (NSUInteger blocked=0;blocked<2;blocked++) {
        scenarios++;VoiceTransAnimationFixture *fixture=CreateVoiceTransAnimationFixture(NO);
        VoiceTransTextMessageCellView *v=fixture.views[1];v.isAnimating=YES;
        CSMessageMergeRestore(v);CGRect frame=v.container.frame;frame.origin.y=11;v.container.frame=frame;
        v.nativeLayoutCacheClean=blocked==0;v.nativeModelGateBlocks=blocked;
        ScheduleVoiceTransFixture(fixture);CHECK(!CSMessageMergeLayoutSettled(fixture.page));
        v.isAnimating=NO;CSMessageMergeNativeAnimationEnded(v);
        NSUInteger layouts=v.nativeLayouts;[fixture.table layoutIfNeeded];
        CHECK(v.nativeLayouts==layouts+(blocked ? 0 : 1));
        if (blocked) {
            CHECK(v.container.frame.origin.y==11);CHECK(!CSMessageMergeLayoutSettled(fixture.page));
            CHECK(fixture.table.updateCount==0); // No transient-frame rejection.
            // Pause after the retry was queued. Its callback must preserve the
            // single opportunity for activation's next native readiness gate.
            CSMessageMergeDeactivate(fixture.page);DrainIntegration();
            CHECK(v.nativeLayouts==layouts);CHECK(fixture.table.updateCount==0);
            v.nativeModelGateBlocks=1;CSMessageMergeActivate(fixture.page);CSMessageMergeFlush(fixture.page);
            CHECK(v.nativeLayouts==layouts);CHECK(!CSMessageMergeLayoutSettled(fixture.page));
        }
        AdvanceVoiceTransNativeTicks(fixture);
        CHECK(v.nativeLayouts>layouts);CHECK(fixture.table.updateCount==1);CHECK(fixture.table.heightQueries==4);
        CheckVoiceTransNativeSeams(fixture,fixture.heights);
        NSUInteger requests=v.layoutRequests,resets=v.nativeCellResets,updates=fixture.table.updateCount;
        AdvanceVoiceTransNativeTicks(fixture);
        CHECK(v.layoutRequests==requests);CHECK(v.nativeCellResets==resets);CHECK(fixture.table.updateCount==updates);
        FinishVoiceTransAnimationFixture(fixture);
    }
    {
        scenarios++;VoiceTransAnimationFixture *fixture=CreateVoiceTransAnimationFixture(NO);
        VoiceTransTextMessageCellView *v=fixture.views[1];v.isAnimating=YES;v.nativeModelGateBlocks=10;
        ScheduleVoiceTransFixture(fixture);v.isAnimating=NO;CSMessageMergeNativeAnimationEnded(v);
        [fixture.table layoutIfNeeded];AdvanceVoiceTransNativeTicks(fixture);
        CHECK(v.nativeLayouts==0);CHECK(fixture.table.updateCount==1);CHECK(!CSMessageMergeLayoutSettled(fixture.page));
        NSUInteger requests=v.layoutRequests,resets=v.nativeCellResets,skipped=v.nativeSkippedLayouts;
        AdvanceVoiceTransNativeTicks(fixture);
        CHECK(v.layoutRequests==requests);CHECK(v.nativeCellResets==resets);CHECK(v.nativeSkippedLayouts==skipped);
        CHECK(fixture.table.updateCount==1); // No polling after the single retry.
        v.nativeModelGateBlocks=0;[v setNeedsLayout];AdvanceVoiceTransNativeTicks(fixture);
        CHECK(v.nativeLayouts==1);CHECK(fixture.table.updateCount==1);CheckVoiceTransNativeSeams(fixture,fixture.heights);
        FinishVoiceTransAnimationFixture(fixture);
    }
    {
        scenarios++;VoiceTransAnimationFixture *fixture=CreateVoiceTransAnimationFixture(NO);
        VoiceTransTextMessageCellView *v=fixture.views[1];v.isAnimating=YES;ScheduleVoiceTransFixture(fixture);
        v.isAnimating=NO;CSMessageMergeNativeAnimationEnded(v);CSMessageMergeRestore(v);
        CSMessageMergePerformNativeLayout(v,^{
            v.nativeLayouts++; // A newer animation completion arrives inside this older native pass.
            v.isAnimating=YES;CGRect frame=v.container.frame;frame.origin.y=11;v.container.frame=frame;
            v.isAnimating=NO;CSMessageMergeNativeAnimationEnded(v);
        });
        CSMessageMergeRender(v);
        CHECK(CSMessageMergeMeasure(v.viewModel,CGSizeMake(320,55)).height==36);
        CHECK(fixture.table.updateCount==0);CHECK(!CSMessageMergeLayoutSettled(fixture.page));
        AdvanceVoiceTransNativeTicks(fixture);
        CHECK(v.nativeLayouts>1);CHECK(fixture.table.updateCount==1);CheckVoiceTransNativeSeams(fixture,fixture.heights);
        FinishVoiceTransAnimationFixture(fixture);
    }
    {
        scenarios++;VoiceTransAnimationFixture *fixture=CreateVoiceTransAnimationFixture(NO);
        VoiceTransTextMessageCellView *v=fixture.views[1];NSString *identity=CSMessageNativeIdentity(v.viewModel);
        v.isAnimating=YES;CSMessageMergeRestore(v);
        [v.viewModel resetLayoutCache];[v resetLayoutCache];
        v.viewModel.contentViewSize=CGSizeMake(180,62);v.viewModel.nativeCachedHeight=79;
        // Reproduce updateLayoutsWithoutReload's native height transaction while
        // common layoutInternal is suppressed; layoutUI changes only body size.
        [fixture.table beginUpdates];[fixture.table endUpdates];[fixture.table layoutIfNeeded];
        CGRect frame=v.container.frame;frame.origin.y=11;frame.size.height=62;v.container.frame=frame;
        v.container.bounds=CGRectMake(0,0,240,62);v.content.frame=CGRectMake(10,0,180,62);v.content.bounds=CGRectMake(0,0,180,62);
        CSMessageMergeRender(v);CHECK(v.nativeLayouts==0);CHECK([CSMessageNativeIdentity(v.viewModel) isEqual:identity]);
        v.isAnimating=NO;CSMessageMergeNativeAnimationEnded(v);AdvanceVoiceTransNativeTicks(fixture);
        CHECK(v.nativeLayouts>0);CHECK(fixture.table.updateCount==2);CHECK(fixture.table.heightQueries==8);
        CheckVoiceTransNativeSeams(fixture,@[@44,@60,@36,@47]);
        FinishVoiceTransAnimationFixture(fixture);
    }
    {
        scenarios++;VoiceTransAnimationFixture *fixture=CreateVoiceTransAnimationFixture(NO);
        TextMessageViewModel *m=[VoiceTransTextMessageViewModel new];m.messageWrap=model(30004).messageWrap;
        m.messageWrap.m_nsFromUsr=@"alice";m.messageWrap.m_uiMessageType=1;m.isSender=YES;
        m.contentViewSize=CGSizeMake(180,38);m.nativeCachedHeight=55;m.bgBubbleInfo=((TextMessageViewModel *)fixture.page.nodes[0]).bgBubbleInfo;
        VoiceTransTextMessageCellView *v=[VoiceTransTextMessageCellView new];v.viewModel=m;v.isAnimating=YES;
        v.frame=CGRectMake(0,0,320,55);v.bounds=CGRectMake(0,0,320,55);
        v.head=[UIView new];v.head.frame=CGRectMake(282,5,38,38);v.head.bounds=CGRectMake(0,0,38,38);[v addSubview:v.head];
        v.container=[UIView new];v.container.frame=CGRectMake(40,11,240,38);v.container.bounds=CGRectMake(0,0,240,38);[v addSubview:v.container];
        YYAsyncImageView *bg=[YYAsyncImageView new];BubbleInfo *info=m.bgBubbleInfo;
        bg.image=[YYImage imageWithUIImage:info.normal];bg.highlightedImage=[YYImage imageWithUIImage:info.pressed];
        bg.frame=CGRectMake(10,0,180,38);bg.bounds=CGRectMake(0,0,180,38);v.content=bg;[v.container addSubview:bg];
        CSMessageMergeWillMutate(fixture.page);[fixture.page.nodes addObject:m];
        NSIndexPath *path=[NSIndexPath indexPathForRow:0 inSection:4];TestTableCell *cell=[TestTableCell new];cell.cellView=v;
        NSMutableDictionary *cells=[fixture.table.testCells mutableCopy];cells[path]=cell;fixture.table.testCells=cells;
        fixture.views=[fixture.views arrayByAddingObject:v];fixture.paths=[fixture.paths arrayByAddingObject:path];
        fixture.table.testHeights=[fixture.table.testHeights arrayByAddingObject:@55];fixture.table.indexPathsForVisibleRows=fixture.paths;
        CSMessageMergeBind(fixture.page,fixture.table,path,cell);
        [fixture.table beginUpdates];[fixture.table endUpdates];[fixture.table layoutIfNeeded];
        CSMessageMergeDidMutate(fixture.page);CSMessageMergeFlush(fixture.page);CHECK(v.nativeLayouts==0);
        v.isAnimating=NO;CSMessageMergeNativeAnimationEnded(v);AdvanceVoiceTransNativeTicks(fixture);
        CHECK(v.nativeLayouts>0);CHECK(fixture.table.updateCount==2);CHECK(fixture.table.heightQueries==10);
        CheckVoiceTransNativeSeams(fixture,@[@44,@36,@36,@36,@47]);
        FinishVoiceTransAnimationFixture(fixture);
    }
    CSMessageMergeTestProfileVersion=previousVersion;return scenarios;
}

static NSUInteger VerifyVoiceTranslationSeams(void) {
    NSUInteger scenarios=0;
    // Text, side-button voice, quote, expanded voice. Rotate the two voice states
    // through first/middle/last, including the mixed chain in IMG_7445.jpg.
    NSArray *orders=@[@[@3,@0,@1],@[@0,@1,@2,@3,@0],@[@1,@3,@0],@[@0,@1,@3]];
    for (NSUInteger style=0;style<2;style++) for (NSUInteger dark=0;dark<2;dark++)
    for (NSUInteger scale=1;scale<=3;scale++) for (NSUInteger outgoing=0;outgoing<2;outgoing++)
    for (NSString *session in @[@"alice",@"group@chatroom"]) for (NSArray *order in orders) {
        ConfigureIntegration(style,2);scenarios++;
        [NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidReceiveMemoryWarningNotification object:nil];
        CGFloat body=style ? 37 : 38,top=dark ? 2 : 1,bottom=dark ? 4 : 3;
        BubbleInfo *info=[BubbleInfo new];info.normal=NativeCapsTemplate(scale,1,3);info.pressed=info.normal;
        info.darkNormal=NativeCapsTemplate(scale,2,4);info.darkPressed=info.darkNormal;
        TestController *page=[TestController new];page.session=session;page.nodes=[NSMutableArray array];
        UIWindow *window=[UIWindow new];UITableView *table=[UITableView new];page.table=table;page.view=table;table.window=window;
        table.bounds=CGRectMake(0,0,320,600);table.traitCollection.userInterfaceStyle=dark ? UIUserInterfaceStyleDark : UIUserInterfaceStyleLight;
        for (NSUInteger i=0;i<order.count;i++) {
            NSUInteger kind=[order[i] unsignedIntegerValue];BOOL voice=kind==1 || kind==3;
            TextMessageViewModel *m=voice ? [VoiceMessageViewModel new] : [TextMessageViewModel new];
            m.messageWrap=model(24000+(unsigned)i).messageWrap;m.messageWrap.m_nsFromUsr=session;
            m.messageWrap.m_uiMessageType=voice ? 34 : 1;m.isSender=outgoing;m.bgBubbleInfo=info;
            m.contentViewSize=CGSizeMake(180,body+(kind==3 ? 4+63 : 0));
            if (voice) { ((VoiceMessageViewModel *)m).bShowingQuickTranTips=kind==1;((VoiceMessageViewModel *)m).canShowTranslateText=kind==3; }
            if (kind==2) {
                m.messageWrap.m_uiMessageType=49;m.messageWrap.m_uiAppMsgInnerType=57;
                m.canShowReplyMessage=YES;m.replyTextSize=CGSizeMake(160,24);m.replyTextInset=UIEdgeInsetsMake(2,0,3,0);
            }
            [page.nodes addObject:m];
        }
        CSMessageMergeActivate(page);
        NSMutableArray *views=[NSMutableArray array],*paths=[NSMutableArray array],*heights=[NSMutableArray array],*nativeHeights=[NSMutableArray array];
        NSMutableArray *tips=[NSMutableArray array],*transcripts=[NSMutableArray array];
        NSMutableDictionary *cells=[NSMutableDictionary dictionary];
        for (NSUInteger i=0;i<order.count;i++) {
            NSUInteger kind=[order[i] unsignedIntegerValue];BOOL voice=kind==1 || kind==3;
            BOOL named=i==0 && !outgoing && [session hasSuffix:@"@chatroom"];
            CGFloat y=named ? 17 : 8,total=body+(kind==2 ? 33 : (kind==3 ? 67 : 0));
            CGFloat native=(named ? 29 : 17)+total,end=y+total-((kind==2 || kind==3) ? 0 : bottom);
            NSIndexPath *path=[NSIndexPath indexPathForRow:0 inSection:i];[paths addObject:path];
            CSMessageMergePrepare(page,table,path);CGFloat height=CSMessageMergeRowHeight(page,table,path,native);
            CGFloat expected=i==0 ? end+1 : (i==order.count-1 ? native-(8+top)+1 : end-(8+top)+2);
            if (fabs(height-expected)>=.01) fprintf(stderr,"Voice first-pass mismatch: kind=%lu row=%lu actual=%g expected=%g\n",kind,i,height,expected);
            CHECK(fabs(height-expected)<.01); // Must be correct before any cell exists.
            [heights addObject:@(height)];[nativeHeights addObject:@(native)];
            NativeHierarchyCellView *v=voice ? [VoiceMessageCellView new] : [NativeHierarchyCellView new];
            v.viewModel=page.nodes[i];v.frame=CGRectMake(0,0,320,height);v.bounds=v.frame;
            v.traitCollection.userInterfaceStyle=table.traitCollection.userInterfaceStyle;
            v.container=[UIView new];v.container.frame=CGRectMake(40,y,240,total);v.container.bounds=CGRectMake(0,0,240,total);[v addSubview:v.container];
            v.head=[UIView new];v.head.frame=CGRectMake(outgoing ? 282 : 0,5,38,38);v.head.bounds=CGRectMake(0,0,38,38);[v addSubview:v.head];
            YYAsyncImageView *bg=[YYAsyncImageView new];bg.frame=CGRectMake(10,0,180,body);bg.bounds=CGRectMake(0,0,180,body);
            bg.traitCollection.userInterfaceStyle=v.traitCollection.userInterfaceStyle;
            bg.image=[ForbiddenYYImage deferredImageWithUIImage:dark ? info.darkNormal : info.normal];
            bg.highlightedImage=[ForbiddenYYImage deferredImageWithUIImage:dark ? info.darkPressed : info.pressed];
            v.content=bg;[v.container addSubview:bg];
            UIView *tip=[UIView new],*transcript=[UIView new];[tips addObject:tip];[transcripts addObject:transcript];
            if (voice) {
                VoiceMessageCellView *vc=(id)v;
                UIView *glyph=[UIView new];glyph.frame=CGRectMake(outgoing ? 158 : 18,(body-24)/2,24,24);glyph.bounds=CGRectMake(0,0,24,24);
                glyph.transform=CGAffineTransformMakeScale(outgoing ? -1 : 1,1);vc->m_playingImageView=glyph;[v.container addSubview:glyph];
                UIView *unread=[UIView new];unread.frame=CGRectMake(202,(body-8)/2,8,8);unread.bounds=CGRectMake(0,0,8,8);
                unread.hidden=outgoing;vc->m_unreadImageView=unread;[v.container addSubview:unread];
                // Real hierarchy: the button's 20pt container is a direct cell child.
                tip.frame=CGRectMake(258,y+(body-20)/2,60,20);tip.bounds=CGRectMake(0,0,60,20);tip.hidden=kind!=1;
                UIView *button=[UIView new];button.frame=tip.bounds;button.bounds=tip.bounds;[tip addSubview:button];[v addSubview:tip];
            }
            if (kind==2 || kind==3) {
                transcript.frame=CGRectMake(10,body+4,180,kind==3 ? 63 : 29);transcript.bounds=CGRectMake(0,0,180,transcript.frame.size.height);
                [v.container addSubview:transcript];
            }
            if (named) { v->m_chatRoomNameLabel=[UIView new];v->m_chatRoomNameLabel.frame=CGRectMake(50,0,160,14);
                v->m_chatRoomNameLabel.bounds=CGRectMake(0,0,160,14);[v addSubview:v->m_chatRoomNameLabel]; }
            TestTableCell *cell=[TestTableCell new];cell.cellView=v;cells[path]=cell;[views addObject:v];CSMessageMergeBind(page,table,path,cell);
        }
        table.testCells=cells;table.indexPathsForVisibleRows=paths;table.testHeights=heights;
        NSUInteger requests=info.requests,scans=0;
        for (NSUInteger pass=0;pass<12;pass++) {
            table.dragging=pass<4;table.decelerating=pass>=4 && pass<8;
            for (NSUInteger i=0;i<order.count;i++) {
                NativeHierarchyCellView *v=views[i];NSUInteger kind=[order[i] unsignedIntegerValue];
                if (pass==1 || pass==3) { ((YYAsyncImageView *)v.content).highlighted=pass==3;Display((id)v.content); }
                if (kind==1) {
                    VoiceMessageViewModel *m=(id)v.viewModel;m.bShowingQuickTranTips=pass%3!=0;
                    ((UIView *)tips[i]).hidden=!m.bShowingQuickTranTips;
                    ((VoiceMessageCellView *)v)->m_unreadImageView.hidden=outgoing || pass>=5;
                }
            }
            CSMessageMergeInvalidateLayout(page);CSMessageMergeWillMutate(page);CSMessageMergeDidMutate(page);
            for (NSUInteger i=0;i<order.count;i++) {
                NativeHierarchyCellView *v=views[i];CSMessageMergePrepare(page,table,paths[i]);CSMessageMergeRender(v);
                CHECK(CSMessageMergeRowHeight(page,table,paths[i],[nativeHeights[i] doubleValue])==[heights[i] doubleValue]);
                CHECK(v.viewModel.resetCount==1); // Only initial preparation; side-button toggles do not invalidate cached height.
                if (i) {
                    NativeHierarchyCellView *prev=views[i-1];NSUInteger pk=[order[i-1] unsignedIntegerValue];
                    UIView *last=(pk==2 || pk==3) ? transcripts[i-1] : prev.content;
                    CGFloat end=prev.frame.origin.y+CGRectGetMaxY([prev convertRect:last.bounds fromView:last])-((pk==2 || pk==3) ? 0 : bottom);
                    CGFloat start=v.frame.origin.y+CGRectGetMinY([v convertRect:v.content.bounds fromView:v.content])+top;
                    CHECK(fabs([heights[i-1] doubleValue]+start-end-2)<.01);
                }
                if ([order[i] unsignedIntegerValue]==3) {
                    UIView *transcript=transcripts[i];CHECK(transcript.frame.origin.y-CGRectGetMaxY(v.content.frame)==4);
                    CHECK(v.viewModel.contentViewSize.height==body+67); // Already includes transcript; never double-count it.
                }
            }
            CSMessageMergeFlush(page);CHECK(table.updateCount==0);CHECK(info.requests==requests);
            if (pass==3) scans=CSBubbleNativePaddingScanCount;
            if (pass>3) CHECK(scans==CSBubbleNativePaddingScanCount);
        }
        // Real transcription changes replace the first-pass plan at native height
        // measurement. No extra rich-text size query or delayed tightening is needed.
        NSUInteger expandedIndex=[order indexOfObject:@3];NativeHierarchyCellView *expanded=views[expandedIndex];
        VoiceMessageViewModel *expandedModel=(id)expanded.viewModel;UIView *transcript=transcripts[expandedIndex];
        CGFloat initialHeight=[heights[expandedIndex] doubleValue],initialNative=[nativeHeights[expandedIndex] doubleValue];
        for (NSUInteger change=0;change<3;change++) {
            BOOL collapsed=change==1;CGFloat extra=change==0 ? 31 : 0;
            expandedModel.canShowTranslateText=!collapsed;expandedModel.contentViewSize=CGSizeMake(180,body+(collapsed ? 0 : 67+extra));
            CGFloat native=initialNative+(collapsed ? -67 : extra);
            CGFloat expected=initialHeight+(collapsed ? -67-(expandedIndex==order.count-1 ? 0 : bottom) : extra);
            CGFloat measured=CSMessageMergeRowHeight(page,table,paths[expandedIndex],native);CHECK(measured==expected);
            transcript.hidden=collapsed;CGRect frame=transcript.frame;frame.size.height=63+extra;transcript.frame=frame;transcript.bounds=CGRectMake(0,0,180,63+extra);
            expanded.frame=CGRectMake(0,0,320,measured);expanded.bounds=CGRectMake(0,0,320,measured);
            NSMutableArray *current=[heights mutableCopy];current[expandedIndex]=@(measured);table.testHeights=current;
            for (NSUInteger pass=0;pass<3;pass++) {
                CSMessageMergeRender(expanded);CSMessageMergeInvalidateLayout(page);CSMessageMergePrepare(page,table,paths[expandedIndex]);
                CHECK(CSMessageMergeRowHeight(page,table,paths[expandedIndex],native)==measured);
                CSMessageMergeFlush(page);CHECK(table.updateCount==0);
                if (expandedIndex+1<order.count) {
                    NativeHierarchyCellView *next=views[expandedIndex+1];UIView *last=collapsed ? expanded.content : transcript;
                    CGFloat end=expanded.frame.origin.y+CGRectGetMaxY([expanded convertRect:last.bounds fromView:last])-(collapsed ? bottom : 0);
                    CGFloat start=next.frame.origin.y+CGRectGetMinY([next convertRect:next.content.bounds fromView:next.content])+top;
                    CHECK(fabs(measured+start-end-2)<.01);
                }
            }
        }
        table.testHeights=heights;
        // Real button overflow still expands, and hiding it cannot shrink the row later.
        NSUInteger index=[order indexOfObject:@1];UIView *tip=tips[index];NativeHierarchyCellView *v=views[index];
        tip.hidden=NO;CGRect frame=tip.frame;frame.origin.y=-3;tip.frame=frame;
        CSMessageMergeRender(v);CGFloat safe=CSMessageMergeRowHeight(page,table,paths[index],[nativeHeights[index] doubleValue]);
        CHECK(safe>[heights[index] doubleValue]);
        tip.hidden=YES;
        for (NSUInteger pass=0;pass<3;pass++) { CSMessageMergeRender(v);CHECK(CSMessageMergeRowHeight(page,table,paths[index],[nativeHeights[index] doubleValue])==safe); }
        for (TestCellView *cell in views) { CSMessageMergeReuse(cell);CSBubbleStyleDetach(cell);CHECK(cell.frame.origin.y==0); }
        CSMessageMergeDeactivate(page);
    }
    return scenarios;
}

int main(int argc, const char *argv[]) { @autoreleasepool {
    if (argc==2 && !strcmp(argv[1],"--voice-animation-core")) {
        NSUInteger scenarios=VerifyVoiceTransTextNativeCompletion();
        printf("PASS: %lu core native completion scenarios; %u checks\n",(unsigned long)scenarios,checks);
        return 0;
    }
    if (argc!=1) { fprintf(stderr,"Usage: %s [--voice-animation-core]\n",argv[0]);return 2; }
    VerifyDynamicNamedBubbleSeams();
    NSUInteger voiceTransTextScenarios=VerifyVoiceTransTextSeams();
    printf("PASS: %lu sent speech-to-text mixed seam/fallback/rebind scenarios\n",(unsigned long)voiceTransTextScenarios);
    NSUInteger animationScenarios=VerifyVoiceTransTextAnimationSeams()+VerifyVoiceTransTextAnimationBoundaries()+VerifyVoiceTransTextNativeCompletion();
    printf("PASS: %lu sent speech-to-text animation/deferred-flush scenarios\n",(unsigned long)animationScenarios);
    NSUInteger translationScenarios=VerifyVoiceTranslationSeams();
    ConfigureIntegration(NO,2);
    // Regression: a 38pt body exactly fits the native fixed caps. Requiring an
    // extra 1/scale here incorrectly freezes text/voice rows at native spacing.
    for (NSUInteger scale=1;scale<=3;scale++) {
        BubbleInfo *info=[BubbleInfo new];info.normal=NativeCapsTemplate(scale,1,3);info.pressed=NativeCapsTemplate(scale,0,2);
        info.darkNormal=NativeCapsTemplate(scale,2,4);info.darkPressed=NativeCapsTemplate(scale,1,3);
        TextMessageViewModel *m=model(19000+(unsigned)scale);m.bgBubbleInfo=info;
        UIImageView *bg=[UIImageView new];UIEdgeInsets modelInsets,visibleInsets;
        for (NSUInteger dark=0;dark<2;dark++) {
            bg.traitCollection.userInterfaceStyle=dark ? UIUserInterfaceStyleDark : UIUserInterfaceStyleLight;
            bg.image=dark ? info.darkNormal : info.normal;bg.highlightedImage=dark ? info.darkPressed : info.pressed;
            bg.frame=CGRectMake(0,0,45,38);
            CHECK(CSBubbleStyleModelInsets(m,bg,bg.frame.size,&modelInsets));
            CHECK(CSBubbleStyleVisibleInsets(bg,&visibleInsets));
            CHECK(modelInsets.top==(dark ? 1 : 0) && modelInsets.bottom==(dark ? 3 : 2));
            CHECK(visibleInsets.top==modelInsets.top && visibleInsets.bottom==modelInsets.bottom);
            CHECK(CSBubbleStyleModelInsets(m,bg,CGSizeMake(0,38),&modelInsets)); // Width measured separately by native text layout.
            bg.frame=CGRectMake(0,0,45,37.99);
            CHECK(!CSBubbleStyleModelInsets(m,bg,bg.frame.size,&modelInsets));CHECK(!CSBubbleStyleVisibleInsets(bg,&visibleInsets));
            bg.frame=CGRectMake(0,0,44.99,38);
            CHECK(!CSBubbleStyleModelInsets(m,bg,bg.frame.size,&modelInsets));CHECK(!CSBubbleStyleVisibleInsets(bg,&visibleInsets));
            bg.frame=CGRectMake(0,0,45.01,38.01);
            CHECK(CSBubbleStyleModelInsets(m,bg,bg.frame.size,&modelInsets));CHECK(CSBubbleStyleVisibleInsets(bg,&visibleInsets));
        }
    }
    // A custom template fits actual font-derived short bodies, including alpha
    // padding; native 30+8 caps must not veto the replacement renderer's fit.
    ConfigureIntegration(YES,2);
    for (NSUInteger scale=1;scale<=3;scale++) {
        BubbleInfo *info=[BubbleInfo new];info.normal=NativeCapsTemplate(scale,1,3);info.pressed=info.normal;
        TextMessageViewModel *m=model(19500+(unsigned)scale);m.bgBubbleInfo=info;
        UIView *appearance=[UIView new];UIEdgeInsets padding;
        CHECK(CSBubbleStyleModelInsets(m,appearance,CGSizeMake(60,37),&padding));
        CHECK(padding.top==1 && padding.bottom==3);
        CHECK(!CSBubbleStyleModelInsets(m,appearance,CGSizeMake(60,5),&padding));
    }
    NSUInteger scenarios=translationScenarios+voiceTransTextScenarios+animationScenarios;
    for (NSUInteger heightCase=0;heightCase<2;heightCase++)
    for (NSUInteger templateKind=0;templateKind<3;templateKind++)
    for (NSUInteger style=0;style<2;style++) for (NSUInteger dark=0;dark<2;dark++)
    for (NSUInteger scale=1;scale<=3;scale++) for (NSUInteger outgoing=0;outgoing<2;outgoing++)
    for (NSString *session in @[@"alice",@"group@chatroom"]) for (NSUInteger avatar=1;avatar<=2;avatar++)
    for (NSUInteger quote=0;quote<2;quote++)
    for (NSUInteger voicePattern=0;voicePattern<(templateKind==2 ? (quote ? 3 : 7) : 1);voicePattern++) {
        ConfigureIntegration(style,avatar);scenarios++;
        // Each independent scenario starts with an empty bounded image cache.
        // Check steady scrolling without eviction from hundreds of earlier fixtures.
        [NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidReceiveMemoryWarningNotification object:nil];
        UIImage *(*makeTemplate)(CGFloat,CGFloat,CGFloat)=templateKind ? NativeCapsTemplate : Template;
        CGFloat bodyHeight=heightCase ? 37 : 38;
        BubbleInfo *info=[BubbleInfo new];info.normal=makeTemplate(scale,heightCase ? 0 : 1,heightCase ? 0 : 3);info.pressed=info.normal;
        info.darkNormal=makeTemplate(scale,heightCase ? 0 : 2,heightCase ? 0 : 4);info.darkPressed=info.darkNormal;
        CGFloat top=heightCase ? 0 : (dark ? 2 : 1),bottom=heightCase ? 0 : (dark ? 4 : 3);
        TestController *page=[TestController new];page.session=session;page.nodes=[NSMutableArray array];
        UIWindow *window=[UIWindow new];UITableView *table=[UITableView new];page.table=table;page.view=table;table.window=window;
        table.bounds=CGRectMake(0,0,320,600);table.traitCollection.userInterfaceStyle=dark ? UIUserInterfaceStyleDark : UIUserInterfaceStyleLight;
        NSMutableArray *views=[NSMutableArray array],*paths=[NSMutableArray array],*heights=[NSMutableArray array],*nativeHeights=[NSMutableArray array];
        NSMutableDictionary *cells=[NSMutableDictionary dictionary];
        for (NSUInteger i=0;i<3;i++) {
            const NSUInteger quotePatterns[]={1,4,5};
            NSUInteger voiceMask=templateKind==2 ? (quote ? quotePatterns[voicePattern] : voicePattern+1) : 0;
            BOOL voice=(voiceMask & (1UL<<i))!=0;
            TextMessageViewModel *m=voice ? [VoiceMessageViewModel new] : [TextMessageViewModel new];
            m.messageWrap=model(20000+(unsigned)i).messageWrap;m.contentViewSize=CGSizeMake(0,bodyHeight);m.isSender=outgoing;
            m.messageWrap.m_nsFromUsr=session;m.bgBubbleInfo=info;m.messageWrap.m_uiMessageType=voice ? 34 : 1;
            if (quote && i==1) { m.messageWrap.m_uiMessageType=49;m.messageWrap.m_uiAppMsgInnerType=57;
                m.canShowReplyMessage=YES;m.replyTextSize=CGSizeMake(160,24);m.replyTextInset=UIEdgeInsetsMake(2,0,3,0); }
            [page.nodes addObject:m];
        }
        CSMessageMergeActivate(page);
        for (NSUInteger i=0;i<3;i++) {
            TextMessageViewModel *m=page.nodes[i];BOOL identity=avatar==2 ? i==0 : i==2;
            BOOL named=identity && !outgoing && [session hasSuffix:@"@chatroom"];
            CGFloat y=named ? 17 : 8,extra=quote && i==1 ? 33 : 0,native=(named ? 29 : 17)+bodyHeight+extra;
            NSIndexPath *path=[NSIndexPath indexPathForRow:0 inSection:i];[paths addObject:path];
            CSMessageMergePrepare(page,table,path);CGFloat height=CSMessageMergeRowHeight(page,table,path,native);
            CHECK(height<native || (named && i==2)); // Compact before display; keep the last-row nickname footprint.
            [heights addObject:@(height)];[nativeHeights addObject:@(native)];
            BOOL voice=[m isKindOfClass:VoiceMessageViewModel.class];
            NativeHierarchyCellView *v=voice ? [VoiceMessageCellView new] : [NativeHierarchyCellView new];
            v.viewModel=m;v.frame=CGRectMake(0,0,320,height);v.bounds=v.frame;
            v.container=[UIView new];v.container.frame=CGRectMake(40,y,240,native-y);v.container.bounds=CGRectMake(0,0,240,native-y);[v addSubview:v.container];
            v.traitCollection.userInterfaceStyle=table.traitCollection.userInterfaceStyle;
            v.head=[UIView new];v.head.frame=CGRectMake(outgoing ? 282 : 0,5,38,38);v.head.bounds=CGRectMake(0,0,38,38);[v addSubview:v.head];
            YYAsyncImageView *bg=[YYAsyncImageView new];bg.frame=CGRectMake(10,0,180,bodyHeight);bg.bounds=CGRectMake(0,0,180,bodyHeight);
            bg.traitCollection.userInterfaceStyle=v.traitCollection.userInterfaceStyle;
            bg.image=[ForbiddenYYImage deferredImageWithUIImage:dark ? info.darkNormal : info.normal];
            bg.highlightedImage=[ForbiddenYYImage deferredImageWithUIImage:dark ? info.darkPressed : info.pressed];
            v.content=bg;[v.container addSubview:bg];
            if (voice) {
                VoiceMessageCellView *voiceCell=(id)v;
                // Native 8.0.78: outgoing VoicePlayingView mirrors horizontally.
                // Playback frames animate inside this view without changing its bounds.
                UIView *glyph=[UIView new];glyph.frame=CGRectMake(outgoing ? 158 : 18,(bodyHeight-24)/2,24,24);
                glyph.bounds=CGRectMake(0,0,24,24);glyph.transform=CGAffineTransformMakeScale(outgoing ? -1 : 1,1);
                voiceCell->m_playingImageView=glyph;[v.container addSubview:glyph];
                UIView *duration=[UIView new];duration.frame=CGRectMake(outgoing ? 130 : 44,(bodyHeight-20)/2,26,20);
                duration.bounds=CGRectMake(0,0,26,20);voiceCell->m_secLabel=duration;[v.container addSubview:duration];
                UIView *unread=[UIView new];unread.frame=CGRectMake(202,(bodyHeight-8)/2,8,8);unread.bounds=CGRectMake(0,0,8,8);
                unread.hidden=outgoing;voiceCell->m_unreadImageView=unread;[v.container addSubview:unread];
            }
            if (named) { v->m_chatRoomNameLabel=[UIView new];v->m_chatRoomNameLabel.frame=CGRectMake(50,0,160,14);
                v->m_chatRoomNameLabel.bounds=CGRectMake(0,0,160,14);[v addSubview:v->m_chatRoomNameLabel]; }
            if (extra) { UIView *reply=[UIView new];reply.frame=CGRectMake(10,bodyHeight+4,160,29);reply.bounds=CGRectMake(0,0,160,29);[v.container addSubview:reply]; }
            TestTableCell *cell=[TestTableCell new];cell.cellView=v;cells[path]=cell;[views addObject:v];
            CSMessageMergeBind(page,table,path,cell);
        }
        table.testCells=cells;table.testHeights=heights;table.indexPathsForVisibleRows=paths;
        NSUInteger requests=info.requests,scans=0,resets=((TextMessageViewModel *)page.nodes[1]).resetCount;
        CHECK(requests==(style ? 12 : 6)); // Two per plan and per initial styled binding, never per frame.
        for (NSUInteger pass=0;pass<16;pass++) {
            table.dragging=pass<5;table.decelerating=pass>=5 && pass<10;
            if (pass==1 || pass==3) for (TestCellView *v in views) {
                YYAsyncImageView *bg=(id)v.content;bg.highlighted=pass==3;Display(bg);
            }
            CSMessageMergeInvalidateLayout(page);CSMessageMergeWillMutate(page);
            for (TextMessageViewModel *m in page.nodes) [m resetLayoutCache];
            CSMessageMergeDidMutate(page);
            for (NSUInteger i=0;i<3;i++) {
                TestCellView *v=views[i];CSMessageMergeRender(v);
                if ([v isKindOfClass:VoiceMessageCellView.class]) {
                    VoiceMessageCellView *voice=(id)v;
                    CHECK(CGAffineTransformEqualToTransform(voice->m_playingImageView.transform,CGAffineTransformMakeScale(outgoing ? -1 : 1,1)));
                    CHECK(voice->m_playingImageView.bounds.size.height==24);
                    // Unread -> read does not change the voice row's seam or height.
                    if (pass==7) voice->m_unreadImageView.hidden=YES;
                }
                if (style && pass>=4) {
                    UIEdgeInsets ready;CHECK(CSBubbleStyleVisibleInsets(v.content,&ready));
                    CHECK(ready.top==top && ready.bottom==bottom);
                    CHECK(![((YYAsyncImageView *)v.content)->m_image isKindOfClass:ForbiddenYYImage.class]);
                }
                CGFloat height=CSMessageMergeRowHeight(page,table,paths[i],[nativeHeights[i] doubleValue]);
                CHECK(height==[heights[i] doubleValue]);
                if (!v.head.hidden) {
                    CGFloat headY=v.frame.origin.y+v.head.frame.origin.y;
                    CHECK(headY>=0 && headY+38<=height+.01);
                }
                if (i) {
                    TestCellView *previous=views[i-1];BOOL previousQuoted=quote && i==2;
                    CGFloat previousBottom=previous.frame.origin.y+CGRectGetMinY([previous convertRect:previous.content.bounds fromView:previous.content])+bodyHeight+(previousQuoted ? 33 : -bottom);
                    CGFloat currentTop=v.frame.origin.y+CGRectGetMinY([v convertRect:v.content.bounds fromView:v.content])+top;
                    BOOL named=!outgoing && [session hasSuffix:@"@chatroom"] && avatar==1 && i==2;
                    CGFloat gap=[heights[i-1] doubleValue]+currentTop-previousBottom;
                    CHECK(fabs(gap-(named ? 18+top : 2))<.01);
                }
            }
            CSMessageMergeFlush(page);CHECK(table.updateCount==0);CHECK(info.requests==requests);
            if (pass==4) scans=CSBubbleNativePaddingScanCount;
            if (pass>4 && scans!=CSBubbleNativePaddingScanCount)
                fprintf(stderr,"Unexpected scan: fixture=%lu style=%lu dark=%lu scale=%lu outgoing=%lu session=%s avatar=%lu quote=%lu pass=%lu before=%lu after=%lu\n",(unsigned long)templateKind,(unsigned long)style,(unsigned long)dark,(unsigned long)scale,(unsigned long)outgoing,session.UTF8String,(unsigned long)avatar,(unsigned long)quote,(unsigned long)pass,(unsigned long)scans,(unsigned long)CSBubbleNativePaddingScanCount);
            if (pass>4) CHECK(scans==CSBubbleNativePaddingScanCount);
        }
        CHECK(((TextMessageViewModel *)page.nodes[1]).resetCount==resets+16); // Only simulated native resets.
        for (TestCellView *v in views) { CSMessageMergeReuse(v);CSBubbleStyleDetach(v);CHECK(v.frame.origin.y==0); }
        CSMessageMergeDeactivate(page);
    }
    // The existing merge range includes voice, photos, videos and stickers. Each
    // keeps the same joins while committing its measured container before display.
    for (Class cls in @[VoiceMessageViewModel.class,ImageMessageViewModel.class,VideoMessageViewModel.class,EmoticonMessageViewModel.class]) {
        ConfigureIntegration(YES,2);
        TestController *page=[TestController new];page.session=@"alice";page.nodes=[NSMutableArray array];
        UIWindow *window=[UIWindow new];UITableView *table=[UITableView new];table.window=window;page.table=table;page.view=table;
        table.bounds=CGRectMake(0,0,320,600);
        BubbleInfo *info=[BubbleInfo new];info.normal=Template(3,0,0);info.pressed=info.normal;
        for (NSUInteger i=0;i<4;i++) {
            TextMessageViewModel *m=[cls new];m.messageWrap=model(22000+(unsigned)i).messageWrap;m.messageWrap.m_nsFromUsr=@"alice";
            m.contentViewSize=CGSizeMake(180,80);m.bgBubbleInfo=info;
            m.messageWrap.m_uiMessageType=cls==VoiceMessageViewModel.class ? 34 : 3;[page.nodes addObject:m];
        }
        CSMessageMergeActivate(page);
        for (NSUInteger i=0;i<4;i++) {
            NSIndexPath *path=[NSIndexPath indexPathForRow:0 inSection:i];CSMessageMergePrepare(page,table,path);
            CGFloat expected=i==0 ? 89 : (i==3 ? 90 : 82);
            CHECK(CSMessageMergeRowHeight(page,table,path,97)==expected);
            TestCellView *v=[TestCellView new];v.viewModel=page.nodes[i];v.frame=CGRectMake(0,0,320,expected);v.bounds=v.frame;
            UIImageView *bg=[UIImageView new];bg.image=info.normal;bg.frame=CGRectMake(50,8,180,80);bg.bounds=CGRectMake(0,0,180,80);
            v.content=bg;[v addSubview:bg];TestTableCell *cell=[TestTableCell new];cell.cellView=v;CSMessageMergeBind(page,table,path,cell);
            for (NSUInteger j=0;j<100;j++) {
                CSMessageMergeRender(v);CSMessageMergeResetGeometry(v.viewModel);
                CHECK(CSMessageMergeRowHeight(page,table,path,97)==expected);CHECK(v.frame.origin.y==(i ? -7 : 0));
            }
            CSMessageMergeReuse(v);CSBubbleStyleDetach(v);
        }
        CSMessageMergeDeactivate(page);
    }
    // Missing BubbleInfo at first measurement: styling retries when it appears,
    // but a displayed native fallback must not become a late compact row.
    ConfigureIntegration(YES,2);
    TestController *page=[TestController new];page.session=@"alice";
    page.nodes=[NSMutableArray arrayWithArray:@[model(23001),model(23002),model(23003)]];
    for (TextMessageViewModel *m in page.nodes) { m.messageWrap.m_nsFromUsr=@"alice";m.messageWrap.m_uiMessageType=1;m.contentViewSize=CGSizeMake(0,38); }
    UIWindow *window=[UIWindow new];UITableView *table=[UITableView new];table.window=window;page.table=table;page.view=table;
    table.bounds=CGRectMake(0,0,320,600);NSIndexPath *path=[NSIndexPath indexPathForRow:0 inSection:1];
    CSMessageMergeActivate(page);CSMessageMergePrepare(page,table,path);CHECK(CSMessageMergeRowHeight(page,table,path,55)==55);
    TestCellView *v=[TestCellView new];v.viewModel=page.nodes[1];v.frame=CGRectMake(0,0,320,55);v.bounds=v.frame;
    YYAsyncImageView *bg=[YYAsyncImageView new];bg.frame=CGRectMake(50,8,180,38);bg.bounds=CGRectMake(0,0,180,38);
    UIImage *normal=Template(2,1,3);YYImage *native=[YYImage imageWithUIImage:normal];bg.image=native;v.content=bg;[v addSubview:bg];
    TestTableCell *cell=[TestTableCell new];cell.cellView=v;table.testCells=@{path:cell};table.indexPathsForVisibleRows=@[path];table.testHeights=@[@55,@55,@55];
    CSMessageMergeBind(page,table,path,cell);CSMessageMergeRender(v);CHECK(bg->m_image==native);
    BubbleInfo *info=[BubbleInfo new];info.normal=normal;info.pressed=normal;v.viewModel.bgBubbleInfo=info;
    CSBubbleStyleApply(v);CHECK(bg->m_image!=native); // Recovers without NativeChanged.
    for (NSUInteger i=0;i<500;i++) {
        CSMessageMergeInvalidateLayout(page);CSMessageMergeWillMutate(page);CSMessageMergeDidMutate(page);
        CSMessageMergePrepare(page,table,path);CSMessageMergeRender(v);CSMessageMergeFlush(page);
        CHECK(CSMessageMergeRowHeight(page,table,path,55)==55);CHECK(v.frame.origin.y==0);CHECK(table.updateCount==0);
    }
    // An actual width change allows a fresh plan; then transient native cache
    // emptiness must not invalidate that new compact result during a reload.
    table.bounds=CGRectMake(0,0,400,600);CHECK(CSMessageMergeRowHeight(page,table,path,55)==36);
    NSUInteger resets=v.viewModel.resetCount;
    v.viewModel.contentViewSize=CGSizeZero;CSMessageMergeInvalidateLayout(page);CSMessageMergePrepare(page,table,path);
    v.viewModel.contentViewSize=CGSizeMake(0,38);CHECK(CSMessageMergeRowHeight(page,table,path,55)==36);CHECK(v.viewModel.resetCount==resets);
    // Theme-specific insets prefer decoded dark pixels even when a light origin exists.
    YYImage *dynamic=[YYImage imageWithUIImage:normal];dynamic.decodeImageDM=Template(2,4,6);
    UIImageView *metric=[UIImageView new];metric.image=dynamic;metric.frame=CGRectMake(0,0,180,100);
    metric.traitCollection.userInterfaceStyle=UIUserInterfaceStyleDark;UIEdgeInsets insets;
    CHECK(CSBubbleStyleVisibleInsets(metric,&insets));CHECK(insets.top==4 && insets.bottom==6);
    // Model metadata changing in place must restore unsupported content and recover.
    v.viewModel.messageWrap.m_uiMessageType=3;CSBubbleStyleApply(v);CHECK(bg->m_image==native);
    v.viewModel.messageWrap.m_uiMessageType=1;CSBubbleStyleApply(v);CHECK(bg->m_image!=native);
    CSMessageMergeReuse(v);CSBubbleStyleDetach(v);CSMessageMergeDeactivate(page);
    printf("PASS: %lu seam combinations, four media types, late metadata/theme/fallback; %u checks; no post-display shrink, no no-op row transactions, bounded template scans\n",(unsigned long)scenarios,checks);
} return 0; }
