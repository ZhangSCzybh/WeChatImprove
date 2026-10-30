# Independent native sync observer regression

Command: `bash Tests/verify-ai-native-sync-observer.sh --ios`.

Result: **828 checks passed**: 786 checks in the main fixture and 7 independent process cases with 6 checks each for rejected installation ABIs. The actual production observer source also compiled for iOS 15 arm64 and arm64e with warnings treated as errors. Output is recorded in `observer-independent.log`.

The fixture compiles `Controllers/CSAINativeSyncObserver.m` directly. It extracts the unchanged native-dispatch helper portion of `CSMessageNativeActionAdapter.m`, uses real Objective-C runtime method replacement for `MSHookMessageEx`, and dynamically registers fake `NewSyncService`, `NewSyncRequest`, `NewSyncResponse`, and `ProtobufCGIWrap` classes. Service Boolean ivars and callback arguments use `_Bool`, so the positive fixture supplies the required `B` encoding. Separate invocations prove that `c`, incorrect widths, return types, and argument counts do not install hooks. Installation temporarily substitutes the main bundle version with 8.0.78, then restores the original getter.

The regression verifies:

- Original create/return/handle order, original invocation counts, exact object/scalar arguments, Boolean results, and native exception propagation. Observer metadata exceptions preserve original native execution.
- A complete normal request selector `0x40007`, CGI 138, terminal `ret == 0`, zero continuation flags, and `processed == YES` are required. Acceptance alone, busy/rejected creation, and creation without an event do not establish coverage.
- Completion waits behind native main-queue idle work and rejects uninitialized, paused, need-sync, native-error, active-event, getting-data, or operating states. Response mutations or metadata exceptions at handle/queued-completion boundaries consume the old observation without allowing later revival.
- Concrete service/response/request/wrapper identity, event identity, and account epoch remain required across all three hooks and queued completion. Wrong services, unknown host versions, disabled ingress, unavailable context, and off-main observation cannot establish coverage.
- The wrapper marker binds only its expected epoch. Unbound native events cannot opt in, an epoch change requires a new wrapper binding, and both normal and throwing/nested marker scopes restore their previous state.
- Native create reentry preserves the newer transaction context. A marker can be claimed only once: a second raw service cannot inherit it from the first service's original method, refusal, or exception. Capture-getter reentry cannot claim an outer marker or bind another service.
- A queued completion is accepted at an age below 45 seconds and rejected at 45 seconds, after a backward clock movement, or with a non-finite clock. This uses a temporary Foundation uptime getter replacement restored in `@finally`.

No production file was modified by this regression task. No package build, installation, real WeChat service, account, network request, or database was used. These are host/runtime fixture results and iOS object-compilation checks; they do not claim device-level behavior on an installed host.
