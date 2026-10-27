# 2.0-24 原生折叠入口摘要：先调研，后实现

本报告在生产源码修改前写入。研究对象为微信 8.0.78 arm64 离线 Mach-O，SHA256 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`。没有执行微信，没有读取用户聊天内容。源码起点为已交付的 2.0-23b（保留时间不能否决摘要的修正）；用户设备上的 2.0-23 是本次行为对照。

## 根因与原生链路

2.0-23 只读取子会话的 `m_textForMessageLabel`，备用路径调用 `digestForMsg:withSender:` 并使用普通群聊发送人前缀，最后画进单个插件 UILabel。这不是原生折叠入口的完整摘要。原生入口用 `m_prefixTextForQuoteMessage` 单独存放**消息所属会话名称**，由第二个原生 label 展示。正文 formatter 不负责这个名称。

| 层 | 可验证证据 |
|---|---|
| cell/data | 主表 `NewMainFrameViewController.tableView:cellForRowAtIndexPath:` 0x10511eafc → NewMainFrameCell → MainFrameItemView / MainFrameCellData。MainFrameAggregationCell 也继承并转发同一路径；并非插件 footer。 |
| 名称生成 | `-[MainFrameCellData makeTextForQuoteMessage]` 0x104a80370，`v16@0:8`；chatroom_session_box 分支 0x104a80a74–0x104a80c10。 |
| 名称来源 | `CMessageWrap.GetChatName` → CContactMgr.getContactByName: → `+[CContact genChatRoomName:truncateByLen:appendTailText:]`，参数 10 / `... `。原生内部再使用 `%@: `。不是群内发言人的昵称。 |
| 名称优先级 | genChatRoomName 的 canShowRemark:YES 包装（0x100f914b8）→ 0x100f914e4；使用 remark / nickname，必要时由群成员生成群名，并执行微信自己的长度处理。 |
| 消息 | aggregate 的 makeTextForMessageLabel → makeTextSession: 使用空 sender，常规分支调用 `+[MainFrameCellData digestForMsg:withSender:]`（0x104a78584，`@32@0:8@16@24`）；类型摘要由微信解析与本地化。 |
| 双 label | MainFrameItemView.updateMessageLabel 的 chatroom_session_box 分支读取 prefix，调用 `quoteMessageLable:prefixText:`（0x104a91f74，`v32@0:8@16@24`）。第一个参数是消息 label，第二个是名称前缀。 |
| 字体/颜色/截断 | 消息为 NoLineBreakLabel，名称为 MMUILabel（tag 10001001）。quote 方法复制原生消息 font/color/alignment 等，使用微信主题、dynamicLength 与 CControlUtil 量字；名称左端等于未 quote 前消息左端，消息紧随 ceil(prefix.right)，无插件比例宽/间隙。显式备注/昵称直接返回（0x100f91954），不会一律截到10字符；由成员生成的无名群名称才按 calStringLen/参数10与尾文案限制（0x100f9172c/0x100f919f4）；之后均按可用像素宽度量字；正文继续用原生单行 label，不能自造缩字策略。 |
| 时间 | updateTimeLabel 0x104a8f428 判定 aggregate 后将时间置 nil。无需也不应新增日期区域。 |

完整地址、方法编码、ivar、逐指令证据见 `native/methods.json`、`native/prefix-manifest.json` 与 `native/rendering/README.md`。原生名称中冒号和空格是从二进制确认的事实，实施时直接调用原生名称 builder，不在插件里复制拼接格式。

## 各类消息及安全调用边界

图片、表情、语音、引用/链接、撤回、系统消息、红包的文案与本地化分支均在原生 digestForMsg 与 makeTextSession 中；本次不维护一套 `[图片]` 等类型字符串映射。正文使用原生入口现成正文（严格校验同一候选消息）或对**独立拷贝的消息**调用原生 formatter，空 sender；名称仍由原生 aggregate 名称 builder 提供。LinkAnchorParser 的原生 stripping helper 保留聚合入口的链接展示处理。消息单行转义和像素截断由原生 NoLineBreakLabel/quote 方法负责。

不可调用整个 makeTextSession: 或 updateMessageLabel 来“刷新一下”：前者含 `clearExclusiveHbMessageCount:`（0x104a7f32c），后者含 AddOrModifySession / clearDraftForContact。不会调用这些有业务写入的入口。makeTextForQuoteMessage 只在新建 CellData 上运行，绑定临时 aggregate 只读值对象（消息为拷贝，品牌/计数字段为空/零），不修改实际 session 或缓存。quote/removeQuote 是局部 UI 操作。

限制：formatter 与原生入口缓存不同路径用不同日志来源标识；特定业务消息的完整有状态处理不是安全的纯格式化接口，因此不能声称在不启动真机的情况下已验证所有业务态像素。常见类型复用微信自己的 formatter；不会伪造占位文本。未知签名或身份失败时继续隐私保护，记录原因，不借全局摘要冒充当前组。

## 原生全局候选与分组候选的差异

ChatBoxMgr.lastMsgForChatBoxSession 遍历全局 chatBoxSessions，可回查 GetLastMsg。updateChatBoxSessionDesc 比较 IsSameMsg、更新 aggregate 消息并调用 MainFrameCellDataManager.updateCellData:；消息与折叠变化经 OnAddMsgListForSession / updateSession / onMainFrameEndReload 驱动。cell 的 updateWithCellData → setNeedsLayout → layoutSubviews → updateMessageLabel 完成重排。

不能直接调用 global lastMsgForChatBoxSession 作为当前组兜底。本次保留现有不可变行、分组/隐私过滤及排序规则，从其选中的最新可见子会话取得同一份名称/正文。只有 aggregate cache 的消息 ID、GetChatName、aggregate 身份和源消息同时验证为该子会话，才可复制其现成双字段；不匹配则用拷贝消息 + 原生 aggregate 名称方法。源对象或账号 epoch / privacy revision 变化拒绝发布。时间只排序、不控制有效正文显示。没有首次打开折叠页的依赖；主列表刷新继续重试。

## 确定的最小实施方案

1. 为 CSGroupRow 增加独立名称前缀与来源元数据，只传播展示信息，不改成员、未读、筛选和排序规则。
2. 支持严格身份验证的入口 cache 和冷启动 formatter 两条路径；诊断 source=entry_cache/native_formatter/neutral，保留去重、32条进程上限、不记录正文/账号。
3. 保留原生标题、图标与消息 label，使用 quoteMessageLable:prefixText: 生成原生名称 label。每次恢复 quote 前起点再 quote，避免累积位移。复用/失效清除自己产生的文本，不恢复旧账号内容，不主动调用有副作用的完整渲染方法。
4. 先红后绿，只运行两个指定脚本。用原生方法替身验证调用契约、分组边界、冷启动、复用与隐私，不将 host 替身等同于真机像素验证。

## 追加的类型与截断证据索引

以下是原始汇编中的 selector / 本地化 key，不是插件添加的消息占位映射：

| 原生证据 | 地址 / 文件 |
|---|---|
| `GetDisplaySessionContent`：消息原生可显示文本入口 | digestForMsg 0x104a787b8 / 0x104a787e4 |
| 图片本地化 `MessageContent_ImgFlag` | digestForMsg 0x104a79250 |
| 语音 `m_uiVoiceTime`、`MessageContent_Voice`、`%@%@ %@` | digestForMsg 0x104a78b84 / 0x104a78c4c / 0x104a78c6c |
| 表情与表情分享 `OpenApi_MainItem_Emoji`、`OpenApi_MainItem_Emoticon_Share` | digestForMsg 0x104a7a250 / 0x104a79b2c |
| 链接 `OpenApi_MainItem_Url`、`MessageContent_Link` | digestForMsg 0x104a79a10 / 0x104a7b9cc |
| 原生消息标题/描述 `GetTextTitleAndDesc:toTitle:toDesc:needBreakLines:` | digestForMsg 0x104a7bda0；引用等子类型仍交给原生解析，不在插件解 XML |
| 红包存在额外业务态摘要与计数处理 | makeTextSession 0x104a7e64c（WCRedEnvelopes_WelcomePage_Title）、0x104a7ed4c（enableShowGiftRedDigest）、0x104a7f32c（clearExclusiveHbMessageCount） |

显式备注/昵称的返回点是 genChatRoomName 0x100f91954，直接调用原生 getter 返回；不能误读 `truncateByLen:10` 为“所有名称一律截10字符”。只有需要由群成员自动生成名称时，才进入 calStringLen、native truncate/尾文案分支。最终像素空间始终由 native quote/label 决定。本轮没有复制这些规则，也没有猜测中文/英文字符宽度。

完整 makeTextSession 对正文另有原生链接去锚点及最大页面维度/4 的预裁剪；本轮只调用纯文本去锚点 helper，像素裁剪由原生消息 label 负责，不自行选屏幕宽度或字符上限。特殊红包红字、未读计数等有业务态写入的分支不调用，也不开放既有隐藏区域。撤回/系统等内容若原生 formatter 返回文本，则原样使用；本报告不把替身中的示例文案当成某个微信本地化版本的实际字符串。
