# 1.9-4 密友解锁期间通话修复

在现有主检出 `/Users/zhangshichao/Documents/Workspace/WeChatImprove` 的 `main` 上修复并构建 Rootless 安装包。基础提交为 `b56895f2`；本次没有安装到真机。

## 原因与改动

`CSCloseFriendSnapshot.rejectsCaller:chatRoom:video:` 原来只检查功能开关、来电类型和密友名单，没有检查临时解锁状态，因此解锁后仍会提交拒接。

`CSCloseFriendCallToken.suppressesPresentation` 同时使用消息静默策略。单独停用拒接会继续吞掉来电处理，无法恢复接听界面。本次为这两个决策增加解锁状态判断，使解锁期间的单人语音、视频、邀请界面和群通话走微信原生来电流程，消息通知继续按静默开关处理。再次锁定后原拒接开关恢复生效。

主动拨号使用既有资料页原生入口；它们已依据当前隐藏状态放行。本次补测 `onOpenVoiceVoipView`、`onOpenVoipView`、`onOpenVoipActionSheet:` 和原生通话按钮可见性，确认解锁时进入原方法、重新锁定时恢复保护、已失效的资料对象不能借用新的授权。聊天通话没有额外新增拦截。

挂断回复继续使用当前拒接策略核验，因此解锁期间不新增回复，等待中的发送或失败重试在下一次执行时停止。已提交给微信的消息不撤回。设置页说明及 README 已同步为新行为。

## 核心验证

新增用例先在修复前代码运行，分别复现解锁后仍拒接、解锁后仍抑制来电展示，见 `core-before.log` 和 `alerts-before.log`。资料页测试脚手架缺少现有刷新调度函数的替身，补齐同步回调后验证真实资料页 Hook；页面可见性调度本身未修改。

| 验证 | 结果 |
| --- | --- |
| `Tests/verify-close-friend-core.sh` | 215 项通过 |
| `Tests/verify-close-friend-alerts.sh` | 216 项通过 |
| `Tests/verify-close-friend-profile.sh` | 22 项通过 |
| Rootless 完整构建 | arm64、arm64e 均成功 |
| 包与符号校验 | deb、暂存及构建 dylib 一致；两个架构的 dSYM UUID 匹配 |

核心路径覆盖锁定、解锁、重新锁定；ilink 与旧单聊的语音和视频；邀请浮窗与群通话；主动拨号入口；普通联系人；过期账号回调；挂断回复和重试。完成上述验证后未扩展无关回归。

构建使用独立临时输出目录，未执行 `make clean`。起始记录中的 16 个已有包、符号及修改过的 `.theos` 文件哈希均保留。详细命令、输出和交付哈希见 `build-result.json`、`validation.json` 及各测试日志。

## 交付与真机验收

- [1.9-4 Rootless 安装包](../../../packages/com.wechat.improve_1.9-4_iphoneos-arm64.deb)
- [匹配的 dSYM](../../../packages/WeChatImprove-1.9-4-dSYMs.zip)

安装后，在解锁期间分别接听密友语音、视频来电，并从聊天及资料页主动发起通话；随后重新锁定，确认新来电按原拒接开关处理。上述主机回归不等同于真机接通验证。
