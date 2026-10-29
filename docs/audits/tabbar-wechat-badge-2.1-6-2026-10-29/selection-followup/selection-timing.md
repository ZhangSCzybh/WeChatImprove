# 保存密友名单后微信角标立即消失：源码时序复核

本次仅分析已回滚至授权清理交付的 2.1-6 源码，不修改生产代码、正式 Tests、版本、旧报告或历史包。16 个相关文件的完整快照及逐段行号已保存；全部与 `authorization-cleanup-2026-10-28/source-sha256-after.json` 的 SHA-256 一致，捕获前后原交付清单的 602 个文件保持一致。见 [source-reference.json](source-reference.json) 和 [source-references.md](source-references.md)。

用户的新反馈是“选择任意一个密友或群，微信 tab 数字立即消失；清空后恢复”。源码中存在一条不需要等待新消息、也不依赖底栏几何变化的完整可达链：**保存第一项使角标过滤从不接管变为接管；主会话列表在设置页后面时可能已经清空缓存并置 dirty；策略通知的刷新允许因列表挂起而退出，另一个观察者把查询返回的 `@0` 写给原生 tab 数字 setter。** 这里可以确认“源码能这样发生”，但本机尚未捕获用户设备的实际配置、生命周期、两个观察者顺序和原生 setter 调用日志，不能将这条可达路径写成已测得的设备调用栈。

## 1. “选择”的实际提交点

`CSNativeContactPicker.m:35–94` 中，逐项选中回调 `onShouldSelectContact:` 只验证联系人和单选约束，不保存配置。点击原生“完成”后，`PickerDone` 调用 `finish:YES`；它读取原生选择字典，关闭选择器导航，在 dismissal completion 中再次验证账号和 token，随后交付名单。取消走 `finish:NO`，不提交。

`CSCloseFriendSettingsViewController.m:190–214` 的完成回调先刷新账号、验证 token，再将 `profile[@"friends"]` 或 `profile[@"groups"]` 替换为选择结果并调用 `save:`。保存空数组也走同一成功提交路径。因此当前源码能证明的触发点是“完成并保存名单”，不能仅凭反馈将触发点精确到尚未点击完成的每一次勾选。实际复现记录应明确这两种动作。

`CSCloseFriendPolicy.m:48–55` 构建的 `protectedUserNames` 是 friends 与 groups 的并集。第一次任一列表从空变为非空可以让总并集从 0 变 1；清空一类而另一类仍有项目时，总并集不会归零。后文所说的“清空后不接管”指总并集为空且 snapshot 非 blocked。

## 2. 保存、持久化、snapshot 失效和策略通知

| 阶段 | 2.1-6 代码位置 | 已确认行为 |
| --- | --- | --- |
| 配置提交 | `CSCloseFriendBridge.m:45–58` | 主线程、账号 epoch 和 suspended 检查；刷新账号并拒绝 blocked snapshot；调用 runtime `updateProfile:`。 |
| runtime 更新 | `CSCloseFriendRuntime.m:208–221` | 要求当前授权及 credential；规范化 profile；保存并读回状态；成功后调用 `changed`。失败分支会 blocked/lock，不能默认失败也成功生效。 |
| 实际落盘 | `CSCloseFriendStore.m:99–133` | 验证账号/profile/key、加密 staging、读回验证、原子 rename 与 fsync。Store 自身不发策略通知。 |
| snapshot 失效 | `CSCloseFriendRuntime.m:42` | revision 加一，清空 publishedSnapshot 和 boundarySnapshot，然后调用 didChange。 |
| 广播排队 | `CSCloseFriendManager.m:102–115` | didChange 调度 `schedulePolicyRefresh`；合并重复待发任务，dispatch 到主队列；flush 刷新相关状态后发送 `CSCloseFriendPolicyDidChangeNotification`。 |

这是一条成功保存后的下一次主队列策略发布路径，没有额外新增的固定等待。磁盘读回成功、账号有效等条件仍需日志确认；用户看到名单保存结果不能替代这些内部状态记录。

## 3. 第一个名单项为何改变角标接管结果

`CSGroupListAdapter.m:183–209` 的返回类型实际上承担两种含义：`nil` 表示不接管、交给原生；非 nil 表示插件提供了要使用的数值。当前实现把“确定没有未读”和“暂时没有合格的列表快照”都表示为数值零。

过滤条件为：

```objc
[policy concealsSurface:CSCloseFriendSurfaceSession]
    || (policy.enabled && [policy.options[@"silenceMessages"] boolValue])
```

`silenceMessages` 的默认值是 YES（`CSCloseFriendPolicy.m:7–9`），但尚未读取用户的实际选项，不应把默认值当成设备当前值。会话隐藏受 revealed 影响；第二个 enabled + silenceMessages 条件没有 revealed 限制，因此进入已验证设置页时即便会话隐藏暂时解除，角标过滤仍可能激活。

| snapshot/列表状态 | `closeFriendAlertBadgeCount` 结果 | 对微信 tab 的意义 |
| --- | --- | --- |
| 非 blocked，过滤未激活 | `nil` | 后续原生 setter 保留原始参数。 |
| 非 blocked，总保护名单为空 | `nil` | 后续原生 setter 保留原始参数。 |
| snapshot blocked（不要求名单非空） | `@0` | 数值 setter 被替换为零；字符串 setter 被替换为 nil；新增红点调用可被抑制。 |
| 过滤激活、总名单非空，但不在主线程 | `@0` | 同上。 |
| 过滤激活、总名单非空，但所有 adapter 均无有效缓存或在 changeDepth/dirty/revision/epoch/account 不一致状态 | `@0` | 同上。该值没有区分“尚不可计算”。 |
| 有合格缓存并且投影有效 | 投影 `.count` | 按过滤后的计数接管；这里只取 count，没有保留原生纯红点状态。 |

blocked 状态不会进入 `!policy.blocked` 限制的名单/过滤旁路，因此即使保护名单为空也不会 nil 透传。“过滤激活、名单非空”是本次正常保存路径的主要前提，不是 blocked 返回零的必要条件。

保存任意一个名字本身并不保证投影未读为零。如果缓存有效，且还有其他可见未读会话，结果可以是非零。与新反馈相吻合的关键组合是“并集由空变非空，且此时列表缓存不可用”，而不是“随便选一个人就一定把所有未读过滤掉”。

另有独立问题：投影确实可能返回 `count == 0 && redDot == YES`，getter 只取 count 会丢失这一差别。先前受控内容探针已验证此状态，但它不应被当作本次数字从 12 变为消失的唯一解释。见 [content-probe.md](../probe/content-probe.md)。

## 4. 设置页覆盖列表时已经存在的缓存失效路径

`SessionGroupHooks.xm:74–81` 在主列表的 `viewWillDisappear:` 与 `viewDidDisappear:` 调用 `setPresentationSuspended:YES`。

`CSGroupListAdapter.m:157–166` 的 suspension 会：

1. 设置 `presentationSuspended = YES` 和 `dirty = YES`。
2. 使原生 snapshot revision 失效，并将 `cachedNativeSections = nil`。
3. 丢弃投影计算缓存、取消待执行的刷新，并收束悬挂的 table 批处理。

`refresh` 在 `CSGroupListAdapter.m:492–493` 允许直接退出：

```objc
if ((... application inactive ...)
    || (self.presentationSuspended && !self.nativeActions.count)) {
    self.dirty=YES;
    [self finishSuspendedBatches];
    return;
}
```

`privacyRefreshPending` 不会绕过后一项“挂起且没有 nativeActions”限制。因此，保存后分组观察者即便先执行 refresh，也不保证立即重建缓存。此时角标查询在 `191–193` 跳过这个 adapter，最终 `209` 返回 `@0`。

实际打开设置的导航方式会影响主列表是否收到 disappearance；不能把上述钩子存在本身当成设备生命周期日志。这条源码路径的实机核对重点是：保存前该 controller 的 suspended、dirty、cache 是否已经是 `YES / YES / nil`，以及是否存在另一个有效的非折叠 adapter 可供读取。

## 5. 两个与角标有关的策略观察者

这里列的是本条证据链相关的两个观察者，不代表全仓只有两个策略观察者。

**分组观察者。** `SessionGroupHooks.xm:499–510` 在 `CSBackupWhenReady` 后注册。回调 `CSGroupListAdapter.m:214–227` 对每个 adapter 设置 privacyRefreshPending 和 dirty，遮蔽敏感行、取消旧刷新、使原生快照失效，然后尝试 refresh。它能重建还是立即退出，取决于上节的实际状态。

**通知/角标观察者。** `CloseFriendNotificationHooks.xm:113–125` 在 main operation queue 上接收通知。它查询 `closeFriendAlertBadgeCount`；只要结果非 nil，就同步应用图标角标并遍历已知 TabOwners，对匹配的聊天 tab 调用原生 `setTabBarBadgeValue:forIndex:`。结果为零时，还单独调用 `removeRedDotOnTabBarItemAtIndex:`。这些发送前都有 ABI 匹配检查。

后者有几项不可省略的实际前提：

- owner 之前曾在主线程经过成功的 `ChatTab` 判断，进入弱引用 `TabOwners`，而且仍存活。
- 该 owner 当前 `viewControllers` 仍能读到匹配聊天根控制器的项。
- 对应 setter/remove 方法的 ABI 检查通过。
- 观察者获取的 value 非 nil。value 是 `@0` 时仍为非 nil，确实进入写零与 remove 分支。

观察者发送 setter 使用的是 `objc_msgSend`，会重新进入已安装的数值 hook，再次查询 getter，然后才调用原始实现。主线程没有自然并发穿插并不等于值永不变，嵌套原生调用仍可能产生状态变化；精确值应记录两次查询。

源码没有规定两个观察者间的业务依赖，也未保证谁先收到这次通知。不能把“注册先后看起来如此”写成固定运行顺序。若分组观察者先刷新并成功得到有效非零缓存，后者可以写非零；若它因 suspension/changeDepth 等退出，或通知观察者先读取了无效缓存，则写零路径仍可达。记录应包含两回调进入/退出和 getter 的对应时间顺序。

## 6. 从保存第一项到写零的最短可达链

以下是源码可达的条件链，并非已捕获的真机 trace：

```text
当前非 blocked，名单并集为空
  └─ badge getter 返回 nil，原生数字可正常显示
打开设置/选择器，主列表若发生 disappearance
  └─ presentationSuspended=YES, dirty=YES, cachedNativeSections=nil
点击完成，保存第一位密友/群
  └─ store 保存并读回成功 → runtime.changed → 新 snapshot → 主队列策略通知
总保护名单变为非空，且 enabled+silenceMessages 或 session concealment 生效
  ├─ 分组观察者：置 dirty 并 refresh；若挂起且没有 nativeActions，直接退出
  └─ 角标观察者：无合格缓存 → getter=@0
       └─ 已注册 owner + ChatTab 匹配 + ABI 通过
            └─ setTabBarBadgeValue:forIndex: 参数为 0
                 └─ 经过插件 hook 后进入原生数值实现
            └─ removeRedDotOnTabBarItemAtIndex:（值为零时）
```

这一链条只针对匹配 `NewMainFrameViewController` 的聊天 tab；不会因同一内容 hook 自动对通讯录、发现、我全部写零。其他 tab 正常、微信 tab 数字与红点一起受影响，比“所有 item 共用的背景层统一盖住”更符合这条内容路径。这个关联仍不足以从逻辑上排除共享布局代码只对某个几何组合产生影响，几何探针的独立发现应保留，见 [geometry-analysis.md](../geometry-analysis.md)。

## 7. 清空名单为什么允许恢复，以及尚未证明的恢复调用

当保护并集为空且 snapshot 非 blocked 时，getter 在 `CSGroupListAdapter.m:186` 返回 nil。三个 tab 内容 hook 随后各自透传原始参数，不再将数字替换为零、字符串替换为 nil 或拦截新增红点。

但策略观察者的写入结构是 `if (value) ...`。这次 getter 若为 nil，观察者不会主动写回原生总数，也不会从缓存恢复旧字符串。**清空名单解除接管是源码直接证据；清空观察者本身直接恢复原始 12 则不是。** 用户看到恢复，说明至少存在后续原生更新或另一路间接重算；它可能发生在此次页面/列表刷新中，不能据此断言必须等待下一条新消息。

如果清空后仍处于 blocked，getter 不会 nil 旁路；清空一类而另一类名单未空，也不满足该旁路。实机记录需要同时打印并集大小、enabled、silence、revealed、blocked 与返回值，避免只记录 UI 中某一类名单的计数。

## 8. 列表 refresh 可能间接恢复，不能只搜 setter 得出“永不恢复”

全仓查找显示 `CSGroupListAdapter.refresh` 没有显式、专用、保证发生的 tab 内容重新发布调用。但 refresh 并非没有原生回调边界，不能从“没有直接调用这个 selector”推导为“不会再触发原生 tab setter”。

可见的间接边界包括：

| 源码边界 | 为什么必须保留恢复可能性 |
| --- | --- |
| `CSGroupListAdapter.m:507` | 开始 refresh 时就令 publishing=YES、dirty=NO；getter 没有单独以 publishing 或 suspended 为拒绝条件。 |
| `nativeSectionsForAccount:465–476` | 读取原生数据源并重建 cachedNativeSections，稳定时记录 account/revision/epoch；刷新尚未结束，也可能已有合格缓存。 |
| `publishProjection:617–638` | 调用 reloadData/reloadRows 和 layoutIfNeeded。`SessionGroupHooks.xm:53,312–338` 的 Projected 条件排除 publishing，因此这时相关 table hook 会进入原始 table 实现。 |
| adapter table proxy：`972–982,1002–1052` 等 | cell 构建和 delegate/dataSource 回调可以转发给原生目标；本次冻结了相关有界段及完整源码。 |
| `CSGroupIndexScope.m:1–17` | native/display 坐标域只是作用域标记，不构成“禁止原生回调副作用”的屏障。 |
| adapter `591–612,1173–1190` | refresh 还有布局、恢复 anchor、原生 updateTitleView、完成块及 queued nativeActions 执行边界。 |
| 其他原生事件 | 页面 appearance、未读通知、后续消息等仍可走原生未读重算；并非本次分析已经测得其调用顺序。 |

若某个原生边界在缓存已经有效时调用 tab 数字 setter，内容 hook 能重新得到非零投影并恢复显示。如果处于“非隐私、会话分组也未启用”的 refresh 早退分支（`CSGroupListAdapter.m:532–543`），它反而会将 cachedNativeSections 清空，而 enabled + silenceMessages 的 badge 过滤仍可能激活；这种组合下无缓存返回零可以持续，不只是短暂事务窗口。设备实际会走哪一支尚未记录。

因此目前可以写的结论是：**正常 refresh 完成没有源码保证的专用 tab 重发布；保留的原生回调又使间接恢复成为可能。** 不能写“绝不恢复”“必须等新消息”或“reload 一定恢复”。纯几何 layout 可以重新排 badge 的位置，但不会自动从已经写零的内容状态重建原始数字；需要区分原生内容重算与仅布局两个事件。

新消息事务仍是另一条可达的零路径：`SessionGroupHooks.xm:46–51` 在原生消息处理前后包 begin/endNativeChange；`CSGroupListAdapter.m:762–777` 设置 changeDepth/失效 revision，end 后按既有调度刷新。事务中发生 tab setter 会得到零。新的“保存名单即发生”反馈说明没有必要只依赖新消息事务来解释本次症状，但它仍应包含在后续诊断矩阵中。

## 9. ChatTab 不是硬编码 index 0，底栏样式也没有替换 controller 根

`CloseFriendNotificationHooks.xm:27–32` 的 `ChatTab(owner,index)` 条件依次是：

1. 通过 ABI 校验的对象 getter/精确对象 ivar 读取 `viewControllers`，结果为 NSArray。
2. 参数 index 在数组范围内。
3. 取 `viewControllers[index]`；如果是 UINavigationController，只展开一次 `viewControllers.firstObject`。
4. `NewMainFrameViewController` 类存在，且展开后的对象为该类或子类。
5. 匹配且在主线程才将 owner 加入弱集合；非主线程匹配仍返回 YES，随后 getter 可以返回零。

它没有比较 index==0，也没有检查 selectedIndex；聊天页在 index 2 等其他位置仍可匹配。读不到数组、越界、空导航栈、不属于 UINavigationController 的额外 wrapper、多层自定义包装、根类型不同或目标类不存在，都可能 NO。这里没有递归 child 搜索兜底。

对 `Hooks/TabBarStyleHooks.xm` 与 `Controllers/CSTabBarNativeAdapter.m` 完整源码搜索 `setViewControllers:|viewControllers\s*=|setRootViewController:|rootViewController\s*=` 为无匹配，证据已保存。样式 adapter 从现有 bar.customDelegate 识别 owner，仅读取 selectedViewController/nav.viewControllers/topViewController 决定 inset。现有样式修改 view/frame/inset/surface/hit-test，没有生产源码证据表明它替换 controller 数组或根控制器。不能把 view 层级调整等同于 controller containment 重建。

8.0.78 原生启动静态结果也不支持“正常初始化完成时根尚未建立”的默认解释：`MainTabBarViewController.init`（`0x104abe968`）先创建 slim controllers，再调用 `p_createNewMainFrameViewController`，之后 `setViewControllers:`；创建方法在 `0x104abfacc` 构建 NewMainFrame，`0x104abfae8` 创建以其为 root 的 StatusBarMonitorNavigationController，`0x104abfb44` 放到 index 0。继承链已核对为 StatusBarMonitorNavigationController → MMUINavigationController → UINavigationController。对应汇编、方法清单和类继承证据见 [native](native/)。早于最终 setViewControllers 的原生 badge 调用是否存在，仍需日志，不应从静态正常完成路径倒推不存在。

## 10. 冷启动正常不能笼统解释为“策略没加载就透传”

`CSCloseFriendRuntime.m:34` 初始化 blocked=YES；`snapshotForEpoch:suspended:` 在 epoch 边界不匹配或 suspended 情况构造 blocked boundary。`CSCloseFriendCurrentSnapshot()` 本身只是读取 runtime snapshot，不在这个 getter 中同步加载账号。

因此 hooks 已安装且 ChatTab 匹配时，“策略尚未加载”会使 getter 返回 `@0`，不会 nil 透传。`CSCloseFriendManager.start` 和 `refreshAccount` 则同步调用 runtime 账号加载；源码没有一个必须等待未知异步配置读取的流程。生命周期 ctor 的 hook 安装与 start 都 dispatch 到主队列，HomeDidAppear 先调原始实现再 start/refresh；原生早期 setter 与这些安装/加载事件的相对顺序需要实测。

如果启动时总名单本来为空，nil 旁路是直接有据的“原生数字正常”条件。若名单已持久化非空而冷启动仍显示原始数字，可能要核对 hook 安装前调用、ChatTab 尚未匹配、有效非零快照、不同过滤选项，或旧内容尚未被下一次 setter 更新等情况。上述是待区分的候选，不能凭冷启动表象选定其中一项。

## 11. 本次证据边界与下一步最小记录

本次源码分析可证明保存回调、缓存失效规则、两观察者工作内容、数值零写入的可达路径、清空名单的 nil 旁路，以及保留的原生间接回调边界。源码快照和搜索是生产基线证据；受控 host 探针验证的是所提取逻辑在指定状态下的结果。二者都不是用户设备真实对象状态或原生回调时序的测量。

后续如允许采集运行时日志，最小一轮应包含同一进程、同一 owner 的：

- 从列表进入设置前后、选择完成/取消、保存成功、名单并集大小及 policy revision；同时记录 enabled、silence、revealed、blocked、账号 epoch 的匿名标识。
- 两策略观察者 enter/exit，getter 的调用来源与每个 adapter 的 suspended/dirty/changeDepth/cache/revision/epoch/account 匹配结果。
- 原生数字、字符串、showRedDot、removeRedDot 的入参、ChatTab 匹配/index、原始调用前后 badge 内容状态；敏感联系人和消息内容不写入日志。
- refresh 进入/guard 退出/缓存发布/完成，相关原生内容 setter 是否在其内嵌套或之后触发。
- “清空后恢复”时的第一条非零原生 setter，定位它由哪个回调触发；同时区分仅 layout 的调用。

首轮矩阵应把样式保持不变，比较“名单并集空 → 保存任一项 → 清空并集”，再比较分组启用/停用、silence 开关、revealed 状态、设置覆盖主列表与回到主列表。这比在尚未区分内容清零时先修改布局，更能缩小当前事件的实际原因。该条矩阵是诊断建议，本次没有改变任何设置、读取用户名单或运行设备采样。

本报告未提出已实施的修复，也没有构建、打包或修改版本。
