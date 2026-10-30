# 2.1-18 Manager 显式事件集成审查

日期：2026-10-30。范围为 `CSAIReplyManager.h/.m`、`AIReplyManagerTests.m`，使用既有 `verify-ai-manager.sh --ios`。修改前 4 文件副本位于本目录 `baseline`，可与 2.1-17 的 729 项 Manager 回归及源码直接比较。

## 接口和上下文

保留 `captureBackgroundSyncContextForEpoch:` 与 `nativeFullSyncCompletedWithContext:`。前者是按当前 Store 账号捕获的快捷入口，后者等价于完成时允许请求。新增 `captureBackgroundSyncContextForEpoch:serviceAccount:` 冻结原生服务提供的 NSString 账号，并要求其非空、与 Store 账号一致，再走既有完整捕获流程。原生服务是否确实归属这个账号，仍由 Observer 对 raw service context 的身份与账号核验负责。

新增 `nativeFullSyncCompletedWithContext:allowsRequest:`。YES 在完成全部验证后把外部事件交给 Scheduler；NO 仍一次消费并验证 owner、Store、配置身份、账号、两个 epoch、Manager generation、Scheduler contextGeneration、active 与实际资格，但不会调用 Scheduler，不会预留请求预算，也不会创建延后工作。NO 消费过的上下文不能再用 YES 重放，即使已经超过 45 秒。

私有上下文新增冻结 `schedulerGeneration`，与只在停止/失效时改变的 `contextGeneration` 匹配。此举使停止后重新激活也不能复活旧原生事务。Scheduler 的 active 新语义允许已启用而无 timer 的 Manager 捕获自然事件，解决旧 active 依赖 timer 的第二层启动障碍。

保留 native getter 前后的快照终检、一次性 consumed、配置保存开始即撤销旧上下文、Scheduler 最后资格查询的 verifying context 与 `@finally` 恢复。捕获资格失败仅在原上下文仍匹配时停止该 Scheduler，不停止 getter 已换入的新账号/新配置。

实际原生额外请求继续使用原账号 wrapper，保留 ABI、原生 busy/拒绝/异常保护。完整账号/联系人/授权查询在 Observer frame 激活前完成；frame 内只进行纯状态快照比较，并额外核对 Scheduler contextGeneration，再直接调用保留 wrapper。未添加任何 timer 或请求队列。连接测试原有的 60 秒超时 timer 与此改动无关，仍保留。

## 受影响测试和语义替换

| 测试区域 | 保留与新增验证 | 被移除的旧假设 |
| --- | --- | --- |
| `BackgroundSyncReplies` | 后台启用但无事件请求数为零；明确外部完成事件才释放假排队消息并走原回复链；保留 19 项资格 gate、忙碌、拒绝、异常、切号重入、ABI 和 wrapper 检查 | 进入后台、恢复音频或资格后自动尝试；timer 到点自动拉取。旧 stale timer 检查替换为停止/恢复后旧 context 不可使用 |
| `BackgroundSyncContexts` | 保留 22 组 Store/配置/账号/epoch/generation 和 getter 重入场景；新增错/空 serviceAccount 拒绝、无 timer 即可捕获、停止后恢复不能复活上下文、NO 完整资格查询且一次消费、NO 超过 45 秒仍无请求 | 删除 verifiedSync / lastVerifiedSync 的 KVC 断言、完成后覆盖时间顺延以及覆盖到期自动同步；改用实际请求数与显式新事件验证 |
| 配置保存场景 | 相同配置保存成功、异步失败、宿主同步失败均撤销旧 token；恢复后无自动请求，45 秒后也仍需新事件 | 保存结束或旧尝试期限到达即自动请求 |
| `BackgroundSyncRequestReentry` | 5 组 helper 捕获时切号、相同值配置替换、撤授权、换 epoch、换 Store 均拒绝旧 wrapper；可被认领的 request body 内 account/contact/authorization native getter 计数为零 | 原先由 refresh 自动进入 helper；现在先证明 refresh 不进入，只有明确外部事件才进入 |
| 其它 Manager 测试 | 原配置持久化、连接测试、密友展示隔离、消息准入、普通/图片/群聊自动回复、异步凭据与账号边界继续由完整脚本执行 | 没有为无关功能修改断言以迎合新实现 |

`ConfirmExternalSync` 是测试中的受信任自然完成快捷入口：直接捕获并完成一次 Manager 上下文。它不代替 Observer 对原生 source/origin、raw service context、response 或 continuation 的独立测试。插件请求和 scene-6 等续页何时标 NO，属于 Observer 的来源策略；这些 NO 到达 Manager 后不能再发请求。

## 验证与交付边界

本轮 `bash Tests/verify-ai-manager.sh --ios` 运行 772 项检查通过，Manager arm64 / arm64e 源对象编译通过；最终日志为 `manager.log`。原 729 项检查因定时/覆盖语义替换和新接口/生命周期验证调整为 772 项，不能把数量差当作覆盖率结论。验证脚本原有 `--ios` 实现未改。

测试使用临时目录、假账号、假服务和假网络 client，未启动服务或写真实账号数据。此结果证明 Manager 的事件门禁和请求边界；完整自然 bootstrap 还依赖 Observer 从原生 context 证明账号归属。未知版本、不合格回调或没有自然同步完成时，额外请求会保持沉默；不再退回 45 秒拉取。本轮未降低消息接收、回复去重或发送保护，也没有改变 120 秒历史消息准入边界。
