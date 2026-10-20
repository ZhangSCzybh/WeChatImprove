# WeChat 8.0.78：密友来电拒接静态证据报告

本轮已经确认三类可区分的原生路线：旧版单聊邀请使用逐房间拒接请求；缓存中的 ilink／多人第二路邀请使用带房间匹配的 extension 回调；群聊主邀请另有 `MultiTalkReject:`，把传入房间原样交给 SDK。不能把所有入口统一成 `rejectInvitationWithInfo:`，也不能按 `roomType != 2` 全部当作语音。

## 范围与可信度

- 检查对象：`/tmp/wechat-8.0.78-inset-analysis/WeChat`，arm64 Mach-O。SHA-256：`0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`。
- 本轮只做只读二进制解析、Objective-C 方法／属性元数据扫描和有边界的反汇编；未执行目标、未接触设备或真实账号、未发起网络请求、未修改产品代码或原始证据。
- 复用根任务已确认的 Mach-O 解析器前缀与匹配目标的 class 地址清单。扫描 46,098 个 class 的 instance／metaclass 方法表，解析错误 0；不是全量 category、运行时动态注册或所有可达路径证明。
- 每个反汇编限制在 `LC_FUNCTION_STARTS` 的函数边界内，单函数上限 16,000 字节。最终文件清单、摘要、截断状态在 [manifest.json](alert-native/manifest.json)。
- `.asm` 的 `selector=...`、`class=...` 等是静态引用提示，脚本不是寄存器数据流分析器。结论依据邻近 `adrp`／`ldr` 与实际寄存器传参；C++ vtable 读处可能出现旧寄存器提示，不能把提示当成真实 selector。
- ABI、分支与调用参数属于静态已证实；拒接请求是否被服务端接受、并发队列顺序、所有版本／后台模式覆盖仍需真机验收。本报告中的“提交原生拒接”不等于“对端已收到拒接”。

## 邀请类型与身份

| 对象／字段 | 当前目标证据 | 实现含义 |
|---|---|---|
| `VoIPInvitationInfo.roomType` | `infoWithVoipMonoMsg:scene:` 用 `isVideo ? 2 : 1`，地址 `0x10611fa58–0x10611fa70` | 单聊语音 `1`，单聊视频 `2` |
| `VoipMonoMsg.isVideo` | `m_mode == 0`，`0x106375308`，编码 `B16@0:8` | 不可把 `m_mode == 0` 解释为语音 |
| 多人 `VoIPInvitationInfo.roomType` | `genVoIPInvitationInfoWithMsg:Scene:NeedReport:` 的 `MultiTalkMonoMsg` 分支固定填 `3`，`0x10616cc38` | `3` 是多人邀请类别，不能据此推导音频／视频 |
| 多人 `VoIPInvitationInfo.roomKey` | 同一构造分支明确填 `0` | 群聊不应套用单聊“roomKey 必须非零”的有效性规则 |
| 多人 `VoIPInvitationInfo.contact` | 用 `cache.inviteInfo.callerUsername` 查联系人 | contact 是邀请者；不是群聊身份 |
| `VoIPMtInviteMsg.wxGroupid/fromUsername` | 当前二进制 property 为 NSString，带 `D`；没有直接 getter IMP | 属性确实存在，但动态 getter 在调用前仍须核对运行时 signature |
| `MultiTalkMonoMsg.m_group` | 当前 property 类型是 `MMConfSDKMemberMgr *` | 比旧头文件的 `id` 更精确 |
| `MMConfSDKMemberMgr.mWxGroupId` | `@16@0:8`，`0x10291e188` | 微信群身份，应用于密友群匹配 |
| `MMConfSDKMemberMgr.mMultiTalkGroupId` | `@16@0:8`，`0x10291e174` | 通话会话身份，不能替代微信 chatroom username |
| `MMConfSDKMemberMgr.mroomid` | `q16@0:8`，`0x10291e154` | 有符号 64 位；与 `MultiTalkMonoMsg.roomID` 的 `Q16@0:8` 要分别做 ABI 检查 |
| `MultiTalkMonoMsg.m_fromUser/roomID` | 分别 `@16@0:8`、`Q16@0:8` | 可直接区分邀请者、目标通话房间 |

关键证据：[单聊类型构造](alert-native/VoIPInvitationInfo--class--infoWithVoipMonoMsg_scene_.asm#L107)、[isVideo](alert-native/VoipMonoMsg--instance--isVideo.asm#L10)、[多人构造](alert-native/VoIPMPSubCallService--instance--genVoIPInvitationInfoWithMsg_Scene_NeedReport_.asm#L558)、[当前属性元数据](alert-native/identity-properties.json)、[群身份方法](alert-native/group-identity-methods.json)。`identity-metadata.py` 可复现属性与全 class 方法匹配扫描。

策略层目前只有 `rejectsCaller:chatRoom:video:` 的 BOOL 参数，无法表示多人／未知类别。适配层至少应保留 `voice / video / multiTalk / unknown` 分类。只有已证实的单聊类型才转成 BOOL；多人不能静默落入语音分支。两项拒接开关同时开启时可明确制定“所有已识别密友来电”的多人策略；只开一项时，缺乏可靠媒体类型证据应记录能力缺口，不能猜测。`ConfRecvInviteInfo.roomType` 的 `I` 属性与外层 `VoIPInvitationInfo.roomType` 的 `Q` 属性也不能仅因同名就共享枚举。

## 拒接入口与普通在途通话保护

### 1. 旧版单聊：extension 到独立请求

`VoIPInvitationService -rejectInvitationWithInfo:`，`0x1061219ac`，编码 `v24@0:8@16`，调用 `callExtensionOnMainThread:selector:sync:block:`，`sync = YES`，广播 `voIPInvitationServiceDidRejectWithInfo:`。回调 block 在 `0x106121a8c`，把捕获的邀请 info 原样交给接收方。

当前 class 方法表发现三个接收者：`VOIPMessageMgr`、`MultiTalkMgr`、`VoIPMPSubCallService`。`MultiTalkMgr` 的对应方法只有 `ret`，并不拒接。`VOIPMessageMgr.init` 与 `VoIPMPSubCallService.init` 均明确向当前 `MMContext` 注册 `VoIPInvitationServiceExtension`；这确认原生注册代码存在，仍不代表任意进程时刻对象一定已初始化。

`VOIPMessageMgr -voIPInvitationServiceDidRejectWithInfo:`，`0x105f8bc0c`，编码 `v24@0:8@16`：

1. 如果 `info.isFromIlink == YES`，记录 “Failed to reject because it is ilink mode.” 并返回。
2. 否则从 info 取 `roomID`、`roomKey`、`contact`，调用 `CAppUtil +voIPRequestAnswerAboutRejectWithDelegate:roomID:roomKey:contact:forceToVoice:`，其中 `forceToVoice = NO`。
3. 后者调用通用请求，明确 `type = 2`；通用请求新建 `VoipAnswerReq`，填入所传房间、key、answer，创建 CGI 172 事件。检查到的函数没有重写正在使用的 `VOIPMgr` component room。
4. 原生回调还补写拒接消息气泡。不要为了隐私阻止该消息入库，应由显示过滤隐藏它。

证据：[原始广播](../../../docs/evidence/close-friends-native-2026-10-20/VoIPInvitationService--rejectInvitationWithInfo_.asm)、[回调](alert-native/VOIPMessageMgr--instance--voIPInvitationServiceDidRejectWithInfo_.asm#L76)、[逐房间请求](alert-native/CAppUtil--class--voIPRequestAnswerWithDelegate_roomID_roomKey_contact_forceToVoice_type_nicInfos_peerId_capInfo_.asm#L74)、[VOIP 注册](alert-native/VOIPMessageMgr--instance--init.asm#L66)、[子通话注册](alert-native/VoIPMPSubCallService--instance--init.asm#L81)。

**可用建议：** 对非 ilink 的有效单聊邀请，优先提交该高层 info 拒接，保留原生 delegate／气泡行为。调用前检查实例与真实编码、当前账号 epoch、当前策略、目标确为待接邀请，且不是已经接通的当前普通房间。

**明确禁用：** `VOIPMgr -Reject:withRoomId:andKey:`（`v40@0:8@16Q24q32`）先把所传房间和 key 写入当前 component，再发送 answer 2。它会改变现有组件身份，不能用于“普通通话进行中，拒绝新密友来电”的通用路径。[证据](alert-native/VOIPMgr--instance--Reject_withRoomId_andKey_.asm#L21)。`VoipUIManager` 同名封装的非 ilink 分支仍走此路径，不解决问题。

### 2. 缓存中的第二路邀请：匹配 room 后使用原生子通话选择

`VoIPMPSubCallService -voIPInvitationServiceDidRejectWithInfo:`，`0x106171484`，`v24@0:8@16`，先要求 `cache.inviteInfo` 非空，再要求 `info.roomID == cache.inviteInfo.roomid`，之后才调用 `self reject`；不匹配只记录日志。[比较与调用](alert-native/VoIPMPSubCallService--instance--voIPInvitationServiceDidRejectWithInfo_.asm#L87)。

`-reject`（`0x10616a730`）区分主通话是否活跃：`VoIPConfSDKService.currentStatus == 1`，或 `MultiTalkMgr.isMultiTalkConnected` 时，给下游 `hangup:1 isSubCall:YES`；否则给 NO。`MMConfSDKService`／`VoIPConfSDKService` 队列 block 把该 BOOL 交给 `MMConfSDKNativeEngine +hangup:isSubCall:`，最终走 C++ vtable `+0x60`，保留所传参数。

因此高层广播中的房间匹配，比直接调用 `sharedInstance reject` 多一层必要保护。实现仍须在执行前核对缓存与当前邀请一致，并在目标变更、账号切换、已接听或结束后撤销 token。不要把“有缓存”误认成“该缓存属于这个邀请”。

**未消除的静态疑点：** `-reject` 在 `0x10616ab4c` 先调用 `clear`，`clear` 的实现确实 `setCache:nil`，而后 `0x10616ab58` 又读 `cache.inviteType`，用 `== 3` 选择 `VoIPConfSDKService`，否则选 `MMConfSDKService`。按已见实现推导，清空后的读取会落入默认分支；这可能是原生代码路径特性或缺陷，本轮未运行目标，不能承诺其所有子通话类型均成功，也不能在插件中凭猜测修复原生顺序。见 [reject 顺序](alert-native/VoIPMPSubCallService--instance--reject.asm#L268)、[clear](alert-native/VoIPMPSubCallService--instance--clear.asm#L59)。这是第二路 ilink／多人验收的重点。

### 3. 群聊主邀请：有明确逐房间入口

`MultiTalkMgr -MultiTalkReject:`，`0x104f38dc4`，准确编码 **`v24@0:8Q16`**。传入 x2 保存到 x19，随后取得当前 context 的 `MMConfSDKService`，调用 `hangup:1 roomID:x19`。自身没有看到设置当前 room 或全局清理的行为。[入口证据](alert-native/MultiTalkMgr--instance--MultiTalkReject_.asm#L89)。

`MMConfSDKService -hangup:roomID:`，`0x10292f248`，**`v28@0:8i16Q20`**，将传入 roomID 捕获进服务队列 block。block `0x10292f3a4` 在服务对象仍存在且 reason != 10 时，把 reason 和同一 roomID 交给 `MMConfSDKNativeEngine +hangup:roomID:`；该 block 未见全局 session reset。[队列入口](alert-native/MMConfSDKService--instance--hangup_roomID_.asm#L60)、[block](alert-native/function-0x10292f3a4.asm#L16)。

`MMConfSDKNativeEngine +hangup:roomID:`，`0x10292030c`，**`i28@0:8i16Q20`**，检查 conf instance，空则返回 -1；非空把 reason 与 roomID 交给 C++ vtable `+0x68` 并返回结果。本轮没有追完整 C++ 实现，无法证明其内部所有房间、并发、对端语义。

**可用建议：** 将 `MultiTalkReject:` 作为有版本／ABI 门槛的群聊逐房间候选；目标来自有效 `MultiTalkMonoMsg.roomID`／一致的 `m_group.mroomid`，密友群身份来自 `m_group.mWxGroupId`，邀请者单独保留。先确认尚未接通且目标不是普通已接通房间，去重后提交。服务 API 是异步且 void，不能在调用返回时记录“拒接成功”。

**不要复用：** `MultiTalkMgr -onMonoServiceMsgRejectWithMsg:` 会在 2 秒后安排 `rejectCall:`；旧 `rejectCall:` 不保留精确房间参数。这种延迟会把原本属于旧邀请的操作带到新通话时间段，不能当成通用精准拒接适配器。原生入口检查的 `mMultiTalkGroupId` 也不是密友群的微信 username。[延迟调用证据](alert-native/MultiTalkMgr--instance--onMonoServiceMsgRejectWithMsg_.asm#L315)。

### 4. 主 ilink：现有方法有共享状态副作用

`VoIPilinkMgr -rejectWithRoomID:`（`0x106255454`，`v24@0:8Q16`）在未连接或目标等于当前 `mRoomId` 时调用 `hangupWithRoomID:`；若已连接且是另一个房间，则先 `VoIPInvitationService rejectWithRoomID:`，随后无房间参数调用 `VoIPMPSubCallService.sharedInstance reject`。后者必须依赖当前缓存，不能凭方法名安全调用。

`-hangupWithRoomID:`（`0x1062552a0`，同编码）虽然把指定 roomID 交给 `VoIPConfSDKService hangup:roomID:`，也会设置自身 `isAlreadyHangup = YES`，并在 `changeToMultiTalk` 时执行 `StopSession`。SDK 的该版本 block 还会清两处服务字段。因此“参数带 roomID”不保证对另一条普通通话完全无副作用。[共享标志与提交](alert-native/VoIPilinkMgr--instance--hangupWithRoomID_.asm#L36)、[StopSession](alert-native/VoIPilinkMgr--instance--hangupWithRoomID_.asm#L105)。

`VoIPInvitationService -rejectWithRoomID:` 只比对现有 `viewController.info.roomID` 再 `rejectIfNeedAnimation:NO`；没有创建 view 时，它不是新邀请的网络拒接入口。`rejectInvitationWithInfo:` 在 `isFromIlink == YES` 且无匹配 cache 时也缺少已证实的有效接收者（`VOIPMessageMgr` 返回、`MultiTalkMgr` no-op、子服务无缓存返回）。不要对这一路宣称已完成自动拒接。需补足其 pending 状态与主 ilink 生命周期验证后再启用，或明确将此路线标为未验证能力。

## 首帧前拦截位置

1. **统一邀请路线：** `VoIPInvitationService -handleInvitationInfo:withTalkingRoomID:talkingRoomKey:`，`0x106120688`，**`B40@0:8@16Q24Q32`**。原方法内创建 `VoIPInvitationViewController`，随后 `showInWindow`、`enterFloatWindowDirectly`／`scrollIn`，还可能发送本地通知与打开 CarPlay 收听界面。必须在 original 之前处理被策略接管的邀请；只在 `showInWindow` 后隐藏已经太晚。[窗口创建与副作用](alert-native/VoIPInvitationService--instance--handleInvitationInfo_withTalkingRoomID_talkingRoomKey_.asm#L122)。
2. 参数 `talkingRoomID/talkingRoomKey` 是已有主通话，不是新邀请目标。新邀请目标从 `info.roomID/roomKey` 读取。子服务调用点会明确先取当前主通话房间，再调用该方法。[调用证据](alert-native/VoIPMPSubCallService--instance--onMonoServiceMsgHandleWithMsg_.asm)。
3. BOOL 返回值被调用者作为“是否已处理”使用。政策接管且原生拒接路线已确认、已提交时，可返回 YES 防止原生 fallback 再弹 UI；需要把状态命名为“policy handled/requested”，不能当作服务端成功。路线不支持时不能虚构成功，也不要为了绕过 fallback 盲目挂断当前通话。通知静默与自动拒接是独立能力，需要各自的输出拦截和状态记录。
4. **群聊主路线：** `MultiTalkMgr -_onMonoServiceMsgStartWithMsg:`，`0x104f52754`，**`v24@0:8@16`**，独立创建 `m_mainWindow/mainViewController`，显示收听布局，播放铃声／震动，并选择 `VoIPPushKitNotifyService reportIncomingCallFromUser:ofType:withMsg:isPushKit:isMultitalk:` 或本地通知。统一邀请 hook 不能覆盖它。若用此入口，需在 original 前完成针对 incoming/cancel/type/room 的判定；不能只拦截它创建出的浮窗。[界面](alert-native/MultiTalkMgr--instance--_onMonoServiceMsgStartWithMsg_.asm#L525)、[铃声](alert-native/MultiTalkMgr--instance--_onMonoServiceMsgStartWithMsg_.asm#L589)、[系统上报](alert-native/MultiTalkMgr--instance--_onMonoServiceMsgStartWithMsg_.asm#L740)。
5. `MultiTalkMgr -onInviteMultiTalk:`（`0x104f3a030`，`v24@0:8@16`）从 group 对象构造 `MultiTalkMonoMsg`：room 来自 `mroomid`，`m_group` 保存原对象，`m_fromUser` 来自 `getInviteUserFromGroup:`。它是更早的消息排队路线，但有原生状态／同步行为，不宜仅因更早就整体吞掉。优先对明确 UI 启动边界做精确控制，并保留取消／结束消息。[构造证据](alert-native/MultiTalkMgr--instance--onInviteMultiTalk_.asm#L221)。

目前注入目标与本轮证据仍不能证明系统通知扩展、进程被终止时 APNs 展示、锁屏 CallKit 首帧或所有 CarPlay 流程完全受控。不能跳过 PushKit 必需 completion／系统生命周期来换取静默，也不能宣传所有系统场景零首帧。这个限制与应用内的已证实拦截点应分别展示。

## 适配器必须具备的状态与验收

- token 建议包含账号 ID／account epoch、call family、目标 roomID、可用的邀请 ID 或 msgKey；房间 ID 不是全局永久唯一键。旧邀请的 completion、延时 block 与账号切换不能消费新策略授权。
- 先验证 selector 与标准化 ABI，再取 identity；所有写动作提交前重新核对 epoch、当前策略、当前 pending room、未接通状态。`nil`／0／未知对象不按密友匹配。
- 分别记录 `unsupported / identified / requested / native-ended / failed`；void 返回仅可推进到 requested。token 的超时清理不能调用原生全局 reset，也不能撤销另一条普通通话的 UI、audio session 或 cache。
- 原生拒接气泡、取消／终止回调、消息存储及未读保留。对密友显示的隐藏与提示静默由策略层执行，解锁后仍保持用户要求的静默／独立拒接选项。
- 必验：普通语音接通中接到密友语音／视频；普通视频接通中接到密友群邀请；普通群通话接通中接到密友单聊／群邀请；同邀请重复投递与乱序取消；拒接队列提交后普通新来电立即到达；用户正好点击接听；账号切换后旧回调；缺失动态 accessor 或不匹配 ABI；仅开语音／仅开视频时遇到多人类型；拒接后下一个普通通话的弹窗、铃声、接听、结束全部正常。
- 本轮没有执行真机验收，未把以上静态结果计作设备功能通过。生产实现应保留按 call family 的能力状态，主 ilink 无匹配 cache 路线和子服务 clear 顺序是优先验证项。

## 限定补查：MMConfSDKService 能否替代主 ilink 拒接

**结论：目前不能证明安全替代，主 ilink 无匹配 cache 的自动拒接继续标为未适配。** 两个 SDK 封装最后使用同一个引擎 selector、保留相同 roomID，是必要线索；它不足以证明换服务／换工作队列后的状态和并发行为一致，更不足以保证另一条普通通话不受影响。本次按要求止于这一未知，没有扩展到全库查找或执行目标。

原生拒绝链的已证实条件如下：

```text
VoipUIManager Reject:withRoomId:andKey:isilink:YES
  → 当前 context 的 VoIPilinkMgr rejectWithRoomID:incomingRoomID
      ├─ !isConnected 或 incomingRoomID == mRoomId
      │   → hangupWithRoomID:incomingRoomID
      │      → isAlreadyHangup = YES
      │      → VoIPConfSDKService hangup:1 roomID:incomingRoomID
      │      → 若 changeToMultiTalk 则 StopSession
      └─ isConnected 且 incomingRoomID != mRoomId
          → VoIPInvitationService rejectWithRoomID:incomingRoomID
          → VoIPMPSubCallService.sharedInstance reject
```

UI 封装的准确编码为 `v44@0:8@16Q24q32B40`，`isilink` 分支在 `0x10639dc60`，roomID 原样传给 `VoIPilinkMgr` 的位置是 `0x10639dc98`。[UI 拒绝入口](alert-native/VoipUIManager--instance--Reject_withRoomId_andKey_isilink_.asm#L30)。随后 `isConnected` 分支和 `mRoomId` 比较在 `0x1062554c4–0x1062554e8`。[主／子路线选择](alert-native/VoIPilinkMgr--instance--rejectWithRoomID_.asm#L35)。这里没有原生“主 ilink 直接改走 MMConfSDKService”的分支。

作为同一 UI 层的旁证，`VoipUIManager -HangupWithRoomID:reason:`（`v32@0:8Q16q24`）在 ilink 分支先比较目标和 `VoIPilinkMgr.mRoomId`，不匹配仅走日志并返回；匹配才调用 `hangupWithRoomID:`。这说明此状态清理路径需要房间归属守卫，不能据函数参数存在就绕过守卫。`-OnHangup:` 只处理最近状态音频与统计，不是替代拒接入口。[归属比较](alert-native/VoipUIManager--instance--HangupWithRoomID_reason_.asm#L70)、[OnHangup](alert-native/VoipUIManager--instance--OnHangup_.asm)。

两条 SDK 路线的差异已经具体到当前二进制 ivar：

| 项目 | `VoIPConfSDKService`（主 ilink 原生调用） | `MMConfSDKService`（群聊原生调用） |
|---|---|---|
| 方法 ABI | `v28@0:8i16Q20` | `v28@0:8i16Q20` |
| 提交队列 | 从其实例 `_workerQueue` 取值，offset 8，ivar offset symbol `0x120237a08` | 从其实例 `_workerQueue` 取值，offset 16，ivar offset symbol `0x120201d00` |
| 捕获内容 | 原始 reason、原始 roomID、服务对象引用（执行时获取并判空） | 原始 reason、原始 roomID、服务对象引用（执行时获取并判空） |
| block 执行条件 | 服务仍存在；reason != 10 才调用引擎 | 服务仍存在；reason != 10 才调用引擎 |
| 引擎调用 | `MMConfSDKNativeEngine hangup:reason roomID:capturedRoomID` | 完全相同 selector 与捕获参数 |
| block 后续状态 | `_isCameraStarted = NO`、`_screenStatus = 0`（reason 10 也执行这两项） | 此 block 无对应清理 |
| 执行时重新核对 pending／已接通／账号 | 该 block 未见 | 该 block 未见 |

字段证据：[ilink-service-fields.json](alert-native/ilink-service-fields.json)。`_isCameraStarted` 位于 offset 355，`_screenStatus` 位于 offset 360；原报告中的“两处未知服务字段”现已明确。捕获证据：[VoIPConf 提交](alert-native/VoIPConfSDKService--instance--hangup_roomID_.asm#L89)、[其 block](alert-native/function-0x1060f6710.asm#L16)、[MMConf 提交](alert-native/MMConfSDKService--instance--hangup_roomID_.asm#L60)、[其 block](alert-native/function-0x10292f3a4.asm#L16)。不同实例字段不等于已证实两个队列必然不同；本轮也没有证据证明两者在运行时总是同一队列或拥有可互换的排序保证。

`MMConfSDKNativeEngine +getConfInst` 的返回类型确实是 `^{IWXConfService=^^?}16@0:8`，它把常数 `0x01352707` 交给一个 native helper；两个封装均通过此 selector 取引擎。[getConfInst](alert-native/MMConfSDKNativeEngine--class--getConfInst.asm)。后续 `hangup:roomID:` 仍止于 `IWXConfService` 的 vtable `+0x68`：reason 与 roomID 被保留，但没有这段 C++ 实现的房间定位、主／子通话匹配、失效 ID 处理和回调效果证据。不能由共用入口推出线程上下文相同，不能由有 roomID 推出其他通话完全不受影响。

最安全的现阶段实现策略是：

1. 将有身份、策略要求拒接、但主 ilink 无匹配 cache 的邀请标记为 `identified + rejectionUnsupported`；不调用 `MMConfSDKService` 作主 ilink 兜底，也不调用当前通话的全局 hangup/reset/StopSession。
2. 对已确认密友身份执行已经授权的应用内提示／来电 UI 静默。语音、视频两项同时开启时仍不能把“所有类型均要求拒接”当作“所有拒接路线已验证”。未知媒体类型也不阻止身份明确后的静默策略，但不能猜测某个单独拒接开关。
3. 在明确的 UI 边界可记为 `presentationSuppressed`；如果 BOOL 返回 YES 用于避免展示 fallback，这个 YES 只表示展示已被策略接管，不能推进到 `rejectionRequested/rejected`。保留原生收包、取消／结束回调、超时清理与系统必需 completion，避免创建虚假的网络成功状态。
4. 如果某入口把不可跳过的 call state 初始化与 UI 展示混在一起，只过滤有身份的展示／声音输出，不整段吞掉该入口。实际 CallKit 上报生命周期继续遵守系统要求，系统首帧覆盖维持未验证。
5. 拒接适配完成的上线门槛是：主 ilink pending 邀请精确匹配；普通单聊／普通群通话存在时目标不受损；调用排队后目标取消、接听或普通新来电先到时无误杀；摄像头、屏幕共享、后续普通通话状态正确。仅加 `incomingRoomID != activeRoomID` 的调用前检查，还不足以替代队列执行时与 C++ 语义验证。
