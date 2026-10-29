# 正式 Host 回归与证据边界

执行 `bash Tests/verify-close-friend-alerts.sh`，旧 alerts 二进制通过 216 项，新 tab badge 二进制通过 782 项，退出码 0、stderr 为空。完整结果在 `logs/verify-close-friend-alerts.sh.log`，输入哈希与编译参数在 `formal-test-result.json`。

旧 `Tests/CloseFriendAlertTests.m` 与本轮 baseline 字节完全一致；旧 `verify-close-friend-alerts.sh` 保留为当前脚本的完整前缀。本轮只追加 tab 专用回归，没有删除或弱化既有 alerts 用例。新二进制使用 `-fobjc-arc -fblocks -Wall -Wextra -Werror`，未添加警告抑制。

## 实际执行的生产代码

- 直接编译 `CSCloseFriendPolicy.m`、`CSCloseFriendSignatures.m`、`CSGroupProjection.m`、`WESessionTabItem.m`。
- 从当前 `CSGroupListAdapter.h/.m` 提取真实 decision 接口、factory 与两个 getter，保持方法体不变。
- 从当前 `CloseFriendNotificationHooks.xm` 提取真实 `ChatTab`、整段 output helper、三个 numeric/string/dot hook block。hook block 通过真实 Objective-C method swizzling 安装到 host 的对应 ABI 方法，再由测试调用原入口。
- 从当前 adapter 提取真实 source 完成分支的 `if` 条件与 notification post，包在 host 方法中；notification observer 同样提取生产注册代码。因此实际覆盖 emitter 条件 → notification → observer → publisher → swizzled hook → 原 IMP 可观察副作用。

## 覆盖的行为

| 分组 | 主要断言 |
| --- | --- |
| 自然透传 | 已确认空名单在 enabled/revealed 四组合下，数字 0/1/10/99/100/ULLONG_MAX、nil/空/数字/99+/任意原生字符串、纯点均原参数透传；从未接管的目标不因 source 事件读取总数、写 badge 或填充 tab cache |
| 隐藏与显示 | 隐藏 protected3、ordinary7 → 原生10输出7；好友与群分别覆盖；显示后即使 silenceMessages=YES 也透传原生；hideSessions=NO/功能关闭返回 nil |
| 数字与红点 | 受控 rows 的 show-as-dot 贡献不重复扣减；ordinary 纯点保留；真实零才输出 numeric0；原生纯点清 count/string 的副作用建模并断言 |
| Pending | 缺 cache、dirty、changeDepth、revision/epoch 不匹配、无 owner，且 safe stamp 未变时保留先前7；策略/账号/epoch/root/item/badge/无 stamp 边界通过 string nil 隐藏，未伪造 numeric0 |
| 发布恢复 | 可靠 source 变9后立即发布，不等待下一条消息；finished/dirty/depth/folded/epoch 事件门槛；原生 getTotalUnreadCount 的 `I@:` ABI 检查；native0 的可靠点/真实零回退 |
| 接管债务 | 已接管 → nil 主动恢复仅一次；自然 numeric/string/dot 成功后清旧债；后续 source 事件不覆盖原生任意文本/点；不可靠0保留后续可靠恢复机会 |
| 重入与账号 | 原生 IMP 在最后 UI 写前重入策略/blocked/source；读 native123 中切换 epoch/account 且新 source 仍旧时最终隐藏、不发布123；Pending 不能建立 Known token；新 source ready/native5后才恢复5 |
| Bypass | 原生调用豁免仅限当前 owner/index/selector、只消费一次；原 IMP 抛异常后仍归还状态 |
| 非微信 tab | chat 根位于 index2 的五 tab fixture；其余 index0/1/3/4 原样透传；root 尚未建好或类型不符时透传 |

## 明确未作为本测试证明的事项

Host 中 controller、item、badge 都是 Foundation 替身；`fixtureFrame` 仅用来证明这段 tab 输出代码没有改 frame/替换 badge 对象，不能证明 iOS 上的层级、裁剪、z 序、渲染形状、主题或动画。`showSmallRedDot` 清 item count/string 的外部结果存储在 fixture badge 字段，不能把该字段存储位置当作真机结构。

source emitter 的完成条件由 host 传入，本二进制没有运行完整 adapter refresh 生命周期、原生消息回调或真实微信免打扰读取。rows 的 raw show-as-dot 是受控输入，不能据此声称免打扰设置或真实消息推送已验收。完整 adapter 生命周期由单独的 group lifecycle 回归负责；实际微信显示效果与消息/前后台/账号切换仍需报告中的真机步骤验收。

## 先红后绿

`red/` 保留修改前 2.1-6 精确生产 getter/ChatTab/numeric hook block 的冻结输入与 SHA 校验、编译日志和实际失败事件：revealed 原生10被替换成7；dirty 未知状态被替换成 numeric0 并隐藏。它证明旧代码会覆盖原生输出，但不把初期 prototype 的无 safe stamp hold 假设当作最终契约；正式契约为同可信 stamp 可 hold，缺 stamp/跨边界使用原生 string nil 隐藏。

开发期间另有 `formal-reentry-check.log` 记录原 IMP 在最终 UI 写前重入导致旧输出覆盖内层隐藏的失败；最终正式脚本包含该重入与同 token source7→5 回归并已通过。

`red/pending-token-candidate/` 另保留本轮 2.1-8 候选版的独立回归失败（不是历史 2.1-6 证据）：旧 epoch Ready7 → epoch 推进/source 仍旧 → 自然 Pending 隐藏 → 新策略 empty/source 仍旧/原生旧总数123 → publisher 错误恢复123。正式新增用例先失败于 `Badge(o).hidden`；修正为仅 Ready decision 记录 Known token 后同用例通过，并继续验证可靠新 source/native5 立即恢复。该目录包括失败时冻结的5项源码输入、SHA256 与日志，最终绿输入记录于主 manifest。
