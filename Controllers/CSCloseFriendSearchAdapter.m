#import "CSCloseFriendSearchAdapter.h"
#import "CSCloseFriendManager.h"

// Ordinary edits stay in WeChat's live-search pipeline. Only an exact password
// match consumes input and keeps late callbacks from reviving that cleared query.
@interface CSCFSearchInputState : NSObject
@property(nonatomic) NSUInteger dispatchDepth;
@property(nonatomic) BOOL consumed, resetting;
@end
@implementation CSCFSearchInputState @end
static char SearchInputKey;
static BOOL SearchProtected(id page) {
    CSCloseFriendSnapshot *snapshot=CSCloseFriendCurrentSnapshot();
    return CSCFIsClass(page,@"FTSHomeViewController") && (snapshot.enabled || snapshot.blocked);
}
static CSCFSearchInputState *InputState(id page) {
    CSCFSearchInputState *state=objc_getAssociatedObject(page,&SearchInputKey);
    if(!state) {
        state=[CSCFSearchInputState new];
        objc_setAssociatedObject(page,&SearchInputKey,state,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return state;
}
static NSString *SearchInput(id page,id input) {
    id query=[input isKindOfClass:NSString.class] ? input : CSCloseFriendRead(input,@"text");
    if(![query isKindOfClass:NSString.class]) query=CSCloseFriendRead(page,@"searchBarText");
    return [query isKindOfClass:NSString.class] ? query : @"";
}
static BOOL SearchComposing(id page) {
    id textView=CSCloseFriendRead(CSCloseFriendRead(page,@"searchBar"),@"textView");
    return CSCloseFriendRead(CSCloseFriendRead(page,@"searchTextField"),@"markedTextRange") ||
        CSCloseFriendRead(textView,@"markedTextRange") ||
        CSCloseFriendRead(CSCloseFriendRead(textView,@"textView"),@"markedTextRange");
}
static void SearchSetEmptyPresentation(id page,BOOL empty) {
    SEL selector=NSSelectorFromString(@"updateViewHideStates:");
    if(CSCloseFriendMethodMatches(class_getInstanceMethod([page class],selector),"v@:B"))
        ((void(*)(id,SEL,BOOL))[page methodForSelector:selector])(page,selector,empty);
}
BOOL CSCFSearchSuppressLoading(id page) {
    if(!SearchProtected(page)) return NO;
    CSCFSearchInputState *state=objc_getAssociatedObject(page,&SearchInputKey);
    return state.consumed;
}
void CSCFSearchClearResults(id page) {
    CSCFSetObject(page,@"setSectionData:",@[]);
    CSCFSetObject(CSCloseFriendRead(page,@"tableView"),@"setTableFooterView:",nil);
    CSCFSetObject(CSCloseFriendRead(CSCloseFriendRead(page,@"listAdapter"),@"tableView"),@"setTableFooterView:",nil);
}
static void SearchReset(id page) {
    CSCFSearchInputState *state=InputState(page); id presenter=CSCloseFriendRead(page,@"presenter");
    [NSObject cancelPreviousPerformRequestsWithTarget:presenter];
    state.resetting=YES;
    @try {
        id bar=CSCloseFriendRead(page,@"searchBar");
        // Clear the actual large editor, or the legacy field on older layouts.
        if(!CSCFCallVoid(bar,@"inputBoxClear")) {
            CSCFSetObject(CSCloseFriendRead(page,@"searchTextField"),@"setText:",@"");
            CSCFSetObject(CSCloseFriendRead(bar,@"textView"),@"setText:",@"");
        }
        CSCFSetObject(presenter,@"handleTextDidChange:",@"");
    } @finally {
        state.resetting=NO;
        [NSObject cancelPreviousPerformRequestsWithTarget:presenter];
        CSCFCallVoid(presenter,@"cancelFTSSearch");
        CSCFSetObject(presenter,@"setLatestCompeleteWebSearchQuery:",@"");
        CSCFSearchClearResults(page);
        SearchSetEmptyPresentation(page,YES);
        CSCFCallVoid(page,@"reloadList");
    }
}
BOOL CSCFSearchConsumePassword(id page,id input) {
    if(!NSThread.isMainThread || !SearchProtected(page) || SearchComposing(page)) return NO;
    NSString *query=SearchInput(page,input);
    if(!query.length || ![CSCloseFriendManager.sharedManager consumeHomepageSearchPassword:query]) return NO;
    CSCFSearchInputState *state=InputState(page);
    state.consumed=YES;
    SearchReset(page);
    CSCFCallVoid(page,@"resignSearchFirstResponder");
    return YES;
}
static void DispatchPassword(id page,id input,BOOL composing,void (^native)(void)) {
    CSCFSearchInputState *state=InputState(page);
    if(state.resetting) { if(!SearchInput(page,input).length) native(); return; }
    if(state.consumed) return;
    if(state.dispatchDepth || composing || SearchComposing(page)) { native(); return; }
    state.dispatchDepth++;
    @try { if(!CSCFSearchConsumePassword(page,input)) native(); }
    @finally { state.dispatchDepth--; }
}
void CSCFSearchDispatchInput(id page,id input,BOOL composing,void (^native)(void)) {
    if(!NSThread.isMainThread || !SearchProtected(page)) {
        if(page) objc_setAssociatedObject(page,&SearchInputKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        native(); return;
    }
    CSCFSearchInputState *state=InputState(page);
    if(!state.resetting) state.consumed=NO;
    DispatchPassword(page,input,composing,native);
}
void CSCFSearchDispatchQuery(id page,id input,void (^native)(void)) {
    if(!NSThread.isMainThread || !SearchProtected(page)) { native(); return; }
    DispatchPassword(page,input,NO,native);
}
void CSCFSearchSubmit(id page,void (^native)(void)) {
    // Native typing already scheduled searches. Do not replay a query on Return.
    NSString *query=SearchInput(page,nil);
    if(query.length) CSCFSearchDispatchInput(page,query,NO,native);
    else CSCFSearchDispatchQuery(page,query,native);
}
@interface CSCFSearchState : NSObject
@property(nonatomic) NSUInteger epoch, revision, displayedRevision, generation, displayedGeneration;
@property(nonatomic,copy) NSArray *source;
@property(nonatomic,copy) NSString *key;
@property(nonatomic,copy) id taskKey;
@end
@implementation CSCFSearchState @end
static char SearchKey;
static NSHashTable *Sections;
id CSCFSearchModel(id row) {
    // FTSNormalSectionData.rows contains row wrappers. Native single/group/top-hit
    // cell builders read row.model before reading CContact.m_nsUsrName.
    return CSCloseFriendRead(row,@"model") ?: row;
}
NSArray *CSCFSearchVisibleRows(NSArray *rows) {
    return CSCloseFriendVisibleContacts(rows,CSCloseFriendCurrentSnapshot(),CSCloseFriendSurfaceSearch,^NSString *(id row){
        return CSCloseFriendUserName(CSCFSearchModel(row));
    });
}
static UIViewController *Presenter(id section) {
    id page=CSCloseFriendRead(section,@"getViewController");
    if(![page isKindOfClass:UIViewController.class]) page=CSCloseFriendRead(CSCloseFriendRead(section,@"resultPage"),@"getViewController");
    return [page isKindOfClass:UIViewController.class] ? page : nil;
}
static CSCFSearchState *State(id section) {
    CSCFSearchState *state=objc_getAssociatedObject(section,&SearchKey);
    if(!state) { state=[CSCFSearchState new]; state.epoch=CSCloseFriendAccountEpoch(); objc_setAssociatedObject(section,&SearchKey,state,OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
    static dispatch_once_t once;
    dispatch_once(&once,^{
        Sections=[NSHashTable weakObjectsHashTable];
        [NSNotificationCenter.defaultCenter addObserverForName:CSCloseFriendPolicyDidChangeNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(__unused NSNotification *note){
            for(id item in Sections.allObjects) { CSCFSearchPrepare(item); CSCFReloadTables(Presenter(item)); }
        }];
    });
    [Sections addObject:section]; return state;
}
void CSCFSearchBegin(id section) {
    CSCFSearchState *state=State(section); state.source=nil; state.revision=0; state.generation++;
}
void CSCFSearchWillUpdate(id section) {
    CSCFSearchState *state=State(section);
    if(state.key.length && state.epoch==CSCloseFriendAccountEpoch() && state.source) {
        CSCFSetObject(section,[state.key isEqual:@"contacts"] ? @"setContacts:" : @"setTopHitItems:",[state.source mutableCopy]);
    }
}
void CSCFSearchDidUpdate(id section,NSString *key) {
    CSCFSearchState *state=State(section); state.key=key;
    id source=CSCloseFriendRead(section,key);
    state.generation++;
    state.source=[source isKindOfClass:NSArray.class] ? [source copy] : @[];
    state.taskKey=[CSCloseFriendRead(section,@"ftsTaskKey") copy]; state.revision=0;
    CSCFSearchPrepare(section);
}
BOOL CSCFSearchPrepare(id section) {
    CSCFSearchState *state=State(section); CSCloseFriendSnapshot *policy=CSCloseFriendCurrentSnapshot();
    BOOL current=state.epoch==CSCloseFriendAccountEpoch();
    if(state.key.length) {
        NSArray *rows=current ? CSCFSearchVisibleRows(state.source) : @[];
        NSString *setter=[state.key isEqual:@"contacts"] ? @"setContacts:" : @"setTopHitItems:";
        if(!CSCFSetObject(section,setter,rows)) return NO;
    }
    state.revision=policy.revision; return current;
}
void CSCFSearchDidRender(id section) {
    CSCFSearchState *state=State(section); state.displayedRevision=CSCloseFriendCurrentSnapshot().revision; state.displayedGeneration=state.generation;
}
BOOL CSCFSearchAllowsSelection(id section) {
    CSCFSearchState *state=State(section); id taskKey=CSCloseFriendRead(section,@"ftsTaskKey");
    return state.epoch==CSCloseFriendAccountEpoch() && state.displayedRevision==CSCloseFriendCurrentSnapshot().revision && state.displayedGeneration==state.generation && (!state.taskKey || [state.taskKey isEqual:taskKey]);
}
BOOL CSCFSearchGated(id section) {
    CSCFSearchState *state=State(section);
    if(state.epoch!=CSCloseFriendAccountEpoch() || CSCloseFriendCurrentSnapshot().blocked) return YES;
    if(!CSCloseFriendSurfaceConcealed(CSCloseFriendCurrentSnapshot(),CSCloseFriendSurfaceSearch)) return NO;
    // These contracts cannot distinguish protected group authors and aggregate payloads safely.
    return CSCFIsClass(section,@"FTSMessageSectionController") || CSCFIsClass(section,@"FTSSearchContactSectionController");
}
static NSString *GroupDisplayTitle(id item) {
    item=CSCFSearchModel(item);
    NSString *username=CSCloseFriendUserName(item);
    if([username hasSuffix:@"@chatroom"]) {
        id title=CSCloseFriendRead(item,@"m_nsNickName");
        return [title isKindOfClass:NSString.class] && [title length] ? title : @"群聊";
    }
    // Known structured group matches carry member dictionaries. Their arbitrary key is NOT a username.
    if(CSCFIsClass(item,@"FTSTopHitValue")) {
        id members=CSCloseFriendRead(item,@"dicGroupMember");
        if([members isKindOfClass:NSDictionary.class] && [members count]) return @"群聊";
    }
    if(CSCFIsClass(item,@"FTSTopHitItem")) {
        id values=CSCloseFriendRead(item,@"arrTopHitValue");
        if([values isKindOfClass:NSArray.class]) for(id value in values) if(CSCFIsClass(value,@"FTSTopHitValue") && GroupDisplayTitle(value)) return @"群聊";
    }
    return nil;
}
BOOL CSCFSearchRedactsGroupMatch(id contact) {
    return [CSCloseFriendUserName(contact) hasSuffix:@"@chatroom"] &&
        CSCloseFriendSurfaceConcealed(CSCloseFriendCurrentSnapshot(),CSCloseFriendSurfaceSearch);
}
void CSCFSearchUpdateGroupCell(id cell,id contact) {
    if(!CSCFSearchRedactsGroupMatch(contact)) return;
    // Keep WeChat's live avatar, hierarchy and layout. Only substitute the public
    // group title, avoiding fallback names generated from protected group members.
    CSCFSetObject(CSCloseFriendRead(cell,@"_displayNameLabel"),@"setText:",GroupDisplayTitle(contact));
}
