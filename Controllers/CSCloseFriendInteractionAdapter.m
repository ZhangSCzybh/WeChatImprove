#import "CSCloseFriendSocialAdapter.h"
#import <objc/message.h>
static char MessagesKey;
static BOOL UnreadDisplay;
static id MessageCountingOwner;
static id DiscoveryCountingOwner;
static NSMutableDictionary *DiscoveryCounts;
static id (*NativeUnread)(id,SEL);
static NSMutableDictionary *UnreadProjections;
static NSUInteger UnreadEpoch, UnreadRevision;
static NSString *UnreadAccount;
BOOL CSCFUnreadBegin(void) {
    BOOL previous=UnreadDisplay;
    if(NSThread.isMainThread) {
        if(!previous) UnreadProjections=[NSMutableDictionary dictionary];
        UnreadDisplay=YES;
    }
    return previous;
}
void CSCFUnreadEnd(BOOL previous) {
    if(!NSThread.isMainThread)return;
    UnreadDisplay=previous;
    if(!previous)UnreadProjections=nil;
}
static CSCloseFriendSocialProjection *UnreadProjection(id facade) {
    CSCloseFriendSnapshot *snapshot=CSCloseFriendCurrentSnapshot();
    NSUInteger epoch=CSCloseFriendAccountEpoch();
    if(UnreadEpoch!=epoch || UnreadRevision!=snapshot.revision || ![UnreadAccount isEqual:snapshot.accountID]) {
        [UnreadProjections removeAllObjects];
        UnreadEpoch=epoch; UnreadRevision=snapshot.revision; UnreadAccount=snapshot.accountID;
    }
    NSValue *key=[NSValue valueWithNonretainedObject:facade];
    CSCloseFriendSocialProjection *projection=UnreadProjections[key];
    if(!projection) {
        NSArray *source=!snapshot.blocked && NativeUnread ? NativeUnread(facade,NSSelectorFromString(@"getUnReadMessages")) : @[];
        if(epoch!=CSCloseFriendAccountEpoch() || snapshot.revision!=CSCloseFriendCurrentSnapshot().revision)source=@[];
        projection=CSCFSocialProject(source,CSCloseFriendSurfaceInteraction);
        if(UnreadProjections)UnreadProjections[key]=projection;
    }
    return projection;
}
static NSUInteger VisibleUnread(id page) {
    id facade=CSCFTimelineFacade(page);
    return facade && NativeUnread && CSCFPageIsCurrent(page) ? UnreadProjection(facade).visible.count : 0;
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
    if(!NSThread.isMainThread || !old || !CSCFPageIsCurrent(page) || ![path isKindOfClass:NSIndexPath.class] || path.row<0 || (NSUInteger)path.row>=old.visible.count) return NO;
    id message=old.visible[(NSUInteger)path.row];
    NSArray *source=CSCloseFriendRead(page,@"_arrCommentList"); NSUInteger original=[old sourceIndex:(NSUInteger)path.row];
    return [source isKindOfClass:NSArray.class] && original<source.count && source[original]==message && !CSCFSocialHidden(message,CSCloseFriendSurfaceInteraction);
}
static void TableMethod(NSString *name,const char *type) {
    __block IMP raw=NULL; SEL selector=NSSelectorFromString(name); IMP replacement=NULL;
    if(!strcmp(type,"@@:@@")) replacement=imp_implementationWithBlock(^id(id page,id table,NSIndexPath *path){NSIndexPath *native=MessagePath(page,path); return native ? ((id(*)(id,SEL,id,id))raw)(page,selector,table,native) : [UITableViewCell new];});
    else if(!strcmp(type,"d@:@@")) replacement=imp_implementationWithBlock(^double(id page,id table,NSIndexPath *path){NSIndexPath *native=MessagePath(page,path); return native ? ((double(*)(id,SEL,id,id))raw)(page,selector,table,native) : 0;});
    else if(!strcmp(type,"v@:@@")) replacement=imp_implementationWithBlock(^(id page,id table,NSIndexPath *path){
        if(!MessageActionCurrent(page,path)) {
            // The native load-more row follows the projected messages. It has no
            // message identity, so validate the entire unchanged source boundary.
            CSCloseFriendSocialProjection *projection=objc_getAssociatedObject(page,&MessagesKey);
            NSArray *live=CSCloseFriendRead(page,@"_arrCommentList");
            if(!NSThread.isMainThread || !CSCFPageIsCurrent(page) || !projection ||
               ![path isKindOfClass:NSIndexPath.class] || path.row!=(NSInteger)projection.visible.count ||
               ![live isKindOfClass:NSArray.class] || live.count!=projection.source.count) return;
            for(NSUInteger i=0;i<live.count;i++) if(live[i]!=projection.source[i]) return;
        }
        NSIndexPath *native=MessagePath(page,path);
        if(native) ((void(*)(id,SEL,id,id))raw)(page,selector,table,native);
    });
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
    if(!CSCFPageIsCurrent(DiscoveryCountingOwner) || CSCloseFriendCurrentSnapshot().blocked || !NativeUnread)return 0;
    CSCloseFriendSnapshot *snapshot=CSCloseFriendCurrentSnapshot();
    NSArray *key=@[[NSValue valueWithNonretainedObject:facade],@(CSCloseFriendAccountEpoch()),@(snapshot.revision),snapshot.accountID];
    NSArray *counts=DiscoveryCounts[key];
    if(!counts) {
        NSArray *source=UnreadProjection(facade).source;
        if(![source isKindOfClass:NSArray.class])return 0;
        NSUInteger total=0,related=0,mutual=0; BOOL partitionsKnown=YES;
        for(id message in source) {
            if(!CSCFSocialHidden(message,CSCloseFriendSurfaceInteraction))continue;
            total++;
            BOOL known=NO,isRelated=DiscoveryRelatedMessage(message,&known);
            partitionsKnown &= known;
            if(isRelated)related++;else mutual++;
        }
        counts=@[@(total),@(related),@(mutual),@(partitionsKnown)];
        if(DiscoveryCounts)DiscoveryCounts[key]=counts;
    }
    NSUInteger index=[name isEqual:@"getUnReadMessageCount"] ? 0 : [name isEqual:@"getUnReadMessageCountReleatedToMe"] ? 1 : 2;
    if(index && ![counts[3] boolValue])return 0;
    return nativeCount-(unsigned int)MIN((NSUInteger)nativeCount,[counts[index] unsignedIntegerValue]);
}
static void DiscoveryWithCounts(id page,void (^native)(void)) {
    id previous=DiscoveryCountingOwner; NSMutableDictionary *counts=DiscoveryCounts;
    if(!NSThread.isMainThread) {native();return;}
    BOOL unread=CSCFUnreadBegin(); DiscoveryCountingOwner=page;
    if(previous!=page || !DiscoveryCounts)DiscoveryCounts=[NSMutableDictionary dictionary];
    @try {native();} @finally {DiscoveryCountingOwner=previous; DiscoveryCounts=counts; CSCFUnreadEnd(unread);}
}
static void InstallUnread(void) {
    __block IMP unread=NULL;
    IMP replacement=imp_implementationWithBlock(^id(id facade){
        return UnreadDisplay && NSThread.isMainThread ? UnreadProjection(facade).visible : ((id(*)(id,SEL))unread)(facade,NSSelectorFromString(@"getUnReadMessages"));
    });
    if(CSCloseFriendInstallHook(@"WCFacade",@"getUnReadMessages",replacement,&unread,"@@:")) NativeUnread=(void *)unread; else imp_removeBlock(replacement);
    for(NSString *name in @[@"getUnReadMessageCount",@"getUnReadMessageCountForMutualFriends",@"getUnReadMessageCountReleatedToMe"]) {
        __block IMP raw=NULL; SEL selector=NSSelectorFromString(name);
        replacement=imp_implementationWithBlock(^unsigned int(id facade){
            if(UnreadDisplay && NSThread.isMainThread && CSCloseFriendSurfaceConcealed(CSCloseFriendCurrentSnapshot(),CSCloseFriendSurfaceInteraction)) {
                if(DiscoveryCountingOwner) return DiscoveryUnreadCount(facade,name,((unsigned int(*)(id,SEL))raw)(facade,selector));
                // Other surfaces retain their existing partition fallback.
                if(![name isEqual:@"getUnReadMessageCount"] || !NativeUnread) return 0;
                return (unsigned int)MIN(UnreadProjection(facade).visible.count,UINT_MAX);
            }
            return ((unsigned int(*)(id,SEL))raw)(facade,selector);
        });
        if(!CSCloseFriendInstallHook(@"WCFacade",name,replacement,&raw,"I@:")) imp_removeBlock(replacement);
    }
    __block IMP last=NULL;
    replacement=imp_implementationWithBlock(^id(id facade){
        id message=((id(*)(id,SEL))last)(facade,NSSelectorFromString(@"getLastUnReadMessage"));
        if(UnreadDisplay && NSThread.isMainThread && CSCloseFriendCurrentSnapshot().blocked)return nil;
        if(!UnreadDisplay || !NSThread.isMainThread || !CSCFSocialHidden(message,CSCloseFriendSurfaceInteraction))return message;
        // Native getLastUnReadMessage takes the first result of LIMIT 1.
        // Separate database queries can return distinct objects for the same ID.
        return UnreadProjection(facade).visible.firstObject;
    });
    if(!CSCloseFriendInstallHook(@"WCFacade",@"getLastUnReadMessage",replacement,&last,"@@:")) imp_removeBlock(replacement);
    __block IMP limit=NULL;
    replacement=imp_implementationWithBlock(^id(id facade,int count){
        if(!UnreadDisplay || !NSThread.isMainThread || !CSCloseFriendSurfaceConcealed(CSCloseFriendCurrentSnapshot(),CSCloseFriendSurfaceInteraction))
            return ((id(*)(id,SEL,int))limit)(facade,NSSelectorFromString(@"getUnReadMessagesLimit:"),count);
        NSArray *visible=UnreadProjection(facade).visible;
        return [visible subarrayWithRange:NSMakeRange(0,MIN((NSUInteger)MAX(count,0),visible.count))];
    });
    if(!CSCloseFriendInstallHook(@"WCFacade",@"getUnReadMessagesLimit:",replacement,&limit,"@@:i")) imp_removeBlock(replacement);
    for(NSString *name in @[@"onMessageUnReadCountChanged",@"checkNewMessage"]) CSCFSocialHook0(@"WCTimeLineViewController",name,^(id page,void(^orig)(void)){
        if(!NSThread.isMainThread || !CSCFPageIsCurrent(page)) {orig();return;}
        BOOL saved=CSCFUnreadBegin(); @try {orig();} @finally {CSCFUnreadEnd(saved);}
    });
    __block IMP tip=NULL;
    replacement=imp_implementationWithBlock(^NSInteger(id page){
        if(!NSThread.isMainThread)return CSCloseFriendSurfaceConcealed(CSCloseFriendCurrentSnapshot(),CSCloseFriendSurfaceInteraction) ? 0 : ((NSInteger(*)(id,SEL))tip)(page,NSSelectorFromString(@"messageTipCount"));
        BOOL saved=CSCFUnreadBegin(); @try {return !CSCFPageIsCurrent(page) ? 0 : CSCloseFriendSurfaceConcealed(CSCloseFriendCurrentSnapshot(),CSCloseFriendSurfaceInteraction) ? (NSInteger)VisibleUnread(page) : ((NSInteger(*)(id,SEL))tip)(page,NSSelectorFromString(@"messageTipCount"));} @finally {CSCFUnreadEnd(saved);}
    });
    if(!CSCloseFriendInstallHook(@"WCTimeLineViewController",@"messageTipCount",replacement,&tip,"q@:")) imp_removeBlock(replacement);
    __block IMP has=NULL;
    replacement=imp_implementationWithBlock(^BOOL(id page){
        if(!NSThread.isMainThread)return !CSCloseFriendSurfaceConcealed(CSCloseFriendCurrentSnapshot(),CSCloseFriendSurfaceInteraction) && ((BOOL(*)(id,SEL))has)(page,NSSelectorFromString(@"hasUnReadMessage"));
        BOOL saved=CSCFUnreadBegin(); @try {return CSCFPageIsCurrent(page) && (CSCloseFriendSurfaceConcealed(CSCloseFriendCurrentSnapshot(),CSCloseFriendSurfaceInteraction) ? VisibleUnread(page)>0 : ((BOOL(*)(id,SEL))has)(page,NSSelectorFromString(@"hasUnReadMessage")));} @finally {CSCFUnreadEnd(saved);}
    });
    if(!CSCloseFriendInstallHook(@"WCTimeLineViewController",@"hasUnReadMessage",replacement,&has,"B@:")) imp_removeBlock(replacement);
    __block IMP avatar=NULL;
    replacement=imp_implementationWithBlock(^id(id page){
        if(!NSThread.isMainThread)return CSCloseFriendSurfaceConcealed(CSCloseFriendCurrentSnapshot(),CSCloseFriendSurfaceInteraction) ? nil : ((id(*)(id,SEL))avatar)(page,NSSelectorFromString(@"messageTipUserName"));
        if(!CSCFPageIsCurrent(page))return nil;
        id username=((id(*)(id,SEL))avatar)(page,NSSelectorFromString(@"messageTipUserName"));
        if(!CSCFSocialHidden(username,CSCloseFriendSurfaceInteraction))return username;
        id facade=CSCFTimelineFacade(page); BOOL saved=CSCFUnreadBegin();
        @try {
            id message=CSCloseFriendRead(facade,@"getLastUnReadMessage");
            id comment=CSCloseFriendRead(message,@"comment");
            return CSCloseFriendRead(comment,@"username");
        } @finally {CSCFUnreadEnd(saved);}
    });
    if(!CSCloseFriendInstallHook(@"WCTimeLineViewController",@"messageTipUserName",replacement,&avatar,"@@:")) imp_removeBlock(replacement);
    CSCFSocialHook0(@"WCFacade",@"onMessageUnReadCountChanged",^(__unused id facade,void(^orig)(void)){
        if(NSThread.isMainThread) {[UnreadProjections removeAllObjects]; [DiscoveryCounts removeAllObjects];}
        orig();
    });
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
            BOOL saved=CSCFUnreadBegin(); id previous=DiscoveryCountingOwner;
            DiscoveryCountingOwner=page;
            @try { return ((NSInteger(*)(id,SEL))count)(page,selector); }
            @finally { CSCFUnreadEnd(saved); DiscoveryCountingOwner=previous; }
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
    CSCFSocialHook1(@"FindFriendEntryViewController",@"updateWCTimeLineView:",^(id page,id cell,void(^orig)(id)){DiscoveryWithCounts(page,^{orig(cell);}); DiscoveryViews(page);});
    CSCFSocialHook0(@"FindFriendEntryViewController",@"reloadData",^(id page,void(^orig)(void)){DiscoveryWithCounts(page,orig); DiscoveryViews(page);});
    CSCFSocialHook0(@"FindFriendEntryViewController",@"onMessageUnReadCountChanged",^(id page,void(^orig)(void)){DiscoveryWithCounts(page,orig); DiscoveryViews(page);});
    __block IMP appear=NULL;
    IMP replacement=imp_implementationWithBlock(^(id page,BOOL animated){
        ((void(*)(id,SEL,BOOL))appear)(page,NSSelectorFromString(@"viewWillAppear:"),animated);
        if(CSCFPageIsCurrent(page)) CSCFCallVoid(page,@"onMessageUnReadCountChanged");
        DiscoveryViews(page);
    });
    if(!CSCloseFriendInstallHook(@"FindFriendEntryViewController",@"viewWillAppear:",replacement,&appear,"v@:B")) imp_removeBlock(replacement);
}
static id CurrentInteractionFacade(void) {
    Class contextClass=NSClassFromString(@"MMContext");
    SEL current=NSSelectorFromString(@"currentContext"),service=NSSelectorFromString(@"getService:");
    id center=nil;
    @try {
        // An available current-context accessor returning nil means logged out;
        // never substitute a cached default service belonging to another account.
        if(class_getClassMethod(contextClass,current)) {
            if(!CSCloseFriendMethodMatches(class_getClassMethod(contextClass,current),"@@:"))return nil;
            id context=((id(*)(id,SEL))objc_msgSend)(contextClass,current);
            if(!context)return nil;
            center=CSCloseFriendMethodMatches(class_getInstanceMethod([context class],service),"@@:#") ? context : CSCloseFriendRead(context,@"serviceCenter");
        } else {
            for(NSString *name in @[@"MMServiceCenter",@"ServiceCenter"]) {
                Class cls=NSClassFromString(name); SEL getter=NSSelectorFromString(@"defaultCenter");
                if(CSCloseFriendMethodMatches(class_getClassMethod(cls,getter),"@@:"))center=((id(*)(id,SEL))objc_msgSend)(cls,getter);
                if(center)break;
            }
        }
        Class facadeClass=NSClassFromString(@"WCFacade");
        if(!facadeClass || !CSCloseFriendMethodMatches(class_getInstanceMethod([center class],service),"@@:#"))return nil;
        id facade=((id(*)(id,SEL,Class))objc_msgSend)(center,service,facadeClass);
        return [facade isKindOfClass:facadeClass] ? facade : nil;
    } @catch(__unused NSException *exception) {return nil;}
}
static BOOL InteractionReadCurrent(id page,CSCloseFriendSnapshot *snapshot,NSUInteger epoch) {
    CSCloseFriendSnapshot *current=CSCloseFriendCurrentSnapshot();
    return NSThread.isMainThread && epoch==CSCloseFriendAccountEpoch() && CSCFPageIsCurrent(page) &&
        !current.blocked && current.revision==snapshot.revision && [current.accountID isEqual:snapshot.accountID];
}
static unsigned int InteractionMessageLocalID(id message) {
    id identifier=CSCloseFriendRead(message,@"msgID");
    if(![identifier isKindOfClass:NSString.class] || ![identifier length])return 0;
    unsigned long long value=0;
    for(const char *digit=[identifier UTF8String];*digit;digit++) {
        if(*digit<'0' || *digit>'9')return 0;
        value=value*10+(unsigned int)(*digit-'0');
        if(value>UINT_MAX)return 0;
    }
    return (unsigned int)value;
}
static void MarkVisibleMessagesRead(id page,void (^native)(void)) {
    if(!NSThread.isMainThread || !CSCFPageIsCurrent(page))return;
    CSCloseFriendSnapshot *snapshot=CSCloseFriendCurrentSnapshot();
    if(snapshot.blocked)return;
    if(![snapshot concealsSurface:CSCloseFriendSurfaceInteraction]) {native();return;}
    NSUInteger epoch=CSCloseFriendAccountEpoch();
    id facade=CurrentInteractionFacade(); SEL mark=NSSelectorFromString(@"markMessageListRead:");
    if(!facade || !NativeUnread || !CSCloseFriendMethodMatches(class_getInstanceMethod([facade class],mark),"v@:@"))return;
    NSArray *pageSource=CSCloseFriendRead(page,@"_arrCommentList");
    if(![pageSource isKindOfClass:NSArray.class] || !pageSource.count)return;
    // Native all-read uses the first loaded message's local ID as its cutoff.
    // Include older unread rows beyond the first page, but never newer arrivals.
    unsigned int cutoff=InteractionMessageLocalID(pageSource.firstObject);
    if(!cutoff)return;
    NSArray *unread=NativeUnread(facade,NSSelectorFromString(@"getUnReadMessages"));
    if(![unread isKindOfClass:NSArray.class] || !InteractionReadCurrent(page,snapshot,epoch))return;
    NSMutableArray *candidates=[NSMutableArray array];
    for(id message in unread) {
        unsigned int localID=InteractionMessageLocalID(message);
        if(localID && localID<=cutoff && !CSCFSocialHidden(message,CSCloseFriendSurfaceInteraction)) [candidates addObject:message];
    }
    // Re-read once at the write boundary. New messages are never added to the
    // captured batch; removed/already-read objects are discarded by stable msgID.
    NSArray *live=NativeUnread(facade,NSSelectorFromString(@"getUnReadMessages"));
    if(![live isKindOfClass:NSArray.class] || !InteractionReadCurrent(page,snapshot,epoch))return;
    NSMutableDictionary *liveByID=[NSMutableDictionary dictionary];
    for(id message in live) {
        id identifier=CSCloseFriendRead(message,@"msgID");
        if([identifier isKindOfClass:NSString.class] && [identifier length])liveByID[identifier]=message;
    }
    NSMutableArray *batch=[NSMutableArray array];
    for(id candidate in candidates) {
        id identifier=CSCloseFriendRead(candidate,@"msgID"); id message=liveByID[identifier];
        if(message && !CSCFSocialHidden(message,CSCloseFriendSurfaceInteraction)) {[batch addObject:message]; [liveByID removeObjectForKey:identifier];}
    }
    if(!batch.count || !InteractionReadCurrent(page,snapshot,epoch))return;
    // WeChat 8.0.80.34 expects WCSNSMessage objects here (the facade also reads
    // batch[0].comment.createTime), while the lower database layer consumes IDs.
    [UnreadProjections removeAllObjects]; [DiscoveryCounts removeAllObjects];
    // The manager re-reads the database count, saves it and notifies its facade
    // delegate. Use that native notification once; never synthesize a zero count.
    ((void(*)(id,SEL,id))objc_msgSend)(facade,mark,[batch copy]);
}
void CSCFInteractionInstall(void) {
    InstallUnread(); InstallDiscovery();
    BOOL ready=YES;
    NSDictionary *contracts=@{@"getWCCommentListCount:":@"q@:q",@"tableView:numberOfRowsInSection:":@"q@:@q",@"tableView:cellForRowAtIndexPath:":@"@@:@@",@"tableView:heightForRowAtIndexPath:":@"d@:@@",@"tableView:didSelectRowAtIndexPath:":@"v@:@@"};
    for(NSString *selector in contracts) ready &= CSCloseFriendMethodMatches(class_getInstanceMethod(NSClassFromString(@"WCCommentListViewController"),NSSelectorFromString(selector)),[contracts[selector] UTF8String]);
    CSCloseFriendRecordCapability(@"social.interactions.coupled",ready);
    if(!ready) {CSCFSocialProtectRoute(@"WCCommentListViewController",CSCloseFriendSurfaceInteraction); return;}

    CSCFSocialHook0(@"WCCommentListViewController",@"markMessageAllRead",^(id page,void(^orig)(void)){
        MarkVisibleMessagesRead(page,orig);
    });

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
    // Destructive operations require a fresh action after authentication. The
    // native pagination arrays and hidden records are never replaced or deleted.
    for(NSString *name in @[@"clearList",@"onDeleteData"]) CSCFSocialHook0(@"WCCommentListViewController",name,^(id page,void(^orig)(void)){
        if(!CSCFSocialRequireAuthentication(page,CSCloseFriendSurfaceInteraction)) orig();
    });
    CSCFSocialHook1(@"WCCommentListViewController",@"onClearList:",^(id page,id sender,void(^orig)(id)){
        if(!CSCFSocialRequireAuthentication(page,CSCloseFriendSurfaceInteraction)) orig(sender);
    });
    __block IMP edit=NULL;
    replacement=imp_implementationWithBlock(^(id page,id table,NSInteger style,NSIndexPath *path){if(CSCFSocialRequireAuthentication(page,CSCloseFriendSurfaceInteraction)) return; if(MessageActionCurrent(page,path)) ((void(*)(id,SEL,id,NSInteger,id))edit)(page,NSSelectorFromString(@"tableView:commitEditingStyle:forRowAtIndexPath:"),table,style,MessagePath(page,path));});
    if(!CSCloseFriendInstallHook(@"WCCommentListViewController",@"tableView:commitEditingStyle:forRowAtIndexPath:",replacement,&edit,"v@:@q@")) imp_removeBlock(replacement);

}
