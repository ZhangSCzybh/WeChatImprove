// Host replay of the actual native-index lifecycle -> visible UIKit layout ->
// projection/data-source/cell boundary. A submission records the complete set
// of identities available for one layout, including its first visible delivery.
// Every permitted original-layout call deliberately re-queries every cell, so
// samples are a worst-case reentrancy probe, not UIKit content-commit counts.
// UIKit and refresh admission are fixtures; projection, publication planning,
// identity lookup, policy decisions, index scopes and visible-layout code are real.
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
static NSIndexPath *Path(NSUInteger row) { NSUInteger indexes[]={0,row};return [NSIndexPath indexPathWithIndexes:indexes length:2]; }
@interface NSIndexPath (ReturnRows)
+ (instancetype)indexPathForRow:(NSInteger)row inSection:(NSInteger)section;
@end
@implementation NSIndexPath (ReturnRows)
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
- (instancetype)initWithStyle:(NSInteger)style reuseIdentifier:(NSString *)identifier;
@end
@implementation UITableViewCell
- (instancetype)initWithStyle:(NSInteger)style reuseIdentifier:(NSString *)identifier {
    (void)style;(void)identifier;if ((self=[super init])) self.textLabel=[Label new];return self;
}
@end
@class MainFrameTableView;
typedef MainFrameTableView UITableView;
#include "GroupNeutralUIKitDouble.h"
@interface CSCloseFriendListShield : NSObject
@property(nonatomic,readonly) CGSize contentSize;
@property(nonatomic,copy,readonly) NSArray<NSNumber *> *sectionRowCounts;
- (void)shieldCell:(UITableViewCell *)cell;
- (void)shieldTable:(UITableView *)table;
- (void)shieldTable:(UITableView *)table contentSize:(CGSize)size;
- (void)shieldTable:(UITableView *)table contentSize:(CGSize)size sectionRowCounts:(NSArray<NSNumber *> *)counts;
- (void)finishTablePublication;
- (void)prepareForPublication;
@end
static void CSCloseFriendUpdateSessionCover(id cell,id row) { (void)cell;(void)row; }
static void CSCloseFriendRefreshSessionCover(id cell) { (void)cell; }
@class CSGroupListAdapter,NativeHost;
typedef struct { CGFloat top,left,bottom,right; } UIEdgeInsets;
@interface MainFrameTableView : NSObject
@property(nonatomic) CGRect bounds;
@property(nonatomic) CGSize contentSize;
@property(nonatomic,strong) CALayer *layer;
@property(nonatomic,strong) GroupNeutralHeader *tableHeaderView;
@property(nonatomic) BOOL accessibilityElementsHidden;
@property(nonatomic,weak) CSGroupListAdapter *adapter;
@property(nonatomic,weak) NativeHost *host;
@property(nonatomic,strong) NSMutableArray<NSArray<NSString *> *> *submissions;
@property(nonatomic,strong) NSArray<UITableViewCell *> *visibleCells;
@property(nonatomic,copy) NSArray<NSIndexPath *> *indexPathsForVisibleRows;
@property(nonatomic) BOOL tracking,dragging,decelerating,editing;
@property(nonatomic) CGPoint contentOffset;
@property(nonatomic) UIEdgeInsets adjustedContentInset;
@property(nonatomic) NSUInteger reloads,rowReloads,offsetWrites,layouts;
- (void)layoutSubviews;
- (void)originalLayout;
- (void)layoutIfNeeded;
- (void)reloadData;
- (void)reloadRowsAtIndexPaths:(NSArray *)paths withRowAnimation:(NSInteger)animation;
@end
#include "GroupReturnPrivacyShield.h"
@interface NativeHost : NSObject
@property(nonatomic,strong) MainFrameTableView *m_tableView;
@property(nonatomic,strong) NSMutableArray<NativeSession *> *sessions;
@property(nonatomic) NSUInteger privateCellCalls;
- (UITableViewCell *)tableView:(id)table cellForRowAtIndexPath:(NSIndexPath *)path;
@end
@implementation NativeHost
- (id)m_mainFrameLogicController { return self; }
- (NSInteger)numberOfSectionsInTableView:(id)table { (void)table;return 1; }
- (NSInteger)tableView:(id)table numberOfRowsInSection:(NSInteger)section { (void)table;return section==0 ? (NSInteger)self.sessions.count : 0; }
- (id)getSessionInfoAtIndexPath:(NSIndexPath *)path { return path.length==2 && [path indexAtPosition:1]<self.sessions.count ? self.sessions[[path indexAtPosition:1]] : nil; }
- (id)getCellDataAtIndexPath:(NSIndexPath *)path { (void)path;return nil; }
- (id)indexPathOfSessionUserName:(NSString *)name { for (NSUInteger i=0;i<self.sessions.count;i++) if ([self.sessions[i].m_nsUserName isEqual:name]) return Path(i);return nil; }
- (UITableViewCell *)tableView:(id)table cellForRowAtIndexPath:(NSIndexPath *)path {
    (void)table;NativeSession *session=[self getSessionInfoAtIndexPath:path];
    if ([session.m_nsUserName hasPrefix:@"secret"]) self.privateCellCalls++;
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:nil];
    cell.textLabel.text=session.m_nsUserName ?: ([path indexAtPosition:1]==0 ? @"favorite-banner" : @"mac-banner");return cell;
}
@end
@interface Preferences : NSObject
@property(nonatomic,copy) NSString *accountID;
@property(nonatomic) BOOL filterDuplicates;
@end
@implementation Preferences @end
@interface CSGroupListAdapter : NSObject
@property(nonatomic,strong) MainFrameTableView *table;
@property(nonatomic,strong) NativeHost *controller;
@property(nonatomic,strong) Preferences *preferences;
@property(nonatomic,strong) CSCloseFriendListShield *privacyShield;
@property(nonatomic,copy) NSDictionary *neutralViewport;
@property(nonatomic) BOOL finishingNeutralPublication;
@property(nonatomic) CGSize retainedContentSize;
@property(nonatomic,copy) NSArray<NSNumber *> *retainedSectionCounts;
@property(nonatomic,strong) CSGroupProjection *projection;
@property(nonatomic,strong) NSDictionary *identityDisplayPaths;
@property(nonatomic,strong) NSMutableSet *prefetchedPaths;
@property(nonatomic,strong) NSMutableArray *nativeActions;
@property(nonatomic) BOOL projecting,dirty,publishing,nativePresentation,pendingScrollToTop,snapshotRetryAttempted,publicationNeedsFullReload;
@property(nonatomic) BOOL searching,presentationSuspended,privacyRefreshPending;
@property(nonatomic) NSUInteger snapshotRetryGeneration,changeDepth,recoveries,modelRevision;
- (BOOL)isActive;
- (void)refresh;
- (void)requestRecovery;
- (void)requestRefresh;
- (void)scheduleRefresh;
- (void)layout;
- (void)beginNativeChange;
- (void)endNativeChange;
- (BOOL)forwardSwipeInvocation:(NSInvocation *)inv target:(id)target;
// This suite has no retained return viewport; the layout-followup suite uses
// the real production viewport helpers and an inset/offset lifecycle double.
- (NSNumber *)presentationScrollHeight;
- (void)restoreScrollHeight:(CGFloat)height;
- (void)shieldVisiblePrivateRows;
- (void)neutralizeVisibleContent;
- (void)finishNeutralPublication:(BOOL)completed;
- (void)performVisibleLayout:(void (^)(void))layout;
+ (instancetype)adapterForTable:(id)table;
- (void)publishProjection:(CSGroupProjection *)projection previous:(CSGroupProjection *)previous changes:(CSGroupChangeKind)changes contentUserNames:(NSSet *)names contentIdentityKnown:(BOOL)known previouslyProjecting:(BOOL)previouslyProjecting;
@end
@implementation CSGroupListAdapter
#include "GroupReturnPrivacyBodies.h"
- (BOOL)isActive { return self.projecting; }
+ (instancetype)adapterForTable:(id)table { return [table adapter]; }
- (void)requestRecovery { self.recoveries++;self.dirty=YES; }
- (void)requestRefresh { self.dirty=YES; }
- (void)scheduleRefresh {}
- (void)layout {}
- (NSNumber *)presentationScrollHeight { return nil; }
- (void)restoreScrollHeight:(CGFloat)height { (void)height; }
- (void)beginNativeChange { self.changeDepth++; }
- (void)endNativeChange { self.changeDepth--; }
- (void)recordRefreshEvent:(NSString *)event delay:(NSTimeInterval)delay { (void)event;(void)delay; }
- (BOOL)forwardSwipeInvocation:(NSInvocation *)inv target:(id)target { (void)inv;(void)target;return NO; }
// The host refresh boundary deliberately leaves production projection building,
// privacy filtering and publication planning unmodified. UI admission/chrome and
// viewport restoration belong to the existing lifecycle/viewport suites.
- (void)refresh {
    if (self.publishing || self.changeDepth) { self.dirty=YES;return; }
    self.publishing=YES;
    @try {
        CSGroupProjection *previous=self.projection;BOOL was=self.projecting;
        NSArray *sections=CSGroupBuildNativeSections(self.controller,self.table,self.controller);
        CSGroupProjection *next=[self projectionForSections:sections tabs:@[[WESessionTabItem tabWithType:WETabTypeAll]] selectedTabID:@"preset_0" accountID:account];
        self.projection=next;self.projecting=next.isValid;self.dirty=NO;
        NSMutableDictionary *paths=[NSMutableDictionary dictionary];
        for (NSUInteger s=0;s<next.sections.count;s++) for (NSUInteger r=0;r<next.sections[s].count;r++) {
            CSGroupRow *row=next.sections[s][r];if(row.userName)paths[row.userName]=[NSIndexPath indexPathForRow:(NSInteger)r inSection:(NSInteger)s];
        }
        self.identityDisplayPaths=paths;
        [self.privacyShield prepareForPublication];
        [self publishProjection:next previous:previous changes:CSGroupChangeUnknown contentUserNames:nil contentIdentityKnown:YES previouslyProjecting:was];
        self.privacyRefreshPending=NO;
    } @finally { self.publishing=NO; }
}
@end
static CSGroupListAdapter *Adapter(id owner) { return [owner isKindOfClass:NativeHost.class] ? [(NativeHost *)owner m_tableView].adapter : nil; }
#include "GroupReturnPrivacyNative.h"
#include "GroupReturnPrivacyLayout.h"
static NSInteger Count(CSGroupListAdapter *adapter,SEL selector,BOOL rows) {
    NSInvocation *inv=[NSInvocation invocationWithMethodSignature:[adapter.controller methodSignatureForSelector:selector]];
    inv.selector=selector;__unsafe_unretained id table=adapter.table;[inv setArgument:&table atIndex:2];
    if (rows) { NSInteger section=0;[inv setArgument:&section atIndex:3]; }
    [adapter forwardInvocation:inv target:adapter.controller];NSInteger value=0;[inv getReturnValue:&value];return value;
}
@implementation MainFrameTableView
- (CALayer *)layer { if(!_layer)_layer=[CALayer layer];return _layer; }
- (void)setContentOffset:(CGPoint)value { _contentOffset=value;self.offsetWrites++; }
- (void)layoutSubviews { self.layouts++;HookMainFrameLayout(self,^{ [self originalLayout]; }); }
- (void)originalLayout {
    NSMutableArray *identities=[NSMutableArray array],*cells=[NSMutableArray array];
    NSInteger sections=Count(self.adapter,@selector(numberOfSectionsInTableView:),NO);
    if(sections>0) {
        NSInteger rows=Count(self.adapter,@selector(tableView:numberOfRowsInSection:),YES);
        for (NSInteger r=0;r<rows;r++) {
            UITableViewCell *cell=[self.adapter cellForDisplayPath:Path((NSUInteger)r) target:self.host];
            [cells addObject:cell];[identities addObject:cell.textLabel.text ?: @"empty"];
        }
    }
    self.visibleCells=cells;[self.submissions addObject:[identities copy]];
}
- (void)layoutIfNeeded { [self layoutSubviews]; }
- (void)reloadData { self.reloads++; }
- (void)reloadRowsAtIndexPaths:(NSArray *)paths withRowAnimation:(NSInteger)animation { (void)paths;(void)animation;self.rowReloads++; }
@end
static NSUInteger checks,failures;
static void Check(BOOL pass,NSString *message) { checks++;if(!pass){failures++;fprintf(stderr,"FAIL: %s\n",message.UTF8String);} }
static NSArray *Safe(void) { return @[@"favorite-banner",@"mac-banner",@"ordinary-a",@"ordinary-b"]; }
static NSArray *All(void) { return @[@"favorite-banner",@"mac-banner",@"ordinary-a",@"secret-friend",@"secret@chatroom",@"ordinary-b"]; }
static CSGroupListAdapter *List(void) {
    CSGroupListAdapter *a=[CSGroupListAdapter new];a.controller=[NativeHost new];a.table=[MainFrameTableView new];
    a.controller.m_tableView=a.table;a.table.host=a.controller;a.table.adapter=a;a.table.submissions=[NSMutableArray array];
    a.controller.sessions=[NSMutableArray array];
    for(id name in @[NSNull.null,NSNull.null,@"ordinary-a",@"secret-friend",@"secret@chatroom",@"ordinary-b"]) {
        NativeSession *s=[NativeSession new];s.m_nsUserName=name==NSNull.null?nil:name;[a.controller.sessions addObject:s];
    }
    a.table.indexPathsForVisibleRows=@[Path(0),Path(1),Path(2),Path(3)];
    a.table.contentOffset=CGPointMake(0,243);a.table.offsetWrites=0;a.preferences=[Preferences new];a.nativeActions=[NSMutableArray array];
    [a refresh];[a.table.submissions removeAllObjects];a.table.reloads=0;a.table.rowReloads=0;a.controller.privateCellCalls=0;
    return a;
}
static void ReturnLayout(CSGroupListAdapter *a) { Native(a.controller,NO,^{ [a.table layoutSubviews]; }); }
static BOOL NoSecrets(NSArray *submissions) {
    for(NSArray *identities in submissions) for(NSString *name in identities) if([name hasPrefix:@"secret"])return NO;return YES;
}
static void Trace(CSGroupListAdapter *a,NSString *mode) {
    NSString *identities=[[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:a.table.submissions options:0 error:NULL] encoding:NSUTF8StringEncoding];
    printf("%s: %lu visible-layout samples; identities=%s; native secret cell calls=%lu; full reloads=%lu; row reloads=%lu\n",
        mode.UTF8String,(unsigned long)a.table.submissions.count,identities.UTF8String,
        (unsigned long)a.controller.privateCellCalls,(unsigned long)a.table.reloads,(unsigned long)a.table.rowReloads);
}
static void CheckCommon(CSGroupListAdapter *a,NSString *mode) {
    Trace(a,mode);
    Check(!CSGroupUsesNativeIndices(a.table),[mode stringByAppendingString:@": native scope unwinds after layout"]);
    Check(a.table.contentOffset.y==243 && !a.table.offsetWrites,[mode stringByAppendingString:@": no scroll position write"]);
}
int main(void) { @autoreleasepool {
    policy=Policy(NO,NO,1);Check(CSGroupApplicationActive() && CSGroupPrivacyActive(),@"fixture uses the real locked privacy decision");CSGroupListAdapter *a=List();ReturnLayout(a);
    Check(a.table.submissions.count==1,@"locked return submits list content once");
    Check([a.table.submissions.firstObject isEqual:Safe()],@"locked first visible submission already filters friend and group");
    Check(NoSecrets(a.table.submissions) && !a.controller.privateCellCalls,@"locked return never asks native renderer for secret cells");
    Check(!a.table.reloads && !a.table.rowReloads,@"unchanged locked return adds no table reload");CheckCommon(a,@"locked");

    policy=Policy(YES,NO,2);a=List();ReturnLayout(a);
    Check(a.table.submissions.count==1 && [a.table.submissions.firstObject isEqual:All()],@"revealed return preserves existing friend and group visibility");
    Check(a.controller.privateCellCalls==2 && !a.table.reloads,@"revealed return renders native secret rows without new reload");CheckCommon(a,@"revealed");

    policy=Policy(YES,NO,3);a=List();policy=Policy(NO,NO,4);a.dirty=NO;ReturnLayout(a);
    Check(a.table.submissions.count>0 && [a.table.submissions.firstObject isEqual:Safe()],@"relock before async notification filters the stale revealed projection before first delivery");
    Check(NoSecrets(a.table.submissions) && !a.controller.privateCellCalls,@"relock return has no intermediate unfiltered submission");CheckCommon(a,@"relock");

    policy=Policy(NO,NO,5);a=List();policy=Policy(NO,YES,6);a.dirty=YES;ReturnLayout(a);
    Check(NoSecrets(a.table.submissions) && !a.controller.privateCellCalls,@"late blocked policy never publishes native unfiltered content");
    Check(!a.table.submissions.count || !a.table.submissions.firstObject.count || [a.table.submissions.firstObject isEqual:Safe()],@"unready policy keeps safe prior content or publishes an empty list");
    Trace(a,@"late policy blocked phase");
    policy=Policy(NO,NO,7);a.dirty=YES;ReturnLayout(a);
    Check([a.table.submissions.lastObject isEqual:Safe()] && NoSecrets(a.table.submissions),@"late ready policy publishes filtered rows with no unfiltered intermediate frame");CheckCommon(a,@"late policy");

    policy=Policy(YES,NO,8);a=List();policy=Policy(NO,NO,9);a.dirty=NO;a.changeDepth=1;
    NSArray *priorCells=a.table.visibleCells;ReturnLayout(a);
    Check(!a.table.submissions.count && !a.controller.privateCellCalls,@"pending native transaction refuses unsafe visible-layout submission");
    BOOL concealed=YES,ordinaryVisible=YES;
    for(UITableViewCell *cell in priorCells) {
        if([cell.textLabel.text hasPrefix:@"secret"])concealed&=cell.hidden;
        else ordinaryVisible&=!cell.hidden;
    }
    Check(concealed && ordinaryVisible,@"pending native transaction synchronously shields only prior secret cells");
    a.changeDepth=0;ReturnLayout(a);
    Check([a.table.submissions.firstObject isEqual:Safe()] && NoSecrets(a.table.submissions),@"native transaction completion delivers only the safe projection");CheckCommon(a,@"native transaction");

    policy=Policy(NO,NO,10);a=List();[a.table layoutSubviews];
    Check(a.table.submissions.count==1 && [a.table.submissions.firstObject isEqual:Safe()],@"ordinary display scope stays filtered without a native lifecycle wrapper");
    Check(!a.table.reloads && !a.table.rowReloads,@"ordinary filtered layout does not add full or row reloads");CheckCommon(a,@"display");
    policy=Policy(NO,NO,11);a=List();
    a.projection=[[CSGroupProjection alloc] initWithSections:@[] tabs:@[[WESessionTabItem tabWithType:WETabTypeAll]] selectedTabID:@"preset_0" filterDuplicates:NO accountID:account];
    a.dirty=YES;ReturnLayout(a);ReturnLayout(a);
    Check(a.table.submissions.count==2 && !a.table.submissions[0].count && !a.table.submissions[1].count,@"revision-zero native-recovery placeholder stays empty through repeated layout");
    Check(!a.table.reloads && !a.table.rowReloads && !a.recoveries,@"revision-zero placeholder cannot start a per-layout snapshot or reload recovery loop");CheckCommon(a,@"native fallback placeholder");

    policy=Policy(NO,YES,12);a=List();
    a.projection=[[CSGroupProjection alloc] initWithSections:@[@[]] tabs:@[[WESessionTabItem tabWithType:WETabTypeAll]] selectedTabID:@"preset_0" filterDuplicates:NO accountID:account hiddenUserNames:[NSSet set] privacyRevision:12 previousProjection:nil];
    ReturnLayout(a);
    Check(a.table.submissions.count==1 && !a.table.submissions.firstObject.count,@"blocked policy accepts empty sections without native content");
    Check(!a.table.reloads && !a.table.rowReloads,@"blocked existing safe empty sections need no reconstruction");CheckCommon(a,@"blocked empty section");

    printf("Group return privacy: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
    return failures?1:0;
} }
