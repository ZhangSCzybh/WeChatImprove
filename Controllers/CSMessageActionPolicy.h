#import "CSMessageActionPreferences.h"
#import "CSMessageActionContext.h"

NS_ASSUME_NONNULL_BEGIN
FOUNDATION_EXPORT CSMessageAction CSMessageActionValidated(NSInteger rawAction);
FOUNDATION_EXPORT CSMessageAction CSMessageActionForDirection(CSMessageActionSettings *settings,
    CSMessageActionDirection direction, BOOL outgoing);
// Settings gate only; caller must separately validate context, message capability and native permissions.
FOUNDATION_EXPORT BOOL CSMessageActionEntryAllows(CSMessageActionSettings *settings,
    CSMessageActionEntry entry, CSMessageAction action);
// Enhancement decision only: ordinary native onForward is allowed independently of these switches.
FOUNDATION_EXPORT BOOL CSMessageActionUsesVoiceEnhancement(CSMessageActionSettings *settings,
    CSMessageActionEntry entry, CSMessageAction action, NSUInteger messageType);
typedef NS_ENUM(NSInteger, CSMessageActionGesturePhase) {
    CSMessageActionGesturePhaseTracking, CSMessageActionGesturePhaseEnded,
    CSMessageActionGesturePhaseCancelled, CSMessageActionGesturePhaseFailed
};
FOUNDATION_EXPORT BOOL CSMessageActionGestureHasHorizontalIntent(double x, double y);
FOUNDATION_EXPORT double CSMessageActionGestureDistanceThreshold(double visibleWidth);
FOUNDATION_EXPORT BOOL CSMessageActionGestureIsArmed(double x, double velocityX,
    double visibleWidth, CSMessageActionDirection lockedDirection);
FOUNDATION_EXPORT BOOL CSMessageActionGestureShouldCommit(CSMessageActionGesturePhase phase,
    double x, double velocityX, double visibleWidth, CSMessageActionDirection lockedDirection,
    BOOL contextValid, BOOL entryStillEnabled);

typedef NS_ENUM(NSInteger, CSMessageActionSubmissionState) {
    CSMessageActionSubmissionStateUnregistered = -1,
    CSMessageActionSubmissionStatePreparing, CSMessageActionSubmissionStateWaitingForMedia,
    CSMessageActionSubmissionStateReady, CSMessageActionSubmissionStateSubmitting,
    CSMessageActionSubmissionStateAccepted, CSMessageActionSubmissionStateSucceeded,
    CSMessageActionSubmissionStateFailedBeforeAcceptance,
    CSMessageActionSubmissionStateFailedAfterAcceptance,
    CSMessageActionSubmissionStateUnknown, CSMessageActionSubmissionStateCancelled
};
// One ledger belongs to one bounded operation/batch, bound to its captured account epoch.
// The coordinator releases it after operation cleanup; never keep one for the whole account lifetime.
// Every operationID has exactly one ledger owner. Late callbacks look up that owner, never recreate it.
// Distinct user actions use distinct IDs. No global or persisted deduplication.
// Registration freezes the exact target set. A duplicate registration never resets state.
// All mutations are guarded; beginSubmission is the only transition to Submitting.
@interface CSMessageActionSubmissionLedger : NSObject
@property(nonatomic, copy, readonly) NSString *accountID;
@property(nonatomic, readonly) NSUInteger accountEpoch;
- (instancetype)initWithAccountID:(NSString *)accountID accountEpoch:(NSUInteger)accountEpoch;
- (BOOL)registerOperationID:(NSString *)operationID targetIDs:(NSArray<NSString *> *)targetIDs;
- (CSMessageActionSubmissionState)stateForOperationID:(NSString *)operationID targetID:(NSString *)targetID;
- (BOOL)transitionOperationID:(NSString *)operationID targetID:(NSString *)targetID
    toState:(CSMessageActionSubmissionState)state;
- (BOOL)beginSubmissionForOperationID:(NSString *)operationID targetID:(NSString *)targetID
    currentAccountID:(NSString *)accountID accountEpoch:(NSUInteger)accountEpoch;
// Cancels only Preparing/Waiting/Ready. Submitting/Accepted remain owned by the original sender.
- (void)cancelUnsubmittedOperations;
@end
NS_ASSUME_NONNULL_END
