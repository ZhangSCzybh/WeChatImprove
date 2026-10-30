# 2.1-19：后台兜底补拉开关

本轮以当前已回退的 2.1-17 工作树为起点，只增加一个账号配置开关 `backgroundFallback`。未切换 checkout、服务、账号或数据库，未执行真实微信/模型请求、未安装设备；未运行 `make clean`，未改写历史包或历史审计。

## 设置路径、文案与存储

路径：**插件设置 → 功能增强 → 人工智能（AI 自动回复）→ 功能 → 后台兜底补拉**。开关紧跟“启用 AI 自动回复”，使用原 `switchItemWithTitle:`、`arrow.clockwise` 图标和现有 `save:` 异步账号保存路径。

“功能”分组原 footer 完整保留，并在原文后追加：

> 后台兜底补拉：默认开启，满足后台运行和 AI 条件时，以约 45 秒为兜底期限尝试补拉会话；已验证的完整同步会顺延下一次补拉。适合免打扰群的后台自动回复；会周期性唤醒网络，收到符合规则的消息后还可能触发模型请求，存在额外耗电。关闭后仅依靠微信自身事件或回到前台时同步，更省电，但后台可能不再自动回复。

新配置显式保存 `backgroundFallback: YES`，旧配置缺少键时按 YES 消费；不迁移、不补写旧文件。新键仍位于原账号 AI 配置，不使用另一套 NSUserDefaults。Store 只为新键加入可选的严格 Boolean 校验和 portable 导出白名单；既有键的校验不改。显式 NO 随现有账号备份/恢复保留，旧备份缺键按开启解释。恢复仍关闭 AI 总开关、清除凭据与连接验证，保留原账号限制，单独恢复此偏好不会启动 AI。

## 开关行为与严格边界

| 状态 | 实际行为 |
| --- | --- |
| 开启，或旧配置缺键 | 完全沿用 2.1-17 的一次性 timer、45 秒间隔、3 秒 tolerance、尝试预算/冷却及 `max(最近一次尝试+45秒, 最近一次已验证完整同步+45秒)` 期限；原生完整同步确认可以顺延。原有后台、音频、账号、连接、群聊、授权、忙碌及暂停门槛全部保留 |
| 关闭 | 设置为 OFF 时立即调用原 `stop` 失效 timer，`active == NO`。关闭态 `refresh` 不起表，已验证同步完成也不能启动或重排插件请求；Manager 在原生账号/联系人 getter 前拒绝已关闭配置。微信自身原生同步和现有消息处理继续运行，没有新增事件补拉路径 |
| 重新开启 | Scheduler setter 仅恢复开关标记，由原配置保存后的 `refresh` 按当前 deadline 起表；预算已经到期时保留原版的一次即时尝试，未到期则继续剩余时间，不补发错过的周期。直接 OFF/ON 保留原验证覆盖和尝试预算；通过设置保存时仍按旧规则撤销配置身份对应的验证覆盖，但不清除已发生的尝试预算与45秒冷却 |
| 保存失败 | 按最终仍有效的已保存配置恢复 ON/OFF，不让 UI 临时状态成为持久调度依据 |

切换仍走原有配置保存流程，因此原本的取消尚未提交回复、清空内存上下文和撤销旧配置证据规则继续有效。`CSAIConnectionIdentifier` 没有改动，切换此键不要求重新测试模型连接，也不清除普通保存中的 `verifiedConnection` / `verifiedAt`。

未引入 2.1-18 的调度器 `contextGeneration` 公开接口、`allowsRequest` 标记、scene 6 限制或 raw service context 身份核验。`CSAINativeSyncObserver.h/.m`、`Hooks/AIReplyHooks.xm`、密友、底栏角标、列表还原、备份 Engine/Registry 等均与任务前哈希一致。

关闭的代价是：没有周期兜底后，微信长时间不自行完成同步时，后台静默群消息可能延迟或收不到，AI 也可能不再自动回复。开关不关闭既有后台音频保活，不能据此承诺固定幅度的续航或温降。开启后是周期性的同步尝试，不是每45秒固定请求模型；模型仍需符合原规则的新消息才能触发。

新配置向旧版降级有既有严格 schema 边界：2.1-19 可读缺键旧配置，但旧 2.1-17 的白名单不认识新键。这里仅记录实际兼容边界，不修改旧版或扩大本轮范围。

## 改动文件与改前/改后哈希

20 份选定 baseline 副本及 manifest 已保存于 [baseline/manifest.json](baseline/manifest.json)。实际修改 **16 个文件**，其中生产/版本输入8个，测试3个、验证脚本2个、文档3个；另外4个受保护文件未变。

| 文件 | 改前 SHA-256 | 改后 SHA-256 | 结论 |
| --- | --- | --- | --- |
| `Controllers/CSAIBackgroundSync.h` | `2dbfeed9f46dee8482475240a6777179e16f8cc4da9466ac6f0d71d8dab6bf16` | `3629c9c7ce4e3bba60a215fe0f1efbbb589dcaf5c27797e2ed9dd6888f09910e` | 范围内修改 |
| `Controllers/CSAIBackgroundSync.m` | `66c8b213863e88626975c16c41ba4a98280b0989e590e4c7b6cfc7bd200e0e0d` | `6b96295cdcfa0e9c103999a870fe351ca5a08875f6006146463f2ab65c3d0bed` | 范围内修改 |
| `Controllers/CSAIReplyManager.m` | `3545484aefe47a85577a31b10b03957019b198d508abcababd89aed9d203020e` | `c73595a82766247707afe35e7fce42a607a222060f787775bf418944367af1ce` | 范围内修改 |
| `Controllers/CSAIReplyStore.m` | `ec154647a31d7fa892125646cd6efb90c0ac91b13b9dee309793dba59416faf2` | `4937f4bb757f1145ab6f89561a91c88683c03d8eb03499fb4ed93651845cec7a` | 范围内修改 |
| `Controllers/CSAIReplySettingsViewController.m` | `7c9c00507bf119eda8b8b962977c7fb4b50f44609df9c9592a840806e5a76aca` | `6ba96063b229d4a7f766a3d3e63fb43091b0744a5fc896ae2b6d1710349e88c8` | 范围内修改 |
| `Tests/AIBackgroundSyncTests.m` | `969f941a831411f52a07cc03e30df823eeff118dc57f585987498dfc42b2c964` | `b160d9acf80104481094060d6332e8485dd4992464b7722461ec23b1b2e79905` | 范围内修改 |
| `Tests/AIReplyManagerTests.m` | `803b02ead4ff04d987a54f3efaeaf72e0824860fb91eec4a4ab8b9c34e3e067a` | `c3ba47c60049ea82b9dd577f5002cf7348f571516276c1d37fd903a30bfc21b0` | 范围内修改 |
| `Tests/AIReplyCoordinatorTests.m` | `594135e9b78c5b78dc5936dd736510bdf1cba3ff9d1fd5cdeb6f488f31be80e3` | `7b672a22e331ffb2fb0cfc4558a4c745395ca8774b1528d672902bff6ec4cada` | 范围内修改 |
| `Tests/verify-ai-background-sync.sh` | `8d6f0e6b83cab7a0d8f5defff478e040ba6c6fd8dd6758bf8915322d156a8e25` | `b2d551c7261911d2fa9aecc3de2056c0a4661d4d393fb882302d31b16b6d9ca4` | 范围内修改 |
| `Tests/verify-ai-manager.sh` | `a44a73cae03d67d788e63ec44c04906c27da6488a5e33dd2f068a53ec0413749` | `fded93c17090a4931ce9c7040e47744fc80c6a33d7007d81bd309ee71251b15e` | 范围内修改 |
| `control` | `a7a58000074af6d0782a4d62454ff65ac53ebe9d3936553867d8cbf1f4785f6a` | `5d9b0cc16b7bf40f90000d711acfcdc094b61dbffcc5a2437c4fda45df2d3e5d` | 范围内修改 |
| `Headers/CSUserInfoHelper.h` | `f91d0a63cc806e69508e2d738e917e07f6c5d1421bbd8c6e4cf58a647ec390bb` | `2c5572b53ef9c2596c87aa2200d81d20fcb6191532708b6858927370e6c69a8b` | 范围内修改 |
| `Controllers/CSReleaseNotesViewController.m` | `2a4bb551d70868b7329338552410b29c7ca556f7d0b909321073abbcbbf6da18` | `c6a411e280ff95d605363ebe697e4d0cb055132c448a0b41091decd039988099` | 范围内修改 |
| `README.md` | `4d8f93d8c116b8d54a9d94b18d0476206f46d9eaf1ba19d123c9ea4586bdca10` | `d4b2ec12c189529ca1bd888d85af41ad1b21b5b2fe33b7ab06d1382c9553d0cc` | 范围内修改 |
| `docs/features/ai-auto-reply.md` | `9e4391adcac372797dd3fd6b3fb28de5b7ca403ffa631c9a758550c1a4313b3a` | `2bd0bff0ec2f8fc3eb3bdd3174c1de6a79625ddee150f41a22853e4ce82cf38c` | 范围内修改 |
| `docs/features/ai-auto-reply-validation.md` | `ff9f319b3515f10c6f2399499d0c510aa5339562a4183b601466b6a7486db028` | `8e95ac50282ae450ac2c0db5bb1ad752199e7a780694425a24089f72f2e8deaa` | 范围内修改 |

机器清单为 [change-manifest.json](change-manifest.json)，完整任务内差异为 [changes.patch](changes.patch)。4个逐字节未变的保护副本为 `CSAIReplyStore.h`、`CSAINativeSyncObserver.h/.m`、`Hooks/AIReplyHooks.xm`。基于全部42,513个生产输入的范围审查确认：只有以下8个预期文件变化，其余42,505个不变，范围无新增或缺失。

| 文件 / 方法 | 修改与原因 |
| --- | --- |
| `CSAIBackgroundSync.h/.m:init/setFallbackEnabled:/refresh` | 仅新增默认YES的 `fallbackEnabled` 入口、OFF调用原stop、关闭态refresh早退。移除这些纯新增代码后，文件主体与2.1-17逐字节相同，deadline/tick/verified/cooldown核心不改 |
| `CSAIReplyManager.m:reconcileBackgroundSyncContext/allowsBackgroundSync` | 仅增加配置到调度器属性同步和本地false资格门；移除这两行后与基线逐字节相同 |
| `CSAIReplyStore.m:DefaultConfiguration/ValidateConfiguration/PortableState` | 新键默认、可选类型校验、portable保留；不改连接指纹、其它字段或持久化算法 |
| `CSAIReplySettingsViewController.m:reload` | 原功能分组新增同风格开关；原footer后追加用途/能耗/关闭代价；走原save |
| `control`、`CSUserInfoHelper.h`、`CSReleaseNotesViewController.m` | 三处版本统一2.1-19，新增默认开启/用途/耗电代价的内置说明，历史条目保留 |
| 3个测试、2个脚本及3篇文档 | 追加开关覆盖与精确检查数，更新使用方式、备份偏好、交付路径；没有修改或删除旧测试断言 |

## 测试结果与新增用例

所有测试在临时目录、假账号、假服务或URLProtocol中运行，无真实账号/Keychain/AI请求。只运行与本轮调度、配置、备份及原生边界有关的8套回归，未跑项目全量。

| 回归 | 2.1-17相关基线 | 本轮实际 | 日志 |
| --- | ---: | --- | --- |
| scheduler `--ios` | 78 | **115 = 78 + 新增37**；arm64/arm64e对象通过 | [scheduler.log](scheduler.log) |
| manager `--ios` | 729 | **850 = 729 + 新增121**；arm64/arm64e对象通过 | [manager.log](manager.log) |
| coordinator / Store | 4496 | **4588 = 4496 + 新增92** | [coordinator.log](coordinator.log) |
| observer `--ios` | 828 | **828**（786 + 七种ABI各6）；双架构对象通过 | [observer.log](observer.log) |
| ai-native | 86 | **86** | [ai-native.log](ai-native.log) |
| background-run | 186 | **186**，音频及宿主hook检查通过 | [background-run.log](background-run.log) |
| ai-backup | 保留既有用例 | **96**，完整备份Engine链路回归通过 | [ai-backup.log](ai-backup.log) |
| foundation | Store / Client套件 | **两套均通过**，脚本不打印数值检查总数 | [foundation.log](foundation.log) |

共6,749个有数值的计数检查，另有未提供计数的Store/Client套件。计数包括循环和fixture断言，不等于独立产品场景或覆盖率。coordinator日志中的新增92是4,588的子集，没有重复相加。

两个 scheduler/manager 验证脚本在2.1-17中**原本没有hard count**，本轮分别新增精确期望 **115 / 850**。脚本保留原编译和iOS对象验证路径，只对实际输出增加期望检查；最终带新期望的两套 `--ios` 均已重跑通过，不是仅修改显示数字。

新增函数及覆盖：

- `FallbackToggleDeadlines`：新实例默认YES；OFF不读资格、不排表；关闭态refresh/完整同步完成/旧timer不启动；ON+原refresh恢复当前max deadline与3秒tolerance；短停、覆盖撤销与预算到期不绕开冷却。
- `FallbackToggleReentry`：资格、时钟和同步回调内切换OFF/ON，原generation和timer归属保护仍能拦截旧调用；重入不能生成重复预算。
- `BackgroundFallbackConfiguration`：旧缺键配置按开启；真实异步保存OFF/ON立即生效；关闭态正常消息仍准入；两方向保存失败恢复、连接验证保留、配置证据撤销、账号Store隔离。
- `BackgroundFallbackReentry`：四个原生/账号查询边界中切换开关，旧请求与旧完成不能穿过关闭或配置变化。
- Store/Coordinator 新增92项：新默认、旧缺键有效且加载不重写磁盘、YES→NO→YES真实保存/重载、portable导出和独立Store恢复保留、11类非法值拒绝且磁盘/ready不变、连接指纹及验证时间不变。

原有三份测试正文和main调用，在移除本轮纯新增内容后，与baseline逐字节一致；没有放宽旧断言。Store层的portable恢复新增验证与既有完整Engine备份回归共同提供证据，不把Store fixture称为真机备份验收。细节见 [Scheduler/Manager审查](scheduler-manager-review.md)、[Store审查](store-review.md)、[独立范围审查](review.md) 和 [test-results.json](test-results.json)。

## 编译与包校验

Rootless和Rootful各使用全新隔离临时 `.theos` 完整打包，均exit0。每个方案 **6条警告，与2.1-17基线6一致**：`UILocalNotification`弃用、`statusBarFrame`弃用和链接器`-multiply_defined is obsolete`，各双架构一次。本次代码未引入新警告。

[build-rootless.log](build-rootless.log)、[build-rootful.log](build-rootful.log)、[build-result.json](build-result.json) 已留档。生产输入在构建前后哈希一致，旧构建/包均保留；不运行clean。构建和验包脚本分别是 [build-packages.py](build-packages.py)、[verify-packages.py](verify-packages.py)。

两个包均为版本2.1-19，包内均含arm64/arm64e，最低iOS15.0。filter与源码一致、payload与staging一致、关键已有功能符号保留；二进制包含新配置键。四套dSYM与二进制UUID一致，symbols ZIP CRC通过，共12个文件。未安装设备。

| 方案 | 包的Debian架构 | dylib安装路径 |
| --- | --- | --- |
| Rootless | `iphoneos-arm64` | `/var/jb/Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib` |
| Rootful | `iphoneos-arm` | `/Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib` |

| 方案 | Mach-O架构 | 二进制 / dSYM UUID |
| --- | --- | --- |
| rootless | arm64 | `671B8D52-D5FC-3532-824E-387F66D21409` |
| rootless | arm64e | `7A952314-6723-30DC-B2F6-2E793DA402DD` |
| rootful | arm64 | `33B6B50C-673D-3336-A1FC-E5119D8A6C43` |
| rootful | arm64e | `514A77C6-C049-3177-BD07-28E77E6D70E5` |

输出目录：`packages/2.1-19-ai-fallback-toggle/`。独立执行 `shasum -a 256 -c SHA256SUMS`，三个产物均为OK。

| 产物 | 字节数 | SHA-256 |
| --- | ---: | --- |
| [com.wechat.improve_2.1-19_iphoneos-arm.deb](../../../packages/2.1-19-ai-fallback-toggle/com.wechat.improve_2.1-19_iphoneos-arm.deb) | 1525090 | `0cc3502aa42698f791dec42aed79158b425a08c8ded807889d7f47f2700de54b` |
| [com.wechat.improve_2.1-19_iphoneos-arm64.deb](../../../packages/2.1-19-ai-fallback-toggle/com.wechat.improve_2.1-19_iphoneos-arm64.deb) | 1526178 | `89f0aa71a35813cd06445b007f9c5cd48ad4ecec24935802d15378b108e1a776` |
| [com.wechat.improve_2.1-19_symbols.zip](../../../packages/2.1-19-ai-fallback-toggle/com.wechat.improve_2.1-19_symbols.zip) | 11079406 | `cbcf083330f15c229f6da8ebe388ab71f6df868342d1fc26d34ea2b5d03e3095` |

[SHA256SUMS](../../../packages/2.1-19-ai-fallback-toggle/SHA256SUMS) 与完整 [package-verification.json](package-verification.json) 已保存。任务前原有 `.theos` / `packages` 的1,275个文件逐一保持原路径与哈希，本轮只在新交付目录增加上述双包、symbols和SHA256SUMS。

交付前 [最终独立重算记录](final-verification.json) 再次验证42,513个构建输入与20个冻结文件，全部符合构建/测试快照；生产范围只变更授权的8个文件，42,505个不变，无新增/缺失。旧产物1,275个均未变，新产物恰为本次4个交付文件，三个产物及SHA256SUMS记录均重新核对通过。

## 真机验收（尚未执行）

1. 保持原设备/账号/配置，安装匹配注入方案的2.1-19；检查版本与功能分组中开关顺序，确认原总开关footer仍在，新说明包含用途和额外耗电。
2. 旧配置缺键应显示开启。在满足原后台音频、AI已验证、免@群条件下，确认原一次性兜底与完整同步顺延仍工作。
3. 关闭开关后确认插件timer停止，持续后台超过多个45秒周期，插件兜底请求不增加；微信自身事件收到的消息仍按现有规则处理。重点记录免打扰群延迟或收不到的实际结果，不用切前台补收替代后台结果。
4. 在上次尝试后不足45秒时重新打开，确认只恢复剩余deadline；预算已到期时至多原有一次即时尝试，不连续追补。停止音频、切前台、切号、通话让出仍按原规则生效。
5. 重启微信确认开关按账号保存；用独立测试账号/备份验证显式NO可恢复，恢复后仍关闭AI总开关且需要Key和连接测试。
6. 相同设备/网络/消息量对照开关ON/OFF的额外请求、后台到达率、Energy Log与温度。主机回归和构建不能证明实际省电或发热幅度。
