# 2.0-24：折叠入口的原生名称与消息双 label

已完成原生调研、失败复现、修复和双包构建。本机采用已交付 2.0-23b 源码为工作基线，保留用户已确认的“时间仅排序、不能否决有效摘要”修正；用户设备中的 2.0-23 是本轮现象对照。未连接或执行真机微信，不把 host 回归和静态反汇编当作真机像素验收。

## 根因及可验证证据

先前实现读取普通子会话 `m_textForMessageLabel`，备用路径 `digestForMsg:withSender:` 使用普通群聊发言人前缀，最终放进一个插件 UILabel。原生折叠入口实际由两部分组成：

- `m_prefixTextForQuoteMessage` 提供消息所属**会话名称**，不是群内发送人的昵称；原生通过 GetChatName → 联系人/群资料 → genChatRoomName 取得并生成分隔符。
- `m_textForMessageLabel` 提供正文/微信类型摘要；`MainFrameItemView.quoteMessageLable:prefixText:` 将名称放入独立 MMUILabel，与现有 NoLineBreakLabel 正文相邻。

实际标点由微信生成：8.0.78 此分支使用 `%@: `，并非插件自行决定空格或冒号。显式备注、昵称和自动生成群名的裁剪规则不同。两块 label 的字体、颜色、动态字号、可用宽度和截断都复用原生方法。

研究报告在生产编辑前写入：[原生链路、地址与边界](native-findings.md)。完整 UI 方法、布局公式、继承关系见 [渲染证据](native/rendering/README.md)；[恢复的接口签名](native/VerifiedFoldedSummaryInterfaces.h)、[方法元数据](native/methods.json) 和同目录完整汇编可核查。

## 实施

1. CSGroupNativeBridge 只复用**与分组候选严格匹配**的原生入口缓存：aggregate 身份、消息 ID（q/Q 全64位）、GetChatName、当前消息来源必须匹配；否则不取全局入口摘要。
2. 冷启动/缓存未生成时，用独立消息副本调用原生 digest（空 sender）和原生 aggregate makeTextForQuoteMessage。临时 CellData 只绑定本地只读值对象，不注册缓存、不改 live session、不调用会清红包计数的 makeTextSession 或修改会话/草稿的 updateMessageLabel。
3. CSGroupRow 只新增不可变名称前缀及来源元数据，沿用既有同一份分组/隐私子投影和最新候选选择。名称变化也使展示快照失效；组成员、排序、未读/红点算法未改。
4. 展示复用原生 m_messageLabel 与原生 quote 方法产生的名称 label；每次先恢复未 quote 的左起点，避免重复刷新逐次右移。失效/复用只清除本插件仍持有的双文本，不把旧全局摘要恢复回来，也不覆盖微信刚写入的普通会话文本。原生渲染中发生隐私变化也在本帧撤下文本。
5. 标题保持原生“折叠的聊天”及字号；图标、行高、连续圆角卡片、浅深色及时间隐藏规则保留。未知原生结构走有原因日志的中性保护，不伪造一个单 label 的“原生格式”。

功能改动集中在 CSGroupNativeBridge、CSGroupProjection（只读值及诊断）、CSGroupListAdapter（诊断来源）、CSCloseFriendSessionPresentation。其余是测试、版本、文档。源码差异见 [changes-from-2.0-23b.diff](changes-from-2.0-23b.diff)。

## 诊断

示例（不含会话、账号或正文）：

```
[WeChatImprove][FoldedDigest] stage=source reason=ok_cache tab=preset_2 count=2 source=entry_cache
[WeChatImprove][FoldedDigest] stage=source reason=ok_copy_cell_missing tab=preset_2 count=2 source=native_formatter
[WeChatImprove][FoldedDigest] stage=display reason=ok tab=preset_2 count=2 source=native_formatter
```

`entry_cache`＝已验证同一候选的原生入口双字段；`native_formatter`＝消息副本上的微信正文/折叠名称生成；`neutral`＝未显示有效双文本。stage 分 source/display，reason 保留缺失、身份不匹配、策略失效等原因。相同 stage/reason/tab/source 去重，总共最多32条/进程，不写持久诊断存储。日志没有时间降级理由。

## 红/绿回归

严格只运行用户指定的两套脚本，无全量。生产修改前最初复现35个失败，并通过 SHA256 证明生产源码未变，见 [red-production-preservation.json](red-production-preservation.json)。补齐最终全部用例后，另外在源 ZIP 恢复的独立临时目录运行同一套最终测试：

| 脚本/子集 | 最终用例数 | 旧基线失败 | 2.0-24 失败 |
|---|---:|---:|---:|
| verify-list-corners.sh | 1017 | 13 | 0 |
| verify-close-friend-session.sh：会话 | 139 | 37 | 0 |
| verify-close-friend-session.sh：展示 | 44 | 16 | 0 |
| 合计 | 1200 | 66 | 0 |

覆盖：私聊/群聊名称与消息分工及分隔、显式长名称与原生生成的截短名称、长正文与窄宽容器对原生 quote 的委托、类型占位原样传递、最新候选变化、跨组排除、密友顺延、全隐藏、账号/代次/revision、无缓存冷启动、无时间仍可显示、缓存身份错误、复制别名拒绝、渲染中策略变化、普通/折叠 cell 复用、反复布局、卡片浅深色/开关切换。原来要求单 overlay 的测试改为原生两 label 契约；未知结构不再要求假原生摘要。

日志：[旧源码最终红](logs/red-final-session.log)、[旧源码卡片红](logs/red-final-corners.log)、[会话/展示绿](logs/green-session.log)、[卡片绿](logs/green-corners.log)。替身只验证调用边界和行为，最终 UIFont/语言/微信版本像素需真机对照。

## 构建与保留

control、版本常量、发布说明均为2.0-24。rootful/rootless 均在 [独立构建目录](build-environment.json) 完成 arm64 + arm64e 编译。每方案12条历史警告，与上一版类型及数量一致；新增0条、错误0条。见 [build-verification.json](build-verification.json)。没有 make clean，没有复用/改写工作区 .theos。

- [Rootful deb](../../../packages/com.wechat.improve_2.0-24_iphoneos-arm.deb)
- [Rootless deb](../../../packages/com.wechat.improve_2.0-24_iphoneos-arm64.deb)
- [两方案/两架构 symbols](../../../packages/com.wechat.improve_2.0-24_symbols.zip)

已校验包版本、架构、载荷安装路径、dylib与各架构dSYM UUID匹配、真实运行符号存在、测试替身未混入包、存储启动 initializer 顺序未改变。SHA256、UUID见 [packages.json](packages.json)。历史54个 packages文件、3066个历史审计文件、1173个工作区.theos文件全部SHA256不变；只新增本版三个成品。[保留证据](preservation.json)。

## 真机验收

1. 同一微信、相同字体/主题/圆角设置下，将原生折叠入口和启用分组后的入口并排截图，检查标题字号，名称在前、正文在后，分隔、颜色和省略位置；不应出现数量后缀或右侧时间。
2. 给A/B两组分别放至少一条私聊、一条群聊折叠会话。冷启动后不先进入折叠页，分别切组；各组应显示自身最新可见会话的名称与消息，不串组。再进一次折叠页返回，应保持一致。
3. 让组内另一会话收到新消息，摘要的名称和正文必须一起变化。用长备注、长群名和长消息确认微信原生截断；用图片、表情、引用/链接、语音、撤回/系统/红包检查实际微信本地化摘要。
4. 隐藏最新密友应顺延到下一条；全部隐藏时入口消失。切账号或改变隐私后，旧名称与正文不能闪现。
5. 浅/深色、动态字体、短列表滚动复用、反复切组，圆角开关关后再开：双 label 不累计右移、不重复、无旧文本，图标、行高和连续卡片仍与2.0-23一致。
6. 若任何场景仍不一致，请提供“原生/分组”同一消息的两张截图、微信版本，以及同进程 `[WeChatImprove][FoldedDigest]` 的 source/display 行。无需提供消息正文日志；reason/source 可区分取数和渲染分支。
