#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import "CSCloseFriendSignatures.h"

static NSUInteger Assertions;
#define CHECK(...) do { Assertions++; if (!(__VA_ARGS__)) { \
    fprintf(stderr, "Moments runtime FAIL %d: %s\n", __LINE__, #__VA_ARGS__); exit(1); \
} } while (0)

@class CSMomentsLayoutAdapter;
@interface CSMomentsRefreshDouble : NSObject
@property(nonatomic) NSUInteger ends;
- (void)endRefreshing;
@end
@implementation CSMomentsRefreshDouble
- (void)endRefreshing { self.ends++; }
@end
#define UIRefreshControl CSMomentsRefreshDouble

enum { UIControlStateNormal=0 };
@interface MomentsFooterButtonDouble : NSObject
@property(nonatomic) BOOL hidden, enabled;
@property(nonatomic, copy) NSString *title;
- (void)setTitle:(NSString *)title forState:(NSUInteger)state;
@end
@implementation MomentsFooterButtonDouble
- (void)setTitle:(NSString *)title forState:(NSUInteger)state {
    CHECK(state==UIControlStateNormal); self.title=title;
}
@end
@interface CSMomentsSupplement : NSObject
@property(nonatomic, strong) MomentsFooterButtonDouble *button;
@end
@implementation CSMomentsSupplement @end

@interface CSMomentsOwnerDouble : NSObject
@property(nonatomic, weak) CSMomentsLayoutAdapter *adapter;
@property(nonatomic) BOOL allowsCalls,controllerBusy;
@property(nonatomic,strong) id headRefreshView,footerView;
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(id)header;
@property(nonatomic) NSUInteger loads, refreshes, changes;
@property(nonatomic) NSUInteger completions;
@property(nonatomic, copy) void (^duringCall)(void);
@property(nonatomic, copy) void (^duringCompletion)(void);
@end
@implementation CSMomentsOwnerDouble
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(id)header { (void)header; return self.controllerBusy; }
@end

// These are boundary doubles only. The paging state transitions and callback
// wrapper below are extracted from production source by the verification script.
@interface CSMomentsLayoutAdapter : NSObject
@property(nonatomic, strong) CSMomentsOwnerDouble *owner;
@property(nonatomic, strong) CSMomentsRefreshDouble *refreshControl;
@property(nonatomic, copy) NSArray *cards;
@property(nonatomic) BOOL attached, current, nativeBusy, refreshing, loadingMore, noMore, error;
@property(nonatomic) BOOL acceptEmptySource,retryRefresh;
@property(nonatomic,strong) id table;
@property(atomic) NSUInteger requestSerial;
@property(nonatomic) NSUInteger sourceCount, lastAutomaticCount;
@property(nonatomic) NSUInteger updates, footerUpdates;
- (BOOL)isCurrent;
- (BOOL)nativeLoading;
- (BOOL)nativeLoadingProduction;
- (void)updateFooter;
- (void)configureFooter:(CSMomentsSupplement *)footer;
- (void)scheduleUpdate;
- (void)armTimeout;
- (void)refresh:(UIRefreshControl *)sender;
- (void)loadMore:(id)sender;
- (void)requestFinished:(BOOL)noMore error:(BOOL)error;
@end

static NSMutableArray *Timeouts, *Pending;
static NSHashTable *Adapters;
static IMP FooterHook;
static NSUInteger FooterOriginalCalls;
static void CaptureTimeout(dispatch_time_t when, dispatch_queue_t queue, dispatch_block_t block) {
    (void)when; (void)queue;
    [Timeouts addObject:[block copy]];
}
static void CaptureAsync(dispatch_queue_t queue, dispatch_block_t block) {
    (void)queue;
    [Pending addObject:[block copy]];
}
static void Drain(void) {
    while (Pending.count) {
        dispatch_block_t block = Pending.firstObject;
        [Pending removeObjectAtIndex:0];
        block();
    }
}
static void RunBackground(dispatch_block_t block) {
    dispatch_semaphore_t finished = dispatch_semaphore_create(0);
    NSThread *thread = [[NSThread alloc] initWithBlock:^{ @autoreleasepool {
        block();
        dispatch_semaphore_signal(finished);
    } }];
    [thread start];
    CHECK(dispatch_semaphore_wait(finished, dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC)) == 0);
}
static id Read(id owner, NSString *name) {
    @try { return [owner valueForKey:name]; } @catch(__unused NSException *exception) { return nil; }
}
static BOOL Matches(id object,NSString *name,const char *types) {
    return CSCloseFriendMethodMatches(class_getInstanceMethod([object class],NSSelectorFromString(name)),types);
}
@interface MomentsProviderDouble : NSObject
@property(nonatomic) BOOL isUpdating;
@end
@implementation MomentsProviderDouble @end
@interface MomentsManagerDouble : NSObject
@property(nonatomic,strong) id dataProvider;
@end
@implementation MomentsManagerDouble @end
@interface MomentsFacadeDouble : NSObject
@property(nonatomic,strong) id timelineMgr;
@end
@implementation MomentsFacadeDouble @end
static id NativeFacade;
static id CurrentFacade(void) { return NativeFacade; }
static BOOL Call0(CSMomentsOwnerDouble *owner, NSString *name) {
    CHECK([name isEqual:@"onLoadMore"]);
    if (!owner.allowsCalls) return NO;
    owner.loads++;
    if (owner.duringCall) owner.duringCall();
    return YES;
}
static BOOL Call1(CSMomentsOwnerDouble *owner, NSString *name, id value) {
    (void)value;
    CHECK([name isEqual:@"egoRefreshTableHeaderDidTriggerRefresh:"]);
    if (!owner.allowsCalls) return NO;
    owner.refreshes++;
    if (owner.duringCall) owner.duringCall();
    return YES;
}
static CSMomentsLayoutAdapter *Adapter(CSMomentsOwnerDouble *owner, BOOL create) {
    (void)create;
    return owner.adapter;
}
static void NativeChanged(CSMomentsOwnerDouble *owner, SEL selector, id added, id changed, id deleted) {
    (void)selector; (void)added; (void)changed; (void)deleted;
    owner.changes++;
}
static NSMutableDictionary<NSString *, NSValue *> *CompletionIMPs;
static BOOL LayoutEnabled, OriginalAllowsFlutter;
static NSUInteger OriginalDetailCalls;
static Class DetailRouterClass;
static id LastDetailRouter;
static IMP DetailRouteIMP;
@interface MomentsDetailRouterDouble : NSObject
+ (BOOL)isFlutterDetailEnabled;
@end
@implementation MomentsDetailRouterDouble
+ (BOOL)isFlutterDetailEnabled { return YES; }
@end
@interface MomentsIncompatibleRouterDouble : NSObject
+ (NSInteger)isFlutterDetailEnabled;
@end
@implementation MomentsIncompatibleRouterDouble
+ (NSInteger)isFlutterDetailEnabled { return 1; }
@end
static BOOL CSMomentsLayoutEnabled(void) { return LayoutEnabled; }
static Class DetailClassLookup(NSString *name) {
    CHECK([name isEqual:@"WCTimelineRouterHelper"]); return DetailRouterClass;
}
static BOOL NativeDetailDecision(id router, SEL selector) {
    CHECK(selector==NSSelectorFromString(@"isFlutterDetailEnabled"));
    OriginalDetailCalls++; LastDetailRouter=router; return OriginalAllowsFlutter;
}
static void NativeCompletion(CSMomentsOwnerDouble *owner, SEL selector) {
    (void)selector;
    owner.completions++;
    if (owner.duringCompletion) owner.duringCompletion();
}
static void NativeFooterCompletion(id footer,SEL selector,id scrollView) {
    (void)footer; (void)selector; (void)scrollView; FooterOriginalCalls++;
}
static BOOL Install(NSString *className, NSString *name, const char *types, IMP replacement, IMP *original, BOOL classMethod) {
    if([className isEqual:@"WCTimeLineFooterView"]) {
        CHECK([name isEqual:@"refreshScrollViewDataSourceDidFinishedLoading:"] && strcmp(types,"v@:@")==0 && !classMethod);
        *original=(IMP)NativeFooterCompletion; FooterHook=replacement; return YES;
    }
    if([className isEqual:@"WCTimelineRouterHelper"]) {
        CHECK([name isEqual:@"isFlutterDetailEnabled"] && strcmp(types,"B@:")==0 && classMethod);
        *original=(IMP)NativeDetailDecision; DetailRouteIMP=replacement; return YES;
    }
    (void)className; (void)types; (void)classMethod;
    *original = (IMP)NativeCompletion;
    CompletionIMPs[name] = [NSValue valueWithPointer:replacement];
    return YES;
}

#define dispatch_after CaptureTimeout
#define dispatch_async CaptureAsync
@implementation CSMomentsLayoutAdapter
- (BOOL)isCurrent { return self.current; }
- (BOOL)nativeLoading { return self.nativeBusy; }
- (void)updateFooter { self.footerUpdates++; }
- (void)scheduleUpdate { self.updates++; }
#include "MomentsPagingBodies.h"
#include "MomentsNativeLoadingBody.h"
@end

static IMP ChangedIMP;
static void InstallChangedCallback(void) {
    SEL changed = NSSelectorFromString(@"onDataChangedWithAdded:andChanged:andDeleted:");
    __block IMP previousChanged = (IMP)NativeChanged;
#include "MomentsChangedBody.h"
    ChangedIMP = changedIMP;
}
#include "MomentsCompletionBody.h"
#define NSClassFromString DetailClassLookup
#include "MomentsDetailRouteBodies.h"
#undef NSClassFromString
#undef dispatch_after
#undef dispatch_async

static CSMomentsLayoutAdapter *Page(void) {
    [Timeouts removeAllObjects];
    [Pending removeAllObjects];
    CSMomentsLayoutAdapter *page = [CSMomentsLayoutAdapter new];
    page.owner = [CSMomentsOwnerDouble new];
    page.owner.adapter = page;
    page.owner.allowsCalls = YES;
    page.owner.footerView=[NSObject new]; page.table=[NSObject new];
    [Adapters addObject:page];
    page.refreshControl = [CSMomentsRefreshDouble new];
    page.attached = page.current = YES;
    page.sourceCount = 12;
    page.lastAutomaticCount = NSNotFound;
    return page;
}
static void EmitChanged(CSMomentsLayoutAdapter *page, NSArray *added, NSArray *changedItems, NSArray *deleted) {
    ((void (*)(id, SEL, id, id, id))ChangedIMP)(page.owner,
        NSSelectorFromString(@"onDataChangedWithAdded:andChanged:andDeleted:"), added, changedItems, deleted);
}
static void EmitCompletion(CSMomentsLayoutAdapter *page, NSString *name) {
    IMP implementation = CompletionIMPs[name].pointerValue;
    ((void (*)(id, SEL))implementation)(page.owner, NSSelectorFromString(name));
}
static void TestLoadGuards(void) {
    CSMomentsLayoutAdapter *page = Page();
    [page loadMore:nil];
    CHECK(page.loadingMore && page.owner.loads == 1 && Timeouts.count == 1);
    [page loadMore:nil]; [page loadMore:@YES];
    CHECK(page.owner.loads == 1);
    [page refresh:page.refreshControl];
    CHECK(!page.refreshing && page.owner.refreshes == 0);
    [page requestFinished:NO error:NO];
    [page loadMore:nil];
    CHECK(page.owner.loads == 1);
    page.sourceCount = 24;
    [page loadMore:nil];
    CHECK(page.loadingMore && page.owner.loads == 2);
    [page requestFinished:YES error:NO];
    [page loadMore:@YES];
    CHECK(page.owner.loads == 2 && page.noMore);
    page.nativeBusy = YES;
    [page refresh:page.refreshControl];
    CHECK(page.owner.refreshes == 0);
    page.nativeBusy = NO;
    [page refresh:page.refreshControl];
    CHECK(page.refreshing && !page.noMore && !page.error && page.owner.refreshes == 1);
    [page requestFinished:NO error:YES];
    [page loadMore:nil];
    CHECK(page.owner.loads == 2);
    [page loadMore:@YES];
    CHECK(page.owner.loads == 2 && page.owner.refreshes == 2 && page.refreshing && !page.error);
}
static void TestTimeoutsAndFailure(void) {
    CSMomentsLayoutAdapter *page = Page();
    [page loadMore:@YES];
    dispatch_block_t oldTimeout = Timeouts.firstObject;
    [page requestFinished:NO error:NO];
    [page loadMore:@YES];
    NSUInteger serial = page.requestSerial;
    oldTimeout();
    CHECK(page.loadingMore && !page.error && page.requestSerial == serial);
    dispatch_block_t currentTimeout = Timeouts.lastObject;
    currentTimeout();
    CHECK(!page.loadingMore && page.error);
    page.owner.allowsCalls = NO;
    [page loadMore:@YES];
    CHECK(!page.loadingMore && page.error);
    page.owner.allowsCalls = YES;
    page.owner.footerView=[NSObject new]; page.table=[NSObject new];
    [Adapters addObject:page];
    page.current = NO;
    NSUInteger calls = page.owner.loads;
    [page loadMore:@YES]; [page refresh:page.refreshControl];
    CHECK(page.owner.loads == calls && !page.refreshing);
    page.attached = NO;
    serial = page.requestSerial;
    [page requestFinished:YES error:NO];
    CHECK(page.requestSerial == serial);
}
static void TestSynchronousCompletion(void) {
    CSMomentsLayoutAdapter *page = Page();
    __weak CSMomentsLayoutAdapter *weakPage = page;
    page.owner.duringCall = ^{ [weakPage requestFinished:YES error:NO]; };
    [page loadMore:@YES];
    CHECK(page.noMore && !page.loadingMore && !page.error);
    dispatch_block_t timeout = Timeouts.lastObject;
    timeout();
    CHECK(page.noMore && !page.error);
}
static void TestUnrelatedChangesDuringPaging(void) {
    CSMomentsLayoutAdapter *page = Page();
    [page loadMore:@YES];
    NSUInteger serial = page.requestSerial;
    EmitChanged(page, @[], @[@"updated-like-count"], @[]);
    Drain();
    CHECK(page.owner.changes == 1);
    CHECK(page.loadingMore && page.requestSerial == serial);
    [page loadMore:@YES];
    CHECK(page.owner.loads == 1);
}
static void TestUnownedNativeCompletionsStayQuiet(void) {
    for(NSString *name in @[@"onTimelineServerError",@"onNoMoreTimelineData",@"onNormalTimelineData"]) {
        CSMomentsLayoutAdapter *page=Page();
        NSUInteger serial=page.requestSerial;
        EmitCompletion(page,name);
        CHECK(page.owner.completions==1 && page.updates==1);
        CHECK(!page.error && !page.noMore && !page.refreshing && !page.loadingMore && page.requestSerial==serial);
        CHECK(page.acceptEmptySource==![name isEqual:@"onTimelineServerError"]);
        CHECK(page.refreshControl.ends==0 && page.footerUpdates==0);
    }
    // A callback already queued by native startup cannot fail a request that
    // this adapter starts later, while the callback is waiting on the main queue.
    CSMomentsLayoutAdapter *page=Page();
    RunBackground(^{ EmitCompletion(page,@"onTimelineServerError"); });
    CHECK(Pending.count==1);
    [page loadMore:@YES];
    NSUInteger serial=page.requestSerial;
    Drain();
    CHECK(page.loadingMore && !page.error && page.requestSerial==serial);
    EmitCompletion(page,@"onTimelineServerError");
    CHECK(!page.loadingMore && page.error && page.refreshControl.ends==1);
}
static void TestDeleteConfirmsEmptySource(void) {
    CSMomentsLayoutAdapter *page=Page();
    EmitChanged(page,@[],@[@"updated-like"],@[]); Drain();
    CHECK(!page.acceptEmptySource);
    EmitChanged(page,@[],@[],@[@"deleted-last-item"]);
    CHECK(!page.acceptEmptySource); Drain();
    CHECK(page.acceptEmptySource && !page.refreshing && !page.loadingMore);
    page=Page();
    NSMutableArray *deleted=[NSMutableArray arrayWithObject:@"native-mutable-delete-payload"];
    EmitChanged(page,@[],@[],deleted); [deleted removeAllObjects]; Drain();
    CHECK(page.acceptEmptySource);
}
static void TestOldCallbackCannotFinishNewRequest(void) {
    CSMomentsLayoutAdapter *page = Page();
    [page loadMore:@YES];
    EmitChanged(page, @[@"page-one"], @[], @[]);
    [page requestFinished:NO error:NO];
    [page loadMore:@YES];
    NSUInteger serial = page.requestSerial;
    Drain();
    CHECK(page.loadingMore && page.requestSerial == serial && page.owner.loads == 2);
    EmitChanged(page, @[@"page-two"], @[], @[]);
    [page requestFinished:YES error:NO];
    Drain();
    CHECK(page.noMore && !page.loadingMore);
}
static void TestNativeCompletionWrapper(void) {
    CSMomentsLayoutAdapter *page = Page();
    [page loadMore:@YES];
    EmitCompletion(page, @"onNormalTimelineData");
    CHECK(!page.loadingMore && !page.noMore && !page.error);
    [page loadMore:@YES];
    EmitCompletion(page, @"onNoMoreTimelineData");
    CHECK(!page.loadingMore && page.noMore && !page.error);
    [page refresh:page.refreshControl];
    EmitCompletion(page, @"onTimelineServerError");
    CHECK(!page.refreshing && !page.noMore && page.error);

    page = Page();
    [page loadMore:@YES];
    NSUInteger serial = page.requestSerial;
    EmitCompletion(page, @"stopRefreshHeaderView");
    CHECK(page.loadingMore && page.requestSerial == serial);

    page = Page();
    [page loadMore:@YES];
    __weak CSMomentsLayoutAdapter *weakPage = page;
    page.owner.duringCompletion = ^{
        [weakPage requestFinished:NO error:NO];
        [weakPage loadMore:@YES];
    };
    EmitCompletion(page, @"onNoMoreTimelineData");
    CHECK(page.loadingMore && !page.noMore && page.owner.loads == 2);
    page.owner.duringCompletion = nil;
    EmitCompletion(page, @"onNormalTimelineData");
    CHECK(!page.loadingMore && !page.noMore && !page.error);
    CHECK(page.owner.completions == 2);

    page = Page();
    [page loadMore:@YES];
    RunBackground(^{
        EmitCompletion(page, @"onNoMoreTimelineData");
    });
    CHECK(Pending.count == 1);
    [page requestFinished:NO error:NO];
    [page loadMore:@YES];
    serial = page.requestSerial;
    Drain();
    CHECK(page.loadingMore && !page.noMore && page.requestSerial == serial);
    EmitCompletion(page, @"onNormalTimelineData");
    CHECK(!page.loadingMore && !page.noMore && !page.error);

    page = Page();
    [page refresh:page.refreshControl];
    EmitCompletion(page, @"stopRefreshHeaderView");
    CHECK(page.refreshing); Drain();
    CHECK(!page.refreshing && !page.error);
}

static void EmitFooter(CSMomentsLayoutAdapter *page,id footer,id table) {
    (void)page;
    ((void(*)(id,SEL,id))FooterHook)(footer,NSSelectorFromString(@"refreshScrollViewDataSourceDidFinishedLoading:"),table);
}
static void TestProviderBusyAdmission(void) {
    CSMomentsLayoutAdapter *page=Page();
    MomentsFacadeDouble *facade=[MomentsFacadeDouble new];
    MomentsManagerDouble *manager=[MomentsManagerDouble new];
    MomentsProviderDouble *provider=[MomentsProviderDouble new];
    facade.timelineMgr=manager; manager.dataProvider=provider; NativeFacade=facade;
    CHECK(![page nativeLoadingProduction]);
    provider.isUpdating=YES;
    CHECK([page nativeLoadingProduction]);
    provider.isUpdating=NO; page.owner.controllerBusy=YES;
    CHECK([page nativeLoadingProduction]);
    page.owner.controllerBusy=NO;
    CHECK(![page nativeLoadingProduction]);
    manager.dataProvider=[NSObject new];
    CHECK(![page nativeLoadingProduction]);
    NativeFacade=nil;
    CHECK(![page nativeLoadingProduction]);
    page.nativeBusy=YES;
    [page loadMore:nil]; [page refresh:page.refreshControl];
    CHECK(!page.loadingMore && !page.refreshing && page.lastAutomaticCount==NSNotFound);
    CHECK(Timeouts.count==0 && page.owner.loads==0 && page.owner.refreshes==0);
}
static void TestNativeFooterAndNestedResultOwnership(void) {
    CSMomentsLayoutAdapter *page=Page();
    __weak CSMomentsLayoutAdapter *weakPage=page;
    page.owner.duringCall=^{
        CSMomentsLayoutAdapter *current=weakPage;
        EmitFooter(current,current.owner.footerView,current.table);
    };
    [page loadMore:@YES];
    CHECK(page.loadingMore && Pending.count==1);
    dispatch_block_t timeout=Timeouts.lastObject;
    Drain();
    CHECK(!page.loadingMore && !page.error);
    timeout();
    CHECK(!page.error); // Native synchronous completion must invalidate the watchdog.

    page=Page(); [page loadMore:@YES];
    EmitFooter(page,[NSObject new],page.table);
    EmitFooter(page,page.owner.footerView,[NSObject new]); Drain();
    CHECK(page.loadingMore);
    EmitFooter(page,page.owner.footerView,page.table);
    [page requestFinished:NO error:NO]; [page loadMore:@YES];
    NSUInteger serial=page.requestSerial; Drain();
    CHECK(page.loadingMore && page.requestSerial==serial);

    for(NSString *result in @[@"onTimelineServerError",@"onNoMoreTimelineData"]) {
        page=Page(); [page loadMore:@YES]; weakPage=page;
        page.owner.duringCompletion=^{
            CSMomentsLayoutAdapter *current=weakPage;
            EmitFooter(current,current.owner.footerView,current.table);
        };
        EmitCompletion(page,result); Drain();
        CHECK(!page.loadingMore && page.error==[result isEqual:@"onTimelineServerError"]);
        CHECK(page.noMore==[result isEqual:@"onNoMoreTimelineData"]);
    }
    page=Page(); [page refresh:page.refreshControl]; weakPage=page;
    __block BOOL nested=NO;
    page.owner.duringCompletion=^{
        if(nested)return;
        nested=YES;
        EmitCompletion(weakPage,@"stopRefreshHeaderView");
    };
    EmitCompletion(page,@"onTimelineServerError"); Drain();
    CHECK(page.error && page.retryRefresh && !page.refreshing);
    CHECK(page.refreshControl.ends==1);
    NSUInteger loads=page.owner.loads,refreshes=page.owner.refreshes;
    [page loadMore:@YES];
    CHECK(page.refreshing && page.owner.refreshes==refreshes+1 && page.owner.loads==loads);
    CHECK(!page.error && !page.retryRefresh);
    CHECK(FooterOriginalCalls>=6);
    // The same native nesting must preserve failure when delivered off main.
    page=Page(); [page refresh:page.refreshControl]; weakPage=page; nested=NO;
    page.owner.duringCompletion=^{
        if(nested)return;
        nested=YES;
        EmitCompletion(weakPage,@"stopRefreshHeaderView");
    };
    RunBackground(^{ EmitCompletion(weakPage,@"onTimelineServerError"); });
    CHECK(page.refreshing && Pending.count==1);
    Drain();
    CHECK(page.error && page.retryRefresh && !page.refreshing && page.refreshControl.ends==1);
}

static void TestSilentEmptyFooterAndRetry(void) {
    CSMomentsLayoutAdapter *page=Page();
    CSMomentsSupplement *footer=[CSMomentsSupplement new];
    footer.button=[MomentsFooterButtonDouble new];
    // All empty states stay quiet: first frame, a native empty response, a
    // filtered projection, refresh and an empty successful final page.
    for(NSUInteger state=0;state<4;state++) {
        page.cards=@[]; page.noMore=state==1; page.refreshing=state==2; page.loadingMore=state==3;
        [page configureFooter:footer];
        CHECK(footer.button.hidden && !footer.button.enabled && [footer.button.title isEqual:@""]);
    }
    page.noMore=NO; page.refreshing=NO; page.loadingMore=NO; page.error=YES;
    [page configureFooter:footer];
    CHECK(!footer.button.hidden && footer.button.enabled && [footer.button.title isEqual:@"加载失败，轻点重试"]);
    page.error=NO; page.cards=@[@"loaded-card"];
    [page configureFooter:footer];
    CHECK(!footer.button.hidden && footer.button.enabled && [footer.button.title isEqual:@"加载更多"]);
    page.loadingMore=YES;
    [page configureFooter:footer];
    CHECK(!footer.button.hidden && !footer.button.enabled && [footer.button.title isEqual:@"正在加载…"]);
    page.loadingMore=NO; page.noMore=YES;
    [page configureFooter:footer];
    CHECK(!footer.button.hidden && !footer.button.enabled && [footer.button.title isEqual:@"没有更多动态"]);
    page.noMore=NO; page.current=NO;
    [page configureFooter:footer];
    CHECK(!footer.button.enabled);
    // A footer reused after returning from detail or after a privacy clear
    // must not retain the previous title or an accessible invisible action.
    page.current=YES; page.cards=@[];
    [page configureFooter:footer];
    CHECK(footer.button.hidden && !footer.button.enabled && [footer.button.title isEqual:@""]);
}

static void TestNativeDetailRouteAndExistingHookChain(void) {
    DetailRouterClass=Nil;
    CHECK(!NativeDetailRouteAvailable());
    DetailRouterClass=NSObject.class;
    CHECK(!NativeDetailRouteAvailable());
    DetailRouterClass=MomentsIncompatibleRouterDouble.class;
    CHECK(!NativeDetailRouteAvailable());
    DetailRouterClass=MomentsDetailRouterDouble.class;
    CHECK(NativeDetailRouteAvailable());
    CHECK(HookNativeDetailRoute() && DetailRouteIMP!=NULL);
    BOOL (*route)(id,SEL)=(BOOL(*)(id,SEL))DetailRouteIMP;
    SEL selector=NSSelectorFromString(@"isFlutterDetailEnabled");
    OriginalDetailCalls=0; OriginalAllowsFlutter=YES; LayoutEnabled=NO;
    CHECK(route(DetailRouterClass,selector) && OriginalDetailCalls==1 && LastDetailRouter==DetailRouterClass);
    LayoutEnabled=YES;
    CHECK(!route(DetailRouterClass,selector) && OriginalDetailCalls==1);
    // Turning layout off restores the preexisting hook's decision, including
    // its false result (such as a privacy hook requiring a native detail).
    LayoutEnabled=NO; OriginalAllowsFlutter=NO;
    CHECK(!route(DetailRouterClass,selector) && OriginalDetailCalls==2);
    LayoutEnabled=YES;
    CHECK(!route(DetailRouterClass,selector) && OriginalDetailCalls==2);
    LayoutEnabled=NO; OriginalAllowsFlutter=YES;
    CHECK(route(DetailRouterClass,selector) && OriginalDetailCalls==3);
    imp_removeBlock(DetailRouteIMP); DetailRouteIMP=NULL;
}

int main(void) { @autoreleasepool {
    Adapters=[NSHashTable weakObjectsHashTable];
    Timeouts = [NSMutableArray array];
    Pending = [NSMutableArray array];
    CompletionIMPs = [NSMutableDictionary dictionary];
    InstallChangedCallback();
    HookNativeFooterCompletion();
    HookCompletion(@"onNormalTimelineData", NO, NO, NO);
    HookCompletion(@"onNoMoreTimelineData", YES, NO, NO);
    HookCompletion(@"onTimelineServerError", NO, YES, NO);
    HookCompletion(@"stopRefreshHeaderView", NO, NO, YES);
    TestProviderBusyAdmission();
    TestNativeFooterAndNestedResultOwnership();
    TestLoadGuards();
    TestTimeoutsAndFailure();
    TestSynchronousCompletion();
    TestUnrelatedChangesDuringPaging();
    TestUnownedNativeCompletionsStayQuiet();
    TestDeleteConfirmsEmptySource();
    TestOldCallbackCannotFinishNewRequest();
    TestNativeCompletionWrapper();
    TestSilentEmptyFooterAndRetry();
    TestNativeDetailRouteAndExistingHookChain();
    imp_removeBlock(FooterHook);
    imp_removeBlock(ChangedIMP);
    for (NSValue *value in CompletionIMPs.allValues) imp_removeBlock(value.pointerValue);
    printf("Moments runtime: %lu checks passed (production footer/paging/route bodies, silent first frame, retry, native detail ABI and hook chain, duplicate guards, stale timeouts, callback ordering).\n", (unsigned long)Assertions);
    return 0;
} }
