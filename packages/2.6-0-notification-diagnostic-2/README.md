# 2.6-0+notifydiag.2 通知点击诊断修正

**用户环境更正：当前为 App 内注入后重签／TrollStore 类安装，具体方式、iOS 版本及有效签名权限待核验；此前按 Rootless 设备环境描述未经核实。** 本目录的 Rootless 包及校验记录仅代表历史 Theos 构建方案，不证明用户设备越狱环境，也不证明重签后的主 App／通知扩展权限。本轮不需重新安装或复现同一诊断包。

**本轮取证已完成：微信 `8.0.80.34` 的真机报告确认所点来电提示为远程通知，残留提示尚未修复。** 14 项 Hook capability 均为 YES，保留 13 条事件；`notification.response.remote=1`、`notification.response.local=0`、`response.enter=1`、`response.actions=1`、`delegate.actions=2`。MonoService、Push、local info、local 输出、UN 提交和 VoIP 等已监测主 App 入口计数仍为 0。点击响应约在 `+11.248 s`，回到前台约在 `+11.304 s`。

这份报告确认了所点通知的系统 trigger 类型，**尚未在运行时证实 `WeChatNotificationServiceExtension` 处理了这条通知，也未证明通知被成功抑制。** 标准化证据见 [本机 diag2 报告](../../../WeChatImprove-local-archive/audits/2.6-0-remote-call-notification/user-feedback-diag2.normalized.json)，持续排查状态见 [问题审计记录](../../docs/audits/close-friend-background-call-notification-2026-11-12/README.md)。下文保留本诊断包的原安装、复现和构建记录；当前无需再次安装或复现该包。

用户在微信 8.0.80.34 上复现“你收到了通话邀请”，确认直接点击该通知回到微信。第一份诊断中所有指定 Hook 安装成功，但 MonoService、Push、local info、UN 提交、点击响应均为零；仅记录到前后台生命周期。这不证明通知一定是远程 Push。

定向核查发现上一版诊断漏了真实响应路径：微信的 `NotificationActionsMgr.onServiceInit` 把自身设为 UN 通知代理；场景恢复还可通过主程序 `internalHandleReceiveNotificationResponse:withCompletionHandler:` 处理点击。两者都绕过上一版仅监测的 AppDelegate 标准代理方法。

## 原安装与复现记录

当时提供 [Rootless 构建的诊断包](com.wechat.improve_2.6-0+notifydiag.2_iphoneos-arm64.deb)，要求确认插件显示 `2.6-0+notifydiag.2`。该产物不代表已核实用户的安装环境。下列步骤保留为当时取证记录，当前无需重复：

1. 密友设置 → 右上角“通知诊断”→“开始本轮记录”。
2. 保持原来的密友及拒接设置，将微信置于后台或锁屏，再复现一次密友来电。
3. 出现通知后，直接点击这条通知回到微信。
4. 返回密友设置 →“通知诊断”→“复制报告”，将完整报告发回当前对话。复现期间不要划掉微信。

## 本次变化与边界

- 补上已核验 ABI 的实际微信通知代理和场景内部转发方法，只观察响应，不改变原参数、原 completion 及调用时机。
- 开始记录时读取系统当前通知代理，记录固定分类。对于当前真实运行时类，只观察已存在且完整签名匹配的点击方法；重复检查不重复包装，未实现该方法的代理不会被增加方法，也不会被替换。
- 所点通知通过系统 `UNPushNotificationTrigger` 类型区分远程与本地。静态核查只证明可用路径；后续用户设备报告已确认本轮所点提示为远程类型，结果与限制见顶部。
- 一次点击可能同时经过多个转发入口，计数代表入口命中次数，不代表不同通知条数。
- 默认关闭采集，记录仍仅保存在当前进程内存，最多 64 条相对时间事件。报告不包含通知正文、联系人、账号、payload 或 request 标识。

本版修正诊断盲区，尚未修复或证明消除残留通知。普通消息、现有来电拒接与账号数据不变。通知扩展不能直接加载主插件来读取密友配置：现有存储和密钥只供主程序使用，并且锁屏读取受保护；本轮没有修改注入范围、跨进程共享配置或文件保护级别。

## 定向验证

- `bash Tests/verify-close-friend-call-response.sh`：31 项生产代码契约检查通过。旧入口无法观察 Actions 回调，新入口可识别远程／本地；原参数、原 completion 及调用次数不变，重复检查和继承不重复包装，缺失 optional 方法不会被添加，关闭记录时仍正常透传。
- `bash Tests/verify-close-friend-call-diagnostics.sh`：100 项诊断检查通过，覆盖默认关闭、固定白名单、事件上限、停止后导出及账号边界。
- 本轮仅针对新增观察路径验证，没有重复执行原来的 alert／badge 全套回归。
- Rootless 包编译完成，包含 arm64／arm64e 两个切片；版本、最低 iOS 15.0、安装路径、RPATH、原注入过滤及新增导出函数均已解包核验。447 个生产输入在构建前后哈希一致。
- [调试符号](symbols-rootless.zip) 的两个 UUID 与包内切片匹配，ZIP 完整性校验通过；[SHA-256 清单](SHA256SUMS) 已验证。

定向原生证据及第一份用户反馈保存在本机 `WeChatImprove-local-archive/audits/2.6-0-notification-diagnostic-2/`。
