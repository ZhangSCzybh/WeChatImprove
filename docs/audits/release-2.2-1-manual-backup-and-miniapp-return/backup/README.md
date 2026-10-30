# 手动备份提取与回归核验

基线：已逐文件命中权威 manifest 的 2.1-20 快照。参考实现：`3810d735`。本子目录只记录删除自动备份及保留手动操作的变更。

## 提取边界

- `CSBackupEngine.m` 仅提取固定 manual 保存、直接发布及准备阶段不发布保护备份；不引入 `CSBackgroundRunPolicy`、`RevisionFields` 或背景策略 revision 兼容代码。
- `CSBackupRegistry.m` 仅为既有 auto_enabled 条目补充惰性兼容说明，登记项和类型验证仍为 2.1-20。`BackupRegistryTests.m` 保持 2.1-20 字节。
- 保留 `CSBackupMutation` 的资源写入代次，仅服务手动采集的一致性核验；删除 Scheduler/ChangeBatch、定时器、自动开关、观察者、升级备份、数量清理及失败状态。
- 历史 automatic/upgrade/protection 的 Codec、读取、导入、导出、恢复和手动管理仍支持；旧事务的 protectionID 删除保护继续保留。新恢复/重置仅写事务 before/beforeWrites，不发布保护文件。
- UI 历史 automatic 来源标签相对参考实现改为“历史配置备份”，内部 kind 保持 automatic。现有对应断言只检查“历史”，未改断言。
- `Tests/PluginStorageMigrationTests.m` 额外发现两处旧 API 调用，严格提取参考提交的两处改动：删去已删除 prune: 调用，save:kind:error: 改为 save:error:，其它迁移断言保持。
- 逐文件取舍、增删与哈希见 `reference-review.json`、`changed-files.json`；相对精确 2.1-20 的差异见 `changes.patch`。

## 回归结果

19 个脚本、20 组，3812 checks / 0 failures。红测要求由本轮小程序隐私测试单独承担，下面只统计备份最终成功运行。

| 脚本 | checks | failures |
| --- | ---: | ---: |
| Tests/verify-backup-engine.sh | 25 | 0 |
| Tests/verify-backup-transactions.sh | 104 | 0 |
| Tests/verify-backup-reset.sh | 33 | 0 |
| Tests/verify-backup-restore-paths.sh | 249 | 0 |
| Tests/verify-backup-store.sh | 51 | 0 |
| Tests/verify-backup-manual-management.sh | 130 | 0 |
| Tests/verify-backup-deletion.sh | 140 | 0 |
| Tests/verify-backup-compatibility.sh | 66 | 0 |
| Tests/verify-ai-backup.sh | 97 | 0 |
| Tests/verify-scheduled-task-backup.sh | 507 | 0 |
| Tests/verify-plugin-storage-migration.sh | 84 | 0 |
| Tests/verify-backup-bootstrap.sh | 34 | 0 |
| Tests/verify-plugin-framework.sh | 56 | 0 |
| Tests/verify-backup-performance.sh | 182 | 0 |
| Tests/verify-backup-deletion-ui.sh | 565 | 0 |
| Tests/verify-backup-codec.sh | 16 | 0 |
| Tests/verify-backup-registry.sh | 1404 | 0 |
| Tests/verify-backup-assets.sh | 26 | 0 |
| Tests/verify-backup-audit.sh | 43 | 0 |

`verify-plugin-framework.sh` 为入口 21 + 启动集成 35 两组。所有 suite 使用临时目录/隔离 defaults/内存替身，不读写真实微信数据。

首次运行 `verify-plugin-storage-migration.sh` 编译失败，原因是测试仍调用本轮删除的 prune: 与旧 save:kind:error: 接口；原始失败日志保留为 `logs/verify-plugin-storage-migration.sh.initial-compile-fail.log`，不计入成功数。取参考实现中对应两处测试变化后，该套 84 checks / 0 failures。其余 18 脚本无需重跑。

主机日志中编译 warning 行数：0。`verify-backup-bootstrap.sh` 另完成所有 Logos hook 与 Bootstrap 的 iPhoneOS arm64 语法编译、C linkage 检查，原日志完整保留。双架构正式链接构建与警告基线比对由主发布审计记录。

## 兼容字段消费核对

以下检索覆盖生产 Controllers / Headers / Hooks：

```text
rg -n 'auto_enabled|CSBackupScheduler|CSBackupChangeBatch|attemptUpgradeBackup|resumeScheduledWork|processScheduledWork|isAutoBackupEnabled|enableAutoBackup:' Controllers Headers Hooks --glob '*.{h,m,xm}'
Controllers/CSBackupRegistry.m:70: existing auto_enabled registry declaration only
```

该惰性字段只有登记声明，没有运行观察者、开关读取或调度消费者。事务测试同时覆盖带历史惰性开关值及 protectionID 的旧日志中断回滚，启动集成测试确认开启旧值也不会创建备份。

删除的 3 个 verify 与配套测试均专用于被删除的自动调度/数量清理，不保留无功能测试入口。未导入背景策略备份测试、脚本依赖或相关生产文件。
