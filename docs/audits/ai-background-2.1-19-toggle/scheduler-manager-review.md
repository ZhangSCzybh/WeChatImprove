# 2.1-19 后台兜底补拉开关：Scheduler / Manager 审查

日期：2026-10-30。以本目录 `baseline` 中恢复后的 2.1-17 为改前证据，仅修改下表 7 个授权文件。未编辑 baseline、Observer、Hooks、Store、UI、版本或安装包。本轮测试使用临时可执行文件、临时配置文件、假账号/假服务/假网络 client；未启动微信或服务，未访问真实账号、消息、数据库或网络。

## 生产实现与原行为

`CSAIBackgroundSync` 仅新增 `fallbackEnabled` 属性，初始化为 YES。设为 NO 时同步调用原 `stop`，立即取消当前 timer、清空 timer 所有权并推进既有 generation，`active` 变为 NO；不清除 `attempted`、`lastAttempt` 或仍有效的完整同步覆盖。OFF 状态的 `refresh` 提前返回，原 `verifiedFullSyncCompleted` 因 running 为 NO 也直接返回，不查询资格、不记录覆盖、不排表。设为 YES 只改变属性，由既有 `refresh` 在资格成立时按当前 deadline 恢复，setter 本身不创建工作。

开启状态仍逐字保留原一次性 timer、45 秒间隔、3 秒 tolerance、`max(now, lastAttempt+45, lastVerifiedSync+45)`、错过时段不追赶、忙碌/拒绝/异常保留尝试预算，以及原 stale/early/reentrant timer 栅栏。直接 OFF→ON 不绕过已发生的请求冷却，也不更新关闭期间的完整同步覆盖。

Manager 在原 `reconcileBackgroundSyncContext` 读取当前配置后、snapshot 相同的早退前同步属性：`backgroundFallback` 缺键为 YES，显式值按 boolValue。ON setter 不起表，所以在快照发布和原账号/配置证据撤销前不会提前创建请求。现有 refresh、notify、上下文捕获/完成、配置保存成功/失败恢复都经过此协调入口。

`allowsBackgroundSync` 只增一个本地 false gate，位于原生账号、联系人、授权 getters 前。尚未协调的旧 timer 也不能越过显式关闭配置。原 wrapper、ABI、busy/异常保护和请求体纯快照终检不变；连接指纹、普通消息准入、120 秒历史消息边界、回复去重/发送保护、独立连接测试 60 秒超时不变。

实际保存开关仍走原配置保存流程。新的配置身份依旧撤销旧 context 与已验证覆盖，保存期间依旧停止调度器，不为开关绕过原证据规则。保存结束恢复的是 `lastAttempt+45` 与当前仍有效覆盖的 deadline；被旧配置撤销的覆盖不会被恢复。保存失败按仍实际保存的配置恢复开关：失败的 OFF 保存保持开启，失败的 ON 保存保持关闭。

未增加 2.1-18 的 public contextGeneration、serviceAccount/allowsRequest overload、raw service context 核验、scene-6 来源规则或无 timer 显式事件请求改造。Observer 与原生 Hook 保持 2.1-17。

## 原测试保留与新增场景

原 Scheduler 的 7 组用例及其原 main 调用完整保留；原 Manager 的所有测试和原 main 调用完整保留。验证方式为从当前测试文本中移除本轮新函数、两行新调用和新 math import 后，与 baseline 全文逐字节比较，结果一致。没有修改、删除或放宽任何旧断言。

| 新增测试函数 | 新增验证 |
| --- | --- |
| `FallbackToggleDeadlines` | Scheduler 默认 YES；初始 OFF 不排表且不读资格；ON setter 自身不启动；ON+refresh 启动；OFF 同步取消 timer；关闭态 refresh/verified/stale timer 不工作；直接切换保留有效覆盖与原 max deadline；45 秒尝试预算；反复赋值；超时后恢复单次请求；3 秒 tolerance。 |
| `FallbackToggleReentry` | eligibility getter、clock getter 和 synchronize callback 内 OFF 撤销当前 timer；关闭后回调不能继续；callback 内 OFF→ON+refresh 不能绕过已预留预算；45 秒前无新增尝试。 |
| `BackgroundFallbackConfiguration` | 真实旧配置缺键默认 YES；实际异步保存 OFF 立即停止并撤旧 context；OFF 多次 refresh/verified 不重启；关闭时原消息准入与假模型处理仍工作；实际异步保存 ON 按剩余冷却恢复；连接指纹和 verifiedConnection 不变；保存新配置撤销旧覆盖但保留尝试预算；两方向保存失败恢复仍持久化的状态；账号 Store 开关隔离与旧账号 context 拒绝。 |
| `BackgroundFallbackReentry` | 原联系人 getter、原生 busy getter、Observer request helper 内关闭，以及 helper 内 OFF→ON；旧 wrapper 不提交；旧 context 不记覆盖；边界前后是否已预留尝试预算的冷却差异；请求体仍无原生 getter。 |

新增辅助函数 `SyncDelayIs` 与 `SaveBackgroundFallback` 分别检查原 timer deadline 和实际异步保存。新消息 fixture 在注入 Coordinator 假时钟后调用既有 `configurationDidChange`，使原 admissionBoundary 与测试时钟一致；没有更改生产时间或准入规则。

## 最终验证

| 命令/检查 | 最终结果 |
| --- | --- |
| `bash Tests/verify-ai-background-sync.sh --ios` | **115 = 原 78 + 新增 37** 项通过；arm64 / arm64e 源对象编译通过；exit 0。 |
| `bash Tests/verify-ai-manager.sh --ios` | **850 = 原 729 + 新增 121** 项通过；arm64 / arm64e 源对象编译通过；exit 0。 |
| 两脚本 `bash -n` | 通过。 |
| 7 文件 `git diff --check` | 通过。 |
| 原测试内容与 baseline 比较 | 移除纯新增内容后逐字节一致。 |

最终日志是本目录 `scheduler.log` 与 `manager.log`。两个验证脚本在 2.1-17 原版中都没有硬编码期望项数，本轮依用户要求**新增**精确期望检查 115 / 850，并已用更新后的脚本重新跑完上述最终两套 `--ios`。检查数增加来自列出的新场景；没有用降低原期望数掩盖缺失测试。

## 改动文件与 SHA-256

| 文件 | 改前 SHA-256（baseline） | 改后 SHA-256 | 结论 |
| --- | --- | --- | --- |
| `Controllers/CSAIBackgroundSync.h` | `2dbfeed9f46dee8482475240a6777179e16f8cc4da9466ac6f0d71d8dab6bf16` | `3629c9c7ce4e3bba60a215fe0f1efbbb589dcaf5c27797e2ed9dd6888f09910e` | 仅新增 fallbackEnabled 可设置属性与契约注释。 |
| `Controllers/CSAIBackgroundSync.m` | `66c8b213863e88626975c16c41ba4a98280b0989e590e4c7b6cfc7bd200e0e0d` | `6b96295cdcfa0e9c103999a870fe351ca5a08875f6006146463f2ab65c3d0bed` | 默认 YES；OFF 调用原 stop；OFF 的 refresh 提前返回。 |
| `Controllers/CSAIReplyManager.m` | `3545484aefe47a85577a31b10b03957019b198d508abcababd89aed9d203020e` | `c73595a82766247707afe35e7fce42a607a222060f787775bf418944367af1ce` | reconcile 同步缺键 YES 开关；allowsBackgroundSync 增本地 false gate。 |
| `Tests/AIBackgroundSyncTests.m` | `969f941a831411f52a07cc03e30df823eeff118dc57f585987498dfc42b2c964` | `b160d9acf80104481094060d6332e8485dd4992464b7722461ec23b1b2e79905` | 保留原 78 项，新增两组开关测试，共 115 项。 |
| `Tests/AIReplyManagerTests.m` | `803b02ead4ff04d987a54f3efaeaf72e0824860fb91eec4a4ab8b9c34e3e067a` | `c3ba47c60049ea82b9dd577f5002cf7348f571516276c1d37fd903a30bfc21b0` | 保留原 729 项，新增配置保存、消息链路和开关重入测试，共 850 项。 |
| `Tests/verify-ai-background-sync.sh` | `8d6f0e6b83cab7a0d8f5defff478e040ba6c6fd8dd6758bf8915322d156a8e25` | `b2d551c7261911d2fa9aecc3de2056c0a4661d4d393fb882302d31b16b6d9ca4` | 原脚本没有硬编码项数；本轮新增实际 115 项的精确期望检查。 |
| `Tests/verify-ai-manager.sh` | `a44a73cae03d67d788e63ec44c04906c27da6488a5e33dd2f068a53ec0413749` | `fded93c17090a4931ce9c7040e47744fc80c6a33d7007d81bd309ee71251b15e` | 原脚本没有硬编码项数；本轮新增实际 850 项的精确期望检查。 |

生产/测试/脚本已冻结，后续完整构建、警告基线比较、版本、文档、安装包与总清单由 root 统一完成；此片段不声称完成真机后台消息必达或耗电测量。
