# 2.1-22 手动备份与后台运行策略

日期：2026-10-30。基于用户既有工作目录 `/Users/zhangshichao/Documents/Workspace/WeChatImprove` 构建，分支 `main`。按用户要求将 `control`、插件内显示版本、内置更新说明及 README 同步更新为 `2.1-22`，生成 Rootless / Rootful 安装包与调试符号。

## 更新内容

- 配置备份仅保留手动创建。删除自动备份、版本更新备份和恢复/重置前保护备份；历史文件继续可用，事务失败回滚仍保留。详见[备份指南](../../backup-guide.md)及[实现验证](../manual-backup-only-2026-10-30.md)。
- 后台运行新增每日允许时段，支持跨午夜；每次最长 5/15/30/60/120 分钟或不限。首次成功启动保活后连续计时，暂停、开关和策略修改不重置预算，返回前台后结束本轮。
- 新增低电量模式、电量回差和系统热状态保护，微信通话/录音优先。事件通知配合最多一个单次边界回调，不新增轮询。
- 设置页显示运行原因、剩余时长及上次结果。既有用户保留全天、不限时、节能关闭，首次编辑保存策略后使用所选限制；新用户默认总开关关闭、全天、30 分钟、节能开启。
- 新策略纳入手动备份，旧备份与旧待执行事务兼容；修复夏令时跳时当天时间编辑可能改写时分的问题。详见[后台运行说明](../../background-run-policy-proposal.md)及[完整验证](../background-run-policy-2026-10-30.md)。

本版继续包含 2.1-21 的会话列表两阶段优化、既有定时任务规则及 AI 后台兜底开关。2.1-21 的前台 CPU 实测是前版历史证据，不能作为本版温度或续航结论。

## 编译与验证

功能改造的 14 组共 5733 项检查已通过，覆盖真实后台管理器与音频所有权、日历边界、完整生产设置控制器、AI 联动、手动备份及恢复事务，详见[专项审计](../background-run-policy-2026-10-30.md)。本次版本与说明调整后，使用相同生产源码完成两种方案的全量编译、链接和打包。

[构建脚本](build-packages.py)分别为 Rootless / Rootful 创建全新的临时对象、staging 和 session 目录，显式指定 `PACKAGE_VERSION=2.1-22`；不执行项目中会删除 `.theos` 与 `packages` 的 `make clean`。

| 核验 | 结果与证据 |
| --- | --- |
| Rootless / Rootful 全量编译链接打包 | 两种方案成功，退出码均为 0；[构建结果](build-result.json) |
| 源码输入冻结 | 构建前后 42,513 个生产输入文件哈希一致；[构建前](build-input-sha256.json)、[构建后](build-input-sha256-after.json) |
| 历史产物保全 | 原有 1,287 个 `.theos` / `packages` 文件未缺失、未修改；[保全记录](preserved-artifacts-after.json) |
| 编译警告 | 每方案 6 条；去除 ANSI 后与 2.1-21 警告内容及数量逐项一致；[比较记录](warning-baseline-comparison.json) |
| 安装包、符号与摘要 | [产物核验记录](package-verification.json) |

两种包均包含 `arm64` / `arm64e`，最低目标 iOS 15.0。Rootless 安装到 `/var/jb/Library/MobileSubstrate/DynamicLibraries/`，Rootful 安装到 `/Library/MobileSubstrate/DynamicLibraries/`。文件名中的 `iphoneos-arm64` / `iphoneos-arm` 是方案标识，请沿用设备原有注入环境。

最终产物核验通过：两包版本均为 `2.1-22`，全部 payload 与各自 staging 一致，filter 与源码一致，依赖和安装路径符合方案；后台策略 C 符号与新管理器方法存在，已移除的自动备份 Scheduler 及旧自动保存方法缺席。四份 dSYM UUID 与包内两架构逐一匹配；符号 ZIP 的 12 个文件通过 CRC、字节一致性和方法核验。两个 deb 与符号 ZIP 的 SHA-256 经独立 `shasum -a 256 -c SHA256SUMS` 复核，3/3 OK。最终核验再次读取 42,513 份生产输入及 1,287 份历史产物，均与构建记录一致。

## 交付文件

- [Rootless 安装包](../../../packages/2.1-22-background-policy/com.wechat.improve_2.1-22_iphoneos-arm64.deb)
- [Rootful 安装包](../../../packages/2.1-22-background-policy/com.wechat.improve_2.1-22_iphoneos-arm.deb)
- [调试符号](../../../packages/2.1-22-background-policy/com.wechat.improve_2.1-22_symbols.zip)
- [SHA256SUMS](../../../packages/2.1-22-background-policy/SHA256SUMS)

本次没有向手机安装或修改手机配置，也没有更换账号、数据库或服务环境。既有用户安装后需在 **插件设置 → 账号与安全 → 后台运行** 中选择最长时长、允许时段并开启节能保护，才使用所选限制。到期或暂停后微信可能挂起，AI 回复与定时任务可能延迟；允许时段不能唤醒已挂起或结束的微信。本版尚待安装后真机 CPU、温度及拔线续航验收。
