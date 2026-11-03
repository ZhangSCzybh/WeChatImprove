# 2.2-8 分组功能真机 Instruments 采样

2026-11-03，在用户连接的 iPhone 14 Pro Max 上采集了静置、连续收消息、滚动聊天列表、切换分组四个场景。四份正式 trace 最终均保存并退出 0，所选分析窗口的目标微信 CPU 数据覆盖率均为 100%，无缺口。已取得整微信进程 CPU、Core Animation 提交与有明确适用范围的帧呈现延迟数据；**分组每轮计算耗时和精确刷新调用次数仍未测得**，不能将本次调查描述为已完成分组内部性能归因。

本次按用户确认的实际安装版本 **2.2-8** 测量。未进行 2.2-7 同设备对照，因此不能据此给出相对 2.2-7 的手机 CPU 降低比例。此前 macOS 模型基准也不能替代本次真机指标。

## 设备、目标和环境

- iPhone 14 Pro Max / iPhone15,3 / A16，iOS 27.0.1（24A446）。
- 微信 8.0.78（设备安装元数据为 8.0.78.34）；目标为用户明确确认的 `com.tencent.xin`，PID `37813`。设备同时运行的 `com.tencent.zsc` 不作为分析目标。
- Xcode 27.2（27B52），xctrace 27.2；保留现有项目 checkout `/Users/zhangshichao/Documents/Workspace/WeChatImprove`。
- 插件版本依据用户安装确认；正式 trace 的已导出二进制元数据没有提供可独立校验的插件 UUID，未把该项写成已验证。
- 没有重装/启动/重启微信、切换账号、修改分组、偏好或数据库，也没有修改生产代码。采样结束后设备查询仍显示原微信 PID `37813` 存活。没有遗留本任务的 `xctrace record` 进程。
- 正式采样使用 Activity Monitor、Frame Lifetimes、Core Animation FPS、Core Animation Commits；静置另显式添加 Thermal State，其他 trace 同样导出了热状态。静置、收消息、滚动的热状态导出记录 Nominal。切组在 trace 第 40.358 秒从 Nominal 变为 Fair：主窗口前 15.358 秒为 Nominal，后 29.642 秒（65.87%）为 Fair。没有证据据此确认具体降频，但四景不能视作同温度条件的受控比较。

## CPU 和渲染提交实测

CPU 是 **微信整个进程** 的消耗。100% 代表占满一个 CPU 核心，不能将 35% 解读为整台设备所有 CPU 能力的 35%。均值和 P95 按区间时长加权；峰值为约 1 秒区间的最高样本值，不是瞬时峰值。累计 user+system CPU 时间的首尾差作了独立交叉核对，没有对累计计数求和。

| 场景 | 有效窗口 / 时长 | CPU 均值 | CPU P95 | CPU 最高样本 | 微信 CA 提交数 | CA 提交 / 秒 |
| --- | --- | ---: | ---: | ---: | ---: | ---: |
| 静置聊天列表 | [5,65) / 60 秒 | 3.14% | 4.74% | 10.07% | 3 | 0.05 |
| 连续收消息 | [20,65) / 45 秒 | 18.72% | 29.57% | 36.03% | 183 | 4.07 |
| 滚动聊天列表 | [25,65) / 40 秒 | 35.17% | 42.31% | 43.69% | 4120 | 103.00 |
| 切换分组 | [25,70) / 45 秒 | 18.82% | 28.78% | 59.80% | 720 | 16.00 |

**CA 提交是渲染事务提交，不能当作分组重算、`reloadData`、局部刷新或分组栏重建的调用次数。** 滚动期间的大量提交包含持续运动的渲染工作，不能凭这一列断言分组在重复全量计算。

用户在每个开始提示后手动执行相应动作，并在三个动作场景之后明确确认“三项都按提示完成”。原始录制为 70/70/70/80 秒；为了避开工具启动、提示与人工反应的准备时间，动作场景使用更短的保守窗口。没有自动动作标签或屏幕录像，不能声称精确到每次触摸时间或确切消息速率。提示与窗口依据保存在 [operator-cues.json](operator-cues.json)。

## 帧呈现延迟实测

以下 hitch 表示 Frame Lifetimes 记录到错过预定呈现时间的生命周期。表中分母是去重后且具有明确 on-time/hitch 分类的生命周期记录数，**不是用固定 60/120 Hz 反推的理论帧数**。生命周期可能重叠，一条 hitch 也可能跨越多个显示周期，因此此处不把事件数称作精确“丢了多少帧”，也不将生命周期事件密度当作实际呈现 FPS。

| 场景 | 帧数据适用范围 | 已分类记录数 | 正 hitch 数 / 占比 | hitch 合计时长 | 正 hitch P95 | 最长 hitch |
| --- | --- | ---: | ---: | ---: | ---: | ---: |
| 静置 | 设备显示范围 | 3599 | 0 / 0.00% | 0 ms | 无正事件 | 0 ms |
| 连续收消息 | 已核对目标微信采集范围 | 2712 | 48 / 1.77% | 1706.00 ms | 50.05 ms | 66.73 ms |
| 滚动 | 已核对目标微信采集范围 | 4317 | 29 / 0.67% | 299.44 ms | 16.72 ms | 37.08 ms |
| 切组 | 设备显示范围 | 3229 | 87 / 2.69% | 2608.29 ms | 58.42 ms | 66.76 ms |

连续收消息与滚动 trace 均独立核对了 TOC 中 attached PID `37813` 及 `coreanimation-lifetime-interval target-pid=SINGLE`。静置与切组采用 all-processes；该帧表为 `target-pid=ALL` 且逐行没有 PID，故只能报告设备显示范围，**不能将这些帧全部归因于微信或插件**。两类范围不能直接当作同口径的应用帧率横向比较。四景 CPU 和 CA 提交始终严格筛选目标 PID。

原始 `hitch-duration` 只有在明确 narrative 标注 on-time 时才将 sentinel 解释为零；其他未知值不会默认为零。独立复算核对了正 hitch 与 `duration - acceptableLatency` 一致。设备级 legacy FPS estimate 约 60，没有足够的进程/表面归属，不用于判断 ProMotion 120 Hz 漏帧。

## 目前能得出的判断

1. 本次静置窗口的整微信平均 CPU 为 3.14%，渲染提交仅 3 次；未观察到持续高 CPU 或大量持续渲染提交的现象。该结果不能证明分组完全没有计算或定时任务。
2. 收消息与滚动两个可核对目标范围的窗口中，收消息的正 hitch 占比更高，最长呈现延迟约 66.73 ms，值得优先补查消息更新到列表发布的链路。
3. 切组时观察到较高的 CPU 样本峰值 59.80%，同一窗口设备显示范围内有 87 条正 hitch；此景后段热状态升为 Fair，也是解释和复测时需要控制的条件。需要补齐分组事件和应用帧归属，才能判断这些延迟与模型计算、表格刷新、分组栏动画或微信自身行为的关系。
4. 以上都是单次人工操作场景的实测基线，没有旧版、关闭插件或相同消息负载的对照；不能从这些值推出插件独占 CPU、性能提升比例或确定的卡顿原因。

## 尚未取得的指标与已验证的限制

| 指标 | 状态与原因 | 补齐所需证据 |
| --- | --- | --- |
| 分组每轮计算耗时 | 未取得。现有 2.2-8 没有分组轮次起止 signpost，采样不能恢复每次短调用的边界 | 独立观测版本中的低成本原生起止事件，分别覆盖完整模型、增量模型及协调器应用，并校验探针开销 |
| 精确分组刷新 / 完整与局部 reload 次数 | 未取得。CA 提交和采样栈都不能计数这些调用 | 目标主表、原生发布作用域与分组栏实际重建的独立事件计数 |
| 分组独占 CPU 和热点 | 未取得。两种 Time Profiler / Animation Hitches 组合测试报 Instruments 内部 `tagged-backtrace` 类型错误，失败 smoke 不作为正式栈证据 | 修复工具兼容性后的有效采样，或可验证的低开销原生观测 |
| 精确漏帧数、真实应用呈现 FPS | 未取得可直接使用的数据。生命周期密度和设备 FPS estimate 不是同一个指标 | 正确的应用呈现/显示周期事件与所有者映射 |
| 相对 2.2-7 的真机 CPU 改善比例 | 未进行同设备对照 | 在相同账号、列表、负载与设备条件下测两版本，保留独立重复轮次 |

为尝试补齐调用计数，在四景原始采集结束后做了一次 Frida 17.8.2 连接能力检查，仅请求附加原 PID，未加载脚本、未安装任何 hook；返回 `NotSupportedError: unable to detect RSD port`。系统隧道状态正常；现有 Frida 公开 API 没有手工 RSD 端口参数，不能将苹果业务端口冒充 Frida 服务端点。非交互特权检查也未获得执行权限，未执行特权命令。原因尚不足以认定为某一种权限或系统兼容问题。

离线候选与边界分析已保存在 [observation-candidate/README.md](observation-candidate/README.md)、[observer.js](observation-candidate/observer.js) 与 [rsd-investigation.md](observation-candidate/rsd-investigation.md)。候选仅完成语法和源代码核对，**没有在设备运行，也不是已验证可用的测量工具**。JS 观察开销可能接近极短增量计算本身，未来即便附加成功，也不能把该探针时延冒充未注入版本的纯计算耗时。若继续补齐缺失指标，优先准备独立的原生 signpost 观测构建，再单独验证开销与采样，不向正式发布代码加入常驻调试日志。

## trace 有效性与复核

Time Profiler 与旧 Animation Hitches 的失败兼容性测试单独保留；错误明确为 `set-column ... 'backtrace' ... 'tagged-backtrace'`，没有当作正式结果。两次切组附加 PID 的尝试返回 exit 21，设备查询仍确认相同 PID 存活，之后系统采集成功；没有将工具的“找不到 PID”误写为微信崩溃。

静置和切组在达到录制时间限制后，Mac 端远端符号解析/符号存储整理长时间未完成。只对本任务的 xctrace 进程发出 SIGINT/SIGTERM，使其最终保存并退出 0；未终止共享 Instruments 服务或手机应用。对应 `capture-result.json`、host sample 和原始日志完整保留。所选 CPU 窗口另外检查了表内覆盖、缺口、单位和累计 CPU 首尾差；没有只凭 XML 可读就判定成功。

每个正式场景导出均含 TOC、CPU、sysmon、lifetime、commits、FPS、thermal 及逐文件 SHA256 manifest。分析支持 XML id/ref，确认单位后解析，拒绝未知归属与不支持值；CPU 时长加权与帧数/时长还经过独立复算。

- [场景汇总 JSON](scenario-comparison.json)
- [静置分析](idle/summary.json)、[原始 trace](idle/raw.trace)、[采集记录](idle/capture-result.json)
- [收消息分析](messages/summary.json)、[原始 trace](messages/raw.trace)、[采集记录](messages/capture-result.json)
- [滚动分析](scroll/summary.json)、[原始 trace](scroll/raw.trace)、[采集记录](scroll/capture-result.json)
- [切组分析](switch-system/summary.json)、[原始 trace](switch-system/raw.trace)、[采集记录](switch-system/capture-result.json)
- [导出脚本](export-trace.py)、[分析脚本](analyze-trace.py)、[采集脚本](capture-scenario.py)
- [证据文件 SHA256 索引](evidence-manifest.json)

主报告中的动作场景使用上表的保守窗口。`analysis-window-5-65.json` 等较宽参考窗口若存在，会明确注明可能混入准备期，不与主报告口径混用。
