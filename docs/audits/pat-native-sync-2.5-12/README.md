# 2.5-12 后台拍动事件同步

## 问题与目标

2.5-11 的用户反馈：群聊后台／锁屏，接收端聊天记录已显示拍一拍后，文字回复仍晚约 6–12 秒；前台与私聊明显更快。diag.2 的三次记录中，最早插件原始快照到文字成功回调约为 241／450／385 ms，两个后台事件分别在插件补拉之后约 126／287 ms 入站。这说明现有插件入站后的固定延迟不足以解释用户观察；成功回调也不代表远端已显示。

本版基于正式 2.5-11 提交 `39930b3d31e54d8719eca1494e13f1f801f10b5b`，接入更早的原生同步需求，在微信有执行机会时立即推动同步。静态证据支持消除已确认的定时消费环节，尚未证明每次手机上的可见延迟全部来自该环节。

## 原生证据

目标为本机解密微信 8.0.80.34 arm64 二进制，SHA-256 `e484889f7e32adce054e6b19bef373e2d1c3eb6984bc01176bbd40906373f317`，UUID `7E4A8171-5ACC-3A72-A76A-3ACE52D3D895`，image base `0x100000000`。使用 REA 绑定目标，并用相同 SHA 的 Objective-C 元数据、LC_FUNCTION_STARTS 边界及 `llvm-objdump` 定向反汇编交叉核对，未启动或注入手机进程。原始证据存于本机归档 `WeChatImprove-local-archive/audits/2.5-12/native-evidence/`，仓库不包含微信二进制或用户聊天日志。

| 位置 | 已观察到的静态行为 | 本版处理 |
| --- | --- | --- |
| `CMainControll NotifyFromEvent:Message:MessageInfo:` `0x104d17130` | message 4／63 分支调用 `setNeedSyncWithScene:`，该分支不直接发起同步 | 在原生设置需求后唤醒 |
| `TimerCheckEvent` `0x104d15b7c`；`checkNeedSync` `0x10546359c` | 定时检查 need 后调用 `NotifyToSync` | 新路径无需等待该检查 |
| `setNeedSyncWithScene:` `0x105463448`，ABI `v20@0:8i16` | 原生确认账号后设置场景与 need；参数是 signed int | 原方法先运行，保留参数与异常，再合并主队列唤醒 |
| `NotifyToSync` `0x105462d98`，ABI `B16@0:8` | 读取原生场景并调用 `InternalCreateSync:` | 使用该 BOOL 原生入口，保持原生场景与请求保护 |
| `InternalCreateSync:` `0x105462488` | 检查暂停、初始化和现有 event；真正创建前消费 need | 插件不改写同步状态，不伪造前台 |
| `HandleSyncResp:handleResult:` `0x105463a48` | 成功续页可直接置 need=1、scene=6；gettingData 仍可为真 | 完成后消费真实续页需求，不能把 gettingData 当终止条件 |
| `makeSyncResume` `0x105466d50`；`resetGettingData` `0x105461650` | 恢复暂停或结束数据获取 | 以实际恢复事件唤醒保留的需求 |

`m_lastSyncFinishCallingExtension` 为真并不表示忙碌，原生创建同步也不以它为门槛。本版不拿这个标志或 `m_isGettingData` 阻挡合法续页。旧 `m_bSyncOpError` 也不能阻止新的 full sync：普通响应经过 `NewSyncEventHandler.OnProtocolResponse`、`markSyncOperating`、`g_HandleSyncResponse`，成功时 `HandleSyncResp` 覆盖旧 error；push 专用 `__handleNewSyncResponse` 的 error 拒绝分支不适用于新 full sync 的请求门槛。

进一步核对 `creatPBNewSyncEvent` → `EventService CreateProtobufEvent:Flag:`（flag=5）→ `CMultiEventWrap.AddEvent`。旧实现向 operation queue 调 `addOperation:`（`0x1051430b0`）；新实现已启动时直接 `TryStartEvent:`（`0x105144130`）。`EventService TryStartEvents` 实际调用 `ClearStopEvent` 清理结束事件，不是启动请求的第二个定时门槛。该结论仍为静态控制流证据，不等于已观察到用户手机的实际网络发包。

## 实现边界

`CSAutomationNativeSync` 独立负责原生事件合并与状态读取。安装限定微信短版本 8.0.80，并核验全部使用的方法和 ivar ABI；原生方法正常返回之后才增加插件行为，异常语义保持。每个服务与账号 epoch 绑定，突发通知合并为一次主队列任务。`CSAutomationManager` 在请求前复核后台状态、有效拍动配置、账号／授权及当前服务身份。

有真实 need 且原生状态允许时调用 `NotifyToSync`；正在同步、处理或暂停时保留需求。完成与恢复事件再检查，不使用轮询、短间隔重试或忙等。调用内嵌的 setter／reset 不再生成自己的循环；失败或异常后的同一 ticket 不自动重试，新外部通知或恢复事件可重新提供机会。

已安装新入口的宿主停用拍动 10 秒计时器，事件触发也不走 `CSBackgroundSyncBudget` 的 10／45 秒限流。其他宿主继续使用既有兼容同步；AI 自身的兜底预算及完整同步观察器保持原策略。原始 10002／49-62 入站快照、严格身份解析、持久去重、回拍／回复独立动作、用户延迟与撤回流程保持。

## 验证与限制

专项使用真实生产 runtime hook、动态原生 ABI 类和录制服务，验证即时唤醒、合并、忙碌／暂停恢复、续页、失败无循环、异线程、epoch 切换、参数／异常与拒装边界。Manager 集成另验证当前服务／账号／配置守卫、新入口无拍动计时器、无预算等待，以及零延迟拍动各产生一次持久认领后的回拍和文字任务。原有自动功能、拍动入站、AI 与兼容预算回归一并验证。

最终测试和包校验见 [发布记录](../../../packages/2.5-12-pat-native-sync/README.md)。主机夹具不连接微信服务器，不证明手机已经秒回。系统挂起／退出、通知未交付、网络或原生状态不允许时，插件无法保证即时处理。需要在用户原有 Rootless、原账号及原配置上确认群后台／锁屏效果；本轮没有修改真实账号、配置或数据库，也没有改动保活策略。
