# 2.1-4 发布记录 · 2026-10-28

在原工作目录 `/Users/zhangshichao/Documents/Workspace/WeChatImprove` 的 `main` 上完成版本统一、核心回归、两种方案完整构建和发布提交准备。开始时 HEAD 为 `a445c24adee5653ce64f20fdbec3052b894a2067`，远端 `main` 为 `fa4e242f`（完整 SHA 见 `initial-git-state.json`），本地领先 3 个既有回退提交。最新 AI 与列表恢复功能当时仅在未提交工作区，尚未同步 GitHub；本次将当前完整源码及所有新依赖直接提交到 main，不另造合并提交或改写历史。

## 本次整合

- 百炼 Chat Completions 联网、单图输入、SSE 接收和服务商/能力设置。通用接口保留默认文本行为；按能力修改撤销连接验证，旧配置默认值指纹保持兼容。
- 群聊独立免 @、免打扰群约 30 秒后台原生同步，及已有实时授权、去重、并发/超时、最终发送和备份回滚保护。
- AI 授权与存储/解析性能清理；图片与 JSON 工作放在后台，有界尺寸/字节/并发和取消，无新增轮询。
- 返回前台会话列表画布/间隔背景恢复及相关清理；当前工作区的「人工智能」「隐藏自动回复」入口文案一起保留，配置键与路由未改变。
- `control`、`kPluginVersionString` 和当前版本更新说明统一为 **2.1-4**。

使用与模型能力说明见 [AI 自动回复](../../features/ai-auto-reply.md)，实现细节见 [联网/图片记录](../ai-multimodal-web-2026-10-28/README.md)。

## 安装包

| 环境 | 安装包 | 包架构 | 动态库架构 |
| --- | --- | --- | --- |
| Rootless | [2.1-4 iphoneos-arm64](../../../packages/2.1-4/com.wechat.improve_2.1-4_iphoneos-arm64.deb) | iphoneos-arm64 | arm64、arm64e |
| Rootful | [2.1-4 iphoneos-arm](../../../packages/2.1-4/com.wechat.improve_2.1-4_iphoneos-arm.deb) | iphoneos-arm | arm64、arm64e |

[匹配符号](../../../packages/2.1-4/com.wechat.improve_2.1-4_symbols.zip) · [SHA256SUMS](../../../packages/2.1-4/SHA256SUMS)。两种包版本均已通过 `dpkg-deb` 验证，安装位置分别为 `var/jb/Library/MobileSubstrate/DynamicLibraries/` 和 `Library/MobileSubstrate/DynamicLibraries/`；四组动态库/dSYM UUID 匹配，符号 ZIP 完整性通过。二进制包含本次 AI 图片、SSE、联网参数、免 @、后台同步与列表恢复特征。

```text
3be49d3703b28ed786e85ce7da7db144195ee9f36c7d0130d0c341e3abbd7144  com.wechat.improve_2.1-4_iphoneos-arm64.deb
0c136dbfe1e5273a620ef5a602476a8ce4ddb5ce36ae60f42890515cf2e3b482  com.wechat.improve_2.1-4_iphoneos-arm.deb
8886e926008b26d296bbd1644bff848deaf01d44286f356f2a00164b6854d439  com.wechat.improve_2.1-4_symbols.zip
```

## 核心验证

10 个脚本全数退出 0，计数检查 **2,293** 项（AI 936 + 列表 1,357），另有 Store、Client、Coordinator 专项。

| 脚本 | 结果 |
| --- | --- |
| verify-ai-foundation.sh | Store、Client 通过 |
| verify-ai-coordinator.sh | 调度专项通过 |
| verify-ai-manager.sh | 333 项 |
| verify-ai-native.sh | 86 项 |
| verify-ai-images.sh | 145 项 |
| verify-ai-backup.sh | 78 项 |
| verify-ai-background-sync.sh | 41 项 |
| verify-authorization-read.sh | 67 项 |
| verify-background-run.sh | 186 项 |
| verify-list-corners.sh | 1,357 项 |

逐项命令、退出码、耗时及日志哈希见 [tests.json](tests.json)，603 项测试/生产输入哈希见 `test-sources-sha256.json`。所有测试使用临时配置、合成图片、URLProtocol 及原生替身，不调用真实模型，不操作真实微信数据或 Keychain，不发送消息。

两套 Theos 完整打包成功，命令、构建目录和日志见 `build-environment.json`、`build-rootless.log`、`build-rootful.log`；包/架构/UUID/特征验证见 `delivery-verification.json`。最终编译输入共 368 个文件，哈希见 `source-sha256.json`；构建期间源码无变化。

构建使用独立 `_THEOS_LOCAL_DATA_DIR`、`THEOS_BUILD_DIR`、`THEOS_PACKAGE_DIR`，没有 clean。保留任务开始时存在的 **1230** 个 `.theos`/packages 文件，哈希全部不变；新增包仅写入 `packages/2.1-4/`。任务开始时已有旧包删除和构建缓存改动，保持其本地状态，不将这些删除/缓存或用户反馈截图混入发布提交。

## GitHub 核对

目标为 [ZhangSCzybh/WeChatImprove 的 main](https://github.com/ZhangSCzybh/WeChatImprove/tree/main)。发布提交显式包含本次改动的生产源码/新增模块、测试、文档、审计证据和 2.1-4 包。提交前已逐项比较 Git index 的 368 项编译输入和 3 个包/符号文件 SHA-256，全部匹配构建清单；提交后再核对 Git HEAD。当前源码、测试、功能文档及本次发布记录的 `git diff --cached --check` 通过；历史原始源码快照和原始 diff 保留其原有空白。推送使用普通 fast-forward 并在远端核对 main SHA，结果随任务最终交付。

本次仅发布源码和包，未安装到设备。真实联网检索、微信图片下载和免打扰锁屏回复，以及温度和耗电，仍需真机验收。
