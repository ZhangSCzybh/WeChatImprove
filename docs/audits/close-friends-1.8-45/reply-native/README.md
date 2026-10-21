# 挂断回复：原生发送契约与修复依据

目标是 WeChat 8.0.78 arm64，`/tmp/wechat-8.0.78-inset-analysis/WeChat`，SHA-256 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`。REA `open_binary` 核对了目标；此处复用已验证的 mmap Objective-C 元数据解析器和有界 `llvm-objdump`，仅读取指定四个类的相关方法。所有结论都是静态观察，未运行微信、未连接设备、未发送真实消息。`manifest.json` 保存方法/脚本/反汇编指纹；`methods.json` 保存真实类型编码和函数边界。

## 已确认根因

1.8-44 `CSCloseFriendCallReply.m` 将 `initWithMsgType:` 严格校验为 `@@:I`，实际为 **`@24@0:8q16`**（`long long`）。因此构造消息之前直接返回，`AddMsg` 根本没有被调用。这是发送失败的明确代码根因；现有证据不支持把它归因于 VoIP 房间销毁。

当前版本使用显式 `long long` 的原生 init-family 声明，让 ARC 处理初始化所有权。任务在拒接提交时复制账号、账号 epoch、来电人、通话身份和回复文案，之后不保留通话 token，也不依赖其 `native-ended` 状态或 VoIP 服务存活。

## 精确 ABI

| 方法 | 8.0.78 类型编码 | 用途 |
| --- | --- | --- |
| CMessageWrap `initWithMsgType:` | `@24@0:8q16` | 创建文本消息 |
| `setM_uiStatus:` / `setM_uiCreateTime:` | `v20@0:8I16` | 32 位状态、时间 |
| `m_uiMessageType` / `m_uiStatus` / `m_uiCreateTime` / `m_uiMesLocalID` | `I16@0:8` | 确认原文本记录身份和状态 |
| `m_n64MesSvrID` | `q16@0:8` | 已获服务端身份，禁止重发 |
| `m_nsFromUsr` / `m_nsToUsr` / `m_nsContent` | `@16@0:8` | 精确核对发送人、接收人、文案 |
| CMessageMgr `AddMsg:MsgWrap:` / `ModMsg:MsgWrap:` | `v32@0:8@16@24` | 新消息插入/原记录更新 |
| `GetMsg:LocalID:` | `@28@0:8@16I24` | 读取当前账号原记录 |
| `OnSendMessageSuccess:` / `OnSendMessageFail:` | `v24@0:8@16` | 唤醒观察器；回调只作为信号，不信任其旧状态 |
| SendMessageMgr `AddMsgToSendTable:MsgWrap:` | `v32@0:8@16@24` | 原 local ID 重新入队 |
| `CheckResend` / `SendMsg` | `v16@0:8` | 原生限频、登录和发送中保护 |

`ReSendMessage:MsgWrap:` 只在仓库头文件出现，本次目标的 CMessageMgr 实例/类方法中没有该 selector。`ResendMsg:MsgWrap:` 是另一条操作：复制消息，且普通路径可能删除原记录（`0x104b2f234–0x104b2f258`），不采用它作为保持原消息身份的重试。

## 发送、回执及重试依据

- `CMessageMgr--AddMsg_MsgWrap_.asm`：`0x104b2dd60–0x104b2dd90` 先调用原生存储并要求非零 local ID；`0x104b2e27c–0x104b2e2f0` 入 SendMessageMgr 队列并推进发送。该方法返回 void，不是送达回执。首次仅调用一次，之后不再创建另一条消息。
- `SendMessageEventHandler--OnProtocolResponse_shouldContinue_.asm`：单条服务端响应失败在 `0x105777c40–0x105777ca4` 设置 `status=5` 并更新对应 local ID，再异步通知 `OnSendMessageFail:`；成功在 `0x105777d60–0x105777d8c` 写服务端 ID、设置 `status=2`，随后持久化并通知成功。
- `SendMessageEventHandler--HandleSendFail.asm`：终止的连接失败同样写 `status=5` 到原记录（`0x105778500–0x105778560`）；`OnProtocolConnectFail:` 在原生 `canRetry` 为真时继续让原生处理，不提前判定失败。
- `SendMessageMgr--AddMsgToSendTable_MsgWrap_.asm`：要求原非零 local ID；复制原创建时间、文本、接收人及 local ID，`0x10577a08c–0x10577a0d8` 按 chat + local ID 删除重复队列项后保存。它不插入第二条聊天消息。
- `SendMessageEventHandler--LoadMsgFromDB.asm`：无 `m_firstSendMsgId` 时，`0x105779164–0x1057791b4` 用接收人、local ID、原创建时间生成客户端 ID。重试保持这些值，避免变成新的消息身份。
- `CMessageMgr--ModMsg_MsgWrap_.asm`：`0x104b2e380–0x104b2e3b4` 更新传入的原记录并发原生变更通知。重试只对精确身份且服务端 ID 为零、状态为 5 的本任务消息恢复状态 1，然后重新入队。这样旧失败回调和轮询不会把正在重试的一条消息再判成失败。
- `SendMessageMgr--MessageReturn_Event_.asm` 会清理已完成的 chat + local ID 队列项；回调后的重试延后 2 秒/8 秒，并在真正执行前再次读取原记录，避开原生当前回调栈及已成功的消息。

## 实现边界与验证

初次服务暂不可用时在入 `AddMsg` 前最多准备 4 次。准备失败释放活动任务，不占用同人 5 分钟名额；原生提交后保留同通话去重。每次重试都核对账号 epoch、当前账号、密友/拒接/回复开关，以及原记录的发送人、接收人、类型、内容、创建时间、local ID。

仅明确 `status=5` 且服务端 ID 为零的原消息最多自动重试 2 次。原生状态恢复后、入队前发生可确定失败或设置撤销时，重新核对同账号原记录并恢复状态 5；已经尝试入队而结果不明时不盲重发。原生成功/失败回调唤醒检查，同时有最长 120 秒的有限轮询兜底。状态 2 或非零服务端 ID 终止自动重试；失败上限保留原生失败行，允许用户手动重试。未知状态交由原生持久队列继续处理，不冒充已送达。

`Tests/CloseFriendCallReplyFixture.h` 使用真实 q/I ABI、分离的内存 DB 记录、虚拟时钟/队列，覆盖通话 token 销毁、服务延迟、同通话/同人去重、回调丢失、同 ID 失败重试、旧失败回调、延迟成功、账号/开关撤销、入队前异常恢复、缺失/变更记录和不确定 handoff。测试不会访问微信存储或网络。主机回归和编译只能验证此契约与状态机；网络恢复、对端实际收件、微信暂停/退出后的队列行为仍需真机复验。
