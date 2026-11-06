#import "CSCloseFriendSearchAdapter.h"
#import "CSCloseFriendManager.h"

// Ordinary edits stay in WeChat's live-search pipeline. Only an exact password
// match consumes input and keeps late callbacks from reviving that cleared query.
@interface CSCFSearchInputState : NSObject
@property(nonatomic) NSUInteger dispatchDepth;
@property(nonatomic) BOOL consumed, resetting;
@property(nonatomic) NSUInteger generation, epoch;
@property(nonatomic,copy) NSString *inputQuery, *pendingQuery;
@property(nonatomic,strong) NSMutableArray *pendingCallbacks;
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
        state=[CSCFSearchInputState new]; state.epoch=CSCloseFriendAccountEpoch();
        objc_setAssociatedObject(page,&SearchInputKey,state,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return state;
}
static NSString *SearchInput(id page,id input) {
    id query=[input isKindOfClass:NSString.class] ? input : CSCloseFriendRead(input,@"text");
    if(![query isKindOfClass:NSString.class]) query=CSCloseFriendRead(page,@"searchBarText");
    return [query isKindOfClass:NSString.class] ? query : @"";
}
BOOL CSCFSearchHasMarkedText(id range) {
    if(!range)return NO;
    // 8.0.80 passes a UITextRange. A present, empty range is already committed
    // input; testing only for nil can prevent the password check indefinitely.
    SEL selector=NSSelectorFromString(@"isEmpty");
    if(CSCloseFriendMethodMatches(class_getInstanceMethod([range class],selector),"B@:"))
        return !((BOOL(*)(id,SEL))[range methodForSelector:selector])(range,selector);
    return YES;
}
static BOOL SearchComposing(id page) {
    id textView=CSCloseFriendRead(CSCloseFriendRead(page,@"searchBar"),@"textView");
    return CSCFSearchHasMarkedText(CSCloseFriendRead(CSCloseFriendRead(page,@"searchTextField"),@"markedTextRange")) ||
        CSCFSearchHasMarkedText(CSCloseFriendRead(textView,@"markedTextRange")) ||
        CSCFSearchHasMarkedText(CSCloseFriendRead(CSCloseFriendRead(textView,@"textView"),@"markedTextRange"));
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
static void DispatchPassword(id page,id input,BOOL composing,void (^native)(void)) {
    CSCFSearchInputState *state=InputState(page);
    NSString *query=SearchInput(page,input);
    if(state.resetting) { if(!query.length)native(); return; }
    if(state.consumed || state.epoch!=CSCloseFriendAccountEpoch())return;
    if(state.dispatchDepth || composing || SearchComposing(page)) {native();return;}
    if(query.length<6 || query.length>128) {native();return;}
    if([state.pendingQuery isEqual:query]) { [state.pendingCallbacks addObject:[native copy]]; return; }
    state.pendingQuery=query; state.pendingCallbacks=[NSMutableArray arrayWithObject:[native copy]];
    NSUInteger generation=state.generation, epoch=state.epoch;
    [CSCloseFriendManager.sharedManager checkHomepageSearchPassword:query isCurrent:^BOOL{
        return objc_getAssociatedObject(page,&SearchInputKey)==state && state.generation==generation &&
            epoch==CSCloseFriendAccountEpoch() && !SearchComposing(page) && [state.pendingQuery isEqual:query];
    } completion:^(BOOL consumed){
        if(objc_getAssociatedObject(page,&SearchInputKey)!=state || state.generation!=generation ||
           ![state.pendingQuery isEqual:query])return;
        NSArray *callbacks=[state.pendingCallbacks copy]; state.pendingCallbacks=nil; state.pendingQuery=nil;
        // Release native closures on account changes as well; they retain the page.
        if(epoch!=CSCloseFriendAccountEpoch() || SearchComposing(page))return;
        if(consumed) {
            state.consumed=YES; state.inputQuery=@"";
            @try {SearchReset(page);} @catch(__unused NSException *exception) {CSCFSearchClearResults(page);}
            CSCFCallVoid(page,@"resignSearchFirstResponder");
            return;
        }
        state.dispatchDepth++;
        @try {
            for(void (^callback)(void) in callbacks) {
                if(state.generation!=generation || epoch!=CSCloseFriendAccountEpoch())break;
                callback();
            }
        } @finally {state.dispatchDepth--;}
    }];
}
void CSCFSearchDispatchInput(id page,id input,BOOL composing,void (^native)(void)) {
    if(!NSThread.isMainThread || !SearchProtected(page)) {
        if(page)objc_setAssociatedObject(page,&SearchInputKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        native(); return;
    }
    CSCFSearchInputState *state=InputState(page);
    if(state.dispatchDepth || state.resetting) {DispatchPassword(page,input,composing,native);return;}
    NSString *query=SearchInput(page,input);
    if(state.epoch!=CSCloseFriendAccountEpoch())return;
    if(![state.inputQuery isEqual:query] || state.consumed || composing || SearchComposing(page)) {
        state.generation++; state.pendingQuery=nil; state.pendingCallbacks=nil;
    }
    state.inputQuery=query; state.consumed=NO;
    DispatchPassword(page,input,composing,native);
}
void CSCFSearchDispatchQuery(id page,id input,void (^native)(void)) {
    if(!NSThread.isMainThread || !SearchProtected(page)) {native();return;}
    CSCFSearchInputState *state=InputState(page);
    // Delayed work for an older edit cannot revive it after a new input/clear.
    if(!state.resetting && !state.dispatchDepth && state.inputQuery && ![state.inputQuery isEqual:SearchInput(page,input)])return;
    DispatchPassword(page,input,NO,native);
}
void CSCFSearchSubmit(id page,void (^native)(void)) {
    // Native typing already scheduled searches. Do not replay a query on Return.
    NSString *query=SearchInput(page,nil);
    if(query.length) CSCFSearchDispatchInput(page,query,NO,native);
    else CSCFSearchDispatchQuery(page,query,native);
}
@interface CSCFSearchState : NSObject
@property(nonatomic) NSUInteger epoch, revision, displayedRevision, generation, displayedGeneration, preparedGeneration;
@property(nonatomic) BOOL prepared;
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
            NSHashTable *pages=[NSHashTable weakObjectsHashTable];
            for(id item in Sections.allObjects) {
                State(item).prepared=NO;
                UIViewController *page=Presenter(item); if(page)[pages addObject:page];
            }
            for(id page in pages.allObjects)CSCFRefreshSurface(page,^(id owner){CSCFReloadTables(owner);});
        }];
    });
    [Sections addObject:section]; return state;
}
void CSCFSearchBegin(id section) {
    CSCFSearchState *state=State(section); state.source=nil; state.revision=0; state.prepared=NO; state.generation++;
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
    state.taskKey=[CSCloseFriendRead(section,@"ftsTaskKey") copy]; state.revision=0; state.prepared=NO;
    CSCFSearchPrepare(section);
}
BOOL CSCFSearchPrepare(id section) {
    CSCFSearchState *state=State(section); CSCloseFriendSnapshot *policy=CSCloseFriendCurrentSnapshot();
    BOOL current=state.epoch==CSCloseFriendAccountEpoch();
    if(state.prepared && current && state.revision==policy.revision && state.preparedGeneration==state.generation)return YES;
    if(state.key.length) {
        NSArray *rows=current ? CSCFSearchVisibleRows(state.source) : @[];
        NSString *setter=[state.key isEqual:@"contacts"] ? @"setContacts:" : @"setTopHitItems:";
        if(!CSCFSetObject(section,setter,rows)) return NO;
    }
    state.revision=policy.revision; state.preparedGeneration=state.generation; state.prepared=YES; return current;
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
