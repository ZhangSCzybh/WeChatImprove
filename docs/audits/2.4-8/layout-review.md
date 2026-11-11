# 2.4-8 编辑器布局独立审查

审查范围：`Controllers/CSGroupChatSettingsViewController.m` 中本次新增的编辑器局部布局、`CSSettingsTableViewController` 的 inset 规则与共享设置 cell 的生命周期。仅源代码审查；没有真机或 Simulator 运行证据。

## 已确认的设计落实

- 编辑器继承共享表格基类、使用 `CSGCConfigureTable`，不改共享基类。
- 编辑、预览及快捷操作 cell 均持续持有、`reuseIdentifier:nil`；编辑 textView 只建立一次。输入更新没有 `reloadData/reloadRows`，不会主动重设 text/selection。
- 输入与预览以实际宽度测高；输入下限使用 `UIFontMetrics` 随动态字号增长，字体变化后重新测量。
- 高度无变化即返回；实际高度变化才无动画执行表格高度更新。
- 普通/失效状态 footer 按两种文案最大高度预留，状态变化只改文字；计数只更新指定 footer。
- 快捷操作局部 cell 在窄宽/大字号下改为上下排列；不改首页现有 cell 的行为。
- 键盘坐标经 screen → window → table 转换；停靠键盘只增减自身 inset 贡献，基类安全区管理保留。
- sheet 锚点以「插入变量」行实际矩形与可见区域交集为准，不能命中时回退到可见区域中心。

## 审查中发现并反馈的问题

1. **系统 footer 复用可能覆盖其他分组说明。** 初版把系统 footer.textLabel 存到弱属性。footer 即使滚出屏幕，仍可能被复用于其他 section，弱引用不会因此失效。已反馈主代理；复读时实现已改为每次用 `footerViewForSection:0/2` 定位当前目标 footer，问题已处理。
2. **浮动键盘遮住 caret 时，短内容可能没有足够滚动空间。** 初版只将目标 offset 夹到现有最大滚动值；iPad 整表内容不足一屏时最大值为 0，滚动无法将 caret 移出键盘。最终源码已补充 `floatingKeyboardInset`，在目标 offset 超出现有最大值时记录不足的滚动空间，通过已有 `keyboardInset` delta 机制叠加到当前 content/indicator inset；键盘移动或隐藏时将浮动贡献清零并撤回。该已知代码缺口已修正；iPad 实际交互仍未真机验证。
3. **原生 grouped footer 的文字宽度比表格 layoutMargins 还窄。** 已复读看到测量宽度增加了 32 点内部边距保留，降低大字号与小屏多行 footer 裁切风险。仍需在真实 UIKit 布局中验证其最终表现。

4. **编辑区高度与行分隔线的约束精度。** 最终源码将动态 `editorHeight` 约束优先级设为 999，保留上下边界，避免原生 cell.contentView 的分隔线厚度与 required 高度产生冲突。

## 最终 UI 技术审查结论

此次布局实现满足源代码层面的改造边界：三个入口共用分组表格编辑器，复用现有 section/item/cell 组件；快捷操作具有图标、详情及 disclosure；计数、帮助与状态进入原生 footer；编辑区随内容及动态字体测高，预览位于标准分组 cell 中。输入更新持续使用同一 textView，不调用 reloadData/reloadRows，不主动重设选区；停靠与浮动键盘的附加 inset 均通过独立贡献的 delta 合并，保留基类 safe-area 管理。popover 锚点跟随插入变量行。

业务行为比较脚本在最终源码上复跑为 **18 / 18 PASS**。此前独立审查提出的 footer 复用、footer 测量宽度、分隔线约束冲突、浮动键盘短页面滚动空间不足四项均已在最终代码中处理。本轮没有发现需要扩大改造范围的剩余代码问题。该结论不等同于真机视觉或交互验收。

## 必须保留的验证边界

源码可确认持续使用同一个编辑 view、没有 reload、动态测高与 additive inset；无法仅凭源码保证系统 TextKit、原生 footer、iPad 浮动键盘及所有无障碍字号的最终排版。真机仍需覆盖 iPhone SE、横屏、iPad 停靠/浮动键盘、分屏、连续输入/选区/插入变量以及账号失效提示。
