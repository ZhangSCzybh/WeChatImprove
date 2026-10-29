# 2.1-7 角标正式回归与调用量核对

日期：2026-10-29。目标：微信 8.0.78；测试在 macOS host 上编译真实 `CSTabBarNativeAdapter.m` 与 `CSTabBarPreferences.m`，其余微信/UIKit 对象由明确限制的替身提供。本记录只报告几何契约与结构调用量，不将 host 通过当成真机像素可见性验收。

## 冻结的先红后绿

新增独立的 `Tests/TabBarBadgeTests.m`，未修改 `Tests/TabBarNativeTests.m` 的原有 fixture。`Tests/verify-tabbar.sh` 在原有测试之后调用新的 `verify-tabbar-badge.sh`，后者默认运行以下两个模式：

- `source`：读取并校验实际 `Hooks/TabBarStyleHooks.xm` 包装，按源码是否存在 `relayoutIconAndBadge` Hook 建立对应的 host 调用嵌套。
- `without-relayout`：同一真实 adapter 与同一断言，仅在 host 中禁用复合方法包装，单独核对新增复合 Hook 的作用。

测试提取器还要求 `layoutSubviews/layoutIcon/layoutBadgeView/reloadIconImage` 四个原生产 Hook 确实采用 `Begin → %orig → End` 的调用次序；如果生产 Hook 与替身的契约不同，测试先停止而不是继续跑一个脱离源代码的嵌套模型。

| 阶段 | 源码/模式 | 组合 | checks | failures | 退出码 |
| --- | --- | ---: | ---: | ---: | ---: |
| 冻结红测 | 2.1-6 adapter、源 Hook 中没有复合包装、source | 560 | 16,000,960 | 302,796 | 1 |
| 修复绿测 | 修复 adapter + 源复合 Hook、source | 560 | 16,000,960 | 0 | 0 |
| 独立对照绿测 | 同一修复 adapter、host 禁用复合包装 | 560 | 16,000,960 | 0 | 0 |

红测首批失败直接出现于 `.6` 宽度、44 高、保留文字、系统图标、纯红点的首次开启与嵌套 bar layout：badge 与 item 的交集为空，并新增了原生同宽 frame 没有的右越界。红测不是编译失败，也没有用“统计但仍退出 0”的探针替代失败用例。

冻结红测保存了 12 个输入的完整副本与 SHA-256，见 [red-stage.json](red-stage.json) 与 [red-source-snapshot](red-source-snapshot/)。修复后两模式运行的 6 个 Tests 输入 SHA 均与冻结红测完全一致；全部 12 个输入在每次绿测期间保持不变，见 [green-stage.json](green-stage.json)。因此没有通过改变断言、调整用例数据或放宽容差获得绿测。预冻结的初期红日志为 302,800 failures；正式先红后绿采用包含最终调用量计数器的 `red-final-source.log`，其准确值为 302,796。

原始日志：[冻结红测](logs/red-final-source.log)、[source 绿测](logs/green-badge-source.log)、[禁用复合包装绿测](logs/green-badge-without-relayout.log)。

## 5×4 默认样式矩阵

每格有 24 个默认组合：@2x/@3x × 高度 44/52/80 × 保留/隐藏文字 × 系统/导入图标。每次检查同时检查四个 item。下表是由冻结测试的循环基数与完整成功退出推导的覆盖数量，不伪称测试逐格输出了独立结果。

| 宽度比例 | 纯红点 | 1 | 12 | 99+ |
| --- | ---: | ---: | ---: | ---: |
| .6 | 24 / 24 通过 | 24 / 24 通过 | 24 / 24 通过 | 24 / 24 通过 |
| .7 | 24 / 24 通过 | 24 / 24 通过 | 24 / 24 通过 | 24 / 24 通过 |
| .8 | 24 / 24 通过 | 24 / 24 通过 | 24 / 24 通过 | 24 / 24 通过 |
| .9 | 24 / 24 通过 | 24 / 24 通过 | 24 / 24 通过 | 24 / 24 通过 |
| 1.0 | 24 / 24 通过 | 24 / 24 通过 | 24 / 24 通过 | 24 / 24 通过 |

合计 480 默认组合。另有 80 个边界组合：同样的 @2x/@3x、五档宽度、四种内容，分别采用原生文字行高 20/样式高度 44，以及原生 customSize 20×20/样式高度 52；每个宽度×内容格另有 4 个边界组合，全部通过。边界保持文字可见、系统图标，是验证“只限制插件新增越界”的受控输入，不声称动态字号或 customSize 的所有可能值均被枚举。

每个组合含首次开启、100 次普通 Update、100 次嵌套 item layout、100 次嵌套 bar layout、两组选择/外观状态变化、移除再挂回、20 次禁用/启用配对、最终禁用恢复。默认组合还含纯红点/1/12/99+ 的动态内容变更，以及原生将数值设为 0 后的隐藏路径。机器可读矩阵见 [badge-coverage-matrix.json](badge-coverage-matrix.json)。

## 独立不变量

测试使用不带样式状态的独立原生替身，在当前**同样宽的 item** 上按核对过的 native `layoutIcon/layoutBadgeView` 规则生成反事实 frame，并读取 badge getter；它不复制生产 adapter 的夹取公式。

- badge 指针与 superview 不变；可见路径下 alpha 仍为 0.75，祖先没有被样式设为 hidden/透明。
- frame 有限且非空，保持原生向上像素对齐后的 size；未通过缩小角标或自定义图标获得通过。
- styled frame 与 item 有非空交集；四侧越界逐侧不大于同宽 native getter frame 的四侧越界，浮点比较容差 0.001pt，小于 @2x/@3x 的一个物理像素。
- 插件 surface 在 item 下方；角标仍在图标之后的原有 sibling 顺序，surface 的 zPosition 不高于 item。
- 同一稳态反复更新 frame 不漂移；禁用样式后与当前原生 frame 相同，动态内容变化不恢复旧 size。
- 原生 value=0 隐藏路径继续 hidden，并保持同一对象。

每模式产生 782,720 次独立原生 getter 对照，其中 36,784 次 native frame 本来就部分越界。该统计不会被错误解释为插件引入的失败：只要插件没有增加任何一侧的越界即允许保留，例如最窄档 99+ 的原生自然观感。`CGRectContainsRect` 未被当作强制绿色条件。

## 逐事件结构调用量

在一个固定配置（@3x、.9 宽、52 高、保留文字、系统图标、12 角标）中，每种事件重复 100 次；统计 native-equivalent `layoutIcon` 与 `layoutBadgeView` 方法体进入次数，表中已除以 100。独立反事实 getter 的调用不计入。`reloadIconImage` 单独记录在 JSON，避免混进几何调用数。

| 单次事件 | 样式关闭 | 修复但无复合包装 | 修复且有源复合包装 | 源复合包装节省 |
| --- | ---: | ---: | ---: | ---: |
| 普通 Update（四项合计） | 0 | 16 | 16 | 0 |
| item 0 的 layoutIcon | 1 | 3 | 3 | 0 |
| item 0 的 layoutBadgeView | 1 | 3 | 3 | 0 |
| item 0 的 relayoutIconAndBadge | 2 | 8 | 4 | 4（50%） |
| item 0 的 layoutSubviews | 2 | 4 | 4 | 0 |
| bar.layout（四项合计） | 8 | 24 | 24 | 0 |

逐 item 明细：普通 Update 的四项各为 4 次；完整 bar.layout 的四项各为 6 次；单 item 事件只进入 item 0，其余三个为 0。style-off 的完整 bar.layout 四项各 2 次，其余 native 单项事件也保持原生调用数。

修复引入了同步重建原生几何的结构开销，不能表述为“没有额外调用”。新增复合 Hook 只将独立 compound 入口从 8 降到 4；已经有 item 外层深度保护的路径不会再被这一层减少。style-off 仍为 2 次；最终 compound 路径的结构几何量为关闭样式的 2 倍。100 次 compound 的 `reloadIconImage` 均为 100 次；无包装的 icon/badge 各 400 次，有包装的各 200 次。

完整逐事件、逐 item 数据及旧 adapter 对照：[native-event-comparison.json](native-event-comparison.json)。从日志原样抽取的数据：[source](green-native-event-counts-source.json)、[无复合包装](green-native-event-counts-without-relayout.json)。这些是结构方法计数，**没有测量真机耗时、CPU、GPU、动画帧率或实际调度次数**；7 秒级 host 总运行时长不适合当作本次修复的性能结论。

## 适用边界与真机待验

替身只模拟有静态证据的 imageView FlexibleLeftMargin；没有给共享 UIKit 替身加入全局 autoresizing，原有生命周期 fixture 不受这一模拟影响。`UIScreen.scale` 是共享替身唯一新增接口，默认值 3；badge 测试逐组合设为 2/3。测试通过 UUID NSUserDefaults suite 和临时图标隔离，不接触用户微信数据。

以下内容仍须依据主审计的真机步骤验收：真实原生层级与裁剪链、实际 badge 测字、每个 tab 的实际消息/红点来源、独立的浅色选中/深色未选中交叉状态、真实前后台及动画过渡、第五个或临时 tab。当前 host fixture 为四 tab；light+unselected / dark+selected 只覆盖两组属性状态，并未执行完整微信选择流程。detach/reattach 只覆盖关联状态恢复，不冒充真实前后台。静态 z 序与几何非空也不等同于已观察到真机像素可见。完整既有 tabbar 与其它模块回归、构建、产物校验由主交付记录汇总。
