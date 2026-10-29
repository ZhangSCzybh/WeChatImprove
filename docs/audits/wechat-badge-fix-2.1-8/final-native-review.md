# 2.1-8 微信 tab 原生输出与恢复边界复核

本文件记录 tab 输出侧的专项复核；构建、包校验、完整回归和设备验收以本目录主报告为准。本次没有修改微信实际未读、通知静音、免打扰、app icon、UN/local notification 输出，也没有新增或复制 badge 对象。host 测试仅模拟可观察的原生 setter 行为，不能作为真机视图层级、深浅色或几何遮挡的证据。

## 原生行为证据

- 8.0.78 的 `MMTabBarController.setTabBarBadgeString:forIndex:` 在 `0x104726638` 对 nil/空字符串进入 `0x104726690–0x1047266a0`，调用 item 的 `setBadgeViewHidden:YES`。此分支不是调用 item 的字符串 setter 清内容，因此只能声称安全隐藏，不能声称已清掉 item 缓存的 unreadCount/badgeString。证据：[原生反汇编](../tabbar-badge-2026-10-28/native/MMTabBarController--setTabBarBadgeString_forIndex_.asm)。
- `MMTabBarItemView.showSmallRedDot` 的 `0x10472775c–0x104727780` 会清除 item 的数字和字符串，再建立原生点显示。因此输出必须采用数字优先、纯点其次；不能在正数字之后再调用 show-dot。证据：[原生反汇编](../tabbar-badge-2026-10-28/native/MMTabBarItemView--showSmallRedDot.asm)。
- 数字 setter 的真正零值会隐藏；来源未知不能借此伪造零。remove-small-dot 仅移除点，不能作为清除任意数字/文字内容的统一入口。证据：[数字 setter](../tabbar-badge-2026-10-28/native/MMTabBarItemView--setTabBarBadgeValue_.asm)、[removeSmallRedDot](../tabbar-badge-2026-10-28/native/MMTabBarItemView--removeSmallRedDot.asm)。
- `MainFrameLogicController.getTotalUnreadCount` 的返回 ABI 是 unsigned int `I@:`；主动读取前按完整签名检查。`NewMainFrameViewController.updateUnReadCount` 内部把输出指向全局 tab 0，故恢复不能直接调用它，必须读取真实 root 的 logic、写真实 owner/index。证据：[logic getter](../tabbar-wechat-badge-2.1-6-2026-10-29/native/MainFrameLogicController--getTotalUnreadCount.asm)、[原生更新](../tabbar-wechat-badge-2.1-6-2026-10-29/native/NewMainFrameViewController--updateUnReadCount.asm)。
- 普通会话的原生 dot/count 分支已在 [语义复核](semantic-audit.md) 列出。`m_bShowUnReadAsRedDot` 表达原生展示方式；本轮没有把它直接等同免打扰，也没有新增一套 DND 规则。

## 输出路径与标记

生产改动集中在 `Hooks/CloseFriendNotificationHooks.xm` 的 `Chat tab badge output` 代码块及三个自然 tab setter 的前后处理。三个 orig 调用仍原样接收调用者的 count、string、index；非微信 tab 继续直接走原生。`ChatTab` 仍由实际 viewControllers/root class 确定位置，既不固定 tab 0，也不限制只处理前四个 tab。

`CSChatTabBadgeDisplay` 把两种权限分开：

| 字段 | 含义 | 不授予的权限 |
| --- | --- | --- |
| `token` | 由 Known 结果建立、某账号/epoch/policy revision 下可安全延续的显示凭据；还须同 root/item/badge | Pending 的隐藏动作本身不建立 Known 凭据；不能跨账号、epoch、policy 或实际目标复用 |
| `needsNativeRestore` | 插件实际写过此目标，仍需交还原生 | 本身不允许 Pending 延续旧显示，也不允许跨边界复用旧 total |

主动 native 恢复先检查同目标的待恢复标记；没有标记的空名单刷新不读取 total、不调用 setter。原生自然输入的 capture 也先检查此标记，因此冷空名单的自然 number/string/dot 不会为补强处理计算 publication projection 或填充 tabAlertBadge 缓存。

从插件过滤切回原生后，存在两条完成恢复的路径：主动发布成功后清标记；微信自身成功写入自然 number/string/dot、且前后账号/epoch/policy/目标仍有效时也清标记。后续 source 事件因而不会用一次主动 total 覆盖微信刚写的任意原生字符串或红点。清标记还须确认记录对象未被同步重入替换，避免旧调用删掉新策略建立的记录。

边界失效先撤销安全 token，再通过原生 nil-string 隐藏当前真实目标；隐藏成功仍保留待恢复标记。原生 total 读取前捕获 publication decision 和实际 root/item/badge，读取后及写入后重新核对账号、epoch、policy、实际账号与目标。若变化后新策略仍为 nil/native，旧 count 也不能只凭“现在是 nil”直接通过。发生失效后安全隐藏，并复用既有 publication 重入标记安排当前状态补发。

无可信纯点来源且 native total 为零时保留恢复机会，等可靠 source 刷新后决定 dot 或真正的零。跨边界撤销 token 后，即便同一个旧 logic 还返回正数，也须有经过当前账号/epoch 校验的来源才能恢复；不能仅用旧 logic 的正数替代账号归属证据。

## 同步重入与循环

已复核并由 host 故意放大两条原生顺序：原生 setter 先同步回调 policy/source observer，最后才落 UI。只在调用前检查不足以处理此顺序。

1. 插件 Known/Pending 输出返回后复核；若边界或目标已变化，通过原生 nil-string 撤销迟到写入，然后发布新状态。
2. `ApplyingChatTabBadges` 使自然 hook 内的插件 apply 期间发生的 source/policy 发布先记为待处理，避免内层新结果先落地、外层旧结果最后覆盖。
3. `PublishingChatTabBadges` 防止 publisher 递归；嵌套请求设置 `ChatTabBadgesPublishAgain`，由当前循环补发。稳定 Known、稳定 boundary、稳定 source Pending 本身不会无条件设置补发位。
4. 私有原生写入旁路只匹配同 owner/index/selector，且在进入原 IMP 前消费一次；同 selector 的内部再入不得继续旁路过滤。`@finally` 恢复旁路上下文，异常不会把旁路留给后续事件。
5. 自然 nil 输出结束后也复查新决策。如果原 IMP 内同步进入隐藏/blocked，新决策在最后落 UI 后重新应用，防止原始自然参数覆盖刚才的隐藏结果。

本轮没有固定延时、dispatch_sync(main)、每帧叠加位移或额外异步 UI 调度。主线程检查覆盖 publisher、apply 和自然补强；跨线程政策/epoch 变化通过调用前后的 token/current-account 验证处理。

## 实际目标替换的边界

恢复凭据绑定 root、item、badge 三个对象。若外部无任何 policy/source 或自然输出事件便替换这些对象，旧标记不会主动接管新目标。新目标等待自己的下一次原生更新；若当时需要过滤，自然 hook 建立其自己的安全显示/恢复记录。不能把 host 中替换对象的人工操作声称为微信真实生命周期行为。

当替换发生在正在读取 total 或正在写 UI 的过程中，前后校验会拒绝旧结果，安全隐藏当前真实目标并记录其恢复需求。若新策略为 Pending，则等待可靠刷新；若为当前 Known，则重新应用当前决策。

## 隔离检查与测试记录

机器检查记录在 [final-native-review-checks.json](final-native-review-checks.json)。以本目录保存的实施前工作区为基线，以下片段逐字相等：旧 `closeFriendAlertBadgeCount`、`ChatTab`、三个 tab hook 之前的非 tab ctor、policy observer 中 UN pending/delivered/app icon 前缀。旧 getter 的独立 SHA-256 为 `18af0cb05d34aecde81d291157f1b792daeecd17ca1989bfdfe8d0f6ff52e618`。

正式 host 脚本为 `Tests/verify-close-friend-alerts.sh`，直接抽取生产 decision/getter、projection、marker helpers、三个 hook block 与真实 source emitter/observer；输出保存在 [formal-alerts-latest.log](formal-alerts-latest.log)。替身的 string-nil 只隐藏不清 count/string，numeric/dot 的同步回调发生在最终 UI 写入之前，避免用过强替身掩盖原生顺序问题。

最终结果为 **216 项既有 alerts + 782 项 tab 检查通过，exit 0，stderr 为空**。冻结前新增的 `pending-new-epoch-does-not-mint-known-restore-token` 用例先在候选实现失败：新 epoch 的 Pending 隐藏被赋予 token，随后空名单可错误放行旧 logic 的 123。候选源码与失败输出保存在 [red/pending-token-candidate/](red/pending-token-candidate/)。最终仅将记忆参数改为 `decision.badge ? token : nil`，该用例及新 epoch 可靠 source 到达后的恢复均通过；已有 Known 同 token 的 Pending 延续行为仍保留。此处是候选实现的红绿记录，不冒称 2.1-6 的原始缺陷。

覆盖包括任意原生输入透传、第五 tab 与实际微信 tab index、数字优先/纯点/真正零、同 token Pending 延续、策略/epoch/实际账号/root/item/badge 失效、空名单从未接管不读不写、恢复一次后释放、自然输入成功后释放、native 零+来源 Pending 等待 dot、native read/write 前后切账号、旧 logic 正数跨 epoch、旁路作用域/一次消费/异常恢复、同步 observer 先于原 IMP 最后 UI 写入。

此专项报告不把 host 计数检查等同真机通过；真实 DND 映射、前后台、真实账号切换、系统角标形状与颜色、真实视图 z 序仍应按主报告的设备步骤验收。

## 最终复核文件指纹

| 文件 | SHA-256 |
| --- | --- |
| `Hooks/CloseFriendNotificationHooks.xm` | `d730ea7bfbc16326691a5eb69cc95c74e6f828dab41eb0baa18d8dfe80d56818` |
| `Controllers/CSGroupListAdapter.h` | `71f845953bbf16c1d1732f042a3064b22596472a1503c5adb73a6c2e570d60ec` |
| `Controllers/CSGroupListAdapter.m` | `e5e41ede849a82197144715c0767d98a4b153ff4aadb07c2e7288e9d9ee72599` |
| `Tests/CloseFriendTabBadgeTests.m` | `de45cee80070d2d5776b3dc065f77427f9e4179fa8ac277609aec1fcfc09ea43` |
| `Tests/verify-close-friend-alerts.sh` | `8e01df0c859cf58e28e2d9fe2fc27a95a3f3b76667bea961acb24e95b92a55f0` |

上述为最后一行 Pending-token 修正和 782 项检查后的复核结果。第一轮构建如发生在修正之前，只能作为中间验证，不能作为本候选的最终包证据；最终构建由主任务重新冻结源码后完成。
