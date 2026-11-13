# Fresh static evidence: unsolicited notify and sync scheduling

This report uses only the Mach-O binary extracted for the current fresh analysis, not project reports or historical patches. This analysis did not modify production source, services, or device app state.

Binary: `/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-43fcc0e6-d4aa-4466-9db3-97b4ce143058/Payload/WeChat.app/WeChat`.

All addresses below are unslid VM addresses. Selected supporting assembly is stored in this directory, with NewSyncService methods in [../sync](../sync/) and AppDelegate methods in [../network](../network/). Temporary exploration output is not required to review the consolidated findings.

## 1. Actual unsolicited network push

`stn_callback.mm::OnPush`, function start `0x10af23c1c`, logs `onNotify - %u`, obtains `MMContext` through `contextByMarsLongLinkName:`. A missing context causes an early return (`0x10af23dec` onward).

| Incoming cmd | Observed dispatch |
| --- | --- |
| 24 (`0x18`) | Requires payload length >= 4. Reads the first 32-bit big-endian selector. Calls `CUtility.NeedNewSync:`. If true, creates `{"86":"1"}` and calls `CMainControll.NotifyFromEvent:nil Message:4 MessageInfo:dict`. Also calls extension `onNewSyncPlugin:` separately. |
| 5 | Creates the same scene-1 notification and calls `NotifyFromEvent:nil Message:4 MessageInfo:dict`. |
| 122 (`0x7a`) | Converts payload to NSData and schedules `CMainControll.HandleNewSyncPush:` through `ThreadQueue.RunWithTarget:selector:object:`. |
| 2000 (`0x7d0`) | Same dispatch mechanism using `CMainControll.HandleNewSyncPush64:`. |

Supporting instructions: cmd24 branch `0x10af23f54`; length check `0x10af23fb8`; selector decode `0x10af23fc0–0x10af23fe4`; `NeedNewSync:` call `0x10af24034`; Message4 call `0x10af240e4`; cmd5 Message4 call `0x10af248ec`; cmd122 selector `0x10af247a8`; cmd2000 selector `0x10af24820`; common ThreadQueue call `0x10af24838`.

`+[CUtility NeedNewSync:]` (`0x1157802b0`) is exactly `(selector & 7) != 0`: `tst w2,#7; cset w0,ne; ret`.

No applicationState / background / foreground guard was observed before these four dispatches in this OnPush implementation. This bounded negative finding does not establish that any particular incoming event was delivered by the server or transport.

`ThreadQueue.RunWithTarget:selector:object:` (`0x1131fd574`) wraps the target/selector/object in `__ThreadWarp`, creates an NSInvocationOperation, and adds it to a shared operation queue held at `0x11fb1cc38`. `__ThreadWarp.Run` (`0x1131fd4e8`) calls target `performSelector:withObject:`. These inspected methods have no application-state filter. Queue initialization/concurrency and actual delivery timing were not established.

## 2. Message4 marks need-sync; an NSTimer later consumes it

The actual call chain is:

```text
OnPush(cmd24 with selector & 7, or cmd5)
  -> CMainControll.NotifyFromEvent:nil Message:4 MessageInfo:{86:1}
  -> NewSyncService.SetLastNotifyTime:date
  -> NewSyncService.setNeedSyncWithScene:1
       [requires current context uin64 != 0]
       m_uiSyncScene = 1
       m_bNeedSync = YES
  ... next executing TimerCheckEvent callback ...
  -> NewSyncService.checkNeedSync
       if m_bNeedSync == 1
         -> NotifyToSync
         -> InternalCreateSync:<current scene>
```

`NotifyFromEvent:` does **not** call NotifyToSync immediately on this path. It updates the last notify time (`0x104d17278–0x104d17318`), reads the scene from dict key `"86"` (default 1), and calls `setNeedSyncWithScene:` (`0x104d17474`). It then queues the ordinary CMessage notification and returns.

`setNeedSyncWithScene:` (`0x105463448`) checks current context `uin64` at `0x10546349c–0x1054634ac`, normalizes nonpositive scene to 7, stores m_uiSyncScene at `0x105463524`, and writes m_bNeedSync=1 at `0x105463538`. Its inspected code has no application-state condition.

Ivar metadata confirms:

- `m_uiSyncScene`: offset pointer `0x11edca8f8`, instance offset `0x10`.
- `m_tLastNotify`: pointer `0x11edca900`, offset `0x20`.
- `m_bNeedSync`: pointer `0x11edca8d4`, offset `0x57`.

`CMainControll.Start:` creates a repeating timer targeting `TimerCheckEvent` (`0x104d151e0–0x104d1520c`). The double loaded from `0x1178c79e0` is **0.05 seconds**, and repeats is 1. The object is saved at CMainControll instance offset `0x18`.

`MMTimer.scheduledNoRetainTimerWithTimeInterval:target:selector:userInfo:repeats:` (`0x1160ee538`) delegates directly to `NSTimer.scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:` at `0x1160ee5ec`, using `MMNoRetainTimerTarget.onNoRetainTimer:` as target selector. The wrapper does not inspect application state. `MMNoRetainTimerTarget.onNoRetainTimer:` (`0x1160ee498`) obtains the weak target and performs its stored selector if nonnil; no application-state guard is present.

`TimerCheckEvent` (`0x104d15b7c`) begins by obtaining NewSyncService and calling `checkNeedSync` at `0x104d15c14`, before its event queue processing. There is no foreground/background condition before that call.

`checkNeedSync` (`0x10546359c`) has only `m_bNeedSync == 1` as a condition and tailcalls `NotifyToSync` at `0x1054635b8`. `NotifyToSync` (`0x105462d98`) passes current m_uiSyncScene to InternalCreateSync. InternalCreateSync's own gates are outside this report's scope.

`CMainControll.Stop` invalidates this timer at `0x104d1596c` and nils it. CMainControll's class method set contains no named application background lifecycle / pause method. All CMainControll methods were dumped, and no pauseTimer call is present in them. This does not establish all external callers of Stop or possible direct ivar access.

**Timing limit:** 50ms is the requested NSTimer cadence. Static analysis does not prove the scheduling thread, run-loop mode, main run-loop availability, or actual background execution cadence. The user-provided premise that other background functions execute does not itself prove this exact timer fired.

## 3. APNS generic-notification route has an Active-only sync call

`MicroMessengerAppDelegate.handleReceiveRemoteNotification:requestID:` (`0x104e8d514`) routes cmd prefix216 directly to WCFinderGlobalPushJumpMgr; other commands call NotificationActionsMgr's same selector at `0x104e8d65c`.

`NotificationActionsMgr.handleReceiveRemoteNotification:requestID:` (`0x105490c4c`) performs these branch decisions:

1. cmd prefix216 -> Finder inactive APNS handling and returns.
2. If AppDelegate.m_isActive is false and `jump` is nonempty, then after the `hasEnterWechatMain` check it handles the deep link or returns. This path does not reach the generic sync call.
3. aps.category `PushLoginUrlAutoLogin` invokes ExtDevice handling and logs; it **falls through** to the following login check, rather than returning.
4. Requires `MMContext.isLoggedIn` **or** cmd prefix200 to continue (`0x105490ee0–0x105490f14`).
5. cmd prefix200 -> VOIPHelper.APNSPushWithUsrInfo:requestID:, then ordinary notification bookkeeping.
6. cmd prefix202 -> WCJdBussinessMgr inactive APNS handler; prefix203 -> WCInnerJumpMgr inactive handler; then bookkeeping.
7. cmd missing, or other cmd -> generic branch at `0x105491120`.

In this generic branch, x27 is UIApplication.sharedApplication, established at `0x105490fcc–0x105490fe8`. It requires `respondsToSelector(applicationState)` and `applicationState == 0` (`UIApplicationStateActive`) at `0x105491138–0x10549114c` before calling NewSyncService.ApnsNotifySync at `0x1054911ac`. Inactive/background states skip that sync call and continue handling the notification's alert / metadata.

This foreground condition is specific to the inspected ordinary remote-notification branch. It is **not** evidence that cmd122/2000 unsolicited longlink pushes are blocked, nor that the separate silent-push/background-fetch AppDelegate paths are blocked.

## Interpretation boundary

The fresh binary shows different mechanisms: selector-only notifications set a flag for a periodic NSTimer consumer; payload-bearing cmd122/2000 dispatch the response path directly through an operation queue; generic APNS notifications only issue their additional ApnsNotifySync call while Active. These facts identify distinct places to observe, but they do not by themselves identify the network command or sync-command type used by the user's group-pat case.

No inspected upstream code discriminates group vs private chat before the command dispatches above. Downstream pat processing and the separately examined derived room member sync are documented in [../receiver/README.md](../receiver/README.md).

## Artifact caution

The exploratory xref finder used an ADRP+LDR window without full register-lifetime tracking and could produce false positives. The findings retained here were checked against the actual assembly and do not rely on unverified xref candidates. The parser retained in [../receiver/macho.py](../receiver/macho.py) also emits linear annotation hints rather than a complete control-flow analysis; actual instructions and checked data flow take precedence.
