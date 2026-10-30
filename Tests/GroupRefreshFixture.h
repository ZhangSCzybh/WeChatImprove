#import "../Controllers/CSGroupRefreshState.h"
static BOOL CSGroupAppInactive;
static BOOL CSGroupApplicationActive(void) { return !CSGroupAppInactive; }
#define UIApplicationDidBecomeActiveNotification @"UIApplicationDidBecomeActiveNotification"
#define UIApplicationDidEnterBackgroundNotification @"UIApplicationDidEnterBackgroundNotification"
@interface NSObject (GroupCacheFixture)
- (void)discardComputationCache;
- (void)refreshAppearance;
@end
#define CS_GROUP_REFRESH_TEST_PROPERTIES \
@property(nonatomic) CSGroupChangeKind pendingChanges; \
@property(nonatomic) BOOL recoveryPending,scheduledInteraction,scheduledRecovery,appearanceDirty; \
@property(nonatomic) NSUInteger recoveryAttempts,recoveryRevision,interactionAttempts; \
@property(nonatomic,copy) NSString *recoveryAccount; \
@property(nonatomic) NSTimeInterval interactionDeadline; \
@property(nonatomic) NSTimeInterval pendingRefreshDeadline,scheduledRefreshDeadline; \
@property(nonatomic) BOOL pendingImmediateRefresh; \
@property(nonatomic,strong) NSMutableSet<NSString *> *pendingContentUserNames; \
@property(nonatomic) BOOL pendingContentUnattributed; \
@property(nonatomic) BOOL publicationNeedsFullReload; \
@property(nonatomic,copy) NSSet<NSString *> *nativeChangeUserNames; \
@property(nonatomic,strong) NSMutableArray *nativeChangeIdentityStack; \
- (void)recordRefreshEvent:(NSString *)event delay:(NSTimeInterval)delay; \
- (void)scheduleRefresh; \
- (void)requestRecovery; \
- (void)cancelScheduledRefresh;
