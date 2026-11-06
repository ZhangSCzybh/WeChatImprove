# 2.2-8 临时运行观察候选：尚未附加或运行

本目录是离线方案。未附加、注入、重装微信或修改生产源码，未修改设备数据与配置。`observer.js` 仅供后续独立观测轮审阅，不能当成本轮已经得到的设备数据。

当前安装包未包含分组调用计数、每轮时钟或 signpost。Instruments 的 Time Profiler 栈采样可以定位 CPU 热点，无法恢复精确调用次数、每轮开始/结束和零采样短调用。Core Animation Commit 也不等于 `reloadData`，更不等于分组重算。若需要补齐这些指标，可以在原安装包上临时附加观察器；必须把该轮与未注入的 Instruments 基线分开。

## 实现证据和指标语义

| 源码边界 | 可准确计数/计时的事件 | 不能直接推断的指标 |
| --- | --- | --- |
| `CSGroupNativeSessionCoordinator.m:524`，`-applyBaselineCandidate` | 一次候选模型应用的同步墙钟时间 | 入口含缓存复用、策略检查、原生数组发布和拒绝路径；不是每次重算 |
| `CSGroupNativeModel.m:79`，`+modelByUpdatingResult:changedUserNames:rowProvider:` | 一次增量模型 API 尝试；nil 表示拒绝增量并要求回退，非 nil 含空名单直接返回旧对象 | 不能把每个非 nil 都视作做了有效计算，也不能把尝试次数当消息数 |
| `CSGroupNativeModel.m:119`，`+buildWithTopSessions:normalSessions:allTopSessions:allSessions:tabs:selectedTabID:groupingEnabled:filterDuplicates:accountID:hiddenUserNames:privacyRevision:scopeFoldedEntry:foldedRows:rowProvider:` | 一次完整模型 API 调用的同步墙钟时间 | 返回值可能是无效结果；方法正常返回不代表发布成功 |
| `CSGroupNativeSessionCoordinator.m:543,552,754` | 模型 API 在 `applyBaselineCandidate` 内外的调用上下文 | 完整源临时读取也能建模型；它不一定属于主聊天列表 UI 更新 |
| `CSGroupListAdapter.m:1181,1005`，`-refresh`、`-refreshNativeSessionModel` | 刷新尝试；各自包含的同步耗时 | 两者嵌套，不能相加；都含发布中/交互中/后台早退及排队路径 |
| `CSGroupListAdapter.m:1325`，`-publishNativeProjection:previous:changes:changedUserNames:previouslyProjecting:` | 原生模型路径到达列表发布阶段的次数和同步耗时 | 一次发布可能仅更新角标、不请求表格刷新 |
| `CSGroupListAdapter.m:1372`，`-publishProjection:previous:changes:previouslyProjecting:` | 兼容路径到达列表发布阶段的次数和同步耗时 | 与原生发布分开，不能默认为当前使用兼容路径 |
| `CSGroupListAdapter.m:1349,1367`，目标表 `-reloadData`、`-reloadRowsAtIndexPaths:withRowAnimation:` | 主列表表格完整刷新请求、局部刷新请求；并按是否处于插件发布作用域分开 | 不等于屏幕实际重绘帧数；局部请求数不等于行数；作用域只是同步因果边界，其他同步观察者也可能在范围内执行 |
| `WESessionTabContainerView.m:412`，`-updateTabs:` | 更新尝试；`renderedTabRecords` 对象是否更换，区分 no-op 与真正重建记录/按钮路径 | 尝试次数不能称分组栏重建次数 |
| `WESessionTabContainerView.m:488`，`-updateUnreadCount:hasRedDot:forTabIndex:` | 一次角标更新尝试 | 此入口有值未变直接返回；不是实际角标变化次数 |
| `WESessionTabContainerView.m:503`，`-selectTabAtIndex:animated:` | 选择尝试；`selectedIndex` 前后数值变化表示视觉选中项改变 | 不等于分组内容已发布，指示器动画也可能尚未结束 |
| `CSGroupListAdapter.m:1936`，`-selectIndex:` | 内容切组请求及其同步处理耗时 | 可能因菜单、下标或账号边界拒绝，不能叫成功切组数或“点击到首帧”耗时 |

`-consumeRefreshRequest` 也被 `cancelScheduledRefresh` 与无脏数据的排队任务调用，不适合作为“每轮有效计算”计数。没有一个单一方法能同时准确表示模型计算、缓存命中、表格刷新、分组栏重建和最终显示完成，报告应保留这些不同事件。

## 候选实现

`observer.js` 使用 Frida 17 的核心 `NativeFunction`、`Interceptor` 和 libobjc C runtime 解析当前方法 IMP，不依赖 Frida 17 普通 Python `create_script` 中未必存在的 `ObjC` 全局，也不需要安装 bridge。Frida 工具包的 REPL 自带按需 bridge 加载，不能把 REPL 环境直接等同于 Python 的纯脚本环境。

候选只读取插件自己的表、控制器、分组栏指针，分组栏记录对象身份，以及选中项数值。它不读取或输出消息文本、用户名、联系人、分组名称、分组 ID、未读数、偏好或数据库。不会主动刷新、调用原生会话 getter、选择组或写入配置。输出为事件统计，不包含栈、对象内容和用户标识。

加载后保持停用。等待一次自然主列表刷新发现 `NewMainFrameViewController` 对应的表和分组栏后，`status()` 必须显示两者已发现，才能通过 `arm()` 开始正式计数。初始化前/发现前的调用不计入窗口。不能在未发现目标时把静置零事件解释为有效的零刷新。观察器不通过全堆枚举或主动触发刷新寻找对象。

候选会读取模型方法所在 Mach-O 的 `LC_UUID`，只允许已经交付的 4 个 2.2-8 架构/环境 UUID。此检查仅证明方法实现所在模块版本，不替代进程 bundle ID 的外部确认。附加前仍须由设备进程列表把 PID 映射到 `com.tencent.xin`，避免误测双开 `com.tencent.zsc`。未附加前不能证明设备支持当前 Frida 服务/目标附加；目前只确认了本机有 Frida 17.8.2 和 USB 设备枚举能力。

调用计数在入口累计，耗时仅在正常退出累计。增量 nil/non-nil 独立计数；模型按 `applyBaselineCandidate` 作用域拆为 `main_apply` 与 `other_context`。同一主表的刷新请求在重入/继承转发时只统计最外层请求，并区分插件发布内外。表的当前实际类 IMP 会在发现时解析；若运行中再次被其他插件 swizzle，需要重新验证覆盖范围。这里只覆盖 `reloadData` 和 `reloadRows...`，没有声称覆盖宿主所有批量插入、删除和移动更新 API。

`stop()` 返回累计统计与 P95，每个指标最多保留 65,536 条正常返回耗时；超限返回 `samplesTruncated=true`，P95 置空。未发生的指标缺席，不能把缺席误写成已经验证为零。停止时仍有在途作用域、正常返回数小于入口数、脚本错误、异常展开导致作用域不平衡、模块/表替换，均需标记窗口不完整。计数只能声称覆盖本观察器已安装并正常工作的方法。

`detach()` 只卸载本脚本的监听器；正常实验结束还应卸载脚本/分离会话。未构建启动器，未提供自动附加命令，防止将尚未实测的候选误认为已可直接执行的设备工具。

## 性能开销和结果限制

JS 回调在每次入口/退出进入 Frida 运行时，另外存在单调时钟调用、作用域统计、对象身份检查和数值 getter 开销。每轮不发送日志，停止时一次返回聚合，减少通信干扰；这仍不能使观察无成本。嵌套指标的墙钟时间还会包含内部观察点开销。

此前主机模型增量基准约 0.0345 ms。该量级与临时运行观察开销可能相近，不能从观测时间直接推断原始模型真实耗时，也不能用测得的固定空探针成本可靠地扣除全部扰动。候选更适合查“真实调用/刷新次数”和毫秒级异常轮次。所有耗时应标成 **Frida 观测轮的同步墙钟耗时（含探针与调度开销）**，不称纯计算 CPU 时间；在途请求、异步等待和点击到实际呈现的延迟另论。

CPU、系统帧和 hitch 以独立的未注入 Instruments 轮次为基线。若同时运行观察器，应保存为独立观测组，记录加载/卸载时间，并做相同场景的无观察/有观察 A/B，评估总体 CPU 和 hitch 扰动。不能混用基线 CPU 与观测器调用耗时，计算所谓精确插件 CPU 百分比。若要可靠测量极短模型路径，下一步应考虑低成本原生探针/自定义 Instruments signpost 构建，并同样单独验证开销。

## 离线校验范围

仅进行 JavaScript 语法检查及源代码交叉核对。尚未在设备验证 Frida 服务器版本、附加权限、iOS 27 的 Interceptor/PAC、异常处理、当前具体 UITableView 子类、runtime 方法签名及附加稳定性。语法通过不能作为真机可用、计数准确或开销可忽略的证据。
