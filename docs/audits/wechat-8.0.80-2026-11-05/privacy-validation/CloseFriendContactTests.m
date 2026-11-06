#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "CSCloseFriendContactProjection.h"
#import "CSCloseFriendSignatures.h"
static NSUInteger checks;
static void Check(BOOL condition,NSString *message) { checks++; if(!condition) {fprintf(stderr,"FAIL: %s\n",message.UTF8String); exit(1);} }
@interface Contact : NSObject
@property(nonatomic,copy) NSString *username, *m_nsNickName, *remark;
@property(nonatomic) BOOL isFriend;
@end
@implementation Contact @end
static Contact *Person(NSString *name) {Contact *c=[Contact new]; c.username=name; c.isFriend=YES; return c;}
static CSCloseFriendSnapshot *Policy(BOOL revealed,NSUInteger revision) {
    return [[CSCloseFriendSnapshot alloc] initWithAccountID:@"account-A" profile:@{@"enabled":@YES,@"friends":@[@"secret"],@"groups":@[@"private@chatroom"],@"options":CSCloseFriendDefaultOptions()} revealed:revealed revision:revision blocked:NO];
}
static CSCloseFriendSnapshot *Current;
static NSUInteger Epoch=1;
NSUInteger CSCloseFriendAccountEpoch(void) { return Epoch; }
CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) {return Current;}
BOOL CSCloseFriendShouldHideUserName(NSString *name,CSCloseFriendSurface surface) {return [Current hidesUserName:name surface:surface];}
id CSCloseFriendRead(id object,NSString *key) {@try {return [object valueForKey:key];} @catch(__unused NSException *e) {return nil;}}
NSString *CSCloseFriendUserName(id object) {return [object isKindOfClass:Contact.class] ? [object username] : nil;}
BOOL CSCFIsClass(id object,NSString *name) {return [object isKindOfClass:NSClassFromString(name)];}
#import "GroupTitle.h"
// The production profile state predicate, compiled verbatim by the focused runner.
@interface UIView : NSObject
@property(nonatomic,strong) id window;
@property(nonatomic,copy) NSArray *subviews;
@property(nonatomic) NSUInteger moves;
- (void)didMoveToWindow;
@end
@implementation UIView
- (void)didMoveToWindow {self.moves++;}
@end
@interface UITableView : UIView
@property(nonatomic) NSUInteger reloads;
- (void)reloadData;
@end
@implementation UITableView
- (void)reloadData {self.reloads++;}
@end
@interface UICollectionView : UITableView @end
@implementation UICollectionView @end
@interface UIViewController : NSObject
@property(nonatomic,strong) UIView *view;
@property(nonatomic,getter=isViewLoaded) BOOL viewLoaded;
@property(nonatomic) NSUInteger appearances;
- (void)viewWillAppear:(BOOL)animated;
@end
@implementation UIViewController
- (void)viewWillAppear:(__unused BOOL)animated {self.appearances++;}
@end
@interface DeferredPage : UIViewController @end
@implementation DeferredPage @end
BOOL CSCloseFriendInstallHook(NSString *,NSString *,IMP,IMP *,const char *);
#import "SurfaceRefreshBodies.h"
@interface ContactInfoViewController : UIViewController
@property(nonatomic,strong) Contact *m_contact;
@property(nonatomic,strong) id m_oContactInfoAssist;
@end
@implementation ContactInfoViewController @end
@interface CSCFProfileState : NSObject
@property(nonatomic,weak) UIViewController *owner;
@property(nonatomic,weak) id activeAssist;
@property(nonatomic) NSUInteger epoch, generation;
@property(nonatomic,copy) NSString *userName;
@end
@implementation CSCFProfileState @end
#import "ProfilePredicate.h"
#import "ProfileBindingClass.h"
static char ProfileKey, AssistBindingKey, PresentationDepthKey;
void CSCFProfileLocalAdd(id object) {(void)object;}
NSString *const CSCloseFriendPolicyDidChangeNotification=@"TestPolicyChanged";
void CSCFProfileRefresh(id object) {(void)object;}
#import "ProfileBindings.h"
static char PageEpochKey, ForwardSourcesKey, ForwardUpdateDepthKey;
NSArray *CSCFVisible(NSArray *source,CSCloseFriendSurface surface) {
    return CSCloseFriendVisibleContacts(source,Current,surface,^NSString *(id item){return CSCloseFriendUserName(item);});
}
#import "ForwardBodies.h"
@interface NativeForward : NSObject {
@public
    NSMutableArray *arrSearchResultOfContacts, *arrSearchResultOfGroup, *arrSearchResultOfTopHit, *arrSectionKey;
    NSMutableDictionary *dicSearchResult;
}
@end
@implementation NativeForward @end
BOOL CSCloseFriendInstallHook(NSString *className,NSString *name,IMP replacement,IMP *original,const char *encoding) {
    Class cls=NSClassFromString(className); SEL selector=NSSelectorFromString(name); Method method=class_getInstanceMethod(cls,selector);
    if(!CSCloseFriendMethodMatches(method,encoding)) return NO; *original=method_getImplementation(method); class_replaceMethod(cls,selector,replacement,method_getTypeEncoding(method)); return YES;
}
// Compile the production action wrappers, rather than a test-only imitation of their control flow.
#import "ProfileGuards.h"
@interface NativeAssist : NSObject
@property(nonatomic) NSUInteger sent;
@property(nonatomic,copy) NSString *nativeButton;
- (BOOL)isInMyContactList;
- (void)renderButtons;
@property(nonatomic,strong) Contact *m_contact;
@property(nonatomic,weak) id owner;
- (id)getViewController;
- (void)doAddContact;
- (void)onNewMessage:(id)sender;
@end
@implementation NativeAssist
- (id)getViewController {return self.owner;}
- (BOOL)isInMyContactList {return self.m_contact.isFriend;}
- (void)renderButtons {self.nativeButton=[self isInMyContactList] ? @"发消息" : @"添加到通讯录";}
- (void)doAddContact {self.sent++;}
- (void)onNewMessage:(id)sender {(void)sender; self.sent++;}
@end
#include "CloseFriendSearchInputFixture.h"
static void SurfaceRefreshChecks(void) {
    DeferredPage *page=[DeferredPage new];page.view=[UIView new];page.viewLoaded=YES;
    __block NSUInteger old=0,latest=0;
    CSCFRefreshSurface(page,^(__unused id owner){old++;});
    CSCFRefreshSurface(page,^(id owner){latest++;Check(owner==page,@"refresh receives its original owner");});
    Check(!old && !latest && !page.appearances,@"offscreen policy changes defer work");
    [page viewWillAppear:YES];[page viewWillAppear:NO];
    Check(!old && latest==1 && page.appearances==2,@"appearance runs latest refresh once and retains original lifecycle");
    UIViewController *untracked=[UIViewController new];[untracked viewWillAppear:NO];
    Check(untracked.appearances==1 && latest==1,@"inherited lifecycle hook is isolated to tracked class");
    page.view.window=[NSObject new];CSCFRefreshSurface(page,^(__unused id owner){latest++;});
    Check(latest==2,@"visible page refreshes immediately");
    UIView *view=[UIView new];CSCFRefreshSurface(view,^(__unused id owner){latest++;});[view didMoveToWindow];
    Check(latest==2 && view.moves==1,@"view remains deferred until attached to window");
    view.window=[NSObject new];[view didMoveToWindow];[view didMoveToWindow];
    Check(latest==3 && view.moves==3,@"window attachment consumes deferred refresh once");
    UITableView *table=[UITableView new];UICollectionView *media=[UICollectionView new];
    table.subviews=@[media];page.view.subviews=@[table];CSCFReloadTables(page);
    Check(table.reloads==1 && !media.reloads,@"reload stops at owning table, preserving nested media layout");
}
int main(void) {@autoreleasepool {
    SurfaceRefreshChecks();
    SearchInputChecks();
    CSCloseFriendIdentity identity=^NSString *(id item){return [item isKindOfClass:NSString.class] ? item : [item username];};
    Contact *visible=Person(@"ordinary"), *hidden=Person(@"secret"), *group=Person(@"private@chatroom");
    NSMutableArray *a=[NSMutableArray arrayWithArray:@[hidden,visible]], *b=[NSMutableArray arrayWithObject:group];
    NSDictionary *source=@{@"A":a,@"B":b}; Current=Policy(NO,1);
    CSCloseFriendContactProjection *p=[[CSCloseFriendContactProjection alloc] initWithKeys:@[@"A",@"B"] sections:source snapshot:Current surface:CSCloseFriendSurfaceContact identity:identity];
    Check(p.count==1 && [p.keys isEqual:@[@"A"]] && p.sections[@"A"][0]==visible,@"count, section index, and selected object share one projection");
    Check(a.count==2 && b.count==1 && hidden.isFriend,@"source arrays and relationship untouched");
    [a removeObject:visible]; Check([p.sections[@"A"] count]==1,@"source updates do not mutate a published projection");
    CSCloseFriendContactProjection *next=[[CSCloseFriendContactProjection alloc] initWithKeys:@[@"A",@"B"] sections:source snapshot:Current surface:CSCloseFriendSurfaceContact identity:identity];
    Check(next.count==0 && next.keys.count==0,@"fresh snapshot reflects removals and empty sections");
    Check(CSCloseFriendVisibleContacts(a,Policy(YES,2),CSCloseFriendSurfaceContact,identity).count==1,@"reveal derives from intact latest source");
    NSArray *members=@[@"secret",@"ordinary"];
    Check(CSCloseFriendVisibleContacts(members,Current,CSCloseFriendSurfaceTag,identity).count==1 && members.count==2,@"tag presentation preserves full membership");
    Current=Policy(YES,2); CSCloseFriendSelectionTicket *ticket=[[CSCloseFriendSelectionTicket alloc] initWithSnapshot:Current epoch:Epoch];
    Check([ticket allowsRecipients:@[visible,hidden] snapshot:Current epoch:Epoch identity:identity],@"revealed native recipients accepted intact");
    Check(![ticket allowsRecipients:@[visible,hidden] snapshot:Policy(NO,3) epoch:Epoch identity:identity],@"locking rejects entire stale recipient selection");
    Check(![ticket allowsRecipients:@[visible] snapshot:Current epoch:2 identity:identity],@"account boundary invalidates even ordinary recipients");
    CSCloseFriendSelectionTicket *locked=[[CSCloseFriendSelectionTicket alloc] initWithSnapshot:Policy(NO,3) epoch:Epoch];
    Check(![locked allowsRecipients:@[visible,hidden] snapshot:Policy(NO,3) epoch:Epoch identity:identity],@"current concealed recipient blocks entire submit");
    group.m_nsNickName=@"公开群名"; group.remark=@"密友匹配摘要";
    Check([GroupDisplayTitle(group) isEqual:@"公开群名"],@"group row cover exposes public group title, never member-match summary");
    hidden.m_nsNickName=@"公开昵称"; hidden.remark=@"私密备注";
    Current=Policy(NO,3);
    NSArray *nativeRows=@[@{@"model":hidden},@{@"model":visible},@{@"model":group},@{@"model":@{@"feature":@1}}];
    NSArray *filtered=CSCFSearchVisibleRows(nativeRows);
    Check(filtered.count==2 && filtered[0]==nativeRows[1] && filtered[1]==nativeRows[3],@"native FTS row.model filters nickname/remark contact and group hits, preserves feature rows");
    Check(nativeRows.count==4 && hidden.isFriend,@"search projection preserves native results and real friendship");
    Current=Policy(YES,4); Check(CSCFSearchVisibleRows(nativeRows).count==4,@"search reveal restores original row wrappers");
    Check([GroupDisplayTitle(@{@"model":group}) isEqual:@"公开群名"],@"group summary unwraps the same native row model");
    NativeForward *forward=[NativeForward new];
    CSCFForwardSearchWillUpdate(forward);
    forward->arrSearchResultOfContacts=[@[hidden,visible] mutableCopy]; forward->arrSearchResultOfGroup=[NSMutableArray array]; forward->arrSearchResultOfTopHit=[NSMutableArray array];
    forward->arrSectionKey=[@[@"first"] mutableCopy]; forward->dicSearchResult=[@{@"first":[@[hidden,visible] mutableCopy]} mutableCopy];
    Current=Policy(NO,3); CSCFForwardSearchDidUpdate(forward);
    CSCFForwardSearchWillUpdate(forward);
    NSMutableArray *reusedKeys=forward->arrSectionKey; NSMutableDictionary *reusedSections=forward->dicSearchResult;
    [reusedKeys removeAllObjects]; [reusedKeys addObject:@"second"];
    [reusedSections removeAllObjects]; reusedSections[@"second"]=[@[hidden,group] mutableCopy];
    forward->arrSearchResultOfContacts=[@[hidden] mutableCopy]; forward->arrSearchResultOfGroup=[@[group] mutableCopy];
    CSCFForwardSearchWillUpdate(forward); CSCFRefreshForwardSearch(forward); CSCFForwardSearchDidUpdate(forward); // Nested native merge must not publish filtered source early.
    Check(forward->arrSectionKey==reusedKeys && forward->dicSearchResult==reusedSections,@"native second-query buffers mutate in place through nested merge");
    CSCFForwardSearchDidUpdate(forward);
    Current=Policy(YES,4); CSCFRefreshForwardSearch(forward);
    Check([forward->arrSectionKey isEqual:@[@"second"]] && [forward->dicSearchResult[@"second"] isEqual:@[hidden,group]] && !forward->dicSearchResult[@"first"],@"consecutive in-place queries publish current complete sections and reveal current hidden members");
    Guard0(@"NativeAssist",@"doAddContact"); Guard1(@"NativeAssist",@"onNewMessage:"); NativeAssist *assist=[NativeAssist new];
    ContactInfoViewController *page=[ContactInfoViewController new]; page.m_contact=hidden; page.m_oContactInfoAssist=assist; assist.m_contact=hidden; assist.owner=page;
    CSCFProfileBind(page);
    DisplayFlag(@"NativeAssist",@"isInMyContactList"); Render0(@"NativeAssist",@"renderButtons");
    Current=Policy(NO,5); [assist renderButtons];
    Check([assist.nativeButton isEqual:@"添加到通讯录"] && [assist isInMyContactList] && hidden.isFriend,@"native button construction sees stranger only inside the bound scope");
    @try {CSCFProfileWithNativePresentation(assist,^{@throw [NSException exceptionWithName:@"Fixture" reason:nil userInfo:nil];});} @catch(__unused NSException *e) {}
    Check([assist isInMyContactList],@"native presentation scope restores real relationship after an exception");
    Current=Policy(YES,6); [assist renderButtons]; Check([assist.nativeButton isEqual:@"发消息"],@"reveal rebuilds original native friend button");
    Current=Policy(NO,3); [assist doAddContact]; [assist onNewMessage:nil];
    Check(assist.sent==0 && hidden.isFriend,@"masked profile guards never invoke native add/message or change friendship");
    Current=Policy(YES,4); [assist onNewMessage:nil]; Check(assist.sent==1,@"reveal permits native action again");
    NativeAssist *replacement=[NativeAssist new]; replacement.m_contact=visible; replacement.owner=page;
    page.m_contact=visible; page.m_oContactInfoAssist=replacement; CSCFProfileBind(page);
    Current=Policy(NO,5); [assist doAddContact]; [assist onNewMessage:nil]; [replacement onNewMessage:nil];
    Check(assist.sent==1 && replacement.sent==1,@"retired assist cannot inherit ordinary replacement authorization while the current ordinary assist works");
    Current=Policy(YES,6); [assist onNewMessage:nil]; Check(assist.sent==1,@"retired assist remains rejected even during reveal");
    Epoch++; [replacement doAddContact]; Check(replacement.sent==1,@"stale assist stays blocked across accounts");
    printf("Close-friend contacts: projection/source/tag preservation, stale forwarding, profile action guards and native-reuse regressions passed\n");
    printf("CloseFriendContactTests: %lu checks passed\n",(unsigned long)checks);
} return 0;}
