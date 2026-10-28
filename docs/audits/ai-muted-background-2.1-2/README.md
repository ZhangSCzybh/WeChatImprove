# 2.1-2 免打扰群后台 AI 回复修复

用户反馈：群免打扰、免 @ 已开且显示“后台音频已启动”时，普通消息在返回微信后才补齐；被单独 @ 时可在后台回复。修复在原项目 `main`（基线 `a445c24a`）补充有条件的原生后台同步，版本继续使用用户指定的 `2.1-2`。本记录包含实现、核心回归、打包核验及 iOS 微信 8.0.78 `NewSyncService` 的有限静态证据；尚未安装到真机，没有实际后台接收成功、续航或稳定性结论。

## 实现与启停条件

新增 `CSAIBackgroundSync`，由 AI manager 在主线程管理。仅当微信处于后台、用户已开启后台运行且音频实际播放并持有 session、账号及 epoch 有效、插件授权有效、AI 总开关及连接验证有效，且至少一个有效群同时开启 AI 和免 @ 时启动。进入合格状态立即尝试一次，之后约每 30 秒尝试；使用单调时间限频，忙碌、拒绝和异常也消耗当次预算，不追补错过的定时器周期，快速关闭／重开不会清掉限频。

每次请求取得当前账号的 `NewSyncService`，通过已有 `CSMessageNativeSupports/Invoke` 检查 `isGettingData` 和 `BackGroundFetchToSync` 的 BOOL ABI，保留账号上下文 wrapper 转发。忙碌时跳过，调用前再次检查资格及捕获的账号／epoch。不会强制恢复原生暂停状态。返回前台立即停止，音频失效、关闭相关开关或账号／连接失效时停止；每次 tick 也重新检查。群免打扰设置不变，隐私隐藏的已启用群仍按配置回复。

同步后新消息继续进入既有 `AsyncOnAddMsg:MsgWrap:` Hook 和 AI 回复链路。没有增加接收 Hook，也没有放宽旧消息、去重、@所有人、本人消息、非文本、过期或最终发送限制。只为音频 manager 增加只读 `backgroundAudioActive`，不改变音频保活流程。额外同步会增加网络和耗电，30 秒只表示请求间隔；系统挂起、强退、网络或服务端限制仍可能使后台同步不能完成。

## 聚焦核心回归

| 命令 | 结果 | 关键覆盖 |
| --- | --- | --- |
| `bash Tests/verify-ai-background-sync.sh` | 41 项通过 | 首次立即、30 秒限频、无追补、陈旧 timer、重入、回调内撤销、停止／重启和释放 |
| `bash Tests/verify-ai-manager.sh` | 305 项通过 | 保留此前 188 项；新增同步至现有 Hook／生成／发送链路、去重、19 项资格门、前后台通知竞态、账号重入、忙碌及异常、ABI 和 wrapper |
| `bash Tests/verify-ai-native.sh` | 78 项通过 | 群原生设置顺序、开关、其他群和私聊隔离、消息解析、共享 UIKit 测试声明兼容 |
| `bash Tests/verify-background-run.sh` | 186 项通过 | 原生音频 Hook、前后台／中断／宿主抢占；新增实际租约已失效但状态文本尚未变化时立即拒绝同步的资格检查 |
| `bash Tests/verify-ai-coordinator.sh` | 通过 | 原有按群免 @、去重、合并、并发、上下文、取消、过期及最终发送保护 |

计数脚本合计 610 项通过，另有 coordinator 专项通过，`git diff --check` 通过。所有自动化检查使用临时文件、替身模型与微信／音频服务，没有调用真实模型或发送真实微信消息，不读写用户真实账号配置和数据库。

## 修复安装包与验证

本轮两种完整打包均成功，版本仍为 `2.1-2`。为区分首次免 @ 包且保留历史产物，新包放入独立目录 `packages/2.1-2-muted-background/`：

| 文件 | SHA-256 |
| --- | --- |
| [Rootless 安装包](../../../packages/2.1-2-muted-background/com.wechat.improve_2.1-2_iphoneos-arm64.deb) | `265e7ede47dac40aee77ce4ad5c1dba2986437d32027f52029e61c209315abff` |
| [Rootful 安装包](../../../packages/2.1-2-muted-background/com.wechat.improve_2.1-2_iphoneos-arm.deb) | `3bb6d52c11e8f6fa1a7603409fb78a216544c572134d8dac659f31dcaa47c289` |
| [调试符号](../../../packages/2.1-2-muted-background/com.wechat.improve_2.1-2_symbols.zip) | `29d544ded53955bff19fc2d6f364dfaba91d4aa2747d97a9167557949ddcb030` |

逐包确认 `arm64 arm64e`、Debian 版本与架构、Rootless／Rootful 安装路径及新增功能标识；四份 dSYM UUID 与对应动态库一致，符号 ZIP CRC 通过。两次编译均 0 错误、12 条仓库既有警告，此次 AI 和音频状态改动文件无新增警告。构建使用独立对象、stage 和 package 目录，不执行 `make clean`；输入源码在两次构建期间哈希一致，原有 1,228 个 `.theos`／`packages` 文件逐个哈希保持不变。没有切换分支、服务、数据库或安装插件。

完整命令和环境见 [build-environment.json](build-environment.json)，源码清单见 [source-sha256.json](source-sha256.json)，结果见 [delivery-verification.json](delivery-verification.json) 和 [packages.json](packages.json)。两种完整日志为 [build-rootless.log](build-rootless.log) 与 [build-rootful.log](build-rootful.log)。

真机核心验收：使用本目录修复包，保持群免打扰开启，确认该群 AI 与免 @、总开关及已验证连接有效，后台运行显示音频已启动。将微信留在后台，由另一账号发送普通文本并等待下一轮同步及模型生成，检查无 @ 自动回复且同一消息只回复一次；再关闭免 @，检查普通消息不触发、单独 @ 仍可回复。还需检查锁屏及较长后台时段的同步、系统中断后的状态和实际耗电。主机回归不能代替上述真机结果。

## 原生静态证据

目标文件为 `/tmp/wechat-8.0.78-inset-analysis/WeChat`，SHA-256：

```text
0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e
```

目标是 arm64 Mach-O，`NewSyncService` 类元数据地址 `0x1203859a8`。分析使用只读 mmap 解码 Objective-C 方法及 ivar 元数据，并按方法起止地址使用 LLVM 有界反汇编。没有运行、附加、修改目标，也没有访问真实用户数据或操作共享 REA 会话。

## 已确认的入口及原生保护

| 方法 | 地址 / Objective-C ABI | 静态观察 |
|---|---|---|
| `BackGroundFetchToSync` | `0x1051825c8` / `B16@0:8` | 统计后尾调用 `InternalCreateSync:(12)`；完整方法体无前台状态门禁。动态派发签名为 `BOOL (*)(id, SEL)`。 |
| `isGettingData` | `0x1051809a0` / `B16@0:8` | 可用于外层跳过正在同步的服务；内部事件 ID 保护仍需保留。 |
| `InternalCreateSync:` | `0x1051818bc` / `B20@0:8I16` | 检查原生暂停状态、主设置初始化、服务初始化及活动事件 ID；已有事件时，场景 12 直接返回 `NO`，不另排 need-sync。 |
| `creatPBNewSyncEvent:` | `0x105181b34` / `B20@0:8I16` | 写入请求场景，构造 `NewSyncRequest` 与 CGI 138 的 `ProtobufCGIWrap`，通过 `EventService CreateProtobufEvent:Flag:`（flag 5）提交；完整方法体未见前台或场景 12 排除。 |
| `NotifyToSync` | `0x1051821cc` / `B16@0:8` | 使用已有 `m_uiSyncScene` 进入内部入口，不固定为后台请求场景。 |
| `LongLinkTimerSync` | `0x1051827c8` / `v16@0:8` | 忙碌时忽略，否则记录场景 2/4 的 need-sync；不是同等直接的一次后台 fetch。 |

入口 `BOOL` 返回值只反映事件创建或忙碌等受理结果，不代表同步完成、已经收到群消息或 AI 已回复。集成应在主线程、当前账号和 epoch 下重新校验资格，保留运行时 ABI 检查；不清活动事件 ID，不调用 `resetGettingData`，也不强制恢复原生暂停状态。

## 生命周期结论

`onServiceEnterBackground`、`onServiceEnterForeground`、`onWillSuspend` 的完整方法体仅在登录有效时构造 `BgFgRequest`、以在线模式 2/1/3 和命令 312 交 `EventService` 上报；前台方法另置首轮同步标志。后台及挂起方法体未调用 `makeSyncPause`、`setSyncPaused:` 或读写 `m_bIsSyncPause`，也未直接请求新消息同步。

真正的 `makeSyncPause/Resume` 是独立路径，并联动 `BypSyncService`。上述“没有暂停”的结论仅覆盖所检查的方法体，不排除其他观察者、网络层或系统执行暂停。精确地址和逐条证据见[生命周期报告](native-static/lifecycle/report.md)。

## 文件与复核边界

- [入口结论与约束](native-static/entry-review.json)、[方法元数据](native-static/methods.json) 和[SHA-256 清单](native-static/manifest.json)记录目标身份、地址、ABI、已观察行为及未知。
- `native-static/*.asm` 是有限方法范围的原始反汇编；相应 `.asm.annotated` 解析直接 ADRP/load 对应的 selector、ivar 和常量字符串。注释用于阅读，原始指令与元数据是本地证据。LLVM 输出中的邻近 Flutter 符号标签不代表这些 Objective-C 方法的真实名称。
- `native-static/lifecycle/` 保留本次生命周期结论所需的方法体、ivar、选择器引用和简短报告；没有复制完整应用反汇编、二进制或 56 MB 的全局引用索引。
- `native-static/extract.py` 是原有只读元数据解析器的本轮副本。其输出目录保留原分析 `/tmp` 路径；本审计目录的完整性以本地 manifest 为准。

静态分析不能确定 iOS 是否持续给予执行时间、`EventService` 和网络是否完成后台同步、服务器是否返回静音群消息、30 秒调度的实际延迟与能耗、其他微信版本的 ABI 或真机插件组合表现。这些需要独立的核心自动化检查与真机复验；本目录不把静态路径可达当作真机验收。
