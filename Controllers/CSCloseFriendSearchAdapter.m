#import "CSCloseFriendSearchAdapter.h"
#import "CSCloseFriendManager.h"

static char SearchPasswordConsumedKey;
BOOL CSCFSearchSuppressLoading(id page) {
    return [objc_getAssociatedObject(page,&SearchPasswordConsumedKey) boolValue];
}
BOOL CSCFSearchConsumePassword(id page,id input) {
    if(!NSThread.isMainThread || !CSCFIsClass(page,@"FTSHomeViewController")) return NO;
    id bar=CSCloseFriendRead(page,@"searchBar");
    id field=CSCloseFriendRead(page,@"searchTextField");
    id textView=CSCloseFriendRead(bar,@"textView");
    if(CSCloseFriendRead(field,@"markedTextRange") || CSCloseFriendRead(textView,@"markedTextRange")) return NO;
    id query=[input isKindOfClass:NSString.class] ? input : CSCloseFriendRead(input,@"text");
    if(![query isKindOfClass:NSString.class]) query=CSCloseFriendRead(page,@"searchBarText");
    if(![query isKindOfClass:NSString.class]) return NO;
    if(![CSCloseFriendManager.sharedManager consumeHomepageSearchPassword:query]) {
        if([query length]) objc_setAssociatedObject(page,&SearchPasswordConsumedKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return NO;
    }
    objc_setAssociatedObject(page,&SearchPasswordConsumedKey,@YES,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    id presenter=CSCloseFriendRead(page,@"presenter");
    [NSObject cancelPreviousPerformRequestsWithTarget:presenter];
    // 8.0.78 uses WCSearchBar's large-input UITextView. Its native clear operation
    // resets the visible editor AND runs the empty-input delegate path. Clearing
    // searchTextField alone leaves that editor, query state and loading footer live.
    if(!CSCFCallVoid(bar,@"inputBoxClear")) {
        CSCFSetObject(field,@"setText:",@"");
        CSCFSetObject(textView,@"setText:",@"");
        CSCFSetObject(presenter,@"handleTextDidChange:",@"");
    }
    // Cancel after native empty-input reset; resetDataSource after cancellation
    // would create a fresh unfinished search and revive the loading indicator.
    [NSObject cancelPreviousPerformRequestsWithTarget:presenter];
    CSCFCallVoid(presenter,@"cancelFTSSearch");
    CSCFSetObject(presenter,@"setLatestCompeleteWebSearchQuery:",@"");
    CSCFSetObject(CSCloseFriendRead(page,@"tableView"),@"setTableFooterView:",nil);
    CSCFCallVoid(page,@"reloadList");
    CSCFCallVoid(page,@"resignSearchFirstResponder");
    return YES;
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
UITableViewCell *CSCFSearchUnlockCell(void) {
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text=@"解锁后查看"; cell.textLabel.textColor=UIColor.secondaryLabelColor;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator; return cell;
}
void CSCFSearchUnlock(id section) {
    UIViewController *page=Presenter(section); if(!page) return;
    NSUInteger epoch=CSCloseFriendAccountEpoch(); __weak id weakSection=section;
    CSCloseFriendAuthenticate(page,^(BOOL ok){
        if(ok && epoch==CSCloseFriendAccountEpoch() && weakSection && !CSCFSearchGated(weakSection)) {
            CSCFSearchPrepare(weakSection); CSCFReloadTables(Presenter(weakSection));
        }
    });
}

@interface CSCFGroupResultCover : UIView
@property(nonatomic,strong) NSMapTable<UIView *,NSNumber *> *hiddenStates;
@property(nonatomic,strong) id originalElements;
@property(nonatomic,copy) NSString *originalLabel;
@property(nonatomic) BOOL originalElement;
@property(nonatomic,strong) UILabel *titleLabel;
@end
@implementation CSCFGroupResultCover @end
static char GroupCoverKey;
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
static UIView *FindGroupAvatar(UIView *view) {
    if(CSCFIsClass(view,@"MMHeadImageView")) return view;
    for(UIView *child in view.subviews) {UIView *found=FindGroupAvatar(child); if(found) return found;}
    return nil;
}
void CSCFSearchUpdateGroupCell(id object,id item) {
    if(![object isKindOfClass:UITableViewCell.class]) return;
    UITableViewCell *cell=object; CSCFGroupResultCover *cover=objc_getAssociatedObject(cell,&GroupCoverKey);
    NSString *title=GroupDisplayTitle(item);
    BOOL masked=title && CSCloseFriendSurfaceConcealed(CSCloseFriendCurrentSnapshot(),CSCloseFriendSurfaceSearch);
    {
        if(cover) {
            for(UIView *child in cover.hiddenStates) child.hidden=[[cover.hiddenStates objectForKey:child] boolValue];
            cell.isAccessibilityElement=cover.originalElement; cell.accessibilityElements=cover.originalElements; cell.accessibilityLabel=cover.originalLabel;
            [cover removeFromSuperview]; objc_setAssociatedObject(cell,&GroupCoverKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC); cover=nil;
        }
        if(!masked) return;
    }
    if(!cover) {
        cover=[[CSCFGroupResultCover alloc] initWithFrame:cell.contentView.bounds]; cover.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight; cover.userInteractionEnabled=NO;
        cover.hiddenStates=[NSMapTable weakToStrongObjectsMapTable]; cover.originalElement=cell.isAccessibilityElement; cover.originalElements=cell.accessibilityElements; cover.originalLabel=cell.accessibilityLabel;
        UIView *head=FindGroupAvatar(cell.contentView); UIView *avatar=[head snapshotViewAfterScreenUpdates:NO];
        if(!avatar) {UIImageView *fallback=[[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"person.2.fill"]]; fallback.tintColor=UIColor.secondaryLabelColor; fallback.contentMode=UIViewContentModeScaleAspectFit; avatar=fallback;}
        avatar.frame=CGRectMake(16,10,40,40); avatar.autoresizingMask=UIViewAutoresizingFlexibleBottomMargin; [cover addSubview:avatar];
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(72,0,MAX(0,cover.bounds.size.width-88),cover.bounds.size.height)]; label.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight; label.font=[UIFont preferredFontForTextStyle:UIFontTextStyleBody]; label.textColor=UIColor.labelColor; label.numberOfLines=2; cover.titleLabel=label; [cover addSubview:label];
        cover.isAccessibilityElement=YES; objc_setAssociatedObject(cell,&GroupCoverKey,cover,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    cover.titleLabel.text=title; cover.accessibilityLabel=title; cover.backgroundColor=cell.contentView.backgroundColor ?: cell.backgroundColor ?: UIColor.systemBackgroundColor;
    for(UIView *child in cell.contentView.subviews) if(child!=cover) {if(![cover.hiddenStates objectForKey:child]) [cover.hiddenStates setObject:@(child.hidden) forKey:child]; child.hidden=YES;}
    if(cover.superview!=cell.contentView) [cell.contentView addSubview:cover]; [cell.contentView bringSubviewToFront:cover];
    cell.isAccessibilityElement=NO; cell.accessibilityLabel=nil; cell.accessibilityElements=@[cover];
}
