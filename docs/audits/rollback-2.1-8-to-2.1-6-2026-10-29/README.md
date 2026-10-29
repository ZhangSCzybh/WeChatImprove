# 从 2.1-8 恢复到 2.1-6

2026-10-29 按用户要求完成代码回退。当前生产源码与正式测试 **602 项 SHA256 全部与 2.1-6 交付清单一致**，两处版本声明均为 **2.1-6**，没有残留的新增生产/测试源文件。已有包和审计记录全部保留。

## 回退依据与执行

权威基线是 [授权清理交付后的清单](../authorization-cleanup-2026-10-28/source-sha256-after.json)，与 2.1-8 审计保存的 `baseline-source-sha256.json` 完全一致。没有使用 Git HEAD 代替发布基线，也没有执行 reset、checkout 或 clean。

回退前确认当前 603 项输入仍逐项符合 2.1-8 最终构建输入，未发现交付后额外修改；反向应用 [2.1-8 完整增量 release.patch](../wechat-badge-fix-2.1-8/release.patch)，恢复 8 个修改文件并撤除 1 个新增测试。原内容已保存到 [pre-rollback-snapshot/](pre-rollback-snapshot/Controllers/CSGroupListAdapter.m)。预检见 [preflight.json](preflight.json)。

| 文件 | 回退内容 |
| --- | --- |
| `Controllers/CSGroupListAdapter.h/.m` | 恢复 2.1-6 的声明、角标计算和刷新流程，撤回 tab 三态接口与专用发布事件。 |
| `Hooks/CloseFriendNotificationHooks.xm` | 恢复 2.1-6 的三个 tab hook 和策略通知处理。 |
| `Headers/CSUserInfoHelper.h`、`control` | 两处版本恢复为 2.1-6。 |
| `Tests/GroupLifecycleTests.m`、`Tests/extract-group-lifecycle.py`、`Tests/verify-close-friend-alerts.sh` | 恢复 2.1-6 原始测试和脚本内容。 |
| `Tests/CloseFriendTabBadgeTests.m` | 撤除 2.1-8 新增正式测试，回退前副本保留在本审计目录。 |

逐项证据：[源码比较](source-comparison.tsv)、[恢复后 SHA 清单](source-sha256-after.json)、[初步回退结果](rollback-result.json)、[最终验证](final-result.json)。Git 相对 HEAD 原先存在的历史差异不在此次回退中清除；本次一致性以 2.1-6 的 602 项交付清单为准。

## 验证

| 项目 | 结果 |
| --- | --- |
| 2.1-6 源码与正式测试 | 602/602 SHA 一致；额外源文件 0。 |
| 版本 | `control` 和 `kPluginVersionString` 均为 2.1-6。 |
| 隔离编译 | `make all -j4 SCHEME=rootless` 成功；arm64、arm64e；6 条历史警告，无新增。 |
| 编译产物核对 | 2.1-6 版本字符串存在；2.1-8 专用 `closeFriendTabBadgeDecision` selector 不存在。 |
| `verify-close-friend-alerts.sh` | 216 项通过。 |
| `verify-group-lifecycle.sh` | 103 项，0 失败；隐藏回调发布 0/20。 |
| 历史产物保存 | `.theos` 与 `packages` 共 1264 项全部保持原路径、原 SHA；包含所有既有 2.1-8 包。 |

构建使用新建的系统临时目录，不写回原 `.theos`，没有运行 `make package`。未生成新包，未安装或更换设备上的插件。日志：[编译](build.log)、[编译结果](build-result.json)、[通知回归](verify-close-friend-alerts.sh.log)、[生命周期回归](verify-group-lifecycle.sh.log)、[历史产物对比](historical-artifacts-comparison.tsv)。

可运行 [verify-rollback.py](verify-rollback.py) 重新只读校验源码与产物，验证结果仅写入本审计目录。既有 2.1-8 审计记录作为历史交付证据保留，当前工作区状态以本回退记录为准。
