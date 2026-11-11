#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
FOUNDATION_EXPORT NSNotificationName const CSGroupChatConfigurationDidChange;
FOUNDATION_EXPORT NSDictionary *CSGroupChatDefaultConfiguration(void);
FOUNDATION_EXPORT BOOL CSGroupChatValidateConfiguration(NSDictionary *configuration);
@interface CSGroupChatManager : NSObject
+ (instancetype)sharedManager;
@property(nonatomic,copy,readonly) NSString *accountID;
@property(nonatomic,readonly) NSUInteger accountEpoch;
@property(nonatomic,readonly) NSUInteger configurationGeneration;
@property(nonatomic,copy,readonly) NSDictionary *configuration;
@property(nonatomic,readonly) BOOL ready;
@property(nonatomic,copy,readonly) NSString *statusText;
- (void)start;
- (void)refresh;
// Main-thread bridge to the shared background execution manager.
- (void)configureBackgroundDemand:(void (^)(BOOL requested))demand;
// Main-thread configuration transaction; unknown/invalid keys are rejected.
- (void)updateConfiguration:(NSDictionary *)changes completion:(void (^)(BOOL success, NSError *_Nullable error))completion;
// Called after native processing with an immutable, response-validated snapshot.
- (void)receiveMemberSnapshot:(NSDictionary *)snapshot epoch:(NSUInteger)epoch;
- (void)nativeContactChanged:(NSString *)roomID epoch:(NSUInteger)epoch;
// A remote native system message is only a hint to fetch a full member list.
- (void)nativeSystemMessageInRoom:(NSString *)roomID epoch:(NSUInteger)epoch;
// A successful native removal response supplies reason evidence; only a full member delta posts notices.
- (void)nativeMemberRemovals:(NSArray<NSString *> *)members inRoom:(NSString *)room epoch:(NSUInteger)epoch;
- (void)requestBaselineForRoom:(NSString *)roomID;
@end
NS_ASSUME_NONNULL_END
