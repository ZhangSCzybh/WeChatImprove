# 2.1-29 准备阶段：源码保护与构建基线

冻结提交：`11a3d078f7f0c6a7751f5ca8a1d7e3a0c5213b41`。本记录写于候选修改之前，只描述当时的源码与历史构建基线；准备阶段没有修改生产代码或版本元数据、构建 2.1-29、安装手机、启动或重启微信。最终修改与构建结果见本目录 README。

## 完整方法保护

[source-guard-sha256.json](source-guard-sha256.json) 保存四个完整定义的字节数、SHA-256、基线提交和源码路径；原始定义保存在 [source-guards](source-guards/)。范围包括 2.1-26 的 `setPresentationSuspended:forController:`，2.1-27 的完整 `refresh` 与 `publishProjection:…`，以及 2.1-28 的完整 `performVisibleLayout:`。

校验按原始字节比较，不归一化空格、换行、注释或 token。校验器同时确认冻结片段与记录哈希、Git 基线定义和当前生产定义一致。此命令只读取文件和 Git 对象，结果输出至标准输出：

```bash
python3 -B docs/audits/release-2.1-29-top-chrome-return-flicker/verify-source-guards.py
```

初次校验见 [source-guard-initial-check.json](source-guard-initial-check.json)：四个方法均逐字节相同，生产文件相对当前 HEAD 的差异清单为空。源码保护检查是静态校验，不是手机运行计数或设备帧验证。

## 2.1-28 警告基线

基线为 `release-2.1-28-closefriend-return-leak/layout-firstframe-candidate-1` 的实际 rootful／rootless 构建结果；每方案均为 **6 条**。剥离 ANSI 后的准确多重集合与原记录 SHA-256 已保存至 [warning-baseline-2.1-28.json](warning-baseline-2.1-28.json)。

| 既有警告 | 每方案次数 |
| --- | ---: |
| `Hooks/CloseFriendNotificationHooks.xm:393:62`：`UILocalNotification` 弃用 | 2 |
| `Hooks/RedEnvelopHooks.xm:132:61`：`statusBarFrame` 弃用 | 2 |
| `ld: warning: -multiply_defined is obsolete` | 2 |

2.1-29 构建脚本要求警告多重集合与上述基线完全相同，并核验基线记录 SHA-256；只维持相同总数不足以通过。

## 输入与历史文件保护

- [baseline-production-input-sha256.json](baseline-production-input-sha256.json)：42,513 份生产输入的 SHA-256；包含 Controllers、Hooks、Headers、HeadersFile、layout，以及 Makefile、control、注入 plist，排除 `.DS_Store`。
- [historical-packages-before.json](historical-packages-before.json)：准备阶段 `packages` 下全部 **84 个文件**的 SHA-256，包含既有包、符号、校验清单及现存文件；构建前和最终验证均逐一复核。
- 准备时 `.theos` 有 **1,237 个文件**，连同 `packages` 共 **1,321 个既有文件**；实际构建仍会另行冻结全部现存 `.theos`／`packages` 文件并验证没有修改或缺失。
- 参考的 2.1-28 候选构建当时保护了 1,317 个既有文件，随后新增四个候选交付文件；与本次 1,321 的起点一致。

设备尚未连接到可用诊断通道，当前没有新增的真机刷新次数、UIView 交付次数或修复后帧数据。宿主静态校验及历史主机回归不能替代这些运行证据。
