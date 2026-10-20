#import <Foundation/Foundation.h>
#import "CSBackupStore.h"
NS_ASSUME_NONNULL_BEGIN
@interface CSBackupEngine : NSObject
@property(nonatomic,readonly) CSBackupStore *store;
@property(nonatomic,readonly) NSURL *resourceRoot;
@property(nonatomic) BOOL readPreferencesOnMain;
@property(nonatomic,readonly,nullable) NSDictionary *appliedContext;
@property(nonatomic,copy) NSDictionary *(^context)(void);
/// Test-only failure/crash seam. Called after persistent transaction boundaries.
@property(nonatomic,copy,nullable) void (^checkpoint)(NSString *point);
- (instancetype)initWithDefaults:(NSDictionary<NSString *,NSUserDefaults *> *)defaults domains:(NSDictionary<NSString *,NSString *> *)domains store:(CSBackupStore *)store resources:(NSURL *)resources;
- (nullable NSDictionary *)capture:(NSString *)name kind:(NSString *)kind error:(NSError **)error;
- (nullable NSDictionary *)save:(NSString *)name kind:(NSString *)kind error:(NSError **)error;
+ (NSString *)contentDigest:(NSDictionary *)snapshot;
- (nullable NSDictionary *)preview:(NSDictionary *)snapshot modules:(NSSet<NSString *> *)modules accounts:(NSSet<NSString *> *)accounts error:(NSError **)error;
- (BOOL)prepare:(NSDictionary *)preview error:(NSError **)error;
- (BOOL)applyPending:(NSError **)error;
- (BOOL)rollbackBeforeActivation:(NSError **)error;
- (BOOL)confirmStartup:(NSError **)error;
- (BOOL)finishStartup:(NSError **)error;
- (BOOL)cancelPending:(NSError **)error;
- (nullable NSDictionary *)resetSnapshot:(NSError **)error;
@end
NS_ASSUME_NONNULL_END
