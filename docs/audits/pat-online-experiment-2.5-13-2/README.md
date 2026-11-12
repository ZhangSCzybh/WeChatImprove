# 2.5-13+online.2 其他保活方式兼容修正

基线为 `3af45015ce464b7f1feb029ec362a98db274df9f`。用户明确需要使用其他插件保活，并反馈：online.1 开启本插件后台运行时群后台／锁屏立即回复，使用其他保活时仍等前台。后一种失败有本轮手机日志支持；前一种成功来自用户反馈，没有对应新日志，二者证据类型保持区分。

## 日志结论

文件 `WeChatImprove-2.5-13-online1-7541DAA9-63D4-4D94-8DF1-097B508D82CE.json`，版本 2.5-13+online.1，80.326 秒、530 条、手动停止、零丢弃。

| 采样时间 | 观察 |
| --- | --- |
| 1.944 秒 | online.switch=1，用户确实打开实验 |
| 6.664 秒 | 进入后台 |
| 6.804 / 6.808 秒 | online.reconcile=3：enabled 和 group eligible 成立，execution 和 lease 不成立 |
| 后台期间 | 26 个主队列 pulse；整轮 pulse 间隔中位 2000ms、最大 2126ms；没有实验 online.request.begin 或排队／add 记录 |
| 59.699 秒 | 微信自然前台 mode1 上报；这不是实验请求 |
| 59.758 秒 | 前台生命周期通知，原生前台动作可早于该通知 |
| 59.890 / 59.891 秒 | 两条 raw 拍动快照进入插件 |
| 60.034 秒 | 唯一群文字回复调用原生发送；对应 raw 到提交约 143ms |
| 60.566 秒 | 文字成功回调进入；不等于对方可见时刻 |

原生通知 message=4 在前台采样段出现，后台等待期间没有该同步通知。不能把普通 message=0/190 直接解释成群拍动到达。后台 pulse 证明这些时刻能执行主队列回调，不能保证未来永不挂起。

本次可以确定的是：online.1 的实验请求被插件自有保活资源门槛挡住。`CSBackgroundRunManager.canAttemptBackgroundWork/canAttemptGroupChatBackgroundWork` 只表示本插件拥有的资源，false 不表示微信没有获得其他方式提供的执行时间。故这轮失败没有测试到 onlineMode 实际上报的效果，也不能据此否定接收模式路径。

## 修改与保护

仅调整实验模块的 executionAvailable：要求当前主线程且 actual background，不再依赖本插件后台资源 getter。已有后台生命周期或原生回调到达时尝试上报；无新增网络计时器，没有启用音频、背景任务或改写其他插件设置。状态日志 `online.reconcile` 的 bit2 在 online.2 表示当前执行回调条件成立，online.1 中表示插件自有资源资格成立，分析时必须结合版本。

本插件自身资源失效不再单独触发恢复，因为无法由此推断其他保活方式失效。恢复仍由实验关闭、群配置／授权失效和超时触发；前台由自然模式接管，账号或 raw 服务变化关闭并废弃旧请求，已排队旧事件在原 add/cancel 前被拒绝。

原生 ABI、TLS 所有权、异步 add 边界和账号上下文逻辑未改变，证据与审阅沿用 [online.1 原生审计](../pat-online-experiment-2.5-13/native-review/REVIEW.md)。这次没有再次逆向或声称观察了微信服务器行为。

## 验证与重现

专项用真实 Environment/NSProxy/原生 ABI 分发和可控微信事件验证：插件自有两种资源均为 false 时仍能发出并提交 mode1；重复资源通知不额外发请求；关闭后仅一次 mode2；原生两种延迟队列中自己的资源变化不再错杀有效 mode1。还检查整套不查询插件自有资源 getter、不写持久配置，账号／前后台／服务替换／旧事件／异常与到期保护继续通过。

完整基线补丁为 `online-source.patch` 和 `online-tests.patch`，应用在从上述 Git 基线导出的全新隔离目录。`online1-to-online2.patch` 只展示上一实验到本版的生产和测试差异。`package-build-inputs.sha256` 覆盖453个冻结生产输入，`package-verification.json`、`patch-replay.json`、`validation-summary.json` 给出实际核验。历史86个包文件保持内容、大小及修改时间不变。

运行专项：`bash Tests/verify-automation-online-experiment.sh --ios`；构建：`python3 build_online.py /绝对路径/已打补丁的源码 /绝对路径/全新审核输出目录`。构建使用独立 `/private/tmp`，显式指定 Rootless 与各输出目录，不运行项目 make clean。正式源码与版本保持 2.5-13，试验包版本为 2.5-13+online.2。

其他插件保活下的真实即时回复仍需用户安装本版确认；本机通过不能代替手机执行和服务端接收。安装步骤见 [包说明](../../../packages/2.5-13-online-experiment-2/README.md)。

本轮实跑：实验主套8110项，22个ABI拒绝进程合计960项，总计9070项；诊断记录器16285项、回复关联639项；实验及记录器均通过arm64/arm64e严格对象编译。完整Rootless包通过版本、双架构、iOS15、安装路径、dSYM UUID、ZIP CRC及SHA-256核验；453个冻结输入及两种补丁重放一致，791个正式基线文件、86个历史包文件保持。
