# Task 3 report: gesture adapter and deterministic message cell lifecycle

Date: 2026-10-17. Implementation and isolated host/target build verification complete. No device deployment or live UIKit acceptance is claimed.

## Environment and scope

Authorized worktree: `/Users/zhangshichao/.codex/worktrees/message-actions-refactor/WeChatImprove`; branch `codex/message-actions-refactor-1.7-17`; starting revision `6f82e553`. Read Task 3 brief, global constraints, Task 3 decisions, Task 2 report/final headers, and design sections 4/5/10/11. The brainstorming skill was read in the context of the existing approved architectural design and explicit implementation authorization; prior design decisions were preserved.

Only this worktree and temporary host/build directories were written. No original checkout, shared `.theos`, existing package, account, database, service, device, or installed application was changed. No sends, installs, package generation, `make clean`, push, merge, or service switch occurred. The complete Theos compile/link/sign ran in a disposable full source copy excluding `.git`, `.theos`, packages and node_modules; that copy was removed automatically. Test defaults use a unique `GestureTests.<UUID>` suite and remove its persistent domain. Time tests retain their prior volatile NSArgumentDomain fixture behavior inside the test process.

## Implementation

Added `Controllers/CSMessageGestureAdapter.{h,m}`. Each cell owns one adapter/pan; the adapter weakly references cell/page through the shared immutable context and retains the existing coordinator facade. It caches settings, source identity, action capabilities and binding generation on binding/configuration changes. Repeated layouts update region/geometry/actual navigation recognizer references without recapturing account/services or rereading preferences. ShouldReceiveTouch/ShouldBegin and Changed do not resolve services, read preferences/files, construct menus or allocate business operations. Changed updates only the owned transform and one readiness haptic.

Admission uses the real bubble getter, or a narrow native content view fallback, and converted bounds. Full-row fallback containers, avatar/blank space, UIControls and nested horizontally scrollable controls are excluded. Native disabled-operation and multiselect BOOL fields are resolved/type/size checked once per binding, using the verified `ivars.json` field names/encodings (`m_bDisableAllOperation`, `m_bMultiSelectMode`); admission reads those cached scalar offsets directly. Native UITableView editing is also respected. Direction admission uses the existing 1.5 horizontal intent policy and the action for the actual sender/direction. Native recognizer delegates are unchanged.

The real `navigationController.interactivePopGestureRecognizer` receives failure priority; no Edge/class-name matching remains. Failure/simultaneous relationships apply only to that exact pop recognizer, the ancestor scroll pan, and actual content tap/long-press competitors. Cell-attached native content gestures use their location in the converted bubble region; unrelated/outside gestures do not gain broad failure dependencies. Actual UIKit arbitration still needs device validation.

Began locks source context/action/direction. Shared policy keeps distance `max(visibleWidth*0.2,60)`, 600pt/s directional speed and minimum 12pt displacement. Readiness feedback occurs at most once per gesture, including Armed→Tracking→Armed. Only Ended can hand off to `executeContext:action:entry:`. Cancellation, failure, reuse, model change, configuration change, page exit and window detachment clear tracking without a handoff. Real facade validation still protects source/account changes that occur outside binding callbacks.

The adapter tracks native baseline, plugin offset and last applied transform. It only removes a transform equal to its last owned value. Native scale/rotation/translation survive drag/reset. Host takeover during tracking, or an incompatible native transform produced during detached layout, cancels interaction and preserves that host transform. Rebound uses a retained, individually owned UIViewPropertyAnimator; new begin, layout, reuse, invalidation and page/window cancellation stop only that animator. No Identity reset or layer-wide `removeAllAnimations` is used. Reduced motion restores immediately. Model geometry is restored before facade invocation; there is no cell access after the business handoff.

Added `Controllers/CSMessageCellLifecycle.{h,m}` and replaced the 2,566-line legacy `Hooks/MessageGestureHooks.xm` with one lifecycle owner and account boundary hooks. Outermost layout order is: detach plugin translation/stop own rebound → merge restore → complete subclass/native layout → time content preparation → merge render/final time position → geometry cache refresh → reapply only when native baseline is still compatible. Native layouts inside binding/reuse run their original implementation while the outer boundary owns final preparation; nested reuse setters cannot re-enable an adapter. Same-model setter entry also invalidates gesture capture, while preserving time-tap visibility. Layout/binding/reuse depths prevent duplicate work through Voice/Common superclass chains; Voice compatibility entries also work when native code omits super. Binding/reuse invalidate active tracking/generation and cancel cell-owned short UI operations through the facade. Already committed repeat/native forward ownership stays with the coordinator. BubbleStyle and HideChatTime hooks were preserved.

`MessageMergeHooks.xm` no longer independently owns Common cell layout/bind/reuse and cancels page tracking on disappearance. `MessageTimeHooks.xm` exports content/reset bridges while retaining its private measurement/cache/visibility state and `cs_messageTimeLayout`. Its tap now has an independent associated weak-cell delegate that excludes content/control touches; both duplicate Common `%new` gesture delegate methods were removed. Final positioning is owned by merge rendering, including its inactive path, rather than doubled in time preparation. Removed stale plugin declarations/enums from `HeadersFile/CommonMessageCellView.h`. Settings pages already consumed shared constants from Task 1; no additional settings changes were necessary.

Verified native account hooks call `CSMessageActionAccountWillChangeAtNativeBoundary()` immediately before `MMContextManager.logout:` original, and `CSMessageActionAccountDidChangeAtNativeBoundary()` immediately after `loginByContext:` original, on the native calling thread. The race-safe Task 2 scalar marker precedes any asynchronous gesture/UI cleanup. Hook bodies do not query account services or dispatch_sync to main. Main cleanup invalidates/rebinds visible adapters; delayed UI cleanup cannot permit an old-account facade invocation because the coordinator checks the immediate marker.

## Full-link integration correction

The initial complete build compiled all new adapters and three affected Logos files for both architectures, then failed at link with duplicate `_CSMessageNativeObject`: the preexisting `CSChatNativeBridge.m` and Task 2 `CSMessageNativeActionAdapter.m` each exported that name with different semantics. This full-project conflict was hidden by the earlier scoped Task 2 link.

With parent coordination, renamed only the Task 2 helper declaration/definition/call sites to `CSMessageActionNativeObject`, including media, send and execution tests. The existing chat/merge/time bridge name and behavior remain intact; the new action helper retains its checked type-extension forwarding semantics. Reran the affected execution suite and the full dual-architecture source build successfully. This is a symbol-only integration correction, not a route/payload behavior change.

## Validation

Commands ran in the authorized worktree; binaries/build outputs were isolated outside it.

```text
bash Tests/verify-message-gesture.sh
PASS: 272 production gesture/lifecycle checks (UIKit/facade doubles, no native sends)

bash Tests/verify-message-time.sh
PASS: 142 message-time production hook lifecycle checks (UIKit double)

bash Tests/verify-message-merge.sh
PASS: 53200 message merge/navigation checks
PASS: 2872 native adapter/navigation lifecycle checks (UIKit double)

bash Tests/verify-bubble-style.sh
Bubble policy/renderer/ownership: 8269 checks passed
Bubble real-adapter lifecycle: 111 checks passed

bash Tests/verify-revoke-interception.sh
PASS: 73 production revoke interception checks (native service doubles)

bash Tests/verify-revoke-reference.sh
PASS: 84 persisted revoke reference/event checks

bash Tests/verify-message-actions-core.sh
PASS: 1362 message action core checks (isolated defaults suite; no native sends)

bash Tests/verify-message-actions-execution.sh
PASS: 202 production action/coordinator/native/media checks (host doubles, no native sends)
```

The gesture runner compiles the actual production adapter/lifecycle/context/settings/policy with Foundation/ARC/blocks and `-Wall -Wextra -Werror`; UIKit and the business facade are invocation-recording doubles. It additionally extracts and executes the real native account hook bodies. Tests cover vertical/disabled direction/no-feedback/no-transform admission, bubble/control/nested horizontal scrolling roles, actual pop priority, scoped content competition, source A→B rebind with zero facade handoffs, cancel/Failed, duplicate Ended suppression, two distinct deliberate gestures, exact speed/minimum displacement/direction, backtracking/one haptic, settings cancellation, 100 repeated layouts with no defaults/capture/capability work or recognizer growth, subclass/super depth/order, intermediate setter/reuse layout, native nonidentity baseline, native takeover during drag and layout, own rebound stopped on reuse, reduced motion, native delegate preservation, page/window cancellation and final facade invalidation.

The time harness now extracts its migrated layout/reuse/appearance hook entrypoints from MessageGestureHooks and executes the actual CSMessageCellLifecycle scheduler. Merge/gesture boundaries are explicit doubles in this time-focused test. All 138 previous assertions remain, and four independent tap-delegate assertions were added. Real merge policy/adapter and bubble ownership regressions continue to run independently.

Three isolated mutation copies proved the suite rejects material ownership regressions; production files were not mutated:

```text
EXPECTED RED cancel-no-restore : FAIL line 128: executions==0 && CGAffineTransformEqualToTransform(cell.transform,expectedBaseline)
EXPECTED RED post-layout-native-transform-overwritten : FAIL line 163: executions==3 && CGAffineTransformEqualToTransform(cell.transform,takeover)
EXPECTED RED own-rebound-not-stopped : FAIL line 134: CSGestureActiveRebounds==1
```

Strict iOS syntax checks both exited 0 with no diagnostics (SDK27.1, minimum iOS15):

```text
xcrun --sdk iphoneos clang -target arm64-apple-ios15.0 -fobjc-arc -fblocks -Wall -Wextra -Werror -fsyntax-only -IControllers Controllers/CSMessageGestureAdapter.m Controllers/CSMessageCellLifecycle.m Controllers/CSMessageNativeActionAdapter.m Controllers/CSMessageMediaProvider.m Controllers/CSMessageSendAdapter.m
xcrun --sdk iphoneos clang -target arm64e-apple-ios15.0 -fobjc-arc -fblocks -Wall -Wextra -Werror -fsyntax-only -IControllers Controllers/CSMessageGestureAdapter.m Controllers/CSMessageCellLifecycle.m Controllers/CSMessageNativeActionAdapter.m Controllers/CSMessageMediaProvider.m Controllers/CSMessageSendAdapter.m
```

Final full-project copy invocation and output:

```text
make all SCHEME=rootless -j4
Final isolated full Theos exit: 0
Linking tweak WeChatImprove (arm64e)
Linking tweak WeChatImprove (arm64)
Merging tweak WeChatImprove
Signing WeChatImprove
```

All affected Logos files compiled for both architectures. Full logs: `/tmp/wechat-task3-theos.log` (initial link collision) and `/tmp/wechat-task3-theos-final.log` (passing final source build). Temporary checkout copies were removed. Full-build warnings are preexisting and outside changed source: CSAuthorizationManager (three openURL deprecations), CSContactSeparatorSettingsViewController (unused weakSelf), HideSettingHooks (unused title), ReceiveTransferHooks (three unused variables and UIApplication.windows deprecation), RedEnvelopHooks (unused variable/function and statusBarFrame deprecation), plus the obsolete `-multiply_defined` linker flag. Each appears for both architectures. No warning originated in the new adapters/lifecycle or affected message hook files. `git diff --check` passed.

## Acceptance limits

Host doubles establish production control flow, snapshot/geometry ownership and facade invocation behavior, not UIKit's real failure graph, native pop UX, animation presentation timing, voice playback/control touch arbitration or device frame time. Device verification remains required for ordinary/split text, voice/image/video/card/reference regions, actual navigation pop and native tap/long-press/vertical scroll, multiselect transitions, 12pt speed usability, reduced motion, page/native picker transitions and all simultaneous feature combinations.

The account hook marker ordering is compiled and host-exercised; actual native account locking and installed image identity remain Task 2's documented device boundary. The coordinator's opaque concurrent native call limitation is unchanged. No media/send equivalence or recipient playability claim was added. No user delivery URL/data source exists for this tweak-only isolated implementation, and no live environment was substituted.
