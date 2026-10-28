# 2.1-2 群聊免 @ 回复与打包验证

2026-10-27，在原项目目录 `/Users/zhangshichao/Documents/Workspace/WeChatImprove` 的 `main` 上实现。基线为 `a445c24a`，保留此前的测试版更新说明，按用户要求将包版本、插件显示版本与当前更新说明同步为 `2.1-2`。

## 功能行为

群聊原生详情在「查找聊天内容」下方按「启用 AI 回复 → 免 @ 回复 → 回复预设」排列，AI 设置中的群会话页同步提供此选项。私聊不新增开关。`allowUnmentioned` 为可选的群会话布尔字段，旧配置缺失时按关闭处理，无须迁移；切换会话启用状态或回复预设时保留该字段，备份和恢复也保留。

开启后，仅当前群的新文本消息无需单独 @ 即可进入自动回复。总开关、当前群开关、连接验证、授权、账号和最终发送校验继续生效；@所有人、本人消息、非文本、历史和重复消息继续排除。关闭后取消尚未提交的活跃／排队回复，并拒绝迟到回包。配置变更沿用既有统一取消机制，会取消当前待回复任务并清空内存上下文。

## 聚焦核心回归

| 命令 | 结果 | 直接覆盖 |
| --- | --- | --- |
| `bash Tests/verify-ai-foundation.sh` | StoreTests、AIClientTests 通过 | 旧配置兼容、新字段类型校验、保存与重载、既有存储及连接边界 |
| `bash Tests/verify-ai-native.sh` | 78 项通过 | 群行顺序、私聊不增加、开关操作、重复刷新、陈旧／隐私动作拒绝、原生开关接口回退、消息解析 |
| `bash Tests/verify-ai-coordinator.sh` | 通过 | 按群开启、其他群隔离、默认关闭、去重、@所有人排除、双重开关、关闭取消及迟到回包 |
| `bash Tests/verify-ai-manager.sh` | 188 项通过 | 生产 Hook 至发送链路、按群免 @、预设／启用保留、账号与编辑保护、隐藏群仍回复、既有手动回复并行 |
| `bash Tests/verify-ai-backup.sh` | 54 项通过 | 新字段导出、恢复及重载、缺字段默认关闭、既有恢复暂停及事务保护 |

计数脚本合计 320 项检查通过，另有存储、客户端及调度专项通过。测试仅使用临时目录、fake client 和原生替身，没有调用真实模型、发送真实微信消息或访问用户真实配置／凭据。

## 发布产物

| 文件 | 用途 | SHA-256 |
| --- | --- | --- |
| `packages/com.wechat.improve_2.1-2_iphoneos-arm64.deb` | Rootless | `dc5674f203ff2490d7d8d1e54c12d298ca17e91781beb2cca64fb3c733adafff` |
| `packages/com.wechat.improve_2.1-2_iphoneos-arm.deb` | Rootful | `06dcb5bd43f0e9d35a24ec383ac0fe04eb0991d2117162b0dd99c22bf133774a` |
| `packages/com.wechat.improve_2.1-2_symbols.zip` | 两种方案的 arm64／arm64e dSYM | `84b8479f71a2b49a0c8f6b40f3e0e14ec86e7dab8096b8b8c9aeb55764dcf6f2` |

两次完整打包均成功，动态库均包含 `arm64 arm64e`。逐包核对版本 `2.1-2`、Debian 架构及安装路径：Rootless 为 `/var/jb/Library/MobileSubstrate/DynamicLibraries`，Rootful 为 `/Library/MobileSubstrate/DynamicLibraries`。逐架构确认免 @ 功能标识和插件版本均进入产物，动态库与四份 dSYM 的 UUID 匹配，符号 ZIP 完整性检查通过。无此次 AI 修改文件的编译警告；保留仓库既有弃用接口及链接器警告。

构建使用独立临时对象、stage 和 package 目录，没有执行 `make clean`。打包期间所有输入源码哈希保持一致，既有 1,225 个 `.theos`／`packages` 文件逐个 SHA-256 核对未变；只向 `packages` 增加本版本三份产物。未切换项目分支、服务或数据库，未安装到设备。

构建命令、输入源码哈希、完整日志、产物哈希及核验结果见本目录的 `build-environment.json`、`source-sha256.json`、`build-rootless.log`、`build-rootful.log`、`packages.json` 和 `delivery-verification.json`。

真机待验：目标微信群详情实际布局、开关状态保存、普通群消息免 @ 回复、关闭后恢复单独 @ 条件，以及真实模型与微信发送结果。主机替身回归及双架构打包通过不等同于这些真机流程已经验证。
