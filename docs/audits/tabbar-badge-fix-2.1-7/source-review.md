# 2.1-7 底栏角标补丁：独立源码审查

日期：2026-10-29。审查基线为当前工作区 2.1-6，目标微信 8.0.78 / build 8.0.78.34。本文由独立审查代理维护；该代理不修改生产/测试源码、不改版本、不运行构建。原生方法依据复用上一轮已留存的 `../tabbar-badge-2026-10-28/native/` 静态证据。

当前状态：已审查第一版正式生产 diff，未发现需要阻止构建/回归的源码问题。审查对象的 SHA-256：`Controllers/CSTabBarNativeAdapter.m = 820135a85ca3e70415b2e358023145063c4cb4636359b8b2446e3d6ec2ab1dfd`；`Hooks/TabBarStyleHooks.xm = d5d57ca0c76302803d75cf61eabc3a4062778f44bea28a17d069ecaab56cc522`。此结论是有静态边界的源码审查，不代替主任务的编译、host 回归或真机验收。

## 1. 方案应满足的边界

- Apply 必须先退出上次样式状态，再于当前 item.bounds 下同步建立 native image/badge pair，随后才采样并应用既有图标尺寸公式。单纯将采样提前到改 item.frame 前不能覆盖 state 已在 styled 宽度下被 native layout 重建的情况。
- RestoreGeometry 必须先恢复原有 button/item frame，再为曾经 styled 的 item 同步建立恢复后 bounds 下的 native pair；新建/未样式化的 item 不应因此进入几何接管。
- 同步 pair 用现有 item.depth 保护，新增 native 调用应处于 performWithoutAnimation 中；深度以 @try/@finally 成对维护。不能用移除所有动画替代。
- badgeOffset 必须在 native setFrame 完成后由实际 getter 计算，不应记录像素对齐前的 requested origin。
- 原生 badge 对象、值、字符串、尺寸、shape、hidden/alpha 规则不应被插件写入；自定义图标的最终尺寸公式、native 点击和导航不应改变。
- 多 tab 不扩大支持范围，继续完整 fail-closed/restore；原有 surface 和材质继续显示，不以隐藏背景消除证据中的越界。

## 2. 原生同步方法的真实副作用

`-[MMTabBarItemView layoutIcon]`（`0x10472884c`）不是 getter。它选择 native customIcon/image 的显隐，必要时挂载 customIcon 并送到底层，设置原生图标尺寸、top/bottom、centerX 与 autoresizingMask=1。相关指令包括 customIcon addSubview/sendSubviewToBack（`0x1047288dc–0x104728938`）、setHidden（`0x10472895c–0x1047289e8`）、setSize/top/bottom/centerX（`0x104728a84–0x104728b60`）、setAutoresizingMask（`0x104728b64–0x104728b74`）。

`-[MMTabBarItemView layoutBadgeView]`（`0x104728b94`）根据 native unreadCount/badgeString 选择数字或纯点锚点，然后只写 y/x 或 y/right。没有 badge 内容、size、shape、hidden/alpha 写入，也没有异步资源加载。

已核对范围未发现新增同步调用会造成不可接受的业务值修改；没有需要因此报停的具体静态证据。应明确代价是更多 native setter/布局调用，外部曝光/KVO/第三方观察者的调用次数可能变化。新增调用不应扩展为 reloadIconImage，不应触及业务 setter，以限制副作用面。

原生 setupUI 已确认 badge 是 item 直接子视图；隐藏 native customIcon 不会通过父子关系隐藏 badge。layoutIcon 对 customIcon 的送后属于 native 既有职责，不是插件新增 bringToFront 兜底。

## 3. depth 与复合 Hook 评估

pair helper 先令 item.depth 从 d 加到 d+1，再发起已有 hooked layoutIcon/layoutBadgeView：每个 Hook Begin 看到非零 depth 不 restore，End 减回 helper 所保持的非零深度，不再次调用 Apply。helper finally 再减回 d。此结构可以抑制 helper 引起的自身递归；需要生产 diff 与 host 调用计数核对加减位置。

原生 relayoutIconAndBadge 顺序是 reload → icon → badge。此前直接进入这个未 Hook 复合入口时，三个子方法各自 End 都可 Apply；给复合入口增加相同 Begin/%orig/End 后，中间子方法只减少到外层 depth=1，最终外层 End 才 Apply 一次。从已经 Hook 的 setSelected/layoutSubviews 进入时，只是增加一层嵌套，最终仍由最外层 End 收尾；不能在 End 之外额外 Apply。

若一次直接复合调用没有其他嵌套：native 自身有2个几何方法；helper 每次 Apply 再调用2个。只有子 Hook、没有复合 Hook 时会出现 `2 + 3×2 = 8` 个几何方法调用；加复合 Hook 后为 `2 + 1×2 = 4`。这是结构推导，不是设备耗时或帧率测量。样式关闭或未创建 state 时，新增复合 Hook 应只转发 native 原实现，不生成 state/执行额外样式布局。

不建议为这项几何补丁再扩展数字/字符串/纯点业务 setter Hook：现有末尾 layoutBadgeView/layoutIcon 已提供最终收尾点，额外业务 Hook 会扩大维护面和曝光时序变化。

## 4. 性能审查口径

四个已 styled item 的稳定 bar Update 会先对每个旧 item 在 restore 后执行一对 native 方法，再在 apply 时执行一对，因而单次可增加8对、16个几何方法调用。复合 Hook 可以减少复合入口的重复 apply，但不会消除普通 bar Update 这项真实成本。不能把 host 速度或结构计数写成真实设备性能无变化。

本轮不应为节省调用重新引入跨几何阶段的缓存/省略恢复，或增加固定 delay/timer。优先保持同步 pair 的正确性，利用现有 bar/item depth 合并已嵌套的调用。关注是否新增图片加载/解码、数组重建、观察者或异步任务；原生 pair 本身没有图片 reload。设备验收应观察频繁消息、切 tab、持续布局和后台恢复时的 native 调用次数/主线程耗时及点击动画，而不制造额外业务消息来“证明”角标。

## 5. 生产 diff 审查结果

对上述哈希版本完成只读审查，未发现阻断项。逐项结果如下：

| 检查 | 实际实现与结论 |
| --- | --- |
| helper 深度配对 | `CSTabBarNativeAdapter.m:169–178` 的 state 已由 caller 创建/取得，先增 depth，native 两方法的已有 Begin/End 不会使它归零；@finally 减回原值，不存在从 helper 的 End 再次 Apply 的直接递归。 |
| 临时动画 | native pair 被 performWithoutAnimation 包住；未添加 removeAllAnimations 或改点击动画数据。原有动画 reconciliation 和 final frame helper 保持。 |
| Apply 采样 | `210–215` 顺序为 RestoreItem → native pair → 采样实际 image/badge frame，修正此前 resize 后采到不配对几何的问题。 |
| 实际偏移 | `243–247` 先写请求，读取实际 frame 决定是否约束，最后用 getter 计算 offset；不再记录 setter 前的请求差值。 |
| 位置/size/hidden | clamp 函数只写 frame.origin.x/y，原 frame.size 原样返回；未写 badge 对象、内容、hidden/alpha、shape、父视图或 clips。两次 CSSetFrame 调用中的第二次正常路径返回同 frame，CSSetFrame 内部相等判断使其不发生第二次实际赋值。 |
| 像素范围 | `179–198` 用同步 native frame 扩张 item.bounds 得到允许区间；只在某轴新增 overflow 时取向内 pixel 范围，另一轴保持实际 getter 值；无循环或第三次写入。区间异常在额外写入前回退 native origin。 |
| Restore 范围 | `294–303` 仍由 geometryApplied 保护；在旧 button state 恢复 frame 后，只有 b.item 存在关联 CSTabBarItemState 才调 native pair。新建/未样式化 item 不因此获得 state。 |
| 自定义图标尺寸语义 | 从 preferences 获取 custom 到写 icon/text frame 的原布局块与 2.1-6 基线逐字节一致（1413字节）；25×25 自定义图基数和现有 factor 没有调整。 |
| 复合 Hook | `TabBarStyleHooks.xm:67–69` 只有现有 Begin/%orig/End，无额外 Apply；原 %ctor 的 CSBackupWhenReady/初始化顺序不变。没有泛增业务 setter Hook。 |
| 非四 tab | 生产 diff 未改原 Update 的两个 count==4 前置条件、原 index 范围及 CSStop 路径，继续整体回退原生。 |
| surface/材质 | 生产 diff 未改绘制、层级、隐藏或动画；没有通过隐藏覆盖层处理 badge。 |
| 旧 host fixture | 老 TabBarNativeTests 的 layoutIcon/layoutBadgeView 仍为 no-op；helper 增减深度后不改变这两个 fixture 方法。新增 UIScreen 替身有默认 scale=3，补齐生产 clamp 所需接口。实际回归结果由主任务日志记录，本代理没有运行脚本。 |
| Hook 提取/初始化 allowlist | 新 extract-tabbar-badge-hooks.py 先验证现有四个 selector 的 Begin/%orig/End，再检测并验证新增复合 wrapper；没有把旧 selector 从检查移除。backup bootstrap 脚本仍对生成 Logos 的 readiness barrier/arm64语法/C链接作原有检查，没有为此 Hook 新增绕过。 |

### 5.1 有效数值前提

当前实现假设 UIKit 返回的 native/current badge frame、bounds 与 UIScreen.mainScreen.scale 为有限正常值；对合法 iOS screen，scale>=1，`MAX(1,scale)` 不改变 native 使用的格点。helper 中 `lower>upper` 的浮点异常已有 native origin 回退。该 clamp 不承担修复上游外部插件注入 NaN/Infinity frame 的职责：NaN origin 的大小比较为 false，不能靠本函数恢复它；上游 native frame 本身无效时也没有可证明的 native 参照。未发现本次修改制造这类非法值的可达路径，不据此要求增加泛用数值修复或扩大范围。

### 5.2 已报告给主任务的 native customIcon 边界

native `layoutIcon` 存在 customIconView 时，`0x104728944–0x104728a08` 选择这个 custom view 作为后续 setSize/top/bottom/centerX/mask 的对象，hidden imageView 不一定在此被重新居中。native `layoutBadgeView` 纯点分支仍读取 imageView。因而“同步调用 native pair”应表述为重走 native 的当前几何职责，不能无条件写成“每次都将 imageView 重新居中”。

这不构成当前 clamp 的静态阻断：它仍比较同一原生 badge 的实际 frame、约束插件新增 overflow，且无 native parent/shape/hidden 改写。但首版 TabBarBadgeTests 的 probeHasNativeCustomSize 表示 item.customSize，尚不等于真实 customIconView 的存在分支。已建议主任务补充这个 host 分支或明确未模拟；插件上传普通/选中图片路径与 native customIconView 是不同概念，不能混称都已覆盖。真实 native customIcon 的观感/曝光和第三方观察者仍需设备验证。

## 6. 同窄原生越界上限的位置约束

已评估主实现拟采用的最小约束，具体原生推导见同目录 `native-overflow-analysis.md`。该约束不把 native 已有右越界当成插件错误：以当前 bounds 下同步 native badge 的实际 frame N 为基准，逐边限制 styled frame 新增的 overflow。只调必要的 x/y，不改内容、size、hidden/alpha、父视图或裁剪。与无条件强行塞回 item 相比，这与保留原生观感的任务边界相符。

正确性依赖以下细节，待 diff 逐项核对：

1. 原生四边 budget 由同一 item.bounds、同一原生 badge 实际 frame 计算，不能用原始全宽 item 或预期 nativeWidth=28 的假定。
2. 原候选先经过真实 MMBadgeView setter，读实际 frame 后判断新增越界；正常结果不主动进行第二套舍入，保留 native 的 tie 行为。
3. 仅新增越界的轴取向内可行像素区间；另一轴保持首次 actual getter 值。scale 使用 native setter 相同的 UIScreen.mainScreen.scale，不能另选 window.screen 改变舍入格点。
4. 采用真实 badge 当前 size，不恢复历史 size。size 不变时，原生实际 origin 一定属于可行区间，所以数学上有解；badge 比 item 宽时也不应调整 badge size。
5. 额外写入最多一次。若计算格点区间受浮点尾差影响而出现异常，应在第二次写入前为必要轴选原生实际 origin；第二次 getter 若仍不满足，不能循环改位置或再写第三次而仍报告“最多两写”。此类异常应由测试/日志暴露。
6. 最终实际 offset 必须从最后 getter 得到，无论是否约束。容差仅为数值尾差，不能把整整一物理像素的新增越界当通过。

此数学约束能控制插件新增 overflow，并不证明真实屏幕中的遮挡和裁剪已全数排除；真机验收边界继续保留。正常路径一趟 badge frame 写入、异常轴最多增加一趟，没有 timer、固定 delay、轮询或资源加载。
