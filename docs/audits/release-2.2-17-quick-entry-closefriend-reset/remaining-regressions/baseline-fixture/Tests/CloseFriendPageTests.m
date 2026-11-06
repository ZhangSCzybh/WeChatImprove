#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import "CSCloseFriendContactProjection.h"
#import "CSCloseFriendSignatures.h"
static NSUInteger checks,epoch=1;
static CSCloseFriendSnapshot *policy;
static void Check(BOOL ok,NSString *label) {checks++;if(!ok){fprintf(stderr,"FAIL: %s\n",label.UTF8String);exit(1);}}
static void SetPolicy(BOOL enabled,BOOL revealed,NSUInteger revision) {
    policy=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"fixture" profile:@{@"enabled":@(enabled),@"friends":@[@"secret"],@"groups":@[@"secret@chatroom"],@"options":CSCloseFriendDefaultOptions()} revealed:revealed revision:revision blocked:NO];
}
CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void){return policy;}
NSUInteger CSCloseFriendAccountEpoch(void){return epoch;}
BOOL CSCloseFriendShouldHideUserName(NSString *name,CSCloseFriendSurface surface){return [policy hidesUserName:name surface:surface];}
id CSCloseFriendRead(id object,NSString *name){@try{return [object valueForKey:name];}@catch(__unused NSException *e){return nil;}}
NSString *CSCloseFriendUserName(id object){return [object isKindOfClass:NSString.class]?object:CSCloseFriendRead(object,@"m_nsUsrName");}
BOOL CSCFIsClass(id object,NSString *name){return [object isKindOfClass:NSClassFromString(name)];}
static char EpochKey;
BOOL CSCFPageIsCurrent(id owner){NSNumber *saved=objc_getAssociatedObject(owner,&EpochKey);if(!saved){saved=@(epoch);objc_setAssociatedObject(owner,&EpochKey,saved,OBJC_ASSOCIATION_RETAIN_NONATOMIC);}return saved.unsignedIntegerValue==epoch;}
NSArray *CSCFVisible(NSArray *source,CSCloseFriendSurface surface){return CSCloseFriendVisibleContacts(source,policy,surface,^NSString *(id item){return CSCloseFriendUserName(item);});}
BOOL CSCFSetObject(id object,NSString *name,id value){SEL s=NSSelectorFromString(name);if(!CSCloseFriendMethodMatches(class_getInstanceMethod([object class],s),"v@:@"))return NO;((void(*)(id,SEL,id))objc_msgSend)(object,s,value);return YES;}
void CSCFTrackSurface(id owner,NSString *selector){CSCFPageIsCurrent(owner);}
void CSCloseFriendRecordCapability(NSString *name,BOOL ready){Check(ready,name);}
BOOL CSCloseFriendInstallHook(NSString *name,NSString *method,IMP replacement,IMP *original,const char *type){
    Class cls=NSClassFromString(name);SEL s=NSSelectorFromString(method);Method m=class_getInstanceMethod(cls,s);
    if(!CSCloseFriendMethodMatches(m,type))return NO;*original=method_getImplementation(m);
    if(!class_addMethod(cls,s,replacement,method_getTypeEncoding(m)))method_setImplementation(m,replacement);
    return YES;
}
@interface View : NSObject
@property(nonatomic) BOOL hidden;
@property(nonatomic,strong) id window;
@property(nonatomic,copy) NSString *text,*image;
@end
@implementation View @end
@class UINavigationController;
@interface UIViewController : NSObject
@property(nonatomic,strong) View *view;
@property(nonatomic,strong) UIViewController *presentedViewController;
@property(nonatomic,weak) UIViewController *presentingViewController,*parentViewController;
@property(nonatomic,copy) NSArray *childViewControllers;
@property(nonatomic,weak) UINavigationController *navigationController;
@property(nonatomic) BOOL isViewLoaded;
@property(nonatomic) NSUInteger dismissals;
- (void)dismissViewControllerAnimated:(BOOL)animated completion:(void(^)(void))completion;
@end
@implementation UIViewController
- (instancetype)init{if((self=[super init])){_view=[View new];_view.window=@YES;_isViewLoaded=YES;_childViewControllers=@[];}return self;}
- (void)dismissViewControllerAnimated:(BOOL)animated completion:(void(^)(void))completion{self.dismissals++;self.presentedViewController.presentingViewController=nil;self.presentedViewController=nil;if(completion)completion();}
@end
@interface UIAlertController : UIViewController @end
@implementation UIAlertController @end
@interface UINavigationController : UIViewController
@property(nonatomic,copy) NSArray<UIViewController *> *viewControllers;
@property(nonatomic,readonly) UIViewController *topViewController;
@property(nonatomic) NSUInteger pops;
- (void)setViewControllers:(NSArray *)pages animated:(BOOL)animated;
- (NSArray *)popToViewController:(UIViewController *)page animated:(BOOL)animated;
@end
@implementation UINavigationController
- (void)setViewControllers:(NSArray *)pages{for(UIViewController *p in _viewControllers){p.parentViewController=nil;p.navigationController=nil;}_viewControllers=[pages copy];self.childViewControllers=pages;for(UIViewController *p in pages){p.parentViewController=self;p.navigationController=self;}}
- (void)setViewControllers:(NSArray *)pages animated:(BOOL)animated{self.viewControllers=pages;self.pops++;}
- (UIViewController *)topViewController{return self.viewControllers.lastObject;}
- (NSArray *)popToViewController:(UIViewController *)page animated:(BOOL)animated{NSUInteger i=[self.viewControllers indexOfObject:page];Check(i!=NSNotFound,@"pop target belongs to its navigation stack");self.viewControllers=[self.viewControllers subarrayWithRange:NSMakeRange(0,i+1)];self.pops++;return @[];}
@end
@interface UITabBarController : UIViewController
@property(nonatomic,strong) UIViewController *selectedViewController;
@property(nonatomic,copy) NSArray *viewControllers;
@end
@implementation UITabBarController
- (void)setViewControllers:(NSArray *)pages{_viewControllers=[pages copy];self.childViewControllers=pages;for(UIViewController *p in pages)p.parentViewController=self;}
@end
@interface NewMainFrameViewController : UIViewController @end
@implementation NewMainFrameViewController @end
@interface BaseMsgContentViewController : UIViewController
@property(nonatomic,strong) id contact;
- (id)GetContact;
@end
@implementation BaseMsgContentViewController
- (id)GetContact{return self.contact;}
@end
#import "Navigation.h"
static void NavigationTests(void){
    SetPolicy(YES,NO,1);
    NewMainFrameViewController *home=[NewMainFrameViewController new];UIViewController *contacts=[UIViewController new],*moments=[UIViewController new],*search=[UIViewController new];
    UINavigationController *chatNav=[UINavigationController new],*contactNav=[UINavigationController new];chatNav.viewControllers=@[home];contactNav.viewControllers=@[contacts,moments];
    UITabBarController *tabs=[UITabBarController new];tabs.viewControllers=@[chatNav,contactNav];tabs.selectedViewController=contactNav;
    Check(!CSCFReturnProtectedChatToList(tabs,home) && contactNav.topViewController==moments && tabs.selectedViewController==contactNav,@"lock keeps Moments and selected Contacts tab");
    moments.presentedViewController=search;search.presentingViewController=moments;
    Check(!CSCFReturnProtectedChatToList(tabs,home)&&moments.presentedViewController==search,@"ordinary search modal remains open on lock");
    moments.presentedViewController=nil;
    BaseMsgContentViewController *normal=[BaseMsgContentViewController new];normal.contact=@"normal";chatNav.viewControllers=@[home,normal];tabs.selectedViewController=chatNav;
    Check(!CSCFReturnProtectedChatToList(tabs,home)&&chatNav.topViewController==normal,@"ordinary chat stays in place");
    BaseMsgContentViewController *secret=[BaseMsgContentViewController new];secret.contact=@"secret@chatroom";secret.childViewControllers=@[[UIViewController new]];chatNav.viewControllers=@[home,secret];
    SetPolicy(YES,YES,2);Check(!CSCFReturnProtectedChatToList(tabs,home),@"revealed secret chat is native");
    SetPolicy(YES,NO,3);Check(CSCFReturnProtectedChatToList(tabs,home)&&chatNav.topViewController==home,@"concealed group chat returns to chat list");
    secret.contact=@"secret";contactNav.viewControllers=@[contacts,secret];tabs.selectedViewController=contactNav;
    Check(CSCFReturnProtectedChatToList(tabs,home)&&tabs.selectedViewController==chatNav&&contactNav.topViewController==contacts,@"secret chat from Contacts returns to actual chat tab and removes its old chat");
    contactNav.viewControllers=@[contacts,secret,moments];tabs.selectedViewController=contactNav;
    Check(!CSCFReturnProtectedChatToList(tabs,home)&&contactNav.topViewController==moments,@"normal page above secret chat stays open");
    contactNav.viewControllers=@[contacts,secret];Check(CSCFReturnProtectedChatToList(tabs,home),@"returning to concealed old chat is rejected");
    UINavigationController *modal=[UINavigationController new];modal.viewControllers=@[secret];home.presentedViewController=modal;modal.presentingViewController=home;
    Check(CSCFReturnProtectedChatToList(tabs,nil)&&home.presentedViewController==nil&&chatNav.topViewController==home,@"modal secret chat dismisses to discovered native home");
    chatNav.viewControllers=@[home,secret];SetPolicy(NO,NO,4);Check(!CSCFReturnProtectedChatToList(tabs,home),@"disabled close friends leaves chat untouched");
}
@interface MemberDataLogic : NSObject
@property(nonatomic,strong) NSMutableDictionary *sections;
@property(nonatomic,strong) NSMutableArray *keys;
@property(nonatomic,copy) NSArray *filtered;
- (NSArray *)getKeyArray;- (NSUInteger)getSectionItemCount:(NSUInteger)section;- (id)getItemInSection:(NSUInteger)section atRow:(NSUInteger)row;
- (NSArray *)getFilteredContacts;- (NSArray *)getAllContacts;
- (void)reloadMemberList:(id)contacts;- (void)addContact:(id)contact;- (BOOL)removeContact:(id)contact;- (void)sortKeys;- (void)doSearch:(NSString *)query;
@end
@implementation MemberDataLogic
- (NSArray *)getKeyArray{return self.keys;}
- (NSUInteger)getSectionItemCount:(NSUInteger)section{return [self.sections[self.keys[section]] count];}
- (id)getItemInSection:(NSUInteger)section atRow:(NSUInteger)row{return self.sections[self.keys[section]][row];}
- (NSArray *)getAllContacts{NSMutableArray *a=[NSMutableArray array];for(id k in self.keys)[a addObjectsFromArray:self.sections[k]];return a;}
- (NSArray *)getFilteredContacts{return self.filtered;}
- (void)doSearch:(NSString *)query{self.filtered=[[self getAllContacts] filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(NSString *name,id bindings){return [name containsString:query];}]];}
- (void)reloadMemberList:(id)contacts{self.keys=[@[@"N"] mutableCopy];self.sections=[@{@"N":[contacts mutableCopy]} mutableCopy];}
- (void)addContact:(id)contact{[self.sections[self.keys.lastObject] addObject:contact];}
- (BOOL)removeContact:(id)contact{for(id k in self.keys)[self.sections[k] removeObject:contact];return YES;}
- (void)sortKeys{[self.keys sortUsingSelector:@selector(compare:)];}
@end
@interface Searcher : NSObject
@property(nonatomic,copy) NSArray *arrResult;
@end
@implementation Searcher @end
@interface MemberListViewController : UIViewController
@property(nonatomic,strong) id m_memberData;
@property(nonatomic,strong) Searcher *_searcher;
@property(nonatomic,strong) id selected;
@property(nonatomic) NSUInteger reloads;
- (void)setMemberLogic:(id)logic;- (void)reloadTable;- (void)doSearch:(id)query Pre:(BOOL)prefix;
- (void)tableView:(id)table didSelectRowAtIndexPath:(id)path;- (void)didSearchViewTableSelect:(id)path;- (void)JumpToChatRoom:(id)contact;
@end
@implementation MemberListViewController
- (void)setMemberLogic:(id)logic{self.m_memberData=logic;}
- (void)reloadTable{self.reloads++;((NSUInteger(*)(id,SEL))objc_msgSend)(self.m_memberData,NSSelectorFromString(@"getSectionCount"));}
- (void)doSearch:(id)query Pre:(BOOL)prefix{[self.m_memberData doSearch:query];self._searcher.arrResult=[self.m_memberData getFilteredContacts];}
- (void)tableView:(id)table didSelectRowAtIndexPath:(id)path{[self JumpToChatRoom:[self.m_memberData getItemInSection:[path[0] unsignedIntegerValue] atRow:[path[1] unsignedIntegerValue]]];}
- (void)didSearchViewTableSelect:(id)path{[self JumpToChatRoom:self._searcher.arrResult[[path unsignedIntegerValue]]];}
- (void)JumpToChatRoom:(id)contact{self.selected=contact;}
@end
@interface ChatRoomListViewController : MemberListViewController @end
@implementation ChatRoomListViewController @end
#import "GroupListAdapter.h"
static void GroupTests(void){
    SetPolicy(YES,NO,10);CSCFGroupListInstall();
    MemberDataLogic *raw=[MemberDataLogic new];raw.keys=[@[@"A",@"B"] mutableCopy];raw.sections=[@{@"A":[@[@"secret@chatroom"] mutableCopy],@"B":[@[@"open@chatroom",@"last@chatroom"] mutableCopy]} mutableCopy];
    ChatRoomListViewController *page=[ChatRoomListViewController new];page._searcher=[Searcher new];[page setMemberLogic:raw];CSCFGroupListData *data=page.m_memberData;
    Check([data isKindOfClass:CSCFGroupListData.class],@"only group list receives page-owned presentation wrapper");
    Check([[data getKeyArray] isEqual:@[@"B"]]&&[data getTotalCount]==2,@"hidden group and empty section removed with count");
    Check([data getSectionCount]==1&&[data getSectionItemCount:0]==2&&[[data getItemInSection:0 atRow:1] isEqual:@"last@chatroom"],@"section, count and item use same visible mapping");
    [page tableView:nil didSelectRowAtIndexPath:@[@0,@0]];Check([page.selected isEqual:@"open@chatroom"],@"tap opens the displayed group after section removal");
    [page doSearch:@"@chatroom" Pre:NO];Check(page._searcher.arrResult.count==2&&raw.filtered.count==3,@"page search hides groups without truncating source");
    NSMutableArray *searchCopy=[data getFilteredContacts];[searchCopy removeAllObjects];
    Check(raw.filtered.count==3&&[data getFilteredContacts].count==2,@"native mutable search result contract preserves independent source");
    [page didSearchViewTableSelect:@1];Check([page.selected isEqual:@"last@chatroom"],@"search selection maps to visible result");
    SetPolicy(YES,YES,11);page.selected=nil;[page tableView:nil didSelectRowAtIndexPath:@[@0,@0]];Check(!page.selected,@"policy changes reject a stale tap before refresh");
    [page reloadTable];Check([data getTotalCount]==3&&page._searcher.arrResult.count==3,@"reveal restores list and active search in place");
    SetPolicy(YES,NO,12);[page reloadTable];Check([data getTotalCount]==2&&page._searcher.arrResult.count==2&&raw.keys.count==2,@"relock refilters without removing native groups");
    [data addContact:@"new@chatroom"];Check([data getTotalCount]==3,@"native addition invalidates projection");
    [data removeContact:@"open@chatroom"];Check([data getTotalCount]==2,@"native removal invalidates projection");
    [data reloadMemberList:@[@"secret@chatroom",@"fresh@chatroom"]];Check([data getTotalCount]==1&&[[data getItemInSection:0 atRow:0] isEqual:@"fresh@chatroom"],@"native list replacement rebuilds projection");
    MemberListViewController *other=[MemberListViewController new];[other setMemberLogic:raw];Check(other.m_memberData==raw&&[raw getAllContacts].count==2,@"other native member lists and settings picker data stay intact");
    epoch++;[page reloadTable];Check([data getTotalCount]==0&&page._searcher.arrResult.count==0,@"account epoch invalidates old page results");
}
@interface FTSContactCell : NSObject {
@public View *_displayNameLabel;
}
@property(nonatomic,strong) View *head,*brandHead;
@property(nonatomic,strong) id contact,tip;
@property(nonatomic) BOOL topHit;
- (void)updateContact:(id)contact matchTip:(id)tip asTopHit:(BOOL)topHit;
@end
@implementation FTSContactCell
- (instancetype)init{if((self=[super init])){_displayNameLabel=[View new];_head=[View new];_brandHead=[View new];}return self;}
- (void)updateContact:(id)contact matchTip:(id)tip asTopHit:(BOOL)topHit{
    self.contact=contact;self.tip=tip;self.topHit=topHit;
    BOOL finder=[CSCloseFriendUserName(contact) hasSuffix:@"@finder"];
    self.head.hidden=finder;self.brandHead.hidden=!finder;
    _displayNameLabel.text=CSCloseFriendRead(contact,@"m_nsNickName") ?: @"native generated name";
}
@end
#import "SearchCell.h"
static void SearchCellTests(void){
    SetPolicy(YES,NO,30);InstallNativeSearchCell();
    FTSContactCell *cell=[FTSContactCell new];id tip=@"member-match";
    NSDictionary *group=@{@"m_nsUsrName":@"open@chatroom",@"m_nsNickName":@"公开群名"};
    [cell updateContact:group matchTip:tip asTopHit:YES];
    Check(cell.contact==group&&!cell.tip&&cell.topHit,@"group keeps native contact/top-hit behavior and removes match snippet");
    Check(!cell.head.hidden&&cell.brandHead.hidden&&[cell->_displayNameLabel.text isEqual:@"公开群名"],@"native group head and public title stay visible");
    View *liveHead=cell.head;liveHead.image=@"download-completed";
    Check(cell.head==liveHead&&[cell.head.image isEqual:@"download-completed"],@"async avatar completes on original live view");
    id finder=@{@"m_nsUsrName":@"followed@finder",@"m_nsNickName":@"关注的视频号"};
    [cell updateContact:finder matchTip:tip asTopHit:NO];
    Check(cell.tip==tip&&cell.head.hidden&&!cell.brandHead.hidden&&[cell->_displayNameLabel.text isEqual:@"关注的视频号"],@"group to Finder reuse keeps native brand avatar and match text");
    [cell updateContact:@{@"m_nsUsrName":@"open@chatroom"} matchTip:tip asTopHit:NO];
    Check(!cell.head.hidden&&cell.brandHead.hidden&&[cell->_displayNameLabel.text isEqual:@"群聊"],@"Finder to unnamed group restores native head and suppresses generated member title");
    SetPolicy(YES,YES,31);[cell updateContact:group matchTip:tip asTopHit:NO];Check(cell.tip==tip,@"unlock preserves native match payload");
    SetPolicy(NO,NO,32);[cell updateContact:group matchTip:tip asTopHit:NO];Check(cell.tip==tip,@"disabled feature leaves native search render untouched");
}
int main(void){@autoreleasepool{NavigationTests();GroupTests();SearchCellTests();printf("Close-friend pages: %lu checks passed\n",(unsigned long)checks);}return 0;}
