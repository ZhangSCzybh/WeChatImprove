# Spec Compliance

- ❌ Issues found: observed external DND edits can lose ownership revocation when the journal save fails, allowing a later recovery to undo the user's edit (`Controllers/CSCloseFriendMuteAdapter.m:12`, `Controllers/CSCloseFriendMuteAdapter.m:32`). This violates the binding external-edits-win requirement.
- ✅ The requested adapters, output hooks, focused fixtures and affected iOS compilation entries are present. Payment changes remain at `CSSend` (`Controllers/CSPaymentAutomation.m:211`); the diff does not suppress message receipt/storage or alter payment execution.
- ⚠️ Device behavior, required system call lifecycle under native races, and whole-branch preservation of earlier surfaces cannot be established from this task diff. The report correctly distinguishes interface evidence from device validation.

# Strengths

- `Controllers/CSCloseFriendCallAdapter.m:11` preserves confirmed individual voice/video decisions and requires both switches for unknown/group media. `Controllers/CSCloseFriendCallAdapter.m:84` limits legacy/cached-ilink rejection to the supplied safe candidates; main ilink without an exact cache remains unsupported, with no MMConfSDKService substitution or global hangup/reset. `Controllers/CSCloseFriendCallAdapter.m:110` preserves the MultiTalk native entry while scoping presentation suppression.
- `Controllers/CSCloseFriendNotificationAdapter.m:24` preserves an existing message's account binding, and `Hooks/CloseFriendNotificationHooks.xm:85` calls a suppressed UN submission completion exactly once. Output scopes unwind through `@finally` (`Controllers/CSCloseFriendNotificationAdapter.m:34`).
- `Controllers/CSCloseFriendMuteAdapter.m:29` records restoration intent before native writes and conservatively forfeits ambiguous partial-write ownership. `Controllers/CSGroupListAdapter.m:162` uses validated native rows, epoch/source revision checks and the existing projection rather than changing unread storage or subtracting membership counts.

# Issues

## Critical

- None found.

## Important

- **Preserve revocation when its durable save fails — `Controllers/CSCloseFriendMuteAdapter.m:12`–`16`, `Controllers/CSCloseFriendMuteAdapter.m:78`–`84`.** `externalMutation` builds a revoked record but discards the result of `persist:`; the observer then forwards the native edit unconditionally. For example, a plugin-owned mute has `original=YES, phase=applied, owned=YES`; the user or remote account explicitly sets notification-open to NO; saving the revocation fails. The native NO edit proceeds, but the durable record still says the plugin owns it. After recovery reloads that record, disabling autoMute takes the restoration branch at line 32 and writes YES over the external choice. This is an *observed* setter mutation, not the documented limitation for edits that bypass all observers. The existing runtime blocks on a store failure but can subsequently reload the unchanged owned journal (`Controllers/CSCloseFriendRuntime.m:43`, `Controllers/CSCloseFriendRuntime.m:127`), so blocking alone does not resolve the ownership loss. Preserve a conservative revocation/failure barrier through recovery and prevent restoration from treating the old record as trustworthy; keep the external setter's native behavior. Add one focused fixture for revocation-save failure followed by recovery and disabling autoMute, asserting no restore write. Existing failure coverage tests an applied-record commit failure instead (`Tests/CloseFriendAlertTests.m:149`).

## Minor

- None requiring separate action.

# Checks and Limits

- Read the supplied diff in bounded sections because the initial combined tool output was truncated; did not reread changed production files, run git commands, rerun suites, or perform new native research.
- Named outside-diff checks: (1) DND revocation failure/recovery — bridge mutation and runtime save/reload behavior; (2) native pending-guard ABI — supplied `alert-native/methods.json` and `MultiTalkMonoMsg-methods.json` confirm `isCancelMsg` / `isOutOfDate` BOOL getters; (3) room/inviter interpretation — unchanged policy methods confirm the caller-or-room contract. The latter two checks did not produce findings.
- Accepted bounded limitations: main ilink rejection without an exact cache, unified group-broadcast rejection, unbound/asynchronous/system-first-frame notifications, and opaque native queued races are not promoted to verified protection. Their explicit reporting matches the controller rulings; no broad coverage expansion is requested.
- Reported validation is 57 focused alert checks, 6 payment privacy checks, and arm64/arm64e affected-source compilation with clean final output. These were not repeated. Review wrote only this report; no services, real account/data, index, branch, or production files changed.

# Assessment

**Task quality: Needs fixes.** The implementation follows the native-evidence boundaries and separates output policy from storage/payment effects well. The failed external-revocation path must be made conservative before its restoration ownership can be trusted.
