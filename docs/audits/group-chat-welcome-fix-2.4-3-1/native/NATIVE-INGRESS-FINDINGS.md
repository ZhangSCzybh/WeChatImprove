# 2.4-3-1 入群欢迎：原生消息入口复核

本次仅离线读取用户指定的微信 8.0.80.34 arm64 主程序。目标 SHA-256 为 `1d626426df97058a8a87c661532b2801cd27b7d9fcc12e27609c751f5877b7ed`；IPA/提取身份沿用 `artifact-identity.json`。未连接真实账号、未运行微信、未执行入群/保存/退群，也没有修改生产源码。开发者反馈的“微信一直在前台但未发送欢迎”仍需在修复包上完成真实设备验证。

## 已观察到的入口与 ABI

| 类 | selector | 编码 | IMP |
|---|---|---|---|
| CMessageMgr | AsyncOnAddMsg:MsgWrap: | v32@0:8@16@24 | 0x104dd9d54 |
| CMessageMgr | onNewSyncAddMessage: | v24@0:8@16 | 0x104df0cf8 |
| CMessageWrap | m_uiMessageType | I16@0:8 | 0x104e68b6c |
| CMessageWrap | m_nsFromUsr | @16@0:8 | 0x104e68b38 |
| CMessageWrap | m_n64MesSvrID | q16@0:8 | 0x104e68b18 |
| CContactMgr | setContact:chatRoomMemList:isNotify: | B36@0:8@16@24B32 | 0x100c77bd0 |
| CContactMgr | setContact:nsAdminList:nsMemberList: | B40@0:8@16@24@32 | 0x100c77820 |
| SyncCmdHandler | BatchAddMsg:ShowPush: | B24@0:8B16B20 | 0x105e415ac |

完整相关类元数据保存在 `message-ingress-metadata.json`。m_n64MesSvrID 是 q（有符号 64 位），调用时保持原生 ABI；“非零”仅作为外部已分配消息 ID 的过滤条件。

## 同步消息到 AsyncOnAddMsg 的实际静态调用链

1. `SyncCmdHandler.BatchAddMsg:ShowPush:` 在 `0x105e433dc` / `0x105e433e0` 构造 invoke 地址为 `0x105e44154` 的 block；见 `SyncCmdHandler-BatchAddMsg_ShowPush_-annotated.asm`。
2. 该 block 遍历其捕获的接收通知列表，在 `0x105e44284` 加载 `onNewSyncAddMessage:`，在 `0x105e44304` 通过 `MMContext.callExtension:selector:block:` 分发原始列表元素。见 `SyncCmdHandler-onNewSyncAddMessage-containing-function-annotated.asm`。此地址是 block，不能把它当作 BatchAddMsg 方法自身的连续指令范围。
3. `CMessageMgr.onNewSyncAddMessage:` 在 `0x104df0d68` 读取 `m_bNew`；为假的消息会跳过新增通知。新消息的通用尾部在 `0x104df1448`–`0x104df1458` 调用 `AsyncOnAddMsg:MsgWrap:`，群/会话参数来自同一 wrap 的 `GetChatName`。文本/媒体类型有附加处理；在此通用尾部之前未观察到单独排除 10000 或 10002 的分支。见 `CMessageMgr-onNewSyncAddMessage_-annotated.asm`。
4. `AsyncOnAddMsg:MsgWrap:` 校验两个对象非空，打包会话和 wrap，使用 `performSelectorOnMainThread:withObject:waitUntilDone:NO` 调用 `MainThreadNotifyToExt:`。它没有自带“新人身份”或完整群名单判断。见 `CMessageMgr-AsyncOnAddMsg_MsgWrap_-annotated.asm`。

据此可将远端群系统消息作为“需要主动刷新群名单”的辅助信号。在 hook 中限定 type 为 10000/10002、serverID 非零、群 ID 为普通 @chatroom 且会话参数与 from/to 归属一致；随后进入既有完整名单请求与版本/成员身份一致性校验，仍由旧完整名单与新完整名单的差分决定是否欢迎。系统消息不直接等同于入群事件，不解析中文文案来构造新人。

以上是补充信号的设计建议；尚未用真实邀请/扫码/审批入群抓包证明所有场景都具有非零 serverID、同样的 from/to 归属或 10000/10002 类型。没有该辅助信号时仍保留原有原生联系人/完整名单回包入口。

## 联系人通知开关的边界

`CContactMgr.setContact:chatRoomMemList:isNotify:` 将 isNotify 保存在 done block 中；`0x100c77d48` 读取 flag，`0x100c77d4c` 与 1 比较，只有相等才在 `0x100c77d70` 调用 `internalModifyContact:CallExt:YES`。flag 不为 YES 时可以完成名单写入而跳过这条扩展通知，见 `CContactMgr-setContact_chatRoomMemList_isNotify_-annotated.asm`。

此处仅证明“普通联系人扩展通知不是所有名单写入路径的强制后置条件”。限定 ADRP x8 + LDR 的原始指令扫描只匹配到该 selector 的一个调用点 `0x102022710`，属于 `CGroupDB.QuitGroup:withUsrName:`，该点明确传 isNotify=YES（`0x102022720`），见 `CGroupDB-QuitGroup_withUsrName_-annotated.asm`。扫描不能覆盖其他寄存器、间接选择器调用、动态转发或服务器所有场景。因此不能把 flagNO 直接认定为这次真实新成员入群不发送的已证实根因。

## 已排除的 ABI 猜测

曾怀疑 protobuf 动态 getter 尚未解析会导致 `class_getInstanceMethod` 返回空。已使用独立 macOS Objective-C fixture 定义 `+resolveInstanceMethod:` 动态安装 getter，直接调用 `class_getInstanceMethod` 即观察到 resolver 执行并返回 Method。源文件与 stdout 保存在 `objc-dynamic-resolution-fixture.m`、`objc-dynamic-resolution-fixture-result.txt`。该结果排除了“class_getInstanceMethod 一定不触发动态解析”的一般性假设；不能以此为理由重写全局 ABI 适配器。它没有证明实际 iOS protobuf 对象的每个字段在设备上的 ABI/值均已匹配。

## 来源、范围与剩余未知

- REA 成功打开并核对上述主程序 SHA-256。一次 search_procedures 等待过久被取消，未以该未完成搜索作为结论证据；定点反汇编使用 `xcrun llvm-objdump`，元数据来自项目中已存在的只读 Mach-O reader。调查结束已调用 REA close_binary，返回成功。
- `additional-disassembly-commands.json` 保存后续定点反汇编命令；`assembly-ranges.json` 保存全部归档汇编的实际首末指令和 SHA-256。附近 llvm-objdump 导出符号标签不是 Objective-C 方法名称，方法身份以 class 元数据 IMP 为准。
- `selector-load-references.json` 仅是上述限定指令模式扫描结果，不是完整 xrefs，也不是运行时覆盖率证据。
- 系统消息辅助刷新是否在真实设备覆盖本次入群场景、hook 是否安装、完整名单响应是否通过每项校验、欢迎消息是否成功交由原生发送链，仍需设备日志/实际流程验证。静态分析不能声称已观察到发送成功。
