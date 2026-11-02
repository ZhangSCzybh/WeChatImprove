# 后台运行记录独立审查

审查日期：2026-11-02（Asia/Shanghai）。本次只读复核 `CSBackgroundRunManager` 的进程内运行记录逻辑，以及 Runtime 的日期／单调时钟接口和对应主机回归。未修改 Manager、音频实现、配置、设备数据或服务，未执行安装。按分工增加的 Runtime 日期 getter 及其验证见下文；正式测试日志由测试负责人另行留存，本文件不重复执行测试。

结论：在约定的检查口径下，未发现记录逻辑存在需要修复的问题。最后检查记录由明确的后台评估请求触发，普通设置刷新、重复应用／场景生命周期通知和返回前台后的 reload 不会把记录推进到新的时刻；后台轮次已结束后，无关音频通知也不会伪造更新。真正的进入后台、有效单次检查交付、当前任务到期和允许重新尝试的事件分别保留其身份／代次校验。

本轮确认的“实际检查”口径为：普通设置刷新和重复生命周期通知不计；有效后台周期内，音频事件触发 `reconcile`，重新读取 Runtime 预算并评估 task / audio，因此即使最终状态文字不变，也算一次实际检查。该口径不要求过滤成只有音频状态变化才记录。已经结束的周期不会因无关音频通知而推进最后检查时间。

对各项记录的复核如下：

| 记录 | 已检查的行为 |
| --- | --- |
| 最近一次后台开始 | 实际前后台转换创建新一轮并重置上轮记录；重复通知不改写开始时间。开启功能时 Manager 已在后台，只能记录开始观察的时间，并将 `lastBackgroundStartObserved` 设为 NO |
| 最后实际检查及当时状态 | 在 `checkRecordRequested` 且观察仍打开、仍在后台、功能仍启用时，保存检查时的 `currentDate`、状态及 `uptime`；同状态的有效单次检查继续推进内存记录，时间戳更新本身不发布状态通知 |
| 返回前台 | 仅首次从后台转换到前台时记录；随后 active 通知、设置刷新或迟到检查不会覆盖返回时间或补造后台检查 |
| 停止时间与原因 | `recordStop:` 只在本轮还没有停止记录时写入；已有到期／关闭原因不会被后来的返回前台改写。明确重新启用或允许恢复后开始新尝试，会清除停止状态并重新评估 |
| 最后检查距返回间隔 | 用 `uptime` 差值计算，未知或无有效单调时间时返回 -1；不使用两份展示日期相减，因此墙钟回拨不产生负间隔 |
| 迟到／旧回调 | 单次检查验证检查代次和轮次代次；任务到期验证轮次代次与 task 对象身份。旧轮次／取消后的回调不能改写新记录或复活旧资源 |

墙钟与单调时钟职责已分开：`currentDate` 返回 `NSDate.date`，只用于展示事件发生的本地日期时间；`uptime` 继续用于调度、恢复持续时间和最后检查距返回的经过时长。用户修改日期或时区时，展示时间可以前后跳变，但诊断间隔仍遵循单调时间。记录以 Manager 内存字段保存，没有新增记录 Timer、文件、defaults 键或数据库写入。

最终通知优化已单独只读复核：`publish:phase:` 的记录写入块不再把 `changed` 强制置为 YES，检查时间和快照仍照常更新；phase、可尝试执行能力、音频活跃状态、状态文字或上次后台结果变化，仍会发布 `CSBackgroundRunStateChangedNotification`。AI 的状态 observer 每次通知都会异步 `refresh`，因此该修改避免同状态的 26 秒检查或临界区 1 秒检查仅因时间戳改变而追加配置刷新。执行能力实际变化的通知条件保持完整，未发现因此漏掉 AI 所需状态变化。

后台运行返回前台时从运行／终止阶段转为 standby，仍发布状态变化；设置页 `viewWillAppear:` 每次调用 Manager 的 `reloadSettings` 并 `rebuildSections`，重新读取最新记录。因此最新检查时间的展示依赖返回／进入设置时的读取，不需要每次后台检查都广播。该优化的通知行为新增断言及后台／AI 回归由测试负责人执行；本审查没有重复运行，下面留存的命令结果为此前已完成的验证，不将其称为这项最终通知优化后的独立重测。

已执行的验证命令与结果如下。以下结果来自审查期间已完成的一次执行，编译产物和数据均在脚本临时目录或隔离 defaults 中；本文件落盘时没有再次运行。

```text
bash Tests/verify-background-run.sh
Background run: one-shot runtime boundary, finite task cleanup, public lifecycle and in-memory audio contracts
Background records: 51 checks passed; actual checks, lifecycle timestamps, monotonic gaps and stale callbacks verified
Background hybrid: 138 checks passed; deterministic budgets, lifecycle, audio handoff and expiration verified
Background run: 186 checks passed; production manager, audio ownership and native hook bodies verified
```

同一次脚本还以 `afinfo` 校验生产生成的音频为 8 秒、16000 Hz、单声道 Int16 WAV。记录专项的 51 项检查覆盖：前台初始无记录、同状态周期检查推进、重复设置／生命周期通知不推进、返回保留最后检查、到期停止原因返回后保持、开关切换、旧回调与新一轮隔离、迟加载观察、墙钟回拨下的单调间隔，以及音频激活过程中返回前台后不再补写后台检查。

Runtime 独立专项在加入 `currentDate` 后已执行：

```text
bash Tests/verify-background-run-runtime.sh --ios
Background runtime: 47 checks passed; task expiration, ownership and one-shot checks verified
Background runtime iOS: arm64 + arm64e source objects compiled
```

日期 getter 的新增断言用调用前后两次系统日期夹住返回值。该专项还覆盖申请失败、任务到期／结束幂等、同步与非主线程到期、旧新任务隔离、Timer 取消／迟到／重复交付及引用释放。iPhoneOS 对象使用真实 SDK、iOS 15.0 target 和 `-Wall -Wextra -Werror` 编译 arm64 / arm64e 两种架构。

这些记录表示进程在某个检查时点确实执行了相应代码，不是持续驻留证明。两次检查之间可能有系统挂起、Timer 延迟、网络阻塞或其他未观察到的状态；“最后检查距返回间隔”只能说明最后一次可确认检查到前台事件的时间差，不能据此精确判定进程何时被挂起。进程被系统结束、用户划掉或重启后，内存记录会丢失；迟加载时也不能还原此前真实后台进入时间。

本次没有设备端长期后台、锁屏、温度、续航或消息到达率验证。主机测试通过不证明系统持续给予后台时间，也不证明定时任务、红包或 AI 回复在后台必达。
