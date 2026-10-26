# 2.0-3：备份与密友 Preferences 存储迁移

本版按新的方案移除 2.0-2 的全部清理拦截，将两个持久化目录迁入微信已知 Preferences 分类范围。原本的微信清理、移动和删除行为全部放行；插件只管理自己的目录与文件。

## 原生规则结论

对微信 8.0.78 样本，完整 1046 条编译规则中 index 112 将 `Library/Preferences` 标记为 `bizType=33, storeTimeType=1, class=4, fileType=0x7fffffff`。目录分类会逐层继承到 `WeChatImprove/BackupV2`、`WeChatImprove/CloseFriends` 及普通文件；没有相应子规则覆盖。`storeTimeType=1` 将可删除标志保持为 0，绕过已确认的未知文件和普通业务文件删除调用。

这并非“Preferences 完全不会被扫描”。空目录在本样本中仍可能在约 14 天后被移除，非空备份不满足该空目录入口。其他业务回调、运行时扩展、动态规则与未来版本未被穷尽；本次没有连接用户真机，不能把静态分析写成现场删除者日志。精确指令地址、规则表与已检查入口见 [native-findings.md](native-findings.md)。

## 当前路径与迁移

| 数据 | 新路径（相对当前微信容器） | 旧路径用途 |
| --- | --- | --- |
| 备份、元数据、恢复事务、pending | `Library/Preferences/WeChatImprove/BackupV2/` | `Library/Application Support/WeChatImprove/BackupV2/` 只作迁移来源及失败时只读兼容 |
| 按账号加密的密友名单与策略 | `Library/Preferences/WeChatImprove/CloseFriends/` | `Library/Application Support/WeChatImprove/CloseFriends/` 只作迁移来源及失败时只读兼容 |
| 自定义 PNG 资源 | `Library/Preferences/WeChatImprove/` 的直接子文件 | 不迁移资源根 |
| 被动审计 | `Library/Preferences/com.wechat.improve.backup-audit.plist` | 保留既有位置 |

公共模块 `Controllers/CSPluginStorage.h/m` 集中路径与迁移逻辑。两个业务 Store 的生产初始化固定指向新目录。没有跨容器搜索或迁移，没有写回旧目录，也没有清空目录或以空索引重建目录。

- **旧目录独有**：使用同容器 `renameatx_np(..., RENAME_EXCL)` 原子改名，不覆盖同时出现的目标；保留 inode、原始字节、文件保护属性和扩展属性。
- **新旧并存**：预检查完整旧树；新目标已有同名文件须字节一致，否则报冲突并保留两边。缺失文件用同文件系统硬链接合并，避免双倍磁盘占用；逐文件验证、同步文件和目录，完整合并确认后才逐个移除旧叶文件和空目录。最终目标始终至少保有已清理旧文件的同一 inode 或核验相同的数据。未知文件、pending、嵌套目录、元数据和事务都按原字节保留，不以“未识别”为理由丢弃。
- **中断和失败**：已合并的副本可用于幂等重试；未合并的旧文件保留。源清理中断后，新目录已拥有整套数据。符号链接、特殊文件、路径冲突不跟随/不覆盖。空间或权限故障不会触发清空或重新初始化。
- **只读兼容**：备份列表按新旧目录合并扫描，旧数据仍可列出、读取或导出，迁移错误显示为诊断；所有写入、轮转删除及恢复实际应用等待迁移成功。同名不同内容不会静默选择一份当作可信恢复数据。
- **最早迁移和重试**：`CSPluginStorageStartup.m` 是 Makefile 中第一个链接输入，constructor 仅做原始文件系统操作，不访问账号/钥匙串、不创建业务 Manager。Mach-O 不全局排序 constructor 优先级，因此最终包另检 `__TEXT,__init_offsets` 首项为 `CSPluginStorageLoad`。设备保护数据变为可用、进入前台和业务读写入口均可重试，无轮询计时器。
- **恢复事务**：Bootstrap 即使迁移失败仍检查新旧两个 `transaction.plist`，不因新目录为空放行旧事务。Engine 在修改偏好或图片前确认迁移完成。

密友保持原 Keychain service/account、SHA-256 账号文件名、policy key、auth/password 数据及加密格式。迁移不解密/重加密、不重设密码和运行时授权；读取密钥有独立只读 provider。旧/新任何账号文件存在或无法确认不存在时，都禁止生成替代 policy key；迁移失败或密文损坏不被误报为新账号空名单。

旧目录清理由迁移自身在核验后执行，范围只限两个明确叶目录；不会移除整个 `Application Support/WeChatImprove`，其中独立的 `payment-ledger-v1.plist` 保持原位。本次未扩大为支付统计存储迁移。全部旧完整路径引用的保留理由见 [path-reference-inventory.md](path-reference-inventory.md)。

## 图片清理与审计

图片删除 helper 收紧到资源根的直接子级普通 PNG，使用目录描述符和 `unlinkat(..., 0)`，拒绝子目录、符号链接和目录目标。导航保存不再在资源根不是目录时先删除根；创建失败直接返回。备份恢复/回滚中删除资源也统一使用该 helper。新增备份与密友子目录内的 PNG 和数据哨兵必须保持。逐项审查见 [resource-boundaries.md](resource-boundaries.md)。

已删除 `CSBackupFileProtection.*`、`BackupFileProtectionHooks.xm` 及安装接口，替换为 `CSBackupAudit`。审计没有 host hook、Foundation hook、swizzle 或文件删除拦截；只记录插件提交的加载、迁移、发布、库存及自身删除事件。所有审计文件 I/O 异步执行，失败不影响业务；最多 96 个事件、512 KiB，保留最后发布回执。进程被立即终止时，尚未写入的最后少量事件可能丢失。去掉 hook 后不能取得微信删除者的调用栈，这是消除行为干预的明确取舍。库存事件同时记录实际 `readRoots`，目录身份带实际异步观察时间。

## 核心回归

全部脚本使用隔离的临时 Library、独立 NSUserDefaults suite、测试凭据；没有操作用户真机数据。日志位于本目录 `test-*.log`。

| 入口 | 通过检查数 | 主要覆盖 |
| --- | ---: | --- |
| `verify-plugin-storage-migration.sh` | 83 | 独占改名、合并、冲突、原始数据/事务/pending、真实进程退出后重试、ENOSPC、只读兼容、禁止旧路径写入、真实待恢复事务接续 |
| `verify-close-friend-migration.sh` | 59 | 双账号密文逐字节相同、原密码解锁、切账号、只读密钥、失败兼容与冲突保护 |
| `verify-close-friend-core.sh` | 246 | 加密、策略、凭据与账号持久化 |
| `verify-close-friend-runtime.sh` | 94 + 9 | 授权/锁定状态、调度 |
| `verify-backup-store.sh` | 52 | 不可变快照、元数据与事务持久化 |
| `verify-backup-retention.sh` | 171 | 收藏/导入/手动与事务引用保留 |
| `verify-backup-transactions.sh` | 89 | 应用、崩溃恢复、回滚、激活交接 |
| `verify-backup-reset.sh` | 32 | 重置与保护原件；共享资源根下两个数据目录的 PNG 哨兵 |
| `verify-backup-engine.sh` | 25 | 配置、资源恢复流程 |
| `verify-backup-bootstrap.sh` | 36 | 启动门禁；另通过 33 个门禁 hook 文件、8 个独立 adapter、2 个恢复文件的 Logos/iOS 语法与 C linkage 检查 |
| `verify-managed-image-files.sh` | 125 + 29 | 删除 API 边界及实际控制器清理/保存方法，两个新目录与 PNG 哨兵 |
| `verify-backup-audit.sh` | 43 | host/Foundation IMP 未改变、实际删除移动成功、异步审计失败不干预业务 |
| **合计** | **1093** | 检查数按各脚本输出求和，不计 Logos 文件数和包核验 |

迁移的进程中断用真实生产迁移代码编译，仅在该编译单元的 `linkat/unlinkat` 边界注入测试故障：系统调用成功后 `_exit(77)`，新进程随后继续迁移。ENOSPC 也由测试 syscall shim 注入；发布包不含这些 shim。

## 包与设备验收

版本 `2.0-3` 同步 `control`、`kPluginVersionString`、发布说明与 README。构建使用独立 Theos 数据目录，保留原有 `.theos` 和旧安装包，不执行 `make clean`。产物与哈希记录在 `packages.json`，测试记录在 `validation.json`。

当前使用未越狱签名 IPA：Rootful deb 可供既有 IPA 注入流程提取 dylib，deb 本身不是可直接签名安装的 IPA。Rootless 另外保留。两种包均需核验 arm64/arm64e、dSYM UUID、迁移首 constructor、新存储类、没有旧保护类/垃圾移动 hook；没有宣称已完成真机验收。

建议真机验收：

1. 保留旧容器中仍存在的两个目录和独立导出副本，再覆盖升级当前签名 IPA；不要卸载重装来验证同容器迁移。
2. 首次解锁启动后确认新目录有原文件、旧叶目录已清理；核对备份数量、原密码、各账号密友名单、切账号与重新锁定。
3. 新建手动备份、清除自定义底栏图标和导航图片，确认两个持久化子目录及内容仍在。
4. 执行原本会触发问题的微信存储清理，观察备份/密友是否保留，再锁屏/前后台切换、重新启动检查。
5. 若迁移提示失败，先检查锁定状态、空间、路径冲突与审计 `storage-migration-pending`，保留两边原件后重试；不要删除旧目录“修复”问题。若再次消失，收集审计中的容器路径/目录身份、最后发布回执和实际微信版本。本版不捕获宿主删除调用栈。

旧目录已被微信删除的数据无法凭迁移找回。跨容器重新安装也不会自动找到旧容器。本文不将任何残留临时文件或其他历史容器自动导入当前账号。
