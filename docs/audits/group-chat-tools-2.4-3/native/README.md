# 群聊功能原生接口实现审计

目标为用户提供的 WeChat 8.0.80 IPA，程序版本 8.0.80.34。薄 arm64 Mach-O SHA-256：`1d626426df97058a8a87c661532b2801cd27b7d9fcc12e27609c751f5877b7ed`。本目录保存离线 Objective-C 元数据、定点反汇编和选择器注释；未执行微信，未触发真实群操作。原始扩展调查位于 `../../group-chat-design-2026-11-10/room-actions/`。

## 对象参数语义

Objective-C 的 `@` 只证明对象 ABI，不能证明对象是用户名字符串还是 CContact。以下实参结论均来自函数体或微信原生调用点。

| 接口 | 实参 | 函数体证据 |
|---|---|---|
| `+[CContact IsChatRoomContact:]` | 群 CContact | `0x10107491c` 将 x2 保存为 x19，`0x10107492c`/`0x101074934` 向该对象发送 `isChatroom`；原生批量引擎 `0x10038ea50` 传入已验证 CContact 的 x22。实现必须传 contact，不能传 roomID。 |
| `-[CContact getChatRoomMemberDisplayName:]` | 成员 CContact | `0x1010711c4` 向实参发送 `getRemark`，`0x101071220` 向实参发送 `m_nsUsrName`。 |
| `-[ChatRoomData getDislayNameForUserName:]` | 成员用户名字符串 | 上述 CContact 方法在 `0x101071238` 将成员 `m_nsUsrName` 的结果传给它；元数据返回对象。 |
| `-[CGroupMgr GetGroupMemberUserListByContact:]` | 群 CContact | `0x102039ce4`/`0x102039cec` 向实参发送 `m_nsChatRoomMemList`，再按分号拆分。 |
| `-[CGroupMgr GetEntireChatRoomMemberDetail:]` | 群 CContact | `0x1020414d0`~`0x1020414d8` 向实参发送 `m_nsUsrName`。 |
| `-[CGroupMgr ShowInContactBook:sync:]` | 群 roomID 字符串、BOOL | `0x10203a6fc` 保存原 x2 到 x19，`0x10203a770` 原样作为 `getContactByName:` 实参；随后对取出的 contact 调 `addContact:listType:opLog:callExt:`，后三项为 1/YES/YES。 |
| `-[CGroupMgr IsUsrInChatRoom:Usr:]` | 群 roomID、成员用户名字符串 | `0x10203a2bc` 将第一实参送 `getContactByName:`；后续对原生成员字符串列表逐一比较第二实参。 |
| `+[ChatRoomUtils openContactProfile:ofChatRoomContact:inViewController:delegate:searchScene:]` | 成员 CContact、群 CContact、来源 VC、delegate、Q | `ChatRoomInfoViewController.openContactInfo:` 直接调用；函数体 `0x100fd80b4` 验证第一实参 CContact 类，`0x100fd80c8` 查询 `isValid`，再设置原生联系人页。 |

`-[CContact isChatRoomDismissed]` 确为 `B16@0:8`（`0x101074b1c`），读取 ChatRoomDetail 的 `m_uiChatRoomStatus` bit1。`isChatRoomBlocked` 同为 `B16@0:8`（`0x101074b68`），读取 `m_uiChatRoomSpamStatus` bit0。因此 8.0.80 目标上两接口存在；其他版本若缺失，适配器停止自动操作而不推定群可用。

## 原生保存与退出结果

`ShowInContactBook:sync:` 的函数体没有使用输入 sync 参数。实现额外调用 `NewSyncService.NeedToSyncOplog`，与 `DelaySwitchSettingLogic.commitAllSwitchSetting` 的普通群同步路径一致，并回读 `isMMContact`。这证明本地原生保存状态；不声称获得服务端同步完成回执。

`BatchQuitChatRoomLogic.startWithRoomNames:clearHistory:` 返回 void；实现只将其视为开始处理，不视为退出成功。成功链为 `MessageReturn:Event:` 验证 eventID/CGI18448 → `handleBatchResponse:` 检查顶层结果 → `handleResultList:requestedRoomNames:` 验证每群标识、hasOutcome、请求归属和重复项 → 每群 outcome=0（`0x100390470` 的零分支）到 `0x100390504`~`0x100390510` 调 `reconcileSuccessfulRoom:` → `recordSuccessForRoom:` → `didSucceedRoom:`。这与仅创建/提交 CGI 的返回有明确区分。

原生成功路径会尝试本地 reconcile，但未将其 BOOL 失败传播为服务器失败；协调器在成功回调后额外检查成员状态，仍显示在群时记 unknown 并停止后续。成员查询的 false 本身从不产生 succeeded；只有当前 token/engine/账号 epoch 均匹配的原生逐群成功回调才能进入成功处理。对服务器已经成功、本地联系人缓存缺失的情形，仍存在本地查询无法独立证明缓存完整的限制；必须在真机验收中覆盖。

外层最多 20 群一批，120 秒超时记 unknown；原生引擎自带有限重试，外层不额外重发。停止只影响后续批次。账号/授权/恢复门禁丢失时取消所持原生引擎；已发出的网络请求不可撤回。公开结果按账号和 epoch 隔离。

## 验证

`Tests/verify-group-chat-quit.sh` 将当前生产协调器实现接入假原生服务，在 macOS Foundation 中运行。12 个场景覆盖 45 群拆分 20/20/5、预检、停止、网络未知、账号隔离、超时、缺失/非请求结果、双向回调冲突、提交前停止、ABI 缺失和通知同步重入。该测试不加载微信，也不访问真实账号、群聊或聊天记录。

静态证据和 host fixture 未证明服务器 CGI18448 在当前网络环境下的可用性、全部特殊群限制、OpenIM 批量支持或真机导航效果；批量退出仅开放普通 `@chatroom`。
