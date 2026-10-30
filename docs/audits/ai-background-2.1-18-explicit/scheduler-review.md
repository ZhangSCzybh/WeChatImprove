# 2.1-18 Scheduler 显式事件请求审查

日期：2026-10-30。范围为 `CSAIBackgroundSync.h/.m`、`AIBackgroundSyncTests.m` 及现有 `verify-ai-background-sync.sh`。修改前副本位于本目录 `baseline/Controllers` 与 `baseline/Tests`。本轮测试只使用临时可执行文件、假资格与单调时钟；未启动微信、连接账号、请求网络或改用户数据。

## 最终行为

Scheduler 没有 NSTimer、延迟任务、待处理事件或重试队列。`refresh` 仅查询资格并激活观察，`active` 表示 `running`，不再要求有有效 timer。启动、恢复后台音频、恢复资格、配置保存完成、`invalidateVerifiedSync` 和时间流逝都不会创建请求。

只有调用者验证过的外部完整原生同步完成事件才能进入 `verifiedFullSyncCompleted`。当前资格、状态代次和有限非负单调时间均有效，且距上次事件请求至少 45 秒时，才调用一次 `synchronize`。间隔内的事件被消费，不排队、不延后、不因时间到达而补发；必须再有一个真实合格事件。首次合格事件没有历史请求预算，可以立即请求。

`eventRequestAttempted` / `lastEventRequest` 记录的是额外请求尝试预算，替代旧的周期尝试和同步健康覆盖字段。忙碌、拒绝、原生异常仍消费该预算；停止、重启、切换配置和失效不会清空预算，因此不能绕过最小间隔。切号后短时间内的事件也可能直接受到此节流，不会补发。

`contextGeneration` 仅在 `stop` / `invalidateVerifiedSync` 改变，供 Manager 冻结上下文。成功事件预留预算不会改变它。旧上下文在停止后重新激活也不能复活。`invalidateVerifiedSync` 为接口兼容保留原名，其新用途是撤销事件上下文；没有可撤销的定时健康覆盖，也不产生任何请求。

`processingEvent` 覆盖资格查询、时钟查询和同步 callback，阻断同步重入，包括 callback 中停止/重新激活并推进时钟的情形。`@finally` 保证异常后恢复处理标记。资格或时钟 callback 若改变 generation，旧调用先放弃，不能用旧资格结果停止已恢复的新调度器。非主线程完成事件直接忽略。

## 原 7 组用例的迁移

| 2.1-17 用例 | 2.1-18 对应验证 | 删除或改变的语义 |
| --- | --- | --- |
| `EligibilityAndCadence` | `EligibilityAndEventThrottle`：无事件时反复 refresh、推进时钟和运行主循环均不请求；事件才请求，45 秒内被抑制 | 删除首次 refresh 立即请求、固定节拍、timer tolerance/fireDate 与错过节拍补一次的验证；这些行为已移除 |
| `StopRestartAndStaleTimers` | `StopRestartAndNoReplay`：停止忽略事件，恢复不自动请求，节流跨停止保留，contextGeneration 撤销旧上下文 | 无 timer，故删除 stale/manual/foreign timer 验证；旧 timer 的归属风险由事件上下文代次验证接替 |
| `ReentryAndRejectedAttempts` | `ReentryAndRejectedEvents`：忙碌事件消费预算，callback 重入/停止/恢复都不递归请求 | 删除失败后下一轮 timer 重试；现在只有下一个真实事件有请求机会 |
| `InvalidTimeAndRelease` | 同名：NaN、无限值、负时间与回退不请求；无事件时 clock 恢复不请求；弱引用可释放 | 删除无效时间自动重新设 timer、timer 释放验证；无效事件直接消费，没有恢复后的自动工作 |
| `RevocationInsideBoundaries` | 同名：资格/时钟查询重入停止或失效后，旧事件不能继续；重入恢复的新代次保持 active | 由 timer callback 边界改为显式事件边界；不再通过新 timer 恢复尝试 |
| `VerifiedCoverageAndInvalidation` | `ExplicitEventInvalidation`：失效只撤销 context，保留预算且不请求；恢复资格也需新事件 | 删除 lastVerifiedSync 覆盖、完成后 45 秒顺延兜底及覆盖到期自动同步；这些状态与行为均不存在 |
| `CompletionReentryAndFailures` | `CompletionReentryAndExceptions`：资格/clock/callback 递归事件被拒，异常保留预算并清处理标记，非主线程事件忽略 | 删除原生抛异常后自动保留/触发下一 timer 的验证；异常后无定时重试 |

旧套件为 78 项检查，新套件为 72 项检查。检查数变化来自上述定时行为删除与事件语义替换；保留的安全条件通过对应事件场景验证。现有验证脚本仍适用，未更改其编译参数。

## 验证与边界

运行 `bash Tests/verify-ai-background-sync.sh --ios`：72 项检查通过，arm64 / arm64e 源对象编译通过。最终日志为本目录 `scheduler.log`。指定源文件与测试的 `git diff --check` 通过。

Scheduler 不推断事件来源。Observer 必须独立验证完整原生响应、账号归属，并把插件额外请求及保守处理的续页标为不可再请求；Manager 负责一次性消费与上下文终检。没有观察到合格原生事件时，不存在兜底，额外请求数保持为零。此验证不证明真机一定有自然事件、消息必达或耗电变化。
