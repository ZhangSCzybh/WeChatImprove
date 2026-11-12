# 在线模式实验：独立原生与设计审阅

审阅范围：root 提出的默认关闭、仅进程内在线模式实验设计；本次读取时 `CSAutomationOnlineExperiment.m` 尚未落盘，因此这是实现前的设计结论，不是最终代码批准。正式 main 和实验源码均未修改；没有编译、执行微信或访问 REA session。仅在本目录写入静态证据及报告。

目标：微信 8.0.80.34 arm64，UUID `7E4A8171-5ACC-3A72-A76A-3ACE52D3D895`，SHA-256 `e484889f7e32adce054e6b19bef373e2d1c3eb6984bc01176bbd40906373f317`。7 个方法从同一二进制重新有界提取，精确范围／ABI／文件哈希见 `target.json`。

## 必须调整的设计点

**仅在 sendBgFgRequestWithOnlineMode: 入口放 TLS epoch/generation 守卫不足。** 原生方法构建事件后用 `performSelectorOnMainThread:withObject:waitUntilDone:NO` 排队；真正取消前一个 BgFg 事件、加入网络事件发生在稍后的 `addBgFg…Event:`。TLS 栈帧退出后，之前已排队的实验 mode1/mode2 仍可到达该方法。

因此必须给**仅实验自身构造的事件对象**附上不可变所有权 token，跨异步边界保留 epoch、实验 generation／提交序号、请求 mode、目标原始服务身份。两个 `addBgFg…Event:` 入口在 original 前识别 token 并重新检查当前状态；过期的 owned 事件直接丢弃，未经标记的原生事件完整保留。**检查必须在 add original 前，不能仅在 EventService.AddEvent 前**，因为 add 的第一项副作用就是 cancel 旧事件。

如果选择在 `NewSyncService` 的 `performSelectorOnMainThread:withObject:waitUntilDone:` 分发边界做 scoped 事件标记，必须只处理当前 TLS owned frame、目标 raw self、两个已验证 add selector 及正确事件对象；保留 original 的 selector、object、wait 参数和异常。不能改 NSObject 全局行为，不能把其他自然调用误认作本次实验请求。最终具体实现仍由 root 审核和夹具证明。

这解决三个已由原生异步边界支持的可达风险：

1. 自发 mode1 排队后用户关闭／配置或后台资源失效，旧 mode1 不能在补偿 mode2 后重新提交。
2. 自发恢复 mode2 排队后微信自然前台 mode1 接管，旧 mode2 不能随后覆盖前台或先取消前台任务。
3. 排队后切换账号、清服务或当前 service 被替换，旧事件不能在新账号的当前上下文下进入原生 cancel/AddEvent。

## 原生请求和取消的真实顺序

| 方法 | 关键地址 | 观察 |
| --- | --- | --- |
| sendBgFgRequestWithOnlineMode: (`0x105461764`, `v20@0:8i16`) | `0x1054617a4–7ac` | isLogin 为 false 可直接返回；返回 void 不是提交成功证据 |
| 同上 | `0x105461818–824` | 读取 `clicfg_bgfg_task_timeout_switch`；决定 longlink 等响应路线或 sendOnly 路线 |
| 同上 | `0x10546195c–968` | 将调用参数写入 BgFgRequest.onlineMode；不只是本地状态赋值 |
| 同上，longlink 路线 | `0x105461990–9bc` | 创建 NetCmdLongLinkEvent，retryCount=0、totalTimeoutMS=10000 |
| 同上，sendOnly 路线 | `0x105461a1c–a30` | 创建 NetCmdSendOnlyEvent，选择 addBgFgSendOnlyEvent: |
| 同上，两路线汇合 | `0x105461a60–a78` | 调 performSelectorOnMainThread:withObject:waitUntilDone:NO。send 方法退出与实际 add 是不同边界 |
| addBgFgLongLinkEvent: (`0x105461c4c`, `v24@0:8@16`) | `0x105461c70–c78` | **先** cancelBgFgEvent |
| 同上 | `0x105461c88–c90` | 取消后才再检查 isLogin |
| 同上 | `0x105461cec–cf4` | 从 currentContext 取 EventService 并 AddEvent |
| 同上 | `0x105461cf8–d00` | 把 AddEvent 返回的事件 ID 存到 `0x11edca8ec` 指示的实例槽 |
| addBgFgSendOnlyEvent: (`0x105461b7c`, `v24@0:8@16`) | `0x105461ba0–ba8` | 同样**先** cancelBgFgEvent |
| 同上 | `0x105461bb8–bc0` | 取消之后再检查 isLogin |
| 同上 | `0x105461c1c–c24` | AddEvent；此方法没有把返回 ID 存入同一取消槽 |
| cancelBgFgEvent (`0x105461d28`, `v16@0:8`) | `0x105461d38–d44` | 只检查该已存 ID，0 时返回 |
| 同上 | `0x105461da0–dc0` | 对 currentContext 的 EventService 调 StopEvent(ID)，然后把槽置 0 |
| onServiceClearData (`0x105461708`) | `0x10546173c–760` | 也通过 waitUntilDone:NO 排队 cancelBgFgEvent，不能等同同步清掉所有已排队 BgFg 提交 |
| onServiceEnterBackground (`0x105461dd4`) | 完整函数 | 以 mode2 调 sendBgFgRequestWithOnlineMode: |
| onServiceEnterForeground (`0x105461de4`) | `0x105461e2c–e40` | 登录成立后以 mode1 调同一方法 |

`cancelBgFgEvent` 只操作已保存的 longlink ID；它不是“撤回全部旧 mode 请求”的总开关。特别是 sendOnly 路线没有该 ID 留存，已经加入或发出的请求无法由这段代码证明可以撤回。不得依赖“后调用必然覆盖服务器状态”作为安全证明，也不要为此再直接操作 StopEvent 或原生事件字段。

本轮静态证据证明了异步排队和取消顺序，但没有实测 `performSelectorOnMainThread` 与 GCD main queue 的跨调度器顺序，不声称所有手机场景必然乱序。即使同一队列保持 FIFO，epoch／generation 失效后才执行已排队 work 仍是必须防守的情况。

## 获取与释放应使用不同资格

mode1 获取资格可以要求：实验开启、有效群拍动配置、当前账号／授权有效、actual background、后台运行提供可执行窗口，并且当前 wrapper 指向预期 raw service。

mode2 释放不能要求上述全部获取条件依旧成立。关闭开关、配置停用、授权失效或后台资源失效恰好是要释放的原因。释放只应在同 epoch／当前账号及 service 可验证、仍实际 background、尚无自然 foreground mode1 接管时尝试；不能因为可执行窗口失效就从资格函数直接返回而忘记释放。

本进程的 lease 状态应表达“实验提交过 mode1，可能需要恢复”，而不是“服务器已确认 mode1”。原生 send 和 add 都是 void，而且都可因登录不可用直接返回；原生 AddEvent 结果也未提供到实验 API 的最终状态。提交失败／能力暂不可用应保留待恢复状态，供后续已授权生命周期／资格事件重新评估。账号 epoch 改变则放弃旧租用，不用新账号发送旧 mode2。

当原生前台 mode1 接管时，应同步使所有尚未执行的 owned 恢复 token 失效，而后清理租用。不能只把布尔 lease 设为 NO 留着有效异步 token。`UIApplicationWillEnterForeground` 可能早于 applicationState 变为 Active，应该有明确 enteringForeground 防线；也可由当前账号自然 mode1 的观察立即使旧 token 失效。

## 事件驱动与去重

不需要定时补拉。生命周期、自动功能配置／账号／授权变化、`CSBackgroundRunStateChangedNotification` 和自然 online mode 调用可作为重审触发。后台管理器现有 `publish:` 会在 work/groupWork/audio/phase/status 改变时发状态通知；source `CSBackgroundRunManager.m:108–120`。

必须区分自然请求和 owned 请求，防止自发 mode1 → hook重审 → 再发 mode1 的循环。相同有效条件及同一次自然mode2观察只允许一次请求；在已排队 owned 请求期间重复通知应合并。generation 应随真实失效或新的请求意图变化，不应每次无变化重审都递增导致自己刚排队的事件被无谓丢弃。

当前 wrapper 仍用于提交 mode 请求；raw service 身份只用于比较和 token 归属。延迟 add 回调不得盲目复用过期 wrapper，更不能跨账号补偿。自然请求的原参数、原调用、返回和异常必须完整保持；过期 owned work 的拒绝不应作用于未经标记的自然请求。

## 最低需要验证的交错

- raw自然 mode2 正常执行，且实验关闭时没有额外 mode1/mode2；私聊专用配置不启用实验获取。
- 获得全部资格后只提交一次 mode1，重复状态通知不形成请求循环。
- send返回但add尚未执行时关闭开关；把 owned mode1 与恢复 mode2 的执行顺序交错，旧 mode1 不进入 add original。
- 同样分别对授权、配置、资源、epoch、raw service身份失效执行上述交错。
- 恢复 mode2 已排队但自然 foreground mode1 先接管；旧 mode2 不取消自然事件。
- sendOnly 与 longlink 两条路线都覆盖 owned token，并验证“拒绝发生在 cancel之前”。
- 自发 send原调用内发生自然调用重入，不能错误借用TLS frame或吞掉自然调用。
- wrapper替换但raw身份相同仍通过当前wrapper；目标raw不同拒绝；过期账号旧wrapper不被调用。
- send/add原调用抛异常，归属token和线程局部frame可靠恢复；自然异常原样透传。
- 释放暂不可用后靠后续事件重试；自然前台接管或账号切换后不再旧恢复。

## 尚未证实

此实验可能改变服务端对该设备在线状态的认知，但静态字段赋值不证明服务端必然因此立即下发群拍动。服务器接受时间、sendOnly在网络层是否严格按序、StopEvent能否阻止已发送数据、iOS锁屏期间执行机会和最终回复延迟均仍需手机验证。交付说明应把该包定位为验证假设的实验，不能把本审阅写成已修复群锁屏拍动。

## 实现审阅（首轮，修订进行中）

随后已读取 `source/Controllers/CSAutomationOnlineExperiment.{h,m}` 及 `source/Tests/AutomationOnlineExperimentTests.m`。本审阅者仍未修改实验源码，也未运行测试或编译；测试执行及夹具补充由 `baseline_validation` 负责。

当前实现已经落实：默认关闭／仅进程状态、版本及 ABI 限定、当前 wrapper 提交／raw 身份比对、owned 事件跨异步 token、add original 前拒绝失效 owned 事件、获取与恢复资格分离、前台意图边界以及 10 分钟单次到期。这些设计能保护账号边界及原生取消入口，不能证明服务端已接受在线模式。

首轮确定的实现问题及处理方向：

1. **自然重入可借用外层 owned TLS。** 外层 owned send 的原调用可同步触发另一个自然 send；若自然分支未临时清空 TLS，嵌套自然事件会被 schedule hook 挂上外层 owned token，稍后因 token 失效被拒绝，原生调用被改变。同 mode 重入还需要 `!token.entered` 才能区分。root 已加入这两项防线；进一步应在调用自然观察逻辑之前就清空 TLS，并在 `finally` 恢复，覆盖观察逻辑的同步通知重入。
2. **重复通知会无谓使有效 pending 失效。** 首轮 `changed:` 无条件 `revision++`；即使配置及执行机会未变化，先前排队的 owned 事件也会被拒绝并重新构建。应仅在账号／生命周期／自然接管／请求意图真正改变时失效；相同有效 pending 期间重复通知应合并。没有 pending 的后续外部状态事件可以允许一次有界重试。单纯删除 revision 递增也不够：wrapper 转发期间撤销资格必须在 raw 构建或 add 副作用前被拒绝。
3. **自然 send 入口重审早于原生异步 add，存在提交次序空洞。** 首轮在自然 send original 前 dispatch 重审，而 native original 随后通过 performSelector 排 add。两个调度机制没有已证明的顺序；owned mode1 可能先 add，迟到的自然 mode2 再 add 后覆盖。建议只给自然事件附加观察 token，绝不阻止／改写自然 add；send 入口先撤销旧 owned 意图，原生 add original 完成后按实际 mode 再接管并重审。自然 add 异常必须原样透传，观察自身失败不得覆盖原异常。没有排出事件的自然 send 可在返回后做一次 fallback 重审。该修正仍只约束已观察到的本地 add 次序，不等于网络或服务端状态确认。

上述重入及自然 add 排序用例已交测试负责人，root 正在修订。此段不是修订后批准结论；最终必须按修订源码再核对一次。

## 修订后复核结论

复核源码 SHA-256：

- `CSAutomationOnlineExperiment.m`：`693e02e694a4c0ab57fa64c2c9e84ff44d5128bd0c99e36232922632a6ed3e85`
- `CSAutomationOnlineExperiment.h`：`2726fb00ec56bbd9b27878aba334b4b6817253d047d5479d8067242704884628`

上述修订已在源码核实，本轮独立静态复核未发现需要继续阻止实验验证的实现问题：

- owned send 先检查 epoch／revision，再一次性 claim token，随后才调用可能重入的资格 getter；同 mode 的嵌套自然 send 不会重复 claim。
- 自然 send 在执行观察前清空 owned TLS，使用独立自然 frame；`finally` 恢复两个 TLS。自然 original 的调用参数和异常保持原样。
- 自然事件只加观察关联，add original 始终执行且不受实验 epoch／开关守卫阻止；观察逻辑位于 original 后的 `finally` 内并隔离自身异常。自然 send 入口只使 owned 意图失效，不抢先排重审；没有排出事件时才在 send 退出时排 fallback，正常自然 add 完成后重审。
- 因此先前“owned mode1 add 后再发生自然 mode2 add”的本地排序空洞有完成边界重新评估；它不依赖两个主线程调度机制的 FIFO 假设。
- 重复同意图通知保留 pending；实际意图变化、生命周期、自然接管和账号边界仍令旧 token 失效。raw send 及异步 add 前均重新检查资格，拒绝 owned 事件仍发生在 native cancel 之前。
- 当前账号或 raw service 明确改变会关闭并清理实验；相同 raw 的 wrapper 替换继续使用当前 wrapper。新 enable 与后台边界清除旧 naturalMode 证据。
- mode2 恢复不要求 mode1 获取资格继续成立；仍要求当前账号／服务、后台边界以及未被自然前台接管。默认关闭、内存状态及单次 600 秒到期保持不变。

这是对指定源码和已归档原生方法的**只读实现审阅**。本审阅者没有执行测试／编译／手机实测；测试结果应单独引用测试负责人的实际输出。复核结论仅支持制作受限实验包验证假设，**不证明服务器已接受模式、BgFg 网络请求的最终顺序、群拍动已立即下发，也不证明锁屏回复已达秒发**。最终手机效果必须由实验开关前后、相同场景的新日志及实际计时确认。

最终小幅修订复核：测试发现 wrapper forwarding 期间 raw service 被静默替换、未发布通知时，旧异步 add 虽会被拦截，旧 send original 仍可能先构建一次。现 raw send 的资格检查后重新调用 `currentReceiver`，核对其 raw 身份等于当前接收者，并最终复核 background／revision／epoch；明确的 raw 替换会关闭实验并在旧 send original 前返回。此次只核查该改动及相关声明，未扩大审阅或执行测试；未发现该补丁引入新的阻塞问题。上列 `.m` 哈希已更新，`.h` 哈希未变。
