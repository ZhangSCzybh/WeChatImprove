# Task 2 report — runtime, authentication, lifecycle and settings

Status: DONE (implementation complete; physical-device acceptance remains a separate downstream step). Final head: `505900870952b7930d5a839d95dfb530ea215b75`.

Commits:
- `c7a7ed8f6e5a895b66d823255833d5a4af0049c6` — `Add account-bound close-friend runtime, authentication and settings`.
- `8f6d9d79b9735ac5bb385cd9ab7b9f753e38ef3d` — `Use monotonic elapsed time for close-friend reveal expiry`.
- `505900870952b7930d5a839d95dfb530ea215b75` — `Keep close-friend expiry active during UI tracking`.

Implementation stayed in `/Users/zhangshichao/Documents/Workspace/WeChatImprove`, branch `codex/close-friends`, starting from `bde53cfe`. No checkout switch, package clean, service start/restart, installation, database migration, real account edit, real Keychain write, or device runtime action was performed. Host tests use a new temporary directory, generated key bytes and memory credential providers. iOS compiler outputs use a temporary directory removed on exit. No subagent was spawned.

## Files and actual shared contracts

- `Controllers/CSCloseFriendBridge.{h,m}`: all brief APIs retained. C exports have explicit `extern "C"` linkage. Added `CSCloseFriendMethodMatches(Method,const char *)` for shared exact normalized method checks and `CSCloseFriendPluginEntryHidden()` for entry gates. Thread-safe snapshot reads; main-thread profile/journal writes held inside `CSBackupPerformAtAccountEpoch` with current suspension/account rechecks. Native object reads only invoke guarded object getters or read object-typed ivars. No arbitrary KVC in new bridge readers. Global privacy-icon hiding remains effective while revealed.
- `Controllers/CSCloseFriendManager.{h,m}`: singleton runtime owner, device-only Keychain provider, lifecycle observation, password and biometric UI, recovery gesture, capability registry, settings presentation. Main methods are `start`, `refreshAccount`, `lockAndReturnToSafePage`, `authenticateFrom:completion:`, `presentSettingsFrom:`, `changePasswordFrom:`, `capabilities`, `recordCapability:available:`, `attachRecoveryGestureTo:`.
- `Controllers/CSCloseFriendRuntime.{h,m}`: production Foundation state/auth core, with injected store, separate wall/monotonic elapsed clocks, credential reader and writer. Account synchronization, immutable cached snapshots, account/generation auth tokens, PIN/password verification and cooldown, setup/change-password, independent journal preservation, temporary reveal and immediate clock checks. This is the actual core exercised by host tests, not a parallel test-only model.
- `Controllers/CSCloseFriendAccount.{h,m}`: injectable class lookup and guarded authoritative account resolution. Mirrors established `CSGroupCurrentAccountID` priority: MMContext.currentUserName, SettingUtil.getCurUsrName, then current-context service lookup only when authoritative accessors do not exist. An available authoritative getter returning nil, throwing or having an unsupported signature fails closed. Available currentContext returning nil never falls back to cached default-center self data. Legacy default center is used only when the current-context accessor is absent.
- `Controllers/CSCloseFriendSignatures.{h,m}`: full normalized return/argument comparison, ignoring ABI-neutral qualifiers/quoted object annotations and encoded offsets, retaining distinctions such as block/object, BOOL/integer and argument count.
- `Controllers/CSCloseFriendSettingsViewController.{h,m}`: gated grouped table settings, exact twenty brief option keys, enable switch, friends/groups through existing `WEContactSelectViewController`, password change, lock, unlock duration, capability rows. Direct instantiation yields no rows before authentication. Async picker/duration saves recheck token, authorization and account before merging current profile.
- `Hooks/CloseFriendLifecycleHooks.xm`: deferred guarded NewMainFrameViewController viewDidAppear adapter for home navbar long press and guarded UIWindow shake adapter. Constructor only schedules deferred bootstrap; no native login hook, service lookup, Keychain access, file read or class scan in the constructor.
- `Controllers/CSCustomViewController.m`: adds 密友 in existing 账号与安全 section, respects hideSettingsEntry, and covers/gates direct plugin host instantiation before sensitive settings content appears.
- `Hooks/CustomEntryHooks.xm`: gates direct/delayed hidden plugin opens; skips registration while hidden; removes previously inserted native settings/More cells when their normal refresh hooks execute. New removal reads use the guarded bridge, preserving existing framework implementation elsewhere.
- `Controllers/CSCloseFriendPolicy.h`, `CSCloseFriendCrypto.h`, `CSCloseFriendStore.h`: root-authorized small integration change adds C linkage guards for Objective-C++ consumers; core implementation unchanged.
- `Makefile`: adds Security framework; UserNotifications not needed in this task.
- `Tests/CloseFriendRuntimeTests.m`, `verify-close-friend-runtime.sh`: behavioral Foundation/auth/account/signature tests.
- `Tests/verify-close-friend-ios.sh`: isolated arm64 + arm64e object compilation of all close-friend sources, modified custom settings and both lifecycle/custom-entry Logos outputs, without touching `.theos` or packages.
- `Tests/PluginEntryTests.m`: four added hidden-entry behavioral checks; all previous framework tests retained.

## Runtime and security behavior

Encrypted state root is the app sandbox's `Library/Application Support/WeChatImprove/CloseFriends`. Store schemas remain exactly `{profile, muteRecords}`. Per-account policy key is 64 random bytes. Keychain service is `com.wechatimprove.closefriends.v1`; account indexes are SHA-256 digests with `policy.` / `auth.` prefixes. Both item types use `kSecAttrAccessibleWhenUnlockedThisDeviceOnly`, synchronizable NO. Auth stores 32-byte random salt, PBKDF2-HMAC-SHA256 verifier at 210000 iterations, failure count and cooldown timestamp. Credentials never enter defaults, encrypted policy profiles, logs, diagnostic files or ordinary backup modules.

Only a genuine missing state file can initialize a disabled empty profile. Unreadable/corrupt/incompatible state, missing credentials over any persisted state, unavailable Keychain item or failed durable auth update holds protection. The key provider checks the exact hashed state path with lstat before generating a new key and refuses creation when existing bytes or inaccessible path are present. The store independently refuses corrupt-state replacement. No reset/recovery-overwrite path exists.

Setup requires at least six ASCII digits OR eight characters (maximum 128). Mixed six/seven-character and six non-ASCII-digit values are rejected. After five wrong passwords, cooldown begins at 30 seconds and increases with further failures, capped by the implementation at 180 seconds for the saturated count of ten (formula includes a 300-second maximum). Failure state is persisted in the credential item, so runtime recreation does not reset cooldown. Password and biometric success consume the auth generation. Biometric only uses `LAPolicyDeviceOwnerAuthenticationWithBiometrics`, requires the current option and current token, and cannot bypass cooldown. Late biometric/password callbacks after background/account change fail. A replaced/invalidated LAContext callback does not overwrite the newer attempt's manager state.

Reveal defaults to the exact 300-second option. Queries compare the injected monotonic elapsed clock immediately; production supplies NSProcessInfo.systemUptime independently from NSDate wall time used for durable cooldown. Wall-clock jumps cannot extend or resurrect reveal. The existing `initWithStore:clock:credentialReader:credentialWriter:` remains a convenience initializer treating the supplied clock as wall time and using system uptime for reveal; deterministic callers can use `initWithStore:wallClock:elapsedClock:credentialReader:credentialWriter:`. Account/background generation behavior is unchanged. On expiration, expiration produces a new immutable policy revision and the manager timer triggers safe navigation and notification. Stable per-row reads reuse the same immutable snapshot instead of renormalizing up to twenty thousand names. Epoch/suspension mismatch returns an empty-membership blocked snapshot, so old-account names cannot silence or reject calls in the next account. Profile mutation requires authorization; trusted mute-journal mutation works while locked but requires an existing credential, matching account and matching epoch. Profile and journal writes preserve each other.

Lifecycle handling invalidates authorization, covers visible windows and returns to safe roots when the feature or a sensitive auth/settings session is active. Background covers remain until didBecomeActive regardless of whether UIApplication still reports active during willResignActive. Disabled/unconfigured ordinary navigation is not popped simply for backgrounding. Existing backup epoch/suspension ownership is reused; no competing native login/logout hooks were introduced.

## Exact validation

Final commands (all exit 0):

- `bash Tests/verify-close-friend-runtime.sh` → `CloseFriendRuntimeTests: 76 checks passed`.
- `bash Tests/verify-close-friend-core.sh` → `CloseFriendCoreTests: 209 checks passed` (after core header linkage edits; core implementations unchanged).
- `bash Tests/verify-plugin-framework.sh` → `Plugin entry: 18 checks passed`, `Backup startup integration: 14 checks passed`.
- `bash Tests/verify-close-friend-ios.sh` → `Close-friend iOS: arm64 + arm64e source objects compiled` (rerun after final guarded entry-reader change).
- `git diff --check` and `git diff --cached --check` passed before commit.

Runtime coverage includes missing versus corrupt state; setup/password strength; verifier ownership; wrong-password attempts/cooldown across recreation; biometric cooldown; late replies after background/account change; expiry and revision; immutable snapshot reuse; current policy silence during reveal; cross-account/epoch journal rejection; preservation in both profile/journal directions; unavailable key provider; failed credential update; missing persisted-state verifier; corrupt bytes never overwritten; authoritative account nil/wrong-signature handling; guarded legacy fallback; method return/argument/count mismatches. All use memory or temporary files only.

Compilation uses `/Users/zhangshichao/theos` and iPhoneOS27.1.sdk under the provided Xcode path, targeting iOS 15.0. New Objective-C files compile with ARC, blocks, Wall/Wextra/Werror. Legacy modified settings/entry retain their established nonfatal warning policy. Standalone Logos compilation supplies `-D_Bool=bool` for legacy dump headers. Initial standalone compile attempts exposed a missing framework search path, an ARC autoreleasing error-pointer block capture, and the legacy `_Bool` C++ compatibility flag; all were corrected and final actual object compilation passes. No full package or device runtime validation is claimed here.

## Self-review / concerns for downstream acceptance

- Root review findings were incorporated before commit: authoritative account resolver, empty old-account side-effect membership at epoch boundaries, exact password policy, and cached snapshots.
- Real Keychain entitlement/access behavior, Face ID/Touch ID transitions, cover timing across real scenes, home-navbar gesture placement, shake delivery, and safe navigation remain physical-device acceptance work. Capability labels explicitly say interface available/unavailable and device verification pending, never complete protection.
- Third-party WCPluginsMgr may retain a registration created before hidePluginEntry was enabled. The registered controller path is always gated; this task does not call an unknown unregister API to promise removal of external cached registry rows. Normal owned settings/More cells are removed on their usual refresh.
- Policy failures deliberately block presentation, but unavailable/corrupt memberships cannot identify recipients for native silence or call rejection. They never invent membership or apply previous-account membership.
- Native auto-mute ownership/readback, notification interception, incoming-call exact tokens, list/profile/social adapters and full package/device acceptance remain Tasks 3–7. This task publishes their snapshot, capability, auth, epoch and durable journal interfaces.

## Expiration-correctness follow-up

The concrete wall-clock reveal limitation was resolved in separate commit `8f6d9d79`. All setup/password/biometric reveal deadlines and both authorization/snapshot checks now use the injected elapsed clock. Durable cooldown creation and comparisons continue using the wall clock. No generation/epoch/background behavior was changed.

Added semantic tests independently advance wall and elapsed time: wall time moves backward by one hour while elapsed time advances past 300 seconds; reveal still expires and publishes a new revision. A forward wall correction cannot resurrect an expired reveal. A new authorization followed by a one-day forward wall jump retains its original elapsed interval and expires as elapsed time passes 300 seconds.

RED: the updated runtime suite failed to compile before implementation because `initWithStore:wallClock:elapsedClock:credentialReader:credentialWriter:` did not yet exist. Final GREEN at `8f6d9d79`: `bash Tests/verify-close-friend-runtime.sh` → **76 checks passed**, exit 0; `bash Tests/verify-close-friend-ios.sh` → **arm64 + arm64e source objects compiled**, exit 0. Only these affected suites were rerun for this follow-up. Previously passing unchanged core/framework results above remain from the initial Task 2 validation. `git diff --check` passed before the follow-up commit. No subagents, device operations or real account/Keychain writes were performed.

## Independent review fix round 1

Base: `8f6d9d79`. Fix commit: `505900870952b7930d5a839d95dfb530ea215b75`. Read the complete `task-2-review.md`; addressed I1/P1, I2/P2 and M1/P2 without changing authentication generation, storage or account ownership.

- **I1 / expiry scheduling:** Extracted the manager's actual scheduling body into `startExpiryTimer`. It creates an unscheduled NSTimer and explicitly registers it with `NSRunLoop.mainRunLoop` in `NSRunLoopCommonModes`, preserving the callback's fresh `CSCloseFriendCurrentSnapshot()` read and safe-page transition condition. A previous timer is invalidated before registration. UI tracking no longer suspends this expiry poll.
- **I2 / duplicated hidden-entry cleanup:** Added file-local `CSRemoveHiddenPluginEntryFromHost(id host)` in `CustomEntryHooks.xm`. Both More and native Settings insertion hooks now use the same gate-plus-helper path. The guarded readers, shape checks, matching-title removal and preservation of unrelated/native cells are retained.
- **M1 / picker dismissal contract:** Friends and groups now present the existing WEContactSelectViewController in its own UINavigationController page sheet. Its existing Done/Cancel modal dismissal returns to the close-friend settings screen instead of leaving a pushed picker or dismissing the entire settings presentation. The existing callback's account refresh, authorization/token checks and current-profile merge are unchanged.

Added `Tests/CloseFriendSchedulingTests.m`. The verification script extracts `startExpiryTimer` verbatim from production and compiles that actual method into a Foundation fixture backed by the real injected-clock runtime. The fixture advances elapsed time beyond reveal expiry, runs the main run loop exclusively in a custom nondefault common/tracking mode, and confirms the production callback requests exactly one safe-page transition and locks the runtime. A default-mode control timer must remain unfired, proving that the test does not accidentally pass by running the default mode. The production timer remains valid for later reveal sessions. UIKit navigation is replaced only by an observable transition counter; this is scheduler/dispatch coverage, not visual-device evidence.

Regression sequence: first test compilation exposed a test-fixture typo (`NSData dataWithLength:`), corrected to NSMutableData. With the unchanged default-mode production scheduler the behavioral test then failed exactly at `production expiry scheduler requests safe-page transition while tracking`. After common-mode registration the same test passes. This establishes RED/GREEN on the reported scheduling defect.

Plugin fixture extraction now includes the real shared cleanup helper. Added behavioral cases for deleting duplicate matching cached rows while retaining native rows, leaving unsupported immutable cell collections alone, and tolerating an unsupported section shape.

Final affected commands, all exit 0:

- `bash Tests/verify-close-friend-runtime.sh` → `CloseFriendRuntimeTests: 76 checks passed`; `CloseFriendSchedulingTests: 5 checks passed`.
- `bash Tests/verify-plugin-framework.sh` → `Plugin entry: 21 checks passed`; `Backup startup integration: 14 checks passed`.
- `bash Tests/verify-close-friend-ios.sh` → `Close-friend iOS: arm64 + arm64e source objects compiled`.
- `git diff --check` and `git diff --cached --check` → no errors.

Self-review checked both helper call sites, retained auth token validation in the modal picker callback, current snapshot recheck in timer firing, timer invalidation before re-registration, and the negative control proving nondefault-mode test execution. No unchanged core suite was rerun. Remaining limits are the previously identified physical-device UI/Keychain/biometric acceptance checks; a real iOS finger-tracking session and rendered cover/navigation were not exercised by the host fixture. No subagents, clean, service operations, real accounts, device or Keychain operations were performed.
