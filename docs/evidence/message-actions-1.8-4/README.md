# 1.8-4 evidence

Scope: fix the confirmed native voice constructor ABI mismatch, distinguish media vs send-preparation failures, and add bounded opt-in observations for the still-unresolved device sticker-menu failure. Baseline: `52e083916af0443fe8976d242d8d40239366643d`; branch `codex/message-actions-refactor-1.7-17`.

The user confirmed that 1.8-3 was installed and restarted: ordinary text/image repeat works; an independent sticker has no Repeat button; incoming and outgoing voices can play but repeat/forward report one unsubmitted target. This is user-supplied runtime observation. It is not a captured method trace and does not establish the phone's exact binary identity.

[Voice native report](voice-native/report.md) binds the `q` constructor signature and bounded downstream analysis to the existing WeChat 8.0.78.34 arm64 image. [Menu native report](menu-native/report.md) records inspected menu stages and the missing phone evidence without asserting an unproven fix. Each directory contains its extraction script, selected metadata/assembly and hash manifest. The main REA target session was closed after investigation; no target process was launched.

[Constructor negative control](host/native-constructor-before-fix.log) is the behavioral assertion failure after correcting the default host fixture to the native 64-bit initializer while production still used the old 32-bit admission. The production correction then passes the actual coordinator path. This is not a compiler-failure negative control.

Final logs: [execution](host/execution.log), [core](host/message-actions-core.log), [gesture](host/message-gesture.log), [time](host/message-time.log), [merge](host/message-merge.log). All five suites passed: 988 + 1,362 + 272 + 142 + 53,200 + 2,872 = **58,836 checks**. Execution output was captured from the completed tool result; other final stdout/stderr streams were written directly by their runners. An initial CHECK-macro comma compilation error in a newly added test was corrected before the passing run.

New execution coverage drives the real media/coordinator/send code through received/outgoing sources, repeat/forward, SILK/OPUS/automatic format cases and duplicate target callbacks. Codec data and calculators are explicit host doubles, not native decoder or recipient-playback evidence. Diagnostic tests execute the actual production observer bodies extracted from RepeatHooks.xm and retain native return identity, including restricted/nil menus. They test opt-in/bounding/reset/schema filtering, not UIKit rendering or real device hook loading.

[Build runner](build-release.py) records the source commit, command, fresh build directories, toolchain, log hashes and exit status in `build-provenance.json` and preserves `rootless-build.log`. The runner checks hashes for 777 tracked `.theos` files and 8 old packages, plus the main checkout HEAD/status, before and after the build.

[Artifact verifier](verify-artifact.py) checks the actual deb metadata, Rootless paths, bundle filter, embedded version, arm64+arm64e slices, 17 required Objective-C classes, 12 exports and 48 required Hook pairs per slice (including the 3 new read-only menu observation hooks). Results are in `artifact-manifest.json`, `artifact-verification.log`, package metadata/contents and per-slice registration evidence. Static registration is not a phone loading check.

The release does not claim the user's sticker-menu failure is fixed. Device diagnosis and voice receipt/playback remain outstanding. No phone install, message send, service/database change, push or merge was performed. See [release notes](../../message-actions-1.8-4.md) for the precise capture steps and remaining uncertainty.
