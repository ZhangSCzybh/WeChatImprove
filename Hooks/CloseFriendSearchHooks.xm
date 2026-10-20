#import "../Controllers/CSCloseFriendSearchAdapter.h"
static __thread NSUInteger PasswordDispatchDepth;
static void DispatchSearchInput(id page,id input,BOOL composing,void (^native)(void)) {
    if(PasswordDispatchDepth || composing) { native(); return; }
    PasswordDispatchDepth++;
    @try { if(!CSCFSearchConsumePassword(page,input)) native(); }
    @finally { PasswordDispatchDepth--; }
}
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
    __block IMP count=NULL;
    replacement=imp_implementationWithBlock(^NSInteger(id object){
        if(CSCFSearchGated(object)) return (NSInteger)1;
        if(!CSCFSearchPrepare(object)) return (NSInteger)0;
        return ((NSInteger(*)(id,SEL))count)(object,NSSelectorFromString(@"numberOfItems"));
    });
    if(!CSCloseFriendInstallHook(cls,@"numberOfItems",replacement,&count,"q@:")) imp_removeBlock(replacement);
    __block IMP cell=NULL;
    replacement=imp_implementationWithBlock(^id(id object,NSInteger index,NSInteger section){
        if(CSCFSearchGated(object)) return CSCFSearchUnlockCell();
        if(!CSCFSearchPrepare(object)) return [UITableViewCell new];
        id rendered=((id(*)(id,SEL,NSInteger,NSInteger))cell)(object,NSSelectorFromString(@"cellForItemAtIndex:section:"),index,section);
        CSCFSearchDidRender(object); return rendered;
    });
    if(!CSCloseFriendInstallHook(cls,@"cellForItemAtIndex:section:",replacement,&cell,"@@:qq")) imp_removeBlock(replacement);
    __block IMP select=NULL;
    replacement=imp_implementationWithBlock(^(id object,NSInteger index){
        if(CSCFSearchGated(object)) { CSCFSearchUnlock(object); return; }
        if(!CSCFSearchAllowsSelection(object) || !CSCFSearchPrepare(object)) return;
        ((void(*)(id,SEL,NSInteger))select)(object,NSSelectorFromString(@"didSelectRowAtIndex:"),index);
    });
    if(!CSCloseFriendInstallHook(cls,@"didSelectRowAtIndex:",replacement,&select,"v@:q")) imp_removeBlock(replacement);
    if([key isEqual:@"contacts"] || [key isEqual:@"topHitItems"]) {
        __block IMP dataCell=NULL;
        IMP replacement=imp_implementationWithBlock(^id(id object,NSInteger index,id path){
            id cell=((id(*)(id,SEL,NSInteger,id))dataCell)(object,NSSelectorFromString(@"dataCellForItemAtIndex:indexPath:"),index,path);
            NSArray *rows=CSCloseFriendRead(object,key);
            id item=[rows isKindOfClass:NSArray.class] && index>=0 && (NSUInteger)index<rows.count ? rows[(NSUInteger)index] : nil;
            CSCFSearchUpdateGroupCell(cell,item); return cell;
        });
        if(!CSCloseFriendInstallHook(cls,@"dataCellForItemAtIndex:indexPath:",replacement,&dataCell,"@@:q@")) imp_removeBlock(replacement);
    }
    __block IMP selectData=NULL;
    replacement=imp_implementationWithBlock(^(id object,NSInteger index,id path){
        if(CSCFSearchGated(object)) {CSCFSearchUnlock(object); return;}
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
    replacement=imp_implementationWithBlock(^(id object){if(CSCFSearchGated(object)) {CSCFSearchUnlock(object); return;} ((void(*)(id,SEL))load)(object,NSSelectorFromString(@"onLoadMore"));});
    if(!CSCloseFriendInstallHook(cls,@"onLoadMore",replacement,&load,"v@:")) imp_removeBlock(replacement);
}
%ctor { dispatch_async(dispatch_get_main_queue(),^{
    __block IMP inputChanged=NULL;
    IMP inputReplacement=imp_implementationWithBlock(^(id page,id marked,id query){
        DispatchSearchInput(page,query,marked!=nil,^{((void(*)(id,SEL,id,id))inputChanged)(page,NSSelectorFromString(@"mmInputBoxTextChanged:text:"),marked,query);});
    });
    if(!CSCloseFriendInstallHook(@"FTSHomeViewController",@"mmInputBoxTextChanged:text:",inputReplacement,&inputChanged,"v@:@@")) imp_removeBlock(inputReplacement);
    __block IMP voiceInput=NULL;
    inputReplacement=imp_implementationWithBlock(^(id page,id query,BOOL voice){
        DispatchSearchInput(page,query,NO,^{((void(*)(id,SEL,id,BOOL))voiceInput)(page,NSSelectorFromString(@"onGetTextInput:isFromVoice:"),query,voice);});
    });
    if(!CSCloseFriendInstallHook(@"FTSHomeViewController",@"onGetTextInput:isFromVoice:",inputReplacement,&voiceInput,"v@:@B")) imp_removeBlock(inputReplacement);
    for(NSString *name in @[@"onTextFieldChanged:",@"doWebSearchWithQuery:"]) {
        __block IMP original=NULL; SEL selector=NSSelectorFromString(name);
        IMP replacement=imp_implementationWithBlock(^(id page,id input){
            DispatchSearchInput(page,input,NO,^{((void(*)(id,SEL,id))original)(page,selector,input);});
        });
        if(!CSCloseFriendInstallHook(@"FTSHomeViewController",name,replacement,&original,"v@:@")) imp_removeBlock(replacement);
    }
    // Also cover pasted/voice queries and native search/history dispatch which bypasses
    // the text-field callback. Only the global homepage presenter is eligible.
    for(NSString *name in @[@"handleTextDidChange:",@"doSearch:",@"doFTSSearch:",@"recordLocalSearchHistory:"]) {
        __block IMP original=NULL; SEL selector=NSSelectorFromString(name);
        IMP replacement=imp_implementationWithBlock(^(id object,id query){
            DispatchSearchInput(CSCloseFriendRead(object,@"page"),query,NO,^{((void(*)(id,SEL,id))original)(object,selector,query);});
        });
        if(!CSCloseFriendInstallHook(@"FTSVoiceSearchBarController",name,replacement,&original,"v@:@")) imp_removeBlock(replacement);
    }
    InstallSection(@"FTSSingleContactSectionController",@"contacts");
    InstallSection(@"FTSGroupContactSectionController",@"contacts");
    InstallSection(@"FTSTopHitsSectionController",@"topHitItems");
    InstallSection(@"FTSMessageSectionController",nil);
    InstallSection(@"FTSSearchContactSectionController",nil);
    CSCloseFriendRecordCapability(@"search.message.filtered",NO);
    CSCloseFriendRecordCapability(@"search.extra-page-loading",NO);
}); }
