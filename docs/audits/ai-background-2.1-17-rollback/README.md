# 回退至 2.1-17：恢复 45 秒兜底

本次只执行回退，不新增功能、不出新包。项目 checkout 保持 `/Users/zhangshichao/Documents/Workspace/WeChatImprove`，未启动或切换服务、账号和数据库。所有恢复均直接读取 `../ai-background-2.1-18-explicit/baseline/` 的副本写回原目标，不凭记忆改写，不使用 Git reset/checkout 覆盖其它工作。

## 结论与证据等级

**有效源码、构建输入、版本、发布说明、当前使用文档及指定测试已恢复到 2.1-17，未保留 2.1-18 逻辑。** 全部 42,513 个生产输入与 2.1-17 构建前后哈希记录一致，范围内没有新增、缺失或变化。19 个恢复目标全部与 baseline 副本逐字节相同。

其中 **16 个文件有历史哈希依据，逐字节核对一致**。剩余 **3 个文件按用户明确授权接受 baseline 来源**，恢复后立即运行 scheduler 和 manager 的 `--ios` 验证，分别为 **78 / 729**，与 2.1-17 记录一致，满足本次授权要求的行为计数等价条件。这 3 个文件没有逐字节基准哈希，不能将其结论写成历史哈希核对通过；本报告对两类证据分别标记。

就本次回退所覆盖的交付源码、版本、使用文档和测试而言，相对 2.1-17 **无差异**；上述 3 个文件的结论采用用户认可的 baseline 来源加行为计数依据。此前 2.1-18 的审计记录与成品包作为历史记录保留。本轮新增内容仅位于本审计目录；完整编译产物位于隔离临时目录，没有覆盖工作区已有构建产物。

## 21 份副本与 19 个项目文件

baseline 中除 manifest 外共 21 份副本，实际映射到 19 个项目文件。以下两组为重复副本，内容及 SHA-256 完全一致，仅恢复对应的 Tests 目标，没有在项目根目录新增同名文件：

| 平铺副本路径（相对 baseline） | 相同副本路径（相对 baseline） | 实际项目目标 |
| --- | --- | --- |
| `AINativeSyncObserverTests.m` | `Tests/AINativeSyncObserverTests.m` | `Tests/AINativeSyncObserverTests.m` |
| `verify-ai-native-sync-observer.sh` | `Tests/verify-ai-native-sync-observer.sh` | `Tests/verify-ai-native-sync-observer.sh` |

[恢复前核对](preflight.json) 记录全部 21 份副本的实际哈希与映射；[恢复结果](restore-result.json) 记录 19 个目标的来源及恢复后实算值。

## 恢复的行为与范围

- `CSAIBackgroundSync.h/.m` 恢复一次性 timer、约 45 秒兜底、3 秒 tolerance、尝试预算/冷却，以及 `max(最近一次尝试 + 45 秒, 最近一次已验证完整同步 + 45 秒)` 截止计算。`verifiedFullSyncCompleted` 恢复为验证成功后延后兜底期限，不再采用 2.1-18 的事件请求最小间隔语义。对外契约没有 `contextGeneration`。
- `CSAINativeSyncObserver.h/.m` 恢复 2.1-17 的账号 wrapper 作用域绑定方式；撤除 `allowsRequest` 来源标记、scene 6 不驱动限制及 raw service context 只读身份核验分支。8.0.78、三个方法 ABI、事务/终批/处理/idle、账号/epoch、排队时效及异常时钟保护按原版恢复。
- `CSAIReplyManager.h/.m` 恢复原有公开接口和终检，撤除额外的 `contextGeneration` 栅栏、`serviceAccount` 新重载及 `allowsRequest` 新重载。`Hooks/AIReplyHooks.xm` 同样按副本恢复。
- 三套 scheduler / manager / observer 测试与三个 verify 脚本恢复副本内容，没有保留 2.1-18 删改后的断言。
- `control`、`Headers/CSUserInfoHelper.h` 和 `Controllers/CSReleaseNotesViewController.m` 恢复 2.1-17；内置发布说明不含 2.1-18 条目。`README.md`、`docs/features/ai-auto-reply.md`、`docs/features/ai-auto-reply-validation.md` 恢复约 45 秒兜底补拉表述。

## 逐文件核对表

A = **逐字节核对一致**：副本、恢复后文件及已记录哈希一致。baseline manifest 提供 14 个目标的记录，另外 `CSAIBackgroundSync.h/.m` 由 2.1-17 的构建前后记录交叉验证。有多处记录时全部相同，没有冲突。

B = **baseline 副本恢复 + 行为计数等价（78 / 729 与 2.1-17 记录一致）**：没有逐字节基准哈希，按用户授权采用此证据等级。恢复后实算 SHA-256 仅用于本次结果留档。

| 文件 | 回退后 SHA-256 | 2.1-17 / baseline manifest 记录值 | 依据 | 结论 |
| --- | --- | --- | --- | --- |
| `Tests/AINativeSyncObserverTests.m` | `3348612ecd78c8589a70384d6feef86d529dbee4882c3ef205dff5bafcd46978` | `3348612ecd78c8589a70384d6feef86d529dbee4882c3ef205dff5bafcd46978` | A：逐字节核对一致 | 通过 |
| `Controllers/CSAIBackgroundSync.h` | `2dbfeed9f46dee8482475240a6777179e16f8cc4da9466ac6f0d71d8dab6bf16` | `2dbfeed9f46dee8482475240a6777179e16f8cc4da9466ac6f0d71d8dab6bf16` | A：逐字节核对一致 | 通过 |
| `Controllers/CSAIBackgroundSync.m` | `66c8b213863e88626975c16c41ba4a98280b0989e590e4c7b6cfc7bd200e0e0d` | `66c8b213863e88626975c16c41ba4a98280b0989e590e4c7b6cfc7bd200e0e0d` | A：逐字节核对一致 | 通过 |
| `Controllers/CSAINativeSyncObserver.h` | `50972613f5d454e82c073e9ca5e2dac69698807523fcdcf19147b7de5441a32e` | `50972613f5d454e82c073e9ca5e2dac69698807523fcdcf19147b7de5441a32e` | A：逐字节核对一致 | 通过 |
| `Controllers/CSAINativeSyncObserver.m` | `a27088eb7e788ed572498a82a8254d0636c9268ec7dd88c95ff6073923064455` | `a27088eb7e788ed572498a82a8254d0636c9268ec7dd88c95ff6073923064455` | A：逐字节核对一致 | 通过 |
| `Controllers/CSAIReplyManager.h` | `434c1520e967c6e989264b7ba028b598a0251cba0dbb435cab49ed3105de9025` | `434c1520e967c6e989264b7ba028b598a0251cba0dbb435cab49ed3105de9025` | A：逐字节核对一致 | 通过 |
| `Controllers/CSAIReplyManager.m` | `3545484aefe47a85577a31b10b03957019b198d508abcababd89aed9d203020e` | `3545484aefe47a85577a31b10b03957019b198d508abcababd89aed9d203020e` | A：逐字节核对一致 | 通过 |
| `Controllers/CSReleaseNotesViewController.m` | `2a4bb551d70868b7329338552410b29c7ca556f7d0b909321073abbcbbf6da18` | `2a4bb551d70868b7329338552410b29c7ca556f7d0b909321073abbcbbf6da18` | A：逐字节核对一致 | 通过 |
| `Headers/CSUserInfoHelper.h` | `f91d0a63cc806e69508e2d738e917e07f6c5d1421bbd8c6e4cf58a647ec390bb` | `f91d0a63cc806e69508e2d738e917e07f6c5d1421bbd8c6e4cf58a647ec390bb` | A：逐字节核对一致 | 通过 |
| `Hooks/AIReplyHooks.xm` | `e9f3c8b37fa6d9adb4bda1caeb159dcc4fc90cf953af9bc8b69de327dc411b8a` | `e9f3c8b37fa6d9adb4bda1caeb159dcc4fc90cf953af9bc8b69de327dc411b8a` | A：逐字节核对一致 | 通过 |
| `README.md` | `4d8f93d8c116b8d54a9d94b18d0476206f46d9eaf1ba19d123c9ea4586bdca10` | `4d8f93d8c116b8d54a9d94b18d0476206f46d9eaf1ba19d123c9ea4586bdca10` | A：逐字节核对一致 | 通过 |
| `Tests/AIBackgroundSyncTests.m` | `969f941a831411f52a07cc03e30df823eeff118dc57f585987498dfc42b2c964` | 无逐字节基准哈希；按本次用户授权 | B：baseline 恢复 + 78 / 729 行为计数等价 | 通过 |
| `Tests/AIReplyManagerTests.m` | `803b02ead4ff04d987a54f3efaeaf72e0824860fb91eec4a4ab8b9c34e3e067a` | `803b02ead4ff04d987a54f3efaeaf72e0824860fb91eec4a4ab8b9c34e3e067a` | A：逐字节核对一致 | 通过 |
| `Tests/verify-ai-background-sync.sh` | `8d6f0e6b83cab7a0d8f5defff478e040ba6c6fd8dd6758bf8915322d156a8e25` | 无逐字节基准哈希；按本次用户授权 | B：baseline 恢复 + 78 / 729 行为计数等价 | 通过 |
| `Tests/verify-ai-manager.sh` | `a44a73cae03d67d788e63ec44c04906c27da6488a5e33dd2f068a53ec0413749` | 无逐字节基准哈希；按本次用户授权 | B：baseline 恢复 + 78 / 729 行为计数等价 | 通过 |
| `Tests/verify-ai-native-sync-observer.sh` | `8f78ada50875b4eb8a83a96e984e9dd9efd9f46335da931c06fef4d239e6f517` | `8f78ada50875b4eb8a83a96e984e9dd9efd9f46335da931c06fef4d239e6f517` | A：逐字节核对一致 | 通过 |
| `control` | `a7a58000074af6d0782a4d62454ff65ac53ebe9d3936553867d8cbf1f4785f6a` | `a7a58000074af6d0782a4d62454ff65ac53ebe9d3936553867d8cbf1f4785f6a` | A：逐字节核对一致 | 通过 |
| `docs/features/ai-auto-reply-validation.md` | `ff9f319b3515f10c6f2399499d0c510aa5339562a4183b601466b6a7486db028` | `ff9f319b3515f10c6f2399499d0c510aa5339562a4183b601466b6a7486db028` | A：逐字节核对一致 | 通过 |
| `docs/features/ai-auto-reply.md` | `9e4391adcac372797dd3fd6b3fb28de5b7ca403ffa631c9a758550c1a4313b3a` | `9e4391adcac372797dd3fd6b3fb28de5b7ca403ffa631c9a758550c1a4313b3a` | A：逐字节核对一致 | 通过 |

逐文件机器记录为 [file-verification.json](file-verification.json)，其中保留各记录来源，未为缺失文件补造历史哈希。

## 回归与一次编译

恢复后首先并行执行用户要求的两套独立 fixture，全部通过后才继续检查和完整编译。随后补跑恢复后的观察器回归，未跑项目全量测试。

| 验证命令 | 2.1-17 记录 | 本轮实际结果 | 日志 |
| --- | ---: | --- | --- |
| `bash Tests/verify-ai-background-sync.sh --ios` | 78 | **78 项通过**；arm64/arm64e 对象编译通过 | [scheduler.log](scheduler.log) |
| `bash Tests/verify-ai-manager.sh --ios` | 729 | **729 项通过**；arm64/arm64e 对象编译通过 | [manager.log](manager.log) |
| `bash Tests/verify-ai-native-sync-observer.sh --ios` | 828 | **828 项通过**（主进程 786 + 七种 ABI 各 6）；arm64/arm64e 对象编译通过 | [observer.log](observer.log) |

三个缺逐字节基准哈希文件与上述计数的关联是：scheduler 套件验证 `Tests/AIBackgroundSyncTests.m` 和 `Tests/verify-ai-background-sync.sh`；manager 套件验证 `Tests/verify-ai-manager.sh`，其测试主体另有历史哈希依据。计数一致仅按本次用户指定的验收条件确认为行为计数等价，不代表对缺失历史哈希的补证，也不代表对所有可能行为的穷尽证明。

完整 Rootless 编译仅执行 **一次 `make all`**，双架构 `arm64 arm64e`，保留原 `DEBUG=0`、`FINALPACKAGE=1` 及编译参数，不运行 `make package`、`make clean`、安装或签发新包。实际命令含隔离的 `_THEOS_LOCAL_DATA_DIR`、`THEOS_BUILD_DIR` 和 `THEOS_PACKAGE_DIR`，见 [build-command.json](build-command.json)。

结果：**exit 0，6 条警告，与 2.1-17 Rootless 的 6 条基线一致**。分别为 `UILocalNotification` 弃用两条、`statusBarFrame` 弃用两条、`-multiply_defined is obsolete` 两条；没有新增警告。实际合并 dylib 由 `xcrun lipo -archs` 确认含 arm64 和 arm64e。

构建日志为 [build-rootless.log](build-rootless.log)，机器结果为 [build-rootless-result.json](build-rootless-result.json)。隔离编译目录记录在 [build-directory.txt](build-directory.txt)，不是新交付包路径。

## 守恒与最终核验

- 本轮没有新增、覆盖、删除或移动 `packages/` 中任何文件；2.1-17、2.1-18 安装包和符号均保留。
- 原有 `.theos` 与 `packages` 的 **1,275 个文件**路径集合及 SHA-256 全部一致；未创建新包。
- 42,513 个生产输入与 2.1-17 记录完全一致；未修改其它生产输入。
- Tests、docs 和根 README 的前后文件集合相同（排除本审计目录），内容变化均属于上述 19 个授权目标；此前两轮审计记录未变。
- 恢复目标中的 `2.1-18`、`allowsRequest`、`contextGeneration`、新增身份分支与新事件间隔标记均无残留。
- 未切换 checkout、服务、账号或数据库，未执行真实微信或 AI 请求，未安装到设备。

根代理 [最终核验记录](final-verification.json) 与另一代理只读生成的 [独立核验记录](independent-verification.json) 均通过；[required-regression-result.json](required-regression-result.json) 记录用户要求的两项精确计数。原始前后快照同存于本目录，便于复核。
