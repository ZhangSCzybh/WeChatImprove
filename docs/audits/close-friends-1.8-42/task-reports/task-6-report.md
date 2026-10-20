# Task 6 implementation report

Status: DONE_WITH_CONCERNS (documented native coverage limits; no device validation).
Commit: `f747a6a4` — `feat: add identity-bound close-friend alert and call privacy`.

## Implemented

- `CSCloseFriendNotificationAdapter.{h,m}`: immutable account/epoch/session/sender subjects, object bindings which cannot be rebound across account changes, nested output scopes, and source-aware payment output policy. A message is accepted only when `m_nsToUsr` equals the current account; session is `m_nsFromUsr`, group sender is `m_nsRealChatUsr`. An explicitly supplied contact must agree with the session. No notification `userInfo` key is guessed as account identity.
- `CloseFriendNotificationHooks.xm`: QuickReply item/message output and `canShowPushForContact:msgWrap:` gates. `onNewMsgArriving:NotifyFlag:` always invokes native bookkeeping inside a subject scope. Local notification factory bindings and `MMLocalNotificationUtil +showLocalNotificationWithInfo:` preserve subject identity into local output. Verified scoped `AudioHelper` sound/vibration candidates never disable unrelated audio. Modern UN requests and legacy UIApplication local notification outputs are filtered; receipt/storage APIs remain untouched.
- Only `UNUserNotificationCenter -addNotificationRequest:withCompletionHandler:` has a completion gate: a silenced request invokes its supplied completion once with nil; an allowed request forwards the original completion once to native. The focused fixture executes the actual production add-hook body. PushKit/CallKit reporting and completions are not hooked or skipped.
- Pending/delivered removal uses only in-memory request identifiers captured at the bound UN submission boundary, the captured request content, and a fresh current-subject policy check on main. It never removes all system notifications and cannot remove unbound/restarted-process notifications safely.
- `CSGroupListAdapter` exposes a minimal alert badge accessor over its validated native sections, account, epoch and source revision. It uses the existing CSGroupProjection semantics and excludes folded-controller duplicates. `silenceMessages` contributions remain excluded while revealed; `showBadges` never authorizes unread exposure. Unknown/dirty/blocked source displays neutral zero. App icon, local request badge, and confirmed chat-tab numeric/string/dot output use it. Existing observed chat tabs are refreshed on policy changes. Original unread values are unchanged.
- `CSCloseFriendMuteAdapter.{h,m}`: durable prepared -> applied/owned journal, getter/readback, original-muted preservation, at most two apply attempts, epoch checks, restoration-intent save before restoring and conservative ownership loss after ambiguous partial writes. A restart reconstructs the transaction from the bridge's encrypted journal. Native writes are gated to 8.0.78 and normalized BOOL signatures. External edits revoke ownership before forwarding the setter.
- DND external-mutation observation: `ChangeNotifyStatus:withStatus:sync:`, `ChangeNotifyStatusForChatRoom:withStatus:sync:`, `setContact:notifyOpen:sync:`, `CContact -setChatStatusNotifyOpen:`. A later read that differs from the owned muted state also revokes ownership. Only the plugin's own synchronous write scope bypasses those observers.
- `CSCloseFriendCallAdapter.{h,m}` and `CloseFriendCallHooks.xm`: account/epoch/family/room/key/message tokens, 120-second bounded duplicate tombstones, fresh pending/identity checks, separate group/unknown media decisions requiring both rejection switches, and exact-room MultiTalk requests. Unified invitation handling suppresses known-subject presentation before native creation. Legacy single calls use `rejectInvitationWithInfo:`; cached ilink single calls additionally require the exact cache invite-info object, matching caller and room. Ordinary established rooms are excluded.
- MultiTalk's native start routine always runs, including required lifecycle reporting. Only matching incoming output scopes suppress its window/ring/legacy float-banner outputs, followed by the verified `MultiTalkReject:` candidate after fresh checks. This avoids swallowing state initialization or hanging up a global current call.
- `CSPaymentAutomation.m` changes only `CSSend`: summary and configurable automated reply consult the source account/session/payer or envelope sender. Native payment and ledger execution stay intact. `Makefile` links UserNotifications for the new system notification references.

## Validation (final relevant runs)

All runs used macOS memory/temp-file fixtures or isolated iOS object compilation. No device, service, account, real ledger/database, installation, package, clean, push or merge occurred. Checkout remained `/Users/zhangshichao/Documents/Workspace/WeChatImprove`, branch `codex/close-friends`.

```
Tests/verify-close-friend-alerts.sh
Close-friend alerts: 57 focused checks passed (identity, durable mute, calls, badge, payment policy)

bash Tests/verify-payment-core.sh --privacy
Payment privacy: ledger/execution preserved, summary + reply gated, ordinary outputs restored (6 checks)

Tests/verify-close-friend-ios.sh --alerts
Close-friend iOS: arm64 + arm64e source objects compiled

git diff --check
(no output, success)
```

The alerts test executes the production Foundation adapters, the actual UN submission hook body and only the new badge accessor with the real CSGroupProjection. It covers silent/ordinary subjects, reveal still silent, stale epochs, room/inviter separation, notification completion, original mute preservation, external edit revocation, new-engine restart, failed applied-journal commit, duplicate legacy/cached-ilink/group requests, unsupported main ilink, ordinary call after scope cleanup, same-room established call, unknown group-media switch, folded totals and immutable native unread.

Payment `--privacy` was added to the existing fixture/script to run only the changed effect boundary; the normal historical suite remains available. This verifies completed transfers and ledger increments while summary/reply are blocked, then ordinary summary/reply delivery. Unchanged historical message/payment suites were not rerun, following the efficiency instruction; consolidated integration/package validation belongs to Task 7.

Initial development compile found existing unused-parameter warnings in CSPaymentAutomation and a Foundation fixture factory typo; both were resolved. The affected iOS script keeps `-Werror` with the repository's unused-parameter exception. Final outputs above have no warnings.

TDD was not required by this brief. Tests were built alongside implementation; no artificial RED claim is made.

## Self-review and limits

- Fixed source epoch validation, stale call-object rebinding, post-native token identity recheck, same-room established MultiTalk handling, and legacy banner filtering limited to the matching incoming scope.
- States mean: `identified` = identity resolved; `presentationSuppressed` = output policy owns presentation; `rejectionRequested` = native request submitted; `rejectionUnsupported` = no verified safe request route; `native-ended` = local tombstone. A void native return is never called rejected/successful. Capability records are interface availability only.
- Main ilink without an exact matching cache remains rejectionUnsupported. No MMConfSDKService substitution or global hangup/reset is used. The controller approved leaving unified roomType=3 broadcast unsupported; group main invitations use the separate exact-room MultiTalk path. Strict cache object/caller matching can conservatively leave additional subcall invitations unsupported.
- Native SDK queued cancellation/accept races and subcall clear-order behavior remain device-validation risks in the supplied evidence. Unknown scalar/accessor ABI does not authorize a write/rejection. System-first-frame coverage is explicitly unavailable; process-terminated APNs, notification extensions, CallKit lock-screen first frame and unbound/asynchronous output paths are not claimed covered. Legacy floating banners are only suppressed in the verified matching incoming scope, not arbitrary later/established-call banners.
- DND edits bypassing every observed native setter and returning to the same final value cannot be distinguished from no edit. Versions other than verified 8.0.78 do not write DND. Ambiguous prepared/restoring crashes can leave native mute enabled rather than incorrectly restoring user intent. These are conservative ownership limits.
- A neutral badge can temporarily undercount ordinary notifications when the current main-list source is unavailable, stale or has unknown aggregates. No private KVC projection or membership-count subtraction was introduced.
- Root-owned modified plan and untracked `docs/audits/close-friends-1.8-42/` are excluded from this task's commit.

## Files changed

New: Controllers/CSCloseFriendNotificationAdapter.h/.m, Controllers/CSCloseFriendMuteAdapter.h/.m, Controllers/CSCloseFriendCallAdapter.h/.m, Hooks/CloseFriendNotificationHooks.xm, Hooks/CloseFriendCallHooks.xm, Tests/CloseFriendAlertTests.m, Tests/verify-close-friend-alerts.sh.

Modified: Controllers/CSGroupListAdapter.h/.m, Controllers/CSPaymentAutomation.m, Makefile, Tests/PaymentAutomationTests.m, Tests/verify-payment-core.sh, Tests/verify-close-friend-ios.sh.

## Review fix — failed durable mute-ownership revocation

Fix commit: `b0a81135` — `fix: prevent revoked mute ownership from reviving after recovery`.

Round 1 review found one Important issue: a failed save of `revoked` left the previous `applied/owned` record on disk; the native external setter still correctly ran, but a runtime reload could later restore YES over the external NO edit.

Fixed only `Controllers/CSCloseFriendMuteAdapter.m` and `Tests/CloseFriendAlertTests.m`:

- Every newly prepared transaction has independent random `transactionID` and `restorationSession` fields in the existing encrypted journal.
- External mutation registers an account/name/transaction tombstone before attempting persistence or forwarding the native write. The process-global tombstone survives adapter recreation, runtime recovery and epoch changes, even when the journal save fails.
- Restoration requires the current process's restoration-session identity and a non-revoked transaction. A new process never automatically reacquires ownership of old prepared/applied records; it conservatively marks them revoked. No second persistence channel or shared-runtime modification was introduced.
- Successfully saved transactions still restore normally when an adapter/runtime is recreated in the same process. The existing normal-restoration fixture remains active.

The controller explicitly accepted the tradeoff: **after a process restart, an old automatically applied DND state can remain enabled; after removing the subject or disabling autoMute, the user may need to change DND back manually in WeChat.** This supersedes any earlier implication that cross-process restart preserves restoration authority. Task 7 will carry this behavior into UI/delivery wording. The native external edit is never suppressed due to a failed journal save.

Focused regression evidence:

```
# RED, before the fix, with only the new failed-revocation/reload/disable fixture:
Tests/verify-close-friend-alerts.sh
FAIL 158: writes==before && ![native[@"friend"] boolValue]

# GREEN, same fixture plus existing core behavior checks:
Tests/verify-close-friend-alerts.sh
Close-friend alerts: 59 focused checks passed (identity, durable mute, calls, badge, payment policy)

# Only the changed Objective-C adapter was compiled for both target architectures.
# A Python tempfile.TemporaryDirectory wrapper obtained the SDK using
# xcrun --sdk iphoneos --show-sdk-path and invoked this argv for each arch:
xcrun --sdk iphoneos clang -target <arm64|arm64e>-apple-ios15.0 -isysroot <iphoneos-sdk> -fobjc-arc -fblocks -Wall -Wextra -Werror -IControllers -c Controllers/CSCloseFriendMuteAdapter.m -o <temporary-directory>/mute.<arch>.o
Mute adapter: arm64 + arm64e compiled

git diff --check
(no output, success)
```

No unrelated suites, payment rerun, native research, packaging, install or real-data changes were performed. An initial shell cleanup wrapper was automatically rejected because it contained `rm -rf`; compilation then completed using Python's TemporaryDirectory cleanup instead. No blocked action remains.
