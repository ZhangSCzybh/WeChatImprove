# 2.0-20：折叠入口跟随列表圆角卡片

按用户澄清，以“折叠入口必须使用同一套圆角卡片”为验收标准。已直接查看原图、左上角基准、折叠入口放大图及入口裁切。浅灰色是卡片周围的既有列表画布；2.0-19 将列表下方改白的处理在本版纠正，不再把浅灰画布当作缺陷。

## 根因与排除

1. **入口是实际投影行，并非 footer。** `CSGroupProjection.m` 为 `chatroom_session_box` 生成带 `foldedEntryScoped` 的聚合行；`CSGroupListAdapter` 仍经原生 `cellForRowAtIndexPath:` 取得 cell，然后执行 `CSCloseFriendUpdateSessionCover`。测试用真实投影证实两条普通会话加一个入口，共三行。
2. **截图中的卡片被整行保护层遮住。** 2.0-18 的 `CSCloseFriendUpdateSessionCover` 隐藏 cell 的全部子视图（含卡片），再在 cell 上绘制铺满宽度的不透明单行标题。可在 [2.0-18 实现副本](../folded-entry-visual-2.0-19/before/Controllers/CSCloseFriendSessionPresentation.m) 中复核。2.0-19 在原生视图结构匹配时改为透明双行显示，但未知结构的回退分支仍隐藏整行，遮住卡片。本版让该回退也绘制在共享卡片内。
3. **缺少折叠行的独立卡片边界。** `CSGroupCardPosition` 原先只用 section 首尾判定。普通会话与折叠入口被当成连续的一张卡片，前一行没有收底，入口上方也没有独立间隙。并不是“中间行不画背景”：原渲染器即使 `first=NO,last=NO` 仍绘制矩形卡片背景。
4. **关闭开关缺少已有样式清理。** 旧的装饰与布局入口遇到 `enabled=NO` 直接返回，已经创建的背景、边距和分隔线隐藏状态可能保留。现增加可逆清理，并验证同一个 cell 的开启、关闭、再次开启和复用。

未发现按内容高度计算的整张白色列表容器。卡片背景由每个 cell 独立持有，列表下方是 table / backgroundView 的画布。不存在通过把白色容器拉高来修复的问题。

## 原生结构核实

对本地微信 8.0.78 二进制做了只读静态核实，目标与 SHA256 见 [native/manifest.json](native/manifest.json)。本轮使用 REA 确认目标，再通过现有 Mach-O 解析与有界 `llvm-objdump` 提取类结构和方法；未做真机运行捕获。

- 主列表 `NewMainFrameViewController tableView:cellForRowAtIndexPath:` 的已检查实现构造 `NewMainFrameCell` 等；没有证据把本次问题归咎于入口改用了 `MainFrameAggregationCell`。
- `NewMainFrameCell` 有 `m_itemView`；`MainFrameAggregationCell` 是其子类，另有 `_itemView`。二者类型均为 `MainFrameItemView`。兼容读取必须检查对象 ivar 类型和实际视图层级，不硬编码偏移。
- `MainFrameItemView` 有 `m_frameHeadView`、`m_nameLabel`、`m_messageLabel`；`MMCPLabel` 继承 `MMUILabel`。正常结构保留原生图标和文字位置。
- 已确认原生有 `heightForRowAtIndexPath:`；不为未证实存在的 `estimatedHeightForRowAtIndexPath:` 增加 `%orig` 钩子。

[类结构](native/layout.json)、[方法清单](native/methods.json) 和有界反汇编保存在 `native/`。这些证据限定于该二进制，不能替代用户设备的实际层级验收。

## 修改范围与行为

- `CSGroupListAdapter.h/.m`：仅调整 `CSGroupCardPosition` 的外观角色计算。折叠行独立成卡；紧邻其前的普通行收底，后一行重新起顶。保持已有原生/显示坐标映射，不改分组成员、折叠投影或角标计算。
- `CSListCornerSessionAdapter.h/.m`：继续使用共享配置和渲染器；需要间隔时在原生行高之上增加 `normalGap`，不挤压原生内容。卡片内的原生 item 跟随实际边距坐标，并保留原生 frame 供关闭时恢复。
- `CSListCornerPageContext.h/.m`：共享卡片使用现有 `enabled`、`radius`、`leftMargin`、`rightMargin`、`backgroundForStyle:` 和 `normalGap`。浅色画布保留现有 0.929 灰色，深色画布为黑色。记录本插件施加的颜色、分隔线及坐标，关闭时移除卡片并恢复；若原生已重绘颜色，不用旧快照覆盖新颜色。
- `CSCloseFriendSessionPresentation.m`：原生结构匹配时保留实际图标，透明中性双行显示位于原生内容内；结构未知但已有共享卡片时，兼容显示位于卡片内，保留圆角与边距。结构未知且圆角关闭时使用保守的平面中性保护。未知结构不猜图标、不展示原生全局摘要。
- `ListCornerRadiusHooks.xm`：原生行高加共享间隙；布局后修复现有卡片及保护显示；复用前移除旧保护和卡片。布局修复使用已建立的行角色，不从 layout 中重查行号、重载列表或添加定时器。
- 中性标题为“折叠的聊天（N）”，摘要为“N 个会话”。账号或隐私代次过期时不沿用旧数量。继续隐藏其他分组的末条消息、时间与全局未读；不改原生数据模型。
- 版本、当前文档和内置更新说明同步到 2.0-20。圆角设置页既有的“保存后重启”交互保持原样；已有 cell 的关闭清理和布局更新也有核心测试覆盖。

正常布局中，独立折叠卡片的内容高度与原生行高一致；table 行高会额外包括上方配置间隙，例如原生内容 76 + 间隙 10 = 行高 86。没有普通行在其前时不多加顶部间隙。

## 失败复现与核心回归

先加集成回归再改生产代码。测试把真实分组投影、实际 `CSGroupCardPosition`、共享配置、卡片渲染、提取的布局/行高 Hook 和真实保护显示放在同一个 host cell 上执行；同时覆盖已知原生结构和未知结构回退。

旧实现 **929 项中 32 项失败**，涉及独立间隙、前后圆角、卡片被遮挡、配置联动、关闭残留和画布颜色。结果见 [red-cards.log](red-cards.log)。修复后增加关闭再开启与重复原生 setter 的边界检查，最终如下：

| 脚本 / 范围 | 检查数 | 结果 |
| --- | ---: | --- |
| `Tests/verify-list-corners.sh`：共享圆角、真实投影及保护层集成；同宽边距、独立间隔、前后圆角、半径与深色配色、开关清理、重建、复用、短列表/空列表 | 938 | 0 失败 |
| `Tests/verify-close-friend-session.sh`：会话/折叠投影、点击映射、隐私门禁 | 85 | 0 失败 |
| 同脚本：折叠双行显示、原生图标、延后原生布局、账号/隐私代次与复用恢复 | 32 | 0 失败 |
| **总计** | **1,055** | **0 失败** |

最终日志：[卡片](green-cards.log)、[会话与显示](green-session.log)。只运行上述两个相关脚本，没有全量回归。测试使用 UIKit host 替身，验证真实生产逻辑、层级和几何，不声称已经取得 iOS 真机渲染结果。

## 构建与交付检查

基于当前工作区构建，使用独立 Theos 缓存，顺序打包 rootful / rootless，不执行 `make clean`。构建位置见 [build-environment.json](build-environment.json)，日志为 [rootful](build-rootful.log)、[rootless](build-rootless.log)。

[verify-packages.py](verify-packages.py) 核对版本、deb 架构、安装前缀、arm64/arm64e 切片、修复函数和 Hook、测试替身排除、dSYM UUID 及 `CSPluginStorageLoad` 首初始化顺序，并核对本轮基线的 47,386 个既有文件与历史包。结果保存在 [packages.json](packages.json)、[preservation.json](preservation.json)，源文件摘要见 [source-sha256.json](source-sha256.json)。

## 真机验收

1. 安装对应包，完全退出再打开微信。在“群聊”分组保留两条普通会话和一个可见折叠会话。开启圆角：入口应是独立卡片，与普通会话同左右边距、同底色，上下四角完整；前一会话卡片底部圆角完整，两张卡片之间有配置的普通会话间隙。
2. 将圆角半径分别设为较小和较大值，例如 8、24；分别调整左右边距和浅/深色卡片颜色，按设置页提示生效。普通会话与折叠入口必须同时使用新配置，入口不能残留旧白色矩形或固定宽度。
3. 关闭圆角并按提示重启：入口恢复原生平面观感，没有旧卡片或残留左右缩进；再次开启后恢复卡片。长列表滚动复用、返回短列表后重复检查。
4. 切换微信实际生效的浅色/深色模式。卡片与文字跟随对应配色，画布保留相应浅灰/深色；短列表下方的画布是正常样式，不要求涂成卡片白色。
5. 检查仅有折叠入口的组和确认无可见会话的空分组：前者完整独立卡片，不额外增加顶部间隔；后者隐藏入口，不留下空白卡片。
6. 入口保留原生图标及标题/摘要两行，摘要是当前组“N 个会话”。让其他分组产生消息/未读，再切组、隐藏密友、打开折叠页并返回，不能泄露其他分组末条消息、时间和全局未读；点击仍进入当前组的折叠会话。

若设备仍显示不一致，需要当前微信版本、圆角半径/左右边距/颜色设置，以及浅色、深色的完整列表截图；未知私有视图结构的兼容显示可能不保留原生图标，但仍必须保留卡片和中性摘要。
