#import <Foundation/Foundation.h>
#import "CSBackupInfo.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CSBackupError) {
    CSBackupErrorNone = 0,
    CSBackupErrorCreateFailed,
    CSBackupErrorRestoreFailed,
    CSBackupErrorDeleteFailed,
    CSBackupErrorExportFailed,
    CSBackupErrorImportFailed,
    CSBackupErrorInvalidBackup,
    CSBackupErrorFileNotFound,
};

@interface CSBackupManager : NSObject

+ (instancetype)sharedManager;

#pragma mark - 备份管理

- (BOOL)createBackupWithName:(NSString *)backupName
                  description:(nullable NSString *)description
                   isAutoBackup:(BOOL)isAutoBackup
                       error:(NSError **)error;

- (BOOL)restoreBackup:(CSBackupInfo *)backupInfo error:(NSError **)error;

- (BOOL)deleteBackup:(CSBackupInfo *)backupInfo error:(NSError **)error;

- (NSArray<CSBackupInfo *> *)getAllBackups;

- (nullable CSBackupInfo *)getBackupById:(NSString *)backupId;

#pragma mark - 导出导入

- (nullable NSURL *)exportBackupToTempFile:(CSBackupInfo *)backupInfo error:(NSError **)error;

- (BOOL)importBackupFromFile:(NSURL *)fileURL error:(NSError **)error;

#pragma mark - 发送到聊天窗口

- (BOOL)sendBackupToFileHelper:(CSBackupInfo *)backupInfo error:(NSError **)error;

- (BOOL)sendBackupToSelf:(CSBackupInfo *)backupInfo error:(NSError **)error;

#pragma mark - 自动备份

- (void)enableAutoBackup:(BOOL)enable;

- (BOOL)isAutoBackupEnabled;

- (void)performAutoBackupIfNeeded;

#pragma mark - 辅助方法

- (NSInteger)getConfigCount;

- (NSString *)getBackupDirectory;

@end

NS_ASSUME_NONNULL_END
