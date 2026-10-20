# 未读语音「转文字」按钮的原生几何证据

本记录仅分析已选定的微信 8.0.78（8.0.78.34）可执行文件 `/private/tmp/wechat-8.0.78-inset-analysis/WeChat`。SHA-256 已重新核对为 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`，已建立的 UUID 为 `9CD58B8E-B7AB-3487-ADBD-2AC0AA16A5DE`。这是静态元数据及有界 ARM64 反汇编证据，没有在 iPhone 上执行应用。

## 结论

普通未读语音右侧的「转文字」按钮是高 **20pt** 的横向附属控件，竖直中心与原生语音主体中心一致。37pt、38pt 主体均完全容纳它，不应因为模型的 `bShowingQuickTranTips` 为真就强制保留原生上下间距。显示和隐藏只做 alpha 动画，不改变 transform 或尺寸；按钮容器的尺寸直接等于按钮尺寸，没有另外扩大一圈的透明外框。

按钮容器是 **VoiceMessageCellView 的直接子视图**，不是 `m_contentView` 的子视图。现有合并渲染的两层有限测量会覆盖它，仍需保留该边界校验，不应把它从安全检测中排除。

## 地址与公式

| 证据位置 | 可核对的原生行为 |
| --- | --- |
| `VoiceMessageCellView.initQuickTransTipButton` `0x1062788b8` | `0x106278a38–0x106278a40` 设置按钮 height=20；`0x106278b60–0x106278b80` 设置 width=titleLabel.width+16。 |
| 同方法 `0x106278c70–0x106278c8c` | 读取按钮 size 后直接传给容器 setSize；没有额外竖向预算。 |
| 同方法 `0x106278cb4–0x106278cc4` | 把按钮加入 `transTipButtonContainer`。 |
| `VoiceMessageCellView.layoutContentView` `0x106276a68–0x106276a8c` | 当 `bShowingQuickTranTips` 为真时初始化按钮，再把容器直接加入 Cell。 |
| `VoiceMessageCellView.animateShowQuickTransTips` `0x10627944c–0x10627945c` | 独立显示路径同样把容器直接加入 Cell。 |
| `VoiceMessageCellView.updateQuickTransTipButtonPosition` `0x1062790ec` | 先算 content 坐标系中的中心，再通过 `m_contentView convertPoint:toView:cell` 转成 Cell 坐标，最后设置容器 center。 |
| `QuickTipBlocks.showAlpha` `0x10627958c` | 仅对容器 setAlpha:1。 |
| `QuickTipBlocks.hideAlpha` `0x106279700` | 仅对容器 setAlpha:0。 |
| completion block `0x1062795c4` / `0x106279738` | 均只有 ret。 |
| `VoiceMessageViewModel.measureContentViewSize:` `0x10628d230` | 直接返回 voiceNodeWidth、voiceNodeHeight；该方法没有快速转写按钮状态分支。 |
| `VoiceMessageViewModel.animateShowQuickTransTips` `0x106290c64` / `animateHiddenQuickTransTips` `0x106290d0c` | 修改布尔状态、通知已有 Cell 展示/隐藏；这两个方法不重新计算行高。 |

`updateQuickTransTipButtonPosition` 的中心公式为：

```text
contentCenter.x = maxX(m_unreadImageView.frame) + 8 + container.width / 2
contentCenter.y = (2 * text_message_margin_top + ceil(systemFont.lineHeight)) / 2
container.center = m_contentView.convertPoint(contentCenter, toView:cell)
```

这里的 Y 公式与 `voiceNodeHeight` 的语音主体高度公式一致。按钮垂直占用为 `[voiceBodyHeight/2 - 10, voiceBodyHeight/2 + 10]`，正常 37/38pt 高度时位于主体内部。

解码的成员偏移为 `m_contentView=24`（BaseMessageCellView）、`m_unreadImageView=224`、`m_quickTransTipButton=232`、`transTipButtonContainer=240`；这些偏移只用于离线核对反汇编，不能直接硬编码到生产访问。

## 实施边界与未验证内容

对已经适配的原生 Voice 模型取消 quick-tip 布尔阻断即可让首轮规划沿用既有语音几何；按钮显隐本身不需要改变行高，也不应触发后续收紧。保留真实容器的有限边界校验，可在其他插件改动尺寸、异常变换或未知几何时继续安全扩展/回退。

20pt 是本版本原生实现的常量，不是跨版本接口保证。若字体/CSS 导致主体高度小于20pt，则不能直接假设按钮仍内含。未运行真机，没有观察其他插件注入后的最终尺寸。

本目录的 `extract.py` 复用已核对的 Objective-C 元数据，依 Mach-O LC_FUNCTION_STARTS 限定每次反汇编范围。`.asm` 文件保存全部本次选中函数；`evidence.json` 保存目标标识、常量与结论。反汇编器显示的 `_Flutter_MMFoundation_BindContext` 标签是剥离符号后的邻近标签，方法名来源于 Objective-C 方法元数据，不能把这个邻近符号误当目标函数名。
