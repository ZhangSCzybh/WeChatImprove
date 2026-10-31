# 2.2-4 方案 A 前置核查：停止实施，未出包

基线：`ad031947f858dc55a3f09792964d47c707c91dc4`（2.2-3）。已阅读 CPU 分析报告第 3.3 节与第 6 节方案 A。本次只核查实施条件，未修改源码、Tests、Hooks、版本、README 或发布说明，未构建、未打包、未提交。本目录是本轮唯一新增内容；上轮留在工作树中的审计修改、素材及 Finder 文件保持原状。

## 停止原因

1. **没有找到能够证明覆盖全部相关主题变化的可靠失效渠道。** 找到了真实的主题加载、深色、字号和 context 变更方法，但只有 class dump 声明，没有完整实现/设备事件序列可证明 `cell_headimg_left_margin` 和 `cell_headimg_size` 的每次变化必经这些入口。不能据此把未知主题视为稳定。本轮依照用户“设计上必须先回答的问题”第 2 条停止，不直接实施未知主题原生摘要复用，也不自行替换为外观退化的 fallback 出包。
2. **新目标与当前实际执行的旧断言冲突。** `Tests/FoldedEntryVisualTests.h:56/:59/:61/:65` 明确要求未知/异常主题时每次原生 quote。新要求稳定 600 次应为 quote/remove=0/0，不能同时保留这些旧期望并让十二套全部通过。本轮没有修改、跳过旧断言，或改变 fixture 来回避冲突。

## 主题失效渠道的实际证据

下列位置均对着本次 2.2-3 基线；“存在 selector”与“能证明完整失效覆盖”分开陈述。

| 类与 selector / 属性 | 文件:行 | 已知范围与不足 |
| --- | --- | --- |
| MMThemeManager `-reloadThemeResource` | HeadersFile/MMThemeManager.h:63 | 真实资源重载方法；未证明每次主题规则变化均经此入口 |
| MMThemeManager `-reloadCssForMultiTaskingIfNeed` | 同上:30 | 多任务 CSS 重载入口；不是通用失效通知证明 |
| MMThemeManager `-loadCSSFromPath:IntoRuleSetList:` | 同上:65 | CSS 载入方法；缺少所有调用路径实现 |
| MMThemeManager `-loadRuleSets` / `-loadSimpleRuleSets` | 同上:66、67 | 规则载入方法；不能排除规则载入后的就地修改 |
| MMThemeManager `currentTheme` / `ruleSetList` 可写属性 | 同上:29、26 | 可观察对象替换，不足以检测对象内部原地变动 |
| MMRuleSetList `ruleSets` 可写 NSMutableDictionary | HeadersFile/MMRuleSetList.h:19 | 规则集合是可变对象，稳定身份不代表内容未变 |
| MMRuleSetList `-addOrMergeRuleSet:forSelector:` | 同上:31 | 直接规则合并入口，不能只监听 manager 的 reload |
| MMRuleSetList `-removeRuleSetForKey:` / `-setRuleSet:forKey:` | 同上:34、35 | 存在其它规则更新入口，完整实际调用关系未知 |
| MMContext `+setContext:atIndex:` / `+pop:` / `+push:` | HeadersFile/MMContext.h:41、42、43 | context 可替换；不能证明不替换时 CSS 规则未变 |
| MMContext `-setService:for:` / `-removeService:` | 同上:94、95 | service 可替换；实例不变时的内部状态没有完整版本证明 |
| DarkModeManager `-mm_traitCollectionDidChange:` / `-changeDarkModeConfigType:` | HeadersFile/DarkModeManager.h:18、19 | 深色处理入口；不能代替全部头像 CSS 规则变化 |
| MMDarkModeObserver `+observerWithCallback:` / `-fireDarkModeChange:` | HeadersFile/MMDarkModeObserver.h:16、19 | 真实暗色观察 API，覆盖范围不等同所有主题值 |
| UIView(DarkMode) `-addDarkModeObserver:forKey:fireImmediately:` | HeadersFile/UIView-DarkMode.h:15 | view 暗色观察 API，不证明 margin/size 规则失效 |
| UITraitEnvironment `-traitCollectionDidChange:` | HeadersFile/UITraitEnvironment-Protocol.h:12 | trait 变化接口；不可观测主题规则可以独立于 trait |
| IMMFontMgrExt `-onFontSizeChange` | HeadersFile/IMMFontMgrExt-Protocol.h:11 | 微信字体变化扩展接口；没有 CSS 总失效保证 |
| UIFont `+setAppFontSize:` | HeadersFile/UIFont-PreHot.h:21 | 微信字体设置入口；不等同头像主题规则变更 |

未找到可在当前证据范围内证明完整覆盖上述两个 CSS 值的主题变更通知。这里没有断言微信内部绝不存在这种机制，也没有把某个方法名直接当成已验证的总通知。

## 为什么当前重建不能直接删除

`Controllers/CSCloseFriendSessionPresentation.m:97` 的 `CSFoldedNativeRenderState` 在 context/service/任一主题值未知时返回 nil；`:138–140` 的复用条件因此失败，`:153/:155` 再委托原生 remove/quote。这样做成本高，但在无法确认原生主题输入是否变化时，仍由原生方法重新计算当前前缀几何与外观。

即使当前 item/message/prefix 的文本、frame、font、color、trait 全相等，也只证明**已经渲染的结果**没有变，不能证明尚未应用到这些视图的原生 CSS margin/size 没有变。直接给未知 token 固定哨兵，或只 hook 几个 reload/setter，再永远复用，都缺少外观正确性证明。

若后续继续设计稳定键，还需补齐当前键缺少的 item 身份、message 的直接 superview 身份、prefix 的 traitCollection（当前 `:119` 只有 item/message 两个 trait）。这些字段是必要补充，仍不能替代主题失效证据。每次账号/策略/摘要身份前后校验（`:200–202`、`:228–233`）以及保活/hidden 语义必须保留；本轮没有改动它们。

## 旧测试语义冲突

这些断言由 `Tests/CloseFriendSessionPresentationTests.m:131` include，`Tests/verify-close-friend-session.sh:53` 编译执行，属于用户要求的十二套之一，并非废弃文件。

| 旧断言位置 | 当前期望 | 与新目标的冲突 |
| --- | --- | --- |
| Tests/FoldedEntryVisualTests.h:56 | 主题不可读，两次回调 quote +2 | 稳定未知输入仍必须每次重建 |
| 同上:59 | getter ABI 不符，两次回调 quote +2，且不得调用错误 ABI | 不能把异常路径静默变成每次零重建后仍满足旧期望 |
| 同上:61 | getter 抛异常，一次回调 quote +1，仍呈现原生安全摘要 | 改用中性摘要也会改变该外观契约 |
| 同上:65 | 主题不可读，12 次回调 quote/remove +12/+12 | 与稳定未知输入零重建直接相反 |

既有 `:42` 同时断言可读主题稳定输入零重建，`:47` 断言主题数组就地变化必须重建，这两条应继续保留。若实施新语义，必须明确允许对上列冲突的旧契约做有范围的更新；不能通过改 fixture、跳过 include 或区分“12 次/600 次”伪造全绿。

## 真机可读性与 600 次计数

**真机 `MMContext currentContext`、`getService:` 与两个主题属性是否可读：未验证。** 本轮没有设备连接、Instruments 或运行时读取数据，也没有人为制造不可读场景来宣称用户设备有收益。

下表引用用户已给出的主机探针事实及原分析报告的计数，不是本轮新增实测。由于本轮停止实施，没有“修复后”的计数或收益。

| 预热后 600 次主机输入 | 原生 layout | quote | remove | theme service 读取 |
| --- | ---: | ---: | ---: | ---: |
| scoped 折叠入口，主题不可读 | 600 | 600 | 600 | 600 |
| scoped 折叠入口，主题可读且稳定 | 600 | 0 | 0 | 600 |
| 普通非 scoped 行 | 600 | 0 | 0 | 0 |

如果用户设备主题本来可读且输入稳定，当前 quote/remove 已是 0/0，本方案在该分支的可消除重复重建为 **0**。没有整机 CPU 降幅结论。

## 更安全的替代与外观代价

未知主题时直接选用现有安全中性 fallback、不再调用原生 quote，是不依赖未知 CSS 规则的替代方向；每次仍执行现有隐私检查。此方向本轮未实施，不能把它写成已交付效果。

现有 fallback 在 `CSCloseFriendSessionPresentation.m:203–205` 把标题与第二行都设为“折叠的聊天”，`:233–234` 在原生渲染不可用时释放旧 pair 并显示 summaryLabel。`:57–69` 借用原生标签垂直指标、字体、颜色，但横向位置/宽度走 fallback，单行左对齐、尾部截断、不缩放。

用户能明显看到：原来的发送者前缀及分组内安全消息摘要不再显示，第二行成为通用文案；原生前缀分段与宽度规则也不再保留。不能称为原生外观等价。此选择需要明确接受信息退化，并处理上列旧断言冲突；本轮不自行改变产品语义。

另一条路径是保持原生外观，先在实际设备上取两类最小证据：稳定驻留期间 context/service/margin/size 的成功率、quote/remove 次数；深浅色、微信字号、可能的 CSS/头像规则变化时值与候选回调的先后序列。使用工作树外运行时工具、仅汇总内存计数，不逐回调写日志，也不把插桩 CPU 当应用基线。仍需证明相关规则失效不被遗漏，不能只测一次深色切换就宣称全部覆盖。

## 本轮变更、验证与未执行项

- 源码、Hooks、Tests、版本与发布说明：**0 个文件、0 行修改**；仍为 2.2-3。
- 用户指定九项受保护正文：与 ad031947 逐字节相同，完整基线/当前 SHA256 见 `protected-blocks-comparison.json`。
- 检视的 22 个输入文件与基线逐字节相同，见 `source-provenance.json`。
- 本轮只新增此审计目录；历史 packages 和主树 .theos 的 1,345 个文件前后哈希核对见 `preservation-result.json`。
- 未写新测试，未运行红/绿或十二套回归：设计前置条件未满足且已发现旧断言冲突，按用户要求停止在改动之前。未把过往通过数挪作本轮结果。
- 未构建、未打包、未创建 `packages/2.2-4-folded-summary-idempotent/`，没有本轮 deb、symbols 或 SHA256SUMS，未执行 make clean。
- 真机主题可读性、自然回调覆盖、外观、锁定/解锁与返回动画均未验证。

继续前需要明确两点：选择“保留原生外观、先补设备和完整失效证据”，还是“接受未知主题时通用中性摘要”；以及是否允许只更新上列四项与新语义直接冲突的旧测试契约，其余既有断言保持不变。
