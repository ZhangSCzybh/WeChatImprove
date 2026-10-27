# 2.1-1 AI 优化与群聊免 @ 安装包

2026-10-27，根据用户「帮我打包」要求，从原项目目录的 `codex/ai-session-cache-group-unmentioned` 分支、功能提交 `d6913bff711d887145cf45cfbc9ac014d6c8408a` 完整重建。保留当前版本 `2.1-1`，包含工作目录里用户已有的更新说明修改；未修改功能源码或覆盖历史产物。

本次包包含百炼 Responses 会话续接、可选 Session 缓存、实际 Token 用量以及群聊原生「免 @ 回复」开关。基础功能的手动回复并行、密友列表隐藏不影响 AI／定时发送继续保留。源码核心回归结果见 [验证记录](../../features/ai-auto-reply-validation.md)。

产物独立保存于 `packages/2.1-1-ai-session-d6913bff/`：

| 文件 | 用途 | SHA-256 |
| --- | --- | --- |
| `com.wechat.improve_2.1-1_iphoneos-arm64.deb` | Rootless，安装至 `/var/jb/Library/MobileSubstrate/DynamicLibraries` | `2fac37197cab741a42c1d338f3c1d8d32a75b610de023aabe44db8b7129d3a08` |
| `com.wechat.improve_2.1-1_iphoneos-arm.deb` | Rootful，安装至 `/Library/MobileSubstrate/DynamicLibraries` | `1ed30a93048dc6c91dd2e6bd8eaeeb9a6cd60178b5ec6e460b4bbe901246355f` |
| `com.wechat.improve_2.1-1_symbols.zip` | 两种安装方案的 arm64／arm64e dSYM，用于崩溃定位 | `d258c2652ad3c5400b46677e55e5e54a0c017ecf69391ef34c212d3f700091cc` |

两种包都包含 `arm64 arm64e`，包元数据和插件显示版本均为 `2.1-1`。逐架构检查了新 AI 功能标识，四组动态库／dSYM UUID 均匹配，符号归档完整性检查通过。两次构建均 0 错误、12 条仓库既有弃用／链接器警告，无新增 AI 编译警告。

构建使用临时对象、stage 和 package 目录，没有执行 `make clean`。开始前记录的 1218 个既有 `.theos`／`packages` 文件逐一通过 SHA-256 核对，所有打包输入源码也保持不变；本地 API Key、微信数据均未访问。

包管理器可能将此包识别为同版本重新安装，应按设备当前环境选择对应包。尚未安装到设备；真实百炼连接、缓存命中／计费和微信原生页面／发送结果仍需真机验收。

构建命令、源码哈希、完整日志、包哈希及校验结果分别保存于本目录的 `build-environment.json`、`source-sha256.json`、`build-rootless.log`／`build-rootful.log`、`packages.json` 和 `delivery-verification.json`。
