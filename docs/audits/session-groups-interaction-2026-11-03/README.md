# 2.2-9 分组交互优化与独立性能观测

本轮承接用户已安装 `2.2-8` 后的 Instruments 分析，实施刷新调度、切组计算复用及独立观测构建。所有修改在既有 checkout 完成，构建在冻结的临时副本中运行。没有安装或重启手机微信，没有改动账号、偏好或用户数据。

设备参考仍是用户此前确认的 iPhone 14 Pro Max / iOS 27.0.1、微信 8.0.78、`com.tencent.xin`。本轮交付尚未在该设备运行，因此没有新的手机 CPU、掉帧或刷新实测结果。此前四场景原始采样与归属限制保存在 [2.2-8 Instruments 基线](../session-groups-instruments-2026-11-03/README.md)。

## 本轮改动

### 1. 统一交互期间的刷新等待

`CSGroupListAdapter` 新增 `refreshInteractionIsBlocking`，原生刷新入口和调度器共同检查 tracking、dragging、decelerating、editing、swipe、分组手势及原生菜单状态。

此前刷新入口会在 decelerating 时拒绝发布，但调度器只考虑 tracking、分组手势及菜单移动位。手指松开后 tracking 先结束，列表仍在减速，dirty 刷新可反复执行“立即入队 → 拒绝发布 → 再次立即入队”。该触发条件由真实生产方法提取回归重现，不能据此断言它占用了之前手机采样中多少 CPU。

现在这些交互共用 50/100/200/400 ms 的有界退避，最长等待预算 2 秒；预算耗尽后保留 dirty，由真实滚动结束、编辑结束、菜单完成和手势终态等事件唤醒，发布合并后的最新内容。隐私紧急刷新继续绕过交互等待；显式挂起的原生导航沿用其既有处理。

### 2. 切组复用完整源元数据

协调器的共享配置 key 保留账号、epoch、隐私 revision、隐藏集合、分组定义和去重等边界，把所选分组作为单独的选择步骤处理。相同完整来源和配置下，`modelBySelectingTabID:fromResult:foldedRows:` 复用源元数据、对象索引、成员及适用的角标统计，再建立目标组的显示映射和原生数组。

这里只保存一份完整源边界；不建立无限增长的“每个组一份原生数组”缓存。切组结果保持原生对象身份和顺序；模型间共享不可变计算信息，不形成历史模型引用链。

“全部”使用原生折叠聚合展示，筛选分组使用按成员限定的折叠入口。跨这两类展示范围切换时，从已有复制值重建投影及统计，避免复用不适用的 aggregate 规则；仍不重新读取全部主会话元数据。同范围的筛选分组切换直接复用成员与角标缓存。

折叠子会话有独立来源，稳定的主列表 baseline 不能证明它没有变化。因此在切组或增量复用前，重新读取轻量折叠快照，比较 nil/空数组、数量、顺序、身份、路径、类型、分类、置顶、未读、红点、排序、摘要及展示字段。任何不匹配都回到完整构建。已知增量和切组在同一轮发生时，先验证折叠边界，再更新命中会话，最后选择目标组。

主列表来源、账号、epoch、隐私和发布前后的重入校验均保留。全链路仍有 O(N) 身份与槽位验证，不能描述为“切组完全零遍历”。未知范围更新、结构变化、分组配置编辑和隐私边界变化继续完整校验。

### 3. 独立原生性能观测

正式构建 `CS_GROUP_PERFORMANCE_OBSERVATION=0`，Makefile 明确排除观测 `.m` 和 `.xm`。独立观测构建 `2.2-9+observe` 才启用固定名称的 `os_signpost`，记录模型完整/增量/切组调用、刷新尝试、发布、已验证主表 reload、分组栏记录重建及布局。

观测不写逐次文本日志，不记录用户名、账号、消息或分组名称。区间为含探针的同步墙钟耗时，嵌套区间不能累加。刷新尝试、成功模型、发布、表格刷新及 CA 提交是不同指标；目标或具体表类派发不能验证时标为未取得，不能填零。指标枚举、采集及开销对照见 [观测说明](observation/README.md)。

## 验证与局限

验证代码位于本审计的 `validation/`，从生产源提取实际 Adapter 调度/刷新方法及原生交互结束 Hook，并直接编译真实 Model、Projection、Coordinator、Bridge 等实现。历史审计和已删除的根 `Tests/` 不作恢复或改写。

主机选择对照在 `selection-benchmark/`：真实冻结 `2.2-8` 与本轮最终实现，使用 1200 条会话加一个折叠入口、24 个自定义组、100 个折叠子会话、每轮 120 次切组，共 5 轮。模型指纹核对原生数组顺序、分组会话数、角标和折叠展示；主会话元数据读取减少与主机模型耗时分别记录。测量不包含折叠源采集、完整来源身份验证、UIKit、手机 CPU 或帧表现。

最初计时与完整打包并行，单独保留为首次记录；最终使用 `selection-benchmark/rerun-final/`：开始时没有匹配的构建/基准进程，结束时记录到两个 clang 验证编译进程。因此最终计时也包含主机并发局限；起止进程记录不代表中途完全没有后台负载，时延只作本机输入下的参考，不能换算为真机 CPU 降幅。补齐最后 6 个异常 folded 展示字段比较之前的安静重跑另存 `rerun-isolated/`，不将其哈希混记为最终源码。

最终主机模型对照（每次切组耗时中位数）：

| 场景 | 冻结 2.2-8 完整构建 | 2.2-9 选择复用 | 每轮主会话元数据读取 |
| --- | ---: | ---: | ---: |
| 筛选分组之间切换 | 6.223 ms | 0.328 ms | 144,120 → 0 |
| “全部”与筛选分组切换 | 8.097 ms | 2.010 ms | 144,120 → 0 |

两条路径的 28 个目的组指纹均与完整构建一致。这里的 0 仅指切组模型新增主会话元数据读取，不包含完整来源身份验证和每次新读取的折叠快照。计时上下文与最终源码哈希见 [最终主机对照](selection-benchmark/rerun-final/comparison.json) 及同目录 JSON。最终行为断言与负对照结果见下方。独立只读代码审查未发现本轮阻断问题，并补充了混合隐藏/可见 folded children 的等价回归。

最终通过 **3,961 项唯一行为断言**：原生模型/协调器/Bridge/Adapter 等 3,383 项（含旧 389 项及新增切组 2,994 项）、未读面板 77 项、ABI 7 项、既有核心 393 项、独立交互调度 101 项。单独运行的切组对照不重复计入总数。32 个来源/折叠/隐私/去重/可选能力组合执行 192 次切组，原生数组、映射、角标及折叠元数据与完整构建等价。

冻结 2.2-8 的真实刷新和调度方法，在固定时刻执行 64 个即时任务后仍有待执行任务；修复版在同触发条件下不执行即时刷新任务，并覆盖有界等待、最后状态发布、原生结束 Hook、隐私优先及离屏原生动作例外。协调器另以 120 条会话验证五次切组，旧版每次 120 次未读 getter，新版均为 0。

四类负对照均命中预期失败：临时恢复整表刷新、恢复旧恢复预算重置、恢复交互等待条件不一致、把 selectedTabID 重新加入共享配置 key。变体只存在于临时提取/复制代码，生产未改写。最初把交互 fixture 与既有重入 fixture 放在同一进程导致受控宿主行数前提互相影响；改为独立进程后通过，原失败输出保留在 `validation/interim/`。这是验证夹具隔离修正，未改变生产逻辑或原断言。

完整命令、范围和局限见 [验证说明](validation/README.md)；[最终验证完整性](validation/final/validation-integrity.json) 确认 378 个生产输入、18 个夹具输入及全部最终运行的源哈希一致。

## 交付

| 用途 | Rootless | Rootful |
| --- | --- | --- |
| 正式版 `2.2-9` | [iphoneos-arm64.deb](../../../packages/2.2-9-session-groups-interaction-final/com.wechat.improve_2.2-9_iphoneos-arm64.deb) | [iphoneos-arm.deb](../../../packages/2.2-9-session-groups-interaction-final/com.wechat.improve_2.2-9_iphoneos-arm.deb) |
| 观测版 `2.2-9+observe` | [iphoneos-arm64.deb](../../../packages/2.2-9-session-groups-interaction-observe-final/com.wechat.improve_2.2-9+observe_iphoneos-arm64.deb) | [iphoneos-arm.deb](../../../packages/2.2-9-session-groups-interaction-observe-final/com.wechat.improve_2.2-9+observe_iphoneos-arm.deb) |

正式版的 [dSYM](../../../packages/2.2-9-session-groups-interaction-final/com.wechat.improve_2.2-9_symbols.zip)、[SHA256SUMS](../../../packages/2.2-9-session-groups-interaction-final/SHA256SUMS)；观测版的 [dSYM](../../../packages/2.2-9-session-groups-interaction-observe-final/com.wechat.improve_2.2-9+observe_symbols.zip)、[SHA256SUMS](../../../packages/2.2-9-session-groups-interaction-observe-final/SHA256SUMS)。两种包使用同一包标识；按实际注入环境选一种安装包，观测版用于专门采集。

冻结打包脚本为 [build-packages.py](build-packages.py)。不执行根目录 `make clean`，历史安装包保持原哈希。观测构建只在其冻结副本中同步改写 package/display/release-note 的版本标记，源码实现与正式版一致。最终构建记录在 `builds/final/normal/` 和 `builds/final/observation/`；首轮打包记录与候选产物保留，但本页链接以上表 final 目录为准。

构建检查包版本、安装前缀、arm64/arm64e 双架构、原生优化方法、dylib/dSYM UUID 和产物 SHA256。另由 [verify-delivery.py](verify-delivery.py) 分别检查各 Mach-O slice，证明正式版无本轮探针字符串、实现符号或 signpost import，观测版包含相应探针；核对当前生产源、既有删除和历史采样。结果写入 `delivery-integrity.json`。

后续真机验证应先确认当前加载版本，再按原来的静置、连续收消息、滚动和切组场景复测。使用观测包时先验证 signpost 配对、主表目标和派发覆盖，并对照正式版、观测关闭、观测开启三档开销。温度、输入速率和操作节奏应一致，特别避免沿用上一轮切组场景的 Fair 热状态直接比较。

最终交付校验通过：四个包的两个 Mach-O slice 均与预期探针配置一致；当前生产源与冻结输入匹配，375 个基线文件、6,892 个既有跟踪删除、2,075 个此前 Instruments 证据文件及历史安装包均保持。详见 [交付完整性](delivery-integrity.json)。
