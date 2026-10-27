# 2.0-19：折叠入口外观与短列表背景

本轮直接查看了用户提供的原图、入口裁切和下半区裁切。修复限定在会话列表背景及折叠入口显示层；分组投影、折叠数据源、角标计算、会话点击映射不作调整。构建使用本工作区及独立 Theos 缓存，不清理既有构建文件和历史包，不连接真机或改动账号数据。

## 根因与证据

1. **短列表下方灰底来自覆盖可视区的 `table.backgroundView`。** `CSListCornerPrepareTable` 原先将 table 本身设为会话配色，却把它的 backgroundView 固定设为 `CSListCornerCanvasColor()`（0.929 灰色）。普通会话的白色是逐个 cell 的卡片，由 `CSListCornerOwnedBackground` / `CSListApplyCardBackground` 绘制；没有一个按内容高度计算的白色列表大容器。最后一个 cell 之后露出灰色 backgroundView，正好形成截图中的整齐断层。空分组也会暴露同一背景。
2. **折叠入口一直是真正的原生 cell，不是 section footer。** `CSGroupListAdapter` 调用原生 cell renderer 后再调用 `CSCloseFriendUpdateSessionCover`。2.0-18 的 cover 隐藏整个 cell 的所有子视图，再直接添加一个铺满 cell 的不透明视图和单行标题。这遮住了原生图标、摘要、卡片边距与分隔线，并未修改原生行高；视觉上因此像一行裸文字。
3. **子视图的布局回调可能晚于 cell。** 改为保留原生图标后，单靠 cell 的 layout 回调不足以防止 `MainFrameItemView` 自己的后续 layout 再次显示全局摘要、时间、未读。新增针对性失败用例确认这一时序，需要在原生 item layout 完成后再更新已有的保护显示。

原始实现副本保存在 [before](before/)；本轮红灯结果为 [显示测试](red-session.log)、[背景测试](red-appearance.log)、[子视图后续布局](red-item-layout.log)。截图见 [原图](../../feedbacks/2026-10-26-folded-entry-visual.jpg)、[入口区域](../../feedbacks/crop-folded.png)、[下半区](../../feedbacks/crop-lower.png)。

## 修改

- `Controllers/CSListCornerPageContext.m`：会话 table 与 backgroundView 使用相同的当前配色。默认浅色白色、深色沿用现有会话深色配色；用户自定义颜色继续生效。其他页面保留各自原有画布色。
- `Hooks/ListCornerRadiusHooks.xm`：主会话控制器布局后同步背景，即使没有 cell、原生替换了 backgroundView 或切换主题也能更新。不改背景视图尺寸，不查询行数，不调用 reload，不新增定时器。
- `Controllers/CSCloseFriendSessionPresentation.m`：从已存在的 `m_itemView`、`m_frameHeadView`、`m_nameLabel`、`m_messageLabel` 读取原生视图；先检查 ivar 类型、UIView 类型及实际层级，不猜私有参数。保留原生图标、外层 card/内容容器/分隔线和行高；仅隐藏 item 内的原生业务内容，包括头像分支内的 unread badge。在原生标题/摘要的位置添加透明、不可交互的两行中性显示，字体和颜色跟随原生 UILabel。
- 标题为 `折叠的聊天（N）`，摘要为 `N 个会话`。未知数据或账号/隐私代次已经变化时不继续显示旧数量，使用“折叠的聊天”。不显示或复制最后消息、时间、全局未读；不修改原生消息模型和原生 label 文本。复用时恢复已记录的隐藏状态和无障碍属性。
- `Hooks/SessionGroupHooks.xm`：原生 `MainFrameItemView.layoutSubviews` 完成后，仅刷新已有折叠显示层的所属 cell。防止原生后续布局把全局信息重新显示出来。
- 版本、发布说明和当前包链接统一为 `2.0-19`。

当前头文件的原生层级依据在 `HeadersFile/NewMainFrameCell.h` 和 `HeadersFile/MainFrameItemView.h`。如果其他微信版本改变这些私有视图结构，读取校验失败时使用两行中性整行保护作为兼容回退；此时不凭空拼装或猜测原生图标。正常匹配时保留实际原生聚合图标。该回退优先保护摘要隐私，需要真机截图才能进一步适配未知结构。

## 核心回归

先加测试后改生产代码：

- 旧 2.0-18 实现：显示测试 31 项中 **7 项失败**；列表外观 901 项中 **15 项失败**；既有会话逻辑 85 项通过。证明原生图标/双行排版及短列表背景缺陷。
- 第一版修复后，再加入原生子视图延后布局检查：32 项显示测试中 **2 项失败**，证明不能只在 cell layout 中修复。
- 最终：仅运行两个相关脚本，无全量回归。

| 脚本 / 测试内容 | 检查数 | 结果 |
| --- | ---: | --- |
| `Tests/verify-close-friend-session.sh`：会话投影、折叠入口数量及隐藏、点击坐标、密友门禁 | 85 | 通过 |
| 同脚本：折叠显示、双行位置、原生图标/卡片/行高、原生布局重新显示、隐私/账号代次、复用恢复 | 32 | 通过 |
| `Tests/verify-list-corners.sh`：列表外观及共享外观函数；含 0/3/40 行、圆角开关、浅/深色切换、背景替换 | 901 | 通过 |
| **总计** | **1,018** | **0 失败** |

最终日志：[会话与显示](green-session.log)、[列表外观](green-appearance.log)。这些是编译真实生产源码与提取 Hook 的 host 替身测试，验证层级、状态和布局坐标，不等同于 iOS 真机截图验收。

## 构建与包校验

rootful、rootless 使用 [build-environment.json](build-environment.json) 中的独立缓存，顺序执行 `make -j4 package`，没有执行 `make clean`。日志为 [rootful](build-rootful.log)、[rootless](build-rootless.log)。

[verify-packages.py](verify-packages.py) 检查 deb 版本/架构/安装前缀、arm64 与 arm64e、生产函数及布局 Hook、测试替身未混入、dSYM UUID、存储迁移首初始化顺序，并核对本轮之前的文件与历史包是否保持不变。结果见 [packages.json](packages.json)、[preservation.json](preservation.json)；生产源码摘要见 [source-sha256.json](source-sha256.json)。

## 真机验收

1. 在与截图相同的列表外观设置下，切到只有两条普通会话及一个折叠入口的群聊组。入口下方直到 tabbar 上方应与会话配色一致，不再整块灰底。关闭圆角设置后再检查一次。
2. 折叠入口应保留微信原生聚合图标，行高与普通会话一致；标题“折叠的聊天（1）”、摘要“1 个会话”分别位于原生两行位置，卡片边距/分隔线遵循同列表的样式。
3. 切到确认没有可见折叠会话的空分组：入口隐藏、可视区背景正常。切到长列表并滚动，让 cell 复用，再返回短列表，不应遗留遮罩或额外白色矩形。
4. 保持此页，切换微信实际生效的浅色/深色外观，再切回。背景和文字颜色应随当前会话主题更新；深色下不应出现白色入口或浅灰大块。自定义会话背景时检查普通 cell、入口及列表下方配色一致。
5. 让另一个分组的折叠会话产生消息和未读，当前分组入口只显示自己的中性数量，不能出现另一组的摘要、时间或全局未读。隐藏密友、切组、进入/退出折叠页及滚动后重复观察。
6. 点击折叠入口应进入当前分组的折叠列表，返回正常。VoiceOver 不应读出隐藏的原生全局摘要。

未连接真机，本轮不声称已经完成设备渲染验收。若仍有异常，请提供当前微信版本、列表圆角开关及配色设置、浅/深色的完整列表截图，以核实实际原生视图结构。
