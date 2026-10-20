# Task 5 implementation report

Status: DONE_WITH_CONCERNS — implemented verified boundaries and explicit protected fallbacks; native device acceptance remains outstanding.

Commit: `ffaccc52 feat: scope close-friend social presentation and protected edits`.

## Implemented

- `CSCloseFriendSocialProjection` retains original native objects and source coordinates. It filters WCDataItem/WCUserComment username, refUserName and dataItemUsrName, plus WCSNSMessage comment/refComment identities. Object/message IDs are never treated as usernames. Native posts are never copied, proxied or mutated.
- Main legacy WCTimeLineViewController rendering uses synchronous main-thread scopes around native table count/cell/height/selection, item navigation and scrolling. Within these contexts the WCFacade timeline list/count/index reads share one projection, retaining native special-section/body/footer/ad mapping. Outside scopes, including concurrent background reads, the service and model getters return original data. Native reload executes outside the display scope.
- Comment count/index/height/name helpers and cell rendering/getShowComment/click/link/reply callbacks share scoped like/comment getters and native int counts. Stale cells and hidden reply identities are denied. Native comment deletion accepting an index is disabled while interaction concealment is active rather than forwarding a projected index to business deletion. Native source arrays and counts remain intact.
- Verified itemID-based derived like-style/height caches are invalidated before scoped layout, after it, and on policy revision; per-page height/show caches rebuild on policy change. Filtered styles are not retained for unscoped service consumers.
- WCCommentListViewController retains its complete native page/pagination arrays. Visible rows translate back to original source coordinates for native cell/height/select. Native count checks inside translated callbacks see source counts; only table row-count composition receives projected counts. Trailing native load-more rows retain their original coordinates. No synthetic mark-read/delete call is made; native whole-list mark-read and destructive actions are guarded while concealed.
- Timeline unread count/avatar display is scoped and derived from complete unread messages. A source facade not yet observed produces a neutral count rather than stale native count. Unsupported relevance-specific display counts are neutral while concealed. FindFriendEntryViewController independently neutralizes only Moments badge/count and reversibly hides its timeline head-avatar/red-dot views, including hit/accessibility state. Reveal restores native contributions; unrelated Discover rows and aggregate tab count are untouched.
- Status grid count/cell/select/layout/supplementary paths use page-scoped TextStateTopicModel.usernames reads, leaving topic objects and native folding intact. Supplementary headers for topics containing hidden members are omitted to prevent anyTextState/summary fallback leaks, including all-hidden topics. Card provider count/configuration/change/beginIndex use original source coordinates. Direct/unverified single providers are gated; open cards close or remain covered on relock.
- WCMomentsPrivacyViewController has a neutral protected cover while concealed. Visibility-mode, selected-contact/tag and completion operations require a fresh operation after authentication. There is no stale callback replay and no write to WCCommitPrivacySetting.selectContacts/selectTags or native selected sets. Positively identified publishing-owned ContactSelectView logic has a coupled candidate key/row/count projection, separate from the editable ACL. This deliberately means editing visibility requires temporary unlock.
- All Moments privacy buttons are removed from their parent before native layout, suppressing native spacing, hit targets and accessibility. `onShowGroup` is blocked while the independent preference is enabled, including during reveal. Feature/preference disable restores native initPrivacyButton from the intact data item.
- Unsupported personal/detail/Flutter timeline routes and unverified direct status routes use protected covers. Coupled timeline/interaction/status contracts are preflighted; missing key signatures gate the relevant route instead of installing an incoherent partial projection. Runtime hooks compare full normalized encodings, including int/q/Q/B and structs. Capability records remain discovery reports, not protection claims.

## Focused validation

Successful commands (no prior suites or packages rerun):

- `bash Tests/verify-close-friend-social.sh` — `Close-friend social: scoped native timeline/model reads, mixed interactions, cache/source/ACL preservation, status indexes, discovery cues and reveal/relock/account transitions passed`.
- `bash Tests/verify-close-friend-ios.sh --social` — `Close-friend iOS: arm64 + arm64e source objects compiled` (ARC, iOS 15, warnings as errors, six changed production units and the social hook).
- `git diff --check` — clean.

The fixture compiles production projection plus bounded production adapter bodies, installs the real model/facade hook bodies on native-shaped fixture classes, and invokes real source mapping/status/discovery functions. It checks mixed post/like/comment/refComment/refUserName/post-author identities, source array/object/count/ACL equivalence, source-index and trailing-row mapping, in-place source change safety, background unfiltered access, derived cache removal, reveal/relock/account transitions, status indexes and discovery native-counter restoration. Native fixture posts deliberately have no NSCopying support. All data is in memory. TDD was not required; no UI/device simulation is claimed.

## Stable interfaces and files

New coordinator `Controllers/CSCloseFriendSocialAdapter.h` exposes install, main-thread tracking, protected-route/authentication, guarded helper and per-responsibility install functions. Foundation `CSCloseFriendSocialProjection.h` exposes immutable source/visible/indexes, sourceIndex and the exact native identity predicate. Timeline facade access is account-bound; unread begin/end is synchronous main-thread scope only. Existing Task1/Task2/Task4 interfaces were unchanged.

Added focused SocialAdapter, SocialProjection, TimelineAdapter, InteractionAdapter, StatusAdapter, AudienceAdapter production files; Hooks/CloseFriendSocialHooks.xm; Tests/CloseFriendSocialTests.m and verify-close-friend-social.sh. Updated verify-close-friend-ios.sh default sources and added `--social` for affected sources only. Root-owned audit and plan changes are excluded from this commit.

## Self-review and limits

Self-review corrected background scope leakage; stale native scalar unread counts; projected/source count disagreement inside native mapped message cells; cache contamination across unscoped reads; direct comment/delete callback bypasses; protected-card revision handling; and preserved native internal page-list clearing for pagination/source refresh. No service was started/restarted, no checkout/ports/database/account were changed, and no install/deployment or real-account operation was performed.

User-visible tradeoffs: personal/detail/Flutter and unknown single-status routes require unlock; visibility editing requires unlock; comment deletion/whole interaction-list read/destructive actions do not proceed while concealed; protected status-topic supplementary summaries are omitted; Discover Moments notification cues are neutral while concealed; relevance-specific unread display counts are neutral. Ordinary verified main timeline/status/message navigation remains native with presentation projections.

Static extraction, fixture execution and compilation do not prove every device gesture path or native cache/layout implementation. Device acceptance must still check actual native section transitions, card sliding-window transitions, all-hidden/empty layouts, VoiceOver and privacy-button restoration, discovery avatar rebuilding, tag/picker ownership shape, and unsupported-route cover placement. Native display code that directly bypasses the verified getters is not claimed covered without device evidence. No full end-to-end native account workflow was run.

## Review fix round 1

Commit: `e459b2ba fix: revoke stale publishing pickers and interaction render indexes`.

Resolved both Important findings in task-5-review.md:

1. Publishing candidate ownership now includes the actual ContactSelectView, its logic and publishing editor, with account epoch and policy revision. Cached candidate rows validate their binding and projection stamps on every read, including a row request without a preceding keys request. Policy changes immediately revoke the picker operation, discard only its presentation snapshot, shield the actual picker view, disable interaction/accessibility and reload its tables. Native layout reapplies a revoked shield. Verified picker selection/search/multi-select mutation entry points reject stale actions. Native pending selections and real selectContacts/selectTags are retained intact. Because some native completion callbacks do not identify their source picker, the parent editor is also retired after revocation; it cannot accept a delayed old result under a subsequent reveal. The user reopens the privacy editor to begin a fresh operation; no captured callback is replayed.
2. MessagePath now validates the live native array's object identity, bounds and current policy before passing a coordinate to native cell or height rendering. A replaced/reordered/hidden message produces a neutral cell/zero height instead of dereferencing an old coordinate. Trailing rows also require an unchanged native source boundary. Native source updates are never rewritten to match an old projection.

Focused regression additions execute the production binding/refresh/row/action predicates and native cell/height hook bodies. The picker sequence covers revealed full candidates → policy relock → actual tracked refresh callback → shield request and stale row read without keys → denied old action/completion after another reveal → fresh editor operation. The message sequence replaces the previously visible native source object in place with a protected message after count projection, then verifies that both cell and height callbacks return neutral output without invoking the native renderer. UIKit painting is still checked by compilation rather than represented as device validation.

Successful commands/output:

- `bash Tests/verify-close-friend-social.sh` — `Close-friend social: scoped native timeline/model reads, mixed interactions, cache/source/ACL preservation, status indexes, discovery cues, publishing-picker revocation, stale native render rejection and reveal/relock/account transitions passed`.
- `bash Tests/verify-close-friend-ios.sh --social` — `Close-friend iOS: arm64 + arm64e source objects compiled`.
- `git diff --check` — clean.

Changed only AudienceAdapter, InteractionAdapter and the existing focused fixture/runner. No broader tests, native research, package, service or account operations. Root audit/plan changes remain excluded.

## Review fix round 2

Commit: `3e757d92 fix: preserve publishing authorization after picker dismissal`.

Resolved the normal publishing-completion regression from task-5-fix-1-review.md. Operation authorization now checks the owning editor, account epoch, policy revision and explicit revocation independently of the weak picker/logic lifetime. Live picker presentation/actions additionally require those native presentation objects. Thus a successful native completion followed by ordinary picker disposal leaves onDone/onSaveAsNewTag usable under the same revealed authorization. Picker layout/refresh no longer retires the editor merely because its presentation logic disappeared. Policy/account changes and previously revoked editor operations remain denied; no ACL write or callback replay was introduced.

Added one focused regression to the existing fixture: release both weak picker and logic objects after the accepted revealed operation, execute the production FinishEdit guard used by onDone, verify the native continuation runs once with the original ACL retained, and confirm a subsequent account change invalidates that authorization. Existing revoked-picker checks still pass.

Successful commands/output:
- `bash Tests/verify-close-friend-social.sh` — `Close-friend social: scoped native timeline/model reads, mixed interactions, cache/source/ACL preservation, status indexes, discovery cues, publishing-picker revocation, stale native render rejection, completed-picker authorization and reveal/relock/account transitions passed`.
- `bash Tests/verify-close-friend-ios.sh --social` — `Close-friend iOS: arm64 + arm64e source objects compiled`.
- `git diff --check` — clean.

Changed only AudienceAdapter and the focused fixture/runner. No broader suite, native research, environment changes, package or real-account operations. Device presentation acceptance remains outstanding.
