// Execute the production target-menu and picker methods against a modal hierarchy.
// No WeChat process, user defaults, network, task execution or message sending.
#if __has_include("CSSettingsPresentation.h")
#import "CSSettingsPresentation.h"
#endif
@interface TestPickerPrivacy : NSObject
@property(nonatomic) NSUInteger revision;
@property(nonatomic) BOOL blocked;
@end
@implementation TestPickerPrivacy @end
static TestPickerPrivacy *pickerPrivacy;
static NSUInteger pickerAlerts;
static TestPickerPrivacy *CSCloseFriendCurrentSnapshot(void) { return pickerPrivacy; }
static NSUInteger pickerAccountEpoch=1;
static NSUInteger CSCloseFriendAccountEpoch(void) { return pickerAccountEpoch; }
static const NSInteger CSCloseFriendSurfaceSession=0;
static BOOL CSCloseFriendShouldHideUserName(NSString *name,NSInteger surface) { return [name isEqual:@"hidden"]; }
static void CSTaskAlert(UIViewController *presenter,NSString *message) { pickerAlerts++; }

@interface CSScheduledTaskEditor : UIViewController
@property(nonatomic,strong) NSMutableDictionary *task;
@property(nonatomic) BOOL editable;
- (void)chooseTarget;
- (void)presentTargetPicker:(BOOL)groups;
@end
@implementation CSScheduledTaskEditor
- (BOOL)canEdit { return self.editable && [account isEqual:@"me"]; }
- (void)reload {}
- (void)presentSheet:(UIAlertController *)sheet section:(NSInteger)section row:(NSInteger)row {
    [sheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:sheet animated:YES completion:nil];
}
#import "ScheduledTaskPickerUnderTest.h"
@end

@interface TestPickerTransition : NSObject <UIViewControllerTransitionCoordinator,UIViewControllerTransitionCoordinatorContext>
@property(nonatomic,getter=isCancelled) BOOL cancelled;
@property(nonatomic,copy) void (^completion)(id<UIViewControllerTransitionCoordinatorContext>);
@end
@implementation TestPickerTransition
- (BOOL)animateAlongsideTransition:(void (^)(id<UIViewControllerTransitionCoordinatorContext>))animation completion:(void (^)(id<UIViewControllerTransitionCoordinatorContext>))completion {
    self.completion=completion;return YES;
}
@end
static UIAlertAction *TargetAction(UIAlertController *sheet,NSString *title) {
    for(UIAlertAction *a in sheet.actions)if([a.title isEqual:title])return a;
    Check(NO,@"target action exists");return nil;
}
static NSDictionary *TaskDraft(void) {
    return @{@"title":@"未保存的任务",@"text":@"已填写内容\n第二行",@"target":@"filehelper",@"mode":@"minutes",@"interval":@3,@"enabled":@YES};
}
static CSScheduledTaskEditor *EditorTree(BOOL modal,UIViewController **root,UINavigationController **container) {
    *root=[UIViewController new];(*root).view.window=[NSObject new];
    CSScheduledTaskEditor *editor=[CSScheduledTaskEditor new];editor.task=[TaskDraft() mutableCopy];editor.editable=YES;[editor loadViewIfNeeded];
    *container=[[UINavigationController alloc] initWithRootViewController:[UIViewController new]];
    [*container pushViewController:[UIViewController new] animated:NO];
    [*container pushViewController:editor animated:NO];
    if(modal)[*root presentViewController:*container animated:NO completion:nil];
    else { (*container).parentViewController=*root;(*container).view.window=(*root).view.window;editor.view.window=(*root).view.window; }
    dismissReceivers=[NSMutableArray array];invalidPresentations=0;return editor;
}
static void AssertHost(BOOL modal,UIViewController *root,UINavigationController *container,CSScheduledTaskEditor *editor) {
    Check(!modal || root.presentedViewController==container,@"plugin modal survives choosing a target (no editor/host dismiss)");
    Check(container.viewControllers.count==3 && container.topViewController==editor && editor.view.window!=nil,@"same pushed editor remains in its navigation stack/window");
    Check(![dismissReceivers containsObject:editor] && ![dismissReceivers containsObject:container],@"only the alert or picker may be dismissed");
}
static void TestScheduledPickerPresentation(void) {
    requireVisiblePresentation=YES;pickerPrivacy=[TestPickerPrivacy new];account=@"me";
    // Before handler, during dismissal, and not-yet-dismissed are all legal UIKit orderings.
    // Start with the recording's detached-sheet + modal case to prove the old failure.
    for(NSNumber *modalValue in @[@YES,@NO])for(NSNumber *groupsValue in @[@NO,@YES])for(NSUInteger timing=0;timing<3;timing++) {
        BOOL modal=modalValue.boolValue,groups=groupsValue.boolValue;
        UIViewController *root;UINavigationController *container;CSScheduledTaskEditor *editor=EditorTree(modal,&root,&container);
        [editor chooseTarget];UIAlertController *sheet=(id)editor.presentedViewController;
        Check([sheet isKindOfClass:UIAlertController.class] && sheet.actions.count==4,@"original target menu and Cancel remain available");
        UIAlertAction *action=TargetAction(sheet,groups?@"群聊":@"私聊");
        TestPickerTransition *transition=nil;
        if(timing==0)DetachPresentation(sheet);
        if(timing==1){transition=[TestPickerTransition new];sheet.transitionCoordinator=transition;sheet.isBeingDismissed=YES;}
        if(timing==2)deferSheetDismissal=YES;
        action.handler(action);
        AssertHost(modal,root,container,editor);
        if(timing>0) {
            Check(editor.presentedViewController==sheet,@"no native picker is presented before the sheet really finishes");
            if(timing==1) {Check(transition.completion!=nil,@"observe the active sheet transition");DetachPresentation(sheet);transition.completion(transition);}
            else {Check(pendingSheetDismissal!=nil,@"wait for dismissal of this sheet");void(^done)(void)=pendingSheetDismissal;pendingSheetDismissal=nil;deferSheetDismissal=NO;done();}
        }
        AssertHost(modal,root,container,editor);
        UIViewController *picker=Picker(editor);
        Check(groups?[picker isKindOfClass:GroupSelectContactsViewController.class]:[picker isKindOfClass:MultiSelectContactsViewController.class],@"correct native friend/group picker is actually presented");
        Check(invalidPresentations==0,@"no detached presenter or second presentation attempt");
        Check([editor.task isEqual:TaskDraft()],@"opening the picker does not alter the draft");
        if(groups)[(GroupSelectContactsViewController *)picker onCancelBack:nil];else [(MultiSelectContactsViewController *)picker actionCancel];
        AssertHost(modal,root,container,editor);
        Check(!editor.presentedViewController && [editor.task isEqual:TaskDraft()],@"Cancel returns to the same editor and preserves all unsaved fields");
        // Reopen, choose one recipient and finish through the actual native adapter.
        [editor chooseTarget];sheet=(id)editor.presentedViewController;action=TargetAction(sheet,groups?@"群聊":@"私聊");DetachPresentation(sheet);action.handler(action);
        picker=Picker(editor);NSString *name=groups?@"picked@chatroom":@"picked-friend";
        if(groups){[(GroupSelectContactsViewController *)picker selectContact:Contact(name)];TapGroupDone((id)picker);}
        else {[(MultiSelectContactsViewController *)picker selectContact:Contact(name)];TapFriendDone((id)picker);}
        NSMutableDictionary *expected=[TaskDraft() mutableCopy];expected[@"target"]=name;
        Check([editor.task isEqual:expected] && !editor.presentedViewController,@"Done changes only the recipient and returns to the draft");
        AssertHost(modal,root,container,editor);
    }
    // Dismissal may finish after the editor/account/visible modal has changed.
    for(NSUInteger change=0;change<7;change++) {
        UIViewController *root;UINavigationController *container;CSScheduledTaskEditor *editor=EditorTree(YES,&root,&container);
        [editor chooseTarget];UIAlertController *sheet=(id)editor.presentedViewController;UIAlertAction *action=TargetAction(sheet,@"私聊");
        TestPickerTransition *transition=[TestPickerTransition new];sheet.transitionCoordinator=transition;sheet.isBeingDismissed=YES;
        action.handler(action);Check(editor.presentedViewController==sheet,@"wait before applying lifecycle changes");
        DetachPresentation(sheet);
        if(change==0)editor.view.window=nil;
        if(change==1)container.topViewController=[UIViewController new];
        if(change==2)container.isBeingDismissed=YES;
        if(change==3)editor.presentedViewController=[UIViewController new];
        if(change==4)account=@"another";
        if(change==5)transition.cancelled=YES;
        if(change==6)container.presentedViewController=[UIViewController new];
        transition.completion(transition);
        Check(![editor.presentedViewController isKindOfClass:UINavigationController.class],@"stale transition never opens a native picker");
        Check(root.presentedViewController==container && [editor.task isEqual:TaskDraft()],@"stale transition never closes the plugin or alters the draft");
        Check(invalidPresentations==0,@"invalid presenter is rejected before calling UIKit");account=@"me";
    }
    UIViewController *root;UINavigationController *container;CSScheduledTaskEditor *editor=EditorTree(YES,&root,&container);
    [editor chooseTarget];UIAlertController *sheet=(id)editor.presentedViewController;DetachPresentation(sheet);
    UIAlertAction *helper=TargetAction(sheet,@"文件传输助手");helper.handler(helper);
    Check(!editor.presentedViewController && [editor.task isEqual:TaskDraft()],@"file helper sets its target without a second modal");
    [editor chooseTarget];sheet=(id)editor.presentedViewController;DetachPresentation(sheet);
    Check(TargetAction(sheet,@"取消").handler==nil && [editor.task isEqual:TaskDraft()],@"target-menu Cancel leaves the draft unchanged");
    AssertHost(YES,root,container,editor);
    Check(nativeDoneCalls==0,@"picker tests never send a message or create a group");
}
