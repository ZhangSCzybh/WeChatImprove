#import "CSCloseFriendSocialAdapter.h"
#import <objc/message.h>

static char AlbumHiddenKey;
static BOOL AlbumHidden(id owner) {
    if(!owner || !NSThread.isMainThread) return NO;
    if(!CSCFPageIsCurrent(owner)) return YES;
    CSCloseFriendSnapshot *snapshot=CSCloseFriendCurrentSnapshot();
    return snapshot.blocked || [snapshot hidesUserName:CSCloseFriendUserName(CSCloseFriendRead(owner,@"m_contact")) surface:CSCloseFriendSurfaceTimeline];
}
static BOOL AlbumViewHidden(id view) {
    id owner=CSCloseFriendRead(view,@"viewController");
    return AlbumHidden(owner ?: view);
}
// Both arrays belong to the page/view. The facade, WCDataItem and friendship are
// untouched. Native row construction consumes the temporary empty presentation.
static void AlbumWithEmptyPhotos(id owner,void (^render)(void)) {
    id photos=CSCloseFriendRead(owner,@"m_arrPhotoDatas"), stars=CSCloseFriendRead(owner,@"m_starredDataItems");
    BOOL replacedPhotos=CSCFSocialSetIvar(owner,@"m_arrPhotoDatas",@[]);
    BOOL replacedStars=CSCFSocialSetIvar(owner,@"m_starredDataItems",@[]);
    @try { render(); }
    @finally {
        if(replacedPhotos) CSCFSocialSetIvar(owner,@"m_arrPhotoDatas",photos);
        if(replacedStars) CSCFSocialSetIvar(owner,@"m_starredDataItems",stars);
    }
}
static void AlbumTerminator(id view) {
    if(!view || !AlbumViewHidden(view)) return;
    // 8.0.78 uses a nil tip to build its standard MMTerminatorView (— · —).
    // This is a view state only; do not invoke controller refreshFooter, which
    // requests another homepage page from the facade.
    SEL selector=NSSelectorFromString(@"showNoContentTips:");
    if(CSCloseFriendMethodMatches(class_getInstanceMethod([view class],selector),"v@:B")) ((void(*)(id,SEL,BOOL))objc_msgSend)(view,selector,NO);
    CSCFSetObject(CSCloseFriendRead(view,@"m_footerView"),@"onStateOfNoMoreData:",nil);
}
static void AlbumRefresh(id owner) {
    NSNumber *previous=objc_getAssociatedObject(owner,&AlbumHiddenKey);
    BOOL hidden=AlbumHidden(owner);
    if([owner isKindOfClass:UIViewController.class] && [(UIViewController *)owner isViewLoaded] && previous && previous.boolValue!=hidden) {
        // Rebuild only this native view from the intact controller arrays. This
        // also restores the native footer/header after reveal without a fetch.
        CSCFCallVoid(owner,@"reloadStyle");
    }
    objc_setAssociatedObject(owner,&AlbumHiddenKey,@(hidden),OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static BOOL AlbumNeedsNativeRoute(NSString *option) {
    CSCloseFriendSnapshot *snapshot=CSCloseFriendCurrentSnapshot();
    // Keep the same native route during a temporary reveal, so a later relock
    // can refresh pages that were opened while unlocked.
    return snapshot.blocked || (snapshot.enabled && snapshot.protectedUserNames.count &&
        ([snapshot.options[option] boolValue] || ([option isEqual:@"hideTimeline"] && [snapshot.options[@"hideInteractions"] boolValue])));
}
static void AlbumInstallRoutes(void) {
    for(NSString *name in @[@"Moments_enableFlutterUserPage",@"Moments_enableFlutterTimeline"]) {
        __block IMP original=NULL; SEL selector=NSSelectorFromString(name);
        IMP replacement=imp_implementationWithBlock(^BOOL(id config){
            return AlbumNeedsNativeRoute(@"hideTimeline") ? NO : ((BOOL(*)(id,SEL))original)(config,selector);
        });
        if(!CSCloseFriendInstallHook(@"WCFacadeDynamicConfig",name,replacement,&original,"B@:")) imp_removeBlock(replacement);
    }
}
void CSCFAlbumInstall(void) {
    BOOL ready=YES;
    NSDictionary *contracts=@{
        @"WCListViewController":@{@"reloadStyle":@"v@:"},
        @"WCListView":@{@"updateRowsData":@"v@:",@"shouldReloadData:starredDataItems:jumpState:prePage:":@"v@:@@BB",@"showNoContentTips:":@"v@:B"},
        @"WCTimeLineFooterView":@{@"onStateOfNoMoreData:":@"v@:@"}
    };
    for(NSString *cls in contracts) for(NSString *name in contracts[cls]) ready &= CSCloseFriendMethodMatches(class_getInstanceMethod(NSClassFromString(cls),NSSelectorFromString(name)),[contracts[cls][name] UTF8String]);
    for(NSString *cls in @[@"WCListViewController",@"WCListView"]) for(NSString *name in @[@"m_arrPhotoDatas",@"m_starredDataItems"]) {
        Ivar ivar=class_getInstanceVariable(NSClassFromString(cls),name.UTF8String);
        ready &= ivar && ivar_getTypeEncoding(ivar)[0]=='@';
    }
    CSCloseFriendRecordCapability(@"social.personal.native-content",ready);
    if(!ready) return;
    AlbumInstallRoutes();
    CSCFSocialHook0(@"WCListViewController",@"reloadStyle",^(id owner,void(^original)(void)){
        BOOL hidden=AlbumHidden(owner);
        if(hidden) AlbumWithEmptyPhotos(owner,original); else original();
        objc_setAssociatedObject(owner,&AlbumHiddenKey,@(hidden),OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        AlbumTerminator(CSCloseFriendRead(owner,@"m_view"));
        CSCFSocialTrack(owner,^(id page){AlbumRefresh(page);});
    });
    CSCFSocialHook1(@"WCListViewController",@"setM_contact:",^(id owner,id contact,void(^original)(id)){
        original(contact); AlbumRefresh(owner);
    });
    __block IMP appear=NULL;
    IMP replacement=imp_implementationWithBlock(^(id owner,BOOL animated){
        AlbumRefresh(owner); ((void(*)(id,SEL,BOOL))appear)(owner,NSSelectorFromString(@"viewWillAppear:"),animated);
    });
    if(!CSCloseFriendInstallHook(@"WCListViewController",@"viewWillAppear:",replacement,&appear,"v@:B")) imp_removeBlock(replacement);
    CSCFSocialHook0(@"WCListView",@"updateRowsData",^(id view,void(^original)(void)){
        if(AlbumViewHidden(view)) AlbumWithEmptyPhotos(view,original); else original();
        AlbumTerminator(view);
    });
    __block IMP reload=NULL;
    SEL reloadSelector=NSSelectorFromString(@"shouldReloadData:starredDataItems:jumpState:prePage:");
    replacement=imp_implementationWithBlock(^(id view,id photos,id stars,BOOL jump,BOOL previous){
        BOOL hidden=AlbumViewHidden(view);
        ((void(*)(id,SEL,id,id,BOOL,BOOL))reload)(view,reloadSelector,hidden?@[]:photos,hidden?@[]:stars,hidden?NO:jump,hidden?NO:previous);
        AlbumTerminator(view);
    });
    if(!CSCloseFriendInstallHook(@"WCListView",NSStringFromSelector(reloadSelector),replacement,&reload,"v@:@@BB")) imp_removeBlock(replacement);
    __block IMP noMore=NULL;
    SEL noMoreSelector=NSSelectorFromString(@"onNoMoreDataWithRet:andTip:");
    replacement=imp_implementationWithBlock(^(id view,NSInteger result,id tip){
        BOOL hidden=AlbumViewHidden(view);
        ((void(*)(id,SEL,NSInteger,id))noMore)(view,noMoreSelector,hidden?1:result,hidden?nil:tip);
    });
    if(!CSCloseFriendInstallHook(@"WCListView",NSStringFromSelector(noMoreSelector),replacement,&noMore,"v@:q@")) imp_removeBlock(replacement);
    CSCFSocialHook0(@"WCListView",@"initFooterView",^(id view,void(^original)(void)){original(); AlbumTerminator(view);});
    __block IMP footerEnd=NULL;
    replacement=imp_implementationWithBlock(^(id view,unsigned int result){
        ((void(*)(id,SEL,unsigned int))footerEnd)(view,NSSelectorFromString(@"refreshFooterEnd:"),result); AlbumTerminator(view);
    });
    if(!CSCloseFriendInstallHook(@"WCListView",@"refreshFooterEnd:",replacement,&footerEnd,"v@:I")) imp_removeBlock(replacement);
}
