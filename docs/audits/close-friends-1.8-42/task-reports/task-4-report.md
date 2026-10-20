# Task 4 report

Status: DONE_WITH_CONCERNS (implemented boundaries pass focused checks; native device acceptance remains outstanding).

Commit: `7ced6a39 feat: scope close-friend contacts search and stranger profiles`.

## Implementation

- Main contacts and forwarding-bound ContactSelectView logic use immutable, coupled key/section/row/count projections. Native contact objects, relationship flags and source arrays remain intact. Favourites and recent-forward menus return filtered copies. Recent-forward presence predicates use visible rows, with native icon rebuilding and action-time identity checks.
- Forwarding recipients are indivisible. Account epoch/policy revision tickets reject and natively cancel stale operations instead of silently trimming recipients. Final callbacks and selection predicates recheck policy. Native search callback copies and page-owned search buffers keep key/row mappings together; mutable native buffers are copied separately from source snapshots.
- Forwarding's message-origin candidates use the verified `sessionSelectMessageSearchLogic:shouldIncludeContact:` allow predicate to gate that route while hidden. Ordinary contact/group candidates remain available. No out-object-pointer merge method was guessed or called; the native query and cursor are unchanged.
- Tag detail generation omits hidden members only from derived sections. Native complete membership and cell tagData are retained. Summary counts/text and detail empty state use visible membership. Tag search and destructive/full-replacement member edits require authentication and a fresh user operation; successful authentication never replays stale edit arguments.
- FTS contact/group/top-hit section arrays retain source copies and install current-policy presentation copies after native updates, including direct-ivar updates. Epoch/task-key checks protect delayed delivery; generation/revision checks protect selection. FTS message and aggregate contact routes display a neutral `解锁后查看` row while concealment is active; native cursors/models remain intact and there is no guessed extra-page loading.
- Group result data cells and structured group top hits retain their native cell/contact and selection, but use a reversible cover containing only public group title/avatar. Member-match/secondary summaries and their accessibility text are suppressed while hidden. Structured group matches without proven public identity show `群聊`; arbitrary top-hit keys are never treated as usernames. Reveal restores original native presentation. This intentionally removes richer group match metadata during concealment.
- Profile controllers bind their exact assist instance. Hidden individuals get a page-owned public-avatar/public-nickname stranger presentation and local `添加到通讯录`. It covers native remark/tag/status/Moments/friend controls and navigation actions. The local button only shows a local notice. Guarded add/verify/message/call/edit entry points recheck current epoch/policy. Reveal restores hidden/accessibility/navigation state and asks native code to rebuild from the intact contact. No global identity getter, friendship flag, stored message, or membership is modified.

## Validation

Latest successful focused commands:

- `bash Tests/verify-close-friend-contacts.sh` — `Close-friend contacts: projection/source/tag preservation, stale forwarding, profile action guards passed`.
- `bash Tests/verify-close-friend-ios.sh --surfaces` — `Close-friend iOS: arm64 + arm64e source objects compiled` (ARC/iOS 15; affected four adapters/helpers and three hooks; warnings treated as errors).
- `git diff --check` — clean.

The behavioral fixture executes real projection/ticket code and production-extracted profile predicate/action guards. It checks coherent count/index/selection, immutable source snapshots and source changes/reveal, complete tag membership, whole-operation stale forwarding rejection, no native add/message under profile masking, native action restoration on reveal, account-stale assist denial, public nickname instead of saved remark, and public group title instead of member-match summary. It does not simulate the complete WeChat UI or prove device protection. TDD was not required. No full existing group/runtime suite was rerun.

## Files and stable handoff

Added:
- Controllers/CSCloseFriendContactProjection.{h,m}
- Controllers/CSCloseFriendContactAdapter.{h,m}
- Controllers/CSCloseFriendSearchAdapter.{h,m}
- Controllers/CSCloseFriendProfileAdapter.{h,m}
- Hooks/CloseFriendContactHooks.xm, CloseFriendSearchHooks.xm, CloseFriendProfileHooks.xm
- Tests/CloseFriendContactTests.m, Tests/verify-close-friend-contacts.sh

Updated Tests/verify-close-friend-ios.sh: default compilation includes these sources; `--surfaces` compiles only Task4's changed production sources.

Existing bridge/policy interfaces were not changed. Reusable Foundation interfaces are `CSCloseFriendContactProjection`, `CSCloseFriendVisibleContacts`, `CSCloseFriendSelectionTicket`, and `CSCloseFriendSurfaceConcealed`. UIKit adapters expose `CSCFVisible`, guarded object setters/calls, surface tracking, selection validation, and page epoch checks in their headers. New C exports used by Logos have C linkage.

Task5 ownership: generic ContactSelectView/谁可以看/publishing ACL selectors are deliberately left complete and native. Only direct SessionSelectController-owned ContactSelectView is bound here. Task5 can reuse the immutable contact projection for its own presentation, but must retain original ACL plus visible changes (or require authentication); do not globally bind/filter all ContactSelectView instances.

## Self-review and limits

Self-review corrected refresh-selector overwrites, native mutable search-buffer compatibility, stale selection callbacks, profile identity reuse, public nickname sourcing, group-member summary leakage, native-empty recent-forward presence, and C/C++ linkage. No real account data, service process, ports, checkout or database was switched. Work stayed in the authorized checkout on codex/close-friends; no package/install/deploy or native-account operation occurred. The controller's unrelated `docs/audits/close-friends-1.8-42/` work is excluded.

Capabilities are interface discovery, not device validation. Runtime/native acceptance still needs to confirm current page ownership/ivar shapes, actual cell selection and native recent-forward rebuilding, all-hidden layout, profile avatar loading and restoration/VoiceOver, and the currently verified FTS result-page reload contract. Independent smart/media controllers outside these verified section boundaries are not claimed as covered; message/aggregate paths in the verified controllers are deliberately gated. Unsupported result-route capabilities (`search.message.filtered`, `search.extra-page-loading`, `forward.message-search.filtered`, `tags.search.filtered`) are explicitly false. Public avatars use snapshots of native avatar-only views with a system fallback until available; there is no network image request in the adapter.

## Review fix round 1

Commit: `a77b0045 fix: isolate native search updates and profile assist bindings`.

Resolved both Important findings from task-4-review.md:

1. Removed search-container pointer-equality freshness detection. `CSCFForwardSearchWillUpdate` starts a native-update scope with mutable copies of the complete previous source, so partial merges do not start from filtered rows. Full native callbacks may clear/repopulate those same buffers. The outermost `CSCFForwardSearchDidUpdate` always snapshots their current contents (including copied section rows), applies the current presentation policy and reloads the page tables. Nested merge callbacks publish only once; policy-only refreshes cannot replace a native update in progress. Thus query two cannot restore query one's saved sections, and reveal uses query two's complete sources.
2. Separated controller presentation state from immutable assist authorization bindings. Each assist binding captures owner, username, account epoch and controller generation. Rebinding changes the controller generation/current assist without mutating old bindings. Every guarded assist action checks its own current contact identity, binding generation/epoch and whether it remains the active assist. Retired, identity-mismatched and account-stale assists are rejected, including during reveal.

The focused runner now compiles and executes the real production profile binding and action-decision functions; the former `Masked(ProfileState)` authorization replacement was removed. Added only the two requested regressions: consecutive in-place query rebuilding with nested merge/policy refresh and complete-source reveal, plus old-assist-after-controller-rebind while the new ordinary-contact assist remains usable.

Final successful commands/output:
- `bash Tests/verify-close-friend-contacts.sh` — `Close-friend contacts: projection/source/tag preservation, stale forwarding, profile action guards and native-reuse regressions passed`.
- `bash Tests/verify-close-friend-ios.sh --surfaces` — `Close-friend iOS: arm64 + arm64e source objects compiled`.
- `git diff --check` — clean.

Changed only the contact adapter/header + contact hook, profile adapter, and focused fixture/runner. No broader regressions, new native research, service changes or account operations. New handoff API: pair `CSCFForwardSearchWillUpdate` / `CSCFForwardSearchDidUpdate` around synchronous native update callbacks; use `CSCFRefreshForwardSearch` only for policy-derived presentation refreshes.

Controller-supplied follow-up evidence establishes that current 8.0.78 `FTSFeatureMessageSectionController` inherits the gated boundaries from `FTSMessageSectionController` without overrides (`search-feature-metadata.json` in the SDD). This narrows the earlier coverage uncertainty for that class; it required no production change and is still static evidence, not device acceptance.
