#import "CSBackupSettingsViewController.h"
#import "CSSettingTableViewCell.h"
#import "CSBackupManager.h"
#import "CSBackupInfo.h"
#import <Photos/Photos.h>
#import <MobileCoreServices/MobileCoreServices.h>

static NSString * const kBackupCellIdentifier = @"CSBackupCell";

@interface CSBackupSettingsViewController () <UITableViewDelegate, UITableViewDataSource, UIDocumentPickerDelegate>

@property (nonatomic, strong) NSMutableArray<CSBackupInfo *> *backupList;

@end

@implementation CSBackupSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"备份配置";
    self.tableView.backgroundColor = [UIColor systemGroupedBackgroundColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 54, 0, 0);
    
    [CSSettingTableViewCell registerToTableView:self.tableView];
    
    [self loadBackupList];
    [self setupData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadBackupList];
    [self setupData];
    [self.tableView reloadData];
}

- (void)loadBackupList {
    self.backupList = [[CSBackupManager sharedManager].getAllBackups mutableCopy];
}

- (void)setupData {
    self.sections = [NSMutableArray array];
    
    CSSettingItem *createBackupItem = [CSSettingItem actionItemWithTitle:@"创建备份"
                                                              iconName:@"plus.circle.fill"
                                                             iconColor:[UIColor systemBlueColor]];
    createBackupItem.actionBlock = ^{
        [self showCreateBackupDialog];
    };
    
    CSSettingItem *importBackupItem = [CSSettingItem actionItemWithTitle:@"导入备份"
                                                              iconName:@"square.and.arrow.down"
                                                             iconColor:[UIColor systemGreenColor]];
    importBackupItem.actionBlock = ^{
        [self showImportBackupPicker];
    };
    
    CSSettingItem *autoBackupItem = [CSSettingItem switchItemWithTitle:@"自动备份"
                                                            iconName:@"clock.arrow.circlepath"
                                                           iconColor:[UIColor systemOrangeColor]
                                                          switchValue:[CSBackupManager sharedManager].isAutoBackupEnabled
                                                     valueChangedBlock:^(BOOL isOn) {
        [[CSBackupManager sharedManager] enableAutoBackup:isOn];
    }];
    
    CSSettingSection *actionSection = [CSSettingSection sectionWithHeader:@"操作"
                                                                   items:@[createBackupItem, importBackupItem, autoBackupItem]];
    [self.sections addObject:actionSection];
    
    if (self.backupList.count > 0) {
        NSMutableArray *backupItems = [NSMutableArray array];
        
        for (CSBackupInfo *backupInfo in self.backupList) {
            NSString *detailText = [NSString stringWithFormat:@"%@ | %ld项配置",
                                    [self formatDate:backupInfo.createTime],
                                    (long)backupInfo.configCount];
            
            CSSettingItem *backupItem = [CSSettingItem itemWithTitle:backupInfo.backupName
                                                           iconName:@"doc.fill"
                                                          iconColor:backupInfo.isAutoBackup ? [UIColor systemOrangeColor] : [UIColor systemBlueColor]
                                                             detail:detailText];
            backupItem.actionBlock = ^{
                [self showBackupActionsForBackup:backupInfo];
            };
            [backupItems addObject:backupItem];
        }
        
        CSSettingSection *backupSection = [CSSettingSection sectionWithHeader:@"备份列表"
                                                                       items:backupItems];
        [self.sections addObject:backupSection];
    }
    
    CSSettingItem *infoItem = [CSSettingItem itemWithTitle:@"备份说明"
                                                iconName:@"info.circle"
                                               iconColor:[UIColor systemGrayColor]
                                                 detail:@"备份包含所有插件配置，可随时恢复"];
    
    CSSettingSection *infoSection = [CSSettingSection sectionWithHeader:@"说明"
                                                                 items:@[infoItem]];
    [self.sections addObject:infoSection];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sections[section].items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CSSettingTableViewCell reuseIdentifier]];
    
    CSSettingItem *item = self.sections[indexPath.section].items[indexPath.row];
    [cell configureWithItem:item];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sections[section].header;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return @"自动备份每天执行一次";
    }
    return nil;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CSSettingItem *item = self.sections[indexPath.section].items[indexPath.row];
    if (item.actionBlock) {
        item.actionBlock();
    }
}

#pragma mark - 创建备份

- (void)showCreateBackupDialog {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"创建备份"
                                                                   message:@"请输入备份名称和描述（可选）"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"备份名称";
        textField.text = [NSString stringWithFormat:@"备份 %@", [self formatDate:[NSDate date]]];
    }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"备份描述（可选）";
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    
    UIAlertAction *createAction = [UIAlertAction actionWithTitle:@"创建"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action) {
        UITextField *nameField = alert.textFields.firstObject;
        UITextField *descField = alert.textFields.lastObject;
        
        NSString *backupName = nameField.text.length > 0 ? nameField.text : @"未命名备份";
        NSString *description = descField.text.length > 0 ? descField.text : nil;
        
        [self createBackupWithName:backupName description:description];
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:createAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)createBackupWithName:(NSString *)backupName description:(NSString *)description {
    NSError *error = nil;
    BOOL success = [[CSBackupManager sharedManager] createBackupWithName:backupName
                                                              description:description
                                                             isAutoBackup:NO
                                                                    error:&error];
    
    if (success) {
        [self loadBackupList];
        [self setupData];
        
        [self showSuccessAlert:@"备份创建成功" message:@"请选择发送方式" completion:^(NSInteger actionType) {
            if (actionType == 1) {
                [self sendLatestBackupToFileHelper];
            } else if (actionType == 2) {
                [self sendLatestBackupToSelf];
            }
            [self.tableView reloadData];
        }];
    } else {
        NSString *errorMsg = error ? error.localizedDescription : @"未知错误";
        [self showErrorAlert:@"创建失败" message:errorMsg];
    }
}

- (void)sendLatestBackupToFileHelper {
    if (self.backupList.count == 0) {
        [self showErrorAlert:@"发送失败" message:@"没有可用的备份"];
        return;
    }
    
    CSBackupInfo *latestBackup = self.backupList.firstObject;
    NSError *error = nil;
    BOOL success = [[CSBackupManager sharedManager] sendBackupToFileHelper:latestBackup error:&error];
    
    if (success) {
        [self showSuccessAlert:@"发送成功" message:@"备份已发送到文件传输助手" completion:nil];
    } else {
        NSString *errorMsg = error ? error.localizedDescription : @"未知错误";
        [self showErrorAlert:@"发送失败" message:errorMsg];
    }
}

- (void)sendLatestBackupToSelf {
    if (self.backupList.count == 0) {
        [self showErrorAlert:@"发送失败" message:@"没有可用的备份"];
        return;
    }
    
    CSBackupInfo *latestBackup = self.backupList.firstObject;
    NSError *error = nil;
    BOOL success = [[CSBackupManager sharedManager] sendBackupToSelf:latestBackup error:&error];
    
    if (success) {
        [self showSuccessAlert:@"发送成功" message:@"备份已发送给自己" completion:nil];
    } else {
        NSString *errorMsg = error ? error.localizedDescription : @"未知错误";
        [self showErrorAlert:@"发送失败" message:errorMsg];
    }
}

#pragma mark - 备份操作

- (void)showBackupActionsForBackup:(CSBackupInfo *)backupInfo {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:backupInfo.backupName
                                                                         message:nil
                                                                  preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *restoreAction = [UIAlertAction actionWithTitle:@"恢复此备份"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
        [self restoreBackup:backupInfo];
    }];
    
    UIAlertAction *exportAction = [UIAlertAction actionWithTitle:@"导出备份"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action) {
        [self exportBackup:backupInfo];
    }];
    
    UIAlertAction *sendAction = [UIAlertAction actionWithTitle:@"发送到文件传输助手"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {
        [self sendBackupToFileHelper:backupInfo];
    }];
    
    UIAlertAction *sendToSelfAction = [UIAlertAction actionWithTitle:@"发送给自己"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction *action) {
        [self sendBackupToSelf:backupInfo];
    }];
    
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"删除备份"
                                                           style:UIAlertActionStyleDestructive
                                                         handler:^(UIAlertAction *action) {
        [self deleteBackup:backupInfo];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    
    [actionSheet addAction:restoreAction];
    [actionSheet addAction:exportAction];
    [actionSheet addAction:sendAction];
    [actionSheet addAction:sendToSelfAction];
    [actionSheet addAction:deleteAction];
    [actionSheet addAction:cancelAction];
    
    if (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        actionSheet.popoverPresentationController.sourceView = self.tableView;
        actionSheet.popoverPresentationController.sourceRect = self.tableView.bounds;
    }
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (void)restoreBackup:(CSBackupInfo *)backupInfo {
    UIAlertController *confirmAlert = [UIAlertController alertControllerWithTitle:@"确认恢复"
                                                                         message:@"恢复备份将覆盖当前所有配置，恢复后需要重启微信才能完全生效。是否继续？"
                                                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    
    UIAlertAction *restoreAction = [UIAlertAction actionWithTitle:@"恢复并重启"
                                                            style:UIAlertActionStyleDestructive
                                                          handler:^(UIAlertAction *action) {
        NSError *error = nil;
        BOOL success = [[CSBackupManager sharedManager] restoreBackup:backupInfo error:&error];
        
        if (success) {
            [self showRestartAlert];
        } else {
            NSString *errorMsg = error ? error.localizedDescription : @"未知错误";
            [self showErrorAlert:@"恢复失败" message:errorMsg];
        }
    }];
    
    [confirmAlert addAction:cancelAction];
    [confirmAlert addAction:restoreAction];
    
    [self presentViewController:confirmAlert animated:YES completion:nil];
}

- (void)exportBackup:(CSBackupInfo *)backupInfo {
    NSError *error = nil;
    NSURL *exportURL = [[CSBackupManager sharedManager] exportBackupToTempFile:backupInfo error:&error];
    
    if (!exportURL) {
        NSString *errorMsg = error ? error.localizedDescription : @"未知错误";
        [self showErrorAlert:@"导出失败" message:errorMsg];
        return;
    }
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[exportURL]
                                                                             applicationActivities:nil];
    
    if (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        activityVC.popoverPresentationController.sourceView = self.tableView;
        activityVC.popoverPresentationController.sourceRect = self.tableView.bounds;
    }
    
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (void)sendBackupToFileHelper:(CSBackupInfo *)backupInfo {
    NSError *error = nil;
    BOOL success = [[CSBackupManager sharedManager] sendBackupToFileHelper:backupInfo error:&error];
    
    if (success) {
        [self showSuccessAlert:@"发送成功" message:@"备份已发送到文件传输助手" completion:nil];
    } else {
        NSString *errorMsg = error ? error.localizedDescription : @"未知错误";
        [self showErrorAlert:@"发送失败" message:errorMsg];
    }
}

- (void)sendBackupToSelf:(CSBackupInfo *)backupInfo {
    NSError *error = nil;
    BOOL success = [[CSBackupManager sharedManager] sendBackupToSelf:backupInfo error:&error];
    
    if (success) {
        [self showSuccessAlert:@"发送成功" message:@"备份已发送给自己" completion:nil];
    } else {
        NSString *errorMsg = error ? error.localizedDescription : @"未知错误";
        [self showErrorAlert:@"发送失败" message:errorMsg];
    }
}

- (void)deleteBackup:(CSBackupInfo *)backupInfo {
    UIAlertController *confirmAlert = [UIAlertController alertControllerWithTitle:@"确认删除"
                                                                         message:@"删除后无法恢复，是否继续？"
                                                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"删除"
                                                           style:UIAlertActionStyleDestructive
                                                         handler:^(UIAlertAction *action) {
        NSError *error = nil;
        BOOL success = [[CSBackupManager sharedManager] deleteBackup:backupInfo error:&error];
        
        if (success) {
            [self loadBackupList];
            [self setupData];
            [self.tableView reloadData];
        } else {
            NSString *errorMsg = error ? error.localizedDescription : @"未知错误";
            [self showErrorAlert:@"删除失败" message:errorMsg];
        }
    }];
    
    [confirmAlert addAction:cancelAction];
    [confirmAlert addAction:deleteAction];
    
    [self presentViewController:confirmAlert animated:YES completion:nil];
}

#pragma mark - 导入备份

- (void)showImportBackupPicker {
    UIDocumentPickerViewController *documentPicker = [[UIDocumentPickerViewController alloc]
                                                      initForOpeningContentTypes:@[UTTypeData]
                                                                      asCopy:YES];
    documentPicker.delegate = self;
    documentPicker.allowsMultipleSelection = NO;
    
    [self presentViewController:documentPicker animated:YES completion:nil];
}

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls {
    if (urls.count == 0) {
        return;
    }
    
    NSURL *fileURL = urls.firstObject;
    
    NSError *error = nil;
    BOOL success = [[CSBackupManager sharedManager] importBackupFromFile:fileURL error:&error];
    
    if (success) {
        [self showSuccessAlert:@"导入成功" message:@"备份已导入，可在备份列表中查看" completion:nil];
        [self loadBackupList];
        [self setupData];
        [self.tableView reloadData];
    } else {
        NSString *errorMsg = error ? error.localizedDescription : @"未知错误";
        [self showErrorAlert:@"导入失败" message:errorMsg];
    }
}

- (void)documentPickerWasCancelled:(UIDocumentPickerViewController *)controller {
    
}

#pragma mark - 辅助方法

- (void)showSuccessAlert:(NSString *)title message:(NSString *)message completion:(void(^)(NSInteger actionType))completion {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    if (completion) {
        UIAlertAction *sendToFileHelperAction = [UIAlertAction actionWithTitle:@"发送到文件传输助手"
                                                                        style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction *action) {
            completion(1);
        }];
        
        UIAlertAction *sendToSelfAction = [UIAlertAction actionWithTitle:@"发送给自己"
                                                                  style:UIAlertActionStyleDefault
                                                                handler:^(UIAlertAction *action) {
            completion(2);
        }];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action) {
            completion(0);
        }];
        
        [alert addAction:sendToFileHelperAction];
        [alert addAction:sendToSelfAction];
        [alert addAction:okAction];
    } else {
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alert addAction:okAction];
    }
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showErrorAlert:(NSString *)title message:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showRestartAlert {
    [self.tableView reloadData];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"恢复成功"
                                                                   message:@"配置已恢复，需要重启微信才能完全应用更改。\n\n如果重启后设置仍未生效，请尝试关闭并重新打开设置界面。"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *restartAction = [UIAlertAction actionWithTitle:@"立即重启"
                                                            style:UIAlertActionStyleDestructive
                                                          handler:^(UIAlertAction *action) {
        exit(0);
    }];
    
    UIAlertAction *laterAction = [UIAlertAction actionWithTitle:@"稍后重启"
                                                          style:UIAlertActionStyleDefault
                                                        handler:nil];
    
    [alert addAction:laterAction];
    [alert addAction:restartAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (NSString *)formatDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [formatter stringFromDate:date];
}

@end
