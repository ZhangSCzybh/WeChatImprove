# WeChat sticker repeat menu: native evidence

Scope: the user clarified that independent large stickers, sticker packs, and custom animated stickers have **no repeat menu item**. This is a menu admission investigation, not a send-failure investigation. Source baseline was `2c343db2` on `codex/message-actions-refactor-1.7-17`; the working tree is being updated separately by the parent task.

Target identity: `/private/tmp/wechat-8.0.78-inset-analysis/WeChat`, arm64 Mach-O, SHA-256 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`, the previously selected WeChat 8.0.78.34 sample. REA `open_binary` confirmed the same identity; the owned session was closed after investigation. No deep provider or target process was launched. Focused Objective-C metadata and `xcrun llvm-objdump` analysis reused the repository's existing read-only parsers. These local assembly/metadata files are shipped-artifact observations; no REA deep-analysis Evidence ID is fabricated for them.

## Findings and limits

1. **Proven structural omission: the plugin's controller resolver ignores a concrete native controller accessor present on both sticker cells.** In the baseline `CSMessageNativeEnvironment.controllerForCell:`, only a bounded `nextResponder` walk is attempted. `CSMessageActionCoordinator.validateContext:` requires a non-nil `context.controller`, so a legitimate sticker cell with a native delegate/controller association but no chat controller in its current responder chain loses menu admission. Static evidence proves the accessor and the implementation omission; it does not prove the user's phone used that exact responder arrangement.
2. **No evidence of a new large-sticker builder bypassing the current hooks in this sample.** `EmoticonMessageCellView` and `AppEmoticonMessageCellView` both derive from `CommonMessageCellView`. Both independently implement `operationMenuItems`; both are already explicitly hooked by baseline `RepeatHooks.xm`. Their `onLongTouch` methods delegate to the superclass. Their view models inherit the concrete `messageWrap` getter that the plugin already uses.
3. **The normal native menu pipeline dynamically invokes the sticker-specific builder.** No global menu injection or post-filter reinsertion is justified by this finding. Preserve the existing concrete hooks, per-action menu IDs, and native restrictions.
4. **The send adapter is not part of this reported failure.** `m_nsEmoticonMD5` capitalization is confirmed by native code; `AddEmoticonMsg:MsgWrap:` requires type 47 and a nonempty MD5, but none of these send operations runs while deciding whether to show repeat. Do not label a possible send-layer concern the cause of this missing menu.

## Exact native receiver and ABI

| Receiver and method | Address | Encoding | Observed behavior |
|---|---|---|---|
| `EmoticonMessageCellView -getViewController` | `0x10152fa70` | `@16@0:8` | Loads the weak delegate at ivar-offset field `0x1201df218`, sends it `getViewController`, and returns that result. |
| `AppEmoticonMessageCellView -getViewController` | `0x1000c7eec` | `@16@0:8` | Same delegate-backed behavior. |
| `BaseChatCellView -delegate` | `0x10029cf44` | `@16@0:8` | Loads the same weak delegate field; metadata names it `m_delegate` and types it `id<MessageNodeViewDelegate>`. |
| `BaseMsgContentViewController -getViewController` | `0x1002f53dc` | `@16@0:8` | A single `ret`; returns self in x0. |
| `BaseChatCellView -viewModel` | `0x10029cf78` | `@16@0:8` | Loads `m_viewModel`. |
| `BaseMessageViewModel -messageWrap` | `0x1002b1a44` | `@16@0:8` | Loads the `m_messageWrap` field directly. |
| `EmoticonMessageCellView -operationMenuItems` | `0x10152e064` | `@16@0:8` | Builds a native sticker menu; obtains the source via `self.viewModel.messageWrap`. |
| `AppEmoticonMessageCellView -operationMenuItems` | `0x1000c6d34` | `@16@0:8` | Independent app-sticker builder. |
| `EmoticonMessageCellView -onLongTouch` | `0x10152ee9c` | `v16@0:8` | Reports the source message, then invokes superclass `onLongTouch`. |
| `AppEmoticonMessageCellView -onLongTouch` | `0x1000c7e48` | `v16@0:8` | Same superclass handoff after reporting. |

The plugin should invoke `cell.getViewController` using its existing concrete-method/object-return ABI check, accept only a `BaseMsgContentViewController` instance (including subclasses), and retain the bounded responder walk as fallback. It should not traverse arbitrary delegate objects or accept any NSObject/UI controller merely because it has a similarly named method. Returning an unrelated object, returning nil, throwing, or exposing the wrong ABI must retain the fallback behavior. The source message/account/binding validation remains required.

Source getter chain is already covered: `EmoticonMessageViewModel` and `AppEmoticonMessageViewModel` -> `CommonMessageViewModel` -> `BaseMessageViewModel`. The parent source resolver's `viewModel.messageWrap` path correctly reaches this concrete inherited getter. No additional KVC or arbitrary forwarding is needed.

## Native menu order and restrictions

Reuse the existing bounded artifacts under `../../message-actions-1.8-2/native-menu-text-v2/`:

- `BaseMessageCellView--generateOperationMenu.asm`: at `0x1002a219c`, record detail routes to its own restricted builder; at `0x1002a220c`, unsafe chat messages take restore/delete handling. The normal path at `0x1002a229c` sends **self** `operationMenuItems`, then appends its returned items. The later call at `0x1002a2b74` is `+[CBTAskXiaoWeiMenuMutexHelper removeMutexMenuItemsIfNeeded:]`; class identity was resolved from the class reference at `0x120176198`. This investigation does not claim complete semantics for that helper.
- `BaseMessageCellView--showOperationMenu.asm`: `generateOperationMenu` -> `uniqMenuItems:` -> `filteredMenuItems:` (`0x1002a4ce4`–`0x1002a4d34`) precedes the native display handoff.
- `BaseMessageCellView--uniqMenuItems_.asm`: deduplication is by numeric `menuType`. The baseline already gives repeat and voice-forward distinct positive IDs and checks collisions.
- `BaseMessageCellView--filteredMenuItems_.asm`: ordinary iPhone processing preserves unknown menu IDs; bypass-user/title whitelist, WeClaw/title blacklist, only-delete, and VisionPro restrictions remain native responsibilities. See the earlier `report.md` for exact bounded branches.
- `SessionMenuAdjuester--adjustCustomMenuItems_.asm`: moves named native menu IDs while preserving unknown IDs in the inspected method.

This is a version-specific menu pipeline, not evidence of what any installed phone build or another plugin actually executed. Preserve it; do not append items globally after filtering.

## Message type and unrelated send findings

The existing `../../message-actions-native-2026-10-17/ordinary--ForwardMsgUtil--emojiMsgFromMsgWrap_.asm` shows the native factory allocates `CMessageWrap` with type 47 (`0x101c4d8f0`), copies sticker payload fields, and calls `SetGameContentForMsgWrap:`. The existing `ordinary--CMessageMgr--AddEmoticonMsg_MsgWrap_.asm` reads `m_nsEmoticonMD5` at `0x104b396c4`, rejects empty content and non-47 types before insertion, and owns upload after insertion. This substantiates type 47's native sticker route; it does not diagnose menu absence. App-emoticon wrappers may follow an app-message route, so do not relabel every sticker cell as necessarily type 47 solely from the class name.

Unicode emoji and WeChat inline face tokens in a type 1 text message are handled by the text route; the user explicitly excluded that case. The user subsequently also reported missing repeat menus for dice/rock-paper-scissors. `GameMessageCellView` derives from `CommonMessageCellView` and independently implements `operationMenuItems` at `0x101e12948` (`@16@0:8`). The retained disassembly builds its own mutable array, adds `forwardMenuItem`, then `addRevokeOrDeleteMenuItem:`, and returns without invoking the superclass builder. Baseline `RepeatHooks.xm` does not hook this class. An explicit builder/canPerformAction hook is therefore included in this release, before the unchanged native uniq/filter stages.

Game sends continue through the existing type-47 independent-copy -> `AddEmoticonMsg:MsgWrap:` route. The plugin does not introduce a call to the factory's `SetGameContentForMsgWrap:` or recompute a random result. Host tests verify the game type, content and MD5 passed to the native boundary and source preservation. Existing `GameCheatsHook.xm` still owns the optional result-selection UI when the user enables game assistance. Neither the host test nor this bounded disassembly proves the final recipient animation/result.

## Verification guidance

Use the real `CSMessageNativeEnvironment` in a fixture with a sticker cell's concrete `getViewController` backed by a native-style delegate, a valid `BaseMsgContentViewController`, and a responder chain that does not reach it. Baseline controller capture must fail and the fixed capture/menu admission must succeed. Also exercise invalid object/wrong ABI/throwing accessors and responder fallback. Existing account/message-binding tests remain relevant. This fixture proves the structural omission is repaired; on-device verification still needs to confirm the actual installed build and the user's original large-sticker menu.

Investigation checklist: native sticker controller accessor **answered**; two known sticker builder dispatch **answered**; source-wrap accessor **answered**; bounded additional class/category search **answered**; exact phone runtime cause and post-install workflow **unobserved**. No production source, existing evidence, package, database, account, or phone state was changed by this investigation.
