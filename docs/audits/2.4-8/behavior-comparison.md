# 2.4-8 行为源码独立对照

行为比较：全部通过。这是源码级证据，不代表真机运行验证。

| 检查 | 结果 | 证据与范围 |
|---|---|---|
| editor-save | PASS | 完整方法段与基线逐字比较。 |
| editor-cancel | PASS | 完整方法段与基线逐字比较。 |
| editor-restoreDefault | PASS | 完整方法段与基线逐字比较。 |
| homepage-reload-and-rows | PASS | 完整方法段与基线逐字比较。 |
| homepage-editTemplate-only-table-style | PASS | 唯一差异为 new → initWithStyle:UITableViewStyleInsetGrouped。 |
| insertVariable-only-popover-anchor | PASS | sheet 名称、选项内容/顺序、上下文检查、dismiss 后 becomeFirstResponder+insertText 和调用顺序均逐字不变，仅锚点替换。 |
| stateChanged-only-footer-storage | PASS | valid/saving 规则、保存标题、editable 和完整原提示字串不变，仅存储到 footer 文本并更新当前 section。 |
| updatePreview-only-footer-and-height | PASS | 原 %lu / 4,000 计数、红色条件、全部示例值、欢迎 U+2005 与 CSGroupChatRenderTemplate 逐字不变。 |
| all-three-original-help-strings | PASS | 三套原始说明逐字保留并追加 @群昵称/@群人数/@时间 含义。 |
| all-other-production-source-outside-editor | PASS | 编辑器之后所有代码仅入口初始化样式变化。 |
| shared-helper-and-cell-source-unchanged | PASS | CSGCContextValid/CSGCRequireAuthorization/CSGCRow/CSGroupChatSettingsCell/CSGCConfigureTable 均逐字不变；仅增加 math.h import。 |
| no-editor-reload | PASS | 编辑器内没有 reloadData/reloadRows。稳定 editorCell/textView 通过 beginUpdates/endUpdates 更新高度。 |
| navigation-and-accessibility | PASS | 标题继续由未变的 editTemplate 设置；取消/保存文案与 style、accessibilityLabel、hidesBottomBarWhenPushed 保留。 |
| unchanged-file-Controllers/CSSettingsTableViewController.m | PASS | 文件 SHA-256 与改造前相同。 |
| unchanged-file-Controllers/CSSettingTableViewCell.m | PASS | 文件 SHA-256 与改造前相同。 |
| unchanged-file-Controllers/CSGroupChatTemplate.m | PASS | 文件 SHA-256 与改造前相同。 |
| unchanged-file-Controllers/CSGroupChatStore.m | PASS | 文件 SHA-256 与改造前相同。 |
| unchanged-file-Controllers/CSGroupChatManager.m | PASS | 文件 SHA-256 与改造前相同。 |

## 布局审查记录

- 已修正：footer 更新直接取 footerViewForSection，避免离屏 footer 复用写错 section。
- 已修正：footer 高度测量额外扣除 32pt，给系统 footer 内边距预留空间。
- 已修正：编辑区 height constraint priority 为 999，避免 separator 厚度与 required 上下约束冲突。
- 已修正：浮动 iPad 键盘遮挡 caret 且现有滚动空间不足时，以 floatingKeyboardInset 记录缺少的滚动空间，通过原键盘 delta 叠加；键盘移动或隐藏时清零撤回。真实设备表现尚未验证。

未执行真机运行验证；只读源码比较不能证明键盘、SE/横屏/iPad 与动态字体显示结果。
