# WCRefine 2.1-7 后台保活逆向与后台运行替换方案（待确认）

分析日期：2026-11-13。用户要求先分析 deb、梳理其他功能影响并提出方案，确认后才开始重造。本轮仅新增分析与证据，未修改生产源码、安装或运行目标插件、打包或操作账号及用户数据。当前生产源码仍为正式 **2.5-11**，HEAD `00634e438df1bac522e4c4b527adb95d3dfbbcea`。

本报告依据本轮直接读取的 deb、Objective-C 元数据、ARM64 机器码、微信音频资源，以及当前生效源码。包内描述和字符串用于寻找入口，不视为运行结果或实现结论；历史项目分析不作为本报告依据。

## 结论

可以按 WCRefine 的核心策略重造项目后台运行：**UIKit 有限后台任务 + 余量条件触发的短静音播放 + 任务续接**。其实际播放方式与项目现有“预算不足后使用无限循环音频接力”有明显区别。

推荐采用“WCRefine 的短音频与检查策略 + 项目现有接口及音频所有权保护”的适配实现。这样确实替换运行策略，同时保住 AI、群聊资源申请、真实生命周期、旧配置和宿主音频接管的兼容契约。

静态分析能证实机制和依赖；尚未在用户手机运行该 deb，不能证明新策略一定比现有实现持续更久、更省电，或让完整群拍消息更及时下发。后台任务是否续得时间、锁屏是否持续调度，需要真机对照。

## 目标身份与包内容

- 文件：`/Users/zhangshichao/Downloads/WCRefine_2.1-7_无根.deb`。
- deb SHA-256：`bc08fd136108ebbd0a851dd50c616cc095ac09f2c138650425438b2dec0c6b65`。
- control 声明：`com.qimiao.WCRefine`，`2.1-7`，`iphoneos-arm64`，firmware >=14.0、mobilesubstrate，说明基于微信8.0.64+。这是包声明，不能直接当成全部版本兼容证明。
- dylib：44,282,288 字节，ARM64，UUID `0CCD634D-E436-35F3-9743-2CEF918323D3`。
- dylib SHA-256：`1a50ed857cc654b67b784490e8b18b334ea6ab7112b0e31c0c6ef111c9669929`。
- REA Mach-O 证据：`ev_766b1bf2750056e2626b3c5cafa69073b2956d0fe81befd4eac50887b8a323ae`，完整结果见 [rea-macho-evidence.json](rea-macho-evidence.json)。

deb 的 data 部分只有 dylib、注入 plist 和 `.DS_Store`，没有额外后台 daemon、launchd plist 或音频资源；control 部分仅 control 文件，没有安装脚本。plist 将整个插件注入微信和部分分享扩展；这不表示保活在所有扩展中都能有效工作，项目替换不需要扩大现有注入范围。

包清单及资源身份见 [target.json](target.json)、[inventory.json](inventory.json)、[package-control.txt](package-control.txt)、[package-filter.plist](package-filter.plist)。

## 原生实现：入口、定时和后台任务

核心类为 `WCRefineBackgroundKeepAlive`。地址均为 dylib 未滑动 VM 地址。

| 方法 / 入口 | IMP | 核实的行为 |
| --- | --- | --- |
| `+load` | `0xec73ac` | Hook `MicroMessengerAppDelegate.applicationWillTerminate:` 用于结束提示；异步到主队列创建 shared 并刷新设置 |
| `refreshSettings` | `0xec7cbc` | 读取配置与间隔；关闭时移除观察并 stop，开启则注册观察；已在后台时重新启动检查 |
| `appDidEnterBackground` | `0xec7eb0` | 标记后台、记录开始时间、重置结束提示标记，再调用 startIfNeeded |
| `appWillEnterForeground` | `0xec7fcc` | 清后台标记、清记录、stop |
| `startIfNeeded` | `0xec80e0` | 无 task 才申请；安排一次1.5秒检查，以及按配置间隔重复的 onTimer；两个timer加入主runloop common modes |
| `onGracePulse` | `0xec92e0` | 重新确认开启和后台，然后调用同一 requestMoreTime；不是无条件在1.5秒时播放音频 |
| `onTimer` | `0xec8884` | 调用 requestMoreTime |
| `requestMoreTime` | `0xec88bc` | 常规有限值条件为 `0 < backgroundTimeRemaining < 30秒`，满足后 ensureAudioPlaying → endBackgroundTask → beginBackgroundTaskIfNeeded |
| `beginBackgroundTaskIfNeeded` | `0xec865c` | 仅无task且开启、后台时申请；expiration block 通过 weak self 调 endBackgroundTask |
| `stop` | `0xec9a40` | 取消重复timer及grace timer、stopAudio、结束task、清让出标记 |

`backgroundKeepAliveInterval` 默认 **25秒**，配置与 `clampedInterval:` 都限制 **10～30秒**（`0x208f148`、`0xec7b04`）。这表示检查频率，音频播放和换task还需要余量条件。不能表述成“每25秒无条件播放并拿到新时间”。

已核对的保活类、load Hook 和直接辅助函数中，没有发现改写微信 NewSyncService / onlineMode、全局伪造 UIApplicationStateActive，或吞掉后台通知的实现。该局部结论不等于审计了整个44MB插件所有其他功能。

## 原生实现：短音频与音频让出

`ensureAudioPlaying`（`0xec8a08`）的主要行为：

1. 检查微信通话 / 多人通话状态及 VoiceChat、VideoChat mode；命中时停止自己的player并让出。
2. 确保共享 AudioSession 类别为 **Playback**，options 包含 **MixWithOthers（1）**。该方法没有设置 mode。
3. 读取 `secondaryAudioShouldBeSilencedHint`，提示其他音频优先时停止自己的player。注意其原实现是在前述类别检查 / 修改后才检查该hint。
4. 若现有player仍在播放则返回；否则激活 AudioSession，取 `NSBundle.mainBundle` 中的 **blank.caf**，新建 AVAudioPlayer，volume=0，prepareToPlay 后 play。

**本方法没有设置 numberOfLoops，也没有设置 currentTime。** 每次真正重新播放会新建player；不能根据“silentPlayer”名称推断为无限循环。资源缺失、创建失败、play失败均会退出；原实现没有完整校验并传播 setCategory / setActive 的失败。

为确认主包资源，本轮从本会话原生微信8.0.80.34 IPA重新读取 `Payload/WeChat.app/blank.caf`，得到：

- 13,876字节，SHA-256 `87624270eecd99416dff2c9371ababa416c118d26b7ef194cabb691c884cdc8a`。
- 44.1kHz、双声道、16-bit PCM、2445帧，时长 **0.055442秒（约55毫秒）**；读取音频数据段确认采样全零。
- [afinfo原始输出](host-blank-caf-afinfo.txt)。这个时长只属于上述微信包，deb本身没有固定该资源的时长。

因此，此目标在该微信包上的音频动作是短静音播放，而项目当前生成8秒音频并无限循环。

`audioSessionMayHaveChanged:`（`0xec937c`）观察 route change、interruption、silence secondary hint：需让出时停player；其余恢复机会经 **0.4秒** dispatch_after 后重查开启、后台、通话和其他音频，再尝试播放。它未按项目当前方式检查 interruption ShouldResume，也没有完整的 media-services lost/reset 状态机。独立音频复核见 [native-audio-review.md](native-audio-review.md)，其中也核实了动态通话状态调用只检查selector存在，未做项目当前惯用的完整ABI校验。

`stopAudio`（`0xec9898`）只 stop 并清player。所查停止链没有 `setActive:NO`、恢复先前 category/mode/options/policy 或音频配置所有权代次保护。短音频结束也不等于共享session已交还。

这一差别是适配项目时最大的影响点：微信与插件共享 AudioSession，照搬会留下录音、通话、音频路由及其他播放器被改配置的可能；应保留项目的宿主接管检测和只释放自身租约的机制。

## 结束提示的实际能力

目标还提供 `backgroundDropNotifyEnabled`，由 applicationWillTerminate Hook 调 `notifyDropEndedOnTerminate`（`0xec9b90`）发送本地通知，附本次开始到结束的时间。

这只是收到 termination 回调时的尽力提示，不是独立进程监控。不能把它作为“系统挂起、强杀、所有退后台失效情况都会通知”的保证。用户本次要求替换保活引擎，建议首轮不引入这项额外通知权限和提示功能。

## 与项目当前2.5-11的差异

| 项目 | 当前后台运行 | WCRefine已观察实现 |
| --- | --- | --- |
| task检查 / 轮换 | 26秒尝试轮换，并按预算边界增加单次检查 | 默认25秒检查，范围10～30；进后台另有1.5秒检查 |
| 触发音频的余量 | <8秒；初次task失败也可尝试音频 | 常规有限余量0～30秒内触发音频并续接task |
| 音频形式 | 内存生成8秒、16kHz、单声道PCM，无限循环 | 主微信包blank.caf，音量0、未设置循环；本轮微信资源约55毫秒 |
| 停音频策略 | 至少5秒；预算恢复>=12秒并经两次采样后停止 | 短音频自行播完，下一次条件满足时重新创建播放；停止链不恢复session |
| task换手 | 新task先成功再结束旧task；回调绑定handle和代次 | 检查路径先结束旧task再申请新task；expiration通过当前manager结束task |
| 宿主音频保护 | 公开配置/active调用监测、atomic epoch、同值写入也撤销租约、按所有权恢复 | 通话状态/mode和secondary hint、音频通知后延时重查；未见相同租约保护 |
| 生命周期 | App + Scene，多Scene和迟到回调保护 | 本类主要观察App通知；load额外Hook终止回调 |

## 对其他功能的影响

详细源码核查见 [source-dependencies.md](source-dependencies.md) 和 [source-lifecycle.md](source-lifecycle.md)。以下是本轮替换要处理的真实契约。

| 功能 | 依赖和可能影响 | 替换要求 |
| --- | --- | --- |
| AI后台兜底补拉 | `CSAIReplyManager.m:122,333–354` 直接依赖 `canAttemptBackgroundWork` 和状态通知 | 保留真实能力与通知；短音频自然结束不能被当成整个引擎故障；开关打开也不能直接等同可执行 |
| 群欢迎 / 退群 | `GroupChatHooks.xm:6–14` 申请共享资源；`CSGroupChatManager.m:76–88` KVO enabled，当前请求还要求全局enabled | 保留API、KVO与请求撤销；同一套引擎共享，不新增第二套timer/player |
| 定时任务 | 自有 nextRun / 主队列timer / 账号和持久认领；无后台manager直接门禁 | 影响到期时的执行机会，需真机验准时性；调度规则和去重继续由本模块负责 |
| 红包 / 自动收款 | 独立入站消息、timer和payment epoch；无后台manager直接门禁 | 回归后台收到消息后的处理，保留账号授权、领取资格和去重 |
| 自动回复 / 回拍 / 拍动文字回复 / 撤回 | 独立任务与拍动10秒补拉，未要求本manager开关 | 本轮不改变同步预算和动作语义；引擎替换本身不能证明群拍完整消息入站问题已修复 |
| 微信录音、语音收听、语音/视频/多人通话、视频音乐 | 与保活共用AudioSession | 保留公开调用透传与配置epoch，宿主接管立即让出；不得恢复旧快照覆盖新宿主配置 |
| 后台隐私模糊、密友锁定 / Face ID | 依赖真实App/Scene失活、后台、锁屏事件 | 完整保留原生命周期；本方案不改applicationState或通知分发 |
| 备份恢复、重置和设置页 | 原suite/key/type为兼容边界；UI仍描述旧引擎 | 开关和值继承，恢复后统一重评估；更新真实策略和状态说明 |

有一处需要按生效代码纠正：当前manager底层支持 `enabled || groupChatRequested`，但当前群模块提交请求的条件又要求 `enabled`，旧群独立后台键已在加载和保存剔除。设置页仍有“关闭全局后群可独立保活”的旧说明，与当前调用链不符。**本轮保留底层请求与两类capability接口，不复活旧独立开关，并修正文案。** 底层接口测试可覆盖两类请求；用户界面验收按当前实际开关语义执行。

另外，选择外部插件保活、关闭本项目开关时，当前AI主动兜底仍会因本manager能力为false停止；已入站AI回复和群处理走各自条件。这是现有行为，不能在替换中悄悄改变。

## 可选方案与推荐

| 方案 | 做法 | 取舍 |
| --- | --- | --- |
| A：逐项复刻目标行为 | 依赖主包blank.caf，照搬timer、task换手及停音频方式 | 与目标最接近，但保留其资源依赖、音频session交还和回调竞态缺口，项目回归风险较大 |
| **B：核心策略移植并适配项目（推荐）** | 采用短静音 + 25秒检查 / 30秒余量条件 / 1.5秒首检；保留项目facade、资源handle、音频租约、Scene和配置约束 | 达到替换目标，其他模块改动可控；仍需真机确认短音频策略的实际持续性 |
| C：同包保留两个可选引擎 | 新旧运行策略通过内部模式切换，互斥运行 | 有利于长期对照，但增加设置、测试和维护成本；本次只需阶段对照验证，无须交付两个引擎 |

建议采用B，首轮交付单引擎。保留正式2.5-11作为可回退基线，验证包与正式包版本清楚区分。

## 推荐方案的具体设计

### 1. 保留外部契约，替换内部调度

沿用 `CSBackgroundRunManager` 的公开接口、原 `enabled` KVO、`CSBackgroundRunStateChangedNotification`、群资源申请、最近后台记录、`CSBackupWhenReady` 后启动。后台资源仍为进程级服务，各业务自行检查账号epoch与授权。

在现有Manager内部重造策略，Runtime继续负责可取消检查和仅属于自己的task handle。旧26秒轮换 / 8秒进入 / 12秒恢复 / 最短5秒循环的状态机退出生效路径，不能追加一套新timer同时运行。

### 2. 新策略的事件顺序

1. 开启且确认真正进入后台后，创建一个有限task和一套检查调度；首检1.5秒，后续默认25秒。
2. 每次检查重新确认需求、真实App/Scene、代次和资源，读取系统remaining。仅有效有限余量 `0 < remaining < 30秒` 时进入短音频与task续接流程；极大值不当作“已永久保活”证据。
3. 宿主音频可借用且系统允许时播放一次短静音；成功完成是预期事件。自然完成不触发当前 `audioPlayerDidFinishPlaying` 所代表的“无限循环异常中止”处理，也不结束本轮检查。
4. 为保留项目现有资源安全，先取得新task再结束旧task；申请失败保留尚有效的旧task，状态按真实失败更新。这是相对WCRefine先结束再申请的明确适配。
5. 真实前台、全部需求撤销或开关关闭后，取消调度、停止自身player、结束自身task，按仍持有的音频租约交还配置；旧generation的1.5秒/0.4秒回调失效。

task申请不等于增加预算；音频播放也不等于系统保证后续timer执行。剩余预算为0且没有实际执行资源时上报不可执行，不循环空转续申请。

### 3. 音源与音频会话

采用本项目自行生成的等价短全零PCM，首轮按本轮微信资源的2445帧 / 44.1kHz / 双声道构造约55毫秒音频，volume=0，单次播放。**不再依赖微信blank.caf存在，也不把现有8秒无限循环音频留作静默回退。** 格式与时长选择是本方案的工程决定，效果以验证包确认。

调度层采用WCRefine策略，音频配置由项目租约层管理：Playback + MixWithOthers，Default mode / policy仅在确认可借用时设置；宿主配置、激活、录音、通话和路由优先。宿主同值写入仍代表接管，立即失效旧租约；只停自己的player，不对新宿主session做deactivate或恢复。

短音频自然结束时不立即反复恢复/激活session；后台期间可保留有效租约供下一次短播放，直到前台、关闭或宿主接管。持有租约不作为持续执行能力证明。

中断结束按ShouldResume、宿主真实释放和media reset重新评估，可采用目标0.4秒合并恢复检查，但普通route/defaults通知不越过“禁止恢复”状态、不形成播放风暴。检查OtherAudio hint应放在修改类别之前。

### 4. 配置与界面

- 保留原suite `com.cyansmoke.wechattweak`、`BackgroundRunEnabled` bool及旧备份内容。
- 检查间隔使用明确的新键（建议 `BackgroundRunCheckInterval`），默认25、允许10～30秒，注册为global number并校验。旧 `BackgroundInterval` 继续兼容保存，不将其历史含义未经确认地解释成新间隔。
- 设置页保留“后台运行”入口，新增检查间隔、展示实际task/短音频/让出/不可执行状态，更新旧机制和独立群开关文案。
- 能力仍按真实有效task/正在播放且拥有的音频及本轮状态计算；不能直接返回enabled，也不因正常55毫秒播放结束反复误报引擎失败。有效task持续存在时，短音频自然起落不应重置AI兜底调度窗口或取消在途请求；按状态变化合并通知并做此项回归。
- 首轮不加入termination通知，也不改变微信原生在线状态、消息补拉频率或业务规则。

## 实施范围（批准后）

主要调整 `Controllers/CSBackgroundRunManager.{h,m}`、`CSBackgroundRunAudio.{h,m}`、`CSBackgroundRunRuntime.{h,m}`、`CSBackgroundRunViewController.m` 和配置备份注册。`Hooks/BackgroundRun.xm` 继续承担宿主音频调用观察和启动；尽量保留参数、结果、error、异常透传实现。

AI、群聊、支付、定时和自动功能原则上只做兼容回归，发现明确接口问题再做最小适配。任何额外业务行为变化单列说明。

项目自动编译Controllers与Hooks，支持arm64/arm64e、iOS15+，AVFoundation已链接。新实现不需要携带或链接WCRefine整包。发布同步control、版本宏和内置版本说明；避免执行会删除历史packages的make clean。

## 验证与验收

先做必要的状态机/接口检查：单实例资源、正常短音频完成、task换手失败、同步到期、关停后的迟到回调、宿主同值接管、中断恢复、多个Scene、配置导入、KVO和能力通知。现有测试中的旧固定阈值断言按新策略更新，账号/去重/存储约束继续保留。

随后在用户同一微信包、同一账号/数据与设备上，用原正式2.5-11与新验证包分阶段对照；只启用本次选定的一种保活。不能同时运行两个引擎来归因。

| 真机场景 | 验收内容 |
| --- | --- |
| 后台与锁屏持续驻留 | 建议覆盖刚进后台、5/15/30/60分钟；记录检查间隔、remaining、task与pulse结果及系统调度间断 |
| 微信语音、录音、语音/视频/多人通话、系统来电 | 麦克风、路由、音量和通话正常；保活让出、许可后恢复，关闭后不遗留错误session |
| 音乐/视频、耳机/蓝牙切换、系统中断 | 不打断宿主或其他音频，不错误抢回路由，不出现高频重试 |
| AI、群欢迎退群、定时任务、红包与自动收款 | 长时驻留后实际成功；AI能力通知和群资源需求正确，重复抑制与账号隔离保留 |
| 群/私聊拍动回拍与文字回复 | 分开记录完整事件入站和动作提交；保活稳定不能替代消息即时交付的验收 |
| 切前台、关闭再开、切号/退出、授权变化、恢复旧备份 | 资源停止/恢复、配置继承、业务代次以及隐私模糊/密友重新认证正确 |
| 能耗对照 | 相同驻留时长与消息负载，比较电量、温度、CPU与音频活动；不根据短音频时长推算一定更省电 |

验收通过后才能把新验证实现作为正式替换；若短音频策略无法维持目标设备的后台执行，报告实测结果并保留可回退包，不能悄悄改回无限循环后仍宣称复刻成功。

## 已回答与仍待实测

- 已回答：该deb后台保活的入口、间隔、资源来源、音频播放方式、续接顺序、让出/恢复和停止行为。
- 已回答：当前项目的直接消费者、生命周期敏感功能、配置兼容边界及推荐替换设计。
- 待实测：用户设备上的持续性、系统实际续时、真实音频兼容性、相对耗电，以及群拍完整消息交付是否改善。
- 待用户确认：是否采用推荐B方案；确认前不进入生产实现。

反汇编证据位于 [native](native/)。线性寄存器注释仅是定位辅助，分支汇合和W/X别名可能产生残留提示；结论依据实际指令、selector、导入绑定及手工核对的数据流。静态检查没有观察目标插件实际执行。

本轮使用的Mach-O/ObjC元数据解析与反汇编辅助脚本保存在 [tools/macho.py](tools/macho.py)，需要Python3及Capstone5。可用 `python3 tools/macho.py --binary /绝对路径/WCRefine.dylib WCRefineBackgroundKeepAlive --out /新输出目录` 复核方法表与汇编，或用 `--address 0xec88bc` 读取具体函数；目标二进制需与target.json哈希一致。
