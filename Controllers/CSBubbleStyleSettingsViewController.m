#import "CSBubbleStylePolicy.h"
//
//  CSBubbleStyleSettingsViewController.m
//  气泡样式设置界面实现
//

#import "CSBubbleStyleSettingsViewController.h"
#import "CSSettingTableViewCell.h"
#import "CSMessageMergePolicy.h"

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

static NSString * const kBubbleRedEnvelopSenderLightColorRedKey = @"com.wechat.enhance.bubble_style.redenvelop_sender_light_color.red";
static NSString * const kBubbleRedEnvelopSenderLightColorGreenKey = @"com.wechat.enhance.bubble_style.redenvelop_sender_light_color.green";
static NSString * const kBubbleRedEnvelopSenderLightColorBlueKey = @"com.wechat.enhance.bubble_style.redenvelop_sender_light_color.blue";
static NSString * const kBubbleRedEnvelopSenderLightColorAlphaKey = @"com.wechat.enhance.bubble_style.redenvelop_sender_light_color.alpha";

static NSString * const kBubbleRedEnvelopSenderDarkColorRedKey = @"com.wechat.enhance.bubble_style.redenvelop_sender_dark_color.red";
static NSString * const kBubbleRedEnvelopSenderDarkColorGreenKey = @"com.wechat.enhance.bubble_style.redenvelop_sender_dark_color.green";
static NSString * const kBubbleRedEnvelopSenderDarkColorBlueKey = @"com.wechat.enhance.bubble_style.redenvelop_sender_dark_color.blue";
static NSString * const kBubbleRedEnvelopSenderDarkColorAlphaKey = @"com.wechat.enhance.bubble_style.redenvelop_sender_dark_color.alpha";

static NSString * const kBubbleRedEnvelopReceiverLightColorRedKey = @"com.wechat.enhance.bubble_style.redenvelop_receiver_light_color.red";
static NSString * const kBubbleRedEnvelopReceiverLightColorGreenKey = @"com.wechat.enhance.bubble_style.redenvelop_receiver_light_color.green";
static NSString * const kBubbleRedEnvelopReceiverLightColorBlueKey = @"com.wechat.enhance.bubble_style.redenvelop_receiver_light_color.blue";
static NSString * const kBubbleRedEnvelopReceiverLightColorAlphaKey = @"com.wechat.enhance.bubble_style.redenvelop_receiver_light_color.alpha";

static NSString * const kBubbleRedEnvelopReceiverDarkColorRedKey = @"com.wechat.enhance.bubble_style.redenvelop_receiver_dark_color.red";
static NSString * const kBubbleRedEnvelopReceiverDarkColorGreenKey = @"com.wechat.enhance.bubble_style.redenvelop_receiver_dark_color.green";
static NSString * const kBubbleRedEnvelopReceiverDarkColorBlueKey = @"com.wechat.enhance.bubble_style.redenvelop_receiver_dark_color.blue";
static NSString * const kBubbleRedEnvelopReceiverDarkColorAlphaKey = @"com.wechat.enhance.bubble_style.redenvelop_receiver_dark_color.alpha";

static NSString * const kMergeMessagesEnabledKey = @"com.wechat.enhance.merge_messages.enabled";
static NSString * const kMergeMessagesScopeKey = @"com.wechat.enhance.merge_messages.scope";
static NSString * const kMergeMessagesAvatarPositionKey = @"com.wechat.enhance.merge_messages.avatar_position";


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

@property (nonatomic, strong) CSSettingItem *redEnvelopSenderLightColorItem;
@property (nonatomic, strong) CSSettingItem *redEnvelopReceiverLightColorItem;
@property (nonatomic, strong) CSSettingItem *redEnvelopSenderDarkColorItem;
@property (nonatomic, strong) CSSettingItem *redEnvelopReceiverDarkColorItem;

@property (nonatomic, strong) BubbleColorPreviewView *senderLightColorPreview;
@property (nonatomic, strong) BubbleColorPreviewView *receiverLightColorPreview;
@property (nonatomic, strong) BubbleColorPreviewView *senderDarkColorPreview;
@property (nonatomic, strong) BubbleColorPreviewView *receiverDarkColorPreview;

@property (nonatomic, strong) BubbleColorPreviewView *redEnvelopSenderLightColorPreview;
@property (nonatomic, strong) BubbleColorPreviewView *redEnvelopReceiverLightColorPreview;
@property (nonatomic, strong) BubbleColorPreviewView *redEnvelopSenderDarkColorPreview;
@property (nonatomic, strong) BubbleColorPreviewView *redEnvelopReceiverDarkColorPreview;

@property (nonatomic, strong) UIColor *senderLightColor;
@property (nonatomic, strong) UIColor *receiverLightColor;
@property (nonatomic, strong) UIColor *senderDarkColor;
@property (nonatomic, strong) UIColor *receiverDarkColor;

@property (nonatomic, strong) UIColor *redEnvelopSenderLightColor;
@property (nonatomic, strong) UIColor *redEnvelopReceiverLightColor;
@property (nonatomic, strong) UIColor *redEnvelopSenderDarkColor;
@property (nonatomic, strong) UIColor *redEnvelopReceiverDarkColor;

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
    
    self.redEnvelopSenderLightColorPreview = [[BubbleColorPreviewView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
    self.redEnvelopReceiverLightColorPreview = [[BubbleColorPreviewView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
    self.redEnvelopSenderDarkColorPreview = [[BubbleColorPreviewView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
    self.redEnvelopReceiverDarkColorPreview = [[BubbleColorPreviewView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
    
    [self loadCurrentSettings];
    [self setupData];
}

- (void)loadCurrentSettings {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.cornerRadius = [[CSBubbleStyleConfiguration alloc] initWithDefaults:defaults generation:0].radius;
    
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
    
    self.redEnvelopSenderLightColor = [self loadColorWithRedKey:kBubbleRedEnvelopSenderLightColorRedKey
                                                      greenKey:kBubbleRedEnvelopSenderLightColorGreenKey
                                                       blueKey:kBubbleRedEnvelopSenderLightColorBlueKey
                                                      alphaKey:kBubbleRedEnvelopSenderLightColorAlphaKey
                                                   defaultRed:0.91
                                                 defaultGreen:0.30
                                                  defaultBlue:0.24
                                                 defaultAlpha:1.0];
    
    self.redEnvelopReceiverLightColor = [self loadColorWithRedKey:kBubbleRedEnvelopReceiverLightColorRedKey
                                                        greenKey:kBubbleRedEnvelopReceiverLightColorGreenKey
                                                         blueKey:kBubbleRedEnvelopReceiverLightColorBlueKey
                                                        alphaKey:kBubbleRedEnvelopReceiverLightColorAlphaKey
                                                     defaultRed:0.91
                                                   defaultGreen:0.30
                                                    defaultBlue:0.24
                                                   defaultAlpha:1.0];
    
    self.redEnvelopSenderDarkColor = [self loadColorWithRedKey:kBubbleRedEnvelopSenderDarkColorRedKey
                                                     greenKey:kBubbleRedEnvelopSenderDarkColorGreenKey
                                                      blueKey:kBubbleRedEnvelopSenderDarkColorBlueKey
                                                     alphaKey:kBubbleRedEnvelopSenderDarkColorAlphaKey
                                                  defaultRed:0.86
                                                defaultGreen:0.22
                                                 defaultBlue:0.10
                                                defaultAlpha:1.0];
    
    self.redEnvelopReceiverDarkColor = [self loadColorWithRedKey:kBubbleRedEnvelopReceiverDarkColorRedKey
                                                       greenKey:kBubbleRedEnvelopReceiverDarkColorGreenKey
                                                        blueKey:kBubbleRedEnvelopReceiverDarkColorBlueKey
                                                       alphaKey:kBubbleRedEnvelopReceiverDarkColorAlphaKey
                                                    defaultRed:0.86
                                                  defaultGreen:0.22
                                                   defaultBlue:0.10
                                                  defaultAlpha:1.0];
    
    self.senderLightColorPreview.previewColor = self.senderLightColor;
    self.receiverLightColorPreview.previewColor = self.receiverLightColor;
    self.senderDarkColorPreview.previewColor = self.senderDarkColor;
    self.receiverDarkColorPreview.previewColor = self.receiverDarkColor;
    
    self.redEnvelopSenderLightColorPreview.previewColor = self.redEnvelopSenderLightColor;
    self.redEnvelopReceiverLightColorPreview.previewColor = self.redEnvelopReceiverLightColor;
    self.redEnvelopSenderDarkColorPreview.previewColor = self.redEnvelopSenderDarkColor;
    self.redEnvelopReceiverDarkColorPreview.previewColor = self.redEnvelopReceiverDarkColor;
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
    
    CGFloat red = CSBubbleReadComponent(defaults, redKey, defaultRed);
    CGFloat green = CSBubbleReadComponent(defaults, greenKey, defaultGreen);
    CGFloat blue = CSBubbleReadComponent(defaults, blueKey, defaultBlue);
    CGFloat alpha = CSBubbleReadComponent(defaults, alphaKey, defaultAlpha);

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
    
    self.redEnvelopSenderLightColorItem = [CSSettingItem itemWithTitle:@"发送方红包/转账颜色"
                                                             iconName:@"envelope.fill"
                                                            iconColor:[UIColor systemRedColor]
                                                              detail:@""];
    self.redEnvelopSenderLightColorItem.actionBlock = ^{
        weakSelf.currentColorType = 4;
        [weakSelf showColorPickerWithTitle:@"浅色模式 - 发送方红包/转账颜色" currentColor:weakSelf.redEnvelopSenderLightColor];
    };
    
    self.redEnvelopReceiverLightColorItem = [CSSettingItem itemWithTitle:@"接收方红包/转账颜色"
                                                              iconName:@"envelope.fill"
                                                             iconColor:[UIColor systemRedColor]
                                                               detail:@""];
    self.redEnvelopReceiverLightColorItem.actionBlock = ^{
        weakSelf.currentColorType = 5;
        [weakSelf showColorPickerWithTitle:@"浅色模式 - 接收方红包/转账颜色" currentColor:weakSelf.redEnvelopReceiverLightColor];
    };
    
    self.redEnvelopSenderDarkColorItem = [CSSettingItem itemWithTitle:@"发送方红包/转账颜色"
                                                           iconName:@"envelope.fill"
                                                          iconColor:[UIColor systemRedColor]
                                                            detail:@""];
    self.redEnvelopSenderDarkColorItem.actionBlock = ^{
        weakSelf.currentColorType = 6;
        [weakSelf showColorPickerWithTitle:@"深色模式 - 发送方红包/转账颜色" currentColor:weakSelf.redEnvelopSenderDarkColor];
    };
    
    self.redEnvelopReceiverDarkColorItem = [CSSettingItem itemWithTitle:@"接收方红包/转账颜色"
                                                            iconName:@"envelope.fill"
                                                           iconColor:[UIColor systemRedColor]
                                                             detail:@""];
    self.redEnvelopReceiverDarkColorItem.actionBlock = ^{
        weakSelf.currentColorType = 7;
        [weakSelf showColorPickerWithTitle:@"深色模式 - 接收方红包/转账颜色" currentColor:weakSelf.redEnvelopReceiverDarkColor];
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
    
    CSMessageMergeConfiguration *mergeConfig = [[CSMessageMergeConfiguration alloc] initWithDefaults:defaults];
    BOOL mergeEnabled = mergeConfig.enabled;
    NSInteger mergeScope = mergeConfig.scope;

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
    
    NSString *consecutiveSpacingText = CSMessageSpacingModeTitle(mergeConfig.spacingMode);
    CSSettingItem *consecutiveSpacingItem = [CSSettingItem itemWithTitle:@"连续消息间距"
                                                               iconName:@"arrow.up.and.down"
                                                              iconColor:[UIColor systemOrangeColor]
                                                                detail:consecutiveSpacingText];
    consecutiveSpacingItem.actionBlock = ^{
        [weakSelf showConsecutiveSpacingPicker];
    };
    
    NSInteger avatarPosition = mergeConfig.avatarPosition;

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
                                                                       items:@[self.senderLightColorItem, self.receiverLightColorItem, self.redEnvelopSenderLightColorItem, self.redEnvelopReceiverLightColorItem]];
    
    CSSettingSection *darkModeSection = [CSSettingSection sectionWithHeader:@"深色模式"
                                                                      items:@[self.senderDarkColorItem, self.receiverDarkColorItem, self.redEnvelopSenderDarkColorItem, self.redEnvelopReceiverDarkColorItem]];
    
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
    
    if (indexPath.section == 1) {
        if ([item.title isEqualToString:@"发送方颜色"]) {
            cell.accessoryView = self.senderLightColorPreview;
        } else if ([item.title isEqualToString:@"接收方颜色"]) {
            cell.accessoryView = self.receiverLightColorPreview;
        } else if ([item.title isEqualToString:@"发送方红包/转账颜色"]) {
            cell.accessoryView = self.redEnvelopSenderLightColorPreview;
        } else if ([item.title isEqualToString:@"接收方红包/转账颜色"]) {
            cell.accessoryView = self.redEnvelopReceiverLightColorPreview;
        }
    } else if (indexPath.section == 2) {
        if ([item.title isEqualToString:@"发送方颜色"]) {
            cell.accessoryView = self.senderDarkColorPreview;
        } else if ([item.title isEqualToString:@"接收方颜色"]) {
            cell.accessoryView = self.receiverDarkColorPreview;
        } else if ([item.title isEqualToString:@"发送方红包/转账颜色"]) {
            cell.accessoryView = self.redEnvelopSenderDarkColorPreview;
        } else if ([item.title isEqualToString:@"接收方红包/转账颜色"]) {
            cell.accessoryView = self.redEnvelopReceiverDarkColorPreview;
        }
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
        UIColor *defaultRedEnvelopSenderLight = [UIColor colorWithRed:0.91 green:0.30 blue:0.24 alpha:1.0];
        UIColor *defaultRedEnvelopReceiverLight = [UIColor colorWithRed:0.91 green:0.30 blue:0.24 alpha:1.0];
        UIColor *defaultRedEnvelopSenderDark = [UIColor colorWithRed:0.86 green:0.22 blue:0.10 alpha:1.0];
        UIColor *defaultRedEnvelopReceiverDark = [UIColor colorWithRed:0.86 green:0.22 blue:0.10 alpha:1.0];
        
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
        
        [self saveColor:defaultRedEnvelopSenderLight
                redKey:kBubbleRedEnvelopSenderLightColorRedKey
              greenKey:kBubbleRedEnvelopSenderLightColorGreenKey
               blueKey:kBubbleRedEnvelopSenderLightColorBlueKey
              alphaKey:kBubbleRedEnvelopSenderLightColorAlphaKey];
        
        [self saveColor:defaultRedEnvelopReceiverLight
                redKey:kBubbleRedEnvelopReceiverLightColorRedKey
              greenKey:kBubbleRedEnvelopReceiverLightColorGreenKey
               blueKey:kBubbleRedEnvelopReceiverLightColorBlueKey
              alphaKey:kBubbleRedEnvelopReceiverLightColorAlphaKey];
        
        [self saveColor:defaultRedEnvelopSenderDark
                redKey:kBubbleRedEnvelopSenderDarkColorRedKey
              greenKey:kBubbleRedEnvelopSenderDarkColorGreenKey
               blueKey:kBubbleRedEnvelopSenderDarkColorBlueKey
              alphaKey:kBubbleRedEnvelopSenderDarkColorAlphaKey];
        
        [self saveColor:defaultRedEnvelopReceiverDark
                redKey:kBubbleRedEnvelopReceiverDarkColorRedKey
              greenKey:kBubbleRedEnvelopReceiverDarkColorGreenKey
               blueKey:kBubbleRedEnvelopReceiverDarkColorBlueKey
              alphaKey:kBubbleRedEnvelopReceiverDarkColorAlphaKey];
        
        [defaults synchronize];
        
        self.senderLightColor = defaultSenderLight;
        self.receiverLightColor = defaultReceiverLight;
        self.senderDarkColor = defaultSenderDark;
        self.receiverDarkColor = defaultReceiverDark;
        self.redEnvelopSenderLightColor = defaultRedEnvelopSenderLight;
        self.redEnvelopReceiverLightColor = defaultRedEnvelopReceiverLight;
        self.redEnvelopSenderDarkColor = defaultRedEnvelopSenderDark;
        self.redEnvelopReceiverDarkColor = defaultRedEnvelopReceiverDark;
        
        self.senderLightColorPreview.previewColor = defaultSenderLight;
        self.receiverLightColorPreview.previewColor = defaultReceiverLight;
        self.senderDarkColorPreview.previewColor = defaultSenderDark;
        self.receiverDarkColorPreview.previewColor = defaultReceiverDark;
        self.redEnvelopSenderLightColorPreview.previewColor = defaultRedEnvelopSenderLight;
        self.redEnvelopReceiverLightColorPreview.previewColor = defaultRedEnvelopReceiverLight;
        self.redEnvelopSenderDarkColorPreview.previewColor = defaultRedEnvelopSenderDark;
        self.redEnvelopReceiverDarkColorPreview.previewColor = defaultRedEnvelopReceiverDark;
        
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
        case 4:
            self.redEnvelopSenderLightColor = selectedColor;
            self.redEnvelopSenderLightColorPreview.previewColor = selectedColor;
            [self saveColor:selectedColor
                    redKey:kBubbleRedEnvelopSenderLightColorRedKey
                  greenKey:kBubbleRedEnvelopSenderLightColorGreenKey
                   blueKey:kBubbleRedEnvelopSenderLightColorBlueKey
                  alphaKey:kBubbleRedEnvelopSenderLightColorAlphaKey];
            break;
        case 5:
            self.redEnvelopReceiverLightColor = selectedColor;
            self.redEnvelopReceiverLightColorPreview.previewColor = selectedColor;
            [self saveColor:selectedColor
                    redKey:kBubbleRedEnvelopReceiverLightColorRedKey
                  greenKey:kBubbleRedEnvelopReceiverLightColorGreenKey
                   blueKey:kBubbleRedEnvelopReceiverLightColorBlueKey
                  alphaKey:kBubbleRedEnvelopReceiverLightColorAlphaKey];
            break;
        case 6:
            self.redEnvelopSenderDarkColor = selectedColor;
            self.redEnvelopSenderDarkColorPreview.previewColor = selectedColor;
            [self saveColor:selectedColor
                    redKey:kBubbleRedEnvelopSenderDarkColorRedKey
                  greenKey:kBubbleRedEnvelopSenderDarkColorGreenKey
                   blueKey:kBubbleRedEnvelopSenderDarkColorBlueKey
                  alphaKey:kBubbleRedEnvelopSenderDarkColorAlphaKey];
            break;
        case 7:
            self.redEnvelopReceiverDarkColor = selectedColor;
            self.redEnvelopReceiverDarkColorPreview.previewColor = selectedColor;
            [self saveColor:selectedColor
                    redKey:kBubbleRedEnvelopReceiverDarkColorRedKey
                  greenKey:kBubbleRedEnvelopReceiverDarkColorGreenKey
                   blueKey:kBubbleRedEnvelopReceiverDarkColorBlueKey
                  alphaKey:kBubbleRedEnvelopReceiverDarkColorAlphaKey];
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
        case 4:
            self.redEnvelopSenderLightColorPreview.previewColor = selectedColor;
            break;
        case 5:
            self.redEnvelopReceiverLightColorPreview.previewColor = selectedColor;
            break;
        case 6:
            self.redEnvelopSenderDarkColorPreview.previewColor = selectedColor;
            break;
        case 7:
            self.redEnvelopReceiverDarkColorPreview.previewColor = selectedColor;
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
    NSUserDefaults *defaults = NSUserDefaults.standardUserDefaults;
    CSMessageMergeConfiguration *config = [[CSMessageMergeConfiguration alloc] initWithDefaults:defaults];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"连续消息间距"
        message:@"正常保留原生间距；紧密在连续消息中目标减少 25pt，空间不足时保留完整内容。分段长文本及特殊内容保持原生布局。"
        preferredStyle:UIAlertControllerStyleAlert];
    __weak typeof(self) weakSelf = self;
    for (NSInteger value=CSMessageSpacingNormal; value<=CSMessageSpacingCompact; value++) {
        CSMessageSpacingMode mode = (CSMessageSpacingMode)value;
        NSString *title = CSMessageSpacingModeTitle(mode);
        if (mode==config.spacingMode) title=[title stringByAppendingString:@" ✓"];
        [alert addAction:[UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [defaults setInteger:mode forKey:CSMessageMergeSpacingModeKey];
            CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(),
                (__bridge CFStringRef)CSMessageMergeSettingsNotification,NULL,NULL,true);
            [weakSelf setupData];[weakSelf.tableView reloadData];
        }]];
    }
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
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
