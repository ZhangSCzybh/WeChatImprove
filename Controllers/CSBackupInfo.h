#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSBackupInfo : NSObject <NSCopying>

@property (nonatomic, copy) NSString *backupId;
@property (nonatomic, copy) NSString *backupName;
@property (nonatomic, copy) NSDate *createTime;
@property (nonatomic, copy, nullable) NSString *backupDescription;
@property (nonatomic, assign) NSInteger configCount;
@property (nonatomic, copy, nullable) NSString *filePath;
@property (nonatomic, assign) BOOL isAutoBackup;

- (instancetype)initWithBackupId:(NSString *)backupId
                      backupName:(NSString *)backupName
                      createTime:(NSDate *)createTime
                      backupDescription:(nullable NSString *)backupDescription
                     configCount:(NSInteger)configCount
                        filePath:(nullable NSString *)filePath
                     isAutoBackup:(BOOL)isAutoBackup;

- (NSDictionary *)toDictionary;
+ (instancetype)fromDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
