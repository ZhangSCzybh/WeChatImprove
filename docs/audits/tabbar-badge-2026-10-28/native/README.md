# 微信 8.0.78 原生底栏 badge 静态证据

本目录复用项目已选定的微信 8.0.78（build 8.0.78.34）arm64 可执行文件 `/tmp/wechat-8.0.78-inset-analysis/WeChat`，SHA-256 为 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`。与 `docs/evidence/tabbar-native-2026-10-17/manifest.json` 及上一轮授权清理的目标一致。

证据通过 `extract.py` 只读解析 Mach-O 的 Objective-C 相对方法表、chained pointers、类和实例变量表，再由 `disassemble.py` 对 47 个有界函数调用 Xcode `llvm-objdump`。方法起点来自 Objective-C 元数据，终点取下一条 `LC_FUNCTION_STARTS` 记录；不是按 LLVM 显示的最近导出符号推断方法名。`methods.json` 保存每个函数起止地址和文件名。`<setupUI-shapeChangeBlock>` 是从 setupUI 中的 block invoke 地址追加的伪标签，不是原生 Objective-C selector。此轮未启动微信、未执行目标、未打开 REA 分析会话。

## 1. badge 的直接父视图是 item

`MMTabBarItemView` 的父类是 `UIView`；`_imageView` 是 `MMWebImageView`，`_badgeView` 是 `MMBadgeView`。`MMBadgeView` 的父类是 `UIImageView`。见 `metadata.json`。

`-[MMTabBarItemView setupUI]` 为 `0x104727bb4`：

- `0x104727c8c–0x104727ca0` 把 `_imageView` 作为 `x2`，把 `self` 作为 `x0` 调用 `addSubview:`。
- `0x104727dd0–0x104727ddc` 把 `_textLabel` 加到 `self`。
- `0x104727df0–0x104727e18` 从 `+[MMBadgeView smallRedDot]` 取得 badge，写入 `_badgeView`；`0x104727e1c–0x104727e2c` 先设 hidden 为 YES。
- `0x104728154–0x104728160` 把 `_badgeView` 作为 `x2`，把 `self` 作为 `x0` 调用同一个 `addSubview:` selector。
- 随后 `0x104728164–0x104728170` 调用 `relayoutIconAndBadge`。

所以在该原生 setup 路径中 imageView、textLabel、badgeView 是 item 的兄弟视图，badge 添加顺序在后。**“badgeView 是 imageView 的子视图，插件把不同坐标系直接相加”不符合此 8.0.78 静态证据。** 当前 UIKit 替身的层级应以此构建；不能反过来把替身当成原生层级证明。

`-[MMTabBarItemView badgeView]` 为 `0x104729854`，直接读取 `_badgeView`；`getBadgeView` 为 `0x104727954`，也返回原生实例，没有另建视图。

## 2. 原生布局和更新调用链

| 原生方法 | 地址 | 静态观察 |
| --- | --- | --- |
| `relayoutIconAndBadge` | `0x104728808` | 顺序调用 `reloadIconImage` → `layoutIcon` → `layoutBadgeView`。 |
| `layoutSubviews` | `0x104728d90` | 调用 superclass，布局文字，最后调用 `relayoutIconAndBadge`。 |
| `setSelected:` | `0x104728ea0` | 更新选中状态并调用 `relayoutIconAndBadge`。 |
| `setTabBarBadgeValue:` | `0x1047272b0` | 微信维护 unreadCount/badgeString；正数时设置 badge hidden=NO 并 `setValue:`；非正数时 hidden=YES；最后直接调用 `layoutBadgeView`。 |
| `setTabBarBadgeString:` | `0x1047274b8` | 微信维护 badgeString/可见性及 `setString:`；结尾 `0x104727668` 调用 `relayoutIconAndBadge`。 |
| `showSmallRedDot` | `0x104727694` | 清空 unreadCount/badgeString，调用原生 badge `setAsSmallDot`、hidden=NO；最后 `0x104727834–0x104727850` **只调用 `layoutIcon`**。之后是否另有 UIKit layout 是运行时问题。 |
| `removeSmallRedDot` | `0x104727854` | 微信自行维护隐藏规则。 |

当前插件分别 hook `layoutSubviews`、`layoutIcon`、`layoutBadgeView`、`reloadIconImage`、`setSelected:`。每个 hook 都是 `CSTabBarBeginItemUpdate` → `%orig` → `CSTabBarEndItemUpdate`，所以 `layoutBadgeView` 的原生实现没有被吞掉。已有 item state 时最外层 begin 会 restore，原生执行后最外层 end 才 `CSApplyItem`。

**需要区分两个静态调用环境：**从 hooked `layoutSubviews`/`setSelected:` 进入时，外层 depth 包住复合链；从未 hook 的 `relayoutIconAndBadge` 或 `setTabBarBadgeString:` 直接进入时，reload、icon、badge 三个子调用之间各自可能完成 restore/apply。不能把两者写成同一个事务，但仅凭这一结构也不能断言 badge 消失。

## 3. 数字和纯红点使用不同的原生锚点

`-[MMTabBarItemView layoutBadgeView]` 为 `0x104728b94`：

- unreadCount > 0 或 badgeString.length > 0 时，`0x104728c08–0x104728c78` 调用 badge `setY:4`，再把 `getBadgeViewRightMarginPortrait` 的返回值传给 `setX:`。
- `getBadgeViewRightMarginPortrait` 为 `0x104728d64`，返回 **item.width / 2 + 3**。名字中有 rightMargin，实际使用却是 badge 的 x origin；分析以指令和调用为准。
- 两者都为空时，`0x104728c98–0x104728d54` 调用 badge `setY:imageView.y`、`setRight:imageView.right`。
- 该方法没有设置 badge size、hidden、alpha、父视图或裁剪开关。

因此数字和纯红点并非同一个锚点公式。插件当前 `CSApplyItem` 把原生 badge frame 的 origin 加上图标右边和顶边差值，实际是对两种原生锚点统一做平移；静态证据没有证明它必然把每个 badge 移出可见区域。

## 4. customIcon、裁剪与层级的边界

`-[MMTabBarItemView layoutIcon]` 为 `0x10472884c`：存在原生 customIcon 且未挂载时，`0x1047288dc–0x104728904` 将其加入 self；`0x104728910–0x104728938` 随后调用 `sendSubviewToBack:`。原生 customIcon 不应据添加时间直接推断为盖在 badge 上。此方法按 customIcon 的存在决定 imageView/customIcon 可见性，随后布局 imageView 的尺寸、top/bottom、centerX。

在本次核对的 MMTabBarItemView init/setup/layout 方法中未见 `setClipsToBounds:` 或 `setAlpha:`。这不证明运行时父视图永不裁剪：UIKit 默认行为、外部调用、其他插件、CALayer mask 与 presentation layer 都未在此静态边界内。当前插件新背景/描边 surface 由 `insertSubview:atIndex:0` 放到 bar 底层，且插件仅对 bar 级原生背景设置 hidden；这些是源码路径证据，不能替代真实运行层级日志。

## 5. badge frame 不是普通 UIView 的精确赋值

`-[MMBadgeView setFrame:]` 为 `0x11671553c`。它取 `UIScreen.mainScreen.scale`：

- origin 先乘 scale、`frinti`、再除 scale，即对齐到屏幕像素；
- width/height 调 `pixelAlignedCeil:`；
- 最后调用 superclass `setFrame:`。

`setCenter:` 为 `0x116715630`，也结合 frame 与 scale 对齐。插件记录的“希望设置的偏移”可能与原生 getter 返回的“像素对齐后的实际偏移”有分数像素差异。应让 host 测试覆盖此行为；**不能仅凭此差异宣称已经复现了整枚 badge 消失**。

`setAsSmallDot` 为 `0x116714e60`，调用 `updateShape:0`，再 `setCircleDotWithDiameter:8`。后者通过 `UIFont.dynamicLength:` 决定实际直径，然后设置原生 red dot image 和 size。`setValue:` 为 `0x116714774`，默认 `maxCount` 是 99；值、99+ 文案、形状及尺寸归微信维护。`updateWithSize:` 为 `0x1167152d4`，保存原有 center、设置新尺寸、再恢复 center 并布局 badgeLabel；size 变化期间 origin 可以由原生改变。

setupUI 安装的 shapeChangeBlock invoke 在 `0x10472825c`，有界核对见对应 `.asm`，它负责红点曝光/埋点参数，不调用 layoutBadgeView；不能把 shape change 自动等同于同步完整重新布局。

## 6. tab 数量

`-[MainTabBarViewController p_createSlimViewControllers]` 为 `0x104abf754`。该路径创建主界面、通讯录、发现、我对应的四个 controller，并四次 `safeAddObject:`（`0x104abf830`、`0x104abf894`、`0x104abf8f4`、`0x104abf954`）。`p_createTabBarItems` 创建这四个 item。

通用 `-[MMTabBar createTabBarItemViews]` 为 `0x10471f65c`，按 `items.count` 循环创建原生 item view，`tabBarItemCount` 也是数组 count，故不能把静态标准主界面路径外推为所有账号、远端配置和其他插件组合永远只有四项。

当前适配器 `CSTabBarUpdate` 的 `items.count!=4 || bar.items.count!=4` 会 `CSStop` 整体恢复原生；`CSApplyItem` 的 index>=4 是第二层保护。对完整经过 update 的多 tab 路径，静态上不是“只改前四项、第五项保持脏状态”。切换项数组期间具体事件先后仍需 host 回归和设备验收。

## 7. 结论边界

已确定：原生 badge 是 item 的直接子视图、默认在图标与文字之后；原生布局和更新入口确实存在；数字与纯点锚点不同；MMBadgeView 的 frame setter 有像素对齐；标准主 tab 构建为四项，通用组件支持按数组计数。

本目录单独的静态证据**不构成“所有 tab、所有样式角标消失”的已复现根因**。主审计应结合当前适配器可复现的 host 失败路径，或设备日志中的 badge 实例、frame/bounds、superview、祖先 hidden/alpha/clips/mask、z 序与事件顺序，才能对现场现象作根因归因。未从静态证据推导样式必现率，也未把测试替身的层级和渲染结果冒充设备观察。


## 8. 追加核验：autoresizing 与 surface 顺序

原生 `setupUI` 的 `0x104727c64–0x104727c74`、`layoutIcon` 的 `0x104728b64–0x104728b74` 都把 imageView 的 `autoresizingMask` 设置为 1，即 `UIViewAutoresizingFlexibleLeftMargin`；本次 item setup/layout 方法没有对 badge 设置 autoresizingMask。

当前插件在 `CSTabBarUpdate` 中先缩小 `item.frame`，随后在 `CSApplyItem` 记录 `s.imageFrame` 和 `s.badgeFrame`。按 UIKit 的 flexible-left-margin 语义，固定图标宽度和右边距时，item 宽度从 W0 变为 W，imageView.x 会自动增加 W−W0，而未设 autoresizing 的 badge.x 不会一起移动。因此，“图标基线”和“角标基线”可能采自不同的几何阶段。

举例仅为 UIKit 几何推导，**不是设备测量**：native item 宽100、image=(36,8,28,28)、数字badge.x=53；item 缩到40时，image.x自动变为−24，插件目标图标x=6，按当前公式算出 dx=30，于是 badge.x=83，已经越出40宽item。这能证明需要含 autoresizing 语义的 host 探针；它还不能证明现场所有 tab/样式均如此，也不能单独证明被哪个祖先裁剪。反复同尺寸往返未必累计；随后原生 item layout 会再次居中图标，因此应分别测“首次改item尺寸、尚未原生重排”和“已原生重排”的阶段。

`MMTabBar.createTabBarItemViews` 为新 item 调用的是 `addSubview:`（`0x10471f868–0x10471f874`），在末尾加入；不是 `insertSubview:atIndex:0`。复用已有 item 的路径不重排。`relayoutTabBarItems` 只设置frame并通知delegate，未改item z序。`MMTabBar.layoutSubviews` 把原生 background 送到底部，并未把 item 送到 plugin surface 后面。**本次有界静态证据未发现原生重排使已有 plugin surface 覆盖 item 的具体路径**；不能只因 CSRenderSurface 不重复sendBack 就判定该假说成立。

追加核对 `MMBadgeView.innerSetCircleShape`（`0x1167149c4`）、`innerSetBadgeShape`（`0x116714ae4`）、`badgeLabel`（`0x1167157f8`）。内部 label 的位置来自 badge.width/2、height/2；这几条相关路径中未发现把外部 frame.origin 当内部内容坐标的用法。setValue 的 shape 更新走上述曝光埋点 block，没有重入 item layout 的证据。
