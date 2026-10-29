# 微信数字角标：保护名单触发条件与零值回退的历史依据

日期：2026-10-29。工作区：`/Users/zhangshichao/Documents/Workspace/WeChatImprove`。分析对象为恢复至授权清理后 **2.1-6** 的源码，微信静态证据版本为 **8.0.78**。本项只增加本文件及 `history/` 证据，不修改生产代码、Tests、旧报告、版本或包，不编译、安装、操作账号或执行设备探针。

本项根据新增用户反馈展开：**选择任意密友或保护群后，微信 tab 数字角标消失；清空名单后恢复。** 这是用户报告的稳定触发条件；本项未自行在设备重现，也未补齐当时的策略选项、普通未读数量和 setter 日志。

## 可以确定的三件事

1. **排除受保护会话的静默未读是有意设计。** 首次实现的测试同时放入受保护会话未读 8、普通会话未读 3，要求结果为 **3**，并断言受保护会话的真实 unread 仍为 8。有效来源下保留普通数字未读同样属于原有契约。
2. **来源不可靠时返回 `@0` 也是有意设计。** 首次实现即测试 epoch/revision 失配返回零；当次交付文档明确写出 “Unknown/dirty/blocked source displays neutral zero”，允许来源过期、未知或未加载时**暂时**少显示普通未读。它并非本轮代码清理或底栏样式临时引入的无意分支。
3. **“名单非空就持续清掉全部普通未读”不是上述两项的直接要求。** 当前名单非空会使读取从原生透传进入过滤路径；进入之后如果可靠主会话快照无法取得，或快照恢复后没有相应输出更新，保守零值便可能成为持续可见的结果。这是跨组件的快照供给及角标发布问题，不能仅凭看到 `@0` 就断定应改成 `nil`。

这里的“有意”指 Git 中可核对的实现、测试和交付记录。它不证明原始人类沟通已逐项批准这些取舍，也不代表这些路径曾通过真机验收。

## 引入和延续记录

| 时间 / commit | 代码与记录 | 能证明什么 |
| --- | --- | --- |
| 2026-10-20 22:40:28 +08，`f747a6a476d1ead2d9578840bd1ee6e4549d830d`，`feat: add identity-bound close-friend alert and call privacy` | 同次添加 `closeFriendAlertBadgeCount`、tab 数字/字符串/红点 hook、策略 observer，以及普通未读保留和过期零值断言 | 过滤总量和保守零值是一起设计的；不是后来只加了一个兜底 |
| 2026-10-20 22:59:14 +08，`6987c113b5b739d745ecd23709d4d3c350de3056`，`feat: integrate close-friend privacy and package 1.8-42` | 交付 README、任务 6 报告、实施决策、待验证验收表明确说明可靠来源与中性零值 | 可以独立核对当时记录的设计意图及验证边界 |
| 2026-10-21 15:20:18 +08，`d35c3e002c7dc1f08e2c34f9467c973a7280437f`，`perf: optimize close-friend filtering and remove automatic DND in 1.8-58` | 将 gate 改为当前的 filtering + protected count，增加 badge 计算缓存，保留各类无效来源返回零；缓存命中仍放在来源有效性校验之后 | 性能优化没有把未知来源放行，也没有取消普通未读保留的目标 |
| 2026-10-26 09:51:17 +08，`571b80a8ba3bceb3c0ddf260d8b6bccaafb1e64d`，`修复备份恢复、密友隐私与分组角标，更新至 2.0-10` | 与组条角标等逻辑有关；已保存相关 diff | 当前 getter 的零值契约和这组 tab hook 的 blame 仍回到前两次源码提交，不能把它们归因于 2.0-10 或本轮授权清理 |

搜索使用 `git log --all -S closeFriendAlertBadgeCount`、`-G 'return @0|silenceMessages|protectedUserNames.count'`、getter 的 `git log -L`，再对当前 getter、hook、测试及旧交付记录做 `git blame`。命令及精确输出见 `history/manifest.json`；没有仅按 commit 标题推断行为。

## 原始设计文字与测试

`6987c113` 中 `docs/audits/close-friends-1.8-42/task-reports/task-6-report.md:12`：

> `CSGroupListAdapter` exposes a minimal alert badge accessor over its validated native sections, account, epoch and source revision. It uses the existing CSGroupProjection semantics and excludes folded-controller duplicates. `silenceMessages` contributions remain excluded while revealed; `showBadges` never authorizes unread exposure. **Unknown/dirty/blocked source displays neutral zero.** App icon, local request badge, and confirmed chat-tab numeric/string/dot output use it. Existing observed chat tabs are refreshed on policy changes. Original unread values are unchanged.

同一报告 `:52`：

> A neutral badge can **temporarily undercount ordinary notifications** when the current main-list source is unavailable, stale or has unknown aggregates.

`6987c113` 中 `README.md:22`：

> 公开角标使用同一会话数据源排除静默贡献。真实消息、未读、同步和入库流程保留。

同文件 `:32`：

> 会话来源过期、未知聚合或尚未加载时，公开角标暂时显示中性值，可能少显示普通未读；不会通过清除真实未读来隐藏密友。

`delivery-decisions.md:6` 另有同义决策：角标依赖经过校验的主会话来源，在未知状态下可以少计普通贡献。`device-acceptance.md:22` 的 S02 要求“可靠来源下可见角标准确，不重复扣减；未知/过期聚合允许中性值，真实未读未被清除”，但结果列为 **待验证**，不能用作真机已通过的证据。

首次源码提交 `f747a6a4` 的 `Tests/CloseFriendAlertTests.m:170–176` 已包含：

```objc
// The validated owner excludes protected counts while revealed; folded owner never doubles totals.
// owner: friend unread=8, ordinary unread=3, aggregate unread=10
CHECK([[CSGroupListAdapter closeFriendAlertBadgeCount] isEqual:@3]);
CHECK(((CSGroupRow *)owner.cachedNativeSections[0][0]).unreadCount==8);
owner.snapshotEpoch--;
CHECK([[CSGroupListAdapter closeFriendAlertBadgeCount] isEqual:@0]);
// epoch 恢复后，modelRevision 增加而 snapshotRevision 不增加
CHECK([[CSGroupListAdapter closeFriendAlertBadgeCount] isEqual:@0]);
// policy disabled
CHECK(![CSGroupListAdapter closeFriendAlertBadgeCount]);
```

以上为便于阅读的摘录，省略初始化和恢复语句；逐行原文保存在 `history/f747-tests.txt`。当前测试 `:195–208` 保留这些语义，另补同版本读取缓存复用、折叠名单变化，以及可靠新来源 ordinary=5 时结果为 **5**。故不能把“保护名单有成员”解释成“普通数字未读也应当全部隐藏”。

## 新反馈为何把焦点指向过滤入口

当前 `Controllers/CSGroupListAdapter.m:183–210` 的入口是：

```objc
BOOL filtering=[policy concealsSurface:CSCloseFriendSurfaceSession]
    || (policy.enabled && [policy.options[@"silenceMessages"] boolValue]);
if(!policy.blocked && (!filtering || !policy.protectedUserNames.count))return nil;
```

| 状态 | getter 的意义 | 对原生 tab 输入的影响 |
| --- | --- | --- |
| 未 blocked，名单为空，或无需过滤 | `nil` | tab hook 透传微信原 count/string/red-dot 调用 |
| 需要过滤且名单非空，有可靠主会话来源 | 非空数字，包括确实为零的结果 | 使用排除受保护贡献后的数字总量 |
| 需要过滤且名单非空，没有可靠来源 | `@0` | 数字被替成 0、字符串被替成 nil；红点 show 被阻止 |
| blocked | 保守零值，不适用上述空名单透传 | 保持账号/策略边界的保护 |

名单由空变为非空会打开过滤入口，**但不会不经计算就直接指定所有角标为零**。默认设置或用户反馈本身也不能证明当时 `enabled / revealed / hideSessions / silenceMessages / blocked` 的具体组合。

`Hooks/CloseFriendNotificationHooks.xm:104–112` 只对 root class 为 `NewMainFrameViewController` 的 tab 替换值，这与“微信数字消失，通讯录和发现正常”的用户补充相符。对应数值为零后微信原生设置 badge hidden 的 8.0.78 静态闭环见上一份 `notification-analysis.md` 及本目录 `native/`，本项不将其当成设备已经抓到的调用。

名单清空后，在未 blocked 的条件下，**后续原生调用**可以透传。因此清空后恢复与入口条件一致。但策略 observer 在 getter 为 `nil` 时会直接结束，不会主动将上一次原生总量重发给 tab；“清空立即恢复”究竟由哪个后续原生事件完成，仍需事件日志，不能声称 observer 自己恢复了数值。

## 哪些集成问题能够使普通未读持续消失

当前源码可证明以下条件路径；本项未据此选定用户设备实际命中的那一条：

1. **设置页修改名单时，主列表来源可能处于离屏失效状态。** `SessionGroupHooks` 的页面生命周期可将主会话 adapter 置为 `presentationSuspended`，adapter 清掉快照。策略 observer 会主动计算并写 tab；若此时没有其他可靠主会话 adapter，就会写入零。observer 与列表策略刷新 observer 的运行顺序及现场 adapter 状态未实测。
2. **过滤需要与快照维护的启用条件并不完全一致。** `CSGroupPrivacyActive:17–19` 只包含 blocked，或 `enabled && !revealed && hideSessions`，不包含单独的 `silenceMessages`。若过滤因静音仍然需要、保护名单非空，但 privacy 不活跃且聊天分组未开启，`refresh:532–543` 会清掉 `cachedNativeSections` 并结束。getter 仍要求可靠快照，只能返回零。这类配置可形成持续不可用，不能全部概括为偶发竞态。
3. **原生未读通知的同步输出落在失效窗口。** `SessionGroupHooks:200` 使用 `NativeNotification`；它先使快照失效、`changeDepth++`，再调用原生通知。已保存的 8.0.78 静态链证明原生 `onSessionTotalUnreadCountChange:` 同步调 delegate `updateUnReadCount`，后者同步写 tab 数字。若当前 adapter 是唯一可靠来源，该 setter 取值时会被 getter 排除。`endNativeChangeCoalesced:` 之后才安排列表刷新。
4. **可靠来源恢复与原生底栏角标重新发布未形成项目内闭环。** 成功 refresh 的 `chrome updateUnreadCount:` 更新的是聊天分组条；引用分析未找到在该成功点重发原生 tab 角标的项目调用。项目的主动 tab 重发在策略 observer。微信之后是否另发 setter 以及何时发，需要日志；因此这里证明的是项目缺少相应主动衔接，不能扩大成“微信永远不会再更新”。

这些条件与原有局部保守策略可以同时成立：局部返回零符合来源契约，而上层长期不能提供可靠源或不能重新发布正确结果，会造成整体功能缺陷。若要判定此次普通数字未读错误丢失，至少要确认有**非保护会话的数字未读 >0**，并区分来源尚未可靠、来源始终未维护，以及来源恢复但 tab 未更新。仅看到原生总数 >0 还不够；其全部贡献可能属于保护对象，或来自当时无法可靠归属的聚合。

## 不应据此直接确定的改法

把所有“无可靠来源”的 `@0` 改为 `nil`，会同时改变历史明确保留的隐私边界，让未知分类、账号切换、blocked 状态或包含保护贡献的原生总量重新透出；这不属于已证明正确的最小修复。改为保留旧值也需要证明旧值仍属于当前账号、epoch、策略和来源版本，不能复用跨边界结果。

更精确的下一步是按事件区分入口过滤、来源有效性、来源重建及原生输出：先记录名单非空时 getter 的具体拒绝原因，确认普通未读贡献与重建完成后的结果，再决定是否修补独立的角标来源维护条件及其输出衔接。无需改原生 badge 对象、形状、数值的微信存储，也无需先调整底栏图标几何。这里只给出定位边界，不提出未经验证的生产变更。

## 历史验证缺口与证据保存

原任务 6 报告 `:37` 明确说明执行的是 Foundation adapter、实际 UN 提交通知 hook，以及新 badge accessor。当前 `Tests/verify-close-friend-alerts.sh:11–28` 同样只提取 getter 与部分通知输出代码，未执行三个 tab setter hook 和策略 observer 的原生生命周期组合。因此单元测试覆盖了“有效来源保留普通计数”和“过期回退零”，没有证明“名单设置 → 离屏来源失效 → 写零 → 来源恢复 → tab 更新”这一链条。替身对象也不证明设备原生层级或真实事件顺序。旧 S02 真机项仍为待验证。

`history/` 保留 13 份命令输出、9 份带原 blob OID 和行号的摘录，以及 `manifest.json`。manifest 记录命令、退出码、输出 SHA-256、摘录来源 commit/blob/hash，并记录 6 个源码/测试输入及 5 个旧报告的读取前后 SHA-256；采集时全部一致，`inputs_unchanged: true`。`HEAD` 摘录对应 manifest 中的 `7ff8a17d8e2ff1af6077b4246d36eb870e5e6620`，不将此提交号误写成 2.1-6 的发布提交。报告核对期间也没有改动这些输入。

本项未执行回归、构建或设备探针，不新增版本或包；现有静态与历史证据足以确认设计契约及集成风险，仍不足以把用户现场某一条条件路径写成已经抓到的运行事实。
