# 2.1-11：移除密友消息静默

日期：2026-10-29。按用户确认的五项范围，在现有工作目录继续修改，保留目录中已有的角标、未读聊天面板及其他未提交改动。

## 行为变化

移除“静默消息通知”设置项、图标、默认值和静默策略接口。密友、密群和普通群中可识别密友发送者的消息不再因为密友身份被插件静默，消息展示、声音和震动交由微信及 iOS 设置决定。

公开角标仅在会话隐藏策略生效时排除受保护会话。锁定且开启“隐藏聊天会话”时仍过滤；临时解锁、关闭会话隐藏、停用保护或清空名单后使用原生角标。保留已有来源刷新、离屏维护、红点、原生恢复和账号边界处理。

来电展示仅由现有拒接策略决定。锁定但对应拒接选项关闭时，单聊语音／视频及已适配群通话恢复原生流程；临时解锁仍恢复原生来电。群通话无法确定媒体种类时，继续沿用语音和视频拒接都开启才拒接的规则。

## 兼容与保留范围

- `CSCloseFriendNormalizeProfile` 接受历史 `silenceMessages` 布尔值，校验后忽略；错误类型继续拒绝，不扩大其他未知键的允许范围。
- 不清空、替换或重建账号状态文件。读取历史密文不改写文件；用户正常保存设置后，写出的配置不再包含退役字段。保留名单、总开关、其他保护选项、密码验证信息和遗留 `muteRecords`。
- 保留整个通知 Hook 与 Adapter。`shouldDiscardOutput` 仅拒绝失效账号／代次的输出，`DiscardOutput` 另外保留拒接来电上下文的输出保护。
- 保留 `CSCFPaymentOutputAllowed`；红包／收款执行与账本继续运行，含受保护来源身份的摘要和回复仍受原有隐私规则约束。
- 保留会话、通讯录、搜索、资料、朋友圈、未读聊天面板等隐藏策略及临时授权。未读面板跟随会话隐藏，不依赖退役选项。
- 不修改微信原生免打扰设置、好友关系、消息记录或真实未读。

## 主要代码

| 文件 | 调整 |
| --- | --- |
| `Controllers/CSCloseFriendSettingsViewController.m` | 移除设置项、图标及旧说明 |
| `Controllers/CSCloseFriendPolicy.h/.m` | 移除静默默认值与判断，兼容历史布尔键 |
| `Controllers/CSCloseFriendBridge.h/.m` | 移除退役静默查询接口 |
| `Controllers/CSCloseFriendNotificationAdapter.h/.m` | 保留身份／账号有效性及支付接口，移除静默判断 |
| `Controllers/CSCloseFriendCallAdapter.m` | 来电展示仅使用拒接判断 |
| `Controllers/CSGroupListAdapter.m` | 三处公开角标过滤仅使用会话隐藏策略 |
| `Hooks/CloseFriendNotificationHooks.xm` | 输出判断更名，保留通知、来电和角标保护 |
| `Headers/CSUserInfoHelper.h`、`control`、`Controllers/CSReleaseNotesViewController.m` | 同步版本为 `2.1-11` 和更新说明 |

## 主机验证

以下检查均使用临时目录或替身对象，不访问设备上的微信账号、Keychain 或消息数据库。

| 命令 | 本次结果 |
| --- | --- |
| `bash Tests/verify-close-friend-core.sh` | 455 checks passed |
| `bash Tests/verify-close-friend-runtime.sh` | Runtime 109、Scheduling 9、Biometric 99 checks passed |
| `bash Tests/verify-close-friend-alerts.sh` | Alerts 248、Tab badge 902 checks passed |
| `bash Tests/verify-group-lifecycle.sh` | 142 checks，0 failures |
| `bash Tests/verify-close-friend-unread-panel.sh` | Panel 71、ABI 7 checks，0 failures |
| `bash Tests/verify-close-friend-session.sh` | Sessions 148、Presentation 44 checks，0 failures |
| `bash Tests/verify-group-badges.sh` | 136 checks，0 failures |
| `bash Tests/verify-payment-core.sh --privacy` | 6 checks passed |
| `bash Tests/verify-close-friend-entry.sh` | State 45、Gesture 26 checks passed |
| `bash Tests/verify-close-friend-ios.sh` | 完整密友模块及相关 Hook 的 arm64、arm64e 对象编译通过 |
| `git diff --check` | 通过 |

共 2,447 项主机行为检查通过。新增／调整覆盖历史选项真假值加载、密文读取与保存、密码继续有效、当前消息正常通知、旧账号输出丢弃、拒接关闭时来电原生处理、会话隐藏下的角标过滤、解锁后原生恢复及支付隐私。

## 隔离构建与产物

使用本目录 `build-packages.py` 在全新临时 Theos 目录构建 Rootless 和 Rootful，输出到 `packages/2.1-11-no-message-silence/`。不运行 `make clean`，不覆盖现有 `.theos` 或历史安装包。构建命令、源文件哈希和结果保存于本目录。

`verify-packages.py` 核对安装包版本／架构、动态库 arm64 与 arm64e、最低 iOS 15.0、注入过滤、保留接口、退役接口移除及 dSYM UUID，生成调试符号归档和 SHA-256。最终结果见 `build-result.json` 与 `package-verification.json`。

本次 Rootless 和 Rootful 完整构建均退出 0；源码输入哈希前后一致。既有 `.theos` 和历史 `packages` 共 1,272 个文件无缺失、无哈希变化。两包的版本、双架构、安装路径、过滤 plist、stage／包内动态库哈希和全部 dSYM UUID 校验通过；支付、未读面板及来电接口保留，退役静默 bridge 符号消失，符号归档 CRC 通过。每个方案均有 6 条既有弃用／链接器警告，涉及 `UILocalNotification`、`statusBarFrame` 和 `-multiply_defined`，详情保存在构建日志中。

- [Rootless 安装包](../../../packages/2.1-11-no-message-silence/com.wechat.improve_2.1-11_iphoneos-arm64.deb)
- [Rootful 安装包](../../../packages/2.1-11-no-message-silence/com.wechat.improve_2.1-11_iphoneos-arm.deb)
- [调试符号](../../../packages/2.1-11-no-message-silence/com.wechat.improve_2.1-11_symbols.zip)
- [SHA-256](../../../packages/2.1-11-no-message-silence/SHA256SUMS)

## 真机验收

尚未安装到设备；主机替身和编译不能代替以下验证。

1. 从有旧密友配置的版本升级，确认原密码、名单及其他选项保留，设置页已无静默开关。
2. 按微信／iOS 通知设置，分别收到密友私聊、密群和普通群内密友消息，验证横幅、声音及震动；原生免打扰开启时遵守微信设置。
3. 锁定且隐藏会话时，桌面／底栏角标继续排除受保护会话；临时解锁或关闭会话隐藏后恢复原生计数，真实未读不变。
4. 分别打开／关闭语音、视频拒接，验证对应单聊与群通话；临时解锁期间可以正常接听，挂断回复仍按原开关工作。
5. 切换账号及后台返回，检查过期回调不会显示前一账号内容；未读聊天面板仍按锁定状态隐藏／恢复。

本次没有安装设备、发送微信消息、重启共享服务、修改真实数据库或提交／推送 Git。
