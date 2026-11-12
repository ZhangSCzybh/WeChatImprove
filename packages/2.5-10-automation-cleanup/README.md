# 2.5-10 自动功能清理

本版基于当前工作区的 2.5-9 清理，保留此前已完成的自动功能、后台同步与群拍动修复。Git 提交基点为 `eb32eaa549ec8b63ac2ce8cb214fb05827c8e8be`；该提交之后本地已有的 2.5-2 至 2.5-9 源码改动属于本版发布输入，不能把旧 Git HEAD 当作本次清理前的功能基线。

## 清理范围

- 移除拍动 XML 解析仅供诊断的兼容接口，将遗留测试改为核对实际解析结果与拒绝边界。
- 清理自动功能中的无用参数与重复声明。
- 保留严格 XML 与群消息前导解析、统一入站快照、账号和授权校验、会话名单、持久去重、发送与撤回调度，以及拍动与 AI 共用的约 45 秒后台同步预算。
- 保留既有功能设置、账号配置与历史数据。没有安装手机、启动或切换服务，也没有执行数据库迁移。

## 安装包

用户当前环境为 **Rootless**，请选择 [Rootless 安装包](com.wechat.improve_2.5-10_iphoneos-arm64.deb)。另提供 [Rootful 安装包](com.wechat.improve_2.5-10_iphoneos-arm.deb)、[Rootful 重签用 dylib](WeChatImprove.dylib)、[两种方案的调试符号](symbols.zip) 与 [SHA-256 清单](SHA256SUMS)。两个方案均编译 arm64 / arm64e，最低目标 iOS 15.0。

## 测试与构建

本轮运行 15 个与清理范围相关的 runner，全部通过；下表合计打印 6,161 个成功 checks，包含循环、共享夹具及多种 ABI 模式，不能当作互相独立的功能数量。另对 core、native、manager 三项执行 `--ios`，均完成 arm64 / arm64e 严格源对象编译。

| 回归脚本（`Tests/`） | 成功 checks |
| --- | ---: |
| `verify-automation-core.sh` | 200 |
| `verify-automation-native.sh` | 590 + 48 ABI |
| `verify-automation-manager.sh` | 167 + 110 后台 + 9 timer |
| `verify-automation-pat-ingress.sh` | 79 |
| `verify-automation-pat-unified-ingress.sh` | 106 + 94 ABI |
| `verify-automation-pat-content-boundary.sh` | 99 |
| `verify-automation-background-sync.sh` | 59 |
| `verify-background-sync-budget.sh` | 89 |
| `verify-automation-backup.sh` | 72 |
| `verify-ai-manager.sh` | 863 |
| `verify-ai-native-sync-observer.sh` | 786 + 42 ABI |
| `verify-ai-background-sync.sh` | 115 |
| `verify-ai-native.sh` | 86 |
| `verify-scheduled-task-manager.sh` | 2,360 |
| `verify-close-friend-automation.sh` | 187 |

11 项外溢回归在冻结的 2.5-9 基线和清理后均通过，其中 10 项 checks 序列完全一致。内容边界从 147 降至 99，仅删除 48 条诊断 reason、固定码及输出隐私断言；所有原非法输入、实际拒绝、有效身份、后台两项动作、持久认领和晚到 49/62 去重断言保留。核心回归的原诊断统计断言已迁移为相同样例的实际解析结果检查，修复了 2.5-9 因兼容接口返回空统计而造成的旧测试失败。

独立源码复核以本轮冻结的 2.5-9 为准：EventAdapter 的原判定条件、调用顺序和返回事件逐字保留，仅移除诊断封装与输出；Manager 只删除重复声明；Hooks 只删除三个未使用的内部参数。账号代次校验、原生 Hook 参数转发、快照、发送、去重、延迟及同步预算均保留。

Rootless / Rootful 使用同一份冻结的 444 个生产输入分别构建，两个构建退出码均为 0；完成后与当前源码逐项 SHA-256 一致。已核验：

- 两包的 `Package=com.wechat.improve`、`Version=2.5-10` 和对应 Debian 架构；两份 dylib 均含 arm64 / arm64e，最低 iOS 15.0。
- Rootless 安装在 `/var/jb/Library/MobileSubstrate/DynamicLibraries/`；Rootful 安装在 `/Library/MobileSubstrate/DynamicLibraries/`，注入过滤配置与源码一致。
- Rootless 的 RPATH、独立 dylib 与 Rootful payload 的字节一致性，以及两种方案共四个切片的 dylib / dSYM UUID 匹配。
- `symbols.zip` CRC 和 `SHA256SUMS` 四个文件全部通过；46 个既有历史产物的 SHA-256、大小和修改时间保持一致。

构建没有运行 `make clean`，未改写当前 checkout 的 `.theos` 缓存。详细基线、日志与独立审查按仓库惯例保存在本机 `WeChatImprove-local-archive/audits/2.5-10/`。

## 验证限制

2.5-10 尚未安装到手机实测。用户确认正常的前台、后台未锁屏及锁屏群拍动回拍与回复属于 2.5-7 的历史验收，不代表本版已实测。主机回归及成功构建不能证明手机上的实际送达、撤回、界面交互或插件组合兼容性。

2.5-9 的历史全套结果为 130 个 runner 中 110 通过、20 失败。本轮按影响范围验证上述 15 项，没有重跑全套，也未改动分组、密友等其他旧 fixture 的既有失败；不能将本次相关回归全通过表述为全仓测试全绿。历史包继续保留。
