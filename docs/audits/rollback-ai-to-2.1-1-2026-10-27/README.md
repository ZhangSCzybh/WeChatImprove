# 回退至原版 2.1-1

2026-10-27，按用户明确指定，将原项目目录的本地 `main` 源码恢复到 `f75012a1ceb264f86d11582480fd8b825ee6d94c`。使用新的回退提交保留后续历史；本次没有推送 GitHub、重新打包或安装到手机。

恢复范围为 `Controllers`、`Headers`、`HeadersFile`、`Hooks`、`Tests`、`Makefile`、`control`、`WeChatImprove.plist`、`README.md`、`package-lock.json`、`docs/features` 和 `docs/superpowers`。这些路径的暂存内容与工作区内容均已核对，和目标提交完全一致，版本号为 `2.1-1`。历史审计记录、既有构建文件和安装包保留。

该版本保留最初的 AI 自动回复、多个命名预设、群聊仅被单独 @ 时回复、手动回复与 AI 并行，以及密友列表隐藏不影响自动执行的行为。撤回百炼 Responses 会话续接、Session 缓存、Token 用量页面和群聊免 @ 等后续变更。此前后台发送问题的修复尚未写入生产代码，本次以用户指定的版本恢复为准。

回退前保存了源码、测试、未提交修改和构建产物，共 1,821 个文件，并逐文件校验压缩包 SHA-256。备份目录：

`/Users/zhangshichao/Documents/Workspace/WeChatImprove-backups/before-rollback-f75012a1-20261027-192403`

其中 `workspace-before-rollback.zip` 包含回退前文件，`unstaged.patch`、`staged.patch`、`state.json`、`files-sha256.json` 保存差异、版本和校验信息。原有更新说明的本地修改也已备份，当前说明恢复为目标版本。回退后核对 1,222 个原有 `.theos` 和 `packages` 文件，其内容全部保持不变。未执行 `make clean`。

核心回归全部通过：

- `verify-ai-foundation.sh`：存储、请求解析、错误处理、凭据替身通过。
- `verify-ai-coordinator.sh`：过滤、去重、合并、串行化、上下文、取消、过期通过。
- `verify-ai-manager.sh`：143 项通过。
- `verify-ai-native.sh`：67 项通过。
- `verify-ai-backup.sh`：49 项通过。
- `verify-background-run.sh`：176 项通过。
- `verify-close-friend-automation.sh`：185 项通过。

以上计数脚本合计 620 项检查，另有基础和调度专项。日志随本记录保存。测试使用隔离临时目录及替身，没有调用真实模型、发送微信消息或修改手机配置；它们不能证明手机上的后台回复已经恢复。现有安装包未重新生成，源码回退不等于手机已降级。
