# 语音播放控制：现项目设置与 Cell 接入只读分析

分析日期：2026-11-10。范围：当前 checkout 的设置、偏好、备份/重置、消息 cell 布局与手势；未修改生产源码、未构建、未操作用户偏好数据。私有播放 API 的实际 8.0.80 ABI 与语义须由本轮 IPA 分析确认，下列 class-dump 只作为线索。

## 最小设置方案

复用 `Controllers/CSVoiceForwardSettingsViewController.m`，保留现有“语音转发”“收藏语音转发”两项及其默认关闭/独立语义，在该页新增“播放控制”分组，包含两个独立开关：“语音倍速播放”“语音进度拖动”。倍速开启时默认 1.5 倍，进度关闭时不创建/显示交互控件。两项新开关也建议默认关闭，避免升级后改变既有播放行为。是否提供更多倍速档位由主任务根据用户原话决定；仅提供默认 1.5 倍无需额外持久化一个固定数值。

现页使用 `CSSettingItem +switchItemWithTitle:iconName:iconColor:switchValue:valueChangedBlock:` 和 `CSSettingSection +sectionWithHeader:items:`，无需新增设置 cell 类型。注意 `CSSettingItem -setDetail:` 对 switch 强制置 nil，1.5 倍解释应写在分组 footer 或普通说明条目，不能依赖开关 detail。当前 footer 硬编码 `section == 1`，新增分组必须改为清晰的实际分组位置，继续保留收藏转发操作说明。

主设置入口在 `Controllers/CSCustomViewController.m:829`，位于“功能增强”分组；路由 `:1099` 比较 `item.title == “语音转发”` 后实例化上述 VC。保持原入口名称时无需修改主设置；如果主任务选择更符合四项能力的“语音功能”名称，必须同步修改创建标题、路由条件与 VC.title，保留控制器类名可缩小范围。

## 偏好与备份/重置

当前语音转发偏好均在 `Controllers/CSMessageActionPreferences.h/.m`：

- `CSMessageActionVoiceForwardEnabledKey` → `com.wechat.enhance.voice_forward.enabled`。
- `CSMessageActionFavoriteVoiceForwardEnabledKey` → `com.wechat.enhance.voice_forward.favorite_enabled`。
- `CSActionBool` 对缺省键返回 NO；不可为了默认值调用 registerDefaults 后将既有值覆盖。
- `CSMessageActionSettings` 提供不可变快照，`hasSameValuesAs:` 决定是否增加 version 并通知。刷新经 NSUserDefaultsDidChange、Darwin 通知和 UIApplicationDidBecomeActive 三条路径，合并至主线程。
- `CSMessageActionVoiceForwardDarwinNotification` 为现有语音设置通知。

最少文件改动可在同一 preferences 增加两个 BOOL 常量/快照字段，并同步 `initWithDefaults:version:` 和 `hasSameValuesAs:`，设置页写入后沿用现有语音 Darwin 通知。建议新键使用 `com.wechat.enhance.voice_playback.speed_enabled` / `com.wechat.enhance.voice_playback.progress_enabled`，避免与转发开关键混淆。播放适配器只读这两个字段，不能把任一转发开关作为播放的前置条件。

如果主任务希望播放模块不依赖消息发送协调器，可单独建立 Foundation 的 CSVoicePlaybackPreferences，沿用上述不可变快照/合并刷新方式；它增加一个小文件，但不应为读取开关而初始化收藏转发、发送适配器或 message action coordinator。两种方案均可保持设置页复用。

`Controllers/CSBackupRegistry.m:230–231` 已登记两个转发键为 standard / message_actions / bool / global。新增两播放键按相同元数据登记即可。模块标题 `message_actions` 已存在，显示“消息操作”。`Controllers/CSBackupEngine.m:107` 从 allowlist 读取全部字段，`resetSnapshot:` (:416) 将字段转为 present:NO，所以新键进入 registry 即能参与导出、恢复与恢复默认，不应额外另写重置清单或直接删除整个偏好 domain。

保持收藏转发的 key、快照字段与 registry 条目不变。收藏适配器在 settings change 时仅当 favoriteVoiceForwardEnabled 关闭才取消；因此开启/关闭播放功能不得借机重置收藏开关或取消仍有效的收藏转发。

## Cell/UI 与手势边界

`Hooks/MessageGestureHooks.xm` 为 CommonMessageCellView + VoiceMessageCellView 安装统一生命周期；语音子类可能不调用 super，现有 CSMessageCellLifecycle 通过 layout/binding/reuse depth 保证最外层只执行一次。不要给新功能再建未经去重的并行 setViewModel/layoutSubviews 链。

`Controllers/CSMessageCellLifecycle.m` 的最终顺序为 native → time prepare → message merge render → clown render → gesture geometry refresh；播放进度控件应在最终几何确定后刷新。复用、model 替换、离屏、window=nil、切号时应撤销该 cell 的播放 UI/timer/拖动状态；复用后旧 seek completion 不得作用于新消息。

当前语音布局还被 `Hooks/BubbleStyleHooks.xm` 的 VoiceMessageCellView.layoutContentView / updateSecLabelColor 更新。CSBubbleStyleAdapter 按真实 VoiceMessageViewModel + type34 判断普通语音并拥有原生背景/秒数颜色。CSMessageMergeAdapter 识别 `m_playingImageView` 的原生发出方向镜像、译文/快捷转写按钮，并以子视图实际占位保护紧密布局。新增控件应放入确认的语音内容区域，使用其最终坐标，不修改原生 m_secLabel、m_playingImageView 的 frame/transform；否则容易影响已有紧密气泡及转文字布局。

最小交互建议：独立的 UISlider / UIControl 进度区域，拖动期间只更新本控件的进度/时间预览，结束时对仍在播放且绑定身份相同的消息提交一次 seek；取消只恢复显示。不要在整个语音气泡上叠加横向 UIPanGestureRecognizer。

原因：`Controllers/CSMessageGestureAdapter.m:114–131` 在 shouldReceiveTouch 中逐级检查 touch.view 祖先，遇 UIControl 立即 return NO；已有 `Tests/MessageGestureAdapterTests.m:112` 就有 control 触摸不得触发消息横滑的断言。UISlider 将天然让该命中区域交给控件；气泡剩余区域仍可保持原生点击、长按转发和配置的横滑操作。仍需针对原生 cell 上的 tap/long-press 验证是否会抢 slider 的拖动，不能仅凭此一条 admission 规则宣布所有手势兼容。

## 私有 API 线索（尚非本轮 8.0.80 验证）

`HeadersFile/VoiceMessageCellView.h` 包含 startPlaying / stopPlaying / onBeginPlayingMsg:autoPlayEnabled: / onEndPlayingMsg:autoPlayEnabled: / onWindowHide / getVoicePath / getMediaWrap，以及 m_secLabel、m_playingImageView、m_resumePlayButton 等 ivar。`HeadersFile/VoiceMessageViewModel.h` 有 isPlaying、voiceTimeLength、voiceTimeStirng、voiceNodeWidth/Height、canShowResumeButton。需要真实二进制核验后才可调用或 Hook。

`HeadersFile/AudioPlayerProtocol-Protocol.h` 的 setProgress:(unsigned int)、getCurrentTimeMs、currentTime、playAtTime:、asyncPlayAtTime: 是定位线索，单凭名字无法确定毫秒/秒/百分比单位；该旧协议没有倍速方法。SimpleCommonPlayer 持有 AVAudioPlayer 的事实也不能证明聊天语音走该播放器。不要 Hook 所有 AVAudioPlayer/setRate 或所有音频播放，避免扩散到音乐、短视频、电话、笔记与其他非聊天语音。

若复用 `CSMessageNativeSupports`，必须匹配已验证的实参/返回值编码，再做 typed invocation；速率浮点及 seek 时间单位不能用任意 KVC 或猜测型 objc_msgSend 处理。

## 建议核心回归

1. 偏好：缺省均关闭；四项语音开关相互独立；开启倍速仅将新播放/当前受管播放设为 1.5；关闭倍速恢复受管播放到 1.0；关闭进度只移除拖动能力。配置导入、domain 替换和 reset 删除键后都及时刷新；不会写入宿主消息/收藏文件。
2. 备份：两个 bool allowlist 条目元数据与默认值正确，YES/NO 接受、字符串/2 拒绝，导出/恢复/重置均覆盖新键并保留两转发键。可扩展现有 BackupRegistryTests 和 BackupResetTests。
3. 播放身份：开始/切换/结束、自动连播、停止后再播；旧 cell/model 的进度 tick 与 seek completion 不能碰新消息；进入后台/切号及时取消 UI 状态。
4. 进度：0、末尾、越界、NaN/Inf、零时长、未下载、无法 seek 播放器；统一单位并 clamp；拖动中系统 tick 不抢 thumb，结束只提交一次，取消不 seek，源语音时长与文件保持原值。
5. 手势与布局：UISlider 与消息横滑/原生点击/长按/列表纵向滚动/导航返回；收发方向、短/长语音、紧密合并开关、译文/快捷转写、深浅色、复用与离屏。确保只有一个控件和一个 timer，layout 不读 preferences 或访问服务。
6. 保留回归：Tests/verify-message-actions-core.sh、verify-message-gesture.sh、verify-message-time.sh、verify-message-merge.sh、verify-merge-bubble-integration.sh、verify-backup-registry.sh、verify-backup-reset.sh，以及 verify-favorite-voice-forward.sh、verify-favorite-voice-media.sh 和 verify-forward-selection-boundary.sh。以实际改动选择必要集合；不要无差别测试全部项目。

注意：verify-message-gesture.sh 与 verify-message-time.sh 直接链接 CSMessageCellLifecycle.m；若主任务在共享生命周期增加播放 API 调用，两个测试的 UIKit doubles/link inputs 必须一并调整。进度/倍速的新策略建议独立 Foundation 核心 + fake player 测试；UI 验证应提取真实 hook/adapter，避免只测试与生产流程无关的复制逻辑。
