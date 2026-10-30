# 2.1-19 backgroundFallback 配置存储与备份边界审查

本子任务仅修改 `Controllers/CSAIReplyStore.m` 和 `Tests/AIReplyCoordinatorTests.m`。对照本目录 `baseline/` 检查，Store 的生产差异限定为新增严格布尔判断、默认值、配置校验允许键及可移植导出允许键。`CSAIReplyStore.h` 与基线逐字节一致，连接指纹函数、持久化提交、账号隔离、历史记录及消息去重逻辑均未修改。

- 新配置包含 `backgroundFallback = YES`。
- 旧配置缺少该键仍通过配置与状态校验，加载和备份导出不强制补写该键。缺键按开启消费的运行时语义由 Manager/Scheduler 实现及其测试负责，本文件不声称 Store 已将旧配置迁移为显式 YES。
- 显式值只接受 CFBoolean。字符串、普通 NSNumber（包括整数或浮点 0/1）、空值、数组及字典均拒绝。其他既有配置键的布尔校验保持原样。
- `CSAIReplyPortableState` 同时保留显式 YES 与 NO。仅切换此键不会改变 `CSAIConnectionIdentifier`、`verifiedConnection` 或 `verifiedAt`。

备份导入链路只读检查结果：`CSBackupEngine.m` 捕获、恢复和比较均复用 `CSAIReplyPortableState`；`CSBackupRegistry.m` 的 AI 状态校验委托 `CSAIReplyValidateState`。没有另一个需要添加新键的配置白名单，因此无需修改其他备份生产文件。恢复继续限制原账号，并按既有规则关闭 AI 总开关、清空凭据版本和连接验证、不导入运行记录。普通切换的验证状态保留与备份恢复主动清验证是不同的既有行为。

验证使用 macOS 主机测试、UUID 临时目录及测试账号 `fallback-toggle-test`，完成后删除目录。未启动或重启服务，未访问微信真实账号或数据库，未进行全项目构建、打包或 clean，未更改基线、旧审计或已有安装包。

执行命令：`bash Tests/verify-ai-coordinator.sh`。修改前实际执行结果为 4496 checks；修改后退出码 0，总计 **4588 checks**，新增 `BackgroundFallbackConfiguration` **92 checks**。完整最终输出保存于 `coordinator.log`。`git diff --check -- Controllers/CSAIReplyStore.m Tests/AIReplyCoordinatorTests.m` 通过。

新增用例覆盖：

1. 新 Store 和默认配置开启；旧缺键配置有效，真实磁盘加载保持缺键且不改写原文件，既有验证时间与指纹保留；旧格式可移植状态可恢复。
2. YES → NO → YES 三次切换均通过真实磁盘保存、读取和新 Store 加载；全局 AI enabled 与连接指纹、验证标记、验证时间保持；每次可移植导出和独立文件恢复均保留具体开关值。
3. 导出仍剥离凭据和验证字段；按 BackupEngine 当前规则整理可移植状态后，真实 Store 恢复保留新键，并维持 AI 总开关关闭和凭据/验证清空。
4. 11 种非法值分别使直接校验和 Store 保存失败，且错误非空、Store 仍 ready、内存已接受配置与磁盘字节不变。

验证边界：本回归执行真实 Store 与 portable 导出/恢复路径，并模拟现有 BackupEngine 的恢复清理规则；没有在此 runner 内链接并执行完整 BackupEngine，也没有执行微信设备端后台唤醒。运行时调度与 UI 由对应子任务独立验证。

最终 SHA-256：

| 文件 | SHA-256 |
| --- | --- |
| `Controllers/CSAIReplyStore.m` | `4937f4bb757f1145ab6f89561a91c88683c03d8eb03499fb4ed93651845cec7a` |
| `Controllers/CSAIReplyStore.h`（未改） | `a4f48bbe945922a90990d07eef258fad25cf31814497293a58ff8edf4f5572fc` |
| `Tests/AIReplyCoordinatorTests.m` | `7b672a22e331ffb2fb0cfc4558a4c745395ca8774b1528d672902bff6ec4cada` |
