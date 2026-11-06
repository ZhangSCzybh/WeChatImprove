#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import "CSCloseFriendPolicy.h"
#import "CSCloseFriendSignatures.h"
static CSCloseFriendSnapshot *Snapshot;
static NSUInteger Epoch=1;
static char EpochKey;
static NSMapTable *Refreshes;
static CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) {return Snapshot;}
static BOOL CSCFPageIsCurrent(id page) {
    NSNumber *saved=objc_getAssociatedObject(page,&EpochKey);
    if(!saved) {saved=@(Epoch); objc_setAssociatedObject(page,&EpochKey,saved,OBJC_ASSOCIATION_RETAIN_NONATOMIC);}
    return saved.unsignedIntegerValue==Epoch;
}
static id CSCloseFriendRead(id object,NSString *key) {
    if([object isKindOfClass:NSDictionary.class]) return object[key];
    SEL selector=NSSelectorFromString(key);
    if(CSCloseFriendMethodMatches(class_getInstanceMethod([object class],selector),"@@:")) return ((id(*)(id,SEL))objc_msgSend)(object,selector);
    Ivar ivar=class_getInstanceVariable([object class],key.UTF8String);
    return ivar && ivar_getTypeEncoding(ivar)[0]=='@' ? object_getIvar(object,ivar) : nil;
}
static NSString *CSCloseFriendUserName(id object) {return CSCloseFriendRead(object,@"username");}
static BOOL CSCFSocialSetIvar(id object,NSString *name,id value) {
    Ivar ivar=class_getInstanceVariable([object class],name.UTF8String);
    if(!ivar || ivar_getTypeEncoding(ivar)[0]!='@') return NO;
    object_setIvar(object,ivar,value); return YES;
}
static BOOL CSCFCallVoid(id object,NSString *name) {
    SEL selector=NSSelectorFromString(name);
    if(!CSCloseFriendMethodMatches(class_getInstanceMethod([object class],selector),"v@:")) return NO;
    ((void(*)(id,SEL))objc_msgSend)(object,selector); return YES;
}
static BOOL CSCFSetObject(id object,NSString *name,id value) {
    SEL selector=NSSelectorFromString(name);
    if(!CSCloseFriendMethodMatches(class_getInstanceMethod([object class],selector),"v@:@")) return NO;
    ((void(*)(id,SEL,id))objc_msgSend)(object,selector,value); return YES;
}
static BOOL CSCloseFriendInstallHook(NSString *cls,NSString *name,IMP replacement,IMP *original,const char *type) {
    Method method=class_getInstanceMethod(NSClassFromString(cls),NSSelectorFromString(name));
    if(!CSCloseFriendMethodMatches(method,type)) return NO;
    *original=method_getImplementation(method);
    class_replaceMethod(NSClassFromString(cls),NSSelectorFromString(name),replacement,method_getTypeEncoding(method)); return YES;
}
static void CSCFSocialHook0(NSString *cls,NSString *name,void(^body)(id,void(^)(void))) {
    __block IMP original=NULL; SEL selector=NSSelectorFromString(name);
    IMP replacement=imp_implementationWithBlock(^(id object){body(object,^{((void(*)(id,SEL))original)(object,selector);});});
    if(!CSCloseFriendInstallHook(cls,name,replacement,&original,"v@:")) imp_removeBlock(replacement);
}
static void CSCFSocialHook1(NSString *cls,NSString *name,void(^body)(id,id,void(^)(id))) {
    __block IMP original=NULL; SEL selector=NSSelectorFromString(name);
    IMP replacement=imp_implementationWithBlock(^(id object,id value){body(object,value,^(id next){((void(*)(id,SEL,id))original)(object,selector,next);});});
    if(!CSCloseFriendInstallHook(cls,name,replacement,&original,"v@:@")) imp_removeBlock(replacement);
}
static void CSCFSocialTrack(id page,void(^refresh)(id)) {
    if(!Refreshes) Refreshes=[NSMapTable weakToStrongObjectsMapTable];
    [Refreshes setObject:[refresh copy] forKey:page];
}
static void CSCloseFriendRecordCapability(__unused NSString *name,__unused BOOL available) {}
@interface UIViewController : NSObject
@property(nonatomic) BOOL isViewLoaded;
@end
@implementation UIViewController @end
@interface WCTimeLineFooterView : NSObject
@property(nonatomic,copy) NSString *tip;
@property(nonatomic) BOOL terminator;
- (void)onStateOfNoMoreData:(id)tip;
@end
@implementation WCTimeLineFooterView
- (void)onStateOfNoMoreData:(id)tip {self.terminator=YES; self.tip=tip;}
@end
@interface WCListView : NSObject {
@public
    id m_contact;
    __weak id viewController;
    NSArray *m_arrPhotoDatas,*m_starredDataItems,*displayed;
    WCTimeLineFooterView *m_footerView;
}
@property(nonatomic) BOOL tips,jump,prePage;
- (void)updateRowsData;
- (void)shouldReloadData:(id)photos starredDataItems:(id)stars jumpState:(BOOL)jump prePage:(BOOL)prePage;
- (void)showNoContentTips:(BOOL)show;
- (void)initFooterView;
- (void)onNoMoreDataWithRet:(NSInteger)result andTip:(id)tip;
- (void)refreshFooterEnd:(unsigned int)result;
@end
@implementation WCListView
- (void)initFooterView {m_footerView=[WCTimeLineFooterView new];}
- (void)updateRowsData {displayed=[m_arrPhotoDatas arrayByAddingObjectsFromArray:m_starredDataItems];}
- (void)shouldReloadData:(id)photos starredDataItems:(id)stars jumpState:(BOOL)jump prePage:(BOOL)prePage {
    m_arrPhotoDatas=photos; m_starredDataItems=stars; self.jump=jump; self.prePage=prePage;
    [self updateRowsData]; self.tips=!m_arrPhotoDatas.count;
}
- (void)showNoContentTips:(BOOL)show {self.tips=show;}
- (void)onNoMoreDataWithRet:(__unused NSInteger)result andTip:(id)tip {[m_footerView onStateOfNoMoreData:tip];}
- (void)refreshFooterEnd:(__unused unsigned int)result {m_footerView.terminator=NO;}
@end
@interface WCListViewController : UIViewController {
@public
    id m_contact;
    NSArray *m_arrPhotoDatas,*m_starredDataItems;
    WCListView *m_view;
}
@property(nonatomic) NSUInteger builds,appears;
@property(nonatomic,strong) id headerContact;
- (void)reloadStyle;
- (void)setM_contact:(id)contact;
- (void)viewWillAppear:(BOOL)animated;
@end
@implementation WCListViewController
- (void)setM_contact:(id)contact {m_contact=contact;}
- (void)reloadStyle {
    self.builds++; self.headerContact=m_contact;
    m_view=[WCListView new]; m_view->m_contact=m_contact; m_view->viewController=self;
    m_view->m_arrPhotoDatas=m_arrPhotoDatas; m_view->m_starredDataItems=m_starredDataItems;
    [m_view initFooterView]; [m_view updateRowsData]; self.isViewLoaded=YES;
}
- (void)viewWillAppear:(__unused BOOL)animated {self.appears++;}
@end
@interface WCFacadeDynamicConfig : NSObject
- (BOOL)Moments_enableFlutterUserPage;
- (BOOL)Moments_enableFlutterTimeline;
@end
@implementation WCFacadeDynamicConfig
- (BOOL)Moments_enableFlutterUserPage {return YES;}
- (BOOL)Moments_enableFlutterTimeline {return YES;}
@end
#include "AlbumBodies.h"
static unsigned Checks;
#define Check(x) do {Checks++; if(!(x)) {fprintf(stderr,"FAIL %s:%d: %s\n",__FILE__,__LINE__,#x); return 1;}} while(0)
static void Policy(BOOL enabled,BOOL revealed,BOOL hideTimeline) {
    NSMutableDictionary *options=[CSCloseFriendDefaultOptions() mutableCopy]; options[@"hideTimeline"]=@(hideTimeline);
    Snapshot=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"self" profile:@{@"enabled":@(enabled),@"friends":@[@"secret"],@"groups":@[],@"options":options} revealed:revealed revision:Epoch blocked:NO];
}
int main(void) { @autoreleasepool {
    Policy(YES,NO,YES); CSCFAlbumInstall();
    WCFacadeDynamicConfig *config=[WCFacadeDynamicConfig new];
    Check(![config Moments_enableFlutterUserPage] && ![config Moments_enableFlutterTimeline]);
    WCListViewController *page=[WCListViewController new];
    id secret=@{@"username":@"secret"}, ordinary=@{@"username":@"alice"};
    NSArray *posts=@[@"p1",@"p2"], *stars=@[@"s1"];
    page->m_arrPhotoDatas=posts; page->m_starredDataItems=stars; [page setM_contact:secret]; [page reloadStyle];
    Check(page->m_view->displayed.count==0 && page.headerContact==secret);
    Check(page->m_arrPhotoDatas==posts && page->m_starredDataItems==stars && posts.count==2);
    Check(page->m_view->m_footerView.terminator && page->m_view->m_footerView.tip==nil && !page->m_view.tips);
    [page->m_view shouldReloadData:posts starredDataItems:stars jumpState:YES prePage:YES];
    Check(!page->m_view->displayed.count && !page->m_view.jump && !page->m_view.prePage && !page->m_view.tips);
    [page->m_view onNoMoreDataWithRet:2 andTip:@"native limited access tip"];
    Check(page->m_view->m_footerView.tip==nil && page->m_view->m_footerView.terminator);
    [page->m_view refreshFooterEnd:0]; Check(page->m_view->m_footerView.terminator);
    void(^refresh)(id)=[Refreshes objectForKey:page]; Check(refresh!=nil);
    Policy(YES,YES,YES); refresh(page);
    Check(page->m_view->displayed.count==3 && !page->m_view->m_footerView.terminator && page.headerContact==secret);
    Check(![config Moments_enableFlutterUserPage]);
    Policy(YES,NO,YES); refresh(page); Check(page->m_view->displayed.count==0);
    [page setM_contact:ordinary]; Check(page->m_view->displayed.count==3 && page.headerContact==ordinary);
    NSUInteger builds=page.builds; refresh(page); [page viewWillAppear:YES];
    Check(page.builds==builds && page.appears==1);
    [page->m_view shouldReloadData:posts starredDataItems:stars jumpState:YES prePage:YES];
    Check(page->m_view->displayed.count==3 && page->m_view.jump && page->m_view.prePage);
    [page->m_view onNoMoreDataWithRet:2 andTip:@"ordinary native tip"];
    Check([page->m_view->m_footerView.tip isEqual:@"ordinary native tip"]);
    Policy(YES,NO,NO); [page setM_contact:secret]; refresh(page);
    Check(page->m_view->displayed.count==3);
    Policy(NO,NO,YES); refresh(page); Check([config Moments_enableFlutterUserPage] && [config Moments_enableFlutterTimeline]);
    for(NSNumber *hide in @[@YES,@NO]) {
        Snapshot=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"self" profile:@{@"enabled":@YES,@"friends":@[],@"groups":@[],@"options":@{@"hideTimeline":@NO,@"hideInteractions":@NO,@"hidePrivacyIcons":hide}} revealed:YES revision:Epoch blocked:NO];
        Check([config Moments_enableFlutterUserPage]==!hide.boolValue && [config Moments_enableFlutterTimeline]==!hide.boolValue);
    }
    // UI construction failure still restores original controller arrays.
    @try {AlbumWithEmptyPhotos(page,^{@throw [NSException exceptionWithName:@"fixture" reason:nil userInfo:nil];});} @catch(__unused NSException *exception) {}
    Check(page->m_arrPhotoDatas==posts && page->m_starredDataItems==stars);
    Policy(YES,NO,YES); Epoch++; refresh(page); Check(page->m_view->displayed.count==0);
    printf("Album: %u checks, native headers/terminator, updates, ordinary pages, reveal/relock, source restoration and routing passed\n",Checks);
    return 0;
} }
