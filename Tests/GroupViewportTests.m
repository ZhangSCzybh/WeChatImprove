// Production method bodies + small host doubles. No real defaults, accounts or UI.
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import <dispatch/dispatch.h>
#import <math.h>

typedef struct { CGFloat top,left,bottom,right; } UIEdgeInsets;
@interface NSIndexPath (GroupViewport)
+ (instancetype)indexPathForRow:(NSInteger)row inSection:(NSInteger)section;
@end
@implementation NSIndexPath (GroupViewport)
+ (instancetype)indexPathForRow:(NSInteger)row inSection:(NSInteger)section {
    NSUInteger indexes[]={(NSUInteger)section,(NSUInteger)row};
    return [self indexPathWithIndexes:indexes length:2];
}
@end
@interface UITableView : NSObject
@property(nonatomic) CGRect bounds;
@property(nonatomic) CGSize contentSize;
@property(nonatomic) CGPoint contentOffset;
@property(nonatomic) UIEdgeInsets adjustedContentInset;
@property(nonatomic) UIEdgeInsets contentInset;
@property(nonatomic,strong) id window;
@property(nonatomic) BOOL tracking,dragging,decelerating,editing;
@property(nonatomic) CGFloat decelerationRate;
@property(nonatomic,strong) id tableHeaderView;
@property(nonatomic,strong) NSArray *indexPathsForVisibleRows;
@property(nonatomic,strong) NSDictionary<NSIndexPath *,NSNumber *> *rowOrigins;
@property(nonatomic) NSUInteger offsetWrites;
- (CGRect)rectForRowAtIndexPath:(NSIndexPath *)path;
- (void)setContentOffset:(CGPoint)point animated:(BOOL)animated;
@end
@implementation UITableView
- (CGRect)rectForRowAtIndexPath:(NSIndexPath *)path { return CGRectMake(0,[self.rowOrigins[path] doubleValue],320,80); }
- (void)setContentOffset:(CGPoint)point animated:(BOOL)animated { (void)animated; self.offsetWrites++; self.contentOffset=point; }
@end
@interface HostController : NSObject
@property(nonatomic,strong) UITableView *m_tableView;
@property(nonatomic) BOOL isSearching;
@end
@implementation HostController @end
@interface CSGroupRow : NSObject
@property(nonatomic,copy) NSString *userName;
@property(nonatomic) NSUInteger kind;
@end
@implementation CSGroupRow @end
@interface CSGroupProjection : NSObject
@property(nonatomic,strong) NSArray<NSArray<CSGroupRow *> *> *sections;
- (CSGroupRow *)rowAtDisplayPath:(NSIndexPath *)path;
@end
@implementation CSGroupProjection
- (CSGroupRow *)rowAtDisplayPath:(NSIndexPath *)path {
    if (!path || path.length!=2) return nil;
    NSUInteger section=[path indexAtPosition:0],row=[path indexAtPosition:1];
    return section<self.sections.count && row<self.sections[section].count ? self.sections[section][row] : nil;
}
@end
@interface CSGroupPreferences : NSObject
@property(nonatomic,copy) NSString *accountID;
@end
@implementation CSGroupPreferences @end
static char AdapterKey;
static BOOL enabled=YES;
static NSString *account=@"test-account";
static NSHashTable *Adapters(void) {
    static NSHashTable *adapters;
    if (!adapters) adapters=[NSHashTable weakObjectsHashTable];
    return adapters;
}
static BOOL Option(NSString *suffix) { (void)suffix; return enabled; }
static NSString *CSGroupCurrentAccountID(void) { return account; }
static id CSGroupReadObject(id object,NSString *name) { return [object valueForKey:name]; }
static long long CSGroupReadInteger(id object,NSString *name,long long fallback) {
    return object ? [[object valueForKey:name] longLongValue] : fallback;
}
static void CSGroupWithDisplayIndices(id table,void (^body)(void)) { (void)table; body(); }

@interface CSGroupListAdapter : NSObject
@property(nonatomic,weak) UITableView *table;
@property(nonatomic,weak) HostController *controller;
@property(nonatomic,strong) CSGroupPreferences *preferences;
@property(nonatomic,strong) CSGroupProjection *projection;
@property(nonatomic,strong) NSMutableDictionary *proxies,*anchors;
@property(nonatomic,strong) NSMutableArray *completions,*nativeActions;
@property(nonatomic,strong) NSMutableSet *prefetchedPaths;
@property(nonatomic,strong) id nativeHeader;
@property(nonatomic) CGFloat baselineDeceleration;
@property(nonatomic) BOOL dirty,searching,publishedEnabled,scheduled,publishing;
@property(nonatomic) BOOL active;
@property(nonatomic) NSUInteger changeDepth,refreshCount,layoutCount,detachCount;
@property(nonatomic,copy) NSString *publishedTabID;
- (BOOL)isActive;
+ (instancetype)adapterForController:(id)controller;
+ (void)attachToController:(id)controller;
- (void)refresh;
- (void)layout;
- (void)detach;
- (void)saveAnchor;
- (void)restoreAnchor;
- (void)requestRefresh;
@end
@implementation CSGroupListAdapter
#include "GroupViewportBodies.h"
- (BOOL)isActive { return self.active; }
- (void)refresh {
    self.refreshCount++; self.dirty=NO;
    self.preferences=[CSGroupPreferences new]; self.preferences.accountID=account;
    self.publishedEnabled=enabled; self.searching=self.controller.isSearching;
}
- (void)layout { self.layoutCount++; }
- (void)detach { self.detachCount++; objc_setAssociatedObject(self.table,&AdapterKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
@end

static NSUInteger checks,failures;
static void Check(BOOL condition,NSString *message) {
    checks++;
    if (!condition) { failures++; fprintf(stderr,"FAIL: %s\n",message.UTF8String); }
}
static BOOL Near(CGFloat a,CGFloat b) { return fabs(a-b)<0.001; }
static CSGroupListAdapter *List(HostController **owner,CGFloat height) {
    HostController *host=[HostController new]; host.m_tableView=[UITableView new];
    [CSGroupListAdapter attachToController:host];
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForController:host];
    a.active=YES; a.publishedTabID=@"private";
    a.table.bounds=CGRectMake(0,0,320,700);
    a.table.contentSize=CGSizeMake(320,height);
    a.table.adjustedContentInset=(UIEdgeInsets){100,0,30,0};
    a.table.contentOffset=CGPointMake(7,-20);
    a.projection=[CSGroupProjection new];
    CSGroupRow *row=[CSGroupRow new]; row.userName=@"fixture-row";
    a.projection.sections=@[@[row]];
    NSIndexPath *path=[NSIndexPath indexPathForRow:0 inSection:0];
    a.table.indexPathsForVisibleRows=@[path]; a.table.rowOrigins=@{path:@60};
    *owner=host; return a;
}
static void Drain(CSGroupListAdapter *a) {
    NSDate *deadline=[NSDate dateWithTimeIntervalSinceNow:1];
    while (a.scheduled && deadline.timeIntervalSinceNow>0)
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.002]];
    Check(!a.scheduled,@"queued refresh completed");
}
int main(void) { @autoreleasepool {
    HostController *host=nil;
    CSGroupListAdapter *a=List(&host,240);
    Check(a.refreshCount==1,@"first attachment initializes the projection once");
    for (NSUInteger i=0;i<8;i++) [CSGroupListAdapter attachToController:host];
    Check(a.refreshCount==1,@"repeated will/did appear without changes does not reload");
    Check(a.layoutCount==9,@"appearance still reconciles header layout");
    Check(a.table.offsetWrites==0,@"appearance does not force a scroll");
    NSUInteger before=a.refreshCount;
    a.dirty=YES; [CSGroupListAdapter attachToController:host];
    Check(a.refreshCount==before+1,@"pending native changes still publish on appearance");
    before=a.refreshCount; enabled=NO; [CSGroupListAdapter attachToController:host];
    Check(!a.publishedEnabled && a.refreshCount==before+1,@"disabling grouping still refreshes");
    before=a.refreshCount; enabled=YES; [CSGroupListAdapter attachToController:host];
    Check(a.publishedEnabled && a.refreshCount==before+1,@"enabling grouping still refreshes");
    before=a.refreshCount; host.isSearching=YES; [CSGroupListAdapter attachToController:host];
    Check(a.searching && a.refreshCount==before+1,@"native search activation is observed");
    before=a.refreshCount; host.isSearching=NO; [CSGroupListAdapter attachToController:host];
    Check(!a.searching && a.refreshCount==before+1,@"search cancellation is observed");
    before=a.refreshCount; account=@"other-test-account"; [CSGroupListAdapter attachToController:host];
    Check([a.preferences.accountID isEqual:account] && a.refreshCount==before+1,@"account switch refreshes");
    before=a.refreshCount; account=nil; [CSGroupListAdapter attachToController:host];
    [CSGroupListAdapter attachToController:host];
    Check(a.refreshCount==before+1,@"logged-out nil account does not reload on every appearance");
    account=@"test-account";
    CSGroupListAdapter *old=a;
    host.m_tableView=[UITableView new]; [CSGroupListAdapter attachToController:host];
    a=[CSGroupListAdapter adapterForController:host];
    Check(a!=old && old.detachCount==1 && a.refreshCount==1,@"replaced main table is detached and initialized");
    [a requestRefresh]; [CSGroupListAdapter attachToController:host];
    NSUInteger published=a.refreshCount; Drain(a);
    Check(a.refreshCount==published,@"queued request consumed by appearance does not reload again");
    [a requestRefresh]; [a requestRefresh]; published=a.refreshCount; Drain(a);
    Check(a.refreshCount==published+1,@"multiple pending updates publish once");

    // Reproduce the two/four-row return with a native offset different from -top.
    for (NSNumber *height in @[@0,@160,@320,@570]) {
        a=List(&host,height.doubleValue);
        a.anchors[a.publishedTabID]=@{@"name":@"fixture-row",@"kind":@0,@"offset":@(-80)};
        [a restoreAnchor];
        Check(Near(a.table.contentOffset.y,-20) && a.table.offsetWrites==0,@"short/empty/exact-fit list preserves the native offset");
        [a saveAnchor];
        Check(!a.anchors[a.publishedTabID],@"short list does not retain a stale row anchor");
    }
    a=List(&host,1600); [a saveAnchor];
    [a restoreAnchor];
    Check(a.table.offsetWrites==0,@"unchanged long-list anchor avoids redundant scroll callbacks");
    a.table.adjustedContentInset=(UIEdgeInsets){140,0,30,0};
    [a restoreAnchor];
    Check(Near(a.table.contentOffset.y,-60),@"navigation inset change preserves the row relative to the visible top");
    Check(Near(a.table.contentOffset.x,7),@"anchor restoration preserves horizontal offset");
    NSIndexPath *path=[NSIndexPath indexPathForRow:0 inSection:0];
    a.table.rowOrigins=@{path:@260}; [a restoreAnchor];
    Check(Near(a.table.contentOffset.y,140),@"long-list row movement restores the same visual anchor");
    a.table.rowOrigins=@{path:@5000}; [a restoreAnchor];
    Check(Near(a.table.contentOffset.y,930),@"long-list anchor clamps at the bottom");
    a.table.rowOrigins=@{path:@(-500)}; [a restoreAnchor];
    Check(Near(a.table.contentOffset.y,-140),@"long-list anchor clamps at the top");
    for (NSString *state in @[@"tracking",@"dragging",@"decelerating"]) {
        a=List(&host,1600); [a saveAnchor];
        [a.table setValue:@YES forKey:state];
        a.table.rowOrigins=@{path:@260}; [a restoreAnchor];
        Check(a.table.offsetWrites==0,@"touch/drag/deceleration stays under native control");
    }
    a=List(&host,1600); [a saveAnchor];
    NSDictionary *saved=a.anchors[a.publishedTabID];
    a.table.contentOffset=CGPointMake(7,-180); [a saveAnchor]; [a restoreAnchor];
    Check(a.table.offsetWrites==0 && [a.anchors[a.publishedTabID] isEqual:saved],@"pull-down bounce is neither captured nor overwritten");
    a.table.contentOffset=CGPointMake(7,-20); a.searching=YES; [a restoreAnchor];
    Check(a.table.offsetWrites==0,@"search transition does not restore a list anchor");
    a.searching=NO; a.table.bounds=CGRectZero; [a restoreAnchor];
    Check(a.table.offsetWrites==0,@"unlaid-out table does not restore an anchor");
    a=List(&host,1600); [a saveAnchor]; a.projection.sections=@[@[]]; [a restoreAnchor];
    Check(a.table.offsetWrites==0,@"deleted anchor leaves the host position intact");
    a=List(&host,1600); [a saveAnchor]; a.publishedTabID=@"group-without-anchor"; [a restoreAnchor];
    Check(a.table.offsetWrites==0,@"new group without an anchor leaves layout to the host");
    a=List(&host,1600); [a saveAnchor]; a.table.contentSize=CGSizeMake(320,NAN); [a restoreAnchor];
    Check(a.table.offsetWrites==0,@"nonfinite content geometry does not write an offset");
    fprintf(stdout,"Group viewport: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
    return failures ? 1 : 0;
} }
