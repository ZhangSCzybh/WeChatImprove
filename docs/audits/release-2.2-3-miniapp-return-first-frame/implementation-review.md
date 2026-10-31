# 可见前闸门实现复审

审阅范围：`CSGroupListAdapter.h/.m` 与 `Hooks/SessionGroupHooks.xm` 相对 `faa294ff12ff17eab7336c0802693d968923154d` 的本轮改动。此复审没有修改生产源码或既有测试，结论为源码静态核对，不是设备运行证明。

- **三个真实入口：通过。** `WAAppDismissAnimateTransition -animateTransition:`、`WAAppTansitionController -onMiniTaskDismissalGestureWillBegin`、`-sheetDismissalTransitionWillBegin:` 均在已有 header 内，新增 hook 的类名、selector、参数数量与签名一致。每个 hook 都在 `%orig` 前同步执行统一前置校验；没有人为等待。
- **零次内容布局：通过源码路径核对。** `prepareForListVisibility` 遍历注册 adapter，`prepareForVisibility` 直接检查当前实际 visibleCells 的交付身份、账号、隐私规则，并在旧 native 内容/身份未知/投影未就绪时同步 shield 全部当前 cell。因此不要求 table layout 才能中性化已有内容。
- **gate 后非发布布局：通过。** associated hold 为真且 `publishing` 为假时 `ready` 不成立，沿原 ready-NO 分支，不能因“投影本身安全”就执行 `prepareForPublication` 恢复旧 native cell。inactive + privacy=true 也不能依靠有效投影绕过。
- **正常发布恢复：通过源码路径核对。** 前置 gate 通过原 requestRefresh 标记刷新；原 refresh 构建过滤投影与行几何，在 `publishing` 内允许已知策略的布局继续。原 publishProjection 路径交付完成后清除前置 hold，保留 sessionLayoutHeld 对后置策略不匹配的保护。没有新增直接 reloadData 调用。主线程同一发布栈中的 prepare/reload/layout 是否在真机合成中完全无中间屏幕帧，需要复录，未把源码顺序当作屏幕证明。
- **未知键兼容边界：复审发现后已补。** 直接在所有 ready 分支要求 NSNumber 会冲突于既有 2.2-2 测试“未知 hideSessions 不缓存、仍走旧全扫”的契约。本轮保持该既有契约；新可见 gate 把未知键视为不安全并 hold，在 hold 状态仅 `publishing && hideOption 为 NSNumber` 才准入，且 refresh 的完成分支在未知 hideSessions 时不清 hold。这样新可见边界不会被随后一次旧全扫放开；没有修改既有断言来迁就实现。真实 Snapshot 正常构造会规范化 profile 并补默认选项，未知键属于异常/测试场景。
- **显式导航 shortcut：通过。** inactive 且隐私激活/状态未知时不再直接进入原生布局；动作保留原 epoch/账号 guarded closure，进入原队列，并在隐私+inactive 时主动走现有 refresh，避免仅限制 shortcut 导致 useNativePresentation 因 inactive 早退、动作永远滞留。现有调用者是显式会话导航，不把此处宣称为已实测的小程序根因。
- **2.2-2 缓存：未重写键/扫描逻辑。** 新条件只增加可见 hold 与 inactive 防线，稳定 active 投影的缓存键、扫描路径、布局后复检与成功动作保留；次数是否保持 25 次布局/32 行一次扫描，以本轮实际 cache 测试日志为准。

## 仍需真机确认

1. 录屏所在微信版本是否实际命中上述 animator/gesture/sheet 中至少一个入口，以及入口先于第一可见帧的时序。
2. 自然返回时的 isActive、VC appear/disappear 序列、table 内容布局次数、旧 cell 身份、原生截图合成与真实屏幕中间帧。
3. mixed 生命周期：若覆盖期间曾收到 disappear，而返回没有 appear，presentationSuspended 仍可能阻止后续 refresh；此时隐私保持中性态安全，但恢复要等其它既有唤醒。两边都不走标准回调的容器路径不触发这个条件。没有为未知设备路径改写受保护 suspended 定义。
4. 中性态保留 contentSize、offset 与 table 手势属性的代码意图，不等于真实触摸链路和滚动已测。

除上述明确限制外，未发现额外确定的隐私放行缺口；最终回归、受保护块哈希与构建由主任务汇总。
