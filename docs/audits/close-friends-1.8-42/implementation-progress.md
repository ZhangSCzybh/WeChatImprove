# SDD ledger — plan: docs/superpowers/plans/2026-10-20-close-friends.md
Baseline: 929d265b; design/plan: 54762b7f; original checkout retained; branch codex/close-friends.
Ruling: User has approved the complete design and requested implementation including shared-group profile masking; no repeated approval gate.
Ruling: Preserve the established checkout and environment by using a dedicated branch in the same path; no alternate worktree/service/database delivery.
Ruling: task-brief helper failed because its sibling script is not executable; extracted exact global/interface/task text into per-task brief files without modifying installed skills.
Ruling: Native header discovery does not certify device behavior. Implement guarded adapters, package and host-test; record device acceptance pending unless evidence becomes available.

| Tasks | Shared boundary | Preflight result |
|---|---|---|
|1/2|Immutable policy, crypto/store|Foundation API contract stable; UI/security service only in task 2|
|2/3|Snapshot, policy change, account epoch|Group pure tests keep old initializers; no runtime import in projection|
|2/4|Native read/identity/hook helpers|All scoped; global CContactMgr relationship reads untouched|
|2/5|State and social policy|No source cache writes; adapters own derived view data|
|2/6|Journal writes, snapshot|Auth edits and trusted journal updates are separate APIs|
|3/6|Unread composition|Preserve real unread and avoid aggregate double subtraction|
|4/5|Tags and audience selectors|Task 4 contact candidates/tag display; task 5 Moments ACL controller owns editing gate|
|1–6/7|All new and existing behavior|Host test/build first, device coverage separately labeled|
|1|Policy/store tests vs output|Tamper and account boundary are semantic, not source assertions|
|2|Settings/auth/lifecycle|Requires credentials before enable, keeps hidden-entry recovery|
|3|Session tests/mapping|Native path validation remains on complete source|
|4|Profile/selection|False add is display only and cannot send requests|
|5|Social state|Global icons stay hidden while revealed; real ACL unchanged|
|6|Native side effects|Verified signatures, ownership/readback and exact call tokens|
|7|Delivery|Version 1.8-42 and no make clean or automatic installation|

Task 1: in progress; base 54762b7f.

Task 1: implemented 55219769; 209 focused checks passed; reviewer /root/cf_core_review examining task-1-review.diff.

Task 1: complete — 55219769, 209 checks; independent spec and quality Approved.
Ruling: compressed control-flow readability is minor/nonblocking; carry into Task 7 review instead of adding a security-neutral fix cycle now.

Task 2: in progress; base bde53cfe; implementer /root/cf_runtime_impl.
Native read-only research: surface /root/privacy_surface_evidence; alerts /root/privacy_alert_evidence; social root. No parallel production implementation.

Task 2 controller findings sent before final report: authoritative CSGroupCurrentAccountID lookup (no direct stale defaultCenter fallback); empty membership for mismatched account epoch/suspension so old-account silence/rejection cannot execute; password >=6 digits OR >=8 chars; cache immutable snapshot rather than normalize full member sets on every read. Implementer to fix and test, then independent review.
Task 2 integration ruling: add extern C guards to Task 1 C exports in their own headers, and extend PluginEntryTests doubles/assertions for new entry route; preserve existing regression assertions.
Social native research and device acceptance draft ready in SDD scratch for Tasks 5/7.

Task 2 initial implementation c7a7ed8f: 71 runtime, 209 core, 18 entry + 14 startup checks; arm64/arm64e object compilation passed.
Task 2 pre-review correction in progress with same implementer: separate monotonic reveal deadline from durable wall-clock cooldown; no review dispatched before final fix. Report concerned wall-clock rollback could extend 300-second reveal, so this is correctness work rather than a deferred disclaimer.
Native surface research complete: surface-native-report.md (37 classes, 2741 methods, 79 bounded funcs). Native alert report complete with follow-up narrowly examining main Ilink exact-room rejection; existing report path alert-native-report.md.
Ruling for final review package: bulk generated static methods/assembly can be excluded from inline diff while retaining file stats, manifests, scripts and authored findings; reviewer should review every production/test change and use original evidence files for named native-ABI concerns. Generated corpus is reference data, not executable plugin code.

Task 2 pre-review fix completed: 8f6d9d79, monotonic reveal/cooldown clocks separated; 76 runtime checks + arm64/arm64e compile. Independent review pending on bde53cfe..8f6d9d79.

Task 2: independent reviewer /root/cf_runtime_review dispatched against bde53cfe..8f6d9d79; awaiting spec and quality verdicts.
Native alert followup complete: alert-native-report.md section main ilink contains 63 evidence files/42 full functions. Ruling: without matching subcall cache, main ilink rejection remains unsupported; do not substitute MMConfSDKService or a global hangup. Confirmed-identity presentation suppression may proceed while preserving native end/cancel/timeout and mandatory completions. This prevents cross-call damage; cost is a documented rejected-call coverage gap pending device/runtime evidence.

Task 2: review Needs fixes. P1 default-runloop NSTimer can defer expiry during tracking; P2 duplicate native-entry removal block. Minor picker navigation/dismiss mismatch also recorded and carried into this existing fix dispatch to avoid a broken selection return. Fix round 1/5 pending with original implementer; review base 8f6d9d79.

Task 2: fix round 1/5 (I1, I2, M1 addressed, 0 important open; 8f6d9d79..50590087). Independent scoped review clean. 76 runtime + 5 scheduling, 21 entry + 14 startup checks, arm64/arm64e compile passed.
Task 2: minor (deferred): picker save failure alert is presented by settings while its picker modal is still shown; error explanation may be lost. Carry to Task7/full review for coherent dismissal/error handling.
Task 2 cannot-verify items resolved as scoped delivery boundaries: real Keychain/biometric lifecycle/scene covers/gestures pending device acceptance (explicit matrix A04/A06/A07/A09/A10), surface/alerts/DND belong to Tasks3–6. No device-protection claim made.
Task 2: complete (commits bde53cfe..50590087, spec and quality approved after one fix round).
Task 3: in progress; base 50590087; fresh implementer to own session projection/integration. Root performing read-only folded-chat candidate investigation alongside implementation.

Task3 scope ruling: group/All/session aggregate display belongs to Task3; app tab/icon/local-notification badge integration belongs to Task6. Folded sessions have separate ChatBoxSessionListViewController; focused folded adapter/hooks allowed to meet spec without overloading main adapter. Root read-only evidence is session-native-report.md (12 bounded functions). Cost of scope split is a documented Task6 handoff, not omission of app badges.

Task3 aggregate ruling: do not hide the entire folded container whenever any secret membership exists, because ordinary folded groups would lose navigation. Reuse CSGroupListAdapter/proxy for folded VC with forced All/no chrome if safe, and preserve original native coordinates. A reversible owned neutral cover on the original aggregate cell is allowed when hidden-child preview/dot attribution cannot be safely derived; source model stays unchanged. Cost: ordinary mixed-container previews may become neutral while hidden, but ordinary rows/navigation remain accessible. Folded logicGetCountForSection delegates table count, requiring native-read scope to avoid recursive projection.

Task5 read-only evidence enriched: WCDataItem NSObject/no verified NSCopying (isCopyingEnabled is extFlag UI policy), concrete native comment count/index/height and stale itemID like-layout cache found. social-native-report.md references social-presentation-native (15 funcs). Ruling: permit focused timeline/interaction/status/audience units under CSCloseFriend prefix instead of one oversized social file; costs additional small interfaces, keeps task behavior unchanged.

Task3 refinement sent: bounded read-only folded child assessment (none/mixed/all/unknown) avoids blank all-hidden entry and unnecessary preview masking of known ordinary groups; unknown retains neutral navigable entry. Session-native report already proves service getter/count/index candidates, so no speculative global filtering or source writes needed.

Task 3: implemented 0eca8028; 1,024 checks and affected arm64/arm64e objects pass; independent review pending 50590087..0eca8028. Native UI/device concerns remain acceptance items.
Ruling (latest user instruction): focus tests and regression on changed core behavior; do not repeat completed suites, broaden test matrices, or rerun evidence just for confirmation. During Tasks4–6 run focused behavioral checks and affected source compilation only; consolidate integration checks once in Task7. Review remains scoped to actual requirements, privacy/data safety and crashes. This supersedes earlier per-task broad-regression instructions.

Task3 independent review: one Important deferred native next/previous/unread command must recheck privacy after queue drain, not only enqueue. Fix round1 dispatched to /root/cf_session_impl from 0eca8028, focused reveal→enqueue→lock→drain test and affected hook compile only.

Task3: fix round1/5 (deferred traversal addressed; 0 open; 0eca8028..3cf088f2), scoped rereview approved. 41 session checks plus changed hook arm64/arm64e compile; no broad rerun. Device UI behavior stays in acceptance matrix; alert badge integration belongs Task6.
Task 3: complete (50590087..3cf088f2, spec and quality approved).
Task 4: in progress; base 3cf088f2; fresh implementer to own contacts/forward/search/profile.

Root prepared untracked durable native evidence in docs/audits/close-friends-1.8-42; 212 existing manifest entries verified during relocation. No native reanalysis. Task7 must commit this archive with final report and keep production implementation separate.
Ruling: unsupported message/advanced search result sections may be gated during concealment, preserving supported ordinary contact/group search and native query/cursor. Reliable structured sender coverage is not proven for every native result format; cost is reduced search availability until temporary reveal, documented as gated rather than filtered coverage.

Task4 narrow search ruling applied to forwarding too: verified SessionSelectMessageSearchLogic message-search route is gated during forwarding concealment, including in-flight result consumption, since group-author match identity cannot safely be filtered through unverified native message cloning. Ordinary contact/group recipient search stays filtered and available; native cursors/source unchanged. Core behavioral checks and affected arm64/arm64e compile passed before this final small gate.

Task4 controller core finding before report: ordinary group contact-search member-match highlights could expose a protected friend despite filtering by group username. Ruling: preserve ordinary group result/navigation but neutralize its page-owned secondary match summary during concealment; if exact secondary view unavailable, reversible owned public-identity row cover is allowed. Source model/text remains unchanged. Cost: ordinary member-match snippets are also absent while concealment is active. Sent to implementer for current task.

Task4 implemented7ced6a39. Focused behavioral fixture and affected four adapters/three hooks arm64+arm64e compile passed; no group/runtime reruns. Report records native route/device limits; independent review pending3cf088f2..7ced6a39.

Task4 review early findings: Important in-place native search container update mistaken for already-filtered buffers, causing prior query section restore; Important shared profile state authorizes old assist against replacement contact. Fix round1 dispatched to original /root/cf_surface_impl from7ced6a39, two focused regressions only; full review report pending.

Task4 cannot-verify followup (bounded metadata read only): current class inventory identified FTSFeatureMessageSectionController; search-feature-metadata.json proves it subclasses FTSMessageSectionController and overrides only title/type/config/display/mapping helpers, not hooked count/cell/select/update/search boundaries. Existing isKindOfClass gate therefore applies. FTSMsgScopeViewController is the search-bar scope view, not an independent result controller. No additional concrete bypass found; unobserved device routes remain pending Q01–Q03, no universal coverage claim. Evidence preserved directly in audit too.

Task4: fix round1/5 (both in-place search/retired assist findings addressed;0 open;7ced6a39..a77b0045), scoped review approved. Known FTSFeatureMessage inheritance is resolved by static evidence; actual UI/independent routes remain device acceptance, with no universal coverage claim.
Task 4: complete (3cf088f2..a77b0045, spec and quality approved).
Task 5: in progress; base a77b0045; fresh implementer to own social/ACL/status. Root-only modified plan validation note and untracked audit evidence are reserved for Task7.

Task5 implementer requested exact WCSNSMessage/WCUserComment/Topic identity ABI. Root performed bounded3-class metadata-only read using existing parser; social-identity-metadata.json supplied and preserved in audit. WCSNSMessage.comment/refComment, WCUserComment.username/refUserName/dataItemUsrName, TextStateTopicModel.usernames/topicId all verified @@:. ObjectIDs are not usernames. No repeated whole-target scan/disassembly.

Task7 deferred integration observation: showBadges option UI says 显示密友标记; currently only default/schema/settings uses observed. Confirm actual visual consumer by final integration; avoid shipping an inert switch. This is optional marker polish, not authorization to leak numeric badges. Core unread composition stays Task6.

Task5 Ruling: concealment uses a neutral cover on the publishing privacy page and authentication before all visibility-mode/selection edits, plus scoped publishing-owned ContactSelectView candidates and filtered summary formatting. Existing complete ACL remains untouched; success requires a fresh revealed operation and never replays stale callback arguments. Exact currentItem/params merge semantics are unproven. Cost: changing who-can-see while concealed requires temporary unlock even for an ordinary-only edit; avoids silently removing hidden ACL members. No further merge-contract research needed.

Task5 controller identified discovery Moments entry as concrete extra leak surface before report. Narrow metadata supplied discovery-metadata.json: Moment badge/count and head/red-dot object ivars. Ruling: neutralize only Moments entry head/dot/count while concealed if reliable attribution unavailable, restore on reveal and retain entry/unrelated Discover rows. Cost: ordinary Moments activity hints are also neutral during concealment; avoid source read/delete and do not zero whole Discover aggregate.

Task5 implemented ffaccc52; focused production adapter fixture and6changed units+hook arm64/arm64e strict compile pass. Reports explicit gate/neutral-display tradeoffs, source/ACL intact. Independent review pendinga77b0045..ffaccc52.

Task5 review early Important: publishing ContactSelectView itself was not tracked/covered/reloaded on relock; Rows reused revealed candidate projection without epoch/policy checks. Fix round1 dispatched to original /root/cf_social_impl fromffaccc52: bind actual picker, validate current epoch/revision, immediate shield/reload and reject stale selection; one reveal-open-picker→relock regression. Full review report pending.

Task5 full review confirms two Important findings: publishing picker relock and interaction render using stale source indexes after in-place native replacement. Original implementer is fixing both in round1; only two focused regressions plus affected compile. Other reported UI/navigation/runtime items are device acceptance, with no additional static bypass established.

Task5 fix round1 e459b2ba addressed both original findings; scoped review found new Important normal completion regression: retained pending binding rejects revealed onDone after weak picker/logic deallocates. Round2 dispatched to original implementer from e459b2ba to separate completed operation authorization from live view ownership, preserving stale-callback denial. One successful picker-dismiss→onDone regression plus affected compile only.

Ruling: to honor user efficiency, Task7 task review and the final broad branch review may be delivered by one reviewer in one read-through, with separate Task7 spec/quality and whole-branch verdicts. This preserves both required review scopes while avoiding a second pass over the same integration changes; any findings enter one consolidated final fix wave and scoped rereview.

Task5 fix round2/5 (normal completion addressed, 0 open; e459b2ba..3e757d92), scoped spec and quality Approved. Both original privacy findings were fixed in round1. Focused social tests and changed dual-arch source compile passed; no broader regressions. Device gesture/layout/status window/cover restoration remain explicitly pending acceptance.
Task 5: complete (a77b0045..3e757d92; two scoped fix rounds; spec and quality approved).
Task 6: in progress; base 3e757d92; fresh implementer owns alerts, DND, calls and payment summary gates.

Task6 clarification: temporary reveal restores list presentation, not notification cues; application/chat-tab badge composition must apply silenceMessages independently of revealed list totals using the single validated session source owner. Unknown native contributions are neutral, never inferred by subtracting membership counts. True unread remains unchanged.

Task6 Ruling: cached subcall rejection may require exact inviteInfo object, room and caller agreement; group primary invitations use the separate verified MultiTalkReject route. Unmatched or unsafe type3 broadcast routes remain rejectionUnsupported with independently confirmed presentation suppression. Existing evidence does not justify broadening receiver routing, and the user's efficiency request rules out another speculative native study; cost is conservative unsupported call coverage recorded in delivery.

Task6 implemented f747a6a4: focused alerts57 + payment privacy6, affected arm64/arm64e compilation passed. Independent /root/cf_alert_review examines3e757d92..f747a6a4; no prior tests repeated. Actual capability/coverage boundaries documented in task-6-report.md, including native-only completion retention, observed DND setters, unsupported unbound/system call and notification paths, neutral stale-source badge.

Task6 review has one Important: observed external native edit proceeds after failed journal revocation; old applied/owned record can revive on reload and overwrite that edit on disable. Round1 from f747a6a4 dispatched to original implementer.
Task6 Ruling: accept process-bound restoration ownership plus process-retained revoked-transaction tombstones. External native edits must continue; same failed journal cannot prove durable revocation after restart, and a second fallible persistence path would add complexity without universal guarantee. Successful current-process transactions still restore; prior-process records cannot reacquire ownership automatically. Cost: automatic DND may remain after restart when a contact is removed or feature disabled, requiring a manual native change. This conservative limitation must be explicit in settings/footer, audit and final handoff, and scoped failure/reload tests.

Task6 fix round1/5 (durable revocation finding addressed, 0 open; f747a6a4..b0a81135), independent spec/quality Approved against process-bound restoration ruling. Focused failure reproduced before fix;59 checks and changed mute adapter dual-arch compile passed. No unrelated reruns.
Task 6: complete (3e757d92..b0a81135; review approved; documented restart and native route limits remain).
Task 7: in progress; base b0a81135; final integration/version/package/docs. Combined Task7 task gate + final whole-branch review will follow once, as ledgered.

Task7 integrated core scripts + directly affected entry/payment privacy passed once; package build succeeded, metadata checks ongoing. Picker error delivery uses explicit opt-in completesAfterDismissal on existing picker with default behavior preserved. Inert showBadges row omitted, schema retained. DND restart limitation added to settings/docs.
Ruling: .theos is tracked by this repository; preserve current generated build outputs on disk and exclude cache churn from the integration commit. Commit source/docs/audit and new package. Record generated working-tree changes explicitly rather than resetting the user's build directory or mixing build cache into review.

Task7 integration complete: picker deferred save, inert showBadges row omitted, process-bound DND UI/docs explicit; all six close-friend core scripts + entry/startup + payment privacy passed once. Package 1.8-42 rootless dual-arch built and metadata/hash/source/prior-artifact checks passed. Device acceptance pending; combined final review follows. .theos retained, excluded from commit.

Task7 implementation complete6987c113 + documentation e98c5ace. Integrated core/entry/payment checks once and package passed. Verified arm64/arm64e, minOS15.0,22exports perarch, UUID, source/staged/package bytes and455source inputs; prior5artifacts preserved. Package1,074,430bytes SHA256146e7a37e6482106c81b991836bd7e6ba2c48207402ff91d7eef0659a7135932. Build warnings are documented deprecated APIs/old linker flag, not errors.
Combined Task7 task gate and final branch review dispatched to /root/cf_final_review with929d265b..e98c5ace package. No deployment or device acceptance claimed.

Final review early Important candidate: positively bound stale notification subjects return shouldSilence=NO and output hooks can pass old-account/epoch UN/QuickReply/localInfo to native display. Must distinguish unknown subject from known stale output, drop stale presentation while honoring completions and without applying old policy to new account. Await full findings before one consolidated final fix wave.

Combined final review complete: Task7 spec/quality Approved; whole branch Needs fixes for one Important I1 (bound stale notification output); no Critical. M1 preexisting carried compact security control-flow readability and M2 documented build warnings nonblocking.
Final consolidated fix wave dispatched to /root/cf_integration_impl from e98c5ace for I1 only; focused actual notification output regression plus required package/manifest refresh. Unknown/unbound output stays native, positively stale output discarded, exact request matching/mandatory completions retained. No unrelated test or formatting expansion.

Final fix wave: I1 stale bound notifications addressed in 06aeaa37; real UN output reproduced failure then 71 focused alert checks passed. Only affected alerts and final package rerun, unchanged suites reused. New 1.8-42 package/hash and explicit historical-vs-final evidence recorded; one scoped rereview pending.

Final fix wave implemented06aeaa37 (source/tests) +16ffb180 (package/audit). Added stale-output discard distinct from current membership silence; real output and cleanup fixtures RED→71checks GREEN. Rebuilt package and verified delivery, reusing unaffected initial checks. Current package1,077,776bytes SHA256f9ed41cfbcb43332a09205f56be7639b3cbcc9fe1645cfc0f71af820436e72cc; prior5artifacts unchanged. Single scoped final rereview dispatched to original /root/cf_final_review on e98c5ace..16ffb180.

Final scoped rereview complete: I1 ADDRESSED, no new breakage. Whole branch Approved for code/package delivery with explicit device-pending/coverage limits; zero unresolved Critical/Important findings. M1 readability/M2 documented warnings remain nonblocking.
Task 7: complete (b0a81135..16ffb180; combined task gate + whole-branch review + one consolidated fix wave/scoped rereview approved).
Delivery: final package1.8-42,1,077,776bytes,SHA256f9ed41cfbcb43332a09205f56be7639b3cbcc9fe1645cfc0f71af820436e72cc; original checkout/data/prior artifacts preserved, .theos generated changes retained. No install/push/merge or device acceptance claimed. Final reports/decisions archived before retiring this plan's scratch workspace.
