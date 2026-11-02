# Background Run Hybrid Implementation Plan

> **For agentic workers:** Use the current session's subagents for independent runtime, manager regression, and AI/UI work; the primary agent integrates and reviews each result. The user has approved implementation and packaging.

**Goal:** Replace immediate continuous background audio with task-first, conditional audio execution.

**Architecture:** Manager owns the main-thread state machine. An injectable runtime owns task identifiers and cancellable single-shot checks; the existing audio layer retains session ownership and yielding. AI consumes execution eligibility rather than audio playback.

**Tech Stack:** Objective-C/Logos, UIKit, Foundation, AVFoundation, Theos, host-native stubs.

**Spec:** docs/superpowers/specs/2026-11-02-background-run-hybrid-design.md

## Global Constraints

- Base: 2.2-3 in /Users/zhangshichao/Documents/Workspace/WeChatImprove.
- Keep defaults com.cyansmoke.wechattweak / BackgroundRunEnabled and existing account data.
- arm64 and arm64e; minimum iOS 15.0; Rootless/Rootful isolated outputs.
- Never run make clean, install on device, change shared service, or overwrite historical artifacts.

## Task 1: Runtime ownership

- [x] Create Controllers/CSBackgroundRunRuntime.h/.m: CSBackgroundRunTask.valid/end; CSBackgroundRunScheduledCheck.cancel; runtime uptime/backgroundTimeRemaining/beginTaskWithExpirationHandler:/scheduleAfter:handler:.
- [x] Test each task's independent identifier, begin failure, synchronous expiry, background-thread expiry, duplicate end, stale callbacks, timer cancellation, weak lifetimes using Tests/verify-background-run-runtime.sh.

## Task 2: Hybrid manager

- [x] Extend Manager.h with injected runtime initializer and readonly canAttemptBackgroundWork.
- [x] Replace immediate audio reconcile with the approved 10/5/15-second boundaries, 10-second minimum audio, three 1-second recovery samples and 26-second monotonic task rotation. Bound rotation and player retries; fence resources with generation and identity.
- [x] Add deterministic production-manager tests. Preserve audio/Hook regression through task-denial fallback. Run Tests/verify-background-run.sh; use fake time, tasks, schedules, no real messages or device audio.

## Task 3: AI and settings

- [x] Replace both allowsBackgroundSync audio checks with canAttemptBackgroundWork, test task-only eligibility and capability loss, and preserve 45-second scheduling/epoch guards.
- [x] Update settings description/footer and AI feature documentation to describe task-first execution and audio capability separately.
- [x] Run verify-ai-manager.sh, verify-ai-background-sync.sh and relevant native observer tests.

## Task 4: Integration and delivery

- [x] Independently review production diffs and resource/reentrancy paths; run scheduled-task manager and backup registry/compatibility regressions in temporary stores.
- [x] Advance version consistently to 2.2-4 (no existing 2.2-4 package), add release note and README delivery links.
- [x] Snapshot production inputs and historical artifacts; build Rootless and Rootful using independent temporary .theos/build/package directories, record exit codes/warnings/input hashes.
- [x] Verify payload paths, architectures, iOS version, filter, new runtime and capability methods, staging payload hashes and dSYM UUIDs; create symbols ZIP and SHA256SUMS exclusively in packages/2.2-4-background-run-hybrid/.
- [x] Record test/build/package evidence and limits in docs/audits/background-run-hybrid-2026-11-02/README.md; deliver clickable artifacts with actual validation results.
