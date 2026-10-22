#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import "CSCloseFriendPolicy.h"
#import "CSCloseFriendSignatures.h"
static CSCloseFriendSnapshot *snapshot;
static NSUInteger epoch=1;
static char EpochKey;
NSString *const CSCloseFriendPolicyDidChangeNotification=@"PrivacyFixturePolicyChanged";
static BOOL CSCloseFriendHidesPrivacyIcons(void) {return snapshot.blocked || (snapshot.enabled && [snapshot.options[@"hidePrivacyIcons"] boolValue]);}
static BOOL CSCFPageIsCurrent(id owner) {NSNumber *saved=objc_getAssociatedObject(owner,&EpochKey);if(!saved){saved=@(epoch);objc_setAssociatedObject(owner,&EpochKey,saved,OBJC_ASSOCIATION_RETAIN_NONATOMIC);}return saved.unsignedIntegerValue==epoch;}
static id CSCloseFriendRead(id owner,NSString *key) {Ivar ivar=class_getInstanceVariable([owner class],key.UTF8String);return ivar?object_getIvar(owner,ivar):nil;}
static BOOL CSCFCallVoid(id owner,NSString *name) {SEL sel=NSSelectorFromString(name);if(!CSCloseFriendMethodMatches(class_getInstanceMethod([owner class],sel),"v@:"))return NO;((void(*)(id,SEL))objc_msgSend)(owner,sel);return YES;}
static BOOL CSCloseFriendInstallHook(NSString *name,NSString *method,IMP replacement,IMP *original,const char *encoding) {Class cls=NSClassFromString(name);SEL sel=NSSelectorFromString(method);Method m=class_getInstanceMethod(cls,sel);if(!CSCloseFriendMethodMatches(m,encoding))return NO;*original=method_getImplementation(m);class_replaceMethod(cls,sel,replacement,method_getTypeEncoding(m));return YES;}
void MSHookMessageEx(Class cls,SEL sel,IMP replacement,IMP *original) {Method method=class_getInstanceMethod(cls,sel);*original=method_getImplementation(method);class_replaceMethod(cls,sel,replacement,method_getTypeEncoding(method));}
void CSCloseFriendRecordCapability(__unused NSString *name,__unused BOOL supported) {}
static void CSCFSocialHook0(NSString *cls,NSString *name,void(^body)(id,void(^)(void))) {__block IMP original=NULL;SEL sel=NSSelectorFromString(name);IMP replacement=imp_implementationWithBlock(^(id owner){body(owner,^{((void(*)(id,SEL))original)(owner,sel);});});if(!CSCloseFriendInstallHook(cls,name,replacement,&original,"v@:"))imp_removeBlock(replacement);}
@interface UIView : NSObject
@property(nonatomic,weak) UIView *superview;
@property(nonatomic,strong) NSMutableArray *subviews;
@property(nonatomic) double x,width;
- (double)right;
- (void)addSubview:(UIView *)view;
- (void)removeFromSuperview;
@end
@implementation UIView
- (double)right {return self.x+self.width;}
- (void)addSubview:(UIView *)view {NSCAssert(view,@"Native addSubview requires a real view");[view removeFromSuperview];if(!self.subviews)self.subviews=[NSMutableArray new];[self.subviews addObject:view];view.superview=self;}
- (void)removeFromSuperview {[self.superview.subviews removeObjectIdenticalTo:self];self.superview=nil;}
@end
@interface WCListCellStatusInfo : NSObject
@property(nonatomic) BOOL grouped,privatePost,starred;
- (BOOL)showsGroupedStatus;
- (BOOL)showsPrivateStatus;
@end
@implementation WCListCellStatusInfo
- (BOOL)showsGroupedStatus {return self.grouped;}
- (BOOL)showsPrivateStatus {return self.privatePost;}
@end
@interface WCListBaseCellView : NSObject {
@public UIView *m_sharedImageView,*m_lockedImageView;
}
@property(nonatomic,strong) UIView *container;
@property(nonatomic,strong) WCListCellStatusInfo *source;
@property(nonatomic) NSUInteger layouts,rebuilds,spokenStatuses;
- (void)setGroupItem:(id)item inGroup:(id)group;
- (void)initView;
- (void)initSharedImageView;
- (void)initLockedImageView;
- (void)initStatusIconImageView;
- (void)layoutStatusIconImageView;
- (void)layoutSubviews;
- (void)updateAccessibility;
@end
@implementation WCListBaseCellView
- (instancetype)init {if((self=[super init]))_container=[UIView new];return self;}
- (void)setGroupItem:(id)item inGroup:(__unused id)group {self.source=item;[self initView];[self layoutSubviews];[self updateAccessibility];}
- (void)initView {self.rebuilds++;[m_sharedImageView removeFromSuperview];[m_lockedImageView removeFromSuperview];[self initStatusIconImageView];}
- (void)initSharedImageView {if(!m_sharedImageView)m_sharedImageView=[UIView new];[self.container addSubview:m_sharedImageView];}
- (void)initLockedImageView {if(!m_lockedImageView)m_lockedImageView=[UIView new];[self.container addSubview:m_lockedImageView];}
- (void)initStatusIconImageView {if(self.source.showsGroupedStatus)[self initSharedImageView];if(self.source.showsPrivateStatus)[self initLockedImageView];}
- (void)layoutStatusIconImageView {self.layouts++;}
- (void)layoutSubviews {[self layoutStatusIconImageView];}
- (void)updateAccessibility {self.spokenStatuses=self.source.showsGroupedStatus+self.source.showsPrivateStatus+self.source.starred;}
@end
@interface WCListPhotoCellView : WCListBaseCellView
@property(nonatomic) NSUInteger thumbnailOverlayCount;
@end
@implementation WCListPhotoCellView
- (void)initView {[super initView];self.thumbnailOverlayCount=self.source.showsGroupedStatus+self.source.showsPrivateStatus;}
@end
// Native layout builds this model independently of the controller's view tree.
// Types 1, 5 and 6 are the timestamp, range indicator and delete action.
@interface WCActionAreaVM : NSObject
@property(nonatomic,copy) NSArray<NSNumber *> *elements;
+ (BOOL)canShowShareGroupButtonWithDataItem:(id)item isDynamicTagEnabled:(BOOL)dynamicTag;
- (instancetype)initWithDataItem:(id)item;
@end
@implementation WCActionAreaVM
+ (BOOL)canShowShareGroupButtonWithDataItem:(id)item isDynamicTagEnabled:(BOOL)dynamicTag {return dynamicTag && [item[@"grouped"] boolValue];}
- (instancetype)initWithDataItem:(id)item {if((self=[super init]))self.elements=[[self class] canShowShareGroupButtonWithDataItem:item isDynamicTagEnabled:YES]?@[@1,@5,@6]:@[@1,@6];return self;}
@end
@interface WCCommentDetailViewControllerFB : NSObject {
@public UIView *_privacyBtn;
}
@property(nonatomic,strong) UIView *header,*deleteButton,*timeLabel;
@property(nonatomic) BOOL grouped,throwDuringLayout,probeOtherThread,otherThreadShowsPrivacy;
@property(nonatomic) NSUInteger rebuilds,actions,layoutUpdates;
- (BOOL)canShowPirvacyButton;
- (void)initTableHeaderView;
- (double)layoutActionArea;
- (void)updateTableLayout;
- (void)onShowGroup;
@end
@implementation WCCommentDetailViewControllerFB
- (instancetype)init {if((self=[super init])){_header=[UIView new];_deleteButton=[UIView new];_deleteButton.width=14;_timeLabel=[UIView new];_timeLabel.x=45;_timeLabel.width=40;}return self;}
- (BOOL)canShowPirvacyButton {return self.grouped;}
- (void)initTableHeaderView {self.rebuilds++;[_privacyBtn removeFromSuperview];_privacyBtn=nil;if([self canShowPirvacyButton]){_privacyBtn=[UIView new];_privacyBtn.width=24;[self.header addSubview:_privacyBtn];}[self.header addSubview:self.timeLabel];[self.header addSubview:self.deleteButton];}
- (double)layoutActionArea {
    WCActionAreaVM *model=[[WCActionAreaVM alloc] initWithDataItem:@{@"grouped":@(self.grouped)}];
    if(self.throwDuringLayout) @throw [NSException exceptionWithName:@"FixtureLayoutError" reason:nil userInfo:nil];
    if(self.probeOtherThread) {
        dispatch_semaphore_t done=dispatch_semaphore_create(0);
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT,0),^{
            self.otherThreadShowsPrivacy=[WCActionAreaVM canShowShareGroupButtonWithDataItem:@{@"grouped":@YES} isDynamicTagEnabled:YES];
            dispatch_semaphore_signal(done);
        });
        dispatch_semaphore_wait(done,DISPATCH_TIME_FOREVER);
    }
    double right=0;
    for(NSNumber *type in model.elements) {
        UIView *view=type.integerValue==1?self.timeLabel:(type.integerValue==5?_privacyBtn:self.deleteButton);
        if(type.integerValue!=1) view.x=right+8;
        // Mirrors native layout's nil-message behavior: a missing privacy view
        // resets the positioning reference and moves delete to x=8 (the bug).
        right=[view right];
    }
    return model.elements.count==3?40:20;
}
- (void)updateTableLayout {self.layoutUpdates++;(void)[self layoutActionArea];}
- (void)onShowGroup {self.actions++;}
@end
#import "PrivacyAdapterUnderTest.h"
static NSUInteger checks;
#define Check(x,message) do {checks++;if(!(x)){fprintf(stderr,"FAIL: %s\n",message);exit(1);}} while(0)
static void Policy(BOOL enabled,BOOL hide,BOOL revealed) {snapshot=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"icons-fixture" profile:@{@"enabled":@(enabled),@"friends":@[],@"groups":@[],@"options":@{@"hidePrivacyIcons":@(hide)}} revealed:revealed revision:epoch blocked:NO];}
static void Notify(void) {[NSNotificationCenter.defaultCenter postNotificationName:CSCloseFriendPolicyDidChangeNotification object:nil];}
int main(void) {@autoreleasepool {
    Policy(YES,NO,NO);CSCFPrivacyInstall();
    WCListCellStatusInfo *source=[WCListCellStatusInfo new];source.grouped=YES;source.starred=YES;
    WCListPhotoCellView *cell=[WCListPhotoCellView new];[cell setGroupItem:source inGroup:nil];
    WCCommentDetailViewControllerFB *detail=[WCCommentDetailViewControllerFB new];detail.grouped=YES;[detail initTableHeaderView];
    Check(cell->m_sharedImageView.superview && cell.thumbnailOverlayCount==1 && detail->_privacyBtn.superview,"native icons visible with option off");
    Policy(YES,YES,NO);Notify();
    Check(!cell->m_sharedImageView.superview && cell.thumbnailOverlayCount==0,"setting hides both existing list status view and photo overlay");
    Check(cell.spokenStatuses==1 && source.starred && source.grouped,"range description hidden while star status and true source are preserved");
    Check(detail.deleteButton.x==detail.timeLabel.right+8,"hidden privacy keeps delete after timestamp instead of at the left edge");
    Check(!detail->_privacyBtn.superview && [detail layoutActionArea]==20,"existing detail hides range button and collapses its spacing");
    Check(detail.deleteButton.superview==detail.header,"delete action is preserved");
    for(NSUInteger i=0;i<3;i++) (void)[detail layoutActionArea];
    Check(detail.deleteButton.x==detail.timeLabel.right+8,"repeated native layouts preserve delete position");
    Check([WCActionAreaVM canShowShareGroupButtonWithDataItem:@{@"grouped":@YES} isDynamicTagEnabled:YES],"unrelated layout models keep native privacy predicate outside detail layout");
    Check(![WCActionAreaVM canShowShareGroupButtonWithDataItem:@{@"grouped":@YES} isDynamicTagEnabled:NO],"native predicate arguments are forwarded unchanged");
    detail.probeOtherThread=YES;(void)[detail layoutActionArea];detail.probeOtherThread=NO;
    Check(detail.otherThreadShowsPrivacy,"detail layout scope does not suppress another thread's model");
    detail.throwDuringLayout=YES;BOOL threw=NO;
    @try {(void)[detail layoutActionArea];} @catch(NSException *exception) {threw=[exception.name isEqual:@"FixtureLayoutError"];}
    detail.throwDuringLayout=NO;
    Check(threw && [WCActionAreaVM canShowShareGroupButtonWithDataItem:@{@"grouped":@YES} isDynamicTagEnabled:YES],"exception restores scoped predicate and propagates native failure");
    [detail onShowGroup];Check(detail.actions==0,"stale range-button action suppressed");
    NSUInteger cells=cell.rebuilds,pages=detail.rebuilds;
    Policy(YES,YES,YES);Notify();Check(cell.rebuilds==cells && detail.rebuilds==pages,"temporary reveal keeps icons hidden without redundant rebuild");
    [cell initSharedImageView];[cell layoutSubviews];Check(!cell->m_sharedImageView.superview,"late native image creation cannot reattach hidden icon");
    WCListPhotoCellView *newCell=[WCListPhotoCellView new];[newCell setGroupItem:source inGroup:nil];
    WCCommentDetailViewControllerFB *newDetail=[WCCommentDetailViewControllerFB new];newDetail.grouped=YES;[newDetail initTableHeaderView];
    Check(newCell.thumbnailOverlayCount==0 && !newDetail->_privacyBtn,"new/reused cells and newly opened details start hidden");
    Check([newDetail layoutActionArea]==20 && newDetail.deleteButton.x==newDetail.timeLabel.right+8,"newly opened hidden detail lays out delete after timestamp");
    source.grouped=NO;source.privatePost=YES;[cell setGroupItem:source inGroup:nil];
    Check(cell.thumbnailOverlayCount==0 && !cell->m_lockedImageView.superview,"private-post range marker hidden too");
    Policy(YES,NO,YES);Notify();
    Check(cell->m_lockedImageView.superview && !cell->m_sharedImageView.superview && cell.thumbnailOverlayCount==1,"restoration follows current reused post rather than saved former icon");
    Check(detail->_privacyBtn.superview && newDetail->_privacyBtn.superview && [detail layoutActionArea]==40,"off restores existing and previously suppressed detail buttons");
    Check(detail.deleteButton.x==detail->_privacyBtn.right+8 && detail->_privacyBtn.x==detail.timeLabel.right+8,"off restores native timestamp, privacy, delete sequence");
    [detail onShowGroup];Check(detail.actions==1,"off restores native range-button action");
    source.privatePost=NO;[cell setGroupItem:source inGroup:nil];detail.grouped=NO;[detail initTableHeaderView];
    Policy(YES,YES,NO);Notify();Policy(YES,NO,NO);Notify();
    Check(cell.thumbnailOverlayCount==0 && !detail->_privacyBtn,"public post remains without range icons across toggles");
    Check(detail.deleteButton.x==detail.timeLabel.right+8,"public post delete position survives toggles");
    source.grouped=YES;detail.grouped=YES;[cell setGroupItem:source inGroup:nil];[detail initTableHeaderView];
    Policy(YES,YES,NO);Notify();Policy(NO,YES,NO);Notify();
    Check(cell.thumbnailOverlayCount==1 && detail->_privacyBtn.superview,"disabling master feature restores native display");
    cells=cell.rebuilds;pages=detail.rebuilds;epoch++;Policy(YES,YES,NO);Notify();
    Check(cell.rebuilds==cells && detail.rebuilds==pages,"old-account owners are never rebuilt under another account");
    __weak id weakCell;@autoreleasepool{WCListPhotoCellView *temporary=[WCListPhotoCellView new];[temporary setGroupItem:source inGroup:nil];weakCell=temporary;}
    Check(!weakCell,"refresh registry does not retain recycled cell owners");
    printf("CloseFriendPrivacyTests: %lu checks passed\n",(unsigned long)checks);
}return 0;}
