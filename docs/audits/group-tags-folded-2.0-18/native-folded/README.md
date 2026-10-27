# Folded chat grouping: native evidence and presentation boundary

Read-only inspection of `/tmp/wechat-8.0.78-inset-analysis/WeChat`, WeChat 8.0.78
arm64, SHA-256
`0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`.
The root task first opened this target with REA. REA's native dispatch metadata
snapshot rejected the artifact under its 64 MiB snapshot budget. The new scripts
here reuse only the repository's mmap parser prefix and invoke bounded
`xcrun llvm-objdump` ranges. They do not execute WeChat or modify older evidence.
`methods.json` records exact method addresses and Objective-C encodings;
`manifest.json` records bounded function ranges and file hashes. Inline selector,
class and CFString comments are static metadata annotations, not runtime traces.

## Aggregate construction and unread semantics

`-[ChatBoxMgr updateChatBoxSessionWithSortTime:]`, `0x100e48aec`:

- `0x100e48b90`–`0x100e48ba0`: reads `CContactMgr.getContactByName:` using
  the actual CFString `chatroom_session_box` at `0x11e4b0ea8`.
- `0x100e48bd4`–`0x100e48bf0`: creates an `MMSessionInfo` and assigns that contact.
- `0x100e48d60`–`0x100e48d90`: calls `lastMsgForChatBoxSession` and assigns
  its message to the aggregate session's `m_msgWrap`.
- `0x100e48da0`–`0x100e48dac`: sets `m_bShowUnReadAsRedDot` to true.
- `0x100e48e80`–`0x100e48e9c`: reads `isChatBoxSessionUnread` and assigns that
  BOOL to `m_uUnReadCount`. It is not the number of child sessions.
- `0x100e48ebc`–`0x100e48ef4`: obtains `MMNewSessionMgr` and calls
  `AddOrModifySession:withNotifyFlag:` with this aggregate session.

`updateChatBoxSessionDesc`, `0x100e49158`, updates the same aggregate source
message and notifies `updateCellContent:withContact:` through native cell data.
Earlier complete evidence in `../../close-friends-1.8-42/session-native/` proves
`isChatBoxSessionUnread` reads MMKV, while `chatBoxSessionCount` returns the
global `_chatBoxSessions.count`. These represent different concepts.

## Main entry click and the folded page

`-[NewMainFrameViewController handleSelectIndexPath:tableView:]`,
`0x10511feac`, gets the native session and dispatches to the
`openMessageContentView:...indexPath:` overload. The retained overloads lead to
`tryOpenMessageContentView:...firstUnreadMessageWrap:completion:`,
`0x10511deac`.

In the latter method:

- `0x10511e16c`–`0x10511e190` compares the session identity with the actual
  `chatroom_session_box` CFString and branches on the result.
- `0x10511e1b4` reports entry; `0x10511e1c0` creates
  `ChatBoxSessionListViewController`.
- `0x10511e248`–`0x10511e274` gets the navigation controller and calls
  `PushViewController:animated:completion:`. This branch also preserves native
  `lastEnterMainTabTime` and device-specific presentation behavior.

The separate `+[ChatBoxUtil pushChatBoxListFrom:complete:]`, `0x100e4c35c`, also
constructs that same folded controller, sets `hidesBottomBarWhenPushed`, and
calls `PushViewController:animated:completion:`. The main entry branch above
constructs the controller directly; it does not need to call `ChatBoxUtil`.
`+[ChatBoxUtil isChatBox:]` compares only with `chatroom_session_box`.

Existing complete folded-controller evidence proves its native count, cell and
selection callbacks use `ChatBoxMgr`; cell and selection access the manager
directly rather than exclusively using convenience logic getters. The current
table proxy must remain the common mapping owner.

## Name, preview and count presentation

`MainFrameCellData.makeTextForNameLabel` constructs the title from the contact
name or its native localized plugin/official name. `MainFrameItemView.updateNameLabel`
reads `m_textForNameLabel` and calls its label's `setText:` (`0x104a8ff8c` and
`0x104a8ffb0`). `MainFrameItemView.updateUnreadCountView` reads
`m_uUnReadCount` and `m_bShowUnReadAsRedDot` (`0x104a9bf44`, `0x104a9bf5c`).
The inspected ordinary ChatBox entry path does not establish a separate native
"number of folded sessions" label or any per-group count provider. In particular,
changing the aggregate unread field to a group membership count would corrupt
native unread semantics. The proposed N is a presentation count, independently
derived from visible folded children; it must not be stored in a native model.

## Feasibility conclusion and narrow plan

Presentation grouping is supported: retain native ChatBox membership and source
arrays, intersect the folded controller projection with the current account's
selected group, and use the same projected child set to decide whether the main
aggregate is present and how many visible conversations it represents.

Independent native fold/unfold state per group is not available in the inspected
manager: there is one `_chatBoxSessions` collection and one aggregate session.
Do not claim independent source folding. Follow the selected group when entering
the folded page; refresh if the current group changes through another live owner.

A neutral title plus count on the existing native cell is feasible without
changing native navigation or private label ivars. Extend the existing single
`CSCloseFriendSessionCover` presentation owner with an optional, verified folded
count. It already has `userInteractionEnabled=NO`, restores original child-hidden
and accessibility states on reuse, and is refreshed after native relayout.
Do not put a second independent cover above or below it.

The cover must activate when either grouping presentation or the existing privacy
condition requires it. It must conceal global preview, time and unread content
whenever showing a group-local summary, leave native row interaction intact, and
keep privacy dominant: never count hidden members, never show a precise count
from an unverified/old-account snapshot, and never remove the cover merely because
privacy was revealed while a scoped group summary is still needed. Updating the
single label must also update accessibility. Reuse with a non-ChatBox row must
restore all owned state as before.

This is a source/binary feasibility finding, not a claim of implementation or
device acceptance. Before implementation, add failing tests for filtered folded
rows, empty-group entry removal, count changes, native index mapping, hidden
members, policy/account invalidation, cover refresh/reuse and source immutability.
