#import "CSBackupPreviewViewController.h"
#import "CSBackupManager.h"
#import "CSBackupRegistry.h"
#import "CSBackupSettingsCell.h"
@interface CSBackupPreviewViewController ()
@property(nonatomic) NSDictionary *snapshot;
@property(nonatomic) NSDictionary *preview;
@property(nonatomic) NSArray *modules;
@property(nonatomic) NSArray *accounts;
@property(nonatomic) NSMutableSet *selectedModules;
@property(nonatomic) NSMutableSet *selectedAccounts;
@property(nonatomic) NSString *message;
@property(nonatomic) NSUInteger generation;
@property(nonatomic) BOOL busy;
@property(nonatomic) BOOL resetting;
@end
@implementation CSBackupPreviewViewController
- (instancetype)initWithSnapshot:(NSDictionary *)snapshot {if((self=[super initWithStyle:UITableViewStyleInsetGrouped]))_snapshot=snapshot;return self;}
- (void)viewDidLoad {
    [super viewDidLoad];self.resetting=[self.snapshot[@"operation"] isEqual:@"reset"];
    self.title=self.resetting?@"预览重置":@"预览恢复";self.message=@"正在检查当前配置…";
    self.tableView.backgroundColor=UIColor.systemGroupedBackgroundColor;
    self.tableView.separatorInset=UIEdgeInsetsMake(0,54,0,0);
    [CSBackupSettingsCell registerToTableView:self.tableView];
    NSMutableSet *modules=[NSMutableSet set],*accounts=[NSMutableSet set];
    for(NSDictionary *f in self.snapshot[@"fields"]){NSDictionary *entry=[CSBackupRegistry entryForDomain:f[@"domain"] key:f[@"key"]];[modules addObject:entry[@"module"]];if([f[@"key"] isEqual:@"com.wechat.enhance.chat_group.account_profiles"]&&[f[@"value"] isKindOfClass:NSDictionary.class])[accounts addObjectsFromArray:[f[@"value"] allKeys]];}
    if([self.snapshot[@"source"][@"accounts"] isKindOfClass:NSArray.class])[accounts addObjectsFromArray:self.snapshot[@"source"][@"accounts"]];
    NSString *current=[CSBackupManager.sharedManager currentContext][@"account"];
    if(current.length)[accounts addObject:current];self.modules=[modules.allObjects sortedArrayUsingSelector:@selector(compare:)];self.accounts=[accounts.allObjects sortedArrayUsingSelector:@selector(compare:)];
    self.selectedModules=[modules mutableCopy];self.selectedAccounts=[NSMutableSet set];if(current.length)[self.selectedAccounts addObject:current];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:self.resetting?@"准备重置":@"准备恢复" style:UIBarButtonItemStyleDone target:self action:@selector(confirm)];[self refreshPreview];
}
- (void)refreshPreview {
    NSUInteger generation=++self.generation;self.busy=YES;self.preview=nil;self.message=@"正在检查当前配置…";self.navigationItem.rightBarButtonItem.enabled=NO;[self.tableView reloadData];
    [CSBackupManager.sharedManager preview:self.snapshot modules:self.selectedModules.copy accounts:self.selectedAccounts.copy completion:^(NSDictionary *preview,NSError *error){
        if(generation!=self.generation)return;self.busy=NO;self.preview=preview;self.message=error.localizedDescription?:[preview[@"warnings"] componentsJoinedByString:@"\n\n"];if(error){UIAlertController *failure=[UIAlertController alertControllerWithTitle:self.resetting?@"无法预览重置":@"无法预览恢复" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];[failure addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil]];if(!self.presentedViewController)[self presentViewController:failure animated:YES completion:nil];}self.navigationItem.rightBarButtonItem.enabled=preview!=nil&&[preview[@"changes"] count]>0;[self.tableView reloadData];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {(void)tableView;return 4;}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {(void)tableView;return section==0?(self.resetting?3:6):(section==1?self.modules.count:(section==2?MAX(1,self.accounts.count):MAX(1,[self.preview[@"changes"] count])));}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    (void)tableView;
    if(section==1)return [NSString stringWithFormat:@"选择模块 · 已选 %lu 项",(unsigned long)self.selectedModules.count];
    if(section==2)return [NSString stringWithFormat:@"选择原所属账号 · 已选 %lu 个",(unsigned long)self.selectedAccounts.count];
    return section==0?(self.resetting?@"重置概览":@"恢复概览"):@"变更明细";
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    (void)tableView;
    if(section==0)return self.message.length?self.message:@"未选中的模块和账号保持当前配置。";
    if(section==2)return @"默认选择当前账号。其他账号的分组始终归属原账号；联系人和群关系仅支持同一本机、同一当前账号操作。";
    if(section==3)return self.resetting?@"准备重置前保存可读取的配置和图片。已丢失图片无法找回；重启前配置变化会使计划失效。":@"准备恢复前保存当前配置作为保护备份。重新打开微信时应用；期间配置变化会使计划失效。";
    return nil;
}
- (NSString *)changeDescription:(NSDictionary *)change {
    NSString *key=change[@"key"];
    NSDictionary *labels=@{@"com.wechat.enhance.redenvelop.autoReceive":@"自动领取红包",@"com.wechat.enhance.redenvelop.autoReplyEnable":@"红包自动回复",@"kReceiveTransferAutoEnableKey":@"自动收款",@"kReceiveTransferAutoReplyEnableKey":@"收款自动回复",@"com.wechat.enhance.chat_group.account_profiles":@"账号分组和成员"};
    NSString *label=labels[key]?:@"配置项";id before=change[@"before"][@"value"],after=change[@"after"][@"value"];
    if([change[@"reset"] boolValue])return [label stringByAppendingString:@"：恢复未设置状态，使用插件默认值。"];
    if([after isKindOfClass:NSNumber.class])return [NSString stringWithFormat:@"%@：%@ → %@",label,before?:@"未设置",after];
    if([key isEqual:@"com.wechat.enhance.chat_group.account_profiles"]){
        NSMutableArray *removed=[NSMutableArray array];for(NSString *account in before){NSMutableSet *ids=[NSMutableSet set];for(NSDictionary *tab in after[account][@"customTabs"])[ids addObject:tab[@"id"]];for(NSDictionary *tab in before[account][@"customTabs"])if(![ids containsObject:tab[@"id"]])[removed addObject:tab[@"name"]];}
        return removed.count?[NSString stringWithFormat:@"账号分组将更新；移除分组：%@",[removed componentsJoinedByString:@"、"]]:@"更新所选账号的分组、成员和排序";
    }
    if([after isKindOfClass:NSString.class]&&![after hasPrefix:@"csbackup:"])return [NSString stringWithFormat:@"%@：%@",label,[after length]>160?[[after substringToIndex:160]stringByAppendingString:@"…"]:after];
    return [label stringByAppendingString:@"：替换为备份中的值"];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)path {
    CSSettingItem *item=nil;BOOL checked=NO,selectable=NO;
    if(path.section==0){
        NSString *title=nil,*detail=nil,*icon=nil;
        NSInteger selectionRow=self.resetting?path.row:path.row-3;
        if(!self.resetting&&path.row==0){title=@"备份名称";detail=self.snapshot[@"name"];icon=@"archivebox";selectable=YES;}
        else if(!self.resetting&&path.row==1){NSDateFormatter *date=[NSDateFormatter new];date.dateFormat=@"MM-dd HH:mm";title=@"创建时间";detail=[date stringFromDate:self.snapshot[@"createdAt"]];icon=@"calendar";selectable=YES;}
        else if(!self.resetting&&path.row==2){title=@"自定义图片";detail=[NSString stringWithFormat:@"%lu 张",(unsigned long)[self.snapshot[@"assets"] count]];icon=@"photo";}
        else if(selectionRow==0){title=@"已选模块";detail=[NSString stringWithFormat:@"%lu 项",(unsigned long)self.selectedModules.count];icon=@"square.stack.3d.up";}
        else if(selectionRow==1){title=@"已选账号";detail=[NSString stringWithFormat:@"%lu 个",(unsigned long)self.selectedAccounts.count];icon=@"person.crop.circle";}
        else{title=@"变更数量";detail=self.busy?@"检查中":(self.preview?[NSString stringWithFormat:@"%lu 项",(unsigned long)[self.preview[@"changes"] count]]:@"检查失败");icon=@"slider.horizontal.3";}
        item=[CSSettingItem itemWithTitle:title iconName:icon iconColor:UIColor.systemBlueColor detail:detail];
    }else if(path.section==1){
        NSString *module=self.modules[path.row];checked=[self.selectedModules containsObject:module];selectable=YES;
        item=[CSSettingItem itemWithTitle:CSBackupRegistry.moduleTitles[module]?:module iconName:@"slider.horizontal.3" iconColor:UIColor.systemBlueColor detail:nil];
    }else if(path.section==2){
        if(self.accounts.count){NSString *account=self.accounts[path.row];checked=[self.selectedAccounts containsObject:account];selectable=YES;
            item=[CSSettingItem itemWithTitle:account iconName:@"person.crop.circle" iconColor:UIColor.systemGreenColor detail:[account isEqual:[CSBackupManager.sharedManager currentContext][@"account"]]?@"当前账号":nil];
        }else item=[CSSettingItem itemWithTitle:@"账号尚未就绪" iconName:@"person.crop.circle" iconColor:UIColor.systemGrayColor detail:nil];
    }else{
        NSArray *changes=self.preview[@"changes"];
        if(changes.count){NSDictionary *change=changes[path.row];selectable=YES;item=[CSSettingItem itemWithTitle:CSBackupRegistry.moduleTitles[change[@"module"]] iconName:@"arrow.triangle.2.circlepath" iconColor:UIColor.systemOrangeColor detail:[change[@"reset"] boolValue]?@"恢复默认":@"更新配置"];}
        else item=[CSSettingItem itemWithTitle:self.busy?@"正在检查…":(self.preview?@"所选范围没有差异":@"暂时无法预览") iconName:@"info.circle" iconColor:UIColor.systemGrayColor detail:nil];
    }
    CSBackupSettingsCell *cell=[tableView dequeueReusableCellWithIdentifier:CSBackupSettingsCell.reuseIdentifier];[cell configureWithItem:item];
    cell.selectionStyle=selectable?UITableViewCellSelectionStyleDefault:UITableViewCellSelectionStyleNone;
    if((path.section==0||path.section==3)&&selectable)cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    if(path.section==1||path.section==2){cell.accessoryType=checked?UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryNone;cell.accessibilityTraits=(selectable?UIAccessibilityTraitButton:UIAccessibilityTraitNone)|(checked?UIAccessibilityTraitSelected:0);}
    else cell.accessibilityTraits=selectable?UIAccessibilityTraitButton:UIAccessibilityTraitNone;
    if(path.section==2)cell.textLabel.lineBreakMode=NSLineBreakByTruncatingMiddle;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)path {
    [tableView deselectRowAtIndexPath:path animated:YES];
    if(path.section==0&&!self.resetting&&path.row<2){
        NSDateFormatter *date=[NSDateFormatter new];date.dateStyle=NSDateFormatterLongStyle;date.timeStyle=NSDateFormatterMediumStyle;
        NSString *detail=path.row==0?self.snapshot[@"name"]:[date stringFromDate:self.snapshot[@"createdAt"]];
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:path.row==0?@"备份名称":@"创建时间" message:detail preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil]];[self presentViewController:alert animated:YES completion:nil];return;
    }
    if(path.section==3&&[self.preview[@"changes"] count]){NSDictionary *change=self.preview[@"changes"][path.row];UIAlertController *alert=[UIAlertController alertControllerWithTitle:CSBackupRegistry.moduleTitles[change[@"module"]] message:[self changeDescription:change] preferredStyle:UIAlertControllerStyleAlert];[alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil]];[self presentViewController:alert animated:YES completion:nil];return;}
    if((path.section!=1&&path.section!=2)||(path.section==2&&!self.accounts.count))return;NSMutableSet *selected=path.section==1?self.selectedModules:self.selectedAccounts;NSString *value=(path.section==1?self.modules:self.accounts)[path.row];if([selected containsObject:value])[selected removeObject:value];else [selected addObject:value];[tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];[self refreshPreview];
}
- (void)confirm {
    if(self.busy||!self.preview||![self.preview[@"changes"] count])return;
    NSString *verb=self.resetting?@"重置":@"恢复";
    NSString *message=self.resetting?@"先保存可读取的配置和图片作为保护备份，再生成重置计划。已丢失的图片无法找回。请随后手动退出并重新打开微信。":@"先保存恢复前保护备份，再生成待执行计划。请随后手动退出并重新打开微信。";
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"准备%@所选配置",verb] message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:[@"准备" stringByAppendingString:verb] style:UIAlertActionStyleDestructive handler:^(__unused UIAlertAction *action){
        self.busy=YES;self.tableView.userInteractionEnabled=NO;self.navigationItem.rightBarButtonItem.enabled=NO;
        [CSBackupManager.sharedManager prepare:self.preview completion:^(__unused id result,NSError *error){
            self.busy=NO;self.tableView.userInteractionEnabled=YES;
            UIAlertController *resultAlert=[UIAlertController alertControllerWithTitle:error?[@"未能准备" stringByAppendingString:verb]:[verb stringByAppendingString:@"已准备"] message:error.localizedDescription?:@"计划已保存，尚未应用。请完全退出微信进程后重新打开；切换前后台不会执行。执行前可在备份页取消计划。" preferredStyle:UIAlertControllerStyleAlert];
            [resultAlert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *a){if(!error)[self.navigationController popViewControllerAnimated:YES];else [self refreshPreview];}]];[self presentViewController:resultAlert animated:YES completion:nil];
        }];
    }]];[self presentViewController:alert animated:YES completion:nil];
}
@end
