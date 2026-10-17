# Device follow-up correction implementation — 1.8-2 candidate

Implementation date: 2026-10-18. Base: d88dfcdb on `codex/message-actions-refactor-1.7-17`. Only checkout `/Users/zhangshichao/.codex/worktrees/message-actions-refactor/WeChatImprove` was edited. This is a source correction for independent review, not a released/package-installed result. Version remains 1.8-1 until the separately authorized release step. Original checkout, existing packages, shared `.theos`, device, account/data and services were not changed. No make clean, install, live send, push or merge ran.

Binding scope: task-1-brief.md and requirements.md under `.superpowers/sdd/2026-10-18-message-actions-device-followups/`, plus the approved unified-message-actions design except the user's newly explicit type42 long-press repeat requirement. Existing account-scoped service proxy dispatch and the closed forward-binding cleanup guard remain intact.

## Evidence and correction

The static evidence targets extracted WeChat8.0.78.34 arm64, SHA256 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`. The user's actual reported app is WeChat8.0.78. Static artifact identity is not proof of the installed runtime's exact image, current voice status or file contents. See the separately maintained `native-menu-text-v2/report.md`, `native-voice-report.md`, and their manifests/assembly. No native contract is inferred from host test doubles.

### Normal return and truthful outcomes

The selected native send route now records `nativeHandoffReturned` only after its actual final send call returns normally. The voice route does not set it merely after AddLocalMsg/local-ID assignment; it sets it after the selected concrete uploader returns. Exceptions and insertion/authorization ambiguity retain a false marker. Coordinator results remain Unknown where no native acceptance/delivery observation exists; no route becomes Succeeded or Accepted solely from return/ID. Normal native-owned status no longer produces the generic failure-like uncertainty popup. Exceptional Unknown and actual pre-submit failures remain visible, including mixed-target results. Ledger claims, no replay, and per-target ownership are unchanged.

### Text owner and ABI

For native BaseMsgContentViewController ancestry, resolve concrete `m_delegate` and require BaseMsgContentLogicController ancestry, then the existing exact `SendTextMessage:` void/object ABI. The native getter and owning-logic assignment are proven by current binary metadata/disassembly. No unwrapping, arbitrary delegate traversal or new synthetic signature support was introduced. Existing older explicit logic/controller routes remain available outside that native page shape. Target must still match the captured conversation. Plain text and Unicode emoji remain exactly the same type1 route and payload.

### Native menu construction

Add missing independent `operationMenuItems` hooks for AppEmoticonMessageCellView, AppFileMessageCellView and ShareCardMessageCellView. Keep the existing six hooks and shared adapter, and admit type42 in menu policy. Native `uniqMenuItems:` deduplicates numeric menuType; the prior two plugin actions both used0, causing voice repeat to disappear and allowing collisions with host items. Plugin actions now use distinct positive application namespace IDs (base0x43535001/2), scanning the current menu to skip numeric collisions. These numbers are application choices, not claimed native reserved constants. Host/other-plugin relative ordering and existing action-based dedup remain unchanged. No global menu hook or post-filter append was added: native restricted-title/delete-only/VisionPro filtering stays in control.

MMMenuItem's weak target is mirrored in the new test fixture; the existing item-associated invocation keeps the immutable operation context alive. A reused cell's historical menu item remains rejected rather than sending the replacement message.

### Voice source readiness and safe download eligibility

Native status is interpreted as a bitmask: bit0 means downloaded; outgoing recordings additionally require bit3 finalized. Played/play-sounded bits no longer cause a completed source to be redownloaded. Both incoming1/5/17/21 and outgoing9/13/25/29 are covered. Recording source status1/5/17 refuses. Native outgoing XML intentionally lacks network length/end flags; absence is distinct from explicit endflag0/cancelflag1. Cancellation from XML or the forwarded native voice-cancel getter is sticky.

Prefer the verified instance `getVoicePath`; retain verified class `getPathOfAudio:` as a capability fallback. Snapshot forwarded voice bytes/metadata on main, read file bytes and validate on the serial media queue. Stable size/mtime and byte count, positive duration/known format, declared length when present, and native codec duration are all required. Native SILK/OPUS header recognition handles the raw format -1/4/7 cases without invoking native file-reading getVoiceFormat on main. Native duration must agree within the existing20ms tolerance; the original source duration is retained in milliseconds. A terminal download callback never bypasses byte/codec validation. There is no new media size cap or arbitrary accepted-format whitelist.

Completed local, outgoing, recording, malformed or cancelled sources never invoke a speculative repair download. This matters because the proven native CGI download path can remove an existing audio file. Download requests are limited to incomplete incoming remote sources with serverID and positive declared length. Unsupported downloader/service/exception returns immediate failure rather than leaving a misleading60-second wait; eligible requests keep the existing60-second bound, shared subscriptions and cancellation. EndFlag1/ErrNo3 proceeds, nonterminal callbacks wait, terminal non-success finishes failure, and late completion cannot reopen a retired operation.

After the original native callback, the provider optionally refreshes only that waiting source through current-account CMessageMgr `GetMsg:LocalID:` (@/object/uint ABI). Returned type, from/to, localID and serverID must match. It does not replace/mutate the operation's captured source. Native GetMsg is a general lookup plus status normalization, not universally side-effect-free: native image status branches may write. The focused evidence shows ordinary type34 bypasses those status writes and VoiceMsgDownloader itself uses this same exact getter. Service dispatch remains through the registered account proxy. Missing refresh capability uses the existing source snapshot and still requires full byte validation; mismatched returned source fails closed.

### Native success UI and cleanup

The exact enhanced native logic's `bShowSendSuccessView` returns NO and `bHiddenSendSuccessToastView` returns YES. Both are needed because disabling the success sheet alone enables the fallback success toast. All original confirmation, comments, dismissal and manager cleanup handlers still run. The existing compact enhancement binding remains through post-cleanup getter calls; it is cleared when the same logic begins a new unrelated forwardMessage invocation. Unbound and reused unrelated logic returns original getter results. Global notification/toast behavior was not changed.

## Regression evidence

Tests compile production controllers and extract actual production Logos menu/voice getter/cleanup bodies. Native-shaped fixtures include a page with only m_delegate, a logic sender, weak MMMenuItem target, fresh independent concrete menu builders, numeric menu dedup followed by restricted filtering, forwarded payload extension, current-account NSProxy services, and separate persisted/UI source wrappers. They do not contact WeChat or send messages.

Initial RED observations before the corresponding production fixes:

- Native text shape: `FAIL line253: route` (page lacks the invented m_logicController and SendTextMessage methods).
- Native menu pipeline: `FAIL line390: shown.count==(i==2 ? 4 : 3)` (dedup collision/missing builder hooks).
- Native voice duration fixture: `FAIL line456: !NSThread.isMainThread` (old codec validation ran on main; additional final mutations prove the old status equality fails).

Final host validation:

- `bash Tests/verify-message-actions-execution.sh`: **416 checks PASS**.
- `bash Tests/verify-message-actions-core.sh`: **1362 checks PASS**.
- `bash Tests/verify-message-gesture.sh`: **272 checks PASS**.
- `bash Tests/verify-message-time.sh`: **142 checks PASS**.
- `bash Tests/verify-message-merge.sh`: **53200 policy/navigation +2872 adapter/lifecycle checks PASS**.

Execution checks include normal text/image/type49 no-popup, exception Unknown visible/no replay, target mismatch and unrelated delegate refusal, both sticker classes/file/card menus, host numeric collision, both voice actions, repeat toggle independence, restricted native menu filtering, stale menu context, incoming/outgoing status combinations, missing/unknown/mismatched/truncated/growing source bytes, recording/explicit XML and native cancellation, shared download cancellation, exact callback correlation, fresh persisted source versus stale UI wrapper, wrong persisted serverID, terminal error, unsupported downloader, duplicate callbacks, forward cleanup while waiting, success getter order after cleanup, unbound/reused logic, account invalidation and source/fresh-output ownership.

Four isolated temporary source mutations all produced expected assertion failures (no compile failure), recorded in `implementation-mutation-results.txt`: wrong text owner, normal-return popup, numeric menu collision, and voice equality1/9. Production files were never mutated for these controls.

Final strict target syntax: all five modified controller implementations and both Logos-transformed hooks pass arm64 and arm64e, iOS SDK27.1/minimum15, ARC/blocks, `-Wall -Wextra -Werror` (generated unused parameters excluded). Logos transforms use `warnings=error`. The substrate framework search path is required; an initial command without it failed to locate CydiaSubstrate headers, then the corrected invocation passed. `git diff --check` passes. No package was built in this task.

## Remaining acceptance and handoff

Independent code review is next. Parent owns any subsequent version1.8-2 packaging and release documentation, preserving1.8-0/1.8-1. No post-fix phone install/send/recipient-playability, native UI timing, real codec corpus or performance acceptance was performed. The20ms native duration tolerance and format inference still need actual source/recipient checks on the established user device; conservative refusal produces visible failure and never destructive download or Unknown replay. Static evidence plus host validation must not be described as device success.
