# 2.1-18 自然同步账号身份与 extra 来源的只读研究

日期：2026-10-30。目标为 `/tmp/wechat-8.0.78-inset-analysis/WeChat`，arm64 Mach-O，567,459,632 字节，SHA-256 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`。本目录复用既有 mmap 元数据解析方法，重新验证目标哈希并按 `LC_FUNCTION_STARTS` 限定提取 17 个方法；没有运行目标、附加进程、调用原生服务、接触真实账号数据库或进行大型逆向导入。这些文件是静态元数据与 LLVM 汇编证据，不是运行观察或 REA function Evidence。旧的 2.1-17 审计文件未修改。

## 结论与最小方案

移除 45 秒兜底后，不能继续依赖 2.1-17 的“插件 scene-12 请求先绑定 raw service，后续自然 create 才可捕获”路径：第一次插件请求已经被移除，自然 create 又因没有 bound epoch 而拒绝，形成无法启动的依赖。应在自然 `creatPBNewSyncEvent:` 的原调用之前，从该 raw service 自身的 `context` 证明账号身份，继续让实际 extra 请求经过原账号 wrapper 调用。无需添加全局 `MMServiceWrapper` hook，也无需 unwrap 或通过 raw service 发送同步。

最小身份条件为：具体 `NewSyncService`、已验证的继承 getter ABI、服务尚未移除；其 `context` 为具体 `MMContext`、是 user context 且非 invalid；context 与 `MMContext.activeUserContext` 和 `MMContext.currentContext` 为同一对象；context 的非空 `userName` 与 Manager 捕获的冻结账号一致。跨可能重入的 Manager / 原生 getter 后，重复复核同一 context、active/current identity、epoch 和账号。原有 context owner/store/configuration/generation、账号 epoch、资格查询及最终 Manager/scheduler 复核仍不可省略。

观察成功与允许创建 extra 必须分开。按本次选择的保守来源规则，插件动态 frame 内的所有 create，以及所有 scene 6 create，仍经过完整响应与最终 Manager 验证，但 `allowsRequest = NO`；仅不在插件 frame 中的非 scene 6 自然完整终批可以驱动 extra。这样避免插件自身请求的终批、或其 frame 退出后的 scene 6 续页终批再次驱动 extra。来源标志应随一次 observation 传递并一次消费，不能从回调时是否仍有 frame 反推。45 秒仅作为事件触发后的防抖间隔，不能由 refresh、时间流逝、失败或没有事件自行创建请求。

此选择会保守漏触发：自然多批同步最后通常以 scene 6 收尾，因此该完整终批也不会追加 extra；不修改原生同步或消息处理。静态证据不能在所有 scene 6 中独立区分自然续页与插件续页，选择不引入跨请求 chain provenance 状态。不能以 45 秒时间窗替代来源证明，也不能把所有 scene 12 都当成插件来源。

## 继承关系与 getter 证据

`hierarchies.json` 来自目标 class metadata，而不是 class-dump 声明：

`NewSyncService (0x1203859a8) → MMUserService (0x120649180) → MMBaseService (0x120649108) → NSObject`。

`HeadersFile/NewSyncService.h` 的 NSObject 父类声明不足以反映该目标的真实继承关系。目标中的 `MMBaseService.m_context` 为 `@"MMContext"`；元数据中的初始偏移 24 只用于证据定位，不能在生产中硬编码。NewSyncService 的本类方法中没有覆写 `context` 或 `isServiceRemoved`。

| 方法 | IMP / ABI | 已验证语义 |
| --- | --- | --- |
| `MMBaseService.context` | `0x1175dc8f8`, `@16@0:8` | `ldr x0,[x0,#0x18]` 后进入返回对象 thunk；读取所属 context，不查询全局账号 |
| `MMBaseService.isServiceRemoved` | `0x1175dc94c`, `B16@0:8` | 读取 base 的 removed BOOL 并返回；可拒绝同 context 中已移除的旧服务 |
| `MMContext.isUserContext` | `0x1175e3de8`, `B16@0:8` | context type 等于 2 |
| `MMContext.isInvalidContext` | `0x1175e3df8`, `B16@0:8` | context type 等于 0 |
| `MMContext.userName` | `0x1175e4054`, `@16@0:8` | 普通 context 在 `0x1175e40c8` 读取自己的 username；root/placeholder 分支会转向 active context，故先拒绝这类 context |
| `MMContext.activeUserContext` | `0x1175c4dfc`, `@16@0:8` | 委托 `MMContextManager.defaultManager.activeUserContext` |
| `MMContextManager.activeUserContext` | `0x1175e0330`, `@16@0:8` | 在锁辅助函数范围内读取 manager 的 active context 对象 |
| `MMContext.currentContext` | `0x1175c4c64`, `@16@0:8` | 优先任务/co-context/线程 context，只有 fallback 分支才取 active context；不能单独证明当前登录账号 |

`isUserContext` 与 `isInvalidContext` 仅是类型判断，不是登录状态。既有 `docs/evidence/message-actions-native-2026-10-17/ordinary-repeat-contracts.md` 已验证 logout 不清空 active context、不增加登录计数；因此本方案仍依赖插件既有 logout/epoch、backup ready/suspend 和 Manager 当前账号检查，不能用上述类型/指针条件替代它们。不同但同名的旧 context 应因 identity 不同而拒绝；只有 username 相等不够。

## wrapper 与同步来源证据

- `MMServiceWrapper` 实际继承 `NSProxy`。`initWithServiceObj:` 在 `0x1175fbe68` 保存底层 service。`forwardingTargetForSelector:` 在 `0x1175fc024..0x1175fc02c` 比较 fast current context 与 raw service 的 `m_context`，仅相同时返回 raw target。
- `forwardInvocation:` 在 `0x1175fc134` 读取 raw service 的 context，在 `0x1175fc14c` 调用 `MMContext.push:`，`0x1175fc160` 对 raw target 执行 invocation，随后 `0x1175fc174..0x1175fc184` 调用 pop。保留 wrapper 才保留原生账号切换语义；读取 context 用于身份检查不等于允许 raw 发请求。
- `BackGroundFetchToSync` 在 `0x1051825f4` 选择 `InternalCreateSync:`，在 `0x1051825fc` 传入 scene 12。这个 scene 不包含“由插件调用”的唯一标志；必须使用插件动态 frame 作为自身来源依据。
- `InternalCreateSync:` 在 `0x105181980..0x10518198c` 检查已有 event；已有 event 且 scene 12 时返回失败，其它 scene 可设置 need-sync。`0x105181ae4..0x105181af0` 才实际调用 `creatPBNewSyncEvent:`。因此 wrapper 的 BOOL 仍只表示请求阶段结果。
- `HandleSyncResp:handleResult:` 在 processed 成功、`NeedNewSync:` 为真且继续次数允许的路径，于 `0x105183108` 设置 need-sync，`0x105183120..0x105183124` 将后续 scene 设为 6；`0x105183388` 又明确判断 scene 6 并在结束后复位。scene 6 是续页的证据，不是独立自然请求来源的证据。
- 保留 2.1-17 的完整成功链：accepted create + 正 event；orig 前同 raw service / event / epoch 匹配；具体 wrapper、CGI 138、selector `0x40007`、ret 0、continue 0；processed YES；一次 token；orig 正常返回后异步主队列、完整 idle/初始化检查；最终 Manager 的 context/账号/资格/generation 检查。`allowsRequest:NO` 只限制副作用，不能绕过或简化该验证链。

## 验证边界与复现

具体类、ABI、线程、epoch、身份、event、response 或 idle 不符合时，仍应拒绝 extra；本次移除兜底后，拒绝意味着没有插件补拉。`queued completion age < 45 seconds` 是旧结果有效期门槛，应独立命名，不能误当成保留定时兜底。新版本主机、热修复、其它插件、离线、后台挂起和 off-main 回调覆盖均未运行验证。

复现：`python3 docs/audits/ai-background-2.1-18-explicit/native-identity/extract.py`。`manifest.json` 记录目标 SHA、限定方法地址、文件哈希；`.annotated.asm` 是直接 ADRP/load 注释辅助，没有完整控制流/寄存器数据流证明。结论应以元数据及具体原始指令为准。

## 最终实现的独立只读复审

2026-10-30 已复核下列源码快照，本轮自然 bootstrap、来源隔离与新增身份 getter 的重入检查顺序已收口；未发现阻止本次集成的剩余静态问题，审计范围冻结。

| 文件 | SHA-256 |
| --- | --- |
| `Controllers/CSAINativeSyncObserver.m` | `5b77491716de0d510e1a499b0b1b84a8de459061918536061e136865a178128b` |
| `Controllers/CSAINativeSyncObserver.h` | `28635b8bcf26777917a05e784c0bc782d8c34850b755a8407b20a70bd14aa8fb` |
| `Controllers/CSAIReplyManager.m` | `a3cadc594991f510f66919113d1909e0fd401759183e610db25e401b35aed33c` |
| `Controllers/CSAIReplyManager.h` | `a5c5cb75446c1a502b9c5efd07a7878317870e6eb7b7262c815969586b492ab9` |

Observer 仍只安装原有三个事务 hook，版本和三个 hook ABI gate 保留；新增身份读取均先检查具体类与各 getter 的原生 ABI。自然 create 可以独立通过 raw service 所属 context 与 active/current context 的身份、类型、removed 状态及冻结账号检查捕获 Manager context，不再依赖插件先发送请求。整个身份读取/Manager capture/二次身份与 epoch 检查受捕获递归保护，`@finally` 清除；插件 frame 仍保持 expectedEpoch、一次 claim、原 wrapper preflight context 和异常/嵌套恢复。

原 create 返回后的身份 getter 可能重入创建新事务，因此 `CSAISyncAttachCreated` 在 getter 后重新检查 epoch 与 observation association；只有仍为原事务、再次直接读取 event 也相等时才绑定。不会清除或覆盖重入安装的新 observation。最终主队列回调则在新增 identity getter 之后再次通过纯 ivar 读取检查 idle，避免 getter 已启动新同步但沿用之前 idle 的时间窗。原生 orig 调用仍处于观察 catch 外；原有响应、终批、处理结果、一次 token、FIFO 和完整 idle/初始化门槛保留。

`allowsRequest` 在 create 时由 `!frame && scene != 6` 冻结，随 observation 传到 Manager，覆盖插件 frame 内创建及 frame 退出后的 scene 6 续页。Manager 的新增 serviceAccount 参数复制并核对冻结账号；capture 与 completion 保留资格查询前后的 context 匹配，新增 scheduler context generation 约束。`allowsRequest:NO` 在一次消费和完整 Manager 终检之后返回，因此不绕过验证，也不能驱动下一次 extra；允许驱动时的 scheduler 最终资格复核仍受 verifying context 约束。queued result 的 45 秒上限已命名为 `CSAISyncQueuedResultMaxAge`，与请求节流/兜底语义分离。

本复审只修改本审计目录，没有修改生产文件。Observer/Manager 回归、双架构对象检查、完整构建与软件包验证由对应任务另行记录；本报告不代替这些检查，也不声称已验证真实设备后台行为。

冻结补记：Manager 后续仅将两处旧计时语义注释改为事件请求与无定时重试说明。已在内存中将这两条注释还原，所得完整文件 SHA-256 精确等于先前已审快照 `32babafe765c09c5df2a892d859220cf969907eecaec1f6b09d70ec270c2294d`，证明除此之外没有文件内容变化；未向生产文件写入还原结果。上表记录最终注释快照哈希，其余三个文件哈希不变，原复审结论保持有效。
