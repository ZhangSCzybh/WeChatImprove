// Miniapp container UI reentry: production privacy/index/viewport/card-role logic with a
// deterministic UIKit geometry double. This is not a device frame measurement.
// Host replay of the actual native-index lifecycle -> visible UIKit layout ->
// projection/data-source/cell boundary. A submission records the complete set
// of identities available for one layout, including its first visible delivery.
// Every permitted original-layout call deliberately re-queries every cell, so
// samples are a worst-case reentrancy probe, not UIKit content-commit counts.
// UIKit geometry, admission and chrome are fixtures; full refresh, real proxy,
// native bridge, projection/publication, policy, index scopes and visible-layout
// methods execute unchanged. UI callback order below is a controlled input.
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <objc/runtime.h>
#import <math.h>
#import "CSGroupProjection.h"
#import "CSGroupNativeBridge.h"
#import "CSGroupIndexScope.h"
#import "CSGroupInvocationMapper.h"
#import "CSCloseFriendPolicy.h"
#import "CSCloseFriendSignatures.h"
#import "WESessionTabItem.h"
static NSString *account=@"return-privacy-account";
static CSCloseFriendSnapshot *policy;
static NSUInteger epoch=1;
static BOOL appActive=YES,groupEnabled=YES;
static char CellRowKey;
static BOOL Option(NSString *key) { return [key isEqual:@"enabled"] && groupEnabled; }
static CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) { return policy; }
static NSUInteger CSCloseFriendAccountEpoch(void) { return epoch; }
static BOOL CSGroupApplicationActive(void) { return appActive; }
static BOOL CSCloseFriendShouldHideUserName(NSString *name,CSCloseFriendSurface surface) { return [policy hidesUserName:name surface:surface]; }
#include "GroupReturnPrivacyActive.h"
id CSGetService(Class cls) { (void)cls;return nil; }
@interface MMContext : NSObject @end
@implementation MMContext
+ (NSString *)currentUserName { return account; }
@end
static NSIndexPath *At(NSUInteger section,NSUInteger row) { NSUInteger indexes[]={section,row};return [NSIndexPath indexPathWithIndexes:indexes length:2]; }
@interface NSIndexPath (ReturnRows)
@property(nonatomic,readonly) NSInteger row,section;
+ (instancetype)indexPathForRow:(NSInteger)row inSection:(NSInteger)section;
@end
@implementation NSIndexPath (ReturnRows)
- (NSInteger)row { return (NSInteger)[self indexAtPosition:1]; }
- (NSInteger)section { return (NSInteger)[self indexAtPosition:0]; }
+ (instancetype)indexPathForRow:(NSInteger)row inSection:(NSInteger)section { NSUInteger indexes[]={(NSUInteger)section,(NSUInteger)row};return [self indexPathWithIndexes:indexes length:2]; }
@end
static CSCloseFriendSnapshot *Policy(BOOL revealed,BOOL blocked,NSUInteger revision) {
    return [[CSCloseFriendSnapshot alloc] initWithAccountID:account
        profile:@{@"enabled":@YES,@"friends":@[@"secret-friend"],@"groups":@[@"secret@chatroom"],@"options":@{}}
        revealed:revealed revision:revision blocked:blocked];
}
@interface NativeSession : NSObject
@property(nonatomic,copy) NSString *m_nsUserName;
@property(nonatomic) NSUInteger m_uUnReadCount;
@property(nonatomic) CGFloat fixtureHeight;
@property(nonatomic) BOOL m_bIsTop;
@end
@implementation NativeSession
- (BOOL)isSingleChatSession { return ![self.m_nsUserName hasSuffix:@"@chatroom"]; }
@end
@interface Label : NSObject
@property(nonatomic,copy) NSString *text;
@end
@implementation Label @end
static const NSInteger UITableViewCellStyleDefault=0,UITableViewCellSelectionStyleNone=0,UITableViewRowAnimationNone=0;
@interface UITableViewCell : NSObject
@property(nonatomic,strong) Label *textLabel;
@property(nonatomic) BOOL userInteractionEnabled,hidden;
@property(nonatomic) NSInteger selectionStyle;
@property(nonatomic) BOOL roleValid,roleFirst,roleLast;
- (instancetype)initWithStyle:(NSInteger)style reuseIdentifier:(NSString *)identifier;
@end
@implementation UITableViewCell
- (instancetype)initWithStyle:(NSInteger)style reuseIdentifier:(NSString *)identifier {
    (void)style;(void)identifier;if ((self=[super init])) self.textLabel=[Label new];return self;
}
@end
@interface CSCloseFriendListShield : NSObject
- (void)shieldCell:(UITableViewCell *)cell;
- (void)prepareForPublication;
@end
#include "GroupReturnPrivacyShield.h"
static void CSCloseFriendUpdateSessionCover(id cell,id row) { (void)cell;(void)row; }
static void CSCloseFriendRefreshSessionCover(id cell) { (void)cell; }
@class CSGroupListAdapter,NativeHost,MainFrameTableView;
typedef MainFrameTableView UITableView;
static BOOL CSGroupCardPosition(UITableView *table,NSIndexPath *path,BOOL *first,BOOL *last);
typedef struct { CGFloat top,left,bottom,right; } UIEdgeInsets;
@interface MainFrameTableView : NSObject
@property(nonatomic,weak) CSGroupListAdapter *adapter;
@property(nonatomic,weak) NativeHost *host;
@property(nonatomic,strong) NSMutableArray<NSArray<NSString *> *> *submissions;
@property(nonatomic,strong) NSMutableArray<NSDictionary *> *geometrySamples,*completedLayouts;
@property(nonatomic,strong) NSDictionary<NSIndexPath *,NSNumber *> *rowOrigins;
@property(nonatomic) CGRect bounds;
@property(nonatomic) CGSize contentSize;
@property(nonatomic) BOOL decoratorOutside,reenterOnce;
@property(nonatomic) NSUInteger originalCalculations,decorationRepairs;
@property(nonatomic,strong) NSArray<UITableViewCell *> *visibleCells;
@property(nonatomic,copy) NSArray<NSIndexPath *> *indexPathsForVisibleRows;
@property(nonatomic) BOOL tracking,dragging,decelerating,editing;
@property(nonatomic) CGPoint contentOffset;
@property(nonatomic) UIEdgeInsets adjustedContentInset;
@property(nonatomic) NSUInteger reloads,rowReloads,offsetWrites,layouts;
- (void)layoutSubviews;
- (void)originalLayout;
- (void)layoutIfNeeded;
- (CGRect)rectForRowAtIndexPath:(NSIndexPath *)path;
- (void)setContentOffset:(CGPoint)point animated:(BOOL)animated;
- (void)reloadData;
- (void)reloadRowsAtIndexPaths:(NSArray *)paths withRowAnimation:(NSInteger)animation;
@end
@interface NativeHost : NSObject
@property(nonatomic,strong) MainFrameTableView *m_tableView;
@property(nonatomic,strong) NSArray<NSArray<NativeSession *> *> *sections;
@property(nonatomic) NSUInteger privateCellCalls;
- (UITableViewCell *)tableView:(id)table cellForRowAtIndexPath:(NSIndexPath *)path;
@end
@implementation NativeHost
- (CGFloat)tableView:(id)table heightForHeaderInSection:(NSInteger)section { (void)table;(void)section;return 12; }
- (NSString *)tableView:(id)table titleForHeaderInSection:(NSInteger)section { (void)table;return [NSString stringWithFormat:@"section-%ld",(long)section]; }
- (CGFloat)tableView:(id)table heightForRowAtIndexPath:(NSIndexPath *)path { (void)table;return path.length==2 && (NSUInteger)path.section<self.sections.count && (NSUInteger)path.row<self.sections[(NSUInteger)path.section].count ? [self.sections[(NSUInteger)path.section][(NSUInteger)path.row] fixtureHeight] : 0; }
- (id)m_mainFrameLogicController { return self; }
- (NSInteger)numberOfSectionsInTableView:(id)table { (void)table;return (NSInteger)self.sections.count; }
- (NSInteger)tableView:(id)table numberOfRowsInSection:(NSInteger)section { (void)table;return section>=0 && (NSUInteger)section<self.sections.count ? (NSInteger)self.sections[(NSUInteger)section].count : 0; }
- (id)getSessionInfoAtIndexPath:(NSIndexPath *)path { NativeSession *session=path.length==2 && (NSUInteger)path.section<self.sections.count && (NSUInteger)path.row<self.sections[(NSUInteger)path.section].count ? self.sections[(NSUInteger)path.section][(NSUInteger)path.row] : nil;return session.m_nsUserName.length ? session : nil; }
- (id)getCellDataAtIndexPath:(NSIndexPath *)path { (void)path;return nil; }
- (id)indexPathOfSessionUserName:(NSString *)name { for(NSUInteger s=0;s<self.sections.count;s++)for(NSUInteger r=0;r<self.sections[s].count;r++)if([self.sections[s][r].m_nsUserName isEqual:name])return At(s,r);return nil; }
- (UITableViewCell *)tableView:(id)table cellForRowAtIndexPath:(NSIndexPath *)path {
    NativeSession *session=[self getSessionInfoAtIndexPath:path];
    if ([session.m_nsUserName hasPrefix:@"secret"]) self.privateCellCalls++;
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:nil];
    cell.textLabel.text=session.m_nsUserName ?: ([path indexAtPosition:1]==0 ? @"favorite-banner" : @"mac-banner");
    BOOL first=NO,last=NO;cell.roleValid=CSGroupCardPosition(table,path,&first,&last);cell.roleFirst=first;cell.roleLast=last;return cell;
}
@end
@interface CSGroupPreferences : NSObject
@property(nonatomic) BOOL filterDuplicates;
@property(nonatomic,copy) NSString *accountID,*selectedTabID;
@property(nonatomic,strong) NSArray *tabs;
- (instancetype)initWithDefaults:(NSUserDefaults *)defaults accountID:(NSString *)account;
- (void)reload;
@end
@implementation CSGroupPreferences
- (instancetype)initWithDefaults:(NSUserDefaults *)defaults accountID:(NSString *)value { (void)defaults;if((self=[super init])){self.accountID=value;self.tabs=@[[WESessionTabItem tabWithType:WETabTypeGroup]];self.selectedTabID=[self.tabs[0] tabId];}return self; }
- (void)reload {}
@end
@interface ProbeChrome : NSObject
@property(nonatomic,copy) NSString *selectedTabID;
- (void)refreshAppearance;
- (void)updateTabs:(NSArray *)tabs;
- (void)updateUnreadCount:(NSInteger)count hasRedDot:(BOOL)red forTabIndex:(NSInteger)index;
@end
@implementation ProbeChrome
- (void)refreshAppearance {}
- (void)updateTabs:(NSArray *)tabs { (void)tabs; }
- (void)updateUnreadCount:(NSInteger)count hasRedDot:(BOOL)red forTabIndex:(NSInteger)index { (void)count;(void)red;(void)index; }
@end
@interface ProbeProxySlot : NSObject
@property(nonatomic,weak) id target;
@end
@implementation ProbeProxySlot @end
@interface NSObject (ContainerPrefetch)
- (void)tableView:(id)table cancelPrefetchingForRowsAtIndexPaths:(NSArray *)paths;
@end
@class CSGroupTableProxy;
@interface CSGroupListAdapter : NSObject
@property(nonatomic,strong) MainFrameTableView *table;
@property(nonatomic,strong) NativeHost *controller;
@property(nonatomic,strong) CSGroupPreferences *preferences;
@property(nonatomic,strong) ProbeChrome *chrome;
@property(nonatomic,strong) CSGroupTableProxy *uiProxy;
@property(nonatomic,strong) NSMutableDictionary<NSNumber *,ProbeProxySlot *> *proxies;
@property(nonatomic,strong) NSMutableArray *completions;
@property(nonatomic,strong) NSMutableSet *pendingContentUserNames;
@property(nonatomic,copy) NSArray *cachedNativeSections,*displayedTabs;
@property(nonatomic) CSGroupChangeKind pendingChanges;
@property(nonatomic) BOOL scheduled,scheduledCoalesced,scheduledInteraction,scheduledRecovery,coalescingNotification,pendingImmediateRefresh;
@property(nonatomic) BOOL pendingContentUnattributed,recoveryPending,appearanceDirty,searchChromeVisible,publishedEnabled,tabBadgeSourceScheduled;
@property(nonatomic) NSUInteger refreshGeneration,interactionAttempts;
@property(nonatomic) NSTimeInterval interactionDeadline,pendingRefreshDeadline,scheduledRefreshDeadline;
@property(nonatomic,strong) CSCloseFriendListShield *privacyShield;
@property(nonatomic,strong) CSGroupProjection *projection;
@property(nonatomic,strong) NSDictionary *identityDisplayPaths;
@property(nonatomic,strong) NSMutableSet *prefetchedPaths;
@property(nonatomic,strong) NSMutableArray *nativeActions;
@property(nonatomic,strong) NSMutableDictionary *anchors;
@property(nonatomic,copy) NSDictionary *presentationViewport;
@property(nonatomic,copy) NSString *publishedTabID;
@property(nonatomic) BOOL chromeVisible,swipeActive;
@property(nonatomic) BOOL projecting,dirty,publishing,nativePresentation,pendingScrollToTop,snapshotRetryAttempted,publicationNeedsFullReload;
@property(nonatomic) BOOL searching,presentationSuspended,privacyRefreshPending;
@property(nonatomic) NSUInteger snapshotRetryGeneration,changeDepth,recoveries,modelRevision;
- (void)pruneNativeActions;
- (void)finishSuspendedBatches;
- (void)reconcileDeletedSwipeRow;
- (void)installProxies;
- (void)ensureChrome;
- (NSArray *)nativeSectionsForAccount:(NSString *)value;
- (void)refreshNavigationTitle;
- (void)requestTabBadgeSourceRefresh;
- (BOOL)isActive;
- (void)refresh;
- (void)requestRecovery;
- (void)requestRefresh;
- (void)scheduleRefresh;
- (void)layout;
- (void)beginNativeChange;
- (void)endNativeChange;
- (BOOL)forwardSwipeInvocation:(NSInvocation *)inv target:(id)target;
- (void)saveAnchor;
- (void)restoreAnchor;
- (void)applyPendingScrollToTop;
- (BOOL)groupPanMoving;
- (NSUInteger)nativeMenuState;
- (NSNumber *)presentationScrollHeight;
- (void)restoreScrollHeight:(CGFloat)height;
- (void)shieldVisiblePrivateRows;
- (void)performVisibleLayout:(void (^)(void))layout;
+ (instancetype)adapterForTable:(id)table;
- (void)publishProjection:(CSGroupProjection *)projection previous:(CSGroupProjection *)previous changes:(CSGroupChangeKind)changes contentUserNames:(NSSet *)names contentIdentityKnown:(BOOL)known previouslyProjecting:(BOOL)previouslyProjecting;
@end
@implementation CSGroupListAdapter
#include "GroupReturnPrivacyBodies.h"
#include "GroupContainerRefresh.h"
#include "GroupReturnLayoutViewport.h"
- (void)pruneNativeActions {}
- (void)finishSuspendedBatches {}
- (void)reconcileDeletedSwipeRow {}
- (void)installProxies {}
- (void)ensureChrome { if(!self.chrome)self.chrome=[ProbeChrome new]; }
- (NSArray *)nativeSectionsForAccount:(NSString *)value { (void)value;__block NSArray *sections;CSGroupWithNativeIndices(self.table,^{ sections=CSGroupBuildNativeSections(self.controller,self.table,self.controller); });return sections; }
- (void)refreshNavigationTitle {}
- (void)requestTabBadgeSourceRefresh {}
- (BOOL)groupPanMoving { return NO; }
- (NSUInteger)nativeMenuState { return 0; }
- (void)applyPendingScrollToTop {}
- (BOOL)isActive { return self.projecting; }
+ (instancetype)adapterForTable:(id)table { return [table adapter]; }
- (void)requestRecovery { self.recoveries++;self.dirty=YES; }
- (void)requestRefresh { self.dirty=YES; }
- (void)scheduleRefresh {}
- (void)layout {}
- (void)beginNativeChange { self.changeDepth++; }
- (void)endNativeChange { self.changeDepth--; }
- (void)recordRefreshEvent:(NSString *)event delay:(NSTimeInterval)delay { (void)event;(void)delay; }
- (BOOL)forwardSwipeInvocation:(NSInvocation *)inv target:(id)target { (void)inv;(void)target;return NO; }

@end
#include "GroupContainerProxy.h"
#include "GroupReturnLayoutCard.h"
static CSGroupListAdapter *Adapter(id owner) { return [owner isKindOfClass:NativeHost.class] ? [(NativeHost *)owner m_tableView].adapter : nil; }
#include "GroupReturnPrivacyNative.h"
#include "GroupReturnPrivacyLayout.h"
// These are the real decorator table hook and nesting-depth wrapper. The
// downstream paint repair deliberately only counts reuse of already known roles.
static char RestoreKey;
@interface CSListCornerSessionRestore : NSObject
@property(nonatomic) NSUInteger tableLayoutDepth;
@end
@implementation CSListCornerSessionRestore @end
static void CSListCornerRestoreSessionTable(UITableView *table,BOOL geometry) { (void)geometry;table.decorationRepairs++; }
#include "GroupReturnLayoutDecorator.h"
static NSInteger Count(CSGroupListAdapter *adapter,SEL selector,NSInteger section,BOOL rows) {
    NSInvocation *inv=[NSInvocation invocationWithMethodSignature:[adapter.controller methodSignatureForSelector:selector]];
    inv.selector=selector;__unsafe_unretained id table=adapter.table;[inv setArgument:&table atIndex:2];
    if(rows)[inv setArgument:&section atIndex:3];
    [inv invokeWithTarget:adapter.uiProxy];NSInteger value=0;[inv getReturnValue:&value];return value;
}
static CGFloat Height(CSGroupListAdapter *adapter,NSIndexPath *path) {
    SEL selector=@selector(tableView:heightForRowAtIndexPath:);
    NSInvocation *inv=[NSInvocation invocationWithMethodSignature:[adapter.controller methodSignatureForSelector:selector]];
    inv.selector=selector;__unsafe_unretained id table=adapter.table;__unsafe_unretained id row=path;
    [inv setArgument:&table atIndex:2];[inv setArgument:&row atIndex:3];
    [inv invokeWithTarget:adapter.uiProxy];CGFloat value=0;[inv getReturnValue:&value];return value;
}
static CGFloat SectionHeight(CSGroupListAdapter *adapter,NSInteger section) {
    SEL selector=@selector(tableView:heightForHeaderInSection:);NSInvocation *inv=[NSInvocation invocationWithMethodSignature:[adapter.controller methodSignatureForSelector:selector]];
    inv.selector=selector;__unsafe_unretained id table=adapter.table;[inv setArgument:&table atIndex:2];[inv setArgument:&section atIndex:3];[inv invokeWithTarget:adapter.uiProxy];CGFloat value=0;[inv getReturnValue:&value];return value;
}
static NSString *SectionTitle(CSGroupListAdapter *adapter,NSInteger section) {
    SEL selector=@selector(tableView:titleForHeaderInSection:);NSInvocation *inv=[NSInvocation invocationWithMethodSignature:[adapter.controller methodSignatureForSelector:selector]];
    inv.selector=selector;__unsafe_unretained id table=adapter.table;[inv setArgument:&table atIndex:2];[inv setArgument:&section atIndex:3];[inv invokeWithTarget:adapter.uiProxy];__unsafe_unretained NSString *value=nil;[inv getReturnValue:&value];return value;
}
@implementation MainFrameTableView
- (void)setContentOffset:(CGPoint)value { _contentOffset=value;self.offsetWrites++; }
- (void)setContentOffset:(CGPoint)point animated:(BOOL)animated { (void)animated;self.contentOffset=point; }
- (CGRect)rectForRowAtIndexPath:(NSIndexPath *)path { return CGRectMake(0,[self.rowOrigins[path] doubleValue],320,Height(self.adapter,path)); }
- (void)layoutSubviews {
    self.layouts++;
    if(self.decoratorOutside) HookDecoratorLayout(self,^{HookMainFrameLayout(self,^{[self originalLayout];});});
    else HookMainFrameLayout(self,^{HookDecoratorLayout(self,^{[self originalLayout];});});
    NSDictionary *sample=self.geometrySamples.lastObject;
    if(sample) {
        NSMutableDictionary *completed=[sample mutableCopy];completed[@"offsetX"]=@(self.contentOffset.x);completed[@"offsetY"]=@(self.contentOffset.y);
        [self.completedLayouts addObject:[completed copy]];
    }
}
- (void)originalLayout {
    self.originalCalculations++;
    if(self.reenterOnce) {self.reenterOnce=NO;Native(self.host,NO,^{[self layoutSubviews];});}
    NSMutableArray *identities=[NSMutableArray array],*cells=[NSMutableArray array],*sections=[NSMutableArray array],*counts=[NSMutableArray array];
    NSMutableDictionary *origins=[NSMutableDictionary dictionary];
    NSInteger sectionCount=Count(self.adapter,@selector(numberOfSectionsInTableView:),0,NO);
    CGFloat y=80;
    for(NSInteger s=0;s<sectionCount;s++) {
        NSInteger rowCount=Count(self.adapter,@selector(tableView:numberOfRowsInSection:),s,YES);[counts addObject:@(rowCount)];
        // UIKit geometry double: fixed section gap, real forwarded row height.
        y+=SectionHeight(self.adapter,s);(void)SectionTitle(self.adapter,s);NSMutableArray *rows=[NSMutableArray array];
        for(NSInteger r=0;r<rowCount;r++) {
            NSIndexPath *path=At((NSUInteger)s,(NSUInteger)r);CGFloat height=Height(self.adapter,path);
            UITableViewCell *cell=[self.adapter.uiProxy tableView:self cellForRowAtIndexPath:path];
            NSString *name=cell.textLabel.text ?: @"empty";[identities addObject:name];[cells addObject:cell];origins[path]=@(y);
            [rows addObject:@{@"name":name,@"y":@(y),@"height":@(height),@"roleValid":@(cell.roleValid),@"first":@(cell.roleFirst),@"last":@(cell.roleLast)}];
            y+=height;
        }
        [sections addObject:[rows copy]];
    }
    self.contentSize=CGSizeMake(320,y);self.rowOrigins=origins;self.visibleCells=cells;[self.submissions addObject:[identities copy]];
    [self.geometrySamples addObject:@{@"sectionCounts":[counts copy],@"sections":[sections copy],@"offsetX":@(self.contentOffset.x),@"offsetY":@(self.contentOffset.y)}];
}
- (void)layoutIfNeeded { [self layoutSubviews]; }
- (void)reloadData { self.reloads++; }
- (void)reloadRowsAtIndexPaths:(NSArray *)paths withRowAnimation:(NSInteger)animation { (void)paths;(void)animation;self.rowReloads++; }
@end
static NSUInteger checks,failures,sequence;
static NSString *scenario=@"initial";
static void Emit(NSString *kind,NSDictionary *fields) {
    NSMutableDictionary *e=[fields mutableCopy] ?: [NSMutableDictionary dictionary];e[@"kind"]=kind;e[@"scenario"]=scenario;e[@"sequence"]=@(++sequence);e[@"evidence"]=@"host-controlled";
    NSData *data=[NSJSONSerialization dataWithJSONObject:e options:NSJSONWritingSortedKeys error:NULL];printf("%s\n",[[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding] UTF8String]);
}
static void Check(BOOL pass,NSString *message) {checks++;Emit(@"assertion",@{@"message":message,@"passed":@(pass)});if(!pass){failures++;fprintf(stderr,"FAIL: %s / %s\n",scenario.UTF8String,message.UTF8String);} }
static void Reset(CSGroupListAdapter *a) {
    [a.table.submissions removeAllObjects];[a.table.geometrySamples removeAllObjects];[a.table.completedLayouts removeAllObjects];
    a.table.originalCalculations=0;a.table.reloads=0;a.table.rowReloads=0;a.table.offsetWrites=0;a.table.layouts=0;a.controller.privateCellCalls=0;a.recoveries=0;
}
static CSGroupListAdapter *List(BOOL decoratorOutside) {
    CSGroupListAdapter *a=[CSGroupListAdapter new];a.controller=[NativeHost new];a.table=[MainFrameTableView new];
    a.controller.m_tableView=a.table;a.table.host=a.controller;a.table.adapter=a;
    a.table.submissions=[NSMutableArray array];a.table.geometrySamples=[NSMutableArray array];a.table.completedLayouts=[NSMutableArray array];
    a.table.decoratorOutside=decoratorOutside;a.table.bounds=CGRectMake(0,0,320,600);a.table.contentSize=CGSizeMake(320,1800);
    NSMutableArray *normal=[@[@"secret@chatroom",@"normal-a@chatroom",@"gh_official",@"normal-b@chatroom",@"ordinary-private",@"brandservicesessionholder"] mutableCopy];
    for(NSUInteger i=0;i<12;i++)[normal addObject:[NSString stringWithFormat:@"extra-%lu@chatroom",(unsigned long)i]];
    NSArray *names=@[@[NSNull.null,NSNull.null],@[@"pinned-private",@"pinned-a@chatroom",@"secret-friend",@"pinned-b@chatroom",@"brandsessionholder"],normal];
    NSMutableArray *sections=[NSMutableArray array];
    for(NSUInteger s=0;s<names.count;s++) {NSMutableArray *rows=[NSMutableArray array];for(NSUInteger r=0;r<[names[s] count];r++) {
        id name=names[s][r];NativeSession *session=[NativeSession new];session.m_nsUserName=name==NSNull.null?nil:name;session.m_bIsTop=s==1;session.fixtureHeight=s==0?34:((r%3)==0?70:64);[rows addObject:session];
    }[sections addObject:rows];}
    a.controller.sections=sections;a.table.indexPathsForVisibleRows=@[At(0,0),At(0,1),At(1,0),At(1,1),At(2,0),At(2,1)];
    a.nativeActions=[NSMutableArray array];a.completions=[NSMutableArray array];a.anchors=[NSMutableDictionary dictionary];a.prefetchedPaths=[NSMutableSet set];a.proxies=[NSMutableDictionary dictionary];
    a.uiProxy=[CSGroupTableProxy new];a.uiProxy.adapter=a;a.uiProxy.target=a.controller;
    objc_setAssociatedObject(a.table,&RestoreKey,[CSListCornerSessionRestore new],OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [a refresh];a.table.adjustedContentInset=(UIEdgeInsets){100,0,0,0};a.table.contentOffset=CGPointMake(0,400);Reset(a);return a;
}
static NSArray *Flatten(NSDictionary *sample) {NSMutableArray *rows=[NSMutableArray array];for(NSArray *section in sample[@"sections"])for(NSDictionary *row in section)[rows addObject:row];return rows;}
static NSDictionary *Stable(BOOL order) {CSGroupListAdapter *a=List(order);[a.table layoutSubviews];return a.table.geometrySamples.lastObject;}
static void CompareFirst(CSGroupListAdapter *a,NSDictionary *stable) {
    NSDictionary *first=a.table.geometrySamples.firstObject;
    Check(first!=nil,@"first content sample exists");
    Check([first[@"sectionCounts"] isEqual:stable[@"sectionCounts"]],@"first content section counts equal filtered stable collection");
    NSArray *firstRows=Flatten(first),*stableRows=Flatten(stable);
    Check(firstRows.count==stableRows.count,@"first content row count equals filtered stable row count");
    for(NSDictionary *row in firstRows) Check(![row[@"name"] hasPrefix:@"secret"],@"first content has no protected identity");
    NSUInteger count=MIN(firstRows.count,stableRows.count);
    for(NSUInteger i=0;i<count;i++) {
        NSDictionary *row=firstRows[i],*expected=stableRows[i];
        Check([row[@"name"] isEqual:expected[@"name"]],@"first content row identity matches filtered stable order");
        Check([row[@"y"] isEqual:expected[@"y"]] && [row[@"height"] isEqual:expected[@"height"]],@"first content y and height match filtered stable geometry");
        Check([row[@"roleValid"] isEqual:expected[@"roleValid"]] && [row[@"first"] isEqual:expected[@"first"]] && [row[@"last"] isEqual:expected[@"last"]],@"first content card roles/corners equal filtered stable roles");
    }
    Check(a.controller.privateCellCalls==0,@"first UI content never calls protected native cell getter");
    Check(a.table.offsetWrites==0 && a.table.contentOffset.y==400,@"container UI query keeps existing viewport without intermediate offset writes");
    Check(a.table.reloads==0,@"container UI query does not reconstruct the full table");
}
static void ContainerQuery(BOOL order,BOOL nativeOwner,BOOL blankBefore) {
    scenario=[NSString stringWithFormat:@"container-no-appearance/%@/%@/%@",order?@"decorator-outer":@"privacy-outer",nativeOwner?@"native-owner-scope":@"display-scope",blankBefore?@"blank-before-content":@"retained-content"];
    policy=Policy(NO,NO,10);NSDictionary *stable=Stable(order);CSGroupListAdapter *a=List(order);a.presentationViewport=nil;a.dirty=YES;
    Emit(@"host-input",@{@"standardAppearanceCallbacks":@0,@"nativeOwnerScope":@(nativeOwner),@"callsTableLayoutSubviewsBeforeUIRequests":@NO,@"blankBeforeContent":@(blankBefore),@"policy":@"locked-ready"});
    if(blankBefore){a.table.visibleCells=@[];Emit(@"host-placeholder",@{@"visibleContentRows":@0,@"reason":@"explicit host input; not a fabricated observed phone callback"});}
    if(nativeOwner) Native(a.controller,NO,^{[a.table originalLayout];});else [a.table originalLayout];
    Emit(@"first-ui-content",@{@"sample":a.table.geometrySamples.firstObject ?: @{},@"privateNativeCellCalls":@(a.controller.privateCellCalls),@"tableLayoutSubviewsCalls":@(a.table.layouts),@"fullReloads":@(a.table.reloads),@"rowReloads":@(a.table.rowReloads),@"offsetWrites":@(a.table.offsetWrites)});
    CompareFirst(a,stable);
    Check(!CSGroupUsesNativeIndices(a.table),@"outer native scope unwinds after container callbacks");
    [a.table layoutSubviews];Emit(@"later-layout-content",@{@"sample":a.table.geometrySamples.lastObject ?: @{}});
}
static void BlockedLate(BOOL order,BOOL transaction) {
    scenario=[NSString stringWithFormat:@"blocked-policy-late/%@/%@",order?@"decorator-outer":@"privacy-outer",transaction?@"native-transaction":@"no-transaction"];
    policy=Policy(YES,NO,20);CSGroupListAdapter *a=List(order);policy=Policy(NO,YES,21);a.presentationViewport=nil;a.dirty=YES;a.changeDepth=transaction?1:0;
    Emit(@"host-input",@{@"standardAppearanceCallbacks":@0,@"policy":@"blocked",@"changeDepth":@(a.changeDepth),@"queryBeforeLayout":@YES});
    __block NSInteger sections=-1;__block CGFloat height=-1,headerHeight=-1;__block NSString *title;__block UITableViewCell *stale;
    NSUInteger recoveryBefore=a.recoveries;
    Native(a.controller,NO,^{sections=Count(a,@selector(numberOfSectionsInTableView:),0,NO);height=Height(a,At(2,0));headerHeight=SectionHeight(a,2);title=SectionTitle(a,2);stale=[a.uiProxy tableView:a.table cellForRowAtIndexPath:At(2,0)];});
    Emit(@"blocked-query-result",@{@"sections":@(sections),@"height":@(height),@"headerHeight":@(headerHeight),@"headerTitle":title ?: @"",@"cellIsNil":@(stale==nil),@"cellText":stale.textLabel.text ?: @"",@"privateNativeCellCalls":@(a.controller.privateCellCalls),@"recoveries":@(a.recoveries-recoveryBefore),@"fullReloads":@(a.table.reloads)});
    Check(sections==0,@"blocked policy exposes neutral empty section count before first UI content");
    Check(height==0,@"blocked policy has no native protected row geometry");
    Check(headerHeight==0 && title==nil,@"blocked policy exposes neutral header height/title rather than native section work");
    Check(stale!=nil,@"stale required cell request returns nonnil safe placeholder");
    Check(![stale.textLabel.text hasPrefix:@"secret"],@"stale required cell request never returns protected identity");
    Check(a.controller.privateCellCalls==0,@"blocked policy never invokes protected native cell getter");
    Check(a.recoveries==recoveryBefore,@"blocked stale query does not start a recovery loop");
    Check(a.table.reloads==0,@"blocked stale query does not perform full table reload");
    a.changeDepth=0;policy=Policy(NO,NO,22);a.privacyRefreshPending=YES;a.dirty=YES;[a refresh];Reset(a);
    Native(a.controller,NO,^{[a.table originalLayout];});CompareFirst(a,Stable(order));
}
static void LockUnlock(BOOL order) {
    for(NSNumber *revealed in @[@NO,@YES]) {
        scenario=[NSString stringWithFormat:@"lock-unlock/%@/%@",order?@"decorator-outer":@"privacy-outer",revealed.boolValue?@"unlocked":@"locked"];
        policy=Policy(revealed.boolValue,NO,30+revealed.unsignedIntegerValue);CSGroupListAdapter *a=List(order);a.presentationViewport=nil;
        Native(a.controller,NO,^{[a.table originalLayout];});
        BOOL protectedGroup=NO,protectedPrivate=NO;for(NSDictionary *row in Flatten(a.table.geometrySamples.firstObject)){protectedGroup|=[row[@"name"] isEqual:@"secret@chatroom"];protectedPrivate|=[row[@"name"] isEqual:@"secret-friend"];}
        Check(protectedGroup==revealed.boolValue,@"protected group visibility follows unchanged lock/unlock semantics");
        Check(!protectedPrivate,@"selected Group still excludes private sessions in either lock state");
        Emit(@"lock-visibility",@{@"revealed":revealed,@"protectedGroupVisible":@(protectedGroup),@"protectedPrivateVisible":@(protectedPrivate)});
        // Original native source remains fully readable for model snapshots and actions.
        __block NSArray *nativeRows;Native(a.controller,NO,^{nativeRows=CSGroupBuildNativeSections(a.controller,a.table,a.controller);});
        BOOL hasNativeSecret=NO;for(NSArray *rows in nativeRows)for(CSGroupRow *row in rows)hasNativeSecret|=[row.userName isEqual:@"secret@chatroom"];
        Check(hasNativeSecret,@"original native bridge reads remain complete and independent of UI proxy filtering");
    }
}
static void NativeActions(BOOL revealed) {
    scenario=[NSString stringWithFormat:@"explicit-native-action/%@",revealed?@"unlocked":@"locked"];policy=Policy(revealed,NO,40+revealed);CSGroupListAdapter *a=List(NO);
    __block BOOL nativeScope=NO,ran=NO;__block NSString *nativeIdentity;
    [a.nativeActions addObject:^{ran=YES;nativeScope=CSGroupUsesNativeIndices(a.table);nativeIdentity=[[a.controller getSessionInfoAtIndexPath:At(2,0)] m_nsUserName];}];
    a.nativePresentation=YES;[a refresh];
    Check(ran && nativeScope,@"explicit original native action still executes synchronously under native indices");
    Check([nativeIdentity isEqual:@"secret@chatroom"],@"explicit native model/action read still addresses original source coordinates");
    BOOL protectedVisible=NO;for(NSString *name in a.table.submissions.lastObject)protectedVisible|=[name isEqual:@"secret@chatroom"];
    Check(protectedVisible==revealed,@"explicit native presentation retains existing locked/unlocked UI semantics");
    Check(a.nativeActions.count==0,@"explicit native action completes once and drains its queue");
    Emit(@"native-action-result",@{@"revealed":@(revealed),@"ran":@(ran),@"nativeScope":@(nativeScope),@"nativeIdentity":nativeIdentity ?: @"",@"protectedVisible":@(protectedVisible),@"remainingActions":@(a.nativeActions.count)});
}
int main(void) {@autoreleasepool {
    Emit(@"probe-boundary",@{@"deviceEvidence":@NO,@"entry":@"Controlled UIKit-like required UI proxy requests before layoutSubviews inside a native owner scope",@"productionBodies":@"full refresh, projection building/filtering, publication plan, proxy class, invocation forwarding/cell delivery, index scopes, protected performVisibleLayout, viewport and card-role policy; real corner table hook/depth order",@"doubles":@[@"UIKit geometry and UI content scheduling",@"adapter attachment/header/chrome",@"corner paint counted boundary"]});
    for(NSNumber *outside in @[@NO,@YES]) {BOOL order=outside.boolValue;for(NSNumber *native in @[@NO,@YES])for(NSNumber *blank in @[@NO,@YES])ContainerQuery(order,native.boolValue,blank.boolValue);BlockedLate(order,NO);BlockedLate(order,YES);LockUnlock(order);}
    NativeActions(NO);NativeActions(YES);
    Emit(@"result",@{@"checks":@(checks),@"failures":@(failures)});fprintf(stderr,"Group container return HOST: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);return failures?1:0;
}}
