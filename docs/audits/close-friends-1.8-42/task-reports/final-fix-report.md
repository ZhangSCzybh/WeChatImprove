# Final review fix — I1 stale account-bound notification output

Status: DONE_WITH_CONCERNS (I1 addressed; device acceptance and existing coverage limitations remain). Review base: e98c5ace. Production source/test commit: `06aeaa37` — `fix: discard stale account-bound notification output`.

## Finding and correction

I1 distinguished an unknown subject from a previously positively bound subject whose account/epoch was no longer current. The old shouldSilence correctly refused to apply another account's membership, but the output gate incorrectly treated that as native forwarding permission.

Added `shouldDiscardOutput` on CSCloseFriendAlertSubject: discard if not current, otherwise apply current-account silence. Sending this predicate to nil returns NO, preserving unknown/unbound compatibility. The shared production Silent output gate now uses the new decision, covering QuickReply, bound local notification info, UN submission, legacy local notification, sound and vibration. The can-show predicate and known pending/delivered cleanup also use it. Cleanup still requires the captured identifier and exact content equality; reused identifiers with different content and untracked native requests remain untouched. No stale rebinding or message-ingestion bypass was introduced; PushKit/CallKit reporting and mandatory callbacks remain unchanged. A discarded UN submission invokes its completion once.

Changed production/tests: Controllers/CSCloseFriendNotificationAdapter.h, Controllers/CSCloseFriendNotificationAdapter.m, Hooks/CloseFriendNotificationHooks.xm, Tests/CloseFriendAlertTests.m, Tests/verify-close-friend-alerts.sh. The fixture now extracts the real production Silent and RemoveKnown bodies rather than mirroring the gate, alongside the existing real UN add hook.

## Focused regression evidence

```text
RED — bash Tests/verify-close-friend-alerts.sh
FAIL 156: completions==4 && center.submissions==2
```

This assertion failed before the fix: the bound ordinary request had already been submitted under the old account; after an account/epoch switch the real output hook submitted it again instead of discarding. The raw RED log is logs/final-fix-alerts-red.log.

```text
GREEN — bash Tests/verify-close-friend-alerts.sh
Close-friend alerts: 71 focused checks passed (identity, durable mute, calls, badge, payment policy)
exit 0

make package -j4 SCHEME=rootless PACKAGE_VERSION=1.8-42
exit 0; 6.34 seconds

python3 docs/audits/close-friends-1.8-42/verify-delivery.py
exit 0; arm64 + arm64e; minimum iOS 15.0; 455 source inputs; 22 exports per architecture; 5 prior artifacts preserved
```

The regression checks positively bound and scoped stale UN requests, one completion/no additional native submission, current protected silence while revealed, current ordinary and unknown native forwarding, and pending/delivered cleanup preserving replacement/untracked notifications. Existing focused alert suite assertions also remain green. No other core suite, historic regression, isolated full compile, native evidence analysis or device check was rerun.

Original integrated validation/source manifest/build results and logs are preserved as validation-integration.json, source-manifest-integration.json, build-result-integration.json and logs/package.log. Current validation.json explicitly distinguishes reused initial host evidence from final-fix-results.json and the current build. Final source-manifest.json is the post-fix production/test state before rebuild. Final build log is logs/package-final-fix.log; API-deprecation and obsolete-linker warnings remain recorded, not represented as a clean-warning build.

## Corrected artifact

- Path: packages/com.wechat.improve_1.8-42_iphoneos-arm64.deb
- Bytes: 1,077,776
- SHA-256: f9ed41cfbcb43332a09205f56be7639b3cbcc9fe1645cfc0f71af820436e72cc
- Version/control/header/release agreement, package/built/staged dylib SHA, architecture/minOS, required exports, dSYM UUID and unchanged injection filter all verified.
- All original 4 .deb files and packages/.DS_Store retain initial bytes/hash. The authorized 1.8-42 artifact was rebuilt in place; historical pre-fix metadata remains clearly labeled.

Other changes: audit verifier and source/metadata/build records; README and delivery decisions; historical review and this report; final package. Existing .theos output remains on disk and is excluded from commits. No clean/install/push/merge, service switch or real account/database activity.

## Self-review and remaining limits

Self-review confirms all affected output call sites route through the discard decision; only precise known-request cleanup changed, with no remove-all behavior, new identity inference or ingestion suppression. Nil compatibility and exact completion behavior are covered by the actual hook fixture. I1 is addressed; root owns one scoped rereview. Nonblocking M1 readability and M2 warnings were not expanded into cleanup.

Device acceptance remains pending. Process-bound DND restoration/manual reset after restart, unsupported unmatched main ilink and some unified group broadcasts, system-first-frame/terminated-process notification limits, and existing reveal/neutral-display tradeoffs remain unchanged and documented. No new device acceptance claim is made.
