# 2.6-0+notifydiag.1 来电通知诊断

**后续设备报告：所有通知入口及点击计数为零，只有生命周期记录；用户确认直接点击了残留通知。** 核查证明本版点击监测漏了微信实际通知代理和场景转发，不能据此判断通知来源。请使用 [诊断第 2 版](../2.6-0-notification-diagnostic-2/README.md)。下文保留本版构建和验证历史。

用户反馈：安装 2.6-0 后，微信仍在后台／锁屏时显示“你收到了通话邀请”，点击进入微信首页。2.6-0 的主机回归未覆盖这条真实通知来源，本版用于取得设备证据，不宣称已解决残留提示。

## 安装及复现

当时按 Rootless 方案提供 [历史诊断包](com.wechat.improve_2.6-0+notifydiag.1_iphoneos-arm64.deb)，版本为 `2.6-0+notifydiag.1`。用户后续确认使用 App 内注入后重签／TrollStore 类安装，此处构建方案不代表实际越狱环境。该版本按 Debian 规则高于 `2.6-0`，不覆盖前版安装包文件。两种 CPU 切片均包含，最低编译目标 iOS 15.0。

1. 进入插件的密友设置，点右上角“通知诊断”→“开始本轮记录”。
2. 保持原来的密友与拒接设置，让微信进入后台或锁屏，使用原来能复现问题的来电再试一次。
3. 残留通知出现后，**点击这条通知回到微信**；这一步用于判断系统交付的是远程 Push 还是本地通知。
4. 返回密友设置→“通知诊断”→“复制报告”，把报告完整发回当前对话。

记录仅保存在当前微信进程内存中，复现期间不要划掉微信。停止记录后仍可复制；重新开始会清空上一轮记录。账号 epoch 变化时清空并停录。

## 已确认的证据

- 微信 8.0.80.34 主程序的 `Voip_LocalNotification_Tips_IF_TIPS_CLOSE` 与通知扩展的 `NSE_WCNotificationEncryption_NotificationContent_ApsAlertTitle_VoIPDefault` 都对应“你收到了通话邀请”，仅凭文案无法判断来源。
- 插件当前只注入微信主程序，通知扩展 bundle `com.tencent.xin.WeChatNotificationServiceExtension` 不在注入范围。存在进程外的通知生成方，不代表用户这条通知已经被证明来自它。
- 主程序还有 `MMLocalNotificationMgr` 的独立 VoIP Push 通知路径。它会把推送转成普通 type=1 的 `CMessageWrap`，不保留 room/media，不能把 cmd=501 或普通消息通知全部屏蔽。
- 2.6-0 的 100 项通知集成检查直接调用 MonoService 通知入口，不能证明系统远程通知、独立 Push 分发或通知扩展已被覆盖。

本版读取被点击通知的 `UNPushNotificationTrigger` 类型，并记录现有 MonoService、通话通知策略、设置回调、通用 Push、local info 和最终 UN 提交的固定事件计数。额外记录真实存在的 `VoIPPushKitNotifyService` 两个类方法是否进入，保留原参数、BOOL 返回值和 completion。

## 数据与行为

采集默认关闭，开始后最多保留 64 条相对时间事件及固定计数。可复制报告只包含经过校验的版本、白名单 Hook 安装状态和固定事件；没有通知正文、标题、payload/userInfo、账号、联系人、房间或 request 标识、聊天记录和路径。诊断不增加通知拦截或改变拒接规则，没有迁移、清空或修改账号配置。

## 验证

- `bash Tests/verify-close-friend-call-diagnostics.sh`：100 项诊断专项检查通过，覆盖默认关闭、白名单、敏感内容拒绝、64 条事件上限、重置、停止后导出及账号 epoch 变化。
- `bash Tests/verify-close-friend-alerts.sh`：348 项核心检查通过，其中包含原 100 项通知集成检查；附带 902 项角标检查通过。该结果仅证明现有主机覆盖范围内行为保持，不代表本次残留提示已修复。
- 新诊断 Hook 已按指定微信二进制的真实 ABI 独立复核，完整保留原调用。
- Rootless 正式参数打包完成；arm64／arm64e 两个切片均编译通过，最低 iOS 15.0、`/var/jb` 安装路径及 RPATH、原注入 plist 已核验。447 个生产输入的构建前后哈希一致。
- [Rootless 调试符号](symbols-rootless.zip) 的两个 UUID 与包内切片匹配，ZIP 完整性校验通过。[SHA-256 清单](SHA256SUMS) 已逐项验证。

编译日志、源输入哈希与定向原生证据保存于 `WeChatImprove-local-archive/audits/2.6-0-notification-diagnostic/`。本轮提供 Rootless 诊断包；原 Rootful 2.6-0 历史包保留。
