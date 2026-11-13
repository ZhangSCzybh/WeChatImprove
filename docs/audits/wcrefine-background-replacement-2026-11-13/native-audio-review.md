# WCRefine 2.1-7：音频、让出及恢复的独立静态复核

本复核只读本轮提取的目标 dylib 及 ARM64 机器码，不采用项目历史分析。目标 SHA-256 为 `1a50ed857cc654b67b784490e8b18b334ea6ab7112b0e31c0c6ef111c9669929`。所有地址均为未滑动 VM 地址。没有运行、安装目标插件或修改项目生产源码。

## 已确认的播放方式

`-[WCRefineBackgroundKeepAlive ensureAudioPlaying]` 为 `0xec8a08`：

- `0xec8b40` 起取得共享 AVAudioSession，`0xec8b90–0xec8c74` 判断类别是否为 Playback 且 `categoryOptions & 1 == 1`，不满足时调用 `setCategory:withOptions:error:`，options 为1（MixWithOthers）。导入绑定 `0x25f44d8` 为 `_AVAudioSessionCategoryPlayback`。
- 类别检查/必要修改在 `otherAppOwnsAudio` 检查之前；`0xec8c78` 才调用后者。
- 如果已有player且 `isPlaying` 为真（`0xec8da8–0xec8e8c`），直接返回；没有重置其 `currentTime`。
- 其余情况调用 `setActive:YES error:`（`0xec8e9c–0xec8ec4`），然后从 `NSBundle.mainBundle` 取 `blank.caf`（`0xec8ed4–0xec8f1c`）。
- 资源存在才新建 `AVAudioPlayer initWithContentsOfURL:error:`；`0xec90c4–0xec90d8` 设 `volume=0`，随后 `prepareToPlay` 和 `play`。
- 这一方法没有 `setNumberOfLoops:`、`setCurrentTime:`，没有内存构造PCM、设置mode/policy、注册player delegate或结束回调。新播放重新建player。不能将其描述为无限循环音频或把播放器名称当成播放行为的证据。
- `setCategory`/`setActive` 虽接收NSError指针，但这一路没有据返回BOOL或NSError完整阻止后续流程。无资源时直接退出，创建或play失败时清player。

主agent补充并核验的宿主资源来自**本会话原生微信8.0.80.34 IPA** `Payload/WeChat.app/blank.caf`，不是deb内置资源：13,876字节，SHA-256 `87624270eecd99416dff2c9371ababa416c118d26b7ef194cabb691c884cdc8a`，44.1kHz、双声道、Int16、2445帧、约0.055442秒。该时长只能归属于这份微信包；不能推广为deb对所有宿主的固定55毫秒设计。deb未携带caf文件。

## 宿主通话与其他音频的让出条件

`+[WCRefineBackgroundKeepAlive hostCallOwnsAudioSession]`（`0xec759c`）转入helper `0xec75c0`，依次检查：

1. 服务 `VoipUIManager` 的 `isVoipWorking` / `isTalking`。
2. 服务 `MultiTalkMgr` 的 `isMultiTalkActive` / `isMultiTalkCalling` / `isMultiTalkConnected`。
3. 共享AudioSession的mode是否为 VoiceChat / VideoChat。导入绑定 `0x25f44f8` / `0x25f44f0` 分别确认这两个常量。

服务helper `0xecb17c` 动态取类，优先 `MMContext.currentContext`，再 `activeUserContext`，使用 `getService:`；失败可回退 `MMServiceCenter.defaultCenter`。BOOL调用helper `0xecb4dc` 检查对象和selector存在及 `respondsToSelector:`，然后直接发消息。此处未见项目现有的完整方法类型编码校验。

命中宿主占用时，ensure方法设置 `yieldedForHostCall=YES`，调用 `stopAudio` 并返回；不占用后清此标志。

`+[WCRefineBackgroundKeepAlive otherAppOwnsAudio]`（`0xec781c`）转入helper `0xec7840`，其实际依据仅是 `AVAudioSession.sharedInstance.secondaryAudioShouldBeSilencedHint`。它不是“所有其他App音频状态”的完整枚举，也没有在此查询 `isOtherAudioPlaying`。命中时设置 `yieldedForOtherAudio=YES`，停自身player并返回。

所查host helper没有检查所有录音/播放类别、通用AVAudioSession配置写入或租约所有权。不能声称已覆盖微信全部录音、语音收听和系统来电场景。项目方案保留现有所有权和宿主接管保护是必要的适配边界。

## 通知恢复与停止

`registerObserversIfNeeded`（`0xeca8a0`）注册App后台/前台/Active通知，以及AudioSession route-change、interruption、silence-secondary-hint通知。AudioSession观察统一进入 `audioSessionMayHaveChanged:`（`0xec937c`）。

该方法只在开启且后台时处理；先重新检查host占用，命中则停player并标记让出。然后检查中断type==1（began）、或silence hint type==1（begin），或当前secondary hint为真；需让出时停player并标记。没有读取 `AVAudioSessionInterruptionOptionShouldResume` 或InterruptionOptionKey；不能将所有结束通知描述为已获系统恢复许可。

其余分支安排 **0.4秒** `dispatch_after`（`0xec96ec–0xec9774`；常量 `0x17d78400` ns）。block `0xec97b8` 再查weak self、后台、开启、host占用和secondary hint，满足后才 `ensureAudioPlaying`。没有在这一block里按代次取消，重复通知可安排多个待执行block；本轮只确认每个block都做状态复查。

本类未注册media-services lost/reset通知，未见与项目当前同等的Scene/音频epoch状态机。

`stopAudio`（`0xec9898`）仅调用自身player的 `stop` 并将 `silentPlayer=nil`。没有 `setActive:NO`，没有恢复先前category/mode/options/policy，没有持有/释放音频配置租约或以epoch防止旧快照覆盖宿主新配置。所查 `stop` 链也没有这些交还步骤。55毫秒音频自然播放完毕不等于AudioSession已交还。

## 对方案草稿的复核

已阅读主报告 `docs/audits/wcrefine-background-replacement-2026-11-13/README.md`。原生音频事实、55毫秒的宿主资源归属、没有循环/currentTime、无deactivate/快照恢复、ShouldResume缺口及helper checks的表述准确，未发现必须修正的事实。

推荐方案保留项目facade、Scene、音频所有权和宿主接管约束，同时采用短音频及余量检查，方向合理。自行构造等帧数全零音频属于工程设计，不是恢复到的原代码；应继续像草稿一样明确这一点，并以真机确认实际持续性。音频完成不应被旧无限循环语义认定为故障；租约仍持有也不能被当成持续后台执行能力。

本复核只覆盖保活主类及其直接host/other helpers。没有在这些检查范围内看到微信onlineMode / NewSyncService覆写；这不等于排除了整个44MB插件所有其他功能中的相关代码，也不能单凭保活替换承诺群拍同步交付改善。

