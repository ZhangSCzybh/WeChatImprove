#import "CSCloseFriendContactAdapter.h"
#import <objc/message.h>
static char SelectionKey, PageEpochKey, ForwardSourcesKey, ForwardUpdateDepthKey;
BOOL CSCFPageIsCurrent(id owner) {
    NSNumber *epoch=objc_getAssociatedObject(owner,&PageEpochKey);
    if(!epoch) { epoch=@(CSCloseFriendAccountEpoch()); objc_setAssociatedObject(owner,&PageEpochKey,epoch,OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
    return epoch.unsignedIntegerValue==CSCloseFriendAccountEpoch();
}
BOOL CSCFIsClass(id object,NSString *name) { Class cls=NSClassFromString(name); return cls && [object isKindOfClass:cls]; }
NSArray *CSCFVisible(NSArray *source,CSCloseFriendSurface surface) {
    return CSCloseFriendVisibleContacts(source,CSCloseFriendCurrentSnapshot(),surface,^NSString *(id item){ return CSCloseFriendUserName(item); });
}
BOOL CSCFCallVoid(id object,NSString *name) {
    SEL selector=NSSelectorFromString(name); if(!object || !CSCloseFriendMethodMatches(class_getInstanceMethod([object class],selector),"v@:")) return NO;
    ((void(*)(id,SEL))objc_msgSend)(object,selector); return YES;
}
BOOL CSCFSetObject(id object,NSString *name,id value) {
    SEL selector=NSSelectorFromString(name); if(!object || !CSCloseFriendMethodMatches(class_getInstanceMethod([object class],selector),"v@:@")) return NO;
    ((void(*)(id,SEL,id))objc_msgSend)(object,selector,value); return YES;
}
static void ReloadView(UIView *view) {
    if([view isKindOfClass:UITableView.class]) [(UITableView *)view reloadData];
    if([view isKindOfClass:UICollectionView.class]) [(UICollectionView *)view reloadData];
    for(UIView *child in view.subviews) ReloadView(child);
}
void CSCFReloadTables(id owner) {
    if([owner isKindOfClass:UIView.class]) ReloadView(owner);
    else if([owner isKindOfClass:UIViewController.class] && [owner isViewLoaded]) ReloadView([owner view]);
    else { id table=CSCloseFriendRead(owner,@"tableView"); if([table isKindOfClass:UIView.class]) ReloadView(table); }
}
void CSCFTrackSurface(id owner,NSString *refreshSelector) {
    if(!owner || !NSThread.isMainThread) return;
    CSCFPageIsCurrent(owner);
    static NSMapTable *owners; static dispatch_once_t once;
    dispatch_once(&once,^{
        owners=[NSMapTable weakToStrongObjectsMapTable];
        [NSNotificationCenter.defaultCenter addObserverForName:CSCloseFriendPolicyDidChangeNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(__unused NSNotification *note){
            for(id page in owners.keyEnumerator.allObjects) {
                CSCFCancelSelection(page);
                CSCFCallVoid(page,[owners objectForKey:page]);
                if(CSCFIsClass(page,@"SessionSelectView")) CSCFRefreshForwardSearch(page);
                CSCFReloadTables(page);
                if(CSCFIsClass(page,@"ContactsViewController")) {
                    id logic=CSCloseFriendRead(page,@"m_contactsDataLogic"); SEL selector=NSSelectorFromString(@"getContactCount");
                    if(CSCloseFriendMethodMatches(class_getInstanceMethod([logic class],selector),"I@:")) {
                        unsigned int count=((unsigned int(*)(id,SEL))objc_msgSend)(logic,selector);
                        UILabel *label=CSCloseFriendRead(page,@"m_countLabel");
                        if([label isKindOfClass:UILabel.class]) label.text=[NSString stringWithFormat:@"%u 位联系人",count];
                    }
                }
            }
        }];
    });
    if(refreshSelector.length || ![owners objectForKey:owner]) [owners setObject:refreshSelector ?: @"" forKey:owner];
}
BOOL CSCFContactLogicSurface(id logic,CSCloseFriendSurface *surface) {
    id owner=CSCloseFriendRead(logic,@"m_delegate");
    if(CSCFIsClass(owner,@"ContactsViewController")) { *surface=CSCloseFriendSurfaceContact; CSCFTrackSurface(owner,@"reloadContacts"); return YES; }
    // Generic ContactSelectView also backs publishing ACL editors. Never truncate its business selections.
    if(CSCFIsClass(owner,@"ContactSelectView") && CSCFIsClass(CSCloseFriendRead(owner,@"m_delegate"),@"SessionSelectController")) {
        *surface=CSCloseFriendSurfaceForward; CSCFTrackSurface(owner,@"reloadContacts"); return YES;
    }
    return NO;
}
void CSCFBeginSelection(id owner) {
    if(!objc_getAssociatedObject(owner,&SelectionKey)) objc_setAssociatedObject(owner,&SelectionKey,[[CSCloseFriendSelectionTicket alloc] initWithSnapshot:CSCloseFriendCurrentSnapshot() epoch:CSCloseFriendAccountEpoch()],OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    CSCFTrackSurface(owner,@"");
}
void CSCFCancelSelection(id owner) {
    if(!objc_getAssociatedObject(owner,&SelectionKey)) return;
    // Native cancellation clears all selected state and closes the operation; never trim its recipient set.
    CSCFCallVoid(owner,@"onSelectCancel");
    // Keep the invalid ticket so a late callback cannot resurrect the cancelled operation.
}
BOOL CSCFAllowSelection(id owner,NSArray *recipients) {
    CSCFBeginSelection(owner);
    CSCloseFriendSelectionTicket *ticket=objc_getAssociatedObject(owner,&SelectionKey);
    BOOL allowed=[ticket allowsRecipients:recipients snapshot:CSCloseFriendCurrentSnapshot() epoch:CSCloseFriendAccountEpoch() identity:^NSString *(id item){ return CSCloseFriendUserName(item); }];
    if(!allowed) CSCFCancelSelection(owner); return allowed;
}
BOOL CSCFRequireTagAuthentication(id owner) {
    if(!CSCFPageIsCurrent(owner)) return YES;
    if(!CSCloseFriendSurfaceConcealed(CSCloseFriendCurrentSnapshot(),CSCloseFriendSurfaceTag)) return NO;
    if([owner isKindOfClass:UIViewController.class]) {
        NSUInteger epoch=CSCloseFriendAccountEpoch(); __weak UIViewController *page=owner;
        CSCloseFriendAuthenticate(owner,^(BOOL ok){
            if(!ok || epoch!=CSCloseFriendAccountEpoch() || !page || CSCloseFriendSurfaceConcealed(CSCloseFriendCurrentSnapshot(),CSCloseFriendSurfaceTag)) return;
            CSCFCallVoid(page,@"reloadDataAndView"); CSCFReloadTables(page);
            // No destructive action is replayed using stale hidden/selected members.
        });
    } return YES;
}
void CSCFUpdateTagSummary(id cell,id tag) {
    NSArray *source=CSCloseFriendRead(tag,@"m_arrContactNameList"); NSArray *visible=CSCFVisible(source,CSCloseFriendSurfaceTag);
    if(visible.count==source.count) return;
    CSCFSetObject(cell,@"setMemberCountText:",[NSString stringWithFormat:@"%lu",(unsigned long)visible.count]);
    CSCFSetObject(cell,@"setMemberListText:",@""); CSCFSetObject(cell,@"setMemberListAttributedText:",nil);
    CSCFCallVoid(cell,@"updateView"); // tagData is intentionally still the native full business model.
}
void CSCFUpdateTagDetail(id owner) {
    CSCFTrackSurface(owner,@"reloadDataAndView");
    id tag=CSCloseFriendRead(owner,@"contactTagData"); NSArray *source=CSCloseFriendRead(tag,@"m_arrContactNameList");
    NSArray *visible=CSCFVisible(source,CSCloseFriendSurfaceTag);
    if(visible.count==source.count) return;
    if([owner isKindOfClass:UIViewController.class]) [owner setTitle:[NSString stringWithFormat:@"%@ (%lu)",CSCloseFriendRead(tag,@"m_nsName") ?: @"标签",(unsigned long)visible.count]];
    UIView *empty=CSCloseFriendRead(owner,@"emptyView"); if([empty isKindOfClass:UIView.class]) empty.hidden=visible.count!=0;
    UIView *table=CSCloseFriendRead(owner,@"tableView"); if([table isKindOfClass:UIView.class]) table.hidden=visible.count==0;
}

// These are page-owned derived search buffers, never ContactMgr or stored message results.
static BOOL SetPresentationBuffer(id owner,NSString *key,id value) {
    Ivar ivar=class_getInstanceVariable([owner class],key.UTF8String);
    const char *type=ivar ? ivar_getTypeEncoding(ivar) : NULL;
    if(!type || type[0]!='@') return NO;
    object_setIvar(owner,ivar,value); return YES;
}
void CSCFRefreshForwardSearch(id owner) {
    if([objc_getAssociatedObject(owner,&ForwardUpdateDepthKey) unsignedIntegerValue]) return;
    NSDictionary *sources=objc_getAssociatedObject(owner,&ForwardSourcesKey);
    if(!sources) return;
    BOOL current=CSCFPageIsCurrent(owner);
    for(NSString *key in @[@"arrSearchResultOfContacts",@"arrSearchResultOfGroup",@"arrSearchResultOfTopHit"]) {
        NSArray *rows=current ? CSCFVisible(sources[key],CSCloseFriendSurfaceForward) : @[];
        NSMutableArray *buffer=[rows mutableCopy];
        SetPresentationBuffer(owner,key,buffer);
    }
    NSArray *keys=sources[@"arrSectionKey"]; NSDictionary *sections=sources[@"dicSearchResult"];
    if([keys isKindOfClass:NSArray.class] && [sections isKindOfClass:NSDictionary.class]) {
        CSCloseFriendContactProjection *p=[[CSCloseFriendContactProjection alloc] initWithKeys:current?keys:@[] sections:sections snapshot:CSCloseFriendCurrentSnapshot() surface:CSCloseFriendSurfaceForward identity:^NSString *(id item){return CSCloseFriendUserName(item);}];
        NSMutableArray *keyBuffer=[p.keys mutableCopy]; NSMutableDictionary *sectionBuffer=[NSMutableDictionary dictionary];
        for(id key in p.keys) sectionBuffer[key]=[p.sections[key] mutableCopy];
        SetPresentationBuffer(owner,@"arrSectionKey",keyBuffer);
        SetPresentationBuffer(owner,@"dicSearchResult",sectionBuffer);
    }
}
void CSCFForwardSearchWillUpdate(id owner) {
    NSUInteger depth=[objc_getAssociatedObject(owner,&ForwardUpdateDepthKey) unsignedIntegerValue];
    objc_setAssociatedObject(owner,&ForwardUpdateDepthKey,@(depth+1),OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if(depth) return;
    // A partial native merge must start with the complete last source, not our filtered buffers.
    // A full rebuild will clear/replace these containers itself. Neither is a policy-only refresh.
    NSDictionary *sources=objc_getAssociatedObject(owner,&ForwardSourcesKey);
    for(NSString *key in sources) {
        id value=sources[key];
        if([value isKindOfClass:NSDictionary.class]) {
            NSMutableDictionary *sections=[NSMutableDictionary dictionary];
            for(id section in value) sections[section]=[value[section] isKindOfClass:NSArray.class] ? [value[section] mutableCopy] : value[section];
            SetPresentationBuffer(owner,key,sections);
        } else if([value isKindOfClass:NSArray.class]) SetPresentationBuffer(owner,key,[value mutableCopy]);
    }
}
void CSCFForwardSearchDidUpdate(id owner) {
    NSUInteger depth=[objc_getAssociatedObject(owner,&ForwardUpdateDepthKey) unsignedIntegerValue];
    objc_setAssociatedObject(owner,&ForwardUpdateDepthKey,@(depth ? depth-1 : 0),OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if(depth>1) return; // Nested merge inside the full contact callback: publish only once.
    NSMutableDictionary *sources=[NSMutableDictionary dictionary];
    for(NSString *key in @[@"arrSearchResultOfContacts",@"arrSearchResultOfGroup",@"arrSearchResultOfTopHit",@"arrSectionKey",@"dicSearchResult"]) {
        id value=CSCloseFriendRead(owner,key);
        if([value isKindOfClass:NSDictionary.class]) {
            NSMutableDictionary *sections=[NSMutableDictionary dictionary];
            for(id section in value) sections[section]=[value[section] isKindOfClass:NSArray.class] ? [value[section] copy] : value[section];
            sources[key]=[sections copy];
        } else if([value isKindOfClass:NSArray.class]) sources[key]=[value copy];
    }
    // Native full callbacks clear and repopulate existing containers. Always capture their contents.
    objc_setAssociatedObject(owner,&ForwardSourcesKey,[sources copy],OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    CSCFRefreshForwardSearch(owner);
    CSCFReloadTables(owner);
}
