#import "CSCloseFriendSocialAdapter.h"
#import <objc/message.h>
#import <substrate.h>

// FB details cache interaction arrays in ivars and read those ivars directly. Projection
// belongs to synchronous rendering only; business actions always see native source arrays.
@interface CSCFDetailState : NSObject
@property(nonatomic,strong) id item;
@property(nonatomic,strong) CSCloseFriendSocialProjection *likes,*comments;
@property(nonatomic,strong) NSArray *savedLikes,*savedComments;
@property(nonatomic,strong) NSMutableArray *visibleLikes,*visibleComments;
@property(nonatomic,strong) id renderedCommentView;
@property(nonatomic) NSUInteger epoch,revision,depth;
@property(nonatomic) BOOL gridDirty;
@end
@implementation CSCFDetailState @end
@interface CSCFDetailCommentBinding : NSObject
@property(nonatomic,strong) id item,comment;
@property(nonatomic,weak) id owner;
@property(nonatomic) NSUInteger epoch,revision;
@end
@implementation CSCFDetailCommentBinding @end
static char DetailStateKey,DetailCommentKey,DetailGridKey;
static BOOL DetailReady;
static id DetailIvar(id object,const char *name) {
    Ivar ivar=class_getInstanceVariable([object class],name);
    return ivar && ivar_getTypeEncoding(ivar)[0]=='@' ? object_getIvar(object,ivar) : nil;
}
static NSArray *DetailArray(id object,const char *name) {
    id value=DetailIvar(object,name); return [value isKindOfClass:NSArray.class] ? value : @[];
}
static BOOL DetailSameObjects(NSArray *a,NSArray *b) {
    if(a.count!=b.count) return NO;
    for(NSUInteger i=0;i<a.count;i++) if(a[i]!=b[i]) return NO;
    return YES;
}
static CSCFDetailState *DetailState(id page) {
    CSCFDetailState *state=objc_getAssociatedObject(page,&DetailStateKey);
    if(!state) {
        state=[CSCFDetailState new]; state.epoch=CSCloseFriendAccountEpoch(); state.revision=NSUIntegerMax;
        objc_setAssociatedObject(page,&DetailStateKey,state,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return state;
}
static void DetailRefresh(id page) {
    CSCFDetailState *state=DetailState(page); state.revision=NSUIntegerMax;
    CSCFSocialClearCaches(page,@[@"m_dicUserCommentsUICache"]);
    CSCFCallVoid(page,@"updateHeaderGridView"); CSCFCallVoid(page,@"reloadTableView");
}
static CSCFDetailState *DetailEnter(id page) {
    if(!NSThread.isMainThread) return nil;
    CSCFDetailState *state=DetailState(page);
    if(state.depth++) return state;
    state.savedLikes=DetailIvar(page,"_arrLikeList"); state.savedComments=DetailIvar(page,"_arrCommentList");
    id item=CSCloseFriendRead(page,@"dataItem");
    BOOL current=CSCFPageIsCurrent(page) && state.epoch==CSCloseFriendAccountEpoch();
    NSArray *likes=current ? DetailArray(item,"_likeUsers") : @[];
    NSArray *comments=current ? DetailArray(item,"_commentUsers") : @[];
    CSCloseFriendSnapshot *snapshot=CSCloseFriendCurrentSnapshot();
    if(state.item!=item || state.revision!=snapshot.revision || !DetailSameObjects(state.likes.source,likes) || !DetailSameObjects(state.comments.source,comments)) {
        state.item=item; state.revision=snapshot.revision;
        state.likes=CSCFSocialProject(likes,CSCloseFriendSurfaceInteraction);
        state.comments=CSCFSocialProject(comments,CSCloseFriendSurfaceInteraction);
        state.visibleLikes=[state.likes.visible mutableCopy]; state.visibleComments=[state.comments.visible mutableCopy];
        state.gridDirty=YES; CSCFSocialClearCaches(page,@[@"m_dicUserCommentsUICache"]);
    }
    CSCFSocialSetIvar(page,@"_arrLikeList",state.visibleLikes ?: [NSMutableArray array]);
    CSCFSocialSetIvar(page,@"_arrCommentList",state.visibleComments ?: [NSMutableArray array]);
    CSCFSocialTrack(page,^(id owner){DetailRefresh(owner);});
    return state;
}
static void DetailLeave(id page,CSCFDetailState *state) {
    if(!state || !state.depth || --state.depth) return;
    CSCFSocialSetIvar(page,@"_arrLikeList",state.savedLikes);
    CSCFSocialSetIvar(page,@"_arrCommentList",state.savedComments);
    state.savedLikes=nil; state.savedComments=nil;
}
static void DetailEnsureGrid(id page,CSCFDetailState *state) {
    if(state.gridDirty) {state.gridDirty=NO; CSCFCallVoid(page,@"updateHeaderGridView");}
}
static NSUInteger DetailSourceIndex(id page,id comment) {
    CSCFDetailState *state=DetailState(page);
    if(!comment || state.depth || !CSCFPageIsCurrent(page) || state.epoch!=CSCloseFriendAccountEpoch() || CSCFSocialHidden(comment,CSCloseFriendSurfaceInteraction)) return NSNotFound;
    id item=CSCloseFriendRead(page,@"dataItem");
    if(item!=state.item) return NSNotFound;
    NSArray *source=DetailArray(page,"_arrCommentList");
    NSUInteger index=[source indexOfObjectIdenticalTo:comment];
    // Both references must still designate this native comment before forwarding a business action.
    return index!=NSNotFound && [DetailArray(item,"_commentUsers") indexOfObjectIdenticalTo:comment]!=NSNotFound ? index : NSNotFound;
}
static BOOL DetailBindTag(id page,id view) {
    CSCFDetailCommentBinding *binding=objc_getAssociatedObject(view,&DetailCommentKey);
    if(!binding || binding.epoch!=CSCloseFriendAccountEpoch() || binding.revision!=CSCloseFriendCurrentSnapshot().revision || binding.item!=CSCloseFriendRead(page,@"dataItem")) return NO;
    NSUInteger index=DetailSourceIndex(page,binding.comment);
    SEL selector=NSSelectorFromString(@"setTag:");
    if(index==NSNotFound || !CSCloseFriendMethodMatches(class_getInstanceMethod([view class],selector),"v@:q")) return NO;
    ((void(*)(id,SEL,NSInteger))objc_msgSend)(view,selector,(NSInteger)index); return YES;
}
static void DetailInstallRendering(void) {
    __block IMP rows=NULL;
    IMP replacement=imp_implementationWithBlock(^NSInteger(id page,id table,NSInteger section){
        CSCFDetailState *state=DetailEnter(page);
        @try {return ((NSInteger(*)(id,SEL,id,NSInteger))rows)(page,NSSelectorFromString(@"tableView:numberOfRowsInSection:"),table,section);}
        @finally {DetailLeave(page,state);}
    });
    if(!CSCloseFriendInstallHook(@"WCCommentDetailViewControllerFB",@"tableView:numberOfRowsInSection:",replacement,&rows,"q@:@q")) imp_removeBlock(replacement);
    __block IMP cell=NULL;
    replacement=imp_implementationWithBlock(^id(id page,id table,id path){
        CSCFDetailState *state=DetailEnter(page); state.renderedCommentView=nil; id result=nil,view=nil;
        @try {DetailEnsureGrid(page,state); result=((id(*)(id,SEL,id,id))cell)(page,NSSelectorFromString(@"tableView:cellForRowAtIndexPath:"),table,path); view=state.renderedCommentView;}
        @finally {DetailLeave(page,state); state.renderedCommentView=nil;}
        if(view) DetailBindTag(page,view);
        return result;
    });
    if(!CSCloseFriendInstallHook(@"WCCommentDetailViewControllerFB",@"tableView:cellForRowAtIndexPath:",replacement,&cell,"@@:@@")) imp_removeBlock(replacement);
    __block IMP height=NULL;
    replacement=imp_implementationWithBlock(^double(id page,id table,id path){
        CSCFDetailState *state=DetailEnter(page);
        @try {DetailEnsureGrid(page,state); return ((double(*)(id,SEL,id,id))height)(page,NSSelectorFromString(@"tableView:heightForRowAtIndexPath:"),table,path);}
        @finally {DetailLeave(page,state);}
    });
    if(!CSCloseFriendInstallHook(@"WCCommentDetailViewControllerFB",@"tableView:heightForRowAtIndexPath:",replacement,&height,"d@:@@")) imp_removeBlock(replacement);
    CSCFSocialHook0(@"WCCommentDetailViewControllerFB",@"updateHeaderGridView",^(id page,void(^original)(void)){
        CSCFDetailState *state=DetailEnter(page); state.gridDirty=NO;
        @try {
            original();
            id grid=DetailIvar(page,"_headerGridView");
            if(grid) {
                CSCFDetailCommentBinding *binding=[CSCFDetailCommentBinding new];
                binding.owner=page; binding.item=state.item; binding.epoch=state.epoch; binding.revision=state.revision;
                objc_setAssociatedObject(grid,&DetailGridKey,binding,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        } @finally {DetailLeave(page,state);}
    });
    __block IMP form=NULL;
    replacement=imp_implementationWithBlock(^id(id page,id comment){
        CSCFDetailState *state=DetailEnter(page); id view=nil;
        @try {
            if(!CSCFPageIsCurrent(page) || CSCFSocialHidden(comment,CSCloseFriendSurfaceInteraction)) return nil;
            view=((id(*)(id,SEL,id))form)(page,NSSelectorFromString(@"FormCommentTipsView:"),comment);
            if(view) {
                CSCFDetailCommentBinding *binding=[CSCFDetailCommentBinding new];
                binding.item=state.item; binding.comment=comment; binding.epoch=state.epoch; binding.revision=state.revision;
                objc_setAssociatedObject(view,&DetailCommentKey,binding,OBJC_ASSOCIATION_RETAIN_NONATOMIC); state.renderedCommentView=view;
            }
            return view;
        } @finally {DetailLeave(page,state);}
    });
    if(!CSCloseFriendInstallHook(@"WCCommentDetailViewControllerFB",@"FormCommentTipsView:",replacement,&form,"@@:@")) imp_removeBlock(replacement);
    CSCFSocialHook1(@"WCCommentDetailViewControllerFB",@"setDataItem:",^(id page,id item,void(^original)(id)){
        original(item);
        // Opening a detail can be nested in a projected timeline callback. Rebind its
        // native page cache to the verified raw model ivars before any business action.
        CSCFSocialSetIvar(page,@"_arrLikeList",DetailIvar(item,"_likeUsers"));
        CSCFSocialSetIvar(page,@"_arrCommentList",DetailIvar(item,"_commentUsers"));
        CSCFDetailState *state=DetailState(page); state.revision=NSUIntegerMax; state.item=item;
        CSCFSocialTrack(page,^(id owner){DetailRefresh(owner);});
    });
    __block IMP appear=NULL;
    replacement=imp_implementationWithBlock(^(id page,BOOL animated){DetailRefresh(page); ((void(*)(id,SEL,BOOL))appear)(page,NSSelectorFromString(@"viewWillAppear:"),animated);});
    if(!CSCloseFriendInstallHook(@"WCCommentDetailViewControllerFB",@"viewWillAppear:",replacement,&appear,"v@:B")) imp_removeBlock(replacement);
}
static void DetailInstallActions(void) {
    // The native grid keeps its own projected contacts and passes a CContact object to
    // the page block. Its index is already correct; only stale-owner/policy checks apply.
    __block IMP head=NULL;
    IMP headReplacement=imp_implementationWithBlock(^(id grid,id value){
        CSCFDetailCommentBinding *binding=objc_getAssociatedObject(grid,&DetailGridKey);
        if(binding) {
            id page=binding.owner;
            if(!page || !CSCFPageIsCurrent(page) || binding.epoch!=CSCloseFriendAccountEpoch() || binding.revision!=CSCloseFriendCurrentSnapshot().revision || binding.item!=CSCloseFriendRead(page,@"dataItem") || ![value isKindOfClass:NSNumber.class]) return;
            NSArray *contacts=DetailArray(grid,"m_arrContacts"); NSUInteger index=[value unsignedIntegerValue];
            if(index>=contacts.count || [CSCloseFriendCurrentSnapshot() hidesUserName:CSCloseFriendUserName(contacts[index]) surface:CSCloseFriendSurfaceInteraction]) return;
        }
        ((void(*)(id,SEL,id))head)(grid,NSSelectorFromString(@"onClickHeadImageView:"),value);
    });
    if(!CSCloseFriendInstallHook(@"WCHeaderGridView",@"onClickHeadImageView:",headReplacement,&head,"v@:@")) imp_removeBlock(headReplacement);
    __block IMP click=NULL;
    IMP replacement=imp_implementationWithBlock(^(id page,id view,NSInteger way){
        if(!DetailBindTag(page,view)) return;
        ((void(*)(id,SEL,id,NSInteger))click)(page,NSSelectorFromString(@"onClickContent:way:"),view,way);
    });
    if(!CSCloseFriendInstallHook(@"WCCommentDetailViewControllerFB",@"onClickContent:way:",replacement,&click,"v@:@q")) imp_removeBlock(replacement);
    for(NSString *name in @[@"onClickSelfComment:comment:index:confirmDelete:",@"onClickFriendsComment:comment:index:replay:"]) {
        __block IMP raw=NULL; SEL selector=NSSelectorFromString(name);
        replacement=imp_implementationWithBlock(^(id page,id view,id comment,__unused NSInteger index,BOOL flag){
            NSUInteger source=DetailSourceIndex(page,comment); if(source==NSNotFound) return;
            ((void(*)(id,SEL,id,id,NSInteger,BOOL))raw)(page,selector,view,comment,(NSInteger)source,flag);
        });
        if(!CSCloseFriendInstallHook(@"WCCommentDetailViewControllerFB",name,replacement,&raw,"v@:@@qB")) imp_removeBlock(replacement);
    }
    for(NSString *name in @[@"onCommentViewClicked:item:comment:",@"onCommentViewEmoticonClicked:item:comment:",@"onCommentViewPicClicked:item:comment:",@"onCommentViewExposured:item:comment:"]) {
        __block IMP raw=NULL; SEL selector=NSSelectorFromString(name);
        replacement=imp_implementationWithBlock(^(id page,id view,id item,id comment){
            if(item!=CSCloseFriendRead(page,@"dataItem") || DetailSourceIndex(page,comment)==NSNotFound || !DetailBindTag(page,view)) return;
            ((void(*)(id,SEL,id,id,id))raw)(page,selector,view,item,comment);
        });
        if(!CSCloseFriendInstallHook(@"WCCommentDetailViewControllerFB",name,replacement,&raw,"v@:@@@")) imp_removeBlock(replacement);
    }
}
static void DetailInstallRouter(void) {
    Class meta=object_getClass(NSClassFromString(@"WCTimelineRouterHelper")); SEL selector=NSSelectorFromString(@"isFlutterDetailEnabled");
    BOOL available=CSCloseFriendMethodMatches(class_getInstanceMethod(meta,selector),"B@:");
    if(available) {
        __block IMP original=NULL;
        IMP replacement=imp_implementationWithBlock(^BOOL(id object){
            CSCloseFriendSnapshot *snapshot=CSCloseFriendCurrentSnapshot();
            // Keep the same native detail surface during temporary reveal so relocking an
            // already-open page can refresh its interaction projection immediately.
            BOOL nativeRequired=snapshot.blocked || (snapshot.enabled && snapshot.protectedUserNames.count && ([snapshot.options[@"hideInteractions"] boolValue] || [snapshot.options[@"hideTimeline"] boolValue]));
            if(DetailReady && nativeRequired) return NO;
            return ((BOOL(*)(id,SEL))original)(object,selector);
        });
        MSHookMessageEx(meta,selector,replacement,&original);
    }
    CSCloseFriendRecordCapability(@"social.detail.native-router",available);
}
void CSCFDetailInstall(void) {
    NSDictionary *contracts=@{@"setDataItem:":@"v@:@",@"dataItem":@"@@:",@"tableView:numberOfRowsInSection:":@"q@:@q",@"tableView:cellForRowAtIndexPath:":@"@@:@@",@"tableView:heightForRowAtIndexPath:":@"d@:@@",@"updateHeaderGridView":@"v@:",@"FormCommentTipsView:":@"@@:@",@"onClickContent:way:":@"v@:@q",@"onClickSelfComment:comment:index:confirmDelete:":@"v@:@@qB",@"onClickFriendsComment:comment:index:replay:":@"v@:@@qB"};
    Class cls=NSClassFromString(@"WCCommentDetailViewControllerFB"); BOOL ready=cls!=Nil;
    for(NSString *name in contracts) ready &= CSCloseFriendMethodMatches(class_getInstanceMethod(cls,NSSelectorFromString(name)),[contracts[name] UTF8String]);
    for(NSString *name in @[@"_arrLikeList",@"_arrCommentList"]) {Ivar ivar=class_getInstanceVariable(cls,name.UTF8String); ready &= ivar && ivar_getTypeEncoding(ivar)[0]=='@';}
    for(NSString *name in @[@"_likeUsers",@"_commentUsers"]) {Ivar ivar=class_getInstanceVariable(NSClassFromString(@"WCDataItem"),name.UTF8String); ready &= ivar && ivar_getTypeEncoding(ivar)[0]=='@';}
    DetailReady=ready; CSCloseFriendRecordCapability(@"social.personal-detail.filtered",ready);
    if(ready) {DetailInstallRendering(); DetailInstallActions();}
    DetailInstallRouter();
}
