# 分组原生 signpost 观测构建

本目录说明本轮新增的独立观测模块。此模块已完成离线语法校验；**尚未在设备安装、运行或验证采集开销**。这里没有新增真机性能结果，也不替代 2.2-8 的 Instruments 基线。

## 构建隔离

`CS_GROUP_PERFORMANCE_OBSERVATION` 默认值为 `0`。正式构建由 Makefile 从源文件列表排除 `Controllers/CSGroupPerformanceObservation.m` 和 `Hooks/SessionGroupPerformanceObservation.xm`；头文件中的声明也受同一宏保护。正式包不得含此模块的 Logos 初始化、hook、signpost 名称、`CSGroupPerformance*` 实现符号或运行路径。最终以正式构建和 Mach-O 检查为证，不能仅凭宏的默认值声明没有观测代码。

观测构建显式启用该宏，包含同一份生产实现及独立的观测源文件。分组模型、排序、账号、偏好和隐私配置不由观测模块修改。观测模块不主动刷新、不调用会话 getter、不遍历用户数据，也不输出任何消息、用户名、联系人、分组名称、分组 ID 或账号。

日志的固定 subsystem 为 `com.wechatimprove.performance`，category 为 `SessionGroups`。仅使用 `os_signpost_interval_begin/end` 与 `os_signpost_event_emit`，没有 `NSLog`、`printf`、文件写入或逐次字符串格式化。可变载荷只有固定枚举和数值计数。

## 计时和计数语义

区间计时均为**观测构建中的同步墙钟耗时，包含区间内的观测开销**，不是线程 CPU 时间，也不是点击到首帧耗时。嵌套区间不能相加；例如 `CoordinatorApply` 已包含其中的模型调用，`AdapterPublication` 已包含其中的表格刷新。

| 固定区间名称 | 一次区间代表的调用 | 结果与限制 |
| --- | --- | --- |
| `ModelFull` | 完整原生模型 API 调用 | `Valid` 表示返回有效结果；`Rejected` 表示返回无效结果，均不代表随后成功发布 |
| `ModelDelta` | 增量模型 API 尝试 | `Fallback` 表示 nil；`Reused` 表示直接返回原结果；`Valid` 表示返回另一个有效结果 |
| `ModelSelection` | 切组选择复用 API 尝试 | 结果区分同上；nil 要求完整构建，不是成功复用 |
| `CoordinatorApply` | `applyBaselineCandidate` 调用 | 含缓存、策略检查、模型调用和原生应用；`Ready` 仅表示返回时模型有效且没有边界，不能当成原生数组写入次数 |
| `AdapterRefreshAttempt` | 原生模型路径 `refreshNativeSessionModel` 尝试 | 含发布中、交互中、后台和边界等早退；不可称为有效重算或实际刷新次数 |
| `AdapterPublication` | 到达 `publishNativeProjection:…` 的发布调用 | 发布可能仅更新角标、没有表格刷新；表格目标验证失败时仍可能有区间，必须查目标事件 |
| `MainTableReloadData` | 已验证主表在原生发布作用域中进入 UIKit `reloadData` | 计数范围仅限此同步发布作用域；不包括宿主在作用域外的刷新 |
| `MainTableReloadRows` | 已验证主表在原生发布作用域中进入 UIKit `reloadRowsAtIndexPaths:…` | 调用数与请求行数分开；`units` 为该调用的路径数量，不记录路径值 |
| `TabRecordsUpdateAttempt` | 分组栏 `updateTabs:` 调用 | 记录对象身份未替换为 `Unchanged`，实际替换为 `Completed` |
| `TabLayout` | 分组栏 `layoutSubviews` 的实际执行 | 不等于重建按钮次数，也不等于 CA 提交或呈现帧数 |

模型 API 也可能服务于完整源临时读取。只在同一线程 `CoordinatorApply` 区间内的模型调用可归入本轮候选应用；区间外的模型调用须另列，不能全部称为主列表刷新重算。已知/未知变更事件只是来源提示，不直接证明完整构建的具体回退原因。

所有区间结束都带有 `outcome` 和 `units` 数值。结果枚举如下：

| `outcome` | 语义 |
| ---: | --- |
| 0 | 原调用或观测完成前抛出异常；`@finally` 仍配对结束区间并恢复发布作用域，异常继续传播 |
| 1 | 正常完成 |
| 2 | 模型返回有效的新结果 |
| 3 | 模型返回无效结果 |
| 4 | 可选模型路径返回 nil，要求回退 |
| 5 | 返回传入的原结果对象，直接复用 |
| 6 | 协调器返回时模型有效且非 boundary |
| 7 | 协调器返回时未满足上述 ready 条件 |
| 8 | 分组栏记录对象未替换 |

固定事件作为实际完成计数或归属校验：

| 固定事件名称 | 每个事件的含义 |
| --- | --- |
| `MainTableTargetVerified` | 发布入口的表等于该 Adapter 已绑定的表，且仍使用原生模型。`units` 为 reload 派发验证位：1=`reloadData`，2=`reloadRows…`，3=两者均验证 |
| `MainTableTargetUnavailable` | 当前发布无法确认主表目标；本次对应统计不能填零 |
| `ReloadDispatchUnverified` | 目标表至少一个方法被具体子类覆写，无法确认它会进入被观察的 UITableView 实现；`units` 为仍已验证的位掩码，未验证项须列为不可用 |
| `PublicationCompleted` | 验证目标后的原生发布方法正常返回；不表示刷新了表格 |
| `ReloadDataCompleted` | 被观察的已验证主表完整刷新方法正常返回 |
| `ReloadRowsCompleted` | 被观察的已验证主表局部刷新方法正常返回，`units` 为路径数 |
| `TabRecordsRebuilt` | `updateTabs:` 正常返回，且 `renderedTabRecords` 对象身份与入口不同，即实际进入记录/按钮重建路径 |
| `KnownChangeHint` / `UnknownChangeHint` | 协调器变更入口收到具名完整提示或未知范围提示。`units` 仅为 `CSGroupChangeKind` 位掩码，不含名称；不能直接解释成消息条数或回退原因 |

原生发布作用域使用线程局部的栈节点保存主表指针。嵌套发布结束或抛出异常时恢复外层，其他队列不继承作用域；其他表格、折叠列表以及发布作用域外的调用均不纳入主表计数。只覆盖列出的两个刷新 API，没有声称覆盖宿主所有批量插入、删除或移动 API。若运行中又有其他插件 swizzle 或替换表格，须重新验证归属和派发覆盖。

## Instruments 采集方法

1. 单独保存正式构建与观测构建的包、dSYM、SHA256、构建宏和 Mach-O UUID。使用明确的观测包标识，不能与正式包混淆。安装和重启操作另行按既有用户授权执行，本模块本身没有部署设备。
2. 用 `devicectl device info processes` 把 PID 对应到 `com.tencent.xin`，确认微信仍为 8.0.78；同机 `com.tencent.zsc` 不能混用。采集前确认真机亮屏、前台聊天列表、热状态 Nominal，保留设备/微信/插件版本和采集起止时间。
3. Instruments 创建独立文档，加入 **os_signpost**（可在 Instruments 的 Instrument Library 搜索）、Activity Monitor、Frame Lifetimes、Core Animation Commits 和 Thermal State，按已验证能力选择目标进程。不要使用已在本机触发 `tagged-backtrace` 内部错误的旧 Animation Hitches 组合。
4. 配置 signpost 采集包含上述 subsystem/category；先录短 smoke，切换一次分组并返回。须能看到 `ModelSelection`、`AdapterPublication`、`MainTableTargetVerified(units=3)` 以及配对区间。若没有这些证据，先排查日志启用/目标/构建，不得把空表解释为零计算、零刷新。若 `ReloadDispatchUnverified` 出现，只报告已验证的指标。
5. 正式分别采集静置、连续收消息、滚动和切组。动作开始时另记外部时间标注，剔除等待提示和人工反应时间；每场保留完整 trace。对采集边界的未完成区间、丢事件、作用域不配对、目标重启/替换或热状态变化作明确标注，必要时重录。
6. 在同一分析窗口内按固定区间统计尝试次数、各 outcome 数量以及完整区间耗时的中位数/P95/最大值。表格刷新分别统计入口区间、正常完成事件和局部行数；分组栏更新尝试、记录重建与布局单列。任何未验证归属或覆盖项均用“未取得”，不补零。

观测前热身应在正式分析窗口之外完成，并保留目标和派发验证证据。静置窗口可能没有发布，只有在同一进程、已验证目标/方法、收集没有中断或丢事件的条件下，才可以说“本窗口内未观察到这些受覆盖调用”；不能扩展成所有宿主刷新 API 都为零。

## 探针开销验证

这些探针没有磁盘写入和用户字符串处理，但仍存在 Logos 方法转发、启用判断、signpost ID、系统事件提交、少量结果 getter 和主表方法归属校验开销。`TabRecordsUpdateAttempt` 暂时保留入口记录对象以比较对象身份。特别短的增量模型不能假定观测开销可忽略。

需要在同一设备、相同数据、相同消息速率、相同动作节奏及 Nominal 温度下，至少对照三档：正式构建；同份观测构建且 signpost 采集关闭；观测构建且 signpost 采集开启。分别比较全微信 CPU、hitch、实际调用次数及耗时分布，改变场景顺序或冷却后重复，避免只比较先后两轮热状态不同的数据。

未完成这个对照前，计时只能标为“观测构建耗时”，不能声称是未观测正式包的纯计算时间，也不能简单扣除一个固定空探针成本。CPU/帧数据须与所属构建和采集配置一起报告；没有同设备旧版对照时，不能给出整体 CPU 降幅。

## 当前验证

`syntax-result.json` 记录 Logos 转换和 iOS 15.0 / arm64 的离线语法检查：观测 API 与生成的 hook 在宏 0、宏 1 均通过。`*-syntax.log` 和 `logos-generation.log` 为相应编译诊断。Root 另负责两档的完整双架构构建和正式 Mach-O 排除检查。

本目录不声称已通过真机烟测、UIKit 子类覆盖验证、采集完整性或探针开销验证。首次安装观测构建后的有效采集，才可以补齐这些证据。
