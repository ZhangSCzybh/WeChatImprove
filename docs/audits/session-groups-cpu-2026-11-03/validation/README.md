# 分组 CPU 优化验证

此目录验证 2.2-8 的三项改动：已知会话变化时复用分组归属并更新该会话统计；同一完整基线与同一配置复用模型；列表身份和结构稳定时局部刷新可见行，离屏角标变化跳过表格刷新与同步布局。

生产 `CSGroupNativeModel`、`CSGroupProjection`、`CSGroupNativeSessionCoordinator`、`CSGroupNativeBridge`、偏好及隐私签名直接编译为 macOS Foundation 可执行文件。Adapter 发布、局部刷新、变化名称合并、恢复、通知及调度方法，原生完整来源枚举器替换，以及实际 Hook 的名称提取和广域 Unknown 包装函数，均从当前生产文件提取。测试替身只提供不可在主机运行的 UIKit/微信对象与调度边界；未用简化算法替代生产分组计算。

最终冻结源码通过 **389 + 77 + 7 + 393 = 866 项检查**，记录在 `final/`。两个负对照按预期失败，生产源码保持不变。

运行命令：

```sh
python3 docs/audits/session-groups-cpu-2026-11-03/validation/record-validation.py --output-dir final
python3 docs/audits/session-groups-cpu-2026-11-03/validation/run-legacy-core.py --output-dir final
python3 docs/audits/session-groups-cpu-2026-11-03/validation/run-negative-controls.py --output-dir final
python3 docs/audits/session-groups-cpu-2026-11-03/validation/run-model-benchmark.py --output-dir final
```

所有可执行文件、从历史 Git 导出的 `Tests` fixtures 和进程内偏好替身均在临时目录；不恢复工作区已删除的 `Tests/`，不访问设备、实际微信偏好、账户、聊天数据库或共享服务。`baseline-2.2-7/` 是改动前冻结的生产源码，原有 blank/native audit 与安装包保持原位。

`CpuRegressionFixture.h` 覆盖：

- 一个用户名对应原始会话和包装会话时，只读取这两个对象，未变化行保持不可变对象指针；完整来源的统计仍优先于包装计数。
- 多名更新、隐藏会话、多个红点贡献者、最后一个红点消失、Unknown 类别跨组统计、折叠组角标贡献和汇总来源信息。
- 名称、类别、置顶属性、异常、特殊行和已饱和计数拒绝局部推算；canonical 映射拒绝伪造、重复、缺失行，保持隐私和折叠字段。
- 1000 条会话的稳定偏好刷新复用同一 model，未读 getter 零新增调用；单名更新仅读少量对象，未知变化、隐私 revision、epoch 变化重算完整来源。
- 外层已知 A、内层广域 Unknown 同时改变 A/B，必须保留 B 的新统计并发布 `allChangesKnown=NO`。
- 缓存复用期间原生用户名 getter 同步触发密友重新隐藏，不得再次发布旧模型中的受保护会话。
- 真实 Bridge 只读取命中的普通会话元数据，其余已校验身份的行复用；Unknown、Structure、缺失名称提示重读全部元数据；枚举期间宿主行数变化拒绝快照。
- 实际原生发布方法仅刷新命中的可见行；离屏角标更新不刷新表格、不同步布局；未命名内容变化刷新可见行；未知、身份、账户、形状或显式滚顶变化执行完整刷新。
- 实际 Hook 对包装会话、基础会话、字符串、数组、集合和字典提取已知名称，任何无法验证的来源保留未知语义。

旧版 280 项原生/Bridge/Adapter/调度回归保留，新增 109 项断言，包括空分区、原始统计来源晚加载、不兼容回退、完整来源、隐私屏蔽、局部 setter 失败和同步重入恢复。Unread panel 的 77 项功能与 7 项 ABI 检查、五套共 393 项既有核心检查独立运行。

`run-negative-controls.py` 只在临时提取的方法中恢复整表发布和旧恢复预算重置逻辑，并要求相应精确断言失败，防止“通过”来自未运行新路径。生产哈希必须前后一致。

`run-model-benchmark.py` 分别编译冻结的 2.2-7 和当前 NativeModel/Projection/TabItem 生产翻译单元。工作负载为 1200 条会话、24 个自定义组、5 轮各 120 次单会话未读更新；每轮校验完整来源与实际未读总数，并比较全部分组的数值、红点、成员数结果。记录元数据读取次数和每次更新时间的各轮值、中位数及源哈希。

这些时间属于受控 macOS 主机上的模型域 wall time，排除了 UIKit、原生来源捕获、Bridge 与协调器。它们不能换算成手机整体 CPU、耗电、发热或流畅度的降低百分比。完整链路仍执行 O(N) 的身份/槽位一致性验证；广域事件、结构变更和不明确来源保留完整重算及刷新。设备端微信 8.0.78 的运行效果仍需实际安装验证。
