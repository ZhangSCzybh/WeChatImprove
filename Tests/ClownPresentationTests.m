#import "ClownPresentationNativeDouble.h"
#import "CSClownPreferences.h"
#import "CSClownMenuAdapter.h"
#import <objc/runtime.h>
#include <math.h>
#include <stdlib.h>

// Compile the production file unchanged. Its private session/request types remain
// visible to fixtures; assertions exercise production entry points and real UIKit.
#import "../Controllers/CSClownPresentation.m"

static NSUInteger checks;
static CSClownPreferences *ClownTestPreferences;
static NSUserDefaults *ClownTestDefaults;
#define CHECK(...) do { checks++; if (!(__VA_ARGS__)) { fprintf(stderr,"FAIL line %d: %s\n",__LINE__,#__VA_ARGS__); exit(1); } } while (0)
static id TestSharedPreferences(id self, SEL selector) { (void)self; (void)selector; return ClownTestPreferences; }

@interface ClownBeganPress : UILongPressGestureRecognizer @end
@implementation ClownBeganPress
- (UIGestureRecognizerState)state { return UIGestureRecognizerStateBegan; }
@end
@interface ClownPresentationTouch : UITouch
@property(nonatomic, strong) UIView *testView;
@property(nonatomic) CGPoint testPoint;
@end
@implementation ClownPresentationTouch
- (UIView *)view { return self.testView; }
- (CGPoint)locationInView:(UIView *)view { (void)view; return self.testPoint; }
@end
@interface ClownDelayedPhotoProvider : NSItemProvider
@property(nonatomic, copy) void (^testCompletion)(__kindof id<NSItemProviderReading>, NSError *);
@end
@implementation ClownDelayedPhotoProvider
- (BOOL)canLoadObjectOfClass:(Class<NSItemProviderReading>)aClass { return aClass==UIImage.class; }
- (NSProgress *)loadObjectOfClass:(Class<NSItemProviderReading>)aClass completionHandler:(void (^)(__kindof id<NSItemProviderReading>, NSError *))completionHandler {
    CHECK(aClass==UIImage.class); self.testCompletion=completionHandler; return [NSProgress progressWithTotalUnitCount:1];
}
@end
@interface ClownPhotoResult : NSObject
@property(nonatomic, strong) NSItemProvider *itemProvider;
@end
@implementation ClownPhotoResult @end

static void Drain(void) {
    NSDate *deadline=[NSDate dateWithTimeIntervalSinceNow:.04];
    while (deadline.timeIntervalSinceNow>0) [NSRunLoop.currentRunLoop runMode:NSDefaultRunLoopMode beforeDate:deadline];
}
static void SetCapability(NSString *key, BOOL enabled) {
    [ClownTestDefaults setBool:enabled forKey:key]; [ClownTestPreferences requestRefresh]; Drain();
}
static UIImage *Image(CGSize size, UIColor *color) {
    UIGraphicsImageRenderer *renderer=[[UIGraphicsImageRenderer alloc] initWithSize:size];
    return [renderer imageWithActions:^(UIGraphicsImageRendererContext *context) { (void)context; [color setFill]; UIRectFill((CGRect){CGPointZero,size}); }];
}
static ClownPresentationModel *Model(NSUInteger type, NSUInteger identity, BOOL outgoing) {
    ClownPresentationWrap *wrap=[ClownPresentationWrap new]; wrap.m_nsFromUsr=outgoing ? @"me" : @"chat";
    wrap.m_nsToUsr=outgoing ? @"chat" : @"me"; wrap.m_uiMessageType=(unsigned int)type;
    wrap.m_uiMesLocalID=(unsigned int)identity; wrap.m_n64MesSvrID=(long long)identity+1000;
    wrap.m_nsContent=type==49 ? @"<msg><appmsg><type>2000</type><wcpayinfo><feedesc>¥1.00</feedesc><total_fee>100</total_fee></wcpayinfo></appmsg></msg>" : @"native message";
    wrap.m_uiCreateTime=1700000000; wrap.m_dtImg=[@"original image file bytes" dataUsingEncoding:NSUTF8StringEncoding];
    ClownPresentationModel *model=[ClownPresentationModel new]; model.messageWrap=wrap;
    model.contentTextSize=CGSizeMake(100,20); model.contentViewSize=CGSizeMake(124,40);
    model.thumbImageSize=type==3 ? CGSizeMake(100,70) : CGSizeZero;
    if (type==3) model.contentTextSize=CGSizeZero;
    model.contentTextFont=[UIFont systemFontOfSize:17]; model.contentTextColor=UIColor.blackColor;
    model.originContentText=wrap.m_nsContent; model.contentText=wrap.m_nsContent; model.nativeHeights=@[@80];
    return model;
}
static BaseMsgContentViewController *Controller(NSArray *nodes) {
    BaseMsgContentViewController *owner=[BaseMsgContentViewController new]; owner.testChat=@"chat"; owner.testNodes=nodes;
    owner.testViews=[NSMutableDictionary dictionary]; owner.view=[[UIView alloc] initWithFrame:CGRectMake(0,0,390,844)];
    ClownPresentationTable *table=[[ClownPresentationTable alloc] initWithFrame:owner.view.bounds style:UITableViewStylePlain];
    table.dataSource=owner; table.delegate=owner; table.estimatedRowHeight=0; table.estimatedSectionHeaderHeight=0; table.estimatedSectionFooterHeight=0;
    owner.testTable=table; [owner.view addSubview:table]; CSClownPageDidAppear(owner); return owner;
}
static ClownPresentationCell *TextCell(BaseMsgContentViewController *owner, id model) {
    ClownPresentationCell *cell=[[ClownPresentationCell alloc] initWithFrame:CGRectMake(0,0,390,80)];
    cell.testOwner=owner; cell.viewModel=model;
    cell.nativeContent=[[UIView alloc] initWithFrame:cell.bounds]; [cell addSubview:cell.nativeContent];
    cell.nativeBubble=[[UIImageView alloc] initWithFrame:CGRectMake(64,8,124,40)]; [cell.nativeContent addSubview:cell.nativeBubble];
    cell.nativeText=[[UILabel alloc] initWithFrame:CGRectMake(76,16,100,20)]; cell.nativeText.text=@"native message";
    cell.nativeText.font=[UIFont systemFontOfSize:17]; cell.nativeText.userInteractionEnabled=YES;
    cell.nativeText.layer.opacity=.87f; [cell.nativeContent addSubview:cell.nativeText];
    return cell;
}
static ImageMessageCellView *ImageCell(BaseMsgContentViewController *owner, ClownPresentationModel *model) {
    ImageMessageCellView *cell=[[ImageMessageCellView alloc] initWithFrame:CGRectMake(0,0,390,100)];
    cell.testOwner=owner; cell.viewModel=model;
    cell.nativeContent=[[UIView alloc] initWithFrame:cell.bounds]; [cell addSubview:cell.nativeContent];
    cell.nativeBubble=[[UIImageView alloc] initWithFrame:CGRectMake(60,6,108,78)]; [cell.nativeContent addSubview:cell.nativeBubble];
    cell->m_imageView=[[UIImageView alloc] initWithFrame:CGRectMake(64,10,100,70)];
    cell->m_imageView.image=Image(CGSizeMake(100,70),UIColor.redColor); [cell.nativeContent addSubview:cell->m_imageView];
    return cell;
}
static NSIndexPath *Path(NSInteger section, NSInteger row) { return [NSIndexPath indexPathForRow:row inSection:section]; }
static CGPoint Center(UIView *view) { return CGPointMake(CGRectGetMidX(view.frame),CGRectGetMidY(view.frame)); }
static CSClownEditRequest *TextRequest(ClownPresentationCell *cell) {
    CSClownEditRequest *request=CSClownCaptureEdit(cell,NO); CHECK(request && CSClownEditIsValid(request)); return request;
}

static void TestUIKitLayerOpacityHitTesting(void) {
    UIView *container=[[UIView alloc] initWithFrame:CGRectMake(0,0,200,80)];
    UILabel *source=[[UILabel alloc] initWithFrame:CGRectMake(20,20,100,30)];
    source.userInteractionEnabled=YES; source.text=@"native time"; [container addSubview:source];
    CGPoint point=Center(source);
    CHECK([container hitTest:point withEvent:nil]==source && source.alpha==1);
    source.layer.opacity=0;
    // Real UIKit shares UIView.alpha with the backing layer opacity; this removes native hit targets.
    CHECK(source.alpha==0 && [container hitTest:point withEvent:nil]==container);
    source.layer.opacity=1;
    CHECK(source.alpha==1 && [container hitTest:point withEvent:nil]==source);
}

static void TestTextOverlayAndRestore(void) {
    ClownPresentationModel *model=Model(1,1,NO); BaseMsgContentViewController *owner=Controller(@[model]);
    ClownPresentationCell *cell=TextCell(owner,model); owner.testViews[Path(0,0)]=cell;
    CGRect sourceFrame=cell.nativeText.frame, bubbleFrame=cell.nativeBubble.frame, contentFrame=cell.nativeContent.frame;
    NSString *native=model.messageWrap.m_nsContent; CGSize modelSize=model.contentTextSize;
    CALayer *originalMask=[CALayer layer]; originalMask.frame=cell.nativeText.bounds;
    originalMask.backgroundColor=UIColor.blackColor.CGColor; cell.nativeText.layer.mask=originalMask;
    CHECK([cell.nativeContent hitTest:Center(cell.nativeText) withEvent:nil]==cell.nativeText);
    CSClownEditRequest *request=TextRequest(cell);
    CSClownPerformEdit(request); UIAlertController *editor=(id)owner.testPresented;
    CHECK([editor isKindOfClass:UIAlertController.class] && [editor.title isEqual:@"修改文字"]);
    CHECK([editor.textFields.firstObject.text isEqual:native]);
    NSString *replacement=[@"long replacement message " stringByPaddingToLength:600 withString:@"more content " startingAtIndex:0];
    editor.textFields.firstObject.text=replacement; CHECK(ClownPresentationInvokeAction(editor,1));
    CSClownRenderCell(cell);
    CSClownCellState *state=objc_getAssociatedObject(cell,&CSClownCellKey);
    CHECK(state.active && [state.overlay isKindOfClass:UILabel.class]);
    UILabel *overlay=(id)state.overlay;
    CHECK([overlay.attributedText.string isEqual:replacement] && overlay.superview==cell.nativeText.superview);
    CHECK(!overlay.userInteractionEnabled && !overlay.hidden && cell.nativeText.userInteractionEnabled);
    CHECK(fabs(cell.nativeText.alpha-.87)<.0001 && cell.nativeText.accessibilityElementsHidden);
    CHECK([cell.nativeContent hitTest:Center(cell.nativeText) withEvent:nil]==cell.nativeText);
    CHECK(overlay.frame.size.height>sourceFrame.size.height && cell.nativeBubble.frame.size.height>bubbleFrame.size.height);
    CHECK(CSClownRowHeight(owner,owner.testTable,Path(0,0),80)>80);
    CHECK(model.messageWrap.m_nsContent==native && CGSizeEqualToSize(model.contentTextSize,modelSize));
    NSUInteger count=cell.nativeContent.subviews.count;
    CSClownRenderCell(cell); CSClownRenderCell(cell);
    CHECK(cell.nativeContent.subviews.count==count && state.overlay==overlay);
    CSClownRestoreCell(cell);
    CHECK(!state.active && overlay.hidden && fabs(cell.nativeText.layer.opacity-.87f)<.0001);
    CHECK(cell.nativeText.layer.mask==originalMask);
    CHECK(!cell.nativeText.accessibilityElementsHidden && CGRectEqualToRect(cell.nativeText.frame,sourceFrame));
    CHECK(CGRectEqualToRect(cell.nativeBubble.frame,bubbleFrame) && CGRectEqualToRect(cell.nativeContent.frame,contentFrame));
    CSClownRenderCell(cell);
    CALayer *updatedNativeMask=[CALayer layer]; updatedNativeMask.frame=cell.nativeText.bounds;
    updatedNativeMask.backgroundColor=UIColor.blackColor.CGColor;
    cell.nativeText.layer.mask=updatedNativeMask; CSClownRestoreCell(cell);
    CHECK(cell.nativeText.layer.mask==updatedNativeMask && fabs(cell.nativeText.alpha-.87)<.0001);
    CSClownRenderCell(cell); CSClownReuseCell(cell);
    CHECK(cell.nativeText.layer.mask==updatedNativeMask);
    CHECK(overlay.superview==nil && objc_getAssociatedObject(cell,&CSClownCellKey)==nil);
    cell.viewModel=Model(1,2,NO); CSClownRenderCell(cell);
    CHECK(cell.nativeText.layer.opacity>0 && objc_getAssociatedObject(cell,&CSClownCellKey)==nil);
    CSClownPageDidDisappear(owner); CHECK(!request.page.session.active);
}

static void TestOffscreenSplitAndCachedExit(void) {
    ClownPresentationModel *model=Model(1,3,NO); model.contentTextSize=CGSizeMake(240,900); model.nativeHeights=@[@500,@420];
    ClownPresentationSplit *first=[ClownPresentationSplit new], *second=[ClownPresentationSplit new];
    first.parentModel=model; second.parentModel=model; second.startHeight=500; model.subViewModels=@[first,second];
    BaseMsgContentViewController *owner=Controller(@[model]);
    ClownPresentationCell *cell=TextCell(owner,first), *continuation=TextCell(owner,second);
    CSClownEditRequest *request=TextRequest(cell); CHECK([request.page.session setText:@"short" forContext:request.context]);
    // No visible table cell is needed to calculate both row heights.
    CHECK(owner.testViews.count==0);
    CGFloat firstHeight=CSClownRowHeight(owner,owner.testTable,Path(0,0),500);
    CHECK(firstHeight>0 && firstHeight<100 && CSClownRowHeight(owner,owner.testTable,Path(0,1),420)<1);
    CSClownRenderCell(continuation);
    CHECK(((CSClownCellState *)objc_getAssociatedObject(continuation,&CSClownCellKey)).active);
    CHECK(CSClownRowHeight(owner,owner.testTable,Path(0,1),420)<1);
    CSClownReuseCell(continuation); CHECK(continuation.layer.opacity==1);
    CSClownRenderCell(cell); CHECK(fabs(cell.nativeText.alpha-.87)<.0001);
    [owner.testTable reloadData]; [owner.testTable layoutIfNeeded];
    CGFloat cached=[owner.testTable rectForRowAtIndexPath:Path(0,1)].size.height; CHECK(cached<1);
    NSUInteger reloads=owner.testTable.testReloadCount;
    CSClownPageDidDisappear(owner); CHECK(!request.page.session.active && cell.nativeText.layer.opacity>0);
    CSClownPageDidAppear(owner);
    CHECK(owner.testTable.testReloadCount>reloads);
    CHECK(CSClownRowHeight(owner,owner.testTable,Path(0,0),500)==500 && CSClownRowHeight(owner,owner.testTable,Path(0,1),420)==420);
    CHECK([owner.testTable rectForRowAtIndexPath:Path(0,1)].size.height==420);
    CHECK(model.messageWrap.m_uiCreateTime==1700000000 && model.subViewModels.count==2 && first.parentModel==model);
    CSClownEditRequest *again=TextRequest(cell); CHECK([again.page.session setText:@"short again" forContext:again.context]);
    [owner.testTable reloadData]; [owner.testTable layoutIfNeeded]; CHECK([owner.testTable rectForRowAtIndexPath:Path(0,1)].size.height<1);
    CSClownPageDidDisappear(owner); SetCapability(CSClownEnabledKey,NO);
    reloads=owner.testTable.testReloadCount; CSClownPageDidAppear(owner);
    CHECK(owner.testTable.testReloadCount>reloads && [owner.testTable rectForRowAtIndexPath:Path(0,1)].size.height==420);
    SetCapability(CSClownEnabledKey,YES);
}

static void TestImageOverlay(void) {
    ClownPresentationModel *model=Model(3,4,YES); model.nativeHeights=@[@100];
    BaseMsgContentViewController *owner=Controller(@[model]); ImageMessageCellView *cell=ImageCell(owner,model);
    CSClownEditRequest *request=CSClownCaptureEdit(cell,YES); CHECK(request && CSClownEditIsValid(request));
    cell->m_imageView.userInteractionEnabled=YES;
    UILongPressGestureRecognizer *nativePress=[[UILongPressGestureRecognizer alloc] initWithTarget:nil action:NULL];
    [cell->m_imageView addGestureRecognizer:nativePress];
    CHECK([cell.nativeContent hitTest:Center(cell->m_imageView) withEvent:nil]==cell->m_imageView);
    UIImage *replacement=Image(CGSizeMake(80,180),UIColor.blueColor), *original=cell->m_imageView.image;
    NSData *originalData=model.messageWrap.m_dtImg; CGRect frame=cell->m_imageView.frame;
    CHECK([request.page.session setImage:replacement forContext:request.context]); CSClownRenderCell(cell);
    CSClownCellState *state=objc_getAssociatedObject(cell,&CSClownCellKey);
    CHECK(state.active && [state.overlay isKindOfClass:UIImageView.class]);
    CHECK(((UIImageView *)state.overlay).image==replacement && cell->m_imageView.image==original && cell->m_imageView.alpha==1);
    CHECK([cell.nativeContent hitTest:Center(cell->m_imageView) withEvent:nil]==cell->m_imageView);
    CHECK([cell->m_imageView.gestureRecognizers containsObject:nativePress]);
    CHECK(CGSizeEqualToSize(state.overlay.frame.size,CGSizeMake(80,180)));
    CHECK(CSClownRowHeight(owner,owner.testTable,Path(0,0),100)==210);
    CHECK(model.messageWrap.m_dtImg==originalData && CGSizeEqualToSize(model.thumbImageSize,CGSizeMake(100,70)));
    // Native asynchronous thumbnail changes cannot overwrite the independent overlay.
    cell->m_imageView.image=Image(CGSizeMake(100,70),UIColor.greenColor);
    CHECK(((UIImageView *)state.overlay).image==replacement);
    CSClownReuseCell(cell); CHECK(state.overlay.superview==nil && CGRectEqualToRect(cell->m_imageView.frame,frame));
    CSClownPageDidDisappear(owner);
}

static void TestRetargetedControllerRestoresCachedHeights(void) {
    ClownPresentationModel *model=Model(1,40,NO); model.contentTextSize=CGSizeMake(240,900); model.nativeHeights=@[@500,@420];
    ClownPresentationSplit *first=[ClownPresentationSplit new], *second=[ClownPresentationSplit new];
    first.parentModel=model; second.parentModel=model; second.startHeight=500; model.subViewModels=@[first,second];
    BaseMsgContentViewController *owner=Controller(@[model]); ClownPresentationCell *cell=TextCell(owner,first);
    CSClownEditRequest *request=TextRequest(cell); CHECK([request.page.session setText:@"short" forContext:request.context]);
    [owner.testTable reloadData]; [owner.testTable layoutIfNeeded];
    CHECK([owner.testTable rectForRowAtIndexPath:Path(0,1)].size.height<1);
    NSUInteger reloads=owner.testTable.testReloadCount;
    // A retained native controller can report a changed conversation before a
    // separate native lifecycle notification; rejecting its session must reload.
    owner.testChat=@"another-chat"; CSClownPageDidAppear(owner);
    CHECK(!request.page.session.active && owner.testTable.testReloadCount>reloads);
    CHECK([owner.testTable rectForRowAtIndexPath:Path(0,1)].size.height==420);
    CSClownPageDidDisappear(owner);
}

static void TestTimeAndAmount(void) {
    ClownPresentationTimeModel *time=[ClownPresentationTimeModel new]; time.showingTime=1700000000; time.timeText=@"native time"; time.nativeHeights=@[@30];
    ClownPresentationModel *transfer=Model(49,5,NO); BaseMsgContentViewController *owner=Controller(@[time,transfer]);
    ChatTimeCellView *cell=[[ChatTimeCellView alloc] initWithFrame:CGRectMake(0,0,390,30)]; cell.testOwner=owner; cell.viewModel=time;
    cell.userInteractionEnabled=NO; cell->m_timeLabel=[[UILabel alloc] initWithFrame:CGRectMake(170,4,50,20)];
    cell->m_timeLabel.text=time.timeText; cell->m_timeLabel.font=[UIFont systemFontOfSize:12]; [cell addSubview:cell->m_timeLabel];
    CSClownBindTimeCell(cell); CHECK(cell.gestureRecognizers.count==1 && cell.userInteractionEnabled);
    CSClownPage *page=objc_getAssociatedObject(owner,&CSClownPageKey);
    NSDate *date=CSClownDateFromInput(@"2026-11-09 14:30"); CHECK([page.session setDate:date forTimeModel:time]); CSClownBindTimeCell(cell);
    CSClownCellState *timeState=objc_getAssociatedObject(cell,&CSClownCellKey);
    CHECK(timeState.active && [((UILabel *)timeState.overlay).text isEqual:CSClownDateDisplay(date)]);
    CHECK(cell->m_timeLabel.alpha==1 && [cell->m_timeLabel.text isEqual:@"native time"] && time.showingTime==1700000000);
    NSUInteger count=cell.subviews.count; CSClownBindTimeCell(cell); CHECK(cell.subviews.count==count && cell.gestureRecognizers.count==1);
    CSClownTimeTarget *target=objc_getAssociatedObject(cell,&CSClownTimeKey);
    ClownPresentationTouch *edge=[ClownPresentationTouch new]; edge.testView=cell;
    edge.testPoint=CGPointMake(CGRectGetMinX(timeState.overlay.frame)+1,CGRectGetMidY(timeState.overlay.frame));
    CHECK([target gestureRecognizer:target.gesture shouldReceiveTouch:edge]);
    cell.hidden=YES; CSClownBindTimeCell(cell); CHECK(!timeState.active && timeState.overlay.hidden); cell.hidden=NO;
    [target longPress:[[ClownBeganPress alloc] initWithTarget:nil action:NULL]];
    UIAlertController *timeEditor=(id)owner.testPresented;
    CHECK([timeEditor.title isEqual:@"修改时间"] && [timeEditor.textFields.firstObject.text isEqual:@"2026-11-09 14:30"]);
    timeEditor.textFields.firstObject.text=@"2026-02-30 00:00";
    [NSNotificationCenter.defaultCenter postNotificationName:UITextFieldTextDidChangeNotification object:timeEditor.textFields.firstObject];
    CHECK(!timeEditor.actions[1].enabled && !ClownPresentationInvokeAction(timeEditor,1));
    timeEditor.textFields.firstObject.text=@"2026-11-08 09:20";
    [NSNotificationCenter.defaultCenter postNotificationName:UITextFieldTextDidChangeNotification object:timeEditor.textFields.firstObject];
    CHECK(timeEditor.actions[1].enabled && ClownPresentationInvokeAction(timeEditor,1));
    CHECK([[page.session dateForTimeModel:time] isEqual:CSClownDateFromInput(@"2026-11-08 09:20")]);
    CHECK([time.timeText isEqual:@"native time"] && time.showingTime==1700000000);

    WCPayTransferMessageCellView *pay=[[WCPayTransferMessageCellView alloc] initWithFrame:CGRectMake(0,0,390,80)]; pay.testOwner=owner; pay.viewModel=transfer;
    pay->m_titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(64,8,280,24)]; pay->m_titleLabel.text=@"向张三转账 ¥1.00，附言周末";
    pay->m_titleLabel.font=[UIFont systemFontOfSize:17]; [pay addSubview:pay->m_titleLabel];
    NSString *original=transfer.messageWrap.m_nsContent; CSClownEditRequest *request=CSClownCaptureAmountEdit(pay);
    CHECK(request && CSClownEditIsValid(request)); CSClownPerformEdit(request);
    UIAlertController *alert=(id)owner.testPresented; CHECK([alert.title isEqual:@"修改金额"] && [alert.textFields.firstObject.text isEqual:@"1.00"]);
    alert.textFields.firstObject.text=@"88.80";
    [NSNotificationCenter.defaultCenter postNotificationName:UITextFieldTextDidChangeNotification object:alert.textFields.firstObject];
    CHECK(ClownPresentationInvokeAction(alert,1)); CSClownRenderCell(pay);
    CSClownCellState *payState=objc_getAssociatedObject(pay,&CSClownCellKey);
    CHECK(payState.active && [((UILabel *)payState.overlay).text isEqual:@"向张三转账 ¥88.80，附言周末"]);
    CHECK([pay->m_titleLabel.text isEqual:@"向张三转账 ¥1.00，附言周末"] && transfer.messageWrap.m_nsContent==original);
    NSArray *grouped=@[@"给你 ￥1,000.00（已收款）",@"向你转账 1,000.00元",@"¥1000.00"];
    NSArray *expected=@[@"给你 ￥88.80（已收款）",@"向你转账 88.80元",@"¥88.80"];
    for (NSUInteger index=0;index<grouped.count;index++) {
        CSClownRestoreCell(pay); pay->m_titleLabel.text=grouped[index]; CSClownRenderCell(pay);
        CHECK([((UILabel *)payState.overlay).text isEqual:expected[index]] && [pay->m_titleLabel.text isEqual:grouped[index]]);
    }
    CHECK([page.session setAmount:nil forContext:request.context]); CSClownRestoreCell(pay); pay->m_titleLabel.text=@"￥1,000.00";
    CSClownPerformEdit(CSClownCaptureAmountEdit(pay)); UIAlertController *groupedEditor=(id)owner.testPresented;
    CHECK([groupedEditor.textFields.firstObject.text isEqual:@"1000.00"]);
    CHECK(ClownPresentationInvokeAction(groupedEditor,0));
    CSClownPageDidDisappear(owner); CHECK(cell.gestureRecognizers.count==0 && !cell.userInteractionEnabled);
    CHECK(cell->m_timeLabel.layer.opacity==1);
    CHECK(pay->m_titleLabel.layer.opacity==1);
    CHECK(payState.overlay.superview==nil);
}

static void TestNativeTimeTapAndDisplayModes(void) {
    ClownPresentationTimeModel *time=[ClownPresentationTimeModel new];
    time.showingTime=1700000000; time.timeText=@"native model text"; time.nativeHeights=@[@30];
    ClownPresentationTimeModel *otherTime=[ClownPresentationTimeModel new];
    otherTime.showingTime=1700010000; otherTime.timeText=@"second native time"; otherTime.nativeHeights=@[@30];
    BaseMsgContentViewController *owner=Controller(@[time,otherTime]);
    ChatTimeCellView *cell=[[ChatTimeCellView alloc] initWithFrame:CGRectMake(0,0,390,30)];
    cell.testOwner=owner; cell.viewModel=time; owner.testViews[Path(0,0)]=cell;
    cell->m_timeLabel=[[UILabel alloc] initWithFrame:CGRectMake(170,4,50,20)];
    cell->m_timeLabel.font=[UIFont systemFontOfSize:12]; cell->m_timeLabel.alpha=.91;
    [cell addSubview:cell->m_timeLabel]; [cell installNativeTimeTap]; [cell renderNativeTime];
    CGRect nativeFrame=cell->m_timeLabel.frame;
    CALayer *nativeMask=[CALayer layer]; nativeMask.frame=cell->m_timeLabel.bounds;
    nativeMask.backgroundColor=UIColor.blackColor.CGColor; cell->m_timeLabel.layer.mask=nativeMask;
    NSString *nativeCompact=cell->m_timeLabel.text;
    CHECK([cell hitTest:Center(cell->m_timeLabel) withEvent:nil]==cell->m_timeLabel);
    CHECK(ClownPresentationTapNativeTime(cell,Center(cell->m_timeLabel)));
    CHECK(owner.timeDetailMode && owner.nativeTimeToggleCount==1 && owner.lastNativeTimeToggleTimestamp==1700000000);
    CHECK(![cell->m_timeLabel.text isEqual:nativeCompact]);
    CHECK(ClownPresentationTapNativeTime(cell,Center(cell->m_timeLabel)));
    CHECK(!owner.timeDetailMode && owner.nativeTimeToggleCount==2 && [cell->m_timeLabel.text isEqual:nativeCompact]);
    CSClownBindTimeCell(cell);
    CSClownPage *page=objc_getAssociatedObject(owner,&CSClownPageKey);
    NSDate *date=CSClownDateFromInput(@"2026-11-09 14:30");
    CHECK([page.session setDate:date forTimeModel:time]); CSClownBindTimeCell(cell);
    ChatTimeCellView *otherCell=[[ChatTimeCellView alloc] initWithFrame:CGRectMake(0,0,390,30)];
    otherCell.testOwner=owner; otherCell.viewModel=otherTime; owner.testViews[Path(1,0)]=otherCell;
    otherCell->m_timeLabel=[[UILabel alloc] initWithFrame:CGRectMake(170,4,50,20)];
    [otherCell addSubview:otherCell->m_timeLabel]; [otherCell installNativeTimeTap]; [otherCell renderNativeTime];
    CHECK([page.session setDate:CSClownDateFromInput(@"2026-11-08 09:20") forTimeModel:otherTime]);
    CSClownBindTimeCell(otherCell);
    CSClownCellState *otherState=objc_getAssociatedObject(otherCell,&CSClownCellKey);
    CHECK([((UILabel *)otherState.overlay).text isEqual:@"11月8日 09:20"]);
    CSClownCellState *state=objc_getAssociatedObject(cell,&CSClownCellKey);
    UILabel *overlay=(id)state.overlay;
    CHECK(state.active && [overlay.text isEqual:@"11月9日 14:30"]);
    CHECK(!overlay.userInteractionEnabled && fabs(cell->m_timeLabel.alpha-.91)<.0001);
    CHECK([cell->m_timeLabel.text isEqual:nativeCompact] && time.showingTime==1700000000 && [time.timeText isEqual:@"native model text"]);
    CSClownTimeTarget *target=objc_getAssociatedObject(cell,&CSClownTimeKey);
    CHECK(target && !target.gesture.cancelsTouchesInView && !target.gesture.delaysTouchesBegan && !target.gesture.delaysTouchesEnded);
    CHECK([target gestureRecognizer:target.gesture shouldRecognizeSimultaneouslyWithGestureRecognizer:cell.nativeTimeTap]);
    CHECK([cell->m_timeLabel.gestureRecognizers containsObject:cell.nativeTimeTap]);
    for (NSUInteger position=0;position<3;position++) {
        CGRect displayed=state.overlay.frame;
        CGPoint point=position==0 ? Center(state.overlay) : CGPointMake(position==1 ? CGRectGetMinX(displayed)+1 : CGRectGetMaxX(displayed)-1,CGRectGetMidY(displayed));
        CHECK([cell hitTest:point withEvent:nil]==cell->m_timeLabel);
        NSUInteger previous=owner.nativeTimeToggleCount;
        CHECK(ClownPresentationTapNativeTime(cell,point));
        // Mirrors hook order: native toggle runs first, then production reapplies only the local display.
        CSClownTimeDisplayModeDidChange(owner);
        CHECK(owner.nativeTimeToggleCount==previous+1 && owner.lastNativeTimeToggleTimestamp==1700000000);
        NSString *display=((UILabel *)state.overlay).text;
        CHECK([display containsString:@"11月9日"] && [display containsString:@"14:30"] && ![display containsString:@"11月14日"]);
        CHECK(owner.timeDetailMode ? [display containsString:@"星期一"] : [display isEqual:@"11月9日 14:30"]);
        NSString *otherDisplay=((UILabel *)otherState.overlay).text;
        CHECK([otherDisplay isEqual:owner.timeDetailMode ? @"11月8日 星期日 09:20" : @"11月8日 09:20"]);
        CHECK(otherTime.showingTime==1700010000 && [otherTime.timeText isEqual:@"second native time"]);
        CHECK(fabs(cell->m_timeLabel.alpha-.91)<.0001 && [cell->m_timeLabel.gestureRecognizers containsObject:cell.nativeTimeTap]);
    }
    CHECK(owner.timeDetailMode && owner.nativeTimeToggleCount==5);
    CSClownBindTimeCell(cell); CHECK([((UILabel *)state.overlay).text containsString:@"星期一"] && owner.timeDetailMode);
    [target longPress:[[ClownBeganPress alloc] initWithTarget:nil action:NULL]];
    UIAlertController *editor=(id)owner.testPresented;
    CHECK([editor.title isEqual:@"修改时间"] && [editor.textFields.firstObject.text isEqual:@"2026-11-09 14:30"]);
    editor.textFields.firstObject.text=@"2026-11-10 06:15";
    CHECK(ClownPresentationInvokeAction(editor,1)); CSClownBindTimeCell(cell);
    CHECK(owner.timeDetailMode && [((UILabel *)state.overlay).text containsString:@"11月10日 星期二 06:15"]);
    CHECK(time.showingTime==1700000000 && [time.timeText isEqual:@"native model text"]);
    CSClownRestoreCell(cell);
    CHECK(CGRectEqualToRect(cell->m_timeLabel.frame,nativeFrame) && cell->m_timeLabel.layer.mask==nativeMask);
    CHECK(fabs(cell->m_timeLabel.alpha-.91)<.0001 && [cell->m_timeLabel.gestureRecognizers containsObject:cell.nativeTimeTap]);
    CHECK(ClownPresentationTapNativeTime(cell,Center(cell->m_timeLabel)));
    CHECK(!owner.timeDetailMode && owner.lastNativeTimeToggleTimestamp==1700000000);
    CSClownBindTimeCell(cell); CSClownPageDidDisappear(owner);
    CHECK(CGRectEqualToRect(cell->m_timeLabel.frame,nativeFrame) && cell->m_timeLabel.layer.mask==nativeMask);
    CHECK(![cell.gestureRecognizers containsObject:target.gesture] && [cell->m_timeLabel.gestureRecognizers containsObject:cell.nativeTimeTap]);
    CHECK(!otherState.active && otherState.overlay.superview==nil && otherCell->m_timeLabel.layer.mask==nil);
    CHECK(ClownPresentationTapNativeTime(cell,Center(cell->m_timeLabel)) && time.showingTime==1700000000);
}

static void TestNativeTransferAmountsAndMenus(void) {
    NSArray<NSString *> *titles=@[@"1.00",@"1,000.00",@"$1.00",@"HK$1.00",@"USD 1.00",@"1.00 USD",@" EUR 1,000.00 ",@"1.00元"];
    NSArray<NSString *> *expected=@[@"88.80",@"88.80",@"$88.80",@"HK$88.80",@"USD 88.80",@"88.80 USD",@" EUR 88.80 ",@"88.80元"];
    for (NSUInteger index=0;index<titles.count;index++) {
        ClownPresentationModel *transfer=Model(49,100+index,NO);
        BaseMsgContentViewController *owner=Controller(@[transfer]);
        WCPayTransferMessageCellView *cell=[[WCPayTransferMessageCellView alloc] initWithFrame:CGRectMake(0,0,390,80)];
        cell.testOwner=owner; cell.viewModel=transfer; owner.testViews[Path(0,0)]=cell;
        cell->m_titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(64,8,280,24)];
        cell->m_titleLabel.text=titles[index]; cell->m_titleLabel.font=[UIFont systemFontOfSize:17];
        cell->m_titleLabel.userInteractionEnabled=YES; [cell addSubview:cell->m_titleLabel];
        UILongPressGestureRecognizer *nativePress=[[UILongPressGestureRecognizer alloc] initWithTarget:nil action:NULL];
        [cell->m_titleLabel addGestureRecognizer:nativePress];
        NSString *originalXML=transfer.messageWrap.m_nsContent;
        CGRect nativeFrame=cell->m_titleLabel.frame;
        NSArray *menu=[CSClownMenuAdapter itemsByAddingActionsForCell:cell items:@[]];
        CHECK(menu.count==1);
        MMMenuItem *item=menu.firstObject;
        CHECK([item.title isEqual:@"修改金额"] && item.action==NSSelectorFromString(@"cs_clownEditAmount:") && item.target);
        CHECK([CSClownMenuAdapter canPerformSelector:item.action cell:cell]);
        CSClownEditRequest *captured=CSClownCaptureAmountEdit(cell);
        CHECK(captured && CSClownEditIsValid(captured));
        IMP invoke=[item.target methodForSelector:item.action];
        ((void(*)(id,SEL,id))invoke)(item.target,item.action,item);
        UIAlertController *editor=(id)owner.testPresented;
        CHECK([editor.title isEqual:@"修改金额"]);
        CHECK([editor.textFields.firstObject.text isEqual:[titles[index] containsString:@"," ] ? @"1000.00" : @"1.00"]);
        editor.textFields.firstObject.text=@"88.80";
        [NSNotificationCenter.defaultCenter postNotificationName:UITextFieldTextDidChangeNotification object:editor.textFields.firstObject];
        CHECK(editor.actions[1].enabled && ClownPresentationInvokeAction(editor,1));
        CSClownRenderCell(cell);
        CSClownCellState *state=objc_getAssociatedObject(cell,&CSClownCellKey);
        CHECK(state.active && [((UILabel *)state.overlay).text isEqual:expected[index]]);
        CHECK([cell->m_titleLabel.text isEqual:titles[index]] && cell->m_titleLabel.alpha==1);
        CHECK([cell hitTest:Center(cell->m_titleLabel) withEvent:nil]==cell->m_titleLabel && [cell->m_titleLabel.gestureRecognizers containsObject:nativePress]);
        CHECK(transfer.messageWrap.m_nsContent==originalXML && transfer.messageWrap.m_uiCreateTime==1700000000);
        CSClownRestoreCell(cell);
        CHECK(!state.active && state.overlay.hidden && [cell->m_titleLabel.text isEqual:titles[index]]);
        CHECK(CGRectEqualToRect(cell->m_titleLabel.frame,nativeFrame) && cell->m_titleLabel.alpha==1);
        CSClownPageDidDisappear(owner);
        CHECK(state.overlay.superview==nil && !CSClownEditIsValid(captured));
    }
}

static ClownDelayedPhotoProvider *SelectPhoto(CSClownEditRequest *captured) {
    CSClownPerformEdit(captured);
    CSClownPage *page=captured.page;
    PHPickerViewController *picker=(id)page.owner.presentedViewController;
    CSClownPhotoDelegate *delegate=page.editorDelegate;
    CHECK([picker isKindOfClass:ClownPresentationPhotoController.class] && [delegate isKindOfClass:CSClownPhotoDelegate.class]);
    // An internally presented full-screen picker must preserve this chat's session.
    CSClownPageDidDisappear(page.owner); CHECK(page.session.active);
    ClownDelayedPhotoProvider *provider=[ClownDelayedPhotoProvider new]; ClownPhotoResult *result=[ClownPhotoResult new]; result.itemProvider=provider;
    [delegate picker:picker didFinishPicking:(id)@[result]];
    CHECK(provider.testCompletion && page.editor==nil && page.owner.presentedViewController==nil);
    return provider;
}
static void DeliverPhoto(ClownDelayedPhotoProvider *provider, UIImage *image, NSError *error) {
    CHECK(provider.testCompletion!=nil); provider.testCompletion(image,error); provider.testCompletion=nil; Drain();
}
static void TestPhotoAsyncBoundaries(void) {
    ClownPresentationModel *first=Model(3,20,NO), *second=Model(3,21,NO), *text=Model(1,22,NO);
    BaseMsgContentViewController *owner=Controller(@[first,second,text]);
    ImageMessageCellView *firstCell=ImageCell(owner,first), *secondCell=ImageCell(owner,second);
    ClownPresentationCell *textCell=TextCell(owner,text);
    CSClownEditRequest *captured=CSClownCaptureEdit(firstCell,YES); CHECK(captured);
    CSClownPage *page=captured.page;
    CSClownPerformEdit(captured); CSClownPhotoDelegate *cancelDelegate=page.editorDelegate; PHPickerViewController *cancelPicker=(id)owner.testPresented;
    CHECK(page.pendingPhotos.count==1); [cancelDelegate picker:cancelPicker didFinishPicking:@[]];
    CHECK(page.editor==nil && owner.testPresented==nil && page.pendingPhotos.count==0 && [page.session imageForContext:captured.context]==nil);

    // Executing the very same menu object twice must create independent callback tokens.
    ClownDelayedPhotoProvider *older=SelectPhoto(captured), *newer=SelectPhoto(captured);
    CHECK(page.pendingPhotos.count==1);
    UIImage *red=Image(CGSizeMake(80,90),UIColor.redColor), *blue=Image(CGSizeMake(90,80),UIColor.blueColor);
    DeliverPhoto(older,red,nil); CHECK([page.session imageForContext:captured.context]==nil);
    DeliverPhoto(newer,blue,nil); CHECK([page.session imageForContext:captured.context]==blue && page.pendingPhotos.count==0);
    ClownDelayedPhotoProvider *chosenBeforeCancel=SelectPhoto(captured);
    CSClownPerformEdit(captured); CSClownPhotoDelegate *secondCancel=page.editorDelegate;
    CHECK(page.pendingPhotos.count==2); [secondCancel picker:(id)owner.testPresented didFinishPicking:@[]];
    CHECK(page.pendingPhotos.count==1 && page.editor==nil);
    DeliverPhoto(chosenBeforeCancel,red,nil); CHECK([page.session imageForContext:captured.context]==red && page.pendingPhotos.count==0);

    // Independent messages and a text edit must not cancel an image still loading.
    ClownDelayedPhotoProvider *pendingFirst=SelectPhoto(captured);
    CSClownEditRequest *secondRequest=CSClownCaptureEdit(secondCell,YES); ClownDelayedPhotoProvider *pendingSecond=SelectPhoto(secondRequest);
    CHECK(page.pendingPhotos.count==2);
    CSClownPerformEdit(TextRequest(textCell)); UIAlertController *textEditor=(id)owner.testPresented;
    textEditor.textFields.firstObject.text=@"changed while photos load"; CHECK(ClownPresentationInvokeAction(textEditor,1));
    DeliverPhoto(pendingFirst,red,nil); DeliverPhoto(pendingSecond,blue,nil);
    CHECK([page.session imageForContext:captured.context]==red && [page.session imageForContext:secondRequest.context]==blue);
    CHECK(page.pendingPhotos.count==0 && [[page.session textForContext:TextRequest(textCell).context] isEqual:@"changed while photos load"]);

    ClownDelayedPhotoProvider *failed=SelectPhoto(captured);
    DeliverPhoto(failed,nil,[NSError errorWithDomain:@"ClownPhotoTest" code:1 userInfo:nil]);
    CHECK([page.session imageForContext:captured.context]==red && page.pendingPhotos.count==0);
    ClownDelayedPhotoProvider *disabled=SelectPhoto(captured);
    SetCapability(CSClownImageEnabledKey,NO); DeliverPhoto(disabled,blue,nil);
    CHECK([page.session imageForContext:captured.context]==nil && page.pendingPhotos.count==0);
    SetCapability(CSClownImageEnabledKey,YES);
    CSClownEditRequest *afterSetting=CSClownCaptureEdit(firstCell,YES); CHECK(afterSetting);
    ClownDelayedPhotoProvider *late=SelectPhoto(afterSetting);
    CSClownPageDidDisappear(owner); CHECK(!page.session.active && page.pendingPhotos.count==0);
    CSClownPageDidAppear(owner); DeliverPhoto(late,red,nil);
    CSClownEditRequest *reentered=CSClownCaptureEdit(firstCell,YES); CHECK(reentered && reentered.page!=page);
    CHECK([reentered.page.session imageForContext:reentered.context]==nil);
    CHECK([first.messageWrap.m_dtImg isEqual:[@"original image file bytes" dataUsingEncoding:NSUTF8StringEncoding]]);
    CSClownPageDidDisappear(owner);
}

static void TestWarmthAndFakeQuote(void) {
    SetCapability(CSClownWarmthEnabledKey, YES); SetCapability(CSClownFakeQuoteEnabledKey, YES);
    [ClownTestPreferences setWarmthTargets:@[@"chat"] account:@"me" groups:NO]; Drain();
    ClownPresentationModel *incoming = Model(1, 400, NO); incoming.messageWrap.m_nsContent = @"好";
    ClownPresentationModel *outgoing = Model(1, 401, YES); outgoing.messageWrap.m_nsContent = @"好";
    BaseMsgContentViewController *owner = Controller(@[incoming, outgoing]);
    ClownPresentationCell *cell = TextCell(owner, incoming);
    CSClownPage *page = CSClownPageForController(owner, NO);
    CSMessageActionContext *context = CSClownContext(page, incoming);
    NSString *warm = CSClownDisplayText(page, context);
    CHECK([CSClownWarmExpressions(@"好") containsObject:warm]);
    for (NSUInteger i = 0; i < 20; i++) {
        CHECK([warm isEqual:CSClownDisplayText(page, context)]);
        CSClownRenderCell(cell); CHECK([((UILabel *)CSClownExistingOverlay(cell, UILabel.class)).text isEqual:warm]);
    }
    CHECK([incoming.messageWrap.m_nsContent isEqual:@"好"]);
    CHECK(!CSClownDisplayText(page, CSClownContext(page, outgoing)));
    incoming.messageWrap.m_nsContent = @"好。"; CHECK(!CSClownDisplayText(page, context));
    incoming.messageWrap.m_nsContent = @"好";
    CHECK([page.session setText:@"手动优先" forContext:context]);
    CHECK([CSClownDisplayText(page, context) isEqual:@"手动优先"]);
    [ClownTestPreferences setWarmthTargets:@[] account:@"me" groups:NO]; Drain();
    CHECK([CSClownDisplayText(page, context) isEqual:@"手动优先"]);
    [page.session setText:nil forContext:context]; CHECK(!CSClownDisplayText(page, context));
    SetCapability(CSClownTextEnabledKey, NO);
    [ClownTestPreferences setWarmthTargets:@[@"chat"] account:@"me" groups:NO]; Drain();
    CHECK(CSClownDisplayText(page, CSClownContext(page, incoming)).length);

    __block BOOL invalidSent = NO;
    CSClownSubmitInput(owner, @"#假引用+旧格式；正文", ^(id text) { invalidSent = YES; });
    CHECK(!invalidSent && [owner.testPresented isKindOfClass:UIAlertController.class]); owner.testPresented = nil;
    CSClownSubmitInput(owner, @"#假引用 引用；  ", ^(id text) { invalidSent = YES; });
    CHECK(!invalidSent); owner.testPresented = nil;
    __block id firstCarrier, secondCarrier;
    CSClownSubmitInput(owner, @"#假引用 第一条；好", ^(id text) { firstCarrier = text; });
    CSClownSubmitInput(owner, @"#假引用 第二条;好", ^(id text) { secondCarrier = text; });
    CHECK([firstCarrier isEqual:@"好"] && [secondCarrier isEqual:@"好"] && firstCarrier != secondCarrier);
    ClownPresentationModel *first = Model(1, 410, YES), *second = Model(1, 411, YES), *normal = Model(1, 412, YES);
    for (ClownPresentationModel *model in @[first, second, normal]) model.messageWrap.m_nsContent = @"好";
    owner.testNodes = @[first, normal, second];
    CSClownSendInput(owner, firstCarrier, nil, nil, ^(id text) {
        CSClownDidAddMessage(@"chat", normal.messageWrap); // Equal text cannot claim a submission.
        CSClownDidFormText(@"chat", text, first.messageWrap);
        CSClownDidAddMessage(@"other", first.messageWrap); // Wrong destination cannot claim it.
        CSClownDidAddMessage(@"chat", first.messageWrap);
        CSClownDidAddMessage(@"chat", first.messageWrap); // Duplicate callback is harmless.
    });
    CSClownSendInput(owner, secondCarrier, nil, nil, ^(id text) {
        CSClownDidFormText(@"chat", text, second.messageWrap); CSClownDidAddMessage(@"chat", second.messageWrap);
    });
    CHECK([[page.session fakeQuoteForContext:CSClownContext(page, first)] hasSuffix:@"：第一条"]);
    CHECK([[page.session fakeQuoteForContext:CSClownContext(page, second)] hasSuffix:@"：第二条"]);
    CHECK(![page.session fakeQuoteForContext:CSClownContext(page, normal)]);
    CGFloat nativeHeight = 80, projected = CSClownRowHeight(owner, owner.testTable, Path(0,0), nativeHeight);
    CHECK(projected > nativeHeight);
    cell.viewModel = first; CSClownRenderCell(cell);
    CSClownCellState *state = objc_getAssociatedObject(cell, &CSClownCellKey);
    CHECK(state.quoteView && !state.quoteView.hidden && [state.quoteView.text hasSuffix:@"：第一条"]);
    CHECK(CGRectGetMinY(state.quoteView.frame) >= CGRectGetMaxY(cell.nativeBubble.frame)+5);
    CHECK(CGRectGetMaxX(state.quoteView.frame) == CGRectGetMaxX(cell.nativeBubble.frame));
    CSClownRestoreCell(cell); CHECK(state.quoteView.hidden);
    CSClownRenderCell(cell); CSClownReuseCell(cell); CHECK(!state.quoteView.superview);
    cell.viewModel = normal; CSClownRenderCell(cell);
    CHECK(!((CSClownCellState *)objc_getAssociatedObject(cell, &CSClownCellKey)).quoteView);
    ClownPresentationSplit *head = [ClownPresentationSplit new], *tail = [ClownPresentationSplit new];
    head.parentModel = first; tail.parentModel = first; first.subViewModels = @[head, tail];
    CHECK(CSClownRowHeight(owner, owner.testTable, Path(0,0), nativeHeight) == nativeHeight);
    CHECK(CSClownRowHeight(owner, owner.testTable, Path(0,1), nativeHeight) > nativeHeight);
    cell.viewModel = head; CSClownRenderCell(cell);
    CHECK(!((CSClownCellState *)objc_getAssociatedObject(cell, &CSClownCellKey)).quoteView);
    cell.viewModel = tail; CSClownRenderCell(cell);
    CHECK(!((CSClownCellState *)objc_getAssociatedObject(cell, &CSClownCellKey)).quoteView.hidden);
    CSClownReuseCell(cell); first.subViewModels = @[];
    SetCapability(CSClownFakeQuoteEnabledKey, NO);
    CHECK(CSClownRowHeight(owner, owner.testTable, Path(0,0), nativeHeight) == nativeHeight);
    SetCapability(CSClownFakeQuoteEnabledKey, YES);
    CHECK(![page.session fakeQuoteForContext:CSClownContext(page, first)]);
    __block id delayed;
    CSClownSubmitInput(owner, @"#假引用 不应错发；正文", ^(id text) { delayed = text; });
    CSClownPageDidDisappear(owner); __block BOOL sent = NO;
    CSClownSendInput(owner, delayed, nil, nil, ^(id text) { (void)text; sent = YES; }); CHECK(!sent);
    [ClownTestPreferences setWarmthTargets:@[@"room@chatroom"] account:@"me" groups:YES]; Drain();
    ClownPresentationModel *group = Model(1, 420, NO); group.messageWrap.m_nsFromUsr = @"room@chatroom";
    group.messageWrap.m_nsRealChatUsr = @"friend"; group.messageWrap.m_nsContent = @"friend:\n嗯";
    BaseMsgContentViewController *room = Controller(@[group]); room.testChat = @"room@chatroom"; CSClownPageDidAppear(room);
    CSClownPage *groupPage = CSClownPageForController(room, NO);
    CHECK([CSClownWarmExpressions(@"嗯") containsObject:CSClownDisplayText(groupPage, CSClownContext(groupPage, group))]);
    group.messageWrap.m_nsRealChatUsr = @"me"; CHECK(!CSClownDisplayText(groupPage, CSClownContext(groupPage, group)));
    CSClownPageDidDisappear(room);
    SetCapability(CSClownTextEnabledKey, YES); SetCapability(CSClownWarmthEnabledKey, NO); SetCapability(CSClownFakeQuoteEnabledKey, NO);
}

static void TestUnsupportedAndDisabled(void) {
    ClownPresentationModel *voice=Model(34,6,NO); BaseMsgContentViewController *owner=Controller(@[voice]);
    ClownPresentationCell *cell=TextCell(owner,voice);
    CHECK(CSClownCaptureEdit(cell,NO)==nil && CSClownCaptureEdit(cell,YES)==nil && CSClownCaptureAmountEdit(cell)==nil);
    CHECK(CSClownRowHeight(owner,owner.testTable,Path(0,0),80)==80);
    ClownPresentationModel *text=Model(1,7,NO); cell.viewModel=text; owner.testNodes=@[text]; text.isRecordDetail=YES;
    CHECK(CSClownCaptureEdit(cell,NO)==nil); text.isRecordDetail=NO;
    CSClownEditRequest *request=TextRequest(cell); CHECK([request.page.session setText:@"temporary" forContext:request.context]); CSClownRenderCell(cell);
    CHECK(fabs(cell.nativeText.alpha-.87)<.0001); SetCapability(CSClownEnabledKey,NO);
    CHECK(!request.page.session.active && cell.nativeText.layer.opacity>0 && CSClownCaptureEdit(cell,NO)==nil);
    CHECK(CSClownRowHeight(owner,owner.testTable,Path(0,0),80)==80);
    SetCapability(CSClownEnabledKey,YES); CSClownPageDidAppear(owner);
    CSClownEditRequest *newRequest=TextRequest(cell); CHECK([newRequest.page.session textForContext:newRequest.context]==nil);
    CHECK([newRequest.page.session setText:@"before account boundary" forContext:newRequest.context]); CSClownRenderCell(cell);
    dispatch_group_t group=dispatch_group_create();
    dispatch_group_async(group,dispatch_get_global_queue(QOS_CLASS_USER_INITIATED,0),^{ CSClownAccountBoundary(); });
    dispatch_group_wait(group,DISPATCH_TIME_FOREVER);
    CHECK(!CSClownEditIsValid(newRequest)); // The atomic epoch rejects before the queued UI cleanup runs.
    Drain(); CHECK(!newRequest.page.session.active && cell.nativeText.layer.opacity>0);
}

int main(void) {
    @autoreleasepool {
        NSString *suite=[@"ClownPresentationUIKitTests." stringByAppendingString:NSUUID.UUID.UUIDString];
        ClownTestDefaults=[[NSUserDefaults alloc] initWithSuiteName:suite];
        [ClownTestDefaults setPersistentDomain:@{CSClownEnabledKey:@YES,CSClownTextEnabledKey:@YES,
            CSClownTimeEnabledKey:@YES,CSClownImageEnabledKey:@YES,CSClownAmountEnabledKey:@YES} forName:suite];
        ClownTestPreferences=[[CSClownPreferences alloc] initWithDefaults:ClownTestDefaults];
        Method shared=class_getClassMethod(CSClownPreferences.class,@selector(sharedPreferences));
        IMP originalShared=method_setImplementation(shared,(IMP)TestSharedPreferences);
        ClownPresentationInstallPresentationBoundary();
        TestUIKitLayerOpacityHitTesting(); TestTextOverlayAndRestore(); TestOffscreenSplitAndCachedExit(); TestImageOverlay(); TestRetargetedControllerRestoresCachedHeights(); TestTimeAndAmount(); TestNativeTimeTapAndDisplayModes(); TestNativeTransferAmountsAndMenus(); TestPhotoAsyncBoundaries(); TestWarmthAndFakeQuote(); TestUnsupportedAndDisabled();
        [ClownTestDefaults removePersistentDomainForName:suite]; method_setImplementation(shared,originalShared);
        printf("Clown production presentation passed %lu checks (real Mac Catalyst UIKit, isolated defaults).\n",(unsigned long)checks);
    }
    return 0;
}
