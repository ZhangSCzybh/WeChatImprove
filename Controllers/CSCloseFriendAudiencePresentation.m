#import "CSCloseFriendSocialAdapter.h"
#import <objc/message.h>

// The native ACL and selection dictionaries stay intact. Model getters are projected
// only during a synchronous render of the identified publishing page.
@interface CSCFAudienceDisplayScope : NSObject
@property(nonatomic,strong) id owner,model,picker;
@end
@implementation CSCFAudienceDisplayScope @end
static CSCFAudienceDisplayScope *DisplayScope; // main-thread UI calls only
static id (*PreviewContacts)(id,SEL);
static char AudienceToolSourceKey,AudienceToolOwnerKey,AudiencePreviewOwnerKey;
@interface CSCFAudienceToolOwner : NSObject
@property(nonatomic,weak) id owner;
@property(nonatomic) NSUInteger epoch;
@end
@implementation CSCFAudienceToolOwner @end

static NSArray *DisplayContacts(id contacts) {
    if([contacts isKindOfClass:NSArray.class]) return contacts;
    if([contacts isKindOfClass:NSOrderedSet.class]) return [contacts array];
    if([contacts isKindOfClass:NSSet.class]) return [contacts allObjects];
    return nil;
}
static NSArray *VisibleDisplayContacts(id owner,NSArray *source) {
    return CSCFPageIsCurrent(owner) ? CSCFVisible(source,CSCloseFriendSurfaceContact) : @[];
}
static id DisplayPickerOwner(id picker) {
    if(!CSCFIsClass(picker,@"MultiSelectContactsViewController")) return nil;
    id select=CSCloseFriendRead(picker,@"m_selectView");
    return CSCFAudiencePublishingOwner(CSCloseFriendRead(select,@"m_contactsDataLogic"));
}
static void WithAudienceDisplay(id owner,id model,id picker,void(^native)(void)) {
    if(!NSThread.isMainThread) {native(); return;}
    CSCFAudienceDisplayScope *saved=DisplayScope;
    CSCFAudienceDisplayScope *scope=nil;
    if(owner || model) {scope=[CSCFAudienceDisplayScope new]; scope.owner=owner; scope.model=model; scope.picker=picker;}
    DisplayScope=scope;
    @try {native();} @finally {DisplayScope=saved;}
}
static void RefreshAudienceTool(id tool) {
    NSArray *source=objc_getAssociatedObject(tool,&AudienceToolSourceKey);
    if(source) CSCFSetObject(tool,@"updateSelectedContacts:",source);
}
static id ToolDisplayContacts(id tool,id contacts) {
    if(!NSThread.isMainThread) return contacts;
    CSCFAudienceToolOwner *binding=objc_getAssociatedObject(tool,&AudienceToolOwnerKey);
    if(DisplayScope.picker && CSCloseFriendRead(DisplayScope.picker,@"m_toolView")==tool) {
        if(!binding) {binding=[CSCFAudienceToolOwner new]; objc_setAssociatedObject(tool,&AudienceToolOwnerKey,binding,OBJC_ASSOCIATION_RETAIN_NONATOMIC);}
        binding.owner=DisplayScope.owner; binding.epoch=CSCloseFriendAccountEpoch();
        CSCFSocialTrack(tool,^(id view){RefreshAudienceTool(view);});
    }
    if(!binding) return contacts;
    NSArray *source=DisplayContacts(contacts);
    if(!source) return contacts;
    objc_setAssociatedObject(tool,&AudienceToolSourceKey,[source copy],OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    NSArray *visible=binding.owner && binding.epoch==CSCloseFriendAccountEpoch() ? VisibleDisplayContacts(binding.owner,source) : @[];
    return [visible mutableCopy]; // ContactSelectToolView owns a mutable presentation buffer.
}
static CSCFAudienceToolOwner *PreviewBinding(id preview) {
    CSCFAudienceToolOwner *binding=objc_getAssociatedObject(preview,&AudiencePreviewOwnerKey);
    if(!binding) {
        id owner=DisplayPickerOwner(CSCloseFriendRead(preview,@"delegate"));
        if(!owner) return nil;
        binding=[CSCFAudienceToolOwner new]; binding.owner=owner; binding.epoch=CSCloseFriendAccountEpoch();
        CSCFPageIsCurrent(owner);
        objc_setAssociatedObject(preview,&AudiencePreviewOwnerKey,binding,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        CSCFSocialTrack(preview,^(id page){CSCFReloadTables(page);});
    }
    return binding;
}
static NSArray *PreviewVisibleContacts(id preview,CSCFAudienceToolOwner *binding) {
    id raw=PreviewContacts ? PreviewContacts(preview,NSSelectorFromString(@"selectedContacts")) : CSCloseFriendRead(preview,@"selectedContacts");
    NSArray *source=DisplayContacts(raw);
    return binding.owner && binding.epoch==CSCloseFriendAccountEpoch() ? VisibleDisplayContacts(binding.owner,source) : @[];
}
static BOOL PreviewPathIsVisible(id preview,CSCFAudienceToolOwner *binding,NSIndexPath *path) {
    return [path isKindOfClass:NSIndexPath.class] && path.row>=0 && (NSUInteger)path.row<PreviewVisibleContacts(preview,binding).count;
}
static void InstallAudiencePreview(void) {
    // Native tap also deselects the table's row. Keep visible index paths and scope
    // the getter instead of passing a source index path to the visible table.
    IMP replacement=imp_implementationWithBlock(^id(id preview){
        id source=PreviewContacts(preview,NSSelectorFromString(@"selectedContacts"));
        if(!NSThread.isMainThread || DisplayScope.model!=preview) return source;
        CSCFAudienceToolOwner *binding=PreviewBinding(preview);
        if(!binding) return source;
        NSArray *visible=PreviewVisibleContacts(preview,binding);
        return [source isKindOfClass:NSMutableArray.class] ? [visible mutableCopy] : visible;
    });
    if(!CSCloseFriendInstallHook(@"ContactsSelectionPreviewViewController",@"selectedContacts",replacement,(IMP *)&PreviewContacts,"@@:")) {imp_removeBlock(replacement); return;}
    __block IMP count=NULL;
    replacement=imp_implementationWithBlock(^NSInteger(id preview,id table,NSInteger section){
        CSCFAudienceToolOwner *binding=PreviewBinding(preview);
        if(!binding) return ((NSInteger(*)(id,SEL,id,NSInteger))count)(preview,NSSelectorFromString(@"tableView:numberOfRowsInSection:"),table,section);
        return (NSInteger)PreviewVisibleContacts(preview,binding).count;
    });
    if(!CSCloseFriendInstallHook(@"ContactsSelectionPreviewViewController",@"tableView:numberOfRowsInSection:",replacement,&count,"q@:@q")) imp_removeBlock(replacement);
    __block IMP cell=NULL;
    replacement=imp_implementationWithBlock(^id(id preview,id table,id path){
        CSCFAudienceToolOwner *binding=PreviewBinding(preview);
        if(binding && !PreviewPathIsVisible(preview,binding,path)) return [UITableViewCell new];
        __block id result=nil;
        WithAudienceDisplay(binding.owner,binding ? preview : nil,nil,^{result=((id(*)(id,SEL,id,id))cell)(preview,NSSelectorFromString(@"tableView:cellForRowAtIndexPath:"),table,path);});
        return result;
    });
    if(!CSCloseFriendInstallHook(@"ContactsSelectionPreviewViewController",@"tableView:cellForRowAtIndexPath:",replacement,&cell,"@@:@@")) imp_removeBlock(replacement);
    __block IMP tap=NULL;
    replacement=imp_implementationWithBlock(^(id preview,id table,id path){
        CSCFAudienceToolOwner *binding=PreviewBinding(preview);
        if(binding && !PreviewPathIsVisible(preview,binding,path)) return;
        WithAudienceDisplay(binding.owner,binding ? preview : nil,nil,^{((void(*)(id,SEL,id,id))tap)(preview,NSSelectorFromString(@"tableView:didSelectRowAtIndexPath:"),table,path);});
    });
    if(!CSCloseFriendInstallHook(@"ContactsSelectionPreviewViewController",@"tableView:didSelectRowAtIndexPath:",replacement,&tap,"v@:@@")) imp_removeBlock(replacement);
}
static void InstallPrivacyDescriptions(void) {
    // 8.0.80 renders selectedContacts via WCUIUtil; selectContactDescription is
    // only its fallback. Filter identities before either native nickname path.
    __block IMP selected=NULL;
    IMP replacement=imp_implementationWithBlock(^id(id item){
        id source=((id(*)(id,SEL))selected)(item,NSSelectorFromString(@"selectedContacts"));
        if(!NSThread.isMainThread || DisplayScope.model || !CSCFIsClass(DisplayScope.owner,@"WCMomentsPrivacyViewController")) return source;
        NSArray *list=DisplayContacts(source); if(!list) return source;
        NSArray *visible=VisibleDisplayContacts(DisplayScope.owner,list);
        if(visible.count==list.count) return source;
        if([source isKindOfClass:NSMutableSet.class]) return [NSMutableSet setWithArray:visible];
        if([source isKindOfClass:NSSet.class]) return [NSSet setWithArray:visible];
        return [source isKindOfClass:NSMutableArray.class] ? [visible mutableCopy] : visible;
    });
    if(!CSCloseFriendInstallHook(@"WCMomentsPrivacyItem",@"selectedContacts",replacement,&selected,"@@:")) imp_removeBlock(replacement);
    __block IMP description=NULL;
    replacement=imp_implementationWithBlock(^id(id item){
        id native=((id(*)(id,SEL))description)(item,NSSelectorFromString(@"selectContactDescription"));
        if(!NSThread.isMainThread || DisplayScope.model || !CSCFIsClass(DisplayScope.owner,@"WCMomentsPrivacyViewController")) return native;
        id raw=selected ? ((id(*)(id,SEL))selected)(item,NSSelectorFromString(@"selectedContacts")) : CSCloseFriendRead(item,@"selectedContacts");
        NSArray *source=DisplayContacts(raw);
        if(!source) return native;
        NSArray *visible=VisibleDisplayContacts(DisplayScope.owner,source);
        return visible.count==source.count ? native : [CSCFContactNames(visible) componentsJoinedByString:@", "];
    });
    if(!CSCloseFriendInstallHook(@"WCMomentsPrivacyItem",@"selectContactDescription",replacement,&description,"@@:")) imp_removeBlock(replacement);
    for(NSString *name in @[@"tableView:cellForRowAtIndexPath:",@"tableView:heightForRowAtIndexPath:"]) {
        __block IMP original=NULL; SEL selector=NSSelectorFromString(name);
        if([name isEqual:@"tableView:cellForRowAtIndexPath:"]) {
            replacement=imp_implementationWithBlock(^id(id page,id table,id path){
                __block id result=nil; WithAudienceDisplay(page,nil,nil,^{result=((id(*)(id,SEL,id,id))original)(page,selector,table,path);}); return result;
            });
        } else {
            replacement=imp_implementationWithBlock(^double(id page,id table,id path){
                __block double result=0; WithAudienceDisplay(page,nil,nil,^{result=((double(*)(id,SEL,id,id))original)(page,selector,table,path);}); return result;
            });
        }
        if(!CSCloseFriendInstallHook(@"WCMomentsPrivacyViewController",name,replacement,&original,[name isEqual:@"tableView:cellForRowAtIndexPath:"] ? "@@:@@" : "d@:@@")) imp_removeBlock(replacement);
    }
}
static void InstallLastAudience(void) {
    __block IMP contacts=NULL;
    IMP replacement=imp_implementationWithBlock(^id(id setting){
        id source=((id(*)(id,SEL))contacts)(setting,NSSelectorFromString(@"selectContacts"));
        if(!NSThread.isMainThread || DisplayScope.model!=setting || !CSCFIsClass(DisplayScope.owner,@"WCNewCommitViewController")) return source;
        NSArray *list=DisplayContacts(source); if(!list) return source;
        NSArray *visible=VisibleDisplayContacts(DisplayScope.owner,list);
        if(visible.count==list.count) return source;
        return [source isKindOfClass:NSMutableArray.class] ? [visible mutableCopy] : visible;
    });
    if(!CSCloseFriendInstallHook(@"WCCommitPrivacySetting",@"selectContacts",replacement,&contacts,"@@:")) imp_removeBlock(replacement);
    CSCFSocialHook1(@"WCNewCommitViewController",@"makeLastSelectTagCell:",^(id page,id cell,void(^orig)(id)){
        CSCFPageIsCurrent(page);
        CSCFSocialTrack(page,^(id editor){CSCFReloadTables(editor);});
        WithAudienceDisplay(page,CSCloseFriendRead(page,@"lastPostPrivacySetting"),nil,^{orig(cell);});
    });
    // 8.0.80.34 added cellManager: and a separate summary row; retain the older
    // one-argument hook above for versions which still advertise that signature.
    for(NSString *name in @[@"makeLastSelectTagCell:cellManager:",@"makeLastSelectTagSummaryCell:cellManager:"]) {
        __block IMP original=NULL; SEL selector=NSSelectorFromString(name);
        replacement=imp_implementationWithBlock(^(id page,id cell,id manager){
            CSCFPageIsCurrent(page);
            CSCFSocialTrack(page,^(id editor){CSCFReloadTables(editor);});
            WithAudienceDisplay(page,CSCloseFriendRead(page,@"lastPostPrivacySetting"),nil,^{((void(*)(id,SEL,id,id))original)(page,selector,cell,manager);});
        });
        if(!CSCloseFriendInstallHook(@"WCNewCommitViewController",name,replacement,&original,"v@:@@")) imp_removeBlock(replacement);
    }
}
void CSCFAudiencePresentationInstall(void) {
    CSCFSocialHook1(@"ContactSelectToolView",@"updateSelectedContacts:",^(id tool,id contacts,void(^orig)(id)){orig(ToolDisplayContacts(tool,contacts));});
    for(NSString *name in @[@"updateToolViewSelectedContacts",@"updateSelectedHeadImgView",@"updatePanelBtnAndToolViewSelectedContacts",@"updateMultiSelectView"]) {
        CSCFSocialHook0(@"MultiSelectContactsViewController",name,^(id picker,void(^orig)(void)){
            WithAudienceDisplay(DisplayPickerOwner(picker),nil,picker,orig);
        });
    }
    CSCFSocialHook0(@"MultiSelectContactsViewController",@"viewDidLoad",^(id picker,void(^orig)(void)){
        orig();
        if(DisplayPickerOwner(picker)) CSCFCallVoid(picker,@"updateToolViewSelectedContacts");
    });
    InstallAudiencePreview(); InstallPrivacyDescriptions(); InstallLastAudience();
}
