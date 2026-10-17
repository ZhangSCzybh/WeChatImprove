// Host replay of real header publication / search-hook bodies, not an iOS render test.
#import <Foundation/Foundation.h>
#import "CSGroupAppearance.h"
#define CGRect NSRect
#define CGSize NSSize
#define CGRectMake NSMakeRect
#define CGRectGetHeight NSHeight
#define CGRectGetWidth NSWidth
#define CGRectEqualToRect NSEqualRects
static BOOL enabled=YES,appActive=YES;
static NSString *account=@"A";
static BOOL Option(NSString *key) { (void)key; return enabled; }
static BOOL CSGroupApplicationActive(void) { return appActive; }
static NSString *CSGroupCurrentAccountID(void) { return account; }
static void CSGroupWithDisplayIndices(id table,void (^body)(void)) { (void)table; body(); }
@interface UIView : NSObject
@property(nonatomic) CGRect frame,bounds;
@property(nonatomic) BOOL hidden,userInteractionEnabled;
@property(nonatomic,weak) UIView *superview;
@property(nonatomic,strong) NSMutableArray *children;
@property(nonatomic) NSUInteger removals;
- (void)removeFromSuperview;
- (void)addSubview:(UIView *)view;
- (BOOL)isDescendantOfView:(UIView *)view;
@end
@implementation UIView
- (void)removeFromSuperview { self.removals++; [self.superview.children removeObject:self]; self.superview=nil; }
- (void)addSubview:(UIView *)view {
    [view removeFromSuperview]; if (!self.children) self.children=[NSMutableArray array];
    [self.children addObject:view]; view.superview=self;
}
- (BOOL)isDescendantOfView:(UIView *)view { return self==view || [self.superview isDescendantOfView:view]; }
@end
@interface Chrome : UIView
@property(nonatomic) CGSize intrinsicContentSize;
- (void)applyAppearanceWithFontSize:(CGFloat)size showsSearchButton:(BOOL)visible;
@end
@implementation Chrome
- (void)applyAppearanceWithFontSize:(CGFloat)size showsSearchButton:(BOOL)visible { (void)size; (void)visible; }
@end
@interface Pan : NSObject
@property(nonatomic) BOOL enabled;
@end
@implementation Pan @end
@interface UITableView : UIView
@property(nonatomic,strong) UIView *tableHeaderView;
@property(nonatomic) double decelerationRate;
@end
@implementation UITableView @end
@interface Preferences : NSObject
@property(nonatomic,copy) NSString *accountID;
@end
@implementation Preferences @end
@interface CSGroupListAdapter : NSObject
@property(nonatomic,strong) UITableView *table;
@property(nonatomic,strong) Chrome *chrome;
@property(nonatomic,strong) UIView *nativeHeader,*headerContainer;
@property(nonatomic,strong) Pan *pan,*listPan;
@property(nonatomic,strong) Preferences *preferences;
@property(nonatomic) BOOL chromeVisible,searching,searchChromeVisible,pendingScrollToTop,presentationSuspended,updatingHeader;
@property(nonatomic) double baselineDeceleration;
@property(nonatomic) NSUInteger invalidations,anchors,titles,refreshes,requests;
- (void)layout;
- (void)publishHeader:(UIView *)header;
@end
@implementation CSGroupListAdapter
- (void)invalidateNativeSnapshot { self.invalidations++; }
- (void)saveAnchor { self.anchors++; }
- (void)refreshNavigationTitle { self.titles++; }
- (void)ensureChrome {}
- (void)updateGroupGestureAvailability { self.pan.enabled=self.listPan.enabled=!self.searching; }
- (void)applyPendingScrollToTop {}
- (void)refresh { self.refreshes++; }
- (void)requestRefresh { self.requests++; }
#include "SearchBodies.h"
@end
@interface Host : NSObject
@property(nonatomic,strong) CSGroupListAdapter *adapter;
@property(nonatomic) NSUInteger calls;
@property(nonatomic) BOOL sawNativeBeforePrepare;
- (void)originalSearchCall;
@end
static CSGroupListAdapter *Adapter(Host *host) { return host.adapter; }
static void Native(id owner,BOOL change,void (^body)(void)) { (void)owner; (void)change; body(); }
@implementation Host
- (void)originalSearchCall {
    self.calls++;
    if (self.adapter.table.tableHeaderView==self.adapter.nativeHeader) self.sawNativeBeforePrepare=YES;
}
#include "SearchHooks.h"
@end
static NSUInteger checks,failures;
static void Check(BOOL ok,NSString *message) { checks++; if (!ok) { failures++; fprintf(stderr,"FAIL: %s\n",message.UTF8String); } }
static CSGroupListAdapter *List(void) {
    CSGroupListAdapter *a=[CSGroupListAdapter new]; a.table=[UITableView new]; a.table.bounds=NSMakeRect(0,0,430,900);
    a.nativeHeader=[UIView new]; a.nativeHeader.frame=NSMakeRect(0,0,430,47);
    a.chrome=[Chrome new]; a.chrome.intrinsicContentSize=NSMakeSize(430,52);
    a.pan=[Pan new]; a.listPan=[Pan new]; a.preferences=[Preferences new]; a.preferences.accountID=account;
    a.chromeVisible=YES; a.baselineDeceleration=.99; [a layout]; return a;
}
int main(void) { @autoreleasepool {
    // Use a private defaults suite: never modify the developer's real settings.
    NSUserDefaults *defaults=NSUserDefaults.standardUserDefaults;
    [defaults setVolatileDomain:@{CSGroupSearchButtonVisibleKey:@YES} forName:NSArgumentDomain];
    CSGroupListAdapter *a=List(); UIView *wrapper=a.table.tableHeaderView;
    Check(wrapper==a.headerContainer && !a.nativeHeader.superview,@"shortcut hides the original search header");
    CGRect originalFrame=a.nativeHeader.frame;
    [a prepareForNativeSearch];
    Check(a.searching && a.searchChromeVisible && a.table.tableHeaderView==wrapper && !a.chrome.hidden,@"entry keeps the grouping header visible");
    Check(!a.pan.enabled && !a.listPan.enabled && !a.chrome.userInteractionEnabled,@"group swipes are disabled while searching");
    Check([a nativeTableHeaderView]==a.nativeHeader && NSEqualRects(originalFrame,a.nativeHeader.frame),@"native search retains original identity and geometry");
    [a prepareForNativeSearch];
    Check(a.anchors==1 && a.searchChromeVisible,@"nested onSearch and active callbacks preserve the transition");
    // Native search refresh disables projection/chrome ownership, while its
    // independent header presentation must remain stable throughout the pop.
    a.chromeVisible=NO;
    for (NSUInteger i=0;i<20;i++) { [a layout]; Check(a.table.tableHeaderView==wrapper && !a.chrome.hidden,@"search/interactive return frames never install the native header"); }
    UIView *searchPage=[UIView new]; [searchPage addSubview:a.nativeHeader];
    NSUInteger removals=a.nativeHeader.removals;
    [a layout];
    Check(a.nativeHeader.superview==searchPage && a.nativeHeader.removals==removals,@"search layout does not steal the host search view");
    UIView *newHeader=[UIView new]; newHeader.frame=NSMakeRect(0,0,430,60);
    [a setNativeTableHeaderView:newHeader];
    Check(a.nativeHeader==newHeader && a.table.tableHeaderView==wrapper,@"native header replacement remains invisible behind search");
    a.presentationSuspended=YES; [a layout];
    Check(a.table.tableHeaderView==wrapper,@"offscreen suspension preserves the transition backing header");
    a.presentationSuspended=NO; a.searching=NO; a.searchChromeVisible=NO; a.chromeVisible=YES; [a layout];
    Check(a.table.tableHeaderView==wrapper && a.pan.enabled && a.chrome.userInteractionEnabled,@"completed return restores group interaction without changing header identity");
    a=List(); [a prepareForNativeSearch]; account=@"B";
    Check(![a keepsGroupHeaderDuringSearch],@"retained chrome cannot cross accounts"); account=@"A";
    enabled=NO; [a layout];
    Check(a.table.tableHeaderView==a.nativeHeader && a.chrome.hidden,@"disabling grouping restores native header even during search"); enabled=YES;
    [defaults setVolatileDomain:@{CSGroupSearchButtonVisibleKey:@NO} forName:NSArgumentDomain];
    a=List(); Check(NSHeight(a.headerContainer.frame)==99 && a.nativeHeader.superview==a.headerContainer,@"shortcut disabled retains native search above groups");
    [a prepareForNativeSearch];
    Check(!a.searchChromeVisible && a.table.tableHeaderView==a.nativeHeader,@"ordinary native search retains its previous presentation");
    [defaults setVolatileDomain:@{CSGroupSearchButtonVisibleKey:@YES} forName:NSArgumentDomain];
    Host *host=[Host new]; host.adapter=List();
    [host onSearch]; [host setSearchBarActive:YES];
    Check(host.calls==2 && !host.sawNativeBeforePrepare && host.adapter.searchChromeVisible,@"real hooks prepare the stable header before invoking native search");
    NSUInteger refreshes=host.adapter.refreshes, requests=host.adapter.requests;
    [host cancelSearch]; [host onFTSSearchEnd]; [host setSearchBarActive:NO];
    Check(host.calls==5 && host.adapter.refreshes==refreshes+3 && host.adapter.requests==requests,@"search end hooks reconcile synchronously without the scheduled delay");
    appActive=NO; host.adapter.table.tableHeaderView=nil; [host.adapter layout];
    Check(!host.adapter.table.tableHeaderView,@"inactive application still blocks header publication");
    fprintf(stdout,"Group search: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
    return failures ? 1 : 0;
} }
