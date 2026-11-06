#import "CSCloseFriendGroupListAdapter.h"
#import <objc/message.h>

// This wrapper belongs only to Contacts > Group Chats. The original member logic
// retains complete membership/search data and receives all mutations unchanged.
@interface CSCFGroupListData : NSObject
@property(nonatomic,strong) id native;
@property(nonatomic,weak) id owner;
@property(nonatomic,strong) CSCloseFriendContactProjection *projection;
@property(nonatomic) NSUInteger revision, renderedRevision;
- (void)invalidate;
@end
@implementation CSCFGroupListData
- (BOOL)respondsToSelector:(SEL)selector { return [super respondsToSelector:selector] || [self.native respondsToSelector:selector]; }
- (BOOL)conformsToProtocol:(Protocol *)protocol { return [super conformsToProtocol:protocol] || [self.native conformsToProtocol:protocol]; }
- (id)forwardingTargetForSelector:(SEL)selector { return [self.native respondsToSelector:selector] ? self.native : [super forwardingTargetForSelector:selector]; }
- (void)invalidate { self.projection=nil; }
- (CSCloseFriendContactProjection *)visible {
    CSCloseFriendSnapshot *snapshot=CSCloseFriendCurrentSnapshot();
    if(!self.projection || self.revision!=snapshot.revision || !CSCFPageIsCurrent(self.owner)) {
        NSArray *keys=CSCloseFriendRead(self.native,@"getKeyArray");
        NSMutableDictionary *sections=[NSMutableDictionary dictionary];
        if(!CSCFPageIsCurrent(self.owner) || ![keys isKindOfClass:NSArray.class]) keys=@[];
        for(NSUInteger section=0;section<keys.count;section++) {
            NSMutableArray *rows=[NSMutableArray array];
            NSUInteger count=((NSUInteger(*)(id,SEL,NSUInteger))objc_msgSend)(self.native,NSSelectorFromString(@"getSectionItemCount:"),section);
            for(NSUInteger row=0;row<count;row++) {
                id contact=((id(*)(id,SEL,NSUInteger,NSUInteger))objc_msgSend)(self.native,NSSelectorFromString(@"getItemInSection:atRow:"),section,row);
                if(contact) [rows addObject:contact];
            }
            sections[keys[section]]=rows;
        }
        self.projection=[[CSCloseFriendContactProjection alloc] initWithKeys:keys sections:sections snapshot:snapshot surface:CSCloseFriendSurfaceContact identity:^NSString *(id contact){return CSCloseFriendUserName(contact);}];
        self.revision=snapshot.revision;
    }
    return self.projection;
}
- (NSArray *)getKeyArray { return self.visible.keys; }
- (NSUInteger)getSectionCount { self.renderedRevision=CSCloseFriendCurrentSnapshot().revision; return self.visible.keys.count; }
- (id)getKeyAtSection:(NSUInteger)section { NSArray *keys=self.visible.keys; return section<keys.count ? keys[section] : nil; }
- (NSArray *)rows:(NSUInteger)section { id key=[self getKeyAtSection:section]; return key ? self.visible.sections[key] : @[]; }
- (NSUInteger)getSectionItemCount:(NSUInteger)section { self.renderedRevision=CSCloseFriendCurrentSnapshot().revision; return [self rows:section].count; }
- (id)getItemInSection:(NSUInteger)section atRow:(NSUInteger)row { NSArray *rows=[self rows:section]; return row<rows.count ? rows[row] : nil; }
- (NSUInteger)getTotalCount { return self.visible.count; }
- (NSArray *)filter:(id)source { return CSCFPageIsCurrent(self.owner) ? CSCFVisible(source,CSCloseFriendSurfaceContact) : @[]; }
- (NSArray *)getAllContacts { return [self filter:CSCloseFriendRead(self.native,@"getAllContacts")]; }
- (NSMutableArray *)getFilteredContacts { return [[self filter:CSCloseFriendRead(self.native,@"getFilteredContacts")] mutableCopy]; }
- (NSMutableArray *)filtContactsByName:(NSArray *)names { return [[self filter:((id(*)(id,SEL,id))objc_msgSend)(self.native,_cmd,names)] mutableCopy]; }
- (void)reloadMemberList:(id)contacts { [self invalidate]; ((void(*)(id,SEL,id))objc_msgSend)(self.native,_cmd,contacts); }
- (void)addContact:(id)contact { [self invalidate]; ((void(*)(id,SEL,id))objc_msgSend)(self.native,_cmd,contact); }
- (BOOL)removeContact:(id)contact { [self invalidate]; return ((BOOL(*)(id,SEL,id))objc_msgSend)(self.native,_cmd,contact); }
- (void)sortKeys { [self invalidate]; ((void(*)(id,SEL))objc_msgSend)(self.native,_cmd); }
@end
static CSCFGroupListData *GroupData(id owner) {
    id data=CSCloseFriendRead(owner,@"m_memberData");
    return [data isKindOfClass:CSCFGroupListData.class] ? data : nil;
}
static void RefreshGroupSearch(id owner) {
    CSCFGroupListData *data=GroupData(owner); if(!data) return;
    // The native search table reads WCDataSearcher's arrResult for count, cells
    // and taps. Rebuild this presentation buffer from the unmodified search data.
    CSCFSetObject(CSCloseFriendRead(owner,@"_searcher"),@"setArrResult:",[data getFilteredContacts]);
}
static BOOL GroupSelectionCurrent(id owner) {
    CSCFGroupListData *data=GroupData(owner);
    return !data || (CSCFPageIsCurrent(owner) && data.renderedRevision==CSCloseFriendCurrentSnapshot().revision);
}
void CSCFGroupListInstall(void) {
    NSDictionary *contracts=@{@"getKeyArray":@"@@:",@"getSectionItemCount:":@"Q@:Q",@"getItemInSection:atRow:":@"@@:QQ",@"getFilteredContacts":@"@@:"};
    BOOL ready=YES;
    for(NSString *name in contracts) ready &= CSCloseFriendMethodMatches(class_getInstanceMethod(NSClassFromString(@"MemberDataLogic"),NSSelectorFromString(name)),[contracts[name] UTF8String]);
    CSCloseFriendRecordCapability(@"contacts.group-list",ready);
    if(!ready) return;
    __block IMP set=NULL;
    IMP replacement=imp_implementationWithBlock(^(id owner,id native){
        if(CSCFIsClass(owner,@"ChatRoomListViewController") && CSCFIsClass(native,@"MemberDataLogic")) {
            CSCFGroupListData *data=[CSCFGroupListData new]; data.native=native; data.owner=owner;
            data.renderedRevision=CSCloseFriendCurrentSnapshot().revision;
            CSCFTrackSurface(owner,@"reloadTable"); native=data;
        }
        ((void(*)(id,SEL,id))set)(owner,NSSelectorFromString(@"setMemberLogic:"),native);
    });
    if(!CSCloseFriendInstallHook(@"ChatRoomListViewController",@"setMemberLogic:",replacement,&set,"v@:@")) imp_removeBlock(replacement);
    __block IMP reload=NULL;
    replacement=imp_implementationWithBlock(^(id owner){
        [GroupData(owner) invalidate]; RefreshGroupSearch(owner);
        ((void(*)(id,SEL))reload)(owner,NSSelectorFromString(@"reloadTable"));
    });
    if(!CSCloseFriendInstallHook(@"ChatRoomListViewController",@"reloadTable",replacement,&reload,"v@:")) imp_removeBlock(replacement);
    __block IMP search=NULL;
    replacement=imp_implementationWithBlock(^(id owner,id query,BOOL prefix){
        ((void(*)(id,SEL,id,BOOL))search)(owner,NSSelectorFromString(@"doSearch:Pre:"),query,prefix);
        GroupData(owner).renderedRevision=CSCloseFriendCurrentSnapshot().revision;
    });
    if(!CSCloseFriendInstallHook(@"ChatRoomListViewController",@"doSearch:Pre:",replacement,&search,"v@:@B")) imp_removeBlock(replacement);
    __block IMP select=NULL;
    replacement=imp_implementationWithBlock(^(id owner,id table,id path){
        if(GroupSelectionCurrent(owner)) ((void(*)(id,SEL,id,id))select)(owner,NSSelectorFromString(@"tableView:didSelectRowAtIndexPath:"),table,path);
    });
    if(!CSCloseFriendInstallHook(@"ChatRoomListViewController",@"tableView:didSelectRowAtIndexPath:",replacement,&select,"v@:@@")) imp_removeBlock(replacement);
    __block IMP searchSelect=NULL;
    replacement=imp_implementationWithBlock(^(id owner,id path){
        if(GroupSelectionCurrent(owner)) ((void(*)(id,SEL,id))searchSelect)(owner,NSSelectorFromString(@"didSearchViewTableSelect:"),path);
    });
    if(!CSCloseFriendInstallHook(@"ChatRoomListViewController",@"didSearchViewTableSelect:",replacement,&searchSelect,"v@:@")) imp_removeBlock(replacement);
    __block IMP jump=NULL;
    replacement=imp_implementationWithBlock(^(id owner,id contact){
        if(CSCFPageIsCurrent(owner) && !CSCloseFriendShouldHideUserName(CSCloseFriendUserName(contact),CSCloseFriendSurfaceContact))
            ((void(*)(id,SEL,id))jump)(owner,NSSelectorFromString(@"JumpToChatRoom:"),contact);
    });
    if(!CSCloseFriendInstallHook(@"ChatRoomListViewController",@"JumpToChatRoom:",replacement,&jump,"v@:@")) imp_removeBlock(replacement);
}
