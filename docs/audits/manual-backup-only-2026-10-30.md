# 仅保留手动备份：实现与验证

日期：2026-10-30。工作目录：`/Users/zhangshichao/Documents/Workspace/WeChatImprove`，分支 `main`。本次是源码变更，版本仍为 `2.1-21`；未打包、安装或提交推送。

后续已完成后台运行策略改造，并按用户要求统一发布为 `2.1-22`，见[交付记录](release-2.1-22-background-policy/README.md)。下文保留仅手动备份改造阶段的范围与验证结果。

## 确认范围

用户要求删除自动备份，并明确确认恢复/重置前也不自动创建保护快照。后台运行的时段、时长及节能策略本次仅提供[方案](../background-run-policy-proposal.md)，未修改后台运行实现。

## 最终行为

- 删除自动备份开关、配置/资源/前后台监听、变更合并调度器、定时器、版本更新备份及失败状态展示。
- 新保存接口固定创建 `manual`，直接发布，不再扫描历史做自动去重，也不触发数量清理。
- 恢复/重置准备阶段不发布保护 `.wcbak`，新事务不写 `protectionID`。
- 保留预览一致性校验和事务 `before` / `beforeWrites`，仅供本次操作失败或中断后的回滚。成功操作后若要恢复以前的完整配置，须使用用户事先手动创建的备份。
- 历史 `automatic` / `upgrade` / `protection` 文件保留，仍可读取、导入、导出、预览恢复及手动管理；旧事务的保护文件引用继续受删除保护。
- 名称、收藏和导入元数据保留，损坏时可确认、修复，不与完整配置备份混淆。
- 旧 `auto_enabled` 仅保留为登记兼容字段，以维持旧 v2 和已准备事务的 revision 校验；没有运行消费者，读回开启值也不会创建备份。
- 删除设置入口中仅为自动备份而提前创建 Manager 的启动任务；真实待恢复事务仍由 Bootstrap 解析和交接。
- 清理 Bootstrap 已无用途的版本探测参数，启动是否需恢复仅取决于事务日志。

## 验证

所有主机测试均使用临时目录、隔离 defaults suite 或内存替身，不操作手机中的真实配置和备份。以下 20 组共 3812 项检查通过：

| 验证脚本（Tests/ 下） | 检查数 |
| --- | ---: |
| verify-backup-engine.sh | 25 |
| verify-backup-transactions.sh | 104 |
| verify-backup-reset.sh | 33 |
| verify-backup-restore-paths.sh | 249 |
| verify-backup-store.sh | 51 |
| verify-backup-manual-management.sh | 130 |
| verify-backup-deletion.sh | 140 |
| verify-backup-compatibility.sh | 66 |
| verify-ai-backup.sh | 97 |
| verify-scheduled-task-backup.sh | 507 |
| verify-plugin-storage-migration.sh | 84 |
| verify-backup-bootstrap.sh | 34 |
| verify-plugin-framework.sh（入口与启动集成） | 21 + 35 |
| verify-backup-performance.sh | 182 |
| verify-backup-deletion-ui.sh | 565 |
| verify-backup-codec.sh | 16 |
| verify-backup-registry.sh | 1404 |
| verify-backup-assets.sh | 26 |
| verify-backup-audit.sh | 43 |

事务测试真实启动子进程，在写入、资源、配置、同步和提交边界中断，再跨进程恢复；每次准备均确认没有新保护备份。另模拟带历史 `protectionID` 和惰性开关值的旧事务，验证中断回滚及引用解除后手动删除。恢复路径测试覆盖合并存储、文件权限错误和真实原子写入失败。

性能检查在 0 / 20 / 80 份历史文件下，同内容及配置变化后的手动保存均为 0 次历史读取；普通列表分别读取 5 / 25 / 85 份文件，各一次。共享图片由 1 / 20 / 100 个字段引用时，编码阶段均只验证一份图片。此结果是主机 I/O 行为验证，不是手机 CPU 或耗电实测。

8 个变更生产 `.m`（Bootstrap、Engine、Manager、两个备份 UI、Registry、Store、Reset UI）在 iPhoneOS arm64 / arm64e、iOS 15 target 下通过 `-Wall -Wextra -Werror` 语法编译，共 16 次。Makefile 原始源文件表达式求值为 205 个存在且不重复的源码，删除的 Scheduler 不再纳入构建。

Bootstrap 验证用 Logos 实际生成并编译全部 Hook：35 个有屏障的功能文件、9 个独立原生适配器、2 个恢复基础文件，另验证 Objective-C++ 的 C 符号链接。变更的 CustomEntry Hook 双架构单独检查时存在 8 条原有 unused-parameter 诊断，与 HEAD 基线逐项相同；只关闭该类诊断后通过，未引入其他诊断。没有执行完整链接构建或真机 UI 验收。

## 数据与交付边界

未修改历史备份文件、现有发布包或 `.theos` 构建产物。未清理历史工作树改动。当前手机继续运行原已安装包；本次变更需后续版本发布和安装才会进入手机。当前使用说明见[备份指南](../backup-guide.md)。
