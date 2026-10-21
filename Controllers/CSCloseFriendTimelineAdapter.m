#import "CSCloseFriendSocialAdapter.h"
#import <objc/message.h>
#import <substrate.h>
@interface CSCFTimelineState : NSObject
@property(nonatomic,strong) CSCloseFriendSocialProjection *posts;
@property(nonatomic,weak) id facade;
@property(nonatomic) NSUInteger revision, epoch;
@end
@implementation CSCFTimelineState @end
@interface CSCFTimelineScope : NSObject
@property(nonatomic,strong) CSCloseFriendSnapshot *snapshot;
@property(nonatomic,strong) CSCFTimelineState *state;
@property(nonatomic,strong) id item;
@property(nonatomic) BOOL unreadPrevious;
@end
@implementation CSCFTimelineScope @end
static CSCFTimelineScope *Scope; // main-thread only, synchronous UI calls
static char TimelineKey, CommentRevisionKey;
static id (*RawPosts)(id,SEL);
static id (*RawLikes)(id,SEL);
static id (*RawComments)(id,SEL);
static void ClearLikes(id facade,NSArray *posts) {
    SEL selector=NSSelectorFromString(@"removeCachesOfLikeUserWithDataItemId:");
    if(!CSCloseFriendMethodMatches(class_getInstanceMethod([facade class],selector),"v@:@")) return;
    for(id item in posts) { id itemID=CSCloseFriendRead(item,@"itemID"); if(itemID) ((void(*)(id,SEL,id))objc_msgSend)(facade,selector,itemID); }
}
static CSCFTimelineState *State(id owner) {
    CSCFTimelineState *state=objc_getAssociatedObject(owner,&TimelineKey);
    if(!state) { state=[CSCFTimelineState new]; state.epoch=CSCloseFriendAccountEpoch(); objc_setAssociatedObject(owner,&TimelineKey,state,OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
    return state;
}
id CSCFTimelineFacade(id owner) { CSCFTimelineState *state=objc_getAssociatedObject(owner,&TimelineKey); return state.epoch==CSCloseFriendAccountEpoch() ? state.facade : nil; }
static CSCFTimelineScope *Enter(id owner,id item) {
    if(!NSThread.isMainThread) return nil;
    CSCFTimelineScope *previous=Scope;
    CSCFTimelineScope *next=[CSCFTimelineScope new]; next.snapshot=previous.snapshot ?: CSCloseFriendCurrentSnapshot();
    next.item=item ?: previous.item; next.state=previous.state;
    if(CSCFIsClass(owner,@"WCTimeLineViewController")) {
        next.state=State(owner);
        CSCFSocialTrack(owner,^(id page){
            CSCFTimelineState *state=State(page); ClearLikes(state.facade,state.posts.source); state.posts=nil;
            CSCFSocialClearCaches(page,@[@"cellHeightCache",@"cellShowItemCache"]);
            if(!CSCFPageIsCurrent(page)) CSCFSocialGate(page,CSCloseFriendSurfaceTimeline,YES);
            else {CSCFCallVoid(page,@"onMessageUnReadCountChanged"); CSCFReloadTables(page);}
        });
    }
    next.unreadPrevious=CSCFUnreadBegin(); Scope=next; return previous;
}
static void Leave(CSCFTimelineScope *previous) {
    if(!NSThread.isMainThread) return;
    if(!previous) ClearLikes(Scope.state.facade,Scope.state.posts.source);
    CSCFUnreadEnd(Scope.unreadPrevious); Scope=previous;
}
static NSArray *ProjectedPosts(id facade) {
    if(!NSThread.isMainThread || !Scope.state || !RawPosts) return nil;
    CSCFTimelineState *state=Scope.state;
    if(state.epoch!=CSCloseFriendAccountEpoch()) return @[];
    if(!state.posts || state.revision!=Scope.snapshot.revision) {
        CSCFTimelineScope *saved=Scope; Scope=nil; id source=RawPosts(facade,NSSelectorFromString(@"getTimelineDataItem")); Scope=saved;
        if(![source isKindOfClass:NSArray.class]) return @[];
        state.facade=facade; ClearLikes(facade,source);
        state.posts=[[CSCloseFriendSocialProjection alloc] initWithSource:source snapshot:Scope.snapshot surface:CSCloseFriendSurfaceTimeline read:^id(id object,NSString *key){return CSCloseFriendRead(object,key);}];
        state.revision=Scope.snapshot.revision;
    } return state.posts.visible;
}
static BOOL ModelScoped(id item) { return NSThread.isMainThread && Scope && (item==Scope.item || [Scope.state.posts.visible containsObject:item]); }
static NSArray *ProjectedUsers(id item,BOOL likes) {
    NSArray *source=likes ? RawLikes(item,NSSelectorFromString(@"likeUsers")) : RawComments(item,NSSelectorFromString(@"commentUsers"));
    return [[CSCloseFriendSocialProjection alloc] initWithSource:source snapshot:Scope.snapshot surface:CSCloseFriendSurfaceInteraction read:^id(id object,NSString *key){return CSCloseFriendRead(object,key);}].visible;
}
static void InstallModel(void) {
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
    // at outer scope exit, so filtered styles cannot contaminate an unscoped service consumer.
    __block IMP styles=NULL;
    replacement=imp_implementationWithBlock(^id(id facade,id item,double width,BOOL spring){if(ModelScoped(item)) ClearLikes(facade,@[item]); id result=((id(*)(id,SEL,id,double,BOOL))styles)(facade,NSSelectorFromString(@"layoutStylesOfLikeUserWithDataItem:width:isSpringStyle:"),item,width,spring); if(ModelScoped(item)) ClearLikes(facade,@[item]); return result;});
    if(!CSCloseFriendInstallHook(@"WCFacade",@"layoutStylesOfLikeUserWithDataItem:width:isSpringStyle:",replacement,&styles,"@@:@dB")) imp_removeBlock(replacement);
    __block IMP height=NULL;
    replacement=imp_implementationWithBlock(^double(id facade,double width,id item,BOOL spring){if(ModelScoped(item)) ClearLikes(facade,@[item]); double result=((double(*)(id,SEL,double,id,BOOL))height)(facade,NSSelectorFromString(@"likeUserHeightForWidth:withDataItem:isSpringStyle:"),width,item,spring); if(ModelScoped(item)) ClearLikes(facade,@[item]); return result;});
    if(!CSCloseFriendInstallHook(@"WCFacade",@"likeUserHeightForWidth:withDataItem:isSpringStyle:",replacement,&height,"d@:d@B")) imp_removeBlock(replacement);
}
// Only known method signatures are wrapped. Native section/body/footer/ad semantics stay native.
static void TimelineMethod(NSString *name,const char *types) {
    __block IMP raw=NULL; SEL sel=NSSelectorFromString(name); IMP replacement=NULL;
#define BEGIN CSCFTimelineScope *old=Enter(object,nil)
#define END @finally {Leave(old);}
    if(!strcmp(types,"q@:@")) replacement=imp_implementationWithBlock(^NSInteger(id object,id a){State(object).posts=nil; BEGIN; @try {return ((NSInteger(*)(id,SEL,id))raw)(object,sel,a);} END });
    else if(!strcmp(types,"q@:@q")) replacement=imp_implementationWithBlock(^NSInteger(id object,id a,NSInteger b){BEGIN; @try {return ((NSInteger(*)(id,SEL,id,NSInteger))raw)(object,sel,a,b);} END });
    else if(!strcmp(types,"@@:@@")) replacement=imp_implementationWithBlock(^id(id object,id a,id b){BEGIN; @try {return ((id(*)(id,SEL,id,id))raw)(object,sel,a,b);} END });
    else if(!strcmp(types,"d@:@@")) replacement=imp_implementationWithBlock(^double(id object,id a,id b){BEGIN; @try {return ((double(*)(id,SEL,id,id))raw)(object,sel,a,b);} END });
    else if(!strcmp(types,"v@:@@")) replacement=imp_implementationWithBlock(^(id object,id a,id b){if(!CSCFPageIsCurrent(object)) return; BEGIN; @try {((void(*)(id,SEL,id,id))raw)(object,sel,a,b);} END });
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
static void InstallTimelineRoutes(void) {
    // WCCommentDetailViewController is Finder's comment UI. Moments uses the FB
    // controller and its WCDataItem, or the Flutter detail/profile controllers.
    for(NSString *cls in @[@"WCListViewController",@"WCCommentDetailViewControllerFB",@"WCTimelineFlutterAlbumV2ViewController",@"WCTimelineFlutterDetailViewController",@"WCTimelineFlutterProfileViewController",@"WCTimelineFlutterViewController"]) CSCFSocialProtectRoute(cls,CSCloseFriendSurfaceTimeline);
}
void CSCFTimelineInstall(void) {
    InstallTimelineRoutes();
    BOOL ready=YES;
    NSDictionary *contracts=@{@"WCFacade":@{@"getTimelineDataItem":@"@@:",@"countOfTimelineDataItem":@"q@:",@"getTimelineDataItemOfIndex:":@"@@:q",@"removeCachesOfLikeUserWithDataItemId:":@"v@:@"},@"WCDataItem":@{@"likeUsers":@"@@:",@"commentUsers":@"@@:",@"likeCount":@"i@:",@"commentCount":@"i@:"},@"WCTimeLineViewController":@{@"numberOfSectionsInTableView:":@"q@:@",@"tableView:numberOfRowsInSection:":@"q@:@q",@"tableView:cellForRowAtIndexPath:":@"@@:@@",@"tableView:heightForRowAtIndexPath:":@"d@:@@",@"tableView:didSelectRowAtIndexPath:":@"v@:@@"}};
    for(NSString *cls in contracts) for(NSString *selector in contracts[cls]) ready &= CSCloseFriendMethodMatches(class_getInstanceMethod(NSClassFromString(cls),NSSelectorFromString(selector)),[contracts[cls][selector] UTF8String]);
    NSDictionary *commentContracts=@{@"getCommentViewCountForDataItem:":@"Q@:@",@"getCommentIndexForDataItem:RowIndex:":@"q@:@q",@"getCellHeightForDataItem:RowIndex:pageContext:":@"d@:@q@",@"getNickNameForDataItem:":@"@@:@"};
    for(NSString *selector in commentContracts) ready &= CSCloseFriendMethodMatches(class_getClassMethod(NSClassFromString(@"WCTimeLineCommentCellView"),NSSelectorFromString(selector)),[commentContracts[selector] UTF8String]);
    CSCloseFriendRecordCapability(@"social.timeline.coupled",ready);
    if(!ready) {CSCFSocialProtectRoute(@"WCTimeLineViewController",CSCloseFriendSurfaceTimeline); return;}
    InstallModel(); InstallComments();
    TimelineMethod(@"numberOfSectionsInTableView:","q@:@");
    TimelineMethod(@"tableView:numberOfRowsInSection:","q@:@q");
    TimelineMethod(@"tableView:cellForRowAtIndexPath:","@@:@@");
    TimelineMethod(@"tableView:heightForRowAtIndexPath:","d@:@@");
    TimelineMethod(@"tableView:didSelectRowAtIndexPath:","v@:@@");
    TimelineMethod(@"getNextDataItem:","@@:q"); TimelineMethod(@"visibleDataItemList","@@:");
    TimelineMethod(@"indexPathOfDataItem:","@@:@"); TimelineMethod(@"sectionIndexForDataItemWithTid:","Q@:@");
    for(NSString *name in @[@"scrollViewDidScroll:",@"scrollTableViewToShowDataItem:",@"refreshWholeViewWithFixedDataItem:"]) CSCFSocialHook1(@"WCTimeLineViewController",name,^(id owner,id arg,void(^orig)(id)){
        if(!CSCFPageIsCurrent(owner)) return; CSCFTimelineScope *old=Enter(owner,nil); @try {orig(arg);} @finally {Leave(old);}
    });
    CSCloseFriendRecordCapability(@"social.personal-detail.filtered",NO); CSCloseFriendRecordCapability(@"social.flutter.filtered",NO);
}
