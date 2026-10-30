# 2.2-1：以 2.1-20 为基线的手动备份与小程序返回修复

## 基线核验

回退阶段结论：**源码已逐字节回到 2.1-20**。

唯一源码判据为 `release-2.1-20-scheduled-tasks/tested-source-sha256.json`。开始两项修改前，42,776 个文件全部命中目标 SHA256；逐文件路径、目标哈希、工作树哈希与一致性列见 [baseline-file-hashes.tsv](baseline-file-hashes.tsv)，机器可读版见 [baseline-file-hashes.json](baseline-file-hashes.json)。源码目录 manifest 外文件为 0，见 [baseline-extra-source-check.json](baseline-extra-source-check.json)。

实际需恢复 83 个 manifest 文件：79 个取 `d15acffe`、1 个取 `00c1d9dc`，另 3 个精确重建。control／CSUserInfoHelper.h 仅替换 `00c1d9dc` 的版本串；发布说明删除完整 2.1-21 条目，三者均命中目标哈希。README、定时任务文档、备份指南另命中 2.1-20 change-manifest 的交付哈希，见 [baseline-document-hashes.json](baseline-document-hashes.json)。

回退阶段删除 44 个 manifest 外后加文件，清单见 [deleted-post-2120-files.txt](deleted-post-2120-files.txt)。历史审计、反馈素材、packages 与 .theos 保留。随后按照本次明确需求重新引入手动管理备份的两份参考测试，并新增两份小程序测试；这是本次改动，未保留其它后续版代码。

当前交付树已经在上述精确基线上实施两项修复并升为 2.2-1，因此不把最终树描述为未经修改的 2.1-20。最终 42,732 个 manifest 文件仍保持原字节，44 个 manifest 文件只因本次两项需求及版本元数据修改或删除；另 4 个新增文件均为本次测试。连同文档共 52 个差异，逐项见 [final-changed-files.json](final-changed-files.json)，完整两项改动见 [changes.patch](changes.patch)。范围验证的意外差异为 0，既有审计差异为 0，见 [final-scope-verification.json](final-scope-verification.json)。

## 小程序返回隐私

2.1-20 的原生 owner 布局运行在 native 索引作用域中。表格内容布局若继承该作用域，真实生产代理会绕过过滤后的分组行集合。主机提取生产代理、索引作用域、projection 与卡片首末行判定，重放后可复现原生行先出现、随后过滤分组布局的差异；这不是手机自然生命周期的运行日志。

本轮仅在 Adapter 增加 `performSessionListLayout:`，由 MainFrameTableView 的内容布局入口调用。已就绪时切回 display 索引，使用过滤后的行集合及几何；策略、账号、epoch、投影策略版本或重试占位尚未就绪时不执行本次内容布局，复用 2.1-20 既有 ListShield 整组中性化可见内容，保留原有包围盒和 offset。私有 held 状态阻止刷新尾部提前释放旧内容；就绪事件通过原有刷新路径收口。

未新增定时器、固定延时、截图、CALayer mask、行数归零、整表刷新、offset 写入或手势开关；未移植 2.1-21 至 2.1-31 的返回、banner、遮罩或滚动实现。原 `refresh` 的发布结构、密友判定与解锁规则保持，只有尾部 shield 释放增加 held 条件。

最终同一新增断言集：冻结未修改 2.1-20 **72 项／26 失败**，修复后 **72 项／0 失败**。覆盖无 appear 的容器返回、首帧 section／行身份／替身 y／首末行／offset 与稳定态相等、迟到策略、锁定解锁、旧投影、空投影、epoch、发布与事务重入、同步策略变更、scope 异常恢复及关闭保护后的释放。offset／reload 计数器先用控制项证明可捕获两次写入和一次 reload，正式返回测得新增写入与整表刷新均为 0。y 为明确的 64px 行高替身，不是 UIKit 像素实测。

既有最小回归：密友 session 174／0、session presentation 55／0、group lifecycle 191／0、viewport 72／0、search 54／0。仅给两处测试替身增加新状态属性声明，既有断言未改。iOS arm64／arm64e 的生产对象及 Logos hooks 定向编译通过。红日志、具体失败项、原始 layout records、初次脚手架失败及 provenance 见 [privacy/README.md](privacy/README.md)。

## 手动备份

逐文件审查 `3810d735`，只取删除自动备份的变更。明确排除 Engine 的 background policy RevisionFields、Registry 的后台策略字段和 validator、对应后台测试、verify 中新增后台策略链接依赖。逐项取舍见 [backup/reference-review.json](backup/reference-review.json)。

删除开关、配置／资源／前后台观察、变更合并调度、定时器、升级备份、失败状态展示、自动去重和数量清理。保存固定创建 manual 并直接发布；恢复／重置准备不再发布保护文件，仍保留事务 before／beforeWrites 回滚。历史 automatic／upgrade／protection 可读取、导入、导出、预览恢复和手动管理，旧事务引用继续受保护。UI 来源标签为“历史配置备份”。auto_enabled 只剩惰性兼容登记，无运行消费者；CSBackupMutation 原字节保留，服务手动采集一致性。

19 个脚本、20 组共 **3812 项／0 失败**：

| verify 脚本（Tests/） | checks | failures |
| --- | ---: | ---: |
| backup-engine | 25 | 0 |
| backup-transactions | 104 | 0 |
| backup-reset | 33 | 0 |
| backup-restore-paths | 249 | 0 |
| backup-store | 51 | 0 |
| backup-manual-management | 130 | 0 |
| backup-deletion | 140 | 0 |
| backup-compatibility | 66 | 0 |
| ai-backup | 97 | 0 |
| scheduled-task-backup | 507 | 0 |
| plugin-storage-migration | 84 | 0 |
| backup-bootstrap | 34 | 0 |
| plugin-framework | 21 + 35 | 0 |
| backup-performance | 182 | 0 |
| backup-deletion-ui | 565 | 0 |
| backup-codec | 16 | 0 |
| backup-registry | 1404 | 0 |
| backup-assets | 26 | 0 |
| backup-audit | 43 | 0 |

初次 storage-migration 因调用已删除 API 而编译失败，保留日志；严格采用参考提交的两处手动保存适配后 84 项通过，未改其余断言。已移除功能的 manager-scheduling／scheduler／retention 三套测试与脚本随自动调度删除，以 manual-management 验证手动与历史文件管理。原始日志和逐套结果见 [backup/README.md](backup/README.md)。

## 构建、校验及验证边界

总成功数 **4430 项／0 失败**（3812 + 72 + 546）；红测、重复运行、定向编译不重复计数。未全量运行其它无关套件，也未恢复 2.1-21 以后的测试套件。所有主机测试使用替身、临时目录或隔离 defaults，不操作用户设备数据。

rootful／rootless 完整构建均 exit 0。每方案 6 条警告，与 2.1-20 规范化警告多重集一致，新增 0：UILocalNotification×2、statusBarFrame×2、multiply_defined×2。[build-result.json](build-result.json) 与两份 build 日志记录原始内容。42,511 个生产输入在构建前后及核验后保持一致。

双包版本、依赖、安装前缀、filter、staging／payload、arm64／arm64e、iOS 15.0、四份 dSYM UUID、12 个符号文件和 ZIP CRC 均通过。已实际执行 `shasum -a 256 -c SHA256SUMS`，三项全部 OK，见 [shasum-check.log](shasum-check.log)。task-start 1333 个 packages／.theos 文件逐字节保留，无 make clean、无覆盖已有包，见 [historical-artifacts-after-packaging.json](historical-artifacts-after-packaging.json)。

```text
0118be64951af9b49ae58c4133159839d44f2f76facffba052f4ce116e486eef  com.wechat.improve_2.2-1_iphoneos-arm.deb
fcc9f8417eaf3da2075fd3e177996fd720413a2afdd8107bd81ce93fca3123db  com.wechat.improve_2.2-1_iphoneos-arm64.deb
07639f5dc33ae6a8dc6e0dd535d308617ca2d1f9e229eb53c6d8a5c4983e363b  com.wechat.improve_2.2-1_symbols.zip
```

交付目录：`packages/2.2-1-manual-backup-and-miniapp-return/`。本轮没有连接、安装或运行真机。仍须真机确认：微信能正常启动，真实小程序自然返回的事件顺序，第一张可见屏幕帧的隐私与布局、真实滚动位置及触摸、真实 UIView 身份。旧录屏只证明旧包现象，主机契约与完整编译不替代这些验收。
