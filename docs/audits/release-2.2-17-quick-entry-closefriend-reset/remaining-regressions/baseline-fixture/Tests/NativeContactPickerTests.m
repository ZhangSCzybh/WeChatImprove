#import "CSNativeContactPicker.h"
#import "CSGroupNativeBridge.h"
#import <objc/message.h>
#import <objc/runtime.h>
static NSUInteger checks, nativeDoneCalls;
static NSUInteger groupInitCalls, groupButtonCalls, friendButtonCalls, friendPanelCalls;
static BOOL wrapPickerBeforeLoad, useBottomToolView;
static NSUInteger toolDoneCalls;
static NSString *account=@"me";
static void (^duringDismissal)(void);
static BOOL requireVisiblePresentation, deferSheetDismissal;
static NSUInteger invalidPresentations;
static NSMutableArray *dismissReceivers;
static void (^pendingSheetDismissal)(void);
static BOOL deferPickerPresentation;
static void (^pendingPickerPresentation)(void);
static NSUInteger nativeTagEntrances;
static void DetachPresentation(UIViewController *controller) {
    controller.presentingViewController.presentedViewController=nil;
    controller.presentingViewController=nil; controller.view.window=nil; controller.isBeingDismissed=NO;
    if ([controller isKindOfClass:UINavigationController.class]) [(UINavigationController *)controller topViewController].view.window=nil;
}
static void Check(BOOL ok,NSString *message){checks++;if(!ok){fprintf(stderr,"FAIL: %s\n",message.UTF8String);exit(1);}}
@implementation UIView @end
@implementation UIControl @end
@implementation UIButton @end
@implementation UIBarButtonItem @end
@implementation UINavigationItem @end
@implementation UISheetPresentationController @end
@implementation UISheetPresentationControllerDetent
+ (instancetype)mediumDetent { return [self new]; }
+ (instancetype)largeDetent { return [self new]; }
@end
@implementation UIViewController
- (instancetype)init {if((self=[super init])){_view=[UIView new];_navigationItem=[UINavigationItem new];_navigationItem.rightBarButtonItem=[UIBarButtonItem new];}return self;}
- (void)viewDidLoad {}
- (void)presentViewController:(UIViewController *)controller animated:(BOOL)animated completion:(void(^)(void))completion {
    if(requireVisiblePresentation && (!self.view.window || self.presentedViewController || self.isBeingDismissed)) { invalidPresentations++; return; }
    self.presentedViewController=controller;controller.presentingViewController=self;
    controller.view.window=self.view.window;
    if([controller isKindOfClass:UINavigationController.class]) {
        UIViewController *top=[(UINavigationController *)controller topViewController];top.view.window=controller.view.window;[top loadViewIfNeeded];
    }
    if(deferPickerPresentation && [controller isKindOfClass:UINavigationController.class]) pendingPickerPresentation=[completion copy];
    else if(completion)completion();
}
- (void)loadViewIfNeeded {
    if(self.isViewLoaded)return;
    // UIKit appearance tagging can insert a runtime subclass just before viewDidLoad.
    if(wrapPickerBeforeLoad && [NSStringFromClass(object_getClass(self)) hasPrefix:@"CSNativeSettings"]) {
        Class base=object_getClass(self);NSString *name=[@"Appearance_" stringByAppendingString:NSStringFromClass(base)];
        Class wrapper=NSClassFromString(name);
        if(!wrapper){wrapper=objc_allocateClassPair(base,name.UTF8String,0);objc_registerClassPair(wrapper);}
        object_setClass(self,wrapper);
    }
    self.isViewLoaded=YES;[self viewDidLoad];
}
- (void)dismissViewControllerAnimated:(BOOL)animated completion:(void(^)(void))completion {
    [dismissReceivers addObject:self];
    // UIKit forwards a child's dismiss to its containing modal when the alert
    // has already gone. The old stub only cleared self.presenting and missed it.
    UIViewController *owner=self;
    while(owner && !owner.presentedViewController && !owner.presentingViewController) owner=owner.parentViewController;
    UIViewController *target=owner.presentedViewController?:owner;
    void (^done)(void)=^{ if(target.presentingViewController)DetachPresentation(target);if(duringDismissal)duringDismissal();if(completion)completion(); };
    if(deferSheetDismissal && [target isKindOfClass:UIAlertController.class]) { target.isBeingDismissed=YES;pendingSheetDismissal=done; }
    else done();
}
@end
@implementation UINavigationController
- (instancetype)initWithRootViewController:(UIViewController *)root {if((self=[super init])){self.viewControllers=@[root];self.topViewController=root;root.navigationController=self;root.parentViewController=self;}return self;}
- (void)pushViewController:(UIViewController *)controller animated:(BOOL)animated {
    self.viewControllers=[self.viewControllers arrayByAddingObject:controller];self.topViewController=controller;
    controller.navigationController=self;controller.parentViewController=self;controller.view.window=self.view.window;
}
@end
@implementation UIAlertAction
+ (instancetype)actionWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void (^)(UIAlertAction *))handler { UIAlertAction *a=[self new];a.title=title;a.handler=handler;return a; }
@end
@implementation UIAlertController
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)style { UIAlertController *a=[self new];a.title=title;a.actions=[NSMutableArray array];return a; }
- (void)addAction:(UIAlertAction *)action { [self.actions addObject:action]; }
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
@interface ContactSelectToolView : UIView
@property(nonatomic,strong) UIButton *completeButton;
@property(nonatomic,copy) void (^completeHandler)(id);
- (void)updateWithCompleteBarButtonItem:(UIBarButtonItem *)item;
- (void)onDone:(id)sender;
@end
@implementation ContactSelectToolView
- (void)updateWithCompleteBarButtonItem:(UIBarButtonItem *)item {
    // Native tool view takes the button from the item's custom view and
    // redirects touch-up to its completeHandler; it has no navigation item.
    self.completeButton=(UIButton *)item.customView;
    self.completeButton.target=self;self.completeButton.action=@selector(onDone:);
}
- (void)onDone:(id)sender {toolDoneCalls++;if(self.completeHandler)self.completeHandler(sender);}
@end
@interface NSObject (PickerSelectionDelegate)
- (BOOL)onShouldSelectContact:(id)contact;
- (void)contactTagListViewController:(id)controller didSelectContactTag:(NSArray *)contacts;
@end
// Native tag callback selects contacts into the friend's live ContactSelectView.
// No tag-management or plugin-owned list implementation participates in this fixture.
@interface ContactTagListViewController : UIViewController
@property(nonatomic,weak) id delegate;
- (void)selectTagContacts:(NSArray *)contacts;
@end
@implementation ContactTagListViewController
- (void)selectTagContacts:(NSArray *)contacts {
    [self.delegate contactTagListViewController:self didSelectContactTag:contacts];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
@end
@interface MultiSelectContactsViewController : UIViewController
@property(nonatomic,weak) id m_delegate;
@property(nonatomic,strong) NSMutableDictionary *m_dicMultiSelect;
@property(nonatomic,strong) ContactSelectView *m_selectView;
@property(nonatomic,strong) ContactSelectToolView *m_toolView;
@property(nonatomic,strong) UIBarButtonItem *m_panelBtnItem;
@property(nonatomic,strong) UIButton *m_panelBtn;
@property(nonatomic,copy) NSString *m_viewcontrllerTitle,*m_rightBarButtonTitle;
@property(nonatomic) BOOL m_bShowHistoryGroup,m_bShowRadarCreateRoom,hideSelfContact,m_bShowContactTag;
- (void)initData;
- (void)actionDone;
- (void)onDone:(id)sender;
- (void)actionCancel;
- (void)onCancel:(id)sender;
- (void)updateRightBarItemEnabled:(BOOL)enabled;
- (void)updatePanelBtn;
- (void)selectContact:(CContact *)contact;
- (void)onSelectContactTag;
@end
@implementation MultiSelectContactsViewController
- (void)initData {}
- (void)viewDidLoad {
    [self initData];self.m_selectView=[ContactSelectView new];self.m_selectView.m_dicMultiSelect=[self.m_dicMultiSelect mutableCopy];
    if(useBottomToolView) {
        self.m_toolView=[ContactSelectToolView new];
        __weak typeof(self) weakSelf=self;
        self.m_toolView.completeHandler=^(id sender){[weakSelf onDone:sender];};
    }
    [self updatePanelBtn];
}
- (void)actionDone {nativeDoneCalls++;}
- (void)onDone:(id)sender {[self actionDone];}
- (void)actionCancel {nativeDoneCalls++;}
- (void)onCancel:(id)sender {[self actionCancel];}
- (void)updateRightBarItemEnabled:(BOOL)enabled {friendButtonCalls++;self.navigationItem.rightBarButtonItem.enabled=enabled;}
- (void)updatePanelBtn {
    friendPanelCalls++;
    // Native updatePanelBtn rebuilds the item and sets enabled directly,
    // bypassing updateRightBarItemEnabled: in the default picker scene.
    NSUInteger count=self.m_selectView.m_dicMultiSelect.count;
    UIBarButtonItem *button=[UIBarButtonItem new];button.target=self;button.action=@selector(onDone:);
    button.title=count ? [NSString stringWithFormat:@"%@(%lu)",self.m_rightBarButtonTitle,(unsigned long)count] : self.m_rightBarButtonTitle;
    button.enabled=count>0;
    UIButton *control=[UIButton new];control.enabled=button.enabled;control.title=button.title;
    button.customView=control;self.m_panelBtnItem=button;self.m_panelBtn=control;
    if(self.m_toolView) {
        self.navigationItem.rightBarButtonItem=nil;
        [self.m_toolView updateWithCompleteBarButtonItem:button];
    } else self.navigationItem.rightBarButtonItem=button;
}
- (void)selectContact:(CContact *)contact {
    NSMutableDictionary *selected=self.m_selectView.m_dicMultiSelect;
    if(selected[contact.m_nsUsrName])[selected removeObjectForKey:contact.m_nsUsrName];
    else if([self.m_delegate onShouldSelectContact:contact])selected[contact.m_nsUsrName]=contact;
    [self updatePanelBtn];
}
- (void)onSelectContactTag {
    nativeTagEntrances++;
    Check(self.m_bShowContactTag && self.isViewLoaded && self.m_selectView!=nil && self.view.window!=nil,@"native tag entry waits until the native friend's presentation completes");
    ContactTagListViewController *tags=[ContactTagListViewController new];tags.delegate=self;
    [self presentViewController:[[MMUINavigationController alloc] initWithRootViewController:tags] animated:YES completion:nil];
}
- (void)contactTagListViewController:(id)controller didSelectContactTag:(NSArray *)contacts {
    for(CContact *contact in contacts) self.m_selectView.m_dicMultiSelect[contact.m_nsUsrName]=contact;
    [self updatePanelBtn];
}
@end
@protocol TestGroupPickerDelegate <NSObject>
@optional
- (BOOL)onShouldSelectContact:(CContact *)contact;
- (void)onGroupSelectContactReturn:(CContact *)contact;
@end
@interface GroupSelectContactsViewController : UIViewController
@property(nonatomic,weak) id<TestGroupPickerDelegate> m_delegate;
@property(nonatomic,strong) NSMutableDictionary *m_dicMultiSelect;
@property(nonatomic,copy) NSString *m_viewControllerTitle,*m_rightBarButtonTitle;
@property(nonatomic) BOOL m_bShowSearchBar;
@property(nonatomic) unsigned int m_uiDataScene;
- (void)initData;
- (void)actionDone;
- (void)onDone;
- (void)onCancelBack:(id)sender;
- (void)updateRightBarBtn;
- (BOOL)isSelected:(CContact *)contact;
- (void)selectContact:(CContact *)contact;
@end
@implementation GroupSelectContactsViewController
- (void)initData {groupInitCalls++;self.m_dicMultiSelect=[NSMutableDictionary dictionary];}
- (void)viewDidLoad {[self initData];[self updateRightBarBtn];}
- (void)actionDone {nativeDoneCalls++;}
- (void)onDone {[self actionDone];}
- (void)onCancelBack:(id)sender {nativeDoneCalls++;}
- (void)updateRightBarBtn {
    groupButtonCalls++;
    if(!self.m_rightBarButtonTitle.length)return;
    UIBarButtonItem *button=[UIBarButtonItem new];button.target=self;button.action=@selector(onDone);
    button.title=self.m_dicMultiSelect.count ? [NSString stringWithFormat:@"%@(%lu)",self.m_rightBarButtonTitle,(unsigned long)self.m_dicMultiSelect.count] : self.m_rightBarButtonTitle;
    button.enabled=self.m_dicMultiSelect.count>0;self.navigationItem.rightBarButtonItem=button;
}
- (BOOL)isSelected:(CContact *)contact {return self.m_dicMultiSelect[contact.m_nsUsrName]!=nil;}
- (void)selectContact:(CContact *)contact {
    // WeChat 8.0.78 selectContact: at 0x101ecda98: only scene 4 toggles
    // the dictionary. Other scenes dispatch a single-contact delegate callback.
    if(self.m_uiDataScene!=4) {
        if([self.m_delegate respondsToSelector:@selector(onGroupSelectContactReturn:)])[self.m_delegate onGroupSelectContactReturn:contact];
        return;
    }
    if([self isSelected:contact])[self.m_dicMultiSelect removeObjectForKey:contact.m_nsUsrName];
    else if(![self.m_delegate respondsToSelector:@selector(onShouldSelectContact:)] || [self.m_delegate onShouldSelectContact:contact])
        self.m_dicMultiSelect[contact.m_nsUsrName]=contact;
    [self updateRightBarBtn];
}
@end
static UIViewController *Picker(UIViewController *presenter){return [(UINavigationController *)presenter.presentedViewController topViewController];}
static void TapFriendDone(MultiSelectContactsViewController *picker) {
    if(picker.m_toolView) {
        UIButton *button=picker.m_toolView.completeButton;
        Check(button.enabled&&button.target==picker.m_toolView&&[button.target respondsToSelector:button.action],@"bottom Done keeps its enabled native tool-view action");
        ((void(*)(id,SEL,id))objc_msgSend)(button.target,button.action,button);
        return;
    }
    UIBarButtonItem *button=picker.navigationItem.rightBarButtonItem;
    Check(button.enabled&&button.target==picker&&[button.target respondsToSelector:button.action],@"friend native Done has an enabled action and target");
    ((void(*)(id,SEL,id))objc_msgSend)(button.target,button.action,button);
}
static void TapGroupDone(GroupSelectContactsViewController *picker) {
    UIBarButtonItem *button=picker.navigationItem.rightBarButtonItem;
    Check(button.enabled&&button.target==picker&&[button.target respondsToSelector:button.action],@"native Done button has an enabled action and target");
    ((void(*)(id,SEL))objc_msgSend)(button.target,button.action);
}
#import "ScheduledTaskPickerPresentationTests.h"
#import "GroupPickerPresentationTests.h"
int main(void){@autoreleasepool{
    if(getenv("CS_TEST_GROUP_PICKER")) { TestGroupPickerPresentation();printf("Group picker presentation: %lu checks passed\n",(unsigned long)checks);return 0; }
    if(getenv("CS_TEST_SCHEDULED_PICKER")) { TestScheduledPickerPresentation();printf("Scheduled picker presentation: %lu checks passed\n",(unsigned long)checks);return 0; }
    UIViewController *presenter=[UIViewController new];NSError *error=nil;
    __block NSUInteger saves=0;__block NSArray *saved=nil;__block BOOL valid=YES;
    void (^save)(NSArray *)=^(NSArray *names){Check(presenter.presentedViewController==nil,@"save occurs after dismissal");saves++;saved=names;};
    Check(CSNativeContactPickerPresent(presenter,@"密友",NO,@[@"alice",@"bob"],^BOOL{return valid;},save,&error),@"friend picker opens");
    MultiSelectContactsViewController *friends=(id)Picker(presenter);
    Check([friends isKindOfClass:MultiSelectContactsViewController.class]&&friends.hideSelfContact&&!friends.m_bShowHistoryGroup,@"real native friend class is configured");
    Check(friends.m_dicMultiSelect.count==2&&friends.m_dicMultiSelect[@"alice"],@"preselection survives native initialization");
    [friends.m_selectView.m_dicMultiSelect removeObjectForKey:@"bob"];friends.m_selectView.m_dicMultiSelect[@"carol"]=Contact(@"carol");
    [friends initData];Check(friends.m_selectView.m_dicMultiSelect.count==2&&friends.m_selectView.m_dicMultiSelect[@"carol"],@"native reinitialization preserves current edits");
    [friends updatePanelBtn];
    Check([friends.navigationItem.rightBarButtonItem.title isEqual:@"完成(2)"],@"friend native count title is preserved after live edits");
    TapFriendDone(friends);[friends actionDone];
    Check(saves==1&&[saved isEqual:@[@"alice",@"carol"]],@"live search/tag selection wins over initial seed and commits exactly once");
    Check(CSNativeContactPickerPresent(presenter,@"密友",NO,@[@"alice"],nil,save,&error),@"reopen friends");
    friends=(id)Picker(presenter);[friends.m_selectView.m_dicMultiSelect removeAllObjects];[friends updatePanelBtn];
    Check(friends.navigationItem.rightBarButtonItem.enabled,@"friend Done permits clearing the last entry");
    TapFriendDone(friends);Check(saved.count==0&&saves==2,@"empty friend list is saved");
    Check(CSNativeContactPickerPresent(presenter,@"群",YES,@[@"room@chatroom"],nil,save,&error),@"group picker opens");
    GroupSelectContactsViewController *groups=(id)Picker(presenter);
    Check([groups isKindOfClass:GroupSelectContactsViewController.class]&&groups.m_bShowSearchBar,@"native group search/list is configured");
    Check(groups.m_dicMultiSelect[@"room@chatroom"]!=nil,@"group preselection survives native reset");
    [groups.m_dicMultiSelect removeAllObjects];[groups updateRightBarBtn];
    Check(groups.navigationItem.rightBarButtonItem.enabled,@"group Done permits an empty list");[groups onDone];
    Check(saved.count==0&&saves==3,@"empty group list is saved");
    CSNativeContactPickerPresent(presenter,@"群",YES,@[@"room@chatroom"],nil,save,&error);
    groups=(id)Picker(presenter);[groups.m_dicMultiSelect removeAllObjects];[groups onCancelBack:nil];[groups onDone];
    Check(saves==3&&!presenter.presentedViewController,@"cancel dismisses without writing or accepting a late Done");
    CSNativeContactPickerPresent(presenter,@"密友",NO,@[@"alice"],^BOOL{return valid;},save,&error);
    friends=(id)Picker(presenter);valid=NO;CSNativeContactPickerRevalidate(presenter);
    Check(Picker(presenter)==friends && friends.view.hidden && !friends.navigationItem.rightBarButtonItem.enabled,@"relock conceals invalid picker in place, retaining native cancel");
    valid=YES;[friends updateRightBarItemEnabled:YES];
    Check(!friends.navigationItem.rightBarButtonItem.enabled,@"retired picker cannot re-enable Done after later unlock");
    [friends updatePanelBtn];
    Check(!friends.navigationItem.rightBarButtonItem.enabled,@"native item replacement cannot re-enable a revoked picker");
    [friends actionDone];
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
    wrapPickerBeforeLoad=YES;
    NSUInteger initializations=groupInitCalls,updates=groupButtonCalls;
    Check(CSNativeContactPickerPresent(presenter,@"密友群聊",YES,@[@"room@chatroom"],nil,save,&error),@"group picker opens with appearance runtime subclass");
    groups=(id)Picker(presenter);
    Check(groupInitCalls==initializations+1&&groupButtonCalls==updates+1,@"runtime wrapper forwards each native group method exactly once");
    [groups.m_dicMultiSelect removeAllObjects];groups.m_dicMultiSelect[@"changed@chatroom"]=Contact(@"changed@chatroom");
    [groups initData];[groups updateRightBarBtn];
    Check(groupInitCalls==initializations+2&&groupButtonCalls==updates+2&&groups.m_dicMultiSelect[@"changed@chatroom"],@"wrapped reinitialization preserves live selection without recursion");
    [groups onDone];Check([saved isEqual:@[@"changed@chatroom"]],@"wrapped group picker completes normally");
    updates=friendButtonCalls;
    Check(CSNativeContactPickerPresent(presenter,@"密友名单",NO,@[],nil,save,&error),@"friend picker opens with appearance runtime subclass");
    friends=(id)Picker(presenter);[friends updateRightBarItemEnabled:NO];
    Check(friendButtonCalls==updates+2&&friends.navigationItem.rightBarButtonItem.enabled,@"wrapped friend button forwards once and allows empty list");
    [friends actionCancel];
    for(NSString *title in @[@"密友群聊",@"白名单群",@"黑名单群"]) {
        previous=saves;initializations=groupInitCalls;updates=groupButtonCalls;
        Check(CSNativeContactPickerPresent(presenter,title,YES,@[@"room@chatroom"],nil,save,&error),[title stringByAppendingString:@" opens the shared native group picker"]);
        groups=(id)Picker(presenter);
        Check([groups.title isEqual:title]&&groupInitCalls==initializations+1&&groupButtonCalls==updates+1&&[groups isSelected:Contact(@"room@chatroom")],@"group picker loads once with its existing selection");
        [groups selectContact:Contact(@"second@chatroom")];
        Check([groups isSelected:Contact(@"second@chatroom")]&&[groups.navigationItem.rightBarButtonItem.title isEqual:@"完成(2)"],@"tapping a group checks it and updates the native Done count");
        [groups selectContact:Contact(@"room@chatroom")];
        Check(![groups isSelected:Contact(@"room@chatroom")]&&[groups.navigationItem.rightBarButtonItem.title isEqual:@"完成(1)"],@"tapping a preselected group unchecks it");
        [groups selectContact:Contact(@"ordinary-friend")];
        Check(groups.m_dicMultiSelect.count==1,@"native selection delegate rejects a non-group candidate");
        TapGroupDone(groups);
        Check(saves==previous+1&&[saved isEqual:@[@"second@chatroom"]]&&!presenter.presentedViewController,@"native Done saves the tapped group and dismisses");
        CSNativeContactPickerPresent(presenter,title,YES,saved,nil,save,&error);
        groups=(id)Picker(presenter);[groups selectContact:Contact(@"second@chatroom")];
        Check(groups.m_dicMultiSelect.count==0&&groups.navigationItem.rightBarButtonItem.enabled,@"last group can be unchecked while Done stays enabled");
        TapGroupDone(groups);
        Check(saves==previous+2&&saved.count==0,@"empty group selection saves through the native button");
        CSNativeContactPickerPresent(presenter,title,YES,saved,nil,save,&error);
        groups=(id)Picker(presenter);[groups selectContact:Contact(@"cancelled@chatroom")];[groups onCancelBack:nil];
        Check(saves==previous+2&&saved.count==0&&!presenter.presentedViewController,@"cancel after native selection preserves the stored list");
    }
    for(NSNumber *wrapped in @[@NO,@YES]) {
        wrapPickerBeforeLoad=wrapped.boolValue;previous=saves;updates=friendPanelCalls;
        Check(CSNativeContactPickerPresent(presenter,@"密友名单",NO,@[],nil,save,&error),@"initially empty friend picker opens");
        friends=(id)Picker(presenter);
        Check(friendPanelCalls==updates+1&&friends.navigationItem.rightBarButtonItem.enabled,@"initial empty Done is enabled and native initialization runs once");
        [friends updatePanelBtn];
        Check(friendPanelCalls==updates+2&&[friends.navigationItem.rightBarButtonItem.title isEqual:@"完成"],@"repeated native updates and runtime subclassing retain the empty Done title without recursion");
        TapFriendDone(friends);
        Check(saves==previous+1&&saved.count==0&&!presenter.presentedViewController,@"untouched empty friend selection saves through the native button");
    }
    useBottomToolView=YES;
    for(NSNumber *wrapped in @[@NO,@YES]) {
        wrapPickerBeforeLoad=wrapped.boolValue;
        for(NSArray *initial in @[@[],@[@"alice"]]) {
            previous=saves;NSUInteger calls=toolDoneCalls;
            CSNativeContactPickerPresent(presenter,@"密友名单",NO,initial,nil,save,&error);friends=(id)Picker(presenter);
            Check(!friends.navigationItem.rightBarButtonItem&&friends.m_toolView.completeButton,@"screenshot layout has only a bottom Done button");
            Check(friends.m_panelBtnItem.enabled&&friends.m_toolView.completeButton.enabled,@"bottom Done permits an initially empty list");
            Check(friends.m_panelBtnItem.customView==friends.m_toolView.completeButton,@"native toolbar reuses the original custom button");
            UIButton *old=friends.m_toolView.completeButton;
            [friends.m_selectView.m_dicMultiSelect removeAllObjects];[friends updatePanelBtn];
            Check(friends.m_toolView.completeButton!=old&&friends.m_toolView.completeButton.enabled&&[friends.m_toolView.completeButton.title isEqual:@"完成"],@"clearing and rebuilding the native bottom button keeps it enabled");
            TapFriendDone(friends);
            Check(saves==previous+1&&saved.count==0&&toolDoneCalls==calls+1,@"bottom control routes through native completeHandler and saves an empty list once");
            CSNativeContactPickerPresent(presenter,@"密友名单",NO,saved,nil,save,&error);friends=(id)Picker(presenter);
            Check(friends.m_selectView.m_dicMultiSelect.count==0&&friends.m_toolView.completeButton.enabled,@"reopening the saved empty list still enables bottom Done");
            [friends actionCancel];Check(saves==previous+1,@"bottom picker cancel does not save");
        }
    }
    previous=saves;valid=YES;
    CSNativeContactPickerPresent(presenter,@"密友名单",NO,@[@"alice"],^BOOL{return valid;},save,&error);friends=(id)Picker(presenter);
    valid=NO;CSNativeContactPickerRevalidate(presenter);
    Check(!friends.m_panelBtnItem.enabled&&!friends.m_toolView.completeButton.enabled,@"relock immediately disables the internal item and actual bottom control");
    valid=YES;[friends updatePanelBtn];
    Check(!friends.m_toolView.completeButton.enabled,@"native bottom button replacement cannot restore revoked authorization");
    [friends.m_toolView onDone:friends.m_toolView.completeButton];Check(saves==previous,@"late bottom completion cannot write after revocation");
    CSNativeContactPickerPresent(presenter,@"密友名单",NO,@[],nil,save,&error);friends=(id)Picker(presenter);
    account=@"another";[friends updatePanelBtn];
    Check(!friends.m_toolView.completeButton.enabled,@"account change disables bottom Done even without a navigation button");
    [friends.m_toolView onDone:nil];Check(saves==previous,@"bottom completion rejects a changed account");account=@"me";
    Check(nativeDoneCalls==0,@"bottom Done never enters native send or create-group business actions");
    // Scheduled tasks reuse the native lists but require exactly one recipient.
    __block NSUInteger singleSaves=0; __block NSString *singleName=nil;
    void (^saveSingle)(NSString *)=^(NSString *name){
        Check(presenter.presentedViewController==nil,@"single target is returned only after native dismissal");
        singleSaves++;singleName=name;
    };
    for(NSNumber *bottom in @[@NO,@YES]) for(NSNumber *wrapped in @[@NO,@YES]) {
        useBottomToolView=bottom.boolValue;wrapPickerBeforeLoad=wrapped.boolValue;
        NSUInteger before=singleSaves;
        Check(CSNativeContactPickerPresentSingle(presenter,@"选择一个好友",NO,nil,^BOOL{return valid;},saveSingle,&error),@"single native friend picker opens");
        friends=(id)Picker(presenter);
        Check([friends isKindOfClass:MultiSelectContactsViewController.class]&&!friends.m_panelBtnItem.enabled&&!friends.m_panelBtn.enabled,@"single picker uses native friend UI and cannot finish empty");
        [friends actionDone];Check(presenter.presentedViewController!=nil&&singleSaves==before,@"forced empty Done stays open and never changes the target");
        [friends selectContact:Contact(@"alice")];[friends selectContact:Contact(@"bob")];
        Check(friends.m_selectView.m_dicMultiSelect.count==1&&friends.m_selectView.m_dicMultiSelect[@"alice"]&&friends.m_panelBtnItem.enabled,@"single friend selection rejects a second contact");
        [friends selectContact:Contact(@"alice")];[friends selectContact:Contact(@"bob")];
        Check(friends.m_selectView.m_dicMultiSelect.count==1&&friends.m_selectView.m_dicMultiSelect[@"bob"],@"uncheck then select changes the target");
        // Search/tag bulk return can replace the dictionary without the delegate.
        friends.m_selectView.m_dicMultiSelect=[@{@"alice":Contact(@"alice"),@"bob":Contact(@"bob")} mutableCopy];
        [friends updatePanelBtn];[friends actionDone];
        Check(!friends.m_panelBtnItem.enabled&&!friends.m_panelBtn.enabled&&presenter.presentedViewController&&singleSaves==before,@"bulk overflow disables native Done and never silently chooses the first contact");
        [friends selectContact:Contact(@"alice")];TapFriendDone(friends);
        Check(singleSaves==before+1&&[singleName isEqual:@"bob"],@"corrected single result saves once through native Done");
        CSNativeContactPickerPresentSingle(presenter,@"选择一个好友",NO,@"missing-friend",nil,saveSingle,&error);friends=(id)Picker(presenter);
        Check(friends.m_selectView.m_dicMultiSelect.count==0&&!friends.m_panelBtnItem.enabled,@"unresolvable target cannot be invisibly retained as a single selection");
        [friends selectContact:Contact(@"gh_service")];[friends selectContact:Contact(@"me")];[friends selectContact:Contact(@"room@chatroom")];
        Check(friends.m_selectView.m_dicMultiSelect.count==0,@"single private picker rejects service accounts, self and groups");
        [friends actionCancel];Check(singleSaves==before+1,@"cancel preserves the existing scheduled target");
    }
    for(NSNumber *wrapped in @[@NO,@YES]) {
        wrapPickerBeforeLoad=wrapped.boolValue;NSUInteger before=singleSaves;
        Check(CSNativeContactPickerPresentSingle(presenter,@"选择一个群聊",YES,@"room@chatroom",nil,saveSingle,&error),@"single native group picker opens");
        groups=(id)Picker(presenter);
        Check([groups isKindOfClass:GroupSelectContactsViewController.class]&&[groups isSelected:Contact(@"room@chatroom")],@"single group target survives native initialization");
        [groups selectContact:Contact(@"second@chatroom")];Check(groups.m_dicMultiSelect.count==1,@"single group rejects a second group");
        [groups selectContact:Contact(@"room@chatroom")];[groups onDone];
        Check(!groups.navigationItem.rightBarButtonItem.enabled&&presenter.presentedViewController&&singleSaves==before,@"single empty group cannot finish even through direct Done");
        [groups selectContact:Contact(@"second@chatroom")];[groups initData];[groups updateRightBarBtn];TapGroupDone(groups);
        Check(singleSaves==before+1&&[singleName isEqual:@"second@chatroom"],@"single group retains live edits across initialization and saves once");
    }
    NSUInteger before=singleSaves;
    CSNativeContactPickerPresentSingle(presenter,@"选择一个好友",NO,@"alice",^BOOL{return valid;},saveSingle,&error);friends=(id)Picker(presenter);
    valid=NO;CSNativeContactPickerRevalidate(presenter);valid=YES;[friends updatePanelBtn];[friends actionDone];
    Check(friends.view.hidden&&singleSaves==before,@"privacy invalidation revokes the native single picker permanently");
    CSNativeContactPickerPresentSingle(presenter,@"选择一个群聊",YES,@"room@chatroom",nil,saveSingle,&error);groups=(id)Picker(presenter);
    account=@"another";[groups onDone];account=@"me";
    Check(singleSaves==before,@"account change never writes a scheduled target");
    CSNativeContactPickerPresentSingle(presenter,@"选择一个好友",NO,@"alice",^BOOL{return valid;},saveSingle,&error);friends=(id)Picker(presenter);
    duringDismissal=^{valid=NO;};[friends actionDone];duringDismissal=nil;valid=YES;
    Check(singleSaves==before,@"single target validity is rechecked after dismissal");
    Check(nativeDoneCalls==0,@"single target selection never sends a message or creates a group");
    printf("Native contact picker: %lu checks passed\n",(unsigned long)checks);
}return 0;}
