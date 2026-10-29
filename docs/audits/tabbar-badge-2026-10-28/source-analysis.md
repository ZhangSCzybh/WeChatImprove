# 底栏原生角标：2.1-6 源码审计

日期：2026-10-28。基线是当前工作区 2.1-6 授权清理后的源码。本文记录源码事实，并在补充核对本目录 `native/README.md` 的微信 8.0.78 静态证据后修正候选范围；不以 host 替身层级代替微信真实层级。未修改生产源码或测试。

以下行号取自本轮修改前的基线。`Hooks/TabBarStyleHooks.xm` SHA-256 为 `a30fdb29e98707a944f2bdb2f020fdee7e8ecdcd29bc863a580140a85f7a5617`，`Controllers/CSTabBarNativeAdapter.m` 为 `7eeac3627d62361d93a6bcdb8c3c00dc236286fb355c51455eaae4a71659374c`。

## 1. 可以确认的调用顺序

`Hooks/TabBarStyleHooks.xm:66–84` 为 `MMTabBarItemView.layoutSubviews/layoutIcon/layoutBadgeView/reloadIconImage/setSelected:/setTitle:` 都保留 `%orig`，且顺序均为 `CSTabBarBeginItemUpdate → 原生实现 → CSTabBarEndItemUpdate`。原生 `layoutBadgeView` 没有因为启用样式而跳过，也没有用插件实现替换原生 badge 内容/显隐。

`Controllers/CSTabBarNativeAdapter.m:525–534` 中，已样式化 item 在最外层 Begin 将 `depth` 从 0 加到 1 并 `CSRestoreItem`；嵌套的原生布局继续累加深度，只有最外层 End 减回 0 才尝试 `CSApplyItem`。原生 layoutBadgeView 若嵌套在 layoutSubviews/layoutIcon 等调用里，不会逐层反复叠加样式偏移。

`Hooks/TabBarStyleHooks.xm:5–15、51–63` 对 bar/controller 布局也使用 Begin/End。`Controllers/CSTabBarNativeAdapter.m:516–524` 在最外层 bar Begin 恢复原生几何，所有原生布局执行完后才 `CSTabBarUpdate`；`CSApplyItem:169–170` 在 bar `depth>0` 时直接返回。由此，**bar 布局内 item 的 End 不会提前把原生 frame 换成样式 frame**。最终顺序是 bar 恢复 → 原生 bar/item 布局 → bar Update 恢复/采样/应用样式。

目标静态实现已经补齐顺序：`relayoutIconAndBadge` 顺序调用 reloadIconImage → layoutIcon → layoutBadgeView；数字更新最后调用 layoutBadgeView，字符串更新调用 relayoutIconAndBadge，纯点更新最后仅调用 layoutIcon（见 `native/README.md` 第 2 节）。后者是未 Hook 的复合入口时，各子 selector 之间可以分别完成 restore/apply，不能等同于存在一个包住整条链的 depth。静态调用链不等于在用户设备观察到了对应事件频率。

## 2. apply / restore 的坐标假设

`Controllers/CSTabBarNativeAdapter.m:179–184` 每次 apply 先 restore，再采样 image/text/badge 的当前 frame。`197–205` 计算新图标 frame，`208–212` 对原生 badge 加以下偏移：

```text
dx = newImageFrame.maxX - nativeImageFrame.maxX
dy = newImageFrame.minY - nativeImageFrame.minY
badge.origin += (dx, dy)
```

这里没有 `convertRect:`、没有查看 `badgeView.superview`。本轮补充静态证据已将目标的父子关系核清：`-[MMTabBarItemView setupUI]` 的 `0x104727c8c–0x104727ca0` 把 image 加到 self，`0x104728154–0x104728160` 把 badge 加到同一个 self；badge 在后添加。见 `native/README.md` 第 1 节与对应 `.asm`。

**对微信 8.0.78 此 setup 路径而言，image 和 badge 均为 item 直接子视图，frame 同属 item 坐标；“badge 是 image 子视图、父移动被重复加一次”的初始候选已排除。** 隐藏 native customIcon 也不会因父子关系而隐藏 badge。公式表达“原生 badge 相对 image 右上角的差值保持不变”，在同一采样时点有几何含义。另一个实际缺口是采样发生在 item frame 改小、image 已自动调整之后，见第 10 节。

`CSRestoreItem:163–165` 从当前 badge frame 减去 `s.badgeOffset`，不覆盖当前 size；`CSApplyItem:208` 从采样 frame 开始，同样不改 size。对原生非零 size 的同一对象、且中间没有原生直接重设 origin 的一对一 apply/restore，代数上不会把 size 设成 0，也不会逐轮累计偏移。保留当前 size 也保留原生从一位数变为 `12/99+` 时更新的宽度；不能把“不恢复 size”本身视为错误。

已确认的生命周期边界是：微信 `MMBadgeView.updateWithSize:` 保存 center、改变 size、再还原 center，所以数字/点大小变化会在 item 的 layout Hook 之外改写 origin。`setTabBarBadgeValue:` 在改变 size 后会调用 hooked layoutBadgeView，可重新确定数字位置；`setTabBarBadgeString:` 调用复合 relayout；`showSmallRedDot` 改 shape/size 后仅调用 hooked layoutIcon，没有紧接着调用 layoutBadgeView（`native/README.md` 第 2、5 节）。若变化发生于 styled 状态，restore 仍减旧 offset，不能等同于精确回到某个历史 badgeFrame。item state 目前没有 badge 对象身份，也没有记录已应用 frame；不过本轮 native getter/setup/setter 证据没有证明微信日常更新会替换对象，不能捏造“新对象必被错误恢复”。这些时序缺口有待 host 复现或日志进一步归因，不能直接外推所有 badge 消失。

## 3. 自定义图标、裁剪与层级

`CSApplyItem:186–205` 对每个 tab 的所选/未选中配置分别取图。自定义图使用原 imageView，改 image 和 `ScaleAspectFit`，不创建新图标 view；已有 native customIcon 在此分支被隐藏。自定义图尺寸以 25×25 作为基数，按同一 `factor` 计算 imageView 的 frame；系统图用采样的 native image frame size。`scale` 是底栏宽度系数，不是自定义图片独立尺寸系数。

角标位移使用最终图标 frame 的右上角，因此**在 badge 与 image 共用 item 坐标的前提下**，图标选择、自定义图、隐藏文字都会影响锚点，代码并没有漏掉这些分支。风险在真实坐标契约和可见区域，不是代码完全没按新图标大小计算。

`CSTabBarUpdate:453` 将 **bar** 的 `clipsToBounds` 设为 NO。它没有修改 item、imageView、button 或 badge 各自的 clipsToBounds。`434–440` 的祖先裁剪防护只验证 floating rect，不验证超出 item/floating rect 的 badge。一个较宽的 `99+` 若被定位到 item 右侧以外，源码没有额外保证该区域不被 item 或更深父视图裁剪。是否真的会裁剪，需要真实父链、clips 值和原生 badge 尺寸；不能把替身默认 clips=NO 当成真机事实。

自定义图标分支 `189` 会令 native customIcon hidden=YES；目标静态 setup 已确认 badge 是 item 的直接子视图，因此此操作不会通过父子继承隐藏 badge。imageView.hidden 明确设为 NO；原生 layoutIcon 还会将 native customIcon `sendSubviewToBack:`，不支持 customIcon 因后加入而必然覆盖 badge 的说法。

## 4. 自建背景层并非 item 上方的覆盖层

活视图路径在 `CSRenderSurface:383–412`。surface 通过 `392` 的 `insertSubview:atIndex:0` 插入 bar 最底层；material 是 surface 的子视图（387–388），border 是 surface.layer 的子层（389–390）；haloContainer 是 surface.layer 内、border 之下的子层（304–311）。这些层没有设正 zPosition，没有被插入 item/image/badge 上方。material 的 clips=YES（401）只裁剪它自己的子树，不裁剪与 surface 同级的原生 item。

`445–450` 隐藏的对象限于 bar.backgroundView 或类名包含 BarBackground 的 bar 直接子视图。它不遍历隐藏 badge，不改 badge alpha/hidden；bar 自己的 hidden/alpha 继续走原生值（`Hooks/TabBarStyleHooks.xm:16–24`）。在**原生 item 是 bar 中位于 surface 后的普通 sibling**的情形下，不能由源码支持“自建背景压住原生 badge”的说法。

`CSTabBarStyleSnapshot:486–515` 只处理原生 snapshot，重新组合 UIImageView 像素副本和一个 snapshot 专属 surface。它既不修改活 badge 的父视图，也不改变活 badge.frame。这段可以用于检查转场快照问题，不能作为活视图 badge 层级和可见性证据。

## 5. 第五个 tab 与未知组合

`CSApplyItem:171–172` 的 index>=4 是第二道限制；第一道限制在 `CSTabBarUpdate:420–422`，要求 `tabBarItemViews.count==4` 且 `bar.items.count==4`。不满足时调用 `CSStop`，经 `CSRestoreVisuals/CSRestoreGeometry` 恢复当前 items 以及旧 button state 中已记录的 items（259–281），移除 surface 和 feedback target（286–291）。

所以普通第五 tab 进入 `CSTabBarUpdate` 时会整体退回原生，不会“继续自定义前四个、唯独漏第五个”。不过 **item 独立 End 与 tab count 切换的先后顺序**是否存在短暂窗口，需要事件序列验证。8.0.78 的 `p_createSlimViewControllers/p_createTabBarItems` 常规路径已经静态确认创建微信/通讯录/发现/我四项，通用 createTabBarItemViews 则按 items.count 工作；这不能外推所有账号/远端配置/其他插件组合永远只有四项。

## 6. 反复布局、切换、前后台与开关

| 触发 | 2.1-6 源码行为 | 与 badge 有关的证据边界 |
| --- | --- | --- |
| 普通 bar layout/relayout | 恢复 → 原生 → 应用，bar/item depth 防重入 | 保证已 Hook 布局顺序；不能证明原生不存在 Hook 外 frame 写入 |
| 切 tab / reloadIconImage | 原生 selector 被 Begin/End 包围，然后按所选状态取图 | setSelected 外层包住复合链；未 Hook 的复合入口不构成同一事务 |
| 收到数字/红点更新 | 数字末尾 layoutBadgeView；字符串复合 relayout；纯点末尾仅 layoutIcon | 已有静态顺序；大小变化保 center 和读取时点仍需 host/log 验证 |
| bar hidden、alpha、离开 window | 样式几何保留以供原生转场快照；touch/inset 释放 | 不会单独隐藏 badge；宿主原生隐藏会使其全部子树隐藏 |
| 深浅色切换 | trait Hook 更新；surface 外观缓存 key 含 style | badge 色彩、内容、形状仍归原生；没有插件 badge theme 分支 |
| 前后台/scene 激活 | 594–625 恢复/停止描边动画和点击动画，不重设 badge frame | 首次/恢复 badge 布局仍靠 native selector 和普通 Update |
| 改配置、反复开关样式 | 583–588 reload → Stop → setNeedsLayout/layoutIfNeeded → Update | 无固定 delay；未验证 native 原生重布局是否完全同步 |
| 点击弹动 | 134–153 给选中 icon.layer 叠加 presentation transform | 不写 badge frame；若 badge 是 icon 子级会跟随，若为 item sibling 则不会跟随，但不能据此解释常态消失 |

## 7. 样式维度矩阵（代码路径，不冒充真机复现矩阵）

设置页只有一个“启用悬浮底栏”开关（`CSTabBarStyleSettingsViewController.m:167`）。“迷你/紧凑/中等/标准”是宽度 0.6/0.7/0.8/0.9 四档（461–462），共用完全相同 apply 逻辑，并非两套底栏实现。

| 维度 | 取值/范围 | 是否经过同一 badge 公式 | 从源码能否判定必现 |
| --- | --- | --- | --- |
| 总开关 | 关 | 否；退出接管并 restore | 不能判定视觉结果；用户反馈关闭恢复可用 |
| 总开关 | 开、受支持四 tab | 是 | 父级已静态核清；现有几何缺口仍不能证明所有配置必现 |
| 标签 | 保留 / 隐藏 | 是；labelHeight/gap 改变图标 top | 同父级坐标成立；两者都经过第 10 节采样顺序，无实测差异证据 |
| 图标 | 系统 / 自定义普通 / 自定义选中 | 是；系统取 native size，自定义基数 25×25 | 隐藏 customIcon 会继承隐藏 badge 的候选已排除；两者都经过采样顺序 |
| 宽度 | 迷你 .6 / 紧凑 .7 / 中等 .8 / 标准 .9；读取兼容至 1 | 是；itemWidth 和新图标 x 变化 | 较窄更易让宽 badge 超出 item，但需父链 clips 才能判断裁剪 |
| 高度 | 44–80，默认 52 | 是；图标上限 28，下限 20 | 高度/标签共同决定 dy，不能凭配置名推断视觉结果 |
| 上移 | 0–100 | 是；整体 item 移动 | 同一 item 子树整体移动，不引入不同父坐标系；检查祖先裁剪 |
| 胶囊/圆角、描边/颜色/模糊 | 两种角，边宽 0–6，可自定义颜色/系统材质 | 同一 badge 公式 | surface 后层结构相同，不支持“换边框就会露出”的源码结论 |
| 深/浅色 | native trait | 同一 badge 公式 | 无 badge 独立分支，待视觉验收 |
| 选择态 | 已选 / 未选 | 同一公式，可能不同图片 | 无独立 badge 隐藏分支 |
| badge 内容 | 纯红点 / 1 / 12 / 99+ / 原生字符串 | 只读 frame，不读写数值/形状 | 数字与纯点原生锚点和更新顺序不同；已静态核清，未观察真机 |
| tab 数 | 非 4 | 整体 stop/restore | 保留原生；需验证组合切换不存在遗留状态 |

用户目前只报告“开启底栏样式后纯红点和数字均不可见，关闭正常”，没有给定发生在哪些 tab、首次开启还是更新后、是否选中态相关、是否自定义图标/隐藏文字相关。不能在报告中填造“所有 tab/所有样式真机必现”。

## 8. 既有测试为什么不足以证明当前视觉正确

`Tests/TabBarNativeTests.m:119–122` 人为把 image/text/badge 均作为 item 直接子视图，且 badge 被添加在 image 之后；本轮静态证据确认这与目标 setup 层级相符。但 `42` 的 layoutIcon/layoutBadgeView/reloadIconImage 都为空方法；badge 是空 UIView，且替身没有实现原生 image autoresizingMask、MMBadgeView 像素对齐、内部 content、原生创建时序和布局读写副作用。

`130` 只验证对象同一且 !hidden；`135–136` 验证同样替身条件下 100 轮幂等；`151–154` 验证外部 width 更新保留。即使它们全通过，也不能证明真实 badge 的内部可见内容存在、在 item 可见范围内、未被 sibling 遮挡或未被真实父链裁剪。

`Tests/TabBarUIKit/TabBarUIKit.m:31–37` 只存储 subviews 数组并按加减 frame/bounds.origin 做坐标转换；并不构造真实 UIKit backing layer 的视图合成树、裁剪或渲染。用它检查 sibling 顺序可作为结构断言，不能包装成真实屏幕像素可见验证。

本轮 `rg` 扫描未发现 ListCornerRadius 模块与 CSTabBar/MMTabBar 的直接调用。`Tests/verify-list-corners.sh:6–17` 不编译 TabBar adapter/Hook；它通过只能说明列表圆角模块的现有语义仍成立，不能替代底栏可见性回归。

## 9. 其他模块影响与排除边界

`Hooks/CloseFriendNotificationHooks.xm:104–112` 独立按密友策略调整“微信”tab 的 count/string/红点，未依赖底栏样式开关。此逻辑可能影响特定密友消息的业务角标，但源码不支持它解释“所有原生 badge 只随样式开关一并消失”。本任务不应修改它的语义。

结合 native 静态补证，可排除“插件忘记调用原生 layoutBadgeView”“badge 在 image 子视图里、坐标系不一致”“隐藏 customIcon 连带隐藏 badge”“样式代码直接把 badge.hidden 设成 YES”“surface 正常路径被加到 item 上方”“snapshot 重排了活 badge”“恢复时故意把 badge size 设为 0”这些直接说法。第 10 节记录已能推导的几何误差，但当前仍不能将它当成现场所有 badge 消失的完整根因。最小修改应针对能被失败用例/日志证实的断点，继续复用原生 badge，不以隐藏背景、改图标尺寸或固定 delay 掩盖。

## 10. 补充追查：image autoresizing 与采样时点

原生 `setupUI` 的 `0x104727c64–0x104727c74` 将 imageView.autoresizingMask 设为 **1，即 UIViewAutoresizingFlexibleLeftMargin**；原生 `layoutIcon` 的 `0x104728b64–0x104728b74` 再次设置同一值。本次有界 setup/layout 未见 badge 设置 autoresizingMask。UIView 默认 mask 为 None；没有外部改写时，item 宽度改变会把 image.x 按宽度差自动移动，但 badge.x 不跟着移动。

实际源码顺序是 `CSTabBarUpdate:461` **先改 item.frame**，再到 `CSApplyItem:181` 采样 imageFrame/badgeFrame。设 native item 宽 W、样式宽 w、原生 image 右边 r、badge.x=b。按 flexibleLeftMargin，采到的 image.right 为 `r+(w-W)`，而 badge.x 仍为 b。`209` 的结果为：

```text
styledBadgeX = b + newImageRight - (r + w - W)
             = (b + newImageRight - r) + (W - w)
```

因此**尚未原生 relayout 的首次/普通 apply，会相对“同一原生几何快照的锚点平移”多出向右 W−w 的稳定误差**。这是真实 setter 顺序与 native mask 能推导的几何缺口；不是因 badge/image 属于不同父视图。mask 的实际运行值若被其他插件改写，需另以日志判断。

下表只演示公式量级，不冒充真机尺寸：native W=97.5、native image=25×25 且居中，native 数字 badge.x=W/2+3，新 icon=28×28。取点大小不改变本表 x 公式。

| 底栏宽度系数 | item 宽 w | 采到 image.right | 旧代码 badge.x | 同一原生锚点平移应得 x | 额外右移 |
| --- | ---: | ---: | ---: | ---: | ---: |
| .6 | 58.5 | 22.25 | 72.75 | 33.75 | 39 |
| .7 | 68.25 | 32 | 67.875 | 38.625 | 29.25 |
| .8 | 78 | 41.75 | 63 | 43.5 | 19.5 |
| .9 | 87.75 | 51.5 | 58.125 | 48.375 | 9.75 |
| 1 | 97.5 | 61.25 | 53.25 | 53.25 | 0 |

.6 时 badge 已可落到下一 item 的 icon 区域；由于下一 item 绘制顺序较后，可发生相交和局部遮挡。**仅凭相交不足以证明全枚不可见**：实际图片可能透明，badge 可能有部分区域在外，最后一个 item 没有下一个 icon，bar.clipsToBounds 又已关闭。尤其 .9 示例中的普通 8 pt 点仍在当前 item 范围内，所以此公式本身不支持“所有宽度、所有 tab、数字与纯点都必然全无”。

### 10.1 普通 restore/apply 不累积该误差

普通往返中，`CSRestoreItem:162` 先还原采到的 imageFrame，`CSRestoreGeometry:265` 才把 item 宽从 w 还原 W，flexibleLeftMargin 使 image.x 自动加回 W−w；随后 Update 再把 W 缩回 w，自动位移抵消。badge origin 的相反偏移也抵消（屏幕像素对齐余差另议）。因此不能把此缺口写成“每 layout 一次向右漂移 W−w”。

若下一次 UIKit item.layoutSubviews 在样式宽 w 下执行，Hook 先 restore，native layoutIcon 会按当前 w 居中 image，layoutBadgeView 会重设 badge 原生位置，再由 End 重新采样。此时可纠正前述跨采样时点的误差。反过来，`CSRestoreGeometry` 只恢复 frames 而不强制执行 native layout；独立 badge/layoutIcon 更新和完整 bar/item 布局可能采到不同 native 基准，呈现首次/收到消息/切换后不同的位置。具体出现时序需事件日志或有 native autoresizing 行为的 host 复现。

### 10.2 create/layout 没发现把 surface 提到 item 上方的目标源码

`MMTabBar.createTabBarItemViews` 在原数组数量不足时新建 item，并通过 `0x10471f868–0x10471f874` 的 `addSubview:` 加在 bar 尾部；已有 item 的分支不调用 bring/send/insert。`MMTabBar.layoutSubviews` 在 `0x10471f218–0x10471f230` 仅把 backgroundView 送到最后面（视觉最底层），然后 relayout；`relayoutTabBarItems` 对各 item 写 frame、最后通知 delegate 同步 button frame，没有 item/surface z 序操作。surface 首次插入 index 0 后，native background 被 sendToBack 只会移到 surface 下面，不会把 item 放到 surface 下面。

当前 `CSRenderSurface:392` 的确只在 superview 改变时重新插到 index 0，没有每次纠正 sibling 顺序；若 UIKit superclass 或外部插件主动重排未知视图，理论上可能打破结构。但本轮目标 native 有界方法未发现该路径，不能把它当已证实根因，也不应仅凭可能性先加 bringSubviewToFront/隐藏覆盖层。

### 10.3 当前结论

已证实真实父级一致、native image mask 与插件采样顺序之间有几何缺口；已排除所查 native create/layout 主动将 surface 压到 items 上方。没有找到能仅靠当前源码和这些静态方法证明“全部 badge 在所有启用样式下完全消失”的路径。后续应让 host 真实模拟 mask/像素对齐/原生 badge 更新顺序做失败验证，并以设备日志确认现场 badge.frame、item.bounds、祖先裁剪和 z 序，而非直接以局部缺口替代现场根因。

## 11. 最小可靠修复候选评估（尚未改生产代码）

### 11.1 不能只移动一次采样时点

将 `s.imageFrame` 的采样从 Update 改 item.frame 之后移到之前，只能修复“此次确实处于 native 宽 W 的完整配对几何”这一种起点。下一次独立 native item.layoutSubviews 可在样式宽 w 下重新布局 image 和 badge，并由 End 将 w 基准写回 state；此后 RestoreGeometry 扩至 W 时 image 自动右移 W−w、badge 不移动，**pre-resize 又采到另一组错配 pair**。此时同样写法可能转而把 badge 向左移。不能把“总在缩 item 前读 frame”作为充分修复。

### 11.2 候选：在当前 bounds 下同步建立原生 pair，并对称恢复

较小、可由 native 方法语义支持的方案是保留现有 restore/apply 结构，在两个明确边界同步建立完整原生几何：

1. **Apply 边界**：现有 `CSRestoreItem` 后、采样 image/text/badge state 前，在当前 item.bounds 下同步调用原生 `layoutIcon`，再 `layoutBadgeView`。调用期间暂增 item state.depth，抑制这两个已有 Hook 的 End 再次 apply；深度通过 `@try/@finally` 成对还原。这保证每次采样的图标和 badge 都属于当前同一 item 尺寸，不依赖上次基线来自 W 还是 w。
2. **原有平移**：接着仍按现有图标尺寸语义和同一右上角差值定位原生 badge。实际调用 `CSSetFrame(badge, requested)` 后，读取 **setter 返回的实际 frame**，再保存 `actual.origin - nativeBadgeFrame.origin` 作为 badgeOffset。不能在 setter 前记录 requested offset，因为 MMBadgeView 会做屏幕像素对齐。
3. **Restore 边界**：`CSRestoreGeometry` 恢复原有 item.frame 后，也在相同 depth 抑制下对原有 styled item 同步执行 native icon/badge pair。否则先恢复 w 基准的 image、再扩 item 到 W，只会自动移动 image，badge 仍停在 w 基准；关闭样式/进入 native bar 布局之前的即时几何仍不可靠。此处保留现有 button/item frame 恢复顺序，只补齐配对布局。

新增的同步取几何调用应使用与 `CSSetFrame` 相同的 `UIView performWithoutAnimation` 语境，避免在宿主 UIView 转场动画上下文中为临时 native frame 提交新动画；不能以 removeAllAnimations 移除既有 native/点击动画。它不调用 reloadIconImage，不重载资源，不创建 badge，也不更改 badge 内容、hidden、alpha、形状或 size。

这解决的是已能证明的配对采样/像素对齐可逆问题，不能在没有现场证据时包装成已消除用户手机上的全部角标消失。

### 11.3 native pair 的副作用范围与最小 Hook 边界

静态 `layoutIcon` 会选择 native customIcon/image 的显隐、必要时挂载 customIcon 并 sendToBack、按 item.customSize 或 dynamic28 设置尺寸、top/bottom、centerX 和 autoresizingMask=1；`layoutBadgeView` 按 unreadCount/badgeString 判断数字或纯点，再只写 badge x/y/right。所核对的方法未写 badge 数值、字符串、shape、hidden、alpha。因而此候选不直接改变原生 badge 语义，也不会改变插件最终自定义图标尺寸公式。

代价是每次最终 apply 多执行一次原生图标/角标布局，另在 restore geometry 时补一次；对 customIcon 的 setHidden/add/sendBack 和外部观察者可能有调用频率影响。静态方法未见网络请求、图片 reload 或业务值更改，但不能宣称所有 UIKit/埋点/第三方观察者没有副作用。host 应记录调用次数和稳定性，设备验收检查 presentation 动画与原生曝光日志。

若补一个复合边界 Hook，优先仅选 **`relayoutIconAndBadge`**：它已被静态确认顺序调用 reload → icon → badge，而当前三个子 selector 可各自完成独立 apply。沿用已有 Begin/%orig/End 可将复合链收敛到一次最终样式 apply，避免新增 native pair 被重复执行三次。不需要为本几何候选再泛加 setTabBarBadgeValue/String/showSmallRedDot 等业务 setter Hook：数字末尾已有 layoutBadgeView，纯点末尾已有 layoutIcon，其 End 的完整 native pair 足以确定最终配对位置；内容与可见性继续交给原生 setter。

`relayoutIconAndBadge` 外层 Hook 本身不解决 bar 直接缩 item 后的首次采样，所以不能取代 11.2。反之 11.2 的 canonical pair 已能在未 Hook 的复合入口各个收尾建立最终正确 pair，复合 Hook 主要减少中间重复布局/过渡状态；是否纳入最小补丁应以红测/调用次数证据确定，不作为泛重构借口。

### 11.4 此候选仍必须验证的边界

- native mask 的缩/扩行为、独立 item.layoutSubviews 在 w 下重建基线后下一轮 bar Update、关闭时立即回到 W 的原生 anchor。
- 原生 setValue/setString/updateWithSize 保 center、showSmallRedDot 只调 layoutIcon、99+ 宽度变化，以及 2×/3× 像素对齐后的反复恢复。
- 已选/未选普通图、自定义图、native customIcon 并存；最终自定义图标 frame 与修复前尺寸语义相同。
- 高度44–80、label.lineHeight 的动态变化及最窄宽度下，badge 的完整 bounds 是否仍能在 item 内。完整 pair 只能保证正确原生锚点；较大原生 badge 的几何可容纳性仍须逐项断言，不应凭该方案宣称覆盖全部尺寸组合。
- 不增加固定延时、不累计偏移，不隐藏 surface、不移除既有动画；纯红点/数字值/shape/hidden 与 native setter 完全一致。
- 非四 tab 的 fail-closed restore 不因新增 native pair 将未样式化/新建 item 拉进接管范围。

在这些验证和现场归因前，应将该方案标注为针对已证实几何缺口的候选，而非已经确定能解释并修复全部用户现象的最终方案。
