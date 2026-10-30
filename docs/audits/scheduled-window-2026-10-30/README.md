# 定时任务：时间段内执行

日期：2026-10-30。基于 `d15acffed6c2f6d5a6873d1d2c3f9ebacf218955` 的 2.1-19 源码增量实现。本轮不修改版本号、不打包、不提交 GitHub；没有运行 make clean，没有启动微信、共享服务或切换账号／数据库。测试只使用临时任务文件、隔离配置及原生替身，不发送真实消息。

## 用户入口与规则

插件设置 → 功能增强 → 定时任务 → 新建／编辑任务 → 时间规则 → 时间段内执行。

支持每天、周一至周五、自定义星期；分钟间隔 1–1440、小时间隔 1–168；开始时间、结束时间及最早生效时间。结束早于开始显示次日。起点包含、终点不包含，起止相同拒绝保存；星期属于开始日，每个窗口从开始时间重新锚定。间隔长于窗口时只有开始点；最早生效时间可排除较早的计划点。旧五种时间规则保持原样。

例如每天 09:00–18:00 每 30 分钟，执行 09:00、09:30……17:30；10:12 开启后下一次为 10:30。周五 22:00–次日 02:00 可延续到周六凌晨。周一至周五只按星期判断，不识别法定节假日。

只在本次计划所属的同一窗口内允许迟到执行／补发最近一次；窗口外跳过。异步领取写盘、原生 wrap 构造、联系人查询、账号 epoch 及 route submit 边界都复核窗口。发生时刻已领取后即使最终被取消，也不会因时钟回退而重放。提交给微信不等同于送达；系统挂起、强退、关机仍无法保证准点执行。

## 改动点

| 文件／方法 | 改动及原因 |
| --- | --- |
| `CSScheduledTaskSettingsViewController.m`：`reload`、`chooseRule`、窗口时间／单位／日期编辑方法 | 增加独立 window 编辑行，复用原时间滚轮与草稿保存；weekday 菜单按实际行定位；保留小时单位切换时的上限归一。 |
| `CSScheduledTaskStore.h/.m`：验证、定义白名单、`CSScheduledTaskNext`、`CSScheduledTaskLatest`、描述 | 增加 `mode=window`、`windowUnit`、`windowStart`、`windowEnd`，复用 interval／weekdays／zone／anchor；日级有界搜索和算术定位，旧模式分支不改。 |
| `CSScheduledTaskStore.m`：`CSScheduledTaskAllowsExecution`、`claimTaskOnQueue` | 校验发生时刻与当前时间属于同一窗口；仅对窗口规则修复找不到合法发生时刻的陈旧到期状态，避免每秒空转。 |
| `CSScheduledTaskManager.m`：`runSnapshotCurrent`、`run` | 在原发送保护边界增加窗口复核，越界取消记录为 skipped；原账号／epoch／generation／任务快照及单调时间预算保留。 |
| 三套 `ScheduledTask*Tests.m` | 保留原断言，增加窗口、异步越界、备份与拒绝输入回归。 |
| `README.md`、`docs/backup-guide.md`、功能文档 | 说明入口、时间规则、补发、系统限制、备份与旧版本识别限制。 |

只新增一个公开的窗口许可函数，没有改定时器架构、私有原生接口或密友展示策略。继续共用最近到期的一次性定时器，窗口外不增加轮询、网络或空转写盘。

时区边界使用日历：缺失的边界取下一个有效时刻，重复边界取第一次；被 DST 压成零长度的当天窗口跳过。向后／向前扫描覆盖缺失的整周窗口；窗口内间隔按实际经过秒数计算，秋季回拨可出现相同显示时分的不同真实计划点。

## 验证

| 验证 | 结果 | 证据 |
| --- | --- | --- |
| `verify-scheduled-tasks.sh` | 387 项通过 | [scheduler.log](scheduler.log) |
| `verify-scheduled-task-manager.sh` | 2319 项通过 | [manager.log](manager.log) |
| `verify-scheduled-task-backup.sh` | 505 项通过 | [backup.log](backup.log) |
| 原有联系人选择器定时任务分支 | 278 项通过，未新增时间控件 UI 覆盖 | 子代理工具输出；没有持久 stdout 日志 |
| Store／Manager 的 iOS arm64、arm64e 语法编译 | 4 次全部通过，零警告，`-Wall -Wextra -Werror` | [core-ios-syntax-results.json](core-ios-syntax-results.json) |
| Settings 的 iOS arm64、arm64e 语法编译 | 2 次全部通过，零警告，`-Wall -Wextra -Werror` | [ui-syntax-results.json](ui-syntax-results.json) |
| 独立时区往返探针 | 5120 项通过，纽约／柏林／豪勋爵岛／阿皮亚 | 只读复核代理工具输出；临时探针不属于正式套件 |
| `git diff --check` | 通过 | 最终工作树检查 |

三套核心合计 3211 项。覆盖开闭边界、跨午夜星期归属、不整除间隔、间隔长于窗口、最早生效时间、DST 缺口及回拨、跨缺失周查询、重启防重、补发及关闭期间不补发、陈旧 due 不空转、实际 claim 落盘后才能提交、各提交边界越过窗口取消、定义备份及恢复关闭总开关、26 类无效输入拒绝且原文件不变。

验证不是完整插件构建，也不等同于微信真机验收；本轮没有生成包或安装到设备。版本三处、ScheduledTask Hook 与基线一致。SHA256 明细见 [change-manifest.json](change-manifest.json)，最终检查见 [final-verification.json](final-verification.json)。

## 真机验收

1. 文件传输助手创建每天的短时段、每 1 分钟任务，核对开始包含、结束排除、下次执行与记录；开始等于结束应拒绝保存。
2. 选择指定星期，验证 22:00–次日 02:00 按开始日归属；分别检查分钟／小时单位及大间隔显示。
3. 窗口内错过后回前台，关闭补发应跳过超 30 秒时刻，开启补发最多补最近 10 分钟的一次；窗口结束后回前台不能补发。
4. 关闭总开关再开启，从下一个未来计划点开始；编辑、删除、重启、切账号后不重复或跨账号发送。
5. 打开日期／时间／单位菜单后取消，返回原编辑页；选择联系人取消后窗口草稿保留，保存后重进仍一致。检查弹窗／全屏、iPad 弹窗锚点、深浅色和长摘要。
6. 手动备份、修改任务再恢复，同账号窗口定义应恢复，运行状态不导入，总开关关闭；确认后开启只排未来计划。系统长期挂起后的结果按窗口及原错过规则验收，不把后台音频或 AI 同步视为此功能的保证。
