#import "CSCloseFriendSocialAdapter.h"
#import <objc/message.h>
static char GateKey, PrivacyKey;
@interface CSCFSocialCover : UIButton
@property(nonatomic,weak) UIViewController *owner;
@property(nonatomic) CSCloseFriendSurface surface;
@property(nonatomic) BOOL originalHidden;
@property(nonatomic) BOOL originalAccessibility;
@property(nonatomic,copy) NSArray *rightItems;
@property(nonatomic,copy) NSString *title;
@end
@implementation CSCFSocialCover
- (void)unlock { CSCFSocialRequireAuthentication(self.owner,self.surface); }
@end
CSCloseFriendSocialProjection *CSCFSocialProject(NSArray *source,CSCloseFriendSurface surface) {
    return [[CSCloseFriendSocialProjection alloc] initWithSource:source snapshot:CSCloseFriendCurrentSnapshot() surface:surface read:^id(id item,NSString *key){return CSCloseFriendRead(item,key);}];
}
BOOL CSCFSocialHidden(id object,CSCloseFriendSurface surface) { return CSCloseFriendSocialObjectHidden(object,CSCloseFriendCurrentSnapshot(),surface,^id(id item,NSString *key){return CSCloseFriendRead(item,key);}); }
void CSCFSocialTrack(id owner,void (^refresh)(id)) {
    if(!owner || !NSThread.isMainThread) return;
    CSCFPageIsCurrent(owner);
    static NSMapTable *pages; static dispatch_once_t once;
    dispatch_once(&once,^{
        pages=[NSMapTable weakToStrongObjectsMapTable];
        [NSNotificationCenter.defaultCenter addObserverForName:CSCloseFriendPolicyDidChangeNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(__unused NSNotification *note){
            for(id page in pages.keyEnumerator.allObjects) { void(^update)(id)=[pages objectForKey:page]; update(page); }
        }];
    });
    [pages setObject:[refresh copy] forKey:owner];
}
BOOL CSCFSocialGate(id object,CSCloseFriendSurface surface,BOOL force) {
    if(![object isKindOfClass:UIViewController.class]) return force;
    UIViewController *owner=object;
    BOOL blocked=!CSCFPageIsCurrent(owner) || (force && CSCloseFriendSurfaceConcealed(CSCloseFriendCurrentSnapshot(),surface));
    if(!owner.isViewLoaded) return blocked;
    CSCFSocialCover *cover=objc_getAssociatedObject(owner,&GateKey);
    if(blocked) {
        if(!cover) {
            cover=[CSCFSocialCover buttonWithType:UIButtonTypeSystem]; cover.owner=owner; cover.surface=surface;
            cover.rightItems=owner.navigationItem.rightBarButtonItems; cover.title=owner.navigationItem.title;
            cover.originalHidden=owner.view.hidden; cover.originalAccessibility=owner.view.accessibilityElementsHidden;
            cover.backgroundColor=UIColor.systemBackgroundColor; [cover setTitle:@"解锁后查看" forState:UIControlStateNormal];
            [cover addTarget:cover action:@selector(unlock) forControlEvents:UIControlEventTouchUpInside];
            objc_setAssociatedObject(owner,&GateKey,cover,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        // Cover all native content and navigation items. No source loading/deletion is synthesized.
        owner.view.accessibilityElementsHidden=YES; owner.view.hidden=YES;
        UIView *host=owner.view.superview;
        if(host) { cover.frame=owner.view.frame; cover.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight; [host addSubview:cover]; [host bringSubviewToFront:cover]; }
        if(owner.navigationController.topViewController==owner) {owner.navigationItem.rightBarButtonItems=@[]; owner.navigationItem.title=@"隐私保护";}
    } else if(cover) {
        owner.navigationItem.rightBarButtonItems=cover.rightItems; owner.navigationItem.title=cover.title;
        owner.view.hidden=cover.originalHidden; owner.view.accessibilityElementsHidden=cover.originalAccessibility;
        [cover removeFromSuperview]; objc_setAssociatedObject(owner,&GateKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return blocked;
}
BOOL CSCFSocialRequireAuthentication(id object,CSCloseFriendSurface surface) {
    if(!CSCFPageIsCurrent(object)) return YES;
    if(!CSCloseFriendSurfaceConcealed(CSCloseFriendCurrentSnapshot(),surface)) return NO;
    if([object isKindOfClass:UIViewController.class]) {
        NSUInteger epoch=CSCloseFriendAccountEpoch(); __weak id owner=object;
        CSCloseFriendAuthenticate(object,^(BOOL ok){
            if(ok && owner && epoch==CSCloseFriendAccountEpoch() && !CSCloseFriendSurfaceConcealed(CSCloseFriendCurrentSnapshot(),surface)) CSCFReloadTables(owner);
            // Never replay an edit or gesture captured under another policy.
        });
    } return YES;
}
void CSCFSocialHook0(NSString *cls,NSString *name,void (^body)(id,void(^)(void))) {
    __block IMP original=NULL; SEL selector=NSSelectorFromString(name);
    IMP replacement=imp_implementationWithBlock(^(id object){body(object,^{((void(*)(id,SEL))original)(object,selector);});});
    if(!CSCloseFriendInstallHook(cls,name,replacement,&original,"v@:")) imp_removeBlock(replacement);
}
void CSCFSocialHook1(NSString *cls,NSString *name,void (^body)(id,id,void(^)(id))) {
    __block IMP original=NULL; SEL selector=NSSelectorFromString(name);
    IMP replacement=imp_implementationWithBlock(^(id object,id arg){body(object,arg,^(id value){((void(*)(id,SEL,id))original)(object,selector,value);});});
    if(!CSCloseFriendInstallHook(cls,name,replacement,&original,"v@:@")) imp_removeBlock(replacement);
}
BOOL CSCFSocialSetIvar(id owner,NSString *name,id value) {
    Ivar ivar=class_getInstanceVariable([owner class],name.UTF8String);
    if(!ivar || ivar_getTypeEncoding(ivar)[0]!='@') return NO;
    object_setIvar(owner,ivar,value); return YES;
}
void CSCFSocialClearCaches(id owner,NSArray<NSString *> *names) {
    for(NSString *name in names) { id cache=CSCloseFriendRead(owner,name); if([cache isKindOfClass:NSMutableDictionary.class]) [cache removeAllObjects]; }
}
static void Privacy(id cell) {
    UIView *button=CSCloseFriendRead(cell,@"m_privacyButton");
    if(![button isKindOfClass:UIView.class]) return;
    if(CSCloseFriendHidesPrivacyIcons()) {
        if(!objc_getAssociatedObject(cell,&PrivacyKey)) objc_setAssociatedObject(cell,&PrivacyKey,@[@(button.userInteractionEnabled),@(button.isAccessibilityElement),@(button.accessibilityElementsHidden)],OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        button.userInteractionEnabled=NO; button.isAccessibilityElement=NO; button.accessibilityElementsHidden=YES;
        // Native layout tests superview, not hidden. Removal collapses the owned 8pt spacing too.
        UIView *parent=button.superview; NSArray *elements=parent.accessibilityElements;
        if([elements containsObject:button]) { NSMutableArray *updated=[elements mutableCopy]; [updated removeObjectIdenticalTo:button]; parent.accessibilityElements=updated; }
        [button removeFromSuperview];
    } else {
        NSArray *saved=objc_getAssociatedObject(cell,&PrivacyKey);
        if(saved) { button.userInteractionEnabled=[saved[0] boolValue]; button.isAccessibilityElement=[saved[1] boolValue]; button.accessibilityElementsHidden=[saved[2] boolValue]; objc_setAssociatedObject(cell,&PrivacyKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            // Rebuild native targets and hierarchy from the intact source data item.
            CSCFSetObject(cell,@"initPrivacyButton:",CSCloseFriendRead(cell,@"m_dataItem"));
        }
    }
}
void CSCFSocialProtectRoute(NSString *cls,CSCloseFriendSurface surface) {
    for(NSString *name in @[@"viewDidLoad",@"viewDidLayoutSubviews"]) CSCFSocialHook0(cls,name,^(id owner,void(^orig)(void)){
        orig(); CSCloseFriendSurface effective=surface==CSCloseFriendSurfaceTimeline && CSCloseFriendSurfaceConcealed(CSCloseFriendCurrentSnapshot(),CSCloseFriendSurfaceInteraction) ? CSCloseFriendSurfaceInteraction : surface;
        CSCFSocialGate(owner,effective,YES);
        CSCFSocialTrack(owner,^(id page){CSCloseFriendSurface current=surface==CSCloseFriendSurfaceTimeline && CSCloseFriendSurfaceConcealed(CSCloseFriendCurrentSnapshot(),CSCloseFriendSurfaceInteraction) ? CSCloseFriendSurfaceInteraction : surface; CSCFSocialGate(page,current,YES);});
    });
}
void CSCFSocialInstall(void) {
    CSCFSocialHook1(@"WCTimeLineCellView",@"initPrivacyButton:",^(id cell,id item,void(^orig)(id)){ orig(item); Privacy(cell); CSCFSocialTrack(cell,^(id c){Privacy(c); [c setNeedsLayout];}); });
    CSCFSocialHook0(@"WCTimeLineCellView",@"layoutSubviews",^(id cell,void(^orig)(void)){Privacy(cell); orig();});
    CSCFSocialHook0(@"WCTimeLineCellView",@"onShowGroup",^(__unused id cell,void(^orig)(void)){if(!CSCloseFriendHidesPrivacyIcons()) orig();});
    CSCFTimelineInstall(); CSCFInteractionInstall(); CSCFStatusInstall(); CSCFAudienceInstall();
}
