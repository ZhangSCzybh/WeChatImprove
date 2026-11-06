#import "CSImageStickerSettingsViewController.h"
#import "CSSettingTableViewCell.h"
#import "CSMessageActionPreferences.h"

@interface CSImageStickerSettingsViewController ()
@property(nonatomic, copy) NSArray<CSSettingSection *> *sections;
@end

@implementation CSImageStickerSettingsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"表情功能";
    self.tableView.backgroundColor = UIColor.systemGroupedBackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 54, 0, 0);
    [CSSettingTableViewCell registerToTableView:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSUserDefaults *defaults = NSUserDefaults.standardUserDefaults;
    CSSettingItem *enabled = [CSSettingItem switchItemWithTitle:@"图片添加到表情"
        iconName:@"face.smiling" iconColor:UIColor.systemOrangeColor
        switchValue:[defaults boolForKey:CSMessageActionImageStickerEnabledKey]
        valueChangedBlock:^(BOOL isOn) {
            [defaults setBool:isOn forKey:CSMessageActionImageStickerEnabledKey];
            [CSMessageActionPreferences.sharedPreferences requestRefresh];
        }];
    self.sections = @[[CSSettingSection sectionWithHeader:@"功能设置" items:@[enabled]]];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { return self.sections.count; }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { return self.sections[section].items.count; }
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section { return self.sections[section].header; }
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return @"开启后，长按会话中的图片，选择“添加到表情”。添加过程仅使用微信原生提示，可在自定义表情列表中查看。";
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)path {
    CSSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSSettingTableViewCell.reuseIdentifier forIndexPath:path];
    [cell configureWithItem:self.sections[path.section].items[path.row]];
    return cell;
}
@end
