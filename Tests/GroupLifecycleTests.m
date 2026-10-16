#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>
#import <objc/runtime.h>
#import <objc/message.h>
@class CSGroupListAdapter;
@interface UITableView : NSObject
@property(nonatomic) BOOL tracking,dragging,decelerating,editing;
@property(nonatomic) double decelerationRate;
@property(nonatomic,strong) id tableHeaderView;
@property(nonatomic) NSUInteger reloads;
- (void)setEditing:(BOOL)value animated:(BOOL)animated;
@end
@interface Host : NSObject
@property(nonatomic,strong) UITableView *m_tableView;
@property(nonatomic) BOOL isSearching;
@property(nonatomic) NSUInteger originalCalls;
- (void)nativeAppearance:(BOOL)animated;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)viewDidDisappear:(BOOL)animated;
@end
@interface CSGroupPreferences : NSObject
@property(nonatomic,copy) NSString *accountID;
@end
@implementation CSGroupPreferences @end
static char AdapterKey, PresentationSuspendedKey;
static NSString *account=@"account-A";
static BOOL enabled=YES;
static NSUInteger scopes;
static NSHashTable *Adapters(void) {
    static NSHashTable *adapters; if (!adapters) adapters=[NSHashTable weakObjectsHashTable]; return adapters;
}
static BOOL Option(NSString *key) { (void)key; return enabled; }
static NSString *CSGroupCurrentAccountID(void) { return account; }
static id CSGroupReadObject(id owner,NSString *key) { return [owner valueForKey:key]; }
static long long CSGroupReadInteger(id owner,NSString *key,long long fallback) { return owner ? [[owner valueForKey:key] longLongValue] : fallback; }
static void CSGroupWithNativeIndices(id table,void (^body)(void)) { (void)table; body(); }
static void CSGroupWithDisplayIndices(id table,void (^body)(void)) { (void)table; scopes++; body(); }
@interface CSGroupListAdapter : NSObject
@property(nonatomic,weak) UITableView *table;
@property(nonatomic,weak) Host *controller;
@property(nonatomic,strong) NSMutableDictionary *proxies,*anchors;
@property(nonatomic,strong) NSMutableArray *completions,*nativeActions;
@property(nonatomic,strong) NSMutableSet *prefetchedPaths;
@property(nonatomic,strong) id nativeHeader;
@property(nonatomic,strong) CSGroupPreferences *preferences;
@property(nonatomic) double baselineDeceleration;
@property(nonatomic) BOOL active,presentationSuspended,publishedEnabled,searching,dirty,scheduled,publishing,groupPanMoving,swipeActive,nativePresentation,updatingHeader,snapshotRetryAttempted;
@property(nonatomic) NSUInteger changeDepth,snapshotRetryGeneration,refreshCount,layoutCount,anchorOrTitleCount,menuReads,menuState;
+ (instancetype)adapterForController:(id)controller;
+ (instancetype)adapterForTable:(id)table;
+ (void)setPresentationSuspended:(BOOL)value forController:(id)controller;
- (void)refresh;
- (void)requestRefresh;
- (void)finishSuspendedBatches;
- (void)saveAnchor;
- (void)refreshNavigationTitle;
- (void)useNativePresentation;
@end
@implementation CSGroupListAdapter
#include "GroupLifecycleBodies.h"
- (BOOL)isActive { return self.active; }
- (NSUInteger)nativeMenuState { self.menuReads++; return self.menuState; }
- (void)reconcileDeletedSwipeRow {}
- (void)applyPendingScrollToTop {}
- (void)detach {
    self.presentationSuspended=YES; self.active=NO;
    [self.nativeActions removeAllObjects];
    objc_setAssociatedObject(self.table,&AdapterKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)publishFixture {
    self.refreshCount++;
    self.preferences=[CSGroupPreferences new]; self.preferences.accountID=account;
    self.publishedEnabled=enabled; self.searching=self.controller.isSearching;
    self.active=enabled && !self.searching && !self.nativePresentation;
    [self layout];
}
@end
static CSGroupListAdapter *Adapter(id owner) { return [CSGroupListAdapter adapterForController:owner]; }
static void Native(id owner,BOOL change,void (^body)(void)) { (void)owner; (void)change; body(); }
static BOOL Projected(CSGroupListAdapter *a) { return a.isActive && !a.publishing; }
@implementation Host
- (void)nativeAppearance:(BOOL)animated {
    (void)animated; self.originalCalls++;
    // Native lifecycle may itself produce a session/UI invalidation.
    [Adapter(self) requestRefresh];
}
#include "GroupLifecycleHooks.h"
@end
@implementation UITableView
- (void)setEditing:(BOOL)value animated:(BOOL)animated { (void)animated; self.editing=value; }
#include "GroupLifecycleReload.h"
@end
static NSUInteger checks,failures;
static void Check(BOOL condition,NSString *message) {
    checks++; if (!condition) { failures++; fprintf(stderr,"FAIL: %s\n",message.UTF8String); }
}
static void RunFor(double interval) { [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:interval]]; }
static CSGroupListAdapter *List(Host **owner) {
    Host *host=[Host new]; host.m_tableView=[UITableView new];
    [CSGroupListAdapter attachToController:host]; *owner=host;
    return Adapter(host);
}
int main(void) { @autoreleasepool {
    Host *host=nil; CSGroupListAdapter *a=List(&host);
    NSUInteger before=a.refreshCount, layouts=a.layoutCount;
    [host viewWillDisappear:YES]; [host viewDidDisappear:YES]; RunFor(.02);
    Check(a.presentationSuspended && host.originalCalls==2,@"native disappearance runs and suspends grouping");
    Check(a.refreshCount==before && a.layoutCount==layouts,@"disappearance's own invalidation does not publish");
    a.anchorOrTitleCount=0; a.menuReads=0;
    __block NSUInteger models=0;
    for (NSUInteger i=0;i<200;i++) {
        [a beginNativeChange]; models++; [a endNativeChange];
        [CSGroupListAdapter layoutForController:host];
        [CSGroupListAdapter attachToController:host];
        [a refresh];
    }
    [a saveAnchor]; [a restoreAnchor]; [a returnToGroupTop]; [a refreshNavigationTitle];
    RunFor(.08);
    Check(models==200 && !a.changeDepth,@"all native changes still execute and transactions balance");
    Check(a.refreshCount==before && a.layoutCount==layouts,@"200 hidden updates do zero publication or header layout");
    Check(!a.anchorOrTitleCount && !a.menuReads,@"hidden work avoids anchor/title work and menu scans");
    Check(a.dirty && !a.scheduled,@"hidden changes retain dirty state without polling");
    [CSGroupListAdapter settingsChanged]; RunFor(.02);
    Check(a.refreshCount==before && a.layoutCount==layouts,@"settings notifications also respect suspension");
    [host viewWillAppear:YES]; RunFor(.02);
    Check(!a.presentationSuspended && a.refreshCount==before+1 && !a.dirty,@"return publishes merged changes once");
    // An interactive pop toward the list may cancel and hide it again.
    [host viewWillDisappear:YES]; [host viewDidDisappear:YES]; before=a.refreshCount;
    [a requestRefresh]; RunFor(.08);
    Check(a.presentationSuspended && a.refreshCount==before && !a.scheduled,@"cancelled interactive return stays suspended");
    // A cancelled push gives appearance callbacks back to the list.
    [host viewWillAppear:YES]; [host viewDidAppear:YES]; RunFor(.02);
    Check(!a.presentationSuspended && !a.dirty,@"cancelled departure resumes on appearance callbacks");

    // Separate run-loop turns reproduce normal event delivery, not just one burst.
    a=List(&host); [host viewWillDisappear:NO]; RunFor(.02); before=a.refreshCount;
    for (NSUInteger i=0;i<20;i++) {
        [a beginNativeChange]; models++; [a endNativeChange]; RunFor(.004);
    }
    fprintf(stdout,"Hidden native event publications: %lu / 20 events\n",(unsigned long)(a.refreshCount-before));
    Check(a.refreshCount==before && !a.scheduled,@"events on separate run-loop turns do not rebuild the hidden list");

    a=List(&host); before=a.refreshCount;
    [a requestRefresh]; [host viewWillDisappear:YES]; RunFor(.08);
    Check(a.refreshCount==before && a.dirty && !a.scheduled,@"already queued immediate refresh rechecks visibility");
    a=List(&host); a.table.tracking=YES; [a requestRefresh];
    before=a.refreshCount; [host viewWillDisappear:YES]; RunFor(.16);
    Check(a.refreshCount==before && !a.scheduled,@"tracking wake-up stops rescheduling after departure");
    a=List(&host); a.groupPanMoving=YES; [a requestRefresh];
    before=a.refreshCount; [host viewWillDisappear:YES]; RunFor(.16);
    Check(a.refreshCount==before && !a.scheduled,@"group-pan polling stops after departure");
    a=List(&host); a.menuState=3; [a requestRefresh];
    before=a.refreshCount; [host viewWillDisappear:YES]; RunFor(.16);
    Check(a.refreshCount==before && !a.scheduled,@"custom-menu polling stops after departure");

    a=List(&host); [host viewWillDisappear:YES]; before=a.refreshCount;
    __block NSUInteger callbacks=0; __block BOOL completed=YES;
    [a performNativeBatch:^{ models++; } completion:^(BOOL finished) { callbacks++; completed=finished; }];
    Check(callbacks==1 && !completed && !a.completions.count,@"hidden batch completes once with interrupted UI semantics");
    [a beginNativeChange];
    [a performNativeBatch:^{ models++; } completion:^(BOOL finished) { (void)finished; callbacks++; }];
    Check(callbacks==1,@"nested batch waits for outer native transaction");
    [a endNativeChange];
    Check(callbacks==2 && !a.changeDepth && !a.completions.count,@"outer transaction drains hidden callbacks");
    @try {
        [a performNativeBatch:^{ @throw [NSException exceptionWithName:@"fixture" reason:nil userInfo:nil]; }
                   completion:^(BOOL finished) { (void)finished; callbacks++; }];
    } @catch (NSException *e) { (void)e; }
    Check(callbacks==3 && !a.changeDepth,@"throwing batch completes only once and balances depth");
    Check(a.refreshCount==before && !a.scheduled,@"batch completion does not force a hidden reload");
    // Explicit native navigation is intentionally allowed one native publication.
    __block NSUInteger actions=0;
    a.table.tracking=YES; a.table.editing=YES; a.swipeActive=YES; a.menuState=3;
    [a performInNativePresentation:^{ actions++; }];
    Check(actions==1 && a.refreshCount==before+1 && !a.nativeActions.count,@"explicit hidden navigation publishes native indices and drains action");
    Check(a.presentationSuspended && !a.active,@"native navigation does not resume ordinary hidden work");
    [a requestRefresh]; RunFor(.08);
    Check(a.refreshCount==before+1 && !a.scheduled,@"passive events after explicit navigation remain deferred");

    a=List(&host); [host viewWillDisappear:YES];
    [a beginNativeChange]; [a performInNativePresentation:^{ actions++; }];
    NSUInteger actionBefore=actions; account=@"account-B"; [a endNativeChange]; RunFor(.02);
    Check(actions==actionBefore && !a.nativeActions.count,@"queued navigation never crosses accounts");
    a=List(&host); [host viewWillDisappear:YES];
    enabled=NO; host.isSearching=YES; [CSGroupListAdapter settingsChanged]; RunFor(.02);
    [host viewWillAppear:NO];
    Check(!a.publishedEnabled && a.searching && [a.preferences.accountID isEqual:account],@"return applies latest account, settings and search state");
    enabled=YES;

    a=List(&host); [host viewWillDisappear:NO];
    CSGroupListAdapter *old=a; host.m_tableView=[UITableView new];
    [CSGroupListAdapter attachToController:host]; a=Adapter(host);
    Check(a!=old && a.presentationSuspended && !a.refreshCount,@"replacement table inherits hidden owner state");
    [host viewWillAppear:NO];
    Check(a.refreshCount==1 && !a.presentationSuspended,@"replacement table initializes once when owner returns");

    UITableView *chat=[UITableView new]; NSUInteger scopesBefore=scopes;
    [chat reloadData];
    Check(chat.reloads==1 && scopes==scopesBefore,@"unrelated chat table reload bypasses grouping scopes");
    fprintf(stdout,"Group lifecycle: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
    return failures ? 1 : 0;
} }
