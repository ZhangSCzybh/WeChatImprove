#import "CSCloseFriendSocialAdapter.h"
static char AudienceProjectionKey;
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
    id owner=PublishingOwner(logic); if(!owner || !AudienceKeys || !AudienceRows) return nil;
    NSArray *keys=AudienceKeys(logic,NSSelectorFromString(@"getKeysArray"));
    if(![keys isKindOfClass:NSArray.class]) return nil;
    NSMutableDictionary *sections=[NSMutableDictionary dictionary];
    for(id key in keys) { id rows=AudienceRows(logic,NSSelectorFromString(@"getContactsArrayWith:"),key); if([rows isKindOfClass:NSArray.class]) sections[key]=CSCFPageIsCurrent(owner) ? rows : @[]; }
    CSCloseFriendContactProjection *projection=[[CSCloseFriendContactProjection alloc] initWithKeys:keys sections:sections snapshot:CSCloseFriendCurrentSnapshot() surface:CSCloseFriendSurfaceContact identity:^NSString *(id item){return CSCloseFriendUserName(item);}];
    objc_setAssociatedObject(logic,&AudienceProjectionKey,projection,OBJC_ASSOCIATION_RETAIN_NONATOMIC); return projection;
}
static id Keys(id logic,SEL cmd) { CSCloseFriendContactProjection *p=Candidates(logic); return p ? p.keys : AudienceKeys(logic,cmd); }
static id Rows(id logic,SEL cmd,id key) { if(!PublishingOwner(logic)) return AudienceRows(logic,cmd,key); CSCloseFriendContactProjection *p=objc_getAssociatedObject(logic,&AudienceProjectionKey) ?: Candidates(logic); return p.sections[key] ?: @[]; }
static BOOL NeedsUnlock(id owner) {
    // Until a full native ACL merge contract exists, all edits are indivisible. Original
    // selectContacts/selectTags and pending native sets are never overwritten by projections.
    return CSCFSocialRequireAuthentication(owner,CSCloseFriendSurfaceContact) || CSCFSocialRequireAuthentication(owner,CSCloseFriendSurfaceTag);
}
static void Cover(id page) {
    BOOL concealed=CSCloseFriendSurfaceConcealed(CSCloseFriendCurrentSnapshot(),CSCloseFriendSurfaceContact) || CSCloseFriendSurfaceConcealed(CSCloseFriendCurrentSnapshot(),CSCloseFriendSurfaceTag);
    CSCFSocialGate(page,CSCloseFriendSurfaceContact,concealed);
    if(concealed && !CSCloseFriendSurfaceConcealed(CSCloseFriendCurrentSnapshot(),CSCloseFriendSurfaceContact)) CSCFSocialGate(page,CSCloseFriendSurfaceTag,YES);
}
void CSCFAudienceInstall(void) {
    for(NSString *name in @[@"viewDidLoad",@"viewDidLayoutSubviews"]) CSCFSocialHook0(@"WCMomentsPrivacyViewController",name,^(id page,void(^orig)(void)){orig(); Cover(page); CSCFSocialTrack(page,^(id owner){Cover(owner); CSCFReloadTables(owner);});});
    for(NSString *name in @[@"onDone",@"openAddFromTag",@"openAddFromFriend",@"onSaveAsNewTag"]) CSCFSocialHook0(@"WCMomentsPrivacyViewController",name,^(id owner,void(^orig)(void)){if(!NeedsUnlock(owner)) orig();});
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
