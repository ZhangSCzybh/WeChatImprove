# WeChat 8.0.80 普通聊天语音进度审计

本轮最终范围为普通聊天正在播放语音的进度显示和拖动定位，设置开关默认关闭。用户确认微信原生已有倍速功能，因此本轮不新增或改变倍速；目录中已留存的倍速反汇编仅供后续核查。

## 二进制身份与方法

- 原始 IPA：`/Users/zhangshichao/Downloads/Telegram Desktop/com.tencent.xin_8.0.80.ipa`。
- 复用已提取的薄 arm64 主程序：`/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat`。
- 主程序 SHA-256：`1d626426df97058a8a87c661532b2801cd27b7d9fcc12e27609c751f5877b7ed`。
- 本文地址为未加 ASLR slide 的 VM 地址，image base 为 `0x100000000`。
- 先用 REA 绑定同一主程序；大体量 `inspect_macho` 在 60 秒超时，没有完成该结果。随后使用仓库已有的 Objective-C 元数据解析器、`xcrun llvm-objdump` 和选择器/ivar 注释工具进行定点静态分析，没有运行微信、发送消息或更改真实用户数据。
- 元数据入口：`MsgPlayingFacade-metadata.json`、`facade-playing-controller-metadata.json`、`ui-voice-metadata.json`、`codec-button-init-metadata.json`、`annotator-metadata.json`。每个相关方法的原始和 `-annotated.asm` 文件均保留在本目录。

## 可直接使用的原生接口

微信原生聊天代码通过 `[MMContext.currentContext getService:MsgPlayingFacade.class]` 取得播放门面。对应 classref `0x11ed151f8` 解析为 `MsgPlayingFacade`，`0x11ed12780` 解析为 `MMContext`。

| 类 / selector | Objective-C 类型编码 | IMP | 语义 |
| --- | --- | --- | --- |
| `MsgPlayingFacade.currentPlayingMsg` | `@16@0:8` | `0x1050a6284` | 当前 `CMessageWrap`，转调 `PlayingController.currentPlayingMsg` |
| `MsgPlayingFacade.isMsgPlaying:` | `B24@0:8@16` | `0x1050a61ec` | 用消息身份判断是否处于当前播放状态 |
| `MsgPlayingFacade.isPlaying` | `B16@0:8` | `0x1050a626c` | 当前播放布尔值 |
| `MsgPlayingFacade.currentPlayTime` | `i16@0:8` | `0x1050a629c` | **有符号 32 位整数，单位毫秒** |
| `MsgPlayingFacade.seekToTime:` | `v20@0:8I16` | `0x1050a659c` | **无符号 32 位整数，单位毫秒** |
| `PlayingController.SeekVoiceMsg:toTime:` | `v28@0:8@16I24` | `0x10565c3f0` | 仅对当前正在播放且 `IsSameMsg:` 匹配的消息定位 |
| `AudioReceiver.getCurrentTimeMs` | `i16@0:8` | `0x1001772dc` | 转调当前 codec player |
| `AudioReceiver.setProgress:` | `v20@0:8I16` | `0x1001772f4` | 不改变单位，转调当前 codec player |

`currentPlayTime` 取 `MMContext` 的 `AudioReceiver` 服务并调用 `getCurrentTimeMs`，没有秒数换算。`seekToTime:` 取当前消息并调用 `SeekVoiceMsg:toTime:`，后者先检查 `m_bPlaying` 和 `[m_msgWrap IsSameMsg:argument]`，再将原始 uint32 参数传给 `AudioReceiver.setProgress:`。这些方法的调用方必须使用准确的整型 ABI，不能把返回值或定位参数声明成 `double`。

总时长来自当前 `messageWrap.m_uiVoiceTime`，单位毫秒。**不要使用 `VoiceMessageViewModel.voiceTimeLength` 作为时长**：尽管名字包含 TimeLength，该方法实际读取 `m_uiVoiceTime` 后通过 `message_node_voiceNode_min_width` / `rate` / `max_width` 等 CSS 值计算气泡宽度。证据为 `VoiceMessageViewModel-voiceTimeLength-annotated.asm`。

## 定位如何继续播放

原生链路为：

```text
MsgPlayingFacade.seekToTime:(uint32 milliseconds)
  -> PlayingController.SeekVoiceMsg:currentMsg toTime:milliseconds
  -> AudioReceiver.setProgress:milliseconds
  -> 当前 codec player.setProgress:milliseconds
```

| Codec | `setProgress:` IMP | 已观察到的行为 | 静态定位精度 |
| --- | --- | --- | --- |
| `SilkAudioPlayer` | `0x105cf4d10` | `mAqData+0x6d` 非零才调用 `setCurrentPacketWithTime:`；更新 packet/cursor、标志和 `mLastNumber=-1`；没有 stop 或重新创建播放器 | 输入毫秒除以 `100.0` 后向下取整，即 100 ms |
| `OpusAudioPlayer` | `0x105592ec0` | 与 Silk 相同的定位结构 | 100 ms |
| `AMRAudioPlayer` | `0x10001bbd0` | 调 `AudioQueueReset`，运行标志等于 1 时更新游标并按现有 3 个 buffer 重新填充 | 输入毫秒乘 `0x10624dd3` 再右移 38 位，即整秒截断 |
| `SPXAudioPlayer` | `0x1059774bc` | 与 AMR 相同的定位结构 | 整秒截断 |

`BaseAudioPlayer.setProgress:` 本身为空实现，但以上四个实际 codec 均覆盖它。只看到基类空实现不能推断聊天播放器不支持定位。

AMR/SPX 的 reset 入口已沿跳板和 GOT 独立解析：`0x107c2633c -> 0x10f85c5f8 -> 0x116e4df4c`，GOT `0x11d74b508` 的 chained import 为 `_AudioQueueReset`，详见 `seek-import-evidence.json`。

实现应在活动消息匹配且播放仍在进行时调用门面的原生定位。该链路不要求应用层先暂停、停止、重建播放器或再启动播放。Silk/Opus 修改读取游标后可能受已经入队的音频缓冲影响；精确听感延迟和边界行为仍需要真机验证，不能由静态代码保证立即跳转。

## 生命周期与消息身份

`AudioReceiver.StartPlay:Path:fromTime:` 根据 `CMessageWrap.getVoiceFormat` 选 AMR（0）、Silk（4）、Opus（7），其余走 SPX，并建立 `AudioPlayerUserData`，其中 `msgWrap` 是实际消息对象。播放器准备与启动为异步过程，所以该方法返回不能证明已经出声。

`audioPlayerDidStartPlaying:`（`0x100177b18`）先比较 `self.m_audioPlayer == callback player`，再从 `player.getUserData.msgWrap` 调 `notifyOnPlaying:success:YES`。暂停、停止、自然结束回调也先检查同一播放器对象，从而忽略旧播放器的迟到回调。停止广播 `isForceStop:YES`，自然结束广播 `isForceStop:NO`。

原生上层事件的消息参数均为 `CMessageWrap`：

- `MsgPlayingFacade.OnBeginPlaying:success:`：`v28@0:8@16B24`，IMP `0x1050a6fc8`；广播 `onBeginPlayingMsg:autoPlayEnabled:`。
- `MsgPlayingFacade.OnEndPlaying:isForceStop:`：`v28@0:8@16B24`，IMP `0x1050a722c`；广播 `onEndPlayingMsg:autoPlayEnabled:`。
- `MsgPlayingFacade.OnPausePlaying:`：`v24@0:8@16`，IMP `0x1050a7138`。
- `VoiceMessageCellView.onBeginPlayingMsg:autoPlayEnabled:`：`v28@0:8@16B24`，IMP `0x106586078`。
- `VoiceMessageCellView.onEndPlayingMsg:autoPlayEnabled:`：同编码，IMP `0x1065864d4`。

这些回调的首个参数不是 `NSNotification`，不能按 `notification.object` 读取。cell 原生实现用 `[self.viewModel.messageWrap IsSameMsg:callbackMsg]` 匹配。`VoiceMessageViewModel.isPlaying` 会在门面查询为否时退回 `_isPlaying` 标志，因此该 VM 值适合 UI 状态，不应单独作为定位目标的权威身份。

进度 UI 的实现约束由此得出：只在门面当前消息与 cell.messageWrap 匹配时显示/刷新；拖动开始记录当前消息身份；拖动结束再次检查当前消息相同且仍在播放，随后将 clamp 后的毫秒值传给 `seekToTime:`；切到另一条、结束、暂停、cell 复用或离开页面时解除拖动和刷新。连续读数取原生播放时间，拖动期间临时显示目标值，避免定时刷新抢占手指位置。这是实现建议，最后的 UI 生命周期需要结合父任务的 cell 审计与真机测试验证。

## 原生倍速的留存证据

`VoiceMessageCellView.layoutContentView` 在 `0x106572100` 无条件调用幂等的 `initPlayRateButton` 并将 `m_playRateButton` 加入 cell；按钮 ivar 偏移为 256，初始 hidden。`VoiceMessageViewModel.canShowPlayRateButton` 本体按至少 5 秒、非最小化、收到未读消息首次播放等条件判定，未见该方法或上述创建入口读取 AB 配置。

原生 `onClickPlayRateButton:` 调 VM `onClickPlayRate` 完成 1.0/1.5 切换，随后更新按钮标题、尺寸与语音长度。VM 的 `m_currentPlayRate` 是 offset 128 的 double，初始化和停止时均为 1.0。这里仅记录原生能力，最终进度功能无需修改该字段、按钮或倍率。

## 已回答与待验证

已回答：普通聊天门面取得路径、播放时间和定位参数 ABI/单位、真实消息身份、codec 定位与续播结构、原生回调参数类型，以及总时长的正确字段。以上均为同一 8.0.80 arm64 程序的静态元数据与反汇编证据。

未执行：iPhone 真机实际播放、拖动到开头/结尾、未完整下载语音、后台和路由中断、不同 codec 的听感定位延迟、多个 cell 复用场景。静态审计不替代这些运行时验收；本轮没有观察到实际 UI 或音频结果。
