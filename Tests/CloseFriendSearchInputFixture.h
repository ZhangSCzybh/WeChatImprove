// Native boundary doubles; both the adapter and the installed hooks are production code.
#import "CSCloseFriendSignatures.h"
@interface UITextField : NSObject
@property(nonatomic,copy) NSString *text;
@property(nonatomic,strong) id markedTextRange;
@end
@implementation UITextField @end
@interface SearchTextWrapper : UITextField
@property(nonatomic,strong) UITextField *textView;
@end
@implementation SearchTextWrapper
- (NSString *)text {return self.textView.text;}
- (void)setText:(NSString *)text {self.textView.text=text;}
@end
@interface SearchTable : NSObject
@property(nonatomic,strong) id tableFooterView;
@end
@implementation SearchTable @end
@interface WCWebSearchBar : NSObject
@property(nonatomic,strong) SearchTextWrapper *textView;
@property(nonatomic,copy) void (^didClear)(void);
@property(nonatomic) NSUInteger clears,textOnlyWrites;
- (void)inputBoxClear;
- (void)inputBoxSetTextOnly:(NSString *)text;
@end
@implementation WCWebSearchBar
- (void)inputBoxClear {self.clears++;self.textView.text=@"";if(self.didClear)self.didClear();}
- (void)inputBoxSetTextOnly:(NSString *)text {self.textOnlyWrites++;self.textView.textView.markedTextRange=nil;self.textView.text=text;}
@end
@class FTSVoiceSearchBarController;
@interface FTSHomeViewController : NSObject
@property(nonatomic,strong) UITextField *searchTextField;
@property(nonatomic,strong) WCWebSearchBar *searchBar;
@property(nonatomic,strong) SearchTable *tableView;
@property(nonatomic,strong) FTSVoiceSearchBarController *presenter;
@property(nonatomic,copy) NSArray *sectionData;
@property(nonatomic) NSUInteger reloads,resigns,submits,inputCallbacks,footerReads,loadingStarts;
@property(nonatomic) BOOL emptyPresentation;
- (NSString *)searchBarText;
- (void)reloadList;
- (void)resignSearchFirstResponder;
- (void)updateViewHideStates:(BOOL)empty;
- (void)setLoadingStatus;
- (void)updateFooterView;
- (NSArray *)objectsForListAdapter:(id)adapter;
- (void)shouldReturnStartSearch;
- (void)mmInputBoxTextChanged:(id)marked text:(NSString *)query;
- (void)onTextFieldChanged:(UITextField *)field;
- (void)onGetTextInput:(NSString *)query isFromVoice:(BOOL)voice;
- (void)onGetTextInputFromNewVoice:(NSString *)query voiceId:(id)voiceID;
@end
@interface FTSVoiceSearchBarController : NSObject
@property(nonatomic,weak) FTSHomeViewController *page;
@property(nonatomic) BOOL searching,throwOnEmpty;
@property(nonatomic) NSUInteger cancels,searches,delayedSearches;
@property(nonatomic,copy) NSString *latestCompeleteWebSearchQuery;
@property(nonatomic,strong) NSMutableArray *queries,*history;
@property(nonatomic,copy) NSArray *results;
- (void)handleTextDidChange:(NSString *)query;
- (void)handleTextDidChange:(NSString *)query fromNewVoice:(BOOL)voice;
- (void)cancelFTSSearch;
- (void)doSearch:(NSString *)query;
- (void)doFTSSearch:(NSString *)query;
- (void)recordLocalSearchHistory:(NSString *)query;
- (void)delaySearchImp:(NSString *)query;
- (void)delayPardusSearchImp:(NSString *)query;
@end
@implementation FTSVoiceSearchBarController
- (instancetype)init {if((self=[super init])){_queries=[NSMutableArray array];_history=[NSMutableArray array];}return self;}
- (void)handleTextDidChange:(NSString *)query {[self handleTextDidChange:query fromNewVoice:NO];}
- (void)handleTextDidChange:(NSString *)query fromNewVoice:(BOOL)voice {
    (void)voice;
    if(!query.length && self.throwOnEmpty) @throw [NSException exceptionWithName:@"Native" reason:nil userInfo:nil];
    self.searching=query.length!=0;
    if(query.length) {[self.queries addObject:query];[self.page setLoadingStatus];}
    else self.results=@[];
}
- (void)cancelFTSSearch {self.cancels++;self.searching=NO;}
- (void)doSearch:(NSString *)query {self.searches++;[self handleTextDidChange:query];}
- (void)doFTSSearch:(NSString *)query {self.results=@[query];}
- (void)recordLocalSearchHistory:(NSString *)query {[self.history addObject:query];}
- (void)delaySearchImp:(NSString *)query {self.delayedSearches++;[self doFTSSearch:query];}
- (void)delayPardusSearchImp:(NSString *)query {self.results=@[query];}
@end
@implementation FTSHomeViewController
- (NSString *)searchBarText {return self.searchBar ? self.searchBar.textView.text : self.searchTextField.text;}
- (void)reloadList {self.reloads++;(void)[self objectsForListAdapter:nil];}
- (void)resignSearchFirstResponder {self.resigns++;}
- (void)updateViewHideStates:(BOOL)empty {self.emptyPresentation=empty;}
- (void)setLoadingStatus {self.loadingStarts++;self.tableView.tableFooterView=@"loading";}
- (void)updateFooterView {self.footerReads++;if(self.presenter.searching)[self setLoadingStatus];}
- (NSArray *)objectsForListAdapter:(id)adapter {(void)adapter;self.sectionData=self.presenter.results;[self updateFooterView];return self.sectionData;}
- (void)shouldReturnStartSearch {self.submits++;[self resignSearchFirstResponder];[self.presenter recordLocalSearchHistory:[self searchBarText]];}
- (void)mmInputBoxTextChanged:(id)marked text:(NSString *)query {(void)marked;self.inputCallbacks++;[self.presenter handleTextDidChange:query];}
- (void)onTextFieldChanged:(UITextField *)field {[self mmInputBoxTextChanged:field.markedTextRange text:field.text];}
- (void)onGetTextInput:(NSString *)query isFromVoice:(BOOL)voice {(void)voice;[self.searchBar inputBoxSetTextOnly:query];[self mmInputBoxTextChanged:nil text:query];}
- (void)onGetTextInputFromNewVoice:(NSString *)query voiceId:(id)voiceID {(void)voiceID;[self onGetTextInput:query isFromVoice:YES];}
@end
@interface CSCloseFriendManager : NSObject
@property(nonatomic) NSUInteger probes,unlocks;
+ (instancetype)sharedManager;
- (BOOL)consumeHomepageSearchPassword:(NSString *)query;
@end
@implementation CSCloseFriendManager
+ (instancetype)sharedManager {static id manager; if(!manager)manager=[self new];return manager;}
- (BOOL)consumeHomepageSearchPassword:(NSString *)query {self.probes++;BOOL match=[query isEqual:@"654321"];if(match)self.unlocks++;return match;}
@end
static BOOL CSCFCallVoid(id object,NSString *name) {
    SEL selector=NSSelectorFromString(name); if(!CSCloseFriendMethodMatches(class_getInstanceMethod([object class],selector),"v@:")) return NO;
    ((void(*)(id,SEL))[object methodForSelector:selector])(object,selector); return YES;
}
static BOOL CSCFSetObject(id object,NSString *name,id value) {
    SEL selector=NSSelectorFromString(name); if(!CSCloseFriendMethodMatches(class_getInstanceMethod([object class],selector),"v@:@")) return NO;
    ((void(*)(id,SEL,id))[object methodForSelector:selector])(object,selector,value); return YES;
}
#include "SearchInputBodies.h"
#include "SearchInputHooks.h"
static FTSHomeViewController *SearchPage(BOOL modern) {
    FTSHomeViewController *page=[FTSHomeViewController new];page.searchTextField=[UITextField new];page.searchTextField.text=@"";
    page.tableView=[SearchTable new];page.presenter=[FTSVoiceSearchBarController new];page.presenter.page=page;
    if(modern) {
        page.searchTextField.text=@"unused";page.searchBar=[WCWebSearchBar new];page.searchBar.textView=[SearchTextWrapper new];
        page.searchBar.textView.textView=[UITextField new];page.searchBar.textView.text=@"";
        __weak FTSHomeViewController *weakPage=page;
        page.searchBar.didClear=^{[weakPage mmInputBoxTextChanged:nil text:@""];};
    }
    return page;
}
static void TypeSearch(FTSHomeViewController *page,NSString *query) {
    if(page.searchBar) {page.searchBar.textView.text=query;[page mmInputBoxTextChanged:nil text:query];}
    else {page.searchTextField.text=query;[page onTextFieldChanged:page.searchTextField];}
}
static void SearchInputChecks(void) {
    NSUInteger initialEpoch=Epoch;
    Current=Policy(NO,1);InstallSearchInputHooks();
    FTSHomeViewController *page=SearchPage(YES);FTSVoiceSearchBarController *presenter=page.presenter;
    [presenter performSelector:@selector(delaySearchImp:) withObject:@"previous query" afterDelay:0.01];
    for(NSString *prefix in @[@"6",@"65",@"654",@"6543",@"65432"]) {
        TypeSearch(page,prefix);[presenter handleTextDidChange:prefix fromNewVoice:YES];[presenter delayPardusSearchImp:prefix];
        [presenter recordLocalSearchHistory:prefix];[page updateFooterView];[page setLoadingStatus];
        Check([[page searchBarText] isEqual:prefix] && page.emptyPresentation && ![page objectsForListAdapter:nil].count && !page.tableView.tableFooterView,@"prefix stays in editor with no suggestions, result rows or loading footer");
    }
    Check(!presenter.queries.count && !presenter.history.count && !page.footerReads && !page.loadingStarts,@"typing never reaches original suggestion, history, footer logging or loading methods");
    [NSRunLoop.currentRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.02]];
    Check(!presenter.delayedSearches && !page.searchBar.textOnlyWrites,@"pending previous searches are cancelled without rewriting the editor");
    TypeSearch(page,@"654321");
    Check(page.searchBar.clears==1 && ![page searchBarText].length && page.resigns==1 && [page.searchTextField.text isEqual:@"unused"],@"exact password clears the actual large editor and dismisses keyboard");
    Check(!presenter.searching && !presenter.queries.count && !presenter.history.count && CSCFSearchSuppressLoading(page),@"unlock consumes password before query/history and cannot leave a loading task");
    TypeSearch(page,@"ordinary");Check(!presenter.queries.count,@"ordinary typing is retained until explicit Search");
    [page shouldReturnStartSearch];[presenter delaySearchImp:@"ordinary"];[presenter delayPardusSearchImp:@"ordinary"];
    Check(page.submits==1 && presenter.searches==1 && [presenter.queries isEqual:@[@"ordinary"]] && [presenter.history isEqual:@[@"ordinary"]] && [page objectsForListAdapter:nil].count==1 && !page.emptyPresentation,@"explicit submission starts native query once and allows delayed results/history");
    TypeSearch(page,@"6");[presenter delaySearchImp:@"ordinary"];[presenter recordLocalSearchHistory:@"ordinary"];
    Check(presenter.delayedSearches==1 && presenter.history.count==1 && ![page objectsForListAdapter:nil].count,@"next edit revokes old asynchronous query and clears prior visible results");
    NSUInteger probes=CSCloseFriendManager.sharedManager.probes;
    page.searchBar.textView.textView.markedTextRange=[NSObject new];TypeSearch(page,@"654321");[page shouldReturnStartSearch];
    Check(page.searchBar.clears==1 && page.searchBar.textView.textView.markedTextRange && CSCloseFriendManager.sharedManager.probes==probes && !presenter.searching,@"nested large-editor IME neither unlocks nor leaks suggestions, and is not unmarked");
    page.searchBar.textView.textView.markedTextRange=nil;TypeSearch(page,@"654321");
    Check(page.searchBar.clears==2,@"committed/pasted complete password unlocks");
    [page onGetTextInputFromNewVoice:@"voice query" voiceId:@"voice-1"];
    Check([[page searchBarText] isEqual:@"voice query"] && presenter.queries.count==1,@"voice input remains visible without native prefix dispatch");
    [page shouldReturnStartSearch];Check(presenter.searches==2,@"retained voice query can be submitted normally");
    Epoch++;[presenter delaySearchImp:@"voice query"];[page shouldReturnStartSearch];
    Check(presenter.delayedSearches==1 && page.submits==2 && CSCFSearchSuppressLoading(page),@"old page submission and callbacks cannot cross accounts");
    TypeSearch(page,@"new account");[page shouldReturnStartSearch];Check(page.submits==3,@"fresh edit binds a new ordinary search to the current account");
    FTSHomeViewController *legacy=SearchPage(NO);TypeSearch(legacy,@"65");Check(!legacy.presenter.queries.count,@"legacy editor also holds prefixes");
    TypeSearch(legacy,@"654321");Check(!legacy.searchTextField.text.length && legacy.resigns==1,@"legacy clear fallback preserves full-password unlock");
    TypeSearch(legacy,@"ordinary legacy");[legacy shouldReturnStartSearch];Check(legacy.presenter.searches==1,@"legacy explicit submission starts local search even without incremental results");
    presenter.throwOnEmpty=YES;
    @try {TypeSearch(page,@"throw");} @catch(__unused NSException *e) {}
    Check(!InputState(page).resetting,@"native reset exception cannot leave a broad reentrancy bypass");
    presenter.throwOnEmpty=NO;TypeSearch(page,@"65");Check(presenter.queries.count==3,@"after reset failure prefixes are still withheld");
    __block NSUInteger external=0;CSCFSearchDispatchInput([NSObject new],@"654321",NO,NO,^{external++;});
    Check(external==1,@"non-homepage searches remain native");
    Current=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"account-A" profile:@{@"enabled":@NO,@"friends":@[],@"groups":@[],@"options":CSCloseFriendDefaultOptions()} revealed:NO revision:99 blocked:NO];
    NSUInteger unlocks=CSCloseFriendManager.sharedManager.unlocks;TypeSearch(page,@"654321");
    Check(!CSCFSearchSuppressLoading(page) && presenter.queries.count==4 && CSCloseFriendManager.sharedManager.unlocks==unlocks,@"feature disabled restores native live search without password interception");
    Epoch=initialEpoch;
    printf("Search input: prefix isolation, full unlock, installed submit/delay/footer hooks, IME, voice and account boundaries passed\n");
}
