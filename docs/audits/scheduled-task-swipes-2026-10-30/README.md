# 定时任务列表左滑启用／停止

2026-10-30。在本工作树已有的“时间段内执行”改造之上增量添加，不改版本号、不打包或提交 GitHub。基线保存的是本轮开始时的实际工作树，包含此前尚未提交的窗口规则，不能把它误读为 2.1-19 发布时源码。

## 行为

任务列表左滑保留红色“删除”，已启用任务显示橙色“停止”，已停用任务显示绿色“启用”。删除位置及原有全滑行为保留。空列表占位、非任务分组或无法操作的任务不提供新菜单。

菜单捕获任务 ID、账号、显示时的账号 epoch 和目标启用状态。点击时重新查找最新任务，验证存储就绪、未保存中、账号／epoch 未变及当前隐私可见性；列表重排不改变操作对象，已编辑的最新字段不会被旧菜单覆盖。过期、删除或隐藏后旧菜单取消并刷新。

启用／停止只修改当前任务的 `enabled`，复用原 Manager `saveTask:`，不自动开启总开关、不改时间规则或发送接口。过期单次任务沿用原“请选择未来的执行时间”校验，不修改时间使其立即发送。已启用时再次启用直接完成，不重新排期。

显式停止即使当前任务已经停用，仍走保存路径：单次任务领取执行意图时会先自动停用，但原生发送可能尚未发生；保存会让 Manager 推进 generation、撤销尚未提交的执行。已经交给微信的消息不由此撤回。

## 改动

- `Controllers/CSScheduledTaskSettingsViewController.m`：显示快照增加 epoch；新增身份查找、操作处理及 trailing swipe actions；任务组说明更新。原 `canEditRow` 与 legacy 删除方法正文保持不变。
- `Tests/ScheduledTaskSwipeTests.m`、`Tests/verify-scheduled-task-swipes.sh`：提取并执行真实的五个 UI 方法，使用临时 Store、真实隐私投影和局部 UI／Manager 替身。
- `Tests/ScheduledTaskManagerTests.m`：新增真实 Manager 下，已领取并自动停用的单次任务显式停止可取消原生提交的回归。
- `docs/features/scheduled-tasks-and-image-stickers.md`：补充左滑入口、总开关和停止语义。

Store.h/.m 与 Manager.h/.m 生产代码逐字节保持本轮开始时状态。前后 SHA256 见 [change-manifest.json](change-manifest.json)。

## 聚焦验证

| 验证 | 结果 | 日志 |
| --- | --- | --- |
| `bash Tests/verify-scheduled-task-swipes.sh` | 165 项通过 | [swipes.log](swipes.log) |
| `bash Tests/verify-close-friend-automation.sh` | 原 187 项通过 | [close-friend-automation.log](close-friend-automation.log) |
| `bash Tests/verify-scheduled-task-manager.sh` | 2360 项通过，上一轮 2319 + 新增 41 | [manager.log](manager.log) |
| 设置页 iOS arm64／arm64e 语法编译 | 两次通过，零警告，`-Wall -Wextra -Werror` | [ios-syntax-results.json](ios-syntax-results.json) |
| `git diff --check`、新脚本语法检查 | 通过 | 工作树／专项检查 |

测试覆盖菜单标题、异步成功／失败、启用同态不重排、停止自动停用单次任务、重排与更新后仍操作正确任务、账号／epoch／隐私／保存中门禁、总开关关闭、过期单次任务及旧删除路径。没有访问真实账号、发送真实消息、启动服务、切换 checkout／数据库或执行 make clean。

真机待验收：启用／停止后的文字、图标与调度刷新，删除及全滑行为，深浅色和菜单收起；总开关关闭时只启用单项；菜单展开后切账号或重新锁定密友再点击应取消。停止前已提交给微信的消息仍可能由微信发出。
