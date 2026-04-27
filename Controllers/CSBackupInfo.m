#import "CSBackupInfo.h"

@implementation CSBackupInfo

- (instancetype)initWithBackupId:(NSString *)backupId
                      backupName:(NSString *)backupName
                      createTime:(NSDate *)createTime
                      backupDescription:(nullable NSString *)backupDescription
                     configCount:(NSInteger)configCount
                        filePath:(nullable NSString *)filePath
                     isAutoBackup:(BOOL)isAutoBackup {
    self = [super init];
    if (self) {
        _backupId = [backupId copy];
        _backupName = [backupName copy];
        _createTime = [createTime copy];
        _backupDescription = [backupDescription copy];
        _configCount = configCount;
        _filePath = [filePath copy];
        _isAutoBackup = isAutoBackup;
    }
    return self;
}

- (instancetype)init {
    return [self initWithBackupId:[[NSUUID UUID] UUIDString]
                      backupName:@"未命名备份"
                      createTime:[NSDate date]
                      backupDescription:nil
                     configCount:0
                        filePath:nil
                     isAutoBackup:NO];
}

- (id)copyWithZone:(NSZone *)zone {
    CSBackupInfo *copy = [[CSBackupInfo allocWithZone:zone] initWithBackupId:self.backupId
                                                                   backupName:self.backupName
                                                                   createTime:self.createTime
                                                           backupDescription:self.backupDescription
                                                                  configCount:self.configCount
                                                                     filePath:self.filePath
                                                                  isAutoBackup:self.isAutoBackup];
    return copy;
}

- (NSDictionary *)toDictionary {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"backupId"] = self.backupId ?: @"";
    dict[@"backupName"] = self.backupName ?: @"";
    dict[@"createTime"] = @(self.createTime.timeIntervalSince1970);
    dict[@"backupDescription"] = self.backupDescription ?: @"";
    dict[@"configCount"] = @(self.configCount);
    dict[@"filePath"] = self.filePath ?: @"";
    dict[@"isAutoBackup"] = @(self.isAutoBackup);
    return [dict copy];
}

+ (instancetype)fromDictionary:(NSDictionary *)dict {
    if (!dict || ![dict isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    NSString *backupId = dict[@"backupId"] ?: [[NSUUID UUID] UUIDString];
    NSString *backupName = dict[@"backupName"] ?: @"未命名备份";
    
    NSDate *createTime = [NSDate date];
    if (dict[@"createTime"]) {
        NSTimeInterval interval = [dict[@"createTime"] doubleValue];
        createTime = [NSDate dateWithTimeIntervalSince1970:interval];
    }
    
    NSString *backupDescription = dict[@"backupDescription"];
    NSInteger configCount = [dict[@"configCount"] integerValue];
    NSString *filePath = dict[@"filePath"];
    BOOL isAutoBackup = [dict[@"isAutoBackup"] boolValue];
    
    return [[CSBackupInfo alloc] initWithBackupId:backupId
                                       backupName:backupName
                                       createTime:createTime
                               backupDescription:backupDescription
                                      configCount:configCount
                                         filePath:filePath
                                      isAutoBackup:isAutoBackup];
}

@end
