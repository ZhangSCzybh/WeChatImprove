# 角标几何隔离探针

探针直接编译当前生产 `CSTabBarNativeAdapter.m` 和 `CSTabBarPreferences.m`，复用 `Tests/TabBarUIKit`，不改动 `Tests/` 或生产文件。所有偏好写入 UUID 测试 suite，结束删除该 suite，不读取、改写用户插件配置或微信数据。

## 可以证明的结论

**在模拟了静态证据确认的 imageView FlexibleLeftMargin 后，现有 adapter 可以把角标整个平移出所属 item；现有测试缺少此行为，因此漏检。** 首次开样式以及 bar 重新完成原生布局再应用样式时均可出现。单独的 native item 布局可以把它纠正，下一次 bar 布局又会推错。

这不等于已证明真机的“整枚不可见”。探针没有人为添加 `clipsToBounds=YES`，所有 badge 对象均仍在、frame 非零、hidden 没变、祖先未隐藏。越出 item 的 badge 在真实 UIKit 中可能继续画到相邻 item 区域；真正裁剪、覆盖或整体不显示还需要真机层级/日志证据。

无 autoresizing 的控制模式中，44,160 次观察没有一例角标与所属 item 完全无交集；只加已证实的 imageView FlexibleLeftMargin 后出现 3,872 例。这为错误采样时机提供可重复的源码证据，不能据此替代真机验收。

## 模型来源与边界

- badge 是 item 的直接子视图，由本目录上级 `native/MMTabBarItemView--setupUI.asm` 的 `self addSubview:_badgeView` 支持，不把它放到 imageView 内。
- 数字/字符串布局采用静态 `layoutBadgeView` 中的 `y=4`、`x=item.width/2+3`；纯点采用 `y=imageView.y`、`right=imageView.right`。
- 无 native customSize 时，`layoutIcon` 的默认动态字号长度以 28pt 输入，`y=8`、水平居中；这是默认字号模型，不是动态字体所有档位的完整模拟。
- 开启 `flexible-left-margin` 模式时，item 宽度变更只为 imageView 应用 `x += newWidth-oldWidth`，对应静态确认的 `imageView.autoresizingMask=1`；badge 没有对应 mask。没有实现通用 UIKit autoresizing 引擎，也没有主动给 badge 增加 mask。
- `MMBadgeView.setFrame:` 的原点像素对齐、尺寸向上对齐分别用 `nearbyint` / `ceil` 实现，分别跑 2x 和 3x。`updateWithSize:` 保留 center；纯点 `setSize` 保留 origin，直径为静态确认的 8pt。`shapeChangeBlock` 经静态确认只处理曝光/埋点，不重新调用 item 布局。
- 数字 `1 / 12 / 100`、字符串 `99+` 的几何输入分别选用 16 / 24 / 30pt 宽、16pt 高，用来覆盖尺寸变化；这些是代表性输入，不声称为微信字体排版的实测宽度。插件没有参与改值或造 badge。
- Hook 顺序由相同的生产 begin/end 函数模拟：item/layoutIcon/layoutBadge/reload 嵌套，bar begin → native item frame/布局 → bar end。原生完整调用时机、UIKit 异步布局、layer 合成、屏幕像素与实际遮挡均不在主机探针覆盖范围。

## 复跑

```sh
bash docs/audits/tabbar-badge-2026-10-28/probe/run.sh
bash docs/audits/tabbar-badge-2026-10-28/probe/run.sh flexible-left-margin
```

脚本在临时目录编译、执行，退出后移除临时文件；不会调用 make、install 或启动微信。两个模式均以 `-Wall -Wextra -Werror` 编译通过，编译/运行 stderr 日志为空。

每模式 480 组合：2x/3x × 宽 `.6/.7/.8/.9/1` × 高 `44/52/80` × 保留/隐藏文字 × 系统/导入图标 × 初始纯点/1/12/100。每组合检查首次开启、100 次普通 update、恢复、运行中 value/string/dot/hidden 更新、各 100 次 item 和 bar 嵌套布局、开关配对恢复。每种生产 adapter 模式共有 44,160 次四 tab 逐项观察，原生 badge/layout 等价体被调用 2,726,400 次。

完整结果：[无 autoresizing 控制组](no-autoresize-results.json)、[FlexibleLeftMargin 模型组](flexible-left-margin-results.json)。JSON 的 `matrix` 是 480 组合明细，`stageMatrix` 是阶段与宽度分组，`trace` 给出指定组合的前后 frame，`stageCounts` 给出各类异常计数。

## 阶段 × 宽度 × badge 类型

表格中的数值是 **“完全无所属 item 交集 / 观察数”**，不是“真机不可见次数”。宽度 `.6/.7/.8/.9` 分别对应迷你/紧凑/中等/标准；`1` 是持久化读取允许的最大值。

| 阶段 | badge | 宽 .6 | 宽 .7 | 宽 .8 | 宽 .9 | 宽 1 |
| --- | --- | --- | --- | --- | --- | --- |
| 首次开启前已有 badge | 纯点 | 96/96 | 80/96 | 0/96 | 0/96 | 0/96 |
| 首次开启前已有 badge | 1 | 96/96 | 0/96 | 0/96 | 0/96 | 0/96 |
| 首次开启前已有 badge | 12 | 96/96 | 0/96 | 0/96 | 0/96 | 0/96 |
| 首次开启前已有 badge | 100（宽溢出输入） | 96/96 | 0/96 | 0/96 | 0/96 | 0/96 |
| 接着 100 次普通 update | 以上各类，合计 | 384/384 | 80/384 | 0/384 | 0/384 | 0/384 |
| 后续原生 value 更新，尚未 item layout | 1 / 12 / 100，各类 | 0/384 | 0/384 | 0/384 | 0/384 | 0/384 |
| 后续原生 string 更新，尚未 item layout | 99+ | 0/384 | 0/384 | 0/384 | 0/384 | 0/384 |
| 后续原生 dot 更新，尚未 item layout | 纯点，两轮合计 | 0/768 | 0/768 | 0/768 | 0/768 | 0/768 |
| 100 次 native item layout | 1 / 12 / 100，各类 | 0/384 | 0/384 | 0/384 | 0/384 | 0/384 |
| 100 次 native item layout | 99+ | 0/384 | 0/384 | 0/384 | 0/384 | 0/384 |
| 100 次 native item layout | 纯点，两轮合计 | 0/768 | 0/768 | 0/768 | 0/768 | 0/768 |
| 再 100 次 native bar layout | 1 / 12 / 100，各类 | 384/384 | 0/384 | 0/384 | 0/384 | 0/384 |
| 再 100 次 native bar layout | 99+ | 384/384 | 0/384 | 0/384 | 0/384 | 0/384 |
| 再 100 次 native bar layout | 纯点，两轮合计 | 768/768 | 640/768 | 0/768 | 0/768 | 0/768 |

“有交集”不等于“完全包含”。例如 .6 的 value 更新后，角标可能只有一部分进入 item；30pt 宽的 `100` / `99+` 在 item 布局纠正后仍有 320/384 次未完全包含，这种部分越界单列在 `notContained`，不当成整枚消失，也不直接判为真机可接受。没有把正常图标角落相交判定为覆盖，也没有为了出红例设置 item 裁剪。

在本探针的全部观察中，badge frame 空/非有限、hidden 被插件改变、identity 改变、祖先 hidden/alpha 不可见分别都是 0。与之对应，当前问题可以确认存在的断点是几何采样；“创建新对象/插件主动隐藏/尺寸清零”在该模型中未复现。

将未完全包含分成“整枚越出”和“部分越出”，各宽度的全部阶段合计如下：

| 宽度 | 整枚越出所属 item | 部分越出，但仍与 item 相交 | 未完全包含合计 |
| --- | --- | --- | --- |
| .6 | 3072 | 3200 | 6272 |
| .7 | 800 | 3424 | 4224 |
| .8 | 0 | 1856 | 1856 |
| .9 | 0 | 0 | 0 |
| 1 | 0 | 0 | 0 |

`.7` 的首次纯点整枚越出只发生在隐藏文字或者高度为 52/80 的组合；44pt 高且保留文字时，点仍有交集。`.8` 首次开启的 1 和纯点都完全包含，24/30pt 宽数字输入各有 96 次部分越界。系统/导入图标与 2x/3x 均已参与以上分组，不能将参数模型的结果扩大成真机所有字体/屏幕结论。

## 具体路径与数量级

取 3x、`.6`、44pt 高、保留文字、系统图标、纯点组合；原生 item 宽 97.5pt，样式 item 宽 58.5pt，差为 39pt：

| 步骤 | 图标 frame（x,y,w,h） | 角标 frame（x,y,w,h） |
| --- | --- | --- |
| 原生，开启前 | 34.75, 8, 28, 28 | 54.6667, 8, 8, 8 |
| 首次启用 | 19.25, 4.5, 20, 20 | 70, 4.6667, 8, 8 |
| 100 次普通 update 后 | 同上 | 70, 5, 8, 8 |
| 后续 native item layout 后 | 同上 | 31.3333, 4.6667, 8, 8 |
| 后续 native bar layout 再应用样式 | 同上 | 70, 4.6667, 8, 8 |

数字和字符串同一个组合中，native item layout 后约为 `x=28.3333`，bar 布局重新应用后约为 `x=67`。这不是数值改变，而是采样 `s.imageFrame` 时 image 已经受父 item 缩窄的 autoresizing 影响，随后又将这个差值加到了没有 autoresizing 的 badge 上。

控制组相同组合首次角标 `x=31.3333`，模型组 `x=70`；差约为原生 item 与样式 item 的宽差 39pt（有亚像素对齐误差）。因此“imageView 子视图坐标系错用”不是这次静态证据支持的解释；父 item 改宽之后才保存 image 的基准才是已经复现的错误条件。

## 像素对齐误差

两个生产 adapter 模式均出现 100 条 100 次重复后的 origin 差异；最大单轴差为 `1/3pt`，发生在 3x 屏输入。这些不是尺寸变零，也不能解释大量角标消失。

已保存 trace 的最坏情况：首次 y=`4.6666667`，第一次普通 update 后为 `5`，第 2、3、4、5、100 次均为 `5`。本次每个 100 次同类循环的逐步采样最大 origin 误差均未超过 `1/3pt`，没有观察到持续增长。不能据有限循环把所有真机时序宣称为无累积。

恢复后相对开启前原生坐标的最大单轴差为 `2/3pt`，同一 3x 组合原生 y=`8`，首次关闭恢复后 y=`8.6666667`。生产 state 记录的是请求 offset，原生 badge setter 实际落点还会做像素对齐，导致还原基准不完全可逆；这是与宽度基准错误分开的次要现象。

总报告可以把它作为最小修改方案需要处理的幂等性问题；本轮没有据此修改 adapter，也没有把探针结果称为完整修复回归。

## 最小方案隔离实验

额外生成一个临时 adapter 变体，只验证改动方向，不写生产或 `Tests/`。生成逻辑见 [prepare-experiment.py](prepare-experiment.py)，准确三处差异见 [experimental-adapter.diff](experimental-adapter.diff)，原生产源码与生成结果的 SHA-256 见 [manifest](experimental-adapter-manifest.json)。

实验变体在 `CSApplyItem` restore 后、记录原生 image/badge 基准前，用 item depth 包围原生 `layoutIcon` + `layoutBadgeView`；在 `CSRestoreGeometry` 将 item.frame 恢复原生尺寸后，同样通过 depth 包围重建原生 icon/badge；写 badge 后读取实际 frame.origin，记录实际生效 offset，吸收 MMBadgeView 像素对齐。

复跑命令：

```sh
bash docs/audits/tabbar-badge-2026-10-28/probe/run-experiment.sh
```

脚本始终复制到临时目录编译，结束删除该临时 adapter。变体用完全相同的 480 组合、44,160 次观察及 100 次循环运行，编译带 `-Werror`，stderr 为空。完整 [实验 JSON](experimental-results.json)：

| 检查 | 生产 adapter + FlexibleLeftMargin | 临时方案实验 |
| --- | --- | --- |
| 空/非有限 frame | 0 | 0 |
| hidden / identity / 祖先显隐变化 | 0 | 0 |
| 完全无所属 item 交集 | 3872 | 0 |
| 部分越出所属 item（仍有交集） | 8480 | 2080 |
| 100 次循环后 origin 不一致 | 100 | 0 |
| 恢复 origin 不一致 | 820 | 0 |
| 最大重复 origin 误差 | 1/3pt | 0 |
| 最大恢复 origin 误差 | 2/3pt | 0 |

剩余 2080 次部分越界全部来自 `.6` 的 30pt 宽数字/99+ 几何输入；是否需要进一步限制位置，要以真实尺寸和裁剪/覆盖链确认，不能将“仍有交集”当作通过完整可见性验收。若需要处理，只能调位置并保持 badge size、形状、显隐和图标缩放语义。该实验也没有把角标改造成插件对象。

实验表明“在正确父尺寸下先让原生重建基准、然后仅定位”的方向能消除本探针已复现的错误；它不证明真机视觉全绿。额外 native layout 等价调用从 2,726,400 增至 7,259,520 次，正式实现还需评估原生方法副作用和调用量。没有据实验结果发布新版本、产包或宣称正式修复。
