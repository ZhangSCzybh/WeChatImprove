# 2.0-21：恢复 2.0-20 后修正折叠行布局

本轮按用户要求先恢复并验证 2.0-20，再修改标题、摘要和卡片首末规则。已查看原图 `docs/feedbacks/2026-10-27-folded-card-title-truncated.jpg` 及两张裁切图。截图中的折叠行把前后连续会话分成三段，标题截断、摘要明显偏右，均与代码和失败用例相符。

## 任务 1：恢复证据

恢复源为 `../rollback-to-2.0-18-2026-10-27/execution/source-before-rollback.zip`，没有凭记忆重写，也没有执行 Git 全局重置。

- 从 ZIP 恢复 23 个文件，包括回退时移出的 `Tests/FoldedEntryVisualTests.h`、`Tests/FoldedCardIntegrationTests.h`。
- [逐文件 SHA256 与字节比较](restore/zip-comparison.json)：23 / 23 一致。
- [完整清单比较](restore/manifest-comparison.json)：与 2.0-20 报告中的 557 个文件全部一致，无差异。
- 当时的 control、版本常量、发布说明、README 均为 2.0-20，之后才更新为交付版 2.0-21。
- 使用独立构建目录编译恢复后的原始 2.0-20，arm64 / arm64e 通过；警告与原 2.0-20 rootful 构建相同，12 条、0 新增。见 [编译校验](restore/build-verification.json) 和 [完整日志](logs/restore20-build.log)。
- 恢复前工作区的对应文件已另存 [workspace-before-restore.zip](restore/workspace-before-restore.zip)。此次不重新发布或覆盖 2.0-20 成品。

## 两处根因及修复范围

**标题与摘要。** `CSCloseFriendSessionPresentation.m` 的 `CSFoldedLayoutLabel` 原本直接复制原生 label 的整个 frame。原生聚合标题可以只有适合旧标题的窄宽度，摘要也有自己的偏移位置，复制后不能容纳带组内数量的完整新标题。新 UILabel 没有显式缩字设置，空间不足时出现尾部省略号。这是手动 frame 布局，不是 Auto Layout compression resistance 竞争。标题字符串及分组数量本身正确。

修复仅让两行共用标题左边缘至内容区右侧（保留 12 pt 右内边距）的可用宽度；仍取原生 label 的纵向位置、高度、字体和颜色。两行明确左对齐、单行且不使用省略模式，按测量后的文本宽度设置最小缩放比例；可用空间缩小时完整缩字，变宽后恢复正常大小。被隐私层隐藏的全局时间、未读区域不再占据中性标题宽度。

**独立卡片与间隙。** `CSGroupCardPosition` 把折叠行同时判成 first / last，并把前行判为 last、后行判为 first；`separate` 标记又驱动行高增加 normalGap 及卡片内部 y 偏移。因此折叠行会切断同一个 section 的卡片。

修复按普通行处理折叠行：仅 row 0 为 first，row count−1 为 last。删除只为独立折叠卡片引入的 separate 参数、separated 状态、额外行高 helper 和行高 hook；保留既有 section 间距规则。保留共享圆角配置、颜色、边距、原生图标、关闭圆角的完整清理，以及 cell 复用/内容容器替换的处理。

生产改动收敛在上述展示、分组首末判定及配套声明和 hook；未改分组成员投影、未读角标、隐私策略、选择器或存储。完整 [2.0-20 → 2.0-21 差异](changes-from-2.0-20.diff) 与 [逐文件前后 SHA256](changes-from-2.0-20.json) 包含 20 个文件（8 个布局相关实现/声明文件、5 个版本/说明文件、7 个相关测试文件）。最终工作区为 2.0-21，恢复完成时与 ZIP 一致的记录在 restore/ 下单独保留。

## 先失败、再修复

在改动生产代码之前，核对 343 个生产/构建文件仍与 2.0-20 清单一致；新增测试运行真实生产模块、提取的实际 hook 和分组角色函数，使用主机 UIKit 替身，不连接微信。

[失败验证记录](red-verification.json)、[当时测试源码](red-tests.zip)：

| 失败阶段 | 检查数 | 失败数 | 日志 |
| --- | ---: | ---: | --- |
| 卡片/折叠展示 | 1,004 | 37 | [red-cards.log](logs/red-cards.log) |
| 会话逻辑 | 85 | 0 | [red-session.log](logs/red-session.log) |
| 标题/摘要/隐私展示 | 36 | 6 | [red-session.log](logs/red-session.log) |

标题测试刻意设置窄原生标题框和偏移摘要框，除了验证完整字符串，也用 CoreText 的实际字形度量验证可用宽度/缩放是否能容纳全文。卡片测试覆盖折叠行在首、中、末位置，使用非恒等 native/display 路径映射，检查真实 mask 的相邻边角、相邻背景几何和原生行高；normalGap 设置为非零，确保旧实现确实暴露多余间隙。

仅运行两个相关脚本，没有运行全量：

| 最终回归 | 检查数 | 失败数 | 日志 |
| --- | ---: | ---: | --- |
| `bash Tests/verify-list-corners.sh` | 1,020 | 0 | [green-cards.log](logs/green-cards.log) |
| `bash Tests/verify-close-friend-session.sh`：会话逻辑 | 85 | 0 | [green-session.log](logs/green-session.log) |
| 同一脚本：展示/隐私 | 37 | 0 | [green-session.log](logs/green-session.log) |
| **合计** | **1,142** | **0** | |

覆盖浅色/深色、已识别和未知原生视图结构、标题全角括号与多位数量、窄宽度缩字后恢复、摘要左对齐、圆角半径/非对称边距/配色变更、关闭再开启、重复原生布局、普通与折叠 cell 互相复用，以及空分组隐藏入口。主机检查验证布局合同和生产逻辑，不能代替设备上的 UILabel 和微信布局最终视觉验收。

## 编译、包校验与保留

2.0-21 rootful / rootless 均编译 arm64 与 arm64e。每种方案仍有原 2.0-20 的 12 条警告（历史 API 弃用和 obsolete linker 参数），新增警告为 0。详见 [双包编译校验](build-verification.json)、[rootful 日志](logs/build-rootful.log)、[rootless 日志](logs/build-rootless.log)。

[包校验](packages.json) 验证版本、Architecture、rootful/rootless 安装前缀、两个 Mach-O slice、dSYM UUID、存储初始化器顺序、旧间距 hook 缺失和测试替身未混入。校验完成后仅以不存在的新文件名发布到 packages/；[verify-release.py](verify-release.py) 是本轮单次校验/发布脚本，已有交付文件时会拒绝覆盖。

[保留记录](preservation.json)：原有 packages 下 42 个文件、历史审计 2,926 个文件、工作区 .theos 下 1,173 个文件 SHA256 均不变。全部历史 2.0-20 deb 和 symbols 完好，未执行 make clean。packages 仅新增以下 3 个文件：

- [com.wechat.improve_2.0-21_iphoneos-arm.deb](../../../packages/com.wechat.improve_2.0-21_iphoneos-arm.deb)，1,289,190 B
  SHA256：`06e2987ebd561dda14ee7ba0b995d8b943e475f90c536a2d3a5e5e2b6cbc9fd5`
- [com.wechat.improve_2.0-21_iphoneos-arm64.deb](../../../packages/com.wechat.improve_2.0-21_iphoneos-arm64.deb)，1,289,308 B
  SHA256：`8b5d8c3af8c0fde39cb5af102c67ab88655c277202ac82006fc7b348a7139713`
- [com.wechat.improve_2.0-21_symbols.zip](../../../packages/com.wechat.improve_2.0-21_symbols.zip)，9,818,179 B
  SHA256：`d9c25b3c57d03bea62f4cf0902f076ad0074ca71daeda5725f06079b53888948`

## 真机验收步骤

1. 安装对应环境的 2.0-21 包，完全退出并重新打开微信，确认插件版本为 2.0-21。使用现有会话和分组，不重置配置。
2. 进入与录屏/截图相同的分组，包含 4 个可见折叠会话时应显示完整“折叠的聊天（4）”，第二行“4 个会话”与标题左边缘一致。切组后数量更新，不能出现其他分组消息、时间或全局未读。较窄屏幕/较大左右边距时应缩字而不是出现省略号。
3. 分别查看折叠行在同一 section 中间和末尾的情况：中间行与上下会话无额外间隙、上下接缝没有圆角；末尾折叠行只承担整组下圆角，前一行不能提前收底。整组第一行保留上圆角；只有一行的 section 可同时有上下圆角。原有置顶/普通 section 之间的间距保持正常。
4. 在浅色和深色下分别修改圆角半径、左右边距和卡片配色；折叠行应与相邻会话一起变化。关闭圆角后回到平面样式、没有残留卡片，再开启仍为连续分组。
5. 上下滚动触发 cell 复用、往返切换分组；标题不恢复成截断状态、摘要不偏移、普通会话不残留中性文字。短列表仍连续成卡；无可见折叠会话的空分组不出现假入口。

尚未在真机安装本轮产物，以上为需由设备确认的验收步骤。
