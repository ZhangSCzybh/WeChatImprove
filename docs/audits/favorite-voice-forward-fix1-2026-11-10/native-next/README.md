# WeChat 8.0.80: Next-button timing and favorite long-press input

Evidence is from the user-supplied WeChat 8.0.80 IPA, using its extracted thin arm64 executable. The executable SHA-256 is `1d626426df97058a8a87c661532b2801cd27b7d9fcc12e27609c751f5877b7ed`. Addresses below are unslid VM addresses, image base `0x100000000`. This audit uses offline Objective-C metadata and targeted `llvm-objdump` disassembly. It does not run WeChat or send a message.

## Next reads a live selection only inside the native original

The shared `SessionSelectController` picker is used by ordinary message forwarding and the new favorite-voice forwarding adapter. Its default native creation in `ForwardMessageLogicController.showContactSelectViewController` loads the class reference at `0x11ed1bbf0` (resolved to `SessionSelectController`) and calls ordinary alloc/init at `0x101dbbbdc`. The relevant excerpt is saved as `ForwardMessageLogicController-showContactSelectViewController-picker-init-excerpt.asm`.

The default `SessionSelectController.init` at `0x105ae2d3c` does not initialize `m_selectedContacts`. That object ivar starts nil. The separate `initWithSelectedContacts:` and `initWithSelectedContacts:requiredContacts:` initializers copy supplied arrays into the ivar; they do not describe the ordinary forwarding picker. `viewDidLoad` preloads existing contacts only when their count is nonzero. `beginMultiSelect` and `cancelMultiSelect` toggle selection mode without collecting a snapshot.

The actual Next methods call `endMultiSelect`:

| Selector | IMP | Observed behavior |
| --- | --- | --- |
| `onMultiDone` | `0x105aea920` | Calls `endMultiSelect` at `0x105aea948`, then analytics |
| `onMultiDoneInPageSheetMode` | `0x105ae2914` | Tailcalls `endMultiSelect` |
| `endMultiSelect` | `0x105ae8dd4` | Collects current selection, then schedules `performCallback` |
| `getSelectedContacts` | `0x105ae6868` | Copies `m_selectedContacts`; it does not collect current selection |

The exact `endMultiSelect` ABI is `v16@0:8`: it has no explicit argument and no BOOL. Its relevant sequence is:

1. At `0x105ae8ec8`, read `m_selectedContacts` (object ivar, offset 128). If nil, allocate the mutable array at `0x105ae8ed0`–`0x105ae8eec`.
2. At `0x105ae8ef8`, remove all previously saved contacts.
3. At `0x105ae8f04`, read `m_selectView` (object ivar, offset 304); call its `m_dicMultiSelect` getter at `0x105ae8f10`.
4. At `0x105ae8f28`, call `allValuesInOrder` on that dictionary; append the resulting contacts at `0x105ae8f40`.
5. At `0x105ae8f64`–`0x105ae8f80`, schedule `performCallback` after approximately 0.1 seconds.

There is no alternate branch retaining a previous `m_selectedContacts` value if `m_selectView` is absent: the native path always clears and refills it. `SessionSelectView.m_dicMultiSelect` is declared `OrderedDictionary *`, not an NSArray. `OrderedDictionary` subclasses `NSMutableDictionary`; its `allValuesInOrder` method has ABI `@16@0:8`, IMP `0x11610d8c8`, and enumerates the stored key order to return values.

The previous privacy hook read `m_selectedContacts` before calling the native `onMultiDone` original, and called the original only when that ivar was already an NSArray. A normal picker with a nil snapshot was therefore silently stopped before native code could populate it. A stale nonnil snapshot also validated the wrong recipients. Substituting `getSelectedContacts` would preserve the same timing error. The preflight must read `m_selectView.m_dicMultiSelect.allValuesInOrder`, validate that current snapshot, and then let the native original collect it and callback.

This explains a shared Next-button failure in both ordinary-chat and favorite forwarding. It is static evidence of the blocked control flow; the final fix still needs real-device UI verification.

## Favorite long-press shape

`FavMultiMenuTableViewCell.forwardAction:` (`0x101ae06b4`) calls its delegate's `performAction:forRowAtIndexPath:`. The `MyFavoritesViewController` implementation (`0x1052a635c`) recognizes the `forwardAction:` selector, reads `indexPath.section`, calls `m_dataController.dataAtIndex:` at `0x1052a64f8`, puts that exact object into a one-element NSArray at `0x1052a6594`, and calls `forwardData:` at `0x1052a65b4`. It does not unwrap the data before `forwardData:`.

`FavBaseTableDataController.dataAtIndex:` (`0x101a4ee50`, ABI `@24@0:8q16`) chooses its source array as follows:

```text
if (m_arrFavDataWrap.count > 0)
    return m_arrFavDataWrap.safeObjectAtIndex(index);
return m_arrFavItem.safeObjectAtIndex(index);
```

The native `MyFavoritesViewController.forwardData:` (`0x10529ad14`) accepts both FavoritesItem objects and FavDataItemWrap objects. Its native fallback is consequently not proof that the new favorite-voice adapter captured the operation.

For the reviewed normal standalone voice routes, the list object is a raw FavoritesItem. `favSearchTypeMaskForItem:` (`0x101a2c408`) maps favorite type 3 to `1 << (3 - 1)`, or mask `0x4`. `presentFilteredItems:append:hasMoreData:` aggregates the `0x10`, `0x20`, and `0x80` categories into wrappers; `0x4` takes the raw-item path. Legacy `OnSearch:taskKey:` likewise takes `addFavItemList:` for `0x4`, while `addItemList:withAutoScrollToAddPositon:` adds raw favorite items. Thus wrapper bypass is a possible input shape supported by native code, but is not established as the cause of the reported ordinary voice long-press failure.

## Strict wrapper normalization

`FavDataItemWrap.parent` (`0x101a7682c`) and `.dataItem` (`0x101a76808`) both have ABI `@16@0:8`. They directly return `m_parent` (offset 16, declared FavoritesItem *) and `m_dataItem` (offset 8, declared FavoritesItemDataField *). `GetParent` and `GetDataItem` read the same respective ivars. The constructors retain the supplied objects without making a field copy, so a supplied child dataItem can be checked by object identity against its parent's sole validated voice field.

The field may legitimately be nil for a wrapper representing the entire parent item. Native `dataWrapAtIndex:` constructs `initWithParent:item DataItem:nil Index:0` when its backing array contains raw items. `FavSearchHelper.filterAndAggregateSearchResult:withSearchText:withSearchType:withTagList:` also constructs that whole-item form at `0x101b26a80`–`0x101b26a9c` for non-record items whose type is not 2. The constructor preserves the nil argument in `m_dataItem`; it does not replace it with the first field.

A bounded adapter normalization can therefore accept only the known FavDataItemWrap class, require its parent to pass the existing strict standalone type-3/sole voice-field validation, and require its dataItem to be either nil (whole parent) or the same object as that sole voice field. A mismatched nonnil child must be rejected. This keeps notes and saved chat-record children outside the supported scope.

## Evidence inventory and limits

`selected-metadata.json` contains full SessionSelectController, SessionSelectView, and OrderedDictionary class records. `favorite-entry-metadata.json` contains favorite cell/controller metadata. `favorite-data-shape-metadata.json` adds FavBaseTableDataController, FavBaseListViewController, FavoritesItem, FavDataItemWrap, and FavSearchHelper including the helper's class methods. Adjacent annotated ASM files correspond to the selectors discussed above; selector and ivar annotations are resolved from the same executable.

The common forward/selection/confirmation methods reviewed here did not show a blanket message-type-34 rejection for ordinary personal recipients. `onShouldSelectContact:` has type-34 cases within OpenIM contact/room compatibility checks. That observation is limited to the reviewed methods; this audit is not a claim that every native forwarding restriction has been removed. Favorite media duration conversion is investigated separately from this picker control-flow issue.
