# 2.1-17：原生完整同步验证与约 45 秒后台兜底

本次按用户已确认的方案实现：确认当前账号的一次正常原生完整同步成功后，重排下一次额外同步；不能确认时继续兜底。将原约 30 秒间隔调整为约 45 秒。保留现有 AI 会话筛选、账号隔离、消息去重、过期拦截及通话音频让出规则。

## 调度行为

- 仅在微信处于后台、后台音频实际有效、AI 连接已验证，且至少有一个可用群同时开启 AI 和免 @ 时运行。没有开启 AI 的会话仍在消息入口提前过滤。
- 使用一次性定时器和单调时间，下一期限为 `max(最近一次尝试 + 45 秒, 最近一次已验证完整同步 + 45 秒)`；保留 3 秒 timer tolerance。主线程阻塞或系统挂起会带来额外延迟，不补发错过的周期。
- 请求前先预留尝试预算；忙碌、拒绝、异常也保留预算。停止调度不清除尝试冷却；原生完成事件不能启动已经停止的调度器。
- 只有完整验证成功才延后期限。单条消息到达、原生入口受理、忙碌状态及单独 finish/end 通知均不能建立覆盖。
- 账号、配置身份、保存流程或后台资格改变后撤销旧证据；等值配置替换、保存失败及迟到回调也不能恢复旧证据。

示例：最近一次尝试发生于第 0 秒，则原期限是第 45 秒；若第 20 秒确认了完整同步，期限改为第 65 秒；若该响应失败、仍需续页或无法确认，则仍保留第 45 秒的兜底机会。45 秒是调度间隔，不能作为消息到达或回复完成时限。

无可抵扣的原生同步、连续运行且忽略 timer tolerance 时，兜底尝试预算从约每小时 120 次变为 80 次；这是间隔计算，不能等同于实测流量、耗电或温度降幅。只靠兜底收到的消息也可能比此前多等待约 15 秒。

## 原生验证边界

当前只为微信 **8.0.78** 安装观察器，且三个目标方法的参数与返回 ABI 必须全部匹配。其他版本和不匹配的 ABI 保留约 45 秒兜底。

观察器不修改原生请求参数、返回值、状态字段、暂停或忙碌保护。后台请求继续通过原有账号 wrapper；仅将该 wrapper 作用域内的第一个有效 scene-12 原生创建与当前 epoch 绑定。未绑定服务不能自行取得账号归属；切号、原生重入、嵌套调用和异常均有作用域隔离。

只有以下路径成立才通知管理器：同一具体服务与非零 event、正常 CGI 138 和 `0x40007` 请求、终批 `ret == 0` 且 `continueFlag == 0`、实际处理结果成功。等待原生已排队的主线程收尾后，再核对无活动 event、未获取数据、未操作、无错误/暂停/待同步且已初始化。排队结果达到 45 秒、时钟异常或倒退时丢弃。管理器最后再核对一次性上下文中的 owner、Store/配置身份、账号、epoch、generation 和实际资格。

[静态证据与逐项审查](native-static/report.md) 基于限定的 8.0.78 本地二进制，只证明上述匹配请求的终批成功处理语义。它不能证明服务器每次均下发所有静默群消息，也不能保证 iOS 持续给予后台执行时间。保守拒绝无法确认的事件会继续产生兜底请求。

## 核心回归

以下均使用隔离主机 fixture 或临时编译目录，未调用真实微信账号服务、AI 接口或用户数据库。

| 范围 | 实际结果 | 记录 |
| --- | --- | --- |
| 45 秒调度、一次性 timer、预算、停止和重入 | 78 项检查通过；iOS arm64/arm64e 源对象编译通过 | `scheduler.log` |
| 管理器上下文、账号与配置变化、请求和完成终检 | 729 项检查通过；iOS arm64/arm64e 源对象编译通过 | `manager.log` |
| 原生观察器、原调用保留、ABI 拒绝、事务/终批/队列和 scope | 828 项检查通过；iOS arm64/arm64e 源对象编译通过 | [独立审查](observer-independent-review.md)、`observer-independent.log` |
| 自动回复协调、去重及过期拦截 | 4496 项检查通过 | `coordinator.log` |
| 原生自动回复适配 | 86 项检查通过 | `ai-native.log` |
| 后台音频、通话/中断及宿主音频所有权 | 186 项检查通过，音频与宿主 hook 检查通过 | `background-run.log` |

## 编译与交付

版本号、插件内版本说明及使用文档已更新为 `2.1-17`。Rootless、Rootful 完整编译及验包均成功，两个安装包都包含 arm64/arm64e，最低目标为 iOS 15.0。

使用 [构建脚本](build-packages.py) 为 rootless/rootful 分别创建全新临时输出目录，双架构目标为 arm64/arm64e、最低 iOS 15。不运行 `make clean`，并核对既有 `.theos` 和 `packages` 文件的前后哈希。

[验包脚本](verify-packages.py) 检查 Debian 版本与架构、安装路径、双架构、最低系统版本、注入 filter、包内与 staging 哈希、关键功能符号和四份 dSYM 的 UUID。调试符号 ZIP 通过校验后才发布。

实际执行：

```sh
python3 docs/audits/ai-background-2.1-17/build-packages.py
python3 docs/audits/ai-background-2.1-17/verify-packages.py
# 在 packages/2.1-17-ai-background/ 下执行
shasum -a 256 -c SHA256SUMS
```

[完整构建结果](build-result.json) 和 [验包结果](package-verification.json) 均通过。构建后再次独立检查 42,513 个生产输入文件，与构建快照全部一致；既有 `.theos` 和 `packages` 中的 1,267 个文件全部保留且哈希不变。两个 deb 和符号 ZIP 的 SHA-256 校验均为 `OK`，ZIP CRC 与四份 dSYM UUID 也通过。

每个方案有 6 条既有警告，分别来自 `UILocalNotification`、`statusBarFrame` 的废弃声明及 `-multiply_defined` 链接器选项；未阻止编译。详细输出见 `build-rootless.log`、`build-rootful.log`。

| 交付文件 | 用途 |
| --- | --- |
| [com.wechat.improve_2.1-17_iphoneos-arm64.deb](../../../packages/2.1-17-ai-background/com.wechat.improve_2.1-17_iphoneos-arm64.deb) | Rootless，安装于 `/var/jb/Library/MobileSubstrate/DynamicLibraries/` |
| [com.wechat.improve_2.1-17_iphoneos-arm.deb](../../../packages/2.1-17-ai-background/com.wechat.improve_2.1-17_iphoneos-arm.deb) | Rootful，安装于 `/Library/MobileSubstrate/DynamicLibraries/` |
| [com.wechat.improve_2.1-17_symbols.zip](../../../packages/2.1-17-ai-background/com.wechat.improve_2.1-17_symbols.zip) | 两方案、两架构的调试符号 |
| [SHA256SUMS](../../../packages/2.1-17-ai-background/SHA256SUMS) | 两个 deb 和符号 ZIP 的 SHA-256 |

本轮未安装到设备、未提交 GitHub。后台成功率、延迟、实际续航及发热仍需真机对照验证。
