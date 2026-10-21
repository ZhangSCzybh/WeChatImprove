#import "../Controllers/CSCloseFriendSearchAdapter.h"
static void InstallSection(NSString *cls,NSString *key) {
    __block IMP update=NULL; SEL updateSEL=NSSelectorFromString(@"didUpdateWithModel:");
    IMP replacement=imp_implementationWithBlock(^(id object,id model){
        NSUInteger epoch=CSCloseFriendAccountEpoch(); id taskKey=[CSCloseFriendRead(object,@"ftsTaskKey") copy];
        void (^apply)(void)=^{
            id current=CSCloseFriendRead(object,@"ftsTaskKey");
            if(epoch!=CSCloseFriendAccountEpoch() || (taskKey && ![taskKey isEqual:current])) return;
            CSCFSearchWillUpdate(object);
            ((void(*)(id,SEL,id))update)(object,updateSEL,model); CSCFSearchDidUpdate(object,key);
        };
        if(NSThread.isMainThread) apply(); else dispatch_async(dispatch_get_main_queue(),apply);
    });
    if(!CSCloseFriendInstallHook(cls,@"didUpdateWithModel:",replacement,&update,"v@:@")) imp_removeBlock(replacement);
    __block IMP search=NULL;
    replacement=imp_implementationWithBlock(^(id object,id query){CSCFSearchBegin(object); ((void(*)(id,SEL,id))search)(object,NSSelectorFromString(@"search:"),query);});
    if(!CSCloseFriendInstallHook(cls,@"search:",replacement,&search,"v@:@")) imp_removeBlock(replacement);
    // Concealed aggregate sections have no visible rows or unlock affordance.
    __block IMP count=NULL;
    replacement=imp_implementationWithBlock(^NSInteger(id object){
        if(CSCFSearchGated(object)) return (NSInteger)0;
        if(!CSCFSearchPrepare(object)) return (NSInteger)0;
        return ((NSInteger(*)(id,SEL))count)(object,NSSelectorFromString(@"numberOfItems"));
    });
    if(!CSCloseFriendInstallHook(cls,@"numberOfItems",replacement,&count,"q@:")) imp_removeBlock(replacement);
    __block IMP cell=NULL;
    replacement=imp_implementationWithBlock(^id(id object,NSInteger index,NSInteger section){
        if(CSCFSearchGated(object)) return [UITableViewCell new];
        if(!CSCFSearchPrepare(object)) return [UITableViewCell new];
        id rendered=((id(*)(id,SEL,NSInteger,NSInteger))cell)(object,NSSelectorFromString(@"cellForItemAtIndex:section:"),index,section);
        CSCFSearchDidRender(object); return rendered;
    });
    if(!CSCloseFriendInstallHook(cls,@"cellForItemAtIndex:section:",replacement,&cell,"@@:qq")) imp_removeBlock(replacement);
    __block IMP select=NULL;
    replacement=imp_implementationWithBlock(^(id object,NSInteger index){
        if(CSCFSearchGated(object)) return;
        if(!CSCFSearchAllowsSelection(object) || !CSCFSearchPrepare(object)) return;
        ((void(*)(id,SEL,NSInteger))select)(object,NSSelectorFromString(@"didSelectRowAtIndex:"),index);
    });
    if(!CSCloseFriendInstallHook(cls,@"didSelectRowAtIndex:",replacement,&select,"v@:q")) imp_removeBlock(replacement);
    __block IMP selectData=NULL;
    replacement=imp_implementationWithBlock(^(id object,NSInteger index,id path){
        if(CSCFSearchGated(object)) return;
        if(!CSCFSearchAllowsSelection(object) || !CSCFSearchPrepare(object)) return;
        ((void(*)(id,SEL,NSInteger,id))selectData)(object,NSSelectorFromString(@"didSelectDataRowAtIndex:indexPath:"),index,path);
    });
    if(!CSCloseFriendInstallHook(cls,@"didSelectDataRowAtIndex:indexPath:",replacement,&selectData,"v@:q@")) imp_removeBlock(replacement);
    // Native "more N results" strings can contain the original model count. Use a neutral title
    // while filtering; never modify searchItemCount or the source model/cursor.
    __block IMP more=NULL;
    replacement=imp_implementationWithBlock(^id(id object){if(CSCloseFriendSurfaceConcealed(CSCloseFriendCurrentSnapshot(),CSCloseFriendSurfaceSearch)) return @"查看更多"; return ((id(*)(id,SEL))more)(object,NSSelectorFromString(@"titleForMoreCell"));});
    if(!CSCloseFriendInstallHook(cls,@"titleForMoreCell",replacement,&more,"@@:")) imp_removeBlock(replacement);
    __block IMP load=NULL;
    replacement=imp_implementationWithBlock(^(id object){if(CSCFSearchGated(object)) return; ((void(*)(id,SEL))load)(object,NSSelectorFromString(@"onLoadMore"));});
    if(!CSCloseFriendInstallHook(cls,@"onLoadMore",replacement,&load,"v@:")) imp_removeBlock(replacement);
}
static void InstallNativeSearchCell(void) {
    __block IMP update=NULL;
    SEL selector=NSSelectorFromString(@"updateContact:matchTip:asTopHit:");
    IMP replacement=imp_implementationWithBlock(^(id cell,id contact,id tip,BOOL topHit){
        // Contact, group and followed-Finder sections reuse FTSContactCell.
        // Redact the match payload before native rendering; never hide its views.
        if(CSCFSearchRedactsGroupMatch(contact)) tip=nil;
        ((void(*)(id,SEL,id,id,BOOL))update)(cell,selector,contact,tip,topHit);
        CSCFSearchUpdateGroupCell(cell,contact);
    });
    if(!CSCloseFriendInstallHook(@"FTSContactCell",NSStringFromSelector(selector),replacement,&update,"v@:@@B")) imp_removeBlock(replacement);
}
static void InstallSearchInputHooks(void) {
    for(NSString *name in @[@"setLoadingStatus",@"updateFooterView"]) {
        __block IMP original=NULL; SEL selector=NSSelectorFromString(name);
        IMP replacement=imp_implementationWithBlock(^(id page){
            if(CSCFSearchSuppressLoading(page)) { CSCFSearchClearResults(page); return; }
            ((void(*)(id,SEL))original)(page,selector);
        });
        if(!CSCloseFriendInstallHook(@"FTSHomeViewController",name,replacement,&original,"v@:")) imp_removeBlock(replacement);
    }
    __block IMP objects=NULL;
    IMP replacement=imp_implementationWithBlock(^id(id page,id adapter){
        if(CSCFSearchSuppressLoading(page)) { CSCFSearchClearResults(page); return @[]; }
        return ((id(*)(id,SEL,id))objects)(page,NSSelectorFromString(@"objectsForListAdapter:"),adapter);
    });
    if(!CSCloseFriendInstallHook(@"FTSHomeViewController",@"objectsForListAdapter:",replacement,&objects,"@@:@")) imp_removeBlock(replacement);
    __block IMP submit=NULL;
    replacement=imp_implementationWithBlock(^(id page){
        CSCFSearchSubmit(page,^{((void(*)(id,SEL))submit)(page,NSSelectorFromString(@"shouldReturnStartSearch"));});
    });
    if(!CSCloseFriendInstallHook(@"FTSHomeViewController",@"shouldReturnStartSearch",replacement,&submit,"v@:")) imp_removeBlock(replacement);
    __block IMP inputChanged=NULL;
    replacement=imp_implementationWithBlock(^(id page,id marked,id query){
        CSCFSearchDispatchInput(page,query,marked!=nil,^{((void(*)(id,SEL,id,id))inputChanged)(page,NSSelectorFromString(@"mmInputBoxTextChanged:text:"),marked,query);});
    });
    if(!CSCloseFriendInstallHook(@"FTSHomeViewController",@"mmInputBoxTextChanged:text:",replacement,&inputChanged,"v@:@@")) imp_removeBlock(replacement);
    __block IMP voiceInput=NULL;
    replacement=imp_implementationWithBlock(^(id page,id query,BOOL voice){
        CSCFSearchDispatchInput(page,query,NO,^{((void(*)(id,SEL,id,BOOL))voiceInput)(page,NSSelectorFromString(@"onGetTextInput:isFromVoice:"),query,voice);});
    });
    if(!CSCloseFriendInstallHook(@"FTSHomeViewController",@"onGetTextInput:isFromVoice:",replacement,&voiceInput,"v@:@B")) imp_removeBlock(replacement);
    __block IMP newVoice=NULL;
    replacement=imp_implementationWithBlock(^(id page,id query,id voiceID){
        CSCFSearchDispatchInput(page,query,NO,^{((void(*)(id,SEL,id,id))newVoice)(page,NSSelectorFromString(@"onGetTextInputFromNewVoice:voiceId:"),query,voiceID);});
    });
    if(!CSCloseFriendInstallHook(@"FTSHomeViewController",@"onGetTextInputFromNewVoice:voiceId:",replacement,&newVoice,"v@:@@")) imp_removeBlock(replacement);
    __block IMP legacyInput=NULL;
    replacement=imp_implementationWithBlock(^(id page,id input){
        CSCFSearchDispatchInput(page,input,NO,^{((void(*)(id,SEL,id))legacyInput)(page,NSSelectorFromString(@"onTextFieldChanged:"),input);});
    });
    if(!CSCloseFriendInstallHook(@"FTSHomeViewController",@"onTextFieldChanged:",replacement,&legacyInput,"v@:@")) imp_removeBlock(replacement);
    // Preserve live native searches. These guards only consume an exact password
    // or stop late callbacks from the query cleared after successful unlock.
    for(NSString *name in @[@"handleTextDidChange:",@"doSearch:",@"doFTSSearch:",@"recordLocalSearchHistory:",@"delaySearchImp:",@"delayPardusSearchImp:"]) {
        __block IMP original=NULL; SEL selector=NSSelectorFromString(name);
        replacement=imp_implementationWithBlock(^(id object,id query){
            CSCFSearchDispatchQuery(CSCloseFriendRead(object,@"page"),query,^{((void(*)(id,SEL,id))original)(object,selector,query);});
        });
        if(!CSCloseFriendInstallHook(@"FTSVoiceSearchBarController",name,replacement,&original,"v@:@")) imp_removeBlock(replacement);
    }
    __block IMP newVoiceChange=NULL;
    replacement=imp_implementationWithBlock(^(id object,id query,BOOL voice){
        CSCFSearchDispatchQuery(CSCloseFriendRead(object,@"page"),query,^{((void(*)(id,SEL,id,BOOL))newVoiceChange)(object,NSSelectorFromString(@"handleTextDidChange:fromNewVoice:"),query,voice);});
    });
    if(!CSCloseFriendInstallHook(@"FTSVoiceSearchBarController",@"handleTextDidChange:fromNewVoice:",replacement,&newVoiceChange,"v@:@B")) imp_removeBlock(replacement);
}
%ctor { dispatch_async(dispatch_get_main_queue(),^{
    InstallSearchInputHooks();
    InstallNativeSearchCell();
    InstallSection(@"FTSSingleContactSectionController",@"contacts");
    InstallSection(@"FTSGroupContactSectionController",@"contacts");
    InstallSection(@"FTSTopHitsSectionController",@"topHitItems");
    InstallSection(@"FTSMessageSectionController",nil);
    InstallSection(@"FTSSearchContactSectionController",nil);
    CSCloseFriendRecordCapability(@"search.message.filtered",NO);
    CSCloseFriendRecordCapability(@"search.extra-page-loading",NO);
}); }
