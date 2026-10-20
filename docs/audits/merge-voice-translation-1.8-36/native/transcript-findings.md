# 展开语音转写的占位证据

目标为微信 8.0.78（build 8.0.78.34）的既有本地可执行文件 `/private/tmp/wechat-8.0.78-inset-analysis/WeChat`。SHA-256 为 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`，UUID 为 `9CD58B8E-B7AB-3487-ADBD-2AC0AA16A5DE`。依据 Objective-C 元数据定位方法，并用 LC_FUNCTION_STARTS 限定反汇编范围。这里只给出静态原生证据，没有真机运行结果。

## 首次测量已经包含完整转写框

`VoiceMessageViewModel.measureContentViewSize:`（`0x10628d230`，完整输出见 `quick-tip/`）返回 `voiceNodeWidth` 与 `voiceNodeHeight`。

`VoiceMessageViewModel.voiceNodeHeight`（`0x10628dbd4`）先计算语音主体高：`2 * text_message_margin_top + ceil(systemFont.lineHeight)`；完成转写的路径再计入转写框及 4pt 内部间隔。关键位置如下：

| 地址 | 行为 |
| --- | --- |
| `0x10628dcf4`–`0x10628dcfc` | 主体高度公式。 |
| `0x10628dd24`–`0x10628dd34` | 单独检查加载状态。 |
| `0x10628de1c`–`0x10628de2c` | 检查 `canShowTranslateText`。 |
| `0x10628de30`–`0x10628de60` | 根据原生转写结束状态选择文字尺寸。 |
| `0x10628de64` | 累加文字高度。 |
| `0x10628def8`–`0x10628defc` | 累加两侧文字内边距。 |
| `0x10628df1c`–`0x10628df20` | 加入 4pt 内部间隔。 |
| `0x10628df24` 之后 | 检查二次语言翻译等其他状态。 |
| `0x10628e320`–`0x10628e444` | 完成转写框最小高度保护。 |

对本次放行的普通完成转写状态，可将总高理解为：

```text
主体高 + 4pt + max(转写文字高 + 2 * 文字纵向内边距, 主体高)
```

插件直接使用微信已缓存的 `contentViewSize`，不能再添加一次转写高度。`translatedTextSize` 和 `displayTextSize` 会进入原生富文本测量，因此插件不主动调用它们；测试替身把这些方法设为失败哨兵，防止滚动路径意外重复测量。

## 转写框底边就是整条内容底边

`VoiceMessageCellView.createTranslateView`（`0x10627c3d8`）在 `0x10627c53c`–`0x10627c54c` 将转写框 Y 设为主体高 + 4，`0x10627c68c`–`0x10627c690` 给出初始最小高度，`0x10627c698`–`0x10627c6ac` 创建矩形。

`VoiceMessageCellView.setTranslateText:`（`0x106288280`）在 `0x10628832c`–`0x106288338` 取得文本高度，在 `0x1062883e8`–`0x1062883ec` 加入两侧内边距，在 `0x106288688`–`0x10628869c` 保留最小高度，最终在 `0x1062887c8`–`0x1062887d0` 更新框尺寸。

因此，合并规划下边界应使用完整内容高度，不能从转写框底边继续减去上方语音气泡的透明底边距。气泡顶部仍沿用原模板透明边距。2pt 是相邻消息间的逻辑距离，语音主体与自身转写框之间原生的 4pt 不变。

## 安全与兼容边界

仅放行精确 `VoiceMessageViewModel` 的 `canShowTranslateText`，原有首次几何适配仍限制在 8.0.78。加载中、二次语言翻译、方言反馈及其他附属布局继续保留原生安全空间。未确认版本、派生模型、缺失/非有限尺寸均不据此猜测紧密高度。

转写框继续参加既有两层、非递归的真实子视图边界检查；越界时允许安全扩展，后续子视图缩小不触发二次收紧。展开、收起和文字实际变化是原生测量输入变化，可在下一次行高请求中重新确定布局。

反汇编中 `_Flutter_MMFoundation_BindContext` 是剥离符号后的邻近标签，不能把它当作目标方法名；方法身份来自保存的 Objective-C 元数据。
