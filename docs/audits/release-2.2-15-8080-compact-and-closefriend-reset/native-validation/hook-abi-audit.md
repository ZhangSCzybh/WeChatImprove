# 8.0.80 message hook ABI audit

Encodings include implicit self/_cmd. Explicit argument counts are shown separately. UIKit superclass declarations are marked separately. These results establish static ABI eligibility, not a hook installation inside the user's process.

| Source | Hook class | Selector | Return / explicit argc | Hook ABI | Native owner / encoding | IMP | Result |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `Hooks/MessageMergeHooks.xm:13` | BaseMsgContentViewController | `viewDidLoad` | `v` / 0 | `v@:` | BaseMsgContentViewController / `v16@0:8` | `0x100355aa0` | MATCH |
| `Hooks/MessageMergeHooks.xm:14` | BaseMsgContentViewController | `viewWillAppear:` | `v` / 1 | `v@:B` | BaseMsgContentViewController / `v20@0:8B16` | `0x10034a5c8` | MATCH |
| `Hooks/MessageMergeHooks.xm:15` | BaseMsgContentViewController | `viewDidDisappear:` | `v` / 1 | `v@:B` | BaseMsgContentViewController / `v20@0:8B16` | `0x10034d0fc` | MATCH |
| `Hooks/MessageMergeHooks.xm:16` | BaseMsgContentViewController | `tableView:heightForRowAtIndexPath:` | `d` / 2 | `d@:@@` | BaseMsgContentViewController / `d32@0:8@16@24` | `0x100335424` | MATCH |
| `Hooks/MessageMergeHooks.xm:21` | BaseMsgContentViewController | `tableView:cellForRowAtIndexPath:` | `@` / 2 | `@@:@@` | BaseMsgContentViewController / `@32@0:8@16@24` | `0x100335588` | MATCH |
| `Hooks/MessageMergeHooks.xm:28` | BaseMsgContentViewController | `tableView:willDisplayCell:forRowAtIndexPath:` | `v` / 3 | `v@:@@@` | BaseMsgContentViewController / `v40@0:8@16@24@32` | `0x100336580` | MATCH |
| `Hooks/MessageMergeHooks.xm:32` | BaseMsgContentViewController | `scrollViewDidEndDragging:willDecelerate:` | `v` / 2 | `v@:@B` | BaseMsgContentViewController / `v28@0:8@16B24` | `0x1003389d0` | MATCH |
| `Hooks/MessageMergeHooks.xm:35` | BaseMsgContentViewController | `scrollViewWillBeginDragging:` | `v` / 1 | `v@:@` | BaseMsgContentViewController / `v24@0:8@16` | `0x100338618` | MATCH |
| `Hooks/MessageMergeHooks.xm:36` | BaseMsgContentViewController | `scrollViewDidEndScrollingAnimation:` | `v` / 1 | `v@:@` | BaseMsgContentViewController / `v24@0:8@16` | `0x100339670` | MATCH |
| `Hooks/MessageMergeHooks.xm:37` | BaseMsgContentViewController | `mmTableViewDidFinishedLoading:` | `v` / 1 | `v@:@` | BaseMsgContentViewController / `v24@0:8@16` | `0x1003353cc` | MATCH |
| `Hooks/MessageMergeHooks.xm:38` | BaseMsgContentViewController | `onLoadMessageFail` | `v` / 0 | `v@:` | BaseMsgContentViewController / `v16@0:8` | `0x10032dc94` | MATCH |
| `Hooks/MessageMergeHooks.xm:39` | BaseMsgContentViewController | `scrollViewDidEndDecelerating:` | `v` / 1 | `v@:@` | BaseMsgContentViewController / `v24@0:8@16` | `0x100338d30` | MATCH |
| `Hooks/MessageMergeHooks.xm:40` | BaseMsgContentViewController | `MenuControllerWillHide:` | `v` / 1 | `v@:@` | BaseMsgContentViewController / `v24@0:8@16` | `0x100355874` | MATCH |
| `Hooks/MessageMergeHooks.xm:45` | BaseMsgContentViewController | `viewDidAppear:` | `v` / 1 | `v@:B` | BaseMsgContentViewController / `v20@0:8B16` | `0x10034b854` | MATCH |
| `Hooks/MessageMergeHooks.xm:46` | BaseMsgContentViewController | `viewDidLayoutSubviews` | `v` / 0 | `v@:` | BaseMsgContentViewController / `v16@0:8` | `0x100333ed4` | MATCH |
| `Hooks/MessageMergeHooks.xm:47` | BaseMsgContentViewController | `addMessageNode:layout:addMoreMsg:` | `v` / 3 | `v@:@BB` | None / `None` | `None` | ABSENT_IN_IMAGE |
| `Hooks/MessageMergeHooks.xm:50` | BaseMsgContentViewController | `addMessageNode:addMoreMsg:` | `v` / 2 | `v@:@B` | None / `None` | `None` | ABSENT_IN_IMAGE |
| `Hooks/MessageMergeHooks.xm:53` | BaseMsgContentViewController | `addChatViewModel:addMoreMsg:` | `v` / 2 | `v@:@B` | BaseMsgContentViewController / `v28@0:8@16B24` | `0x10032a888` | MATCH |
| `Hooks/MessageMergeHooks.xm:56` | BaseMsgContentViewController | `replaceMessageNode:withMessageNodeList:` | `v` / 2 | `v@:@@` | BaseMsgContentViewController / `v32@0:8@16@24` | `0x10032cb4c` | MATCH |
| `Hooks/MessageMergeHooks.xm:59` | BaseMsgContentViewController | `removeObjectsFromMessageNodeDatas:` | `v` / 1 | `v@:@` | BaseMsgContentViewController / `v24@0:8@16` | `0x1002ffbf8` | MATCH |
| `Hooks/MessageMergeHooks.xm:62` | BaseMsgContentViewController | `deleteNode:` | `v` / 1 | `v@:@` | BaseMsgContentViewController / `v24@0:8@16` | `0x100325fd8` | MATCH |
| `Hooks/MessageMergeHooks.xm:65` | BaseMsgContentViewController | `deleteNode:withDB:animated:` | `v` / 3 | `v@:@BB` | BaseMsgContentViewController / `v32@0:8@16B24B28` | `0x1003058a4` | MATCH |
| `Hooks/MessageMergeHooks.xm:68` | BaseMsgContentViewController | `removeAllObjectsFromMessageNodeDatas` | `v` / 0 | `v@:` | BaseMsgContentViewController / `v16@0:8` | `0x1002ffbe0` | MATCH |
| `Hooks/MessageMergeHooks.xm:71` | BaseMsgContentViewController | `reloadMessagesInternal` | `v` / 0 | `v@:` | BaseMsgContentViewController / `v16@0:8` | `0x10033f208` | MATCH |
| `Hooks/MessageMergeHooks.xm:75` | BaseMsgContentViewController | `reloadTableData` | `v` / 0 | `v@:` | BaseMsgContentViewController / `v16@0:8` | `0x10033f184` | MATCH |
| `Hooks/MessageMergeHooks.xm:78` | BaseMsgContentViewController | `reloadNodeWithMessageWrap:` | `v` / 1 | `v@:@` | BaseMsgContentViewController / `v24@0:8@16` | `0x1002ffc10` | MATCH |
| `Hooks/MessageMergeHooks.xm:82` | BaseMsgContentViewController | `reloadNodeWithMessageWrap:WithTryScroll:ReloadAll:` | `v` / 3 | `v@:@BB` | BaseMsgContentViewController / `v32@0:8@16B24B28` | `0x1002ffc24` | MATCH |
| `Hooks/MessageMergeHooks.xm:86` | BaseMsgContentViewController | `clearNodeLayoutCache` | `v` / 0 | `v@:` | BaseMsgContentViewController / `v16@0:8` | `0x100303524` | MATCH |
| `Hooks/MessageMergeHooks.xm:93` | CommonMessageViewModel | `isShowChatRoomDisplayName` | `B` / 0 | `B@:` | CommonMessageViewModel / `B16@0:8` | `0x10104ca4c` | MATCH |
| `Hooks/MessageMergeHooks.xm:101` | BaseMessageViewModel | `resetLayoutCache` | `v` / 0 | `v@:` | BaseMessageViewModel / `v16@0:8` | `0x1002c0cec` | MATCH |
| `Hooks/BubbleStyleHooks.xm:8` | CommonMessageCellView | `initWithViewModel:` | `@` / 1 | `@@:@` | CommonMessageCellView / `@24@0:8@16` | `0x101034d20` | MATCH |
| `Hooks/BubbleStyleHooks.xm:13` | CommonMessageCellView | `setViewModel:` | `v` / 1 | `v@:@` | CommonMessageCellView / `v24@0:8@16` | `0x101034d7c` | MATCH |
| `Hooks/BubbleStyleHooks.xm:18` | CommonMessageCellView | `prepareForReuse` | `v` / 0 | `v@:` | CommonMessageCellView / `v16@0:8` | `0x101035528` | MATCH |
| `Hooks/BubbleStyleHooks.xm:22` | CommonMessageCellView | `layoutSubviews` | `v` / 0 | `v@:` | CommonMessageCellView / `v16@0:8` | `0x101035af0` | MATCH |
| `Hooks/BubbleStyleHooks.xm:26` | CommonMessageCellView | `updateBgImageView:` | `v` / 1 | `v@:B` | CommonMessageCellView / `v20@0:8B16` | `0x101048b30` | MATCH |
| `Hooks/BubbleStyleHooks.xm:30` | CommonMessageCellView | `traitCollectionDidChange:` | `v` / 1 | `v@:@` | CommonMessageCellView / `v24@0:8@16` | `0x101042b84` | MATCH |
| `Hooks/BubbleStyleHooks.xm:34` | CommonMessageCellView | `onExtChatBackgroundChanged:` | `v` / 1 | `v@:@` | CommonMessageCellView / `v24@0:8@16` | `0x1010488d0` | MATCH |
| `Hooks/BubbleStyleHooks.xm:38` | CommonMessageCellView | `onAppear` | `v` / 0 | `v@:` | CommonMessageCellView / `v16@0:8` | `0x101037ec0` | MATCH |
| `Hooks/BubbleStyleHooks.xm:47` | VoIPBubbleMessageCellView | `layoutContentView` | `v` / 0 | `v@:` | VoIPBubbleMessageCellView / `v16@0:8` | `0x10638fb74` | MATCH |
| `Hooks/BubbleStyleHooks.xm:48` | VoIPBubbleMessageCellView | `updateStatus` | `v` / 0 | `v@:` | VoIPBubbleMessageCellView / `v16@0:8` | `0x106390688` | MATCH |
| `Hooks/BubbleStyleHooks.xm:52` | TextMessageCellView | `layoutContentView` | `v` / 0 | `v@:` | TextMessageCellView / `v16@0:8` | `0x105ef88a4` | MATCH |
| `Hooks/BubbleStyleHooks.xm:53` | TextMessageCellView | `updateStatus` | `v` / 0 | `v@:` | TextMessageCellView / `v16@0:8` | `0x105efccbc` | MATCH |
| `Hooks/BubbleStyleHooks.xm:57` | VoiceMessageCellView | `layoutContentView` | `v` / 0 | `v@:` | VoiceMessageCellView / `v16@0:8` | `0x106571e5c` | MATCH |
| `Hooks/BubbleStyleHooks.xm:58` | VoiceMessageCellView | `updateSecLabelColor` | `v` / 0 | `v@:` | VoiceMessageCellView / `v16@0:8` | `0x106581b08` | MATCH |
| `Hooks/BubbleStyleHooks.xm:62` | RichTextView | `setOTextColor:` | `v` / 1 | `v@:@` | RichTextView / `v24@0:8@16` | `0x1058a3b04` | MATCH |
| `Hooks/BubbleStyleHooks.xm:66` | VoIPSignalMessageCellView | `layoutContentView` | `v` / 0 | `v@:` | VoIPSignalMessageCellView / `v16@0:8` | `0x1064fa36c` | MATCH |
| `Hooks/BubbleStyleHooks.xm:67` | VoIPSignalMessageCellView | `updateStatus` | `v` / 0 | `v@:` | VoIPSignalMessageCellView / `v16@0:8` | `0x1064faec8` | MATCH |
| `Hooks/BubbleStyleHooks.xm:73` | YYAsyncImageView | `setImage:` | `v` / 1 | `v@:@` | YYAsyncImageView / `v24@0:8@16` | `0x10ae81040` | MATCH |
| `Hooks/BubbleStyleHooks.xm:76` | YYAsyncImageView | `setHighlightedImage:` | `v` / 1 | `v@:@` | YYAsyncImageView / `v24@0:8@16` | `0x10ae8118c` | MATCH |
| `Hooks/BubbleStyleHooks.xm:79` | YYAsyncImageView | `newAsyncDisplayTask` | `@` / 0 | `@@:` | YYAsyncImageView / `@16@0:8` | `0x10ae813f8` | MATCH |
| `Hooks/BubbleStyleHooks.xm:88` | YYImage | `decodeImage` | `@` / 0 | `@@:` | YYImage / `@16@0:8` | `0x10ae835f0` | MATCH |
| `Hooks/MessageGestureHooks.xm:12` | CommonMessageCellView | `initWithViewModel:` | `@` / 1 | `@@:@` | CommonMessageCellView / `@24@0:8@16` | `0x101034d20` | MATCH |
| `Hooks/MessageGestureHooks.xm:13` | CommonMessageCellView | `setViewModel:` | `v` / 1 | `v@:@` | CommonMessageCellView / `v24@0:8@16` | `0x101034d7c` | MATCH |
| `Hooks/MessageGestureHooks.xm:14` | CommonMessageCellView | `prepareForReuse` | `v` / 0 | `v@:` | CommonMessageCellView / `v16@0:8` | `0x101035528` | MATCH |
| `Hooks/MessageGestureHooks.xm:15` | CommonMessageCellView | `layoutSubviews` | `v` / 0 | `v@:` | CommonMessageCellView / `v16@0:8` | `0x101035af0` | MATCH |
| `Hooks/MessageGestureHooks.xm:16` | CommonMessageCellView | `updateNodeStatus` | `v` / 0 | `v@:` | CommonMessageCellView / `v16@0:8` | `0x1010381ac` | MATCH |
| `Hooks/MessageGestureHooks.xm:17` | CommonMessageCellView | `onAppear` | `v` / 0 | `v@:` | CommonMessageCellView / `v16@0:8` | `0x101037ec0` | MATCH |
| `Hooks/MessageGestureHooks.xm:18` | CommonMessageCellView | `onDisappear` | `v` / 0 | `v@:` | CommonMessageCellView / `v16@0:8` | `0x101038138` | MATCH |
| `Hooks/MessageGestureHooks.xm:19` | CommonMessageCellView | `didMoveToWindow` | `v` / 0 | `v@:` | UIKit declaration UIView / `v@:` | `None` | MATCH |
| `Hooks/MessageGestureHooks.xm:24` | VoiceMessageCellView | `setViewModel:` | `v` / 1 | `v@:@` | CommonMessageCellView / `v24@0:8@16` | `0x101034d7c` | MATCH |
| `Hooks/MessageGestureHooks.xm:25` | VoiceMessageCellView | `prepareForReuse` | `v` / 0 | `v@:` | VoiceMessageCellView / `v16@0:8` | `0x106573424` | MATCH |
| `Hooks/MessageGestureHooks.xm:26` | VoiceMessageCellView | `layoutSubviews` | `v` / 0 | `v@:` | CommonMessageCellView / `v16@0:8` | `0x101035af0` | MATCH |
| `Hooks/MessageGestureHooks.xm:30` | MMContextManager | `logout:` | `v` / 1 | `v@:@` | MMContextManager / `v24@0:8@16` | `0x11610bf40` | MATCH |
| `Hooks/MessageGestureHooks.xm:35` | MMContextManager | `loginByContext:` | `v` / 1 | `v@:@` | MMContextManager / `v24@0:8@16` | `0x11610bc64` | MATCH |
