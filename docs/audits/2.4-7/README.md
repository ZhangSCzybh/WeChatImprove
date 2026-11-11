# WeChatImprove 2.4-7：群聊后台处理专项审计

本版基于 2.4-6。微信进程在后台仍能执行主队列、原生层能提供完整成员名单时，已选群会处理入群欢迎、退群本地提示，以及用户已开启的本群退群通知。插件级「后台运行」只决定本插件是否申请保活资源。离线夹具验证到微信原生接口调用的录制边界；本版未在 iPhone 安装。

## 原因：两条发送链的差异

- **2.4-6 群聊**（以下为旧版行号）：`CSGroupChatManager.m:54–57` 同时要求 `canAttemptBackgroundWork` 和 `backgroundCanWork()`；`Hooks/GroupChatHooks.xm:12–15` 把后者接到 `canAttemptGroupChatBackgroundWork`，并监听保活能力变化。[全局管理器第 81–82 行](../../../Controllers/CSBackgroundRunManager.m#L81)分别要求插件开关开启和存在群聊保活请求。即便第三方插件已让微信继续运行，开关关闭时两个检查仍然失败。旧 Manager 第 59–60、66–68、91–106 行因此拦住群处理并关闭 ingress；[Runtime 第 18–23、90–95、163–167 行](../../../Controllers/CSGroupChatRuntime.m#L18)会在原生入口及主队列交接时丢弃这些回调，发送授权又经旧 Manager 第 163–164 行的 `canRunInRoom:`。
- **定时任务**：[第 28 行](../../../Controllers/CSScheduledTaskManager.m#L28)监听激活等通知，[第 66–68 行](../../../Controllers/CSScheduledTaskManager.m#L66)以主队列 `dispatch_source` 到期唤醒；[第 86–101 行](../../../Controllers/CSScheduledTaskManager.m#L86)核对账号 epoch、授权、目标和任务快照，[第 107–123 行](../../../Controllers/CSScheduledTaskManager.m#L107)向原生发送适配器提交。没有保活管理器依赖或前台状态检查，主队列能执行就可以处理已到期且仍有效的任务。该文件未改。

## 2.4-7 判定链

| 阶段 | 代码与行为 |
| --- | --- |
| 进入后台、打开 ingress | [Manager 第 54–71 行](../../../Controllers/CSGroupChatManager.m#L54)：已收到进入后台通知（或启动时已在后台）、群聊就绪、未保存中、欢迎或监控至少有一个已选群，即有执行机会。ingress 还检查当前账号、epoch、备份就绪与账号挂起状态。账号和设置未变时，进入后台不重置入口 token。[第 169–175 行](../../../Controllers/CSGroupChatManager.m#L169)补查已选群。系统挂起时主队列不会执行，因此这段判断不需要猜测是否被第三方保活。 |
| 原生事件进入业务 | [Runtime 第 66–85 行](../../../Controllers/CSGroupChatRuntime.m#L66)核对完整名单、原生缓存版本和账号，再交给 Manager。[Manager 第 334、348、355、382–390 行](../../../Controllers/CSGroupChatManager.m#L334)核对账号、群选择和名单快照；成功的原生踢人回执依旧只提供原因证据。 |
| 允许提交发送 | [Manager 第 194–201 行](../../../Controllers/CSGroupChatManager.m#L194)校验账号 epoch、配置版本及会话，`canRunInRoom:` 以已选群为准。[退群第 431、455–470 行](../../../Controllers/CSGroupChatManager.m#L454)校验授权与本账号群关系并消费独立的本地、本群标记；[欢迎第 508–538 行](../../../Controllers/CSGroupChatManager.m#L508)先认领待办 ID，提交时再查授权、有效期及相关成员仍在群。两条路径都没有应用必须处于前台的限制。使用 [CSMessageSendAdapter 第 84–106 行](../../../Controllers/CSMessageSendAdapter.m#L84)准备消息，最终在[第 45–52 行](../../../Controllers/CSMessageSendAdapter.m#L45)调用微信 `AddMsg:MsgWrap:`。 |
| 只决定是否申请保活 | [Manager 第 76–88 行](../../../Controllers/CSGroupChatManager.m#L76)读取全局开关并登记或撤回需求，[Hook 第 12 行](../../../Hooks/GroupChatHooks.xm#L12)只接 `setGroupChatBackgroundRequested:`。开关关闭不请求任务或音频；开启后由原有全局管理器按预算和音频条件接力。全局能力通知不会开关群聊 ingress 或授权发送。 |
| 有待办才重试 | [Manager 第 94–136 行](../../../Controllers/CSGroupChatManager.m#L94)用一个主队列定时源，每 **5 秒**检查一次，允许 **0.5 秒**合并余量；5 秒沿用名单请求冷却，避免空闲轮询和过密查询。普通事件和欢迎到期仍直接驱动处理。名单请求被拒或已接受却没有有效回包时，允许一次跟进；处理完成立即停表。[第 152–166 行](../../../Controllers/CSGroupChatManager.m#L152)离开后台即停表，账号或配置切换也会清理。欢迎保持原有截止时间；待提交的退群通知超过 120 秒丢弃。只重试明确未调用微信的提交，本地插入不重放，已交给微信或结果不明确的发送不自动重发。 |
| 回前台补齐 | [Manager 第 155–185 行](../../../Controllers/CSGroupChatManager.m#L155)保留最高已处理名单版本，切换 ingress token，重新请求完整名单；[名单差分第 17–33 行](../../../Controllers/CSGroupChatEventPolicy.m#L17)拒绝旧版本或同版本冲突，相同版本、相同成员集不产生新事件。[Manager 第 474–488 行](../../../Controllers/CSGroupChatManager.m#L474)只恢复未过期且成员关系仍匹配的原待发欢迎。后台已提交的欢迎和退群通知不重复。 |

继续沿用 2.4-4/2.4-5 的本群发送选择、两套退群文案、`@备注`、`@微信ID` 与踢人判定。恢复预览去掉已删除开关的名称，插件关于页、更新说明与 Debian 包版本均为 2.4-7。群聊设置页 [第 413 行](../../../Controllers/CSGroupChatSettingsViewController.m#L413)仍有 2.4-6 的页脚描述，未纳入本次指定的三处文案修改；它不是运行时门禁。

## 离线证据

从项目根目录运行 `bash docs/audits/2.4-7/verify-live-background.sh`。 [脚本](verify-live-background.sh)编译生产群聊 Manager、Runtime、名单与配置实现、实际发送适配器、定时任务 Manager/Store、后台 Manager，并接上生产 Hook 的接线。各场景在独立宿主进程和临时目录运行，使用现有假运行时、后台资源和可录制原生服务，不连网。 [完整日志](live-background.log)共 **133 条断言通过**。

| 场景 | 记录到的证据 |
| --- | --- |
| A：关闭，微信在后台执行 | 44 条。模拟加入和成功移出；名单首次获准却不回包，主队列 tick 仅补查一次。暂时阻止准备发送后恢复，欢迎及本群退群通知分别经实际适配器调用一次录制的 `AddMsg:MsgWrap:`，状态均为 `Background`。欢迎含真实原生 at-list 参数，本地提示调用一次。待办清空停表，任务租约和音频申请为零。 |
| A 的定时任务对照 | 同一进程、同为关闭和 `Background`。实际定时任务计时器到期，经适配器调用录制的 `AddMsg:MsgWrap:`，任务历史记为 `submitted`。 |
| B：后台后立刻回前台 | 21 条：退群通知在后台提交一次，延迟欢迎在前台恢复一次，重放名单无重复。另有 B-queued 25 条：原生回调已排队、主队列还没消费就回前台，旧 token 被淘汰，仅由新名单差分各提交一次。 |
| C：开启 | 22 条：群聊在 `Background` 各提交一次，记录到一次租约申请；模拟原生预算偏低时音频启动一次。回前台释放任务、停止音频。 |
| D：模拟无执行机会 | 21 条：后台期间仅改变录制侧的服务端名单，不给微信进程投递成员事件，也不让主队列消费后台工作；无后台提交。回前台后才取得新完整名单，各提交一次，离群原因为「未确认」，无实时踢人证据。 |

## 指定回归

| 脚本 | 结果 |
| --- | --- |
| [group-chat-core](group-chat-core.log) | 110 项通过 |
| [group-chat-manager](group-chat-manager.log) | **失败；停止点之后未覆盖。** [既有断言第 289 行](../../../Tests/GroupChatManagerTests.m#L289)要求进入后台立即关闭 ingress 并清空待发欢迎，和 2.4-7 的要求冲突；保留原断言，未改脚本或把红灯记为通过。新的后台入口、回前台去重与恢复由上面的专项夹具验证。 |
| [group-chat-runtime](group-chat-runtime.log) | 165 项通过 |
| [group-chat-store](group-chat-store.log) | 27 项通过 |
| [group-chat-backup](group-chat-backup.log) | 57 项通过 |
| [group-chat-mentions](group-chat-mentions.log) | 45 项通过 |
| [group-chat-notice](group-chat-notice.log) | 35 项通过 |
| [group-chat-quit](group-chat-quit.log) | 12 个场景通过 |
| [background-run](background-run.log) | 53 项状态记录、161 项租约和音频协作、186 项运行检查通过 |
| [background-run-runtime](background-run-runtime.log) | 47 项通过 |

`compact1436` 的 144 条历史红灯按要求未重跑、未修、未豁免，不阻塞出包。

## 补齐边界与真机未验证项

- 断线、系统挂起或主队列停顿期间，没有可执行的实时路径。回前台只比较同账号、同配置会话中仍保留的可信基线和恢复后的完整名单。原生拿不到完整名单时，无法补齐；在两次有效名单之间先入群又退群且最终名单不变，也无法从差分恢复。没有成功移出回执时，只能记录离群原因未确认。
- 切账号、账号 epoch 失效、冷启动或微信被杀后，会清除旧账号的内存待办或重建基线，不能补发上一会话的缺口。诊断名单不作为冷启动补发依据。已经过期、已经交给微信或交接结果不明确的消息不回放。
- **真机未验证**：其他插件如何保活；微信真正被系统冻结、锁屏、断线或杀进程时的事件到达和恢复行为；真实群聊送达、提醒显示、音频/续航；Rootful/Rootless 安装注入。录制接口接到调用仅表示走到提交点。此次交付是本地 iOS 插件包，未操作实际微信账号、聊天数据或数据库；无服务 URL 或端口切换。

## 源文件快照与产物

- [生产基线](production-baseline.sha256)与 2.4-6 的 429 项最终清单相同；[生产最终快照](production-final.sha256)和[冻结构建输入](package-build-inputs.sha256)逐字节一致。[变更清单](changed-files.tsv)记录 7 个生产文件的前后 SHA-256。
- `Tests/` 可见顶层条目保持 307（[改前](tests-top-level-baseline.txt)、[改后](tests-top-level-final.txt)）；递归计入隐藏文件共 324 个文件，路径和哈希[改前](tests-baseline.sha256)、[改后](tests-final.sha256)相同。所有新增夹具均在此审计目录。
- 历史包 295 个文件的[改前哈希](historical-packages-before.sha256)与[改后哈希](historical-packages-after.sha256)相同；没有使用 Git 或 `make clean`。

| 产物 | 核验 |
| --- | --- |
| [Rootless deb](../../../packages/2.4-7-group-chat-background-opportunity/com.wechat.improve_2.4-7_iphoneos-arm64.deb) | 2.4-7，`iphoneos-arm64`，包内双架构 |
| [Rootful deb](../../../packages/2.4-7-group-chat-background-opportunity/com.wechat.improve_2.4-7_iphoneos-arm.deb) | 2.4-7，`iphoneos-arm`，包内双架构 |
| [独立 dylib](../../../packages/2.4-7-group-chat-background-opportunity/WeChatImprove.dylib) | `arm64 + arm64e`，与 Rootful 包内 dylib 字节一致 |
| [symbols.zip](../../../packages/2.4-7-group-chat-background-opportunity/symbols.zip) | 四份 dSYM 的 UUID 均与对应切片一致，ZIP CRC 通过 |
| [SHA256SUMS](../../../packages/2.4-7-group-chat-background-opportunity/SHA256SUMS) | 四项均通过 |

[出包验证](package-verification.txt)列出安装路径、最低 iOS 15.0、架构、UUID 和校验值。[Rootful](build-rootful.log)和 [Rootless](build-rootless.log)均从本工作目录冻结的生产输入独立构建。
