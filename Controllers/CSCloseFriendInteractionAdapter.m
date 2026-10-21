#import "CSCloseFriendSocialAdapter.h"
#import <objc/message.h>
static char MessagesKey;
static BOOL UnreadDisplay;
static id MessageCountingOwner;
static id DiscoveryCountingOwner;
static id (*NativeUnread)(id,SEL);
BOOL CSCFUnreadBegin(void) { BOOL previous=UnreadDisplay; if(NSThread.isMainThread) UnreadDisplay=YES; return previous; }
void CSCFUnreadEnd(BOOL previous) { if(NSThread.isMainThread) UnreadDisplay=previous; }
static NSUInteger VisibleUnread(id page) {
    id facade=CSCFTimelineFacade(page);
    return facade && NativeUnread && CSCFPageIsCurrent(page) ? CSCFSocialProject(NativeUnread(facade,NSSelectorFromString(@"getUnReadMessages")),CSCloseFriendSurfaceInteraction).visible.count : 0;
}
static CSCloseFriendSocialProjection *Messages(id page) {
    NSArray *source=CSCloseFriendRead(page,@"_arrCommentList");
    CSCloseFriendSocialProjection *projection=CSCFSocialProject(CSCFPageIsCurrent(page) ? source : @[],CSCloseFriendSurfaceInteraction);
    objc_setAssociatedObject(page,&MessagesKey,projection,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    CSCFSocialTrack(page,^(id owner){
        objc_setAssociatedObject(owner,&MessagesKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        CSCFSocialClearCaches(owner,@[@"_dicCells",@"_dicCellHeights"]); CSCFReloadTables(owner);
    }); return projection;
}
static NSIndexPath *MessagePath(id page,NSIndexPath *path) {
    CSCloseFriendSocialProjection *projection=objc_getAssociatedObject(page,&MessagesKey) ?: Messages(page);
    if(!CSCFPageIsCurrent(page) || ![path isKindOfClass:NSIndexPath.class]) return nil;
    NSArray *live=CSCloseFriendRead(page,@"_arrCommentList");
    if(![live isKindOfClass:NSArray.class] || path.row<0) return nil;
    NSUInteger index=[projection sourceIndex:(NSUInteger)path.row];
    if(index!=NSNotFound) {
        // Native cell/height callbacks dereference the current page array, not our immutable
        // snapshot. Never forward a coordinate whose live object was replaced/reordered.
        id visible=projection.visible[(NSUInteger)path.row];
        if(index>=live.count || live[index]!=visible || CSCFSocialHidden(visible,CSCloseFriendSurfaceInteraction)) return nil;
    } else {
        // A trailing native load-more row is safe only while the source boundary is unchanged.
        if(live.count!=projection.source.count || (NSUInteger)path.row<projection.visible.count) return nil;
        index=live.count+((NSUInteger)path.row-projection.visible.count);
    }
    return [NSIndexPath indexPathForRow:(NSInteger)index inSection:path.section];
}
static BOOL MessageActionCurrent(id page,NSIndexPath *path) {
    CSCloseFriendSocialProjection *old=objc_getAssociatedObject(page,&MessagesKey);
    if(!old || !CSCFPageIsCurrent(page) || (NSUInteger)path.row>=old.visible.count) return NO;
    id message=old.visible[(NSUInteger)path.row];
    NSArray *source=CSCloseFriendRead(page,@"_arrCommentList"); NSUInteger original=[old sourceIndex:(NSUInteger)path.row];
    return original<source.count && source[original]==message && !CSCFSocialHidden(message,CSCloseFriendSurfaceInteraction);
}
static void TableMethod(NSString *name,const char *type) {
    __block IMP raw=NULL; SEL selector=NSSelectorFromString(name); IMP replacement=NULL;
    if(!strcmp(type,"@@:@@")) replacement=imp_implementationWithBlock(^id(id page,id table,NSIndexPath *path){NSIndexPath *native=MessagePath(page,path); return native ? ((id(*)(id,SEL,id,id))raw)(page,selector,table,native) : [UITableViewCell new];});
    else if(!strcmp(type,"d@:@@")) replacement=imp_implementationWithBlock(^double(id page,id table,NSIndexPath *path){NSIndexPath *native=MessagePath(page,path); return native ? ((double(*)(id,SEL,id,id))raw)(page,selector,table,native) : 0;});
    else if(!strcmp(type,"v@:@@")) replacement=imp_implementationWithBlock(^(id page,id table,NSIndexPath *path){if(!MessageActionCurrent(page,path)) return; NSIndexPath *native=MessagePath(page,path); if(native) ((void(*)(id,SEL,id,id))raw)(page,selector,table,native);});
    if(replacement && !CSCloseFriendInstallHook(@"WCCommentListViewController",name,replacement,&raw,type)) imp_removeBlock(replacement);
}
// The discovery row reads getSnsMessageCount, while the tab aggregate reads
// numberOfUnreadAtMomentCell. Preserve their native reminder-partition choice.
static BOOL DiscoveryCommentInteger(id comment,NSString *name,int *value) {
    SEL selector=NSSelectorFromString(name);
    if(!CSCloseFriendMethodMatches(class_getInstanceMethod([comment class],selector),"i@:")) return NO;
    *value=((int(*)(id,SEL))objc_msgSend)(comment,selector); return YES;
}
static BOOL DiscoveryRelatedMessage(id message,BOOL *known) {
    id comment=CSCloseFriendRead(message,@"comment"); int type=0,flags=0;
    *known=DiscoveryCommentInteger(comment,@"type",&type) && DiscoveryCommentInteger(comment,@"commentFlag",&flags);
    if(!*known) return NO;
    // MyWCDB isMessageRelatedToMe: uses the server action's type/flag/referrer;
    // WCMessageFromDBMessage: preserves these in WCUserComment and refComment.
    NSString *referrer=CSCloseFriendRead(CSCloseFriendRead(message,@"refComment"),@"username");
    return type==4 || (flags & (1<<17))!=0 || ([referrer isKindOfClass:NSString.class] && [referrer isEqual:CSCloseFriendCurrentSnapshot().accountID]);
}
static unsigned int DiscoveryUnreadCount(id facade,NSString *name,unsigned int nativeCount) {
    if(!CSCFPageIsCurrent(DiscoveryCountingOwner) || CSCloseFriendCurrentSnapshot().blocked || !NativeUnread) return 0;
    NSArray *source=NativeUnread(facade,NSSelectorFromString(@"getUnReadMessages"));
    if(![source isKindOfClass:NSArray.class]) return 0;
    BOOL total=[name isEqual:@"getUnReadMessageCount"];
    BOOL related=[name isEqual:@"getUnReadMessageCountReleatedToMe"];
    NSUInteger removed=0;
    for(id message in source) {
        if(!CSCFSocialHidden(message,CSCloseFriendSurfaceInteraction)) continue;
        if(!total) {
            BOOL known=NO,isRelated=DiscoveryRelatedMessage(message,&known);
            if(!known) return 0;
            if(isRelated!=related) continue;
        }
        removed++;
    }
    // Only the display count changes. Native arrays, hasRead flags and cached
    // notification-manager counts never receive the filtered list or count.
    return nativeCount-(unsigned int)MIN((NSUInteger)nativeCount,removed);
}
static void InstallUnread(void) {
    __block IMP unread=NULL;
    IMP replacement=imp_implementationWithBlock(^id(id facade){id rows=((id(*)(id,SEL))unread)(facade,NSSelectorFromString(@"getUnReadMessages")); return UnreadDisplay && NSThread.isMainThread ? CSCFSocialProject(rows,CSCloseFriendSurfaceInteraction).visible : rows;});
    if(CSCloseFriendInstallHook(@"WCFacade",@"getUnReadMessages",replacement,&unread,"@@:")) NativeUnread=(void *)unread; else imp_removeBlock(replacement);
    for(NSString *name in @[@"getUnReadMessageCount",@"getUnReadMessageCountForMutualFriends",@"getUnReadMessageCountReleatedToMe"]) {
        __block IMP raw=NULL; SEL selector=NSSelectorFromString(name);
        replacement=imp_implementationWithBlock(^unsigned int(id facade){
            if(UnreadDisplay && NSThread.isMainThread && CSCloseFriendSurfaceConcealed(CSCloseFriendCurrentSnapshot(),CSCloseFriendSurfaceInteraction)) {
                if(DiscoveryCountingOwner) return DiscoveryUnreadCount(facade,name,((unsigned int(*)(id,SEL))raw)(facade,selector));
                // Other surfaces retain their existing partition fallback.
                if(![name isEqual:@"getUnReadMessageCount"] || !NativeUnread) return 0;
                return (unsigned int)MIN(CSCFSocialProject(NativeUnread(facade,NSSelectorFromString(@"getUnReadMessages")),CSCloseFriendSurfaceInteraction).visible.count,UINT_MAX);
            }
            return ((unsigned int(*)(id,SEL))raw)(facade,selector);
        });
        if(!CSCloseFriendInstallHook(@"WCFacade",name,replacement,&raw,"I@:")) imp_removeBlock(replacement);
    }
    __block IMP last=NULL;
    replacement=imp_implementationWithBlock(^id(id facade){id message=((id(*)(id,SEL))last)(facade,NSSelectorFromString(@"getLastUnReadMessage")); return UnreadDisplay && NSThread.isMainThread && CSCFSocialHidden(message,CSCloseFriendSurfaceInteraction) ? nil : message;});
    if(!CSCloseFriendInstallHook(@"WCFacade",@"getLastUnReadMessage",replacement,&last,"@@:")) imp_removeBlock(replacement);
    __block IMP limit=NULL;
    replacement=imp_implementationWithBlock(^id(id facade,int count){id rows=((id(*)(id,SEL,int))limit)(facade,NSSelectorFromString(@"getUnReadMessagesLimit:"),count); return UnreadDisplay && NSThread.isMainThread ? CSCFSocialProject(rows,CSCloseFriendSurfaceInteraction).visible : rows;});
    if(!CSCloseFriendInstallHook(@"WCFacade",@"getUnReadMessagesLimit:",replacement,&limit,"@@:i")) imp_removeBlock(replacement);
    for(NSString *name in @[@"onMessageUnReadCountChanged",@"checkNewMessage"]) CSCFSocialHook0(@"WCTimeLineViewController",name,^(id page,void(^orig)(void)){
        BOOL saved=UnreadDisplay; UnreadDisplay=NSThread.isMainThread && CSCFPageIsCurrent(page); @try {orig();} @finally {UnreadDisplay=saved;}
    });
    __block IMP tip=NULL;
    replacement=imp_implementationWithBlock(^NSInteger(id page){BOOL saved=UnreadDisplay; UnreadDisplay=NSThread.isMainThread; @try {return !CSCFPageIsCurrent(page) ? 0 : CSCloseFriendSurfaceConcealed(CSCloseFriendCurrentSnapshot(),CSCloseFriendSurfaceInteraction) ? (NSInteger)VisibleUnread(page) : ((NSInteger(*)(id,SEL))tip)(page,NSSelectorFromString(@"messageTipCount"));} @finally {UnreadDisplay=saved;} });
    if(!CSCloseFriendInstallHook(@"WCTimeLineViewController",@"messageTipCount",replacement,&tip,"q@:")) imp_removeBlock(replacement);
    __block IMP has=NULL;
    replacement=imp_implementationWithBlock(^BOOL(id page){BOOL saved=UnreadDisplay; UnreadDisplay=NSThread.isMainThread; @try {return CSCFPageIsCurrent(page) && (CSCloseFriendSurfaceConcealed(CSCloseFriendCurrentSnapshot(),CSCloseFriendSurfaceInteraction) ? VisibleUnread(page)>0 : ((BOOL(*)(id,SEL))has)(page,NSSelectorFromString(@"hasUnReadMessage")));} @finally {UnreadDisplay=saved;} });
    if(!CSCloseFriendInstallHook(@"WCTimeLineViewController",@"hasUnReadMessage",replacement,&has,"B@:")) imp_removeBlock(replacement);
    __block IMP avatar=NULL;
    replacement=imp_implementationWithBlock(^id(id page){id username=((id(*)(id,SEL))avatar)(page,NSSelectorFromString(@"messageTipUserName")); return !CSCFPageIsCurrent(page) || CSCFSocialHidden(username,CSCloseFriendSurfaceInteraction) ? nil : username;});
    if(!CSCloseFriendInstallHook(@"WCTimeLineViewController",@"messageTipUserName",replacement,&avatar,"@@:")) imp_removeBlock(replacement);

}
static BOOL DiscoveryConcealed(id page) {
    return !CSCFPageIsCurrent(page) || CSCloseFriendSurfaceConcealed(CSCloseFriendCurrentSnapshot(),CSCloseFriendSurfaceInteraction) || CSCloseFriendSurfaceConcealed(CSCloseFriendCurrentSnapshot(),CSCloseFriendSurfaceTimeline);
}
static void DiscoveryCounters(void) {
    __block IMP badge=NULL;
    IMP replacement=imp_implementationWithBlock(^BOOL(id page){return !DiscoveryConcealed(page) && ((BOOL(*)(id,SEL))badge)(page,NSSelectorFromString(@"badgeAtMomentCell"));});
    if(!CSCloseFriendInstallHook(@"FindFriendEntryViewController",@"badgeAtMomentCell",replacement,&badge,"B@:")) imp_removeBlock(replacement);
    for(NSString *name in @[@"getSnsMessageCount",@"numberOfUnreadAtMomentCell"]) {
        __block IMP count=NULL; SEL selector=NSSelectorFromString(name);
        replacement=imp_implementationWithBlock(^NSInteger(id page){
            if(!NSThread.isMainThread) return ((NSInteger(*)(id,SEL))count)(page,selector);
            if(!CSCFPageIsCurrent(page)) return 0;
            BOOL saved=UnreadDisplay; id previous=DiscoveryCountingOwner;
            UnreadDisplay=YES; DiscoveryCountingOwner=page;
            @try { return ((NSInteger(*)(id,SEL))count)(page,selector); }
            @finally { UnreadDisplay=saved; DiscoveryCountingOwner=previous; }
        });
        if(!CSCloseFriendInstallHook(@"FindFriendEntryViewController",name,replacement,&count,"q@:")) imp_removeBlock(replacement);
    }
}
static char DiscoveryViewKey;
static void DiscoveryViews(id page) {
    BOOL hidden=DiscoveryConcealed(page);
    for(NSString *key in @[@"m_timelineHeadView",@"m_timelineRedDotView"]) {
        UIView *view=CSCloseFriendRead(page,key); if(![view isKindOfClass:UIView.class]) continue;
        NSArray *saved=objc_getAssociatedObject(view,&DiscoveryViewKey);
        if(hidden) {
            if(!saved) objc_setAssociatedObject(view,&DiscoveryViewKey,@[@(view.hidden),@(view.accessibilityElementsHidden),@(view.userInteractionEnabled),@(view.isAccessibilityElement)],OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            view.hidden=YES; view.accessibilityElementsHidden=YES; view.userInteractionEnabled=NO; view.isAccessibilityElement=NO;
        } else if(saved) {
            view.hidden=[saved[0] boolValue]; view.accessibilityElementsHidden=[saved[1] boolValue]; view.userInteractionEnabled=[saved[2] boolValue]; view.isAccessibilityElement=[saved[3] boolValue];
            objc_setAssociatedObject(view,&DiscoveryViewKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    CSCFSocialTrack(page,^(id owner){
        DiscoveryViews(owner);
        // Native refresh rebuilds the existing Moments row and the tab aggregate;
        // it does not mark interaction messages read or change source records.
        if(CSCFPageIsCurrent(owner)) CSCFCallVoid(owner,@"onMessageUnReadCountChanged");
    });
}
static void InstallDiscovery(void) {
    DiscoveryCounters();
    CSCFSocialHook1(@"FindFriendEntryViewController",@"updateWCTimeLineView:",^(id page,id cell,void(^orig)(id)){orig(cell); DiscoveryViews(page);});
    CSCFSocialHook0(@"FindFriendEntryViewController",@"reloadData",^(id page,void(^orig)(void)){orig(); DiscoveryViews(page);});
    CSCFSocialHook0(@"FindFriendEntryViewController",@"onMessageUnReadCountChanged",^(id page,void(^orig)(void)){orig(); DiscoveryViews(page);});
    __block IMP appear=NULL;
    IMP replacement=imp_implementationWithBlock(^(id page,BOOL animated){
        ((void(*)(id,SEL,BOOL))appear)(page,NSSelectorFromString(@"viewWillAppear:"),animated);
        if(CSCFPageIsCurrent(page)) CSCFCallVoid(page,@"onMessageUnReadCountChanged");
        DiscoveryViews(page);
    });
    if(!CSCloseFriendInstallHook(@"FindFriendEntryViewController",@"viewWillAppear:",replacement,&appear,"v@:B")) imp_removeBlock(replacement);
}
void CSCFInteractionInstall(void) {
    InstallUnread(); InstallDiscovery();
    BOOL ready=YES;
    NSDictionary *contracts=@{@"getWCCommentListCount:":@"q@:q",@"tableView:numberOfRowsInSection:":@"q@:@q",@"tableView:cellForRowAtIndexPath:":@"@@:@@",@"tableView:heightForRowAtIndexPath:":@"d@:@@",@"tableView:didSelectRowAtIndexPath:":@"v@:@@"};
    for(NSString *selector in contracts) ready &= CSCloseFriendMethodMatches(class_getInstanceMethod(NSClassFromString(@"WCCommentListViewController"),NSSelectorFromString(selector)),[contracts[selector] UTF8String]);
    CSCloseFriendRecordCapability(@"social.interactions.coupled",ready);
    if(!ready) {CSCFSocialProtectRoute(@"WCCommentListViewController",CSCloseFriendSurfaceInteraction); return;}

    __block IMP count=NULL;
    IMP replacement=imp_implementationWithBlock(^NSInteger(id page,NSInteger section){if(MessageCountingOwner==page) return (NSInteger)Messages(page).visible.count; return ((NSInteger(*)(id,SEL,NSInteger))count)(page,NSSelectorFromString(@"getWCCommentListCount:"),section);});
    if(!CSCloseFriendInstallHook(@"WCCommentListViewController",@"getWCCommentListCount:",replacement,&count,"q@:q")) imp_removeBlock(replacement);
    __block IMP rows=NULL;
    replacement=imp_implementationWithBlock(^NSInteger(id page,id table,NSInteger section){
        id previous=MessageCountingOwner; MessageCountingOwner=page;
        @try { return ((NSInteger(*)(id,SEL,id,NSInteger))rows)(page,NSSelectorFromString(@"tableView:numberOfRowsInSection:"),table,section); }
        @finally { MessageCountingOwner=previous; }
    });
    if(!CSCloseFriendInstallHook(@"WCCommentListViewController",@"tableView:numberOfRowsInSection:",replacement,&rows,"q@:@q")) imp_removeBlock(replacement);
    TableMethod(@"tableView:cellForRowAtIndexPath:","@@:@@"); TableMethod(@"tableView:heightForRowAtIndexPath:","d@:@@");
    TableMethod(@"tableView:didSelectRowAtIndexPath:","v@:@@"); TableMethod(@"tableView:accessoryButtonTappedForRowWithIndexPath:","v@:@@");
    // No filtered list is passed to native mark-read/delete code; those whole-list operations
    // require a fresh revealed operation. Source pagination arrays remain completely native.
    for(NSString *name in @[@"markMessageAllRead",@"clearList",@"onDeleteData"]) CSCFSocialHook0(@"WCCommentListViewController",name,^(id page,void(^orig)(void)){
        if(CSCFPageIsCurrent(page) && !CSCloseFriendSurfaceConcealed(CSCloseFriendCurrentSnapshot(),CSCloseFriendSurfaceInteraction)) orig();
    });
    __block IMP edit=NULL;
    replacement=imp_implementationWithBlock(^(id page,id table,NSInteger style,NSIndexPath *path){if(CSCFSocialRequireAuthentication(page,CSCloseFriendSurfaceInteraction)) return; if(MessageActionCurrent(page,path)) ((void(*)(id,SEL,id,NSInteger,id))edit)(page,NSSelectorFromString(@"tableView:commitEditingStyle:forRowAtIndexPath:"),table,style,MessagePath(page,path));});
    if(!CSCloseFriendInstallHook(@"WCCommentListViewController",@"tableView:commitEditingStyle:forRowAtIndexPath:",replacement,&edit,"v@:@q@")) imp_removeBlock(replacement);

}
