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
// Keep native section behavior behind the actual production guards. A hidden
// aggregate has zero items; no substitute row or unlock action is manufactured.
@interface UITableViewCell : NSObject @end
@implementation UITableViewCell @end
#include "SearchSectionBodies.h"
@interface NativeSearchSection : NSObject
@property(nonatomic) NSUInteger cellCalls,selections,loads;
- (NSInteger)numberOfItems;
- (id)cellForItemAtIndex:(NSInteger)index section:(NSInteger)section;
- (void)didSelectRowAtIndex:(NSInteger)index;
- (void)didSelectDataRowAtIndex:(NSInteger)index indexPath:(id)path;
- (void)onLoadMore;
@end
@implementation NativeSearchSection
- (NSInteger)numberOfItems {return 3;}
- (id)cellForItemAtIndex:(NSInteger)index section:(NSInteger)section {(void)index;(void)section;self.cellCalls++;return @"native row";}
- (void)didSelectRowAtIndex:(NSInteger)index {(void)index;self.selections++;}
- (void)didSelectDataRowAtIndex:(NSInteger)index indexPath:(id)path {(void)index;(void)path;self.selections++;}
- (void)onLoadMore {self.loads++;}
@end
// Own methods on each class, matching MSHookMessageEx's per-class isolation.
#define NATIVE_SECTION_METHODS \
- (NSInteger)numberOfItems {return [super numberOfItems];} \
- (id)cellForItemAtIndex:(NSInteger)index section:(NSInteger)section {return [super cellForItemAtIndex:index section:section];} \
- (void)didSelectRowAtIndex:(NSInteger)index {[super didSelectRowAtIndex:index];} \
- (void)didSelectDataRowAtIndex:(NSInteger)index indexPath:(id)path {[super didSelectDataRowAtIndex:index indexPath:path];} \
- (void)onLoadMore {[super onLoadMore];}
@interface FTSMessageSectionController : NativeSearchSection @end
@implementation FTSMessageSectionController
NATIVE_SECTION_METHODS
@end
@interface FTSSearchContactSectionController : NativeSearchSection @end
@implementation FTSSearchContactSectionController
NATIVE_SECTION_METHODS
@end
#undef NATIVE_SECTION_METHODS
#include "SearchSectionHooks.h"
static void SearchSectionChecks(void) {
    NSUInteger epoch=Epoch;Current=Policy(NO,10);
    InstallSection(@"FTSMessageSectionController",nil);InstallSection(@"FTSSearchContactSectionController",nil);
    NSArray *sections=@[[FTSMessageSectionController new],[FTSSearchContactSectionController new]];
    for(NativeSearchSection *section in sections) {
        Check([section numberOfItems]==0,@"concealed search aggregates have zero rows, no unlock placeholder");
        Check([[section cellForItemAtIndex:0 section:0] isKindOfClass:UITableViewCell.class] && !section.cellCalls,@"stale cell requests cannot render native concealed content");
        [section didSelectRowAtIndex:0];[section didSelectDataRowAtIndex:0 indexPath:nil];[section onLoadMore];
        Check(!section.selections && !section.loads,@"removed placeholder has no leftover selection or load action");
    }
    Current=Policy(YES,11);
    for(NativeSearchSection *section in sections) {
        Check([section numberOfItems]==3 && [[section cellForItemAtIndex:0 section:0] isEqual:@"native row"],@"unlock restores original aggregate rows");
        [section didSelectRowAtIndex:0];[section onLoadMore];
        Check(section.selections==1 && section.loads==1,@"revealed native selection and pagination remain available");
    }
    Epoch++;
    for(NativeSearchSection *section in sections)Check([section numberOfItems]==0,@"stale account cannot regain hidden search rows");
    Epoch=epoch;
}
static void SearchInputChecks(void) {
    Current=Policy(NO,1);InstallSearchInputHooks();
    FTSHomeViewController *page=SearchPage(YES);FTSVoiceSearchBarController *presenter=page.presenter;
    NSArray *nativeRows=@[@"搜索网络结果",@"61",@"619电竞",@"61路公交"];
    presenter.results=nativeRows;
    for(NSString *prefix in @[@"6",@"61",@"65",@"654",@"6543",@"65432"]) {
        TypeSearch(page,prefix);
        Check([[page searchBarText] isEqual:prefix] && [presenter.queries.lastObject isEqual:prefix] && !CSCFSearchSuppressLoading(page),@"prefix flows immediately to native live search, without requiring Return");
        Check([page objectsForListAdapter:nil]==nativeRows && page.tableView.tableFooterView && !page.emptyPresentation,@"native web entry, suggestions and loading remain unchanged while typing");
    }
    [presenter delayPardusSearchImp:@"65432"];[presenter recordLocalSearchHistory:@"65432"];
    Check([[page objectsForListAdapter:nil] isEqual:@[@"65432"]] && [presenter.history.lastObject isEqual:@"65432"],@"native delayed suggestion and ordinary history paths stay enabled");
    NSUInteger queries=presenter.queries.count,history=presenter.history.count,probes=CSCloseFriendManager.sharedManager.probes;
    [presenter performSelector:@selector(delaySearchImp:) withObject:@"65432" afterDelay:0.01];
    TypeSearch(page,@"654321");
    Check(page.searchBar.clears==1 && ![page searchBarText].length && page.resigns==1 && [page.searchTextField.text isEqual:@"unused"],@"exact password clears actual large editor and dismisses keyboard");
    Check(CSCloseFriendManager.sharedManager.probes==probes+1 && presenter.queries.count==queries && presenter.history.count==history && !presenter.searching && CSCFSearchSuppressLoading(page),@"only complete password is consumed before native query/history, without recursive verification");
    [NSRunLoop.currentRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.02]];
    Check(!presenter.delayedSearches,@"password unlock cancels already scheduled prefix search");
    presenter.results=nativeRows;page.tableView.tableFooterView=@"late loading";
    [presenter delaySearchImp:@"65432"];[presenter recordLocalSearchHistory:@"654321"];[page updateFooterView];[page setLoadingStatus];
    Check(![page objectsForListAdapter:nil].count && !page.tableView.tableFooterView && presenter.history.count==history && !presenter.delayedSearches,@"late callbacks cannot revive cleared password search or history");
    TypeSearch(page,@"ordinary");presenter.results=nativeRows;
    Check(presenter.queries.count==queries+1 && presenter.searching && !CSCFSearchSuppressLoading(page) && [page objectsForListAdapter:nil]==nativeRows,@"next ordinary edit immediately restores native live results and loading");
    NSUInteger searches=presenter.searches;[page shouldReturnStartSearch];
    Check(page.submits==1 && presenter.searches==searches && [presenter.history.lastObject isEqual:@"ordinary"],@"Return keeps native submit behavior without injecting another search");
    probes=CSCloseFriendManager.sharedManager.probes;NSUInteger clears=page.searchBar.clears;
    page.searchBar.textView.textView.markedTextRange=[NSObject new];TypeSearch(page,@"654321");
    Check(page.searchBar.clears==clears && page.searchBar.textView.textView.markedTextRange && CSCloseFriendManager.sharedManager.probes==probes && [presenter.queries.lastObject isEqual:@"654321"],@"IME composition follows native behavior without early password consumption or unmarking");
    page.searchBar.textView.textView.markedTextRange=nil;TypeSearch(page,@"654321");Check(page.searchBar.clears==clears+1,@"confirmed complete password unlocks");
    [page onGetTextInputFromNewVoice:@"voice query" voiceId:@"voice-1"];
    Check([[page searchBarText] isEqual:@"voice query"] && [presenter.queries.lastObject isEqual:@"voice query"],@"voice input retains native editor and live search behavior");
    queries=presenter.queries.count;[page onGetTextInput:@"654321" isFromVoice:YES];
    Check(![page searchBarText].length && presenter.queries.count==queries,@"full voice password is consumed before original voice dispatch");
    FTSHomeViewController *legacy=SearchPage(NO);TypeSearch(legacy,@"65");
    Check([legacy.presenter.queries isEqual:@[@"65"]],@"legacy partial input searches immediately");
    TypeSearch(legacy,@"654321");Check(!legacy.searchTextField.text.length && legacy.resigns==1,@"legacy clear fallback retains full-password unlock");
    TypeSearch(legacy,@"ordinary legacy");[legacy shouldReturnStartSearch];
    Check(legacy.submits==1 && legacy.presenter.searches==0 && [legacy.presenter.queries.lastObject isEqual:@"ordinary legacy"],@"legacy return uses existing native search without replay");
    page.searchBar.textView.text=@"654321";queries=presenter.queries.count;[page shouldReturnStartSearch];
    Check(page.submits==1 && presenter.queries.count==queries && ![page searchBarText].length,@"Return also consumes complete password if an edit callback was bypassed");
    presenter.throwOnEmpty=YES;
    @try {TypeSearch(page,@"654321");} @catch(__unused NSException *e) {}
    Check(!InputState(page).resetting && !InputState(page).dispatchDepth,@"native reset exception restores dispatch guards");
    presenter.throwOnEmpty=NO;TypeSearch(page,@"recovered");Check([presenter.queries.lastObject isEqual:@"recovered"],@"next ordinary input remains usable after a reset exception");
    __block NSUInteger external=0;CSCFSearchDispatchInput([NSObject new],@"654321",NO,^{external++;});
    Check(external==1,@"non-homepage searches remain native");
    Current=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"account-A" profile:@{@"enabled":@NO,@"friends":@[],@"groups":@[],@"options":CSCloseFriendDefaultOptions()} revealed:NO revision:99 blocked:NO];
    NSUInteger unlocks=CSCloseFriendManager.sharedManager.unlocks;TypeSearch(page,@"654321");
    Check(!CSCFSearchSuppressLoading(page) && [presenter.queries.lastObject isEqual:@"654321"] && CSCloseFriendManager.sharedManager.unlocks==unlocks,@"disabled feature leaves native live search intact");
    SearchSectionChecks();
    printf("Search: zero unlock placeholders, native live suggestions/web/history/submit, full unlock, late callbacks and IME passed\n");
}
