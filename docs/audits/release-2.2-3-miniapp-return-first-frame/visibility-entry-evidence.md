# 2.2-2 可见前入口静态核对

基线：`faa294ff12ff17eab7336c0802693d968923154d`。本文件全部源码行号均指该提交，不指后续工作树。只读调查，未修改生产源码、头文件或测试，未构建、未打包。

## 对用户五个根因方向逐条结论

1. **旧内容被父容器揭露：与证据一致，不能据此声称 cell 对象身份已实测。** 用户提供的帧 168 与帧 175 第 4 行身份/消息不同，能证明屏幕显示的不是同一份稳定内容。基线仅在 `MainFrameTableView -layoutSubviews` 调用布局闸门（`Hooks/SessionGroupHooks.xm:364–369`）；没有小程序 dismissal / gesture / animator 入口。只重新显露已有图层而没有 table 内容布局时，已有内容不会经过闸门。UIView/cell 身份是否相同、原生是否使用截图参与合成，须真机验证。
2. **`!isActive && !privacy` 早退不是 privacy=true 的无条件放行。** `Controllers/CSGroupListAdapter.m:649–659` 已明确只有两者都满足才原样布局；只要有效快照给出 privacy=true，就进入后面的 ready/scan/hold 链。`isActive` 仅返回 `self.projecting`（`:507–509`），不是可见性状态。受保护的 `setPresentationSuspended:`（`:196–208`）不修改 projecting，因而不能把“小程序覆盖”直接等同于 isActive=NO。`:879–883` 的无隐私/搜索/账号不可用分支、`:917/:924` 的投影有效性判断、`:530` 的 detach 才能将它置 NO。自然小程序路径上的真实 isActive 值未测。
3. **`performInNativePresentation:` 的 inactive shortcut 存在，但不是自动小程序返回入口。** `:1150–1172` 负责显式原生坐标导航；`:1154` 的确在 inactive 时直接进入 native scope。全仓实际调用者仅 `Hooks/SessionGroupHooks.xm:106/117/118/119`，对应按用户名选会话与下一个/上一个会话，调用前都要求 `a.isActive`，不是小程序关闭回调。该 shortcut 在重入或调用期间状态变化时仍有防御收紧价值，不能定性为录屏根因。
4. **零次内容布局的遗漏成立于静态可达性；帧 133–168 的实际调用次数未验证。** 除 `MainFrameTableView -layoutSubviews` 外，基线没有其它 `performSessionListLayout:` 调用者。`NewMainFrameViewController -viewWillAppear:`（Hooks `:62–66`）只恢复 suspended、执行原生、attach；小程序是否触发这个 VC 的 appear 没有设备计数。纯父容器动画/重新可见不要求该 UITableView 重新 layout。
5. **事后 refresh 可以解释最终隐藏，实际刷新时间未采样。** 源码 `refresh` 在 suspended 且无显式导航动作时延后（Adapter `:839–841`），而 attach 在 dirty 等条件满足后触发刷新（`:190–191`）。真正切换行集合发生于 `:905–924`，随后 `publishProjection:`（`:940`），符合帧 175 才换一份内容。录屏只能证明屏幕最终换内容，不能单独证明哪次 refresh 或其调用堆栈。

## 已存在、可用于前置闸门的类/方法

下列类/方法不是新增猜想：均来自当前基线已有的 `HeadersFile/` class dump。

| 入口 | 基线位置 | 前置的理由与限制 |
| --- | --- | --- |
| `WAAppDismissAnimateTransition -animateTransition:` | `HeadersFile/WAAppDismissAnimateTransition.h:28` | UIKit animator 开始提交原生转场前的同步插入口，`%orig` 之前处理底下已有 cell，不依赖 table 布局。该类还有 `isInteracting` 属性 `:26`，但没有其实现，不能据此声称所有交互必走它。 |
| `WAAppTansitionController -onMiniTaskDismissalGestureWillBegin` | `HeadersFile/WAAppTansitionController.h:117` | 方法语义明确是小程序 dismissal 手势即将开始，可在原始手势处理前处理现存表格。补 animator 未必触发或交互已开始的路径。真实顺序需设备计数。 |
| `WAAppTansitionController -sheetDismissalTransitionWillBegin:` | 同上 `:52` | sheet dismissal 将开始，补半屏/容器 dismissal。`sheetPresentation...dismissalTransitionDidEnd:` 是结束入口，不能代替此入口。 |
| `MiniTaskDismissAnimatedTransitioning -animateTransition:` | `HeadersFile/MiniTaskDismissAnimatedTransitioning.h:19` | 另一份已有最小化任务 animator；是否本段录屏实际使用未知，可作最低成本 animator 补口。该类包含 snapshotView，不能假定原生过渡完全没有快照。 |
| `NewMainFrameViewController -viewWillAppear:` | `HeadersFile/NewMainFrameViewController.h:260`，已有 hook `Hooks/SessionGroupHooks.xm:62` | 标准 appear 的同步可见前入口；不能单独覆盖“原列表 VC 无 appear”的容器揭露。 |

额外的真实入口：`WAAppTask -dismissTaskPage:completion:`（header `:888`）、`-onMinimizeInteractiveTransitionBegin:panGesture:`（`:1140`）、`-navigationController:navigationViewWillDisappear:`（`:320`）。它们说明存在非标准 presentation 路径，但本次无真实调用序列，不建议无依据大范围铺 hook。

历史原生类表也包含 `WAAppTansitionController`、`WAAppDismissAnimateTransition`、`MiniTaskDismissAnimatedTransitioning`：`docs/audits/payment-notifications-1.8-21/native/classes.json:40954/:40956/:43500`。这仅加强类存在证据，不代表 2026-10-31 真机已命中这些 hook。

`WAAppTansitionController.h` 同时声明 `interactionControllerForDismissal:`（`:92`）与 `animationControllerForDismissedController:`（`:119`），符合交互控制与 animator 分离。当前材料没有函数体，无法从 header 证明 animateTransition 的真实调用顺序或覆盖率。因此将 animator、手势 willBegin、sheet willBegin 并列前置是覆盖不同已存在入口，而不是编造某条已经观测到的调用链。

## 最小实现建议及边界

在以上受支持的前置回调 `%orig` 之前，统一调用 adapter 的可见前校验：遍历当前实际 cell，验证交付身份、账号/epoch/策略与投影；已验证安全的内容可以保留，不可验证则 fail-closed 中性化，不能仅相信投影安全就把已有 native cell 当安全。之后由现有 refresh 恢复过滤后的内容和布局。

新增前置方法应同步完成 shield/hold，不等待 dispatch_async、更不能等待固定时长。必须保留 ready-NO 分支与 2.2-2 的稳定投影证明语义。尤其要防止后续一次成功的布局闸门调用 `prepareForPublication` 把先前已隐藏、但尚未按过滤集合重建的旧 cell 恢复出来；需要测试“前置 shield 后 layout / refresh”的完整序列。

`performInNativePresentation:` 若收紧，仅增加 `!CSGroupPrivacyActive()` 到 inactive native shortcut 还不够：之后 `useNativePresentation`（`:1147`）会因 inactive 早退，使动作滞留。需要让 privacy+inactive 的显式动作进入现有 nativeActions 队列并同步 refresh（原 `:905–917` 在 privacy 时仍建过滤 All），然后走原 `:957–959` 的动作 drain。现有 guarded action 仍要保留 epoch/账号条件。这是防御边界，不应宣称是已确认的小程序漏口。

## 未验证项

- 本段录屏所在微信版本实际采用哪一个 dismissal animator、交互 callback、VC appear 序列，以及每个回调相对帧 133 的时间。
- 帧 133–168 table 内容 layout 的真实次数、isActive 的真实值、原生 cell/UIView 身份、原生是否合成已有截图。
- 新前置入口能否先于该设备第一可见帧运行，及真实触摸/滚动行为。
- 本次结论属于源码静态核对与用户提供屏幕事实；不含 Instruments、真机插桩或设备运行计数。
