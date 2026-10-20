# 密友适配原生证据（静态）

目标为已有留存的微信 8.0.78 arm64 Mach-O，SHA-256 为 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`。REA 已打开、确认目标并关闭，没有执行目标、连接手机或更改真实账号。Ghidra 完整自动分析对该 567 MB 文件并非本次所需；复用仓库已有只读 ObjC 元数据解析器，配合按函数边界限定的 `llvm-objdump`。这份证据不代表真机运行验证，也不证明其他版本兼容。

`extract.py` 读取真实类/元类方法列表，`methods.json` 保存 4,187 条方法的 selector、类型编码及地址。`disassemble.py` 对选定函数反汇编，单函数上限 16,000 字节；所有当前选定函数都未截断。`; selector` 注释是由本文件选择器指针解析得到的辅助标注，遇到其他数据可能显示无意义字符，不能把任意注释当成符号绑定。`manifest.json` 记录目标及脚本/输出摘要。

## 可以据此作出的实现决定

| 结论 | 静态位置 | 实现影响 |
|---|---|---|
| `ChangeNotifyStatus:withStatus:sync:` 的状态参数直接传入 `setContact:notifyOpen:sync:`，群分支转到独立接口；群接口把状态取反后传入 mute 语义接口 | `CContactMgr--ChangeNotifyStatus_withStatus_sync_.asm` 0x100fdb22c；`CContactMgr--ChangeNotifyStatusForChatRoom_withStatus_sync_.asm` 0x100fdb088 | 调用通知开启状态 `NO` 实现免打扰，不直接改联系人 bitmask；必须读回 `isChatStatusNotifyOpen` 并记录变更所有权 |
| 上述三个 setter 在样本中返回 `B`，两个状态参数也均为 `B` | `methods.json` 的 CContactMgr 方法条目 | 动态签名检查必须包含返回值，不能声明为 void 或按整数猜测 |
| 资料页局部 `isInMyContactList` 最终读取原生联系人关系；辅助对象在 `addMsgActionView` 和 `initFooterBtnArea` 内调用同名局部判断 | `ContactInfoViewController--isInMyContactList.asm` 0x100fb6bdc；`WeixinContactInfoAssist--addMsgActionView.asm` 0x10a94ba30；`WeixinContactInfoAssist--initFooterBtnArea.asm` 0x10a94fd64 | 可以在受保护资料实例的展示上下文适配；不能全局改 CContact.isMMContact 或删除实际好友 |
| `initFooterView` 会重建 footer 和 stack，再调用 `initFooterBtnArea` | `WeixinContactInfoAssist--initFooterView.asm` 0x10a950330 | 锁定/解锁和视图重建都应重做局部按钮投影，不能仅改一次按钮标题 |
| 样本先把 mono message 转成 invitation info，再调用 `handleInvitationInfo:withTalkingRoomID:talkingRoomKey:`；后者包含 showInWindow、scrollIn、本地通知和额外接听控制器路径 | `VoIPInvitationService--handleInviteMonoMsg_withTalkingRoomID_talkingRoomKey_.asm` 0x106120ffc；`VoIPInvitationService--handleInvitationInfo_withTalkingRoomID_talkingRoomKey_.asm` | 在具备完整 info 的邀请边界做身份判断，视图展示前做二次防御；不能只拦一个浮窗 |
| `rejectInvitationWithInfo:` 通知扩展；`rejectIfNeedAnimation:` 对当前 viewController 的 info 执行拒接、清理视图、置空并 reset | 相应同名 `.asm` 文件 | 必须区分指定邀请拒绝和清理当前通话；未确认同一 room/token 时不能调用全局当前通话清理 |
| `hangupManually:` 会停止铃声、清理超时块，再通知 delegate | `VoIPInvitationViewController--hangupManually_.asm` 0x106127f7c | 已创建视图的拒绝需要沿原生退出路径，不只是 hidden=YES |
| `MultiTalkMgr rejectCall:` 实际调用当前服务的 `hangup:YES`，传入对象不作为 room 参数 | `MultiTalkMgr--rejectCall_.asm` 0x104f38d8c | 不可在收到另一个邀请时盲目调用此接口，否则可能影响已进行的普通通话；应使用已确认 room 的拒接链路 |
| 旧头文件 `VoIPInvitationInfo.isVideo` 和 `infoWithMonoMsg:` 与样本方法列表不一致；样本使用 roomType、roomID、roomKey 及新的 info factory | `methods.json` 的 VoIPInvitationInfo 条目 | 只从已知类型与经验证字段取值；不能把缺失 isVideo 的 nil 自动解释为语音 |
| 旧头文件的 `MultiTalkMgr showMultiTalkBanner:group:roomId:roomKey:` 不在该类样本自身方法表 | `methods.json` 的 MultiTalkMgr 条目 | 作为旧版本候选探测；当前版本要核对邀请视图及 banner 链路，不得仅凭安装一个旧 selector 声称覆盖 |

## 尚需设备确认

免打扰本地/服务端同步及外部变更观察、资料页按钮样式与复用、邀请 roomType 语义和取消竞态、群通话状态、前后台与系统 CallKit 行为仍需要受控账号真机验收。方法存在和编码匹配只代表接口适配条件，不代表保护已验证。
