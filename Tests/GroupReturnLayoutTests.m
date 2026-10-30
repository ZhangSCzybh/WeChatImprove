// Layout follow-up: production privacy/index/viewport/card-role logic with a
// deterministic UIKit geometry double. This is not a device frame measurement.
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
- (CGFloat)tableView:(id)table heightForRowAtIndexPath:(NSIndexPath *)path { (void)table;return [(NativeSession *)[self getSessionInfoAtIndexPath:path] fixtureHeight]; }
- (id)m_mainFrameLogicController { return self; }
- (NSInteger)numberOfSectionsInTableView:(id)table { (void)table;return (NSInteger)self.sections.count; }
- (NSInteger)tableView:(id)table numberOfRowsInSection:(NSInteger)section { (void)table;return section>=0 && (NSUInteger)section<self.sections.count ? (NSInteger)self.sections[(NSUInteger)section].count : 0; }
- (id)getSessionInfoAtIndexPath:(NSIndexPath *)path { return path.length==2 && (NSUInteger)path.section<self.sections.count && (NSUInteger)path.row<self.sections[(NSUInteger)path.section].count ? self.sections[(NSUInteger)path.section][(NSUInteger)path.row] : nil; }
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
@interface Preferences : NSObject
@property(nonatomic) BOOL filterDuplicates;
@property(nonatomic,copy) NSString *accountID;
@end
@implementation Preferences @end
@interface CSGroupListAdapter : NSObject
@property(nonatomic,strong) MainFrameTableView *table;
@property(nonatomic,strong) NativeHost *controller;
@property(nonatomic,strong) Preferences *preferences;
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
#include "GroupReturnLayoutViewport.h"
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
// The host refresh boundary deliberately leaves production projection building,
// privacy filtering and publication planning unmodified. UI admission/chrome and
// viewport restoration belong to the existing lifecycle/viewport suites.
- (void)refresh {
    if (self.publishing || self.changeDepth) { self.dirty=YES;return; }
    self.publishing=YES;
    @try {
        CSGroupProjection *previous=self.projection;BOOL was=self.projecting;
        NSArray *sections=CSGroupBuildNativeSections(self.controller,self.table,self.controller);
        CSGroupProjection *next=[self projectionForSections:sections tabs:@[[WESessionTabItem tabWithType:WETabTypeGroup]] selectedTabID:[WESessionTabItem tabWithType:WETabTypeGroup].tabId accountID:account];
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
    [adapter forwardInvocation:inv target:adapter.controller];NSInteger value=0;[inv getReturnValue:&value];return value;
}
static CGFloat Height(CSGroupListAdapter *adapter,NSIndexPath *path) {
    SEL selector=@selector(tableView:heightForRowAtIndexPath:);
    NSInvocation *inv=[NSInvocation invocationWithMethodSignature:[adapter.controller methodSignatureForSelector:selector]];
    inv.selector=selector;__unsafe_unretained id table=adapter.table;__unsafe_unretained id row=path;
    [inv setArgument:&table atIndex:2];[inv setArgument:&row atIndex:3];
    [adapter forwardInvocation:inv target:adapter.controller];CGFloat value=0;[inv getReturnValue:&value];return value;
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
        y+=12;NSMutableArray *rows=[NSMutableArray array];
        for(NSInteger r=0;r<rowCount;r++) {
            NSIndexPath *path=At((NSUInteger)s,(NSUInteger)r);CGFloat height=Height(self.adapter,path);
            UITableViewCell *cell=[self.adapter cellForDisplayPath:path target:self.host];
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
static NSUInteger checks,failures;
static void Check(BOOL pass,NSString *message) { checks++;if(!pass){failures++;fprintf(stderr,"FAIL: %s\n",message.UTF8String);} }
static void ResetSamples(CSGroupListAdapter *a) {
    [a.table.submissions removeAllObjects];[a.table.geometrySamples removeAllObjects];[a.table.completedLayouts removeAllObjects];
    a.table.originalCalculations=0;a.table.reloads=0;a.table.rowReloads=0;a.table.offsetWrites=0;a.controller.privateCellCalls=0;
}
static CSGroupListAdapter *List(BOOL decoratorOutside,BOOL emptyPinned) {
    CSGroupListAdapter *a=[CSGroupListAdapter new];a.controller=[NativeHost new];a.table=[MainFrameTableView new];
    a.controller.m_tableView=a.table;a.table.host=a.controller;a.table.adapter=a;
    a.table.submissions=[NSMutableArray array];a.table.geometrySamples=[NSMutableArray array];a.table.completedLayouts=[NSMutableArray array];
    a.table.decoratorOutside=decoratorOutside;a.table.bounds=CGRectMake(0,0,320,600);a.table.contentSize=CGSizeMake(320,1800);
    NSMutableArray *normal=[@[@"secret@chatroom",@"normal-a@chatroom",@"gh_official",@"normal-b@chatroom",@"ordinary-private",@"brandservicesessionholder"] mutableCopy];
    for(NSUInteger i=0;i<12;i++)[normal addObject:[NSString stringWithFormat:@"extra-%lu@chatroom",(unsigned long)i]];
    NSArray *pinned=emptyPinned ? @[@"pinned-private",@"secret-friend",@"brandsessionholder"] :
        @[@"pinned-private",@"pinned-a@chatroom",@"secret-friend",@"pinned-b@chatroom",@"brandsessionholder"];
    NSArray *names=@[@[NSNull.null,NSNull.null],pinned,normal];NSMutableArray *sections=[NSMutableArray array];
    for(NSUInteger s=0;s<names.count;s++) {
        NSMutableArray *rows=[NSMutableArray array];
        for(NSUInteger r=0;r<[names[s] count];r++) {
            id name=names[s][r];NativeSession *session=[NativeSession new];session.m_nsUserName=name==NSNull.null?nil:name;
            session.m_bIsTop=s==1;session.fixtureHeight=s==0?34:((r%3)==0?70:64);[rows addObject:session];
        }
        [sections addObject:rows];
    }
    a.controller.sections=sections;
    a.table.indexPathsForVisibleRows=@[At(0,0),At(0,1),At(1,0),At(1,1),At(2,0),At(2,1)];
    a.preferences=[Preferences new];a.preferences.accountID=account;a.nativeActions=[NSMutableArray array];a.anchors=[NSMutableDictionary dictionary];
    a.publishedTabID=[WESessionTabItem tabWithType:WETabTypeGroup].tabId;a.chromeVisible=YES;
    objc_setAssociatedObject(a.table,&RestoreKey,[CSListCornerSessionRestore new],OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [a refresh];a.table.adjustedContentInset=(UIEdgeInsets){100,0,0,0};a.table.contentOffset=CGPointMake(0,400);
    a.presentationViewport=@{@"height":@500,@"account":account,@"epoch":@(epoch)};ResetSamples(a);return a;
}
static NSDictionary *Stable(BOOL order,BOOL emptyPinned) {
    CSGroupListAdapter *stable=List(order,emptyPinned);stable.table.adjustedContentInset=(UIEdgeInsets){140,0,0,0};
    [stable restoreScrollHeight:500];
    CSGroupWithDisplayIndices(stable.table,^{[stable.table originalLayout];});
    return stable.table.geometrySamples.lastObject;
}
static void Entrance(CSGroupListAdapter *a,BOOL reenter) {
    a.table.adjustedContentInset=(UIEdgeInsets){140,0,0,0};a.table.contentOffset=CGPointMake(0,-25);a.table.offsetWrites=0;a.table.reenterOnce=reenter;
    Native(a.controller,NO,^{[a.table layoutSubviews];});
}
static NSArray *Flatten(NSDictionary *sample) {
    NSMutableArray *rows=[NSMutableArray array];for(NSArray *section in sample[@"sections"])for(NSDictionary *row in section)[rows addObject:row];return rows;
}
static void Compare(CSGroupListAdapter *a,NSDictionary *expected,NSString *mode) {
    NSDictionary *first=a.table.completedLayouts.firstObject;
    Check(first!=nil,[mode stringByAppendingString:@": original layout produced a complete sampled result"]);
    Check([first[@"sectionCounts"] isEqual:expected[@"sectionCounts"]],[mode stringByAppendingString:@": first section structure equals selected Group stable state"]);
    NSArray *actualRows=Flatten(first),*expectedRows=Flatten(expected);
    Check(actualRows.count==expectedRows.count,[mode stringByAppendingString:@": first layout row count equals filtered stable state"]);
    for(NSUInteger r=0;r<expectedRows.count;r++) {
        NSDictionary *row=r<actualRows.count?actualRows[r]:nil,*ref=expectedRows[r];
        Check([row[@"name"] isEqual:ref[@"name"]],[NSString stringWithFormat:@"%@: row %lu uses stable filtered identity",mode,(unsigned long)r]);
        Check([row[@"y"] isEqual:ref[@"y"]] && [row[@"height"] isEqual:ref[@"height"]],[NSString stringWithFormat:@"%@: row %lu y/height equals stable geometry",mode,(unsigned long)r]);
        Check([row[@"roleValid"] isEqual:ref[@"roleValid"]] && [row[@"first"] isEqual:ref[@"first"]] && [row[@"last"] isEqual:ref[@"last"]],
            [NSString stringWithFormat:@"%@: row %lu native decorator gets stable first/last card role",mode,(unsigned long)r]);
    }
    Check([first[@"offsetX"] isEqual:expected[@"offsetX"]] && [first[@"offsetY"] isEqual:expected[@"offsetY"]],[mode stringByAppendingString:@": first complete layout offset equals restored stable viewport"]);
    BOOL consistent=YES;for(NSDictionary *sample in a.table.completedLayouts)if(![sample isEqual:expected])consistent=NO;
    Check(consistent,[mode stringByAppendingString:@": every complete layout uses the same safe final geometry and viewport"]);
    Check(!CSGroupUsesNativeIndices(a.table),[mode stringByAppendingString:@": owner native-index scope unwinds"]);
    NSString *sectionJSON=[[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:first[@"sectionCounts"] ?: @[] options:0 error:NULL] encoding:NSUTF8StringEncoding];
    printf("%s: originalLayout calculations=%lu; completed hook returns=%lu; first sections=%s; first offset=%s; expected offset=%s; full reloads=%lu; row reloads=%lu\n",
        mode.UTF8String,(unsigned long)a.table.originalCalculations,(unsigned long)a.table.completedLayouts.count,
        sectionJSON.UTF8String,[first[@"offsetY"] description].UTF8String,[expected[@"offsetY"] description].UTF8String,
        (unsigned long)a.table.reloads,(unsigned long)a.table.rowReloads);
}
int main(void) { @autoreleasepool {
    Check(CSGroupApplicationActive() && groupEnabled,@"fixture retains active native host and actual selected Group projection");
    for(NSNumber *outside in @[@NO,@YES]) {
        BOOL order=outside.boolValue;NSString *label=order?@"decorator outside":@"privacy outside";
        policy=Policy(NO,NO,1);NSDictionary *stable=Stable(order,NO);CSGroupListAdapter *a=List(order,NO);a.dirty=YES;Entrance(a,NO);Compare(a,stable,[label stringByAppendingString:@" locked"]);
        Check(!a.table.reloads && !a.table.rowReloads,[label stringByAppendingString:@": stable return does not add table reconstruction"]);
        policy=Policy(NO,NO,2);stable=Stable(order,YES);a=List(order,YES);Entrance(a,NO);Compare(a,stable,[label stringByAppendingString:@" empty selected section"]);
        Check([stable[@"sectionCounts"][1] unsignedIntegerValue]==0,@"real Group projection preserves an empty native pinned section after membership filtering");
        policy=Policy(YES,NO,3);a=List(order,NO);policy=Policy(NO,NO,4);stable=Stable(order,NO);Entrance(a,NO);Compare(a,stable,[label stringByAppendingString:@" relock"]);
        policy=Policy(NO,NO,5);a=List(order,NO);policy=Policy(NO,YES,6);NSDictionary *empty=Stable(order,NO);Entrance(a,NO);Compare(a,empty,[label stringByAppendingString:@" blocked"]);
        ResetSamples(a);policy=Policy(NO,NO,7);stable=Stable(order,NO);Entrance(a,NO);Compare(a,stable,[label stringByAppendingString:@" ready"]);
        policy=Policy(YES,NO,8);stable=Stable(order,NO);a=List(order,NO);Entrance(a,NO);Compare(a,stable,[label stringByAppendingString:@" revealed"]);
        NSArray *revealed=Flatten(stable);BOOL foundGroup=NO,foundPrivate=NO;
        for(NSDictionary *row in revealed){foundGroup|=[row[@"name"] isEqual:@"secret@chatroom"];foundPrivate|=[row[@"name"] isEqual:@"secret-friend"];}
        Check(foundGroup && !foundPrivate,@"revealed Group semantics show protected group while ordinary protected private chat remains outside selected Group");
        policy=Policy(NO,NO,9);stable=Stable(order,NO);a=List(order,NO);Entrance(a,YES);Compare(a,stable,[label stringByAppendingString:@" same-owner reentry"]);
        Check(a.table.originalCalculations==2,[label stringByAppendingString:@": same native owner reentry executes exactly two original-layout calculations"]);
        policy=Policy(NO,NO,10);a=List(order,NO);
        NSMutableArray *sections=[a.controller.sections mutableCopy],*normal=[sections[2] mutableCopy];NativeSession *added=[NativeSession new];added.m_nsUserName=@"arrived-while-away@chatroom";added.fixtureHeight=68;[normal insertObject:added atIndex:1];
        [normal removeObjectAtIndex:3];NSMutableArray *pinned=[sections[1] mutableCopy];NativeSession *moved=normal.lastObject;[normal removeLastObject];moved.m_bIsTop=YES;[pinned insertObject:moved atIndex:1];sections[1]=pinned;sections[2]=normal;a.controller.sections=sections;a.dirty=YES;
        CSGroupListAdapter *reference=List(order,NO);reference.controller.sections=sections;[reference refresh];reference.table.adjustedContentInset=(UIEdgeInsets){140,0,0,0};[reference restoreScrollHeight:500];ResetSamples(reference);CSGroupWithDisplayIndices(reference.table,^{[reference.table originalLayout];});
        stable=reference.table.geometrySamples.lastObject;Entrance(a,NO);Compare(a,stable,[label stringByAppendingString:@" dirty structure"]);
    }
    printf("Group return layout: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);return failures?1:0;
} }
