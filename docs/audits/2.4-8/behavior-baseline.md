# 2.4-8 编辑器行为基线与风险（只读调查）

基线来自本 checkout 的 2.4-7 源码，完整文件保存在 `baseline-CSGroupChatSettingsViewController.m`，关键方法保存在 `behavior-method-baseline.json`。未执行任何 git 命令，未修改 Tests 或生产代码。

## 基线行为

| 检查项 | 2.4-7 的精确行为 |
|---|---|
| 变量顺序 | `@昵称`、`@备注`、`@微信ID`、`@群昵称`、`@时间`、`@群人数`；非 welcomeTemplate 才追加 `@离群类型`；最后取消。 |
| 插入链路 | 先校验 context / saving / CSSettingsCanPresentFrom；动作经 CSSettingsAfterDismissingSheet，重新校验 page/context/saving，再 becomeFirstResponder + insertText:token + updatePreview。|
| 恢复默认 | 校验 context/saving；`self.textView.text=self.defaultText?:@""; [self updatePreview];`。默认值由首页 editTemplate: 的 CSGroupChatDefaultWelcome / CSGroupChatDefaultRoomDeparture / CSGroupChatDefaultDeparture 既有接口提供。 |
| 空白校验 | 使用 whitespaceAndNewlineCharacterSet trim；失败字串：`请输入文案，内容不能全为空白。` |
| 长度校验 | NSString.length > 4000；失败字串：`文案不能超过 4,000 个字符。`；输入阶段不截断内容，只显示红色计数。 |
| 保存链路 | context/saving 检查 → CSGCRequireAuthorization → 空白/长度检查 → saving=YES/stateChanged → updateConfiguration:@{configurationKey:text} completion → main queue → saving=NO → 仅 success 且自身仍为 topViewController 时 pop；失败先 stateChanged，再 error.localizedDescription 或 `保存失败，请重试。`。 |
| 保存失效提示 | 点击保存时 `账号或设置已变化，请返回后重新编辑。`。 |
| 状态禁用 | stateChanged 内 main-thread 转发；valid=CSGCContextValid(context,YES)；保存启用与 editable 均为 valid && !saving；保存标题为 `保存中…` 或 `保存`。 |
| 状态页脚 | valid || saving 时 `预览使用示例成员与群聊，不会发送消息。`，否则 `账号或设置已变化，请返回后重新编辑。当前内容尚未保存。`。 |
| 预览 | 原函数 CSGroupChatRenderTemplate(text,values)；值为张三/三哥/wxid_zhangsan/读书群/128/CSGroupChatDateText(NSDate.date)；welcome 昵称替换为 `@张三\u2005`（U+2005），其他两种追加离群类型被移出。 |
| 导航 | 左取消 Plain；右保存 Done；取消直接 pop；title 欢迎文案/本群文案/通知文案；textView.accessibilityLabel=self.title；hidesBottomBarWhenPushed=YES。 |
| 首页欢迎文案 | text.bubble.fill / systemBlueColor / config[welcomeTemplate] / editTemplate:welcomeTemplate。 |
| 首页通知文案 | bell.fill / systemOrangeColor / config[departureTemplate] / editTemplate:departureTemplate。 |
| 首页本群文案 | text.bubble.fill / systemBlueColor / 开启时 config[departureRoomTemplate] 或既有默认；关闭时 `开启后可编辑`；点击 editTemplate:departureRoomTemplate，仍受 monitorEnabled 和 departureSendToRoom 限制。 |

## 原说明必须保留

- 欢迎：`@昵称显示微信昵称并提醒新成员；@备注显示群内备注；@微信ID显示成员的微信账号标识。备注或 ID 缺失时留空。支持换行、标点和表情。`
- 本群：`消息会发到成员离开的群，群内成员可见。@昵称、@备注和@微信ID均为文字，ID 缺失时留空；@离群类型显示已确认的离群原因。`
- 通知：`此通知仅自己可见，点击昵称可查看成员资料。@备注显示群内备注；@微信ID显示成员的微信账号标识。备注或 ID 缺失时留空；@离群类型显示已确认的离群原因。`
- 三种均支持 @群昵称、@群人数、@时间，原插入 sheet 已提供；新 footer 需写明其含义。

## 既有组件与布局风险

- CSGCConfigureTable 设置 systemGroupedBackground、separatorInset 左 54/其余 0、AutomaticDimension、estimatedRowHeight 52，注册 CSGroupChatSettingsCell。
- CSGCRow 用 actionItem 搭配 actionBlock 即自动得到 disclosure indicator、标准系统配色；CSSettingSection 保持现有 header/items 模型。
- 首页 footer 使用 titleForFooterInSection 及换行串，不是独立裸 label。
- 继承 CSSettingsTableViewController 后 safe bottom 由 cs_updateBottomSafeArea 以 delta 叠加；键盘贡献必须独立记录并以 delta 加到当前 contentInset/verticalScrollIndicatorInsets，不能直接覆盖为键盘高度。
- 输入和预览必须持有稳定 cell/textView；输入更新禁止 reloadData/reloadRows。仅在测量高度变化时使用无动画布局更新，保留选区和 firstResponder；footer 计数固定或预留高度避免每次字数增长抖动。
- CSGroupChatSettingsCell 默认 title/detail 都单行截尾；仅复用该类而未做编辑器局部多行适配，可能在 SE/大字体违反不截断要求。不要修改共享类来影响首页三行。
- textView 关闭内部滚动后需将全部文本高度纳入 cell 的 Auto Layout；过长文本需由表格滚动并滚动光标所在矩形，不能只确保整行可见（整行可能高于屏幕）。
- popover 锚点应为插入变量行在 tableView 上的 rect，必要时取可见区域内交集；不能保留固定 y=180。
- 真实设备视觉、键盘互动、动态字体、横屏和 iPad popover 仍须实际运行验证；源码/打包通过不可冒充真机验证。
