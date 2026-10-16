# 1.6-18：返回页面时系统 inset 变化的处理

后续实机与二进制分析纠正：本版仍未解决；多次进入修正但 inset 读回不变。MMTableView.contentInset 并非始终代表 UIKit 原始 inset，原始数值推断不成立。1.6-19 移除本版的补偿，改为保持原生表头识别一致，见 [后续根因分析](session-groups-header-1.6-19.md)。以下保留历史实现记录。

## 本次证据与 1.6-17 未命中的原因

目标环境保持为用户现有的微信 8.0.78.34 / iOS 27.0.1；在原项目 checkout 构建 Rootless 包，不操作手机账号或数据库。用户安装 1.6-17 后的视频显示，从“我”和“通讯录”回微信，搜索框、分组栏和两条私聊会话整体下移，导航标题仍显示。视频没有展示正常状态到异常状态的完整 inset 写入过程。

用户日志中的各个 did-appear、refresh、reload、restore 阶段均为：

| 指标 | 数值 |
| --- | ---: |
| 原始 contentInset.top | 103 |
| adjustedContentInset.top | 200.67 |
| 当前系统贡献（adjusted − raw） | 97.67 |
| contentOffset.y | −200.67 |
| 原始 inset 观测基线 | 0 |
| 内容 / 视口高度 | 291.63 / 932 |
| 显示表头 / 原生表头高度 | 98.8 / 46.8 |
| 原生顶部状态 | 0（已知、未展开或转换） |

1.6-17 要求 `raw − baseline` 与**当前**系统贡献在 0.5 pt 内相等。本次 103 与 97.67 相差 5.33，所以没有进入修正，也没有 `inset-repair-before/after`。这确认为上一版判据遗漏，而不是已经执行的修正量不足。

前次 1.6-16 日志实际出现过正常 raw=0 / adjusted=103。因此旧的系统贡献可能残留在 raw 中，而当前系统贡献随布局变化；这是实现修正所针对的机制。当前证据仍不足以确定哪个微信私有函数最先写入 103。头文件 `MMUIViewController.h` 声明了 `adjustContentInsets`、`adjustTableViewInset:`、`wcautoAdjustsScrollViewInsets` 等，但声明不等于执行证据，本版不全局关闭微信或 UIKit 的 inset 调整。

## 实现

- 首次挂载记录每张主表的原始 inset 基线，沿用 1.6-17 行为。
- 在正常分组布局、主表 `setContentInset:` 写入前，以及 `adjustedContentInsetDidChange` 原实现执行后采样系统贡献。采样独立于诊断开关。仅原始 top 与基线一致、表格在 window 中、顶部状态已知且闲置、没有搜索/拖动/编辑等交互时接受，避免异常 raw 污染正常观测。
- 短列表位于 adjusted 顶部边界时，重复量可匹配当前系统贡献，或者同一表、相同视口尺寸下最后一次正常采样的系统贡献。容差仍为 0.5 pt，不固定写入 103，也不放宽成一个任意范围。
- 继续通过微信的 `setTableViewContentInsetOffsetWithoutScrollWithContentInset:contentOffset:` 成对修正 inset 与 offset，保留非顶部 inset 和水平偏移，并验证私有方法 ABI。
- 原始 top 和 offset 确实达到请求值后，才记录成功去除的重复量及视口尺寸，用于随后相同残留的页面往返。否则正常布局更新系统贡献后，第二次往返可能再次失配。仅调用返回不能证明修复成功。
- 仍避开长列表、搜索、拖动、减速、编辑、侧滑、顶部小程序区域展开/收起、原生数据事务和表头更新。历史尺寸不匹配、无观测证据且当前贡献不匹配、其他显式 inset 不修正。布局回调重入受保护。
- MainFrameTableView 新钩子只采样和记录，不在原生 inset 写入中嵌套修正；修正仍发生在已有布局/刷新完成路径。

本次日志形态若有此前正常 103 的观测，则修正目标为 raw=0、offset=−97.67。真实 UIKit 之后若进一步调整系统贡献，最终 offset 不必永远为 −97.67，应该结合当时 adjusted inset 和页面位置判断。

## 诊断

保留「版本控制 → 查看诊断记录 → 清空」，不改变诊断开关或聊天数据。

新增 `auto`（当前系统贡献）、`observedAuto` / `observed` / `observedSize`（正常采样）、`repairedDuplicate`（曾成功去除的量）。主表原始 top 改变时记录 `raw-inset-before-native/after-native`；私有 setter 返回但实际 top 或 offset 未到请求值时，记录 `inset-repair-not-applied`。原有 unavailable、failed、before、after 保留。数据仅含布局数值，不含会话信息。

## 验证与边界

- `bash Tests/verify-group-viewport.sh`：98 项通过。
- 对照 1.6-17 的实际方法体：同一组测试 10 项失败，覆盖历史贡献不相等、正常布局后重复往返，以及 setter 未生效的区分。
- 回归还覆盖非零原始基线、未观测的差值、旋转后尺寸不同、显式其他 padding、搜索/下拉/拖动、原生字段未知、私有方法缺失/签名错误/异常、重入和长列表锚点。
- 主机测试抽取生产适配器方法体与原生顶部标志读取函数，表格及微信私有 setter 使用替身。完整 UIKit/Logos 通过 Rootless 双架构编译检查；这些结果不代表已经在真实微信执行。
- 本轮未修改诊断清空实现或消息合并代码，因此不重复运行它们上版已通过的检查。
- 构建源文件、旧包保留和新包校验见 `session-groups-inset-1.6-18-validation.json`。

设备验收：安装 1.6-18，完全退出微信后重新打开；开启诊断并清空记录，进入两条会话的私聊分组，切换“通讯录/我 → 微信”多次。核对顶部空白、搜索返回、原生下拉顶部区域、正常拖动，以及“全部”长列表的位置。若仍异常，完整新日志中的采样值、写入前后和修正结果可区分无正常观测、修正未执行、接口未生效和后续覆盖。
