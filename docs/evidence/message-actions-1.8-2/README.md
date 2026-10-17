# Message actions1.8-2 release evidence

Implementation `27c4e60307b53d50504cebb49033e8d9834858d4`; approved source/evidence `f94d7cb372ce98ed90884733732f66fc20fc8e53`; build source **b4bb3414e0735260a9c901e28505afab1a2b4d76**. Task1 [review](task-1-review.md) approved with no confirmed blocking findings. User instructed direct packaging without new review rounds.

The five reported1.8-1 device defects and corresponding fixes are described in [release notes](../../message-actions-1.8-2.md) and [fix report](fix-report.md): misleading normal-handoff popup, missing type-specific repeat menus, wrong native text owner, premature native voice success UI, and stuck/local-voice media preparation. Earlier1.8-0 common menu/gesture failure facts remain, as do six historical package files.

## Host and native evidence

[Host validation](host-validation-reported.json) is the parent-supplied implementer-reported tool-execution record:5 unchanged host suites,58,264 checks (execution416, core1362, gesture272, time142, merge53200+2872), final strict arm64/arm64e syntax pass and four expected source-mutation assertion failures. Raw host stdout/stderr was **not retained as files**; transcript references are reported execution evidence, not raw logs or log hashes. No unchanged suite was rerun for version-only edits.

[Native manifest verification](native-evidence-verification.json) rehashes33 voice and47 menu/text manifest entries, all matching. Native reports/manifests and assembly were preserved. The evidence targets extracted8.0.78.34 arm64 SHA-256 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`; user reports WeChat8.0.78, exact current-phone image unproven. The20ms duration agreement rule is a conservative assumption that may refuse usable audio, not a proven universal native acceptance rule; reviewer suggested optional boundary coverage, no production blocker.

## Fresh target build and actual artifact

[Build provenance](build-provenance.json) records the exact pre-build source SHA, command, SDK27.1/minimumiOS15/compiler, timestamps, fresh empty temporary build/data directories and exit0. Both THEOS_BUILD_DIR and _THEOS_LOCAL_DATA_DIR were assigned the fresh location; no stale tracked objects or clean target. Full build stdout/stderr is retained in [rootless-build.log](rootless-build.log), distinct from the unretained host test output. Both modified Logos files and controller sources compiled for both architectures.

The build retains26 known unrelated warning occurrences: CSAuthorizationManager openURL6; CSContactSeparatorSettingsViewController weakSelf2; HideSettingHooks title2; ReceiveTransferHooks variables/windows8; RedEnvelopHooks variable/function/statusBarFrame6; obsolete multiply_defined linker flag2. Parallel output may interleave; no unrelated cleanup was added.

[Verifier](verify-artifact.py), [verification log](artifact-verification.log), [metadata](package-metadata.txt), [contents](package-contents.txt) and [manifest](artifact-manifest.json) verify actual deb1.8-2/iphoneos-arm64, Rootless dylib/plist paths, equivalent injection filter, embedded version and exactly arm64+arm64e slices. Each slice has15 required ObjC classes,11 defined exports and **43 required Hook class/selector pairs** decoded from actual packaged registration instructions. This covers all9 concrete menu builders and both scoped voice-success getters, plus existing lifecycle/account/forward/download hooks. JSON registration/IMP addresses and focused disassembly/symbol logs are retained; static instructions are not proof of runtime injection.

Package `packages/com.wechat.improve_1.8-2_iphoneos-arm64.deb` SHA-256 **c0ced2cce61ed9b0502c4967606444b36aa8fc35f820f7532778513d94e4c396**.

[Six prior package hashes](prior-packages.json), including1.8-0 and1.8-1, remain unchanged. All777 preexisting .theos files hashed identically before/after; scoped Git status clean. No original checkout, service, database/account, device or historical evidence was changed. No install/send/push/merge. Fresh build retained at provenance's temporary path.

## Limits and delivery

This is direct package delivery after approved fixes, with no new review wait. No1.8-2 device acceptance, real sends/receipt/playback or FPS/latency/power measurement occurred. Native handoff/Unknown is not delivery, no universal subtype-equivalence claim. Any later production change requires a fresh corresponding package. Scratch report remains for parent cleanup.
