//
//  CSBubbleStyleSettingsViewController.m
//  气泡样式设置界面实现
//

#import "CSBubbleStyleSettingsViewController.h"
#import "CSSettingTableViewCell.h"

static NSString * const kBubbleStyleEnabledKey = @"com.wechat.enhance.bubble_style.enabled";
static NSString * const kBubbleCornerRadiusKey = @"com.wechat.enhance.bubble_style.corner_radius";
static NSString * const kBubbleStyleSettingsChangedNotification = @"com.wechat.enhance.bubble_style.settings_changed";

static NSString * const kBubbleSenderLightColorRedKey = @"com.wechat.enhance.bubble_style.sender_light_color.red";
static NSString * const kBubbleSenderLightColorGreenKey = @"com.wechat.enhance.bubble_style.sender_light_color.green";
static NSString * const kBubbleSenderLightColorBlueKey = @"com.wechat.enhance.bubble_style.sender_light_color.blue";
static NSString * const kBubbleSenderLightColorAlphaKey = @"com.wechat.enhance.bubble_style.sender_light_color.alpha";

static NSString * const kBubbleReceiverLightColorRedKey = @"com.wechat.enhance.bubble_style.receiver_light_color.red";
static NSString * const kBubbleReceiverLightColorGreenKey = @"com.wechat.enhance.bubble_style.receiver_light_color.green";
static NSString * const kBubbleReceiverLightColorBlueKey = @"com.wechat.enhance.bubble_style.receiver_light_color.blue";
static NSString * const kBubbleReceiverLightColorAlphaKey = @"com.wechat.enhance.bubble_style.receiver_light_color.alpha";

static NSString * const kBubbleSenderDarkColorRedKey = @"com.wechat.enhance.bubble_style.sender_dark_color.red";
static NSString * const kBubbleSenderDarkColorGreenKey = @"com.wechat.enhance.bubble_style.sender_dark_color.green";
static NSString * const kBubbleSenderDarkColorBlueKey = @"com.wechat.enhance.bubble_style.sender_dark_color.blue";
static NSString * const kBubbleSenderDarkColorAlphaKey = @"com.wechat.enhance.bubble_style.sender_dark_color.alpha";

static NSString * const kBubbleReceiverDarkColorRedKey = @"com.wechat.enhance.bubble_style.receiver_dark_color.red";
static NSString * const kBubbleReceiverDarkColorGreenKey = @"com.wechat.enhance.bubble_style.receiver_dark_color.green";
static NSString * const kBubbleReceiverDarkColorBlueKey = @"com.wechat.enhance.bubble_style.receiver_dark_color.blue";
static NSString * const kBubbleReceiverDarkColorAlphaKey = @"com.wechat.enhance.bubble_style.receiver_dark_color.alpha";

static NSString * const kMergeMessagesEnabledKey = @"com.wechat.enhance.merge_messages.enabled";
static NSString * const kMergeMessagesScopeKey = @"com.wechat.enhance.merge_messages.scope";
static NSString * const kMergeMessagesSpacingKey = @"com.wechat.enhance.merge_messages.spacing";
static NSString * const kMergeMessagesAvatarPositionKey = @"com.wechat.enhance.merge_messages.avatar_position";
static NSString * const kConsecutiveMessagesSpacingKey = @"com.wechat.enhance.consecutive_messages.spacing";

static const CGFloat kDefaultCornerRadius = 16.0;
static const CGFloat kDefaultConsecutiveSpacing = 4.0;

@interface BubbleColorPreviewView : UIView
@property (nonatomic, strong) UIColor *previewColor;
@end

@implementation BubbleColorPreviewView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = frame.size.height / 2;
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.previewColor = [UIColor redColor];
    }
    return self;
}

- (void)setPreviewColor:(UIColor *)previewColor {
    _previewColor = previewColor;
    self.backgroundColor = previewColor;
    [self setNeedsDisplay];
}

@end

@interface CSBubbleStyleSettingsViewController () <UIColorPickerViewControllerDelegate>

@property (nonatomic, strong) NSArray<CSSettingSection *> *sections;
@property (nonatomic, strong) CSSettingItem *cornerRadiusItem;
@property (nonatomic, assign) CGFloat cornerRadius;

@property (nonatomic, strong) CSSettingItem *senderLightColorItem;
@property (nonatomic, strong) CSSettingItem *receiverLightColorItem;
@property (nonatomic, strong) CSSettingItem *senderDarkColorItem;
@property (nonatomic, strong) CSSettingItem *receiverDarkColorItem;

@property (nonatomic, strong) BubbleColorPreviewView *senderLightColorPreview;
@property (nonatomic, strong) BubbleColorPreviewView *receiverLightColorPreview;
@property (nonatomic, strong) BubbleColorPreviewView *senderDarkColorPreview;
@property (nonatomic, strong) BubbleColorPreviewView *receiverDarkColorPreview;

@property (nonatomic, strong) UIColor *senderLightColor;
@property (nonatomic, strong) UIColor *receiverLightColor;
@property (nonatomic, strong) UIColor *senderDarkColor;
@property (nonatomic, strong) UIColor *receiverDarkColor;

@property (nonatomic, assign) NSInteger currentColorType;

@end

@implementation CSBubbleStyleSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"气泡样式";
    self.tableView.backgroundColor = [UIColor systemGroupedBackgroundColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 54, 0, 0);
    
    [CSSettingTableViewCell registerToTableView:self.tableView];
    
    self.senderLightColorPreview = [[BubbleColorPreviewView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
    self.receiverLightColorPreview = [[BubbleColorPreviewView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
    self.senderDarkColorPreview = [[BubbleColorPreviewView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
    self.receiverDarkColorPreview = [[BubbleColorPreviewView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
    
    [self loadCurrentSettings];
    [self setupData];
}

- (void)loadCurrentSettings {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![defaults objectForKey:kBubbleCornerRadiusKey]) {
        self.cornerRadius = kDefaultCornerRadius;
        [defaults setFloat:self.cornerRadius forKey:kBubbleCornerRadiusKey];
        [defaults synchronize];
    } else {
        self.cornerRadius = [defaults floatForKey:kBubbleCornerRadiusKey];
    }
    
    self.senderLightColor = [self loadColorWithRedKey:kBubbleSenderLightColorRedKey
                                            greenKey:kBubbleSenderLightColorGreenKey
                                             blueKey:kBubbleSenderLightColorBlueKey
                                            alphaKey:kBubbleSenderLightColorAlphaKey
                                         defaultRed:0.27
                                       defaultGreen:0.78
                                        defaultBlue:0.49
                                       defaultAlpha:1.0];
    
    self.receiverLightColor = [self loadColorWithRedKey:kBubbleReceiverLightColorRedKey
                                              greenKey:kBubbleReceiverLightColorGreenKey
                                               blueKey:kBubbleReceiverLightColorBlueKey
                                              alphaKey:kBubbleReceiverLightColorAlphaKey
                                           defaultRed:0.95
                                         defaultGreen:0.95
                                          defaultBlue:0.95
                                         defaultAlpha:1.0];
    
    self.senderDarkColor = [self loadColorWithRedKey:kBubbleSenderDarkColorRedKey
                                            greenKey:kBubbleSenderDarkColorGreenKey
                                             blueKey:kBubbleSenderDarkColorBlueKey
                                            alphaKey:kBubbleSenderDarkColorAlphaKey
                                         defaultRed:0.20
                                       defaultGreen:0.60
                                        defaultBlue:0.98
                                       defaultAlpha:1.0];
    
    self.receiverDarkColor = [self loadColorWithRedKey:kBubbleReceiverDarkColorRedKey
                                              greenKey:kBubbleReceiverDarkColorGreenKey
                                               blueKey:kBubbleReceiverDarkColorBlueKey
                                              alphaKey:kBubbleReceiverDarkColorAlphaKey
                                           defaultRed:0.18
                                         defaultGreen:0.18
                                          defaultBlue:0.18
                                         defaultAlpha:1.0];
    
    self.senderLightColorPreview.previewColor = self.senderLightColor;
    self.receiverLightColorPreview.previewColor = self.receiverLightColor;
    self.senderDarkColorPreview.previewColor = self.senderDarkColor;
    self.receiverDarkColorPreview.previewColor = self.receiverDarkColor;
}

- (UIColor *)loadColorWithRedKey:(NSString *)redKey
                       greenKey:(NSString *)greenKey
                        blueKey:(NSString *)blueKey
                       alphaKey:(NSString *)alphaKey
                    defaultRed:(CGFloat)defaultRed
                  defaultGreen:(CGFloat)defaultGreen
                   defaultBlue:(CGFloat)defaultBlue
                  defaultAlpha:(CGFloat)defaultAlpha {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    CGFloat red = [defaults floatForKey:redKey];
    CGFloat green = [defaults floatForKey:greenKey];
    CGFloat blue = [defaults floatForKey:blueKey];
    CGFloat alpha = [defaults floatForKey:alphaKey];
    
    if (red == 0 && green == 0 && blue == 0 && alpha == 0) {
        [defaults setFloat:defaultRed forKey:redKey];
        [defaults setFloat:defaultGreen forKey:greenKey];
        [defaults setFloat:defaultBlue forKey:blueKey];
        [defaults setFloat:defaultAlpha forKey:alphaKey];
        [defaults synchronize];
        return [UIColor colorWithRed:defaultRed green:defaultGreen blue:defaultBlue alpha:defaultAlpha];
    }
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (void)saveColor:(UIColor *)color
          redKey:(NSString *)redKey
        greenKey:(NSString *)greenKey
         blueKey:(NSString *)blueKey
        alphaKey:(NSString *)alphaKey {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    CGFloat red = 0, green = 0, blue = 0, alpha = 0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    
    [defaults setFloat:red forKey:redKey];
    [defaults setFloat:green forKey:greenKey];
    [defaults setFloat:blue forKey:blueKey];
    [defaults setFloat:alpha forKey:alphaKey];
    [defaults synchronize];
}

- (void)setupData {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    CSSettingItem *bubbleEnabledItem = [CSSettingItem switchItemWithTitle:@"气泡样式"
                                                                iconName:@"rectangle.roundedtop"
                                                               iconColor:[UIColor systemBlueColor]
                                                             switchValue:[defaults boolForKey:kBubbleStyleEnabledKey]
                                                       valueChangedBlock:^(BOOL isOn) {
        [defaults setBool:isOn forKey:kBubbleStyleEnabledKey];
        [defaults synchronize];
        
        CFNotificationCenterPostNotification(
            CFNotificationCenterGetDarwinNotifyCenter(),
            CFSTR("com.wechat.enhance.bubble_style.settings_changed"),
            NULL,
            NULL,
            true
        );
    }];
    
    NSString *radiusDetail = [NSString stringWithFormat:@"%.0f", self.cornerRadius];
    self.cornerRadiusItem = [CSSettingItem itemWithTitle:@"圆角大小"
                                               iconName:@"slider.horizontal.3"
                                              iconColor:[UIColor systemOrangeColor]
                                                detail:radiusDetail];
    
    __weak typeof(self) weakSelf = self;
    self.cornerRadiusItem.actionBlock = ^{
        [weakSelf showCornerRadiusPicker];
    };
    
    self.senderLightColorItem = [CSSettingItem itemWithTitle:@"发送方颜色"
                                                   iconName:@"paintbrush.fill"
                                                  iconColor:[UIColor systemGreenColor]
                                                    detail:@""];
    self.senderLightColorItem.actionBlock = ^{
        weakSelf.currentColorType = 0;
        [weakSelf showColorPickerWithTitle:@"浅色模式 - 发送方颜色" currentColor:weakSelf.senderLightColor];
    };
    
    self.receiverLightColorItem = [CSSettingItem itemWithTitle:@"接收方颜色"
                                                     iconName:@"paintbrush.fill"
                                                    iconColor:[UIColor systemGrayColor]
                                                      detail:@""];
    self.receiverLightColorItem.actionBlock = ^{
        weakSelf.currentColorType = 1;
        [weakSelf showColorPickerWithTitle:@"浅色模式 - 接收方颜色" currentColor:weakSelf.receiverLightColor];
    };
    
    self.senderDarkColorItem = [CSSettingItem itemWithTitle:@"发送方颜色"
                                                  iconName:@"paintbrush.fill"
                                                 iconColor:[UIColor systemBlueColor]
                                                   detail:@""];
    self.senderDarkColorItem.actionBlock = ^{
        weakSelf.currentColorType = 2;
        [weakSelf showColorPickerWithTitle:@"深色模式 - 发送方颜色" currentColor:weakSelf.senderDarkColor];
    };
    
    self.receiverDarkColorItem = [CSSettingItem itemWithTitle:@"接收方颜色"
                                                    iconName:@"paintbrush.fill"
                                                   iconColor:[UIColor systemGrayColor]
                                                     detail:@""];
    self.receiverDarkColorItem.actionBlock = ^{
        weakSelf.currentColorType = 3;
        [weakSelf showColorPickerWithTitle:@"深色模式 - 接收方颜色" currentColor:weakSelf.receiverDarkColor];
    };
    
    CSSettingItem *descItem = [CSSettingItem itemWithTitle:@"使用说明"
                                                 iconName:@"info.circle.fill"
                                                iconColor:[UIColor systemGrayColor]
                                                  detail:@"将消息气泡改为圆角气泡，立即生效。"];
    
    CSSettingItem *resetItem = [CSSettingItem itemWithTitle:@"重置默认颜色"
                                                  iconName:@"arrow.counterclockwise"
                                                 iconColor:[UIColor systemRedColor]
                                                   detail:@""];
    resetItem.actionBlock = ^{
        [weakSelf resetToDefaultColors];
    };
    
    BOOL mergeEnabled = [defaults boolForKey:kMergeMessagesEnabledKey];
    NSInteger mergeScope = [defaults integerForKey:kMergeMessagesScopeKey];
    if (mergeScope == 0) {
        mergeScope = 2;
        [defaults setInteger:mergeScope forKey:kMergeMessagesScopeKey];
        [defaults synchronize];
    }
    
    NSString *scopeText = @"全部生效";
    switch (mergeScope) {
        case 1:
            scopeText = @"群聊生效";
            break;
        case 2:
            scopeText = @"私聊生效";
            break;
        case 3:
            scopeText = @"全部生效";
            break;
    }
    
    CSSettingItem *mergeEnabledItem = [CSSettingItem switchItemWithTitle:@"合并消息"
                                                              iconName:@"rectangle.stack"
                                                             iconColor:[UIColor systemPurpleColor]
                                                           switchValue:mergeEnabled
                                                     valueChangedBlock:^(BOOL isOn) {
        [defaults setBool:isOn forKey:kMergeMessagesEnabledKey];
        [defaults synchronize];
        
        CFNotificationCenterPostNotification(
            CFNotificationCenterGetDarwinNotifyCenter(),
            CFSTR("com.wechat.enhance.bubble_style.settings_changed"),
            NULL,
            NULL,
            true
        );
    }];
    
    CSSettingItem *mergeScopeItem = [CSSettingItem itemWithTitle:@"生效范围"
                                                       iconName:@"scope"
                                                      iconColor:[UIColor systemTealColor]
                                                        detail:scopeText];
    mergeScopeItem.actionBlock = ^{
        [weakSelf showMergeScopePicker];
    };
    
    CGFloat consecutiveSpacing = [defaults floatForKey:kConsecutiveMessagesSpacingKey];
    if (![defaults objectForKey:kConsecutiveMessagesSpacingKey]) {
        consecutiveSpacing = kDefaultConsecutiveSpacing;
        [defaults setFloat:consecutiveSpacing forKey:kConsecutiveMessagesSpacingKey];
        [defaults synchronize];
    }
    
    NSString *consecutiveSpacingText = [NSString stringWithFormat:@"%.1f", consecutiveSpacing];
    CSSettingItem *consecutiveSpacingItem = [CSSettingItem itemWithTitle:@"连续消息间距"
                                                               iconName:@"arrow.up.and.down"
                                                              iconColor:[UIColor systemOrangeColor]
                                                                detail:consecutiveSpacingText];
    consecutiveSpacingItem.actionBlock = ^{
        [weakSelf showConsecutiveSpacingPicker];
    };
    
    NSInteger avatarPosition = [defaults integerForKey:kMergeMessagesAvatarPositionKey];
    if (avatarPosition == 0) {
        avatarPosition = 1;
        [defaults setInteger:avatarPosition forKey:kMergeMessagesAvatarPositionKey];
        [defaults synchronize];
    }
    
    NSString *avatarPositionText = @"最后一条消息";
    switch (avatarPosition) {
        case 1:
            avatarPositionText = @"最后一条消息";
            break;
        case 2:
            avatarPositionText = @"第一条消息";
            break;
    }
    
    CSSettingItem *avatarPositionItem = [CSSettingItem itemWithTitle:@"头像显示位置"
                                                           iconName:@"person.crop.circle"
                                                          iconColor:[UIColor systemIndigoColor]
                                                            detail:avatarPositionText];
    avatarPositionItem.actionBlock = ^{
        [weakSelf showAvatarPositionPicker];
    };
    
    CSSettingSection *mainSection = [CSSettingSection sectionWithHeader:@"功能设置"
                                                                 items:@[bubbleEnabledItem, self.cornerRadiusItem]];
    
    CSSettingSection *lightModeSection = [CSSettingSection sectionWithHeader:@"浅色模式"
                                                                       items:@[self.senderLightColorItem, self.receiverLightColorItem]];
    
    CSSettingSection *darkModeSection = [CSSettingSection sectionWithHeader:@"深色模式"
                                                                      items:@[self.senderDarkColorItem, self.receiverDarkColorItem]];
    
    CSSettingSection *resetSection = [CSSettingSection sectionWithHeader:@"重置设置"
                                                                  items:@[resetItem]];
    
    CSSettingSection *mergeSection = [CSSettingSection sectionWithHeader:@"合并消息"
                                                                  items:@[mergeEnabledItem, mergeScopeItem, consecutiveSpacingItem, avatarPositionItem]];
    
    CSSettingSection *descSection = [CSSettingSection sectionWithHeader:@"说明"
                                                                 items:@[descItem]];
    
    self.sections = @[mainSection, lightModeSection, darkModeSection, resetSection, mergeSection, descSection];
}

#pragma mark - Table view data source

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
    
    if ([item.title isEqualToString:@"发送方颜色"] && indexPath.section == 1) {
        cell.accessoryView = self.senderLightColorPreview;
    } else if ([item.title isEqualToString:@"接收方颜色"] && indexPath.section == 1) {
        cell.accessoryView = self.receiverLightColorPreview;
    } else if ([item.title isEqualToString:@"发送方颜色"] && indexPath.section == 2) {
        cell.accessoryView = self.senderDarkColorPreview;
    } else if ([item.title isEqualToString:@"接收方颜色"] && indexPath.section == 2) {
        cell.accessoryView = self.receiverDarkColorPreview;
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sections[section].header;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"开启后将使用自定义颜色和样式的聊天气泡，圆角大小可以调整气泡的圆润程度。";
        case 1:
        case 2:
            return @"点击可选择不同颜色气泡颜色，支持自定义透明度。";
        case 3:
            return @"恢复默认的气泡颜色和圆角设置。";
        case 4:
            return @"开启后，同一个人连续发送的消息只保留首条/末条消息的头像。";
        default:
            return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CSSettingItem *item = self.sections[indexPath.section].items[indexPath.row];
    if (item.actionBlock) {
        item.actionBlock();
    }
}

#pragma mark - Corner Radius Picker

- (void)showCornerRadiusPicker {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"圆角大小"
                                                                   message:@"请输入圆角大小（范围: 1-30）"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.placeholder = [NSString stringWithFormat:@"当前: %.0f", self.cornerRadius];
        textField.text = [NSString stringWithFormat:@"%.0f", self.cornerRadius];
    }];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = alert.textFields.firstObject;
        NSString *inputText = textField.text;
        
        CGFloat radiusValue = [inputText floatValue];
        
        if (radiusValue < 1) {
            radiusValue = 1;
        } else if (radiusValue > 30) {
            radiusValue = 30;
        }
        
        self.cornerRadius = radiusValue;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setFloat:radiusValue forKey:kBubbleCornerRadiusKey];
        [defaults synchronize];
        
        CFNotificationCenterPostNotification(
            CFNotificationCenterGetDarwinNotifyCenter(),
            CFSTR("com.wechat.enhance.bubble_style.settings_changed"),
            NULL,
            NULL,
            true
        );
        
        [self setupData];
        [self.tableView reloadData];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    
    [alert addAction:confirmAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Reset to Default Colors

- (void)resetToDefaultColors {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"重置默认颜色"
                                                                   message:@"确定要恢复默认的气泡颜色和圆角设置吗？"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定"
                                                            style:UIAlertActionStyleDestructive
                                                          handler:^(UIAlertAction * _Nonnull action) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setFloat:16.0 forKey:kBubbleCornerRadiusKey];
        self.cornerRadius = 16.0;
        
        UIColor *defaultSenderLight = [UIColor colorWithRed:0.27 green:0.78 blue:0.49 alpha:1.0];
        UIColor *defaultReceiverLight = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
        UIColor *defaultSenderDark = [UIColor colorWithRed:0.20 green:0.60 blue:0.98 alpha:1.0];
        UIColor *defaultReceiverDark = [UIColor colorWithRed:0.18 green:0.18 blue:0.18 alpha:1.0];
        
        [self saveColor:defaultSenderLight
                redKey:kBubbleSenderLightColorRedKey
              greenKey:kBubbleSenderLightColorGreenKey
               blueKey:kBubbleSenderLightColorBlueKey
              alphaKey:kBubbleSenderLightColorAlphaKey];
        
        [self saveColor:defaultReceiverLight
                redKey:kBubbleReceiverLightColorRedKey
              greenKey:kBubbleReceiverLightColorGreenKey
               blueKey:kBubbleReceiverLightColorBlueKey
              alphaKey:kBubbleReceiverLightColorAlphaKey];
        
        [self saveColor:defaultSenderDark
                redKey:kBubbleSenderDarkColorRedKey
              greenKey:kBubbleSenderDarkColorGreenKey
               blueKey:kBubbleSenderDarkColorBlueKey
              alphaKey:kBubbleSenderDarkColorAlphaKey];
        
        [self saveColor:defaultReceiverDark
                redKey:kBubbleReceiverDarkColorRedKey
              greenKey:kBubbleReceiverDarkColorGreenKey
               blueKey:kBubbleReceiverDarkColorBlueKey
              alphaKey:kBubbleReceiverDarkColorAlphaKey];
        
        [defaults synchronize];
        
        self.senderLightColor = defaultSenderLight;
        self.receiverLightColor = defaultReceiverLight;
        self.senderDarkColor = defaultSenderDark;
        self.receiverDarkColor = defaultReceiverDark;
        
        self.senderLightColorPreview.previewColor = defaultSenderLight;
        self.receiverLightColorPreview.previewColor = defaultReceiverLight;
        self.senderDarkColorPreview.previewColor = defaultSenderDark;
        self.receiverDarkColorPreview.previewColor = defaultReceiverDark;
        
        CFNotificationCenterPostNotification(
            CFNotificationCenterGetDarwinNotifyCenter(),
            CFSTR("com.wechat.enhance.bubble_style.settings_changed"),
            NULL,
            NULL,
            true
        );
        
        [self setupData];
        [self.tableView reloadData];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    
    [alert addAction:cancelAction];
    [alert addAction:confirmAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Color Picker

- (void)showColorPickerWithTitle:(NSString *)title currentColor:(UIColor *)currentColor {
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
    
    switch (self.currentColorType) {
        case 0:
            self.senderLightColor = selectedColor;
            self.senderLightColorPreview.previewColor = selectedColor;
            [self saveColor:selectedColor
                    redKey:kBubbleSenderLightColorRedKey
                  greenKey:kBubbleSenderLightColorGreenKey
                   blueKey:kBubbleSenderLightColorBlueKey
                  alphaKey:kBubbleSenderLightColorAlphaKey];
            break;
        case 1:
            self.receiverLightColor = selectedColor;
            self.receiverLightColorPreview.previewColor = selectedColor;
            [self saveColor:selectedColor
                    redKey:kBubbleReceiverLightColorRedKey
                  greenKey:kBubbleReceiverLightColorGreenKey
                   blueKey:kBubbleReceiverLightColorBlueKey
                  alphaKey:kBubbleReceiverLightColorAlphaKey];
            break;
        case 2:
            self.senderDarkColor = selectedColor;
            self.senderDarkColorPreview.previewColor = selectedColor;
            [self saveColor:selectedColor
                    redKey:kBubbleSenderDarkColorRedKey
                  greenKey:kBubbleSenderDarkColorGreenKey
                   blueKey:kBubbleSenderDarkColorBlueKey
                  alphaKey:kBubbleSenderDarkColorAlphaKey];
            break;
        case 3:
            self.receiverDarkColor = selectedColor;
            self.receiverDarkColorPreview.previewColor = selectedColor;
            [self saveColor:selectedColor
                    redKey:kBubbleReceiverDarkColorRedKey
                  greenKey:kBubbleReceiverDarkColorGreenKey
                   blueKey:kBubbleReceiverDarkColorBlueKey
                  alphaKey:kBubbleReceiverDarkColorAlphaKey];
            break;
    }
    
    CFNotificationCenterPostNotification(
        CFNotificationCenterGetDarwinNotifyCenter(),
        CFSTR("com.wechat.enhance.bubble_style.settings_changed"),
        NULL,
        NULL,
        true
    );
    
    [self.tableView reloadData];
}

- (void)colorPickerViewControllerDidSelectColor:(UIColorPickerViewController *)viewController {
    UIColor *selectedColor = viewController.selectedColor;
    
    switch (self.currentColorType) {
        case 0:
            self.senderLightColorPreview.previewColor = selectedColor;
            break;
        case 1:
            self.receiverLightColorPreview.previewColor = selectedColor;
            break;
        case 2:
            self.senderDarkColorPreview.previewColor = selectedColor;
            break;
        case 3:
            self.receiverDarkColorPreview.previewColor = selectedColor;
            break;
    }
}

#pragma mark - Merge Scope Picker

- (void)showMergeScopePicker {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger currentScope = [defaults integerForKey:kMergeMessagesScopeKey];
    if (currentScope == 0) {
        currentScope = 3;
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"生效范围"
                                                                   message:@"选择合并消息功能的生效范围"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *groupAction = [UIAlertAction actionWithTitle:@"群聊生效"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
        [defaults setInteger:1 forKey:kMergeMessagesScopeKey];
        [defaults synchronize];
        
        CFNotificationCenterPostNotification(
            CFNotificationCenterGetDarwinNotifyCenter(),
            CFSTR("com.wechat.enhance.bubble_style.settings_changed"),
            NULL,
            NULL,
            true
        );
        
        [self setupData];
        [self.tableView reloadData];
    }];
    
    UIAlertAction *privateAction = [UIAlertAction actionWithTitle:@"私聊生效"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
        [defaults setInteger:2 forKey:kMergeMessagesScopeKey];
        [defaults synchronize];
        
        CFNotificationCenterPostNotification(
            CFNotificationCenterGetDarwinNotifyCenter(),
            CFSTR("com.wechat.enhance.bubble_style.settings_changed"),
            NULL,
            NULL,
            true
        );
        
        [self setupData];
        [self.tableView reloadData];
    }];
    
    UIAlertAction *allAction = [UIAlertAction actionWithTitle:@"全部生效"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
        [defaults setInteger:3 forKey:kMergeMessagesScopeKey];
        [defaults synchronize];
        
        CFNotificationCenterPostNotification(
            CFNotificationCenterGetDarwinNotifyCenter(),
            CFSTR("com.wechat.enhance.bubble_style.settings_changed"),
            NULL,
            NULL,
            true
        );
        
        [self setupData];
        [self.tableView reloadData];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    
    if (currentScope == 1) {
        groupAction.enabled = NO;
    } else if (currentScope == 2) {
        privateAction.enabled = NO;
    } else if (currentScope == 3) {
        allAction.enabled = NO;
    }
    
    [alert addAction:groupAction];
    [alert addAction:privateAction];
    [alert addAction:allAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Consecutive Spacing Picker

- (void)showConsecutiveSpacingPicker {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    CGFloat currentSpacing = kDefaultConsecutiveSpacing;
    
    if ([defaults objectForKey:kConsecutiveMessagesSpacingKey]) {
        currentSpacing = [defaults floatForKey:kConsecutiveMessagesSpacingKey];
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"连续消息间距"
                                                                   message:@"设置同一发送者连续消息之间的间距（范围: -50-20）\n负值减少间距，正值增加间距  \n（建议设置为-10）"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        textField.placeholder = [NSString stringWithFormat:@"当前: %.1f", currentSpacing];
        textField.text = [NSString stringWithFormat:@"%.1f", currentSpacing];
    }];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = alert.textFields.firstObject;
        NSString *inputText = textField.text;
        
        CGFloat spacingValue = [inputText floatValue];
        
        if (spacingValue < -50) {
            spacingValue = -50;
        } else if (spacingValue > 20) {
            spacingValue = 20;
        }
        
        [defaults setFloat:spacingValue forKey:kConsecutiveMessagesSpacingKey];
        [defaults synchronize];
        
        CFNotificationCenterPostNotification(
            CFNotificationCenterGetDarwinNotifyCenter(),
            CFSTR("com.wechat.enhance.bubble_style.settings_changed"),
            NULL,
            NULL,
            true
        );
        
        [self setupData];
        [self.tableView reloadData];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    
    [alert addAction:confirmAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Avatar Position Picker

- (void)showAvatarPositionPicker {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger currentPosition = [defaults integerForKey:kMergeMessagesAvatarPositionKey];
    if (currentPosition == 0) {
        currentPosition = 1;
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"头像显示位置"
                                                                   message:@"选择合并消息时头像的显示位置"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *lastAction = [UIAlertAction actionWithTitle:@"最后一条消息"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
        [defaults setInteger:1 forKey:kMergeMessagesAvatarPositionKey];
        [defaults synchronize];
        
        CFNotificationCenterPostNotification(
            CFNotificationCenterGetDarwinNotifyCenter(),
            CFSTR("com.wechat.enhance.bubble_style.settings_changed"),
            NULL,
            NULL,
            true
        );
        
        [self setupData];
        [self.tableView reloadData];
    }];
    
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"第一条消息"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
        [defaults setInteger:2 forKey:kMergeMessagesAvatarPositionKey];
        [defaults synchronize];
        
        CFNotificationCenterPostNotification(
            CFNotificationCenterGetDarwinNotifyCenter(),
            CFSTR("com.wechat.enhance.bubble_style.settings_changed"),
            NULL,
            NULL,
            true
        );
        
        [self setupData];
        [self.tableView reloadData];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    
    if (currentPosition == 1) {
        lastAction.enabled = NO;
    } else if (currentPosition == 2) {
        firstAction.enabled = NO;
    }
    
    [alert addAction:lastAction];
    [alert addAction:firstAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
