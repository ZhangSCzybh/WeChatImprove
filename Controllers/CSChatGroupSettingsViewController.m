#import "CSChatGroupSettingsViewController.h"
#import "WESessionTabItem.h"
#import "CSGroupPreferences.h"
#import "CSGroupAppearance.h"

extern NSString *CSGroupCurrentAccountID(void);
#import "CSSettingTableViewCell.h"
#import "WEContactSelectViewController.h"
#import "CSNativeContactPicker.h"
#import "CSSettingsPresentation.h"
#import "CSCloseFriendBridge.h"
#import "CSGroupNativeBridge.h"
#import "CSServiceCenter.h"
#import <objc/runtime.h>
#import <objc/message.h>

static NSString * const kChatGroupEnabledKey = @"com.wechat.enhance.chat_group.enabled";
static NSString * const kIndicatorColorKey = @"com.wechat.enhance.chat_group.indicator_color";
static NSString * const kIndicatorColorDarkKey = @"com.wechat.enhance.chat_group.indicator_color_dark";
static NSString * const kSelectedTextColorKey = @"com.wechat.enhance.chat_group.selected_text_color";
static NSString * const kSelectedTextColorDarkKey = @"com.wechat.enhance.chat_group.selected_text_color_dark";
static NSString * const kHapticFeedbackKey = @"com.wechat.enhance.chat_group.haptic_feedback";
static NSString * const kSwipeGestureEnabledKey = @"com.wechat.enhance.chat_group.swipe_gesture_enabled";
static NSString * const kHideGroupBadgeKey = @"com.wechat.enhance.chat_group.hide_group_badge";
static NSString * const kHideAllBadgeKey = @"com.wechat.enhance.chat_group.hide_all_badge";
static NSString * const kScrollSensitivityKey = @"com.wechat.enhance.scroll_sensitivity";

@interface WEColorPreviewView : UIView
@property (nonatomic, strong) UIColor *previewColor;
@end

@implementation WEColorPreviewView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = frame.size.height / 2;
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    return self;
}

- (void)setPreviewColor:(UIColor *)previewColor {
    _previewColor = previewColor;
    self.backgroundColor = previewColor;
}

@end

@interface CSChatGroupSettingsViewController () <UITableViewDataSource, UITableViewDelegate, UIColorPickerViewControllerDelegate>
@property (nonatomic, weak) UIAlertAction *fontSizeSaveAction;

@property (nonatomic, strong) NSArray<CSSettingSection *> *sections;
@property (nonatomic, strong) NSMutableArray<WESessionTabItem *> *customTabs;
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSString *> *presetTabNames;
@property (nonatomic, strong) NSMutableArray<NSString *> *tabOrder;
@property (nonatomic, strong) NSMutableSet<NSString *> *hiddenPresetTabs;
@property (nonatomic, strong) WEColorPreviewView *indicatorColorPreview;
@property (nonatomic, strong) WEColorPreviewView *selectedTextColorPreview;
@property (nonatomic, assign) NSInteger currentColorType;
@property (nonatomic, strong) CSGroupPreferences *groupPreferences;
@property (nonatomic, strong) NSTimer *accountCheckTimer;

@end

@implementation CSChatGroupSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"聊天分组";
    self.tableView.backgroundColor = [UIColor systemGroupedBackgroundColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 54, 0, 0);
    
    [CSSettingTableViewCell registerToTableView:self.tableView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"排序"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(editButtonTapped)];
    
    self.indicatorColorPreview = [[WEColorPreviewView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
    self.selectedTextColorPreview = [[WEColorPreviewView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
    
    [self loadAccountPreferences];
    [self setupData];
    for (NSString *name in @[CSCloseFriendPolicyDidChangeNotification,@"CSBackupAccountChanged"])
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(contactSelectionPolicyChanged:) name:name object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshAccountIfNeeded];
    __weak typeof(self) weakSelf = self;
    [self.accountCheckTimer invalidate];
    self.accountCheckTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer *timer) {
        [weakSelf refreshAccountIfNeeded];
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.accountCheckTimer invalidate];
    self.accountCheckTimer = nil;
}

- (void)dealloc { [_accountCheckTimer invalidate]; [NSNotificationCenter.defaultCenter removeObserver:self]; }

- (void)contactSelectionPolicyChanged:(NSNotification *)notification {
    CSNativeContactPickerRevalidate(self);
}

- (void)copyAccountPreferences {
    self.customTabs = [self.groupPreferences.customTabs mutableCopy];
    self.presetTabNames = [self.groupPreferences.presetNames mutableCopy];
    self.tabOrder = [self.groupPreferences.tabOrder mutableCopy];
    self.hiddenPresetTabs = [self.groupPreferences.hiddenPresetTabs mutableCopy];
}

- (void)loadAccountPreferences {
    self.groupPreferences = [[CSGroupPreferences alloc] initWithDefaults:[NSUserDefaults standardUserDefaults]
                                                             accountID:CSGroupCurrentAccountID()];
    [self copyAccountPreferences];
}

- (BOOL)refreshAccountIfNeeded {
    NSString *current = CSGroupCurrentAccountID();
    NSString *loaded = self.groupPreferences.accountID;
    if ((current.length == 0 && loaded.length == 0) || [current isEqualToString:loaded]) return NO;
    [self loadAccountPreferences];
    [self.tableView setEditing:NO animated:NO];
    self.navigationItem.rightBarButtonItem.title = @"排序";
    [self setupData];
    [self.tableView reloadData];
    return YES;
}

// Every deferred group mutation validates the account and then resolves its stable ID.
- (BOOL)canEditAccount:(NSString *)accountID {
    [self refreshAccountIfNeeded];
    if (!accountID.length || ![accountID isEqualToString:self.groupPreferences.accountID]) return NO;
    // Another adapter/settings instance may have edited this same account meanwhile.
    [self.groupPreferences reload];
    [self copyAccountPreferences];
    return YES;
}

- (WESessionTabItem *)customTabWithID:(NSString *)tabID {
    for (WESessionTabItem *tab in self.customTabs) if ([tab.tabId isEqualToString:tabID]) return tab;
    return nil;
}

- (void)saveAccountPreferences {
    // Mutations already reloaded at their action boundary. Preserve that proposed edit here;
    // the preferences layer rejects it if another writer changed the profile in between.
    if ([self refreshAccountIfNeeded] || !self.groupPreferences.accountID.length) return;
    if (![self.groupPreferences saveCustomTabs:self.customTabs presetNames:self.presetTabNames
                                    tabOrder:self.tabOrder hiddenPresetTabs:self.hiddenPresetTabs]) {
        [self.groupPreferences reload];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"未能保存分组"
            message:@"已保留原有配置，请稍后重试。" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    [self copyAccountPreferences];
    [self reloadChatGroupSettings];
}

- (void)saveHiddenPresetTabs { [self saveAccountPreferences]; }
- (void)saveTabOrder { [self saveAccountPreferences]; }
- (void)savePresetTabNames { [self saveAccountPreferences]; }
- (void)saveCustomTabs { [self saveAccountPreferences]; }

- (void)showLegacyImportAlert {
    NSString *accountID = [self.groupPreferences.accountID copy];
    if (![self canEditAccount:accountID]) return;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"导入旧分组到当前账号"
        message:@"旧分组没有账号归属。确认后将合并到当前登录账号，保留现有分组和原始旧配置。"
        preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"导入" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if (![self canEditAccount:accountID]) return;
        BOOL saved = [self.groupPreferences importLegacy];
        [self copyAccountPreferences];
        [self setupData];
        [self.tableView reloadData];
        if (saved) [self reloadChatGroupSettings];
        else {
            UIAlertController *failure = [UIAlertController alertControllerWithTitle:@"未能导入"
                message:@"原始旧配置已保留，请稍后重试。" preferredStyle:UIAlertControllerStyleAlert];
            [failure addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:failure animated:YES completion:nil];
        }
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)reloadChatGroupSettings {
    CFNotificationCenterPostNotification(
        CFNotificationCenterGetDarwinNotifyCenter(),
        CFSTR("com.wechat.enhance.chat_group.settings_changed"),
        NULL,
        NULL,
        true
    );
}

- (void)setupData {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    __weak typeof(self) weakSelf = self;
    NSString *accountID = [self.groupPreferences.accountID copy];
    
    CSSettingItem *enableItem = [CSSettingItem switchItemWithTitle:@"启用聊天分组"
                                                         iconName:@"rectangle.grid.1x2"
                                                        iconColor:[UIColor systemIndigoColor]
                                                      switchValue:[defaults boolForKey:kChatGroupEnabledKey]
                                                valueChangedBlock:^(BOOL isOn) {
        [defaults setBool:isOn forKey:kChatGroupEnabledKey];
        [defaults synchronize];
        
        [weakSelf reloadChatGroupSettings];
    }];
    
    NSMutableArray<CSSettingItem *> *groupItems = [NSMutableArray array];
    
    NSDictionary *presetTabsDict = @{
        @"preset_0": [WESessionTabItem tabWithType:WETabTypeAll],
        @"preset_1": [WESessionTabItem tabWithType:WETabTypeGroup],
        @"preset_2": [WESessionTabItem tabWithType:WETabTypePrivate],
        @"preset_3": [WESessionTabItem tabWithType:WETabTypeOfficial]
    };
    
    NSDictionary *customTabsDict = [NSDictionary dictionaryWithObjects:self.customTabs
                                                               forKeys:[self.customTabs valueForKeyPath:@"tabId"]];
    
    for (NSString *tabId in self.tabOrder) {
        WESessionTabItem *tab = nil;
        NSString *detailText = nil;
        UIColor *iconColor = nil;
        
        if ([tabId hasPrefix:@"preset_"]) {
            tab = presetTabsDict[tabId];
            BOOL isHidden = [self.hiddenPresetTabs containsObject:tabId];
            detailText = isHidden ? @"预设 (已隐藏)" : @"预设";
            iconColor = [UIColor systemGrayColor];
        } else {
            tab = customTabsDict[tabId];
            if (!tab) continue;
            detailText = [NSString stringWithFormat:@"自定义 (%ld个会话)", (long)tab.sessionUserNames.count];
            iconColor = [UIColor systemOrangeColor];
        }
        
        if (!tab) continue;
        
        NSString *customName = self.presetTabNames[tabId];
        NSString *displayName = customName.length > 0 ? customName : tab.displayName;
        
        CSSettingItem *tabItem = [CSSettingItem itemWithTitle:displayName
                                                    iconName:@"folder"
                                                   iconColor:iconColor
                                                      detail:detailText];
        tabItem.actionBlock = nil;
        
        [groupItems addObject:tabItem];
    }
    
    CSSettingItem *addTabItem = [CSSettingItem itemWithTitle:@"添加自定义组"
                                                   iconName:@"plus.circle"
                                                  iconColor:[UIColor systemBlueColor]
                                                     detail:@""];
    addTabItem.actionBlock = ^{
        [weakSelf showAddCustomTabAlert];
    };
    
    [groupItems addObject:addTabItem];
    if (self.groupPreferences.hasLegacyData) {
        CSSettingItem *importItem = [CSSettingItem itemWithTitle:@"导入旧分组到当前账号"
            iconName:@"square.and.arrow.down" iconColor:[UIColor systemBlueColor]
            detail:accountID.length ? @"合并并保留旧配置" : @"当前账号尚未确认"];
        importItem.actionBlock = ^{ [weakSelf showLegacyImportAlert]; };
        [groupItems addObject:importItem];
    }
    
    CSSettingItem *fontSizeItem = [CSSettingItem itemWithTitle:@"分组标签字号"
                                                   iconName:@"textformat.size"
                                                  iconColor:[UIColor systemBlueColor]
                                                     detail:[NSString stringWithFormat:@"%ld pt", (long)CSGroupTabFontSize(defaults)]];
    fontSizeItem.actionBlock = ^{ [weakSelf showTabFontSizePicker]; };

    CSSettingItem *searchButtonItem = [CSSettingItem switchItemWithTitle:@"分组搜索按钮"
                                                              iconName:@"magnifyingglass"
                                                             iconColor:[UIColor systemBlueColor]
                                                           switchValue:CSGroupSearchButtonVisible(defaults)
                                                     valueChangedBlock:^(BOOL isOn) {
        [defaults setBool:isOn forKey:CSGroupSearchButtonVisibleKey];
        [defaults synchronize];
        [weakSelf reloadChatGroupSettings];
    }];

    self.indicatorColorPreview.previewColor = [self currentIndicatorColor];
    CSSettingItem *indicatorColorItem = [CSSettingItem itemWithTitle:@"指示器背景色"
                                                           iconName:@"rectangle"
                                                          iconColor:[self currentIndicatorColor]
                                                             detail:@""];
    indicatorColorItem.actionBlock = ^{
        weakSelf.currentColorType = 0;
        [weakSelf showColorPicker];
    };
    
    self.selectedTextColorPreview.previewColor = [self currentSelectedTextColor];
    CSSettingItem *selectedTextColorItem = [CSSettingItem itemWithTitle:@"选中文本颜色"
                                                              iconName:@"textformat"
                                                             iconColor:[self currentSelectedTextColor]
                                                                detail:@""];
    selectedTextColorItem.actionBlock = ^{
        weakSelf.currentColorType = 1;
        [weakSelf showColorPicker];
    };
    
    CSSettingItem *indicatorAnimationItem = [CSSettingItem itemWithTitle:@"分组切换动画"
        iconName:@"wand.and.stars" iconColor:[UIColor systemPurpleColor]
        detail:CSGroupIndicatorStyleName(CSGroupCurrentIndicatorStyle(defaults))];
    indicatorAnimationItem.actionBlock = ^{ [weakSelf showIndicatorStylePicker]; };

    NSString *hapticDetail = [self hapticFeedbackName];
    CSSettingItem *hapticFeedbackItem = [CSSettingItem itemWithTitle:@"分组切换触感"
                                                           iconName:@"hand.tap"
                                                          iconColor:[UIColor systemPurpleColor]
                                                             detail:hapticDetail];
    hapticFeedbackItem.actionBlock = ^{
        [weakSelf showHapticFeedbackPicker];
    };
    
    CSSettingItem *filterDuplicateItem = [CSSettingItem switchItemWithTitle:@"过滤重复会话"
                                                                  iconName:@"person.crop.circle.badge.minus"
                                                                 iconColor:[UIColor systemRedColor]
                                                               switchValue:self.groupPreferences.filterDuplicates
                                                         valueChangedBlock:^(BOOL isOn) {
        if (![weakSelf canEditAccount:accountID]) return;
        weakSelf.groupPreferences.filterDuplicates = isOn;
        [weakSelf copyAccountPreferences];
        [weakSelf setupData];
        [weakSelf.tableView reloadData];
        [weakSelf reloadChatGroupSettings];
    }];
    
    CSSettingItem *swipeGestureItem = [CSSettingItem switchItemWithTitle:@"分组切换手势"
                                                               iconName:@"arrow.left.arrow.right"
                                                              iconColor:[UIColor systemBlueColor]
                                                            switchValue:[defaults boolForKey:kSwipeGestureEnabledKey]
                                                      valueChangedBlock:^(BOOL isOn) {
        [defaults setBool:isOn forKey:kSwipeGestureEnabledKey];
        [defaults synchronize];
        
        [weakSelf reloadChatGroupSettings];
    }];
    
    CSSettingItem *hideGroupBadgeItem = [CSSettingItem switchItemWithTitle:@"隐藏分组角标"
                                                                 iconName:@"rectangle.badge.minus"
                                                                iconColor:[UIColor systemOrangeColor]
                                                              switchValue:[defaults boolForKey:kHideGroupBadgeKey]
                                                        valueChangedBlock:^(BOOL isOn) {
        [defaults setBool:isOn forKey:kHideGroupBadgeKey];
        [defaults synchronize];
        
        [weakSelf reloadChatGroupSettings];
    }];
    
    CSSettingItem *hideAllBadgeItem = [CSSettingItem switchItemWithTitle:@"隐藏全部角标"
                                                               iconName:@"rectangle.badge.minus"
                                                              iconColor:[UIColor systemPinkColor]
                                                            switchValue:[defaults boolForKey:kHideAllBadgeKey]
                                                      valueChangedBlock:^(BOOL isOn) {
        [defaults setBool:isOn forKey:kHideAllBadgeKey];
        [defaults synchronize];
        
        [weakSelf reloadChatGroupSettings];
    }];
    
    NSString *sensitivityDetail = [self scrollSensitivityName];
    CSSettingItem *scrollSensitivityItem = [CSSettingItem itemWithTitle:@"滑动灵敏速度"
                                                              iconName:@"slider.horizontal.3"
                                                             iconColor:[UIColor systemCyanColor]
                                                                detail:sensitivityDetail];
    scrollSensitivityItem.actionBlock = ^{
        [weakSelf showScrollSensitivityPicker];
    };
    
    CSSettingItem *infoItem = [CSSettingItem itemWithTitle:@"分组功能说明"
                                                 iconName:@"info.circle"
                                                iconColor:[UIColor systemBlueColor]
                                                   detail:@"点击查看"];
    infoItem.actionBlock = ^{
        [weakSelf showInfoAlert];
    };
    
    CSSettingSection *mainSection = [CSSettingSection sectionWithHeader:@"功能设置"
                                                                 items:@[enableItem]];
    
    CSSettingSection *groupSection = [CSSettingSection sectionWithHeader:@"分组列表"
                                                                  items:groupItems];
    
    CSSettingSection *otherSection = [CSSettingSection sectionWithHeader:@"其他设置"
                                                                  items:@[fontSizeItem, searchButtonItem, indicatorColorItem, selectedTextColorItem, indicatorAnimationItem, hapticFeedbackItem, filterDuplicateItem, swipeGestureItem, hideGroupBadgeItem, hideAllBadgeItem, scrollSensitivityItem]];
    
    CSSettingSection *infoSection = [CSSettingSection sectionWithHeader:@""
                                                                  items:@[infoItem]];
    
    self.sections = @[mainSection, groupSection, otherSection, infoSection];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sections[section].items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSSettingItem *item = self.sections[indexPath.section].items[indexPath.row];
    CSSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CSSettingTableViewCell reuseIdentifier] forIndexPath:indexPath];
    [cell configureWithItem:item];
    
    if ([item.title isEqualToString:@"指示器背景色"]) {
        cell.accessoryView = self.indicatorColorPreview;
    } else if ([item.title isEqualToString:@"选中文本颜色"]) {
        cell.accessoryView = self.selectedTextColorPreview;
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sections[section].header;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return @"开启后，聊天列表顶部将显示会话分组，可快速切换查看不同类型的会话，在列表安全更新后生效";
    } else if (section == 1) {
        if (!self.groupPreferences.accountID.length) return @"当前账号尚未确认，账号分组暂不可编辑；确认登录账号后将自动载入。";
        return @"点击右上角\"排序\"可拖拽调整分组顺序，左滑可编辑或隐藏或删除";
    } else if (section == 2){
        return @"分组标签字号：默认 18 pt，可自定义 12–28 pt，并随系统文字大小缩放。\n显示分组栏搜索按钮：开启时使用标签栏右侧搜索入口，收起聊天列表整块原生搜索区域（含背景、留白和占位）；关闭时恢复。\n添加分组：请在本页点击“添加自定义分组”。\n过滤重复会话：开启后分组内的好友、群聊将不会出现在私信和群列表，在列表安全更新后生效。\n分组切换手势：在会话区域左侧 85% 起手横滑可切换分组；从会话右侧 15% 起手左滑可展开原生菜单。按手指落点区分，滑动中途不改变用途；菜单展开时暂停切组。分组栏也支持横滑，标签过多时优先滚动标签。\n隐藏分组角标：隐藏除\"全部\"外的其他分组角标。\n隐藏全部角标：隐藏\"全部\"分组的角标。\n滑动灵敏度：建议默认，相对流畅。\n分组指示器切换动画：可选下划线、胶囊包裹或关闭，升级沿用原开关状态。下划线保留移动伸展；胶囊按下时立即以 Neo 的0.12秒 EaseOut预览，仅背景微扩至1.08×1.04，标题和角标不缩放；松手沿用单次选择，取消或滑出标签时恢复；选中及横滑过渡沿用0.28秒，背景直接使用指示器颜色，标题使用选中文本颜色。关闭后保留下划线并直接落位。遵循系统减弱动态效果。";
    } else {
        return nil;
    }
}

#pragma mark - Tab Appearance Settings

- (void)showIndicatorStylePicker {
    NSUserDefaults *defaults = NSUserDefaults.standardUserDefaults;
    CSGroupIndicatorStyle current = CSGroupCurrentIndicatorStyle(defaults);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"分组指示器切换动画"
        message:@"下划线：保留原有移动与伸展效果。\n胶囊包裹：按下立即以 Neo 的0.12秒 EaseOut预览，仅背景微扩至1.08×1.04，标题和角标不缩放；松手单次选择，取消或滑出标签时恢复。选中及横滑过渡沿用0.28秒。\n指示器颜色直接控制下划线或胶囊背景，选中文本颜色控制标题；深浅色分别设置。\n关闭：保留下划线，切换时直接落位。"
        preferredStyle:UIAlertControllerStyleActionSheet];
    __weak typeof(self) weakSelf = self;
    for (NSNumber *value in @[@(CSGroupIndicatorStyleUnderline), @(CSGroupIndicatorStyleCapsule), @(CSGroupIndicatorStyleNone)]) {
        CSGroupIndicatorStyle style = value.integerValue;
        NSString *name = CSGroupIndicatorStyleName(style);
        if (style == current) name = [name stringByAppendingString:@" ✓"];
        [alert addAction:[UIAlertAction actionWithTitle:name style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action) {
            CSGroupSetIndicatorStyle(defaults, style);
            [defaults synchronize];
            [weakSelf reloadChatGroupSettings];
            [weakSelf setupData];
            [weakSelf.tableView reloadData];
        }]];
    }
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    alert.popoverPresentationController.sourceView = self.view;
    alert.popoverPresentationController.sourceRect = CGRectMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds), 1, 1);
    alert.popoverPresentationController.permittedArrowDirections = 0;
    [self presentViewController:alert animated:YES completion:nil];
}

- (NSInteger)parsedTabFontSize:(NSString *)text {
    NSString *trimmed = [text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    if (!trimmed.length) return NSNotFound;
    NSScanner *scanner = [NSScanner scannerWithString:trimmed];
    NSInteger size = 0;
    if (![scanner scanInteger:&size] || !scanner.isAtEnd || size < CSGroupMinTabFontSize || size > CSGroupMaxTabFontSize)
        return NSNotFound;
    return size;
}

- (void)tabFontSizeInputChanged:(UITextField *)field {
    self.fontSizeSaveAction.enabled = [self parsedTabFontSize:field.text] != NSNotFound;
}

- (void)saveTabFontSize:(NSInteger)size {
    NSUserDefaults *defaults = NSUserDefaults.standardUserDefaults;
    if (size == CSGroupDefaultTabFontSize) [defaults removeObjectForKey:CSGroupTabFontSizeKey];
    else [defaults setInteger:size forKey:CSGroupTabFontSizeKey];
    [defaults synchronize];
    [self setupData];
    [self.tableView reloadData];
    [self reloadChatGroupSettings];
}

- (void)showTabFontSizePicker {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"分组标签字号"
        message:[NSString stringWithFormat:@"输入 %ld–%ld 之间的整数字号，默认 %ld pt。标签也会随系统文字大小适当缩放。",
            (long)CSGroupMinTabFontSize, (long)CSGroupMaxTabFontSize, (long)CSGroupDefaultTabFontSize]
        preferredStyle:UIAlertControllerStyleAlert];
    __weak typeof(self) weakSelf = self;
    [alert addTextFieldWithConfigurationHandler:^(UITextField *field) {
        field.keyboardType = UIKeyboardTypeNumberPad;
        field.text = [NSString stringWithFormat:@"%ld", (long)CSGroupTabFontSize(NSUserDefaults.standardUserDefaults)];
        field.placeholder = @"12–28";
        field.accessibilityLabel = @"分组标签字号";
        [field addTarget:weakSelf action:@selector(tabFontSizeInputChanged:) forControlEvents:UIControlEventEditingChanged];
    }];
    __weak UIAlertController *weakAlert = alert;
    UIAlertAction *save = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action) {
        CSChatGroupSettingsViewController *self = weakSelf;
        if (!self) return;
        NSInteger size = [self parsedTabFontSize:weakAlert.textFields.firstObject.text];
        if (size != NSNotFound) [self saveTabFontSize:size];
    }];
    self.fontSizeSaveAction = save;
    [alert addAction:save];
    [alert addAction:[UIAlertAction actionWithTitle:@"恢复默认" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action) {
        [weakSelf saveTabFontSize:CSGroupDefaultTabFontSize];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Color Settings

- (UIColor *)storedColorForKey:(NSString *)key {
    id data=[NSUserDefaults.standardUserDefaults objectForKey:key];
    if ([data isKindOfClass:NSData.class]) {
        @try {
            id color=[NSKeyedUnarchiver unarchivedObjectOfClass:UIColor.class fromData:data error:nil];
            if ([color isKindOfClass:UIColor.class]) return color;
        } @catch (__unused NSException *exception) {}
    }
    return [UIColor colorWithRed:0.102 green:0.678 blue:0.098 alpha:1.0];
}

- (UIColor *)currentIndicatorColor {
    return [self storedColorForKey:[self isDarkMode] ? kIndicatorColorDarkKey : kIndicatorColorKey];
}

- (UIColor *)currentSelectedTextColor {
    return [self storedColorForKey:[self isDarkMode] ? kSelectedTextColorDarkKey : kSelectedTextColorKey];
}

- (BOOL)isDarkMode {
    return self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark;
}

- (void)showColorPicker {
    NSString *title = self.currentColorType == 0 ? @"指示器背景色" : @"选中文本颜色";
    UIColor *currentColor = self.currentColorType == 0 ? [self currentIndicatorColor] : [self currentSelectedTextColor];
    
    UIColorPickerViewController *colorPicker = [[UIColorPickerViewController alloc] init];
    colorPicker.delegate = self;
    colorPicker.selectedColor = currentColor;
    colorPicker.title = title;
    colorPicker.supportsAlpha = YES;
    [self presentViewController:colorPicker animated:YES completion:nil];
}

#pragma mark - UIColorPickerViewControllerDelegate

- (void)colorPickerViewControllerDidFinish:(UIColorPickerViewController *)viewController {
    UIColor *selectedColor = viewController.selectedColor;
    
    NSString *colorKey = nil;
    if (self.currentColorType == 0) {
        colorKey = [self isDarkMode] ? kIndicatorColorDarkKey : kIndicatorColorKey;
        self.indicatorColorPreview.previewColor = selectedColor;
    } else {
        colorKey = [self isDarkMode] ? kSelectedTextColorDarkKey : kSelectedTextColorKey;
        self.selectedTextColorPreview.previewColor = selectedColor;
    }
    
    [self saveColor:selectedColor forKey:colorKey];
    [self setupData];
    [self.tableView reloadData];
}

- (void)colorPickerViewControllerDidSelectColor:(UIColorPickerViewController *)viewController {
    UIColor *selectedColor = viewController.selectedColor;
    
    if (self.currentColorType == 0) {
        self.indicatorColorPreview.previewColor = selectedColor;
    } else {
        self.selectedTextColorPreview.previewColor = selectedColor;
    }
}

- (void)saveColor:(UIColor *)color forKey:(NSString *)key {
    if (![color isKindOfClass:UIColor.class]) return;
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:color requiringSecureCoding:YES error:nil];
    if (!data) return;
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self reloadChatGroupSettings];
}

#pragma mark - Haptic Feedback

- (NSInteger)hapticFeedbackValue {
    NSInteger value = [[NSUserDefaults standardUserDefaults] integerForKey:kHapticFeedbackKey];
    return value;
}

- (NSString *)hapticFeedbackName {
    NSInteger value = [self hapticFeedbackValue];
    switch (value) {
        case 0:
            return @"无";
        case 1:
            return @"舒适";
        case 2:
            return @"轻柔";
        case 3:
            return @"中度";
        case 4:
            return @"重度";
        default:
            return @"无";
    }
}

- (void)showHapticFeedbackPicker {
    NSInteger currentValue = [self hapticFeedbackValue];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"切换触感"
                                                                   message:@"选择切换Tab时的触感反馈强度"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    NSArray<NSString *> *options = @[@"无", @"舒适", @"轻柔", @"中度", @"重度"];
    __weak typeof(self) weakSelf = self;
    
    for (NSInteger i = 0; i < options.count; i++) {
        NSString *title = options[i];
        if (i == currentValue) {
            title = [title stringByAppendingString:@" ✓"];
        }
        
        NSInteger index = i;
        [alert addAction:[UIAlertAction actionWithTitle:title
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction *action) {
            [[NSUserDefaults standardUserDefaults] setInteger:index forKey:kHapticFeedbackKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [weakSelf reloadChatGroupSettings];
            [weakSelf setupData];
            [weakSelf.tableView reloadData];
        }]];
    }
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Edit Mode

- (void)editButtonTapped {
    if ([self refreshAccountIfNeeded] || !self.groupPreferences.accountID.length) return;
    if (!self.tableView.editing) {
        [self.groupPreferences reload];
        [self copyAccountPreferences];
        [self setupData];
        [self.tableView reloadData];
    }
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    
    if (self.tableView.editing) {
        self.navigationItem.rightBarButtonItem.title = @"完成";
    } else {
        self.navigationItem.rightBarButtonItem.title = @"排序";
        [self saveTabOrder];
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section != 1 || !self.groupPreferences.accountID.length) return NO;
    
    NSInteger totalTabs = self.tabOrder.count;
    return indexPath.row < totalTabs;
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    if (proposedDestinationIndexPath.section != 1) {
        return sourceIndexPath;
    }
    
    NSInteger totalTabs = self.tabOrder.count;
    if (proposedDestinationIndexPath.row >= totalTabs) {
        return [NSIndexPath indexPathForRow:totalTabs - 1 inSection:1];
    }
    
    return proposedDestinationIndexPath;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    if ([self refreshAccountIfNeeded] || !self.groupPreferences.accountID.length) return;
    if (sourceIndexPath.section != 1 || destinationIndexPath.section != 1) return;
    if (sourceIndexPath.row >= self.tabOrder.count || destinationIndexPath.row >= self.tabOrder.count) return;
    
    NSString *movedTabId = self.tabOrder[sourceIndexPath.row];
    [self.tabOrder removeObjectAtIndex:sourceIndexPath.row];
    [self.tabOrder insertObject:movedTabId atIndex:destinationIndexPath.row];
    
    [self setupData];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self refreshAccountIfNeeded]) return;
    
    if (indexPath.section == 1) {
        NSInteger totalTabs = self.tabOrder.count;
        if (indexPath.row < totalTabs) {
            NSString *tabId = self.tabOrder[indexPath.row];
            
            if (![tabId hasPrefix:@"preset_"]) {
                NSDictionary *customTabsDict = [NSDictionary dictionaryWithObjects:self.customTabs
                                                                           forKeys:[self.customTabs valueForKeyPath:@"tabId"]];
                WESessionTabItem *tab = customTabsDict[tabId];
                
                if (tab) {
                    [self showContactSelectForTab:tab];
                    return;
                }
            }
        }
    }
    
    CSSettingItem *item = self.sections[indexPath.section].items[indexPath.row];
    if (item.actionBlock) {
        item.actionBlock();
    }
}

- (BOOL (^)(void))contactSelectionValidatorForTab:(WESessionTabItem *)tab {
    NSString *accountID = [self.groupPreferences.accountID copy];
    NSString *tabID = [tab.tabId copy];
    if (![self canEditAccount:accountID]) return ^BOOL { return NO; };
    tab=[self customTabWithID:tabID];
    if (!tab) return ^BOOL { return NO; };
    CSGroupPreferences *preferences=self.groupPreferences;
    NSUInteger epoch=CSCloseFriendAccountEpoch(),revision=CSCloseFriendCurrentSnapshot().revision;
    __weak typeof(self) weakSelf=self;
    __block BOOL current=YES;
    return [^BOOL {
        // reload preserves tab objects only while definitions are unchanged.
        // Identity rejects deletion/recreation and edits by another settings instance;
        // the account epoch also rejects A -> B -> A during a pending selection.
        current=current && weakSelf && epoch==CSCloseFriendAccountEpoch() &&
            revision==CSCloseFriendCurrentSnapshot().revision && !CSCloseFriendCurrentSnapshot().blocked &&
            [weakSelf canEditAccount:accountID] && weakSelf.groupPreferences==preferences &&
            [weakSelf customTabWithID:tabID]==tab;
        return current;
    } copy];
}

- (BOOL)contactName:(NSString *)name belongsToNativeGroups:(BOOL)groups {
    if (![name isKindOfClass:NSString.class] || !name.length || [name hasSuffix:@"@chatroom"]!=groups ||
        [name isEqual:self.groupPreferences.accountID]) return NO;
    if (groups) return YES;
    id manager=CSGetService(NSClassFromString(@"CContactMgr"));
    for (NSString *getter in @[@"getContactByName:",@"getContactByNameFromDB:",@"getContactForSearchByName:"]) {
        SEL selector=NSSelectorFromString(getter);
        if (!CSCloseFriendMethodMatches(class_getInstanceMethod([manager class],selector),"@@:@")) continue;
        @try {
            id contact=((id(*)(id,SEL,id))objc_msgSend)(manager,selector,name);
            if ([CSGroupReadObject(contact,@"m_nsUsrName") isEqual:name])
                return CSGroupCategoryForContact(contact)==CSGroupRowCategoryPrivate;
        } @catch (__unused NSException *exception) {}
    }
    return NO; // Unresolved existing members must survive opening/finishing a picker.
}

- (void)showContactSelectForTab:(WESessionTabItem *)tab {
    BOOL (^isValid)(void)=[self contactSelectionValidatorForTab:tab];
    if (!isValid() || !CSSettingsCanPresentFrom(self)) return;
    tab=[self customTabWithID:tab.tabId];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择类型"
                                                                   message:@"请选择要添加的会话类型"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    __weak typeof(self) weakSelf = self;
    __weak UIAlertController *weakAlert=alert;
    NSArray *titles=@[@"私聊",@"群聊",@"标签"];
    NSArray *types=@[@(WEContactSelectTypePrivate),@(WEContactSelectTypeGroup),@(WEContactSelectTypeTag)];
    for (NSUInteger index=0;index<titles.count;index++) {
        WEContactSelectType type=[types[index] integerValue];
        [alert addAction:[UIAlertAction actionWithTitle:titles[index] style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action) {
            CSSettingsAfterDismissingSheet(weakAlert,^{
                if (!isValid() || !CSSettingsCanPresentFrom(weakSelf)) return;
                if (type==WEContactSelectTypeTag) [weakSelf showTagSelectForTab:tab];
                else [weakSelf presentContactSelectWithType:type tab:tab tagName:nil];
            });
        }]];
    }
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showTagSelectForTab:(WESessionTabItem *)tab {
    // Let WeChat own the label list and its member-selection callback. Search
    // and individual checkmarks stay in the shared native friend picker.
    [self presentContactSelectWithType:WEContactSelectTypeTag tab:tab tagName:nil];
}

- (void)presentContactSelectWithType:(WEContactSelectType)selectType tab:(WESessionTabItem *)tab tagName:(NSString *)tagName {
    NSString *tabID = [tab.tabId copy];
    BOOL (^isValid)(void)=[self contactSelectionValidatorForTab:tab];
    if (!isValid() || !CSSettingsCanPresentFrom(self)) return;
    tab = [self customTabWithID:tabID];
    if (selectType!=WEContactSelectTypePrivate && selectType!=WEContactSelectTypeGroup && selectType!=WEContactSelectTypeTag) return;
    BOOL groups=selectType==WEContactSelectTypeGroup;
    NSMutableArray *preselected=[NSMutableArray array],*preserved=[NSMutableArray array];
    for (NSString *name in tab.sessionUserNames) {
        if (![name isKindOfClass:NSString.class] || !name.length) continue;
        // Native lists return only their own category. Preserve the rest of this
        // mixed group's membership, including self/service/unresolved contacts.
        NSMutableArray *destination=[self contactName:name belongsToNativeGroups:groups] ? preselected : preserved;
        [destination addObject:name];
    }
    __weak typeof(self) weakSelf = self;
    void (^save)(NSArray<NSString *> *) = ^(NSArray<NSString *> *selectedUserNames) {
        if (!isValid()) return;
        WESessionTabItem *current = [weakSelf customTabWithID:tabID];
        if (!current) return;
        NSMutableSet *names=[NSMutableSet setWithArray:preserved];
        for (NSString *name in selectedUserNames)
            if ([name isKindOfClass:NSString.class] && name.length) [names addObject:name];
        current.sessionUserNames = [names.allObjects sortedArrayUsingSelector:@selector(compare:)];
        current.updateTime = [NSDate date];
        [weakSelf saveCustomTabs];
        [weakSelf setupData];
        [weakSelf.tableView reloadData];
    };

    NSError *error=nil;
    BOOL presented=selectType==WEContactSelectTypeTag
        ? CSNativeContactPickerPresentTags(self,tab.displayName,preselected,isValid,save,&error)
        : CSNativeContactPickerPresent(self,tab.displayName,groups,preselected,isValid,save,&error);
    if (!presented) {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"无法选择会话"
            message:error.localizedDescription?:@"当前无法打开微信原生选择器，原有分组成员已保留。" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        if (CSSettingsCanPresentFrom(self)) [self presentViewController:alert animated:YES completion:nil];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section != 1 || !self.groupPreferences.accountID.length) return NO;
    
    NSInteger totalTabs = self.tabOrder.count;
    return indexPath.row < totalTabs;
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView leadingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self refreshAccountIfNeeded] || !self.groupPreferences.accountID.length) return nil;
    if (indexPath.section != 1 || indexPath.row >= self.tabOrder.count) return nil;
    NSString *accountID = [self.groupPreferences.accountID copy];
    NSString *tabID = [self.tabOrder[indexPath.row] copy];
    __weak typeof(self) weakSelf = self;
    if ([tabID hasPrefix:@"preset_"]) {
        WESessionTabItem *tab = [WESessionTabItem tabWithType:(WETabType)[[tabID substringFromIndex:7] integerValue]];
        BOOL hidden = [self.hiddenPresetTabs containsObject:tabID];
        UIContextualAction *rename = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"重命名"
            handler:^(UIContextualAction *action, UIView *view, void (^done)(BOOL)) {
                if (![weakSelf canEditAccount:accountID]) { done(NO); return; }
                [weakSelf showEditPresetTabAlertWithTabId:tabID defaultName:tab.displayName];
                done(YES);
            }];
        rename.backgroundColor = [UIColor systemBlueColor];
        UIContextualAction *toggle = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:hidden ? @"显示" : @"隐藏"
            handler:^(UIContextualAction *action, UIView *view, void (^done)(BOOL)) {
                if (![weakSelf canEditAccount:accountID]) { done(NO); return; }
                if ([weakSelf.hiddenPresetTabs containsObject:tabID]) [weakSelf.hiddenPresetTabs removeObject:tabID];
                else [weakSelf.hiddenPresetTabs addObject:tabID];
                [weakSelf saveHiddenPresetTabs];
                [weakSelf setupData];
                [weakSelf.tableView reloadData];
                done(YES);
            }];
        toggle.backgroundColor = hidden ? [UIColor systemGreenColor] : [UIColor systemOrangeColor];
        return [UISwipeActionsConfiguration configurationWithActions:@[toggle, rename]];
    }
    if (![self customTabWithID:tabID]) return nil;
    UIContextualAction *rename = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"重命名"
        handler:^(UIContextualAction *action, UIView *view, void (^done)(BOOL)) {
            if (![weakSelf canEditAccount:accountID] || ![weakSelf customTabWithID:tabID]) { done(NO); return; }
            [weakSelf showEditCustomTabAlertWithTabID:tabID];
            done(YES);
        }];
    rename.backgroundColor = [UIColor systemBlueColor];
    UIContextualAction *remove = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"删除"
        handler:^(UIContextualAction *action, UIView *view, void (^done)(BOOL)) {
            if (![weakSelf canEditAccount:accountID]) { done(NO); return; }
            WESessionTabItem *target = [weakSelf customTabWithID:tabID];
            if (!target) { done(NO); return; }
            UIAlertController *confirm = [UIAlertController alertControllerWithTitle:@"确认删除"
                message:[NSString stringWithFormat:@"确定要删除分组“%@”吗？", target.displayName] preferredStyle:UIAlertControllerStyleAlert];
            [confirm addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *a) { done(NO); }]];
            [confirm addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *a) {
                if (![weakSelf canEditAccount:accountID]) { done(NO); return; }
                WESessionTabItem *current = [weakSelf customTabWithID:tabID];
                if (!current) { done(NO); return; }
                [weakSelf.customTabs removeObject:current];
                [weakSelf.tabOrder removeObject:tabID];
                [weakSelf saveCustomTabs];
                [weakSelf setupData];
                [weakSelf.tableView reloadData];
                done(YES);
            }]];
            [weakSelf presentViewController:confirm animated:YES completion:nil];
        }];
    remove.backgroundColor = [UIColor systemRedColor];
    return [UISwipeActionsConfiguration configurationWithActions:@[remove, rename]];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark - Actions

- (void)showAddCustomTabAlert {
    NSString *accountID = [self.groupPreferences.accountID copy];
    if (![self canEditAccount:accountID]) return;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"新建分组"
                                                                   message:@"请输入分组名称"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"分组名称";
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if (![self canEditAccount:accountID]) return;
        NSString *name = alert.textFields.firstObject.text;
        if (name.length > 0) {
            WESessionTabItem *tab = [WESessionTabItem customTabWithName:name sessionUserNames:@[]];
            [self.customTabs addObject:tab];
            [self.tabOrder addObject:tab.tabId];
            [self saveCustomTabs];
            [self setupData];
            [self.tableView reloadData];
        }
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showEditCustomTabAlertWithTabID:(NSString *)tabID {
    NSString *accountID = [self.groupPreferences.accountID copy];
    if (![self canEditAccount:accountID]) return;
    WESessionTabItem *tab = [self customTabWithID:tabID];
    if (!tab) return;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"编辑分组"
                                                                   message:@"请输入分组名称"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.text = tab.displayName;
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if (![self canEditAccount:accountID]) return;
        WESessionTabItem *current = [self customTabWithID:tabID];
        if (!current) return;
        NSString *name = alert.textFields.firstObject.text;
        if (name.length > 0) {
            current.tabName = name;
            current.updateTime = [NSDate date];
            [self saveCustomTabs];
            [self setupData];
            [self.tableView reloadData];
        }
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showEditPresetTabAlertWithTabId:(NSString *)tabId defaultName:(NSString *)defaultName {
    NSString *accountID = [self.groupPreferences.accountID copy];
    if (![self canEditAccount:accountID]) return;
    NSString *currentName = self.presetTabNames[tabId];
    NSString *displayName = currentName.length > 0 ? currentName : defaultName;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"编辑预设分组"
                                                                   message:@"请输入分组名称（留空恢复默认）"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.text = displayName;
        textField.placeholder = defaultName;
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"恢复默认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        if (![self canEditAccount:accountID]) return;
        [self.presetTabNames removeObjectForKey:tabId];
        [self savePresetTabNames];
        [self setupData];
        [self.tableView reloadData];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if (![self canEditAccount:accountID]) return;
        NSString *name = alert.textFields.firstObject.text;
        if (name.length > 0 && ![name isEqualToString:defaultName]) {
            self.presetTabNames[tabId] = name;
            [self savePresetTabNames];
        } else if (name.length == 0 || [name isEqualToString:defaultName]) {
            [self.presetTabNames removeObjectForKey:tabId];
            [self savePresetTabNames];
        }
        [self setupData];
        [self.tableView reloadData];
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Scroll Sensitivity Settings

- (NSInteger)scrollSensitivityValue {
    NSInteger value = [[NSUserDefaults standardUserDefaults] integerForKey:kScrollSensitivityKey];
    return value == 0 ? 3 : value;
}

- (NSString *)scrollSensitivityName {
    NSInteger value = [self scrollSensitivityValue];
    switch (value) {
        case 1:
            return @"快速";
        case 2:
            return @"超快";
        case 3:
            return @"极快";
        default:
            return @"极快";
    }
}

- (void)showScrollSensitivityPicker {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"滑动灵敏度"
                                                                   message:@"选择滑动灵敏度级别"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"快速" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:kScrollSensitivityKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self reloadChatGroupSettings];
        [self setupData];
        [self.tableView reloadData];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"超快" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:kScrollSensitivityKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self reloadChatGroupSettings];
        [self setupData];
        [self.tableView reloadData];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"极快" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[NSUserDefaults standardUserDefaults] setInteger:3 forKey:kScrollSensitivityKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self reloadChatGroupSettings];
        [self setupData];
        [self.tableView reloadData];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showInfoAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"聊天分组功能说明"
                                                                            message:@"聊天分组功能在聊天列表顶部显示会话分组标签，方便您快速切换查看不同类型的会话。开启分组栏搜索按钮后，使用该按钮搜索，并收起整块原生搜索区域。\n\n【主要功能】\n• 预设分组：全部、群聊、私聊、服务\n• 自定义分组：在设置页点击“添加自定义分组”创建\n• 分组排序：拖拽调整分组顺序\n• 分组隐藏：可隐藏不需要的分组\n\n【高级设置】\n• 分组标签字号：默认 18 pt，可自定义 12–28 pt\n• 显示分组栏搜索按钮：开启时收起整块原生搜索区域及占位，关闭时恢复\n• 指示器背景色：自定义选中指示器颜色\n• 选中文本颜色：自定义选中文本颜色\n• 切换触感：切换分组时的触感反馈\n• 过滤重复会话：避免会话重复显示\n• 分组切换手势：会话区域左侧 85% 起手横滑切组，右侧 15% 起手左滑展开菜单，按起点区分；菜单展开时暂停切组。分组栏也可横滑，标签过多时优先滚动标签\n• 隐藏角标：隐藏分组角标\n• 滑动灵敏度：调整列表滑动速度\n• 分组指示器切换动画：下划线、胶囊包裹或关闭；胶囊按下采用 Neo 的0.12秒 EaseOut背景预览，标题和角标不缩放，松手单次选择，取消或滑出标签时恢复，选中及横滑过渡沿用0.28秒；胶囊沿用指示器颜色与选中文本颜色，深浅色分别配置；关闭保留静态下划线，遵循系统减弱动态效果\n\n设置将在当前滚动或编辑结束后更新。"
                                                                     preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"了解了"
                                                      style:UIAlertActionStyleDefault
                                                    handler:nil];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
