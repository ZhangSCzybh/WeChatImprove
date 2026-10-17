# Task 2 report: shared action execution, media and native forwarding

Date: 2026-10-17. Implementation and isolated host/target compilation complete; not deployed and not device acceptance.

## Scope and environment

Worktree `/Users/zhangshichao/.codex/worktrees/message-actions-refactor/WeChatImprove`, branch `codex/message-actions-refactor-1.7-17`, starting implementation base `68bbb0d2`. Only six new controller pairs, `Hooks/RepeatHooks.xm`, `Hooks/VoiceForwardHooks.xm`, the execution test/runner and this report are part of this task's commit. Task 1 headers were consumed without alteration. Native evidence belongs to the parent task and is excluded from this source commit.

No live WeChat/account/device was used. No message was sent, service started or restarted, database opened or migrated, package installed or generated, existing package removed, original checkout changed, or shared `.theos` used. No push/merge or `make clean` ran. Runtime send calls in tests target local Foundation doubles. Native UIKit behavior is compiled, not live exercised.

Read before route decisions: task brief/global constraints/Task 2 decisions, Task 1 report and authoritative headers; native `report.md`; follow-up `ordinary-repeat-contracts.md` and method metadata. Brainstorming skill was read in the context of the existing approved architectural design and implementation instructions; approved decisions were not reopened.

## Baseline inventory and route migration

All three legacy hooks were inspected. Original attempts and actual binary ownership are different evidence levels; the implementation preserves payload/entry capabilities while removing retry APIs that can delete historical rows and zero-ID queue calls that cannot enqueue correctly.

| Type | Legacy paths inspected | Shared route and ownership |
|---|---|---|
| Text 1 | Repeat logic `SendTextMessage:` / externInfo; gesture adds controller text compatibility | Pick one supported logic/controller text selector before invocation. Preserve source content, multiline and Unicode. No exception fallback. |
| Image 3 | Both repeat paths copy wrap then `ResendMsg`, then queue fallback | Independent factory input preserving lookup IDs; detach `m_oImageInfo` before `imgMsgFromMsgWrap:`; fresh output IDs; one `AddMsg` owns storage/image upload. |
| Voice 34 | Repeat/gesture queue + AddLocal + multiple resend/upload fallbacks; voice hook additionally patches global factories and rescans manager logics | Shared complete source resource; fresh type34 per target; exact current sender/target/time/client identity; preflight `AudioSender.uploaderForMsgWrap:`; one `AddLocalMsg`, then that concrete uploader once. Never call AudioSender resend on original or output. |
| Video 43 | Dedicated generator, CaptureVideoInfo, generic generated wrap, AddVideo/AddShortVideo/queue branches | Clear forwarding cache only on detached input, generate independent CaptureVideoInfo, normalize specified recipient and keep `m_bForward=YES` to preserve source files. Pick one supported AddVideo/AddShortVideo ABI. Returned fresh wrap is retained for correlation; never cascade after invocation. Distinct generated-wrap compatibility uses one AddMsg. |
| Emoji 47 | Menu AddEmoticon; gesture adds MD5/XML parsing, CEmoticonMgr lookup, logic/tool-view object compatibility, queue | Copy full payload and extension rather than regenerating dice/game content; preserve/parse MD5. Pick AddEmoticon, or pre-resolve emoji object and pick a supported logic/tool-view entry, or complete generic AddMsg compatibility. No post-invocation alternate route. |
| Card 42 | Explicit gesture branch; menu allow-list excludes42 | Card factory on independent input + one AddMsg; menu exclusion retained while gesture remains eligible. |
| Location 48 | Menu supports; generic queue in both paths | Distinct location factory output or complete copy, identity reset, one AddMsg. |
| App 49 | Image/card/app ResendMsg and generic queue; file/reference and newer payloads travel in copied extensions | App factory on detached source preserving lookup IDs; native record/note AddRecord; file historical data path + AddApp DataPath; other app payload data + AddApp Data. Source app path resolved before IDs reset, reads off main. Missing required file/data fails before submission. |
| Other ordinary types | Gesture generic copy/queue compatibility | Complete distinct native copy + fresh IDs + one native AddMsg, without a newly narrowed gesture allow-list. System/control types10000/10002 are rejected. Native capability/preparation failure is visible. |

`ResendMsg` is deliberately absent: artifact evidence shows ChangeForDisplay/source-ID lookup and conditional DelMsg(input). `AddMsgToSendTable` is absent from plugin sending: native AddMsg/AddApp/AddEmoticon/AddVideo own their queues and insertion. No arbitrary generic-forward replacement or unchanged legacy send method remains.

Static evidence establishes native construction/ownership and units, not every subtype's exact repeat equivalence. Image HD/CDN/live media, file/record/reference, miniapp/Finder/music and gaming emoji still require representative device comparison. App native factories apply forwarding transformations; broad native subtype preservation is implemented, but universal repeat equivalence/deep nested immutability is not claimed from this evidence alone.

## Interfaces and coordination

`CSMessageActionCoordinator.h` is the Task 3 facade:

- `captureContextForCell:controller:bindingGeneration:`, `validateContext:`, `canExecuteContext:action:entry:`, `executeContext:action:entry:`.
- `cancelOperationID:`, `cancelOperationsForCell:`, `cancelAllUnsubmittedOperations`, account ID/epoch/settings and per-target `resultsForOperationID:`.
- `accountWillChange` invalidates and suspends immediately on main; `accountDidChange` resumes with a fresh epoch/account. **Use the C native-boundary markers in native account hooks:** `CSMessageActionAccountWillChangeAtNativeBoundary()` before logout, and `CSMessageActionAccountDidChangeAtNativeBoundary()` after login. They update an atomic generation/suspension flag immediately on the calling native thread without services/UI, then enqueue main cleanup. Pending callbacks check the marker before capture/claim/invocation and before the voice uploader after local insertion.
- Forward bridge methods carry the same operation through native opening/binding/confirmation/per-target dispatch/cleanup. `executeContext:Forward` uses synchronous opening scope; nested BaseMessageCellView `onForward:` reuses it rather than allocating another operation.
- An injected environment, sender, native adapter and media provider support invocation-recording host tests. Default production environment resolves native services afresh; no account service is cached. Main-thread source capture/metadata and UI operations retain Task 1 rules.

One bounded operation owns one ledger. Targets register only from the exact native logic's final `getToContacts` snapshot at `ForwardMsgList:ToContact:WithRevokeBatchId:`—after native confirmation waiting/refusal branches. Targets are username-deduplicated without scanning other logics/payloads. Only matching source + exact logic + registered target can reach the plugin voice submitter. Native confirmation, picker selection, comments, dismissal/reporting and cancel methods continue through original implementations. Confirmation cancellation keeps the picker binding.

A native UI-completion callback never sends and is not delivery evidence. Cleanup is independent of feature toggles. A compact terminal marker remains on each cleaned native logic to suppress matching late voice callbacks: it keeps weak source identity plus immutable IDs/usernames and operation ID, with no source/resource/page/targets/ledger/service ownership. Reusing a closed logic replaces this marker; active binding cannot be overwritten by another operation. A late callback never recreates an operation/ledger or selects another route.

Per-target results remain separate, including A accepted/B explicitly refused. Actual void native sends are conservatively Unknown; no return/local ID/completion is presented as network success. `CSMessagePreparedSend` catches side-effect exceptions as Unknown and never invokes another route. Native BOOL/object/scalar/out-object ABIs are checked and invoked accurately; delete passes real BOOL values and revoke receives the actual wrap, not a view.

Light actions have no media/ledger. Quote route is selected before invocation, delete/revoke retain confirmation, confirmation revalidates identity/account/capability, favorite/forward honor native predicates where available. Revoke uses the live cell's per-message BOOL predicate, without hardcoded time rules. Native feedback remains authoritative; plugin does not announce favorite/send success from void returns.

## Media, lifetime and feedback

The single serial media queue reads immutable snapshots and file paths off main. Voice preparations share a source resource across operation subscribers and targets. XML `length` is byte length; `voicelength` and `m_uiVoiceTime` are milliseconds. Format zero is valid and distinguished from missing metadata. Completion requires positive duration, valid metadata, stable file size/mtime around reading, and either declared complete byte length, matched terminal completion plus full-byte revalidation, or verified codec duration agreement. Status1/9 alone is insufficient. No magnitude-based duration conversion or file-size cap is used.

Only native EndFlag1/ErrNo3 continuation (original callback first) correlates account/epoch/chat/local ID/server ID. A source download is shared, no fixed-delay readiness assumption and no idle polling. Missing media has a cancellable progress panel on the available native presenter; already-ready media does not show a needless download dialog. Cancelling one subscriber does not stop another/native shared download. Cancellation during an actual background read suppresses late completion and submit. Timers weakly reference preparations, so completed/cancelled reads do not remain retained until timeout.

Metadata capacity is32 active operations/preparations and64 subscribers per preparation, not a recipient/file-size limit. Backpressure and missing/unsupported data produce visible feedback. Preparations time out after60s; operation ownership is bounded at180s. Completed result retention is32 operations. No source file is modified/deleted; native outgoing wrap/queue own handed-off upload data, with no plugin temp-resource deletion on return.

Committed repeat and established native forwarding outlive cell reuse; short UI actions are cancelled with cell invalidation. Pages/cells/native logic are weak. Multi-target results show accepted/unsubmitted/cancelled/unknown counts, avoiding method/class names and delivery claims. If the originating page is offscreen, bounded account/epoch/chat-scoped feedback is shown when that conversation is bound again. Progress-panel placement across real native picker presentation and all final feedback timing still need device UI verification.

Menu injection/canPerform/execution share one policy. Item order, selectors, white cached icons, line/menu values and type42 entry distinction remain. Each actual menu target owns its creation context, so rebuilding a menu after cell reuse cannot retarget an older item. Legacy action selectors remain thin handlers. No unconditional debug menu traversal or manager-wide recipient collection remains.

## Validation

Commands ran in this worktree and temporary copies only:

```text
bash Tests/verify-message-actions-core.sh
PASS: 1362 message action core checks (isolated defaults suite; no native sends)

bash Tests/verify-message-actions-execution.sh
PASS: 162 production action/coordinator/native/media checks (host doubles, no native sends)
```

Execution runner compiles actual production core, coordinator, menu, native, media, sender and forward bridge with Foundation, ARC/blocks and `-Wall -Wextra -Werror`. UIKit icon/presenter construction compiles only for iOS; host native/menu/service doubles record real production invocation arguments and ownership.

Coverage includes: multiple targets; accepted/refused retained results; duplicates and cleanup tombstones; wrong logic/source/target; facade Forward's exact operation identity; text mutation then exception with zero alternate calls; local voice insertion then exception and upload then exception; format0/exact1234ms; distinct outgoing wraps and immutable original IDs/users; actual BOOL confirmation invocation/revalidation; toggle-off cleanup; cancel before media and during a real background read; account switch and same-account suspension; weak page lifetime; source-shared download and correlated continuation; partial-media refusal; image nested input independence and outgoing IDs; card; video cached descriptor/recipient/forward/source preservation and returned fresh wrap; app record/file/Data route choice/off-main read/source path preservation; generic payload; actual production menu snapshot/reused-cell stale click/order/de-duplication/entry policy.

Two isolated mutation copies prove behavior assertions reject the main regressions; production files were untouched:

```text
EXPECTED RED menu-recapture-reused-cell : FAIL line216: !controller.calls.count
EXPECTED RED exception-treated-as-safe-refusal : FAIL line176: [text submit]==CSMessageActionSubmissionStateUnknown
```

Target strict syntax checks for all six new controller implementations passed for arm64 and arm64e with iOS27.1 SDK, target iOS15, ARC/blocks and all warnings as errors.

A full temporary checkout-source copy (including HeadersFile, excluding .theos/packages) ran `make all SCHEME=rootless -j4` and compiled/linked both architectures successfully. Initial temporary copy omitted HeadersFile and failed on unrelated ListCornerRadiusHooks import; corrected copy passed. No make clean/package/install ran. Final source subset—including both thin Logos hooks, all six new implementations and the three core files—was compiled/linked again in a fresh temporary Theos tree after later menu/atomic account changes:

```text
Final isolated scoped Theos exit:0
Linking tweak WeChatImprove (arm64)
Linking tweak WeChatImprove (arm64e)
Merging tweak WeChatImprove
Signing WeChatImprove
```

Logs are `/tmp/wechat-task2-theos.log` and `/tmp/wechat-task2-theos-final.log` for this session; temporary build trees were removed. Existing full-project warnings remain outside this task; final Task 2 compile has no source warnings, only the existing obsolete multiply_defined linker option warning. `git diff --check` passed.

## Downstream requirements and remaining acceptance limits

1. Task 3 must migrate legacy gesture execution/lifecycle/time/merge hooks and wire the verified account logout/login C markers. The legacy gesture implementation remains until that task, as required. Shared native onForward hooks already apply to it but do not replace its legacy repeat code in this intermediate commit.
2. Gesture admission/Changed must use cached settings/context/capabilities; do not repeatedly call account/service resolving capture/revalidation there. Ended submits this facade once after geometric restoration.
3. Native source existence is guarded by live captured binding/native predicates and the original native methods; no raw database checks are introduced. Confirmation/lifecycle invalidation must continue to cancel detached UI actions.
4. Static native evidence targets extracted WeChat8.0.78/build8.0.78.34. Runtime ABI checks fail closed on absent/mismatched APIs, but installed-image identity and cross-version behavior remain unverified.
5. No live server acceptance/delivery observer was established. Real native void routes remain Unknown and never auto-retry. Accepted/refused host injection exercises ownership/results without pretending to prove delivery.
6. Native UI confirmation, picker/comments/cancellation, progress placement, page changes, menu target/icon compatibility, media file/download states, all ordinary subtype repeat equivalence and end-to-end playable/openable recipient payloads require device comparison before release. App nested subtype/delegated location builders have residual native ownership/semantic uncertainty explicitly documented by the evidence; no universal deep-copy or exact-repeat claim is made.
7. The atomic marker closes queued-callback invalidation before main cleanup. It cannot make an individual opaque native method atomic with WeChat account transitions already concurrent inside that method; post-insertion invalidation yields Unknown and never another sender.

## Review round 1 correction — native payload forwarding and voice XML flags

Addressed both material findings in `task-2-review-findings.md`. The original direct-property host fixture hid a native mismatch: the studied CMessageWrap delegates type-specific payload selectors through `forwardingTargetForSelector:` to `m_extendInfoWithMsgType`. The native adapter now resolves this exact path only for CMessageWrap instances, verifies the concrete getter and forwarder ABIs, requires the forwarder to select that exact type-extension object, then checks/invokes its concrete method ABI. Synthetic signatures, arbitrary forwarding targets, unrelated forwarding objects and recursive forwarding chains are not accepted. Direct native methods retain their previous handling. Task 1 context/service/UI getters remain concrete-only.

The native boundary now includes an object payload getter, used consistently for voice bytes, image-info detachment, emoji MD5 and app attachment ID. Scalar getters/setters and Supports/Invoke share the same checked receiver resolution. Existing production send tests now run against a wrapper whose voice/image/app/emoji properties are `@dynamic` and actually forward to a separate extension, including fresh outgoing voice construction. Image independence and app declared-data/remote-ID guards therefore exercise the real ownership/dispatch shape.

Voice preparation parses presence-aware `endflag` and `cancelflag` attributes from the `voicemsg` tag. Explicit nonterminal state cannot be accepted merely because duration/status/declared byte count match. A correlated terminal native callback can supersede that earlier nonterminal metadata after revalidation. Cancellation is sticky within the preparation and always refuses, including at a terminal callback. Flags are freshly read before background work and again before accepting its result, so cancellation arriving during the file read refuses. Historical messages with absent flags retain the existing length/codec/terminal completeness routes; no new file-size or recipient restriction was added.

Test-first evidence before production changes (line numbers from the red test revision):

```text
bash Tests/verify-message-actions-execution.sh
EXPECTED RED: FAIL line 185: CSMessageNativeSupports(forwarded,@"setM_uiVoiceTime:",@"v",(@[@"I"]))

CS_TEST_VOICE_FLAGS_ONLY=1 bash Tests/verify-message-actions-execution.sh
EXPECTED RED: FAIL line 321: !accepted
```

The independent flags-only run used status1, a stable five-byte file, declared length5, positive1234ms and format0, so its failure proves the prior provider accepted explicit `endflag=0`. This run intentionally bypassed the earlier forwarding assertion. The final suite also covers immediate cancelled-source refusal, cancellation observed at a correlated terminal callback, cancellation during a real background read, absent-flag historical acceptance, wrong extension target, unrelated forwarder, wrong scalar/object ABI, image nested independence, fresh outgoing voice fields and forwarded app attachment guards.

Final validation:

```text
bash Tests/verify-message-actions-execution.sh
PASS: 202 production action/coordinator/native/media checks (host doubles, no native sends)

bash Tests/verify-message-actions-core.sh
PASS: 1362 message action core checks (isolated defaults suite; no native sends)

Strict iOS syntax: six Task 2 controller implementations passed arm64 and arm64e,
ARC/blocks, -Wall -Wextra -Werror, iOS SDK27.1 / minimum iOS15.
```

This correction was tested in the authorized worktree and temporary host test directories. It does not add device acceptance evidence; the previously documented installed-runtime, native UI and recipient-playability limits still apply. No native send, device install, original-checkout edit, service switch, database change, shared `.theos` mutation, package, push or merge was performed.
