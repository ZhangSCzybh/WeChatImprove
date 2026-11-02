# AI / 设置界面接口一致性复核

2026-11-02，现有 checkout：`/Users/zhangshichao/Documents/Workspace/WeChatImprove`。

- `CSBackgroundRunManager.h` 保留 `backgroundAudioActive`，新增只读 `canAttemptBackgroundWork`；注释明确它是当前执行机会，不能保证系统不会挂起。
- Manager 的能力条件为已开启、后台、当前 cycle 有效且未结束，再要求有效的自有音频或有效 task 和正剩余预算。未把 `supportsBackgroundAudio` 声明当作执行资格。
- `CSAIReplyManager.m` 两次后台同步资格判断均使用新能力；初始检查先排除非主线程。账号、连接、会话免 @ 配置、授权、前台转换及原生服务校验继续保留。
- Manager `publish:phase:` 在能力或音频变化时发布 `CSBackgroundRunStateChangedNotification`；AI 继续监听该通知并刷新。过期或失去资格后，AI scheduler 自身也会重新校验。
- 设置页说明为有限后台任务优先、剩余预算不足时按需音频；预算持续恢复后停音频。后台音频行明确只呈现安装包声明；当前状态没有承诺永久运行或业务成功。
- `BackgroundSyncTaskWithoutAudio` 用独立替身信号验证任务有执行机会但无音频仍可补拉，资格撤销即停止、旧 timer 不生效、恢复保留 45 秒节流，以及原生读取过程中的资格撤销。

复核未发现 AI / UI 与新增接口之间的阻断性不一致。整合回归结果及完整输出见 `tests-integration.json` 和 `test-*.log`。这些测试使用临时目录、替身服务和模拟时钟，不代表目标微信真机后台时长、音频兼容或功耗已验证。生产编译与打包由主任务统一完成。
