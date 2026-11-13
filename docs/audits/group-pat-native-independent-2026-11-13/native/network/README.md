# 微信原生生命周期与网络前后台信号

本目录仅采用本轮重新提取的微信 8.0.80.34 ARM64 二进制。身份及哈希见 [../../target.json](../../target.json)。以下地址均为未滑动 VM 地址；反汇编注释为辅助提示，结论依据实际指令及核对后的调用和参数。

## 已确认的调用

`MicroMessengerAppDelegate.applicationDidEnterBackground:` 在构造 `default` 字符串后，分别在 `0x104e857a4`、`0x104e857fc` 把首参数置为 0，于 `0x104e857a8` 调用 `0x107c0c310`，于 `0x104e85800` 调用 `0x10b7439a0`。第二路调用有其前置能力检查，不能表述为任何配置下都无条件执行。

对应 `applicationWillEnterForeground:` 在 `0x104e86338`、`0x104e86390` 将首参数置为 1，于 `0x104e8633c`、`0x104e86394` 调用同两路函数。由此能确认原生传递了独立的网络前后台状态，而不是只记一条生命周期日志。

第一路的已核对路径为：

```text
0x107c0c310 -> 0x10f83d454 -> 0x1130e6870
  -> 获取信号对象 / 分发
注册函数 0x112dabf5c（mars::mmext，mmstn_logic.cc）
  -> 已注册回调 0x112db03b8 -> 0x112db26e0
  -> 0x112debb50（mm_core.cc，OnForeground）
```

`network-signal-xrefs.json` 保留探索定位结果；其中候选引用本身不证明调用可达性，以上结论只取已逐段核对的链。所附 `0x112debb50.asm` 明确包含 `mm_core.cc` / `OnForeground` 字符串及传入状态的保存和后续任务分发。

另外，NewSyncService 会在后台调用 `sendBgFgRequestWithOnlineMode:2`，前台登录状态下传 1。其发送方法确实构造 BgFgRequest、写入 onlineMode 并提交网络事件。相关原生汇编保存在 [../sync](../sync/)。

## 结论范围

项目的 UIKit 后台任务和 AVAudioPlayer 保活，不能单凭“进程仍可执行”就推导上述在线上报或网络状态仍与前台相同。这与用户报告其他后台任务正常并不矛盾。

本目录没有证明这些状态导致了实际群拍延迟，没有确认服务器对具体群拍选用的传输命令，也没有证明把 onlineMode 或任何信号强制为前台就能满足即时接收。是否应改这一层，取决于同一次事件的原生通知到达与完整消息到达时序。

`MicroMessengerAppDelegate_handleReceiveRemoteNotification_requestID_.asm` 为普通远程通知转发证据；具体 Active-only 同步条件在 NotificationActionsMgr 内，见 [../notify/confirmed-notify-chain.md](../notify/confirmed-notify-chain.md)。
