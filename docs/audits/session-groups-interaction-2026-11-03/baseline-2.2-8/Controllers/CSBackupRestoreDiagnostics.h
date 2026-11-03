#import <Foundation/Foundation.h>
#include <errno.h>

NS_ASSUME_NONNULL_BEGIN
// Shared by Foundation storage, engine and UIKit presentation; no hooks or I/O.
typedef NS_ENUM(NSInteger, CSBackupRestoreErrorCode) {
    CSBackupRestoreMigration = 1001,
    CSBackupRestoreValidation = 1002,
    CSBackupRestorePermission = 1003,
    CSBackupRestoreStorage = 1004,
    CSBackupRestoreRestart = 1005,
    CSBackupRestoreState = 1006,
    CSBackupRestoreCompatibility = 1007,
    CSBackupRestoreMissingResource = 1008,
};
NS_INLINE NSError *CSBackupFileError(NSString *path, NSString *operation, int code) {
    return [NSError errorWithDomain:NSPOSIXErrorDomain code:code?:EIO userInfo:@{
        NSLocalizedDescriptionKey:[NSString stringWithFormat:@"文件操作未完成：%@",path.lastPathComponent?:@""],
        NSFilePathErrorKey:path?:@"",@"operation":operation}];
}
NS_INLINE CSBackupRestoreErrorCode CSBackupRestoreCategory(NSError * _Nullable error, CSBackupRestoreErrorCode fallback) {
    for(NSUInteger depth=0;error&&depth<8;depth++,error=error.userInfo[NSUnderlyingErrorKey]){
        if([error.domain isEqual:@"CSBackupRestore"])return (CSBackupRestoreErrorCode)error.code;
        if([error.domain isEqual:@"CSPluginStorage"])return CSBackupRestoreMigration;
        if([error.domain isEqual:NSPOSIXErrorDomain]&&(error.code==EACCES||error.code==EPERM||error.code==EROFS))return CSBackupRestorePermission;
        if([error.domain isEqual:NSCocoaErrorDomain]&&(error.code==NSFileReadNoPermissionError||error.code==NSFileWriteNoPermissionError))return CSBackupRestorePermission;
        if([error.domain isEqual:NSPOSIXErrorDomain]&&error.code==ENOENT&&[error.userInfo[@"operation"] isEqual:@"inspect-image"])return CSBackupRestoreMissingResource;
        if([error.domain isEqual:NSPOSIXErrorDomain]||([error.domain isEqual:NSCocoaErrorDomain]&&error.code>=0&&error.code<1024))fallback=CSBackupRestoreStorage;
    }return fallback;
}
NS_INLINE NSError *CSBackupRestoreError(NSError * _Nullable source, NSString *stage, CSBackupRestoreErrorCode fallback, NSString * _Nullable path) {
    if([source.domain isEqual:@"CSBackupRestore"])return source;
    CSBackupRestoreErrorCode category=CSBackupRestoreCategory(source,fallback);
    NSString *title=@{@(CSBackupRestoreMigration):@"迁移未完成",@(CSBackupRestoreValidation):@"文件或配置校验失败",
        @(CSBackupRestorePermission):@"文件读写权限失败",@(CSBackupRestoreStorage):@"文件读写未完成",
        @(CSBackupRestoreRestart):@"需要重新打开微信",@(CSBackupRestoreState):@"恢复条件未满足",
        @(CSBackupRestoreCompatibility):@"该备份不适用于当前版本",@(CSBackupRestoreMissingResource):@"图片资源缺失"}[@(category)]?:@"恢复未完成";
    if(category==CSBackupRestorePermission){
        // Asset errors wrap Foundation/POSIX causes; inspect the whole chain so
        // an unreadable existing PNG is not described as a failed write.
        NSError *cause=source;
        for(NSUInteger depth=0;cause&&depth<8;depth++,cause=cause.userInfo[NSUnderlyingErrorKey]){
            NSString *operation=cause.userInfo[@"operation"];
            if([operation containsString:@"read"]||[operation hasPrefix:@"inspect-"]||
               ([cause.domain isEqual:NSCocoaErrorDomain]&&cause.code==NSFileReadNoPermissionError)){title=@"文件读取权限失败";break;}
            if(operation.length||([cause.domain isEqual:NSCocoaErrorDomain]&&cause.code==NSFileWriteNoPermissionError)){title=@"文件写入权限失败";break;}
        }
    }
    NSString *reason=source.localizedDescription?:@"操作没有完成，请查看备份与恢复状态后重试。";
    NSString *hint=category==CSBackupRestorePermission?@"请先解锁设备，再检查文件访问权限后重试。":@"";
    if([source.domain isEqual:NSPOSIXErrorDomain]&&source.code==ENOSPC){title=@"存储空间不足";hint=@"请释放空间后重试，原备份已保留。";}
    NSMutableDictionary *info=[@{NSLocalizedDescriptionKey:[NSString stringWithFormat:@"%@：%@%@",title,reason,hint],@"restoreStage":stage} mutableCopy];
    if(source)info[NSUnderlyingErrorKey]=source;
    NSString *actual=source.userInfo[NSFilePathErrorKey]?:path;if(actual)info[NSFilePathErrorKey]=actual;
    return [NSError errorWithDomain:@"CSBackupRestore" code:category userInfo:info];
}
NS_INLINE NSDictionary *CSBackupRestoreErrorDetails(NSError * _Nullable error) {
    if(!error)return @{@"errorCode":@0};
    NSMutableDictionary *details=[@{@"errorDomain":error.domain,@"errorCode":@(error.code),@"error":error.localizedDescription} mutableCopy];
    NSMutableArray *causes=[NSMutableArray array];
    for(NSUInteger depth=0;error&&depth<8;depth++,error=error.userInfo[NSUnderlyingErrorKey]){
        NSMutableDictionary *cause=[@{@"domain":error.domain,@"code":@(error.code)} mutableCopy];
        for(NSString *key in @[NSFilePathErrorKey,@"operation",@"errno",@"restoreStage"]){id value=error.userInfo[key];if(value)cause[key]=value;}
        [causes addObject:cause];
        if(error.userInfo[NSFilePathErrorKey])details[@"path"]=error.userInfo[NSFilePathErrorKey];
    }
    details[@"causes"]=causes;return details;
}
NS_ASSUME_NONNULL_END
