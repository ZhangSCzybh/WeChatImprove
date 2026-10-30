# 微信前台发热与后台耗电：真机排查结果

日期：2026-10-30，Asia/Shanghai。有效进程采样约 10:59–12:03；本报告已纳入后续线程快照和完整投影开关对照，替代早期仅按源码列候选的结论。

## 结论与证据强度

**前台主要负载已经定位到 WeChatImprove 的共享会话列表投影刷新通道。** 聊天分组开启，或密友处于锁定隐藏状态，均会启用该通道。在这台手机当前账号、当前列表状态下，两种情况单独测试均复现约一核 CPU；关闭分组并解锁密友，使两者都退出投影后，同一微信进程、同一聊天列表前台降到 5.75%。恢复分组则回到 109.13%；只启用密友锁定隐藏为 104.21%。

连续 8 份线程快照中的主线程累计 CPU 差显示：约 140 秒内主线程持续占用单核的 98.65–99.16%。其中 6 份瞬时调用栈命中同一条插件 `scheduleRefresh → refresh → publishProjection → reloadData / layoutIfNeeded`，并进入原生表格重载、会话行创建、布局和文字更新。这里的 6/8 是稀疏命中次数，不能换算成 75% CPU 占比；持续主线程负载由累计时间差独立确认。

**尚未确认的是每次重刷最初由哪个原生事件或回调重新触发。** 已找到并通过本地有限回放验证一处会丢失合并延迟的调度缺口，但不能把合成回放当成手机上实际生产者的证明。因此，本次已完成主要负载的模块／调用链定位和功能对照，未声称已证明某一个原生 selector 就是循环入口，也没有实施或交付节电修复。

后台锁屏约 89 秒内，微信 CPU 实际接近零，读取、写入均无增长；没有复现用户所述的持续后台高 CPU。该短窗口不覆盖新消息、AI 回复、定时任务到期和异常重试，也不能排除音频保活或网络的能耗。手机连线充电，未取得自然掉电速度、实际瓦数、GPU 或温度数据。

## 设备、版本与环境保护

- 用户设备：iPhone 14 Pro Max，iOS 27.0.1；微信显示版本 8.0.78，设备应用元数据 8.0.78.34。
- 实际目标：`com.tencent.xin`，PID 64070；所有有效数据中进程启动标识一致。未使用另一份已安装微信的数据。
- 用户插件版本 2.1-19；运行时镜像 UUID `514a77c6-c049-3177-bd07-28e77e6d70e5`，与该版本 **rootful arm64e** dSYM 精确匹配。微信二进制 UUID 也与本地符号映射输入严格匹配。
- 原始设置：后台运行、AI 自动回复、底栏美化及描边动画、列表圆角、聊天分组和定时任务开启；AI 后台兜底补拉关闭。用户进一步确认密友开启且锁定隐藏。
- 未修改生产源码、账号、消息、配置内容或数据库；未构建、安装、启动或重启微信。所有临时开关由用户操作。工作区其他任务已有的修改和包未被更改。
- **用户已确认恢复全部测试前设置，密友仍锁定隐藏。** 本次 `capture.py`、stackshot、LLDB 等诊断采集进程已结束；未停止用户自己的 Console 或其他新开的诊断实例。

## 真机功能对照

CPU 为 `100 × Δ(cpuTotalUser + cpuTotalSystem) / ΔprocAge`，**100% 表示一个 CPU 核心**，多线程可超过 100%。低频进程采样均为 1 秒间隔，去掉第一条未初始化样本，用设备累计时间计算。原始 `cpuUsage` 已是百分数，未再次乘 100。

| 场景 | 有效跨度 | 微信平均 CPU | 进程写入计数／秒 | 解释 |
| --- | ---: | ---: | ---: | --- |
| 原配置前台复核 | 33.82 s | 86.18% | 0.614 MiB | 含中间低负载段；区间中位 106.39%，不能拿全窗均值判断后续开关变差 |
| 后台并锁屏 | 89.04 s | 0.000145% | 0 | CPU 累计仅增约 0.000129 s，没有复现持续后台高 CPU |
| 仅关描边动画 | 34.68 s | 106.95% | 0.749 MiB | 未消除主要负载 |
| 再关聊天分组，密友仍锁定 | 32.74 s | 108.92% | 0.624 MiB | 密友隐私投影仍在运行；这项不能排除共享模块 |
| 关闭底栏美化总开关 | 32.70 s | 107.40% | 0.755 MiB | 底栏样式不是触发主要负载的必要条件 |
| 再关闭列表圆角，分组开启、密友锁定 | 30.57 s | 104.34% | 1.364 MiB | 圆角关闭仍高；之后线程快照末段的下降是用户确认的锁屏，未算作优化效果 |
| **分组关闭＋密友解锁**，圆角继续关闭 | **24.39 s** | **5.75%** | **0.042 MiB** | **完整退出共享投影后明显下降** |
| **仅恢复分组开启**，密友继续解锁 | **23.24 s** | **109.13%** | **1.114 MiB** | **分组单独启用即可复现** |
| **分组关闭，仅密友锁定隐藏** | **24.01 s** | **104.21%** | **1.374 MiB** | **密友隐私投影单独启用也复现** |

最后三组保持同一目标进程、前台聊天列表以及当前圆角／底栏测试设置。对照并非随机重复实验，不能量化全天节电百分比，但 CPU 从约一核降至约 6%、恢复投影后再升高，与调用栈证据共同建立了明确的模块归因。不能把这些 CPU 比例直接换算成电池每小时掉电或降温幅度。

`diskBytesWritten` 是设备返回的进程累计写入计数，不等于文件净增长，也不直接等于物理闪存写入。主机 JSON 保存在 Mac `/tmp`，没有写进微信容器。相同采样方法在后台微信写入为零，在退出投影后明显降低，也不支持把 Mac 采样文件误算成微信写入的说法。

## 已定位的实际调用链

```text
主线程上的 scheduleRefresh 主队列任务
  → -[CSGroupListAdapter refresh]
  → -[CSGroupListAdapter publishProjection:previous:changes:previouslyProjecting:]
  → UITableView / MMTableView reloadData
  → layoutIfNeeded / MMTableView layoutSubviews
  → 更新、回收、创建可见会话 cell
  → MainFrameItemView layoutSubviews
  → 会话摘要、名称和联系人状态更新
```

插件符号对应 `Controllers/CSGroupListAdapter.m:848,879,880,891,1008`，表格 hook 对应 `Hooks/SessionGroupHooks.xm:312`。圆角的全局／列表 hook 会参与部分布局，但关闭圆角并未移除这条投影发布路径。

关闭圆角后的一份快照还确认了下列原生路径，名称来自同 UUID 二进制的精确 Objective-C IMP 映射，没有按最近符号猜测：

```text
MainFrameItemView layoutSubviews
  → updateNameLabel
  → updateTextStateView
  → CContact mostRecentTextState
  → TextStateMgr / TextStateDataLogic / StatusDBWrapper / StatusDBImpl
  → StatusDBCache mostRecentTextStateForUsername:
  → StatusDBCache prepareCacheSync:
  → StatusStorageManager selectStatusInfoWithUsername:offset:count:timeMsLimit:
```

这说明反复重载和布局会连带执行微信自身的文字处理与同步状态数据库查询，成本超过绘制圆角本身。单次栈不能给该查询分配独立 CPU 百分比，也未确定具体数据库文件。

分组和密友共用 adapter 的源码条件也与实测一致：`CSGroupListAdapter.m:786` 只有 `!privacy && !enabled` 才退出投影；`:824` 的 projecting 条件包含 `privacy || enabled`。所以只关闭分组，密友仍锁定隐藏，依然会发布隐私过滤后的列表；之前这一项对照没有真正关闭完整路径。

## 进一步发现的调度缺口与仍需验证的入口

源码中，原生通知在发布期间进入时存在以下状态路径：

```text
publish 正在执行
  → NativeNotification
  → beginNativeChangeOfKind：增加 modelRevision，清 recoveryPending
  → endNativeChangeCoalesced:YES
  → requestCoalescedRefresh：dirty=YES，临时设置 coalescingNotification
  → scheduleRefresh 因 publishing 提前返回，尚未保留 80 ms 延迟
  → requestCoalescedRefresh 清除临时合并状态
  → 原 publish finally 发现 dirty，再次 schedule
  → 按普通零延迟任务立即刷新
```

相关位置：`Hooks/SessionGroupHooks.xm:39`，`Controllers/CSGroupListAdapter.m:868,977,983,1023,1028,1041`。这条普通通知路径不使用 recovery 的三次重试预算；持续产生新 revision 也不能靠稳定 revision 的重试限制收敛。

对抽取出的真实调度方法做了**仅在 Mac `/tmp` 的有限状态机回放**：发布外的通知在 25 ms 内零次、125 ms 内一次；每次发布内合成一次相同通知，总上限 20 次，在约 28.4 ms 内完成 21 次发布，recoveryAttempts 为 0。该结果证明调度状态缺口存在；**合成通知不能证明手机上就是哪个 selector 在持续产生通知**。

另一条有条件的路径是原生延后 `reloadData`：`SessionGroupHooks.xm:312` 对 active 且非 publishing 的 reload 调用 `requestRefresh`；若原生 reload/layout 延后再次调用公开 reloadData，就可能被转成下一次插件发布。每次发布重复设置相同 dataSource/delegate/proxy 也值得减少。当前未用入口调用计数证明其生产关系。

没有发现 `attachToController:` 或 `layoutForController:` 无条件调用 requestRefresh 的简单自循环。badge 的 modelRevision 通知候选已有相同显示值去重保护，不能认定为无条件反馈环。不能点名 `updateItem`、`reloadSessions`、`onSessionChanged` 中任意一个是已证实的源头。

## 写入文件与其他进程

只读容器目录元数据显示：`Library/WechatPrivate/log/MM_20261030.xlog` 从 309,118,728 B 增至 338,082,842 B，约 325 秒观察期间净增 28,964,114 B，粗略约 87 KiB/s。没有读取日志正文、聊天内容或凭证。该日志是实际增长的文件，但时间窗与进程采样不同，且净增长与进程累计写入口径不同，不能认定它解释全部 0.6–1.4 MiB/s 写入，更不能仅凭文件扩展名认定压缩／加密是一核 CPU 的原因。

当前账号 AI store 最后修改时间 08:24:28，备份审计文件约 07:50:59，均早于本次前台持续 CPU 采样。这不支持“这一轮持续写入就是该 AI store 或备份审计文件反复保存”的说法。目录 mtime 不变不能排除已有子文件改写。

早期原配置低频组：backboardd 约 18.64%，diagnosticd 24.54%，sysmond 11.18%，DTServiceHub 5.03%，assetsd 10.99%；音频进程 audiomxd 约 1.79%。退出投影的低负载组，diagnosticd 仍约 23.16%、sysmond 11.87%、DTServiceHub 6.26%，而微信降至 5.75%。因此开发诊断本身会增加设备负担，但不能解释微信随投影开关发生的全部变化。不能把这些服务的 CPU 简单相减来得到插件净耗电，也没有证据将 assetsd 的工作全部归给插件。

## 优化方案与正确性边界

1. **先修共享调度，保留通知合并语义。** 把“真实数据失效”与“安排已有工作”分开；schedule 不应无条件制造 dirty。发布期间持久记录待处理原因和截止时间，结束后统一排队，避免临时 coalescing 状态丢失；native end 仅在 changeDepth 从 1 降到 0 时唤醒。真实消息仍需处理，不能简单丢弃全部 publishing 期间通知。
2. **用有限内存计数找生产者。** 记录哪个入口重新置 dirty、是否 publishing、revision 增量、pendingScrollToTop 和最终 delay；短窗口结束后一次导出。无需逐帧、逐行或逐消息落日志。已确定热路径后，继续盲目关闭其他功能的收益有限。
3. **减少整表重发与强制布局。** `publishProjection` 虽有增量路径，但匿名、业务或聚合行会使其退回整表 reload，随后总调用 layoutIfNeeded。应保存内容失效的会话身份，更新对应可见行，并单独标记结构和聚合行几何变化。当前 row 快照不含完整摘要／草稿版本，不能仅因结构和未读相同就跳过所有 Content 事件，否则会产生旧消息文字或草稿。
4. **降低每次发布的额外成本。** 相同对象不重复设置 dataSource/delegate；同一发布版本内复用账号、epoch 和索引映射；稳定 ABI 校验可按 class/selector/IMP 缓存；全局 cell hook 快速排除无关表格。圆角 renderer 已有 frame/path/color 缓存，不能称为每帧必定重建 mask。
5. **临时缓解有明确代价。** 本轮显著降低 CPU 的设置是“关闭分组并解锁密友”，会影响分组展示和会话隐藏，应按隐私需求选择；只关描边、底栏或圆角均未解决当前主要负载。保持用户原设置是本次最终交付状态。保留分组与密友功能需要修代码并再做真机验证。

未实施这些行为修改，因此没有修复版、安装结果或降温／节电收益可交付。后续修复验收必须覆盖：分组筛选与未读、真实消息和草稿更新、聚合入口、滚动／左滑／回顶、密友锁定不泄露、解锁恢复、账号切换及后台恢复。

## 后台耗电的结论与处理

用户的后台兜底补拉已经关闭，不能继续把插件 45 秒补拉计入用户这次耗电。AI 模型在远程接口运行，没有手机本地大模型推理证据。定时任务采用最近到期的一次性 timer，不能仅按“总开关开启”认定有常驻秒级轮询。

后台运行采用静音音频保活，可能维持后台执行和联网资格，但本轮后台锁屏时微信 CPU／I/O 近零、audiomxd 也未见持续高 CPU，**未确认它是当前后台快掉电的实测根因**。需要后台实时回复／定时发送时，直接关闭保活有功能代价。

后台后续验证应在不充电、信号与亮度条件相近时，按相同消息和任务输入，比较 30–60 分钟原配置与只关闭后台运行；同时记录 AI 实际回复、任务执行和音频状态。iOS 电池页后台活动可辅助解释，短期近零 CPU 不能保证全天低耗电。本轮不按充电时的温感或电量变化计算自然耗电。

## 证据文件

- `energy-device-2026-10-30/measurements.json`：9 个低频场景的筛选进程指标、微信区间 CPU、场景和日志元数据。
- `energy-device-2026-10-30/thread-evidence.json`：主线程原始帧、累计 CPU、设备时间、镜像 UUID 和原始文件 SHA-256；包含锁屏混入标注。
- `energy-device-2026-10-30/plugin-frames-symbolicated.json/.txt`：匹配 2.1-19 dSYM 的插件函数和源行。
- `energy-device-2026-10-30/wechat-native-main-frames.json`、`no-corners-native-main-frames.json`：匹配微信二进制 UUID 和精确方法边界的原生映射。
- `energy-device-2026-10-30/main-thread-shared-cache-frames.json`、`shared-cache-images.json`、`shared-cache-exact-symbols.json`：用同一系统 cache UUID 的既有 crash 映射系统库范围与精确地址符号；未知函数未按最近符号猜测。
- `energy-device-2026-10-30/feedback-host-replay/`：有限本地状态机回放副本和结果，不能替代真机通知生产者证据。

完整原始采集暂存 `/tmp/wechat-energy-20261030.pVHImp/`。没有把其他系统任务的完整 stackshot 或微信日志正文复制进项目。Instruments 早期 kperf 占用和 LLDB 连接失败未产生有效热栈，未纳入本报告；后续成功的线程快照单独归档。所有结论区分实测、源码条件和未确认入口。
