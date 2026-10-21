#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import "CSCloseFriendSocialProjection.h"
#import "CSCloseFriendSignatures.h"
#import "CSCloseFriendContactProjection.h"
static CSCloseFriendSnapshot *Snapshot;
static NSUInteger Epoch=1;
NSString *const CSCloseFriendPolicyDidChangeNotification=@"CSCloseFriendPolicyDidChange";
static char EpochKey;
static CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) {return Snapshot;}
static NSUInteger CSCloseFriendAccountEpoch(void) {return Epoch;}
static BOOL CSCFIsClass(id object,NSString *name) {return [object isKindOfClass:NSClassFromString(name)];}
static id CSCloseFriendRead(id object,NSString *key) {
    if([object isKindOfClass:NSDictionary.class]) return object[key];
    SEL selector=NSSelectorFromString(key);
    if(CSCloseFriendMethodMatches(class_getInstanceMethod([object class],selector),"@@:")) return ((id(*)(id,SEL))objc_msgSend)(object,selector);
    Ivar ivar=class_getInstanceVariable([object class],key.UTF8String); return ivar && ivar_getTypeEncoding(ivar)[0]=='@' ? object_getIvar(object,ivar) : nil;
}
static BOOL CSCFPageIsCurrent(id page) {NSNumber *old=objc_getAssociatedObject(page,&EpochKey); if(!old) {old=@(Epoch); objc_setAssociatedObject(page,&EpochKey,old,OBJC_ASSOCIATION_RETAIN_NONATOMIC);} return old.unsignedIntegerValue==Epoch;}
static NSMapTable *Refreshes;
static void CSCFSocialTrack(id owner,void(^refresh)(id)) {if(!Refreshes) Refreshes=[NSMapTable weakToStrongObjectsMapTable]; [Refreshes setObject:[refresh copy] forKey:owner];}
static void CSCFSocialClearCaches(id owner,NSArray *names) {for(NSString *name in names) {id cache=CSCloseFriendRead(owner,name); if([cache isKindOfClass:NSMutableDictionary.class]) [cache removeAllObjects];}}
static BOOL CSCFCallVoid(id page,NSString *name) {SEL selector=NSSelectorFromString(name); if(!CSCloseFriendMethodMatches(class_getInstanceMethod([page class],selector),"v@:"))return NO; ((void(*)(id,SEL))objc_msgSend)(page,selector); return YES;}
static void CSCFReloadTables(__unused id page) {}
static NSMapTable *RouteGates;
static BOOL CSCFSocialGate(id owner,CSCloseFriendSurface surface,BOOL force) {
    if(!RouteGates) RouteGates=[NSMapTable weakToStrongObjectsMapTable];
    BOOL blocked=!CSCFPageIsCurrent(owner) || (force && CSCloseFriendSurfaceConcealed(Snapshot,surface));
    [RouteGates setObject:@(blocked) forKey:owner]; return blocked;
}
static BOOL CSCFUnreadBegin(void) {return NO;}
static void CSCFUnreadEnd(__unused BOOL previous) {}
static CSCloseFriendSocialProjection *CSCFSocialProject(NSArray *source,CSCloseFriendSurface surface) {return [[CSCloseFriendSocialProjection alloc] initWithSource:source snapshot:Snapshot surface:surface read:^id(id item,NSString *key){return CSCloseFriendRead(item,key);}];}
static BOOL CSCFSocialHidden(id object,CSCloseFriendSurface surface) {return CSCloseFriendSocialObjectHidden(object,Snapshot,surface,^id(id item,NSString *key){return CSCloseFriendRead(item,key);});}
static NSMutableSet *InstalledHooks;
static BOOL CSCloseFriendInstallHook(NSString *cls,NSString *name,IMP replacement,IMP *original,const char *type) {
    Method m=class_getInstanceMethod(NSClassFromString(cls),NSSelectorFromString(name));
    if(!CSCloseFriendMethodMatches(m,type)) return NO;
    *original=method_getImplementation(m);
    if(!InstalledHooks)InstalledHooks=[NSMutableSet new]; [InstalledHooks addObject:[cls stringByAppendingFormat:@".%@",name]];
    // MSHookMessageEx creates a class-local override for inherited lifecycle methods.
    class_replaceMethod(NSClassFromString(cls),NSSelectorFromString(name),replacement,method_getTypeEncoding(m)); return YES;
}
static void CSCFSocialHook0(NSString *cls,NSString *name,void(^body)(id,void(^)(void))) {
    __block IMP original=NULL; SEL selector=NSSelectorFromString(name);
    IMP replacement=imp_implementationWithBlock(^(id object){body(object,^{((void(*)(id,SEL))original)(object,selector);});});
    if(!CSCloseFriendInstallHook(cls,name,replacement,&original,"v@:")) imp_removeBlock(replacement);
}
@interface NSIndexPath (CSCFTest)
@property(nonatomic,readonly) NSInteger row,section;
+ (instancetype)indexPathForRow:(NSInteger)row inSection:(NSInteger)section;
@end
@implementation NSIndexPath (CSCFTest)
+ (instancetype)indexPathForRow:(NSInteger)row inSection:(NSInteger)section {NSUInteger indexes[]={(NSUInteger)section,(NSUInteger)row}; return [self indexPathWithIndexes:indexes length:2];}
- (NSInteger)row {return (NSInteger)[self indexAtPosition:1];}
- (NSInteger)section {return (NSInteger)[self indexAtPosition:0];}
@end
@interface WCDataItem : NSObject
@property(nonatomic,copy) NSString *username,*itemID;
@property(nonatomic,strong) NSArray *likeUsers,*commentUsers;
@property(nonatomic) BOOL isPrivate;
@property(nonatomic,copy) NSSet *selectContacts,*selectTags;
- (int)likeCount;
- (int)commentCount;
@end
@implementation WCDataItem
- (int)likeCount {return (int)_likeUsers.count;}
- (int)commentCount {return (int)_commentUsers.count;}
@end
@interface WCFacade : NSObject
@property(nonatomic,strong) NSArray *source;
@property(nonatomic,strong) NSMutableDictionary *styleCache;
@property(nonatomic) NSUInteger clears,reads;
- (NSArray *)getTimelineDataItem;
- (NSInteger)countOfTimelineDataItem;
- (id)getTimelineDataItemOfIndex:(NSInteger)index;
- (void)reloadTimelineDataItems;
- (void)removeCachesOfLikeUserWithDataItemId:(NSString *)itemID;
- (id)layoutStylesOfLikeUserWithDataItem:(WCDataItem *)item width:(double)width isSpringStyle:(BOOL)spring;
- (double)likeUserHeightForWidth:(double)width withDataItem:(WCDataItem *)item isSpringStyle:(BOOL)spring;
@end
@implementation WCFacade
- (NSArray *)getTimelineDataItem {self.reads++;return self.source;}
- (NSInteger)countOfTimelineDataItem {return (NSInteger)self.source.count;}
- (id)getTimelineDataItemOfIndex:(NSInteger)index {return index>=0 && (NSUInteger)index<self.source.count ? self.source[(NSUInteger)index] : nil;}
- (void)reloadTimelineDataItems {}
- (void)removeCachesOfLikeUserWithDataItemId:(NSString *)itemID {self.clears++; [self.styleCache removeObjectForKey:itemID];}
- (id)layoutStylesOfLikeUserWithDataItem:(WCDataItem *)item width:(__unused double)width isSpringStyle:(__unused BOOL)spring {NSArray *names=self.styleCache[item.itemID]; if(!names) self.styleCache[item.itemID]=names=item.likeUsers; return names;}
- (double)likeUserHeightForWidth:(__unused double)width withDataItem:(WCDataItem *)item isSpringStyle:(__unused BOOL)spring {return item.likeCount*20;}
@end
@interface UIView : NSObject
@property(nonatomic,strong) id window;
@end
@implementation UIView @end
@interface UITableView : UIView
@property(nonatomic) NSUInteger reloads;
@property(nonatomic) BOOL renderPending;
- (void)reloadData;
@end
@implementation UITableView
- (void)reloadData {self.reloads++; self.renderPending=YES;}
@end
@interface UIViewController : NSObject
@property(nonatomic,strong) UIView *view;
@property(nonatomic,getter=isViewLoaded) BOOL viewLoaded;
@end
@implementation UIViewController @end
@interface WCTimeLineViewController : UIViewController
@property(nonatomic,strong) UITableView *tableView,*nestedMedia;
@property(nonatomic,strong) WCFacade *facade;
@property(nonatomic,strong) NSMutableDictionary *cellHeightCache,*cellShowItemCache;
@property(nonatomic,strong) NSMutableArray *deferredRows;
@property(nonatomic,strong) id displayedItem;
@property(nonatomic) NSUInteger nativeReloads,nativeLayouts,appearances,displayCalls,disappearances;
@property(nonatomic) BOOL refreshInsideReload;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidAppear:(BOOL)animated;
- (void)viewDidDisappear:(BOOL)animated;
- (void)viewDidLayoutSubviews;
- (void)reloadDataWrap;
- (NSInteger)numberOfSectionsInTableView:(id)table;
- (void)tableView:(id)table willDisplayCell:(id)cell forRowAtIndexPath:(NSIndexPath *)path;
@end
@implementation WCTimeLineViewController
- (void)viewWillAppear:(__unused BOOL)animated {self.appearances++;}
- (void)viewDidAppear:(__unused BOOL)animated {self.appearances++;}
- (void)viewDidDisappear:(__unused BOOL)animated {self.disappearances++;}
// Native layout can reload. A plugin that forces layout from a reload hook
// would re-enter this cycle; production must not install either hook.
- (void)viewDidLayoutSubviews {self.nativeLayouts++; [self reloadDataWrap];}
- (void)reloadDataWrap {
    self.nativeReloads++; [self.deferredRows removeAllObjects]; [self.tableView reloadData];
    if(self.refreshInsideReload) {void(^update)(id)=[Refreshes objectForKey:self]; if(update)update(self);}
}
- (NSInteger)numberOfSectionsInTableView:(__unused id)table {return [self.facade countOfTimelineDataItem];}
- (void)tableView:(__unused id)table willDisplayCell:(__unused id)cell forRowAtIndexPath:(NSIndexPath *)path {
    self.displayCalls++; self.displayedItem=[self.facade getTimelineDataItemOfIndex:path.section];
}
@end
@interface InteractionPage : NSObject
@property(nonatomic,strong) NSMutableArray *_arrCommentList;
@end
@implementation InteractionPage @end
@interface UITableViewCell : NSObject @end
@implementation UITableViewCell @end
@interface WCCommentListViewController : InteractionPage
@property(nonatomic) NSUInteger nativeRenderCalls;
- (id)tableView:(id)table cellForRowAtIndexPath:(NSIndexPath *)path;
- (double)tableView:(id)table heightForRowAtIndexPath:(NSIndexPath *)path;
@end
@implementation WCCommentListViewController
- (id)tableView:(__unused id)table cellForRowAtIndexPath:(NSIndexPath *)path {self.nativeRenderCalls++; return self._arrCommentList[(NSUInteger)path.row];}
- (double)tableView:(__unused id)table heightForRowAtIndexPath:(__unused NSIndexPath *)path {self.nativeRenderCalls++; return 44;}
@end
@interface StatusPage : NSObject
@property(nonatomic,strong) NSMutableArray *usernameList;
@end
@implementation StatusPage @end
@interface FindFriendEntryViewController : NSObject
- (BOOL)badgeAtMomentCell;
- (NSInteger)numberOfUnreadAtMomentCell;
@end
@implementation FindFriendEntryViewController
- (BOOL)badgeAtMomentCell {return YES;}
- (NSInteger)numberOfUnreadAtMomentCell {return 7;}
@end
@interface WCMomentsPrivacyViewController : NSObject
@property(nonatomic,strong) NSSet *selectContacts;
@property(nonatomic,strong) id currentItem;
@end
@implementation WCMomentsPrivacyViewController @end
@interface WCNewCommitViewController : NSObject
@property(nonatomic,strong) id contactsSelectorController;
@end
@implementation WCNewCommitViewController @end
@interface ContactsSelectorController : NSObject
@property(nonatomic,weak) id delegate;
@property(nonatomic,strong) NSArray *arrContacts;
@end
@implementation ContactsSelectorController @end
@interface MultiSelectContactsViewController : NSObject
@property(nonatomic,weak) id m_delegate;
@end
@implementation MultiSelectContactsViewController @end
@interface ContactSelectView : NSObject
@property(nonatomic,weak) id m_delegate;
@property(nonatomic,strong) NSSet *pending;
@end
@implementation ContactSelectView @end
@interface AudienceLogic : NSObject
@property(nonatomic,weak) id m_delegate;
@property(nonatomic,strong) NSArray *contacts;
@end
@implementation AudienceLogic @end
static NSArray *FixtureKeys(__unused id logic,__unused SEL cmd) {return @[@"A"];}
static NSArray *FixtureRows(AudienceLogic *logic,__unused SEL cmd,__unused id key) {return logic.contacts;}
static char ShieldKey;
static void ShieldPicker(id picker) {objc_setAssociatedObject(picker,&ShieldKey,@YES,OBJC_ASSOCIATION_RETAIN_NONATOMIC);}
static BOOL CSCloseFriendShouldHideUserName(NSString *name,CSCloseFriendSurface surface) {return [Snapshot hidesUserName:name surface:surface];}
#include "SocialRouteBodies.h"
static BOOL CSCFSocialRequireAuthentication(id owner,CSCloseFriendSurface surface) {return !CSCFPageIsCurrent(owner) || CSCloseFriendSurfaceConcealed(Snapshot,surface);}
#include "TimelineBodies.h"
#include "InteractionBodies.h"
#include "StatusBodies.h"
#include "AudienceBodies.h"
#define Check(x) do { if(!(x)) {fprintf(stderr,"FAIL %s:%d: %s\n",__FILE__,__LINE__,#x); return 1;} } while(0)
static void Policy(BOOL revealed,NSUInteger revision) {
    Snapshot=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"fixture" profile:@{@"enabled":@YES,@"friends":@[@"secret"],@"groups":@[],@"options":CSCloseFriendDefaultOptions()} revealed:revealed revision:revision blocked:NO];
}
#include "CloseFriendSocialRouteFixture.h"
#include "CloseFriendTimelinePresentationTests.h"
#include "CloseFriendTimelineCacheTests.h"
int main(void) { @autoreleasepool {
    Check(TestSocialRoutes()==0);
    Policy(NO,1); InstallModel();
    Check(TestTimelineCacheNativeCallbacks()==0);
    Policy(NO,1);
    TableMethod(@"tableView:cellForRowAtIndexPath:","@@:@@"); TableMethod(@"tableView:heightForRowAtIndexPath:","d@:@@");
    NSDictionary *ordinary=@{@"username":@"alice"}, *hidden=@{@"username":@"secret"}, *reply=@{@"username":@"alice",@"refUserName":@"secret"};
    WCDataItem *post=[WCDataItem new]; post.username=@"alice"; post.itemID=@"post-a"; post.likeUsers=@[ordinary,hidden]; post.commentUsers=@[hidden,reply,ordinary]; post.isPrivate=YES; post.selectContacts=[NSSet setWithArray:@[@"alice",@"secret"]]; post.selectTags=[NSSet setWithObject:@"original-tag"];
    WCDataItem *secretPost=[WCDataItem new]; secretPost.username=@"secret"; secretPost.itemID=@"post-s";
    WCDataItem *last=[WCDataItem new]; last.username=@"carol"; last.itemID=@"post-c";
    WCFacade *facade=[WCFacade new]; facade.source=@[post,secretPost,last]; facade.styleCache=[NSMutableDictionary dictionary];
    NSArray *originalLikes=post.likeUsers,*originalComments=post.commentUsers,*originalPosts=facade.source; NSSet *acl=post.selectContacts,*tags=post.selectTags;
    Check(![post respondsToSelector:@selector(copyWithZone:)]);
    [facade layoutStylesOfLikeUserWithDataItem:post width:320 isSpringStyle:NO];
    WCTimeLineViewController *page=[WCTimeLineViewController new]; CSCFTimelineScope *previous=Enter(page,nil);
    Check([facade countOfTimelineDataItem]==2); Check([facade getTimelineDataItemOfIndex:1]==last); Check([facade getTimelineDataItemOfIndex:2]==nil);
    Check(post.likeCount==1 && post.commentCount==1); Check([post.commentUsers isEqual:@[ordinary]]);
    Check([[facade layoutStylesOfLikeUserWithDataItem:post width:320 isSpringStyle:NO] isEqual:@[ordinary]]);
    Check([facade likeUserHeightForWidth:320 withDataItem:post isSpringStyle:NO]==20);
    __block BOOL backgroundOriginal=NO;
    dispatch_group_t group=dispatch_group_create(); dispatch_group_async(group,dispatch_get_global_queue(QOS_CLASS_DEFAULT,0),^{backgroundOriginal=[facade countOfTimelineDataItem]==3 && post.commentCount==3;}); dispatch_group_wait(group,DISPATCH_TIME_FOREVER);
    Check(backgroundOriginal); Leave(previous);
    Check(facade.source==originalPosts && post.likeUsers==originalLikes && post.commentUsers==originalComments);
    Check(post.likeCount==2 && post.commentCount==3 && post.isPrivate && post.selectContacts==acl && post.selectTags==tags);
    Check(facade.clears>0 && facade.styleCache.count==0);
    NSUInteger clears=facade.clears;
    for(NSUInteger i=0;i<20;i++) {previous=Enter(page,nil);Check([facade countOfTimelineDataItem]==2);Leave(previous);}
    Check(facade.clears==clears); // Scroll/count scope must not flush all post layouts.
    previous=Enter(page,nil);NSUInteger reads=facade.reads;
    Check([facade countOfTimelineDataItem]==2);NSArray *cachedLikes=post.likeUsers,*cachedComments=post.commentUsers;
    for(NSUInteger i=0;i<20;i++)Check([facade countOfTimelineDataItem]==2 && post.likeUsers==cachedLikes && post.commentUsers==cachedComments);
    Check(facade.reads==reads+1);Leave(previous); // One source validation within the native call.
    NSMutableArray *mutablePosts=[originalPosts mutableCopy],*mutableLikes=[originalLikes mutableCopy],*mutableComments=[originalComments mutableCopy];
    facade.source=mutablePosts;post.likeUsers=mutableLikes;post.commentUsers=mutableComments;
    [mutablePosts removeObject:last];[mutableLikes removeObject:ordinary];[mutableComments addObject:ordinary];
    previous=Enter(page,nil);Check([facade countOfTimelineDataItem]==1 && post.likeCount==0 && post.commentCount==2);Leave(previous);
    Check(mutableLikes.count==1 && mutableComments.count==4); // Projection never edits source.
    [mutablePosts addObject:last];[mutableLikes addObject:ordinary];[mutableComments removeLastObject];
    previous=Enter(page,nil);Check([facade countOfTimelineDataItem]==2 && post.likeCount==1 && post.commentCount==1);Leave(previous);
    facade.source=originalPosts;post.likeUsers=originalLikes;post.commentUsers=originalComments;
    Policy(YES,2); previous=Enter(page,nil); Check(!Scope && [facade countOfTimelineDataItem]==3 && post.commentCount==3); Leave(previous);
    Check(facade.clears==clears);
    Policy(NO,3); previous=Enter(page,nil); Check([facade countOfTimelineDataItem]==2 && post.commentCount==1); Leave(previous);
    NSDictionary *m1=@{@"comment":ordinary,@"objID":@"secret"};
    NSDictionary *m2=@{@"comment":hidden}, *m3=@{@"comment":ordinary,@"refComment":reply};
    NSDictionary *m4=@{@"comment":@{@"username":@"alice",@"dataItemUsrName":@"secret"}};
    NSDictionary *m5=@{@"comment":@{@"username":@"carol"}};
    WCCommentListViewController *messages=[WCCommentListViewController new]; messages._arrCommentList=[@[m1,m2,m3,m4,m5] mutableCopy];
    NSMutableArray *nativeMessages=messages._arrCommentList;
    Check(Messages(messages).visible.count==2);
    NSIndexPath *second=[NSIndexPath indexPathForRow:1 inSection:0];
    Check(MessagePath(messages,second).row==4 && MessageActionCurrent(messages,second));
    Check(MessagePath(messages,[NSIndexPath indexPathForRow:2 inSection:0]).row==5);
    Check(messages._arrCommentList==nativeMessages && nativeMessages.count==5);
    Check([messages tableView:nil cellForRowAtIndexPath:second]==m5);
    NSUInteger renders=messages.nativeRenderCalls; nativeMessages[4]=m2;
    Check(MessagePath(messages,second)==nil && !MessageActionCurrent(messages,second));
    Check([[messages tableView:nil cellForRowAtIndexPath:second] isKindOfClass:UITableViewCell.class]);
    Check([messages tableView:nil heightForRowAtIndexPath:second]==0 && messages.nativeRenderCalls==renders);
    Check(nativeMessages[4]==m2); // Validation never rewrites the native update.
    [nativeMessages removeLastObject]; Check(!MessageActionCurrent(messages,second));
    Policy(YES,4); Check(Messages(messages).visible.count==4); Check(nativeMessages.count==4);
    StatusPage *status=[StatusPage new]; status.usernameList=[@[@"secret",@"alice",@"carol"] mutableCopy];
    Policy(NO,5); Check(Cards(status).visible.count==2 && [Cards(status) sourceIndex:0]==1 && [Cards(status) sourceIndex:1]==2); Check(status.usernameList.count==3);
    Policy(YES,6); Check(Cards(status).visible.count==3 && [Cards(status) sourceIndex:0]==0);
    // Revealed publishing picker retains complete native candidates and real pending ACL.
    WCMomentsPrivacyViewController *privacy=[WCMomentsPrivacyViewController new]; privacy.selectContacts=acl;
    ContactSelectView *picker=[ContactSelectView new]; picker.m_delegate=privacy; picker.pending=acl;
    AudienceLogic *logic=[AudienceLogic new]; logic.m_delegate=picker; logic.contacts=@[@"alice",@"secret"];
    AudienceKeys=(void *)FixtureKeys; AudienceRows=(void *)FixtureRows;
    Check([Keys(logic,NULL) count]==1 && [Rows(logic,NULL,@"A") count]==2 && PickerAllowsAction(picker));
    void(^refreshPicker)(id)=[Refreshes objectForKey:picker]; Check(refreshPicker!=nil);
    Policy(NO,7); refreshPicker(picker);
    Check(PickerAllowsContact([ContactSelectView new],@"secret"));
    Check(!PickerAllowsContact(picker,@"secret") && PickerAllowsContact(picker,@"alice"));
    Check(![objc_getAssociatedObject(picker,&ShieldKey) boolValue]);
    Check([Rows(logic,NULL,@"A") count]==1 && PickerAllowsAction(picker) && !NeedsUnlock(privacy));
    Check(logic.contacts.count==2 && picker.pending==acl && privacy.selectContacts==acl);
    Policy(YES,8); Check([Rows(logic,NULL,@"A") count]==2 && PickerAllowsAction(picker) && !NeedsUnlock(privacy));
    WCMomentsPrivacyViewController *freshPrivacy=[WCMomentsPrivacyViewController new]; freshPrivacy.selectContacts=acl;
    __weak id dismissedPicker, dismissedLogic;
    // Drain temporary weak-reference retains before checking native dismissal.
    @autoreleasepool {
    ContactSelectView *freshPicker=[ContactSelectView new]; freshPicker.m_delegate=freshPrivacy;
    AudienceLogic *freshLogic=[AudienceLogic new]; freshLogic.m_delegate=freshPicker; freshLogic.contacts=logic.contacts;
    Check([Keys(freshLogic,NULL) count]==1 && [Rows(freshLogic,NULL,@"A") count]==2 && PickerAllowsAction(freshPicker) && !NeedsUnlock(freshPrivacy) && !NeedsUnlock(privacy));
    dismissedPicker=freshPicker; dismissedLogic=freshLogic;
    }
    Policy(NO,9);
    privacy.currentItem=[NSObject new];
    objc_setAssociatedObject(privacy,&AudienceItemKey,privacy.currentItem,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(privacy,&AudienceSelectionKey,[NSSet setWithArray:@[@"secret",@"alice"]],OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    NSSet *visibleChange=[NSSet setWithObject:@"carol"];
    Check(([MergeSelection(privacy,visibleChange) isEqual:[NSSet setWithArray:@[@"secret",@"carol"]]]));
    Check(visibleChange.count==1 && privacy.selectContacts==acl);
    Policy(YES,10); Check([MergeSelection(privacy,visibleChange) isEqual:visibleChange]);
    WCNewCommitViewController *editor=[WCNewCommitViewController new];
    ContactsSelectorController *selector=[ContactsSelectorController new];selector.delegate=editor;editor.contactsSelectorController=selector;selector.arrContacts=@[@"secret"];
    MultiSelectContactsViewController *multiPicker=[MultiSelectContactsViewController new];multiPicker.m_delegate=selector;
    ContactSelectView *reminder=[ContactSelectView new];reminder.m_delegate=multiPicker;reminder.pending=acl;
    AudienceLogic *reminderLogic=[AudienceLogic new];reminderLogic.m_delegate=reminder;reminderLogic.contacts=logic.contacts;
    Policy(NO,11); Check(PublishingOwner(reminderLogic)==editor);
    Check([Keys(reminderLogic,NULL) count]==1 && [Rows(reminderLogic,NULL,@"A") isEqual:@[@"alice"]] && !PickerAllowsContact(reminder,@"secret"));
    Check(PickerAllowsContact(reminder,@"alice") && reminder.pending==acl && [selector.arrContacts isEqual:@[@"secret"]] && reminderLogic.contacts.count==2);
    BindReminderPicker(selector,multiPicker);multiPicker.m_delegate=nil;
    Check(PublishingOwner(reminderLogic)==editor); // Session-hosted branch uses commonSetup identity.
    Policy(YES,12);Check([Rows(reminderLogic,NULL,@"A") count]==2);
    MultiSelectContactsViewController *unrelated=[MultiSelectContactsViewController new];
    ContactsSelectorController *otherSelector=[ContactsSelectorController new];otherSelector.delegate=editor;unrelated.m_delegate=otherSelector;
    ContactSelectView *otherPicker=[ContactSelectView new];otherPicker.m_delegate=unrelated;
    AudienceLogic *otherLogic=[AudienceLogic new];otherLogic.m_delegate=otherPicker;
    Check(!PublishingOwner(otherLogic));
    // Successful native return may release both presentation objects before editor onDone.
    // Exercise the production onDone authorization predicate after those weak refs disappear.
    Check(dismissedPicker==nil && dismissedLogic==nil);
    Check(!NeedsUnlock(freshPrivacy));
    __block NSUInteger doneCalls=0; FinishEdit(freshPrivacy,^{doneCalls++;});
    Check(doneCalls==1 && freshPrivacy.selectContacts==acl && !NeedsUnlock(privacy));
    Check(TestTimelinePresentation()==0);
    Epoch++; Policy(NO,9); previous=Enter(page,nil); Check([facade countOfTimelineDataItem]==0); Leave(previous); Check([facade countOfTimelineDataItem]==3);
    Check(Cards(status).visible.count==0 && !MessageActionCurrent(messages,second) && NeedsUnlock(freshPrivacy));
    Check([Rows(reminderLogic,NULL,@"A") count]==0 && !PickerAllowsContact(reminder,@"alice") && [selector.arrContacts isEqual:@[@"secret"]]);
    puts("Close-friend social: scoped native timeline/model reads, mixed interactions, cache/source/ACL preservation, status indexes, locked publishing candidates and hidden-selection preservation, stale native render rejection, completed-picker authorization and reveal/relock/account transitions passed");
} return 0; }
