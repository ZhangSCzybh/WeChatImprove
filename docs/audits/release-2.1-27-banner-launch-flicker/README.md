# 2.1-27：冷启动首次发布顶部业务行

日期：2026-10-30，Asia/Shanghai。使用既有工作目录 `/Users/zhangshichao/Documents/Workspace/WeChatImprove`，基线为 `main` 的 `2bbb6cae3b4e63cdd7bd76b4b70e94e6434b46b1`（2.1-26）。未切换 checkout、安装到设备或改写账号、配置和数据库。

## 根因与最小修改

用户新录屏的第 58 帧显示收藏置顶与“已登录 Mac”；第 62–67 帧卡片位置、高度保持而内容变空，第 68 帧恢复。这是冷启动首次进入分组列表的反馈，与 2.1-26 的离页返回路径分开处理。

首发代码在切换 `projection/projecting` 后，先 `layout` 挂载分组表头，再调用 `publishProjection:` 的既有首次 `reloadData`。表头 setter 允许同步布局和数据源重入，因此可以在正式刷新之前交付一批新顶部 cell；正式刷新又使其失效并构造第二批。

原生静态证据确认：`MainFrameHeaderLogic.getBanner:` 从 `m_bannerAry` 中取包装器持有的既存 UIView，同一行不是每次创建独立内容。原生 Header cell 构造时清理 contentView，再 `addSubview:` 这个共享 banner。第二个容器会把内容从第一个容器移走，留下几何不变的白板。详见 [原生证据及边界](native-evidence.md)。这是首次发布顺序与共享视图所有权的缺陷；没有证据表明原生文字需要异步准备。

生产行为仅修改 `Controllers/CSGroupListAdapter.m` 的两处：

1. `refresh` 对首次激活投影跳过提前的表头 `layout`。
2. `publishProjection:` 在原有首次 `reloadData` 之后、原有 `layoutIfNeeded` 之前同步执行该 `layout`。先使旧 cells 失效，再通过表头或最终布局交付完整内容，不再交付随后会被废弃的首发容器。

没有新增全表刷新，没有把局部刷新换成全表刷新，没有延时、隐藏、动画或透明度补偿。增量路径、分组投影结构、密友、底栏角标、AI 和滚动恢复代码未修改。2.1-26 的 `setPresentationSuspended:forController:` 与基线逐字一致。另同步 `control`、`Headers/CSUserInfoHelper.h`、内置发布说明和 README 的版本及交付入口。

## 红绿回归

新增测试完整提取并执行生产 `refresh`、`publishProjection:`、`layout`、`publishHeader:`、`cellForDisplayPath:` 与 `isActive`，不替换方法体；使用真实投影与索引作用域。UIKit 替身提供可同步重入和普通两种表头行为，按原生共享 UIView 语义检查每一行的交付次数、初次与最终容器身份、内容 superview、空容器及后续局部刷新。

先在保存的 2.1-26 源码上执行最终测试版本，结果为 **32 项中 9 项失败、23 项通过**。修改生产代码后，同一测试文件与提取器未变，结果为 **32 项全绿**。9 个红项包含两行分别重复交付、首容器被替换、共享内容被移走，以及首次表头早于刷新。可直接重放旧代码控制：

```bash
bash Tests/verify-group-launch-banner.sh \
  docs/audits/release-2.1-27-banner-launch-flicker/regressions/CSGroupListAdapter-2.1-26.m.txt
```

仅运行用户指定范围的核心回归：

| 套件 | 检查数 | 失败数 | 日志 |
| --- | ---: | ---: | --- |
| 首次顶部业务行发布、重入及后续局部刷新 | 32 | 0 | [绿](regressions/group-launch-banner-green.txt) / [旧代码红](regressions/group-launch-banner-red.txt) |
| 页面生命周期与顶部返回路径 | 239 | 0 | [日志](regressions/group-lifecycle-green.txt) |
| 分组切换、共享滚动高度及聊天返回位置 | 151 | 0 | [日志](regressions/group-viewport-green.txt) |
| 搜索进入、返回与分组内容 | 57 | 0 | [日志](regressions/group-search-green.txt) |
| 合计 | 479 | 0 | [汇总及红绿测试输入哈希](regressions/regression-summary.json) |

**首次提交与空白态的回答：**在受控首次投影回放中，两条业务行各仅交付一次，首容器即最终容器，中间没有共享内容被移走的空容器；完整内容在同一个同步发布调用中准备并挂载。无变化返回不重建顶部业务行；真实无归属内容事件仍走局部刷新。

**帧验证边界：**原生静态分析证明共享视图语义，主机测试证明旧顺序的风险可达且新顺序消除了这条重入路径。替身的空容器计数不是设备帧统计；尚未采集修复后真机录屏，因此不能声称已经实测冷启动零空白帧，也不能把用户那次录屏的确切原生回调时刻当作已观测事实。

## 构建、警告与历史产物保护

- [构建结果](build-result.json)：rootful、rootless 在独立临时目录全量编译和打包，退出码均为 0；每包含 arm64 / arm64e，目标 iOS 15.0。
- [输入对照](production-input-comparison.json)：42,513 份生产输入中仅适配器、版本头、内置发布说明和 control 四个文件变化，其余 42,509 份不变；构建前后输入哈希一致。
- [警告对照](warning-baseline-comparison.json)：每方案 6 条，与 2.1-26 去除 ANSI 控制符后的警告多重集合完全相同。为既有 `UILocalNotification` 弃用 ×2、`statusBarFrame` 弃用 ×2、链接器 `-multiply_defined` 过时 ×2，无新增警告。
- [历史产物保护](preserved-artifacts-after.json)：既有 `.theos` 与 `packages` 共 1,309 个文件未缺失、未修改。没有执行 `make clean`，新目录没有覆盖历史包。
- [包与符号校验](package-verification.json)：版本、安装路径、payload 与 staging 一致、注入目标、双架构、依赖、最低系统、四份 dSYM UUID 和符号归档均通过。

## 交付

全部位于新目录 `packages/2.1-27-banner-launch-flicker/`：

| 文件 | SHA-256 |
| --- | --- |
| `com.wechat.improve_2.1-27_iphoneos-arm.deb`（rootful） | `c9963949f4e991f41fde9f7ced767eb2986fbb51b362e50cb7b3663a4d7d9fc3` |
| `com.wechat.improve_2.1-27_iphoneos-arm64.deb`（rootless） | `d52af49016011da8e49a9f3089610576deb51c9de49ed30c0a1d4555d454c319` |
| `com.wechat.improve_2.1-27_symbols.zip` | `84d2d0d68de73e221cf0304b4d20fe2b07cdfa64581f2e04e4f674cdee7ce532` |

另提供 `SHA256SUMS`。未自动安装到手机；冷启动最终视觉验收应沿用原有设备注入方案、账号与数据，完全退出微信后重新打开，复录顶部两行首次出现，并检查返回、分组切换、搜索与滚动位置。
