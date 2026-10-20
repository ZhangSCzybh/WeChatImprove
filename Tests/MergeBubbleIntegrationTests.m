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
            v.head=[UIView new];v.head.frame=CGRectMake(outgoing ? 282 : 0,named ? 3 : 8,38,38);v.head.bounds=CGRectMake(0,0,38,38);[v addSubview:v.head];
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

int main(void) { @autoreleasepool {
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
    NSUInteger scenarios=translationScenarios;
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
            v.head=[UIView new];v.head.frame=CGRectMake(outgoing ? 282 : 0,named ? 3 : 8,38,38);v.head.bounds=CGRectMake(0,0,38,38);[v addSubview:v.head];
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
