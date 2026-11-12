# Native transport and BgFg result review — 2.5-13-online.3

**Final disposition:** the initial and intermediate findings documented below are resolved in the final reviewed bridge SHA-256 `03a71d855c247152165b61a8c534b508d326ae0bb6dd7c580c9a5ed8ce423f6d`. The reviewer checked the final source and the matching validation evidence; no remaining blocker was identified within this review scope. Historical findings are retained with their resolved status for traceability. Offline validation does not establish device latency or server delivery.

This is an independent static review of the proposed transport bridge. It is not a device/runtime validation and does not establish that group pat delivery is fixed. No production sources, tests, builds, target process, or REA session were modified or run by this review. The user’s corrected observation is that both online.1 and online.2 can be intermittent, including with the plugin’s own keepalive; delayed cases may deliver after manually returning foreground. There is no established deterministic online.1-to-online.2 regression or HBB-only failure.

## Target identity and evidence

- WeChat 8.0.80.34, arm64, image base `0x100000000`.
- Binary: `/private/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-crash-141902-g68h12mb/WeChat`.
- UUID: `7E4A8171-5ACC-3A72-A76A-3ACE52D3D895`.
- SHA-256: `e484889f7e32adce054e6b19bef373e2d1c3eb6984bc01176bbd40906373f317`.
- Existing lifecycle evidence: `extra-evidence-sha256.json` and its ASM files.
- Existing request creation evidence: `NewSyncService_sendBgFgRequestWithOnlineMode_.asm`, `NewSyncService_addBgFgLongLinkEvent_.asm`, and `NewSyncService_addBgFgSendOnlyEvent_.asm`.
- New bounded extraction: local `target.json`, `bgfg-blocks.json`, `bgfg-log-method.json` and listed ASM files. Extraction verifies the selected binary hash and uses `LC_FUNCTION_STARTS` for function boundaries.

## Transport entries and context ownership

The primary AppDelegate call goes through `0x107c0c310 -> 0x10f83d454 -> 0x1130e6870`; the first two are tail branches. The second lane is `0x10b7439a0` and is called only when the native feature check passes. Both final entries accept the boolean in `w0` and the address of the C++ context string in `x1`. They retrieve a signal receiver and tail-call shared dispatch `0x10b635598` with receiver in `x0`, boolean in `w1`, context in `x2`. This is distinct from `ActiveLogic::OnForeground` at `0x1130e3fe4`, which takes an instance in `x0` and boolean in `w1`.

The reviewed AppDelegate callsites construct the 24-byte libc++ string containing `default` on the stack. Destruction inspects the high bit of byte 23, consistent with the target libc++ string layout. Retaining the pointer or memcpy-ing its object representation into retained storage is unsafe for general strings. An Objective-C++ bridge must own the context value with a compatible libc++ ABI and preserve its lifetime until the original trampoline returns. For the exact `default`-only gate, the final implementation’s independent constant `std::string("default")` is sufficient; no native context pointer or object representation is retained. Treat the inferred `const std::string &` as a binary calling convention, not permission to mutate native storage.

| Lane | Background BL | Background return PC | Foreground return PC |
| --- | --- | --- | --- |
| Primary | `0x104e857a8` | `0x104e857ac` | `0x104e86340` |
| Secondary | `0x104e85800` | `0x104e85804` | `0x104e86398` |

The verified tail veneers preserve the original LR. A caller check must capture that LR directly in the replacement entry (not inside an out-of-line helper), normalize it for the image slide, and account for pointer authentication if applicable to a supported build. Gate native hooks on the UUID and verified entry bytes. The original trampoline must retain native dynamic-redirection behavior rather than jump into the middle of these entries.

## Minimum scope and restoration requirements

1. Override `false` only while the existing default-off, bounded experiment is eligible, with a valid current account and group-pat configuration, on the main thread, with context exactly `default`, and with the verified AppDelegate background return PC for that lane. Pass every other natural signal through with its original arguments and thread. The boolean change must not modify UIKit lifecycle, application state, or scene state.
2. Keep ownership per lane. Record the copied context and actual natural value only after that lane really intercepted a natural `false`; do not create a secondary restore because the primary lane was used. Use each lane’s original trampoline for restoration.
3. A later natural `true`, or a same-context natural signal the experiment did not own, takes control back. Invalidate that lane’s pending restore so an old `false` cannot undo the newer native state. Maintain a sequence/generation per lane, including natural pass-through signals.
4. Transport ownership is process/default-context state, unlike the account-scoped NewSyncService lease. On account/config/authorization loss, release the experiment’s still-owned native background-intent override absent newer native takeover, then clear the binding. UIKit may still report Active during the verified native background callback, so logical ownership and the explicit foreground handoff fence, rather than UIKit state alone, decide cleanup. Merely clearing transport state at account epoch change can leave it forced true; conversely requiring old-account authorization before restoring a process-global signal can prevent cleanup.
5. Preserve native ordering and reentry. Do not send existing native calls asynchronously to another queue and do not hold a nonrecursive state lock while invoking original signal callbacks. Shared signal dispatch has callback/slot machinery, while the deeper ActiveLogic handler can dispatch to its own owner thread. An off-main same-context natural call must invalidate ownership; a generation check separated from the actual restore call still leaves an ordering race. If the implementation assumes only the verified main-thread lifecycle calls can own the lane, it must conservatively stop/defer restoration when concurrent/in-flight native activity is seen rather than replay stale state. The final implementation uses coalesced post-collision correction, synthetic-call depth, and an explicit foreground handoff fence; its reviewed collision cases and validation are recorded in the final disposition below.
6. Expiry, disabling, foreground transition, account transition, and partial installation all need one restoration/ownership decision. A natural foreground transition is takeover, not a reason to append a synthetic background signal. No restore is needed for a lane never overridden.

These are global transport signals. Limiting activation to valid group-pat configuration does not isolate network effects to that group or to pats. ActiveLogic at `0x1130e3fe4` updates native foreground/active state, timestamp and timer; `OnInactive` retains active state when foreground is true. Thus the proposed experiment may affect the wider WeChat connection and power usage. Static evidence supports testing the hypothesis, not claiming permanent or pat-only behavior.

## MessageReturn:Event: is not BgFg result evidence

`-[NewSyncService MessageReturn:Event:]` starts at `0x105463690`, ABI `v28@0:8@16I24`. At `0x1054636a8` it saves the second explicit argument (`x3`) and later prints it as `EventID: %u, message:%u`. It also passes it to `removePBEventObserverListItem:andValue:`. This parameter is the event identifier, not a return/error code.

Observed CGI dispatch in this method is 681 (`HandleOplog:Event:`), 138 (newsync) and 139 (init). For CGI 138, `m_uiMessage == 1` calls `resetGettingData` and `onNewSyncOplogConnectFail`; for CGI 139 it calls `onNewInitConnectFail`. Other newsync messages pass `m_oUserData.boolValue` plus `m_pbResponse` to `HandleSyncResp:handleResult:`. Therefore message value 1 must not be labeled success. No BgFg-specific handler exists in this reviewed function.

## Actual BgFg completion path

`sendBgFgRequestWithOnlineMode:` builds netcmd number 312 (`0x138`) at `0x105461a44`, distinct from decimal newsync CGI 138 (`0x8a`). Its native feature switch `clicfg_bgfg_task_timeout_switch` chooses between `NetCmdLongLinkEvent` and `NetCmdSendOnlyEvent`; do not change that choice merely to obtain diagnostics.

For the longlink path:

- Retry count is 0 and total timeout is 10000 ms.
- Global response-decoder block is at `0x11c2fde68`, invoke `0x105461ab0`, descriptor signature `i24@?0@"NSData"8^i16`.
- The decoder checks for nonempty NSData and parses `BgFgResponse`. On successful parse it returns 0 and writes `response.retcode` to the nonnull `int *` output. Missing/invalid data returns -14 and writes -1 when an output pointer is provided. Decoder return 0 alone does not mean server retcode 0.
- Global response-handler block is at `0x11c2fdea8`, invoke `0x105461b68`, signature `v24@?0@"NSData"8i16i20`.
- That handler directly calls `+[NewSyncService logBgFgResponseWithErrType:errCode:]`, preserving its two int arguments.
- This class method has ABI `v24@0:8i16i20`, IMP `0x10546123c`. It outputs `BgFgResponse success` only when BOTH `errType == 0` and `errCode == 0`; otherwise it outputs the failed format with both values.

A hook of this class log method can observe native BgFg completion, but carries no account, event ID or onlineMode. It cannot reliably attribute a completion to a specific experiment attempt by time proximity alone. Precise attribution requires wrapping the existing responseHandler on the specific event already verified as experiment-owned, preserving and calling its original block, and retaining the owning request/account/generation metadata only for observation. Do not replace the decoder, infer mode from the current global state, or rewrite native callback arguments. The send-only branch has no corresponding response decoder/handler; a void send/add return or an AddEvent ID is not a server acknowledgment.

## Conclusion and limits

The proposed bridge targets a separate native transport layer that onlineMode=1 alone does not keep foreground. Its observed ABI and lifecycle callers are identifiable for this exact binary. The experiment is reviewable if narrowly scoped, uses C++ value ownership, and restores only its own per-lane state without undoing newer native signals. The initial and intermediate findings below were fixed in the final reviewed source; the final disposition links the matching source and validation evidence. BgFg ACK observability can be improved through its verified callback chain, but neither successful BgFg completion nor a retained local foreground bit proves immediate delivery of a group pat. Device testing remains required for latency and ordinary message/connection behavior.


## Verified event accessor ABI and block storage

`NetCmdLongLinkEvent` directly subclasses `NetCmdSendOnlyEvent`; detect the specific longlink class before using broad superclass checks. Exact target metadata:

| Method | Encoding | IMP |
| --- | --- | --- |
| `responseHandler` | `@?16@0:8` | `0x105322684` |
| `setResponseHandler:` | `v24@0:8@?16` | `0x105322694` |
| `responseDecoder` | `@?16@0:8` | `0x105322668` |
| `setResponseDecoder:` | `v24@0:8@?16` | `0x105322678` |
| `setResponseData:errType:errCode:` | `v32@0:8@16i24i28` | `0x105322450` |
| `NotifyFromPrtl:MessageInfo:` | `v28@0:8I16@20` | `0x1053224d4` |

`_responseHandler` is a block ivar at offset 80; `_responseDecoder` is offset 72; `_responseData` is NSData at offset 88; signed 32-bit `_responseErrType` and `_responseErrCode` are offsets 60 and 64. Use the selectors, not raw field writes. The setter tail-calls `0x107c27c98 -> 0x10f85fc24 -> 0x116e5c64c`, whose Mach-O indirect-symbol entry is `_objc_setProperty_nonatomic_copy`. It copies the incoming block.

`NotifyFromPrtl:MessageInfo:` captures handler/data/error fields before calling super, then arranges a block using `dispatch_get_global_queue(0,0)` (verified veneer `0x107c2787c -> 0x10f85f620 -> 0x116e5a5ac`). Its callback must not assume main thread. Preserve original handler execution on its callback thread and with identical arguments; dispatch only the experiment’s own state/diagnostic bookkeeping if it requires main-thread state. Capture immutable request/account/generation information, not the event strongly, to avoid an event-to-block-to-event retention cycle. Store data only as needed for diagnostics, without retaining message payloads.

## Initial implementation review — historical findings resolved

Reviewed file: `source/Controllers/CSAutomationNetworkActivity.mm` (snapshot hash recorded below). No changes were made to this file by the reviewer.

Positive checks: entries and callsite instruction words match the reviewed target; the captured LR is taken in noinline replacement entries; UUID and both entry signatures are checked; default context is an independent C++ string value; only matching default context, native background callsite and eligible main-thread calls are candidates for override. Natural foreground calls pass through. Ownership and restoration are independent per lane. Deeper instance ABI is not mistaken for the public signal entry.

Two initial findings sent to the owner and resolved in the final reviewed source:

1. **Resolved — initial partial hook installation could still override.** The initial receive path could alter channel 0 after channel 1 failed installation because it did not check the completed `installed` state. The final gate keeps partial installation transparent; it does not bypass target signature checks to retry a patched entry.
2. **Resolved for the reviewed cases — initial signal ordering used only a generation counter.** The initial code could send a stale synthetic value after a newer worker natural signal and then discard restoration because generations differed. The final code detects collisions and coalesces a correction to the latest natural/owned intent after the native stack unwinds. It adds no timer and holds no lock across the original callbacks. The final disposition lists the deterministic worker collision tests.

Initial reviewed source SHA-256: `b627d5df94ec34f39384b3d171210f54b6f96b4cddcc3805d72b7f3985f12157`.


## Follow-up review — intermediate findings resolved; owned-event response observer

The intermediate bridge added the complete-installation gate, a post-diagnostic ownership check, and coalesced main-queue repair after detected natural-signal collisions. This resolves the reported partial-installation override and gives collisions a wake-up without a timer or a lock across native callbacks. Entry addresses, signatures, context and caller scope remain restricted to the same target. The C++ string is still an independent constant value, so no native stack context pointer is retained.

Two concrete reentrant sequences were found in the intermediate source; both are resolved and explicitly covered by the final implementation and harness:

1. **Resolved — foreground correction discarded.** The intermediate repair returned whenever UIKit was not Background, dropping the correction after a reentrant natural true was overtaken by an outer restore false. The final repair permits the latest natural true while Active and uses the explicit foreground handoff fence to reject an old background false.
2. **Resolved — disable during repair left an outer true.** The intermediate `emitOwned` lacked depth tracking, so a reentrant disable could send nested false before the outer repair true finished and leave true unowned. The final synthetic-call depth defers release until that outer call unwinds. The final disposition links the corresponding deferred-commit test.

These are deterministic callback-reentry scenarios suitable for the existing fake original: mutate the recorded effective value after performing its injected callback. They do not require a real phone or a network race. The validation owner was notified; this reviewer did not run tests.

The new response observer in `CSAutomationOnlineExperiment.m` is restricted to the experiment-owned event after acceptQueued plus epoch/revision checks. It requires the exact NetCmdLongLinkEvent class and verified getter/setter block ABI. The native original handler is copied, called with unchanged NSData/int/int arguments on the original callback thread, and its exceptions remain visible. The wrapper captures the token but not the event; token.service is weak. Its diagnostics use locked recording and cached application state, so no UIKit getter is introduced on the callback thread. No native decoder, retry policy, send-only path or ordinary unowned event handler is replaced.

Queue observation reads `m_bgFgEventID` only after checking type `I` and instance bounds; send-only records only its path. Interpret the value as a post-add native event-ID snapshot. It is not a server ACK, and if another native request reenters during the add and replaces this service field, a nonzero value alone cannot uniquely establish ownership of that queue ID.

Follow-up source SHA-256 (`CSAutomationNetworkActivity.mm`): `ce53258f1cff7d2ac7e34a554665466187913406eaddd1d8ad294ea9051ebb3b`.

Follow-up source SHA-256 (`CSAutomationOnlineExperiment.m`): `829f78e9a8d0d20f14eec77e141b66c0cbb1e76f85d8270188023902f5544438`.


## Final disposition — source and matching validation checked

Final reviewed `CSAutomationNetworkActivity.mm` SHA-256: `03a71d855c247152165b61a8c534b508d326ae0bb6dd7c580c9a5ed8ce423f6d`.

The complete-installation gate is present in `receive`; partial installation stays transparent. Natural calls keep their original thread, arguments and context reference. The UUID, exact entry words, exact native background callsites, `default` context, main thread, and current experiment/account/config eligibility gates were not widened.

`emitOwned` now increments synthetic-call depth, decrements it after the original returns or throws, schedules coalesced correction if natural generation changed, and executes a pending release only after the outer native call unwinds. This closes the reviewed repair-true / nested-disable / outer-true ordering issue. It avoids holding locks across native callbacks.

Repair no longer discards all work solely because UIKit is Active. A newer explicit native true is reapplied after an overtaken false. `CSAutomationNetworkActivityForeground` clears owned state and records a per-lane natural-generation fence; repair skips the old fenced false. It also checks the fence again after eligibility may reenter foreground handling, preventing the intermediate stale-false replay. Native takeover and account changes still release only outstanding process-level experiment state; a newer native true remains authoritative.

The reviewer read the final production module, the concrete deferred-commit/reentry tests, and the test summary whose source hash matches the final module. The validation owner ran **2771 checks**, with successful strict `-Wall -Wextra -Werror` compilation for both `arm64-apple-ios15.0` and `arm64e-apple-ios15.0`. This reviewer did not repeat that suite.

| Historical finding | Final disposition | Concrete validation |
| --- | --- | --- |
| Partial hook can still override | Resolved by complete-installation gate | `partial installation cannot override` |
| Worker natural signal overtaken by synthetic call | Resolved for reviewed sequences by post-collision coalesced repair | `worker true overtakes restore false before synthetic commit`; `worker false overtakes override true before synthetic commit`; collision coalescing |
| Native foreground true correction discarded while UIKit Active | Resolved; repair applies latest native true | `natural foreground wins restoration while UIKit active` |
| Disable during repair can leave outer true | Resolved by synthetic depth and deferred release | `repair synthetic call defers nested release until stack exit` |
| Eligibility reenters foreground and old false is replayed | Resolved by second foreground-fence check | `foreground during repair eligibility cancels its old false` |
| Account handoff loses cleanup or overwrites new native intent | Reviewed process-level cleanup preserved | `account epoch still releases stale process transport override`; `new account natural true owns queued process transport repair` |

Evidence links:

- [Final bridge source](/Users/zhangshichao/Documents/Workspace/WeChatImprove-local-archive/audits/2.5-13-online.3/source/Controllers/CSAutomationNetworkActivity.mm)
- [Real-module harness and deterministic reentry cases](/Users/zhangshichao/Documents/Workspace/WeChatImprove-local-archive/audits/2.5-13-online.3/source/Tests/AutomationNetworkActivityTests.mm)
- [Matching 2771-check and strict iOS compilation summary](/Users/zhangshichao/Documents/Workspace/WeChatImprove-local-archive/audits/2.5-13-online.3/test-results/automation-network-activity-summary.json)
- [Validation log](/Users/zhangshichao/Documents/Workspace/WeChatImprove-local-archive/audits/2.5-13-online.3/test-results/automation-network-activity.log)

No unresolved implementation blocker remains from this review. This disposition is limited to the pinned native ABI, hook scope, reviewed ownership/restoration cases, and owned-event response observation. The offline results do not prove long-lived device execution, power behavior, server delivery, or immediate group-pat latency; those require the resulting experimental package on the target device. The module affects global native transport activity while the bounded experiment is active, not only pat traffic.
