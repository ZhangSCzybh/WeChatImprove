# 2.1-8 源码复核与真实 refresh 生命周期验证

本复核确认：`closeFriendTabBadgeDecisionForPublication:` 将“普通原生输入是否接管”和“恢复时是否有可靠数字/纯红点来源”分开；分组 All 的计数规则保持既有投影语义。真实 `refresh` 的非投影分支与 `@finally` 现在可以完成“最后一个保护对象被清空、分组关闭、原生总数为 0”的纯红点来源恢复，同时冷空名单不会仅为 tab 获取快照或发来源事件。

本子任务只改动两个 lifecycle 测试文件及本审计记录，未改生产、`CloseFriendTabBadgeTests.m` 或 `verify-close-friend-alerts.sh`。下面的 host 结果证明实际抽取的生产控制流和不可变行投影，不是已完成真机验收的声明。最终 Hooks marker 补丁、全仓范围和包哈希由主任务统一核对。

## 复核版本与依据

这是明确的源码快照审查，后续生产改动应以主报告的最终范围/哈希为准。

| 文件 | 本轮审查 SHA-256 |
| --- | --- |
| `Controllers/CSGroupListAdapter.h` | `71f845953bbf16c1d1732f042a3064b22596472a1503c5adb73a6c2e570d60ec` |
| `Controllers/CSGroupListAdapter.m` | `e5e41ede849a82197144715c0767d98a4b153ff4aadb07c2e7288e9d9ee72599` |
| `Controllers/CSGroupProjection.m` | `c16febd6db38a37146f3b6d8b62ec01ac36daf2f1b9a880d73c1ce6e255ba34d` |
| `Hooks/CloseFriendNotificationHooks.xm`（审查到恢复 marker 落地、自然 nil 成功清债补丁之前） | `59fe19c8434021671221bd396e246d4e60543319b6211dbee3e8e7921eff575a` |
| `Tests/GroupLifecycleTests.m` | `137593ebef301ed54ab311ca2178198b459f0d153a8bc6ed3d1ee5c9fb857e07` |
| `Tests/extract-group-lifecycle.py` | `5723ac4c16ff57c27b80817b234d2189b98206caeea6b55ca4d413fa6d9b9bf6` |

更完整的原有分组/密友语义和微信 8.0.78 静态限制见 [semantic-audit.md](semantic-audit.md)。本轮继续引用已保存的 [8.0.78 原生静态证据](../tabbar-wechat-badge-2.1-6-2026-10-29/native/README.md)，没有将 host 替身的 view 层级当作真机层级，也没有再次运行或虚构设备日志。

## Adapter 与真实发布链

1. `Controllers/CSGroupListAdapter.m:224` 的普通 getter 委托 `ForPublication:NO`。非 blocked 且保护名单为空、揭示状态、密友功能关闭或 Session 隐藏关闭时返回 nil，原生输入继续保有其含义；blocked/账号不匹配返回 boundary，无可靠源返回带账号/epoch/revision 的 pending，没有将 unavailable 伪装成真实的数字 0。
2. `Controllers/CSGroupListAdapter.m:227` 的 publication 路径允许计算“未过滤的原生数字/纯红点来源”，没有据此扩大普通 setter 的接管范围。它仍要求主线程、主列表 owner、原生 sections 已存在、无 dirty/transaction、model/snapshot revision 和账号 epoch 一致，计算结束再次检查账号、epoch、policy revision 和 transaction 状态。
3. `Controllers/CSGroupListAdapter.m:587` 的非投影路径继续关闭分组 UI。只有当前策略可读、同账号，且“保护名单非空或此 adapter 已有 tab 来源”时读取 native snapshot。因此揭示状态/分组关闭仍能恢复纯红点；已有来源后清空最后一个保护对象也保有一次可靠恢复所需的行来源。冷空名单从未接管时不额外建 tab 来源。
4. `Controllers/CSGroupListAdapter.m:678` 的 source gate 另检查“当前保护名单非空或已有 tab 来源”，防止冷空名单即使启用过分组也仅因普通分组快照而产生 `tabAlertBadge`/来源事件。新增 host 用例实际覆盖了冷空名单的“分组关 → 开 → 关”。
5. 来源事件位于真实 `@finally`，所以非投影分支的 `finished=YES; return;` 仍会到达它。事件发生在 `publishing=NO`、completion/native-action 处理和 dirty 调度之后；只有 finished、无 dirty、无 changeDepth、非 folded 且 getter 给出 verified badge 时才发出。若回调再次弄脏模型或开启原生事务，此次事件被 gate 拦下。
6. 专用 `CSGroupTabBadgeSourceDidRefreshNotification` observer 只调用 tab 发布，不调用通知清理、app-icon 更新或再次请求列表 refresh。它不依赖“下一条新消息”来补上可靠源。既有策略通知仍承担自己的通知/app-icon 工作，二者没有混成一个循环。

## 原生 owner/index、数字与纯红点边界

复核的 Hooks 快照按实际 `viewControllers` 查找 `NewMainFrameViewController`，再按同一 owner/index 取得原生 item/badge；不是固定写第 0 项，也没有限制只能存在四个 tab。native 恢复直接读取目标 root 的 `m_mainFrameLogicController.getTotalUnreadCount`，先核对返回 ABI `I@:`，再调用该 owner/index 的原生 number/dot API。

这样绕开了已保存静态证据中 `NewMainFrameViewController.updateUnReadCount` 的“写全局 tab 0、仅数字”限制：数字为正使用原生数字；原生总数为 0 时，必须有经过 account/epoch/revision 验证的不可变行来源，才能决定恢复纯红点或真实零。没有来源的零不能证明原生无红点。

复核快照中的 display marker 区分了“显示值仍可信”和“仍欠一次原生恢复”，Pending 只允许同 root/item/badge、同 account/epoch/policy token 的显示继续保留；marker 本身不能授权复用旧账号内容。恢复目标改变、账号边界或同步重入由后置检查失效处理；内部原生写入绕过只消费同 owner/index/selector 的一次调用，并在 `@finally` 还原。

本复核曾指出“自然原生 nil passthrough 成功后旧 marker 仍在，下一来源事件可能重复恢复并盖掉微信新写的原生 string/dot”这一收尾问题。主任务已另行委派 Hooks agent 与测试 agent 补自然输出成功清债及对应覆盖。本文件没有把上述 SHA 对应的较早快照当作该补丁已经验证；这部分最终差异由主任务审计。

## 分组语义与本轮范围

`Controllers/CSGroupProjection.m:68` 对 `redDot`/aggregate/business 行不加数字；`CSGroupProjection.m:74` 仅对 `unreadCount > 0 && redDot` 提供 dot。`CSGroupProjection.m:275` 在行进入计数/成员关系之前过滤实际隐藏名单；数字做饱和求和、dot 做 OR，渲染时数字为正优先。tab getter直接复用此投影与其既有 folded 规则，没有重写一套“native total 减名单 unread”的算法。

隐藏时排除受保护行、揭示时计回这些行，符合分组现有行为。`silenceMessages` 在通知/app-icon getter 中维持原有作用，不再被拿来决定 tab 的 Session 可见计数。分组本身的 selection、列表投影、badge 数学、样式图标尺寸、原生 badge 对象及布局代码均不在本子任务修改范围内。

`redDot` 是原生“以点呈现”的行标记，本轮静态与 host 证据不证明它等于免打扰设置，也不证明免打扰 @ 提醒的每个原生写入路径。真机验收仍需分别制造免打扰普通消息与 @ 提醒；不能把 host `redDot=YES` 用例命名为已经验证了真实 DND 规则。

## Lifecycle fixture 调整、红绿与日志

修改前，原 lifecycle fixture 未声明新增 decision/notification 依赖，生产 `@finally` 被提取后编译错误为：未知 `closeFriendTabBadgeDecisionForPublication:`、id 无 `badge` 属性、未声明 `CSGroupTabBadgeSourceDidRefreshNotification`。这是测试依赖编译缺口，不能冒充行为红测。

本次没有用永远返回 nil 的 stub 隐藏新路径：

- `Tests/extract-group-lifecycle.py:24` 直接提取生产 decision interface/class、notification 常量和两个 getter，和原有真实 non-projection refresh/完整 `@finally` 一同执行。普通昂贵的 UI 发布仍使用既有 `publishFixture`；原生行读取、账号、视图宿主为受控边界。
- `Tests/GroupLifecycleTests.m:47` 增加可控保护名单、原生不可变行来源、真实投影所需的 folded-unknown 边界。该 fixture 没有 aggregate 行；这个未知 folded 替身不用于宣称已覆盖真实 folded membership。
- `Tests/GroupLifecycleTests.m:347` 将旧“关闭分组永远不读取 snapshot”断言改为准确行为：该旧 fixture 一直保留 `secret` 保护名单，现在关闭分组仍需要可靠 tab 来源，但不能激活分组。没有删除该场景或其他旧生命周期断言。
- `Tests/GroupLifecycleTests.m:537` 起增加冷空名单分组关/开/关无 tab 来源 ownership，以及“曾过滤纯红点 → 列表被覆盖释放 snapshot → 清空最后名单且分组关闭 → 仍遵守 offscreen suspension → 返回仅构建一次 native 来源 → publishing/dirty/depth 清空后发一次 verified-dot 事件”的覆盖。最后检查普通 getter 仍是 nil 原生透传。
- 对没有新增 tab API 的旧控制源码，extractor 保留兼容分支并跳过依赖该 API 的新增场景；没有将新 API 硬塞给旧代码。

| 验证 | 结果 | 证据 |
| --- | --- | --- |
| 当前真实 production refresh + getter + projection 的 lifecycle 回归 | **113 checks，0 failures**；hidden native event publications **0/20** | [完整日志](logs/verify-group-lifecycle.sh.log) |
| 单条件变异控制：只在隔离 adapter 副本撤回非投影分支的 `|| self.tabAlertBadge` | **113 checks，2 failures，预期失败 exit 1**；精准失败于最后名单清空后 snapshot 恢复和真实 finally 的 dot 来源事件 | [红测日志](logs/group-lifecycle-last-name-marker-red.log)、[隔离控制源码](red/group-lifecycle-last-name-marker-control.m) |

该红测是明确标记的单条件变异控制，证明新增断言能抓住前述漏项；不是 2.1-6 原包/真机日志，也没有改动当前生产来制造失败。最终绿色日志由脚本完整捕获 stdout、stderr 和 exit code，未以手写输出替代。

被改测试原文在写入前保存到 [baseline/Tests/GroupLifecycleTests.m](baseline/Tests/GroupLifecycleTests.m) 与 [baseline/Tests/extract-group-lifecycle.py](baseline/Tests/extract-group-lifecycle.py)，逐一与本任务 602 项原工作区 SHA 清单比对通过：分别为 `f35382e0c35d6f0378afc7c720403d6f81b0ee37ab7cdd968d887d8262d773fd`、`2bda131e0d4a93622c9602125d0c6e0445d3568d311fc5f1de365f9a7932d489`。没有使用 Git HEAD 代替用户指定基线，没有触碰历史产物。

本子任务未执行双架构编译、打包或全量回归；这些由主任务统一执行并记录，避免多任务同时改动构建状态。此处没有把其他 agent 的测试结果混写成本子任务运行结果。
