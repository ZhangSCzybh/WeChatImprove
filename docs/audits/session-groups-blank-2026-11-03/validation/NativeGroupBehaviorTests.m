#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import <UIKit/UIKit.h>
#import "CSGroupNativeModel.h"
#import "CSGroupNativeSessionCoordinator.h"
#import "CSGroupNativeBridge.h"
#import "CSGroupPreferences.h"
#import "CSCloseFriendPolicy.h"
#import "CSCloseFriendBridge.h"
#import "WESessionTabItem.h"

// This executable compiles the production model, coordinator, bridge, projection,
// preferences and signature code. Only the unavailable WeChat/UIKit host is faked.
static NSUInteger Checks, Epoch=1;
static NSString *Account=@"validation-account-A";
static BOOL Suspended;
static CSCloseFriendSnapshot *Policy;
static CSGroupNativeSessionCoordinator *Coordinator;
#define CHECK(c) do { Checks++; if (!(c)) { fprintf(stderr,"FAIL %s:%d: %s\n",__FILE__,__LINE__,#c); exit(1); } } while(0)

@implementation UIView @end
@implementation UIViewController @end
@implementation UINavigationController @end
@implementation UITabBarController @end
@implementation UIWindow @end

@interface MemoryDefaults : NSUserDefaults
@property(nonatomic,strong) NSMutableDictionary *memory;
@end
@implementation MemoryDefaults
- (instancetype)init { if ((self=[super init])) _memory=[NSMutableDictionary dictionary]; return self; }
- (id)objectForKey:(NSString *)key { return self.memory[key]; }
- (BOOL)boolForKey:(NSString *)key { return [self.memory[key] boolValue]; }
- (void)setObject:(id)value forKey:(NSString *)key { self.memory[key]=value; }
- (void)removeObjectForKey:(NSString *)key { [self.memory removeObjectForKey:key]; }
- (BOOL)synchronize { return YES; }
@end
static MemoryDefaults *Defaults;
static id InMemoryDefaults(id self,SEL command) { (void)self;(void)command;return Defaults; }

@interface MMSessionInfo : NSObject
@property(nonatomic,copy) NSString *m_nsUserName;
@property(nonatomic) unsigned int m_uUnReadCount;
@property(nonatomic) BOOL m_bShowUnReadAsRedDot,isHidden,isInChatBox,isInBrandServiceBox,m_isFolding;
@property(nonatomic) BOOL isSingleChatSession,m_bIsTop;
@end
@implementation MMSessionInfo @end
@interface MainSessionInfoItem : NSObject
@property(nonatomic,strong) MMSessionInfo *mainSession;
@property(nonatomic) unsigned int mainUnReadCount;
@property(nonatomic) BOOL showAsRedDot;
@end
@implementation MainSessionInfoItem @end
@interface MainSessionMgr : NSObject
@property(nonatomic,strong) NSMutableArray *topSessions,*normalSessions,*allTopSessions;
@property(nonatomic) long long totalTopSessionCount,chatBoxMinIndex;
@property(nonatomic,copy) NSArray *hostTop,*hostNormal,*hostAllTop;
@property(nonatomic) long long hostTotal;
@property(nonatomic) NSUInteger rebuilds;
@property(nonatomic,copy) void (^onSetNormal)(void);
@property(nonatomic,copy) void (^onEnumerate)(void);
@property(nonatomic) BOOL invalidEnumerator;
@property(nonatomic) BOOL rejectNormalWrites;
- (void)rebuildMainSessions;
- (id)fixtureForwardableSessionEnumerator;
@end
@interface LazyNativeEnumerator:NSObject
@property(nonatomic,weak) MainSessionMgr *manager;
- (NSArray *)allObjects;
@end
@interface WrongNativeEnumerator:NSObject
- (NSInteger)allObjects;
@end
@implementation WrongNativeEnumerator
- (NSInteger)allObjects {return 4;}
@end
@implementation MainSessionMgr
- (void)setNormalSessions:(NSMutableArray *)value {
    if(self.rejectNormalWrites)@throw [NSException exceptionWithName:@"FixtureNormalWriteRejected" reason:@"Controlled partial setter failure" userInfo:nil];
    _normalSessions=value;
    void (^callback)(void)=self.onSetNormal; self.onSetNormal=nil;
    if(callback)callback();
}
- (void)rebuildMainSessions {
    self.rebuilds++;
    [Coordinator performNativeRebuildForManager:self original:^{
        self.topSessions=[self.hostTop mutableCopy];self.normalSessions=[self.hostNormal mutableCopy];
        self.allTopSessions=[self.hostAllTop mutableCopy];self.totalTopSessionCount=self.hostTotal;
        self.chatBoxMinIndex=42;
    }];
}
- (id)fixtureForwardableSessionEnumerator {
    void(^callback)(void)=self.onEnumerate;self.onEnumerate=nil;if(callback)callback();
    if(self.invalidEnumerator)return [WrongNativeEnumerator new];
    LazyNativeEnumerator *enumerator=[LazyNativeEnumerator new];enumerator.manager=self;return enumerator;
}
@end
@implementation LazyNativeEnumerator
- (NSArray *)allObjects {return [self.manager.topSessions arrayByAddingObjectsFromArray:self.manager.normalSessions];}
@end
@interface MMNewSessionMgr:NSObject { @public NSArray *m_arrSession; }
@end
@implementation MMNewSessionMgr @end
@interface ChatBoxMgr:NSObject
@property(nonatomic,copy) NSArray *chatBoxSessions;
@end
@implementation ChatBoxMgr @end
@interface MMContext:NSObject @end
@implementation MMContext
+ (NSString *)currentUserName { return Account; }
@end
@interface NewMainFrameViewController:NSObject
@property(nonatomic,strong) UIViewController *curViewController;
@property(nonatomic,strong) id m_tableView,m_mainFrameLogicController;
@property(nonatomic) BOOL isSearching;
@end
@implementation NewMainFrameViewController @end
static MainSessionMgr *Main;
static MMNewSessionMgr *Full;
static ChatBoxMgr *Folded;
id CSGetService(Class cls) {
    if(cls==MainSessionMgr.class)return Main;
    if(cls==MMNewSessionMgr.class)return Full;
    if(cls==ChatBoxMgr.class)return Folded;
    return nil;
}
NSString *const CSCloseFriendPolicyDidChangeNotification=@"CSCloseFriendPolicyDidChange";
CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) { return Policy; }
NSUInteger CSCloseFriendAccountEpoch(void) { return Epoch; }
BOOL CSBackupAccountIsSuspended(void) { return Suspended; }
static NSIndexPath *Path(NSUInteger row) { NSUInteger indexes[]={0,row};return [NSIndexPath indexPathWithIndexes:indexes length:2]; }
static MMSessionInfo *Session(NSString *name,unsigned int unread) {
    MMSessionInfo *s=[MMSessionInfo new];s.m_nsUserName=name;s.m_uUnReadCount=unread;
    s.isSingleChatSession=![name hasSuffix:@"@chatroom"];return s;
}
static MainSessionInfoItem *Wrap(MMSessionInfo *s,long long unread) {
    MainSessionInfoItem *item=[MainSessionInfoItem new];item.mainSession=s;item.mainUnReadCount=unread;return item;
}
static CSCloseFriendSnapshot *MakePolicy(NSArray *hidden,BOOL revealed,BOOL blocked,NSDictionary *options,NSUInteger revision) {
    return [[CSCloseFriendSnapshot alloc] initWithAccountID:Account
        profile:@{@"enabled":@YES,@"friends":hidden,@"groups":@[],@"options":options ?: @{}}
        revealed:revealed revision:revision blocked:blocked];
}
static NSArray *Tabs(void) {
    return @[[WESessionTabItem tabWithType:WETabTypeAll],[WESessionTabItem tabWithType:WETabTypeGroup],
        [WESessionTabItem tabWithType:WETabTypePrivate],[WESessionTabItem tabWithType:WETabTypeOfficial]];
}
static CSGroupNativeModelResult *Build(NSArray *top,NSArray *normal,NSArray *allTop,NSArray *all,NSString *selected,BOOL enabled,NSSet *hidden) {
    return [CSGroupNativeModel buildWithTopSessions:top normalSessions:normal allTopSessions:allTop allSessions:all
        tabs:Tabs() selectedTabID:selected groupingEnabled:enabled filterDuplicates:NO accountID:Account hiddenUserNames:hidden
        privacyRevision:Policy.revision scopeFoldedEntry:enabled foldedRows:@[]
        rowProvider:^CSGroupRow *(id s,NSIndexPath *p,BOOL isTop) { return CSGroupRowForNativeSession(s,p,isTop); }];
}
static void Select(NSString *selected) {
    CSGroupPreferences *prefs=[[CSGroupPreferences alloc] initWithDefaults:Defaults accountID:Account];
    prefs.selectedTabID=selected;
    [Coordinator refreshFromPreferences];
}
static void PublishPolicy(CSCloseFriendSnapshot *policy) {
    Policy=policy;
    [NSNotificationCenter.defaultCenter postNotificationName:CSCloseFriendPolicyDidChangeNotification object:nil];
}
static void ModelTests(void) {
    MMSessionInfo *a=Session(@"a",3),*b=Session(@"b@chatroom",7),*c=Session(@"c",11);
    // Distinct full/cache native instances with the same identity are valid;
    // each output keeps its exact input object and full-source unread wins.
    MainSessionInfoItem *wa=Wrap(Session(@"a",90),99),*wb=Wrap(Session(@"b@chatroom",90),98),*wc=Wrap(c,97);
    CSGroupNativeModelResult *m=Build(@[wa],@[wb,wc],@[wa],@[a,b,c],@"preset_1",YES,NSSet.set);
    CHECK(m.isValid);CHECK(m.topSessions.count==0);CHECK(m.normalSessions.count==1 && m.normalSessions[0]==wb);
    CHECK([m rowForSession:wb].unreadCount==7);CHECK([m rowForSession:b].unreadCount==7);
    CHECK(m.sourceRows.count==3);CHECK([m.projection badgeForTabID:@"preset_0"].count==21);
    CHECK([m.projection badgeForTabID:@"preset_2"].count==14);CHECK([m.projection badgeForTabID:@"preset_1"].count==7);
    m=Build(@[wa],@[wb,wc],nil,@[a,b,c],@"preset_1",NO,[NSSet setWithObject:@"a"]);
    CHECK(m.isValid && [m.selectedTabID isEqual:@"preset_0"]);CHECK(m.allTopSessions==nil);
    CHECK(m.normalSessions.count==2 && m.normalSessions[0]==wb && m.normalSessions[1]==wc);CHECK(m.topSessions.count==0);
    CHECK(!Build(@[wa],@[wb,wc],@[wa],@[a,a,c],@"preset_0",YES,NSSet.set).isValid);
    CHECK(!Build(@[wa],@[wa,wc],@[wa],@[a,b,c],@"preset_0",YES,NSSet.set).isValid);
    CHECK(!Build(@[wa],@[wb,wc],@[wa],@[a,Session(@"a",6)],@"preset_0",YES,NSSet.set).isValid);
    MainSessionInfoItem *other=Wrap(Session(@"a",1),1);other.mainSession.isSingleChatSession=NO;
    CHECK(!Build(@[other],@[wb,wc],@[other],@[a,b,c],@"preset_0",YES,NSSet.set).isValid);
    CHECK(wa.mainUnReadCount==99 && wb.mainUnReadCount==98);CHECK(a.m_uUnReadCount==3 && b.m_uUnReadCount==7);
}
static void CoordinatorTests(void) {
    MMSessionInfo *a=Session(@"a",3),*b=Session(@"b@chatroom",7),*c=Session(@"c",11);
    MainSessionInfoItem *wa=Wrap(Session(@"a",90),99),*wb=Wrap(Session(@"b@chatroom",90),98),*wc=Wrap(c,97);
    Main.hostTop=@[wa];Main.hostNormal=@[wb,wc];Main.hostAllTop=@[wa];Main.hostTotal=9;Full->m_arrSession=@[a,b,c];
    [Main rebuildMainSessions];CHECK(!Coordinator.boundary && Coordinator.model.isValid);
    CHECK(Main.totalTopSessionCount==9 && Main.chatBoxMinIndex==42);CHECK(Main.topSessions[0]==wa && Main.normalSessions[0]==wb);
    Select(@"preset_1");CHECK(Main.topSessions.count==0 && Main.normalSessions.count==1 && Main.normalSessions[0]==wb);
    CHECK(Coordinator.applied && Full->m_arrSession.count==3);CHECK([Coordinator.model.projection badgeForTabID:@"preset_0"].count==21);
    CHECK([Coordinator rowForSession:wb path:Path(0)].unreadCount==7);
    NSUInteger builds=Main.rebuilds;NSArray *stable=Main.normalSessions;
    [Coordinator refreshFromPreferences];CHECK(Main.rebuilds==builds && Main.normalSessions==stable);
    // A mutation for an out-of-group session must see the complete baseline,
    // including hidden/off-group native instances, before native rebuild.
    [Coordinator performNativeMutationForManager:Main original:^{
        CHECK(Main.topSessions.count==1 && Main.topSessions[0]==wa);
        CHECK(Main.normalSessions.count==2 && Main.normalSessions[1]==wc);
        c.m_uUnReadCount=13;
    }];
    CHECK(Main.normalSessions.count==1 && Main.normalSessions[0]==wb);
    CHECK([Coordinator.model.projection badgeForTabID:@"preset_0"].count==23);
    CHECK([Coordinator.model.projection badgeForTabID:@"preset_2"].count==16);
    // Switching groups reuses the complete native baseline, never the previous
    // selected manager arrays. Returning All restores host geometry/count.
    Select(@"preset_2");CHECK(Main.topSessions.count==1 && Main.topSessions[0]==wa);
    CHECK(Main.normalSessions.count==1 && Main.normalSessions[0]==wc);
    Select(@"preset_0");CHECK(Main.normalSessions.count==2 && Main.totalTopSessionCount==9 && Main.chatBoxMinIndex==42);
    PublishPolicy(MakePolicy(@[@"a"],NO,NO,nil,2));
    CHECK(!Coordinator.boundary && Main.topSessions.count==0 && Main.normalSessions.count==2);
    CHECK([Coordinator.model.projection badgeForTabID:@"preset_0"].count==20);
    PublishPolicy(MakePolicy(@[@"a"],YES,NO,nil,3));CHECK(Main.topSessions.count==1 && Main.topSessions[0]==wa && Main.totalTopSessionCount==9);
    PublishPolicy(MakePolicy(@[@"a"],NO,YES,nil,4));CHECK(Coordinator.boundary && Main.normalSessions.count==0 && Main.topSessions.count==0);
    PublishPolicy(MakePolicy(@[@"a"],NO,NO,nil,5));CHECK(!Coordinator.boundary && Main.normalSessions.count==2 && Main.topSessions.count==0);
    Select(@"preset_1");Epoch++;
    CHECK(![Coordinator rowForSession:wb path:Path(0)]);CHECK([Coordinator foldSessionCountWithNativeCount:88]==0);
    [Coordinator refreshFromPreferences];CHECK(!Coordinator.boundary && Coordinator.epoch==Epoch);
    // Identity mutation invalidates a cached baseline; never reinterpret a slot
    // belonging to the old conversation as a valid current row.
    wb.mainSession.m_nsUserName=@"changed@chatroom";
    CHECK(![Coordinator rowForSession:wb path:Path(0)]);
    wb.mainSession.m_nsUserName=@"b@chatroom";
    PublishPolicy(MakePolicy(@[@"a"],YES,NO,nil,6));Select(@"preset_2");
    // Native setters may synchronously invoke callbacks. They must see a closed
    // publication until all fields and the new policy have been revalidated.
    Main.onSetNormal=^{ CHECK(Coordinator.boundary && Coordinator.model==nil);CHECK(![Coordinator rowForSession:wb path:Path(0)]); };
    Select(@"preset_1");CHECK(!Coordinator.boundary);
    Main.onSetNormal=^{ PublishPolicy(MakePolicy(@[@"a"],NO,YES,nil,7)); };
    Select(@"preset_2");CHECK(Coordinator.boundary && Main.topSessions.count==0 && Main.normalSessions.count==0);
    CHECK(Full->m_arrSession.count==3 && Full->m_arrSession[0]==a);
    PublishPolicy(MakePolicy(@[@"a"],NO,NO,nil,8));
    [Defaults setObject:@NO forKey:@"com.wechat.enhance.chat_group.enabled"];
    [Coordinator refreshFromPreferences];CHECK(!Coordinator.boundary && Main.topSessions.count==0 && Main.normalSessions.count==2);
    PublishPolicy(MakePolicy(@[@"a"],YES,NO,nil,9));CHECK(Main.topSessions.count==1 && Main.totalTopSessionCount==9);
}

#include "NativeEnumeratorBody.h"
static void CompleteSourceTests(void) {
    [Defaults setObject:@YES forKey:@"com.wechat.enhance.chat_group.enabled"];
    Select(@"preset_1");
    PublishPolicy(MakePolicy(@[@"a"],NO,NO,@{@"hideSessions":@YES,@"hideForwarding":@NO},10));
    CHECK(Main.normalSessions.count==1 && Main.topSessions.count==0);
    __block NSUInteger entered=0;
    __block NSUInteger notifications=0;
    id observer=[NSNotificationCenter.defaultCenter addObserverForName:CSGroupNativeSessionModelDidChangeNotification object:Coordinator queue:nil usingBlock:^(NSNotification *note){(void)note;notifications++;}];
    BOOL accepted=[Coordinator performWithCompleteSourceForSurface:CSCloseFriendSurfaceSession original:^{
        entered++;CHECK(Coordinator.boundary && Coordinator.model==nil);
        CHECK(Main.topSessions.count==0 && Main.normalSessions.count==2);
        CHECK([Coordinator performWithCompleteSourceForSurface:CSCloseFriendSurfaceSession original:^{entered++;}]);
        CHECK(![Coordinator performWithCompleteSourceForSurface:CSCloseFriendSurfaceForward original:^{entered+=100;}]);
    }];
    CHECK(accepted && entered==2);CHECK(notifications==1);CHECK(!Coordinator.boundary && Main.normalSessions.count==1 && Main.topSessions.count==0);
    notifications=0;[Coordinator refreshFromPreferences];CHECK(notifications==0);
    // Forward is a separate privacy surface: hideForwarding=NO permits A in
    // the temporary complete view without changing the hidden main list.
    __block NSArray *materialized=nil;
    accepted=[Coordinator performWithCompleteSourceForSurface:CSCloseFriendSurfaceForward original:^{
        CHECK(Coordinator.boundary && Main.topSessions.count==1 && Main.normalSessions.count==2);
        NSEnumerator *lazy=[[@[Main.topSessions,Main.normalSessions] valueForKeyPath:@"@unionOfArrays.self"] objectEnumerator];
        materialized=[lazy allObjects];
    }];
    CHECK(accepted && materialized.count==3);CHECK(Main.normalSessions.count==1 && Main.topSessions.count==0);
    CHECK([materialized[0] mainSession]!=nil);
    PublishPolicy(MakePolicy(@[@"a"],NO,NO,@{@"hideSessions":@YES,@"hideForwarding":@YES},11));
    accepted=[Coordinator performWithCompleteSourceForSurface:CSCloseFriendSurfaceForward original:^{
        CHECK(Main.topSessions.count==0 && Main.normalSessions.count==2);
    }];CHECK(accepted);
    // During multi-field preparation, synchronous native setter callbacks must
    // not obtain a nested reader over a partially written temporary view.
    Main.onSetNormal=^{
        CHECK(![Coordinator performWithCompleteSourceForSurface:CSCloseFriendSurfaceForward original:^{entered+=100;}]);
        CHECK(Coordinator.boundary && Coordinator.model==nil);
    };
    accepted=[Coordinator performWithCompleteSourceForSurface:CSCloseFriendSurfaceForward original:^{entered++;}];
    CHECK(accepted && entered==3);
    BOOL caught=NO;notifications=0;
    @try { [Coordinator performWithCompleteSourceForSurface:CSCloseFriendSurfaceSession original:^{
        @throw [NSException exceptionWithName:@"NativeExpected" reason:nil userInfo:nil];
    }]; } @catch(NSException *e) {caught=[e.name isEqual:@"NativeExpected"];}
    CHECK(caught && !Coordinator.boundary && Main.normalSessions.count==1 && Main.topSessions.count==0);CHECK(notifications==1);
    accepted=[Coordinator performWithCompleteSourceForSurface:CSCloseFriendSurfaceSession original:^{
        Epoch++;
    }];CHECK(!accepted);CHECK(Coordinator.epoch==Epoch && !Coordinator.boundary && Main.normalSessions.count==1);
    accepted=[Coordinator performWithCompleteSourceForSurface:CSCloseFriendSurfaceSession original:^{
        PublishPolicy(MakePolicy(@[@"a"],NO,YES,nil,12));
    }];CHECK(!accepted && Coordinator.boundary && Main.topSessions.count==0 && Main.normalSessions.count==0);
    PublishPolicy(MakePolicy(@[@"a"],NO,NO,nil,13));
    accepted=[Coordinator performWithCompleteSourceForSurface:CSCloseFriendSurfaceSession original:^{
        ((MMSessionInfo *)Full->m_arrSession.lastObject).m_uUnReadCount=17;
        [Coordinator invalidateNativeData];
    }];CHECK(!accepted);CHECK(!Coordinator.boundary && Main.normalSessions.count==1);
    CHECK([Coordinator.model.projection badgeForTabID:@"preset_2"].count==17);
    NSString *savedAccount=Account;
    accepted=[Coordinator performWithCompleteSourceForSurface:CSCloseFriendSurfaceSession original:^{
        Account=@"validation-account-B";Epoch++;Policy=MakePolicy(@[],NO,YES,nil,14);
    }];CHECK(!accepted && Coordinator.boundary && Main.normalSessions.count==0);
    Account=savedAccount;Epoch++;PublishPolicy(MakePolicy(@[@"a"],NO,NO,nil,15));
    CHECK(!Coordinator.boundary && Main.normalSessions.count==1);
    CHECK(![Coordinator performWithCompleteSourceForSurface:CSCloseFriendSurfaceSearch original:^{entered+=100;}]);
    CHECK(entered==3);
    // An unsupported host with no managed baseline preserves its native reader;
    // this fallback is forbidden for a supported but unavailable managed source.
    MainSessionMgr *savedMain=Main;Main=nil;
    CSGroupNativeSessionCoordinator *unsupported=[CSGroupNativeSessionCoordinator new];
    accepted=[unsupported performWithCompleteSourceForSurface:CSCloseFriendSurfaceSession original:^{entered++;}];
    CHECK(accepted && entered==4);
    Suspended=YES;
    CHECK(![unsupported performWithCompleteSourceForSurface:CSCloseFriendSurfaceSession original:^{entered+=100;}]);
    Suspended=NO;Main=savedMain;
    [NSNotificationCenter.defaultCenter removeObserver:observer];
    // Execute the actual replacement block from NativeSessionGroupHooks.xm.
    // The native enumerator is deliberately lazy and reads the manager only
    // from allObjects, so it must be consumed before the group is restored.
    PublishPolicy(MakePolicy(@[@"a"],NO,NO,@{@"hideForwarding":@NO},16));
    NSEnumerator *frozen=FixtureForwardEnumerator(Main);
    CHECK(Main.normalSessions.count==1 && Main.topSessions.count==0);
    CHECK(frozen.allObjects.count==3);
    PublishPolicy(MakePolicy(@[@"a"],NO,NO,@{@"hideForwarding":@YES},17));
    CHECK([(NSEnumerator *)FixtureForwardEnumerator(Main) allObjects].count==2);
    Main.invalidEnumerator=YES;CHECK([(NSEnumerator *)FixtureForwardEnumerator(Main) allObjects].count==0);Main.invalidEnumerator=NO;
    Main.onEnumerate=^{Epoch++;};CHECK([(NSEnumerator *)FixtureForwardEnumerator(Main) allObjects].count==0);
    MainSessionMgr *separate=[MainSessionMgr new];separate.topSessions=[NSMutableArray array];separate.normalSessions=[NSMutableArray arrayWithObject:Session(@"other-manager",2)];
    CHECK([[(LazyNativeEnumerator *)FixtureForwardEnumerator(separate) allObjects] count]==1);
    accepted=[Coordinator performWithCompleteSourceForSurface:CSCloseFriendSurfaceForward original:^{
        // Install only after the complete view is ready, so this callback fires
        // while finally restores the selected group's native fields.
        Main.onSetNormal=^{PublishPolicy(MakePolicy(@[@"a"],NO,YES,nil,18));};
    }];
    CHECK(!accepted && Coordinator.boundary && Main.normalSessions.count==0);
    PublishPolicy(MakePolicy(@[@"a"],NO,NO,nil,19));CHECK(!Coordinator.boundary);
}

static void StatisticsEligibilityTests(void) {
    NSArray *represented=[Full->m_arrSession subarrayWithRange:NSMakeRange(0,3)];
    MMSessionInfo *hidden=Session(@"raw-hidden",50);hidden.isHidden=YES;
    MMSessionInfo *folded=Session(@"raw-folded@chatroom",70);folded.isInChatBox=YES;
    MMSessionInfo *brandChild=Session(@"raw-brand-child",90);brandChild.isInBrandServiceBox=YES;
    Full->m_arrSession=[represented arrayByAddingObjectsFromArray:@[hidden,folded,brandChild]];
    [Main rebuildMainSessions];
    CHECK(!Coordinator.boundary && Coordinator.model.sourceRows.count==3);
    CHECK([Coordinator.model.projection badgeForTabID:@"preset_0"].count==24);
    CHECK([Coordinator.model.projection badgeForTabID:@"preset_2"].count==17);
    CHECK([Coordinator.model rowForSession:Main.normalSessions[0]].unreadCount==7);
    // The complete host presentation owns display eligibility; contradictory
    // raw statistics can decline enhancement without erasing the main list.
    MMSessionInfo *a=represented[0];a.isHidden=YES;[Main rebuildMainSessions];CHECK(!Coordinator.boundary && Main.normalSessions.count==1);
    a.isHidden=NO;[Main rebuildMainSessions];CHECK(!Coordinator.boundary);
    NSArray *saved=Full->m_arrSession;Full->m_arrSession=nil;[Main rebuildMainSessions];
    __block BOOL entered=NO;
    CHECK(!Coordinator.boundary && Main.normalSessions.count==1);
    CHECK([Coordinator performWithCompleteSourceForSurface:CSCloseFriendSurfaceSession original:^{entered=YES;}]);
    CHECK(entered);
    Full->m_arrSession=saved;[Main rebuildMainSessions];CHECK(!Coordinator.boundary);
}

static void ExhaustPublicationBudget(MMSessionInfo *session) {
    CFRunLoopRunInMode(kCFRunLoopDefaultMode,0.02,false);
    Select(@"preset_1");
    NSUInteger builds=Main.rebuilds;
    __block NSUInteger mutations=0;
    __block __weak void (^repeatWeak)(void)=nil;
    void (^repeatingMutation)(void)=^{
        if ([[Coordinator valueForKey:@"publicationDepth"] unsignedIntegerValue]) {
            [Coordinator performNativeMutationForManager:Full original:^{session.m_uUnReadCount++;mutations++;}];
        }
        Main.onSetNormal=repeatWeak;
    };
    repeatWeak=repeatingMutation;Main.onSetNormal=repeatingMutation;
    Select(@"preset_2");
    CFRunLoopRunInMode(kCFRunLoopDefaultMode,0.05,false);
    CHECK(mutations>=4 && Main.rebuilds==builds+3);
    CHECK(Coordinator.boundary && Coordinator.model==nil && [[Coordinator valueForKey:@"dirty"] boolValue]);
    CHECK([[Coordinator valueForKey:@"publicationRecoveryAttempts"] unsignedIntegerValue]==3);
    NSUInteger stoppedBuilds=Main.rebuilds,stoppedMutations=mutations;
    CFRunLoopRunInMode(kCFRunLoopDefaultMode,0.02,false);
    for (NSUInteger i=0;i<5;i++) [Coordinator refreshFromPreferences];
    CHECK(Main.rebuilds==stoppedBuilds && mutations==stoppedMutations && Coordinator.boundary);
    Main.onSetNormal=nil;
}

static void ReentrantPublicationTests(void) {
    // The scope return must be revalidated after its restoration notification:
    // a synchronous observer can change Forward policy before the frozen
    // candidate list is handed back to its caller.
    PublishPolicy(MakePolicy(@[@"a"],NO,NO,@{@"hideForwarding":@NO},100));
    Select(@"preset_1");
    __block BOOL notified=NO;
    id observer=[NSNotificationCenter.defaultCenter addObserverForName:CSGroupNativeSessionModelDidChangeNotification
        object:Coordinator queue:nil usingBlock:^(NSNotification *note) {
        (void)note;
        if (!notified) {
            notified=YES;
            PublishPolicy(MakePolicy(@[@"a"],NO,NO,@{@"hideForwarding":@YES},101));
        }
    }];
    CHECK([(NSEnumerator *)FixtureForwardEnumerator(Main) allObjects].count==0);
    CHECK(notified && [Policy hidesUserName:@"a" surface:CSCloseFriendSurfaceForward]);
    [NSNotificationCenter.defaultCenter removeObserver:observer];

    // Reentrant host updates during publication may complete synchronously or
    // leave a closed pending boundary, but must never publish the model that
    // was computed before the real native source changed.
    PublishPolicy(MakePolicy(@[],NO,NO,nil,102));Select(@"preset_1");
    MMSessionInfo *a=Full->m_arrSession[0],*c=Full->m_arrSession[2];
    unsigned int previous=c.m_uUnReadCount;
    Main.onSetNormal=^{
        [Coordinator performNativeMutationForManager:Main original:^{c.m_uUnReadCount=previous+100;}];
    };
    Select(@"preset_2");
    NSUInteger expected=(NSUInteger)a.m_uUnReadCount+c.m_uUnReadCount;
    CHECK(c.m_uUnReadCount==previous+100);
    CHECK(Coordinator.boundary || [Coordinator.model.projection badgeForTabID:@"preset_2"].count==expected);
    if (Coordinator.boundary) CHECK(Coordinator.model==nil);
    [Coordinator refreshFromPreferences];
    CHECK(!Coordinator.boundary && [Coordinator.model.projection badgeForTabID:@"preset_2"].count==expected);

    [Main rebuildMainSessions];previous=c.m_uUnReadCount;
    [Coordinator performNativeRebuildForManager:Main original:^{
        Main.topSessions=[Main.hostTop mutableCopy];Main.normalSessions=[Main.hostNormal mutableCopy];
        Main.allTopSessions=[Main.hostAllTop mutableCopy];Main.totalTopSessionCount=Main.hostTotal;
        // Register only after native rebuild has written its arrays, so the
        // callback fires in applyBaseline after capture, not in the original.
        Main.onSetNormal=^{
            [Coordinator performNativeMutationForManager:Full original:^{c.m_uUnReadCount=previous+100;}];
        };
    }];
    expected=(NSUInteger)a.m_uUnReadCount+c.m_uUnReadCount;
    CHECK(c.m_uUnReadCount==previous+100);
    CHECK(Coordinator.boundary || [Coordinator.model.projection badgeForTabID:@"preset_2"].count==expected);
    if (Coordinator.boundary) CHECK(Coordinator.model==nil);
    [Coordinator refreshFromPreferences];
    CHECK(!Coordinator.boundary && [Coordinator.model.projection badgeForTabID:@"preset_2"].count==expected);

    // A mutation inside the native rebuild's original implementation belongs
    // to that source update; its latest value is captured without manufacturing
    // a publication conflict or spending the automatic recovery budget.
    previous=c.m_uUnReadCount;
    [Coordinator performNativeRebuildForManager:Main original:^{
        [Coordinator performNativeMutationForManager:Full original:^{c.m_uUnReadCount=previous+1;}];
        Main.topSessions=[Main.hostTop mutableCopy];Main.normalSessions=[Main.hostNormal mutableCopy];
        Main.allTopSessions=[Main.hostAllTop mutableCopy];Main.totalTopSessionCount=Main.hostTotal;
    }];
    expected=(NSUInteger)a.m_uUnReadCount+c.m_uUnReadCount;
    CHECK(!Coordinator.boundary && ![[Coordinator valueForKey:@"dirty"] boolValue]);
    CHECK(c.m_uUnReadCount==previous+1 && [Coordinator.model.projection badgeForTabID:@"preset_2"].count==expected);

    // Every attempted publication can itself trigger another real update.
    // Recovery must exhaust a bounded queue budget, retain a closed pending
    // boundary, and wait for a later genuine source event without spinning.
    ExhaustPublicationBudget(c);
    // A genuine event arriving off main must reset the exhausted budget after
    // hopping to main; simply setting dirty would keep the source closed.
    dispatch_semaphore_t backgroundDone=dispatch_semaphore_create(0);
    [NSThread detachNewThreadWithBlock:^{ @autoreleasepool {
        c.m_uUnReadCount++;[Coordinator invalidateNativeData];dispatch_semaphore_signal(backgroundDone);
    } }];
    CHECK(dispatch_semaphore_wait(backgroundDone,dispatch_time(DISPATCH_TIME_NOW,NSEC_PER_SEC))==0);
    CFRunLoopRunInMode(kCFRunLoopDefaultMode,0.05,false);
    expected=(NSUInteger)a.m_uUnReadCount+c.m_uUnReadCount;
    CHECK(!Coordinator.boundary && [Coordinator.model.projection badgeForTabID:@"preset_2"].count==expected);
    CHECK(![[Coordinator valueForKey:@"dirty"] boolValue]);

    // Epoch/account/manager can change without a clear or policy notification.
    // Old recovery exhaustion must never suppress loading the new boundary.
    ExhaustPublicationBudget(c);Epoch++;
    [Coordinator refreshFromPreferences];
    CHECK(!Coordinator.boundary && Coordinator.epoch==Epoch && Coordinator.model.isValid);
    ExhaustPublicationBudget(c);
    NSString *savedAccount=Account;Account=@"validation-budget-account-B";Policy=MakePolicy(@[],NO,NO,nil,103);
    [Coordinator refreshFromPreferences];
    CHECK(!Coordinator.boundary && [Coordinator.accountID isEqual:Account] && Coordinator.model.isValid);
    ExhaustPublicationBudget(c);
    MainSessionMgr *savedMain=Main,*replacement=[MainSessionMgr new];
    replacement.hostTop=Main.hostTop;replacement.hostNormal=Main.hostNormal;
    replacement.hostAllTop=Main.hostAllTop;replacement.hostTotal=Main.hostTotal;Main=replacement;
    [Coordinator refreshFromPreferences];
    CHECK(!Coordinator.boundary && Coordinator.model.isValid && Main.rebuilds==1);
    CHECK([[Coordinator valueForKey:@"publicationRecoveryAttempts"] unsignedIntegerValue]==0);
    Main=savedMain;Account=savedAccount;Policy=MakePolicy(@[],NO,NO,nil,104);
    [Coordinator refreshFromPreferences];CHECK(!Coordinator.boundary && Coordinator.model.isValid);
}

#include "AdapterBehaviorFixture.h"
#include "BlankRegressionFixture.h"

int main(void) { @autoreleasepool {
    Defaults=[MemoryDefaults new];
    Method standard=class_getClassMethod(NSUserDefaults.class,@selector(standardUserDefaults));
    IMP original=method_setImplementation(standard,(IMP)InMemoryDefaults);
    Policy=MakePolicy(@[],NO,NO,nil,1);
    Main=[MainSessionMgr new];Full=[MMNewSessionMgr new];Folded=[ChatBoxMgr new];Folded.chatBoxSessions=@[];
    Coordinator=[CSGroupNativeSessionCoordinator sharedCoordinator];
    [Coordinator setMainController:[NewMainFrameViewController new]];
    // Keep the native owner alive: the coordinator intentionally owns it weakly.
    NewMainFrameViewController *owner=[NewMainFrameViewController new];[Coordinator setMainController:owner];
    [Defaults setObject:@YES forKey:@"com.wechat.enhance.chat_group.enabled"];
    ModelTests();CoordinatorTests();CompleteSourceTests();StatisticsEligibilityTests();AdapterTests(owner);SchedulingTests();ReentrantPublicationTests();
    BridgeRepresentationTests();NativeAvailabilityRegressionTests();HandoffIntegrityRegressionTests();CompatibilityFallbackRegressionTests(owner);
    method_setImplementation(standard,original);
    printf("Native model/coordinator/adapter/scheduling: %lu behavior checks passed\n",(unsigned long)Checks);
    (void)owner;
} return 0; }
