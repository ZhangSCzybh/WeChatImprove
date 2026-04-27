// NavigationTitleHooks.xm
// 用于修改导航栏标题为头像的Hook实现

#import "../Headers/WCHeaders.h"
#import "../Headers/CSUserInfoHelper.h"
#import "../Controllers/CSNavigationTitleSettingsViewController.h"
#import "../Controllers/CSSettingTableViewCell.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

// 常量定义
#import "../Headers/WCHeaders.h"

// 添加用户信息弹窗控制器类声明
@interface CSUserInfoPopoverController : UIViewController <UIPopoverPresentationControllerDelegate, UITableViewDelegate, UITableViewDataSource>
- (void)setupWithContact:(CContact *)contact;

@end

// 自定义头像视图类
@interface CSAvatarTitleView : UIView
@property (nonatomic, strong) UIView *otherAvatarContainer;      // 对方头像容器
@property (nonatomic, strong) UIView *selfAvatarContainer;       // 自己头像容器
@property (nonatomic, strong) UIView *separatorContainer;        // 分隔符容器
@property (nonatomic, strong) UIImageView *otherAvatarImageView; // 对方头像
@property (nonatomic, strong) UIImageView *selfAvatarImageView;  // 自己头像
@property (nonatomic, strong) UILabel *separatorLabel;           // 分隔符标签
@property (nonatomic, strong) UIImageView *separatorImageView;   // 新增：分隔符图片
@property (nonatomic, strong) UILabel *nicknameLabel;            // 添加对方网名标签
@property (nonatomic, copy) NSString *separatorText;             // 分隔符文本
@property (nonatomic, strong) UIImage *separatorImage;           // 新增：分隔符图片对象
@property (nonatomic, assign) CGFloat separatorSize;             // 分隔符大小
@property (nonatomic, assign) CGFloat separatorWidth;            // 分隔符容器宽度（自适应文本）
@property (nonatomic, assign) CGFloat avatarSpacing;             // 头像间距
@property (nonatomic, assign) CGFloat verticalOffset;            // 垂直偏移
@property (nonatomic, copy) NSString *otherAvatarUrl;
@property (nonatomic, copy) NSString *selfAvatarUrl;
@property (nonatomic, copy) NSString *otherNickname;             // 添加对方网名
@property (nonatomic, assign) CSNavigationAvatarMode avatarMode;  // 头像显示模式
@property (nonatomic, assign) CGFloat avatarSize;                // 头像大小
@property (nonatomic, assign) CGFloat avatarRadius;              // 头像圆角比例
@property (nonatomic, assign) BOOL showOtherNickname;            // 是否显示对方网名
@property (nonatomic, assign) CSNavigationNicknamePosition nicknamePosition; // 网名位置
@property (nonatomic, assign) CGFloat nicknameSize;              // 网名字体大小
@property (nonatomic, strong) CContact *otherContact;            // 添加otherContact属性
- (void)updateOtherAvatarWithUrl:(NSString *)url;
- (void)updateSelfAvatarWithUrl:(NSString *)url;
- (void)updateLayoutWithMode:(CSNavigationAvatarMode)mode;
- (void)updateSizeAndRadius:(CGFloat)size radius:(CGFloat)radius;
- (void)updateSeparatorText:(NSString *)text;
- (void)updateSeparatorImage:(UIImage *)image;                  // 新增：更新分隔符图片的方法
- (void)updateSeparatorSize:(CGFloat)size;
- (void)updateAvatarSpacing:(CGFloat)spacing;
- (void)updateVerticalOffset:(CGFloat)offset;
- (void)updateOtherAvatarWithContact:(CContact *)contact forGroup:(BOOL)isGroup;
- (void)updateOtherNickname:(NSString *)nickname;               // 添加更新对方网名的方法

@end

@implementation CSAvatarTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 从设置加载默认值
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        // 默认大小和圆角
        _avatarSize = [defaults objectForKey:kNavigationAvatarSizeKey] ? 
                     [defaults floatForKey:kNavigationAvatarSizeKey] : kDefaultAvatarSize;
        
        _avatarRadius = [defaults objectForKey:kNavigationAvatarRadiusKey] ? 
                       [defaults floatForKey:kNavigationAvatarRadiusKey] : kDefaultAvatarRadius;
        
        // 加载分隔符文本
        _separatorText = [defaults objectForKey:kNavigationSeparatorTextKey] ?
                       [defaults stringForKey:kNavigationSeparatorTextKey] : @"💗";
        
        // 加载分隔符大小
        _separatorSize = [defaults objectForKey:kNavigationSeparatorSizeKey] ?
                       [defaults floatForKey:kNavigationSeparatorSizeKey] : kDefaultSeparatorSize;
        
        // 加载头像间距
        _avatarSpacing = [defaults objectForKey:kNavigationAvatarSpacingKey] ?
                       [defaults floatForKey:kNavigationAvatarSpacingKey] : kDefaultAvatarSpacing;
                       
        // 加载垂直偏移
        _verticalOffset = [defaults objectForKey:kNavigationVerticalOffsetKey] ?
                       [defaults floatForKey:kNavigationVerticalOffsetKey] : kDefaultVerticalOffset;
        
        // 加载是否显示对方网名
        _showOtherNickname = [defaults objectForKey:kNavigationShowOtherNicknameKey] ?
                           [defaults boolForKey:kNavigationShowOtherNicknameKey] : NO;
                           
        // 加载网名位置设置
        NSInteger positionValue = [defaults objectForKey:kNavigationNicknamePositionKey] ? 
                                [defaults integerForKey:kNavigationNicknamePositionKey] : CSNavigationNicknamePositionRight; // 默认右侧
        _nicknamePosition = (CSNavigationNicknamePosition)positionValue;
        
        // 加载网名字体大小设置
        _nicknameSize = [defaults objectForKey:kNavigationNicknameSizeKey] ? 
                       [defaults floatForKey:kNavigationNicknameSizeKey] : kDefaultNicknameSize; // 默认16pt
        
        // 创建对方头像容器
        _otherAvatarContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _avatarSize, _avatarSize)];
        [self addSubview:_otherAvatarContainer];
        
        // 分隔符容器 - 宽度根据文本内容自适应
        // 计算分隔符文本所需宽度
        UIFont *separatorFont = [UIFont systemFontOfSize:_separatorSize];
        CGSize textSize = [_separatorText sizeWithAttributes:@{NSFontAttributeName: separatorFont}];
        _separatorWidth = ceil(textSize.width) + 4.0; // 添加少量padding
        
        _separatorContainer = [[UIView alloc] initWithFrame:CGRectMake(_avatarSize, 0, _separatorWidth, _avatarSize)];
        [self addSubview:_separatorContainer];
        
        // 创建自己头像容器
        _selfAvatarContainer = [[UIView alloc] initWithFrame:CGRectMake(_avatarSize * 2, 0, _avatarSize, _avatarSize)];
        [self addSubview:_selfAvatarContainer];
        
        // 创建对方头像视图
        _otherAvatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _avatarSize, _avatarSize)];
        _otherAvatarImageView.layer.cornerRadius = _avatarSize * _avatarRadius; // 0-0.5之间的半径比例
        _otherAvatarImageView.layer.masksToBounds = YES;
        _otherAvatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        [_otherAvatarContainer addSubview:_otherAvatarImageView];
        
        // 为对方头像添加点击手势
        UITapGestureRecognizer *otherAvatarTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleOtherAvatarTap:)];
        [_otherAvatarContainer addGestureRecognizer:otherAvatarTap];
        _otherAvatarContainer.userInteractionEnabled = YES;
        
        // 创建自己头像视图
        _selfAvatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _avatarSize, _avatarSize)];
        _selfAvatarImageView.layer.cornerRadius = _avatarSize * _avatarRadius;
        _selfAvatarImageView.layer.masksToBounds = YES;
        _selfAvatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        [_selfAvatarContainer addSubview:_selfAvatarImageView];
        
        // 为自己的头像添加点击手势
        UITapGestureRecognizer *selfAvatarTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSelfAvatarTap:)];
        [_selfAvatarContainer addGestureRecognizer:selfAvatarTap];
        _selfAvatarContainer.userInteractionEnabled = YES;
        
        // 创建分隔符标签
        _separatorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _separatorWidth, _avatarSize)];
        _separatorLabel.textAlignment = NSTextAlignmentCenter;
        _separatorLabel.font = [UIFont systemFontOfSize:_separatorSize];
        _separatorLabel.text = _separatorText;
        _separatorLabel.lineBreakMode = NSLineBreakByClipping; // 不显示省略号
        [_separatorContainer addSubview:_separatorLabel];
        
        // 创建分隔符图片视图
        _separatorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _separatorWidth, _avatarSize)];
        _separatorImageView.contentMode = UIViewContentModeScaleAspectFit;
        _separatorImageView.hidden = YES; // 默认隐藏图片
        [_separatorContainer addSubview:_separatorImageView];
        
        // 加载分隔符图片
        NSString *imagePath = [defaults objectForKey:kNavigationSeparatorImageKey];
        if (imagePath) {
            // 检查保存的路径是否存在
            if ([[NSFileManager defaultManager] fileExistsAtPath:imagePath]) {
                NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
                if (imageData) {
                    _separatorImage = [UIImage imageWithData:imageData];
                    _separatorImageView.image = _separatorImage;
                    
                    // 如果有图片，则显示图片而不是文本
                    if (_separatorImage) {
                        _separatorImageView.hidden = NO;
                        _separatorLabel.hidden = YES;
                    }
                }
            } else {
                // 尝试在固定位置查找
                // 资源存储路径：Preferences/WeChatImprove/separator_image.png（原WechatEnhance已更名为WeChatImprove）
                NSString *prefsPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
                prefsPath = [prefsPath stringByAppendingPathComponent:@"Preferences"];
                NSString *enhanceFolderPath = [prefsPath stringByAppendingPathComponent:@"WeChatImprove"];
                NSString *fixedPath = [enhanceFolderPath stringByAppendingPathComponent:@"separator_image.png"];
                
                if ([[NSFileManager defaultManager] fileExistsAtPath:fixedPath]) {
                    // 找到了固定位置的图片，更新保存的路径
                    [defaults setObject:fixedPath forKey:kNavigationSeparatorImageKey];
                    [defaults synchronize];
                    
                    // 加载图片
                    NSData *imageData = [NSData dataWithContentsOfFile:fixedPath];
                    if (imageData) {
                        _separatorImage = [UIImage imageWithData:imageData];
                        _separatorImageView.image = _separatorImage;
                        
                        if (_separatorImage) {
                            _separatorImageView.hidden = NO;
                            _separatorLabel.hidden = YES;
                        }
                    }
                } else {
                    // 没有找到图片，清除设置
                    [defaults removeObjectForKey:kNavigationSeparatorImageKey];
                    [defaults synchronize];
                }
            }
        } else {
            // 尝试加载固定位置的图片
            // 资源存储路径：Preferences/WeChatImprove/separator_image.png（原WechatEnhance已更名为WeChatImprove）
            NSString *prefsPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
            prefsPath = [prefsPath stringByAppendingPathComponent:@"Preferences"];
            NSString *enhanceFolderPath = [prefsPath stringByAppendingPathComponent:@"WeChatImprove"];
            NSString *fixedPath = [enhanceFolderPath stringByAppendingPathComponent:@"separator_image.png"];
            
            if ([[NSFileManager defaultManager] fileExistsAtPath:fixedPath]) {
                // 找到了固定位置的图片，更新保存的路径
                [defaults setObject:fixedPath forKey:kNavigationSeparatorImageKey];
                [defaults synchronize];
                
                // 加载图片
                NSData *imageData = [NSData dataWithContentsOfFile:fixedPath];
                if (imageData) {
                    _separatorImage = [UIImage imageWithData:imageData];
                    _separatorImageView.image = _separatorImage;
                    
                    if (_separatorImage) {
                        _separatorImageView.hidden = NO;
                        _separatorLabel.hidden = YES;
                    }
                }
            }
        }
        
        // 创建对方网名标签
        _nicknameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 20)];
        _nicknameLabel.textAlignment = NSTextAlignmentLeft;
        _nicknameLabel.font = [UIFont systemFontOfSize:_nicknameSize];
        _nicknameLabel.textColor = [UIColor labelColor];  // 直接使用系统动态颜色，iOS 15+
        _nicknameLabel.hidden = YES; // 默认隐藏
        _nicknameLabel.lineBreakMode = NSLineBreakByTruncatingTail; // 添加截断模式
        _nicknameLabel.numberOfLines = 1; // 设置为单行显示
        [self addSubview:_nicknameLabel];
        
        // 初始化时根据设置更新显示状态
        BOOL showSelfAvatar = [defaults objectForKey:kNavigationShowSelfAvatarKey] ? 
                            [defaults boolForKey:kNavigationShowSelfAvatarKey] : NO; // 默认关闭
        BOOL showOtherAvatar = [defaults objectForKey:kNavigationShowOtherAvatarKey] ? 
                             [defaults boolForKey:kNavigationShowOtherAvatarKey] : NO; // 默认关闭
        
        // 根据开关组合设置模式
        if (showSelfAvatar && showOtherAvatar) {
            _avatarMode = CSNavigationAvatarModeBoth;
        } else if (showSelfAvatar) {
            _avatarMode = CSNavigationAvatarModeSelf;
        } else if (showOtherAvatar) {
            _avatarMode = CSNavigationAvatarModeOther;
        } else {
            _avatarMode = CSNavigationAvatarModeNone;
        }
        
        [self updateLayoutWithMode:_avatarMode];
        
        // 添加设置变更通知监听
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(settingsChanged:) 
                                                     name:@"CSNavigationTitleSettingsChanged" 
                                                   object:nil];
    }
    return self;
}

- (void)updateOtherAvatarWithUrl:(NSString *)url {
    if (!url || [url isEqualToString:self.otherAvatarUrl]) {
        return;
    }
    
    self.otherAvatarUrl = url;
    
    // 加载对方头像
    if (url.length > 0) {
        // 设置默认头像作为占位图
        self.otherAvatarImageView.image = [UIImage imageNamed:@"DefaultProfileHead_phone"];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        config.timeoutIntervalForRequest = 10; // 设置10秒超时
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (data && !error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 确保URL没有改变
                    if ([url isEqualToString:self.otherAvatarUrl]) {
                        UIImage *image = [UIImage imageWithData:data];
                        if (image) {
                            self.otherAvatarImageView.image = image;
                        }
                    }
                });
            }
        }];
        [task resume];
    } else {
        self.otherAvatarImageView.image = [UIImage imageNamed:@"DefaultProfileHead_phone"];
    }
}

- (void)updateSelfAvatarWithUrl:(NSString *)url {
    if (!url || [url isEqualToString:self.selfAvatarUrl]) {
        return;
    }
    
    self.selfAvatarUrl = url;
    
    // 加载自己头像
    if (url.length > 0) {
        // 设置默认头像作为占位图
        self.selfAvatarImageView.image = [UIImage imageNamed:@"DefaultProfileHead_phone"];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        config.timeoutIntervalForRequest = 10; // 设置10秒超时
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (data && !error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 确保URL没有改变
                    if ([url isEqualToString:self.selfAvatarUrl]) {
                        UIImage *image = [UIImage imageWithData:data];
                        if (image) {
                            self.selfAvatarImageView.image = image;
                        }
                    }
                });
            }
        }];
        [task resume];
    } else {
        self.selfAvatarImageView.image = [UIImage imageNamed:@"DefaultProfileHead_phone"];
    }
}

- (void)updateLayoutWithMode:(CSNavigationAvatarMode)mode {
    self.avatarMode = mode;
    
    CGRect frame = self.frame;
    
    // 所有容器大小相同，保持一致
    CGFloat containerSize = self.avatarSize;
    
    // 应用垂直偏移 - 反转逻辑，让正值向上移动，负值向下移动
    CGFloat yOffset = -self.verticalOffset;
    
    // 是否显示对方网名
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL shouldShowNickname = [defaults boolForKey:kNavigationShowOtherNicknameKey];
    self.showOtherNickname = shouldShowNickname;
    
    // 加载网名位置设置
    NSInteger positionValue = [defaults objectForKey:kNavigationNicknamePositionKey] ? 
                             [defaults integerForKey:kNavigationNicknamePositionKey] : CSNavigationNicknamePositionRight;
    self.nicknamePosition = (CSNavigationNicknamePosition)positionValue;
    
    // 加载网名字体大小设置
    self.nicknameSize = [defaults objectForKey:kNavigationNicknameSizeKey] ? 
                        [defaults floatForKey:kNavigationNicknameSizeKey] : kDefaultNicknameSize;
    
    // 更新网名标签字体大小
    self.nicknameLabel.font = [UIFont systemFontOfSize:self.nicknameSize];
    
    // 先隐藏网名标签
    self.nicknameLabel.hidden = YES;
    
    switch (mode) {
        case CSNavigationAvatarModeOther: {
            // 只显示对方头像
            self.otherAvatarContainer.hidden = NO;
            self.selfAvatarContainer.hidden = YES;
            self.separatorContainer.hidden = YES;  // 隐藏分隔符
            
            if (shouldShowNickname && self.otherNickname.length > 0) {
                // 显示对方头像和网名
                
                // 计算标签尺寸 - 支持多行显示
                CGFloat maxWidth = 250.0f;
                CGFloat maxHeight = 40.0f; // 设置最大高度限制
                CGSize labelSize = [self.otherNickname boundingRectWithSize:CGSizeMake(maxWidth, maxHeight)
                                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                                 attributes:@{NSFontAttributeName: self.nicknameLabel.font}
                                                                    context:nil].size;
                
                // 确保标签至少有足够高度显示文本
                CGFloat labelHeight = MAX(24, labelSize.height); // 确保最小高度为24点
                CGFloat spacing = 8.0; // 头像和网名之间的间距
                
                // 根据网名位置设置布局
                switch (self.nicknamePosition) {
                    case CSNavigationNicknamePositionRight: {
                        // 右侧 - 原有布局
                        CGFloat totalWidth = containerSize + spacing + labelSize.width;
                        frame.size.width = totalWidth;
                        self.frame = frame;
                        
                        // 头像容器
                        self.otherAvatarContainer.frame = CGRectMake(0, yOffset, containerSize, containerSize);
                        
                        // 网名标签
                        self.nicknameLabel.hidden = NO;
                        self.nicknameLabel.textAlignment = NSTextAlignmentLeft;
                        self.nicknameLabel.frame = CGRectMake(containerSize + spacing, 
                                                            containerSize/2 - labelHeight/2 + yOffset, 
                                                            labelSize.width, 
                                                            labelHeight);
                        break;
                    }
                    
                    case CSNavigationNicknamePositionLeft: {
                        // 左侧
                        CGFloat totalWidth = labelSize.width + spacing + containerSize;
                        frame.size.width = totalWidth;
                        self.frame = frame;
                        
                        // 网名标签
                        self.nicknameLabel.hidden = NO;
                        self.nicknameLabel.textAlignment = NSTextAlignmentRight;
                        self.nicknameLabel.frame = CGRectMake(0, 
                                                            containerSize/2 - labelHeight/2 + yOffset, 
                                                            labelSize.width, 
                                                            labelHeight);
                        
                        // 头像容器
                        self.otherAvatarContainer.frame = CGRectMake(labelSize.width + spacing, yOffset, containerSize, containerSize);
                        break;
                    }
                    
                    default: {
                        // 默认使用右侧布局
                        CGFloat totalWidth = containerSize + spacing + labelSize.width;
                        frame.size.width = totalWidth;
                        self.frame = frame;
                        
                        // 头像容器
                        self.otherAvatarContainer.frame = CGRectMake(0, yOffset, containerSize, containerSize);
                        
                        // 网名标签
                        self.nicknameLabel.hidden = NO;
                        self.nicknameLabel.textAlignment = NSTextAlignmentLeft;
                        self.nicknameLabel.frame = CGRectMake(containerSize + spacing, 
                                                            containerSize/2 - labelHeight/2 + yOffset, 
                                                            labelSize.width, 
                                                            labelHeight);
                        break;
                    }
                }
            } else {
                // 仅显示对方头像，不显示网名
                frame.size.width = containerSize;
                self.frame = frame;
                self.otherAvatarContainer.frame = CGRectMake(0, yOffset, containerSize, containerSize);
            }
            break;
        }
            
        case CSNavigationAvatarModeSelf: {
            // 只显示自己头像
            self.otherAvatarContainer.hidden = YES;
            self.selfAvatarContainer.hidden = NO;
            self.separatorContainer.hidden = YES;  // 隐藏分隔符
            
            // 更新视图宽度
            frame.size.width = containerSize;
            self.frame = frame;
            
            // 更新自己头像容器位置（添加垂直偏移）
            self.selfAvatarContainer.frame = CGRectMake(0, yOffset, containerSize, containerSize);
            break;
        }
            
        case CSNavigationAvatarModeBoth:
        default: {
            // 显示两个头像
            self.otherAvatarContainer.hidden = NO;
            self.selfAvatarContainer.hidden = NO;
            self.separatorContainer.hidden = NO;  // 显示分隔符
            
            // 计算分隔符容器宽度（根据文本内容自适应）
            UIFont *separatorFont = [UIFont systemFontOfSize:self.separatorSize];
            CGSize textSize = [self.separatorText sizeWithAttributes:@{NSFontAttributeName: separatorFont}];
            self.separatorWidth = ceil(textSize.width) + 4.0; // 添加少量padding
            
            // 计算总宽度：头像 + 间距 + 分隔符容器 + 间距 + 头像
            CGFloat totalWidth = (containerSize * 2) + self.separatorWidth + (self.avatarSpacing * 2);
            
            // 更新视图宽度
            frame.size.width = totalWidth;
            self.frame = frame;
            
            // 1. 首先计算中心位置 - 整个视图的中点
            CGFloat centerX = totalWidth / 2.0;
            
            // 2. 分隔符容器位置（严格居中,并应用垂直偏移）
            self.separatorContainer.frame = CGRectMake(centerX - self.separatorWidth/2, yOffset, self.separatorWidth, containerSize);
            
            // 更新分隔符标签frame
            self.separatorLabel.frame = CGRectMake(0, 0, self.separatorWidth, containerSize);
            
            // 3. 对方头像容器位置（左侧,并应用垂直偏移）
            self.otherAvatarContainer.frame = CGRectMake(centerX - self.separatorWidth/2 - self.avatarSpacing - containerSize, yOffset, containerSize, containerSize);
            
            // 4. 自己头像容器位置（右侧,并应用垂直偏移）
            self.selfAvatarContainer.frame = CGRectMake(centerX + self.separatorWidth/2 + self.avatarSpacing, yOffset, containerSize, containerSize);
            break;
        }
    }
}

- (void)updateSizeAndRadius:(CGFloat)size radius:(CGFloat)radius {
    self.avatarSize = size;
    self.avatarRadius = radius;
    
    // 更新对方头像
    self.otherAvatarImageView.frame = CGRectMake(0, 0, size, size);
    self.otherAvatarImageView.layer.cornerRadius = size * radius;
    
    // 更新自己头像
    self.selfAvatarImageView.frame = CGRectMake(0, 0, size, size);
    self.selfAvatarImageView.layer.cornerRadius = size * radius;
    
    // 重新计算分隔符宽度
    UIFont *separatorFont = [UIFont systemFontOfSize:self.separatorSize];
    CGSize textSize = [self.separatorText sizeWithAttributes:@{NSFontAttributeName: separatorFont}];
    self.separatorWidth = ceil(textSize.width) + 4.0;
    
    // 更新分隔符标签
    self.separatorLabel.frame = CGRectMake(0, 0, self.separatorWidth, size);
    
    // 更新整体布局
    [self updateLayoutWithMode:self.avatarMode];
}

- (void)updateSeparatorText:(NSString *)text {
    self.separatorText = text;
    
    // 设置字体大小
    self.separatorLabel.font = [UIFont systemFontOfSize:self.separatorSize];
    
    // 直接设置文本，让系统处理显示
    self.separatorLabel.text = text;
    
    // 重新计算分隔符宽度
    UIFont *separatorFont = [UIFont systemFontOfSize:self.separatorSize];
    CGSize textSize = [text sizeWithAttributes:@{NSFontAttributeName: separatorFont}];
    self.separatorWidth = ceil(textSize.width) + 4.0;
    
    // 更新分隔符标签frame
    self.separatorLabel.frame = CGRectMake(0, 0, self.separatorWidth, self.avatarSize);
    
    // 更新整体布局
    [self updateLayoutWithMode:self.avatarMode];
    
    // 如果分隔符图片存在，则优先显示图片而不是文本
    if (self.separatorImage) {
        self.separatorLabel.hidden = YES;
        self.separatorImageView.hidden = NO;
    } else {
        self.separatorLabel.hidden = NO;
        self.separatorImageView.hidden = YES;
    }
}

// 添加更新分隔符图片的方法
- (void)updateSeparatorImage:(UIImage *)image {
    self.separatorImage = image;
    
    if (image) {
        // 设置图片并显示
        self.separatorImageView.image = image;
        self.separatorImageView.hidden = NO;
        self.separatorLabel.hidden = YES; // 隐藏文本
    } else {
        // 恢复显示文本
        self.separatorImageView.hidden = YES;
        self.separatorLabel.hidden = NO;
    }
}

- (void)updateSeparatorSize:(CGFloat)size {
    self.separatorSize = size;
    
    // 更新字体大小
    self.separatorLabel.font = [UIFont systemFontOfSize:size];
    
    // 重新计算分隔符宽度
    UIFont *separatorFont = [UIFont systemFontOfSize:size];
    CGSize textSize = [self.separatorText sizeWithAttributes:@{NSFontAttributeName: separatorFont}];
    self.separatorWidth = ceil(textSize.width) + 4.0;
    
    // 更新分隔符标签frame
    self.separatorLabel.frame = CGRectMake(0, 0, self.separatorWidth, self.avatarSize);
    
    // 更新整体布局
    [self updateLayoutWithMode:self.avatarMode];
}

- (void)updateAvatarSpacing:(CGFloat)spacing {
    self.avatarSpacing = spacing;
}

- (void)updateVerticalOffset:(CGFloat)offset {
    self.verticalOffset = offset;
    
    // 更新布局以应用新的垂直偏移
    [self updateLayoutWithMode:self.avatarMode];
}

- (void)updateOtherNickname:(NSString *)nickname {
    if (!nickname) return;
    
    // 检查是否应该显示备注名而非网名
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL showRemarkName = [defaults objectForKey:kNavigationShowRemarkNameKey] ? 
                          [defaults boolForKey:kNavigationShowRemarkNameKey] : NO;
    
    // 如果启用了显示备注名，并且有备注名可用，则使用备注名
    if (showRemarkName && self.otherContact) {
        NSString *remarkName = nil;
        
        // 动态检查哪个备注名属性可用
        if ([self.otherContact respondsToSelector:@selector(m_nsRemark)]) {
            remarkName = [self.otherContact valueForKey:@"m_nsRemark"];
        } else if ([self.otherContact respondsToSelector:@selector(m_nsRemarkName)]) {
            remarkName = [self.otherContact valueForKey:@"m_nsRemarkName"];
        }
        
        // 只有当备注名存在且非空时才使用它
        if (remarkName && remarkName.length > 0) {
            self.otherNickname = remarkName;
        } else {
            // 没有有效的备注名，使用网名
            self.otherNickname = nickname;
        }
    } else {
        // 不显示备注名或没有备注名时，使用网名
        self.otherNickname = nickname;
    }
    
    self.nicknameLabel.text = self.otherNickname;
    
    // 检查是否需要更新布局
    if (self.showOtherNickname && self.avatarMode == CSNavigationAvatarModeOther) {
        [self updateLayoutWithMode:self.avatarMode];
    }
}

// 处理对方头像点击事件
- (void)handleOtherAvatarTap:(UITapGestureRecognizer *)recognizer {
    // 检查是否启用了点击头像显示信息功能
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL showPopoverWhenTapAvatar = [defaults objectForKey:kNavigationShowPopoverWhenTapAvatarKey] ? 
                                 [defaults boolForKey:kNavigationShowPopoverWhenTapAvatarKey] : YES; // 默认开启
    
    // 如果功能已关闭，直接返回
    if (!showPopoverWhenTapAvatar) {
        return;
    }
    
    // 添加震动反馈
    [self playHapticFeedback];
    
    // 获取当前应用程序的keyWindow
    UIWindow *keyWindow = nil;
    
    // iOS 13及以上版本
    if (@available(iOS 13.0, *)) {
        NSSet<UIScene *> *connectedScenes = [UIApplication sharedApplication].connectedScenes;
        for (UIScene *scene in connectedScenes) {
            if (scene.activationState == UISceneActivationStateForegroundActive && [scene isKindOfClass:[UIWindowScene class]]) {
                UIWindowScene *windowScene = (UIWindowScene *)scene;
                NSArray<UIWindow *> *windows = windowScene.windows;
                for (UIWindow *window in windows) {
                    if (window.isKeyWindow) {
                        keyWindow = window;
                        break;
                    }
                }
                if (keyWindow) break;
            }
        }
    } else {
        // iOS 13以下版本
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wdeprecated-declarations"
        keyWindow = [UIApplication sharedApplication].keyWindow;
        #pragma clang diagnostic pop
    }
    
    if (!keyWindow) return;
    
    // 获取当前的视图控制器
    UIViewController *rootVC = keyWindow.rootViewController;
    UIViewController *currentVC = [self findTopViewControllerFrom:rootVC];
    
    if ([currentVC isKindOfClass:%c(BaseMsgContentViewController)]) {
        BaseMsgContentViewController *msgVC = (BaseMsgContentViewController *)currentVC;
        CContact *contact = [msgVC GetContact];
        if (contact) {
            // 创建并显示用户信息弹窗
            CSUserInfoPopoverController *popoverVC = [[CSUserInfoPopoverController alloc] init];
            popoverVC.modalPresentationStyle = UIModalPresentationPopover;
            popoverVC.preferredContentSize = CGSizeMake(280, 400);
            
            // 设置联系人信息
            [popoverVC setupWithContact:contact];
            
            // 配置弹窗
            UIPopoverPresentationController *popoverPresentation = popoverVC.popoverPresentationController;
            popoverPresentation.sourceView = self.otherAvatarContainer;
            popoverPresentation.sourceRect = self.otherAvatarContainer.bounds;
            popoverPresentation.permittedArrowDirections = UIPopoverArrowDirectionAny;
            popoverPresentation.delegate = popoverVC;
            
            // 显示弹窗
            [currentVC presentViewController:popoverVC animated:YES completion:nil];
        }
    }
}

// 添加处理自己头像点击事件的方法
- (void)handleSelfAvatarTap:(UITapGestureRecognizer *)recognizer {
    // 检查是否启用了点击头像显示信息功能
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL showPopoverWhenTapAvatar = [defaults objectForKey:kNavigationShowPopoverWhenTapAvatarKey] ? 
                                 [defaults boolForKey:kNavigationShowPopoverWhenTapAvatarKey] : YES; // 默认开启
    
    // 如果功能已关闭，直接返回
    if (!showPopoverWhenTapAvatar) {
        return;
    }
    
    // 添加震动反馈
    [self playHapticFeedback];
    
    // 获取当前应用程序的keyWindow
    UIWindow *keyWindow = nil;
    
    // iOS 13及以上版本
    if (@available(iOS 13.0, *)) {
        NSSet<UIScene *> *connectedScenes = [UIApplication sharedApplication].connectedScenes;
        for (UIScene *scene in connectedScenes) {
            if (scene.activationState == UISceneActivationStateForegroundActive && [scene isKindOfClass:[UIWindowScene class]]) {
                UIWindowScene *windowScene = (UIWindowScene *)scene;
                NSArray<UIWindow *> *windows = windowScene.windows;
                for (UIWindow *window in windows) {
                    if (window.isKeyWindow) {
                        keyWindow = window;
                        break;
                    }
                }
                if (keyWindow) break;
            }
        }
    } else {
        // iOS 13以下版本
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wdeprecated-declarations"
        keyWindow = [UIApplication sharedApplication].keyWindow;
        #pragma clang diagnostic pop
    }
    
    if (!keyWindow) return;
    
    // 获取当前的视图控制器
    UIViewController *rootVC = keyWindow.rootViewController;
    UIViewController *currentVC = [self findTopViewControllerFrom:rootVC];
    
    // 获取自己的联系人信息
    CContact *selfContact = [[%c(CContactMgr) alloc] getSelfContact];
    if (selfContact) {
        // 创建并显示用户信息弹窗
        CSUserInfoPopoverController *popoverVC = [[CSUserInfoPopoverController alloc] init];
        popoverVC.modalPresentationStyle = UIModalPresentationPopover;
        popoverVC.preferredContentSize = CGSizeMake(280, 400);
        
        // 设置联系人信息
        [popoverVC setupWithContact:selfContact];
        
        // 配置弹窗
        UIPopoverPresentationController *popoverPresentation = popoverVC.popoverPresentationController;
        popoverPresentation.sourceView = self.selfAvatarContainer;
        popoverPresentation.sourceRect = self.selfAvatarContainer.bounds;
        popoverPresentation.permittedArrowDirections = UIPopoverArrowDirectionAny;
        popoverPresentation.delegate = popoverVC;
        
        // 显示弹窗
        [currentVC presentViewController:popoverVC animated:YES completion:nil];
    }
}

// 递归查找顶层视图控制器
- (UIViewController *)findTopViewControllerFrom:(UIViewController *)viewController {
    if (viewController.presentedViewController) {
        return [self findTopViewControllerFrom:viewController.presentedViewController];
    }
    
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navController = (UINavigationController *)viewController;
        return [self findTopViewControllerFrom:navController.visibleViewController];
    }
    
    if ([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabController = (UITabBarController *)viewController;
        return [self findTopViewControllerFrom:tabController.selectedViewController];
    }
    
    return viewController;
}

- (void)updateOtherAvatarWithContact:(CContact *)contact forGroup:(BOOL)isGroup {
    if (!contact) return;
    
    // 保存联系人信息以便后续使用
    self.otherContact = contact;
    
    if (!isGroup) {
        // 个人或公众号头像
        [self updateOtherAvatarWithUrl:contact.m_nsHeadImgUrl];
        
        // 直接调用updateOtherNickname方法，它会处理备注名的显示逻辑
        [self updateOtherNickname:contact.m_nsNickName];
    } else {
        // 群聊头像
        [self updateOtherAvatarWithUrl:contact.m_nsHeadImgUrl];
        [self updateOtherNickname:contact.m_nsNickName];
    }
}

// 处理设置变更通知
- (void)settingsChanged:(NSNotification *)notification {
    // 从UserDefaults重新加载所有设置
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // 获取最新的头像显示设置
    BOOL showSelfAvatar = [defaults boolForKey:kNavigationShowSelfAvatarKey];
    BOOL showOtherAvatar = [defaults boolForKey:kNavigationShowOtherAvatarKey];
    BOOL showOtherNickname = [defaults boolForKey:kNavigationShowOtherNicknameKey];
    
    // 更新显示对方网名的设置
    self.showOtherNickname = showOtherNickname;
    
    // 更新网名位置设置
    NSInteger positionValue = [defaults objectForKey:kNavigationNicknamePositionKey] ? 
                             [defaults integerForKey:kNavigationNicknamePositionKey] : CSNavigationNicknamePositionRight;
    self.nicknamePosition = (CSNavigationNicknamePosition)positionValue;
    
    // 更新网名字体大小设置
    CGFloat nicknameSize = [defaults objectForKey:kNavigationNicknameSizeKey] ? 
                          [defaults floatForKey:kNavigationNicknameSizeKey] : kDefaultNicknameSize;
    self.nicknameSize = nicknameSize;
    self.nicknameLabel.font = [UIFont systemFontOfSize:nicknameSize];
    
    // 更新头像大小和圆角
    CGFloat newSize = [defaults floatForKey:kNavigationAvatarSizeKey];
    CGFloat newRadius = [defaults floatForKey:kNavigationAvatarRadiusKey];
    [self updateSizeAndRadius:newSize radius:newRadius];
    
    // 更新分隔符大小
    CGFloat newSeparatorSize = [defaults objectForKey:kNavigationSeparatorSizeKey] ?
                            [defaults floatForKey:kNavigationSeparatorSizeKey] : kDefaultSeparatorSize;
    [self updateSeparatorSize:newSeparatorSize];
    
    // 更新头像间距
    CGFloat newAvatarSpacing = [defaults objectForKey:kNavigationAvatarSpacingKey] ?
                            [defaults floatForKey:kNavigationAvatarSpacingKey] : kDefaultAvatarSpacing;
    [self updateAvatarSpacing:newAvatarSpacing];
    
    // 更新垂直偏移
    CGFloat newVerticalOffset = [defaults objectForKey:kNavigationVerticalOffsetKey] ?
                              [defaults floatForKey:kNavigationVerticalOffsetKey] : kDefaultVerticalOffset;
    [self updateVerticalOffset:newVerticalOffset];
    
    // 更新分隔符文本
    NSString *newSeparator = [defaults objectForKey:kNavigationSeparatorTextKey] ?
                            [defaults stringForKey:kNavigationSeparatorTextKey] : @"💗";
    [self updateSeparatorText:newSeparator];
    
    // 检查并更新分隔符图片
    NSString *imagePath = [defaults objectForKey:kNavigationSeparatorImageKey];
    if (imagePath) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:imagePath]) {
            NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
            if (imageData) {
                UIImage *image = [UIImage imageWithData:imageData];
                [self updateSeparatorImage:image];
            } else {
                [self updateSeparatorImage:nil]; // 无法加载图片，使用文本
            }
        } else {
            // 尝试在固定位置查找
            // 资源存储路径：Preferences/WeChatImprove/separator_image.png（原WechatEnhance已更名为WeChatImprove）
            NSString *prefsPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
            prefsPath = [prefsPath stringByAppendingPathComponent:@"Preferences"];
            NSString *enhanceFolderPath = [prefsPath stringByAppendingPathComponent:@"WeChatImprove"];
            NSString *fixedPath = [enhanceFolderPath stringByAppendingPathComponent:@"separator_image.png"];
            
            if ([[NSFileManager defaultManager] fileExistsAtPath:fixedPath]) {
                // 找到了固定位置的图片，更新保存的路径
                [defaults setObject:fixedPath forKey:kNavigationSeparatorImageKey];
                [defaults synchronize];
                
                // 加载图片
                NSData *imageData = [NSData dataWithContentsOfFile:fixedPath];
                if (imageData) {
                    UIImage *image = [UIImage imageWithData:imageData];
                    [self updateSeparatorImage:image];
                } else {
                    [self updateSeparatorImage:nil]; // 无法加载图片，使用文本
                }
            } else {
                // 路径存在但文件不存在，清除设置
                [defaults removeObjectForKey:kNavigationSeparatorImageKey];
                [defaults synchronize];
                [self updateSeparatorImage:nil]; // 文件不存在，使用文本
            }
        }
    } else {
        // 尝试加载固定位置的图片
        // 资源存储路径：Preferences/WeChatImprove/separator_image.png（原WechatEnhance已更名为WeChatImprove）
        NSString *prefsPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
        prefsPath = [prefsPath stringByAppendingPathComponent:@"Preferences"];
        NSString *enhanceFolderPath = [prefsPath stringByAppendingPathComponent:@"WeChatImprove"];
        NSString *fixedPath = [enhanceFolderPath stringByAppendingPathComponent:@"separator_image.png"];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:fixedPath]) {
            // 找到了固定位置的图片，更新保存的路径
            [defaults setObject:fixedPath forKey:kNavigationSeparatorImageKey];
            [defaults synchronize];
            
            // 加载图片
            NSData *imageData = [NSData dataWithContentsOfFile:fixedPath];
            if (imageData) {
                UIImage *image = [UIImage imageWithData:imageData];
                [self updateSeparatorImage:image];
            } else {
                [self updateSeparatorImage:nil]; // 无法加载图片，使用文本
            }
        } else {
            [self updateSeparatorImage:nil]; // 没有图片路径，使用文本
        }
    }
    
    // 根据开关组合设置模式
    CSNavigationAvatarMode newMode;
    if (showSelfAvatar && showOtherAvatar && !showOtherNickname) {
        newMode = CSNavigationAvatarModeBoth;
    } else if (showSelfAvatar && !showOtherNickname) {
        newMode = CSNavigationAvatarModeSelf;
    } else if (showOtherAvatar) {
        newMode = CSNavigationAvatarModeOther;
    } else {
        newMode = CSNavigationAvatarModeNone;
    }
    
    // 更新布局
    [self updateLayoutWithMode:newMode];
}

// 在dealloc中移除通知观察者
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// 添加震动反馈方法
- (void)playHapticFeedback {
    // 根据iOS版本选择合适的震动类型
    if (@available(iOS 10.0, *)) {
        // 选择较轻的震动效果，提供更好的用户体验
        UINotificationFeedbackGenerator *generator = [[UINotificationFeedbackGenerator alloc] init];
        [generator prepare];
        [generator notificationOccurred:UINotificationFeedbackTypeSuccess];
    }
}


@end

// 声明BaseMsgContentViewController的分类
@interface BaseMsgContentViewController (CSNavigationTitle)
- (void)updateNavigationAvatarWithContact:(CContact *)contact;

@end

// Hook BaseMsgContentViewController 类
%hook BaseMsgContentViewController

- (void)viewDidLoad {
    %orig;
    
    // 检查是否启用了头像显示
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL showAvatar = [defaults objectForKey:kNavigationShowAvatarKey] ? 
                      [defaults boolForKey:kNavigationShowAvatarKey] : NO; // 默认关闭
    
    if (!showAvatar) {
        return; // 如果禁用了头像显示，则不进行任何操作
    }

    // 获取当前联系人
    CContact *contact = [self GetContact];
    if (!contact) {
        return; // 如果无法获取联系人信息，则退出
    }
    
    // 获取聊天ID，用于判断聊天类型
    NSString *chatID = contact.m_nsUsrName;
    
    // 判断聊天类型并检查相应设置
    BOOL showInCurrentScene = YES;
    
    if ([chatID hasPrefix:@"gh_"]) {
        // 公众号 - 判断是否显示
        BOOL shouldShowInOfficial = [defaults objectForKey:kNavigationShowInOfficialKey] ? 
                                   [defaults boolForKey:kNavigationShowInOfficialKey] : NO; // 默认关闭
        showInCurrentScene = shouldShowInOfficial;
    } else if ([chatID hasSuffix:@"@chatroom"]) {
        // 群聊 - 判断是否显示
        BOOL shouldShowInGroup = [defaults objectForKey:kNavigationShowInGroupKey] ? 
                                [defaults boolForKey:kNavigationShowInGroupKey] : NO; // 默认关闭
        showInCurrentScene = shouldShowInGroup;
    } else {
        // 私聊 - 判断是否显示
        BOOL shouldShowInPrivate = [defaults objectForKey:kNavigationShowInPrivateKey] ? 
                                  [defaults boolForKey:kNavigationShowInPrivateKey] : NO; // 默认关闭
        showInCurrentScene = shouldShowInPrivate;
    }
    
    // 如果当前场景不显示头像，则直接返回
    if (!showInCurrentScene) {
        return;
    }
    
    // 获取头像大小和圆角
    CGFloat avatarSize = [defaults objectForKey:kNavigationAvatarSizeKey] ? 
                        [defaults floatForKey:kNavigationAvatarSizeKey] : kDefaultAvatarSize;
    
    CGFloat avatarRadius = [defaults objectForKey:kNavigationAvatarRadiusKey] ? 
                          [defaults floatForKey:kNavigationAvatarRadiusKey] : kDefaultAvatarRadius;
    
    // 创建自定义头像标题视图
    CGFloat totalWidth = avatarSize * 3; // 三个等宽的容器
    CSAvatarTitleView *avatarTitleView = [[CSAvatarTitleView alloc] initWithFrame:CGRectMake(0, 0, totalWidth, avatarSize)];
    [avatarTitleView updateSizeAndRadius:avatarSize radius:avatarRadius];
    self.navigationItem.titleView = avatarTitleView;
    
    // 获取显示模式（新版本）
    BOOL showSelf = [defaults objectForKey:kNavigationShowSelfAvatarKey] ? 
                   [defaults boolForKey:kNavigationShowSelfAvatarKey] : NO; // 默认关闭
    BOOL showOther = [defaults objectForKey:kNavigationShowOtherAvatarKey] ? 
                    [defaults boolForKey:kNavigationShowOtherAvatarKey] : NO; // 默认关闭
    
    // 确定实际模式
    CSNavigationAvatarMode mode;
    if (showSelf && showOther) {
        mode = CSNavigationAvatarModeBoth;
    } else if (showSelf) {
        mode = CSNavigationAvatarModeSelf;
    } else {
        mode = CSNavigationAvatarModeOther;
    }
    
    // 更新布局
    [avatarTitleView updateLayoutWithMode:mode];
    
    // 获取并设置头像URL
    [self updateNavigationAvatarWithContact:contact];
}

%new
- (void)updateNavigationAvatarWithContact:(CContact *)contact {
    if (!contact) return;
    
    // 获取自定义标题视图
    CSAvatarTitleView *avatarTitleView = (CSAvatarTitleView *)self.navigationItem.titleView;
    if (!avatarTitleView || ![avatarTitleView isKindOfClass:[CSAvatarTitleView class]]) return;
    
    // 获取头像大小和圆角设置
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    CGFloat avatarSize = [defaults objectForKey:kNavigationAvatarSizeKey] ? 
                        [defaults floatForKey:kNavigationAvatarSizeKey] : kDefaultAvatarSize;
    
    CGFloat avatarRadius = [defaults objectForKey:kNavigationAvatarRadiusKey] ? 
                          [defaults floatForKey:kNavigationAvatarRadiusKey] : kDefaultAvatarRadius;
    
    // 获取分隔符文本
    NSString *separatorText = [defaults objectForKey:kNavigationSeparatorTextKey] ?
                            [defaults stringForKey:kNavigationSeparatorTextKey] : @"💗";
    
    // 获取分隔符大小
    CGFloat separatorSize = [defaults objectForKey:kNavigationSeparatorSizeKey] ?
                          [defaults floatForKey:kNavigationSeparatorSizeKey] : kDefaultSeparatorSize;
                          
    // 获取头像间距
    CGFloat avatarSpacing = [defaults objectForKey:kNavigationAvatarSpacingKey] ?
                          [defaults floatForKey:kNavigationAvatarSpacingKey] : kDefaultAvatarSpacing;
                          
    // 获取垂直偏移
    CGFloat verticalOffset = [defaults objectForKey:kNavigationVerticalOffsetKey] ?
                           [defaults floatForKey:kNavigationVerticalOffsetKey] : kDefaultVerticalOffset;
    
    // 确保更新头像大小和圆角 - 这对所有聊天类型都应该应用
    [avatarTitleView updateSizeAndRadius:avatarSize radius:avatarRadius];
    
    // 更新分隔符大小
    [avatarTitleView updateSeparatorSize:separatorSize];
    
    // 更新头像间距
    [avatarTitleView updateAvatarSpacing:avatarSpacing];
    
    // 更新垂直偏移
    [avatarTitleView updateVerticalOffset:verticalOffset];
    
    // 更新分隔符文本
    [avatarTitleView updateSeparatorText:separatorText];
    
    // 获取并设置自己的头像
    CContact *selfContact = [[%c(CContactMgr) alloc] getSelfContact];
    if (selfContact) {
        [avatarTitleView updateSelfAvatarWithUrl:selfContact.m_nsHeadImgUrl];
    }
    
    // 设置对方的头像
    NSString *chatID = contact.m_nsUsrName;
    BOOL isGroup = [chatID hasSuffix:@"@chatroom"];
    
    if (isGroup) {
        // 群聊头像
        [avatarTitleView updateOtherAvatarWithContact:contact forGroup:YES];
    } else {
        // 个人或公众号头像
        [avatarTitleView updateOtherAvatarWithContact:contact forGroup:NO];
    }
}

// 在聊天界面即将出现时更新头像
- (void)viewWillAppear:(_Bool)animated {
    %orig;
    
    // 检查是否启用了头像显示
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL showAvatar = [defaults objectForKey:kNavigationShowAvatarKey] ? 
                      [defaults boolForKey:kNavigationShowAvatarKey] : NO; // 默认关闭
    
    if (!showAvatar) {
        // 如果禁用了头像显示，则恢复原始标题
        CSAvatarTitleView *avatarTitleView = (CSAvatarTitleView *)self.navigationItem.titleView;
        if ([avatarTitleView isKindOfClass:[CSAvatarTitleView class]]) {
            self.navigationItem.titleView = nil;
            
            // 恢复原始标题（如果有）
            CContact *contact = [self GetContact];
            if (contact) {
                self.title = contact.m_nsNickName;
            }
        }
        return;
    }
    
    // 获取当前联系人
    CContact *contact = [self GetContact];
    if (!contact) {
        return;
    }
    
    // 获取聊天ID，用于判断聊天类型
    NSString *chatID = contact.m_nsUsrName;
    
    // 判断聊天类型并检查相应设置
    BOOL showInCurrentScene = YES;
    
    if ([chatID hasPrefix:@"gh_"]) {
        // 公众号 - 判断是否显示
        BOOL shouldShowInOfficial = [defaults objectForKey:kNavigationShowInOfficialKey] ? 
                                   [defaults boolForKey:kNavigationShowInOfficialKey] : NO; // 默认关闭
        showInCurrentScene = shouldShowInOfficial;
    } else if ([chatID hasSuffix:@"@chatroom"]) {
        // 群聊 - 判断是否显示
        BOOL shouldShowInGroup = [defaults objectForKey:kNavigationShowInGroupKey] ? 
                                [defaults boolForKey:kNavigationShowInGroupKey] : NO; // 默认关闭
        showInCurrentScene = shouldShowInGroup;
    } else {
        // 私聊 - 判断是否显示
        BOOL shouldShowInPrivate = [defaults objectForKey:kNavigationShowInPrivateKey] ? 
                                  [defaults boolForKey:kNavigationShowInPrivateKey] : NO; // 默认关闭
        showInCurrentScene = shouldShowInPrivate;
    }
    
    // 如果当前场景不显示头像，则恢复原始标题
    if (!showInCurrentScene) {
        CSAvatarTitleView *avatarTitleView = (CSAvatarTitleView *)self.navigationItem.titleView;
        if ([avatarTitleView isKindOfClass:[CSAvatarTitleView class]]) {
            self.navigationItem.titleView = nil;
            self.title = contact.m_nsNickName;
        }
        return;
    }
    
    // 如果启用了头像显示但标题视图不是CSAvatarTitleView，则创建它
    if (![self.navigationItem.titleView isKindOfClass:[CSAvatarTitleView class]]) {
        // 获取头像大小和圆角
        CGFloat avatarSize = [defaults objectForKey:kNavigationAvatarSizeKey] ? 
                            [defaults floatForKey:kNavigationAvatarSizeKey] : kDefaultAvatarSize;
        
        CGFloat avatarRadius = [defaults objectForKey:kNavigationAvatarRadiusKey] ? 
                              [defaults floatForKey:kNavigationAvatarRadiusKey] : kDefaultAvatarRadius;
        
        CGFloat totalWidth = avatarSize * 3; // 三个等宽的容器
        CSAvatarTitleView *avatarTitleView = [[CSAvatarTitleView alloc] initWithFrame:CGRectMake(0, 0, totalWidth, avatarSize)];
        [avatarTitleView updateSizeAndRadius:avatarSize radius:avatarRadius];
        self.navigationItem.titleView = avatarTitleView;
    }
    
    // 更新头像
    [self updateNavigationAvatarWithContact:contact];
}

%end

// 主入口函数
%ctor {
} 

// 重新实现用户信息弹窗控制器类
@implementation CSUserInfoPopoverController {
    UITableView *_tableView;
    CContact *_contact;
    NSMutableArray<CSSettingSection *> *_sections;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置视图背景色
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    
    // 创建数据源数组
    _sections = [NSMutableArray array];
    
    // 创建表格视图
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleInsetGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor systemGroupedBackgroundColor];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.estimatedRowHeight = 44.0; // 设置估计行高
    _tableView.rowHeight = UITableViewAutomaticDimension; // 启用自动行高
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone; // 移除分割线
    _tableView.directionalLayoutMargins = NSDirectionalEdgeInsetsMake(8, 8, 8, 8);
    _tableView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0);
    
    // 添加表头和表尾视图，提高美观度
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 20)];
    headerView.backgroundColor = [UIColor clearColor];
    _tableView.tableHeaderView = headerView;
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    footerView.backgroundColor = [UIColor clearColor];
    
    // 创建底部提示文本
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.text = @"点击信息项复制到剪贴板";
    tipLabel.font = [UIFont systemFontOfSize:13];
    tipLabel.textColor = [UIColor tertiaryLabelColor];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [footerView addSubview:tipLabel];
    
    [NSLayoutConstraint activateConstraints:@[
        [tipLabel.centerXAnchor constraintEqualToAnchor:footerView.centerXAnchor],
        [tipLabel.topAnchor constraintEqualToAnchor:footerView.topAnchor constant:16],
        [tipLabel.leadingAnchor constraintEqualToAnchor:footerView.leadingAnchor constant:16],
        [tipLabel.trailingAnchor constraintEqualToAnchor:footerView.trailingAnchor constant:-16]
    ]];
    
    _tableView.tableFooterView = footerView;
    
    [self.view addSubview:_tableView];
    
    // 如果是iPhone且是模态显示，添加关闭按钮
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone && self.presentingViewController) {
        UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemClose 
                                                                                target:self 
                                                                                action:@selector(dismissView)];
        self.navigationItem.rightBarButtonItem = closeButton;
    }
    
    // 注册自定义单元格
    [CSSettingTableViewCell registerToTableView:_tableView];
    
    // 如果联系人已设置，则立即更新UI
    if (_contact) {
        [self updateUIWithContact:_contact];
    }
}

// 添加关闭弹窗方法
- (void)dismissView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setupWithContact:(CContact *)contact {
    _contact = contact;
    
    // 如果视图已加载，则更新UI
    if (_tableView) {
        [self updateUIWithContact:contact];
    }
}

- (void)updateUIWithContact:(CContact *)contact {
    if (!contact) return;
    
    // 清空现有数据
    [_sections removeAllObjects];
    
    // 添加头像部分
    [self addAvatarSection:contact];
    
    // 添加基本信息部分
    [self addBasicInfoSection:contact];
    
    // 添加特定类型的信息
    NSString *chatID = contact.m_nsUsrName;
    if ([chatID hasSuffix:@"@chatroom"]) {
        [self addGroupInfoSection:contact];
    } else if ([chatID hasPrefix:@"gh_"]) {
        [self addOfficialAccountInfoSection:contact];
    }
    
    // 刷新表格视图
    [_tableView reloadData];
}

#pragma mark - 构建数据模型

- (void)addAvatarSection:(CContact *)contact {
    // 创建头像项 - 使用自定义类型
    CSSettingItem *avatarItem = [[CSSettingItem alloc] init];
    avatarItem.title = contact.m_nsNickName ?: @"未知";
    avatarItem.detail = contact.m_nsUsrName ?: @"未知ID";
    
    // 使用关联对象存储头像URL
    objc_setAssociatedObject(avatarItem, "contactHeadImgUrl", contact.m_nsHeadImgUrl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(avatarItem, "contact", contact, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    CSSettingSection *section = [CSSettingSection sectionWithHeader:@"" items:@[avatarItem]];
    [_sections addObject:section];
}

- (void)addBasicInfoSection:(CContact *)contact {
    NSMutableArray *items = [NSMutableArray array];
    NSString *chatID = contact.m_nsUsrName;
    NSString *chatType = @"私聊";
    
    if ([chatID hasSuffix:@"@chatroom"]) {
        chatType = @"群聊";
    } else if ([chatID hasPrefix:@"gh_"]) {
        chatType = @"公众号";
    }
    
    // 添加跳转到个人主页的选项
    CSSettingItem *profileItem = [CSSettingItem itemWithTitle:@"主页" iconName:nil iconColor:nil detail:@"点击进入信息页"];
    // 关联联系人对象，以便在点击时访问
    objc_setAssociatedObject(profileItem, "profileContact", contact, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    // 添加到数组的最前面
    [items addObject:profileItem];
    
    // 添加基本信息项，使用两个字的标题
    [items addObject:[CSSettingItem itemWithTitle:@"类型" iconName:nil iconColor:nil detail:chatType]];
    [items addObject:[CSSettingItem itemWithTitle:@"微信" iconName:nil iconColor:nil detail:chatID]];
    
    // 获取备注名
    NSString *remarkName = @"未设置";
    if ([contact respondsToSelector:@selector(m_nsRemark)]) {
        remarkName = [contact valueForKey:@"m_nsRemark"];
    } else if ([contact respondsToSelector:@selector(m_nsRemarkName)]) {
        remarkName = [contact valueForKey:@"m_nsRemarkName"];
    }
    if (!remarkName || remarkName.length == 0) {
        remarkName = @"未设置";
    }
    [items addObject:[CSSettingItem itemWithTitle:@"备注" iconName:nil iconColor:nil detail:remarkName]];
    
    // 获取性别信息
    NSString *gender = @"未知";
    if ([contact respondsToSelector:@selector(m_uiSex)]) {
        int sex = [[contact valueForKey:@"m_uiSex"] intValue];
        gender = (sex == 1) ? @"男" : (sex == 2) ? @"女" : @"未知";
    }
    [items addObject:[CSSettingItem itemWithTitle:@"性别" iconName:nil iconColor:nil detail:gender]];
    
    // 获取地区信息
    NSString *location = @"未设置";
    NSString *province = nil;
    NSString *city = nil;
    
    // 尝试获取省份
    if ([contact respondsToSelector:@selector(m_nsProvince)]) {
        province = [contact valueForKey:@"m_nsProvince"];
    }
    
    // 尝试获取城市
    if ([contact respondsToSelector:@selector(m_nsCity)]) {
        city = [contact valueForKey:@"m_nsCity"];
    }
    
    if ((province && province.length > 0) || (city && city.length > 0)) {
        location = [NSString stringWithFormat:@"%@ %@", 
                    province ?: @"", city ?: @""];
        location = [location stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    }
    [items addObject:[CSSettingItem itemWithTitle:@"地区" iconName:nil iconColor:nil detail:location]];
    
    // 获取个性签名
    NSString *signature = @"未设置";
    if ([contact respondsToSelector:@selector(m_nsSignature)]) {
        NSString *signStr = [contact valueForKey:@"m_nsSignature"];
        if (signStr && signStr.length > 0) {
            signature = signStr;
        }
    }
    [items addObject:[CSSettingItem itemWithTitle:@"签名" iconName:nil iconColor:nil detail:signature]];
    
    CSSettingSection *section = [CSSettingSection sectionWithHeader:@"基本信息" items:items];
    [_sections addObject:section];
}

- (void)addGroupInfoSection:(CContact *)contact {
    NSMutableArray *items = [NSMutableArray array];
    
    // 群主信息
    NSString *ownerWxID = @"未知";
    if ([contact respondsToSelector:@selector(m_nsOwner)]) {
        ownerWxID = [contact valueForKey:@"m_nsOwner"] ?: @"未知";
    }
    [items addObject:[CSSettingItem itemWithTitle:@"群主" iconName:nil iconColor:nil detail:ownerWxID]];
    
    CSSettingSection *section = [CSSettingSection sectionWithHeader:@"群聊信息" items:items];
    [_sections addObject:section];
}

- (void)addOfficialAccountInfoSection:(CContact *)contact {
    NSMutableArray *items = [NSMutableArray array];
    
    [items addObject:[CSSettingItem itemWithTitle:@"类别" iconName:nil iconColor:nil detail:@"服务号"]];
    
    // 尝试获取验证状态
    BOOL isVerified = NO;
    if ([contact respondsToSelector:@selector(m_uiVerifyFlag)]) {
        int verifyFlag = [[contact valueForKey:@"m_uiVerifyFlag"] intValue];
        isVerified = (verifyFlag > 0);
    }
    [items addObject:[CSSettingItem itemWithTitle:@"认证" iconName:nil iconColor:nil detail:isVerified ? @"已认证" : @"未认证"]];
    
    CSSettingSection *section = [CSSettingSection sectionWithHeader:@"公众号信息" items:items];
    [_sections addObject:section];
}

#pragma mark - TableView 数据源方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _sections[section].items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSSettingItem *item = _sections[indexPath.section].items[indexPath.row];
    
    if (indexPath.section == 0) {
        // 头像部分使用卡片式设计
        static NSString *avatarCellId = @"AvatarCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:avatarCellId];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:avatarCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            // 创建卡片容器视图
            UIView *cardView = [[UIView alloc] init];
            cardView.tag = 1000;
            cardView.backgroundColor = [UIColor secondarySystemGroupedBackgroundColor];
            cardView.layer.cornerRadius = 16;
            cardView.layer.shadowColor = [UIColor blackColor].CGColor;
            cardView.layer.shadowOffset = CGSizeMake(0, 1);
            cardView.layer.shadowOpacity = 0.2;
            cardView.layer.shadowRadius = 3;
            [cell.contentView addSubview:cardView];
            
            // 设置卡片布局
            cardView.translatesAutoresizingMaskIntoConstraints = NO;
            [NSLayoutConstraint activateConstraints:@[
                [cardView.leadingAnchor constraintEqualToAnchor:cell.contentView.leadingAnchor constant:4],
                [cardView.trailingAnchor constraintEqualToAnchor:cell.contentView.trailingAnchor constant:-4],
                [cardView.topAnchor constraintEqualToAnchor:cell.contentView.topAnchor constant:12],
                [cardView.bottomAnchor constraintEqualToAnchor:cell.contentView.bottomAnchor constant:-12]
            ]];
            
            // 创建头像视图
            UIImageView *avatarView = [[UIImageView alloc] init];
            avatarView.tag = 1001;
            avatarView.layer.cornerRadius = 40;
            avatarView.layer.masksToBounds = YES;
            avatarView.contentMode = UIViewContentModeScaleAspectFill;
            // 移除蓝色边框，添加阴影效果
            avatarView.layer.borderWidth = 0;
            // 为了使阴影效果可见，创建一个容器视图
            UIView *avatarContainer = [[UIView alloc] init];
            avatarContainer.tag = 1003;
            avatarContainer.backgroundColor = [UIColor clearColor];
            avatarContainer.layer.shadowColor = [UIColor blackColor].CGColor;
            avatarContainer.layer.shadowOffset = CGSizeMake(0, 2);
            avatarContainer.layer.shadowOpacity = 0.4;
            avatarContainer.layer.shadowRadius = 4;
            avatarContainer.layer.cornerRadius = 40;
            [cardView addSubview:avatarContainer];
            [avatarContainer addSubview:avatarView];
            
            // 设置容器布局
            avatarContainer.translatesAutoresizingMaskIntoConstraints = NO;
            [NSLayoutConstraint activateConstraints:@[
                [avatarContainer.centerXAnchor constraintEqualToAnchor:cardView.centerXAnchor],
                [avatarContainer.topAnchor constraintEqualToAnchor:cardView.topAnchor constant:24],
                [avatarContainer.widthAnchor constraintEqualToConstant:80],
                [avatarContainer.heightAnchor constraintEqualToConstant:80]
            ]];
            
            // 设置头像布局
            avatarView.translatesAutoresizingMaskIntoConstraints = NO;
            [NSLayoutConstraint activateConstraints:@[
                [avatarView.topAnchor constraintEqualToAnchor:avatarContainer.topAnchor],
                [avatarView.leadingAnchor constraintEqualToAnchor:avatarContainer.leadingAnchor],
                [avatarView.trailingAnchor constraintEqualToAnchor:avatarContainer.trailingAnchor],
                [avatarView.bottomAnchor constraintEqualToAnchor:avatarContainer.bottomAnchor]
            ]];
            
            // 创建昵称标签
            UILabel *nameLabel = [[UILabel alloc] init];
            nameLabel.tag = 1002;
            nameLabel.font = [UIFont boldSystemFontOfSize:20];
            nameLabel.textColor = [UIColor labelColor];
            nameLabel.textAlignment = NSTextAlignmentCenter;
            nameLabel.numberOfLines = 0;
            [cardView addSubview:nameLabel];
            
            // 设置昵称布局
            nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
            [NSLayoutConstraint activateConstraints:@[
                [nameLabel.leadingAnchor constraintEqualToAnchor:cardView.leadingAnchor constant:16],
                [nameLabel.trailingAnchor constraintEqualToAnchor:cardView.trailingAnchor constant:-16],
                [nameLabel.topAnchor constraintEqualToAnchor:avatarView.bottomAnchor constant:16],
                [nameLabel.bottomAnchor constraintEqualToAnchor:cardView.bottomAnchor constant:-24]
            ]];
        }
        
        // 获取控件
        UIView *cardView = [cell.contentView viewWithTag:1000];
        UIView *avatarContainer = [cardView viewWithTag:1003];
        UIImageView *avatarView = [avatarContainer viewWithTag:1001];
        UILabel *nameLabel = [cardView viewWithTag:1002];
        
        // 根据深色模式调整卡片样式
        if (@available(iOS 13.0, *)) {
            if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                cardView.layer.shadowOpacity = 0.3;
                avatarContainer.layer.shadowOpacity = 0.5;
            } else {
                cardView.layer.shadowOpacity = 0.2;
                avatarContainer.layer.shadowOpacity = 0.4;
            }
        }
        
        // 设置数据
        nameLabel.text = item.title;
        
        // 加载头像
        NSString *avatarUrl = (NSString *)objc_getAssociatedObject(item, "contactHeadImgUrl");
        if (avatarUrl.length > 0) {
            // 设置默认头像作为占位图
            avatarView.image = [UIImage imageNamed:@"DefaultProfileHead_phone"];
            
            // 异步加载图片
            NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:avatarUrl]
                                                     cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                 timeoutInterval:10.0];
            
            NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (!error && data) {
                    UIImage *image = [UIImage imageWithData:data];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        avatarView.image = image;
                    });
                }
            }];
            [task resume];
        } else {
            avatarView.image = [UIImage imageNamed:@"DefaultProfileHead_phone"];
        }
        
        return cell;
    } else {
        // 信息项也使用卡片式设计
        static NSString *infoCellId = @"InfoCardCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:infoCellId];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:infoCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            cell.backgroundColor = [UIColor clearColor];
            
            // 创建卡片视图
            UIView *cardView = [[UIView alloc] init];
            cardView.tag = 2000;
            cardView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.95];
            cardView.layer.cornerRadius = 12;
            cardView.layer.shadowColor = [UIColor blackColor].CGColor;
            cardView.layer.shadowOffset = CGSizeMake(0, 1);
            cardView.layer.shadowOpacity = 0.1;
            cardView.layer.shadowRadius = 2;
            [cell.contentView addSubview:cardView];
            
            // 设置卡片布局
            cardView.translatesAutoresizingMaskIntoConstraints = NO;
            [NSLayoutConstraint activateConstraints:@[
                [cardView.leadingAnchor constraintEqualToAnchor:cell.contentView.leadingAnchor constant:4],
                [cardView.trailingAnchor constraintEqualToAnchor:cell.contentView.trailingAnchor constant:-4],
                [cardView.topAnchor constraintEqualToAnchor:cell.contentView.topAnchor constant:6],
                [cardView.bottomAnchor constraintEqualToAnchor:cell.contentView.bottomAnchor constant:-6]
            ]];
            
            // 创建标题标签
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.tag = 2001;
            titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
            titleLabel.textColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0];
            titleLabel.numberOfLines = 1;
            [cardView addSubview:titleLabel];
            
            // 标题标签布局 - 设置为固定宽度60，解决标题显示不全的问题
            titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
            [NSLayoutConstraint activateConstraints:@[
                [titleLabel.leadingAnchor constraintEqualToAnchor:cardView.leadingAnchor constant:16],
                [titleLabel.centerYAnchor constraintEqualToAnchor:cardView.centerYAnchor],
                [titleLabel.widthAnchor constraintEqualToConstant:60]
            ]];
            
            // 创建详情标签
            UILabel *detailLabel = [[UILabel alloc] init];
            detailLabel.tag = 2002;
            detailLabel.font = [UIFont systemFontOfSize:15];
            detailLabel.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0];
            detailLabel.numberOfLines = 0;
            detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
            [cardView addSubview:detailLabel];
            
            // 详情标签布局 - 减小右侧边距，确保长内容能完整显示
            detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
            [NSLayoutConstraint activateConstraints:@[
                [detailLabel.leadingAnchor constraintEqualToAnchor:titleLabel.trailingAnchor constant:10],
                [detailLabel.trailingAnchor constraintEqualToAnchor:cardView.trailingAnchor constant:-10],
                [detailLabel.topAnchor constraintEqualToAnchor:cardView.topAnchor constant:12],
                [detailLabel.bottomAnchor constraintEqualToAnchor:cardView.bottomAnchor constant:-12]
            ]];
            
            // 准备选中状态的背景视图
            UIView *selectedBgView = [[UIView alloc] init];
            selectedBgView.tag = 2003;
            selectedBgView.backgroundColor = [UIColor colorWithRed:0.9 green:0.95 blue:1.0 alpha:1.0];
            selectedBgView.layer.cornerRadius = 12;
            cell.selectedBackgroundView = selectedBgView;
        }
        
        // 获取控件
        UIView *cardView = [cell.contentView viewWithTag:2000];
        UILabel *titleLabel = [cardView viewWithTag:2001];
        UILabel *detailLabel = [cardView viewWithTag:2002];
        UIView *selectedBgView = cell.selectedBackgroundView;
        
        // 根据深色模式调整卡片样式
        if (@available(iOS 13.0, *)) {
            if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                cardView.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.95];
                titleLabel.textColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
                detailLabel.textColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
                selectedBgView.backgroundColor = [UIColor colorWithRed:0.3 green:0.35 blue:0.4 alpha:1.0];
            } else {
                cardView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.95];
                titleLabel.textColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0];
                detailLabel.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0];
                selectedBgView.backgroundColor = [UIColor colorWithRed:0.9 green:0.95 blue:1.0 alpha:1.0];
            }
        }
        
        // 设置数据
        titleLabel.text = item.title;
        detailLabel.text = item.detail;
        
        // 调整详情文本颜色，使特殊值更明显
        if ([item.detail isEqualToString:@"未设置"] || [item.detail isEqualToString:@"未知"]) {
            detailLabel.font = [UIFont italicSystemFontOfSize:15];
            if (@available(iOS 13.0, *)) {
                if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                    detailLabel.textColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0];
                } else {
                    detailLabel.textColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0];
                }
            } else {
                detailLabel.textColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0];
            }
        } else {
            detailLabel.font = [UIFont systemFontOfSize:15];
            if (@available(iOS 13.0, *)) {
                if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                    detailLabel.textColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
                } else {
                    detailLabel.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0];
                }
            } else {
                detailLabel.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0];
            }
        }
        
        return cell;
    }
}

#pragma mark - TableView 代理方法

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return _sections[section].header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 添加震动反馈
    [self playHapticFeedback];
    
    // 检查是否点击了个人主页选项
    if (indexPath.section == 1 && indexPath.row == 0) {
        CSSettingItem *item = _sections[indexPath.section].items[indexPath.row];
        CContact *contact = (CContact *)objc_getAssociatedObject(item, "profileContact");
        
        if (contact) {
            // 获取ContactInfoViewController类
            Class contactInfoViewControllerClass = %c(ContactInfoViewController);
            if (contactInfoViewControllerClass) {
                // 创建ContactInfoViewController实例
                id contactInfoVC = [[contactInfoViewControllerClass alloc] init];
                
                // 设置联系人对象
                @try {
                    [contactInfoVC setValue:contact forKey:@"m_contact"];
                } @catch (NSException *exception) {
                    // 设置失败时不做处理
                }
                
                // 关闭当前弹窗并跳转
                __weak typeof(self) weakSelf = self;
                [self dismissViewControllerAnimated:YES completion:^{
                    // 重新获取顶层控制器
                    UIViewController *newTopVC = [weakSelf findTopViewController];
                    
                    // 尝试获取导航控制器
                    UINavigationController *newNavController = nil;
                    if ([newTopVC isKindOfClass:[UINavigationController class]]) {
                        newNavController = (UINavigationController *)newTopVC;
                    } else {
                        newNavController = newTopVC.navigationController;
                    }
                    
                    if (newNavController) {
                        [newNavController pushViewController:contactInfoVC animated:YES];
                    } else {
                        // 如果没有导航控制器，使用模态方式呈现
                        [newTopVC presentViewController:contactInfoVC animated:YES completion:nil];
                    }
                }];
            } else {
                // 不做任何操作
            }
        } else {
            // 不做任何操作
        }
        return;
    }
    
    // 其他信息项的复制逻辑
    if (indexPath.section > 0) {
        CSSettingItem *item = _sections[indexPath.section].items[indexPath.row];
        if (item.detail.length > 0) {
            // 避免复制"未设置"和"未知"
            if (![item.detail isEqualToString:@"未设置"] && ![item.detail isEqualToString:@"未知"]) {
                [self copyTextToClipboard:item.detail];
            }
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 头像部分高度调整
    if (indexPath.section == 0) {
        return 210.0;
    }
    return UITableViewAutomaticDimension; // 其他行使用自动高度
}

// 重写viewDidLayoutSubviews方法，调整弹窗大小
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // 如果这是iPad，调整首选内容大小
    if (self.preferredContentSize.width == 0 || self.preferredContentSize.height == 0) {
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            self.preferredContentSize = CGSizeMake(400, 500);
        }
    }
}

#pragma mark - 辅助方法

- (void)copyTextToClipboard:(NSString *)text {
    if (!text || text.length == 0) return;
    
    // 复制到剪贴板
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:text];
    
    // 添加震动反馈
    [self playHapticFeedback];
    
    // 显示复制成功提示
    [self showCopySuccessToast];
}

- (void)showCopySuccessToast {
    // 创建提示视图 - 使用固定的颜色方案
    UIView *toastView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    
    // 使用固定的配色方案，确保在深色和浅色模式下都能清晰看到
    toastView.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.9];
    toastView.layer.cornerRadius = 25;
    toastView.clipsToBounds = YES;
    
    // 添加内部卡片，提供更好的视觉效果
    UIView *innerCard = [[UIView alloc] initWithFrame:CGRectInset(toastView.bounds, 1, 1)];
    innerCard.backgroundColor = [UIColor clearColor];
    innerCard.layer.cornerRadius = 24;
    innerCard.layer.borderWidth = 1;
    innerCard.layer.borderColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.2].CGColor;
    [toastView addSubview:innerCard];
    
    // 水平布局容器
    UIStackView *stackView = [[UIStackView alloc] initWithFrame:toastView.bounds];
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.alignment = UIStackViewAlignmentCenter;
    stackView.distribution = UIStackViewDistributionFill;
    stackView.spacing = 8;
    stackView.layoutMarginsRelativeArrangement = YES;
    stackView.layoutMargins = UIEdgeInsetsMake(0, 16, 0, 16);
    [toastView addSubview:stackView];
    
    // 添加成功图标
    UIImageView *checkImageView = [[UIImageView alloc] init];
    checkImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    // 使用固定的绿色，不使用系统动态色
    UIColor *fixedGreenColor = [UIColor colorWithRed:0.2 green:0.8 blue:0.2 alpha:1.0];
    
    if (@available(iOS 13.0, *)) {
        checkImageView.image = [UIImage systemImageNamed:@"checkmark.circle.fill"];
        checkImageView.tintColor = fixedGreenColor;
    } else {
        checkImageView.image = [UIImage imageNamed:@"check"];
        checkImageView.tintColor = fixedGreenColor;
    }
    
    checkImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [checkImageView.heightAnchor constraintEqualToConstant:24].active = YES;
    [checkImageView.widthAnchor constraintEqualToConstant:24].active = YES;
    
    // 添加文本标签 - 使用固定的白色
    UILabel *toastLabel = [[UILabel alloc] init];
    toastLabel.text = @"已复制到剪贴板";
    toastLabel.textColor = [UIColor whiteColor];
    toastLabel.textAlignment = NSTextAlignmentCenter;
    toastLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    
    // 添加到布局
    [stackView addArrangedSubview:checkImageView];
    [stackView addArrangedSubview:toastLabel];
    
    // 添加到视图中
    [self.view addSubview:toastView];
    
    // 居中显示，偏下
    toastView.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height - 100);
    
    // 创建显示和隐藏的动画
    toastView.alpha = 0;
    toastView.transform = CGAffineTransformMakeScale(0.8, 0.8);
    
    // 先执行弹出动画
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        toastView.alpha = 1;
        toastView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        // 延迟后执行淡出动画
        [UIView animateWithDuration:0.3 delay:1.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
            toastView.alpha = 0;
            toastView.transform = CGAffineTransformMakeScale(0.9, 0.9);
        } completion:^(BOOL finished) {
            [toastView removeFromSuperview];
        }];
    }];
}

- (void)playHapticFeedback {
    // 根据iOS版本选择合适的震动类型
    if (@available(iOS 10.0, *)) {
        // 选择较轻的震动效果，提供更好的用户体验
        UINotificationFeedbackGenerator *generator = [[UINotificationFeedbackGenerator alloc] init];
        [generator prepare];
        [generator notificationOccurred:UINotificationFeedbackTypeSuccess];
    }
}

#pragma mark - UIPopoverPresentationControllerDelegate

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    // 强制使用Popover样式，即使在iPhone上
    return UIModalPresentationNone;
}

// 递归查找顶层视图控制器的方法
- (UIViewController *)findTopViewController {
    // 获取keyWindow
    UIWindow *keyWindow = nil;
    
    if (@available(iOS 13.0, *)) {
        // 使用Scene API获取keyWindow (iOS 13+)
        NSSet<UIScene *> *connectedScenes = [UIApplication sharedApplication].connectedScenes;
        for (UIScene *scene in connectedScenes) {
            if (scene.activationState == UISceneActivationStateForegroundActive && [scene isKindOfClass:[UIWindowScene class]]) {
                UIWindowScene *windowScene = (UIWindowScene *)scene;
                NSArray<UIWindow *> *windows = windowScene.windows;
                for (UIWindow *window in windows) {
                    if (window.isKeyWindow) {
                        keyWindow = window;
                        break;
                    }
                }
                if (keyWindow) break;
            }
        }
    } else {
        // iOS 13以下版本
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wdeprecated-declarations"
        keyWindow = [UIApplication sharedApplication].keyWindow;
        #pragma clang diagnostic pop
    }
    
    if (!keyWindow) return nil;
    
    // 获取根视图控制器
    UIViewController *rootVC = keyWindow.rootViewController;
    UIViewController *currentVC = rootVC;
    
    // 递归查找最上层的视图控制器
    while (currentVC.presentedViewController) {
        currentVC = currentVC.presentedViewController;
    }
    
    if ([currentVC isKindOfClass:[UINavigationController class]]) {
        currentVC = [(UINavigationController *)currentVC visibleViewController];
    }
    
    if ([currentVC isKindOfClass:[UITabBarController class]]) {
        currentVC = [(UITabBarController *)currentVC selectedViewController];
        if ([currentVC isKindOfClass:[UINavigationController class]]) {
            currentVC = [(UINavigationController *)currentVC visibleViewController];
        }
    }
    
    return currentVC;
}



@end