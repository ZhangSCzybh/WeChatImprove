# 2.1-28：返回会话列表的隐私发布边界证据

调查基线为未修改的 2.1-27 提交 `e9d4601c63fbfdeb11b208777ae9dc99f5f1c3c9`。本文记录源码和仓库已有原生静态证据；不把受控 host 回放或静态反汇编等同于用户设备的实时调用栈。调查没有启动、连接、注入或安装微信，没有切换 checkout、账号或数据源。

## 已确认的绕过路径

`Hooks/SessionGroupHooks.xm` 的 `Native` helper 对整个 body 执行 `CSGroupWithNativeIndices(a.table, body)`。`NewMainFrameViewController.viewWillAppear:` 和 `viewDidAppear:` 的顺序均为：解除 presentation suspension → 在 Native 范围执行原生 appearance → `attachToController:` 同步刷新（如需）。`viewDidLayoutSubviews` 等原生入口也使用同一 Native helper。

这里的 native scope 原本服务于 owner 使用原生路径进行选择、滚动、数据查询。`Controllers/CSGroupIndexScope.m` 通过当前线程中按表区分的作用域栈决定索引域；同步重入会继承同一表最内层作用域。因此原生 appearance 内若触发 table 的同步布局，UIKit 调用代理数据源时仍可能处于 owner 的 native scope。

`Controllers/CSGroupListAdapter.m` 有两处明确绕过投影：

- `cellForDisplayPath:target:` 只在 `self.isActive && !CSGroupUsesNativeIndices(self.table)` 时从 `self.projection` 读取行并映射身份。native scope 下直接将传入 path 交给原生 cell 数据源，交付对象没有投影 row 身份。
- `forwardInvocation:target:` 在 `!self.isActive || CSGroupUsesNativeIndices(self.table)` 时直接调用原生 target 并返回；投影的 section/row 数量分支位于该返回之后。原生 scope 下的 `numberOfSectionsInTableView:` / `tableView:numberOfRowsInSection:` 因而也可以读到未过滤数量。

`UITableView.reloadData` hook 对投影表拦截显式 reload，将其改为请求适配器刷新；这不能隔离原生生命周期其他同步布局所触发的 counts/cells 回调。即使当前策略已锁定、投影早已过滤，继承的 native scope 仍能绕过它。单纯提前刷新策略或投影，不能修复这个独立通道。

## 策略未就绪的既有安全语义与通知窗口

`Controllers/CSCloseFriendBridge.m` 的 `CSCloseFriendCurrentSnapshot()` 同步调用 runtime 的 `snapshotForEpoch:suspended:`。`Controllers/CSCloseFriendRuntime.m` 初始化时 `blocked=YES`；账户同步先阻塞，再同步读取和校验持久策略/凭据；epoch 不匹配或 suspension 边界返回 `blocked=YES` 的 boundary snapshot。

`Controllers/CSGroupListAdapter.m` 的 `CSGroupPrivacyActive()` 将 `snapshot.blocked` 直接视为隐私生效。`projectionForSections:tabs:selectedTabID:accountID:` 对 blocked、账户不一致、epoch 或 revision 不一致使用空 `sections`，不会将未知策略当作无隐私。`CSCloseFriendPolicy.m` 仍按既有 enabled / revealed / hideSessions / protected names 规则决定可见性。

另有真实时序边界：runtime 的 `didChange` 调用 `CSCloseFriendManager.schedulePolicyRefresh`，后者通过 `dispatch_async` 在主队列执行 `flushPolicyRefresh`，再发 `CSCloseFriendPolicyDidChangeNotification`。当前 snapshot 已变更而 adapter 尚未收到通知的间隙是可能的；不能仅用 `privacyRefreshPending` 证明投影策略版本是当前版本。

离页期间收到通知时，`closeFriendPolicyChanged:` 会先 shield 当时已有的敏感 visible cells，再请求刷新；presentation suspended 会阻止普通刷新。若旧投影来自解锁状态，display scope 中的 `currentPathForRow:` 已会按当前策略拒绝新交付的隐藏身份，不能将这个分支描述成继续创建新的敏感 cell。但在异步通知到达前，旧的缓存 visible cells 仍可能可见；旧投影的行数、占位和几何也可能尚未收敛。因此可见布局 guard 直接同步检查当前 policy 的 blocked 状态、当前账户和投影 account / privacy revision，而不只依赖 pending flag；epoch 边界已由 snapshot 的 blocked 语义涵盖。策略规则和解锁语义本身无需修改。

## 完整布局链的最窄边界

仓库已有 8.0.78 只读静态证据：

- `../list-restore-2.1-3/native/class-chain.json`：`MainFrameTableView → MMMainTableView → MMTableView`。前两层 metadata 未声明原生 `layoutSubviews`。
- `../list-restore-2.1-3/native/MMTableView--layoutSubviews.asm`：`MMTableView.layoutSubviews` 位于 `0x116729e84`，先调用 super layout（`0x116729ebc`），然后执行 `reloadIndexView`（`0x116729ecc`）及原生选择 cell 恢复（`cellForRowAtIndexPath:` 调用位于 `0x116729f20`）。仅在 UIKit 基类包一层 display scope，无法覆盖 MMTableView 的 super 返回后的工作。
- `../list-restore-2.1-3/native/NewMainFrameViewController--viewWillAppear_.asm`：原生 appearance 包含条件 `resetTableViewOffset:`（`0x105118d64`）、`cancelSelectedCell`（`0x105118d74`）、条件 `reloadData`（`0x105118e28`）、任务栏通知和 `indexPathsForVisibleRows`（`0x105118e60`）。它包含原生表恢复和同步查询入口，但这份静态证据本身不证明用户某一帧必经了其中哪条分支。

因此将已附着主表的完整 `MainFrameTableView.layoutSubviews` 原生调用置于 display scope，可在布局入口隔离 owner 的 native scope，同时保留原生 owner 自己使用 native 路径的语义。正常 `layoutIfNeeded` 触发动态分发的实际 table layout，无需固定延时或另加延时刷新。

现有 `Hooks/ListCornerRadiusHooks.xm` 也 hook 叶类 `MainFrameTableView.layoutSubviews`，交给 `CSListCornerPerformSessionTableLayout` 做完整原生调用后的外观收口。`Controllers/CSListCornerSessionRestore.m` 的 post-layout 恢复复用已交付角色，不读取 rows/projection。无论两条 hook 的安装链顺序，可见布局 scope 都能包住完整原生 `%orig`；本次不需要修改圆角、间距或外观规则。

## 位移和帧证据的边界

用户录屏第 86 帧显示两条受保护会话，第 92 帧同一区域已没有这两条，后面的普通会话整体上移。上述绕过路径可先交付原生数量和 cell，随后安全投影重新交付较短的过滤结果；先多出两行再移除，本身就会造成内容上移。它是同一发布失配足以解释的位移，不需要为此修改滚动锚点或分组结构。

源码证据确认“首轮可见回调能绕过过滤”和“异步通知前不能仅信任 pending flag”这两个缺口。新增受控回归应通过真实生产方法回放外层 native appearance → 同步 table layout → counts/cells，记录每次交付身份与顺序，并覆盖锁定策略已就绪、通知晚到、blocked、解锁与再锁定。修复后首个可见提交必须使用当前过滤结果；前置条件不足时不得先交付未过滤内容。

用户视频中的约 6 帧 / 0.2 秒是真机现象证据。host 的身份交付日志能证明模拟序列是否存在中间未过滤提交，不能测量 iOS 合成器实际帧，也不能代替安装 2.1-28 后的真机复录。最终报告应分别说明受控回归的提交次数、首个提交的过滤状态，以及真机复录是否完成，不将静态或 host 证据表述成实测零泄露帧。
