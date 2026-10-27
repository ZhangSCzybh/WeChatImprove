# AI Auto Reply Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox syntax for tracking.

**Goal:** Implement the approved account-scoped native AI reply feature on codex/ai-auto-reply.
**Architecture:** Foundation store/client/coordinator with explicit native adapter boundaries. UIKit settings and native detail sections consume one manager; outbound text uses the existing prepared-send adapter.
**Tech Stack:** Objective-C, Logos, UIKit, Foundation, Security, Theos.
**Spec:** docs/superpowers/specs/2026-10-27-ai-auto-reply-design.md

## Global Constraints
- iOS 15, arm64 and arm64e; preserve existing settings styles and source baseline d364397d.
- Work only in this attached worktree. No actual API request, message send, database change or shared checkout edit.
- Strict default-off account/conversation gates. Never log secrets or raw chat bodies. Unknown sends never retry.
- Core regression only; use production Foundation code with temporary files, URLProtocol and native fakes.

### Task 1: Configuration, credentials, HTTP client
**Files:** CSAIReplyStore.h/.m, CSAIClient.h/.m, CSAICredentialStore.h/.m; Tests/AIReplyStoreTests.m, AIClientTests.m, verify-ai-foundation.sh.
**Interfaces:** Exact declarations are checked in under Controllers. Configuration keys: enabled (bool), endpoint/model/credentialRevision/verifiedConnection (strings), verifiedAt (optional NSDate), presets (array id/name/prompt), defaultPreset (id), conversations (dictionary conversationID → enabled/presetID). Empty presetID inherits default. State keys schema/account/configuration/handled/history. History: date/conversation/preset/result/detail only, max 200; ledger max 5000 recent identities, 7-day retention. Presets 1–50, name 1–60, prompt 1–12000; conversation limit 1000. HTTP client callbacks on main, once, cancellation suppresses late success, 60 sec, no redirects, no cookies/cache, max response 1 MiB and output 4000 chars. HTTPS complete URL with no URL credentials/fragment; model nonempty max 200. Bearer authentication, model/messages/stream:false JSON. Use URLProtocol tests, no actual network. Error bodies never exposed; map status to safe Chinese messages. Keychain service com.wechatimprove.ai-reply.v1, account+revision immutable slots, AfterFirstUnlockThisDeviceOnly, no sync.
- [x] Test initially missing implementations using `bash Tests/verify-ai-foundation.sh` then implement production store/client/credentials.
- [x] Assert `!store.configuration[@"enabled"].boolValue`, corrupt load preserves bytes, duplicate claim returns NO, portable state omits ledger/history/verification/credential revision, config contains no key.
- [x] Fake URLProtocol: 200 valid text, 401, 429, 500, malformed/empty JSON, cancellation, timeout, redirect and response bounds.
- [x] Run the focused script, self-review and commit only owned files.

### Task 2: Reply policy and coordinator
**Files:** CSAIReplyCoordinator.h/.m, CSAIReplyPolicy.h/.m, Tests/AIReplyCoordinatorTests.m, verify-ai-coordinator.sh.
**Interfaces:** Coordinator consumes the Task 1 store and CSAIGenerating client. Receives immutable message events with account/conversation/sender/identifiers/text/type/group/mentioned/atAll/created/live. Delegate supplies account/privacy validity, credential and native send with a final authorization closure. Expose receiveEvent, configurationDidChange, cancelAll, processPending, and injectable now clock. All operations main-queue serialized. Root integrates its header before implementation.
- [x] Assert filtered events create zero network tasks and zero native sends; true mentions create one. Test two callbacks sharing either server/local identity, batching, global max 2, one conversation at a time.
- [x] Implement 2-second debounce, 120-second expiry, 20 pending batches, context 10 messages/12000 chars, no context until new live messages after enable/start. Claim before model request; store failure aborts.
- [x] Assert delayed results after disable/account/config/privacy changes do not send; manual replies leave AI active/pending/context intact; cancellation frees capacity, old callback cannot mutate new task. Unknown submission never retries. Configuration change clears memory and resets admission boundary.
- [x] Run `bash Tests/verify-ai-coordinator.sh`, self-review and commit only owned files.

### Task 3: Native/UI integration and backup
**Files:** CSAIReplyManager.h/.m, CSAIMessageAdapter.h/.m, CSAIChatDetailAdapter.h/.m, CSAIReplySettingsViewController.h/.m, CSAIPresetViewController.h/.m, Hooks/AIReplyHooks.xm; modify CSCustomViewController.m, CSBackupRegistry/Engine/Manager/PreviewViewController and targeted regression link inputs.
**Interfaces:** Manager owns current-account store/coordinator/client, exposes configuration editing, testConnection, setConversation, preset selection, status, display names. Hook snapshots only verified AsyncOnAddMsg receive events; do not observe outgoing AddMsg for cancellation. Tag own AI wraps before submission so they cannot reenter incoming admission. Native private APIs verify type encodings before call. Reuse CSMessageSendAdapter.prepareScheduledText. Backup uses ai_reply virtual domain and existing prepared/applying/committed lifecycle.
- [x] Implement native snapshots, account epoch and privacy gates, manager UI mutations with expected account/epoch checks, Keychain staged revision, test result fingerprint check.
- [x] Use WCTableViewSectionManager/WCTableViewCellManager candidates with validated signatures and table container; add/remove only owned sections, preserve native indexes by insertion after existing sections, refresh state without recursion. Test doubles assert repeated reload has one section and stale controllers reject updates.
- [x] Implement native-style settings with secure connection editor, multi-preset editing/copy/replacement, conversation list and history; long value truncation; changes only on Save.
- [x] Add backup capture/sanitize/restore/rollback and automatic configuration notification; test account mismatch, restored off/unverified, old backup preservation, secret exclusion.
- [x] Run focused native and backup core tests plus existing scheduled-task and send-path regression affected by shared integration.

### Task 4: Review, compile, delivery
**Files:** docs/features/ai-auto-reply.md, plan progress; no main checkout release/version changes.
- [x] Review task diffs for spec and quality; fix load-bearing findings with regression cases.
- [x] Run focused core regression and Theos arm64/arm64e build using fresh isolated build output; never `make clean` which deletes packages.
- [x] Commit feature and evidence, report branch, worktree, tests and precise unverified device behavior. Keep branch for review; no automatic merge/deploy.

## Completion evidence
Final source commit: `987dbda0`. Task 1 and 2 independent reviews and final task 3 / whole-feature scoped review passed. Current manual-reply coexistence requirement supersedes the initial manual-cancellation behavior. Core regression and arm64/arm64e build evidence is in `docs/features/ai-auto-reply-validation.md`; target-device acceptance remains explicitly unverified. Branch/worktree are preserved for review, with no merge or deployment.
