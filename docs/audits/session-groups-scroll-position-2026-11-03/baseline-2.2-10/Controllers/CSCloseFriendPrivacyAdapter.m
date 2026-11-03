#import "CSCloseFriendSocialAdapter.h"
#import <objc/message.h>

static char PrivacyRenderedKey, PrivacyDetailViewStateKey;
typedef NS_ENUM(NSUInteger, CSCFPrivacyOwnerKind) { CSCFPrivacyAlbum, CSCFPrivacyDetail };

static void SetDetailPrivacyHidden(id owner,BOOL hidden) {
    UIView *view=CSCloseFriendRead(owner,@"_privacyBtn");
    if(![view isKindOfClass:UIView.class]) return;
    NSDictionary *saved=objc_getAssociatedObject(view,&PrivacyDetailViewStateKey);
    if(hidden) {
        if(!saved) objc_setAssociatedObject(view,&PrivacyDetailViewStateKey,
            @{@"hidden":@(view.hidden),@"interactive":@(view.userInteractionEnabled),
              @"accessible":@(view.isAccessibilityElement),@"accessibilityHidden":@(view.accessibilityElementsHidden)},OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        // Keep the real button and its native frame as the layout reference for
        // delete. Hide drawing, hit testing and accessibility without collapsing it.
        view.hidden=YES;
        view.userInteractionEnabled=NO;
        view.isAccessibilityElement=NO;
        view.accessibilityElementsHidden=YES;
    } else if(saved) {
        view.hidden=[saved[@"hidden"] boolValue];
        view.userInteractionEnabled=[saved[@"interactive"] boolValue];
        view.isAccessibilityElement=[saved[@"accessible"] boolValue];
        view.accessibilityElementsHidden=[saved[@"accessibilityHidden"] boolValue];
        objc_setAssociatedObject(view,&PrivacyDetailViewStateKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
static void HidePrivacyViews(id owner,CSCFPrivacyOwnerKind kind) {
    // These are presentation views only. Never modify WCDataItem privacy/ACL fields.
    if(kind==CSCFPrivacyDetail) {SetDetailPrivacyHidden(owner,YES); return;}
    for(NSString *key in @[@"m_sharedImageView",@"m_lockedImageView"]) {
        id view=CSCloseFriendRead(owner,key);
        if([view isKindOfClass:UIView.class]) [view removeFromSuperview];
    }
}
static void RefreshPrivacyOwner(id owner,CSCFPrivacyOwnerKind kind) {
    BOOL hidden=CSCloseFriendHidesPrivacyIcons();
    NSNumber *rendered=objc_getAssociatedObject(owner,&PrivacyRenderedKey);
    if(rendered && rendered.boolValue==hidden) return;
    // A recycled old-account page must never be rebuilt using another account's policy.
    if(!CSCFPageIsCurrent(owner)) {HidePrivacyViews(owner,kind); return;}
    objc_setAssociatedObject(owner,&PrivacyRenderedKey,@(hidden),OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if(hidden) HidePrivacyViews(owner,kind);
    // Native reconstruction reads the intact post. This also refreshes thumbnail overlays,
    // cached buttons and accessibility when the preference is turned off.
    CSCFCallVoid(owner,kind==CSCFPrivacyAlbum ? @"initView" : @"initTableHeaderView");
    CSCFCallVoid(owner,kind==CSCFPrivacyAlbum ? @"layoutSubviews" : @"updateTableLayout");
    if(kind==CSCFPrivacyAlbum) CSCFCallVoid(owner,@"updateAccessibility");
}
static void TrackPrivacyOwner(id owner,CSCFPrivacyOwnerKind kind) {
    if(!owner || !NSThread.isMainThread) return;
    CSCFPageIsCurrent(owner);
    objc_setAssociatedObject(owner,&PrivacyRenderedKey,@(CSCloseFriendHidesPrivacyIcons()),OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    // Separate from CSCFSocialTrack: a detail page also owns its likes/comments refresh.
    static NSMapTable *owners; static dispatch_once_t once;
    dispatch_once(&once,^{
        owners=[NSMapTable weakToStrongObjectsMapTable];
        [NSNotificationCenter.defaultCenter addObserverForName:CSCloseFriendPolicyDidChangeNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(__unused NSNotification *note){
            for(id page in owners.keyEnumerator.allObjects) RefreshPrivacyOwner(page,[[owners objectForKey:page] unsignedIntegerValue]);
        }];
    });
    [owners setObject:@(kind) forKey:owner];
}
static void InstallPrivacyFlag(NSString *className,NSString *name) {
    __block IMP original=NULL; SEL selector=NSSelectorFromString(name);
    IMP replacement=imp_implementationWithBlock(^BOOL(id object){
        return !CSCloseFriendHidesPrivacyIcons() && ((BOOL(*)(id,SEL))original)(object,selector);
    });
    if(!CSCloseFriendInstallHook(className,name,replacement,&original,"B@:")) imp_removeBlock(replacement);
}
void CSCFPrivacyInstall(void) {
    // WCListCellStatusInfo is a display-only model. These getters also drive the
    // photo-grid overlay helper, width calculation and spoken status descriptions.
    InstallPrivacyFlag(@"WCListCellStatusInfo",@"showsGroupedStatus");
    InstallPrivacyFlag(@"WCListCellStatusInfo",@"showsPrivateStatus");
    __block IMP setGroup=NULL;
    IMP replacement=imp_implementationWithBlock(^(id cell,id item,id group){
        ((void(*)(id,SEL,id,id))setGroup)(cell,NSSelectorFromString(@"setGroupItem:inGroup:"),item,group);
        if(CSCloseFriendHidesPrivacyIcons()) HidePrivacyViews(cell,CSCFPrivacyAlbum);
        TrackPrivacyOwner(cell,CSCFPrivacyAlbum);
    });
    if(!CSCloseFriendInstallHook(@"WCListBaseCellView",@"setGroupItem:inGroup:",replacement,&setGroup,"v@:@@")) imp_removeBlock(replacement);
    for(NSString *name in @[@"initSharedImageView",@"initLockedImageView",@"initStatusIconImageView"]) {
        CSCFSocialHook0(@"WCListBaseCellView",name,^(id cell,void(^original)(void)){
            original(); if(CSCloseFriendHidesPrivacyIcons()) HidePrivacyViews(cell,CSCFPrivacyAlbum);
        });
    }
    CSCFSocialHook0(@"WCListBaseCellView",@"layoutStatusIconImageView",^(id cell,void(^original)(void)){
        if(CSCloseFriendHidesPrivacyIcons()) HidePrivacyViews(cell,CSCFPrivacyAlbum);
        original();
    });
    // Preserve native button creation and VM elements, including their spacing.
    CSCFSocialHook0(@"WCCommentDetailViewControllerFB",@"initTableHeaderView",^(id page,void(^original)(void)){
        original(); SetDetailPrivacyHidden(page,CSCloseFriendHidesPrivacyIcons());
        TrackPrivacyOwner(page,CSCFPrivacyDetail);
    });
    __block IMP layout=NULL;
    replacement=imp_implementationWithBlock(^double(id page){
        // Let native measurement observe its original view state, then conceal
        // the icon before this synchronous layout returns to rendering.
        SetDetailPrivacyHidden(page,NO);
        @try {return ((double(*)(id,SEL))layout)(page,NSSelectorFromString(@"layoutActionArea"));}
        @finally {SetDetailPrivacyHidden(page,CSCloseFriendHidesPrivacyIcons());}
    });
    if(!CSCloseFriendInstallHook(@"WCCommentDetailViewControllerFB",@"layoutActionArea",replacement,&layout,"d@:")) imp_removeBlock(replacement);
    CSCFSocialHook0(@"WCCommentDetailViewControllerFB",@"onShowGroup",^(__unused id page,void(^original)(void)){
        if(!CSCloseFriendHidesPrivacyIcons()) original();
    });
}
