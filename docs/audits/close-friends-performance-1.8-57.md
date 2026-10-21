# 密友功能与性能审查：1.8-57

审查日期：2026-10-21。源码基线：`codex/close-friends-148`，`08a087e2`，`control` 版本 `1.8-57`。开发目录：`/Users/zhangshichao/.codex/worktrees/close-friends-148/WeChatImprove`。

结论：当前存在明确的重复计算和主线程重任务，优先处理搜索密码校验、朋友圈滚动时的点赞缓存清理、免打扰记录引发的全局刷新。不能据此声称已经测得真机掉帧、耗电或内存泄漏。本次完成源码审查和一次隔离的 macOS 密码校验测量，没有修改产品代码。

## 功能和数据流

主要链路：`Settings → Runtime / Store → Snapshot → 各页面 Adapter / Hook → 原生展示与动作`。

- 设置使用微信原生好友、群聊选择器；名单按微信用户名保存，以账号为边界。
- Runtime 管理启用、临时解锁期限、账号 epoch、认证 generation 和策略 revision。Snapshot 缓存在内存中，包含密友用户名集合和各项开关；普通策略读取不重新解密配置文件。
- Store 保存加密配置，Keychain 保存加密密钥和密码验证材料。配置文件有尺寸限制、完整性校验、原子替换和读回校验。
- 展示隐藏主要发生在各页面的数据源、原生模型 getter 的限定调用范围和渲染入口。消息仍通过微信原生链路接收；免打扰设置、拒接和自动回复会调用原生业务接口。

| 范围 | 当前实现与边界 |
| --- | --- |
| 会话 | 首页及折叠群聊使用过滤后的索引映射；正常服务号/公众号保留原生形态。无法精确展示的混合折叠群聊摘要采用保护性展示。 |
| 通讯录、转发、标签 | 过滤候选、标签成员和群聊列表；选中与提交校验账号、策略和实际对象，避免索引变化后误选。部分无法安全过滤的标签搜索/编辑需要解锁。 |
| 原生搜索 | 过滤联系人、群聊、Top Hits；完整密码匹配后消费输入、清空编辑器并取消搜索。普通联想和网络搜索保留。无法可靠拆分的消息/聚合搜索 section 在保护期间整体不显示，没有解锁占位行。 |
| 发朋友圈 | “谁可以看”入口保持原生；“部分可见”“不给谁看”“提醒谁看”的候选隐藏密友。隐藏候选不会直接覆盖原生的完整发布权限集合。 |
| 朋友圈 | 动态、点赞、评论、互动详情/消息和发现页提示分别处理；密友个人相册保留原生页面，内容为空并显示原生结束横杠。启用相关保护时走已适配的原生 UIKit 朋友圈路径。 |
| 个人资料 | 原生资料页在限定展示范围内呈现“添加到通讯录”；不修改实际好友关系。朋友圈、朋友资料等只读导航保留，添加按钮被本地拦截。 |
| 状态 | 状态广场和卡片过滤；身份/数据源无法可靠确认的单卡片路径使用保护性遮挡。 |
| 通知、免打扰 | 对具有可靠身份的通知、声音、震动及角标进行过滤；自动免打扰保存原状和操作归属。用户/远端后续修改不自动覆盖；重启后可能需手动恢复免打扰。 |
| 来电、回复 | 在已适配的邀请/来电入口拒接并抑制提示；拒接提交后创建独立回复任务。默认关闭挂断回复，只给自动拒接的单人语音/视频来电发送。 |
| 解锁、锁定 | 密码、生物识别、首页导航栏长按 1 秒；完整首页搜索密码也可解锁。默认 300 秒；失去活动状态、账号变化、手动或摇动触发锁定。当前页通常保留，密友聊天页返回聊天列表。 |

临时解锁会恢复各展示列表，但静默、拒接、自动免打扰仍按开关生效；“隐藏全部朋友圈可见范围图标”同样不以临时解锁为停用条件。

主要依据：[Policy](/Users/zhangshichao/.codex/worktrees/close-friends-148/WeChatImprove/Controllers/CSCloseFriendPolicy.m:54)、[Runtime](/Users/zhangshichao/.codex/worktrees/close-friends-148/WeChatImprove/Controllers/CSCloseFriendRuntime.m:65)、[设置](/Users/zhangshichao/.codex/worktrees/close-friends-148/WeChatImprove/Controllers/CSCloseFriendSettingsViewController.m:71)、[个人相册](/Users/zhangshichao/.codex/worktrees/close-friends-148/WeChatImprove/Controllers/CSCloseFriendAlbumAdapter.m:77)、[发布权限候选](/Users/zhangshichao/.codex/worktrees/close-friends-148/WeChatImprove/Controllers/CSCloseFriendAudienceAdapter.m:127)。

## 需要优化的性能路径

### 1. 高优先级：搜索输入在主线程进行昂贵的密码验证

`consumeSearchPassword:` 对 6–128 字符的合格输入，在主线程和 runtime 同步锁内执行 PBKDF2-SHA256；默认 210,000 轮。普通搜索词达到长度也执行，临时解锁状态没有跳过。`dispatchDepth` 仅消除同步嵌套调用，独立的延迟搜索、历史记录等回调没有按查询内容复用验证结果。

本机直接编译生产 `CSCloseFriendCrypto.m`，使用合成密码和盐：Apple M4、macOS 27.0、Clang `-O2`；预热 2 次，采样 12 次。单次最小 **27.994 ms**、中位 **28.660 ms**、最大 **29.532 ms**。这些数值只代表 Mac 上的密码推导函数，不包括 UIKit、账号读取、Keychain 或搜索结果过滤，也不代表 iPhone 上的输入延迟。

建议：对相同账号/凭据/查询去重；把重计算移出主线程和共享策略锁；回到主线程前验证账号与查询代次。必须保留“完整密码先识别并消费，再决定是否进入原生搜索”的顺序，避免异步校验尚未完成就把密码写进历史或发给网络。不能通过关闭原生联想规避开销，也不能降低密码推导强度。

依据：[Runtime:126](/Users/zhangshichao/.codex/worktrees/close-friends-148/WeChatImprove/Controllers/CSCloseFriendRuntime.m:126)、[搜索分发:82](/Users/zhangshichao/.codex/worktrees/close-friends-148/WeChatImprove/Controllers/CSCloseFriendSearchAdapter.m:82)、[搜索 Hook:111](/Users/zhangshichao/.codex/worktrees/close-friends-148/WeChatImprove/Hooks/CloseFriendSearchHooks.xm:111)。

### 2. 高优先级：朋友圈高频回调反复清理整批点赞布局缓存

`Leave` 在最外层调用结束时，对 `state.posts.source` 的所有已加载动态调用原生点赞缓存删除。`scrollViewDidScroll:`、行高、cell 创建等路径均进入该范围。点赞布局/高度计算自身也在调用前后清缓存，`likeUsers`、`commentUsers`、对应 count 又各自创建新的过滤结果；成员判断还可能线性扫描已显示动态。

因此，已加载动态越多、点赞评论越多，滚动过程中重复遍历和布局重建的压力越大。上述入口缺少“不需要保护时直接走原生”的统一快速路径，关闭密友或临时解锁后仍可执行投影和缓存清理。这里确认的是多余工作，不是已经重现卡死或确认此前黑屏的根因。

建议：按动态身份、数据版本和展示策略缓存过滤结果；只清理本次确实涉及的原生点赞缓存；正常滚动不清空整批动态缓存；关闭/解锁后完成一次必要恢复，再跳过无效过滤。必须保留 scoped getter 对业务读取的隔离，避免把过滤结果污染到原生模型；保留当前离屏延迟刷新和布局重入保护。

依据：[缓存清理:26](/Users/zhangshichao/.codex/worktrees/close-friends-148/WeChatImprove/Controllers/CSCloseFriendTimelineAdapter.m:26)、[作用域退出:53](/Users/zhangshichao/.codex/worktrees/close-friends-148/WeChatImprove/Controllers/CSCloseFriendTimelineAdapter.m:53)、[互动投影:113](/Users/zhangshichao/.codex/worktrees/close-friends-148/WeChatImprove/Controllers/CSCloseFriendTimelineAdapter.m:113)、[滚动入口:253](/Users/zhangshichao/.codex/worktrees/close-friends-148/WeChatImprove/Controllers/CSCloseFriendTimelineAdapter.m:253)。

### 3. 高优先级（批量场景）：免打扰逐项写完整配置并反复发布策略变化

为一个原先未免打扰、没有记录的密友成功设置免打扰，正常路径会依次保存 prepared、attempt、applied 三次。每次保存都处理完整 profile 和 muteRecords，包含已有文件验证、序列化/加密、文件和目录 fsync、读回解密；随后 `saveState` 增加同一个策略 revision，并排入全局通知。

例如首次同时设置 100 个符合上述条件的密友，正常路径可达约 300 次状态保存，以及相应的通知调度。每轮通知还会调用免打扰 reconcile 和其他页面观察者。稳态不会一直写盘；问题是首次启用、批量修改、恢复免打扰和部分启动恢复时的集中放大，而非已经证明无限递归。名单逐项增长时，重复处理完整记录的总工作量可接近平方增长。

建议：把操作恢复日志与展示策略版本分开；日志落盘不触发全界面刷新；采用保留崩溃恢复语义的分阶段批量持久化或专用日志。文件/加密工作可放到串行队列，原生 UI/联系人调用仍遵循线程约束；提交前后保留账号、操作归属验证，不能简单删除 prepared 持久化。

依据：[免打扰事务:82](/Users/zhangshichao/.codex/worktrees/close-friends-148/WeChatImprove/Controllers/CSCloseFriendMuteAdapter.m:82)、[Store:80](/Users/zhangshichao/.codex/worktrees/close-friends-148/WeChatImprove/Controllers/CSCloseFriendStore.m:80)、[Runtime 保存:149](/Users/zhangshichao/.codex/worktrees/close-friends-148/WeChatImprove/Controllers/CSCloseFriendRuntime.m:149)、[通知分发:68](/Users/zhangshichao/.codex/worktrees/close-friends-148/WeChatImprove/Controllers/CSCloseFriendManager.m:68)。

### 4. 中优先级：锁定及策略刷新范围过大、未合并

`resign:` 先经过 `lockAndReturnToSafePage` 调用 lock，再由 `setActive:NO` 调用 lock；当前 lock 每次都增加 revision、失效快照并发布通知。未开启密友或已经锁定，也会产生这类展示刷新。

通讯录/转发观察者遍历所有仍存活的已登记页面，先调用原生刷新，再递归 reload 子 UITableView/UICollectionView；搜索观察者按 section 刷新 presenter，同一个 presenter 可能被重复刷新；通知观察者每次还查询 pending/delivered notifications。部分页面离屏但尚未释放，也会参与。

建议：认证 token 的失效与展示状态变化分开；相同展示状态不反复发布；同一轮合并通知、按页面身份去重。可见页面及时应用保护，离屏页面只标脏，在再次显示前刷新。不能为节流而留下可见密友内容。

依据：[失活入口:157](/Users/zhangshichao/.codex/worktrees/close-friends-148/WeChatImprove/Controllers/CSCloseFriendManager.m:157)、[锁定:80](/Users/zhangshichao/.codex/worktrees/close-friends-148/WeChatImprove/Controllers/CSCloseFriendRuntime.m:80)、[页面刷新:21](/Users/zhangshichao/.codex/worktrees/close-friends-148/WeChatImprove/Controllers/CSCloseFriendContactAdapter.m:21)、[搜索观察者:140](/Users/zhangshichao/.codex/worktrees/close-friends-148/WeChatImprove/Controllers/CSCloseFriendSearchAdapter.m:140)。

### 5. 中优先级：列表过滤和角标未充分复用结果

- 搜索 `CSCFSearchPrepare` 在数量查询、生成 cell、选中等入口重新过滤整个 section 的 source 并写回；revision 字段目前没有用于跳过重复计算。N 条候选、V 次 cell/数量回调可产生约 O(N×V) 的遍历。
- 通讯录 `getKeysArray` 和 `getContactCount` 都完整重建投影；状态卡片 count/configure 等也反复创建投影。
- `CSCloseFriendVisibleContacts` 即使停用/解锁也逐项提取身份并复制数组；`CSCloseFriendSurfaceConcealed` 在停用、解锁或相应开关关闭时可能扫描全部密友才返回 NO。
- 聊天角标每次调用会重新创建一个完整 `CSGroupProjection`，`previousProjection:nil`。应用角标、底栏角标、通知提交可能重复触发；发现页多个未读计数入口也分别扫描互动消息。

建议：用账号 epoch、策略 revision、原生数据 generation 作为缓存失效依据；不能只比较可变 NSArray 地址。停用/不需要过滤时使用安全的原生快速路径；数量、cell 和点击共用同一份索引映射。角标单独缓存计算结果，在会话/未读/折叠群成员或策略变化时失效。

依据：[搜索投影:163](/Users/zhangshichao/.codex/worktrees/close-friends-148/WeChatImprove/Controllers/CSCloseFriendSearchAdapter.m:163)、[通讯录投影:7](/Users/zhangshichao/.codex/worktrees/close-friends-148/WeChatImprove/Hooks/CloseFriendContactHooks.xm:7)、[通用过滤:2](/Users/zhangshichao/.codex/worktrees/close-friends-148/WeChatImprove/Controllers/CSCloseFriendContactProjection.m:2)、[角标:159](/Users/zhangshichao/.codex/worktrees/close-friends-148/WeChatImprove/Controllers/CSGroupListAdapter.m:159)、[发现页计数:71](/Users/zhangshichao/.codex/worktrees/close-friends-148/WeChatImprove/Controllers/CSCloseFriendInteractionAdapter.m:71)。

### 6. 低优先级：到期检测常驻每秒轮询

Manager 启动后注册 common modes 的 1 秒重复计时器，没有按是否解锁、启用或前台活动来撤销。每次主要读取内存快照，单次成本很小；iOS 挂起进程时不会因此持续执行。可以改成有解锁期限时的一次性到期调度，保留每次策略读取的单调时钟期限校验，并在前后台切换时更新调度。

依据：[到期计时器:144](/Users/zhangshichao/.codex/worktrees/close-friends-148/WeChatImprove/Controllers/CSCloseFriendManager.m:144)。

## 已有的有效保护与性能边界

- Snapshot 已缓存；用户名使用 NSSet 查询，通常不随密友数线性查找。需要优化的是重复调用和外围扫描。
- 首页会话列表已有账号/原生数据版本缓存、消息变化合并和有条件的增量刷新；通讯录群聊包装器也缓存投影并在成员变化时失效。
- 页面登记大多使用弱引用，不会因为注册表直接永久保留页面。投影会增加数组/索引及模型引用的内存，未测得实际峰值，也不能仅靠静态检查排除所有泄漏。
- 摇动监测仅在启用、前台、临时解锁且开关打开时运行，40 Hz，串行 utility 队列；锁定、失活后停止。有条件的传感器开销，不是全天候持续采样。
- 通话拒接去重最多 128 项并按 120 秒清理；回复任务最多 32 个、去重最多 512 项、任务最长 120 秒、最多两次重发；轮询从 2 秒退到 8 秒。同一人正常五分钟内只自动回复一次。
- 当前朋友圈出现时刷新有 revision/refreshing 保护，离屏不直接重载主时间线；没有重新挂入先前造成重入问题的时间线 viewDidLayoutSubviews/reloadDataWrap 刷新组合。优化时应保留这些约束。

依据：[会话缓存](/Users/zhangshichao/.codex/worktrees/close-friends-148/WeChatImprove/Controllers/CSGroupListAdapter.m:426)、[群聊缓存](/Users/zhangshichao/.codex/worktrees/close-friends-148/WeChatImprove/Controllers/CSCloseFriendGroupListAdapter.m:18)、[摇动启停](/Users/zhangshichao/.codex/worktrees/close-friends-148/WeChatImprove/Controllers/CSCloseFriendManager.m:125)、[采样频率](/Users/zhangshichao/.codex/worktrees/close-friends-148/WeChatImprove/Controllers/CSCloseFriendShakeMonitor.m:40)、[回复重试](/Users/zhangshichao/.codex/worktrees/close-friends-148/WeChatImprove/Controllers/CSCloseFriendCallReply.m:126)、[任务上限](/Users/zhangshichao/.codex/worktrees/close-friends-148/WeChatImprove/Controllers/CSCloseFriendCallReply.m:219)。

建议实施顺序：先处理搜索主线程计算与朋友圈滚动；随后分离免打扰日志和策略刷新、合并展示通知；再补列表/角标缓存及停用快速路径；最后替换常驻到期轮询。验证聚焦连续搜索、长朋友圈滚动、批量名单保存及锁定/解锁四个场景；同时检查普通搜索建议、密友隐藏、消息/互动及时更新和账号边界，避免扩展到无关功能回归。
