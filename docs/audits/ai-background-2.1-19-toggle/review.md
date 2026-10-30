# Independent review: 2.1-19 background fallback toggle

This review starts from the completed 2.1-17 rollback recorded in `../ai-background-2.1-17-rollback/`. The new task baseline is `baseline/manifest.json` (20 selected source/test/document copies) and `source-before-sha256.json` (42,513 production inputs). Prior 2.1-17, 2.1-18 and rollback audits remain historical evidence and are not rewritten.

The authorized change is one account configuration option, `backgroundFallback`, presented as **后台兜底补拉**. Missing keys and new default configurations mean `YES`, preserving the 2.1-17 behavior. OFF stops plugin fallback timers and additional sync attempts; it does not intercept the host's original synchronization, disable AI replies or change conversation rules. ON retains the existing one-shot deadline, attempt cooldown, account/configuration revocation and native completion deferral.

## Configuration and backup boundary

The Store keeps account-owned state in `ai-reply-<SHA256(account)>.plist`, with the account recorded in the state and checked by `CSAIReplyValidateState`. `CSBackupRegistry` dynamically registers the whole `aiReply/<account>` state with `scope: account`; it does not register each configuration key individually.

The new key must pass all three Store boundaries:

1. `CSAIReplyDefaultConfiguration` must include `backgroundFallback: @YES`; readers must also treat a missing key in an existing configuration as YES.
2. `CSAIReplyValidateConfiguration` must admit the key in its strict `OnlyKeys` list and reject a present non-Boolean value. Keeping it optional permits existing schema-1 state and old backups to load without a migration or rewriting account data.
3. `CSAIReplyPortableState` must copy explicit YES and NO values. Testing truthiness instead of presence would silently discard NO and restore the effective default YES.

`CSBackupEngine` captures the current account state, uses `CSAIReplyPortableState` for exported snapshots and revalidates through the Store. Restore restricts the AI field to the selected current/source account, creates another portable configuration, turns AI's master `enabled` off, clears credentials and connection verification, and resets handled/history state. The new portable setting can survive that path without changing the backup engine, registry or account ownership. Restoring the fallback option alone cannot activate replies because the master switch and credentials remain subject to the existing restore policy.

`CSAIConnectionIdentifier` should remain unchanged: fallback scheduling is not an API endpoint, model, credential or model capability. Toggling it should retain the current verified connection and avoid requiring another model connection test.

Compatibility is directional. The new validator can read existing files that omit the key. The original 2.1-17 validator has a strict key whitelist and will reject a future configuration containing `backgroundFallback`; this review does not claim old binaries can read the new state. No historical file is modified to create that compatibility.

## Scheduler and Manager boundary

The baseline scheduler uses a one-shot NSTimer with a 45-second interval and three-second tolerance. Before crossing the native sync boundary it reserves `lastAttempt` and arms the next deadline. Verified native full sync can defer that deadline. It does not repeatedly call the model every 45 seconds, and timer delivery is subject to background runtime availability.

OFF must invalidate the current timer and its generation immediately. A stale callback cannot start a plugin request. The Manager must also reject the disabled option before querying native account/contact services, and must recheck the setting after reentrant getters and before the final native request boundary. The account wrapper and Observer original methods remain intact.

An OFF/ON cycle must retain the last-attempt cooldown. Configuration identity changes still revoke previously verified full-sync coverage, as in 2.1-17; they must not revive old completion contexts or permit bursts by resetting attempt history. ON is still gated by background state, active background audio, AI master switch, verified model connection, an enabled supported unmentioned group, account/epoch readiness and authorization.

The UI should use the existing account/epoch checked asynchronous save path. That path already cancels pending unsubmitted reply work and invalidates old sync evidence while saving, so the change should not promise that switching a configuration has no effect on an in-flight task. It can accurately state that disabling fallback does not block host-origin synchronization or turn off AI's master switch.

## User wording

The user-required title is **后台兜底补拉**. The footer should describe an additional sync attempt after roughly 45 seconds without a verified complete sync, and say that a verified complete sync postpones the next attempt. It should distinguish periodic network activity from model requests, which still require a message that meets the existing reply rules.

The proposed explanation appropriately covers enabled-by-default behavior, muted-group use, extra network wakeups and battery usage, and the possibility that relying on host events alone may miss background replies. The phrase “每约45秒” must not be presented as a fixed model schedule. Existing statements that the feature does not enable background keepalive automatically, and cannot guarantee replies after suspension/exit, remain applicable.

## Final implementation review

The owner declared source/document freeze before this final read-only check on 2026-10-29 23:44 UTC (2026-10-30 07:44 Asia/Shanghai). No blocking finding remains in the reviewed scope.

The Store adds only a default YES value, an optional strict CFBoolean validator and portable-key copying. Numeric 0/1 and coercible strings are rejected for the new key without tightening the historical validation rules for other keys. Loading an old configuration does not insert the key or rewrite its bytes. The connection identifier function remains byte-identical to the baseline.

The Scheduler adds a default-YES property, an OFF setter that calls the original `stop`, and one OFF guard at the start of `refresh`. Removing exactly those additions reproduces the complete 2.1-17 implementation byte for byte. Thus ON retains the original timer/tolerance, deadline calculation, cooldown reservation, native boundary, stale/early timer checks, exception behavior and generation guards. Direct scheduler OFF/ON preserves current coverage and attempt history; saving a different Manager configuration still revokes old coverage through the unchanged configuration identity policy.

The Manager adds only two executable lines: synchronizing the property in `reconcileBackgroundSyncContext` and rejecting an explicit NO in `allowsBackgroundSync` before native eligibility getters. Removing those two lines reproduces the full Manager baseline byte for byte. Existing save success/failure handling, account and epoch checks, post-getter configuration checks, account wrapper invocation and pure snapshot final request fence remain intact.

The Settings row uses the required title, treats missing values as YES, and saves a Boolean through the existing account/epoch checked asynchronous path. Its final footer says “以约45秒为兜底期限” and that verified full sync postpones the next attempt. It explains network wakeups, possible subsequent model requests and additional battery use; it does not promise periodic model calls or measured battery savings. Existing model, conversation and keepalive explanations remain present.

## Frozen scope and hash checks

The independent comparison recomputed every production file in `source-before-sha256.json`:

- **42,513** production paths checked; **42,505 unchanged**, exactly **8 authorized changed files** below.
- No production file was added or removed.
- All **20** selected baseline copies match `baseline/manifest.json`.
- Those selected targets contain **16 expected changes**: 8 production files, 5 tests/scripts and 3 documentation files. The 4 explicitly protected targets remain unchanged: `CSAIReplyStore.h`, both `CSAINativeSyncObserver` files and `Hooks/AIReplyHooks.xm`.
- Every other production path is unchanged, which includes all close-friend/badge code, backup Engine/Registry, native message paths and Makefile.
- `tested-source-sha256.json` matches all **20 / 20** current source, test, script and document inputs. Its SHA-256 is `95aa4876fe369ed09a0949663555ea3472e93a6d659ffaf824df80ae3e69706e`.
- The production baseline manifest's SHA-256 is `bcb3a557021c7e4de1143bceabd3e14bab0fadaa32e17aaa7f1e32c4e6be66a6`.

| Changed production input | Frozen SHA-256 |
| --- | --- |
| `Controllers/CSAIBackgroundSync.h` | `3629c9c7ce4e3bba60a215fe0f1efbbb589dcaf5c27797e2ed9dd6888f09910e` |
| `Controllers/CSAIBackgroundSync.m` | `6b96295cdcfa0e9c103999a870fe351ca5a08875f6006146463f2ab65c3d0bed` |
| `Controllers/CSAIReplyManager.m` | `c73595a82766247707afe35e7fce42a607a222060f787775bf418944367af1ce` |
| `Controllers/CSAIReplySettingsViewController.m` | `6ba96063b229d4a7f766a3d3e63fb43091b0744a5fc896ae2b6d1710349e88c8` |
| `Controllers/CSAIReplyStore.m` | `4937f4bb757f1145ab6f89561a91c88683c03d8eb03499fb4ed93651845cec7a` |
| `Controllers/CSReleaseNotesViewController.m` | `c6a411e280ff95d605363ebe697e4d0cb055132c448a0b41091decd039988099` |
| `Headers/CSUserInfoHelper.h` | `2c5572b53ef9c2596c87aa2200d81d20fcb6191532708b6858927370e6c69a8b` |
| `control` | `5d9b0cc16b7bf40f90000d711acfcdc094b61dbffcc5a2437c4fda45df2d3e5d` |

## Observed validation and limits

The reviewer read the owner/implementation-agent logs and independently inspected their source/test diffs; these commands were not rerun by this reviewer:

| Evidence | Observed result |
| --- | --- |
| `scheduler.log` | **115 = 78 original + 37 new** checks; iOS arm64/arm64e objects compiled. |
| `manager.log` | **850 = 729 original + 121 new** checks; iOS arm64/arm64e objects compiled. |
| `coordinator.log` | **4588 = 4496 original + 92 new** checks. |
| `observer.log` | **828 = 786 main + 7 × 6 ABI** checks; iOS arm64/arm64e objects compiled. |
| `ai-backup.log` | **96** AI backup checks passed. |
| `foundation.log` | Store and Client suites reported success. |

Removing only the new functions, main invocations and Manager fixture's new math import reproduces each complete original Scheduler, Manager and Coordinator test file byte for byte. Existing assertions were not removed or relaxed. Both Scheduler/Manager shell scripts add a hard check for the new exact expected count, 115 and 850 respectively.

The new Store tests cover explicit YES/NO disk round trips, portable NO preservation, old missing-key files remaining unchanged, connection fingerprint/verification preservation and invalid values leaving persisted state untouched. Their restore path reproduces the existing Engine transformation at the Store boundary; it is not described as an independent complete Engine transaction test. The separate AI backup log provides the existing Engine integration regression result.

The new Manager tests verify that disabling fallback leaves incoming-message admission and eligible model work available, old timer/context callbacks cannot restart it, failed saves retain the persisted option, account switches do not share preferences, and toggles inside contact/busy/Observer getters cannot submit stale wrappers. Scheduler tests verify direct toggle deadlines, cooldown, stale timers and OFF at eligibility/clock/synchronize reentry boundaries.

No production or test files were edited by this reviewer. This subtask only wrote `review.md` in the new audit directory. It performed no full build, package operation, real host execution, account/database operation or service restart. Full builds, warning counts, package verification and final historical-artifact preservation are owned by the root agent and are not asserted here. Host fixture and object-compilation results do not establish real-device background delivery, runtime UI appearance or measured battery savings.
