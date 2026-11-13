# 当前 2.5-11 后台运行模块依赖核查

只读核查当前 Controllers / Hooks / Makefile / 备份注册表，不使用历史分析。未改生产源码，未运行服务或操作用户数据。此文不包含 WCRefine 二进制结论，供主报告与其逆向证据合并。

## 当前实现与对外契约

- `Controllers/CSBackgroundRunManager.m:7–10`：suite `com.cyansmoke.wechattweak`，开关 `BackgroundRunEnabled`，配置通知 `BackgroundRunStatusChanged`，能力/状态通知 `CSBackgroundRunStateChanged`。
- `CSBackgroundRunManager.h:15–42`：保留 start/reloadSettings/setGroupChatBackgroundRequested、KVO 可观察 enabled、backgroundAudioActive、canAttemptBackgroundWork、canAttemptGroupChatBackgroundWork、supportsBackgroundAudio、statusText 和最近一次后台记录等接口，能显著缩小替换范围。
- `CSBackgroundRunManager.m:75–82`：资源需求 = 全局 enabled OR groupChatRequested；执行能力 = 后台且有效运行周期，且音频仍拥有会话并播放，或有效 UIKit 后台任务且 remaining>0。`canAttemptBackgroundWork` 额外要求全局 enabled，群能力额外要求 groupChatRequested。不能简单用“开关打开”代替实际能力。
- `CSBackgroundRunManager.m:83–96`：观察 App/Scene 真实生命周期、音频中断/服务重置/路由、宿主音频变化、设置导入通知；`98–103` 支持多 scene，有任一前台 scene 时不作为全后台。
- 当前机制为混合接力：`m:12–14,201–211,253–263` 每26秒轮换有限 UIKit task；`281–299` 剩余<8s或无task才尝试音频，音频至少5s，有限预算>=12s经2次相隔1s采样才停止音频；`302–324` 预算不足结束/按下一边界单次检查。无限大 remaining 不被当成恢复证据（15–17）。
- `CSBackgroundRunRuntime.m:129–135` 使用 UIKit `beginBackgroundTaskWithName:expirationHandler:`；`92–118` 单次 NSTimer 加主runloop common mode；task句柄严格只结束自身identifier、容忍同步到期/旧回调（21–71）。
- `CSBackgroundRunAudio.m:36–51` 内存生成8秒16kHz单声道16位零PCM WAV；`99–108` AVAudioPlayer无限循环、Playback/Default/MixWithOthers、激活后确认真的播放。实际零样本，源码不是外部音频文件。
- `CSBackgroundRunAudio.m:13–33,70–85,86–119,129–156`：宿主修改epoch、线程局部排除自己的调用、宿主忙不抢占，接管后relinquish；只在仍持有配置lease时关闭会话/恢复旧category/options/mode/policy；中断后按系统允许恢复。
- `Hooks/BackgroundRun.xm:7–49` 仅观察 AVAudioSession 的7个配置/激活方法，完整调用原方法、透传返回值错误，不修改UIApplication状态或微信在线状态；`52–57` 启动在 CSBackupWhenReady 后主队列。

## 功能依赖矩阵

| 功能 | 直接耦合 | 当前行为与替换影响 |
| --- | --- | --- |
| 后台设置界面 | 强 | `CSBackgroundRunViewController.m:20–26,49–67` 订阅manager状态、读写同一开关，展示能力与最近记录。更换算法应更新 `89,115–116` 的机制描述，不能仍描述26s/8s/12s混合接力。 |
| AI后台兜底补拉 | 强 | `CSAIReplyManager.m:122–124` 订阅状态通知和真实生命周期；`333–354` 在后台、全局manager.canAttemptBackgroundWork为真才允许补拉，且配置、免@群、账号、授权有效。新实现若未正确发布能力，会停掉AI兜底；若只看开关，会在资源已失效时误请求。保活状态改变不应高频抖动，时间戳更新不应反复通知（BackgroundRunManager.m:116–120）。 |
| AI已入站消息回复 | 无直接能力门禁 | manager真正发消息的授权、账号与会话条件在 `CSAIReplyManager.m:530–539`，后台能力门禁主要控制主动补拉，不应扩展成“关保活就禁止AI所有后台事件”。 |
| 群欢迎/退群 | 资源申请耦合，业务处理独立 | `Hooks/GroupChatHooks.xm:6–14` 启动manager并传入共享需求。`CSGroupChatManager.m:76–88` KVO enabled，需求须全局enabled + ready + 非saving + 配置群 + 账号授权有效。`54–70` 实际后台处理以当前主队列执行机会为准，不依赖 canAttemptGroupChatBackgroundWork。替换保留资源申请接口和KVO即可避免业务大改。 |
| 定时任务 | 无直接依赖 | `CSScheduledTaskManager.m:59–68` 本地nextRun、主队列dispatch_source到期；`73–101,107–124` 保留账号epoch/授权/会话校验和durable claim。新引擎影响CPU执行机会和准时性，不能改任务时间、补发窗口、去重规则。 |
| 红包/自动收款 | 无直接依赖 | `ReceiveTransferHooks.xm:16–26` 监听AddMsg/AsyncOnAddMsg，`CSPaymentAutomation.m:493–515` 快照type49入站并投主队列；`426–445` 独立任务timer；`525–533` 独立payment epoch。引擎影响收到消息后的执行时机，不应直接调用领取或绕过去重。 |
| 自动回复/拍我回拍/回复/撤回 | 无直接依赖 | `CSAutomationManager.m:103–110` 账号授权真实存储能力；`144–235` 拍动10秒补拉只以后台、配置、账号授权为条件，不要求保活manager；`373–380,467–474,543–588` 入站和任务独立调度。替换保活不等于已解决群拍完整事件入站迟到。 |
| 后台隐私模糊 | 无manager依赖，但真实生命周期敏感 | `CSBackgroundBlurManager.m:72–88,102–128` 依赖App/Scene失活后台通知与真实scene状态，接管快照遮罩。任何屏蔽/伪造全局生命周期方案需要单独兼容，不能遗漏隐私遮罩。 |
| 密友锁定/FaceID | 无manager依赖，但真实生命周期敏感 | `CSCloseFriendManager.m:164–174,218–234` 在失活/后台/锁屏撤销展示授权、遮罩、取消挑战；回前台再激活。全局伪造Active或吞通知可能破坏锁定/遮罩和恢复边界。 |
| 备份恢复/重置 | 开关键契约 | `CSBackupManager.m:34–35` legacy映射当前suite；`CSBackupRegistry.m:64–65` 精确注册BackgroundInterval(number)、BackgroundRunEnabled(bool)，scope global。保留旧开关键与类型，BackgroundInterval可继续作为惰性兼容项；新参数需显式注册并限定取值，不能读取WCRefine配置域或替换用户现有域。 |
| 账号/授权生命周期 | manager本身无业务账号门禁 | `BackgroundRunManager.m` 不查询CSAuthorizationManager、CSBackupAccountChanged；只在 CSBackupWhenReady 后开始。其本质是进程全局资源服务。业务模块各自持有账号epoch/授权条件。替换不可把资源引擎变成消息发送入口，亦不能让账号相关任务跨切换重用。 |

## 当前代码与旧说明的冲突

`CSBackgroundRunViewController.m:89,116` 仍写“群聊后台实时运行可独立使用资源”。生效代码中 `CSGroupChatManager.m:77` 资源请求明确要求全局 `backgroundRunManager.enabled`；群配置的旧键 `backgroundRealtimeEnabled` 在加载和保存去掉（222、232），仅兼容接受旧数据（CSGroupChatStore.m:60）。因此当前真实语义为：全局开关控制本插件额外买时间；群消息业务在其他方式给予运行机会时也能继续处理。方案应明确保持这个语义并修正说明，避免意外复活一个旧独立开关。

## 替换必须保住的约束

1. 同一进程只有一个资源owner，开关关闭/前台/无需求时及时释放，仅结束自己的UIKit task、timer、player和音频session配置。
2. 保留 manager的API、enabled KVO、状态通知和真实能力定义，尤其保障AI补拉控制；状态真实失败时必须发布false。
3. 不能吞掉UIKit/Scene真实通知、全局applicationState返回值或原生回调；否则支付/AI/自动功能foreground handover、群连续性、隐私遮罩与密友锁定均可能受影响。
4. 宿主音视频/语音通话/录音优先。至少保留现有音频lease/epoch识别、系统中断/重置处理和恢复时序；WCRefine若更激进，可借其运行策略，不能丢失这些项目保护。
5. 启动仍经CSBackupWhenReady，恢复/重置计划处理前不读旧开关提前启动。配置沿用原suite/key/type，业务数据与账号文件不动；最近后台记录为当前进程内存观察，不伪造“持续运行”证明。
6. 拍动10s、AI45s主动补拉与新保活引擎是不同子系统；本任务替换引擎时默认保持现有预算/消息处理/去重/授权逻辑，群拍目标另以关闭补拉的真实时序验收。
7. `Makefile:19–20` arm64/arm64e、iOS15+；`:23–25` 自动编译所有Hooks/Controllers，因此旧实现要停用/移除，不能只加新文件导致两引擎并行。`:41–43` make clean会删除packages，不用它清理历史包。

## 建议回归范围（实施后）

模块自动检查：资源owner/到期竞态/生命周期多scene、开关/KVO/通知、音频接管中断及恢复；现有 `BackgroundRunTests/HybridTests/RuntimeTests/RecordTests` 应按新状态机调整而不是机械保留旧阈值预期；`AIReplyManagerTests` 核对能力false立刻停兜底、恢复只开一个调度器；备份registry兼容、群资源请求撤销。

真机：后台与锁屏驻留后依次验证群欢迎退群、定时任务、红包/收款、AI、自动拍动；过程中穿插语音消息、通话、录音、视频和耳机/蓝牙路由；验证回前台、关开关、账号切换、锁屏隐私遮罩及密友重新认证。不能用仅静态或宿主夹具通过宣称真实后台有效。
