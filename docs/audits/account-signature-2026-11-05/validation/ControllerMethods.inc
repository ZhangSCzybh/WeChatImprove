#pragma mark - 显示文本常量

// 证书类型文本
static NSString * const kCertTypePersonal = @"个人证书";
static NSString * const kCertTypeEnterprise = @"企业证书";
static NSString * const kCertTypeAppStore = @"App Store";

// 信息缺失文本
static NSString * const kInfoMissing = @"未读取到证书信息";
static NSString * const kDevicesUnlimited = @"不限制";

// 区域标题
static NSString * const kSectionUserInfo = @"用户信息";
static NSString * const kSectionAppInfo = @"应用信息";
static NSString * const kSectionCertInfo = @"签名信息";

// 用户信息标题
static NSString * const kUserName = @"微信名";
static NSString * const kWechatID = @"微信号";
static NSString * const kWXID = @"WXID";

// 应用信息标题
static NSString * const kAppName = @"应用名称";
static NSString * const kBundleID = @"Bundle ID";
static NSString * const kVersionTitle = @"版本号";
static NSString * const kDeviceModel = @"设备标识";

// 证书信息标题
static NSString * const kCertType = @"证书类型";
static NSString * const kTeamName = @"签名团队";
static NSString * const kTeamID = @"团队ID";
static NSString * const kCreationDate = @"注册时间";
static NSString * const kExpirationDate = @"过期时间";
static NSString * const kAllowedDevices = @"允许设备";
static NSString * const kDeviceUDID = @"授权设备 UDID";

// 其他格式文本
static NSString * const kDateFormat = @"yyyy-MM-dd HH:mm:ss";
static NSString * const kDevicesCountFormat = @"%lu 台设备";
static NSString * const kVersionFormat = @"%@\t(%@)";

// 按钮文本
static NSString * const kPageTitle = @"账号信息";
static NSString * const kAppSuffix = @"aucfa";


@implementation CSAccountDetailViewController

- (NSString *)determineProfileType:(NSDictionary *)profileDict {
    // 获取关键信息
    id devices = profileDict[@"ProvisionedDevices"];
    id allDevices = profileDict[@"ProvisionsAllDevices"];
    BOOL hasAllDevices = [allDevices isKindOfClass:NSNumber.class] && [allDevices boolValue];
    
    // 判断证书类型
    if ([devices isKindOfClass:NSArray.class]) {
        // 有设备列表 - 个人证书
        return kCertTypePersonal;
    } else if (hasAllDevices) {
        // 允许所有设备 - 企业证书
        return kCertTypeEnterprise;
    } else {
        // 默认为App Store
        return kCertTypeAppStore;
    }
}

- (NSDictionary *)readProvisioningProfile {
    // 获取embedded.mobileprovision文件路径
    NSString *embeddedPath = [NSBundle.mainBundle.bundlePath stringByAppendingPathComponent:@"embedded.mobileprovision"];
    
    // 直接读取二进制数据；描述文件不存在时仍显示信息缺失状态。
    self.profileReadMessage = nil;
    NSError *readError = nil;
    NSData *profileData = [NSData dataWithContentsOfFile:embeddedPath options:0 error:&readError];
    if (!profileData) {
        BOOL missing = [readError.domain isEqualToString:NSCocoaErrorDomain] &&
            (readError.code == NSFileReadNoSuchFileError || readError.code == NSFileNoSuchFileError);
        self.profileReadMessage = missing ? @"当前安装包未包含签名描述文件，无法显示签名信息。重签时请保留 embedded.mobileprovision。" :
                                           @"暂时无法读取当前安装包的签名描述文件。";
        return nil;
    }
    NSDictionary *profile = CSProvisioningProfileDictionaryFromData(profileData);
    if (!profile) {
        self.profileReadMessage = @"当前安装包的签名描述文件无法解析，请检查重签时使用的描述文件。";
    }
    return profile;
}

- (NSString *)getDeviceModelIdentifier {
    struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

- (void)setupData {
    // 获取用户信息
    NSString *nickname = [CSUserInfoHelper getUserNickname] ?: @"未知";
    NSString *aliasName = [CSUserInfoHelper getUserAliasName] ?: @"未知";
    NSString *wxid = [CSUserInfoHelper getUserWXID] ?: @"未知";
    
    // 获取应用信息
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *appName = [mainBundle objectForInfoDictionaryKey:@"CFBundleDisplayName"] ?: 
                        [mainBundle objectForInfoDictionaryKey:@"CFBundleName"] ?: @"未知";
    NSString *bundleID = mainBundle.bundleIdentifier ?: @"未知";
    NSString *version = [mainBundle objectForInfoDictionaryKey:@"CFBundleShortVersionString"] ?: @"未知";
    NSString *build = [mainBundle objectForInfoDictionaryKey:@"CFBundleVersion"] ?: @"未知";
    
    // 获取设备型号标识符
    NSString *deviceModelIdentifier = [self getDeviceModelIdentifier] ?: @"未知";
    
    // 创建用户信息模型
    self.userItems = @[
        [CSSettingItem itemWithTitle:kUserName iconName:@"person" iconColor:[UIColor systemBlueColor] detail:nickname],
        [CSSettingItem itemWithTitle:kWechatID iconName:@"at" iconColor:[UIColor systemGreenColor] detail:aliasName],
        [CSSettingItem itemWithTitle:kWXID iconName:@"number" iconColor:[UIColor systemOrangeColor] detail:wxid]
    ];
    
    // 读取描述文件信息
    NSDictionary *profileDict = [self readProvisioningProfile];
    
    // 创建应用信息模型
    self.appItems = @[
        [CSSettingItem itemWithTitle:kAppName iconName:@"app" iconColor:[UIColor systemIndigoColor] detail:appName],
        [CSSettingItem itemWithTitle:kBundleID iconName:@"doc.text" iconColor:[UIColor systemTealColor] detail:bundleID],
        [CSSettingItem itemWithTitle:kVersionTitle iconName:@"tag" iconColor:[UIColor systemPurpleColor] detail:[NSString stringWithFormat:kVersionFormat, version, build]],
        [CSSettingItem itemWithTitle:kDeviceModel iconName:@"iphone.radiowaves.left.and.right" iconColor:[UIColor systemBlueColor] detail:deviceModelIdentifier]
    ];
    
    // 如果无法读取配置文件
    if (!profileDict) {
        self.certItems = @[
            [CSSettingItem itemWithTitle:kAllowedDevices iconName:@"iphone" iconColor:[UIColor systemCyanColor] detail:kInfoMissing],
            [CSSettingItem itemWithTitle:kCertType iconName:@"lock.shield" iconColor:[UIColor systemTealColor] detail:kInfoMissing],
            [CSSettingItem itemWithTitle:kTeamName iconName:@"person.2" iconColor:[UIColor systemRedColor] detail:kInfoMissing],
            [CSSettingItem itemWithTitle:kTeamID iconName:@"person.crop.square" iconColor:[UIColor systemPurpleColor] detail:kInfoMissing],
            [CSSettingItem itemWithTitle:kCreationDate iconName:@"calendar.badge.plus" iconColor:[UIColor systemGreenColor] detail:kInfoMissing],
            [CSSettingItem itemWithTitle:kExpirationDate iconName:@"calendar" iconColor:[UIColor systemOrangeColor] detail:kInfoMissing],
            // 添加UDID项，即使没有读取到证书信息
            [CSSettingItem itemWithTitle:kDeviceUDID iconName:@"iphone.circle" iconColor:[UIColor systemRedColor] detail:kInfoMissing]
        ];
    } else {
        // 基本证书信息 - 加强空值检查
        NSString *teamName = kInfoMissing;
        if (profileDict[@"TeamName"] && [profileDict[@"TeamName"] isKindOfClass:[NSString class]]) {
            teamName = profileDict[@"TeamName"];
        }
        
        NSString *teamID = kInfoMissing;
        if (profileDict[@"TeamIdentifier"] && 
            [profileDict[@"TeamIdentifier"] isKindOfClass:[NSArray class]] && 
            [profileDict[@"TeamIdentifier"] count] > 0) {
            id firstItem = profileDict[@"TeamIdentifier"][0];
            if ([firstItem isKindOfClass:[NSString class]]) {
                teamID = (NSString *)firstItem;
            }
        }
        
        NSString *profileType = [self determineProfileType:profileDict];
        
        // 获取时间信息 - 加强空值检查
        NSString *createDateStr = kInfoMissing;
        if (profileDict[@"CreationDate"] && [profileDict[@"CreationDate"] isKindOfClass:[NSDate class]]) {
            NSDate *createDate = profileDict[@"CreationDate"];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = kDateFormat;
            createDateStr = [formatter stringFromDate:createDate];
        }
        
        NSString *expirationDateStr = kInfoMissing;
        if (profileDict[@"ExpirationDate"] && [profileDict[@"ExpirationDate"] isKindOfClass:[NSDate class]]) {
            NSDate *expirationDate = profileDict[@"ExpirationDate"];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = kDateFormat;
            expirationDateStr = [formatter stringFromDate:expirationDate];
        }
        
        // 设备信息 - 加强空值检查
        NSString *deviceCountStr = kDevicesUnlimited;
        if (profileDict[@"ProvisionedDevices"] && 
            [profileDict[@"ProvisionedDevices"] isKindOfClass:[NSArray class]]) {
            NSArray *devices = profileDict[@"ProvisionedDevices"];
            deviceCountStr = [NSString stringWithFormat:kDevicesCountFormat, (unsigned long)devices.count];
        }
        
        // 创建证书信息模型 - 按照要求调整顺序
        NSMutableArray *certItemsArray = [NSMutableArray arrayWithArray:@[
            [CSSettingItem itemWithTitle:kAllowedDevices iconName:@"iphone" iconColor:[UIColor systemCyanColor] detail:deviceCountStr],
            [CSSettingItem itemWithTitle:kCertType iconName:@"lock.shield" iconColor:[UIColor systemTealColor] detail:profileType],
            [CSSettingItem itemWithTitle:kTeamName iconName:@"person.2" iconColor:[UIColor systemRedColor] detail:teamName],
            [CSSettingItem itemWithTitle:kTeamID iconName:@"person.crop.square" iconColor:[UIColor systemPurpleColor] detail:teamID],
            [CSSettingItem itemWithTitle:kCreationDate iconName:@"calendar.badge.plus" iconColor:[UIColor systemGreenColor] detail:createDateStr],
            [CSSettingItem itemWithTitle:kExpirationDate iconName:@"calendar" iconColor:[UIColor systemOrangeColor] detail:expirationDateStr]
        ]];
        
        // 如果是个人证书，添加UDID到证书信息区域的最后
        if ([profileType isEqualToString:kCertTypePersonal]) {
            NSArray *provisionedDevices = profileDict[@"ProvisionedDevices"];
            if (provisionedDevices && [provisionedDevices isKindOfClass:[NSArray class]] && provisionedDevices.count > 0) {
                NSString *udid = [provisionedDevices firstObject];
                if (udid && [udid isKindOfClass:[NSString class]]) {
                    [certItemsArray addObject:[CSSettingItem itemWithTitle:kDeviceUDID 
                                                                iconName:@"iphone.circle" 
                                                                iconColor:[UIColor systemRedColor] 
                                                                detail:udid]];
                }
            }
        }
        
        // 设置证书信息
        self.certItems = [certItemsArray copy];
    }
    
    // 创建sections
    NSMutableArray *sections = [NSMutableArray array];
    [sections addObject:[CSSettingSection sectionWithHeader:kSectionUserInfo items:self.userItems]];
    [sections addObject:[CSSettingSection sectionWithHeader:kSectionAppInfo items:self.appItems]];
    [sections addObject:[CSSettingSection sectionWithHeader:kSectionCertInfo items:self.certItems]];
    
    self.sections = [sections copy];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return [self.sections[section].header isEqualToString:kSectionCertInfo] ? self.profileReadMessage : nil;
}

@end
