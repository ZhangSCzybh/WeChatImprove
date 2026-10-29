# 2.1-8 前置只读核对：分组、隐藏/揭示与免打扰角标语义

本报告核对实施前 2.1-6 的既有口径。检查时下列生产文件及测试文件均与 `docs/audits/authorization-cleanup-2026-10-28/source-sha256-after.json` 一致。本次只读取源码、既存测试及已保存的 8.0.78 静态证据；未修改生产文件、正式测试或用户配置，未运行构建、测试或设备采样。

结论：**分组展示已遵循“实际隐藏才扣除，揭示后加回”的规则，`silenceMessages` 不会让已揭示分组继续扣除。旧 app/微信 tab 角标 getter 则在 silenceMessages 开启时仍排除已揭示的保护名单，与本轮目标有明确冲突。** 原生免打扰是否总映射为 dot 不能仅靠字段名断言；目前没有证据证明“DND 且 dot=NO 时原生 total 不计、分组投影却计”的实际冲突。复用原生表现标记有源码、测试及 8.0.78 原生计数分支依据，DND 的真实映射仍需设备验收。

## 1. 行快照保留的原生事实

`Controllers/CSGroupNativeBridge.m:384–406,443–463` 在主列表和折叠列表都读取相同字段：

```objc
unreadCount = MAX(0, CSGroupReadInteger(session, @"m_uUnReadCount", 0));
redDot = CSGroupReadInteger(session, @"m_bShowUnReadAsRedDot", 0) != 0;
```

得到的是不可变 `CSGroupRow`。复用比较同时检查 unreadCount 和 redDot，字段任一变化均可使行快照变化。桥接层不修改微信未读计数，不写免打扰，不把 `silenceMessages` 改写成 row.redDot，也不单独读取一个 mute/DND 位来决定投影数字。

`m_bShowUnReadAsRedDot` 表达原生未读的展示方式，不能单独证明当前有未读，也不能被直接命名为“免打扰标记”。[docs/session-groups.md:104](../../session-groups.md) 与 [2.0-10 既存审计](../group-badge-clear-2.0-10/README.md) 已明确保留这一边界。

## 2. 投影数字和红点的既有规则

`Controllers/CSGroupProjection.m:68–77`：

```objc
static NSUInteger CSGroupNumericUnread(CSGroupRow *row) {
    if (row.redDot || row.kind == CSGroupRowKindAggregate
                   || row.kind == CSGroupRowKindBusiness) return 0;
    return row.unreadCount;
}
static BOOL CSGroupDotUnread(CSGroupRow *row) {
    return row.unreadCount > 0 && row.redDot;
}
```

隐藏过滤在 `CSGroupProjection.m:275–276` 先于任何成员归属和计数执行：hiddenUserNames 中的行直接跳过。因此它既不贡献数字，也不贡献红点，不会通过“全部”、预设或自定义组重复漏入。

对保留下来的普通会话，数字按上述函数饱和累加；红点按 OR 合并（`300–321,336–339`）。最终 `CSGroupBadge` 可以同时具有正数字与 redDot=YES；顶部分组按钮在数字大于零时优先显示数字，数字为零且 redDot=YES 时显示点，`0/NO` 才隐藏（`WESessionTabContainerView.m:204–214`）。这两个分量不能压缩成“只看 count”。

| 可见普通会话的原生字段 | 对所在分组的数字贡献 | 红点贡献 |
| --- | ---: | --- |
| count=9、dot=NO | 9 | NO |
| count=9、dot=YES | 0 | YES |
| count=0、dot=YES | 0 | NO |
| count=0、dot=NO | 0 | NO |
| 行被实际隐藏 | 0 | NO |

aggregate/business 不累加未知覆盖范围的数字，也不根据残留 count 自行制造红点。折叠聚合入口另有既有的子投影、成员与隐私归属规则，不能将父入口 count 再与子会话数字重复相加。揭示意味着恢复符合原生表现和分组归属的贡献，不意味着所有原生 raw count 都改为数字。

## 3. 分组隐藏/揭示不依赖 silenceMessages

`Controllers/CSGroupListAdapter.m:639–670` 的 `projectionForSections:...` 只依据：

```objc
for (NSString *name in policy.protectedUserNames)
    if ([policy hidesUserName:name surface:CSCloseFriendSurfaceSession])
        [hidden addObject:name];
```

它不读取 `silenceMessages`。`CSCloseFriendPolicy.m:59–67` 的 `concealsSurface:` 在 `!enabled || revealed || !protectedUserNames.count` 时返回 NO；`hidesUserName:` 继而返回 NO。因此已揭示且非 blocked 时，保护名单不会进入上述 hidden 集合，分组重新计入它们符合原生表现的数字或点。

`CSGroupPrivacyActive()`（`CSGroupListAdapter.m:17–20`）同样不读取 silenceMessages，而是 blocked 或 enabled + !revealed + hideSessions。`refresh` 的角标发布（`583–589`）进一步区分：

- “全部”且 !privacy：数字优先读取原生 `getTotalUnreadCount`，失败 fallback 到投影 count。
- 其他分组，或隐私过滤期间的“全部”：数字采用投影 count。
- 所有分组的红点分量均采用投影 redDot；既有 hide_all_badge/hide_group_badge 开关同时屏蔽数字与点。

由此可确认：revealed + silenceMessages=YES 不会让分组继续以保护名单扣数；如果 hideSessions=NO，即使尚未 revealed，也不会仅因 silenceMessages=YES 隐藏分组会话或扣其计数。blocked、账号/epoch/政策修订失效则走既有安全中性处理，不能视作正常揭示样本。

## 4. 真正的口径冲突在旧 app/微信 tab getter

实施前 `CSGroupListAdapter.m:183–209` 的 `closeFriendAlertBadgeCount` 采用不同条件：

```objc
BOOL filtering = [policy concealsSurface:CSCloseFriendSurfaceSession]
    || (policy.enabled && [policy.options[@"silenceMessages"] boolValue]);
NSMutableSet *hidden = [policy.protectedUserNames mutableCopy];
```

只要 silenceMessages 开启，它在 revealed 时仍继续接管，并无条件将全部保护名单当作 hidden；同一段代码随后只读取投影 count，没有携带 redDot。它与分组 `projectionForSections` 的实际隐藏口径不是同一回事。

这不是推测：`Tests/CloseFriendAlertTests.m:195–199` 明写 “excludes protected counts while revealed”，构造已揭示策略、保护会话 8、普通会话 3，要求旧 getter 仍返回 3。这个历史断言与本轮“揭示加回”的 tab 目标直接不一致；它测试的是旧 app/tab getter，不是分组的既有展示规则。

同时，`CSCloseFriendPolicy.silencesSession:` 的通知静音语义本来就独立于 revealed（`CSCloseFriendPolicy.m:69`）；`CloseFriendCoreTests.m:35–38` 和 `CloseFriendRuntimeTests.m:106–108` 均明确要求揭示后继续静音。这不等于分组数字也必须扣除。实施时应把通知静音与本轮 tab 展示口径区分清楚；不能为了“揭示加回”连带停用消息通知静音。

## 5. 原生免打扰是否存在已证实冲突

已查看 `Tests/GroupBadgeTests.m:83–146`。它通过生产 bridge → projection → adapter 发布片段 → 两层 UI 更新验证原生 dot/count 组合，明确覆盖：dot 模式正未读贡献点、清零后 dot 标记仍在也不能残留提示、dot=NO 的普通会话贡献数字、只有 flag 改变时失效复用、原生全部数字优先、隐私过滤和 hide badge 选项。测试的 native session 是 host 替身，没有 native mute/DND 属性，所以它能证明“桥接后的表现标记语义”，不能证明真实 DND→dot 的映射。

既存 8.0.78 静态结果进一步支持直接复用原生表现标记：

- [MMNewSessionMgr.recountUnReadCount](../tabbar-wechat-badge-2.1-6-2026-10-29/native/MMNewSessionMgr--recountUnReadCount.asm) 的 `0x10452e818–0x10452e834` 读取 dot 与 count；`0x10452e838` 在 dot 为 NO 时跳到 `0x10452e868`，将 count 加到数字 total 对应字段。dot 为 YES 则先进入另一个累计字段，并按是否有正未读累计相应提示。
- [MMNewSessionMgr.GetTotalUnreadCount](../tabbar-wechat-badge-2.1-6-2026-10-29/native/MMNewSessionMgr--GetTotalUnreadCount.asm) 在 `0x104521c14–0x104521c1c` 返回上述数字 total 字段。
- [MainFrameLogicController.getTotalUnreadCount](../tabbar-wechat-badge-2.1-6-2026-10-29/native/MainFrameLogicController--getTotalUnreadCount.asm) 的 `0x104aa6574–0x104aa6580` 调用该 manager getter；此方法另有数据未就绪返回 0 的原生前置分支。

这段原生重算还排除 isHidden、isInChatBox、isInBrandServiceBox、折叠聚合入口等，与插件现有聚合/成员规则需要分别看待；不能声称任意“全部数字”永远等于任意分组投影数字之和。但在上述普通会话的 dot/count 分支，没有看到“dot=NO 且 DND=YES 仍另外排除数字”的独立 DND 检查。这里仅论证这条已保存的重算路径，尚未追出 total 字段全部增量写入，也没有追完 DND 状态到 dot/count 的所有上游更新及 @/提醒例外，因此不宣称完整复刻原生总数规则。

因此目前**没有证实实际 DND 冲突**。尤其不能从一个人为构造的“DND=YES、dot=NO、nativeTotal=0”替身直接推导真机有此状态。审计应写为“复用原生未读表现标记，数字/点规则与分组一致；真实 DND 映射未真机验收”。如果设备后续确实出现原生 DND 不计数字而 dot=NO 的样本，需核对原生模型更新时点、@/提醒例外、聚合归属、原生 total 和会话字段，再决定是否需要增加来源；本次没有这种现场或足够静态证据，不提出额外 DND 规则。

## 6. 实施前可采用的语义判断

| 本轮要求 | 与现有分组规则 | 与旧 app/tab getter |
| --- | --- | --- |
| 实际隐藏的会话不贡献数字/点 | 一致 | 隐藏时一致，但会把暂时无缓存也表示为零。 |
| 正常揭示后加回原生表现对应贡献 | 一致；silenceMessages 不改变 hidden 集合 | 开启 silenceMessages 时不一致，有旧测试明确要求继续排除。 |
| native dot 模式不产生数字，正未读时保留点 | 一致 | 仅返回 count，丢失纯点分量。 |
| 原生 DND 不产生数字 | 复用原生表现标记，未证实另有实际冲突；DND 映射待设备验收 | 不能把 silenceMessages 直接当 native DND；需与通知静音独立处理。 |
| 不改变通知静音、微信真实未读、原生免打扰 | 现有分组为只读投影 | 旧 getter 与静音绑定不应反过来要求修改通知策略。 |

本次未运行测试；上面描述的是现有用例覆盖及源码/既存静态证据，不声称 2.1-8 的回归或设备验收已经通过。

## 7. 检查时源码指纹

| 文件 | SHA-256 |
| --- | --- |
| Controllers/CSGroupProjection.m | `c16febd6db38a37146f3b6d8b62ec01ac36daf2f1b9a880d73c1ce6e255ba34d` |
| Controllers/CSGroupNativeBridge.m | `aa352dd26bbb41b0446994689e91d7ed8427e2ff81ddb0f8a51e69664e618475` |
| Controllers/CSGroupListAdapter.m | `dcea1b1e1f4b0eb7cc2f2ef4cd0af301527789bf79c9804455a852e601fbc811` |
| Controllers/CSCloseFriendPolicy.m | `270695d97b73bf4d3298b8e9546a4ba35c5d16777c21cefd5ce8d52e0ee9a174` |
| Controllers/WESessionTabContainerView.m | `b7ce9e8eb8f07029668e5c47fb9735e7f234cd4e2c549b2fc169e8eef28c5764` |
| Tests/GroupBadgeTests.m | `c5b0bc82e721b735adb212adea0be05ed0007ca1201d49034882d7ce4b640cf9` |
| Tests/CloseFriendSessionTests.m | `3aa84bd04a3e0d6c7e416bd7c6e1eb35e43c1a968e589ecc15eced8547bc0046` |
| Tests/CloseFriendAlertTests.m | `d0f15d3d9d550f4d2bcc41213ab0e75543217d2ba81c36d758ac2f80a1ee7e43` |
| Tests/CloseFriendCoreTests.m | `fc2f07829aa80c269ebbbcaac8c84f5549b76efb2fe1d84b20db4131adc5948f` |
| Tests/CloseFriendRuntimeTests.m | `16e9c2e52c16e4a4f4dad053197e5213c91afef93a4942032e2a091cb0e84750` |

文档 `docs/session-groups.md` 的检查时 SHA-256 为 `e6457d41cc39e37c6f5b044d4b267254b6ad8e78498e6593f5b7809e7305db13`；它作为既有语义说明交叉参考，没有把它冒充授权清理 602 项源码清单中的匹配文件。
