# Task 1 report: shared message action core

Date: 2026-10-17. Status: implementation complete for this task; not installed, not a claim of completed message-actions migration.

## Scope and environment

Worktree: `/Users/zhangshichao/.codex/worktrees/message-actions-refactor/WeChatImprove`.
Branch: `codex/message-actions-refactor-1.7-17`. Starting commit: `7ffc8e2d` (`docs: record approved unified message actions refactor plan`).

Implemented only shared Foundation contracts, settings snapshots/cache, read-only source-context capture, pure entry/direction/gesture policy, and guarded per-target submission state. Three settings controllers now share keys, persisted enum and Darwin notification constants; their UI, stored values, defaults and notification channels retain their existing semantics. Operational Hooks were not changed. Makefile already discovers `Controllers/*.m`, so no build-list modification was necessary.

No service was started/restarted, no live WeChat or device accessed, and no original checkout, preferences, user database, `.theos`, packages, or package metadata were changed. Tests use a unique `CSMessageActionCoreTests.<UUID>` defaults suite and remove that suite. Syntax checks are read-only and temporary host binaries/mutation copies are outside the checkout and removed. Other agents' untracked `docs/evidence/message-actions-*` files are excluded from this commit.

The existing approved design and task brief supplied the architecture and authorization; brainstorming skill was read to confirm scope, without reopening approved design decisions.

## Behavior and contracts

- Action values remain exactly Disabled=0, Quote=1, Delete=2, Forward=3, Favorite=4, Revoke=5, Repeat=6. All seven existing keys and three Darwin names are exported once. Missing toggles default false; missing actions default zero. Unknown action values remain stored and visible in the immutable snapshot, while pure policy interprets them as Disabled.
- Gesture entry gates only on the gesture switch and a valid non-disabled action. Menu repeat gates only on repeat plus Repeat action. Menu voice forward gates only on voice-forward plus Forward action. Native Forward remains eligible independently of all three switches. Voice enhancement additionally requires voice type 34 and the voice-forward switch; gesture/menu repeat is never redirected into enhancement.
- Preferences read only seven related keys. Snapshots are immutable/read-only, begin at version 1, and advance only when effective related values differ. `requestRefresh` coalesces on the main queue. Actual Darwin callbacks, `NSUserDefaultsDidChangeNotification`, and UIKit's activation notification name bridge into that queue; the local settings-changed notification is a separate Foundation channel, emitted on main with the preferences instance as object. Import/reset is covered by activation refresh. No eager global initializer or account-service cache is introduced.
- Context capture fails closed without an explicit nonempty account and nonzero epoch, a resolvable source, or a conversation that agrees with the wrap. Capture and source resolution reject background-thread access to native mutable objects. The native sender method is signature checked, including its object argument and BOOL return; an authoritative NO is never overwritten by a sender-status fallback. With no supported sender method, exact from/to account identity supplies direction; contradictory/unknown identity fails closed.
- A nil `getCurrentMessageWrap` continues through viewModel/messageWrap and bounded parentModel fallback. Segmented models resolve the complete parent source; cycles/overlong parent chains fail closed. Object, BOOL and integer getters dispatch through checked concrete ABI and no KVC. Exceptions from getters produce no side effects.
- Persistent identity includes account, chat and server/local message IDs with length-delimited scope. `matchesSourceContext:` accepts shared local ID during promotion, then shared server ID; conflicting known server IDs fail. A transition that exposes neither shared ID cannot be guessed. No-ID identity uses a wrapper-associated random token plus nonzero caller binding generation, and only matches the same retained live wrap and generation. No message text/time identity exists. Cell/controller are weak; sourceWrap is read-only and retained only for the bounded operation lifetime.
- Gesture policy keeps 1.5 horizontal intent, distance `max(width*0.2,60)`, and velocity 600. Fast commit also requires displacement >=12pt in locked direction and same-sign velocity. Only Ended can commit; invalid context, disabled entry, Cancelled, Failed, reversed displacement, and short fast swipes cannot. The 12pt parameter remains awaiting device validation.
- The ledger atomically registers an immutable exact target set for each operationID; duplicate registration never resets it. Only Ready can claim submission; 100 concurrent callback attempts yield one owner. Distinct operationIDs for the same message/chat remain independent. Direct transitions into Submitting are forbidden. Accepted requires an explicit evidence-driven transition; no void return, arbitrary local ID, call completion or timeout automatically means success. Succeeded is possible only after Accepted. Failure-before-acceptance, failure-after-acceptance, Unknown and Cancelled are terminal; no reopening/retry occurs in this core.
- Ledger lifetime is explicitly one bounded operation/batch, not an account-lifetime registry. Each operationID has one retained ledger owner; late callbacks look up that owner and never recreate it. The coordinator must release it with operation cleanup and issue fresh IDs for new user actions. This is in-memory plugin ownership, not server exactly-once or restart deduplication. FailedBeforeAcceptance may motivate a separately owned new retry operation only after the caller proves no prior side effect; this core never infers that proof.

## Validation evidence

All commands below ran in the isolated worktree. Host runner compiles the three new `.m` files and behavior tests with ARC, blocks, Foundation, `-Wall -Wextra -Werror`; it builds into mktemp and cleans up.

### Red before implementation

After writing headers and behavior tests, before implementation files:

```text
$ bash Tests/verify-message-actions-core.sh
clang: error: no such file or directory: '.../Controllers/CSMessageActionPreferences.m'
clang: error: no such file or directory: '.../Controllers/CSMessageActionContext.m'
clang: error: no such file or directory: '.../Controllers/CSMessageActionPolicy.m'
(exit 1)
```

The first compiling implementation passed 657 checks. Extending it to the full legal/forbidden transition matrix and multi-target cancellation found a real behavior failure:

```text
$ bash Tests/verify-message-actions-core.sh
*** Terminating app due to uncaught exception 'NSGenericException', reason:
'*** Collection <__NSDictionaryM: ...> was mutated while being enumerated.'
-[CSMessageActionSubmissionLedger cancelUnsubmittedOperations]
TestAllSubmissionTransitions
Tests/verify-message-actions-core.sh: line 12: ... Abort trap: 6
(exit 134)
```

Fix: enumerate the target dictionary's `allKeys` snapshot before replacing per-target state values. This produced 1,358 passing checks. Added actual domain replacement/reset and background access checks afterward. The background check initially used `dispatch_sync`, which can execute on the calling thread; the test harness was corrected to dispatch_group_async plus a joined group, proving real background rejection.

### Final green

```text
$ bash Tests/verify-message-actions-core.sh
PASS: 1362 message action core checks (isolated defaults suite; no native sends)
(exit 0)
```

Coverage: all eight combinations of three toggles across all four entries and action values; four swipe slots; persisted enum/key behavior and unknown values; native forward vs enhancement; received/sent/group source identity; nil-current and parent fallback; signature mismatch, cycles, account/epoch/chat invalidity, local/server promotion, weak UI lifetime, bounded object binding; Ended/Cancelled/Failed/short/reverse/nonfinite gesture inputs; every legal/forbidden submission edge and terminal late event; cancellation of multiple targets; per-operation/per-target independence and concurrent ownership; related-key cache, notification coalescing/main delivery, real Darwin and defaults notification bridges, activation/import/reset, and zero defaults reads during 1,000 cached policy calls.

### Isolated mutation red checks

A temporary copy of only the three core modules, headers, host tests and runner was made per mutation with Python `tempfile.TemporaryDirectory`, `shutil.copy2` and `subprocess.run(['bash', copied_runner], capture_output=True, text=True)`. Each case replaced exactly one matching source expression, asserted nonzero exit plus `FAIL line`, and deleted the copy. Production sources were untouched. Changes and actual outputs:

```text
phase==Ended -> (phase==Ended || phase==Cancelled)
EXPECTED RED cancelled-can-commit: exit 1; FAIL line 115: !CSMessageActionGestureShouldCommit(phase.integerValue,70*direction,700*direction,300,direction,YES,YES)

case Gesture: return settings.gestureEnabled -> return settings.gestureEnabled && settings.repeatEnabled
EXPECTED RED gesture-repeat-depends-on-menu: exit 1; FAIL line 64: CSMessageActionEntryAllows(s,CSMessageActionEntryGesture,CSMessageActionRepeat)

beginSubmission sets Submitting -> sets Ready
EXPECTED RED duplicate-submission-owner: exit 1; FAIL line 193: !Begin(l,@"op1",@"chat")

distance>=12 && velocity>=600 -> distance>=0 && velocity>=600
EXPECTED RED short-fast-swipe: exit 1; FAIL line 109: !CSMessageActionGestureIsArmed(11.99*direction,700*direction,300,direction)
PASS: all 4 isolated policy mutations rejected by behavior tests
(exit 0 for the mutation driver)
```

An initial Cancelled mutation removed all usage of `phase` and was rejected at compile time by `-Wunused-parameter`; the final mutation retained usage so the recorded red is a behavior assertion.

### Target syntax/ABI compilation

Installed SDK resolved via `xcrun --sdk iphoneos --show-sdk-path`:
`/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS27.1.sdk`.

```sh
xcrun --sdk iphoneos clang -target arm64-apple-ios15.0 -fobjc-arc -fblocks -Wall -Wextra -Werror -fsyntax-only -IControllers Controllers/CSMessageActionPreferences.m Controllers/CSMessageActionContext.m Controllers/CSMessageActionPolicy.m
xcrun --sdk iphoneos clang -target arm64e-apple-ios15.0 -fobjc-arc -fblocks -Wall -Wextra -Werror -fsyntax-only -IControllers Controllers/CSMessageActionPreferences.m Controllers/CSMessageActionContext.m Controllers/CSMessageActionPolicy.m
xcrun --sdk iphoneos clang -target arm64-apple-ios15.0 -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter -fsyntax-only -IControllers -IHeaders Controllers/CSMessageGestureSettingsViewController.m Controllers/CSRepeatSettingsViewController.m Controllers/CSVoiceForwardSettingsViewController.m
```

All three exited 0 with no output. A prior combined strict syntax invocation found the settings controller's existing unused `alertAction` block parameter. Only settings syntax checking suppresses that inherited unused-parameter warning; core checks retain all warnings as errors. No Theos build/package command ran. `git diff --check` passed with no output.

## Downstream integration requirements and limitations

1. This task supplies settings eligibility, not native message-type permissions or host availability. Adapters must AND it with real capabilities/context revalidation; no operational hook has migrated yet.
2. The coordinator must generate fresh operationIDs per explicit user action, retain exactly one ledger per bounded operation/batch, freeze route and exact targets, and never create a replacement ledger on repeated callbacks. Account changes cancel unsubmitted old operations and pass the newly current accountID/epoch into the guarded begin method. No global current-account service is fetched here.
3. Capture contexts on main at binding/entry time. Pass the current binding generation and account epoch; on revalidation capture a new context and compare IDs plus binding validity. Persistent identity alone does not prove a reused cell still displays the message. An unbridged local-only -> server-only change fails closed; acquire a promoted context while both IDs are available when the host permits. The caller must separately validate action permissions and source existence at side effect time.
4. Settings observers are lazy and live only while the preferences instance is retained. Adapters should consume the snapshot version and local notification. They must cancel tracking on relevant settings changes and preserve committed request snapshots. Activation refresh intentionally rescans only related keys to support restore/reset that bypass feature-specific Darwin posts.
5. Ledger transitions express caller-provided evidence; this layer cannot validate a private API contract or tell whether a native call mutated data. Unknown is terminal and never replays. Native forward ownership and voice enhancement selection still require the separately researched native contracts.
6. Host tests do not validate UIKit arbitration, actual WeChat selectors/data roles, device latency, media delivery, account-switch native ordering, existing menus, or 12pt usability. iOS syntax compilation is not linked packaging or real-device acceptance. This task does not claim deployment or changed live behavior.

## Exact public interfaces for downstream tasks

The following are the complete delivered public headers (authoritative source remains the committed header files).

### CSMessageActionPreferences.h

```objc
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
// These values are persisted. Never reorder or renumber.
typedef NS_ENUM(NSInteger, CSMessageAction) {
    CSMessageActionDisabled = 0, CSMessageActionQuote = 1, CSMessageActionDelete = 2,
    CSMessageActionForward = 3, CSMessageActionFavorite = 4, CSMessageActionRevoke = 5,
    CSMessageActionRepeat = 6
};
typedef NS_ENUM(NSInteger, CSMessageActionEntry) {
    CSMessageActionEntryGesture, CSMessageActionEntryMenuRepeat,
    CSMessageActionEntryMenuVoiceForward, CSMessageActionEntryNativeForward
};
typedef NS_ENUM(NSInteger, CSMessageActionDirection) {
    CSMessageActionDirectionNone = 0, CSMessageActionDirectionLeft = -1,
    CSMessageActionDirectionRight = 1
};
FOUNDATION_EXPORT NSString *const CSMessageActionGestureEnabledKey;
FOUNDATION_EXPORT NSString *const CSMessageActionRepeatEnabledKey;
FOUNDATION_EXPORT NSString *const CSMessageActionVoiceForwardEnabledKey;
FOUNDATION_EXPORT NSString *const CSMessageActionLeftOtherKey;
FOUNDATION_EXPORT NSString *const CSMessageActionLeftSelfKey;
FOUNDATION_EXPORT NSString *const CSMessageActionRightOtherKey;
FOUNDATION_EXPORT NSString *const CSMessageActionRightSelfKey;
// Local Foundation notification; object is the preferences instance. Delivered on main.
FOUNDATION_EXPORT NSNotificationName const CSMessageActionSettingsDidChangeNotification;
FOUNDATION_EXPORT NSString *const CSMessageActionGestureDarwinNotification;
FOUNDATION_EXPORT NSString *const CSMessageActionRepeatDarwinNotification;
FOUNDATION_EXPORT NSString *const CSMessageActionVoiceForwardDarwinNotification;

@interface CSMessageActionSettings : NSObject
@property(nonatomic, readonly) BOOL gestureEnabled;
@property(nonatomic, readonly) BOOL repeatEnabled;
@property(nonatomic, readonly) BOOL voiceForwardEnabled;
@property(nonatomic, readonly) NSUInteger version;
// Raw values remain available; unknown values are interpreted as Disabled only by policy.
@property(nonatomic, readonly) NSInteger leftOtherAction;
@property(nonatomic, readonly) NSInteger leftSelfAction;
@property(nonatomic, readonly) NSInteger rightOtherAction;
@property(nonatomic, readonly) NSInteger rightSelfAction;
- (instancetype)initWithDefaults:(NSUserDefaults *)defaults version:(NSUInteger)version;
@end

@interface CSMessageActionPreferences : NSObject
@property(nonatomic, strong, readonly) CSMessageActionSettings *snapshot;
+ (instancetype)sharedPreferences;
// Inject a unique defaults suite for host tests. Does not write defaults or register defaults.
- (instancetype)initWithDefaults:(NSUserDefaults *)defaults;
// Coalesced asynchronous main-thread refresh. Also observed on defaults/Darwin/app activation.
- (void)requestRefresh;
@end
NS_ASSUME_NONNULL_END
```

### CSMessageActionContext.h

```objc
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
// Signature-checked object dispatch; no KVC and no object/BOOL ABI confusion.
// ResolveSourceWrap and context capture fail closed off main (native mutable objects are UI owned).
FOUNDATION_EXPORT id _Nullable CSMessageActionObjectGetter(id _Nullable object, SEL selector);
FOUNDATION_EXPORT id _Nullable CSMessageActionResolveSourceWrap(id _Nullable cell);

// Capture/revalidate on main. Source wrap is retained read-only for the operation's bounded lifetime.
// Account identity/epoch must come from the caller's current account lifecycle, never a cached service.
@interface CSMessageActionContext : NSObject
@property(nonatomic, copy, readonly) NSString *accountID;
@property(nonatomic, readonly) NSUInteger accountEpoch;
@property(nonatomic, copy, readonly) NSString *sourceConversationID;
@property(nonatomic, copy, readonly) NSString *stableMessageIdentity;
@property(nonatomic, strong, readonly) id sourceWrap;
@property(nonatomic, weak, readonly, nullable) id cell;
@property(nonatomic, weak, readonly, nullable) id controller;
@property(nonatomic, readonly) NSUInteger bindingGeneration;
@property(nonatomic, readonly) BOOL outgoing;
@property(nonatomic, readonly) NSUInteger messageType;
@property(nonatomic, readonly) unsigned long long localID;
@property(nonatomic, readonly) unsigned long long serverID;
+ (nullable instancetype)contextWithCell:(id)cell controller:(nullable id)controller
    accountID:(NSString *)accountID accountEpoch:(NSUInteger)accountEpoch
    conversationID:(nullable NSString *)conversationID bindingGeneration:(NSUInteger)bindingGeneration;
- (BOOL)isValidForAccountID:(NSString *)accountID epoch:(NSUInteger)epoch;
// Persistent IDs may evolve local -> local+server -> server. Conflicting known server IDs fail.
// No-ID messages match only the same live wrapper and nonzero binding generation.
- (BOOL)matchesSourceContext:(CSMessageActionContext *)other;
@end
NS_ASSUME_NONNULL_END
```

### CSMessageActionPolicy.h

```objc
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
```
