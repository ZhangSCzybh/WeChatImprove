# NewSyncService lifecycle: static-only review

Target: `/tmp/wechat-8.0.78-inset-analysis/WeChat`, supplied iOS WeChat 8.0.78 arm64 Mach-O. Class metadata address `0x1203859a8`. Only read-only mmap metadata decoding and LLVM bounded disassembly were used. The target was not executed, attached, patched, or rebuilt. No REA session or real user data was accessed. All new files for this subtask are in this directory.

## Direct answer

Neither `onServiceEnterBackground` nor `onWillSuspend` actively pauses synchronization in its complete bounded implementation. There is no `makeSyncPause` dispatch, no `setSyncPaused:` dispatch, and no read or write through the `m_bIsSyncPause` ivar-offset address in either complete method. This negative observation is restricted to these two bodies; it does not claim that other observers, callers, services, or iOS never pause or suspend work.

Their observed work is a login-gated `BgFgRequest` report, not a call to `NotifyToSync` or `InternalCreateSync:`. `onServiceEnterForeground` follows the same reporting pattern and additionally marks the first sync after a background/foreground change. Do not suppress these native callbacks or treat their invocation as proof that new messages have been fetched.

## Evidence ledger

| ID | Observation | Address evidence | Files |
|---|---|---|---|
| LC-01 | Instance ivar `m_bIsSyncPause` is a BOOL at object offset 84; ivar-offset variable `0x120228918`. `m_bFirstSyncAfterBgfgChange` is BOOL offset 86; variable `0x120228944`. | Objective-C class/ivar metadata, class `0x1203859a8`. | `ivars.json`, `metadata-context.json` |
| LC-02 | Background entry is `0x105180aa4`, next function starts at `0x105180d40`; no pause operation in this complete range. `CAppUtil.isLogin` selector reference is loaded at `0x105180ad8`, called at `0x105180adc`; `cbz w0` at `0x105180ae0` exits to `0x105180d24`. | `0x105180aa4 <= pc < 0x105180d40`. | `NewSyncService--onServiceEnterBackground.asm`, annotated counterpart |
| LC-03 | Background login-success path creates `BgFgRequest`, sets client version, device type and network mode, then passes integer 2 to `setOnlineMode:`. It serializes the request, constructs a native command with integer 312, sets it on `NetCmdSendOnlyEvent`, and requests `EventService` to perform `AddEvent:` on the main thread with `waitUntilDone:NO`. | `setOnlineMode:` reference `0x105180c1c`, argument 2 `0x105180c24`, call `0x105180c28`; command 312 `0x105180c68`; `AddEvent:` reference `0x105180ccc`; main-thread dispatch `0x105180ce0`. | Same as LC-02; `references.json` |
| LC-04 | Foreground entry is `0x105180d40`, next function `0x105180ff8`. It checks login and, on success, writes YES to `m_bFirstSyncAfterBgfgChange`, then reports `setOnlineMode:1` with the same command/event mechanism. No `makeSyncResume` or `setSyncPaused:` in this complete range. | Login call `0x105180d7c`, exit branch `0x105180d80`; first-sync flag store `0x105180dd0`; online mode argument 1 `0x105180ed0`, call `0x105180ed4`; main-thread dispatch `0x105180f98`. | `NewSyncService--onServiceEnterForeground.asm`, annotated counterpart |
| LC-05 | Suspend entry is `0x105180ff8`, next function `0x105181294`; no pause operation in this complete range. It checks login and reports `setOnlineMode:3` with command 312 and the same asynchronous main-thread `AddEvent:` mechanism. | Login call `0x105181030`, exit branch `0x105181034`; online mode argument 3 `0x105181178`, call `0x10518117c`; command 312 `0x1051811bc`; main-thread dispatch `0x105181234`. | `NewSyncService--onWillSuspend.asm`, annotated counterpart |
| LC-06 | The actual pause method independently writes YES to `m_bIsSyncPause`, obtains `BypSyncService` through `MMContext.currentContext.getService:`, then passes YES to `setSyncPaused:`. | Complete `0x1051860c4 <= pc < 0x1051861ac`; flag store `0x105186128`; `setSyncPaused:` argument 1 at `0x105186188`, dispatch `0x10518618c`. | `NewSyncService--makeSyncPause.asm`, annotated counterpart |
| LC-07 | The resume method independently clears `m_bIsSyncPause` and calls the same `BypSyncService.setSyncPaused:` with NO. Neither complete body directly dispatches a `NewSyncService` synchronization entry point; downstream `BypSyncService` behavior was not inspected. | Complete `0x1051861ac <= pc < 0x105186290`; flag clear `0x10518620c`; `setSyncPaused:` argument 0 at `0x10518626c`, dispatch `0x105186270`. | `NewSyncService--makeSyncResume.asm`, annotated counterpart |
| LC-08 | Initialization explicitly clears pause state, sets the first-sync flag to YES, registers `onWillSuspend` for notification `MMApplicationWillSuspend`, and registers `INewSyncExt` on `MMContext`. | Pause clear `0x1051806d4`; first flag YES `0x1051807dc`; notification observer call `0x1051807bc`; extension registration `0x105180814`. | `NewSyncService--init.asm`, annotated counterpart; `registration.json` |
| LC-09 | A separately named `BackGroundToForeGroundSync` method changes `m_uiSyncScene` to 3 unless its current value is 6, and tail-dispatches `NotifyToSync`. It is not called by the reviewed foreground lifecycle body. | Complete `0x105182434 <= pc < 0x105182504`; scene compare `0x1051824a4`, store `0x1051824b0`; `NotifyToSync` selector `0x1051824ec`, tail dispatch `0x105182500`. | `NewSyncService--BackGroundToForeGroundSync.asm`, annotated counterpart |

## Constraints for a conditional background sync implementation

1. Preserve the original lifecycle calls, reporting, first-sync marker, and native login handling. These methods do not establish a pause/resume boundary that a plugin needs to undo.
2. Preserve pause state rather than clearing or toggling it to make a fetch succeed. The pause/resume API explicitly changes both `NewSyncService` and `BypSyncService`; it is not a per-conversation AI preference.
3. Keep the actual synchronization API choice and its preconditions separate from background/foreground reporting. The parent investigation owns `BackGroundFetchToSync`, `NotifyToSync`, `InternalCreateSync:`, and active-sync gating; this subtask does not override those results.
4. A hook or timer can only make a sync request while code is actually executing. The three lifecycle bodies do not show a background-execution entitlement, an iOS task extension, a new wakeup source, or a guarantee that queued main-thread work runs before suspension. This is a bounded code observation, not an app-wide background-execution assessment.

## Unknowns and interpretation limits

- No live device, suspension timing, network event, server response, new-message delivery, OS scheduling grant, battery impact, or app termination behavior was observed.
- Downstream effects inside `BypSyncService.setSyncPaused:` and the lifecycle request/event classes were not expanded in this scoped pass.
- A false login check skips lifecycle report construction in these methods. The runtime login/account state and upstream callback order were not measured.
- The integer online-mode values 1/2/3 are directly observed; their association with foreground/background/suspend comes from the respective methods and log strings. A separate enum declaration or server-side interpretation was not inspected.
- The `NetCmdSendOnlyEvent` submission is a static call sequence. It does not prove delivery, completion, or synchronization of message history.
- The three adjacent global bytes written near method entry were not assigned application-state semantics. Their ownership and purpose were not established.
- The entry boundaries come from Objective-C metadata and LC_FUNCTION_STARTS. LLVM's broad nearest-symbol display label (for example `_Flutter_MMFoundation_BindContext`) is not the recovered Objective-C method name.
- The lightweight annotation pass resolves direct ADRP/load metadata references; raw disassembly is retained as canonical local evidence. It is not a full control/data-flow decompiler.
