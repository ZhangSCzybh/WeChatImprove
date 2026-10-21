#import "CSNativeContactPicker.h"
#import "CSGroupNativeBridge.h"
#import <objc/message.h>
static NSUInteger checks, nativeDoneCalls;
static NSString *account=@"me";
static void (^duringDismissal)(void);
static void Check(BOOL ok,NSString *message){checks++;if(!ok){fprintf(stderr,"FAIL: %s\n",message.UTF8String);exit(1);}}
@implementation UIBarButtonItem @end
@implementation UINavigationItem @end
@implementation UIViewController
- (instancetype)init {if((self=[super init])){_navigationItem=[UINavigationItem new];_navigationItem.rightBarButtonItem=[UIBarButtonItem new];}return self;}
- (void)viewDidLoad {}
- (void)presentViewController:(UIViewController *)controller animated:(BOOL)animated completion:(void(^)(void))completion {
    self.presentedViewController=controller;controller.presentingViewController=self;
    [[(UINavigationController *)controller topViewController] viewDidLoad];if(completion)completion();
}
- (void)dismissViewControllerAnimated:(BOOL)animated completion:(void(^)(void))completion {
    self.presentingViewController.presentedViewController=nil;
    if(duringDismissal)duringDismissal();if(completion)completion();
}
@end
@implementation UINavigationController
- (instancetype)initWithRootViewController:(UIViewController *)root {if((self=[super init])){self.topViewController=root;root.navigationController=self;}return self;}
@end
@interface MMUINavigationController : UINavigationController @end
@implementation MMUINavigationController @end
@interface CContact : NSObject
@property(nonatomic,copy) NSString *m_nsUsrName;
@end
@implementation CContact @end
static CContact *Contact(NSString *name){CContact *c=[CContact new];c.m_nsUsrName=name;return c;}
@interface CContactMgr : NSObject
- (id)getContactByName:(NSString *)name;
@end
@implementation CContactMgr
- (id)getContactByName:(NSString *)name{return [name hasPrefix:@"missing"]?nil:Contact(name);}
@end
id CSGetService(Class cls){return [cls new];}
NSString *CSGroupCurrentAccountID(void){return account;}
id CSGroupReadObject(id object,NSString *key){return [object valueForKey:key];}
CSGroupRowCategory CSGroupCategoryForContact(id contact){return [[contact m_nsUsrName] hasPrefix:@"gh_"]?CSGroupRowCategoryService:CSGroupRowCategoryPrivate;}

@interface ContactSelectView : NSObject
@property(nonatomic,strong) NSMutableDictionary *m_dicMultiSelect;
@end
@implementation ContactSelectView @end
@interface MultiSelectContactsViewController : UIViewController
@property(nonatomic,weak) id m_delegate;
@property(nonatomic,strong) NSMutableDictionary *m_dicMultiSelect;
@property(nonatomic,strong) ContactSelectView *m_selectView;
@property(nonatomic,copy) NSString *m_viewcontrllerTitle,*m_rightBarButtonTitle;
@property(nonatomic) BOOL m_bShowHistoryGroup,m_bShowRadarCreateRoom,hideSelfContact;
- (void)initData;
- (void)actionDone;
- (void)onDone:(id)sender;
- (void)actionCancel;
- (void)onCancel:(id)sender;
- (void)updateRightBarItemEnabled:(BOOL)enabled;
@end
@implementation MultiSelectContactsViewController
- (void)initData {}
- (void)viewDidLoad {[self initData];self.m_selectView=[ContactSelectView new];self.m_selectView.m_dicMultiSelect=[self.m_dicMultiSelect mutableCopy];[self updateRightBarItemEnabled:NO];}
- (void)actionDone {nativeDoneCalls++;}
- (void)onDone:(id)sender {[self actionDone];}
- (void)actionCancel {nativeDoneCalls++;}
- (void)onCancel:(id)sender {[self actionCancel];}
- (void)updateRightBarItemEnabled:(BOOL)enabled {self.navigationItem.rightBarButtonItem.enabled=enabled;}
@end
@interface GroupSelectContactsViewController : UIViewController
@property(nonatomic,weak) id m_delegate;
@property(nonatomic,strong) NSMutableDictionary *m_dicMultiSelect;
@property(nonatomic,copy) NSString *m_viewControllerTitle,*m_rightBarButtonTitle;
@property(nonatomic) BOOL m_bShowSearchBar;
@property(nonatomic) unsigned int m_uiDataScene;
- (void)initData;
- (void)actionDone;
- (void)onDone;
- (void)onCancelBack:(id)sender;
- (void)updateRightBarBtn;
@end
@implementation GroupSelectContactsViewController
- (void)initData {self.m_dicMultiSelect=[NSMutableDictionary dictionary];}
- (void)viewDidLoad {[self initData];[self updateRightBarBtn];}
- (void)actionDone {nativeDoneCalls++;}
- (void)onDone {[self actionDone];}
- (void)onCancelBack:(id)sender {nativeDoneCalls++;}
- (void)updateRightBarBtn {self.navigationItem.rightBarButtonItem.enabled=self.m_dicMultiSelect.count>0;}
@end
static UIViewController *Picker(UIViewController *presenter){return [(UINavigationController *)presenter.presentedViewController topViewController];}
int main(void){@autoreleasepool{
    UIViewController *presenter=[UIViewController new];NSError *error=nil;
    __block NSUInteger saves=0;__block NSArray *saved=nil;__block BOOL valid=YES;
    void (^save)(NSArray *)=^(NSArray *names){Check(presenter.presentedViewController==nil,@"save occurs after dismissal");saves++;saved=names;};
    Check(CSNativeContactPickerPresent(presenter,@"密友",NO,@[@"alice",@"bob"],^BOOL{return valid;},save,&error),@"friend picker opens");
    MultiSelectContactsViewController *friends=(id)Picker(presenter);
    Check([friends isKindOfClass:MultiSelectContactsViewController.class]&&friends.hideSelfContact&&!friends.m_bShowHistoryGroup,@"real native friend class is configured");
    Check(friends.m_dicMultiSelect.count==2&&friends.m_dicMultiSelect[@"alice"],@"preselection survives native initialization");
    [friends.m_selectView.m_dicMultiSelect removeObjectForKey:@"bob"];friends.m_selectView.m_dicMultiSelect[@"carol"]=Contact(@"carol");
    [friends initData];Check(friends.m_selectView.m_dicMultiSelect.count==2&&friends.m_selectView.m_dicMultiSelect[@"carol"],@"native reinitialization preserves current edits");
    [friends onDone:nil];[friends actionDone];
    Check(saves==1&&[saved isEqual:@[@"alice",@"carol"]],@"live search/tag selection wins over initial seed and commits exactly once");
    Check(CSNativeContactPickerPresent(presenter,@"密友",NO,@[@"alice"],nil,save,&error),@"reopen friends");
    friends=(id)Picker(presenter);[friends.m_selectView.m_dicMultiSelect removeAllObjects];[friends updateRightBarItemEnabled:NO];
    Check(friends.navigationItem.rightBarButtonItem.enabled,@"friend Done permits clearing the last entry");
    [friends onDone:nil];Check(saved.count==0&&saves==2,@"empty friend list is saved");
    Check(CSNativeContactPickerPresent(presenter,@"群",YES,@[@"room@chatroom"],nil,save,&error),@"group picker opens");
    GroupSelectContactsViewController *groups=(id)Picker(presenter);
    Check([groups isKindOfClass:GroupSelectContactsViewController.class]&&groups.m_bShowSearchBar&&groups.m_uiDataScene==5,@"native group search/list is configured");
    Check(groups.m_dicMultiSelect[@"room@chatroom"]!=nil,@"group preselection survives native reset");
    [groups.m_dicMultiSelect removeAllObjects];[groups updateRightBarBtn];
    Check(groups.navigationItem.rightBarButtonItem.enabled,@"group Done permits an empty list");[groups onDone];
    Check(saved.count==0&&saves==3,@"empty group list is saved");
    CSNativeContactPickerPresent(presenter,@"群",YES,@[@"room@chatroom"],nil,save,&error);
    groups=(id)Picker(presenter);[groups.m_dicMultiSelect removeAllObjects];[groups onCancelBack:nil];[groups onDone];
    Check(saves==3&&!presenter.presentedViewController,@"cancel dismisses without writing or accepting a late Done");
    CSNativeContactPickerPresent(presenter,@"密友",NO,@[@"alice"],^BOOL{return valid;},save,&error);
    friends=(id)Picker(presenter);valid=NO;CSNativeContactPickerRevalidate(presenter);[friends actionDone];
    Check(saves==3&&!presenter.presentedViewController,@"expired unlock cancels and cannot save late");valid=YES;
    CSNativeContactPickerPresent(presenter,@"群",YES,@[],nil,save,&error);groups=(id)Picker(presenter);
    account=@"another";[groups onDone];Check(saves==3,@"account switch rejects save");account=@"me";
    CSNativeContactPickerPresent(presenter,@"密友",NO,@[@"alice"],^BOOL{return valid;},save,&error);friends=(id)Picker(presenter);
    duringDismissal=^{valid=NO;};[friends onDone:nil];duringDismissal=nil;valid=YES;
    Check(saves==3,@"authorization is rechecked after dismissal animation");
    CSNativeContactPickerPresent(presenter,@"群",YES,@[@"missing@chatroom"],nil,save,&error);groups=(id)Picker(presenter);
    groups.m_dicMultiSelect[@"wrong"]=Contact(@"ordinary-friend");groups.m_dicMultiSelect[@"next@chatroom"]=Contact(@"next@chatroom");[groups onDone];
    Check([saved isEqual:@[@"missing@chatroom",@"next@chatroom"]],@"unresolvable old entries are preserved and wrong recipient categories rejected");
    NSUInteger previous=saves;CSNativeContactPickerPresent(presenter,@"密友",NO,@[],nil,save,&error);friends=(id)Picker(presenter);friends.m_selectView.m_dicMultiSelect=nil;[friends onDone:nil];
    Check(saves==previous,@"missing native result never clears stored names");
    Check(nativeDoneCalls==0,@"settings Done/Cancel never invokes native send/create-group actions");
    printf("Native contact picker: %lu checks passed\n",(unsigned long)checks);
}return 0;}
