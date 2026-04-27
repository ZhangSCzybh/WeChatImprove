#import "CSBackupManager.h"
#import "CSServiceCenter.h"
#import <objc/runtime.h>
#import <objc/message.h>

#define kUserDefaultsSuiteName @"com.cyansmoke.wechattweak"

static NSString * const kBackupDirectoryName = @"Backup";
static NSString * const kBackupInfoFileName = @"backup_info.json";
static NSString * const kAutoBackupEnabledKey = @"com.wechat.enhance.backup.auto_enabled";
static NSString * const kLastAutoBackupDateKey = @"com.wechat.enhance.backup.last_date";

@interface CSBackupManager ()
@property (nonatomic, strong) NSString *backupDirectory;
@property (nonatomic, strong) NSString *backupInfoPath;
@property (nonatomic, strong) NSMutableArray<CSBackupInfo *> *backupList;
@end

@implementation CSBackupManager

+ (instancetype)sharedManager {
    static CSBackupManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CSBackupManager alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupBackupDirectory];
        [self loadBackupList];
    }
    return self;
}

#pragma mark - 初始化

- (void)setupBackupDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryPath = [paths firstObject];
    self.backupDirectory = [libraryPath stringByAppendingPathComponent:kBackupDirectoryName];
    self.backupInfoPath = [self.backupDirectory stringByAppendingPathComponent:kBackupInfoFileName];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:self.backupDirectory]) {
        [fileManager createDirectoryAtPath:self.backupDirectory
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:nil];
    }
}

- (void)loadBackupList {
    self.backupList = [NSMutableArray array];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:self.backupInfoPath]) {
        NSData *data = [NSData dataWithContentsOfFile:self.backupInfoPath];
        if (data) {
            NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            if (array && [array isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dict in array) {
                    CSBackupInfo *info = [CSBackupInfo fromDictionary:dict];
                    if (info) {
                        [self.backupList addObject:info];
                    }
                }
            }
        }
    }
}

- (void)saveBackupList {
    NSMutableArray *array = [NSMutableArray array];
    for (CSBackupInfo *info in self.backupList) {
        [array addObject:[info toDictionary]];
    }
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
    if (data) {
        [data writeToFile:self.backupInfoPath atomically:YES];
    }
}

#pragma mark - 备份管理

- (BOOL)createBackupWithName:(NSString *)backupName
                  description:(nullable NSString *)description
                   isAutoBackup:(BOOL)isAutoBackup
                       error:(NSError **)error {
    
    NSString *backupId = [[NSUUID UUID] UUIDString];
    NSString *backupPath = [self.backupDirectory stringByAppendingPathComponent:backupId];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager createDirectoryAtPath:backupPath
                withIntermediateDirectories:YES
                                 attributes:nil
                                      error:error]) {
        return NO;
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryPath = [paths firstObject];
    NSString *preferencesPath = [libraryPath stringByAppendingPathComponent:@"Preferences"];
    
    NSArray *directoryContents = [fileManager contentsOfDirectoryAtPath:preferencesPath error:error];
    if (!directoryContents && error) {
        return NO;
    }
    
    NSInteger configCount = 0;
    for (NSString *fileName in directoryContents) {
        if ([fileName hasSuffix:@".plist"]) {
            NSString *sourcePath = [preferencesPath stringByAppendingPathComponent:fileName];
            NSString *destPath = [backupPath stringByAppendingPathComponent:fileName];
            
            if ([fileManager copyItemAtPath:sourcePath toPath:destPath error:error]) {
                configCount++;
            }
        }
    }
    
    NSLog(@"[BackupManager] 备份创建完成，配置文件数量: %ld", (long)configCount);
    
    NSString *wechatImprovePath = [preferencesPath stringByAppendingPathComponent:@"WeChatImprove"];
    if ([fileManager fileExistsAtPath:wechatImprovePath]) {
        NSString *backupImprovePath = [backupPath stringByAppendingPathComponent:@"WeChatImprove"];
        
        if ([fileManager fileExistsAtPath:backupImprovePath]) {
            [fileManager removeItemAtPath:backupImprovePath error:nil];
        }
        
        if ([fileManager copyItemAtPath:wechatImprovePath toPath:backupImprovePath error:error]) {
            configCount++;
        }
    }
    
    CSBackupInfo *backupInfo = [[CSBackupInfo alloc] initWithBackupId:backupId
                                                           backupName:backupName
                                                           createTime:[NSDate date]
                                                   backupDescription:description
                                                          configCount:configCount
                                                             filePath:backupPath
                                                          isAutoBackup:isAutoBackup];
    
    [self.backupList insertObject:backupInfo atIndex:0];
    [self saveBackupList];
    
    return YES;
}

- (BOOL)restoreBackup:(CSBackupInfo *)backupInfo error:(NSError **)error {
    if (!backupInfo || !backupInfo.filePath) {
        if (error) {
            *error = [NSError errorWithDomain:@"CSBackupManager"
                                         code:CSBackupErrorInvalidBackup
                                     userInfo:@{NSLocalizedDescriptionKey: @"无效的备份信息"}];
        }
        return NO;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:backupInfo.filePath]) {
        if (error) {
            *error = [NSError errorWithDomain:@"CSBackupManager"
                                         code:CSBackupErrorFileNotFound
                                     userInfo:@{NSLocalizedDescriptionKey: @"备份文件不存在"}];
        }
        return NO;
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryPath = [paths firstObject];
    NSString *preferencesPath = [libraryPath stringByAppendingPathComponent:@"Preferences"];
    
    NSArray *backupFiles = [fileManager contentsOfDirectoryAtPath:backupInfo.filePath error:error];
    if (!backupFiles && error) {
        return NO;
    }
    
    NSInteger restoredCount = 0;
    for (NSString *fileName in backupFiles) {
        NSString *sourcePath = [backupInfo.filePath stringByAppendingPathComponent:fileName];
        NSString *destPath = [preferencesPath stringByAppendingPathComponent:fileName];
        
        BOOL isDirectory = NO;
        if ([fileManager fileExistsAtPath:sourcePath isDirectory:&isDirectory]) {
            if (isDirectory) {
                if ([fileManager fileExistsAtPath:destPath]) {
                    [fileManager removeItemAtPath:destPath error:nil];
                }
                
                if ([fileManager copyItemAtPath:sourcePath toPath:destPath error:error]) {
                    restoredCount++;
                }
            } else if ([fileName hasSuffix:@".plist"]) {
                if ([fileManager fileExistsAtPath:destPath]) {
                    [fileManager removeItemAtPath:destPath error:nil];
                }
                
                if ([fileManager copyItemAtPath:sourcePath toPath:destPath error:error]) {
                    restoredCount++;
                }
            }
        }
    }
    
    if (restoredCount == 0) {
        if (error) {
            *error = [NSError errorWithDomain:@"CSBackupManager"
                                         code:CSBackupErrorRestoreFailed
                                     userInfo:@{NSLocalizedDescriptionKey: @"没有恢复任何配置文件"}];
        }
        return NO;
    }
    
    // 强制NSUserDefaults重新加载配置
    // 注意：不要清除微信的域，这会导致微信关键配置丢失而崩溃
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // 只清除插件的域
    NSString *suiteName = kUserDefaultsSuiteName;
    if (suiteName.length > 0) {
        NSUserDefaults *suiteDefaults = [[NSUserDefaults alloc] initWithSuiteName:suiteName];
        [suiteDefaults removePersistentDomainForName:suiteName];
        [suiteDefaults synchronize];
    }
    
    [defaults synchronize];
    
    // 方法2: 直接从备份文件读取并更新NSUserDefaults
    for (NSString *fileName in backupFiles) {
        if ([fileName hasSuffix:@".plist"]) {
            NSString *sourcePath = [backupInfo.filePath stringByAppendingPathComponent:fileName];
            NSDictionary *plistDict = [NSDictionary dictionaryWithContentsOfFile:sourcePath];
            
            if (plistDict) {
                // 根据plist文件名判断使用哪个UserDefaults
                // 插件配置文件特征：包含特定关键词，或者文件名就是插件suite name
                BOOL isPluginConfig = [fileName containsString:@"WeChatImprove"] || 
                                     [fileName containsString:@"wechattweak"] || 
                                     [fileName containsString:@"cyansmoke"] ||
                                     [fileName containsString:kUserDefaultsSuiteName];
                
                if (isPluginConfig) {
                    // 使用共享Suite
                    NSUserDefaults *suiteDefaults = [[NSUserDefaults alloc] initWithSuiteName:kUserDefaultsSuiteName];
                    for (NSString *key in plistDict) {
                        id value = plistDict[key];
                        if (value) {
                            [suiteDefaults setObject:value forKey:key];
                        }
                    }
                    [suiteDefaults synchronize];
                } else {
                    // 使用标准UserDefaults
                    for (NSString *key in plistDict) {
                        id value = plistDict[key];
                        if (value) {
                            [defaults setObject:value forKey:key];
                        }
                    }
                }
            }
        }
    }
    
    [defaults synchronize];
    
    // 确保共享Suite也同步
    if (suiteName.length > 0) {
        NSUserDefaults *suiteDefaults = [[NSUserDefaults alloc] initWithSuiteName:suiteName];
        [suiteDefaults synchronize];
        
        // 验证恢复结果
        NSDictionary *allValues = [suiteDefaults persistentDomainForName:suiteName];
        NSLog(@"[BackupManager] 备份恢复完成，插件配置项数量: %lu", (unsigned long)allValues.count);
    }
    
    CFNotificationCenterPostNotification(
        CFNotificationCenterGetDarwinNotifyCenter(),
        CFSTR("com.wechat.enhance.settings_changed"),
        NULL,
        NULL,
        true
    );
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.settings_changed" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.local_settings_changed" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BackgroundRunStatusChanged" object:nil];
    
    return YES;
}

- (BOOL)deleteBackup:(CSBackupInfo *)backupInfo error:(NSError **)error {
    if (!backupInfo || !backupInfo.filePath) {
        if (error) {
            *error = [NSError errorWithDomain:@"CSBackupManager"
                                         code:CSBackupErrorInvalidBackup
                                     userInfo:@{NSLocalizedDescriptionKey: @"无效的备份信息"}];
        }
        return NO;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:backupInfo.filePath]) {
        if (![fileManager removeItemAtPath:backupInfo.filePath error:error]) {
            return NO;
        }
    }
    
    [self.backupList removeObject:backupInfo];
    [self saveBackupList];
    
    return YES;
}

- (NSArray<CSBackupInfo *> *)getAllBackups {
    return [self.backupList copy];
}

- (nullable CSBackupInfo *)getBackupById:(NSString *)backupId {
    for (CSBackupInfo *info in self.backupList) {
        if ([info.backupId isEqualToString:backupId]) {
            return info;
        }
    }
    return nil;
}

#pragma mark - 导出导入

- (nullable NSURL *)exportBackupToTempFile:(CSBackupInfo *)backupInfo error:(NSError **)error {
    if (!backupInfo || !backupInfo.filePath) {
        if (error) {
            *error = [NSError errorWithDomain:@"CSBackupManager"
                                         code:CSBackupErrorInvalidBackup
                                     userInfo:@{NSLocalizedDescriptionKey: @"无效的备份信息"}];
        }
        return nil;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:backupInfo.filePath]) {
        if (error) {
            *error = [NSError errorWithDomain:@"CSBackupManager"
                                         code:CSBackupErrorFileNotFound
                                     userInfo:@{NSLocalizedDescriptionKey: @"备份文件不存在"}];
        }
        return nil;
    }
    
    NSString *tempPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"BackupExport"];
    [fileManager createDirectoryAtPath:tempPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    NSString *exportFileName = [NSString stringWithFormat:@"%@_%@.wechatbackup",
                                backupInfo.backupName,
                                [self formatDate:backupInfo.createTime]];
    NSString *exportPath = [tempPath stringByAppendingPathComponent:exportFileName];
    
    NSMutableDictionary *exportData = [NSMutableDictionary dictionary];
    exportData[@"version"] = @"1.0";
    exportData[@"backupInfo"] = [backupInfo toDictionary];
    exportData[@"createDate"] = @([[NSDate date] timeIntervalSince1970]);
    
    NSMutableDictionary *allSettings = [NSMutableDictionary dictionary];
    
    NSArray *backupFiles = [fileManager contentsOfDirectoryAtPath:backupInfo.filePath error:nil];
    for (NSString *fileName in backupFiles) {
        NSString *filePath = [backupInfo.filePath stringByAppendingPathComponent:fileName];
        
        BOOL isDirectory = NO;
        if ([fileManager fileExistsAtPath:filePath isDirectory:&isDirectory]) {
            if (isDirectory) {
                NSMutableDictionary *folderData = [NSMutableDictionary dictionary];
                [self readAllFilesInFolder:filePath toDictionary:folderData];
                allSettings[fileName] = folderData;
            } else if ([fileName hasSuffix:@".plist"]) {
                NSString *plistName = [fileName stringByDeletingPathExtension];
                NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile:filePath];
                if (plistData) {
                    NSMutableDictionary *safePlistData = [NSMutableDictionary dictionary];
                    for (NSString *key in plistData) {
                        id value = plistData[key];
                        if ([self isJSONSafeObject:value]) {
                            safePlistData[key] = value;
                        } else if ([value isKindOfClass:[NSData class]]) {
                            NSString *base64String = [(NSData *)value base64EncodedStringWithOptions:0];
                            safePlistData[key] = @{@"__type__": @"data", @"value": base64String};
                        } else {
                            safePlistData[key] = @{@"__type__": @"unknown", @"value": [value description]};
                        }
                    }
                    allSettings[plistName] = safePlistData;
                }
            }
        }
    }
    
    exportData[@"settings"] = allSettings;
    
    NSError *jsonError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:exportData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&jsonError];
    if (!jsonData || jsonError) {
        if (error) {
            *error = [NSError errorWithDomain:@"CSBackupManager"
                                         code:CSBackupErrorExportFailed
                                     userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"无法创建备份数据: %@", jsonError.localizedDescription]}];
        }
        return nil;
    }
    
    if (![jsonData writeToFile:exportPath atomically:YES]) {
        if (error) {
            *error = [NSError errorWithDomain:@"CSBackupManager"
                                         code:CSBackupErrorExportFailed
                                     userInfo:@{NSLocalizedDescriptionKey: @"无法写入备份文件"}];
        }
        return nil;
    }
    
    return [NSURL fileURLWithPath:exportPath];
}

- (BOOL)isJSONSafeObject:(id)object {
    if ([object isKindOfClass:[NSString class]] ||
        [object isKindOfClass:[NSNumber class]] ||
        [object isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([object isKindOfClass:[NSArray class]]) {
        for (id item in (NSArray *)object) {
            if (![self isJSONSafeObject:item]) {
                return NO;
            }
        }
        return YES;
    }
    if ([object isKindOfClass:[NSDictionary class]]) {
        for (id key in (NSDictionary *)object) {
            if (![key isKindOfClass:[NSString class]]) {
                return NO;
            }
            if (![self isJSONSafeObject:[(NSDictionary *)object objectForKey:key]]) {
                return NO;
            }
        }
        return YES;
    }
    return NO;
}

- (void)readAllFilesInFolder:(NSString *)folderPath toDictionary:(NSMutableDictionary *)dictionary {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:folderPath error:nil];
    
    for (NSString *fileName in contents) {
        NSString *filePath = [folderPath stringByAppendingPathComponent:fileName];
        
        BOOL isDirectory = NO;
        if ([fileManager fileExistsAtPath:filePath isDirectory:&isDirectory]) {
            if (isDirectory) {
                NSMutableDictionary *subDictionary = [NSMutableDictionary dictionary];
                [self readAllFilesInFolder:filePath toDictionary:subDictionary];
                dictionary[fileName] = subDictionary;
            } else {
                NSData *fileData = [NSData dataWithContentsOfFile:filePath];
                if (fileData) {
                    NSString *base64String = [fileData base64EncodedStringWithOptions:0];
                    dictionary[fileName] = base64String;
                }
            }
        }
    }
}

- (BOOL)importBackupFromFile:(NSURL *)fileURL error:(NSError **)error {
    if (![fileURL isFileURL]) {
        if (error) {
            *error = [NSError errorWithDomain:@"CSBackupManager"
                                         code:CSBackupErrorImportFailed
                                     userInfo:@{NSLocalizedDescriptionKey: @"无效的文件路径"}];
        }
        return NO;
    }
    
    NSString *filePath = fileURL.path;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:filePath]) {
        if (error) {
            *error = [NSError errorWithDomain:@"CSBackupManager"
                                         code:CSBackupErrorFileNotFound
                                     userInfo:@{NSLocalizedDescriptionKey: @"文件不存在"}];
        }
        return NO;
    }
    
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    if (!jsonData) {
        if (error) {
            *error = [NSError errorWithDomain:@"CSBackupManager"
                                         code:CSBackupErrorImportFailed
                                     userInfo:@{NSLocalizedDescriptionKey: @"无法读取文件"}];
        }
        return NO;
    }
    
    NSDictionary *importData = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:error];
    if (!importData || ![importData isKindOfClass:[NSDictionary class]]) {
        if (error) {
            *error = [NSError errorWithDomain:@"CSBackupManager"
                                         code:CSBackupErrorImportFailed
                                     userInfo:@{NSLocalizedDescriptionKey: @"无效的备份文件格式"}];
        }
        return NO;
    }
    
    NSDictionary *backupInfoDict = importData[@"backupInfo"];
    if (!backupInfoDict) {
        if (error) {
            *error = [NSError errorWithDomain:@"CSBackupManager"
                                         code:CSBackupErrorImportFailed
                                     userInfo:@{NSLocalizedDescriptionKey: @"备份信息缺失"}];
        }
        return NO;
    }
    
    CSBackupInfo *backupInfo = [CSBackupInfo fromDictionary:backupInfoDict];
    if (!backupInfo) {
        if (error) {
            *error = [NSError errorWithDomain:@"CSBackupManager"
                                         code:CSBackupErrorImportFailed
                                     userInfo:@{NSLocalizedDescriptionKey: @"无法解析备份信息"}];
        }
        return NO;
    }
    
    NSString *newBackupId = [[NSUUID UUID] UUIDString];
    NSString *backupPath = [self.backupDirectory stringByAppendingPathComponent:newBackupId];
    
    if (![fileManager createDirectoryAtPath:backupPath
                withIntermediateDirectories:YES
                                 attributes:nil
                                      error:error]) {
        return NO;
    }
    
    backupInfo.backupId = newBackupId;
    backupInfo.filePath = backupPath;
    backupInfo.createTime = [NSDate date];
    backupInfo.isAutoBackup = NO;
    
    // 从JSON文件中提取settings并写入plist文件
    NSDictionary *settings = importData[@"settings"];
    if (settings && [settings isKindOfClass:[NSDictionary class]]) {
        NSLog(@"[BackupManager] 导入备份，settings数量: %lu", (unsigned long)settings.count);
        
        for (NSString *key in settings) {
            id value = settings[key];
            
            if ([value isKindOfClass:[NSDictionary class]]) {
                NSString *plistName = key;
                NSString *plistFileName = [plistName stringByAppendingPathExtension:@"plist"];
                NSString *plistPath = [backupPath stringByAppendingPathComponent:plistFileName];
                
                NSMutableDictionary *plistData = [NSMutableDictionary dictionary];
                NSDictionary *settingsDict = (NSDictionary *)value;
                
                for (NSString *settingKey in settingsDict) {
                    id settingValue = settingsDict[settingKey];
                    
                    // 处理特殊类型
                    if ([settingValue isKindOfClass:[NSDictionary class]]) {
                        NSDictionary *valueDict = (NSDictionary *)settingValue;
                        NSString *type = valueDict[@"__type__"];
                        
                        if ([type isEqualToString:@"data"]) {
                            // 从base64恢复Data
                            NSString *base64String = valueDict[@"value"];
                            if (base64String) {
                                NSData *data = [[NSData alloc] initWithBase64EncodedString:base64String options:0];
                                if (data) {
                                    plistData[settingKey] = data;
                                }
                            }
                        } else if ([type isEqualToString:@"unknown"]) {
                            // 跳过未知类型
                        } else {
                            // 其他类型，保存原始值
                            plistData[settingKey] = settingValue;
                        }
                    } else {
                        // 普通类型，直接保存
                        plistData[settingKey] = settingValue;
                    }
                }
                
                // 写入plist文件
                if (plistData.count > 0) {
                    [plistData writeToFile:plistPath atomically:YES];
                }
            }
        }
    }
    
    [self.backupList insertObject:backupInfo atIndex:0];
    [self saveBackupList];
    
    return YES;
}

#pragma mark - 发送到文件传输助手

- (BOOL)sendBackupToFileHelper:(CSBackupInfo *)backupInfo error:(NSError **)error {
    NSURL *exportURL = [self exportBackupToTempFile:backupInfo error:error];
    if (!exportURL) {
        return NO;
    }
    
    NSData *fileData = [NSData dataWithContentsOfURL:exportURL];
    if (!fileData) {
        if (error) {
            *error = [NSError errorWithDomain:@"CSBackupManager"
                                         code:CSBackupErrorExportFailed
                                     userInfo:@{NSLocalizedDescriptionKey: @"无法读取备份文件"}];
        }
        return NO;
    }
    
    NSString *fileName = [backupInfo.backupName stringByAppendingPathExtension:@"wcbak"];
    NSString *tempDir = NSTemporaryDirectory();
    NSString *tempFilePath = [tempDir stringByAppendingPathComponent:fileName];
    
    NSError *writeError = nil;
    if (![fileData writeToFile:tempFilePath options:NSDataWritingAtomic error:&writeError]) {
        if (error) {
            *error = [NSError errorWithDomain:@"CSBackupManager"
                                         code:CSBackupErrorExportFailed
                                     userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"无法保存临时文件: %@", writeError.localizedDescription]}];
        }
        return NO;
    }
    
    Class cMessageWrapClass = NSClassFromString(@"CMessageWrap");
    if (!cMessageWrapClass) {
        if (error) {
            *error = [NSError errorWithDomain:@"CSBackupManager"
                                         code:CSBackupErrorExportFailed
                                     userInfo:@{NSLocalizedDescriptionKey: @"无法获取CMessageWrap类"}];
        }
        return NO;
    }
    
    id msgWrap = nil;
    NSString *selfUserName = [self getCurrentUserName];
    
    @try {
        SEL genFileSel = NSSelectorFromString(@"genFileAppMsgWithFileName:filePath:fileData:");
        if ([cMessageWrapClass respondsToSelector:genFileSel]) {
            msgWrap = ((id (*)(id, SEL, id, id, id))objc_msgSend)(
                cMessageWrapClass, genFileSel, fileName, tempFilePath, fileData);
        }
    } @catch (NSException *exception) {
        NSLog(@"[备份管理] genFileAppMsgWithFileName 失败: %@", exception);
        msgWrap = nil;
    }
    
    if (!msgWrap) {
        if (error) {
            *error = [NSError errorWithDomain:@"CSBackupManager"
                                         code:CSBackupErrorExportFailed
                                     userInfo:@{NSLocalizedDescriptionKey: @"无法创建文件消息对象"}];
        }
        return NO;
    }
    
    @try {
        NSString *fileHelperUserName = @"filehelper";
        
        if ([msgWrap respondsToSelector:@selector(setM_nsToUsr:)]) {
            [msgWrap setValue:fileHelperUserName forKey:@"m_nsToUsr"];
        }
        
        if (selfUserName.length > 0 && [msgWrap respondsToSelector:@selector(setM_nsFromUsr:)]) {
            [msgWrap setValue:selfUserName forKey:@"m_nsFromUsr"];
        }
        
        if ([msgWrap respondsToSelector:@selector(setM_uiIsSenderStatus:)]) {
            [msgWrap setValue:@(1) forKey:@"m_uiIsSenderStatus"];
        }
        
        unsigned int createTime = (unsigned int)[[NSDate date] timeIntervalSince1970];
        if ([msgWrap respondsToSelector:@selector(setM_uiCreateTime:)]) {
            [msgWrap setValue:@(createTime) forKey:@"m_uiCreateTime"];
        }
        
        if ([msgWrap respondsToSelector:@selector(setM_uiSendTime:)]) {
            [msgWrap setValue:@(createTime) forKey:@"m_uiSendTime"];
        }
        
        if ([msgWrap respondsToSelector:@selector(setM_uiStatus:)]) {
            [msgWrap setValue:@(1) forKey:@"m_uiStatus"];
        }
        
        if ([msgWrap respondsToSelector:@selector(setM_uiDownloadStatus:)]) {
            [msgWrap setValue:@(9) forKey:@"m_uiDownloadStatus"];
        }
        
        if ([msgWrap respondsToSelector:@selector(setM_uiUploadStatus:)]) {
            [msgWrap setValue:@(1) forKey:@"m_uiUploadStatus"];
        }
        
        if ([msgWrap respondsToSelector:@selector(setM_uiPercent:)]) {
            [msgWrap setValue:@(100) forKey:@"m_uiPercent"];
        }
        
        if ([msgWrap respondsToSelector:@selector(setM_uiMesLocalID:)]) {
            [msgWrap setValue:@(0) forKey:@"m_uiMesLocalID"];
        }
        
        if ([msgWrap respondsToSelector:@selector(setM_n64MesSvrID:)]) {
            [msgWrap setValue:@(0) forKey:@"m_n64MesSvrID"];
        }
        
        NSString *clientMsgID = nil;
        if (selfUserName.length > 0) {
            clientMsgID = [NSString stringWithFormat:@"%@_%u_%u", selfUserName, createTime, arc4random()];
        } else {
            clientMsgID = [NSString stringWithFormat:@"cs_%u_%u", createTime, arc4random()];
        }
        if ([msgWrap respondsToSelector:@selector(setM_nsClientMsgID:)]) {
            [msgWrap setValue:clientMsgID forKey:@"m_nsClientMsgID"];
        }
        
    } @catch (NSException *exception) {
        if (error) {
            *error = [NSError errorWithDomain:@"CSBackupManager"
                                         code:CSBackupErrorExportFailed
                                     userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"设置消息属性失败: %@", exception.reason]}];
        }
        return NO;
    }
    
    @try {
        Class cMessageMgrClass = NSClassFromString(@"CMessageMgr");
        if (!cMessageMgrClass) {
            if (error) {
                *error = [NSError errorWithDomain:@"CSBackupManager"
                                             code:CSBackupErrorExportFailed
                                         userInfo:@{NSLocalizedDescriptionKey: @"无法获取CMessageMgr类"}];
            }
            return NO;
        }
        
        id messageMgr = CSGetService(cMessageMgrClass);
        if (!messageMgr) {
            if (error) {
                *error = [NSError errorWithDomain:@"CSBackupManager"
                                             code:CSBackupErrorExportFailed
                                         userInfo:@{NSLocalizedDescriptionKey: @"无法获取CMessageMgr实例"}];
            }
            return NO;
        }
        
        NSString *fileHelperUserName = @"filehelper";
        unsigned int scene = 0;
        
        SEL addAppMsgSelector = NSSelectorFromString(@"AddAppMsg:MsgWrap:DataPath:Scene:");
        if ([messageMgr respondsToSelector:addAppMsgSelector]) {
            NSMethodSignature *signature = [messageMgr methodSignatureForSelector:addAppMsgSelector];
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
            [invocation setTarget:messageMgr];
            [invocation setSelector:addAppMsgSelector];
            [invocation setArgument:&fileHelperUserName atIndex:2];
            [invocation setArgument:&msgWrap atIndex:3];
            [invocation setArgument:&tempFilePath atIndex:4];
            [invocation setArgument:&scene atIndex:5];
            [invocation invoke];
            return YES;
        }
        
        SEL addAppMsgDataSelector = NSSelectorFromString(@"AddAppMsg:MsgWrap:Data:Scene:");
        if ([messageMgr respondsToSelector:addAppMsgDataSelector]) {
            NSMethodSignature *signature = [messageMgr methodSignatureForSelector:addAppMsgDataSelector];
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
            [invocation setTarget:messageMgr];
            [invocation setSelector:addAppMsgDataSelector];
            [invocation setArgument:&fileHelperUserName atIndex:2];
            [invocation setArgument:&msgWrap atIndex:3];
            [invocation setArgument:&fileData atIndex:4];
            [invocation setArgument:&scene atIndex:5];
            [invocation invoke];
            return YES;
        }
        
        SEL addLocalMsgSelector = NSSelectorFromString(@"AddLocalMsg:MsgWrap:");
        if ([messageMgr respondsToSelector:addLocalMsgSelector]) {
            NSMethodSignature *signature = [messageMgr methodSignatureForSelector:addLocalMsgSelector];
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
            [invocation setTarget:messageMgr];
            [invocation setSelector:addLocalMsgSelector];
            [invocation setArgument:&fileHelperUserName atIndex:2];
            [invocation setArgument:&msgWrap atIndex:3];
            [invocation invoke];
            return YES;
        }
        
        SEL addMsgSelector = NSSelectorFromString(@"AddMsg:MsgWrap:");
        if ([messageMgr respondsToSelector:addMsgSelector]) {
            NSMethodSignature *signature = [messageMgr methodSignatureForSelector:addMsgSelector];
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
            [invocation setTarget:messageMgr];
            [invocation setSelector:addMsgSelector];
            [invocation setArgument:&fileHelperUserName atIndex:2];
            [invocation setArgument:&msgWrap atIndex:3];
            [invocation invoke];
            return YES;
        }
        
        Class sendMessageMgrClass = NSClassFromString(@"SendMessageMgr");
        if (!sendMessageMgrClass) {
            if (error) {
                *error = [NSError errorWithDomain:@"CSBackupManager"
                                             code:CSBackupErrorExportFailed
                                         userInfo:@{NSLocalizedDescriptionKey: @"无法获取SendMessageMgr类"}];
            }
            return NO;
        }
        
        id sendMessageMgr = CSGetService(sendMessageMgrClass);
        if (!sendMessageMgr) {
            if (error) {
                *error = [NSError errorWithDomain:@"CSBackupManager"
                                             code:CSBackupErrorExportFailed
                                         userInfo:@{NSLocalizedDescriptionKey: @"无法获取SendMessageMgr实例"}];
            }
            return NO;
        }
        
        SEL addMsgToSendTableSelector = NSSelectorFromString(@"AddMsgToSendTable:MsgWrap:");
        if (![sendMessageMgr respondsToSelector:addMsgToSendTableSelector]) {
            if (error) {
                *error = [NSError errorWithDomain:@"CSBackupManager"
                                             code:CSBackupErrorExportFailed
                                         userInfo:@{NSLocalizedDescriptionKey: @"SendMessageMgr不支持发送消息"}];
            }
            return NO;
        }
        
        ((void (*)(id, SEL, id, id))objc_msgSend)(sendMessageMgr, addMsgToSendTableSelector, fileHelperUserName, msgWrap);
        
        return YES;
        
    } @catch (NSException *exception) {
        if (error) {
            *error = [NSError errorWithDomain:@"CSBackupManager"
                                         code:CSBackupErrorExportFailed
                                     userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"发送失败: %@", exception.reason]}];
        }
        return NO;
    }
}

- (BOOL)sendBackupToSelf:(CSBackupInfo *)backupInfo error:(NSError **)error {
    NSURL *exportURL = [self exportBackupToTempFile:backupInfo error:error];
    if (!exportURL) {
        return NO;
    }
    
    NSData *fileData = [NSData dataWithContentsOfURL:exportURL];
    if (!fileData) {
        if (error) {
            *error = [NSError errorWithDomain:@"CSBackupManager"
                                         code:CSBackupErrorExportFailed
                                     userInfo:@{NSLocalizedDescriptionKey: @"无法读取备份文件"}];
        }
        return NO;
    }
    
    NSString *fileName = [backupInfo.backupName stringByAppendingPathExtension:@"wcbak"];
    NSString *tempDir = NSTemporaryDirectory();
    NSString *tempFilePath = [tempDir stringByAppendingPathComponent:fileName];
    
    NSError *writeError = nil;
    if (![fileData writeToFile:tempFilePath options:NSDataWritingAtomic error:&writeError]) {
        if (error) {
            *error = [NSError errorWithDomain:@"CSBackupManager"
                                         code:CSBackupErrorExportFailed
                                     userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"无法保存临时文件: %@", writeError.localizedDescription]}];
        }
        return NO;
    }
    
    Class cMessageWrapClass = NSClassFromString(@"CMessageWrap");
    if (!cMessageWrapClass) {
        if (error) {
            *error = [NSError errorWithDomain:@"CSBackupManager"
                                         code:CSBackupErrorExportFailed
                                     userInfo:@{NSLocalizedDescriptionKey: @"无法获取CMessageWrap类"}];
        }
        return NO;
    }
    
    id msgWrap = nil;
    NSString *selfUserName = [self getCurrentUserName];
    
    if (selfUserName.length == 0) {
        if (error) {
            *error = [NSError errorWithDomain:@"CSBackupManager"
                                         code:CSBackupErrorExportFailed
                                     userInfo:@{NSLocalizedDescriptionKey: @"无法获取当前用户名"}];
        }
        return NO;
    }
    
    @try {
        SEL genFileSel = NSSelectorFromString(@"genFileAppMsgWithFileName:filePath:fileData:");
        if ([cMessageWrapClass respondsToSelector:genFileSel]) {
            msgWrap = ((id (*)(id, SEL, id, id, id))objc_msgSend)(
                cMessageWrapClass, genFileSel, fileName, tempFilePath, fileData);
        }
    } @catch (NSException *exception) {
        NSLog(@"[备份管理] genFileAppMsgWithFileName 失败: %@", exception);
        msgWrap = nil;
    }
    
    if (!msgWrap) {
        if (error) {
            *error = [NSError errorWithDomain:@"CSBackupManager"
                                         code:CSBackupErrorExportFailed
                                     userInfo:@{NSLocalizedDescriptionKey: @"无法创建文件消息对象"}];
        }
        return NO;
    }
    
    @try {
        if ([msgWrap respondsToSelector:@selector(setM_nsToUsr:)]) {
            [msgWrap setValue:selfUserName forKey:@"m_nsToUsr"];
        }
        
        if ([msgWrap respondsToSelector:@selector(setM_nsFromUsr:)]) {
            [msgWrap setValue:selfUserName forKey:@"m_nsFromUsr"];
        }
        
        if ([msgWrap respondsToSelector:@selector(setM_uiIsSenderStatus:)]) {
            [msgWrap setValue:@(1) forKey:@"m_uiIsSenderStatus"];
        }
        
        unsigned int createTime = (unsigned int)[[NSDate date] timeIntervalSince1970];
        if ([msgWrap respondsToSelector:@selector(setM_uiCreateTime:)]) {
            [msgWrap setValue:@(createTime) forKey:@"m_uiCreateTime"];
        }
        
        if ([msgWrap respondsToSelector:@selector(setM_uiSendTime:)]) {
            [msgWrap setValue:@(createTime) forKey:@"m_uiSendTime"];
        }
        
        if ([msgWrap respondsToSelector:@selector(setM_uiStatus:)]) {
            [msgWrap setValue:@(1) forKey:@"m_uiStatus"];
        }
        
        if ([msgWrap respondsToSelector:@selector(setM_uiDownloadStatus:)]) {
            [msgWrap setValue:@(9) forKey:@"m_uiDownloadStatus"];
        }
        
        if ([msgWrap respondsToSelector:@selector(setM_uiUploadStatus:)]) {
            [msgWrap setValue:@(1) forKey:@"m_uiUploadStatus"];
        }
        
        if ([msgWrap respondsToSelector:@selector(setM_uiPercent:)]) {
            [msgWrap setValue:@(100) forKey:@"m_uiPercent"];
        }
        
        if ([msgWrap respondsToSelector:@selector(setM_uiMesLocalID:)]) {
            [msgWrap setValue:@(0) forKey:@"m_uiMesLocalID"];
        }
        
        if ([msgWrap respondsToSelector:@selector(setM_n64MesSvrID:)]) {
            [msgWrap setValue:@(0) forKey:@"m_n64MesSvrID"];
        }
        
        NSString *clientMsgID = [NSString stringWithFormat:@"%@_%u_%u", selfUserName, createTime, arc4random()];
        if ([msgWrap respondsToSelector:@selector(setM_nsClientMsgID:)]) {
            [msgWrap setValue:clientMsgID forKey:@"m_nsClientMsgID"];
        }
        
    } @catch (NSException *exception) {
        if (error) {
            *error = [NSError errorWithDomain:@"CSBackupManager"
                                         code:CSBackupErrorExportFailed
                                     userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"设置消息属性失败: %@", exception.reason]}];
        }
        return NO;
    }
    
    @try {
        Class cMessageMgrClass = NSClassFromString(@"CMessageMgr");
        if (!cMessageMgrClass) {
            if (error) {
                *error = [NSError errorWithDomain:@"CSBackupManager"
                                             code:CSBackupErrorExportFailed
                                         userInfo:@{NSLocalizedDescriptionKey: @"无法获取CMessageMgr类"}];
            }
            return NO;
        }
        
        id messageMgr = CSGetService(cMessageMgrClass);
        if (!messageMgr) {
            if (error) {
                *error = [NSError errorWithDomain:@"CSBackupManager"
                                             code:CSBackupErrorExportFailed
                                         userInfo:@{NSLocalizedDescriptionKey: @"无法获取CMessageMgr实例"}];
            }
            return NO;
        }
        
        unsigned int scene = 0;
        
        SEL addAppMsgSelector = NSSelectorFromString(@"AddAppMsg:MsgWrap:DataPath:Scene:");
        if ([messageMgr respondsToSelector:addAppMsgSelector]) {
            NSMethodSignature *signature = [messageMgr methodSignatureForSelector:addAppMsgSelector];
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
            [invocation setTarget:messageMgr];
            [invocation setSelector:addAppMsgSelector];
            [invocation setArgument:&selfUserName atIndex:2];
            [invocation setArgument:&msgWrap atIndex:3];
            [invocation setArgument:&tempFilePath atIndex:4];
            [invocation setArgument:&scene atIndex:5];
            [invocation invoke];
            return YES;
        }
        
        SEL addAppMsgDataSelector = NSSelectorFromString(@"AddAppMsg:MsgWrap:Data:Scene:");
        if ([messageMgr respondsToSelector:addAppMsgDataSelector]) {
            NSMethodSignature *signature = [messageMgr methodSignatureForSelector:addAppMsgDataSelector];
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
            [invocation setTarget:messageMgr];
            [invocation setSelector:addAppMsgDataSelector];
            [invocation setArgument:&selfUserName atIndex:2];
            [invocation setArgument:&msgWrap atIndex:3];
            [invocation setArgument:&fileData atIndex:4];
            [invocation setArgument:&scene atIndex:5];
            [invocation invoke];
            return YES;
        }
        
        SEL addLocalMsgSelector = NSSelectorFromString(@"AddLocalMsg:MsgWrap:");
        if ([messageMgr respondsToSelector:addLocalMsgSelector]) {
            NSMethodSignature *signature = [messageMgr methodSignatureForSelector:addLocalMsgSelector];
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
            [invocation setTarget:messageMgr];
            [invocation setSelector:addLocalMsgSelector];
            [invocation setArgument:&selfUserName atIndex:2];
            [invocation setArgument:&msgWrap atIndex:3];
            [invocation invoke];
            return YES;
        }
        
        SEL addMsgSelector = NSSelectorFromString(@"AddMsg:MsgWrap:");
        if ([messageMgr respondsToSelector:addMsgSelector]) {
            NSMethodSignature *signature = [messageMgr methodSignatureForSelector:addMsgSelector];
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
            [invocation setTarget:messageMgr];
            [invocation setSelector:addMsgSelector];
            [invocation setArgument:&selfUserName atIndex:2];
            [invocation setArgument:&msgWrap atIndex:3];
            [invocation invoke];
            return YES;
        }
        
        Class sendMessageMgrClass = NSClassFromString(@"SendMessageMgr");
        if (!sendMessageMgrClass) {
            if (error) {
                *error = [NSError errorWithDomain:@"CSBackupManager"
                                             code:CSBackupErrorExportFailed
                                         userInfo:@{NSLocalizedDescriptionKey: @"无法获取SendMessageMgr类"}];
            }
            return NO;
        }
        
        id sendMessageMgr = CSGetService(sendMessageMgrClass);
        if (!sendMessageMgr) {
            if (error) {
                *error = [NSError errorWithDomain:@"CSBackupManager"
                                             code:CSBackupErrorExportFailed
                                         userInfo:@{NSLocalizedDescriptionKey: @"无法获取SendMessageMgr实例"}];
            }
            return NO;
        }
        
        SEL addMsgToSendTableSelector = NSSelectorFromString(@"AddMsgToSendTable:MsgWrap:");
        if (![sendMessageMgr respondsToSelector:addMsgToSendTableSelector]) {
            if (error) {
                *error = [NSError errorWithDomain:@"CSBackupManager"
                                             code:CSBackupErrorExportFailed
                                         userInfo:@{NSLocalizedDescriptionKey: @"SendMessageMgr不支持发送消息"}];
            }
            return NO;
        }
        
        ((void (*)(id, SEL, id, id))objc_msgSend)(sendMessageMgr, addMsgToSendTableSelector, selfUserName, msgWrap);
        
        return YES;
        
    } @catch (NSException *exception) {
        if (error) {
            *error = [NSError errorWithDomain:@"CSBackupManager"
                                         code:CSBackupErrorExportFailed
                                     userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"发送失败: %@", exception.reason]}];
        }
        return NO;
    }
}

- (NSString *)getCurrentUserName {
    Class contactMgrClass = NSClassFromString(@"CContactMgr");
    if (contactMgrClass) {
        id contactMgr = CSGetService(contactMgrClass);
        if (contactMgr) {
            SEL getSelfContactSelector = NSSelectorFromString(@"getSelfContact");
            if ([contactMgr respondsToSelector:getSelfContactSelector]) {
                @try {
                    id selfContact = ((id (*)(id, SEL))objc_msgSend)(contactMgr, getSelfContactSelector);
                    if (selfContact) {
                        SEL m_nsUsrNameSelector = NSSelectorFromString(@"m_nsUsrName");
                        if ([selfContact respondsToSelector:m_nsUsrNameSelector]) {
                            id userName = ((id (*)(id, SEL))objc_msgSend)(selfContact, m_nsUsrNameSelector);
                            if ([userName isKindOfClass:[NSString class]] && [(NSString *)userName length] > 0) {
                                return (NSString *)userName;
                            }
                        }
                    }
                } @catch (NSException *exception) {
                    NSLog(@"[备份管理] 从CContactMgr获取用户名失败: %@", exception);
                }
            }
        }
    }
    
    Class serviceCenterClass = NSClassFromString(@"ServiceCenter");
    if (serviceCenterClass) {
        SEL currentUserNameSelector = NSSelectorFromString(@"currentUserName");
        if ([serviceCenterClass respondsToSelector:currentUserNameSelector]) {
            @try {
                id userName = ((id (*)(id, SEL))objc_msgSend)(serviceCenterClass, currentUserNameSelector);
                if ([userName isKindOfClass:[NSString class]] && [(NSString *)userName length] > 0) {
                    return (NSString *)userName;
                }
            } @catch (NSException *exception) {
                NSLog(@"[备份管理] 从ServiceCenter获取用户名失败: %@", exception);
            }
        }
    }
    
    Class settingServiceClass = NSClassFromString(@"SettingService");
    if (settingServiceClass) {
        id settingService = CSGetService(settingServiceClass);
        if (settingService) {
            SEL currentUserNameSelector = NSSelectorFromString(@"currentUserName");
            if ([settingService respondsToSelector:currentUserNameSelector]) {
                @try {
                    id userName = ((id (*)(id, SEL))objc_msgSend)(settingService, currentUserNameSelector);
                    if ([userName isKindOfClass:[NSString class]] && [(NSString *)userName length] > 0) {
                        return (NSString *)userName;
                    }
                } @catch (NSException *exception) {
                    NSLog(@"[备份管理] 从SettingService获取用户名失败: %@", exception);
                }
            }
        }
    }
    
    return @"";
}

#pragma mark - 自动备份

- (void)enableAutoBackup:(BOOL)enable {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:enable forKey:kAutoBackupEnabledKey];
    [defaults synchronize];
}

- (BOOL)isAutoBackupEnabled {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:kAutoBackupEnabledKey];
}

- (void)performAutoBackupIfNeeded {
    if (![self isAutoBackupEnabled]) {
        return;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDate *lastBackupDate = [defaults objectForKey:kLastAutoBackupDateKey];
    
    if (lastBackupDate) {
        NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:lastBackupDate];
        if (interval < 24 * 60 * 60) {
            return;
        }
    }
    
    NSString *backupName = [NSString stringWithFormat:@"自动备份 %@",
                            [self formatDate:[NSDate date]]];
    
    NSError *error = nil;
    if ([self createBackupWithName:backupName
                       description:@"自动创建的备份"
                      isAutoBackup:YES
                             error:&error]) {
        [defaults setObject:[NSDate date] forKey:kLastAutoBackupDateKey];
        [defaults synchronize];
    }
}

#pragma mark - 辅助方法

- (NSInteger)getConfigCount {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryPath = [paths firstObject];
    NSString *preferencesPath = [libraryPath stringByAppendingPathComponent:@"Preferences"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *directoryContents = [fileManager contentsOfDirectoryAtPath:preferencesPath error:nil];
    
    NSInteger count = 0;
    for (NSString *fileName in directoryContents) {
        if ([fileName hasSuffix:@".plist"]) {
            count++;
        }
    }
    
    return count;
}

- (NSString *)getBackupDirectory {
    return self.backupDirectory;
}

- (NSString *)formatDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [formatter stringFromDate:date];
}

@end
