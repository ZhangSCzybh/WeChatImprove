#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
FOUNDATION_EXPORT NSString *const CSMessageMergeEnabledKey;
FOUNDATION_EXPORT NSString *const CSMessageMergeScopeKey;
FOUNDATION_EXPORT NSString *const CSMessageMergeAvatarKey;
FOUNDATION_EXPORT NSString *const CSMessageMergeSpacingKey; // Legacy numeric preference, retained for migration.
FOUNDATION_EXPORT NSString *const CSMessageMergeSpacingModeKey;
typedef NS_ENUM(NSInteger, CSMessageSpacingMode) {
    CSMessageSpacingNormal = 0, CSMessageSpacingCompact = 1
};
FOUNDATION_EXPORT NSString *CSMessageSpacingModeTitle(CSMessageSpacingMode mode);
FOUNDATION_EXPORT NSString *const CSMessageMergeSettingsNotification;

@interface CSMessageMergeConfiguration : NSObject
@property(nonatomic, readonly) BOOL enabled;
@property(nonatomic, readonly) NSInteger scope; // 1 group, 2 private, 3 both
@property(nonatomic, readonly) NSInteger avatarPosition; // 1 last, 2 first
@property(nonatomic, readonly) double spacing;
@property(nonatomic, readonly) CSMessageSpacingMode spacingMode;
@property(nonatomic, readonly) BOOL reservesAvatarTime;
@property(nonatomic, readonly) BOOL hasLargeTimeLabel;
- (instancetype)initWithDefaults:(NSUserDefaults *)defaults;
- (BOOL)appliesToGroup:(BOOL)group;
@end

// No UIKit objects, message bodies or timestamp-based identity.
@interface CSMessageMergeItem : NSObject
@property(nonatomic, copy) NSString *account;
@property(nonatomic, copy) NSString *session;
@property(nonatomic, copy) NSString *sender;
@property(nonatomic, copy) NSString *identity;
@property(nonatomic) BOOL outgoing;
@property(nonatomic) BOOL eligible;
@end

typedef struct {
    BOOL joinsPrevious;
    BOOL joinsNext;
    BOOL hidesIdentity;
} CSMessageMergeDecision;

FOUNDATION_EXPORT BOOL CSMessageMergeCanJoin(CSMessageMergeItem * _Nullable a, CSMessageMergeItem * _Nullable b);
FOUNDATION_EXPORT CSMessageMergeDecision CSMessageMergeDecide(CSMessageMergeItem * _Nullable previous,
    CSMessageMergeItem *current, CSMessageMergeItem * _Nullable next, NSInteger avatarPosition);
FOUNDATION_EXPORT double CSMessageMergeSafeDelta(double requested, double nativeHeight, double verifiedSlack);
// First-pass external spacing budget. Content and identity sizes are never scaled.
FOUNDATION_EXPORT double CSMessageMergePlannedDelta(CSMessageSpacingMode mode, double nativeHeight,
    double contentHeight, double identityHeight, double nameHeight);
FOUNDATION_EXPORT long long CSMessageRevokeLinkID(NSString * _Nullable link);
FOUNDATION_EXPORT NSString *CSMessageEscapeMarkup(NSString *text);
FOUNDATION_EXPORT double CSMessageNavigationMargin(double visibleHeight, double messageHeight);
FOUNDATION_EXPORT double CSMessageNavigationOffset(double rowY, double rowHeight, double viewportHeight,
    double contentHeight, double topInset, double bottomInset);
NS_ASSUME_NONNULL_END
