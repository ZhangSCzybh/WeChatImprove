# Corrected message actions 1.8-1 release evidence

Reviewed production fix: `1808c982edd31e54127afba72053216dec98898b`.
Build source commit: `82ae74f0b3330de0520ae6da833b56a150ea9427`.
Branch: `codex/message-actions-refactor-1.7-17`; original source baseline: `2aa7bcb8`.

## Known faulty predecessor and review

User reported missing menus and no gesture movement on plugin1.8-0 / WeChat8.0.78. Its package remains byte-identical, retained for history. This package includes the service-proxy admission fix and first-terminal-outcome preservation for confirmed forward intents waiting for media. No Hook-order production change was made. [Review outcome](review-outcome.md) records the parent-reported two P1 findings, both ADDRESSED by scoped `review_device_fix` review of exact fix1808c982, no new Important findings; parent owns final release review.

## Host and native evidence retained

The fix owner just ran **8 suites / 66,626 checks**, exit0: core1362, execution241, gesture272, time142, merge53200+2872, bubble8269+111, revoke interception73 and reference84. [Host evidence references](host-regression-reference.json) retain exact commands, original committed log paths and SHA-256 hashes. The original logs and two RED controls in `../message-actions-device-regression-2026-10-17/` were preserved; they were not rerun or rewritten for version-only changes. Execution includes actual production environment/proxy admission plus extracted native completion/cancel/clearData hook bodies, while UIKit/native objects remain host doubles.

[Build provenance](build-provenance.json) confirms the only production/test changes after reviewed fix1808c982 were version display and in-app release-note metadata; `control` version and release documentation were also updated. No execution behavior or test file changed. The source commit was recorded before build.

[Native evidence check](native-evidence-verification.json) confirms all **37** entries in the service-entry manifest match their SHA-256 hashes. [Static service report](../message-actions-native-2026-10-17/service-entry-report.md) concerns locally extracted8.0.78.34 arm64 binary SHA-256 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`. That evidence and the user's actual8.0.78 failure report are distinct; current installed phone image identity was not established.

## Fresh build and actual package

[Full build log](rootless-build.log) and [provenance](build-provenance.json) record the exact absolute-Theos command, SDK27.1/compiler, minimumiOS15, empty initial temporary build directory, start/end UTC and exit0. Both `THEOS_BUILD_DIR` and `_THEOS_LOCAL_DATA_DIR` use that new temporary directory, with only package output directed to this isolated worktree. Both fixed production files compiled for both slices. No clean target ran, no stale tracked objects were reused.

The full build retains **26** known warning occurrences across both architectures: CSAuthorizationManager openURL(6), CSContactSeparatorSettingsViewController weakSelf(2), HideSettingHooks title(2), ReceiveTransferHooks unused variables/windows(8), RedEnvelopHooks unused variable/function/statusBarFrame(6), obsolete multiply_defined linker flag(2). Parallel diagnostics occasionally interleave in the raw log. No unrelated warning cleanup was added; none belongs to the fixed action/coordinator files or new release notes.

[Actual artifact verifier](verify-artifact.py) passed; [verification log](artifact-verification.log), [metadata](package-metadata.txt), [payload listing](package-contents.txt) and [artifact manifest](artifact-manifest.json) record1.8-1 / iphoneos-arm64, rootless dylib/plist paths, semantic source filter equality, and exactly arm64+arm64e slices. Each packaged slice contains15 expected action/lifecycle classes and11 defined C exports. Actual packaged `otool` instructions resolve33 required class/selector `MSHookMessageEx` pairs per slice; JSON registration/IMP addresses, focused instruction excerpts and symbol logs are retained. These are static registration instructions, not evidence of actual device injection.

Package: `packages/com.wechat.improve_1.8-1_iphoneos-arm64.deb`.
SHA-256: `b2344c95af5992868651498fc1a635c0a1108c7c8c89c9f3064588e15c932296`.

All **5** [prior package hashes](prior-packages.json), including known faulty1.8-0, were checked unchanged. All **777** preexisting local `.theos` files hash identically before/after, and scoped Git status is clean. The 1.8-0 evidence directory was not edited. Fresh build files remain at the temporary directory recorded in provenance for review.

## Acceptance boundary

No post-fix install or device acceptance, real send/receipt/playback, FPS/latency/energy measurement, original-checkout edit, service/database/account operation, push or merge occurred. Unknown is not delivery evidence, and neither host/native/package checks establish universal subtype equivalence. Parent owns final release review/delivery; a later production change requires another fresh build and package verification. Scratch reports remain until parent cleanup.
