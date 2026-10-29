# 微信 tab 角标：通知与会话快照路径只读核对

日期：2026-10-29。分析 checkout：`/Users/zhangshichao/Documents/Workspace/WeChatImprove`。生产基线为授权清理后的 **2.1-6**；基线恢复依据见本目录 `rollback-provenance.json`、`rollback-diff-result.json`。本项仅增加此分析文件，没有修改生产源码、Tests、版本、历史报告或安装包，没有运行微信、读取用户配置、安装或打包。

## 结论及证据边界

已确认项目中存在一条**直接让微信原生 tab badge 隐藏**的路径：`CloseFriendNotificationHooks` 只对会话页对应 tab 改写未读值；`closeFriendAlertBadgeCount` 将“可靠会话快照暂不可用”和“过滤后确实没有数字未读”都表示成非空 `NSNumber @0`。hook 收到 `@0` 后，将数字输入改成 `0`、字符串输入改成 `nil`，或阻止显示原生红点。微信 8.0.78 的原生代码将数字 `0` / 空字符串转换为原生 badge 的 `hidden=YES`。**这个机制不需要发生 frame 错位、遮挡或裁剪。**

这是一条有完整源码与原生静态证据的可达机制。新增的定向静态核对还证明：`MainFrameLogicController onSessionTotalUnreadCountChange:` 会同步调用 delegate 的 `updateUnReadCount`，后者同步写微信 tab 数字角标，确实位于本项目 `NativeNotification` 的 changeDepth 非零范围。**但尚不能确认为本次真机故障根因**：未取得用户当时的密友策略、过滤后的正常未读量、hook 安装状态及原生 setter 实际输入输出。也不能把用户怀疑的“底栏样式导致”当成已经完成对照验证的事实。

本轮补充的现象是：通讯录、发现角标正常；微信 tab 冷启动有数字角标，新消息到达后消失。它与本路径“仅筛选会话页 tab，运行期写值时才介入”的形态相符，但相符不是运行证据。关闭底栏样式后是否恢复、是否涉及“我”、纯红点是否同样出现、具体样式配置及前后台条件，都仍待观察。

## 所有相关写入点

按 `Controllers / Hooks / Headers / Tests` 搜索 `setTabBarBadgeValue`、`setTabBarBadgeString`、`setBadgeViewHidden`、`showRedDotOnTabBarItemAtIndex`、`removeRedDotOnTabBarItemAtIndex`、`badgeView`、`badgeValue`；微信原生头目录 `HeadersFile` 不作为项目引用。以下行号均对应恢复后的 2.1-6 当前源码。

| 文件、方法/位置 | 触发和筛选条件 | 实际写入/抑制 |
| --- | --- | --- |
| `Hooks/CloseFriendNotificationHooks.xm:27–32`，`ChatTab` | 读取 owner 的 `viewControllers[index]`；若为导航取根页；根页为 `NewMainFrameViewController` 才匹配；不假定 index=0 | 无直接写值；主线程匹配时将 owner 记入 weak `TabOwners`；通讯录、发现页不匹配 |
| 同文件 `:104–106`，`setTabBarBadgeValue:forIndex:` hook | `ChatTab` 匹配后取过滤结果；不匹配视为 `nil` | `nil` 保留原 count；非空数字代替原 count，包括 `@0 → 0` |
| 同文件 `:107–109`，`setTabBarBadgeString:forIndex:` hook | 同上 | `nil` 保留原 string；正数代替为过滤结果的 `stringValue`；`@0` 代替为 `nil` |
| 同文件 `:110–112`，`showRedDotOnTabBarItemAtIndex:` hook | 同上 | 非空 `@0` 直接 return，不调用微信原方法；`nil` 或正数调用原方法 |
| 同文件 `:113–126`，密友策略变更 observer | 监听 `CSCloseFriendPolicyDidChangeNotification`，主队列；仅过滤结果非空才遍历已记住的 owners，对匹配 tab 执行 | `:120–121` 发 `setTabBarBadgeValue:forIndex:`，重新经过同一 hook；结果零时 `:122–123` 另发 `removeRedDotOnTabBarItemAtIndex:` |
| `Controllers/CSTabBarNativeAdapter.m:163–165,181,209–212` | 底栏原生适配 restore/apply | 保存及改写原生 badge 的 **frame**，没有在这些位置改 count/string/hidden；几何分析由主报告另行核对 |

本轮 selector/属性引用搜索中，项目没有其他直接设置原生 tab badge 数值/字符串的调用点，也没有发现独立的项目 `badgeView.hidden` 写入。这个结论限于可检索的现有源码；它不涵盖微信原生所有内部写入者，也不能证明不存在运行时由其他插件安装的 hook。

以下写的是**应用图标角标/本地通知**，不能当作底部 tab 的直接写入证据：

| 文件、位置 | 作用 |
| --- | --- |
| `Hooks/CloseFriendNotificationHooks.xm:83–95` | `UNUserNotificationCenter addNotificationRequest:`；过滤结果与原通知 `.badge` 都非空时，copy content 并替换应用图标 badge |
| 同文件 `:96–99` | 两个 `UILocalNotification` 入口；copy 后替换 `applicationIconBadgeNumber` |
| 同文件 `:101–103` | `UIApplication setApplicationIconBadgeNumber:`；非空过滤值覆盖输入，包括零 |
| 同文件 `:116` | 策略变化时主动写应用图标角标；随后 `:117–125` 才是独立的 tab 更新 |

消息身份 `CSCFMessageSubject`、`Silent` 只负责相关通知/音频输出过滤；上述三个 tab hook **没有调用 `Silent`，也没有检查当前这条消息是否属于密友**，它们计算的是会话列表的过滤总量。不能以“新消息来自普通好友”排除这条总量路径。

## 过滤返回值的精确条件

`Controllers/CSGroupListAdapter.m:183–210`：

```text
filtering = policy.concealsSurface(Session)
            || (policy.enabled && policy.options.silenceMessages)
```

| 条件 | 返回值 | 三个 tab hook 的后果 |
| --- | --- | --- |
| `!blocked && (!filtering || protectedUserNames.count == 0)`，`:186` | `nil` | 透传微信输入，包括非主线程时也先命中此分支 |
| 需要过滤且非主线程，或 `blocked`，`:188` | `@0` | 数字写零、字符串写 nil、红点显示被阻止 |
| 所有 adapter 都是折叠页、没有 cached sections、`changeDepth>0`、`dirty`、revision/epoch/account 不匹配，`:190–193,209` | `@0` | 同上；并非“确认未读数为零” |
| 得到可用 sections 后，projection 无效，或计算过程中 revision/epoch/policy revision 变化，`:202–205` | `@0` | 同上 |
| 有可用且稳定的快照，projection 过滤后数字 count 为零，`:206–207` | `@0` | 同上；这可能是预期隐私过滤结果，不能一概改成透传 |
| 有可用且稳定的快照，过滤后数字 count > 0，`:206–207` | `@(count)` | 将微信输入替换为过滤总数；红点调用放行 |

`CSCloseFriendSnapshot` 的事实边界：

- `Controllers/CSCloseFriendPolicy.m:59–64`：`blocked` 会使 `concealsSurface` 返回 YES；未启用、已 revealed 或没有保护名单时返回 NO；否则会话面看 `hideSessions`。
- 同文件 `:69` 的消息静音策略不以 revealed 为条件。`closeFriendAlertBadgeCount` 的 `silenceMessages` 分支同样不检查 revealed；因此“当前已经解锁显示了密友”不等于“不再过滤角标”。
- `Controllers/CSCloseFriendRuntime.m:77–89`、`CSCloseFriendBridge.m:8–11`：账号暂停、epoch 不一致会提供 blocked 边界快照。初始化 `_blocked=YES`（Runtime `:34`）；账号同步/凭据或策略不可用的情况也可能保持 blocked（`:54–74`）。这些都是代码条件，**不是对用户账号状态的判断**。
- 默认 options 包含 `hideSessions=YES`、`silenceMessages=YES`（Policy `:7–8`）；默认空 profile 的 enabled 为 NO（Runtime `:10`）。默认选项不能证明用户开启了密友功能。

### 红点与数字总数并不是同一个状态

`CSGroupProjection.m:68–78` 明确把数字 unread 和 redDot 分开：row 是 redDot / Aggregate / Business 时，数字贡献为 0；普通红点 row 有未读时仍可贡献 `redDot=YES`。`:318–321,337–339` 将两个量分别汇总。可用 projection 可以合法得到 `{count:0, redDot:YES}`。

但是 `closeFriendAlertBadgeCount:206` 只返回 `.count`，没有把 `.redDot` 暴露给 hook。此时 `showRedDotOnTabBarItemAtIndex:` 的 `:111` 会因为 `@0` 阻止原生 show。它是另一个已确认的**条件性机制**；尚不知道反馈时普通未读是否只剩红点会话，也不把分组 chrome 的红点对象当作底部 tab 原生角标。

## 新消息失效窗口与后续刷新

源代码可以证明以下顺序：

1. `Hooks/SessionGroupHooks.xm:93,94,100` 将 `newMessageByContact:msgWrapToAdd:`、`updateSession:`、`logicUpdateSession:` 包在 `NativeNotification` 内；`:200` 也将 **MainFrameLogicController `onSessionTotalUnreadCountChange:`** 包在同一 helper 内。`Adapter:34–37` 可以从逻辑对象的 `m_delegate` 找会话页 adapter。
2. `NativeNotification:46–51` 先取 adapter。有 table 时，**先** `beginNativeChangeOfKind:`，再执行微信原实现，finally 执行 `endNativeChangeCoalesced:YES`。没有 table 时只执行原实现。
3. `CSGroupListAdapter.m:762–768` 的 begin 先 `invalidateNativeSnapshot`，增加 `modelRevision`（`:465–466`），然后 `changeDepth++`。在这段时间，当前 adapter 无法通过 getter `:191–193` 的有效性判断。
4. end `:774–776` 减少 depth；最外层请求 coalesced refresh `:747–758`，标记 dirty，再由 `scheduleRefresh:707–745` 异步刷新。当前代码 coalesced delay 是 0.08 秒（`:718`）；这是已有行为，本轮未更改，也不建议靠加延时修复。
5. refresh 只有在安全可发布时才构建 native sections；拖动、侧滑、编辑、未在前台、列表已离屏等条件会推迟刷新（`:492–505`）。`nativeSectionsForAccount:468–477` 在成功稳定构建后才更新 cached sections/revision/epoch。

新增定向原生证据已经补齐 `onSessionTotalUnreadCountChange:` 这一具体窗口的同步关系，文件位于本目录 `native/`：

```text
SessionGroupHooks:200 NativeNotification
  → beginNativeChangeOfKind: invalidate + changeDepth++
  → 原生 MainFrameLogicController.onSessionTotalUnreadCountChange:
      0x104aa81b0 取 selector updateUnReadCount
      0x104aa81d4–81e4 同步向 m_delegate 发送 updateUnReadCount
        → NewMainFrameViewController.updateUnReadCount
            0x105112a04–a1c 从逻辑对象读取 getTotalUnreadCount，保存在 x21
            0x105112bd4 将 count 放入 w2
            0x105112bdc 取 selector setTabBarBadgeValue:forIndex:
            0x105112be0 设置 x3=0
            0x105112be4 同步发送 setter
                → CloseFriendNotificationHooks:105 过滤总数
  → endNativeChangeCoalesced:YES
```

所以，在 adapter/table 已附着、delegate 指向主会话页且原生走到此 setter 的正常路径上，**setter 在当前 adapter `changeDepth>0` 的范围内执行不是时序猜测**。若此时需要过滤/blocked，且没有其他有效非折叠 adapter 提供新快照，getter 就会返回 `@0`。仍未观察到的是用户现场是否开启过滤、原生 count 是否为正、具体 root class 匹配情况、hook 是否生效，以及故障时是否实际经过该回调；这些条件必须保留。其他 `newMessageByContact:` 等回调各自的内部 setter 时机，本项不作同样的全称推断。

此外还有两个更长的快照不可用条件：

- 离开会话列表时 `setPresentationSuspended:YES`（`SessionGroupHooks:73–79`）清缓存并失效（`CSGroupListAdapter:157–166`）；前后台切换 `:246–257` 也清缓存。此时普通刷新会等到合适的列表可见/前台时机，不能假定收到消息时总有有效列表快照。
- `CSGroupPrivacyActive:17–19` 只看 blocked，或 `enabled && !revealed && hideSessions`。它不包括 `silenceMessages`。若密友启用且保护名单非空、`silenceMessages=YES`，同时当前 `privacy=NO`（例如 revealed=YES 或 hideSessions=NO），聊天分组也未开启，则 refresh `:532–543` 会清掉 `cachedNativeSections`。getter 仍需过滤，最终 `:209` 返回 `@0`。此条件可以持续存在，不能只用“瞬时竞态”描述所有零值。

### 刷新成功是否会修回 tab

引用搜索未找到“native sections 刷新成功后重新发布原生底栏 badge”的项目调用。`refresh:583–589` 调用的是 `self.chrome updateUnreadCount:hasRedDot:forTabIndex:`，这是**聊天分组条**；`:597–614` 的 finally 执行已排队 completion/native actions 与后续 refresh，没有直接重发 MMTabBarController badge。

项目中的主动 tab 重发位于 `CloseFriendNotificationHooks:113–126` 的**密友策略变化通知**。策略通知来自 Runtime `changed` → Manager `schedulePolicyRefresh/flushPolicyRefresh`（`Runtime:42`、`Manager:103–114`），不是每次会话快照刷新都会发的事件。SessionGroupHooks `:503` 和通知 hook 各注册了策略 observer；实际注册/调用顺序尚未运行核对。原生后续是否还会另发 setter，也需要日志；不能将“项目没主动重发”写成“永远不会恢复”。

## 8.0.78 原生静态闭环

显隐和 ABI 核对复用 `docs/audits/tabbar-badge-2026-10-28/native/` 的有界证据；本次同步调用链引用主任务新增的本目录 `native/MainFrameLogicController--onSessionTotalUnreadCountChange_.asm`、`NewMainFrameViewController--updateUnReadCount.asm` 及 metadata。本子项没有重新打开 REA或执行目标。目标为微信 8.0.78 / build 8.0.78.34 / arm64，SHA-256：

```text
0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e
```

这代表本地分析镜像；尚未校验用户设备加载镜像 identity。方法边界按 `methods.json` 和 Objective-C metadata，而不是 llvm 输出中的泛化符号标题。

| 原生方法 | 静态证据 |
| --- | --- |
| `MainFrameLogicController onSessionTotalUnreadCountChange:`，起点 `0x104aa8180` | 本目录 `native/`：`0x104aa81ac–81e4` 检查 delegate 响应后，同步发送 `updateUnReadCount` |
| `NewMainFrameViewController updateUnReadCount`，起点 `0x1051129d4` | 本目录 `native/`：`0x105112a04–a1c` 读取并保存原生 total；`0x105112bd4–be4` 以该 total、index=0 同步调用 `setTabBarBadgeValue:forIndex:` |
| `MMTabBarController setTabBarBadgeValue:forIndex:`，起点 `0x1047263ac` | `0x10472649c–4d4` 取指定 tab item 并发送 `setTabBarBadgeValue:`，没有丢弃零值 |
| `MMTabBarItemView setTabBarBadgeValue:`，起点 `0x1047272b0` | `0x1047273c0–3c4` count<1 分支到 `0x104727474`；`0x10472747c–48c` 对 badge `setHidden:YES`；正数分支 `0x104727400–424` 先 setHidden:NO 再 setValue；末尾 `0x104727490–4b4` 走 layoutBadgeView |
| `MMTabBarController setTabBarBadgeString:forIndex:`，起点 `0x104726534` | `0x104726628–638` 检查字符串 length；零 length（含 nil）到 `0x104726690–6a0` 对 item 发 `setBadgeViewHidden:YES` |
| `MMTabBarItemView setBadgeViewHidden:`，起点 `0x104727298` | `0x104727298–2ac` 取原生 badge ivar 并直接转发 `setHidden:` |
| `MMTabBarItemView showSmallRedDot`，起点 `0x104727694` | 对原生 badge 设置 small dot 与可见状态，再调用 layoutIcon；若项目 hook 在上游 return，该原生显示过程根本不执行 |

ABI 也已核对：metadata 中数字 setter `v32@0:8Q16Q24`、字符串 setter `v32@0:8@16Q24`、show/remove 红点 `v24@0:8Q16`，与 hook 的 `v@:QQ`、`v@:@Q`、`v@:Q` 参数类型吻合。`CSCloseFriendSignatures.m:9–16` 按 `NSMethodSignature` 比较返回/参数类型，忽略栈布局数字；`CSCloseFriendBridge.m:59–64` 安装时还要求 runtime 方法存在且 original IMP 非空。**静态 ABI 匹配说明能通过这道门，不等于已经观察到设备上安装成功。**

## 样式维度的影响范围

这条**数值过滤路径**不读取底栏样式 enabled、无文字/保留文字、系统/自定义图标、紧凑/悬浮、深浅色或选中状态。对同样的策略、快照状态与 setter 输入，它在这些组合中作同样决定。下面区分源码推导与设备观察，避免把未实测组合写为必现。

| 维度 | 此路径的源码结论 | 本次设备证据 |
| --- | --- | --- |
| 底栏样式开/关 | 没有条件依赖；关样式不能在源码上阻止过滤 hook | 新补充中尚未完成开/关对照 |
| 系统/自定义图标、文字保留/隐藏 | 不参与数值决策；几何效果另查 | 未记录具体组合 |
| 紧凑/悬浮、深浅色、选中/未选中 | 不参与数值决策 | 未完成矩阵观察 |
| 微信会话页 tab | 能被 `ChatTab` 匹配；不依赖固定 index | 冷启动有数字，新消息后消失 |
| 通讯录/发现 | 不匹配会话页类型，透传原生输入 | 用户补充正常 |
| “我”、额外/临时 tab | 仍按实际 root class 匹配，非会话页透传 | 未观察 live tab 数与 root 类型 |
| 数字、99+、原生字符串 | 只要 getter 返回 @0，相应 setter 会送 0/nil 并原生隐藏；正数走过滤总量 | 最新具体反馈仅确认微信数字；99+ 未验证 |
| 纯红点 | @0 阻止 show；`count=0, redDot=YES` 也存在信息丢失条件 | 未验证此次是否命中 |

不能由此宣称“所有样式必现”。能确定的是：如果本次命中该写值路径，修改图标尺寸、偏移或背景层 z 序无法让 `hidden=YES` 的原生 badge 显示。

## 现有测试覆盖与局限

只读核对 `Tests/CloseFriendAlertTests.m:195–208` 与 `verify-close-friend-alerts.sh`，本项没有修改/运行测试：

- `:199,206` 验证过滤后数字总量为 3/5，并验证不修改原始 row unread。
- `:200–203` 验证同 revision 缓存复用与折叠名单 cache key 更新。
- `:207–208` **明确将 epoch 失配、revision 失配的结果断言为 `@0`**，随后 disabled policy 断言为 nil。这证明该零回退不是本轮推测；也说明现有测试主动接受这个返回协议。
- 脚本提取生产 `closeFriendAlertBadgeCount` 方法，通知输出测试只提取 `Silent`、`RemoveKnown` 与 UNNotification 入口。它未提取或执行三个 `MMTabBarController` tab hook，也未验证“原生输入非零 → 无效快照 → hook 输出零 → native hidden”的事件序列。
- 测试 owner/sections 是 host 替身，不证明真机调用顺序、原生 badge 层级或实际用户策略。没有把替身视图层级当成原生证据。

## 还需要的最小运行证据

在不记录消息内容、联系人原文、密码、密钥或数据库数据的前提下，围绕一次“冷启动角标可见 → 普通新消息 → 消失”采集事件序号/单调时间与以下字段。先观察，再决定改哪个组件。

| 边界 | 必要字段与判断用途 |
| --- | --- |
| hook 安装 | 三个 tab selector capability、runtime 类型编码、目标镜像 version/UUID；排除未安装或其他版本 |
| 原生输入与项目输出 | 方法名、主线程标记、index、root class、入参 count/string 类型与长度或数值、`ChatTab` 结果、getter 是否 nil/零/正数、传给原生的最终值；确认是否真实改写非零为零 |
| 密友策略 | blocked/enabled/revealed、保护集合数量、hideSessions/silenceMessages、account 仅同一性标记、policy revision、当前 epoch；区别不介入、预期过滤为零与错误回退 |
| adapter 状态 | adapter 数、是否折叠、cached sections 有无、changeDepth/dirty/presentationSuspended/publishing、model/snapshot revision、snapshot/current epoch、account 相等性、group enabled/searching；标记 getter 具体返回原因 |
| 消息/刷新顺序 | begin/end native change、setter、refresh 开始/成功/跳过原因及下一次 setter 的事件序号；验证实际 setter 是否发生于无效窗口，刷新后是否重发 |
| 最终原生对象 | 同一 badge identity、hidden/alpha/frame/superview class、item bounds、祖先 clips/hidden/alpha；输入输出不被改写时再判断几何、裁剪或遮挡 |
| 对照 | 同一策略/图标/文字/布局/选中状态，开关底栏样式各重复一次；微信、通讯录、发现、“我”分别记录；无需更改密友策略或用户数据 |

可确认本次根因的充分观察应至少包括：①原生入参非零/有显示请求，②该 hook 将它转成零/nil或 return，③getter 的明确返回原因，④原生同一 badge 随后 hidden=YES（或 show 根本没有执行）。若入参输出相同且 badge.hidden=NO，就应沿布局/裁剪/覆盖方向继续查，而不是修改密友过滤策略。

## 最小改动方向（候选，不实施）

若日志确认是**快照暂不可用被当成零**，修复边界应是“未读总量的状态协议及更新完成后的发布”，保持原生 badge 对象和隐私过滤规则。需区分“不介入 / 待定 / 已知过滤总数”，把待定状态与真实零分开，并在可靠新会话状态完成时以事件发布一次最新过滤结果。不能简单把所有 `@0` 改成 nil：真实零有意屏蔽密友未读；blocked/账号边界也不能透传旧账号的原生总数。具体待定状态保留/发布规则须基于日志与安全语义确定，不能借修角标改动密友行为。

若日志确认是**合法红点状态被数字 count=0 覆盖**，修复边界应保留 `{numeric count, redDot}` 两个原生显示条件，分开决定数字和红点入口；不新建 badge、不改原生形状、不手动 hidden=NO。仍需确认微信会话主 tab 的原生红点输入在该用户模式下确实发生。

若日志显示**过滤完全未介入**（结果 nil，或输入输出一致），本报告不能支持修改通知/会话组件。应根据同一原生 badge 的 frame、hidden 和祖先层级证据定位底栏适配；不通过扩大图标、隐藏背景或加延时掩盖现象。

本项不出修复包，不提前顺延版本；待主报告合并几何/测试核对及运行证据后再决定改法。
