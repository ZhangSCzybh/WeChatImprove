// Production custom-group entry/save methods + actual native picker/preferences.
// Only UIKit, WeChat contacts and the defaults backing store are host doubles.
#import "CSGroupPreferences.h"
#import "WEContactSelectViewController.h"
#import "CSCloseFriendSignatures.h"
#if __has_include("CSSettingsPresentation.h")
#import "CSSettingsPresentation.h"
#endif
@implementation UITableViewController @end
@interface WEContactSelectViewController ()
@property(nonatomic,copy) NSArray *testSelectedNames;
@property(nonatomic) WEContactSelectType testType;
@property(nonatomic,copy) NSString *testTag;
@end
@implementation WEContactSelectViewController
- (instancetype)initWithTitle:(NSString *)title selectedUserNames:(NSArray *)names selectType:(WEContactSelectType)type {
    return [self initWithTitle:title selectedUserNames:names selectType:type tagName:nil];
}
- (instancetype)initWithTitle:(NSString *)title selectedUserNames:(NSArray *)names selectType:(WEContactSelectType)type tagName:(NSString *)tag {
    if((self=[super init])) { self.title=title;self.testSelectedNames=names;self.testType=type;self.testTag=tag; }return self;
}
@end
@interface ContactTagMgr : NSObject @end
@implementation ContactTagMgr
- (NSArray *)getAllLabelName { return @[@"同事",@"朋友"]; }
@end
@interface GroupPickerDefaults : NSObject
@property(nonatomic,strong) NSMutableDictionary *values;
@end
@implementation GroupPickerDefaults
- (instancetype)init { if((self=[super init]))self.values=[NSMutableDictionary dictionary];return self; }
- (id)objectForKey:(NSString *)key { return self.values[key]; }
- (void)setObject:(id)value forKey:(NSString *)key { self.values[key]=[value copy]; }
- (void)removeObjectForKey:(NSString *)key { [self.values removeObjectForKey:key]; }
- (BOOL)synchronize { return YES; }
@end
@interface GroupPickerTable : NSObject
@property(nonatomic) NSUInteger reloads;
@end
@implementation GroupPickerTable
- (void)reloadData { self.reloads++; }
@end
@interface NSObject (GroupPickerPolicy)
- (void)contactSelectionPolicyChanged:(NSNotification *)notification;
@end
@interface CSChatGroupSettingsViewController : UIViewController
@property(nonatomic,strong) CSGroupPreferences *groupPreferences;
@property(nonatomic,strong) GroupPickerDefaults *defaults;
@property(nonatomic,strong) NSMutableArray<WESessionTabItem *> *customTabs;
@property(nonatomic,strong) NSMutableDictionary *presetTabNames;
@property(nonatomic,strong) NSMutableArray *tabOrder;
@property(nonatomic,strong) NSMutableSet *hiddenPresetTabs;
@property(nonatomic,strong) GroupPickerTable *tableView;
@property(nonatomic) NSUInteger saves,setups;
- (void)showContactSelectForTab:(WESessionTabItem *)tab;
- (void)showTagSelectForTab:(WESessionTabItem *)tab;
- (void)presentContactSelectWithType:(WEContactSelectType)type tab:(WESessionTabItem *)tab tagName:(NSString *)name;
@end
@implementation CSChatGroupSettingsViewController
- (BOOL)refreshAccountIfNeeded {
    if([account isEqual:self.groupPreferences.accountID])return NO;
    self.groupPreferences=[[CSGroupPreferences alloc] initWithDefaults:(id)self.defaults accountID:account];
    [self copyAccountPreferences];return YES;
}
- (void)saveCustomTabs {
    self.saves++;
    Check([self.groupPreferences saveCustomTabs:self.customTabs presetNames:self.presetTabNames tabOrder:self.tabOrder hiddenPresetTabs:self.hiddenPresetTabs],@"selection saves through the actual account preferences store");
    [self copyAccountPreferences];
}
- (void)setupData { self.setups++; }
#import "GroupPickerUnderTest.h"
@end
static CSChatGroupSettingsViewController *GroupEditorTree(BOOL modal,UIViewController **root,UINavigationController **container) {
    account=@"me";pickerAccountEpoch=1;pickerPrivacy=[TestPickerPrivacy new];
    CSChatGroupSettingsViewController *editor=[CSChatGroupSettingsViewController new];
    editor.defaults=[GroupPickerDefaults new];editor.tableView=[GroupPickerTable new];
    editor.groupPreferences=[[CSGroupPreferences alloc] initWithDefaults:(id)editor.defaults accountID:account];
    WESessionTabItem *tab=[WESessionTabItem customTabWithName:@"混合分组" sessionUserNames:@[@"alice",@"alice",@"old@chatroom",@"gh_brand",@"me",@"missing-user",@"hidden"]];
    [editor.groupPreferences saveCustomTabs:@[tab] presetNames:@{} tabOrder:@[] hiddenPresetTabs:[NSSet set]];
    [editor copyAccountPreferences];[editor loadViewIfNeeded];
    *root=[UIViewController new];(*root).view.window=[NSObject new];
    *container=[[UINavigationController alloc] initWithRootViewController:[UIViewController new]];
    [*container pushViewController:[UIViewController new] animated:NO];[*container pushViewController:editor animated:NO];
    if(modal)[*root presentViewController:*container animated:NO completion:nil];
    else { (*container).parentViewController=*root;(*container).view.window=(*root).view.window;editor.view.window=(*root).view.window; }
    dismissReceivers=[NSMutableArray array];invalidPresentations=0;return editor;
}
static void AssertGroupHost(BOOL modal,UIViewController *root,UINavigationController *container,CSChatGroupSettingsViewController *editor) {
    Check(!modal || root.presentedViewController==container,@"custom-group selection keeps plugin modal attached");
    Check(container.viewControllers.count==3 && container.topViewController==editor && editor.view.window!=nil,@"same group settings page stays in its navigation stack/window");
    Check(![dismissReceivers containsObject:editor] && ![dismissReceivers containsObject:container],@"group flow dismisses only its menu or picker");
}
static UIViewController *OpenGroupPicker(CSChatGroupSettingsViewController *editor,BOOL groups) {
    [editor showContactSelectForTab:editor.customTabs.firstObject];UIAlertController *sheet=(id)editor.presentedViewController;
    UIAlertAction *action=TargetAction(sheet,groups?@"群聊":@"私聊");DetachPresentation(sheet);action.handler(action);return Picker(editor);
}
static void TestGroupNativeTags(void) {
    for(NSNumber *modalValue in @[@YES,@NO])for(NSUInteger timing=0;timing<3;timing++) {
        UIViewController *root;UINavigationController *container;
        CSChatGroupSettingsViewController *editor=GroupEditorTree(modalValue.boolValue,&root,&container);
        NSArray *original=[editor.customTabs.firstObject.sessionUserNames copy];NSDictionary *before=[editor.defaults.values copy];
        [editor showContactSelectForTab:editor.customTabs.firstObject];UIAlertController *sheet=(id)editor.presentedViewController;
        UIAlertAction *action=TargetAction(sheet,@"标签");TestPickerTransition *transition=nil;
        if(timing==0)DetachPresentation(sheet);
        if(timing==1) { transition=[TestPickerTransition new];sheet.transitionCoordinator=transition;sheet.isBeingDismissed=YES; }
        if(timing==2)deferSheetDismissal=YES;
        deferPickerPresentation=YES;NSUInteger prior=nativeTagEntrances;
        action.handler(action);
        if(timing>0) {
            Check(editor.presentedViewController==sheet && !invalidPresentations,@"native tag route waits for the type sheet itself");
            if(timing==1) { Check(transition.completion!=nil,@"tag route observes dismissal transition");DetachPresentation(sheet);transition.completion(transition); }
            else { Check(pendingSheetDismissal!=nil,@"tag route dismisses the sheet only");void(^done)(void)=pendingSheetDismissal;pendingSheetDismissal=nil;deferSheetDismissal=NO;done(); }
        }
        Check([editor.presentedViewController isKindOfClass:MMUINavigationController.class],@"tag entry uses the shared native picker, not a custom tag sheet or PageSheet");
        MultiSelectContactsViewController *picker=(id)Picker(editor);
        Check([picker isKindOfClass:MultiSelectContactsViewController.class] && editor.presentedViewController.modalPresentationStyle==UIModalPresentationFullScreen,@"tag route retains native fullscreen friend/search/checkmark UI");
        Check(picker.m_bShowContactTag && nativeTagEntrances==prior && pendingPickerPresentation!=nil,@"native tag dialog is deferred to actual picker presentation completion");
        void(^presented)(void)=pendingPickerPresentation;pendingPickerPresentation=nil;deferPickerPresentation=NO;presented();
        Check(nativeTagEntrances==prior+1 && [Picker(picker) isKindOfClass:ContactTagListViewController.class],@"exactly one native onSelectContactTag entry is invoked");
        Check(picker.m_selectView.m_dicMultiSelect[@"alice"] && [editor.customTabs.firstObject.sessionUserNames isEqual:original] && [editor.defaults.values isEqual:before],@"old All-origin members and native preselection survive opening the new tag flow without migration");
        Check([editor.groupPreferences.tabs filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"tabId == %@",@"preset_0"]].count==1,@"removing All from picker leaves builtin All group intact");
        ContactTagListViewController *tags=(id)Picker(picker);
        [tags selectTagContacts:@[Contact(@"bob"),Contact(@"bob"),Contact(@"carol"),Contact(@"wrong@chatroom"),Contact(@"gh_bad")]];
        Check(picker.m_selectView.m_dicMultiSelect[@"bob"] && picker.m_selectView.m_dicMultiSelect[@"carol"] && !editor.saves,@"native tag bulk selection updates live selection without saving yet");
        [picker actionCancel];
        Check([editor.defaults.values isEqual:before] && [editor.customTabs.firstObject.sessionUserNames isEqual:original] && !editor.saves,@"Cancel after tag selection preserves all original members and timestamps");
        AssertGroupHost(modalValue.boolValue,root,container,editor);
        [editor showTagSelectForTab:editor.customTabs.firstObject];picker=(id)Picker(editor);tags=(id)Picker(picker);
        [tags selectTagContacts:@[Contact(@"bob"),Contact(@"bob"),Contact(@"carol"),Contact(@"wrong@chatroom"),Contact(@"gh_bad")]];
        [picker selectContact:Contact(@"alice")];TapFriendDone(picker);
        NSArray *saved=editor.customTabs.firstObject.sessionUserNames;
        Check([saved containsObject:@"bob"] && [saved containsObject:@"carol"] && ![saved containsObject:@"alice"],@"native tag result permits individual search/list edits before whole-list save");
        Check([saved containsObject:@"old@chatroom"] && [saved containsObject:@"gh_brand"] && [saved containsObject:@"missing-user"] && [saved containsObject:@"me"] && [saved containsObject:@"hidden"],@"tag edits preserve unrelated old All-origin members");
        Check(![saved containsObject:@"wrong@chatroom"] && ![saved containsObject:@"gh_bad"] && saved.count==[NSSet setWithArray:saved].count,@"native tag bulk callback cannot bypass final category validation or duplicate members");
        Check(editor.saves==1 && editor.setups==1 && editor.tableView.reloads==1 && !invalidPresentations,@"tag completion saves/reloads once without overlapping UI");
        AssertGroupHost(modalValue.boolValue,root,container,editor);
        [editor showTagSelectForTab:editor.customTabs.firstObject];picker=(id)Picker(editor);tags=(id)Picker(picker);
        Check(picker.m_selectView.m_dicMultiSelect[@"bob"] && picker.m_selectView.m_dicMultiSelect[@"carol"],@"native tag flow reopens with saved checkmarks");
        [tags.navigationController dismissViewControllerAnimated:YES completion:nil];[picker actionCancel];
    }
    // Invalidation while either the native parent is presenting or its tag dialog is open.
    for(NSUInteger boundary=0;boundary<3;boundary++)for(NSUInteger change=0;change<4;change++) {
        UIViewController *root;UINavigationController *container;CSChatGroupSettingsViewController *editor=GroupEditorTree(YES,&root,&container);
        deferPickerPresentation=boundary==0;NSUInteger prior=nativeTagEntrances;
        [editor showTagSelectForTab:editor.customTabs.firstObject];MultiSelectContactsViewController *picker=(id)Picker(editor);
        void(^invalidate)(void)=^{ if(change==0)pickerAccountEpoch++;if(change==1)account=@"other";if(change==2)pickerPrivacy.revision++;
            if(change==3) { CSGroupPreferences *other=[[CSGroupPreferences alloc] initWithDefaults:(id)editor.defaults accountID:@"me"];[other saveCustomTabs:@[] presetNames:@{} tabOrder:@[] hiddenPresetTabs:[NSSet set]]; } };
        if(boundary==0) {
            invalidate();void(^done)(void)=pendingPickerPresentation;pendingPickerPresentation=nil;deferPickerPresentation=NO;done();
            Check(nativeTagEntrances==prior,@"invalid account/configuration during parent presentation cannot open tag dialog");
        } else {
            ContactTagListViewController *tags=(id)Picker(picker);
            if(boundary==1) {
                invalidate();[editor contactSelectionPolicyChanged:nil];
                Check(picker.view.hidden && (!picker.presentedViewController || tags.view.hidden),@"invalid native tag dialog cannot expose the former account's contacts");
            }
            [tags selectTagContacts:@[Contact(@"late")]];
            if(boundary==2)duringDismissal=invalidate;
        }
        [picker onDone:nil];duringDismissal=nil;
        Check(!editor.saves,@"native tag route rejects account/privacy/configuration changes before and after dismissal");
        AssertGroupHost(YES,root,container,editor);
    }
}
static void TestGroupPickerPresentation(void) {
    requireVisiblePresentation=YES;
    if(getenv("CS_TEST_GROUP_TAG_ONLY")) { TestGroupNativeTags();return; }
    // Separate red entry points prove both incorrect routing and the dismissal race.
    if(getenv("CS_TEST_GROUP_PICKER_RACE")) {
        UIViewController *root;UINavigationController *container;CSChatGroupSettingsViewController *editor=GroupEditorTree(YES,&root,&container);
        [editor showContactSelectForTab:editor.customTabs.firstObject];UIAlertController *sheet=(id)editor.presentedViewController;
        TestPickerTransition *transition=[TestPickerTransition new];sheet.transitionCoordinator=transition;sheet.isBeingDismissed=YES;
        UIAlertAction *action=TargetAction(sheet,@"私聊");action.handler(action);
        Check(invalidPresentations==0,@"type handler must not present while its action sheet is dismissing");
        Check(transition.completion!=nil,@"group route waits on the action sheet transition coordinator");return;
    }
    for(NSNumber *modalValue in @[@YES,@NO])for(NSNumber *groupValue in @[@NO,@YES])for(NSUInteger timing=0;timing<3;timing++) {
        BOOL modal=modalValue.boolValue,groups=groupValue.boolValue;
        UIViewController *root;UINavigationController *container;CSChatGroupSettingsViewController *editor=GroupEditorTree(modal,&root,&container);
        NSDictionary *before=[editor.defaults.values copy];
        [editor showContactSelectForTab:editor.customTabs.firstObject];UIAlertController *sheet=(id)editor.presentedViewController;
        Check(sheet.actions.count==4 && [sheet.actions filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"title == %@",@"全部"]].count==0,@"type menu contains only private/group/tag/Cancel; saved mixed membership is untouched");
        UIAlertAction *action=TargetAction(sheet,groups?@"群聊":@"私聊");TestPickerTransition *transition=nil;
        if(timing==0)DetachPresentation(sheet);
        if(timing==1) { transition=[TestPickerTransition new];sheet.transitionCoordinator=transition;sheet.isBeingDismissed=YES; }
        if(timing==2)deferSheetDismissal=YES;
        action.handler(action);
        if(timing>0) {
            Check(editor.presentedViewController==sheet && invalidPresentations==0,@"group picker never competes with dismissing menu");
            if(timing==1) { Check(transition.completion!=nil,@"observe menu dismissal");DetachPresentation(sheet);transition.completion(transition); }
            else { Check(pendingSheetDismissal!=nil,@"explicit dismissal targets only the sheet");void(^done)(void)=pendingSheetDismissal;pendingSheetDismissal=nil;deferSheetDismissal=NO;done(); }
        }
        UIViewController *picker=Picker(editor);
        Check(groups?[picker isKindOfClass:GroupSelectContactsViewController.class]:[picker isKindOfClass:MultiSelectContactsViewController.class],@"private/group must use CSNativeContactPicker, never WEContactSelect PageSheet");
        Check(editor.presentedViewController.modalPresentationStyle==UIModalPresentationFullScreen,@"native picker remains full screen");
        NSDictionary *selection=groups?[(GroupSelectContactsViewController *)picker m_dicMultiSelect]:[(MultiSelectContactsViewController *)picker m_selectView].m_dicMultiSelect;
        Check(selection[groups?@"old@chatroom":@"alice"]!=nil,@"existing selected members are checked in the native list");
        Check([editor.defaults.values isEqual:before] && !editor.saves,@"opening selection never writes configuration");
        if(groups)[(GroupSelectContactsViewController *)picker onCancelBack:nil];else [(MultiSelectContactsViewController *)picker actionCancel];
        Check(!editor.presentedViewController && [editor.defaults.values isEqual:before] && !editor.saves,@"Cancel leaves stored membership and timestamp completely unchanged");
        AssertGroupHost(modal,root,container,editor);
        picker=OpenGroupPicker(editor,groups);
        NSMutableDictionary *live=groups?[(GroupSelectContactsViewController *)picker m_dicMultiSelect]:[(MultiSelectContactsViewController *)picker m_selectView].m_dicMultiSelect;
        [live removeObjectForKey:groups?@"old@chatroom":@"alice"];
        NSString *first=groups?@"new@chatroom":@"bob",*second=groups?@"next@chatroom":@"carol";
        live[first]=Contact(first);live[second]=Contact(second);live[@"duplicate-native-entry"]=Contact(first);
        NSDate *oldDate=editor.customTabs.firstObject.updateTime;
        if(groups)TapGroupDone((id)picker);else TapFriendDone((id)picker);
        NSArray *saved=editor.customTabs.firstObject.sessionUserNames;
        Check([saved containsObject:first] && [saved containsObject:second] && ![saved containsObject:groups?@"old@chatroom":@"alice"],@"Done replaces the selected category with all current selections");
        Check([saved containsObject:groups?@"alice":@"old@chatroom"] && [saved containsObject:@"gh_brand"] && [saved containsObject:@"missing-user"] && [saved containsObject:@"me"] && [saved containsObject:@"hidden"],@"other categories, unavailable names and existing privacy membership survive");
        Check(saved.count==[NSSet setWithArray:saved].count && editor.saves==1 && editor.setups==1 && editor.tableView.reloads==1,@"deduplicated whole-list write runs the existing save/setup/reload sequence once");
        Check([editor.customTabs.firstObject.updateTime compare:oldDate]!=NSOrderedAscending,@"membership update records its timestamp");
        AssertGroupHost(modal,root,container,editor);
        picker=OpenGroupPicker(editor,groups);
        live=groups?[(GroupSelectContactsViewController *)picker m_dicMultiSelect]:[(MultiSelectContactsViewController *)picker m_selectView].m_dicMultiSelect;
        Check(live[first] && live[second],@"saved multi-selection is preselected after reopening");
        [live removeAllObjects];if(groups)TapGroupDone((id)picker);else TapFriendDone((id)picker);
        saved=editor.customTabs.firstObject.sessionUserNames;
        Check(![saved containsObject:first] && ![saved containsObject:second] && [saved containsObject:groups?@"alice":@"old@chatroom"],@"empty selection clears only that category");
        Check(invalidPresentations==0,@"both host modes have no overlapping presentations");
    }
    // Validity is checked both during selection and again after picker dismissal.
    for(NSUInteger boundary=0;boundary<3;boundary++)for(NSUInteger change=0;change<6;change++) {
        UIViewController *root;UINavigationController *container;CSChatGroupSettingsViewController *editor=GroupEditorTree(YES,&root,&container);
        void(^invalidate)(void)=^{
            if(change==0)account=@"another";
            if(change==1)pickerAccountEpoch++; // Includes A -> B -> A with unchanged username.
            if(change==2)pickerPrivacy.revision++;
            if(change==3)pickerPrivacy.blocked=YES;
            if(change==4) {
                CSGroupPreferences *other=[[CSGroupPreferences alloc] initWithDefaults:(id)editor.defaults accountID:@"me"];
                [other saveCustomTabs:@[] presetNames:other.presetNames tabOrder:other.tabOrder hiddenPresetTabs:other.hiddenPresetTabs];
            }
            if(change==5) {
                CSGroupPreferences *other=[[CSGroupPreferences alloc] initWithDefaults:(id)editor.defaults accountID:@"me"];
                other.customTabs.firstObject.tabName=@"在另一页面修改";
                [other saveCustomTabs:other.customTabs presetNames:other.presetNames tabOrder:other.tabOrder hiddenPresetTabs:other.hiddenPresetTabs];
            }
        };
        if(boundary==0) {
            [editor showContactSelectForTab:editor.customTabs.firstObject];UIAlertController *sheet=(id)editor.presentedViewController;
            UIAlertAction *action=TargetAction(sheet,@"私聊");DetachPresentation(sheet);invalidate();action.handler(action);
            Check(![editor.presentedViewController isKindOfClass:UINavigationController.class],@"invalid account/configuration stops menu-to-picker transition");
        } else {
            MultiSelectContactsViewController *picker=(id)OpenGroupPicker(editor,NO);
            [picker selectContact:Contact(@"late")];
            if(boundary==1)invalidate();else duringDismissal=invalidate;
            [picker onDone:nil];duringDismissal=nil;
        }
        Check(editor.saves==0,@"stale account generation/privacy/group definitions cannot write selection");
        AssertGroupHost(YES,root,container,editor);
    }
    for(NSNumber *groupsValue in @[@NO,@YES]) {
        UIViewController *root;UINavigationController *container;CSChatGroupSettingsViewController *editor=GroupEditorTree(YES,&root,&container);
        WESessionTabItem *tab=[WESessionTabItem customTabWithName:@"新建空分组" sessionUserNames:@[]];
        [editor.groupPreferences saveCustomTabs:@[tab] presetNames:@{} tabOrder:@[] hiddenPresetTabs:[NSSet set]];[editor copyAccountPreferences];
        UIViewController *picker=OpenGroupPicker(editor,groupsValue.boolValue);
        if(groupsValue.boolValue){[(GroupSelectContactsViewController *)picker selectContact:Contact(@"first@chatroom")];TapGroupDone((id)picker);}
        else {[(MultiSelectContactsViewController *)picker selectContact:Contact(@"first")];TapFriendDone((id)picker);}
        Check(editor.customTabs.firstObject.sessionUserNames.count==1 && editor.saves==1,@"new empty custom group can select and save its first native member");
        picker=OpenGroupPicker(editor,groupsValue.boolValue);
        pickerPrivacy.revision++;
        if([editor respondsToSelector:@selector(contactSelectionPolicyChanged:)])[(id)editor contactSelectionPolicyChanged:nil];
        Check(picker.view.hidden,@"privacy/account notification conceals invalid native selection in place");
        if(groupsValue.boolValue)[(GroupSelectContactsViewController *)picker onCancelBack:nil];else [(MultiSelectContactsViewController *)picker actionCancel];
        Check(!editor.presentedViewController && editor.saves==1,@"invalidated native picker still permits Cancel without another save");
    }
    for(NSUInteger change=0;change<6;change++) {
        UIViewController *root;UINavigationController *container;CSChatGroupSettingsViewController *editor=GroupEditorTree(YES,&root,&container);
        [editor showContactSelectForTab:editor.customTabs.firstObject];UIAlertController *sheet=(id)editor.presentedViewController;
        TestPickerTransition *transition=[TestPickerTransition new];sheet.transitionCoordinator=transition;sheet.isBeingDismissed=YES;
        UIAlertAction *action=TargetAction(sheet,@"群聊");action.handler(action);DetachPresentation(sheet);
        if(change==0)transition.cancelled=YES;
        if(change==1)editor.view.window=nil;
        if(change==2)container.topViewController=[UIViewController new];
        if(change==3)container.isBeingDismissed=YES;
        if(change==4)editor.presentedViewController=[UIViewController new];
        if(change==5)container.presentedViewController=[UIViewController new];
        transition.completion(transition);
        Check(![editor.presentedViewController isKindOfClass:UINavigationController.class] && !editor.saves && invalidPresentations==0,@"canceled transition or invalid presenter cannot open a picker");
        Check(root.presentedViewController==container,@"invalid transition never dismisses plugin modal");
    }
    TestGroupNativeTags();
    Check(nativeDoneCalls==0,@"group configuration never invokes WeChat send/create-group actions");
}
