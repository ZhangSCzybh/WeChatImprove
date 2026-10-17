#import "CSTabBarStyleSettingsViewController.h"
#import "CSSettingTableViewCell.h"
#import <Photos/Photos.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>

#import "CSTabBarPreferences.h"
#import "CSTabBarGeometry.h"

typedef NS_ENUM(NSInteger, TabBarIconType) {
    TabBarIconTypeChat = 0,
    TabBarIconTypeContacts,
    TabBarIconTypeDiscover,
    TabBarIconTypeMe
};

@interface CSTabBarStyleSettingsViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIColorPickerViewControllerDelegate>

@property (nonatomic, strong) NSArray<CSSettingSection *> *sections;
@property (nonatomic, strong) CSSettingItem *enableItem;
@property (nonatomic, strong) CSSettingItem *hideTextItem;

@property (nonatomic, strong) CSSettingItem *chatIconItem;
@property (nonatomic, strong) CSSettingItem *contactsIconItem;
@property (nonatomic, strong) CSSettingItem *discoverIconItem;
@property (nonatomic, strong) CSSettingItem *meIconItem;

// 新增样式设置项
@property (nonatomic, strong) CSSettingItem *borderStyleItem;
@property (nonatomic, strong) CSSettingItem *cornerRadiusItem;
@property (nonatomic, strong) CSSettingItem *bgColorItem;
@property (nonatomic, strong) CSSettingItem *positionOffsetItem;
@property (nonatomic, strong) CSSettingItem *scaleItem;
@property (nonatomic, strong) CSSettingItem *contentHeightItem;
@property (nonatomic, strong) CSSettingItem *borderWidthItem;
@property (nonatomic, strong) CSSettingItem *hapticFeedbackItem;
@property (nonatomic, strong) CSSettingItem *borderAnimationItem;
@property (nonatomic, strong) CSSettingItem *borderColorItem;

// 文本自定义设置项
@property (nonatomic, strong) CSSettingItem *chatTextItem;
@property (nonatomic, strong) CSSettingItem *contactsTextItem;
@property (nonatomic, strong) CSSettingItem *discoverTextItem;
@property (nonatomic, strong) CSSettingItem *meTextItem;

@property (nonatomic, assign) BOOL tabBarStyleEnabled;
@property (nonatomic, assign) BOOL hideText;
@property (nonatomic, assign) NSInteger borderStyle;
@property (nonatomic, assign) NSInteger hapticFeedback;
@property (nonatomic, assign) NSInteger borderAnimation;

// 新增样式属性
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) CGFloat positionOffset;
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) CGFloat contentHeight;
@property (nonatomic, assign) CGFloat borderWidth;

// 文本自定义属性
@property (nonatomic, strong) NSString *chatText;
@property (nonatomic, strong) NSString *contactsText;
@property (nonatomic, strong) NSString *discoverText;
@property (nonatomic, strong) NSString *meText;

@property (nonatomic, assign) TabBarIconType currentIconType;
@property (nonatomic, assign) BOOL isSelectingIcon;

@end

@implementation CSTabBarStyleSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"底栏样式";
    self.tableView.backgroundColor = [UIColor systemGroupedBackgroundColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 54, 0, 0);
    
    [CSSettingTableViewCell registerToTableView:self.tableView];
    
    [self loadCurrentSettings];
    [self setupData];
}

- (void)loadCurrentSettings {
    [CSTabBarPreferences reload];
    CSTabBarPreferences *p=CSTabBarPreferences.current;
    self.tabBarStyleEnabled=p.enabled; self.hideText=p.hideText;
    self.cornerRadius=p.cornerRadius; self.positionOffset=p.lift; self.scale=p.scale;
    self.contentHeight=p.contentHeight; self.borderWidth=p.borderWidth;
    self.borderStyle=p.borderStyle; self.hapticFeedback=p.haptic; self.borderAnimation=p.animation;
    self.bgColor=p.backgroundColor; self.borderColor=p.borderColor;
    self.chatText=[p titleAtIndex:0]; self.contactsText=[p titleAtIndex:1];
    self.discoverText=[p titleAtIndex:2]; self.meText=[p titleAtIndex:3];
}

- (void)saveSettings {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:self.tabBarStyleEnabled forKey:kTabBarStyleEnabledKey];
    [defaults setBool:self.hideText forKey:kTabBarHideTextKey];
    
    // 保存新的样式设置
    [defaults setFloat:self.cornerRadius forKey:kTabBarCornerRadiusKey];
    [defaults setFloat:self.positionOffset forKey:kTabBarPositionOffsetKey];
    [defaults setFloat:self.scale forKey:kTabBarScaleKey];
    [defaults setFloat:self.contentHeight forKey:kTabBarContentHeightKey];
    [defaults setFloat:self.borderWidth forKey:kTabBarBorderWidthKey];
    [defaults setInteger:self.borderStyle forKey:kTabBarBorderStyleKey];
    [defaults setInteger:self.hapticFeedback forKey:kTabBarHapticFeedbackKey];
    [defaults setInteger:self.borderAnimation forKey:kTabBarBorderAnimationKey];
    
    // 保存背景颜色
    [self saveColor:self.bgColor
          withRedKey:kTabBarBgColorRedKey
          greenKey:kTabBarBgColorGreenKey
           blueKey:kTabBarBgColorBlueKey
          alphaKey:kTabBarBgColorAlphaKey];
    
    // 保存描边颜色
    [self saveColor:self.borderColor
          withRedKey:kTabBarBorderColorRedKey
          greenKey:kTabBarBorderColorGreenKey
           blueKey:kTabBarBorderColorBlueKey
          alphaKey:kTabBarBorderColorAlphaKey];
    
    // 保存自定义文本
    [defaults setObject:self.chatText forKey:kTabBarTextChatKey];
    [defaults setObject:self.contactsText forKey:kTabBarTextContactsKey];
    [defaults setObject:self.discoverText forKey:kTabBarTextDiscoverKey];
    [defaults setObject:self.meText forKey:kTabBarTextMeKey];
    
    [defaults synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.enhance.tabbar_style.changed" object:nil];
}

- (void)saveColor:(UIColor *)color
       withRedKey:(NSString *)redKey
         greenKey:(NSString *)greenKey
          blueKey:(NSString *)blueKey
         alphaKey:(NSString *)alphaKey {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (!color) {
        for (NSString *key in @[redKey,greenKey,blueKey,alphaKey]) [defaults removeObjectForKey:key];
        return;
    }
    CGFloat red=0, green=0, blue=0, alpha=0;
    if (![color getRed:&red green:&green blue:&blue alpha:&alpha]) return;
    
    [defaults setFloat:red forKey:redKey];
    [defaults setFloat:green forKey:greenKey];
    [defaults setFloat:blue forKey:blueKey];
    [defaults setFloat:alpha forKey:alphaKey];
}

- (void)setupData {
    __weak typeof(self) weakSelf = self;
    self.enableItem = [CSSettingItem switchItemWithTitle:@"启用悬浮导航栏"
                                              iconName:@"rectangle.bottomthird.inset.filled"
                                             iconColor:[UIColor systemBlueColor]
                                            switchValue:self.tabBarStyleEnabled
                                       valueChangedBlock:^(BOOL isOn) {
        weakSelf.tabBarStyleEnabled = isOn;
        [weakSelf saveSettings];
        [weakSelf updateIconItemsState];
    }];
    
    self.hideTextItem = [CSSettingItem switchItemWithTitle:@"隐藏标签文本"
                                                iconName:@"textformat.abc.dottedunderline"
                                               iconColor:[UIColor systemOrangeColor]
                                              switchValue:self.hideText
                                         valueChangedBlock:^(BOOL isOn) {
        weakSelf.hideText = isOn;
        [weakSelf saveSettings];
    }];
    
    // 加载已上传的图标
    UIImage *chatIcon = [self loadIconForType:TabBarIconTypeChat isSelected:NO];
    UIImage *contactsIcon = [self loadIconForType:TabBarIconTypeContacts isSelected:NO];
    UIImage *discoverIcon = [self loadIconForType:TabBarIconTypeDiscover isSelected:NO];
    UIImage *meIcon = [self loadIconForType:TabBarIconTypeMe isSelected:NO];
    
    self.chatIconItem = [CSSettingItem itemWithTitle:@"微信图标"
                                          iconName:chatIcon ? nil : @"message.fill"
                                         iconColor:[UIColor systemGreenColor]
                                            detail:chatIcon ? @"已设置" : @"点击设置"];
    self.chatIconItem.customImage = chatIcon;
    self.chatIconItem.actionBlock = ^{
        [weakSelf showIconSelectionAlertForType:TabBarIconTypeChat];
    };
    
    self.contactsIconItem = [CSSettingItem itemWithTitle:@"通讯录图标"
                                             iconName:contactsIcon ? nil : @"person.2.fill"
                                            iconColor:[UIColor systemBlueColor]
                                               detail:contactsIcon ? @"已设置" : @"点击设置"];
    self.contactsIconItem.customImage = contactsIcon;
    self.contactsIconItem.actionBlock = ^{
        [weakSelf showIconSelectionAlertForType:TabBarIconTypeContacts];
    };
    
    self.discoverIconItem = [CSSettingItem itemWithTitle:@"发现图标"
                                             iconName:discoverIcon ? nil : @"safari.fill"
                                            iconColor:[UIColor systemOrangeColor]
                                               detail:discoverIcon ? @"已设置" : @"点击设置"];
    self.discoverIconItem.customImage = discoverIcon;
    self.discoverIconItem.actionBlock = ^{
        [weakSelf showIconSelectionAlertForType:TabBarIconTypeDiscover];
    };
    
    self.meIconItem = [CSSettingItem itemWithTitle:@"我图标"
                                       iconName:meIcon ? nil : @"person.crop.circle.fill"
                                      iconColor:[UIColor systemPurpleColor]
                                         detail:meIcon ? @"已设置" : @"点击设置"];
    self.meIconItem.customImage = meIcon;
    self.meIconItem.actionBlock = ^{
        [weakSelf showIconSelectionAlertForType:TabBarIconTypeMe];
    };
    
    [self updateIconItemsState];
    
    // 创建文本自定义设置项
    self.chatTextItem = [CSSettingItem inputItemWithTitle:@"微信文本"
                                                iconName:@"message.fill"
                                               iconColor:[UIColor systemGreenColor]
                                               inputValue:self.chatText ?: @""
                                           inputPlaceholder:@"输入自定义文本"
                                          valueChangedBlock:^(NSString *value) {
        weakSelf.chatText = value.length > 0 ? value : nil;
        [weakSelf saveSettings];
    }];
    
    self.contactsTextItem = [CSSettingItem inputItemWithTitle:@"通讯录文本"
                                                   iconName:@"person.2.fill"
                                                  iconColor:[UIColor systemBlueColor]
                                                  inputValue:self.contactsText ?: @""
                                              inputPlaceholder:@"输入自定义文本"
                                             valueChangedBlock:^(NSString *value) {
        weakSelf.contactsText = value.length > 0 ? value : nil;
        [weakSelf saveSettings];
    }];
    
    self.discoverTextItem = [CSSettingItem inputItemWithTitle:@"发现文本"
                                                   iconName:@"safari.fill"
                                                  iconColor:[UIColor systemOrangeColor]
                                                  inputValue:self.discoverText ?: @""
                                              inputPlaceholder:@"输入自定义文本"
                                             valueChangedBlock:^(NSString *value) {
        weakSelf.discoverText = value.length > 0 ? value : nil;
        [weakSelf saveSettings];
    }];
    
    self.meTextItem = [CSSettingItem inputItemWithTitle:@"我文本"
                                             iconName:@"person.crop.circle.fill"
                                            iconColor:[UIColor systemPurpleColor]
                                            inputValue:self.meText ?: @""
                                        inputPlaceholder:@"输入自定义文本"
                                       valueChangedBlock:^(NSString *value) {
        weakSelf.meText = value.length > 0 ? value : nil;
        [weakSelf saveSettings];
    }];
    
    // 创建样式设置项
    // 边框样式
    NSArray *borderStyleOptions = @[@"半圆", @"圆角"];
    NSString *borderStyleDetail = borderStyleOptions[self.borderStyle];
    
    self.borderStyleItem = [CSSettingItem itemWithTitle:@"边框样式"
                                             iconName:@"rectangle.roundedtop"
                                            iconColor:[UIColor systemOrangeColor]
                                               detail:borderStyleDetail];
    self.borderStyleItem.actionBlock = ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择边框样式"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
        
        for (NSInteger i = 0; i < borderStyleOptions.count; i++) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:borderStyleOptions[i]
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull action) {
                weakSelf.borderStyle = i;
                weakSelf.borderStyleItem.detail = borderStyleOptions[i];
                [weakSelf saveSettings];
                [weakSelf.tableView reloadData];
            }];
            [alert addAction:action];
        }
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                               style:UIAlertActionStyleCancel
                                                             handler:nil];
        [alert addAction:cancelAction];
        
        [weakSelf presentViewController:alert animated:YES completion:nil];
    };
    
    self.cornerRadiusItem = [CSSettingItem inputItemWithTitle:@"圆角半径"
                                                   iconName:@"rectangle.roundedtop"
                                                  iconColor:[UIColor systemPurpleColor]
                                                  inputValue:[NSString stringWithFormat:@"%.1f", self.cornerRadius]
                                              inputPlaceholder:@"输入圆角（0–40 pt）"
                                             valueChangedBlock:^(NSString *value) {
        CGFloat radius = [value floatValue];
        radius = CSTabBarClamp(radius,0,40,kDefaultCornerRadius);
        weakSelf.cornerRadius = radius;
        [weakSelf saveSettings];
    }];
    self.cornerRadiusItem.inputKeyboardType = UIKeyboardTypeDecimalPad; // 数字键盘
    
    NSString *bgColorDetail = @"跟随原生";
    if (self.bgColor) {
        CGFloat red, green, blue, alpha;
        [self.bgColor getRed:&red green:&green blue:&blue alpha:&alpha];
        bgColorDetail = [NSString stringWithFormat:@"R:%.0f G:%.0f B:%.0f A:%.0f", red * 255, green * 255, blue * 255, alpha * 100];
    }
    
    self.bgColorItem = [CSSettingItem itemWithTitle:@"背景颜色"
                                         iconName:@"paintpalette.fill"
                                        iconColor:[UIColor systemPinkColor]
                                           detail:bgColorDetail];
    self.bgColorItem.actionBlock = ^{
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"背景颜色" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"自定义颜色" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) { [weakSelf showColorPicker]; }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"跟随原生" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            weakSelf.bgColor=nil; [weakSelf saveSettings]; [weakSelf setupData]; [weakSelf.tableView reloadData];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [weakSelf presentViewController:alert animated:YES completion:nil];
    };
    
    // 底栏切换触感
    NSArray *hapticOptions = @[@"无", @"舒适", @"轻柔", @"中度", @"强烈"];
    NSString *hapticDetail = hapticOptions[self.hapticFeedback];
    
    self.hapticFeedbackItem = [CSSettingItem itemWithTitle:@"切换触感"
                                                iconName:@"hand.tap.fill"
                                               iconColor:[UIColor systemPurpleColor]
                                                  detail:hapticDetail];
    self.hapticFeedbackItem.actionBlock = ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择切换触感"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
        
        for (NSInteger i = 0; i < hapticOptions.count; i++) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:hapticOptions[i]
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull action) {
                weakSelf.hapticFeedback = i;
                weakSelf.hapticFeedbackItem.detail = hapticOptions[i];
                [weakSelf saveSettings];
                [weakSelf.tableView reloadData];
            }];
            [alert addAction:action];
        }
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                               style:UIAlertActionStyleCancel
                                                             handler:nil];
        [alert addAction:cancelAction];
        
        [weakSelf presentViewController:alert animated:YES completion:nil];
    };
    
    // 底栏边框描边动画
    NSArray *animationOptions = @[@"无动画", @"扩散呼吸", @"扩散心跳", @"经典呼吸", @"经典心跳"];
    NSString *animationDetail = animationOptions[self.borderAnimation];
    
    self.borderAnimationItem = [CSSettingItem itemWithTitle:@"描边动画"
                                                 iconName:@"sparkles"
                                                iconColor:[UIColor systemYellowColor]
                                                   detail:animationDetail];
    self.borderAnimationItem.actionBlock = ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择描边动画"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
        
        for (NSInteger i = 0; i < animationOptions.count; i++) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:animationOptions[i]
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull action) {
                weakSelf.borderAnimation = i;
                weakSelf.borderAnimationItem.detail = animationOptions[i];
                [weakSelf saveSettings];
                [weakSelf.tableView reloadData];
            }];
            [alert addAction:action];
        }
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                               style:UIAlertActionStyleCancel
                                                             handler:nil];
        [alert addAction:cancelAction];
        
        [weakSelf presentViewController:alert animated:YES completion:nil];
    };
    
    // 描边颜色
    NSString *borderColorDetail = @"点击选择";
    if (self.borderColor) {
        CGFloat red, green, blue, alpha;
        [self.borderColor getRed:&red green:&green blue:&blue alpha:&alpha];
        borderColorDetail = [NSString stringWithFormat:@"R:%.0f G:%.0f B:%.0f A:%.0f", red * 255, green * 255, blue * 255, alpha * 100];
    }
    
    self.borderColorItem = [CSSettingItem itemWithTitle:@"描边颜色"
                                             iconName:@"paintbrush.fill"
                                            iconColor:[UIColor systemIndigoColor]
                                               detail:borderColorDetail];
    self.borderColorItem.actionBlock = ^{
        [weakSelf showBorderColorPicker];
    };
    
    self.positionOffsetItem = [CSSettingItem inputItemWithTitle:@"向上偏移"
                                                     iconName:@"arrow.up.and.down"
                                                    iconColor:[UIColor systemOrangeColor]
                                                    inputValue:[NSString stringWithFormat:@"%.1f", self.positionOffset]
                                                inputPlaceholder:@"距底边距离（0–100 pt，0 为贴底）"
                                               valueChangedBlock:^(NSString *value) {
        CGFloat offset = [value floatValue];
        offset = CSTabBarClamp(offset,0,100,0);
        weakSelf.positionOffset = offset;
        [weakSelf saveSettings];
    }];
    self.positionOffsetItem.inputKeyboardType = UIKeyboardTypeDecimalPad; // 数字键盘
    
    // 底栏大小选项
    NSArray *scaleOptions = @[@"迷你", @"紧凑", @"中等", @"标准"];
    NSArray *scaleValues = @[@0.6, @0.7, @0.8, @0.9];
    NSInteger scaleIndex = 0;
    for (NSInteger i = 0; i < scaleValues.count; i++) {
        if (ABS([scaleValues[i] floatValue] - self.scale) < 0.01) {
            scaleIndex = i;
            break;
        }
    }
    
    self.scaleItem = [CSSettingItem itemWithTitle:@"底栏宽度"
                                        iconName:@"slider.horizontal.3"
                                       iconColor:[UIColor systemTealColor]
                                          detail:scaleOptions[scaleIndex]];
    self.scaleItem.actionBlock = ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择底栏大小"
                                                                       message:nil
                                                                preferredStyle:UIAlertControllerStyleActionSheet];
        
        for (NSInteger i = 0; i < scaleOptions.count; i++) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:scaleOptions[i]
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull action) {
                weakSelf.scale = [scaleValues[i] floatValue];
                weakSelf.scaleItem.detail = scaleOptions[i];
                [weakSelf saveSettings];
                [weakSelf.tableView reloadData]; // 添加这行来刷新表格
            }];
            [alert addAction:action];
        }
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                               style:UIAlertActionStyleCancel
                                                             handler:nil];
        [alert addAction:cancelAction];
        
        [weakSelf presentViewController:alert animated:YES completion:nil];
    };
    
    self.contentHeightItem=[CSSettingItem inputItemWithTitle:@"底栏高度"
        iconName:@"arrow.up.and.down" iconColor:UIColor.systemTealColor
        inputValue:[NSString stringWithFormat:@"%.0f",self.contentHeight]
        inputPlaceholder:@"内容高度（44–80 pt）" valueChangedBlock:^(NSString *value) {
            weakSelf.contentHeight=CSTabBarClamp(value.doubleValue,44,80,52);
            [weakSelf saveSettings];
        }];
    self.contentHeightItem.inputKeyboardType=UIKeyboardTypeDecimalPad;
    self.borderWidthItem=[CSSettingItem inputItemWithTitle:@"描边宽度"
        iconName:@"pencil.tip" iconColor:UIColor.systemIndigoColor
        inputValue:[NSString stringWithFormat:@"%.1f",self.borderWidth]
        inputPlaceholder:@"描边宽度（0–6 pt，0 为关闭）" valueChangedBlock:^(NSString *value) {
            weakSelf.borderWidth=CSTabBarClamp(value.doubleValue,0,6,1);
            [weakSelf saveSettings];
        }];
    self.borderWidthItem.inputKeyboardType=UIKeyboardTypeDecimalPad;

    CSSettingSection *mainSection = [CSSettingSection sectionWithHeader:@"主设置"
                                                                items:@[self.enableItem, self.hideTextItem]];
    
    CSSettingSection *iconSection = [CSSettingSection sectionWithHeader:@"图标自定义"
                                                                items:@[self.chatIconItem,
                                                                       self.contactsIconItem,
                                                                       self.discoverIconItem,
                                                                       self.meIconItem]];
    
    CSSettingSection *textSection = [CSSettingSection sectionWithHeader:@"文本自定义"
                                                                items:@[self.chatTextItem,
                                                                       self.contactsTextItem,
                                                                       self.discoverTextItem,
                                                                       self.meTextItem]];
    
    CSSettingSection *styleSection = [CSSettingSection sectionWithHeader:@"样式设置"
                                                                items:@[self.scaleItem,
                                                                       self.contentHeightItem,
                                                                       self.borderStyleItem,
                                                                       self.cornerRadiusItem,
                                                                       self.positionOffsetItem,
                                                                       self.bgColorItem,
                                                                       self.hapticFeedbackItem,
                                                                       self.borderAnimationItem,
                                                                       self.borderColorItem,
                                                                       self.borderWidthItem]];
    
    CSSettingItem *resetItem = [CSSettingItem actionItemWithTitle:@"恢复默认设置"
                                                       iconName:@"arrow.counterclockwise"
                                                      iconColor:[UIColor systemRedColor]];
    resetItem.actionBlock = ^{
        [weakSelf resetToDefault];
    };
    
    CSSettingSection *resetSection = [CSSettingSection sectionWithHeader:@"重置"
                                                                items:@[resetItem]];
    
    CSSettingItem *descriptionItem = [CSSettingItem itemWithTitle:@"说明"
                                                       iconName:@"info.circle"
                                                      iconColor:[UIColor systemGrayColor]
                                                        detail:@"设置即时生效；红点与未读数字沿用微信原生显示。"];
    
    CSSettingSection *descriptionSection = [CSSettingSection sectionWithHeader:@""
                                                                       items:@[descriptionItem]];
    
    self.sections = @[mainSection, iconSection, textSection, styleSection, resetSection, descriptionSection];
}

- (void)updateIconItemsState {
    BOOL enabled = self.tabBarStyleEnabled;
    
    self.hideTextItem.switchValue = self.hideText;
    
    for (CSSettingItem *item in @[self.chatIconItem,self.contactsIconItem,self.discoverIconItem,self.meIconItem]) {
        item.detail=enabled ? (item.customImage ? @"已设置" : @"点击设置") : @"未启用";
    }
    
    [self.tableView reloadData];
}

- (void)showIconSelectionAlertForType:(TabBarIconType)type {
    if (!self.tabBarStyleEnabled) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                     message:@"请先启用底栏样式功能"
                                                              preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    self.currentIconType = type;
    
    NSString *title;
    switch (type) {
        case TabBarIconTypeChat:
            title = @"微信图标";
            break;
        case TabBarIconTypeContacts:
            title = @"通讯录图标";
            break;
        case TabBarIconTypeDiscover:
            title = @"发现图标";
            break;
        case TabBarIconTypeMe:
            title = @"我图标";
            break;
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:@"选择要设置的图标状态"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"设置普通状态图标"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * _Nonnull action) {
        self.isSelectingIcon = NO;
        [self showImagePicker];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"设置选中状态图标"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * _Nonnull action) {
        self.isSelectingIcon = YES;
        [self showImagePicker];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"清除自定义图标"
                                              style:UIAlertActionStyleDestructive
                                            handler:^(UIAlertAction * _Nonnull action) {
        [self clearCustomIcon];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消"
                                              style:UIAlertActionStyleCancel
                                            handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showImagePicker {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择图片来源"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * _Nonnull action) {
        [self pickImageFromLibrary];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * _Nonnull action) {
        [self pickImageFromCamera];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消"
                                              style:UIAlertActionStyleCancel
                                            handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)pickImageFromLibrary {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    if (status == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized || status == PHAuthorizationStatusLimited) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self presentImagePickerWithSource:UIImagePickerControllerSourceTypePhotoLibrary];
                });
            }
        }];
    } else if (status == PHAuthorizationStatusAuthorized || status == PHAuthorizationStatusLimited) {
        [self presentImagePickerWithSource:UIImagePickerControllerSourceTypePhotoLibrary];
    } else {
        [self showPermissionDeniedAlert];
    }
}

- (void)pickImageFromCamera {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误"
                                                                     message:@"设备不支持相机"
                                                              preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if (status == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self presentImagePickerWithSource:UIImagePickerControllerSourceTypeCamera];
                });
            }
        }];
    } else if (status == AVAuthorizationStatusAuthorized) {
        [self presentImagePickerWithSource:UIImagePickerControllerSourceTypeCamera];
    } else {
        [self showPermissionDeniedAlert];
    }
}

- (void)presentImagePickerWithSource:(UIImagePickerControllerSourceType)sourceType {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = sourceType;
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.mediaTypes = @[@"public.image"];
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)showPermissionDeniedAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"权限不足"
                                                                   message:@"请在设置中允许访问相册或相机"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)clearCustomIcon {
    NSString *normalKey = [self iconKeyForType:self.currentIconType isSelected:NO];
    NSString *selectedKey = [self iconKeyForType:self.currentIconType isSelected:YES];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // 获取文件路径并删除文件
    NSString *normalPath = [defaults stringForKey:normalKey];
    NSString *selectedPath = [defaults stringForKey:selectedKey];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (normalPath && [fileManager fileExistsAtPath:normalPath]) {
        [fileManager removeItemAtPath:normalPath error:nil];
    }
    if (selectedPath && [fileManager fileExistsAtPath:selectedPath]) {
        [fileManager removeItemAtPath:selectedPath error:nil];
    }
    
    // 清除NSUserDefaults中的路径
    [defaults removeObjectForKey:normalKey];
    [defaults removeObjectForKey:selectedKey];
    [defaults synchronize];
    
    // 刷新界面显示
    [self setupData];
    [self.tableView reloadData];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.enhance.tabbar_style.changed" object:nil];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"成功"
                                                                   message:@"已清除自定义图标"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (NSString *)iconKeyForType:(TabBarIconType)type isSelected:(BOOL)isSelected {
    if (isSelected) {
        switch (type) {
            case TabBarIconTypeChat:
                return kTabBarIconSelectedChatKey;
            case TabBarIconTypeContacts:
                return kTabBarIconSelectedContactsKey;
            case TabBarIconTypeDiscover:
                return kTabBarIconSelectedDiscoverKey;
            case TabBarIconTypeMe:
                return kTabBarIconSelectedMeKey;
        }
    } else {
        switch (type) {
            case TabBarIconTypeChat:
                return kTabBarIconChatKey;
            case TabBarIconTypeContacts:
                return kTabBarIconContactsKey;
            case TabBarIconTypeDiscover:
                return kTabBarIconDiscoverKey;
            case TabBarIconTypeMe:
                return kTabBarIconMeKey;
        }
    }
}

- (NSString *)getWeChatImproveFolderPath {
    NSString *prefsPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    prefsPath = [prefsPath stringByAppendingPathComponent:@"Preferences"];
    NSString *enhanceFolderPath = [prefsPath stringByAppendingPathComponent:@"WeChatImprove"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:enhanceFolderPath]) {
        NSError *error = nil;
        [fileManager createDirectoryAtPath:enhanceFolderPath 
               withIntermediateDirectories:YES 
                                attributes:nil 
                                     error:&error];
        if (error) {
            NSLog(@"创建WeChatImprove目录失败: %@", error.localizedDescription);
            return nil;
        }
    }
    
    return enhanceFolderPath;
}

- (NSString *)getIconFileNameForType:(TabBarIconType)type isSelected:(BOOL)isSelected {
    NSString *baseName;
    if (isSelected) {
        switch (type) {
            case TabBarIconTypeChat:
                baseName = @"tabbar_icon_chat_selected";
                break;
            case TabBarIconTypeContacts:
                baseName = @"tabbar_icon_contacts_selected";
                break;
            case TabBarIconTypeDiscover:
                baseName = @"tabbar_icon_discover_selected";
                break;
            case TabBarIconTypeMe:
                baseName = @"tabbar_icon_me_selected";
                break;
        }
    } else {
        switch (type) {
            case TabBarIconTypeChat:
                baseName = @"tabbar_icon_chat";
                break;
            case TabBarIconTypeContacts:
                baseName = @"tabbar_icon_contacts";
                break;
            case TabBarIconTypeDiscover:
                baseName = @"tabbar_icon_discover";
                break;
            case TabBarIconTypeMe:
                baseName = @"tabbar_icon_me";
                break;
        }
    }
    return [baseName stringByAppendingString:@".png"];
}

- (UIImage *)loadIconForType:(TabBarIconType)type isSelected:(BOOL)isSelected {
    NSString *key = [self iconKeyForType:type isSelected:isSelected];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *iconPath = [defaults stringForKey:key];
    
    if (iconPath) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:iconPath]) {
            return [UIImage imageWithContentsOfFile:iconPath];
        }
    }
    
    return nil;
}

- (void)showColorPicker {
    UIColorPickerViewController *colorPicker = [[UIColorPickerViewController alloc] init];
    colorPicker.delegate = self;
    colorPicker.selectedColor = self.bgColor ?: [UIColor clearColor];
    [self presentViewController:colorPicker animated:YES completion:nil];
}

- (void)showBorderColorPicker {
    UIColorPickerViewController *colorPicker = [[UIColorPickerViewController alloc] init];
    colorPicker.delegate = self;
    colorPicker.selectedColor = self.borderColor ?: [UIColor redColor];
    colorPicker.modalPresentationStyle = UIModalPresentationPopover;
    
    // 设置tag来区分是背景颜色还是描边颜色
    colorPicker.view.tag = 1001;
    
    [self presentViewController:colorPicker animated:YES completion:nil];
}

#pragma mark - UIColorPickerViewControllerDelegate

- (void)colorPickerViewControllerDidFinish:(UIColorPickerViewController *)viewController {
    // 根据tag判断是背景颜色还是描边颜色
    if (viewController.view.tag == 1001) {
        // 描边颜色
        self.borderColor = viewController.selectedColor;
        [self saveSettings];
        
        // 更新borderColorItem的显示
        if (self.borderColor) {
            CGFloat red, green, blue, alpha;
            [self.borderColor getRed:&red green:&green blue:&blue alpha:&alpha];
            self.borderColorItem.detail = [NSString stringWithFormat:@"R:%.0f G:%.0f B:%.0f A:%.0f", red * 255, green * 255, blue * 255, alpha * 100];
        } else {
            self.borderColorItem.detail = @"未设置";
        }
    } else {
        // 背景颜色
        self.bgColor = viewController.selectedColor;
        [self saveSettings];
        
        // 更新bgColorItem的显示
        if (self.bgColor) {
            CGFloat red, green, blue, alpha;
            [self.bgColor getRed:&red green:&green blue:&blue alpha:&alpha];
            self.bgColorItem.detail = [NSString stringWithFormat:@"R:%.0f G:%.0f B:%.0f A:%.0f", red * 255, green * 255, blue * 255, alpha * 100];
        } else {
            self.bgColorItem.detail = @"未设置";
        }
    }
    
    [self.tableView reloadData];
}

- (void)colorPickerViewControllerDidSelectColor:(UIColorPickerViewController *)viewController {
    // 根据tag判断是背景颜色还是描边颜色
    if (viewController.view.tag == 1001) {
        self.borderColor = viewController.selectedColor;
    } else {
        self.bgColor = viewController.selectedColor;
    }
    [self saveSettings];
}

- (void)resetToDefault {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认重置"
                                                                   message:@"确定要恢复默认设置吗？"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消"
                                              style:UIAlertActionStyleCancel
                                            handler:nil]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定"
                                              style:UIAlertActionStyleDestructive
                                            handler:^(UIAlertAction * _Nonnull action) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        // 获取所有图标路径并删除文件
        NSArray *iconKeys = @[kTabBarIconChatKey, kTabBarIconContactsKey, kTabBarIconDiscoverKey, kTabBarIconMeKey,
                             kTabBarIconSelectedChatKey, kTabBarIconSelectedContactsKey, kTabBarIconSelectedDiscoverKey, kTabBarIconSelectedMeKey];
        
        for (NSString *key in iconKeys) {
            NSString *filePath = [defaults stringForKey:key];
            if (filePath && [fileManager fileExistsAtPath:filePath]) {
                [fileManager removeItemAtPath:filePath error:nil];
            }
        }
        
        [defaults setBool:NO forKey:kTabBarStyleEnabledKey];
        [defaults setBool:NO forKey:kTabBarHideTextKey];
        
        [defaults removeObjectForKey:kTabBarIconChatKey];
        [defaults removeObjectForKey:kTabBarIconContactsKey];
        [defaults removeObjectForKey:kTabBarIconDiscoverKey];
        [defaults removeObjectForKey:kTabBarIconMeKey];
        
        [defaults removeObjectForKey:kTabBarIconSelectedChatKey];
        [defaults removeObjectForKey:kTabBarIconSelectedContactsKey];
        [defaults removeObjectForKey:kTabBarIconSelectedDiscoverKey];
        [defaults removeObjectForKey:kTabBarIconSelectedMeKey];
        
        // 重置新的样式设置
        [defaults setFloat:kDefaultCornerRadius forKey:kTabBarCornerRadiusKey];
        [defaults setFloat:kDefaultPositionOffset forKey:kTabBarPositionOffsetKey];
        [defaults setFloat:kDefaultScale forKey:kTabBarScaleKey];
        [defaults setInteger:kDefaultBorderStyle forKey:kTabBarBorderStyleKey];
        for (NSString *key in @[kTabBarContentHeightKey,kTabBarBorderWidthKey,kTabBarHapticFeedbackKey,kTabBarBorderAnimationKey,kTabBarBorderColorRedKey,kTabBarBorderColorGreenKey,kTabBarBorderColorBlueKey,kTabBarBorderColorAlphaKey]) [defaults removeObjectForKey:key];
        
        [defaults removeObjectForKey:kTabBarBgColorRedKey];
        [defaults removeObjectForKey:kTabBarBgColorGreenKey];
        [defaults removeObjectForKey:kTabBarBgColorBlueKey];
        [defaults removeObjectForKey:kTabBarBgColorAlphaKey];
        
        // 重置文本自定义
        [defaults removeObjectForKey:kTabBarTextChatKey];
        [defaults removeObjectForKey:kTabBarTextContactsKey];
        [defaults removeObjectForKey:kTabBarTextDiscoverKey];
        [defaults removeObjectForKey:kTabBarTextMeKey];
        
        [defaults synchronize];
        
        self.tabBarStyleEnabled = NO;
        self.hideText = NO;
        self.cornerRadius = kDefaultCornerRadius;
        self.positionOffset = kDefaultPositionOffset;
        self.scale = kDefaultScale;
        self.borderStyle = kDefaultBorderStyle;
        self.bgColor = [UIColor clearColor];
        self.chatText = nil;
        self.contactsText = nil;
        self.discoverText = nil;
        self.meText = nil;
        
        [self loadCurrentSettings];
        [self setupData];
        [self.tableView reloadData];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.enhance.tabbar_style.changed" object:nil];
        
        UIAlertController *successAlert = [UIAlertController alertControllerWithTitle:@"成功"
                                                                              message:@"已恢复默认设置"
                                                                       preferredStyle:UIAlertControllerStyleAlert];
        [successAlert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:successAlert animated:YES completion:nil];
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (!image) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    
    if (image) {
        // Preserve uploaded colors and alpha; white pixels may be intentional artwork.
        NSData *imageData = UIImagePNGRepresentation(image);
        if (imageData) {
            // 获取保存路径
            NSString *folderPath = [self getWeChatImproveFolderPath];
            if (!folderPath) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误"
                                                                               message:@"无法创建存储目录"
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alert animated:YES completion:nil];
                return;
            }
            
            NSString *fileName = [self getIconFileNameForType:self.currentIconType isSelected:self.isSelectingIcon];
            NSString *filePath = [folderPath stringByAppendingPathComponent:fileName];
            
            // 保存图片到文件
            NSError *error = nil;
            BOOL success = [imageData writeToFile:filePath options:NSDataWritingAtomic error:&error];
            
            if (success) {
                // 在NSUserDefaults中保存文件路径
                NSString *key = [self iconKeyForType:self.currentIconType isSelected:self.isSelectingIcon];
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:filePath forKey:key];
                [defaults synchronize];
                
                // 刷新界面显示新图标
                [self setupData];
                [self.tableView reloadData];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.enhance.tabbar_style.changed" object:nil];
                
                NSString *statusText = self.isSelectingIcon ? @"选中状态" : @"普通状态";
                NSString *tabName;
                switch (self.currentIconType) {
                    case TabBarIconTypeChat:
                        tabName = @"微信";
                        break;
                    case TabBarIconTypeContacts:
                        tabName = @"通讯录";
                        break;
                    case TabBarIconTypeDiscover:
                        tabName = @"发现";
                        break;
                    case TabBarIconTypeMe:
                        tabName = @"我";
                        break;
                }
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"设置成功"
                                                                               message:[NSString stringWithFormat:@"%@ %@图标已设置", tabName, statusText]
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alert animated:YES completion:nil];
            } else {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"保存失败"
                                                                               message:error.localizedDescription
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sections[section].items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CSSettingTableViewCell reuseIdentifier] forIndexPath:indexPath];
    
    CSSettingItem *item = self.sections[indexPath.section].items[indexPath.row];
    [cell configureWithItem:item];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CSSettingItem *item = self.sections[indexPath.section].items[indexPath.row];
    
    // 处理inputItem的点击
    if (item.itemType == CSSettingItemTypeInput) {
        [self showInputDialogForItem:item];
        return;
    }
    
    if (item.actionBlock) {
        item.actionBlock();
    }
}

- (void)showInputDialogForItem:(CSSettingItem *)item {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:item.title
                                                                   message:@"请输入数值"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = item.inputPlaceholder;
        textField.text = item.inputValue;
        textField.keyboardType = item.inputKeyboardType;
    }];
    
    __weak typeof(self) weakSelf = self;
    [alert addAction:[UIAlertAction actionWithTitle:@"确定"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = alert.textFields.firstObject;
        NSString *value = textField.text;
        
        // 更新item的值
        item.inputValue = value;
        item.detail = value;
        
        // 调用回调
        if (item.inputValueChanged) {
            item.inputValueChanged(value);
        }
        
        // Display the validated value rather than the unbounded input.
        [weakSelf loadCurrentSettings];
        [weakSelf setupData];
        [weakSelf.tableView reloadData];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sections[section].header;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return @"开启悬浮导航栏，配合隐藏文本使用更佳。";
    } else if (section == 1) {
        return @"为每个Tab设置自定义图标，支持普通和选中两种状态";
    } else if (section == 2) {
        return @"开启隐藏标签文本后，自定义文本不会显示。";
    }
    return nil;
}

@end
