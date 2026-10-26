# 2.0-4：备份存在但恢复失败的排查与修复

日期：2026-10-24。接续 2.0-3 Preferences 存储迁移，当前真机反馈为 `.wcbak` 与列表记录都存在，但恢复不成功。用户未提供失败弹窗、发生阶段及现场恢复审计；本次没有连接用户手机。

**已复现并修复一个明确缺陷：2.0-3 图片删除 helper 从 `/` 开始逐级打开祖先目录，恢复和回滚因此依赖容器外目录的读取权限。** 在“容器内部可读写、外部祖先目录不可打开”的隔离故障注入中，旧代码恢复失败，回滚再次失败，事务停在 `rollingBack`。修复后同一条件下完整恢复通过。

这是受控实验和源码共同证明的代码缺陷，符合签名 IPA 的沙箱使用条件，但**不等同于已经唯一确认本次真机失败原因**。用户尚未说明失败发生在预览、准备还是下次启动应用；2.0-4 同时补齐了具体错误提示和阶段审计以区分这些情况。

## 五项排查结论

| 怀疑方向 | 验证结果及处理 | 代码入口 |
| --- | --- | --- |
| 新旧路径不一致、无旧目录仍 pending | 未复现。新目录单独存在时迁移返回成功、`lastError=nil`；新旧并存的相同快照和待执行事务可合并后恢复。同名不同内容的冲突会保留两侧文件并拒绝继续写入。快照、journal、activation 通过兼容读路径读取，写入先通过迁移检查，再写新根。 | `CSPluginStorage.m` 的 `relocate/readRoots/readURLForName`；`CSBackupStore.m` 的 `prepareForReading/prepareForWriting/readURL/snapshot/readJournalContent` |
| 收紧图片清理的副作用 | **已复现缺陷并修复。** 引擎会为需要清除的 PNG（包含恢复成默认状态时的 fallback PNG）调用 helper。旧 helper 打开 `/` 失败后，恢复与回滚都失败；不是因为新目录下已有目标文件。新 helper 直接打开资源根，并通过 `F_GETPATH` 核对已打开 vnode 的实际路径。直接子级、普通 PNG、防符号链接及 `unlinkat(...,0)` 限制保持。 | `CSManagedImageFile.m` 的 `CSOpenImageDirectory/CSManagedImageRemoveInDirectory`；`CSBackupEngine.m` 的 `writeFields` |
| Preferences 的 Data Protection / 原子写入 | 代码未把 `.wcbak` 当偏好数据库管理；快照和 journal 均是普通文件。原子写入在同一父目录创建 `.pending-*`，写入并同步后 `rename`，再同步父目录；iOS 分支已有 `NSFileProtectionCompleteUntilFirstUserAuthentication`。未降低保护等级。macOS 隔离测试可验证流程与权限失败处理，**不能证明用户 iOS 文件属性或锁屏时访问一定成功**。此次保留底层 errno、操作名及路径，避免统一错误掩盖权限或磁盘问题。 | `CSBackupStore.m` 的 `CSBackupReadFile/CSBackupAtomicWrite`；`CSBackupAssets.m` 的 `ReadAsset/AssetReadError` |
| 启动门禁、账号 epoch、错误提示 | 恢复本来就在下一次进程启动执行，切换前后台不会执行；账号未就绪、账号改变或交接 epoch 不匹配仍阻止应用。现在操作失败保证返回 NSError，预览/准备显示具体原因，启动失败持久保存到备份页。不是通过放开账号门禁使测试通过。 | `CSBackupManager.m` 的 `performRestore/restoreError/resolveStartup/retryPendingWork`；两个备份界面控制器 |
| prepared 成功、应用失败、误回滚 | 新目录单独存在及新旧并存的完整事务都通过。旧 helper 可在 `prepared → applying` 后失败，又在回滚删除图片时失败而留在 `rollingBack`。修复后解除真实资源目录访问失败条件，可完成回滚；原快照保留。未发现“仅因为剩一个目录”就误回滚。 | `CSBackupEngine.m` 的 `applyPendingContent/finishStartupContent/rollbackBeforeActivation/confirmStartupContent` |

当前文件布局保持 2.0-3 方案：

```text
Library/Preferences/WeChatImprove/
  BackupV2/                 # .wcbak、metadata、transaction.plist、activation.plist
  CloseFriends/             # 密友独立数据，不参与图片清理
  separator_image.png       # 资源根的直接子级图片
  touch_trail.png
  …
Library/Preferences/com.wechat.improve.backup-audit.plist
```

`Application Support/WeChatImprove/BackupV2` 只作为旧数据兼容和迁移来源；不会重新成为备份写入根。此次没有修改密友格式、账号隔离、密码或名单逻辑，没有重新加入拦截微信清理的 hook。

## 可重放的缺陷证据

初次运行真实 Store/Engine 恢复流程、仅替换图片 helper 的 `open` 调用以拒绝容器外祖先目录，旧代码结果见 [repro-before.log](repro-before.log)：

```text
REPRO merge-0-deny-1: domain=NSPOSIXErrorDomain code=1 deniedRootOpens=2 journal=rollingBack
REPRO merge-1-deny-1: domain=NSPOSIXErrorDomain code=1 deniedRootOpens=2 journal=rollingBack
```

`merge-0/1` 分别表示仅新目录和新旧并存；`deniedRootOpens=2` 来自应用一次、回滚一次。当时的 helper 已保存为 [before/CSManagedImageFile.m](before/CSManagedImageFile.m)。在仓库根目录可重放：

```sh
CS_RESTORE_IMAGE_SOURCE=docs/audits/restore-paths-2.0-4/before/CSManagedImageFile.m \
  bash Tests/verify-backup-restore-paths.sh --expect-ancestor-denial
```

后续加入错误包装后重放仍失败，公开错误为 `CSBackupRestore/1003`，底层保留 POSIX `EPERM`，结果见 [repro-before-current-harness.log](repro-before-current-harness.log)。测试脚本先引入系统头、再声明 syscall shim，并通过 `nm` 检查对象确实调用 shim，避免 Darwin `open` 的 asm alias 造成假注入。

这里使用的是受控 syscall 失败注入，**不是 iOS 真机沙箱日志，也不是一次实际手机恢复测试**。测试保留正常的容器内文件读写，故障只针对指定操作。没有使用测试 shim 构建交付包。

## 修复和诊断行为

- 图片 helper 直接打开可信资源根；`F_GETPATH` 核对实际打开的 vnode，而非在打开前做一次易受竞态影响的路径检查。仍拒绝跨根路径、嵌套 PNG、非普通文件及祖先符号链接重定向。
- 读取、临时文件创建、写入、同步、原子替换等失败保留真实 `NSError` 链，附带 `NSFilePathErrorKey`、`operation`。图片读取被外层中文文案包装时也保留底层原因；实际权限失败不会伪装成“图片校验失败”。
- `CSBackupRestore` 错误分类：`1001` 迁移未完成、`1002` 文件或配置校验失败、`1003` 读写权限失败、`1004` 存储操作失败、`1005` 需要完整重开微信、`1006` 账号/配置等恢复条件未满足。底层错误仍可从 `causes` 查询。
- “恢复已准备”明确表示尚未应用，需要完全退出微信进程后重开。启动失败原因持久保存于 `com.wechat.enhance.backup.last_restore_error`，展示在“恢复未完成 · 查看原因”和恢复管理说明中；该诊断 key 不加入配置备份登记表。
- 准备新计划、明确取消计划或成功应用并交接后清除界面的旧失败提示。审计的历史失败保留，读取时应同时检查时间和后续成功阶段。

审计依旧只旁观，异步写入：

```text
Library/Preferences/com.wechat.improve.backup-audit.plist
```

| 事件 | 含义 |
| --- | --- |
| `restore-selected` | 选包及读取；包含快照标识、文件名和可读目录 |
| `restore-validate` | 快照、配置和资源预览校验 |
| `restore-prepare` / `restore-prepared` | 准备保护快照及计划；`restart-required` 表示等待完整重开 |
| `restore-transaction` | journal 写入结果，包含 state、transactionID 和路径 |
| `restore-startup` / `restore-apply` / `restore-journal-read` | 启动进入、应用和日志状态读取 |
| `restore-write-resource` | 单项 PNG 写入或删除，包含实际资源路径与 action |
| `restore-write-preferences` | 配置写回及回读核验 |
| `restore-applied` | 引擎写入成功，磁盘状态为 `committed`；仍需 verify 和 activation |
| `restore-write-back` / `restore-failure-cleanup` | 应用失败，以及回滚开始、失败或完成 |
| `restore-verify` / `restore-activation` | 启动核验及持久交接确认 |
| `restore-account-handoff` / `restore-cancel` | 账号交接失败或主动取消 |

阶段公共字段含 `stage/status/path/writeRoot/readRoots/journalPath/errorCode`；失败包含 `errorDomain/error/causes`，每层 cause 保留 domain、code 以及可获得的操作名、路径。成功的 `errorCode` 为 0。顶层 `lastRestore` 保留最近阶段、`lastRestoreFailure` 保留最近失败。

没有增加配置 payload、PNG 内容、密码或密友名单记录；路径和错误文本可能包含文件名或现有错误文案中的联系人标识，分享前可对这些标识脱敏。事件限制仍为 96 条、文件上限 512 KiB。异步审计在进程突然被杀时可能丢失尚未落盘的尾部事件，不能把“没有失败事件”当作成功证明。审计不挂钩删除 API、不阻塞或改变微信清理行为。

事务格式兼容：磁盘状态仍是 `prepared → applying → committed`，失败分支为 `rollingBack → rolledBack`；审计中的 `applied` 不是新的磁盘状态。

## 隔离回归与构建

核心测试共 **992 项检查通过**，包含新增恢复路径 237 项、图片清理及真实控制器集成 154 项、启动入口与 Manager 集成 44 项；完整列表见 [validation.json](validation.json)。初次及后续旧代码复现检查不计入 992 项。

新增 [Tests/BackupRestorePathTests.m](../../../Tests/BackupRestorePathTests.m) / [verify-backup-restore-paths.sh](../../../Tests/verify-backup-restore-paths.sh) 使用随机临时 `Library` 和独立 NSUserDefaults suite，运行后清理，不操作用户微信容器：

1. 新目录创建带 PNG 的快照，完成保存、读取解码、预览、保护快照及 `prepared` 写入。
2. 新旧并存时合并相同快照；模拟重开前两目录同时存在相同 `transaction.plist`。
3. 重新创建 Store/Engine，应用 PNG 增删与配置、回读校验、写 `committed`、确认 activation、下一次启动归档。
4. 拒绝外部祖先目录打开时仍恢复成功；拒绝资源根本身访问时明确失败并留待回滚，解除限制后恢复保护前像。
5. 同名冲突、损坏快照、损坏 journal 分别可见报错；非 root 测试进程以 `chmod 0000` 制造真实图片读取权限错误，验证错误链及读取权限文案。
6. `create-temp`、`rename`、`fsync-file` 注入失败保留原始错误和旧文件，仅清理本次临时文件。这里验证的是 rename 前失败；rename 成功后父目录同步失败的持久性边界仍按原事务设计处理。
7. 通过真实被动审计对象落盘验证阶段/错误字段；检查 BackupV2 与 CloseFriends 子目录内容保持完好。

其余核心覆盖备份读写、资产、事务中断回滚、重置、历史轮转、存储迁移和启动门禁。UI 改动完成 iOS 编译；没有把 macOS 的 Foundation 测试当作 UIKit 真机交互验收。

两种 deb 均使用独立临时构建目录，不清理仓库 `.theos` 和历史包。最终构建日志：[Rootless](build-rootless-final.log)、[Rootful](build-rootful-final.log)。打包检查脚本 [verify-packages.py](verify-packages.py) 核验版本、arm64/arm64e 切片、dSYM UUID、首个迁移初始化函数、旧清理拦截缺席、新恢复诊断存在及测试 shim 缺席；结果及 SHA-256 见 [packages.json](packages.json)。源码快照指纹见 [source-sha256.json](source-sha256.json)。

交付：

- [2.0-4 Rootful deb](../../../packages/com.wechat.improve_2.0-4_iphoneos-arm.deb)
- [2.0-4 Rootless deb](../../../packages/com.wechat.improve_2.0-4_iphoneos-arm64.deb)
- [2.0-4 调试符号](../../../packages/com.wechat.improve_2.0-4_symbols.zip)

这是插件 deb，并非重新签名的 IPA。未越狱设备继续按既有流程从合适的包中提取 dylib，注入 IPA 并签名；文件名中的 `iphoneos-arm` 是包管理架构，两种包内动态库均包含 arm64/arm64e。

## 真机复核步骤与需要的现场信息

升级后先解锁设备，完整退出并重开微信。若 2.0-3 留下 `applying/rollingBack`，2.0-4 会优先恢复保护前像，并提示“已回滚到恢复前配置”；**完成回滚不代表目标备份已经应用**，此时在备份页重新选择目标备份并准备恢复，再完整退出并重开。

如仍失败，请保留源 `.wcbak`、`transaction.plist`，提供：

1. 发生在“点备份/打开预览”“确认准备”还是“完整重开后”的哪个阶段，以及失败弹窗或状态页的原文。
2. 微信版本、iOS 版本及大致失败时间。
3. 审计文件中的 `lastRestoreFailure`，以及相同时间的 `restore-*` 事件；特别是 `stage/status/path/errorDomain/errorCode/causes`。同时查看 `lastRestore`，避免把旧失败当作最新状态。
4. 如有 transaction，仅需先提供 state 和 transactionID；无需发送配置 payload 或图片内容。

若最早失败为 `restore-write-resource` 且底层 `EPERM/EACCES`，结合 path 可进一步区分资源根访问、删除和文件保护问题；若停在 `prepared/restart-required`，先确认是否真正退出了进程；若错误为迁移或校验，按对应底层原因排查，不能用删除事务或清空备份目录来“修复”。
