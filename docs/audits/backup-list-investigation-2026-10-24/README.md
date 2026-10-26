# 本机备份列表变空：隔离诊断（2026-10-24）

> 历史记录：本文描述迁移前路径与当时方案。2.0-3 已改用 Preferences 下 BackupV2/CloseFriends 并移除清理拦截；当前实现见 [存储迁移记录](../preferences-storage-migration-2026-10-24/README.md)。

本次仅审查当前 checkout 的生产代码，并运行主机隔离诊断；没有修改生产源码、安装包、实际手机配置或备份。没有手机日志或实际备份目录，不能将主机可复现路径认定为现场的唯一根因。

## 已确认

- Manager 在当前微信数据容器的 `Library/Application Support/WeChatImprove/BackupV2` 创建 Store（CSBackupManager.m:30）。路径不拼接账号、epoch、installationID 或插件版本。
- Store.records 直接扫描该目录的 `.wcbak`（CSBackupStore.m:109）；没有列表 manifest。meta/meta.bak 是单份保护与显示信息；损坏或缺失不应隐藏条目。损坏 `.wcbak` 在当前实现仍显示 unavailable。
- 页面 reload 在错误时仍执行 `self.records=records?:@[]`（CSBackupSettingsViewController.m:99），之后显示“暂无备份”。错误会另外弹窗，但之前的列表被替换。这可以将扫描失败呈现为备份丢失。
- Store.records 调用 Directory，Directory 会 createDirectoryAtURL（CSBackupStore.m:24、110）。原目录缺失时会重建空目录，无“此前存在过”的判断，也无持久记录。目录被移走、清除或切换到其他容器均可能表现为空。
- 手动、导入及收藏不参加普通额度清理；普通自动保留 20 份，protection/upgrade 合计保留 5 份。每次 Engine.save 成功发布后可能触发 prune；没有按小时过期或总磁盘容量阈值清空。
- 当前版本沿用 1.9-6 的保护修复。两份元数据异常会保留，损坏快照也保留。旧问题记录不能直接当作 2.0-1 的根因。

## 复现

`reproduction.m` 直接编译生产 Store/Engine/Codec/Registry/Assets，操作随机命名临时目录和独立偏好域。没有加载 UIKit 页面；页面的“暂无备份”映射由静态代码核实。权限错误通过真实 chmod 模拟，其发生概率与原因不能由该模拟推断到 iOS。

运行：

```bash
bash /var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-backup-list-investigation-20261024-x3c52yhb/verify.sh /Users/zhangshichao/Documents/Workspace/WeChatImprove
```

结果详见 results.log，29 项检查通过：

1. 发布手动快照；只阻止夹具目录访问；扫描 0 份并返回 NSCocoaErrorDomain/257。恢复权限后 1 份，原文件字节不变。
2. 将夹具备份目录移到另一个临时位置；扫描原路径，自动重建目录并返回 0 份、无错误。原文件仍在保存位置，复原目录后重新出现。
3. 同样相对路径、不同模拟容器，新容器 0 份，原容器 1 份。
4. 移除两份保护元数据：手动快照仍显示，prune 不删。
5. 损坏快照：仍有 1 个 unavailable 条目，prune 保留文件。
6. 同一路径内更改账号、epoch、版本、installationID：旧手动快照仍显示。
7. 留下 `.pending-` 文件：已提交条目数量不变。

现有核心测试本次结果：Store 52、Retention 171、Transactions 89、Reset 30 项通过。总计 342 项现有回归加 29 项隔离诊断。测试不替代手机现场证据。

## 路径、提交与其他设置

正式备份不在 Library/Caches、tmp 或应用包 .app 内。正常保留数据容器的更新不会因插件版本变化覆盖它；删除重装、另一个 bundle/容器或重签工具处理数据需现场核对。微信原生及其他插件的清理是否触及该路径，本次没有设备调用证据。

AtomicWrite 使用同目录 .pending-UUID、完整写循环、文件 fsync、rename、目录 fsync（CSBackupStore.m:38）。崩溃在提交前可能遗留临时文件，但不删除此前已提交快照。元数据先写双份，再发布快照。不存在索引写坏即清空全部备份的流程。

账号 epoch 用于阻止跨账号混合捕获与恢复；列表不按账号过滤。格式仍为 formatVersion=2，插件版本仅记录为来源。1.9-6 起不再扫描旧 Library/Backup，旧文件保留；不能解释当前格式刚手动生成又小时级消失。

自动备份开关只控制自动调度。升级备份独立触发，且与操作前保护共享 5 份额度；备份/重置前保护与回滚不会清空历史。重置可能重置登记的自动备份开关，不会删除 BackupV2。当前备份模块没有云端同步逻辑，分享仅在 tmp 生成副本，分享完成删除该临时副本。

## 建议修复范围（尚未实施）

1. 列表结果区分首次加载、成功非空、成功空、目录缺失、读取失败。失败时保留此前行或显示读取失败，不将失败映射为“暂无备份”；提供重试。
2. 列表读取不隐式创建目录，创建仅在初始化/写入阶段执行；配合根目录外的既往成功记录识别异常消失。该记录只是诊断，不能代替真实文件作为列表来源。
3. 增加有界、按操作触发的诊断：构建 UUID、容器/相对路径指纹、扫描结果与原始错误码、成功发布 ID/kind、明确删除与轮转原因；不记录配置内容，不增加周期轮询。
4. 继续保留现有不可读文件展示、双保护记录、原子提交和手动备份保留规则。实际目录若已丢失，只能从仍存在的原容器/导出文件恢复，不能由 UI 修复找回已删除数据。

现场判定需要：实际运行库/插件版本，8 点那份原始 kind，变空前后 root 与文件是否存在，以及 cleanup.plist（仅最近一次轮转记录）。没有持久手动创建/全量扫描日志；cleanup 没有删除记录不能证明外部未删除，也不能证明手动删除未发生。
