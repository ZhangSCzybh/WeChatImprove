# Current native social evidence for Task 5

Read only static extraction, target SHA-256 0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e, retained WeChat 8.0.78 arm64 artifact. No runtime or real-account validation. Files in `social-native/`: `methods.json`, `ivars.json`, scripts and bounded function disassemblies. Root's committed extractor provenance is in `docs/evidence/close-friends-native-2026-10-20/README.md`.

## Timeline

- Actual superclass chain is WCTimeLineViewController → WCBaseTimelineViewController → MMUIViewController (old class-dump headers misleadingly say NSObject).
- WCTimeLineViewController `numberOfSectionsInTableView:` (`q@:@`, address 0x10a0becf0) calls WCFacade reloadTimelineDataItems, then countOfTimelineDataItem, builds its own C++ section-type mapping, adds live/story/unread/failure/other header sections and data item sections. Do not blindly subtract a fixed header count or assume table section equals item index.
- `getDataItemIndexForSection:` (`q@:q`, 0x10a0c9620) directly forwards to `calcDataItemIndex:`. `getNextDataItem:` (`@@:q`) is separate. Counts/height/cell/select/preload/scroll-to/visible list must agree.
- WCFacade has `getTimelineDataItem` (`@@:`), `countOfTimelineDataItem` (`q@:`), `getTimelineDataItemOfIndex:` (`@@:q`), but these are shared service/cache reads. Any interception must be tightly scoped to a rendering context or a per-controller projection; global filtered service data is forbidden by spec.
- WCDataItem has username, likeUsers/commentUsers object getters, and likeCount/commentCount/realLikeCount/realCommentCount/selfLikeCount/selfCommentCount as **i** returns (`i@:`). There is no own copyWithZone selector in this class's method table. Never assume `[item copy]` is supported; never mutate source arrays/counts. A proxy masquerading as native class is unsafe where native code directly accesses ivars.
- The native controller exposes cellHeightCache/cellShowItemCache through the base class. Policy changes must invalidate display caches; source/store data stays intact.
- WCTimeLineCellView initPrivacyButton: and onShowGroup remain candidates from committed method inventory. User chose global icon hiding even while temporarily revealed, gated by feature/option.

## Interaction messages

- WCCommentListViewController still has object ivars `_arrCommentList`, `_arrCommentListFromDB`, `_dicDataItems`, `_dicCells`, `_dicCellHeights` (typed metadata in ivars.json). `_arrCommentList` is a page-owned mutable array, not permission to mutate WCFacade/database source.
- `tableView:numberOfRowsInSection:` calls `getWCCommentListCount:` (`q@:q`, address 0x106ee738c); latter counts a page ivar. Legacy heads alone miss this newer boundary.
- Methods `addWCMessagesWithArray:MoreData:` (`v@:@B`), `addWCMessages:forListType:` (`v@:@q`), `getWCMessagesWithDataArray:` (`@@:@`), `updateArrSectionTitleType`, and `shouldShowMessagesByRelevance` exist. Keep pagination originals/cursors separate from display and avoid duplicate or lost source items when filtering/revealing.
- WCFacade exposes getUnReadMessages, getUnReadMessagesLimit: (`@@:i`), getUnReadMessageCount (`I@:`), getUnReadMessageCountForMutualFriends / getUnReadMessageCountReleatedToMe, getLastUnReadMessage and getMessageFrom:maxCount: (`@@:@I`). Badge/head-avatar output needs same identity rules without synthetic read/delete operations.
- WCTimeLineViewController has `messageTipCount` (`q@:`), `hasUnReadMessage`, `onMessageUnReadCountChanged` and dynamic unread-message sections. Merely filtering the interaction list does not remove header badges/avatars.

## Status

- TextStateFriendSquareViewController `count` (`Q@:`) reads `usernameList.count`; `configureCardView:atIndex:` (`v@:@Q`) uses usernameList. This is the card provider, while the grid uses a different topic structure.
- `numberOfSectionsInCollectionView:` equals friendTopicList.count + topInfoCellCount. `collectionView:numberOfItemsInSection:` skips top-info sections, reads friendTopicList[section-topInfoCellCount], and then `topic.usernames.count` or folded-row bound. Filtering only usernameList leaves the grid revealing hidden members.
- Grid and card provider must share derived usernames and topic membership, but preserve top-info sections and folding. Actual `_friendTopicList`, `_usernameList`, `_usernameToTextStateListDict`, `_beginIndex`, `_unfoldTopicSet`, `_itemNumberPerRow` ivars confirmed; no fixed offsets should be embedded in production.
- `jumpToCardListForUsername:`, `indexPathForUsername:`, `onTextStateUpdateForUserName:` exist and need stale-policy/direct-route guards.
- TextStateDataSimpleProvider `count` returns a constant 1 in the inspected body; direct single-state routes need explicit identity checks. `textState`, `visable`, beginIndex and configureCardView:atIndex: exist. Card controller exposes dataProvider, beginIndex, currentIndexPath, reloadData and configureMultipleCardView:atIndex:.

## Moments ACL

- WCMomentsPrivacyViewController supports both legacy onMultiSelect... callbacks and newer handleMultiSelectContactReturn... callbacks; `onDone`, `updateWithSelectedContactSet:`, `contactNamesComponentsJoinedByComma:`, `openAddFromTag`, `canSelectPrivacySetting:` (`B@:q`) confirmed.
- Keep WCCommitPrivacySetting selectContacts/selectTags untouched. Require authentication before unsafe editing if preserving hidden members cannot be proved; never save filtered selection as actual ACL.

These are adaptation candidates and typed static observations. Exact native item classes/Swift topic implementations, live rendering/gesture paths, background/red-dot behavior and state transitions still require device acceptance. Implement concrete routes and report unavailable ones rather than treating a found selector as complete protection.

## Additional personal/detail and newer UI routes

Class inventory also contains WCListViewController, WCCommentDetailViewController and newer WCTimelineFlutterAlbumV2ViewController/WCTimelineFlutterDetailViewController/WCTimelineFlutterProfileViewController/WCTimelineFlutterViewController. This establishes class presence only, not active route choice or ABI. Task 5 should cover personal/detail native rendering contexts and inspect/gate unsupported newer routes rather than assume a WCTimeLineViewController hook covers every album/detail. Relevant legacy headers exist for WCListViewController and WCCommentDetailViewController.

## Copying clarification

WCDataItem superclass is an external bound NSObject import (LC_DYLD_CHAINED_FIXUPS import ordinal 8684, `_OBJC_CLASS_$_NSObject`; raw superclass pointer `0x80100000000021ec`). Its own `isCopyingEnabled` getter (0x106fe912c..0x106fe9150) checks `extFlag & 0x80`; that name is not evidence of NSCopying/model cloning. See social-native/clone-followup.json and WCDataItem--isCopyingEnabled.asm. No own copyWithZone exists in inspected metadata. Do not call copy on native posts merely because isCopyingEnabled is true.

## Presentation followup: real comment rows and stale like-layout cache

Separate `social-presentation-native/` has 1,582 methods/11 class metadata and 15 complete bounded functions. All are same read-only artifact; no target execution. `WCActionAreaVM` is the time/source/location/action area, `WCTimelineFooterViewModel` is merchant/share footer, and `WCCommentSectionViewModel` contains Finder comment methods; none should be assumed to own Moments likes/comments just from their names.

The useful verified display boundary is `WCTimeLineCommentCellView`:

- `+getCommentViewCountForDataItem:` (`Q@:@`, 0x10a09b444) returns `(likeCount>0 ? 1 : 0) + max(commentCount,0)`. Both source getters are **int i**, not NSInteger.
- `+getCommentIndexForDataItem:RowIndex:` (`q@:@q`, 0x10a09ad94) converts the displayed row using likeCount and validates against commentCount.
- `-getShowComment` (`@@:`, 0x10a09b81c) calls that class helper, then `mainDataItem.commentUsers.safeObjectAtIndex:`. It can be called on interaction after initial rendering, so only scoping initial cell creation is insufficient.
- `+getCellHeightForDataItem:RowIndex:pageContext:` (`d@:@q@`, 0x10a09a2a0) uses the same index helper, commentUsers, username and commentCount. Count, height, displayed comment and click need one policy snapshot.
- `+getNickNameForDataItem:` (`@@:@`, 0x10a099370) enumerates the **likeUsers getter**. `-initLikeContainer` obtains that name string and uses separate native style/height caches; it does not itself enumerate likes.
- `-setMainDataItem:` stores the real WCDataItem reference, recomputes totalCommentPicCount, invokes initView and initHasNewStoryArray. The view exposes `mainDataItem`, iRow, iSection. Keep actual native models intact; do not install an NSProxy that breaks native direct ivar reads.
- Main timeline table row count computes native section mapping, obtains raw WCFacade.getTimelineDataItemOfIndex:, then calls getCommentViewCountForDataItem: and adds extra native body/footer/ad rows. It cannot be replaced by simply returning filtered comment count; retain native surrounding row semantics.

**Cache trap:** WCFacade `layoutStylesOfLikeUserWithDataItem:width:isSpringStyle:` (`@@:@dB`) looks up a shared derived display-cache by the post **itemID**, width and spring mode. There is no privacy revision in that key. Its companion setter (`v@:@@dB`) and `likeUserHeightForWidth:withDataItem:isSpringStyle:` (`d@:d@B`) similarly use display caches. Changing getter arrays without invalidating these caches can leave old names/heights visible after relock.

`removeCachesOfLikeUserWithDataItemId:` (`v@:@`, 0x1071231c8) clears ordinary and spring like-height/style maps for that ID and removes the empty cache object. Inspected body does not delete a post/comment or mark it read; this is a derived-display-cache invalidation candidate, still requiring runtime signature/account/thread checks. Source `WCDataItem.likeUsers/commentUsers/counts` and the shared timeline source list must not be mutated. Bound any getter projection to known rendering/interaction contexts and invalidate source-derived display caches on policy changes; never leave a global filtered WCDataItem model API for background sync/business logic.

These observations establish concrete selectors and cache risk, not complete device route coverage. Personal/detail/Flutter routes and every gesture need either verified adaptation or an explicit protected route gate; do not infer them from the main timeline table.
