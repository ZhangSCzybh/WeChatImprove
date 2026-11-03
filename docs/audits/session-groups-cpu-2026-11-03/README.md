# 分组计算、模型复用与局部刷新：2.2-8

本次落实已确认的三项优化：仅更新变化会话及其受影响的组统计，复用已验证的模型与投影，列表结构稳定时仅刷新受影响的可见行。随后检查分组相关生产代码，清理无用入口、状态和缓存。版本为 `2.2-8`，保留 `2.2-7` 的聊天列表空白兼容修复。

## 最终交付

- [Rootless 安装包](../../../packages/2.2-8-session-groups-cpu/com.wechat.improve_2.2-8_iphoneos-arm64.deb)
- [Rootful 安装包](../../../packages/2.2-8-session-groups-cpu/com.wechat.improve_2.2-8_iphoneos-arm.deb)
- [调试符号](../../../packages/2.2-8-session-groups-cpu/com.wechat.improve_2.2-8_symbols.zip) 与 [SHA256SUMS](../../../packages/2.2-8-session-groups-cpu/SHA256SUMS)
- [构建及包校验](build-result.json)、[交付交叉校验](delivery-verification.json)、[生产输入指纹](production-inputs.json)

两种注入环境的安装包均包含 `arm64` 和 `arm64e`，最低编译目标为 iOS 15。版本、架构、所需方法符号、dSYM UUID 和包校验和已经核对。包在临时冻结源码副本中独立构建，没有运行根目录 `make clean`，没有安装至设备。

## 三项实现

| 层次 | 变化 | 完整校验条件 |
| --- | --- | --- |
| 模型及统计 | 保存会话名称到原生对象、源行和分组归属的索引。对已知变化会话重读元数据，更新相关分组的数字与红点贡献计数，复用未变化的行和成员关系。 | 身份、类型、分类、置顶、成员或结构变化；无法证明统计权威性；聚合行变化；计数饱和等情况下回到完整构建。 |
| 协调器及界面元数据 | 同一基线与配置复用已验证模型；完整变化名单已知且源对象顺序稳定时复用统计源索引。严格将宿主槽位映射至协调器投影，避免重复计算分组与角标。 | 配置、账号、epoch、隐私策略或版本变化重新计算。包装行统计不一致、业务／伪会话、需要选定分组摘要的折叠入口继续原完整投影路径。 |
| 发布及 UI | 成员、顺序、行类型、隐私属性及 UITableView 缓存行数均一致时，仅重新加载变化的可见行；离屏更新仅影响角标时不主动刷新或同步布局聊天表格。 | 未知范围、无可复用投影、结构变化、表格缓存行数异常或显式滚动请求使用完整刷新。 |

变化提示由协调器通知携带变更种类、会话名称集合和“是否完整已知”。发布过程中到达的新变化留给下一轮处理，失败的变化提示保留。广域 `checkLoadData`、重排、重新统计和主列表重载等 Hook 明确标记 Unknown，不能借用外层单会话名单；后台调用不提前读取宿主会话 getter。

本次减少的是元数据读取、分组计算和 UI 重建。身份、对象顺序、宿主槽位及数组复制仍有随会话数增加的工作，不能把整个链路描述为只遍历变化会话。实际走局部路径的比例取决于微信的回调组合；广域回调会保守地执行完整计算。

## 隐私与兼容复审

交叉审查发现并修正两条重入边界，已纳入可执行回归：

1. 外层已知 A 的更新中，内层 Unknown 同时修改 B，即使对象及顺序未变化，也必须完整读取并更新 A、B。
2. 原生身份 getter 同步触发密友重新隐藏时，旧模型不得再次发布。最终授权检查放在原生身份读取之后，发布期间的隐私变化会失效当前计算并关闭边界。

完整来源读取也在原生 getter 返回后重新核对策略、账号和基线状态。原来的空分区、辅助未读源缺失、包装会话识别、完整原生源恢复、有限重试、未读面板、转发过滤以及首帧保护继续保留。密友名单、分组配置、历史归档和数据格式未迁移。

## 清理结果

人工交叉引用审查及生产文本扫描覆盖 28 个分组相关文件，指纹与记录见 [cleanup-review.json](cleanup-review.json)。范围包括模型、投影、协调器、适配器、桥接、Preferences、分组设置、标签栏、Hook 和群列表隐私交互。

本次删除：

- 没有生产调用的 `CSGroupBuildNativeSections`、`CSGroupCopyFoldedRows` 两个薄包装及声明。
- 没有调用的 `WESessionTabItem -isPresetTab` 方法及声明。
- 只写不读的 `publishedTop`、`publishedNormal`、`publishedAllTop` 和 `hasAllTop` 状态。
- 未参与复用校验或计算的折叠行缓存，以及重复的可见行、对象元数据映射和红点状态。
- 普通元数据路径中重复的身份读取、类别判断；回退时清空不再使用的模型缓存强引用。

生产扫描未发现分组范围中的 `NSLog`、`printf`、`os_log`、DEBUG 调试开关或 TODO/FIXME。审计夹具保留失败诊断、性能计数和负对照，它们不进入插件。`IndexScope`、`InvocationMapper`、兼容代理、宿主动态 getter、NSCoding 及旧配置导入仍有运行或兼容用途，继续保留。

## 性能证据

使用本次修改前保存的 `2.2-7` 源码与本次冻结源码，分别直接编译真实 NativeModel、Projection 和 TabItem。固定工作负载：1200 个会话、24 个自定义组，每轮 120 次单会话未读更新，共 5 轮。

| 指标 | 修改前完整构建 | 修改后增量模型 |
| --- | ---: | ---: |
| 每轮元数据读取 | 144,000 | 120 |
| 每次更新平均元数据读取 | 1,200 | 1 |
| 每次更新主机耗时，5 轮中位数 | 4.3553 ms | 0.0345 ms |

所有组的最终数字、红点与成员数量指纹一致。数据和源指纹见 [模型基准对照](validation/final/model-benchmark-comparison.json)。这是 macOS 上模型与投影的受控耗时，排除了协调器捕获、Bridge、UIKit、iPhone CPU 与电量；不能换算为微信整体 CPU、耗电或掉帧改善百分比。

真实协调器路径的 1000 会话回归另外验证：同一版本重复刷新为 0 次未读 getter 读取；单个已知会话更新不超过 8 次；未知范围、策略或账号 epoch 变化至少读取 1000 次，确保完整校验分支未被跳过。真实 Bridge 路径的三行夹具验证单会话更新仅读取 1 行元数据并复用另外 2 行；Unknown、Structure、缺失名单重读 3 行。UI 夹具验证只刷新命中的可见行，离屏仅角标变化不刷新表格。

## 最终验证与边界

冻结源码回归共 **866 项断言**：

- 原生模型、协调器、Bridge、Adapter、隐私及调度：389 项（保留原 280 项，新增 109 项）。
- 密友未读面板：77 项；未读面板 ABI：7 项。
- 原有分组核心回归：393 项，覆盖配置、增量、角标、外观和标签栏语义。

[行为记录](validation/final/behavior-result.json)、[核心回归](validation/final/legacy-core-result.json)和 [验证说明](validation/README.md)记录详细范围。两个负对照分别在临时提取代码中恢复全表刷新、恢复旧的重试次数重置，均按预期被断言拒绝，生产源码不变，见 [负对照](validation/final/negative-controls-result.json)。

验证使用临时 macOS Foundation 可执行程序、内存配置与宿主替身；实际模型、协调器、Bridge 等直接编译生产文件，Adapter／Hook 的相关方法体从生产源码提取，UIKit 与宿主回调仍为受控边界。旧 Tests 仅从固定提交导出到临时目录；删除薄包装后，仅将临时 Badge 夹具的两处调用改为等价现存 API，断言不变。

最终交叉检查将测试生产指纹、夹具指纹、模型基准、清理审查与冻结构建输入及包哈希对齐。99 个既有 `.deb`／符号包文件保留原哈希；工作区原有 6892 条删除保持不变，未恢复 `Tests/`，未访问真实微信数据库、账户或配置。

**微信 8.0.78 真机显示、列表交互、其他插件组合、CPU／电量及上一版空白修复的设备验收仍待确认。** 本轮没有将主机检查写成设备验收通过。

## 复现

在项目根目录执行：

```sh
python3 docs/audits/session-groups-cpu-2026-11-03/validation/record-validation.py --output-dir final
python3 docs/audits/session-groups-cpu-2026-11-03/validation/run-legacy-core.py --output-dir final
python3 docs/audits/session-groups-cpu-2026-11-03/validation/run-negative-controls.py --output-dir final
python3 docs/audits/session-groups-cpu-2026-11-03/validation/run-model-benchmark.py --output-dir final
python3 docs/audits/session-groups-cpu-2026-11-03/verify-delivery.py
```

重新构建应为新产物显式指定不同的 `--delivery-name` 和 `--evidence-subdir`；构建脚本拒绝覆盖现有交付包与构建证据。不要在根目录运行 `make clean`，该项目清理目标会删除历史 packages。
