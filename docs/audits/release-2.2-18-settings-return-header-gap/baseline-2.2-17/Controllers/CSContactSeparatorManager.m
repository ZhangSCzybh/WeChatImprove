#import "CSContactSeparatorManager.h"
#import "CSNavigationTitleSettingsViewController.h"

NSString * const kContactSeparatorOverridesKey = @"com.wechat.tweak.navigation.contact.overrides";

#pragma mark - CSContactSeparatorConfig

@implementation CSContactSeparatorConfig

+ (instancetype)configWithDictionary:(NSDictionary *)dict {
    CSContactSeparatorConfig *config = [[CSContactSeparatorConfig alloc] init];
    config.separatorText = dict[@"separatorText"];
    config.separatorImagePath = dict[@"separatorImagePath"];
    config.separatorSize = [dict[@"separatorSize"] floatValue];
    config.avatarSpacing = [dict[@"avatarSpacing"] floatValue];
    config.verticalOffset = [dict[@"verticalOffset"] floatValue];
    config.enabled = [dict[@"enabled"] boolValue];
    return config;
}

- (NSDictionary *)toDictionary {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (self.separatorText) {
        dict[@"separatorText"] = self.separatorText;
    }
    if (self.separatorImagePath) {
        dict[@"separatorImagePath"] = self.separatorImagePath;
    }
    if (self.separatorSize > 0) {
        dict[@"separatorSize"] = @(self.separatorSize);
    }
    if (self.avatarSpacing > 0) {
        dict[@"avatarSpacing"] = @(self.avatarSpacing);
    }
    if (self.verticalOffset != 0) {
        dict[@"verticalOffset"] = @(self.verticalOffset);
    }
    dict[@"enabled"] = @(self.enabled);
    return [dict copy];
}

- (id)copyWithZone:(NSZone *)zone {
    CSContactSeparatorConfig *copy = [[CSContactSeparatorConfig allocWithZone:zone] init];
    copy.separatorText = [self.separatorText copyWithZone:zone];
    copy.separatorImagePath = [self.separatorImagePath copyWithZone:zone];
    copy.separatorSize = self.separatorSize;
    copy.avatarSpacing = self.avatarSpacing;
    copy.verticalOffset = self.verticalOffset;
    copy.enabled = self.enabled;
    return copy;
}

@end

#pragma mark - CSContactSeparatorManager

@interface CSContactSeparatorManager ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, CSContactSeparatorConfig *> *configCache;

@end

@implementation CSContactSeparatorManager

+ (instancetype)sharedManager {
    static CSContactSeparatorManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CSContactSeparatorManager alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        _configCache = [NSMutableDictionary dictionary];
        [self loadConfigs];
    }
    return self;
}

- (void)loadConfigs {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *overrides = [defaults dictionaryForKey:kContactSeparatorOverridesKey];
    
    [self.configCache removeAllObjects];
    
    [overrides enumerateKeysAndObjectsUsingBlock:^(NSString *contactId, NSDictionary *configDict, BOOL *stop) {
        CSContactSeparatorConfig *config = [CSContactSeparatorConfig configWithDictionary:configDict];
        if (config) {
            self.configCache[contactId] = config;
        }
    }];
}

- (void)saveConfigs {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *overrides = [NSMutableDictionary dictionary];
    
    [self.configCache enumerateKeysAndObjectsUsingBlock:^(NSString *contactId, CSContactSeparatorConfig *config, BOOL *stop) {
        overrides[contactId] = [config toDictionary];
    }];
    
    [defaults setObject:overrides forKey:kContactSeparatorOverridesKey];
    [defaults synchronize];
}

- (CSContactSeparatorConfig *)configForContactId:(NSString *)contactId {
    return self.configCache[contactId];
}

- (void)setConfig:(CSContactSeparatorConfig *)config forContactId:(NSString *)contactId {
    if (config) {
        self.configCache[contactId] = config;
    } else {
        [self.configCache removeObjectForKey:contactId];
    }
    [self saveConfigs];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CSNavigationTitleSettingsChanged" object:nil];
}

- (void)removeConfigForContactId:(NSString *)contactId {
    [self.configCache removeObjectForKey:contactId];
    [self saveConfigs];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CSNavigationTitleSettingsChanged" object:nil];
}

- (void)resetAllToDefault {
    [self.configCache removeAllObjects];
    [self saveConfigs];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CSNavigationTitleSettingsChanged" object:nil];
}

#pragma mark - 便捷方法

- (NSString *)separatorTextForContactId:(NSString *)contactId {
    CSContactSeparatorConfig *config = [self configForContactId:contactId];
    if (config && config.enabled && config.separatorText.length > 0) {
        return config.separatorText;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:kNavigationSeparatorTextKey] ?
           [defaults stringForKey:kNavigationSeparatorTextKey] : @"💗";
}

- (NSString *)separatorImagePathForContactId:(NSString *)contactId {
    CSContactSeparatorConfig *config = [self configForContactId:contactId];
    NSString *imagePath = nil;
    
    if (config && config.enabled && config.separatorImagePath.length > 0) {
        imagePath = config.separatorImagePath;
    } else {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        imagePath = [defaults objectForKey:kNavigationSeparatorImageKey];
    }
    
    return [imagePath isKindOfClass:NSString.class] ? imagePath : nil;
}

- (UIImage *)separatorImageForContactId:(NSString *)contactId {
    NSString *imagePath=[self separatorImagePathForContactId:contactId];
    if (imagePath && [[NSFileManager defaultManager] fileExistsAtPath:imagePath]) {
        NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
        return [UIImage imageWithData:imageData];
    }
    
    return nil;
}

- (CGFloat)separatorSizeForContactId:(NSString *)contactId {
    CSContactSeparatorConfig *config = [self configForContactId:contactId];
    if (config && config.enabled && config.separatorSize > 0) {
        return config.separatorSize;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:kNavigationSeparatorSizeKey] ?
           [defaults floatForKey:kNavigationSeparatorSizeKey] : kDefaultSeparatorSize;
}

- (CGFloat)avatarSpacingForContactId:(NSString *)contactId {
    CSContactSeparatorConfig *config = [self configForContactId:contactId];
    if (config && config.enabled && config.avatarSpacing > 0) {
        return config.avatarSpacing;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:kNavigationAvatarSpacingKey] ?
           [defaults floatForKey:kNavigationAvatarSpacingKey] : kDefaultAvatarSpacing;
}

- (CGFloat)verticalOffsetForContactId:(NSString *)contactId {
    CSContactSeparatorConfig *config = [self configForContactId:contactId];
    if (config && config.enabled) {
        return config.verticalOffset;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:kNavigationVerticalOffsetKey] ?
           [defaults floatForKey:kNavigationVerticalOffsetKey] : kDefaultVerticalOffset;
}

- (BOOL)hasCustomConfigForContactId:(NSString *)contactId {
    CSContactSeparatorConfig *config = [self configForContactId:contactId];
    return config && config.enabled;
}

- (NSArray<NSString *> *)allContactIdsWithCustomConfig {
    NSMutableArray *result = [NSMutableArray array];
    [self.configCache enumerateKeysAndObjectsUsingBlock:^(NSString *contactId, CSContactSeparatorConfig *config, BOOL *stop) {
        if (config.enabled) {
            [result addObject:contactId];
        }
    }];
    return [result copy];
}

@end
