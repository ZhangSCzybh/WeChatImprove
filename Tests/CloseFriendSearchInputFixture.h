// Minimal native boundary doubles; the consumed helper/dispatch bodies are production code.
@interface UITextField : NSObject
@property(nonatomic,copy) NSString *text;
@property(nonatomic,strong) id markedTextRange;
@end
@implementation UITextField @end
@interface SearchTable : NSObject
@property(nonatomic,strong) id tableFooterView;
@end
@implementation SearchTable @end
@interface NativeSearchPresenter : NSObject
@property(nonatomic) BOOL searching;
@property(nonatomic) NSUInteger resets,cancels,delayedSearches;
@property(nonatomic,copy) NSString *latestCompeleteWebSearchQuery;
- (void)handleTextDidChange:(NSString *)query;
- (void)cancelFTSSearch;
- (void)resetDataSource;
- (void)delaySearchImp:(id)query;
@end
@implementation NativeSearchPresenter
- (void)handleTextDidChange:(NSString *)query {self.searching=query.length!=0;}
- (void)cancelFTSSearch {self.cancels++;self.searching=NO;}
- (void)resetDataSource {self.resets++;self.searching=YES;}
- (void)delaySearchImp:(id)query {(void)query;self.delayedSearches++;self.searching=YES;}
@end
@interface WCWebSearchBar : NSObject
@property(nonatomic,strong) UITextField *textView;
@property(nonatomic,copy) void (^didClear)(void);
@property(nonatomic) NSUInteger clears;
- (void)inputBoxClear;
@end
@implementation WCWebSearchBar
- (void)inputBoxClear {self.clears++;self.textView.text=@"";if(self.didClear)self.didClear();}
@end
@interface FTSHomeViewController : NSObject
@property(nonatomic,strong) UITextField *searchTextField;
@property(nonatomic,strong) WCWebSearchBar *searchBar;
@property(nonatomic,strong) SearchTable *tableView;
@property(nonatomic,strong) id presenter;
@property(nonatomic) NSUInteger reloads, resigns;
- (NSString *)searchBarText;
- (void)reloadList;
- (void)resignSearchFirstResponder;
@end
@implementation FTSHomeViewController
- (NSString *)searchBarText {return self.searchBar ? self.searchBar.textView.text : self.searchTextField.text;}
- (void)reloadList {self.reloads++;}
- (void)resignSearchFirstResponder {self.resigns++;}
@end
@interface CSCloseFriendManager : NSObject
@property(nonatomic) NSUInteger probes;
+ (instancetype)sharedManager;
- (BOOL)consumeHomepageSearchPassword:(NSString *)query;
@end
@implementation CSCloseFriendManager
+ (instancetype)sharedManager {static id manager; if(!manager)manager=[self new];return manager;}
- (BOOL)consumeHomepageSearchPassword:(NSString *)query {self.probes++; return [query isEqual:@"654321"];}
@end
static BOOL CSCFCallVoid(id object,NSString *name) {
    SEL selector=NSSelectorFromString(name); if(![object respondsToSelector:selector]) return NO;
    ((void(*)(id,SEL))[object methodForSelector:selector])(object,selector); return YES;
}
static BOOL CSCFSetObject(id object,NSString *name,id value) {
    SEL selector=NSSelectorFromString(name); if(![object respondsToSelector:selector]) return NO;
    ((void(*)(id,SEL,id))[object methodForSelector:selector])(object,selector,value); return YES;
}
static __thread NSUInteger PasswordDispatchDepth;
#include "SearchInputBodies.h"
static void SearchInputChecks(void) {
    FTSHomeViewController *page=[FTSHomeViewController new];page.searchTextField=[UITextField new];
    __block NSUInteger nativeCalls=0;page.searchTextField.text=@"654321";
    DispatchSearchInput(page,page.searchTextField,NO,^{nativeCalls++;});
    Check(!nativeCalls && !page.searchTextField.text.length && page.reloads==1 && page.resigns==1,@"full homepage password is consumed and cleared before native search/history");
    page.searchTextField.text=@"ordinary";
    NSUInteger probes=CSCloseFriendManager.sharedManager.probes;
    DispatchSearchInput(page,page.searchTextField,NO,^{DispatchSearchInput(page,@"ordinary",NO,^{nativeCalls++;});});
    Check(nativeCalls==1 && CSCloseFriendManager.sharedManager.probes==probes+1,@"ordinary search flows through once without repeated verifier work in nested callbacks");
    page.searchTextField.text=@"654321";page.searchTextField.markedTextRange=[NSObject new];
    DispatchSearchInput(page,page.searchTextField,NO,^{nativeCalls++;});
    Check(nativeCalls==2 && page.searchTextField.text.length==6,@"uncommitted IME composition is not consumed");
    page.searchTextField.markedTextRange=nil;
    DispatchSearchInput([NSObject new],@"654321",NO,^{nativeCalls++;});
    Check(nativeCalls==3,@"non-homepage search remains untouched");
    @try {DispatchSearchInput(page,@"ordinary",NO,^{@throw [NSException exceptionWithName:@"Native" reason:nil userInfo:nil];});} @catch(__unused NSException *e) {}
    Check(PasswordDispatchDepth==0,@"native exception cannot leave password dispatch bypassed");
    // Reproduce the actual 8.0.78 boundary: the visible large editor differs from
    // searchTextField, and resetting data after cancel creates a new loading task.
    FTSHomeViewController *modern=[FTSHomeViewController new];modern.searchTextField=[UITextField new];modern.searchTextField.text=@"unused";
    modern.searchBar=[WCWebSearchBar new];modern.searchBar.textView=[UITextField new];modern.searchBar.textView.text=@"654321";
    modern.tableView=[SearchTable new];modern.tableView.tableFooterView=@"loading";
    NativeSearchPresenter *presenter=[NativeSearchPresenter new];presenter.searching=YES;modern.presenter=presenter;
    __weak FTSHomeViewController *weakPage=modern;
    modern.searchBar.didClear=^{DispatchSearchInput(weakPage,@"",NO,^{[presenter handleTextDidChange:@""];});};
    [presenter performSelector:@selector(delaySearchImp:) withObject:@"old-query" afterDelay:0.01];
    probes=CSCloseFriendManager.sharedManager.probes;
    DispatchSearchInput(modern,@"654321",NO,^{nativeCalls++;});
    Check(!modern.searchBar.textView.text.length && modern.searchBar.clears==1 && [modern.searchTextField.text isEqual:@"unused"],@"native clear targets actual large editor, independent of legacy field");
    Check(!presenter.searching && presenter.cancels==1 && presenter.resets==0 && !modern.tableView.tableFooterView && CSCFSearchSuppressLoading(modern),@"consume cancels native task and footer without creating a fresh unfinished search");
    Check(CSCloseFriendManager.sharedManager.probes==probes+1,@"native clear callback is not recursively password-verified");
    [NSRunLoop.currentRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.02]];
    Check(!presenter.delayedSearches && !presenter.searching,@"pending delayed searches cannot revive loading after consumption");
    modern.searchBar.textView.text=@"ordinary";
    DispatchSearchInput(modern,@"ordinary",NO,^{[presenter handleTextDidChange:@"ordinary"];});
    Check(presenter.searching && !CSCFSearchSuppressLoading(modern),@"next ordinary search immediately restores native loading behavior");
    modern.searchBar.textView.text=@"654321";modern.searchBar.textView.markedTextRange=[NSObject new];
    DispatchSearchInput(modern,@"654321",NO,^{nativeCalls++;});
    Check(modern.searchBar.clears==1 && modern.searchBar.textView.text.length==6,@"large editor IME composition remains native");
}
