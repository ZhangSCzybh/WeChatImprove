#import <Foundation/Foundation.h>
#import <objc/message.h>
#import <objc/runtime.h>
#import "CSCloseFriendPolicy.h"
#import "CSCloseFriendSignatures.h"
#import "CSGroupProjection.h"
#import "WESessionTabItem.h"
#include "TabBadgeDecisionInterface.inc"
#include "TabBadgeDecisionImplementation.inc"
#include "TabBadgeSourceNotification.inc"

// Foundation host boundaries only: policy/account ownership, immutable rows,
// adapter state, controller identities and observable native setter effects.
// Production decision/getter, projection, output helpers and hook blocks run as-is.
static NSUInteger Checks,Epoch=23;
static NSString *CaseName,*CurrentAccount=@"tab-account";
static CSCloseFriendSnapshot *Policy;
static NSHashTable *Owners,*TabOwners;
static NSArray *FoldedNames;
static void (^NativeReentry)(void),(^NativeReadReentry)(void),(^NativePersistentReentry)(void);
static BOOL NativeThrows;
static void BeforeNativeUIWrite(void){void(^callback)(void)=NativeReentry;NativeReentry=nil;if(callback)callback();if(NativePersistentReentry)NativePersistentReentry();}
#define CHECK(c) do{Checks++;if(!(c)){fprintf(stderr,"FAIL %d [%s]: %s\n",__LINE__,CaseName.UTF8String,#c);exit(1);}}while(0)
static CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void){return Policy;}
static NSUInteger CSCloseFriendAccountEpoch(void){return Epoch;}
static NSString *CSGroupCurrentAccountID(void){return CurrentAccount;}
static NSHashTable *Adapters(void){return Owners;}
static BOOL CSGroupIsFoldedController(id owner){return [owner isEqual:@"folded"];}
typedef NS_ENUM(NSUInteger,CSGroupFoldedPrivacyState){CSGroupFoldedPrivacyUnknown,CSGroupFoldedPrivacyNoHidden,CSGroupFoldedPrivacyMixed,CSGroupFoldedPrivacyAllHidden};
static NSArray *CSGroupCopyFoldedUserNames(void){return FoldedNames;}
static CSGroupFoldedPrivacyState CSGroupAssessFoldedUserNames(NSArray *names,NSSet *hidden){(void)names;(void)hidden;return CSGroupFoldedPrivacyUnknown;}
static id CSCloseFriendRead(id owner,NSString *key){@try{return [owner valueForKey:key];}@catch(__unused NSException *e){return nil;}}
@interface CSGroupListAdapter:NSObject
@property(nonatomic,strong) id controller;
@property(nonatomic,copy) NSArray *cachedNativeSections,*tabAlertBadgeKey,*tabBadgeSections,*tabBadgePublishedKey;
@property(nonatomic,copy) NSString *tabBadgeAccount;
@property(nonatomic) NSUInteger tabBadgeRevision,tabBadgeEpoch;
@property(nonatomic) BOOL tabBadgeSourceRequired,tabBadgeRestorePending,tabBadgeSourceScheduled,tabBadgeSourceRefreshing,tabBadgeRequestDispatchPending,tabBadgeRefreshAgain;
@property(nonatomic,strong) CSGroupBadge *tabAlertBadge;
@property(nonatomic) NSUInteger changeDepth,snapshotRevision,modelRevision,snapshotEpoch;
@property(nonatomic) BOOL dirty;
@property(nonatomic,copy) NSString *snapshotAccount;
@property(nonatomic) BOOL usesNativeSessionModel;
@property(nonatomic,copy) NSArray *tabBadgeScheduleKey;
+(CSGroupTabBadgeDecision *)closeFriendTabBadgeDecision;
+(CSGroupTabBadgeDecision *)closeFriendTabBadgeDecisionForPublication:(BOOL)includeNative;
+(CSGroupTabBadgeDecision *)closeFriendTabBadgeDecisionForController:(id)controller includeNative:(BOOL)includeNative;
+ (void)requestTabBadgeSourcesRefresh;
- (void)requestTabBadgeSourceRefresh;
- (void)publishTabBadgeSourceFinished:(BOOL)finished;
@end
@implementation CSGroupListAdapter
#include "TabBadgeGetter.inc"
// Synthetic readiness publication boundary for focused Hook tests only.
// The complete production begin/end/source-refresh/notifier runs separately in
// GroupLifecycleTests; no lifecycle behavior is inferred from this helper.
+ (void)requestTabBadgeSourcesRefresh {}
- (void)requestTabBadgeSourceRefresh {}
- (void)publishTabBadgeSourceFinished:(BOOL)finished {
    if(!finished || !self.tabAlertBadge || self.dirty || self.changeDepth || CSGroupIsFoldedController(self.controller))return;
    CSGroupTabBadgeDecision *d=[CSGroupListAdapter closeFriendTabBadgeDecisionForController:self.controller includeNative:YES];
    if(d.badge && d.sourceController==self.controller)[NSNotificationCenter.defaultCenter postNotificationName:CSGroupTabBadgeSourceDidRefreshNotification object:self];
}
@end

@interface TabNativeLogic:NSObject
@property(nonatomic) unsigned int nativeTotal;
@property(nonatomic) NSUInteger reads;
- (unsigned int)getTotalUnreadCount;
@end
@implementation TabNativeLogic
- (unsigned int)getTotalUnreadCount{self.reads++;unsigned int value=self.nativeTotal;void(^callback)(void)=NativeReadReentry;NativeReadReentry=nil;if(callback)callback();return value;}
@end
@interface TabWrongNativeLogic:NSObject
@property(nonatomic) NSUInteger reads;
- (unsigned long long)getTotalUnreadCount;
@end
@implementation TabWrongNativeLogic
- (unsigned long long)getTotalUnreadCount{self.reads++;return 999;}
@end
@interface NewMainFrameViewController:NSObject
@property(nonatomic,strong) TabNativeLogic *m_mainFrameLogicController;
@end
@interface UINavigationController:NSObject
@property(nonatomic,copy) NSArray *viewControllers;
@end
@implementation UINavigationController @end
@interface TabNativeBadge:NSObject
@property(nonatomic) unsigned long long count;
@property(nonatomic,strong) NSString *string;
@property(nonatomic) BOOL hidden,dot;
@property(nonatomic) NSRect fixtureFrame;
@end
@implementation TabNativeBadge @end
@interface TabNativeItem:NSObject
@property(nonatomic,strong) TabNativeBadge *badgeView;
@end
@implementation TabNativeItem @end
@interface TabNativeBar:NSObject
@property(nonatomic,copy) NSArray<TabNativeItem *> *tabBarItemViews;
- (id)tabBarItemViewAtIndex:(unsigned long long)index;
@end
@implementation TabNativeBar
- (id)tabBarItemViewAtIndex:(unsigned long long)index{return index<self.tabBarItemViews.count?self.tabBarItemViews[index]:nil;}
@end
@interface TabNativeController:NSObject
@property(nonatomic,copy) NSArray *viewControllers;
@property(nonatomic,strong) TabNativeBar *tabBar,*customTabBar;
@property(nonatomic,strong) NSMutableArray *events;
- (void)setTabBarBadgeValue:(unsigned long long)count forIndex:(unsigned long long)index;
- (void)setTabBarBadgeString:(id)string forIndex:(unsigned long long)index;
- (void)showRedDotOnTabBarItemAtIndex:(unsigned long long)index;
@end
@implementation TabNativeController
- (void)setTabBarBadgeValue:(unsigned long long)count forIndex:(unsigned long long)index{
    [self.events addObject:@{@"kind":@"number",@"value":@(count),@"index":@(index)}];
    if(NativeThrows)[NSException raise:@"NativeFixtureThrow" format:@"controlled native failure"];
    BeforeNativeUIWrite();
    TabNativeBadge *b=(self.customTabBar?:self.tabBar).tabBarItemViews[index].badgeView;b.count=count;b.string=nil;b.dot=NO;b.hidden=count==0;
}
- (void)setTabBarBadgeString:(id)string forIndex:(unsigned long long)index{
    [self.events addObject:@{@"kind":@"string",@"value":string?:NSNull.null,@"index":@(index)}];
    BeforeNativeUIWrite();
    TabNativeBadge *b=(self.customTabBar?:self.tabBar).tabBarItemViews[index].badgeView;
    // Native nil/empty-string hides before changing the cached content fields.
    if(![string length]){b.hidden=YES;return;}b.string=string;b.hidden=NO;b.dot=NO;
}
- (void)showRedDotOnTabBarItemAtIndex:(unsigned long long)index{
    [self.events addObject:@{@"kind":@"dot",@"index":@(index)}];
    BeforeNativeUIWrite();
    // Model native showSmallRedDot's externally visible unread-count/string
    // reset; the host stores these effects on its badge rather than its item.
    TabNativeBadge *b=(self.customTabBar?:self.tabBar).tabBarItemViews[index].badgeView;b.count=0;b.hidden=NO;b.dot=YES;b.string=nil;
}
@end
@implementation NewMainFrameViewController
@end
#include "TabBadgeChatTab.inc"
#include "TabBadgeOutput.inc"
static IMP tab,tabString,dot;
static void InstallHooks(void){
    Method number=class_getInstanceMethod(TabNativeController.class,@selector(setTabBarBadgeValue:forIndex:));
    Method string=class_getInstanceMethod(TabNativeController.class,@selector(setTabBarBadgeString:forIndex:));
    Method point=class_getInstanceMethod(TabNativeController.class,@selector(showRedDotOnTabBarItemAtIndex:));
    tab=method_getImplementation(number);tabString=method_getImplementation(string);dot=method_getImplementation(point);
    id n=
#include "TabBadgeNumeric.inc"
    ;id s=
#include "TabBadgeString.inc"
    ;id d=
#include "TabBadgeDot.inc"
    ;method_setImplementation(number,imp_implementationWithBlock(n));method_setImplementation(string,imp_implementationWithBlock(s));method_setImplementation(point,imp_implementationWithBlock(d));
#include "TabBadgeSourceObserver.inc"
}
static CSCloseFriendSnapshot *MakePolicy(NSArray *friends,NSArray *groups,BOOL enabled,BOOL revealed,BOOL blocked,NSDictionary *options,NSUInteger revision){
    return [[CSCloseFriendSnapshot alloc]initWithAccountID:CurrentAccount profile:@{@"enabled":@(enabled),@"friends":friends,@"groups":groups,@"options":options?:@{}} revealed:revealed revision:revision blocked:blocked];
}
static void Reset(NSString *name){
    CaseName=name;Epoch=23;CurrentAccount=@"tab-account";FoldedNames=nil;NativeReentry=nil;NativeReadReentry=nil;NativePersistentReentry=nil;NativeThrows=NO;
    Owners=[NSHashTable hashTableWithOptions:NSPointerFunctionsStrongMemory];TabOwners=[NSHashTable weakObjectsHashTable];
    Policy=MakePolicy(@[@"protected"],@[],YES,NO,NO,nil,41);
}
static CSGroupRow *Row(NSUInteger index,NSString *name,NSUInteger unread,BOOL asDot){NSUInteger p[]={0,index};return [[CSGroupRow alloc]initWithNativePath:[NSIndexPath indexPathWithIndexes:p length:2] userName:name kind:CSGroupRowKindSession category:CSGroupRowCategoryPrivate top:NO unreadCount:unread redDot:asDot];}
static CSGroupListAdapter *Adapter(NSArray *rows){
    CSGroupListAdapter *a=[CSGroupListAdapter new];a.controller=@"main";a.cachedNativeSections=@[rows];a.snapshotAccount=CurrentAccount;a.snapshotEpoch=Epoch;a.modelRevision=a.snapshotRevision=17;[Owners addObject:a];return a;
}
static TabNativeController *Owner(void){
    TabNativeController *o=[TabNativeController new];o.events=[NSMutableArray array];o.tabBar=[TabNativeBar new];NSMutableArray *items=[NSMutableArray array];
    for(NSUInteger i=0;i<5;i++){TabNativeItem *item=[TabNativeItem new];item.badgeView=[TabNativeBadge new];item.badgeView.count=10;item.badgeView.fixtureFrame=NSMakeRect(32,4,24,16);[items addObject:item];}
    o.tabBar.tabBarItemViews=items;NewMainFrameViewController *root=[NewMainFrameViewController new];root.m_mainFrameLogicController=[TabNativeLogic new];root.m_mainFrameLogicController.nativeTotal=10;
    UINavigationController *nav=[UINavigationController new];nav.viewControllers=@[root];o.viewControllers=@[[NSObject new],[NSObject new],nav,[NSObject new],[NSObject new]];
    for(CSGroupListAdapter *a in Owners.allObjects)if([a.controller isEqual:@"main"])a.controller=root;
    CHECK(ChatTab(o,2));CHECK(!ChatTab(o,0));CHECK(!ChatTab(o,5));return o;
}
static TabNativeBadge *Badge(TabNativeController *o){return (o.customTabBar?:o.tabBar).tabBarItemViews[2].badgeView;}
static NewMainFrameViewController *Root(TabNativeController *o){return [o.viewControllers[2] viewControllers].firstObject;}
static void Expect(TabNativeController *o,NSString *kind,id value){
    if(o.events.count!=1)fprintf(stderr,"Expected one %s event, actual %s\n",kind.UTF8String,o.events.description.UTF8String);CHECK(o.events.count==1);CHECK([o.events[0][@"kind"] isEqual:kind]);if(value)CHECK([o.events[0][@"value"] isEqual:value]);CHECK([o.events[0][@"index"] isEqual:@2]);
}
static void ExpectSafeClear(TabNativeController *o){
    CHECK(o.events.count>0);for(NSDictionary *event in o.events){CHECK([event[@"kind"] isEqual:@"string"]);CHECK(event[@"value"]==NSNull.null);CHECK([event[@"index"] isEqual:@2]);}
}
static void Stable(TabNativeController *o,TabNativeBadge *original){CHECK(Badge(o)==original);CHECK(NSEqualRects(original.fixtureFrame,NSMakeRect(32,4,24,16)));}
static void PassthroughChecks(void){
    for(NSNumber *enabled in @[@NO,@YES])for(NSNumber *revealed in @[@NO,@YES]){
        Reset(@"empty-list-arbitrary-native-input");Policy=MakePolicy(@[],@[],enabled.boolValue,revealed.boolValue,NO,nil,41);TabNativeController *o=Owner();TabNativeBadge *b=Badge(o);
        CHECK(![CSGroupListAdapter closeFriendTabBadgeDecision]);
        for(NSNumber *n in @[@0,@1,@10,@99,@100,@(ULLONG_MAX)]){[o.events removeAllObjects];[o setTabBarBadgeValue:n.unsignedLongLongValue forIndex:2];Expect(o,@"number",n);Stable(o,b);}
        for(id value in @[NSNull.null,@"",@"0",@"12",@"99+",@"arbitrary-native-text"]){NSString *s=value==NSNull.null?nil:value;[o.events removeAllObjects];[o setTabBarBadgeString:s forIndex:2];Expect(o,@"string",value);if(s.length)CHECK(Badge(o).string==s);Stable(o,b);}
        [o.events removeAllObjects];[o showRedDotOnTabBarItemAtIndex:2];Expect(o,@"dot",nil);CHECK(b.dot && !b.hidden && b.count==0 && !b.string);
    }
    Reset(@"non-chat-and-fifth-tab-pass-through");Adapter(@[Row(0,@"protected",3,NO),Row(1,@"ordinary",7,NO)]);TabNativeController *o=Owner();
    for(NSNumber *i in @[@0,@1,@3,@4]){[o.events removeAllObjects];[o setTabBarBadgeValue:99 forIndex:i.unsignedLongLongValue];CHECK(o.events.count==1 && [o.events[0][@"value"] isEqual:@99]);}
    for(NSUInteger stage=0;stage<3;stage++){
        if(stage==0)o.viewControllers=@[];else if(stage==1)o.viewControllers=@[[NSObject new],[NSObject new],[NSObject new]];else{UINavigationController *n=[UINavigationController new];n.viewControllers=@[[NSObject new]];o.viewControllers=@[[NSObject new],[NSObject new],n];}
        [o.events removeAllObjects];[o setTabBarBadgeValue:12 forIndex:2];Expect(o,@"number",@12);
    }
}
static void ReadyAndRevealChecks(void){
    Reset(@"hidden-native10-protected3-keeps7");CSGroupListAdapter *a=Adapter(@[Row(0,@"protected",3,NO),Row(1,@"ordinary",7,NO)]);TabNativeController *o=Owner();TabNativeBadge *b=Badge(o);
    CSGroupTabBadgeDecision *d=[CSGroupListAdapter closeFriendTabBadgeDecision];CHECK(d.badge.count==7 && !d.badge.redDot && !d.boundary);CHECK([d.accountID isEqual:CurrentAccount] && d.epoch==Epoch && d.policyRevision==Policy.revision && d.sourceController==Root(o));
    [o setTabBarBadgeValue:10 forIndex:2];Expect(o,@"number",@7);CHECK(b.count==7 && !b.hidden);Stable(o,b);
    [o.events removeAllObjects];[o setTabBarBadgeString:@"99+" forIndex:2];CHECK(!o.events.count && b.count==7 && !b.hidden);
    [o.events removeAllObjects];[o showRedDotOnTabBarItemAtIndex:2];CHECK(!o.events.count && b.count==7 && !b.hidden);
    CSGroupBadge *cached=a.tabAlertBadge;CHECK([CSGroupListAdapter closeFriendTabBadgeDecision].badge==cached);
    CHECK(((CSGroupRow *)a.cachedNativeSections[0][0]).unreadCount==3);
    Policy=MakePolicy(@[@"protected"],@[],YES,YES,NO,@{@"silenceMessages":@YES},42);CHECK(![CSGroupListAdapter closeFriendTabBadgeDecision] && !Policy.options[@"silenceMessages"]);
    [o.events removeAllObjects];[o setTabBarBadgeValue:10 forIndex:2];Expect(o,@"number",@10);
    [o.events removeAllObjects];CSPublishChatTabBadges();CHECK(!o.events.count && b.count==10 && !b.hidden && !Root(o).m_mainFrameLogicController.reads);Stable(o,b);
    Policy=MakePolicy(@[@"protected"],@[],YES,NO,NO,@{@"hideSessions":@NO,@"silenceMessages":@YES},43);CHECK(![CSGroupListAdapter closeFriendTabBadgeDecision]);
    [o.events removeAllObjects];[o setTabBarBadgeString:@"99+" forIndex:2];Expect(o,@"string",@"99+");CHECK([b.string isEqual:@"99+"]);
    Policy=MakePolicy(@[@"protected"],@[],NO,NO,NO,nil,44);CHECK(![CSGroupListAdapter closeFriendTabBadgeDecision]);
    Reset(@"hidden-dot-mode-contribution-not-subtracted-twice");Adapter(@[Row(0,@"protected",3,YES),Row(1,@"ordinary",10,NO)]);o=Owner();[o setTabBarBadgeValue:10 forIndex:2];Expect(o,@"number",@10);
    Reset(@"hidden-group-contribution-and-revealed-native-badge");Policy=MakePolicy(@[],@[@"protected@chatroom"],YES,NO,NO,nil,41);Adapter(@[Row(0,@"protected@chatroom",3,NO),Row(1,@"ordinary",7,NO)]);o=Owner();[o setTabBarBadgeValue:10 forIndex:2];Expect(o,@"number",@7);Policy=MakePolicy(@[],@[@"protected@chatroom"],YES,YES,NO,@{@"silenceMessages":@YES},42);CHECK(![CSGroupListAdapter closeFriendTabBadgeDecision]);[o.events removeAllObjects];[o setTabBarBadgeString:@"99+" forIndex:2];Expect(o,@"string",@"99+");
    Reset(@"ordinary-pure-dot-survives-filter");Adapter(@[Row(0,@"protected",3,NO),Row(1,@"ordinary",2,YES)]);o=Owner();b=Badge(o);d=[CSGroupListAdapter closeFriendTabBadgeDecision];CHECK(d.badge && !d.badge.count && d.badge.redDot);
    [o setTabBarBadgeValue:0 forIndex:2];Expect(o,@"dot",nil);CHECK(b.dot && !b.hidden && b.count==0 && !b.string);Stable(o,b);
    Reset(@"genuine-filtered-zero-is-numeric-zero");Adapter(@[Row(0,@"protected",3,YES),Row(1,@"ordinary",0,YES)]);o=Owner();d=[CSGroupListAdapter closeFriendTabBadgeDecision];CHECK(d.badge && !d.badge.count && !d.badge.redDot);[o showRedDotOnTabBarItemAtIndex:2];Expect(o,@"number",@0);CHECK(Badge(o).hidden);
}
static void PendingChecks(void){
    for(NSString *reason in @[@"no-cache",@"dirty",@"depth",@"revision",@"epoch",@"no-owner"]){
        Reset([@"pending-holds-same-boundary-" stringByAppendingString:reason]);CSGroupListAdapter *a=Adapter(@[Row(0,@"protected",3,NO),Row(1,@"ordinary",7,NO)]);TabNativeController *o=Owner();TabNativeBadge *b=Badge(o);[o setTabBarBadgeValue:10 forIndex:2];Expect(o,@"number",@7);[o.events removeAllObjects];
        if([reason isEqual:@"no-cache"])a.cachedNativeSections=nil;else if([reason isEqual:@"dirty"])a.dirty=YES;else if([reason isEqual:@"depth"])a.changeDepth=1;else if([reason isEqual:@"revision"])a.snapshotRevision--;else if([reason isEqual:@"epoch"])a.snapshotEpoch--;else [Owners removeAllObjects];
        CSGroupTabBadgeDecision *d=[CSGroupListAdapter closeFriendTabBadgeDecision];CHECK(d && !d.badge && !d.boundary);
        [o setTabBarBadgeValue:10 forIndex:2];[o setTabBarBadgeString:@"99+" forIndex:2];[o showRedDotOnTabBarItemAtIndex:2];CHECK(!o.events.count && b.count==7 && !b.hidden);Stable(o,b);
    }
    for(NSString *change in @[@"new-policy",@"new-epoch",@"account-boundary",@"blocked",@"new-root",@"new-item",@"new-badge",@"no-stamp"]){
        Reset([@"pending-invalidates-untrusted-display-" stringByAppendingString:change]);CSGroupListAdapter *a=Adapter(@[Row(0,@"protected",3,NO),Row(1,@"ordinary",7,NO)]);TabNativeController *o=Owner();
        if(![change isEqual:@"no-stamp"])[o setTabBarBadgeValue:10 forIndex:2];[o.events removeAllObjects];a.dirty=YES;
        if([change isEqual:@"new-policy"])Policy=MakePolicy(@[@"protected"],@[],YES,NO,NO,nil,42);
        else if([change isEqual:@"new-epoch"])Epoch++;
        else if([change isEqual:@"account-boundary"])CurrentAccount=@"different-current-account";
        else if([change isEqual:@"blocked"])Policy=MakePolicy(@[],@[],NO,NO,YES,nil,42);
        else if([change isEqual:@"new-root"]){NewMainFrameViewController *r=[NewMainFrameViewController new];r.m_mainFrameLogicController=[TabNativeLogic new];UINavigationController *n=o.viewControllers[2];n.viewControllers=@[r];}
        else if([change isEqual:@"new-item"]){NSMutableArray<TabNativeItem *> *items=[o.tabBar.tabBarItemViews mutableCopy];TabNativeItem *i=[TabNativeItem new];i.badgeView=items[2].badgeView;items[2]=i;o.tabBar.tabBarItemViews=items;}
        else if([change isEqual:@"new-badge"]){TabNativeBadge *b=[TabNativeBadge new];b.count=777;b.fixtureFrame=NSMakeRect(32,4,24,16);o.tabBar.tabBarItemViews[2].badgeView=b;}
        CSGroupTabBadgeDecision *d=[CSGroupListAdapter closeFriendTabBadgeDecision];CHECK(d && !d.badge);[o setTabBarBadgeValue:10 forIndex:2];ExpectSafeClear(o);CHECK(Badge(o).hidden);CHECK(Badge(o).count!=0);
    }
    Reset(@"off-main-getter-is-unavailable");Adapter(@[Row(0,@"protected",3,NO),Row(1,@"ordinary",7,NO)]);dispatch_semaphore_t done=dispatch_semaphore_create(0);__block CSGroupTabBadgeDecision *offMain;
    [NSThread detachNewThreadWithBlock:^{@autoreleasepool{offMain=[CSGroupListAdapter closeFriendTabBadgeDecision];dispatch_semaphore_signal(done);}}];dispatch_semaphore_wait(done,DISPATCH_TIME_FOREVER);CHECK(offMain && !offMain.badge);
}
static void PublicationAndBypassChecks(void){
    Reset(@"reliable-refresh-publishes-without-next-message");CSGroupListAdapter *a=Adapter(@[Row(0,@"protected",3,NO),Row(1,@"ordinary",7,NO)]);TabNativeController *o=Owner();TabNativeBadge *b=Badge(o);[o setTabBarBadgeValue:10 forIndex:2];[o.events removeAllObjects];a.changeDepth=1;[o setTabBarBadgeValue:10 forIndex:2];CHECK(!o.events.count && b.count==7);a.changeDepth=0;a.modelRevision++;a.snapshotRevision=a.modelRevision;a.cachedNativeSections=@[@[Row(0,@"protected",3,NO),Row(1,@"ordinary",9,NO)]];[a publishTabBadgeSourceFinished:YES];Expect(o,@"number",@9);CHECK(b.count==9);Stable(o,b);
    [o.events removeAllObjects];[a publishTabBadgeSourceFinished:NO];CHECK(!o.events.count);a.dirty=YES;[a publishTabBadgeSourceFinished:YES];CHECK(!o.events.count);a.dirty=NO;a.changeDepth=1;[a publishTabBadgeSourceFinished:YES];CHECK(!o.events.count);a.changeDepth=0;a.controller=@"folded";[a publishTabBadgeSourceFinished:YES];CHECK(!o.events.count);a.controller=Root(o);a.snapshotEpoch--;[a publishTabBadgeSourceFinished:YES];CHECK(!o.events.count);a.snapshotEpoch=Epoch;
    Policy=MakePolicy(@[],@[],YES,NO,NO,nil,42);Root(o).m_mainFrameLogicController.nativeTotal=15;[o.events removeAllObjects];CSPublishChatTabBadges();Expect(o,@"number",@15);CHECK(Root(o).m_mainFrameLogicController.reads==1);
    Reset(@"revealed-native-zero-restores-reliable-pure-dot");a=Adapter(@[Row(0,@"protected",3,YES),Row(1,@"ordinary",2,YES)]);o=Owner();[o showRedDotOnTabBarItemAtIndex:2];[o.events removeAllObjects];Policy=MakePolicy(@[@"protected"],@[],YES,YES,NO,nil,42);Root(o).m_mainFrameLogicController.nativeTotal=0;CHECK(![CSGroupListAdapter closeFriendTabBadgeDecision]);CHECK([CSGroupListAdapter closeFriendTabBadgeDecisionForPublication:YES].badge.redDot);[a publishTabBadgeSourceFinished:YES];Expect(o,@"dot",nil);CHECK(Badge(o).dot && !Badge(o).hidden);
    Policy=MakePolicy(@[@"protected"],@[],YES,NO,NO,nil,43);[o showRedDotOnTabBarItemAtIndex:2];[o.events removeAllObjects];Policy=MakePolicy(@[@"protected"],@[],YES,YES,NO,nil,44);Root(o).m_mainFrameLogicController.nativeTotal=15;CSPublishChatTabBadges();Expect(o,@"number",@15);CHECK(Badge(o).count==15 && !Badge(o).dot);
    Policy=MakePolicy(@[@"protected"],@[],YES,NO,NO,nil,45);a.modelRevision++;a.snapshotRevision=a.modelRevision;a.cachedNativeSections=@[@[Row(0,@"protected",0,YES),Row(1,@"ordinary",0,YES)]];[o showRedDotOnTabBarItemAtIndex:2];[o.events removeAllObjects];Policy=MakePolicy(@[@"protected"],@[],YES,YES,NO,nil,46);Root(o).m_mainFrameLogicController.nativeTotal=0;CSPublishChatTabBadges();Expect(o,@"number",@0);CHECK(Badge(o).hidden);
    Reset(@"native-restoration-rejects-wrong-total-ABI-before-call");Adapter(@[Row(0,@"protected",3,NO),Row(1,@"ordinary",7,NO)]);o=Owner();[o setTabBarBadgeValue:10 forIndex:2];[o.events removeAllObjects];Policy=MakePolicy(@[],@[],YES,NO,NO,nil,42);TabWrongNativeLogic *wrong=[TabWrongNativeLogic new];[Root(o) setValue:wrong forKey:@"m_mainFrameLogicController"];CSPublishChatTabBadges();CHECK(!wrong.reads && !o.events.count);
    Reset(@"native-bypass-does-not-escape-owner");Adapter(@[Row(0,@"protected",3,NO),Row(1,@"ordinary",7,NO)]);o=Owner();Adapter(@[Row(0,@"protected",3,NO),Row(1,@"ordinary",7,NO)]);TabNativeController *other=Owner();NativeReentry=^{[other setTabBarBadgeValue:999 forIndex:2];};[o setTabBarBadgeValue:10 forIndex:2];Expect(o,@"number",@7);Expect(other,@"number",@7);
    Reset(@"native-bypass-does-not-escape-index");Adapter(@[Row(0,@"protected",3,NO),Row(1,@"ordinary",7,NO)]);o=Owner();NSMutableArray *views=[o.viewControllers mutableCopy];NewMainFrameViewController *extra=[NewMainFrameViewController new];views[0]=extra;o.viewControllers=views;CSGroupListAdapter *extraAdapter=Adapter(@[Row(0,@"protected",3,NO),Row(1,@"ordinary",7,NO)]);extraAdapter.controller=extra;TabNativeController *same=o;NativeReentry=^{[same setTabBarBadgeValue:999 forIndex:0];};[o setTabBarBadgeValue:10 forIndex:2];CHECK(o.events.count==2);CHECK([o.events[0][@"value"] isEqual:@7] && [o.events[1][@"value"] isEqual:@7]);
    Reset(@"native-bypass-is-consumed-once");Adapter(@[Row(0,@"protected",3,NO),Row(1,@"ordinary",7,NO)]);o=Owner();same=o;NativeReentry=^{[same setTabBarBadgeValue:999 forIndex:2];};[o setTabBarBadgeValue:10 forIndex:2];CHECK(o.events.count==2);CHECK([o.events[0][@"value"] isEqual:@7] && [o.events[1][@"value"] isEqual:@7]);
    Reset(@"native-bypass-does-not-escape-selector");Adapter(@[Row(0,@"protected",3,NO),Row(1,@"ordinary",7,NO)]);o=Owner();same=o;NativeReentry=^{[same setTabBarBadgeString:@"999+" forIndex:2];};[o setTabBarBadgeValue:10 forIndex:2];CHECK(o.events.count==2);CHECK([o.events[0][@"kind"] isEqual:@"number"] && [o.events[1][@"kind"] isEqual:@"number"]);CHECK([o.events[1][@"value"] isEqual:@7]);
    Reset(@"native-throw-restores-bypass");Adapter(@[Row(0,@"protected",3,NO),Row(1,@"ordinary",7,NO)]);o=Owner();NativeThrows=YES;BOOL caught=NO;@try{[o setTabBarBadgeValue:10 forIndex:2];}@catch(NSException *e){caught=[e.name isEqual:@"NativeFixtureThrow"];}CHECK(caught);NativeThrows=NO;[o.events removeAllObjects];[o setTabBarBadgeValue:999 forIndex:2];Expect(o,@"number",@7);
    Reset(@"reentrant-boundary-before-outer-native-write");Adapter(@[Row(0,@"protected",3,NO),Row(1,@"ordinary",7,NO)]);o=Owner();same=o;NativeReentry=^{Policy=MakePolicy(@[],@[],NO,NO,YES,nil,42);CSPublishChatTabBadges();};[o setTabBarBadgeValue:10 forIndex:2];CHECK(Badge(same).hidden);
    Reset(@"reentrant-source-refresh-before-outer-native-write");a=Adapter(@[Row(0,@"protected",3,NO),Row(1,@"ordinary",7,NO)]);o=Owner();same=o;CSGroupListAdapter *changing=a;NativeReentry=^{changing.modelRevision++;changing.snapshotRevision=changing.modelRevision;changing.cachedNativeSections=@[@[Row(0,@"protected",3,NO),Row(1,@"ordinary",5,NO)]];[changing publishTabBadgeSourceFinished:YES];};[o setTabBarBadgeValue:10 forIndex:2];CHECK(Badge(same).count==5 && !Badge(same).hidden);
}
static void NativeOwnershipChecks(void){
    for(NSNumber *enabled in @[@NO,@YES])for(NSNumber *revealed in @[@NO,@YES]){
        Reset(@"empty-list-never-owned-source-does-not-publish");Policy=MakePolicy(@[],@[],enabled.boolValue,revealed.boolValue,NO,nil,41);CSGroupListAdapter *a=Adapter(@[Row(0,@"ordinary",7,NO)]);TabNativeController *o=Owner();[o setTabBarBadgeValue:234 forIndex:2];[o.events removeAllObjects];[a publishTabBadgeSourceFinished:YES];CHECK(!a.tabAlertBadge);[NSNotificationCenter.defaultCenter postNotificationName:CSGroupTabBadgeSourceDidRefreshNotification object:nil];CHECK(!o.events.count && !Root(o).m_mainFrameLogicController.reads);CHECK(Badge(o).count==234);
    }
    Reset(@"native-restoration-releases-plugin-ownership-once");CSGroupListAdapter *a=Adapter(@[Row(0,@"protected",3,NO),Row(1,@"ordinary",7,NO)]);TabNativeController *o=Owner();[o setTabBarBadgeValue:10 forIndex:2];[o.events removeAllObjects];Policy=MakePolicy(@[],@[],YES,NO,NO,nil,42);CSPublishChatTabBadges();Expect(o,@"number",@10);NSUInteger reads=Root(o).m_mainFrameLogicController.reads;[o.events removeAllObjects];[a publishTabBadgeSourceFinished:YES];CSPublishChatTabBadges();CHECK(!o.events.count && Root(o).m_mainFrameLogicController.reads==reads);
    Reset(@"pending-native-zero-keeps-restore-opportunity");a=Adapter(@[Row(0,@"protected",3,NO),Row(1,@"ordinary",7,NO)]);o=Owner();[o setTabBarBadgeValue:10 forIndex:2];[o.events removeAllObjects];Policy=MakePolicy(@[@"protected"],@[],YES,YES,NO,nil,42);Root(o).m_mainFrameLogicController.nativeTotal=0;a.dirty=YES;CSPublishChatTabBadges();for(NSDictionary *event in o.events)CHECK(![event[@"kind"] isEqual:@"number"] || ![event[@"value"] isEqual:@0]);[o.events removeAllObjects];a.dirty=NO;a.modelRevision++;a.snapshotRevision=a.modelRevision;a.cachedNativeSections=@[@[Row(0,@"protected",3,YES),Row(1,@"ordinary",2,YES)]];[a publishTabBadgeSourceFinished:YES];Expect(o,@"dot",nil);CHECK(Badge(o).dot && !Badge(o).hidden);
    for(NSString *boundary in @[@"epoch",@"account"]){
        Reset([@"nil-native-read-revalidates-" stringByAppendingString:boundary]);Adapter(@[Row(0,@"protected",3,NO),Row(1,@"ordinary",7,NO)]);o=Owner();[o setTabBarBadgeValue:10 forIndex:2];[o.events removeAllObjects];Policy=MakePolicy(@[@"protected"],@[],YES,YES,NO,nil,42);TabNativeLogic *logic=Root(o).m_mainFrameLogicController;logic.nativeTotal=123;BOOL changeAccount=[boundary isEqual:@"account"];
        NativeReadReentry=^{Epoch++;if(changeAccount)CurrentAccount=@"next-account";Policy=MakePolicy(@[],@[],YES,NO,NO,nil,43);logic.nativeTotal=5;CSPublishChatTabBadges();};CSPublishChatTabBadges();for(NSDictionary *event in o.events)CHECK(![event[@"kind"] isEqual:@"number"] || ![event[@"value"] isEqual:@123]);CHECK(Badge(o).hidden || Badge(o).count==5);
    }
    for(NSString *boundary in @[@"epoch",@"account"]){
        Reset([@"native-total-from-old-owner-stays-hidden-until-reliable-source-" stringByAppendingString:boundary]);a=Adapter(@[Row(0,@"protected",3,NO),Row(1,@"ordinary",7,NO)]);o=Owner();[o setTabBarBadgeValue:10 forIndex:2];[o.events removeAllObjects];Policy=MakePolicy(@[@"protected"],@[],YES,YES,NO,nil,42);TabNativeLogic *logic=Root(o).m_mainFrameLogicController;logic.nativeTotal=123;BOOL changeAccount=[boundary isEqual:@"account"];
        NativeReadReentry=^{Epoch++;if(changeAccount)CurrentAccount=@"next-account";Policy=MakePolicy(@[],@[],YES,NO,NO,nil,43);CSPublishChatTabBadges();};
        CSPublishChatTabBadges();CHECK(logic.nativeTotal==123 && Badge(o).hidden);for(NSDictionary *event in o.events)CHECK(![event[@"kind"] isEqual:@"number"] || ![event[@"value"] isEqual:@123]);
        [o.events removeAllObjects];a.snapshotAccount=CurrentAccount;a.snapshotEpoch=Epoch;a.modelRevision++;a.snapshotRevision=a.modelRevision;a.cachedNativeSections=@[@[Row(0,@"ordinary",5,NO)]];a.dirty=NO;logic.nativeTotal=5;[a publishTabBadgeSourceFinished:YES];Expect(o,@"number",@5);CHECK(Badge(o).count==5 && !Badge(o).hidden);
    }
    Reset(@"pending-new-epoch-does-not-mint-known-restore-token");a=Adapter(@[Row(0,@"protected",3,NO),Row(1,@"ordinary",7,NO)]);o=Owner();[o setTabBarBadgeValue:10 forIndex:2];Epoch++;[o.events removeAllObjects];[o setTabBarBadgeValue:10 forIndex:2];CHECK(Badge(o).hidden);ExpectSafeClear(o);
    [o.events removeAllObjects];Policy=MakePolicy(@[],@[],YES,NO,NO,nil,42);TabNativeLogic *staleLogic=Root(o).m_mainFrameLogicController;staleLogic.nativeTotal=123;CSPublishChatTabBadges();CHECK(Badge(o).hidden);for(NSDictionary *event in o.events)CHECK(![event[@"kind"] isEqual:@"number"] || ![event[@"value"] isEqual:@123]);
    [o.events removeAllObjects];a.snapshotEpoch=Epoch;a.modelRevision++;a.snapshotRevision=a.modelRevision;a.cachedNativeSections=@[@[Row(0,@"ordinary",5,NO)]];staleLogic.nativeTotal=5;[a publishTabBadgeSourceFinished:YES];Expect(o,@"number",@5);CHECK(Badge(o).count==5 && !Badge(o).hidden);
    Reset(@"nil-native-write-revalidates-account-after-native-callback");Adapter(@[Row(0,@"protected",3,NO),Row(1,@"ordinary",7,NO)]);o=Owner();[o setTabBarBadgeValue:10 forIndex:2];[o.events removeAllObjects];Policy=MakePolicy(@[@"protected"],@[],YES,YES,NO,nil,42);TabNativeController *same=o;Root(o).m_mainFrameLogicController.nativeTotal=123;NativeReentry=^{Epoch++;CurrentAccount=@"next-account";Policy=MakePolicy(@[],@[],YES,NO,NO,nil,43);Root(same).m_mainFrameLogicController.nativeTotal=5;};CSPublishChatTabBadges();CHECK(Badge(o).hidden || Badge(o).count==5);
    for(NSString *kind in @[@"number",@"string",@"dot"]){
        Reset([@"successful-natural-native-input-releases-old-restore-" stringByAppendingString:kind]);a=Adapter(@[Row(0,@"protected",3,NO),Row(1,@"ordinary",7,NO)]);o=Owner();[o setTabBarBadgeValue:10 forIndex:2];[o.events removeAllObjects];Policy=MakePolicy(@[],@[],YES,NO,NO,nil,42);
        if([kind isEqual:@"number"])[o setTabBarBadgeValue:234 forIndex:2];else if([kind isEqual:@"string"])[o setTabBarBadgeString:@"arbitrary-native-text" forIndex:2];else [o showRedDotOnTabBarItemAtIndex:2];
        TabNativeBadge *native=Badge(o);unsigned long long count=native.count;NSString *string=native.string;BOOL hidden=native.hidden,point=native.dot;[o.events removeAllObjects];[a publishTabBadgeSourceFinished:YES];CHECK(!o.events.count && !Root(o).m_mainFrameLogicController.reads);CHECK(native.count==count && native.string==string && native.hidden==hidden && native.dot==point);
    }
    for(NSString *kind in @[@"number",@"string",@"dot"]){
        Reset([@"natural-native-input-policy-boundary-before-UI-write-" stringByAppendingString:kind]);Adapter(@[Row(0,@"protected",3,NO),Row(1,@"ordinary",7,NO)]);o=Owner();[o setTabBarBadgeValue:10 forIndex:2];[o.events removeAllObjects];Policy=MakePolicy(@[],@[],YES,NO,NO,nil,42);NativeReentry=^{Epoch++;Policy=MakePolicy(@[],@[],NO,NO,YES,nil,43);CSPublishChatTabBadges();};
        if([kind isEqual:@"number"])[o setTabBarBadgeValue:123 forIndex:2];else if([kind isEqual:@"string"])[o setTabBarBadgeString:@"old-native-123" forIndex:2];else [o showRedDotOnTabBarItemAtIndex:2];CHECK(Badge(o).hidden);
    }
}

static void ReentrantPublicationChecks(void){
    Reset(@"persistent-same-source-reentry-terminates");
    Adapter(@[Row(0,@"protected",3,NO),Row(1,@"ordinary",7,NO)]);TabNativeController *o=Owner();
    __block NSUInteger calls=0;
    NativePersistentReentry=^{calls++;CHECK(calls<=8);[NSNotificationCenter.defaultCenter postNotificationName:CSGroupTabBadgeSourceDidRefreshNotification object:nil];};
    [o setTabBarBadgeValue:10 forIndex:2];NativePersistentReentry=nil;
    CHECK(calls<=2 && Badge(o).count==7 && !Badge(o).hidden);
    [o.events removeAllObjects];CSPublishChatTabBadges();CHECK(!o.events.count);

    Reset(@"persistent-source-update-reentry-reaches-latest-with-bound");
    CSGroupListAdapter *a=Adapter(@[Row(0,@"protected",3,NO),Row(1,@"ordinary",7,NO)]);o=Owner();calls=0;
    NativePersistentReentry=^{calls++;CHECK(calls<=8);if(calls==1){a.modelRevision++;a.snapshotRevision=a.modelRevision;a.cachedNativeSections=@[@[Row(0,@"protected",3,NO),Row(1,@"ordinary",5,NO)]];}[NSNotificationCenter.defaultCenter postNotificationName:CSGroupTabBadgeSourceDidRefreshNotification object:nil];};
    [o setTabBarBadgeValue:10 forIndex:2];NativePersistentReentry=nil;
    CHECK(calls<=3 && Badge(o).count==5 && !Badge(o).hidden);
    [o.events removeAllObjects];CSPublishChatTabBadges();CHECK(!o.events.count);

    for(NSString *kind in @[@"number",@"string",@"dot"])for(NSString *state in @[@"pending",@"blocked",@"ready"]){
        Reset([NSString stringWithFormat:@"cold-native-pass-reentry-%@-%@",kind,state]);
        Policy=MakePolicy(@[],@[],YES,NO,NO,nil,41);a=Adapter(@[Row(0,@"protected",3,NO),Row(1,@"ordinary",7,NO)]);o=Owner();
        NativeReentry=^{Policy=MakePolicy(@[@"protected"],@[],YES,NO,[state isEqual:@"blocked"],nil,42);if([state isEqual:@"pending"])a.dirty=YES;CSPublishChatTabBadges();};
        if([kind isEqual:@"number"])[o setTabBarBadgeValue:10 forIndex:2];else if([kind isEqual:@"string"])[o setTabBarBadgeString:@"old-native-10" forIndex:2];else [o showRedDotOnTabBarItemAtIndex:2];
        if([state isEqual:@"ready"])CHECK(Badge(o).count==7 && !Badge(o).hidden && !Badge(o).dot);else CHECK(Badge(o).hidden);
    }
}
static void NativeBarIdentityChecks(void){
    Reset(@"custom-native-bar-owns-visible-badge");
    CSGroupListAdapter *a=Adapter(@[Row(0,@"protected",3,NO),Row(1,@"ordinary",7,NO)]);TabNativeController *o=Owner();TabNativeBadge *unused=o.tabBar.tabBarItemViews[2].badgeView;
    o.customTabBar=[TabNativeBar new];NSMutableArray<TabNativeItem *> *items=[NSMutableArray array];for(NSUInteger i=0;i<5;i++){TabNativeItem *item=[TabNativeItem new];item.badgeView=[TabNativeBadge new];item.badgeView.count=10;item.badgeView.fixtureFrame=NSMakeRect(32,4,24,16);[items addObject:item];}o.customTabBar.tabBarItemViews=items;
    [o setTabBarBadgeValue:10 forIndex:2];CHECK(Badge(o).count==7 && !Badge(o).hidden && unused.count==10);
    a.dirty=YES;[o.events removeAllObjects];[o setTabBarBadgeValue:11 forIndex:2];CHECK(!o.events.count && Badge(o).count==7);
    TabNativeBadge *replacement=[TabNativeBadge new];replacement.count=777;items[2].badgeView=replacement;[o setTabBarBadgeValue:11 forIndex:2];CHECK(replacement.hidden && unused.count==10);
    [o.events removeAllObjects];a.dirty=NO;CSPublishChatTabBadges();CHECK(replacement.count==7 && !replacement.hidden && unused.count==10);
}

static void ScopedSourceAndQueueChecks(void){
    Reset(@"controller-scoped-source-never-borrows-another-root");
    CSGroupListAdapter *a=Adapter(@[Row(0,@"protected",3,NO),Row(1,@"ordinary",7,NO)]);TabNativeController *o=Owner();
    CSGroupListAdapter *otherAdapter=Adapter(@[Row(0,@"protected",3,NO),Row(1,@"ordinary",5,NO)]);TabNativeController *other=Owner();
    [o setTabBarBadgeValue:10 forIndex:2];[other setTabBarBadgeValue:10 forIndex:2];CHECK(Badge(o).count==7 && Badge(other).count==5);
    Epoch++;otherAdapter.snapshotEpoch=Epoch;Policy=MakePolicy(@[],@[],YES,NO,NO,nil,42);Root(o).m_mainFrameLogicController.nativeTotal=123;
    CHECK(![CSGroupListAdapter closeFriendTabBadgeDecisionForController:Root(o) includeNative:YES].badge);
    CHECK([CSGroupListAdapter closeFriendTabBadgeDecisionForController:Root(other) includeNative:YES].badge.count==8);
    [o.events removeAllObjects];CSPublishChatTabBadges();CHECK(Badge(o).hidden && !Root(o).m_mainFrameLogicController.reads);for(NSDictionary *event in o.events)CHECK(![event[@"value"] isEqual:@123]);
    a.snapshotEpoch=Epoch;a.modelRevision++;a.snapshotRevision=a.modelRevision;a.cachedNativeSections=@[@[Row(0,@"ordinary",4,NO)]];Root(o).m_mainFrameLogicController.nativeTotal=4;
    [a publishTabBadgeSourceFinished:YES];CHECK(Badge(o).count==4 && !Badge(o).hidden);

    Reset(@"native-restoration-source-revision-changes-before-final-write");
    a=Adapter(@[Row(0,@"protected",3,NO),Row(1,@"ordinary",7,NO)]);o=Owner();[o setTabBarBadgeValue:10 forIndex:2];Policy=MakePolicy(@[],@[],YES,NO,NO,nil,42);[o.events removeAllObjects];TabNativeLogic *logic=Root(o).m_mainFrameLogicController;
    NativeReentry=^{a.modelRevision++;a.snapshotRevision=a.modelRevision;a.cachedNativeSections=@[@[Row(0,@"ordinary",5,NO)]];logic.nativeTotal=5;[NSNotificationCenter.defaultCenter postNotificationName:CSGroupTabBadgeSourceDidRefreshNotification object:nil];};
    CSPublishChatTabBadges();[[NSRunLoop currentRunLoop]runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.01]];CHECK(Badge(o).count==5 && !Badge(o).hidden);
    NSUInteger reads=logic.reads;[o.events removeAllObjects];CSPublishChatTabBadges();CHECK(!o.events.count && logic.reads==reads);

    Reset(@"native-restoration-inner-policy-native-setter-corrects-outer");
    a=Adapter(@[Row(0,@"protected",3,NO),Row(1,@"ordinary",7,NO)]);o=Owner();[o setTabBarBadgeValue:10 forIndex:2];Policy=MakePolicy(@[],@[],YES,NO,NO,nil,42);[o.events removeAllObjects];TabNativeController *same=o;
    NativeReentry=^{Policy=MakePolicy(@[@"protected"],@[],YES,NO,NO,nil,43);[same setTabBarBadgeValue:999 forIndex:2];};CSPublishChatTabBadges();
    CHECK(Badge(o).count==7 && !Badge(o).hidden);

    Reset(@"queued-background-native-input-cannot-cross-epoch");
    Adapter(@[Row(0,@"protected",3,NO),Row(1,@"ordinary",7,NO)]);o=Owner();[o setTabBarBadgeValue:10 forIndex:2];[o.events removeAllObjects];
    dispatch_semaphore_t done=dispatch_semaphore_create(0);TabNativeController *queued=o;
    [NSThread detachNewThreadWithBlock:^{@autoreleasepool{[queued setTabBarBadgeValue:999 forIndex:2];dispatch_semaphore_signal(done);}}];dispatch_semaphore_wait(done,DISPATCH_TIME_FOREVER);
    CHECK(!o.events.count);Epoch++;Policy=MakePolicy(@[],@[],YES,NO,NO,nil,42);[[NSRunLoop currentRunLoop]runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.02]];
    for(NSDictionary *event in o.events)CHECK(![event[@"value"] isEqual:@999]);CHECK(Badge(o).hidden);
    for(NSString *kind in @[@"number",@"string",@"dot"])for(NSNumber *index in @[@1,@3]){
        Reset([NSString stringWithFormat:@"queued-non-chat-%@-%@-ignores-policy-boundary",kind,index]);o=Owner();TabNativeController *nonchat=o;NSUInteger i=index.unsignedIntegerValue;
        dispatch_semaphore_t finished=dispatch_semaphore_create(0);
        [NSThread detachNewThreadWithBlock:^{@autoreleasepool{if([kind isEqual:@"number"])[nonchat setTabBarBadgeValue:999 forIndex:i];else if([kind isEqual:@"string"])[nonchat setTabBarBadgeString:@"99+" forIndex:i];else [nonchat showRedDotOnTabBarItemAtIndex:i];dispatch_semaphore_signal(finished);}}];dispatch_semaphore_wait(finished,DISPATCH_TIME_FOREVER);
        CHECK(!o.events.count);Epoch++;Policy=MakePolicy(@[],@[],NO,NO,YES,nil,42);[[NSRunLoop currentRunLoop]runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.01]];
        CHECK(o.events.count==1 && [o.events[0][@"index"] isEqual:index]);TabNativeBadge *native=o.tabBar.tabBarItemViews[i].badgeView;
        if([kind isEqual:@"number"])CHECK(native.count==999 && !native.hidden);else if([kind isEqual:@"string"])CHECK([native.string isEqual:@"99+"] && !native.hidden);else CHECK(native.dot && !native.hidden);
    }
}
int main(void){@autoreleasepool{
    InstallHooks();PassthroughChecks();ReadyAndRevealChecks();PendingChecks();PublicationAndBypassChecks();NativeOwnershipChecks();ReentrantPublicationChecks();NativeBarIdentityChecks();ScopedSourceAndQueueChecks();
    printf("Close-friend tab badge: %lu focused checks passed (passthrough, reveal, pending, dot, boundary, publication, scoped bypass; host only)\n",(unsigned long)Checks);
}return 0;}
