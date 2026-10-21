# 发现页朋友圈互动未读角标

本次只读核验使用本地微信 8.0.78 可执行文件 `/tmp/wechat-8.0.78-inset-analysis/WeChat`，SHA-256 为 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`。方法类型来自实际 Mach-O Objective-C 元数据，调用路径来自有边界的离线反汇编；没有在手机上执行、写库、删除消息或标记已读。

## 根因

`FindFriendEntryViewController -tableView:cellForRowAtIndexPath:` 在 `0x101b48954` 调用 **`getSnsMessageCount`**，随后在 `0x101b48978` 将该数值转成原生角标字符串，并交给 `makeEntryCell:rowType:`。真实方法类型为 `q16@0:8`。

旧实现只拦截 `numberOfUnreadAtMomentCell` 和 `badgeAtMomentCell`。前者在 `numberOfUnreadAtTab` 的 `0x101b4ea68` 用于发现页 Tab 的聚合计数，后者处理动态提示红点；都不能代替朋友圈行的 `getSnsMessageCount`。此外 `updateWCTimeLineView:` 中的头像/小红点视图不包含这个数字角标，因此只隐藏这些视图不会消除截图里的红色数字。

## 保留原生未读分区

`getSnsMessageCount`（`0x101b4849c`）和 `numberOfUnreadAtMomentCell`（`0x101b4f1d8`）按原生 `isMutualFriendsInteractionReminderEnabled` 开关，在 `WCFacade getUnReadMessageCount` 与 `getUnReadMessageCountReleatedToMe` 之间选择。两个 Facade 方法及 MutualFriends 方法均为 `I16@0:8`。

实现保留这两个页面方法的原生调用，仅在调用期间打开发现页计数作用域。作用域内从完整原生未读数组识别密友互动，在**相同分区**中从原生计数减去这些互动。普通好友的提醒及其他发现页入口的计数不因此清零。

分区规则可由以下 native 路径交叉核对：

- `MyWCDB addNewRawMessage:hasRead:` 在 `0x104ff97bc` 调用 `isMessageRelatedToMe:`，随后把 false/true 映射为 `m_messgaeRelevanceType` 的 1/2。
- `getUnReadMessageCountReleatedToMe` / `getUnReadMessageCountForMutualFriends` 查询未读记录中 relevance 2/1。
- `isMessageRelatedToMe:` 是三个原生判定的或：当前 action type 为 4；引用互动作者为 `SettingUtil getCurUsrName`；或当前 action commentFlag 的 bit 17 为 1。
- `WCMessageFromDBMessage:` 把 `m_type`、`m_commentFlag` 和 `m_ref` 还原到 `WCUserComment.type`、`WCUserComment.commentFlag` 和 `WCSNSMessage.refComment`。因此展示计数可以利用现有未读模型恢复相同分类，不向数据库构造新查询或更新原生字段。
- 当前二进制的 `WCUserComment.type` 与 `commentFlag` 都为 `i16@0:8`。生产代码在调用前校验签名。遇到无法分类的隐藏消息时，相关分区计数保守返回 0；正常模型路径保留普通好友计数。

`NativeUnread` 调用的是未过滤的原生 `WCFacade getUnReadMessages`。这条原生路径可能自校正通知管理器的**原始总未读缓存**；本实现从不把过滤后的数组或数字交给通知管理器、mark-read 或删除路径。

## 已有页面刷新

`onMessageUnReadCountChanged`（`0x101b5f9a8`）原生实现刷新 `m_WCTimeLineIndexPath` 所在行，并调用 `updateTabBarBadge` 重算聚合计数，没有消息已读/删除动作。锁定/解锁策略变化和 `viewWillAppear:` 使用该方法刷新已缓存的角标。页面原生未读变化仍沿用原回调。失效的账号页面不读取当前账号未读列表。

## 定向验证

`bash Tests/verify-close-friend-discovery.sh` 编译并安装实际生产计数、Facade 与生命周期 Hook，验证：

- 实际行入口 `getSnsMessageCount` 与 Tab 入口都去除密友互动。
- 开启/关闭共同好友互动提醒时，普通好友在正确分区中的计数保留。
- type 4、自己动态 flag、回复自己的评论三种 related 类型均正确归类。
- 密友互动独占时朋友圈计数归零，其他发现页入口的测试计数仍保留。
- 页面重新出现、策略锁定/解锁、原生未读更新均刷新旧角标。
- 全局 Facade 调用、原生数组和 `hasRead` 不变；失效账号页面返回 0。

Host 定向验证通过。该证据不等于已经完成真机视觉验收；需要复验截图中的朋友圈行数字，以及混合普通好友互动时保留正常提醒。
