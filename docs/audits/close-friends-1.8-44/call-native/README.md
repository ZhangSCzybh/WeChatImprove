# 1.8-44 单人来电入口补查

目标为微信 8.0.78 arm64 解密可执行文件 `/tmp/wechat-8.0.78-inset-analysis/WeChat`，SHA-256 为 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`。REA 已绑定并关闭该目标；本目录仅记录 Objective-C 元数据解码和有地址边界的静态反汇编，没有启动微信、接打电话或发送消息。全部方法 ABI 见 [methods.json](methods.json)，片段范围/校验见 [manifest.json](manifest.json)。

## 原因与入口

1.8-43 仅拦截统一 `VoIPInvitationService` 及群聊 `MultiTalkMgr`。主 ilink 和旧版单聊各自有 `onMonoServiceMsgStartWithMsg:` → 类方法 `startVoipViewByVoipMonoMsg:` 的独立入口，能够直接创建音/视频窗口和本地通知，不要求经过统一邀请服务。

| 方法 | 8.0.78 实际 ABI | 证据地址 |
|---|---|---|
| `VoIPilinkMgr -onMonoServiceMsgHandleWithMsg:` | `B24@0:8@16` | `0x106267638` |
| `VoIPilinkMgr -onMonoServiceMsgStartWithMsg:` | `v24@0:8@16` | `0x106265788` |
| `VoIPilinkMgr +startVoipViewByVoipMonoMsg:` | `B24@0:8@16` | `0x106265ed4` |
| `VOIPMessageMgr -onMonoServiceMsgHandleWithMsg:` | `B24@0:8@16` | `0x105f7f37c` |
| `VOIPMessageMgr -onMonoServiceMsgStartWithMsg:` | `v24@0:8@16` | `0x105f7e988` |
| `VoIPInvitationInfo +infoWithVoipMonoMsg:scene:` | `@32@0:8@16Q24` | `0x10611f8cc`（1.8-42 证据复用） |
| `VoIPilinkMgr -rejectWithRoomID:` | `v24@0:8Q16` | `0x106255454` |
| `VoIPConfSDKService -hangup:roomID:` | `v28@0:8i16Q20` | `0x1060f6538`（1.8-42 证据复用） |
| `VoIPConfSDKService -currentStatus` | **`Q16@0:8`** | `0x1060e5d44` |

`VoIPilinkMgr` 更早的 `onStartRecvInvite:muteNotification:` / `onStartRecvInvite:inviteMsg:` 分别为 `v28@0:8@16B24` / `v32@0:8@16@24`。它们从 `ConfRecvInviteInfo` 生成 `VoipMonoMsg` 后入原生队列。`ConfRecvInviteInfo -voIPMonoMsgWithType:scene:` 把 `roomid` 同时传给 `m_roomId/m_roomKey`，把 `callerUsername` 传给 `m_fromUser`，设置 `isFromIlink=YES`。其 `roomType==1` 对应 `m_mode=0`；`VoipMonoMsg.isVideo` 以 `m_mode==0` 判断。实现直接用真实 `isVideo`，不混用不同类的 roomType 枚举。

## 生命周期与拒接边界

`MonoServiceMsgMgr -processInviteMsg:` 中，delegate Handle 返回 YES 后，原生添加历史、移除当前邀请并检查队列（`0x104cca3c4–0x104cca44c`，随后进入既有移除路径）。若走 Start，原生也在 `0x104cca48c–0x104cca4c8` 先添加历史并从队列移除，再于 `0x104cca640` 调用 delegate Start。因此在这两个 delegate 边界接管，不需要修改队列，也不应吞掉原生消息接收、取消或结束回调。

主 ilink 原生 `rejectWithRoomID:` 在 `isConnected==NO` 时，确定进入 `hangupWithRoomID:`；后者把原 roomID 和 reason=1 交给当前 context 的 `VoIPConfSDKService -hangup:roomID:`。它还会修改共享状态，所以新适配仅在未接通、当前房间为零或目标房间、没有普通 VoIP 窗口/活跃群通话/活跃子通话、SDK 非已连接状态时使用这条主路。已识别但不满足安全状态时只屏蔽展示，不谎称已提交拒接。

**两个具体状态核对：** `VoipUIManager -isVoipWorking`（`0x106395374`）只检查 `m_videoVoipCallerViewController`（offset 32）与 `m_videoVoipReceiverViewController`（offset 40）是否存在；早期 Handle 位于这些窗口对象创建前。`VoIPilinkMgr -reset` 清除 room、connected、changeToMultiTalk 等字段，却没有清除 `isCaller`。因此实现不把可能残留的 `isCaller` 当活动通话证据，回归包含上一通主叫结束后的新来电。

精确匹配的子通话继续走 `VoIPMPSubCallService -voIPInvitationServiceDidRejectWithInfo:`：执行前校验缓存 `inviteInfo` 的 roomID、caller、对象身份，再由原生 receiver 再次校验 room。没有调用不带目标约束的全局 `reject`。原生子服务 `clear` 的顺序疑点仍见 [1.8-42 报告](../../close-friends-1.8-42/alert-native-report.md)，本轮没有假称修复其内部实现。

旧单聊使用原生 `infoWithVoipMonoMsg:scene:` 构造完整 info，验证账号/邀请标识一致且非 ilink，再直接交给当前 `VOIPMessageMgr -voIPInvitationServiceDidRejectWithInfo:`。该方法的非 ilink 分支提交独立逐房间 CGI type=2，并保留原生通话气泡逻辑（详见 1.8-42 报告）；不改写当前 `VOIPMgr` component 的 room/key。同一已接通目标房间被排除。

每次显式原生拒接调用之后才将 token 推进至 `rejectionSubmitted` 并调用 `CSCFCallDidReject`。这表示提交原生请求，不表示收到服务端成功确认。纯展示屏蔽、不支持的路线、取消/过期、重复邀请和旧账号回调不会发起挂断回复。

## 验证边界

`Tests/CloseFriendIncomingCallFixture.h` 使用真实生产适配器，模拟上述两个 delegate 的输入和服务状态；没有网络发送。覆盖主 ilink 语音/视频、旧单聊逐房间拒接、子通话匹配/不匹配、已接通/普通通话保护、重复/取消/过期/账号切换、单独语音开关、解锁后的静默和旧 isCaller 状态。测试执行结果由本版总验收记录汇总。

静态结果证明已选择的应用内创建 UI/响铃入口在被接管邀请上不再执行；仍需真机确认前台/后台实际来电、后续普通来电及对端挂断表现。进程终止时 APNs、系统已先展示的 CallKit 或未覆盖版本不能由这些静态证据推出“系统零首帧”。

复现：从仓库根目录运行本目录的 `extract.py` 与 `disassemble.py`。早期 selector xrefs 是对三个目标 selector 的 `adrp x8` + `ldr x1,[x8,#offset]` 形式的限定搜索，仅据此选择四个 callback 片段；不宣称覆盖全部指令形式。
