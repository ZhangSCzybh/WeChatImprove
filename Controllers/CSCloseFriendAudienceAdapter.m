#import "CSCloseFriendSocialAdapter.h"
static char AudienceBindingKey, AudiencePendingKey, AudienceOwnerRevokedKey;
@interface CSCFAudienceBinding : NSObject
@property(nonatomic,weak) id owner,logic,picker;
@property(nonatomic) NSUInteger epoch,revision,projectionEpoch,projectionRevision;
@property(nonatomic) BOOL revoked;
@property(nonatomic,strong) CSCloseFriendContactProjection *projection;
@end
@implementation CSCFAudienceBinding @end
static BOOL BindingCurrent(CSCFAudienceBinding *binding) {
    return binding && !binding.revoked && ![objc_getAssociatedObject(binding.owner,&AudienceOwnerRevokedKey) boolValue] && binding.owner && binding.logic && binding.picker && binding.epoch==CSCloseFriendAccountEpoch() && binding.revision==CSCloseFriendCurrentSnapshot().revision && CSCFPageIsCurrent(binding.owner);
}
static void ShieldPicker(id picker) {
    // A revoked operation never revives on a later reveal. Native pending selections/ACL are
    // retained; the user leaves this picker and starts a new operation on complete native data.
    if([picker isKindOfClass:UIView.class]) {UIView *view=picker; view.hidden=YES; view.userInteractionEnabled=NO; view.accessibilityElementsHidden=YES;}
}
static void RevokeBinding(CSCFAudienceBinding *binding) {
    if(!binding) return;
    binding.revoked=YES; binding.projection=nil;
    // Native completion callbacks do not all carry a picker identity. Retire this editor too;
    // otherwise a delayed old callback could be mistaken for a newly opened picker operation.
    if(binding.owner) objc_setAssociatedObject(binding.owner,&AudienceOwnerRevokedKey,@YES,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    ShieldPicker(binding.picker);
}
static void RefreshPicker(id picker) {
    CSCFAudienceBinding *binding=objc_getAssociatedObject(picker,&AudienceBindingKey);
    if(!BindingCurrent(binding)) {RevokeBinding(binding);}
    CSCFReloadTables(picker);
}
static CSCFAudienceBinding *BindPicker(id logic,id owner) {
    id picker=CSCloseFriendRead(logic,@"m_delegate");
    CSCFAudienceBinding *binding=objc_getAssociatedObject(picker,&AudienceBindingKey);
    if(!binding) {
        binding=[CSCFAudienceBinding new]; binding.owner=owner; binding.logic=logic; binding.picker=picker;
        binding.epoch=CSCloseFriendAccountEpoch(); binding.revision=CSCloseFriendCurrentSnapshot().revision;
        objc_setAssociatedObject(picker,&AudienceBindingKey,binding,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(owner,&AudiencePendingKey,binding,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        CSCFSocialTrack(picker,^(id surface){RefreshPicker(surface);});
    }
    if(binding.owner!=owner || binding.logic!=logic || !BindingCurrent(binding)) {RevokeBinding(binding);}
    return binding;
}
static BOOL PickerAllowsAction(id picker) {
    CSCFAudienceBinding *binding=objc_getAssociatedObject(picker,&AudienceBindingKey);
    if(!binding) return YES; // Not one of our positively identified publishing pickers.
    if(!BindingCurrent(binding)) {RevokeBinding(binding); return NO;}
    return !CSCloseFriendSurfaceConcealed(CSCloseFriendCurrentSnapshot(),CSCloseFriendSurfaceContact) && !CSCloseFriendSurfaceConcealed(CSCloseFriendCurrentSnapshot(),CSCloseFriendSurfaceTag);
}
static id (*AudienceKeys)(id,SEL);
static id (*AudienceRows)(id,SEL,id);
static id PublishingOwner(id logic) {
    id select=CSCloseFriendRead(logic,@"m_delegate");
    if(!CSCFIsClass(select,@"ContactSelectView")) return nil;
    id owner=CSCloseFriendRead(select,@"m_delegate");
    // This is a positively identified publishing page, never a global candidate filter.
    if(CSCFIsClass(owner,@"WCMomentsPrivacyViewController")) return owner;
    id delegate=CSCloseFriendRead(owner,@"delegate");
    return CSCFIsClass(delegate,@"WCMomentsPrivacyViewController") ? delegate : nil;
}
static CSCloseFriendContactProjection *Candidates(id logic) {
    id owner=PublishingOwner(logic);
    if(!owner) {
        id picker=CSCloseFriendRead(logic,@"m_delegate"); CSCFAudienceBinding *known=objc_getAssociatedObject(picker,&AudienceBindingKey);
        if(known) {RevokeBinding(known); return [[CSCloseFriendContactProjection alloc] initWithKeys:@[] sections:@{} snapshot:CSCloseFriendCurrentSnapshot() surface:CSCloseFriendSurfaceContact identity:^NSString *(id item){return CSCloseFriendUserName(item);}];}
        return nil;
    }
    if(!AudienceKeys || !AudienceRows) return nil;
    CSCFAudienceBinding *binding=BindPicker(logic,owner);
    NSArray *keys=AudienceKeys(logic,NSSelectorFromString(@"getKeysArray"));
    if(![keys isKindOfClass:NSArray.class]) return nil;
    NSMutableDictionary *sections=[NSMutableDictionary dictionary];
    for(id key in keys) { id rows=AudienceRows(logic,NSSelectorFromString(@"getContactsArrayWith:"),key); if([rows isKindOfClass:NSArray.class]) sections[key]=BindingCurrent(binding) ? rows : @[]; }
    CSCloseFriendContactProjection *projection=[[CSCloseFriendContactProjection alloc] initWithKeys:keys sections:sections snapshot:CSCloseFriendCurrentSnapshot() surface:CSCloseFriendSurfaceContact identity:^NSString *(id item){return CSCloseFriendUserName(item);}];
    binding.projection=projection; binding.projectionEpoch=CSCloseFriendAccountEpoch(); binding.projectionRevision=CSCloseFriendCurrentSnapshot().revision; return projection;
}
static id Keys(id logic,SEL cmd) { CSCloseFriendContactProjection *p=Candidates(logic); return p ? p.keys : AudienceKeys(logic,cmd); }
static id Rows(id logic,SEL cmd,id key) {
    id owner=PublishingOwner(logic);
    if(!owner) {
        id picker=CSCloseFriendRead(logic,@"m_delegate"); CSCFAudienceBinding *known=objc_getAssociatedObject(picker,&AudienceBindingKey);
        if(known) {RevokeBinding(known); return @[];}
        return AudienceRows(logic,cmd,key);
    }
    CSCFAudienceBinding *binding=BindPicker(logic,owner);
    if(!BindingCurrent(binding)) return @[];
    CSCloseFriendContactProjection *p=binding.projection;
    if(!p || binding.projectionEpoch!=CSCloseFriendAccountEpoch() || binding.projectionRevision!=CSCloseFriendCurrentSnapshot().revision) p=Candidates(logic);
    return p.sections[key] ?: @[];
}
static BOOL NeedsUnlock(id owner) {
    // Until a full native ACL merge contract exists, all edits are indivisible. Original
    // selectContacts/selectTags and pending native sets are never overwritten by projections.
    if([objc_getAssociatedObject(owner,&AudienceOwnerRevokedKey) boolValue]) return YES;
    CSCFAudienceBinding *pending=objc_getAssociatedObject(owner,&AudiencePendingKey);
    if(pending && !BindingCurrent(pending)) return YES;
    return CSCFSocialRequireAuthentication(owner,CSCloseFriendSurfaceContact) || CSCFSocialRequireAuthentication(owner,CSCloseFriendSurfaceTag);
}
static void Cover(id page) {
    BOOL concealed=CSCloseFriendSurfaceConcealed(CSCloseFriendCurrentSnapshot(),CSCloseFriendSurfaceContact) || CSCloseFriendSurfaceConcealed(CSCloseFriendCurrentSnapshot(),CSCloseFriendSurfaceTag);
    CSCFSocialGate(page,CSCloseFriendSurfaceContact,concealed);
    if(concealed && !CSCloseFriendSurfaceConcealed(CSCloseFriendCurrentSnapshot(),CSCloseFriendSurfaceContact)) CSCFSocialGate(page,CSCloseFriendSurfaceTag,YES);
}
void CSCFAudienceInstall(void) {
    for(NSString *name in @[@"viewDidLoad",@"viewDidLayoutSubviews"]) CSCFSocialHook0(@"WCMomentsPrivacyViewController",name,^(id page,void(^orig)(void)){orig(); Cover(page); CSCFSocialTrack(page,^(id owner){Cover(owner); CSCFReloadTables(owner);});});
    for(NSString *name in @[@"openAddFromTag",@"openAddFromFriend"]) CSCFSocialHook0(@"WCMomentsPrivacyViewController",name,^(id owner,void(^orig)(void)){
        if([objc_getAssociatedObject(owner,&AudienceOwnerRevokedKey) boolValue] || CSCFSocialRequireAuthentication(owner,CSCloseFriendSurfaceContact) || CSCFSocialRequireAuthentication(owner,CSCloseFriendSurfaceTag)) return;
        objc_setAssociatedObject(owner,&AudiencePendingKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC); orig();
    });
    for(NSString *name in @[@"onDone",@"onSaveAsNewTag"]) CSCFSocialHook0(@"WCMomentsPrivacyViewController",name,^(id owner,void(^orig)(void)){if(!NeedsUnlock(owner)) orig();});
    for(NSString *name in @[@"onMultiSelectContactReturn:",@"onMultiSelectContactReturnForSns:",@"handleMultiSelectContactReturn:",@"handleMultiSelectContactReturnForSns:",@"updateWithSelectedContactSet:"]) CSCFSocialHook1(@"WCMomentsPrivacyViewController",name,^(id owner,id argument,void(^orig)(id)){if(!NeedsUnlock(owner)) orig(argument);});
    for(NSString *name in @[@"onMultiSelectContactReturn:selectContactFromGroup:",@"handleMultiSelectContactReturn:selectContactFromGroup:",@"contactTagListViewController:didSelectContactTag:",@"tableView:didSelectRowAtIndexPath:"]) {
        __block IMP raw=NULL; SEL selector=NSSelectorFromString(name);
        IMP replacement=imp_implementationWithBlock(^(id owner,id a,id b){if(!NeedsUnlock(owner)) ((void(*)(id,SEL,id,id))raw)(owner,selector,a,b);});
        if(!CSCloseFriendInstallHook(@"WCMomentsPrivacyViewController",name,replacement,&raw,"v@:@@")) imp_removeBlock(replacement);
    }
    __block IMP mode=NULL;
    IMP replacement=imp_implementationWithBlock(^BOOL(id owner,NSInteger value){return !NeedsUnlock(owner) && ((BOOL(*)(id,SEL,NSInteger))mode)(owner,NSSelectorFromString(@"canSelectPrivacySetting:"),value);});
    if(!CSCloseFriendInstallHook(@"WCMomentsPrivacyViewController",@"canSelectPrivacySetting:",replacement,&mode,"B@:q")) imp_removeBlock(replacement);
    __block IMP completed=NULL;
    replacement=imp_implementationWithBlock(^BOOL(id owner,id contacts,BOOL finished){return !NeedsUnlock(owner) && ((BOOL(*)(id,SEL,id,BOOL))completed)(owner,NSSelectorFromString(@"onMultiSelectContactCompleted:finished:"),contacts,finished);});
    if(!CSCloseFriendInstallHook(@"WCMomentsPrivacyViewController",@"onMultiSelectContactCompleted:finished:",replacement,&completed,"B@:@B")) imp_removeBlock(replacement);
    __block IMP summary=NULL;
    replacement=imp_implementationWithBlock(^id(id owner,id contacts){id visible=[contacts isKindOfClass:NSArray.class] ? CSCFVisible(contacts,CSCloseFriendSurfaceContact) : @[]; return ((id(*)(id,SEL,id))summary)(owner,NSSelectorFromString(@"contactNamesComponentsJoinedByComma:"),visible);});
    if(!CSCloseFriendInstallHook(@"WCMomentsPrivacyViewController",@"contactNamesComponentsJoinedByComma:",replacement,&summary,"@@:@")) imp_removeBlock(replacement);
    CSCFSocialHook0(@"ContactSelectView",@"layoutSubviews",^(id picker,void(^orig)(void)){
        orig(); CSCFAudienceBinding *binding=objc_getAssociatedObject(picker,&AudienceBindingKey);
        if(binding && !BindingCurrent(binding)) RevokeBinding(binding);
    });
    for(NSString *name in @[@"didSearchViewTableSelect:",@"addSelect:",@"multiSelectWithSearchResult:"]) CSCFSocialHook1(@"ContactSelectView",name,^(id picker,id value,void(^orig)(id)){if(PickerAllowsAction(picker)) orig(value);});
    __block IMP select=NULL;
    replacement=imp_implementationWithBlock(^(id picker,id table,id path){if(PickerAllowsAction(picker)) ((void(*)(id,SEL,id,id))select)(picker,NSSelectorFromString(@"tableView:didSelectRowAtIndexPath:"),table,path);});
    if(!CSCloseFriendInstallHook(@"ContactSelectView",@"tableView:didSelectRowAtIndexPath:",replacement,&select,"v@:@@")) imp_removeBlock(replacement);
    for(NSString *name in @[@"updateMultiSelect:",@"updateMultiSelect:fromInputView:",@"updateMultiSelect:fromRecommendSection:fromInputView:",@"updateMultiSelect:fromRecommendSection:fromInputView:needReloadTableView:"]) {
        __block IMP update=NULL; SEL selector=NSSelectorFromString(name); const char *type=NULL;
        if([name isEqual:@"updateMultiSelect:"]) {type="B@:@"; replacement=imp_implementationWithBlock(^BOOL(id picker,id contact){return PickerAllowsAction(picker) && ((BOOL(*)(id,SEL,id))update)(picker,selector,contact);});}
        else if([name isEqual:@"updateMultiSelect:fromInputView:"]) {type="B@:@B"; replacement=imp_implementationWithBlock(^BOOL(id picker,id contact,BOOL input){return PickerAllowsAction(picker) && ((BOOL(*)(id,SEL,id,BOOL))update)(picker,selector,contact,input);});}
        else if([name isEqual:@"updateMultiSelect:fromRecommendSection:fromInputView:"]) {type="B@:@BB"; replacement=imp_implementationWithBlock(^BOOL(id picker,id contact,BOOL recommend,BOOL input){return PickerAllowsAction(picker) && ((BOOL(*)(id,SEL,id,BOOL,BOOL))update)(picker,selector,contact,recommend,input);});}
        else {type="B@:@BBB"; replacement=imp_implementationWithBlock(^BOOL(id picker,id contact,BOOL recommend,BOOL input,BOOL reload){return PickerAllowsAction(picker) && ((BOOL(*)(id,SEL,id,BOOL,BOOL,BOOL))update)(picker,selector,contact,recommend,input,reload);});}
        if(!CSCloseFriendInstallHook(@"ContactSelectView",name,replacement,&update,type)) imp_removeBlock(replacement);
    }
    Class logic=NSClassFromString(@"ContactsDataLogic");
    BOOL coupled=CSCloseFriendMethodMatches(class_getInstanceMethod(logic,NSSelectorFromString(@"getKeysArray")),"@@:") && CSCloseFriendMethodMatches(class_getInstanceMethod(logic,NSSelectorFromString(@"getContactsArrayWith:")),"@@:@");
    if(coupled) {
        CSCloseFriendInstallHook(@"ContactsDataLogic",@"getKeysArray",(IMP)Keys,(IMP *)&AudienceKeys,"@@:");
        CSCloseFriendInstallHook(@"ContactsDataLogic",@"getContactsArrayWith:",(IMP)Rows,(IMP *)&AudienceRows,"@@:@");
        __block IMP count=NULL;
        replacement=imp_implementationWithBlock(^unsigned int(id object){CSCloseFriendContactProjection *p=Candidates(object); return p ? (unsigned int)MIN(p.count,UINT_MAX) : ((unsigned int(*)(id,SEL))count)(object,NSSelectorFromString(@"getContactCount"));});
        if(!CSCloseFriendInstallHook(@"ContactsDataLogic",@"getContactCount",replacement,&count,"I@:")) imp_removeBlock(replacement);
    }
    CSCloseFriendRecordCapability(@"social.audience.locked-edit",NO);
}
