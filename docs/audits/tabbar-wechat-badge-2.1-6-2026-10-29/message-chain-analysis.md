# 2.1-6 微信 tab 未读内容链只读分析

日期：2026-10-29。基线：当前工作区的 2.1-6 授权清理交付；此前 2.1-7 修改已由主任务撤回。本子分析只读生产源码、现有测试源码与历史静态证据，只新增本记录，没有修改 Controllers/Hooks/Headers/Tests，没有运行测试、构建、打包或启动微信，也没有读取用户会话、账号配置或消息数据库。

本次新事实由用户提供：**微信 tab 冷启动有数字，收到消息后消失；通讯录和发现正常；关闭底栏样式后的结果待验。** 下文不能据此假定用户开启了密友、静音、会话隐藏、揭示或会话分组，也不能假定原始未读确实被清零。

## 1. 源码已经证明的结论

**存在一条只针对“微信”tab 的内容替换路径：密友过滤需要生效时，插件可把微信传来的正数 count 改成非 nil 的 `@0`，把 badgeString 改成 nil，并阻止原生红点展示。它同时依赖会话分组 adapter 的快照是否可用。会话更新事务会主动令该快照暂时不可用，事务结束后的普通分组刷新又没有显式重写底部微信 tab，因此“原始未读仍在，但底栏角标被写零后未恢复”是源码可成立的路径。**

已证明的是上述条件路径，不是用户现场已经触发了它。原生收到消息后究竟在哪一条回调、哪个线程、哪个时刻写底栏，仍须原生静态核对或运行日志闭环，不能凭函数名声称同步。另有不依赖事务的红点信息丢失候选：过滤总量只返回数字 `.count`，忽略可见投影 `.redDot`；即使快照有效，只有红点型未读时也能得到 `@0`。

分组顶部 UI 的“隐藏全部角标/隐藏分组角标”只清自己的顶部 `WETabButton`；未找到它们直接写底部微信 tab 或原生 `MMSessionInfo.m_uUnReadCount` 的生产路径。**要区分“顶部投影里置零”和“底部 setter 实际被替换为零”。后者集中在 `CloseFriendNotificationHooks.xm`。**

## 2. 原始未读、可见未读和角标不是同一个量

| 层次 | 读写对象 / 来源 | 本仓库行为与证据 |
| --- | --- | --- |
| 消息接收 | `CMessageMgr.AsyncOnAddMsg:MsgWrap:` | AI Hook 在 `Hooks/AIReplyHooks.xm:18` 先调用原实现，随后异步交给 AI；收款 Hook 在 `Hooks/ReceiveTransferHooks.xm:17` 先 `%orig`，再把消息交支付处理。接收 Hook 本身没有写 tab 数量或原始未读。两 Hook 的安装先后不靠源码顺序猜测。 |
| 原生 session 未读 | `m_uUnReadCount`、`m_bShowUnReadAsRedDot` | `Controllers/CSGroupNativeBridge.m:458` 读取当前 session，复制到 `CSGroupRow`；折叠子会话在 `:402` 同样只读。原始 count 与 dot 展示标记分开。 |
| 原生未读汇总 | `MainFrameLogicController.getTotalUnreadCount` | 分组顶部“全部”在无 session 隐私过滤时读取该 getter（`CSGroupListAdapter.m:583`）；源码没有 Hook 该 getter，也没有把顶部投影总量回写原生汇总。其与 `MMNewSessionMgr.GetTotalUnreadCount` 的原生调用关系应由原生证据确认，头声明不足以证明。 |
| 分组 / 隐私可见未读 | `CSGroupProjection` 的 `.count`、`.redDot` | `CSGroupProjection.m:68`：红点模式、聚合入口、业务入口不贡献数字；`:77`：只有原始 unread>0 且原生 dot 标记为真才贡献红点；`:276` 隐藏成员不参与可见投影。数字 0 不等于完全没有可见未读。 |
| 顶部会话分组角标 | `WESessionTabContainerView/WETabButton` | `CSGroupListAdapter.m:589` 发布 `count/hasRedDot` 到自己的 chrome；`WESessionTabContainerView.m:204` 同时考虑两者决定 hidden，`:488` 更新顶部按钮。不是 `MMTabBarItemView`。 |
| 底部微信 tab 内容 | `MMTabBarController` value/string/dot setter | `Hooks/CloseFriendNotificationHooks.xm:105`、`:108`、`:111` 可替换/拦截；这是原生 badge 对象走布局前的内容层边界。 |

在 Controllers/Hooks/Headers 中定向搜索 `setM_uUnReadCount`、`m_uUnReadCount =`、按该 key 的写入、原生未读清理 selector、所有 tab badge setter，没有发现会话分组生产实现把真实 session 原始 count 写成 0。`CSGroupProjection.m:282` 和 `:295` 新建的是插件 `CSGroupRow` 表示对象；`CSGroupNativeBridge.m:333` 的 `CSFoldedDigestSessionInfo` 也是独立格式化快照，不被插入原生 manager。这一结论不排除微信自己的阅读/同步逻辑改变原始未读。

## 3. 接收 → 原生通知 → 分组快照失效窗口

当前源码能证明的顺序如下：

1. `AsyncOnAddMsg:MsgWrap:` 的两个插件 Hook 都保留原实现与原参数。AI 回调另行排主线程，不把网络或文件 IO 插进原接收方法（`AIReplyHooks.xm:18`）；支付 Hook 在原实现返回后才调用 `CSPaymentAdmitMessage`（`ReceiveTransferHooks.xm:17`）。本仓库没有实现完整微信接收/汇总算法。
2. 微信进入下列已 Hook 的会话回调时，插件包裹原始调用：`NewMainFrameViewController.newMessageByContact:msgWrapToAdd:`、`updateSession:`、`logicUpdateSession:`（`SessionGroupHooks.xm:93`、`:94`、`:100`）；`MainFrameLogicController.onSessionTotalUnreadCountChange:`、`onSessionChanged:`（`:200`、`:201`）。
3. `NativeNotification` 先拿 owner 或其 `m_delegate` 对应的 adapter，只有找不到有效 table 才直接透传；有 table 时不要求“会话分组 enabled”或“底栏样式 enabled”，先 `beginNativeChangeOfKind:`，再原始 body，最后 `endNativeChangeCoalesced:YES`（`SessionGroupHooks.xm:34`、`:46`）。
4. `beginNativeChangeOfKind:` 先递增 `modelRevision`，再增加 `changeDepth`（`CSGroupListAdapter.m:762`）。因此原始 body 执行期间，该 adapter 至少同时处于 `changeDepth>0` 和旧 `snapshotRevision!=modelRevision` 状态；这两个条件都会令密友角标汇总拒绝该快照。
5. 最外层 end 才减回 depth，并请求合并刷新（`:774`）。`requestCoalescedRefresh` 置 `dirty=YES`（`:747`）；`scheduleRefresh` 保持 dirty，并对普通通知合并 80ms（`:707`、`:718`）。这段既有合并时间是本次观察的源码事实，没有新增延时。
6. 若页面被覆盖、后台、正在拖动/减速/编辑、侧滑菜单未收拢等，普通 `refresh` 会继续保留 dirty 或推迟发布（`:492`、`:497`、`:499`、`:505`）。离开主列表会清除缓存快照（`:157`），应用活动状态变化也会清快照并置 dirty（`:246`）。
7. 安全发布时 `nativeSectionsForAccount:` 重新读原生 sessions，验证 epoch/revision/account 后保存快照（`:468`）；`refresh` 清 dirty 并发布顶部 chrome/列表（`:507`、`:583`、`:593`）。这不是底部 tab 计数的主动恢复。

**仍待闭环的边：**`CMessageMgr.AsyncOnAddMsg` → 原生未读累加/汇总通知的具体路径；以及这些 `%orig` 是否同步或异步到达 `MMTabBarController` 三个内容 setter。源码只能确定：如果 native setter 在 changeDepth 或 dirty 窗口被调用，密友汇总会怎样处理；不能仅凭此表断言所有新消息必然在该窗口写底栏。

## 4. 底部微信 tab 的实质替换点

`ChatTab(controller,index)` 先读取 controller 的 `viewControllers`，导航项取第一个 root，只有 root 是 `NewMainFrameViewController` 才为真（`CloseFriendNotificationHooks.xm:27`）。它没有硬编码 index=0。这个识别解释了**候选路径为何可以只影响微信 tab，而不碰通讯录/发现**；识别是否在用户现场成功仍须日志确认。

| Hook | `closeFriendAlertBadgeCount` 返回 nil | 返回正数 NSNumber | 返回 `@0` |
| --- | --- | --- | --- |
| `setTabBarBadgeValue:forIndex:`（`:105`） | 保留原始 count | 以过滤后数字覆盖原始 count | **无论 native count 多大都传 0** |
| `setTabBarBadgeString:forIndex:`（`:108`） | 保留原始 string | 传过滤后数字字符串 | **传 nil** |
| `showRedDotOnTabBarItemAtIndex:`（`:111`） | 执行原始 show | 执行原始 show | **直接 return，不执行原始 show** |

`@0` 是非 nil 对象。判断写的是 `value ? ... : original`，并非判断 `value>0`，所以它不是“没有结果，使用原数”。历史 8.0.78 静态证据 `docs/audits/tabbar-badge-2026-10-28/native/README.md:30` 已确认 item 原生 `setTabBarBadgeValue:0` 会设 badge hidden=YES；这是内容层隐藏，后续仅修 frame 的 layout 不能让它重显。主任务本轮另行核对原生回调到 controller 的调用边，本记录不复用被撤回修复的实验结论。

政策变化还有一条**主动写入**路径：`CloseFriendNotificationHooks.xm:113` 的 observer 读取同一个过滤数，对已记录的微信 tab owner 调 `setTabBarBadgeValue:forIndex:`；值为 0 时再调 `removeRedDotOnTabBarItemAtIndex:`（`:120`、`:123`）。这不依赖“正在收到消息的 native setter”才能清底栏，但只在 `CSCloseFriendPolicyDidChangeNotification` 发生时运行；普通消息是否导致政策变更不能凭现象推定。

政策事件来源为 runtime 的 `changed` 递增 revision，并回调 manager（`CSCloseFriendRuntime.m:42`）；manager 排主线程 `flushPolicyRefresh`，发布该通知（`CSCloseFriendManager.m:103`、`:106`、`:114`）。账号同步、锁定/揭示等能触发 changed，原生普通消息 Hook 没有无条件触发它。两个政策 observer 的相对执行次序没有固定的源码保证：分组 observer 会先置 dirty/失效/refresh（`CSGroupListAdapter.m:214`），通知 observer 会计算并写底栏，不能未经运行确认就说必定读到刷新后的快照。

## 5. `closeFriendAlertBadgeCount` 的完整返回条件

主方法：`Controllers/CSGroupListAdapter.m:183`。它被底部 tab、应用图标角标、系统通知 badge 共用，底部样式开关不在判断内。

| 条件 | 返回值 / 后续 |
| --- | --- |
| policy 未 blocked，且不需要过滤或 protectedUserNames 为空（`:185`、`:186`） | 返回 nil；底部 setter 透传 native 值。仅关闭“密友隐藏会话”不保证到此，`enabled && silenceMessages` 也要求过滤。 |
| policy.blocked（账号边界/不可读取策略等） | 返回 `@0`（`:188`），即使尚没有保护名单。不能据此假定用户策略损坏。 |
| 需要过滤但当前非主线程 | 返回 `@0`（`:188`）。没有把计算转主线程后再恢复 tab 的补偿。实际 native setter 线程待验。 |
| adapter 为折叠列表，或无缓存，或 changeDepth>0，或 dirty | 跳过该 adapter（`:191`）。 |
| snapshotRevision!=modelRevision、snapshotEpoch!=当前 epoch、snapshotAccount!=policy.accountID、policy.accountID!=当前微信账号 | 跳过该 adapter（`:192`、`:193`）。 |
| 找到有效主 adapter，cacheKey 相同 | 返回此前 alertBadge（`:196`、`:197`）；key 包含账号、epoch、模型 revision、policy revision、foldedNames。这里的计数缓存是已有密友逻辑，和公众号授权“实时读关注状态”无关。 |
| 重新构建的过滤投影无效，或计算中 revision/epoch/policy 变更 | 返回 `@0`（`:205`）。 |
| 投影有效且身份稳定 | 返回“全部”投影的 `.count`（`:206`），**没有同时返回 `.redDot`**。 |
| 遍历后没有任何可用主 adapter | 返回 `@0`（`:209`），不是 nil。 |

过滤器初始 hidden 集直接取整个 protectedUserNames（`:187`），不是“当前选中分组”或只取未揭示的可见隐藏成员；`enabled && silenceMessages` 不受 revealed 限制。因此揭示时静音仍开，也可能走该统计；现有 `Tests/CloseFriendAlertTests.m:195` 明确把“揭示时仍排除保护成员计数”作为已有行为验证。这是现有语义，诊断不把它当成可顺手删除的代码。

### 5.1 事务内 / 刷新等待期间的零

只要需要过滤，且唯一主 adapter 在上一节事务或 dirty 窗口内，native 即使传正数也会因 `@0` 被覆盖。若存在另一个有效主 adapter，遍历可能读到它；不能写成“某一 adapter dirty 就必定零”。折叠列表明确不能作 fallback。

`refresh:583` 到 `:589` 恢复的是顶部分组角标。全仓生产 tab setter 搜索没有发现普通 `publishProjection` 完成后主动把有效过滤数再写底部 tab 的路径。因此窗口内被写零后，不存在这一刷新函数明确安排的恢复；能否稍后自然恢复，取决于微信后续 native badge setter、政策通知等真实事件，而非当前源码已经保证。

### 5.2 过滤需求与快照生成需求不一致

`CSGroupPrivacyActive` 只看 blocked，或 `enabled && !revealed && hideSessions`（`CSGroupListAdapter.m:17`）。但角标过滤还看 `enabled && silenceMessages`。当只有静音过滤需要生效、session 隐私 inactive，且会话分组关闭（或原生搜索返回等分支）时，`refresh:532` 到 `:536` 会主动清 `cachedNativeSections`。后面的 `closeFriendAlertBadgeCount` 仍要求这份缓存；找不到就持续返回 `@0`。揭示中默认 silenceMessages 仍可为真，是这类条件之一。

这是一条稳态无快照路径，不只是 80ms 窗口。是否适用于本次用户配置未知，必须保留条件。

### 5.3 可见原生红点在数字 API 中丢失

对可见非保护会话，若原生 `m_uUnReadCount>0`、`m_bShowUnReadAsRedDot=YES`，投影的数字贡献明确为 0，而 redDot 为 YES（`CSGroupProjection.m:68`、`:77`）。若当前所有剩余可见未读均属这种模式，“全部”投影可能为 `{count:0,redDot:YES}`；角标汇总只返回 `.count` 变成 `@0`，随后 showRedDot Hook 直接吞掉原调用。

这不等于原生消息被标记已读，也不等于顶部分组没有红点：顶部按钮 API 同时传了 `hasRedDot`，`WETabButton` 在 count=0、hasRedDot=YES 时仍显示；底部过滤 API 没有这个状态。该分歧不依赖图标 frame、缩放比例或覆盖层。

## 6. 折叠会话会怎样影响数量

折叠源码有两条不同用途，不能混为同一计数器：

- 分组展示：`projectionForSections:...` 在分组 enabled、非折叠页、非原生 presentation 时读取折叠子 rows，以同样成员/隐私规则构造子投影（`CSGroupListAdapter.m:647`）。聚合入口的 `CSGroupRow` 设 unread=0、redDot=NO，再按子投影状态给顶部 tab 表达 redDot；不把聚合总量再次加到数字，避免重复统计（`CSGroupProjection.m:285`、`:293`、`:295`）。
- 密友 alert 数：独立构造“全部”投影时没有传 `scopeFoldedEntry/foldedProjection`；只读取折叠成员名单，判断全部隐藏/完全不含隐藏/混合或未知（`CSGroupListAdapter.m:195`）。全部隐藏就排除聚合入口；明确无隐藏就 unmask；其它不确定时聚合 row 的可见表示会被替换为 0（`CSGroupProjection.m:281`）。而 `CSGroupNumericUnread` 对所有 aggregate 本来就返回 0。因此不能把原生折叠聚合的 m_uUnReadCount 当成此数字返回值必须包含的总量。

`FoldedChanged` 会对折叠页包事务，结束后通知全部主 adapter 失效/刷新；`FoldedSession` 也包 `NativeNotification`（`SessionGroupHooks.xm:472`、`:479`）。这可延长或重新开启需要重新获得快照的阶段，但没有直接改写 ChatBoxMgr 的全局成员或原始 unread。

`CSGroupCopyFoldedRows` 把真实 session 的 unread 复制到新的 CSGroupRow（`CSGroupNativeBridge.m:384`）；原生摘要取不到消息时只调用 `GetLastMsg:`，格式化使用独立拷贝，不修改原生 session（`:274`、`:298`、`:341`）。折叠摘要代码特意不调用可能清原生 exclusive red-packet 状态的 `makeTextSession:`（`:320`）。未找到此段把真实未读清零的证据。

## 7. 现有测试说明什么、没有说明什么

仅只读检查，本轮未执行任何脚本：

- `Tests/CloseFriendAlertTests.m:195` 至 `:208` 测有效过滤数字、cacheKey、folded owner 不重复累加、epoch/revision 不匹配返回 `@0`、过滤关闭返回 nil。由此确认 fail-closed 的 `@0` 是既有契约，不是本轮误读。
- `Tests/GroupBadgeTests.m:91` 至 `:146` 覆盖顶部投影红点/原生零值/隐藏开关，并明确 count=0 而 redDot=YES 的合法展示。
- 在这些相关用例中未看到完整的“native 消息 → 分组事务/dirty → MMTabBarController Hook 接到正数 → @0 写入 → 刷新结束后底栏恢复”的集成覆盖，也未看到将顶部 `.redDot` 合法状态传过底部过滤 API 的端到端断言。现有两个局部契约分别通过，不能证明组合后的底部微信 tab 正确。

## 8. 闭环需要的最小现场证据

没有当前配置和运行事件，不能把上述候选直接宣布为用户根因。后续只需围绕一次“冷启动有数 → 一条新消息后消失”记录以下状态，即可区分内容归零与几何不可见；本轮没有加入日志代码：

1. 三个 controller badge setter 的原输入、index、ChatTab 结果、线程、过滤返回值（nil/0/正数），以及原生 item 的 badge hidden/value/string。
2. 同一时间 `policy.blocked/enabled/revealed`、hideSessions/silenceMessages、保护名单数量、当前账号/epoch 是否匹配；记录比对结果即可，不输出账号或姓名。
3. 被选 adapter 的 cachedNativeSections 是否存在、dirty/changeDepth、modelRevision/snapshotRevision、snapshotEpoch 的相等关系；是否因列表被覆盖/后台/搜索/交互推迟刷新。
4. 投影的 count 与 redDot 两者、folded 名单是否读到/分类结果；区分过滤后“确实没有可见未读”和“没有可靠快照”。
5. safe refresh 完成后，是否又有底部 setter；如果没有，角标是否仍 hidden。只有 frame 非零/hidden=NO 时才继续用布局链解释像素不可见。
6. 同一账号/同一未读场景下仅关闭底栏样式重现一次。上述内容替换 guard 没有读取底栏样式开关；结果可帮助区分独立内容路径和样式几何路径，但不能在没有同场景数据时排除任一条。

最关键的判据是：**若 native count>0 而插件向原实现传 0、或原生 showDot 被 @0 分支截断，先定位过滤/快照/恢复链；若 setter 内容正确且 badge.hidden=NO，再追 frame、裁剪与 z 序。** 不从“收到消息后消失”倒推是消息丢失，也不从“通讯录/发现正常”倒推所有 tab 共用的几何实现一定无问题。
