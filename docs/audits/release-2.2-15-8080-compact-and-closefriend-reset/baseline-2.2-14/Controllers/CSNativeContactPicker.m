#import "CSNativeContactPicker.h"
#import "CSCloseFriendSignatures.h"
#import "CSGroupNativeBridge.h"
#import "CSServiceCenter.h"
#import "CSSettingsPresentation.h"
#import <objc/message.h>
#import <objc/runtime.h>

static char PickerStateKey;
@interface CSNativePickerState : NSObject
@property(nonatomic,weak) UIViewController *picker;
@property(nonatomic,copy) NSDictionary *preselected;
@property(nonatomic,copy) NSSet<NSString *> *unavailableNames;
@property(nonatomic,copy) NSString *account;
@property(nonatomic,copy) BOOL (^isValid)(void);
@property(nonatomic,copy) void (^completion)(NSArray<NSString *> *);
@property(nonatomic) BOOL groups, seeded, finished, revoked, singleSelection;
- (BOOL)valid;
- (BOOL)canFinish;
- (void)finish:(BOOL)save;
@end

static BOOL Matches(Class cls, NSString *name, const char *type) {
    return CSCloseFriendMethodMatches(class_getInstanceMethod(cls,NSSelectorFromString(name)),type);
}
static id Get(id object, NSString *name) {
    return Matches([object class],name,"@@:") ? ((id(*)(id,SEL))objc_msgSend)(object,NSSelectorFromString(name)) : nil;
}
static void Set(id object, NSString *name, id value) {
    ((void(*)(id,SEL,id))objc_msgSend)(object,NSSelectorFromString(name),value);
}
static BOOL IsName(NSString *name, BOOL groups) {
    return [name isKindOfClass:NSString.class] && name.length && [name hasSuffix:@"@chatroom"]==groups;
}
static CSNativePickerState *State(id picker) { return objc_getAssociatedObject(picker,&PickerStateKey); }
static id CurrentSelection(id picker) {
    // Native friend Done reads ContactSelectView's live result, not the
    // controller's initial seed (search/tag selection may replace that result).
    id owner=State(picker).groups ? picker : CSGroupReadObject(picker,@"m_selectView");
    return Get(owner,@"m_dicMultiSelect");
}

@implementation CSNativePickerState
- (BOOL)valid {
    return !self.finished && !self.revoked && [self.account isEqual:CSGroupCurrentAccountID()] && (!self.isValid || self.isValid());
}
- (BOOL)acceptsContact:(id)contact {
    NSString *name=Get(contact,@"m_nsUsrName");
    return [self valid] && IsName(name,self.groups) && ![name isEqual:self.account] &&
        (self.groups || CSGroupCategoryForContact(contact)==CSGroupRowCategoryPrivate);
}
- (BOOL)onShouldSelectContact:(id)contact {
    if(![self acceptsContact:contact])return NO;
    if(!self.singleSelection)return YES;
    id selection=CurrentSelection(self.picker);
    if(![selection isKindOfClass:NSDictionary.class])return NO;
    NSString *name=Get(contact,@"m_nsUsrName");
    return [selection count]==0 || selection[name]!=nil;
}
- (BOOL)canFinish {
    if(![self valid])return NO;
    if(!self.singleSelection)return YES;
    id selection=CurrentSelection(self.picker);
    return [selection isKindOfClass:NSDictionary.class] && [selection count]==1 && [self acceptsContact:[selection allValues].firstObject];
}
- (void)finish:(BOOL)save {
    if(self.finished)return;
    BOOL allowed=[self valid];
    // Search/tag bulk selection can bypass a per-contact delegate. Never pick
    // an arbitrary first target, and keep the page open so the user can correct it.
    if(save && allowed && self.singleSelection && ![self canFinish])return;
    id selection=CurrentSelection(self.picker);
    // A missing native result is not an intentional empty selection.
    save=save && allowed && [selection isKindOfClass:NSDictionary.class];
    NSMutableSet *names=[self.unavailableNames mutableCopy];
    if(save)for(id contact in [selection allValues]) {
        NSString *name=Get(contact,@"m_nsUsrName");
        if([self acceptsContact:contact])[names addObject:name];
    }
    NSArray *result=[names.allObjects sortedArrayUsingSelector:@selector(compare:)];
    self.finished=YES;
    void (^completion)(NSArray *)=self.completion; self.completion=nil;
    // Keep state alive through dismissal; account/token changes during animation
    // invalidate the write just as changes while the list is open do.
    [self.picker.navigationController dismissViewControllerAnimated:YES completion:^{
        if(save && [self.account isEqual:CSGroupCurrentAccountID()] && (!self.isValid || self.isValid()))completion(result);
    }];
}
@end

static void PickerDone(id picker, SEL command) { [State(picker) finish:YES]; }
static void PickerDoneWithSender(id picker, SEL command, id sender) { PickerDone(picker,command); }
static void PickerCancel(id picker, SEL command) { [State(picker) finish:NO]; }
static void PickerCancelWithSender(id picker, SEL command, id sender) { PickerCancel(picker,command); }

// Capture the native implementations at registration. UIKit appearance tagging
// can subclass the instance again during view loading; its runtime superclass
// then points to our override, not to the native implementation.
static IMP NativeGroupInitData, NativeGroupUpdateButton, NativeFriendUpdateButton, NativeFriendUpdatePanel;
static void PickerInitData(id picker, SEL command) {
    CSNativePickerState *state=State(picker);
    NSDictionary *selection=state.seeded ? Get(picker,@"m_dicMultiSelect") : state.preselected;
    // GroupSelectContactsViewController.initData creates a new selection dictionary.
    // Seed after that reset, before the native table/search UI is initialized.
    ((void(*)(id,SEL))NativeGroupInitData)(picker,command);
    if(!state)return;
    Set(picker,@"setM_dicMultiSelect:",[selection mutableCopy] ?: [NSMutableDictionary dictionary]);
    state.seeded=YES;
}
static void PickerUpdateGroupButton(UIViewController *picker, SEL command) {
    ((void(*)(id,SEL))NativeGroupUpdateButton)(picker,command);
    picker.navigationItem.rightBarButtonItem.enabled=[State(picker) canFinish]; // Multi-select settings still allow an empty list.
}
static void PickerUpdateFriendButton(id picker, SEL command, BOOL enabled) {
    BOOL allowed=[State(picker) canFinish];
    ((void(*)(id,SEL,BOOL))NativeFriendUpdateButton)(picker,command,allowed);
    // Bottom-toolbar layouts have no navigation right item. WeChat moves the
    // internal item's custom UIButton into ContactSelectToolView and keeps its
    // own completeHandler. Update that actual control as well as the source item.
    id item=Get(picker,@"m_panelBtnItem");
    if([item isKindOfClass:UIBarButtonItem.class])[(UIBarButtonItem *)item setEnabled:allowed];
    id panelButton=Get(picker,@"m_panelBtn");
    if([panelButton isKindOfClass:UIControl.class])[(UIControl *)panelButton setEnabled:allowed];
    id completeButton=Get(CSGroupReadObject(picker,@"m_toolView"),@"completeButton");
    if([completeButton isKindOfClass:UIControl.class])[(UIControl *)completeButton setEnabled:allowed];
}
static void PickerUpdateFriendPanel(id picker, SEL command) {
    ((void(*)(id,SEL))NativeFriendUpdatePanel)(picker,command);
    // Native updatePanelBtn replaces the item and disables empty selections
    // without calling updateRightBarItemEnabled:. Reapply settings authorization
    // after that replacement, preserving the native item, title and action.
    PickerUpdateFriendButton(picker,NSSelectorFromString(@"updateRightBarItemEnabled:"),YES);
}
static BOOL Override(Class cls, Class base, NSString *name, IMP implementation, const char *type) {
    Method method=class_getInstanceMethod(base,NSSelectorFromString(name));
    return CSCloseFriendMethodMatches(method,type) && class_addMethod(cls,NSSelectorFromString(name),implementation,method_getTypeEncoding(method));
}
static BOOL OverrideForwarding(Class cls, Class base, NSString *name, IMP implementation, const char *type, IMP *original) {
    if(!Override(cls,base,name,implementation,type))return NO;
    *original=method_getImplementation(class_getInstanceMethod(base,NSSelectorFromString(name)));
    return YES;
}
static Class PickerClass(BOOL groups) {
    NSString *name=groups?@"CSNativeSettingsGroupPicker":@"CSNativeSettingsFriendPicker";
    Class existing=NSClassFromString(name);if(existing)return existing;
    Class base=NSClassFromString(groups?@"GroupSelectContactsViewController":@"MultiSelectContactsViewController");
    if(![base isSubclassOfClass:UIViewController.class])return Nil;
    NSDictionary *contracts=groups ? @{@"setM_uiDataScene:":@"v@:I",@"setM_bShowSearchBar:":@"v@:B",@"setM_viewControllerTitle:":@"v@:@"} :
        @{@"setM_bShowHistoryGroup:":@"v@:B",@"setM_bShowRadarCreateRoom:":@"v@:B",@"setHideSelfContact:":@"v@:B",@"setM_viewcontrllerTitle:":@"v@:@"};
    for(NSString *selector in contracts)if(!Matches(base,selector,[contracts[selector] UTF8String]))return Nil;
    for(NSString *selector in @[@"setM_delegate:",@"setM_dicMultiSelect:",@"setM_rightBarButtonTitle:"])if(!Matches(base,selector,"v@:@"))return Nil;
    if(!Matches(base,@"m_dicMultiSelect","@@:"))return Nil;
    Class cls=objc_allocateClassPair(base,name.UTF8String,0);if(!cls)return Nil;
    BOOL ok=Override(cls,base,@"actionDone",(IMP)PickerDone,"v@:");
    if(groups)ok=ok && OverrideForwarding(cls,base,@"initData",(IMP)PickerInitData,"v@:",&NativeGroupInitData) &&
        Override(cls,base,@"onDone",(IMP)PickerDone,"v@:") &&
        Override(cls,base,@"onCancelBack:",(IMP)PickerCancelWithSender,"v@:@") &&
        OverrideForwarding(cls,base,@"updateRightBarBtn",(IMP)PickerUpdateGroupButton,"v@:",&NativeGroupUpdateButton);
    else ok=ok && Override(cls,base,@"onDone:",(IMP)PickerDoneWithSender,"v@:@") &&
        Override(cls,base,@"actionCancel",(IMP)PickerCancel,"v@:") &&
        Override(cls,base,@"onCancel:",(IMP)PickerCancelWithSender,"v@:@") &&
        OverrideForwarding(cls,base,@"updateRightBarItemEnabled:",(IMP)PickerUpdateFriendButton,"v@:B",&NativeFriendUpdateButton) &&
        OverrideForwarding(cls,base,@"updatePanelBtn",(IMP)PickerUpdateFriendPanel,"v@:",&NativeFriendUpdatePanel);
    if(!ok){objc_disposeClassPair(cls);return Nil;}
    objc_registerClassPair(cls);return cls;
}
static BOOL PickerError(NSError **error) {
    if(error)*error=[NSError errorWithDomain:@"CSNativeContactPicker" code:1 userInfo:@{NSLocalizedDescriptionKey:@"当前无法打开微信原生选择器，请返回后重试。原有名单已保留。"}];
    return NO;
}
static BOOL PresentPicker(UIViewController *presenter, NSString *title, BOOL groups, BOOL singleSelection, BOOL tags, NSArray<NSString *> *selectedNames,
    BOOL (^isValid)(void), void (^completion)(NSArray<NSString *> *), NSError **error) {
    if(!NSThread.isMainThread || presenter.presentedViewController || !completion || (isValid && !isValid()))return PickerError(error);
    Class cls=PickerClass(groups),navClass=NSClassFromString(@"MMUINavigationController");
    NSString *account=CSGroupCurrentAccountID();
    id manager=CSGetService(NSClassFromString(@"CContactMgr"));
    if(!cls || ![navClass isSubclassOfClass:UINavigationController.class] || !account.length || !manager)return PickerError(error);
    // Verified in 8.0.78: the native friend controller owns the tag-list delegate,
    // scenes and bulk selection. Do not invent tagName/scenes for this class.
    if(tags && (!Matches(cls,@"setM_bShowContactTag:","v@:B") || !Matches(cls,@"onSelectContactTag","v@:") ||
        ![NSClassFromString(@"ContactTagListViewController") isSubclassOfClass:UIViewController.class]))return PickerError(error);
    @try {
        NSMutableDictionary *selected=[NSMutableDictionary dictionary];NSMutableSet *unavailable=[NSMutableSet set];
        for(NSString *name in selectedNames) {
            if(!IsName(name,groups))continue;
            id contact=nil;
            for(NSString *getter in @[@"getContactByName:",@"getContactByNameFromDB:",@"getContactForSearchByName:"]) {
                if(Matches([manager class],getter,"@@:@"))contact=((id(*)(id,SEL,id))objc_msgSend)(manager,NSSelectorFromString(getter),name);
                if([Get(contact,@"m_nsUsrName") isEqual:name])break;contact=nil;
            }
            if(contact)selected[name]=contact;else if(!singleSelection)[unavailable addObject:name];
        }
        UIViewController *picker=[[cls alloc] init];if(!picker)return PickerError(error);
        CSNativePickerState *state=[CSNativePickerState new];state.groups=groups;state.preselected=selected;
        state.singleSelection=singleSelection;
        state.unavailableNames=unavailable;state.account=account;state.isValid=isValid;state.completion=completion;state.picker=picker;
        objc_setAssociatedObject(picker,&PickerStateKey,state,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        Set(picker,@"setM_dicMultiSelect:",[selected mutableCopy]);
        Set(picker,@"setM_delegate:",state);Set(picker,@"setM_rightBarButtonTitle:",@"完成");
        Set(picker,groups?@"setM_viewControllerTitle:":@"setM_viewcontrllerTitle:",title);
        picker.title=title;
        if(groups) {
            // Scene 4 enables native checkmarks, selection toggling and Done.
            // Scene 5 is a single-contact history picker and never toggles this dictionary.
            ((void(*)(id,SEL,unsigned int))objc_msgSend)(picker,NSSelectorFromString(@"setM_uiDataScene:"),4);
            ((void(*)(id,SEL,BOOL))objc_msgSend)(picker,NSSelectorFromString(@"setM_bShowSearchBar:"),YES);
        } else {
            for(NSString *selector in @[@"setM_bShowHistoryGroup:",@"setM_bShowRadarCreateRoom:",@"setHideSelfContact:"])
                ((void(*)(id,SEL,BOOL))objc_msgSend)(picker,NSSelectorFromString(selector),[selector isEqual:@"setHideSelfContact:"]);
            if(tags)((void(*)(id,SEL,BOOL))objc_msgSend)(picker,NSSelectorFromString(@"setM_bShowContactTag:"),YES);
        }
        UINavigationController *nav=[[navClass alloc] initWithRootViewController:picker];
        objc_setAssociatedObject(nav,&PickerStateKey,state,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        nav.modalPresentationStyle=UIModalPresentationFullScreen;
        [presenter presentViewController:nav animated:YES completion:tags ? ^{
            // The type sheet and this full-screen presentation must both finish.
            // Recheck authorization/visibility at the actual UIKit completion.
            if([state valid] && CSSettingsCanPresentFrom(picker))
                ((void(*)(id,SEL))objc_msgSend)(picker,NSSelectorFromString(@"onSelectContactTag"));
            else CSNativeContactPickerRevalidate(presenter);
        } : nil];
        return YES;
    } @catch(__unused NSException *exception) {return PickerError(error);}
}
BOOL CSNativeContactPickerPresent(UIViewController *presenter, NSString *title, BOOL groups, NSArray<NSString *> *selectedNames,
    BOOL (^isValid)(void), void (^completion)(NSArray<NSString *> *), NSError **error) {
    return PresentPicker(presenter,title,groups,NO,NO,selectedNames,isValid,completion,error);
}
BOOL CSNativeContactPickerPresentTags(UIViewController *presenter, NSString *title, NSArray<NSString *> *selectedNames,
    BOOL (^isValid)(void), void (^completion)(NSArray<NSString *> *), NSError **error) {
    return PresentPicker(presenter,title,NO,NO,YES,selectedNames,isValid,completion,error);
}
BOOL CSNativeContactPickerPresentSingle(UIViewController *presenter, NSString *title, BOOL groups, NSString *selectedName,
    BOOL (^isValid)(void), void (^completion)(NSString *), NSError **error) {
    if(!completion)return PickerError(error);
    return PresentPicker(presenter,title,groups,YES,NO,selectedName.length?@[selectedName]:@[],isValid,^(NSArray<NSString *> *names){
        if(names.count==1)completion(names.firstObject);
    },error);
}
void CSNativeContactPickerRevalidate(UIViewController *presenter) {
    CSNativePickerState *state=State(presenter.presentedViewController);
    if(state && ![state valid]) {
        // Keep the page and native Cancel button. Expired selections cannot be
        // viewed or saved; finish: still checks authorization before any write.
        state.revoked=YES;
        state.picker.view.hidden=YES;
        state.picker.navigationItem.rightBarButtonItem.enabled=NO;
        if(!state.groups)PickerUpdateFriendButton(state.picker,NSSelectorFromString(@"updateRightBarItemEnabled:"),NO);
        // Native tags are another presentation above the friend picker. Conceal
        // them before closing only that child, leaving the outer native Cancel.
        UIViewController *child=state.picker.presentedViewController ?: state.picker.navigationController.presentedViewController;
        UIViewController *tagPresentation=child;
        while(child) {
            UIViewController *content=[child isKindOfClass:UINavigationController.class] ? [(UINavigationController *)child topViewController] : child;
            content.view.hidden=YES;
            content.navigationItem.rightBarButtonItem.enabled=NO;
            child=content.presentedViewController ?: child.presentedViewController;
        }
        if(tagPresentation.presentingViewController && !tagPresentation.isBeingDismissed)
            [tagPresentation dismissViewControllerAnimated:NO completion:nil];
    }
}
