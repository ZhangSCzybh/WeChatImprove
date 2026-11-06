# 主列表 section 标题估算边界回归

生产修复仅为 `Controllers/CSCustomViewController.m` 的 `setupUI` 增加 `self.tableView.estimatedSectionHeaderHeight = 0;`（加两行注释，共 +3/−0）。保留所有返回刷新、授权、隐私和手势行为；`CSSettingsTableViewController.m` 未修改。

## 证据与边界

主列表的头像、昵称、微信号在 `tableHeaderView` 内，该 UIView 只在 `setupHeaderView` 以 150pt 固定 frame 创建，再由 `setupUI` 一次赋给 `tableHeaderView`。主列表不是 `CSSettingsTableViewController` 子类。主列表 `viewWillAppear:` 和 `viewDidAppear:` 均会 `setupData` 再 `reloadData`，但原 `setupUI` 没有关闭 section 标题估算。

Apple SDK 的 `UITableView.h:364` 指定 `sectionHeaderHeight` 默认 `UITableViewAutomaticDimension`，`:367` 指定 `estimatedSectionHeaderHeight` 默认 `UITableViewAutomaticDimension`，并明确 `set to 0 to disable`。完整文件路径、SHA256 和原始注释在 `RESULT.json.sdk_contract` 留档。因此原流程允许 reload 后尚未真实测量的 section 标题估算高度成为首卡位置的一部分，随后再被实际高度替换；这可以改变首卡顶边而不动 tableHeaderView 内的微信号。

这份测试是执行生产方法的 **公开契约主机 double**：不执行真实 UIKit，不反编译 UIKit 私有测量实现，不声称获得了该设备的真实估算高度。实际高度取 24/37/52pt，估算误差取 −19/−5/+7/+23pt，都是独立的对抗输入，不用录屏的任何像素差去拟合。它验证的是生产代码允许/禁止估算分支这一可测契约；真机根因、动画具体时序和真实默认高度仍需要设备验证。视频帧复测请以本版本独立录屏报告为准。

## 红绿结果

先于生产修改执行冻结的 2.2-17：

```text
python3 docs/audits/release-2.2-18-settings-return-header-gap/header-gap-validation/run-validation.py --source docs/audits/release-2.2-18-settings-return-header-gap/baseline-2.2-17 --label red-final-2.2-17 --expect-red
Header gap lifecycle: 37152 checks, 3456 failures, 432 scenarios, 6048 geometry samples, 12 menu labels
```

仅添加生产 setter 后，使用完全相同的 fixture 和 runner：

```text
python3 docs/audits/release-2.2-18-settings-return-header-gap/header-gap-validation/run-validation.py --label green-2.2-18
Header gap lifecycle: 37152 checks, 0 failures, 432 scenarios, 6048 geometry samples, 12 menu labels
```

`red-final-2.2-17/` 和 `green-2.2-18/` 各保留生产全文、逐字抽取的方法、fixture、runner、编译命令、编译日志、运行日志、6048 个几何阶段样本及 SHA256 provenance。源文件在每次测试前后哈希相同。fixture SHA256 为 `6df06837d82d1630811f0d860e4c406ab56149f6066bad093ffc500a54396db2`，runner SHA256 为 `59f0179dadd1d866d44ab3ff86c543a93e1d4a3f9171f8b90da0a3482e95f5d7`，红绿完全一致。`summarize.py` 独立校验快照并生成 `RESULT.json`。

每个场景采样 14 个阶段：进入前、push 首帧、push 中途、pop willAppear、pop 首个可见帧、测量后仍在转场、didAppear、转场结束等待测量、最终态、交互返回中途、取消、取消后再次返回首帧、再次 didAppear、再次最终态。采集 `header_height`、`section_title_height`、`first_row_y`、`wxid_y`、`contentInset.top`、`adjustedContentInset.top`、`contentOffset.y`、estimate 状态及 reload/data 次数。

旧版本的 8 个中间阶段各有 432 个 gap 失败，合计 3456；两个最终态各 432 个原本就全部通过。只测最终值会把旧代码判为通过。新代码所有阶段 gap 都与各自进入前的基线相同。旧、新的 header frame、微信号坐标、滚动位置、内容 inset 和 adjusted inset 均没有发生改写。push 两个阶段旧、新均通过。

## 路径覆盖的确切含义

从真实菜单分支提取并核对以下十个子页：顶栏信息、头像设置、触摸轨迹、界面简化、界面净化、气泡样式、列表圆角、底栏样式、布局设置、附件布局；另外核对密友设置的普通入口和五击快捷入口，共 12 个标签。每个标签运行同一套生产父列表生命周期，涵盖三种实际标题高度、四种正反方向估算误差、三种滚动/回弹位置，共 432 个场景。

这是 **共享父列表逻辑的主机执行覆盖**。它没有执行上述子页自身、UIKit 导航手势、真实子页的变更通知或实际账号；不能列为 12 条真机返回路径实测。附件只提供一个原有头像设置返回路径的设备录屏。本修复后所有设备返回路径、push 首帧、动画观感及系统版本组合均未验证。

`red-2.2-17/` 是菜单契约断言准备期间留下的未完成运行目录，没有可执行红测试结果；`red-2.2-17-run/` 是补齐快照字段前的首次完整红运行。正式红绿证据使用名称带 `red-final` 和 `green` 的两个目录；早期目录原样保留，不覆盖。
