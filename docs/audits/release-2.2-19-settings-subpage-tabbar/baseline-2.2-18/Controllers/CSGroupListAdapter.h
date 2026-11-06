#import <UIKit/UIKit.h>
#import "CSGroupIndexScope.h"
#import "CSGroupRefreshState.h"
NS_ASSUME_NONNULL_BEGIN
// BEGIN Chat tab badge decision
@class CSGroupBadge, CSCloseFriendSnapshot;
/// nil means native output; a decision without a badge is temporarily unavailable.
@interface CSGroupTabBadgeDecision : NSObject
@property (nonatomic, copy, readonly) NSString *accountID;
@property (nonatomic, readonly) NSUInteger epoch, policyRevision;
@property (nonatomic, readonly) BOOL boundary;
@property (nonatomic, strong, readonly, nullable) CSGroupBadge *badge;
/// Only a verified result identifies the native main-list owner it came from.
@property (nonatomic, weak, readonly, nullable) id sourceController;
@property (nonatomic, readonly) NSUInteger sourceRevision;
+ (instancetype)decisionWithPolicy:(CSCloseFriendSnapshot *)policy epoch:(NSUInteger)epoch
                         boundary:(BOOL)boundary badge:(nullable CSGroupBadge *)badge;
+ (instancetype)decisionWithPolicy:(CSCloseFriendSnapshot *)policy epoch:(NSUInteger)epoch
                         boundary:(BOOL)boundary badge:(nullable CSGroupBadge *)badge sourceController:(nullable id)controller sourceRevision:(NSUInteger)revision;
@end
FOUNDATION_EXPORT NSNotificationName const CSGroupTabBadgeSourceDidRefreshNotification;
// END Chat tab badge decision
@interface CSGroupListAdapter : NSObject
@property (nonatomic, weak, readonly) UITableView *table;
@property (nonatomic, readonly, getter=isActive) BOOL active;
@property (nonatomic, readonly) BOOL publishing;
/// Main list uses one native coordinate space; ChatBox retains its own projection.
@property (nonatomic, readonly) BOOL usesNativeSessionModel;
@property (nonatomic, readonly) BOOL updatingHeader;
@property (atomic, readonly) NSUInteger changeDepth;
+ (nullable instancetype)adapterForTable:(id)table;
+ (nullable instancetype)adapterForController:(id)controller;
+ (void)attachToController:(id)controller;
/// Suspend derived UI work while the native main-frame owner is offscreen.
+ (void)setPresentationSuspended:(BOOL)suspended forController:(id)controller;
/// Restore the departure height after the native appearance/layout finishes.
+ (void)finishPresentationReturnForController:(id)controller;
+ (void)layoutForController:(id)controller;
/// Validate existing cells before a covering miniapp starts revealing the list.
+ (void)prepareForListVisibility;
+ (void)settingsChanged;
/// Display-only total for identity-silent subjects; nil means native policy, zero means
/// privacy owns the badge but no current validated main-list source is available.
+ (nullable NSNumber *)closeFriendAlertBadgeCount;
/// Tab-only result. Notification and app-icon consumers retain their existing contract.
+ (nullable CSGroupTabBadgeDecision *)closeFriendTabBadgeDecision;
/// Native restoration can request a current count/dot source without filtering it.
+ (nullable CSGroupTabBadgeDecision *)closeFriendTabBadgeDecisionForPublication:(BOOL)includeNative;
/// A tab publisher must use the source belonging to its actual chat-page root.
+ (nullable CSGroupTabBadgeDecision *)closeFriendTabBadgeDecisionForController:(nullable id)controller includeNative:(BOOL)includeNative;
+ (void)closeFriendPolicyChanged:(NSNotification *)notification;
/// Returns YES when privacy owns navigation, including no eligible destination.
- (BOOL)navigatePrivateSessionsForward:(BOOL)forward unreadOnly:(BOOL)unreadOnly;
+ (void)applicationActivityChanged:(NSNotification *)notification;
+ (nullable NSString *)groupTitleForTitleView:(id)titleView;
+ (void)recordNativeTitle:(nullable NSString *)title status:(unsigned int)status forTitleView:(id)titleView;
/// A user positioning command supersedes older heights and row anchors.
- (void)beginUserScrolling;
/// Native list dragging excludes an admitted horizontal group gesture.
- (void)beginUserDragging;
- (void)endSwipeEditing;
/// Wake pending work after the host custom menu handles a pan or visibility change.
- (void)nativeMenuDidChange;
/// Restrict the native row pan using the original touch position in the table.
- (BOOL)nativeMenuGesture:(UIGestureRecognizer *)gesture inCell:(UIView *)cell shouldReceiveTouch:(UITouch *)touch;
- (void)layout;
- (void)performSessionListLayout:(void (^)(void))layout;
- (void)refresh;
- (void)bindNativeCell:(UITableViewCell *)cell atPath:(NSIndexPath *)path;
- (void)requestRefresh;
- (void)beginNativeChange;
- (void)beginNativeChangeOfKind:(CSGroupChangeKind)kind;
/// nil means some changed identities are unknown; publication keeps full
/// metadata validation and broader visible-content refresh for that batch.
- (void)beginNativeChangeOfKind:(CSGroupChangeKind)kind changedUserNames:(nullable NSSet<NSString *> *)names;
- (void)endNativeChange;
/// Passive badge-source reads merge 80ms after the latest notification, at most
/// 250ms from the first; privacy, lifecycle and native restoration stay urgent.
- (void)endNativeChangeCoalesced:(BOOL)coalesced;
- (void)performNativeBatch:(void (^ _Nullable)(void))updates completion:(void (^ _Nullable)(BOOL))completion;
- (void)performInNativePresentation:(void (^)(void))action;
- (nullable id)proxyForTarget:(nullable id)target role:(NSUInteger)role;
- (nullable NSIndexPath *)nativePath:(nullable NSIndexPath *)displayPath;
- (nullable NSIndexPath *)displayPath:(nullable NSIndexPath *)nativePath;
- (NSArray<NSIndexPath *> *)nativePaths:(nullable NSArray<NSIndexPath *> *)displayPaths;
- (NSInteger)nativeRowCount:(NSInteger)section;
- (NSInteger)nativeSectionCount;
- (nullable UIView *)nativeTableHeaderView;
- (void)setNativeTableHeaderView:(nullable UIView *)header;
/// Prepare native search while preserving the shortcut header during its transition.
- (void)prepareForNativeSearch;
- (nullable NSDictionary *)captureNativeEditingContextAtPath:(NSIndexPath *)path;
- (BOOL)performNativeEditingContext:(NSDictionary *)context action:(void (^)(NSIndexPath *currentPath))action;
@end
FOUNDATION_EXPORT BOOL CSGroupCardPosition(UITableView *table, NSIndexPath *path, BOOL *first, BOOL *last);
NS_ASSUME_NONNULL_END
