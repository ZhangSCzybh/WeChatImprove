# WeChat 8.0.78：折叠入口摘要原生渲染证据

范围：只读、离线、arm64 反汇编与 Objective-C 元数据；不执行微信，不修改生产源码或 Tests，不运行回归。目标 `/tmp/wechat-8.0.78-inset-analysis/WeChat`，SHA256 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`。主调查的 REA 会话由主代理管理；本子任务未打开/关闭第二个会话。

## 结论

**原生摘要确实由两块文本共同呈现。** `m_textForMessageLabel` 只提供消息正文/原生类型摘要；`m_prefixTextForQuoteMessage` 由数据层另行提供会话名称前缀。`MainFrameItemView` 在 `chatroom_session_box` 分支调用 `quoteMessageLable:prefixText:`，原生方法创建一个独立 `MMUILabel` 作名称前缀，再将已有消息 `NoLineBreakLabel` 放在它右边。前缀不是标题 `m_nameLabel`，也不是群成员发送人昵称 label。主代理负责的数据层调查确认会话名称由 `GetChatName → getContactByName → genChatRoomName:truncateByLen:appendTailText:` 产生；应结合其证据使用这一来源。

现有插件单个 overlay UILabel 的模式无法表达这组原生标签分工。为了格式一致，应复用 **原生已有消息 label + 原生 quote 方法产生的前缀 label**，只替换经当前分组及隐私过滤后选出的消息/前缀，不自造名称和正文拼接字符串，不重写字号/颜色/比例宽度。

## 类与数据结构

- `NewMainFrameViewController.tableView:cellForRowAtIndexPath:`（`0x10511eafc`，`@32@0:8@16@24`）常规会话区按 `kMainFrameCellIdentifier` 复用/创建 `NewMainFrameCell`；创建点 `0x10511ee70`，随后 `updateContentView:tableViewFrame:`。
- `NewMainFrameCell.updateContentView:tableViewFrame:`（`0x1050fe42c`，`v56@0:8@16{CGRect={CGPoint=dd}{CGSize=dd}}24`）取 `MainFrameCellData.m_sessionInfo`；`0x1050fe580` 创建 `MainFrameItemView`，已存在则 `0x1050fe544` 调 `updateWithCellData:`。**折叠入口没有另起一套正文渲染器。**
- `MainFrameAggregationCell` 的元数据 superclass 是 `NewMainFrameCell`；它的 `updateCellData:tableViewFrame:`（`0x104a6d778`）同样转给 `updateContentView:tableViewFrame:`。不能仅因类名含 Aggregation 就认定主表折叠行一定是这个类；主表创建路径证据是 `NewMainFrameCell`，两者共享 MainFrameItemView。
- `MainFrameItemView` ivar 有 `m_cellData`（MainFrameCellData）、`m_nameLabel`（MMCPLabel）、`m_messageLabel`（声明 MMCPLabel）、`m_timeLabel`、`m_greenLabel`。运行实例的 `m_messageLabel` 在 `initSubview` 的 `0x104a8ec70` 创建为 `NoLineBreakLabel`，它继承 `MMCPLabel → MMUILabel`。见 `ivars.json`；静态 ivar 偏移只是元数据，不可直接当运行时绝对偏移使用。

## 折叠分支的精确调用

`MainFrameItemView.updateMessageLabel` 的完整范围 `0x104a92f8c–0x104a96590`：

1. `0x104a93458` 取 `m_textForMessageLabel`，`0x104a93478` 向 `m_messageLabel` 发送 `setText:`。
2. `0x104a96030` 引用常量 `chatroom_session_box`，`0x104a96038` 发 `isEqualToName:`；匹配后 `0x104a96088` 跳到 `0x104a95ecc`。
3. `0x104a95f24` 读取 `m_prefixTextForQuoteMessage`。
4. `0x104a95f3c–0x104a95f4c` 调 `quoteMessageLable:prefixText:`，参数为摘要 label 与前缀。其方法编码为 **`v32@0:8@16@24`**，IMP **`0x104a91f74`**。

某些通用红字/草稿分支可能选择 `m_greenLabel` 作为 quote 的 label 参数。插件现有隐私处理应继续隐藏这些全局标记；本文推荐只处理经过验证的消息正文 label，不打开全局红字、未读、时间内容。

## 字号、颜色、布局、截断

原生 `quoteMessageLable:prefixText:` 全长约 2 KB，完整文件未截断：

- `0x104a91fc4–0x104a91ff8`：创建 `MMUILabel`，初始 frame 来自传入 message label。
- `0x104a92018–0x104a9203c`：前缀颜色读取 **self.m_messageLabel.textColor**。`initSubview` 中正文色为 `WCColor.tertiaryLabelColor`（`0x104a8ed7c–0x104a8eda8`），包含微信自己的深浅主题选择。
- `0x104a9204c–0x104a92110`：前缀复制传入 label 的 font、textAlignment、backgroundColor、highlightedTextColor；没有另造 prefix 专用字体/颜色。
- `0x104a92128` 的 `mov` 与下一条 `movk` 合成 tag **`0x989a69 = 10001001`**，不是仅第一条的 39529。
- `0x104a92138–0x104a92144` 将 prefix 原样 `setText:`；该方法内部不增加冒号/空格。分隔属于数据层生成的 prefix，不能由插件另作决定。
- `0x104a92160` 原生量前缀的自然宽；再按 itemView.width、主题 `cell_headimg_left_margin` / `cell_headimg_size`、原生动态长度计算可用区域，`0x104a92318` 调 `CControlUtil.labelSizeOfLabel:maxWidth:`。
- `0x104a92384–0x104a923c4`：前缀 x 等于传入 message 的原 x；消息 x = `ceil(prefix.right)`。没有插件可自行设置的固定名称占比，也没有额外固定间隔；间隔由 prefix 自己的标点/空格与原生量字形成。
- `0x104a92574–0x104a925a4` 由原生 `CControlUtil.labelWidth:maxWidth:font:` 计算剩余正文宽度；`0x104a92760–0x104a92784` 若前缀自然宽已占满可用区域，则正文 width 置 0，否则沿用原生测量 width+1。最后前缀高度对齐正文。
- `CControlUtil.labelSizeOfLabel:maxWidth:`（`0x1167ec0c4`）在 `0x1167ec140` 将 `lineBreakMode=4`（tail truncation）传给量字方法。正文量宽 helper（`0x1167ebbd0`）使用 `lineBreakMode=1` 量字；实际绘制仍由原生 label 自身完成，不能把“量字模式”误写成“自定义绘制模式”。
- `NoLineBreakLabel.setText:`（`0x1028b7610`，`v24@0:8@16`）先调用 `stringByEscapingAllLineBreak`，再调用 super.setText。因此正文单行换行处理应继续交给原生对象。
- `MainFrameItemView.initSubview` 读取主题 `#mainframe_table / cell_labelmsg_textsize` 和动态字体工具设置正文字体；本次不将静态数字当作真机当前字号。复用已有 label 字体可继承用户字体设置及微信主题；插件不应改 `adjustsFontSizeToFitWidth` 或猜色值。

长名称另有数据层 `genChatRoomName:truncateByLen:appendTailText:` 的截断规则（主代理调查），然后才进入上述像素宽度限制。两层规则都必须沿用。

## 时间、刷新和副作用边界

- **原生折叠入口本来就没有时间。** `MainFrameItemView.updateTimeLabel` 在 `0x104a8f428` 比较 `chatroom_session_box`，匹配后 `0x104a8f448` 将文本参数置 nil，跳过 `m_textForTimeLabel`。该证据与用户真机确认一致。
- `MainFrameItemView.updateWithCellData:`（`0x104a9c77c`）换 data 后 `0x104a9c8d4` 调 `setNeedsLayout`。`layoutSubviews`（`0x104a8f280`）依次刷新 head、unread、time、name、status、message、group 等；其中 message 调用点 `0x104a8f304`。折叠成员变化经数据层通知到 cell 更新后，自然重走前缀布局。
- `NewMainFrameViewController.updateFoldSessionEntry` 内可见 `reload main list at fold change` 字符串（`0x1051111d4`）及 `MainSessionMgr.updateMainSessionListNotify:YES`（`0x10511124c`），这证明折叠变化会刷新主列表，但完整消息/成员变更通知源由主调查的数据层范围提供。
- **不要为刷新摘要而主动调用整段 updateMessageLabel。** 其通用分支里有 `AddOrModifySession:withNotifyFlag:`（`0x104a93858`）、`clearDraftForContact:`（`0x104a938d8`）等业务写操作。即使折叠路径通常绕过它们，也不应当成纯格式化函数。
- 相比之下，完整 `quoteMessageLable:prefixText:` 只读主题/量字、创建前缀和调整两个视图；未见消息/会话/红点写入。`removeQuoteMessageLabel`（`0x104a927e4`，`v16@0:8`）只移除 tag 10001001/10001002，再 setNeedsDisplay。

## 最小渲染复用方案及边界

1. 取原生 item / m_messageLabel，并保存它的原生样式；允许的摘要候选和 prefix 必须来自同一条已验证的组内可见会话。
2. 在原生布局之后，把原生全局 prefix 移除/替换，只向 message label 写入该候选的原生消息摘要。恢复 **quote 前的摘要起点**：现存 prefix 的 frame.x 就是原 message 起点；没有 prefix 时取原 message frame.x。避免反复在已经向右偏移过的 message frame 上 quote，造成累积右移。
3. 调原生 `quoteMessageLable:prefixText:`；保留新产生的 prefix 与 message，继续隐藏全局时间、红点等已有隐私区域。保留原生 title/icon/card 外观。
4. 复用/候选失效时清除旧 prefix、清正文，按现有隐私门禁隐藏，不以全局 prefix 或全局聚合正文兜底。未知原生方法签名/视图结构时回到有诊断原因的中性保护，不编造“类似原生”的双 label 格式。

未声称完成真机像素对照：当前证据为微信 8.0.78 arm64 的静态行为；其它微信版本、UIKit/字体最终像素绘制及系统动态字体尺寸仍须真机验收。实现若直接调用这组原生方法并保留原生 label，能避免在插件里复制私有像素/色值规则。

## 证据索引

- `methods.json`：类、selector、IMP、end、Objective-C 类型编码。
- `ivars.json`：类继承与 ivar 声明。
- `MainFrameItemView--updateMessageLabel.asm`：折叠判定与 quote 调用。
- `MainFrameItemView--quoteMessageLable_prefixText_.asm`：双 label、样式和布局。
- `MainFrameItemView--removeQuoteMessageLabel.asm`：局部 UI 清理。
- `MainFrameItemView--initSubview.asm`、`NoLineBreakLabel--setText_.asm`：正文实例、主题、换行处理。
- `MainFrameItemView--updateTimeLabel.asm`：折叠入口清空时间。
- `NewMainFrameCell--updateContentView_tableViewFrame_.asm`、`MainFrameItemView--updateWithCellData_.asm`、`MainFrameItemView--layoutSubviews.asm`：刷新链路。
- `manifest.json`：目标身份及完整方法范围。汇编注释由直接 selector/CFString 引用解析辅助生成，原始指令为判定依据；未将注释解析当作动态调用证据。
