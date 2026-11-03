# 2.2-9+observe 真机采样与 2.2-8 对比

本轮完成了四个正式场景的 CPU、Core Animation 提交、设备显示卡顿和 os_signpost 采集。结果未显示全面的性能改善：静置和切组平均 CPU 更高；收消息、滚动平均 CPU 较低，但 P95 和约一秒采样峰值更高。原生模型和主表发布链路的探针没有取得，因此每轮计算耗时和实际主表刷新次数仍未测得。

本次实际测试的是用户确认安装的 **2.2-9+observe**，基线为上一轮 **2.2-8**。CPU 是整微信进程的占用，100% 表示占满一个 CPU 核心。这是两次人工负载采样的描述性比较，不是插件独占 CPU 或去除观测开销后的生产版净收益。

设备为 iPhone 14 Pro Max / A16、iOS 27.0.1 (24A446)，原包名 com.tencent.xin、微信安装元数据 8.0.78 / 8.0.78.34。新一轮始终筛选 PID 40208，结束时同一进程及同一 app 路径仍存活。插件版本依赖用户安装确认；dyld-library-load 未导出实际库 UUID，不能独立证明所加载插件二进制与本地包逐字节一致。

**CPU 正式结果**

| 场景 | 有效秒数 旧 / 新 | 平均 CPU 旧 → 新 | 均值变化（百分点） | CPU P95 旧 → 新 | 约一秒 CPU 峰值 旧 → 新 |
| --- | ---: | ---: | ---: | ---: | ---: |
| 静置 | 60 / 40 | 3.14% → 5.43% | +2.29 | 4.74% → 15.92% | 10.07% → 16.88% |
| 连续收消息 | 45 / 45 | 18.72% → 17.45% | -1.27 | 29.57% → 35.08% | 36.03% → 37.80% |
| 滚动 | 40 / 40 | 35.17% → 32.04% | -3.13 | 42.31% → 55.61% | 43.69% → 56.22% |
| 切组 | 45 / 45 | 18.82% → 24.10% | +5.29 | 28.78% → 32.63% | 59.80% → 33.57% |

消息窗口有负载变化。用户确认持续发送约 60 秒，最后几秒未发送；精确到达条数和速率未计量。保留预定主窗 [25,70) 45 秒：均值 17.452545%。分段 [25,55) 30 秒均值 24.300047%，[55,70) 15 秒均值 3.757542%。前 30 秒为事后选择的活跃段敏感性分析，不能替换主窗或作为更公平的 A/B 结果；自有探针末 14.9 秒缺失也不等于这 14.9 秒都未收消息。

本次四景主窗的热状态均为 Nominal。旧切组主窗约 65.87% 的时间处于 Fair，其余 Nominal；两轮操作节奏、后台负载和观测构建不同。切组平均 CPU/P95 上升而峰值降低，不能单凭峰值下降宣称切组优化成功，也不能把差异全部归因于分组代码。

**渲染和卡顿的范围**

| 场景 | 微信 CA 提交/秒 旧 → 新 | 新版设备显示 hitch / 已分类记录 | 新版设备 hitch 占比 | 新版最长 hitch | 两版帧范围 |
| --- | ---: | ---: | ---: | ---: | --- |
| 静置 | 0.050 → 59.825 | 0/2399 | 0.000% | 0.000 ms | 旧/新均为设备显示范围 |
| 连续收消息 | 4.067 → 56.489 | 24/2768 | 0.867% | 75.070 ms | 旧为微信 SINGLE，新为设备 ALL，禁止应用帧差异比较 |
| 滚动 | 103.000 → 88.975 | 66/3559 | 1.854% | 58.390 ms | 旧为微信 SINGLE，新为设备 ALL，禁止应用帧差异比较 |
| 切组 | 16.000 → 52.156 | 115/3364 | 3.419% | 66.730 ms | 旧/新均为设备显示范围 |

新版全部通过 --all-processes 采集，但 CPU 和 CA 提交逐行严格筛选微信 PID。CoreAnimationLifetime 表为 target-pid=ALL；未取得帧到微信进程的归属，因此不能称为微信专属掉帧。旧静置/切组同为 ALL，可作设备显示范围的描述性并列；旧消息/滚动为微信 SINGLE，禁止与新 ALL 计算应用卡顿改善率。静置同范围为旧 0/3599、新 0/2399；切组同范围为旧 87/3229（2.694%）、新 115/3364（3.419%）。

CA 提交不等于分组刷新、reload 或模型重算次数。静置用户已确认全程未触屏，但微信提交仍接近 60 次/秒，值得优先定位持续渲染的来源。hitch 依据记录中的显示截止时间及明确 on-time 分类计算；不按固定 60/120Hz 换算精确掉帧数，记录密度也不是真实 FPS。

**内部计算与刷新**

四景均未取得 ModelFull / ModelDelta / ModelSelection / CoordinatorApply / AdapterRefreshAttempt / AdapterPublication，也没有 MainTableTargetVerified。每轮模型计算耗时、原生发布次数和已验证主表 reload 次数统一列为“未取得”，不能列为零。2.2-8 没有匹配的内部探针边界和计数器，同样不能补算或计算下降比例。

| 场景 | 观察到 Tab 更新调用 | Tab 更新 P95 | 观察到 TabLayout 调用 | TabLayout P95 |
| --- | ---: | ---: | ---: | ---: |
| 静置 | 1 | 0.006791 ms | 0 | 未观察到 |
| 收消息 | 44 | 0.006916 ms | 44 | 0.249833 ms |
| 滚动 | 3 | 0.009917 ms | 0 | 未观察到 |
| 切组 | 117 | 0.015417 ms | 1 | 0.178334 ms |

上述已配对 Tab 更新调用全部为 Unchanged：没有替换 renderedTabRecords 对象。它们是目标进程内 WESessionTabContainerView 类方法的已观察调用，没有 owner/window 标识，不能逐次归属当前可见主列表分组栏，也不等于真实切组或主表刷新次数。用户已确认正式切组时选中项和列表都正常变化；该交互可以不重建记录对象。计时为观测构建中的同步墙钟时间，包含探针开销；嵌套区间不能加总，微秒级结果不代表纯计算成本。

源码中，录制前已进入 compatibilityFallback 可以解释“提示事件仍有，但整条原生入口无事件、UI 仍能切组”的组合；兼容 refresh / publishProjection 不在本观测版的原生链覆盖内。现有 trace 没有运行时路径状态事件，故这只是有源码依据的候选原因。已导出事件配对干净、采集 exit 0 均不能证明成对事件绝无丢失。

**采集与验证**

首轮 idle 因用户确认期间有操作而排除；正式静置使用 idle-confirmed。所有 smoke、附加失败、设备标识失败均与正式结果分开保留。后续改用已验证的系统采集并严格筛 PID；没有把工具“找不到 PID”误报为微信崩溃。实际主窗为静置 [25,65)、消息 [25,70)、滚动 [25,65)、切组 [25,70)。请求的录制时限分别为 70/100/100/100 秒，实际 trace 时长见各景 TOC；主窗按 TOC 实际起点及人工提示对齐，用户逐项确认操作。

四个正式 recorder 均自然保存 exit 0，没有向本轮 recorder 发送信号。Mac 后处理/符号保存有数分钟延迟；消息→滚动、滚动→切组仅在前一录制已明确 completed 后启动，设备录制窗口没有重叠，Mac 保存阶段有重叠。

独立审计的 80 项主窗检查通过，覆盖 CPU/PID/窗口、完整覆盖无重叠、累计 user+system CPU 交叉验证、CA PID 归属、设备帧及正 hitch 公式、热状态和 XML 哈希。旧基线另有 48 项复算一致。解析器校验不等于真机事件绝无丢失，独立核验也不证明人工负载完全相同。

本轮没有安装/重启/切账号、修改手机偏好或生产代码；只在本审计根目录新增材料。结束时原进程仍存活，本任务无录制进程遗留。旧基线清单 2,075 文件 SHA256 全部一致；2.2-9 正式版/观测版共六个冻结包和符号包均匹配 SHA256SUMS；原有 6,892 个 tracked 删除路径保持原样。

**后续优化优先级**

1. 先取得运行时路径与回退原因，并为兼容 refresh / publishProjection 补齐同样可验证的区间、发布和主表目标计数。当前不能用原生路径优化设计代替它在真机实际执行的证据。
2. 定位“全部”静置时约 60 次/秒提交的来源，核对持续动画、CADisplayLink、定时任务及反复失效的视图；先拿到具体调用来源再改代码。
3. 根据真实热路径处理消息/滚动 P95 和切组持续负载，并以固定消息速率、固定切组/滚动脚本、相同热状态重采；至少区分正式版、观测关闭和观测开启的开销。

**证据入口**

- [完整版本对比](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/session-groups-instruments-2.2-9-2026-11-03/comparison/version-comparison.md)
- [结构化对比](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/session-groups-instruments-2.2-9-2026-11-03/comparison/version-comparison.json)
- [四景探针汇总](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/session-groups-instruments-2.2-9-2026-11-03/signposts/four-scenes-observation.md)
- [原生探针覆盖候选诊断](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/session-groups-instruments-2.2-9-2026-11-03/signposts/native-probe-coverage-diagnosis.md)
- [独立复核](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/session-groups-instruments-2.2-9-2026-11-03/review/final-independent-review.json)
- [操作与窗口时间线](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/session-groups-instruments-2.2-9-2026-11-03/scenario-timelines.json)
- [消息分段敏感性](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/session-groups-instruments-2.2-9-2026-11-03/review/messages-time-segments.json)
- [旧证据完整性](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/session-groups-instruments-2.2-9-2026-11-03/baseline-preservation-check.json)
- [最终运行状态](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/session-groups-instruments-2.2-9-2026-11-03/final-runtime-check.json)
- [静置原始 trace](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/session-groups-instruments-2.2-9-2026-11-03/idle-confirmed/raw.trace)；[该景摘要](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/session-groups-instruments-2.2-9-2026-11-03/idle-confirmed/summary.json)
- [收消息原始 trace](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/session-groups-instruments-2.2-9-2026-11-03/messages/raw.trace)；[该景摘要](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/session-groups-instruments-2.2-9-2026-11-03/messages/summary.json)
- [滚动原始 trace](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/session-groups-instruments-2.2-9-2026-11-03/scroll/raw.trace)；[该景摘要](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/session-groups-instruments-2.2-9-2026-11-03/scroll/summary.json)
- [切组原始 trace](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/session-groups-instruments-2.2-9-2026-11-03/switch/raw.trace)；[该景摘要](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/session-groups-instruments-2.2-9-2026-11-03/switch/summary.json)
