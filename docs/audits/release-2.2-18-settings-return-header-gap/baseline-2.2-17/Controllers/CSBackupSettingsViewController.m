#import "CSBackupSettingsViewController.h"
#import "CSBackupManager.h"
#import "CSBackupPreviewViewController.h"
#import <UniformTypeIdentifiers/UniformTypeIdentifiers.h>
#import "CSNavigationTitleSettingsViewController.h"
#import "CSTabBarStyleSettingsViewController.h"
#import "CSTouchTrailViewController.h"
#import "CSContactSeparatorSettingsViewController.h"
#import "CSNativeSettingsHost.h"
#import "CSBackupSettingsCell.h"
@interface CSBackupRepairViewController : CSSettingsTableViewController
@property(nonatomic) NSArray<NSString *> *contacts;
@end
@implementation CSBackupRepairViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"修复当前的配置";
    self.tableView.backgroundColor=UIColor.systemGroupedBackgroundColor;
    self.tableView.separatorInset=UIEdgeInsetsMake(0,54,0,0);
    [CSBackupSettingsCell registerToTableView:self.tableView];
    id contacts=[NSUserDefaults.standardUserDefaults objectForKey:@"com.wechat.tweak.navigation.contact.overrides"];
    self.contacts=[contacts isKindOfClass:NSDictionary.class]?[[contacts allKeys] sortedArrayUsingSelector:@selector(compare:)]:@[];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { (void)tableView;return self.contacts.count?3:2; }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    (void)tableView;return section==0?3:(section==1&&self.contacts.count?self.contacts.count:1);
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    (void)tableView;return section==0?@"自定义图片":(section==1&&self.contacts.count?@"联系人分隔图片":@"其他设置");
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    (void)tableView;
    if(section==0)return @"在对应设置页重新选择图片，或移除无效引用，然后返回备份页重试。";
    if(section==1&&self.contacts.count)return @"按联系人分别检查分隔图片和专属设置。";
    return @"修复后可返回备份页手动创建备份，或重新预览恢复。本页不会清除配置；其他设置仍使用原有授权检查。";
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)path {
    CSSettingItem *item=nil;
    BOOL contactRow=path.section==1&&self.contacts.count;
    if(path.section==0){
        NSArray *titles=@[@"导航栏分隔图片",@"底栏图标",@"触摸轨迹图片"];
        NSArray *icons=@[@"photo",@"square.grid.2x2",@"hand.draw"];
        item=[CSSettingItem itemWithTitle:titles[path.row] iconName:icons[path.row] iconColor:UIColor.systemBlueColor detail:nil];
    }else if(contactRow){
        item=[CSSettingItem itemWithTitle:self.contacts[path.row] iconName:@"person.crop.circle" iconColor:UIColor.systemGreenColor detail:@"编辑"];
    }else{
        item=[CSSettingItem itemWithTitle:@"其他插件设置" iconName:@"gearshape" iconColor:UIColor.systemGrayColor detail:nil];
    }
    CSBackupSettingsCell *cell=[tableView dequeueReusableCellWithIdentifier:CSBackupSettingsCell.reuseIdentifier];
    [cell configureWithItem:item];cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.accessibilityTraits=UIAccessibilityTraitButton;
    if(contactRow)cell.textLabel.lineBreakMode=NSLineBreakByTruncatingMiddle;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)path {
    [tableView deselectRowAtIndexPath:path animated:YES];
    UIViewController *controller=nil;
    if(path.section==0){
        switch(path.row){
            case 0:controller=[CSNavigationTitleSettingsViewController new];break;
            case 1:controller=[CSTabBarStyleSettingsViewController new];break;
            default:controller=[CSTouchTrailViewController new];break;
        }
    }else if(path.section==1&&self.contacts.count){
        controller=[[CSContactSeparatorSettingsViewController alloc]initWithContactId:self.contacts[path.row] contactName:nil contactAvatar:nil];
    }else{
        controller=[[CSNativeSettingsControllerClass() alloc]init];
    }
    [self.navigationController pushViewController:controller animated:YES];
}
@end

@interface CSBackupSettingsViewController () <UIDocumentPickerDelegate>
@property(nonatomic) NSArray *records;
@property(nonatomic) BOOL busy;
@property(nonatomic,strong) UIActivityIndicatorView *activityIndicator;
@end
@implementation CSBackupSettingsViewController
- (void)viewDidLoad {
    [super viewDidLoad];self.title=@"备份配置";self.records=@[];
    self.tableView.backgroundColor=UIColor.systemGroupedBackgroundColor;
    self.tableView.separatorInset=UIEdgeInsetsMake(0,54,0,0);
    // Keep the navigation bar's geometry stable while asynchronous work starts/finishes.
    UIView *activityContainer=[[UIView alloc]initWithFrame:CGRectMake(0,0,32,32)];
    self.activityIndicator=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
    self.activityIndicator.frame=CGRectMake(6,6,20,20);
    self.activityIndicator.hidesWhenStopped=YES;
    self.activityIndicator.isAccessibilityElement=YES;
    self.activityIndicator.accessibilityLabel=@"正在处理，请稍候…";
    [activityContainer addSubview:self.activityIndicator];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:activityContainer];
    [CSBackupSettingsCell registerToTableView:self.tableView];[self rebuildSections];
}
- (void)viewWillAppear:(BOOL)animated {[super viewWillAppear:animated];[self reload];}
- (void)setWorking:(BOOL)working {
    self.busy=working;self.tableView.userInteractionEnabled=!working;
    if(working)[self.activityIndicator startAnimating];else [self.activityIndicator stopAnimating];
}
- (void)reload {[self setWorking:YES];[CSBackupManager.sharedManager list:^(NSArray *records,NSError *error){self.records=records?:@[];[self setWorking:NO];[self rebuildSections];[self.tableView reloadData];if(error)[self message:@"备份检查" detail:error.localizedDescription];}];}
- (void)message:(NSString *)title detail:(NSString *)message {UIAlertController *alert=[UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];[alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil]];[self presentViewController:alert animated:YES completion:nil];}
- (CSSettingItem *)action:(NSString *)title icon:(NSString *)icon color:(UIColor *)color block:(void (^)(void))block {
    // Match ordinary settings rows; Action items override the inherited title font with 17pt.
    CSSettingItem *item=[CSSettingItem itemWithTitle:title iconName:icon iconColor:color detail:nil];item.actionBlock=block;return item;
}
- (void)rebuildSections {
    __weak typeof(self) weakSelf=self;
    CSSettingItem *create=[self action:@"创建备份" icon:@"plus.circle.fill" color:UIColor.systemGreenColor block:^{[weakSelf create];}];
    CSSettingItem *import=[self action:@"导入备份" icon:@"square.and.arrow.down" color:UIColor.systemBlueColor block:^{[weakSelf importFile];}];
    NSMutableArray *backups=[NSMutableArray array];NSDateFormatter *date=[NSDateFormatter new];date.dateFormat=@"MM-dd HH:mm";
    for(NSDictionary *record in self.records){
        BOOL favorite=[record[@"metadata"][@"favorite"] boolValue];
        BOOL issue=[record[@"unavailable"] boolValue]||record[@"metadataWarning"]!=nil;
        CSSettingItem *item=[self action:record[@"metadata"][@"name"]?:record[@"name"] icon:favorite?@"star.fill":(issue?@"exclamationmark.shield.fill":@"archivebox.fill") color:(favorite||issue)?UIColor.systemOrangeColor:UIColor.systemBlueColor block:^{[weakSelf openRecord:record];}];
        item.detail=[record[@"unavailable"] boolValue]?@"原件已保留":(record[@"metadataWarning"]?@"信息待确认":[date stringFromDate:record[@"createdAt"]]);[backups addObject:item];
    }
    if(!backups.count)[backups addObject:[CSSettingItem itemWithTitle:@"暂无备份" iconName:@"archivebox" iconColor:UIColor.systemGrayColor detail:nil]];
    CSSettingItem *status=[self action:@"备份与恢复状态" icon:@"info.circle" color:UIColor.systemBlueColor block:^{[weakSelf message:@"备份与恢复状态" detail:CSBackupManager.sharedManager.status];}];
    status.detail=CSBackupManager.sharedManager.lastRestoreFailure.length?@"恢复未完成 · 查看原因":@"查看";
    CSSettingItem *retry=[self action:@"重试恢复" icon:@"arrow.clockwise" color:UIColor.systemOrangeColor block:^{[weakSelf retryRestore];}];
    CSSettingItem *repair=[self action:@"修复当前的配置" icon:@"wrench.and.screwdriver" color:UIColor.systemOrangeColor block:^{[weakSelf repair];}];
    CSSettingItem *cancel=[self action:@"取消待执行计划" icon:@"xmark.circle" color:UIColor.systemRedColor block:^{[weakSelf confirmCancel];}];
    CSSettingItem *info=[self action:@"功能说明" icon:@"questionmark.circle" color:UIColor.systemGrayColor block:^{[weakSelf message:@"备份配置说明" detail:@"点击“创建备份”保存插件配置、自定义图片、已存档账号分组和当前账号的定时任务。定时任务恢复后总开关关闭，不导入执行记录或待发送状态。仅支持当前 .wcbak 格式。点击备份可预览恢复、导出、重命名、收藏或删除。\n\n备份由你手动创建或从文件导入。修改配置、更新插件、恢复及重置均不额外创建备份，也不按数量清理历史文件。已有历史备份继续保留和管理。恢复或重置前如需保留当前完整配置，请先手动创建备份。\n\n所有备份都提供手动删除入口，包括收藏、信息待确认和无法读取的备份；无法读取的文件可先导出原件或重新检查。恢复事务正在使用的备份需先取消待执行计划或完成恢复、回滚，再删除。“重试恢复”仅处理未完成的恢复事务。\n\n导出文件未加密，可能包含成员、联系人标识和自定义文字；不包含微信消息、登录凭据或支付账本。"]; }];
    self.sections=[@[[CSSettingSection sectionWithHeader:@"备份设置" items:@[create,import]],
                     [CSSettingSection sectionWithHeader:[NSString stringWithFormat:@"本机备份 · %lu 份",(unsigned long)self.records.count] items:backups],
                     [CSSettingSection sectionWithHeader:@"恢复管理" items:@[status,retry,repair,cancel]],
                     [CSSettingSection sectionWithHeader:@"说明" items:@[info]]] mutableCopy];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {(void)tableView;return self.sections.count;}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {(void)tableView;return self.sections[section].items.count;}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {(void)tableView;return self.sections[section].header;}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    (void)tableView;
    if(section==0)return @"手动保存当前插件配置和自定义图片。恢复或重置前如需保留当前配置，请先创建备份。";
    if(section==1)return self.records.count?@"点击备份可预览恢复、分享及管理。历史文件继续保留，所有备份均可手动删除。":@"创建第一份备份，或从文件导入当前格式备份。";
    if(section==2){NSString *failure=CSBackupManager.sharedManager.lastRestoreFailure;return failure.length?[@"上次恢复未完成：\n" stringByAppendingString:failure]:@"恢复和重置在完全退出并重新打开微信后应用，切换前后台不会执行。执行前可取消待处理计划。";}
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)path {
    CSBackupSettingsCell *cell=[tableView dequeueReusableCellWithIdentifier:CSBackupSettingsCell.reuseIdentifier];
    CSSettingItem *item=self.sections[path.section].items[path.row];[cell configureWithItem:item];
    if(item.actionBlock)cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    if(!item.actionBlock&&item.itemType!=CSSettingItemTypeSwitch)cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)path {
    [tableView deselectRowAtIndexPath:path animated:YES];if(self.busy)return;
    [self.sections[path.section].items[path.row] performAction];
}
- (void)openRecord:(NSDictionary *)record {
    if([record[@"unavailable"] boolValue]){[self showUnavailableRecord:record];return;}
    [self setWorking:YES];[CSBackupManager.sharedManager load:record completion:^(NSDictionary *snapshot,NSError *error){
        [self setWorking:NO];if(error||!snapshot){
            NSMutableDictionary *unavailable=[record mutableCopy];unavailable[@"unavailable"]=@YES;
            unavailable[@"issue"]=error.localizedDescription?:@"文件校验未通过，原件已保留";
            [self showUnavailableRecord:unavailable];return;
        }
        NSUInteger row=[self.records indexOfObject:record];UIView *anchor=row!=NSNotFound?[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:1]]:self.view;
        [self showRecord:record snapshot:snapshot anchor:anchor];
    }];
}
- (void)shareURL:(NSURL *)url {
    UIActivityViewController *share=[[UIActivityViewController alloc]initWithActivityItems:@[url] applicationActivities:nil];
    share.popoverPresentationController.sourceView=self.view;share.popoverPresentationController.sourceRect=self.view.bounds;
    share.completionWithItemsHandler=^(__unused UIActivityType type,__unused BOOL complete,__unused NSArray *items,__unused NSError *error){[NSFileManager.defaultManager removeItemAtURL:url error:NULL];};
    [self presentViewController:share animated:YES completion:nil];
}
- (void)showUnavailableRecord:(NSDictionary *)record {
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:record[@"metadata"][@"name"]?:record[@"name"] message:[NSString stringWithFormat:@"%@\n\n原件已保留，可先导出或手动删除；校验通过前不能恢复。",record[@"issue"]] preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"导出原件 / 分享" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *a){
        [self setWorking:YES];[CSBackupManager.sharedManager exportOriginal:record completion:^(NSURL *url,NSError *error){[self setWorking:NO];if(error)[self message:@"导出失败" detail:error.localizedDescription];else [self shareURL:url];}];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"重新检查" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *a){[self reload];}]];
    [alert addAction:[UIAlertAction actionWithTitle:@"删除备份" style:UIAlertActionStyleDestructive handler:^(__unused UIAlertAction *a){[self deleteRecord:record];}]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    alert.popoverPresentationController.sourceView=self.view;alert.popoverPresentationController.sourceRect=self.view.bounds;
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)confirmMetadata:(NSDictionary *)record {
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"确认名称与收藏信息" message:@"这份备份的本机名称与收藏记录不完整，原件已保留。请选择是否收藏，确认后可继续重命名和管理。" preferredStyle:UIAlertControllerStyleAlert];
    for(NSNumber *favorite in @[@YES,@NO]){
        [alert addAction:[UIAlertAction actionWithTitle:favorite.boolValue?@"收藏":@"不收藏" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *a){
            NSDictionary *metadata=@{@"favorite":favorite};
            [self setWorking:YES];[CSBackupManager.sharedManager updateMetadata:metadata record:record completion:^(__unused id value,NSError *error){[self setWorking:NO];if(error)[self message:@"确认失败" detail:error.localizedDescription];else [self reload];}];
        }]];
    }
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)importFile {
    UIDocumentPickerViewController *picker=[[UIDocumentPickerViewController alloc]initForOpeningContentTypes:@[UTTypeData] asCopy:YES];picker.delegate=self;picker.allowsMultipleSelection=NO;[self presentViewController:picker animated:YES completion:nil];
}
- (void)repair {
    [self setWorking:YES];[CSBackupManager.sharedManager checkRepairAccess:^(__unused id value,NSError *error){[self setWorking:NO];if(error)[self message:@"暂时不能修复" detail:error.localizedDescription];else [self.navigationController pushViewController:[[CSBackupRepairViewController alloc]initWithStyle:UITableViewStyleInsetGrouped] animated:YES];}];
}
- (void)retryRestore {
    [self setWorking:YES];[CSBackupManager.sharedManager retryPendingWork:^(__unused id value,NSError *error){[self setWorking:NO];if(error)[self message:@"恢复仍待处理" detail:error.localizedDescription];else [self message:@"恢复检查已完成" detail:@"未完成的恢复事务已检查。尚未执行的计划仍需完全退出并重新打开微信；此操作不会创建备份。"];[self.tableView reloadData];}];
}
- (void)create {
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"创建完整备份" message:@"保存当前插件配置、图片、账号分组和当前账号的定时任务。" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *field){field.placeholder=@"名称（可留空）";}];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action){NSString *name=[alert.textFields.firstObject.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];if(!name.length){NSDateFormatter *date=[NSDateFormatter new];date.dateFormat=@"yyyy-MM-dd HH:mm";name=[@"手动备份 " stringByAppendingString:[date stringFromDate:NSDate.date]];}[self setWorking:YES];[CSBackupManager.sharedManager create:name completion:^(__unused id value,NSError *error){[self setWorking:NO];if(error)[self message:@"保存失败" detail:error.localizedDescription];else [self reload];}];}]];[self presentViewController:alert animated:YES completion:nil];
}
- (void)confirmCancel {
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"取消待执行计划" message:@"保留当前配置和已有备份。已开始但未完成的事务必须先回滚。" preferredStyle:UIAlertControllerStyleAlert];[alert addAction:[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:nil]];[alert addAction:[UIAlertAction actionWithTitle:@"取消计划" style:UIAlertActionStyleDestructive handler:^(__unused UIAlertAction *a){[self setWorking:YES];[CSBackupManager.sharedManager cancelPending:^(__unused id result,NSError *error){[self setWorking:NO];if(error)[self message:@"无法取消" detail:error.localizedDescription];else [self reload];}];}]];[self presentViewController:alert animated:YES completion:nil];
}
- (void)showRecord:(NSDictionary *)record snapshot:(NSDictionary *)snapshot anchor:(UIView *)anchor {
    NSDateFormatter *date=[NSDateFormatter new];date.dateStyle=NSDateFormatterMediumStyle;date.timeStyle=NSDateFormatterShortStyle;
    NSString *kind=@{@"manual":@"手动备份",@"automatic":@"历史配置备份",@"protection":@"历史操作保护备份",@"upgrade":@"历史版本备份",@"imported":@"导入备份"}[snapshot[@"kind"]]?:@"备份";
    NSString *message=[NSString stringWithFormat:@"%@ · %@\n来源版本 %@ · %lu 项配置 · %lu 张图片%@",kind,[date stringFromDate:snapshot[@"createdAt"]],snapshot[@"source"][@"pluginVersion"],(unsigned long)[snapshot[@"fields"] count],(unsigned long)[snapshot[@"assets"] count],[snapshot[@"warnings"] count]?[@"\n" stringByAppendingString:[snapshot[@"warnings"] componentsJoinedByString:@"\n"]]:@""];
    if(record[@"metadataWarning"])message=[message stringByAppendingFormat:@"\n\n%@",record[@"metadataWarning"]];
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:record[@"metadata"][@"name"]?:snapshot[@"name"] message:message preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"预览恢复" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *a){[self.navigationController pushViewController:[[CSBackupPreviewViewController alloc]initWithSnapshot:snapshot] animated:YES];}]];
    [alert addAction:[UIAlertAction actionWithTitle:@"导出到文件 / 分享" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *a){[self setWorking:YES];[CSBackupManager.sharedManager exportSnapshot:snapshot completion:^(NSURL *url,NSError *error){[self setWorking:NO];if(error)[self message:@"导出失败" detail:error.localizedDescription];else [self shareURL:url];}];}]];
    if(record[@"metadataWarning"]){
        [alert addAction:[UIAlertAction actionWithTitle:@"确认名称与收藏信息" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *a){[self confirmMetadata:record];}]];
    }else {
        [alert addAction:[UIAlertAction actionWithTitle:@"重命名" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *a){[self renameRecord:record];}]];
        BOOL favorite=[record[@"metadata"][@"favorite"] boolValue];[alert addAction:[UIAlertAction actionWithTitle:favorite?@"取消收藏":@"收藏" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *a){NSDictionary *metadata=@{@"favorite":favorite?@NO:@YES};[self setWorking:YES];[CSBackupManager.sharedManager updateMetadata:metadata record:record completion:^(__unused id value,NSError *error){[self setWorking:NO];if(error)[self message:@"修改失败" detail:error.localizedDescription];else [self reload];}];}]];
    }
    [alert addAction:[UIAlertAction actionWithTitle:@"删除备份" style:UIAlertActionStyleDestructive handler:^(__unused UIAlertAction *a){[self deleteRecord:record];}]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];alert.popoverPresentationController.sourceView=anchor?:self.view;alert.popoverPresentationController.sourceRect=(anchor?:self.view).bounds;[self presentViewController:alert animated:YES completion:nil];
}
- (void)renameRecord:(NSDictionary *)record {
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"重命名本机备份" message:@"仅修改本机显示名称，原始快照信息保留。" preferredStyle:UIAlertControllerStyleAlert];[alert addTextFieldWithConfigurationHandler:^(UITextField *field){field.text=record[@"metadata"][@"name"]?:record[@"name"];}];[alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];[alert addAction:[UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *a){NSString *name=[alert.textFields.firstObject.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];if(!name.length||name.length>128){[self message:@"名称无效" detail:@"请输入 1–128 个字符。"] ;return;}NSDictionary *metadata=@{@"name":name};[self setWorking:YES];[CSBackupManager.sharedManager updateMetadata:metadata record:record completion:^(__unused id value,NSError *error){[self setWorking:NO];if(error)[self message:@"修改失败" detail:error.localizedDescription];else [self reload];}];}]];[self presentViewController:alert animated:YES completion:nil];
}
- (void)deleteRecord:(NSDictionary *)record {
    BOOL favorite=[record[@"metadata"][@"favorite"] boolValue];
    NSString *message=favorite?@"这份备份已收藏。确认后会删除备份及其本机名称与收藏记录，当前配置保持不变。":@"只删除所选备份及其本机名称与收藏记录，不改变当前配置。";
    if([record[@"unavailable"] boolValue])message=[@"这份备份目前无法读取，删除后原件无法找回，建议先导出原件。\n\n" stringByAppendingString:message];
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:favorite?@"删除这份收藏备份？":@"删除这份备份？" message:message preferredStyle:UIAlertControllerStyleAlert];[alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];[alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(__unused UIAlertAction *a){[self setWorking:YES];[CSBackupManager.sharedManager remove:record completion:^(__unused id value,NSError *error){[self setWorking:NO];if(error)[self message:@"删除失败" detail:error.localizedDescription];else [self reload];}];}]];[self presentViewController:alert animated:YES completion:nil];
}
- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls {(void)controller;if(!urls.count)return;[self setWorking:YES];[CSBackupManager.sharedManager importURL:urls.firstObject completion:^(__unused id value,NSError *error){[self setWorking:NO];if(error)[self message:@"导入失败" detail:error.localizedDescription];else [self reload];}];}
@end
