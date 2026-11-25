#import <Foundation/Foundation.h>
#import "CSCloseFriendPolicy.h"
#import "CSGroupRefreshState.h"

NS_ASSUME_NONNULL_BEGIN
@class CSGroupNativeModelResult, CSGroupRow;

/// Sent on main only when a new native source/boundary revision has finished.
/// Applying an unchanged group from a UI refresh does not emit this notification.
FOUNDATION_EXPORT NSNotificationName const CSGroupNativeSessionModelDidChangeNotification;

/// Owns a complete native baseline and applies group membership to MainSessionMgr.
/// All host model reads and writes happen synchronously on the main thread.
@interface CSGroupNativeSessionCoordinator : NSObject
+ (instancetype)sharedCoordinator;
@property(nonatomic, strong, readonly, nullable) CSGroupNativeModelResult *model;
@property(nonatomic, readonly) BOOL applied;
/// Unavailable account/privacy state or invalid native data is kept closed.
@property(nonatomic, readonly) BOOL boundary;
/// Sticky for this process once an unsupported host representation is detected.
/// The existing projection adapter owns presentation after the complete native
/// source has been restored; account/privacy uncertainty never enables it.
@property(nonatomic, readonly) BOOL compatibilityFallback;
/// Restores any filtered native arrays before giving presentation back to the
/// compatibility adapter. Does nothing unsafe while account/policy is unknown.
- (void)useCompatibilityFallback;
@property(nonatomic, readonly) NSUInteger revision;
@property(nonatomic, copy, readonly, nullable) NSString *accountID;
@property(nonatomic, readonly) NSUInteger epoch;
/// Temporary All presentation for native navigation/search; preferences stay intact.
@property(nonatomic) BOOL nativePresentation;
/// A main-controller-owned, temporary native group selection. Preferences are
/// unchanged until the caller separately commits the user's selection. The
/// caller must cover the real table before beginning, refresh its native rows,
/// and restore/reload the committed group before removing a cancelled cover.
/// All methods are main-thread-only. Source/account/privacy changes invalidate
/// the preview; callers must discard both copied pages when validity fails.
@property(nonatomic, copy, readonly, nullable) NSString *pagePreviewTabID;
- (BOOL)beginPagePreviewForTabID:(NSString *)tabID owner:(id)owner;
/// Fast gesture-time token check. Reads saved coordinator/configuration state
/// and the current privacy snapshot, without host identity or service getters.
/// Use the full check below before accepting captured pixels or committing.
- (BOOL)pagePreviewTokenIsValidForOwner:(id)owner;
- (BOOL)pagePreviewIsValidForOwner:(id)owner;
/// Clears the override before synchronously restoring current preferences.
/// Commit callers first write and verify preferences, then end the preview.
- (void)endPagePreviewForOwner:(id)owner;
- (void)setMainController:(nullable id)controller;
- (void)refreshFromPreferences;
- (void)invalidateNativeData;
/// Named notifications are hints only. Reordering, identity/configuration or
/// privacy changes still require the complete validation/build path.
- (void)performChangeForUserNames:(nullable NSSet<NSString *> *)names
                           kind:(CSGroupChangeKind)kind original:(void (^)(void))original;
- (void)performNativeRebuildForManager:(id)manager original:(void (^)(void))original;
/// Source mutations temporarily receive the complete baseline, then rebuild it.
- (void)performNativeMutationForManager:(id)manager original:(void (^)(void))original;
/// Runs a synchronous read of the complete account's native presentation source,
/// filtered by the requested Session or Forward privacy surface rather than the
/// selected group. The main-list presentation remains closed during the scope.
/// The block must finish consuming native enumerators before returning; it must
/// not retain a lazy enumerator that reads the shared manager later. Host
/// exceptions propagate after restoring the selected group. Returns NO when the
/// source/policy is unavailable, another native transaction is active, or the
/// account/policy changes during the read; callers must discard that read result.
/// If no supported manager has been taken over, preserves the host's original
/// full-source read, subject to the same stable account/privacy checks. Existing
/// caller-side filtering remains responsible for that native fallback path.
- (BOOL)performWithCompleteSourceForSurface:(CSCloseFriendSurface)surface original:(void (^)(void))original;
- (void)nativeManagerWillClear:(nullable id)manager;
- (long long)foldSessionCountWithNativeCount:(long long)nativeCount;
/// Returns immutable display metadata only after rechecking native identity.
- (nullable CSGroupRow *)rowForSession:(nullable id)session path:(NSIndexPath *)path;
@end
NS_ASSUME_NONNULL_END
