# 2.6-0 密友后台／锁屏来电通知修复

**真机反馈：用户安装后确认仍有后台／锁屏通知，文案为“你收到了通话邀请”，点击进入微信首页。本版未解决用户实际问题。** 后续使用 [通知诊断版](../2.6-0-notification-diagnostic/README.md) 确认实际通知来源；下文构建与主机测试仅对应原验证范围。

本版基于当前正式 `2.5-11`（提交 `00634e43`），修复密友来电已自动拒接，但微信后台／锁屏仍出现本地来电通知的问题。包版本、插件内显示版本和离线更新说明均为 `2.6-0`。

## 安装包

此目录保留当时构建的 [Rootless 安装包](com.wechat.improve_2.6-0_iphoneos-arm64.deb)、[Rootful 安装包](com.wechat.improve_2.6-0_iphoneos-arm.deb)、[Rootful 重签用 dylib](WeChatImprove.dylib)、[两种方案的调试符号](symbols.zip) 和 [SHA-256 校验清单](SHA256SUMS)。用户后续确认使用 App 内注入后重签／TrollStore 类安装；此前未核实就认定用户是 Rootless 越狱环境，该判断已纠正。构建方案不代表设备实际注入环境。

两种方案都包含 `arm64`／`arm64e`，最低目标 iOS 15.0。历史安装包保留。

## 本次变化

- 隐藏密友且对应语音／视频拒接选项开启时，在微信原生本地来电通知入口提前阻止通知任务，避免横幅、锁屏提示及该通知流程的重复振动；原有自动拒接和挂断回复继续执行。
- 已进入系统通知设置查询的来电，通过回调携带原始通话身份；执行前复核账号、密友和媒体拒接选项、邀请有效性及消息身份。已提交拒接的同一通话即使随后临时解锁，也不重新显示旧来电通知。
- 普通消息、正常联系人来电、临时显示及对应拒接选项关闭时沿用原生行为。作用域外的系统通知设置查询保留原回调，未恢复已移除的密友普通消息静音。

修复限于 `CSCloseFriendCallAdapter.h/.m` 与 `CloseFriendCallHooks.xm`。三个 `MonoServiceMsgMgr` 通知入口及 `CAppUtil` 通知设置 completion 均校验完整 ABI；原生线程调度保留，嵌套与异常路径恢复原作用域。不增加轮询、后台保活、持久设置或数据库迁移。

## 核心回归

按本次问题范围执行以下检查，没有重跑全仓测试。

| 检查 | 结果 |
| --- | --- |
| `bash Tests/verify-close-friend-alerts.sh` | 348 项通过，包含新增的 100 项来电通知集成检查及原有拒接、挂断回复、身份和支付策略检查 |
| 同一脚本附带的原有角标检查 | 902 项通过 |
| `bash Tests/verify-close-friend-ios.sh --alerts` | 通知、通话、挂断回复及关联 Hook 的 arm64／arm64e 严格源对象编译通过 |
| `git diff --check` | 通过 |

新增检查执行真实生产 Hook 安装块、来电 Adapter、通知设置回调包装和 UN 提交 Hook。覆盖三入口、两种媒体和两种传输的通知／振动为零，正常原参数透传，排队后重锁／新增密友／开启拒接／切换账号，已拒接后再解锁，消息取消或对象复用，仍有效的异步放行，以及嵌套和异常恢复。原有测试替身缺失的属性已同步补齐。

## 构建与产物核验

使用现有 Theos 与 iPhoneOS 27.2 SDK，`DEBUG=0`、`FINALPACKAGE=1`，分别完成 Rootless／Rootful 编译打包。缓存和 staging 分别写入本轮独立构建目录，没有执行项目的 `make clean`。

两包均已解包核验：版本 `2.6-0`，Debian 架构、注入 plist、安装路径和双架构切片正确，两个切片最低 iOS 均为 15.0；Rootless 的 `/var/jb` RPATH 正确，Rootful 不含该 RPATH。两包均包含新增通知入口／回调函数符号，四个 dSYM UUID 与包内切片匹配，符号 ZIP 的 CRC 校验通过。构建前记录的 444 个生产输入 SHA-256 在构建后逐一核对一致。

构建日志、生产输入清单、核心验证记录、源码 diff 和逐包核验 JSON 保存在本机：

`/Users/zhangshichao/Documents/Workspace/WeChatImprove-local-archive/audits/2.6-0-close-friend-call-notifications/`

## 验证范围

源码与指定微信 8.0.80.34 二进制的通知路径核查见 [前序排查记录](../../docs/audits/close-friend-background-call-notification-2026-11-12/README.md)。主机回归使用微信服务及通知中心替身，不表示已在手机安装或观察到锁屏通知送达。本版已完成本地编译交付；真实 Rootless 微信后台／锁屏无来电提示仍需安装后复验。系统 CallKit 首帧及进程终止后的远程 APNs 通知不在本次已验证范围。

本轮没有连接或重启手机微信，没有修改用户账号、密友配置、聊天记录或数据库。
