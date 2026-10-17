# Message actions 1.8-0 release evidence

Source commit: `53ee70c5d3a2d5f29a3c8e66cbe8f14aa1ea072d`; source baseline: `2aa7bcb8`; branch: `codex/message-actions-refactor-1.7-17`.

These are host, compile and static package checks. No device load/install, live send, received-media/playback acceptance, FPS, latency or energy measurement was performed. The native static artifact is the locally extracted WeChat8.0.78.34 arm64 image documented in the sibling `message-actions-native-2026-10-17` evidence directory; it is not proof of current installed phone identity or universal subtype equivalence.

## Host regression

All commands ran in the isolated worktree; exit status0, clean host output. Eight suites, **66,587 checks** total. Each log contains its full compiler/test stdout+stderr. The runners compile actual production components with platform/native doubles; temporary host binaries/default suites are isolated by the runners.

| Command | Checks | Log |
| --- | ---: | --- |
| `bash Tests/verify-message-actions-core.sh` | 1362 | [core](message-actions-core.log) |
| `bash Tests/verify-message-actions-execution.sh` | 202 | [execution](message-actions-execution.log) |
| `bash Tests/verify-message-gesture.sh` | 272 | [gesture](message-gesture.log) |
| `bash Tests/verify-message-time.sh` | 142 | [time](message-time.log) |
| `bash Tests/verify-message-merge.sh` | 53200 + 2872 | [merge](message-merge.log) |
| `bash Tests/verify-bubble-style.sh` | 8269 + 111 | [bubble](bubble-style.log) |
| `bash Tests/verify-revoke-interception.sh` | 73 | [interception](revoke-interception.log) |
| `bash Tests/verify-revoke-reference.sh` | 84 | [reference](revoke-reference.log) |

Cross-entry cases exercise shared policy and production coordinator/menu/media/gesture/lifecycle components: independent gesture/menu/voice toggles, native-forward eligibility, exact operation targets, confirmation/cancel/late callbacks, A/B partial refusal, Unknown without fallback, repeated Ended suppression and deliberate fresh actions, source reuse/settings/page/account invalidation, background media completeness/cancellation and merge/time/bubble ownership. The gesture harness uses a facade double and the execution harness separately exercises the real coordinator; this is component integration, not an installed full UIKit flow.

## Fresh build and artifact

[Build provenance](build-provenance.json) records exact command, SDK/compiler, fresh empty build location, source commit before packaging, start/end timestamps and exit status0. Both `THEOS_BUILD_DIR` and Theos' `_THEOS_LOCAL_DATA_DIR` were assigned a newly created directory outside the checkout; the latter prevents reuse of tracked `.theos` object files. Output packages went only to this isolated checkout. No clean target ran. All **777 preexisting `.theos` files** hashed identically before/after; scoped Git status also remained clean for `.theos`.

[Full build log](rootless-build.log) includes all source/Logos compilation, both links, merge/sign/stage/package and exit status. There are26 known preexisting warning occurrences: CSAuthorizationManager openURL (6), CSContactSeparatorSettingsViewController weakSelf (2), HideSettingHooks title (2), ReceiveTransferHooks unused variables/windows (8), RedEnvelopHooks unused variable/function/statusBarFrame (6), obsolete linker multiply_defined flag (2). Each source warning repeats across architectures. None originates in the new action/gesture/lifecycle components or the release notes. These unrelated warnings remain deferred.

[Artifact verification](artifact-verification.log) and [manifest](artifact-manifest.json) record metadata, rootless dylib/plist paths and equivalent package injection filter, exact arm64/arm64e slices,15 required Objective-C classes and11 defined exports per slice. [Verifier](verify-artifact.py) reruns against the deb while production inputs still match the recorded source commit. The plist is converted by Theos, so semantic equality is checked through `plutil` JSON.

The verifier decodes class literals, selector-reference slots and direct `MSHookMessageEx` registrations in each packaged slice's actual `otool` disassembly: **33 required class/selector pairs** per slice. [arm64 registrations](arm64-hooks.json) / [arm64e registrations](arm64e-hooks.json) include call addresses and replacement IMP addresses, with nearby [arm64 instructions](arm64-hook-instructions.txt) / [arm64e instructions](arm64e-hook-instructions.txt). Some common-cell methods also have preexisting bubble hooks; multiple recorded sites are expected. Symbol logs retain matching exported C bridges/Objective-C class metadata. Static registration evidence does not prove runtime hook availability or successful device injection.

Package SHA-256: `35e571eea2e900f0784ae3ee051b44cc0cc90e73c0255ec4735ccf49b6543d47`.

[Prior package hashes](prior-packages.json) were captured before building and all four were checked unchanged afterward. Only `com.wechat.improve_1.8-0_iphoneos-arm64.deb` was added. Historical task reports1/2/3 moved here verbatim; ignored scratch copies remain for final reviews. Report contents describe their own historical stage, not device acceptance. Baseline logs predate this final run.

Final Task4 and whole-branch independent review remain the parent task's responsibility. Any subsequent production change requires a new source commit, fresh package and updated verification; evidence-only commits may follow this package source commit.
