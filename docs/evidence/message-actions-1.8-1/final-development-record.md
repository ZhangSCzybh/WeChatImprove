# SDD ledger — plan: docs/superpowers/plans/2026-10-17-unified-message-actions.md

Base: 2aa7bcb8. Documentation commit: 7ffc8e2d.
Workspace: /Users/zhangshichao/.codex/worktrees/message-actions-refactor/WeChatImprove
Branch: codex/message-actions-refactor-1.7-17
User approved complete implementation and packaging; no repeated permission required.

## Preflight
| Pair/task | Shared interface / internal consistency | Finding |
|---|---|---|
| 1 / 2 | context/settings/action/state headers feed coordinator | Task 1 publishes exact names before Task 2 starts |
| 1 / 3 | pure gesture policy/config snapshot feeds adapter | one source of enum/defaults/thresholds |
| 2 / 3 | captured context execute facade | Task 2 publishes interface before Task 3 starts |
| 3 / 4 | adjacent merge/time hooks plus tests | regressions required, not just core tests |
| 1 | policy invariant tests vs pure types | consistent |
| 2 | per-target state vs unknown no fallback | consistent; native evidence awaited |
| 3 | transform ownership vs existing merge guard | explicit lifecycle ordering needed |
| 4 | build/release scope vs no device writes | package only; device evidence must not be claimed |

Native research agent: /root/native_contracts, read-only binary investigation; docs only. No parallel implementation agents.
Task 1 base: 7ffc8e2d.
Task 1 implementation: c6858a45; implementer /root/action_core. 1362 core checks + four mutation checks + dual-arch syntax pass. Review /root/review_core running against 7ffc8e2d..c6858a45.
Native research: complete, docs/evidence/message-actions-native-2026-10-17/report.md. Evidence-only arm64 artifact; no device run. Crucial: preflight uploader before fresh voice AddLocalMsg; never AudioSender.ResendVoiceMsg or voice GenForwardMsg factory on source; exact-logic per-target forward interception; download EndFlag1/ErrNo3 after original callback; live per-message revoke capability.
Ruling: submission ledger lifetime is per bounded operation/batch, not account-wide — prevents unbounded retained records without introducing replay persistence — late callbacks must never recreate retired owner.
Task 1: complete (c6858a45; review_core spec compliant, quality Approved, no findings). Cross-task checks assigned to Task2/3: native capabilities, coordinator bounded owner/account lifecycle, deployed UI import/reset semantics. No task1 gap remains.
Native evidence/baselines committed 68bbb0d2.
Task 2 base: 68bbb0d2. Brief task-2-brief.md, supplemental task-2-decisions.md, globals global-constraints.md. Ordinary repeat native research continues read-only with native_contracts.
Task 2 implementer: /root/action_execution. Exact facade header published Controllers/CSMessageActionCoordinator.h. Native research followup reveals CMessageMgr.ResendMsg also destructive; prohibit source or source-ID clone input. Fresh AddMsg owns normal insertion+queue+send, app49 subtype needs AddAppMsg route. Voice units confirmed milliseconds by Silk20ms/frame and Opus*1000 calculation. Implementation informed; followup evidence pending.
Task 2 implementation: 0fa406c1; implementer /root/action_execution. 1362 core +162 execution checks, two mutation checks, strict dual-arch syntax and temporary full/scoped Theos builds passed. Review /root/review_execution running against 68bbb0d2..0fa406c1. No shared .theos changes.
Ordinary native research complete, ordinary-repeat-contracts.md includes exact app DataPath outarg, XML length bytes/voicelength ms, valid format0, MMContextManager logout/login ABI and ordering. Evidence committed separately after Task2.
Task3 integration note updated: call exported atomic account boundary C markers on native hook thread (logout before original, login after original); coordinator observes before each side effect. Task2 report records interface and known actual-device limitations.
Task 2: fix round 1/5 begins, review_execution found two Important defects (forwarded CMessageWrap payload fields rejected by concrete-only ABI boundary; voice readiness ignores explicit cancellation/end flags). Findings task-2-review-findings.md. Fix base96f2fcd7 (reviewed source0fa406c1, intervening evidence-only commit). Resume original action_execution; tests MessageActionExecutionTests.m/verify-message-actions-execution.sh + affected target syntax.
Task 2 fix round1 implementation6f82e553 complete. Forwarded native extension fields + voice end/cancel metadata fixed. Red/green202 execution +1362 core +dualarch strict syntax recorded in report. Scoped re-review /root/rereview_execution against96f2fcd7..6f82e553 running. Worktree clean.
Task 2: fix round1/5 complete, both findings ADDRESSED by rereview_execution, no new breakage.
Task 2: complete (0fa406c1 +6f82e553, evidence96f2fcd7; source review clean).
Task 3 base:6f82e553. Brief task-3-brief.md; globals global-constraints.md; task-3-decisions.md details lifecycle ordering/account atomic marker requirements.
Task 3 implementer:/root/gesture_lifecycle. Proposed C block lifecycle scheduler wraps complete Common/Voice subclass-super native call chain with depth guards; time exports private-state bridge refresh/reset; gesture detach -> merge restore -> native -> time prepare -> merge render/time final position -> gesture reapply. Native account C markers wired immediate thread boundary. No parallel implementation.

Task3 integration: full dual-architecture link exposed duplicate external CSMessageNativeObject between old chat bridge and new action bridge. Existing Task3 implementer owns scoped rename to CSMessageActionNativeObject and execution regression; old bridge semantics preserved. Owned rebound animator and incompatible host-transform cancellation added before task review.
Task3 implementation01889f34 complete: gesture272/time142/core1362/execution202, adjacent merge/bubble/revoke pass; strict dualarch syntax and full isolated Theos compile/link pass. Three mutation regressions expected RED. Fresh task review pending.
Task3: review_gesture spec compliant and quality Approved, no Critical/Important findings. Cross-task settings constant adoption resolved by Task1 reviewed implementation; UIKit/device performance explicitly outside host validation and pending authorized device acceptance.
Task 3: minor (deferred): pre-existing unrelated build warnings and obsolete multiply_defined linker option; final broad reviewer to retain as known noise.
Task 3: complete (6f82e553..01889f34, review clean).
Task4 base01889f34, fresh implementer for release metadata/final regression/package/evidence.
Final review package scope: include all production/tests and source docs, native evidence reports/manifests, release verification; omit raw asm, bulk class/method/ivar metadata, package binary, generated symbol/instruction dumps and scratch. Full diff stats remain included; raw files stay available for concrete evidence questions.
Task4 implementation53ee70c5 source +6edeedd1 artifacts. review_release spec compliant, quality Approved, no blockers; independent hash/metadata/prior4 package checks pass. .theos preservation supported by fresh external output command and clean scoped Git status; original checkout remains codex/list-corner-foundation with its preexisting unrelated changes, untouched by this task.
Task 4: minor (deferred):26 existing unrelated full-build warning occurrences (same Task3 debt), no host test warnings.
Task 4: complete (01889f34..6edeedd1, scoped review clean; broad review follows).
Final review base2aa7bcb8 head6edeedd1; package source53ee70c5.

User device regression after installing1.8-0: all three enabled; no repeat/voice menu and no gesture displacement. Delivery is NOT accepted; prior host test success insufficient. Final review still running; prioritized shared native environment/context admission. New read-only native_entry_contracts verifies MMServiceWrapper path; single fix_device_regression implementer owns meaningful production-environment repro and consolidated fix wave. Fix base6edeedd1. Preserve faulty1.8-0 and publish corrected package1.8-1 only after fix review/fresh verification. No device install/send authorization.
Final review returned exactly2 P1 blockers: native MMServiceWrapper rejection disables all entries/services; closed forward binding cleanup cancels confirmed pending media. Both reproduced RED with production boundaries by fix_device_regression, fixing in ONE wave. No additional confirmed Important/Critical. Findings final-review-findings.md.
Consolidated fix2a1c5148: both blockers reproduced independent RED and fixed; production-environment admission now account=me/context=yes/menus2/gestureyes. Actual extracted send/cancel/clearData Hooks exercised with nested native cleanup.8 suites66626 checks pass (execution241), durable report docs/evidence/message-actions-device-regression-2026-10-17/report.md. No production Hook ordering change (original already before orig); closed-binding guard fix. Scoped re-review pending.
Fix final commit1808c982 supersedes2a1c5148 by report-only amendment recording24 whitespace notices in raw hashed disassembly; production/tests identical. Permanent fix report is docs/evidence/message-actions-device-regression-2026-10-17/README.md (not report.md). Reviewer informed exact range.
Final fix scoped review review_device_fix APPROVED1808c982: both P1 ADDRESSED, no new breakage; actual production-environment/proxy + extracted cleanup hook coverage verified, all37 native evidence hashes independently match. Corrected release1.8-1 dispatched to original release_package implementer with release-1.8-1-brief.md; tests66626 already on final production source.
Corrected1.8-1 release source82ae74f0 /artifact16ba3add. review_release APPROVED: independent actual deb metadata/hash/dylib slice/version, all5 predecessor hashes and8 exact test-log hashes match; no new blocker. Package SHA256b2344c95af5992868651498fc1a635c0a1108c7c8c89c9f3064588e15c932296. Post-fix user-device acceptance remains pending, no installation or real send done by this task.
Final status: implementation, reproduced device-regression fixes, scoped review, fresh corrected package and artifact review complete. Branch/worktree retained by existing user authorization. Original checkout untouched.
Ruling consequence clarification: operation-scoped bounded submission records do not support persistent recovery/replay after process restart; preserving terminal markers within native logic is required to suppress late duplicate callbacks.
