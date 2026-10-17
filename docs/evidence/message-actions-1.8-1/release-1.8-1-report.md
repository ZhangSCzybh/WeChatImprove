# Corrected release1.8-1 report

Status: DONE_WITH_CONCERNS — release metadata and fresh verified package complete; post-fix device acceptance remains unperformed, parent owns final release review/delivery.

## Scope and commits

Work only in `/Users/zhangshichao/.codex/worktrees/message-actions-refactor/WeChatImprove`, branch `codex/message-actions-refactor-1.7-17`, starting reviewed fix `1808c982edd31e54127afba72053216dec98898b`, whole-branch base `2aa7bcb8`. Read release1.8-1 brief, permanent fix report, service-entry static report and prior verifier/provenance. Followed existing approved release design, no new production behavior or Hook ordering changes and no subagents.

Source/release commit: **82ae74f0b3330de0520ae6da833b56a150ea9427**, `release: prepare corrected message actions 1.8-1`. It precedes the full package build. Artifact/evidence commit is the new commit containing this report, subject `release: retain verified corrected 1.8-1 Rootless package`; exact SHA is returned to parent after commit, with no amendment after reporting.

Updated `control`, `Headers/CSUserInfoHelper.h`, Chinese release notes and current README examples to1.8-1. Added `docs/message-actions-1.8-1.md` and this version's separate evidence directory. Marked1.8-0 release doc/README as known faulty following user's actual WeChat8.0.78 report, linked corrected release, preserved the old package and historical evidence bytes. In-app notes use plain Chinese and describe menu/gesture and pending-voice cancellation corrections without private engineering labels.

## Existing fix/review and host verification

Parent reports exactly two P1 blockers from final broad1.8-0 review. Consolidated fix1808c982 resolved native service proxies rejected at account/execution admission, and native cleanup reprocessing a successfully closed forward binding as cancellation. Scoped reviewer `review_device_fix` marked both ADDRESSED with no new Important findings on that exact fix. Durable `review-outcome.md` records the carried review result and parent ownership of final release review.

No8-suite rerun for these version-only edits. Preserved/referenced the fix owner's exact committed logs via SHA-256 in `host-regression-reference.json`:8 suites **66,626 checks**, all exit0 (core1362, execution241, gesture272, time142, merge53200+2872, bubble8269+111, revoke73+84). The execution suite exercises actual production environment/service proxies and extracted native terminal/cleanup hook bodies; native/UIKit objects remain host doubles. Before building, production/test diff from1808c982 was verified limited to the version header and release-note controller; all execution and test files are unchanged. No new TDD applies to metadata/docs.

All37 file hashes from native service-entry manifest reverified successfully and retained in `native-evidence-verification.json`. Native static target remains local extracted8.0.78.34 arm64 SHA-256 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`, not a verified current phone image. No raw assembly corpus was read or rewritten.

## New build and artifact evidence

Fresh full `make package SCHEME=rootless`, absolute Theos `/Users/zhangshichao/theos`, SDK27.1, minimumiOS15, arm64+arm64e, exited0. Exact argv and source commit before packaging are retained in `build-provenance.json`; complete stdout/stderr in `rootless-build.log`. Both Theos build and local-data directories were set to a uniquely created initially empty temporary directory, excluding tracked/stale object reuse. Both fixed production implementations compiled for both architectures. No clean target ran.

Actual artifact: `packages/com.wechat.improve_1.8-1_iphoneos-arm64.deb`.
SHA-256: **b2344c95af5992868651498fc1a635c0a1108c7c8c89c9f3064588e15c932296**.
Metadata checked in actual deb: `Package: com.wechat.improve`, `Version: 1.8-1`, `Architecture: iphoneos-arm64`; actual dylib/plist under `var/jb/Library/MobileSubstrate/DynamicLibraries/`; injection filter matches source semantically. Dylib slices exactly arm64 and arm64e, embedded version1.8-1 present. Each packaged slice verifies15 required ObjC classes,11 defined exports and33 required class/selector hook pairs using actual `otool` static registration instructions, with addresses/excerpts saved. Static registration evidence does not prove device loading.

All5 previous packages including faulty1.8-0 match prior hashes. All777 old `.theos` files match before/after hashes, scoped status clean. Known unrelated build warnings persist (26 occurrences, same baseline sources/linker flag; parallel diagnostics interleave); full provenance retained without unrelated cleanup. Self-review checked scoped diff, truthful version/device distinctions, source-before-artifact provenance and actual package verification. `git diff --check` passes.

## Environment and limits

No original checkout edit, install, real send, service/database/account operation, reset/migration, push or merge. Service URL/ports/database do not apply to this isolated tweak build; no user environment was substituted. Fresh temporary build retained at `/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-message-actions-1.8-1.3pu850xn` for parent review. Ignored report copied to `.superpowers/sdd/2026-10-17-unified-message-actions/release-1.8-1-report.md`; scratch retained for parent cleanup.

User's1.8-0 failure is acknowledged; post-fix phone install/acceptance has not happened. Real UIKit arbitration/menu recovery, native picker/comments/cancel, media receipt/playback and performance remain device boundaries. No universal subtype equivalence, server delivery, FPS/latency/power claim. Parent owns final scoped release review and final delivery; any later production change requires fresh package and updated evidence.
