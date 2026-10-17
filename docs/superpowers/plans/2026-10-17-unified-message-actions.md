# Unified Message Actions Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Refactor all message gestures, repeat and voice forwarding from 1.7-17 without losing supported user behavior, then build an isolated Rootless arm64/arm64e package.

**Architecture:** Three existing settings and interaction entry points share one account-bound message action subsystem. Pure settings/policy/request state are separate from UIKit gestures/menus and native message/media/forwarding bridges. One operation has one submission owner; cancellation cannot submit.

**Tech Stack:** Objective-C ARC, Logos/Theos, Foundation/CoreGraphics host doubles, UIKit; iOS 15 deployment target.

**Spec:** docs/superpowers/specs/2026-10-17-unified-message-actions-design.md

## Global Constraints

- Base 2aa7bcb8 (1.7-17), isolated branch codex/message-actions-refactor-1.7-17; never edit the user's original checkout or its .theos outputs.
- Preserve the three settings pages, existing defaults keys and action enum 0 disabled,1 quote,2 delete,3 forward,4 favorite,5 revoke,6 repeat.
- Gesture repeat is independent of menu-repeat and voice-forward toggles; do not narrow supported message types.
- Source messages/media are read-only; no live message sends, device installs, database resets or migrations.
- Only Ended can submit a gesture. Unknown native submission never triggers another sending route. Every target has its own status and new message identity.
- Native declarations alone do not prove timing; use docs/evidence/message-actions-native-2026-10-17 for artifact evidence and explicitly track residual device limitations.
- Keep original native picker/confirmation/comment/cancel flow, exact operation-scoped recipients, and native cleanup.
- No synchronous plugin media IO in gesture/menu callback; no preference reads in Changed; no idle polling.
- Package version 1.8-0, Rootless arm64 and arm64e. Preserve old packages; no make clean, no push/merge/install.

## Task 1: Shared settings, policy, context and submission state

**Files:** Create Controllers/CSMessageActionPolicy.{h,m}, CSMessageActionPreferences.{h,m}, CSMessageActionContext.{h,m}; Tests/MessageActionCoreTests.m and Tests/verify-message-actions-core.sh. Settings controller integration may centralize only constants/enums; do not change other hooks yet.

**Interfaces:** Foundation-visible CSMessageAction enum with persisted values 0..6; CSMessageActionEntry identifying gesture/menu-repeat/menu-voice-forward/native-forward; CSMessageActionSettings immutable snapshot; settings changed notification; context with account, chat, source identity, sourceWrap, weak cell/controller and account epoch. Publish methods in headers and record exact names in task report. Policy exposes entry gating, direction/action selection and pure gesture threshold predicate. Per-target state model must implement guarded one-time submission and terminal transitions, reusable by coordinator.

- [ ] Write behavior tests before implementation. Cover each entry under three independent toggles, four swipe configurations, unsupported enum, native forward behavior, received/sent identity, parent model fallback, same operation repeated commit vs two distinct operations, Cancelled/Failed, reverse velocity, short high-velocity movement.

```objc
// Exact invariants to encode against the final public API:
// menu repeat disabled + gesture enabled/action repeat => gesture permitted, menu not permitted.
// Cancelled with x=-70 and width=300 => no submit.
// Ended x=-10,vx=700,direction=left => no submit.
// one operation/target beginSubmission twice => first YES, second NO.
// distinct operationIDs for same message => each may submit once.
```

- [ ] Run `bash Tests/verify-message-actions-core.sh`; capture initial failing behavior and final counts in report, using isolated defaults suites only.
- [ ] Implement validated helpers: nil-returning current-message selector continues model/parent fallback; stable identity is account+chat+IDs or bounded object binding identity, never message text. Unknown account/context fails closed for side effects. Explicit BOOL/object ABI. UI-free core can be hosted without fake success semantics.
- [ ] Cache only related settings keys with coalesced main-thread updates; bridge Darwin and NSUserDefaults notifications correctly. Preserve settings import/reset behavior through activation refresh. No permanent account service cache.
- [ ] Commit only own sources/tests, report API and tests for downstream tasks.

## Task 2: Shared native actions, media/send coordinator and menu/forward integration

**Files:** Create Controllers/CSMessageActionCoordinator.{h,m}, CSMessageNativeActionAdapter.{h,m}, CSMessageMediaProvider.{h,m}, CSMessageSendAdapter.{h,m}, CSVoiceForwardAdapter.{h,m}, CSMessageActionMenuAdapter.{h,m}, native declarations as needed; replace Hooks/RepeatHooks.xm and Hooks/VoiceForwardHooks.xm with thin integrations; extend Tests/MessageAction* and verification scripts.

**Interfaces:** Consume Task1 headers verbatim. Public facade must support executing a captured CSMessageActionContext with CSMessageAction and CSMessageActionEntry; revalidate context and entry. Menu and native forwarding share same operation ID across native selection. Export lifecycle/account cancellation and result APIs in the coordinator headers for Task3.

- [ ] Read exact Task1 APIs and native evidence before choosing routes. Enumerate baseline text/image/voice/video/emoji/card/location/app/generic route capabilities from all three old hooks, not just RepeatHooks.
- [ ] Add host invocation-recording tests for multiple targets, duplicate callback, wrong-context target, accepted/unknown no fallback, toggle-off cleanup, cancel before media ready, account switch, weak page lifetime, original-wrap immutability, and accurate BOOL scalar invocation.

```objc
// Failure injection contracts:
// native submit records side effect then throws => state Unknown; no alternate route invocation.
// targets A,B; A accepted,B refused => retain two results; never resend A.
// callback for logic B must never consume logic A's source/targets.
// preparing voice cancelled before read completion => no submit.
```

- [ ] Implement shared media preparation off-main with one bounded preparation queue; reusable source voice resource, precise units, download continuation and cancellation; no arbitrary new file-size cap. Ownership must outlive consumer upload as required by verified route.
- [ ] Implement per-type new packaging/route selection preserving all actual baseline capabilities. Route selection precedes side effects. Do not paste an unchanged 1600-line method into a new file or leave legacy unsafe path as fallback.
- [ ] Implement quote/delete/favorite/revoke with original confirmation and revalidation; actual object argument and ABI from evidence. Keep native UI scope and no raw database operations.
- [ ] Bind forwarding to specific native logic and final exact target list. Preserve original selection/confirmation/comments/cancel/cleanup and single native/plugin submission owner. Remove all-context recipient scanning and single-BOOL batch success.
- [ ] Centralize menu policy across injection/canPerform/execute; preserve item order, icon behavior and existing action selectors as thin compatibility handlers; remove unconditional menu debug traversal.
- [ ] Run core plus new action/media/native tests; run a temporary isolated Theos compile to catch API/Logos errors, not a final release yet. Commit scoped files; report remaining test/device limits honestly.

## Task 3: Gesture adapter and deterministic cell lifecycle integration

**Files:** Create Controllers/CSMessageGestureAdapter.{h,m}, CSMessageCellLifecycle.{h,m}; replace Hooks/MessageGestureHooks.xm; modify only necessary delegates/lifecycle in Hooks/MessageTimeHooks.xm and Hooks/MessageMergeHooks.xm; update HeadersFile/CommonMessageCellView.h to remove stale plugin declarations; settings controllers use shared constants. Add Tests/MessageGestureAdapterTests.m and host harness as needed.

**Interfaces:** Use task1 context/settings/policy and task2 coordinator. Cell lifecycle must call merge/time original functionality in explicit sequence without double execution on subclass/super hooks. Gesture adapter must retain no account service or page, and native recognizer delegates remain intact.

- [ ] Add behavior tests: no native takeover for vertical/disabled direction/controls; only own bubble region; edge-return priority; cancellation/Failed zero action; two deliberate gestures two operations; model rebind during gesture zero action; active gesture settings change cancels; existing base transform preserved.

```objc
// Test using production adapter with UIKit doubles:
// begin source A; bind source B; end crossing threshold => execute count 0.
// disable configured direction => shouldBegin NO, no haptic, no transform.
// native baseline transform scale !=1; drag/reset => baseline preserved.
// same layout repeated => recognizer count unchanged, defaults reads unchanged.
```

- [ ] Install independent pan delegate; migrate message-time tap delegate in same change to remove both duplicate %new methods. Restrict failure/simultaneous rules to actual competing recognizers and navigation pop recognizer.
- [ ] Freeze context/action/direction on begin, use shared trigger policy, preserve distance 20%/minimum60 and speed600 with same direction and minimum12pt, one readiness haptic. Changed does not query prefs/services/files or allocate tasks.
- [ ] Coordinate layout/reuse/setViewModel with message merge/time through lifecycle owner; remove plugin offset before native layout and reapply after derived layout; never Identity-reset unowned transform or removeAllAnimations.
- [ ] Restore/animate visuals before calling business facade; no cell pointer dependence after send handoff; reduced-motion and cancellation cleanup.
- [ ] Run new gesture tests and existing message-time/message-merge/bubble/revoke regressions. Commit and report exact coverage plus UIKit-device limits.

## Task 4: Integrated validation, release metadata and package

**Files:** control; Headers/CSUserInfoHelper.h; Controllers/CSReleaseNotesViewController.m; README.md; docs/message-actions-1.8-0.md; docs/evidence/message-actions-1.8-0/; packages/com.wechat.improve_1.8-0_iphoneos-arm64.deb.

**Interfaces:** Whole branch diff against 2aa7bcb8; consume test reports and artifact-contract report.

- [ ] Execute cross-entry integration cases and final spec/code review, resolve important findings with covering tests.
- [ ] Update version to 1.8-0 and truthful release notes. Record native artifact vs actual-device evidence separately; do not claim unrun device acceptance/FPS.
- [ ] Run changed subsystem suites and relevant message time/merge/bubble/revoke suites. Use `make package SCHEME=rootless` in isolated checkout with valid absolute THEOS. Do not run clean target.
- [ ] Verify deb metadata, payload path, arm64/arm64e slices, exported symbols/runtime-hook registrations, package hash and source commit. Keep original packages untouched.
- [ ] Commit scoped source/tests/docs and final package if appropriate; no .theos build noise. Final response includes branch, base, worktree, package link, validation and device limits.
