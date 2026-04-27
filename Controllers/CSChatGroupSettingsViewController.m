#import "CSChatGroupSettingsViewController.h"
#import "WESessionTabItem.h"
#import "CSSettingTableViewCell.h"
#import "WEContactSelectViewController.h"
#import "CSServiceCenter.h"
#import <objc/runtime.h>
#import <objc/message.h>

static NSString * const kChatGroupEnabledKey = @"com.wechat.enhance.chat_group.enabled";
static NSString * const kCustomTabsKey = @"com.wechat.enhance.chat_group.custom_tabs";
static NSString * const kPresetTabNamesKey = @"com.wechat.enhance.chat_group.preset_names";
static NSString * const kTabOrderKey = @"com.wechat.enhance.chat_group.tab_order";
static NSString * const kHiddenPresetTabsKey = @"com.wechat.enhance.chat_group.hidden_preset_tabs";
static NSString * const kIndicatorColorKey = @"com.wechat.enhance.chat_group.indicator_color";
static NSString * const kIndicatorColorDarkKey = @"com.wechat.enhance.chat_group.indicator_color_dark";
static NSString * const kSelectedTextColorKey = @"com.wechat.enhance.chat_group.selected_text_color";
static NSString * const kSelectedTextColorDarkKey = @"com.wechat.enhance.chat_group.selected_text_color_dark";
static NSString * const kHapticFeedbackKey = @"com.wechat.enhance.chat_group.haptic_feedback";
static NSString * const kFilterDuplicateContactsKey = @"com.wechat.enhance.chat_group.filter_duplicate_contacts";
static NSString * const kSwipeGestureEnabledKey = @"com.wechat.enhance.chat_group.swipe_gesture_enabled";
static NSString * const kHideGroupBadgeKey = @"com.wechat.enhance.chat_group.hide_group_badge";
static NSString * const kHideAllBadgeKey = @"com.wechat.enhance.chat_group.hide_all_badge";
static NSString * const kScrollSensitivityKey = @"com.wechat.enhance.scroll_sensitivity";
static NSString * const kScrollAnimationEnabledKey = @"com.wechat.enhance.scroll_animation.enabled";

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

@property (nonatomic, strong) NSArray<CSSettingSection *> *sections;
@property (nonatomic, strong) NSMutableArray<WESessionTabItem *> *customTabs;
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSString *> *presetTabNames;
@property (nonatomic, strong) NSMutableArray<NSString *> *tabOrder;
@property (nonatomic, strong) NSMutableSet<NSString *> *hiddenPresetTabs;
@property (nonatomic, strong) WEColorPreviewView *indicatorColorPreview;
@property (nonatomic, strong) WEColorPreviewView *selectedTextColorPreview;
@property (nonatomic, assign) NSInteger currentColorType;

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
    
    [self loadPresetTabNames];
    [self loadCustomTabs];
    [self loadTabOrder];
    [self loadHiddenPresetTabs];
    [self setupData];
}

- (void)loadHiddenPresetTabs {
    NSArray *savedHidden = [[NSUserDefaults standardUserDefaults] objectForKey:kHiddenPresetTabsKey];
    if (savedHidden) {
        self.hiddenPresetTabs = [NSMutableSet setWithArray:savedHidden];
    } else {
        self.hiddenPresetTabs = [NSMutableSet set];
    }
}

- (void)saveHiddenPresetTabs {
    [[NSUserDefaults standardUserDefaults] setObject:[self.hiddenPresetTabs allObjects] forKey:kHiddenPresetTabsKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self reloadChatGroupSettings];
}

- (void)loadTabOrder {
    NSArray *savedOrder = [[NSUserDefaults standardUserDefaults] objectForKey:kTabOrderKey];
    if (savedOrder) {
        self.tabOrder = [NSMutableArray arrayWithArray:savedOrder];
    } else {
        self.tabOrder = [NSMutableArray arrayWithArray:@[@"preset_0", @"preset_1", @"preset_2", @"preset_3"]];
    }
}

- (void)saveTabOrder {
    [[NSUserDefaults standardUserDefaults] setObject:self.tabOrder forKey:kTabOrderKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self reloadChatGroupSettings];
}

- (void)loadPresetTabNames {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kPresetTabNamesKey];
    if (data) {
        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        self.presetTabNames = [NSMutableDictionary dictionaryWithDictionary:dict ?: @{}];
    } else {
        self.presetTabNames = [NSMutableDictionary dictionary];
    }
}

- (void)savePresetTabNames {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.presetTabNames];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:kPresetTabNamesKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self reloadChatGroupSettings];
}

- (void)loadCustomTabs {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kCustomTabsKey];
    if (data) {
        NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        self.customTabs = [NSMutableArray arrayWithArray:array ?: @[]];
    } else {
        self.customTabs = [NSMutableArray array];
    }
}

- (void)saveCustomTabs {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.customTabs];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:kCustomTabsKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self reloadChatGroupSettings];
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
    
    CSSettingItem *enableItem = [CSSettingItem switchItemWithTitle:@"启用聊天分组"
                                                         iconName:@"rectangle.grid.1x2"
                                                        iconColor:[UIColor systemIndigoColor]
                                                      switchValue:[defaults boolForKey:kChatGroupEnabledKey]
                                                valueChangedBlock:^(BOOL isOn) {
        [defaults setBool:isOn forKey:kChatGroupEnabledKey];
        [defaults synchronize];
        
        [weakSelf reloadChatGroupSettings];
        [weakSelf showRestartAlert];
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
    
    CSSettingItem *addTabItem = [CSSettingItem itemWithTitle:@"添加自定义分组"
                                                   iconName:@"plus.circle"
                                                  iconColor:[UIColor systemBlueColor]
                                                     detail:@""];
    addTabItem.actionBlock = ^{
        [weakSelf showAddCustomTabAlert];
    };
    
    [groupItems addObject:addTabItem];
    
    self.indicatorColorPreview.previewColor = [self currentIndicatorColor];
    CSSettingItem *indicatorColorItem = [CSSettingItem itemWithTitle:@"指示器颜色"
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
    
    NSString *hapticDetail = [self hapticFeedbackName];
    CSSettingItem *hapticFeedbackItem = [CSSettingItem itemWithTitle:@"切换触感"
                                                           iconName:@"hand.tap"
                                                          iconColor:[UIColor systemPurpleColor]
                                                             detail:hapticDetail];
    hapticFeedbackItem.actionBlock = ^{
        [weakSelf showHapticFeedbackPicker];
    };
    
    CSSettingItem *filterDuplicateItem = [CSSettingItem switchItemWithTitle:@"过滤重复联系人"
                                                                  iconName:@"person.crop.circle.badge.minus"
                                                                 iconColor:[UIColor systemRedColor]
                                                               switchValue:[defaults boolForKey:kFilterDuplicateContactsKey]
                                                         valueChangedBlock:^(BOOL isOn) {
        [defaults setBool:isOn forKey:kFilterDuplicateContactsKey];
        [defaults synchronize];
        
        [weakSelf reloadChatGroupSettings];
        [weakSelf showRestartAlert];
    }];
    
    CSSettingItem *swipeGestureItem = [CSSettingItem switchItemWithTitle:@"分组切换手势"
                                                               iconName:@"arrow.left.arrow.right"
                                                              iconColor:[UIColor systemBlueColor]
                                                            switchValue:[defaults boolForKey:kSwipeGestureEnabledKey]
                                                      valueChangedBlock:^(BOOL isOn) {
        [defaults setBool:isOn forKey:kSwipeGestureEnabledKey];
        [defaults synchronize];
        
        [weakSelf reloadChatGroupSettings];
        [weakSelf showRestartAlert];
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
    CSSettingItem *scrollSensitivityItem = [CSSettingItem itemWithTitle:@"滑动灵敏度"
                                                              iconName:@"slider.horizontal.3"
                                                             iconColor:[UIColor systemCyanColor]
                                                                detail:sensitivityDetail];
    scrollSensitivityItem.actionBlock = ^{
        [weakSelf showScrollSensitivityPicker];
    };
    
    CSSettingItem *scrollAnimationItem = [CSSettingItem switchItemWithTitle:@"滑动特效"
                                                                  iconName:@"wand.and.stars"
                                                                 iconColor:[UIColor systemPurpleColor]
                                                               switchValue:[defaults boolForKey:kScrollAnimationEnabledKey]
                                                         valueChangedBlock:^(BOOL isOn) {
        [defaults setBool:isOn forKey:kScrollAnimationEnabledKey];
        [defaults synchronize];
        
        [weakSelf reloadChatGroupSettings];
    }];
    
    CSSettingItem *infoItem = [CSSettingItem itemWithTitle:@"功能说明"
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
                                                                  items:@[indicatorColorItem, selectedTextColorItem, hapticFeedbackItem, filterDuplicateItem, swipeGestureItem, hideGroupBadgeItem, hideAllBadgeItem, scrollSensitivityItem, scrollAnimationItem]];
    
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
    
    if ([item.title isEqualToString:@"指示器颜色"]) {
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
        return @"开启后，聊天列表顶部将显示会话分组，可快速切换查看不同类型的会话，重启后生效";
    } else if (section == 1) {
        return @"点击右上角\"排序\"可拖拽调整分组顺序，左滑可编辑或隐藏或删除";
    } else if (section == 2){
        return @"过滤重复联系人：开启后分组内的好友、群聊将不会出现在私信和群列表，重启后生效。\n分组切换手势：支持全屏滑动切换分组，重启后生效。\n隐藏分组角标：隐藏除\"全部\"外的其他分组角标。\n隐藏全部角标：隐藏\"全部\"分组的角标。\n滑动灵敏度：建议默认，相对流畅。\n滑动特效：开启后，滚动列表有缩放渐变特效。";
    } else {
        return nil;
    }
}

#pragma mark - Color Settings

- (UIColor *)currentIndicatorColor {
    NSString *colorKey = [self isDarkMode] ? kIndicatorColorDarkKey : kIndicatorColorKey;
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:colorKey];
    if (data) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return [UIColor colorWithRed:0.102 green:0.678 blue:0.098 alpha:1.0];
}

- (UIColor *)currentSelectedTextColor {
    NSString *colorKey = [self isDarkMode] ? kSelectedTextColorDarkKey : kSelectedTextColorKey;
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:colorKey];
    if (data) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return [UIColor colorWithRed:0.102 green:0.678 blue:0.098 alpha:1.0];
}

- (BOOL)isDarkMode {
    if (@available(iOS 13.0, *)) {
        return self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark;
    }
    return NO;
}

- (void)showColorPicker {
    NSString *title = self.currentColorType == 0 ? @"指示器颜色" : @"选中文本颜色";
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
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:color];
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
            [weakSelf setupData];
            [weakSelf.tableView reloadData];
        }]];
    }
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Edit Mode

- (void)editButtonTapped {
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    
    if (self.tableView.editing) {
        self.navigationItem.rightBarButtonItem.title = @"完成";
    } else {
        self.navigationItem.rightBarButtonItem.title = @"排序";
        [self saveTabOrder];
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section != 1) return NO;
    
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
    if (sourceIndexPath.section != 1 || destinationIndexPath.section != 1) return;
    
    NSString *movedTabId = self.tabOrder[sourceIndexPath.row];
    [self.tabOrder removeObjectAtIndex:sourceIndexPath.row];
    [self.tabOrder insertObject:movedTabId atIndex:destinationIndexPath.row];
    
    [self setupData];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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

- (void)showContactSelectForTab:(WESessionTabItem *)tab {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择类型"
                                                                   message:@"请选择要添加的会话类型"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    __weak typeof(self) weakSelf = self;
    
    [alert addAction:[UIAlertAction actionWithTitle:@"群聊" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [weakSelf presentContactSelectWithType:WEContactSelectTypeGroup tab:tab tagName:nil];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"私聊" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [weakSelf presentContactSelectWithType:WEContactSelectTypePrivate tab:tab tagName:nil];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"标签" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [weakSelf showTagSelectForTab:tab];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"全部" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [weakSelf presentContactSelectWithType:WEContactSelectTypeAll tab:tab tagName:nil];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showTagSelectForTab:(WESessionTabItem *)tab {
    Class tagMgrClass = objc_getClass("ContactTagMgr");
    if (!tagMgrClass) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                       message:@"无法获取标签列表"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    id tagMgr = CSGetService(tagMgrClass);
    if (!tagMgr) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                       message:@"无法获取标签列表"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    SEL getAllLabelNameSel = NSSelectorFromString(@"getAllLabelName");
    if (![tagMgr respondsToSelector:getAllLabelNameSel]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                       message:@"无法获取标签列表"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    NSArray *tagNames = ((id (*)(id, SEL))objc_msgSend)(tagMgr, getAllLabelNameSel);
    
    if (!tagNames || tagNames.count == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                       message:@"暂无标签，请先在微信中创建标签"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    UIAlertController *tagAlert = [UIAlertController alertControllerWithTitle:@"选择标签"
                                                                      message:@"请选择要添加的标签"
                                                               preferredStyle:UIAlertControllerStyleActionSheet];
    
    __weak typeof(self) weakSelf = self;
    for (NSString *tagName in tagNames) {
        [tagAlert addAction:[UIAlertAction actionWithTitle:tagName style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [weakSelf presentContactSelectWithType:WEContactSelectTypeTag tab:tab tagName:tagName];
        }]];
    }
    
    [tagAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:tagAlert animated:YES completion:nil];
}

- (void)presentContactSelectWithType:(WEContactSelectType)selectType tab:(WESessionTabItem *)tab tagName:(NSString *)tagName {
    WEContactSelectViewController *selectVC = [[WEContactSelectViewController alloc] initWithTitle:tab.displayName
                                                                                selectedUserNames:tab.sessionUserNames
                                                                                      selectType:selectType
                                                                                       tagName:tagName];
    
    __weak typeof(self) weakSelf = self;
    selectVC.completion = ^(NSArray<NSString *> *selectedUserNames) {
        tab.sessionUserNames = selectedUserNames;
        tab.updateTime = [NSDate date];
        [weakSelf saveCustomTabs];
        [weakSelf setupData];
        [weakSelf.tableView reloadData];
    };
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:selectVC];
    nav.modalPresentationStyle = UIModalPresentationPageSheet;
    
    if (@available(iOS 15.0, *)) {
        if (nav.sheetPresentationController) {
            UISheetPresentationControllerDetent *mediumDetent = [UISheetPresentationControllerDetent mediumDetent];
            UISheetPresentationControllerDetent *largeDetent = [UISheetPresentationControllerDetent largeDetent];
            nav.sheetPresentationController.detents = @[mediumDetent, largeDetent];
        }
    }
    
    [self presentViewController:nav animated:YES completion:nil];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section != 1) return NO;
    
    NSInteger totalTabs = self.tabOrder.count;
    return indexPath.row < totalTabs;
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView leadingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section != 1) return nil;
    
    NSInteger totalTabs = self.tabOrder.count;
    if (indexPath.row >= totalTabs) return nil;
    
    __weak typeof(self) weakSelf = self;
    NSString *tabId = self.tabOrder[indexPath.row];
    
    NSDictionary *presetTabsDict = @{
        @"preset_0": [WESessionTabItem tabWithType:WETabTypeAll],
        @"preset_1": [WESessionTabItem tabWithType:WETabTypeGroup],
        @"preset_2": [WESessionTabItem tabWithType:WETabTypePrivate],
        @"preset_3": [WESessionTabItem tabWithType:WETabTypeOfficial]
    };
    
    if ([tabId hasPrefix:@"preset_"]) {
        WESessionTabItem *tab = presetTabsDict[tabId];
        BOOL isHidden = [self.hiddenPresetTabs containsObject:tabId];
        
        UIContextualAction *editAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal
                                                                                title:@"重命名"
                                                                              handler:^(UIContextualAction *action, UIView *sourceView, void (^completionHandler)(BOOL)) {
            [weakSelf showEditPresetTabAlertWithTabId:tabId defaultName:tab.displayName];
            completionHandler(YES);
        }];
        editAction.backgroundColor = [UIColor systemBlueColor];
        
        UIContextualAction *hideAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal
                                                                                title:isHidden ? @"显示" : @"隐藏"
                                                                              handler:^(UIContextualAction *action, UIView *sourceView, void (^completionHandler)(BOOL)) {
            if (isHidden) {
                [weakSelf.hiddenPresetTabs removeObject:tabId];
            } else {
                [weakSelf.hiddenPresetTabs addObject:tabId];
            }
            [weakSelf saveHiddenPresetTabs];
            [weakSelf setupData];
            [weakSelf.tableView reloadData];
            completionHandler(YES);
        }];
        hideAction.backgroundColor = isHidden ? [UIColor systemGreenColor] : [UIColor systemOrangeColor];
        
        return [UISwipeActionsConfiguration configurationWithActions:@[hideAction, editAction]];
    }
    
    NSDictionary *customTabsDict = [NSDictionary dictionaryWithObjects:self.customTabs
                                                               forKeys:[self.customTabs valueForKeyPath:@"tabId"]];
    WESessionTabItem *tab = customTabsDict[tabId];
    
    if (tab) {
        NSInteger customIndex = [self.customTabs indexOfObject:tab];
        
        UIContextualAction *editAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal
                                                                                title:@"重命名"
                                                                              handler:^(UIContextualAction *action, UIView *sourceView, void (^completionHandler)(BOOL)) {
            [weakSelf showEditCustomTabAlertAtIndex:customIndex];
            completionHandler(YES);
        }];
        editAction.backgroundColor = [UIColor systemBlueColor];
        
        UIContextualAction *deleteAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive
                                                                                   title:@"删除"
                                                                                 handler:^(UIContextualAction *action, UIView *sourceView, void (^completionHandler)(BOOL)) {
            UIAlertController *confirmAlert = [UIAlertController alertControllerWithTitle:@"确认删除"
                                                                                  message:[NSString stringWithFormat:@"确定要删除分组\"%@\"吗？", tab.displayName]
                                                                           preferredStyle:UIAlertControllerStyleAlert];
            
            [confirmAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                completionHandler(NO);
            }]];
            
            [confirmAlert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                [weakSelf.tabOrder removeObject:tabId];
                [weakSelf.customTabs removeObjectAtIndex:customIndex];
                [weakSelf saveCustomTabs];
                [weakSelf saveTabOrder];
                [weakSelf setupData];
                [weakSelf.tableView reloadData];
                completionHandler(YES);
                [weakSelf showRestartAlert];
            }]];
            
            [weakSelf presentViewController:confirmAlert animated:YES completion:nil];
        }];
        deleteAction.backgroundColor = [UIColor systemRedColor];
        
        return [UISwipeActionsConfiguration configurationWithActions:@[deleteAction, editAction]];
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark - Actions

- (void)showAddCustomTabAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"新建分组"
                                                                   message:@"请输入分组名称"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"分组名称";
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSString *name = alert.textFields.firstObject.text;
        if (name.length > 0) {
            WESessionTabItem *tab = [WESessionTabItem customTabWithName:name sessionUserNames:@[]];
            [self.customTabs addObject:tab];
            [self.tabOrder addObject:tab.tabId];
            [self saveCustomTabs];
            [self saveTabOrder];
            [self setupData];
            [self.tableView reloadData];
            [self showRestartAlert];
        }
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showEditCustomTabAlertAtIndex:(NSInteger)index {
    WESessionTabItem *tab = self.customTabs[index];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"编辑分组"
                                                                   message:@"请输入分组名称"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.text = tab.displayName;
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSString *name = alert.textFields.firstObject.text;
        if (name.length > 0) {
            tab.tabName = name;
            tab.updateTime = [NSDate date];
            [self saveCustomTabs];
            [self setupData];
            [self.tableView reloadData];
        }
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showEditPresetTabAlertWithTabId:(NSString *)tabId defaultName:(NSString *)defaultName {
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
        [self.presetTabNames removeObjectForKey:tabId];
        [self savePresetTabNames];
        [self setupData];
        [self.tableView reloadData];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
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

- (void)showRestartAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"重启生效"
                                                                   message:@"此设置需要重启微信才能生效"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"稍后重启" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"立即重启" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        exit(0);
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
                                                                            message:@"聊天分组功能可以在聊天列表顶部显示会话分组标签，方便您快速切换查看不同类型的会话。\n\n【主要功能】\n• 预设分组：全部、群聊、私聊、公众号\n• 自定义分组：可创建个性化分组\n• 分组排序：拖拽调整分组顺序\n• 分组隐藏：可隐藏不需要的分组\n\n【高级设置】\n• 指示器颜色：自定义选中指示器颜色\n• 选中文本颜色：自定义选中文本颜色\n• 切换触感：切换分组时的触感反馈\n• 过滤重复联系人：避免会话重复显示\n• 分组切换手势：全屏滑动切换分组\n• 隐藏角标：隐藏分组角标\n• 滑动灵敏度：调整列表滑动速度\n• 滑动特效：滚动时的缩放渐变动画\n\n注意：部分设置需要重启微信才能生效。"
                                                                     preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"了解了"
                                                      style:UIAlertActionStyleDefault
                                                    handler:nil];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
