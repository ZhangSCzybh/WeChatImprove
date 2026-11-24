#import "CSBackupMutation.h"
#import "CSManagedImageFile.h"
#import "CSTabBarStyleSettingsViewController.h"
#import "CSSettingTableViewCell.h"
#import <Photos/Photos.h>
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
@property (nonatomic, strong) CSSettingItem *swipeSwitchItem;

@property (nonatomic, strong) CSSettingItem *chatIconItem;
@property (nonatomic, strong) CSSettingItem *contactsIconItem;
@property (nonatomic, strong) CSSettingItem *discoverIconItem;
@property (nonatomic, strong) CSSettingItem *meIconItem;

// 样式设置项
@property (nonatomic, strong) CSSettingItem *borderStyleItem;
@property (nonatomic, strong) CSSettingItem *cornerRadiusItem;
@property (nonatomic, strong) CSSettingItem *bgColorItem;
@property (nonatomic, strong) CSSettingItem *positionOffsetItem;
@property (nonatomic, strong) CSSettingItem *scaleItem;
@property (nonatomic, strong) CSSettingItem *contentHeightItem;
@property (nonatomic, strong) CSSettingItem *borderWidthItem;
@property (nonatomic, strong) CSSettingItem *hapticFeedbackItem;
@property (nonatomic, strong) CSSettingItem *clickEffectItem;
@property (nonatomic, strong) CSSettingItem *indicatorColorItem;
@property (nonatomic, strong) CSSettingItem *selectedIconColorItem;
@property (nonatomic, strong) CSSettingItem *borderAnimationItem;
@property (nonatomic, strong) CSSettingItem *borderColorItem;

// 文本自定义设置项
@property (nonatomic, strong) CSSettingItem *chatTextItem;
@property (nonatomic, strong) CSSettingItem *contactsTextItem;
@property (nonatomic, strong) CSSettingItem *discoverTextItem;
@property (nonatomic, strong) CSSettingItem *meTextItem;

@property (nonatomic, assign) BOOL tabBarStyleEnabled;
@property (nonatomic, assign) BOOL hideText;
@property (nonatomic, assign) BOOL swipeSwitch;
@property (nonatomic, assign) NSInteger borderStyle;
@property (nonatomic, assign) NSInteger hapticFeedback;
@property (nonatomic, assign) CSTabBarClickEffect clickEffect;
@property (nonatomic, assign) NSInteger borderAnimation;

// 样式属性
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, strong) UIColor *indicatorColor;
@property (nonatomic, strong) UIColor *selectedIconColor;
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
    self.swipeSwitch=p.swipeSwitch;
    self.cornerRadius=p.cornerRadius; self.positionOffset=p.lift; self.scale=p.scale;
    self.contentHeight=p.contentHeight; self.borderWidth=p.borderWidth;
    self.borderStyle=p.borderStyle; self.hapticFeedback=p.haptic; self.borderAnimation=p.animation;
    self.clickEffect=p.clickEffect;
    self.bgColor=p.backgroundColor; self.borderColor=p.borderColor;
    self.indicatorColor=p.indicatorColor;
    self.selectedIconColor=p.selectedIconColor;
    self.chatText=[p titleAtIndex:0]; self.contactsText=[p titleAtIndex:1];
    self.discoverText=[p titleAtIndex:2]; self.meText=[p titleAtIndex:3];
}

- (void)saveValue:(id)value forKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (value) [defaults setObject:value forKey:key];
    else [defaults removeObjectForKey:key];
    [self finishSavingSettings];
}

- (void)synchronizeSettings {
    NSUserDefaults *defaults=NSUserDefaults.standardUserDefaults;
    [defaults synchronize];
}

- (void)finishSavingSettings {
    // Keep the existing durability/backup boundary and external refresh signal.
    [self synchronizeSettings];
    [[NSNotificationCenter defaultCenter] postNotificationName:CSTabBarPreferencesDidChange object:nil];
}

- (void)saveColorSetting:(BOOL)border {
    [self saveColor:border ? self.borderColor : self.bgColor
          withRedKey:border ? kTabBarBorderColorRedKey : kTabBarBgColorRedKey
          greenKey:border ? kTabBarBorderColorGreenKey : kTabBarBgColorGreenKey
          blueKey:border ? kTabBarBorderColorBlueKey : kTabBarBgColorBlueKey
          alphaKey:border ? kTabBarBorderColorAlphaKey : kTabBarBgColorAlphaKey];
    [self finishSavingSettings];
}

- (void)refreshVisibleItems:(NSArray<CSSettingItem *> *)items {
    for (NSIndexPath *path in self.tableView.indexPathsForVisibleRows) {
        CSSettingItem *item=self.sections[path.section].items[path.row];
        if (![items containsObject:item]) continue;
        CSSettingTableViewCell *cell=[self.tableView cellForRowAtIndexPath:path];
        [cell configureWithItem:item];
        [self applyIndicatorAvailabilityToCell:cell item:item];
    }
}

- (void)applyIndicatorAvailabilityToCell:(CSSettingTableViewCell *)cell item:(CSSettingItem *)item {
    BOOL unavailable=item==self.indicatorColorItem && self.clickEffect==CSTabBarClickEffectNone;
    cell.contentView.alpha=unavailable ? .45 : 1;
    cell.userInteractionEnabled=!unavailable;
    if (unavailable) cell.selectionStyle=UITableViewCellSelectionStyleNone;
}

- (void)saveIndicatorColorSetting {
    [self saveColor:self.indicatorColor withRedKey:kTabBarIndicatorColorRedKey
          greenKey:kTabBarIndicatorColorGreenKey blueKey:kTabBarIndicatorColorBlueKey
          alphaKey:kTabBarIndicatorColorAlphaKey];
    [self finishSavingSettings];
}

- (void)updateIndicatorColorDetail {
    CGFloat red=0,green=0,blue=0,alpha=0;
    if (self.clickEffect==CSTabBarClickEffectNone) self.indicatorColorItem.detail=@"开启切换特效后可用";
    else if (self.indicatorColor && [self.indicatorColor getRed:&red green:&green blue:&blue alpha:&alpha])
        self.indicatorColorItem.detail=[NSString stringWithFormat:@"R:%.0f G:%.0f B:%.0f A:%.0f",red*255,green*255,blue*255,alpha*100];
    else self.indicatorColorItem.detail=@"默认（随浅色/深色）";
}

- (void)refreshIndicatorColorItem {
    [self updateIndicatorColorDetail];
    [self refreshVisibleItems:@[self.indicatorColorItem]];
}

- (void)saveSelectedIconColorSetting {
    [self saveColor:self.selectedIconColor withRedKey:kTabBarSelectedIconColorRedKey
          greenKey:kTabBarSelectedIconColorGreenKey blueKey:kTabBarSelectedIconColorBlueKey
          alphaKey:kTabBarSelectedIconColorAlphaKey];
    [self finishSavingSettings];
}

- (void)updateSelectedIconColorDetail {
    CGFloat red=0,green=0,blue=0,alpha=0;
    self.selectedIconColorItem.detail=self.selectedIconColor && [self.selectedIconColor getRed:&red green:&green blue:&blue alpha:&alpha] ?
        [NSString stringWithFormat:@"R:%.0f G:%.0f B:%.0f A:%.0f",red*255,green*255,blue*255,alpha*100] : @"原生默认（随浅色/深色）";
}

- (void)refreshSelectedIconColorItem {
    [self updateSelectedIconColorDetail];
    [self refreshVisibleItems:@[self.selectedIconColorItem]];
}

- (void)refreshInputItem:(CSSettingItem *)item {
    // Display the same validated formats used by setupData, without rebuilding
    // unrelated models/previews or resetting the table's scroll position.
    if (item==self.cornerRadiusItem) item.inputValue=[NSString stringWithFormat:@"%.1f",self.cornerRadius];
    else if (item==self.positionOffsetItem) item.inputValue=[NSString stringWithFormat:@"%.1f",self.positionOffset];
    else if (item==self.contentHeightItem) item.inputValue=[NSString stringWithFormat:@"%.0f",self.contentHeight];
    else if (item==self.borderWidthItem) item.inputValue=[NSString stringWithFormat:@"%.1f",self.borderWidth];
    else if (item==self.chatTextItem) item.inputValue=self.chatText ?: @"";
    else if (item==self.contactsTextItem) item.inputValue=self.contactsText ?: @"";
    else if (item==self.discoverTextItem) item.inputValue=self.discoverText ?: @"";
    else if (item==self.meTextItem) item.inputValue=self.meText ?: @"";
    item.detail=item.inputValue;
    [self refreshVisibleItems:@[item]];
}

- (void)refreshColorItem:(BOOL)border {
    UIColor *color=border ? self.borderColor : self.bgColor;
    CSSettingItem *item=border ? self.borderColorItem : self.bgColorItem;
    CGFloat red=0,green=0,blue=0,alpha=0;
    item.detail=color && [color getRed:&red green:&green blue:&blue alpha:&alpha] ?
        [NSString stringWithFormat:@"R:%.0f G:%.0f B:%.0f A:%.0f",red*255,green*255,blue*255,alpha*100] :
        (border ? @"点击选择" : @"跟随原生");
    [self refreshVisibleItems:@[item]];
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
    self.enableItem = [CSSettingItem switchItemWithTitle:@"启用悬浮底栏"
                                              iconName:@"rectangle.bottomthird.inset.filled"
                                             iconColor:[UIColor systemBlueColor]
                                            switchValue:self.tabBarStyleEnabled
                                       valueChangedBlock:^(BOOL isOn) {
        weakSelf.tabBarStyleEnabled = isOn;
        [weakSelf saveValue:@(isOn) forKey:kTabBarStyleEnabledKey];
        [weakSelf updateIconItemsState];
    }];
    
    self.hideTextItem = [CSSettingItem switchItemWithTitle:@"隐藏标签文本"
                                                iconName:@"textformat.abc.dottedunderline"
                                               iconColor:[UIColor systemOrangeColor]
                                              switchValue:self.hideText
                                         valueChangedBlock:^(BOOL isOn) {
        weakSelf.hideText = isOn;
        [weakSelf saveValue:@(isOn) forKey:kTabBarHideTextKey];
    }];
    
    self.swipeSwitchItem = [CSSettingItem switchItemWithTitle:@"左右滑动切换"
                                                   iconName:@"arrow.left.and.right"
                                                  iconColor:[UIColor systemTealColor]
                                                switchValue:self.swipeSwitch
                                          valueChangedBlock:^(BOOL isOn) {
        weakSelf.swipeSwitch = isOn;
        [weakSelf saveValue:@(isOn) forKey:kTabBarSwipeSwitchKey];
    }];

    // 加载已上传的图标
    UIImage *chatIcon = [self loadIconForType:TabBarIconTypeChat isSelected:NO];
    UIImage *contactsIcon = [self loadIconForType:TabBarIconTypeContacts isSelected:NO];
    UIImage *discoverIcon = [self loadIconForType:TabBarIconTypeDiscover isSelected:NO];
    UIImage *meIcon = [self loadIconForType:TabBarIconTypeMe isSelected:NO];
    
    self.chatIconItem = [CSSettingItem itemWithTitle:@"替换微信图标"
                                          iconName:chatIcon ? nil : @"message.fill"
                                         iconColor:[UIColor systemGreenColor]
                                            detail:chatIcon ? @"已设置" : @"点击设置"];
    self.chatIconItem.customImage = chatIcon;
    self.chatIconItem.actionBlock = ^{
        [weakSelf showIconSelectionAlertForType:TabBarIconTypeChat];
    };
    
    self.contactsIconItem = [CSSettingItem itemWithTitle:@"替换通讯图标"
                                             iconName:contactsIcon ? nil : @"person.2.fill"
                                            iconColor:[UIColor systemBlueColor]
                                               detail:contactsIcon ? @"已设置" : @"点击设置"];
    self.contactsIconItem.customImage = contactsIcon;
    self.contactsIconItem.actionBlock = ^{
        [weakSelf showIconSelectionAlertForType:TabBarIconTypeContacts];
    };
    
    self.discoverIconItem = [CSSettingItem itemWithTitle:@"替换发现图标"
                                             iconName:discoverIcon ? nil : @"safari.fill"
                                            iconColor:[UIColor systemOrangeColor]
                                               detail:discoverIcon ? @"已设置" : @"点击设置"];
    self.discoverIconItem.customImage = discoverIcon;
    self.discoverIconItem.actionBlock = ^{
        [weakSelf showIconSelectionAlertForType:TabBarIconTypeDiscover];
    };
    
    self.meIconItem = [CSSettingItem itemWithTitle:@"替换我的图标"
                                       iconName:meIcon ? nil : @"person.crop.circle.fill"
                                      iconColor:[UIColor systemPurpleColor]
                                         detail:meIcon ? @"已设置" : @"点击设置"];
    self.meIconItem.customImage = meIcon;
    self.meIconItem.actionBlock = ^{
        [weakSelf showIconSelectionAlertForType:TabBarIconTypeMe];
    };
    
    [self updateIconItemsState];

    self.selectedIconColorItem=[CSSettingItem itemWithTitle:@"选中图标颜色"
        iconName:@"paintpalette.fill" iconColor:UIColor.systemGreenColor detail:nil];
    [self updateSelectedIconColorDetail];
    self.selectedIconColorItem.actionBlock=^{
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"选中图标颜色"
            message:@"仅修改原生图标的选中颜色。已上传的图标（含普通图标回退）保持图片原色；原生默认随微信浅色和深色外观变化。" preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"自定义颜色" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action) {
            [weakSelf showSelectedIconColorPicker];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"恢复原生默认" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action) {
            weakSelf.selectedIconColor=nil;
            [weakSelf saveSelectedIconColorSetting];
            [weakSelf refreshSelectedIconColorItem];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        if (alert.popoverPresentationController) {
            alert.popoverPresentationController.sourceView=weakSelf.view;
            alert.popoverPresentationController.sourceRect=CGRectMake(CGRectGetMidX(weakSelf.view.bounds),CGRectGetMidY(weakSelf.view.bounds),1,1);
            alert.popoverPresentationController.permittedArrowDirections=0;
        }
        [weakSelf presentViewController:alert animated:YES completion:nil];
    };
    
    // 创建文本自定义设置项
    self.chatTextItem = [CSSettingItem inputItemWithTitle:@"替换微信文本"
                                                iconName:@"message.fill"
                                               iconColor:[UIColor systemGreenColor]
                                               inputValue:self.chatText ?: @""
                                           inputPlaceholder:@"输入自定义文本"
                                          valueChangedBlock:^(NSString *value) {
        weakSelf.chatText = value.length > 0 ? value : nil;
        [weakSelf saveValue:weakSelf.chatText forKey:kTabBarTextChatKey];
    }];
    
    self.contactsTextItem = [CSSettingItem inputItemWithTitle:@"替换通讯文本"
                                                   iconName:@"person.2.fill"
                                                  iconColor:[UIColor systemBlueColor]
                                                  inputValue:self.contactsText ?: @""
                                              inputPlaceholder:@"输入自定义文本"
                                             valueChangedBlock:^(NSString *value) {
        weakSelf.contactsText = value.length > 0 ? value : nil;
        [weakSelf saveValue:weakSelf.contactsText forKey:kTabBarTextContactsKey];
    }];
    
    self.discoverTextItem = [CSSettingItem inputItemWithTitle:@"替换发现文本"
                                                   iconName:@"safari.fill"
                                                  iconColor:[UIColor systemOrangeColor]
                                                  inputValue:self.discoverText ?: @""
                                              inputPlaceholder:@"输入自定义文本"
                                             valueChangedBlock:^(NSString *value) {
        weakSelf.discoverText = value.length > 0 ? value : nil;
        [weakSelf saveValue:weakSelf.discoverText forKey:kTabBarTextDiscoverKey];
    }];
    
    self.meTextItem = [CSSettingItem inputItemWithTitle:@"替换我的文本"
                                             iconName:@"person.crop.circle.fill"
                                            iconColor:[UIColor systemPurpleColor]
                                            inputValue:self.meText ?: @""
                                        inputPlaceholder:@"输入自定义文本"
                                       valueChangedBlock:^(NSString *value) {
        weakSelf.meText = value.length > 0 ? value : nil;
        [weakSelf saveValue:weakSelf.meText forKey:kTabBarTextMeKey];
    }];
    
    // 创建样式设置项
    // 边框样式
    NSArray *borderStyleOptions = @[@"半圆", @"圆角"];
    NSString *borderStyleDetail = borderStyleOptions[self.borderStyle];
    
    self.borderStyleItem = [CSSettingItem itemWithTitle:@"选择边框样式"
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
                [weakSelf saveValue:@(i) forKey:kTabBarBorderStyleKey];
                [weakSelf refreshVisibleItems:@[weakSelf.borderStyleItem]];
            }];
            [alert addAction:action];
        }
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                               style:UIAlertActionStyleCancel
                                                             handler:nil];
        [alert addAction:cancelAction];
        
        [weakSelf presentViewController:alert animated:YES completion:nil];
    };
    
    self.cornerRadiusItem = [CSSettingItem inputItemWithTitle:@"圆角半径大小"
                                                   iconName:@"rectangle.roundedtop"
                                                  iconColor:[UIColor systemPurpleColor]
                                                  inputValue:[NSString stringWithFormat:@"%.1f", self.cornerRadius]
                                              inputPlaceholder:@"输入圆角（0–40 pt）"
                                             valueChangedBlock:^(NSString *value) {
        CGFloat radius = [value floatValue];
        radius = CSTabBarClamp(radius,0,40,kDefaultCornerRadius);
        weakSelf.cornerRadius = radius;
        [weakSelf saveValue:@((float)radius) forKey:kTabBarCornerRadiusKey];
    }];
    self.cornerRadiusItem.inputKeyboardType = UIKeyboardTypeDecimalPad; // 数字键盘
    
    NSString *bgColorDetail = @"跟随原生";
    if (self.bgColor) {
        CGFloat red, green, blue, alpha;
        [self.bgColor getRed:&red green:&green blue:&blue alpha:&alpha];
        bgColorDetail = [NSString stringWithFormat:@"R:%.0f G:%.0f B:%.0f A:%.0f", red * 255, green * 255, blue * 255, alpha * 100];
    }
    
    self.bgColorItem = [CSSettingItem itemWithTitle:@"选择背景颜色"
                                         iconName:@"paintpalette.fill"
                                        iconColor:[UIColor systemPinkColor]
                                           detail:bgColorDetail];
    self.bgColorItem.actionBlock = ^{
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"背景颜色" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"自定义颜色" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) { [weakSelf showColorPicker]; }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"跟随原生" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            weakSelf.bgColor=nil; [weakSelf saveColorSetting:NO]; [weakSelf refreshColorItem:NO];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [weakSelf presentViewController:alert animated:YES completion:nil];
    };
    
    // 底栏切换触感
    NSArray *hapticOptions = @[@"无", @"舒适", @"轻柔", @"中度", @"强烈"];
    NSString *hapticDetail = hapticOptions[self.hapticFeedback];
    
    self.hapticFeedbackItem = [CSSettingItem itemWithTitle:@"切换点击触感"
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
                [weakSelf saveValue:@(i) forKey:kTabBarHapticFeedbackKey];
                [weakSelf refreshVisibleItems:@[weakSelf.hapticFeedbackItem]];
            }];
            [alert addAction:action];
        }
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                               style:UIAlertActionStyleCancel
                                                             handler:nil];
        [alert addAction:cancelAction];
        
        [weakSelf presentViewController:alert animated:YES completion:nil];
    };
    
    NSArray *clickOptions = @[@"关闭", @"下划线", @"胶囊"];
    NSArray<NSNumber *> *clickValues = @[@(CSTabBarClickEffectNone), @(CSTabBarClickEffectBounce), @(CSTabBarClickEffectCapsule)];
    NSUInteger currentClickOption = [clickValues indexOfObject:@(self.clickEffect)];
    self.clickEffectItem = [CSSettingItem itemWithTitle:@"切换点击特效"
                                             iconName:@"arrow.up.and.down"
                                            iconColor:[UIColor systemPurpleColor]
                                               detail:clickOptions[currentClickOption==NSNotFound ? 0 : currentClickOption]];
    self.clickEffectItem.actionBlock = ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"切换点击特效"
            message:@"下划线和胶囊均在按下时响应，拖动时同向跟随手指并轻微形变；按下和拖动只作预览，不切换中间页面。开启左右滑动切换后，松手时只切到抬手处的有效项目一次；取消或结束位置无效时不切换。松手后指示器弹性归位。与切换触感独立设置；开启系统“减弱动态效果”时直接落位。"
            preferredStyle:UIAlertControllerStyleActionSheet];
        for (NSUInteger i = 0; i < clickOptions.count; i++) {
            [alert addAction:[UIAlertAction actionWithTitle:clickOptions[i] style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action) {
                NSNumber *value=clickValues[i];
                weakSelf.clickEffect=(CSTabBarClickEffect)value.integerValue;
                weakSelf.clickEffectItem.detail=clickOptions[i];
                [weakSelf saveValue:value forKey:kTabBarClickEffectKey];
                [weakSelf updateIndicatorColorDetail];
                [weakSelf refreshVisibleItems:@[weakSelf.clickEffectItem,weakSelf.indicatorColorItem]];
            }]];
        }
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        if (alert.popoverPresentationController) {
            alert.popoverPresentationController.sourceView=weakSelf.view;
            alert.popoverPresentationController.sourceRect=CGRectMake(CGRectGetMidX(weakSelf.view.bounds),CGRectGetMidY(weakSelf.view.bounds),1,1);
            alert.popoverPresentationController.permittedArrowDirections=0;
        }
        [weakSelf presentViewController:alert animated:YES completion:nil];
    };

    self.indicatorColorItem=[CSSettingItem itemWithTitle:@"选择指示器颜色"
        iconName:@"capsule.fill" iconColor:UIColor.systemGrayColor detail:nil];
    [self updateIndicatorColorDetail];
    self.indicatorColorItem.actionBlock=^{
        if (weakSelf.clickEffect==CSTabBarClickEffectNone) return;
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"选择指示器颜色"
            message:@"默认颜色随浅色和深色外观变化。" preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"自定义颜色" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action) {
            [weakSelf showIndicatorColorPicker];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"恢复默认" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action) {
            weakSelf.indicatorColor=nil;
            [weakSelf saveIndicatorColorSetting];
            [weakSelf refreshIndicatorColorItem];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        if (alert.popoverPresentationController) {
            alert.popoverPresentationController.sourceView=weakSelf.view;
            alert.popoverPresentationController.sourceRect=CGRectMake(CGRectGetMidX(weakSelf.view.bounds),CGRectGetMidY(weakSelf.view.bounds),1,1);
            alert.popoverPresentationController.permittedArrowDirections=0;
        }
        [weakSelf presentViewController:alert animated:YES completion:nil];
    };

    // 底栏边框描边动画
    NSArray *animationOptions = @[@"无动画", @"扩散呼吸", @"扩散心跳", @"经典呼吸", @"经典心跳"];
    NSString *animationDetail = animationOptions[self.borderAnimation];
    
    self.borderAnimationItem = [CSSettingItem itemWithTitle:@"选择描边动画"
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
                [weakSelf saveValue:@(i) forKey:kTabBarBorderAnimationKey];
                [weakSelf refreshVisibleItems:@[weakSelf.borderAnimationItem]];
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
    
    self.borderColorItem = [CSSettingItem itemWithTitle:@"选择描边颜色"
                                             iconName:@"paintbrush.fill"
                                            iconColor:[UIColor systemIndigoColor]
                                               detail:borderColorDetail];
    self.borderColorItem.actionBlock = ^{
        [weakSelf showBorderColorPicker];
    };
    
    self.positionOffsetItem = [CSSettingItem inputItemWithTitle:@"向上偏移距离"
                                                     iconName:@"arrow.up.and.down"
                                                    iconColor:[UIColor systemOrangeColor]
                                                    inputValue:[NSString stringWithFormat:@"%.1f", self.positionOffset]
                                                inputPlaceholder:@"距底边距离（0–100 pt，0 为贴底）"
                                               valueChangedBlock:^(NSString *value) {
        CGFloat offset = [value floatValue];
        offset = CSTabBarClamp(offset,0,100,0);
        weakSelf.positionOffset = offset;
        [weakSelf saveValue:@((float)offset) forKey:kTabBarPositionOffsetKey];
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
    
    self.scaleItem = [CSSettingItem itemWithTitle:@"选择底栏宽度"
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
                [weakSelf saveValue:@((float)weakSelf.scale) forKey:kTabBarScaleKey];
                [weakSelf refreshVisibleItems:@[weakSelf.scaleItem]];
            }];
            [alert addAction:action];
        }
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                               style:UIAlertActionStyleCancel
                                                             handler:nil];
        [alert addAction:cancelAction];
        
        [weakSelf presentViewController:alert animated:YES completion:nil];
    };
    
    self.contentHeightItem=[CSSettingItem inputItemWithTitle:@"输入底栏高度"
        iconName:@"arrow.up.and.down" iconColor:UIColor.systemTealColor
        inputValue:[NSString stringWithFormat:@"%.0f",self.contentHeight]
        inputPlaceholder:@"内容高度（44–80 pt）" valueChangedBlock:^(NSString *value) {
            weakSelf.contentHeight=(float)CSTabBarClamp(value.doubleValue,44,80,52);
            [weakSelf saveValue:@((float)weakSelf.contentHeight) forKey:kTabBarContentHeightKey];
        }];
    self.contentHeightItem.inputKeyboardType=UIKeyboardTypeDecimalPad;
    self.borderWidthItem=[CSSettingItem inputItemWithTitle:@"描边宽度大小"
        iconName:@"pencil.tip" iconColor:UIColor.systemIndigoColor
        inputValue:[NSString stringWithFormat:@"%.1f",self.borderWidth]
        inputPlaceholder:@"描边宽度（0–6 pt，0 为关闭）" valueChangedBlock:^(NSString *value) {
            weakSelf.borderWidth=(float)CSTabBarClamp(value.doubleValue,0,6,1);
            [weakSelf saveValue:@((float)weakSelf.borderWidth) forKey:kTabBarBorderWidthKey];
        }];
    self.borderWidthItem.inputKeyboardType=UIKeyboardTypeDecimalPad;

    CSSettingSection *mainSection = [CSSettingSection sectionWithHeader:@"主设置"
                                                                items:@[self.enableItem, self.hideTextItem, self.swipeSwitchItem]];
    
    CSSettingSection *iconSection = [CSSettingSection sectionWithHeader:@"图标自定义"
                                                                items:@[self.chatIconItem,
                                                                       self.contactsIconItem,
                                                                       self.discoverIconItem,
                                                                       self.meIconItem,
                                                                       self.selectedIconColorItem]];
    
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
                                                                       self.clickEffectItem,
                                                                       self.indicatorColorItem,
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
    
    [self refreshVisibleItems:@[self.hideTextItem,self.chatIconItem,self.contactsIconItem,self.discoverIconItem,self.meIconItem]];
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
            title = @"替换微信图标";
            break;
        case TabBarIconTypeContacts:
            title = @"替换通讯图标";
            break;
        case TabBarIconTypeDiscover:
            title = @"替换发现图标";
            break;
        case TabBarIconTypeMe:
            title = @"替换我的图标";
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
    
    CSManagedImageRemove(normalPath, NULL);
    CSManagedImageRemove(selectedPath, NULL);
    [CSTabBarPreferences invalidateIconAtPath:normalPath resourceIdentifier:normalKey];
    [CSTabBarPreferences invalidateIconAtPath:selectedPath resourceIdentifier:selectedKey];
    
    // 清除NSUserDefaults中的路径
    [defaults removeObjectForKey:normalKey];
    [defaults removeObjectForKey:selectedKey];
    [self synchronizeSettings];
    
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
        if (![fileManager createDirectoryAtPath:enhanceFolderPath
                    withIntermediateDirectories:YES attributes:nil error:nil]) {
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
    NSString *iconPath = [NSUserDefaults.standardUserDefaults stringForKey:key];
    return [CSTabBarPreferences cachedIconAtPath:iconPath resourceIdentifier:key];
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

- (void)showIndicatorColorPicker {
    UIColorPickerViewController *colorPicker=[UIColorPickerViewController new];
    colorPicker.delegate=self;
    BOOL dark=self.traitCollection.userInterfaceStyle==UIUserInterfaceStyleDark;
    colorPicker.selectedColor=self.indicatorColor ?: [UIColor colorWithWhite:dark ? 1 : 0 alpha:dark ? .12 : .08];
    colorPicker.view.tag=1002;
    [self presentViewController:colorPicker animated:YES completion:nil];
}

- (void)showSelectedIconColorPicker {
    UIColorPickerViewController *colorPicker=[UIColorPickerViewController new];
    colorPicker.delegate=self;
    colorPicker.selectedColor=self.selectedIconColor ?: UIColor.systemGreenColor;
    colorPicker.view.tag=1003;
    [self presentViewController:colorPicker animated:YES completion:nil];
}

#pragma mark - UIColorPickerViewControllerDelegate

- (void)colorPickerViewControllerDidFinish:(UIColorPickerViewController *)viewController {
    // Selecting a color saves live. Merely opening/dismissing must preserve nil.
    if (viewController.view.tag==1002 || viewController.view.tag==1003) return;
    BOOL border=viewController.view.tag==1001;
    if (border) self.borderColor=viewController.selectedColor;
    else self.bgColor=viewController.selectedColor;
    [self saveColorSetting:border];
    [self refreshColorItem:border];
}

- (void)colorPickerViewControllerDidSelectColor:(UIColorPickerViewController *)viewController {
    if (viewController.view.tag==1003) {
        self.selectedIconColor=viewController.selectedColor;
        [self saveSelectedIconColorSetting];
        [self refreshSelectedIconColorItem];
        return;
    }
    if (viewController.view.tag==1002) {
        self.indicatorColor=viewController.selectedColor;
        [self saveIndicatorColorSetting];
        [self refreshIndicatorColorItem];
        return;
    }
    BOOL border=viewController.view.tag==1001;
    if (border) self.borderColor=viewController.selectedColor;
    else self.bgColor=viewController.selectedColor;
    [self saveColorSetting:border];
    [self refreshColorItem:border];
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
        
        // 获取所有图标路径并删除文件
        NSArray *iconKeys = @[kTabBarIconChatKey, kTabBarIconContactsKey, kTabBarIconDiscoverKey, kTabBarIconMeKey,
                             kTabBarIconSelectedChatKey, kTabBarIconSelectedContactsKey, kTabBarIconSelectedDiscoverKey, kTabBarIconSelectedMeKey];
        
        CSBackupResourceMutationScope();
        for (NSString *key in iconKeys) {
            NSString *filePath = [defaults stringForKey:key];
            CSManagedImageRemove(filePath, NULL);
            [CSTabBarPreferences invalidateIconAtPath:filePath resourceIdentifier:key];
        }
        
        [defaults setBool:NO forKey:kTabBarStyleEnabledKey];
        [defaults setBool:NO forKey:kTabBarHideTextKey];
        [defaults removeObjectForKey:kTabBarSwipeSwitchKey];
        
        [defaults removeObjectForKey:kTabBarIconChatKey];
        [defaults removeObjectForKey:kTabBarIconContactsKey];
        [defaults removeObjectForKey:kTabBarIconDiscoverKey];
        [defaults removeObjectForKey:kTabBarIconMeKey];
        
        [defaults removeObjectForKey:kTabBarIconSelectedChatKey];
        [defaults removeObjectForKey:kTabBarIconSelectedContactsKey];
        [defaults removeObjectForKey:kTabBarIconSelectedDiscoverKey];
        [defaults removeObjectForKey:kTabBarIconSelectedMeKey];
        
        // 重置样式设置
        [defaults setFloat:kDefaultCornerRadius forKey:kTabBarCornerRadiusKey];
        [defaults setFloat:kDefaultPositionOffset forKey:kTabBarPositionOffsetKey];
        [defaults setFloat:kDefaultScale forKey:kTabBarScaleKey];
        [defaults setInteger:kDefaultBorderStyle forKey:kTabBarBorderStyleKey];
        for (NSString *key in @[kTabBarContentHeightKey,kTabBarBorderWidthKey,kTabBarHapticFeedbackKey,kTabBarClickEffectKey,kTabBarBorderAnimationKey,kTabBarBorderColorRedKey,kTabBarBorderColorGreenKey,kTabBarBorderColorBlueKey,kTabBarBorderColorAlphaKey]) [defaults removeObjectForKey:key];
        for (NSString *key in @[kTabBarIndicatorColorRedKey,kTabBarIndicatorColorGreenKey,kTabBarIndicatorColorBlueKey,kTabBarIndicatorColorAlphaKey]) [defaults removeObjectForKey:key];
        for (NSString *key in @[kTabBarSelectedIconColorRedKey,kTabBarSelectedIconColorGreenKey,kTabBarSelectedIconColorBlueKey,kTabBarSelectedIconColorAlphaKey]) [defaults removeObjectForKey:key];
        
        [defaults removeObjectForKey:kTabBarBgColorRedKey];
        [defaults removeObjectForKey:kTabBarBgColorGreenKey];
        [defaults removeObjectForKey:kTabBarBgColorBlueKey];
        [defaults removeObjectForKey:kTabBarBgColorAlphaKey];
        
        // 重置文本自定义
        [defaults removeObjectForKey:kTabBarTextChatKey];
        [defaults removeObjectForKey:kTabBarTextContactsKey];
        [defaults removeObjectForKey:kTabBarTextDiscoverKey];
        [defaults removeObjectForKey:kTabBarTextMeKey];
        
        [self synchronizeSettings];
        
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
    CSBackupResourceMutationScope();
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
                [CSTabBarPreferences invalidateIconAtPath:filePath resourceIdentifier:key];
                [defaults setObject:filePath forKey:key];
                [self synchronizeSettings];
                
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
    [self applyIndicatorAvailabilityToCell:cell item:item];
    
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
        
        [weakSelf refreshInputItem:item];
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
        return @"图标支持普通和选中两种状态；上传图片始终保留原色，选中图标颜色仅作用于原生图标。";
    } else if (section == 2) {
        return @"开启隐藏标签文本后，自定义文本不会显示。";
    }
    return nil;
}

@end
