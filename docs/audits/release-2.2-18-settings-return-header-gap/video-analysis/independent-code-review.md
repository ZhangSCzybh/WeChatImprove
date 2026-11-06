# 独立检查：单 setter 修复与红绿契约

审查范围是冻结 2.2-17 与当前 `Controllers/CSCustomViewController.m` 的实际 diff、真实生产生命周期方法、Apple SDK 属性契约、同一 fixture 的红绿源快照和全部阶段几何 trace。没有修改生产代码或测试断言。

## 生产修改检查

该文件只有一处 diff：`setupUI` 创建 inset-grouped UITableView 后，增加两行解释性注释及 `self.tableView.estimatedSectionHeaderHeight = 0;`（当前 919–921 行）。共 +3/−0。该值依 SDK 明确表示**禁用 section header 高度估算**，不表示将实际 section header 高度设为0；原默认 `sectionHeaderHeight=UITableViewAutomaticDimension` 和真实标题内容仍保留。

原 `viewWillAppear:` 第151行与 `viewDidAppear:` 第175行的 `reloadData` 都保留，重建菜单、换账号及入口保护路径没有被删。`tableHeaderView` 赋值、头像、长按和五击逻辑、contentInset、contentOffset、布局和转场回调均未改。没有关闭 Core Animation、延迟设值或像素差硬编码。section 数量有限（当前五个），禁用估算会要求真实 section 标题测量，不引入另一套测量值。

Apple SDK `UITableView.h` 的原文及 SHA256 已在上一级 `header-gap-validation/RESULT.json.sdk_contract` 留存。属性声明 `estimatedSectionHeaderHeight` 的注释为 `default is UITableViewAutomaticDimension, set to 0 to disable`。代码修改正确作用在这个契约分支上，而不是把误差从视频中拟合成 padding。

## 独立核对红绿快照

红测试 `ProductionSource.m` 与冻结 2.2-17 全文逐字节一致；绿测试 `ProductionSource.m` 与当前全文逐字节一致。其 SHA256 分别为：

```text
2.2-17 6f602715e9cf5863798accf429f0d02369d33c4214a22aca0d7b015c16519cd7
2.2-18 933c2af2174ee391c916a3f43e6c798147cb54cb6293515b9e1119210c2d26f7
```

红绿 `Fixture.m`、`Runner.py`、`Routes.h` 全部逐字节相同。fixture 与 runner SHA256 分别为 `6df06837d82d1630811f0d860e4c406ab56149f6066bad093ffc500a54396db2` 和 `59f0179dadd1d866d44ab3ff86c543a93e1d4a3f9171f8b90da0a3482e95f5d7`。

独立重新解析两套 `geometry-trace.json`，每套6048个样本，432场景，每场景14阶段：

| 解析项 | 冻结 2.2-17 | 当前 2.2-18 |
|---|---:|---:|
| gap 与进入前基线不同的中间样本 | 3456 | 0 |
| 两次最终态 gap 等于基线的样本 | 864 | 864 |
| header、微信号、scroll/inset 与基线相同的样本 | 6048 | 6048 |

旧版本失败分布在8个阶段，每阶段432个，包括 `pop-first-visible-frame`、`pop-did-appear`、转场结束但尚未测量的阶段、交互返回取消及再次返回。旧版本的最终态本来就全部通过，故该 fixture 不是只比较终值的漏检测试。独立解析结果在 `independent-fixture-review.json`。

## 证据强度与限制

这个 fixture 执行逐字抽取的生产 `setupUI/viewWillAppear/viewDidAppear/viewWillDisappear`；UIKit 对象由公开契约 double 替代，对抗误差同时有正负方向，未使用视频的23/24px去拟合值。它可以证明：旧生产代码允许 reload 后估算值进入中间布局，新 setter 关闭这一分支；不必去删返回刷新或修改保护状态。

它**不能证明该设备的 UIKit 正是通过这个分支产生录屏的24px变化**。double 的 reload/estimate/measure 调度是测试输入，非真机追踪，也不是 UIKit 逆向结果。432个场景中的12个菜单名是共享父列表生命周期的覆盖标签，不代表执行过12个子控制器和导航转场。字幕/报告应使用“已测得契约分支修正；设备根因时序和修复后第一帧未验证”的准确表述，不应声称已测得该设备真实估算高度或确认24px来源。

视频独立分析仅支持 tableHeaderView 内文字不动、其下 section 标题及列表块相对上移24px后恢复。该症状与估算高度替换相符，但也不能排除其他 UIKit 几何过程；可见子视图位置稳定不等于已测得容器 frame。所有设备返回路径与修复后渲染仍需实际设备补证。

审查未发现需阻止候选出包的代码正确性问题；上述证据边界应保留在主报告与交付回复中。
