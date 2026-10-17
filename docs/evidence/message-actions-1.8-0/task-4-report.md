# Task 4 report: release metadata, regression and Rootless package

Status: DONE_WITH_CONCERNS (device acceptance remains unperformed; independent final review owned by parent).

## Scope and provenance

Authorized isolated checkout: `/Users/zhangshichao/.codex/worktrees/message-actions-refactor/WeChatImprove`; branch `codex/message-actions-refactor-1.7-17`; task starting commit `01889f34`; whole-branch base `2aa7bcb8` (1.7-17). Read Task4 brief, global constraints, release decisions, implementer prompt and finalized reports1/2/3 plus native static report/ordinary contracts; did not read the raw assembly corpus. Brainstorming was applied as an already approved bounded release task, preserving approved design decisions. No subagents or reviewers dispatched.

Updated `control`, `Headers/CSUserInfoHelper.h` and Chinese in-app notes to1.8-0. Updated current README/build examples and added `docs/message-actions-1.8-0.md` describing actual behavior and four evidence levels. No production refactor or new behavior was added in this release task; no new low-impact metadata tests were invented.

Source/release metadata commit **53ee70c5d3a2d5f29a3c8e66cbe8f14aa1ea072d** (`release: document unified message actions 1.8-0`) was made before packaging. This report and the package are included in a subsequent artifact/evidence commit (`release: retain verified 1.8-0 Rootless package evidence`); its identity is obtainable through `git log -1 -- docs/evidence/message-actions-1.8-0/task-4-report.md`.

Task1/2/3 reports were copied verbatim to `docs/evidence/message-actions-1.8-0` and old tracked scratch paths removed with `git rm --cached`. Ignored scratch copies remain untouched for parent reviews. Native evidence manifests were not modified.

## Validation and self-review

Eight final suites passed with pristine host output, **66,587 checks**: core1362; execution202; gesture272; time142; merge53200+2872; bubble8269+111; revoke interception73; revoke reference84. Full commands and durable compiler/test stdout+stderr are in the evidence README and individual `.log` files. No new TDD was required because scoped production changes are release metadata only. Existing production behavior tests provide the pertinent regression coverage.

Cross-entry checks consume shared settings/policy, real action execution/menu/coordinator/media adapters and gesture/lifecycle harnesses. Covered independent toggles, repeated gestures/callbacks, exact targets/partial refusal, native confirm/cancel boundaries, unknown-no-replay, source and account invalidation, media cancellation/completeness, and time/merge/bubble/revoke compatibility. Gesture facade and native/UIKit objects use doubles; no installed end-to-end acceptance is claimed.

Self-reviewed scoped source/release diff, report migration and final evidence. `git diff --check` passes. Parent owns independent Task4 and final whole-branch review and any related fixes. No important new implementation finding arose in this metadata/package scope. Full dual-architecture build emitted26 occurrences of known unrelated warnings (detailed provenance in evidence README), with no new action/gesture/lifecycle warnings; no unrelated cleanup was added.

## Build and actual artifact verification

Fresh full `make package SCHEME=rootless` succeeded with absolute Theos path `/Users/zhangshichao/theos`, SDK27.1, iOS15 minimum, arm64+arm64e. Exact argv, timestamp, source commit and empty initial build directory are recorded in `build-provenance.json`; complete stdout/stderr in `rootless-build.log`. Both build and local Theos data directories were assigned a unique temporary directory, preventing tracked/stale object reuse. No `make clean` or `.theos` backup/restore was needed.

Actual deb: `packages/com.wechat.improve_1.8-0_iphoneos-arm64.deb`.
SHA-256: **35e571eea2e900f0784ae3ee051b44cc0cc90e73c0255ec4735ccf49b6543d47**.
Deb metadata: `Package: com.wechat.improve`, `Version: 1.8-0`, `Architecture: iphoneos-arm64`. Actual payload dylib/plist: `var/jb/Library/MobileSubstrate/DynamicLibraries/WeChatImprove.{dylib,plist}`; package filter matches source and targets com.tencent.xin. Dynamic library slices are exactly arm64 and arm64e, embedded version1.8-0 present.

Both packaged slices contain15 expected Objective-C action/lifecycle classes in actual metadata and11 defined C exports, including distinct `CSMessageActionNativeObject` and legacy `CSMessageNativeObject`. Actual packaged disassembly resolves33 required class/selector Hook pairs per architecture, with registration and IMP addresses preserved in JSON plus instruction excerpts; this is static registration code, not runtime device acceptance. Verifier exited0 and logs the source commit/hash.

All four prior packages match before/after SHA-256 snapshots. All777 preexisting local `.theos` files match before/after hashes; scoped Git status for `.theos` is clean. No original checkout path was edited. Original service URL/ports/database are not applicable to this isolated tweak build; no service, database, account or live installed app was accessed or substituted. No install/send/push/merge occurred despite the Makefile's standard install suggestion. Fresh temporary build remains available for parent review at `/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-message-actions-1.8-0.3cytyaeh`.

## Residual concerns

Current-phone installed image identity, real UIKit arbitration/pop/voice controls, native picker/confirmation/comments/cancel, actual recipient payload/playback, account-switch native ordering, representative app/media subtypes and performance need device acceptance. Static local8.0.78.34 evidence and host doubles cannot prove universal subtype equivalence or server delivery; no FPS/latency/power numbers are claimed. Design thresholds remain parameters, not measurements. If final review changes production inputs, the parent must regenerate/reverify the package on the fixed source. Keep plan scratch until reviews/fixes finish.
