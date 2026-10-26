# 存储路径引用核对

当前生产根统一由 `Controllers/CSPluginStorage.m:122` 生成 Preferences 路径。`:123` 的 Application Support 字符串仅生成 legacyRoot；Manager 不再硬编码旧根。两个 Store 的生产构造函数、Bootstrap 和启动迁移均使用此模块。备份/密友的生产代码不再有旧根写入目标。

`CSPaymentAutomation.m:539` 仍使用 Application Support 保存独立支付账本，属于有意保留的其他数据；不能因为共享 WeChatImprove 名称就移动或删除。旧父目录因此不清空。

README、当前备份指南、备份设计与密友计划已同步新路径。以下出现旧完整路径的地方逐项保留；历史 before 源码/日志/包是取证原件，不把它们改写为当前路径。2.0-2 调查和此前列表调查的 README 已添加被本方案替代说明。

| 文件 | 行 | 判断 |
| --- | --- | --- |
| `Tests/CloseFriendMigrationTests.m` | 33 | 旧路径迁移夹具；有意保留 |
| `docs/audits/backup-configuration-1.8-37/README.md` | 16 | 历史版本、调查或 before 原始记录；保留当时路径，不作为当前实现说明 |
| `docs/audits/backup-deletion-2026-10-24/README.md` | 5 | 历史版本、调查或 before 原始记录；保留当时路径，不作为当前实现说明 |
| `docs/audits/backup-deletion-2026-10-24/image-path-reproduction/probe.m` | 95 | 历史版本、调查或 before 原始记录；保留当时路径，不作为当前实现说明 |
| `docs/audits/backup-list-investigation-2026-10-24/README.md` | 9 | 历史版本、调查或 before 原始记录；保留当时路径，不作为当前实现说明 |
| `docs/audits/backup-list-investigation-2026-10-24/reproduction.m` | 14,39 | 历史版本、调查或 before 原始记录；保留当时路径，不作为当前实现说明 |
| `docs/audits/backup-retention-2026-10-22/README.md` | 50,62 | 历史版本、调查或 before 原始记录；保留当时路径，不作为当前实现说明 |
| `docs/audits/backup-retention-fix-1.9-6/README.md` | 69 | 历史版本、调查或 before 原始记录；保留当时路径，不作为当前实现说明 |
| `docs/audits/backup-title-1.9-1/README.md` | 31 | 历史版本、调查或 before 原始记录；保留当时路径，不作为当前实现说明 |
| `docs/audits/close-friend-controls-2026-10-22/README.md` | 57 | 历史版本、调查或 before 原始记录；保留当时路径，不作为当前实现说明 |
| `docs/audits/close-friend-controls-2026-10-22/previous-release-metadata/README.md` | 120 | 历史版本、调查或 before 原始记录；保留当时路径，不作为当前实现说明 |
| `docs/audits/close-friend-layout-1.9-8/README.md` | 30 | 历史版本、调查或 before 原始记录；保留当时路径，不作为当前实现说明 |
| `docs/audits/close-friend-position-1.9-9/README.md` | 26 | 历史版本、调查或 before 原始记录；保留当时路径，不作为当前实现说明 |
| `docs/audits/close-friend-position-1.9-9/before/README.md` | 120 | 历史版本、调查或 before 原始记录；保留当时路径，不作为当前实现说明 |
| `docs/audits/close-friends-1.8-42/task-reports/task-2-report.md` | 31 | 历史版本、调查或 before 原始记录；保留当时路径，不作为当前实现说明 |
| `docs/audits/close-friends-no-expiry-1.9-5/before/Controllers/CSCloseFriendManager.m` | 52 | 历史版本、调查或 before 原始记录；保留当时路径，不作为当前实现说明 |
| `docs/audits/close-friends-no-expiry-1.9-5/before/README.md` | 120 | 历史版本、调查或 before 原始记录；保留当时路径，不作为当前实现说明 |
| `docs/audits/close-friends-settings-1.8-60/README.md` | 49 | 历史版本、调查或 before 原始记录；保留当时路径，不作为当前实现说明 |
| `docs/audits/settings-font-1.8-41/README.md` | 14 | 历史版本、调查或 before 原始记录；保留当时路径，不作为当前实现说明 |
| `docs/backup-guide.md` | 249 | 明确记载只读迁移来源；当前根已改为 Preferences |
