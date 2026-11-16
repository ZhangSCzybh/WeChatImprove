#import "CSAIReplySettingsViewController.h"
#import "CSCustomViewController.h"
#import "CSCloseFriendBridge.h"
#import "CSCloseFriendManager.h"
#import "CSCloseFriendSettingsViewController.h"
#import "CSBackupBootstrap.h"
#import "CSSettingTableViewCell.h"
#import "CSUserInfoHelper.h"
#import "CSAccountDetailViewController.h"
#import "CSNavigationTitleSettingsViewController.h"
#import "CSAvatarSettingsViewController.h"
#import "CSBackgroundRunViewController.h"
#import "CSBackgroundBlurSettingsViewController.h"
#import "CSTouchTrailViewController.h"
#import "CSGameCheatsViewController.h"
#import "CSFavoriteSettingsViewController.h"
#import "CSWCEnhanceViewController.h"
#import "CSUICleanViewController.h"
#import "CSEntrySettingsViewController.h"
#import "CSChatAttachmentSettingsViewController.h"
#import "CSVersionSettingsViewController.h"
#import "CSReleaseNotesViewController.h"
#import "CSNativeRewardPresenter.h"
#import "CSNativeSettingsHost.h"
#import "CSUpdateControlViewController.h"
#import "CSMessageTimeSettingsViewController.h"
#import "CSInputTextSettingsViewController.h"
#import "CSRevokeSettingsViewController.h"
#import "CSRedEnvelopSettingsViewController.h"
#import "CSReceiveTransferSettingsViewController.h"
#import "CSMessageGestureSettingsViewController.h"
#import "CSVoiceForwardSettingsViewController.h"
#import "CSRepeatSettingsViewController.h"
#import "CSImageStickerSettingsViewController.h"
#import "CSClownSettingsViewController.h"
#import "CSGroupChatSettingsViewController.h"
#import "CSAutomationSettingsViewController.h"
#import "CSScheduledTaskSettingsViewController.h"
#import "CSResetSettingsViewController.h"
#import "CSBackupSettingsViewController.h"
#import "CSBubbleStyleSettingsViewController.h"
#import "CSListCornerRadiusSettingsViewController.h"
#import "CSLayoutSettingsViewController.h"
#import "CSChatGroupSettingsViewController.h"
#import "CSTabBarStyleSettingsViewController.h"
#import "CSAuthorizationManager.h"
#import "CSClientGuardSettingsViewController.h"

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

@interface CSCustomViewController () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>
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
@property (nonatomic, assign) BOOL authorizationPromptInFlight;
@property (nonatomic, assign) BOOL returningFromAuthorization;
@property (nonatomic, strong) UILongPressGestureRecognizer *closeFriendEntryGesture;
@property (nonatomic, copy) NSDictionary *closeFriendEntryToken;
@property (nonatomic, assign) BOOL closeFriendEntryVisible;
@property (nonatomic, strong) UITapGestureRecognizer *closeFriendQuickEntryGesture;
@property (nonatomic, copy) NSDictionary *closeFriendQuickEntryToken;
@property (nonatomic) NSUInteger closeFriendQuickEntryCount;
@property (nonatomic) NSTimeInterval closeFriendQuickEntryLastTap;
@end

@implementation CSCustomViewController

- (UINavigationItem *)navigationItem {
    UIViewController *host = CSNativeSettingsHostForContent(self);
    return host == self ? [super navigationItem] : host.navigationItem;
}

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
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(closeFriendEntryPolicyChanged:)
                                                 name:CSCloseFriendPolicyDidChangeNotification
                                               object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(resetCloseFriendQuickEntry) name:UIApplicationDidEnterBackgroundNotification object:nil];
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // Rebuild before the first frame, including when returning under a different account.
    [self setupData];
    [self.tableView reloadData];
    // Covers direct third-party plugin registration routes before any settings content appears.
    UIView *cover=[self.view viewWithTag:871042];
    if(CSCloseFriendPluginEntryHidden() && !cover) {
        cover=[[UIView alloc] initWithFrame:self.view.bounds]; cover.tag=871042;
        cover.backgroundColor=UIColor.systemBackgroundColor; cover.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:cover];
    } else if(!CSCloseFriendPluginEntryHidden())[cover removeFromSuperview];
}

// All entry routes use the authorization manager's native alert.
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.returningFromAuthorization || self.authorizationPromptInFlight) return;
    if(CSCloseFriendPluginEntryHidden()) {
        CSCloseFriendAuthenticate(self,^(BOOL success){
            if(success && !CSCloseFriendPluginEntryHidden()) { [[self.view viewWithTag:871042] removeFromSuperview]; [self viewDidAppear:NO]; }
            else [self dismissViewControllerAnimated:YES completion:nil];
        });
        return;
    }
    [[self.view viewWithTag:871042] removeFromSuperview];

    [self setupData];
    [self.tableView reloadData];

    CSAuthorizationManager *authManager = [CSAuthorizationManager sharedManager];
    self.isAuthorized = [authManager isAuthorized];
    self.tableView.userInteractionEnabled = self.isAuthorized;
    if (!self.isAuthorized) {
        UIViewController *host = CSNativeSettingsHostForContent(self);
        if (host.presentedViewController) return;
        self.authorizationPromptInFlight = YES;
        __weak typeof(self) weakSelf = self;
        [authManager requestAuthorizationWithPresentingViewController:host completion:^(BOOL success, NSString *message) {
            typeof(self) self = weakSelf;
            if (!self) return;
            self.authorizationPromptInFlight = NO;
            self.isAuthorized = success;
            self.tableView.userInteractionEnabled = success;
            if (success) {
                [self checkUserAgreement];
            } else if ([message isEqualToString:@"用户取消授权"]) {
                [self returnFromUnauthorizedSettings];
            }
        }];
        return;
    }
    [self checkUserAgreement];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.returningFromAuthorization = NO;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self resetCloseFriendQuickEntry];
}

- (void)returnFromUnauthorizedSettings {
    UIViewController *host = CSNativeSettingsHostForContent(self);
    UINavigationController *navigation = host.navigationController;
    if (navigation) {
        // A third-party plugin manager may push the native host onto its own stack.
        if (navigation.topViewController != host) return;
        if (navigation.viewControllers.firstObject != host) {
            self.returningFromAuthorization = YES;
            [navigation popViewControllerAnimated:YES];
        } else if (navigation.presentingViewController) {
            self.returningFromAuthorization = YES;
            [navigation dismissViewControllerAnimated:YES completion:nil];
        }
    } else if (host.presentingViewController) {
        self.returningFromAuthorization = YES;
        [host dismissViewControllerAnimated:YES completion:nil];
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
    {
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
    [self installCloseFriendEntryGesture];
    
    // 加载头像
    [self loadAvatarImage];
}

- (void)installCloseFriendEntryGesture {
    if(self.closeFriendEntryGesture)return;
    self.avatarImageView.userInteractionEnabled=YES;
    UILongPressGestureRecognizer *gesture=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(discoverCloseFriendEntry:)];
    gesture.minimumPressDuration=2.0;
    gesture.allowableMovement=10.0;
    gesture.numberOfTouchesRequired=1;
    gesture.cancelsTouchesInView=NO;
    gesture.delegate=self;
    [self.avatarImageView addGestureRecognizer:gesture];
    self.closeFriendEntryGesture=gesture;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCloseFriendQuickEntry:)];
    tap.numberOfTapsRequired=1;
    tap.numberOfTouchesRequired=1;
    tap.cancelsTouchesInView=NO;
    tap.delegate=self;
    // A short release fails long-press immediately; a recognized long-press suppresses tap.
    [tap requireGestureRecognizerToFail:gesture];
    [self.avatarImageView addGestureRecognizer:tap];
    self.closeFriendQuickEntryGesture=tap;
}
- (BOOL)canDiscoverCloseFriendEntry {
    UIViewController *host=CSNativeSettingsHostForContent(self);
    return self.isAuthorized && self.view.window && !self.authorizationPromptInFlight &&
        UIApplication.sharedApplication.applicationState==UIApplicationStateActive &&
        (!host.navigationController || host.navigationController.topViewController==host) &&
        !host.presentedViewController && !self.presentedViewController;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldReceiveTouch:(UITouch *)touch {
    if(gesture==self.closeFriendQuickEntryGesture) {
        if(![self canDiscoverCloseFriendEntry]) { [self resetCloseFriendQuickEntry]; return NO; }
        CSCloseFriendManager *manager=CSCloseFriendManager.sharedManager;
        [manager refreshAccount];
        CSCloseFriendRuntime *runtime=manager.runtime;
        if(![self closeFriendQuickEntryTokenIsCurrent:self.closeFriendQuickEntryToken]) {
            [self resetCloseFriendQuickEntry];
            self.closeFriendQuickEntryToken=runtime.settingsAccessToken;
        }
        return [self closeFriendQuickEntryTokenIsCurrent:self.closeFriendQuickEntryToken];
    }
    if(gesture!=self.closeFriendEntryGesture)return YES;
    self.closeFriendEntryToken=nil;
    if(![self canDiscoverCloseFriendEntry])return NO;
    self.closeFriendEntryToken=[CSCloseFriendManager.sharedManager settingsEntryDiscoveryToken];
    return self.closeFriendEntryToken!=nil;
}
- (void)discoverCloseFriendEntry:(UILongPressGestureRecognizer *)gesture {
    if(gesture!=self.closeFriendEntryGesture)return;
    if(gesture.state!=UIGestureRecognizerStateBegan) {
        if(gesture.state==UIGestureRecognizerStateEnded || gesture.state==UIGestureRecognizerStateCancelled || gesture.state==UIGestureRecognizerStateFailed)self.closeFriendEntryToken=nil;
        return;
    }
    NSDictionary *token=self.closeFriendEntryToken;
    self.closeFriendEntryToken=nil;
    [self resetCloseFriendQuickEntry];
    if(![self canDiscoverCloseFriendEntry] || ![CSCloseFriendManager.sharedManager discoverSettingsEntryWithToken:token])return;
    [self setupData];
    [self.tableView reloadData];
    [[[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight] impactOccurred];
}
- (void)resetCloseFriendQuickEntry {
    [CSCloseFriendManager.sharedManager.runtime invalidateSettingsAccessToken:self.closeFriendQuickEntryToken];
    self.closeFriendQuickEntryToken=nil;
    self.closeFriendQuickEntryCount=0;
    self.closeFriendQuickEntryLastTap=0;
}
- (NSTimeInterval)closeFriendQuickEntryTimestamp { return NSProcessInfo.processInfo.systemUptime; }
- (BOOL)closeFriendQuickEntryTokenIsCurrent:(NSDictionary *)token {
    return token && !CSBackupAccountIsSuspended() && [token[@"epoch"] isEqual:@(CSCloseFriendAccountEpoch())] && [CSCloseFriendManager.sharedManager.runtime isSettingsTokenCurrent:token];
}
- (void)tapCloseFriendQuickEntry:(UITapGestureRecognizer *)gesture {
    if(gesture!=self.closeFriendQuickEntryGesture || gesture.state!=UIGestureRecognizerStateEnded)return;
    if(![self canDiscoverCloseFriendEntry] || ![self closeFriendQuickEntryTokenIsCurrent:self.closeFriendQuickEntryToken]) { [self resetCloseFriendQuickEntry]; return; }
    NSTimeInterval now=[self closeFriendQuickEntryTimestamp];
    if(!self.closeFriendQuickEntryCount || now<self.closeFriendQuickEntryLastTap || now>self.closeFriendQuickEntryLastTap+0.8)self.closeFriendQuickEntryCount=0;
    self.closeFriendQuickEntryLastTap=now;
    if(++self.closeFriendQuickEntryCount<5)return;
    self.closeFriendQuickEntryCount=0;
    self.closeFriendQuickEntryLastTap=0;
    [self confirmCloseFriendQuickEntryWithToken:self.closeFriendQuickEntryToken];
}
- (void)confirmCloseFriendQuickEntryWithToken:(NSDictionary *)token {
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"无密码进入密友设置" message:@"此入口无需密码，可查看和修改当前账号的密友、密群名单及保护选项。任何能操作这台已解锁手机的人，连续点击头像 5 次也能进入。进入本身不会解锁微信列表中的密友；主动修改保护选项会影响隐藏规则。离开设置流程、进入后台或切换账号后入口失效。此页还能经两级确认不可撤销地清空当前账号整个密友配置，任何能操作已解锁手机的人均可执行；修改密码仍须原密码验证。" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(__unused UIAlertAction *action){ [self resetCloseFriendQuickEntry]; }]];
    __weak UIAlertController *weakAlert=alert;
    [alert addAction:[UIAlertAction actionWithTitle:@"进入密友设置" style:UIAlertActionStyleDestructive handler:^(__unused UIAlertAction *action){
        [self finishCloseFriendQuickEntryAlert:weakAlert completion:^{
            CSCloseFriendManager *manager=CSCloseFriendManager.sharedManager;
            [manager refreshAccount];
            if(![self canDiscoverCloseFriendEntry] || ![self closeFriendQuickEntryTokenIsCurrent:token]) { [self resetCloseFriendQuickEntry]; return; }
            CSCloseFriendSettingsViewController *settings=[[CSCloseFriendSettingsViewController alloc] initWithStyle:UITableViewStyleInsetGrouped];
            settings.quickEntry=YES;
            settings.quickEntryToken=token;
            self.closeFriendQuickEntryToken=nil;
            UIViewController *host=CSNativeSettingsHostForContent(self);
            if(host.navigationController)[host.navigationController pushViewController:settings animated:YES];
            else [host presentViewController:[[UINavigationController alloc] initWithRootViewController:settings] animated:YES completion:nil];
        }];
    }]];
    [CSNativeSettingsHostForContent(self) presentViewController:alert animated:YES completion:nil];
}
- (void)finishCloseFriendQuickEntryAlert:(UIAlertController *)alert completion:(void (^)(void))completion {
    id<UIViewControllerTransitionCoordinator> transition=alert.transitionCoordinator;
    if(alert.isBeingDismissed && transition && [transition animateAlongsideTransition:nil completion:^(__unused id<UIViewControllerTransitionCoordinatorContext> context){ completion(); }])return;
    UIViewController *host=CSNativeSettingsHostForContent(self);
    if(alert && host.presentedViewController==alert)[alert dismissViewControllerAnimated:YES completion:completion];
    else completion();
}
- (void)closeFriendEntryPolicyChanged:(NSNotification *)notification {
    if(self.closeFriendQuickEntryToken && ![CSCloseFriendManager.sharedManager.runtime isSettingsTokenCurrent:self.closeFriendQuickEntryToken])[self resetCloseFriendQuickEntry];
    if(!self.isViewLoaded)return;
    if(self.closeFriendEntryVisible==[CSCloseFriendManager.sharedManager settingsEntryVisible])return;
    [self setupData];
    [self.tableView reloadData];
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
    
    NSMutableArray *accountItems=[NSMutableArray arrayWithArray:@[accountItem,favoriteAuthItem]];
    [accountItems addObject:[CSSettingItem itemWithTitle:@"防封检测" iconName:@"shield.lefthalf.filled"
        iconColor:UIColor.systemBlueColor detail:nil]];
    self.closeFriendEntryVisible=[CSCloseFriendManager.sharedManager settingsEntryVisible];
    if(self.closeFriendEntryVisible) {
        [accountItems addObject:[CSSettingItem itemWithTitle:@"捉迷藏呀" iconName:@"lock.shield" iconColor:UIColor.systemBlueColor detail:nil]];
    }
    CSSettingSection *accountSection = [CSSettingSection sectionWithHeader:@"账号与安全" items:accountItems];
    
    // 界面定制组
    CSSettingItem *navigationTitleItem = [CSSettingItem itemWithTitle:@"顶栏信息" 
                                                           iconName:@"person.text.rectangle.fill"
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
                                                        iconName:@"bubble.left.and.bubble.right.fill"
                                                       iconColor:[UIColor systemBlueColor]
                                                         detail:nil];
    
    // 添加列表圆角项
    CSSettingItem *listCornerRadiusItem = [CSSettingItem itemWithTitle:@"列表圆角"
                                                             iconName:@"list.bullet.rectangle.fill"
                                                            iconColor:[UIColor systemIndigoColor]
                                                              detail:nil];
    
    // 添加底栏样式项
    CSSettingItem *tabBarStyleItem = [CSSettingItem itemWithTitle:@"底栏样式"
                                                       iconName:@"ellipsis.rectangle.fill"
                                                      iconColor:[UIColor systemBlueColor]
                                                        detail:nil];
    
    // 添加布局设置项
    CSSettingItem *layoutSettingsItem = [CSSettingItem itemWithTitle:@"布局设置"
                                                          iconName:@"slider.horizontal.3"
                                                         iconColor:[UIColor systemOrangeColor]
                                                           detail:nil];

    CSSettingItem *chatAttachmentItem = [CSSettingItem itemWithTitle:@"附件布局"
                                                          iconName:@"square.grid.2x2"
                                                         iconColor:[UIColor systemTealColor]
                                                           detail:nil];

    CSSettingItem *inputTextItem = [CSSettingItem itemWithTitle:@"文本占位"
                                                      iconName:@"text.bubble.fill"
                                                     iconColor:[UIColor systemPinkColor]
                                                       detail:nil];
    
    // 添加聊天分组设置项
    CSSettingItem *chatGroupItem = [CSSettingItem itemWithTitle:@"聊天分组"
                                                     iconName:@"square.stack.3d.up.fill"
                                                    iconColor:[UIColor systemCyanColor]
                                                      detail:nil];

    // 添加信息时间设置项
    CSSettingItem *messageTimeItem = [CSSettingItem itemWithTitle:@"信息时间"
                                                        iconName:@"clock.fill"
                                                       iconColor:[UIColor systemBlueColor]
                                                         detail:nil];

    CSSettingItem *backgroundBlurItem = [CSSettingItem itemWithTitle:@"后台模糊"
                                                          iconName:@"eye.slash"
                                                         iconColor:[UIColor systemIndigoColor]
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
                                                                     chatAttachmentItem,
                                                                     inputTextItem,
                                                                     chatGroupItem,
                                                                     messageTimeItem,
                                                                     backgroundBlurItem]];
    
    // 功能增强组
    CSSettingItem *backgroundRunItem = [CSSettingItem itemWithTitle:@"后台运行" 
                                                         iconName:@"arrow.clockwise.icloud" 
                                                        iconColor:[UIColor systemPurpleColor]
                                                          detail:nil];
    
    CSSettingItem *gameCheatsItem = [CSSettingItem itemWithTitle:@"游戏辅助"
                                                      iconName:@"gamecontroller.fill"
                                                     iconColor:[UIColor systemGreenColor]
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

    CSSettingItem *aiReplyItem = [CSSettingItem itemWithTitle:@"人工智能" iconName:@"sparkles" iconColor:UIColor.systemPurpleColor detail:nil];
    CSSettingItem *scheduledItem = [CSSettingItem itemWithTitle:@"定时任务" iconName:@"calendar.badge.clock" iconColor:UIColor.systemOrangeColor detail:nil];
    CSSettingItem *imageStickerItem = [CSSettingItem itemWithTitle:@"表情功能" iconName:@"face.smiling" iconColor:UIColor.systemOrangeColor detail:nil];
    CSSettingItem *clownItem = [CSSettingItem itemWithTitle:@"小丑功能" iconName:@"theatermasks.fill" iconColor:UIColor.systemPurpleColor detail:nil];
    CSSettingItem *groupChatToolsItem = [CSSettingItem itemWithTitle:@"群聊功能" iconName:@"person.3.fill" iconColor:UIColor.systemGreenColor detail:nil];
    CSSettingItem *automationItem = [CSSettingItem itemWithTitle:@"自动功能" iconName:@"bolt.circle.fill" iconColor:UIColor.systemOrangeColor detail:nil];
    CSSettingSection *enhancementSection = [CSSettingSection sectionWithHeader:@"功能增强" 
                                                                      items:@[backgroundRunItem,
                                                                             gameCheatsItem,
                                                                             revokeItem,
                                                                             redEnvelopItem,
                                                                             receiveTransferItem,
                                                                             messageGestureItem,
                                                                             voiceForwardItem,
                                                                             repeatItem,
                                                                             aiReplyItem,
                                                                             scheduledItem,
                                                                             imageStickerItem,
                                                                             clownItem,
                                                                             groupChatToolsItem,
                                                                             automationItem]];
    
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
    // Resolve section titles before the first return frame; reloads must not
    // temporarily replace their measured heights with estimates.
    self.tableView.estimatedSectionHeaderHeight = 0;
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
    if ([item.title isEqualToString:@"版本信息"]) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
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
        if ([item.title isEqualToString:@"捉迷藏呀"]) {
            [CSCloseFriendManager.sharedManager presentSettingsFrom:self];
        }
        // 处理账号信息点击
        else if ([item.title isEqualToString:@"账号信息"]) {
            CSAccountDetailViewController *detailVC = [[CSAccountDetailViewController alloc] initWithStyle:UITableViewStyleInsetGrouped];
            [self.navigationController pushViewController:detailVC animated:YES];
        }
        else if ([item.title isEqualToString:@"防封检测"]) {
            [self.navigationController pushViewController:[[CSClientGuardSettingsViewController alloc]
                initWithStyle:UITableViewStyleInsetGrouped] animated:YES];
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
        else if ([item.title isEqualToString:@"后台模糊"]) {
            CSBackgroundBlurSettingsViewController *blurVC = [[CSBackgroundBlurSettingsViewController alloc] initWithStyle:UITableViewStyleInsetGrouped];
            [self.navigationController pushViewController:blurVC animated:YES];
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
        else if ([item.title isEqualToString:@"人工智能"]) {
            [self.navigationController pushViewController:[[CSAIReplySettingsViewController alloc] initWithStyle:UITableViewStyleInsetGrouped] animated:YES];
        }
        else if ([item.title isEqualToString:@"定时任务"]) {
            [self.navigationController pushViewController:[[CSScheduledTaskSettingsViewController alloc] initWithStyle:UITableViewStyleInsetGrouped] animated:YES];
        }
        else if ([item.title isEqualToString:@"表情功能"]) {
            [self.navigationController pushViewController:[[CSImageStickerSettingsViewController alloc] initWithStyle:UITableViewStyleInsetGrouped] animated:YES];
        }
        else if ([item.title isEqualToString:@"小丑功能"]) {
            [self.navigationController pushViewController:[[CSClownSettingsViewController alloc] initWithStyle:UITableViewStyleInsetGrouped] animated:YES];
        }
        else if ([item.title isEqualToString:@"群聊功能"]) {
            [self.navigationController pushViewController:[[CSGroupChatSettingsViewController alloc] initWithStyle:UITableViewStyleInsetGrouped] animated:YES];
        }
        else if ([item.title isEqualToString:@"自动功能"]) {
            [self.navigationController pushViewController:[[CSAutomationSettingsViewController alloc] initWithStyle:UITableViewStyleInsetGrouped] animated:YES];
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
        // 处理当前插件版本的更新说明
        else if ([item.title isEqualToString:@"版本信息"]) {
            CSReleaseNotesViewController *releaseNotesVC = [[CSReleaseNotesViewController alloc] initWithStyle:UITableViewStyleInsetGrouped];
            [self.navigationController pushViewController:releaseNotesVC animated:YES];
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
    cell.backgroundColor = [UIColor secondarySystemGroupedBackgroundColor];
    
    // 配置选中状态的背景色
    UIView *selectedBackgroundView = [[UIView alloc] init];
    selectedBackgroundView.backgroundColor = [UIColor tertiarySystemGroupedBackgroundColor];
    cell.selectedBackgroundView = selectedBackgroundView;
}

#pragma mark - 支持作者

- (void)supportAuthor {
    CSOpenNativeAuthorReward(self);
}

@end
