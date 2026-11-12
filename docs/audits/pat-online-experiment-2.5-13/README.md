# 2.5-13 后台在线模式实验审计

该实验对应用户已批准的下一步：默认关闭的后台接收模式验证开关，无新增定时补拉。正式仓库基线 `5b10a59bc42214e5beb68529a8009485abd35518`，正式源码仍为 2.5-13；仅提交独立实验包、可重现补丁和验证记录。安装及手机验证步骤见 [包说明](../../../packages/2.5-13-online-experiment/README.md)。

## 已观察到的问题

最新 2.5-13+diag.1 手机采样持续 98.984 秒，437 条、无丢弃，8 个原生探针与事件同步 Hook 全部安装。49 个本地主队列 pulse 的间隔中位约 2001ms、最大 2094ms，因此这次没有长时间主队列停顿的证据。

83.441 秒唯一后台 message=4 同步通知到达；插件约 1ms 后请求同步，83.728 秒群／私两条拍动同批进入 raw 路径。私聊 raw 到文字提交约 67ms，群约 91ms，两者都在后台获得成功回调，96.937 秒才回前台。用户观察为“私聊立即回复，之前的群回复也在此时一起出现”。

这支持长等待主要发生在群拍动进入插件之前；没有支持群资料检查、持久认领或发送重试导致这次长等待。日志不能证明服务器此前没有发包，也不能证明在线模式就是根因。群 raw XML 快速解析虽有一次拒绝，但其他原生路径约 63ms 内成功转换，不足以解释数秒至数十秒等待。

## 原生证据与实现

微信 8.0.80.34 arm64，SHA-256 `e484889f7e32adce054e6b19bef373e2d1c3eb6984bc01176bbd40906373f317`，UUID `7E4A8171-5ACC-3A72-A76A-3ACE52D3D895`。有界反汇编确认前台传 mode1、后台传 mode2；sendBgFgRequestWithOnlineMode: 构造请求后通过 performSelectorOnMainThread 排队。两个 addBgFg…Event: 都先取消旧事件，再检查登录及 AddEvent，send 返回并不代表网络提交或服务器生效。

实现针对该已确认边界：

- 通过当前受信服务 wrapper 提交，保留账号上下文；raw service 只用于身份比较。
- 只对实验自身事件附加 epoch、revision、mode 与 raw 身份 token；原生 add 之前再次验证，过期请求在 cancel 之前拒绝。
- 自然请求用独立 TLS 观察 frame，原参数、调度参数与异常保留。自然事件永远执行原 add，完成后再观察模式并重审，避免跨调度队列的先后顺序假设。
- mode1 获取需要群配置、账号、授权和后台执行资格；mode2 恢复不再要求配置、授权或后台资源仍有效。明确账号／原始服务变化时关闭实验，不跨账号补偿。
- 重复同意图状态发布保留 pending；关闭、意图变化、账号和生命周期边界使旧请求失效。无请求循环，无周期性网络计时器；600 秒只用于本地一次关闭。

独立原生与实现审阅见 [native-review/REVIEW.md](native-review/REVIEW.md)。静态审阅只支持制作受限验证包，不能证明服务端接受模式或手机群拍动已达到秒发。

## 新增诊断字段

保留 schema=2，版本改为 2.5-13+online.1。新增 stage 不携带用户数据：

| stage | flags |
| --- | --- |
| online.switch | 0 关闭，1 开启 |
| online.snapshot | bit0 enabled，bit1 有待恢复租用，bit2 pending，bit3 hooks installed，bit8 起为最近 submittedMode |
| online.reconcile | bit0 enabled，bit1 群配置及账号授权有效，bit2 execution，bit3 lease |
| online.request.begin/end | 低位 mode；end bit8 原 send 返回，bit9 已观察到排队 |
| online.event.queued/cancelled | mode；cancelled 表实验旧事件在原 add 前被拒绝 |
| online.event.return | mode，bit8 原 add 返回；不等于服务器确认 |
| online.native.takeover | 微信自然 mode；send 入口及已观察 add 完成各记录一次 |
| online.expired / online.account.reset | 本地到期／账号或服务变化清理 |

采样开始会记录 snapshot，即使用户已经先打开实验开关也能看到初始状态。原有日志格式与解释见上一轮定位审计。

## 本机验证与复现

`online-source.patch` 保存正式基线到临时包全部生产改动，`online-tests.patch` 保存对应测试；包含沿用的临时诊断支持。将基线文件导出到全新临时目录后，顺序应用两个补丁，使用 `package-build-inputs.sha256` 检查 453 个生产输入。不要直接覆盖当前正式 checkout。

构建脚本为 `build_online.py`，固定 Rootless、iOS 15.0、arm64/arm64e 与版本 2.5-13+online.1；使用独立 `/private/tmp` 冻结输入、Theos 数据、输出及 deb 目录。**禁止运行项目 make clean，它会删除历史 packages。** `package-verification.json` 记录实际成品、UUID、哈希和历史文件保持结果；`validation-summary.json` 记录实际检查输出。

本机测试是合成事件与真实生产核心结合的验证，无法替代微信服务端、通知链路和手机后台执行实测。首次有效性判断必须在锁屏后仅群触发、不用私聊促发的条件下完成，失败也应保留完整采样。

本轮实跑结果：实验专项 9006 项（主套 8046，22 个独立 ABI 拒绝进程共 960）；Manager 常规 182、后台 110、dispatch-only 9；记录器 16285、回复关联 639；同步集成在关闭／开启记录时各 528，开启时捕获 547 条并验证阶段顺序。新增实验、Manager 和诊断记录器均通过 arm64 / arm64e 严格对象编译，最终完整 Rootless 包也已核验。453 项冻结输入与补丁重放一致，791 个正式基线文件及 82 个历史包文件保持。

在已应用补丁的隔离目录，可运行 `bash Tests/verify-automation-online-experiment.sh --ios`；构建使用 `python3 build_online.py /绝对路径/已打补丁的源码 /绝对路径/全新审核输出目录`。脚本沿用项目 Makefile 中既有 Theos 安装路径，不启动服务，不操作真实账号或数据库。
