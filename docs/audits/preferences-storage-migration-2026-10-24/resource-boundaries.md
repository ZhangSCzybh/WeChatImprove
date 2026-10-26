# 同一资源根下的图片清理边界

## 迁移带来的额外边界

新布局把 `BackupV2/`、`CloseFriends/` 放入已有图片资源根 `Library/Preferences/WeChatImprove/`。原生 Preferences 保留规则不能阻止插件自身删除，因此必须避免把“位于资源根内部”误认为“属于可删除图片”。本次检查复用了旧目录误删复现，仅补同根下两个真实持久化子目录的回归。

此前 `CSManagedImageRemoveInDirectory` 已拒绝目录、符号链接、非普通文件与越界路径，并用目录描述符和 `unlinkat(..., 0)` 防止递归误删；但仍允许根下任意深度的 `.png`。这会允许被污染的图片设置指向 `BackupV2/sentinel.png` 或 `CloseFriends/sentinel.png` 后，清除图标时删除该数据文件。现有生产图片写入均为根目录直接子文件，因此本次将允许条件收紧为：规范化后候选文件的父目录必须等于可信资源根，且必须是普通 PNG 文件。两个持久化子目录以及任何其他子目录均不能进入图片删除系统调用。

另发现导航 `saveSeparatorImage:` 在资源根存在但不是目录时，会 `removeItemAtPath:enhanceFolderPath` 再创建目录。正常非目录文件不会包含备份，但“存在检查后路径并发替换为数据目录”时，该递归删除 API 有机会删除整个资源根。现已移除此根删除分支，直接请求创建目录；失败保留现场并停止保存。

## 删除及写入路径逐项检查

| 操作 | 路径来源及边界 | 对两个持久化子目录的判断 |
|---|---|---|
| 导航分隔符改为文字 | 读取图片偏好，调用 `CSManagedImageRemove` | 拒绝持久化子目录、嵌套 PNG、根目录及其祖先 |
| 导航清除自定义图片 | 固定 `separator_image.png`，调用同一 helper | 仅删除根下普通 PNG |
| TabBar 清除普通/选中图标 | 两个偏好路径调用同一 helper | 已污染的子目录路径仍清除偏好记录，保留数据文件 |
| TabBar 重置全部图标 | 遍历固定的图标设置键，每个路径调用同一 helper | 与上项同一边界，不枚举/清空根 |
| 导航保存图片 | 创建资源根，然后原子写固定 `separator_image.png` | 已移除根删除/重建；不扫描子目录 |
| TabBar 保存图片 | 创建资源根，按固定图标类型生成根下 PNG 文件名，原子写 | 不清理旧目录，不递归操作子目录 |
| 触控轨迹保存图片 | 创建资源根，原子写固定 `touch_trail.png` | 不删除根或其他资源 |
| `CSBackupAssets` 捕获图片 | 校验在资源根内、无内部符号链接、普通有效图片 | 只读；当前仍允许读取有效嵌套图片，不造成删除 |
| `CSBackupAssets` 恢复资源计划 | `separator_image.png`、`touch_trail.png` 或 `backup_<64 hex>.png` | 仅构造根直接子文件写入计划，没有删除 API |
| `CSBackupEngine.writeFields` 恢复/重置/回滚 | journal 校验限制上述文件名；原代码 absent 分支用 `removeItemAtURL` | 已改用同一 helper；拒绝目录目标，不递归删除 |
| 备份分享完成 | 删除导出函数返回的临时分享文件 | 与资源根子目录分离；没有按图片偏好生成路径 |
| CloseFriends 写入失败 | 删除本 store 根下本次新建 `.pending-<UUID>` | 由关系存储审查负责，不是图片清理入口；不遍历 BackupV2 |

检查范围：`CSManagedImageFile`、导航/TabBar/触控轨迹图片写入及删除、`CSBackupAssets`、`CSBackupEngine` 的资源计划/写入、分享完成回调与关系存储失败清理。没有新增对微信原生清理 API 的拦截或修改。

## 本次修改与验证

本子任务修改：`CSManagedImageFile.h/.m`、导航资源根创建分支、`ManagedImageFileTests.m`、`ManagedImageCleanupIntegrationTests.m`、`verify-managed-image-files.sh`。备份 Engine 的删除分支已统一使用该 helper；`verify-backup-reset.sh` 另以实际共享资源根布局执行重置与回滚，验证 BackupV2/CloseFriends 中 PNG 哨兵保留。

`bash Tests/verify-managed-image-files.sh` 通过：

- **125** 个 helper/文件边界检查：资源根下真实 `BackupV2/` 与 `CloseFriends/`、嵌套 PNG 哨兵、备份/关系数据哨兵、正常根级图片删除、路径穿越/符号链接/特殊文件拒绝、最终删除前文件替换为目录或链接、根被替换为链接时仍保持描述符定位。
- **29** 个真实生产方法集成检查：脚本提取完整的 `clearCustomIcon` 和 `saveSeparatorImage` 方法执行，UI 及系统目录查询映射到隔离夹具；真实 `CSBackupStore` 在新位置发布并回读手动备份。清除污染偏好和正常图片、保存分隔图片之后，备份及两个子目录内数据/PNG 哨兵保持完整。资源根被普通文件占用时，保存失败保留该文件和旧偏好，避免删除重建。

隔离测试用临时目录和独立 NSUserDefaults suite，无用户真机数据。测试出现一次“资源目录已存在同名文件”的日志是预期的阻塞根用例。

`CSManagedImageFile.m` 的 iOS arm64 `-fsyntax-only -Wall -Wextra -Werror` 通过，受影响已跟踪控制器的 `git diff --check` 通过。完整插件构建与 Engine/迁移核心回归由父任务汇总。
