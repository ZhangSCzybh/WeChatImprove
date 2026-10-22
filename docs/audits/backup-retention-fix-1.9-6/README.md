# 1.9-6：备份保护修复与旧格式清理

2026-10-22，基于原 `main` checkout `/Users/zhangshichao/Documents/Workspace/WeChatImprove` 和 `f82de803` 实现。用户授权移除旧备份兼容、清理旧模型，并按前次分析修复备份保护。包版本、插件内版本与更新说明同步为 `1.9-6`。

## 最终行为

- 每份新快照在发布前先建立两份保护记录：`<UUID>.meta` 与 `<UUID>.meta.bak`。记录绑定快照 ID，并校验结构、类型、长度和 SHA-256；写入与读取使用相同的 16 KiB 上限。
- 读取任一记录失败、两份不一致或全部丢失时，保留快照并显示“保护待确认”。仍可从另一份读出的收藏和导入保护继续保留；发生分歧时合并保护，不把未知状态当作未收藏。
- 当前 v2 快照继续使用原格式、ID 和目录。已有的单份本机元数据仍可读取，但在用户重新确认前暂停该备份的自动清理。此处保留的是当前备份的用户保护状态，不是旧 JSON/目录格式兼容。
- “确认备份保护状态”允许用户选择收藏并保留，或不收藏、按类型规则管理。重命名只提交名称变更，不会用页面的旧状态覆盖最新收藏；保护异常时需先确认保护状态。
- 手动、导入和收藏备份继续保留，活动恢复事务引用继续禁止删除。普通自动备份保留 20 份，操作前保护与版本更新备份合并保留 5 份。
- 导入保护在快照发布前持久化，避免中断后留下没有导入保护的自动类型文件；相同文件重复导入保留原收藏，内容冲突时不改动原快照或保护记录。
- 校验失败的 `.wcbak` 继续显示在列表，标记“原件已保留”，可查看原因、重新检查、导出可读取的原始字节。原件不能通过校验前不提供恢复。异常原件保留，其他保护状态明确的普通备份仍可按额度清理。
- 自动清理先将候选 ID、类型、原因和保护核验结果写入 `cleanup.plist`，再逐份删除并记录结果。日志发布失败即停止后续删除；文件发布成功和历史清理警告分别报告。页面的“备份与恢复状态”展示最近清理汇总。
- 单份主动删除保留确认弹窗，收藏备份显示专属删除提示。删除文件后同时移除其常规保护文件；异常非普通文件不会被递归删除。

保护信息全部丢失时，无法凭空重建原收藏状态。本版会保留文件并让用户确认，不能恢复此前已被删除的文件。

## 旧格式与死代码清理

删除以下运行代码及对应旧格式测试：

```text
Controllers/CSBackupInfo.h
Controllers/CSBackupInfo.m
Controllers/CSBackupLegacyReader.h
Controllers/CSBackupLegacyReader.m
Tests/BackupLegacyTests.m
Tests/verify-backup-legacy.sh
```

`CSBackupManager` 不再扫描旧 `Library/Backup`，不再分派旧目录读取，也不再回退到旧 JSON 解码。导入仅接受当前二进制 `.wcbak`，界面和主 README 已同步说明。原旧格式文件保留，没有附带删除用户历史数据。

配置域别名 `legacy` 对应目前仍在使用的 `com.cyansmoke.wechattweak` 设置域；它用于现有头像、后台等功能，保留原映射。

## 验证

修改前新增的专项测试失败于 `favorite survives damaged metadata during retention`，确认原缺陷；日志见 [baseline-reproduction.log](baseline-reproduction.log)。最终回归结果：

| 检查 | 结果 |
| --- | --- |
| 配置登记表 | 1390 项断言通过 |
| 编码 / 图片资源 | 16 / 26 项通过 |
| 文件存储 / 备份引擎 | 52 / 25 项通过 |
| 自动调度 | 10 项通过 |
| 恢复事务 / 重置 | 89 / 30 项通过 |
| 本轮新增保护回归 | 171 项通过 |
| 启动屏障 | 36 项通过；Logos 生成、iOS 语法与 Objective-C++ C 链接校验通过 |
| 插件入口与启动集成 | 见 [verify-plugin-framework.log](verify-plugin-framework.log)，全部通过 |
| 修改的存储、管理器、设置页 | `arm64` / `arm64e` 共 6 组严格语法检查通过，无诊断 |
| Rootless 完整打包 | 成功，包含 `arm64` / `arm64e` |

专项回归覆盖两份记录缺失/损坏、超限、非普通文件、类型错误、完整性不匹配、中断取消收藏、单份写入失败、明确取消收藏后正常清理、手动及导入保护、导入冲突、异常文件展示和原件导出、清理日志失败时不删除，以及普通额度清理仍正常工作。

启动检查脚本原本假设所有功能都通过备份设置初始化屏障，因后来新增的 8 个独立密友适配器而失败。本轮仅校正测试范围：明确列出这些使用独立加密状态的适配器，验证其异步原生注册，并继续编译全部生成的 Hook；其他设置消费者仍逐个检查屏障约束。没有改动密友运行实现。

脚本结果见 [test-results.json](test-results.json)，双架构严格检查见 [ios-syntax.json](ios-syntax.json)。完整构建仍有项目既有的弃用 API 及链接参数警告，详见 [build.log](build.log)。

## 安装包与数据环境

- [1.9-6 Rootless 安装包](../../../packages/com.wechat.improve_1.9-6_iphoneos-arm64.deb)
- [arm64 / arm64e 调试符号](../../../packages/WeChatImprove-1.9-6-dSYMs.zip)
- [包、架构、UUID 与源码核对](package-verification.json)

安装包 SHA-256：`b74f7ca2c45158915c93222e4f7b8e4e8d56116a266d2476a46dc81be6cc779b`。

已从最终 `.deb` 解包核对版本、双架构及注入过滤配置，并验证两架构 dSYM UUID 与实际动态库匹配。链接产物中不再存在 `CSBackupInfo` 和 `CSBackupLegacyReader` 类。构建使用当前 checkout，缓存与暂存放在隔离临时目录；最终产物已复制到本项目原 `packages/`。旧安装包哈希核对一致。

项目运行于 iPhone 微信进程，没有前后端 URL 或端口。正式数据源仍是当前微信容器内的 `Library/Application Support/WeChatImprove/BackupV2/`、原配置域和原图片目录。本轮测试使用 macOS 随机临时目录与独立偏好域，未访问或迁移手机容器，未安装或重启微信。

工作前源码保存在 [source-before-1.9-6.zip](source-before-1.9-6.zip)。未执行 `make clean`、切换 checkout、覆盖历史安装包、提交或推送；既有其他功能源码经哈希核对保留。

真机还需复验：首次升级后原快照与收藏状态显示、异常保护确认、正常创建/导入/导出与恢复，以及连续自动保存后的数量清理。主机回归和打包验证不替代这些设备交互验收。
