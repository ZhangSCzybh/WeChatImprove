# 2.2-10 分组工作量优化与交付

本轮根据用户“按照你说的3点再优化一版”的要求，优化稳定界面布局、收消息更新和滚动／切组期间的重复工作，并补齐兼容路径观测。实现基于当前 checkout 的 2.2-9，开始前已冻结完整生产源码（不含体积较大的 HeadersFile；其哈希单独记录）。所有测试和构建均在本机隔离目录进行，未安装或重启真机微信，未切换账号、偏好或数据。

## 行为变化

| 方向 | 2.2-10 的行为 |
| --- | --- |
| 静置及稳定布局 | 相同标题和 UIFont 复用文字尺寸；相同角标文字和 UIFont 复用宽度；相同几何、样式与指示器目标跳过重复赋值。真正变化的字体、角标占位、viewport、分组内容与排序会使布局失效。 |
| 消息计算 | 兼容路径保留合并后的完整变更名单。普通具名会话的身份、位置、置顶状态及数量稳定、账号与隐私快照有效时，只重读受影响会话的元数据。真实消息回调的 Content\|Structure 组合还须通过更严格的全源证明。 |
| 消息发布 | 兼容路径按身份、坐标、分类、隐私及 UIKit 已有行数判断是否能局部发布。复制展示值变化与已知名单共同决定需要刷新哪些可见行；离屏变化不再导致无意义同步布局。 |
| 滚动与切组 | 减少头部相同 frame、hidden、交互状态和减速率的重复赋值；重复确认同一选中组不再强制同步布局。保留此前的交互结束唤醒和消息合并时限。 |
| 观测 | 独立包补充兼容源快照、投影构建、兼容发布、布局尝试和路径 bitmask，并分别标记 Coordinator 与 Adapter 的变化提示。 |

完整身份和槽位校验仍为 O(N)。带 Structure 的提示仅在所有旧行与当前槽位都能证明为普通、命名、唯一会话时复用元数据；聚合、匿名、特殊类型、重排、增删、置顶或分类变化均转完整读取。Unknown、非法名单、账号／epoch／隐私变化和同步 getter 引发的新 revision 不会被升级为可局部更新。失败的严格证明只用 Unknown 完整重建一次，已临时复用的部分不发布。

局部发布另有账号、选中组、privacy revision、结构、特殊行、待回顶部和 UIKit 行数门禁。确有 reload 或隐私布局仍被 hold 时继续完成同步布局，避免把减少布局变成隐私刷新延迟。

本轮没有增加轮询或常驻逐帧驱动。上一轮静置约 60 次/秒的 CA 提交尚未取得确定的组件来源，本轮不能据主机测试宣布该现象已经解决。

## 验证证据

最终 4,055 项分组／隐私／调度行为断言、135 项分组栏断言和 63 项观测检查全部通过；14 个故障注入负对照全部捕获。20 个 SDK 语法检查和 4 个最终安装包逐架构校验通过。所有测试、源码及构建输入已交叉核对，[最终证据完整性](final-evidence-integrity.json) 记录实际计数和局限。

- 分组原生模型、协调器、Bridge、投影与调度：[validation/final/behavior-result.json](validation/final/behavior-result.json)。
- 兼容发布、真实 refresh 与 source helper（含元数据读取计数和同步重入）：[validation/final/compatibility-result.json](validation/final/compatibility-result.json)。
- 历史核心行为回归：[validation/final/legacy-core-result.json](validation/final/legacy-core-result.json)。根 Tests 保持删除，仅将历史夹具导出到临时目录执行。
- 交互与负对照：[validation/final/interaction-comparison.json](validation/final/interaction-comparison.json)、[validation/final/negative-controls-result.json](validation/final/negative-controls-result.json)。
- 分组栏真实方法体 135 项检查与 4 个故障注入负对照：[ui-validation/README.md](ui-validation/README.md)。
- 真实 observation 实现及原样 owner/hint helper 的 63 项检查：[review/observation/result.json](review/observation/result.json)。
- arm64／arm64e、观测宏 0／1 的 20 个真实 iOS SDK 语法检查：[observation-validation/syntax-result.json](observation-validation/syntax-result.json)。
- 独立源码审阅：[review/independent-review.md](review/independent-review.md)。

在 1,200 条普通会话的真实 Adapter source helper 与 Bridge 受控工作负载中，单个具名 Content|Structure 更新读取 1 条会话元数据，强制完整读取路径读取 1,200 条；最终每个行字段均一致。计数只针对元数据读取，不包含仍需执行的全源身份、位置、置顶与聚合标志校验，也不换算为手机 CPU 百分比。

在受控 UIKit 替身中，1,000 次稳定布局和同选中项确认：2.2-9 方法体发生 74,000 次自有视觉属性写入、9,000 次文字测量、1,000 次同步布局；2.2-10 对应为 0／0／0。该驱动刻意反复调用方法，用于验证无变化输入的去重契约，不表示真实静置时本来有同等调用次数。上一轮真机静置的 TabLayout 本来就是 0，不能用此数据推断手机 CPU 降幅。

这些测试使用真实生产翻译单元或原样提取的方法体，UIKit、宿主数据源与调度为受控边界。它们证明相应行为与工作量变化，不能代替真机渲染、耗电、CPU、CA 提交或 hitch 结论。

## 安装包

| 用途 | Rootless | Rootful |
| --- | --- | --- |
| 正式版 2.2-10 | [安装包](../../../packages/2.2-10-session-groups-efficiency-final/com.wechat.improve_2.2-10_iphoneos-arm64.deb) | [安装包](../../../packages/2.2-10-session-groups-efficiency-final/com.wechat.improve_2.2-10_iphoneos-arm.deb) |
| 观测版 2.2-10+observe | [安装包](../../../packages/2.2-10-session-groups-efficiency-observe-final/com.wechat.improve_2.2-10+observe_iphoneos-arm64.deb) | [安装包](../../../packages/2.2-10-session-groups-efficiency-observe-final/com.wechat.improve_2.2-10+observe_iphoneos-arm.deb) |

两种注入布局各包含 arm64 与 arm64e。正式版不编译 observation API 和 hook；独立观测版只记录固定事件、结果、计数与 route 位，不记录账号、会话名或消息内容。观测时长为 elapsed wall time；入口尝试、完成发布、实际 reload 和 CA 提交须分别统计，嵌套 interval 不相加为 CPU 时间。主表 reload 只覆盖经过验证的插件同步发布 scope，未验证的宿主 override 派发不能填作零次。详细口径见 [观测说明](observation-validation/README.md)。

正式版 [调试符号](../../../packages/2.2-10-session-groups-efficiency-final/com.wechat.improve_2.2-10_symbols.zip)、[SHA-256](../../../packages/2.2-10-session-groups-efficiency-final/SHA256SUMS)；观测版 [调试符号](../../../packages/2.2-10-session-groups-efficiency-observe-final/com.wechat.improve_2.2-10+observe_symbols.zip)、[SHA-256](../../../packages/2.2-10-session-groups-efficiency-observe-final/SHA256SUMS)。

## 构建与保全

`build-packages.py` 将最终源码冻结到独立临时目录构建，分别记录 rootless、rootful 的宏、命令、日志、版本、架构、dSYM UUID 和哈希。`verify-delivery.py` 检查每个架构的探针隔离、当前源码与构建输入一致、历史源码／采样／安装包保全，以及既有 6,892 条 tracked 删除和根 Tests 未被恢复。

最终构建记录：[builds/final/normal/build-result.json](builds/final/normal/build-result.json)、[builds/final/observation/build-result.json](builds/final/observation/build-result.json)；交叉校验：[delivery-integrity.json](delivery-integrity.json)。

初次未安装的构建在独立审阅发现真实消息的 Structure 提示覆盖缺口后保留为候选，未覆盖或删除；其位置与原因在 [builds/candidate-first-pass/relocation.json](builds/candidate-first-pass/relocation.json)。上表仅链接最终构建。

后续真机采样沿用用户确认的 com.tencent.xin、微信 8.0.78、同一设备和设置，分别记录消息负载与热状态，重新采集静置、连续收消息、滚动和切组，再与已冻结的 [2.2-9 采样](../session-groups-instruments-2.2-9-2026-11-03/README.md) 和 [2.2-8 基线](../session-groups-instruments-2026-11-03/README.md) 对照。本轮没有新增真机性能数据。
