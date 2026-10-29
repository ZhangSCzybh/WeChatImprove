# 微信 tab 角标修复 2.1-8

> **已完成 2.1-8 修复、针对性回归、rootful/rootless 完整构建和包校验。** 两方案均为 6 条历史警告，未新增；两个包及 symbols 已生成。真机验收尚未执行。

微信 tab 角标消失的核心问题在内容写入链：旧 `closeFriendAlertBadgeCount` 将“尚无可靠快照”返回为 `@0`，tab 的数字、字符串、红点三个 hook 又把它当成真实零写入原生 badge。新消息触发的 transaction/dirty 窗口因此能把先前正数隐藏；列表后来有可靠数据，也没有对应 tab 发布来恢复。这条 `ChatTab` 路径与底栏样式开关无关。本次修复隔离 tab 的三态契约，在真实 refresh 的可靠完成边界发布恢复，继续调用微信原生 badge API。

揭示状态还存在独立的语义偏差：旧 getter 按通知静音对象过滤，即使已经揭示、原生总数应为 10，也仍可能写 7。本次 tab 复用分组的实际 Session 隐藏集合与 count/dot 投影；旧通知/app-icon 的静音契约继续保留。没有修改底栏几何、图标尺寸、文字、动画、列表圆角或密友策略本体。

## 基线与范围

- 工作区：`/Users/zhangshichao/Documents/Workspace/WeChatImprove`；微信静态核对目标：**8.0.78**。
- 开始前对用户指定 2.1-6 授权清理基线的 **602 项源码 SHA-256** 逐项比对，全部一致。证据：[baseline-result.json](baseline-result.json)、[baseline-source-sha256.json](baseline-source-sha256.json)。本轮不是以 Git HEAD 代替基线。
- 历史产物开始时记录 **1260 项**：[historical-artifacts-before.json](historical-artifacts-before.json)。本轮使用独立构建目录与新包目录，当前保存校验 **1260 项全部相同**：[preservation-result.json](preservation-result.json)、[逐项对比](historical-artifacts-comparison.tsv)。
- 版本：**2.1-8**。交付目录：`packages/2.1-8-wechat-badge/`。独立编译、包与 symbols 校验全部通过，结果见本文末尾。
- 602 项中 **594 项原样、8 项修改**，另新增 1 个 tab测试，共 **603 项构建输入已冻结**。文件清单和被保护方法逐体SHA见 [preservation-result.json](preservation-result.json)、[源码比较](source-comparison.tsv)、[构建输入](build-input-sha256.json)；变更见 [production.patch](production.patch)、[release.patch](release.patch)。

根因链和原生静态证据沿用 [2.1-6 分析记录](../tabbar-wechat-badge-2.1-6-2026-10-29/README.md)、[设置保存/策略通知时序追踪](../tabbar-wechat-badge-2.1-6-2026-10-29/selection-followup/selection-timing.md)、[8.0.78 原生证据](../tabbar-wechat-badge-2.1-6-2026-10-29/native/README.md)。这些证据支持源码路径和原生 API 限制，不能替代尚未完成的真机现场采样。

## 修复契约

| 状态 | 可判定条件 | tab 输出行为 |
| --- | --- | --- |
| **Native：不介入** | 策略可读且实际保护名单为空，或当前没有隐藏 Session | 普通输入直接走 nil 透传；原生 0/1/12/99+/字符串/纯红点保留原意。冷空名单不主动接管、不为 tab 建快照。若此前插件改写过该目标，只完成所欠的原生恢复后释放 marker；微信自己的成功原生输出也应释放这笔恢复义务。 |
| **Pending：暂不可得** | 当前策略要求隐藏，但 cache 不可用、dirty、changeDepth、revision/epoch 不一致、非主线程等 | 不把 unknown 转成数字 0。同 root/item/badge、同账号/epoch/policy token 的已验证显示可继续保留；不可信目标或边界通过原生 nil-string 隐藏失效内容，等待可靠来源。 |
| **Ready：已知结果** | 当前账号/epoch/policy、无 dirty/transaction 的可靠主列表 snapshot，经投影且重验有效 | 正数调用原生 number API；`count=0 && redDot=YES` 调用原生 dot API；`count=0 && !redDot` 才是可写的真实零。 |

这里的“空名单”是当前账号已经加载、可确认的真实空名单；blocked 快照里的空集合只是未知占位，不足以证明当前账号无保护对象，因此走安全边界，不借此透传敏感旧值。

Pending 时的“保留”必须带身份：旧账号、旧 epoch、旧 policy 或新 root/item/badge 的值不能被继续展示。仅 Ready 建立 Known token；Pending 的新隐藏状态不取得可靠数字恢复凭据。无可信显示时选择原生隐藏失效内容，满足“暂不可得不写数字 0”和“隐藏状态不泄露包含密友未读的总数”两条约束。没有固定延时、轮询、整栏重载或新建 badge。

`ForPublication:YES` 只用于取得可靠的原生 count/dot 来源以完成恢复；它不改变普通 getter 的 nil 透传判定。恢复也只针对实际被插件写过、仍欠恢复的同一目标。内部原生 API 写入的绕过限制为同 owner/index/selector 的一次消费，`@finally` 恢复上下文；发布和写入的重入通过同步状态门协调。

## 与分组、免打扰和通知口径的关系

tab 直接复用 `CSGroupProjection`：隐藏集合先排除行，再按既有规则聚合；普通数字行做饱和加总，原生 `redDot` 行不贡献数字而提供 dot，数字为正时优先。隐藏的普通密友数字 3、其余普通数字 7 对应 tab 7；揭示后回到原生 10。不会对已经以点呈现、原本不贡献数字的会话再扣一次 3。

这里有必须保留的证据边界：项目中的 `redDot` 是原生“以点呈现”字段，不能直接等同于“免打扰”。8.0.78 静态证据支持重算未读时 dot/数字的区分，但没有穷尽真实免打扰、@ 提醒等全部增量路径。本次没有改变免打扰判定或分组算法，也没有捏造一个新 DND 布尔判断。host 用例验证“以点呈现的行不贡献数字、不被重复扣减”；免打扰普通消息和 @ 提醒仍列入真机验收。详见 [semantic-audit.md](semantic-audit.md)。

旧 `closeFriendAlertBadgeCount` 继续服务通知内容、app-icon 及原有静音逻辑。tab 使用独立 `CSGroupTabBadgeDecision`，不把 tab 的揭示语义推广到通知静音。专用 source notification 只唤醒 tab 发布，不调用通知移除、app-icon 更新或再次请求列表 refresh。

## 改动点与对应要求

下表的方法与行号对应最终生产源码；[源码复核](final-source-review.md) 记录 adapter/生命周期的固定 SHA，[最终输出复核](final-native-review.md) 记录最终 Hook SHA 和边界。完整差异见 [production.patch](production.patch) 与 [release.patch](release.patch)。

| 文件:方法/位置 | 改了什么、为什么 | 对应用户要求 |
| --- | --- | --- |
| `Controllers/CSGroupListAdapter.h:7`：`CSGroupTabBadgeDecision`、两个 tab getter、source notification 声明 | 提供 Native/Pending/Ready 所需的明确接口及 account/epoch/policy token、count/dot 数据，避免旧 `NSNumber @0` 混义。 | 三态返回；刷新窗口不写伪零；账号边界；纯红点。 |
| `Controllers/CSGroupListAdapter.m:15、224、227`：decision 工厂、`+closeFriendTabBadgeDecision` / `+closeFriendTabBadgeDecisionForPublication:` | 普通 getter 空名单/无 Session 隐藏返回 nil；可靠时复用分组投影与实际隐藏集合；unknown 返回 pending；前后验证 snapshot/account/epoch/revision。 | 空名单绝不接管；10−3=7、揭示回10；与分组一致；保留 dot。 |
| `Controllers/CSGroupListAdapter.m:587、678`：`-refresh` 非投影分支与真实 `@finally` | 揭示/分组关闭时按需要取得 native dot 来源；最后名单清空后已有来源仍可恢复；冷空名单不额外获取 tab ownership。finished、无 dirty/depth、非 folded、verified badge 后发一次专用来源事件。 | 不等下一条消息恢复；不固定延时；不扩大分组 UI 行为；清空名单恢复。 |
| `Hooks/CloseFriendNotificationHooks.xm:36、117、146、158、175`：tab 输出状态与 `CSApplyTabBadgeDecision` / `CSPublishChatTabBadges` / 原生恢复辅助函数 | 按状态调用同一个原生 badge 的 number/dot/string-nil API；只复用同身份已验证显示；按实际 owner/index 恢复；保留所欠恢复 marker 并在恢复/自然输出成功后清债；同步重入再次校验。 | 不新建/复制 badge、不写假零；不泄露隐藏数字；多 tab 与账号/epoch 安全；不覆盖已经恢复的原生输入。 |
| `Hooks/CloseFriendNotificationHooks.xm:315、318、321`：数字、字符串、dot 三个 setter hook | 三个入口都读取相同 tab decision；Native 走原生，Pending/Ready 走统一应用，内部一次写入仅绕过自己的目标。`ChatTab` 判定口径保持原样。 | 三入口一致；样式开关无关；任意原生输入透传。 |
| `Hooks/CloseFriendNotificationHooks.xm:323、329`：策略 observer 的 tab 发布及专用 source observer | 策略变化后立即处理边界/恢复；可靠列表来源完成后补发；专用来源事件不触发旧通知/app-icon 工作。 | 不依赖下条消息；旧静音逻辑隔离；避免刷新循环。 |
| `Tests/CloseFriendTabBadgeTests.m`（新增）与 `Tests/verify-close-friend-alerts.sh` | 用 host 边界执行真实生产 decision、投影、tab hook/output 和来源事件片段，覆盖 nil、pending、ready、dot、边界、重入与恢复。旧通知测试继续独立运行。 | 六类核心验收用例与原通知回归；先红后绿。 |
| `Tests/GroupLifecycleTests.m`、`Tests/extract-group-lifecycle.py` | 提取真实新依赖，保持真实 non-projection refresh 和完整 `@finally`；补冷空名单及“最后保护对象清空+分组关闭”的纯dot恢复。旧关闭分组断言按已有保护名单需原生恢复来源的实际语义调整，没有删除旧生命周期场景。 | 可靠发布边界确实可达；空名单不额外接管；恢复不等新消息。 |
| `Headers/CSUserInfoHelper.h:kPluginVersionString`、`control:Version` | 版本元数据统一为 2.1-8。 | 新版本双包与独立交付目录。 |

密友策略/存储、`CSGroupProjection` 数学、底栏样式、列表圆角、AI、定时发送、备份、授权及通知静音算法均不属于本轮授权修改目标；最终 602 项差异校验已确认这些范围没有新增源码变更。

## 消息与恢复时序

1. 微信 native model/未读回调执行，adapter 进入 transaction/dirty。此时普通 hook 即使先收到正数/字符串/dot，也只拿到 Pending：保留同边界可信显示，或隐藏已经失效的旧内容；不会把 unknown 写成数字 0。
2. native transaction 结束后，既有列表调度完成可靠 snapshot 与投影。无需新增延时或等待新的消息。
3. 真实 `refresh` 的 `@finally` 先退出 publishing，处理原有回调/native action。若回调又使模型 dirty、打开事务或切换账号，本次来源发布被 gate 拦下。
4. finished、无 dirty/depth、非 folded 且决策可验证时发专用来源事件。tab publisher 重新读取当前策略与目标，写微信原生 number/dot API。写入前后都验证 token/目标；同步改变策略或对象会使旧写入失效并协调补发。
5. 揭示/清空名单后普通 hook 回到 nil。仅对插件仍欠恢复的同目标读取其逻辑控制器的原生 total；同账号同 epoch 的可靠旧 token 允许读取正数恢复；token 被边界撤销或账号/epoch 改变后，正数也必须等待当前可靠 source。零始终配合可靠行来源恢复纯 dot 或真实零。成功后释放 marker，后续来源事件不持续接管 Native 输出。

8.0.78 静态证据显示 `NewMainFrameViewController.updateUnReadCount` 会写全局 tab 0 且只有数字路径；因此恢复按枚举到的实际 owner/index 直接调用对应原生 API。`getTotalUnreadCount` 先检查 `I@:` ABI，避免将错误签名作为未读总数调用。静态证据文件见 [native 目录](../tabbar-wechat-badge-2.1-6-2026-10-29/native/README.md)。

## 红测与绿色回归

红测分清原始基线、单条件控制和开发候选回归，后两者不冒充历史 2.1-6 的失败：

| 阶段 | 输入与结果 | 证据 |
| --- | --- | --- |
| **原始 2.1-6 基线红测** | 与历史 2.1-6 SHA 一致的源码副本，抽取真实旧 getter、ChatTab 和数字 hook，编译成功。host 原生10/保护数字3：揭示仍被写7；同边界 dirty 窗口被写数字0；两条行为失败、运行 exit1。主生产在运行中保持未变。 | [red/results.json](red/results.json)、[red/events.jsonl](red/events.jsonl)、[red/stderr.log](red/stderr.log)、[运行脚本](red/run-legacy-red.py)。事件明确 `actualWeChatLoaded=false`。 |
| **最后名单清空的单条件变异控制** | 在隔离的当前 adapter 副本中仅撤回 non-projection 分支的 `|| self.tabAlertBadge`。113 checks 中两条精准失败：最后名单清空后未建 snapshot；真实 finally 未发可靠dot来源。不是原始基线或真机结果。 | [变异控制日志](logs/group-lifecycle-last-name-marker-red.log)、[隔离控制源码](red/group-lifecycle-last-name-marker-control.m)。 |
| **Pending token 候选回归** | 旧 epoch Ready7 → 新 epoch/source 旧 → Pending 隐藏 → 空名单/source 旧/native123，候选会错误恢复123；新增正式用例先失败。仅 Ready 建立 Known token 的一行修正后通过，可靠新 source/native5 后恢复5。 | [候选红测输入/结果](red/pending-token-candidate/result.json)、[红测日志](red/pending-token-candidate/regression.log)、[最终绿测说明](formal-test-boundaries.md)。这不是历史基线红测。 |
| **最终绿色** | 最终 tab/通知、分组和底栏四脚本全部通过；结果见下表。 | [tab/通知结构化结果](formal-test-result.json)、[冻结构建输入](build-input-sha256.json)。 |

本轮只选择与需求直接相关的四个脚本，没有跑全量功能测试。它们分别覆盖输出内容、共用数学、真实发布时机和未修改的底栏交互边界：

| 脚本 | 覆盖理由 | 最终结果/日志 |
| --- | --- | --- |
| `Tests/verify-close-friend-alerts.sh` | 旧通知身份/静音/app-icon口径继续运行；新增 tab 模块验证空名单任意值原样透传、隐藏7/揭示10、dot贡献不重复扣减、各种unknown不写伪零、账号/epoch/blocked、实际owner/index、多tab、同步重入、原生恢复marker及自然输出清债。 | **旧 alerts 216 checks、tab 782 checks，exit 0**：[完整日志](logs/verify-close-friend-alerts.sh.log)。 |
| `Tests/verify-group-badges.sh` | 验证直接复用的不可变行→分组投影→发布数学与数字/点模式，防止另造减法算法改变既有分组口径。 | **136 checks，0 failures**：[日志](logs/verify-group-badges.sh.log)。 |
| `Tests/verify-group-lifecycle.sh` | 验证真实 transaction/dirty/可见性/账号与 refresh-finally 发布边界；最后名单清空的纯dot来源恢复；冷空名单分组关/开/关无额外tab ownership。 | **113 checks，0 failures**；隐藏回调发布 **0/20**：[完整日志](logs/verify-group-lifecycle.sh.log)。fixture固定SHA见 [源码审查](final-source-review.md)。 |
| `Tests/verify-tabbar.sh` | 现有几何、点击效果、preferences/native生命周期，确认与内容hook并行时没有修改底栏框架行为；它是host回归，不代表所有样式的真机截图验收。 | geometry **PASS**、click **39 checks**、preferences/native lifecycle **PASS**：[日志](logs/verify-tabbar.sh.log)。 |

host fixtures提供账号、宿主对象和不可变原生行，执行真实抽取的生产方法/调用片段。`badgeView` 替身只验证原对象身份、原生 setter 参数及几何未被此路径改写；不从其父子关系推断真实微信层级。lifecycle新增的folded输入明确为unknown且不含aggregate行，不能据此宣称真实折叠会话所有模式已验证。

## 核心验收样本与最终结果

| 输入/状态 | 预期与 host 结果 |
| --- | --- |
| 已知空名单，功能开/关、揭示开/关 | 普通 getter 均 nil；原数字、字符串、99+、纯点原参数透传；从未接管者不填 tab cache、不读 total、不主动写回。 |
| 原生数字10，非免打扰表现的保护数字3，普通数字7，隐藏 | Ready7；数字/字符串/dot 三个自然入口采用同一决策。 |
| 同一10/3样本，揭示，silenceMessages仍开 | 普通 getter nil，原生10透传；需要恢复时原生10加回。 |
| 保护行 raw未读3且原生以点呈现，普通数字10 | 隐藏/揭示均数字10口径；保护点不贡献数字，不把10再减成7。受控原生表现标记用例，真实免打扰/@映射待设备验证。 |
| 可见普通点，最终 numeric count=0 / redDot=YES | 原生 dot 显示；不写数字0清掉它；数字为正时不再调用会清数字的纯点API。 |
| 已可靠7 → dirty/changeDepth/无缓存/快照失配 | 同 token/同对象保留7；不写伪数字0；可靠源就绪后主动补发最新结果。 |
| 账号/epoch/blocked变化，旧logic仍返回123 | 安全隐藏旧显示，Pending不能建立Known token；当前可靠source/native5后才恢复5。 |
| 已知结果0且无点 | 真实 numeric0，允许原生正常隐藏；与未知状态分开。 |

## 安装后的三组真机对照

以下是**尚待执行**的验收步骤；本轮没有接入真机或读取用户账号数据。建议保持同一微信8.0.78测试账号和相同消息来源，对每组都记录“样式关闭/开启”的显示值、红点状态、切tab和收到下一条消息后的结果。避免把插件host通过当成设备通过。

1. **不选密友/密群，名单确实为空。** 密友总开关分别开/关；制造0、1、12、99+和纯红点。确认微信原生外形与文案正常，底栏样式开/关一致。连续收消息、切tab、前后台恢复、反复开关样式，角标不消失；空名单不会出现插件自定义数值。分组开/关也不应改变这一结论。
2. **选密友/密群且隐藏。** 先用非免打扰会话构造原生10，其中保护对象3、其余7，确认微信tab和分组口径均为7。收到新消息期间观察，不得瞬间归零后永久消失，不得闪出包含密友的原生总数。再测保护对象与普通对象的原生以点呈现、纯dot和真实零；免打扰普通消息本来不贡献数字时不得再扣减，单独测试@提醒的原生行为。包含数字99+、各tab切换及多tab可用配置，检查只有微信tab被这套Session决策处理。
3. **解锁揭示，再恢复原生所有权。** 上述10/3对照解锁后恢复10，即使 `silenceMessages` 仍开启；这不意味着通知静音被关闭。原生总数0但存在应显示的dot时须恢复纯红点。再次隐藏回7；删除最后一个保护对象时，尤其在设置页覆盖主列表、分组关闭的组合下，返回无需等待下一条消息即可恢复原生数字/dot。让微信随后自己写数字/字符串/dot，再触发来源事件，确认原生新输入不会被旧marker重写。账号切换、同账号epoch更新及blocked状态不能显示旧账号或含隐藏对象的旧总数。

三组还需在深浅色、选中/未选中、系统/自定义图标、保留/无文字、普通/紧凑/悬浮样式中抽取组合执行。实际可配置tab数量以设备为准；代码按实际owner/index枚举，不把host五项当作设备一定有第五tab。几何层这轮没有改动，仍应观察99+、纯红点和自定义图标的遮挡/裁剪，避免把内容修复误写成所有设备渲染组合已验收。

待设备记录：**设备/iOS/微信版本 `__`；rootful或rootless `__`；安装包SHA `__`；三组各组合结果/截图/日志 `__`。** 尚未覆盖：真实免打扰@提醒所有增量路径、真实folded membership与特殊容器、多设备并发/多账号切换现场、系统/图标/样式组合的实机渲染。

## 编译、打包与保存校验

两方案在全新、各自独立的 Theos 目录完整编译，未运行 `make clean`、未重置当前工作区、未安装到设备。最终编译前冻结 603 项输入，编译后逐项比对一致。命令、耗时及原始警告见结果 JSON；[warnings.json](warnings.json) 验证每方案恰为两架构各一条 UILocalNotification、statusBarFrame 和链接器旧选项历史警告，共 6 条，新增 0 条。

| 方案 | 最终构建 | 包架构 / dylib 架构 | 安装路径 |
| --- | --- | --- | --- |
| rootful | exit0；19.31 秒；6 条历史警告；[日志](logs/build-rootful.log)、[结果](build-rootful-result.json) | `iphoneos-arm` / `arm64 arm64e`，两架构最低 iOS15.0 | `/Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib` |
| rootless | exit0；19.348 秒；6 条历史警告；[日志](logs/build-rootless.log)、[结果](build-rootless-result.json) | `iphoneos-arm64` / `arm64 arm64e`，两架构最低 iOS15.0 | `/var/jb/Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib` |

包的 control/version、双架构、最低系统、安装路径、注入 filter 与源码一致性，以及四个 dylib/dSYM UUID 均通过。完整机器结果：[package-verification.json](package-verification.json)；[SHA256SUMS](../../../packages/2.1-8-wechat-badge/SHA256SUMS)、[校验日志](logs/checksums.log)。

| 文件（独立交付目录） | 字节数 | SHA-256 |
| --- | ---: | --- |
| [com.wechat.improve_2.1-8_iphoneos-arm.deb](../../../packages/2.1-8-wechat-badge/com.wechat.improve_2.1-8_iphoneos-arm.deb) | 1418254 | `4c287c1a1a107b62b0339a7d40fb1708e7c083994a637057ee72f74a1be2f0e2` |
| [com.wechat.improve_2.1-8_iphoneos-arm64.deb](../../../packages/2.1-8-wechat-badge/com.wechat.improve_2.1-8_iphoneos-arm64.deb) | 1416842 | `152376ec80eff2761ec740eb8d0dcceae47be95d8a5d47bbfb3bf23e9483e565` |
| [com.wechat.improve_2.1-8_symbols.zip](../../../packages/2.1-8-wechat-badge/com.wechat.improve_2.1-8_symbols.zip) | 10466734 | `09e047cc01368d2e34d33497f534bafbb248d3fcf55144751857ff9139edf4cc` |

Symbols ZIP 包含两方案 × 两架构的 4 份 dSYM，共 12 个文件，ZIP CRC 检查通过。UUID 与各自安装包解出的 dylib 对应架构逐一一致：

| 方案 | 架构 | dylib = dSYM UUID |
| --- | --- | --- |
| rootful | arm64 | `32FB9382-34A6-3E96-835B-2D7C1C3A1BE9` |
| rootful | arm64e | `666520AE-8D3F-31D6-BF06-7E49CDA38527` |
| rootless | arm64 | `932DE78C-515F-3AFB-A48F-6FEBED35D8CE` |
| rootless | arm64e | `4B329ACC-C554-3F79-952D-0E9EC14539BA` |

最终保存检查：[preservation-result.json](preservation-result.json)、[源码逐项对比](source-comparison.tsv)、[历史产物逐项对比](historical-artifacts-comparison.tsv)。602 项中 594 项原样，8 项修改，另新增 1 个 tab 测试；1260 项历史文件均保持原路径、原 SHA。旧通知 getter、ChatTab、非 tab hook 安装段和策略 observer 的 UN/app-icon 前缀均逐字一致。所有既有 2.1-5/2.1-6/2.1-7 成品及旧 Theos 文件保留。

首轮候选构建曾成功，但交付前的 Pending-token 回归暴露一条账号边界漏项，因此未将首轮产物交付。记录归档在 [pre-final-build/](pre-final-build/superseded.json)，旧候选包移至该轮隔离临时构建目录；一行修正先红后绿后，使用全新目录重新完整构建并重新核对输入，当前交付目录只含最终双包、symbols 与 SHA 清单。包校验脚本从 2.1-7 审计迁移时移除了其专有 `relayoutIconAndBadge` 存在断言：2.1-6 基线无该 hook，本轮也没有引入，不能把它当作本轮包的必要条件；生产与构建输入未因此改变。

最终输出复核：[final-native-review.md](final-native-review.md)、[机器检查](final-native-review-checks.json)；生命周期与固定审查快照：[final-source-review.md](final-source-review.md)；host 覆盖边界：[formal-test-boundaries.md](formal-test-boundaries.md)。设备尚未安装或运行本包，真实渲染、裁剪链、免打扰/@映射与真机性能仍须按前述验收步骤核对。
