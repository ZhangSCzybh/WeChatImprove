#import "../Controllers/CSCloseFriendContactAdapter.h"
#import <objc/message.h>
#import "../Controllers/CSCloseFriendGroupListAdapter.h"
@interface CSCFContactsCache : NSObject
@property(nonatomic,strong) CSCloseFriendContactProjection *projection;
@property(nonatomic,copy) NSArray *keys;
@property(nonatomic,copy) NSDictionary *sections;
@property(nonatomic,copy) NSString *accountID;
@property(nonatomic) NSUInteger revision,epoch;
@end
@implementation CSCFContactsCache @end
@interface CSCFContactsIndexRead : NSObject
@property(nonatomic,weak) id logic;
@property(nonatomic,strong) CSCloseFriendContactProjection *projection;
@property(nonatomic,copy) NSString *accountID;
@property(nonatomic) NSUInteger revision,epoch;
@end
@implementation CSCFContactsIndexRead @end
// Only the synchronous native index-title builder owns this scope; never a reload,
// run-loop turn, cell callback or time-based cache.
static CSCFContactsIndexRead *ContactsIndexRead;
static char ProjectionKey;
static id (*OriginalKeys)(id,SEL);
static id (*OriginalRows)(id,SEL,id);
static CSCloseFriendContactProjection *Project(id logic) {
    CSCloseFriendSurface surface;
    if(!OriginalKeys || !OriginalRows || !CSCFContactLogicSurface(logic,&surface)) return nil;
    CSCloseFriendSnapshot *snapshot=CSCloseFriendCurrentSnapshot();
    if(![snapshot concealsSurface:surface]) {objc_setAssociatedObject(logic,&ProjectionKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);return nil;}
    NSUInteger epoch=CSCloseFriendAccountEpoch();
    CSCFContactsIndexRead *read=NSThread.isMainThread && ContactsIndexRead.logic==logic ? ContactsIndexRead : nil;
    if(read.projection && read.revision==snapshot.revision && read.epoch==epoch && [read.accountID isEqual:snapshot.accountID]) return read.projection;
    NSArray *keys=OriginalKeys(logic,NSSelectorFromString(@"getKeysArray"));
    if(![keys isKindOfClass:NSArray.class])return nil;
    CSCFContactsCache *cache=objc_getAssociatedObject(logic,&ProjectionKey);
    BOOL same=cache && cache.revision==snapshot.revision && cache.epoch==epoch && [cache.accountID isEqual:snapshot.accountID] && [cache.keys isEqualToArray:keys];
    NSMutableDictionary *sections=same ? nil : [NSMutableDictionary dictionary];
    for(id key in keys) {
        id rows=OriginalRows(logic,NSSelectorFromString(@"getContactsArrayWith:"),key);
        if(![rows isKindOfClass:NSArray.class])rows=@[];
        if(same && ![cache.sections[key] isEqualToArray:rows]) {same=NO;sections=[cache.sections mutableCopy];}
        if(!same)sections[key]=[rows copy];
    }
    if(!same) {
        cache=[CSCFContactsCache new]; cache.keys=[keys copy]; cache.sections=sections;
        cache.revision=snapshot.revision; cache.epoch=epoch; cache.accountID=snapshot.accountID;
        cache.projection=[[CSCloseFriendContactProjection alloc] initWithKeys:keys sections:sections snapshot:snapshot surface:surface identity:^NSString *(id item){return CSCloseFriendUserName(item);}];
    }
    CSCloseFriendSnapshot *latest=CSCloseFriendCurrentSnapshot();
    if(epoch!=CSCloseFriendAccountEpoch() || latest.revision!=snapshot.revision || ![latest.accountID isEqual:snapshot.accountID]) {
        read.projection=nil; objc_setAssociatedObject(logic,&ProjectionKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return [[CSCloseFriendContactProjection alloc] initWithKeys:@[] sections:@{} snapshot:latest surface:surface identity:^NSString *(id item){return CSCloseFriendUserName(item);}];
    }
    objc_setAssociatedObject(logic,&ProjectionKey,cache,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    read.projection=cache.projection; read.revision=snapshot.revision; read.epoch=epoch; read.accountID=snapshot.accountID;
    return cache.projection;
}
static id Keys(id self,SEL cmd) {CSCloseFriendContactProjection *p=Project(self);return p ? p.keys : OriginalKeys(self,cmd);}
static id Rows(id self,SEL cmd,id key) {
    CSCloseFriendSurface surface;if(!CSCFContactLogicSurface(self,&surface))return OriginalRows(self,cmd,key);
    CSCloseFriendSnapshot *snapshot=CSCloseFriendCurrentSnapshot();
    if(![snapshot concealsSurface:surface])return OriginalRows(self,cmd,key);
    CSCFContactsCache *cache=objc_getAssociatedObject(self,&ProjectionKey);
    CSCloseFriendContactProjection *p=cache && cache.revision==snapshot.revision && cache.epoch==CSCloseFriendAccountEpoch() && [cache.accountID isEqual:snapshot.accountID] ? cache.projection : Project(self);
    return p.sections[key] ?: @[];
}
static void InstallContactIndexRead(void) {
    // WeChat 8.0.78: 0x1010edbb8 and 0x1010edc08 read getKeysArray twice,
    // with only count + appending to a NEW local array in between. No source writes.
    __block IMP original=NULL;
    IMP replacement=imp_implementationWithBlock(^id(id owner,id table){
        id logic=CSCloseFriendRead(owner,@"m_contactsDataLogic");
        if(!NSThread.isMainThread || !logic || table!=CSCloseFriendRead(owner,@"m_tableView") || CSCloseFriendRead(logic,@"m_delegate")!=owner)
            return ((id(*)(id,SEL,id))original)(owner,NSSelectorFromString(@"mmsectionIndexTitlesForTableView:"),table);
        CSCFContactsIndexRead *previous=ContactsIndexRead;
        // Unexpected native reentry starts a fresh verification for both scopes.
        previous.projection=nil;
        CSCFContactsIndexRead *read=[CSCFContactsIndexRead new]; read.logic=logic; ContactsIndexRead=read;
        @try {return ((id(*)(id,SEL,id))original)(owner,NSSelectorFromString(@"mmsectionIndexTitlesForTableView:"),table);}
        @finally {read.projection=nil; ContactsIndexRead=previous;}
    });
    if(!CSCloseFriendInstallHook(@"ContactsViewController",@"mmsectionIndexTitlesForTableView:",replacement,&original,"@@:@")) imp_removeBlock(replacement);
}

static void Hook0(NSString *cls,NSString *name,void (^body)(id,void(^)(void))) {
    __block IMP original=NULL; SEL selector=NSSelectorFromString(name);
    IMP replacement=imp_implementationWithBlock(^(id object){body(object,^{((void(*)(id,SEL))original)(object,selector);});});
    if(!CSCloseFriendInstallHook(cls,name,replacement,&original,"v@:")) imp_removeBlock(replacement);
}
static void Hook1(NSString *cls,NSString *name,void (^body)(id,id,void(^)(id))) {
    __block IMP original=NULL; SEL selector=NSSelectorFromString(name);
    IMP replacement=imp_implementationWithBlock(^(id object,id argument){body(object,argument,^(id value){((void(*)(id,SEL,id))original)(object,selector,value);});});
    if(!CSCloseFriendInstallHook(cls,name,replacement,&original,"v@:@")) imp_removeBlock(replacement);
}
static void FilterGetter(NSString *cls,NSString *name,CSCloseFriendSurface surface) {
    __block IMP original=NULL; SEL selector=NSSelectorFromString(name);
    IMP replacement=imp_implementationWithBlock(^id(id object){id rows=((id(*)(id,SEL))original)(object,selector); CSCFTrackSurface(object,@""); return CSCFVisible(rows,surface);});
    if(!CSCloseFriendInstallHook(cls,name,replacement,&original,"@@:")) imp_removeBlock(replacement);
}
static void Predicate(NSString *cls,NSString *name,CSCloseFriendSurface surface) {
    __block IMP original=NULL; SEL selector=NSSelectorFromString(name);
    IMP replacement=imp_implementationWithBlock(^BOOL(id object,id contact){if(CSCFIsClass(object,@"SessionSelectController") && !CSCFAllowSelection(object,contact ? @[contact] : @[])) return NO; return !CSCloseFriendShouldHideUserName(CSCloseFriendUserName(contact),surface) && ((BOOL(*)(id,SEL,id))original)(object,selector,contact);});
    if(!CSCloseFriendInstallHook(cls,name,replacement,&original,"B@:@")) imp_removeBlock(replacement);
}
static void SearchCallback(NSString *cls,NSString *name) {
    __block IMP original=NULL; SEL selector=NSSelectorFromString(name);
    IMP replacement=imp_implementationWithBlock(^(id object,id keys,id titles,id sections){
        CSCloseFriendSnapshot *snapshot=CSCloseFriendCurrentSnapshot();
        BOOL forwarding=CSCFIsClass(object,@"SessionSelectController") || CSCFIsClass(CSCloseFriendRead(object,@"m_delegate"),@"SessionSelectController");
        if(forwarding && !CSCFPageIsCurrent(object)) {keys=@[]; titles=@{}; sections=@{};}
        if(forwarding && CSCloseFriendSurfaceConcealed(snapshot,CSCloseFriendSurfaceForward)) {
            if([keys isKindOfClass:NSArray.class] && [sections isKindOfClass:NSDictionary.class]) {
                CSCloseFriendContactProjection *p=[[CSCloseFriendContactProjection alloc] initWithKeys:keys sections:sections snapshot:snapshot surface:CSCloseFriendSurfaceForward identity:^NSString *(id item){return CSCloseFriendUserName(item);}];
                keys=[p.keys mutableCopy]; NSMutableDictionary *rows=[NSMutableDictionary dictionary];
                for(id key in p.keys) rows[key]=[p.sections[key] mutableCopy]; sections=rows;
                if([titles isKindOfClass:NSDictionary.class]) { NSMutableDictionary *visible=[NSMutableDictionary dictionary]; for(id key in keys) if(titles[key]) visible[key]=titles[key]; titles=visible; }
            } else { keys=@[]; titles=@{}; sections=@{}; }
        }
        ((void(*)(id,SEL,id,id,id))original)(object,selector,keys,titles,sections);
    });
    if(!CSCloseFriendInstallHook(cls,name,replacement,&original,"v@:@@@")) imp_removeBlock(replacement);
}
static void InstallContacts(void) {
    // Install the coupled key/row contract only when BOTH signatures match.
    Class logic=NSClassFromString(@"ContactsDataLogic");
    BOOL coupled=CSCloseFriendMethodMatches(class_getInstanceMethod(logic,NSSelectorFromString(@"getKeysArray")),"@@:") && CSCloseFriendMethodMatches(class_getInstanceMethod(logic,NSSelectorFromString(@"getContactsArrayWith:")),"@@:@");
    if(coupled) {
        CSCloseFriendInstallHook(@"ContactsDataLogic",@"getContactsArrayWith:",(IMP)Rows,(IMP *)&OriginalRows,"@@:@");
        CSCloseFriendInstallHook(@"ContactsDataLogic",@"getKeysArray",(IMP)Keys,(IMP *)&OriginalKeys,"@@:");
        __block IMP count=NULL;
        IMP replacement=imp_implementationWithBlock(^unsigned int(id object){CSCloseFriendContactProjection *p=Project(object); return p ? (unsigned int)MIN(p.count,UINT_MAX) : ((unsigned int(*)(id,SEL))count)(object,NSSelectorFromString(@"getContactCount"));});
        if(!CSCloseFriendInstallHook(@"ContactsDataLogic",@"getContactCount",replacement,&count,"I@:")) imp_removeBlock(replacement);
        InstallContactIndexRead();
    }
    FilterGetter(@"ContactsViewController",@"favourContactArray",CSCloseFriendSurfaceContact);
    FilterGetter(@"RecentForwardScrollView",@"contactsForRecentForwardMenu",CSCloseFriendSurfaceForward);
    FilterGetter(@"SessionSelectView",@"recentForwardContacts",CSCloseFriendSurfaceForward);
    for(NSString *cls in @[@"SessionSelectView",@"RecentForwardScrollView"]) {
        NSString *name=[cls isEqual:@"SessionSelectView"] ? @"hasRecentForwardSessions" : @"hasRecentForward";
        NSString *getter=[cls isEqual:@"SessionSelectView"] ? @"recentForwardContacts" : @"contactsForRecentForwardMenu";
        __block IMP original=NULL; SEL selector=NSSelectorFromString(name);
        IMP replacement=imp_implementationWithBlock(^BOOL(id object){
            if(!((BOOL(*)(id,SEL))original)(object,selector)) return NO;
            if(!CSCloseFriendSurfaceConcealed(CSCloseFriendCurrentSnapshot(),CSCloseFriendSurfaceForward)) return YES;
            id rows=CSCloseFriendRead(object,getter); return [rows isKindOfClass:NSArray.class] && [rows count]>0;
        });
        if(!CSCloseFriendInstallHook(cls,name,replacement,&original,"B@:")) imp_removeBlock(replacement);
    }
    Hook0(@"RecentForwardScrollView",@"initView",^(id object,void(^orig)(void)){orig(); CSCFTrackSurface(object,@"initView");});
    Hook1(@"RecentForwardScrollView",@"onItemClick:",^(id object,id gesture,void(^orig)(id)){
        UIView *view=[gesture isKindOfClass:UIGestureRecognizer.class] ? [gesture view] : nil;
        NSArray *icons=CSCloseFriendRead(object,@"iconViews");
        if(!view || ![icons isKindOfClass:NSArray.class] || view.tag<0 || (NSUInteger)view.tag>=icons.count) return;
        id contact=CSCloseFriendRead(icons[(NSUInteger)view.tag],@"oContact");
        if(!CSCloseFriendShouldHideUserName(CSCloseFriendUserName(contact),CSCloseFriendSurfaceForward)) orig(gesture);
    });
    Predicate(@"SessionSelectView",@"filterContact:",CSCloseFriendSurfaceForward);
    Predicate(@"SessionSelectView",@"canMultiSelectContact:",CSCloseFriendSurfaceForward);
    Predicate(@"SessionSelectController",@"onShouldSelectContact:",CSCloseFriendSurfaceForward);
    Hook0(@"SessionSelectView",@"initData",^(id object,void(^orig)(void)){orig(); CSCFTrackSurface(object,@"initData");});
    Hook1(@"SessionSelectView",@"onFTSContactSearchFinish:",^(id object,id result,void(^orig)(id)){
        if(!CSCFPageIsCurrent(object)) return; CSCFForwardSearchWillUpdate(object);
        @try { orig(result); } @finally { CSCFForwardSearchDidUpdate(object); }
    });
    Hook0(@"SessionSelectView",@"mergeMessageSearchResultsAndNotify",^(id object,void(^orig)(void)){
        if(!CSCFPageIsCurrent(object)) return; CSCFForwardSearchWillUpdate(object);
        @try { orig(); } @finally { CSCFForwardSearchDidUpdate(object); }
    });
    __block IMP include=NULL;
    IMP includeReplacement=imp_implementationWithBlock(^BOOL(id object,id logic,id contact){
        // Only the message-origin candidate route is gated; ordinary contact/group search remains intact.
        return !CSCloseFriendSurfaceConcealed(CSCloseFriendCurrentSnapshot(),CSCloseFriendSurfaceForward) && CSCFPageIsCurrent(object) && !CSCloseFriendShouldHideUserName(CSCloseFriendUserName(contact),CSCloseFriendSurfaceForward) && ((BOOL(*)(id,SEL,id,id))include)(object,NSSelectorFromString(@"sessionSelectMessageSearchLogic:shouldIncludeContact:"),logic,contact);
    });
    if(!CSCloseFriendInstallHook(@"SessionSelectView",@"sessionSelectMessageSearchLogic:shouldIncludeContact:",includeReplacement,&include,"B@:@@")) imp_removeBlock(includeReplacement);
    Hook0(@"SessionSelectController",@"viewDidLoad",^(id object,void(^orig)(void)){CSCFBeginSelection(object); orig();});
    Hook1(@"SessionSelectController",@"onSelectDoneWithContacts:",^(id object,id contacts,void(^orig)(id)){
        if([contacts isKindOfClass:NSArray.class] && CSCFAllowSelection(object,contacts)) orig(contacts);
    });
    for(NSString *name in @[@"onMultiDone",@"onMultiDoneInPageSheetMode"]) Hook0(@"SessionSelectController",name,^(id object,void(^orig)(void)){
        NSArray *contacts=CSCFCurrentForwardRecipients(object);
        if([contacts isKindOfClass:NSArray.class] && CSCFAllowSelection(object,contacts)) orig();
    });
    for(NSString *name in @[@"contactSelectorViewController:didSelectContact:",@"contactSelectorViewController:didFinishMultiplySelectingContacts:"]) {
        __block IMP original=NULL; SEL selector=NSSelectorFromString(name);
        IMP replacement=imp_implementationWithBlock(^(id object,id picker,id value){
            NSArray *recipients=[value isKindOfClass:NSArray.class] ? value : (value ? @[value] : @[]);
            if(CSCFAllowSelection(object,recipients)) ((void(*)(id,SEL,id,id))original)(object,selector,picker,value);
        });
        if(!CSCloseFriendInstallHook(@"SessionSelectController",name,replacement,&original,"v@:@@")) imp_removeBlock(replacement);
    }
    SearchCallback(@"SessionSelectController",@"onSessionSelectSearchSessions:sectionTitles:sectionResults:");
    SearchCallback(@"ContactSelectView",@"onContactAsynSearchSectionResultChanged:sectionTitles:sectionResults:");
    Hook1(@"ContactTagNewDetailViewController",@"processContactSectionData:",^(id object,id contact,void(^orig)(id)){
        CSCFTrackSurface(object,@"reloadDataAndView"); if(!CSCloseFriendShouldHideUserName(CSCloseFriendUserName(contact),CSCloseFriendSurfaceTag)) orig(contact);
    });
    Hook0(@"ContactTagNewDetailViewController",@"reloadDataAndView",^(id object,void(^orig)(void)){orig(); CSCFUpdateTagDetail(object);});
    // Generic editors / ACL selectors keep complete memberships. Block destructive or full replacement
    // entry while hidden; authenticate and require a fresh operation against restored native data.
    for(NSString *name in @[@"onTapDeleteTag",@"onClickAddMember",@"onClickRemoveMember"]) Hook0(@"ContactTagNewDetailViewController",name,^(id object,void(^orig)(void)){if(!CSCFRequireTagAuthentication(object)) orig();});
    for(NSString *name in @[@"onMultiSelectContactReturn:",@"doAddTagMembers:",@"doRemoveTagMembers:",@"realDoRemoveTagMembers:"]) Hook1(@"ContactTagNewDetailViewController",name,^(id object,id argument,void(^orig)(id)){if(!CSCFRequireTagAuthentication(object)) orig(argument);});
    for(NSString *name in @[@"onContactTagListBottomBarEditTags",@"onContactTagListBottomBarDelete",@"onContactTagListBottomBarMoveTo"]) Hook0(@"ContactTagListViewController",name,^(id object,void(^orig)(void)){if(!CSCFRequireTagAuthentication(object)) orig();});
    __block IMP summary=NULL;
    IMP replacement=imp_implementationWithBlock(^(id object,id cell,id tag,id text){((void(*)(id,SEL,id,id,id))summary)(object,NSSelectorFromString(@"makeContactItemCellContent:withTagData:searchText:"),cell,tag,text); CSCFUpdateTagSummary(cell,tag); CSCFTrackSurface(object,@"reloadDataAndView");});
    if(!CSCloseFriendInstallHook(@"ContactTagListViewController",@"makeContactItemCellContent:withTagData:searchText:",replacement,&summary,"v@:@@@")) imp_removeBlock(replacement);
    __block IMP simpleSummary=NULL;
    replacement=imp_implementationWithBlock(^(id object,id cell,id tag){((void(*)(id,SEL,id,id))simpleSummary)(object,NSSelectorFromString(@"makeContactItemCellContent:withTagData:"),cell,tag); CSCFUpdateTagSummary(cell,tag); CSCFTrackSurface(object,@"reloadDataAndView");});
    if(!CSCloseFriendInstallHook(@"ContactTagListViewController",@"makeContactItemCellContent:withTagData:",replacement,&simpleSummary,"v@:@@")) imp_removeBlock(replacement);
    // Tag search has no proven isolated result contract. Gate it before search, without changing members.
    __block IMP tagSearch=NULL;
    replacement=imp_implementationWithBlock(^(id object,id text,BOOL prefix){if(!CSCFRequireTagAuthentication(object)) ((void(*)(id,SEL,id,BOOL))tagSearch)(object,NSSelectorFromString(@"doSearch:Pre:"),text,prefix);});
    if(!CSCloseFriendInstallHook(@"ContactTagNewDetailViewController",@"doSearch:Pre:",replacement,&tagSearch,"v@:@B")) imp_removeBlock(replacement);
    CSCloseFriendRecordCapability(@"contacts.presentation",coupled);
    CSCloseFriendRecordCapability(@"tags.search.filtered",NO);
    CSCloseFriendRecordCapability(@"forward.message-search.filtered",NO);
}
%ctor { dispatch_async(dispatch_get_main_queue(),^{ InstallContacts(); CSCFGroupListInstall(); }); }
