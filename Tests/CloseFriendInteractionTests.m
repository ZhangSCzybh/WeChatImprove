#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import "CSCloseFriendSocialProjection.h"
#import "CSCloseFriendSignatures.h"

static CSCloseFriendSnapshot *Snapshot;
static NSUInteger Epoch=1,Revision,Checks,AuthenticationRequests,TableRefreshes;
static NSUInteger QueryCount,QueryProbeAt;
static NSString *CaseName;
static char EpochKey;
static NSMapTable *Refreshes;
static NSMutableDictionary *Capabilities;
static NSMutableSet *InstalledHooks;
static id AuthenticationOwner;
static void (^QueryProbe)(void),(^WriteProbe)(void);
NSString *const CSCloseFriendPolicyDidChangeNotification=@"CSCloseFriendPolicyDidChange";
#define Check(x) do {Checks++;if(!(x)){fprintf(stderr,"FAIL %s:%d [%s]: %s\n",__FILE__,__LINE__,CaseName.UTF8String,#x);return 1;}}while(0)

@interface UIView : NSObject
@property(nonatomic) BOOL hidden,accessibilityElementsHidden,userInteractionEnabled,isAccessibilityElement;
@end
@implementation UIView @end
@interface UIViewController : NSObject
@property(nonatomic,strong) UIView *view;
@property(nonatomic,getter=isViewLoaded) BOOL viewLoaded;
@end
@implementation UIViewController @end
@interface UITableViewCell : UIView @end
@implementation UITableViewCell @end
@interface NSIndexPath (InteractionFixture)
@property(nonatomic,readonly) NSInteger row,section;
+ (instancetype)indexPathForRow:(NSInteger)row inSection:(NSInteger)section;
@end
@implementation NSIndexPath (InteractionFixture)
+ (instancetype)indexPathForRow:(NSInteger)row inSection:(NSInteger)section {NSUInteger indexes[]={(NSUInteger)section,(NSUInteger)row};return [self indexPathWithIndexes:indexes length:2];}
- (NSInteger)row {return (NSInteger)[self indexAtPosition:1];}
- (NSInteger)section {return (NSInteger)[self indexAtPosition:0];}
@end

static CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) {return Snapshot;}
static BOOL CSCloseFriendSurfaceConcealed(CSCloseFriendSnapshot *snapshot,CSCloseFriendSurface surface) {return [snapshot concealsSurface:surface];}
static NSUInteger CSCloseFriendAccountEpoch(void) {return Epoch;}
static BOOL CSCFPageIsCurrent(id owner) {
    if(!owner)return NO;
    NSNumber *old=objc_getAssociatedObject(owner,&EpochKey);
    if(!old) {old=@(Epoch);objc_setAssociatedObject(owner,&EpochKey,old,OBJC_ASSOCIATION_RETAIN_NONATOMIC);}
    return old.unsignedIntegerValue==Epoch;
}
static id CSCloseFriendRead(id object,NSString *key) {
    if([object isKindOfClass:NSDictionary.class])return object[key];
    SEL selector=NSSelectorFromString(key);
    if(CSCloseFriendMethodMatches(class_getInstanceMethod([object class],selector),"@@:"))return ((id(*)(id,SEL))objc_msgSend)(object,selector);
    Ivar ivar=class_getInstanceVariable([object class],key.UTF8String);
    return ivar && ivar_getTypeEncoding(ivar)[0]=='@' ? object_getIvar(object,ivar) : nil;
}
static CSCloseFriendSocialProjection *CSCFSocialProject(NSArray *source,CSCloseFriendSurface surface) {
    return [[CSCloseFriendSocialProjection alloc] initWithSource:source snapshot:Snapshot surface:surface read:^id(id item,NSString *key){return CSCloseFriendRead(item,key);}];
}
static BOOL CSCFSocialHidden(id object,CSCloseFriendSurface surface) {return CSCloseFriendSocialObjectHidden(object,Snapshot,surface,^id(id item,NSString *key){return CSCloseFriendRead(item,key);});}
static void CSCloseFriendRecordCapability(NSString *name,BOOL available) {
    if(!Capabilities)Capabilities=[NSMutableDictionary dictionary];Capabilities[name]=@(available);
}
static BOOL CSCloseFriendInstallHook(NSString *className,NSString *name,IMP replacement,IMP *original,const char *types) {
    Class cls=NSClassFromString(className);SEL selector=NSSelectorFromString(name);Method method=class_getInstanceMethod(cls,selector);
    if(!CSCloseFriendMethodMatches(method,types))return NO;
    *original=method_getImplementation(method);class_replaceMethod(cls,selector,replacement,method_getTypeEncoding(method));
    if(!InstalledHooks)InstalledHooks=[NSMutableSet set];[InstalledHooks addObject:[className stringByAppendingFormat:@".%@",name]];
    return *original!=NULL;
}
static void CSCFSocialHook0(NSString *cls,NSString *name,void(^body)(id,void(^)(void))) {
    __block IMP original=NULL;SEL selector=NSSelectorFromString(name);
    IMP replacement=imp_implementationWithBlock(^(id owner){body(owner,^{((void(*)(id,SEL))original)(owner,selector);});});
    if(!CSCloseFriendInstallHook(cls,name,replacement,&original,"v@:"))imp_removeBlock(replacement);
}
static void CSCFSocialHook1(NSString *cls,NSString *name,void(^body)(id,id,void(^)(id))) {
    __block IMP original=NULL;SEL selector=NSSelectorFromString(name);
    IMP replacement=imp_implementationWithBlock(^(id owner,id argument){body(owner,argument,^(id value){((void(*)(id,SEL,id))original)(owner,selector,value);});});
    if(!CSCloseFriendInstallHook(cls,name,replacement,&original,"v@:@"))imp_removeBlock(replacement);
}
static BOOL CSCFCallVoid(id owner,NSString *name) {
    SEL selector=NSSelectorFromString(name);
    if(!CSCloseFriendMethodMatches(class_getInstanceMethod([owner class],selector),"v@:"))return NO;
    ((void(*)(id,SEL))objc_msgSend)(owner,selector);return YES;
}
static BOOL CSCFSocialRequireAuthentication(id owner,CSCloseFriendSurface surface) {
    if(!CSCFPageIsCurrent(owner))return YES;
    if(!CSCloseFriendSurfaceConcealed(Snapshot,surface))return NO;
    if([owner isKindOfClass:UIViewController.class]) {AuthenticationRequests++;AuthenticationOwner=owner;}
    return YES;
}
static void CSCFSocialTrack(id owner,void(^refresh)(id)) {
    if(!Refreshes)Refreshes=[NSMapTable weakToStrongObjectsMapTable];[Refreshes setObject:[refresh copy] forKey:owner];
}
static void CSCFReloadTables(__unused id owner) {TableRefreshes++;}
static void CSCFSocialClearCaches(id owner,NSArray *keys) {
    for(NSString *key in keys) {id value=CSCloseFriendRead(owner,key);if([value isKindOfClass:NSMutableDictionary.class])[value removeAllObjects];}
}
static void CSCFSocialProtectRoute(__unused NSString *name,__unused CSCloseFriendSurface surface) {abort();}

@interface WCUserComment : NSObject
@property(nonatomic,copy) NSString *username,*refUserName,*dataItemUsrName;
@property(nonatomic) int type,commentFlag;
@property(nonatomic) unsigned int createTime;
@end
@implementation WCUserComment @end
@interface WCSNSMessage : NSObject
@property(nonatomic,copy) NSString *msgID,*objID;
@property(nonatomic,strong) WCUserComment *comment,*refComment;
@property(nonatomic) BOOL hasRead;
@end
@implementation WCSNSMessage @end
@class WCTimeLineViewController,FindFriendEntryViewController;
static WCTimeLineViewController *CurrentTimeline;
static FindFriendEntryViewController *CurrentDiscovery;
@interface WCFacade : NSObject
@property(nonatomic,strong) NSMutableArray<WCSNSMessage *> *source;
@property(nonatomic,strong) NSMutableArray<NSArray *> *markedBatches;
@property(nonatomic,strong) NSMutableArray *markedSingles;
@property(nonatomic) NSUInteger notifications,readStateNotifications;
@property(nonatomic) unsigned int lastReadTime;
@property(nonatomic) BOOL writeFails;
- (NSArray *)getUnReadMessages;
- (NSArray *)getUnReadMessagesLimit:(int)limit;
- (id)getLastUnReadMessage;
- (unsigned int)getUnReadMessageCount;
- (unsigned int)getUnReadMessageCountReleatedToMe;
- (unsigned int)getUnReadMessageCountForMutualFriends;
- (void)markMessageListRead:(id)messages;
- (void)markMessageRead:(id)message;
- (void)markMessageAllReadWithSyncMessage:(id)message;
- (void)onMessageUnReadCountChanged;
@end
static WCFacade *CurrentFacade;
static NSArray *FixtureUnread(WCFacade *facade) {
    NSMutableArray *unread=[NSMutableArray array];for(WCSNSMessage *message in facade.source)if(!message.hasRead)[unread addObject:message];
    [unread sortUsingComparator:^NSComparisonResult(WCSNSMessage *left,WCSNSMessage *right){
        unsigned long long a=left.msgID.longLongValue,b=right.msgID.longLongValue;return a>b ? NSOrderedAscending : a<b ? NSOrderedDescending : NSOrderedSame;
    }];return unread;
}
static BOOL FixtureRelated(WCSNSMessage *message) {
    return message.comment.type==4 || (message.comment.commentFlag&(1<<17)) || [message.refComment.username isEqual:Snapshot.accountID];
}
@interface MMContext : NSObject
+ (instancetype)currentContext;
- (id)getService:(Class)service;
@end
@implementation MMContext
+ (instancetype)currentContext {static MMContext *context;static dispatch_once_t once;dispatch_once(&once,^{context=[self new];});return context;}
- (id)getService:(Class)service {return service==WCFacade.class ? CurrentFacade : nil;}
@end
@interface WCTimeLineViewController : UIViewController
@property(nonatomic,strong) WCFacade *facade;
@property(nonatomic) NSUInteger refreshes;
@property(nonatomic) NSInteger displayedCount;
@property(nonatomic,strong) NSString *displayedUser;
- (NSInteger)messageTipCount;
- (BOOL)hasUnReadMessage;
- (id)messageTipUserName;
- (void)onMessageUnReadCountChanged;
- (void)checkNewMessage;
@end
@implementation WCTimeLineViewController
- (NSInteger)messageTipCount {return [self.facade getUnReadMessageCount];}
- (BOOL)hasUnReadMessage {return [self messageTipCount]>0;}
- (id)messageTipUserName {WCSNSMessage *message=[self.facade getLastUnReadMessage];return message.comment.username;}
- (void)onMessageUnReadCountChanged {self.refreshes++;self.displayedCount=[self messageTipCount];self.displayedUser=[self messageTipUserName];}
- (void)checkNewMessage {[self onMessageUnReadCountChanged];}
@end
static id CSCFTimelineFacade(id page) {return CSCloseFriendRead(page,@"facade");}
@interface FindFriendEntryViewController : UIViewController
@property(nonatomic,strong) WCFacade *facade;
@property(nonatomic,strong) UIView *m_timelineHeadView,*m_timelineRedDotView;
@property(nonatomic) BOOL mutualReminder;
@property(nonatomic) NSUInteger refreshes;
@property(nonatomic) NSInteger displayedCount,tabCount;
- (NSInteger)getSnsMessageCount;
- (NSInteger)numberOfUnreadAtMomentCell;
- (BOOL)badgeAtMomentCell;
- (void)onMessageUnReadCountChanged;
- (void)reloadData;
- (void)updateWCTimeLineView:(id)cell;
- (void)viewWillAppear:(BOOL)animated;
@end
@implementation FindFriendEntryViewController
- (NSInteger)getSnsMessageCount {return self.mutualReminder ? [self.facade getUnReadMessageCount] : [self.facade getUnReadMessageCountReleatedToMe];}
- (NSInteger)numberOfUnreadAtMomentCell {return [self getSnsMessageCount];}
- (BOOL)badgeAtMomentCell {return YES;}
- (void)onMessageUnReadCountChanged {self.refreshes++;self.displayedCount=[self getSnsMessageCount];self.tabCount=3+[self numberOfUnreadAtMomentCell];}
- (void)reloadData {[self onMessageUnReadCountChanged];}
- (void)updateWCTimeLineView:(__unused id)cell {}
- (void)viewWillAppear:(__unused BOOL)animated {}
@end
@implementation WCFacade
- (NSArray *)getUnReadMessages {
    NSArray *result=FixtureUnread(self);QueryCount++;
    if(QueryProbe && QueryCount==(QueryProbeAt?:1)) {void(^probe)(void)=QueryProbe;QueryProbe=nil;probe();}
    return result;
}
- (NSArray *)getUnReadMessagesLimit:(int)limit {NSArray *unread=FixtureUnread(self);return [unread subarrayWithRange:NSMakeRange(0,MIN((NSUInteger)MAX(limit,0),unread.count))];}
- (id)getLastUnReadMessage {
    // The native selector has the same order as getUnReadMessagesLimit:1.
    // A fresh DB materialization shares identity by msgID, not object address.
    WCSNSMessage *message=FixtureUnread(self).firstObject;if(!message)return nil;
    WCSNSMessage *copy=[WCSNSMessage new];copy.msgID=message.msgID;copy.objID=message.objID;
    copy.comment=message.comment;copy.refComment=message.refComment;copy.hasRead=message.hasRead;return copy;
}
- (unsigned int)getUnReadMessageCount {return (unsigned int)FixtureUnread(self).count;}
- (unsigned int)getUnReadMessageCountReleatedToMe {unsigned int count=0;for(WCSNSMessage *message in FixtureUnread(self))if(FixtureRelated(message))count++;return count;}
- (unsigned int)getUnReadMessageCountForMutualFriends {return [self getUnReadMessageCount]-[self getUnReadMessageCountReleatedToMe];}
- (void)markMessageListRead:(id)messages {
    void(^probe)(void)=WriteProbe;WriteProbe=nil;if(probe)probe();
    [self.markedBatches addObject:[messages copy]];
    for(id message in messages) {if(![message isKindOfClass:WCSNSMessage.class])abort();if(!self.writeFails)[message setHasRead:YES];}
    self.lastReadTime=[[(WCSNSMessage *)[messages firstObject] comment] createTime];self.readStateNotifications++;
    [self onMessageUnReadCountChanged];
}
- (void)markMessageRead:(id)message {
    void(^probe)(void)=WriteProbe;WriteProbe=nil;if(probe)probe();
    if(![message isKindOfClass:WCSNSMessage.class])abort();[self.markedSingles addObject:message];[message setHasRead:YES];
}
- (void)markMessageAllReadWithSyncMessage:(id)message {
    if(![message isKindOfClass:WCSNSMessage.class])abort();
    unsigned long long cutoff=[[(WCSNSMessage *)message msgID] longLongValue];
    for(WCSNSMessage *row in self.source)if((unsigned long long)row.msgID.longLongValue<=cutoff)row.hasRead=YES;
    self.lastReadTime=[[(WCSNSMessage *)message comment] createTime];self.readStateNotifications++;[self onMessageUnReadCountChanged];
}
- (void)onMessageUnReadCountChanged {
    self.notifications++;[CurrentTimeline onMessageUnReadCountChanged];[CurrentDiscovery onMessageUnReadCountChanged];
}
@end

@interface WCCommentListViewController : UIViewController
@property(nonatomic,strong) NSMutableArray *_arrCommentList;
@property(nonatomic,strong) NSMutableDictionary *_dicCells,*_dicCellHeights;
@property(nonatomic) BOOL hasMore;
@property(nonatomic) NSUInteger nativeReads,clears,clearMenus,deletes,rowDeletes,selections,accessories,loadMore;
@property(nonatomic) NSInteger lastNativeRow;
- (NSInteger)getWCCommentListCount:(NSInteger)section;
- (NSInteger)tableView:(id)table numberOfRowsInSection:(NSInteger)section;
- (id)tableView:(id)table cellForRowAtIndexPath:(NSIndexPath *)path;
- (double)tableView:(id)table heightForRowAtIndexPath:(NSIndexPath *)path;
- (void)tableView:(id)table didSelectRowAtIndexPath:(NSIndexPath *)path;
- (void)tableView:(id)table accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)path;
- (void)tableView:(id)table commitEditingStyle:(NSInteger)style forRowAtIndexPath:(NSIndexPath *)path;
- (void)markMessageAllRead;
- (void)clearList;
- (void)onDeleteData;
- (void)onClearList:(id)sender;
@end
@implementation WCCommentListViewController
- (NSInteger)getWCCommentListCount:(__unused NSInteger)section {return (NSInteger)self._arrCommentList.count;}
- (NSInteger)tableView:(__unused id)table numberOfRowsInSection:(NSInteger)section {return [self getWCCommentListCount:section]+(self.hasMore?1:0);}
- (id)tableView:(__unused id)table cellForRowAtIndexPath:(NSIndexPath *)path {return (NSUInteger)path.row<self._arrCommentList.count ? self._arrCommentList[(NSUInteger)path.row] : @"load-more";}
- (double)tableView:(__unused id)table heightForRowAtIndexPath:(__unused NSIndexPath *)path {return 44;}
- (void)tableView:(__unused id)table didSelectRowAtIndexPath:(NSIndexPath *)path {
    self.lastNativeRow=path.row;if((NSUInteger)path.row==self._arrCommentList.count && self.hasMore)self.loadMore++;else self.selections++;
}
- (void)tableView:(__unused id)table accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)path {self.accessories++;self.lastNativeRow=path.row;}
- (void)tableView:(__unused id)table commitEditingStyle:(__unused NSInteger)style forRowAtIndexPath:(NSIndexPath *)path {self.rowDeletes++;self.lastNativeRow=path.row;}
- (void)markMessageAllRead {self.nativeReads++;if(self._arrCommentList.count)[CurrentFacade markMessageAllReadWithSyncMessage:self._arrCommentList[0]];}
- (void)clearList {self.clears++;}
- (void)onDeleteData {self.deletes++;}
- (void)onClearList:(__unused id)sender {self.clearMenus++;}
@end
#include "InteractionAdapterProduction.h"

static void Policy(BOOL revealed,BOOL hideInteractions) {
    NSMutableDictionary *options=[CSCloseFriendDefaultOptions() mutableCopy];options[@"hideInteractions"]=@(hideInteractions);
    Snapshot=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"self" profile:@{@"enabled":@YES,@"friends":@[@"secret"],@"groups":@[],@"options":options} revealed:revealed revision:++Revision blocked:NO];
}
static WCSNSMessage *Message(NSString *identifier,NSString *name,BOOL related) {
    WCSNSMessage *message=[WCSNSMessage new];message.msgID=@"2000";message.objID=[@"post-" stringByAppendingString:identifier];
    message.comment=[WCUserComment new];message.comment.username=name;message.comment.type=1;message.comment.commentFlag=related?(1<<17):0;message.comment.createTime=2000;return message;
}
static WCCommentListViewController *BeginCase(NSString *name,NSArray *messages) {
    CaseName=name;Policy(NO,YES);AuthenticationRequests=TableRefreshes=QueryCount=QueryProbeAt=0;AuthenticationOwner=nil;QueryProbe=WriteProbe=nil;
    CurrentFacade=[WCFacade new];CurrentFacade.source=[messages mutableCopy];CurrentFacade.markedBatches=[NSMutableArray array];CurrentFacade.markedSingles=[NSMutableArray array];
    [messages enumerateObjectsUsingBlock:^(WCSNSMessage *message,NSUInteger index,__unused BOOL *stop){message.msgID=[NSString stringWithFormat:@"%lu",(unsigned long)(1000-index)];message.comment.createTime=(unsigned int)(1000-index);}];
    CurrentTimeline=[WCTimeLineViewController new];CurrentTimeline.facade=CurrentFacade;
    CurrentDiscovery=[FindFriendEntryViewController new];CurrentDiscovery.facade=CurrentFacade;CurrentDiscovery.mutualReminder=YES;
    WCCommentListViewController *page=[WCCommentListViewController new];page._arrCommentList=[messages mutableCopy];page._dicCells=[NSMutableDictionary dictionary];page._dicCellHeights=[NSMutableDictionary dictionary];
    CSCFPageIsCurrent(page);CSCFPageIsCurrent(CurrentTimeline);CSCFPageIsCurrent(CurrentDiscovery);
    return page;
}
static int ReadCases(void) {
    WCSNSMessage *ordinary=Message(@"ordinary",@"alice",YES);
    WCCommentListViewController *page=BeginCase(@"ordinary-only-while-protected",@[ordinary]);
    NSMutableArray *source=page._arrCommentList,*database=CurrentFacade.source;
    [page tableView:nil numberOfRowsInSection:0];[page markMessageAllRead];
    Check(ordinary.hasRead && AuthenticationRequests==0 && page.nativeReads==0);
    Check(CurrentFacade.markedBatches.count==1 && [CurrentFacade.markedBatches[0] firstObject]==ordinary && CurrentFacade.readStateNotifications==1 && CurrentFacade.lastReadTime==ordinary.comment.createTime);
    Check(page._arrCommentList==source && CurrentFacade.source==database && source.count==1 && database.count==1);
    Check(CurrentFacade.notifications>0 && CurrentTimeline.displayedCount==0 && CurrentDiscovery.displayedCount==0 && CurrentDiscovery.tabCount==3);

    ordinary=Message(@"ordinary-2",@"alice",YES);WCSNSMessage *secret=Message(@"secret",@"secret",YES);
    WCSNSMessage *indirect=Message(@"indirect",@"bob",NO);indirect.refComment=[WCUserComment new];indirect.refComment.username=@"secret";
    page=BeginCase(@"mixed-exact-visible-read",@[secret,ordinary,indirect]);source=page._arrCommentList;
    Check([page tableView:nil numberOfRowsInSection:0]==1);
    [page markMessageAllRead];
    Check(ordinary.hasRead && !secret.hasRead && !indirect.hasRead && page.nativeReads==0 && AuthenticationRequests==0);
    Check(page._arrCommentList==source && source.count==3 && CurrentFacade.source.count==3);
    Check(CurrentTimeline.displayedCount==0 && CurrentDiscovery.displayedCount==0 && CurrentDiscovery.tabCount==3);
    Policy(YES,YES);[CurrentFacade onMessageUnReadCountChanged];
    Check(CurrentTimeline.displayedCount==2 && CurrentDiscovery.displayedCount==2 && !secret.hasRead);
    [page markMessageAllRead];Check(page.nativeReads==1 && secret.hasRead && indirect.hasRead);

    secret=Message(@"hidden-only",@"secret",YES);page=BeginCase(@"hidden-only-no-write",@[secret]);
    [page tableView:nil numberOfRowsInSection:0];[page markMessageAllRead];
    Check(!secret.hasRead && CurrentFacade.markedBatches.count==0 && CurrentFacade.notifications==0 && AuthenticationRequests==0 && page.nativeReads==0);
    ordinary=Message(@"unfiltered",@"alice",YES);secret=Message(@"unfiltered-hidden",@"secret",YES);
    page=BeginCase(@"hide-interactions-disabled-native-behavior",@[secret,ordinary]);Policy(NO,NO);[page markMessageAllRead];
    Check(page.nativeReads==1 && secret.hasRead && ordinary.hasRead && AuthenticationRequests==0);

    ordinary=Message(@"cutoff-anchor",@"alice",YES);secret=Message(@"cutoff-hidden",@"secret",YES);
    page=BeginCase(@"native-local-id-cutoff-includes-unloaded-older",@[ordinary,secret]);
    WCSNSMessage *older=Message(@"unloaded-older",@"bob",YES),*newer=Message(@"after-anchor",@"carol",YES);
    older.msgID=@"500";older.comment.createTime=9000;newer.msgID=@"1001";newer.comment.createTime=1;
    [CurrentFacade.source addObjectsFromArray:@[older,newer]];
    [page markMessageAllRead];
    Check(ordinary.hasRead && older.hasRead && !secret.hasRead && !newer.hasRead && page._arrCommentList.count==2 && CurrentFacade.source.count==4);
    Check(CurrentFacade.markedBatches.count==1 && [CurrentFacade.markedBatches[0] isEqual:(@[ordinary,older])]);

    ordinary=Message(@"failed-write-visible",@"alice",YES);secret=Message(@"failed-write-hidden",@"secret",YES);
    page=BeginCase(@"failed-native-write-keeps-real-unread",@[ordinary,secret]);CurrentFacade.writeFails=YES;
    [page markMessageAllRead];
    Check(!ordinary.hasRead && !secret.hasRead && CurrentFacade.markedBatches.count==1 && CurrentFacade.notifications==1 && CurrentTimeline.displayedCount==1 && CurrentDiscovery.displayedCount==1);
    return 0;
}
static int BoundaryCases(void) {
    WCSNSMessage *ordinary=Message(@"before",@"alice",YES),*arrived=Message(@"after",@"carol",YES),*secret=Message(@"secret-2",@"secret",YES);
    WCCommentListViewController *page=BeginCase(@"arriving-message-not-acknowledged",@[secret,ordinary]);
    [page tableView:nil numberOfRowsInSection:0];
    QueryProbeAt=2;QueryProbe=^{[CurrentFacade.source addObject:arrived];};[page markMessageAllRead];
    Check(ordinary.hasRead && !secret.hasRead && !arrived.hasRead && CurrentFacade.source.count==3);

    ordinary=Message(@"deleted-before-write",@"alice",YES);page=BeginCase(@"record-removed-before-write",@[ordinary]);
    [page tableView:nil numberOfRowsInSection:0];QueryProbe=^{[CurrentFacade.source removeAllObjects];};[page markMessageAllRead];
    Check(!ordinary.hasRead && CurrentFacade.markedBatches.count==0 && CurrentFacade.markedSingles.count==0);

    ordinary=Message(@"stale-account",@"alice",YES);page=BeginCase(@"account-change-during-query",@[ordinary]);
    [page tableView:nil numberOfRowsInSection:0];QueryProbe=^{Epoch++;};[page markMessageAllRead];
    Check(!ordinary.hasRead && CurrentFacade.markedBatches.count==0 && CurrentFacade.markedSingles.count==0);Epoch--;
    ordinary=Message(@"stale-policy",@"alice",YES);page=BeginCase(@"policy-change-during-query",@[ordinary]);
    [page tableView:nil numberOfRowsInSection:0];QueryProbe=^{Policy(YES,YES);};[page markMessageAllRead];
    Check(!ordinary.hasRead && CurrentFacade.markedBatches.count==0 && CurrentFacade.markedSingles.count==0);
    return 0;
}
static int DestructiveCases(void) {
    WCCommentListViewController *page=BeginCase(@"destructive-authentication-without-replay",@[Message(@"clear",@"alice",YES),Message(@"clear-hidden",@"secret",YES)]);
    [page tableView:nil numberOfRowsInSection:0];NSIndexPath *first=[NSIndexPath indexPathForRow:0 inSection:0];
    [page onClearList:nil];[page clearList];[page onDeleteData];[page tableView:nil commitEditingStyle:1 forRowAtIndexPath:first];
    Check(AuthenticationRequests==4 && AuthenticationOwner==page && page.clearMenus==0 && page.clears==0 && page.deletes==0 && page.rowDeletes==0);
    Policy(YES,YES);
    Check(page.clearMenus==0 && page.clears==0 && page.deletes==0 && page.rowDeletes==0);
    [page tableView:nil numberOfRowsInSection:0];[page onClearList:nil];[page clearList];[page onDeleteData];[page tableView:nil commitEditingStyle:1 forRowAtIndexPath:first];
    Check(page.clearMenus==1 && page.clears==1 && page.deletes==1 && page.rowDeletes==1);
    Epoch++;[page clearList];[page onClearList:nil];[page onDeleteData];
    Check(page.clears==1 && page.clearMenus==1 && page.deletes==1 && AuthenticationRequests==4);Epoch--;
    return 0;
}
static int PaginationCases(void) {
    WCSNSMessage *secret=Message(@"page-secret",@"secret",YES),*ordinary=Message(@"page-ordinary",@"alice",YES);
    WCCommentListViewController *page=BeginCase(@"native-load-more-source-index",@[secret,ordinary]);page.hasMore=YES;
    Check([page tableView:nil numberOfRowsInSection:0]==2);
    NSIndexPath *first=[NSIndexPath indexPathForRow:0 inSection:0],*tail=[NSIndexPath indexPathForRow:1 inSection:0];
    Check([page tableView:nil cellForRowAtIndexPath:first]==ordinary && [[page tableView:nil cellForRowAtIndexPath:tail] isEqual:@"load-more"]);
    [page tableView:nil didSelectRowAtIndexPath:first];Check(page.selections==1 && page.lastNativeRow==1);
    [page tableView:nil didSelectRowAtIndexPath:tail];Check(page.loadMore==1 && page.lastNativeRow==2);
    page._arrCommentList[0]=Message(@"replacement",@"secret",YES);[page tableView:nil didSelectRowAtIndexPath:tail];
    Check(page.loadMore==1); // Equal count is insufficient after a source replacement.
    [page tableView:nil numberOfRowsInSection:0];[page._arrCommentList addObject:Message(@"new-page",@"bob",YES)];
    [page tableView:nil didSelectRowAtIndexPath:tail];Check(page.loadMore==1);
    return 0;
}
static int PresentationCases(void) {
    WCSNSMessage *secret=Message(@"tip-secret",@"secret",YES),*latest=Message(@"tip-latest",@"alice",YES);
    WCSNSMessage *otherSecret=Message(@"tip-other-secret",@"secret",YES),*older=Message(@"tip-older",@"bob",YES);
    __unused WCCommentListViewController *page=BeginCase(@"visible-last-and-limit-backfill",@[secret,latest,otherSecret,older]);
    BOOL previous=CSCFUnreadBegin();
    WCSNSMessage *last=[CurrentFacade getLastUnReadMessage];
    Check([last.msgID isEqual:latest.msgID]);
    Check([[CurrentFacade getUnReadMessagesLimit:1] isEqual:@[latest]] && [[CurrentFacade getUnReadMessagesLimit:2] isEqual:(@[latest,older])]);
    CSCFUnreadEnd(previous);
    last=[CurrentFacade getLastUnReadMessage];
    Check(last!=secret && [last.msgID isEqual:secret.msgID] && [[CurrentFacade getUnReadMessagesLimit:1] isEqual:@[secret]]);
    [CurrentTimeline onMessageUnReadCountChanged];[CurrentDiscovery onMessageUnReadCountChanged];
    Check(CurrentTimeline.displayedCount==2 && [CurrentTimeline.displayedUser isEqual:@"alice"] && CurrentDiscovery.displayedCount==2);
    Check(!latest.hasRead && !older.hasRead && !secret.hasRead && !otherSecret.hasRead && CurrentFacade.source.count==4);

#if INTERACTION_HAS_UNREAD_PROJECTION_CACHE
    CaseName=@"background-native-accessors-preserve-main-scope";
    previous=CSCFUnreadBegin();[CurrentFacade getUnReadMessages];
    NSMutableDictionary *cache=UnreadProjections;NSDictionary *contents=[cache copy];
    NSUInteger cachedEpoch=UnreadEpoch,cachedRevision=UnreadRevision;
    __block NSInteger backgroundCount;__block BOOL backgroundHas,backgroundWasMain;__block NSString *backgroundUser;
    dispatch_group_t group=dispatch_group_create();
    dispatch_group_async(group,dispatch_get_global_queue(QOS_CLASS_USER_INITIATED,0),^{
        backgroundWasMain=NSThread.isMainThread;backgroundCount=[CurrentTimeline messageTipCount];backgroundHas=[CurrentTimeline hasUnReadMessage];backgroundUser=[CurrentTimeline messageTipUserName];
    });
    Check(dispatch_group_wait(group,dispatch_time(DISPATCH_TIME_NOW,5*NSEC_PER_SEC))==0 && !backgroundWasMain && backgroundCount==0 && !backgroundHas && !backgroundUser);
    Check(UnreadDisplay && UnreadProjections==cache && [UnreadProjections isEqualToDictionary:contents] && UnreadEpoch==cachedEpoch && UnreadRevision==cachedRevision);
    CSCFUnreadEnd(previous);
    dispatch_group_async(group,dispatch_get_global_queue(QOS_CLASS_USER_INITIATED,0),^{
        backgroundCount=[CurrentTimeline messageTipCount];backgroundHas=[CurrentTimeline hasUnReadMessage];backgroundUser=[CurrentTimeline messageTipUserName];
    });
    Check(dispatch_group_wait(group,dispatch_time(DISPATCH_TIME_NOW,5*NSEC_PER_SEC))==0 && backgroundCount==0 && !backgroundHas && !backgroundUser && !UnreadDisplay && !UnreadProjections && UnreadEpoch==cachedEpoch && UnreadRevision==cachedRevision);
    Policy(YES,YES);
    dispatch_group_async(group,dispatch_get_global_queue(QOS_CLASS_USER_INITIATED,0),^{
        backgroundCount=[CurrentTimeline messageTipCount];backgroundHas=[CurrentTimeline hasUnReadMessage];backgroundUser=[CurrentTimeline messageTipUserName];
    });
    Check(dispatch_group_wait(group,dispatch_time(DISPATCH_TIME_NOW,5*NSEC_PER_SEC))==0 && backgroundCount==4 && backgroundHas && [backgroundUser isEqual:@"secret"] && !UnreadDisplay && !UnreadProjections && UnreadEpoch==cachedEpoch && UnreadRevision==cachedRevision);
#endif
    page=BeginCase(@"same-scope-discovery-policy-revision",@[Message(@"revision-hidden",@"secret",YES),Message(@"revision-alice",@"alice",YES),Message(@"revision-bob",@"bob",YES)]);
    __block NSInteger before,after;
    DiscoveryWithCounts(CurrentDiscovery,^{
        before=[CurrentDiscovery getSnsMessageCount];
        Snapshot=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"self" profile:@{@"enabled":@YES,@"friends":@[@"secret",@"alice"],@"groups":@[],@"options":CSCloseFriendDefaultOptions()} revealed:NO revision:++Revision blocked:NO];
        after=[CurrentDiscovery getSnsMessageCount];
    });
    Check(before==2 && after==1 && CurrentFacade.source.count==3);
    return 0;
}
int main(void) { @autoreleasepool {
    CaseName=@"production-registration";Policy(NO,YES);CSCFInteractionInstall();
    Check([Capabilities[@"social.interactions.coupled"] boolValue]);
    Check([InstalledHooks containsObject:@"WCCommentListViewController.markMessageAllRead"]);
    Check(ReadCases()==0);Check(BoundaryCases()==0);Check(DestructiveCases()==0);Check(PaginationCases()==0);Check(PresentationCases()==0);
    printf("Interactions: %lu checks passed with the complete production adapter (visible read, hidden records, policy/account boundaries, native pagination, authentication without replay, presentation backfill and refresh)\n",(unsigned long)Checks);
    AuthenticationOwner=nil;CurrentFacade=nil;CurrentTimeline=nil;CurrentDiscovery=nil;
    return 0;
} }
