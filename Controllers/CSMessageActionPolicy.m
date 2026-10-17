#import "CSMessageActionPolicy.h"
#include <math.h>

CSMessageAction CSMessageActionValidated(NSInteger rawAction) {
    return rawAction>=CSMessageActionDisabled && rawAction<=CSMessageActionRepeat ? (CSMessageAction)rawAction : CSMessageActionDisabled;
}
CSMessageAction CSMessageActionForDirection(CSMessageActionSettings *settings, CSMessageActionDirection direction, BOOL outgoing) {
    if (direction==CSMessageActionDirectionLeft) return CSMessageActionValidated(outgoing ? settings.leftSelfAction : settings.leftOtherAction);
    if (direction==CSMessageActionDirectionRight) return CSMessageActionValidated(outgoing ? settings.rightSelfAction : settings.rightOtherAction);
    return CSMessageActionDisabled;
}
BOOL CSMessageActionEntryAllows(CSMessageActionSettings *settings, CSMessageActionEntry entry, CSMessageAction action) {
    if (CSMessageActionValidated(action)==CSMessageActionDisabled) return NO;
    switch (entry) {
        case CSMessageActionEntryGesture: return settings.gestureEnabled;
        case CSMessageActionEntryMenuRepeat: return settings.repeatEnabled && action==CSMessageActionRepeat;
        case CSMessageActionEntryMenuVoiceForward: return settings.voiceForwardEnabled && action==CSMessageActionForward;
        case CSMessageActionEntryNativeForward: return action==CSMessageActionForward;
    }
    return NO;
}
BOOL CSMessageActionUsesVoiceEnhancement(CSMessageActionSettings *settings, CSMessageActionEntry entry, CSMessageAction action, NSUInteger messageType) {
    return messageType==34 && action==CSMessageActionForward && settings.voiceForwardEnabled &&
        CSMessageActionEntryAllows(settings,entry,action);
}
BOOL CSMessageActionGestureHasHorizontalIntent(double x, double y) {
    return isfinite(x) && isfinite(y) && fabs(x)>1.5*fabs(y);
}
double CSMessageActionGestureDistanceThreshold(double visibleWidth) {
    return isfinite(visibleWidth) && visibleWidth>0 ? fmax(visibleWidth*.2,60) : INFINITY;
}
BOOL CSMessageActionGestureIsArmed(double x, double velocityX, double visibleWidth, CSMessageActionDirection lockedDirection) {
    if (!isfinite(x) || !isfinite(velocityX) || !isfinite(visibleWidth) || visibleWidth<=0 ||
        (lockedDirection!=CSMessageActionDirectionLeft && lockedDirection!=CSMessageActionDirectionRight)) return NO;
    double distance=x*lockedDirection, velocity=velocityX*lockedDirection;
    return distance>=CSMessageActionGestureDistanceThreshold(visibleWidth) || (distance>=12 && velocity>=600);
}
BOOL CSMessageActionGestureShouldCommit(CSMessageActionGesturePhase phase, double x, double velocityX,
    double visibleWidth, CSMessageActionDirection lockedDirection, BOOL contextValid, BOOL entryStillEnabled) {
    return phase==CSMessageActionGesturePhaseEnded && contextValid && entryStillEnabled &&
        CSMessageActionGestureIsArmed(x,velocityX,visibleWidth,lockedDirection);
}

@interface CSMessageActionSubmissionLedger () {
    NSMutableDictionary<NSString *,NSMutableDictionary<NSString *,NSNumber *> *> *_operations;
}
@end
@implementation CSMessageActionSubmissionLedger
- (instancetype)initWithAccountID:(NSString *)accountID accountEpoch:(NSUInteger)accountEpoch {
    if ((self=[super init])) { _accountID=[accountID copy]; _accountEpoch=accountEpoch; _operations=[NSMutableDictionary dictionary]; }
    return self;
}
- (BOOL)registerOperationID:(NSString *)operationID targetIDs:(NSArray<NSString *> *)targetIDs {
    @synchronized(self) {
        if (!_accountID.length || !_accountEpoch || ![operationID isKindOfClass:NSString.class] || !operationID.length ||
            _operations[operationID] || ![targetIDs isKindOfClass:NSArray.class] || !targetIDs.count) return NO;
        NSMutableDictionary *targets=[NSMutableDictionary dictionaryWithCapacity:targetIDs.count];
        for (NSString *target in targetIDs) {
            if (![target isKindOfClass:NSString.class] || !target.length || targets[target]) return NO;
            targets[[target copy]]=@(CSMessageActionSubmissionStatePreparing);
        }
        _operations[[operationID copy]]=targets;
        return YES;
    }
}
- (CSMessageActionSubmissionState)stateForOperationID:(NSString *)operationID targetID:(NSString *)targetID {
    @synchronized(self) {
        NSNumber *state=_operations[operationID][targetID];
        return state ? state.integerValue : CSMessageActionSubmissionStateUnregistered;
    }
}
- (BOOL)transitionOperationID:(NSString *)operationID targetID:(NSString *)targetID toState:(CSMessageActionSubmissionState)next {
    @synchronized(self) {
        CSMessageActionSubmissionState previous=[self stateForOperationID:operationID targetID:targetID];
        BOOL valid=NO;
        switch (previous) {
            case CSMessageActionSubmissionStatePreparing:
                valid=next==CSMessageActionSubmissionStateWaitingForMedia || next==CSMessageActionSubmissionStateReady ||
                    next==CSMessageActionSubmissionStateFailedBeforeAcceptance || next==CSMessageActionSubmissionStateCancelled; break;
            case CSMessageActionSubmissionStateWaitingForMedia:
                valid=next==CSMessageActionSubmissionStateReady || next==CSMessageActionSubmissionStateFailedBeforeAcceptance ||
                    next==CSMessageActionSubmissionStateCancelled; break;
            case CSMessageActionSubmissionStateReady:
                valid=next==CSMessageActionSubmissionStateFailedBeforeAcceptance || next==CSMessageActionSubmissionStateCancelled; break;
            case CSMessageActionSubmissionStateSubmitting:
                valid=next==CSMessageActionSubmissionStateAccepted || next==CSMessageActionSubmissionStateFailedBeforeAcceptance ||
                    next==CSMessageActionSubmissionStateUnknown; break;
            case CSMessageActionSubmissionStateAccepted:
                valid=next==CSMessageActionSubmissionStateSucceeded || next==CSMessageActionSubmissionStateFailedAfterAcceptance ||
                    next==CSMessageActionSubmissionStateUnknown; break;
            default: break; // Terminal states and unregistered targets never reopen or re-submit.
        }
        if (valid) _operations[operationID][targetID]=@(next);
        return valid;
    }
}
- (BOOL)beginSubmissionForOperationID:(NSString *)operationID targetID:(NSString *)targetID
    currentAccountID:(NSString *)accountID accountEpoch:(NSUInteger)accountEpoch {
    @synchronized(self) {
        if (!_accountID.length || !accountEpoch || accountEpoch!=_accountEpoch || ![_accountID isEqualToString:accountID] ||
            [self stateForOperationID:operationID targetID:targetID]!=CSMessageActionSubmissionStateReady) return NO;
        _operations[operationID][targetID]=@(CSMessageActionSubmissionStateSubmitting);
        return YES;
    }
}
- (void)cancelUnsubmittedOperations {
    @synchronized(self) {
        for (NSString *operationID in _operations) for (NSString *target in _operations[operationID].allKeys) {
            CSMessageActionSubmissionState state=[self stateForOperationID:operationID targetID:target];
            if (state==CSMessageActionSubmissionStatePreparing || state==CSMessageActionSubmissionStateWaitingForMedia || state==CSMessageActionSubmissionStateReady)
                _operations[operationID][target]=@(CSMessageActionSubmissionStateCancelled);
        }
    }
}
@end
