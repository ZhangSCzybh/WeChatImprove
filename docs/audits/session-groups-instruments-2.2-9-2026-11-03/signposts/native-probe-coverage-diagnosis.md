# 原生分组探针缺失的源码候选原因

本说明仅作只读源码分析。它没有读取真机对象属性、注入脚本、修改生产代码、安装或重启微信，不能确认为真机当前已进入兼容模式。当前正式结论仍是：**每轮原生模型耗时、原生发布及已验证主表刷新计数未取得**。

## 已有运行证据

两份烟测及不合格静置动作样本均取得 `com.wechatimprove.performance / SessionGroups` 的 `TabRecordsUpdateAttempt` 和 `UnknownChangeHint`，动作样本另有 `KnownChangeHint`。XML 的引用、数值载荷、跨表去重和区间配对已核对。没有 `ModelFull/Delta/Selection`、`CoordinatorApply`、`AdapterRefreshAttempt`、`AdapterPublication`、`MainTableTargetVerified`。用户确认实际点了分组标签，选中项和列表内容改变。

`smoke-system` 的目标进程 Apple signpost 在 t6.168–56.658 持续存在，并非所有 signpost 通道只在录制末尾生效；有操作的静置样本也在 t7.780 取得了自有事件。事件存在不能证明没有丢事件，也不能证明每个 hook 都安装并持续被调用。

## 最能完整解释现象的源码候选：之前已完成兼容路径切换

1. `Hooks/SessionGroupPerformanceObservation.xm:74` 在进入原 `performChangeForUserNames:kind:original:` **之前**发出 Known/Unknown 提示；原方法在 `CSGroupNativeSessionCoordinator.m:213` 判断 `compatibilityFallback` 后只执行宿主原调用。因此，提示事件仍出现，与协调器已经不再应用原生模型完全相容。
2. `CSGroupNativeSessionCoordinator.m:279` 在安全归还完整宿主来源后设置 `compatibilityFallback=YES`。当前源码只有这一处赋值，没有重新设置为 NO 的路径；它是 singleton 的进程内状态。若发生在录制前，本次 trace 不会包含早先的回退过程。
3. 回退后 `refreshFromPreferences` (`:823`)、`performNativeRebuildForManager` (`:609`) 和 `performNativeMutationForManager` (`:670`) 均在原生候选应用之前退出或直接执行宿主原调用。
4. Adapter 初次绑定以 `!folded && !compatibilityFallback` 决定 `usesNativeSessionModel` (`CSGroupListAdapter.m:196`)；已绑定 Adapter 也可在 `adoptCompatibilityModelIfNeeded` (`:932`) 把它设置为 NO (`:936`)。其 `refresh` 在 `:1183` 仅对 native 标志为 YES 的实例调用被观察的 `refreshNativeSessionModel`，否则走仍可提供分组列表的投影路径。
5. 观测模块只包装 `publishNativeProjection`，没有包装兼容路径的整个 `refresh` / `publishProjection`。所以兼容列表仍然能切组，Tab 更新与来源提示仍有事件，而本轮请求的 native 模型/发布/主表 probes 均可缺失。

这条路径与已见事件组合吻合，**但当前 trace 不包含 compatibilityFallback 或 usesNativeSessionModel 的状态事件，因此不能提升为真机已证实的原因**。

可能触发这条路径的源码条件：

- `CSNativeManagerSupported` (`CSGroupNativeSessionCoordinator.m:18`) 严格验证 MainSessionMgr 及原生数组 getter/setter、totalTopSessionCount 的 `q@:` / setter `v@:q`、rebuild 的 `v@:` ABI。`refreshFromPreferences:844` 或 rebuild `:622` 验证不通过可请求兼容切换。
- 完整来源的数组类型、totalTopSessionCount、可显示元数据无法安全建立，会设置 `captureCompatibilityFailure` (`:375` 起)，后续安全切换；仅来源仍在加载、两个分区都 nil 的情况不等于确认不兼容。
- 完整模型结果无效时 `applyBaselineCandidate` 可请求切换 (`:576`)。
- Adapter 的持续原生展示元数据失败在有界重试达到 3 次时可请求切换 (`CSGroupListAdapter.m:984`)。

当前未读取上述任一真机私有值，不能具体判定是哪一个接口、字段或数据触发。

## 其他候选与解释边界

- **其他非 native Adapter。** 折叠聊天页按源码明确不使用 native 主模型 (`CSGroupListAdapter.m:196`)。用户已经确认当前为聊天列表，故不能直接归因到误进折叠页；仅凭现有探针也无法读取 Adapter 所属 owner。
- **提示来自无需主列表应用的宿主调用。** NativeSessionGroupHooks 在注册宿主入口发送提示，`performNativeMutationForManager` 还会检查主线程、已注册 manager 和重入 depth。提示本身没有 manager 身份，因此提示数量不代表获准主表变更次数，也不是消息条数。这只能解释提示与应用不一一对应，不能单独证明实际切组为何没有 native 刷新入口。
- **个别 hook 或已加载产物未独立核验。** 部分同组 hook 发出事件证明观察模块至少部分工作，不能替代每个 hook 的实际派发覆盖和已加载 dylib UUID 验证。当前没有证据确认其他插件覆盖了方法，也没有证据将所有缺失归为 hook 失败；保留未知。

`selectIndex:` (`CSGroupListAdapter.m:1943`) 成功选择会调用 `refresh` (`:1955`)。若此时 Adapter 确实为 native，观测入口 `AdapterRefreshAttempt` 在原方法任何早退之前开始 (`Hooks/SessionGroupPerformanceObservation.xm:83`)。同理，缓存命中仍经过被包装的 `applyBaselineCandidate` 入口。**不能用“缓存命中很快”把整条入口探针缺失解释成零重算、零发布或优化成功。**

Tab 选中状态由 `selectTabAtIndex` 直接更新按钮与指示器，`updateTabs:` 的记录对象可以始终未变；所以 Tab 更新 outcome=Unchanged 不否定真实点选。布局、记录重建、有效分组切换和主表发布分别处理。

本轮保持已安装的 2.2-9 观测包和用户数据不变，不为诊断增加探针或重装。对外报告 CPU/帧数据时继续注明整微信进程及帧表范围；内部计算与刷新指标列“未取得”。
