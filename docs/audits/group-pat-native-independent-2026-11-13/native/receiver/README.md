# 微信 8.0.80 拍一拍原生接收链：独立静态证据

本目录来自本轮新提取的原生 IPA，不使用项目历史分析文档。所有地址都是下述 ARM64 Mach-O 的未滑动虚拟地址。该静态分析能够说明已接收消息的处理方式；不能证明微信服务器在后台、锁屏时一定下发了完整群拍 XML，也不能替代真机接收时序。

## 目标与方法

- IPA：`/Users/zhangshichao/Downloads/Telegram Desktop/com.tencent.xin_8.0.80.ipa`
- 包版本 / 构建：`8.0.80` / `8.0.80.34`
- ARM64 UUID：`7E4A8171-5ACC-3A72-A76A-3ACE52D3D895`
- 可执行文件 SHA256：`1d626426df97058a8a87c661532b2801cd27b7d9fcc12e27609c751f5877b7ed`
- 可执行文件加密标志：`cryptid = 0`
- `macho.py` 读取 Mach-O、chained fixups、Objective-C 方法表和函数边界，以 Capstone 反汇编；`methods.json` 保存对应 IMP 和 Objective-C 类型编码。

`macho.py` 内的寄存器传播注释只是线性提示，没有完整控制流数据分析。分支汇合、未建模写入和 W/X 寄存器别名可能产生残留注释。结论以实际指令、直接 selector 引用、字符串及手工核对的数据流为依据。

复现需要 Python 3 与 Capstone 5。本次临时依赖位于 `/private/tmp/wechat-native-deps-20261113`；脚本也可读取正常 Python 环境中安装的 Capstone。重新提取 IPA 后，运行 `python3 macho.py --binary /绝对路径/Payload/WeChat.app/WeChat SendPatMgr CMessageMgr SyncCmdHandler --out /绝对路径/输出目录`。可用 `--address 0x地址` 输出单个函数。

## 已接收群拍与私聊拍共享的处理链

1. `SyncCmdHandler.handleBatchMessages:isFromPushData:ShowPush:`，IMP `0x105e410d0`：遍历解码后的 wrapper，经 `processSpecialMessage:` 累积接收列表，并在 `0x105e41210–0x105e41220` 调用 `BatchAddMsg:ShowPush:`。
2. `SyncCmdHandler.BatchAddMsg:ShowPush:`，IMP `0x105e415ac`：在 `0x105e43480–0x105e4348c` 将通知 block `0x105e44154` 放到主队列。该 block 包含 `onNewSyncAddMessage:` 和 `onNewSyncNotAddDBMessage:` 的扩展分发；后者 selector 在 `0x105e4446c`，分发调用在 `0x105e444ec`。
3. `CMessageMgr.onNewSyncNotAddDBMessage:`，IMP `0x104df1718`：取得会话名，发出 `AsyncOnNotAddDBMessage:MsgWrap:`；在 `0x104df1790–0x104df17b0` 判断消息类型 `0x2712`（10002）并调用 `HandleSvrCmd:MsgWrap:`。此方法内未见群聊专属或前后台条件。
4. `CMessageMgr.HandleSvrCmd:MsgWrap:`，IMP `0x104def554`：解析 XML，在 `0x104defc50–0x104defcc0` 经 `MMContext.callExtension:selector:block:` 分发 `OnGetNewXmlMsg:Type:MsgWrap:`。转发 block `0x104defd94` 只取捕获参数后调用该 selector，没有计时器。
5. `SendPatMgr.OnGetNewXmlMsg:Type:MsgWrap:`，IMP `0x105a9bc80`：判断类型 `pat`，检查 `canSendPat`、撤回与重复 server ID，再解析 `fromusername`、`chatusername`、`pattedusername`、`template`，构造 `PatWrap`。在 `0x105a9c39c–0x105a9c3c0` 调用 `addPatWrap:toChat:newXMLMessageWrap:index:`。

在已核对的方法范围内，没有发现“群拍要等待回前台”或“锁屏时丢弃群拍”的直接分支。不能把这个局部结论扩大成上游推送、网络、进程调度和服务器下发均无差异。

## 真正可见的群聊 / 私聊差异

`SendPatMgr.OnGetNewXmlMsg:Type:MsgWrap:` 在 `0x105a9c1dc–0x105a9c254` 调用 `MMKernelUtil.IsChatRoom`。群聊保留 `chatusername`；私聊在发送者不是本人时把会话归一化到发送者。这里是会话归属差异，未见等待或后台判断。

`SendPatMgr.addPatWrap:toChat:newXMLMessageWrap:index:`，IMP `0x105a9a3e8`，类型编码 `I48@0:8@16@24@32^Q40`。在 `0x105a9a55c–0x105a9a5dc` 按群聊与私聊决定本地拍一拍展示消息的创建 / 合并方式。群聊可以把新拍合并到已有的 `patMessageWrap`，私聊路径倾向创建新的本地展示消息。该差异可以影响只盯着新增展示消息的插件入口；不能据此认定原始群拍没有到达。

`SendPatMgr.canSendPat`，IMP `0x105a93a7c`，读取 `MMConfigMgr.uintFromDynamicConfigForKey:defaultValue:` 的 `DisableSendPat`（默认 0），以配置值是否为 0 决定。它不是后台判断。

## 原生发送还存在另一层延迟

`SendPatMgr.sendPat:`，IMP `0x105a94098`，完成有效性、频率限制、suffix/template 和本地展示准备后，在 `0x105a94630–0x105a94640` 进入 `delaySendPat:`（撤回引导等分支另处理）。本方法内未见直接群聊 / 私聊或后台分支。

`patSendDelayInterval`，IMP `0x105a954a4`，从 `ExptService.getIntegerExpt:withDef:` 读取 `clicfg_pat_send_delay_interval`，默认值为 **5**。`delaySendPat:`，IMP `0x105a95548`，间隔非零时以该值建立 `MMTimer`，加入主 `NSRunLoop` common modes；为零时直接调用 `handleSendPat:`。suffix 异步取回也可能提前触发发送。

这是群聊和私聊共享的发送侧行为。它不能解释“群聊拍回复文字与回拍均延迟、私聊正常”的整体差异，也不能与项目自己的 10 秒补拉混为一谈。插件设置延迟为 0 不代表网络发送必然零延迟。

## 已排除的探索分支：cmd603 / BypChatRoomMgr

`SyncCmdHandler.handleCmds:isFromPushData:showLocalPush:` 在 `0x105e3fba4` 判断 cmd `0x25b`（603），解析 `BypChatRoomContact`，取得 `roomName`，在 `0x105e3fcd4–0x105e3fce0` 调用 `BypChatRoomMgr.startDerivedSyncForRoom:`。

进一步核对得到的是群成员同步链：

- `startDerivedSyncForRoom:`，IMP `0x1007a4df4`：已有 derived sync key 时把房间加入 pending 并调度；没有 key 时通过 `CContactMgr.botContactMgr.getContactsFromServer:scene:bizType:` 请求联系人，scene 为 1、bizType 为 `0x1b`。
- `scheduleDerivedSyncTimer`，IMP `0x1007a503c`：使用 `dispatch_after`，时间为 `500,000,000 ns`，即 **0.5 秒合批**。block `0x1007a50c8` 只调用 `flushDerivedSyncBatch`。
- `flushDerivedSyncBatch`，IMP `0x1007a50d8`：创建 `DerivedSyncKey`（instanceType 1、instanceId 为房间）、`DerivedSyncRequest`，通过 `EventService.CreateProtobufEvent:Flag:` 发 CGI `0x4904`，Flag 为 5。
- `onDerivedSyncResponse:`，IMP `0x1007a58c0`：在 `0x1007a5c90–0x1007a5cbc` 把返回 items 解码为 `BypChatRoomMemberData`，读取 `members`，调用 `updateBypMembers:members:derivedSyncKey:` 并通知 `onBypChatRoomMembersUpdated:`。此响应处理未见聊天 `CMessageWrap`、10002 或拍一拍分发。
- 该类只有 19 个实例方法，父类为 `MMUserService`，本二进制 Objective-C category 列表没有此类的类别。`onServiceInit` 只初始化 pending rooms、scheduled flag 和 index，未见直接生命周期注册。定时与 flush 本身未见 applicationState、锁屏判断。

因此不能把 cmd603 当作缺失的群拍后台接收链。本次证据支持它是成员 / 联系人同步。其继承服务上下文、共享网络机制及其他上游行为仍不由这项局部排除结论覆盖。

## 需要真机证据才能回答的问题

静态分析尚不能判定后台群拍是否随 native push 完整到达，还是只有通知 / 同步提示；也不能判定进程是否仍获 CPU 时间。若完整 wrapper 没有进入 `SyncCmdHandler`，修改 `SendPatMgr` 或本地展示回调无法凭空产生事件。若 wrapper 已进入而自动化未入队，则应以插件入口、过滤和去重的时序定位。需要区分这两种情况后，才能对“与私聊一样立即触发”作可验证承诺。
