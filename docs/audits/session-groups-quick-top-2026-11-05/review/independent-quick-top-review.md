# Independent review: finger scroll to top after chat return

Review scope: the current production diff against the checked-in 2.2-11 adapter and session-group hooks. The reported gesture is a finger drag followed by inertia; speculative WeChat tab-bar/programmatic top hooks are outside this patch.

Result: **no blocking finding in the reviewed production changes**. This is a source review; SDK build and fixture results must be attached by their respective runners. No device installation or device acceptance was performed by this reviewer.

## Causal coverage

- The native table pan receives one additional target/action at new adapter attachment. Its Began state reaches cancellation even if a WeChat delegate replacement or forwarding path does not deliver scrollViewWillBeginDragging. Repeated attachment reuses the adapter and does not register a second target.
- Native delegate hooks and compatibility forwarding call beginUserDragging. Accepted standard top commands still use beginUserScrolling. Both user-command representations are retained without taking ownership of the native delegate.
- beginUserScrolling invalidates pending departure/switch heights, clears the ordinary row anchors, and advances viewportGeneration. Clearing only a pending height would leave the completed-return row anchor able to restore the older position.
- captureViewportForTabID records generation before geometry reads; validViewport rejects pre-drag source snapshots. An in-flight refresh therefore cannot revive a captured old height after a finger drag completes.
- restoreScrollHeight, saveAnchor, and restoreAnchor capture generation at method entry. Generation checks bracket geometry/host callbacks and prevent the old operation from treating a synchronous new command as its own successful result. Pending consumption additionally checks request identity.

## Gesture and lifecycle review

- tablePan only accepts the current table pan in Began. Changed/Ended calls make no per-frame computations beyond the state/identity gate.
- beginUserDragging excludes an active group pan and an admitted horizontal group gesture. The same exclusion is shared by the native delegate and compatibility path, preserving shared-height horizontal switching.
- The added observer changes no gesture delegate, recognition dependency, cancelsTouches, scroll offset setter, preference, account, or privacy policy.
- detach removes only this adapter's target/action. dealloc removes the same target/action if the table is still alive; duplicate removal is safe. Table replacement through attach detaches the old adapter before attaching the new one.
- Existing application, presentation, account/epoch, model-revision, search, native-navigation, privacy, and geometry gates remain in place. There are no new timers, polling, display links, observation loggers, or broad setContentOffset hooks.

## Required validation boundaries

The QuickTopFixture source now contains native and compatibility cases for a missing delegate begin callback, a completed-return stale anchor, an in-flight source viewport, Changed/Ended events, stale table callbacks, horizontal admission, ordinary vertical admission, and synchronous cancellation while delivering setContentOffset. Its execution evidence and the final frozen-source hashes must be compared with this review before delivery. Existing return-height/shared-height and privacy regressions remain necessary.

A passing fixture cannot establish the on-device visual outcome. Final handover should state that physical acceptance remains pending until the user installs the package and repeats the video gesture.
