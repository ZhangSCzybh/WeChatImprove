# 2.0-5：结合真机审计核查恢复兼容与悬挂事务

日期：2026-10-24。交付承接 2.0-4 的图片 helper 修复，补充跨版本兼容诊断、`prepared` 跨启动收尾和读取/归档审计。未连接真机，尚未收到现场 `.wcbak` 载荷及 `transaction.plist` 内容。

**已确认并复现的新增缺陷：恢复前检查失败后，旧引擎将有效的 `prepared` 原样保留，后续启动可能反复失败而一直没有收尾。** 2.0-5 为每条计划记录进程启动尝试，下一次启动仍未进入写回时自动撤销并归档，保留当前配置与备份。已经进入 `applying/rollingBack` 的事务仍必须完成真实回滚。

**现场唯一根因仍不能定案。** 审计证明文件存在及事务未归档，但没有记录 journal 的 state、sourceID、异常原因；不能据此断言始终 prepared，也不能确认被恢复的就是 C4141078。2.0-4 已补入多数恢复阶段审计；这份现场文件没有这些事件，也没有插件版本字段，不能仅凭 schema=2 判断是否已运行新版。

## 真机文件核对

输入：[原始审计文件](../inbound/com.wechat.improve.backup-audit-2026-10-24.plist)。SHA-256：`70d4f18dbb9eefbdf039d545fcd87dae3972d7eb4cb0bab21f7dfb6ccc8c81ad`。未修改输入文件。机器可读提取见 [inbound-evidence.json](inbound-evidence.json)。

- schema 2，共 20 条；微信版本为 8.0.78。
- 事件计数：storage-ready 6、published 4、inventory 8、remove-requested 1、removed 1。没有 restore、apply、transaction、rollback 阶段。
- pid 依次为 96103、96412、96433；容器路径一致，BackupV2 inode 一直为 557385440，支持同一目录延续，而非切到新空容器。
- C312A467 为本机手动发布，25,562 B；C4141078 为导入发布，63,157 B；大小不证明来源版本或路径格式，内嵌图片也会增大体积。

| UTC 时间 | 可确认事实 |
| --- | --- |
| 06:42:16 | BackupV2 与 CloseFriends 迁移返回 storage-ready；legacyPresent 为迁移前观察值 true。随后 inventory 的 readRoots 只有新目录。 |
| 06:44:34 | 新建 C312A467 发布成功。 |
| 06:56:38 | C4141078 以 imported=true 发布成功。 |
| 06:56:46 | protection 59990B63 发布成功。 |
| **06:56:48** | **第一次重启前，inventory 已列出 transaction.plist**，共 13 项。 |
| 06:56:51 / 06:57:11 | 两次新 pid 启动，legacyPresent 均为 false。 |
| 06:57:06 / 06:57:19 | 相同 13 项仍在，包括 transaction.plist；未列出 activation.plist 或 last-transaction.plist。 |

另一个线索：BackupV2 的目录 mtime 从 06:56:46 更新至 06:56:55、06:57:13，文件名集合没有变化。这与原子替换 journal 的行为相符，也可能有其他目录项操作；它不能定位具体写入者或证明某个 state，却使“文件一直原封不动地停在 prepared”更不能直接成立。

没有 activation 标记支持“未完成持久启动交接”的判断，但不能排除先 committed 后回滚、或者 rollingBack 重试。protection 发布及时间相邻支持用户确实准备过恢复，但源备份 ID 仍需 journal.sourceID 确认。

## A：载荷究竟存什么路径

`CSBackupAssets.m` 的 `ReadAsset` 在捕获时读取图片，把配置中的路径替换成 `csbackup:<SHA-256>`，把图片字节存入 snapshot.assets。`Materialize` 在恢复时使用当前传入的 resourceRoot 构造 PNG 路径。`beforeWrites/afterWrites` 的键是受约束的直接子级文件名。

因此要区分两类文件：

- **便携 `.wcbak`**：资源字段是摘要引用，图片数据内嵌，不携带可直接用于写回的旧资源绝对路径。`source.pluginVersion` 是来源说明；不是用它决定写入旧根。
- **本机 `transaction.plist`**：在本机准备阶段生成，before/after 中可以有已经按本机资源根生成的绝对路径；图片写入表仍是文件名。它是本机恢复事务，不是跨设备备份格式，不应当跨容器手工移植。

迁移前仓库提交 `64aac104` 的 `CSBackupManager.m` 已把**资源根**设为 `Preferences/WeChatImprove`；此次从 Application Support 迁走的是 BackupV2 和 CloseFriends。不能把备份仓库旧地址等同于图片资源旧地址。

更强的证据来自导入顺序：`CSBackupManager.importURL` 先执行 `CSBackupCodec.decode`，Codec 校验又会调用 `materializeFields`；只接受有效资源引用，再经 Store.importSnapshot 发布。**C4141078 已出现 imported=true 的 published，说明它当时通过了这套资源引用校验。** 如果登记的图片字段中直接含有 Application Support 绝对路径，旧代码就会在发布前拒绝。故目前不支持“这份已导入备份没有路径重映射，所以必然写入旧目录”这一根因推断。

2.0-5 策略：

1. 完整、有效的 v2 旧版本备份继续兼容。预览提示来源插件版本，图片按当前资源目录重新构造路径。
2. 绝对路径或 file: 图片引用明确报 `CSBackupRestore/1007`：“该备份不适用于当前版本”，说明不能仅凭旧路径找回资源；不遍历/替换载荷内的任意字符串，不访问旧容器，不修改原件。
3. 缺少引用的内嵌图片报 `1008`：“图片资源缺失”；损坏图片仍按校验失败处理。文件格式不支持也给出明确兼容错误。
4. 非本次选择模块中的非法资源仍按完整文件校验规则拒绝，不把损坏快照伪装成完整备份。

关键入口：`CSBackupCodec.m` 的 Validate/decode，`CSBackupAssets.m` 的 ReadAsset/Materialize/materializeFields，`CSBackupStore.m` 的 snapshotForRestore，`CSBackupEngine.m` 的 previewContent。

## B：为什么保留整笔恢复和回滚

资源写入逐项失败会终止应用并回滚。配置字段可能引用本次图片；静默跳过图片但提交字段，会产生无效引用，也无法再保证“恢复成功”的含义。因此此次不加入默认跳过图片的降级。

缺失/不兼容资源在准备之前明确拒绝；写回阶段的权限、磁盘等失败仍保留源备份，按事务恢复 before 数据。2.0-4 修复的 helper 不再打开容器外祖先目录，仍保持直接子级 PNG 限制。相关隔离测试继续通过。

## C：prepared 跨启动收尾

旧逻辑的可重放结果见 [repro-prepared-before.log](repro-prepared-before.log)：第一个子进程因账号不匹配拒绝；第二个子进程因准备后配置变化再次拒绝；同一 journal 仍为 prepared。两个子进程是真实独立进程，不是以重复调用冒充重启。

2.0-5 在有效 prepared 的首次启动检查前，原子写入 `startupAttempt={sessionID,startedAt}`。sessionID 为该进程生成的 UUID，而非可能复用的 pid。可得到具体失败原因时，记录有长度上限的 `startupFailure`。

| 当前状态 | 处理 |
| --- | --- |
| prepared，没有启动标记 | 先持久保存标记，再进行账号、revision 和资源核验。标记保存失败则不进入写回。 |
| prepared，同一 sessionID | 同一进程的前台/账号就绪重试仍可继续，不算第二次启动。 |
| prepared，前一个进程的 sessionID | 持久写为 rolledBack，附 `resolution=cancelledBeforeApply` 和原因，再归档到 last-transaction.plist，移除活动 journal，释放这条事务造成的启动阻塞。 |
| applying / rollingBack | 继续核验和恢复真正的 before 数据，回滚失败保留 journal 与错误，不假称收尾。 |
| rolledBack，归档曾失败 | 重试归档并保留恢复原因，不重新写入旧 before 数据。 |
| 日志损坏、迁移冲突、读写不可用 | 保留文件并明确报错；无法安全证明事务状态时，不通过删 journal 放行。 |

**prepared 从未写过业务配置，因此正确的撤销是不重写当前配置。** 准备后用户可能有后续修改或切换了账号，直接把过期 before 重放会覆盖新数据。这里保留未应用前的实际当前状态，源 `.wcbak` 与 protection 快照均保留；这与 applying 之后必须真实回滚不同。

没有启动标记的 2.0-3/2.0-4 历史计划会先获得一次真实尝试；无法根据旧审计可靠反推它过去失败过几次。旧版本仍能理解终态 rolledBack，新增字段不改变事务 version=1。

取消后的原因通过 Engine.recoveryNotice 传给 Manager，保存到备份页。成功解除启动阻塞和目标备份已应用是两个结果，界面不会把自动撤销显示成恢复成功。

## D：审计与可见错误

沿用 2.0-4 的阶段审计，本轮补齐：

- `restore-import`：选择导入文件、读取与结果。
- `restore-metadata`：选包时读取 .meta/.meta.bak 的结果与相关路径；元数据只控制收藏/导入保护，不含恢复目标。元数据镜像损坏会记录 warning，不因此拒绝完整快照。
- `restore-read-snapshot`：实际选择的 `.wcbak` 路径、来源版本、图片数量及解码结果。仅在恢复选择入口记录，避免列表扫描不断刷掉诊断。
- `restore-startup-attempt`、`restore-prepared-expired`：持久尝试和撤销结果；包含事务标识、是否写过业务数据。
- `restore-write-preferences`：字段写回的早退和异常也有最终失败记录。
- `restore-rollback`、`restore-archive`：回滚与归档的结果和错误；原有 failure-cleanup 事件保持。
- 每条事件新增 `pluginVersion`，区分“schema 相同但插件版本不同”。

连同已有 selected、validate、prepare/prepared、transaction、write-resource、applied、verify、activation，覆盖用户要求的完整恢复链路。公共字段为 stage、status、path、readRoots、journalPath、errorCode；失败含 errorDomain/error/causes。meta 另记 paths，归档另记 archivePath。实际磁盘状态为 prepared → applying → committed；applied 是审计事件名。

`1001` 迁移、`1002` 校验、`1003` 权限、`1004` 存储、`1005` 需完整重开、`1006` 账号/配置等条件、`1007` 兼容性、`1008` 资源缺失。原始底层错误保留。启动失败或自动撤销原因持久显示在备份页；新计划准备成功、明确取消或成功应用后按原流程清除界面的旧失败提示。

审计位置仍为 `Library/Preferences/com.wechat.improve.backup-audit.plist`，只旁观，无微信清理 hook；保持 96 条事件、512 KiB 上限和异步写入。lastRestoreFailure 是历史最后失败，需要结合时间、pluginVersion、lastRestore 判断当前结果。突然结束进程可能丢失尚未落盘的尾事件，不把无事件当作成功证据。没有写入配置 payload、密码或图片数据；错误文本、路径可能含文件名或现有联系人标识。

## 验证与构建

本次运行 **12 个核心回归脚本、851 项检查通过**，详见 [validation.json](validation.json)。数字只计本轮执行，不混入 2.0-4 的检查或故意复现旧故障的检查。

新增 [BackupCompatibilityTests.m](../../../Tests/BackupCompatibilityTests.m) 的 66 项检查包括：

- 本机新建备份与旧插件版本导出后导入的备份，两者都完成 PNG、字段、prepared、committed、activation 和归档。
- 合成旧来源甚至故意把捕获图片根放在 Application Support，随后删除整个来源目录；便携载荷仍可按当前根完整恢复。此场景用于验证路径解耦，不代表实际历史版本使用这个资源根。
- 有合法完整性摘要但含绝对旧图片路径的载荷明确拒绝；缺少资源明确报错；保留原件，不创建 journal。
- 选包 meta 镜像损坏时记录 warning，完整快照仍可恢复；各读写阶段实际落盘到被动审计。
- 真实跨进程 prepared 失败和自动撤销；同进程重试不提前取消；启动标记后强制退出仍能收尾。
- 写尝试标记失败时不修改配置；归档失败保留终态，重试成功仍显示原因；后续用户修改不被过期 before 覆盖。
- source/protection 快照均保留；损坏的 startupAttempt 不崩溃、不重写原 journal、不自动删除。

其余核心覆盖：恢复路径 249、事务崩溃与回滚 89、启动入口和 Manager 46、Codec 16，以及 Store、Assets、Reset、Audit、Bootstrap、Retention。测试全部使用临时目录、独立 NSUserDefaults suite；没有操作用户手机数据。

正常运行：

```sh
bash Tests/verify-backup-compatibility.sh
```

重放旧 prepared 缺陷（保留的旧引擎和旧测试入口）：

```sh
CS_COMPAT_ENGINE_SOURCE=docs/audits/restore-compatibility-2.0-5/before/CSBackupEngine.m \
CS_COMPAT_TEST_SOURCE=docs/audits/restore-compatibility-2.0-5/before/BackupCompatibilityTests.m \
  bash Tests/verify-backup-compatibility.sh --expect-stuck
```

重放结果：[repro-prepared-replay.log](repro-prepared-replay.log)。

使用新的隔离构建目录，保留仓库 `.theos` 及历史包，无 make clean。两种包均含 arm64/arm64e；验证版本、dSYM UUID、首个迁移构造函数、恢复收尾符号、旧清理 hook 及测试 shim 缺席。日志：[Rootless](build-rootless.log)、[Rootful](build-rootful.log)。核验及 SHA-256：[packages.json](packages.json)、[source-sha256.json](source-sha256.json)。

- [2.0-5 Rootful deb](../../../packages/com.wechat.improve_2.0-5_iphoneos-arm.deb)
- [2.0-5 Rootless deb](../../../packages/com.wechat.improve_2.0-5_iphoneos-arm64.deb)
- [2.0-5 调试符号](../../../packages/com.wechat.improve_2.0-5_symbols.zip)

这些是插件包，未越狱签名 IPA 继续按现有注入签名流程使用 dylib。尚未进行真机恢复验收。

## 下一步现场判别

首先需要现有 transaction.plist 的 **state、sourceID、transactionID**。这三个字段可直接区分 prepared 悬挂与 applying/rollingBack，并确认是否真的在恢复 C4141078；无需先发送 before/after 配置值。

在 2.0-5、解锁设备且旧事务已处理完的条件下，按用户提出的顺序分别恢复 C312A467、C4141078。每次准备后完整退出微信进程再重开，记录：备份 ID、发生阶段、最终提示、期望设置/图片是否生效。两次实验会改变插件配置，应保留现有保护备份，并在上一条事务结束后再开始下一条。

- 两条都成功：说明旧代码缺陷修复有效，但不能仅凭结果回溯确定原始失败点。
- 新备份成功、导入备份失败：检查新审计的 read-snapshot/validate/asset-reference、来源版本、1007/1008 等错误，再检查实际 C4141078 载荷。
- 两条都失败：看最早失败阶段及底层错误，区分账号/配置检查、资源权限、原子写入或回滚问题。

若仍失败，请提供失败时间、弹窗/状态页原文，以及新版审计的 lastRestoreFailure 和对应 restore-* 事件。进一步判断导入内容时，需要 C4141078 的 formatVersion、source.pluginVersion、资源字段引用类型与缺失资源摘要；仅凭字节大小无法完成这一步。
