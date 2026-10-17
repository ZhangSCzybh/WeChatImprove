# Task2 release1.8-2 report

Status: DONE_WITH_CONCERNS — fresh corrected package and evidence complete; device acceptance remains unperformed. User requested direct packaging with no additional review rounds.

Worktree `/Users/zhangshichao/.codex/worktrees/message-actions-refactor/WeChatImprove`, branch `codex/message-actions-refactor-1.7-17`, starting approved source/evidence `f94d7cb372ce98ed90884733732f66fc20fc8e53`, implementation `27c4e60307b53d50504cebb49033e8d9834858d4`, original base2aa7bcb8. Read Task2 brief, Task1 requirements/report/review and relevant native manifests. No subagents.

Source/version/docs commit **b4bb3414e0735260a9c901e28505afab1a2b4d76**, `release: prepare message actions device corrections 1.8-2`, precedes build. Artifact/evidence commit is the subsequent commit containing this report, subject `release: retain verified message actions 1.8-2 package`; exact SHA returned after commit, no amendment after report.

Updated control/version header/Chinese in-app notes/current README examples to1.8-2; added release doc explaining the five user1.8-1 defects and accurate changes, plus a historical feedback annotation in1.8-1 doc. Existing1.8-0 failure facts and all old package/evidence bytes preserved. Included parent-owned host-validation-reported.json and copied APPROVED Task1 review permanently; no confirmed review blocker, no further review wait. No production behavior or tests changed in this release step; production/test diff from approved source limited to version header/release-note controller.

Host evidence retained as supplied tool-execution report:5 suites **58,264 checks** (416 execution,1362 core,272 gesture,142 time,53200+2872 merge), final dualarch strict syntax and4 expected mutation assertion failures. Raw host stdout/stderr not retained as files; no invented log hashes or raw-log claim, no unchanged suite rerun. No new TDD needed for metadata/docs.

Rehashed both retained native manifests,33 voice+47 menu/text=80 entries, all match; reports/manifests/assembly untouched. Static source is local extracted WeChat8.0.78.34 arm64, not proven current phone binary.20ms voice duration agreement is a conservative assumption, optional boundary-test suggestion is documented, not a new production blocker.

Fresh full make package SCHEME=rootless with absolute THEOS=/Users/zhangshichao/theos, SDK27.1 minimumiOS15, initially empty temporary THEOS_BUILD_DIR and _THEOS_LOCAL_DATA_DIR, exited0. Full stdout/stderr, exact command/source SHA/timestamps in build-provenance.json/rootless-build.log. No make clean or stale tracked objects; both modified hooks/controllers compiled for arm64+arm64e.26 known unrelated warning occurrences remain documented, no unrelated cleanup.

Artifact **packages/com.wechat.improve_1.8-2_iphoneos-arm64.deb**.
SHA-256 **c0ced2cce61ed9b0502c4967606444b36aa8fc35f820f7532778513d94e4c396**.
Actual metadata1.8-2/iphoneos-arm64, Rootless dylib/plist paths, semantic injection filter equality, embedded version, exactly arm64+arm64e verified. Per slice15 required ObjC classes,11 exports and43 required Hook class/selector pairs checked in actual packaged disassembly, including all9 menu builders and2 voice-success getters; addresses/excerpts saved. Static registration does not certify device loading.

All6 old packages and777 old .theos files unchanged by hashes/scoped status. Self-check scoped diff and git diff --check passed. Original checkout, service URL/ports/database/accounts/media/preferences not accessed/substituted; no install/send/push/merge. Fresh build retained at `/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-message-actions-1.8-2.ah6943zj` for inspection. Scratch report at .superpowers/sdd/2026-10-18-message-actions-device-followups/task-2-report.md retained.

Limits:1.8-2 post-fix phone acceptance, actual menu/text/voice behavior, media receipt/playability, UI success timing and performance unperformed. No delivered/succeeded inference from normal native handoff or Unknown, no universal subtype equivalence/FPS/latency claims. Parent can deliver now without new review rounds; any later production change requires package regeneration.
