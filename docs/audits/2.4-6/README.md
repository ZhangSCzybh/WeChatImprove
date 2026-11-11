# WeChatImprove 2.4-6 审计

群聊设置已删除第五段「后台运行」和独立开关。入群欢迎和退群监控使用「插件设置 → 后台运行」：开启时，已配置的群自动请求后台运行；关闭时，群聊撤回请求、停止后台处理，回到前台按原有成员名单差分补齐。此次只改群聊设置页、Store、Manager 和 `control`。工作区为 `/Users/zhangshichao/Documents/Workspace/WeChatImprove`；本次交付是本地 iOS 插件包，无服务 URL、端口或数据库切换。

## 判定链路

1. [插件级设置页](../../../Controllers/CSBackgroundRunViewController.m#L54) 写入 `BackgroundRunEnabled` 并发出设置变更通知。[全局管理器](../../../Controllers/CSBackgroundRunManager.m#L182) 重新读取该键。群聊通过 [启动时取得的同一个共享实例](../../../Controllers/CSGroupChatManager.m#L111) 只读 `enabled` 和 `canAttemptBackgroundWork`，不写全局键。
2. [群聊 Manager 第 75 行](../../../Controllers/CSGroupChatManager.m#L75) 读取 `enabled`。全局已开启、当前账号就绪且匹配、授权有效、未保存中，并有启用了欢迎或退群监控的已选群，才通过[已有 Hook](../../../Hooks/GroupChatHooks.xm#L12) 调用 `setGroupChatBackgroundRequested:YES`。全局开启时，[第 86 行](../../../Controllers/CSGroupChatManager.m#L86) 等全局管理器完成当次状态更新再登记群聊需求，避免两方各自尝试开启一轮后台任务。 [第 83 行](../../../Controllers/CSGroupChatManager.m#L83) 在全局开关变为关闭时同步重算并传入 `NO`，即使当前没有后台执行机会也会撤回。
3. 实时处理还须满足[第 56 行](../../../Controllers/CSGroupChatManager.m#L56)的 `canAttemptBackgroundWork` 和现有群聊能力检查。`canAttemptBackgroundWork` [同时要求全局已开和有当前执行机会](../../../Controllers/CSBackgroundRunManager.m#L81)，与 [AI 自动回复](../../../Controllers/CSAIReplyManager.m#L333) 使用同一语义。成员事件入口和发送前继续按当前账号、群和执行状态复核。
4. 进入后台或失去执行机会时，沿用[连续性快照](../../../Controllers/CSGroupChatManager.m#L142)；[回前台](../../../Controllers/CSGroupChatManager.m#L132)重新请求已选群名单。后台关闭时只走原有的前台补齐路径。退群本群发送、两套退群文案、`@备注`、`@微信ID` 和踢人判定的业务代码保持原样。

[设置页](../../../Controllers/CSGroupChatSettingsViewController.m#L386)现在只有「入群欢迎」「退群监控」「自动添加通讯录」「批量退群」四段。后台说明移到退群监控页脚，仍说明适用功能、锁屏与连接限制、耗电和回前台补齐；原本群文案帮助也保留。检查了 0–3 段的页脚、退群监控第 5 行的可编辑条件，以及批量退群的选择、执行与状态入口。

## 旧配置和备份

- Store 默认值中已无旧键；[校验](../../../Controllers/CSGroupChatStore.m#L60)只允许这一历史键作为例外，不读取或校验其值。账号、schema、群名单、其它键和文案的校验继续生效。
- [Manager 加载](../../../Controllers/CSGroupChatManager.m#L186)时把遗留键从运行配置移除，[日常设置保存](../../../Controllers/CSGroupChatManager.m#L196)也不会将它写回。首次读取不会改写账号文件；下次正常保存时随原子写入移除旧键，保留其它设置，无需启动迁移或数据库变更。
- 显式恢复历史备份时，底层 Store 保留备份中原来就存在的遗留键，因为现有[恢复事务](../../../Controllers/CSBackupEngine.m#L324)会按完整字典比对写入和回读。提前删键会使老备份恢复失败。该值恢复后仍完全无效，下一次群聊设置保存会移除它。恢复逻辑及原备份都无需修改。

## 回归记录

| 原有脚本 | 结果 |
| --- | --- |
| [群聊 core](group-chat-core.log) | 110 项通过 |
| [群聊 manager](group-chat-manager.log) | 48 项通过 |
| [群聊 runtime](group-chat-runtime.log) | 165 项通过 |
| [群聊 store](group-chat-store.log) | 27 项通过 |
| [群聊 backup](group-chat-backup.log) | 57 项通过 |
| [群聊 mentions](group-chat-mentions.log) | 45 项通过 |
| [群聊 notice](group-chat-notice.log) | 35 项通过 |
| [群聊 quit](group-chat-quit.log) | 12 个场景通过 |
| [后台 runtime](background-run-runtime.log) | 47 项通过 |
| [后台 run](background-run.log) | 现有运行边界、53 项状态记录、161 项任务和音频协作、186 项后台运行检查通过 |

[后台连续性审计](verify-background-continuity.sh)的[日志](background-continuity.log)记录了 116 项夹具断言和设置页源代码检查，覆盖旧键有无、全局开关与后台提交、预算用尽后的补齐、旧备份恢复及页脚索引。[共享后台请求审计](verify-shared-background-demand.sh)的[日志](shared-background-demand.log)记录了 45 项通过，使用两个生产 Manager 和实际 Hook 接线，覆盖共享一次任务、关闭开关时同步撤回（含到期及申请失败）、无已选群及正常保存去掉旧键。

`compact1436` 的 144 条历史基线红灯按要求未重跑、未改动、未豁免，不阻塞本次出包。

## 真机：未验证

配对 iPhone 当前不可用，未在设备安装或切换版本，未访问真实微信账号、聊天数据或数据库。以下项目未验证：

- 微信内实际群聊设置页的视觉布局、各行交互和页脚呈现，以及由插件级页面切换后台运行。
- 微信后台或锁屏时的成员事件实时到达、入群欢迎和退群通知送达、退群本群文案、实际提及显示、踢人识别。
- 锁屏、挂起、断线或后台机会耗尽后的真实行为，回前台差分补齐及去重，后台音频、运行时长和耗电。
- 真机从 2.4-5 覆盖安装后的旧账号配置加载、编辑与备份恢复，以及 Rootful / Rootless 的实际注入。

## 文件和交付

生产文件 [2.4-5 基线](production-baseline.sha256) 与上一版 429 项生产归档一致；[2.4-6 快照](production-final.sha256) 与构建输入一致。[变更清单](changed-files.tsv)列出三个群聊实现文件和 `control` 的前后 SHA-256。仅在本审计目录新增专项脚本。 `Tests/` 可见顶层条目仍是 [307](tests-top-level-baseline.txt)，包含测试文件和夹具目录；递归计算的 324 个文件在[改前](tests-baseline.sha256)和[改后](tests-final.sha256)路径及哈希全部一致，原有测试断言未改。290 个既有包文件的[哈希](historical-packages-before.sha256)均保持一致；未运行 Git 或 `make clean`。

| 产物 | 核验 |
| --- | --- |
| [Rootless deb](../../../packages/2.4-6-group-chat-global-background/com.wechat.improve_2.4-6_iphoneos-arm64.deb) | 2.4-6，`iphoneos-arm64`，包内 `arm64 + arm64e` |
| [Rootful deb](../../../packages/2.4-6-group-chat-global-background/com.wechat.improve_2.4-6_iphoneos-arm.deb) | 2.4-6，`iphoneos-arm`，包内 `arm64 + arm64e` |
| [WeChatImprove.dylib](../../../packages/2.4-6-group-chat-global-background/WeChatImprove.dylib) | `arm64 + arm64e`，与 Rootful 包内文件字节一致 |
| [symbols.zip](../../../packages/2.4-6-group-chat-global-background/symbols.zip) | 两种方案共四份符号，CRC 与 UUID 核对通过 |
| [SHA256SUMS](../../../packages/2.4-6-group-chat-global-background/SHA256SUMS) | 四项校验通过 |

[出包证据](package-verification.txt)记录包内路径、架构、最低 iOS 15.0、符号 UUID 和校验值；构建日志：[Rootful](build-rootful.log)、[Rootless](build-rootless.log)。按限定范围，本次更新的是 Debian 包版本；插件内写死的[关于版本](../../../Headers/CSUserInfoHelper.h#L17)和[历史更新说明](../../../Controllers/CSReleaseNotesViewController.m#L7)仍显示 2.4-5，[备份预览](../../../Controllers/CSBackupPreviewViewController.m#L55)仍有旧开关的说明文案。
