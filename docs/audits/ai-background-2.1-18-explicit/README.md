# 2.1-18：移除 45 秒兜底，仅由已验证的原生完整同步驱动

本轮在当前已交付的 2.1-17 工作区上修改，保留已有功能及未提交的前轮改动。不运行 `make clean`，不安装设备，不提交 GitHub，不访问真实 AI 接口、账号配置或用户数据库。双包与符号单独输出到 `packages/2.1-18-ai-background-explicit/`。

## 请求规则与防抖选择

**保留 45 秒最小请求间隔，完全删除调度器的定时器和重试队列。** 该数值沿用 2.1-17 的请求间隔，目的是在缺少真机调优数据时继续限制事件密集到来造成的额外请求；它现在仅约束两个由合格事件触发的请求尝试之间的距离，不是等待截止时间或兜底。

`refresh` 只启用观察资格，不请求。已验证、允许驱动的原生完成事件进入后，若从未尝试过，或距上一次事件请求尝试至少 45 秒，则先预留本次尝试，再调用原有账号 wrapper。45 秒内的事件直接消费，不排队，不设置 timer，不在第 45 秒补发；必须等到之后又出现一条有效事件才有下一次请求。忙碌、拒绝和异常也消费本次尝试，避免同一批事件立即重试。`stop` 和证据撤销不清除此限流记录，以免通过反复切换状态绕过最小间隔。

例如第 0 秒启用观察，没有事件时，即使经过 45 秒、90 秒或更久也没有请求；第 10 秒收到合格自然完成事件，可请求一次；第 20 秒再确认一个事件会被消费；第 55 秒仅时间经过仍不请求；只有第 55 秒或更晚再次出现合格事件才可请求。这里没有“到点自发请求”。

另外保留的另一个 **45 秒** 是观察器中排队原生结果的最大有效年龄 `CSAISyncQueuedResultMaxAge`，作用是丢弃过旧结果及倒退/非有限时钟。它不创建任何任务，与请求间隔独立，不是兜底计时。

## 行为变化与明确后果

删除兜底意味着：如果微信长时间没有完成一次可确认、可用于驱动的原生完整同步，插件将不再主动拉取，后台静默群消息可能明显延迟，或在持续后台期间收不到。仅开启 AI、免 @、群免打扰和后台运行不能消除这种停滞；系统挂起、网络故障或未知微信版本也不会触发插件补拉。这是用户明确选择的取舍，本版没有增加启动拉取、延时重试或定时补偿来绕过它。

为防止“插件请求完成 → 再发插件请求”的反馈循环，插件动态请求作用域内的完成仍被完整验证，但不能创建新请求。原生 `scene 12` 不是插件独有，未处于插件作用域的自然 scene 12 可按同样条件驱动。`scene 6` 为续页，无法单独证明其独立来源，因此所有 scene 6 终批仍完整验证并进入管理器终检，但不追加请求；这也会使自然多页同步的终批不追加请求。没有采用时间窗猜测来源，也没有增加无法证明关联的续页链状态。

观察器继续限定 **微信 8.0.78，且三个目标方法 ABI 全部匹配**。其他版本及未知身份无法取得确认，因而不发起插件额外同步。微信自身的同步与已有消息接收/自动回复入口继续运行。

## 保留的验证与身份绑定

三处原生 hook、参数/返回/异常保留规则均保留：

1. `creatPBNewSyncEvent:`：匹配具体服务、主线程和当前 epoch，原生受理后必须取得非零 event。
2. `MessageReturn:Event:`：在原方法清 event 之前核对同一服务和 event；具体 wrapper/request/response、CGI 138、请求 selector `0x40007`、终批 `ret == 0` 与 `continueFlag == 0` 均必须成立。
3. `HandleSyncResp:handleResult:`：实际处理成功，一次消费观察结果；原生正常返回后排到主队列收尾之后，再查无活动 event、未取数据、未操作、无错误/暂停/待同步且已初始化，并验证结果年龄、时钟和身份。

去掉初始兜底后，不能继续依赖“先发一次插件请求，才能绑定服务”。本版只读核验原始服务继承的 `MMBaseService.context`，要求服务未移除、context 是具体的有效用户 `MMContext`、它与 `currentContext` 和 `activeUserContext` 是同一对象，且用户名与管理器冻结账号一致。原生 getter 和管理器资格查询前后、原调用返回后及最终排队回调均复核身份/epoch。没有解开 wrapper，也没有绕过 wrapper 直接调用原始服务同步方法。

管理器保留 owner、弱 Store、配置对象身份、账号、epoch、配置 generation、实际资格及一次性消费；另冻结调度器的 contextGeneration，确保 stop→refresh 后旧证据不能复活。所有原生资格查询完成后才进入纯快照请求闭包。新 `allowsRequest:NO` 路径仍先完成管理器终检，再拒绝驱动请求。

[原有完整同步静态证据](../ai-background-2.1-17/native-static/report.md) 与 [本轮身份/来源证据](native-identity/report.md) 均仅限相同 SHA 的 8.0.78 静态目标。主机 fixture 与静态证据不能证明服务端每次下发所有静默群，也不能替代真机后台持续性验证。

## 改动清单

| 文件：方法/位置 | 改了什么 | 为什么 |
| --- | --- | --- |
| `Controllers/CSAIBackgroundSync.m:refresh/active` | active 独立于 timer；refresh 只设置观察运行状态 | 删除初次与到期主动同步，避免无 timer 时观察器无法捕获上下文 |
| `Controllers/CSAIBackgroundSync.m:verifiedFullSyncCompleted` | 仅真实合格事件直接尝试；45 秒最小间隔；重入保护；无延时队列 | 控制密集事件，不留下定时自发请求 |
| `Controllers/CSAIBackgroundSync.m:stop/invalidateVerifiedSync/contextGeneration` | 撤销证据 generation；不发请求、不安排任务 | 阻止停止、切号、配置变化后旧事件复活 |
| `Controllers/CSAIBackgroundSync.h` | 更新事件驱动契约并公开只读 contextGeneration | 使管理器独立核对观察会话生命周期 |
| `Controllers/CSAINativeSyncObserver.m:CSAISyncReadIdentity/CSAISyncCaptureServiceContext/CSAISyncAttachCreated` | 读取并重复核对 raw service 的账号 context；受理后绑定当前 epoch | 无初次兜底时安全观察自然同步，不靠全局账号字符串推测旧服务归属 |
| `Controllers/CSAINativeSyncObserver.m:CSAIInstallNativeSyncObserver` 中 `creatPBNewSyncEvent:`、`MessageReturn:Event:`、`HandleSyncResp:handleResult:` 的 replacement | 原三 hook 及完整判据保留；加入 `allowsRequest` 来源标记 | 插件同步和续页仅验证不驱动，避免反馈循环 |
| `Controllers/CSAINativeSyncObserver.m:排队完成 block` | 保留 45 秒结果 TTL 与异常时钟丢弃，重新确认 context | 结果时效保护与已删除的兜底彻底分开 |
| `Controllers/CSAIReplyManager.m:captureBackgroundSyncContextForEpoch:serviceAccount:` | 与真实服务账号匹配，冻结调度器 generation | 保留原身份终检，支持自然首次绑定 |
| `Controllers/CSAIReplyManager.m:nativeFullSyncCompletedWithContext:allowsRequest:` | 全部终检后再决定能否驱动请求 | 来源禁止不能绕开原校验，完成事件不能自行启用调度 |
| `Controllers/CSAIReplyManager.m:matchesBackgroundSyncContext:/requestBackgroundSync` | 加入 contextGeneration 栅栏，保留原 wrapper 与纯快照最终检查 | 防停止重启、getter 重入后调用旧账号 wrapper |
| `Tests/AIBackgroundSyncTests.m`、`Tests/AIReplyManagerTests.m`、`Tests/AINativeSyncObserverTests.m` | 删除兜底专用断言，改为无事件不请求、真实事件/来源/身份回归 | 测试与新行为对应，保留调用安全与账号隔离覆盖 |
| `control`、`Headers/CSUserInfoHelper.h`、`Controllers/CSReleaseNotesViewController.m` | 统一 2.1-18 和内置发布说明 | 明确移除兜底的功能与取舍 |
| `README.md`、`docs/features/ai-auto-reply.md`、`docs/features/ai-auto-reply-validation.md` | 更新安装包、当前规则与长时间不同步后果，旧验证记录明确为历史行为 | 使用说明不能继续承诺定期补拉 |

## 测试删改与覆盖边界

旧兜底的 timer 存在/有效性、3 秒 tolerance、手动/提前/陈旧 timer fire、错过周期不追补、`max(lastAttempt+45,lastVerifiedSync+45)` 截止、覆盖延期和短暂停止后保留覆盖等断言属于已删除行为，不能声称与新测试等价，也不会为这些语义留下替代用例。

仍需等价保留的安全含义是：未合格不请求，停止后事件不能重启，账号/epoch/Store/配置变化撤销证据，失败不能绕开请求限制，原生调用参数/返回/异常不变，重入/并发不重复或错投，时钟异常不创建请求。具体旧测试函数逐项去向见 [Scheduler 7 组迁移表](scheduler-review.md)、[Manager 迁移表](manager-review.md)、[Observer 旧覆盖映射](observer-test-change-map.md) 和 [独立观察器回归说明](observer-independent-review.md)。观察器原 11 组及 7 种 ABI 拒绝模式均保留；原未绑定服务负例明确改为缺失/错误 raw context 的拒绝，自然首次绑定另有正例，不能把旧绑定启动死锁当作保留功能。

Manager 的 60 秒连接测试超时 timer 属于独立功能，未删除；Coordinator 内既有消息处理时限和去重机制也未改变。本次删除限于后台同步兜底。

## 指定核心回归与双包核验

仅运行以下六套相关回归，未扩展到项目全量测试；均使用隔离临时目录、假账号/服务/时钟，未写用户真实数据。

| 回归脚本 | 2.1-17 基线检查数 | 本轮实际结果 | 记录 |
| --- | --- | --- | --- |
| `bash Tests/verify-ai-background-sync.sh --ios` | 78 | **72 通过**；arm64/arm64e 对象编译通过 | [scheduler.log](scheduler.log) |
| `bash Tests/verify-ai-manager.sh --ios` | 729 | **772 通过**；arm64/arm64e 对象编译通过 | [manager.log](manager.log) |
| `bash Tests/verify-ai-native-sync-observer.sh --ios` | 828 | **1,222 通过**（主进程 1,180 + 七种 ABI 各 6）；arm64/arm64e 对象编译通过 | [observer-independent.log](observer-independent.log) |
| `bash Tests/verify-ai-coordinator.sh` | 4,496 | **4,496 通过** | [coordinator.log](coordinator.log) |
| `bash Tests/verify-ai-native.sh` | 86 | **86 通过** | [ai-native.log](ai-native.log) |
| `bash Tests/verify-background-run.sh` | 186 | **186 通过**，宿主音频 hook 与音频文件检查通过 | [background-run.log](background-run.log) |

合计 6,834 个计数检查。计数包括重复循环及 fixture 断言，不表示这么多独立产品场景，也不等于覆盖率。三个改动模块的 iOS 源对象以 `-Wall -Wextra -Werror` 编译通过。主线程资格、同步重入及真实非主线程事件拒绝已有回归；自然服务原生身份、插件完成不自激、scene 6 不驱动、停止再启用旧上下文不可用均分别由对应模块验证。

源码/测试冻结记录为 [tested-source-sha256.json](tested-source-sha256.json)。完整双方案构建、解包核验与独立 SHA-256 校验均已通过。构建只使用各自全新的临时 `.theos` 目录，不运行 `make clean`，不覆盖工作区原 `.theos` 或历史包。构建前后生产输入哈希一致。

| 构建方案 | 结果 | 警告数 / 2.1-17 基线 | 构建日志 |
| --- | --- | --- | --- |
| Rootless | exit 0 | **6 / 6** | [build-rootless.log](build-rootless.log) |
| Rootful | exit 0 | **6 / 6** | [build-rootful.log](build-rootful.log) |

每个方案的 6 条警告均为既有的 `UILocalNotification` 弃用、`statusBarFrame` 弃用及链接器 `-multiply_defined is obsolete`，各双架构一次；未增加警告。完整机器记录见 [build-result.json](build-result.json)。

交付目录为 `packages/2.1-18-ai-background-explicit/`。两个包的版本均为 **2.1-18**，包内 dylib 均含 **arm64 + arm64e**，两个切片的最低 iOS 均为 **15.0**。注入 filter 与源文件一致，包内 payload 与本轮 staging 一致，所核验的既有功能符号保留。符号 ZIP 的 CRC 校验通过，包含两个方案、两个架构的四套 dSYM（共 12 个文件）。未安装到设备。

| 方案 | 安装包 | Debian Architecture | dylib 安装路径 |
| --- | --- | --- | --- |
| Rootless | [com.wechat.improve_2.1-18_iphoneos-arm64.deb](../../../packages/2.1-18-ai-background-explicit/com.wechat.improve_2.1-18_iphoneos-arm64.deb) | `iphoneos-arm64` | `/var/jb/Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib` |
| Rootful | [com.wechat.improve_2.1-18_iphoneos-arm.deb](../../../packages/2.1-18-ai-background-explicit/com.wechat.improve_2.1-18_iphoneos-arm.deb) | `iphoneos-arm` | `/Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib` |

包内二进制与 [symbols ZIP](../../../packages/2.1-18-ai-background-explicit/com.wechat.improve_2.1-18_symbols.zip) 中对应 dSYM 的 UUID 逐一匹配；ZIP 内 dSYM 路径前缀为 `<scheme>/<architecture>/WeChatImprove.dylib.dSYM/`。

| 方案 | 架构 | 二进制 / dSYM UUID |
| --- | --- | --- |
| Rootless | arm64 | `7CA2330D-8782-31C5-94EC-D087A2153009` |
| Rootless | arm64e | `886581B9-8296-3C4A-9A32-E1B35C1BBBD0` |
| Rootful | arm64 | `E0B5ADED-6D0A-3B6B-B86D-9724448D0D05` |
| Rootful | arm64e | `BE20AC45-F5AB-3228-A4E9-A24FD9F513EF` |

以下 SHA-256 已写入 [SHA256SUMS](../../../packages/2.1-18-ai-background-explicit/SHA256SUMS)，另行执行 `shasum -a 256 -c SHA256SUMS`，三个文件均返回 `OK`。

| 文件 | 字节数 | SHA-256 |
| --- | ---: | --- |
| `com.wechat.improve_2.1-18_iphoneos-arm64.deb` | 1,526,582 | `5a232df9ac36582ec18129d00b21430d2773393a6157c05f3bf7df9207c2e740` |
| `com.wechat.improve_2.1-18_iphoneos-arm.deb` | 1,528,322 | `5633a437c1198386dd84c3a980c93f2ed9f937cd7b12eda80ba01959b946e647` |
| `com.wechat.improve_2.1-18_symbols.zip` | 11,080,069 | `3720f22d1fe334e90e9eacff2f0e593290a3dd564ad53a85fa936c2942d9c899` |

完整包核验结果为 [package-verification.json](package-verification.json)，包括安装路径、版本、架构、最低 iOS、所保留符号、filter、staging 一致性和 UUID。构建与验包脚本分别为 [build-packages.py](build-packages.py) 和 [verify-packages.py](verify-packages.py)。

独立最终核对见 [final-verification.json](final-verification.json)：冻结的 10 个源码/测试文件、42,513 个构建输入、39 个原生身份审计文件均与清单一致，原有 `.theos` 和 `packages` 中记录的 1,271 个文件均未改变；构建输入范围没有新增或缺失文件。静态分析使用的原始微信目标 SHA-256 也保持一致。工作区开始时已存在的修改与历史缺失项未回滚或补写，本轮包产物仅写入独立交付目录。

## 真机验收步骤（尚未执行）

1. 记录现有设备、微信完整版本、账号及注入方案，安装匹配的 2.1-18 包，保留原配置与历史；重新进入微信后确认插件内版本为 2.1-18。优先使用 8.0.78；其他版本应观察到不产生插件额外同步。
2. 在一个已有测试群开启 AI、免 @ 和群免打扰，确认 AI 连接已验证、后台音频实际运行。保持原有账号与群配置，记录网络、锁屏和后台条件。不要把后台音频有效当作消息一定到达的证据。
3. 使用开发调试断点或调用栈计数区分微信自身同步与 `CSAIReplyManager requestBackgroundSync` 的插件请求。进入后台但没有可确认的完整同步时，等待多个 45 秒周期；插件额外请求计数必须保持零，不能因刷新设置、计时经过或恢复网络而凭空增加。
4. 让微信自然完成一次可确认的非续页完整同步，检查全部验证通过后最多追加一次。短时间多个有效事件不应连续追加；45 秒到点但没有新事件仍不能追加。插件自身同步完成、其多页续传完成也不能维持周期请求链。
5. **重点验收长时间不同步后的实际表现**：持续后台并确认期间没有可用于驱动的完整同步，再由另一账号向免打扰测试群发送带时间标记的普通消息，记录多久出现、是否回复，以及是否一直未收到。保留未收到/延迟的实际结果；不得用打开微信、切前台、反复改设置或手动刷新造成的新同步来替代这段等待的结果。之后再前台打开，单独记录是否补收及是否因超过 120 秒被拒绝回复。
6. 验证关闭 AI/免 @/后台运行、切前台或切换账号后停止追加；已有旧同步回调不能复活调度或投递到另一账号。保存配置与等值配置替换后旧证据同样无效。
7. 发起/接听语音或视频通话，检查音频让出与恢复、原生通话音频正常；对启用/未启用群、私聊、@ 规则、去重及 120 秒过期消息各作代表性验证。
8. 在相同设备、账号、网络和消息量条件下对照 2.1-17/2.1-18 的后台请求次数、延迟、Energy Log 和温度。报告实测值及收不到的样本，不用主机断言数量推算耗电或发热收益。
