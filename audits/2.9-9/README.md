# WeChatImprove 2.9-9 首次横滑转场诊断报告

日期：2026-11-25。工作目录：`/Users/zhangshichao/Documents/Workspace/WeChatImprove`。对照基线为本轮开始时已有的 2.9-8 工作树及 `audits/2.9-8/` 交付记录。任务由主 agent 连续完成，没有派发子任务。先完成 Rootful、Rootless 诊断包、符号和包校验，再编写本报告。

**交付结论：待真机日志定位，尚未确认修复。** 用户已在原设备上证伪 2.9-8 的修复效果。本轮没有继续追加“提前准备来源”的时机补丁，也没有把任一候选状态直接清零来强行出现转场。静态分析确定了竖滑实际改变的状态及各处拒绝路径，但不能在没有设备运行数据时唯一指出哪个状态挡住了用户的首滑。因此按任务书授权交付临时诊断版 2.9-9：记录原路径实际拒绝的条件，以“返回后直接横滑”与“返回后先竖滑再横滑”的对照日志完成下一步定位。所有设备运行效果均为 **真机未验证**。

**2.9-8 改了什么、是否生效。** 上版在 `SessionGroupHooks.xm` 的出现完成入口、`CSGroupListAdapter.m` 的 `layoutForController:` 和 `gestureRecognizerShouldBegin:` 中提前调用已有 `preparePageSourceForPan`。该代码确实进入交付源码，但“原设备首滑到底被哪条 guard 挡住”当时没有运行证据；主机门禁通过只能证明对应模拟状态。用户的反馈已证伪“那些调用足以解决现场问题”的结论，不能再把它写成修复完成。本版保留这部分已有代码，增加观察，不继续移动准备时机。语音转文字合并完全保持本轮起点内容。

**天然对照的确定事实。** `Controllers/CSGroupListAdapter.m:2371 beginUserScrolling` 先取消旧页面转场，然后增加 `viewportGeneration`，调用 `:2311 clearPendingViewport`，清掉 initial pending、`pageSourceReturnKey`、`presentationViewport`、`switchViewport`、`presentationReturnFinished`，最后清空 anchors。`:2389 beginUserDragging` 排除正在进行的分组横滑，以及已准入的明显水平动作后才进入该流程。真实竖向滚动还可能触发表格实际布局；`:1161 nativeMenuDidChange` 被交互结束路径调用时尝试恢复视口并调度 dirty 刷新。

这里有一个必须区分的方向：`beginUserScrolling` **不会直接把 `dirty` 或 `sessionLayoutHeld` 设为 NO**，也不会直接重建一个“竖滑专用快照缓存”。如果现场是 pending 请求清掉后恢复，则首先看清除前的 pending；如果是 dirty/held 消失，则需要追到后续刷新、模型校验和真实布局，不能把这些变化都归到一次清空操作。两个方向都符合现象，尚不能由静态代码二选一。

**五个候选逐条落实。** 表中“首次返回”和“竖滑后”区分源码已知的动作与未知的设备值；未知值没有用推测数字填充。行号为本版交付源码。

| 候选 | 首次返回与竖滑后的源码差异 | 当前判定与精确观察点 |
| --- | --- | --- |
| 1. 几何、宽度或内容未初始化 | 首次返回的 header/chrome 布局不能代替原生 table 的实际布局；`CSGroupListAdapter.m:920 performSessionListLayout:` 仍可扣住原生布局。竖滑可以使 UITableView 重新进入实际 layout，但不能静态断言首帧一定零宽或一定缺 host。 | **需设备对照。** adapter 记录 bounds/frame/contentSize/contentOffset、contentInset/adjustedInset、header/nativeHeader/chrome frame、table/controller/window/host。animator `:76 visibleFrameForTable:belowView:` 记录实际裁剪结果与首个拒绝条件；`:191 matchesTable:belowView:` 记录 table/rail/host/window/viewport 一致性。比较 `return.did_appear.*`、`horizontal.*` 与 `vertical.before/after`、`table.layout.*`，才能判断是尺寸/宿主未就绪还是同一几何下其他 guard 失败。 |
| 2. 首滑前置条件 early-return | `:2842 preparePageSourceForPan` 受发布、隐私等待、snapshot retry、表格交互、菜单、返回请求及版本证明约束；`:2969 beginSwipePageTransitionToIndex:direction:` 另外直接拒绝 dirty、held、presentation/switch pending。`:2785 pageTransitionContextIsValid` 与 `:3139 pageTransitionTargetIsReady` 检查 model/policy/epoch/选择等。竖滑之后这些条件是否改变必须实测。 | **确定存在拒绝路径，具体首个拒绝状态未知。** 关键复合 guard 的每个表达式在原求值位置包装，保持原短路顺序与一次求值，`event` 为原方法 selector，`reason` 为首次实际拒绝表达式；对于 AND 证明失败使用 `false: ...`。原生 coordinator 的 begin/token/full validity 也逐项记录。不能把辅助字典里较早读取的 policy/account 当成本次 guard 的最新读值。 |
| 3. 竖滑清掉/改变了什么 | `:2371` 的 viewport generation 增加、清 pending/key/anchor 是直接事实；dirty/held 不由此直接清零。`:920` 的真实布局可能因 boundary/model/policy/visibility 被扣住，只有验证通过才解除 hold。`:1161` 的交互结束入口会恢复视口/调度刷新。 | **清理动作成立，因果归属仍需设备日志。** 成对记录 `vertical.before`/`vertical.after`，记录 `table.layout.held` 的 boundary/model/policy/visibility 理由、`table.layout.native_returned`、`table.layout.released`，以及 `interaction.end.before/after`。先确定哪个量在“取消转场/清请求”“真实布局”“结束后刷新”中的哪一步变化，再考虑最小修复；不得一并清 dirty/held 绕过模型或隐私验证。 |
| 4. outgoing/incoming 快照首次不就绪，或 attemptedTarget 抑制重试 | `CSGroupPageAnimator.m:118 snapshotForTable:frame:afterUpdates:` 每次有效预览按需捕获 outgoing(NO)/incoming(YES)，没有等待竖滑才建立的全局快照缓存。adapter `:2969` 通过准入后才记录 attemptedTarget；真实 capture/后续预览失败可能令同次手势不再重试。 | **快照 nil/几何变化及重试抑制都可能，但没有现场结果。** 记录 `snapshot.outgoing.result`、`snapshot.incoming.result` 的 nil/non-nil、capture rect、afterUpdates、前后 frame/host/window 与 animator 的拒绝表达式；`:3317 horizontal.capture_suppressed` 标记 attempted target 已锁住。本机未把 snapshot 非 nil 当作内容已正确绘制的证明。 |
| 5. 冷启动与返回首页的不同分支 | `:2316 prepareInitialViewport`、`:2343 restoreInitialViewport` 按账号/epoch 管初始定位；`:372` 离开首页保存 departure viewport，`:406 finishPresentationReturnForController:` 建独立 return key。`:444 layoutForController:` 的被动准备跳过 initial pending。竖滑会消费初始定位并清 return/switch 请求。 | **分支差异成立，不应互相替代。** 记录 `initial.prepare`/`initial.cancel`、`departure.*`、`return.*`、`viewport.pending.before/after` 和 `viewport.restore_height.entry`/原有 guard；比较初始 key、return key 是否存在/匹配、generation、请求高度、已发布与已选分组匹配。冷启动与聊天返回、其他 tab 返回、搜索返回、table 替换须分别解释，不能因竖滑消费了 startup 请求就把冷启动保护删除。 |

**本轮尚不能命名唯一的“作祟状态量”。** 至少下列几条可达路径与现象相容：未消费的 presentation/switch pending 在 begin 阶段被拒绝，竖滑清除它；return key 已消费后又来迟到模型更新，dirty/held 阻断转场，而竖滑带来的 layout/结束刷新将其解除；adapter 就绪但 native baseline/configuration/epoch 证明尚不一致；outgoing 或 incoming 捕获为空、或者捕获前后 host/frame 改变，继而 attemptedTarget 抑制当次重试。这些是待验证分支，不是已经定位的根因。本版不新增相应状态清理，避免再次提交一个仅凭猜测的“修复”。

**诊断实现与文件范围。**

| 文件 | 本轮改动与用途 |
| --- | --- |
| `Controllers/CSGroupFirstSwipeDiagnostics.h` / `.m`（新增） | 宏控制的本地 JSONL 记录、后台串行写入、队列/文件限额和导出状态；没有默认偏好键或诊断开关。 |
| `Controllers/CSGroupListAdapter.m` | `:240` 被动状态采样；返回/离开、竖滑前后、实际布局 held/released、视口恢复、横滑第一次更新、来源准备、转场 begin/context/ready、attemptedTarget 抑制的观察。 |
| `Controllers/CSGroupNativeSessionCoordinator.m` | `:235` context policy、`:282` token、`:342` full validity、`:394` begin preview，以及 `:482 permitsSelectedGroup`、`:522 identitiesMatch`、`:1054 completeSourcePolicy` 的原求值拒绝理由。包括原生模型、baseline/configuration/owner/manager 和 policy/epoch 证明。 |
| `Controllers/CSGroupPageAnimator.m` | `:76` 有效区域、`:118` 快照结果、`:130` begin、`:191` identity/geometry 一致性、`:213` incoming/readiness 的观察；没有增加快照次数。 |
| `Controllers/CSOtherSettingsViewController.m` | 仅在诊断宏开启时增加 `:35`“导出首滑诊断日志”，`:39` 导出，`:47` 系统分享，`:65` 明确说明尚未确认修复。 |
| `control`、`Headers/CSUserInfoHelper.h`、`Controllers/CSReleaseNotesViewController.m`、根 `README.md` | 版本 2.9-9、诊断版说明、复现/导出入口与包链接。 |
| `packages/2.9-9/`、`audits/2.9-9/` | 本版安装包、fat dylib、匹配符号、SHA256SUMS、门禁比对、构建/产物/宿主日志检查记录及本报告。 |

工作树原有的 `CSMessageMergeAdapter.m`、`Hooks/SessionGroupHooks.xm` 修改来自 2.9-8，本轮没有回滚或编辑。语音转文字合并文件与本轮起点逐字节相同，见 `diagnostics-off-equivalence.json`。Makefile 未修改；宏经 `ADDITIONAL_CFLAGS=-DCS_GROUP_FIRST_SWIPE_DIAG=1` 传入。转场曲线、距离/速度阈值、指示器、返回准备时机和安全准入逻辑沿用 2.9-8。

**采样口径与扰动边界。** 为了观察而重新调用 `CSCloseFriendCurrentSnapshot()` 可能过期 reveal、触发通知并取消本次预览；额外调用 `CSGroupCurrentAccountID()` 也会多走原生 getter。因此诊断 helper 不为日志发起这两类新读取，而是在原路径本来读取的位置捕获返回值与读取 uptime，随后被动复用。`observation.policy_source/account_source` 和 `*_read_uptime` 明确标记来源/年龄；未读过账号时注明来自已有 preferences，不能将其视为 guard 时刻的新事实。实际 `reason` 来自原 guard 的求值，优先级高于缓存辅助证明。没有为诊断强制 layout、刷新、恢复视口或再截一次图。

记录在调用线程采样、去重和构造状态，文件写入在后台串行队列；因此不能声称“诊断无开销”。本版没有测量触摸到显示延迟或帧耗时，`sample_uptime` 只是回调采样时间，并非物理触摸/屏幕呈现时间。若诊断改变复现概率，要如实回传现象，后续必要时依靠系统 trace 或进一步缩小采样；相关运行效果均为 **真机未验证**。

同 owner 的相同 `event/reason/state` 会去重，读取时间戳不单独打破去重；这不是回调次数统计。adapter 的 `comparison.return/vertical/gesture` 是对应入口计数，不能直接当成物理滑动次数；同一竖滑可能经过不止一个原有入口。native 的 `attempt` 用于关联预览尝试。用 session、owner、table/controller/animator 指针关联、uptime 和 sequence 排序；不要跨进程比较对象指针。日志仅记录状态、数值、几何、指针和匹配布尔值，不输出聊天正文、真实账号/分组 ID 或快照像素。

`CSGroupFirstSwipeDiagnostics.m:14–15` 限制数据 16 MiB、待写队列 128 条；`:73` 导出在串行队列中等待先前已入队记录，写 `export.status`、fsync 后复制给系统分享。原始日志保留于微信数据容器 `Documents/WeChatImproveDiagnostics/first-swipe-2.9-9-<毫秒时间戳>-<pid>.jsonl`；导出副本名为 `first-swipe-2.9-9-<UUID>.jsonl`，分享结束清理副本，不自动联网发送。

必须先读 `export.status`：`queue_dropped`、`size_limit_dropped`、`io_error` 或 `pending_after_export_barrier` 说明日志的完整性边界，不能把缺失事件当成未发生；去重也会减少记录。状态 footer 使用数据上限之外的小段保留尾部，因此到达数据上限仍能表明截断。若导出报告 I/O 失败，应保留原文件和错误信息。

**宿主验证和回归。** 六项核心门禁按 2.9-8 已交付逐项 exit code 比较，不使用早期会话“两个核心旧红灯”的过期说法。当前基线六项都是 PASS，本版也全部 PASS，`new_failures=0`。

| 既有脚本 | 2.9-8 | 2.9-9 |
| --- | --- | --- |
| `Tests/verify-tabbar.sh` | PASS / 0 | PASS / 0 |
| `Tests/verify-settings-tab-bar.sh` | PASS / 0 | PASS / 0 |
| `Tests/verify-settings-home.sh` | PASS / 0 | PASS / 0 |
| `Tests/verify-moments-card.sh` | PASS / 0 | PASS / 0 |
| `Tests/verify-moments-share.sh` | PASS / 0 | PASS / 0 |
| `Tests/verify-plugin-header-entry.sh` | PASS / 0 | PASS / 0 |

见 `core-gates-results.json` 和 `logs/<gate>.log`，随包有同名 JSON。另跑七项分组核心专项，均与 2.9-8 PASS 对齐：page-lifecycle 182 checks、page-animator 84、interactions 191、initial-viewport 105、native-preview 209、search 163、indicator 183；见 `focused-gates-results.json`。最终完善嵌套诊断后重跑 native-preview、page-animator 和 page-lifecycle 仍通过。全部为宿主验证，不能据此宣称原设备动画已出现。

2.9-8 另有 group-lifecycle 的 fixture 声明不全、group-selection 的宿主 Python mkdir EEXIST、message-merge 的 UIColor 桩编译问题。本轮聚焦分组诊断，没有重跑这三项，也没有改断言/桩来制造 PASS；不能把它们列为本版已通过，亦不能称作六项核心中的红灯。

关闭诊断宏后，对三份核心源文件进行预处理 token 对照，adapter 34108、animator 2114、coordinator 11648 个 token 均与本轮起点完全相同，详见 `diagnostics-off-equivalence.json`。这验证了非诊断路径没有夹带功能修复，不证明开启日志后的零扰动。最终设备构建均启用诊断宏，编译和符号核对另行通过。

临时 Foundation harness 只把生产 logger 的 `NSHomeDirectory()` 替换为隔离临时目录，宏开启，以 `-Wall -Wextra -Werror` 编译并验证真实 JSONL 导出和队列截断。小样本导出 2 条、无丢弃/错误；压力样本写入 141 条、`queue_dropped=4862`、文件 4,568,516 bytes、size-limit drop 0、I/O error 0，确认显式报告队列截断。该压力结果只证明宿主日志器行为，不是用户设备会掉这些数量的记录，也不是页面转场验证。见 `logger-host-check.json` 与 `logs/logger-host-check.log`。没有向 Tests/ 或默认回归加入 harness。

本轮 `git diff --numstat -- Tests` 为空，Tests/ 保持开始时的 468 个文件：466 个受跟踪文件与两份原已存在的 `.DS_Store`。没有改测试、桩、脚本、断言，没有新增默认回归。没有 make clean，没有写历史包；local-archive 仅按授权完整读取本任务书，没有做历史产物全量哈希或 protected-state/baseline 快照。

**构建和产物。** 两版均为 Release/FINALPACKAGE，包版本 `2.9-9`，使用独立临时 Theos 数据目录和本版输出目录，未使用 clean。命令形态：

```sh
make -j6 package SCHEME=<rootful|rootless> \
  _THEOS_LOCAL_DATA_DIR=<本轮临时目录>/build-<scheme> \
  THEOS_PACKAGE_DIR=<项目>/packages/2.9-9 \
  PACKAGE_VERSION=2.9-9 PACKAGE_BUILDNAME= \
  ADDITIONAL_CFLAGS=-DCS_GROUP_FIRST_SWIPE_DIAG=1
```

298 个源码单元均进入两个架构：Rootful 初次完整编译与最终增量编译的并集为每架构 298，最终命令重编每架构 60；Rootless 最终全编每架构 298。最终 Rootful 日志有 6 条既有警告、Rootless 有 8 条，均 0 编译错误，未表述为零警告。Rootless 复用临时构建目录时，Theos 删除自身临时 swift 目录遭宿主 `Operation not permitted`，该次退出 2；保留原目录，改用新的独立 `build-rootless-v2` 后构建成功。没有删除或清理历史目录；见 `build-retries.json`。

| 产物 | arm64 UUID | arm64e UUID |
| --- | --- | --- |
| `packages/2.9-9/com.wechat.improve_2.9-9_iphoneos-arm64.deb`（Rootless） | `31ED5337-A175-3AE3-BAE2-C3BC8E1DA4A3` | `DA733B7F-9903-3EEB-8782-CFF3A1977120` |
| `packages/2.9-9/com.wechat.improve_2.9-9_iphoneos-arm.deb`（Rootful） | `CAF504AB-BD2F-3E7C-B116-77BE9DFCEAF0` | `673F28FD-2EEE-3118-BCFB-1D09C57BC8E4` |

独立 fat `WeChatImprove.dylib` 与 Rootful 包内库逐字节相同；Rootless 包安装到 `/var/jb/Library`，Rootful 到 `/Library`。包 ID、精确版本、arm64/arm64e 和最低 iOS 15.0 均已检查；打包动态库与各自最终构建对象一致。OpenStep 注入 plist 转换后与源码语义一致，诊断记录/导出符号存在。symbols.zip 含两方案各两架构的四份匹配 dSYM，UUID 全部相符，ZIP CRC 通过。见 `artifact-validation.json`。

本版 `SHA256SUMS` 覆盖两个 deb、fat dylib、symbols.zip、包 README、核心门禁 JSON，共六项，`shasum -a 256 -c SHA256SUMS` **全部 OK**。包 README 和门禁 JSON 已在写本报告前完成，历史包不在本轮哈希范围内。

**用户需要回传的对照。** 安装对应环境的 2.9-9 诊断包后重启微信一次；保持同一进程、账号、分组与开关。A：进入原先的聊天/其他页面，返回首页，不先竖滑，立即同方向横滑至相邻分组。B：再次进入同一页面再返回，先上下滚动一下，再从同一来源向相同目标横滑。不要在 A/B 之间杀掉微信；如需选择回原分组，注明操作即可。完成后进入 **插件首页 → 设置 Tab → 其他设置 → 导出首滑诊断日志**，回传原始 `.jsonl`，并写明 A/B 的有无转场、微信版本、iOS 版本。如果诊断版使现象消失或改变，仍需日志及变化描述，不能直接视为已修复。

**拿到日志后的判定规则。** 先检查 session/导出状态和截断，再按 adapter 的 return/vertical/gesture 与原生 attempt、对象关联串起同次尝试。从 `horizontal.should_begin`/`horizontal.began` 找到来源准备、`transition.begin.entry`、animator outgoing、native preview、incoming/readiness 的第一处实际失败，向后验证是否发生取消或 attemptedTarget 抑制。比较 A/B：如果 pending 从 present 变 absent 且原 begin 拒绝恰为该 pending，则定位到请求生命周期；如果 pending 均为空而 held/dirty 经真实 layout/刷新才变，则定位到模型/布局的释放条件；如果两个链路都过准入再出现 snapshot nil/几何变化，则处理具体捕获/宿主问题；若阻断在 native proof，则看嵌套 reason 与 baseline/configuration/policy/epoch 变化。单个成功事件、缺失记录或缓存 policy 的表面差异都不足以单独定因。

仍需原设备确认：A/B 的真实阻断表达式和状态变化；冷启动、聊天/其他 tab/搜索返回和 table 替换；连续快滑、反向取消、原生菜单与右侧触摸区；账号、隐私和系统减弱动态效果边界；日志导出与诊断开销。上述均为 **真机未验证**。若完整日志显示全部准入/快照/ready 成功而肉眼仍无转场，再使用系统 Core Animation/主线程 trace 对齐可见帧，不以本地日志采样时间冒充帧耗时。获得对照证据后才能提交确定性功能修复，本版没有宣称完成该修复。
