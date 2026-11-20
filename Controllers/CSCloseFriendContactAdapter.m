#import "CSCloseFriendContactAdapter.h"
#import "CSServiceCenter.h"
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
NSArray<NSString *> *CSCFContactNames(NSArray *contacts) {
    if(![contacts isKindOfClass:NSArray.class]) return @[];
    NSMutableArray<NSString *> *names=[NSMutableArray array];
    id manager=nil; BOOL requestedManager=NO;
    for(id value in contacts) {
        id contact=value; NSString *username=CSCloseFriendUserName(value);
        @try {
            if([value isKindOfClass:NSString.class]) {
                if(!requestedManager) {manager=CSGetService(NSClassFromString(@"CContactMgr")); requestedManager=YES;}
                SEL selector=NSSelectorFromString(@"getContactByName:");
                contact=CSCloseFriendMethodMatches(class_getInstanceMethod([manager class],selector),"@@:@") ? ((id(*)(id,SEL,id))objc_msgSend)(manager,selector,value) : nil;
            }
            NSString *name=nil;
            for(NSString *key in @[@"getContactDisplayName",@"m_nsRemark",@"m_nsNickName"]) {
                id candidate=CSCloseFriendRead(contact,key);
                if([candidate isKindOfClass:NSString.class] && [candidate length]) {name=candidate; break;}
            }
            if(!name.length) name=username;
            if(name.length) [names addObject:[name copy]];
        } @catch(__unused NSException *exception) { if(username.length) [names addObject:[username copy]]; }
    }
    return [names copy];
}
BOOL CSCFCallVoid(id object,NSString *name) {
    SEL selector=NSSelectorFromString(name); if(!object || !CSCloseFriendMethodMatches(class_getInstanceMethod([object class],selector),"v@:")) return NO;
    ((void(*)(id,SEL))objc_msgSend)(object,selector); return YES;
}
BOOL CSCFSetObject(id object,NSString *name,id value) {
    SEL selector=NSSelectorFromString(name); if(!object || !CSCloseFriendMethodMatches(class_getInstanceMethod([object class],selector),"v@:@")) return NO;
    ((void(*)(id,SEL,id))objc_msgSend)(object,selector,value); return YES;
}
static char PendingSurfaceRefreshKey, SurfaceAppearanceHookKey;
static void ApplyPendingSurfaceRefresh(id owner) {
    void (^refresh)(id)=objc_getAssociatedObject(owner,&PendingSurfaceRefreshKey);
    objc_setAssociatedObject(owner,&PendingSurfaceRefreshKey,nil,OBJC_ASSOCIATION_COPY_NONATOMIC);
    if(refresh)refresh(owner);
}
static BOOL WatchSurfaceAppearance(id owner) {
    Class cls=[owner class]; NSNumber *installed=objc_getAssociatedObject(cls,&SurfaceAppearanceHookKey);
    if(installed)return installed.boolValue;
    __block IMP original=NULL; IMP replacement=NULL; NSString *name=nil; const char *types=NULL;
    if([owner isKindOfClass:UIViewController.class]) {
        name=@"viewWillAppear:"; types="v@:B";
        replacement=imp_implementationWithBlock(^(id page,BOOL animated){
            ApplyPendingSurfaceRefresh(page);
            ((void(*)(id,SEL,BOOL))original)(page,@selector(viewWillAppear:),animated);
        });
    } else if([owner isKindOfClass:UIView.class]) {
        name=@"didMoveToWindow"; types="v@:";
        replacement=imp_implementationWithBlock(^(UIView *view){
            ((void(*)(id,SEL))original)(view,@selector(didMoveToWindow));
            if(view.window)ApplyPendingSurfaceRefresh(view);
        });
    } else return NO;
    BOOL ok=CSCloseFriendInstallHook(NSStringFromClass(cls),name,replacement,&original,types);
    if(!ok)imp_removeBlock(replacement);
    objc_setAssociatedObject(cls,&SurfaceAppearanceHookKey,@(ok),OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return ok;
}
void CSCFRefreshSurface(id owner,void (^refresh)(id)) {
    if(!owner || !refresh)return;
    BOOL visible=YES;
    if([owner isKindOfClass:UIViewController.class])visible=[owner isViewLoaded] && [[owner view] window]!=nil;
    else if([owner isKindOfClass:UIView.class])visible=[owner window]!=nil;
    if(!visible && WatchSurfaceAppearance(owner)) {
        // The block receives its weakly tracked owner; it never captures the page.
        objc_setAssociatedObject(owner,&PendingSurfaceRefreshKey,refresh,OBJC_ASSOCIATION_COPY_NONATOMIC);
        return;
    }
    objc_setAssociatedObject(owner,&PendingSurfaceRefreshKey,nil,OBJC_ASSOCIATION_COPY_NONATOMIC);
    refresh(owner);
}
static void ReloadView(UIView *view) {
    if([view isKindOfClass:UITableView.class]) {[(UITableView *)view reloadData];return;}
    if([view isKindOfClass:UICollectionView.class]) {[(UICollectionView *)view reloadData];return;}
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
            for(id tracked in owners.keyEnumerator.allObjects) CSCFRefreshSurface(tracked,^(id page){
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
            });
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
    // End the visible multi-select mode in place. onSelectCancel dismisses this
    // page, which must not happen when the user relocks from an unrelated page.
    CSCFCallVoid(owner,@"cancelMultiSelect");
    // Keep the invalid ticket so a late callback cannot resurrect this operation.
    // The native Back/Cancel button remains available to start a fresh operation.
}
NSArray *CSCFCurrentForwardRecipients(id owner) {
    if(!NSThread.isMainThread || !CSCFIsClass(owner,@"SessionSelectController")) return nil;
    // 8.0.80 endMultiSelect: fills m_selectedContacts only AFTER onMultiDone.
    // Read the same ordered selection that native completion is about to copy.
    id view=CSCloseFriendRead(owner,@"m_selectView");
    id selection=CSCloseFriendRead(view,@"m_dicMultiSelect");
    SEL selector=NSSelectorFromString(@"allValuesInOrder");
    Method method=class_getInstanceMethod([selection class],selector);
    if(!CSCloseFriendMethodMatches(method,"@@:")) return nil;
    @try {
        id recipients=((id(*)(id,SEL))objc_msgSend)(selection,selector);
        return [recipients isKindOfClass:NSArray.class] ? [recipients copy] : nil;
    } @catch(__unused NSException *exception) { return nil; }
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
static NSString *TagMemberCountText(id cell,NSUInteger count) {
    id original=CSCloseFriendRead(cell,@"memberCountText");
    NSString *number=[NSString stringWithFormat:@"%lu",(unsigned long)count];
    if([original isKindOfClass:NSString.class]) {
        NSCharacterSet *digits=NSCharacterSet.decimalDigitCharacterSet;
        NSRange range=[original rangeOfCharacterFromSet:digits];
        if(range.location!=NSNotFound) {
            NSUInteger end=NSMaxRange(range);
            while(end<[original length] && [digits characterIsMember:[original characterAtIndex:end]]) end++;
            return [original stringByReplacingCharactersInRange:NSMakeRange(range.location,end-range.location) withString:number];
        }
    }
    return [NSString stringWithFormat:@"(%@)",number];
}
void CSCFUpdateTagSummary(id cell,id tag) {
    NSArray *source=CSCloseFriendRead(tag,@"m_arrContactNameList"); NSArray *visible=CSCFVisible(source,CSCloseFriendSurfaceTag);
    if(visible.count==source.count) return;
    CSCFSetObject(cell,@"setMemberCountText:",TagMemberCountText(cell,visible.count));
    CSCFSetObject(cell,@"setMemberListText:",[CSCFContactNames(visible) componentsJoinedByString:@", "]); CSCFSetObject(cell,@"setMemberListAttributedText:",nil);
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
