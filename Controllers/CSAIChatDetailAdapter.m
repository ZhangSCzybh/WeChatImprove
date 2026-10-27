#import "CSAIChatDetailAdapter.h"
#import "CSAIReplyManager.h"
#import "CSAIReplySettingsViewController.h"
#import "CSMessageNativeActionAdapter.h"
#import <UIKit/UIKit.h>
#import <objc/message.h>
#import <objc/runtime.h>

static const void *DetailKey=&DetailKey;
static const void *SectionKey=&SectionKey;
static const void *CellKey=&CellKey;
static id ReadIvar(id object,const char *name){
    Ivar ivar=class_getInstanceVariable(object_getClass(object),name);
    return ivar && ivar_getTypeEncoding(ivar)[0]=='@'?object_getIvar(object,ivar):nil;
}
static id Call(id receiver,NSString *selector,NSArray *types,NSArray *arguments){
    return CSMessageNativeSupports(receiver,selector,@"@",types)?CSMessageNativeInvoke(receiver,selector,arguments):nil;
}
static NSArray *Cells(id section){
    id cells=CSMessageActionNativeObject(section,@"getAllCells");
    if(![cells isKindOfClass:NSArray.class])cells=CSMessageActionNativeObject(section,@"cells");
    return [cells isKindOfClass:NSArray.class]?[cells copy]:nil;
}
static BOOL IsChatSearchCell(id cell){
    id config=CSMessageActionNativeObject(cell,@"cellConfig");
    if(CSMessageNativeSupports(config,@"clickAction",@":",@[])){
        SEL action=((SEL(*)(id,SEL))objc_msgSend)(config,NSSelectorFromString(@"clickAction"));
        if(action==NSSelectorFromString(@"onEditAndSearch"))return YES;
    }
    // The action is language-independent; the visible title also supports host
    // versions that route this native row through a different action handler.
    id left=CSMessageActionNativeObject(config,@"leftConfig");
    return [CSMessageActionNativeObject(left,@"title") isEqual:@"查找聊天内容"];
}
static id ChatSearchSection(NSArray *sections){
    id match=nil;
    for(id section in sections){
        NSArray *cells=Cells(section);
        for(NSUInteger row=0;row<cells.count;row++)if(IsChatSearchCell(cells[row])){
            // Append inside the search section: every existing native index path
            // stays intact, including the chatroom controller's cached paths.
            if(match || row+1!=cells.count)return nil;
            match=section;
        }
    }
    return match;
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
        if(![sections isKindOfClass:NSArray.class])return;
        sections=[sections copy];
        for(NSInteger index=(NSInteger)sections.count-1;index>=0;index--){
            id section=sections[(NSUInteger)index];
            if(objc_getAssociatedObject(section,SectionKey)==self && CSMessageNativeSupports(tableInfo,@"removeSectionAt:",@"v",@[@"Q"])){
                CSMessageNativeInvoke(tableInfo,@"removeSectionAt:",@[@(index)]);continue;
            }
            NSArray *cells=Cells(section);
            if(CSMessageNativeSupports(section,@"removeCellAt:",@"v",@[@"Q"]))for(NSInteger row=(NSInteger)cells.count-1;row>=0;row--){
                if(objc_getAssociatedObject(cells[(NSUInteger)row],CellKey)==self)CSMessageNativeInvoke(section,@"removeCellAt:",@[@(row)]);
            }
        }
        if([self current]){
            Class sectionClass=NSClassFromString(@"WCTableViewSectionManager"),cellClass=NSClassFromString(@"WCTableViewCellManager");
            BOOL group=[self.conversation hasSuffix:@"@chatroom"];
            id section=group?ChatSearchSection(sections):Call(sectionClass,@"sectionWithHeader:",@[@"@"],@[@"AI 回复"]);
            if(!group && !section)section=Call(sectionClass,@"sectionInfoHeader:",@[@"@"],@[@"AI 回复"]);
            BOOL canInsert=section && CSMessageNativeSupports(section,@"addCell:",@"v",@[@"@"]) &&
                (group?CSMessageNativeSupports(section,@"removeCellAt:",@"v",@[@"Q"]):
                 (CSMessageNativeSupports(tableInfo,@"addSection:",@"v",@[@"@"]) && CSMessageNativeSupports(tableInfo,@"removeSectionAt:",@"v",@[@"Q"])));
            CSAIReplyManager *manager=CSAIReplyManager.sharedManager;
            BOOL enabled=[manager.store.configuration[@"conversations"][self.conversation][@"enabled"] boolValue];
            id toggle=nil;
            if(group && enabled)toggle=Call(cellClass,@"switchCellForSel:target:leftImage:title:desc:on:",@[@":",@"@",@"@",@"@",@"@",@"B"],@[@"toggle:",self,NSNull.null,@"启用 AI 回复",[manager statusForConversation:self.conversation],@(enabled)]);
            if(!toggle)toggle=Call(cellClass,@"switchCellForSel:target:title:on:",@[@":",@"@",@"@",@"B"],@[@"toggle:",self,@"启用 AI 回复",@(enabled)]);
            id preset=Call(cellClass,@"normalCellForSel:target:title:rightValue:",@[@":",@"@",@"@",@"@"],@[@"choosePreset",self,@"回复预设",[manager presetNameForConversation:self.conversation]]);
            if(canInsert && toggle && preset){
                objc_setAssociatedObject(toggle,CellKey,self,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                objc_setAssociatedObject(preset,CellKey,self,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                CSMessageNativeInvoke(section,@"addCell:",@[toggle]);CSMessageNativeInvoke(section,@"addCell:",@[preset]);
                if(!group){
                    if(CSMessageNativeSupports(section,@"setFooterTitle:",@"v",@[@"@"]))CSMessageNativeInvoke(section,@"setFooterTitle:",@[[manager statusForConversation:self.conversation]]);
                    objc_setAssociatedObject(section,SectionKey,self,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                    CSMessageNativeInvoke(tableInfo,@"addSection:",@[section]);
                }
            }
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
