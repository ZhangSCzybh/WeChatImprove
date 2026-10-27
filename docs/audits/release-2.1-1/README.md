# 2.1-1 打包记录

2026-10-27，按用户要求在原主目录的 `main` 上重新构建最新合并源码。源码基线为 `dfc3487d20e3879f83c7715bd11f373dfb23a130`，本次仅更新包版本、插件显示版本、离线更新说明及文档，没有修改功能执行逻辑。

## 交付内容

| 产物 | 路径 | 大小 |
| --- | --- | --- |
| Rootless | [com.wechat.improve_2.1-1_iphoneos-arm64.deb](../../../packages/com.wechat.improve_2.1-1_iphoneos-arm64.deb) | 1,382,604 字节 |
| Rootful | [com.wechat.improve_2.1-1_iphoneos-arm.deb](../../../packages/com.wechat.improve_2.1-1_iphoneos-arm.deb) | 1,382,964 字节 |
| 调试符号 | [com.wechat.improve_2.1-1_symbols.zip](../../../packages/com.wechat.improve_2.1-1_symbols.zip) | 10,311,584 字节 |

两种安装包均包含 `arm64` 和 `arm64e` 动态库切片。Rootless 安装到 `/var/jb/Library/MobileSubstrate/DynamicLibraries`，Rootful 安装到 `/Library/MobileSubstrate/DynamicLibraries`。符号归档按方案和架构分别保存四套 dSYM。

此版本包含 AI 自动回复、API 与模型配置、连接测试、多个命名预设、会话独立选择及群聊单独 @ 触发。手动回复与 AI 并行；群聊设置位于「查找聊天内容」下方，沿用原生布局。密友的 AI 和定时任务隐藏选项只影响页面列表，自动回复和定时发送继续执行。保留 2.0-27 的折叠摘要与页面稳定性修复。

## 验证结果

- `control`、`kPluginVersionString`、当前离线更新说明与两种包的元数据统一为 `2.1-1`。
- Rootless、Rootful 均从独立临时构建目录完整编译成功，零错误；每种方案有 12 条既有 UIKit API 弃用／链接参数警告。
- 解包验证两种动态库均含 `arm64 arm64e`，四个架构／方案组合的 UUID 与对应 dSYM 一致，符号 ZIP 完整性检查通过。
- 动态库包含 AI 管理、调度、原生聊天详情、定时任务及两项隐藏开关标识；构建前后功能源码 SHA-256 一致。
- 原目录下 1,239 个历史构建与安装包文件逐一核对 SHA-256，全部保留。未执行 `make clean`，未覆盖旧安装包。
- 功能逻辑沿用合并 main 时通过的 14 个核心验证脚本：计数脚本共 2,558 项检查通过，另有 AI 基础／调度专项和 5 个代理生命周期场景。详见 [合并与核心验证记录](../../features/ai-auto-reply-validation.md)。本次只改发布元数据，验证范围集中在完整编译、包内容与调试符号。

尚未安装或进行真机验收；本机编译、包内容校验与此前替身回归不能替代微信设备上的实际回复／定时发送验证。本次没有执行真实模型调用、微信发送或修改设备数据。

## 证据文件

- [构建脚本](build.py)、[构建环境与命令](build-environment.json)、[源码基线](source-base.txt)
- [Rootless 构建日志](build-rootless.log)、[Rootful 构建日志](build-rootful.log)
- [产物大小及 SHA-256](packages.json)、[包内容与符号校验](delivery-verification.json)
- [构建源码 SHA-256](source-sha256.json)、[既有文件保留清单](preservation-before.json)

构建脚本为此次发布保留，发现同版本交付产物时会拒绝覆盖。
