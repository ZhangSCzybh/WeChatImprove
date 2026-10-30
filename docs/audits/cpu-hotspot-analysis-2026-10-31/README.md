# 聊天列表前台 CPU 热点分析（仅分析，2026-10-31）

## 1. 结论摘要

1. 基线唯一使用 `8467df87bebb2998f021238b7d88eaea65266214`（2.2-1）；本轮没有修改生产代码、Tests、构建输入或既有产物。
2. **当前证据不足，不能认定用户真机的接近 100% CPU 已定位。** 尚未取得自然驻留时的线程采样、布局频率和开关对照；不能把主机桩制造的回调频率当作手机频率。
3. 已证实的正常路径放大器是 `performSessionListLayout:` 每次布局扫描整个已投影行集合；锁定时单行需校验字符串并查询名单，主机 1,000 行约 0.219 ms/次、10,000 行约 2.200 ms/次。
4. 已证实的条件性视图拆建是折叠摘要的主题状态不可读：600 次给定布局输入导致 600 次原生 quote 和 600 次 remove；状态可读时这两项均为 0。真实手机是否命中该条件仍未采到。
5. 无效快照的刷新反馈链有条件成立，但**不能从源码断定无限自激**：干净表格只按需布局的桩中，一次触发经 4 次刷新后停止；只有布局保持 dirty 的对照中才达到 512 次刷新上限仍未停止。
6. 上述列表重活在当前代码中由主线程执行；没有找到与这两个开关直接绑定的后台忙等或无条件列表 displayLink。真机高 CPU 是否来自主线程，以及持续忙转还是高频脉冲，仍需采样确认。
7. 推荐先做下文的最小真机取证；代码候选优先处理**被实际采样命中的幂等性/恢复状态问题**，再做布局准入证明缓存。预计可去掉对应的重复拆建或重复扫描，尚无依据承诺整机 CPU 降幅。
8. 本轮交付至报告与原始数据即止，不实施任何候选方案。

## 2. 复现条件与现象界定

用户反馈：分组开启、密友/密群隐藏开启，微信前台停在聊天列表，不滚动、不切页，CPU 持续接近 100%。用户没有验证两个开关分别单独开启时的结果。因此“同时开启是必要条件”尚未成立；目前仅知道两者同时开时出现。

本文区分三个频率：**真机原生自然回调频率未知**；主机有界队列重放得到的派生调用次数已测；60 Hz/600 次布局是明确给定的实验输入。没有 Instruments trace，没有真实微信 UIKit/主题服务/数据库/屏幕合成的耗时。CPU 百分比的监测工具、是否按单核 100% 计、机型、系统/微信版本、原生会话数也未知。

记号：`N_s` 为原生主列表行数，`N_p` 为当前分组过滤后的投影行数，`F` 为折叠会话数，`H` 为保护名单大小，`M` 为分组数，`V` 为可见 cell 数，`D` 为全部会话与分组的归属关系总数。静止 UIKit 并不必然每帧调用布局；“每帧都计算”是需要证据的结论。

**谁在跑，先按证据回答：**

- 普通 C/ObjC 同步无限 `while` 忙转：在所列分组、隐私、圆角和 chrome 路径中没有找到；循环均为有限集合遍历。
- 主队列刷新闭环：主机证实依赖“布局是否继续 dirty”的条件，存在可复现的未收敛模型，也存在收敛模型；真机属于哪种未知。
- 高频外部回调：每次布局扫描及折叠摘要拆建的放大系数已测，但自然触发源/每秒次数未知。
- 后台队列：没有找到这两个开关启动的永久工作队列；通知可能来自后台，`requestRefresh`/`refresh` 最终转主队列。不能据此排除手机中其他微信/插件后台工作。

## 3. 热点清单与量化证据

### 3.1 可测的刷新成本 Top（主机受控负载）

完整生产方法重放的具体 Top、规模表和队列对照见本目录 `replay-summary.md`、`replay-summary.json` 与 `replay-*-results.json`。测量是 Foundation/生产投影与方法正文加 UIKit 边界替身，**不是实际 UIKit layout 或原生数据库 benchmark**。按独占 CPU 时间排序可避免把 `refresh` 和它的子调用重复相加；`refresh` 的 inclusive 时间才是该次刷新总时间。

主机新结构负载 `N_s=10,000 / M=12 / V=12`，预热后连续20次（每次替换会话身份），`refresh` 总CPU **283.216ms**，约14.161ms/次；独占时间Top如下。可见path替身为空，未执行真实cell交付；N/M负载不是任意大分组成员配置。

| 排名 | 方法与位置 | calls | 独占CPU ms | 占refresh总CPU |
| ---: | --- | ---: | ---: | ---: |
| 1 | `projectionForSections…`，Adapter:943 → Projection:143 | 20 | 199.918 | 70.59% |
| 2 | `refresh`未单独包装的其余步骤，Adapter:789 | 20 | 48.315 | 17.06% |
| 3 | `performSessionListLayout:`，Adapter:648 | 20 | 34.262 | 12.10% |
| 4 | `nativeSectionsForAccount:`，Adapter:767（source为替身） | 20 | 0.623 | 0.22% |
| 5 | `layout`，Adapter:601（chrome/native UI边界为替身） | 20 | 0.067 | 0.02% |
| 6 | `publishProjection…`自身，Adapter:921（guard时间已在第3项） | 20 | 0.032 | 0.01% |

| 20次refresh的总CPU ms | N_s=100/M=4 | N_s=1,000/M=4 | N_s=10,000/M=4 | N_s=10,000/M=12 |
| --- | ---: | ---: | ---: | ---: |
| 缓存且结构相同 | 0.959 | 7.030 | 77.097 | 78.880 |
| 每次新结构 | 2.926 | 27.141 | 276.174 | 283.216 |

M为1个All加M−1个单成员custom tab；Synthetic source构造在计时之外。此Top仅排序同口径可计时的方法，以下折叠原生quote/通知/恢复链缺乏原生耗时，不伪造跨实验排序。重放采用ARC、计数包装、无额外优化标志；Policy微基准另以-O2执行，两者不能直接当作同口径速度比较。

对相同投影输入的刷新仍需做投影验证/数组比较；对结构变化的刷新还需创建映射、分组归属和角标。对象缓存减少重建，不能把当前路径概括为“每帧所有东西全算一遍”。正常单次触发的队列会归零；主机人为连续触发 60 次会得到 60 次 refresh，不能将它记成插件自主 60 Hz。

### 3.2 每次 table layout 的全投影行扫描（确定的 O(N_p) 放大器）

位置：`Controllers/CSGroupListAdapter.m:648`，其中 `659` 校验账号/epoch/投影有效性，`662` 通过 `CSGroupReadInteger` 反射读取隐私版本，`663` 遍历每个 section/row，`664` 调用 `hidesUserName:surface:`。发现一个隐藏行后也不会立即退出扫描。

调用链：UIKit `MainFrameTableView.layoutSubviews` → `Hooks/SessionGroupHooks.xm:368` → `performSessionListLayout:` → `CSCloseFriendCurrentSnapshot`（Bridge:8）→ Runtime `snapshotForEpoch:`（Runtime:77）→ Policy `hidesUserName:`（Policy:66）。主线程上的 table layout 触发这条链；该函数没有自己的 timer、displayLink 或 `setNeedsLayout`。原生 layout 被调用几次未知；插件额外增加的是**每次回调 O(N_p) 次策略查询 + 账号/版本反射与快照校验**。

实际未修改 `CSCloseFriendPolicy.m`，100 个保护名单项、31 字符普通名称、预热一次扫描，3 轮各 200 次全量扫描，主机 Apple M4，`CLOCK_PROCESS_CPUTIME_ID` 中位数：

| 状态 | 100 行 ms/scan | 1,000 行 | 5,000 行 | 10,000 行 |
| --- | ---: | ---: | ---: | ---: |
| 锁定隐藏 | 0.026715 | 0.218955 | 1.158850 | 2.199625 |
| 已解锁 | 0.001585 | 0.015235 | 0.077700 | 0.152665 |
| 密友主开关关闭 | 0.001420 | 0.014185 | 0.070395 | 0.140795 |
| 开启锁定但名单空 | 0.002345 | 0.021595 | 0.110145 | 0.217335 |

锁定时 1,000 行约为密友关闭时的 15.4 倍，但绝对值仍约 0.219 ms。**若外部恰好每秒调用 60 次**，该 policy-only 扫描消耗约 13.14 ms CPU/s（一个主机核的 1.31%）；10,000 行约 131.98 ms/s（13.20%）。120 次/s 时分别翻倍。这不是已观察到的调用频率，也不能直接换算 iPhone CPU。仅此数据不能解释普通规模会话列表持续 100%。原始值在 `policy-benchmark.json`。

### 3.3 折叠摘要在主题状态未知时，每次布局拆建前缀（确定条件，频率待采）

位置/链：`Hooks/SessionGroupHooks.xm:444` 的 cell layout、`:447` 的 item layout、`Hooks/ListCornerRadiusHooks.xm:61` 的会话 cell layout，以及 `Controllers/CSListCornerSessionRestore.m:138` 的表格修复 → `CSCloseFriendRefreshSessionCover`（SessionPresentation:259）→ `CSCloseFriendUpdateSessionCover`（:168）→ `CSFoldedRenderNativeSummary`（:130）。多个 hook 都可进入，不能假定“一帧只有一次”。实际 multiplicity 未采。

`SessionPresentation.m:138` 的复用要求 `nativeRenderState` 非 nil；`:102` 至 `:108` 的主题服务/两个属性读不到时返回 nil；于是 `:153`/`:155` 每次执行 `removeQuoteMessageLabel`/`quoteMessageLable:prefixText:`，`:161` 再尝试读取主题状态。该开销的原生 quote 部分可包含文本测量及子视图创建，真实实现耗时尚未采到。

外置探针使用当前完整 production presentation 正文和当前 item layout hook，预热后每组输入 600 次 layout：

| 行与条件 | 原生 layout 替身 | quote | remove | theme service 读取 |
| --- | ---: | ---: | ---: | ---: |
| scoped 折叠入口，主题不可读 | 600 | 600 | 600 | 600 |
| scoped 折叠入口，主题可读且内容稳定 | 600 | 0 | 0 | 600 |
| 普通非 scoped 行 | 600 | 0 | 0 | 0 |

16 个组合分别覆盖保护开关、解锁状态、scoped 与主题可读性。scoped 行的 `privacyMasked=NO`，关闭保护且名单空时也重现同一 600/600 结果。详见 `folded-layout-counters.jsonl`。因此该项不是两个开关的 AND 专有路径，不能据此解释“只有两者同时开才高”。

若原生自然布局频率为 `L` 次/s，插件额外 native quote/remove 为各 `L` 次/s（未知主题且摘要有效时）；若 cell/item/table 多层分别触发 cover 刷新，则按实际 cover 频率放大。**探针没有令 quote 自动触发下一次 layout**，不能把它写成已证实的 UIKit 自激。

### 3.4 无效快照的就绪判断/刷新反馈（有条件，不能定为无条件无限）

完整调用链与位置：

1. `CSGroupNativeBridge.m:499` 构造快照；签名/logic 不可用（:503/:506/:508）、计数变化（:556/:559）、异常（:562）可返回 nil；Projection:238 对非法坐标/重复普通会话等也会判无效。
2. Adapter:989 将 `snapshotRetryAttempted=YES`，:993 只安排一次 50 ms 恢复；:998 产生有效的安全空投影。该简化 initializer 经 Projection:123/:129 使用 `privacyRevision=0`。
3. Adapter:940 `layoutIfNeeded` 若真的进入布局，guard:660 因 retry 标志判未就绪；:662 的版本不匹配是第二个条件，**不是唯一原因**。正常 Runtime 首次同步会令 revision 从 0 增长（Runtime:74）。
4. guard:672 设置 dirty，发布过程中不再直接 request；refresh:904 清 `privacyRefreshPending`，:917 见 dirty 再调度。
5. refresh:813 已清 recoveryPending；普通 schedule:1032/:1059 是主队列零延迟异步，因此这条 dirty 路径不受 :1045 的三次恢复预算约束。
6. **但第二轮同结构空投影可能不 reload**（Adapter:923、:929、:938）。干净的 `layoutIfNeeded` 不再回调 guard，循环会停。忽略这点的“无条件 layout 桩”会产生假定性结论。

两种 UIKit 边界假设的同源对照：

| 输入（均仅一次外部触发） | dirty 在布局入口清理 | dirty 仅在执行原生 layout 后清理 |
| --- | --- | --- |
| 正常有效投影 | 1 refresh / 1 guard，队列归零 | 见原始对照；正常调用原生 layout 可归零 |
| 持续无效原生集合 / nil source | 4 refresh / 2 guard，5 个队列任务后归零 | 512 refresh / 512 guard，触及硬上限仍 pending=2 |
| fallback，policy revision=0 | 同样 4 / 2 后归零 | 同样未收敛，证明 retry 标志本身已足够阻断 |
| 一次 epoch 或 policy 版本失配、源健康 | 1 refresh 后恢复，含初始失配与后继就绪共 2 guard | 不要求持续外部驱动即可恢复 |

严格模型4次刷新后虽队列归零，`sessionLayoutHeld`/`snapshotRetryAttempted`仍为true；CPU任务停止不代表内容已恢复。512 次的对照中 `reloadData` 仅 1 次，不能写成“每轮全表 reload”。有界队列被实验上限停止不等于应用自然停止，也不等于真机真的这样运行。真实 UITableView 在不执行原生 layout 时是否留下后继失效状态，是必须采的那一环。若手机一直正常显示稳定内容而非安全空表，这条“持续无效源”假设的优先级还应下降。

### 3.5 外部通知风暴会放大完整刷新（有路径，风暴未观察到）

`Hooks/SessionGroupHooks.xm:93`/`:100`/`:200`/`:201` 包装消息、会话、未读通知 → `NativeNotification`（:46）→ `beginNativeChangeOfKind:`（Adapter:1076，每次 invalidate，modelRevision 在 :764 自增）→ `endNativeChangeCoalesced:`（:1088）→ badge source 和列表刷新（:1090）。相同 unread 值也没有在入口短路。合并处理在 schedule:1027/:1032，**不代表原生一定有高频通知**。

如果原生 getter 本身触发同值通知，就可能使 native snapshot 缓存失效，再触发新 getter；原生那条反馈边没有源码实现/真机栈证据，当前不能认定成立。原生通知速率 `R` 未知，插件每次最终执行的 refresh 成本可用 3.1 的受控数据估量，但不能将受控 60 Hz 称为 native 60 Hz。

## 4. 因果链推演与两个开关的作用

假设账号就绪、前台非搜索/原生导航例外；blocked 账号另行守安全边界：

| 分组 | 密友状态 | 会消失/保留的具体路径 |
| --- | --- | --- |
| 关 | 关或已解锁 | Adapter:835 原生快速返回，清投影；非 blocked 时 layout:651 直接原生，消失全投影扫描和 scoped 折叠摘要 |
| 开 | 关或已解锁 | Adapter:873 仍投影，:951 仍可 scopeFolded；layout 扫描保留，但 Policy:61 短路，不做名称扫描/名单 contains；折叠摘要仍可能有 600/600 条件拆建 |
| 关 | 锁定隐藏 | Adapter:854 强制 All，:873 仍为隐私投影；无分组 chrome/分组 folded scope，仍有过滤、guard 扫描、隐私聚合遮蔽与恢复边界 |
| 开 | 锁定隐藏 | 分组/折叠投影、隐藏集合构建、guard 的逐行名单判定叠加；闭环若被触发，单轮重活增加 |

策略保护开启且名单空时，Adapter:33 的 `CSGroupPrivacyActive` 仍可能为真；Policy:59 的 `concealsSurface` 则会因名单空短路，不能混同两个函数的准入语义。

可证实的链条是：分组开 → `scopeFolded`（Adapter:951）→ scoped row（Projection:286）→ cover（Presentation:172）→ 布局时重复主题检查/条件拆建；隐藏开且锁定 → Policy 的名称校验/集合判断 → 每次 guard 的成本上升。**“每帧自然触发”与“因此真机 100%”两环没有证据，明确留空，不能当成最终根因。**

如果只开分组也高，优先采 scoped 折叠摘要的 layout/quote/remove、主题状态未知比例，然后查投影恢复和 native 通知失效；依据是这些路径不依赖密友开关。如果只开隐藏也高，优先采 All 隐私投影的 guard/refresh 与 native 通知频率；有 F 折叠会话且聚合被 privacyMasked 时还要查该 cover；若 policy blocked 且 `refreshAccount` 被外部反复调用，再查 Runtime:54/:62 的加载解密。**普通名单 contains 查询不是后台轮询源**，不应先按“名单很重”定案。

## 5. 逐项排查与已排除项

这里的“排除”仅指排除为该源码路径中的**无条件自驱动来源**，不等于已通过手机采样排除该系统组件。

| 项 | 结论与依据（均为本 HEAD） |
| --- | --- |
| A：refresh/publish/layout | 正常 table/cell/count 回调没有无条件重建投影；guard 扫描 O(N_p)。refresh 调用来源见 3.4/3.5、生命周期/设置/搜索/手势结束。已证实条件性 dirty 反馈，未证实真机持续。 |
| A：reload/updates/layoutIfNeeded | Adapter:929/:938 决定全量或局部刷新，:940 layoutIfNeeded；Hooks:312/:318/:332 拦截原生变更进入适配器，publishing 隔离插件自己的刷新。没有每次 cell 回调直接 full reload 的代码。fallback 与缺失坐标可 requestRecovery。指定路径未发现 invalidateLayout 调用。 |
| A：行高/文本测量 | Adapter:1364 对可映射的 height/estimatedHeight 转原生，失败给 44 并 requestRecovery；插件未在此调用 boundingRect/sizeThatFits/创建 attributedString。原生 height 与 quote 的文本工作没有可见实现，未排除；不能称“没有文本测量”。 |
| A：快照/排序/归一化 | nativeSections:767 按 modelRevision/account/epoch 缓存，未变复用；Projection:231 验证/复制，再于 :262 同值返回旧对象，故缓存命中仍 O(N_s)。新结构建立 maps/membership/badges，约 O(N_s+H+F+M+D)，不是必然 O(N_s*M)。没有全会话 compare: 排序、小写、拼音或正则路径；NativeBridge:285 的 compare 是注释，不能当调用。saveAnchor:1402 只排序 V 个可见 path。 |
| B：名单比较规模 | Policy:48 构造 NSSet，:66 单名先字符串合法性扫描 O(名称长度)，后集合查询平均 O(1)，不是每次遍历 H 个名称；构造 hidden 时 Adapter:948 扫 H 项。原始测量在 3.2。 |
| B：配置/磁盘/加解密 | Bridge:8 → Runtime:77 缓存 snapshot；名单查找不读盘/JSON/加解密。Runtime:54 的显式账号同步在 :62 loadState 加载，:208 至 :213 的显式保存后也做loadState读回；同账号/epoch/非blocked 在 :57 直接返回。blocked 重复同步例外未排除。CSGroupPreferences:138 读 defaults 并比较 loadedProfile，没有每次无条件全量解析；Foundation 内部 I/O 不能从源码证明为零。 |
| B：隐藏行/索引映射 | Projection:277 在创建投影时先过滤，再在 :325 创建显示映射；section/count getter 直接读该投影，没有每个 getter 重算全 section。guard 的扫描不建立索引。 |
| C：KVO/NSNotification | 指定列表、隐私、圆角、chrome/badge 文件没有 KVO 注册。会话更新/未读有 hooks，policy 通知来自 Runtime.changed:42 → Manager:106 合并 → :114 通知 → Adapter:459。锁定同账号普通 snapshot 不反复 changed；解锁到期可一次 changed。原生同值通知风暴未采，未排除。 |
| C：监听范围 | SessionGroupHooks:508/510 注册 policy 与前后台通知，:511/:512 还注册分组设置的 Darwin 通知；未发现其直接监听数据库/同步进度通知；但原生 onSessionChanged/newMessage 的频率受微信同步影响。不能排除微信把同步/入库转换成这些回调。 |
| D：日志/字符串/图像 | 指定 group/policy/layout 路径没有 NSLog/os_log 的高频输出、显式文件写或图片解码。WESessionTabContainerView:60 搜索图标 dispatch_once 创建。字符串/数组/字典分配在投影与 render token 中确实存在。 |
| D：数据库 | 没有该路径的直接 sqlite 调用；但 NativeBridge:324 的 FoldedLastMessage 调 `GetLastMsg:`，:453 构造 folded rows，:485 读取/格式化候选摘要，可能进微信数据库。不能把“无直接sqlite”写成“无DB代价”，原生耗时未测。 |
| D：角标与布局反馈 | Adapter:444 相同发布 key 不再发 source 通知；NotificationHooks:447 接收后发布角标，:153 等有同值/原生写重入门。600 getter +600 source request 主机对照新增 snapshot/list publication/source event 全为 0；再 idle 0.4s 仍 0。排除该受控稳定条件下的纯插件自激；没有排除原生 setter/getter 发新通知。 |
| E：聚合/分组/折叠 | Adapter:951 每次实际 refresh 可重建 F 个 folded rows 和折叠投影（:956 previous=nil），读候选原生摘要；不是每个 count getter 做。selected/folding/model/policy 变化触发，正常驻留无事件不应自主反复刷新。摘要每次布局工作另见 3.3。 |
| E：section/row getter | Adapter:1347/:1348 直接取预先发布的 sections.count/rows.count，主体 O(1)，不做过滤/排序/读盘；proxy 仍有反射/索引映射的固定开销。真实调用频率未采；单纯大量 count 查询不是投影构造计数。 |

驱动源另核查：Adapter:400 的 NSTimer 是 `repeats:NO`；:993 是一次快照恢复；:1035 的交互等待最长 2s，:1045 相同 model/account 的恢复最多 3 次（持续新事件另算）。Manager:207 的揭示到期 timer 也是一次性。未找到这条列表链上的 CADisplayLink 或周期 dispatch_source。

全仓其他驱动不冒充已排除：MessageNavigation:241 的 displayLink 属于消息定位并有结束取消；分组设置页 timer（ChatGroupSettings:98）在离开页 :105 invalidate；NativeRewardPresenter:78 的 0.2/2s 回退只在活动支付展示任务中；后台AI/计划任务不是本次双开关自动启动的列表循环，本轮未对其做全量性能审计。

明确存在的持续显示源：`CSTabBarNativeAdapter.m:340`、`:378` 的描边 CA 无限动画（3s/1.2s），需相应设置开启且前台可见才运行。它未绑定分组/密友两个开关；渲染服务/GPU 持续合成不等于主进程CPU 100%，本次是否启用未知。

普通圆角/chrome 排查依据：`CSListCornerRenderer.m:33` 缓存 path 并比较真实 frame/mask/color 后才写；SessionRestore:96/:122 有 depth/restoring 重入门；Adapter:640 只有 header 身份/尺寸变才重设 tableHeaderView；TabContainer:328/:415/:491/:512 对外观/tabs/badge/selection 同值短路。没有源码直接排出下一轮的无条件边。相同 UIKit setter 的内部副作用/原生反复修正布局仍未采，不能保证真机不重排。

## 6. 修复方案候选与推荐

**推荐决策：先完成第 8 节的最小真机取证，不盲改。代码方案首选 A，实施前提是采到折叠摘要的持续重建；它有600/600对照依据，且局限于渲染幂等性，改动面最小。** 对正常可见列表，优先检查方案 A 的折叠摘要重建；对 guard/refresh 占热点的 trace，优先方案 B；方案 C 是已证实 O(N_p) 放大器的独立优化。以下都只是方案，尚未实施，收益指对应函数/操作，非整机CPU承诺。

### A（正常显示列表时优先候选）：使折叠摘要渲染对稳定输入幂等

- 改 `CSCloseFriendSessionPresentation.m` 的 `CSFoldedRenderNativeSummary`/`CSFoldedNativeRenderState`，必要时调整 `SessionGroupHooks.xm` 的渲染触发职责。每次回调仍立即校验账号/策略/摘要身份并遮蔽隐私；把真实内容/几何/主题失效与“主题 token 不可获得”区分，不能用 nil 当作每次必须销毁重建的理由。
- 主题可验证时按稳定输入复用；不可验证时采用现有安全中性摘要 fallback、或由明确的内容/trait/主题失效事件驱动一次重建，不能把“未知主题”草率当作永远未变。需要用实际 trace 确认主题失效渠道后选定，不能简单删除 token 条件。
- 预计收益：对应探针预热后 600 次稳定布局的 native quote/remove 可从 600/600 降至 0/0；仍需保留轻量隐私检查。真实 quote 时间未采，无法承诺百分比。主题可读时当前已是 0/0，不应声称这类环境也能同幅改善。
- 隐私/布局影响：不使用原生全局摘要，不缓存跨账号/策略文本；不改投影行集合、滚动锚点、分组折叠或圆角。未知主题可能显示安全 fallback，存在原生外观差异风险；返回/动态字体/复用必须验证。
- 风险中；估计生产 1–2 文件、40–90 行，专项测试约 60–100 行，总改动小于 300 行。新断言：未知主题 600 次稳定输入不持续拆建；主题/尺寸/标签身份真实变化正确重建；每次锁定/换号立即不显示旧摘要。

### B（若采到 held/layout/refresh 反馈）：分离安全空态和可见投影的就绪/恢复状态

- 改 `CSGroupListAdapter.m` 的 `projectionForSections:`、`performSessionListLayout:`、refresh 收尾及 recovery 准入。安全空投影携带正确 provenance；“未就绪但已安全”不能反复进入无预算普通 dirty 刷新；相同失败账号/epoch/model/policy 进入现有有限恢复机制，真实模型/策略事件才重新尝试。不能仅将 revision=0 改为当前版本，因 `snapshotRetryAttempted` 仍独立阻断。
- 预计收益：对 dirty-until-original 对照，同一失败输入的刷新应从触及 512 硬上限仍排队变为常数级、有界且可被真实事件唤醒；严格 dirty 模型本来仅 4 次，正常有效状态本来仅 1 次，不能声称所有设备都有无限刷新可削。
- 隐私/位置：策略未就绪仍不交付未过滤行；安全空态不得先按未过滤集合布局；保留原锚点/包围盒及手势语义。需专门验证空态恢复滚动位置，不能通过行数/隐藏处理把交互再次冻住。
- 风险中高；生产 1 文件约 50–100 行，测试约 80–120 行，总量小于 300 行。新断言：两种 layout 脏标记模型均有限收敛，0/非0版本一致，真实事件后恢复，首帧行集合/section/y/圆角首末行/offset 全按过滤集合，锁定/解锁/账号边界不放宽。

### C（确定的单次成本优化）：缓存不可变投影的隐私准入证明

- 改 `CSGroupListAdapter.m:648`，必要时在 `CSGroupProjection.h/.m` 提供只读 provenance；将 O(N_p) 全量证明与不可变投影身份、账号、epoch、policy revision 绑定。每次 layout 仍读最新策略/epoch，证明键变化必须在允许原生布局前重新验证；未知/blocked 不得命中缓存。禁止用仅行数/数组地址之类不完整版本作为证明。
- 预计收益：相同已验证投影的后续布局由 N_p 次策略查询降为常数次 token 比较；600 次不变输入可省 599 次全量 scan（99.83% 的重复扫描工作）。按主机 1,000 行/60 scan/s 示例，上限可省约 13 ms CPU/s 的该子步骤；不能将它宣传为必然解决 100%。
- 不改密友规则/解锁语义、行集合、滚动位置、分组折叠、卡片圆角或返回动画；风险在证明失效漏覆盖，等级中高。生产 1–3 文件约 25–70 行、测试约 70–110 行，总量小于 300 行。新断言：稳定投影只全量验证一次；policy/account/epoch/投影替换及同步重入必须先失效，隐藏行任意时刻不进入原生布局。

上述方案不应一次合并大改。原生事件若是实测驱动源，应先在 `onSessionTotalUnreadCountChange:`/native mutation 入口区分真实变化与无效通知，再单独设计不丢内容/隐私更新的修正；不能仅比较 unread 总数就跳过可能伴随的会话内容变化。

不推荐：固定延时、200 ms 降频、隐藏后再显示、动画/透明度过渡、截图 cover、靠整表 reloadData 掩盖。降频只能减少执行次数，不能修复状态不收敛，还会制造最多一个窗口的策略/消息/布局延迟，无法满足即时隐私边界。若未来仅对非隐私装饰做能耗预算，须另立任务；不是本轮推荐方案。

## 7. 风险与最小回归清单

下一轮若获准实施，只按选中方案增加必要断言；本轮没有改 Tests。必须覆盖：

1. 隐私与小程序返回：`verify-miniapp-private-layout`、`verify-close-friend-session`；锁定/解锁、策略变更/换账号/blocked、主/折叠列表、原生索引 scope 包裹时，首个可见集合和几何均安全。
2. 生命周期与恢复：`verify-group-lifecycle`；成功/失败源、相同失败 token、一次或持续失配、外部事件唤醒，队列有界且无遗漏完成回调。
3. 分组/折叠/角标：按方案涉及 `verify-group-selection`、`verify-group-incremental`、`verify-group-badges`；仅当前分组参与、folded 摘要身份正确、同值输入不制造新发布。
4. 位置/返回/搜索：`verify-group-viewport`、`verify-group-search`；不在静止或手势中先生效再回弹，不退回 All；仅改渲染的方案 A 重点覆盖真实 native label/trait/动态字体。
5. 圆角仅做最小回归 `verify-list-corners`，不能借优化修改圆角算法；真机复录验证 cell/card 与返回过渡。
6. 性能新断言只验证上述调用次数/收敛/失效语义，不用依赖机器速度的毫秒阈值假装功能测试。

本轮额外复用了既有 host session/presentation 检查：174 checks/0 failures、55 checks/0 failures（日志 `host-session-presentation.log`）。其作用是确认探针基础契约；不是本轮修复验收，也不是设备性能证明。没有跑无关 AI/备份全量回归，没有 iOS 插件构建、打包或安装。

## 8. 待确认事项与最小真机取证方案

推荐下一步先采，仍不改仓库源码：同一账号/同一列表/同样会话规模，先保持当前配置，各驻留 15–20s，采「双开」「仅分组」「仅隐藏」「双关」四组；先等页面稳定，再完全不触摸。记录是否有折叠入口可见、实际 N_s/N_p/F/H/M、是否启用了悬浮底栏描边动画、CPU 工具/读数口径、机型和微信版本。

**第一阶段：Instruments Time Profiler 附加现有微信进程**，记录每线程 CPU 时间与主线程 Call Tree，并按 1 秒窗口看是否有空闲。持续 Main queue 同一 refresh/guard 栈且无 idle 支持自激；CA/layout 周期栈与间歇 idle 支持脉冲；后台线程若占主要时间，就转向实际队列，不按本文主线程假设继续改。先不加逐调用日志、断点或运行时 wrapper，避免取证工具制造高 CPU。

**第二阶段只在第一阶段指出相关栈后**，经用户确认用工作树外的运行时诊断工具收集聚合计数，不写生产源码：

- 每秒 table/item/cell layout、cover refresh、quote/remove、主题 state nil/非nil、snapshot build 命中/失败原因。
- refresh/publish、reloadData/reloadRows/layoutIfNeeded、guard 各失败位（blocked/account/epoch/retry/revision/含隐藏行）、dirty/recoveryPending/scheduled 的进出值。
- native unread/session 回调次数、modelRevision/policy revision 的变化次数；原生 getter/角标 setter 到通知的调用栈。
- 只在时间窗结束导出内存计数；计数窗口和 CPU baseline 分开采。不要每行 NSLog 或对所有 ObjC 消息打断点。

自然布局是否再次由 quote/hidden/frame 引起，需至少一组“原生layout→插件quote/remove→后继layout”的真实时间/调用栈证据；fallback 需确认 guard 早退后 UITableView 是否仍保持待布局及为何。不会为了取得这些数据先更改仓库代码。

需要用户决策：

1. 是否先按上述最小方案提供四组真机 Time Profiler/必要运行时计数，再确认实施 A/B/C；这是推荐顺序。
2. 若未知主题分支被命中，是否接受该分支使用现有安全中性摘要 fallback 来换取幂等渲染，或必须保持原生 quote 外观（后者需可靠主题失效证据）。
3. 补齐机型/系统与微信版本、CPU 监测工具及读数口径；当前两个开关分别单开时的 CPU 结果尚缺。

## 9. 度量方法、复现与原始数据

所有临时工具均位于 `/tmp`，未写入仓库源码/Tests/脚本，也不提交本轮工具。主机是 Apple M4 / arm64 / macOS 27.0，Apple clang 21。这里只编译允许的 `/tmp` host Foundation 度量小工程，不构建 iOS 插件；Policy 用 process CPU clock，Adapter重放用 thread CPU clock，wall 时间另记。受控 fake main queue 只决定回调顺序/虚拟延时，不提供真机帧率。宿主 /tmp 临时文件可能被系统清理，持久审计保留原始 JSON、输入哈希、具体方法提取记录和编译命令。

| 材料 | 口径 / 复现入口 |
| --- | --- |
| `policy-benchmark.json`、`policy-provenance.json` | 完整未修改 Policy.m，`-O2 -fobjc-arc -fblocks -framework Foundation`；`/tmp/wechat-cpu-closefriend-20261031/policy_bench.m`，每组预热1次，3×200 scan，process CPU clock，H=100。编译链接当前 Controllers/CSCloseFriendPolicy.m 后运行；姓名长度元数据曾从32纠正为31，非耗时/方法改动。 |
| `folded-layout-counters.jsonl`、`folded-layout-provenance.json` | `python3 /tmp/wechat-cpu-8467df87-folded-layout-probe.py /Users/zhangshichao/Documents/Workspace/WeChatImprove`；生产presentation/hook正文+明确UI/quote/theme替身；每组预热后600输入，16组合。 |
| `badge-idle-counters.json`、`badge-idle-provenance.json` | `python3 /tmp/wechat-cpu-8467df87-badge-idle-probe.py /Users/zhangshichao/Documents/Workspace/WeChatImprove`；稳定后600 decision+600 request，后0.4s idle，生产scheduler/decision，UI发布计数替身。 |
| `replay-summary.md/json`、`replay-*-results.json`、`replay-source-provenance.json` | `/tmp/wechat-221-cpu-replay/` 的 `build.py` 提取当前完整生产方法；布局脏标记双模型与always-layout正控制；512队列任务硬上限；N=100/1000/10000，M=4/12，V=12。运行 `CP_REPO=/Users/zhangshichao/Documents/Workspace/WeChatImprove CP_OUT=/tmp/wechat-221-cpu-replay-reproduced /tmp/wechat-221-cpu-replay/run.sh`；完整方法提取SHA、运行命令和边界见summary/provenance。 |
| `refresh-layout-inventory.txt`、`drivers-inventory.txt` | 当前文件的 rg 原始搜索；静态有/无某类驱动源的证据，不是调用频率。 |
| `source-provenance.json` | 检视生产文件的 HEAD/工作树逐字节哈希对应，行号均锁定本 HEAD。 |
| `preservation-before.json`、`preservation-after.json` | 50,414个已跟踪文件及1,337个 packages/.theos历史文件的前后哈希；原有 .DS_Store 变化和feedback素材保留。 |
| `temporary-tools.json`、`host-environment.json` | 外置工具位置/哈希与主机环境，区分工具与被测生产输入。 |

重放计时 Top 不含微信 native DB/真实 UI/真实服务反射开销；生产方法入口计数含同步嵌套，inclusive 与 self 都有记录。性能规模测试读取 `profile.refresh.inclusiveCPU_ns`，不能把仅队列 pump 的耗时当作 direct refresh 总时间。原始日志中测试模型、次数、单位均保留。`replay-result-validation.log` 是60项分析工具结果关系核对、0失败，单列保留，**不计入产品测试通过数**。

## 10. 本次未验证的部分

- 真机 100% 的线程归属、单核/总核口径、持续忙转还是有间歇的脉冲；没有伪造 Instruments 数据。
- 静止时自然 table/item/cell/cover/notify 的每秒频率；60 Hz 与600输入均为实验条件。
- 当前手机主题接口是否返回 nil，native quote/remove 的真实 CPU 成本、真实 UIView 身份以及是否引发下一轮布局。
- guard 早退后 UITableView 的自然 dirty 生命周期；主机两个模型都合理地限制了结论，不能任选一个当手机事实。
- native snapshot 是否失败、失败原因、实际 F/N/H/M、原生GetLastMsg/摘要格式化的数据库或字符串代价。
- 原生 getter/setter 是否触发同值通知、policy/model revision 是否自然风暴；源码中的插件侧稳定短路不能排除原生反馈。
- 底栏CA动画是否开启及 compositor/GPU 与微信进程CPU的实际占比；没有对无关AI/计划任务做性能全审计。
- 候选方案的整机收益、首帧屏幕隐私、滚动手势、圆角/返回过渡的真机表现。方案尚未实施，没有修复后结果或新安装包。

本轮只形成分析与候选方案，等待用户确认；没有构建插件、打包、提交或推送。
