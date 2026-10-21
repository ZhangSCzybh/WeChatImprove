# Timeline first frame — 1.8-49

Static target: WeChat 8.0.78, arm64, SHA-256 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`. Native evidence is read-only. No target process, live database, or device was changed.

The user screenshot shows the main timeline, with a normally drawn header and first post followed by a black region. The user reports that a scroll repairs it. No runtime layer hierarchy was available, so the exact black layer is not identified from this screenshot alone.

Confirmed source and native behavior:

- Before this change, the policy refresh cleared presentation caches and recursively called UIKit `reloadData`. There was no main-timeline first-appearance/layout reconciliation.
- Native `reloadDataWrap` at `0x10a0b9048` sets `_isReloadingData` (ivar reference `0x1202741f8`, offset 255), clears the native reload cache and calls table `reloadData`. The first cell resets `_isReloadingData` at `0x10a0c6938`.
- Native `viewDidLayoutSubviews` sets the table frame from native page width / `getVisibleHeight`, then runs `layoutTableFooterView`. The footer helper resizes a native customized blank view and has no data-fetch API.
- `p_reloadTableViewContent` also calls `updateContentOffset` and `handleAfterReloadTableView`; the latter invokes autoplay/ad actions. These are not synthesized by the fix.
- `initBackgroundView` constructs an input-toolbar blur view below the screen; it is not evidence of the screenshot's missing timeline cells. The fix does not recolor it or add an overlay.

The adapter now uses native `reloadDataWrap` for policy refresh, keeps native reload rendering inside the same scoped projection, and completes pending table/footer layout on first appearance and native layout completion. Reentrancy is bounded by per-page state. The table frame, content offset, colors, native footer object, service data and native scroll events are not assigned or simulated by the adapter. Unloaded controllers defer work to appearance; stale account pages cannot receive the new reconciliation.

`Tests/verify-close-friend-social.sh` runs actual production lifecycle registration and model projection bodies. A deliberately deferred table render stays unpainted after a bare reload; appearance must fill it using the current reveal/relock projection. The fixture also checks footer/offset preservation, native reload after an incoming data update, unloaded/stale pages and disabled bypass. It does not simulate UIKit/CoreAnimation and therefore does not prove the device's visual result.
