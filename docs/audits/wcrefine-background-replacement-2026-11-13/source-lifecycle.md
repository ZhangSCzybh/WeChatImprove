# 当前后台运行的生命周期与音频约束（只读源码核对）

核对范围：当前正式 2.5-11 源码。下文提及的群聊独立请求是manager底层接口能力；当前实际群模块的请求又要求全局enabled（CSGroupChatManager.m:77），用户界面没有继续生效的旧独立后台开关。最终方案以主报告此项澄清为准。未采用历史分析；未运行或安装插件、未改生产代码、未运行服务或操作用户数据。本稿只评估未来替换引擎必须保留的行为，不对 WCRefine 的机制作推断。

## 当前实际策略

- `Controllers/CSBackgroundRunManager.m:12–19` 定义 26 秒 task 轮换、音频进入阈值 8 秒、清理阈值 5 秒；音频最短 5 秒，独立有限预算恢复到 12 秒且两次检查间隔至少 1 秒后退出音频。极大、无穷或非法预算不作为有限预算恢复证据。
- `:75–82` 资源总需求为全局开关 OR 群聊独立需求；两个业务 capability 分别绑定各自需求。执行机会还要求确实后台、本轮 active/未 ended，且健康音频或有效 task + 正剩余时间。不能把 capability 改成开关值。
- `:201–211` 先申请新 task 再结束旧 task；替换失败不马上结束旧 task。`:192–199` 过期仅处理同代次同一个 task。`:247–265` 过期后无音频则本轮结束，不用无限补申请掩盖到期。
- `Controllers/CSBackgroundRunRuntime.m:129–139` 通过 `beginBackgroundTaskWithName`，task 名为 `WeChatImprove.BackgroundRun`；检查用主 run loop common modes 的单次 NSTimer (`:93–101`)，非永久高频轮询。
- Runtime `:32–69` 处理同步到期早于返回 identifier、重复到期、非主线程到期等重入场景；立即失效、main 上有序结束和回调，避免 identifier 泄漏和误结束另一轮。

## 音频参数与所有权

- `Controllers/CSBackgroundRunAudio.m:36–51` 内存生成 8 秒、16 kHz、单声道 16-bit PCM WAV，数据采样为零；不依赖 bundle 音频文件和额外解码文件。`:99–108` AVAudioPlayer 无限循环。
- 会话参数 `:104`：`AVAudioSessionCategoryPlayback`、`AVAudioSessionModeDefault`、`AVAudioSessionRouteSharingPolicyDefault`、`AVAudioSessionCategoryOptionMixWithOthers`。不设置 Duck、PlayAndRecord 或蓝牙策略。
- `:70–84` 宿主忙碌或已接管配置时不借用会话。晚加载且无法确认宿主 active 状态时，仅允许默认 Ambient/SoloAmbient + Default mode。
- `Hooks/BackgroundRun.xm:7–49` 观察公开 `setCategory` 四个变体、setMode、setActive 两个变体。原始参数、返回值、error、异常均透传。`CSBackgroundRunAudio.m:7–33` 线程局部排除自调用及原生嵌套，通过 atomic epoch 在调用开始时立即撤销旧 ownership，不等待主线程通知。
- `CSBackgroundRunAudio.m:93–94` 记录接管前 Category/Mode/Options/Policy；`:141–156` 仅仍持有同一配置时 deactivate+恢复。deactivate 失败不覆盖配置。宿主已接管时 `relinquish` 仅停自己的 player，不 deactivate、不恢复旧快照。`suspend` 则在系统中断时保留配置租约，允许恢复时再按规则交还/重建。

这些机制对微信的通话、语音录制、聊天语音、视频/音乐播放，以及其他插件修改同一进程 audio session 都有实际意义。未来引擎即使更简单，也不宜绕过所有权/让出约束。

## 状态和生命周期

- `CSBackgroundRunManager.m:83–103` 同时观察 UIApplication 和 UIScene，并把任何 ForegroundActive/ForegroundInactive scene 视为前台。`:354–365` 重复/过期 scene 通知不会在前台重启后台资源。
- `:149–159` 统一释放 task、timer、player并推进 generation。`:326–336` 前台/后台切换重置本轮状态；前台释放全部资源。关闭全局开关时，如果群聊仍有独立需求，资源继续共享（`:75`、`:161–190`）。
- `:367–378` 系统音频中断立即让出；中断结束仅 ShouldResume 才允许恢复，未获准则保持 resumeBlocked 到前台。
- `:379–386` media services lost 让出，reset 才恢复尝试；宿主成功 setActive:NO 且没有后续其他声明，才解除 hostYielded 并允许重试。
- `:387–393` player 结束/解码错或路由改变导致停播，不在普通通知上反复抢占；显示失败并待下一次合适机会。`:338–346` 真正宿主 release/允许恢复/媒体 reset 可开启新机会，普通 defaults/route 通知不会凭空复活 ended cycle。
- manager 没有账号或授权通知依赖。它是全局资源管理器；Hook ctor 只在 `CSBackupWhenReady` 后安装和 start（`Hooks/BackgroundRun.xm:52–56`）。账号隔离和授权由业务消费者保证。未来方案不应误把全局 keepalive 当作某账号任务，也不应让账号旧业务跨代执行。

## 设置、备份、状态展示

- domain/key/通知在 `CSBackgroundRunManager.m:7–10`：`com.cyansmoke.wechattweak` / `BackgroundRunEnabled` / `BackgroundRunStatusChanged`，以及 `CSBackgroundRunStateChanged`。
- UI `Controllers/CSBackgroundRunViewController.m:52–75` 写回原 key，显示当前状态、包内后台 audio 声明和最近后台记录；`:89–91`、`:115–116` 描述当前策略，若更换引擎必须同步改为真实策略。
- 包能力来自主 Bundle 的 UIBackgroundModes/audio（manager `:53–55`）；不是 tweak 自己的 plist。任一新音频方案仍需核对实际微信包能力，不能只检查 deb metadata。
- 最近后台记录为进程内观察值（`:122–145`），检查到前台间隔用 uptime，展示时间用 wall clock。不得把 timer 最后执行时间当作“全程没挂起”的证明。
- `Controllers/CSBackupRegistry.m:64–65` 保留旧 `BackgroundInterval` 和当前 `BackgroundRunEnabled` 的精确注册。兼容旧备份字段不意味着旧 interval 仍有运行消费者。

## 现有测试能提供什么

- `Tests/verify-background-run.sh:6–31` 有实现结构断言：透传 Hook 数量、禁止某些 timer/旧资源/私有 Hook、manager 与 runtime 分层。替换引擎后不能简单照抄为验收标准；应保留行为目标，调整与旧策略绑定的断言。
- 同脚本 `:33–49` 编译并运行 BackgroundRunRecordTests、BackgroundRunHybridTests、BackgroundRunTests，在临时隔离 defaults/runtime 下验证音频会话和 manager，afinfo 验证 PCM 音频。主机模拟不能证明 iOS 锁屏生存、真实音频路由或耗电。
- `Tests/BackgroundRunTests.m:54–105` 单实例资源、晚加载、多 scene、各种启动失败；`:144–208` native 音频接管、线程/嵌套/异常透传、同值写入也夺取 ownership、deactivate 失败不恢复。
- `Tests/BackgroundRunHybridTests.m:47–205` task/audio阈值、轮换、过期、非法预算及失败不重试；`:207–215` capability变化通知；`:218–256` 重入、取消后迟到回调；`:258–268` 多 scene。
- `Tests/BackgroundRunRecordTests.m` 验证真实检查记录、未观察到的背景进入、关闭再开、wall clock改变与单调间隔。
- `Tests/verify-background-run-runtime.sh` / `BackgroundRunRuntimeTests.m` 验证 task identifier 和 one-shot timer 的同步/重入/线程/资源释放及真实Foundation runloop回调。

## 建议的保留/重造边界

建议保留或提供兼容 facade：原 settings domain/key、全局与群聊需求的 OR 合并、enabled KVO、capability语义及状态通知、前后台/Scene判断、host audio ownership、有效停止/恢复、generation拒绝迟到回调、状态真实性。替换策略引擎可以改变26秒、8/12/5秒阈值、播放器类型、资源组织等内部机制，须按已证实的 WCRefine 行为决定，而非机械保留旧阈值。

需要明确检查 capability 的两类语义：`canAttemptBackgroundWork` 仍要服从全局开关，`canAttemptGroupChatBackgroundWork` 仍要服从群聊独立请求，二者都应反映实际执行资源。直接返回 enabled 会令 AI 同步错误启动；在底层另有有效群请求的前提下，误把全局关闭当作无条件释放总资源，会破坏接口语义；当前群调用方仍受全局enabled约束。

## 未来真机验收矩阵

| 场景 | 必须验证 |
| --- | --- |
| 全局开关开/关、后台中途切换；底层全局/群请求组合的接口测试 | 单一资源实例；任一有效需求可运行，全部关闭后真正释放；消费者capability一致 |
| 前台→后台→锁屏，较长停留，再回前台；多 scene/通知中心/Face ID | 真实后台才启动；任一前台scene停止；重复通知无重入及残留timer |
| 微信语音录制/收听、语音/视频通话、收藏音频、视频和音乐、系统来电 | native音频优先；音质/路由/麦克风正常；不抢回宿主session；结束后按允许条件恢复 |
| 耳机插拔、蓝牙连接/断开/切换、扬声器/听筒切换 | 不擅改host路由；不中断native播放；旧session快照不得覆盖新配置 |
| 音频中断含/不含ShouldResume；media service lost/reset；播放失败 | 暂停/恢复条件正确；无失败重试风暴；状态不谎报运行 |
| task申请失败、替换失败、过期、停止后迟到回调 | 正确结束自己的handle；不泄漏、不复活旧轮次、不影响其他后台任务 |
| 账号切换/退出、授权失效、备份恢复/恢复默认 | 全局配置兼容；业务旧账号工作不跨代执行；共享资源总需求正确重评估 |
| AI/群欢迎退群、定时任务、红包收款、群/私拍动 | 在相同实际账号/数据/环境中观察功能成功及重复抑制；接收时序独立于keepalive成功判定 |
| 原一种外部保活启用/关闭；同插件多开条件；长时锁屏能耗 | 防双重音频和timer，比较耗电、CPU与温度，不把主机测试当真机耗电结论 |

构建依旧为 Theos arm64/arm64e iOS15+，`Makefile:23–35` wildcard会自动编入新Controllers/Hooks，AVFoundation已链接。`Makefile:41–43` 的 make clean 会删除 `.theos packages`，不能为分析或新方案构建误删历史包。正式发布需同步 `control:3`、`Headers/CSUserInfoHelper.h:17` 与 `Controllers/CSReleaseNotesViewController.m:4–7`。
