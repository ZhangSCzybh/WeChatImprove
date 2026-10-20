# Backup startup barrier implementation evidence

Date: 2026-10-20. Checkout: /Users/zhangshichao/Documents/Workspace/WeChatImprove.
No service was launched, restarted, switched, or installed on a device. No device preferences, account database, payment ledger, existing .theos output, or existing packages were modified by this task. Tests used temporary directories and an inert manager facade.

## Implemented

- Added Controllers/CSBackupBootstrap.h/.m with C-linkage APIs for Objective-C and Objective-C++ hook callers.
- Metadata-only fast path: protectedVersion must match kPluginVersionString and lstat must report transaction.plist absent. Journals (including malformed/dangling symlinks), inaccessible paths, and upgrade mismatches hold initialization.
- Fast-path callbacks execute synchronously. Held callbacks preserve registration order, run once on main only after successful manager resolution, and remain held after failure. Resolver work starts asynchronously on main; the manager owns background I/O.
- Failure does not schedule an automatic loop. Foreground, native login completion, user retry, or successful cancellation may retry. Concurrent retries join one attempt; stale duplicate completions are ignored. Retry after features are ready never applies a newly prepared transaction live and reports restart required.
- Mechanically gated all 33 feature Hook files, including constructor side effects and actual Logos %init. Preserved Revoke's conditional explicit group initializations. BackgroundBlur has no hook group and therefore no %init.
- Kept CustomEntryHooks and new BackupLifecycleHooks always installed. Held startup exposes backup recovery from both native More and Settings pages despite hidden entry preferences and opens the backup page directly without authorization or full feature-settings initialization.
- Native MMContextManager logout:/loginByContext: boundaries update an atomic epoch/suspension word before context replacement, without creating group, message, or payment coordinator singletons.
- Added Tests/BackupBootstrapTests.m and Tests/verify-backup-bootstrap.sh.

## Verification

- Tests/verify-backup-bootstrap.sh passed: 33 state-machine, journal-probe, callback-order, failure/retry, duplicate-completion, account-boundary, and active-feature retry checks.
- Logos generated all 35 Hook files. No implicit _logosLocalInit constructor remains outside the explicit barrier/always-available infrastructure paths.
- All 35 generated Objective-C++ Hook files and CSBackupBootstrap.m syntax-compiled successfully for arm64-apple-ios15.0 with installed iPhoneOS 27.1 SDK.
- Objective-C++ undefined-symbol inspection confirmed unmangled C linkage for CSBackupAccountEpoch.
- Compared all 22 pre-existing feature constructor bodies to HEAD after stripping only the barrier wrapper, newly explicit %init, and whitespace. Existing side effects and Revoke group variants are unchanged.
- git diff --check -- Hooks passed.

The iOS syntax pass found and fixed the one ctor-before-first-hook file (CSAvatarShape.xm): its gated constructor now appears after hook definitions so generated method declarations precede explicit initialization. All other generated hook files compiled without an ordering correction.

## Residual device acceptance

- Compile and Foundation tests do not prove that private More/Settings table APIs and MMContextManager selectors match every supported WeChat binary.
- Verify on device: ordinary protected-version startup; upgrade snapshot before migrations; prepared/applying/rollingBack/corrupt journal launch; account unavailable then login; account switch during validation; cancellation; foreground retry; settings entry configured hidden; and host usability while held.
- Feature hooks installed after a prolonged recovery hold may need navigation/reopening to revisit native lifecycle events already delivered before installation. UI currently asks the user to reopen WeChat for complete feature initialization after a manual retry.
- Transaction durability, rollback correctness, resource consistency, package build, and full-project regression results belong to the manager/engine/root task and are not claimed by this report.
