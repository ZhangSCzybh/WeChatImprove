# 8.0.78 普通同步完成信号的只读静态验证

日期：2026-10-29。目标为 `/tmp/wechat-8.0.78-inset-analysis/WeChat`，arm64 Mach-O，567,459,632 字节，SHA-256 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`。

本轮只读解析目标、提取限定地址的 LLVM 汇编，未运行微信、连接真机、附加进程、调用原生服务、写入账号数据或修改生产代码。REA 的 `binary_session` 确认没有已打开目标；同一目标既有审计已记录大型 Ghidra 导入成本及 datatype 冲突，本轮复用只读 mmap 元数据解析。输出是静态元数据/原始汇编证据，不冒充 REA `Evidence` 或运行验证。

## 可用于实现的结论

可建立一个保守的“同账号、已关联请求、普通 CGI 138 的终批命令处理成功”观察信号，并让它与约 45 秒兜底协同。不能把单条消息、`fetchsyncdone`、`onNewSyncFinish`、`onNewSyncEnd`、后台 fetch 的 BOOL 返回值或空闲状态单独当作完整成功。

推荐观察链为：

1. `creatPBNewSyncEvent:` 调用前捕获插件当前 account / account epoch / config / scheduler generation；原方法成功且返回后的 raw `NewSyncService.m_syncEventID != 0` 时，把该上下文与 event 关联到 raw self。
2. `MessageReturn:Event:` **调用原方法前**，核对 raw self、已关联 event、当前 event、epoch；只接受 `ProtobufCGIWrap`、`m_uiCgi == 138`、非 `m_uiMessage == 1`、`NewSyncRequest.selector == 0x40007` 及合法 `NewSyncResponse`。每次回调都消费原 transaction token；只给符合条件的 response 附上 token。
3. 在 `HandleSyncResp:handleResult:` 消费同一 response token，要求 `handleResult == YES`、`response.ret == 0`、`response.continueFlag == 0`。原生实际只检查低 3 位来决定续页；要求整个值为零是更保守的子集。
4. 原方法正常返回后，将最终健康发布异步排到主队列；在执行时再检查 epoch / account / config / generation、原 raw service 与 response，并确认原生初始化、无错误、未暂停且没有正在处理/请求/待续同步。任何不确定或不匹配均只保留兜底。

原生 `m_syncEventID` 由 raw self 维护。账号环境的 `serviceNamed:` 返回账号 wrapper，不能把 wrapper 当作 raw self，也不能为获得身份而自行 unwrap。全局 `MMContext.currentContext.userName` 非空只能说明当下有账号，不能证明旧响应归属；插件的 epoch 与事务关联仍是必要条件。

## ABI 与可读状态

这些值来自当前目标的 Objective-C method/ivar metadata，见 `methods.json` 和 `ivars.json`。

| 方法 | IMP | 编码 | 参数含义 |
| --- | --- | --- | --- |
| `creatPBNewSyncEvent:` | `0x105181b34` | `B20@0:8I16` | BOOL 返回，uint32 scene |
| `MessageReturn:Event:` | `0x105182ac4` | `v28@0:8@16I24` | object wrapper，uint32 Event |
| `HandleSyncResp:handleResult:` | `0x105182e7c` | `v28@0:8@16B24` | object response，BOOL processed result |
| `__handleNewSyncResponse:flag:beginTime:` | `0x105183d7c` | `v36@0:8@16I24Q28` | object response，uint32 flag，uint64 beginTime |
| `GetSelector` | `0x1051829f4` | `I16@0:8` | uint32 |
| `IsLastSyncFinishCallingExtension` | `0x105186350` | `B16@0:8` | 仅返回该状态位 |
| `+[CUtility NeedNewSync:]` | `0x116557f4c` | `B20@0:8I16` | `(flag & 7) != 0` |

| raw `NewSyncService` ivar | 本目标偏移 | 编码 | 保守完成过滤 |
| --- | --- | --- | --- |
| `m_bHasInit` | 8 | B | YES |
| `m_bSyncOpError` | 74 | B | NO |
| `m_bSyncOperating` | 75 | B | NO |
| `m_syncEventID` | 80 | I | 0 |
| `m_bIsSyncPause` | 84 | B | NO |
| `m_isGettingData` | 85 | B | NO |
| `m_bNeedSync` | 87 | B | NO |

偏移仅用于复核静态目标；生产必须按运行时 ivar 名称、类型、范围读取，不能复制硬编码偏移，也不能修改这些状态以强行制造完成。

## 请求与响应链的证据

`NewSyncService--creatPBNewSyncEvent_.annotated.asm`：

- `0x105181b80` 的 `mov w2, 7` 加 `0x105181b84` 的 `movk w2, 4, lsl #16` 为新建 `NewSyncRequest` 设置 `selector = 0x40007`。不是仅凭 header 为该常量命名。
- `0x105181ff8` 创建 `ProtobufCGIWrap`；`0x105182008` 设置 request；`0x105182020` 设置 CGI 138。
- `0x10518207c` 创建 event，`0x105182088` 将返回 eventID 写入 raw self，随后零值进入创建失败路径。方法 BOOL 只表示 event 创建成功，不能证明响应或处理成功。

`NewSyncService--MessageReturn_Event_.annotated.asm`：

- `0x105182b50` 在 CGI 138 分支立即将 `m_syncEventID` 清零。Event 匹配必须在 orig 前做；本方法未观察到先用 Event 与旧 eventID 比较再清零的保护。
- scene 12 的 `fetchsyncdone` 在 `0x105182c34` 发出，之后才检查 `m_uiMessage`。它不是成功凭据。
- `0x105182c4c` 比较 `m_uiMessage == 1`；该路径 reset getting、标记 extension 完成、调用 `onNewSyncOplogConnectFail` 并退出。
- 正常分支读取 `wrapper.m_oUserData.boolValue`、`wrapper.m_pbResponse`，在 `0x105182e24` 调用 `HandleSyncResp:handleResult:`。该 BOOL 不是简单的服务器 ret。

`NewSyncEventHandler--OnProtocolResponse_shouldContinue_.annotated.asm`：

- `0x10517cda8` 读取 `NewSyncResponse.ret`；0 进入允许处理路径。另有 `-2006` 也被允许处理，日志在 key block 明确标为 `MM_ERR_KEYBUF_INVALID`；健康观察应拒绝该修复路径。
- 非空 response 与 ret 检查通过后，`0x10517d330` 调用实际 `g_HandleSyncResponse`，其返回值在 `0x10517d4b8` 包装为 NSNumber，再在 `0x10517d4d0` 及后续调用存入 wrapper 的 `m_oUserData`。
- 这里使用的是 `NewSyncResponse.ret`，无 `baseResponse.ret` 访问。`NewSyncResponse` 的 protobuf 动态属性也与仓库 header 一致，但判定以实际调用为依据。

`bounded_function--response_processor.annotated.asm`（日志标识 `g_HandleSyncResponse`，`0x10517d528`）：

- `0x10517d688` 调用 `SyncCmdHandler.handleCmds:isFromPushData:showLocalPush:`，保存返回 BOOL；该值原样返回上游。
- `0x10517d6d4` 读 continueFlag，并调用 `NeedNewSync:`；`NewSyncInsertMsgEvent.isNewSyncEnd` 仅为其取反，不包含 processed BOOL，故通知也不足以单独证明成功。
- `0x10517d80c` 根据 processed BOOL 决定是否调度 key 保存；`0x10517d8a0` 的 chained bind 是 `__dispatch_main_q`，`0x10517d8a8` 调用异步调度 helper。
- `0x10517d934` 调度 `onNewSyncFinish` 位于成功与失败分支汇合点，并在每批调用。它不是 terminal 或 success 专用信号。
- `0x10517d9a0` 用 NeedNewSync 结果决定是否跳过 terminal status / end 工作。`status` 本身在此被记录和传递给 online status 扩展，不是成功返回码，不能要求 status 必须等于 0。

`NewSyncService--HandleSyncResp_handleResult_.annotated.asm`：

- 先核对当前 username 和 `m_bHasInit`。未初始化的早退会 reset getting，因此 `post isGettingData == NO` 不能独自证明方法走到正常处理结尾。
- `0x105183068` 写 `m_bSyncOpError = !processed`；`0x105183074` 清 `m_bSyncOperating`。
- processed 为真、低 3 位仍需同步、继续计数未超阈值时，设置 `m_bNeedSync` 并安排 scene 6；终批不能在这种情况下发布健康。
- 失败或继续计数耗尽后，即使低 3 位仍要求续页，也会在错误路径通过 `0x10518335c` 附近调用 `onNewSyncEnd`。终止不等于成功。
- `resetGettingData` 的独立实现只清 `m_isGettingData` 一位，不清错误、暂停、待续标志。

## DB 批处理、key 与扩展回调的排序

`SyncCmdHandler--handleCmds_isFromPushData_showLocalPush_.annotated.asm` 在 `0x105b3e590` 调 `HandleBatch:ShowPush:` 并传播其 BOOL。

`SyncCmdHandler--HandleBatch_ShowPush_.annotated.asm` 在 `0x105b3e86c` 调 `BatchAddMsg:ShowPush:`；失败时记录 `BatchAddMsg fail`；成功才继续联系人与群成员批处理，最后返回前者 BOOL。

`SyncCmdHandler--BatchAddMsg_ShowPush_.annotated.asm` 在 `0x105b3fea8` 一带为按数据库分组的任务建立 block，并调用 `dispatch_group_async`；`0x105b3fef8` 调 `dispatch_group_wait(group, -1)`，之后才读取汇总 BOOL。相关 thunk 已沿直接 branch 链解析，`bounded_function--batch_group_create/async/wait.annotated.asm` 证实系统 group create / async / wait 的具体绑定或 dlsym 名称。这说明原生 processed result 已等待这组 DB 任务返回；不等于证明磁盘介质 fsync 或所有之后的 UI/扩展任务已完成。

成功 processed 后，`bounded_function--response_key_store_block.annotated.asm` 在主队列执行 `MergeAndSaveSyncBuffer:`（ret 0 的分支）；KEYBUF_INVALID 分支用 `SaveSyncBuffer:`。随后保存 server sync uniq key，并异步通知 `onUpdateNewSyncBuffKey`。这些工作被排在上游 BOOL 返回之前，但不一定在 `HandleSyncResp` 进入或退出时已执行。

`bounded_function--queue_helper_thunk/queue_helper/queue_helper_impl.annotated.asm` 将原调用跟到最终包装器，其中动态解析字符串明确为 `dispatch_async`。该包装器对某些全局队列另走 `MMGlobalQueue`；当前调用传入的绑定明确为 main queue。按主队列异步串行语义，最终健康发布应再排一次主队列，处在原生已提交的主线程工作之后；仍须二次核对上下文及 idle。运行期热修复、其它 tweak、系统调度或原生内部二次异步不是静态审计能排除的变量。

`INewSyncExt` 的实际语义如下：

| 回调 | 已验证触发 | 不能单独说明什么 |
| --- | --- | --- |
| `onNewSyncBegin` | 正常请求 OnProtocolStart 中 scene != 6 时异步投主线程；push 处理也调用 | 未验证响应、成功或覆盖范围 |
| `onNewSyncStart` | g_HandleSyncResponse 进入消息命令处理前异步调用 | 未验证 DB 成功或终批 |
| `onNewSyncFinish` | 每批处理后成功/失败汇合处异步调用 | 不含成功/终批保证 |
| `onNewSyncEnd` | terminal status 主队列 block 调用；HandleSyncResp 续页失败/耗尽也调用 | 不含成功保证；terminal status block 也没有 processed 成功门控 |

`bounded_function--response_status_block.annotated.asm` 在 `0x10517df64` 调用 end；`bounded_function--response_end_block.annotated.asm` 的审计标签虽然含 end，实际函数在 `0x10517dfb0` 分发 plugin/oplog success/fail，不能按审计文件名推断 selector。

## 与当前生产观察器的只读比对

已只读核对 `Controllers/CSAINativeSyncObserver.m` 初版：3 个 hook 与 metadata ABI 一致；按 Event 在 orig 前关联；严格接受 selector 0x40007、ret 0、continue 0 和 processed YES；保留上下文/epoch 过滤；原生 orig 调用在观察逻辑 try/catch 外；完成后异步排主线程，校验完整 idle/初始化标志。该形状与上述证据相符。

具体类、版本、ABI、线程、event、response 或状态不符合时拒绝 co-op，均属于保守漏计成功：行为退回约 45 秒兜底。未发现需要阻止此形状集成的静态问题。本审计没有替代 manager/scheduler 的单元测试、构建检查或真机工作流验收。

## 证据边界

- `0x40007` 是本目标正常 CGI 同步构建时实际使用的 selector，且处理链确实进入 AddMsg/DB 批处理；本轮没有服务端实现、抓包或真机响应，不能由此声称服务端一定返回全部静默群/全部消息类别。生产中的 full-sync 命名应理解为这个被校验的普通请求与终批路径。
- 没有证明每次正常同步成功都会被当前仅主线程的观察器捕获，也没有证明所有后台回调均在主线程。保守拒绝后必须继续兜底。
- 没有量测真实耗电、续航、后台保活时长、服务器限流或成功率；45 秒是实现策略，不是 iOS 定时交付承诺。
- 只验证了上述 SHA 的 8.0.78 静态目标。主版本字符串、运行时 ABI 与 ivar 校验有助于拒绝未知目标，但不等于验证运行中镜像 SHA、微信热修复或其它注入插件。
- 原始 `.asm` 为机器指令证据；`.annotated.asm` 的 direct ADRP/load/string 注释只是阅读辅助，没有完整寄存器/控制流数据流分析，不能单独据注释证明跨分支调用参数。审计结论均核对相关原始参数设置和分支。

复现：`python3 docs/audits/ai-background-2.1-17/native-static/extract.py`。仅使用 `/usr/bin`/Xcode 的只读反汇编及 Python 解析；`manifest.json` 记录目标身份、限定方法范围、所有生成文件哈希与限制。

## 最终账号绑定与重入作用域复审

2026-10-29 对最终窄修完成独立只读复审，本轮账号绑定、嵌套、异常及请求前窗问题已收口。上文的“初版”比对保留为历史记录；最终实现以下列源码快照为准：

| 文件 | SHA-256 |
| --- | --- |
| `Controllers/CSAINativeSyncObserver.m` | `a27088eb7e788ed572498a82a8254d0636c9268ec7dd88c95ff6073923064455` |
| `Controllers/CSAINativeSyncObserver.h` | `50972613f5d454e82c073e9ca5e2dac69698807523fcdcf19147b7de5441a32e` |
| `Controllers/CSAIReplyManager.m` | `3545484aefe47a85577a31b10b03957019b198d508abcababd89aed9d203020e` |
| `Controllers/CSAIReplyManager.h` | `434c1520e967c6e989264b7ba028b598a0251cba0dbb435cab49ed3105de9025` |

- `CSAIObserveBackgroundSyncRequest(expectedEpoch, request)` 使用已保留账号 wrapper 时捕获的 epoch，不在作用域内重新选择当前账号。进入任何可能重入的资格 getter 之前先安装独立 frame，`@finally` 恢复上一层 frame；上下文捕获递归保护也在 `@finally` 清除。捕获期间不允许绑定原生 create。
- frame 的 `claimed` 在 orig 与其它可能重入的 getter 之前消费，一个请求作用域至多为一个具体 scene-12 create 提供账号上下文。只有 orig 接受、非零 event、epoch 未变且同一 observation 仍关联 raw service 时才完成绑定；同 service 嵌套创建的新 observation 不能被外层旧栈帧覆盖。orig 抛异常不执行 attach，也不吞掉原生异常。
- Manager 在 helper 之前完成完整的原生账号、联系人及授权资格查询。helper 返回到 request block 后，仅复核已捕获的 store / configuration / account / epoch / generation、scheduler active、保存中状态、backup 状态与前后台状态，然后直接 invoke 已保留的 wrapper；这里已移除 account/contact/authorization 原生查询，关闭 frame 可领取后被这些 getter 重入抢占的前窗。
- Manager 的 capture 与 completion API 在可能重入的资格查询前后复核上下文；completion 按 owner 与 consumed 限制一次消费。capture 资格失败时，仅在原 context 仍匹配时停止 scheduler，避免误停 getter 换入的新账号或新配置。scheduler 最终 eligibility 也受同一 context 约束，临时 verifying context 通过 `@finally` 恢复。

上述源码形状未再发现阻止本次集成的账号绑定或作用域问题，审计范围至此冻结。此结论是静态代码复审，不包含原生运行、真机后台行为、真实账号数据或耗电验证；Manager/Observer 回归与完整构建由相应任务另外记录，不由本报告代替。
