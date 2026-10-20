# Combined Task 7 and whole-branch review

**Task 7 spec compliance: Approved for the integration/package/documentation scope.** The requested version, audit, package evidence, preserved artifacts and deferred UI corrections are present. This does not approve the integrated branch's privacy behavior; I1 below blocks whole-branch readiness.

**Task 7 code quality: Approved with nonblocking warnings.** The integration changes are scoped and the shared picker retains its default completion order for existing callers. No additional Task 7-only Important defect was found.

**Whole-branch readiness: Needs fixes / not ready to merge or deliver as complete.** One Important account-transition notification defect remains. No Critical findings. Device acceptance remains pending independently of the required code fix.

Review range: `929d265b..e98c5ace`; integration/package source commit `6987c113`. Reviewed the supplied full diff in passes, including all production and test changes, authored current evidence/extraction scripts, plan/decision records, audit verifier and recorded host/build results. Bulk generated native assembly/metadata and historical task reports were used as reference evidence, not redundantly reviewed line by line. No suite, build, installation, native research or Git mutation was performed. Only this report was written. Focused current-source line reads verified the concrete stale-notification path and exact integration references.

## Strengths

- Policy, account runtime and encrypted storage are separated from presentation adapters. The store verifies existing data before replacement and authenticates staged readback (`Controllers/CSCloseFriendStore.m:80`); the account-aware notification model refuses to rebind a previously bound message (`Controllers/CSCloseFriendNotificationAdapter.m:24`). The latter is the right identity invariant, although its output consumer has the defect below.
- Session/contact/social adapters preserve source models and use derived presentation/index mappings. The implemented reveal gates, neutral aggregate fallbacks and publishing-ACL constraints are explicitly documented rather than represented as universal filtering coverage (`docs/audits/close-friends-1.8-42/README.md:15`). No concrete mutation of real friend relationships, message storage/unread, tag membership or publishing ACL was found in the reviewed changes.
- The deferred picker alert ordering is resolved through an opt-in dismissal completion (`Controllers/WEContactSelectViewController.m:334`), with account refresh and authorization-token revalidation before saving (`Controllers/CSCloseFriendSettingsViewController.m:77`). The inert showBadges UI row is absent from the settings keys/labels (`Controllers/CSCloseFriendSettingsViewController.m:12`); compatible schema/default support remains. Both carried Task 2/integration UI findings are resolved in source. UIKit error visibility remains device acceptance C06.
- DND restoration uses the agreed process-session ownership and revoked-transaction protection; the UI/audit disclose that previous automatic DND may require manual restoration after restart (`docs/audits/close-friends-1.8-42/README.md:33`). Known call rejection gaps and required PushKit/CallKit lifecycle preservation remain explicit.
- Version 1.8-42 is consistently reflected in the package/control/display/release documentation. The recorded verifier checks source inputs, package/built/staged dylib agreement, both architectures, minOS, exports, dSYM UUIDs and prior artifacts (`docs/audits/close-friends-1.8-42/verify-delivery.py:79`). The audit distinguishes host success from pending device acceptance (`docs/audits/close-friends-1.8-42/README.md:35`).

## Findings

### Critical

None found.

### Important — I1: Positively bound stale notifications fall through to native output

**Primary location:** `Hooks/CloseFriendNotificationHooks.xm:11`.

**Supporting locations:** `Controllers/CSCloseFriendNotificationAdapter.m:18`, `Controllers/CSCloseFriendNotificationAdapter.m:24`; notification output consumers at `Hooks/CloseFriendNotificationHooks.xm:38`, `:77`, `:85`, `:98`; the separate can-show predicate at `:45`; known-request cleanup at `:21`.

`shouldSilence` correctly returns NO when a subject is no longer current, preventing account A's membership policy from being evaluated as account B's policy. However, `Silent(subject)` interprets that NO as permission to output. A nonnil subject already bound to account A is deliberately retained by `CSCFMessageSubject` and `CSCFBoundAlert`. After an epoch/account transition, a delayed quick-reply, bound notification-info callback or explicitly scoped/bound notification request therefore forwards A's content to the native presentation/submission path. A stale identity is currently treated like a nil, unknown identity. Pending/delivered request cleanup uses the same current-policy-only decision and also leaves positively tracked stale requests untouched.

**Concrete sequence:** create/bind an incoming message or notification info under A; switch account or advance the epoch; consume that same object at `showLocalNotificationWithInfo:` or `addNotificationRequest:withCompletionHandler:`. `isCurrent` is NO, `shouldSilence` is NO, `Silent` is NO in the absence of a separate call scope, and the original output function runs. This violates the explicit late-callback/epoch requirement on a positively identified path, rather than falling within the documented unknown/unbound-output limitation.

**Required fix:** introduce or consistently apply an output-discard decision that rejects a **nonnull positively bound stale subject**, separately from current-account membership silencing. Preserve compatibility for **nil unknown/unbound subjects**. Apply it at the actual notification/quick-reply/sound/vibration output boundaries and corresponding can-show/known-request cleanup decisions. Preserve exact identifier/content matching when removing tracked requests, so unrelated native notifications are not removed. Keep notification completion exactly once when suppressing a submission. Do not skip message ingestion or mandatory PushKit/CallKit reporting/completions, and do not rebind the old subject to the new account.

**Focused verification:** extend the existing production notification-output fixture (`Tests/CloseFriendAlertTests.m:132`) with a bound subject/request created before an epoch change, assert zero native submissions and one completion, and retain ordinary/unbound pass-through checks. The current assertion at `Tests/CloseFriendAlertTests.m:130` only establishes that a stale subject does not apply membership policy; it does not test that stale content is discarded. No broad test matrix is requested.

### Minor — M1: Carried compact security/control flow remains harder to audit

**Location:** `Controllers/CSCloseFriendStore.m:76`, `:84`, `:102` (representative of the already-carried Task 1 readability concern).

Several failure-sensitive operations and branch decisions share long single lines. This increases review cost for key failure, partial write and authenticated-readback paths. No additional functional defect was established. Keep this nonblocking; expand statements when these paths next change rather than conducting a branch-wide formatting/refactor cycle.

### Minor — M2: Build succeeds with documented warnings

**Evidence:** `docs/audits/close-friends-1.8-42/logs/package.log:176`, `:198`, `:233`, `:252`, `:269`, `:275`.

Both architectures report UILocalNotification deprecation from the compatibility adapter, existing RedEnvelop statusBarFrame deprecation, and obsolete linker `-multiply_defined`. These are disclosed in the audit and are not build failures or a new privacy blocker. Do not describe the build as warning-free. No unrelated legacy cleanup is required for this delivery.

## Checked evidence and limits

- Recorded integrated runs all exit 0: core 209; runtime 76 plus scheduling 5; session 41 plus presentation 8; contacts and social semantic fixtures; alerts 59; plugin entry 21 plus startup 14; payment privacy 6. Commands and exact logs are present in `docs/audits/close-friends-1.8-42/host-results.json` and `logs/`. Reviewed fixture behavior and existing output; did not rerun the suites. The stale-notification output scenario in I1 is not covered by those passing results.
- Recorded package command: `make package -j4 SCHEME=rootless PACKAGE_VERSION=1.8-42`, exit 0. Package: `packages/com.wechat.improve_1.8-42_iphoneos-arm64.deb`, 1,074,430 bytes, SHA-256 `146e7a37e6482106c81b991836bd7e6ba2c48207402ff91d7eef0659a7135932`. Recorded validation: arm64 + arm64e, iOS 15.0, 22 required exports per architecture, matching package/built/staged dylib and dSYM UUIDs, unchanged injection filter, 455 matched source/test/build inputs, and all 5 prior artifact entries preserved. These describe the pre-fix reviewed artifact, not any future corrected package.
- Native evidence is static evidence for WeChat 8.0.78; ABI discovery does not certify runtime installation, callback timing or UI coverage. The DND native write version gate is explicitly constrained to 8.0.78.
- Device matrix remains entirely pending: authentication/Keychain/biometrics, active/background changes, picker error UI, actual covers/layout/gestures, native call/notification lifecycle and plugin combinations require real-device evidence. This is an honest remaining validation boundary, not an invented source-code blocker and not a pass.
- Accepted limits remain: gated unsupported search/personal/detail/Flutter/status routes; fresh revealed publishing edits; neutral unknown aggregates/discovery cues that may undercount ordinary activity; unmatched main ilink and some unified group rejection unsupported; system first frames/terminated-process APNs not claimed covered; process-bound DND restoration. I1 is outside these exceptions because the affected subject already has a positive account/epoch binding.
- Original checkout and existing package/build data were preserved. No service/database switch or real-account write was involved. Generated `.theos` changes are intentionally retained and excluded from source commits; they are not a review finding.

## Required closeout

Resolve I1 in the single consolidated final fix wave; run the focused affected notification fixture, then perform scoped rereview. Because production output hooks change, rebuild the package and refresh its source/hash/audit evidence once. Reuse unaffected successful results. Persist this review and the fix/rereview outcome in the durable audit before final handoff; keep device acceptance explicitly pending.
