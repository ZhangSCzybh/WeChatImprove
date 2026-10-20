#import <Foundation/Foundation.h>
#import <objc/message.h>
#import "CSGroupProjection.h"
#import "CSGroupNativeBridge.h"
#import "CSGroupIndexScope.h"
#import "CSGroupInvocationMapper.h"
#import "CSCloseFriendPolicy.h"
#import "CSCloseFriendSignatures.h"
#import "WESessionTabItem.h"
static NSString *account=@"session-test-account";
static CSCloseFriendSnapshot *policy;
static NSUInteger epoch=1;
static BOOL appActive=YES;
static CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) { return policy; }
static NSUInteger CSCloseFriendAccountEpoch(void) { return epoch; }
static BOOL CSGroupApplicationActive(void) { return appActive; }
static BOOL CSCloseFriendShouldHideUserName(NSString *name,CSCloseFriendSurface surface) { return [policy hidesUserName:name surface:surface]; }
#include "PrivacyActive.h"
static id foldedService;
id CSGetService(Class cls) { return cls==NSClassFromString(@"ChatBoxMgr") ? foldedService : nil; }
@interface ChatBoxMgr : NSObject
@property(nonatomic,strong) NSArray *sourceSessions;
@property(nonatomic) BOOL replaceEpoch;
@end
@implementation ChatBoxMgr
- (id)chatBoxSessions { if (self.replaceEpoch) epoch++; return self.sourceSessions; }
@end
@interface WrongFoldedGetter : NSObject
@property(nonatomic) NSUInteger calls;
@end
@implementation WrongFoldedGetter
- (NSInteger)chatBoxSessions { self.calls++; return 3; }
@end
@interface MMContext : NSObject @end
@implementation MMContext
+ (NSString *)currentUserName { return account; }
@end
static NSIndexPath *Path(NSUInteger row) { NSUInteger indexes[]={0,row}; return [NSIndexPath indexPathWithIndexes:indexes length:2]; }
static CSGroupRow *Row(NSUInteger i,NSString *name,CSGroupRowKind kind,CSGroupRowCategory category,NSUInteger unread) {
 return [[CSGroupRow alloc] initWithNativePath:Path(i) userName:name kind:kind category:category top:NO unreadCount:unread redDot:NO];
}
static CSCloseFriendSnapshot *Policy(NSArray *names,BOOL revealed,NSUInteger revision) {
 return [[CSCloseFriendSnapshot alloc] initWithAccountID:account profile:@{@"enabled":@YES,@"friends":names,@"groups":@[],@"options":@{}} revealed:revealed revision:revision blocked:NO];
}
@interface NativeSession : NSObject
@property(nonatomic,copy) NSString *m_nsUserName;
@property(nonatomic) NSUInteger m_uUnReadCount;
@end
@implementation NativeSession
- (BOOL)isSingleChatSession { return YES; }
@end
@interface TestTable : NSObject
@property(nonatomic,strong) NSIndexPath *indexPathForSelectedRow;
@end
@implementation TestTable @end
static char CellRowKey;
static void CSCloseFriendUpdateSessionCover(id cell,id row) { (void)cell; (void)row; }
static void CSCloseFriendRefreshSessionCover(id cell) { (void)cell; }
static const NSInteger UITableViewCellStyleDefault=0,UITableViewCellSelectionStyleNone=0;
@interface Label : NSObject
@property(nonatomic,copy) NSString *text;
@end
@implementation Label @end
@interface UITableViewCell : NSObject
@property(nonatomic,strong) Label *textLabel;
@property(nonatomic) BOOL userInteractionEnabled;
@property(nonatomic) NSInteger selectionStyle;
- (instancetype)initWithStyle:(NSInteger)style reuseIdentifier:(NSString *)identifier;
@end
@implementation UITableViewCell
- (instancetype)initWithStyle:(NSInteger)style reuseIdentifier:(NSString *)identifier {
 (void)style; (void)identifier;
 if ((self=[super init])) self.textLabel=[Label new]; return self;
}
@end
@interface NativeHost : NSObject
@property(nonatomic,strong) TestTable *m_tableView;
@property(nonatomic,strong) NSMutableArray<NativeSession *> *sessions;
@property(nonatomic,strong) NSIndexPath *opened;
@property(nonatomic) NSUInteger calls,nativeTraversalCalls;
@property(nonatomic,strong) NSIndexPath *rendered;
@property(nonatomic,strong) UITableViewCell *nativeCell;
- (id)tableView:(id)table cellForRowAtIndexPath:(NSIndexPath *)path;
- (void)tableView:(id)table didSelectRowAtIndexPath:(NSIndexPath *)path;
@end
@implementation NativeHost
- (id)tableView:(id)table cellForRowAtIndexPath:(NSIndexPath *)path { (void)table; self.rendered=path; return self.nativeCell; }
- (void)tableView:(id)table didSelectRowAtIndexPath:(NSIndexPath *)path { (void)table; self.opened=path;self.calls++; }
- (id)m_mainFrameLogicController { return self; }
- (NSInteger)numberOfSectionsInTableView:(id)table { (void)table; return 1; }
- (NSInteger)tableView:(id)table numberOfRowsInSection:(NSInteger)section { (void)table; (void)section; return (NSInteger)self.sessions.count; }
- (id)getSessionInfoAtIndexPath:(NSIndexPath *)path { return path.length==2 && [path indexAtPosition:1]<self.sessions.count ? self.sessions[[path indexAtPosition:1]] : nil; }
- (id)getCellDataAtIndexPath:(NSIndexPath *)path { (void)path; return nil; }
- (id)indexPathOfSessionUserName:(NSString *)name { for (NSUInteger i=0;i<self.sessions.count;i++) if ([self.sessions[i].m_nsUserName isEqual:name]) return Path(i); return nil; }
- (void)handleSelectIndexPath:(NSIndexPath *)path tableView:(id)table { (void)table; self.calls++; self.opened=path; }
@end
@interface ChatBoxSessionListViewController : NativeHost @end
@implementation ChatBoxSessionListViewController
- (id)tableView { return self.m_tableView; }
- (id)logicGetSessionAtIndexPath:(NSIndexPath *)path { return [self getSessionInfoAtIndexPath:path]; }
- (id)logicGetCellDataAtIndexPath:(NSIndexPath *)path { (void)path; return nil; }
@end
@interface Preferences : NSObject
@property(nonatomic) BOOL filterDuplicates;
@end
@implementation Preferences @end
@interface CSGroupListAdapter : NSObject
@property(nonatomic,strong) TestTable *table;
@property(nonatomic,strong) NativeHost *controller;
@property(nonatomic,strong) CSGroupProjection *projection;
@property(nonatomic,strong) Preferences *preferences;
@property(nonatomic,strong) NSDictionary *identityDisplayPaths;
@property(nonatomic) BOOL snapshotRetryAttempted,dirty,publishing,nativePresentation,pendingScrollToTop;
@property(nonatomic,strong) NSMutableSet *prefetchedPaths;
@property(nonatomic,strong) NSMutableArray *queuedNavigation;
@property(nonatomic) NSUInteger snapshotRetryGeneration,changeDepth,recoveries;
- (BOOL)isActive;
- (void)refresh;
- (void)requestRecovery;
- (void)scheduleRefresh;
- (void)performInNativePresentation:(void (^)(void))action;
- (BOOL)forwardSwipeInvocation:(NSInvocation *)inv target:(id)target;
@end
@implementation CSGroupListAdapter
#include "SessionBodies.h"
- (BOOL)isActive { return self.projection.isValid; }
- (void)requestRecovery { self.recoveries++; }
- (void)scheduleRefresh {}
- (void)performInNativePresentation:(void (^)(void))action { if (!self.queuedNavigation) self.queuedNavigation=[NSMutableArray array]; [self.queuedNavigation addObject:[action copy]]; }
- (BOOL)forwardSwipeInvocation:(NSInvocation *)inv target:(id)target { (void)inv; (void)target; return NO; }
- (void)refresh {
 NSArray *sections=CSGroupBuildNativeSections(self.controller,self.table,self.controller);
 self.projection=[self projectionForSections:sections tabs:@[[WESessionTabItem tabWithType:WETabTypeAll]] selectedTabID:@"preset_0" accountID:account];
 NSMutableDictionary *paths=[NSMutableDictionary dictionary];
 for (NSUInteger i=0;i<self.projection.sections.firstObject.count;i++) paths[self.projection.sections[0][i].userName]=Path(i);
 self.identityDisplayPaths=paths;
}
@end
static CSGroupListAdapter *navigationAdapter;
static CSGroupListAdapter *Adapter(id owner) { return navigationAdapter.controller==owner ? navigationAdapter : nil; }
static void Native(id owner,BOOL mutation,void (^action)(void)) { (void)owner;(void)mutation;action(); }
@interface NativeHost (NavigationFixture)
- (void)onNextChat;
- (void)onNextUnreadChat;
- (void)onLastChat;
- (void)originalNativeTraversal;
@end
@implementation NativeHost (NavigationFixture)
#include "SessionNavigationHooks.h"
- (void)originalNativeTraversal { self.nativeTraversalCalls++;self.opened=Path(1); }
@end
static NSUInteger checks,failures;
static void Check(BOOL pass,NSString *name) { checks++; if(!pass) {failures++; fprintf(stderr,"FAIL: %s\n",name.UTF8String);} }
static CSGroupProjection *Project(NSArray *rows,NSArray *tabs,NSString *tab,NSSet *hidden,NSUInteger revision,CSGroupProjection *previous) {
 return [[CSGroupProjection alloc] initWithSections:@[rows] tabs:tabs selectedTabID:tab filterDuplicates:NO accountID:account hiddenUserNames:hidden privacyRevision:revision previousProjection:previous];
}
int main(void) { @autoreleasepool {
 WESessionTabItem *all=[WESessionTabItem tabWithType:WETabTypeAll],*group=[WESessionTabItem tabWithType:WETabTypeGroup],*private=[WESessionTabItem tabWithType:WETabTypePrivate];
 WESessionTabItem *custom=[WESessionTabItem tabWithType:WETabTypeCustom]; custom.tabId=@"custom"; custom.sessionUserNames=@[@"A",@"B"];
 NSArray *tabs=@[all,group,private,custom];
 NSArray *rows=@[Row(0,@"A",CSGroupRowKindSession,CSGroupRowCategoryPrivate,9),Row(1,@"B",CSGroupRowKindSession,CSGroupRowCategoryPrivate,3),Row(2,@"C",CSGroupRowKindSession,CSGroupRowCategoryGroup,5)];
 NSSet *hidden=[NSSet setWithObject:@"A"];
 CSGroupProjection *p=Project(rows,tabs,all.tabId,hidden,1,nil);
 Check(p.isValid && p.sections[0].count==2 && [[p rowAtDisplayPath:Path(0)].nativePath isEqual:Path(1)],@"A hidden maps display 0 to native B");
 Check([p badgeForTabID:all.tabId].count==8 && [p badgeForTabID:private.tabId].count==3 && [p badgeForTabID:group.tabId].count==5 && [p badgeForTabID:custom.tabId].count==3,@"All/category/custom totals exclude A exactly once");
 Check(![p displayPathForNativePath:Path(0)] && [[p displayPathForNativePath:Path(2)] isEqual:Path(1)],@"hidden native path has no inverse mapping");
 Check(Project(rows,tabs,all.tabId,hidden,1,p)==p,@"same immutable privacy revision reuses projection");
 Check(Project(rows,tabs,all.tabId,hidden,2,p)!=p,@"revision invalidates reuse");
 CSGroupProjection *changed=Project(rows,tabs,all.tabId,[NSSet setWithObject:@"B"],1,p);
 Check(changed!=p && [[changed rowAtDisplayPath:Path(0)].userName isEqual:@"A"],@"hidden set invalidates reuse even if revision is unchanged");
 CSGroupProjection *revealed=Project(rows,tabs,all.tabId,[NSSet set],3,p);
 Check(revealed.sections[0].count==3 && [revealed badgeForTabID:all.tabId].count==17 && [[revealed rowAtDisplayPath:Path(0)].nativePath isEqual:Path(0)],@"reveal restores native paths and unread");
 Check(!Project(@[Row(1,@"A",CSGroupRowKindSession,CSGroupRowCategoryPrivate,9)],tabs,all.tabId,hidden,1,nil).isValid,@"hidden rows still undergo full nativePaths validation");
 Check(!Project(@[rows[0],Row(1,@"A",CSGroupRowKindSession,CSGroupRowCategoryPrivate,9)],tabs,all.tabId,hidden,1,nil).isValid,@"hidden duplicate native identity still rejects snapshot");
 NSArray *retained=@[Row(0,@"A",CSGroupRowKindBusiness,CSGroupRowCategoryUnknown,9),Row(1,nil,CSGroupRowKindBusiness,CSGroupRowCategoryUnknown,0),Row(2,@"chatroom_session_box",CSGroupRowKindAggregate,CSGroupRowCategoryGroup,12)];
 CSGroupProjection *r=Project(retained,tabs,custom.tabId,hidden,1,nil);
 Check(r.sections[0].count==2 && ![r rowAtDisplayPath:Path(0)].userName,@"privacy precedes retained rules; unknown anonymous business row survives");
 NSArray *services=@[Row(0,@"brandsessionholder",CSGroupRowKindAggregate,CSGroupRowCategoryService,7),Row(1,@"brandservicesessionholder",CSGroupRowKindAggregate,CSGroupRowCategoryService,4)];
 CSGroupProjection *serviceProjection=Project(services,tabs,all.tabId,[NSSet setWithObject:@"A"],1,nil);
 Check(serviceProjection.sections[0][0]==services[0] && serviceProjection.sections[0][1]==services[1] && !serviceProjection.sections[0][0].privacyMasked && serviceProjection.sections[0][1].unreadCount==4,@"locked friend never replaces native service-account containers or unread values");
 Check(![r badgeForTabID:all.tabId].redDot && ![r badgeForTabID:custom.tabId].redDot,@"unattributed aggregate unread does not leak into badges");
 Check(![r rowAtDisplayPath:Path(1)].unreadCount && [retained[2] unreadCount]==12,@"aggregate presentation neutralizes unread without changing input value");
 Check([Project(retained,tabs,custom.tabId,[NSSet set],2,r) badgeForTabID:custom.tabId].redDot,@"reveal restores aggregate native dot");
 policy=Policy(@[@"A"],NO,1);
 NativeHost *host=[NativeHost new]; host.sessions=[NSMutableArray array]; host.m_tableView=[TestTable new];
 for(NSString *name in @[@"A",@"B",@"C"]) {NativeSession *session=[NativeSession new];session.m_nsUserName=name;session.m_uUnReadCount=[name isEqual:@"A"]?9:3;[host.sessions addObject:session];}
 CSGroupListAdapter *a=[CSGroupListAdapter new]; a.controller=host;a.table=host.m_tableView;a.preferences=[Preferences new];[a refresh];
 Check([[a nativePaths:@[Path(0),Path(1),Path(8)]] isEqual:@[Path(1),Path(2)]],@"production adapter nativePaths omits invalid display paths and maps B/C");
 Check(![a displayPath:Path(0)] && [[a displayPath:Path(1)] isEqual:Path(0)],@"production inverse paths enforce current policy");
 Check([a navigatePrivateSessionsForward:YES unreadOnly:NO] && [host.opened isEqual:Path(1)],@"production next navigation opens B using native coordinate");
 a.table.indexPathForSelectedRow=Path(0);[a navigatePrivateSessionsForward:YES unreadOnly:YES];
 Check([host.opened isEqual:Path(2)],@"production next unread skips hidden A");
 [a navigatePrivateSessionsForward:NO unreadOnly:NO];Check([host.opened isEqual:Path(2)],@"production previous wraps among visible native sessions");
 policy=Policy(@[@"A",@"B"],NO,2);
 Check(![a nativePath:Path(0)] && ![a displayPath:Path(1)],@"fresh guards reject newly hidden identity before refresh");
 NativeSession *sourceA=host.sessions[0];[host.sessions exchangeObjectAtIndex:1 withObjectAtIndex:2];
 Check([[a nativePath:Path(1)] isEqual:Path(1)],@"native identity is re-resolved after reorder");
 NSUInteger calls=host.calls;appActive=NO;[a navigatePrivateSessionsForward:YES unreadOnly:NO];Check(host.calls==calls,@"background navigation cannot execute");appActive=YES;
 policy=Policy(@[@"A"],YES,3);[a refresh];Check(a.projection.sections[0].count==3 && sourceA.m_uUnReadCount==9,@"reveal restores adapter rows without touching native unread");
 policy=Policy(@[@"A"],NO,4);account=@"another-account";[a refresh];Check(!a.projection.sections.count,@"old-account policy cannot classify a new account");
 account=@"session-test-account";
 ChatBoxSessionListViewController *folded=[ChatBoxSessionListViewController new];folded.sessions=host.sessions;folded.m_tableView=[TestTable new];
 a.controller=folded;a.table=folded.m_tableView;[a refresh];
 Check(a.projection.sections[0].count==2 && [[a nativePath:Path(0)] isEqual:Path(1)],@"folded adapter reads full native source then maps visible paths");
 [folded.sessions exchangeObjectAtIndex:1 withObjectAtIndex:2];
 Check([[a nativePath:Path(0)] isEqual:Path(2)],@"folded identity resolver rescans current native coordinates");
 Check(folded.sessions.count==3 && folded.sessions[0]==sourceA && sourceA.m_uUnReadCount==9,@"folded source membership, order ownership, identity and unread remain native");
 [a refresh]; folded.nativeCell=[UITableViewCell new];
 id delivered=[a cellForDisplayPath:Path(0) target:folded];
 Check(delivered==folded.nativeCell && [folded.rendered isEqual:Path(1)],@"folded direct native cell callback receives mapped B coordinate and preserves native cell instance");
 NSInvocation *select=[NSInvocation invocationWithMethodSignature:[folded methodSignatureForSelector:@selector(tableView:didSelectRowAtIndexPath:)]];
 select.selector=@selector(tableView:didSelectRowAtIndexPath:); id table=a.table; NSIndexPath *display=Path(0);
 [select setArgument:&table atIndex:2];[select setArgument:&display atIndex:3];[a forwardInvocation:select target:folded];
 Check([folded.opened isEqual:Path(1)],@"folded direct didSelect callback receives original B coordinate through production proxy");
 NSInvocation *count=[NSInvocation invocationWithMethodSignature:[folded methodSignatureForSelector:@selector(tableView:numberOfRowsInSection:)]];
 count.selector=@selector(tableView:numberOfRowsInSection:);NSInteger section=0;
 [count setArgument:&table atIndex:2];[count setArgument:&section atIndex:3];[a forwardInvocation:count target:folded];NSInteger visible=0;[count getReturnValue:&visible];
 Check(visible==2 && [folded tableView:a.table numberOfRowsInSection:0]==3,@"folded proxy count filters display only while direct native source count remains three");
 policy=Policy(@[@"A",@"B"],NO,5); calls=folded.calls;
 [select setArgument:&display atIndex:3];[a forwardInvocation:select target:folded];
 Check(folded.calls==calls,@"new policy rejects stale displayed folded selection before publication");
 Check(CSGroupAssessFoldedUserNames(nil,hidden)==CSGroupFoldedPrivacyUnknown && CSGroupAssessFoldedUserNames(@[],hidden)==CSGroupFoldedPrivacyUnknown,@"unavailable and empty folded sources cannot prove all-hidden");
 Check(CSGroupAssessFoldedUserNames(@[@"A",@""],hidden)==CSGroupFoldedPrivacyUnknown,@"unknown child identity prevents all-hidden inference");
 Check(CSGroupAssessFoldedUserNames(@[@"B",@"C"],hidden)==CSGroupFoldedPrivacyNoHidden && CSGroupAssessFoldedUserNames(@[@"A",@"B"],hidden)==CSGroupFoldedPrivacyMixed && CSGroupAssessFoldedUserNames(@[@"A"],hidden)==CSGroupFoldedPrivacyAllHidden,@"folded assessment distinguishes no-hidden, mixed, and all-confirmed-hidden");
 ChatBoxMgr *manager=[ChatBoxMgr new];foldedService=manager;manager.sourceSessions=@[sourceA,folded.sessions[1]];
 NativeSession *aggregate=[NativeSession new];aggregate.m_nsUserName=@"chatroom_session_box";aggregate.m_uUnReadCount=12;
 NativeHost *main=[NativeHost new];main.m_tableView=[TestTable new];main.sessions=[NSMutableArray arrayWithObject:aggregate];a.controller=main;a.table=main.m_tableView;
 policy=Policy(@[@"A"],NO,6);[a refresh];
 Check(a.projection.sections[0].count==1 && a.projection.sections[0][0].privacyMasked && ![a.projection badgeForTabID:@"preset_0"].redDot,@"verified mixed folded children retain neutral entry without private unread");
 manager.sourceSessions=@[sourceA];[a refresh];Check(a.projection.sections[0].count==0,@"all-confirmed-hidden children remove only the aggregate presentation");
 manager.sourceSessions=@[folded.sessions[1]];[a refresh];
 Check(a.projection.sections[0].count==1 && !a.projection.sections[0][0].privacyMasked && [a.projection badgeForTabID:@"preset_0"].redDot,@"verified no-hidden children preserve ordinary native aggregate preview and dot");
 manager.sourceSessions=@[[NSObject new]];[a refresh];Check(a.projection.sections[0].count==1 && a.projection.sections[0][0].privacyMasked,@"unreadable child identity retains conservative neutral entry");
 manager.sourceSessions=@[sourceA];manager.replaceEpoch=YES;[a refresh];Check(a.projection.sections.count==0,@"account epoch change during child read cannot publish its classification");
 Check(aggregate.m_uUnReadCount==12 && main.sessions.count==1 && manager.sourceSessions[0]==sourceA,@"folded assessment never mutates native aggregate, source children, or unread");
 WrongFoldedGetter *wrong=[WrongFoldedGetter new];foldedService=wrong;
 Check(CSGroupCopyFoldedUserNames()==nil && wrong.calls==0,@"unsupported scalar child getter is rejected before invocation");
 // Exercise the production hook's deferred callback across a policy transition.
 NativeHost *queuedHost=[NativeHost new];queuedHost.m_tableView=[TestTable new];queuedHost.sessions=[NSMutableArray array];
 for (NSString *name in @[@"B",@"A",@"C"]) { NativeSession *session=[NativeSession new];session.m_nsUserName=name;session.m_uUnReadCount=1;[queuedHost.sessions addObject:session]; }
 navigationAdapter=[CSGroupListAdapter new];navigationAdapter.controller=queuedHost;navigationAdapter.table=queuedHost.m_tableView;navigationAdapter.preferences=[Preferences new];
 policy=Policy(@[@"A"],YES,7);[navigationAdapter refresh];queuedHost.m_tableView.indexPathForSelectedRow=Path(0);
 [queuedHost onNextChat];BOOL queuedWhileRevealed=navigationAdapter.queuedNavigation.count==1 && queuedHost.calls==0 && queuedHost.nativeTraversalCalls==0;
 policy=Policy(@[@"A"],NO,8);
 NSArray *pending=[navigationAdapter.queuedNavigation copy];[navigationAdapter.queuedNavigation removeAllObjects];for (void (^action)(void) in pending) action();
 Check(queuedWhileRevealed && queuedHost.nativeTraversalCalls==0 && [queuedHost.opened isEqual:Path(2)],@"revealed queued next-chat rechecks lock and advances past hidden A to visible C at drain time");
 fprintf(stdout,"Close-friend sessions: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
 return failures?1:0;
} }
