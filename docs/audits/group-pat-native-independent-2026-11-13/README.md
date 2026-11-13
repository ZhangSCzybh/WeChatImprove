# 群拍动后台即时触发：当前源码与原生 IPA 的独立分析

分析日期：2026-11-13。当前源码为正式 `2.5-11`，HEAD `00634e43`。本报告的判断只采用本轮重新阅读的生效源码，以及新解压微信 IPA 的元数据和 ARM64 机器码；项目历史分析、实验包结论和旧补丁不作为证据。

用户已说明：本项目后台运行与其他插件保活二选一开启，群聊功能、定时任务、红包和自动收款均能在后台正常工作。因此本轮以“微信在相关后台时段具备执行及发送机会”为分析前提，重点检查群拍动的消息交付与同步分流。

## 结论与证据边界

1. 当前业务代码没有为群拍设置额外的 10 秒发送等待。10 秒是 `NewSyncService.BackGroundFetchToSync` 的主动请求间隔，群聊、私聊共用。已入站拍动按用户设置 delay 处理。
2. 当前插件接入了原始 `10002`、聚合 `49/62`、统一同步批次和原生 `PatWrap`，不是只依赖聊天界面新增展示消息。
3. 新 IPA 中，完整拍动进入已检查的接收方法后，没有发现“群聊在后台或锁屏必须等前台”的直接判断。群私差异主要是会话归属及本地展示消息合并。
4. 新 IPA 确实存在不同的新消息交付方式：仅通知需要同步、携带完整同步响应、普通 APNS 通知。普通 APNS 的特定分支只在 Active 时额外调用 `ApnsNotifySync`；不能把该条件推广到所有 push。
5. 进后台仍会改变微信自己的在线上报与网络前后台信号。保活模块不覆盖这层语义。该事实本身不能证明服务器对本次群拍使用了什么下发策略。
6. 结合“群回拍和文字回复共同迟到、私聊正常、其他后台任务正常”的现象，首先应定位完整群拍动到达业务入口之前的阶段。同时保留群资料门禁及解析拒绝这两项可验证的次级候选。

**静态证据尚未把用户手机上的那一次群拍动绑定到具体网络命令或 APNS 分支，不能据此宣称找到了唯一根因，或保证改一个 Hook 就能即时回复。** 本报告已经确定应观察的具体边界和可实施方向；最后的因果确认需要同一次群拍动的真机时序。

## 项目框架与开发约定

项目是 Theos + Objective-C / Logos 的 iOS 微信进程内插件。`Makefile` 自动编译 `Hooks/*.xm` 和 `Controllers/*.m`，目标包含 arm64 / arm64e、iOS 15+。Hooks 负责观察微信原生入口；Controllers 中分开实现事件归一化、配置与持久去重、任务调度、原生接口适配和设置界面。

自动功能的生效链为：

```text
微信原生消息 / 同步批次 / 拍动回调
  → AutomationHooks
  → CSAutomationEventAdapter：身份、路由、时间、XML 校验
  → CSAutomationStore：配置、名单、规则、持久去重
  → CSAutomationManager：账号代次、认领、用户延迟、重试、撤回
  → 原生文字发送适配 / CSAutomationNativeAdapter → SendPatMgr
```

沿用当前习惯：原生调用参数和异常透传、核对真实 ABI、按账号代次拒绝过期工作、严格绑定群和拍动人、持久去重后才提交动作、共享同步预算。修改接收链不应绕开这些规则。发布时需要同步 `control`、`Headers/CSUserInfoHelper.h`、内置版本说明；历史包应保留，不能使用会删除 `packages` 的 `make clean`。

## 当前自动功能：10 秒发生在哪里

| 位置 | 当前行为 | 含义 |
| --- | --- | --- |
| `CSAutomationManager.m:21`、`:144–235` | 拍动后台需求有效时，以共享预算调用 `BackGroundFetchToSync`；最短间隔 10 秒 | 用于获取尚未入站的消息，不是对群拍回复强制延迟 |
| 同文件 `:373–380` | 群、私聊都经 `receivePat → CSAutomationEventFromPat → receiveEvent` | 归一化后共用业务链 |
| 同文件 `:431`、`:467–474` | 到期时间为 arrivalElapsed + 用户 delay；认领完成后处理任务 | delay=0 时不再等 10 秒计时器 |
| 同文件 `:103–110`、`:438–440` | 检查实际账号、授权和存储能力 | 不用全局 protected-data 标志一律阻止锁屏处理 |
| 同文件 `:322–328`、`:346–348` | 群资料可用、仍为成员、非退群；暂不可用按 5 秒复查 | 这是群额外条件，需区分已入站后暂停和根本未入站 |

`AutomationHooks.xm:151`、`:166`、`:177`、`:277`、`:300` 分别接入 onNewSyncAddMessage、onNewSyncNotAddDBMessage、会话批次、统一 BatchAddMsg 和 addPatWrap。统一批次会在原生转换前快照原始 `10002` / `49+62`，原生接受后再发布。全部这些入口都以微信已经取得并解码消息为前提。

## 为什么其他后台功能正常仍可能只有群拍迟到

| 功能 | 当前代码中的触发来源 | 对本问题的证据意义 |
| --- | --- | --- |
| 定时任务 | `CSScheduledTaskManager.m:59–68`、`:107–123`：本地 nextRun、主队列 dispatch_source、到期发送 | 是后台主队列和发送服务可工作的正证；不需要新消息先入站 |
| 红包 / 自动收款 | `ReceiveTransferHooks.xm:16–26`、`CSPaymentAutomation.m:493–503`：AddMsg / AsyncOnAddMsg，支付类 type49 | 与部分自动入口重叠，但不证明原始拍动 type10002 同时交付 |
| 群欢迎 / 退群 | `CSGroupChatRuntime.m:87–97`、`:124–169`：成员详情响应、联系人变化、移除成员响应及系统消息提示 | 成员和联系人事件能独立触发；不是对 pat XML 交付的确认 |
| 群拍动 | 原始 type10002，或之后聚合的 type49 / innerType62 | 应专门定位该消息分流，不能仅根据其他类型消息推定其及时性 |

群欢迎也检查群可用、成员和退群状态（`CSGroupChatManager.m:524–531`）。若同一群的欢迎能实时发送，长期群资料不可用这一解释会进一步减弱。支付和定时任务的资格检查较轻，不能完全替代自动群拍的资格验证。

## 新 IPA：拍动接收处理没有已见群后台屏障

目标为 `com.tencent.xin_8.0.80.ipa`，Info.plist 构建 `8.0.80.34`，UUID `7E4A8171-5ACC-3A72-A76A-3ACE52D3D895`，ARM64、cryptid=0。完整身份与 SHA-256 见 [target.json](target.json)。

| 原生方法 | IMP | 观察 |
| --- | --- | --- |
| `CMessageMgr.onNewSyncNotAddDBMessage:` | `0x104df1718` | type10002 交给 HandleSvrCmd；没有已见群或 App 状态判断 |
| `CMessageMgr.HandleSvrCmd:MsgWrap:` | `0x104def554` | 解析 sysmsg type，经扩展分发 OnGetNewXmlMsg |
| `SendPatMgr.OnGetNewXmlMsg:Type:MsgWrap:` | `0x105a9bc80` | 校验 pat、撤回/重复、身份；群私分支用于归一化会话 |
| `SendPatMgr.addPatWrap:toChat:newXMLMessageWrap:index:` | `0x105a9a3e8` | 群可合并已有展示消息，私聊倾向新建；没有已见 10 秒等待或等前台条件 |

群展示消息合并能解释“只监听新展示消息”的实现为什么漏事件；当前版本已有原始 XML 和批次入口，不能把合并机制直接当成本次遗漏的最终解释。

另查出原生 `sendPat:` 会进入 `delaySendPat:`，实验项 `clicfg_pat_send_delay_interval` 默认值 5 秒，suffix 回调可能提前发送。这是群私共享的发送机制，不能解释群拍文字回复也一起迟到，亦不应与本插件 10 秒补拉混淆。

详细接收证据和汇编见 [native/receiver/README.md](native/receiver/README.md)。新发现的 cmd603 → BypChatRoomMgr 继续追踪后证实处理 BypChatRoomMemberData / members，属于成员资料同步，已排除为缺失的拍动入口。

## 新 IPA：新消息通知不等于完整拍动消息

真正 unsolicited push 的 `stn_callback.mm::OnPush` 在 `0x10af23c1c` 按命令分发：

| 原生入口 | 新确认的行为 | 对即时触发的影响 |
| --- | --- | --- |
| 长连接 cmd24 / cmd5 | 标记 needSync(scene1)，之后由 CMainControll 的 TimerCheckEvent 调 checkNeedSync → NotifyToSync | 到通知时未必已有完整消息；不是直接产生 PatWrap |
| 长连接 cmd122 / cmd2000 | payload 经 ThreadQueue 分别进入 HandleNewSyncPush / HandleNewSyncPush64，解析 NewSyncResponse | 若含完整拍动且原生接受，就可以沿现有接收链处理 |
| 普通 APNS 的 generic 分支 | `NotificationActionsMgr.handleReceiveRemoteNotification:requestID:` 的 `0x105491138–0x1054911ac` 仅 Active 调 ApnsNotifySync；后台继续处理通知但跳过这次同步调用 | 明确存在“通知已处理但这条分支未触发同步”的代码机制；尚未证实真实群拍使用此分支 |

cmd24 的 `CUtility.NeedNewSync:` 实际判定 `(selector & 7) != 0`。原生 TimerCheckEvent 被安排为重复 **0.05 秒 NSTimer**；所查消费路径没有直接 App 状态过滤。0.05 秒只是安排值，不能直接等同后台实际执行间隔，也不能未经观测就认定该 timer 停了。

`InternalCreateSync:`（`0x105462488`）另有暂停、初始化、已有同步 event 的判断。scene12 在已有 event 时直接返回；通知类 scene 则可保留 needSync 标记。`__handleNewSyncResponse:flag:beginTime:`（`0x105464948`）也会因 syncOpError、syncPause、syncOperating 拒绝本次完整 push。当前观察不能把这些状态自动等同于后台状态。

完整上游证据见 [native/notify/confirmed-notify-chain.md](native/notify/confirmed-notify-chain.md)，同步状态分支保存在 [native/sync](native/sync/)。

## 在线上报与网络活动是单独一层

`NewSyncService.onServiceEnterBackground`（`0x105461dd4`）调用 `sendBgFgRequestWithOnlineMode:2`；前台方法（`0x105461de4`）登录后传 1。发送方法（`0x105461764`）确实构造 BgFgRequest，写入 onlineMode 并经网络事件提交，区别不是日志文案。

AppDelegate 进入后台还在 `0x104e857a4`、`0x104e857fc` 向 default context 的两路 C++ 信号传 false；回前台的对应调用传 true。沿已检查的一个信号可追到 mmstn_logic 的注册及 mm_core 的 OnForeground 处理。它们与 UIKit 的后台任务或静音音频不是同一状态。

当前保活实现管理的是 UIKit 有限任务及 AVAudioSession / AVAudioPlayer；`Hooks/BackgroundRun.xm` 没有覆盖上述在线与网络信号。这个区别说明“能运行”与“微信仍按什么网络状态接收消息”应分开观察；**尚不足以证明把 onlineMode 改成 1 就一定使群拍实时下发**，也不能证明两路信号中的任何一个是当前设备的根因。

生命周期与 C++ 信号证据见 [native/network/README.md](native/network/README.md)。

## 达到目标的改造方向

目标应定义为：在已经具备后台执行和发送机会、用户 delay=0 的条件下，由微信原生到达事件驱动群拍动处理，不依赖插件固定 10 秒轮询，也不通过打开微信触发同步。微信正常收包 / 同步仍是这条链路的一部分。

建议先按同一次拍动核对四个时刻：

1. 原生网络通知 / APNS 处理入口，记录消息命令与接收时间。
2. NewSyncService 是否收到完整 response、是否接受，或哪项原生状态导致延期。
3. BatchAddMsg 的原始10002 / PatWrap 到达，以及插件 receivePat 的时间。
4. 两个自动任务认领、提交及实际原生发送回调时间。

只需要结构、命令和单调时钟；不要导出正文、群号和成员身份。用同一后台时段的私聊作对照，可以区分消息根本没到、到通知但未同步、完整消息被拒绝、插件过滤/门禁和原生发送等待。

依结果分三种有依据的修改，不能把它们混成已验证修复：

- **通知已及时到主进程**：优先做原生通知驱动的同步衔接，在当前账号/服务上下文中尊重暂停、忙碌和合并状态，空闲便提交，忙碌则在原生完成/恢复事件后重评估；不依赖固定 10 秒轮询。复用完整原生消息进入现有业务链，不根据通知文案伪造拍动人或直接发送。若原生50ms链确实及时工作，此处没有必要重复请求。
- **后台期间原生通知本身未及时到达**：需要继续核验在线上报与 default transport 的后台活动语义，才能讨论保持原生实时接收状态。该层服务于整个微信连接，影响面不是单个群；改造需要精确版本/ABI/调用来源校验、账号边界、自然前台接管和状态恢复。仅新增 SendPatMgr Hook 无法解决这种情况。
- **完整原始10002 / PatWrap 已及时到达，但任务或提交迟到**：核对 XML / 会话路由拒绝、群资料与成员资格、实际存储和持久认领阶段，针对已证实的阻点修改。此时应沿当前业务链定位，不因本报告发现了网络状态分流就直接改同步或 transport。

验收应在隔离的验证配置中关闭插件定时补拉，保持用户原本的某一种保活方式和同一账号/数据，用户 delay=0；接收端持续后台/锁屏，由发送端连续观察群与私聊，包含刚进后台和停留一段时间后的事件。只有确认群拍经到达事件触发，而不是轮询或回前台后补做，才满足本次需求。主机夹具和静态汇编均不能代替这项验收。

## 本轮交付范围

只新增本独立分析目录与可复核的机器码证据；生产源码保持正式 `2.5-11`，没有打包、安装、切换账号/服务或操作用户数据库。本轮没有通过重新运行已有主机测试来声称修复了真实后台消息交付。
