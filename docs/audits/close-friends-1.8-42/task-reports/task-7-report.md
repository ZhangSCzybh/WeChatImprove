# Task 7 — integration, audit and package

Status: DONE_WITH_CONCERNS — authorized integration complete; device acceptance and documented native limits remain. Integration base: b0a811357c8af96b7c599c570d99f41011040f31, original checkout /Users/zhangshichao/Documents/Workspace/WeChatImprove, branch codex/close-friends.

Integration/source/package commit: `6987c113` — `feat: integrate close-friend privacy and package 1.8-42`. All 455 source manifest entries also matched the staged Git index before commit; no `.theos` path staged. A documentation-only follow-up captures this commit identity and the controller’s latest ledger.

## Changes

- Unified control, displayed version, current release notes, README download/output/build guidance at 1.8-42. Preserved historical release entries.
- Fixed the deferred picker error presentation: existing picker has an opt-in completesAfterDismissal flag, enabled only for close-friend lists. It copies the completion and executes it from UIKit dismissal completion; the existing settings callback refreshes account and rechecks authorization token before saving. Default callers retain their established order. No new marker design.
- Removed the inert “显示密友标记” row after confirming showBadges has no production visual consumer. Schema/default remain compatible; silent unread policy unchanged.
- Settings footer, release notes, README, audit and D04 now explain process-bound DND restoration: after restart, old automatic DND may persist and need manual restoration in WeChat. Same-process ownership still restores; external edits retain priority.
- Final audit includes host/build results, logs, source manifest, read-only package verification script, exact metadata, device matrix and honest gates/unsupported routes. Included root-prepared five evidence directories/authored reports/supplemental manifests without repeating native analysis or corpus verification. Archived Tasks1–6 reports/reviews and latest ledger; final decisions supersede old in-progress entries.

## Verification

Executed once on integrated production source, all exit 0 (exact logs and argv in host-results.json):

```text
bash Tests/verify-close-friend-core.sh       → 209 checks passed
bash Tests/verify-close-friend-runtime.sh    → 76 runtime + 5 scheduling passed
bash Tests/verify-close-friend-session.sh    → 41 session + 8 presentation, zero failures
bash Tests/verify-close-friend-contacts.sh   → production projection/tag/source/forward/profile native-reuse regressions passed
bash Tests/verify-close-friend-social.sh     → timeline/interaction/cache/ACL/status/discovery/picker/relock fixtures passed
bash Tests/verify-close-friend-alerts.sh     → 59 focused checks passed
bash Tests/verify-plugin-framework.sh        → 21 entry + 14 startup passed
bash Tests/verify-payment-core.sh --privacy  → 6 privacy boundary checks passed
make package -j4 SCHEME=rootless PACKAGE_VERSION=1.8-42 → exit 0, 8.37 seconds
python3 docs/audits/close-friends-1.8-42/verify-delivery.py → final exit 0
```

No artificial TDD claim; this task's changes are integration/UI ordering and documentation. Core behavior already has reviewed semantic fixtures. Picker save/error rendering remains explicitly device C06, not falsely called host UIKit validation.

Package verification: arm64 + arm64e, minOS 15.0 in both, 22 required exports per architecture, version strings/control/package agree, dylib hashes match packaged/built/staged bytes, per-arch dSYM UUID matches, injection filter unchanged. 455 source/test/build inputs match pretest manifest. All 5 prior artifact entries (4 .deb + .DS_Store) retain exact bytes/hashes. A first metadata-script run used incorrect assumed adapter class names; corrected checks to the actual exported C functions/classes from headers and nm, then the verifier passed. This was an audit-script expectation error, no production fix/rebuild/test rerun.

Build warnings are recorded rather than described as pristine: UILocalNotification and existing statusBarFrame deprecations, plus obsolete linker -multiply_defined, each per architecture. Host fixture output has no warnings.

Reused Task3 reviewed group preference/business/incremental/selection/search/lifecycle evidence. The mapping/projection/index algorithms did not change afterward; Task6's epoch checks and badge accessor are covered by the integrated alerts/session fixture. No historical full regression rerun or repeated isolated compile.

## Artifact

- packages/com.wechat.improve_1.8-42_iphoneos-arm64.deb
- 1,074,430 bytes
- SHA-256: 146e7a37e6482106c81b991836bd7e6ba2c48207402ff91d7eef0659a7135932
- Metadata and exact verification commands: docs/audits/close-friends-1.8-42/validation.json

No clean, install, push, merge, service switch, real account or database access. The original .theos directory stays on disk with this build's generated changes. Because this repository tracks build caches, git status has generated .theos modifications/new files; they are intentionally excluded from this commit and not reverted. Source identity is independently captured by source-manifest.json and the integration commit, not inferred from a clean build-cache status.

## Self-review and limits

Reviewed the integration diff, exact labels/options, shared picker default path and deferred authorization check, bridge account epoch and normalized signature guard, package/version changes, no new logging/defaults/export of memberships, and source-preserving production boundary changes. No Important integration issue identified. Staged whitespace check found one trailing blank line in the archived alert report; normalized only that authored report and updated its manifest digest, preserving native evidence bytes. Staged diff whitespace check then passed. Root owns the combined Task7 compliance and complete branch review; no duplicate reviewer was spawned.

- Device acceptance remains pending: Keychain/biometrics, UIKit presentation, gestures, actual native runtime notification/call behavior and other plugin combinations.
- Process restart deliberately does not reestablish old DND ownership; manual restoration can be required.
- Main ilink without an exact cache match, some unified group broadcasts, process-terminated APNs/notification extensions/system CallKit first frames and unbound outputs remain unsupported/unverified.
- Message/advanced search, protected personal/detail/status routes and visibility editing require reveal; neutral discovery/badge output can hide ordinary activity cues.
- No real friendship/tag/publishing ACL/message/unread storage mutations were added by integration.

Files: settings and release-notes controllers, shared picker header/implementation, version header, README, control, root-prepared plan validation note, full docs/audits/close-friends-1.8-42 archive, and the new package. Detailed source changes are in the integration commit; .theos is preserved outside it.
