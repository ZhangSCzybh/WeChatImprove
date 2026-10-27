# 2.0-18 折叠会话分组：实现与核心回归

## 结论与边界

结论为**部分可行**：当前分组内的折叠列表、入口可见数量、空组隐藏、密友过滤均可在展示层实现；微信的折叠成员集合仍由 `ChatBoxMgr` 全局管理，不能据此宣称每组拥有独立的原生折叠/展开状态。

本次保留微信全局折叠状态。进入折叠页时读取当前账号已选分组；另一个列表 owner 切组时通知同账号折叠 owner，隐藏的页面只标脏，出现时再刷新。用户在原生界面折叠/取消折叠一个会话，对全局集合仍然生效。

入口显示 `折叠的聊天（N）`，N 是该组可见折叠会话数，已经应用同样的成员归属、排重和密友过滤规则。已验证为空时隐藏入口。读取失败、接口签名不匹配、重复身份或递归聚合等情况显示无数量的中性入口，不伪报 0。分组摘要不展示全局最后消息、时间或原生全局未读；分组 tab 的折叠未读提示由本组可见子会话产生，仅贡献红点，不把会话数量写成未读数字。

## 原生证据与点击链路

证据固定在 `native-folded/README.md` 和同目录反汇编。目标为 WeChat 8.0.78 arm64，SHA-256 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`。

- `ChatBoxMgr.updateChatBoxSessionWithSortTime:` 创建 `chatroom_session_box` 的 `MMSessionInfo`，最后消息来自全局 ChatBox，`m_uUnReadCount` 来自 `isChatBoxSessionUnread` BOOL，不是子会话数。
- 主列表 `handleSelectIndexPath:tableView:` → `openMessageContentView:` 各重载 → `tryOpenMessageContentView:`，ChatBox 分支构造 `ChatBoxSessionListViewController` 并 Push。
- 该分支没有调用 `selectCellForName:`，也未使用插件的 `performInNativePresentation:`；正常入口点击仅把展示坐标还原为原生坐标，不重写 `preferences.selectedTabID`。
- 其他显式原生导航即使临时进入 `nativePresentation`，该标志也是 adapter 的临时展示状态，不会保存 `preset_0` 覆盖用户选组。
- 折叠页原生 count、cell、selection 均直接使用 `ChatBoxMgr`，继续由现有 table proxy 统一转换坐标。`FoldedOpen` 原有 `CSCloseFriendShouldHideUserName` 和 `displayPath` 双重门禁保持不变。

## 修改范围

- `CSGroupNativeBridge`：增加只读折叠子会话快照；与主列表共用原有分类规则；拒绝无法验证的数据，不改写原生数组、session 或 unread 字段。
- `CSGroupProjection`：主入口使用子投影的组归属、计数和未读；折叠摘要携带账号和隐私版本，在行比较中覆盖同数量但来源版本变化的刷新。
- `CSGroupListAdapter`：折叠页面启用当前组选组过滤但不添加分组栏；主入口用同一投影规则；切组通知同账号折叠 owner。
- `CSCloseFriendSessionPresentation`：扩展现有单个 `CSCloseFriendSessionCover`，显示组内数量并隐藏全局摘要；未知/旧账号/旧隐私版本只显示中性标题，复用与还原视觉/辅助功能状态保持原约定。
- `SessionGroupHooks.xm`：仅更新范围注释，已有原生生命周期、folded open/privacy 钩子未改动。

## 失败证明与最终回归

先执行的旧实现测试在 `folded-red.log`：9 项中 6 项失败，覆盖强制 All、子页未过滤、映射不匹配、空组仍有入口、无组内数量及其他组未读污染。

补充两个 red→green 边界：

- `folded-revision-red.log`：41 项中 1 项失败，同数量但隐私版本更新未判为结构变化。已把摘要账号/版本纳入比较。
- `folded-lifecycle-red.log`：103 项中 1 项失败，另一个可见折叠 owner 未随主列表切组刷新。已增加同账号通知，并证明隐藏页面不因此执行额外发布。

最终只执行以下 6 个相关脚本，共 **1,186 项检查，0 失败**：

| 脚本 | 检查数 | 日志 |
| --- | ---: | --- |
| `verify-close-friend-session.sh` | 85 + 19 | `folded-session-green.log` |
| `verify-group-business.sh` | 633 | `folded-business-green.log` |
| `verify-group-incremental.sh` | 180 | `folded-incremental-green.log` |
| `verify-group-badges.sh` | 136 | `folded-badges-green.log` |
| `verify-group-lifecycle.sh` | 103 | `folded-lifecycle-green.log` |
| `verify-group-selection.sh` | 30 | `folded-selection-green.log` |

85 项会话测试包含 41 项新增折叠检查；19 项展示测试包含 11 项新增单层摘要覆盖/复用检查；103 项生命周期包含 5 项新增跨 owner 切组/账号隔离检查。这里的检查数为断言数量，不是测试脚本数量。

`folded-presentation-fixture-invalid-profile.log` 保留了中途测试替身把空 profile 当合法策略的失败。生产策略正确将它判为 blocked；修正测试替身后最终 `folded-session-green.log` 全部通过。它不代表设备恢复或展示失败。

这些测试使用 host 替身和临时配置，执行真实生产投影、原生桥、代理转发、生命周期与展示实现；没有连接用户账号、改变真机数据或运行全量脚本。打包验证由主任务另行记录。

## 真机验收

1. 在微信原生界面折叠群 A、B、C，创建自定义分组甲仅含 A、乙仅含 B、空组不含这三者。
2. 切到甲/乙，入口分别应显示 1；进入折叠页仅显示本组会话，点击打开正确的会话。空组不显示入口。
3. 返回主列表切组后再进入；原生返回和取消交互不应把当前组改成全部。多 owner 场景下可见折叠页随同账号当前组选组刷新。
4. 给 A 留未读、B 清零。甲可有折叠未读红点，乙不应被 A 的全局摘要污染；列表原生全局 unread 数据没有被插件改写。
5. 把 A 设为密友并锁定。甲的折叠入口应消失；解锁后恢复。锁定过程中旧单元格不能泄漏全局预览或旧数量，折叠页旧坐标也不能打开新隐藏会话。
6. 编辑组成员、启用“过滤重复联系人”、折叠或取消折叠一个会话后，核对入口数量与子页实际行数一致。
7. 关闭聊天分组，恢复微信全局折叠列表，密友隐私仍生效；这不改变每个会话的原生折叠状态。

尚未在连接真机上运行上述交互；host 回归不能代替微信实际 UI 验收。
