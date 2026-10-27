#import "CSAIChatDetailAdapter.h"
#import "CSAIReplyManager.h"
#import "CSAIReplySettingsViewController.h"
#import "CSMessageNativeActionAdapter.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

static const void *DetailKey=&DetailKey;
static const void *SectionKey=&SectionKey;
static id ReadIvar(id object,const char *name){
    Ivar ivar=class_getInstanceVariable(object_getClass(object),name);
    return ivar && ivar_getTypeEncoding(ivar)[0]=='@'?object_getIvar(object,ivar):nil;
}
static id Call(id receiver,NSString *selector,NSArray *types,NSArray *arguments){
    return CSMessageNativeSupports(receiver,selector,@"@",types)?CSMessageNativeInvoke(receiver,selector,arguments):nil;
}
@interface CSAIChatDetailState : NSObject
@property(nonatomic,weak) id page;
@property(nonatomic,copy) NSString *account;
@property(nonatomic,copy) NSString *conversation;
@property(nonatomic) NSUInteger epoch;
@property(nonatomic) BOOL refreshing;
- (void)refresh;
@end
@implementation CSAIChatDetailState
- (instancetype)init {if((self=[super init]))[NSNotificationCenter.defaultCenter addObserver:self selector:@selector(changed:) name:CSAIReplyDidChange object:nil];return self;}
- (void)dealloc {[NSNotificationCenter.defaultCenter removeObserver:self];}
- (void)changed:(NSNotification *)note {(void)note;if(NSThread.isMainThread)[self refresh];else dispatch_async(dispatch_get_main_queue(),^{[self refresh];});}
- (BOOL)current {
    CSAIReplyManager *manager=CSAIReplyManager.sharedManager;
    if(!self.page || ![manager isCurrentAccount:self.account epoch:self.epoch])return NO;
    id contact=CSMessageActionNativeObject(self.page,@"getChatContact");
    if(!contact)contact=CSMessageActionNativeObject(self.page,[self.conversation hasSuffix:@"@chatroom"]?@"m_chatRoomContact":@"m_contact");
    return [CSMessageActionNativeObject(contact,@"m_nsUsrName") isEqual:self.conversation] && [manager allowsConversation:self.conversation];
}
- (UIViewController *)controller {
    id page=self.page;
    if([page isKindOfClass:UIViewController.class])return page;
    id controller=CSMessageActionNativeObject(page,@"getViewController");
    return [controller isKindOfClass:UIViewController.class]?controller:nil;
}
- (void)showError:(NSError *)error {
    UIViewController *controller=[self controller];if(!controller.view.window || controller.presentedViewController)return;
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"AI 回复" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil]];[controller presentViewController:alert animated:YES completion:nil];
}
- (void)toggle:(id)sender {
    if(![sender isKindOfClass:UISwitch.class] || ![self current]){[self refresh];return;}
    NSDictionary *conversation=CSAIReplyManager.sharedManager.store.configuration[@"conversations"][self.conversation];NSError *error=nil;
    if(![CSAIReplyManager.sharedManager setConversation:self.conversation enabled:[sender isOn] presetID:conversation[@"presetID"]?:@"" account:self.account epoch:self.epoch error:&error])[self showError:error];
    [self refresh];
}
- (void)choosePreset {
    if(![self current])return;UIViewController *controller=[self controller];
    if(controller.view.window)CSAIPresentPresetPicker(controller,self.conversation,self.account,self.epoch);
}
- (void)refresh {
    if(!NSThread.isMainThread || self.refreshing || !self.page)return;
    self.refreshing=YES;
    @try {
        id tableInfo=ReadIvar(self.page,"m_tableViewInfo");
        if(!tableInfo)tableInfo=CSMessageActionNativeObject(self.page,@"m_tableViewInfo");
        NSArray *sections=CSMessageActionNativeObject(tableInfo,@"getAllSections");
        if(![sections isKindOfClass:NSArray.class])sections=CSMessageActionNativeObject(tableInfo,@"sections");
        if(![sections isKindOfClass:NSArray.class] || !CSMessageNativeSupports(tableInfo,@"addSection:",@"v",@[@"@"]) || !CSMessageNativeSupports(tableInfo,@"removeSectionAt:",@"v",@[@"Q"]))return;
        for(NSInteger index=(NSInteger)sections.count-1;index>=0;index--){
            if(objc_getAssociatedObject(sections[(NSUInteger)index],SectionKey)==self)CSMessageNativeInvoke(tableInfo,@"removeSectionAt:",@[@(index)]);
        }
        if([self current]){
            Class sectionClass=NSClassFromString(@"WCTableViewSectionManager"),cellClass=NSClassFromString(@"WCTableViewCellManager");
            id section=Call(sectionClass,@"sectionWithHeader:",@[@"@"],@[@"AI 回复"]);
            if(!section)section=Call(sectionClass,@"sectionInfoHeader:",@[@"@"],@[@"AI 回复"]);
            if(!section || !CSMessageNativeSupports(section,@"addCell:",@"v",@[@"@"]))return;
            CSAIReplyManager *manager=CSAIReplyManager.sharedManager;
            BOOL enabled=[manager.store.configuration[@"conversations"][self.conversation][@"enabled"] boolValue];
            id toggle=Call(cellClass,@"switchCellForSel:target:title:on:",@[@":",@"@",@"@",@"B"],@[@"toggle:",self,@"启用 AI 回复",@(enabled)]);
            id preset=Call(cellClass,@"normalCellForSel:target:title:rightValue:",@[@":",@"@",@"@",@"@"],@[@"choosePreset",self,@"回复预设",[manager presetNameForConversation:self.conversation]]);
            if(!toggle || !preset)return;
            CSMessageNativeInvoke(section,@"addCell:",@[toggle]);CSMessageNativeInvoke(section,@"addCell:",@[preset]);
            NSString *footer=[manager statusForConversation:self.conversation];
            if([self.conversation hasSuffix:@"@chatroom"])footer=[footer stringByAppendingString:@"。群聊仅在成员单独 @ 当前账号时回复，@ 所有人不触发。"];
            if(CSMessageNativeSupports(section,@"setFooterTitle:",@"v",@[@"@"]))CSMessageNativeInvoke(section,@"setFooterTitle:",@[footer]);
            // Native sections retain cached indexes for their own special rows. Append our
            // section rather than shift those indexes; deletion/footer actions remain native.
            objc_setAssociatedObject(section,SectionKey,self,OBJC_ASSOCIATION_ASSIGN);
            CSMessageNativeInvoke(tableInfo,@"addSection:",@[section]);
        }
        id table=CSMessageActionNativeObject(tableInfo,@"getTableView");if(!table)table=CSMessageActionNativeObject(tableInfo,@"tableView");
        if([table isKindOfClass:UITableView.class])[table reloadData];
    }@catch(__unused NSException *exception){}@finally{self.refreshing=NO;}
}
@end
void CSAIRefreshChatDetail(id page){
    if(!NSThread.isMainThread || !page)return;
    CSAIChatDetailState *state=objc_getAssociatedObject(page,DetailKey);
    if(!state){
        CSAIReplyManager *manager=CSAIReplyManager.sharedManager;if(!manager.store.ready)return;
        id contact=CSMessageActionNativeObject(page,@"getChatContact");
        if(!contact)contact=CSMessageActionNativeObject(page,@"m_chatRoomContact");
        if(!contact)contact=CSMessageActionNativeObject(page,@"m_contact");
        id conversation=CSMessageActionNativeObject(contact,@"m_nsUsrName");
        if(![conversation isKindOfClass:NSString.class] || ![manager allowsConversation:conversation])return;
        state=[CSAIChatDetailState new];state.page=page;state.account=manager.store.account;state.epoch=manager.epoch;state.conversation=conversation;
        objc_setAssociatedObject(page,DetailKey,state,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [state refresh];
}
