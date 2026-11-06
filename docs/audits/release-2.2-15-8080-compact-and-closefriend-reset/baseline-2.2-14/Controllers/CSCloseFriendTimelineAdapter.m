#import "CSCloseFriendSocialAdapter.h"
#import <objc/message.h>
#import <substrate.h>
@interface CSCFTimelineState : NSObject
@property(nonatomic,strong) CSCloseFriendSocialProjection *posts;
@property(nonatomic,strong) NSHashTable *postIdentities;
@property(nonatomic,weak) id facade;
@property(nonatomic) NSUInteger revision, epoch;
@property(nonatomic) NSUInteger presentationRevision;
@property(nonatomic) BOOL prepared, refreshing;
@end
@implementation CSCFTimelineState @end
@interface CSCFTimelineScope : NSObject
@property(nonatomic,strong) CSCloseFriendSnapshot *snapshot;
@property(nonatomic,strong) CSCFTimelineState *state;
@property(nonatomic,strong) id item;
@property(nonatomic) BOOL unreadPrevious, validatedPosts;
@end
@implementation CSCFTimelineScope @end
static CSCFTimelineScope *Scope; // main-thread only, synchronous UI calls
@interface CSCFTimelineUsers : NSObject
@property(nonatomic,weak) id owner;
@property(nonatomic,copy) NSArray *source, *visible;
@property(nonatomic) NSUInteger revision,epoch;
@end
@implementation CSCFTimelineUsers @end
static NSCache *LikeProjections, *CommentProjections;
static NSHashTable *TimelineStates;
static NSUInteger UsersCacheEpoch;
static char TimelineKey, CommentRevisionKey;
static id (*RawPosts)(id,SEL);
static id (*RawLikes)(id,SEL);
static id (*RawComments)(id,SEL);
static void InvalidateTimeline(id owner);
static void PrepareTimeline(id owner);
static BOOL SameObjects(NSArray *left,NSArray *right) {
    if(left==right)return YES;
    if(left.count!=right.count)return NO;
    // Native model equality/hash can archive the model and reenter our getters.
    for(NSUInteger i=0;i<left.count;i++)if(left[i]!=right[i])return NO;
    return YES;
}
static void ClearInteractionProjections(void) {
    [LikeProjections removeAllObjects]; [CommentProjections removeAllObjects];
    UsersCacheEpoch=CSCloseFriendAccountEpoch();
}
static void InstallCacheLifecycle(void) {
    static dispatch_once_t once;
    dispatch_once(&once,^{
        TimelineStates=[NSHashTable weakObjectsHashTable];
        for(NSString *name in @[CSCloseFriendPolicyDidChangeNotification,@"CSBackupAccountChanged"]) {
            [NSNotificationCenter.defaultCenter addObserverForName:name object:nil queue:NSOperationQueue.mainQueue usingBlock:^(__unused NSNotification *note){
                ClearInteractionProjections();
                // Release plugin snapshots immediately, including offscreen pages.
                // Native UI refresh remains with the existing surface lifecycle.
                for(CSCFTimelineState *state in TimelineStates.allObjects) {state.posts=nil; state.postIdentities=nil;}
            }];
        }
    });
}
static void ClearLikes(id facade,NSArray *posts) {
    SEL selector=NSSelectorFromString(@"removeCachesOfLikeUserWithDataItemId:");
    if(!CSCloseFriendMethodMatches(class_getInstanceMethod([facade class],selector),"v@:@")) return;
    for(id item in posts) { id itemID=CSCloseFriendRead(item,@"itemID"); if(itemID) ((void(*)(id,SEL,id))objc_msgSend)(facade,selector,itemID); }
}
static CSCFTimelineState *State(id owner) {
    CSCFTimelineState *state=objc_getAssociatedObject(owner,&TimelineKey);
    if(!state) {
        state=[CSCFTimelineState new]; state.epoch=CSCloseFriendAccountEpoch();
        objc_setAssociatedObject(owner,&TimelineKey,state,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [TimelineStates addObject:state];
        CSCFSocialTrack(owner,^(id page){
            InvalidateTimeline(page);
            if([page isKindOfClass:UIViewController.class] && [page isViewLoaded] && [[page view] window])PrepareTimeline(page);
        });
    }
    return state;
}
id CSCFTimelineFacade(id owner) { CSCFTimelineState *state=objc_getAssociatedObject(owner,&TimelineKey); return state.epoch==CSCloseFriendAccountEpoch() ? state.facade : nil; }
static CSCFTimelineScope *Enter(id owner,id item) {
    if(!NSThread.isMainThread)return nil;
    CSCFTimelineScope *previous=Scope;
    CSCloseFriendSnapshot *snapshot=previous.snapshot ?: CSCloseFriendCurrentSnapshot();
    CSCFTimelineState *state=CSCFIsClass(owner,@"WCTimeLineViewController") ? State(owner) : previous.state;
    if((!state || state.epoch==CSCloseFriendAccountEpoch()) &&
       ![snapshot concealsSurface:CSCloseFriendSurfaceTimeline] && ![snapshot concealsSurface:CSCloseFriendSurfaceInteraction])return previous;
    CSCFTimelineScope *next=[CSCFTimelineScope new]; next.snapshot=snapshot;
    next.item=item ?: previous.item; next.state=state;
    next.validatedPosts=previous && previous.state==state && previous.validatedPosts;
    next.unreadPrevious=CSCFUnreadBegin(); Scope=next; return previous;
}
static void Leave(CSCFTimelineScope *previous) {
    if(!NSThread.isMainThread || Scope==previous)return;
    // Filtered native like layouts are cleaned at their own call boundary only.
    // A scroll callback does not invalidate every loaded post's layout cache.
    CSCFUnreadEnd(Scope.unreadPrevious); Scope=previous;
}
static void InvalidateTimeline(id owner) {
    CSCFTimelineState *state=State(owner);
    state.posts=nil; state.postIdentities=nil;
    if(state.epoch!=CSCloseFriendAccountEpoch())return;
    CSCFSocialClearCaches(owner,@[@"cellHeightCache",@"cellShowItemCache"]);
}
static void PrepareTimeline(id owner) {
    if(!NSThread.isMainThread || !CSCFPageIsCurrent(owner) || ![owner isKindOfClass:UIViewController.class] || ![owner isViewLoaded]) return;
    CSCFTimelineState *state=State(owner);
    CSCloseFriendSnapshot *snapshot=CSCloseFriendCurrentSnapshot();
    if(state.epoch!=CSCloseFriendAccountEpoch() || state.refreshing || (state.prepared && state.presentationRevision==snapshot.revision)) return;
    BOOL affected=snapshot.blocked || (snapshot.enabled && snapshot.protectedUserNames.count &&
        ([snapshot.options[@"hideTimeline"] boolValue] || [snapshot.options[@"hideInteractions"] boolValue]));
    if(!affected && !state.prepared) return;
    id table=CSCloseFriendRead(owner,@"tableView");
    if(![table isKindOfClass:UITableView.class]) return;
    state.refreshing=YES;
    InvalidateTimeline(owner);
    CSCFTimelineScope *previous=Enter(owner,nil);
    BOOL refreshed=NO;
    @try {
        CSCFCallVoid(owner,@"onMessageUnReadCountChanged");
        // Native reload resets _isReloadingData and the deferred row cache.
        // UIKit completes the resulting render in its normal layout pass.
        refreshed=CSCFCallVoid(owner,@"reloadDataWrap") || CSCFCallVoid(table,@"reloadData");
    } @finally {
        Leave(previous); state.refreshing=NO;
        state.prepared=refreshed; state.presentationRevision=snapshot.revision;
    }
}
static void InstallTimelinePresentation(void) {
    // No viewDidLayoutSubviews/reloadDataWrap hook and no layoutIfNeeded:
    // native viewDidLayoutSubviews itself reloads, so forcing another layout
    // from that cycle can continually schedule a new reload (the 1.8-49 freeze).
    for(NSString *name in @[@"viewWillAppear:",@"viewDidAppear:"]) {
        __block IMP original=NULL; SEL selector=NSSelectorFromString(name);
        IMP replacement=imp_implementationWithBlock(^(id owner,BOOL animated){
            ((void(*)(id,SEL,BOOL))original)(owner,selector,animated);
            PrepareTimeline(owner);
        });
        if(!CSCloseFriendInstallHook(@"WCTimeLineViewController",name,replacement,&original,"v@:B")) imp_removeBlock(replacement);
    }
    __block IMP disappear=NULL;
    IMP replacement=imp_implementationWithBlock(^(id owner,BOOL animated){
        @try {((void(*)(id,SEL,BOOL))disappear)(owner,@selector(viewDidDisappear:),animated);}
        @finally {
            ClearInteractionProjections();
            CSCFTimelineState *state=objc_getAssociatedObject(owner,&TimelineKey);
            state.posts=nil; state.postIdentities=nil;
        }
    });
    if(!CSCloseFriendInstallHook(@"WCTimeLineViewController",@"viewDidDisappear:",replacement,&disappear,"v@:B"))imp_removeBlock(replacement);
}
static NSArray *ProjectedPosts(id facade) {
    if(!NSThread.isMainThread || !Scope.state || !RawPosts)return nil;
    CSCFTimelineState *state=Scope.state;
    if(state.epoch!=CSCloseFriendAccountEpoch())return @[];
    if(!Scope.validatedPosts || !state.posts || state.revision!=Scope.snapshot.revision) {
        CSCFTimelineScope *saved=Scope; id source=nil; Scope=nil;
        @try {source=RawPosts(facade,NSSelectorFromString(@"getTimelineDataItem"));} @finally {Scope=saved;}
        if(![source isKindOfClass:NSArray.class])return @[];
        if(!state.posts || state.facade!=facade || state.revision!=Scope.snapshot.revision || !SameObjects(state.posts.source,source)) {
            state.facade=facade;
            state.posts=[[CSCloseFriendSocialProjection alloc] initWithSource:source snapshot:Scope.snapshot surface:CSCloseFriendSurfaceTimeline read:^id(id object,NSString *key){return CSCloseFriendRead(object,key);}];
            state.postIdentities=[NSHashTable hashTableWithOptions:NSPointerFunctionsObjectPointerPersonality|NSPointerFunctionsWeakMemory];
            for(id item in state.posts.visible)[state.postIdentities addObject:item];
            state.revision=Scope.snapshot.revision;
        }
        Scope.validatedPosts=YES;
    }
    return state.posts.visible;
}
static BOOL ModelScoped(id item) {
    return NSThread.isMainThread && Scope && [Scope.snapshot concealsSurface:CSCloseFriendSurfaceInteraction] &&
        (item==Scope.item || [Scope.state.postIdentities containsObject:item]);
}
static NSArray *ProjectedUsers(id item,BOOL likes) {
    NSArray *source=likes ? RawLikes(item,NSSelectorFromString(@"likeUsers")) : RawComments(item,NSSelectorFromString(@"commentUsers"));
    if(![source isKindOfClass:NSArray.class])source=@[];
    if(!LikeProjections) {LikeProjections=[NSCache new]; CommentProjections=[NSCache new]; LikeProjections.countLimit=128; CommentProjections.countLimit=128;}
    NSUInteger epoch=CSCloseFriendAccountEpoch();
    if(UsersCacheEpoch!=epoch)ClearInteractionProjections();
    NSCache *cache=likes ? LikeProjections : CommentProjections;
    // NSCache holds a nonrecursive lock while hashing its key. WCDataItem.hash
    // archives interaction getters, so only a pointer value may be used here.
    NSValue *key=[NSValue valueWithPointer:(__bridge const void *)item];
    CSCFTimelineUsers *users=[cache objectForKey:key];
    if(!users || users.owner!=item || users.revision!=Scope.snapshot.revision || users.epoch!=epoch || !SameObjects(users.source,source)) {
        // A weak owner also rejects a cached entry after its address is reused.
        users=[CSCFTimelineUsers new]; users.owner=item; users.source=[source copy]; users.revision=Scope.snapshot.revision; users.epoch=epoch;
        users.visible=[[CSCloseFriendSocialProjection alloc] initWithSource:source snapshot:Scope.snapshot surface:CSCloseFriendSurfaceInteraction read:^id(id object,NSString *key){return CSCloseFriendRead(object,key);}].visible;
        [cache setObject:users forKey:key];
    }
    return users.visible;
}
static BOOL LikesFiltered(id item) {
    return RawLikes && ModelScoped(item) && ProjectedUsers(item,YES).count<[RawLikes(item,NSSelectorFromString(@"likeUsers")) count];
}
static void InstallModel(void) {
    InstallCacheLifecycle();
    __block IMP original=NULL;
    IMP replacement=imp_implementationWithBlock(^id(id object){NSArray *p=ProjectedPosts(object); return p ?: ((id(*)(id,SEL))original)(object,NSSelectorFromString(@"getTimelineDataItem"));});
    if(CSCloseFriendInstallHook(@"WCFacade",@"getTimelineDataItem",replacement,&original,"@@:")) RawPosts=(void *)original; else imp_removeBlock(replacement);
    __block IMP count=NULL;
    replacement=imp_implementationWithBlock(^NSInteger(id object){NSArray *p=ProjectedPosts(object); return p ? (NSInteger)p.count : ((NSInteger(*)(id,SEL))count)(object,NSSelectorFromString(@"countOfTimelineDataItem"));});
    if(!CSCloseFriendInstallHook(@"WCFacade",@"countOfTimelineDataItem",replacement,&count,"q@:")) imp_removeBlock(replacement);
    __block IMP indexed=NULL;
    replacement=imp_implementationWithBlock(^id(id object,NSInteger index){NSArray *p=ProjectedPosts(object); return p ? (index>=0 && (NSUInteger)index<p.count ? p[(NSUInteger)index] : nil) : ((id(*)(id,SEL,NSInteger))indexed)(object,NSSelectorFromString(@"getTimelineDataItemOfIndex:"),index);});
    if(!CSCloseFriendInstallHook(@"WCFacade",@"getTimelineDataItemOfIndex:",replacement,&indexed,"@@:q")) imp_removeBlock(replacement);
    CSCFSocialHook0(@"WCFacade",@"reloadTimelineDataItems",^(__unused id object,void(^orig)(void)){CSCFTimelineScope *saved=Scope; Scope=nil; @try {orig();} @finally {Scope=saved;} });
    for(NSString *name in @[@"likeUsers",@"commentUsers"]) {
        BOOL likes=[name isEqual:@"likeUsers"]; __block IMP raw=NULL; SEL sel=NSSelectorFromString(name);
        replacement=imp_implementationWithBlock(^id(id object){return ModelScoped(object) ? ProjectedUsers(object,likes) : ((id(*)(id,SEL))raw)(object,sel);});
        if(CSCloseFriendInstallHook(@"WCDataItem",name,replacement,&raw,"@@:")) { if(likes) RawLikes=(void *)raw; else RawComments=(void *)raw; } else imp_removeBlock(replacement);
    }
    for(NSString *name in @[@"likeCount",@"commentCount"]) {
        BOOL likes=[name isEqual:@"likeCount"]; __block IMP raw=NULL; SEL sel=NSSelectorFromString(name);
        replacement=imp_implementationWithBlock(^int(id object){return ModelScoped(object) && RawLikes && RawComments ? (int)MIN(ProjectedUsers(object,likes).count,INT_MAX) : ((int(*)(id,SEL))raw)(object,sel);});
        if(!CSCloseFriendInstallHook(@"WCDataItem",name,replacement,&raw,"i@:")) imp_removeBlock(replacement);
    }
    // Native itemID/width caches have no policy revision. Clear before scoped layout reads and
    // after each affected layout read, so filtered styles cannot contaminate an unscoped consumer.
    __block IMP styles=NULL;
    replacement=imp_implementationWithBlock(^id(id facade,id item,double width,BOOL spring){BOOL filtered=LikesFiltered(item); if(filtered)ClearLikes(facade,@[item]); @try {return ((id(*)(id,SEL,id,double,BOOL))styles)(facade,NSSelectorFromString(@"layoutStylesOfLikeUserWithDataItem:width:isSpringStyle:"),item,width,spring);} @finally {if(filtered)ClearLikes(facade,@[item]);}});
    if(!CSCloseFriendInstallHook(@"WCFacade",@"layoutStylesOfLikeUserWithDataItem:width:isSpringStyle:",replacement,&styles,"@@:@dB")) imp_removeBlock(replacement);
    __block IMP height=NULL;
    replacement=imp_implementationWithBlock(^double(id facade,double width,id item,BOOL spring){BOOL filtered=LikesFiltered(item); if(filtered)ClearLikes(facade,@[item]); @try {return ((double(*)(id,SEL,double,id,BOOL))height)(facade,NSSelectorFromString(@"likeUserHeightForWidth:withDataItem:isSpringStyle:"),width,item,spring);} @finally {if(filtered)ClearLikes(facade,@[item]);}});
    if(!CSCloseFriendInstallHook(@"WCFacade",@"likeUserHeightForWidth:withDataItem:isSpringStyle:",replacement,&height,"d@:d@B")) imp_removeBlock(replacement);
}
// Only known method signatures are wrapped. Native section/body/footer/ad semantics stay native.
static void TimelineMethod(NSString *name,const char *types) {
    __block IMP raw=NULL; SEL sel=NSSelectorFromString(name); IMP replacement=NULL;
#define BEGIN CSCFTimelineScope *old=Enter(object,nil)
#define END @finally {Leave(old);}
    if(!strcmp(types,"q@:@")) replacement=imp_implementationWithBlock(^NSInteger(id object,id a){BEGIN; @try {return ((NSInteger(*)(id,SEL,id))raw)(object,sel,a);} END });
    else if(!strcmp(types,"q@:@q")) replacement=imp_implementationWithBlock(^NSInteger(id object,id a,NSInteger b){BEGIN; @try {return ((NSInteger(*)(id,SEL,id,NSInteger))raw)(object,sel,a,b);} END });
    else if(!strcmp(types,"@@:@@")) replacement=imp_implementationWithBlock(^id(id object,id a,id b){BEGIN; @try {return ((id(*)(id,SEL,id,id))raw)(object,sel,a,b);} END });
    else if(!strcmp(types,"d@:@@")) replacement=imp_implementationWithBlock(^double(id object,id a,id b){BEGIN; @try {return ((double(*)(id,SEL,id,id))raw)(object,sel,a,b);} END });
    else if(!strcmp(types,"v@:@@")) replacement=imp_implementationWithBlock(^(id object,id a,id b){if(!CSCFPageIsCurrent(object)) return; BEGIN; @try {((void(*)(id,SEL,id,id))raw)(object,sel,a,b);} END });
    else if(!strcmp(types,"v@:@@@")) replacement=imp_implementationWithBlock(^(id object,id a,id b,id c){if(!CSCFPageIsCurrent(object)) return; BEGIN; @try {((void(*)(id,SEL,id,id,id))raw)(object,sel,a,b,c);} END });
    else if(!strcmp(types,"@@:q")) replacement=imp_implementationWithBlock(^id(id object,NSInteger a){BEGIN; @try {return ((id(*)(id,SEL,NSInteger))raw)(object,sel,a);} END });
    else if(!strcmp(types,"@@:")) replacement=imp_implementationWithBlock(^id(id object){BEGIN; @try {return ((id(*)(id,SEL))raw)(object,sel);} END });
    else if(!strcmp(types,"@@:@")) replacement=imp_implementationWithBlock(^id(id object,id a){BEGIN; @try {return ((id(*)(id,SEL,id))raw)(object,sel,a);} END });
    else if(!strcmp(types,"Q@:@")) replacement=imp_implementationWithBlock(^NSUInteger(id object,id a){BEGIN; @try {return ((NSUInteger(*)(id,SEL,id))raw)(object,sel,a);} END });
#undef BEGIN
#undef END
    if(replacement && !CSCloseFriendInstallHook(@"WCTimeLineViewController",name,replacement,&raw,types)) imp_removeBlock(replacement);
}
static BOOL CommentCurrent(id cell) {
    NSNumber *revision=objc_getAssociatedObject(cell,&CommentRevisionKey);
    return CSCFPageIsCurrent(cell) && revision && revision.unsignedIntegerValue==CSCloseFriendCurrentSnapshot().revision && !CSCFSocialHidden(CSCloseFriendRead(cell,@"mainDataItem"),CSCloseFriendSurfaceTimeline);
}
static void InstallComments(void) {
    // The count/index/height/name helpers all run against the SAME scoped native object.
    Class meta=object_getClass(NSClassFromString(@"WCTimeLineCommentCellView"));
    for(NSString *name in @[@"getCommentViewCountForDataItem:",@"getNickNameForDataItem:",@"getCellHeightForDataItem:RowIndex:pageContext:",@"getCommentIndexForDataItem:RowIndex:",@"isLastComment:RowIndex:",@"GetIsCommentCellRow:RowIndex:",@"GetIsLastCommentOrLikeCell:RowIndex:"]) {
        __block IMP raw=NULL; SEL sel=NSSelectorFromString(name); IMP replacement=NULL; const char *type=NULL;
#define BEGIN CSCFTimelineScope *old=Enter(nil,item)
#define END @finally {Leave(old);}
        if([name isEqual:@"getCommentViewCountForDataItem:"]) { type="Q@:@"; replacement=imp_implementationWithBlock(^NSUInteger(id object,id item){BEGIN; @try{return ((NSUInteger(*)(id,SEL,id))raw)(object,sel,item);} END }); }
        else if([name isEqual:@"getNickNameForDataItem:"]) { type="@@:@"; replacement=imp_implementationWithBlock(^id(id object,id item){BEGIN; @try{return ((id(*)(id,SEL,id))raw)(object,sel,item);} END }); }
        else if([name isEqual:@"getCellHeightForDataItem:RowIndex:pageContext:"]) {type="d@:@q@"; replacement=imp_implementationWithBlock(^double(id object,id item,NSInteger row,id context){BEGIN; @try{return ((double(*)(id,SEL,id,NSInteger,id))raw)(object,sel,item,row,context);} END });}
        else if([name isEqual:@"getCommentIndexForDataItem:RowIndex:"]) {type="q@:@q"; replacement=imp_implementationWithBlock(^NSInteger(id object,id item,NSInteger row){BEGIN; @try{return ((NSInteger(*)(id,SEL,id,NSInteger))raw)(object,sel,item,row);} END });}
        else {type="B@:@q"; replacement=imp_implementationWithBlock(^BOOL(id object,id item,NSInteger row){BEGIN; @try{return ((BOOL(*)(id,SEL,id,NSInteger))raw)(object,sel,item,row);} END });}
#undef BEGIN
#undef END
        BOOL available=CSCloseFriendMethodMatches(class_getInstanceMethod(meta,sel),type); if(available) MSHookMessageEx(meta,sel,replacement,&raw); else imp_removeBlock(replacement);
        CSCloseFriendRecordCapability([@"social.comment." stringByAppendingString:name],available);
    }
    CSCFSocialHook1(@"WCTimeLineCommentCellView",@"setMainDataItem:",^(id cell,id item,void(^orig)(id)){
        CSCFPageIsCurrent(cell); objc_setAssociatedObject(cell,&CommentRevisionKey,@(CSCloseFriendCurrentSnapshot().revision),OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        CSCFTimelineScope *old=Enter(nil,item); @try {orig(item);} @finally {Leave(old);}
    });
    for(NSString *name in @[@"initView",@"initLikeContainer",@"layoutSubviews"]) CSCFSocialHook0(@"WCTimeLineCommentCellView",name,^(id cell,void(^orig)(void)){
        CSCFTimelineScope *old=Enter(nil,CSCloseFriendRead(cell,@"mainDataItem")); @try {orig();} @finally {Leave(old);}
    });
    __block IMP show=NULL;
    IMP replacement=imp_implementationWithBlock(^id(id cell){if(!CommentCurrent(cell)) return nil; CSCFTimelineScope *old=Enter(nil,CSCloseFriendRead(cell,@"mainDataItem")); @try {return ((id(*)(id,SEL))show)(cell,NSSelectorFromString(@"getShowComment"));} @finally {Leave(old);} });
    if(!CSCloseFriendInstallHook(@"WCTimeLineCommentCellView",@"getShowComment",replacement,&show,"@@:")) imp_removeBlock(replacement);
    for(NSString *name in @[@"showCommentClickOption:",@"showCommentDeleteOption:",@"onCommentViewDelete:",@"onFulltextBtnClick:"]) CSCFSocialHook1(@"WCTimeLineCommentCellView",name,^(id cell,id arg,void(^orig)(id)){
        if(!CommentCurrent(cell)) return; CSCFTimelineScope *old=Enter(nil,CSCloseFriendRead(cell,@"mainDataItem")); @try {orig(arg);} @finally {Leave(old);}
    });
    // Native delete APIs take a source index. Do not forward a projected index into a business edit.
    __block IMP remove=NULL;
    replacement=imp_implementationWithBlock(^(id cell,NSUInteger index){if(!CommentCurrent(cell) || CSCloseFriendSurfaceConcealed(CSCloseFriendCurrentSnapshot(),CSCloseFriendSurfaceInteraction)) return; ((void(*)(id,SEL,NSUInteger))remove)(cell,NSSelectorFromString(@"deleteComment:"),index);});
    if(!CSCloseFriendInstallHook(@"WCTimeLineCommentCellView",@"deleteComment:",replacement,&remove,"v@:Q")) imp_removeBlock(replacement);
    __block IMP removeFromPage=NULL;
    replacement=imp_implementationWithBlock(^(id owner,NSUInteger index,id item){
        if(!CSCFPageIsCurrent(owner) || CSCloseFriendSurfaceConcealed(CSCloseFriendCurrentSnapshot(),CSCloseFriendSurfaceInteraction) || CSCFSocialHidden(item,CSCloseFriendSurfaceTimeline)) return;
        ((void(*)(id,SEL,NSUInteger,id))removeFromPage)(owner,NSSelectorFromString(@"onWCTimeLineCommentCellDeleteComment:ofDataItem:"),index,item);
    });
    if(!CSCloseFriendInstallHook(@"WCTimeLineViewController",@"onWCTimeLineCommentCellDeleteComment:ofDataItem:",replacement,&removeFromPage,"v@:Q@")) imp_removeBlock(replacement);
    for(NSString *name in @[@"onCommentViewClicked:item:comment:",@"onCommentViewEmoticonClicked:item:comment:",@"onCommentViewPicClicked:item:comment:",@"onCommentViewExposured:item:comment:",@"onCommentViewAddEmotion:item:comment:"]) {
        __block IMP callback=NULL; SEL selector=NSSelectorFromString(name);
        replacement=imp_implementationWithBlock(^(id cell,id view,id item,id comment){
            if(!CommentCurrent(cell) || CSCFSocialHidden(comment,CSCloseFriendSurfaceInteraction)) return;
            CSCFTimelineScope *old=Enter(nil,CSCloseFriendRead(cell,@"mainDataItem"));
            @try {((void(*)(id,SEL,id,id,id))callback)(cell,selector,view,item,comment);} @finally {Leave(old);}
        });
        if(!CSCloseFriendInstallHook(@"WCTimeLineCommentCellView",name,replacement,&callback,"v@:@@@")) imp_removeBlock(replacement);
    }
    __block IMP link=NULL;
    replacement=imp_implementationWithBlock(^(id cell,id value,CGRect rect){
        if(!CommentCurrent(cell)) return; CSCFTimelineScope *old=Enter(nil,CSCloseFriendRead(cell,@"mainDataItem"));
        @try {((void(*)(id,SEL,id,CGRect))link)(cell,NSSelectorFromString(@"onLinkClicked:withRect:"),value,rect);} @finally {Leave(old);}
    });
    if(!CSCloseFriendInstallHook(@"WCTimeLineCommentCellView",@"onLinkClicked:withRect:",replacement,&link,"v@:@{CGRect={CGPoint=dd}{CGSize=dd}}")) imp_removeBlock(replacement);
    __block IMP sheet=NULL;
    replacement=imp_implementationWithBlock(^(id cell,id value,NSInteger index){
        if(!CommentCurrent(cell)) return; CSCFTimelineScope *old=Enter(nil,CSCloseFriendRead(cell,@"mainDataItem"));
        @try {((void(*)(id,SEL,id,NSInteger))sheet)(cell,NSSelectorFromString(@"actionSheet:clickedButtonAtIndex:"),value,index);} @finally {Leave(old);}
    });
    if(!CSCloseFriendInstallHook(@"WCTimeLineCommentCellView",@"actionSheet:clickedButtonAtIndex:",replacement,&sheet,"v@:@q")) imp_removeBlock(replacement);
    __block IMP reply=NULL;
    replacement=imp_implementationWithBlock(^(id owner,id comment,id item,id view){if(!CSCFPageIsCurrent(owner) || CSCFSocialHidden(comment,CSCloseFriendSurfaceInteraction) || CSCFSocialHidden(item,CSCloseFriendSurfaceTimeline)) return; ((void(*)(id,SEL,id,id,id))reply)(owner,NSSelectorFromString(@"onReplyComment:ofDataItem:ofTouchedView:"),comment,item,view);});
    if(!CSCloseFriendInstallHook(@"WCTimeLineViewController",@"onReplyComment:ofDataItem:ofTouchedView:",replacement,&reply,"v@:@@@")) imp_removeBlock(replacement);
}
void CSCFTimelineInstall(void) {
    BOOL ready=YES;
    NSDictionary *contracts=@{@"WCFacade":@{@"getTimelineDataItem":@"@@:",@"countOfTimelineDataItem":@"q@:",@"getTimelineDataItemOfIndex:":@"@@:q",@"removeCachesOfLikeUserWithDataItemId:":@"v@:@"},@"WCDataItem":@{@"likeUsers":@"@@:",@"commentUsers":@"@@:",@"likeCount":@"i@:",@"commentCount":@"i@:"},@"WCTimeLineViewController":@{@"numberOfSectionsInTableView:":@"q@:@",@"tableView:numberOfRowsInSection:":@"q@:@q",@"tableView:cellForRowAtIndexPath:":@"@@:@@",@"tableView:heightForRowAtIndexPath:":@"d@:@@",@"tableView:didSelectRowAtIndexPath:":@"v@:@@"}};
    for(NSString *cls in contracts) for(NSString *selector in contracts[cls]) ready &= CSCloseFriendMethodMatches(class_getInstanceMethod(NSClassFromString(cls),NSSelectorFromString(selector)),[contracts[cls][selector] UTF8String]);
    NSDictionary *commentContracts=@{@"getCommentViewCountForDataItem:":@"Q@:@",@"getCommentIndexForDataItem:RowIndex:":@"q@:@q",@"getCellHeightForDataItem:RowIndex:pageContext:":@"d@:@q@",@"getNickNameForDataItem:":@"@@:@"};
    for(NSString *selector in commentContracts) ready &= CSCloseFriendMethodMatches(class_getClassMethod(NSClassFromString(@"WCTimeLineCommentCellView"),NSSelectorFromString(selector)),[commentContracts[selector] UTF8String]);
    CSCloseFriendRecordCapability(@"social.timeline.coupled",ready);
    if(!ready) return;
    InstallModel(); InstallComments(); InstallTimelinePresentation();
    TimelineMethod(@"numberOfSectionsInTableView:","q@:@");
    TimelineMethod(@"tableView:numberOfRowsInSection:","q@:@q");
    TimelineMethod(@"tableView:cellForRowAtIndexPath:","@@:@@");
    TimelineMethod(@"tableView:heightForRowAtIndexPath:","d@:@@");
    TimelineMethod(@"tableView:didSelectRowAtIndexPath:","v@:@@");
    TimelineMethod(@"tableView:willDisplayCell:forRowAtIndexPath:","v@:@@@");
    TimelineMethod(@"getNextDataItem:","@@:q"); TimelineMethod(@"visibleDataItemList","@@:");
    TimelineMethod(@"indexPathOfDataItem:","@@:@"); TimelineMethod(@"sectionIndexForDataItemWithTid:","Q@:@");
    for(NSString *name in @[@"scrollViewDidScroll:",@"scrollTableViewToShowDataItem:",@"refreshWholeViewWithFixedDataItem:"]) CSCFSocialHook1(@"WCTimeLineViewController",name,^(id owner,id arg,void(^orig)(id)){
        if(!CSCFPageIsCurrent(owner)) return; CSCFTimelineScope *old=Enter(owner,nil); @try {orig(arg);} @finally {Leave(old);}
    });
}
