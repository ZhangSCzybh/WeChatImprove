# 底栏角标测试覆盖核对

本文件是对当前 `2.1-6` 工作区的只读测试审查，不是修复完成记录。没有改生产代码、测试代码或配置，也没有根据替身的视图层级推断微信真机层级。

## 现有测试实际覆盖了什么

`Tests/verify-tabbar.sh:6` 编译、执行 `TabBarGeometryTests.c`；`:8` 再将生产 `CSTabBarPreferences.m`、`CSTabBarNativeAdapter.m` 与主机 UIKit 替身、`TabBarNativeTests.m` 一起编译。脚本没有编译或执行 Logos `Hooks/TabBarStyleHooks.xm`。

| 现有位置 | 覆盖内容 | 对此次问题的证据限制 |
| --- | --- | --- |
| `Tests/TabBarNativeTests.m:116` | 手工创建 4 个 item，25×25 原生图标、16×16 角标；角标为 item 直接子视图 | 这是一种测试输入，不能单独证明微信层级；此次静态 `setupUI` 证据才证明目标实现的角标被加到 item |
| `Tests/TabBarNativeTests.m:130` | 同一角标对象且 `hidden == NO` | 没有检查 frame 非空、是否在可见区域、父视图状态和覆盖关系 |
| `Tests/TabBarNativeTests.m:134` | 100 次 `CSTabBarUpdate` 后 frame 不累加漂移 | 只能覆盖没有原生 layout 副作用的重复 apply/restore |
| `Tests/TabBarNativeTests.m:147` | bar begin/end 期间恢复 item / button frame | 中间没有执行真正的微信布局；不能证明原生 badge 布局与 apply 的次序无害 |
| `Tests/TabBarNativeTests.m:151` | 外部只改 badge 宽度后，begin/end 保留宽度 30 | 没有改变 badge 原点、数字形状、hidden，也没有模拟原生 badge 更新链 |
| `Tests/TabBarNativeTests.m:163` | 重组原生 snapshot 的 item 图片、底图、线条 | 只证明 snapshot 组成，不证明活视图的 badge 是否显示 |
| `Tests/TabBarNativeTests.m:269` | 四类边框动画的前后台恢复，保留 item frame 和 badge identity | 没有检查前后台后的 badge frame、形状内部子视图、裁剪或重叠 |
| `Tests/TabBarClickEffectTests.h:39` | 点击效果不改模型层 badge frame，原生 target 与动画行为保持 | 主要是点击效果测试；同样没有真实原生 layout，也没有渲染 |

`Tests/TabBarNativeTests.m:42` 的 `layoutIcon`、`layoutBadgeView`、`reloadIconImage` 都是空方法。测试通过直接调用 `CSTabBarBeginItemUpdate` / `CSTabBarEndItemUpdate` 近似包围关系，无法复现原生方法间的实际嵌套。

## 主机替身的必要边界

`Tests/TabBarUIKit/TabBarUIKit.m:29` 的 `setFrame:` 仅写入 `_frame` 与 `_bounds.size`，没有 UIKit autoresizing、布局失效、子视图布局或真实 UIView/CALayer 同步。`:32` 的 `insertSubview:` 只维护数组和 `superview`，没有建立对应 CALayer 层级。`:39` / `:40` 的 `setNeedsLayout` / `layoutIfNeeded` 均为空。

角标当前用普通 `UIView`，不模拟目标 `MMBadgeView` 的像素对齐、数字/字符串/红点形状切换和 shape-change block。`UIImage` 替身只检查路径存在，`UIColor.resolvedColorWithTraitCollection:` 返回自身。因此已有测试不等于真机渲染验证，深浅色也没有完整视觉覆盖。

此次微信静态证据可支持的替身行为：`MMTabBarItemView.setupUI` 把 badge 作为 item 的直接子视图；`relayoutIconAndBadge` 顺序调用 `reloadIconImage` → `layoutIcon` → `layoutBadgeView`；数字/非空字符串角标在 `layoutBadgeView` 中 `y=4`、`x=item.width/2+3`，纯红点分支 `y=imageView.y`、`right=imageView.right`。这些原生行为的来源是本目录 `native/` 静态反汇编，不是原有替身。

## 后续先红后绿的最小用例设计

失败用例必须复现经微信静态证据或运行日志确认的具体副作用。不能仅为制造失败而把 badge 改成 `imageView` 子视图，也不能以测试里主动隐藏 badge 的方式假装生产 bug。

1. **原生更新顺序**：在测试中为 native `layoutIcon` / `layoutBadgeView` 实现有依据的几何行为，并记录原生调用次数和进入时的几何。按真实 Hook 包围方式执行 `reloadIconImage`、`layoutIcon`、`layoutBadgeView`，以及外围 item / bar layout 的嵌套；确认 %orig 的等价体每次执行，最外层结束才 apply。这样才能捕获仅在微信原生更新中出现的损坏。
2. **角标呈现契约**：每次 apply 后检查角标对象、hidden、alpha、尺寸不被插件改变；检查转到 item 坐标后的 rect 非空且在可视范围；检查 badge 到 item/bar 的祖先 hidden/alpha/clips，检查真实允许的同级绘制顺序。普通透明 hit target 不能因排在后面就被判定为遮挡，表面背景也不能仅因 rect 相交就被判定为遮挡。
3. **恢复契约**：保存原生 badge 原点，执行 apply → 原生宽度/形状变更 → restore，要求恢复原生原点，同时保留原生新尺寸；重复 100 次，并加入偏好开关、选中切换、前后台、detach/attach。使用像素对齐的 badge 替身检查 requested offset 与实际 origin 的误差不能累积。
4. **初始不存在/运行中新生成**：原生 badge 起初 hidden 或不存在，原生更新后显示/创建；插件不得重建、替换对象或抢显隐。若静态确认目标总在 setupUI 创建，则 nil 场景只标为防御性覆盖，不冒充目标必现路径。
5. **数量变化**：当前 `CSTabBarUpdate:420` 同时要求 `tabBarItemViews.count == 4` 与 `bar.items.count == 4`。5-tab 是整个样式回退到原生，不能描述成只处理前 4 个。补 4→5→4 的 fallback/restore 测试，并检查所有 badge 不被遗留处理；不借此扩展样式支持范围。

真正渲染遮挡不能由当前替身直接证明；可以对生产拥有的 background/surface 的层级、frame 与祖先属性做结构断言，最终仍需真机验收。

## 样式维度与已有缺口

现有 UI 没有独立“紧凑模式”和“悬浮模式”引擎：启用后都走同一 adapter。宽度选项是迷你 `.6`、紧凑 `.7`、中等 `.8`、标准 `.9`（`CSTabBarStyleSettingsViewController.m:461`），读取器允许 `.6...1`。高度范围 `44...80`，lift `0...100`。隐藏文字、系统/导入图标、selected 图标替代、背景/边框及动画都是这条共享路径的参数。

| 维度 | 现有测试状态 | 建议矩阵 |
| --- | --- | --- |
| 隐藏 / 保留文字 | 两者被切换，但只在初始隐藏文字组合检查 badge frame 稳定 | 两者 × 红点 / 1 / 12 / 99+，四 tab 均检查 |
| 系统 / 自定义图标 | 首 tab 有导入图标，随后移除；没有完整 badge 几何交叉检查 | 各 tab 的普通/selected 图标分别输入，保持图标尺寸语义 |
| 宽度 | native lifecycle 主要是默认 `.9`；几何测试有 `.6/.7/.9` | `.6/.7/.8/.9`，外加允许存储值 `1`；窄屏与 176pt 宽度下限 |
| 高度、lift | 几何测试扫 44...80；badge 组合未扫 | `44/52/80` × `0/30/100`，含合法裁剪祖先和回退 |
| badge 数字/纯红点 | 普通 UIView 16×16，仅手工宽度改成 30 | 由原生形状语义替身驱动，不由插件改数值/形状 |
| 深浅色 | 有 trait 字段，颜色解析替身无实际变化 | light/dark 结构幂等；颜色和像素视觉在真机核验 |
| 选中、切 tab、前后台 | 点击/动画已有覆盖 | 每一步额外检查 badge 对象/位置/原生尺寸/显隐不漂移 |
| 多 tab | 没有 5-tab 专项；只测控制按钮缺失回退 | 4→5→4 组成变化时全量恢复，保留所有原生 badge |

本次是分析阶段；上述矩阵不能被报告为“所有样式真机必现/不出现”。用户反馈尚未细分 tab、样式和触发时机，静态共享路径只能说明适用条件，不能补造未做的真机观察。

## 相关回归脚本

- `Tests/verify-tabbar.sh`：直接相关，几何、偏好、主机 lifecycle、click effect、snapshot、前后台/边框动画覆盖，应作为主要回归。
- `Tests/verify-backup-bootstrap.sh`：源码提取与 Hook 语法/链接门禁会扫描功能 Hook，可检测底栏 Hook 初始化与 C 接口集成问题；不是角标显示回归。
- `Tests/verify-backup-registry.sh`：偏好注册/备份边界；若此次只改 badge adapter 不涉及键值，属于外围防回归。
- `Tests/verify-list-corners.sh`：编译列表圆角适配器与 `WESessionTabItem` / 分组策略；脚本、测试、提取器、对应 UIKit 替身中无 `TabBar` / `tabbar` / `CSTab` 引用，未加载底栏 adapter 或 Hook。`ListCornerSemanticsTests.m:324` 的发现页 `MMBadgeView` 是列表 cell 内的 badge，与底栏角标没有实际交互，不能计为底栏集成覆盖；仍可按用户要求跑完整脚本做周边回归。

本子审查没有执行回归脚本；执行结果统一由总报告记录，避免把静态检查描述成运行通过。
