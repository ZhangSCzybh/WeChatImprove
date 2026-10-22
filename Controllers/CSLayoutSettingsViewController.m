//
// CSLayoutSettingsViewController.m
// 布局和字体设置界面实现
//

#import "CSLayoutSettingsViewController.h"
#import "CSSettingTableViewCell.h"

static NSString * const kPreferencesSuiteName = @"com.wechat.enhance";
static NSString * const kChatFontSizeKey = @"font.chat_size";
static NSString * const kGlobalScaleKey = @"global.scale";

static const CGFloat kMinChatFontSize = 8.0;
static const CGFloat kMaxChatFontSize = 25.0;
static const CGFloat kDefaultChatFontSize = 17.0;

static const CGFloat kMinGlobalScale = 0.5;
static const CGFloat kMaxGlobalScale = 2.0;
static const CGFloat kDefaultGlobalScale = 1.0;

static NSUserDefaults *getDefaults() {
    static NSUserDefaults *defaults = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaults = [[NSUserDefaults alloc] initWithSuiteName:kPreferencesSuiteName];
    });
    return defaults;
}

@interface CSLayoutSettingsViewController ()

@property (nonatomic, strong) NSArray<CSSettingSection *> *sections;
@property (nonatomic, strong) CSSettingItem *chatFontSizeItem;
@property (nonatomic, strong) CSSettingItem *globalScaleItem;

@property (nonatomic, assign) CGFloat chatFontSize;
@property (nonatomic, assign) CGFloat globalScale;

@end

@implementation CSLayoutSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"布局字体设置";
    self.tableView.backgroundColor = [UIColor systemGroupedBackgroundColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 54, 0, 0);
    
    [CSSettingTableViewCell registerToTableView:self.tableView];
    
    [self loadCurrentSettings];
    [self setupData];
}

- (void)loadCurrentSettings {
    NSUserDefaults *defaults = getDefaults();
    
    self.chatFontSize = [defaults floatForKey:kChatFontSizeKey];
    if (self.chatFontSize < kMinChatFontSize || self.chatFontSize > kMaxChatFontSize) {
        self.chatFontSize = kDefaultChatFontSize;
    }
    
    self.globalScale = [defaults floatForKey:kGlobalScaleKey];
    if (self.globalScale < kMinGlobalScale || self.globalScale > kMaxGlobalScale) {
        self.globalScale = kDefaultGlobalScale;
    }
}

- (void)setupData {
    NSMutableArray *items = [NSMutableArray array];
    
    NSString *chatSizeDetail = [NSString stringWithFormat:@"%.1f", self.chatFontSize];
    self.chatFontSizeItem = [CSSettingItem itemWithTitle:@"聊天界面字体"
                                                iconName:@"bubble.left.and.bubble.right"
                                               iconColor:[UIColor systemBlueColor]
                                                 detail:chatSizeDetail];
    [items addObject:self.chatFontSizeItem];
    
    NSString *globalScaleDetail = [NSString stringWithFormat:@"%.2f", self.globalScale];
    self.globalScaleItem = [CSSettingItem itemWithTitle:@"全局缩放比例"
                                              iconName:@"arrow.up.left.and.arrow.down.right"
                                             iconColor:[UIColor systemGreenColor]
                                               detail:globalScaleDetail];
    [items addObject:self.globalScaleItem];
    
    CSSettingSection *mainSection = [CSSettingSection sectionWithHeader:@"设置"
                                                                items:items];
    
    CSSettingItem *resetItem = [CSSettingItem actionItemWithTitle:@"恢复默认设置"
                                                        iconName:@"arrow.counterclockwise"
                                                       iconColor:[UIColor systemRedColor]];
    
    CSSettingSection *resetSection = [CSSettingSection sectionWithHeader:@"重置"
                                                                  items:@[resetItem]];
    
    CSSettingItem *tipItem1 = [CSSettingItem itemWithTitle:@"聊天界面字体"
                                                iconName:@"info.circle"
                                               iconColor:[UIColor systemGrayColor]
                                                 detail:@"范围：8.0-25.0，默认17.0"];
    
    CSSettingItem *tipItem2 = [CSSettingItem itemWithTitle:@"全局缩放比例"
                                                iconName:@"info.circle"
                                               iconColor:[UIColor systemGrayColor]
                                                 detail:@"范围：0.5-2.0，默认1.0"];
    
    CSSettingSection *tipSection = [CSSettingSection sectionWithHeader:@"说明"
                                                               items:@[tipItem1, tipItem2]];
    
    self.sections = @[mainSection, resetSection, tipSection];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sections[section].items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CSSettingTableViewCell reuseIdentifier]
                                                                forIndexPath:indexPath];
    
    CSSettingItem *item = self.sections[indexPath.section].items[indexPath.row];
    [cell configureWithItem:item];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sections[section].header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CSSettingItem *item = self.sections[indexPath.section].items[indexPath.row];
    
    if (item == self.chatFontSizeItem) {
        [self showChatFontSizeInputAlert];
    } else if (item == self.globalScaleItem) {
        [self showGlobalScaleInputAlert];
    } else if ([item.title isEqualToString:@"恢复默认设置"]) {
        [self resetToDefaultSettings];
    }
}

- (void)showChatFontSizeInputAlert {
    NSString *title = @"聊天界面字体";
    NSString *message = [NSString stringWithFormat:@"请输入字体大小 (%.1f ~ %.1f)", kMinChatFontSize, kMaxChatFontSize];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.keyboardType = UIKeyboardTypeDecimalPad;
        textField.text = [NSString stringWithFormat:@"%.1f", self.chatFontSize];
        textField.placeholder = [NSString stringWithFormat:@"%.1f", kDefaultChatFontSize];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
        UITextField *textField = alert.textFields.firstObject;
        NSString *inputText = textField.text;
        
        CGFloat fontSize = [inputText floatValue];
        
        if (fontSize < kMinChatFontSize) {
            fontSize = kMinChatFontSize;
        } else if (fontSize > kMaxChatFontSize) {
            fontSize = kMaxChatFontSize;
        }
        
        self.chatFontSize = fontSize;
        
        NSUserDefaults *defaults = getDefaults();
        [defaults setFloat:fontSize forKey:kChatFontSizeKey];
        [defaults synchronize];
        
        self.chatFontSizeItem.detail = [NSString stringWithFormat:@"%.1fpt", fontSize];
        
        [self.tableView reloadData];
        
        [self sendSettingsChangedNotification];
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:confirmAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showGlobalScaleInputAlert {
    NSString *title = @"全局缩放比例";
    NSString *message = [NSString stringWithFormat:@"请输入缩放比例 (%.2f ~ %.2f)", kMinGlobalScale, kMaxGlobalScale];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.keyboardType = UIKeyboardTypeDecimalPad;
        textField.text = [NSString stringWithFormat:@"%.2f", self.globalScale];
        textField.placeholder = [NSString stringWithFormat:@"%.2f", kDefaultGlobalScale];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
        UITextField *textField = alert.textFields.firstObject;
        NSString *inputText = textField.text;
        
        CGFloat scale = [inputText floatValue];
        
        if (scale < kMinGlobalScale) {
            scale = kMinGlobalScale;
        } else if (scale > kMaxGlobalScale) {
            scale = kMaxGlobalScale;
        }
        
        self.globalScale = scale;
        
        NSUserDefaults *defaults = getDefaults();
        [defaults setFloat:scale forKey:kGlobalScaleKey];
        [defaults synchronize];
        
        self.globalScaleItem.detail = [NSString stringWithFormat:@"%.2f", scale];
        
        [self.tableView reloadData];
        
        [self sendSettingsChangedNotification];
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:confirmAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)resetToDefaultSettings {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认重置"
                                                                   message:@"确定要恢复默认设置吗？"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定"
                                                            style:UIAlertActionStyleDestructive
                                                          handler:^(UIAlertAction *action) {
        NSUserDefaults *defaults = getDefaults();
        
        self.chatFontSize = kDefaultChatFontSize;
        self.globalScale = kDefaultGlobalScale;
        
        [defaults setFloat:kDefaultChatFontSize forKey:kChatFontSizeKey];
        [defaults setFloat:kDefaultGlobalScale forKey:kGlobalScaleKey];
        [defaults synchronize];
        
        self.chatFontSizeItem.detail = [NSString stringWithFormat:@"%.1fpt", kDefaultChatFontSize];
        self.globalScaleItem.detail = [NSString stringWithFormat:@"%.2f", kDefaultGlobalScale];
        
        [self.tableView reloadData];
        
        [self sendSettingsChangedNotification];
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:confirmAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)sendSettingsChangedNotification {
    CFNotificationCenterPostNotification(
        CFNotificationCenterGetDarwinNotifyCenter(),
        CFSTR("com.wechat.enhance.settings_changed"),
        NULL,
        NULL,
        true
    );
}

@end
