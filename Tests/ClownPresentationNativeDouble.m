#import "ClownPresentationNativeDouble.h"
#import "CSClownPresentation.h"
#import <PhotosUI/PhotosUI.h>
#import <objc/runtime.h>

@implementation ClownPresentationWrap @end
@implementation ClownPresentationModel
- (id)cellDataForRow:(unsigned long long)row { return self.subViewModels.count ? self.subViewModels[(NSUInteger)row] : (row ? nil : self); }
- (long long)numberOfRowsInSection { return (long long)MAX(1,self.subViewModels.count); }
@end
@implementation ClownPresentationSplit @end
@implementation ClownPresentationTimeModel @end
@implementation ClownPresentationCell
- (id)getViewController { return self.testOwner; }
- (id)getCurrentMessageWrap {
    id root=self.viewModel;
    if ([root isKindOfClass:ClownPresentationSplit.class]) root=((ClownPresentationSplit *)root).parentModel;
    return [root isKindOfClass:ClownPresentationModel.class] ? ((ClownPresentationModel *)root).messageWrap : nil;
}
- (id)getContentView { return self.nativeContent; }
- (id)getBgImageView { return self.nativeBubble; }
- (id)getRichTextView { return self.nativeText; }
@end
@implementation ImageMessageCellView @end
@implementation WCPayTransferMessageCellView @end
@implementation ChatTimeCellView
- (void)installNativeTimeTap {
    m_timeLabel.userInteractionEnabled=YES;
    self.nativeTimeTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleNativeTimeTap:)];
    [m_timeLabel addGestureRecognizer:self.nativeTimeTap];
}
- (void)renderNativeTime {
    ClownPresentationTimeModel *model=self.viewModel;
    NSDateFormatter *formatter=[NSDateFormatter new]; formatter.locale=[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    formatter.timeZone=NSTimeZone.defaultTimeZone;
    formatter.dateFormat=self.testOwner.timeDetailMode ? @"M月d日 EEEE HH:mm" : @"M月d日 HH:mm";
    m_timeLabel.text=[formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:model.showingTime]];
}
- (void)handleNativeTimeTap:(UITapGestureRecognizer *)gesture {
    (void)gesture;
    [self.testOwner toggleTimeShowMode:((ClownPresentationTimeModel *)self.viewModel).showingTime];
}
@end
@implementation MMMenuItem
- (instancetype)initWithTitle:(NSString *)title icon:(id)icon target:(id)target action:(SEL)action {
    if ((self=[super init])) { self.title=title; self.iconImage=icon; self.target=target; self.action=action; }
    return self;
}
@end
@implementation ClownPresentationTableCell @end
@implementation ClownPresentationTable
- (void)reloadData { self.testReloadCount++; [super reloadData]; }
@end

static char ClownTestPresentingOwnerKey;
static char ClownTestActionHandlerKey;
static IMP ClownTestOriginalActionFactory;
@implementation BaseMsgContentViewController
- (id)getCurrentChatName { return self.testChat; }
- (id)GetMessageNodeDataArray { return self.testNodes; }
- (id)getTableView { return self.testTable; }
- (id)getMsgTableView { return self.testTable; }
- (BOOL)isNeedShowTimeInDetail { return self.timeDetailMode; }
- (void)toggleTimeShowMode:(double)timestamp {
    self.nativeTimeToggleCount++; self.lastNativeTimeToggleTimestamp=timestamp;
    self.timeDetailMode=!self.timeDetailMode;
    for (ClownPresentationCell *cell in self.testViews.allValues) {
        if ([cell isKindOfClass:ChatTimeCellView.class]) [(ChatTimeCellView *)cell renderNativeTime];
    }
}
- (UIViewController *)presentedViewController { return self.testPresented; }
- (void)presentViewController:(UIViewController *)controller animated:(BOOL)animated completion:(void (^)(void))completion {
    (void)animated; self.testPresented=controller; self.testPresentationCount++;
    objc_setAssociatedObject(controller,&ClownTestPresentingOwnerKey,self,OBJC_ASSOCIATION_ASSIGN);
    if (completion) completion();
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { (void)tableView; return (NSInteger)self.testNodes.count; }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    (void)tableView; id model=self.testNodes[(NSUInteger)section];
    return [model isKindOfClass:ClownPresentationModel.class] ? (NSInteger)[model numberOfRowsInSection] : 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)path {
    id model=self.testNodes[(NSUInteger)path.section]; NSArray *heights=[model nativeHeights];
    CGFloat native=heights.count>(NSUInteger)path.row ? [heights[(NSUInteger)path.row] doubleValue] : 80;
    return CSClownRowHeight(self,tableView,path,native);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section { (void)tableView; (void)section; return .01; }
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section { (void)tableView; (void)section; return .01; }
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)path {
    ClownPresentationTableCell *row=[[ClownPresentationTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    ClownPresentationCell *view=self.testViews[path];
    if (view) { row.cellView=view; [row.contentView addSubview:view]; CSClownBindRow(self,tableView,path,row); }
    return row;
}
@end

static NSString *ClownTestAccount=@"me";
@implementation MMContext
+ (NSString *)currentUserName { return ClownTestAccount; }
+ (void)setTestAccount:(NSString *)account { ClownTestAccount=[account copy]; }
@end

@interface ClownPresentationPhotoController ()
- (instancetype)initWithConfiguration:(PHPickerConfiguration *)configuration;
@end
@implementation ClownPresentationPhotoController
- (instancetype)initWithConfiguration:(PHPickerConfiguration *)configuration {
    (void)configuration;
    return [ClownPresentationPhotoController new];
}
@end

static void ClownTestDismiss(UIViewController *self, SEL selector, BOOL animated, void (^completion)(void)) {
    (void)selector; (void)animated;
    BaseMsgContentViewController *owner=objc_getAssociatedObject(self,&ClownTestPresentingOwnerKey);
    if ([self isKindOfClass:BaseMsgContentViewController.class]) owner=(id)self;
    if (owner.testPresented==self || owner==(id)self) owner.testPresented=nil;
    if (completion) completion();
}
static id ClownTestActionFactory(id self, SEL selector, NSString *title, UIAlertActionStyle style, void (^handler)(UIAlertAction *)) {
    id action=((id(*)(id,SEL,NSString *,UIAlertActionStyle,void(^)(UIAlertAction *)))ClownTestOriginalActionFactory)(self,selector,title,style,handler);
    objc_setAssociatedObject(action,&ClownTestActionHandlerKey,handler,OBJC_ASSOCIATION_COPY_NONATOMIC);
    return action;
}
void ClownPresentationInstallPresentationBoundary(void) {
    Method method=class_getInstanceMethod(UIViewController.class,@selector(dismissViewControllerAnimated:completion:));
    method_setImplementation(method,(IMP)ClownTestDismiss);
    Method factory=class_getClassMethod(UIAlertAction.class,@selector(actionWithTitle:style:handler:));
    ClownTestOriginalActionFactory=method_setImplementation(factory,(IMP)ClownTestActionFactory);
    Method picker=class_getInstanceMethod(PHPickerViewController.class,@selector(initWithConfiguration:));
    Method boundary=class_getInstanceMethod(ClownPresentationPhotoController.class,@selector(initWithConfiguration:));
    method_setImplementation(picker,method_getImplementation(boundary));
}
BOOL ClownPresentationInvokeAction(UIAlertController *alert, NSUInteger index) {
    if (index>=alert.actions.count || !alert.actions[index].enabled) return NO;
    UIAlertAction *action=alert.actions[index];
    void (^handler)(UIAlertAction *)=objc_getAssociatedObject(action,&ClownTestActionHandlerKey);
    BaseMsgContentViewController *owner=objc_getAssociatedObject(alert,&ClownTestPresentingOwnerKey);
    if (owner.testPresented==alert) owner.testPresented=nil;
    if (!handler) return NO;
    handler(action); return YES;
}
BOOL ClownPresentationTapNativeTime(ChatTimeCellView *cell, CGPoint point) {
    UIView *hit=[cell hitTest:point withEvent:nil];
    if (hit!=cell->m_timeLabel || !cell.nativeTimeTap ||
        ![cell->m_timeLabel.gestureRecognizers containsObject:cell.nativeTimeTap]) return NO;
    [cell handleNativeTimeTap:cell.nativeTimeTap];
    return YES;
}
