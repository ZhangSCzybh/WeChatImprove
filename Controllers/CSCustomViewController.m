#import "CSCustomViewController.h"
#import "CSSettingTableViewCell.h"
#import "CSUserInfoHelper.h"
#import "CSAccountDetailViewController.h"
#import "CSNavigationTitleSettingsViewController.h"
#import "CSAvatarSettingsViewController.h"
#import "CSBackgroundRunViewController.h"
#import "CSTouchTrailViewController.h"
#import "CSGameCheatsViewController.h"
#import "CSFavoriteSettingsViewController.h"
#import "CSWCEnhanceViewController.h"
#import "CSUICleanViewController.h"
#import "CSEntrySettingsViewController.h"
#import "CSChatAttachmentSettingsViewController.h"
#import "CSVersionSettingsViewController.h"
#import "CSUpdateControlViewController.h"
#import "CSMessageTimeSettingsViewController.h"
#import "CSInputTextSettingsViewController.h"
#import "CSRevokeSettingsViewController.h"
#import "CSRedEnvelopSettingsViewController.h"
#import "CSReceiveTransferSettingsViewController.h"
#import "CSMessageGestureSettingsViewController.h"
#import "CSVoiceForwardSettingsViewController.h"
#import "CSRepeatSettingsViewController.h"
#import "CSResetSettingsViewController.h"
#import "CSBackupSettingsViewController.h"
#import "CSBubbleStyleSettingsViewController.h"
#import "CSListCornerRadiusSettingsViewController.h"
#import "CSLayoutSettingsViewController.h"
#import "CSChatGroupSettingsViewController.h"
#import "CSTabBarStyleSettingsViewController.h"
#import "CSAuthorizationManager.h"
#import <objc/runtime.h>

static UIImage *gCachedQRCodeImage = nil;
static UIView *gBlurOverlayView = nil;

// UI 常量
static CGFloat const kHeaderViewHeight = 150.0f;        // 头部视图高度
static CGFloat const kAvatarSize = 80.0f;              // 头像大小
static CGFloat const kAvatarTopMargin = 0.0f;         // 头像顶部间距
static CGFloat const kNicknameTopMargin = 15.0f;       // 昵称顶部间距
static CGFloat const kNicknameHeight = 25.0f;          // 昵称高度
static CGFloat const kWXIDTopMargin = 5.0f;            // 微信号顶部间距
static CGFloat const kWXIDHeight = 20.0f;              // 微信号高度
static CGFloat const kLabelHorizontalMargin = 20.0f;   // 标签水平间距

// 字体大小
static CGFloat const kNicknameFontSize = 20.0f;        // 昵称字体大小
static CGFloat const kWXIDFontSize = 14.0f;            // 微信号字体大小

// 头像缓存Key
static NSString * const kAvatarCacheKey = @"com.wechat.tweak.avatar.cache";
// 用户协议同意标记
static NSString * const kUserAgreementAcceptedKey = @"com.wechat.tweak.user.agreement.accepted.v3";

@interface CSCustomViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<CSSettingSection *> *sections;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nicknameLabel;
@property (nonatomic, strong) UILabel *wxidLabel;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIActivityIndicatorView *loadingIndicator;
@property (nonatomic, strong) NSTimer *countdownTimer; // 倒计时计时器
@property (nonatomic, assign) NSInteger countdownSeconds; // 倒计时剩余秒数
@property (nonatomic, strong) UIAlertAction *continueAction; // 继续按钮引用
@property (nonatomic, assign) BOOL isAuthorized; // 授权状态
@property (nonatomic, strong) UIView *authorizationOverlay; // 授权提示遮罩视图
@end

@implementation CSCustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置标题
    self.title = @"微信设置";
    
    // 设置UI样式
    self.tableView.backgroundColor = [UIColor systemGroupedBackgroundColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 54, 0, 0);
    
    // 注册设置单元格
    [CSSettingTableViewCell registerToTableView:self.tableView];
    
    // 设置数据
    [self setupData];
    
    // 隐藏导航栏标题
    self.navigationItem.title = @"";
    [self setupHeaderView];
    [self setupUI];
    
    // 预加载头像，在界面显示前就开始加载
    [self preloadAvatarImage];
    
    // 监听配置变更通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(settingsDidChange:)
                                                 name:@"com.wechat.tweak.settings_changed"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(settingsDidChange:)
                                                 name:@"com.wechat.tweak.local_settings_changed"
                                               object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)settingsDidChange:(NSNotification *)notification {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setupData];
        [self.tableView reloadData];
    });
}

// 添加viewDidAppear方法，在视图显示后检查用户协议
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 刷新设置项
    [self setupData];
    [self.tableView reloadData];
    
    // 先检查授权状态
    CSAuthorizationManager *authManager = [CSAuthorizationManager sharedManager];
    
    BOOL isAuthorized = [authManager isAuthorized];
    
    self.isAuthorized = isAuthorized;
    
    if (!isAuthorized) {
        // 未授权，显示授权弹窗
        [authManager requestAuthorizationWithPresentingViewController:self completion:^(BOOL success, NSString *message) {
            // 只有在用户点击"取消"时才禁用功能
            if ([message isEqualToString:@"用户取消授权"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.isAuthorized = NO;
                    [self showAuthorizationOverlay];
                });
            } else {
                // 用户点击关注公众号，保持插件页面打开，等待用户关注后返回
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.isAuthorized = NO;
                    [self showAuthorizationOverlay];
                });
            }
        }];
        return;
    }
    
    // 已授权，检查用户是否已同意使用声明
    [self checkUserAgreement];
}

// 显示授权提示遮罩
- (void)showAuthorizationOverlay {
    // 如果已经存在遮罩，先移除
    if (self.authorizationOverlay) {
        [self.authorizationOverlay removeFromSuperview];
    }
    
    // 创建遮罩视图
    UIView *overlay = [[UIView alloc] initWithFrame:self.view.bounds];
    overlay.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    overlay.tag = 9999;
    self.authorizationOverlay = overlay;
    
    // 创建提示容器视图
    UIView *containerView = [[UIView alloc] init];
    containerView.backgroundColor = [UIColor whiteColor];
    containerView.layer.cornerRadius = 16;
    containerView.layer.masksToBounds = NO;
    containerView.layer.shadowColor = [[UIColor blackColor] CGColor];
    containerView.layer.shadowOffset = CGSizeMake(0, 4);
    containerView.layer.shadowOpacity = 0.3;
    containerView.layer.shadowRadius = 20;
    containerView.translatesAutoresizingMaskIntoConstraints = NO;
    [overlay addSubview:containerView];
    
    // 创建顶部渐变背景视图
    UIView *gradientView = [[UIView alloc] init];
    gradientView.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:gradientView];
    
    // 添加渐变层
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, 300, 120);
    gradientLayer.colors = @[
        (id)[UIColor colorWithRed:0.07 green:0.78 blue:0.33 alpha:1.0].CGColor, // 微信绿 #1BC754
        (id)[UIColor colorWithRed:0.05 green:0.68 blue:0.28 alpha:1.0].CGColor  // 深绿 #0FAD47
    ];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    [gradientView.layer insertSublayer:gradientLayer atIndex:0];
    
    // 创建圆形图标背景
    UIView *iconBgView = [[UIView alloc] init];
    iconBgView.backgroundColor = [UIColor whiteColor];
    iconBgView.layer.cornerRadius = 40;
    iconBgView.layer.masksToBounds = YES;
    iconBgView.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:iconBgView];
    
    // 创建微信图标
    UIImageView *iconImageView = [[UIImageView alloc] init];
    if (@available(iOS 13.0, *)) {
        UIImage *icon = [UIImage systemImageNamed:@"person.badge.plus"];
        if (!icon) {
            icon = [UIImage systemImageNamed:@"person.crop.circle.badge.plus"];
        }
        iconImageView.image = icon;
        iconImageView.tintColor = [UIColor colorWithRed:0.07 green:0.78 blue:0.33 alpha:1.0]; // 微信绿
    }
    iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [iconBgView addSubview:iconImageView];
    
    // 创建提示标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"需要授权";
    titleLabel.font = [UIFont boldSystemFontOfSize:22];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:titleLabel];
    
    // 创建提示信息
    UILabel *messageLabel = [[UILabel alloc] init];
    messageLabel.text = @"请关注公众号后使用插件功能";
    messageLabel.font = [UIFont systemFontOfSize:15];
    messageLabel.textColor = [UIColor systemGrayColor];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.numberOfLines = 0;
    messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:messageLabel];
    
    // 创建公众号ID提示
    UILabel *accountIdLabel = [[UILabel alloc] init];
    accountIdLabel.text = @"公众号: 再也不会AI";
    accountIdLabel.font = [UIFont systemFontOfSize:13];
    accountIdLabel.textColor = [UIColor systemGray2Color];
    accountIdLabel.textAlignment = NSTextAlignmentCenter;
    accountIdLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:accountIdLabel];
    
    // 创建"关注公众号"按钮
    UIButton *followButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [followButton setTitle:@"关注公众号" forState:UIControlStateNormal];
    followButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    followButton.layer.cornerRadius = 25;
    followButton.backgroundColor = [UIColor colorWithRed:0.07 green:0.78 blue:0.33 alpha:1.0]; // 微信绿
    [followButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    followButton.translatesAutoresizingMaskIntoConstraints = NO;
    [followButton addTarget:self action:@selector(followOfficialAccount) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:followButton];
    
    // 创建"重新检查"按钮
    UIButton *checkButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [checkButton setTitle:@"重新检查授权" forState:UIControlStateNormal];
    checkButton.titleLabel.font = [UIFont systemFontOfSize:16];
    checkButton.layer.cornerRadius = 25;
    checkButton.layer.borderWidth = 1.5;
    checkButton.layer.borderColor = [UIColor colorWithRed:0.07 green:0.78 blue:0.33 alpha:1.0].CGColor;
    checkButton.backgroundColor = [UIColor clearColor];
    [checkButton setTitleColor:[UIColor colorWithRed:0.07 green:0.78 blue:0.33 alpha:1.0] forState:UIControlStateNormal];
    checkButton.translatesAutoresizingMaskIntoConstraints = NO;
    [checkButton addTarget:self action:@selector(recheckAuthorization) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:checkButton];
    
    // 设置约束
    [NSLayoutConstraint activateConstraints:@[
        // 容器视图约束
        [containerView.centerXAnchor constraintEqualToAnchor:overlay.centerXAnchor],
        [containerView.centerYAnchor constraintEqualToAnchor:overlay.centerYAnchor constant:-20],
        [containerView.widthAnchor constraintEqualToConstant:300],
        
        // 渐变背景视图约束
        [gradientView.topAnchor constraintEqualToAnchor:containerView.topAnchor],
        [gradientView.leadingAnchor constraintEqualToAnchor:containerView.leadingAnchor],
        [gradientView.trailingAnchor constraintEqualToAnchor:containerView.trailingAnchor],
        [gradientView.heightAnchor constraintEqualToConstant:120],
        
        // 圆形图标背景约束
        [iconBgView.centerXAnchor constraintEqualToAnchor:containerView.centerXAnchor],
        [iconBgView.centerYAnchor constraintEqualToAnchor:gradientView.bottomAnchor],
        [iconBgView.widthAnchor constraintEqualToConstant:80],
        [iconBgView.heightAnchor constraintEqualToConstant:80],
        
        // 图标约束
        [iconImageView.centerXAnchor constraintEqualToAnchor:iconBgView.centerXAnchor],
        [iconImageView.centerYAnchor constraintEqualToAnchor:iconBgView.centerYAnchor],
        [iconImageView.widthAnchor constraintEqualToConstant:40],
        [iconImageView.heightAnchor constraintEqualToConstant:40],
        
        // 标题约束
        [titleLabel.topAnchor constraintEqualToAnchor:iconBgView.bottomAnchor constant:25],
        [titleLabel.leadingAnchor constraintEqualToAnchor:containerView.leadingAnchor constant:20],
        [titleLabel.trailingAnchor constraintEqualToAnchor:containerView.trailingAnchor constant:-20],
        
        // 提示信息约束
        [messageLabel.topAnchor constraintEqualToAnchor:titleLabel.bottomAnchor constant:12],
        [messageLabel.leadingAnchor constraintEqualToAnchor:containerView.leadingAnchor constant:20],
        [messageLabel.trailingAnchor constraintEqualToAnchor:containerView.trailingAnchor constant:-20],
        
        // 公众号ID约束
        [accountIdLabel.topAnchor constraintEqualToAnchor:messageLabel.bottomAnchor constant:8],
        [accountIdLabel.leadingAnchor constraintEqualToAnchor:containerView.leadingAnchor constant:20],
        [accountIdLabel.trailingAnchor constraintEqualToAnchor:containerView.trailingAnchor constant:-20],
        
        // 关注公众号按钮约束
        [followButton.topAnchor constraintEqualToAnchor:accountIdLabel.bottomAnchor constant:25],
        [followButton.leadingAnchor constraintEqualToAnchor:containerView.leadingAnchor constant:20],
        [followButton.trailingAnchor constraintEqualToAnchor:containerView.trailingAnchor constant:-20],
        [followButton.heightAnchor constraintEqualToConstant:50],
        
        // 重新检查按钮约束
        [checkButton.topAnchor constraintEqualToAnchor:followButton.bottomAnchor constant:12],
        [checkButton.leadingAnchor constraintEqualToAnchor:containerView.leadingAnchor constant:20],
        [checkButton.trailingAnchor constraintEqualToAnchor:containerView.trailingAnchor constant:-20],
        [checkButton.bottomAnchor constraintEqualToAnchor:containerView.bottomAnchor constant:-25],
        [checkButton.heightAnchor constraintEqualToConstant:50]
    ]];
    
    // 添加遮罩到视图
    [self.view addSubview:overlay];
    
    // 添加淡入动画
    overlay.alpha = 0;
    containerView.transform = CGAffineTransformMakeScale(0.9, 0.9);
    [UIView animateWithDuration:0.3 animations:^{
        overlay.alpha = 1;
        containerView.transform = CGAffineTransformIdentity;
    }];
    
    // 禁用 tableView 交互
    self.tableView.userInteractionEnabled = NO;
}

// 隐藏授权提示遮罩
- (void)hideAuthorizationOverlay {
    if (self.authorizationOverlay) {
        // 添加淡出动画
        [UIView animateWithDuration:0.25 animations:^{
            self.authorizationOverlay.alpha = 0;
        } completion:^(BOOL finished) {
            [self.authorizationOverlay removeFromSuperview];
            self.authorizationOverlay = nil;
        }];
    }
    
    // 启用 tableView 交互
    self.tableView.userInteractionEnabled = YES;
    
    // 检查用户协议
    [self checkUserAgreement];
}

// 关注公众号
- (void)followOfficialAccount {
    CSAuthorizationManager *authManager = [CSAuthorizationManager sharedManager];
    [authManager openOfficialAccountFromViewController:self];
}

// 重新检查授权
- (void)recheckAuthorization {
    CSAuthorizationManager *authManager = [CSAuthorizationManager sharedManager];
    BOOL isAuthorized = [authManager isAuthorized];
    
    if (isAuthorized) {
        // 授权成功，隐藏遮罩
        self.isAuthorized = YES;
        [self hideAuthorizationOverlay];
    } else {
        // 授权失败，显示提示
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                       message:@"尚未关注公众号，请先关注公众号"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

// 检查用户是否已同意使用声明
- (void)checkUserAgreement {
    BOOL hasAccepted = [[NSUserDefaults standardUserDefaults] boolForKey:kUserAgreementAcceptedKey];
    if (!hasAccepted) {
        // 如果用户尚未同意，显示声明弹窗
        [self showUserAgreementAlert];
    }
}

// 显示用户协议弹窗
- (void)showUserAgreementAlert {
    // 使用UIAlertController创建弹窗
    UIAlertController *alertController = [UIAlertController 
                                          alertControllerWithTitle:@"用户使用声明" 
                                          message:[self userAgreementText]
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    // 添加继续按钮 - 第一步只显示协议内容
    self.continueAction = [UIAlertAction 
                          actionWithTitle:@"请等待5秒" 
                          style:UIAlertActionStyleDefault 
                          handler:^(UIAlertAction * _Nonnull action) {
        // 用户点击继续后，显示第二步确认界面
        [self showAgreementConfirmAlert];
    }];
    
    // 禁用继续按钮，倒计时后启用
    self.continueAction.enabled = NO;
    
    // 添加查看TG频道按钮 - 保持取消按钮样式但防止关闭弹窗
    UIAlertAction *tgAction = [UIAlertAction 
                               actionWithTitle:@"查看TG频道" 
                               style:UIAlertActionStyleCancel 
                               handler:^(UIAlertAction * _Nonnull action) {
        // 跳转到TG频道
        NSURL *telegramURL = [NSURL URLWithString:@"https://t.me/zaiyebuhui"];
        [[UIApplication sharedApplication] openURL:telegramURL options:@{} completionHandler:^(BOOL success) {
            // 在返回后重新显示协议弹窗
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showUserAgreementAlert];
            });
        }];
    }];
    
    [alertController addAction:self.continueAction];
    [alertController addAction:tgAction];
    
    // 显示弹窗
    [self presentViewController:alertController animated:YES completion:^{
        // 弹窗显示后，开始倒计时
        self.countdownSeconds = 5;
        self.countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                              target:self
                                                            selector:@selector(updateCountdown)
                                                            userInfo:nil
                                                             repeats:YES];
    }];
}

// 更新倒计时
- (void)updateCountdown {
    self.countdownSeconds--;
    
    if (self.countdownSeconds <= 0) {
        // 倒计时结束，停止计时器
        [self.countdownTimer invalidate];
        self.countdownTimer = nil;
        
        // 启用继续按钮
        self.continueAction.enabled = YES;
        
        // 更新按钮标题
        [self.continueAction setValue:@"继续" forKey:@"title"];
    } else {
        // 更新按钮标题，显示剩余时间
        NSString *title = [NSString stringWithFormat:@"请等待%ld秒", (long)self.countdownSeconds];
        [self.continueAction setValue:title forKey:@"title"];
    }
}

// 显示确认输入界面 - 第二步
- (void)showAgreementConfirmAlert {
    UIAlertController *confirmAlert = [UIAlertController 
                                       alertControllerWithTitle:@"确认同意" 
                                       message:@"请输入\"我已阅读并同意\"以确认您已阅读并同意用户协议"
                                       preferredStyle:UIAlertControllerStyleAlert];
    
    // 添加文本框，要求用户输入"我已阅读并同意"
    [confirmAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入\"我已阅读并同意\"";
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    
    // 添加同意按钮
    UIAlertAction *agreeAction = [UIAlertAction 
                                  actionWithTitle:@"确认" 
                                  style:UIAlertActionStyleDefault 
                                  handler:^(UIAlertAction * _Nonnull action) {
        // 获取用户输入的文本
        UITextField *textField = confirmAlert.textFields.firstObject;
        NSString *userInput = textField.text;
        
        // 验证用户输入是否为"我已阅读并同意"
        if ([userInput isEqualToString:@"我已阅读并同意"]) {
            // 保存用户同意状态
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kUserAgreementAcceptedKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
        } else {
            // 如果输入不正确，重新显示弹窗，并提示用户输入错误
            UIAlertController *errorAlert = [UIAlertController
                                             alertControllerWithTitle:@"输入错误"
                                             message:@"请正确输入\"我已阅读并同意\"才能继续使用"
                                             preferredStyle:UIAlertControllerStyleAlert];
            
            [errorAlert addAction:[UIAlertAction actionWithTitle:@"重试"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                // 重新显示确认界面
                [self showAgreementConfirmAlert];
            }]];
            
            [self presentViewController:errorAlert animated:YES completion:nil];
        }
    }];
    
    // 添加返回按钮，返回到协议阅读界面
    UIAlertAction *backAction = [UIAlertAction 
                                actionWithTitle:@"返回" 
                                style:UIAlertActionStyleDefault 
                                handler:^(UIAlertAction * _Nonnull action) {
        // 返回到协议阅读界面
        [self showUserAgreementAlert];
    }];
    
    [confirmAlert addAction:agreeAction];
    [confirmAlert addAction:backAction];
    
    // 显示弹窗
    [self presentViewController:confirmAlert animated:YES completion:nil];
}

// 用户协议文本
- (NSString *)userAgreementText {
    return @"尊敬的用户：\n\n"
           @"欢迎使用本微信插件功能。使用本插件前，请您仔细阅读以下声明：\n\n"
           @"1. 本插件由再也不会开发，仅在Telegram频道发布。\n\n"
           @"2. 二次发布必须保留原始开发者署名，不得修改或删除。\n\n"
           @"3. 本插件仅供个人学习研究使用，不得用于任何商业用途。\n\n"
           @"4. 严禁恶意改名盈利，所有未经授权进行商业用途的行为将被永久拉黑。\n\n"
           @"5. 使用本插件可能违反微信软件的使用条款，可能导致您的微信账号被封禁或限制。\n\n"
           @"6. 您应自行承担使用本插件的全部风险和法律责任，开发者不对因使用本插件导致的任何直接或间接损失负责。\n\n"
           @"7. 严禁利用本插件从事任何违法违规活动，包括但不限于侵犯他人隐私、进行网络诈骗等。\n\n"
           @"8. 开发者保留随时修改、中断或终止本插件的权利，无需事先通知。";
}

// 预加载头像图片
- (void)preloadAvatarImage {
    // 添加加载指示器
    if (!self.loadingIndicator) {
        self.loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
        self.loadingIndicator.center = self.avatarImageView.center;
        [self.headerView addSubview:self.loadingIndicator];
        [self.loadingIndicator startAnimating];
    }
    
    // 1. 先尝试从内存缓存加载
    NSData *cachedImageData = [[NSUserDefaults standardUserDefaults] objectForKey:kAvatarCacheKey];
    if (cachedImageData) {
        UIImage *cachedImage = [UIImage imageWithData:cachedImageData];
        if (cachedImage) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.avatarImageView.image = cachedImage;
                [self.loadingIndicator stopAnimating];
                [self.loadingIndicator removeFromSuperview];
            });
            return;
        }
    }
    
    // 2. 如果内存缓存没有，则从URL加载
    NSString *avatarURL = [[NSUserDefaults standardUserDefaults] objectForKey:kUserAvatarURLKey];
    if (avatarURL.length > 0) {
        NSURL *url = [NSURL URLWithString:avatarURL];
        if (url) {
            NSURLSession *session = [NSURLSession sharedSession];
            NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (error || !data) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.loadingIndicator stopAnimating];
                        [self.loadingIndicator removeFromSuperview];
                    });
                    return;
                }
                
                UIImage *image = [UIImage imageWithData:data];
                if (!image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.loadingIndicator stopAnimating];
                        [self.loadingIndicator removeFromSuperview];
                    });
                    return;
                }
                
                // 缓存图片数据
                [[NSUserDefaults standardUserDefaults] setObject:data forKey:kAvatarCacheKey];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 设置图片
                    self.avatarImageView.image = image;
                    
                    // 确保圆角
                    self.avatarImageView.layer.cornerRadius = kAvatarSize / 2;
                    self.avatarImageView.layer.masksToBounds = YES;
                    
                    // 停止加载指示器
                    [self.loadingIndicator stopAnimating];
                    [self.loadingIndicator removeFromSuperview];
                });
            }];
            [task resume];
        }
    } else {
        // 如果没有URL，则使用CSUserInfoHelper获取
        [self loadAvatarImage];
    }
}

// 加载头像图片 (备用方法，当预加载失败时使用)
- (void)loadAvatarImage {
    NSString *avatarURL = [CSUserInfoHelper getUserAvatarURL];
    if (avatarURL.length > 0) {
        NSURL *url = [NSURL URLWithString:avatarURL];
        if (url) {
            NSURLSession *session = [NSURLSession sharedSession];
            NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (error || !data) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.loadingIndicator stopAnimating];
                        [self.loadingIndicator removeFromSuperview];
                    });
                    return;
                }
                
                UIImage *image = [UIImage imageWithData:data];
                if (!image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.loadingIndicator stopAnimating];
                        [self.loadingIndicator removeFromSuperview];
                    });
                    return;
                }
                
                // 缓存图片数据
                [[NSUserDefaults standardUserDefaults] setObject:data forKey:kAvatarCacheKey];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 设置图片
                    self.avatarImageView.image = image;
                    
                    // 确保圆角
                    self.avatarImageView.layer.cornerRadius = kAvatarSize / 2;
                    self.avatarImageView.layer.masksToBounds = YES;
                    
                    // 停止加载指示器
                    [self.loadingIndicator stopAnimating];
                    [self.loadingIndicator removeFromSuperview];
                });
            }];
            [task resume];
        }
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.loadingIndicator stopAnimating];
            [self.loadingIndicator removeFromSuperview];
        });
    }
}

- (void)setupHeaderView {
    // 创建头部视图
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, kHeaderViewHeight)];
    self.headerView.backgroundColor = [UIColor clearColor];
    
    // 创建头像视图
    self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - kAvatarSize) / 2, 
                                                                        kAvatarTopMargin, 
                                                                        kAvatarSize, 
                                                                        kAvatarSize)];
    self.avatarImageView.layer.cornerRadius = kAvatarSize / 2;
    self.avatarImageView.layer.masksToBounds = YES;
    self.avatarImageView.backgroundColor = [UIColor systemGray5Color];
    self.avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    // 设置默认头像
    if (@available(iOS 13.0, *)) {
        UIImage *defaultAvatar = [UIImage systemImageNamed:@"person.crop.circle.fill"];
        UIImageSymbolConfiguration *config = [UIImageSymbolConfiguration configurationWithPointSize:60 weight:UIImageSymbolWeightRegular];
        self.avatarImageView.image = [defaultAvatar imageWithConfiguration:config];
        self.avatarImageView.tintColor = [UIColor systemGray3Color];
    }
    
    // 创建昵称标签
    self.nicknameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLabelHorizontalMargin, 
                                                                  CGRectGetMaxY(self.avatarImageView.frame) + kNicknameTopMargin,
                                                                  self.view.bounds.size.width - 2 * kLabelHorizontalMargin, 
                                                                  kNicknameHeight)];
    self.nicknameLabel.textAlignment = NSTextAlignmentCenter;
    self.nicknameLabel.font = [UIFont systemFontOfSize:kNicknameFontSize weight:UIFontWeightMedium];
    self.nicknameLabel.text = [CSUserInfoHelper getUserNickname];
    
    // 创建微信号标签
    self.wxidLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLabelHorizontalMargin,
                                                              CGRectGetMaxY(self.nicknameLabel.frame) + kWXIDTopMargin,
                                                              self.view.bounds.size.width - 2 * kLabelHorizontalMargin,
                                                              kWXIDHeight)];
    self.wxidLabel.textAlignment = NSTextAlignmentCenter;
    self.wxidLabel.font = [UIFont systemFontOfSize:kWXIDFontSize];
    self.wxidLabel.textColor = [UIColor systemGrayColor];
    NSString *aliasName = [CSUserInfoHelper getUserAliasName];
    self.wxidLabel.text = [NSString stringWithFormat:@"微信号: %@", aliasName ?: @"未知"];
    
    // 添加视图到headerView
    [self.headerView addSubview:self.avatarImageView];
    [self.headerView addSubview:self.nicknameLabel];
    [self.headerView addSubview:self.wxidLabel];
    
    // 加载头像
    [self loadAvatarImage];
}

- (void)setupData {
    // 账号与安全组
    CSSettingItem *accountItem = [CSSettingItem itemWithTitle:@"账号信息" 
                                                   iconName:@"person.crop.circle" 
                                                  iconColor:[UIColor systemBlueColor]
                                                    detail:nil];
    
    CSSettingItem *favoriteAuthItem = [CSSettingItem itemWithTitle:@"收藏验证"
                                                        iconName:@"star.fill"
                                                       iconColor:[UIColor systemYellowColor]
                                                         detail:nil];
    
    CSSettingSection *accountSection = [CSSettingSection sectionWithHeader:@"账号与安全" 
                                                                   items:@[accountItem, 
                                                                          favoriteAuthItem]];
    
    // 界面定制组
    CSSettingItem *navigationTitleItem = [CSSettingItem itemWithTitle:@"顶栏信息" 
                                                           iconName:@"text.aligncenter" 
                                                          iconColor:[UIColor systemGreenColor]
                                                            detail:nil];
    
    CSSettingItem *avatarItem = [CSSettingItem itemWithTitle:@"头像设置" 
                                                  iconName:@"person.crop.square" 
                                                 iconColor:[UIColor systemOrangeColor]
                                                   detail:nil];
    
    CSSettingItem *touchTrailItem = [CSSettingItem itemWithTitle:@"触摸轨迹"
                                                      iconName:@"hand.tap.fill"
                                                     iconColor:[UIColor systemTealColor]
                                                       detail:nil];
    
    // 添加界面简化项
    CSSettingItem *enhanceUIItem = [CSSettingItem itemWithTitle:@"界面简化" 
                                                       iconName:@"rectangle.grid.1x2" 
                                                      iconColor:[UIColor systemIndigoColor]
                                                        detail:nil];
    
    // 添加界面净化项
    CSSettingItem *cleanUIItem = [CSSettingItem itemWithTitle:@"界面净化" 
                                                   iconName:@"trash" 
                                                  iconColor:[UIColor systemRedColor]
                                                    detail:nil];
    
    // 添加气泡样式项
    CSSettingItem *bubbleStyleItem = [CSSettingItem itemWithTitle:@"气泡样式"
                                                        iconName:@"rectangle.roundedtop"
                                                       iconColor:[UIColor systemBlueColor]
                                                         detail:nil];
    
    // 添加列表圆角项
    CSSettingItem *listCornerRadiusItem = [CSSettingItem itemWithTitle:@"列表圆角"
                                                             iconName:@"rectangle.on.rectangle"
                                                            iconColor:[UIColor systemIndigoColor]
                                                              detail:nil];
    
    // 添加底栏样式项
    CSSettingItem *tabBarStyleItem = [CSSettingItem itemWithTitle:@"底栏样式"
                                                       iconName:@"rectangle.bottomthird.inset.filled"
                                                      iconColor:[UIColor systemBlueColor]
                                                        detail:nil];
    
    // 添加布局设置项
    CSSettingItem *layoutSettingsItem = [CSSettingItem itemWithTitle:@"布局设置"
                                                          iconName:@"rectangle.3.group"
                                                         iconColor:[UIColor systemOrangeColor]
                                                           detail:nil];
    
    // 添加聊天分组设置项
    CSSettingItem *chatGroupItem = [CSSettingItem itemWithTitle:@"聊天分组"
                                                     iconName:@"rectangle.split.3x3"
                                                    iconColor:[UIColor systemCyanColor]
                                                      detail:nil];
    
    CSSettingSection *uiSection = [CSSettingSection sectionWithHeader:@"界面定制"
                                                              items:@[navigationTitleItem,
                                                                     avatarItem,
                                                                     touchTrailItem,
                                                                     enhanceUIItem,
                                                                     cleanUIItem,
                                                                     bubbleStyleItem,
                                                                     listCornerRadiusItem,
                                                                     tabBarStyleItem,
                                                                     layoutSettingsItem,
                                                                     chatGroupItem]];
    
    // 功能增强组
    CSSettingItem *backgroundRunItem = [CSSettingItem itemWithTitle:@"后台运行" 
                                                         iconName:@"arrow.clockwise.icloud" 
                                                        iconColor:[UIColor systemPurpleColor]
                                                          detail:nil];
    
    CSSettingItem *gameCheatsItem = [CSSettingItem itemWithTitle:@"游戏辅助"
                                                      iconName:@"gamecontroller.fill"
                                                     iconColor:[UIColor systemGreenColor]
                                                       detail:nil];
    
    // 添加聊天按钮布局菜单项
    CSSettingItem *chatAttachmentItem = [CSSettingItem itemWithTitle:@"附件布局"
                                                          iconName:@"square.grid.2x2"
                                                         iconColor:[UIColor systemTealColor]
                                                           detail:nil];

    // 添加信息时间设置项
    CSSettingItem *messageTimeItem = [CSSettingItem itemWithTitle:@"信息时间"
                                                        iconName:@"clock.fill"
                                                       iconColor:[UIColor systemBlueColor]
                                                         detail:nil];

    // 添加聊天占位文本设置项
    CSSettingItem *inputTextItem = [CSSettingItem itemWithTitle:@"文本占位"
                                                      iconName:@"text.bubble.fill"
                                                     iconColor:[UIColor systemPinkColor]
                                                       detail:nil];

    // 添加防止撤回设置项
    CSSettingItem *revokeItem = [CSSettingItem itemWithTitle:@"防止撤回"
                                                   iconName:@"arrow.uturn.backward.circle"
                                                  iconColor:[UIColor systemRedColor]
                                                    detail:nil];

    // 添加红包功能设置项
    CSSettingItem *redEnvelopItem = [CSSettingItem itemWithTitle:@"红包功能"
                                                       iconName:@"gift.fill"
                                                      iconColor:[UIColor systemRedColor]
                                                        detail:nil];
    
    // 添加自动收款设置项
    CSSettingItem *receiveTransferItem = [CSSettingItem itemWithTitle:@"自动收款"
                                                            iconName:@"yensign.circle.fill"
                                                           iconColor:[UIColor systemGreenColor]
                                                             detail:nil];
    
    // 添加消息手势设置项
    CSSettingItem *messageGestureItem = [CSSettingItem itemWithTitle:@"消息手势"
                                                           iconName:@"hand.draw.fill"
                                                          iconColor:[UIColor systemBlueColor]
                                                            detail:nil];

    // 添加语音转发设置项
    CSSettingItem *voiceForwardItem = [CSSettingItem itemWithTitle:@"语音转发"
                                                         iconName:@"waveform.circle.fill"
                                                        iconColor:[UIColor systemGreenColor]
                                                          detail:nil];

    // 添加复读功能设置项
    CSSettingItem *repeatItem = [CSSettingItem itemWithTitle:@"复读功能"
                                                   iconName:@"repeat.circle.fill"
                                                  iconColor:[UIColor systemPurpleColor]
                                                    detail:nil];

    CSSettingSection *enhancementSection = [CSSettingSection sectionWithHeader:@"功能增强" 
                                                                      items:@[backgroundRunItem,
                                                                             gameCheatsItem,
                                                                             chatAttachmentItem,
                                                                             messageTimeItem,
                                                                             inputTextItem,
                                                                             revokeItem,
                                                                             redEnvelopItem,
                                                                             receiveTransferItem,
                                                                             messageGestureItem,
                                                                             voiceForwardItem,
                                                                             repeatItem]];
    
    // 添加插件设置组
    CSSettingItem *entrySettingsItem = [CSSettingItem itemWithTitle:@"入口设置"
                                                         iconName:@"door.right.hand.open"
                                                        iconColor:[UIColor systemBrownColor]
                                                          detail:nil];
    
    // 添加版本控制项到插件设置组
    CSSettingItem *versionControlItem = [CSSettingItem itemWithTitle:@"版本控制"
                                                          iconName:@"gear.circle"
                                                         iconColor:[UIColor systemIndigoColor]
                                                           detail:nil];
    
    // 添加热更新控制项
    CSSettingItem *updateControlItem = [CSSettingItem itemWithTitle:@"更新控制"
                                                          iconName:@"xmark.shield.fill"
                                                         iconColor:[UIColor systemRedColor]
                                                           detail:nil];
    
    // 添加重置设置项
    CSSettingItem *resetSettingsItem = [CSSettingItem itemWithTitle:@"重置设置"
                                                         iconName:@"arrow.counterclockwise.circle"
                                                        iconColor:[UIColor systemRedColor]
                                                          detail:nil];
    
    // 添加备份配置项
    CSSettingItem *backupSettingsItem = [CSSettingItem itemWithTitle:@"备份配置"
                                                          iconName:@"externaldrive.badge.icloud"
                                                         iconColor:[UIColor systemGreenColor]
                                                           detail:nil];
    
    NSMutableArray *pluginItems = [NSMutableArray arrayWithObjects:entrySettingsItem, 
                                   versionControlItem,
                                   updateControlItem,
                                   resetSettingsItem,
                                   backupSettingsItem, nil];
    
    CSSettingSection *pluginSection = [CSSettingSection sectionWithHeader:@"插件设置"
                                                                 items:pluginItems];
    
    // 关于组
    CSSettingItem *versionItem = [CSSettingItem itemWithTitle:@"版本信息"
                                                   iconName:@"info.circle"
                                                  iconColor:[UIColor systemBlueColor]
                                                    detail:kPluginVersionString];
    
    CSSettingItem *authorItem = [CSSettingItem itemWithTitle:@"支持作者"
                                                   iconName:@"person.circle"
                                                  iconColor:[UIColor systemRedColor]
                                                    detail:@"️赞助咖啡☕️(≧▽≦)"];
    
    CSSettingSection *aboutSection = [CSSettingSection sectionWithHeader:@"关于"
                                                                 items:@[versionItem, authorItem]];
    
    self.sections = @[accountSection, uiSection, enhancementSection, pluginSection, aboutSection];
}

- (void)setupUI {
    // 设置背景颜色
    self.view.backgroundColor = [UIColor systemGroupedBackgroundColor];
    
    // 创建并配置tableView
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleInsetGrouped];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.backgroundColor = [UIColor systemGroupedBackgroundColor];
    
    // 设置分割线样式
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 54, 0, 0);
    
    // 设置tableView的头部视图
    self.tableView.tableHeaderView = self.headerView;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // 注册通用设置cell
    [CSSettingTableViewCell registerToTableView:self.tableView];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sections[section].items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CSSettingTableViewCell reuseIdentifier]];
    
    // 获取当前项数据并配置cell
    CSSettingItem *item = self.sections[indexPath.section].items[indexPath.row];
    [cell configureWithItem:item];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sections[section].header;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 获取点击的item
    CSSettingItem *item = self.sections[indexPath.section].items[indexPath.row];
    
    // 根据item类型和标题处理不同的点击事件
    if (item.itemType == CSSettingItemTypeNormal) {
        // 处理账号信息点击
        if ([item.title isEqualToString:@"账号信息"]) {
            CSAccountDetailViewController *detailVC = [[CSAccountDetailViewController alloc] initWithStyle:UITableViewStyleInsetGrouped];
            [self.navigationController pushViewController:detailVC animated:YES];
        }
        // 处理顶栏信息点击
        else if ([item.title isEqualToString:@"顶栏信息"]) {
            CSNavigationTitleSettingsViewController *settingsVC = [[CSNavigationTitleSettingsViewController alloc] initWithStyle:UITableViewStyleInsetGrouped];
            [self.navigationController pushViewController:settingsVC animated:YES];
        }
        // 处理头像设置点击
        else if ([item.title isEqualToString:@"头像设置"]) {
            CSAvatarSettingsViewController *avatarVC = [[CSAvatarSettingsViewController alloc] initWithStyle:UITableViewStyleInsetGrouped];
            [self.navigationController pushViewController:avatarVC animated:YES];
        }
        // 处理后台运行点击
        else if ([item.title isEqualToString:@"后台运行"]) {
            CSBackgroundRunViewController *backgroundVC = [[CSBackgroundRunViewController alloc] initWithStyle:UITableViewStyleInsetGrouped];
            [self.navigationController pushViewController:backgroundVC animated:YES];
        }
        // 处理触摸轨迹点击
        else if ([item.title isEqualToString:@"触摸轨迹"]) {
            CSTouchTrailViewController *touchTrailVC = [[CSTouchTrailViewController alloc] initWithStyle:UITableViewStyleInsetGrouped];
            [self.navigationController pushViewController:touchTrailVC animated:YES];
        }
        // 处理游戏辅助点击
        else if ([item.title isEqualToString:@"游戏辅助"]) {
            CSGameCheatsViewController *gameCheatsVC = [[CSGameCheatsViewController alloc] initWithStyle:UITableViewStyleInsetGrouped];
            [self.navigationController pushViewController:gameCheatsVC animated:YES];
        }
        // 处理收藏验证点击
        else if ([item.title isEqualToString:@"收藏验证"]) {
            CSFavoriteSettingsViewController *favoriteVC = [[CSFavoriteSettingsViewController alloc] initWithStyle:UITableViewStyleInsetGrouped];
            [self.navigationController pushViewController:favoriteVC animated:YES];
        }
        // 处理界面简化点击
        else if ([item.title isEqualToString:@"界面简化"]) {
            CSWCEnhanceViewController *enhanceVC = [[CSWCEnhanceViewController alloc] initWithStyle:UITableViewStyleInsetGrouped];
            [self.navigationController pushViewController:enhanceVC animated:YES];
        }
        // 处理界面净化点击
        else if ([item.title isEqualToString:@"界面净化"]) {
            CSUICleanViewController *cleanVC = [[CSUICleanViewController alloc] initWithStyle:UITableViewStyleInsetGrouped];
            [self.navigationController pushViewController:cleanVC animated:YES];
        }
        // 处理气泡样式点击
        else if ([item.title isEqualToString:@"气泡样式"]) {
            CSBubbleStyleSettingsViewController *bubbleStyleVC = [[CSBubbleStyleSettingsViewController alloc] initWithStyle:UITableViewStyleInsetGrouped];
            [self.navigationController pushViewController:bubbleStyleVC animated:YES];
        }
        // 处理列表圆角点击
        else if ([item.title isEqualToString:@"列表圆角"]) {
            CSListCornerRadiusSettingsViewController *listCornerRadiusVC = [[CSListCornerRadiusSettingsViewController alloc] initWithStyle:UITableViewStyleInsetGrouped];
            [self.navigationController pushViewController:listCornerRadiusVC animated:YES];
        }
        // 处理底栏样式点击
        else if ([item.title isEqualToString:@"底栏样式"]) {
            CSTabBarStyleSettingsViewController *tabBarStyleVC = [[CSTabBarStyleSettingsViewController alloc] initWithStyle:UITableViewStyleInsetGrouped];
            [self.navigationController pushViewController:tabBarStyleVC animated:YES];
        }
        // 处理布局设置点击
        else if ([item.title isEqualToString:@"布局设置"]) {
            CSLayoutSettingsViewController *layoutSettingsVC = [[CSLayoutSettingsViewController alloc] initWithStyle:UITableViewStyleInsetGrouped];
            [self.navigationController pushViewController:layoutSettingsVC animated:YES];
        }
        // 处理聊天分组点击
        else if ([item.title isEqualToString:@"聊天分组"]) {
            CSChatGroupSettingsViewController *chatGroupVC = [[CSChatGroupSettingsViewController alloc] initWithStyle:UITableViewStyleInsetGrouped];
            [self.navigationController pushViewController:chatGroupVC animated:YES];
        }
        // 处理入口设置点击
        else if ([item.title isEqualToString:@"入口设置"]) {
            CSEntrySettingsViewController *entrySettingsVC = [[CSEntrySettingsViewController alloc] initWithStyle:UITableViewStyleInsetGrouped];
            [self.navigationController pushViewController:entrySettingsVC animated:YES];
        }
        // 处理聊天按钮布局点击
        else if ([item.title isEqualToString:@"附件布局"]) {
            CSChatAttachmentSettingsViewController *chatAttachmentVC = [[CSChatAttachmentSettingsViewController alloc] initWithStyle:UITableViewStyleInsetGrouped];
            [self.navigationController pushViewController:chatAttachmentVC animated:YES];
        }
        // 处理信息时间点击
        else if ([item.title isEqualToString:@"信息时间"]) {
            CSMessageTimeSettingsViewController *messageTimeVC = [[CSMessageTimeSettingsViewController alloc] initWithStyle:UITableViewStyleInsetGrouped];
            [self.navigationController pushViewController:messageTimeVC animated:YES];
        }
        // 处理爱心文点击
        else if ([item.title isEqualToString:@"文本占位"]) {
            CSInputTextSettingsViewController *inputTextVC = [[CSInputTextSettingsViewController alloc] initWithStyle:UITableViewStyleInsetGrouped];
            [self.navigationController pushViewController:inputTextVC animated:YES];
        }
        // 处理防止撤回点击
        else if ([item.title isEqualToString:@"防止撤回"]) {
            CSRevokeSettingsViewController *revokeVC = [[CSRevokeSettingsViewController alloc] initWithStyle:UITableViewStyleInsetGrouped];
            [self.navigationController pushViewController:revokeVC animated:YES];
        }
        // 处理红包功能点击
        else if ([item.title isEqualToString:@"红包功能"]) {
            CSRedEnvelopSettingsViewController *redEnvelopVC = [[CSRedEnvelopSettingsViewController alloc] initWithStyle:UITableViewStyleInsetGrouped];
            [self.navigationController pushViewController:redEnvelopVC animated:YES];
        }
        // 处理自动收款点击
        else if ([item.title isEqualToString:@"自动收款"]) {
            CSReceiveTransferSettingsViewController *receiveTransferVC = [[CSReceiveTransferSettingsViewController alloc] initWithStyle:UITableViewStyleInsetGrouped];
            [self.navigationController pushViewController:receiveTransferVC animated:YES];
        }
        // 处理消息手势点击
        else if ([item.title isEqualToString:@"消息手势"]) {
            CSMessageGestureSettingsViewController *messageGestureVC = [[CSMessageGestureSettingsViewController alloc] initWithStyle:UITableViewStyleInsetGrouped];
            [self.navigationController pushViewController:messageGestureVC animated:YES];
        }
        // 处理语音转发点击
        else if ([item.title isEqualToString:@"语音转发"]) {
            CSVoiceForwardSettingsViewController *voiceForwardVC = [[CSVoiceForwardSettingsViewController alloc] initWithStyle:UITableViewStyleInsetGrouped];
            [self.navigationController pushViewController:voiceForwardVC animated:YES];
        }
        // 处理复读功能点击
        else if ([item.title isEqualToString:@"复读功能"]) {
            CSRepeatSettingsViewController *repeatVC = [[CSRepeatSettingsViewController alloc] initWithStyle:UITableViewStyleInsetGrouped];
            [self.navigationController pushViewController:repeatVC animated:YES];
        }
        // 处理版本控制点击
        else if ([item.title isEqualToString:@"版本控制"]) {
            CSVersionSettingsViewController *versionVC = [[CSVersionSettingsViewController alloc] initWithStyle:UITableViewStyleInsetGrouped];
            [self.navigationController pushViewController:versionVC animated:YES];
        }
        // 处理热更新控制点击
        else if ([item.title isEqualToString:@"更新控制"]) {
            CSUpdateControlViewController *updateControlVC = [[CSUpdateControlViewController alloc] initWithStyle:UITableViewStyleInsetGrouped];
            [self.navigationController pushViewController:updateControlVC animated:YES];
        }
        // 处理重置设置点击
        else if ([item.title isEqualToString:@"重置设置"]) {
            CSResetSettingsViewController *resetVC = [[CSResetSettingsViewController alloc] initWithStyle:UITableViewStyleInsetGrouped];
            [self.navigationController pushViewController:resetVC animated:YES];
        }
        // 处理备份配置点击
        else if ([item.title isEqualToString:@"备份配置"]) {
            CSBackupSettingsViewController *backupVC = [[CSBackupSettingsViewController alloc] initWithStyle:UITableViewStyleInsetGrouped];
            [self.navigationController pushViewController:backupVC animated:YES];
        }
        // 处理支持作者点击
        else if ([item.title isEqualToString:@"支持作者"]) {
            [self supportAuthor];
        }
    }
    // 处理输入类型项的点击
    else if (item.itemType == CSSettingItemTypeInput) {
        [CSUIHelper showInputAlertWithTitle:item.title
                                  message:nil
                               initialValue:item.inputValue
                               placeholder:item.inputPlaceholder
                          inViewController:self
                                completion:^(NSString *value) {
            // 更新item的值
            item.inputValue = value;
            
            // 刷新表格
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            
            // 执行回调
            if (item.inputValueChanged) {
                item.inputValueChanged(value);
            }
        }];
    }
}

// 设置cell的背景色
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // 使用secondarySystemGroupedBackgroundColor来获得正确的深色模式下的背景色
    if (@available(iOS 13.0, *)) {
        cell.backgroundColor = [UIColor secondarySystemGroupedBackgroundColor];
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    // 配置选中状态的背景色
    UIView *selectedBackgroundView = [[UIView alloc] init];
    if (@available(iOS 13.0, *)) {
        selectedBackgroundView.backgroundColor = [UIColor tertiarySystemGroupedBackgroundColor];
    } else {
        selectedBackgroundView.backgroundColor = [UIColor systemGray5Color];
    }
    cell.selectedBackgroundView = selectedBackgroundView;
}

#pragma mark - 支持作者

- (void)supportAuthor {
    [self showBlurOverlay];
    
    if (gCachedQRCodeImage) {
        NSLog(@"[SupportAuthor] Using cached QR code image");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.auto_scan_image"
                                                          object:nil
                                                        userInfo:@{@"image": gCachedQRCodeImage, @"blurOverlay": gBlurOverlayView ?: [NSNull null]}];
        [self openWeChatScanQRCode];
    } else {
        [self downloadAndSaveQRCodeImage];
    }
}

- (void)downloadAndSaveQRCodeImage {
    NSString *imageUrlString = @"https://i.postimg.cc/rwSLZ9KP/ZSM.jpg";
    NSURL *imageUrl = [NSURL URLWithString:imageUrlString];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
        
        if (imageData) {
            UIImage *image = [UIImage imageWithData:imageData];
            gCachedQRCodeImage = image;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"[SupportAuthor] QR code image downloaded and cached");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.auto_scan_image"
                                                                  object:nil
                                                                userInfo:@{@"image": image, @"blurOverlay": gBlurOverlayView ?: [NSNull null]}];
                
                [self openWeChatScanQRCode];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideBlurOverlay];
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"下载失败"
                                                                               message:@"无法下载赞赏码图片，请检查网络连接"
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定"
                                                                   style:UIAlertActionStyleDefault
                                                                 handler:nil];
                [alert addAction:okAction];
                [self presentViewController:alert animated:YES completion:nil];
            });
        }
    });
}

- (void)openWeChatScanQRCode {
    void (^openScanBlock)(void) = ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            Class WCBizUtilClass = NSClassFromString(@"WCBizUtil");
            if (WCBizUtilClass) {
                SEL jumpScanQRCodeSelector = NSSelectorFromString(@"jumpScanQRCode");
                if ([WCBizUtilClass respondsToSelector:jumpScanQRCodeSelector]) {
                    [WCBizUtilClass performSelector:jumpScanQRCodeSelector];
                }
            }
        });
    };
    
    UIViewController *topVC = [self topViewController];
    
    if (topVC.presentingViewController) {
        [topVC dismissViewControllerAnimated:YES completion:openScanBlock];
    } else if (topVC.navigationController) {
        [topVC.navigationController popToRootViewControllerAnimated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), openScanBlock);
    } else {
        openScanBlock();
    }
}

- (UIViewController *)topViewController {
    UIViewController *topVC = self;
    
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    
    if ([topVC isKindOfClass:[UINavigationController class]]) {
        topVC = [(UINavigationController *)topVC topViewController];
    }
    
    if ([topVC isKindOfClass:[UITabBarController class]]) {
        topVC = [(UITabBarController *)topVC selectedViewController];
    }
    
    return topVC;
}

- (void)showBlurOverlay {
    if (gBlurOverlayView) {
        [gBlurOverlayView removeFromSuperview];
        gBlurOverlayView = nil;
    }
    
    UIWindow *keyWindow = nil;
    if (@available(iOS 13.0, *)) {
        for (UIWindowScene *windowScene in [UIApplication sharedApplication].connectedScenes) {
            if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                for (UIWindow *window in windowScene.windows) {
                    if (window.isKeyWindow) {
                        keyWindow = window;
                        break;
                    }
                }
            }
        }
    }
    
    if (!keyWindow) {
        keyWindow = [UIApplication sharedApplication].keyWindow;
    }
    
    if (!keyWindow) {
        return;
    }
    
    gBlurOverlayView = [[UIView alloc] initWithFrame:keyWindow.bounds];
    gBlurOverlayView.backgroundColor = [UIColor clearColor];
    gBlurOverlayView.userInteractionEnabled = NO;
    
    if (@available(iOS 13.0, *)) {
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemMaterial];
        UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurView.frame = gBlurOverlayView.bounds;
        blurView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [gBlurOverlayView addSubview:blurView];
    } else {
        gBlurOverlayView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.95];
    }
    
    UIView *contentView = [[UIView alloc] init];
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [gBlurOverlayView addSubview:contentView];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    if (@available(iOS 13.0, *)) {
        activityIndicator.color = [UIColor labelColor];
    } else {
        activityIndicator.color = [UIColor darkGrayColor];
    }
    [activityIndicator startAnimating];
    [contentView addSubview:activityIndicator];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.text = @"正在打开赞赏页面";
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    if (@available(iOS 13.0, *)) {
        titleLabel.textColor = [UIColor labelColor];
    } else {
        titleLabel.textColor = [UIColor darkTextColor];
    }
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:titleLabel];
    
    UILabel *subtitleLabel = [[UILabel alloc] init];
    subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    subtitleLabel.text = @"请稍候...";
    subtitleLabel.font = [UIFont systemFontOfSize:14];
    if (@available(iOS 13.0, *)) {
        subtitleLabel.textColor = [UIColor secondaryLabelColor];
    } else {
        subtitleLabel.textColor = [UIColor grayColor];
    }
    subtitleLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:subtitleLabel];
    
    [NSLayoutConstraint activateConstraints:@[
        [contentView.centerXAnchor constraintEqualToAnchor:gBlurOverlayView.centerXAnchor],
        [contentView.centerYAnchor constraintEqualToAnchor:gBlurOverlayView.centerYAnchor],
        
        [activityIndicator.topAnchor constraintEqualToAnchor:contentView.topAnchor],
        [activityIndicator.centerXAnchor constraintEqualToAnchor:contentView.centerXAnchor],
        
        [titleLabel.topAnchor constraintEqualToAnchor:activityIndicator.bottomAnchor constant:20],
        [titleLabel.leadingAnchor constraintEqualToAnchor:contentView.leadingAnchor],
        [titleLabel.trailingAnchor constraintEqualToAnchor:contentView.trailingAnchor],
        
        [subtitleLabel.topAnchor constraintEqualToAnchor:titleLabel.bottomAnchor constant:8],
        [subtitleLabel.leadingAnchor constraintEqualToAnchor:contentView.leadingAnchor],
        [subtitleLabel.trailingAnchor constraintEqualToAnchor:contentView.trailingAnchor],
        [subtitleLabel.bottomAnchor constraintEqualToAnchor:contentView.bottomAnchor]
    ]];
    
    gBlurOverlayView.alpha = 0;
    [keyWindow addSubview:gBlurOverlayView];
    
    [UIView animateWithDuration:0.2 animations:^{
        gBlurOverlayView.alpha = 1;
    }];
}

- (void)hideBlurOverlay {
    if (gBlurOverlayView) {
        [UIView animateWithDuration:0.2 animations:^{
            gBlurOverlayView.alpha = 0;
        } completion:^(BOOL finished) {
            [gBlurOverlayView removeFromSuperview];
            gBlurOverlayView = nil;
        }];
    }
}

@end 