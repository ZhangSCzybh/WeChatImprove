# 密友后台／锁屏来电通知排查（2026-11-12）

**用户环境更正：已确认采用 App 内注入后重签／TrollStore 类安装，具体为普通证书重签还是 TrollStore、实际 iOS 版本及有效签名权限仍待核验。** 此前将用户称为 Rootless 环境未经核实。历史 Rootless／Rootful 安装包仅说明构建方案，不能证明设备越狱环境、扩展注入范围或重签后的 App Group／Keychain 权限。本轮先核验实际安装及权限，不要求重测已完成的同一诊断包。

**最新真机证据：`2.6-0+notifydiag.2` 在微信 `8.0.80.34` 上捕获到所点来电提示为远程通知。残留横幅／锁屏提示尚未修复。** 本轮 14 项 Hook capability 均为 YES，保留 13 条事件；`notification.response.remote=1`、`notification.response.local=0`、`response.enter=1`、`response.actions=1`，实际代理分类为 `delegate.actions=2`。已监测的 MonoService、Push、local info、local 输出、UN 提交和 VoIP 入口计数仍为 0。

本轮点击响应发生于记录开始后约 `+11.248 s`，随后 `+11.304 s` 回到前台。该记录证明所点通知的系统 trigger 为远程类型，且没有命中所监测的主 App 本地通知入口；**尚不能证明这条通知经过了 `WeChatNotificationServiceExtension`，也不能将静态存在扩展或入口计数为零等同于扩展运行时证据。** 诊断第 2 版已取得本轮所需点击证据，无需再次安装或复现该诊断包。标准化报告保存在 [本机 diag2 证据](../../../../WeChatImprove-local-archive/audits/2.6-0-remote-call-notification/user-feedback-diag2.normalized.json)，诊断实现与既有构建记录见 [通知诊断第 2 版](../../../packages/2.6-0-notification-diagnostic-2/README.md)。

此前按用户指令基于正式 `2.5-11` 实现主 App 本地来电通知过滤并编译交付 `2.6-0`，核心回归和安装包见 [2.6-0 发布记录](../../../packages/2.6-0-close-friend-call-notifications/README.md)。用户真机仍显示“你收到了通话邀请”，点击进入微信首页；该版本未解决用户实际问题。下文保留当时的排查结论与证据。

用户确认：密友来电能够自动挂断；微信前台正常；微信后台或锁屏时仍出现系统顶部横幅／锁屏通知，其他功能正常。本轮完成源码审查、原生静态核查和主机行为探针，未修改插件实现、版本或安装包。

## 结论

当前实现存在确定的来电通知过滤缺口：单人来电拒接与后台本地通知分别处理，拒接入口没有覆盖独立的异步通知任务。微信原生通知方法明确跳过前台、仅在非 Active 状态安排通知，因此该遗漏与用户反馈的前后台差异吻合。

已证明的是生产过滤逻辑缺口及指定微信二进制中的后台分支；尚未直接观察用户手机这次来电的运行时调用、APNs 送达和最终系统输出，不能把全部后台通知来源都判定为已验证。

## 项目与环境

- 工作目录：`/Users/zhangshichao/Documents/Workspace/WeChatImprove`；源码检查时 HEAD 为 `3f0d383a`，插件版本为 `2.5-13`。
- iOS 微信 Theos 插件，使用 Objective-C、Logos、Objective-C Runtime／Substrate；架构 `arm64`／`arm64e`，最低编译目标 iOS 15.0。
- `Hooks/` 接入宿主，`Controllers/` 包含设置、策略、业务协调和原生适配，`HeadersFile/` 提供微信私有接口声明，`Tests/` 提供主机回归夹具。
- 主要功能包括聊天分组、气泡与列表外观、消息菜单／手势、密友隐私、AI／定时任务／自动功能、群聊辅助、配置备份与恢复。
- 密友由 Store／Crypto 保存账号配置、Runtime／Policy 形成当前策略，Bridge／各 Adapter 与 Hook 接入宿主；通话由 CallAdapter、CallHooks、CallReply 处理，系统通知另由 NotificationAdapter／NotificationHooks 处理。
- 本项目不提供独立的网页服务 URL、前端端口、后端端口或本机业务数据库。真实账号数据在手机微信容器内；源码规定密友目录为 `Library/Preferences/WeChatImprove/CloseFriends/`。本轮未连接手机，未核验或修改其实际容器绝对路径、配置或数据库，也未重启共享服务。

## 源码证据

| 位置 | 已确认的行为 | 对问题的影响 |
| --- | --- | --- |
| `Hooks/CloseFriendCallHooks.xm:8` | Hook `VoIPilinkMgr`／`VOIPMessageMgr` 的 `onMonoServiceMsgHandleWithMsg:` 和 `onMonoServiceMsgStartWithMsg:` | 能提前提交拒接并阻止启动来电 UI |
| `Controllers/CSCloseFriendCallAdapter.m:144` | 单人拒接按账号、caller、room、媒体类型和当前策略验证后调用原生 reject | 没有为独立本地通知任务设置专属过滤状态 |
| `Controllers/CSCloseFriendCallAdapter.m:206` | `CSCFCallOutputSuppressed()` 仅读当前线程的 `CallScope` | 不覆盖其他异步回调；该作用域仅在群通话路径建立 |
| `Controllers/CSCloseFriendNotificationAdapter.m:19` | `shouldDiscardOutput` 只判断 subject 是否属于当前账号 epoch | 当前账号的来电 subject 不会因为应该拒接而丢弃 |
| `Hooks/CloseFriendNotificationHooks.xm:12` | `DiscardOutput` 只组合 subject 过期和上述线程作用域 | 单人后台来电通知能够通过 |
| `Hooks/CloseFriendNotificationHooks.xm:369` | `MMLocalNotificationUtil.showLocalNotificationWithInfo:` 与最终 UN 提交依赖绑定 subject／当前线程作用域 | 仅绑定普通 subject 仍不足以拦住这条来电通知 |
| `HeadersFile/MonoServiceMsgMgr.h:37` | 存在 ilink、普通两参及普通三参本地通知方法 | 当前密友 Hook 未覆盖这些携带真实来电消息的通知入口 |

`bfeebb6c`（2.1-12）明确移除了密友普通消息静音，故当前通用通知 subject 的放行语义是有意保留的行为。修复本问题不能简单恢复“密友所有消息通知全部丢弃”。

## 微信 8.0.80 原生分支

离线目标为本机既有的微信 8.0.80.34 arm64 解密二进制：SHA-256 `e484889f7e32adce054e6b19bef373e2d1c3eb6984bc01176bbd40906373f317`，UUID `7E4A8171-5ACC-3A72-A76A-3ACE52D3D895`。REA 已绑定并核对其身份，分支由相同字节的 Objective-C 元数据、LC_FUNCTION_STARTS 和有界 `llvm-objdump` 核查；未执行微信。REA 的完整 Mach-O 检查超时，未把该检查列为成功证据；会话已关闭。

| 方法／指令 | 静态观察 |
| --- | --- |
| `showLocalNotificationWithMsg:repeatVibration:silently:`，入口 `0x104f89c9c` | 先记录本地通知历史，再检查应用状态 |
| `0x104f89df8`／`0x104f89e0c` | 读取 `applicationState`，Active＝0 时跳去返回路径 |
| `0x104f89e78`／`0x104f89e84` | 非 Active 状态调用 `CAppUtil.GetEnabledNotificationSettingWithCompletionHandler:`；回调入口为 `0x104f89f08` |
| 回调 `0x104f89fb4`／`0x104f89fc8` | 再次复核应用状态，前台返回 |
| 回调 `0x104f8a1c4`／`0x104f8a1c8` | 从保留的原消息调用 `localNotificationInfo` |
| 回调 `0x104f8a2c8`／`0x104f8a2d0` | 调用 `MMLocalNotificationUtil.showLocalNotificationWithInfo:` |
| 回调 `0x104f8a358` | 后续依据设置和参数可能调用 `repeatOutAppVibration` |
| 普通两参通知入口 `0x104f8a424` | 令 `silently = NO`，尾调用上述三参方法 |
| ilink 通知入口 `0x104f8a434` | 根据 VOIP push、CallKit 可用参数和 mode 决定跳过或转普通通知；还有扩展回调分支 |
| `processInviteMsg:`，入口 `0x104f8b1f8` | Handle 返回 YES 后记录历史、移出队列并退出；仅返回 NO 时才分发 Start |

本轮检查的队列处理本体没有调用上述通知方法；通知与 Handle 的确切相对时序仍未知。原生异步回调保留消息对象，说明依赖同步线程作用域无法覆盖完整生命周期。仅在最后 UN 层丢弃通知还可能遗漏后续重复振动。

选定的 ilink 通知方法体没有执行 CallKit 来电上报，但调用的扩展实现没有继续展开；不得据此全局拦截 PushKit／CallKit 入口。

## 行为探针与测试限制

临时主机探针复用了真实的 CallAdapter、NotificationAdapter 和生产 UN 提交 Hook；微信服务及 UN center 使用测试替身。对隐藏密友来电执行拒接，再将相同来电的 subject 绑定通知请求并提交，得到：

```text
handled=1 rejects=1 nativeHangups=1 starts=0
subjectCurrent=1 subjectDiscard=0 callScopeSuppressed=0
notificationSubmissions=1 completions=1
```

这证明即使通知获得精确来电的账号身份，生产输出逻辑仍提交一次；不等于已经在 iPhone 锁屏实测。

`bash Tests/verify-close-friend-alerts.sh` 已执行，但编译失败，测试未运行。`Tests/CloseFriendAlertTests.m` 中的 `CSGroupListAdapter` 替身缺少生产 accessor 使用的 `usesNativeSessionModel`、`tabBadgeSections`、`tabBadgeRevision`、`tabBadgeEpoch`、`tabBadgeAccount`，共 7 个编译错误。探针只在临时副本补齐这些声明，未更改仓库测试。

现有单人来电夹具验证了拒接和 UI 启动次数，没有覆盖后台通知出口或拒接后的异步通知。普通密友消息通知允许提交的现有断言应保留。

## 建议修复范围

1. 在 `MonoServiceMsgMgr` 携带真实消息的本地通知入口复用现有 caller、room、voice/video、账号 epoch 和拒接策略判断。共同三参入口应在排队和重复振动之前过滤应拒接来电；ilink 包装入口需覆盖其独立扩展分支。
2. 将来电专用身份／策略状态传递到延后生成的 `localNotificationInfo` 和实际输出边界，并在那里复核，覆盖通知排队期间锁定、临时显示、移除密友或切换账号等变化。不要只依赖线程字典或通用消息 subject。
3. 保留正常联系人、普通消息、临时显示及对应拒接选项关闭时的原生行为；保留原生取消、通话结束、PushKit／CallKit 必要处理。清理已提交通知时须使用验证过的确切标识，避免扩大删除范围。
4. 补上后台／锁屏语音和视频、通知先后顺序、异步回调、重复／取消／过期、临时显示及重锁、单项拒接开关、账号切换和普通消息继续通知的回归；同步修复既有夹具声明后再运行专项。

本轮交付为排查结论，尚未实施上述修复或打包。手机端是否已经显示远程 APNs 通知、后台实际走哪个通知分支以及最终无横幅／锁屏提示，仍需修复后的设备复验。

## 本机证据归档

完整定向反汇编、提取脚本、目标身份、临时探针源码及校验清单保存在：

`/Users/zhangshichao/Documents/Workspace/WeChatImprove-local-archive/audits/close-friend-background-call-notification-2026-11-12/`

其中 `native-review/target.json` 记录静态目标和方法，`probe/observed-output.txt` 保存本次探针结果，根目录 `sha256.json` 校验归档文件。归档不包含微信二进制或用户聊天／配置数据。
