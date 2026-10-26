# 本机配置备份消失：删除链路取证与 2.0-2 修复

> 历史记录：本文描述迁移前路径与当时方案。2.0-3 已改用 Preferences 下 BackupV2/CloseFriends 并移除清理拦截；当前实现见 [存储迁移记录](../preferences-storage-migration-2026-10-24/README.md)。

本轮基线：`64aac104`，插件原版本 `2.0-1`。用户补充：真机 `Library/Application Support/WeChatImprove/BackupV2/` 内确实没有 `.wcbak`。本报告取代“只看备份模块没有发现清空调用，所以不是代码删除”的推断；此前列表/权限分析仍可作为其他现象的说明，不能解释已经确认的文件消失。

## 结论与证据强度

**已定位一个能够自动清掉本机备份的宿主兼容缺陷：微信的全容器磁盘扫描把未登记的插件备份识别为未知文件，然后移入垃圾目录并删除。** 在本机可用的微信 8.0.78 原生样本中，已贯通扫描根、完整编译期路径规则、未知文件分类、删除开关、保留策略和最终文件系统 API。`Application Support` 的 iOS 持久化语义并不阻止宿主微信主动清理它。

**同时确认并复现插件内的另一条删除缺陷：图片设置直接删除偏好中的任意路径，异常值可以递归删掉 BackupV2 或其父目录。** 正常选图与当前 V2 恢复不会自然生成这种值，因此只能证明缺陷及触发条件，不能把构造条件当作真机既成事实。

**尚不能确认用户这一次丢失的唯一执行者。** 未连接用户设备，未取得其真实微信二进制、运行时清理开关、路径偏好及删除时调用栈；静态样本还有热补丁/追加规则入口。这里确认的是实际代码缺陷与可达删除链路，并非声称已在真机观察到那次删除。2.0-2 修复已知链路并增加审计，让后续设备记录能直接归因。未卸载、签名、替换或操作用户的真机数据。

## 原生微信证据：全容器扫描 → 未知文件 → 移动 → 删除

样本 `/tmp/wechat-8.0.78-inset-analysis/WeChat`，arm64 Mach-O，SHA-256：

`0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`

使用 reverse-engineer-anything 工作流绑定目标；当前只有 Ghidra provider 可用，未对 567 MB 样本做全量自动分析。使用已有 Mach-O/Objective-C 元数据解析器及限定地址范围的 LLVM 反汇编补充只读取证。方法身份来自 ObjC 元数据；汇编中的邻近导出标签（如 Flutter 名字）不是该函数的身份。

| 环节 | 样本位置与证据 | 含义 |
|---|---|---|
| 扫描根 | `+[MMDiskUsageScanData scanRootDir]`，`0x1029b095c` | `GetDocumentPath` 后删除最后一层，得到整个 app 数据容器，不限于 Caches/tmp |
| 规则表 | `0x1029a274c`，1046 条完整规则；[规则取证](native/path-rule-findings.md)、[原始规则记录](native/compiled-path-rules.json) | root-prefix 规则 276 条；Application Support 只有三个具体子项，无 WeChatImprove、BackupV2 或可继承的通配保护 |
| 祖先继承 | `matchBizWithChildFolder:parentFolder:`，`0x1029a010c` | 规则只按当前路径组件匹配；无规则且无继承标记时，`bizType=2`、`storeTimeType=9` |
| 文件分类 | `fileMatchedBizType:inFolder:`，`0x1029a0568`；默认常量 `0x118d84a80` | 文件默认 `{2,9,0x7ffffffe,0}`。与目录输出的后两个字段不同，不混为同一个结构体值 |
| 删除默认配置 | `-[MMDiskUsageConfigHandler loadConfigFromX]`，`0x1029abae8` | `m_isDelete`、`m_isDeleteUnknow` 等初始默认开启；设备运行值仍须审计/调试确认 |
| 文件保留策略 | `deleteFile:matchInfo:...`，`0x1029c2914–0x1029c2928` | timeType=9 直接置可删标记，并跳过按文件年龄计算的等待；不是“必须备份满若干天” |
| 删除分支 | 同方法 `0x1029c3100–0x1029c3150` | 可删标记 + 删除开关 + 分类2 + 未知删除开关 → `DeleteBizUnknowFile:` |
| 宿主入口 | `+[MMDiskUsageUtil DeleteBizUnknowFile:]`，`0x1029c9484` | 调用 `moveFileToTmpTrash:description:`，描述为 `(bizUnknow)` |
| 最终文件操作 | `moveFileToTmpTrash:description:`，`0x1029c9610`；`0x1029c9770` 移动，`0x1029c9788` 删除 | 先 `movePath:to:`，成功后立即 `removePath:` 删除目标；底层分别为 NSFileManager move/remove API |
| 垃圾位置 | `pathOfTrash` block `0x1029c9f08`；[基路径导入解析](native/trash-base-import.txt) | `NSTemporaryDirectory()/DiskScanTrash/yyyy-MM-dd_HH/File/<随机数>_<原文件名>`；文件移动后会立即删，不是可靠回收站 |
| 目录清理 | `handleDeleteFolder:withFolderPath:withScanStat:` 及 `DeleteBizUnknowDir:` | 目录分支另有条件；不能把文件的即时策略等同于所有目录立即删除。目录搬入同一时间目录的 `Folder/`，后续还有垃圾清理 |

默认配置中可见 300 秒扫描间隔和 14400 秒 finish-scan 间隔，另有紧急程度/运行状态检查；这说明有自动触发机制，**不能据此承诺每 5 分钟/4 小时一定清理，也不能用它反推用户 8 点后的准确删除时间**。

这条路径能同时移除 `.wcbak`、`.meta`、`.meta.bak`、`cleanup.plist` 等未知子文件，不会理会插件写在元数据里的“手动备份/收藏/导入保护”。因此即使插件的 prune 正确保护手动备份，宿主清理仍可留下空目录。完整汇编、工具脚本和哈希见 [native/manifest.json](native/manifest.json)。

## 修复前生产源码：所有删除/重命名调用

以下是基线 `64aac104` 的行号，修复后行号可能变化。搜索边界为 `Controllers/`、`Hooks/`、`Headers/` 中所有生产源码，检查 `removeItem`、`unlink`、`rmdir`、`removefile`、`unlinkat`、`rename`、旧删除 API、move/replace API。共 15 个相关调用点：11 个 NSFileManager 删除、2 个 unlink、2 个 rename。没有备份根目录整体替换调用。表中图片问题不是凭名字猜测，而是已运行原方法复现。

| 调用点（修复前） | 触发条件与实际目标 | 对备份的判断 |
|---|---|---|
| `CSBackupStore.m:50` `rename` | 完整写入/fsync 后，同目录 `.pending-UUID` → 单个目标文件 | 会发布/替换单文件；不移动或替换 BackupV2 目录 |
| `CSBackupStore.m:52` `unlink` | 原子写入失败，清理本次 pending | 仅本次临时文件，不删旧 `.wcbak`；rename 后 fsync 失败也不把已发布文件删掉 |
| `CSBackupStore.m:142` `removeItemAtURL` | 用户在备份页确认删除，或 prune 选中可轮转备份 | 删除一个 UUID `.wcbak`；活动事务 source/protection 受保护 |
| `CSBackupStore.m:145` `unlink` | 上一步成功后 | 删除同 UUID 的两个普通元数据文件 |
| `CSBackupStore.m:208` `removeItemAtURL` | 事务成功归档为 last-transaction 后 | 只删 `transaction.plist`，不是快照或整个根目录 |
| `CSBackupEngine.m:161` `removeItemAtURL` | 恢复/回滚/重置时应用资源记录中的“缺失”状态 | 目标在 `Library/Preferences/WeChatImprove`，当前资源名/引用验证不允许 BackupV2 |
| `CSBackupSettingsViewController.m:161` `removeItemAtURL` | 分享结束或取消 | 只删 `tmp/WeChatImproveBackupExports` 导出副本；原 `.wcbak` 不作为分享 URL |
| `CSCloseFriendStore.m:103` `rename` | 密友状态完整提交 | 密友专用 CloseFriends 目录的单文件，不是 BackupV2 |
| `CSCloseFriendStore.m:104` `removeItemAtURL` | 密友状态提交失败 | 只清其 staged 文件 |
| `CSNavigationTitleSettingsViewController.m:1093` `removeItemAtPath` | 导航分隔符由图片切回文字并确认 | **偏好路径未验证，可递归删 BackupV2/祖先**；异常偏好是必要条件 |
| 同文件 `:1241` `removeItemAtPath` | 点击删除分隔符图片 | 正常固定目标 `Preferences/WeChatImprove/separator_image.png`；本次一并收紧 |
| 同文件 `:1419` `removeItemAtPath` | 保存图片时资源根已存在且不是目录 | 目标固定为 Preferences/WeChatImprove；正常路径不能清备份，指向目录的末级 symlink 被判为目录，不进入该分支 |
| `CSTabBarStyleSettingsViewController.m:734` `removeItemAtPath` | 清除当前普通图标 | **偏好路径未验证，可递归删 BackupV2/祖先** |
| 同文件 `:737` `removeItemAtPath` | 清除当前选中图标 | 同上 |
| 同文件 `:938` `removeItemAtPath` | 底栏样式 → 恢复默认 → 确认；遍历8个图标键 | 同上；与备份页面的“重置保护”不是同一个操作 |

图片原方法复现保存在 [image-path-reproduction/](image-path-reproduction/)：25 项通过，真实 Store 先创建有效手动备份，再执行完整提取的生产 `clearCustomIcon`。直接目录、父目录、中间 symlink 路径均可真实删除备份；之后 Store 读取会自动建空目录。末级 symlink 只删链接自身，正常 PNG 不影响备份。正常选图固定写 PNG；当前 V2 的 capture/materialize 校验不会把 BackupV2 目录当作合法图片写回，因此仍须现场路径或调用栈才能把此缺陷与实际事件关联。

## 对用户提出的其他方向逐项回答

- **列表数据源**：`CSBackupStore.records:` 直接扫描当前 BackupV2 的 `.wcbak`，没有列表 manifest。`.meta/.meta.bak` 是名称、收藏、导入保护元数据。坏快照保留为“无法读取”，不删除原件。账号、epoch、安装ID不参与列表过滤。读目录失败也可能让 UI 显空，但不适用于已确认物理文件消失的证据。
- **主动轮转**：在新快照发布成功后才 prune。普通自动备份保留20份，升级/保护合计5份；手动、导入、收藏、活动事务引用不计入可清理集合。保护状态不明时保留；不是容量不足就清空全部。`cleanup.plist` 是清理结果诊断，不是列表索引。
- **写入/失败回滚**：同目录 pending → 完整 write → fsync → 单文件 rename → 目录 fsync。进程中断可能留下 pending、元数据或刚发布快照；没有“备份前清空旧目录”。从空库首次写入被中断会无成品，但不能解释已成功落地的旧快照消失。恢复回滚保留保护快照，只处理偏好、受控资源和事务日志。
- **整体替换**：插件没有 staging 目录整体替换 BackupV2。宿主的未知目录清理会把目录移到垃圾区，这与原子提交不是同一件事。任何下次 `records:` 都可能通过 `Directory()` 重建缺失目录，导致最终看到一个新空目录。
- **账号切换/退出**：epoch 防止混合捕获和跨账号恢复，未发现切换时清空备份根目录。不能用账号过滤解释物理空目录。
- **升级/格式迁移**：V2 路径不带插件版本。插件更新创建升级保护快照，不重建/清空 BackupV2。旧版本扫描来源的变化不解释当前 `.wcbak` 刚创建又消失。没有主动跨数据容器 UUID 迁移。
- **系统回收/更新覆盖**：BackupV2 位于数据容器的 Application Support，非 app bundle、Caches 或 tmp；正常原位升级保留数据容器内容，不因换 dylib 覆盖它。但卸载重装、签名工具改变 bundleID、分身或重新创建容器可能换成全新数据；容器 UUID 变化本身也不证明内容丢失，系统更新可迁移已有数据。
- **自动备份/云端/重置保护**：自动备份可能触发上述限定轮转；当前没有会同步删除本地文件的云端备份实现。重置保护先保存保护快照，操作偏好与受控图片；不清备份库。宿主未知文件清理独立于这几个插件开关。
- **测试/自检/开发清理**：测试使用临时目录，不编入 dylib。Makefile 的 clean 只删开发机 `.theos packages`，与手机目录无关。本轮构建使用独立临时 Theos 目录，未执行 make clean。

## 2.0-2 的具体修复

1. `CSBackupFileProtection` 在验证真实方法参数/返回值后，保护微信 `MMDiskUsageUtil` 的 `moveFileToTmpTrash:description:` 和 `moveFolderToTmpTrash:description:`。仅目标等于备份目录、位于其中或为其祖先时拒绝；规范化路径并考虑中间 symlink。拒绝返回原生失败值 nil，不谎报成功。普通缓存/其他文件仍交给原方法。未改备份根路径、格式、账号归属或历史保留策略。
2. `CSManagedImageFile` 替换图标和分隔符的未约束删除：从受控资源根逐级 openat(O_NOFOLLOW)，只接受普通 PNG，最终 unlinkat(...,0)。目录/异常链接/越界路径不会被递归删除，异常偏好仍可清除。用目录 fd 避免检查后目录被替换导致递归误删。
3. 备份 Store 在实际成功发布后写诊断回执；记录用户/轮转删除及目录内容变化。增加 Foundation remove（路径/URL）、move（路径/URL）、replace 的定向审计，**观察其他调用者但不改变这些系统 API 的结果**。宿主拦截与系统审计分开；没有全局禁用微信清理，也未添加周期轮询。
4. 审计在 `<当前容器>/Library/Preferences/com.wechat.improve.backup-audit.plist`，不放在 BackupV2 或 WeChatImprove 父目录里。含最近成功发布的ID、目录身份/文件名快照、时间、PID、调用栈、宿主版本/镜像UUID及操作前后结果；不含备份正文。最多96条事件，持久化上限512 KiB，原子写；审计失败不使备份失败。
5. `hooks-installed.unavailable` 标明不存在或 ABI 不兼容的宿主入口；新版本微信改变方法时不会强行套用旧原型。**此兼容保护针对已核验的入口，不声称拦住所有未来微信版本、所有直接 libc 系统调用或进程外清理。** 真机宿主不匹配时需据记录继续适配。

## 真机核验与取证方法

先复制现有 BackupV2 和审计 plist 到容器外的可保留位置，再观察；不要为复现去卸载、清空微信或恢复默认。非越狱签名安装可继续使用用户已能读取目录的工具；Filza 仅在设备确实能使用时适用。

1. 记录当前 app 的 bundleID、微信/插件版本、完整数据容器 UUID 路径和安装方式。看 `BackupV2`、其 `WeChatImprove` 父目录、Application Support、Library 的创建/修改时间，能看到 inode 时也记录。原目录出生时间未变而 mtime 更新，与“逐文件删空”相容；目录出生时间/inode变新，与删除/搬走后重建相容。单独时间戳不能识别删除者，复制/迁移也能改变它。
2. 比对备份成功时记录的同一容器路径；查看工具列出的历史容器/同 bundleID/签名分身映射，而不是只凭目录名相似判断。越狱可查容器管理元数据映射；非越狱应用通常无权枚举其他数据容器，插件也不会跨容器找回。新 UUID 且偏好/其他插件文件也为新内容，才更支持新安装环境；只有 UUID 变了不能单独定案。
3. 打开隐藏文件显示，检查 `.pending-*`、`.meta`、`.meta.bak`、`transaction.plist`、`cleanup.plist`。只有 pending 支持尚未提交，但没有 pending 不排除被清理。若所有类型一起没了，更应查宿主或整目录操作。
4. 检查 `tmp/DiskScanTrash/<日期_小时>/File/` 与 `Folder/`；如有残留先复制再解析，不能直接改名覆盖现库。文件分支移动后立即删，找不到残留不能排除该清理者。宿主原生日志关键词：`Succ move file(bizUnknow) to trash and delete!`、`srcFile=`、`dstFile=`、`Fail to move file`、`[Auto]...disk scan trash`。微信日志可能为专有格式/需工具解码，不能保证系统 Console 有对应内容。
5. 安装本修复的注入包后，记录新建手动备份的UUID和 `published` 回执，再正常使用。`blocked-native-trash` + 调用栈 + 对应目标路径即直接确认微信曾试图清理该备份且已被拦截。`filesystem-before/after` 以 operationID 配对，能区分其他进程内 Foundation 删除、移动、替换及失败；`remove-requested/removed` 可识别插件主动删除。`inventory` 里的 directoryExistedBeforeRead=false 和 previous 非空说明发生了缺失后重建。
6. 若只有 inventory 丢失、无对应操作事件，仍需考虑直接 unlink/rename、其他插件底层调用、进程外清理、未加载新 dylib、审计写失败或容器切换。新包只覆盖上面明示的观测边界，不能事后从 APFS 时间戳还原调用栈。可调试的签名构建中可对 `MMDiskUsageUtil` 两个方法、NSFileManager remove/move，以及 libc unlink/unlinkat/rmdir/rename 下符号断点，筛选目标路径后收集 backtrace；普通非调试签名可能无法附加调试器。

macOS 上收到审计文件后可用 `plutil -p <复制出来的审计文件>` 查看；需要结构化分析时 `plutil -convert json -o <新文件> <审计副本>`。不要转换/覆盖真机原件。日志里的路径、镜像UUID、ID足够用于归因，分享前可遮挡容器UUID等识别信息。

## 核心回归与产物

**495 项核心回归通过；Rootless 与 Rootful 的 arm64/arm64e 双架构构建均通过。** 包内 control 版本、插件版本字串、新增保护符号及两种架构已核对；4 份 dSYM 的 UUID 与对应 dylib 匹配。最终结果见 [validation.json](validation.json)、[包哈希与成员记录](packages.json) 和构建日志。测试只使用独立临时目录/测试偏好，没有修改用户微信数据。

- `bash Tests/verify-backup-file-protection.sh`：真实文件系统 + 真实生产 Store/保护/审计；宿主入口为按已验证原生契约实现的测试替身，并非运行 iOS 微信。覆盖未保护时文件消失/根目录重建、修复后文件/目录/祖先保护、正常缓存清理、用户主动删除、错误返回、审计持久化与界限。
- `bash Tests/verify-managed-image-files.sh`：目录/父目录/中间链接/末级链接与目录替换竞争等边界；另含抽取实际页面 clearCustomIcon 的集成回归。
- 现有备份核心：store、retention、transactions、reset。验证历史保留策略、事务回滚与重置不受修复影响。

本轮没有真机安装、锁屏长时间运行或用户签名 IPA 集成验收。生成 deb 不代表已更新用户手机；非越狱设备仍应通过既有的 IPA 注入签名流程集成 dylib，并保留原数据完成设备核验。

产物：

- [2.0-2 Rootful deb](../../../packages/com.wechat.improve_2.0-2_iphoneos-arm.deb)
- [2.0-2 Rootless deb](../../../packages/com.wechat.improve_2.0-2_iphoneos-arm64.deb)
- [对应符号归档](../../../packages/com.wechat.improve_2.0-2_symbols.zip)
