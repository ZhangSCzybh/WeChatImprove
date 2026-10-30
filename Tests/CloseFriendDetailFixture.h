#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import "CSCloseFriendSocialProjection.h"
#import "CSCloseFriendSignatures.h"
#import "CSCloseFriendContactProjection.h"
static CSCloseFriendSnapshot *Snapshot;
static NSUInteger Epoch=1,Checks,ProjectionCalls;
static BOOL OuterTimelineProjection;
static char EpochKey;
static NSMapTable *Refreshes;
static NSMutableDictionary *Capabilities;
static CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) {return Snapshot;}
static NSUInteger CSCloseFriendAccountEpoch(void) {return Epoch;}
static BOOL CSCFPageIsCurrent(id page) {NSNumber *e=objc_getAssociatedObject(page,&EpochKey); if(!e) {e=@(Epoch); objc_setAssociatedObject(page,&EpochKey,e,OBJC_ASSOCIATION_RETAIN_NONATOMIC);} return e.unsignedIntegerValue==Epoch;}
static id CSCloseFriendRead(id object,NSString *name) {
    if([object isKindOfClass:NSDictionary.class]) return object[name];
    SEL selector=NSSelectorFromString(name);
    if(CSCloseFriendMethodMatches(class_getInstanceMethod([object class],selector),"@@:")) return ((id(*)(id,SEL))objc_msgSend)(object,selector);
    Ivar ivar=class_getInstanceVariable([object class],name.UTF8String); return ivar && ivar_getTypeEncoding(ivar)[0]=='@' ? object_getIvar(object,ivar) : nil;
}
static NSString *CSCloseFriendUserName(id object) {if([object isKindOfClass:NSString.class]) return object; return CSCloseFriendRead(object,@"m_nsUsrName") ?: CSCloseFriendRead(object,@"username");}
static BOOL CSCFSocialSetIvar(id page,NSString *name,id value) {Ivar ivar=class_getInstanceVariable([page class],name.UTF8String); if(!ivar || ivar_getTypeEncoding(ivar)[0]!='@') return NO; object_setIvar(page,ivar,value); return YES;}
static CSCloseFriendSocialProjection *CSCFSocialProject(NSArray *source,CSCloseFriendSurface surface) {ProjectionCalls++; return [[CSCloseFriendSocialProjection alloc] initWithSource:source snapshot:Snapshot surface:surface read:^id(id item,NSString *name){return CSCloseFriendRead(item,name);}];}
static BOOL CSCFSocialHidden(id value,CSCloseFriendSurface surface) {return CSCloseFriendSocialObjectHidden(value,Snapshot,surface,^id(id item,NSString *name){return CSCloseFriendRead(item,name);});}
static BOOL CSCFCallVoid(id owner,NSString *name) {SEL sel=NSSelectorFromString(name); if(!CSCloseFriendMethodMatches(class_getInstanceMethod([owner class],sel),"v@:")) return NO; ((void(*)(id,SEL))objc_msgSend)(owner,sel); return YES;}
static void CSCFSocialClearCaches(id owner,NSArray *names) {for(NSString *name in names) [CSCloseFriendRead(owner,name) removeAllObjects];}
static void CSCFSocialTrack(id page,void(^refresh)(id)) {CSCFPageIsCurrent(page); if(!Refreshes) Refreshes=[NSMapTable weakToStrongObjectsMapTable]; [Refreshes setObject:[refresh copy] forKey:page];}
static void CSCloseFriendRecordCapability(NSString *name,BOOL ready) {if(!Capabilities) Capabilities=[NSMutableDictionary dictionary]; Capabilities[name]=@(ready);}
static void MSHookMessageEx(Class cls,SEL selector,IMP replacement,IMP *original) {Method method=class_getInstanceMethod(cls,selector); *original=method_getImplementation(method); class_replaceMethod(cls,selector,replacement,method_getTypeEncoding(method));}
static BOOL CSCloseFriendInstallHook(NSString *cls,NSString *name,IMP replacement,IMP *original,const char *type) {Class c=NSClassFromString(cls); SEL sel=NSSelectorFromString(name); if(!CSCloseFriendMethodMatches(class_getInstanceMethod(c,sel),type)) return NO; MSHookMessageEx(c,sel,replacement,original); return YES;}
static void CSCFSocialHook0(NSString *cls,NSString *name,void(^body)(id,void(^)(void))) {__block IMP raw=NULL; SEL sel=NSSelectorFromString(name); IMP replacement=imp_implementationWithBlock(^(id object){body(object,^{((void(*)(id,SEL))raw)(object,sel);});}); if(!CSCloseFriendInstallHook(cls,name,replacement,&raw,"v@:")) imp_removeBlock(replacement);}
static void CSCFSocialHook1(NSString *cls,NSString *name,void(^body)(id,id,void(^)(id))) {__block IMP raw=NULL; SEL sel=NSSelectorFromString(name); IMP replacement=imp_implementationWithBlock(^(id object,id value){body(object,value,^(id v){((void(*)(id,SEL,id))raw)(object,sel,v);});}); if(!CSCloseFriendInstallHook(cls,name,replacement,&raw,"v@:@")) imp_removeBlock(replacement);}
@interface NSIndexPath (DetailFixture)
@property(nonatomic,readonly) NSInteger row;
+ (instancetype)indexPathForRow:(NSInteger)row;
@end
@implementation NSIndexPath (DetailFixture)
+ (instancetype)indexPathForRow:(NSInteger)row {NSUInteger indexes[]={0,(NSUInteger)row}; return [self indexPathWithIndexes:indexes length:2];}
- (NSInteger)row {return (NSInteger)[self indexAtPosition:1];}
@end
@interface WCDataItem : NSObject
@property(nonatomic,strong) NSMutableArray *likeUsers,*commentUsers;
@property(nonatomic,copy) NSString *username;
@end
@implementation WCDataItem
- (NSMutableArray *)likeUsers {return OuterTimelineProjection ? [CSCFSocialProject(_likeUsers,CSCloseFriendSurfaceInteraction).visible mutableCopy] : _likeUsers;}
- (NSMutableArray *)commentUsers {return OuterTimelineProjection ? [CSCFSocialProject(_commentUsers,CSCloseFriendSurfaceInteraction).visible mutableCopy] : _commentUsers;}
@end
@interface DetailCommentView : NSObject
@property(nonatomic,strong) id comment;
@property(nonatomic) NSInteger tag;
@end
@implementation DetailCommentView @end
@interface WCHeaderGridView : NSObject {
@public NSArray *m_arrContacts;
}
@property(nonatomic,strong) id clicked;
- (void)onClickHeadImageView:(NSNumber *)index;
@end
@implementation WCHeaderGridView
- (void)onClickHeadImageView:(NSNumber *)index {if(index.unsignedIntegerValue<m_arrContacts.count) self.clicked=m_arrContacts[index.unsignedIntegerValue];}
@end
@interface WCCommentDetailViewControllerFB : NSObject {
@public NSMutableArray *_arrLikeList,*_arrCommentList;
@public NSMutableDictionary *m_dicUserCommentsUICache;
@public WCHeaderGridView *_headerGridView;
}
@property(nonatomic,strong) WCDataItem *dataItem;
@property(nonatomic,strong) NSArray *renderedLikes;
@property(nonatomic,strong) id actedComment;
@property(nonatomic) NSInteger actedIndex;
@property(nonatomic) NSUInteger actions,reloads;
@property(nonatomic) BOOL readTail,throwDuringCell;
@property(nonatomic,strong) NSMutableArray *replacementDuringCount;
- (NSInteger)tableView:(id)table numberOfRowsInSection:(NSInteger)section;
- (id)tableView:(id)table cellForRowAtIndexPath:(NSIndexPath *)path;
- (double)tableView:(id)table heightForRowAtIndexPath:(NSIndexPath *)path;
- (id)FormCommentTipsView:(id)comment;
- (void)updateHeaderGridView;
- (void)reloadTableView;
- (void)viewWillAppear:(BOOL)animated;
- (void)onClickContent:(id)view way:(NSInteger)way;
- (void)onClickSelfComment:(id)view comment:(id)comment index:(NSInteger)index confirmDelete:(BOOL)confirm;
- (void)onClickFriendsComment:(id)view comment:(id)comment index:(NSInteger)index replay:(BOOL)reply;
- (void)onCommentViewClicked:(id)view item:(id)item comment:(id)comment;
@end
@implementation WCCommentDetailViewControllerFB
- (instancetype)init {if((self=[super init])) m_dicUserCommentsUICache=[NSMutableDictionary dictionary]; return self;}
- (void)setDataItem:(WCDataItem *)item {_dataItem=item; _arrLikeList=item.likeUsers; _arrCommentList=item.commentUsers;}
- (NSInteger)tableView:(__unused id)table numberOfRowsInSection:(__unused NSInteger)section {if(self.replacementDuringCount) {_arrCommentList=self.replacementDuringCount; self.replacementDuringCount=nil;} return (_arrLikeList.count>0)+_arrCommentList.count+self.readTail;}
- (id)tableView:(__unused id)table cellForRowAtIndexPath:(NSIndexPath *)path {
    if(self.throwDuringCell) @throw [NSException exceptionWithName:@"fixture" reason:nil userInfo:nil];
    NSInteger row=path.row-(_arrLikeList.count>0);
    if(row<0) return self.renderedLikes;
    if((NSUInteger)row>=_arrCommentList.count) return @"native-read-count";
    DetailCommentView *view=[self FormCommentTipsView:_arrCommentList[(NSUInteger)row]]; view.tag=row; return view;
}
- (double)tableView:(__unused id)table heightForRowAtIndexPath:(NSIndexPath *)path {
    NSInteger row=path.row-(_arrLikeList.count>0);
    if(row<0) return self.renderedLikes.count*20;
    if((NSUInteger)row>=_arrCommentList.count) return 12;
    return [_arrCommentList[(NSUInteger)row][@"height"] doubleValue];
}
- (id)FormCommentTipsView:(id)comment {NSString *key=comment[@"id"]; DetailCommentView *v=m_dicUserCommentsUICache[key]; if(!v) {v=[DetailCommentView new]; v.comment=comment; m_dicUserCommentsUICache[key]=v;} return v;}
- (void)updateHeaderGridView {self.renderedLikes=[_arrLikeList copy]; _headerGridView=[WCHeaderGridView new]; _headerGridView->m_arrContacts=[_arrLikeList copy];}
- (void)reloadTableView {self.reloads++;}
- (void)viewWillAppear:(__unused BOOL)animated {}
- (void)onClickContent:(DetailCommentView *)view way:(__unused NSInteger)way {self.actedIndex=view.tag; self.actedComment=_arrCommentList[(NSUInteger)view.tag]; self.actions++;}
- (void)onClickSelfComment:(__unused id)view comment:(__unused id)comment index:(NSInteger)index confirmDelete:(__unused BOOL)confirm {self.actedIndex=index; self.actedComment=_arrCommentList[(NSUInteger)index]; self.actions++;}
- (void)onClickFriendsComment:(__unused id)view comment:(__unused id)comment index:(NSInteger)index replay:(__unused BOOL)reply {self.actedIndex=index; self.actedComment=_arrCommentList[(NSUInteger)index]; self.actions++;}
- (void)onCommentViewClicked:(id)view item:(__unused id)item comment:(__unused id)comment {[self onClickContent:view way:0];}
@end
@interface WCTimelineRouterHelper : NSObject
+ (BOOL)isFlutterDetailEnabled;
@end
@implementation WCTimelineRouterHelper
+ (BOOL)isFlutterDetailEnabled {return YES;}
@end
#include "DetailAdapterBodies.h"
static void Check(BOOL ok,NSString *message) {Checks++; if(!ok) {fprintf(stderr,"FAIL: %s\n",message.UTF8String); exit(1);}}
static void Policy(BOOL enabled,BOOL revealed,NSUInteger revision) {Snapshot=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"fixture" profile:@{@"enabled":@(enabled),@"friends":@[@"secret"],@"groups":@[],@"options":CSCloseFriendDefaultOptions()} revealed:revealed revision:revision blocked:NO];}
static NSDictionary *DetailComment(NSString *name,NSString *identity,NSUInteger height) {return @{@"username":name,@"id":identity,@"height":@(height)};}
static void Refresh(WCCommentDetailViewControllerFB *page) {void(^block)(id)=[Refreshes objectForKey:page]; if(block) block(page);}
@interface DetailCountingArray : NSMutableArray
@property(nonatomic,strong) NSMutableArray *storage;
@property(nonatomic) NSUInteger reads;
@end
@implementation DetailCountingArray
- (instancetype)init {if((self=[super init])) _storage=[NSMutableArray array]; return self;}
- (NSUInteger)count {return self.storage.count;}
- (id)objectAtIndex:(NSUInteger)index {self.reads++; return self.storage[index];}
- (void)insertObject:(id)object atIndex:(NSUInteger)index {[self.storage insertObject:object atIndex:index];}
- (void)removeObjectAtIndex:(NSUInteger)index {[self.storage removeObjectAtIndex:index];}
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)object {self.storage[index]=object;}
@end
int main(void) {@autoreleasepool {
    Policy(YES,NO,1); CSCFDetailInstall(); Check([Capabilities[@"social.personal-detail.filtered"] boolValue],@"complete native ABI gate");
    Check(![WCTimelineRouterHelper isFlutterDetailEnabled],@"concealed interactions select native details");
    NSDictionary *hidden=DetailComment(@"secret",@"hidden",40),*ordinary=DetailComment(@"friend",@"normal",55),*reply=DetailComment(@"friend",@"reference",66);
    NSMutableDictionary *hiddenReference=[reply mutableCopy]; hiddenReference[@"refUserName"]=@"secret";
    WCDataItem *item=[WCDataItem new]; item.username=@"self"; item.likeUsers=[@[@"secret",@"friend"] mutableCopy]; item.commentUsers=[@[hidden,ordinary,hiddenReference] mutableCopy];
    WCCommentDetailViewControllerFB *page=[WCCommentDetailViewControllerFB new]; OuterTimelineProjection=YES; page.dataItem=item; OuterTimelineProjection=NO;
    NSArray *likes=item.likeUsers,*comments=item.commentUsers;
    Check([page tableView:nil numberOfRowsInSection:0]==2,@"own post keeps ordinary like and comment");
    Check(page->_arrLikeList==likes && page->_arrCommentList==comments,@"count restores source array references");
    Check([page tableView:nil heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0]]==20,@"like grid height uses filtered avatars");
    Check([page.renderedLikes isEqual:@[@"friend"]],@"native like avatar grid receives ordinary users only");
    [page->_headerGridView onClickHeadImageView:@0]; Check([page->_headerGridView.clicked isEqual:@"friend"],@"projected avatar opens its own native contact");
    Check([page tableView:nil heightForRowAtIndexPath:[NSIndexPath indexPathForRow:1]]==55,@"height aligns with visible comment");
    DetailCommentView *view=[page tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1]];
    Check(view.comment==ordinary,@"cell aligns with visible comment"); Check(view.tag==1,@"native comment tag mapped to original index");
    Check(item.commentUsers==comments && item.commentUsers.count==3 && item.likeUsers==likes && item.likeUsers.count==2,@"model arrays untouched");
    [page onClickContent:view way:0]; Check(page.actedComment==ordinary && page.actedIndex==1,@"click uses original object/index");
    [page onClickSelfComment:view comment:ordinary index:0 confirmDelete:YES]; Check(page.actedComment==ordinary && page.actedIndex==1,@"self action maps by object instead of projected index");
    [page onClickFriendsComment:view comment:ordinary index:0 replay:YES]; Check(page.actedComment==ordinary && page.actedIndex==1,@"friend reply maps by object");
    NSUInteger actions=page.actions; [page onClickFriendsComment:nil comment:hidden index:0 replay:YES]; Check(page.actions==actions,@"hidden callback rejected");
    page.readTail=YES; Check([page tableView:nil numberOfRowsInSection:0]==3,@"native trailing read counter preserved"); Check([[page tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2]] isEqual:@"native-read-count"],@"trailing row still native"); page.readTail=NO;
    Policy(YES,YES,2); Refresh(page); Check([page tableView:nil numberOfRowsInSection:0]==4,@"reveal restores full interactions"); Check(page.renderedLikes.count==2,@"reveal rebuilds avatar grid"); Check(![WCTimelineRouterHelper isFlutterDetailEnabled],@"temporary reveal keeps refreshable native details for relock");
    actions=page.actions; [page onClickContent:view way:0]; Check(page.actions==actions,@"old-policy view cannot trigger a stale action");
    DetailCommentView *secretView=[page tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1]];
    WCHeaderGridView *staleGrid=page->_headerGridView;
    Policy(YES,NO,3); Refresh(page); [staleGrid onClickHeadImageView:@0]; Check(staleGrid.clicked==nil,@"relock suppresses old like-grid callback"); actions=page.actions; [page onClickContent:secretView way:0]; Check(page.actions==actions,@"relock rejects formerly visible secret view");
    Check([page tableView:nil numberOfRowsInSection:0]==2 && page.reloads>=2,@"policy refresh updates count and requests native reload");
    view=[page tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1]];
    [item.commentUsers exchangeObjectAtIndex:0 withObjectAtIndex:1]; [page onClickContent:view way:0]; Check(page.actedComment==ordinary && page.actedIndex==0,@"live reorder keeps object identity");
    [item.commentUsers removeObjectIdenticalTo:ordinary]; actions=page.actions; [page onClickContent:view way:0]; Check(page.actions==actions,@"removed comment cannot select replacement");
    item.likeUsers=[@[@"secret"] mutableCopy]; item.commentUsers=[@[hidden,hiddenReference] mutableCopy]; page.dataItem=item;
    Check([page tableView:nil numberOfRowsInSection:0]==0,@"all hidden yields zero interaction rows without placeholders"); [page updateHeaderGridView]; Check(page.renderedLikes.count==0,@"all hidden clears cached avatars");
    page.throwDuringCell=YES; @try {[page tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0]];} @catch(__unused NSException *exception) {}
    Check(page->_arrLikeList==item.likeUsers && page->_arrCommentList==item.commentUsers,@"exception restores native arrays"); page.throwDuringCell=NO;
    Policy(NO,NO,4); Refresh(page); Check([page tableView:nil numberOfRowsInSection:0]==3,@"disabled feature retains native contents"); Check([WCTimelineRouterHelper isFlutterDetailEnabled],@"disabled feature retains Flutter configuration");
    NSMutableDictionary *options=[CSCloseFriendDefaultOptions() mutableCopy]; options[@"hideInteractions"]=@NO;
    Snapshot=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"fixture" profile:@{@"enabled":@YES,@"friends":@[@"secret"],@"groups":@[],@"options":options} revealed:NO revision:5 blocked:NO]; Refresh(page);
    Check([page tableView:nil numberOfRowsInSection:0]==3,@"timeline-only protection preserves all detail interactions");
    view=[page tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1]]; actions=page.actions; [page onClickContent:view way:0]; Check(page.actions==actions+1 && page.actedComment==hidden,@"disabled interaction hiding preserves native click");
    Check(![WCTimelineRouterHelper isFlutterDetailEnabled],@"timeline-only protection still selects refreshable native detail");
    DetailCountingArray *liveComments=[DetailCountingArray new]; [liveComments addObjectsFromArray:@[hidden,ordinary]];
    item.commentUsers=liveComments; page.dataItem=item; Refresh(page); liveComments.reads=0; ProjectionCalls=0;
    for(NSUInteger i=0;i<100;i++) Check([page tableView:nil numberOfRowsInSection:0]==3,@"inactive conceal uses native counts");
    Check(!liveComments.reads && !ProjectionCalls,@"100 native count callbacks do not scan or project interaction arrays");
    liveComments[0]=ordinary; Check([page tableView:nil heightForRowAtIndexPath:[NSIndexPath indexPathForRow:1]]==55,@"native fast path observes in-place source replacement");
    NSMutableArray *nativeReplacement=[@[ordinary] mutableCopy]; page.replacementDuringCount=nativeReplacement;
    Check([page tableView:nil numberOfRowsInSection:0]==2 && page->_arrCommentList==nativeReplacement,@"native array replacement survives an unsubstituted callback");
    page.dataItem=item; page.throwDuringCell=YES;
    @try {[page tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1]];} @catch(__unused NSException *exception) {}
    page.throwDuringCell=NO; Check([page tableView:nil numberOfRowsInSection:0]==3,@"native exception leaves later callbacks usable");
    Policy(YES,NO,6); Refresh(page); Check([page tableView:nil numberOfRowsInSection:0]==2,@"relock projects latest live source");
    liveComments[0]=hidden; Check([page tableView:nil numberOfRowsInSection:0]==1,@"concealed path detects same-pointer same-count source replacement");
    for(NSNumber *hide in @[@YES,@NO]) {
        Snapshot=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"fixture" profile:@{@"enabled":@YES,@"friends":@[],@"groups":@[],@"options":@{@"hideTimeline":@NO,@"hideInteractions":@NO,@"hidePrivacyIcons":hide}} revealed:YES revision:6 blocked:NO];
        Check([WCTimelineRouterHelper isFlutterDetailEnabled]==!hide.boolValue,@"icon option alone selects native detail even with empty protected list and during reveal");
    }
    Epoch++; Check([page tableView:nil numberOfRowsInSection:0]==0,@"old-account detail cannot render another account's interactions");
    fprintf(stdout,"Close-friend detail: %lu checks passed (native ivar rendering, likes/comments, source preservation, action identity, reveal/relock, routes).\n",(unsigned long)Checks);
} return 0;}
