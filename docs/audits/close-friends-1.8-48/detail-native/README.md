# Native Moments detail interaction evidence (1.8-48)

Target: `/tmp/wechat-8.0.78-inset-analysis/WeChat`, SHA-256 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`. This is static evidence from the established 8.0.78 arm64 executable. Existing Objective-C metadata parsing and bounded `llvm-objdump` were reused; no device, account, message, or database was exercised. Root agent owns the REA session; this subtask did not open or close it.

## Observed rendering path

The screenshot of the user's own post is consistent with `WCCommentDetailViewControllerFB`: its native implementation has a table header for the post, a `WCHeaderGridView` row of like avatars, and `WCCommentView` rows for comments. A static screenshot cannot establish whether the device selected FB or Flutter. Both classes exist in the binary. The implementation therefore covers the verified FB path and selects the app's existing FB route while relevant privacy settings are enabled.

The important behavior is **direct ivar access**, not the property getter names in old headers:

| Method | Actual ABI | Evidence |
| --- | --- | --- |
| `-setDataItem:` | `v24@0:8@16` | Reads `commentUsers` at `0x106e720a0` and stores its retained result in `_arrCommentList`; reads `likeUsers` at `0x106e720d0` and stores in `_arrLikeList`. |
| `-tableView:numberOfRowsInSection:` | `q32@0:8@16q24` | `0x106e94b08` / `0x106e94b28` directly read the two page arrays. Ordinary row count is comments plus one row when likes are nonempty; optional ad-firework/read-count rows are added separately. |
| `-tableView:cellForRowAtIndexPath:` | `@32@0:8@16@24` | Subtracts the likes-row offset, reads the page comments array, passes the comment object to `FormCommentTipsView:`, and writes the comment index to that view's `tag`. |
| `-tableView:heightForRowAtIndexPath:` | `d32@0:8@16@24` | Uses the same array/offset convention. Likes use `_headerGridView.height`; comments use the same `FormCommentTipsView:` result. |
| `-updateHeaderGridView` | `v16@0:8` | Clears the previous `_headerGridView`, then enumerates `_arrLikeList`, reads each username, and creates `WCHeaderGridView` with user info and like count. Zero likes leaves no grid. |
| `-FormCommentTipsView:` | `@24@0:8@16` | Reuses `m_dicUserCommentsUICache` keyed via `getCommentsUICacheKey:`; creates/layouts a native `WCCommentView` otherwise. |
| `-reloadData:` | `v24@0:8@16` | Invokes `setDataItem:`, `updateHeaderGridView`, and `reloadTableView`. |

Verified object ivars: FB `_arrCommentList` offset 688, `_arrLikeList` offset 696, `_headerGridView` offset 136, `m_dicUserCommentsUICache` offset 552. WCDataItem `_likeUsers` offset 400 and `_commentUsers` offset 408; their getters are plain direct reads in this build. Production uses runtime ivar lookup with object-type validation, never these numeric offsets.

## Why the former filter missed this page

The pre-existing timeline scope filtered `WCDataItem.likeUsers/commentUsers` only for known main-timeline rendering calls. Detail construction caches these lists; subsequent count/cell/height calls dereference cached ivars without calling the model getters. Merely wrapping the detail table callbacks in the old getter scope would not change those already-cached lists.

The new `CSCloseFriendDetailAdapter.m` projects only page-local arrays during synchronous count, cell, height, comment-view creation and grid creation. It restores the original page references in `@finally`. The underlying WCDataItem arrays remain intact. Opening a detail can itself occur inside a main-timeline projection scope, so `setDataItem:` rebinds its page cache to the verified raw model ivars after native setup. This keeps later reveal and native actions attached to complete source data.

A policy change clears the native comment UI cache, rebuilds the native like grid, and asks the native table to reload. The same hidden-identity projection handles comments authored by a close friend and comments whose `refUserName` targets a close friend. Native optional footer/read-count/ad branches continue to compute their own layout using the projected arrays.

## Action-index safety

`-onClickContent:way:` (`v32@0:8@16q24`) reads `view.tag`, indexes `_arrCommentList`, and dispatches the comment action. `onClickSelfComment:comment:index:confirmDelete:` and `onClickFriendsComment:comment:index:replay:` are both `v44@0:8@16@24q32B40`. They pass the index into native menus; `actionSheet:clickedButtonAtIndex:` later reads the original page array by its tag and passes the resulting **object** to `deleteCommentWithDataItem:comment:`.

The adapter therefore binds each native comment view to its actual comment object, item, account epoch, and policy revision. After drawing, it converts the view's projected index back to that object's current source index. Action callbacks validate the identity again and recompute the source index; a hidden, removed, previous-policy or previous-account view is rejected. No projected index enters the native deletion/reply pipeline, and the adapter neither sends a comment nor deletes one during refresh. Source arrays are restored before an action is forwarded.

The like grid uses a different, already-safe indexing contract: `WCHeaderGridView -onClickHeadImageView:` (`v24@0:8@16`) indexes its own `m_arrContacts` and passes the selected contact object to the block. The FB block at `0x106e8cb90` directly passes that object to `setM_contact:` and pushes the contact page; it never reads `_arrLikeList` again. The original filtered grid therefore keeps the correct avatar/contact correspondence after the page source arrays are restored. The adapter adds owner, policy revision, account epoch and identity checks only to grids it created, preventing an old revealed grid from opening a now-hidden contact after relock. Evidence: `WCHeaderGridView--onClickHeadImageView_.asm`, `FBLikeGridBlock--invoke.asm` (complete block through the next function boundary).

## Native detail routing

`+WCTimelineRouterHelper isFlutterDetailEnabled` has `B16@0:8`; its implementation reads `WCFacadeDynamicConfig -Moments_enableFlutterDetail`.

Two verified native helpers branch on that flag:

- `+navigateToCommentDetailViewController:failedComment:currentViewController:pageContext:`: `v48@0:8@16@24@32@40`.
- `+navigateToCommentDetailViewController:tipType:currentViewController:pageContext:`: `v48@0:8@16q24@32@40`.

On false, they allocate the class at classref `0x120176828`, confirmed as `WCCommentDetailViewControllerFB` in `route-classrefs.json`, configure the original data item/context/delegate/tip or failed-comment fields, and call the existing native navigation push. The adapter only changes the returned routing decision while the feature is enabled with a nonempty protected list and `hideInteractions` or `hideTimeline`; it does not write a config value. Temporary reveal still chooses FB so relocking an open detail can refresh it. Disabling the feature returns the original preference.

`-FlutterSnsNativeRouterPlugin pushDetailWithWCDataItem:` (`v24@0:8@16`, `0x101c164e8`) already allocates that same FB class, assigns the original item/username/delegate, and pushes it. This establishes one native-detail path directly from Flutter code without requiring payload conversion.

The separate Flutter detail initializer and Dart/FFI payload transformation were not broadly reverse engineered in this task. No claim is made that every manually constructed Flutter controller is rewritten. The verified helper's native branch plus the existing native plugin path are the implemented integration points; actual device routing remains part of acceptance.

## Focused verification

`bash Tests/verify-close-friend-detail.sh` compiles the **entire new production adapter body** against native-shaped Foundation fixtures and installs its real hooks. 35 checks passed: mixed ordinary/hidden likes and comments on an own post, hidden referenced users, aligned row counts/heights/cells, native trailing row retention, grid cache refresh, source pointer/content preservation, original action mapping, source reordering/removal, reveal/relock, old-account rejection, exception restoration, avatar click identity, stale grid callback rejection, timeline-only protection with interaction hiding disabled, and relevant native route decisions. The fixture also opens a detail while the model getters are already projected by an outer timeline scope.

This host suite does not establish a successful iPhone rendering or install. The parent task owns the full iOS build/package verification and device handoff.
